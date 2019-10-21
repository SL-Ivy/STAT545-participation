---
title: "cm007 Exercises: Practice with `dplyr`"
output: 
  html_document:
    keep_md: true
    theme: paper
---

<!---The following chunk allows errors when knitting--->




```r
suppressPackageStartupMessages(library(tidyverse))
suppressPackageStartupMessages(library(gapminder))
suppressPackageStartupMessages(library(tsibble))
```


This worksheet contains exercises aimed for practice with `dplyr`. 


1. (a) What's the minimum life expectancy for each continent and each year? (b) Add the corresponding country to the tibble, too. (c) Arrange by min life expectancy.


```r
gapminder %>% 
  group_by(continent, year) %>% 
  summarize(min_life = min(lifeExp), country = country [lifeExp == min_life]) %>% 
  arrange (min_life) #default is increasing order
```

```
## # A tibble: 60 x 4
## # Groups:   continent [5]
##    continent  year min_life country     
##    <fct>     <int>    <dbl> <fct>       
##  1 Africa     1992     23.6 Rwanda      
##  2 Asia       1952     28.8 Afghanistan 
##  3 Africa     1952     30   Gambia      
##  4 Asia       1957     30.3 Afghanistan 
##  5 Asia       1977     31.2 Cambodia    
##  6 Africa     1957     31.6 Sierra Leone
##  7 Asia       1962     32.0 Afghanistan 
##  8 Africa     1962     32.8 Sierra Leone
##  9 Asia       1967     34.0 Afghanistan 
## 10 Africa     1967     34.1 Sierra Leone
## # ... with 50 more rows
```

2. Calculate the growth in population since the first year on record _for each country_ by rearranging the following lines, and filling in the `FILL_THIS_IN`. Here's another convenience function for you: `dplyr::first()`. 

```
mutate(rel_growth = FILL_THIS_IN) %>% 
arrange(FILL_THIS_IN) %>% 
gapminder %>% 
DT::datatable()
group_by(country) %>% 
```


```r
gapminder %>%
  group_by(country) %>%
  arrange (year) %>%
  mutate (rel_growth = pop - first (pop)) %>%
  DT::datatable ()
```

