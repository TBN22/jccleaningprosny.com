// netlify/functions/submitForm.js

const nodemailer = require('nodemailer');

exports.handler = async (event, context) => {
    if (event.httpMethod !== 'POST') {
        return {
            statusCode: 405,
            body: 'Method Not Allowed'
        };
    }

    const { form_fields } = JSON.parse(event.body);

    // Configure the email transport using the default SMTP transport and a Gmail account.
    let transporter = nodemailer.createTransport({
        service: 'gmail',
        auth: {
            user: 'talalbinnaveed2210@gmail.com', // Your email
            pass: 'NMsntf12.'   // Your email password or App Password
        }
    });

    // Email content
    let mailOptions = {
        from: 'talalbinnaveed2210@gmail.com',
        to: 'recipient-email@example.com', // Recipient email
        subject: 'New Form Submission',
        text: `
            Name: ${form_fields.name || ''}
            Last Name: ${form_fields.field_f13eef2 || ''}
            Phone Number: ${form_fields.field_2ff050b || ''}
            Email: ${form_fields.email || ''}
            Services Selected: ${form_fields.field_ff5fb4e ? form_fields.field_ff5fb4e.join(', ') : ''}
            Location: ${form_fields.message || ''}
            Message: ${form_fields.field_3d8397d || ''}
        `
    };

    // Send email
    try {
        await transporter.sendMail(mailOptions);
        return {
            statusCode: 200,
            body: 'Form submitted successfully!'
        };
    } catch (error) {
        return {
            statusCode: 500,
            body: `Failed to send email: ${error.toString()}`
        };
    }
};
