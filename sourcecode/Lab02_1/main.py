import sys, getopt

import knowledgeBase
import sentence


def addNegativeAlphaToKb(kb, alpha):
	for s in alpha:
		kb.append(sentence.Sentence([-s]))


def pl_resolution(kb, alpha):
	# store existed sentences hashes
	hashSet = set()
	# store existed sentences
	base = knowledgeBase.KnowledgeBase([])
	# new store new sentences created after a loop
	# initialized with the given sentences and negative alpha
	addNegativeAlphaToKb(kb, alpha)
	newBase = knowledgeBase.KnowledgeBase(kb)
	newBase.addToSet(hashSet)
	# result of kb entials alpha
	res = None
	# loop until result is comfirmed
	while res is None:
		# resolve return new sentences created with
		# sentences in base1 resolve sentences in base2
		# and a boolean check if empty sentence exists
		new, hasEmpty1 = base.resolve(newBase, hashSet)
		new2, hasEmpty2 = newBase.resolve(newBase, hashSet)
		# concat new sentences
		new += new2
		# if exist an empty sentence, result is true
		if hasEmpty1 or hasEmpty2:
			res = True
		# if no new sentence is created, result if false
		if len(new) == 0:
			res = False
		# push previous new sentences to knowledgebase
		base.push(newBase)
		# new sentences base is newly created sentences
		newBase = knowledgeBase.KnowledgeBase(new)

	base.push(newBase)
	return res, base


def handleArgv(argv):
	inputfile = ''
   	outputfile = ''
   	
   	try:
	  	opts, args = getopt.getopt(argv,"hi:o:",["ifile=","ofile="])
   	except getopt.GetoptError:
		print 'main.py -i <inputfile> -o <outputfile>'
		sys.exit(2)
   	for opt, arg in opts:
		if opt == '-h':
			print 'main.py -i <inputfile> -o <outputfile>'
			sys.exit()
		elif opt in ("-i", "--ifile"):
			inputfile = arg
		elif opt in ("-o", "--ofile"):
			outputfile = arg

	if inputfile == '' or outputfile == '':
		print 'main.py -i <inputfile> -o <outputfile>'
		sys.exit()

	return inputfile, outputfile


def number(str):
	str = str.strip()
	n = ord(str[-1])
	return n if len(str) == 1 else -n


def input(inputfile):
	kb = []
	with open(inputfile) as f:
		alpha = [number(x) for x in next(f).split('OR')]
		n = int(next(f))
		for line in f:
			clause = [number(x) for x in line.split('OR')]
			kb.append(sentence.Sentence(clause))
	return kb, alpha


def output(outputfile, res, base):
	base.printChunksToFile(outputfile, 1)

	with open(outputfile, "a") as f:
		if res == True:
			f.write("YES")
		else:
			f.write("NO")


def main(argv):
	inputfile, outputfile = handleArgv(argv)
	
	kb, alpha = input(inputfile)
	
	res, base = pl_resolution(kb, alpha)

	output(outputfile, res, base)


if __name__ == '__main__':
	main(sys.argv[1:])