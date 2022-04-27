def cipher(string, shift = 0)
end

def shiftedAlphabet(shift = 0)
    alphabet = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
    shiftedAlphabet = alphabet[shift..-1] + alphabet[0..shift-1]
    p shiftedAlphabet
end

shiftedAlphabet(1)