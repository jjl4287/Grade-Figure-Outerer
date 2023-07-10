#!/bin/bash
#######################################################################################################
## Section to Automate Projects

desig="${1}"
projectcol=B

    printf "rightstring A0 = \"%s\"\n"                                             "${desig}"

    printf "rightstring A1 = \"projects:\"\n"

    printf "rightstring A2 = \"yourscore:\"\n"

    printf "rightstring A3 = \"total:\"\n"

    printf "rightstring A4 = \"result:\"\n"


for project in $(cat ~/info/status/"${desig}".projects | grep ':final tally' | cut -d':' -f2); do
    mypts=$(cat ~/info/status/"${desig}".projects | grep ':final tally' | grep ":${project}:" | cut -d':' -f1)
    ttlpts=$(cat ~/info/status/"${desig}".projects | grep ':final tally' | grep ":${project}:" |  cut -d'/' -f2 | tr -d ')')

    printf "rightstring %c1 = \"%s\"\nlet %c2 = %hhu\nlet %c3 = %hhu\n"            "${projectcol}" \
								                   "${project}"    \
										   "${projectcol}" \
										   "${mypts}"      \
										   "${projectcol}" \
										   "${ttlpts}"

    if [ "${project}" != "bonus" ]; then

       printf "let %c4 = %c2/%c3*100\n"                                            "${projectcol}" \
										   "${projectcol}" \
                                                                                   "${projectcol}"
    fi

    projectcol=$(echo "${projectcol}" | tr "ABCDEFGHIJKLMNOPQR" "BCDEFGHIJKLMNOPQRS")

done

printf "rightstring %c1 = \"tally\"\n"      					   "${projectcol}"

projectcold=$(echo "${projectcol}" | tr "BCDEFGHIJKLMNOPQRS" "ABCDEFGHIJKLMNOPQR")

printf "let %c2 = @sum(B2:%c2)\n"                                                  "${projectcol}" \
										   "${projectcold}"
printf "let %c3 = @sum(B3:%c3)\n"                                                  "${projectcol}" \
                                                                                   "${projectcold}"
printf "let %c4 = %c2/%c3*100\n"                                                   "${projectcol}" \
										   "${projectcol}" \
										   "${projectcol}"
printf "rightstring %c5 = "                                                        "${projectcold}"
printf '"points/52:"'
printf "\n"
printf "let %c5 = @if(%c2/%c3*52>52,52,%c2/%c3*52)\n"                              "${projectcol}" \
                                                                                   "${projectcol}" \
                                                                                   "${projectcol}" \
                                                                                   "${projectcol}" \
                                                                                   "${projectcol}"

#######################################################################################################
## Section on Journal Automation

journalcol=B

for journal in $(cat ~/info/status/"${desig}".journal | grep ':final tally' | cut -d':' -f2); do
    myjpts=$(cat ~/info/status/"${desig}".journal | grep ':final tally' | grep ":${journal}:" | cut -d':' -f1)
    ttljpts=$(cat ~/info/status/"${desig}".journal | grep ':final tally' | grep ":${journal}:" |  cut -d'/' -f2 | tr -d ')')

    printf "rightstring %c7 = \"%s\"\nlet %c8 = %hhu\nlet %c9 = %hhu\n"            "${journalcol}" \
                                                                                   "${journal}"    \
                                                                                   "${journalcol}" \
                                                                                   "${myjpts}"      \
                                                                                   "${journalcol}" \
                                                                                   "${ttljpts}"

    journalcol=$(echo "${journalcol}" | tr "ABCDEFGHIJKLMNOPQR" "BCDEFGHIJKLMNOPQRS")

done

printf "rightstring A8 = \"yourscore:\"\nrightstring A9 = \"total:\"\nrightstring A7 = \"journal\"\n"

printf "rightstring %c7 = \"tally\"\n"                                             "${journalcol}"

