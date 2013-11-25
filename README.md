Ruby Bot Game : RUBOTGAME
=========================
inspired by robotgame.org

Concept:
Each player writes a class describing a bot, and submits it. On the server the bots play against each other on a simple map, and get ELO raiting.

Steps:
 # build the kit
 # build the rg module
 # built test robot
 # built the server
 # built any other tools

Game Rules:
-----------
* In robot game, you write programs to control robots that fight for you. The game is played on a 19x19 grid.
* Dark squares represent where you can't walk. As you can see, this effectively creates a circle arena where your robots fight.
* The green squares represent spawn points. Every 10 turns, a batch of 5 robots will spawn at random spawn points for each player, and any robot still standing on a spawn point will die.
* Each robot starts out with 50 HP.
* Robots can generally act (move, attack, etc.) on the squares up, left, right, and down — its adjacent squares.
* Each turn, every robot can take one action:
  - Move into an adjacent square. If there's already a robot there, or if another robot tries to move into the same square, both robots will lose 5 HP as collision damage, and the move(s) won't happen. On the other hand, if a robot tries to move into a square with a robot already there, but that robot successfully moves out the same turn, both robots will move. Four robots in a square, all moving clockwise, will move, as will any number of robots that move in a circle.
  - Attack an adjacent square. If there is a robot in that square at the end of the turn — i.e. a robot stayed there or successfully moved into that square—that robot will lose between 8 and 10 HP as attack damage.
  - Suicide. The robot will die, dealing 15 to any robots in adjacent squares at the end of the turn.
  - Guard. The robot will stay put, take half damage from attacks and suicides, and take no damage from collisions.
* There is no friendly damage in this game. Collisions, attacks, and suicides will only damage the opponent.
* Whoever has more robots left after 100 turns wins.
* Your get to code the AI for a single robot. All your robots will use this AI. To win, your robots must work together with other copies of themselves—to surround an enemy robot, for example.

API
---
**Creating a robot file**
This is the basic structure of every robot file:

        class Robot:
            def act(self, game):
                return [<some action>, <params>]

Every turn, the system calls your Robot's act method to determine the robot's next action. The method should return one of:
 * `['move', (x, y)]`
 * `['attack', (x, y)]`
 * `['guard']`
 * `['suicide']`
If act throws an exception or returns an invalid command, the robot will simply guard. On the server, this method has an enforced execution time limit of 300ms.

**Accessing the robot's info**
Every robot, including self, has the following properties exposed:
 * location — the robot's location as a tuple (x, y)
 * hp — the robot's health as an int
 * player_id — the robot's player_id (what "team" it belongs to)
 * robot_id — a unique number identifying each robot
For example, to access the current robot's HP, you would write `self.hp`.

Every turn, the system calls your act method, passing it a game parameter set to the following structure:

        {
            # a dictionary of all robots on the field mapped
            # by {location: robot}
            'robots': {
                (x1, y1): {   
                    'location': (x1, y1),
                    'hp': hp,
                    'player_id': player_id,

                    # only if the robot is on your team
                    'robot_id': robot_id
                },

                # ...and the rest of the robots
            },

            # number of turns passed (starts at 0)
            'turn': turn
        }

game and every robot in `game['robots']` are instances of a special type of dict where you can access values using attributes. This is to make writing code faster. So, the following are equivalent:

        game['robots'][location]['hp']
        game['robots'][location].hp
        game.robots[location].hp

Here's a quick example to print out the location of any robots that are on your team:

        class Robot:
            def act(self, game):
                for loc, robot in game.robots.items():
                    if robot.player_id == self.player_id:
                        print loc

**Example starting robot**

Here's a simple robot to use as a starting point. It looks for any enemies around and attacks them. Otherwise, it tries to move to the center.

        import rg

        class Robot:
            def act(self, game):
                # if we're in the center, stay put
                if self.location == rg.CENTER_POINT:
                    return ['guard']

                # if there are enemies around, attack them
                for loc, bot in game.robots.iteritems():
                    if bot.player_id != self.player_id:
                        if rg.dist(loc, self.location) <= 1:
                            return ['attack', loc]

                # move toward the center
                return ['move', rg.toward(self.location, rg.CENTER_POINT)]

**Library documentation**

Robot game comes with a library to make your life easier. It's packaged inside the `rg` module which you can import like any other, by writing `import rg` at the top of your file. Things to note:
 * Locations are represented by tuples of the form `(x, y)`
 * method `rg.dist(loc1, loc2)` returns the mathematical distance between two locations.
 * method `rg.wdist(loc1, loc2)` returns the walking difference between two locations. Since robots can't move diagonally, this is `dx + dy`.
 * method `rg.loc_types(loc)` returns a list of the types of locations that loc is. Possible values are:
   - invalid — out of bounds
   - normal — on the grid
   - spawn — spawn point
   - obstacle — somewhere you can't walk
  The returned list may contain a combination of these, like `['normal', 'obstacle']`
 * method `rg.locs_around(loc[, filter_out=None)` returns a list of adjacent locations to loc. You can supply a list of location types to filter out as filter_out. For example,

        rg.locs_around(self.location, filter_out=('invalid', 'obstacle'))

 would give you a list of all locations you can move into.
 * method `rg.toward(current_loc, dest_loc)` returns the next point on the way from current_loc to dest_loc. For example, the following code

        import rg

        class Robot:
            def act(self, game):
                if self.location == rg.CENTER_POINT:
                    return ['suicide']
                return ['move', rg.toward(self.location, rg.CENTER_POINT)]

 would make your robot move to the center, then commit suicide.
 * constant `rg.CENTER_POINT` is the location of the center of the board.

 * AttrDict `rg.settings` - A special type of dict that can be accessed via attributes that holds game settings.
   - `rg.settings.spawn_every` - how many turns pass between robots being spawned
   - `rg.settings.spawn_per_player` - how many robots are spawned per player
   - `rg.settings.robot_hp` - default robot HP
   - `rg.settings.attack_range` - a tuple `(minimum, maximum)` holding range of damage dealt by attacks
   - `rg.settings.collision_damage` - damage dealt by collisions
   - `rg.settings.suicide_damage` - damage dealt by suicides
   - `rg.settings.max_turns` - number of turns per game

**Kit**
To test your robots beforehand, please use the testing kit `rgkit` (provide gem?)

        rb rgkit/run.rb yourcode.rb yourothercode.rb

and it will launch a game between yourcode.rb and yourothercode.rb. If you've only written one AI, you can just run it against itself.
`run.rb` also takes two more optional parameters:
 * -H, --headless: runs without the UI (e.g. for A/B testing, etc.)
 * -m, --map <map>: specifies a map file
To create maps, use:

        rb rgkit/mapeditor.rb <optional map file to load>

and follow the directions on screen.