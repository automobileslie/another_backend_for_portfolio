
Post.destroy_all
Project.destroy_all


project_one=Project.create(title: "Plan a Garden", description: "This is an application designed to help users imagine the kind of garden that they would like to create and then start to plan it. The idea for it came from the avid gardening I did last summer and from my appreciation of the community gardens all over New York City." , video: "PlanAGardenVideo", image: "./Images/Azaleas.jpg")

project_two=Project.create(title: "Book and Movie Memory Bank", description: "The Book and Movie Memory Bank was inspired by some of my experiences planning courses when I was a Philosophy instructor and writing essays as a student. Occasionally, I would end up mining my memory when deciding what to teach, trying to remember the name of a film I saw years ago that would be especially relevant for a particular class. Or, as I was writing I would be reminded of an idea from an essay or book and would rack my brain or have to rummage through my notes trying to find the title of it. The Book and Movie Memory Log is a place to store information about films or books that have made an impact on you, that you know you want to remember and may want to return to for various purposes later on." , video: "BookandMovieMemoryBankVideo", image: "./Images/Book_and_Movie_Memory_Bank.jpg")

project_three=Project.create(title:  "National Park Trip Planner", description: "National Parks Trip Planner provides information about national parks in the United States, fetching from the National Park Service API and also linking to the National Park Service website. Users can save parks that they would like to go to or to learn more about and take notes on saved parks as they plan a trip. The idea for this application came from my eagerness to get outdoors. I like that National Parks are low-cost and offer educational opportunities about both history and nature.", video: "NationalParksDemo", image: "./Images/United_States.jpg")

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
    address= 'https://developer.nps.gov/api/v1/parks?&API_KEY=#{ENV['NPS_API_KEY']}&q=' \n
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

./Images/Search_Bar_with_Cave.jpg newpar,

./Images/Search_Results_for_Cave.jpg newpar,

./Images/Oregon_Caves.jpg newpar,


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

