module Test
  module Quality
    module Tools
      # Test for the 'bigfiles' tool within the quality gem
      module Punchlist
        def punchlist_expected_args
          "--glob '" + expected_source_and_doc_files_glob +
            "' --exclude-glob '{**/vendor/**,db/schema.rb}'"
        end

        def expect_punchlist_run(quality_checker)
          @mocks[:quality_checker_class]
            .expects(:new).with('punchlist',
                                { args: punchlist_expected_args },
                                'metrics',
                                false)
            .returns(quality_checker)
          @mocks[:config]
            .expects(:punchlist_regexp).returns('a|b')
            .at_least(1)
          @mocks[:config]
            .expects(:source_and_doc_files).returns(%w(a.md b.rb))
            .at_least(1)
        end
      end
    end
  end
end