<!--html_preserve--><div id="htmlwidget-397d86f13b47a034b763" style="width:100%;height:auto;" class="datatables html-widget"></div>
<script type="application/json" data-for="htmlwidget-397d86f13b47a034b763">{"x":{"filter":"none","data":[["1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16","17","18","19","20","21","22","23","24","25","26","27","28","29","30","31","32","33","34","35","36","37","38","39","40","41","42","43","44","45","46","47","48","49","50","51","52","53","54","55","56","57","58","59","60","61","62","63","64","65","66","67","68","69","70","71","72","73","74","75","76","77","78","79","80","81","82","83","84","85","86","87","88","89","90","91","92","93","94","95","96","97","98","99","100","101","102","103","104","105","106","107","108","109","110","111","112","113","114","115","116","117","118","119","120","121","122","123","124","125","126","127","128","129","130","131","132","133","134","135","136","137","138","139","140","141","142","143","144","145","146","147","148","149","150","151","152","153","154","155","156","157","158","159","160","161","162","163","164","165","166","167","168","169","170","171","172","173","174","175","176","177","178","179","180","181","182","183","184","185","186","187","188","189","190","191","192","193","194","195","196","197","198","199","200","201","202","203","204","205","206","207","208","209","210","211","212","213","214","215","216","217","218","219","220","221","222","223","224","225","226","227","228","229","230","231","232","233","234","235","236","237","238","239","240","241","242","243","244","245","246","247","248","249","250","251","252","253","254","255","256","257","258","259","260","261","262","263","264","265","266","267","268","269","270","271","272","273","274","275","276","277","278","279","280","281","282","283","284","285","286","287","288","289","290","291","292","293","294","295","296","297","298","299","300","301","302","303","304","305","306","307","308","309","310","311","312","313","314","315","316","317","318","319","320","321","322","323","324","325","326","327","328","329","330","331","332","333","334","335","336","337","338","339","340","341","342","343","344","345","346","347","348","349","350","351","352","353","354","355","356","357","358","359","360","361","362","363","364","365","366","367","368","369","370","371","372","373","374","375","376","377","378","379","380","381","382","383","384","385","386","387","388","389","390","391","392","393","394","395","396","397","398","399","400","401","402","403","404","405","406","407","408","409","410","411","412","413","414","415","416","417","418","419","420","421","422","423","424","425","426","427","428","429","430","431","432","433","434","435","436","437","438","439","440","441","442","443","444","445","446","447","448","449","450","451","452","453","454","455","456","457","458","459","460","461","462","463","464","465","466","467","468","469","470","471","472","473","474","475","476","477","478","479","480","481","482","483","484","485","486","487","488","489","490","491","492","493","494","495","496","497","498","499","500","501","502","503","504","505","506","507","508","509","510","511","512","513","514","515","516","517","518","519","520","521","522","523","524","525","526","527","528","529","530","531","532","533","534","535","536","537","538","539","540","541","542","543","544","545","546","547","548","549","550","551","552","553","554","555","556","557","558","559","560","561","562","563","564","565","566","567","568","569","570","571","572","573","574","575","576","577","578","579","580","581","582","583","584","585","586","587","588","589","590","591","592","593","594","595","596","597","598","599","600","601","602","603","604","605","606","607","608","609","610","611","612","613","614","615","616","617","618","619","620","621","622","623","624","625","626","627","628","629","630","631","632","633","634","635","636","637","638","639","640","641","642","643","644","645","646","647","648","649","650","651","652","653","654","655","656","657","658","659","660","661","662","663","664","665","666","667","668","669","670","671","672","673","674","675","676","677","678","679","680","681","682","683","684","685","686","687","688","689","690","691","692","693","694","695","696","697","698","699","700","701","702","703","704","705","706","707","708","709","710","711","712","713","714","715","716","717","718","719","720","721","722","723","724","725","726","727","728","729","730","731","732","733","734","735","736","737","738","739","740","741","742","743","744","745","746","747","748","749","750","751","752","753","754","755","756","757","758","759","760","761","762","763","764","765","766","767","768","769","770","771","772","773","774","775","776","777","778","779","780","781","782","783","784","785","786","787","788","789","790","791","792","793","794","795","796","797","798","799","800","801","802","803","804","805","806","807","808","809","810","811","812","813","814","815","816","817","818","819","820","821","822","823","824","825","826","827","828","829","830","831","832","833","834","835","836","837","838","839","840","841","842","843","844","845","846","847","848","849","850","851","852","853","854","855","856","857","858","859","860","861","862","863","864","865","866","867","868","869","870","871","872","873","874","875","876","877","878","879","880","881","882","883","884","885","886","887","888","889","890","891","892","893","894","895","896","897","898","899","900","901","902","903","904","905","906","907","908","909","910","911","912","913","914","915","916","917","918","919","920","921","922","923","924","925","926","927","928","929","930","931","932","933","934","935","936","937","938","939","940","941","942","943","944","945","946","947","948","949","950","951","952","953","954","955","956","957","958","959","960","961","962","963","964","965","966","967","968","969","970","971","972","973","974","975","976","977","978","979","980","981","982","983","984","985","986","987","988","989","990","991","992","993","994","995","996","997","998","999","1000","1001","1002","1003","1004","1005","1006","1007","1008","1009","1010","1011","1012","1013","1014","1015","1016","1017","1018","1019","1020","1021","1022","1023","1024","1025","1026","1027","1028","1029","1030","1031","1032","1033","1034","1035","1036","1037","1038","1039","1040","1041","1042","1043","1044","1045","1046","1047","1048","1049","1050","1051","1052","1053","1054","1055","1056","1057","1058","1059","1060","1061","1062","1063","1064","1065","1066","1067","1068","1069","1070","1071","1072","1073","1074","1075","1076","1077","1078","1079","1080","1081","1082","1083","1084","1085","1086","1087","1088","1089","1090","1091","1092","1093","1094","1095","1096","1097","1098","1099","1100","1101","1102","1103","1104","1105","1106","1107","1108","1109","1110","1111","1112","1113","1114","1115","1116","1117","1118","1119","1120","1121","1122","1123","1124","1125","1126","1127","1128","1129","1130","1131","1132","1133","1134","1135","1136","1137","1138","1139","1140","1141","1142","1143","1144","1145","1146","1147","1148","1149","1150","1151","1152","1153","1154","1155","1156","1157","1158","1159","1160","1161","1162","1163","1164","1165","1166","1167","1168","1169","1170","1171","1172","1173","1174","1175","1176","1177","1178","1179","1180","1181","1182","1183","1184","1185","1186","1187","1188","1189","1190","1191","1192","1193","1194","1195","1196","1197","1198","1199","1200","1201","1202","1203","1204","1205","1206","1207","1208","1209","1210","1211","1212","1213","1214","1215","1216","1217","1218","1219","1220","1221","1222","1223","1224","1225","1226","1227","1228","1229","1230","1231","1232","1233","1234","1235","1236","1237","1238","1239","1240","1241","1242","1243","1244","1245","1246","1247","1248","1249","1250","1251","1252","1253","1254","1255","1256","1257","1258","1259","1260","1261","1262","1263","1264","1265","1266","1267","1268","1269","1270","1271","1272","1273","1274","1275","1276","1277","1278","1279","1280","1281","1282","1283","1284","1285","1286","1287","1288","1289","1290","1291","1292","1293","1294","1295","1296","1297","1298","1299","1300","1301","1302","1303","1304","1305","1306","1307","1308","1309","1310","1311","1312","1313","1314","1315","1316","1317","1318","1319","1320","1321","1322","1323","1324","1325","1326","1327","1328","1329","1330","1331","1332","1333","1334","1335","1336","1337","1338","1339","1340","1341","1342","1343","1344","1345","1346","1347","1348","1349","1350","1351","1352","1353","1354","1355","1356","1357","1358","1359","1360","1361","1362","1363","1364","1365","1366","1367","1368","1369","1370","1371","1372","1373","1374","1375","1376","1377","1378","1379","1380","1381","1382","1383","1384","1385","1386","1387","1388","1389","1390","1391","1392","1393","1394","1395","1396","1397","1398","1399","1400","1401","1402","1403","1404","1405","1406","1407","1408","1409","1410","1411","1412","1413","1414","1415","1416","1417","1418","1419","1420","1421","1422","1423","1424","1425","1426","1427","1428","1429","1430","1431","1432","1433","1434","1435","1436","1437","1438","1439","1440","1441","1442","1443","1444","1445","1446","1447","1448","1449","1450","1451","1452","1453","1454","1455","1456","1457","1458","1459","1460","1461","1462","1463","1464","1465","1466","1467","1468","1469","1470","1471","1472","1473","1474","1475","1476","1477","1478","1479","1480","1481","1482","1483","1484","1485","1486","1487","1488","1489","1490","1491","1492","1493","1494","1495","1496","1497","1498","1499","1500","1501","1502","1503","1504","1505","1506","1507","1508","1509","1510","1511","1512","1513","1514","1515","1516","1517","1518","1519","1520","1521","1522","1523","1524","1525","1526","1527","1528","1529","1530","1531","1532","1533","1534","1535","1536","1537","1538","1539","1540","1541","1542","1543","1544","1545","1546","1547","1548","1549","1550","1551","1552","1553","1554","1555","1556","1557","1558","1559","1560","1561","1562","1563","1564","1565","1566","1567","1568","1569","1570","1571","1572","1573","1574","1575","1576","1577","1578","1579","1580","1581","1582","1583","1584","1585","1586","1587","1588","1589","1590","1591","1592","1593","1594","1595","1596","1597","1598","1599","1600","1601","1602","1603","1604","1605","1606","1607","1608","1609","1610","1611","1612","1613","1614","1615","1616","1617","1618","1619","1620","1621","1622","1623","1624","1625","1626","1627","1628","1629","1630","1631","1632","1633","1634","1635","1636","1637","1638","1639","1640","1641","1642","1643","1644","1645","1646","1647","1648","1649","1650","1651","1652","1653","1654","1655","1656","1657","1658","1659","1660","1661","1662","1663","1664","1665","1666","1667","1668","1669","1670","1671","1672","1673","1674","1675","1676","1677","1678","1679","1680","1681","1682","1683","1684","1685","1686","1687","1688","1689","1690","1691","1692","1693","1694","1695","1696","1697","1698","1699","1700","1701","1702","1703","1704"],["Afghanistan","Albania","Algeria","Angola","Argentina","Australia","Austria","Bahrain","Bangladesh","Belgium","Benin","Bolivia","Bosnia and Herzegovina","Botswana","Brazil","Bulgaria","Burkina Faso","Burundi","Cambodia","Cameroon","Canada","Central African Republic","Chad","Chile","China","Colombia","Comoros","Congo, Dem. Rep.","Congo, Rep.","Costa Rica","Cote d'Ivoire","Croatia","Cuba","Czech Republic","Denmark","Djibouti","Dominican Republic","Ecuador","Egypt","El Salvador","Equatorial Guinea","Eritrea","Ethiopia","Finland","France","Gabon","Gambia","Germany","Ghana","Greece","Guatemala","Guinea","Guinea-Bissau","Haiti","Honduras","Hong Kong, China","Hungary","Iceland","India","Indonesia","Iran","Iraq","Ireland","Israel","Italy","Jamaica","Japan","Jordan","Kenya","Korea, Dem. Rep.","Korea, Rep.","Kuwait","Lebanon","Lesotho","Liberia","Libya","Madagascar","Malawi","Malaysia","Mali","Mauritania","Mauritius","Mexico","Mongolia","Montenegro","Morocco","Mozambique","Myanmar","Namibia","Nepal","Netherlands","New Zealand","Nicaragua","Niger","Nigeria","Norway","Oman","Pakistan","Panama","Paraguay","Peru","Philippines","Poland","Portugal","Puerto Rico","Reunion","Romania","Rwanda","Sao Tome and Principe","Saudi Arabia","Senegal","Serbia","Sierra Leone","Singapore","Slovak Republic","Slovenia","Somalia","South Africa","Spain","Sri Lanka","Sudan","Swaziland","Sweden","Switzerland","Syria","Taiwan","Tanzania","Thailand","Togo","Trinidad and Tobago","Tunisia","Turkey","Uganda","United Kingdom","United States","Uruguay","Venezuela","Vietnam","West Bank and Gaza","Yemen, Rep.","Zambia","Zimbabwe","Afghanistan","Albania","Algeria","Angola","Argentina","Australia","Austria","Bahrain","Bangladesh","Belgium","Benin","Bolivia","Bosnia and Herzegovina","Botswana","Brazil","Bulgaria","Burkina Faso","Burundi","Cambodia","Cameroon","Canada","Central African Republic","Chad","Chile","China","Colombia","Comoros","Congo, Dem. Rep.","Congo, Rep.","Costa Rica","Cote d'Ivoire","Croatia","Cuba","Czech Republic","Denmark","Djibouti","Dominican Republic","Ecuador","Egypt","El Salvador","Equatorial Guinea","Eritrea","Ethiopia","Finland","France","Gabon","Gambia","Germany","Ghana","Greece","Guatemala","Guinea","Guinea-Bissau","Haiti","Honduras","Hong Kong, China","Hungary","Iceland","India","Indonesia","Iran","Iraq","Ireland","Israel","Italy","Jamaica","Japan","Jordan","Kenya","Korea, Dem. Rep.","Korea, Rep.","Kuwait","Lebanon","Lesotho","Liberia","Libya","Madagascar","Malawi","Malaysia","Mali","Mauritania","Mauritius","Mexico","Mongolia","Montenegro","Morocco","Mozambique","Myanmar","Namibia","Nepal","Netherlands","New Zealand","Nicaragua","Niger","Nigeria","Norway","Oman","Pakistan","Panama","Paraguay","Peru","Philippines","Poland","Portugal","Puerto Rico","Reunion","Romania","Rwanda","Sao Tome and Principe","Saudi Arabia","Senegal","Serbia","Sierra Leone","Singapore","Slovak Republic","Slovenia","Somalia","South Africa","Spain","Sri Lanka","Sudan","Swaziland","Sweden","Switzerland","Syria","Taiwan","Tanzania","Thailand","Togo","Trinidad and Tobago","Tunisia","Turkey","Uganda","United Kingdom","United States","Uruguay","Venezuela","Vietnam","West Bank and Gaza","Yemen, Rep.","Zambia","Zimbabwe","Afghanistan","Albania","Algeria","Angola","Argentina","Australia","Austria","Bahrain","Bangladesh","Belgium","Benin","Bolivia","Bosnia and Herzegovina","Botswana","Brazil","Bulgaria","Burkina Faso","Burundi","Cambodia","Cameroon","Canada","Central African Republic","Chad","Chile","China","Colombia","Comoros","Congo, Dem. Rep.","Congo, Rep.","Costa Rica","Cote d'Ivoire","Croatia","Cuba","Czech Republic","Denmark","Djibouti","Dominican Republic","Ecuador","Egypt","El Salvador","Equatorial Guinea","Eritrea","Ethiopia","Finland","France","Gabon","Gambia","Germany","Ghana","Greece","Guatemala","Guinea","Guinea-Bissau","Haiti","Honduras","Hong Kong, China","Hungary","Iceland","India","Indonesia","Iran","Iraq","Ireland","Israel","Italy","Jamaica","Japan","Jordan","Kenya","Korea, Dem. Rep.","Korea, Rep.","Kuwait","Lebanon","Lesotho","Liberia","Libya","Madagascar","Malawi","Malaysia","Mali","Mauritania","Mauritius","Mexico","Mongolia","Montenegro","Morocco","Mozambique","Myanmar","Namibia","Nepal","Netherlands","New Zealand","Nicaragua","Niger","Nigeria","Norway","Oman","Pakistan","Panama","Paraguay","Peru","Philippines","Poland","Portugal","Puerto Rico","Reunion","Romania","Rwanda","Sao Tome and Principe","Saudi Arabia","Senegal","Serbia","Sierra Leone","Singapore","Slovak Republic","Slovenia","Somalia","South Africa","Spain","Sri Lanka","Sudan","Swaziland","Sweden","Switzerland","Syria","Taiwan","Tanzania","Thailand","Togo","Trinidad and Tobago","Tunisia","Turkey","Uganda","United Kingdom","United States","Uruguay","Venezuela","Vietnam","West Bank and Gaza","Yemen, Rep.","Zambia","Zimbabwe","Afghanistan","Albania","Algeria","Angola","Argentina","Australia","Austria","Bahrain","Bangladesh","Belgium","Benin","Bolivia","Bosnia and Herzegovina","Botswana","Brazil","Bulgaria","Burkina Faso","Burundi","Cambodia","Cameroon","Canada","Central African Republic","Chad","Chile","China","Colombia","Comoros","Congo, Dem. Rep.","Congo, Rep.","Costa Rica","Cote d'Ivoire","Croatia","Cuba","Czech Republic","Denmark","Djibouti","Dominican Republic","Ecuador","Egypt","El Salvador","Equatorial Guinea","Eritrea","Ethiopia","Finland","France","Gabon","Gambia","Germany","Ghana","Greece","Guatemala","Guinea","Guinea-Bissau","Haiti","Honduras","Hong Kong, China","Hungary","Iceland","India","Indonesia","Iran","Iraq","Ireland","Israel","Italy","Jamaica","Japan","Jordan","Kenya","Korea, Dem. Rep.","Korea, Rep.","Kuwait","Lebanon","Lesotho","Liberia","Libya","Madagascar","Malawi","Malaysia","Mali","Mauritania","Mauritius","Mexico","Mongolia","Montenegro","Morocco","Mozambique","Myanmar","Namibia","Nepal","Netherlands","New Zealand","Nicaragua","Niger","Nigeria","Norway","Oman","Pakistan","Panama","Paraguay","Peru","Philippines","Poland","Portugal","Puerto Rico","Reunion","Romania","Rwanda","Sao Tome and Principe","Saudi Arabia","Senegal","Serbia","Sierra Leone","Singapore","Slovak Republic","Slovenia","Somalia","South Africa","Spain","Sri Lanka","Sudan","Swaziland","Sweden","Switzerland","Syria","Taiwan","Tanzania","Thailand","Togo","Trinidad and Tobago","Tunisia","Turkey","Uganda","United Kingdom","United States","Uruguay","Venezuela","Vietnam","West Bank and Gaza","Yemen, Rep.","Zambia","Zimbabwe","Afghanistan","Albania","Algeria","Angola","Argentina","Australia","Austria","Bahrain","Bangladesh","Belgium","Benin","Bolivia","Bosnia and Herzegovina","Botswana","Brazil","Bulgaria","Burkina Faso","Burundi","Cambodia","Cameroon","Canada","Central African Republic","Chad","Chile","China","Colombia","Comoros","Congo, Dem. Rep.","Congo, Rep.","Costa Rica","Cote d'Ivoire","Croatia","Cuba","Czech Republic","Denmark","Djibouti","Dominican Republic","Ecuador","Egypt","El Salvador","Equatorial Guinea","Eritrea","Ethiopia","Finland","France","Gabon","Gambia","Germany","Ghana","Greece","Guatemala","Guinea","Guinea-Bissau","Haiti","Honduras","Hong Kong, China","Hungary","Iceland","India","Indonesia","Iran","Iraq","Ireland","Israel","Italy","Jamaica","Japan","Jordan","Kenya","Korea, Dem. Rep.","Korea, Rep.","Kuwait","Lebanon","Lesotho","Liberia","Libya","Madagascar","Malawi","Malaysia","Mali","Mauritania","Mauritius","Mexico","Mongolia","Montenegro","Morocco","Mozambique","Myanmar","Namibia","Nepal","Netherlands","New Zealand","Nicaragua","Niger","Nigeria","Norway","Oman","Pakistan","Panama","Paraguay","Peru","Philippines","Poland","Portugal","Puerto Rico","Reunion","Romania","Rwanda","Sao Tome and Principe","Saudi Arabia","Senegal","Serbia","Sierra Leone","Singapore","Slovak Republic","Slovenia","Somalia","South Africa","Spain","Sri Lanka","Sudan","Swaziland","Sweden","Switzerland","Syria","Taiwan","Tanzania","Thailand","Togo","Trinidad and Tobago","Tunisia","Turkey","Uganda","United Kingdom","United States","Uruguay","Venezuela","Vietnam","West Bank and Gaza","Yemen, Rep.","Zambia","Zimbabwe","Afghanistan","Albania","Algeria","Angola","Argentina","Australia","Austria","Bahrain","Bangladesh","Belgium","Benin","Bolivia","Bosnia and Herzegovina","Botswana","Brazil","Bulgaria","Burkina Faso","Burundi","Cambodia","Cameroon","Canada","Central African Republic","Chad","Chile","China","Colombia","Comoros","Congo, Dem. Rep.","Congo, Rep.","Costa Rica","Cote d'Ivoire","Croatia","Cuba","Czech Republic","Denmark","Djibouti","Dominican Republic","Ecuador","Egypt","El Salvador","Equatorial Guinea","Eritrea","Ethiopia","Finland","France","Gabon","Gambia","Germany","Ghana","Greece","Guatemala","Guinea","Guinea-Bissau","Haiti","Honduras","Hong Kong, China","Hungary","Iceland","India","Indonesia","Iran","Iraq","Ireland","Israel","Italy","Jamaica","Japan","Jordan","Kenya","Korea, Dem. Rep.","Korea, Rep.","Kuwait","Lebanon","Lesotho","Liberia","Libya","Madagascar","Malawi","Malaysia","Mali","Mauritania","Mauritius","Mexico","Mongolia","Montenegro","Morocco","Mozambique","Myanmar","Namibia","Nepal","Netherlands","New Zealand","Nicaragua","Niger","Nigeria","Norway","Oman","Pakistan","Panama","Paraguay","Peru","Philippines","Poland","Portugal","Puerto Rico","Reunion","Romania","Rwanda","Sao Tome and Principe","Saudi Arabia","Senegal","Serbia","Sierra Leone","Singapore","Slovak Republic","Slovenia","Somalia","South Africa","Spain","Sri Lanka","Sudan","Swaziland","Sweden","Switzerland","Syria","Taiwan","Tanzania","Thailand","Togo","Trinidad and Tobago","Tunisia","Turkey","Uganda","United Kingdom","United States","Uruguay","Venezuela","Vietnam","West Bank and Gaza","Yemen, Rep.","Zambia","Zimbabwe","Afghanistan","Albania","Algeria","Angola","Argentina","Australia","Austria","Bahrain","Bangladesh","Belgium","Benin","Bolivia","Bosnia and Herzegovina","Botswana","Brazil","Bulgaria","Burkina Faso","Burundi","Cambodia","Cameroon","Canada","Central African Republic","Chad","Chile","China","Colombia","Comoros","Congo, Dem. Rep.","Congo, Rep.","Costa Rica","Cote d'Ivoire","Croatia","Cuba","Czech Republic","Denmark","Djibouti","Dominican Republic","Ecuador","Egypt","El Salvador","Equatorial Guinea","Eritrea","Ethiopia","Finland","France","Gabon","Gambia","Germany","Ghana","Greece","Guatemala","Guinea","Guinea-Bissau","Haiti","Honduras","Hong Kong, China","Hungary","Iceland","India","Indonesia","Iran","Iraq","Ireland","Israel","Italy","Jamaica","Japan","Jordan","Kenya","Korea, Dem. Rep.","Korea, Rep.","Kuwait","Lebanon","Lesotho","Liberia","Libya","Madagascar","Malawi","Malaysia","Mali","Mauritania","Mauritius","Mexico","Mongolia","Montenegro","Morocco","Mozambique","Myanmar","Namibia","Nepal","Netherlands","New Zealand","Nicaragua","Niger","Nigeria","Norway","Oman","Pakistan","Panama","Paraguay","Peru","Philippines","Poland","Portugal","Puerto Rico","Reunion","Romania","Rwanda","Sao Tome and Principe","Saudi Arabia","Senegal","Serbia","Sierra Leone","Singapore","Slovak Republic","Slovenia","Somalia","South Africa","Spain","Sri Lanka","Sudan","Swaziland","Sweden","Switzerland","Syria","Taiwan","Tanzania","Thailand","Togo","Trinidad and Tobago","Tunisia","Turkey","Uganda","United Kingdom","United States","Uruguay","Venezuela","Vietnam","West Bank and Gaza","Yemen, Rep.","Zambia","Zimbabwe","Afghanistan","Albania","Algeria","Angola","Argentina","Australia","Austria","Bahrain","Bangladesh","Belgium","Benin","Bolivia","Bosnia and Herzegovina","Botswana","Brazil","Bulgaria","Burkina Faso","Burundi","Cambodia","Cameroon","Canada","Central African Republic","Chad","Chile","China","Colombia","Comoros","Congo, Dem. Rep.","Congo, Rep.","Costa Rica","Cote d'Ivoire","Croatia","Cuba","Czech Republic","Denmark","Djibouti","Dominican Republic","Ecuador","Egypt","El Salvador","Equatorial Guinea","Eritrea","Ethiopia","Finland","France","Gabon","Gambia","Germany","Ghana","Greece","Guatemala","Guinea","Guinea-Bissau","Haiti","Honduras","Hong Kong, China","Hungary","Iceland","India","Indonesia","Iran","Iraq","Ireland","Israel","Italy","Jamaica","Japan","Jordan","Kenya","Korea, Dem. Rep.","Korea, Rep.","Kuwait","Lebanon","Lesotho","Liberia","Libya","Madagascar","Malawi","Malaysia","Mali","Mauritania","Mauritius","Mexico","Mongolia","Montenegro","Morocco","Mozambique","Myanmar","Namibia","Nepal","Netherlands","New Zealand","Nicaragua","Niger","Nigeria","Norway","Oman","Pakistan","Panama","Paraguay","Peru","Philippines","Poland","Portugal","Puerto Rico","Reunion","Romania","Rwanda","Sao Tome and Principe","Saudi Arabia","Senegal","Serbia","Sierra Leone","Singapore","Slovak Republic","Slovenia","Somalia","South Africa","Spain","Sri Lanka","Sudan","Swaziland","Sweden","Switzerland","Syria","Taiwan","Tanzania","Thailand","Togo","Trinidad and Tobago","Tunisia","Turkey","Uganda","United Kingdom","United States","Uruguay","Venezuela","Vietnam","West Bank and Gaza","Yemen, Rep.","Zambia","Zimbabwe","Afghanistan","Albania","Algeria","Angola","Argentina","Australia","Austria","Bahrain","Bangladesh","Belgium","Benin","Bolivia","Bosnia and Herzegovina","Botswana","Brazil","Bulgaria","Burkina Faso","Burundi","Cambodia","Cameroon","Canada","Central African Republic","Chad","Chile","China","Colombia","Comoros","Congo, Dem. Rep.","Congo, Rep.","Costa Rica","Cote d'Ivoire","Croatia","Cuba","Czech Republic","Denmark","Djibouti","Dominican Republic","Ecuador","Egypt","El Salvador","Equatorial Guinea","Eritrea","Ethiopia","Finland","France","Gabon","Gambia","Germany","Ghana","Greece","Guatemala","Guinea","Guinea-Bissau","Haiti","Honduras","Hong Kong, China","Hungary","Iceland","India","Indonesia","Iran","Iraq","Ireland","Israel","Italy","Jamaica","Japan","Jordan","Kenya","Korea, Dem. Rep.","Korea, Rep.","Kuwait","Lebanon","Lesotho","Liberia","Libya","Madagascar","Malawi","Malaysia","Mali","Mauritania","Mauritius","Mexico","Mongolia","Montenegro","Morocco","Mozambique","Myanmar","Namibia","Nepal","Netherlands","New Zealand","Nicaragua","Niger","Nigeria","Norway","Oman","Pakistan","Panama","Paraguay","Peru","Philippines","Poland","Portugal","Puerto Rico","Reunion","Romania","Rwanda","Sao Tome and Principe","Saudi Arabia","Senegal","Serbia","Sierra Leone","Singapore","Slovak Republic","Slovenia","Somalia","South Africa","Spain","Sri Lanka","Sudan","Swaziland","Sweden","Switzerland","Syria","Taiwan","Tanzania","Thailand","Togo","Trinidad and Tobago","Tunisia","Turkey","Uganda","United Kingdom","United States","Uruguay","Venezuela","Vietnam","West Bank and Gaza","Yemen, Rep.","Zambia","Zimbabwe","Afghanistan","Albania","Algeria","Angola","Argentina","Australia","Austria","Bahrain","Bangladesh","Belgium","Benin","Bolivia","Bosnia and Herzegovina","Botswana","Brazil","Bulgaria","Burkina Faso","Burundi","Cambodia","Cameroon","Canada","Central African Republic","Chad","Chile","China","Colombia","Comoros","Congo, Dem. Rep.","Congo, Rep.","Costa Rica","Cote d'Ivoire","Croatia","Cuba","Czech Republic","Denmark","Djibouti","Dominican Republic","Ecuador","Egypt","El Salvador","Equatorial Guinea","Eritrea","Ethiopia","Finland","France","Gabon","Gambia","Germany","Ghana","Greece","Guatemala","Guinea","Guinea-Bissau","Haiti","Honduras","Hong Kong, China","Hungary","Iceland","India","Indonesia","Iran","Iraq","Ireland","Israel","Italy","Jamaica","Japan","Jordan","Kenya","Korea, Dem. Rep.","Korea, Rep.","Kuwait","Lebanon","Lesotho","Liberia","Libya","Madagascar","Malawi","Malaysia","Mali","Mauritania","Mauritius","Mexico","Mongolia","Montenegro","Morocco","Mozambique","Myanmar","Namibia","Nepal","Netherlands","New Zealand","Nicaragua","Niger","Nigeria","Norway","Oman","Pakistan","Panama","Paraguay","Peru","Philippines","Poland","Portugal","Puerto Rico","Reunion","Romania","Rwanda","Sao Tome and Principe","Saudi Arabia","Senegal","Serbia","Sierra Leone","Singapore","Slovak Republic","Slovenia","Somalia","South Africa","Spain","Sri Lanka","Sudan","Swaziland","Sweden","Switzerland","Syria","Taiwan","Tanzania","Thailand","Togo","Trinidad and Tobago","Tunisia","Turkey","Uganda","United Kingdom","United States","Uruguay","Venezuela","Vietnam","West Bank and Gaza","Yemen, Rep.","Zambia","Zimbabwe","Afghanistan","Albania","Algeria","Angola","Argentina","Australia","Austria","Bahrain","Bangladesh","Belgium","Benin","Bolivia","Bosnia and Herzegovina","Botswana","Brazil","Bulgaria","Burkina Faso","Burundi","Cambodia","Cameroon","Canada","Central African Republic","Chad","Chile","China","Colombia","Comoros","Congo, Dem. Rep.","Congo, Rep.","Costa Rica","Cote d'Ivoire","Croatia","Cuba","Czech Republic","Denmark","Djibouti","Dominican Republic","Ecuador","Egypt","El Salvador","Equatorial Guinea","Eritrea","Ethiopia","Finland","France","Gabon","Gambia","Germany","Ghana","Greece","Guatemala","Guinea","Guinea-Bissau","Haiti","Honduras","Hong Kong, China","Hungary","Iceland","India","Indonesia","Iran","Iraq","Ireland","Israel","Italy","Jamaica","Japan","Jordan","Kenya","Korea, Dem. Rep.","Korea, Rep.","Kuwait","Lebanon","Lesotho","Liberia","Libya","Madagascar","Malawi","Malaysia","Mali","Mauritania","Mauritius","Mexico","Mongolia","Montenegro","Morocco","Mozambique","Myanmar","Namibia","Nepal","Netherlands","New Zealand","Nicaragua","Niger","Nigeria","Norway","Oman","Pakistan","Panama","Paraguay","Peru","Philippines","Poland","Portugal","Puerto Rico","Reunion","Romania","Rwanda","Sao Tome and Principe","Saudi Arabia","Senegal","Serbia","Sierra Leone","Singapore","Slovak Republic","Slovenia","Somalia","South Africa","Spain","Sri Lanka","Sudan","Swaziland","Sweden","Switzerland","Syria","Taiwan","Tanzania","Thailand","Togo","Trinidad and Tobago","Tunisia","Turkey","Uganda","United Kingdom","United States","Uruguay","Venezuela","Vietnam","West Bank and Gaza","Yemen, Rep.","Zambia","Zimbabwe","Afghanistan","Albania","Algeria","Angola","Argentina","Australia","Austria","Bahrain","Bangladesh","Belgium","Benin","Bolivia","Bosnia and Herzegovina","Botswana","Brazil","Bulgaria","Burkina Faso","Burundi","Cambodia","Cameroon","Canada","Central African Republic","Chad","Chile","China","Colombia","Comoros","Congo, Dem. Rep.","Congo, Rep.","Costa Rica","Cote d'Ivoire","Croatia","Cuba","Czech Republic","Denmark","Djibouti","Dominican Republic","Ecuador","Egypt","El Salvador","Equatorial Guinea","Eritrea","Ethiopia","Finland","France","Gabon","Gambia","Germany","Ghana","Greece","Guatemala","Guinea","Guinea-Bissau","Haiti","Honduras","Hong Kong, China","Hungary","Iceland","India","Indonesia","Iran","Iraq","Ireland","Israel","Italy","Jamaica","Japan","Jordan","Kenya","Korea, Dem. Rep.","Korea, Rep.","Kuwait","Lebanon","Lesotho","Liberia","Libya","Madagascar","Malawi","Malaysia","Mali","Mauritania","Mauritius","Mexico","Mongolia","Montenegro","Morocco","Mozambique","Myanmar","Namibia","Nepal","Netherlands","New Zealand","Nicaragua","Niger","Nigeria","Norway","Oman","Pakistan","Panama","Paraguay","Peru","Philippines","Poland","Portugal","Puerto Rico","Reunion","Romania","Rwanda","Sao Tome and Principe","Saudi Arabia","Senegal","Serbia","Sierra Leone","Singapore","Slovak Republic","Slovenia","Somalia","South Africa","Spain","Sri Lanka","Sudan","Swaziland","Sweden","Switzerland","Syria","Taiwan","Tanzania","Thailand","Togo","Trinidad and Tobago","Tunisia","Turkey","Uganda","United Kingdom","United States","Uruguay","Venezuela","Vietnam","West Bank and Gaza","Yemen, Rep.","Zambia","Zimbabwe"],["Asia","Europe","Africa","Africa","Americas","Oceania","Europe","Asia","Asia","Europe","Africa","Americas","Europe","Africa","Americas","Europe","Africa","Africa","Asia","Africa","Americas","Africa","Africa","Americas","Asia","Americas","Africa","Africa","Africa","Americas","Africa","Europe","Americas","Europe","Europe","Africa","Americas","Americas","Africa","Americas","Africa","Africa","Africa","Europe","Europe","Africa","Africa","Europe","Africa","Europe","Americas","Africa","Africa","Americas","Americas","Asia","Europe","Europe","Asia","Asia","Asia","Asia","Europe","Asia","Europe","Americas","Asia","Asia","Africa","Asia","Asia","Asia","Asia","Africa","Africa","Africa","Africa","Africa","Asia","Africa","Africa","Africa","Americas","Asia","Europe","Africa","Africa","Asia","Africa","Asia","Europe","Oceania","Americas","Africa","Africa","Europe","Asia","Asia","Americas","Americas","Americas","Asia","Europe","Europe","Americas","Africa","Europe","Africa","Africa","Asia","Africa","Europe","Africa","Asia","Europe","Europe","Africa","Africa","Europe","Asia","Africa","Africa","Europe","Europe","Asia","Asia","Africa","Asia","Africa","Americas","Africa","Europe","Africa","Europe","Americas","Americas","Americas","Asia","Asia","Asia","Africa","Africa","Asia","Europe","Africa","Africa","Americas","Oceania","Europe","Asia","Asia","Europe","Africa","Americas","Europe","Africa","Americas","Europe","Africa","Africa","Asia","Africa","Americas","Africa","Africa","Americas","Asia","Americas","Africa","Africa","Africa","Americas","Africa","Europe","Americas","Europe","Europe","Africa","Americas","Americas","Africa","Americas","Africa","Africa","Africa","Europe","Europe","Africa","Africa","Europe","Africa","Europe","Americas","Africa","Africa","Americas","Americas","Asia","Europe","Europe","Asia","Asia","Asia","Asia","Europe","Asia","Europe","Americas","Asia","Asia","Africa","Asia","Asia","Asia","Asia","Africa","Africa","Africa","Africa","Africa","Asia","Africa","Africa","Africa","Americas","Asia","Europe","Africa","Africa","Asia","Africa","Asia","Europe","Oceania","Americas","Africa","Africa","Europe","Asia","Asia","Americas","Americas","Americas","Asia","Europe","Europe","Americas","Africa","Europe","Africa","Africa","Asia","Africa","Europe","Africa","Asia","Europe","Europe","Africa","Africa","Europe","Asia","Africa","Africa","Europe","Europe","Asia","Asia","Africa","Asia","Africa","Americas","Africa","Europe","Africa","Europe","Americas","Americas","Americas","Asia","Asia","Asia","Africa","Africa","Asia","Europe","Africa","Africa","Americas","Oceania","Europe","Asia","Asia","Europe","Africa","Americas","Europe","Africa","Americas","Europe","Africa","Africa","Asia","Africa","Americas","Africa","Africa","Americas","Asia","Americas","Africa","Africa","Africa","Americas","Africa","Europe","Americas","Europe","Europe","Africa","Americas","Americas","Africa","Americas","Africa","Africa","Africa","Europe","Europe","Africa","Africa","Europe","Africa","Europe","Americas","Africa","Africa","Americas","Americas","Asia","Europe","Europe","Asia","Asia","Asia","Asia","Europe","Asia","Europe","Americas","Asia","Asia","Africa","Asia","Asia","Asia","Asia","Africa","Africa","Africa","Africa","Africa","Asia","Africa","Africa","Africa","Americas","Asia","Europe","Africa","Africa","Asia","Africa","Asia","Europe","Oceania","Americas","Africa","Africa","Europe","Asia","Asia","Americas","Americas","Americas","Asia","Europe","Europe","Americas","Africa","Europe","Africa","Africa","Asia","Africa","Europe","Africa","Asia","Europe","Europe","Africa","Africa","Europe","Asia","Africa","Africa","Europe","Europe","Asia","Asia","Africa","Asia","Africa","Americas","Africa","Europe","Africa","Europe","Americas","Americas","Americas","Asia","Asia","Asia","Africa","Africa","Asia","Europe","Africa","Africa","Americas","Oceania","Europe","Asia","Asia","Europe","Africa","Americas","Europe","Africa","Americas","Europe","Africa","Africa","Asia","Africa","Americas","Africa","Africa","Americas","Asia","Americas","Africa","Africa","Africa","Americas","Africa","Europe","Americas","Europe","Europe","Africa","Americas","Americas","Africa","Americas","Africa","Africa","Africa","Europe","Europe","Africa","Africa","Europe","Africa","Europe","Americas","Africa","Africa","Americas","Americas","Asia","Europe","Europe","Asia","Asia","Asia","Asia","Europe","Asia","Europe","Americas","Asia","Asia","Africa","Asia","Asia","Asia","Asia","Africa","Africa","Africa","Africa","Africa","Asia","Africa","Africa","Africa","Americas","Asia","Europe","Africa","Africa","Asia","Africa","Asia","Europe","Oceania","Americas","Africa","Africa","Europe","Asia","Asia","Americas","Americas","Americas","Asia","Europe","Europe","Americas","Africa","Europe","Africa","Africa","Asia","Africa","Europe","Africa","Asia","Europe","Europe","Africa","Africa","Europe","Asia","Africa","Africa","Europe","Europe","Asia","Asia","Africa","Asia","Africa","Americas","Africa","Europe","Africa","Europe","Americas","Americas","Americas","Asia","Asia","Asia","Africa","Africa","Asia","Europe","Africa","Africa","Americas","Oceania","Europe","Asia","Asia","Europe","Africa","Americas","Europe","Africa","Americas","Europe","Africa","Africa","Asia","Africa","Americas","Africa","Africa","Americas","Asia","Americas","Africa","Africa","Africa","Americas","Africa","Europe","Americas","Europe","Europe","Africa","Americas","Americas","Africa","Americas","Africa","Africa","Africa","Europe","Europe","Africa","Africa","Europe","Africa","Europe","Americas","Africa","Africa","Americas","Americas","Asia","Europe","Europe","Asia","Asia","Asia","Asia","Europe","Asia","Europe","Americas","Asia","Asia","Africa","Asia","Asia","Asia","Asia","Africa","Africa","Africa","Africa","Africa","Asia","Africa","Africa","Africa","Americas","Asia","Europe","Africa","Africa","Asia","Africa","Asia","Europe","Oceania","Americas","Africa","Africa","Europe","Asia","Asia","Americas","Americas","Americas","Asia","Europe","Europe","Americas","Africa","Europe","Africa","Africa","Asia","Africa","Europe","Africa","Asia","Europe","Europe","Africa","Africa","Europe","Asia","Africa","Africa","Europe","Europe","Asia","Asia","Africa","Asia","Africa","Americas","Africa","Europe","Africa","Europe","Americas","Americas","Americas","Asia","Asia","Asia","Africa","Africa","Asia","Europe","Africa","Africa","Americas","Oceania","Europe","Asia","Asia","Europe","Africa","Americas","Europe","Africa","Americas","Europe","Africa","Africa","Asia","Africa","Americas","Africa","Africa","Americas","Asia","Americas","Africa","Africa","Africa","Americas","Africa","Europe","Americas","Europe","Europe","Africa","Americas","Americas","Africa","Americas","Africa","Africa","Africa","Europe","Europe","Africa","Africa","Europe","Africa","Europe","Americas","Africa","Africa","Americas","Americas","Asia","Europe","Europe","Asia","Asia","Asia","Asia","Europe","Asia","Europe","Americas","Asia","Asia","Africa","Asia","Asia","Asia","Asia","Africa","Africa","Africa","Africa","Africa","Asia","Africa","Africa","Africa","Americas","Asia","Europe","Africa","Africa","Asia","Africa","Asia","Europe","Oceania","Americas","Africa","Africa","Europe","Asia","Asia","Americas","Americas","Americas","Asia","Europe","Europe","Americas","Africa","Europe","Africa","Africa","Asia","Africa","Europe","Africa","Asia","Europe","Europe","Africa","Africa","Europe","Asia","Africa","Africa","Europe","Europe","Asia","Asia","Africa","Asia","Africa","Americas","Africa","Europe","Africa","Europe","Americas","Americas","Americas","Asia","Asia","Asia","Africa","Africa","Asia","Europe","Africa","Africa","Americas","Oceania","Europe","Asia","Asia","Europe","Africa","Americas","Europe","Africa","Americas","Europe","Africa","Africa","Asia","Africa","Americas","Africa","Africa","Americas","Asia","Americas","Africa","Africa","Africa","Americas","Africa","Europe","Americas","Europe","Europe","Africa","Americas","Americas","Africa","Americas","Africa","Africa","Africa","Europe","Europe","Africa","Africa","Europe","Africa","Europe","Americas","Africa","Africa","Americas","Americas","Asia","Europe","Europe","Asia","Asia","Asia","Asia","Europe","Asia","Europe","Americas","Asia","Asia","Africa","Asia","Asia","Asia","Asia","Africa","Africa","Africa","Africa","Africa","Asia","Africa","Africa","Africa","Americas","Asia","Europe","Africa","Africa","Asia","Africa","Asia","Europe","Oceania","Americas","Africa","Africa","Europe","Asia","Asia","Americas","Americas","Americas","Asia","Europe","Europe","Americas","Africa","Europe","Africa","Africa","Asia","Africa","Europe","Africa","Asia","Europe","Europe","Africa","Africa","Europe","Asia","Africa","Africa","Europe","Europe","Asia","Asia","Africa","Asia","Africa","Americas","Africa","Europe","Africa","Europe","Americas","Americas","Americas","Asia","Asia","Asia","Africa","Africa","Asia","Europe","Africa","Africa","Americas","Oceania","Europe","Asia","Asia","Europe","Africa","Americas","Europe","Africa","Americas","Europe","Africa","Africa","Asia","Africa","Americas","Africa","Africa","Americas","Asia","Americas","Africa","Africa","Africa","Americas","Africa","Europe","Americas","Europe","Europe","Africa","Americas","Americas","Africa","Americas","Africa","Africa","Africa","Europe","Europe","Africa","Africa","Europe","Africa","Europe","Americas","Africa","Africa","Americas","Americas","Asia","Europe","Europe","Asia","Asia","Asia","Asia","Europe","Asia","Europe","Americas","Asia","Asia","Africa","Asia","Asia","Asia","Asia","Africa","Africa","Africa","Africa","Africa","Asia","Africa","Africa","Africa","Americas","Asia","Europe","Africa","Africa","Asia","Africa","Asia","Europe","Oceania","Americas","Africa","Africa","Europe","Asia","Asia","Americas","Americas","Americas","Asia","Europe","Europe","Americas","Africa","Europe","Africa","Africa","Asia","Africa","Europe","Africa","Asia","Europe","Europe","Africa","Africa","Europe","Asia","Africa","Africa","Europe","Europe","Asia","Asia","Africa","Asia","Africa","Americas","Africa","Europe","Africa","Europe","Americas","Americas","Americas","Asia","Asia","Asia","Africa","Africa","Asia","Europe","Africa","Africa","Americas","Oceania","Europe","Asia","Asia","Europe","Africa","Americas","Europe","Africa","Americas","Europe","Africa","Africa","Asia","Africa","Americas","Africa","Africa","Americas","Asia","Americas","Africa","Africa","Africa","Americas","Africa","Europe","Americas","Europe","Europe","Africa","Americas","Americas","Africa","Americas","Africa","Africa","Africa","Europe","Europe","Africa","Africa","Europe","Africa","Europe","Americas","Africa","Africa","Americas","Americas","Asia","Europe","Europe","Asia","Asia","Asia","Asia","Europe","Asia","Europe","Americas","Asia","Asia","Africa","Asia","Asia","Asia","Asia","Africa","Africa","Africa","Africa","Africa","Asia","Africa","Africa","Africa","Americas","Asia","Europe","Africa","Africa","Asia","Africa","Asia","Europe","Oceania","Americas","Africa","Africa","Europe","Asia","Asia","Americas","Americas","Americas","Asia","Europe","Europe","Americas","Africa","Europe","Africa","Africa","Asia","Africa","Europe","Africa","Asia","Europe","Europe","Africa","Africa","Europe","Asia","Africa","Africa","Europe","Europe","Asia","Asia","Africa","Asia","Africa","Americas","Africa","Europe","Africa","Europe","Americas","Americas","Americas","Asia","Asia","Asia","Africa","Africa","Asia","Europe","Africa","Africa","Americas","Oceania","Europe","Asia","Asia","Europe","Africa","Americas","Europe","Africa","Americas","Europe","Africa","Africa","Asia","Africa","Americas","Africa","Africa","Americas","Asia","Americas","Africa","Africa","Africa","Americas","Africa","Europe","Americas","Europe","Europe","Africa","Americas","Americas","Africa","Americas","Africa","Africa","Africa","Europe","Europe","Africa","Africa","Europe","Africa","Europe","Americas","Africa","Africa","Americas","Americas","Asia","Europe","Europe","Asia","Asia","Asia","Asia","Europe","Asia","Europe","Americas","Asia","Asia","Africa","Asia","Asia","Asia","Asia","Africa","Africa","Africa","Africa","Africa","Asia","Africa","Africa","Africa","Americas","Asia","Europe","Africa","Africa","Asia","Africa","Asia","Europe","Oceania","Americas","Africa","Africa","Europe","Asia","Asia","Americas","Americas","Americas","Asia","Europe","Europe","Americas","Africa","Europe","Africa","Africa","Asia","Africa","Europe","Africa","Asia","Europe","Europe","Africa","Africa","Europe","Asia","Africa","Africa","Europe","Europe","Asia","Asia","Africa","Asia","Africa","Americas","Africa","Europe","Africa","Europe","Americas","Americas","Americas","Asia","Asia","Asia","Africa","Africa","Asia","Europe","Africa","Africa","Americas","Oceania","Europe","Asia","Asia","Europe","Africa","Americas","Europe","Africa","Americas","Europe","Africa","Africa","Asia","Africa","Americas","Africa","Africa","Americas","Asia","Americas","Africa","Africa","Africa","Americas","Africa","Europe","Americas","Europe","Europe","Africa","Americas","Americas","Africa","Americas","Africa","Africa","Africa","Europe","Europe","Africa","Africa","Europe","Africa","Europe","Americas","Africa","Africa","Americas","Americas","Asia","Europe","Europe","Asia","Asia","Asia","Asia","Europe","Asia","Europe","Americas","Asia","Asia","Africa","Asia","Asia","Asia","Asia","Africa","Africa","Africa","Africa","Africa","Asia","Africa","Africa","Africa","Americas","Asia","Europe","Africa","Africa","Asia","Africa","Asia","Europe","Oceania","Americas","Africa","Africa","Europe","Asia","Asia","Americas","Americas","Americas","Asia","Europe","Europe","Americas","Africa","Europe","Africa","Africa","Asia","Africa","Europe","Africa","Asia","Europe","Europe","Africa","Africa","Europe","Asia","Africa","Africa","Europe","Europe","Asia","Asia","Africa","Asia","Africa","Americas","Africa","Europe","Africa","Europe","Americas","Americas","Americas","Asia","Asia","Asia","Africa","Africa","Asia","Europe","Africa","Africa","Americas","Oceania","Europe","Asia","Asia","Europe","Africa","Americas","Europe","Africa","Americas","Europe","Africa","Africa","Asia","Africa","Americas","Africa","Africa","Americas","Asia","Americas","Africa","Africa","Africa","Americas","Africa","Europe","Americas","Europe","Europe","Africa","Americas","Americas","Africa","Americas","Africa","Africa","Africa","Europe","Europe","Africa","Africa","Europe","Africa","Europe","Americas","Africa","Africa","Americas","Americas","Asia","Europe","Europe","Asia","Asia","Asia","Asia","Europe","Asia","Europe","Americas","Asia","Asia","Africa","Asia","Asia","Asia","Asia","Africa","Africa","Africa","Africa","Africa","Asia","Africa","Africa","Africa","Americas","Asia","Europe","Africa","Africa","Asia","Africa","Asia","Europe","Oceania","Americas","Africa","Africa","Europe","Asia","Asia","Americas","Americas","Americas","Asia","Europe","Europe","Americas","Africa","Europe","Africa","Africa","Asia","Africa","Europe","Africa","Asia","Europe","Europe","Africa","Africa","Europe","Asia","Africa","Africa","Europe","Europe","Asia","Asia","Africa","Asia","Africa","Americas","Africa","Europe","Africa","Europe","Americas","Americas","Americas","Asia","Asia","Asia","Africa","Africa"],[1952,1952,1952,1952,1952,1952,1952,1952,1952,1952,1952,1952,1952,1952,1952,1952,1952,1952,1952,1952,1952,1952,1952,1952,1952,1952,1952,1952,1952,1952,1952,1952,1952,1952,1952,1952,1952,1952,1952,1952,1952,1952,1952,1952,1952,1952,1952,1952,1952,1952,1952,1952,1952,1952,1952,1952,1952,1952,1952,1952,1952,1952,1952,1952,1952,1952,1952,1952,1952,1952,1952,1952,1952,1952,1952,1952,1952,1952,1952,1952,1952,1952,1952,1952,1952,1952,1952,1952,1952,1952,1952,1952,1952,1952,1952,1952,1952,1952,1952,1952,1952,1952,1952,1952,1952,1952,1952,1952,1952,1952,1952,1952,1952,1952,1952,1952,1952,1952,1952,1952,1952,1952,1952,1952,1952,1952,1952,1952,1952,1952,1952,1952,1952,1952,1952,1952,1952,1952,1952,1952,1952,1952,1957,1957,1957,1957,1957,1957,1957,1957,1957,1957,1957,1957,1957,1957,1957,1957,1957,1957,1957,1957,1957,1957,1957,1957,1957,1957,1957,1957,1957,1957,1957,1957,1957,1957,1957,1957,1957,1957,1957,1957,1957,1957,1957,1957,1957,1957,1957,1957,1957,1957,1957,1957,1957,1957,1957,1957,1957,1957,1957,1957,1957,1957,1957,1957,1957,1957,1957,1957,1957,1957,1957,1957,1957,1957,1957,1957,1957,1957,1957,1957,1957,1957,1957,1957,1957,1957,1957,1957,1957,1957,1957,1957,1957,1957,1957,1957,1957,1957,1957,1957,1957,1957,1957,1957,1957,1957,1957,1957,1957,1957,1957,1957,1957,1957,1957,1957,1957,1957,1957,1957,1957,1957,1957,1957,1957,1957,1957,1957,1957,1957,1957,1957,1957,1957,1957,1957,1957,1957,1957,1957,1957,1957,1962,1962,1962,1962,1962,1962,1962,1962,1962,1962,1962,1962,1962,1962,1962,1962,1962,1962,1962,1962,1962,1962,1962,1962,1962,1962,1962,1962,1962,1962,1962,1962,1962,1962,1962,1962,1962,1962,1962,1962,1962,1962,1962,1962,1962,1962,1962,1962,1962,1962,1962,1962,1962,1962,1962,1962,1962,1962,1962,1962,1962,1962,1962,1962,1962,1962,1962,1962,1962,1962,1962,1962,1962,1962,1962,1962,1962,1962,1962,1962,1962,1962,1962,1962,1962,1962,1962,1962,1962,1962,1962,1962,1962,1962,1962,1962,1962,1962,1962,1962,1962,1962,1962,1962,1962,1962,1962,1962,1962,1962,1962,1962,1962,1962,1962,1962,1962,1962,1962,1962,1962,1962,1962,1962,1962,1962,1962,1962,1962,1962,1962,1962,1962,1962,1962,1962,1962,1962,1962,1962,1962,1962,1967,1967,1967,1967,1967,1967,1967,1967,1967,1967,1967,1967,1967,1967,1967,1967,1967,1967,1967,1967,1967,1967,1967,1967,1967,1967,1967,1967,1967,1967,1967,1967,1967,1967,1967,1967,1967,1967,1967,1967,1967,1967,1967,1967,1967,1967,1967,1967,1967,1967,1967,1967,1967,1967,1967,1967,1967,1967,1967,1967,1967,1967,1967,1967,1967,1967,1967,1967,1967,1967,1967,1967,1967,1967,1967,1967,1967,1967,1967,1967,1967,1967,1967,1967,1967,1967,1967,1967,1967,1967,1967,1967,1967,1967,1967,1967,1967,1967,1967,1967,1967,1967,1967,1967,1967,1967,1967,1967,1967,1967,1967,1967,1967,1967,1967,1967,1967,1967,1967,1967,1967,1967,1967,1967,1967,1967,1967,1967,1967,1967,1967,1967,1967,1967,1967,1967,1967,1967,1967,1967,1967,1967,1972,1972,1972,1972,1972,1972,1972,1972,1972,1972,1972,1972,1972,1972,1972,1972,1972,1972,1972,1972,1972,1972,1972,1972,1972,1972,1972,1972,1972,1972,1972,1972,1972,1972,1972,1972,1972,1972,1972,1972,1972,1972,1972,1972,1972,1972,1972,1972,1972,1972,1972,1972,1972,1972,1972,1972,1972,1972,1972,1972,1972,1972,1972,1972,1972,1972,1972,1972,1972,1972,1972,1972,1972,1972,1972,1972,1972,1972,1972,1972,1972,1972,1972,1972,1972,1972,1972,1972,1972,1972,1972,1972,1972,1972,1972,1972,1972,1972,1972,1972,1972,1972,1972,1972,1972,1972,1972,1972,1972,1972,1972,1972,1972,1972,1972,1972,1972,1972,1972,1972,1972,1972,1972,1972,1972,1972,1972,1972,1972,1972,1972,1972,1972,1972,1972,1972,1972,1972,1972,1972,1972,1972,1977,1977,1977,1977,1977,1977,1977,1977,1977,1977,1977,1977,1977,1977,1977,1977,1977,1977,1977,1977,1977,1977,1977,1977,1977,1977,1977,1977,1977,1977,1977,1977,1977,1977,1977,1977,1977,1977,1977,1977,1977,1977,1977,1977,1977,1977,1977,1977,1977,1977,1977,1977,1977,1977,1977,1977,1977,1977,1977,1977,1977,1977,1977,1977,1977,1977,1977,1977,1977,1977,1977,1977,1977,1977,1977,1977,1977,1977,1977,1977,1977,1977,1977,1977,1977,1977,1977,1977,1977,1977,1977,1977,1977,1977,1977,1977,1977,1977,1977,1977,1977,1977,1977,1977,1977,1977,1977,1977,1977,1977,1977,1977,1977,1977,1977,1977,1977,1977,1977,1977,1977,1977,1977,1977,1977,1977,1977,1977,1977,1977,1977,1977,1977,1977,1977,1977,1977,1977,1977,1977,1977,1977,1982,1982,1982,1982,1982,1982,1982,1982,1982,1982,1982,1982,1982,1982,1982,1982,1982,1982,1982,1982,1982,1982,1982,1982,1982,1982,1982,1982,1982,1982,1982,1982,1982,1982,1982,1982,1982,1982,1982,1982,1982,1982,1982,1982,1982,1982,1982,1982,1982,1982,1982,1982,1982,1982,1982,1982,1982,1982,1982,1982,1982,1982,1982,1982,1982,1982,1982,1982,1982,1982,1982,1982,1982,1982,1982,1982,1982,1982,1982,1982,1982,1982,1982,1982,1982,1982,1982,1982,1982,1982,1982,1982,1982,1982,1982,1982,1982,1982,1982,1982,1982,1982,1982,1982,1982,1982,1982,1982,1982,1982,1982,1982,1982,1982,1982,1982,1982,1982,1982,1982,1982,1982,1982,1982,1982,1982,1982,1982,1982,1982,1982,1982,1982,1982,1982,1982,1982,1982,1982,1982,1982,1982,1987,1987,1987,1987,1987,1987,1987,1987,1987,1987,1987,1987,1987,1987,1987,1987,1987,1987,1987,1987,1987,1987,1987,1987,1987,1987,1987,1987,1987,1987,1987,1987,1987,1987,1987,1987,1987,1987,1987,1987,1987,1987,1987,1987,1987,1987,1987,1987,1987,1987,1987,1987,1987,1987,1987,1987,1987,1987,1987,1987,1987,1987,1987,1987,1987,1987,1987,1987,1987,1987,1987,1987,1987,1987,1987,1987,1987,1987,1987,1987,1987,1987,1987,1987,1987,1987,1987,1987,1987,1987,1987,1987,1987,1987,1987,1987,1987,1987,1987,1987,1987,1987,1987,1987,1987,1987,1987,1987,1987,1987,1987,1987,1987,1987,1987,1987,1987,1987,1987,1987,1987,1987,1987,1987,1987,1987,1987,1987,1987,1987,1987,1987,1987,1987,1987,1987,1987,1987,1987,1987,1987,1987,1992,1992,1992,1992,1992,1992,1992,1992,1992,1992,1992,1992,1992,1992,1992,1992,1992,1992,1992,1992,1992,1992,1992,1992,1992,1992,1992,1992,1992,1992,1992,1992,1992,1992,1992,1992,1992,1992,1992,1992,1992,1992,1992,1992,1992,1992,1992,1992,1992,1992,1992,1992,1992,1992,1992,1992,1992,1992,1992,1992,1992,1992,1992,1992,1992,1992,1992,1992,1992,1992,1992,1992,1992,1992,1992,1992,1992,1992,1992,1992,1992,1992,1992,1992,1992,1992,1992,1992,1992,1992,1992,1992,1992,1992,1992,1992,1992,1992,1992,1992,1992,1992,1992,1992,1992,1992,1992,1992,1992,1992,1992,1992,1992,1992,1992,1992,1992,1992,1992,1992,1992,1992,1992,1992,1992,1992,1992,1992,1992,1992,1992,1992,1992,1992,1992,1992,1992,1992,1992,1992,1992,1992,1997,1997,1997,1997,1997,1997,1997,1997,1997,1997,1997,1997,1997,1997,1997,1997,1997,1997,1997,1997,1997,1997,1997,1997,1997,1997,1997,1997,1997,1997,1997,1997,1997,1997,1997,1997,1997,1997,1997,1997,1997,1997,1997,1997,1997,1997,1997,1997,1997,1997,1997,1997,1997,1997,1997,1997,1997,1997,1997,1997,1997,1997,1997,1997,1997,1997,1997,1997,1997,1997,1997,1997,1997,1997,1997,1997,1997,1997,1997,1997,1997,1997,1997,1997,1997,1997,1997,1997,1997,1997,1997,1997,1997,1997,1997,1997,1997,1997,1997,1997,1997,1997,1997,1997,1997,1997,1997,1997,1997,1997,1997,1997,1997,1997,1997,1997,1997,1997,1997,1997,1997,1997,1997,1997,1997,1997,1997,1997,1997,1997,1997,1997,1997,1997,1997,1997,1997,1997,1997,1997,1997,1997,2002,2002,2002,2002,2002,2002,2002,2002,2002,2002,2002,2002,2002,2002,2002,2002,2002,2002,2002,2002,2002,2002,2002,2002,2002,2002,2002,2002,2002,2002,2002,2002,2002,2002,2002,2002,2002,2002,2002,2002,2002,2002,2002,2002,2002,2002,2002,2002,2002,2002,2002,2002,2002,2002,2002,2002,2002,2002,2002,2002,2002,2002,2002,2002,2002,2002,2002,2002,2002,2002,2002,2002,2002,2002,2002,2002,2002,2002,2002,2002,2002,2002,2002,2002,2002,2002,2002,2002,2002,2002,2002,2002,2002,2002,2002,2002,2002,2002,2002,2002,2002,2002,2002,2002,2002,2002,2002,2002,2002,2002,2002,2002,2002,2002,2002,2002,2002,2002,2002,2002,2002,2002,2002,2002,2002,2002,2002,2002,2002,2002,2002,2002,2002,2002,2002,2002,2002,2002,2002,2002,2002,2002,2007,2007,2007,2007,2007,2007,2007,2007,2007,2007,2007,2007,2007,2007,2007,2007,2007,2007,2007,2007,2007,2007,2007,2007,2007,2007,2007,2007,2007,2007,2007,2007,2007,2007,2007,2007,2007,2007,2007,2007,2007,2007,2007,2007,2007,2007,2007,2007,2007,2007,2007,2007,2007,2007,2007,2007,2007,2007,2007,2007,2007,2007,2007,2007,2007,2007,2007,2007,2007,2007,2007,2007,2007,2007,2007,2007,2007,2007,2007,2007,2007,2007,2007,2007,2007,2007,2007,2007,2007,2007,2007,2007,2007,2007,2007,2007,2007,2007,2007,2007,2007,2007,2007,2007,2007,2007,2007,2007,2007,2007,2007,2007,2007,2007,2007,2007,2007,2007,2007,2007,2007,2007,2007,2007,2007,2007,2007,2007,2007,2007,2007,2007,2007,2007,2007,2007,2007,2007,2007,2007,2007,2007],[28.801,55.23,43.077,30.015,62.485,69.12,66.8,50.939,37.484,68,38.223,40.414,53.82,47.622,50.917,59.6,31.975,39.031,39.417,38.523,68.75,35.463,38.092,54.745,44,50.643,40.715,39.143,42.111,57.206,40.477,61.21,59.421,66.87,70.78,34.812,45.928,48.357,41.893,45.262,34.482,35.928,34.078,66.55,67.41,37.003,30,67.5,43.149,65.86,42.023,33.609,32.5,37.579,41.912,60.96,64.03,72.49,37.373,37.468,44.869,45.32,66.91,65.39,65.94,58.53,63.03,43.158,42.27,50.056,47.453,55.565,55.928,42.138,38.48,42.723,36.681,36.256,48.463,33.685,40.543,50.986,50.789,42.244,59.164,42.873,31.286,36.319,41.725,36.157,72.13,69.39,42.314,37.444,36.324,72.67,37.578,43.436,55.191,62.649,43.902,47.752,61.31,59.82,64.28,52.724,61.05,40,46.471,39.875,37.278,57.996,30.331,60.396,64.36,65.57,32.978,45.009,64.94,57.593,38.635,41.407,71.86,69.62,45.883,58.5,41.215,50.848,38.596,59.1,44.6,43.585,39.978,69.18,68.44,66.071,55.088,40.412,43.16,32.548,42.038,48.451,30.332,59.28,45.685,31.999,64.399,70.33,67.48,53.832,39.348,69.24,40.358,41.89,58.45,49.618,53.285,66.61,34.906,40.533,41.366,40.428,69.96,37.464,39.881,56.074,50.54896,55.118,42.46,40.652,45.053,60.026,42.469,64.77,62.325,69.03,71.81,37.328,49.828,51.356,44.444,48.57,35.983,38.047,36.667,67.49,68.93,38.999,32.065,69.1,44.779,67.86,44.142,34.558,33.489,40.696,44.665,64.75,66.41,73.47,40.249,39.918,47.181,48.437,68.9,67.84,67.81,62.61,65.5,45.669,44.686,54.081,52.681,58.033,59.489,45.047,39.486,45.289,38.865,37.207,52.102,35.307,42.338,58.089,55.19,45.248,61.448,45.423,33.779,41.905,45.226,37.686,72.99,70.26,45.432,38.598,37.802,73.44,40.08,45.557,59.201,63.196,46.263,51.334,65.77,61.51,68.54,55.09,64.1,41.5,48.945,42.868,39.329,61.685,31.57,63.179,67.45,67.85,34.977,47.985,66.66,61.456,39.624,43.424,72.49,70.56,48.284,62.4,42.974,53.63,41.208,61.8,47.1,48.079,42.571,70.42,69.49,67.044,57.907,42.887,45.671,33.97,44.077,50.469,31.997,64.82,48.303,34,65.142,70.93,69.54,56.923,41.216,70.25,42.618,43.428,61.93,51.52,55.665,69.51,37.814,42.045,43.415,42.643,71.3,39.475,41.716,57.924,44.50136,57.863,44.467,42.122,48.435,62.842,44.93,67.13,65.246,69.9,72.35,39.693,53.459,54.64,46.992,52.307,37.485,40.158,40.059,68.75,70.51,40.489,33.896,70.3,46.452,69.51,46.954,35.753,34.488,43.59,48.041,67.65,67.96,73.68,43.605,42.518,49.325,51.457,70.29,69.39,69.24,65.61,68.73,48.126,47.949,56.656,55.292,60.47,62.094,47.747,40.502,47.808,40.848,38.41,55.737,36.936,44.248,60.246,58.299,48.251,63.728,47.924,36.161,45.108,48.386,39.393,73.23,71.24,48.632,39.487,39.36,73.47,43.165,47.67,61.817,64.361,49.096,54.757,67.64,64.39,69.62,57.666,66.8,43,51.893,45.914,41.454,64.531,32.767,65.798,70.33,69.15,36.981,49.951,69.69,62.192,40.87,44.992,73.37,71.32,50.305,65.2,44.246,56.061,43.922,64.9,49.579,52.098,45.344,70.76,70.21,68.253,60.77,45.363,48.127,35.18,46.023,52.358,34.02,66.22,51.407,35.985,65.634,71.1,70.14,59.923,43.453,70.94,44.885,45.032,64.79,53.298,57.632,70.42,40.697,43.548,45.415,44.799,72.13,41.478,43.601,60.523,58.38112,59.963,46.472,44.056,52.04,65.424,47.35,68.5,68.29,70.38,72.96,42.074,56.751,56.678,49.293,55.855,38.987,42.189,42.115,69.83,71.55,44.598,35.857,70.8,48.072,71,50.016,37.197,35.492,46.243,50.924,70,69.5,73.73,47.193,45.964,52.469,54.459,71.08,70.75,71.06,67.51,71.43,51.629,50.654,59.942,57.716,64.624,63.87,48.492,41.536,50.227,42.881,39.487,59.371,38.487,46.289,61.557,60.11,51.253,67.178,50.335,38.113,49.379,51.159,41.472,73.82,71.52,51.884,40.118,41.04,74.08,46.988,49.8,64.071,64.951,51.445,56.393,69.61,66.6,71.1,60.542,66.8,44.1,54.425,49.901,43.563,66.914,34.113,67.946,70.98,69.18,38.977,51.927,71.44,64.266,42.858,46.633,74.16,72.77,53.655,67.5,45.757,58.285,46.769,65.4,52.053,54.336,48.051,71.36,70.76,68.468,63.479,47.838,51.631,36.984,47.768,53.995,36.088,67.69,54.518,37.928,67.065,71.93,70.63,63.3,45.252,71.44,47.014,46.714,67.45,56.024,59.504,70.9,43.591,44.057,40.317,47.049,72.88,43.457,45.569,63.441,63.11888,61.623,48.944,45.989,54.907,67.849,49.801,69.61,70.723,70.29,73.47,44.366,59.631,58.796,51.137,58.207,40.516,44.142,43.515,70.87,72.38,48.69,38.308,71,49.875,72.34,53.738,38.842,36.486,48.042,53.884,72,69.76,74.46,50.651,49.203,55.234,56.95,71.28,71.63,72.19,69,73.42,56.528,53.559,63.983,62.612,67.712,65.421,49.767,42.614,52.773,44.851,41.766,63.01,39.977,48.437,62.944,62.361,53.754,70.636,52.862,40.328,53.07,53.867,43.971,73.75,71.89,55.151,40.546,42.821,74.34,52.143,51.929,66.216,65.815,55.448,58.065,70.85,69.26,72.16,64.274,69.21,44.6,56.48,53.886,45.815,68.7,35.4,69.521,70.35,69.82,40.973,53.696,73.06,65.042,45.083,49.552,74.72,73.78,57.296,69.39,47.62,60.405,49.759,65.9,55.602,57.005,51.016,72.01,71.34,68.673,65.712,50.254,56.532,39.848,50.107,55.635,38.438,68.93,58.014,39.483,68.481,73.49,72.17,65.593,46.923,72.8,49.19,50.023,69.86,59.319,61.489,70.81,46.137,45.91,31.22,49.355,74.21,46.775,47.383,67.052,63.96736,63.837,50.939,47.804,55.625,70.75,52.374,70.64,72.649,70.71,74.69,46.519,61.788,61.31,53.319,56.696,42.024,44.535,44.51,72.52,73.83,52.79,41.842,72.5,51.756,73.68,56.029,40.762,37.465,49.923,57.402,73.6,69.95,76.11,54.208,52.702,57.702,60.413,72.03,73.06,73.48,70.11,75.38,61.134,56.155,67.159,64.766,69.343,66.099,52.208,43.764,57.442,46.881,43.767,65.256,41.714,50.852,64.93,65.032,55.491,73.066,55.73,42.495,56.059,56.437,46.748,75.24,72.22,57.47,41.291,44.514,75.37,57.367,54.043,68.681,66.353,58.447,60.06,70.67,70.41,73.44,67.064,69.46,45,58.55,58.69,48.879,70.3,36.788,70.795,70.45,70.97,41.974,55.527,74.39,65.949,47.8,52.537,75.44,75.39,61.195,70.59,49.919,62.494,52.887,68.3,59.837,59.507,50.35,72.76,73.38,69.481,67.456,55.764,60.765,44.175,51.386,57.674,39.854,70.42,61.368,39.942,69.942,74.74,73.18,69.052,50.009,73.93,50.904,53.859,70.69,61.484,63.336,71.08,48.122,47.471,50.957,52.961,75.76,48.295,49.517,70.565,65.525,66.653,52.933,47.784,56.695,73.45,53.983,70.46,73.717,70.96,74.63,48.812,63.727,64.342,56.006,56.604,43.662,43.89,44.916,74.55,74.89,56.564,45.58,73.8,53.744,75.24,58.137,42.891,39.327,51.461,60.909,75.45,69.39,76.99,56.596,56.159,59.62,62.038,73.1,74.45,74.98,71.21,77.11,63.739,58.766,69.1,67.123,71.309,66.983,55.078,44.852,62.155,48.969,45.642,68,43.916,53.599,66.711,67.405,57.489,74.101,59.65,42.795,58.056,58.968,49.594,76.05,73.84,59.298,42.598,45.826,75.97,62.728,56.158,70.472,66.874,61.406,62.082,71.32,72.77,73.75,69.885,69.66,46.218,60.351,63.012,52.379,70.162,38.445,71.76,70.8,71.063,42.955,58.161,76.3,68.757,50.338,55.561,76.42,76.21,64.59,72.16,50.608,64.597,55.471,68.832,64.048,61.036,49.849,74.04,74.65,70.805,68.557,58.816,64.406,49.113,51.821,60.363,40.822,72,65.799,39.906,70.774,76.32,74.94,70.75,52.819,75.35,52.337,57.251,71.14,63.622,65.205,71.34,49.557,48.211,53.914,54.985,76.86,50.485,51.051,72.492,67.274,67.768,54.926,47.412,57.47,74.752,54.655,71.52,74.174,71.58,74.8,50.04,66.046,67.231,59.797,63.154,45.664,46.453,46.684,74.83,76.34,60.19,49.265,74.847,55.729,76.67,60.782,45.552,41.245,53.636,64.492,76.2,69.58,77.23,58.553,60.137,63.04,65.044,74.36,75.6,76.42,71.77,78.67,65.869,59.339,70.647,69.81,74.174,67.926,57.18,46.027,66.234,49.35,47.457,69.5,46.364,56.145,68.74,69.498,60.222,74.865,62.677,42.861,58.339,60.835,52.537,76.83,74.32,62.008,44.555,46.886,75.89,67.734,58.245,71.523,67.378,64.134,64.151,70.98,74.06,74.63,71.913,69.53,44.02,61.728,66.295,55.769,71.218,40.006,73.56,71.08,72.25,44.501,60.834,76.9,69.011,51.744,57.678,77.19,77.41,66.974,73.4,51.535,66.084,56.941,69.582,66.894,63.108,51.509,75.007,75.02,71.918,70.19,62.82,67.046,52.922,50.821,62.351,41.674,71.581,67.744,40.647,71.868,77.56,76.04,72.601,56.018,76.46,53.919,59.957,72.178,62.745,67.057,71.19,50.26,44.736,55.803,54.314,77.95,49.396,51.724,74.126,68.69,68.421,57.939,45.548,56.433,75.713,52.044,72.527,74.414,72.4,75.33,51.604,68.457,69.613,63.674,66.798,47.545,49.991,48.091,75.7,77.46,61.366,52.644,76.07,57.501,77.03,63.373,48.576,43.266,55.089,66.399,77.601,69.17,78.77,60.223,62.681,65.742,59.461,75.467,76.93,77.44,71.766,79.36,68.015,59.285,69.978,72.244,75.19,69.292,59.685,40.802,68.755,52.214,49.42,70.693,48.388,58.333,69.745,71.455,61.271,75.435,65.393,44.284,59.32,61.999,55.727,77.42,76.33,65.843,47.391,47.472,77.32,71.197,60.838,72.462,68.225,66.458,66.458,70.99,74.86,73.911,73.615,69.36,23.599,62.742,68.768,58.196,71.659,38.333,75.788,71.38,73.64,39.658,61.888,77.57,70.379,53.556,58.474,78.16,78.03,69.249,74.26,50.44,67.298,58.061,69.862,70.001,66.146,48.825,76.42,76.09,72.752,71.15,67.662,69.718,55.599,46.1,60.377,41.763,72.95,69.152,40.963,73.275,78.83,77.51,73.925,59.412,77.53,54.777,62.05,73.244,52.556,69.388,70.32,50.324,45.326,56.534,52.199,78.61,46.066,51.573,75.816,70.426,70.313,60.66,42.587,52.962,77.26,47.991,73.68,76.151,74.01,76.11,53.157,69.957,72.312,67.217,69.535,48.245,53.378,49.402,77.13,78.64,60.461,55.861,77.34,58.556,77.869,66.322,51.455,44.873,56.671,67.659,80,71.04,78.95,61.765,66.041,68.042,58.811,76.122,78.269,78.82,72.262,80.69,69.772,54.407,67.727,74.647,76.156,70.265,55.558,42.221,71.555,54.978,47.495,71.938,49.903,60.43,70.736,73.67,63.625,75.445,67.66,46.344,60.328,58.909,59.426,78.03,77.55,68.426,51.313,47.464,78.32,72.499,61.818,73.738,69.4,68.386,68.564,72.75,75.97,74.917,74.772,69.72,36.087,63.306,70.533,60.187,72.232,39.897,77.158,72.71,75.13,43.795,60.236,78.77,70.457,55.373,54.289,79.39,79.37,71.527,75.25,48.466,67.521,58.39,69.465,71.973,68.835,44.578,77.218,76.81,74.223,72.146,70.672,71.096,58.02,40.238,46.809,42.129,75.651,70.994,41.003,74.34,80.37,78.98,74.795,62.013,78.32,54.406,63.883,74.09,46.634,71.006,72.14,50.65,47.36,56.752,49.856,79.77,43.308,50.525,77.86,72.028,71.682,62.974,44.966,52.97,78.123,46.832,74.876,77.158,75.51,77.18,53.373,70.847,74.173,69.806,70.734,49.348,55.24,50.725,78.37,79.59,56.761,58.041,78.67,58.453,78.256,68.978,53.676,45.504,58.137,68.565,81.495,72.59,80.5,62.879,68.588,69.451,57.046,77.783,79.696,80.24,72.047,82,71.263,50.992,66.662,77.045,76.904,71.028,44.593,43.753,72.737,57.286,45.009,73.044,51.818,62.247,71.954,74.902,65.033,73.981,69.615,44.026,59.908,51.479,61.34,78.53,79.11,70.836,54.496,46.608,79.05,74.193,63.61,74.712,70.755,69.906,70.303,74.67,77.29,77.778,75.744,71.322,43.413,64.337,71.626,61.6,73.213,41.012,78.77,73.8,76.66,45.936,53.365,79.78,70.815,56.369,43.869,80.04,80.62,73.053,76.99,49.651,68.564,57.561,68.976,73.042,70.845,47.813,78.471,77.31,75.307,72.766,73.017,72.37,60.308,39.193,39.989,43.828,76.423,72.301,42.731,75.32,81.235,79.829,75.635,64.062,79.441,56.728,65.554,74.852,50.728,72.39,73.005,52.295,49.58,59.723,50.43,80.653,44.741,50.651,78.553,72.961,72.889,65.152,46.462,55.322,78.782,48.328,75.748,78.273,76.486,78.332,54.791,72.235,74.994,71.338,71.878,51.579,58.04,52.947,79.313,80.657,56.735,59.448,79.406,60.022,79.483,70.259,56.007,46.388,60.916,70.198,82.208,73.338,81.757,64.698,70.65,70.964,59.545,78.885,80.745,80.546,72.567,82.603,72.535,54.11,67.297,78.623,77.588,71.993,42.592,45.678,73.952,59.443,48.303,74.241,54.467,64.164,72.801,76.195,66.803,74.543,71.164,42.082,62.069,52.906,63.785,79.762,80.204,72.899,56.867,46.859,80.196,75.64,65.483,75.537,71.752,71.421,71.688,75.563,78.098,78.746,76.442,72.476,46.242,65.528,72.777,63.062,74.002,42.568,79.972,74.663,77.926,48.159,49.339,80.941,72.396,58.556,39.613,80.884,81.701,74.143,78.4,52.517,70.616,58.42,69.819,73.923,71.777,51.542,79.425,78.242,76.384,73.747,74.249,73.422,62.698,42.384,43.487],[8425333,1282697,9279525,4232095,17876956,8691212,6927772,120447,46886859,8730405,1738315,2883315,2791000,442308,56602560,7274900,4469979,2445618,4693836,5009067,14785584,1291695,2682462,6377619,556263527,12350771,153936,14100005,854885,926317,2977019,3882229,6007797,9125183,4334000,63149,2491346,3548753,22223309,2042865,216964,1438760,20860941,4090500,42459667,420702,284320,69145952,5581001,7733250,3146381,2664249,580653,3201488,1517453,2125900,9504000,147962,372000000,82052000,17272000,5441766,2952156,1620914,47666000,1426095,86459025,607914,6464046,8865488,20947571,160000,1439529,748747,863308,1019729,4762912,2917802,6748378,3838168,1022556,516556,30144317,800663,413834,9939217,6446316,20092996,485831,9182536,10381988,1994794,1165790,3379468,33119096,3327728,507833,41346560,940080,1555876,8025700,22438691,25730551,8526050,2227000,257700,16630000,2534927,60011,4005677,2755589,6860147,2143249,1127000,3558137,1489518,2526994,14264935,28549870,7982342,8504667,290243,7124673,4815000,3661549,8550362,8322925,21289402,1219113,662850,3647735,22235677,5824797,50430000,157553000,2252965,5439568,26246839,1030585,4963829,2672000,3080907,9240934,1476505,10270856,4561361,19610538,9712569,6965860,138655,51365468,8989111,1925173,3211738,3076000,474639,65551171,7651254,4713416,2667518,5322536,5359923,17010154,1392284,2894855,7048426,637408000,14485993,170928,15577932,940458,1112300,3300000,3991242,6640752,9513758,4487831,71851,2923186,4058385,25009741,2355805,232922,1542611,22815614,4324000,44310863,434904,323150,71019069,6391288,8096218,3640876,2876726,601095,3507701,1770390,2736300,9839000,165110,409000000,90124000,19792000,6248643,2878220,1944401,49182000,1535090,91563009,746559,7454779,9411381,22611552,212846,1647412,813338,975950,1201578,5181679,3221238,7739235,4241884,1076852,609816,35015548,882134,442829,11406350,7038035,21731844,548080,9682338,11026383,2229407,1358828,3692184,37173340,3491938,561977,46679944,1063506,1770902,9146100,26072194,28235346,8817650,2260000,308700,17829327,2822082,61325,4419650,3054547,7271135,2295678,1445929,3844277,1533070,2780415,16151549,29841614,9128546,9753392,326741,7363802,5126000,4149908,10164215,9452826,25041917,1357445,764900,3950849,25670939,6675501,51430000,171984000,2424959,6702668,28998543,1070439,5498090,3016000,3646340,10267083,1728137,11000948,4826015,21283783,10794968,7129864,171863,56839289,9218400,2151895,3593918,3349000,512764,76039390,8012946,4919632,2961915,6083619,5793633,18985849,1523478,3150417,7961258,665770000,17009885,191689,17486434,1047924,1345187,3832408,4076557,7254373,9620282,4646899,89898,3453434,4681707,28173309,2747687,249220,1666618,25145372,4491443,47124000,455661,374020,73739117,7355248,8448233,4208858,3140003,627820,3880130,2090162,3305200,10063000,182053,454000000,99028000,22874000,7240260,2830000,2310904,50843200,1665128,95831757,933559,8678557,10917494,26420307,358266,1886848,893143,1112796,1441863,5703324,3628608,8906385,4690372,1146757,701016,41121485,1010280,474528,13056604,7788944,23634436,621392,10332057,11805689,2488550,1590597,4076008,41871351,3638919,628164,53100671,1215725,2009813,10516500,30325264,30329617,9019800,2448046,358900,18680721,3051242,65345,4943029,3430243,7616060,2467895,1750200,4237384,1582962,3080153,18356657,31158061,10421936,11183227,370006,7561588,5666000,4834621,11918938,10863958,29263397,1528098,887498,4286552,29788695,7688797,53292000,186538000,2598466,8143375,33796140,1133134,6120081,3421000,4277736,11537966,1984060,12760499,5247469,22934225,11872264,7376998,202182,62821884,9556500,2427334,4040665,3585000,553541,88049823,8310226,5127935,3330989,6960067,6335506,20819767,1733638,3495967,8858908,754550000,19764027,217378,19941073,1179760,1588717,4744870,4174366,8139332,9835109,4838800,127617,4049146,5432424,31681188,3232927,259864,1820319,27860297,4605744,49569000,489004,439593,76368453,8490213,8716441,4690773,3451418,601287,4318137,2500689,3722800,10223422,198676,506000000,109343000,26538000,8519282,2900100,2693585,52667100,1861096,100825279,1255058,10191512,12617009,30131000,575003,2186894,996380,1279406,1759224,6334556,4147252,10154878,5212416,1230542,789309,47995559,1149500,501035,14770296,8680909,25870271,706640,11261690,12596822,2728150,1865490,4534062,47287752,3786019,714775,60641899,1405486,2287985,12132200,35356600,31785378,9103000,2648961,414024,19284814,3451079,70787,5618198,3965841,7971222,2662190,1977600,4442238,1646912,3428839,20997321,32850275,11737396,12716129,420690,7867931,6063000,5680812,13648692,12607312,34024249,1735550,960155,4786986,33411317,8900294,54959000,198712000,2748579,9709552,39463910,1142636,6740785,3900000,4995432,13079460,2263554,14760787,5894858,24779799,13177000,7544201,230800,70759295,9709100,2761407,4565872,3819000,619351,100840058,8576200,5433886,3529983,7450606,7021028,22284500,1927260,3899068,9717524,862030000,22542890,250027,23007669,1340458,1834796,6071696,4225310,8831348,9862158,4991596,178848,4671329,6298651,34807417,3790903,277603,2260187,30770372,4639657,51732000,537977,517101,78717088,9354120,8888628,5149581,3811387,625361,4698301,2965146,4115700,10394091,209275,567000000,121282000,30614000,10061506,3024400,3095893,54365564,1997616,107188273,1613551,12044785,14781241,33505000,841934,2680018,1116779,1482628,2183877,7082430,4730997,11441462,5828158,1332786,851334,55984294,1320500,527678,16660670,9809596,28466390,821782,12412593,13329874,2929100,2182908,5060262,53740085,3933004,829050,69325921,1616384,2614104,13954700,40850141,33039545,8970450,2847132,461633,20662648,3992121,76595,6472756,4588696,8313288,2879013,2152400,4593433,1694510,3840161,23935810,34513161,13016733,14597019,480105,8122293,6401400,6701172,15226039,14706593,39276153,2056351,975199,5303507,37492953,10190285,56079000,209896000,2829526,11515649,44655014,1089572,7407075,4506497,5861135,14880372,2509048,17152804,6162675,26983828,14074100,7568430,297410,80428306,9821800,3168267,5079716,4086000,781472,114313951,8797022,5889574,3834415,6978607,7959865,23796400,2167533,4388260,10599793,943455000,25094412,304739,26480870,1536769,2108457,7459574,4318673,9537988,10161915,5088419,228694,5302800,7278866,38783863,4282586,192675,2512642,34617799,4738902,53165019,706367,608274,78160773,10538093,9308479,5703430,4227026,745228,4908554,3055235,4583700,10637171,221823,634000000,136725000,35480679,11882916,3271900,3495918,56059245,2156814,113872473,1937652,14500404,16325320,36436000,1140357,3115787,1251524,1703617,2721783,8007166,5637246,12845381,6491649,1456688,913025,63759976,1528000,560073,18396941,11127868,31528087,977026,13933198,13852989,3164900,2554598,5682086,62209173,4043205,1004533,78152686,1839782,2984494,15990099,46850962,34621254,9662600,3080828,492095,21658597,4657072,86796,8128505,5260855,8686367,3140897,2325300,4827803,1746919,4353666,27129932,36439000,14116836,17104986,551425,8251648,6316424,7932503,16785196,17129565,44148285,2308582,1039009,6005061,42404033,11457758,56179000,220239000,2873520,13503563,50533506,1261091,8403990,5216550,6642107,12881816,2780097,20033753,7016384,29341374,15184200,7574613,377967,93074406,9856303,3641603,5642224,4172693,970347,128962939,8892098,6634596,4580410,7272485,9250831,25201900,2476971,4875118,11487112,1000281000,27764644,348643,30646495,1774735,2424367,9025951,4413368,9789224,10303704,5117810,305991,5968349,8365850,45681811,4474873,285483,2637297,38111756,4826933,54433565,753874,715523,78335266,11400338,9786480,6395630,4710497,825987,5198399,3669448,5264500,10705535,233997,708000000,153343000,43072751,14173318,3480000,3858421,56535636,2298309,118454974,2347031,17661452,17647518,39326000,1497494,3086876,1411807,1956875,3344074,9171477,6502825,14441916,6998256,1622136,992040,71640904,1756032,562548,20198730,12587223,34680442,1099010,15796314,14310401,3210650,2979423,6437188,73039376,4114787,1301048,91462088,2036305,3366439,18125129,53456774,36227381,9859650,3279001,517810,22356726,5507565,98593,11254672,6147783,9032824,3464522,2651869,5048043,1861252,5828892,31140029,37983310,15410151,20367053,649901,8325260,6468126,9410494,18501390,19844382,48827160,2644765,1116479,6734098,47328791,12939400,56339704,232187835,2953997,15620766,56142181,1425876,9657618,6100407,7636524,13867957,3075321,23254956,7874230,31620918,16257249,7578903,454612,103764241,9870200,4243788,6156369,4338977,1151184,142938076,8971958,7586551,5126023,8371791,10780667,26549700,2840009,5498955,12463354,1084035000,30964245,395114,35481645,2064095,2799811,10761098,4484310,10239839,10311597,5127024,311025,6655297,9545158,52799062,4842194,341244,2915959,42999530,4931729,55630100,880397,848406,77718298,14168101,9974490,7326406,5650262,927524,5756203,4372203,5584510,10612740,244676,788000000,169276000,51889696,16543189,3539900,4203148,56729703,2326606,122091325,2820042,21198082,19067554,41622000,1891487,3089353,1599200,2269414,3799845,10568642,7824747,16331785,7634008,1841240,1042663,80122492,2015133,569473,22987397,12891952,38028578,1278184,17917180,14665278,3317166,3344353,7332638,81551520,4186147,1593882,105186881,2253639,3886512,20195924,60017788,37740710,9915289,3444468,562035,22686371,6349365,110812,14619745,7171347,9230783,3868905,2794552,5199318,1945870,6921858,35933379,38880702,16495304,24725960,779348,8421403,6649942,11242847,19757799,23040630,52910342,3154264,1191336,7724976,52881328,15283050,56981620,242803533,3045153,17910182,62826491,1691210,11219340,7272406,9216418,16317921,3326498,26298373,8735988,33958947,17481977,7914969,529491,113704579,10045622,4981671,6893451,4256013,1342614,155975974,8658506,8878303,5809236,10150094,12467171,28523502,3265124,6429417,13572994,1164970000,34202721,454429,41672143,2409073,3173216,12772596,4494013,10723260,10315702,5171393,384156,7351181,10748394,59402198,5274649,387838,3668440,52088559,5041039,57374179,985739,1025384,80597764,16278738,10325429,8486949,6990574,1050938,6326682,5077347,5829696,10348684,259012,872000000,184816000,60397973,17861905,3557761,4936550,56840847,2378618,124329269,3867409,25020539,20711375,43805450,1418095,3219994,1803195,1912974,4364501,12210395,10014249,18319502,8416215,2119465,1096202,88111030,2312802,621621,25798239,13160731,40546538,1554253,20326209,15174244,3437674,4017939,8392818,93364244,4286357,1915208,120065004,2484997,4483945,22430449,67185766,38370697,9927680,3585176,622191,22797027,7290203,125911,16945857,8307920,9826397,4260884,3235865,5302888,1999210,6099799,39964159,39549438,17587060,28227588,962344,8718867,6995447,13219062,20686918,26605473,56667095,3747553,1183669,8523077,58179144,18252190,57866349,256894189,3149262,20265563,69940728,2104779,13367997,8381163,10704340,22227415,3428038,29072015,9875024,36203463,18565243,8069876,598561,123315288,10199787,6066080,7693188,3607000,1536536,168546719,8066057,10352843,6121610,11782962,14195809,30305843,3696513,7562011,14599929,1230075000,37657830,527982,47798986,2800947,3518107,14625967,4444595,10983007,10300707,5283663,417908,7992357,11911819,66134291,5783439,439971,4058319,59861301,5134406,58623428,1126189,1235767,82011073,18418288,10502372,9803875,8048834,1193708,6913545,5867957,6495918,10244684,271192,959000000,199278000,63327987,20775703,3667233,5531387,57479469,2531311,125956499,4526235,28263827,21585105,46173816,1765345,3430388,1982823,2200725,4759670,14165114,10419991,20476091,9384984,2444741,1149818,95895146,2494803,692651,28529501,16603334,43247867,1774766,23001113,15604464,3676187,4609572,9666252,106207839,4405672,2283635,135564834,2734531,5154123,24748122,75012988,38654957,10156415,3759430,684810,22562458,7212583,145608,21229759,9535314,10336594,4578212,3802309,5383010,2011612,6633514,42835005,39855442,18698655,32160729,1054486,8897619,7193761,15081016,21628605,30686889,60216677,4320890,1138101,9231669,63047647,21210254,58808266,272911760,3262838,22374398,76048996,2826046,15826497,9417789,11404948,25268405,3508512,31287142,10866106,38331121,19546792,8148312,656397,135656790,10311970,7026113,8445134,4165416,1630347,179914212,7661799,12251209,7021078,12926707,15929988,31902268,4048013,8835739,15497046,1280400000,41008227,614382,55379852,3328795,3834934,16252726,4481020,11226999,10256295,5374693,447416,8650322,12921234,73312559,6353681,495627,4414865,67946797,5193039,59925035,1299304,1457766,82350671,20550751,10603863,11178650,8807818,1332459,7607651,6677328,6762476,10083313,288030,1034172547,211060000,66907826,24001816,3879155,6029529,57926999,2664659,127065841,5307470,31386842,22215365,47969150,2111561,3677780,2046772,2814651,5368585,16473477,11824495,22662365,10580176,2828858,1200206,102479927,2674234,720230,31167783,18473780,45598081,1972153,25873917,16122830,3908037,5146848,11140655,119901274,4535591,2713462,153403524,2990875,5884491,26769436,82995088,38625976,10433867,3859606,743981,22404337,7852401,170372,24501530,10870037,10111559,5359092,4197776,5410052,2011497,7753310,44433622,40152517,19576783,37090298,1130269,8954175,7361757,17155814,22454239,34593779,62806748,4977378,1101832,9770575,67308928,24739869,59912431,287675526,3363085,24287670,80908147,3389578,18701257,10595811,11926563,31889923,3600523,33333216,12420476,40301927,20434176,8199783,708573,150448339,10392226,8078314,9119152,4552198,1639131,190010647,7322858,14326203,8390505,14131858,17696293,33390141,4369038,10238807,16284741,1318683096,44227550,710960,64606759,3800610,4133884,18013409,4493312,11416987,10228744,5468120,496374,9319622,13755680,80264543,6939688,551201,4906585,76511887,5238460,61083916,1454867,1688359,82400996,22873338,10706290,12572928,9947814,1472041,8502814,7483763,6980412,9956108,301931,1110396331,223547000,69453570,27499638,4109086,6426679,58147733,2780132,127467972,6053193,35610177,23301725,49044790,2505559,3921278,2012649,3193942,6036914,19167654,13327079,24821286,12031795,3270065,1250882,108700891,2874127,684736,33757175,19951656,47761980,2055080,28901790,16570613,4115771,5675356,12894865,135031164,4627926,3204897,169270617,3242173,6667147,28674757,91077287,38518241,10642836,3942491,798094,22276056,8860588,199579,27601038,12267493,10150265,6144562,4553009,5447502,2009245,9118773,43997828,40448191,20378239,42292929,1133066,9031088,7554661,19314747,23174294,38139640,65068149,5701579,1056608,10276158,71158647,29170398,60776238,301139947,3447496,26084662,85262356,4018332,22211743,11746035,12311143],[779.4453145,1601.056136,2449.008185,3520.610273,5911.315053,10039.59564,6137.076492,9867.084765,684.2441716,8343.105127,1062.7522,2677.326347,973.5331948,851.2411407,2108.944355,2444.286648,543.2552413,339.2964587,368.4692856,1172.667655,11367.16112,1071.310713,1178.665927,3939.978789,400.448611,2144.115096,1102.990936,780.5423257,2125.621418,2627.009471,1388.594732,3119.23652,5586.53878,6876.14025,9692.385245,2669.529475,1397.717137,3522.110717,1418.822445,3048.3029,375.6431231,328.9405571,362.1462796,6424.519071,7029.809327,4293.476475,485.2306591,7144.114393,911.2989371,3530.690067,2428.237769,510.1964923,299.850319,1840.366939,2194.926204,3054.421209,5263.673816,7267.688428,546.5657493,749.6816546,3035.326002,4129.766056,5210.280328,4086.522128,4931.404155,2898.530881,3216.956347,1546.907807,853.540919,1088.277758,1030.592226,108382.3529,4834.804067,298.8462121,575.5729961,2387.54806,1443.011715,369.1650802,1831.132894,452.3369807,743.1159097,1967.955707,3478.125529,786.5668575,2647.585601,1688.20357,468.5260381,331,2423.780443,545.8657229,8941.571858,10556.57566,3112.363948,761.879376,1077.281856,10095.42172,1828.230307,684.5971438,2480.380334,1952.308701,3758.523437,1272.880995,4029.329699,3068.319867,3081.959785,2718.885295,3144.613186,493.3238752,879.5835855,6459.554823,1450.356983,3581.459448,879.7877358,2315.138227,5074.659104,4215.041741,1135.749842,4725.295531,3834.034742,1083.53203,1615.991129,1148.376626,8527.844662,14734.23275,1643.485354,1206.947913,716.6500721,757.7974177,859.8086567,3023.271928,1468.475631,1969.10098,734.753484,9979.508487,13990.48208,5716.766744,7689.799761,605.0664917,1515.592329,781.7175761,1147.388831,406.8841148,820.8530296,1942.284244,3013.976023,3827.940465,6856.856212,10949.64959,8842.59803,11635.79945,661.6374577,9714.960623,959.6010805,2127.686326,1353.989176,918.2325349,2487.365989,3008.670727,617.1834648,379.5646281,434.0383364,1313.048099,12489.95006,1190.844328,1308.495577,4315.622723,575.9870009,2323.805581,1211.148548,905.8602303,2315.056572,2990.010802,1500.895925,4338.231617,6092.174359,8256.343918,11099.65935,2864.969076,1544.402995,3780.546651,1458.915272,3421.523218,426.0964081,344.1618859,378.9041632,7545.415386,8662.834898,4976.198099,520.9267111,10187.82665,1043.561537,4916.299889,2617.155967,576.2670245,431.7904566,1726.887882,2220.487682,3629.076457,6040.180011,9244.001412,590.061996,858.9002707,3290.257643,6229.333562,5599.077872,5385.278451,6248.656232,4756.525781,4317.694365,1886.080591,944.4383152,1571.134655,1487.593537,113523.1329,6089.786934,335.9971151,620.9699901,3448.284395,1589.20275,416.3698064,1810.066992,490.3821867,846.1202613,2034.037981,4131.546641,912.6626085,3682.259903,1642.002314,495.5868333,350,2621.448058,597.9363558,11276.19344,12247.39532,3457.415947,835.5234025,1100.592563,11653.97304,2242.746551,747.0835292,2961.800905,2046.154706,4245.256698,1547.944844,4734.253019,3774.571743,3907.156189,2769.451844,3943.370225,540.2893983,860.7369026,8157.591248,1567.653006,4981.090891,1004.484437,2843.104409,6093.26298,5862.276629,1258.147413,5487.104219,4564.80241,1072.546602,1770.337074,1244.708364,9911.878226,17909.48973,2117.234893,1507.86129,698.5356073,793.5774148,925.9083202,4100.3934,1395.232468,2218.754257,774.3710692,11283.17795,14847.12712,6150.772969,9802.466526,676.2854478,1827.067742,804.8304547,1311.956766,518.7642681,853.10071,2312.888958,2550.81688,4269.276742,7133.166023,12217.22686,10750.72111,12753.27514,686.3415538,10991.20676,949.4990641,2180.972546,1709.683679,983.6539764,3336.585802,4254.337839,722.5120206,355.2032273,496.9136476,1399.607441,13462.48555,1193.068753,1389.817618,4519.094331,487.6740183,2492.351109,1406.648278,896.3146335,2464.783157,3460.937025,1728.869428,5477.890018,5180.75591,10136.86713,13583.31351,3020.989263,1662.137359,4086.114078,1693.335853,3776.803627,582.8419714,380.9958433,419.4564161,9371.842561,10560.48553,6631.459222,599.650276,12902.46291,1190.041118,6017.190733,2750.364446,686.3736739,522.0343725,1796.589032,2291.156835,4692.648272,7550.359877,10350.15906,658.3471509,849.2897701,4187.329802,8341.737815,6631.597314,7105.630706,8243.58234,5246.107524,6576.649461,2348.009158,896.9663732,1621.693598,1536.344387,95458.11176,5714.560611,411.8006266,634.1951625,6757.030816,1643.38711,427.9010856,2036.884944,496.1743428,1055.896036,2529.067487,4581.609385,1056.353958,4649.593785,1566.353493,556.6863539,388,3173.215595,652.3968593,12790.84956,13175.678,3634.364406,997.7661127,1150.927478,13450.40151,2924.638113,803.3427418,3536.540301,2148.027146,4957.037982,1649.552153,5338.752143,4727.954889,5108.34463,3173.72334,4734.997586,597.4730727,1071.551119,11626.41975,1654.988723,6289.629157,1116.639877,3674.735572,7481.107598,7402.303395,1369.488336,5768.729717,5693.843879,1074.47196,1959.593767,1856.182125,12329.44192,20431.0927,2193.037133,1822.879028,722.0038073,1002.199172,1067.53481,4997.523971,1660.30321,2322.869908,767.2717398,12477.17707,16173.14586,5603.357717,8422.974165,772.0491602,2198.956312,825.6232006,1452.725766,527.2721818,836.1971382,2760.196931,3246.991771,5522.776375,8052.953021,14526.12465,12834.6024,14804.6727,721.1860862,13149.04119,1035.831411,2586.886053,2172.352423,1214.709294,3429.864357,5577.0028,794.8265597,412.9775136,523.4323142,1508.453148,16076.58803,1136.056615,1196.810565,5106.654313,612.7056934,2678.729839,1876.029643,861.5932424,2677.939642,4161.727834,2052.050473,6960.297861,5690.268015,11399.44489,15937.21123,3020.050513,1653.723003,4579.074215,1814.880728,4358.595393,915.5960025,468.7949699,516.1186438,10921.63626,12999.91766,8358.761987,734.7829124,14745.62561,1125.69716,8513.097016,3242.531147,708.7595409,715.5806402,1452.057666,2538.269358,6197.962814,9326.64467,13319.89568,700.7706107,762.4317721,5906.731805,8931.459811,7655.568963,8393.741404,10022.40131,6124.703451,9847.788607,2741.796252,1056.736457,2143.540609,2029.228142,80894.88326,6006.983042,498.6390265,713.6036483,18772.75169,1634.047282,495.5147806,2277.742396,545.0098873,1421.145193,2475.387562,5754.733883,1226.04113,5907.850937,1711.04477,566.6691539,349,3793.694753,676.4422254,15363.25136,14463.91893,4643.393534,1054.384891,1014.514104,16361.87647,4720.942687,942.4082588,4421.009084,2299.376311,5788.09333,1814.12743,6557.152776,6361.517993,6929.277714,4021.175739,6470.866545,510.9637142,1384.840593,16903.04886,1612.404632,7991.707066,1206.043465,4977.41854,8412.902397,9405.489397,1284.73318,7114.477971,7993.512294,1135.514326,1687.997641,2613.101665,15258.29697,22966.14432,1881.923632,2643.858681,848.2186575,1295.46066,1477.59676,5621.368472,1932.360167,2826.356387,908.9185217,14142.85089,19530.36557,5444.61962,9541.474188,637.1232887,2649.715007,862.4421463,1777.077318,569.7950712,739.9811058,3313.422188,4182.663766,5473.288005,9443.038526,16788.62948,16661.6256,18268.65839,630.2336265,16672.14356,1085.796879,2980.331339,2860.16975,2263.611114,4985.711467,6597.494398,854.7359763,464.0995039,421.6240257,1684.146528,18970.57086,1070.013275,1104.103987,5494.024437,676.9000921,3264.660041,1937.577675,904.8960685,3213.152683,5118.146939,2378.201111,9164.090127,5305.445256,13108.4536,18866.20721,3694.212352,2189.874499,5280.99471,2024.008147,4520.246008,672.4122571,514.3242082,566.2439442,14358.8759,16107.19171,11401.94841,756.0868363,18016.18027,1178.223708,12724.82957,4031.408271,741.6662307,820.2245876,1654.456946,2529.842345,8315.928145,10168.65611,15798.06362,724.032527,1111.107907,9613.818607,9576.037596,9530.772896,12786.93223,12269.27378,7433.889293,14778.78636,2110.856309,1222.359968,3701.621503,3030.87665,109347.867,7486.384341,496.5815922,803.0054535,21011.49721,1748.562982,584.6219709,2849.09478,581.3688761,1586.851781,2575.484158,6809.40669,1421.741975,7778.414017,1930.194975,724.9178037,357,3746.080948,674.7881296,18794.74567,16046.03728,4688.593267,954.2092363,1698.388838,18965.05551,10618.03855,1049.938981,5364.249663,2523.337977,5937.827283,1989.37407,8006.506993,9022.247417,9123.041742,5047.658563,8011.414402,590.5806638,1532.985254,24837.42865,1597.712056,10522.06749,1353.759762,8597.756202,9674.167626,12383.4862,1254.576127,7765.962636,10638.75131,1213.39553,1659.652775,3364.836625,17832.02464,27195.11304,2571.423014,4062.523897,915.9850592,1524.358936,1649.660188,6619.551419,2753.285994,3450.69638,950.735869,15895.11641,21806.03594,5703.408898,10505.25966,699.5016441,3133.409277,1265.047031,1773.498265,799.3621758,786.11336,3533.00391,4910.416756,3008.647355,10079.02674,18334.19751,19749.4223,19340.10196,659.8772322,19117.97448,1029.161251,3548.097832,3528.481305,3214.857818,6660.118654,7612.240438,743.3870368,556.1032651,524.9721832,1783.432873,22090.88306,1109.374338,1133.98495,4756.763836,741.2374699,3815.80787,1172.603047,795.757282,3259.178978,5926.876967,2517.736547,11305.38517,6380.494966,14800.16062,20422.9015,3081.761022,2681.9889,6679.62326,2785.493582,5138.922374,958.5668124,505.7538077,556.8083834,15605.42283,18292.63514,21745.57328,884.7552507,20512.92123,993.2239571,14195.52428,4879.992748,874.6858643,764.7259628,1874.298931,3203.208066,11186.14125,11674.83737,19654.96247,813.337323,1382.702056,11888.59508,14688.23507,11150.98113,13306.61921,14255.98475,6650.195573,16610.37701,2852.351568,1267.613204,4106.301249,4657.22102,59265.47714,8659.696836,745.3695408,640.3224383,21951.21176,1544.228586,663.2236766,3827.921571,686.3952693,1497.492223,3710.982963,7674.929108,1647.511665,9595.929905,2370.619976,502.3197334,371,3876.485958,694.1124398,21209.0592,16233.7177,5486.371089,808.8970728,1981.951806,23311.34939,11848.34392,1175.921193,5351.912144,3248.373311,6281.290855,2373.204287,9508.141454,10172.48572,9770.524921,4319.804067,9356.39724,670.0806011,1737.561657,34167.7626,1561.769116,12980.66956,1348.285159,11210.08948,10922.66404,15277.03017,1450.992513,8028.651439,13236.92117,1348.775651,2202.988423,3781.410618,18855.72521,26982.29052,3195.484582,5596.519826,962.4922932,1961.224635,1532.776998,7899.554209,3120.876811,4269.122326,843.7331372,17428.74846,24072.63213,6504.339663,13143.95095,713.5371196,3682.831494,1829.765177,1588.688299,685.5876821,978.0114388,3630.880722,5745.160213,2756.953672,8997.897412,19477.00928,21597.08362,19211.14731,676.9818656,20979.84589,1277.897616,3156.510452,4126.613157,4551.14215,7030.835878,8224.191647,807.1985855,559.603231,624.4754784,2367.983282,22898.79214,956.7529907,797.9081006,5095.665738,962.4213805,4397.575659,1267.100083,673.7478181,4879.507522,5262.734751,2602.710169,13221.82184,7316.918107,15377.22855,21688.04048,2879.468067,2861.092386,7213.791267,3503.729636,4098.344175,927.8253427,524.8758493,577.8607471,18533.15761,20293.89746,15113.36194,835.8096108,22031.53274,876.032569,15268.42089,4820.49479,857.2503577,838.1239671,2011.159549,3121.760794,14560.53051,12545.99066,23269.6075,855.7235377,1516.872988,7608.334602,14517.90711,12618.32141,15367.0292,16537.4835,6068.05135,19384.10571,4161.415959,1348.225791,4106.525293,5622.942464,31354.03573,7640.519521,797.2631074,572.1995694,17364.27538,1302.878658,632.8039209,4920.355951,618.0140641,1481.150189,3688.037739,9611.147541,2000.603139,11222.58762,2702.620356,462.2114149,424,4191.100511,718.3730947,21399.46046,17632.4104,3470.338156,909.7221354,1576.97375,26298.63531,12954.79101,1443.429832,7009.601598,4258.503604,6434.501797,2603.273765,8451.531004,11753.84291,10330.98915,5267.219353,9605.314053,881.5706467,1890.218117,33693.17525,1518.479984,15181.0927,1465.010784,15169.16112,11348.54585,17866.72175,1176.807031,8568.266228,13926.16997,1648.079789,1895.544073,3895.384018,20667.38125,28397.71512,3761.837715,7426.354774,874.2426069,2393.219781,1344.577953,9119.528607,3560.233174,4241.356344,682.2662268,18232.42452,25009.55914,6920.223051,11152.41011,707.2357863,4336.032082,1977.55701,1408.678565,788.8550411,852.3959448,3738.932735,5681.358539,2430.208311,9139.671389,21888.88903,23687.82607,18524.02406,751.9794035,22525.56308,1225.85601,2753.69149,4314.114757,6205.88385,7807.095818,8239.854824,912.0631417,621.8188189,683.8955732,2602.664206,26626.51503,844.8763504,952.386129,5547.063754,1378.904018,4903.2191,1315.980812,672.774812,4201.194937,5629.915318,2156.956069,13822.58394,7532.924763,16310.4434,25116.17581,2880.102568,2899.842175,6481.776993,3885.46071,4140.442097,966.8968149,521.1341333,573.7413142,21141.01223,22066.44214,11864.40844,611.6588611,24639.18566,847.0061135,16120.52839,4246.485974,805.5724718,736.4153921,1823.015995,3023.096699,20038.47269,12986.47998,26923.20628,976.5126756,1748.356961,6642.881371,11643.57268,13872.86652,17122.47986,19207.23482,6351.237495,22375.94189,4448.679912,1361.936856,4106.492315,8533.088805,28118.42998,5377.091329,773.9932141,506.1138573,11770.5898,1155.441948,635.5173634,5249.802653,684.1715576,1421.603576,4783.586903,8688.156003,2338.008304,11732.51017,2755.046991,389.8761846,385,3693.731337,775.6324501,23651.32361,19007.19129,2955.984375,668.3000228,1385.029563,31540.9748,18115.22313,1704.686583,7034.779161,3998.875695,6360.943444,2189.634995,9082.351172,13039.30876,12281.34191,5303.377488,9696.273295,847.991217,1516.525457,21198.26136,1441.72072,15870.87851,1294.447788,18861.53081,12037.26758,18678.53492,1093.244963,7825.823398,15764.98313,1876.766827,1507.819159,3984.839812,23586.92927,30281.70459,3116.774285,11054.56175,831.8220794,2982.653773,1202.201361,7388.597823,3810.419296,5089.043686,617.7244065,21664.78767,29884.35041,7452.398969,9883.584648,820.7994449,5107.197384,1971.741538,1213.315116,706.1573059,649.3413952,2497.437901,5023.216647,2627.845685,9308.41871,23424.76683,27042.01868,19035.57917,837.8101643,25575.57069,1191.207681,2961.699694,2546.781445,7954.111645,6950.283021,6302.623438,931.7527731,631.6998778,682.3031755,1793.163278,26342.88426,747.9055252,1058.0643,7596.125964,1655.784158,5444.648617,1246.90737,457.7191807,4016.239529,6160.416317,1648.073791,8447.794873,5592.843963,14297.02122,26406.73985,2377.156192,3044.214214,7103.702595,3794.755195,4444.2317,1132.055034,582.8585102,421.3534653,20647.16499,24703.79615,13522.15752,665.6244126,26505.30317,925.060154,17541.49634,4439.45084,794.3484384,745.5398706,1456.309517,3081.694603,24757.60301,10535.62855,25144.39201,1164.406809,2383.140898,7235.653188,3745.640687,17558.81555,18051.52254,22013.64486,7404.923685,26824.89511,3431.593647,1341.921721,3726.063507,12104.27872,34932.91959,6890.806854,977.4862725,636.6229191,9640.138501,1040.67619,563.2000145,7277.912802,739.014375,1361.369784,6058.253846,9472.384295,1785.402016,7003.339037,2948.047252,410.8968239,347,3804.537999,897.7403604,26790.94961,18363.32494,2170.151724,581.182725,1619.848217,33965.66115,18616.70691,1971.829464,6618.74305,4196.411078,4446.380924,2279.324017,7738.881247,16207.26663,14641.58711,6101.255823,6598.409903,737.0685949,1428.777814,24841.61777,1367.899369,9325.068238,1068.696278,24769.8912,9498.467723,14214.71681,926.9602964,7225.069258,18603.06452,2153.739222,1492.197043,3553.0224,23880.01683,31871.5303,3340.542768,15215.6579,825.682454,4616.896545,1034.298904,7370.990932,4332.720164,5678.348271,644.1707969,22705.09254,32003.93224,8137.004775,10733.92631,989.0231487,6017.654756,1879.496673,1210.884633,693.4207856,635.341351,3193.054604,4797.295051,2277.140884,10967.28195,26997.93657,29095.92066,20292.01679,972.7700352,27561.19663,1232.975292,3326.143191,4766.355904,8647.142313,7957.980824,5970.38876,946.2949618,463.1151478,734.28517,1694.337469,28954.92589,740.5063317,1004.961353,10118.05318,2289.234136,6117.361746,1173.618235,312.188423,3484.164376,6677.045314,1786.265407,9875.604515,5431.990415,16048.51424,29804.34567,1895.016984,3614.101285,7429.455877,4173.181797,5154.825496,2814.480755,913.47079,515.8894013,23723.9502,25889.78487,14722.84188,653.7301704,27788.88416,1005.245812,18747.69814,4684.313807,869.4497668,796.6644681,1341.726931,3160.454906,28377.63219,11712.7768,28061.09966,1458.817442,3119.335603,8263.590301,3076.239795,24521.94713,20896.60924,24675.02446,7121.924704,28816.58499,3645.379572,1360.485021,1690.756814,15993.52796,40300.61996,8754.96385,1186.147994,609.1739508,9467.446056,986.2958956,692.2758103,10132.90964,790.2579846,1483.136136,7425.705295,9767.29753,1902.2521,6465.613349,2982.101858,472.3460771,415,3899.52426,1010.892138,30246.13063,21050.41377,2253.023004,580.3052092,1624.941275,41283.16433,19702.05581,2049.350521,7113.692252,4247.400261,5838.347657,2536.534925,10159.58368,17641.03156,16999.4333,6071.941411,7346.547557,589.9445051,1339.076036,20586.69019,1392.368347,7914.320304,574.6481576,33519.4766,12126.23065,17161.10735,930.5964284,7479.188244,20445.29896,2664.477257,1632.210764,3876.76846,25266.59499,32135.32301,4014.238972,20206.82098,789.1862231,5852.625497,982.2869243,8792.573126,4876.798614,6601.429915,816.559081,26074.53136,35767.43303,9230.240708,10165.49518,1385.896769,7110.667619,2117.484526,1071.353818,792.4499603,726.7340548,4604.211737,5288.040382,2773.287312,8797.640716,30687.75473,32417.60769,23403.55927,1136.39043,30485.88375,1372.877931,3413.26269,6018.975239,11003.60508,8131.212843,7696.777725,1037.645221,446.4035126,896.2260153,1934.011449,33328.96507,738.6906068,1156.18186,10778.78385,3119.280896,5755.259962,1075.811558,241.1658765,3484.06197,7723.447195,1648.800823,11628.38895,6340.646683,17596.21022,32166.50006,1908.260867,4563.808154,5773.044512,4754.604414,5351.568666,7703.4959,765.3500015,530.0535319,28204.59057,28926.03234,12521.71392,660.5855997,30035.80198,1111.984578,22514.2548,4858.347495,945.5835837,575.7047176,1270.364932,3099.72866,30209.01516,14843.93556,31163.20196,1746.769454,2873.91287,9240.761975,4390.717312,34077.04939,21905.59514,27968.09817,6994.774861,28604.5919,3844.917194,1287.514732,1646.758151,19233.98818,35110.10566,9313.93883,1275.184575,531.4823679,9534.677467,894.6370822,665.4231186,10206.97794,951.4097518,1579.019543,9021.815894,10742.44053,2140.739323,6557.194282,3258.495584,633.6179466,611,4072.324751,1057.206311,33724.75778,23189.80135,2474.548819,601.0745012,1615.286395,44683.97525,19774.83687,2092.712441,7356.031934,3783.674243,5909.020073,2650.921068,12002.23908,19970.90787,18855.60618,6316.1652,7885.360081,785.6537648,1353.09239,19014.54118,1519.635262,7236.075251,699.489713,36023.1054,13638.77837,20660.01936,882.0818218,7710.946444,24835.47166,3015.378833,1993.398314,4128.116943,29341.63093,34480.95771,4090.925331,23235.42329,899.0742111,5913.187529,886.2205765,11460.60023,5722.895655,6508.085718,927.7210018,29478.99919,39097.09955,7727.002004,8605.047831,1764.456677,4515.487575,2234.820827,1071.613938,672.0386227,974.5803384,5937.029526,6223.367465,4797.231267,12779.37964,34435.36744,36126.4927,29796.04834,1391.253792,33692.60508,1441.284873,3822.137084,7446.298803,12569.85177,9065.800825,10680.79282,1217.032994,430.0706916,1713.778686,2042.09524,36319.23501,706.016537,1704.063724,13171.63885,4959.114854,7006.580419,986.1478792,277.5518587,3632.557798,9645.06142,1544.750112,14619.22272,8948.102923,22833.30851,35278.41874,2082.481567,6025.374752,6873.262326,5581.180998,5728.353514,12154.08975,641.3695236,690.8055759,33207.0844,30470.0167,13206.48452,752.7497265,32170.37442,1327.60891,27538.41188,5186.050003,942.6542111,579.231743,1201.637154,3548.330846,39724.97867,18008.94444,36180.78919,2452.210407,3540.651564,11605.71449,4471.061906,40675.99635,25523.2771,28569.7197,7320.880262,31656.06806,4519.461171,1463.249282,1593.06548,23348.13973,47306.98978,10461.05868,1569.331442,414.5073415,12057.49928,1044.770126,759.3499101,12451.6558,1042.581557,1803.151496,10956.99112,11977.57496,3095.772271,9253.896111,3820.17523,823.6856205,944,4811.060429,1091.359778,36797.93332,25185.00911,2749.320965,619.6768924,2013.977305,49357.19017,22316.19287,2605.94758,9809.185636,4172.838464,7408.905561,3190.481016,15389.92468,20509.64777,19328.70901,7670.122558,10808.47561,863.0884639,1598.435089,21654.83194,1712.472136,9786.534714,862.5407561,47143.17964,18678.31435,25768.25759,926.1410683,9269.657808,28821.0637,3970.095407,2602.394995,4513.480643,33859.74835,37506.41907,4184.548089,28718.27684,1107.482182,7458.396327,882.9699438,18008.50924,7092.923025,8458.276384,1056.380121,33203.26128,42951.65309,10611.46299,11415.80569,2441.576404,3025.349798,2280.769906,1271.211593,469.7092981],[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,815601,193808,991331,329266,1733582,1021357,38088,18208,4478609,258706,186858,328423,285000,32331,8948611,376354,243437,221900,628700,350856,2224570,100589,212393,670807,81144473,2135222,16992,1477927,85573,185983,322981,109013,632955,388575,153831,8702,431840,509632,2786432,312940,15958,103851,1954673,233500,1851196,14202,38830,1873117,810287,362968,494495,212477,20442,306213,252937,610400,335000,17148,37000000,8072000,2520000,806877,-73936,323487,1516000,108995,5103984,138645,990733,545893,1663981,52846,207883,64591,112642,181849,418767,303436,990857,403716,54296,93260,4871231,81471,28995,1467133,591719,1638848,62249,499802,644395,234613,193038,312716,4054244,164210,54144,5333384,123426,215026,1120400,3633503,2504795,291600,33000,51000,1199327,287155,1314,413973,298958,410988,152429,318929,286140,43552,253421,1886614,1291744,1146204,1248725,36498,239129,311000,488359,1613853,1129901,3752515,138332,102050,303114,3435262,850704,1000000,14431000,171994,1263100,2751704,39854,534261,344000,565433,1841750,445440,1721423,593920,3406827,2103756,202092,51416,9952430,487995,413580,710603,558000,70456,19436830,738046,449653,516297,1389783,784566,4200265,231783,467955,1583639,109506473,4659114,37753,3386429,193039,418870,855389,194328,1246576,495099,312899,26749,962088,1132954,5950000,704822,32256,227858,4284431,400943,4664333,34959,89700,4593165,1774247,714983,1062477,475754,47167,678642,572709,1179300,559000,34091,82000000,16976000,5602000,1798494,-122156,689990,3177200,239033,9372732,325645,2214511,2052006,5472736,198266,447319,144396,249488,422134,940412,710806,2158007,852204,124201,184460,10977168,209617,60694,3117387,1342628,3541440,135561,1149521,1423701,493756,424807,696540,8752255,311191,120331,11754111,275645,453937,2490800,7886573,4599066,493750,221046,101200,2050721,516315,5334,937352,674654,755913,324646,623200,679247,93444,553159,4091722,2608191,2439594,2678560,79763,436915,851000,1173072,3368576,2541033,7973995,308985,224648,638817,7553018,1864000,2862000,28985000,345501,2703807,7549301,102549,1156252,749000,1196829,3112633,701363,3480974,1015374,5057269,3181052,449226,81735,15935025,826095,689019,1157350,794000,111233,31447263,1035326,657956,885371,2266231,1326439,6034183,441943,813505,2481289,198286473,7413256,63442,5841068,324875,662400,1767851,292137,2131535,709926,504800,64468,1557800,1883671,9457879,1190062,42900,381559,6999356,515244,7109333,68302,155273,7222501,2909212,983191,1544392,787169,20634,1116649,983236,1596900,719422,50714,134000000,27291000,9266000,3077516,-52056,1072671,5001100,435001,14366254,647144,3727466,3751521,9183429,415003,747365,247633,416098,739495,1571644,1229450,3406500,1374248,207986,272753,17851242,348837,87201,4831079,2234593,5777275,220809,2079154,2214834,733356,699700,1154594,14168656,458291,206942,19295339,465406,732109,4106500,12917909,6054827,576950,421961,156324,2654814,916152,10776,1612521,1210252,1111075,518941,850600,884101,157394,901845,6732386,4300405,3755054,4211462,130447,743258,1248000,2019263,5098330,4284387,12734847,516437,297305,1139251,11175640,3075497,4529000,41159000,495614,4269984,13217071,112051,1776956,1228000,1914525,4654127,980857,5481262,1662763,6902843,4485788,616429,110353,23872436,978695,1023092,1682557,1028000,177043,44237498,1301300,963907,1084365,2756770,2011961,7498916,635565,1216606,3339905,305766473,10192119,96091,8907664,485573,908479,3094677,343081,2823551,736975,657596,115699,2179983,2749898,12584108,1748038,60639,821427,9909431,549157,9272333,117275,232781,9571136,3773119,1155378,2003200,1147138,44708,1496813,1447693,1989800,890091,61313,195000000,39230000,13342000,4619740,72244,1474979,6699564,571521,20729248,1005637,5580739,5915753,12557429,681934,1240489,368032,619320,1164148,2319518,1813195,4693084,1989990,310230,334778,25839977,519837,113844,6721453,3363280,8373394,335951,3230057,2947886,934306,1017118,1680794,20620989,605276,321217,27979361,676304,1058228,5929000,18411450,7308994,444400,620132,203933,4032648,1457194,16584,2467079,1833107,1453141,735764,1025400,1035296,204992,1313167,9670875,5963291,5034391,6092352,189862,997620,1586400,3039623,6675677,6383668,17986751,837238,312349,1655772,15257276,4365488,5649000,52343000,576561,6076081,18408175,58987,2443246,1834497,2780228,6455039,1226351,7873279,1930580,9106872,5382888,640658,176963,33541447,1091395,1429952,2196401,1295000,339164,57711391,1522122,1419595,1388797,2284771,2950798,9010816,875838,1705798,4222174,387191473,12743641,150803,12380865,681884,1182140,4482555,436444,3530191,1036732,754419,165545,2811454,3730113,16560554,2239721,-24289,1073882,13756858,648402,10705352,285665,323954,9014821,4957092,1575229,2557049,1562777,164575,1707066,1537782,2457800,1133171,73861,262000000,54673000,18208679,6441150,319744,1875004,8393245,730719,27413448,1329738,8036358,7459832,15488429,980357,1676258,502777,840309,1702054,3244254,2719444,6097003,2653481,434132,396469,33615659,727337,146239,8457724,4681552,11435091,491195,4750662,3471001,1170106,1388808,2302618,29090077,715477,496700,36806126,899702,1428618,7964399,24412271,8890703,1136550,853828,234395,5028597,2122145,26785,4122828,2505266,1826220,997648,1198300,1269666,257401,1826672,12864997,7889130,6134494,8600319,261182,1126975,1501424,4270954,8234834,8806640,22858883,1089469,376159,2357326,20168356,5632961,5749000,62686000,620555,8063995,24286667,230506,3440161,2544550,3561200,4456483,1497400,10754228,2784289,11464418,6492988,646841,257520,46187547,1125898,1903288,2758909,1381693,528039,72360379,1617198,2164617,2134792,2578649,4241764,10416316,1185276,2192656,5109493,444017473,15413873,194707,16546490,919850,1498050,6048932,531139,3781427,1178521,783810,242842,3477003,4817097,23458502,2432008,68519,1198537,17250815,736433,11973898,333172,431203,9189314,5819337,2053230,3249249,2046248,245334,1996911,2151995,3138600,1201535,86035,336000000,71291000,25800751,8731552,527844,2237507,8869636,872214,31995949,1739117,11197406,8782030,18378429,1337494,1647347,663060,1093567,2324345,4408565,3585023,7693538,3160088,599580,475484,41496587,955369,148714,10259513,6140907,14587446,613179,6613778,3928413,1215856,1813633,3057720,39920280,787059,793215,50115528,1096225,1810563,10099429,31018083,10496830,1333600,1052001,260110,5726726,2972638,38582,7248995,3392194,2172677,1321273,1524869,1489906,371734,3301898,16875094,9433440,7427809,11862386,359658,1200587,1653126,5748945,9951028,11521457,27537758,1425652,453629,3086363,25093114,7114603,5909704,74634835,701032,10181198,29895342,395291,4693789,3428407,4555617,5442624,1792624,13975431,3642135,13743962,7566037,651131,334165,56877382,1139795,2505473,3273054,1547977,708876,86335516,1697058,3116572,2680405,3677955,5771600,11764116,1548314,2816493,6085735,527771473,18613474,241178,21381640,1209210,1873494,7784079,602081,4232042,1186414,793024,247876,4163951,5996405,30575753,2799329,124280,1477199,22138589,841229,13170433,459695,564086,8572346,8587100,2241240,4180025,2986013,346871,2554715,2854750,3458610,1108740,96714,416000000,87224000,34617696,11101423,587744,2582234,9063703,900511,35632300,2212128,14734036,10202066,20674429,1731487,1649824,850453,1406106,2780116,5805730,4906945,9583407,3795840,818684,526107,49978175,1214470,155639,13048180,6445636,17935582,792353,8734644,4283290,1322372,2178563,3953170,48432424,858419,1086049,63840321,1313559,2330636,12170224,37579097,12010159,1389239,1217468,304335,6056371,3814438,50801,10614068,4415758,2370636,1725656,1667552,1641181,456352,4394864,21668444,10330832,8512962,16221293,489105,1296730,1834942,7581298,11207437,14717705,31620940,1935151,528486,4077241,30645651,9458253,6551620,85250533,792188,12470614,36579652,660625,6255511,4600406,6135511,7892588,2043801,17018848,4503893,16081991,8790765,987197,409044,66817720,1315217,3243356,4010136,1465013,900306,99373414,1383606,4408324,3363618,5456258,7458104,13737918,1973429,3746955,7195375,608706473,21851950,300493,27572138,1554188,2246899,9795577,611784,4715463,1190519,837393,321007,4859835,7199641,37178889,3231784,170874,2229680,31227618,950539,14914512,565037,741064,11451812,10697737,2592179,5340568,4326325,470285,3125194,3559894,3703796,844684,111050,500000000,102764000,43125973,12420139,605605,3315636,9174847,952523,37870244,3259495,18556493,11845887,22857879,1258095,1780465,1054448,1049666,3344772,7447483,7096447,11571124,4578047,1096909,579646,57966713,1512139,207787,15859022,6714415,20453542,1068422,11143673,4792256,1442880,2852149,5013350,60245148,958629,1407375,78718444,1544917,2928069,14404749,44747075,12640146,1401630,1358176,364491,6167027,4755276,65900,12940180,5552331,2966250,2117635,2108865,1744751,509692,3572805,25699224,10999568,9604718,19722921,672101,1594194,2180447,9557513,12136556,18282548,35377693,2528440,520819,4875342,35943467,12427393,7436349,99341189,896297,14825995,43693889,1074194,8404168,5709163,7623433,13802082,2145341,19792490,5642929,18326507,9874031,1142104,478114,76428429,1469382,4327765,4809873,816000,1094228,111944159,791157,5882864,3675992,7089126,9186742,15520259,2404818,4879549,8222310,673811473,25307059,374046,33698981,1946062,2591790,11648948,562366,4975210,1175524,949663,354759,5501011,8363066,43910982,3740574,223007,2619559,39000360,1043906,16163761,705487,951447,12865121,12837287,2769122,6657494,5384585,613055,3712057,4350504,4370018,740684,123230,587000000,117226000,46055987,15333937,715077,3910473,9813469,1105216,39497474,3918321,21799781,12719617,25226245,1605345,1990859,1234076,1337417,3739941,9402202,7502189,13727713,5546816,1422185,633262,65750829,1694140,278817,18590284,10157018,23154871,1288935,13818577,5222476,1681393,3443782,6286784,73088743,1077944,1775802,94218274,1794451,3598247,16722422,52574297,12924406,1630365,1532430,427110,5932458,4677656,85597,17224082,6779725,3476447,2434963,2675309,1824873,522094,4106520,28570070,11305572,10716313,23656062,764243,1772946,2378761,11419467,13078243,22363964,38927275,3101777,475251,5583934,40811970,15385457,8378266,115358760,1009873,16934830,49802157,1795461,10862668,6745789,8324041,16843072,2225815,22007617,6634011,20454165,10855580,1220540,535950,88769931,1581565,5287798,5561819,1374416,1188039,123311652,386899,7781230,4575460,8232871,10920921,17116684,2756318,6153277,9119427,724136473,28657456,460446,41279847,2473910,2908617,13275707,598791,5219202,1131112,1040693,384267,6158976,9372481,51089250,4310816,278663,2976105,47085856,1102539,17465368,878602,1173446,13204719,14969750,2870613,8032269,6143569,751806,4406163,5159875,4636576,579313,140068,662172547,129008000,49635826,18560050,926999,4408615,10260999,1238564,40606816,4699556,24922796,13349877,27021579,1951561,2238251,1298025,1951343,4348856,11710565,8906693,15913987,6742008,1806302,683650,72335610,1873571,306396,21228566,12027464,25505085,1486322,16691381,5740842,1913243,3981058,7761187,86782178,1207863,2205629,112056964,2050795,4328615,18743736,60556397,12895425,1907817,1632606,486281,5774337,5317474,110361,20495853,8114448,3251412,3215843,3070776,1851915,521979,5226316,30168687,11602647,11594441,28585631,840026,1829502,2546757,13494265,13903877,26270854,41517346,3758265,438982,6122840,45073251,18915072,9482431,130122526,1110120,18848102,54661308,2358993,13737428,7923811,8845656,23464590,2317826,24053691,8188381,22424971,11742964,1272011,588126,103561480,1661821,6339999,6235837,1761198,1196823,133408087,47958,9856224,5944887,9438022,12687226,18604557,3077343,7556345,9907122,762419569,31876779,557024,50506754,2945725,3207567,15036390,611083,5409190,1103561,1134120,433225,6828276,10206927,58041234,4896823,334237,3467825,55650946,1147960,18624249,1034165,1404039,13255044,17292337,2973040,9426547,7283565,891388,5301326,5966310,4854512,452108,153969,738396331,141495000,52181570,22057872,1156930,4805765,10481733,1354037,41008947,5445279,29146131,14436237,28097219,2345559,2481749,1263902,2330634,5017185,14404742,10409277,18072908,8193627,2247509,734326,78556574,2073464,270902,23817958,13505340,27668984,1569249,19719254,6188625,2120977,4509566,9515397,101912068,1300198,2697064,127924057,2302093,5111271,20649057,68638596,12787690,2116786,1715491,540394,5646056,6325661,139568,23595361,9511904,3290118,4001313,3426009,1889365,519727,6591779,29732893,11898321,12395897,33788262,842823,1906415,2739661,15653198,14623932,29816715,43778747,4482466,393758,6628423,48922970,23345601,10346238,143586947,1194531,20645094,59015517,2987747,17247914,9074035,9230236]],"container":"<table class=\"display\">\n  <thead>\n    <tr>\n      <th> <\/th>\n      <th>country<\/th>\n      <th>continent<\/th>\n      <th>year<\/th>\n      <th>lifeExp<\/th>\n      <th>pop<\/th>\n      <th>gdpPercap<\/th>\n      <th>rel_growth<\/th>\n    <\/tr>\n  <\/thead>\n<\/table>","options":{"columnDefs":[{"className":"dt-right","targets":[3,4,5,6,7]},{"orderable":false,"targets":0}],"order":[],"autoWidth":false,"orderClasses":false}},"evals":[],"jsHooks":[]}</script><!--/html_preserve-->


