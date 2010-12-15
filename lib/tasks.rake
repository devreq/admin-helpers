namespace :admin_helpers do
  desc "Copy assets to public in production"
  task :cp_assets do
    from = File.join(AdminHelpers::Railtie.root, "public")
    to = File.join(Rails.root)
    FileUtils.cp_r(from, to, :verbose => true)
  end

  desc "Create symbolic links to assets public dir"
  task :ln_assets do
    from = File.join(AdminHelpers::Railtie.root, "public", "images", "admin")
    to = File.join(Rails.root, "public", "images")
    FileUtils.ln_s(from, to, :verbose => true)

    from = File.join(AdminHelpers::Railtie.root, "public", "stylesheets", "admin")
    to = File.join(Rails.root, "public", "stylesheets")
    FileUtils.ln_s(from, to, :verbose => true)
  end  
end