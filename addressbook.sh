
#!/bin/sh

print_list() {
  reset
  echo "(0) - List all Address Book entry"
  echo "(1) - Search Address Book"
  echo "(2) - Add an Address Book entry"
  echo "(3) - Edit an Address Book entry"
  echo "(4) - Remove an Address Book entry"
  echo "(5) - For quit the app, press 5, goodbye..."

  echo "Select the number of your choice on the list, or quit by pressing q"
}
show_record(){
  cat address.txt
}
read_record() {

  RECORD=$1
  ID=$(nl address.txt | grep -w $RECORD | awk '{print $2}')
  NAME=$(nl address.txt | grep -w $RECORD | awk '{print $3}')
  PHONE=$(nl address.txt | grep -w $RECORD | awk '{print $4}')

  echo "Id: $ID , Name: $NAME , Phone: $PHONE"
}

insert_record() {
  echo "please enter id"
  read ID
  echo "please enter name "
  read NAME
  echo "please enter phone number "
  read PHONE 
  echo "Adding address book entry..."
  echo "$ID $NAME $PHONE" >> address.txt
  echo "data inserted!"
}
edit_record() {
  DATA=$1
  echo "Enter new value"
  read VALUE
  echo "Editing address book entry"
  sed -i "s/$DATA/$VALUE/" address.txt
}

remove_record() {
  DATA=$1
 echo "$DATA"
  echo "Removing address book entry"
  sed -i "/$DATA/d" address.txt
}

go_back() {
    echo "press any key to go to menu"
    read menu
    print_list
    read CHOICE
}

echo "Welcome to Addressbook app v1 ..."

print_list

read CHOICE

while [ $CHOICE -ne 5 ]
do
  if [ $CHOICE -eq 0 ]; then
    show_record 
    go_back
    elif [ $CHOICE -eq 1 ]; then
    echo "please enter either id,name or phone number"
    read QUERY
    read_record $QUERY
    go_back
    elif [ $CHOICE -eq 2 ]; then
      insert_record
      go_back
    elif [ $CHOICE -eq 3 ]; then
      echo "please enter either id,name or phone number that you want to edit"
      read USER
      edit_record $USER
      go_back
    elif [ $CHOICE -eq 4 ]; then
      echo "please enter either id,name or phone number of user that you want to remove"
      read USER
      remove_record $USER
      go_back
    else 
      exit 0
  fi
done
