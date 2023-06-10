Tạo csdl stage và datawarehouse của cps bằng cách
Chạy 2 file sql cps_dw và cps_st
Chạy các package trong project SSIS_CPS để load dữ liệu từ các csv -> stage db -> dw db
1 ETL ST All Dims.dtsx package này có thể chạy sẽ lâu và bị lỗi -> chạy lại nhiều lần
2 ETL ST All Facts.dtsx
3 ETL DW All Dims.dtsx
4 ETL DW All Facts.dtsx

Sử dụng project SSAS_CPS để phân tích