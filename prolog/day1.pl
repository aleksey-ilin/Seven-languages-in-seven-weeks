# Make a simple knowledge base. Represent some of your favorite books and authors.

book(code_complete, steve_mcconnell).
book(seven_languages_in_seven_weeks, bruce_a_tate).
book(silva_method, josé_silva).
book(professional_software_development, steve_mcconnell).

# Find all books in your knowledge base written by one author.

?- book(Books, steve_mcconnell).
Books = code_complete;
Books = professional_software_development.

# Make a knowledge base representing musicians and instruments. Also represent musicians and their genre of music.

musician(мамай_артём_владимирович, ударные, рок).
musician(гайков_владимир_михайлович, ударные, классическая_музыка).
musician(войтенко_сергей_иванович, баян, шансон).
musician(август_филипп_олегович, гитара, рок).
musician(джанго, гитара, рок).


# Find all musicians who play the guitar.

?- musician(Кто, гитара, Жанр).
Кто = август_филипп_олегович,
Жанр = рок ;
Кто = джанго,
Жанр = рок.
