# Nice to have String methods.
class String
    def substring_of?(other)
        # Motto: "When in doubt, sort". Damn you, Perl.
        # Motto v2: "When in doubt, have fun (with recursion)" :-)

        # Recursive helper to find if xs is a substring of ys.
        def helper(xs, ys)
            x = xs.shift
            y = ys.shift

            if    x.nil? then true # Bottom.
            elsif y.nil? then false # Couldn't find all chars.
            elsif x == y then helper(xs, ys) # Found char.
            elsif x > y  then helper(x + xs, ys) # Maybe later char.
            elsif x < y  then false # Impossible to find char.
            end
        end

        helper(self.sort, other.sort)
    end

    # Like Array#shift.
    def shift
        first = self[0]
        rest  = self[1..-1] || ''

        self.replace(rest)

        first
    end

    def sort
        self.chars.sort.join
    end
end

$anagram_letters = "poultry outwits ants".delete!(' ').sort.freeze

class String
    def could_work?
        self.substring_of?($anagram_letters.dup)
    end
end

# Remove duplicates in wordlist.
`sort wordlist | uniq > sorted-unique-wordlist` unless File.exists?('sorted-unique-wordlist')

# Make a "filtered-wordlist" of words that uses only letters from
# $anagram_letters.
begin
    could_work = File.open('filtered-wordlist', 'w')

    File.foreach('sorted-unique-wordlist') do |word_with_newline|
        word = word_with_newline.chomp

        could_work.puts(word) if word.could_work?
    end
ensure
    could_work.close
end unless File.exists?('filtered-wordlist')


# More String helpers.
require 'digest'
class String
    def same_chars?(other)
        # Avoid sorting when obviously false.
        return false unless self.length == other.length

        self.sort == other.sort
    end

    def the_answer?
        Digest::MD5.hexdigest(self) == '4624d200580677270a54ccff86b9610e'
    end
end

# Find and test anagrams.
begin
    # Manually run through i = 1, 2, ... until the answer is found.
    i = 3

    acceptable_words = File.readlines('filtered-wordlist').map{|l| l.chomp}

    # I'm getting pragmatic.
    acceptable_words.combination(i).each do |combination|
        if combination.join.same_chars?($anagram_letters)
            # Gimme progress bar.
            p "#{Time.now}: Found #{combination.join(' ')}"

            combination.permutation.each do |perm|
                if perm.join(' ').the_answer?
                    # Indentation level horror!
                    p perm.join(' ')
                    exit 0
                end
            end
        end
    end
end
