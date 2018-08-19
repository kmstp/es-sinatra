class UserCommandHandler < Sequent::CommandHandler
  on CreateUser do |command|
    repository.add_aggregate User.new(command)
  end

  on UpdatePassword do |command|
    do_with_aggregate(command, User) do |user|
      user.update_password(command)
    end
  end
end
