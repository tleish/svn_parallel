require "svn_parallel/version"

module SvnParallel

  class Update
    def initialize(root_dir=nil)
      @root_dir = root_dir
      puts svn_updates
    end

    def self.run(root_dir)
      SvnParallel::Update.new(root_dir)
    end

    private

    def svn_updates
      svn_update_commands
      .map { |cmd| [cmd, Thread.new { `#{cmd}` }] }
      .map { |cmd, thread| "#{cmd}\n#{thread.value}" }.join("\n")
    end

    def svn_update_commands
      cd_root_dir + svn_update_externals + svn_update_current_dir
    end

    def cd_root_dir
      @root_dir ? ["cd #{@root_dir}"] : []
    end

    def svn_update_current_dir
      #['svn up . --ignore-externals 2>&1']
      ['svn up . --ignore-externals']
    end

    def svn_update_externals
      #external_directories.map { |d| "cd #{d} && svn up 2>&1" }
      external_directories.map { |d| "cd #{d} && svn up" }
    end

    def external_directories
      dirs = svn_propget_externals
      .map { |xd, exts| exts.strip.split(/\s*\n/).map { |l| xd + '/' + l.split(/\s+/).last } }
      .inject { |a, b| a + b }
      dirs || []
    end

    def svn_propget_externals
      return [] if externals_hash.nil?
      externals_hash.map { |xd, ps| [xd, `svn pg svn:externals #{xd}| grep -v ^#`] }
    end

    def externals_hash
      @proplist_hash ||= proplist_hash.select { |d, ps| ps.include? 'svn:externals' }
    end

    def proplist_hash
      svn_proplist.inject({}) { |h, (d, p)| h[d] = p.strip.split(/\s+/); h }
    end

    def svn_proplist
      `svn pl -R`.scan(/\S.*'(.*)':\n((?:  .*\n)+)/)
    end

  end

end
