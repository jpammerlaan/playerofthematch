messages = [
    "Celeste Split",
    "Celeste Split",
    "Mick snel",
    "Mick Snel",
    "Jet",
    "Celeste de beste",
    "Jet Hendriks !! (Groetjes ex neefje van Marjolijn kroon)",
    "Jacco Boonstra player of the match!",
    "Celeste split",
    "Yoran Willemsen",
    "Player of the Match\nCeleste Split",
    "Celeste split natuurlijk",
    "Celeste Split",
    "Hendriks Player of the Match"
]

from fuzzywuzzy import process
import csv

def get_player_list():
    with open('input/player_list.csv', 'rb') as f:
        reader = csv.reader(f)
        return list(reader)[0]
player_options = get_player_list()
for message in messages:
    print message
    best_player_match, match_value = process.extractOne(message, player_options)
    print best_player_match
    print match_value