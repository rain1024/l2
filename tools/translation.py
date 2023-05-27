from easynmt import EasyNMT
model = EasyNMT('opus-mt')

#Translate a single sentence to German
print(model.translate('C’est papa, ça ?', target_lang='en'))

#Translate several sentences to German
# sentences = ['You can define a list with sentences.',
#              'All sentences are translated to your target language.',
#              'Note, you could also mix the languages of the sentences.']
# print(model.translate(sentences, target_lang='de'))

# m2 = EasyNMT('mbart50_m2m')
# print(m2.translate('Oui, on s’est déjà croisés.', target_lang='en'))
