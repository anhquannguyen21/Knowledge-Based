class KnowledgeBase:
	def __init__(self, listSentences):
		self.sentences = listSentences
		self.index = {}
		i = 0
		for s in self.sentences:
			for c in s.sentence:
				if not c in self.index:
					self.index[c] = []
				self.index[c].append(i)
			i = i + 1
		self.chunk = []

	def __search(self, key):
		return self.index[key] if key in self.index else []

	def size(self):
		return len(self.sentences)

	def push(self, anotherKB):
		i = self.size()

		self.chunk.append(i)

		for s in anotherKB.sentences:
			for c in s.sentence:
				if not c in self.index:
					self.index[c] = []
				self.index[c].append(i)
			i = i + 1

		self.sentences = self.sentences + anotherKB.sentences

	def addToSet(self, hashSet):
		for s in self.sentences:
			hashSet.add(s)

	def resolve(self, anotherKB, hashSet):
		res = []
		hasEmpty = False
		for s in self.sentences:
			for c in s.sentence:
				index = anotherKB.__search(-c)
				for i in index:
					newSentence = s.resolve(anotherKB.sentences[i], c)
					if newSentence.isTrue() == True:
						continue
					if newSentence.isEmpty() == True:
						hasEmpty = True
					if not newSentence in hashSet:
						res.append(newSentence)
						hashSet.add(newSentence)

		return res, hasEmpty

	def printChunksToFile(self, filename, offset):
		self.chunk.append(self.size())

		with open(filename, "w") as f:
			for ind in range(len(self.chunk) - 1 - offset):
				i = ind + offset
				n = self.chunk[i + 1] - self.chunk[i]
				f.write(str(n) + '\n')
				for j in range(n):
					f.write(self.sentences[j + self.chunk[i]].clausify() + '\n')

		self.chunk.pop()