3. Determine the country that experienced the sharpest 5-year drop in life expectancy, in each continent, sorted by the drop, by rearranging the following lines of code. Ensure there are no `NA`'s. Instead of using `lag()`, use the convenience function provided by the `tsibble` package, `tsibble::difference()`:

```
drop_na() %>% 
ungroup() %>% 
arrange(year) %>% 
filter(inc_life_exp == min(inc_life_exp)) %>% 
gapminder %>% 
mutate(inc_life_exp = FILL_THIS_IN) %>% 
arrange(inc_life_exp) %>% 
group_by(country) %>% 
group_by(continent) %>% 
knitr::kable()
```


```r
gapminder %>% 
  group_by(country) %>%
  arrange (year) %>%
  mutate(inc_life_exp = difference (lifeExp)) %>%
  drop_na() %>% 
  ungroup() %>%
  group_by(continent) %>%
  arrange(inc_life_exp) %>% 
  knitr::kable()
```



country                    continent    year    lifeExp          pop     gdpPercap   inc_life_exp
-------------------------  ----------  -----  ---------  -----------  ------------  -------------
Rwanda                     Africa       1992   23.59900      7290203      737.0686      -20.42100
Zimbabwe                   Africa       1997   46.80900     11404948      792.4500      -13.56800
Lesotho                    Africa       2002   44.59300      2046772     1275.1846      -10.96500
Swaziland                  Africa       2002   43.86900      1130269     4128.1169      -10.42000
Botswana                   Africa       1997   52.55600      1536536     8647.1423      -10.18900
Cambodia                   Asia         1977   31.22000      6978607      524.9722       -9.09700
Namibia                    Africa       2002   51.47900      1972153     4072.3248       -7.43000
South Africa               Africa       2002   53.36500     44433622     7710.9464       -6.87100
Zimbabwe                   Africa       2002   39.98900     11926563      672.0386       -6.82000
China                      Asia         1962   44.50136    665770000      487.6740       -6.04760
Botswana                   Africa       2002   46.63400      1630347    11003.6051       -5.92200
Zambia                     Africa       1997   40.23800      9417789     1071.3538       -5.86200
Iraq                       Asia         1992   59.46100     17861905     3745.6407       -5.58300
Liberia                    Africa       1992   40.80200      1912974      636.6229       -5.22500
Cambodia                   Asia         1972   40.31700      7450606      421.6240       -5.09800
Kenya                      Africa       1997   54.40700     28263827     1360.4850       -4.87800
Somalia                    Africa       1992   39.65800      6099799      926.9603       -4.84300
Zambia                     Africa       1992   46.10000      8381163     1210.8846       -4.72100
Swaziland                  Africa       2007   39.61300      1133066     4513.4806       -4.25600
Uganda                     Africa       1997   44.57800     21210254      816.5591       -4.24700
Swaziland                  Africa       1997   54.28900      1054486     3876.7685       -4.18500
Lesotho                    Africa       1997   55.55800      1982823     1186.1480       -4.12700
Cote d'Ivoire              Africa       1997   47.99100     14625967     1786.2654       -4.05300
South Africa               Africa       2007   49.33900     43997828     9269.6578       -4.02600
Gabon                      Africa       2002   56.76100      1299304    12521.7139       -3.70000
Burundi                    Africa       1992   44.73600      5809236      631.6999       -3.47500
Congo, Rep.                Africa       1997   52.96200      2800947     3484.1644       -3.47100
Kenya                      Africa       2002   50.99200     31386842     1287.5147       -3.41500
Central African Republic   Africa       1997   46.06600      3696513      740.5063       -3.33000
Namibia                    Africa       1997   58.90900      1774766     3899.5243       -3.09000
Congo, Dem. Rep.           Africa       1997   42.58700     47798986      312.1884       -2.96100
Central African Republic   Africa       2002   43.30800      4048013      738.6906       -2.75800
Uganda                     Africa       1992   48.82500     18252190      644.1708       -2.68400
Cote d'Ivoire              Africa       1992   52.04400     12772596     1648.0738       -2.61100
Malawi                     Africa       2002   45.00900     11824495      665.4231       -2.48600
Cameroon                   Africa       2002   49.85600     15929988     1934.0114       -2.34300
Mozambique                 Africa       2002   44.02600     18473780      633.6179       -2.31800
Korea, Dem. Rep.           Asia         1997   67.72700     21585105     1690.7568       -2.25100
Rwanda                     Africa       1987   44.02000      6349365      847.9912       -2.19800
Cameroon                   Africa       1997   52.19900     14195809     1694.3375       -2.11500
Lesotho                    Africa       2007   42.59200      2012649     1569.3314       -2.00100
Zimbabwe                   Africa       1992   60.37700     10704340      693.4208       -1.97400
Tanzania                   Africa       1997   48.46600     30686889      789.1862       -1.97400
Mozambique                 Africa       2007   42.08200     19951656      823.6856       -1.94400
Malawi                     Africa       1997   47.49500     10419991      692.2758       -1.92500
Congo, Dem. Rep.           Africa       1992   45.54800     41672143      457.7192       -1.86400
Iraq                       Asia         2002   57.04600     24001816     4390.7173       -1.76500
Sierra Leone               Africa       1992   38.33300      4260884     1068.6963       -1.67300
South Africa               Africa       1997   60.23600     42835005     7479.1882       -1.65200
El Salvador                Americas     1977   56.69600      4282586     5138.9224       -1.51100
Montenegro                 Europe       2002   73.98100       720230     6557.1943       -1.46400
Cote d'Ivoire              Africa       2002   46.83200     16252726     1648.8008       -1.15900
Tanzania                   Africa       1992   50.44000     26605473      825.6825       -1.09500
Central African Republic   Africa       1992   49.39600      3265124      747.9055       -1.08900
Korea, Dem. Rep.           Asia         2002   66.66200     22215365     1646.7582       -1.06500
Chad                       Africa       2002   50.52500      8835739     1156.1819       -1.04800
Zambia                     Africa       2002   39.19300     10595811     1071.6139       -1.04500
Congo, Rep.                Africa       1992   56.43300      2409073     4016.2395       -1.03700
Zambia                     Africa       1987   50.82100      7272406     1213.3151       -1.00000
Gabon                      Africa       1997   60.46100      1126189    14722.8419       -0.90500
Botswana                   Africa       1992   62.74500      1342614     7954.1116       -0.87700
Bulgaria                   Europe       1997   70.32000      8066057     5970.3888       -0.87000
Nigeria                    Africa       2002   46.60800    119901274     1615.2864       -0.85600
Togo                       Africa       2002   57.56100      4977378      886.2206       -0.82900
Puerto Rico                Americas     1992   73.91100      3585176    14641.5871       -0.71900
Cameroon                   Africa       1992   54.31400     12467171     1793.1633       -0.67100
Korea, Dem. Rep.           Asia         1992   69.97800     20711375     3726.0635       -0.66900
Uganda                     Africa       1977   50.35000     11457758      843.7331       -0.66600
Iraq                       Asia         1997   58.81100     20775703     3076.2398       -0.65000
Eritrea                    Africa       1982   43.89000      2637297      524.8758       -0.64500
Slovak Republic            Europe       1972   70.35000      4593433     9674.1676       -0.63000
Hungary                    Europe       1982   69.39000     10705535    12545.9907       -0.56000
Uganda                     Africa       1982   49.84900     12939400      682.2662       -0.50100
Trinidad and Tobago        Americas     2002   68.97600      1101832    11460.6002       -0.48900
Myanmar                    Asia         2002   59.90800     45598081      611.0000       -0.42000
Albania                    Europe       1992   71.58100      3326498     2497.4379       -0.41900
Hungary                    Europe       1992   69.17000     10348684    10535.6285       -0.41000
Trinidad and Tobago        Americas     1997   69.46500      1138101     8792.5731       -0.39700
Congo, Dem. Rep.           Africa       1987   47.41200     35481645      672.7748       -0.37200
Benin                      Africa       2002   54.40600      7026113     1372.8779       -0.37100
Poland                     Europe       1987   70.98000     37740710     9082.3512       -0.34000
Jamaica                    Americas     2002   72.04700      2664659     6994.7749       -0.21500
Croatia                    Europe       1982   70.46000      4413368    13221.8218       -0.18000
Poland                     Europe       1977   70.67000     34621254     9508.1415       -0.18000
Romania                    Europe       1992   69.36000     22797027     6598.4099       -0.17000
Chad                       Africa       1997   51.57300      7562011     1004.9614       -0.15100
Bulgaria                   Europe       1992   71.19000      8658506     6302.6234       -0.15000
Serbia                     Europe       1982   70.16200      9032824    15181.0927       -0.13800
Romania                    Europe       1987   69.53000     22686371     9696.2733       -0.13000
Ghana                      Africa       2002   58.45300     20550751     1111.9846       -0.10300
El Salvador                Americas     1982   56.60400      4474873     4098.3442       -0.09200
Bulgaria                   Europe       1977   70.81000      8797022     7612.2404       -0.09000
Czech Republic             Europe       1972   70.29000      9862158    13108.4536       -0.09000
Norway                     Europe       1987   75.89000      4186147    31540.9748       -0.08000
Netherlands                Europe       1972   73.75000     13329874    18794.7457       -0.07000
Denmark                    Europe       1982   74.63000      5117810    21688.0405       -0.06000
Kenya                      Africa       1992   59.28500     25020539     1341.9217       -0.05400
Angola                     Africa       1987   39.90600      7874230     2430.2083       -0.03600
Gabon                      Africa       2007   56.73500      1454867    13206.4845       -0.02600
Congo, Dem. Rep.           Africa       1982   47.78400     30646495      673.7478       -0.02000
Nigeria                    Africa       1997   47.46400    106207839     1624.9413       -0.00800
Jamaica                    Americas     1992   71.76600      2378618     7404.9237       -0.00400
Romania                    Europe       1967   66.80000     19284814     6470.8665        0.00000
Congo, Rep.                Africa       2002   52.97000      3328795     3484.0620        0.00800
Poland                     Europe       1992   70.99000     38370697     7738.8812        0.01000
Montenegro                 Europe       1997   75.44500       692651     6465.6133        0.01000
Norway                     Europe       1962   73.47000      3638919    13450.4015        0.03000
Slovenia                   Europe       1967   69.18000      1646912     9405.4894        0.03000
Angola                     Africa       2002   41.00300     10866106     2773.2873        0.04000
Iceland                    Europe       1967   73.73000       198676    13319.8957        0.05000
Burkina Faso               Africa       1997   50.32400     10352843      946.2950        0.06400
Mozambique                 Africa       1987   42.86100     12891952      389.8762        0.06600
Sri Lanka                  Asia         1997   70.45700     18698655     2664.4773        0.07800
Afghanistan                Asia         1997   41.76300     22227415      635.3414        0.08900
Slovenia                   Europe       1982   71.06300      1861252    17866.7218        0.09300
Slovak Republic            Europe       1977   70.45000      4827803    10922.6640        0.10000
Chad                       Africa       2007   50.65100     10238807     1704.0637        0.12600
Australia                  Oceania      1967   71.10000     11872264    14526.1246        0.17000
Denmark                    Europe       1987   74.80000      5127024    25116.1758        0.17000
Iceland                    Europe       1997   78.95000       271192    28061.0997        0.18000
Hungary                    Europe       1977   69.95000     10637171    11674.8374        0.19000
Hungary                    Europe       1987   69.58000     10612740    12986.4800        0.19000
Germany                    Europe       1972   71.00000     78717088    18016.1803        0.20000
Ireland                    Europe       1972   71.28000      3024400     9530.7729        0.20000
Romania                    Europe       1982   69.66000     22356726     9605.3141        0.20000
Uruguay                    Americas     1972   68.67300      2829526     5703.4089        0.20500
Iceland                    Europe       1962   73.68000       182053    10350.1591        0.21000
Uruguay                    Americas     1967   68.46800      2748579     5444.6196        0.21500
Djibouti                   Africa       2002   53.37300       447416     1908.2609        0.21600
Cambodia                   Asia         2002   56.75200     12926707      896.2260        0.21800
Thailand                   Asia         1997   67.52100     60216677     5852.6255        0.22300
Cuba                       Americas     1992   74.41400     10723260     5592.8440        0.24000
Netherlands                Europe       1962   73.23000     11805689    12790.8496        0.24000
Iceland                    Europe       1987   77.23000       244676    26923.2063        0.24000
Romania                    Europe       1977   69.46000     21658597     9356.3972        0.25000
Czech Republic             Europe       1982   70.96000     10303704    15377.2285        0.25000
Nigeria                    Africa       2007   46.85900    135031164     2013.9773        0.25100
Sri Lanka                  Asia         1987   69.01100     16495304     1876.7668        0.25400
Hungary                    Europe       1972   69.76000     10394091    10168.6561        0.26000
Norway                     Europe       1972   74.34000      3933004    18965.0555        0.26000
Bulgaria                   Europe       1987   71.34000      8971958     8239.8548        0.26000
Bulgaria                   Europe       1982   71.08000      8892098     8224.1916        0.27000
New Zealand                Oceania      1967   71.52000      2728150    14463.9189        0.28000
Finland                    Europe       1987   74.83000      4931729    21141.0122        0.28000
Slovak Republic            Europe       1987   71.08000      5199318    12037.2676        0.28000
Trinidad and Tobago        Americas     1992   69.86200      1183669     7370.9909        0.28000
Myanmar                    Asia         1987   58.33900     38028578      385.0000        0.28300
Slovak Republic            Europe       1992   71.38000      5302888     9498.4677        0.30000
Mozambique                 Africa       1982   42.79500     12587223      462.2114        0.30000
Italy                      Europe       2007   80.54600     58147733    28569.7197        0.30600
Puerto Rico                Americas     1982   73.75000      3279001    10330.9891        0.31000
Angola                     Africa       1997   40.96300      9875024     2277.1409        0.31600
Burkina Faso               Africa       2002   50.65000     12251209     1037.6452        0.32600
Togo                       Africa       1997   58.39000      4320890      982.2869        0.32900
New Zealand                Oceania      1977   72.22000      3164900    16233.7177        0.33000
United Kingdom             Europe       1962   70.76000     53292000    12477.1771        0.34000
Slovak Republic            Europe       1982   70.80000      5048043    11348.5459        0.35000
Sri Lanka                  Asia         2002   70.81500     19576783     3015.3788        0.35800
Greece                     Europe       1992   77.03000     10325429    17541.4963        0.36000
Romania                    Europe       1997   69.72000     22562458     7346.5476        0.36000
Afghanistan                Asia         2002   42.12900     25268405      726.7341        0.36600
United States              Americas     1987   75.02000    242803533    29884.3504        0.37000
New Zealand                Oceania      1972   71.89000      2929100    16046.0373        0.37000
Madagascar                 Africa       1987   49.35000     10568642     1155.4419        0.38100
Greece                     Europe       2002   78.25600     10603863    22514.2548        0.38700
Eritrea                    Africa       1977   44.53500      2512642      505.7538        0.39300
Rwanda                     Africa       1977   45.00000      4657072      670.0806        0.40000
Ethiopia                   Africa       1982   44.91600     38111756      577.8607        0.40600
Czech Republic             Europe       1977   70.71000     10161915    14800.1606        0.42000
Niger                      Africa       1972   40.54600      5060262      954.2092        0.42800
Zambia                     Africa       1982   51.82100      6100407     1408.6786        0.43500
Serbia                     Europe       1992   71.65900      9826397     9325.0682        0.44100
Bosnia and Herzegovina     Europe       1987   71.14000      4338977     4314.1148        0.45000
Cuba                       Americas     1987   74.17400     10239839     7532.9248        0.45700
Angola                     Africa       1982   39.94200      7016384     2756.9537        0.45900
Czech Republic             Europe       1967   70.38000      9835109    11399.4449        0.48000
New Zealand                Oceania      1987   74.32000      3317166    19007.1913        0.48000
Bulgaria                   Europe       1972   70.90000      8576200     6597.4944        0.48000
Austria                    Europe       1972   70.63000      7544201    16661.6256        0.49000
Argentina                  Americas     1967   65.63400     22934225     8052.9530        0.49200
Jamaica                    Americas     1997   72.26200      2531311     7121.9247        0.49600
Germany                    Europe       1967   70.80000     76368453    14745.6256        0.50000
Trinidad and Tobago        Americas     1967   65.40000       960155     5621.3685        0.50000
Belgium                    Europe       1972   71.44000      9709100    16672.1436        0.50000
Rwanda                     Africa       1972   44.60000      3992121      590.5807        0.50000
Trinidad and Tobago        Americas     1972   65.90000       975199     6619.5514        0.50000
Netherlands                Europe       2002   78.53000     16122830    33724.7578        0.50000
United States              Americas     2002   77.31000    287675526    39097.0995        0.50000
Paraguay                   Americas     1987   67.37800      3886512     3998.8757        0.50400
Burundi                    Africa       1972   44.05700      3529983      464.0995        0.50900
Denmark                    Europe       1972   73.47000      4991596    18866.2072        0.51000
Jamaica                    Americas     2007   72.56700      2780132     7320.8803        0.52000
Paraguay                   Americas     1982   66.87400      3366439     4258.5036        0.52100
Denmark                    Europe       1992   75.33000      5171393    26406.7399        0.53000
Trinidad and Tobago        Americas     1982   68.83200      1116479     9119.5286        0.53200
Paraguay                   Americas     1977   66.35300      2984494     3248.3733        0.53800
Denmark                    Europe       1962   72.35000      4646899    13583.3135        0.54000
Paraguay                   Americas     1957   63.19600      1770902     2046.1547        0.54700
United States              Americas     1967   70.76000    198712000    19530.3656        0.55000
Sweden                     Europe       1972   74.72000      8122293    17832.0246        0.56000
Jamaica                    Americas     1987   71.77000      2326606     6351.2375        0.56000
Montenegro                 Europe       2007   74.54300       684736     9253.8961        0.56200
Sao Tome and Principe      Africa       1997   63.30600       145608     1339.0760        0.56400
Montenegro                 Europe       1992   75.43500       621621     7003.3390        0.57000
Serbia                     Europe       1997   72.23200     10336594     7914.3203        0.57300
Kenya                      Africa       1987   59.33900     21198082     1361.9369        0.57300
Cameroon                   Africa       2007   50.43000     17696293     2042.0952        0.57400
United States              Americas     1972   71.34000    209896000    21806.0359        0.58000
Nigeria                    Africa       1992   47.47200     93364244     1619.8482        0.58600
Netherlands                Europe       1967   73.82000     12596822    15363.2514        0.59000
Paraguay                   Americas     1967   64.95100      2287985     2299.3763        0.59000
Netherlands                Europe       1992   77.42000     15174244    26790.9496        0.59000
Burundi                    Africa       1997   45.32600      6121610      463.1151        0.59000
Austria                    Europe       1967   70.14000      7376998    12834.6024        0.60000
United Kingdom             Europe       1967   71.36000     54959000    14142.8509        0.60000
Norway                     Europe       1982   75.97000      4114787    26298.6353        0.60000
Australia                  Oceania      1962   70.93000     10794968    12217.2269        0.60000
Spain                      Europe       1987   76.90000     38880702    15764.9831        0.60000
Japan                      Asia         2007   82.60300    127467972    31656.0681        0.60300
Denmark                    Europe       1967   72.96000      4838800    15937.2112        0.61000
Norway                     Europe       1967   74.08000      3786019    16361.8765        0.61000
Netherlands                Europe       1997   78.03000     15604464    30246.1306        0.61000
Czech Republic             Europe       1987   71.58000     10311597    16310.4434        0.62000
Switzerland                Europe       1992   78.03000      6995447    31871.5303        0.62000
Venezuela                  Americas     2002   72.76600     24287670     8605.0478        0.62000
Sweden                     Europe       1957   72.49000      7363802     9911.8782        0.63000
Niger                      Africa       1967   40.11800      4534062     1054.3849        0.63100
Guinea-Bissau              Africa       2002   45.50400      1332459      575.7047        0.63100
Korea, Dem. Rep.           Asia         2007   67.29700     23301725     1593.0655        0.63500
Slovenia                   Europe       1972   69.82000      1694510    12383.4862        0.64000
Poland                     Europe       1982   71.32000     36227381     8451.5310        0.65000
Slovak Republic            Europe       1967   70.98000      4442238     8412.9024        0.65000
United Kingdom             Europe       1972   72.01000     56079000    15895.1164        0.65000
Sweden                     Europe       2002   80.04000      8954175    29341.6309        0.65000
Colombia                   Americas     1992   68.42100     34202721     5444.6486        0.65300
Ireland                    Europe       1997   76.12200      3667233    24521.9471        0.65500
Costa Rica                 Americas     2007   78.78200      4133884     9645.0614        0.65900
Canada                     Americas     1997   78.61000     30305843    28954.9259        0.66000
Spain                      Europe       1992   77.57000     39549438    18603.0645        0.67000
Cote d'Ivoire              Africa       1987   54.65500     10761098     2156.9561        0.67200
Chad                       Africa       1992   51.72400      6429417     1058.0643        0.67300
Lebanon                    Asia         1977   66.09900      3115787     8659.6968        0.67800
Austria                    Europe       1957   67.48000      6965860     8842.5980        0.68000
Kuwait                     Asia         2007   77.58800      2505559    47306.9898        0.68400
Tanzania                   Africa       1982   50.60800     19844382      874.2426        0.68900
Belgium                    Europe       1967   70.94000      9556500    13149.0412        0.69000
Japan                      Asia         1992   79.36000    124329269    26824.8951        0.69000
Chile                      Americas     2007   78.55300     16284741    13171.6388        0.69300
Reunion                    Africa       2007   76.44200       798094     7670.1226        0.69800
Equatorial Guinea          Africa       1997   48.24500       439971     2814.4808        0.70000
Burkina Faso               Africa       1992   50.26000      8878303      931.7528        0.70300
Hong Kong, China           Asia         2007   82.20800      6980412    39724.9787        0.71300
Congo, Rep.                Africa       1977   55.62500      1536769     3259.1790        0.71800
United States              Americas     1962   70.21000    186538000    16173.1459        0.72000
Sweden                     Europe       1977   75.44000      8251648    18855.7252        0.72000
United States              Americas     1997   76.81000    272911760    35767.4330        0.72000
Iceland                    Europe       1972   74.46000       209275    15798.0636        0.73000
Norway                     Europe       2002   79.05000      4535591    44683.9753        0.73000
Cambodia                   Asia         1997   56.53400     11782962      734.2852        0.73100
Sri Lanka                  Asia         1962   62.19200     10421936     1074.4720        0.73600
Germany                    Europe       2007   79.40600     82400996    32170.3744        0.73600
Burundi                    Africa       1987   48.21100      5126023      621.8188        0.74000
Angola                     Africa       1992   40.64700      8735988     2627.8457        0.74100
Argentina                  Americas     1962   65.14200     21283783     7133.1660        0.74300
Lesotho                    Africa       1967   48.49200       996380      498.6390        0.74500
Niger                      Africa       1977   41.29100      5682086      808.8971        0.74500
Kuwait                     Asia         2002   76.90400      2111561    35110.1057        0.74800
Hungary                    Europe       2007   73.33800      9956108    18008.9444        0.74800
Canada                     Americas     1972   72.88000     22284500    18970.5709        0.75000
Ireland                    Europe       1977   72.03000      3271900    11150.9811        0.75000
United Kingdom             Europe       1977   72.76000     56179000    17428.7485        0.75000
Hong Kong, China           Asia         1987   76.20000      5584510    20038.4727        0.75000
Trinidad and Tobago        Americas     1987   69.58200      1191336     7388.5978        0.75000
Switzerland                Europe       1962   71.32000      5666000    20431.0927        0.76000
Bosnia and Herzegovina     Europe       2007   74.85200      4552198     7446.2988        0.76200
Lebanon                    Asia         2002   71.02800      3677780     9313.9388        0.76300
Montenegro                 Europe       1987   74.86500       569473    11732.5102        0.76400
Norway                     Europe       1957   73.44000      3491938    11653.9730        0.77000
Sweden                     Europe       1987   77.19000      8421403    23586.9293        0.77000
Albania                    Europe       2007   76.42300      3600523     5937.0295        0.77200
Congo, Rep.                Africa       1987   57.47000      2064095     4201.1949        0.77500
Sri Lanka                  Asia         1972   65.04200     13016733     1213.3955        0.77600
Netherlands                Europe       1987   76.83000     14665278    23651.3236        0.78000
Denmark                    Europe       1997   76.11000      5283663    29804.3457        0.78000
Serbia                     Europe       2007   74.00200     10150265     9786.5347        0.78900
Ireland                    Europe       1967   71.08000      2900100     7655.5690        0.79000
Sweden                     Europe       1967   74.16000      7867931    15258.2970        0.79000
Belgium                    Europe       2002   78.32000     10311970    30485.8838        0.79000
Swaziland                  Africa       1992   58.47400       962344     3553.0224        0.79600
United Kingdom             Europe       1997   77.21800     58808266    26074.5314        0.79800
Portugal                   Europe       1992   74.86000      9927680    16207.2666        0.80000
Uruguay                    Americas     1977   69.48100      2873520     6504.3397        0.80800
Portugal                   Europe       2007   78.09800     10642836    20509.6478        0.80800
Netherlands                Europe       1982   76.05000     14310401    21399.4605        0.81000
Switzerland                Europe       1982   76.21000      6468126    28397.7151        0.82000
Czech Republic             Europe       1992   72.40000     10315702    14297.0212        0.82000
Ecuador                    Americas     2007   74.99400     13755680     6873.2623        0.82100
Panama                     Americas     2007   75.53700      3242173     9809.1856        0.82500
Canada                     Americas     1967   72.13000     20819767    16076.5880        0.83000
France                     Europe       1972   72.38000     51732000    16107.1917        0.83000
Bosnia and Herzegovina     Europe       1982   70.69000      4172693     4126.6132        0.83000
Australia                  Oceania      1972   71.93000     13177000    16788.6295        0.83000
Argentina                  Americas     1987   70.77400     31620918     9139.6714        0.83200
Uruguay                    Americas     1992   72.75200      3149262     8137.0048        0.83400
Greece                     Europe       1997   77.86900     10502372    18747.6981        0.83900
Bahrain                    Asia         2007   75.63500       708573    29796.0483        0.84000
Trinidad and Tobago        Americas     2007   69.81900      1056608    18008.5092        0.84300
Sweden                     Europe       2007   80.88400      9031088    33859.7484        0.84400
Bosnia and Herzegovina     Europe       2002   74.09000      4165416     6018.9752        0.84600
Paraguay                   Americas     1992   68.22500      4483945     4196.4111        0.84700
Mauritius                  Africa       2007   72.80100      1250882    10956.9911        0.84700
China                      Asia         1977   63.96736    943455000      741.2375        0.84848
Austria                    Europe       2007   79.82900      8199783    36126.4927        0.84900
Afghanistan                Asia         1992   41.67400     16317921      649.3414        0.85200
Benin                      Africa       1997   54.77700      6066080     1232.9753        0.85800
Togo                       Africa       2007   58.42000      5701579      882.9699        0.85900
Netherlands                Europe       1957   72.99000     11026383    11276.1934        0.86000
Taiwan                     Asia         1992   74.26000     20686918    15215.6579        0.86000
Costa Rica                 Americas     2002   78.12300      3834934     7723.4472        0.86300
Slovak Republic            Europe       2007   74.66300      5447502    18678.3144        0.86300
Paraguay                   Americas     1972   65.81500      2614104     2523.3380        0.86400
Australia                  Oceania      2007   81.23500     20434176    34435.3674        0.86500
Bulgaria                   Europe       2007   73.00500      7322858    10680.7928        0.86500
New Zealand                Oceania      1957   70.26000      2229407    12247.3953        0.87000
Czech Republic             Europe       1962   69.90000      9620282    10136.8671        0.87000
Finland                    Europe       1992   75.70000      5041039    20647.1650        0.87000
Bahrain                    Asia         2002   74.79500       656397    23403.5593        0.87000
Croatia                    Europe       2007   75.74800      4493312    14619.2227        0.87200
Israel                     Asia         1972   71.63000      3095893    12786.9322        0.88000
Iceland                    Europe       1982   76.99000       233997    23269.6075        0.88000
Puerto Rico                Americas     1987   74.63000      3444468    12281.3419        0.88000
Sweden                     Europe       1962   73.37000      7561588    12329.4419        0.88000
Tunisia                    Africa       2007   73.92300     10276158     7092.9230        0.88100
Canada                     Americas     2007   80.65300     33390141    36319.2350        0.88300
Lebanon                    Asia         1982   66.98300      3086876     7640.5195        0.88400
Guinea-Bissau              Africa       2007   46.38800      1472041      579.2317        0.88400
Niger                      Africa       1962   39.48700      4076008      997.7661        0.88900
Dominican Republic         Americas     2002   70.84700      8650322     4563.8082        0.89000
Poland                     Europe       2007   75.56300     38518241    15389.9247        0.89300
Honduras                   Americas     2002   68.56500      6677328     3099.7287        0.90600
Sri Lanka                  Asia         1977   65.94900     14116836     1348.7757        0.90700
Bulgaria                   Europe       1967   70.42000      8310226     5577.0028        0.91000
Tanzania                   Africa       1987   51.53500     23040630      831.8221        0.92700
Turkey                     Europe       2007   71.77700     71158647     8458.2764        0.93200
United States              Americas     2007   78.24200    301139947    42951.6531        0.93200
China                      Asia         2007   72.96100   1318683096     4959.1149        0.93300
Panama                     Americas     1992   72.46200      2484997     6618.7431        0.93900
Finland                    Europe       1957   67.49000      4324000     7545.4154        0.94000
Switzerland                Europe       1957   70.56000      5126000    17909.4897        0.94000
Lebanon                    Asia         1987   67.92600      3089353     5377.0913        0.94300
Finland                    Europe       2007   79.31300      5238460    33207.0844        0.94300
Guinea                     Africa       1957   34.55800      2876726      576.2670        0.94900
France                     Europe       2002   79.59000     59925035    28926.0323        0.95000
Malawi                     Africa       1957   37.20700      3221238      416.3698        0.95100
United Kingdom             Europe       2007   79.42500     60776238    33203.2613        0.95400
Venezuela                  Americas     1992   71.15000     20265563    10733.9263        0.96000
Costa Rica                 Americas     1992   75.71300      3173216     6160.4163        0.96100
Lebanon                    Asia         2007   71.99300      3921278    10461.0587        0.96500
Singapore                  Asia         1982   71.76000      2651869    15169.1611        0.96500
Kuwait                     Asia         1997   76.15600      1765345    40300.6200        0.96600
United Kingdom             Europe       1987   75.00700     56981620    21664.7877        0.96700
Puerto Rico                Americas     2007   78.74600      3942491    19328.7090        0.96800
Afghanistan                Asia         1987   40.82200     13867957      852.3959        0.96800
Sweden                     Europe       1992   78.16000      8718867    23880.0168        0.97000
Reunion                    Africa       2002   75.74400       743981     6316.1652        0.97200
Uruguay                    Americas     1957   67.04400      2424959     6150.7730        0.97300
Lebanon                    Asia         1997   70.26500      3430388     8754.9639        0.97300
Panama                     Americas     2002   74.71200      2990875     7356.0319        0.97400
Czech Republic             Europe       2007   76.48600     10228744    22833.3085        0.97600
Guinea-Bissau              Africa       1977   37.46500       745228      764.7260        0.97900
New Zealand                Oceania      1962   71.24000      2488550    13175.6780        0.98000
Argentina                  Americas     2007   75.32000     40301927    12779.3796        0.98000
Pakistan                   Asia         1997   61.81800    135564834     2049.3505        0.98000
Iceland                    Europe       1957   73.47000       165110     9244.0014        0.98000
Sweden                     Europe       1982   76.42000      8325260    20667.3812        0.98000
Serbia                     Europe       2002   73.21300     10111559     7236.0753        0.98100
Venezuela                  Americas     2007   73.74700     26084662    11415.8057        0.98100
Somalia                    Africa       1982   42.95500      5828892     1176.8070        0.98100
Myanmar                    Asia         1992   59.32000     40546538      347.0000        0.98100
Guinea-Bissau              Africa       1957   33.48900       601095      431.7905        0.98900
Sudan                      Africa       1957   39.62400      9753392     1770.3371        0.98900
Taiwan                     Asia         1997   75.25000     21628605    20206.8210        0.99000
Mauritius                  Africa       1997   70.73600      1149818     7425.7053        0.99100
Guinea-Bissau              Africa       1972   36.48600       625361      820.2246        0.99400
Ethiopia                   Africa       1977   44.51000     34617799      556.8084        0.99500
Venezuela                  Americas     1997   72.14600     22374398    10165.4952        0.99600
Sudan                      Africa       2002   56.36900     37090298     1993.3983        0.99600
Paraguay                   Americas     2007   71.75200      6667147     4172.8385        0.99700
Guinea-Bissau              Africa       1962   34.48800       627820      522.0344        0.99900
Norway                     Europe       1997   78.32000      4405672    41283.1643        1.00000
Somalia                    Africa       1977   41.97400      4353666     1450.9925        1.00100
Guinea-Bissau              Africa       1967   35.49200       601287      715.5806        1.00400
Mauritius                  Africa       1992   69.74500      1096202     6058.2538        1.00500
Liberia                    Africa       1957   39.48600       975950      620.9700        1.00600
Puerto Rico                Americas     1997   74.91700      3759430    16999.4333        1.00600
Croatia                    Europe       1992   72.52700      4494013     8447.7949        1.00700
Cuba                       Americas     2002   77.15800     11226999     6340.6467        1.00700
Myanmar                    Asia         1997   60.32800     43247867      415.0000        1.00800
Belgium                    Europe       1962   70.25000      9218400    10991.2068        1.01000
Switzerland                Europe       1972   73.78000      6401400    27195.1130        1.01000
Austria                    Europe       1982   73.18000      7574613    21597.0836        1.01000
Spain                      Europe       2002   79.78000     40152517    24835.4717        1.01000
Sao Tome and Principe      Africa       1992   62.74200       125911     1428.7778        1.01400
Kuwait                     Asia         1992   75.19000      1418095    34932.9196        1.01600
Liberia                    Africa       1962   40.50200      1112796      634.1952        1.01600
Italy                      Europe       1992   77.44000     56840847    22013.6449        1.02000
Denmark                    Europe       1957   71.81000      4487831    11099.6593        1.03000
Croatia                    Europe       1977   70.64000      4318673    11305.3852        1.03000
Norway                     Europe       1977   75.37000      4043205    23311.3494        1.03000
Sao Tome and Principe      Africa       2002   64.33700       170372     1353.0924        1.03100
Liberia                    Africa       1967   41.53600      1279406      713.6036        1.03400
Montenegro                 Europe       1982   74.10100       562548    11222.5876        1.03500
Bosnia and Herzegovina     Europe       1992   72.17800      4256013     2546.7814        1.03800
France                     Europe       1967   71.55000     49569000    12999.9177        1.04000
Finland                    Europe       1972   70.87000      4639657    14358.8759        1.04000
Thailand                   Asia         2002   68.56400     62806748     5913.1875        1.04300
Germany                    Europe       1987   74.84700     77718298    24639.1857        1.04700
Mongolia                   Asia         1992   61.27100      2312802     1785.4020        1.04900
Israel                     Asia         2007   80.74500      6426679    25523.2771        1.04900
United States              Americas     1957   69.49000    171984000    14847.1271        1.05000
Panama                     Americas     1987   71.52300      2253639     7034.7792        1.05100
West Bank and Gaza         Asia         2007   73.42200      4018332     3025.3498        1.05200
South Africa               Africa       1992   61.88800     39964159     7225.0693        1.05400
Ghana                      Africa       1997   58.55600     18418288     1005.2458        1.05500
Serbia                     Europe       1987   71.21800      9230783    15870.8785        1.05600
Puerto Rico                Americas     1972   72.16000      2847132     9123.0417        1.06000
France                     Europe       1982   74.89000     54433565    20293.8975        1.06000
Croatia                    Europe       1987   71.52000      4484310    13822.5839        1.06000
Nigeria                    Africa       1987   46.88600     81551520     1385.0296        1.06000
Argentina                  Americas     2002   74.34000     38331121     8797.6407        1.06500
Bosnia and Herzegovina     Europe       1997   73.24400      3607000     4766.3559        1.06600
France                     Europe       2007   80.65700     61083916    30470.0167        1.06700
Cuba                       Americas     1982   73.71700      9789224     7316.9181        1.06800
Tunisia                    Africa       2002   73.04200      9770575     5722.8957        1.06900
Ireland                    Europe       1982   73.10000      3480000    12618.3214        1.07000
Congo, Rep.                Africa       1982   56.69500      1774735     4879.5075        1.07000
United States              Americas     1992   76.09000    256894189    32003.9322        1.07000
Belgium                    Europe       1997   77.53000     10199787    27561.1966        1.07000
Denmark                    Europe       2002   77.18000      5374693    32166.5001        1.07000
Uruguay                    Americas     2007   76.38400      3447496    10611.4630        1.07700
Malawi                     Africa       1967   39.48700      4147252      495.5148        1.07700
Liberia                    Africa       1972   42.61400      1482628      803.0055        1.07800
Puerto Rico                Americas     1962   69.62000      2448046     5108.3446        1.08000
Finland                    Europe       1967   69.83000      4605744    10921.6363        1.08000
Switzerland                Europe       2007   81.70100      7554661    37506.4191        1.08100
Uruguay                    Americas     2002   75.30700      3363085     7727.0020        1.08400
Liberia                    Africa       1982   44.85200      1956875      572.1996        1.08800
Canada                     Americas     1992   77.95000     28523502    26342.8843        1.09000
Slovak Republic            Europe       2002   73.80000      5410052    13638.7784        1.09000
Syria                      Asia         2007   74.14300     19314747     4184.5481        1.09000
Saudi Arabia               Asia         2002   71.62600     24501530    19014.5412        1.09300
Argentina                  Americas     1992   71.86800     33958947     9308.4187        1.09400
New Zealand                Oceania      2007   80.20400      4115771    25185.0091        1.09400
Jamaica                    Americas     1982   71.21000      2298309     6068.0513        1.10000
Canada                     Americas     1987   76.86000     26549700    26626.5150        1.10000
Rwanda                     Africa       1967   44.10000      3451079      510.9637        1.10000
Austria                    Europe       1992   76.04000      7914969    27042.0187        1.10000
Venezuela                  Americas     1982   68.55700     15620766    11152.4101        1.10100
Ireland                    Europe       2007   78.88500      4109086    40675.9964        1.10200
Equatorial Guinea          Africa       2002   49.34800       495627     7703.4959        1.10300
Malaysia                   Asia         2002   73.04400     22662365    10206.9779        1.10600
Ireland                    Europe       1992   75.46700      3557761    17558.8155        1.10700
Croatia                    Europe       1972   69.61000      4225310     9164.0901        1.11000
Jamaica                    Americas     1977   70.11000      2156814     6650.1956        1.11000
Belgium                    Europe       1992   76.46000     10045622    25575.5707        1.11000
Portugal                   Europe       1997   75.97000     10156415    17641.0316        1.11000
Uruguay                    Americas     1987   71.91800      3045153     7452.3990        1.11300
India                      Asia         2002   62.87900   1034172547     1746.7695        1.11400
Colombia                   Americas     1987   67.76800     30964245     4903.2191        1.11500
Cuba                       Americas     2007   78.27300     11416987     8948.1029        1.11500
Sierra Leone               Africa       2002   41.01200      5359092      699.4897        1.11500
France                     Europe       1992   77.46000     57374179    24703.7961        1.12000
Togo                       Africa       1992   58.06100      3747553     1034.2989        1.12000
Belgium                    Europe       2007   79.44100     10392226    33692.6051        1.12100
Italy                      Europe       1972   72.19000     54365564    12269.2738        1.13000
Belgium                    Europe       1982   73.93000      9856303    20979.8459        1.13000
El Salvador                Americas     2007   71.87800      6939688     5728.3535        1.14400
Norway                     Europe       2007   80.19600      4627926    49357.1902        1.14600
Portugal                   Europe       1977   70.41000      9662600    10172.4857        1.15000
Israel                     Asia         1987   75.60000      4203148    17122.4799        1.15000
Liberia                    Africa       1977   43.76400      1703617      640.3224        1.15000
Slovenia                   Europe       1977   70.97000      1746919    15277.0302        1.15000
Saudi Arabia               Asia         2007   72.77700     27601038    21654.8319        1.15100
Denmark                    Europe       2007   78.33200      5468120    35278.4187        1.15200
Croatia                    Europe       1997   73.68000      4444595     9875.6045        1.15300
Niger                      Africa       1957   38.59800      3692184      835.5234        1.15400
Romania                    Europe       2007   72.47600     22276056    10808.4756        1.15400
Reunion                    Africa       1997   74.77200       684810     6071.9414        1.15700
Canada                     Americas     2002   79.77000     31902268    33328.9651        1.16000
Spain                      Europe       2007   80.94100     40448191    28821.0637        1.16100
Namibia                    Africa       1992   61.99900      1554253     3804.5380        1.16400
Paraguay                   Americas     1962   64.36100      2009813     2148.0271        1.16500
Liberia                    Africa       1987   46.02700      2269414      506.1139        1.17500
Paraguay                   Americas     1997   69.40000      5154123     4247.4003        1.17500
Gabon                      Africa       1992   61.36600       985739    13522.1575        1.17600
France                     Europe       1997   78.64000     58623428    25889.7849        1.18000
Libya                      Africa       2002   72.73700      5368585     9534.6775        1.18200
Tanzania                   Africa       2002   49.65100     34593779      899.0742        1.18500
Slovenia                   Europe       1987   72.25000      1945870    18678.5349        1.18700
Sao Tome and Principe      Africa       2007   65.52800       199579     1598.4351        1.19100
Malaysia                   Asia         1992   70.69300     18319502     7277.9128        1.19300
Guinea                     Africa       1962   35.75300      3140003      686.3737        1.19500
Croatia                    Europe       2002   74.87600      4481020    11628.3890        1.19600
Sierra Leone               Africa       1962   32.76700      2467895     1116.6399        1.19700
Malaysia                   Asia         2007   74.24100     24821286    12451.6558        1.19700
El Salvador                Americas     2002   70.73400      6353681     5351.5687        1.19900
Germany                    Europe       1962   70.30000     73739117    12902.4629        1.20000
Taiwan                     Asia         1977   70.59000     16785196     5596.5198        1.20000
Switzerland                Europe       1987   77.41000      6649942    30281.7046        1.20000
Spain                      Europe       1997   78.77000     39855442    20445.2990        1.20000
Singapore                  Asia         2007   79.97200      4553009    47143.1796        1.20200
Malawi                     Africa       1962   38.41000      3628608      427.9011        1.20300
Colombia                   Americas     2007   72.88900     44227550     7006.5804        1.20700
Uruguay                    Americas     1962   68.25300      2598466     5603.3577        1.20900
Australia                  Oceania      1957   70.33000      9712569    10949.6496        1.21000
Canada                     Americas     1957   69.96000     17010154    12489.9501        1.21000
Yemen, Rep.                Asia         1962   35.18000      6120081      825.6232        1.21000
Thailand                   Asia         1992   67.29800     56667095     4616.8965        1.21400
Libya                      Africa       2007   73.95200      6036914    12057.4993        1.21500
Mauritius                  Africa       2002   71.95400      1200206     9021.8159        1.21800
Rwanda                     Africa       1982   46.21800      5507565      881.5706        1.21800
Denmark                    Europe       1977   74.69000      5088419    20422.9015        1.22000
New Zealand                Oceania      1997   77.55000      3676187    21050.4138        1.22000
Germany                    Europe       1992   76.07000     80597764    26505.3032        1.22300
Greece                     Europe       2007   79.48300     10706290    27538.4119        1.22700
Djibouti                   Africa       1987   50.04000       311025     2880.1026        1.22800
Sweden                     Europe       1997   79.39000      8897619    25266.5950        1.23000
Mexico                     Americas     2002   74.90200    102479927    10742.4405        1.23200
Netherlands                Europe       2007   79.76200     16570613    36797.9333        1.23200
Vietnam                    Asia         2007   74.24900     85262356     2441.5764        1.23200
Sierra Leone               Africa       1957   31.57000      2295678     1004.4844        1.23900
Belgium                    Europe       1957   69.24000      8989111     9714.9606        1.24000
United Kingdom             Europe       1957   70.42000     51430000    11283.1779        1.24000
Poland                     Europe       1972   70.85000     33039545     8006.5070        1.24000
Albania                    Europe       1977   68.93000      2509048     3533.0039        1.24000
Taiwan                     Asia         1987   73.40000     19757799    11054.5618        1.24000
Australia                  Oceania      1992   77.56000     17481977    23424.7668        1.24000
Finland                    Europe       2002   78.37000      5193039    28204.5906        1.24000
Malaysia                   Asia         1997   71.93800     20476091    10132.9096        1.24500
Sudan                      Africa       1962   40.87000     11183227     1959.5938        1.24600
Australia                  Oceania      1982   74.74000     15184200    19477.0093        1.25000
Switzerland                Europe       2002   80.62000      7361757    34480.9577        1.25000
United Kingdom             Europe       2002   78.47100     59912431    29478.9992        1.25300
Iceland                    Europe       2007   81.75700       301931    36180.7892        1.25700
Finland                    Europe       1962   68.75000      4491443     9371.8426        1.26000
Ireland                    Europe       1987   74.36000      3539900    13872.8665        1.26000
Honduras                   Americas     1997   67.65900      5867957     3160.4549        1.26000
Slovenia                   Europe       2007   77.92600      2009245    25768.2576        1.26600
Australia                  Oceania      1997   78.83000     18565243    26997.9366        1.27000
United States              Americas     1982   74.65000    232187835    25009.5591        1.27000
Germany                    Europe       1997   77.34000     82011073    27788.8842        1.27000
Jordan                     Asia         2007   72.53500      6053193     4519.4612        1.27200
Tanzania                   Africa       1962   44.24600     10863958      722.0038        1.27200
Singapore                  Asia         1977   70.79500      2325300    11210.0895        1.27400
West Bank and Gaza         Asia         2002   72.37000      3389578     4515.4876        1.27400
Lesotho                    Africa       1972   49.76700      1116779      496.5816        1.27500
Panama                     Americas     1997   73.73800      2734531     7113.6923        1.27600
Zambia                     Africa       1977   51.38600      5216550     1588.6883        1.27900
Puerto Rico                Americas     1977   73.44000      3080828     9770.5249        1.28000
United Kingdom             Europe       1982   74.04000     56339704    18232.4245        1.28000
Guatemala                  Americas     2007   70.25900     12572928     5186.0500        1.28100
Sierra Leone               Africa       1972   35.40000      2879013     1353.7598        1.28700
Italy                      Europe       1977   73.48000     56059245    14255.9847        1.29000
Portugal                   Europe       1987   74.06000      9915289    13039.3088        1.29000
Mexico                     Americas     2007   76.19500    108700891    11977.5750        1.29300
Germany                    Europe       1982   73.80000     78335266    22031.5327        1.30000
Slovenia                   Europe       1962   69.15000      1582962     7402.3034        1.30000
Costa Rica                 Americas     1987   74.75200      2799811     5629.9153        1.30200
Oman                       Asia         1997   72.49900      2283635    19702.0558        1.30200
Niger                      Africa       1982   42.59800      6437188      909.7221        1.30700
Algeria                    Africa       2007   72.30100     33333216     6223.3675        1.30700
Japan                      Asia         2002   82.00000    127065841    28604.5919        1.31000
Mauritius                  Africa       1967   61.55700       789309     2475.3876        1.31100
Ethiopia                   Africa       1997   49.40200     59861301      515.8894        1.31100
Nigeria                    Africa       1982   45.82600     73039376     1576.9738        1.31200
Portugal                   Europe       2002   77.29000     10433867    19970.9079        1.32000
Ethiopia                   Africa       2002   50.72500     67946797      530.0535        1.32300
Bahrain                    Asia         1997   73.92500       598561    20292.0168        1.32400
Uruguay                    Americas     1982   70.80500      2953997     6920.2231        1.32400
Chile                      Americas     1957   56.07400      7048426     4315.6227        1.32900
Canada                     Americas     1977   74.21000     23796400    22090.8831        1.33000
Spain                      Europe       1977   74.39000     36439000    13236.9212        1.33000
Japan                      Asia         1997   80.69000    125956499    28816.5850        1.33000
Slovak Republic            Europe       1997   72.71000      5383010    12126.2306        1.33000
Germany                    Europe       2002   78.67000     82350671    30035.8020        1.33000
Israel                     Asia         1992   76.93000      4936550    18051.5225        1.33000
Israel                     Asia         1997   78.26900      5531387    20896.6092        1.33900
Canada                     Americas     1962   71.30000     18985849    13462.4855        1.34000
Greece                     Europe       1972   72.34000      8888628    12724.8296        1.34000
Greece                     Europe       1977   73.68000      9308479    14195.5243        1.34000
Switzerland                Europe       1997   79.37000      7193761    32135.3230        1.34000
Sierra Leone               Africa       1967   34.11300      2662190     1206.0435        1.34600
Paraguay                   Americas     2002   70.75500      5884491     3783.6742        1.35500
Israel                     Asia         1967   70.75000      2693585     8393.7414        1.36000
Belgium                    Europe       1977   72.80000      9821800    19117.9745        1.36000
Lebanon                    Asia         1992   69.29200      3219994     6890.8069        1.36600
Sri Lanka                  Asia         1992   70.37900     17587060     2153.7392        1.36800
Albania                    Europe       1997   72.95000      3428038     3193.0546        1.36900
Colombia                   Americas     2002   71.68200     41008227     5755.2600        1.36900
Croatia                    Europe       1967   68.50000      4174366     6960.2979        1.37000
Singapore                  Asia         1997   77.15800      3802309    33519.4766        1.37000
Sao Tome and Principe      Africa       1987   61.72800       110812     1516.5255        1.37700
West Bank and Gaza         Asia         1997   71.09600      2826046     7110.6676        1.37800
Italy                      Europe       1997   78.82000     57479469    24675.0245        1.38000
Brazil                     Americas     2007   72.39000    190010647     9065.8008        1.38400
Philippines                Asia         2007   71.68800     91077287     3190.4810        1.38500
Mauritius                  Africa       1972   62.94400       851334     2575.4842        1.38700
Sierra Leone               Africa       1977   36.78800      3140897     1348.2852        1.38800
Dominican Republic         Americas     2007   72.23500      9319622     6025.3748        1.38800
Ireland                    Europe       1962   70.29000      2830000     6631.5973        1.39000
Israel                     Asia         1982   74.45000      3858421    15367.0292        1.39000
Slovenia                   Europe       1992   73.64000      1999210    14214.7168        1.39000
Ethiopia                   Africa       1972   43.51500     30770372      566.2439        1.40000
Albania                    Europe       1967   66.22000      1984060     2760.1969        1.40000
Hong Kong, China           Asia         1992   77.60100      5829696    24757.6030        1.40100
Sudan                      Africa       1987   51.74400     24725960     1507.8192        1.40600
Ethiopia                   Africa       1992   48.09100     52088559      421.3535        1.40700
Gambia                     Africa       2007   59.44800      1688359      752.7497        1.40700
Argentina                  Americas     1997   73.27500     36203463    10967.2820        1.40700
Algeria                    Africa       1997   69.15200     29072015     4797.2951        1.40800
Mongolia                   Asia         2002   65.03300      2674234     2140.7393        1.40800
Iran                       Asia         2002   69.45100     66907826     9240.7620        1.40900
Taiwan                     Asia         2007   78.40000     23174294    28718.2768        1.41000
United Kingdom             Europe       1992   76.42000     57866349    22705.0925        1.41300
Senegal                    Africa       2002   61.60000     10870037     1519.6353        1.41300
Argentina                  Americas     1977   68.48100     26983828    10079.0267        1.41600
Afghanistan                Asia         1982   39.85400     12881816      978.0114        1.41600
China                      Asia         1992   68.69000   1164970000     1655.7842        1.41600
Djibouti                   Africa       2007   54.79100       496374     2082.4816        1.41800
Liberia                    Africa       1997   42.22100      2200725      609.1740        1.41900
Belgium                    Europe       1987   75.35000      9870200    22525.5631        1.42000
Italy                      Europe       2002   80.24000     57926999    27968.0982        1.42000
Yemen, Rep.                Asia         1957   33.97000      5498090      804.8305        1.42200
Mozambique                 Africa       1992   44.28400     13160731      410.8968        1.42300
Israel                     Asia         2002   79.69600      6029529    21905.5951        1.42700
Namibia                    Africa       2007   52.90600      2055080     4811.0604        1.42700
Italy                      Europe       1962   69.24000     50843200     8243.5823        1.43000
Norway                     Europe       1992   77.32000      4286357    33965.6611        1.43000
Finland                    Europe       1997   77.13000      5134406    23723.9502        1.43000
Israel                     Asia         1977   73.06000      3495918    13306.6192        1.43000
Greece                     Europe       1987   76.67000      9974490    16120.5284        1.43000
Argentina                  Americas     1972   67.06500     24779799     9443.0385        1.43100
Benin                      Africa       1987   52.33700      4243788     1225.8560        1.43300
Central African Republic   Africa       2007   44.74100      4369038      706.0165        1.43300
Burkina Faso               Africa       1987   49.55700      7586551      912.0631        1.43500
Italy                      Europe       1987   76.42000     56729703    19207.2348        1.44000
Guinea                     Africa       1967   37.19700      3451418      708.7595        1.44400
Oman                       Asia         2007   75.64000      3204897    22316.1929        1.44700
Switzerland                Europe       1967   72.77000      6063000    22966.1443        1.45000
France                     Europe       1977   73.83000     53165019    18292.6351        1.45000
France                     Europe       1987   76.34000     55630100    22066.4421        1.45000
Haiti                      Americas     1992   55.08900      6326682     1456.3095        1.45300
Argentina                  Americas     1982   69.94200     29341374     8997.8974        1.46100
Senegal                    Africa       2007   63.06200     12267493     1712.4721        1.46200
Haiti                      Americas     2002   58.13700      7607651     1270.3649        1.46600
Congo, Dem. Rep.           Africa       1962   42.12200     17486434      896.3146        1.47000
Albania                    Europe       1972   67.69000      2263554     3313.4222        1.47000
Austria                    Europe       1997   77.51000      8069876    29095.9207        1.47000
Austria                    Europe       2002   78.98000      8148312    32417.6077        1.47000
Togo                       Africa       1987   56.94100      3154264     1202.2014        1.47000
Uruguay                    Americas     1997   74.22300      3262838     9230.2407        1.47100
Bolivia                    Americas     1957   41.89000      3211738     2127.6863        1.47600
Nigeria                    Africa       1957   37.80200     37173340     1100.5926        1.47800
Puerto Rico                Americas     1967   71.10000      2648961     6929.2777        1.48000
Thailand                   Asia         1987   66.08400     52910342     2982.6538        1.48700
Gabon                      Africa       1962   40.48900       455661     6631.4592        1.49000
Greece                     Europe       1967   71.00000      8716441     8513.0970        1.49000
Jamaica                    Americas     1972   69.00000      1997616     7433.8893        1.49000
Mali                       Africa       1972   39.97700      5828158      581.3689        1.49000
Netherlands                Europe       1977   75.24000     13852989    21209.0592        1.49000
Albania                    Europe       1982   70.42000      2780097     3630.8807        1.49000
Slovenia                   Europe       1997   75.13000      2011612    17161.1073        1.49000
Jordan                     Asia         2002   71.26300      5307470     3844.9172        1.49100
Hong Kong, China           Asia         2002   81.49500      6762476    30209.0152        1.49500
Congo, Dem. Rep.           Africa       2007   46.46200     64606759      277.5519        1.49600
Cote d'Ivoire              Africa       2007   48.32800     18013409     1544.7501        1.49600
Rwanda                     Africa       1957   41.50000      2822082      540.2894        1.50000
Rwanda                     Africa       1962   43.00000      3051242      597.4731        1.50000
Germany                    Europe       1977   72.50000     78160773    20512.9212        1.50000
Italy                      Europe       1982   74.98000     56535636    16537.4835        1.50000
Malaysia                   Asia         1987   69.50000     16331785     5249.8027        1.50000
Dominican Republic         Americas     1997   69.95700      7992357     3614.1013        1.50000
Czech Republic             Europe       2002   75.51000     10256295    17596.2102        1.50000
Equatorial Guinea          Africa       1957   35.98300       232922      426.0964        1.50100
Burundi                    Africa       1957   40.53300      2667518      379.5646        1.50200
Equatorial Guinea          Africa       1962   37.48500       249220      582.8420        1.50200
Equatorial Guinea          Africa       1967   38.98700       259864      915.5960        1.50200
Burundi                    Africa       1967   43.54800      3330989      412.9775        1.50300
Equatorial Guinea          Africa       1977   42.02400       192675      958.5668        1.50800
Congo, Dem. Rep.           Africa       1957   40.65200     15577932      905.8602        1.50900
Tanzania                   Africa       1967   45.75700     12607312      848.2187        1.51100
Burundi                    Africa       1962   42.04500      2961915      355.2032        1.51200
Iran                       Asia         2007   70.96400     69453570    11605.7145        1.51300
Mali                       Africa       1997   49.90300      9384984      790.2580        1.51500
Peru                       Americas     2007   71.42100     28674757     7408.9056        1.51500
Central African Republic   Africa       1982   48.29500      2476971      956.7530        1.52000
France                     Europe       1957   68.93000     44310863     8662.8349        1.52000
Peru                       Americas     2002   69.90600     26769436     5909.0201        1.52000
Syria                      Asia         2002   73.05300     17155814     4090.9253        1.52600
Equatorial Guinea          Africa       1972   40.51600       277603      672.4123        1.52900
Nepal                      Asia         1957   37.68600      9682338      597.9364        1.52900
Turkey                     Europe       1982   61.03600     47328791     4241.3563        1.52900
Slovenia                   Europe       2002   76.66000      2011497    20660.0194        1.53000
Afghanistan                Asia         1957   30.33200      9240934      820.8530        1.53100
Egypt                      Africa       2007   71.33800     80264543     5581.1810        1.53200
Liberia                    Africa       2002   43.75300      2814651      531.4824        1.53200
Chad                       Africa       1987   51.05100      5498955      952.3861        1.53400
Bolivia                    Americas     1962   43.42800      3593918     2180.9725        1.53800
Haiti                      Americas     1982   51.46100      5198399     2011.1595        1.53800
Iceland                    Europe       1992   78.77000       259012    25144.3920        1.54000
Hungary                    Europe       1967   69.50000     10223422     9326.6447        1.54000
Austria                    Europe       1977   72.17000      7568430    19749.4223        1.54000
Australia                  Oceania      2002   80.37000     19546792    30687.7547        1.54000
India                      Asia         1997   61.76500    959000000     1458.8174        1.54200
Somalia                    Africa       1987   44.50100      6921858     1093.2450        1.54600
Korea, Dem. Rep.           Asia         1987   70.64700     19067554     4106.4923        1.54700
Costa Rica                 Americas     1997   77.26000      3518107     6677.0453        1.54700
Morocco                    Africa       2007   71.16400     33757175     3820.1752        1.54900
Hungary                    Europe       1962   67.96000     10063000     7550.3599        1.55000
Israel                     Asia         1962   69.39000      2310904     7105.6307        1.55000
Hungary                    Europe       2002   72.59000     10083313    14843.9356        1.55000
Iceland                    Europe       2002   80.50000       288030    31163.2020        1.55000
Canada                     Americas     1982   75.76000     25201900    22898.7921        1.55000
Mali                       Africa       1967   38.48700      5212416      545.0099        1.55100
Lebanon                    Asia         1972   65.42100      2680018     7486.3843        1.55100
Djibouti                   Africa       1997   53.15700       417908     1895.0170        1.55300
Angola                     Africa       1977   39.48300      6162675     3008.6474        1.55500
Sierra Leone               Africa       2007   42.56800      6144562      862.5408        1.55600
China                      Asia         1982   65.52500   1000281000      962.4214        1.55764
Nigeria                    Africa       1962   39.36000     41871351     1150.9275        1.55800
Australia                  Oceania      1977   73.49000     14074100    18334.1975        1.56000
Greece                     Europe       1982   75.24000      9786480    15268.4209        1.56000
Japan                      Asia         1987   78.67000    122091325    22375.9419        1.56000
New Zealand                Oceania      2002   79.11000      3908037    23189.8014        1.56000
Burundi                    Africa       1982   47.47100      4580410      559.6032        1.56100
Sierra Leone               Africa       1987   40.00600      3868905     1294.4478        1.56100
Djibouti                   Africa       1992   51.60400       384156     2377.1562        1.56400
Sierra Leone               Africa       1997   39.89700      4578212      574.6482        1.56400
Swaziland                  Africa       1962   44.99200       370006     1856.1821        1.56800
Ghana                      Africa       2007   60.02200     22873338     1327.6089        1.56900
Taiwan                     Asia         1982   72.16000     18501390     7426.3548        1.57000
Singapore                  Asia         1972   69.52100      2152400     8597.7562        1.57500
Korea, Rep.                Asia         2007   78.62300     49044790    23348.1397        1.57800
France                     Europe       1962   70.51000     47124000    10560.4855        1.58000
Albania                    Europe       1987   72.00000      3075321     3738.9327        1.58000
Australia                  Oceania      1987   76.32000     16257249    21888.8890        1.58000
Sri Lanka                  Asia         2007   72.39600     20378239     3970.0954        1.58100
Benin                      Africa       1992   53.91900      4981671     1191.2077        1.58200
Haiti                      Americas     1997   56.67100      6913545     1341.7269        1.58200
Germany                    Europe       1957   69.10000     71019069    10187.8267        1.60000
Hong Kong, China           Asia         1977   73.60000      4583700    11186.1413        1.60000
Serbia                     Europe       1977   70.30000      8686367    12980.6696        1.60000
China                      Asia         2002   72.02800   1280400000     3119.2809        1.60200
Romania                    Europe       2002   71.32200     22404337     7885.3601        1.60200
Bolivia                    Americas     1967   45.03200      4040665     2586.8861        1.60400
Guinea-Bissau              Africa       1997   44.87300      1193708      796.6645        1.60700
Cote d'Ivoire              Africa       1982   53.98300      9025951     2602.7102        1.60900
Switzerland                Europe       1977   75.39000      6316424    26982.2905        1.61000
Czech Republic             Europe       1997   74.01000     10300707    16048.5142        1.61000
Singapore                  Asia         2002   78.77000      4197776    36023.1054        1.61200
Brazil                     Americas     2002   71.00600    179914212     8131.2128        1.61800
Ghana                      Africa       1967   48.07200      8490213     1125.6972        1.62000
Spain                      Europe       1972   73.06000     34513161    10638.7513        1.62000
New Zealand                Oceania      1982   73.84000      3210650    17632.4104        1.62000
Mali                       Africa       1957   35.30700      4241884      490.3822        1.62200
Iraq                       Asia         1982   62.03800     14173318    14517.9071        1.62500
Mali                       Africa       1962   36.93600      4690372      496.1743        1.62900
Ghana                      Africa       1957   44.77900      6391288     1043.5615        1.63000
Kuwait                     Asia         1977   69.34300      1140357    59265.4771        1.63100
Venezuela                  Americas     1987   70.19000     17910182     9883.5846        1.63300
Honduras                   Americas     2007   70.19800      7483763     3548.3308        1.63300
Chile                      Americas     1992   74.12600     13572994     7596.1260        1.63400
Philippines                Asia         1967   56.39300     35356600     1814.1274        1.63600
Zimbabwe                   Africa       1967   53.99500      4995432      569.7951        1.63700
Equatorial Guinea          Africa       1982   43.66200       285483      927.8253        1.63800
Zimbabwe                   Africa       1972   55.63500      5861135      799.3622        1.64000
Swaziland                  Africa       1967   46.63300       420690     2613.1017        1.64100
Guinea                     Africa       1972   38.84200      3811387      741.6662        1.64500
Burkina Faso               Africa       2007   52.29500     14326203     1217.0330        1.64500
Finland                    Europe       1977   72.52000      4738902    15605.4228        1.65000
Greece                     Europe       1962   69.51000      8448233     6017.1907        1.65000
Iceland                    Europe       1977   76.11000       221823    19654.9625        1.65000
Sierra Leone               Africa       1982   38.44500      3464522     1465.0108        1.65700
Colombia                   Americas     1972   61.62300     22542890     3264.6600        1.66000
Uganda                     Africa       1987   51.50900     15283050      617.7244        1.66000
Ireland                    Europe       2002   77.78300      3879155    34077.0494        1.66100
Afghanistan                Asia         1962   31.99700     10267083      853.1007        1.66500
India                      Asia         1992   60.22300    872000000     1164.4068        1.67000
Bangladesh                 Asia         1977   46.92300     80428306      659.8772        1.67100
Bolivia                    Americas     2007   65.55400      9119152     3822.1371        1.67100
Philippines                Asia         1972   58.06500     40850141     1989.3741        1.67200
Ghana                      Africa       1962   46.45200      7355248     1190.0411        1.67300
Nigeria                    Africa       1967   41.04000     47287752     1014.5141        1.68000
Bolivia                    Americas     1972   46.71400      4565872     2980.3313        1.68200
Portugal                   Europe       1957   61.51000      8817650     3774.5717        1.69000
Chile                      Americas     1997   75.81600     14599929    10118.0532        1.69000
Nigeria                    Africa       1977   44.51400     62209173     1981.9518        1.69300
Oman                       Asia         2002   74.19300      2713462    19774.8369        1.69400
Bahrain                    Asia         1987   70.75000       454612    18524.0241        1.69800
Afghanistan                Asia         2007   43.82800     31889923      974.5803        1.69900
Reunion                    Africa       1992   73.61500       622191     6101.2558        1.70200
Nepal                      Asia         1962   39.39300     10332057      652.3969        1.70700
Benin                      Africa       1982   50.90400      3641603     1277.8976        1.71400
Spain                      Europe       1957   66.66000     29841614     4564.8024        1.72000
Angola                     Africa       2007   42.73100     12420476     4797.2313        1.72800
Japan                      Asia         1982   77.11000    118454974    19384.1057        1.73000
China                      Asia         1997   70.42600   1230075000     2289.2341        1.73600
Cuba                       Americas     1997   76.15100     10983007     5431.9904        1.73700
Mali                       Africa       1977   41.71400      6491649      686.3953        1.73700
Mongolia                   Asia         1977   55.49100      1528000     1647.5117        1.73700
Philippines                Asia         2002   70.30300     82995088     2650.9211        1.73900
Taiwan                     Asia         2002   76.99000     22454239    23235.4233        1.74000
Venezuela                  Americas     1977   67.45600     13503563    13143.9510        1.74400
Comoros                    Africa       1957   42.46000       170928     1211.1485        1.74500
Zambia                     Africa       1967   47.76800      3900000     1777.0773        1.74500
China                      Asia         1987   67.27400   1084035000     1378.9040        1.74900
Spain                      Europe       1967   71.44000     32850275     7993.5123        1.75000
Jordan                     Asia         1997   69.77200      4526235     3645.3796        1.75700
Tanzania                   Africa       1957   42.97400      9452826      698.5356        1.75900
Austria                    Europe       1987   74.94000      7578903    23687.8261        1.76000
Poland                     Europe       1997   72.75000     38654957    10159.5837        1.76000
Saudi Arabia               Asia         1997   70.53300     21229759    20586.6902        1.76500
Ethiopia                   Africa       1987   46.68400     42999530      573.7413        1.76800
South Africa               Africa       1972   53.69600     23935810     7765.9626        1.76900
Mongolia                   Asia         2007   66.80300      2874127     3095.7723        1.77000
Ghana                      Africa       1992   57.50100     16278738      925.0602        1.77200
Lebanon                    Asia         1967   63.87000      2186894     6006.9830        1.77600
Botswana                   Africa       1967   53.29800       553541     1214.7093        1.77800
Mauritius                  Africa       1982   66.71100       992040     3688.0377        1.78100
Nigeria                    Africa       1972   42.82100     53740085     1698.3888        1.78100
Serbia                     Europe       1972   68.70000      8313288    10522.0675        1.78600
Chad                       Africa       1957   39.88100      2894855     1308.4956        1.78900
Panama                     Americas     1982   70.47200      2036305     7009.6016        1.79100
Pakistan                   Asia         2002   63.61000    153403524     2092.7124        1.79200
Mauritania                 Africa       1957   42.33800      1076852      846.1203        1.79500
Bangladesh                 Asia         1972   45.25200     70759295      630.2336        1.79900
Haiti                      Americas     1972   48.04200      4698301     1654.4569        1.79900
Singapore                  Asia         1987   73.56000      2794552    18861.5308        1.80000
Sao Tome and Principe      Africa       1982   60.35100        98593     1890.2181        1.80100
Ghana                      Africa       1972   49.87500      9354120     1178.2237        1.80300
Yemen, Rep.                Asia         1967   36.98400      6740785      862.4421        1.80400
Mexico                     Americas     1967   60.11000     47995559     5754.7339        1.81100
Sudan                      Africa       1992   53.55600     28227588     1492.1970        1.81200
Chad                       Africa       1977   47.38300      4388260     1133.9850        1.81400
Malawi                     Africa       1987   47.45700      7824747      635.5174        1.81500
Congo, Dem. Rep.           Africa       1977   47.80400     26480870      795.7573        1.81500
Sudan                      Africa       1997   55.37300     32160729     1632.2108        1.81700
Mauritania                 Africa       2002   62.24700      2828858     1579.0195        1.81700
India                      Asia         2007   64.69800   1110396331     2452.2104        1.81900
Italy                      Europe       1967   71.06000     52667100    10022.4013        1.82000
Bulgaria                   Europe       2002   72.14000      7661799     7696.7777        1.82000
Nicaragua                  Americas     1982   59.29800      2979423     3470.3382        1.82800
Gambia                     Africa       1962   33.89600       374020      599.6503        1.83100
South Africa               Africa       1977   55.52700     27129932     8028.6514        1.83100
Bolivia                    Americas     2002   63.88300      8445134     3413.2627        1.83300
Chad                       Africa       1962   41.71600      3150417     1389.8176        1.83500
Algeria                    Africa       2002   70.99400     31287142     5288.0404        1.84200
Egypt                      Africa       1972   51.13700     34807417     2024.0081        1.84400
Brazil                     Americas     1982   63.33600    128962939     7030.8359        1.84700
Chile                      Americas     1962   57.92400      7961258     4519.0943        1.85000
Hong Kong, China           Asia         1982   75.45000      5264500    14560.5305        1.85000
Bahrain                    Asia         1992   72.60100       529491    19035.5792        1.85100
Brazil                     Americas     1992   67.05700    155975974     6950.2830        1.85200
Burundi                    Africa       1977   45.91000      3834415      556.1033        1.85300
Ecuador                    Americas     2002   74.17300     12921234     5773.0445        1.86100
Guinea-Bissau              Africa       1982   39.32700       825987      838.1240        1.86200
Eritrea                    Africa       2002   55.24000      4414865      765.3500        1.86200
Tanzania                   Africa       1972   47.62000     14706593      915.9851        1.86300
Bangladesh                 Asia         1957   39.34800     51365468      661.6375        1.86400
Namibia                    Africa       1987   60.83500      1278184     3693.7313        1.86700
Bangladesh                 Asia         1962   41.21600     56839289      686.3416        1.86800
Brazil                     Americas     1987   65.20500    142938076     7807.0958        1.86900
Italy                      Europe       1957   67.81000     49182000     6248.6562        1.87000
Poland                     Europe       1962   67.64000     30329617     5338.7521        1.87000
Hungary                    Europe       1997   71.04000     10244684    11712.7768        1.87000
Brazil                     Americas     1972   59.50400    100840058     4985.7115        1.87200
Pakistan                   Asia         2007   65.48300    169270617     2605.9476        1.87300
Malawi                     Africa       1982   45.64200      6502825      632.8039        1.87500
Ghana                      Africa       1977   51.75600     10538093      993.2240        1.88100
Haiti                      Americas     1977   49.92300      4908554     1874.2989        1.88100
Equatorial Guinea          Africa       1992   47.54500       387838     1132.0550        1.88100
Chad                       Africa       1967   43.60100      3495967     1196.8106        1.88500
Zimbabwe                   Africa       1962   52.35800      4277736      527.2722        1.88900
Cambodia                   Asia         1992   55.80300     10150094      682.3032        1.88900
Taiwan                     Asia         1972   69.39000     15226039     4062.5239        1.89000
Colombia                   Americas     1997   70.31300     37657830     6117.3617        1.89200
Jamaica                    Americas     1967   67.51000      1861096     6124.7035        1.90000
Botswana                   Africa       1962   51.52000       512764      983.6540        1.90200
Cameroon                   Africa       1957   40.42800      5359923     1313.0481        1.90500
Honduras                   Americas     1992   66.39900      5077347     3081.6946        1.90700
Mauritania                 Africa       1962   44.24800      1146757     1055.8960        1.91000
Spain                      Europe       1982   76.30000     37983310    13926.1700        1.91000
Argentina                  Americas     1957   64.39900     19610538     6856.8562        1.91400
Nepal                      Asia         2002   61.34000     25873917     1057.2063        1.91400
Mali                       Africa       2002   51.81800     10580176      951.4098        1.91500
Mauritania                 Africa       2007   64.16400      3270065     1803.1515        1.91700
Iran                       Asia         1982   59.62000     43072751     7608.3346        1.91800
Guinea-Bissau              Africa       1987   41.24500       927524      736.4154        1.91800
Guinea                     Africa       1977   40.76200      4227026      874.6859        1.92000
Poland                     Europe       2002   74.67000     38625976    12002.2391        1.92000
Liberia                    Africa       2007   45.67800      3193942      414.5073        1.92500
Cuba                       Americas     1977   72.64900      9537988     6380.4950        1.92600
Chile                      Americas     1987   72.49200     12463354     5547.0638        1.92700
Peru                       Americas     1997   68.38600     24748122     5838.3477        1.92800
Congo, Dem. Rep.           Africa       1972   45.98900     23007669      904.8961        1.93300
Congo, Dem. Rep.           Africa       1967   44.05600     19941073      861.5932        1.93400
Dominican Republic         Americas     1982   63.72700      5968349     2861.0924        1.93900
Korea, Dem. Rep.           Asia         1982   69.10000     17647518     4106.5253        1.94100
Angola                     Africa       1972   37.92800      5894858     5473.2880        1.94300
Algeria                    Africa       1992   67.74400     26298373     5023.2166        1.94500
Zambia                     Africa       1962   46.02300      3421000     1452.7258        1.94600
Cambodia                   Asia         1957   41.36600      5322536      434.0383        1.94900
Mozambique                 Africa       1967   38.11300      8680909      566.6692        1.95200
Eritrea                    Africa       1972   44.14200      2260187      514.3242        1.95300
Morocco                    Africa       2002   69.61500     31167783     3258.4956        1.95500
Mexico                     Americas     1992   71.45500     88111030     9472.3843        1.95700
India                      Asia         1987   58.55300    788000000      976.5127        1.95700
Niger                      Africa       1987   44.55500      7332638      668.3000        1.95700
Japan                      Asia         1977   75.38000    113872473    16610.3770        1.96000
Gambia                     Africa       1967   35.85700       439593      734.7829        1.96100
Malawi                     Africa       1992   49.42000     10014249      563.2000        1.96300
Kuwait                     Asia         1982   71.30900      1497494    31354.0357        1.96600
South Africa               Africa       1962   49.95100     18356657     5768.7297        1.96600
Brazil                     Americas     1967   57.63200     88049823     3429.8644        1.96700
Chad                       Africa       1972   45.56900      3899068     1104.1040        1.96800
Poland                     Europe       1967   69.61000     31785378     6557.1528        1.97000
Madagascar                 Africa       1972   44.85100      7082430     1748.5630        1.97000
Tunisia                    Africa       1997   71.97300      9231669     4876.7986        1.97200
South Africa               Africa       1967   51.92700     20997321     7114.4780        1.97600
Central African Republic   Africa       1972   43.45700      1927260     1070.0133        1.97900
Madagascar                 Africa       1962   40.84800      5703324     1643.3871        1.98300
Angola                     Africa       1957   31.99900      4561361     3827.9405        1.98400
Angola                     Africa       1967   35.98500      5247469     5522.7764        1.98500
Brazil                     Americas     1977   61.48900    114313951     6660.1187        1.98500
Burkina Faso               Africa       1982   48.12200      6634596      807.1986        1.98500
Ghana                      Africa       1987   55.72900     14168101      847.0061        1.98500
Mauritius                  Africa       1977   64.93000       913025     3710.9830        1.98600
Sudan                      Africa       1967   42.85800     12716129     1687.9976        1.98800
Ghana                      Africa       1982   53.74400     11400338      876.0326        1.98800
Zimbabwe                   Africa       1987   62.35100      9216418      706.1573        1.98800
Japan                      Asia         1972   73.42000    107188273    14778.7864        1.99000
Ireland                    Europe       1957   68.90000      2878220     5599.0779        1.99000
Senegal                    Africa       1997   60.18700      9535314     1392.3683        1.99100
Cote d'Ivoire              Africa       1957   42.46900      3300000     1500.8959        1.99200
Comoros                    Africa       1987   54.92600       395114     1315.9808        1.99300
Comoros                    Africa       1982   52.93300       348643     1267.1001        1.99400
Comoros                    Africa       1977   50.93900       304739     1172.6030        1.99500
Philippines                Asia         1977   60.06000     46850962     2373.2043        1.99500
Somalia                    Africa       1967   38.97700      3428839     1284.7332        1.99600
Botswana                   Africa       1957   49.61800       474639      918.2325        1.99600
Gabon                      Africa       1957   38.99900       434904     4976.1981        1.99600
Somalia                    Africa       1972   40.97300      3840161     1254.5761        1.99600
Myanmar                    Asia         1982   58.05600     34680442      424.0000        1.99700
Mongolia                   Asia         1982   57.48900      1756032     2000.6031        1.99800
Somalia                    Africa       1957   34.97700      2780415     1258.1474        1.99900
Greece                     Europe       1957   67.86000      8096218     4916.2999        2.00000
Cambodia                   Asia         1967   45.41500      6960067      523.4323        2.00000
Hong Kong, China           Asia         1972   72.00000      4115700     8315.9281        2.00000
Central African Republic   Africa       1957   37.46400      1392284     1190.8443        2.00100
Angola                     Africa       1962   34.00000      4826015     4269.2767        2.00100
Malawi                     Africa       1977   43.76700      5637246      663.2237        2.00100
Equatorial Guinea          Africa       1987   45.66400       341244      966.8968        2.00200
Central African Republic   Africa       1967   41.47800      1733638     1136.0566        2.00300
Somalia                    Africa       1962   36.98100      3080153     1369.4883        2.00400
Comoros                    Africa       1967   46.47200       217378     1876.0296        2.00500
Comoros                    Africa       1962   44.46700       191689     1406.6483        2.00700
New Zealand                Oceania      1992   76.33000      3437674    18363.3249        2.01000
Turkey                     Europe       2002   70.84500     67308928     6508.0857        2.01000
Central African Republic   Africa       1962   39.47500      1523478     1193.0688        2.01100
Swaziland                  Africa       1957   43.42400       326741     1244.7084        2.01700
Zimbabwe                   Africa       1957   50.46900      3646340      518.7643        2.01800
Syria                      Asia         1962   50.30500      4834621     2193.0371        2.02100
Guinea-Bissau              Africa       1992   43.26600      1050938      745.5399        2.02100
Philippines                Asia         1982   62.08200     53456774     2603.2738        2.02200
Afghanistan                Asia         1967   34.02000     11537966      836.1971        2.02300
Cameroon                   Africa       1987   54.98500     10780667     2602.6642        2.02400
Mali                       Africa       1992   48.38800      8416215      739.0144        2.02400
Reunion                    Africa       1987   71.91300       562035     5303.3775        2.02800
Mauritius                  Africa       1987   68.74000      1042663     4783.5869        2.02900
Madagascar                 Africa       1977   46.88100      8007166     1544.2286        2.03000
Finland                    Europe       1982   74.55000      4826933    18533.1576        2.03000
Eritrea                    Africa       1967   42.18900      1820319      468.7950        2.03100
Madagascar                 Africa       1967   42.88100      6334556     1634.0473        2.03300
Burundi                    Africa       2002   47.36000      7021078      446.4035        2.03400
Ecuador                    Americas     1967   56.67800      5432424     4579.0742        2.03800
Zambia                     Africa       1957   44.07700      3016000     1311.9568        2.03900
Zimbabwe                   Africa       1977   57.67400      6642107      685.5877        2.03900
United States              Americas     1977   73.38000    220239000    24072.6321        2.04000
Mauritania                 Africa       1967   46.28900      1230542     1421.1452        2.04100
Chile                      Americas     2002   77.86000     15497046    10778.7838        2.04400
Cambodia                   Asia         1962   43.41500      6083619      496.9136        2.04900
Bangladesh                 Asia         2007   64.06200    150448339     1391.2538        2.04900
Senegal                    Africa       1957   39.32900      3054547     1567.6530        2.05100
Thailand                   Asia         2007   70.61600     65068149     7458.3963        2.05200
Sao Tome and Principe      Africa       1972   56.48000        76595     1532.9853        2.05500
Ethiopia                   Africa       1967   42.11500     27860297      516.1186        2.05600
Austria                    Europe       1962   69.54000      7129864    10750.7211        2.06000
Mozambique                 Africa       1997   46.34400     16603334      472.3461        2.06000
Indonesia                  Asia         2007   70.65000    223547000     3540.6516        2.06200
Nicaragua                  Americas     2007   72.89900      5675356     2749.3210        2.06300
Gambia                     Africa       1957   32.06500       323150      520.9267        2.06500
Afghanistan                Asia         1972   36.08800     13079460      739.9811        2.06800
Philippines                Asia         1987   64.15100     60017788     2189.6350        2.06900
Sao Tome and Principe      Africa       1977   58.55000        86796     1737.5617        2.07000
Turkey                     Europe       1987   63.10800     52881328     5089.0437        2.07200
Sri Lanka                  Asia         1967   64.26600     11737396     1135.5143        2.07400
Nepal                      Asia         1967   41.47200     11261690      676.4422        2.07900
Pakistan                   Asia         1987   58.24500    105186881     1704.6866        2.08700
Madagascar                 Africa       1982   48.96900      9171477     1302.8787        2.08800
Thailand                   Asia         1977   62.49400     44148285     1961.2246        2.08900
Bolivia                    Americas     1997   62.05000      7693188     3326.1432        2.09300
Mexico                     Americas     1987   69.49800     80122492     8688.1560        2.09300
Mauritania                 Africa       1997   60.43000      2444741     1483.1361        2.09700
Colombia                   Americas     1967   59.96300     19764027     2678.7298        2.10000
Lesotho                    Africa       1987   57.18000      1599200      773.9932        2.10200
Thailand                   Asia         1982   64.59700     48827160     2393.2198        2.10300
Philippines                Asia         1997   68.56400     75012988     2536.5349        2.10600
Guatemala                  Americas     1982   58.13700      6395630     4820.4948        2.10800
Senegal                    Africa       1967   43.56300      3965841     1612.4046        2.10900
Eritrea                    Africa       1962   40.15800      1666618      380.9958        2.11100
Pakistan                   Asia         1962   47.67000     53100671      803.3427        2.11300
Pakistan                   Asia         1977   54.04300     78152686     1175.9212        2.11400
Pakistan                   Asia         1982   56.15800     91462088     1443.4298        2.11500
Swaziland                  Africa       1987   57.67800       779348     3984.8398        2.11700
Ecuador                    Americas     1972   58.79600      6298651     5280.9947        2.11800
Eritrea                    Africa       1957   38.04700      1542611      344.1619        2.11900
Guatemala                  Americas     1957   44.14200      3640876     2617.1560        2.11900
Thailand                   Asia         1972   60.40500     39276153     1524.3589        2.12000
Pakistan                   Asia         1957   45.55700     46679944      747.0835        2.12100
Senegal                    Africa       1962   41.45400      3430243     1654.9887        2.12500
Guinea                     Africa       1982   42.89100      4710497      857.2504        2.12900
Benin                      Africa       1972   47.01400      2761407     1085.7969        2.12900
Pakistan                   Asia         1972   51.92900     69325921     1049.9390        2.12900
Pakistan                   Asia         1967   49.80000     60641899      942.4083        2.13000
Jordan                     Asia         1987   65.86900      2820042     4448.6799        2.13000
Chad                       Africa       1982   49.51700      4875118      797.9081        2.13400
Benin                      Africa       1957   40.35800      1925173      959.6011        2.13500
Botswana                   Africa       1987   63.62200      1151184     6205.8839        2.13800
Somalia                    Africa       2002   45.93600      7753310      882.0818        2.14100
Iran                       Asia         1962   49.32500     22874000     4187.3298        2.14400
Panama                     Americas     1972   66.21600      1616384     5364.2497        2.14500
Jordan                     Asia         1992   68.01500      3867409     3431.5936        2.14600
Singapore                  Asia         1967   67.94600      1977600     4977.4185        2.14800
Mauritania                 Africa       1972   48.43700      1332786     1586.8518        2.14800
Djibouti                   Africa       1977   46.51900       228694     3081.7610        2.15300
Korea, Rep.                Asia         1977   64.76600     36436000     4657.2210        2.15400
Cameroon                   Africa       1967   44.79900      6335506     1508.4531        2.15600
Dominican Republic         Americas     1977   61.78800      5302800     2681.9889        2.15700
Madagascar                 Africa       2007   59.44300     19167654     1044.7701        2.15700
Mauritius                  Africa       1962   60.24600       701016     2529.0675        2.15700
Czech Republic             Europe       1957   69.03000      9513758     8256.3439        2.16000
Myanmar                    Asia         2007   62.06900     47761980      944.0000        2.16100
Botswana                   Africa       1982   61.48400       970347     4551.1421        2.16500
Mozambique                 Africa       1977   42.49500     11127868      502.3197        2.16700
Haiti                      Americas     1987   53.63600      5756203     1823.0160        2.17500
Benin                      Africa       1977   49.19000      3168267     1029.1613        2.17600
Comoros                    Africa       2007   65.15200       710960      986.1479        2.17800
Gambia                     Africa       2002   58.04100      1457766      660.5856        2.18000
Egypt                      Africa       1977   53.31900     38783863     2785.4936        2.18200
Madagascar                 Africa       1957   38.86500      5181679     1589.2027        2.18400
Sudan                      Africa       2007   58.55600     42292929     2602.3950        2.18700
Mauritania                 Africa       1992   58.33300      2119465     1361.3698        2.18800
Central African Republic   Africa       1987   50.48500      2840009      844.8764        2.19000
Mali                       Africa       1982   43.91600      6998256      618.0141        2.20200
Portugal                   Europe       1967   66.60000      9103000     6361.5180        2.21000
Colombia                   Americas     1977   63.83700     25094412     3815.8079        2.21400
Cameroon                   Africa       1962   42.64300      5793633     1399.6074        2.21500
Mozambique                 Africa       1972   40.32800      9809596      724.9178        2.21500
Mexico                     Americas     1997   73.67000     95895146     9767.2975        2.21500
Burundi                    Africa       2007   49.58000      8390505      430.0707        2.22000
Guinea                     Africa       2002   53.67600      8807818      945.5836        2.22100
Ethiopia                   Africa       2007   52.94700     76511887      690.8056        2.22200
Somalia                    Africa       2007   48.15900      9118773      926.1411        2.22300
Thailand                   Asia         1967   58.28500     34024249     1295.4607        2.22400
Sudan                      Africa       1972   45.08300     14597019     1659.6528        2.22500
Singapore                  Asia         1992   75.78800      3235865    24769.8912        2.22800
Equatorial Guinea          Africa       2007   51.57900       551201    12154.0897        2.23100
Venezuela                  Americas     1972   65.71200     11515649    10505.2597        2.23300
Bangladesh                 Asia         1967   43.45300     62821884      721.1861        2.23700
Turkey                     Europe       1967   54.33600     33411317     2826.3564        2.23800
Malaysia                   Asia         1977   65.25600     12845381     3827.9216        2.24600
Cameroon                   Africa       1972   47.04900      7021028     1684.1465        2.25000
Mexico                     Americas     1972   62.36100     55984294     6809.4067        2.25100
Senegal                    Africa       1972   45.81500      4588696     1597.7121        2.25200
Panama                     Americas     1967   64.07100      1405486     4421.0091        2.25400
Benin                      Africa       1962   42.61800      2151895      949.4991        2.26000
Benin                      Africa       1967   44.88500      2427334     1035.8314        2.26700
Morocco                    Africa       1997   67.66000     28529501     2982.1019        2.26700
Syria                      Asia         1992   69.24900     13219062     3340.5428        2.27500
Syria                      Asia         1997   71.52700     15081016     4014.2390        2.27800
Malawi                     Africa       1972   41.76600      4730997      584.6220        2.27900
Slovenia                   Europe       1957   67.85000      1533070     5862.2766        2.28000
Montenegro                 Europe       1962   63.72800       474528     4649.5938        2.28000
Montenegro                 Europe       1957   61.44800       442829     3682.2599        2.28400
Yemen, Rep.                Asia         2002   60.30800     18701257     2234.8208        2.28800
Guatemala                  Americas     1977   56.02900      5703430     4879.9927        2.29100
Djibouti                   Africa       1972   44.36600       178848     3694.2124        2.29200
Djibouti                   Africa       1982   48.81200       305991     2879.4681        2.29300
Bahrain                    Asia         1977   65.59300       297410    19340.1020        2.29300
Tanzania                   Africa       1977   49.91900     17129565      962.4923        2.29900
Taiwan                     Asia         1967   67.50000     13648692     2643.8587        2.30000
Iran                       Asia         1997   68.04200     63327987     8263.5903        2.30000
Egypt                      Africa       1967   49.29300     31681188     1814.8807        2.30100
Cameroon                   Africa       1977   49.35500      7959865     1783.4329        2.30600
Philippines                Asia         1992   66.45800     67185766     2279.3240        2.30700
Madagascar                 Africa       2002   57.28600     16473477      894.6371        2.30800
Iran                       Asia         1957   47.18100     19792000     3290.2576        2.31200
Comoros                    Africa       2002   62.97400       614382     1075.8116        2.31400
Nicaragua                  Americas     1977   57.47000      2554598     5486.3711        2.31900
Dominican Republic         Americas     1987   66.04600      6655297     2899.8422        2.31900
Benin                      Africa       2007   56.72800      8078314     1441.2849        2.32200
Peru                       Americas     1992   66.45800     22430449     4446.3809        2.32400
Guinea                     Africa       2007   56.00700      9947814      942.6542        2.33100
Brazil                     Americas     1997   69.38800    168546719     7957.9808        2.33100
Zambia                     Africa       1972   50.10700      4506497     1773.4983        2.33900
Vietnam                    Asia         2002   73.01700     80908147     1764.4567        2.34500
Peru                       Americas     1967   51.44500     12132200     5788.0933        2.34900
Hong Kong, China           Asia         1967   70.00000      3722800     6197.9628        2.35000
Afghanistan                Asia         1977   38.43800     14880372      786.1134        2.35000
El Salvador                Americas     1972   58.20700      3790903     4520.2460        2.35200
Congo, Rep.                Africa       2007   55.32200      3800610     3632.5578        2.35200
Mongolia                   Asia         1997   63.62500      2494803     1902.2521        2.35400
Korea, Rep.                Asia         1982   67.12300     39326000     5622.9425        2.35700
Croatia                    Europe       1962   67.13000      4076557     5477.8900        2.36000
Portugal                   Europe       1982   72.77000      9859650    11753.8429        2.36000
Peru                       Americas     1957   46.26300      9146100     4245.2567        2.36100
Djibouti                   Africa       1962   39.69300        89898     3020.9893        2.36500
Reunion                    Africa       1957   55.09000       308700     2769.4518        2.36600
Brazil                     Americas     1957   53.28500     65551171     2487.3660        2.36800
Niger                      Africa       2007   56.86700     12894865      619.6769        2.37100
Mexico                     Americas     1982   67.40500     71640904     9611.1475        2.37300
Congo, Dem. Rep.           Africa       2002   44.96600     55379852      241.1659        2.37900
Hungary                    Europe       1957   66.41000      9839000     6040.1800        2.38000
Brazil                     Americas     1962   55.66500     76039390     3336.5858        2.38000
Djibouti                   Africa       1967   42.07400       127617     3020.0505        2.38100
Mozambique                 Africa       1962   36.16100      7788944      556.6864        2.38200
Ecuador                    Americas     1992   69.61300     10748394     7103.7026        2.38200
Serbia                     Europe       1967   66.91400      7971222     7991.7071        2.38300
Syria                      Asia         1987   66.97400     11242847     3116.7743        2.38400
India                      Asia         1982   56.59600    708000000      855.7235        2.38800
Yemen, Rep.                Asia         2007   62.69800     22211743     2280.7699        2.39000
Korea, Rep.                Asia         2002   77.04500     47969150    19233.9882        2.39800
Hong Kong, China           Asia         1997   80.00000      6495918    28377.6322        2.39900
Trinidad and Tobago        Americas     1977   68.30000      1039009     7899.5542        2.40000
Syria                      Asia         1957   48.28400      4149908     2117.2349        2.40100
Korea, Rep.                Asia         1997   74.64700     46173816    15993.5280        2.40300
Romania                    Europe       1972   69.21000     20662648     8011.4144        2.41000
Bosnia and Herzegovina     Europe       1977   69.86000      4086000     3528.4813        2.41000
Nicaragua                  Americas     2002   70.83600      5146848     2474.5488        2.41000
Dominican Republic         Americas     1992   68.45700      7351181     3044.2142        2.41100
Morocco                    Africa       1967   50.33500     14770296     1711.0448        2.41100
Mauritania                 Africa       1977   50.85200      1456688     1497.4922        2.41500
Kenya                      Africa       1957   44.68600      7454779      944.4383        2.41600
Vietnam                    Asia         1972   50.25400     44655014      699.5016        2.41600
Libya                      Africa       1967   50.22700      1759224    18772.7517        2.41900
Cote d'Ivoire              Africa       1967   47.35000      4744870     2052.0505        2.42000
Yemen, Rep.                Asia         1997   58.02000     15826497     2117.4845        2.42100
Korea, Rep.                Asia         1967   57.71600     30131000     2029.2281        2.42400
Costa Rica                 Americas     1972   67.84900      1834796     5118.1469        2.42500
Senegal                    Africa       1992   58.19600      8307920     1367.8994        2.42700
Montenegro                 Europe       1977   73.06600       560073     9595.9299        2.43000
Thailand                   Asia         1962   56.06100     29263397     1002.1992        2.43100
Cuba                       Americas     1972   70.72300      8831348     5305.4453        2.43300
Korea, Rep.                Asia         1992   72.24400     43805450    12104.2787        2.43400
Kuwait                     Asia         1962   60.47000       358266    95458.1118        2.43700
Lesotho                    Africa       1977   52.20800      1251524      745.3695        2.44100
Nepal                      Asia         2007   63.78500     28901790     1091.3598        2.44500
Mali                       Africa       1987   46.36400      7634008      684.1716        2.44800
Indonesia                  Asia         1957   39.91800     90124000      858.9003        2.45000
Israel                     Asia         1957   67.84000      1944401     5385.2785        2.45000
Cote d'Ivoire              Africa       1972   49.80100      6071696     2378.2011        2.45100
Gambia                     Africa       1972   38.30800       517101      756.0868        2.45100
West Bank and Gaza         Asia         1962   48.12700      1133134     2198.9563        2.45600
Jordan                     Asia         1962   48.12600       933559     2348.0092        2.45700
Cote d'Ivoire              Africa       1962   44.93000      3832408     1728.8694        2.46100
Panama                     Americas     1977   68.68100      1839782     5351.9121        2.46500
Iran                       Asia         1977   57.70200     35480679    11888.5951        2.46800
Kuwait                     Asia         1957   58.03300       212846   113523.1329        2.46800
Japan                      Asia         1957   65.50000     91563009     4317.6944        2.47000
Comoros                    Africa       1972   48.94400       250027     1937.5777        2.47200
Saudi Arabia               Asia         1992   68.76800     16945857    24841.6178        2.47300
Tunisia                    Africa       1967   52.05300      4786986     1932.3602        2.47400
Sao Tome and Principe      Africa       1957   48.94500        61325      860.7369        2.47400
Vietnam                    Asia         1957   42.88700     28998543      676.2854        2.47500
Vietnam                    Asia         1967   47.83800     39463910      637.1233        2.47500
Vietnam                    Asia         1962   45.36300     33796140      772.0492        2.47600
Tunisia                    Africa       1962   49.57900      4286552     1660.3032        2.47900
Iraq                       Asia         1972   56.95000     10061506     9576.0376        2.49100
Mozambique                 Africa       1957   33.77900      7038035      495.5868        2.49300
Nepal                      Asia         1972   43.97100     12412593      674.7881        2.49900
Iraq                       Asia         2007   59.54500     27499638     4471.0619        2.49900
Tunisia                    Africa       1957   47.10000      3950849     1395.2325        2.50000
Morocco                    Africa       1962   47.92400     13056604     1566.3535        2.50100
Mongolia                   Asia         1972   53.75400      1320500     1421.7420        2.50100
Oman                       Asia         1957   40.08000       561977     2242.7466        2.50200
Turkey                     Europe       1977   59.50700     42404033     4269.1223        2.50200
Lesotho                    Africa       1992   59.68500      1803195      977.4863        2.50500
Jordan                     Asia         1957   45.66900       746559     1886.0806        2.51100
West Bank and Gaza         Asia         1957   45.67100      1070439     1827.0677        2.51100
Ecuador                    Americas     1977   61.31000      7278866     6679.6233        2.51400
Djibouti                   Africa       1957   37.32800        71851     2864.9691        2.51600
Libya                      Africa       1962   47.80800      1441863     6757.0308        2.51900
Libya                      Africa       1992   68.75500      4364501     9640.1385        2.52100
Morocco                    Africa       1972   52.86200     16660670     1930.1950        2.52700
Namibia                    Africa       1982   58.96800      1099010     4191.1005        2.53100
Sao Tome and Principe      Africa       1967   54.42500        70787     1384.8406        2.53200
Sudan                      Africa       1982   50.33800     20367053     1895.5441        2.53800
Indonesia                  Asia         1992   62.68100    184816000     2383.1409        2.54400
Burkina Faso               Africa       1977   46.13700      5889574      743.3870        2.54600
Libya                      Africa       1972   52.77300      2183877    21011.4972        2.54600
Mauritania                 Africa       1987   56.14500      1841240     1421.6036        2.54600
Indonesia                  Asia         2002   68.58800    211060000     2873.9129        2.54700
Egypt                      Africa       1962   46.99200     28173309     1693.3359        2.54800
Morocco                    Africa       1957   45.42300     11406350     1642.0023        2.55000
Egypt                      Africa       1957   44.44400     25009741     1458.9153        2.55100
Eritrea                    Africa       1987   46.45300      2915959      521.1341        2.56300
Libya                      Africa       1957   45.28900      1201578     3448.2844        2.56600
Namibia                    Africa       1977   56.43700       977026     3876.4860        2.57000
Cote d'Ivoire              Africa       1977   52.37400      7459574     2517.7365        2.57300
Korea, Dem. Rep.           Asia         1962   56.65600     10917494     1621.6936        2.57500
Reunion                    Africa       1962   57.66600       358900     3173.7233        2.57600
Costa Rica                 Americas     1967   65.42400      1588717     4161.7278        2.58200
Nicaragua                  Americas     1997   68.42600      4609572     2253.0230        2.58300
Togo                       Africa       1982   55.47100      2644765     1344.5780        2.58400
Ethiopia                   Africa       1957   36.66700     22815614      378.9042        2.58900
Egypt                      Africa       2002   69.80600     73312559     4754.6044        2.58900
Guatemala                  Americas     1992   63.37300      8486949     4439.4508        2.59100
Uganda                     Africa       1957   42.57100      6675501      774.3711        2.59300
Pakistan                   Asia         1992   60.83800    120065004     1971.8295        2.59300
Kenya                      Africa       1977   56.15500     14500404     1267.6132        2.59600
Chile                      Americas     1967   60.52300      8858908     5106.6543        2.59900
Indonesia                  Asia         1962   42.51800     99028000      849.2898        2.60000
Bangladesh                 Asia         2002   62.01300    135656790     1136.3904        2.60100
Jordan                     Asia         1982   63.73900      2347031     4161.4160        2.60500
Lebanon                    Asia         1962   62.09400      1886848     5714.5606        2.60500
Algeria                    Africa       1957   45.68500     10270856     3013.9760        2.60800
Kenya                      Africa       1982   58.76600     17661452     1348.2258        2.61100
Korea, Rep.                Asia         1962   55.29200     26420307     1536.3444        2.61100
Togo                       Africa       1957   41.20800      1357445      925.9083        2.61200
Panama                     Americas     1962   61.81700      1215725     3536.5403        2.61600
Algeria                    Africa       1962   48.30300     11000948     2550.8169        2.61800
Singapore                  Asia         1962   65.79800      1750200     3674.7356        2.61900
South Africa               Africa       1982   58.16100     31140029     8568.2662        2.63400
West Bank and Gaza         Asia         1987   67.04600      1691210     5107.1974        2.64000
Guatemala                  Americas     1987   60.78200      7326406     4246.4860        2.64500
Mali                       Africa       2007   54.46700     12031795     1042.5816        2.64900
Haiti                      Americas     1967   46.24300      4318137     1452.0577        2.65300
Guatemala                  Americas     2002   68.97800     11178650     4858.3475        2.65600
Bosnia and Herzegovina     Europe       1972   67.45000      3819000     2860.1698        2.66000
Portugal                   Europe       1972   69.26000      8970450     9022.2474        2.66000
Guinea                     Africa       1987   45.55200      5650262      805.5725        2.66100
Turkey                     Europe       1972   57.00500     37492953     3450.6964        2.66900
Mexico                     Americas     1977   65.03200     63759976     7674.9291        2.67100
West Bank and Gaza         Asia         1992   69.71800      2104779     6017.6548        2.67200
South Africa               Africa       1987   60.83400     35933379     7825.8234        2.67300
Yemen, Rep.                Asia         1992   55.59900     13367997     1879.4967        2.67700
Egypt                      Africa       1982   56.00600     45681811     3503.7296        2.68700
Korea, Rep.                Asia         1987   69.81000     41622000     8533.0888        2.68700
Turkey                     Europe       1997   68.83500     63047647     6601.4299        2.68900
Zimbabwe                   Africa       1982   60.36300      7636524      788.8550        2.68900
Ecuador                    Americas     1997   72.31200     11911819     7429.4559        2.69900
Trinidad and Tobago        Americas     1957   61.80000       764900     4100.3934        2.70000
Lesotho                    Africa       1962   47.74700       893143      411.8006        2.70000
Romania                    Europe       1962   66.80000     18680721     4734.9976        2.70000
Japan                      Asia         1967   71.43000    100825279     9847.7886        2.70000
Costa Rica                 Americas     1982   73.45000      2424367     5262.7348        2.70000
Albania                    Europe       2002   75.65100      3508512     4604.2117        2.70100
Iran                       Asia         1992   65.74200     60397973     7235.6532        2.70200
Kenya                      Africa       1967   50.65400     10191512     1056.7365        2.70500
Bolivia                    Americas     1992   59.95700      6893451     2961.6997        2.70600
Uganda                     Africa       1967   48.05100      8900294      908.9185        2.70700
Namibia                    Africa       1972   53.86700       821782     3746.0809        2.70800
Venezuela                  Americas     1967   63.47900      9709552     9541.4742        2.70900
Nicaragua                  Americas     1987   62.00800      3344353     2955.9844        2.71000
Togo                       Africa       1962   43.92200      1528098     1067.5348        2.71400
Morocco                    Africa       1992   65.39300     25798239     2948.0473        2.71600
Sudan                      Africa       1977   47.80000     17104986     2202.9884        2.71700
Comoros                    Africa       1997   60.66000       527982     1173.6182        2.72100
Botswana                   Africa       1972   56.02400       619351     2263.6111        2.72600
Peru                       Americas     1987   64.13400     20195924     6360.9434        2.72800
Mongolia                   Asia         1987   60.22200      2015133     2338.0083        2.73300
El Salvador                Americas     1997   69.53500      5783439     5154.8255        2.73700
Malaysia                   Asia         1982   68.00000     14441916     4920.3560        2.74400
Colombia                   Americas     1962   57.86300     17009885     2492.3511        2.74500
Mauritania                 Africa       1982   53.59900      1622136     1481.1502        2.74700
Honduras                   Americas     1957   44.66500      1770390     2220.4877        2.75300
Madagascar                 Africa       1997   54.97800     14165114      986.2959        2.76400
Iran                       Asia         1972   55.23400     30614000     9613.8186        2.76500
Namibia                    Africa       1967   51.15900       706640     3793.6948        2.77300
Uganda                     Africa       1962   45.34400      7688797      767.2717        2.77300
Nepal                      Asia         1977   46.74800     13933198      694.1124        2.77700
Haiti                      Americas     2007   60.91600      8502814     1201.6372        2.77900
Thailand                   Asia         1957   53.63000     25041917      793.5774        2.78200
Singapore                  Asia         1957   63.17900      1445929     2843.1044        2.78300
Reunion                    Africa       1977   67.06400       492095     4319.8041        2.79000
Eritrea                    Africa       2007   58.04000      4906585      641.3695        2.80000
Taiwan                     Asia         1962   65.20000     11918938     1822.8790        2.80000
Libya                      Africa       1997   71.55500      4759670     9467.4461        2.80000
Sri Lanka                  Asia         1982   68.75700     15410151     1648.0798        2.80800
Bangladesh                 Asia         1987   52.81900    103764241      751.9794        2.81000
Guatemala                  Americas     1962   46.95400      4208858     2750.3644        2.81200
Costa Rica                 Americas     1962   62.84200      1345187     3460.9370        2.81600
Colombia                   Americas     1982   66.65300     27764644     4397.5757        2.81600
Venezuela                  Americas     1957   57.90700      6702668     9802.4665        2.81900
Costa Rica                 Americas     1957   60.02600      1112300     2990.0108        2.82000
Reunion                    Africa       1982   69.88500       517810     5267.2194        2.82100
Rwanda                     Africa       2007   46.24200      8860588      863.0885        2.82900
Peru                       Americas     1962   49.09600     10516500     4957.0380        2.83300
Niger                      Africa       1992   47.39100      8392818      581.1827        2.83600
Serbia                     Europe       1962   64.53100      7616060     6289.6292        2.84600
Nepal                      Asia         1982   49.59400     15796314      718.3731        2.84600
Tunisia                    Africa       1987   66.89400      7724976     3810.4193        2.84600
Togo                       Africa       1967   46.76900      1735550     1477.5968        2.84700
Bosnia and Herzegovina     Europe       1967   64.79000      3585000     2172.3524        2.86000
Puerto Rico                Americas     2002   77.77800      3859606    18855.6062        2.86100
Venezuela                  Americas     1962   60.77000      8143375     8422.9742        2.86300
Yemen, Rep.                Asia         1972   39.84800      7407075     1265.0470        2.86400
Madagascar                 Africa       1992   52.21400     12210395     1040.6762        2.86400
Kuwait                     Asia         1987   74.17400      1891487    28118.4300        2.86500
Tanzania                   Africa       2007   52.51700     38139640     1107.4822        2.86600
Congo, Rep.                Africa       1972   54.90700      1340458     3213.1527        2.86700
Morocco                    Africa       1977   55.73000     18396941     2370.6200        2.86800
Lesotho                    Africa       1982   55.07800      1411807      797.2631        2.87000
India                      Asia         1957   40.24900    409000000      590.0620        2.87600
Reunion                    Africa       1967   60.54200       414024     4021.1757        2.87600
Guinea                     Africa       1997   51.45500      8048834      869.4498        2.87900
Slovak Republic            Europe       1962   70.33000      4237384     7481.1076        2.88000
Portugal                   Europe       1962   64.39000      9019800     4727.9549        2.88000
Dominican Republic         Americas     1972   59.63100      4671329     2189.8745        2.88000
Burkina Faso               Africa       1967   40.69700      5127935      794.8266        2.88300
Honduras                   Americas     1967   50.92400      2500689     2538.2694        2.88300
Ecuador                    Americas     1987   67.23100      9545158     6481.7770        2.88900
Bahrain                    Asia         1957   53.83200       138655    11635.7995        2.89300
Burkina Faso               Africa       1972   43.59100      5433886      854.7360        2.89400
Haiti                      Americas     1962   43.59000      3880130     1796.5890        2.89400
Bulgaria                   Europe       1962   69.51000      8012946     4254.3378        2.90000
Hong Kong, China           Asia         1962   67.65000      3305200     4692.6483        2.90000
Costa Rica                 Americas     1977   70.75000      2108457     5926.8770        2.90100
Cuba                       Americas     1957   62.32500      6640752     6092.1744        2.90400
Kenya                      Africa       1972   53.55900     12044785     1222.3600        2.90500
Burkina Faso               Africa       1962   37.81400      4919632      722.5120        2.90800
Lesotho                    Africa       1957   45.04700       813338      335.9971        2.90900
Chile                      Americas     1972   63.44100      9717524     5494.0244        2.91800
Swaziland                  Africa       1972   49.55200       480105     3364.8366        2.91900
Cuba                       Americas     1962   65.24600      7254373     5180.7559        2.92100
Burkina Faso               Africa       1957   34.90600      4713416      617.1835        2.93100
Congo, Rep.                Africa       1957   45.05300       940458     2315.0566        2.94200
Nepal                      Asia         1987   52.53700     17917180      775.6325        2.94300
Sao Tome and Principe      Africa       1962   51.89300        65345     1071.5511        2.94800
Guatemala                  Americas     1997   66.32200      9803875     4684.3138        2.94900
Cambodia                   Asia         1987   53.91400      8371791      683.8956        2.95700
Peru                       Americas     1982   61.40600     18125129     6434.5018        2.95900
Honduras                   Americas     1972   53.88400      2965146     2529.8423        2.96000
Uganda                     Africa       1972   51.01600     10190285      950.7359        2.96500
Cambodia                   Asia         2007   59.72300     14131858     1713.7787        2.97100
South Africa               Africa       1957   47.98500     16151549     5487.1042        2.97600
Swaziland                  Africa       1977   52.53700       551425     3781.4106        2.98500
Myanmar                    Asia         1977   56.05900     31528087      371.0000        2.98900
Togo                       Africa       1972   49.75900      2056351     1649.6602        2.99000
Saudi Arabia               Asia         1957   42.86800      4419650     8157.5912        2.99300
Ecuador                    Americas     1957   51.35600      4058385     3780.5467        2.99900
Peru                       Americas     1977   58.44700     15990099     6281.2909        2.99900
Jamaica                    Americas     1962   65.61000      1665128     5246.1075        3.00000
Bahrain                    Asia         1967   59.92300       202182    14804.6727        3.00000
Iraq                       Asia         1967   54.45900      8519282     8931.4598        3.00200
Mongolia                   Asia         1967   51.25300      1149500     1226.0411        3.00200
Mongolia                   Asia         1962   48.25100      1010280     1056.3540        3.00300
Mongolia                   Asia         1957   45.24800       882134      912.6626        3.00400
Iraq                       Asia         1987   65.04400     16543189    11643.5727        3.00600
Vietnam                    Asia         1997   70.67200     76048996     1385.8968        3.01000
Comoros                    Africa       1992   57.93900       454429     1246.9074        3.01300
Iraq                       Asia         1962   51.45700      7240260     8341.7378        3.02000
Swaziland                  Africa       1982   55.56100       649901     3895.3840        3.02400
Guinea                     Africa       1992   48.57600      6990574      794.3484        3.02400
Morocco                    Africa       1987   62.67700     22987397     2755.0470        3.02700
Spain                      Europe       1962   69.69000     31158061     5693.8439        3.03000
Ecuador                    Americas     1982   64.34200      8365850     7213.7913        3.03200
Turkey                     Europe       1992   66.14600     58179144     5678.3483        3.03800
Cuba                       Americas     1967   68.29000      8139332     5690.2680        3.04400
Saudi Arabia               Asia         1962   45.91400      4943029    11626.4197        3.04600
Romania                    Europe       1957   64.10000     17829327     3943.3702        3.05000
Vietnam                    Asia         1982   58.81600     56142181      707.2358        3.05200
Guatemala                  Americas     1967   50.01600      4690773     3242.5311        3.06200
Senegal                    Africa       1977   48.87900      5260855     1561.7691        3.06400
Oman                       Asia         1962   43.16500       628164     2924.6381        3.08500
Bangladesh                 Asia         1982   50.00900     93074406      676.9819        3.08600
Kuwait                     Asia         1972   67.71200       841934   109347.8670        3.08800
Slovak Republic            Europe       1957   67.45000      3844277     6093.2630        3.09000
Bahrain                    Asia         1962   56.92300       171863    12753.2751        3.09100
Trinidad and Tobago        Americas     1962   64.90000       887498     4997.5240        3.10000
Algeria                    Africa       1967   51.40700     12760499     3246.9918        3.10400
Tunisia                    Africa       1992   70.00100      8523077     4332.7202        3.10700
Mexico                     Americas     1962   58.29900     41121485     4581.6094        3.10900
Algeria                    Africa       1972   54.51800     14760787     4182.6638        3.11100
Haiti                      Americas     1957   40.69600      3507701     1726.8879        3.11700
Iraq                       Asia         1957   48.43700      6248643     6229.3336        3.11700
Nicaragua                  Americas     1957   45.43200      1358828     3457.4159        3.11800
Kenya                      Africa       2007   54.11000     35610177     1463.2493        3.11800
Togo                       Africa       1977   52.88700      2308582     1532.7770        3.12800
Iran                       Asia         1967   52.46900     26538000     5906.7318        3.14400
Namibia                    Africa       1962   48.38600       621392     3173.2156        3.16000
Korea, Dem. Rep.           Asia         1977   67.15900     16325320     4106.3012        3.17600
Niger                      Africa       2002   54.49600     11140655      601.0745        3.18300
Nepal                      Asia         1992   55.72700     20326209      897.7404        3.19000
Zambia                     Africa       2007   42.38400     11746035     1271.2116        3.19100
Bangladesh                 Asia         1992   56.01800    113704579      837.8102        3.19900
Nicaragua                  Americas     1962   48.63200      1590597     3634.3644        3.20000
Myanmar                    Asia         1962   45.10800     23634436      388.0000        3.20300
Gambia                     Africa       1997   55.86100      1235767      653.7302        3.21700
Japan                      Asia         1962   68.73000     95831757     6576.6495        3.23000
Uganda                     Africa       2002   47.81300     24739869      927.7210        3.23500
Indonesia                  Asia         1972   49.20300    121282000     1111.1079        3.23900
Nicaragua                  Americas     1967   51.88400      1865490     4643.3935        3.25200
Kenya                      Africa       1962   47.94900      8678557      896.9664        3.26300
Nicaragua                  Americas     1972   55.15100      2182908     4688.5933        3.26700
Saudi Arabia               Asia         1987   66.29500     14619745    21198.2614        3.28300
Ecuador                    Americas     1962   54.64000      4681707     4086.1141        3.28400
Korea, Dem. Rep.           Asia         1967   59.94200     12617009     2143.5406        3.28600
Dominican Republic         Americas     1967   56.75100      4049146     1653.7230        3.29200
Malawi                     Africa       2007   48.30300     13327079      759.3499        3.29400
Botswana                   Africa       1977   59.31900       781472     3214.8578        3.29500
El Salvador                Americas     1957   48.57000      2355805     3421.5232        3.30800
Bolivia                    Americas     1977   50.02300      5079716     3548.0978        3.30900
Central African Republic   Africa       1977   46.77500      2167533     1109.3743        3.31800
Syria                      Asia         1967   53.65500      5680812     1881.9236        3.35000
Algeria                    Africa       1982   61.36800     20033753     5745.1602        3.35400
India                      Asia         1962   43.60500    454000000      658.3472        3.35600
Indonesia                  Asia         1997   66.04100    199278000     3119.3356        3.36000
Honduras                   Americas     1962   48.04100      2090162     2291.1568        3.37600
Bahrain                    Asia         1972   63.30000       230800    18268.6584        3.37700
Gambia                     Africa       1992   52.64400      1025384      665.6244        3.37900
Congo, Rep.                Africa       1962   48.43500      1047924     2464.7832        3.38200
Eritrea                    Africa       1997   53.37800      4058319      913.4708        3.38700
Senegal                    Africa       1987   55.76900      7171347     1441.7207        3.39000
Ethiopia                   Africa       1962   40.05900     25145372      419.4564        3.39200
Bolivia                    Americas     1987   57.25100      6156369     2753.6915        3.39200
Bangladesh                 Asia         1997   59.41200    123315288      972.7700        3.39400
Syria                      Asia         1982   64.59000      9410494     3761.8377        3.39500
Iran                       Asia         1987   63.04000     51889696     6642.8814        3.42000
Philippines                Asia         1962   54.75700     30325264     1649.5522        3.42300
Indonesia                  Asia         1967   45.96400    109343000      762.4318        3.44600
Montenegro                 Europe       1967   67.17800       501035     5907.8509        3.45000
Indonesia                  Asia         1982   56.15900    153343000     1516.8730        3.45700
Montenegro                 Europe       1972   70.63600       527678     7778.4140        3.45800
India                      Asia         1972   50.65100    567000000      724.0325        3.45800
Bahrain                    Asia         1982   69.05200       377967    19211.1473        3.45900
Iraq                       Asia         1977   60.41300     11882916    14688.2351        3.46300
Oman                       Asia         1992   71.19700      1915208    18616.7069        3.46300
Bosnia and Herzegovina     Europe       1962   61.93000      3349000     1709.6837        3.48000
Algeria                    Africa       1977   58.01400     17152804     4910.4168        3.49600
Zimbabwe                   Africa       2007   43.48700     12311143      469.7093        3.49800
Indonesia                  Asia         1977   52.70200    136725000     1382.7021        3.49900
Senegal                    Africa       1982   52.37900      6147783     1518.4800        3.50000
Namibia                    Africa       1957   45.22600       548080     2621.4481        3.50100
Jordan                     Asia         1967   51.62900      1255058     2741.7963        3.50300
West Bank and Gaza         Asia         1967   51.63100      1142636     2649.7150        3.50400
Honduras                   Americas     1982   60.90900      3669448     3121.7608        3.50700
Chile                      Americas     1982   70.56500     11487112     5095.6657        3.51300
Honduras                   Americas     1977   57.40200      3055235     3203.2081        3.51800
Gambia                     Africa       1977   41.84200       608274      884.7553        3.53400
Eritrea                    Africa       1992   49.99100      3668440      582.8585        3.53800
Egypt                      Africa       1997   67.21700     66134291     4173.1818        3.54300
El Salvador                Americas     1967   55.85500      3232927     4358.5954        3.54800
Tunisia                    Africa       1972   55.60200      5303507     2753.2860        3.54900
India                      Asia         1977   54.20800    634000000      813.3373        3.55700
Croatia                    Europe       1957   64.77000      3991242     4338.2316        3.56000
Lebanon                    Asia         1957   59.48900      1647412     6089.7869        3.56100
Philippines                Asia         1957   51.33400     26072194     1547.9448        3.58200
Honduras                   Americas     1987   64.49200      4372203     3023.0967        3.58300
India                      Asia         1967   47.19300    506000000      700.7706        3.58800
Congo, Rep.                Africa       1967   52.04000      1179760     2677.9396        3.60500
Cameroon                   Africa       1982   52.96100      9250831     2367.9833        3.60600
Chile                      Americas     1977   67.05200     10599793     4756.7638        3.61100
Gabon                      Africa       1987   60.19000       880397    11864.4084        3.62600
Dominican Republic         Americas     1962   53.45900      3453434     1662.1374        3.63100
Malaysia                   Asia         1967   59.37100     10154878     2277.7424        3.63400
Malaysia                   Asia         1962   55.73700      8906385     2036.8849        3.63500
Malaysia                   Asia         1957   52.10200      7739235     1810.0670        3.63900
Malaysia                   Asia         1972   63.01000     11441462     2849.0948        3.63900
Syria                      Asia         1972   57.29600      6701172     2571.4230        3.64100
West Bank and Gaza         Asia         1982   64.40600      1425876     4336.0321        3.64100
El Salvador                Americas     1992   66.79800      5274649     4444.2317        3.64400
Gambia                     Africa       1987   49.26500       848406      611.6589        3.68500
Serbia                     Europe       1957   61.68500      7271135     4981.0909        3.68900
Myanmar                    Asia         1972   53.07000     28466390      357.0000        3.69100
Nepal                      Asia         1997   59.42600     23001113     1010.8921        3.69900
Guatemala                  Americas     1972   53.73800      5149581     4031.4083        3.72200
Uganda                     Africa       2007   51.54200     29170398     1056.3801        3.72900
Reunion                    Africa       1972   64.27400       461633     5047.6586        3.73200
El Salvador                Americas     1962   52.30700      2747687     3776.8036        3.73700
Gambia                     Africa       1982   45.58000       715523      835.8096        3.73800
Gabon                      Africa       1982   56.56400       753874    15113.3619        3.77400
Hong Kong, China           Asia         1957   64.75000      2736300     3629.0765        3.79000
Egypt                      Africa       1987   59.79700     52799062     3885.4607        3.79100
Yemen, Rep.                Asia         1987   52.92200     11219340     1971.7415        3.80900
Oman                       Asia         1967   46.98800       714775     4720.9427        3.82300
Nicaragua                  Americas     1992   65.84300      4017939     2170.1517        3.83500
Bolivia                    Americas     1982   53.85900      5642224     3156.5105        3.83600
Sri Lanka                  Asia         1957   61.45600      9128546     1072.5466        3.86300
Egypt                      Africa       1992   63.67400     59402198     3794.7552        3.87700
Syria                      Asia         1977   61.19500      7932503     3195.4846        3.89900
Taiwan                     Asia         1957   62.40000     10164215     1507.8613        3.90000
Dominican Republic         Americas     1957   49.82800      2923186     1544.4030        3.90000
Morocco                    Africa       1982   59.65000     20198730     2702.6204        3.92000
Niger                      Africa       1997   51.31300      9666252      580.3052        3.92200
Indonesia                  Asia         1987   60.13700    169276000     1748.3570        3.97800
Saudi Arabia               Asia         1972   53.88600      6472756    24837.4287        3.98500
Saudi Arabia               Asia         1967   49.90100      5618198    16903.0489        3.98700
Peru                       Americas     1972   55.44800     13954700     5937.8273        4.00300
Vietnam                    Asia         1987   62.82000     62826491      820.7994        4.00400
Panama                     Americas     1957   59.20100      1063506     2961.8009        4.01000
Turkey                     Europe       1962   52.09800     29788695     2322.8699        4.01900
Korea, Dem. Rep.           Asia         1957   54.08100      9411381     1571.1347        4.02500
Korea, Dem. Rep.           Asia         1972   63.98300     14781241     3701.6215        4.04100
Albania                    Europe       1957   59.28000      1476505     1942.2842        4.05000
Libya                      Africa       1987   66.23400      3799845    11770.5898        4.07900
Jamaica                    Americas     1957   62.61000      1535090     4756.5258        4.08000
Gabon                      Africa       1972   48.69000       537977    11401.9484        4.09200
Botswana                   Africa       2007   50.72800      1639131    12569.8518        4.09400
Gabon                      Africa       1977   52.79000       706367    21745.5733        4.10000
Gabon                      Africa       1967   44.59800       489004     8358.7620        4.10900
Somalia                    Africa       1997   43.79500      6633514      930.5964        4.13700
Kuwait                     Asia         1967   64.62400       575003    80894.8833        4.15400
Tunisia                    Africa       1982   64.04800      6734098     3560.2332        4.21100
West Bank and Gaza         Asia         1977   60.76500      1261091     3682.8315        4.23300
Tunisia                    Africa       1977   59.83700      6005061     3120.8768        4.23500
Puerto Rico                Americas     1957   68.54000      2260000     3907.1562        4.26000
Myanmar                    Asia         1967   49.37900     25870271      349.0000        4.27100
Saudi Arabia               Asia         1982   63.01200     11254672    33693.1753        4.32200
Yemen, Rep.                Asia         1977   44.17500      8403990     1829.7652        4.32700
Mexico                     Americas     1957   55.19000     35015548     4131.5466        4.40100
Algeria                    Africa       1987   65.79900     23254956     5681.3585        4.43100
Poland                     Europe       1957   65.77000     28235346     4734.2530        4.46000
Colombia                   Americas     1957   55.11800     14485993     2323.8056        4.47500
Turkey                     Europe       1957   48.07900     25670939     2218.7543        4.49400
Jordan                     Asia         1977   61.13400      1937652     2852.3516        4.60600
Bosnia and Herzegovina     Europe       1957   58.45000      3076000     1353.9892        4.63000
Libya                      Africa       1977   57.44200      2721783    21951.2118        4.66900
Libya                      Africa       1982   62.15500      3344074    17364.2754        4.71300
China                      Asia         1972   63.11888    862030000      676.9001        4.73776
Saudi Arabia               Asia         1977   58.69000      8128505    34167.7626        4.80400
Vietnam                    Asia         1992   67.66200     69940728      989.0231        4.84200
Korea, Rep.                Asia         1972   62.61200     33505000     3030.8767        4.89600
Jordan                     Asia         1972   56.52800      1613551     2110.8563        4.89900
West Bank and Gaza         Asia         1972   56.53200      1089572     3133.4093        4.90100
Yemen, Rep.                Asia         1982   49.11300      9657618     1977.5570        4.93800
Oman                       Asia         1987   67.73400      1593882    18115.2231        5.00600
Oman                       Asia         1972   52.14300       829050    10618.0385        5.15500
Oman                       Asia         1977   57.36700      1004533    11848.3439        5.22400
Korea, Rep.                Asia         1957   52.68100     22611552     1487.5935        5.22800
Oman                       Asia         1982   62.72800      1301048    12954.7910        5.36100
Vietnam                    Asia         1977   55.76400     50533506      713.5371        5.51000
Albania                    Europe       1962   64.82000      1728137     2312.8890        5.54000
Myanmar                    Asia         1957   41.90500     21731844      350.0000        5.58600
China                      Asia         1957   50.54896    637408000      575.9870        6.54896
El Salvador                Americas     1987   63.15400      4842194     4140.4421        6.55000
Bulgaria                   Europe       1957   66.61000      7651254     3008.6707        7.01000
Mauritius                  Africa       1957   58.08900       609816     2034.0380        7.10300
Rwanda                     Africa       2002   43.41300      7852401      785.6538        7.32600
Rwanda                     Africa       1997   36.08700      7212583      589.9445       12.48800
China                      Asia         1967   58.38112    754550000      612.7057       13.87976
Cambodia                   Asia         1982   50.95700      7272485      624.4755       19.73700



