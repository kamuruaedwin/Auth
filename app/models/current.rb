class Current < ActiveSupport::CurrentAttributes
	attribute :user #stores the variables and attribues of the user
					# accessible from anywhere for queries, in the background jobs etc
end 