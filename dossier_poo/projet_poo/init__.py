from random import randint
from time import sleep



class Creature:
    def __init__(self, x , y):
        self.x = x
        self.y = y
        self.position = (randint(1, x), randint(1, y))   
                                                                                
    def _isSamePos(self, creature1, creature2):

        while creature1.position == creature2.position:
            self.position = randint(1, self.x), randint(1, self.y)

    def _allowedMove(self, creature, listeCase):  

        while True:
            newCreaturePos = (creature.position[0] + randint(-1, 1), creature.position[1] + randint(-1, 1))
            if newCreaturePos == creature.position:
                continue
            if newCreaturePos in listeCase:
                break
        return newCreaturePos  

    def _eatNextShot(self, listeCase, position):
    
        xAfter = position[0] + 1
        yAfter = position[1] + 1
        xBefore = position[0] - 1
        yBefore = position[1] - 1
        adj = [(x, y) for x in range(xBefore, xAfter + 1) for y in range(yBefore, yAfter +1)]
        adj.remove(position)
        
        
        return adj

class Map:
    def __init__(self): 
        self.x = 4
        self.y = 4      
        self.listeCase = [(i,z) for i in range(1, self.x + 1) for z in range(1, self.y + 1)] 



class Game():
    def __init__(self):
        self.count = 1
        self.map = Map()
        self.creature1 = Creature(self.map.x, self.map.y)
        self.creature2  = Creature(self.map.x, self.map.y)


    def _start(self):

        print("game start")

        self.creature1._isSamePos(self.creature1, self.creature2)

        print("creature n°1 start:", self.creature1.position)
        print("creature n°2 start:", self.creature2.position)

        while True:
            sleep(1)
            if self.creature2.position in self.creature2._eatNextShot(self.map.listeCase, self.creature1.position):
                print("the creature 1 is on :", self.creature1.position)
                print("the creature n°2 will be eaten")
                self.creature1.position = self.creature2.position
                winner = "creature n°1"
                break
    
            self.creature1.position = self.creature1._allowedMove(self.creature1, self.map.listeCase)
            print("creature n°1 move to:", self.creature1.position)

            if self.creature1.position in self.creature1._eatNextShot(self.map.listeCase, self.creature2.position):
                print("the creature 2 is on ", self.creature2.position)
                print("the creature n°1 will be eaten")
                self.creature2.position = self.creature1.position
                winner = "creature n°2"
                break

            self.creature2.position = self.creature2._allowedMove(self.creature2, self.map.listeCase)
            print("creature n°2 move to:", self.creature2.position)

            self.count += 1

        return winner

    def __str__(self):
        return "the winner is "+ self._start() + " in "+ str(self.count) + " shots"
 
    

partie = Game()
print(partie)



