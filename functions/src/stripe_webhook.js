const functions = require("firebase-functions");
const admin = require("firebase-admin");
const stripe = require("stripe")("YOUR_STRIPE_SECRET_KEY"); // Placeholder

exports.stripeWebhook = functions.https.onRequest(async (req, res) => {
  const sig = req.headers["stripe-signature"];

  let event;

  try {
    event = stripe.webhooks.constructEvent(
      req.rawBody,
      sig,
      "YOUR_WEBHOOK_SECRET" // Placeholder
    );
  } catch (err) {
    res.status(400).send(`Webhook Error: ${err.message}`);
    return;
  }

  if (event.type === "checkout.session.completed") {
    const session = event.data.object;
    const userId = session.client_reference_id;

    await admin
      .firestore()
      .collection("users")
      .doc(userId)
      .update({ isPro: true });
  }

  res.status(200).send();
});
