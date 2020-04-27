class Sentence:
	def __init__(self, sentence, alwaysTrue=False):
		self.sentence = sentence
		self.alwaysTrue = alwaysTrue

	def __repr__(self):
		return self.stringify()

	def __str__(self):
		return self.stringify()

	def __eq__(self, other):
		n = self.size()

		if n != other.size():
			return False

		for i in range(n):
			if self.sentence[i] != other.sentence[i]:
				return False

		return True

	def __ne__(self, other):
		return not self.__eq__(other)

	def __hash__(self):
		return hash(self.stringify())

	def clausify(self):
		if self.isEmpty():
			return "{}"

		res = ''
		for s in self.sentence[:-1]:
			tmp = chr(abs(s))
			res += (('-' + tmp) if s < 0 else tmp) + ' OR '
		tmp = chr(abs(self.sentence[-1]))
		res += ('-' + tmp) if self.sentence[-1] < 0 else tmp
		return res

	def stringify(self):
		res = ''
		for s in self.sentence:
			res += str(s)
		return res

	def size(self):
		return len(self.sentence)

	def isEmpty(self):
		return len(self.sentence) == 0

	def isTrue(self):
		return self.alwaysTrue

	def resolve(self, another, clause):
		clause = abs(clause)
		i = 0; j = 0; m = self.size(); n = another.size()
		res = []

		prev = 0
		while i < m and j < n:
			tmp1 = abs(self.sentence[i])
			tmp2 = abs(another.sentence[j])
			if tmp1 <= tmp2:
				if tmp1 != clause:
					if prev + self.sentence[i] == 0:
						return Sentence([], True)
					if prev != self.sentence[i]:
						prev = self.sentence[i]
						res.append(prev)
				i = i + 1
			else:
				if tmp2 != clause:
					if prev + another.sentence[j] == 0:
						return Sentence([], True)
					if prev != another.sentence[j]:
						prev = another.sentence[j]
						res.append(prev)
				j = j + 1

		while i < m:
			tmp = abs(self.sentence[i])
			if tmp != clause:
				if prev + self.sentence[i] == 0:
					return Sentence([], True)
				if prev != self.sentence[i]:
					prev = self.sentence[i]
					res.append(prev)
			i = i + 1

		while j < n:
			tmp = abs(another.sentence[j])
			if tmp != clause:
				if prev + another.sentence[j] == 0:
					return Sentence([], True)
				if prev != another.sentence[j]:
					prev = another.sentence[j]
					res.append(prev)
			j = j + 1

		return Sentence(res)