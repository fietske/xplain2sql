indexing

	description: "Xplain attribute which is an extension"

	author:     "Berend de Boer <berend@pobox.com>"
	copyright:  "Copyright (c) 1999, Berend de Boer"
	date:       "$Date: "
	revision:   "$Revision: "


class

	XPLAIN_EXTENSION_ATTRIBUTE

inherit

	XPLAIN_ATTRIBUTE
		rename
			make as inherited_make
			-- , abstracttype as extension
		redefine
			-- extension,
			is_extension,
			write_drop
		end

create

	make

feature {NONE} -- Initialization

	make (an_extension: XPLAIN_EXTENSION) is
		require
			valid_extension: an_extension /= Void
		do
			inherited_make (Void, an_extension, False, True, False, False)
		end


feature -- Status

	is_extension: BOOLEAN is True
			-- Column generated by extend statement.


feature -- Access

	extension: XPLAIN_EXTENSION is
		do
			Result ?= abstracttype
		ensure
			extension_not_void: Result /= Void
		end

	-- I should be able to rename abstracttype to extension and define this:
	--extension: XPLAIN_EXTENSION
	-- But SE doesn't allow that


feature {XPLAIN_TYPE} -- Xplain type controlled SQL code generation

	write_drop (sqlgenerator: SQL_GENERATOR; a_type: XPLAIN_TYPE) is
		do
			sqlgenerator.write_drop_extension (extension)
		end

end