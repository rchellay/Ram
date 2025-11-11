const functions = require("firebase-functions");
const admin = require("firebase-admin");
const stripe = require("stripe")("YOUR_STRIPE_SECRET_KEY"); // Placeholder
admin.initializeApp();

exports.createStripeAccount = functions.https.onCall(async (data, context) => {
  if (!context.auth) {
    throw new functions.https.HttpsError(
      "unauthenticated",
      "The function must be called while authenticated."
    );
  }

  const account = await stripe.accounts.create({
    type: "express",
    email: context.auth.token.email,
  });

  const accountLink = await stripe.accountLinks.create({
    account: account.id,
    refresh_url: "https://spymatch.com/reauth", // Placeholder
    return_url: "https://spymatch.com/return", // Placeholder
    type: "account_onboarding",
  });

  return { url: accountLink.url };
});

exports.createStripeCheckout = functions.https.onCall(async (data, context) => {
  if (!context.auth) {
    throw new functions.https.HttpsError(
      "unauthenticated",
      "The function must be called while authenticated."
    );
  }

  const session = await stripe.checkout.sessions.create({
    payment_method_types: ["card"],
    line_items: [
      {
        price: "YOUR_PRICE_ID", // Placeholder
        quantity: 1,
      },
    ],
    mode: "subscription",
    success_url: "https://spymatch.com/success", // Placeholder
    cancel_url: "https://spymatch.com/cancel", // Placeholder
    client_reference_id: context.auth.uid,
  });

  return { url: session.url };
});
