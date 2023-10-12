from flask import Flask, render_template, request

app = Flask(__name__)

@app.route('/')
def credit_card_form():
    return render_template('credit_card_form.html')

@app.route('/', methods=['POST'])
def credit_card_form_post():
    card_number = request.form['card_number']
    card_holder = request.form['card_holder']
    exp_date = request.form['exp_date']
    cvv = request.form['cvv']

    # Here you can add any validation or processing logic for the credit card input

    return 'Card Number: {}, Card Holder Name: {}, Expiration Date: {}, CVV: {}'.format(card_number, card_holder, exp_date, cvv)

if __name__ == '__main__':
    app.run(host='0.0.0.0')


