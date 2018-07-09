# GenericChatModule-Twitter-
Implementation -:
-> Initially when user is landed 1st time in the app , EndPoint API is used to fetch all its messages using api -:
“"https://api.twitter.com/1.1/direct_messages/events/list.json”
-> which is been parsed into messages model and then structured into firebase database structure as followed -:
Chats -> {
	chatId: {
		name:””,
		lastMessage: {timeStamp:,senderId}
	},
}

Messages -> {
	chatId: {
		messageBody
		
	}

}

Users -> {
	userId: {
		name:
		id:
		phone:
		chatrooms:[chatroomids]
	},
       userId(involved in chatroom) : {
		Details of other user involved
	}
}


Current Project Structure -:

-> MainFiles -: Comprising of Plist Files , StoryBoards , Assets , and Starting AppDelegate File
-> HelperFiles -: It has hardcoded constants of application along with other global application function
-> NetworkManager -:  It is handling all network call which is been then send to correspondent parsers and returned to viewModel’s for updating UI.
->Navigators -: AppRouter is responsible for navigating from 1 controller to another.
-> Scenes -: There are 3 scenes in the application , LoginScene , ChatRoomScene and ChatDetailScene . Each Scene comprises ViewController , ViewModel and Views which are synced with each other to structurally render data with appropriate responsibilities handled by different layer of the application.
-> Models -: are used in different scenes to inbuilt data retrieved from network layer.


//TODO -> 
Once the data is saved for a specific user , we set up a callbackurl in firebase in nondescript which will help in accessing data whenever there is a new message created.
On receive of new message , it is been pushed in firebase database under node -: chats -: and Messages -> 
This new database update is been listen on client side which can be updated on UI.
