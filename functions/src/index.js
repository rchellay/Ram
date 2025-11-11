const functions = require("firebase-functions");
const admin = require("firebase-admin");
const stripe = require("stripe")("YOUR_STRIPE_SECRET_KEY"); // Placeholder
admin.initializeApp();

// ... (previous Stripe functions)

exports.newMissionNotification = functions.firestore
  .document("missions/{missionId}")
  .onCreate(async (snap, context) => {
    const mission = snap.data();
    const message = {
      notification: {
        title: "Nueva Misión Disponible",
        body: `El club '${mission.club}' ha publicado una nueva misión de scouting en tu zona.`,
      },
      topic: "new_missions", // Or target specific users
    };

    return admin.messaging().send(message);
  });

exports.missionAcceptedNotification = functions.firestore
  .document("missions/{missionId}")
  .onUpdate(async (change, context) => {
    const mission = change.after.data();
    const previousMission = change.before.data();

    if (mission.status === "accepted" && previousMission.status !== "accepted") {
      const message = {
        notification: {
          title: "¡Misión Aceptada!",
          body: `Tu misión para el partido '${mission.match}' ha sido aceptada.`,
        },
        topic: `user_${mission.creatorId}`, // Target the mission creator
      };
      return admin.messaging().send(message);
    }
    return null;
  });
