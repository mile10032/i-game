class Game
  def initialize(players)
    puts "gameinitialize"
    puts players
    @isprocessing = false
    @players = players
    
  end

  def start
    @parent = self.chooseRandom(@players)
    playersExcludesParent = @players.select { |player| player.instance_variable_get(:@id) != @parent.instance_variable_get(:@id)}
    @wolf = self.chooseRandom(playersExcludesParent)
    @answerWord = self.chooseRandom(['りんご' ,'ごりら','ラッパ'])
  end
  def parent
    @parent
  end
  def wolf
    @wolf
  end
  def answerWord
    @answerWord
  end
  def chooseRandom(arr)
    return arr[rand(arr.length)]
  end

end