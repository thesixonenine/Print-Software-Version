import os


def main():
    software_name = os.getenv('softwareName')
    command = os.getenv('command')
    command_version = os.getenv('commandVersion')
    with open("software", "a", encoding="UTF-8") as f:
        f.write(software_name + "," + command + "," + command_version + "\n")


if __name__ == "__main__":
    main()
    os.system('git config --global user.name ' + os.getenv('GIT_NAME'))
    os.system('git config --global user.email ' + os.getenv('GIT_EMAIL'))
    os.system('git add software')
    os.system('git commit -am \'add software version\'')
    os.system('git push')