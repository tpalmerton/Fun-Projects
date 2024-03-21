# Problem Set 2, hangman.py
# Name: 
# Collaborators:
# Time spent:

# Hangman Game
# -----------------------------------
# Helper code
# You don't need to understand this helper code,
# but you will have to know how to use the functions
# (so be sure to read the docstrings!)
import random
import string

WORDLIST_FILENAME = "words.txt"


def load_words():
    """
    Returns a list of valid words. Words are strings of lowercase letters.
    
    Depending on the size of the word list, this function may
    take a while to finish.
    """
    print("Loading word list from file...")
    # inFile: file
    inFile = open(WORDLIST_FILENAME, 'r')
    # line: string
    line = inFile.readline()
    # wordlist: list of strings
    wordlist = line.split()
    print("  ", len(wordlist), "words loaded.")
    return wordlist



def choose_word(wordlist):
    """
    wordlist (list): list of words (strings)
    
    Returns a word from wordlist at random
    """
    return random.choice(wordlist)

# end of helper code

# -----------------------------------

# Load the list of words into the variable wordlist
# so that it can be accessed from anywhere in the program
wordlist = load_words()


def is_word_guessed(secret_word, letters_guessed):
    '''
    secret_word: string, the word the user is guessing; assumes all letters are
      lowercase
    letters_guessed: list (of letters), which letters have been guessed so far;
      assumes that all letters are lowercase
    returns: boolean, True if all the letters of secret_word are in letters_guessed;
      False otherwise
    '''
    # FILL IN YOUR CODE HERE AND DELETE "pass"
    guess = str()
    for char in secret_word:
        for letter in letters_guessed:
            if char == letter:
                guess+= char
            else:
                continue
    if guess == secret_word:
        return True
    else:
        return False



def get_guessed_word(secret_word, letters_guessed):
    '''
    secret_word: string, the word the user is guessing
    letters_guessed: list (of letters), which letters have been guessed so far
    returns: string, comprised of letters, underscores (_), and spaces that represents
      which letters in secret_word have been guessed so far.
    '''
    # FILL IN YOUR CODE HERE AND DELETE "pass"
    showbox_list = list()
    for char in secret_word:
        showbox_list.append('_ ')
    for letter in letters_guessed:
        for count, char in enumerate(secret_word):
            if letter == char:
                showbox_list[count] = letter
            else:
                continue
            
    showbox_str = ''.join(showbox_list)
    return showbox_str



def get_available_letters(letters_guessed):
    '''
    letters_guessed: list (of letters), which letters have been guessed so far
    returns: string (of letters), comprised of letters that represents which letters have not
      yet been guessed.
    '''
    # FILL IN YOUR CODE HERE AND DELETE "pass"
    english_letters = list(string.ascii_lowercase)
    
    for letter in letters_guessed:
        english_letters.remove(letter)
        
    english_letters_str = ''.join(english_letters)
    print("Available letters: ", english_letters_str)
    
    return english_letters_str
    
    

