CLASS zcl_week3_mustache DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
   INTERFACES if_oo_adt_classrun.
    CONSTANTS: BEGIN OF c_pagamento,
                 pix TYPE string VALUE 'Pix',
                 debito TYPE string VALUE 'Debito',
                 credito TYPE string VALUE 'Credito',
               END OF c_pagamento.
    TYPES: BEGIN OF ty_ps,
             produto  TYPE string,
             valor type string,
             status TYPE string,
           END OF ty_ps,
           tt_topics TYPE STANDARD TABLE OF ty_ps WITH DEFAULT KEY,
           BEGIN OF ty_vd,
             vendedor TYPE string,
             dados   TYPE tt_topics,
           END OF ty_vd,
           tt_schedule TYPE STANDARD TABLE OF ty_vd WITH DEFAULT KEY.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_week3_mustache IMPLEMENTATION.
 METHOD if_oo_adt_classrun~main.
    DATA(lt_schedule) = VALUE tt_schedule(
       ( vendedor = 'Ana Chaves' dados = VALUE tt_topics(
                                                      (  produto = 'Notebook Levono' valor = 'R$3.000,00' status = c_pagamento-pix )
                                                      (  produto = 'iPhone 11' valor = 'R$3.500,00' status = c_pagamento-debito )
                                                      (  produto = 'SmartTV Samsung' valor = 'R$5.000,00' status = c_pagamento-credito )
                                                     )
       )
       ( vendedor = 'Bruno Berenger' dados = VALUE tt_topics(
                                                      (  produto = 'Mouse' valor = 'R$50,00' status = c_pagamento-pix )
                                                      (  produto = 'Playstation 5' valor = 'R$5.500,00' status = c_pagamento-pix )
                                                      (  produto = 'Teclado Mecânico' valor = 'R$239,90' status = c_pagamento-credito )
                                                     )
       )
       ( vendedor = 'Adriana Woitexem' dados = VALUE tt_topics(
                                                      (  produto = 'Alexa' valor = 'R$455,90' status = c_pagamento-credito )
                                                      (  produto = 'AppleWatch' valor = 'R$1.599,00' status = c_pagamento-pix )
                                                      (  produto = 'JBL' valor = 'R$1.000,00' status  = c_pagamento-debito )
                                                     )
       )
       ( vendedor = 'Lilian Raissa' dados = VALUE tt_topics(
                                                      (  produto = 'AirPods' valor = 'R$1.300,00' status = c_pagamento-debito )
                                                     )
       )

                                         ).

    TRY.
        DATA(lo_mustache) = zcl_mustache=>create(
                                'Bem vindo ao relatório de vendas!' && cl_abap_char_utilities=>newline && cl_abap_char_utilities=>newline &&
                                'Vendas que o funcionário {{vendedor}} realizou:'  && cl_abap_char_utilities=>newline &&
                                '{{#dados}}'                               && cl_abap_char_utilities=>newline &&
                                '>>> Produto: {{produto}} | Valor: {{valor}} | Forma de Pagamento: {{status}}'        && cl_abap_char_utilities=>newline &&
                                '{{/dados}}'
                            ).

        out->write( lo_mustache->render( lt_schedule ) ).
      CATCH zcx_mustache_error.
        "handle exception
    ENDTRY.

  ENDMETHOD.
ENDCLASS.