journalcold=$(echo "${journalcol}" | tr "BCDEFGHIJKLMNOPQRS" "ABCDEFGHIJKLMNOPQR")

printf "let %c8 = @sum(B8:%c8)\n"                                                  "${journalcol}" \
                                                                                   "${journalcold}"
printf "let %c9 = @sum(B9:%c9)\n"                                                  "${journalcol}" \
                                                                                   "${journalcold}"
printf "let %c10 = %c8/%c9*100\n"                                                  "${journalcol}" \
                                                                                   "${journalcol}" \
                                                                                   "${journalcol}"
printf "rightstring %c10 = \"result:\"\n"                                          "${journalcold}"
printf "rightstring %c11 = \"points/13:\"\n"                                       "${journalcold}"
printf "let %c11 = @if(%c8/%c9*13>13,13,%c8/%c9*13)\n"                             "${journalcol}" \
                                                                                   "${journalcol}" \
                                                                                   "${journalcol}" \
                                                                                   "${journalcol}" \
                                                                                   "${journalcol}"




#########################################################################################################
## Section to Automate Participation

pcptcol=B

for pcpt in $(cat ~/info/status/"${desig}".participation | grep ':final tally' | cut -d':' -f2); do
    myppts=$(cat ~/info/status/"${desig}".participation | grep ':final tally' | grep ":${pcpt}:" | cut -d':' -f1)
    ttlppts=$(cat ~/info/status/"${desig}".participation | grep ':final tally' | grep ":${pcpt}:" |  cut -d'/' -f2 | tr -d ')')

    printf "rightstring %c13 = \"%s\"\nlet %c14 = %hhu\nlet %c15 = %hhu\n"         "${pcptcol}" \
                                                                                   "${pcpt}"    \
                                                                                   "${pcptcol}" \
                                                                                   "${myppts}"  \
                                                                                   "${pcptcol}" \
                                                                                   "${ttlppts}"

    pcptcol=$(echo "${pcptcol}" | tr "ABCDEFGHIJKLMNOPQR" "BCDEFGHIJKLMNOPQRS")


done

printf "rightstring A14 = \"yourscore:\"\nrightstring A15 = \"total:\"\nrightstring A13 = \"participation\"\n"

printf "rightstring %c13 = \"tally\"\n"                                            "${pcptcol}"

pcptcold=$(echo "${pcptcol}" | tr "BCDEFGHIJKLMNOPQRS" "ABCDEFGHIJKLMNOPQR")

printf "let %c14 = @sum(B14:%c14)\n"                                               "${pcptcol}" \
                                                                                   "${pcptcold}"
printf "let %c15 = @sum(B15:%c15)\n"                                               "${pcptcol}" \
                                                                                   "${pcptcold}"
printf "let %c16 = %c14/%c15*100\n"                                                "${pcptcol}" \
                                                                                   "${pcptcol}" \
                                                                                   "${pcptcol}"
printf "rightstring %c16 = \"result:\"\n"                                          "${pcptcold}"
printf "rightstring %c17 = \"points/13:\"\n"                                       "${pcptcold}"
printf "let %c17 = @if(%c14/%c15*13>13,13,%c14/%c15*13)\n"                         "${pcptcol}" \
                                                                                   "${pcptcol}" \
                                                                                   "${pcptcol}" \
                                                                                   "${pcptcol}" \
                                                                                   "${pcptcol}"
#########################################################################################################
## Section For Total Calculation

printf "rightstring %c19 = \"points/78:\"\n"                                       "${projectcold}"
printf "rightstring %c20 = \"result:\"\n"                                          "${projectcold}"
printf "let %c19 = %c5+%c11+%c17\n"                                                "${projectcol}" \
                                                                                   "${projectcol}" \
                                                                                   "${journalcol}" \
                                                                                   "${pcptcol}"
printf "let %c20 = (%c19/78)*100\n"                                                "${projectcol}" \
                                                                                   "${projectcol}"

exit 0