def hangman(secret_word):
    '''
    secret_word: string, the secret word to guess.
    
    Starts up an interactive game of Hangman.
    
    * At the start of the game, let the user know how many 
      letters the secret_word contains and how many guesses s/he starts with.
      
    * The user should start with 6 guesses

    * Before each round, you should display to the user how many guesses
      s/he has left and the letters that the user has not yet guessed.
    
    * Ask the user to supply one guess per round. Remember to make
      sure that the user puts in a letter!
    
    * The user should receive feedback immediately after each guess 
      about whether their guess appears in the computer's word.

    * After each guess, you should display to the user the 
      partially guessed word so far.
    
    Follows the other limitations detailed in the problem write-up.
    '''
    # FILL IN YOUR CODE HERE AND DELETE "pass"
    secret_word = choose_word(wordlist)
    letters_guessed = list()
    warnings_remaining = 3
    guesses_remaining = 6
    good_guess = 0
    print('''
    ----------------------------------------------
    Welcome to Hangman!\n 
    Im thinking of a word that is %d letters long
    -----------------------------------------------''' % len(secret_word))
    print(secret_word)
    while not is_word_guessed(secret_word, letters_guessed) and guesses_remaining > 0:
        print("\nYou have %d guesses left."% guesses_remaining)
        get_available_letters(letters_guessed)
        letter = str.lower(input("Please guess a letter: "))
    
        if not letter or letter not in string.ascii_lowercase:
            if warnings_remaining != 0:
                warnings_remaining -= 1
                print("This is not a valid letter. You have % warnings left" % warnings_remaining)
            else:
                print("That is not a valid letter. You have no warnings left, you will lose one guess.")
                guesses_remaining -= 1
                    
        elif letter in letters_guessed:
            if warnings_remaining != 0:
                warnings_remaining -= 1
                print("You've already guessed that letter. You have %d warning left." % warnings_remaining)
            else:
                print("You've already guessed that letter. You have no warning left, so you lose one guess.")
                guesses_remaining -= 1
                                
        else:
            letters_guessed.append(letter)
            if letter not in secret_word:
                print("That letter is not in my word.")
                if letter in 'aiueo':
                    guesses_remaining -= 2
                else:
                    guesses_remaining -= 1
            else:
                print("Good guess!")
                good_guess += 1 
                                                    
        print(get_guessed_word(secret_word, letters_guessed)) 
        print("\n---------------------------------------------------------\n")
    
        if is_word_guessed(secret_word, letters_guessed):
            print("Congratulations, you won!")
            print("Your total score for this game is %d." % (good_guess * guesses_remaining))
            again= input("Do you want to play again? ")
            if again == 'yes' or again == 'Yes' or again == 'YES':
                hangman(secret_word)
            else:
                break
    
        if guesses_remaining == 0:
            print("Sorry, you ran out of guesses. The word was %s." % secret_word)
            again= input("Do you want to play again? ")
            if again == 'yes' or again == 'Yes' or again == 'YES':
                hangman(secret_word)
            else:
                break


# When you've completed your hangman function, scroll down to the bottom
# of the file and uncomment the first two lines to test
#(hint: you might want to pick your own
# secret_word while you're doing your own testing)


# -----------------------------------



def match_with_gaps(my_word, other_word):
    '''
    my_word: string with _ characters, current guess of secret word
    other_word: string, regular English word
    returns: boolean, True if all the actual letters of my_word match the 
        corresponding letters of other_word, or the letter is the special symbol
        _ , and my_word and other_word are of the same length;
        False otherwise: 
    '''
    # FILL IN YOUR CODE HERE AND DELETE "pass"
    my_word_stripped = my_word.replace(" ","")
    same_char = list()
    blank_stripped = list()
    if len(my_word_stripped) == len(other_word):
        for index, letter in enumerate(my_word_stripped):
            if letter in string.ascii_lowercase:
                same_char.append(index)
            else:
                blank_stripped.append(index)
    else:
        return False
    
    mws = ''
    ow = ''
    
    for index_same in same_char:
        for index_dif in blank_stripped:
            if other_word[index_dif] == other_word[index_same]:
                return False
            else:
                mws += my_word_stripped[index_same]
                ow += other_word[index_same]
    if mws == ow:
        return True
    else:
        return False
        



def show_possible_matches(my_word):
    '''
    my_word: string with _ characters, current guess of secret word
    returns: nothing, but should print out every word in wordlist that matches my_word
             Keep in mind that in hangman when a letter is guessed, all the positions
             at which that letter occurs in the secret word are revealed.
             Therefore, the hidden letter(_ ) cannot be one of the letters in the word
             that has already been revealed.

    '''
    # FILL IN YOUR CODE HERE AND DELETE "pass"
    possible_matches = list()
    for i in wordlist:
        if match_with_gaps(my_word, i):
            possible_matches.append(i)
    
    spm = ' '.join(possible_matches)
    
    return spm



