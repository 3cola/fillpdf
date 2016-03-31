if(Meteor.isServer){
  Meteor.startup(function(){
    var userCount = Meteor.users.find().count()
    if (userCount == 0) {
      console.log("initialising first user...");
      resultId = Accounts.createUser({
        username: 'admin',
        email: Config.adminEmail,
        password: "password"
      });
      Roles.setUserRoles(resultId, 'admin')
      console.log("first admin user created : "+Config.adminEmail);
      Accounts.sendResetPasswordEmail(resultId);
      console.log("an email has been sent to "+Config.adminEmail+" to reset the default admin password.");
    }
  });
}
