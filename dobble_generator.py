def generate_dobble_cards(n):
    cards = []

    # Generate the first set of cards
    for i in range(n):
        card = [0]
        for j in range(n):
            card.append(i * n + j + 1)
        cards.append(card)

    # Generate the second set of cards
    for i in range(n):
        for j in range(n):
            card = [i + 1]
            for k in range(n):
                card.append(n + 1 + j + n * ((i + k * j) % n))
            cards.append(card)

    # Generate the final card
    card = [n + 1]
    for i in range(n):
        card.append(n + 2 + n * i)
    cards.append(card)

    return cards

# Russian Cyrillic alphabet + numbers to have 43 symbols
cyrillic_symbols = [
    "А", "Б", "В", "Г", "Д", "Е", "Ё", "Ж", "З", "И", "Й", "К", "Л", "М", "Н", 
    "О", "П", "Р", "С", "Т", "У", "Ф", "Х", "Ц", "Ч", "Ш", "Щ", "Ъ", "Ы", "Ь", 
    "Э", "Ю", "Я", "0", "1", "2", "3", "4", "5", "6", "7", "8", "9"
]

# Generate the cards
cards = generate_dobble_cards(6)

# Translate generated cards to use Cyrillic symbols
translated_cards = []
for card in cards:
    translated_card = [cyrillic_symbols[i] for i in card]
    translated_cards.append(translated_card)

# Print the cards
for i, card in enumerate(translated_cards):
    print(f"Card {i + 1}: {card}")