def hangman_with_hints(secret_word):
    '''
    secret_word: string, the secret word to guess.
    
    Starts up an interactive game of Hangman.
    
    * At the start of the game, let the user know how many 
      letters the secret_word contains and how many guesses s/he starts with.
      
    * The user should start with 6 guesses
    
    * Before each round, you should display to the user how many guesses
      s/he has left and the letters that the user has not yet guessed.
    
    * Ask the user to supply one guess per round. Make sure to check that the user guesses a letter
      
    * The user should receive feedback immediately after each guess 
      about whether their guess appears in the computer's word.

    * After each guess, you should display to the user the 
      partially guessed word so far.
      
    * If the guess is the symbol *, print out all words in wordlist that
      matches the current guessed word. 
    
    Follows the other limitations detailed in the problem write-up.
    '''
    # FILL IN YOUR CODE HERE AND DELETE "pass"
    secret_word = choose_word(wordlist)
    letters_guessed = list()
    warnings_remaining = 3
    guesses_remaining = 6
    good_guess = 0
    print('''
    ----------------------------------------------
    Welcome to Hangman!\n 
    Im thinking of a word that is %d letters long\n
    If you need a hint, type * instead of a letter
    -----------------------------------------------''' % len(secret_word))
    #print(secret_word)
    while not is_word_guessed(secret_word, letters_guessed) and guesses_remaining > 0:
        print("\nYou have %d guesses left."% guesses_remaining)
        get_available_letters(letters_guessed)
        letter = str.lower(input("Please guess a letter: "))
        
        if letter == "*":
            print("possible words are:", show_possible_matches(get_guessed_word(secret_word, letters_guessed)))
    
        elif not letter or letter not in string.ascii_lowercase:
            if warnings_remaining != 0:
                warnings_remaining -= 1
                print("This is not a valid letter. You have % warnings left" % warnings_remaining)
            else:
                print("That is not a valid letter. You have no warnings left, you will lose one guess.")
                guesses_remaining -= 1
                    
        elif letter in letters_guessed:
            if warnings_remaining != 0:
                warnings_remaining -= 1
                print("You've already guessed that letter. You have %d warning left." % warnings_remaining)
            else:
                print("You've already guessed that letter. You have no warning left, so you lose one guess.")
                guesses_remaining -= 1
                                
        else:
            letters_guessed.append(letter)
            if letter not in secret_word:
                print("That letter is not in my word.")
                if letter in 'aiueo':
                    guesses_remaining -= 2
                else:
                    guesses_remaining -= 1
            else:
                print("Good guess!")
                good_guess += 1 
                                                    
        print(get_guessed_word(secret_word, letters_guessed)) 
        print("\n---------------------------------------------------------\n")
    
        if is_word_guessed(secret_word, letters_guessed):
            print("Congratulations, you won!")
            print("Your total score for this game is %d." % (good_guess * guesses_remaining))
            again= input("Do you want to play again? ")
            if again == 'yes' or again == 'Yes' or again == 'YES':
                hangman(secret_word)
            else:
                break
    
        if guesses_remaining == 0:
            print("Sorry, you ran out of guesses. The word was %s." % secret_word)
            again= input("Do you want to play again? ")
            if again == 'yes' or again == 'Yes' or again == 'YES':
                hangman_with_hints(secret_word)
            else:
                break



# When you've completed your hangman_with_hint function, comment the two similar
# lines above that were used to run the hangman function, and then uncomment
# these two lines and run this file to test!
# Hint: You might want to pick your own secret_word while you're testing.


if __name__ == "__main__":
    # pass

    # To test part 2, comment out the pass line above and
    # uncomment the following two lines.
    
    # secret_word = choose_word(wordlist)
    # hangman(secret_word)

###############
    
    # To test part 3 re-comment out the above lines and 
    # uncomment the following two lines. 
    
    secret_word = choose_word(wordlist)
    hangman_with_hints(secret_word)
