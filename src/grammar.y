%{   
    #include <string.h>
%}

%token TEXTO RUTA URL XLINK VIDEODATA IMAGEDATA DOCTYPE C_REF
%token A_ARTICLE        C_ARTICLE
%token A_INFO           C_INFO
%token A_TITLE          C_TITLE
%token A_ABSTRACT       C_ABSTRACT 
%token A_PARA           C_PARA
%token A_AUTHOR         C_AUTHOR
%token A_PERSONNAME     C_PERSONNAME
%token A_FIRSTNAME      C_FIRSTNAME
%token A_SURNAME        C_SURNAME
%token A_DATE           C_DATE
%token A_SECTION        C_SECTION
%token A_SIMSECTION     C_SIMSECTION
%token A_COPYRIGHT      C_COPYRIGHT
%token A_ADDRESS        C_ADDRESS
%token A_CITY           C_CITY
%token A_STATE          C_STATE
%token A_POSTCODE       C_POSTCODE
%token A_STREET         C_STREET
%token A_EMAIL          C_EMAIL
%token A_PHONE          C_PHONE
%token A_ITEMIZEDLIST   C_ITEMIZEDLIST
%token A_LISTITEM       C_LISTITEM
%token A_EMPHASIS       C_EMPHASIS
%token A_HOLDER         C_HOLDER
%token A_SIMPARA        C_SIMPARA
%token A_YEAR           C_YEAR
%token A_COMMENT        C_COMMENT
%token A_IMPORTANT      C_IMPORTANT
%token A_LINK           C_LINK
%token A_MEDIAOBJECT    C_MEDIAOBJECT
%token A_VIDEOOBJECT    C_VIDEOOBJECT
%token A_IMAGEOBJECT    C_IMAGEOBJECT
%token A_INFORMALTABLE  C_INFORMALTABLE
%token A_TGROUP         C_TGROUP
%token A_ROW            C_ROW
%token A_TABLE          C_TABLE
%token A_THEAD          C_THEAD
%token A_TFOOT          C_TFOOT
%token A_TBODY          C_TBODY  
%token A_ENTRYTBL       C_ENTRYTBL
%token A_ENTRY          C_ENTRY

%start sigma

%%

sigma:
     DOCTYPE article
;

article: 
    A_ARTICLE info      title       content     section     C_ARTICLE 
|   A_ARTICLE info      title       content     simsection  C_ARTICLE 
|   A_ARTICLE info      title       content                 C_ARTICLE 
|   A_ARTICLE info      content     section                 C_ARTICLE 
|   A_ARTICLE info      content     simsection              C_ARTICLE 
|   A_ARTICLE info      content                             C_ARTICLE 
|   A_ARTICLE title     content     section                 C_ARTICLE 
|   A_ARTICLE title     content     simsection              C_ARTICLE 
|   A_ARTICLE title     content                             C_ARTICLE 
|   A_ARTICLE content   section                             C_ARTICLE 
|   A_ARTICLE content   simsection                          C_ARTICLE 
|   A_ARTICLE content                                       C_ARTICLE 
;

content:
    itemizedlist    content | itemizedlist
|   important       content | important
|   para            content | para
|   simpara         content | simpara
|   address         content | address
|   mediaobject     content | mediaobject
|   informaltable   content | informaltable
|   comment         content | comment
|   abstract        content | abstract
;

section: 
    A_SECTION info      title       content     section     C_SECTION
|   A_SECTION info      title       content     simsection  C_SECTION
|   A_SECTION info      content     section                 C_SECTION
|   A_SECTION info      content     simsection              C_SECTION
|   A_SECTION info      content                             C_SECTION
|   A_SECTION title     content     section                 C_SECTION
|   A_SECTION title     content     simsection              C_SECTION
|   A_SECTION title     content                             C_SECTION
|   A_SECTION content   section                             C_SECTION
|   A_SECTION content   simsection                          C_SECTION
|   A_SECTION content                                       C_SECTION
;

simsection:
    A_SIMSECTION info   title   content     C_SIMSECTION
|   A_SIMSECTION info   content             C_SIMSECTION
|   A_SIMSECTION title  content             C_SIMSECTION
|   A_SIMSECTION content                    C_SIMSECTION
;


infocontent:
    title       infocontent | title
|   mediaobject infocontent | mediaobject
|   abstract    infocontent | abstract
|   address     infocontent | address
|   author      infocontent | author
|   date        infocontent | date
|   copyright   infocontent | copyright
;

info: 
    A_INFO infocontent C_INFO
;


abstractcontent:
    para abstractcontent    | para
|   simpara abstractcontent | simpara
;

abstract:
    A_ABSTRACT title abstractcontent    C_ABSTRACT
|   A_ABSTRACT abstractcontent          C_ABSTRACT
;

addresscontent:
    TEXTO addresscontent    | TEXTO
|   street addresscontent   | street
|   city addresscontent     | city
|   state addresscontent    | state
|   phone addresscontent    | phone
|   email addresscontent    | email
|   postcode addresscontent | postcode
;

address: 
    A_ADDRESS addresscontent C_ADDRESS
;

authorcontent:
    firstname authorcontent
|   surname authorcontent
|   personame authorcontent
|   personame
|   surname
;

author:
    A_AUTHOR authorcontent C_AUTHOR
;

copyrightyearcontent:
    year copyrightyearcontent
|   year copyrightholdercontent
|   year
;

copyrightholdercontent:
    holder copyrightholdercontent | holder
;

copyright:
    A_COPYRIGHT copyrightyearcontent C_COPYRIGHT
