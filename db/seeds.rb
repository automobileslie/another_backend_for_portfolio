
Post.destroy_all
Project.destroy_all


project_one=Project.create(title: "Plan a Garden", description: "This is an application designed to help users imagine the kind of garden that they would like to create and then start to plan it. The idea for it came from the avid gardening I did last summer and from my appreciation of the community gardens all over New York City." , video: "PlanAGardenVideo", image: "./Images/Azaleas.jpg", frontend: "https://github.com/automobileslie/Garden-App", backend: "https://github.com/automobileslie/Garden-App-API")

project_two=Project.create(title: "Book and Movie Memory Bank", description: "The Book and Movie Memory Bank was inspired by some of my experiences planning courses when I was a Philosophy instructor and writing essays as a student. Occasionally, I would end up mining my memory when deciding what to teach, trying to remember the name of a film I saw years ago that would be especially relevant for a particular class. Or, as I was writing I would be reminded of an idea from an essay or book and would rack my brain or have to rummage through my notes trying to find the title of it. The Book and Movie Memory Log is a place to store information about films or books that have made an impact on you, that you know you want to remember and may want to return to for various purposes later on." , video: "BookandMovieMemoryBankVideo", image: "./Images/Book_and_Movie_Memory_Bank.jpg", frontend: "https://github.com/automobileslie/Book_and_Movie_Memory_Bank", backend: "https://github.com/automobileslie/Book_and_Movie_Memory_Bank_API")

project_three=Project.create(title:  "National Park Trip Planner", description: "National Parks Trip Planner provides information about national parks in the United States, fetching from the National Park Service API and also linking to the National Park Service website. Users can save parks that they would like to go to or to learn more about and take notes on saved parks as they plan a trip. The idea for this application came from my eagerness to get outdoors. I like that National Parks are low-cost and offer educational opportunities about both history and nature.", video: "NationalParksDemo", image: "./Images/United_States.jpg", frontend: "https://github.com/automobileslie/national_parks_app", backend: "https://github.com/automobileslie/national_parks_api")

