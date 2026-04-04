# frozen_string_literal: true

module Cerberus
  module Generators
    class Migrations
      def install!(plugin, to)
        Dir[File.join(migrations_path(plugin), '*.rb')].each { |file| copy_migration(file, to) }
      end

      private

      def migrations_path(plugin)
        File.expand_path("migrations/#{plugin}", __dir__)
      end

      def copy_migration(file, target_dir)
        filename = File.basename(file).sub(/^\d{3}_/, '')
        return if migration_exists?(filename, target_dir)

        target = File.join(target_dir, timestamped(filename))
        FileUtils.cp(file, target)
      end

      def migration_exists?(filename, target_dir)
        Dir[File.join(target_dir, "*_#{filename}")].any?
      end

      def timestamped(filename)
        "#{Time.now.utc.strftime('%Y%m%d%H%M%S')}_#{filename}"
      end
    end
  end
end