|   A_COPYRIGHT TEXTO C_COPYRIGHT
;

titlecontent: 
    emphasis titlecontent   | emphasis
|   link titlecontent       | link
|   email titlecontent      | email
|   TEXTO titlecontent      | TEXTO
;

title:
    A_TITLE titlecontent C_TITLE
;

simparacontent:
    emphasis | TEXTO    |   personame
|   link     | email
|   author   | comment
;

simpara:
    A_SIMPARA simpara simparacontent C_SIMPARA
|   A_SIMPARA simparacontent C_SIMPARA
;

emphasis:
    A_EMPHASIS emphasis simparacontent C_EMPHASIS
|   A_EMPHASIS simparacontent C_EMPHASIS
;

comment:
    A_COMMENT comment simparacontent C_COMMENT
|   A_COMMENT simparacontent C_COMMENT
;

link:
    A_LINK link simparacontent C_LINK
|   A_LINK simparacontent C_LINK
;

paracontent:
    emphasis    | link          | email     | author
|   comment     | itemizedlist  | important | address
|   mediaobject | informaltable | TEXTO
;

para:
    A_PARA para paracontent C_PARA
|   A_PARA paracontent C_PARA
;

important:
    A_IMPORTANT title content C_IMPORTANT
|   A_IMPORTANT content C_IMPORTANT
;

sharedcontent:
    comment sharedcontent       | comment
|   emphasis sharedcontent      | emphasis
|   link sharedcontent          | link
|   TEXTO sharedcontent         | TEXTO
;

personame:
    A_PERSONNAME firstname surname C_PERSONNAME
;


firstname:
    A_FIRSTNAME sharedcontent C_FIRSTNAME
;

surname:
    A_SURNAME sharedcontent C_SURNAME
;

street:
    A_STREET sharedcontent C_STREET
;

postcode:
    A_POSTCODE TEXTO C_POSTCODE
;

city:
    A_CITY sharedcontent C_CITY
;

phone:
    A_PHONE sharedcontent C_PHONE
;

email:
    A_EMAIL sharedcontent C_EMAIL
;

date:
    A_DATE sharedcontent C_DATE
;

year:
    A_YEAR sharedcontent C_YEAR
;

holder:
    A_HOLDER sharedcontent C_HOLDER
;

state:
    A_STATE sharedcontent C_STATE
;

mediaobjectcontent:
    videoobject mediaobjectcontent  |   videoobject
|   imageobject mediaobjectcontent  |   imageobject
;

mediaobject:
    A_MEDIAOBJECT info          videoobject         mediaobjectcontent  C_MEDIAOBJECT
|   A_MEDIAOBJECT info          imageobject         mediaobjectcontent  C_MEDIAOBJECT
|   A_MEDIAOBJECT videoobject   mediaobjectcontent                      C_MEDIAOBJECT
|   A_MEDIAOBJECT imageobject   mediaobjectcontent                      C_MEDIAOBJECT
|   A_MEDIAOBJECT videoobject                                           C_MEDIAOBJECT
|   A_MEDIAOBJECT imageobject                                           C_MEDIAOBJECT
;

imageobject:
    A_IMAGEOBJECT info      imagedata    C_IMAGEOBJECT
|   A_IMAGEOBJECT imagedata              C_IMAGEOBJECT
;

videoobject:
    A_VIDEOOBJECT info      videodata   C_VIDEOOBJECT
|   A_VIDEOOBJECT videodata             C_VIDEOOBJECT
;

videodata:
    VIDEODATA RUTA C_REF
;

imagedata:
    IMAGEDATA RUTA C_REF
;

itemizedlist:
    A_ITEMIZEDLIST listitem itemizedlist C_ITEMIZEDLIST
|   A_ITEMIZEDLIST listitem C_ITEMIZEDLIST
;

listitem:
    A_LISTITEM  content listitem C_LISTITEM
|   A_LISTITEM  content C_LISTITEM
;

informaltablecontent:
    mediaobject informaltablecontent    | mediaobject
|   tgroup  informaltablecontent        | tgroup
;

informaltable:
    A_INFORMALTABLE informaltablecontent C_INFORMALTABLE
;

tgroup:
    A_TGROUP thead  tbody   tfoot   C_TGROUP
|   A_TGROUP thead  tfoot           C_TGROUP
|   A_TGROUP tbody  tfoot           C_TGROUP
|   A_TGROUP tfoot                  C_TGROUP
;

table:
    A_TABLE     tablecontent      C_TABLE
;

tablecontent:
    row tablecontent    |   row
;

thead:
     A_THEAD    tablecontent    C_THEAD
;

tbody:
     A_TBODY    tablecontent    C_TBODY
;

tfoot:
     A_TFOOT    tablecontent    C_TFOOT
;

rowcontent:
    entry rowcontent    |   entry
|   entrytbl rowcontent |   entrytbl
;

row:
   A_ROW    rowcontent  C_ROW
;

entrycontent:
    TEXTO           entrycontent | TEXTO
|   itemizedlist    entrycontent | itemizedlist
|   important       entrycontent | important
|   para            entrycontent | para
|   simpara         entrycontent | simpara
|   mediaobject     entrycontent | mediaobject
|   comment         entrycontent | comment
|   abstract        entrycontent | abstract
;

entry:
    A_ENTRY entrycontent C_ENTRY
;

entrytbl:
    A_ENTRYTBL  thead tbody C_ENTRYTBL
|   A_ENTRYTBL  tbody C_ENTRYTBL
;

xlink:
    XLINK URL C_REF
;
%%
