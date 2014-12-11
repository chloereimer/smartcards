object @deck

attributes(:id,:name)

child :cards, object_root: false do
  extends 'cards/show'
end
