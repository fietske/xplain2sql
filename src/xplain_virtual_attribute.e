indexing

  description: "Xplain attribute which is an assertion"

  author:     "Berend de Boer <berend@pobox.com>"
  copyright:  "Copyright (c) 2001-2009, Berend de Boer"


class

	XPLAIN_VIRTUAL_ATTRIBUTE


inherit

	XPLAIN_ATTRIBUTE
		rename
			make as inherited_make
		redefine
			is_assertion,
			write_drop
		end


create

	make


feature {NONE} -- Initialization

	make (an_assertion: XPLAIN_ASSERTION) is
			-- Initialise.
		require
			valid_assertion: an_assertion /= Void
		local
			f: XPLAIN_EXTENSION_FUNCTION_EXPRESSION
			required: BOOLEAN
		do
			-- Assertions can usually be joined to the type, except when
			-- the some function is used: in that case we might have a
			-- situation where there is no data, so that must be a left
			-- outer join which we can trigger by making this assertion
			-- not required.
			-- Another case is when a where expression is used and the
			-- resulting view doesn't contain all rows.
			-- Easiest now is to simply force a left outer join when
			-- using a virtual attribute, and this can be optimised when
			-- this proves detrimental.
			-- 			if an_assertion.is_function or else an_assertion.expression. then
-- 				f ?= an_assertion.expression
-- 				if f.selection.function.is_some then
-- 					required := False
-- 				end
-- 			end
			required := False
			inherited_make (Void, an_assertion, False, required, False, False)
		end


feature

	is_assertion: BOOLEAN is True
			-- column generated by assert statement

	write_drop (sqlgenerator: SQL_GENERATOR; a_type: XPLAIN_TYPE) is
		do
			abstracttype.write_drop (sqlgenerator)
		end


end
