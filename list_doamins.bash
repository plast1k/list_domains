    #!/usr/bin/env bash
    ##variables
    domain_mirror=$domain.txt
    domain=$1
    ##functions go here
     
    ##banner function
    banner()
    {
    echo -e "\033[34m\t\t#############################################
    \t\t##this script search for domains and subdomain ##
    \t\t##        as seen from a given website         ##
    \t\t##           inspiration:list-urls.py          ##
    \t\t##                 author:plast1k              ##
    \t\t##+++++++++++++++++++++++++++++++++++++++++++++##
    \033[0m"
     
    }
     
    ##usage function
    usage()
    {
    echo -e ""
    echo -e "USAGE: $./list_domains.sh domain"
    echo -e "example: user@box:~$./list_domain.sh mysite.com"
    echo -e ""
    }
     
    ##download function
    download()
    {
    wget http://$domain -O $domain_mirror -o /dev/null
    }
     
    ##matching_domain_purser function
    matching_domain_purser()
    {
    grep "href=" $domain_mirror  | cut -d "/" -f 3 | grep $domain | sort -u | cut -d " " -f 1 | sed s'/\"//g' | sort -u | sed s'/ //g'
    }
     
    ##unmatching_domain_purser function
    unmatching_domain_purser()
    {
    grep "href=" $domain_mirror  | cut -d "/" -f 3 | cut -d " " -f 1 | grep "\." | sed s'/"//g' | sort -u | grep -v $domain | egrep -v  '[!,@,#,$,%,^,&,*,(,),{,},[,[,<,>,?,=]'
    }
     
    ##results display function
    display()
    {
    echo -e "getting a local copy of $domain index page.........."
    download
    echo -e "Done!"
    echo -e ""
    echo -e "\033[31mrelated domains found on http://www.$domain\033[0m"
    echo -e ""
    matching_domain_purser
    echo -e ""
    echo -e "\033[31mother domains found on http://www.$domain \033[0m"
    echo -e ""
    unmatching_domain_purser
    echo -e ""
    }
     
    ##clean up function
    clean_up()
    {
    rm  -rf $domain_mirror
    }
     
    ##master function
    master()
    {
    banner
    display
    clean_up
    }
     
    ###################################
    ########script entrance############
    if [ $# == 1 ]
    then
    #run call master
    master
    else
    banner
    usage
    fi