post_thirty_three = Post.create(title: "Depth First Search", paragraphs: "

./Images/tunnels.jpg this-is-an-image newpar,

In the last week, I have been working on doing breadth-first and depth-first searches of graphs. In my own life outside of coding, I use exactly neither of these methods to get to the bottom of problems, so it was a good learning opportunity! The labs that I did were on The Flatiron School’s Learn.co website, and the following function was written to pass the Depth First Search Lab.* newpar,

*https://learn.co/tracks/software-engineering-post-work/computer-science/data-structures/depth-first-search-lab /anchor newpar,

Vertices and Edges /heading newpar,

The lab prompt gives us a set of vertices and edges, vertices being objects that are meant to represent points on a graph with a ‘name’ and ‘discovered’ attribute, and edges being arrays of the names of two vertices that represent a path between them. In other words, a line could be drawn between the two vertices that form an ‘edge.’ The ‘discovered’ attribute of the vertices is set to a boolean of true, false, or null. Once the vertex has been ‘visited’ by running the function and entering the sets of vertices and edges as input, that value is set to true. newpar,

These are the edges and vertices that Learn.co gives us as example input: newpar,

let edges = [[‘14th&6th’, ‘23rd&6th’], [‘23rd&6th’, ‘34th&6th’], [‘34th&6th’, \n
‘28th&Bwy’], [‘28th&Bwy’, ‘23rd&Bwy’], [‘23rd&Bwy’, \n
‘14th&Lex’],[‘14th&Lex’, ‘23rd&Lex’]] \n
  \n

let vertices = [{name: ‘34th&6th’, discovered: null}, {name: \n
‘23rd&6th’, discovered: null}, {name: ‘14th&6th’, discovered: null}, \n
{name: ‘28th&Bwy’, discovered: null}, {name: ‘23rd&Bwy’, discovered: \n
null}, {name: ‘14th&Lex’, discovered: null}, {name: ‘23rd&Lex’, \n
discovered: null}] newpar,

./Images/depth_first_search_2_paths.png this-is-an-image newpar,

The goal of a depth-first search is to go all the way down one path at a time, rather than going down one level of each of the paths branching from a particular vertex at a time. So, this is the function that I came up with to return an array of the names of the vertices in the order that they are visited in a depth-first search. newpar,

Solution /heading newpar,

function depthFirstSearch (rootNode, vertices, edges){ \n
function findAdjacentNodes(rootNode, vertices, edges){ \n
let adjacentNodeNames = []; \n
let i; \n
for (i = 0; i < edges.length; i++){ \n
if(edges[i].includes(rootNode)){ \n
if(edges[i][0] === rootNode){ \n
adjacentNodeNames.push(edges[i][1]) \n
} \n
else{ \n
adjacentNodeNames.push(edges[i][0]) \n
} \n
} \n
} \n
let adjacentNodes = []; \n
for (let t = 0; t < vertices.length; t++){ \n
if (adjacentNodeNames.includes(vertices[t].name)){ \n
if(vertices[t].discovered === null) \n
adjacentNodes.push(vertices[t]); \n
vertices[t].discovered = true; \n
} \n
else if (vertices[t].name === rootNode){ \n
vertices[t].discovered = true; \n
} \n
} \n
return adjacentNodes; \n
} \n
let theQueue = []; \n
let finalArray = []; \n
theQueue.push(rootNode); \n
finalArray.push(rootNode); \n
let i; \n
while(theQueue.length > 0){ \n
let arrayForQueue = findAdjacentNodes(theQueue[theQueue.length - 1].name, vertices, edges); \n
theQueue.pop(); \n
for(i = 0; i < arrayForQueue.length; i++){ \n
theQueue.push(arrayForQueue[i]); \n
finalArray.push(arrayForQueue[i]) \n
} \n
} \n
return finalArray; \n
} newpar,

The Nested Function /heading newpar,

First, there is a function nested inside of depthFirstSearch called findAdjacentNodes that finds the vertices that branch off of the rootNode. In the first step of that function, there is a for loop that searches the array of edges. If the rootNode’s name appears in an edge, then the name of the node that it shares the edge with is pushed into adjacentNodeNames, which was initialized as an empty array. newpar,

Next, there is a for loop to search through the vertices. If a vertex has a name matching one of the names in adjacentNodeNames, two things happen. First, if it has not yet been marked as ‘discovered’, then that attribute is changed to ‘true.’ It is also pushed into adjacentNodes if it is being discovered for the first time. If it has already been discovered, then nothing happens. If the name of the vertex that the loop is on matches the rootNode, then it is marked as ‘discovered’ without being pushed into the array. newpar,

Finally, at the end of the function, the adjacentNodes array is returned. newpar,

The Rest of the Function /heading newpar,

Next, I set up two empty arrays, one theQueue and the other the finalArray. The variable theQueue will have a value of different names of nodes to be visited, with the nodes to be visited first coming last in the array. The first node name that enters theQueue is the rootNode that was given as input. That name is also immediately pushed into finalArray. newpar,

Then, there is a while loop that will run as long as theQueue has a length greater than 0. In the while loop, the findAdjacentNodes function runs, with the name of the last node in theQueue being entered as the first input value. The return value of findAdjacentNodes is set to a variable called arrayForQueue, and the last item in theQueue is removed from that array using the pop() method. newpar,

Since arrayForQueue will be an array of items, there is then a for loop that will run to push the values in that array into theQueue. newpar,

In the end, the function returns the finalArray, which is the names of the nodes in the order they were visited. That should start with the rootNode (the one given as input as a starting point for the exploration of the graph), then include any vertices that branch off of that node, then all of the nodes down one branch, then all of the nodes down another branch, until all of the nodes that can be visited have been. newpar,

Le Voyage /heading newpar,

The only thing I have against this method as a way of life is that it is not always worth it to turn over every stone to find what you are looking for. Sometimes you also do not need the breadth-first search model to go one level deep in everything out there to know either that you are where you already need to be or that you know where it is you want to go. newpar,

But that is not to discourage the intrepid travelers! newpar,

https://fleursdumal.org/poem/231 /anchor newpar,

https://www.poetryfoundation.org/poets/charles-baudelaire /anchor newpar,

")

post_thirty_two= Post.create(title: "Gridlock", paragraphs: "

For a coding challenge that I did recently, I wrote a function that took in an input of a matrix of size N x N and output whether or not it was valid. In order for the matrix to be valid, it had to have each of the numbers up until N in both the columns and the rows. For example, this is one possible grid, which would be submitted as an array of arrays: [[1, 2, 3, 4], [2, 3, 4, 1], [3, 4, 1, 2], [4, 1, 2, 3]]. newpar,

./Images/Matrix.png this-is-an-image newpar,

Since this satisfies the conditions, the function would return 'VALID'. newpar,

Sudoku /heading newpar,

Though I have never played it before, this problem was supposed to be designed to check sub-grids in a Sudoku game. Here are a couple of resources about Sudoku in case you would like to learn more. newpar,

https://www.nytimes.com/puzzles/sudoku/easy /anchor newpar,

https://en.wikipedia.org/wiki/Sudoku /anchor newpar,

Solution /heading newpar,

This is my solution to the problem, which I will explain below! newpar,

function checkSubSudoku(matrix) { \n
let lengthOfMatrix = matrix.length; \n
let i; \n
let n; \n
let theIntegers = []; \n
let copyOfMatrix = []; \n
let areTheRowsValid; \n
let areArraysInMatrixSameSize; \n
let flattenedMatrix = matrix.flat(); \n
let allAreIntegers; \n
//check to see whether all of the items in the arrays are positive integers \n
for(let a = 0; a < flattenedMatrix.length; a++){ \n
if (Math.sign(flattenedMatrix[a])===1){ \n
if (!allAreIntegers || allAreIntegers === true){ \n
allAreIntegers = true; \n
} \n
else { \n
allAreIntegers = false; \n
} \n
} \n
else { \n
allAreIntegers = false; \n
} \n
} \n
if(!allAreIntegers){ \n
return 'INVALID' \n
} \n
else{ \n
//check that the length of each of the arrays within the array are the same size \n
for(let w = 0; w < lengthOfMatrix; w++){ \n
if(matrix[w].length === lengthOfMatrix){ \n
if(!areArraysInMatrixSameSize || areArraysInMatrixSameSize === true){ \n
areArraysInMatrixSameSize = true; \n
} \n
else{ \n
areArraysInMatrixSameSize = false; \n
} \n
} \n
else{ \n
areArraysInMatrixSameSize = false; \n
} \n
} \n
if(!areArraysInMatrixSameSize){ \n
return 'INVALID'} \n
else{ \n
//set the variable theIntegers to see what numbers must be in each row and column of the matrix \n
for(n = 0; n < lengthOfMatrix; n++){ \n
theIntegers.push(n+1); \n
} \n
theIntegers = parseInt(theIntegers.join("")) \n
//create a copy of the matrix in order to be able to sort without modifying the original array \n
for(let i = 0; i < lengthOfMatrix; i++){ \n
let sliceOfMatrix = matrix.slice(i, i+1).flat(); \n
let sortedSlice = sliceOfMatrix.sort((a, b)=>{ \n
return a-b}) \n
copyOfMatrix.push(sortedSlice); \n
} \n
//check each row of the copy to make sure it includes each number \n
for(let h = 0; h < lengthOfMatrix; h++){ \n
if(parseInt(copyOfMatrix[h].join(""))===theIntegers){ \n
if(!areTheRowsValid || areTheRowsValid === true){ \n
areTheRowsValid = true; \n
} \n
else{ \n
areTheRowsValid = false; \n
} \n
} \n
else{ \n
areTheRowsValid = false; \n
} \n
} \n
//create an array of the columns \n
let copyForColumns = []; \n
for(let g = 0; g < lengthOfMatrix; g++){ \n
let arrayToPush = []; \n
for (h = 0; h < lengthOfMatrix; h++){ \n
arrayToPush.push(matrix[h][g]) \n
} \n
copyForColumns.push(arrayToPush.sort((a, b)=> {return a-b})) \n
} \n
//check each column to make sure it includes all of the numbers \n
let areTheColumnsValid; \n
for(let d = 0; d < lengthOfMatrix; d++){ \n
if(parseInt(copyForColumns[d].join(""))===theIntegers){ \n
if(!areTheColumnsValid || areTheColumnsValid === true){ \n
areTheColumnsValid = true; \n
} \n
else{ \n
areTheColumnsValid = false; \n
} \n
} \n
else{ \n
areTheColumnsValid = false; \n
} \n
} \n
//   return either 'VALID' or 'INVALID' \n
if(areTheRowsValid && areTheColumnsValid){ \n
return 'VALID'; \n
} \n
else{ \n
return 'INVALID'; \n
} \n
} \n
} \n
} newpar,

Damage Control /heading newpar,

In the first couple of steps, I am doing damage control, anticipating edge cases. First, I check to see whether all of the items in the arrays are positive integers. I flatten the nested array to make one long array of items; then I check each of these items and use Math.sign() to determine whether they are positive integers. Math.sign() returns 1 if what is put in between the parentheses is a positive integer, -1 if what is placed there is a negative number, 0 if 0 is put there, and NaN if the value is anything else put in between quotation marks, for example “,”. newpar,

One of many example of why coding is a good time! newpar,

https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Math/sign#:~:text=sign%28%29%20function%20returns%20either,%28%2B%29%20will%20not%20be%20returned. /anchor newpar,

If the current item in the loop through the flattened matrix passes the test, and if the variable areAllIntegers either has not been set yet or has been set to true, then it remains true, being set to true again. If areAllIntegers has been set to false, though, it remains false, since one non-positive integer or other value like a punctuation mark means that the whole grid is invalid. If the current item in the for loop does not pass the test of Math.sign(), then whether areAllIntegers has not been set yet, has been set to true, or has already been set to false, it will be set to false. Another way I could have done this would have been to use a while loop, so that once the variable is set to false, the loop exits, as none of the other values need to be checked. newpar,

Next, I see whether the input arrays within the matrix are all the same size. This follows a similar pattern to the first test, though it is on the non-flattened matrix. We don’t have to check the values within the arrays at this point; we just want to take the length of them. This follows the same pattern as the one above as far as setting the variable areArraysInMatrixSameSize to true or false goes. newpar,

If either of those tests fail (if either areArraysInMatrixSameSize or areAllIntegers have a value of false), the function exits, returning “INVALID”. Otherwise, it goes on to the next step. newpar,

https://en.wikipedia.org/wiki/Damage_control /anchor newpar,

The Next Step: Checking the Rows /heading newpar,

After that, I set the value of theIntegers by running a for loop that goes through the length of the input matrix starting from the counter of n = 0 and pushes n+1 into an array that is then joined and parsed into a number with parseInt. The result of this is that if the input matrix is [[1, 2, 3, 4], [2, 3, 4, 1], [3, 4, 1, 2], [4, 1, 2, 3]], then theIntegers is 1234. This will be used as the point of comparison for what is in each of the rows and columns later on. newpar,

Next, I create a copy of the matrix. The reason that I do this is because I am going to be sorting each of the arrays in the matrix to check them against theIntegers to make sure that all of the numbers are included in each row. I do not want to alter the original input matrix, because I will also be checking the column in a separate step and can’t do that if the original input matrix is changed. newpar,

To create a copy of the matrix, I implemented another for loop starting at 0 and incrementing up until the length of the matrix. At each step of the for loop, I took a slice of the matrix — one of the arrays in the wrapping array, starting from the beginning of the matrix and going until the end.* I sorted it and pushed it into copyOfMatrix. So, copyOfMatrix ended up being not an exact replica of the original input matrix but a sorted version of it. This was so that in the next step of the function, I could check each sorted array to see if it included all of the requisite numbers. newpar,

*To review how to make a shallow copy of the matrix, I consulted a few websites. I am not sure which of them convinced me to try using the slice method, so here are links to all of them. newpar,

https://medium.com/@ziyoshams/deep-copying-javascript-arrays-4d5fc45a6e3e /anchor newpar,

https://www.samanthaming.com/tidbits/35-es6-way-to-clone-an-array/ /anchor newpar,

https://www.freecodecamp.org/news/how-to-clone-an-array-in-javascript-1d3183468f6a/ /anchor newpar,

Because the coding challenge ended up being an exercise in my over-attachment to the for loop, I ran another for loop with a counter of zero incrementing up until the length of the matrix. Here is where I join the sorted array at the current location in the loop and parse it with parseInt before comparing it to theIntegers. If it matches theIntegers, then I go through the same true/false process of setting the variable areTheRowsValid as I did earlier in the first two conditions of the function. At the end of the loop, if areTheRowsValid is false, I could (and should) exit and return 'INVALID'. newpar,

However, I did it a little less efficiently, going ahead and checking the columns before making any final determinations one way or another about the validity of this poor matrix which has already been through a lot. newpar,

The Columns /heading newpar,

So! On to the columns! newpar,

Next, I create an array of arrays of columns. This is an act of imagination, since we don’t actually have a grid and have to imagine the nested arrays stacked on top of each other. newpar,

I return to the friendly for loop, but unfortunately for those of you keeping track of time complexity, this time it is a nested for loop. At the first level of the for loop, I initialize an empty array called arrayToPush. Then in the inner loop, I push matrix[h][g] into arrayToPush. What that means is that with a grid that looks like this: newpar,

./Images/Matrix.png this-is-an-image newpar,

matrix[h] will be the column, and [g] will represent the row. So, on the first loop through, matrix[h][g] will be matrix[0][0], then matrix[0][1], matrix[0][2], and matrix[0][3], or [1, 2, 3, 4]. After that first nested loop through, arrayToPush is pushed into the empty array copyForColumns, though it is sorted first. newpar,

The next nested loop through would be matrix[1][0], matrix[1][1], matrix[1][2], and matrix[1][3], or [2, 3, 4, 1]. At this point, you might notice that the rows and columns with the same index position are actually the same (e.g. row one is the same as column one, row two is the same as column two, etc.). I did not let that observation deter me, because, not being familiar with this type of problem beforehand, it was not clear to me whether that is the way it always ends up as a rule. If it is, though, then checking the columns would be unnecessary. newpar,

Report back to me if you would like to discuss or tell me what is what. newpar,

In the next step, I do the same thing that I did to check whether the rows were valid, looping through copyForColumns, joining each array, and parsing the array with parseInt before comparing that value to theIntegers. newpar,

In the final step, if both areColumnsValid and areRowsValid are true, then the function returns 'VALID'. Otherwise, it returns 'INVALID'. newpar,

And that is the end of my story about grids. newpar,

https://en.wikipedia.org/wiki/Gridlock /anchor newpar,

https://www.youtube.com/embed/snsTmi9N9Gs newpar,

")


post_thirty_one= Post.create(title: "Binary Search Tree and Me", paragraphs: " 

./Images/Binary_Search_Tree.png this-is-an-image newpar,

This week, I have been working on binary search trees, so this is an explanation of a problem that I did on Learn.co’s Software Engineering Post-Work track. It builds on the concept of Linked Lists, which I wrote about a couple of weeks ago. Just as a caveat, this is still something I am learning about and getting comfortable with! newpar,

Binary Search Tree Examples /heading newpar,

When using a binary search tree in JavaScript, numbers higher than the root go to the right of it, while numbers less than the root go to the left, as in the picture above. Below is a picture of another tree on the Flatiron School’s Learn.co. newpar,

./Images/Another_Binary_Tree.png this-is-an-image newpar, 

The pictures are just a heuristic. The code for the first tree pictured above looks like this: newpar,

{data: 5, left: \n
{data: 3, left: null, right: null}, \n
right: {data: 7, left: null, \n
right: {data: 9, left: null, right: null} \n
}} newpar,

Great — now let’s do a problem! newpar,

With a While Loop /heading newpar,

One of the parts of the lab I did asked me to write a function that takes in the root node and one other node; if the other node is found to be in the tree already, then the function returns ‘true.’ Otherwise, it adds the node in the appropriate place on the tree. newpar,

The first approach I took to the problem uses a while loop. The recursive solution is in the works, so we’ll go with this one for now! newpar,

function findOrAdd (currentNode, newNode) { \n
let quitLoop = 0; \n
while(quitLoop < 1){ \n
if(currentNode.data === newNode.data){ \n
return true \n
} \n
else if(newNode.data < currentNode.data){ \n
if (!currentNode.left){ \n
currentNode.left = newNode; \n
quitLoop = 1; \n
} \n
else{ \n
currentNode = currentNode.left; \n
} \n
} \n
else { \n
if (!currentNode.right) { \n
currentNode.right = newNode; \n
quitLoop = 1; \n
} \n
else { \n
currentNode = currentNode.right; \n
} \n
} \n
} \n
return false; \n
} newpar,

Before walking through the code, I’d like to direct your attention to our friend the test file. newpar,

Look at the Test File /heading newpar,

What is currentNode.data and newNode.data? If you look in the test file or comment out the rest of the code from the function and just return them, you can see what type of data the problem is expecting as inputs. Below is what we can learn from looking in the test file. newpar,

let rootNode = {data: 5, left: null, right: null} \n
let firstNewNode = {data: 3, left: null, right: null} \n
let secondNewNode = {data: 7, left: null, right: null} \n
let thirdNewNode = {data: 9, left: null, right: null} newpar,

The rootNode is what would be passed in as currentNode, or the head of the binary tree. The other three nodes are all examples of nodes that could be passed in as the second input. The test also shows us what it is expecting if the rootNode is entered as the first input and the firstNewNode is entered as the second input. newpar,

this-is-code-in-blog
findOrAdd(rootNode, firstNewNode) \n
expect(rootNode.left).toEqual(firstNewNode) newpar,

The data for firstNewNode is 3, and since that is less than 5, it would go to the left. The test is actually pretty simple, since the left and right of the rootNode are both null. If the data of the second argument is larger, it goes to the right, and if it is smaller it goes to the left. Though my solution works with the current tests, I am not 100% sure that my solution would work the way that it is supposed to with a binary tree that has been built up more before using the function to add additional nodes. I did more testing myself — and though it seems to work, I have to think about it some more and get more practice. newpar,

But for a first try with something new, let’s start small! newpar,

Explanation of the While Loop /heading newpar,

If currentNode.data is equal to newNode.data, then the function can return ‘true’ right away. Otherwise, if newNode.data is less than currentNode.data, if currentNode does not have a value to the left, the newNode can be inserted there. The variable quitLoop is set to 1 so the while loop will exit. However, if newNode.data is less than currentNode.data but there is already a value to the left of currentNode, then the currentNode variable is set to the value of currentNode.left and the while loop runs again until either a place on the tree is found for the newNode or it is discovered that the newNode is actually an old node already on the binary search tree — in which case the function will return true to signify that the tree already contains that node. newpar,

If newNode.data is greater than currentNode.data, then the same process occurs, except it starts looking along the right side of what I am going to start imagining to be a Christmas tree. If the function makes it through the tree, finds a place for the newNode, and does not find data equal to the data in newNode, then it will return false and update the binary search tree to include the newNode in it. newpar,

So, that was my adventure with binary search trees. Don’t get lost in the branches, everyone! newpar,

https://www.youtube.com/embed/VNR72YHWVCk newpar,

https://www.youtube.com/embed/DA_dExJjywk

")

post_thirty= Post.create(title: "Recursion (Again)", paragraphs: "Recently, I have been working on recursion, a topic I became newly acquainted with last week. While I am looking forward to using it in different ways in the future, below is a problem that I did as I got started. It is part of a lab on the Software Engineering Post-Work Track on Learn.co for the Flatiron School. Though, I don’t have a job yet, this is how much I like the Flatiron School — I wear their Access Labs t-shirt on beautiful summer days. newpar,

./Images/Access_Labs.jpg this-is-an-image newpar,

Plugging Other Posts /heading newpar,

When learning something new, there are a lot of things that help me to understand it. It is nice to have a theoretical overview, to try to solve problem sets, to see multiple examples, and to get explanations of how a concept or tool works in different contexts. While the read-me and lab on Learn.co was a great place to start, examples I found elsewhere on the internet, particularly for doing string manipulation using recursion, made it easier for me to jump in. Below are the two posts that best helped me to get a foothold at the beginning of the lab so that I could then solve the few remaining parts of the problem set on my own. Thanks, guys! newpar,

https://davidtang.io/2019/04/11/learning-recursion-in-javascript-part-4.html /anchor newpar,

https://learnersbucket.com/examples/algorithms/reverse-a-string-using-recursion/ /anchor newpar,

Adding Up To An Index /heading newpar,

One of the functions I wrote adds up the numbers in an array, stopping at a specified index position and returning the sum. Often there is more than one answer to a problem. That is part of what makes life interesting. Below is my first solution. newpar,

Solution 1 /heading newpar,

function addUpTo (arr, index) { \n
if (arr.length < 1) { \n
    return 0; \n
  } \n
else { \n
    let reducedArray = arr.slice(0, index + 1); \n
return reducedArray.pop() + addUpTo(reducedArray, reducedArray.length); \n
  } \n
} newpar,

If the length of the array is 0, then the function just returns 0. Otherwise, it takes a slice of the array from the beginning through the specified index position. Since when you take a slice it does not alter the array in place, the result of the slice is stored in the variable reducedArray. newpar,

For example, if the input index is 1, and the input array is [5, 6, 2, 4, 1], the reducedArray would be [5, 6]. Below is a link to the MDN explanation of the slice method. newpar,

https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array/slice /anchor newpar,

Then, once we have an array from which all of the values we will not be adding are eliminated, we can go ahead and start adding together the numbers that are left. In the next step, the function removes the last item in the array. Using the pop method returns the eliminated item and alters the array in place. So, [5, 6].pop() returns the number 6, and the value of reducedArray is now just [5]. We do not have to save the altered array to a new variable, unlike when we used the slice method. newpar,

Now, we can finally use recursion! In addition to returning the number that is deleted from the array, we call the function with the new input values of reducedArray and reducedArray.length. newpar,

This is still like magic to me, but what happens next is that the function keeps calling on itself until the array is empty, and there are no more numbers to add together. Though it looks like the function would return several times (and doesn’t a function exit upon the first return?!), the function does not actually return until it has met its base condition and is ready to exit. That means that all of the numbers are popped off of the array and added together. Then the sum of them is returned. newpar,

Solution 2 /heading newpar,

Another way of solving the problem is by using the splice method, which, unlike the slice method, alters an array in place. newpar,

function addUpTo (arr, index) { \n
if (arr.length === 0) { \n
return 0 \n
} \n
else { \n
return arr.splice(index)[0] + addUpTo(arr, arr.length - 1); \n
} \n
} newpar,

In this solution, the first condition is the same — if the length of the array is 0, then 0 is returned. Otherwise, we splice the array at the input index position. Then, we return the value in the 0 position of the array that is returned from splicing. newpar,

For example, take an input array of [5, 6, 2, 4, 1] and an input index of 3. Calling arr.splice(3) would remove all the items from the array starting from index 3 and would return an array of what has been deleted — [4, 1]. Because we want to add the value at the index position in addition to removing it, we can call arr.splice(index)[0] to only return the 4 from [4, 1]. newpar,

https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array/splice /anchor newpar,

Then, we can do recursion again! Since the array has been altered in place using splice, we can just enter ‘arr’ as the input array. The input index is ‘arr.length-1’. That means that when the function calls itself on the next round it will remove the last item in the array and return it, adding it to all the others. The length of the array that is returned from the splice will only be 1 after the first call (before the array is completely emptied), but returning the item at the 0 position will have the same affect as if it were a longer array. newpar,

In Conclusion /heading newpar,

Recursion makes me happy. Have a nice day. newpar,

https://www.youtube.com/embed/JnbfuAcCqpY newpar,

https://www.youtube.com/embed/qHppZ1aXxVc newpar,

")

post_twenty_nine=Post.create(title: "Recursion and Class in JavaScript", paragraphs: "

./Images/Kermit.png this-is-an-image newpar,

This week, I have been both reviewing something old and learning something new, and I decided to bring them together in a blog post so that they can get to know each other and you can get to know them. newpar,

Recursion /heading newpar,

Recursion is the new friend I am making this week, and we are still getting used to each other. Ok, it is mostly me getting used to her. newpar,

Recursion is calling on a function that you are still in the process of defining. Below is an example that takes in a number n and a string of text and logs it to the console n amount of times. newpar,

function repeatLine (n, theLine) { \n
console.log(theLine); \n
if (n > 1) { \n
repeatLine(n - 1, theLine); \n
} \n
} newpar,

First, theLine is logged once before hitting the if condition. Then, if n is greater than one, the function as it is defined up until that point is called with n being decremented. That means that theLine is console-logged. That call will be repeated until n is no longer greater than one. If you call the function with the the number entered as 5 and the string as 'whosits and whatsits galore', you should see the following in your console. newpar,

./Images/Whosits.png this-is-an-image newpar,

As in: newpar,

https://www.youtube.com/embed/t6Ol7VsZGk4 newpar,

Reminder about Function Input /heading newpar,

Something to keep in mind if you are just starting out with JavaScript is that it is the order of the input that matters. For example, if you had called the function with the input order reversed, like this: newpar,

this-is-code-in-blog
repeatLine('whosits and whatsitsgalore', 5) newpar,

then the number 5 would have been console-logged one time. If you check the datatype in the console by adding a console.log to the function for the data type, like this newpar,

function repeatLine (n, theLine) { \n
console.log(theLine); \n
console.log(typeof theLine); \n
if (n > 1) { \n
repeatLine(n - 1, theLine); \n
} \n
} newpar,

you will see that the data type of the 5 that is logged is ‘number’. The data type of the input is not specified by the function, so it will log theLine regardless of its type and will not coerce it into being another type. It will not decide to arbitrarily convert the number 5 into a string. But it also will not know that what you wanted was for the input that is a string to be the one that is printed out. newpar,

Why does the function log anything at all? Before the if statement, a console.log is made, so theLine, whatever it is, will print at least one time. Since the value of n is a string and you cannot compare a string to a number, the if statement is not triggered. This is what I get when trying to compare a string to a number in the console. newpar,

./Images/whosits_2.png this-is-an-image newpar,

If we ask whether the variable is less than one, using the less than operator, the answer is 'false'. If we ask whether the variable is greater than one, then the answer is also 'false'. If you use the == and === operators to compare phrase to 1, it is also comes out false. newpar,

In my opinion, this is an example of how in code, as in life, not everything is reducible to numbers. newpar,

Review of Class Constructors /heading newpar,

This is the old friend who I haven’t thought about in awhile but has been there all along. newpar,

In making applications with React a portion of the work of writing code is abstracted away, and I realized that it was a good time for me to review Class and Inheritance to be reminded of what I have been taking for granted. newpar,

While using the current version of React, it has not been necessary for me to use a constructor, so this is a basic review of what a constructor does. Below is an example of the class Frog. newpar,

class Frog { \n
constructor (name, from, into) { \n
this.name = name; \n
this.from = from; \n
this.into = into; \n
} \n
} newpar,

Any instance of the class Frog will have to be initialized with a name and a value for the 'from' and 'into' attributes. The ‘this’ as it appears in the constructor refers to the instance of a frog that is being or has been created. newpar,

For example, below is a new instance of a frog being created: newpar,

./Images/new_Frog.png this-is-an-image newpar,

The ‘new’ signals that a new object that is an instance of a class is about to be created. After that comes the name of the class, in this case ‘Frog’. Then, we need to include input between parentheses to give a value for the name, from, and into attributes. The result of the above is the following, a new frog! newpar,

./Images/Kermit.png this-is-an-image newpar,

That means that if I type newpar,

this-is-code-in-blog
Kermit.from newpar,

into the console at this point, it should return 'frog'. newpar,

Getting It Together /heading newpar,

Because it is sometimes nice to have a happy ending to a story, let’s bring the above concepts together. newpar,

In the console, if you call repeatLine (the second version that also gives us the data type of what is being logged) with the following input newpar,

this-is-code-in-blog
repeatLine(5, Kermit.from) newpar,

you should get as the output newpar,

./Images/5_frogs.png this-is-an-image newpar,

Which kind of reminds me of a frog doing jump rope. newpar,

You’re welcome. newpar,

")

post_twenty_eight=Post.create(title: "Linked Lists", paragraphs: "

./Images/Linked_List.jpg this-is-an-image newpar,

Over the last week I have had the occasion to start learning about linked lists, doing a couple of problems on Leetcode and also returning to the post-graduation algorithm lessons that Flatiron School has on Learn.co. While I miss the arrays that I am used to, I understand that it is important for me to be familiar with linked lists and to spend more time working with different data structures. newpar,

The Hashes and Variables /heading newpar,

The problems for the Linked List Lab on Learn.co work with a set of data like this: newpar,

let firstNode = {name: 'susie', next: 'rkjasj'} \n
let secondNode = {name: 'sam', next: 'asnan'} \n
let newNode = {name: 'jill', next: ''} \n
let lastNode = {name: 'charlie', next: null} \n
let collection = {rkjasj: secondNode, asnan: lastNode, whana: firstNode, ajhsak: newNode} \n
let linkedList = 'whana' newpar,

Each of the nodes are part of the ‘collection’ hash with a key to each of the nodes. Separating out the firstNode, secondNode, etc. makes it more readable. Otherwise, ‘collection’ would look like this: newpar,

{rkjasj: {name: 'sam', next: 'asnan'}, asnan: {name: 'charlie', next: null}, whana: {name: 'susie', next: 'rkjasj'}, ajhsak: {name: 'jill', next: ''}} newpar,

It is a little misleading putting ‘whana’ third in the collection when it is the head of the linked list, but we are given the information that it is the first node, in any case. I think it is either a typo or something for me to ponder the deeper meaning of. Actually, I think the point is that hashes do not have indexes the way that arrays do. newpar,

We are also given the variable ‘linkedList’ which tells us which of the nodes in the hash is the head. In other words, ‘collection[linkedList]’ gives us the first node. newpar,

Function For Deleting a Node /heading newpar,

While the lab asks us to write eight different functions to manipulate the nodes in different ways, I am going to focus here on the function for deleting a node. Here is the code I wrote, which I will explain below. newpar,

function deleteNodeAt (index, linkedList, collection) { \n
let currentNode = collection[linkedList]; \n
let currentIndex = 0; \n
let addressForAddingNext; \n
let addressToAdd; \n
while (currentIndex <= index){ \n
if (currentIndex === index - 1){ \n
addressForAddingNext = currentNode; \n
currentIndex +=1; \n
currentNode = next(currentNode, collection); \n
} \n
else if (currentIndex === index){ \n
addressToAdd = currentNode.next; \n
addressForAddingNext.next = addressToAdd; \n
currentIndex +=1; \n
currentNode= next(currentNode, collection); \n
} \n
else{ \n
index += 1; \n
currentNode= next(currentNode, collection); \n
} \n
} newpar,

Three arguments are passed into the function: index, linkedList, and collection. The index is the position of the node we are supposed to delete in the collection. The other two variables are given above. newpar,

A while loop runs as long as the current index is less than or equal to the index of the node that we are deleting. At the beginning, I set the currentIndex to zero. Then once the while loop is running, if the index position that we are at is 1 less than the target number, the function grabs the address of that node to use later on. The reason we will need it is to change the address that that node’s ‘next’ key points to, since the address currently there is the one that is being deleted. We want to make it point to the address of the node currently after the one that is being deleted. It is kind of like removing a frog from the game of leap frog (disclaimer: I don’t remember how that game actually works). newpar,

Example of First Pass Through the While Loop /heading newpar,

If the index passed in is 1, then the first condition will be met on the first pass through the loop, since currentIndex is 0 to begin with. So, addressForAddingNext = collection[linkedList], or in other words addressForAddingNext = firstNode. The currentIndex goes up by one, and then we use a function that we wrote earlier to get to the next node and reset the value of currentNode to that. newpar,

Getting to the Next Node /heading newpar,

For the sake of not being too mysterious, the function to get to the next node is: newpar,

function next (node, collection){ \n
return  collection[node.next]; \n
} newpar,

If we call next() with firstNode (the value of ‘whana’ in ‘collection’) and the whole ‘collection’ passed in, this is the node we are dealing with, the value of firstNode: newpar,

this-is-code-in-blog
collection['rkjasj'] newpar,

we get the next node, secondNode, with the value of newpar,

{name: “sam”, next: “asnan”} newpar,

SecondNode becomes the currentNode for the next round. newpar,

What To Do When You Hit the Target Index /heading newpar,

On the next pass through the loop in the example above, the index will match the value of ‘currentIndex’. Here, we can grab the key to reset the ‘next’ value for the node at the previous index. newpar,

The ‘currentNode’ now is ‘secondNode’, set to the value of newpar,

{name: “sam”, next: “asnan”} newpar,

and if we call next on it (secondNode.next) we get ‘asnan’, the key of the next node in the linked list ‘collection’. We no longer want the first node to point to the second one, because we want to delete the second one. So, we can make the ‘next’ value of the first node ‘asnan’ to skip over the second node and go right to the third one. newpar,

If on the second loop we had not already gotten to the node we needed to delete, then we would have just incremented the currentIndex, moved on to the next node, and gone through the loop until we got there. newpar,

But doesn’t the second node still live somewhere in the computer’s memory? Isn’t it there even if it is not a part of the linked list anymore, cluttering some neglected corner piled high with everything else I didn’t get to today? newpar,

Teacher, I have a question. newpar,

À propos of trying to remove certain things from our lives. newpar,

https://www.youtube.com/embed/mcF5wl2PlmU newpar,

")

post_twenty_seven=Post.create(title: "Let Them Eat (Interview) Cake", paragraphs: "

./Images/Showers_Of_Happiness.jpg this-is-an-image newpar,

Following up on last week, this week’s problem on Interview Cake just gave me an opportunity to review binary search again. The prompt states that passed into a function is an array with words taken from a dictionary that has been opened somewhere near the center. The first words in the array are accordingly starting with a letter somewhere near the middle of the alphabet. Then the person trying to improve her vocabulary keeps flipping through until she reaches the end, at which point she turns to the beginning and goes through it until she gets back to where she started. newpar,

We are asked to write a function taking in one such array and returning the index of the inflection point, the point at which it is evident that the dictionary detective has started again from the beginning. The example array that is given is the following, with the inflection point being at ‘asymptote’: newpar,

this-is-code-in-blog
const words = [ \n
'ptolemaic', \n
'retrograde', \n
'supplant', \n
'undulate', \n
'xenoepist', \n
'asymptote', \n
'babka', \n
'banoffee', \n
'engender', \n
'karpatka', \n
'othellolagkage', \n
] newpar,

This is the pseudocode for my approach to the problem: newpar,

this-is-code-in-blog
// start at the middle; check to see if the inflection point is at the median \n
// the value of the first letter of the word at the median should be less than the value of the first letter of the next word \n
// if it is not, then the median is the inflection point \n
// if the median is not the inflection point, go forward or backward depending on how close to the inflection point you are and \n
// check the median again until you find it newpar,

And this is my solution: newpar,

function rotationPoint (words) { \n
let start = 0; \n
let end = words.length - 1; \n
let median; \n
while (start <= end){ \n
median = parseInt((start + end) / 2); \n
if ((words[median][0] < words[median - 1][0])) { \n
return median; \n
} \n
else if (words[median][0]< words[0][0]) { \n
end = median - 1; \n
} \n
else { \n
start = median + 1; \n
} \n
} \n
} newpar,

If the median is not the inflection point, then I check to see whether the first letter of the word there is less than the value of the first letter of the first word in the array. If it is, then that means the inflection point is earlier in the array; so, the end is now moved to one position before the current median. Otherwise, the inflection point is further down the line on the right side of the array, so the start becomes the median + 1. newpar,

A note on using greater and less than operators with letters. JavaScript allows us to make this comparison without converting the characters into numbers. If we wanted to, we could, however, use .charCodeAt() instead. For example, newpar,

this-is-code-in-blog
words[median].charCodeAt(0) < words[median-1].charCodeAt(0) newpar,

works as well as newpar,

this-is-code-in-blog
words[median][0] < words[median - 1][0] newpar,

https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/String/charCodeAt /anchor newpar,

The while loop runs until either the index of the inflection point is returned or the start value becomes greater than the value of the end point (see my last blog post for an explanation of this). newpar,

Though I do not know her, this is the Github profile of the person whose code on LeetCode helped me to understand Binary Search better: newpar,

https://github.com/yuyuhhh /anchor newpar,

Thank you! You deserve a piece of cake. newpar,

")

post_twenty_six=Post.create(title: "Odd Man Out", paragraphs: "

I am working on improving my binary search tactics, and this post documents some of my initial struggles, with updates about the progress I made toward the end. newpar,

First Try: There’s A First Time For Everything /heading newpar,

The code below works in exactly one out of 62 test cases on LeetCode. The problem indicates that we are supposed to give the index position of the target number in a sorted input array or the position where the target number would be if it were included. I am going to keep working on this tomorrow if I can, but this is the code that will make one test pass, in case anyone is interested in getting a 1.61% on the assignment. Some days, that is all we can hope for! newpar,

var searchInsert = function(nums, target) { \n
                
    if (nums.length <= 1) { \n
        
        if(nums[0]){ \n
    
            if (nums[0] === target) { \n
    
            return 0; \n
            } \n
        } \n
        
        else{ \n
            
            return 0; \n
        } \n
    } \n
else { \n
    
        let startingPoint = 0; \n
        
        let endPoint= nums.length - 1; \n
                
        let midpoint; \n
        
        let finished = 0; \n
    
        while (finished < 1) { \n
                        
            midpoint = parseInt((endPoint + startingPoint)/2); \n
if (nums[midpoint] > target){ \n
               
               if (midpoint === 0) { \n
                    
                    finished+=1; \n
                                                         
                   } \n
               
               
               else { \n
                     
                    endPoint = midpoint; \n
                } \n
           } \n
        
            else if (nums[midpoint] < target) { \n
                
                if (midpoint === nums.length - 1){ \n
                    
                    finished+=1; \n
                    
                } \n
                
                else if (midpoint === 0){ \n
                    
                    if(nums.length === 2){ \n
                                                
                        if (nums[midpoint + 1]===target){ \n
                            
                            finished+=1; \n
                            return midpoint+1; \n
                            
                        } \n 
                        
                        else{ \n
                            finished+=1; \n
                        } \n
                    } \n
                } \n
                
                else{ \n
            
                    if (nums[midpoint + 1] > target) { \n
                        
                        finished+=1; \n
                                   } \n
                    
                    else{ \n
                        
                        startingPoint = midpoint; \n
                    } \n
                } \n
            } \n
        
            else if (nums[midpoint] === target){ \n
                
                finished+=1; \n
                                
                return midpoint; \n                  
            } \n
        } \n  
    } \n
    
    return 0; \n
} newpar,

Try Again /heading newpar,

The following is code that passes 2/62 test cases. I am including it as an example of incremental progress. Enjoy! newpar,

var searchInsert = function(nums, target) { \n
                
    if (nums.length <= 1) { \n
        
        if(nums[0]){ \n
            
            if (nums[0] === target || nums[0] > target) { \n
    
            return 0; \n
            } \n
            
            else if (nums[0] < target){ \n
                
                return 1; \n
            } \n
            
        } \n
        
        
        else{ \n
            
            return 0; \n
        } \n
    } \n
else { \n
    
        let startingPoint = 0; \n
        
        let endPoint= nums.length - 1; \n
                
        let midpoint; \n   
        
        let finished = 0; \n
        
        let insertionPosition; \n
            
        while (finished < 1 && startingPoint !== endPoint) { \n
                        
            midpoint = parseInt((endPoint + startingPoint)/2); \n
if (nums[midpoint] > target){ \n
                
                endPoint = midpoint; \n
               
               if (midpoint === 0){ \n
                   
                   insertionPosition = 0; \n
                   
                   finished+=1; \n
                   
                   return insertionPosition; \n
               }
               
               else if (nums[midpoint - 1] < target){ \n
                   
                   insertionPosition = midpoint; \n
                   
                   finished+=1; \n
                   
                   return insertionPosition; \n
                   
               } \n
           } \n
        
            else if (nums[midpoint] < target) { \n
                        
                startingPoint = midpoint; \n
                
                if (midpoint === nums.length - 1){ \n
                   
                   insertionPosition = nums.length; \n
                    
                    return insertionPosition; \n
               } \n
                
                 else if (nums[midpoint + 1] > target){ \n
                   
                   insertionPosition = midpoint + 1; \n
                   
                   finished+=1; \n
                   
                   return insertionPosition; \n
               } \n
            } \n
else if (nums[midpoint] === target){ \n
                
                finished+=1; \n
                                
                return midpoint; \n                    
            } \n
        } \n 
            
        return insertionPosition; \n
    } \n
    
} newpar,

What I Learned Later On /heading newpar,

Finally, I decided that for the sake of better understanding how binary searches work I would look at another person’s solution. Because it is not my own, I will not include it here. However, I wanted to point out a couple of things that I learned. The first is that one option for the condition to use for when the while loop will run is startingPoint ≤ endPoint. The second is that if the target is greater than the current midpoint, then the startingPoint should not become the current midpoint but instead the current midpoint + 1 (if you are setting the condition to startingPoint ≤ endPoint). Also, if the target is less than the current midpoint, then the endPoint should become not the current midpoint but the current midpoint - 1. newpar,

Example /heading newpar,

For example, if the input array is [1, 2, 4, 7] and the target number is 0, then the first midpoint will be parseInt((3+0) / 2), or 1. The value at nums[1] is 2, and that is higher than the target number; so the new value for the endPoint is 1–1, or 0. That means that the startingPoint and the endPoint are now both 0. The midpoint is also zero, because parseInt((0+0)/2)=0. The value at nums[0] is 1, and that is still higher than the target. So, the new endPoint becomes 0-1, or -1. However, at this point the while loop will not run, because the endPoint is less than the startingPoint. newpar,

The same happens at the other end of the array, if the target number is larger than the greatest value. For example, if the input array is [1, 2, 4, 7] and the target number is 10, the first midpoint is the same as before, 1. The value at nums[1] is 2, which is less than the target; so the startingPoint changes to 1 + 1, or 2. The midpoint is parseInt((3+2)/2), or 2. The value of nums[2] is 4, and that is lower than the target, so the startingPoint becomes 2 + 1, or 3. The startingPoint and endPoint are now both 3. 3+3=6/2=3, so the midpoint is 3. The value at nums[3] is 7, still lower than the target, so the startingPoint becomes 3+1, or 4. However, the startingPoint is now greater than the endPoint, so the while loop exits. newpar,

I am going to call my failure at solving the binary search problem alone an example of being better together. Have a nice weekend! newpar,

")

post_twenty_five= Post.create(title: "On A Witch Hunt", paragraphs: "

./Images/On_A_Witch_Hunt_Image.jpg this-is-an-image newpar,

Yesterday, I attended She’s Coding (Seattle)’s Data Structures and Algorithms practice meeting, and though I was basically helpless at the time, I woke up determined to solve the problem I was supposed to do during the second breakout session. The themes of trust and judgment were too enticing to resist. This might be an example of how the way you name your variables matters. They can motivate you to do the work! newpar,

    This is a practice problem on Leetcode.com called “Find the Town Judge.” A town judge trusts no one and is trusted by everyone. There can only be one judge in town, but it is possible that there is no judge. The trust array that is passed into the findJudge function maps a set of relationships. It is an array of arrays. The person (represented by a number) in the 0 position of each of the arrays in the trust array trusts the person (also represented by a number) in the 1 position of that array. For example, if the array passed into findJudge is [[1, 2], [1, 3], [2, 1], [2, 3]], that means 1 trusts 2 and 3, 2 trusts 1 and 3, and 3 trusts no one but is trusted by both of the others. N = 3 to represent the number of people involved in the trust triangle. In this case, the function returns 3 to signify that 3 is the judge. If there is no judge, then the function returns -1. newpar,

    Below is my brute force solution. For homework, see if you can improve upon it. newpar,

    var findJudge = function(N, trust) { \n
       
    if (N === 1) { \n
        
        return 1; \n
    } \n
       
     else { \n
    
    let i; \n
    
    let arrayForTrusting = []; \n
    
    let arrayForTrusted = []; \n
    
    for(i = 0; i < trust.length; i++) { \n
        
        arrayForTrusting.push(trust[i][0]); \n
        
        arrayForTrusted.push(trust[i][1]); \n  
    } \n
    
    let p; \n
    
    let trustingArray = arrayForTrusting.sort((a, b) => {return (a - b)}); \n
    
    let trustedArray = arrayForTrusted.sort((a, b) => {return (a - b)}); \n
    
    let reducedTrustingArray = []; \n
    
    let reducedTrustedArray = []; \n
    
    for(p = 0; p < trustingArray.length; p++) { \n
        
        if (p === trustingArray.length - 1) { \n
            
            reducedTrustingArray.push(trustingArray[p]); \n
        } \n
        
        else { \n
            
            if(trustingArray[p] !== trustingArray[p + 1]) { \n
                
                reducedTrustingArray.push(trustingArray[p]); \n
            } \n
        } \n
    } \n
    
      for(p = 0; p < trustedArray.length; p++) { \n
        
        if (p === trustedArray.length - 1) { \n
            
            reducedTrustedArray.push(trustedArray[p]); \n
        } \n
        
        else { \n
            
            if(trustedArray[p] !== trustedArray[p + 1]) { \n
                
                reducedTrustedArray.push(trustedArray[p]); \n
            } \n
        } \n
    } \n
    
    let s; \n
    
    let townJudgeSuspectArray = []; \n
    
    for (s = 0; s < reducedTrustedArray.length; s++) { \n
        
        if (!(reducedTrustingArray.includes(reducedTrustedArray[s]))) { \n
            
            townJudgeSuspectArray.push(reducedTrustedArray[s]); \n
        } \n
    } \n
        
    if (townJudgeSuspectArray.length === 0) { \n
        
        return -1; \n
    } \n
    
    else if (townJudgeSuspectArray.length === 1) { \n
        
        let n; \n
        
        let arrayOfTrusters = []; \n
        
        for (n = 0; n < trust.length; n++) { \n
            
            if(trust[n][1] === townJudgeSuspectArray[0]) { \n
                
                arrayOfTrusters.push(trust[n][0]); \n
            } \n
        } \n
        
        
        if (arrayOfTrusters.length === reducedTrustingArray.length) { \n
            
            return townJudgeSuspectArray[0]; \n
        } \n
        
        else { \n
            
            return -1; \n
        } \n 
    } \n
         
         else { \n
             
             return -1; \n
         } \n
     } \n
}; newpar,

If N = 1, then that means there is only one person. This is a weird moment in the code. The problem stipulates that the town judge is trusted by everyone and trusts no one. If no one else is around, it seems reasonable to say that the judge trusts no one, but does it make sense to say that the judge is trusted by everyone if no one else is there? Is being doubted by no one the same as being trusted by everyone? If having faith in the judge matters more than the judge’s aloofness, then I feel like the function should return -1. However, the way I wrote the first condition is what makes it pass on Leetcode, so they must have other ideas. newpar,
After that, I push the numbers in the zero index position of the nested arrays into one array and the numbers in the 1 index position into another array, then sort those arrays, and then reduce them so there are no repeat numbers in either of them. newpar,

Next, I do another for loop to see if any of the trusted numbers are also trusting. If there are numbers that are trusted but not trusting, I push them into the townJudgeSuspect array. If that array ends up having a length of zero, then there is no town judge, and the function returns -1. If there is more than one person who trusts no one, then the function also returns -1, because there can only be one town judge. newpar,

    If the townJudgeSuspect array has a length of one, then I check to see whether all of the other people trust this person, or whether only some of them do. If all of them do, then the judge’s number is returned. Otherwise, the function returns -1, and those who have either a healthy or unhealthy skepticism rule the day . newpar,

        https://www.youtube.com/embed/x3DZLldBY7o newpar,

        https://www.youtube.com/embed/8TOBzT-1LfU newpar,
    



")

post_twenty_four= Post.create(title: "Pointers and Common Prefixes in JavaScript", paragraphs: "

./Images/Exit.jpg this-is-an-image newpar,

Last night I finally went to the Data Structures and Algorithms practice hosted on-line by She’s Coding (Seattle) and learned about using pointers to write an algorithm. It was extremely helpful! And it led me to return to LeetCode this morning to try to apply what I learned to another problem. The one I ended up doing prompted me to create a function to return the longest common prefix amongst items in an array. I love the examples they give for input arrays! newpar,

Examples /heading newpar,

./Images/Prefix_Problem.png this-is-an-image newpar,

This is one that I came up with to add to the fun: newpar,

./Images/Prefix_Example.png newpar,

Initializing Variables/Pointers /heading newpar,

In coming up with a solution, I tried to apply my newfound knowledge of pointers. I used three of them to point to different places in the array and to different places within each string. These are the variables at the beginning of the function: newpar,

this-is-code-in-blog
let prefix = ""; \n
    
let i = 0; \n
    
let p = (strs.length) - 1; \n
    
let n = 0; \n
        
let maximumLength = 0; newpar,

The prefix is what will be returned at the end of the function. The maximumLength will be the length of the shortest word in the array, which I get by doing a for loop like this: newpar,

for (let h = 0; h < strs.length; h++) { \n
        
        if (maximumLength === 0) { \n
            
            maximumLength = strs[h].length; \n  
        } \n
        
        else { \n
            
            if (strs[h].length < maximumLength) { \n
                maximumLength = strs[h].length; \n
            } \n
        } \n
    } newpar,

    The reason for getting the length of the shortest word is that the longest common prefix cannot be longer than the shortest word in the array. Getting this value and specifying it as the condition for the while loop I am about to do allows me to exit the program when the maximumLength is reached. newpar,

        Checking for Matches /heading newpar,

        This is the while loop where the function checks the letters in the first word in the array against the letters in the corresponding places for the words in other positions in the array. newpar,

        if (strs.length === 1) { \n
        
        prefix = strs[0]; \n
        return prefix; \n
        
    } \n
    
    else{ \n
while (n < maximumLength) { \n
                
        if (strs[i][n] === strs[p][n]) { \n  
            
            if (p === i + 1) { \n
                
                prefix+=strs[i][n]; \n
                n++; \n
                p = (strs.length) - 1; \n
            } \n
            
            else { \n
            
            p--; \n
          
            } \n
        } \n
             
        else { \n
            
           n = maximumLength; \n
            
            } \n
        } \n
        
    return prefix; \n
        
    } newpar,

    The first ‘if’ statement checks to see if the length of the array is 1. If it is, then the program returns the string stored there. Otherwise, it executes the block of code in the ‘else’ statement. As long as the value of n is less than the length of the shortest word in the array, the while loop runs. The first letter in the first string in the array is checked against the first letter in the last string in the array. strs[i] is the item in the first position of the array when ‘i’ is 0, and strs [i][n] is the first letter in the first item when ‘n’ is also 0. strs[p][n] is the first letter of the last item in the array when the value of ‘p’ is set to the length of the array minus one and the value of ‘n’ is set to 0. newpar,

    If the first letter in the first and last words matches, then it decrements ‘p’ to check the first letter in the second to last string in the array, and so on until there either is a letter that does not match or the value of p is i + 1. If p is i + 1, then that means the pointer has made it through the whole array. In that case, the words in the array all share this letter. At that point, the function adds that common letter to the variable ‘prefix’, and it moves the ‘p’ pointer back to the last word in the array while incrementing ‘n’ to move on to the second letter in the string. This process repeats until either ‘n’ is equal to the maximumLength or there is a letter that does not match. At that point, what is stored in ‘prefix’ is what the program returns before exiting. newpar,

    Example /heading newpar,

    For example, if the input array is [‘cave’, ‘cavil’, ‘camera’], then the while loop will run twice to add ‘c’ and ‘a’ to ‘prefix’. When the ‘v’ in ‘cave’ is checked against the ‘m’ in ‘camera’ on the third loop and found to not be a match, ‘n’ is incremented to the maximumValue to force the while loop to exit. Then the prefix ‘ca’ is returned. newpar,

    Other words that start with ‘ca’ include ‘carlie’, ‘care’, and ‘cat’. Have a good weekend, and as my grandma sometimes says before getting off the phone with me, be good. newpar,

    https://www.youtube.com/embed/kfSQkZuIx84 newpar,

")

post_twenty_three= Post.create(title: "How To Render Images In A React App", paragraphs: " 

./Images/On_The_Wall.jpg this-is-an-image newpar,

When I first started to render images in a React application, I remember being mystified about why an image might have to be required instead of imported like a component. Below are some examples of different ways of displaying an image on a page with explanations of what works and what does not. newpar,

For a more theoretical overview of what the require method does, you could start here: newpar,

https://nodejs.org/en/knowledge/getting-started/what-is-require/ /anchor newpar,

Or to learn more about imports, you could go here: newpar,

https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Statements/import /anchor newpar,

Use Require /heading newpar,

To use images in a React application, I start out by making a directory called 'Images' in the src directory and then dragging and dropping image files from my computer into it. Then, when I want an image to appear in a particular place on the page, there are a few different options for getting it to show up. newpar,

One option is to use require() with the file name between the parentheses. If you use this method, then you do not have to import the file. For example, for my portfolio website, I have a profile photo that I display on the home page using an HTML <img> tag like this: newpar,


<img className='profile-photo' src={require('./Images/Profile_picture.jpeg')} alt={'Carlie Anglemire'}/> newpar,

The src here is a file path that is being required. This is the way it displays on the page (photo credit goes to my husband, who said a lot of silly things to get me to smile): newpar,

./Images/With_Require.jpg this-is-an-image newpar,

If I did not include require() and only typed in the file path as the src, like this: newpar,

<img className='profile-photo' src='./Images/Profile_picture.jpeg' alt={'Carlie Anglemire'}/> newpar,

Or this: newpar,

<img className='profile-photo' src={'./Images/Profile_picture.jpeg'} alt={'Carlie Anglemire'}/> newpar,

The result would have been this: newpar,

./Images/No_Require.jpg this-is-an-image newpar,

Importing Image Files /heading newpar,

Another way of displaying an image is by importing it and then using it where you need it on the page. For example, at the top of the component, I could import it like this: newpar,

this-is-code-in-blog  
import ProfilePicture from './Images/Profile_picture.jpeg'; newpar,

What I name the file path when I import it does not matter as long as I use the same name when I reference it later on in the component. Where I was using require() before, I can then use 'ProfilePicture' instead to get the same result: newpar,

<img className='profile-photo' src={ProfilePicture} alt={'Carlie Anglemire'}/> newpar,

Which One Should I Use? /heading newpar,

While the results are the same, if you are using a lot of images in your component, it might get tedious importing them all at the top and then referencing them one by one where you want them to display. I found using require() useful when I wanted to render an image dynamically instead of hard-coding the file path. newpar,

For example, for the blog posts on my website, there are a number of images stored on the front end. On the back end, I have a model called Post for blog posts. Post has a few attributes, including a paragraphs attribute where I keep the content for the post (all text and markup for where I want images to display). When I want a particular image to display in a post, I include the file path where that image is on the front end, and then that file path is plugged into a require() in the way that I described above for the profile image. On the Ruby on Rails back end, I would have something like this: newpar,

this-is-code-in-blog
./Images/Bad_Connection.jpg newpar,

The tag newpar signifies the end of a paragraph so that the image will be set off from the text that follows it. In the code on the front end, paragraph would be ./Images/Bad_Connection.jpg in this case. I added trim() to get rid of leading and trailing whitespace. paragraph is not something that is imported at the top of the file. It is part of the data fetched from the back end and stored in state in the parent component, then passed down to other components that need access to it. newpar,

else if (paragraph.includes('./Images/')) {
    return <img className='screenshots-for-blog' src={require(`${paragraph.trim()}`)} alt={paragraph} />
    } newpar,

The result of this is that paragraphs being mapped over that include ./Images/ will be rendered with an <img> HTML tag and with the file path required. newpar,

Web Addresses for Images /heading newpar,

While it is not possible to only give the file path without the require method for an image stored on the front end that is not imported at the top of the component, this is something that you can do if you are referencing an image somewhere on the internet. For example, the New York Public Library Digital Collections has a nice picture of a Siberian Wallflower that I might want to use as my new avatar! newpar,
   
./Images/Siberian_Wallflower.jpg this-is-an-image newpar,

To get it to display like this: newpar,

./Images/Carlie_Anglemire_Siberian_Wallflower.jpg this-is-an-image newpar,

I can include the image like this: newpar,

<img className='profile-photo' src='https://images.nypl.org/index.php?id=1589457&t=w' alt={'Carlie Anglemire'}/> newpar,

In that case, everything displays fine and no require() or import is needed. newpar,

https://www.youtube.com/embed/qchPLaiKocI newpar,

")

post_twenty_two= Post.create(title: "Blurred Images", paragraphs: "

./Images/Blurred_Images.jpg this-is-an-image newpar,


Recently, while completing a function in C, my task was to average the red, green, and blue values of each pixel and its surrounding pixels in a bitmap in order to make an image appear blurry. A two-dimensional array called ‘image’ was passed into the function with its height and width specified, and it had to be looped over to transform each pixel. The average I had to find was of the color values for each pixel within one row and one column of the pixel currently being transformed in the loop. newpar,

https://cs50.harvard.edu/x/2020/psets/4/filter/less/ /anchor newpar,

That meant that if the pixel was in one of the corners of the two-dimensional array (think of a square four columns long and four columns wide, for example) then the average would be of the values of four pixels. If the pixel was on an edge, then it would be of six pixels. If it was neither a corner nor an edge, then it would be of nine pixels (including the pixel with the value to be transformed, the one to the left of it, the one to the right, the one directly below it, the one above it, and the ones diagonal to the left and right in the rows above and below it, forming a square of 3 x 3 inside the original image). newpar,

Making a Copy /heading newpar,

One of the first things I had to do was to create an empty nested array that would store values to be used to transform the image later on. The reason I had to do this was because if I transformed the color values in the array directly, then the averages taken as the loop proceeded would be of these transformed values and not the original ones. The third array below has a length of three, because that is where the new color values will be stored, with the average amount of red in the 0 position, blue in the 1 position, and green at the 2 index position. At the end of the function, once finalArray is full of the new values taken from the averages, ‘image’ is looped over again, and the color values stored in finalArray take the place of the original values. newpar,

this-is-code-in-blog  
int finalArray [height][width][3]; newpar,

Loop the Loop /heading newpar,

The function starts with an initial nested loop; the outside ‘for loop’ is set up like this: newpar,

this-is-code-in-blog
for (int i = 0; i < height; i++) newpar,

and the inner loop starts with: newpar,

this-is-code-in-blog
for (int p = 0; p < width; p++) newpar,

The inner loop allows each item in the row to be looped over before the outer loop moves on to the next column. newpar,

Specifying the Conditions /heading newpar,

After trial and error, I broke the problem down into three main if/else statements with more if/else if statements nested inside of them. newpar,

The first condition was newpar,

this-is-code-in-blog
if (p == 0) newpar,

and then inside of that condition there were three more: newpar,

this-is-code-in-blog
if (i == 0) \n
else if (i == height - 1) \n
else if (0 < i < height - 1) newpar,

If ‘p’ and ‘i’ are both zero, that means the loop is on the top left corner. If ‘p’ is zero and ‘i’ is height - 1, then the loop is on the bottom left corner. If ‘p’ is zero and ‘i’ is greater than one but less than the height minus one, then the loop is on the top edge. newpar,

This pattern continues with the two other conditions (p == width - 1 for the next one, and 0 < p < width - 1 for the one after that) and their own nested if/else if statements to cover the whole bitmap. newpar,

This is the first ‘if’ statement, with all of the variables having been initialized earlier on. The variables ‘middleRed’, ‘middleBlue’, and ‘middleGreen’ are the same for all of the conditions here and later in the function, because they are for the current pixel in the loop. That is why they come before the first ‘if’ statement — so they have a wider scope. newpar,

middleRed = image[i][p].rgbtRed; \n
middleBlue = image[i][p].rgbtBlue; \n
middleGreen = image[i][p].rgbtGreen; \n
if (p == 0) \n
            { \n
                rightRed = image[i][p + 1].rgbtRed; \n
                rightBlue = image[i][p + 1].rgbtBlue; \n
                rightGreen = image[i][p + 1].rgbtGreen; \n
bottomRightRed = image[i + 1][p + 1].rgbtRed; \n
                bottomRightBlue = image[i + 1][p + 1].rgbtBlue; \n
                bottomRightGreen = image[i + 1][p + 1].rgbtGreen; \n
topRightRed = image[i - 1][p + 1].rgbtRed; \n
                topRightBlue = image[i - 1][p + 1].rgbtBlue; \n
                topRightGreen = image[i - 1][p + 1].rgbtGreen; \n
belowRed = image[i + 1][p].rgbtRed; \n
                belowBlue = image[i + 1][p].rgbtBlue; \n
                belowGreen = image[i + 1][p].rgbtGreen; \n
aboveRed = image[i - 1][p].rgbtRed; \n
                aboveBlue = image[i - 1][p].rgbtBlue; \n
                aboveGreen = image[i - 1][p].rgbtGreen; \n
//top left corner \n
                if (i == 0) \n
                { \n
                    averageRed = (middleRed + rightRed + bottomRightRed + belowRed) / 4.0; \n
                    averageBlue = (middleBlue + rightBlue + bottomRightBlue + belowBlue) / 4.0; \n
                    averageGreen = (middleGreen + rightGreen + bottomRightGreen + belowGreen) / 4.0; \n
                } \n
//bottom left corner \n
                else if (i == height - 1) \n
                { \n
averageRed = (middleRed + rightRed + topRightRed + aboveRed) / 4.0; \n
                    averageBlue = (middleBlue + rightBlue + topRightBlue + aboveBlue) / 4.0; \n
                    averageGreen = (middleGreen + rightGreen + topRightGreen + aboveGreen) / 4.0; \n
                } \n
//left side edge \n
                else if (0 < i < height - 1) \n
                { \n
                    averageRed = (middleRed + rightRed + bottomRightRed + topRightRed + aboveRed + belowRed) / 6.0; \n
                    averageBlue = (middleBlue + rightBlue + bottomRightBlue + topRightBlue + aboveBlue + belowBlue) / 6.0; \n
                    averageGreen = (middleGreen + rightGreen + bottomRightGreen + topRightGreen + aboveGreen + belowGreen) / 6.0; \n
                } \n
} newpar,

Then, later on in the function, the averageRed, averageBlue, and averageGreen values for the pixel are rounded and added to finalArray. newpar,

this-is-code-in-blog
finalArray[i][p][0] = round(averageRed); \n
finalArray[i][p][1] = round(averageBlue); \n
finalArray[i][p][2] = round(averageGreen); newpar,

Final Loop /heading newpar,

After all of ‘image’ has been looped over and ‘finalArray’ is full, then another nested loop that has the same structure as the one before runs to set the values of red, blue, and green in ‘image’ equal to the averaged value stored in the corresponding position in finalArray. newpar,

for (int v = 0; v < height; v++) \n
{ \n
for (int l = 0; l < width; l++) \n
{ \n
image[v][l].rgbtRed = finalArray[v][l][0]; \n
            image[v][l].rgbtBlue = finalArray[v][l][1]; \n
            image[v][l].rgbtGreen = finalArray[v][l][2]; \n
} \n
} newpar,

And voila! You now have a blurry picture. But this time it was intentional. newpar,


")

post_twenty_one= Post.create(title: "Learning Java", paragraphs: "A couple of weeks ago, I had the task of starting to learn Java to complete a coding challenge. My instructions were to create a function to take in an input and then print out a set of statistics about the information entered. The statistics included the median, mean, and maximum and minimum values of a set of numbers. They also included the number of errors — errors being any inputs that were not positive integers. newpar,

Resources /heading newpar,

First, there were A LOT of resources that I consulted to approach this challenge, actually too many to enumerate. The first place I went was to the New York Public Library to get free access with the use of my library card to Lynda.com. On Lynda.com, I followed along with Kathryn Hodge’s tutorial Learning Java. For that course, she had us download the IntelliJ IDEA, which helped me to test code in an easy way as I got acquainted with Java for the first time, before starting to run programs on the command line after compiling. I also downloaded Java from Oracle. newpar,

User Input /heading newpar,

When I work with JavaScript to build applications, user input mainly comes into play when there are forms. There are input fields or text areas, for example, where a user types in information that is processed when the submit button is clicked. A user’s actions are also recorded by event listeners that read when a user clicks on something like a button or hovers over an element on the page, etc. There are a lot of ways that our computers are listening to us, whether or not they really hear what we are trying to say. newpar,

For the Learning Java course, the way I was listening to the user was by prompting the user for information before a scanner read the input and printed out a response. Following the model of the work I did for the course, I started out my approach to the coding challenge by also putting prompts and a scanner to work to read input. This was helpful for testing purposes and to gain familiarity with the language before implementing my second solution, which involved reading input directly from the command line and passing that information into the main function as an array of strings. newpar,

Compiling Code and Running the Program /heading newpar,

this-is-code-in-blog
javac Main.java newpar,

In the class I have been taking that I keep plugging, the instructor informed us that compiling code changes it from source code into the binary language of zeroes and ones that computers understand. At some point in history way back when, poor unfortunate souls actually had to code in zeroes and ones. We, if we are using Java, just have to compile. So, while I am missing JavaScript, I will keep that in mind and be grateful for what I have. newpar,


https://www.youtube.com/embed/Gi58pN8W3hY newpar,

See, it could be a lot worse. newpar,

Anyway, then after compiling I can run the file by typing newpar,

this-is-code-in-blog
java Main.java newpar,

However, right after the file name, you also enter input to be passed into the function as an array of strings. For example, that might look like the following, which includes three examples. newpar,

./Images/Learning_Java_Photo.jpg this-is-an-image newpar,

In the first case, the errors amount to 2, because ‘rf’ and ‘t’ are not numbers. The count includes the number of valid input values. The invalid input is not considered in determining the minimum, maximum, median, and mean. Likewise, in the second example, -4 is not a positive integer, so it is marked as an error and not included in the other calculations. The count is 4 to reflect the number of valid inputs. newpar,

Behind the Scenes /heading newpar,

So, that is what happens on the command line, but what is going on behind the scenes? newpar,

First, the whole function is wrapped in newpar,

public class Main {  newpar,


and then on the first line the string of arguments is passed in, like this: newpar,

public static void main(String[] args) { newpar,

What the parameters between the parentheses indicate is that the input will be turned into an argument of strings. The user enters characters on the command line separated by spaces, and the function does the work for you of trimming all of the white space and separating the values into strings in an array (kind of like in the split method in JavaScript except for the trimming of white space). When I was using a scanner to read input, I had to do all of that work myself, so I appreciated that it was done for me when I switched to using a function that read standard input in this way. newpar,

Next, the function checks for the number of arguments that the user entered. If there were zero arguments — because the user just hit enter or the space bar after typing in the file name — then this is what would happen: newpar,

if (args.length == 0){ \n
System.out.println('Count: n/a'); \n
System.out.println('Min: n/a'); \n
System.out.println('Max: n/a'); \n
System.out.println('Mean: n/a'); \n
System.out.println('Median: n/a'); \n
System.out.println('Errors: 1'); \n
} newpar,

Here, args is the array of strings. We are able to take the length of args, and if it is equal to zero, the program can print out the above and quickly exit. newpar,

If there is only one argument entered, then the statistics are also pretty simple to calculate, so this was another opportunity for the program to quickly exit. The following code handles that case. I also included notes to help explain what is happening in the code. newpar,

// If only one piece of input is entered, then the program checks whether it is a non-digit. \n
else if (args.length == 1) { \n
char[] singleArgArray = args[0].toCharArray(); \n
boolean includesNonDigits = false; \n
for (int f = 0; f < singleArgArray.length; f++) { \n
if (!(Character.isDigit(singleArgArray[f])) || singleArgArray[f]== ' ') { \n
includesNonDigits = true; \n
} \n
} \n
// If it is a non-digit, then the output is the following. \n
if (includesNonDigits) { \n
System.out.println('Count: n/a'); \n
System.out.println('Min: n/a'); \n
System.out.println('Max: n/a'); \n
System.out.println('Mean: n/a'); \n
System.out.println('Median: n/a'); \n
System.out.println('Errors: 1'); \n
} \n
//If it is not a non-digit, then the count is 1, errors are 0, and the min, max, mean, and median are \n
//all the same number, with the mean and median rounded to the nearest hundredth place. \n
else { \n
long theFinalCount; \n
if(args[0] == '0'){ \n
theFinalCount = 0; \n
} \n
else{ \n
theFinalCount = Math.abs(Long.parseLong(args[0])); \n
} \n
double theMean = theFinalCount * 1.00; \n
double theMedian = theFinalCount * 1.00; \n
System.out.println('Count: ' + args.length); \n
System.out.println('Min: ' + args[0]); \n
System.out.println('Max: ' + args[0]); \n
System.out.printf('Mean: %.2f', theMean); \n
System.out.printf('Median: %.2f', theMedian); \n
System.out.println('Errors: 0'); \n
} \n
} newpar,

Because there was only one item in the array, I was able to turn it into an array of characters (again, like splitting a string down into individual characters in JavaScript) and then loop through the characters and ask of each one of them whether or not they were a digit using the Character.isDigit() method. I set a boolean called includesNonDigits to false to begin with. Then, as the characters are looped through, that boolean changes to true and stays true if any of the characters are not digits. After that, directions are given about what to do in the case that includesNonDigits is true versus in the case that it is false. If it is true, then the output is the same as it was when the user typed in zero arguments. newpar,

If it is false, then the mean, median, maximum, and minimum are all the same number, which is the string in args parsed into a long (that is like an integer but can store larger numbers — and this is like ParseInt() in JavaScript but for bigger numbers). The mean and median are rounded to the nearest hundredth place by multiplying the parsed long value by 1.00. Then, the median and mean are printed out using System.out.printf() with the number of decimal points to be printed specified by the ‘.2’ in ‘%.2f’. ‘%.2f’ with the comma and the variable ‘theMedian’ following it is the way of interpolating a value to output. ‘%f’ stands in for a float value, and theMedian is that value. This is similar to doing string interpolation in C. newpar,

For the rest of the function, I do something similar, but I have other variables to get the count, number of errors, minimum, maximum, and some other information as I loop through the strings in args. The next part of the function looks like this: newpar,

else { \n
    long count = 0; \n
    long total = 0; \n
    long min = Long.MAX_VALUE; \n
    long max = 0; \n
    int errors = 0; \n
    long areAllNonPositiveIntegers = 0; \n
    //A for-loop runs to calculate information about the input. \n
    for (int m = 0; m < args.length; m++) { \n
    //First, the string at args[m] is broken down into an array of characters. \n
    //Then that array of characters is looped over to check whether args[m] contains any non-digits. \n
    char[] thisArray = args[m].toCharArray(); \n
    boolean areNonDigits = false; \n
    for (int v = 0; v < thisArray.length; v++) { \n
    if (!(Character.isDigit(thisArray[v]))) { \n
    areNonDigits = true; \n
    } \n
    } \n
    //If args[m] does not contain any non-digits, then it is parsed as a long. \n
    if (!areNonDigits) { \n
    long num = Long.parseLong(args[m]); \n
    //Then, the function checks whether it is a positive integer. \n
    //If it is, then num is added to the total to be used later to calculate the mean, \n
    //and the count, which adds up the number of valid input items, goes up by one. \n
    //I also add one to the variable areAllNonPositiveIntegers, which will be useful later. \n
    if (num > 0) { \n
    total+=num; \n
    count += 1; \n
    areAllNonPositiveIntegers += 1; \n
    if (num < min) { \n
    min = num; \n
    } \n
    if (num >= max) { \n
    max = num; \n
    } \n
    } \n
    //If num is not greater than zero, then args[m] is counted as an error. \n
    else { \n
    errors += 1; \n
    } \n
    } \n
    //If there are non-digits in args[m], then args[m] is counted as an error. \n
    else { \n
    errors += 1; \n
    } \n
    } newpar,

    I loop through args and then break down each string into an array of characters, just like I did when there was only one item in the array. newpar,

    Then, I process information about each of those characters. For example, if it is a non-digit or a non-positive integer, then that string in args is marked as being an error and is not included in the count of valid integers. newpar,

    If the string does not include any invalid characters, then it is parsed into a long and if that long is a positive integer it is added to the total. The total will be used later when it is divided by the count to get the mean of the valid input. If a string that has no invalid characters, has been parsed into a long, and is a positive integer is greater than the current maximum then it becomes the new maximum value. If it is less than the current minimum value, then it becomes the new minimum. That way, by the time the loop has completed, we will have the minimum and maximum values for the output. By the time the loop completes, we will also have the final count of the number of valid input values and the number or errors. newpar,

    Something else that happens during this loop is that the variable ‘areAllNonPositiveIntegers’ goes up by one whenever a string in args does not include an invalid character. This variable will be used later on in the following way: if ‘areAllNonPositiveIntegers’ is equal to 0 at the end of the loop, then that means all of the input values were invalid. If that is the case, then the number of errors will be equal to the number of values that were input, and the rest of the values will be n/a. The program can exit at that point. newpar,

    Otherwise, to get the mean and median values of the valid input… we have more work to do. For such a simple set of statistics, this is feeling like a lot! But once the function is set, we can pass in a lot of information, and it will be processed for us. Work done upfront can save time later on. If you need to get this same set of statistics over and over again, it is easier to write the function and then plug in the values to run repeatedly. Computers don’t have emotions; they can handle the stress of that repetition! newpar,

    Summary of the Remainder of the Function /heading newpar,

    Because I have already bombarded you with too much code, I will summarize what the rest of the function does. newpar,

    I initialize a new array with a length of args.length minus the number of errors. I then loop through args all over again and loop through each of the characters in the strings to check whether there are any non-digits. If there are no non-digit/non-positive-integers in the current string, then the next item in the new array is set to the parsed (into a long) value of this string. The while loop continues until the array is full. If I was doing this in JavaScript, I would have been able to initialize an empty array along with the ‘count’, ‘errors’, ‘minimum’, and ‘maximum’ variables and pushed items into it while doing the earlier loop through args. But Java (and C) require that you specify the number of items in the array upon initialization, so that is why I had to do a separate loop — the function does not know how long the array of valid input will be until it determines the number of errors during that initial loop. newpar,

    After all that, you are able to get the median and the mean of the array of valid numbers in ways that you can imagine and that I will not bore you with by spelling out! newpar,

    Now, go use those statistics to do some sort of good deed. newpar,
")

post_twenty=Post.create(title: "Conditional Rendering in React", paragraphs: "./Images/What_If.jpg this-is-an-image newpar,

Although using JSX to build the front-end of applications in React allows me to write JavaScript more quickly, something that I have had to overcome is my desire to write out if/else statements in the render method of class components. The render method only accepts ternary expressions, and although they can be nested to your heart’s content, it can get very messy with a long breadcrumb trail of question marks and colons. newpar,

What I have been doing to solve this problem is writing more functions above the render method in class components that return smaller pieces of JSX. Then, I can write another function whose sole responsibility is to spell out all the conditions for when to call the other functions that execute a particular block of code. Lastly, this “deciding” function that makes judgments about what to return can be called in the render method. Though I still end up using ternary expressions in the render method, this allows me to do it a little less often to keep things more under control as the if’s and else’s of the application multiply. newpar,

    First solution /heading newpar,

    For example, I might write a function like this that returns a span with some other things inside of it. newpar,

    forNewListingSubmitted=()=>{ \n
return <span className='submitted-new-listing-container'> \n
<i role='img' className='submitted-new-listing-icon'>&#10004;</i> \n
<h1>Your listing has been submitted.</h1> \n
<button id='return-to-listings' onClick={this.props.returnToListingsIndex}>Return to Listings</button> \n
</span> \n
} newpar,

Other functions in the same class could return different spans, like these. newpar,

forNewDirectRequestsToDonate=()=>{ \n
return <span className='submitted-new-listing-container'> \n
<i role='img' className='submitted-new-listing-icon'>&#10004;</i> \n
<h1>Your donation has been submitted.</h1> \n
<p>When the requestor approves the submission, further directions will be provided for exchange.</p> \n
<button id='return-to-listings' onClick={this.props.returnToListingsIndex}>Return to Listings</button> \n
</span> \n
} \n
forNewDirectRequestsForItems=()=>{ \n
return <span className='submitted-new-listing-container'> \n
<i role='img' className='submitted-new-listing-icon'>&#10004;</i> \n
<h1>Your request has been submitted.</h1> \n
<p>When the donor approves the request, further directions will be provided for exchange.</p> \n
<button id='return-to-listings; onClick={this.props.returnToListingsIndex}>Return to Listings</button> \n
</span> \n
} newpar,

And then a third function would make the decision about which of those functions to call. That looks like this: newpar,
chooseWhichToRender=()=>{ \n
if(this.props.createdANewListing){ \n
return this.forNewListingSubmitted() \n
} \n
else if(this.props.newDirectRequestForItem){ \n
return this.forNewDirectRequestsForItems() \n
} \n
else{ \n
return this.forNewDirectRequestsToDonate() \n
} \n
} newpar,

Separating the logic out makes the class a little more organized and easy to follow. The final render method can then be as follows: newpar,

render(){ \n
return( \n
this.chooseWhichToRender() \n
) \n
} newpar,

It doesn’t get much easier than that! Though in this case the render method just has one function call, in other cases I might have more JSX that is rendered unconditionally, some ternary expressions, other components, or more function calls. This happens to be a simpler component, so it can serve to highlight the separation of concerns that I wanted to focus on. newpar,

Second Solution /heading newpar,

Actually, now that I think of it, another way to write the above which is a little D.R.Y.er is: newpar,

forNewListingSubmitted=()=>{ \n
return <h1> Your listing has been submitted.</h1> \n
} \n
forNewDirectRequestsForItems=()=>{ \n
return <React.Fragment> \n
<h1>Your request has been submitted.</h1> \n
<p>When the donor approves the request, further directions will be provided for exchange.</p> \n
</React.Fragment> \n
} \n
forNewDirectRequestsToDonate=()=>{ \n
return <React.Fragment> \n
<h1>Your donation has been submitted.</h1> \n
<p>When the requestor approves the submission, further directions will be provided for exchange.</p> \n
<React.Fragment> \n
} \n
chooseWhichToRender=()=>{ \n
if(this.props.createdANewListing){ \n
return this.forNewListingSubmitted() \n
} \n
else if(this.props.newDirectRequestForItem){ \n
return this.forNewDirectRequestsForItems() \n
} \n
else{ \n
return this.forNewDirectRequestsToDonate() \n
} \n
} \n
render(){ \n
return( \n
<span className='submitted-new-listing-container'> \n
<i role='img' className='submitted-new-listing-icon'>&#10004;</i> \n
{this.chooseWhichToRender()} \n
<button id='return-to-listings' onClick={this.props.returnToListingsIndex}>Return to Listings</button> \n
</span> \n
) \n
} newpar,

This has more in the render method, because the parts that do not change based on any conditions are there so that I do not have to repeat the same lines over and over. However, the functions that return smaller parts of code that are only rendered under certain conditions work in the same way, just returning less code. The “deciding” function doesn’t change at all. newpar,

    Third Solution /heading newpar,

    You could also combine the four functions above the render method into one to look like this: newpar,

    chooseWhichToRender=()=>{ \n
if(this.props.createdANewListing){ \n
return <h1> \n
Your listing has been submitted.</h1> \n
} \n
else if(this.props.newDirectRequestForItem){ \n
return <React.Fragment> \n
<h1>Your request has been submitted.</h1> \n
<p>When the donor approves the request, further directions will be provided for exchange.</p> \n
</React.Fragment> \n
} \n
else{ \n
return <React.Fragment> \n
<h1>Your donation has been submitted.</h1> \n
<p>When the requestor approves the submission, further directions will be provided for exchange.</p> \n
</React.Fragment> \n
} \n
} \n
render(){ \n
return( \n
<span className='submitted-new-listing-container'> \n
<i role='img' className='submitted-new-listing-icon'>&#10004;</i> \n
{this.chooseWhichToRender()} \n
<button id='return-to-listings' onClick={this.props.returnToListingsIndex}>Return to Listings</button> \n
</span> \n
) \n
} newpar,

And there you have it! Three ways to do the same thing. newpar,

    In the spirit of hoping and wishing that what you want to conditionally render will in fact appear when and where you want it to, this song came to mind. It also conveys some of the suspense and struggle of my first Hackathon, which I just (barely) survived. newpar,

    https://www.youtube.com/embed/eLU_woRD8Dg newpar,


")

post_nineteen=Post.create(title: "The Elephant in the Room", paragraphs: "In switching computers for the first time as a developer, I have been experiencing what it is like to have to set up my coding environment all over again. What I have mainly learned from this is how much I do not know, which is always a bewildering realization. There is still a lot of work for me to do, and this post is not going to be a success story. Actually, I just want to share one line of code, and it is related to using PostgreSql as a database for a Ruby on Rails API. newpar,
    
While trying to complete the task of setting up my environment, I have also been working on getting my portfolio site up again after being dissatisfied with the initial deployment of it. Because of issues transferring data from one computer to another — at one point I spent a half an hour on hold with Apple Support just to ask how long I might theoretically need to wait for the Migration Assistant to finish before deciding that it wasn’t working — I ended up recreating the backend for my website. When I tried to use PostgreSql as the database, I got an error that said something like: 'PG::ConnectionBad: fe_sendauth: no password supplied.' One of the things that was so confusing about this was that because I had just installed postgres on the new computer, I thought that it meant I had not installed it correctly, that I had overlooked some detail that mattered more than I could know. Where it was that I needed to enter the password that had not been supplied was a mystery to me. newpar,

./Images/Bad_Connection.jpg this-is-an-image newpar,

To make a long story short, the mistake was actually familiar, just not one that I had made in awhile. What I needed to do after creating the new Ruby on Rails API with a PostgreSql database and cd’ing into that directory was to enter newpar,

    this-is-code-in-blog
    rails db:create newpar,

    before I could migrate. newpar,

    That was it. newpar,

    This is the blog that included that detail and pointed me in the right direction: newpar,

    https://dev.to/rob__race/setting-up-rails-and-postgresql-5c0k /anchor newpar,

    The reason it did not occur to me to first create the database before migrating was that Ruby on Rails uses sqlite3 as its default database, and when using the default you skip this step. newpar,

    I am tempted to make a connection here. My old computer started to show its age due to its memory being strained after seven years of being crammed with a lot of little things that it was too late for me to go back and delete. I scrambled to rid myself of the detritus that I had accumulated to no avail. Then, once I had acquired a new computer, with all of the other things going on in life, I forgot the one small detail that everything else depended on. I will leave you to draw your own conclusions about what this all means. newpar,
    
    ")

post_eighteen=Post.create(title: "Binary Search", paragraphs: "For the last few days, I have been working on binary searches to take a step in the direction of decreasing runtime and writing better-designed code as I learn more about Big O notation. This is a function that takes in an input of an array of numbers and an integer. It searches the array to see if the integer ‘n’ is present in the array. It does not need to know whether it is repeated and how many times it appears, just whether it is there at all. newpar,

The first condition, which is actually the last part of the code that I wrote, is to check the length of the input array. If it is less than or equal to zero, then the function exits, returning ‘false’ to signify that the number is not present. The reason I added this is because I have discovered that doing a binary search on an empty array gets me stuck in an infinite loop. It is kind of like asking nothingness what its name is. I believe that the importance of providing an appropriate exit condition for a loop was mentioned at least in passing in a recent lecture on the subject of algorithms, but there are certain mistakes I have to make approximately 50 times before I begin to understand them. As a result, my computer has been through a lot lately. newpar,

https://cs50.harvard.edu/x/2020/weeks/3/ /anchor newpar,

The next step is sorting the array, because the goal of a binary search is to start from the middle, check the median against the target number, and if there is not already a match then determine which half of the array can be ignored. If the median on the first round is greater than the target number, then the right half of the array, which would contain values above the median, are eliminated, while the left half is searched. If the array is unsorted then there is no way of making the determination that either half of the array can be eliminated. newpar,

The Variables /heading newpar,

There are a number of variables initialized at the beginning of the function, including a startPoint, an endPoint, a subArray, a variable called ‘finished’, and a median. The subArray is initially a copy of the sortedArray, but its value will be reset later in the function, as will all of the other values except for sortedArray. I want to preserve the original sorted array but also use a subArray to indicate which section of the sortedArray should be searched as the loops go on. The startPoint gives the index of sortedArray where the binary search should begin, and the endPoint gives the index of where subArray, or the section of the array that is currently being searched, should end. Keeping sortedArray intact allows me to give the indexes for the start and finish points for the subArray. newpar,

For example, if the input array is [9, 1, 4, 2, 7] and the target number is 9, the sortedArray will be [1, 2, 4, 7, 9]. Before I explain the rest of the code, I will just go through this in English. The median of the sortedArray is 4. 4 is not equal to the target value of 9, so all of the numbers between 1 and 4 are ignored at this point, and the values above 4 are searched on the next loop. Having the sortedArray intact allows me to specify this by setting the value of the startPoint to one index position higher (if there is one higher) than the current median of 4, or startPoint = median+1, which will translate to sortedArray[3], the item at the third index position of sortedArray. So, 7 becomes the new startPoint, and the endPoint remains the same, the last index position in the sortedArray, with the value of 9. newpar,

Finding the SubArray /heading newpar,

The subArray is set using slice(), which takes one integer of the index where the slice begins and another integer of the index where it ends — the second index, or the end point, is actually for the index position AFTER where you want to stop. If the subArray you want to examine is [7, 9] in the example above, that would be found using subArray.slice(3, 5). subArray is an array of the items that will be part of the next loop’s search, but the start and end points will be used independently of the subArray to find the median. That might sound confusing, so I will give another example to help explain it. newpar,

https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array/slice /anchor newpar,

Say we are calling binarySearch with an array of [1, 7, 2, 4, 9, 16, 12, 4, 2, 13] and an n value of 9. The sortedArray would be [1, 2, 2, 4, 4, 7, 9, 12, 13, 16]. The length of the array is even, so the median would be [4, 7]. Since neither 4 nor 7 matches the target number of 9, and because 9 is greater than those values, the subArray becomes [9, 12, 13, 16]. We arrive at this by calculating subArray.slice(6, 10), the new startPoint being index 6 of sortedArray and the new finish point being at index 9(REMEMBER, slice takes as its second argument the number AFTER the last index you want to include in the slice). The median of the subArray on the next loop is found by taking parseInt((startPoint+endPoint)/2) and then parseInt((startPoint+endPoint)/2)+1 and pushing those values into an array. So, the median is [12, 13], and we check for the target number by asking whether sortedArray[12] or sortedArray[13]===n. newpar,

https://www.youtube.com/embed/bS3O5zg290k newpar,

Calculating the Median /heading newpar,

Why do we need a subArray if we are describing the median as being at a position in sortedArray, or sortedArray[median]? The reason for this is that we have to calculate the median differently based on whether the length of the subArray is an even or odd number. That is what the condition if(subArray.length % 2 !==0) checks for. If when the length of the subArray is divided by 2, the remainder is not zero, then that means the length is an odd integer. If it is an odd number, it is a little easier. The median =(endPoint+startPoint)/2. newpar,

If the length of the subArray is even, then the median will actually be an array of the two numbers at the center. (I know that googling helped me to figure this out, but unfortunately I lost track of which site eventually led me to that conclusion — I will try to be better about keeping track of my sources next week! But I think this also just hearkens back to middle school math!). The way I got the two numbers for the median was by performing the same operation of (endPoint+startPoint)/2 but taking the parseInt() of that value to round down for the first index and then taking the parseInt() of it and adding one to get the second index. Then, the function checks to see whether either of those numbers match the target number before calculating the new start and end points for the subArray. newpar,

The While Loop, a.k.a. Conditions for Exit /heading newpar,

The loop will stop running under two conditions. The first is if a match is found. Then, the subArray is emptied, finished is set to 1, and ‘true’ is returned before the function exits. The second condition is if a subArray is searched, the median does not match the target value, and we cannot move in the direction we would have to go in to keep searching because we have come to the end (or the beginning) of the array. For example, if the target number is 17, but the array ends at 5, then we would have to keep moving forward to get to a larger value — but alas, there are no more available in the array. In that case, ‘finished’ is set to 1, the subArray is set to [], and the function returns ‘false’ before exiting. Because of the condition of the while loop, as long as ‘finished’ is less than zero, the function will keep digging into the sortedArray to focus on smaller and smaller pieces of it before it either finds what it needs or admits its defeat. newpar,

function binarySearch(array, n){ \n
if(array.length<=0){ \n 
return false \n
} \n
else{ \n
let sortedArray= array.sort((a, b)=> a-b) \n
let startPoint=0; \n

let subArray= [...sortedArray]; \n

let endPoint=subArray.length-1; \n

let finished = 0; \n

let median; \n


while(finished<1){ \n

    if(subArray.length % 2 !==0){ \n

        median = (endPoint+startPoint)/2 \n
       

        if(sortedArray[median]===n){ \n

            subArray=[]; \n

            finished+=1; \n

            return true; \n

         } \n

        else if(sortedArray[median]<n){ \n

            if(sortedArray[median+1]){ \n

                startPoint = median+1; \n

                let subArrayLength= subArray.length \n

                subArray= subArray.slice(startPoint, subArrayLength) \n


             } \n



            else{ \n

                subArray=[] \n

                return false; \n

            } \n

        } \n


       else if(sortedArray[median]>n){ \n

        if(sortedArray[median-1]){ \n

            endPoint = median-1; \n

            subArray= subArray.slice(startPoint, endPoint+1) \n


        } \n


        else{ \n

            subArray=[] \n
            return false; \n

        } \n

       } \n

    } \n



    else{ \n

        let firstIndex = parseInt((startPoint+endPoint)/2) \n

        let secondIndex = parseInt((startPoint+endPoint)/2)+1 \n

        median= [firstIndex, secondIndex] \n

        let thisIndex=median[0] \n

        let anotherIndex=median[1] \n

        if(sortedArray[thisIndex]===n || sortedArray[anotherIndex] ===n){ \n

            subArray=[]; \n
       
            finished+=1; \n

            return true; \n

         } \n

        else if(sortedArray[anotherIndex]<n){ \n

            let newStart= median[1]+1 \n

            if(sortedArray[newStart]){ \n


                startPoint = median[1]+1; \n

                let theLength= subArray.length \n

                subArray= subArray.slice(startPoint, theLength) \n

              } \n

            else{ \n

                subArray=[]; \n

                return false; \n

            } \n

        } \n


        else if(sortedArray[anotherIndex]>n){ \n

             let thisStart= median[0]-1 \n

            if (sortedArray[thisStart]){ \n

                endPoint = median[0]-1; \n

                subArray= subArray.slice(startPoint, endPoint+1); \n


                } \n



            else{ \n

                subArray=[]; \n

                return false; \n

            } \n

        } \n


       } \n


} \n

return false; \n
} \n
} newpar,


 


")

post_seventeen=Post.create(title: "Code Encryption Exercise in C", paragraphs: "A practice problem that I just did for a class I am taking had me create a function for turning input into a coded message. It takes in a command-line argument of a number and a string of text that is then 'encrypted' so that the letters in the string are shifted the number of positions specified by the user. I put ‘encrypted’ in quotes, because this is not for the purpose of securing your app or website. It is just for fun! If this is the kind of thing that you do for fun. newpar,
    
The problem set gave us a formula for making sure that once the function reaches the end of the alphabet it wraps back around to the beginning. I will explain that below. But first, let’s get the key, or the number of positions that the letters will be shifted. newpar,

Getting the Key /heading newpar,

The function takes two arguments on the command line, the first one is to make the file run and the second one is to get the key. newpar,

this-is-code-in-blog
int main(int argc, string argv[]) \n

The second argument is an array of strings, but the function will make sure that it is both a string of digits and that the array only has one string in it. Otherwise, the user will see an error message. newpar,

int the_key; \n
int number_for_key; \n
bool is_it_a_digit = true; \n
for (int l = 0; l < strlen(argv[1]); l++) \n
{ \n
            if (isdigit(argv[1][l])) \n
if (is_it_a_digit == false) \n
{ \n
                    is_it_a_digit = false; \n
                } \n
else \n
{ \n
                    is_it_a_digit = true; \n
} \n
else \n
{ \n
is_it_a_digit = false; \n
} \n
} \n
if (is_it_a_digit == false) \n
{ \n
printf('Usage: ./caesar key'); \n
return 1; \n
} \n
else \n
{ \n
number_for_key = atoi(argv[1]); \n
} \n
if (number_for_key > 0) \n
{ \n
the_key = atoi(argv[1]); \n
} \n
else \n
{ \n
printf('Usage: ./caesar key'); \n
return 1; \n
} newpar,

The for loop goes through each character of the string in the array and checks to make sure that it is a digit. If it is not a digit, then the boolean is_it_a_digit is set to false. is_it_a_digit is set to true to begin with, and if it is at any point in the loop changed to false, there is no going back. If it has been set to false, then it stays false. That is so that if the unruly user enters something like y2k5 it will not end up going from the default of true to false then true then false and then finally true. If there are any non-digits entered, the boolean should be set to false so that later the function will error out. newpar,

Next, I turn the string in the array, such as '343', into a number with the method atoi(). If the resulting number is greater than zero, then the key is set to that value. If it is less than or equal to zero, then the function exits and displays an error message. newpar,

Handling the Plaintext Input /heading newpar,

Now that we have the key — if we did not end up in error land — we are prompted for input of some text. newpar,

string the_string = get_string('plaintext: '); \n
int string_length = strlen(the_string); \n
char array_of_new_string[string_length]; \n
for (int i = 0; i < string_length; i++) \n
{ \n
if (the_string[i] >= 'a' && the_string[i] <= 'z') \n
{ \n
char character_with_key_added = (the_string[i] + the_key); \n
char changed_character_with_key = character_with_key_added - 97; \n
char the_remainder = changed_character_with_key % 26; \n
char the_final_character = the_remainder + 97; \n
array_of_new_string[i] = the_final_character; \n
} \n
else if (the_string[i] >= 'A' && the_string[i] <= 'Z') \n
{ \n
char character_with_key_added = (the_string[i] + the_key); \n
char changed_character_with_key = character_with_key_added - 65; \n
char the_remainder = changed_character_with_key % 26; \n
char the_final_character = the_remainder + 65; \n
array_of_new_string[i] = the_final_character; \n
} \n
else \n
{ \n
array_of_new_string[i] = the_string[i]; \n
} \n
} newpar,

Once the user has entered an input, then the function loops over the string and asks of each character whether it is a lowercase letter, an uppercase letter, or something else. There is an array initiated with a length of the string of plaintext, char array_of_new_string[string_length]. The ‘char’ at the beginning of that tells us that what is stored in the array are characters. The brackets tell us that we are initializing an array. string_length is set to strlen(the_string), because we are transforming the message so that it is the same length just with different letters. newpar,

At first, I wanted to create a new string instead of a new array, using the addition operator += to add the altered characters to it as the loop runs, as I would have done in JavaScript. However, I found that this was not possible in C. This stack overflow discussion helped me to come to the conclusion that it needed to be an array of characters: newpar,

https://stackoverflow.com/questions/10279718/append-char-to-string-in-c /anchor newpar,

In JavaScript, I would have split the input string into an array of characters and mapped over them or looped through them to transform the array of characters using the key before joining the new array of characters and then returning the secret message. Here, I loop through the string and set each item at the specified index position in the initialized array to a certain value so that later on in the function I can loop through the array and print it out for the user to see. newpar,

If the character in the string is neither a lowercase nor an uppercase letter, then we do not transform it. It enters the new array unchanged and in the same place as it was originally in. Spaces and punctuation marks, for example, are preserved as they were. So, if you type in 'What the #*&%*&^?!' with a key of 6, you get 'Cngz znk #*&%*&^?!' as the ciphertext output. For example! newpar,

./Images/Caesar_Program.jpg this-is-an-image newpar,

If the character is a lowercase letter, then first the key is added. As Brian points out in his helpful walkthrough video (thank you Brian, whoever you are), letters have numerical ASCII values, and if you add a number to them you will get a different character. For example ‘a’ + 2 = ‘c’, because the ASCII code for ‘a’ is 97 and adding two to that gives us 99, the ASCII value for ‘c’. You do not have to convert ‘a’ into a number before adding two to it and then turning the number back into a letter. What a relief! newpar,

https://theasciicode.com.ar/ /anchor newpar,
    
To use the formula for making the alphabet wrap back around once we reach the end, however, we have to convert the new value (the letter plus the key). The formula is on a scale of 26, 26 letters in the alphabet. It counts up from zero, though, with ‘a’ equal to zero and ‘z’ equal to 25. This is so that if we have a character such as ‘b’ with a value of 1, 1 % 26 will give us a remainder of one. If the character is ‘y’ with the value of 24 and we add three to it to get 27, the formula will handle this by doing 27 % 26 (the remainder of 26 divided by 27) or 1. The letter at position 1 is ‘b’, three places “ahead” of ‘y’. newpar,

To convert from ASCII code to this 0–25 scale, I subtract 97 from lowercase letters and 65 from uppercase letters, because ‘A’ in ASCII code is 65, and ‘a’ is 97. Then I plug the value of that into the formula, take the resulting remainder number and convert that back into ASCII code by adding the 97 or 65 back to it. At that point, I can set the character in the array to this value. newpar,

So now if you want to say ‘Hello!' but don’t want people to know that that is what you are saying, you can say “Mjqqt!” instead. Very useful! newpar,





    ")

post_sixteen=Post.create(title: "Loops", paragraphs: "While beginning to learn C with the help of an on-line class, the problem sets I have been doing have also given me a chance to use and better understand do while and while loops after being committed to for loops for so long. newpar, 
    
https://cs50.harvard.edu/x/2020/ /anchor newpar,

The problem sets I have been working on have had me prompting a user for input and then checking to make sure that that input conforms to certain standards. If it matches the while condition, then the loop runs again and again, until the user has been prompted into submission. newpar,

I would like to add that if a user is continuously entering invalid information it might have something to do with the directions being unclear. Or the user may not be patient enough to fully read the directions — which I can relate to at times when I feel bombarded with information and want to skim to what is relevant for present purposes! newpar,

Do While Loop /heading newpar,

For example, we can use a do while loop to prompt a user for her age and stipulate that the age must be a positive integer. I was about to say a positive integer between 1 and 200, but then I thought that would sound a little unrealistic. Though I am not sure what the record of the oldest person is, I am sure it is less than 200. But if I remember correctly some people in the Bible were said to live several hundreds of years. So, let’s just say that the input has to be a positive integer greater than 0, as controversial as that prompt may be (and not user-friendly for those less than one year old)! newpar,

    https://www.guinnessworldrecords.com/world-records/oldest-person/ /anchor newpar,

    int age; \n
    do \n
    { \n
     age = get_int('Age: '); \n
    } \n
    while (age < 1); newpar,

Then, once the age entered is 1 or greater, any code after the do while loop will execute. The advantage of a do while loop is that the block of code will execute at least once before any condition is checked. That is what we want in this case, like carding someone who is trying to buy cigarettes and not giving in until we see id. newpar,

While Loop /heading newpar,

The while loop is a little bit less aggressive, in a way, because before any code is executed, a condition is checked. If the condition is not met, then the block of code associated with it does not run. For example, I just worked on a function for making change with the least amount of coins possible given a value that a user enters as input in response to a prompt. The while loops looked like this: newpar,

int number_of_coins = 0; \n
int change_still_owed = change_rounded_up; \n
while (change_still_owed >= 25) \n
{
   number_of_coins += 1; \n
   change_still_owed -= 25; \n
}; \n
while (change_still_owed < 25 && change_still_owed >= 10) \n
{
   number_of_coins += 1; \n
   change_still_owed -= 10; \n
}; \n
while (change_still_owed < 10 && change_still_owed >= 5) \n
{ \n
   number_of_coins += 1; \n
   change_still_owed -= 5; \n
}; \n
while (change_still_owed < 5 && change_still_owed >= 1) \n
{ \n
   number_of_coins += 1; \n
   change_still_owed -= 1; \n
}; newpar,

Here the 'do' is implied. What is between the curly braces is executed if the while condition is met. If the user input was .52 (which gets rounded up to and converted into 52 then stored in the variable change_rounded_up), then the condition for the first while loop is met. The number of coins goes up by one, and the change_still_owed goes down by 25. Then the first while loop runs again, as the condition for it is met again. After that, change_still_owed is only 2. At that point, the last while loop will run once and then run again, since its condition is now the one that is being met. After that, change_still_owed will be at zero, and since none of the while loops will be triggered, whatever comes next in the function will execute. newpar,

For Loop /heading newpar,

A for loop sets a counter, a condition for executing a block of code, what to do after executing (incrementing or decrementing the counter), and a block of code. This is an example of a for loop that will print a number of hash marks according to the value that is passed into the function as an argument. newpar,

    void hash(int n) \n
    { \n
    for (int i = 0; i < n; i++) \n
    { \n
    printf('#'); \n
    } \n
    }; newpar,

    So if you call hash(2), the output will be '##'. The function loops from zero until the input number and prints a hash mark for each number as the counter increments. newpar,

    Now that you have done your homework (or skimmed until the end of the page!), you deserve a treat. newpar,

    https://www.youtube.com/embed/lrHYBcd44Og newpar,

")

post_fifteen=Post.create(title: "Last Words", paragraphs: "As the title suggests, I am having a rough week (maybe like some of you are), so I am going to keep it simple! This is a function I wrote for practice on LeetCode.com that takes an input of a string and returns an output of the length of the last word in that string. If there is only one word, then the output is the length of that word. If the input is an empty string, then the output is 0 (those are the conditions I account for in the second part of the function below under the else statement). Trailing spaces do not count as words, perhaps unlike in life when sometimes silence speaks volumes. newpar,

The Split Method /heading newpar,

The first method I use is my favorite fallback, the split method. The split method turns a string into an array, breaking it apart into pieces according to your specifications. First, I create a condition for input strings that have a blank space in them. If they fall under this condition, then I split along the blank space to separate each word. newpar,

For example, if the input ‘s’ is 'hello world' then s.split(' ') becomes the array ['hello', 'world']. newpar,

https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/String/split /anchor newpar,

The Trim Method /heading newpar,

The trim method comes in handy here to get rid of any trailing or leading blank spaces that would be counted as words later on if I did not get rid of them. So, the input 'a nice time ' becomes 'a nice time'. The difference in the way this would look when split would be: ['a', 'nice', 'time', ''] versus ['a', 'nice', 'time']. If I took the length of the former array it would be 4, even though there are only three words. That might seem like almost no difference at all, but…. it could affect the results of something like a search bar if trailing spaces are taken too seriously? Don’t anyone get any ideas please. newpar,
  
https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/String/trim /anchor newpar,

The Length Property /heading newpar,

Calling .length on an array gives you the number of items separated by commas included in it. It is a property, not a method like trim() and split(), so it does not need the parentheses when it is used (though the difference between a property and a method is something I would like to learn more about). The length of ['hello', 'world'] would be two, because there are two items in the array. If splitString= ['hello', 'world'], then splitString.length=2. newpar,

All of those letters don’t count for nothing, but they would have to be counted in a different way. That is what I do in the last step of the first condition (under the if statement) of the function lengthOfLastWord. First, I took the length of the whole array and saved that to a variable. Then, I went to the last index of the array like this: splitString[lengthOfSplitString-1]. This is abstracted since the string that comes as an input (s) is unknown. I tell it to go to the last index, whatever number that might be, which is the length of the string -1, since the index positions of arrays start with zero. The index position of 'world' in ['hello', 'world'] would be 1, even though it is the second item in the array. 'hello' is at position 0. newpar,

Then, luckily, in addition to being able to take the length of an array, I am also allowed to take the length of a string. That is what I do at the end of the first condition to take the measure of 'world', at least the one that I am saying hello to. newpar,

var lengthOfLastWord = function(s) { \n
if(s.includes(' ')){ \n
    
    let splitString=s.trim().split(' ') \n
 
    let lengthOfSplitString=splitString.length \n
    
    return splitString[lengthOfSplitString-1].length \n
} \n
    
    else{ \n
        if(s===''){ \n
            return 0 \n
        } \n
        else{ \n
            return s.trim().length \n
        } \n
        
    } \n
    
}; newpar,

https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array/length /anchor newpar,

https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/String/length /anchor newpar,

https://www.youtube.com/embed/rblYSKz_VnI newpar,


")

post_fourteen=Post.create(title: "Roman Numeral Conversion Algorithm", paragraphs: "One of the algorithms that I worked on earlier this week converts roman numerals into integers. Sometimes when I write a function for the sake of practice on sites like LeetCode.com or Hackerrank.com, I wonder if or when I would ever use it. However, as someone who is not from Ancient Rome, this function struck me as useful — in spite of my sense that I might have actually memorized the roman numeral system in less time than it took to write a function that would make that conversion for me. But I digress… newpar,

What was tricky about this problem was that there were a lot of conditions to articulate. It is undoubtedly the longest function I have written, which makes me suspect that there must be a much shorter solution to this problem, as is usually the case. newpar,

let romanToInt = (s) => { \n
    
    let stringToArray= s.split('') \n
    
    let count=0 \n
let i; \n
    
    for(i=0; i<stringToArray.length; i++){ \n
        
        if (i!==(stringToArray.length-1)){ \n
            
            if(stringToArray[i]==='I'){ \n
            
                if(stringToArray[i+1]==='X'){ \n
               count+=9 \n
                } \n
            
                else if(stringToArray[i+1]==='V'){ \n
                count+=4 \n
                } \n
           
                else{ \n
                count+=1 \n
                } \n
            } \n
           
            else if(stringToArray[i]==='X'){ \n
             
                if(stringToArray[i+1]==='L'){ \n
                count+=40 \n
                } \n
            
                else if(stringToArray[i+1]==='C'){ \n
                count+=90 \n
                } \n
                
                 else if(stringToArray[i-1] && stringToArray[i-1]==='I'){ \n
                       count+=0 \n
                   } \n
             
                else{ \n
                count+=10 \n
                } \n
            } \n
        
            else if(stringToArray[i]==='C'){ \n
             
                if(stringToArray[i+1]==='D'){ \n
                count+=400 \n
                } \n
            
                else if (stringToArray[i+1]==='M'){ \n
                count+=900 \n
                } \n
                
                else if(stringToArray[i-1] && stringToArray[i-1]==='X'){ \n
                       count+=0 \n
                   }  \n
             
                else{ \n
                count+=100 \n
                }   \n
            } \n
        
        else if(stringToArray[i]==='V') { \n
            if(stringToArray[i-1]){ \n
                
                if (stringToArray[i-1]==='I'){ \n
                    count+=0 \n
                } \n
                
                else{ v
                    count+=5 \n
                } \n
            } \n
             
            else{ \n
                count+=5 \n
            } \n
            
        } \n
        
        else if(stringToArray[i]==='L'){ \n
            if(stringToArray[i-1]){ \n
                if (stringToArray[i-1]==='X'){ \n
                    count+=0 \n
                } \n
                
                else{ \n
                    count+=50 \n
                }  \n
            } \n
            
            else{ \n
                count+=50 \n
            } \n
        } \n
        
          else if(stringToArray[i]==='D'){ \n
            if(stringToArray[i-1]){ \n
                if (stringToArray[i-1]==='C'){ \n
                    count+=0 \n
                } \n
                
                else{ \n
                    count+=500 \n
                } \n
            } \n
            
            else{ \n
                count+=500 \n
            } \n     
        } \n
        
         else if(stringToArray[i]==='M'){ \n
            if(stringToArray[i-1]){ \n
                if (stringToArray[i-1]==='C'){ \n
                    count+=0 \n
                } \n
                
                else{ \n
                    count+=1000 \n
                } \n
            } \n
            
            else{ \n
                count+=1000 \n
            } \n     
        } \n
        
        
            } \n
        
    else{ \n
        
        if (stringToArray[i]==='I'){ \n
            count+=1 \n
        } \n
        
        else if(stringToArray[i]==='V'){ \n
            
            if(stringToArray[i-1]){ \n
                
                if(stringToArray[i-1]==='I'){ \n
                    count+=0 \n
                } \n
                else{ \n
                    count+=5 \n
                } \n
            } \n
            else{ \n
                count+=5 \n
            }  \n
        } \n
        
        else if(stringToArray[i]==='X'){ \n
            if(stringToArray[i-1]){ \n
                
                if(stringToArray[i-1]==='I'){ \n
                    count+=0 \n
                } \n
                else{ \n
                    count+=10 \n
                } \n
            } \n
            else{ \n
                count+=10 \n
            }  \n
            
        } \n
        
        else if (stringToArray[i]==='L'){ \n
            if(stringToArray[i-1]){ \n
                
                if(stringToArray[i-1]==='X'){ \n
                    count+=0 \n
                } \n
                else{ \n
                    count+=50 \n
                } \n
            } \n
            else{ \n
                count+=50 \n
            } \n
            
        } \n
        
        else if (stringToArray[i]==='C'){ \n
           if(stringToArray[i-1]){ \n
                
                if(stringToArray[i-1]==='X'){ \n
                    count+=0 \n
                } \n
                else{ \n
                    count+=100 \n
                } \n
            } \n
            else{ \n
                count+=100 \n
            } \n
            
        } \n
        
        else if(stringToArray[i]==='D'){ \n
             if(stringToArray[i-1]){ \n
                
                if(stringToArray[i-1]==='C'){ \n
                    count+=0 \n
                } \n
                else{ \n
                    count+=500 \n
                } \n
            } \n
            else{ \n
                count+=500 \n
            } \n
            
        } \n
        
        else if (stringToArray[i]==='M'){ \n
            if(stringToArray[i-1]){ \n
                
                if(stringToArray[i-1]==='C'){ \n
                    count+=0 \n
                } \n
                else{ \n
                    count+=1000 \n
                } \n
            } \n
            else{ \n
                count+=1000 \n
            }   \n
            
        } \n
            
    } \n
          
    } \n
return count \n
} newpar,

The first step I took was to split the string ‘s’ into an array and save it to another variable. If ‘s’ was 'IV', then the array would be ['I', 'V']. Doing this allowed me to loop through each character and add up the numerals to convert them into an integer, saved to the variable ‘count.’ The first condition in the loop was to specify what to do if the item was not in the last index position. Within that condition, I went through each numeral to indicate how the count should change (or not change). newpar,

For ‘I’, if the numeral in the next position was ‘X’ then the count would go up by 9, or if it was ‘V’ then it would go up by 4. Otherwise, it would go up by one. newpar,

If the numeral was ‘X’, there would be a few possibilities. For each numeral, we basically have to teach the function to read the whole context, often including what comes before a character and what comes after it (if there is anything before or after — and specifying whether or not something comes before or after is another condition to spell out in some cases). For ‘X’, if the next character is ‘L’, then the count goes up by 40, and if it is C it goes up by 90. Then, if there is anything before ‘X’ and if what is before it is ‘I’, then that means the count will go up by 0. That is because if ‘I’ is before ‘X’ in the for loop, ‘IX’ has already been taken together and increased the count by 9 (as I spelled out in the last step). If I didn’t have this condition then when the loop made it to ‘X’ it would add another ten to the count. Finally, if none of these conditions were met, then the count would go up by ten. newpar,

If the character was ‘C’ and the next character was ‘D’, the count would go up by 400. If the next character was ‘M’, the count would increase by 900. But if the character before ‘C’ was ‘X’, then the count would not increase, because ‘XC’ is 90 and would have already been taken into account by a previous condition. If none of these conditions were met, then the count would go up by 100. newpar,

For the character ‘V’, if there was a numeral before it and if that numeral was ‘I’, then the count would not go up, because ‘IV’ would have already been calculated. Otherwise, it would increase by 5. newpar,

The logic for ‘L’ is the same as that for ‘V.’ If it is preceded by ‘X’ the count stays the same, because other than being a t-shirt size ‘XL’ also means 40. If nothing comes before it or what does come before it is not ‘X’ then 50 is added to the count. newpar,

The condition for ‘D’ also follows this pattern of reading only the numeral before it and not the one after it. If what is before it is ‘C’, then the count does not go up, because ‘CD’ is 400— and that would have already been added to the count by the time the loop made it to the D. Otherwise, the count would go up by 500. newpar,

Lastly, if the numeral was ‘M’ and there was either nothing before it or what was before it was not ‘C’, the count would go up by 1000. If what came before it was ‘M’, the count would not go up, because that would have been 900 and would have already been added. newpar,

If you are still awake, I will now go ahead and go through the next part of the function that accounts for the case in which the loop is at the last index position of the array. newpar,

If you are not awake... Wake up, O World; O World, awake! newpar,

https://allpoetry.com/poem/12318010-The-Wakeupworld-by-Countee-Cullen /anchor newpar,

https://www.youtube.com/embed/pfnvyF2zwMw newpar,

Now that you are awake… newpar,

If ‘I’ is the last numeral in the array, then 1 is simply added to the count. Easy! newpar,

If ‘V’ is the last numeral, then the logic is actually the same as if it was in any other position in the array. Which means, this is an opportunity for refactoring!!! I will give you a couple of minutes to go work on that. Meet me back here when you are done. newpar,

Great, thank you for coming back. Now, if ‘L’ is the last numeral in the array, then the logic is ALSO the same as it would be for any other position in the array. WAIT A MINUTE! I am sensing a pattern here. There is a lot of repetitive code. That is not D.R.Y.! newpar,

***UPDATE: I refactored the code above to get the following. There is undoubtedly still room for improvement, but this is what I have so far: newpar,

let romanToInt = (s)=> { \n
    
    let stringToArray= s.split('') \n
    
    let count=0 \n
let i; \n
    
    for(i=0; i<stringToArray.length; i++){ \n
                    
            if(stringToArray[i]==='I'){ \n
if (i===stringToArray.length-1) \n                    {
                
                    count+=1 \n
} \n
else{ \n
            
                if(stringToArray[i+1]==='X'){ \n
               count+=9 \n
                } \n
            
                else if(stringToArray[i+1]==='V'){ \n
                count+=4 \n
                } \n
else{ \n
                count+=1 \n
                } \n
            
            } \n
            } \n
else if(stringToArray[i]==='X'){ \n
if (i!==(stringToArray.length-1)){ \n
             
                if(stringToArray[i+1]==='L'){ \n
                count+=40 \n
                } \n
            
                else if(stringToArray[i+1]==='C'){ \n
                count+=90 \n
                } \n
else{ \n
                count+=10 \n
                } \n
                } \n
                
                 else { \n
                if(stringToArray[i-1] && stringToArray[i-1]==='I'){ \n
                       count+=0 \n
                   } \n
             
                else{ \n
                count+=10 \n
                } \n
                      } \n
                      } \n
        
            else if(stringToArray[i]==='C'){ \n
             
                if(stringToArray[i+1]==='D'){ \n
                count+=400 \n
                } \n
            
                else if (stringToArray[i+1]==='M'){ \n
                count+=900 \n
                } \n
                
                else if(stringToArray[i-1] && stringToArray[i-1]==='X'){ \n
                       count+=0 \n
                   } \n  
             
                else{ \n
                count+=100 \n
                } \n
            } \n
        
        else if(stringToArray[i]==='V') { \n
            if(stringToArray[i-1]){ \n
                
                if (stringToArray[i-1]==='I'){ \n
                    count+=0 \n
                } \n
                
                else{ \n
                    count+=5 \n
                } \n
            } \n
            
            else{ \n
                count+=5 \n
            } \n
            
        } \n
        
        else if(stringToArray[i]==='L'){ \n
            if(stringToArray[i-1]){ \n
                if (stringToArray[i-1]==='X'){ \n
                    count+=0 \n
                } \n
                
                else{ \n
                    count+=50 \n
                } \n
            } \n
            
            else{ \n
                count+=50 \n
            } \n    
        } \n
        
          else if(stringToArray[i]==='D'){ \n
            if(stringToArray[i-1]){ \n
                if (stringToArray[i-1]==='C'){ \n
                    count+=0 \n
                } \n
                
                else{ \n
                    count+=500 \n
                } \n
            } \n
            
            else{ \n
                count+=500 \n
            } \n
        } \n
        
         else if(stringToArray[i]==='M'){ \n
            if(stringToArray[i-1]){ \n
                if (stringToArray[i-1]==='C'){ \n
                    count+=0 \n
                } \n
                
                else{ \n
                    count+=1000 \n
                } \n
            } \n
            
            else{ \n
                count+=1000 \n
            } \n
        } \n
} \n
return count \n
} newpar,

")

post_thirteen=Post.create(title: "Two Sum Function", paragraphs: "This is a post about a two sum function that I wrote while doing a practice problem on LeetCode. The function takes two arguments, the first one an array of numbers and the second one an integer. The integer is a sum of two of the numbers in the array. What the function is supposed to return is an array of the index numbers of the numbers in the original array that when added together equal the target number. newpar,

The last sentence I wrote is an example of how language about coding can make code sound more complicated than it is. I would recommend going down to the examples below to recover from what I just did to you. newpar,

Something that had me sidetracked for awhile was that I was trying to use indexOf() until I realized that in my excitement over the possibility of using this method I had overlooked the fact that indexOf() only returns the first match in an array. For example if we have newpar,

this-is-code-in-blog
let thisArray= [2, 5, 4, 7, 4] newpar,

If I call indexOf on it to get the index of 4 newpar,

this-is-code-in-blog
thisArray.indexOf(4) newpar,

It would give me 2, because that is the first matching index position. IndexOf() does not help me to get the index of the second 4 in the array. newpar,

As a side note, it is also interesting to me that calling indexOf() for something that is not in the array it is called on — for example, thisArray.indexOf(1000) or thisArray.indexOf(17)— yields a -1. Why -1? It seems kind of arbitrary, but I like it! newpar,

https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array/indexOf /anchor newpar,

This is the solution I came up with: newpar,

let twoSum = function(nums, target) { \n
let i; \n
let newArray=[] \n
for(i=0; i<nums.length; i++){ \n
newArray.push([i, nums[i]]) \n
} \n
let n; \n
let anotherArray=[]; \n
for(n=0; n<newArray.length; n++){ \n
newArray.forEach(array=>{ \n
if(array[0]!==newArray[n][0]){ \n
if (array[1]+newArray[n][1]===target){ \n
anotherArray.push(newArray[n][0]) \n
} \n
} \n
}) \n
} \n
let sortedArray=anotherArray.sort((a, b)=>{return a-b}) \n
return sortedArray \n
} newpar,

In the first loop, I transformed the array ‘nums’ to give me an array of arrays. Each array in the array was a set of two numbers. The number at the zero index was the original index position that the number was in in ‘nums,’ and the second number in index position one was the number itself. For example, if ‘nums’ was [4, 7, 3, 6], then ‘newArray’ would be [[0, 4], [1, 7], [2, 3], [3, 6]]. \n

In the second loop, I went through ‘newArray’ one array at a time, adding the number at index 1 to the number at index 1 in the other arrays and pushing the index number into a new array called ‘anotherArray’ if the sum was the target number. The loop allowed me to cycle through each array to compare it to the others, and the forEach allowed me to specify what I wanted to compare that array to, which was every other array. \n

The reason I have the condition newpar,

this-is-code-in-blog
if(array[0]!==newArray[n][0]) newpar,

is so that a number at a specific index position is not compared to itself and is only compared to the other numbers in the original array. newpar,

The result is that if ‘nums’ was [4, 7, 3, 6] and the target was 9, then ‘anotherArray’ would be [2, 3]. newpar,

In this example, ‘anotherArray’ is already in ascending order; but in case it was not, the last step is sorting ‘anotherArray’. There is no harm in sorting an array that is already sorted, as far as I know. At least not in this context! newpar,

Voila! newpar,

https://www.youtube.com/embed/pMWxnjgvUQM newpar,

")

post_twelve=Post.create(title: "Search Bar in React With a 3rd Party API", paragraphs: "Making a search bar when fetching from a third party API with a large set of data required a few more steps than when I was building one for an application that had all of the data stored on the back end. newpar,

The first step was having a search bar component and displaying it in the place where I wanted it. The one that I designed is a controlled form that when submitted triggers a call-back function that was passed down to it as a prop and sends the search term back to the parent component. When it is submitted it also resets the input field so that it is blank until a user types inside of it. newpar,

export default class Searchbar extends React.Component{ \n
state={ \n
searchTerm: ''
} \n
doingASearch=(event)=>{ \n
this.setState({ \n
[event.target.name]: event.target.value \n
}) \n
} \n
submitSearch=(event)=>{ \n
event.preventDefault(); \n
this.props.filterBySearchTerm(this.state.searchTerm) \n
this.setState({ \n
searchTerm: '' \n
}) \n
} \n
render(){ \n
return( \n
<form onSubmit={this.submitSearch}> \n
<label htmlFor='searchTerm'> \n
<strong>Search by park name: </strong> \n
<input type='text' name='searchTerm' value={this.state.searchTerm} onChange={this.doingASearch}/> \n
<input type='submit' value='submit'/> \n
</label> \n
</form> \n
) \n
} \n
} newpar,

In the parent component, I wrote a function that makes a POST fetch to the Ruby on Rails API back end, sending the search term in the body. The reason that it is a POST fetch instead of a GET is that once the fetch goes to the controller that fetches from the third-party API, the search term has to be appended to the API’s url. To inform the controller of what to append, I am posting information in the body of the fetch. This is the action in the controller: newpar,

this-is-code-in-blog
def by_search \n
    require 'rest_client' \n
    query= params[:query] \n
    address= 'https://developer.nps.gov/api/v1/parks?&API_KEY=(INSERT INTERPOLATION WITH .ENV AND KEY HERE)&q=' \n
    complete_search_address=address+query \n
    nps_data= RestClient.get(complete_search_address) \n
    nps_search_parsed= JSON.parse(nps_data) \n
    render json: nps_search_parsed \n
    end newpar,

And this is the function on the front end that makes the POST fetch: newpar,

filterBySearchTerm=(search)=>{ \n
this.setState({ \n
theLocationFilter: search, \n
}) \n
fetch('http://localhost:3000/searchparks', { \n
method: 'POST', \n
headers: { \n
'Content-Type': 'application/json', \n
'Accepts': 'application/json' \n
}, \n
body: JSON.stringify({ \n
query: search \n
}) \n
}) \n
.then(r=>r.json()) \n
.then(thePark=>{ \n
if(thePark.data.length>0){ \n
this.setState({ \n
searchTerm: search, \n
filterAll: false, \n
searchPark: thePark.data, \n
isLoading: false \n
}) \n
} \n
else{ \n
this.setState({ \n
theLocationFilter: search, \n
filterAll: false, \n
isLoading: false, \n
searchError: 'No parks found' \n
}) \n
} \n
}) \n
} newpar,

I store the query params in a variable in the controller’s by_search action and then append it to the base url with &q= at the end. The documentation for the third-party API that I am fetching from specifies how to search by a particular term in its documentation. It also required some trial and error as well as looking up information from other developers on-line to get the format right. For example, it was not clear whether the query term needed to be in quotation marks or in brackets, etc. It turns out that &q= with no quotation marks works, but putting the term in quotes does not. So, if I wanted to search for ‘Belmont’ — which incidentally is the name of a street near where I went to college in Chicago (DePaul) but is also part of the name of a national monument in Washington D.C. (Belmont-Paul Women’s Equality) — I would need to add ‘&q=Belmont’ to the end of the url. Because everything but the query string will be the same when a user uses the search bar, the main address for the fetch in the controller is the same, and the variable storing the query string is added to this base to get the complete address. Rest Client then makes a GET fetch to the third-party API, and the data sent back is parsed and rendered as JSON to the front end. The key for the API is stored in the .env file, which is hidden and not visible on my Github repository but is made available to the controller with the help of the dotenv gem. newpar,

When the data makes its way to the front end, there are a lot of little things that have to happen. The devil is in the details! newpar,

First, it is possible that the search term did not have any matches. In that case, searchError in state is set to a string that says ‘No parks found,’ and that will display on the results page. Even though that is not extremely helpful to users, at least it sends them the message that there were no matches and tells them that they should try again. At that point, if a user clicks on the ‘Return to Parks’ button or just navigates to a different tab on the navigation bar, they will have a clean slate for another search. That is better than, let’s say, redirecting them to some page that seems out of context with no explanation of why they are there and no message about whether or not their search has been successful (I have been seeing some weird redirects and ambiguous results pages on other sites lately, so I know from experience how obscure the results of clicking a button on-line can be!). newpar,

If the data sent back is not just an empty array, then I set state so that the park that matches the search term is displayed. It is possible that multiple matches could come up when a user is looking for one particular park. For example, when I type in ‘Grand Canyon’, three parks are displayed: ‘Grand Canyon National Park,’ ‘John Muir National Historic Site,’ and ‘Parashant National Monument.’ This is because the Grand Canyon is mentioned in the description for all three of these parks. In my opinion, that narrows the search well enough. Users can easily zero in on the Grand Canyon in this way without having to know which state the park is in to use the search-by-state option in the application, which pulls up a list of parks based on a state that the user selects. newpar,

On the other hand, if a user types in nonsense a lot of things can happen. newpar,

#1, if there are absolutely no matches, then the data returned will have a length of zero, so the error message will display, and there is no harm done. newpar,

If, however, the user types in something like ‘to,’ as I did for testing purposes, there might be an unhelpful number of matches, not narrowing the range of parks down in any useful way. Actually, for that particular query, I think it matches all of the parks in the API, but there is a limit of 50 by default — so it renders the first fifty. While it might be fun to test this further, my guess is that it is not a way most users are likely to use the search bar. And if they do, at this point it is not crashing the site but is just rendering parks organized along mysterious lines not relevant for most people planning trips. newpar,

All of the other items set in state when the data is returned from the fetch are for the sake of signaling different conditions to the application. When the function is initially called, I set the locationFilter so that a page flashing ‘Parks are loading’ is displayed in case there is any lag time until the parks that match the search appear. The filterAll item is set to false in order to conditionally render a different component with the list of parks that include the search term instead of the component that is on the landing page for the route, which displays a heading, the search bar, and a list of states and territories that can be selected to search by location. Lastly, searchTerm is a string of what the user entered into the input field, and searchPark is the information about particular parks returned from the API. The searchTerm is used in the heading of the results to remind the user of what they were looking for. The searchPark information is mapped over to display the results of the search in a list. newpar,

Then, any of the names of parks that are shown in the list can be clicked on to render a show page for that particular park. When users click on a ‘Return to List’ button from the show page of a park, it takes them back to the short list of search results, and when they click on the ‘Return to Parks’ button from there it clears all of the search results and takes them back to the landing page for the Parks route. newpar,

This is tangential, but I like to end my blog posts with a song whenever possible. This came to mind and relates to the theme of search and travel. I am not sure what cave it was filmed in, but yes there are caves in some national parks, such as… newpar,

./Images/Search_Bar_with_Cave.jpg this-is-an-image newpar,

./Images/Search_Results_for_Cave.jpg this-is-an-image newpar,

./Images/Oregon_Caves.jpg this-is-an-image newpar,


https://www.nps.gov/orca/index.htm /anchor newpar,

https://www.youtube.com/embed/hXCKLJGLENs newpar,

https://www.youtube.com/embed/KLQS6xo40kI newpar,  

")

post_eleven=Post.create(title: "React Edit Form: What Appears in the Text Area", paragraphs: "As I wrote at the end of my blog last week, there were a few things that I still wanted to work on for the National Park Trip Planner application I have been building, including authorization to restrict who could access a user’s park collection and notes, CSS for the park collection page, and changing the edit form for notes to populate the text area with the note that a user would like to edit. This blog will be about the last of these objectives, and I will write about the other topics in a separate post. newpar,

Although it took me awhile to figure out how to create a better edit form, the solution was relatively simple. Before, there was a callback function for when the edit button was pushed that sent the note to be edited up to App.js. App.js set the text of the entry to be edited in state and then sent it down to ExpandParksInParkCollection.js where the particular park in the collection is displayed, along with any notes a user has taken. There, it became the placeholder of the edit form, which was conditionally rendered after the boolean in state in App.js ‘updateNote’ was set by the onClick event to true. What I wanted to do was to change the placeholder into text that could actually be edited instead of disappearing when a user started typing in the text area. newpar,

To do this, I added a function to ExpandParksInParkCollection.js that is called when the edit form is clicked on. The onClick is still a callback, but it sends the note to the function that is in the same component as the form so that it can do two things. 1. It still calls the updateNoteForm function and sends the note up to App.js where the id of the note is stored in state in order to be used in the url when later sending the updated note in a PATCH fetch to the back end. It also still changes the boolean ‘updateNote’ in state in App.js from false to true so that the edit form will be conditionally rendered in ExpandParksInParkCollection.js. 2. The benefit of making a function in ExpandParksInParkCollection.js to handle the onClick is that I can also reset state in that component. When the onClick is fired, updatedNotes in state is assigned the value of the text of the entry. That way, when the edit form appears, that value is in the edit form and can be changed or added to. This is state in that component: newpar,

import React from 'react'; \n
export default class ExpandParksInParkCollection extends React.Component{ \n
state={ \n
notes: '', \n
updatedNotes: '' \n
} newpar,

This is the switchToEdit function: newpar,

switchToEdit=(the_note)=>{ \n
this.props.updateNoteForm({ \n
note: the_note \n
}) \n
this.setState({ \n
updatedNotes: the_note.entry \n
}) \n
} newpar,

Here is the function where the notes are mapped over for display and where you can also see where the onClick event is called: newpar,

returnTheNotes=()=>{ \n
return this.props.currentNotes.map(note=>{ \n
return  <React.Fragment> \n
<li>{note.entry}</li> \n
<div className='notes-display-container'> \n
<p className='delete-note' onClick={()=>this.props.deleteANote(note.id)}>Delete</p> \n
<p onClick={()=>this.switchToEdit(note)} className='edit-note'>Edit</p> \n
</div> \n
</React.Fragment> \n
}) \n
} newpar,

Here are the two forms conditionally rendered, the edit form if the edit button has been clicked and the new note form if it has not been. newpar,

{this.props.updateNote ? \n
<form onSubmit={this.submitUpdatedNotesForm}> \n
<textarea id='comment-box' type='text' wrap='hard' name='updatedNotes' value={this.state.updatedNotes} onChange={this.updateTheNotes}/> \n
<br></br> \n
<input className='submit-buttons' type='submit' value='submit'/> \n
</form> \n
: \n
<form onSubmit={this.submitNotesForm}> \n
<br></br>
<textarea id='comment-box' type='text' wrap='hard' name='notes' value={this.state.notes} placeholder='Enter a new note here' onChange={this.changeTheNotes}/> \n
<br></br> \n
<input className='submit-buttons' type='submit' value='submit'/> \n
</form> \n
} newpar,

One of the things that was surprising to me was that the text that a user wanted to edit did not disappear when the user starts typing. Since there is an onChange event to allow the user to change the note that is stored in state and sent to the back end, I thought that onChange would make the text that displayed disappear, leaving me no better off than when there was a placeholder. Somehow that is not the case, though. The text that was stored in state as updatedNote when the edit button was clicked displays in the text area, and then the onChange allows a user to edit it at will and add to it. If there were not an onChange event, then the initial value would be fixed. This is the updateNotes function called through the onChange event: newpar,

updateTheNotes=(event)=>{ \n
this.setState({ \n
updatedNotes: event.target.value \n
}) \n
} newpar,

The event.target.value is this.state.updatedNotes from before edited in whatever way the user chooses to edit it. The original text appears first before any changes occur, and then state changes again to reflect what the user does with this text. If the value of the text area had not been set as this.state.updatedNotes but instead had been set directly with the text entry, then the value of the text area would have been fixed. Setting it in state allowed for the edits to happen. newpar,

This topic warrants its own attention, because it is something I had trouble getting information about on-line. So, maybe it can help someone else trying to figure out how to populate their text area with what they would like to edit. newpar,
    

")

post_ten=Post.create(title: "National Parking", paragraphs: "Something that I continue working on is my national parks trip planner application. Being holed up in my apartment as the Coronavirus takes over New York, this app is more aspirational than ever. However, I learn from continuing to build it, even if no one is using it to actually plan any trips. newpar,

What I worked on in the last week was refactoring the notes feature. Before, users could post a note for any park that they had saved in their collection, and they could update or delete their note, persisting the changes to the back end. ‘Note’ was an attribute of a park collection. I wanted to change this to make ‘Note’ its own model so that people could save multiple notes for any given park in their collection and revise and delete the notes as often as they wanted. newpar,

The first thing that I did was to remove note as an attribute of park_collection and make it a model of its own. So my tables for these two models now look like this in the database schema: newpar,

this-is-code-in-blog
create_table 'notes', force: :cascade do |t| \n
    t.integer 'park_collection_id' \n
    t.text 'entry', default: 'Add notes here by typing in the text box below' \n
    t.datetime 'created_at', precision: 6, null: false \n
    t.datetime 'updated_at', precision: 6, null: false \n
    end \n
    create_table 'park_collections', force: :cascade do |t| \n
    t.string 'park_id' \n
    t.text 'description' \n
    t.string 'directions_url' \n
    t.string 'url' \n
    t.string 'full_name' \n
    t.integer 'user_id' \n
    t.datetime 'created_at', precision: 6, null: false \n
    t.datetime 'updated_at', precision: 6, null: false \n
    end newpar,

    A note includes the id of a park_collection, because it belongs to park_collection, and a park_collection includes the user_id since it belongs to a user. I did not want the notes to be saved for a park in general. That is not something I would have been able to do as the application is currently set up, because I am not storing the data fetched from the National Park Service API on my back-end and giving myself the ability to add attributes to it or connect it with models on the back end. Instead, the notes are available as a part of a user’s park collection. They are for personal use rather than for providing comments or information to other users. newpar,
    
    Next, I created a note_serializer so that I would be able to render the notes as json with the help of the notes_controller and fetch the notes from the backend to display on the front end. This is the way the serializer appears: newpar,

    this-is-code-in-blog
    class NoteSerializer < ActiveModel::Serializer \n
        attributes :id, :entry, :park_collection_id \n
        belongs_to :park_collection \n
        end newpar,

    Then, in the park_collection_serializer I had to indicate that when a note is deleted, it should also be deleted from the park_collection. I did this with dependent: :destroy, something that Guligena Aierken showed me when we worked on a group project together a couple of months ago. newpar,

    https://medium.com/@g.aierken /anchor newpar,

    this-is-code-in-blog 
    class ParkCollectionSerializer < ActiveModel::Serializer \n
        attributes :id, :user_id, :park_id, :description, :directions_url, :url, :full_name \n
        belongs_to :user \n
        has_many :notes, dependent: :destroy \n
        end newpar,

    The next thing I had to work on was the controller, which I built up as I worked on the front end. Something I still have to do is to make sure that only the user who is logged in can access his or her notes. Authorization for obtaining access to the routes needs some work across the board on the back-end, in fact. Since this application is not deployed on-line, there are no security risks at the moment, but it would be important to change this if the application were to go live. This is how the controller for the notes looks at the moment: newpar,

        class NotesController < ApplicationController \n
            def index \n
            notes=Note.all \n
            render json: notes \n
            end \n
            def show \n
            parkCollection=ParkCollection.find_by(params[:id]) \n
            render json: parkCollection.notes \n
            end \n
            def create \n
            note = Note.create(note_params) \n
            render json: note \n
            end \n
            def update \n
            note=Note.find(params[:id]) \n
            note.update(entry: params[:entry]) \n
            render json: note \n
            end \n
            def destroy \n
            note=Note.find(params[:id]) \n
            note.destroy \n
            render json: {message: 'Your note has been deleted.'} \n
            end \n
            def note_params \n
            params.permit(:entry, :park_collection_id) \n
            end \n
            end newpar,
    
            So, that is mainly what is going on on the back end as far as the notes are concerned. newpar,

            The fetch to the National Park Service API is not directly related to the notes. When a user goes to the website, there is a list of all of the states and territories in the U.S. where there are national parks. When a user clicks on a location, then a fetch is made to the back end, which then makes a fetch to the National Park Service API for that particular location. Then, a list of parks for that location appears on the front end. A user can click on any of the parks in the list to get more information about it or add it to his or her or their collection. If a user adds a park, then a park_collection is created on the back-end. This may sound a little confusing, because on the front end each user only has one park collection. However, on the back end, each time a user adds a park, it becomes a ‘park_collection’ on the back end. So, what is referred to as one collection on the front end is actually a collection of ‘collections’ in the database. Because each park collection belongs to the User model on the back end, I am able to load the collections belonging to a user when the user logs in by calling park_collections as an instance method on a particular user. When a user logs in, a token is set, giving them access to the site’s different features and allowing them to have access to their information. In the setToken function, I fetch information from the back-end using the user id, so that they will be able to see all their parks, among other things. I also put some information in localStorage so that if the user navigates away from the page without logging out, they will be able to return without having to log back in. newpar,

            setToken = (token, id) => { \n
                localStorage.token = token; \n
                localStorage.userId = id; \n
                fetch(`http://localhost:3000/users/${id}`, { \n
                headers: { \n
                'Authorization': token \n
                } \n
                }) \n
                .then(r => r.json()) \n
                .then(user => { \n
                this.setState({ \n
                username: user.username, \n
                token: token, \n
                userId: id, \n
                parkCollection: user.park_collections \n
                }) \n
                localStorage.setItem('theParkCollection', JSON.stringify(user.park_collections)) \n
                let the_username= user.username \n
                localStorage.setItem('username', the_username) \n
                }) \n
                } newpar,
                
        So, the above code gives the front end access to a set of information including parks that are already saved to a user’s profile. However, I have not yet fetched the notes. I decided to wait until a user is in the park collection section of the application to make this fetch. When a user goes to their collection, there is a list of names of parks, if any have been added. When a user clicks on one of the parks, then a function that has been passed down from App.js is called. It is a callback function, with the component ParksForParkCollection sending up information about the particular park in question. newpar,

        selectAPark=(the_park)=>{ \n
            fetch(`http://localhost:3000/park_collections`) \n
            .then(r => r.json()) \n
            .then(data=> { \n
            let filteredData= data.filter(this_data=>{ \n
            return parseInt(this_data.user_id)===parseInt(this.state.userId) \n
            }) \n
            let newFilteredData= filteredData.filter(this_data_here=>{ \n
            return this_data_here.park_id===the_park.park_id \n
            }) \n
            this.setState({ \n
            parkClickedOn: the_park, \n
            isAParkExpanded: true, \n
            filterAll: false, \n
            currentNotes: newFilteredData[0].notes \n
            }) \n
            }) \n
            }  newpar,
            
    The fetch goes to the park_collections route on the back end. Then, I filter the data that is sent back so that I have a new array of information pertaining only to the logged in user’s park_collections, instead of the entire set of all park_collections. That is stored in the variable filteredData. After that, I filter the new array down further to return an array of park_collections for the specific park that a user has clicked on. That new array is stored in the variable newFilteredData. At that point, I am able to call notes as an instance variable on the filtered park collection. Then, I set state so that currentNotes contains the notes for the park the user has clicked on in the park collection on the front end. When a user leaves the show page in park collection for a specific park, currentNotes is reset to an empty array. newpar,

    The next step was to allow the user to edit and delete notes. There was already a form on the show page for a park in a user’s park collection for creating a new note. I added a ‘p’ tag that said edit and one that said ‘delete’ with an event listener on each of them that was an OnClick callback function sending information back to functions in App.js. For ‘delete’, the function in App.js was deleteANote. That function makes a DELETE fetch to the back end. What I sent back in the callback was the id of the particular note to be deleted. I filter the deleted note out of the currentNotes in order to reset state to reflect the deletion. Then, I make the delete fetch to the url for that note. Here is that function: newpar,

    deleteANote=(note)=>{ \n
let theNewNotes=this.state.currentNotes.filter(the_note=>{ \n
return parseInt(note)!==parseInt(the_note.id) \n
}) \n
fetch(`http://localhost:3000/notes/${parseInt(note)}`, { \n
method: 'DELETE' \n
}) \n
.then(r=>r.json()) \n
.then(data=>{ \n
this.setState({ \n
currentNotes: theNewNotes, \n
theNoteToEdit: '', \n
updateNote: false \n
}) \n
}) \n
} newpar,

Allowing for notes to be edited was a little more complicated. The callback function that is triggered when ‘edit’ is clicked on is: newpar,

updateNoteForm=(theNote)=>{ \n
this.setState({ \n
updateNote: !this.state.updateNote, \n
noteId: theNote.id, \n
theNoteToEdit: theNote.entry \n
}) \n
} newpar,

UpdateNote is a boolean in state that indicates whether or note the user is trying to edit a note. It is set to false from the beginning, and updateNoteForm changes that boolean to true. The id and text of the note to be edited are also set in state in App.js for reasons I will get into. The value of updateNote is sent down to park_collection, and if the value is true, then the edit form is conditionally rendered with the text of the note to edit being the placeholder in the text area. I would like to refactor this to fill in the text-area with the text of the note that they are revising, instead of just having it as a placeholder that disappears when they start typing in the input area. That way they will not have to copy and paste the part of the note that they may want to keep into the text box. When the value of updateNote is false, the form for creating a new note is displayed and functional instead of the edit form. Both are controlled forms. newpar,

When the user submits the edit form for a note, the callback function editNote in App.js that had been passed down is triggered. newpar,

editNote=(note)=>{ \n
let theNotes= this.state.currentNotes.filter(note=>{ \n
return note.id!==parseInt(this.state.noteId) \n
}) \n
fetch(`http://localhost:3000/notes/${parseInt(this.state.noteId)}`, { \n
method: 'PATCH', \n
headers: {
'Content-type': 'application/json', \n
'Accepts': 'application/json' \n
}, \n
body: JSON.stringify({ \n
entry: note.entry \n
}) \n
}) \n
.then(r=>r.json()) \n
.then(updatedNote=>{ \n
this.setState({ \n
currentNotes: [...theNotes, updatedNote], \n
noteId: '', \n
updateNote: !this.state.updateNote, \n
theNoteToEdit: '' \n
}) \n
}) \n
} newpar,

The filter removes the note that is being edited from the currentNotes array and stores the new array without it in a variable. When the user clicked on a note to edit, the application saved the id of the note in state in App.js, so that way we have the id necessary for making a PATCH fetch to the right url. After the patch has been sent, with the data we receive back we can reset state. I used a spread operator to update the notes in currentNotes in state. Then, I cleared the deck so that we are no longer in edit mode. The value of noteId and theNoteToEdit is set back to an empty string, and updateNote is set back to false. When the user clicks submit after entering in the edit form, the revised note appears in place of the old one, and the form for creating a new note appears. newpar,

Things left to do include working on authorization for the routes on the back end, refactoring to change the CSS layout of the page for individual parks in a user’s collection, and changing the text area for the edit form so that the text to be edited appears, not just as a placeholder, in the text box. newpar,

")


post_nine=Post.create(title: "Repeated String Function", paragraphs: "Recently, I wrote a function in response to a problem on hackerrank.com and after solving it in one way learned another way of approaching it from another developer. The function takes in a string that can repeat infinitely many times and a number that indicates the length of the string in this instance and returns the number of times the letter ‘a’ appears in the lengthened string. For example, if s is ‘aght’ and n is 7, then the string you would want to count the a’s of would be ‘aghtagh’. As I have written before, hackerrank’s test cases have been helpful in getting me to consider lots of edge cases and to make sure functions work as they are supposed to under different circumstances. In this case, it was helpful, but eventually the code I came up with was working in my console while appearing to time out and abort in the website’s environment for some of the test cases, when there were larger numbers involved. I am still not sure why this happened; it is a subject for further research. One opportunity that arose from this, however, was that I was prompted to consult the discussion board to see if other developers had insights that could clarify my confusion. As such, this is basically a post about solving a problem and then learning from someone else a much easier way of tackling it. newpar,

This is the not-DRY function I wrote that I do not recommend using, although I learned a lot from the process of thinking through it and as far as I know it is not technically wrong. A couple of curly braces at the end have been omitted. I will walk through it and then discuss the succinct solution that someone else had. newpar,

    function repeatString(s, n) { \n
        if (n===0){ \n
            return 0 \n
        } \n

        if (n%(s.length===0)){ \n
        if(s.length===1){ \n
        if(s==='a'){ \n
        return n \n
        } \n
        else{ \n
        return 0 \n
        } \n
        } \n
        let newS=[] \n
        let divided= n/s.length \n
        let i; \n
        for(i=0; i<=divided; i++){ \n
        if(i){ \n
        newS.push(s) \n
        } \n
        } \n
        if (newS.length > 1) { \n
        let thisArray=newS.join('').split(' ') \n
        let p; \n
        let theNumberOfAs=0 \n
        for(p=0; p<thisArray[0].length; p++){ \n
        if(thisArray[0][p]==='a'){ \n
        theNumberOfAs+=1 \n
        } \n
        } \n
        return theNumberOfAs \n
        } \n
        else{ \n
        let p; \n
        let theNumberOfAs=0 \n
        for(p=0; p<newS[0].length; p++){ \n
        if(newS[0][p]==='a'){
        theNumberOfAs+=1 \n
        } \n
        } \n
        return theNumberOfAs \n
        } \n
        } \n
        else { \n
        if(n<s.length){ \n
        let newString=[] \n
        let q; \n
        for(q=0; q<n; q++){ \n
        if(s[q]){ \n
        newString.push(s[q]) \n
        } \n
        } \n
        let w; \n
        let numberOfA=0 \n
        for(w=0; w<newString.length; w++){ \n
        if(newString[w]==='a'){ \n
        numberOfA+=1 \n
        } \n
        } \n
        return numberOfA \n
        } \n
        else{ \n
        let newS=[] \n
        let theNumberOfAs=0 \n
        let divided= parseInt(n/s.length) \n
        let i; \n
        for(i=0; i<=divided; i++){
        if(i){ \n
        newS.push(s) \n
        } \n
        } \n
        let remainder= n%s.length \n
        let anotherNewString=[] \n
        let q; \n
        for(q=0; q<remainder; q++){ \n
        if(s[q]){ \n
        anotherNewString.push(s[q]) \n
        } \n
        } \n
        let anotherArray= newS.concat(anotherNewString) \n
        let newStringedArray=anotherArray.join('').split(' ')
        let p; \n
        let theNumberOfA=0 \n
        for(p=0; p<newStringedArray[0].length; p++){ \n
        if(newStringedArray[0][p]==='a'){ \n
        theNumberOfA+=1 \n
        } \n
        } \n
        return theNumberOfA \n
        } newpar,

There are a few nested conditions in the code. The first condition is one I added at the end, in case anyone entered 0 for n, which means that essentially there is no point in using the function to begin with. newpar,

The second condition is to account for situations where there is no remainder when n is divided by the length of s. There are a few nested conditions within this part of the code. The first part states that if the length of n is 1, if n=== ‘a’, then ‘a’ is just repeated n number of times. Unfortunately it is not that simple the way I have it set up, since strings cannot be multiplied. But it is simpler than in some of the other cases. If n does not equal ‘a’, then there is no chance for any a’s to work their way in, so the return value is zero. newpar,

Next, I set up a for loop and an empty array in order to push the string n number of times into it before iterating over that new array to count the number of a’s in it. If s is ‘abaagt’ and n is 6, then I do not have to join and split the newS array, but if n is 12, for example, then I join and split newS first. That is because in the first case, newS will have one string nested inside an array, while in the second case there will be two strings nested inside of it and separated by a comma. I did not want to add an additional for loop to loop through each string in the array, so instead I joined the two items in the array by using the split and join methods. Then, in the for loop in both cases I could read the zero index of the array (which is the whole string inside the array) and go to each letter to ‘ask’ it whether it is an a. If it is, it ups the a count, which then gets returned. In the case where n is less than the length of s, n sets the index at which to stop looping over the string, since we do not want to read the whole string but just part of it. newpar,

The next part of the code is for when there is a remainder when n is divided by the length of s. The first part here is to get the full strings chained to each other before handling the fragment. ParseInt rounds down to the nearest integer, and that represents the full number of strings we will need. Then, I do something similar to what I did earlier to basically take a slice of s, with the remainder giving the stopping point when going through the string to count up the a’s. I concat the first array and the ‘remainder’ array, then split and join them and use a for loop to go through and count the number of times ‘a’ appears. newpar,

The next solution was posted by Anthony Nandaa on the discussion board of hackerrank.com. I hope he does not mind that I am citing his work here. newpar,

function repeatedString(s, n) { \n
const counta = (str) => str.split('') \n
.filter(c => c == 'a') \n
.length \n
const d = Math.floor(n / s.length) \n
const r = n - (s.length * d) \n
return d * counta(s) + counta(s.substr(0, r)) \n
} newpar,

https://www.hackerrank.com/challenges/repeated-string/forum?h_l=interview&playlist_slugs%5B%5D=interview-preparation-kit&playlist_slugs%5B%5D=warmup /anchor newpar,

As another user noted, instead of adding strings together to then count the a’s in the new string, which is what I did in my function, he instead counted the a’s in s after filtering through it to get them, by taking the length of the filtered array and saving it to a variable. He then multiplies that number of a’s by the quotient of n and s.length, the number of times that s should be repeated, and rounds it down to the nearest integer using Math.floor(). Then he finds the remainder and essentially takes a slice of it using the substr() method, counts the a’s in that slice and adds the one set of a’s to the other set of a’s. When I looked up substr() on the MDN, it said that it is not deprecated but is a legacy function. The .substring() and .slice() methods do the same thing. This is a quicker way of getting a portion of the string then looping through s and pushing what I want from it into a new array — as I was doing, because I am loop-crazy these days. Maybe it is the Coronavirus cabin fever. newpar,

So, thank you, Anthony, whoever you are, for showing me that I took the wrong road round but more importantly for showing me a better way. newpar,

https://www.youtube.com/embed/Qijs_0IQ-DM newpar,

")

post_eight=Post.create(title: "A Function For Filtering Out Anagrams", paragraphs: "Recently, I completed a coding challenge that asked me to write a function that takes one argument of an array of strings and filters out any anagrams before returning a sorted array. The array that is returned should have the first instance of a string that has an anagram, just not any of its distorted doppelganger friends. I have no idea when this function would be useful. Maybe if you would like to find anagrams in poems? But you would probably want the output to be a little different if that was the objective. In any case, it was a fun problem to work on. newpar,

The Poetry Foundation gives a concise definition of an anagram here: newpar,

https://www.poetryfoundation.org/learn/glossary-terms/anagram /anchor newpar,

I liked their example 'The teacher gapes at the mounds of exam pages lying before her.' That sentence alone is an argument against trying to filter anagrams out of your arrays. If I was an English teacher, I would make my students do anagram exercises. But since not all anagrams are created equal, I can see why sometimes one might want to get rid of them. newpar,

This is my solution for the attack of the anagrams at the moment: newpar,

function filteringAnagrams(anArray){ \n

let newArray=[] \n
let a; \n
for(a=0; a<anArray.length; a++){ \n
newArray.push(anArray[a].split('').sort \n
((a, b)=>{return a.localeCompare(b)})) \n
} \n

let j; \n
let anotherNewArray=[] \n
for(j=0; j<newArray.length; j++){ \n
let arrayWithoutWhiteSpace= newArray[j].filter(string=>{ \n
return string !== '' \n
}) \n
anotherNewArray.push(arrayWithoutWhiteSpace) \n
} \n

let newNewArray=[] \n
let h; \n
for(h=0;h<anotherNewArray.length; h++){ \n
if(!newNewArray.includes(anotherNewArray[h].join(''))){ \n
newNewArray.push(anotherNewArray[h].join('')) \n
} \n
} \n

let s; \n
let arrayToSort=[] \n
for(s=0; s<newNewArray.length; s++){ \n
let findMatch=anArray.find(string=>{ \n
if (string.split('').sort((a, b)=> \n
{return a.localeCompare(b)}).join('')===newNewArray[s]) \n
return string \n
}) \n
arrayToSort.push(findMatch) \n
} \n

let finalArray= arrayToSort.sort((a, b)=>{return a.localeCompare(b)}) \n
return finalArray } newpar,

Like the problem I wrote about in my last blog post, this is an exercise in for loops and also requires joining, splitting, sorting, pushing, finding, and filtering. If you do not get sick of those kinds of actions then you are probably pretty well-positioned for facing a lot of things in life — or at least I hope so, since that is the majority of what I have been doing lately. newpar,

In the first loop, I split and sorted each string in the original array so that we have an array of arrays of the letters in each of the strings stored in a variable. For example, if the array passed in was [‘aaba’, ‘a baa’, ‘cccc’, ‘dread’], then newArray, or the result of the first loop, would be [[‘a’, ‘a’, ‘a’, ‘b’ ], [‘ ’, ‘a’, ‘a’, ‘a’, ‘b’], [‘c’, ‘c’, ‘c’, ‘c’], [‘a’, ‘d’, ‘d’, ‘e’, ‘r’]]. The reason for sorting and splitting the strings is so that there is a basis for comparing words to each other to see if they are anagrams. “aaba” and “a baa” are not equivalent as they are; if I looped through the array for matches without sorting the letters, the loop would not be able to filter out their similarities, or it would require a different kind of logic to do so. Rearranging the words so that the letters are in a specific order allowed me to take stock of the components of the string. If all of the letters composing a string are the same, even if they are arranged differently in their original form, then eventually they will be filtered out. newpar,

The next loop is meant to filter out any whitespace in a string. When I googled anagram, I saw the following example. newpar,

./Images/Anagram_wikipedia.jpg this-is-an-image newpar,

Seeing this example of the word ‘anagram’ having the anagram ‘nag a ram’ made me realize that I would have to filter out whitespace. The second loop returns the same array of arrays as the last one but with with empty strings removed. So, [‘ ’, ‘a’, ‘a’, ‘a’, ‘b’] becomes [‘a’, ‘a’, ‘a’, ‘b’]. If I did not do this, then the function would not read 'aaba' and 'a baa' as anagrams and would keep both of them in the end. newpar,

In the next loop, I iterate over the array of arrays of letters, join each array of strings of letters back into strings and push all of the unique strings into a new array. For example, [[‘a’, ‘a’, ‘a’, ‘b’ ], [‘a’, ‘a’, ‘a’, ‘b’], [‘c’, ‘c’, ‘c’, ‘c’], [‘a’, ‘d’, ‘d’, ‘e’, ‘r’]] becomes ['aaab', 'adder', 'cccc']. The point here is to get rid of strings that repeat themselves (here that was 'aaab'). newpar,

The next loop compares the original array with the array returned in the previous loop to get information about how to change the original array. I loop over newNewArray (the one we got from the last loop), so that each of the items in it are compared to what is in the original array. For every index in newNewArray, I call the .find() method on the array passed into the function to get the first match for newNewArray’s current index’s string. Before making that comparison, I had to split, sort, and join the strings in the original array. Then, that match is pushed into a new array, which is then sorted and returned at the end of the function. For example, if the array we ended up with in the third loop was ['aaab', 'adder', 'cccc'], the fourth loop would visit each of the strings in that array. For each string, the original array ['aaba', 'a baa', 'cccc', 'dread'] has .find() called on it. In the body of the .find() method, I compare 'aaba' in its split, sorted, and joined form (in other words 'aaab') to the string at the index we are on in the loop. When we call .find() on the original array for the zero index, or the first position in newNewArray, 'aaab' matches 'aaba' in its reconfigured form. So, 'aaba' is pushed into arrayToSort. 'a baa' is not pushed into arrayToSort, because find() only returns the first match for which the logic in the body of the method is true. 'a baa' is second, so it is out. newpar,

This song kind of reminds me of what it is like chasing down the anagram. Maybe the moral is to not be a sheep? newpar,

https://www.youtube.com/embed/u4tNoh_Wjos newpar,

In any case, after the last loop is complete, I sort one more time to get the un-anagrammed array in order. Though I have tested the function with some different arrays being passed in, the next step for me might be to start writing tests to search for more edge cases, as there always seem to be more than I imagine!")

post_seven=Post.create(title: "The Case of the Missing Sock", paragraphs: "Lately, I have been preparing for technical interviews and coding challenges with some of the materials on hackerrank.com. This is about one of the warm-up challenges that they make available to users. It is a problem that says to write a function that, given the two parameters of an array of numbers and a number that is equal to the length of that array, will return the number of pairs (of socks, but it could very well be of anything else) in the array. It was mostly an exercise in using the for loop, but it gave me a chance to review a number of other things as well. newpar,
This is a spoiler alert, because I will go ahead a give my solution below. There are probably a lot of ways to solve the problem, but if anyone finds the way I did it helpful then so much the better. I will print the code first and then explain it in steps. newpar,

function sockMerchant(n, ar) { \n
if(n<2){ \n
return 0 \n
} \n
let arrayCount=0; \n
let firstArraySorted=ar.sort(function(a, b){ \n
return a-b} \n
) \n
let c; \n
for (c=0; c<firstArraySorted.length; c++){ \n
if (firstArraySorted[c] === firstArraySorted[firstArraySorted.length-1]){ \n
if(firstArraySorted[c] === firstArraySorted[0]){ \n
arrayCount+=1} \n
} \n
else { \n
if (firstArraySorted[c] === firstArraySorted[c+1]){ \n
arrayCount+=1 \n
} \n
} \n
} \n
if (arrayCount === firstArraySorted.length){ \n
return (firstArraySorted.length)/2 \n
} \n
let theArrays=[] \n
let i; \n
for (i=0; i<n; i++){ \n
let findMatches= ar.filter(number =>{ \n
return number === parseInt(ar[i]) \n
}) \n
if(findMatches.length >1){ \n
theArrays.push(findMatches)} \n
} \n
let sortedArrays= theArrays.sort() \n
function changeArrays(anArray){ \n
let newArray=[] \n
let s; \n
for (s=0; s<=anArray.length-1; s++){ \n
if(s!==anArray.length-1){ \n
if(anArray[s][0] !== anArray[s+1][0]){ \n
newArray.push(anArray[s]) \n
} \n
} \n
else { \n
if(anArray[s][0] !==anArray[s-(anArray.length-1)][0]){ \n
newArray.push(anArray[s]) \n
} \n
} \n
} \n
return newArray \n
} \n
let updatedArray= changeArrays(sortedArrays) \n
let anotherUpdatedArray= updatedArray.map(array=>{ \n
return parseInt(array.length/2) \n
}) \n
function sum(someArray){ \n
let total=0 \n
let a; \n
for (a=0; a<=someArray.length-1; a++){ \n
total+=someArray[a] \n
} \n
return total \n
} \n
return sum(anotherUpdatedArray) \n
} newpar,


The first conditional statement says that if the number of items in the array is less than two, then the number of pairs must be zero. So, it returns zero, and the rest of the code after that does not execute. newpar,

The following part of the code handles the case in which all of the numbers in the array are the same and n is an even number, meaning there are only pairs and no loose socks. In that case, the number of numbers in the array (n) can just be divided by 2. I sorted the array passed in as an argument so that each number in the array could be checked against the number that follows it as the array is looped over. The first part of the conditional statement says that if the number is the last one in the array it will be checked against the number in the first position in the array. If every number in the array turns out to be the same as the number after it (or in the case of the item in the last index position the same as the first number in the array), then the length of arrayCount will be equal to the length of the original array, meaning they all have a match. If this is the case, then the rest of the code after this will not run, and the function will return the quotient of n/2. I might try to re-work later parts of the code to deal with this edge case, but for now this is how I am tackling it. Something that I appreciate about hackerrank.com is that it often has several test cases to check your solution against. One of those tests is what led me to incorporate this into my solution. newpar,

In the next part of the solution, a filter is placed inside of a loop, so the array that is passed into the sockMerchant function as an argument is filtered once for every index in the array. The filter checks for any repeating numbers, but the logic entails that the number will be returned at least once, since it matches itself. If it matches not only itself (which is inevitable) but also another number, then findMatches will have multiples of the same number, such as [1, 1, 1]. That means that 1 matched itself, but the number 1 also appeared two more times in the array. If there had been only one 1 in the array, then the value of findMatches would have been [1]. The next part of the conditional states that if the length of findMatches is greater than 1, then that array should be pushed into theArrays, which becomes an array of arrays. The numbers that do not repeat and end up being a single number in an array (such as [1] or [2], etc.) are irrelevant, because they cannot be part of a pair. Since their length is not greater than one, they are not pushed into theArrays. This filter repeats for every item in the index, with the updated value of findMatches being either pushed or not pushed into theArrays depending on its length before the loop moves on to the next index and eventually gets through the whole array. newpar,

The function changeArrays reduces an array of arrays that has any repeats inside of it, to get rid of them. I had to do this, because in the last part of the code, I checked for repeat numbers multiple times. In other words, if the array to begin with was [1, 2, 1, 3, 4, 7], theArrays would equal [[1, 1], [1, 1]]. That might imply that there are two pairs of 1, when there is only one pair. There are probably other ways of dealing with this, but I decided to root out the repeat arrays in the following way to then handle the reduced set. After I define the function changeArrays, I call it, passing sortedArrays (theArrays with .sort() called on it and saved to a new variable so that the arrays that are alike are grouped together, as in [[1, 1, 1], [1, 1, 1], [2, 2], [2, 2]]) in as an argument and assigning the return from that call to the variable updatedArray. newpar,

Next, I mapped over the array of arrays (updatedArray) to get the number of pairs in each array, and I stored the new array returned from the map in a variable, anotherUpdatedArray. For example, if updatedArray is [[1, 1, 1, 1], [2, 2]], then that is transformed into [[2], [1]]. The length of the first array is 4, and that is divided by 2, indicating that there are two pairs in that array. The second array in updatedArray has a length of two, and 2/2=1, indicating that there is one pair in the second array. If any of the arrays in the array wrapping them have an odd amount of numbers, the parseInt wrapping array.length/2 rounds the quotient down to the nearest whole integer, removing any decimals. As such, when [1, 1, 1] becomes 3/2=1.5, parseInt turns that into [1]. That makes sense for us here, because it means that any remainders are loose socks and should not be counted as a pair. The updatedArray no longer tells us which numbers from the original array have matches, but we do not need to know that for the purposes of this problem. We just need to know how many pairs there are, not what the pairs themselves are. newpar,

The last thing to do is to add the separate sets of numbers of pairs that I counted up in the last part of code together. They are trapped in separate arrays in one array that wraps them at this point. One thing I could have done here would have been to flatten anotherUpdatedArray using .flat() on it before performing different logic to add the number of pairs together. But instead I wrote a function to loop through anotherUpdatedArray and add the value inside of each array to a variable called ‘total’, initially set to 0. If anotherUpdatedArray is [[2], [1]], then when the loop runs, 2 is added to the current value of ‘total’ (0) to bring it up to 2. When the loop goes to the next array, the value there, 1, is added to the current value of ‘total’, bring it up to 3. Then, the value of ‘total’ is returned at the end of the function. I wrote this out as a function and then called it, passing in anotherUpdatedArray as an argument. I did not have to make it a function, but doing this allows this part of the code to be used elsewhere inside of sockMerchant. I did not happen to need to reuse it, but if I did it would have allowed me to avoid rewriting the same logic. There are other parts of the sockMerchant function that I could try to DRY out in a similar way, but this is what I have right now. newpar,

If you prefer to wear mismatched socks or would like to create some kind of sensation amongst your customers (which I definitely do not encourage), then you could, of course, write a totally different kind of function! newpar,

")

post_six=Post.create(title: "Building a Website", paragraphs: "Over the last week or so I worked on building a website to help promote myself and inform potential employers about me. It was also a great way to continue building on my knowledge and fluency with React and Ruby on Rails while trying to take control over my own image on the internet, an admittedly impossible task but still a worthy goal. newpar,
The most challenging part of building the website was moving my blog over to it. If you are reading this on Medium, then you know that I am also still using their platform. In fact, it is much easier to use a platform that handles the hard work for me. However, I wanted to also make my blog directly available on my website. If nothing else, it was good practice solving a slew of coding issues. newpar,
The main problem I encountered when handling moving my blog posts was in the formatting of information that was stored on the back end. I was easily able to assign an attribute to the class Blog to hold the information I wanted to display, but putting line and paragraph breaks where I wanted them was something I had to figure out how to do. Also, putting images, links, and videos exactly where I wanted them posed a problem at first. I could have done all of this on the front end, but it was a lot of information to have to store there. It also made sense to put it on the back end if I was going to be displaying several blog posts and wanted to display them in similar ways, have a list of post titles, etc. There are some things that are still on the front end that I may move to the back end at a later time, such as publication information. But it seemed like an easy solution that would back-fire later on to hard code the blog information on the front end, so that option was out. newpar,
The way I ultimately ended up resolving formatting issues was to have an attribute called ‘paragraphs’ for every blog post and to provide specific markers within that long, long string to signal where I would like a new paragraph to start, where a video would be displayed, where an image would be displayed, where the text displayed was a block of code, etc. At the end of every portion of text where I wanted one paragraph to end and another one to begin I wrote ‘NEWPAR,’ except all in lowercase (I am typing it in scream case here to avoid formatting issues!). Then, on the front end, after fetching from the API and storing an array of posts in state in the parent component, I mapped over the posts to split at ‘NEWPAR,’ and display the text broken into paragraphs after filtering to delete the marker. Below is one example of this on the back end in the seed file. (Again, the uppercase is actually lowercase in my seed file. Also, disregard the pair of curly braces below.) newpar,
While that kind of greeting may raise interesting existential questions, it is not very friendly. '{}' NEWPAR, newpar,
Then, on the front end, I iterated over the seed information like this: newpar,
expandingPost=()=>{ \n
if (this.props.posts) { \n
return this.props.posts.map(post=>{ \n
let changeToArrays=post.paragraphs.split('NEWPAR,') \n
let changeTheseArrays=changeToArrays.filter(description=>{ \n
return description !=='NEWPAR' \n
})
return changeTheseArrays.map(paragraph=>{ \n
if (paragraph.includes('{')) { \n
if (paragraph.includes('\n')) { \n
let newParagraphArray= paragraph.split('\n') \n
let newArray=newParagraphArray.filter(description=>{ \n
return description !=='\n' \n
})
return <div className='coding-in-blog'>{newArray.map(line=>{ \n
return <p>{line}</p> \n
})} \n
</div> \n
} newpar,
The second part of the coding example above includes a conditional for blocks of code. Since a lot of coding examples have curly braces in them, for now I decided to let the condition be that if there is a curly brace… handle the formatting of the text in the following way. The ‘\n’ marker signaled the start of a new line, to make the code more readable. The curly brace conditional also allowed me to assign a specific class name to coding examples to style them in a way that set them off from the rest of the text. newpar,
This methodology served me well later on when building the publications section of the blog, when I wanted to italicize the title of a publication and turn the name of a co-translator into a hyperlink. newpar,
state={ \n
expandBook: false, \n
bookExpanded: [], \n
books: [{title: 'Being Nude: The Skin of Images', \n
... url: 'https://www.fordhampress.com/9780823256204/being-nude/', description: 'Being Nude: The Skin of Images /TITLE by Jean-Luc Nancy and Federico Ferrari is a Philosophy book that I co-translated with /TITLE Anne O'Byrne. /TITLE  It has nudity in different works of art as its subject matter and focuses on what these works reveal about intersubjectivity and identity. /TITLE'}, ... \n
]
} newpar,
The trailing dots in the example above are just to indicate parts of the books array that are not included in this blog. By separating the string of text with the ‘/TITLE’ marker, I was able to iterate over this information in a child component in a similar way to how I did with information that was coming from the seed file that I wanted formatted and styled in a particular way. newpar,
italicizeTheTitle=()=>{ \n
if (this.props.bookExpanded.description.includes('/TITLE')) { \n
let newDescription= this.props.bookExpanded.description.split('/TITLE') \n
let changeTheDescription=newDescription.filter(description=>{ \n
return description !=='/TITLE' \n
}) \n
return <React.Fragment> \n
<p> \n
<i>{changeTheDescription[0]}</i> \n
{changeTheDescription[1]} \n
<a className='link' target='_blank' rel='noopener noreferrer' href='https://www.stonybrook.edu/commcms/philosophy/people/_faculty/byrne.php'>{changeTheDescription[2]}</a> \n
{changeTheDescription[3]} \n
</p> \n
</React.Fragment> \n
} newpar,
The function above is entitled ‘italicizeTheTitle’, because that is what I was originally writing the function to do. I wanted to italicize one small part of the string and had to find a way to set that portion of the text off from the rest of it without making it a whole new paragraph. Now that the function is taking care of other formatting issues, I will likely rename it to reflect that change. I will probably change the ‘/TITLE’ marker to reflect the expanded role that this marker is playing in the code, as well. newpar,
So, here is my website: newpar,
https://www.carlieanglemire.com /anchor newpar,
Since this is the first time I am deploying a site on the internet, I will warn you that there may still be some issues with Heroku and Netlify, which are the sites I am using.* At the moment, however, everything appears to be up and running. newpar,
Though, the way I appear to others on the internet and in life is, of course, still largely out of my control. newpar,

*Thank you to Nicolas Feitel for helping me to launch with these resources: newpar,
https://medium.com/@nicholas.feitel /anchor newpar,
    ")

post_five=Post.create(title: "Local Storage in a National Park Trip Planner", paragraphs: "While working on my final project for Access Labs, I have been learning how to use localStorage so that users can navigate away from an app when they click on an external link and then return without having to log back in or refresh the page. This blog post is about what I have learned so far, particularly about storage that is not as permanent as saving something to the database but not as fleeting as saving something to state and not persisting it. It is a middle ground for keeping things around when you go away for a short while and want them to still be there when you come back. And if you never log out they may stay there for longer than you imagined they would. newpar, 
In the last module, we worked on saving the token and user id to localStorage, but I wanted to practice adding more to it. I started with the username, because my greeting to the user was turning into this after they navigated away from the app and returned to it, until I put it in localStorage: newpar,

./Images/Hello_again_undefined.jpg this-is-an-image newpar,
While that kind of greeting may raise interesting existential questions, it is not very friendly. newpar,
National Parks Trip Planning App /heading newpar,
The app I am making fetches from the National Park Services API on a Ruby on Rails backend in order to display a list of different parks using React on the frontend. Users can expand any of the parks on the list to get more information about them. They can click on a link to go to a National Park Services show-page or to get directions. There is a button for adding a park to your collection to help you track places you might like to go to. I am thinking of adding a feature to organize a user's park collection into long, middle, and short-term goals, places you might want to go to sooner rather than later and other places that it might take you awhile to make the time to visit. And I would like to have a text-box for each park in a user's collection for note-taking purposes. newpar,
While it hasn't been scientifically proven that adding a park to your collection effectively motivates you to go there, it doesn't hurt to try. For example, maybe eventually I will go here: newpar,

./Images/Belmont_Paul_Women's_Equality.jpg this-is-an-image newpar,

./Images/Showpage_for_park.jpg this-is-an-image newpar, 
In addition to lectures from the last module I was in  and work that I did with with Guligena Aierken for a group project, I also got help from a couple of sources on the internet when I was trying to understand how local storage works: newpar,
https://github.com/learn-co-students\nyc-dumbo-web-100719/tree/master/43-jwt-auth/ /anchor newpar,
https://github.com/GAierken/Flatiron-Shopping-Frontend /anchor newpar,
https://www.kirupa.com/html5/storing_and_retrieving_an_array_from_local_storage.htm /anchor newpar,
https://developer.mozilla.org/en-US/docs/Web/API/Window/localStorage /anchor newpar,
https://www.youtube.com/embed/AUOzvFzdIk4 newpar,

ComponentDidMount /heading newpar,
The first time that localStorage comes into play in my app is when the component mounts. A fetch happens to load the parks from the API, and the user id, username, park collection, and token are all set to the values that are stored in local storage. That is so that if you leave the app, when you come back and the page reloads everything that was set when you logged in is not lost. The park collection is parsed when it is retrieved from storage, because localStorage only stores strings, and parsing it turns it back into an array. This is important, because it makes the data easier to iterate over for different purposes later on (for example to map and filter information). newpar,
class App extends React.Component { \n

    state={ \n

    parks: [], \n

    parkClickedOn: [], \n

    isAParkExpanded: false, \n

    parkCollection: [], \n

    userId: null, \n

    username: "", \n

    token: null \n

    } \n
    componentDidMount=()=>{ \n
    fetch('http://localhost:3000/parks') \n
    .then(r => r.json()) \n
    .then(parks => { \n
    let parkCollectionParsed= \n 
    JSON.parse(localStorage.getItem('theParkCollection')) \n
    this.setState({ \n
    parks: parks.data, \n
    token: localStorage.token, \n
    userId: localStorage.userId, \n
    username: localStorage.username, \n
    parkCollection: parkCollectionParsed \n
    }) \n
    }) \n
    }
    } newpar,
    Logging In /heading newpar,
    The second time localStorage is set is when the user logs in. Here state is also set so that the DOM changes, and values are stored in localStorage so that if you leave the page they will still be there (otherwise whatever the values are that are set in componentDidMount will be there instead). These are values that you do not have access to until login, so that is why they are not set in componentDidMount - parts of the app can be accessed without logging in (such as the list of parks). After the page re-renders due to a change of state whatever values you are setting at the time of login are lost until you log out and log back in again. Unless you save to localStorage! Then there are less hoops to jump through to get what you want. Depending how much excitement you like in your life or how unnecessarily difficult you prefer for things to be, that may be a good thing. newpar,
        
        setToken = (token, id) => { \n
        localStorage.token = token; \n
        localStorage.userId = id; \n
        fetch(`http://localhost:3000/users/${id}`, { \n
        headers: { \n
        'Authorization': token \n
        } \n
        }) \n
        .then(r => r.json()) \n
        .then(user => { \n
        this.setState({ \n
        username: user.username, \n
        token: token, \n
        userId: id, \n
        parkCollection: user.park_collections \n
        }) \n
        localStorage.setItem('theParkCollection', \n
        JSON.stringify(user.park_collections)) \n
        let the_username= user.username \n
        localStorage.setItem('username', the_username) \n
        })
        } newpar,

    When using localStorage.setItem(), the first argument is a name for what you are storing - it is like naming a variable. The second argument is the value for it. Then, when you are using localStorage.getItem(), the argument in parentheses is the name it was given before. newpar,
    Logging Out /heading newpar,
    LocalStorage has to be cleared when a user logs out if you don't want information such as the username and a user's collection of National Parks to linger. The MDN documentation says that localStorage can be cleared with localStorage.clear(), but below I used .removeItem() for each piece of information. newpar,
    
    logOut=()=>{ \n
    localStorage.removeItem('userId') \n
    localStorage.removeItem('token') \n
    localStorage.removeItem('username') \n
    localStorage.removeItem('theParkCollection') \n
    localStorage.removeItem('parkCollectionForDisplay') \n
    this.setState({ \n
    userId: null, \n
    token: null, \n
    username: '', \n
    parkCollection: [], \n
    })
    } newpar,
    Everything Between the Beginning and the End /heading newpar,
    In between logging in and logging out, a lot of things can happen! Or, at least a couple things! newpar,
    https://www.youtube.com/embed/MznHdJReoeo newpar,
    Users can add or delete a park from their collection, and storage and state are set when that happens, in addition to the data being posted to the back end. LocalStorage has to be reset to make sure that if users leave the application without logging out their collection will reflect the changes they made when they come back. newpar,
    addToParkCollection=(park)=> { \n
        fetch('http://localhost:3000/park_collections', { \n
        method: 'POST', \n
        headers: { \n
        'Content-type': 'application/json', \n
        'Accepts': 'application/json' \n
        }, \n
        body: JSON.stringify({ \n
        user_id: this.state.userId, \n
        park_id: park.id \n
        }) \n
        }) \n
        .then(r=>r.json()) \n
        .then(theParkCollection => { \n
        let thisParkCollection= \n
        [...this.state.parkCollection, theParkCollection] \n
        localStorage.setItem('theParkCollection', \n
        JSON.stringify(thisParkCollection)) \n
        this.setState({ \n
        parkCollection: thisParkCollection \n
        }) \n
        })
        } newpar,
        Something similar happens when the delete button is pushed. Here I filter to return a new array without the deleted park in it for the purpose of re-setting state. ParkCollection is an array of collections that are basically instances of a user having a park. They have an id, the user_id, and the park_id as attributes. A user has_many park_collections on the backend, and a park_collection belongs to one user. On the frontend, the array of collections is what will display as one collection of parks. Since only the park_id (not the park's name or description, for example) are stored in the park_collection, work has to be done to iterate through the array of parks that are fetched from the backend to pull out more information about the parks that belong to a user. Below, when I am using the .find() method, I am dealing with making a conversion between the park that is passed in as an argument to the deleteFromCollection function (which has information such as the name, description, url, id, etc. of the park) and the park_collections in parkCollection, which only have the id of the collection, the park_id, and the user_id. I need the id of the collection for specifying the url where the delete fetch has to be sent to effectively destroy my association with any given park. newpar,
        
        deleteFromCollection=(park)=>{ \n
        let newParkCollectionArray= \n
        this.state.parkCollection.filter(the_park=>{ \n
        return the_park.park_id !== park.id \n
        }) \n
        let thisParkCollection= \n
        this.state.parkCollection.find(this_park_collection=>{ \n
        return this_park_collection.park_id === park.id \n
        }) \n
        let parkCollectionsId= thisParkCollection.id \n
        fetch(`http://localhost:3000/park_collections/${parkCollectionsId}`, { \n
        method: 'DELETE'}) \n
        .then(r=>r.json()) \n
        .then(parkCollections =>{ \n
        this.setState({ \n
        parkCollection: newParkCollectionArray \n
        }) \n
        localStorage.setItem('theParkCollection', \n
        JSON.stringify(newParkCollectionArray)) \n
        })
        } newpar,
        But don't worry, all you have to do is click a button to add the park again if you are having any regrets when it comes to your park planning preferences.
")

    post_four=Post.create(title: "Plan a Garden Application", paragraphs: "I have been working on an app for garden planning to help practice using React on the front end with a Ruby on Rails API on the backend. One of the main issues I tackled while doing this project was handling an application that had multiple sources of truth on the front-end, and I got practice using ternary expressions and doing conditional rendering to help deal with this issue. newpar,
    Users can currently view the plants that are stored in the database, log a new plant that will post to the backend and render on the frontend, delete a plant from the frontend and backend, add a plant to their garden, remove a plant from their garden, select a plant to be featured (which displays an enlarged image of the plant along with information about it toward the top of the page under the Featured Plant heading), and edit the featured plant. AND they can turn the images of plants into a picture of a cat (Just for fun and to practice creating a toggle button, and because that is what I was asked by my instructors to do during my project review)! newpar,
    Below are a few images of the main page of the application: newpar,
    
    ./Images/Top_of_page.jpg this-is-an-image newpar,
    
    ./Images/Plant_selection.jpg this-is-an-image newpar,
    Something that was enjoyable about building this app at the beginning was creating my own API for the first time with images of plants and information about them from places that I like including seedsavers.org, the Brooklyn Botanic Garden, the New York Botanical Garden, and Golden Earthworm Organic Farm. The Farmer's Almanac on-line also helped me to fill in some of the gaps, and a few of the quotes that I used as plant information are from the on-line version of the Oxford English Dictionary, with access provided by the New York Public Library. I would also like to give a shout out to Ruben Vallejo for explaining some of the fundamentals of CSS to me and to Gene Grady for helping me to understand how to set up routes for the application. newpar,
    https://medium.com/@rv.results /anchor newpar,
    https://medium.com/@grady.gene.thomas /anchor newpar,
    
    ./Images/Featured_plant.jpg this-is-an-image newpar,
    In order to display pictures under Featured Plant I added an array to the state on the parent App.js component called pictureClickedOn, and to display photographs of plants in Your Garden I added the array selectedPlants. Below is the code for setting the state on the initial page load, with the plants being fetched from the backend in the componentDidMount method. The selectedPlants and pictureClickedOn arrays are empty until a user selects a plant to be featured or added to their garden. newpar,
    
    constructor(){ \n
    super(); \n   
    this.state = { \n
    plants: [], \n
    selectedPlants: [], \n
    pictureClickedOn: [], \n
    catButtonClicked: false \n
    } \n
    } \n
    
    componentDidMount= () => { \n
    fetch('http://localhost:3000/plants') \n
    .then(r => r.json()) \n
    .then(plantsArray => { \n
    this.setState({ \n
    plants: plantsArray, \n
    }) \n
    }) \n
    } newpar,

    Adding arrays for the selectedPlants and pictureClickedOn allowed me to grab one plant from the plant selection to be featured and several plants from the choice of plants to be added to a garden. In the current state of the application, Your Garden and the featured plant do not persist, but that is something that eventually I would like to change. newpar,
    Since pictures can appear in three places on the page, I was running into issues when a plant was edited or deleted. The problem I had was that though doing a fetch to edit or delete a plant allowed me to update the plants array on the backend and front end, the selectedPlants and pictureClickedOn arrays were not automatically updating along with it. In order to fix this, I had to set the state for all of the arrays. This is the way I handled the delete action. newpar,

    deleteOnClick= (plant) => { \n
    const theUpdatedGarden= \n
    this.state.selectedPlants.filter(the_clicked_plant => { \n
        the_clicked_plant.id !== plant.id}); \n
    const plantsId= this.state.pictureClickedOn.id \n
    const theUpdatedFeaturedPlant= \n
    plantsId === plant.id ? [] : \n
    this.state.pictureClickedOn; \n
    fetch(`http://localhost:3000/plants/${plant.id}`, { \n
    method: 'DELETE' \n
    }) \n
    .then(r => r.json()) \n
    .then((newArray) => { \n
    this.setState({ \n
    plants: newArray,
    pictureClickedOn: theUpdatedFeaturedPlant, \n
    selectedPlants: theUpdatedGarden \n
    }) \n
    })
    } newpar,

    The deleteOnClick method was passed down as props from App.js to the great-grandchild component that was rendering the plant image and name to the page under the Plant Selection heading along with the two buttons to delete a plant or add it to your garden. The plant being passed in as an argument in deleteOnClick= (plant) on App.js was being passed up from the great grand-child component in a callback function to let App.js know which plant's delete button had been clicked on. Plant is the instance of a plant, and I narrowed it down to plant.id to identify it for removal from the arrays. newpar,
    The filter method in theUpdatedGarden constant allowed me to remove the plant that had been deleted from the selectedPlants array. Filter is a method that when called on an array creates a new array of items for which whatever condition that is specified is true. In this case, any plant that did not have the id of the plant passed as an argument in deleteOnClick was put into this new array, and that is the value that I set selectedPlants to when I set state. So, when a plant is deleted from Plant Selection, it is also removed from Your Garden, while the other plants currently in the garden remain there. newpar,
    https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array/filter /anchor newpar,
    The updatedFeaturedPlant constant is set equal to the return value of a ternary expression. The first condition of the ternary is indicating that if the id of the instance of the plant that has been passed up is equal to the id of the plant in the pictureClickedOn array (in other words if the plant being deleted is the plant also currently being featured), then the pictureClickedOn array should now be empty (and nothing should display to the page in the section under the Featured Plant heading). Otherwise, if the featured plant is not the one being deleted it should remain where it is and be unaffected. newpar,
    https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Operators/Conditional_Operator /anchor newpar,
    The updateSubmit function was similar, but it required me to remove the plant that was being updated from the selectedPlants array before then using a spread operator to add the altered plant back into the array. The result was that I could alter the plant in Your Garden without duplication and without affecting the other plants in the garden. Below is my updateSubmit function, which runs when the submit button for the edit featured plant form is clicked on. newpar,
    
    updateSubmit= (plant) => { \n
    const theUpdatedName= plant.name \n
    const theUpdatedImg= plant.img \n
    const theUpdatedPlantInformation= plant.plant_information \n
    const thePlants= \n
    this.state.selectedPlants.filter(the_plant => { \n
    the_plant.id !== plant.id}) \n
    const gardenPlants= \n
    this.state.selectedPlants.map(plant => { \n
    return plant.id \n
    }) \n
    const gardenUpdate=  \n
    gardenPlants.includes(plant.id) ? \n
    [...thePlants, plant] : \n
    this.state.selectedPlants \n
    fetch(`http://localhost:3000/plants/${this.state.pictureClickedOn.id}`, { \n
    method: 'PATCH', \n
    headers: { \n
    'Content-Type': 'application/json', \n
    'Accept': 'application/json' \n
    }, \n
    body: JSON.stringify({ \n
    name: theUpdatedName, \n
    img: theUpdatedImg, \n
    plant_information: theUpdatedPlantInformation \n
    }) \n
    }) \n
    .then(r => r.json()) \n
    .then((updatedPlants) => { \n
    this.setState({ \n
    plants: updatedPlants, \n
    selectedPlants: gardenUpdate, \n
    pictureClickedOn: plant \n
    }) \n
    }) 
    } newpar,
    I like this example of the spread operator from MDN: newpar,
    
    ./Images/Head_shoulders.jpg this-is-an-image newpar,
    https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Operators/Spread_syntax /anchor newpar,
    Lastly, the Turn Plants into Cats button on the navigation bar at the top of the page gave me a chance to practice toggling with a button. When a user clicks on the Turn Plants into Cats button, the pictures transform, and the text on the button itself changes from saying Turn Plants into Cats into saying Turn Cats into Plants. If there are any plants in Your Garden, they will also turn into cats. newpar,
    
    ./Images/Turn_cats_into_plants.jpg this-is-an-image newpar,
    
    ./Images/Plants_to_cats_in_plant_selection.jpg this-is-an-image newpar,
    
    ./Images/Plants_to_cats_in_garden_and_plant_selection.jpg this-is-an-image newpar,
    
    ./Images/Featured_plant.jpg this-is-an-image newpar,
    I was happy to have them as visitors, but I didn't want them to dominate the garden for too long. So, I created two functions, one for replacing the plant image url with a cat image url by setting state (but not persisting this change to the backend, so that another way of chasing the cats away would be to just refresh the page) and another for fetching the plant information from the backend again, just as I did in componentDidMount, and setting state so that the plant images would once again be displayed. A third function toggles between these two functions depending on whether the catButtonClicked array in state is true or false. newpar,
    changeToCats= () => { \n
    const toCats= this.state.plants.map(plant => { \n
    return {name: plant.name, \n
    img: 'https://scontent-lga3-1.xx.fbcdn.net/v/t31.0-8/774947_4327147871108_384379713_o.jpg?_nc_cat=103&_nc_ohc=19SjhUaMwJoAQnyA2-BXh_BOEWRN-KbtBT43IaYClPcG3JBIqlk26jkxg&_nc_ht=scontent-lga3-1.xx&oh=f24756f6eb4fe6328d41df13de4d4f6e&oe=5E98E72A', \n
    plant_information: plant.plant_information, \n
    id: plant.id} \n
    }) \n
    const gardenCats= \n
    this.state.selectedPlants.map(plant => { \n
    return {name: plant.name, \n
    img: 'https://scontent-lga3-1.xx.fbcdn.net/v/t31.0-8/774947_4327147871108_384379713_o.jpg?_nc_cat=103&_nc_ohc=19SjhUaMwJoAQnyA2-BXh_BOEWRN-KbtBT43IaYClPcG3JBIqlk26jkxg&_nc_ht=scontent-lga3-1.xx&oh=f24756f6eb4fe6328d41df13de4d4f6e&oe=5E98E72A', \n
    plant_information: plant.plant_information, \n
    id: plant.id} \n
    }) \n
    this.setState({ \n
    plants: toCats, \n
    selectedPlants: gardenCats, \n
    pictureClickedOn: [], \n
    catButtonClicked: true \n
    }) \n
    } \n
    changeBacktoPlants= () => { \n
    fetch('http://localhost:3000/plants') \n
    .then(r => r.json()) \n
    .then(plantsArray => { \n
    this.setState({ \n
    plants: plantsArray, \n
    selectedPlants: [], \n
    catButtonClicked: false \n
    }) \n
    }) \n
    } \n
    toggleCatButton= () => { \n
    return !this.state.catButtonClicked ? \n
    this.changeToCats() : this.changeBacktoPlants() \n
    } newpar,
    The toggleCatButton function was passed down as props to the NavBar.js component and is triggered as an onClick function when the button is pressed. This is in the render at the bottom of the component. newpar,
    
    {this.props.catButtonClicked ? \n
    <button className='change-to-cats-button' onClick={this.props.toggleCatButton}>Turn Cats into Plants</button> \n
    : <button className='change-to-cats-button' onClick={this.props.toggleCatButton}>Turn Plants into Cats</button>} newpar,

    There is a ternary expression to indicate which button should display, one of them with the text being Turn Cats into Plants, the other Turn Plants into Cats. The inner text on the button is the only difference between the two. They are governed by the same function. newpar,
    https://reactjs.org/docs/conditional-rendering.html /anchor newpar,
    The only drawbacks are that currently when you change the cats back into plants, the plants that were in your garden will be gone. There will also no longer be a featured plant. When I finish working on the application so that users are authenticated and can log in, I will be able to get plants to persist to a user's garden on the backend. Then, less will be lost in the bibbidi bobbidi boo of the cat button magic. But until then, one can go ahead and recreate their garden using the buttons I have provided after the cats have wrecked their havoc. newpar,
    https://www.youtube.com/embed/iXJvxEHSv5E newpar,
    ")


    post_three=Post.create(title: "Getting the Monsters Under Control in a Single-Page Application", paragraphs: "Last week I learned a lot while working on the Monsters Lab on learn.co. While I am still figuring out how to meet some of the deliverables, I thought I would post about the things I have managed to do with it so far. newpar,
        https://learn.co/tracks/web-development-immersive-3-1-module-three/classroom-materials/additional-practice/monsters /anchor newpar,
        The lab asks us to fetch from a json file to display information about the first fifty monsters in the database on the first page. There is a backwards and forwards arrow at the bottom of the page, and when a user clicks the forward button the next fifty monsters should be displayed. A user should be able to scroll backwards and forwards through the large set of monsters this way. (It would also be helpful for the person testing the code to not have to scroll all the way to the bottom of the page to see what is being displayed. That is a lot of monsters to wade through!) We are also asked to include a form so that users can generate their own monsters (sometimes we are our own worst enemy). newpar,

        In addition to the above, in order to practice CRUD (create, read, update, delete), I made a delete and update function. Users can delete monsters with the click of a button (if only it were that easy in real life!). Or they can update a monster's name, age, or biography to essentially transform its identity, at least as it exists in the database and on the page. It is important to try to keep your monsters under control in whatever way you can. This is what the beginning of the page looks like. I did not write the bios, but I love them. newpar,
        
        ./Images/Monsters_lab.jpg this-is-an-image newpar,
        When a user clicks on the Update this Monster button a form is generated like so, and when it is submitted the monster is updated in the database and on the page. newpar,
        
        ./Images/Monsters_lab_update_form.jpg this-is-an-image newpar,

        fetch('http://localhost:3000/monsters') \n
        .then(r => r.json()) \n
        .then(monstersArray => { \n
        const theMonstersArray= monstersArray \n
        let i=0 \n
        let monsterSet= theMonstersArray.slice(i, i+50) \n
        let firstSet= monsterSet.forEach(showAllMonsters) \n
        }) newpar,

       This makes it so that only the first fifty monsters are displayed when the DOM content loads. A slice takes two arguments, the index number of where the slice should start and the index number of where the slice should end. The second argument is not inclusive, and index numbers begin at zero for the first element in an array. newpar,
       https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array/slice /anchor newpar,
        To make the forward button at the bottom of the page functional, the following worked (to an extent!): newpar,
        
        let forwardButton= document.getElementById('forward') \n
        forwardButton.addEventListener('click', (event) => { \n
        i+=50 \n
        let nextFifty= monstersArray.slice(i, i+50) \n
        nextFifty.forEach(showAllMonsters) \n
        }) newpar,

        I added an event listener to the forward button so that when it is clicked, the next slice in the monstersArray is displayed. However, the issue is that the previous fifty monsters are still on the page…and that is too many monsters! I can't fight them all at once. It is too much. I also haven't worked on the backward arrow yet, so unfortunately there is no going back. Unless you refresh the page! Then you will be down to the first fifty again until you become overzealous enough to click the forward button. But this is a single-page application, so I wouldn't advice you to refresh the page to save your life. newpar,
        I will keep working on the arrow buttons and will write an update when I manage to make them work the way they are supposed to. In the meantime, I will backtrack a little to explain some of the code that I glossed over above. newpar,
        The showAllMonsters function loops through the array of monsters in the database to display the information there in an organized way on the page. Our instructor Eric warned us that using innerHTML could make us unnecessarily over-exposed to harm by all the dangerous people out there on the internet, so I got practice writing things line by line. This is the beginning of that function. We were learning JavaScript, so that is one of the reasons we were not editing the HTML file directly and instead were adding elements to the HTML through a JavaScript file. newpar,

        function showAllMonsters(monsterObj){ \n
        let aMonsterSpan= document.createElement('span') \n
        let aMonsterName= document.createElement('h2') \n
        aMonsterName.innerText= monsterObj.name \n
        let aMonsterAge= document.createElement('li') \n
        aMonsterAge.innerText= `${monsterObj.age} years old` \n
        let aMonsterBio= document.createElement('p') \n
        aMonsterBio.innerText= `Bio: ${monsterObj.description}` \n
        let deleteMonsterButton= document.createElement('button') \n
        deleteMonsterButton.innerText='Delete this monster' \n
        let updateMonsterButton= document.createElement('button') \n
        updateMonsterButton.innerText= 'Update this Monster' \n
        aMonsterSpan.append(aMonsterName, aMonsterAge, \n 
        aMonsterBio, deleteMonsterButton, updateMonsterButton) \n
        theMonsterContainer.append(aMonsterSpan)} newpar,

        theMonsterContainer is a div already written in the HTML we were given, and I captured it in a constant earlier on: newpar,
        const theMonsterContainer= document.getElementById('monster-container'). newpar,

        This was one of the first times I had to perform the gymnastics of appending some elements to a span before appending that span to a div. This was good practice for our code challenge later in the week, when the nesting of elements in the HTML was more complex and required more careful planning. newpar,
        After that, I made the forms and event listeners for creating and updating a monster. But I won't include the code for all that, because sometimes you have to fight your own battles. newpar,
        https://www.youtube.com/embed/vNuVifA7DSU  newpar,
        ")

    

    post_two=Post.create(title: "Time and Greetings in a JavaScript Function", paragraphs: "This post is about one of my first experiences handling time in JavaScript while completing the Fns as First Class Data: Do Behavior lab on Learn.co. One of the directives of the lab was to create a function that, given a time entered by a user in 24-hour format, will return a greeting appropriate for the time of day. newpar,
    
    ./Images/Directions.jpg this-is-an-image newpar,
    The lab also gives us a hint to use the .split() method and parseInt() to process the time entered: newpar,
    
    ./Images/Note.jpg this-is-an-image newpar,
    I am going to focus just on the greet function in this blog, as it gave me plenty to think about and work on. In the words of Miracle Legion, 'Just say hello. It means a lot to me.' newpar,
    The Solution I Arrived At /heading newpar,
    First, here are two solutions that I eventually arrived at (with some code that I will discuss later commented out): newpar,
   
    ./Images/Solution.jpg this-is-an-image newpar,
    
    ./Images/Another_solution.jpg this-is-an-image newpar,
    The first solution should work if I do not need an else statement returning something like TEST to signal an error. newpar,
    Before I came to the first solution, I worked on the second one, so the following explains my thought process for that.The parameter the_time would be replaced by an argument like 09:17 or 18:42 (6:42 p.m.) when a user enters the time of day, and this has to be split to remove the colon. It also has to be changed from a string into a number so the if and else statements can be formed with <, >, ≥, etc. operators to indicate what the returned greeting should be for different ranges of time. That is because these operators only work with numbers as far as I know. newpar,
    The purpose of the split method is to remove the colon, but it also breaks the argument into two separate strings that are put into an array. For example, for 16:00 the resulting array would be ['16', '00']. newpar,
    ParseInt() can then convert the strings into integers if you iterate through each number of the array by their index, for example by doing parseInt(this_time[0]) to get 16, and parseInt(this_time[1]) to get 00. Before I used .parseInt(), I used .concat() to join the two strings in the array (this time without the colon sadly separating them!), which gave me 1600. Then I was able to run that integer through the if/else statements to find the appropriate greeting. newpar,
    Misadventure #1 /heading newpar,
    Now, for some of the discoveries I made before arriving at those solutions! newpar,
    One of the mistakes I made was saving the first index and the second index of this_time to separate variables, one for the hour and one for the minutes. I thought that I could handle it that way, but it was a path that led to many misadventures. Below is one attempt to make it work. newpar,
    
    ./Images/wrong_path_for_lab_1.jpg this-is-an-image newpar,
    The Good Morning greeting was being returned reliably with this function. the Good Evening greeting was working starting at 18:00(it was supposed to be returned starting at 17:01). And between 12:00 and 17:00, Good Afternoon was being returned as long as it was on the hour (12:00, 13:00, etc.). For example, passing in 12:05 as an argument led to the result of TEST, when it should have returned Good Afternoon. newpar,
    The first else if statement was where problems were coming in. If I gave a range between 12 and 17 for the hour and did not include the part of the code involving the minutes, then if a user entered 17:12, the function returned Good Afternoon, when it should have returned Good Evening. newpar,
    Though I meant for 'the_minutes <01' to limit only the range of time for the hour of 17, it was read as applying to every hour between 12 and 17. At one point, I believe I got a slight variation of this to work somehow. However, even when it worked in my Chrome DevTools console, in the terminal where I was completing the lab it gave me the intriguing error of 'legacy octal literals are not allowed in strict mode.' It objected to being asked to process 01, or 00, etc. as a number. newpar,
    This leads me to one of my other takeaways from the lab related to .parseInt(). I had not used .parseInt() more than a couple times thus far in my learning process, so the notion of a base or radix mystified me. What I found out about this was that a radix of ten refers to the numeral system based on integers 0–9. When I experimented with this in my console, .parseInt() defaulted to a base of 10 if no argument was given for it - but refer to MDN(link below) or other documentation to get a thorough answer to what happens if you do not specify a radix. I tried changing the base to different values to see what would happen, but I was unable to understand from the output alone how the base resulted in the output it was giving me. Wikipedia gave me a glimpse of the wondrous rabbit-hole that I could have found myself going down if I had had more time to learn about different numeral systems. I encourage you all to take that journey, and I hope to join you there at some point, just not right now. newpar,
    https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/parseInt /anchor newpar,
    https://en.wikipedia.org/wiki/Radix /anchor newpar,
    Misadventure #2 /heading newpar,
    The last couple of things that I reviewed and learned more about thanks to this lab were the importance of variables and the way the .join() method works. Below is the solution I arrived at but without all of the variables in place. When I split the_time, that work was lost without a variable to hold the transformed the_time in, because the .split() method is non-destructive (it does not permanently alter what it operates on). So, none of the following operations and statements in the function work correctly later on if I do not starting saving to variables right away. newpar,
    
    ./Images/wrong_path_for_lab_2.jpg this-is-an-image newpar,
    Lastly, I tried using the .join() method before I used .concat(). I made the mistake of calling .join() instead of .join(''). You can see the different results of using one versus the other below. Also refer to the MDN for more information about ways to use this method. newpar,
    https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array/join /anchor newpar,
    
    ./Images/wrong_path_3_for_lab.jpg this-is-an-image newpar,
    At first I didn't know why .join() was not working, but testing the code in the console allowed me to see what was happening. The .join() method separates the elements that it brings together by a comma unless you specify some other way to join them in one string. 12,00 was the result of using .join() on an argument of 12:00, and this interestingly turned into 12 when I used .parseInt() on it, so people were being told Good Morning all day long. newpar,
    https://www.youtube.com/embed/wLDtuhtHTY4 newpar,
    However, .join('') (with no spaces between the quotation marks) resulted in the same string as when I used .concat(), so I could have done that. But when all else is equal, I generally consider it preferable to use methods with the word cat in them. You can decide for yourself. newpar,
    ")

    post_one=Post.create(title: "The Split Method and the Power of Punctuation", paragraphs: "This is my first blog, and it is going to be about the mysterious ways of the split method. I had the chance to learn more about this method while working on a lab called the OO Cash Register Lab during the first module of Flatiron School's Software Engineering program at Access Labs in Brooklyn, NY. So, I will write about some of my misadventures while completing that lab and what I learned about the split method along the way. newpar,
    The prompt asked us to do the following: newpar,
    
    ./Images/Lab_description.jpg this-is-an-image newpar,
    https://learn.co/tracks/module-1-web-development-immersive-2-1/object-oriented-ruby/object-s-self/oo-cash-register /anchor newpar,
    One of the methods I was supposed to write would take parameters of a title of an item, the quantity of the item, and the price of it. It was supposed to update the total price of all items combined in the shopping cart and it was also supposed to add new items to the @items array to keep track of what was in the shopping cart. newpar,
    This is the beginning of the code to get you oriented: newpar,
    
    ./Images/Beginning_of_code.jpg this-is-an-image newpar,
    This is the first method I wrote, for adding an item to the cart: newpar,
    
    ./Images/Method.jpg this-is-an-image newpar,
    And below is the small part of the above that this blog is about. Dealing with quantity was what was most difficult for me at the time. The more stuff one has, the harder it can be to keep track of it. newpar,
    First, here is what worked, and then I will go through some of the things that didn't work. The binding.pry is included to show you how the array @items ends up looking under different conditions. newpar,
    
    ./Images/Solution_first_blog.jpg this-is-an-image newpar,
    When I call binding.pry on this, this is what I see: newpar,
    
    ./Images/Solution_result.jpg this-is-an-image newpar,
    So, the tests are looking to see whether we can handle different quantities of an item, in this case books. (Anyone with towers of books surrounding them in their apartment can tell you that it is important to try to keep them organized, even if more often than not this is a losing battle!) newpar,
    Three books were added to the cart, and we see that reflected in the @items array. But it took me a long time to get to that point, so I will back up to show you some of the things that could (and did) go wrong. newpar,
    First, I explored just multiplying the title by the quantity, like so (the working code is commented out): newpar,
    
    ./Images/Title_x_quantity.jpg this-is-an-image newpar,
    But this is how that turned out: newpar,
    
    ./Images/Bookbookbook.jpg this-is-an-image newpar,
    Instead of listing three new books in the cart, I have one big triple book. (Large volumes are not easy to carry around with you to read on the train, so this is a problem!) So, I knew with the help of binding.pry that I needed to find a way to split up the three books that did not currently want to be apart. This would also have to be the case for any quantity of items, not just for the test case of books. It occurred to me thanks to Learn.co's previous lessons that there was a method for that, the split method. Below is Ruby Doc's definition of the split method. newpar,
    
    ./Images/Split_method.jpg this-is-an-image newpar,
    https://ruby-doc.org/core-2.4.0/String.html#method-i-split /anchor newpar,
    Ruby Doc gives a number of examples of ways to split a string, and I will discuss a few of them. The problem that I ran into initially after suspecting that I should somehow put the split method to use was that there was nothing to split ['bookbookbook'] by, no punctuation marks and no white space, for example. Just calling .split on the array did nothing (yes, I am sure I tried that!). Using k as a delimiter, which you can try for fun like so: newpar,
    
    ./Images/Splitting_with_k.jpg this-is-an-image newpar,
    did this: newpar,
    
    ./Images/Splitting_with_k_results.jpg this-is-an-image newpar,
    That might have been good for Halloween last week, but it is not exactly what I was looking for! Also, we might want to add items to the cart that do not have a k in them, and in that case this would also not do anything we want it to do. newpar,
    Ruby Doc tells us that we can split along white space, like this, if there is white space to serve as a delimiter: newpar,
    
    ./Images/Nows_the_time.jpg this-is-an-image newpar,
    Or, it tells us, we could split along each letter, like this: newpar,
    
    ./Images/Hello_split.jpg this-is-an-image newpar,

    to give us this: newpar,
    
    ./Images/Book_by_the_letter.jpg this-is-an-image newpar,
    But that is a little like buying a book by the chapter, too many volumes instead of too few. newpar,
    Another example of a delimiter that Ruby Doc gives us that I like, in spite of how ineffectual it would appear to be for the OO Cash Register Lab is: newpar,
    
    ./Images/Mellow_yellow.jpg this-is-an-image newpar,
    Here is a link to that song, in case you are interested. Thank you Ruby Doc. newpar,
    https://www.youtube.com/watch?v=IQNBQI3UDag /anchor newpar,
    This was all enough to get me to go back to try to interpolate my way out of the problem before again coming back to kneel at the shrine of the split method. So, I tried to interpolate a comma between the items like this: newpar,
    
    ./Images/Adding_a_comma_to_interpolation.jpg this-is-an-image newpar,
    and got this: newpar,
    
    ./Images/Interpolating_with_comma_no_split_result.jpg this-is-an-image newpar, 
    It looked like I was getting closer, so I edited the above to also include a space after the comma, like this: newpar,
    
    ./Images/Interpolating_with_comma_and_space.jpg this-is-an-image newpar,    
    to get this: newpar,
    
    ./Images/Result_for_interpolating_with_comma_and_space.jpg this-is-an-image newpar,   
    Things were looking good, and I was feeling clever; but there was still an extra comma and space at the end of the string, and I still had one string of books instead of three separate strings. This is what brought me back to the split method. newpar,   
    The split method separates your string into smaller strings and adds the commas for you while leaving off the unwanted comma at the end. I knew that the split method was the answer, even though it was giving me so many problems. newpar, 
    What I ended up realizing was that the split method speaks the language of punctuation. There are other delimiters, but punctuation is one thing it likes to work with. Since I am a beginner at software engineering, I don't know first-hand whether computers are stupid, as some people say. But I think that there is something smart about the focus that the split method has on punctuation. newpar, 
    Learning how to punctuate properly can be a difficult thing to master. It is something that as a writer and speaker, one can also overthink and in doing so miss the mark. When punctuation does not serve primarily to convey a message clearly, it can serve a stylistic purpose. It can arrest people's attention, make them unengaged, or make them wonder about something that is left hanging. Punctuation helps us to organize our thoughts. It gives them a certain speed(the urgency of the exclamation point) or forces us to take our time (commas might gather speed, but they can also make us take our time depending on the context). So, I like that the split method speaks the language of punctuation, even though it took me awhile to appreciate this, and even though there are still things about the method that are a mystery to me. newpar,  
    So, that is how I got to the final result: newpar, 
    
    ./Images/Solution_first_blog.jpg this-is-an-image newpar,   
    giving me: newpar, 
    
    ./Images/Solution_result.jpg this-is-an-image newpar,   
    I didn't have to add a space after the comma in the title interpolation, because the split method separates the strings in its resulting array according to the conventions of English grammar, or at least the grammar of arrays, with a comma and a space. Also, if I had added a space it would have actually just created other problems. newpar,
    I had to use flatten!, because without it I had a nested array, like this:  newpar,    
    
    ./Images/Results_without_flatten.jpg this-is-an-image newpar,  
    This happened without the flatten! method being used on the array, because the @items variable was set equal to an empty array. Then, the split method turned the string into an array of strings, which is what I was pushing into the empty @items array. Flatten! collapses the nested arrays into one array that can later on be iterated over to display the contents of the shopping cart or do other things. newpar,  
    In spite of enjoying discovering that the split method speaks the language of punctuation, it turns out that I could have also achieved the same result by just adding a whitespace to the interpolation and then using white space as the delimiter, like this: newpar, 
    
    ./Images/Splitting_along_white_space_copy.jpg this-is-an-image newpar,    
    Since it doesn't matter whether you use a punctuation mark or white space to serve as a delimiter, you can rely on your own preferences (or your own whims at the moment) for either punctuated or blank space. newpar,
    ")  

