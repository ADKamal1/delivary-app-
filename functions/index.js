const functions = require('firebase-functions');
const admin = require('firebase-admin');
admin.initializeApp(functions.config().firebase);


exports.helloWorld = functions.database.ref(
    'orders/{id}').onCreate((snapshot, context) => {
    msgData = snapshot.val();

      admin.database.ref('orders').get().then((snapshot2) => {
        var tokens = [];
        if (snapshot2.empty) {
            console.log('No Device');
        }else {
           // for (var token of snapshot.docs) {
                tokens.push(msgData.token);
          //  }
            const payload = {
                notification : {
                    title  : "حجز جديد فى الارزخانة",
                    body   : " لديك حجز يوم",
                    badge  : '1',
                    sound  : "default"
                }
            }
        }
        return admin.messaging().sendToDevice(tokens, payload).then((response) => {
            console.log('Pushed them all');
            return response;
        }).catch((err) => {
             console.log(err)

        });
    }).catch((err) => {
        return console.log(err)
    });
    return snapshot;
});