./Images/Anagram_wikipedia.jpg newpar,

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
./Images/Hello_again_undefined.jpg newpar,
While that kind of greeting may raise interesting existential questions, it is not very friendly. newpar,
National Parks Trip Planning App /heading newpar,
The app I am making fetches from the National Park Services API on a Ruby on Rails backend in order to display a list of different parks using React on the frontend. Users can expand any of the parks on the list to get more information about them. They can click on a link to go to a National Park Services show-page or to get directions. There is a button for adding a park to your collection to help you track places you might like to go to. I am thinking of adding a feature to organize a user's park collection into long, middle, and short-term goals, places you might want to go to sooner rather than later and other places that it might take you awhile to make the time to visit. And I would like to have a text-box for each park in a user's collection for note-taking purposes. newpar,
While it hasn't been scientifically proven that adding a park to your collection effectively motivates you to go there, it doesn't hurt to try. For example, maybe eventually I will go here: newpar,
./Images/Belmont_Paul_Women's_Equality.jpg newpar,
./Images/Showpage_for_park.jpg newpar, 
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
    ./Images/Top_of_page.jpg newpar,
    ./Images/Plant_selection.jpg newpar,
    Something that was enjoyable about building this app at the beginning was creating my own API for the first time with images of plants and information about them from places that I like including seedsavers.org, the Brooklyn Botanic Garden, the New York Botanical Garden, and Golden Earthworm Organic Farm. The Farmer's Almanac on-line also helped me to fill in some of the gaps, and a few of the quotes that I used as plant information are from the on-line version of the Oxford English Dictionary, with access provided by the New York Public Library. I would also like to give a shout out to Ruben Vallejo for explaining some of the fundamentals of CSS to me and to Gene Grady for helping me to understand how to set up routes for the application. newpar,
    https://medium.com/@rv.results /anchor newpar,
    https://medium.com/@grady.gene.thomas /anchor newpar,
    ./Images/Featured_plant.jpg newpar,
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
    ./Images/Head_shoulders.jpg newpar,
    https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Operators/Spread_syntax /anchor newpar,
    Lastly, the Turn Plants into Cats button on the navigation bar at the top of the page gave me a chance to practice toggling with a button. When a user clicks on the Turn Plants into Cats button, the pictures transform, and the text on the button itself changes from saying Turn Plants into Cats into saying Turn Cats into Plants. If there are any plants in Your Garden, they will also turn into cats. newpar,
    ./Images/Turn_cats_into_plants.jpg newpar,
    ./Images/Plants_to_cats_in_plant_selection.jpg newpar,
    ./Images/Plants_to_cats_in_garden_and_plant_selection.jpg newpar,
    ./Images/Featured_plant.jpg newpar,
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
        ./Images/Monsters_lab.jpg newpar,
        When a user clicks on the Update this Monster button a form is generated like so, and when it is submitted the monster is updated in the database and on the page. newpar,
        ./Images/Monsters_lab_update_form.jpg newpar,

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
    ./Images/Directions.jpg newpar,
    The lab also gives us a hint to use the .split() method and parseInt() to process the time entered: newpar,
    ./Images\note.jpg newpar,
    I am going to focus just on the greet function in this blog, as it gave me plenty to think about and work on. In the words of Miracle Legion, 'Just say hello. It means a lot to me.' newpar,
    The Solution I Arrived At /heading newpar,
    First, here are two solutions that I eventually arrived at (with some code that I will discuss later commented out): newpar,
    ./Images/Solution.jpg newpar,
    ./Images/Another_solution.jpg newpar,
    The first solution should work if I do not need an else statement returning something like TEST to signal an error. newpar,
    Before I came to the first solution, I worked on the second one, so the following explains my thought process for that.The parameter the_time would be replaced by an argument like 09:17 or 18:42 (6:42 p.m.) when a user enters the time of day, and this has to be split to remove the colon. It also has to be changed from a string into a number so the if and else statements can be formed with <, >, ≥, etc. operators to indicate what the returned greeting should be for different ranges of time. That is because these operators only work with numbers as far as I know. newpar,
    The purpose of the split method is to remove the colon, but it also breaks the argument into two separate strings that are put into an array. For example, for 16:00 the resulting array would be ['16', '00']. newpar,
    ParseInt() can then convert the strings into integers if you iterate through each number of the array by their index, for example by doing parseInt(this_time[0]) to get 16, and parseInt(this_time[1]) to get 00. Before I used .parseInt(), I used .concat() to join the two strings in the array (this time without the colon sadly separating them!), which gave me 1600. Then I was able to run that integer through the if/else statements to find the appropriate greeting. newpar,
    Misadventure #1 /heading newpar,
    Now, for some of the discoveries I made before arriving at those solutions! newpar,
    One of the mistakes I made was saving the first index and the second index of this_time to separate variables, one for the hour and one for the minutes. I thought that I could handle it that way, but it was a path that led to many misadventures. Below is one attempt to make it work. newpar,
    ./Images/wrong_path_for_lab_1.jpg newpar,
    The Good Morning greeting was being returned reliably with this function. the Good Evening greeting was working starting at 18:00(it was supposed to be returned starting at 17:01). And between 12:00 and 17:00, Good Afternoon was being returned as long as it was on the hour (12:00, 13:00, etc.). For example, passing in 12:05 as an argument led to the result of TEST, when it should have returned Good Afternoon. newpar,
    The first else if statement was where problems were coming in. If I gave a range between 12 and 17 for the hour and did not include the part of the code involving the minutes, then if a user entered 17:12, the function returned Good Afternoon, when it should have returned Good Evening. newpar,
    Though I meant for 'the_minutes <01' to limit only the range of time for the hour of 17, it was read as applying to every hour between 12 and 17. At one point, I believe I got a slight variation of this to work somehow. However, even when it worked in my Chrome DevTools console, in the terminal where I was completing the lab it gave me the intriguing error of 'legacy octal literals are not allowed in strict mode.' It objected to being asked to process 01, or 00, etc. as a number. newpar,
    This leads me to one of my other takeaways from the lab related to .parseInt(). I had not used .parseInt() more than a couple times thus far in my learning process, so the notion of a base or radix mystified me. What I found out about this was that a radix of ten refers to the numeral system based on integers 0–9. When I experimented with this in my console, .parseInt() defaulted to a base of 10 if no argument was given for it - but refer to MDN(link below) or other documentation to get a thorough answer to what happens if you do not specify a radix. I tried changing the base to different values to see what would happen, but I was unable to understand from the output alone how the base resulted in the output it was giving me. Wikipedia gave me a glimpse of the wondrous rabbit-hole that I could have found myself going down if I had had more time to learn about different numeral systems. I encourage you all to take that journey, and I hope to join you there at some point, just not right now. newpar,
    https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/parseInt /anchor newpar,
    https://en.wikipedia.org/wiki/Radix /anchor newpar,
    Misadventure #2 /heading newpar,
    The last couple of things that I reviewed and learned more about thanks to this lab were the importance of variables and the way the .join() method works. Below is the solution I arrived at but without all of the variables in place. When I split the_time, that work was lost without a variable to hold the transformed the_time in, because the .split() method is non-destructive (it does not permanently alter what it operates on). So, none of the following operations and statements in the function work correctly later on if I do not starting saving to variables right away. newpar,
    ./Images/wrong_path_for_lab_2.jpg newpar,
    Lastly, I tried using the .join() method before I used .concat(). I made the mistake of calling .join() instead of .join(''). You can see the different results of using one versus the other below. Also refer to the MDN for more information about ways to use this method. newpar,
    https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array/join /anchor newpar,
    ./Images/wrong_path_3_for_lab.jpg newpar,
    At first I didn't know why .join() was not working, but testing the code in the console allowed me to see what was happening. The .join() method separates the elements that it brings together by a comma unless you specify some other way to join them in one string. 12,00 was the result of using .join() on an argument of 12:00, and this interestingly turned into 12 when I used .parseInt() on it, so people were being told Good Morning all day long. newpar,
    https://www.youtube.com/embed/wLDtuhtHTY4 newpar,
    However, .join('') (with no spaces between the quotation marks) resulted in the same string as when I used .concat(), so I could have done that. But when all else is equal, I generally consider it preferable to use methods with the word cat in them. You can decide for yourself. newpar,
    ")

    post_one=Post.create(title: "The Split Method and the Power of Punctuation", paragraphs: "This is my first blog, and it is going to be about the mysterious ways of the split method. I had the chance to learn more about this method while working on a lab called the OO Cash Register Lab during the first module of Flatiron School's Software Engineering program at Access Labs in Brooklyn, NY. So, I will write about some of my misadventures while completing that lab and what I learned about the split method along the way. newpar,
    The prompt asked us to do the following: newpar,
    ./Images/Lab_description.jpg newpar,
    https://learn.co/tracks/module-1-web-development-immersive-2-1/object-oriented-ruby/object-s-self/oo-cash-register /anchor newpar,
    One of the methods I was supposed to write would take parameters of a title of an item, the quantity of the item, and the price of it. It was supposed to update the total price of all items combined in the shopping cart and it was also supposed to add new items to the @items array to keep track of what was in the shopping cart. newpar,
    This is the beginning of the code to get you oriented: newpar,
    ./Images/Beginning_of_code.jpg newpar,
    This is the first method I wrote, for adding an item to the cart: newpar,
    ./Images/Method.jpg newpar,
    And below is the small part of the above that this blog is about. Dealing with quantity was what was most difficult for me at the time. The more stuff one has, the harder it can be to keep track of it. newpar,
    First, here is what worked, and then I will go through some of the things that didn't work. The binding.pry is included to show you how the array @items ends up looking under different conditions. newpar,
    ./Images/Solution_first_blog.jpg newpar,
    When I call binding.pry on this, this is what I see: newpar,
    ./Images/Solution_result.jpg newpar,
    So, the tests are looking to see whether we can handle different quantities of an item, in this case books. (Anyone with towers of books surrounding them in their apartment can tell you that it is important to try to keep them organized, even if more often than not this is a losing battle!) newpar,
    Three books were added to the cart, and we see that reflected in the @items array. But it took me a long time to get to that point, so I will back up to show you some of the things that could (and did) go wrong. newpar,
    First, I explored just multiplying the title by the quantity, like so (the working code is commented out): newpar,
    ./Images/Title_x_quantity.jpg newpar,
    But this is how that turned out: newpar,
    ./Images/Bookbookbook.jpg newpar,
    Instead of listing three new books in the cart, I have one big triple book. (Large volumes are not easy to carry around with you to read on the train, so this is a problem!) So, I knew with the help of binding.pry that I needed to find a way to split up the three books that did not currently want to be apart. This would also have to be the case for any quantity of items, not just for the test case of books. It occurred to me thanks to Learn.co's previous lessons that there was a method for that, the split method. Below is Ruby Doc's definition of the split method. newpar,
    ./Images/Split_method.jpg newpar,
    https://ruby-doc.org/core-2.4.0/String.html#method-i-split /anchor newpar,
    Ruby Doc gives a number of examples of ways to split a string, and I will discuss a few of them. The problem that I ran into initially after suspecting that I should somehow put the split method to use was that there was nothing to split ['bookbookbook'] by, no punctuation marks and no white space, for example. Just calling .split on the array did nothing (yes, I am sure I tried that!). Using k as a delimiter, which you can try for fun like so: newpar,
    ./Images/Splitting_with_k.jpg newpar,
    did this: newpar,
    ./Images/Splitting_with_k_results.jpg newpar,
    That might have been good for Halloween last week, but it is not exactly what I was looking for! Also, we might want to add items to the cart that do not have a k in them, and in that case this would also not do anything we want it to do. newpar,
    Ruby Doc tells us that we can split along white space, like this, if there is white space to serve as a delimiter: newpar,
    ./Images\nows_the_time.jpg newpar,
    Or, it tells us, we could split along each letter, like this: newpar,
    ./Images/Hello_split.jpg newpar,
    to give us this: newpar,
    ./Images/Book_by_the_letter.jpg newpar,
    But that is a little like buying a book by the chapter, too many volumes instead of too few. newpar,
    Another example of a delimiter that Ruby Doc gives us that I like, in spite of how ineffectual it would appear to be for the OO Cash Register Lab is: newpar,
    ./Images/Mellow_yellow.jpg newpar,
    Here is a link to that song, in case you are interested. Thank you Ruby Doc. newpar,
    https://www.youtube.com/watch?v=IQNBQI3UDag /anchor newpar,
    This was all enough to get me to go back to try to interpolate my way out of the problem before again coming back to kneel at the shrine of the split method. So, I tried to interpolate a comma between the items like this: newpar,
    ./Images/Adding_a_comma_to_interpolation.jpg newpar,
    and got this: newpar,
    ./Images/Interpolating_with_comma_no_split_result.jpg newpar, 
    It looked like I was getting closer, so I edited the above to also include a space after the comma, like this: newpar,
    ./Images/Interpolating_with_comma_and_space.jpg newpar,    
    to get this: newpar,
    ./Images/Result_for_interpolating_with_comma_and_space.jpg newpar,   
    Things were looking good, and I was feeling clever; but there was still an extra comma and space at the end of the string, and I still had one string of books instead of three separate strings. This is what brought me back to the split method. newpar,   
    The split method separates your string into smaller strings and adds the commas for you while leaving off the unwanted comma at the end. I knew that the split method was the answer, even though it was giving me so many problems. newpar, 
    What I ended up realizing was that the split method speaks the language of punctuation. There are other delimiters, but punctuation is one thing it likes to work with. Since I am a beginner at software engineering, I don't know first-hand whether computers are stupid, as some people say. But I think that there is something smart about the focus that the split method has on punctuation. newpar, 
    Learning how to punctuate properly can be a difficult thing to master. It is something that as a writer and speaker, one can also overthink and in doing so miss the mark. When punctuation does not serve primarily to convey a message clearly, it can serve a stylistic purpose. It can arrest people's attention, make them unengaged, or make them wonder about something that is left hanging. Punctuation helps us to organize our thoughts. It gives them a certain speed(the urgency of the exclamation point) or forces us to take our time (commas might gather speed, but they can also make us take our time depending on the context). So, I like that the split method speaks the language of punctuation, even though it took me awhile to appreciate this, and even though there are still things about the method that are a mystery to me. newpar,  
    So, that is how I got to the final result: newpar, 
    ./Images/Solution_first_blog.jpg newpar,   
    giving me: newpar, 
    ./Images/Solution_result.jpg newpar,   
    I didn't have to add a space after the comma in the title interpolation, because the split method separates the strings in its resulting array according to the conventions of English grammar, or at least the grammar of arrays, with a comma and a space. Also, if I had added a space it would have actually just created other problems. newpar,
    I had to use flatten!, because without it I had a nested array, like this:  newpar,    
    ./Images/Results_without_flatten.jpg newpar,  
    This happened without the flatten! method being used on the array, because the @items variable was set equal to an empty array. Then, the split method turned the string into an array of strings, which is what I was pushing into the empty @items array. Flatten! collapses the nested arrays into one array that can later on be iterated over to display the contents of the shopping cart or do other things. newpar,  
    In spite of enjoying discovering that the split method speaks the language of punctuation, it turns out that I could have also achieved the same result by just adding a whitespace to the interpolation and then using white space as the delimiter, like this: newpar, 
    ./Images/Splitting_along_white_space_copy.jpg newpar,    
    Since it doesn't matter whether you use a punctuation mark or white space to serve as a delimiter, you can rely on your own preferences (or your own whims at the moment) for either punctuated or blank space. newpar,
    ")  

