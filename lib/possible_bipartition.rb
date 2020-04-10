#an undirected graph is bipartite if there exists partition into Left & Right;
#it must be 2 colorable 
#it has no odd length cycles  

#assign floofi to source dog 
#color all neighbors with spotti 
#color all neighbors neighbors with floofi
#continue this way until all dogs are colored 
# while assigning colors, if we find a neighbor which is colored with the same color as the current vertex, then the graph is not bipartite 

def possible_bipartition(dislikes)
  return true if dislikes.length <= 2 
  #we use a queue to keep track of all the neighbors once we visit a node
  queue = []
  dog_types = []
  total_dogs = dislikes.length 

  #we can start by putting the first node in the queue
  #it doesnt matter which node we use to start 
  #we can just put in 0 to our queue, which indicates the index of our first start dog 
  queue << 0

  # So what if one of the dislikes arrays are empty? 
  # That means the nodes are isolated & can go anywhere   
  total_dogs.times do |index|
    if !dog_types[index] 
      queue.push(index)
      dog_types[index] = "floofi"
    end 
  end 
  
  #then we color it (the position in the array represents which dog it is, and the value at that position represents the type of dog)
  #this way, we can also use our dog types array as our visited!!!
  dog_types[0] = "floofi"

  #we're just pulling things off the queue here while theres still things on the queue 
  #nodes get added to the queue that are neighbors 
  while !queue.empty?
    #we take whats at the front of the queue and assign that to our current dog 
    current_dog = queue.shift 

    #this is how we access the list of neighbors a current dog has 
    neighbors = dislikes[current_dog]

    #we want to access the values stored inside of the neighbors array
    neighbors.each do |dog|
      #we want to only look at dogs that havent been ALREADY visited
      if !dog_types[dog] 
        #we wanna color these doggos the opposite based on the current dogs color 
        #& stick em in the queue so we can look at THEIR neighbors later
        dog_types[dog] = (dog_types[current_dog] == "spotti") ? "floofi" : "spotti"
        queue << dog 
      elsif dog_types[dog] == dog_types[current_dog] 
        return false
        #if we wind up here, the dog has been visited before
        #that also means the dog is colored so lets check it ^ 
      end 
    end
  end
  #when we exit this neighbors loop that means we've finished checking all neighbors, which measure if a graph is bipartite 
  return true
end 