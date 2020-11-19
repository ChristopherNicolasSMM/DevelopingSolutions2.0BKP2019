*<html class="sapUiTheme-sap_belize sap-android sap-desktop sapUiMedia-Std-Desktop sapUiMedia-StdExt-Desktop" dir="ltr" data-sap-ui-browser="cr75" data-sap-ui-os="win10" lang="pt-PT" data-sap-ui-animation="on" data-sap-ui-animation-mode="full"
*style="height: 100%;">
*  <head>
*<meta charset="utf-8">
*<meta name="viewport" content="width=device-width, initial-scale=1.0">
*<title>Shop Administration Tool</title>
*<style type="text/css">@font-face {font-family: 'SAP-icons';src: url('https://openui5.hana.ondemand.com/resources//sap/ui/core/themes/base/fonts/SAP-icons.woff2') format('woff2'),url(
*'https://openui5.hana.ondemand.com/resources//sap/ui/core/themes/base/fonts/SAP-icons.woff') format('woff'),url('https://openui5.hana.ondemand.com/resources//sap/ui/core/themes/base/fonts/SAP-icons.ttf') format('truetype'),local('SAP-icons')
*;font-weight: normal;font-style: normal;}</style>
*<style type="text/css">@font-face {font-family: 'SAP-icons-TNT';src: url('https://openui5.hana.ondemand.com/resources//sap/tnt/themes/base/fonts/SAP-icons-TNT.woff2') format('woff2'),url(
*'https://openui5.hana.ondemand.com/resources//sap/tnt/themes/base/fonts/SAP-icons-TNT.woff') format('woff'),url('https://openui5.hana.ondemand.com/resources//sap/tnt/themes/base/fonts/SAP-icons-TNT.ttf') format('truetype'),local('SAP-icons-TNT')
*;font-weight: normal;font-style: normal;}</style>
*<script id="sap-ui-bootstrap" src="https://openui5.hana.ondemand.com/resources///sap-ui-core.js" data-sap-ui-theme="sap_belize" data-sap-ui-resourceroots="{
*  &quot;sap.ui.demo.toolpageapp&quot;: &quot;./&quot;
*  }" data-sap-ui-oninit="module:sap/ui/core/ComponentSupport" data-sap-ui-compatversion="edge" data-sap-ui-async="true"></script><script src="https://openui5.hana.ondemand.com/resources///sap/ui/core/library-preload.js"
*data-sap-ui-module="sap/ui/core/library-preload.js"></script><script src="https://openui5.hana.ondemand.com/resources///sap/ui/core/library-preload.js" data-sap-ui-module="sap/ui/core/library-preload.js"></script><script
*src="https://openui5.hana.ondemand.com/resources///sap/ui/core/library-preload.js" data-sap-ui-module="sap/ui/core/library-preload.js"></script><script src="https://openui5.hana.ondemand.com/resources///sap/ui/core/library-preload.js"
*data-sap-ui-module="sap/ui/core/library-preload.js"></script><script src="https://openui5.hana.ondemand.com/resources///sap/ui/core/library-preload.js" data-sap-ui-module="sap/ui/core/library-preload.js"></script>
*<link rel="stylesheet" href="https://openui5.hana.ondemand.com/resources///sap/ui/core/themes/sap_belize/library.css" id="sap-ui-theme-sap.ui.core" data-sap-ui-ready="true">
*<script src="./Component-preload.js" data-sap-ui-module="sap/ui/demo/toolpageapp/Component-preload.js"></script><script src="https://openui5.hana.ondemand.com/resources///sap/m/library-preload.js"
*data-sap-ui-module="sap/m/library-preload.js"></script><script src="https://openui5.hana.ondemand.com/resources///sap/tnt/library-preload.js" data-sap-ui-module="sap/tnt/library-preload.js"></script><script
*src="https://openui5.hana.ondemand.com/resources///sap/ui/layout/library-preload.js" data-sap-ui-module="sap/ui/layout/library-preload.js"></script><script src="https://openui5.hana.ondemand.com/resources///sap/uxap/library-preload.js"
*data-sap-ui-module="sap/uxap/library-preload.js"></script>
*<link rel="stylesheet" href="https://openui5.hana.ondemand.com/resources///sap/ui/layout/themes/sap_belize/library.css" id="sap-ui-theme-sap.ui.layout" data-sap-ui-ready="true">
*<link rel="stylesheet" href="https://openui5.hana.ondemand.com/resources///sap/m/themes/sap_belize/library.css" id="sap-ui-theme-sap.m" data-sap-ui-ready="true">
*<link rel="stylesheet" href="https://openui5.hana.ondemand.com/resources///sap/tnt/themes/sap_belize/library.css" id="sap-ui-theme-sap.tnt" data-sap-ui-ready="true">
*<link rel="stylesheet" href="https://openui5.hana.ondemand.com/resources///sap/uxap/themes/sap_belize/library.css" id="sap-ui-theme-sap.uxap" data-sap-ui-ready="true">
*<script src="./Component.js" data-sap-ui-module="sap/ui/demo/toolpageapp/Component.js"></script><script src="./model/models.js" data-sap-ui-module="sap/ui/demo/toolpageapp/model/models.js"></script><script src="./controller/Home.controller.js"
*data-sap-ui-module="sap/ui/demo/toolpageapp/controller/Home.controller.js"></script><script src="./controller/App.controller.js" data-sap-ui-module="sap/ui/demo/toolpageapp/controller/App.controller.js"></script><script
*src="./controller/BaseController.js" data-sap-ui-module="sap/ui/demo/toolpageapp/controller/BaseController.js"></script><script src="./model/formatter.js" data-sap-ui-module="sap/ui/demo/toolpageapp/model/formatter.js"></script>
*<style type="text/css">@font-face {font-family: 'SAP-icons';src: url('https://openui5.hana.ondemand.com/resources///sap/ui/core/themes/base/fonts/SAP-icons.woff2') format('woff2'),url(
*'https://openui5.hana.ondemand.com/resources///sap/ui/core/themes/base/fonts/SAP-icons.woff') format('woff'),url('https://openui5.hana.ondemand.com/resources///sap/ui/core/themes/base/fonts/SAP-icons.ttf') format('truetype'),local('SAP-icons')
*;font-weight: normal;font-style: normal;}</style>
*<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
*  </head>
*  <body class="sapUiBody" role="application" style="height: 100%;">
*<div id="sap-ui-static" style="height: 0px; width: 0px; overflow: hidden; float: left;" data-sap-ui-area="sap-ui-static"><span id="__text0" data-sap-ui="__text0" class="sapUiInvisibleText" aria-hidden="true"></span><span id="__text14"
*data-sap-ui="__text14" class="sapUiInvisibleText" aria-hidden="true">Mais</span><span id="__text15" data-sap-ui="__text15" class="sapUiInvisibleText" aria-hidden="true">Container de lista tabelar</span><span id="__text16" data-sap-ui="__text16"
*class="sapUiInvisibleText" aria-hidden="true">Lista tabelar</span></div>
*<div data-name="sap.ui.demo.toolpageapp" data-id="container" data-settings="{&quot;id&quot; : &quot;toolpageapp&quot;}" id="id-1563375681097-1" data-sap-ui-area="id-1563375681097-1" style="height: 100%;">
*  <div id="container" data-sap-ui="container" class="sapUiComponentContainer" style="height: 100%;">
*<div id="container-uiarea" style="height: 100%;">
*  <div id="container-toolpageapp---app" data-sap-ui="container-toolpageapp---app" data-sap-ui-preserve="container-toolpageapp---app" style="width: 100%; height: 100%;" class="sapUiView sapUiXMLView sapUiViewDisplayBlock sapUiSizeCompact">
*<div id="container-toolpageapp---app--app" data-sap-ui="container-toolpageapp---app--app" class="sapTntToolPage sapTntToolPageWithHeader sapUiDemoToolPage" style="height: 100%;">
*  <header>
*<div id="container-toolpageapp---app--app-header" class="sapTntToolPageHeader"></div>
*  </header>
*  <div class="sapTntToolPageContentWrapper" style="height: 100%;">
*<div id="container-toolpageapp---app--app-main" class="sapTntToolPageMain" style="height: 100%;">
*  <div class="sapTntToolPageMainContent" style="height: 100%;">
*<div class="sapTntToolPageMainContentWrapper" style="height: 100%;">
*  <div id="container-toolpageapp---app--mainContents" data-sap-ui="container-toolpageapp---app--mainContents" class="sapMNav sapUiGlobalBackgroundColor sapMApp" style="width: 100%;">
*<div id="container-toolpageapp---app--mainContents-BG" class="sapMAppBG sapUiGlobalBackgroundImage"></div>
*<div id="container-toolpageapp---home" data-sap-ui="container-toolpageapp---home" data-sap-ui-preserve="container-toolpageapp---home" style="width: 100%;" class="sapUiView sapUiXMLView sapMNavItem">
*  <div id="__page0" data-sap-ui="__page0" class="sapMPage sapMPageBgStandard sapMPageBusyCoversAll" role="region" aria-label="Home Page">
*<section id="__page0-cont" role="main" aria-label="KPI Content" class="sapMPageEnableScrolling" style="overflow: hidden auto;">
*  <div id="container-toolpageapp---home--BlockLayout" data-sap-ui="container-toolpageapp---home--BlockLayout" class="sapUiBlockLayout sapUiBlockLayoutBackgroundDefault sapUiBlockLayoutSizeL">
*<div id="__row0" data-sap-ui="__row0" class="sapUiBlockLayoutRow sapUiBlockHorizontalCellsRow sapUiBlockLayoutBackgroundColorSet1">
*  <div style="display: flex;">
*<div id="__cell0" data-sap-ui="__cell0" style="-webkit-flex: 1; -ms-flex: 1; flex: 1;" class="sapUiBlockLayoutCell sapUiNoContentPadding sapUiBlockLayoutOddCell sapUiBlockHorizontalCell"></div>
*  </div>
*</div>
*<div id="__row1" data-sap-ui="__row1" class="sapUiBlockLayoutRow sapUiBlockHorizontalCellsRow sapUiBlockLayoutBackgroundColorSet2">
*  <div style="display: flex;">
*<div id="__cell1" data-sap-ui="__cell1" style="-webkit-flex: 1; -ms-flex: 1; flex: 1;" class="sapUiBlockLayoutCell sapUiBlockLayoutCellColor11D  sapUiBlockLayoutOddCell sapUiBlockHorizontalCell">
*  <!-- sapUiBlockLayoutCellColor11D é escuro e sapUiBlockLayoutCellColor11B Claro-->
*  <div class="sapUiBlockCellContent">
*<div id="__layout0" data-sap-ui="__layout0" class="sapUiVlt sapuiVlt">
*  <div class="sapUiVltCell sapuiVltCell"><span id="__icon3-__clone1068-__clone1213-__clone1391" data-sap-ui="__icon3-__clone1068-__clone1213-__clone1391" role="presentation" aria-hidden="true" data-sap-ui-icon-content="" class="sapUiIcon
*sapUiIconColorDefault" style="font-family: 'SAP\2dicons'; font-size: 2.5rem;"></span></div>
*  <div class="sapUiVltCell sapuiVltCell">
*<h3 id="container-toolpageapp---home--administrationTile" data-sap-ui="container-toolpageapp---home--administrationTile" class="sapMTitle sapMTitleStyleH2 sapMTitleNoWrap sapUiSelectable sapMTitleMaxWidth sapUiTinyMarginTopBottom"><span
*id="container-toolpageapp---home--administrationTile-inner">Valor Faturado</span></h3>
*  </div>
*  <br>
*  <h3>
*<footer class="" id="__list1-footer">#VLFAT</footer>
*  </h3>
*</div>
*  </div>
*</div>
*<div id="__cell2" data-sap-ui="__cell2" style="-webkit-flex: 1; -ms-flex: 1; flex: 1;" class="sapUiBlockLayoutCell sapUiBlockLayoutCellColor11B sapUiBlockLayoutEvenCell sapUiBlockHorizontalCell">
*  <div class="sapUiBlockCellContent">
*<div id="__layout1" data-sap-ui="__layout1" class="sapUiVlt sapuiVlt">
*  <div class="sapUiVltCell sapuiVltCell"><span id="__icon3-__clone1068-__clone1213-__clone2335-__clone2343-__clone2360-__clone2371-__clone2382" data-sap-ui="__icon3-__clone1068-__clone1213-__clone2335-__clone2343-__clone2360-__clone2371-__clone2382"
*role="presentation" aria-hidden="true" data-sap-ui-icon-content="" class="sapUiIcon sapUiIconColorDefault" style="font-family: 'SAP\2dicons'; font-size: 2.5rem;"></span></div>
*  <div class="sapUiVltCell sapuiVltCell">
*<h3 id="container-toolpageapp---home--productTile" data-sap-ui="container-toolpageapp---home--productTile" class="sapMTitle sapMTitleStyleH2 sapMTitleNoWrap sapUiSelectable sapMTitleMaxWidth sapUiTinyMarginTopBottom"><span
*id="container-toolpageapp---home--productTile-inner">Valor Recebido</span></h3>
*  </div>
*  <br>
*  <h3>
*<footer class="" id="__list1-footer">#VLREC</footer>
*  </h3>
*</div>
*  </div>
*</div>
*<div id="__cell1" data-sap-ui="__cell1" style="-webkit-flex: 1; -ms-flex: 1; flex: 1;" class="sapUiBlockLayoutCell sapUiBlockLayoutCellColor11D  sapUiBlockLayoutOddCell sapUiBlockHorizontalCell">
*  <!-- sapUiBlockLayoutCellColor11D é escuro e sapUiBlockLayoutCellColor11B Claro-->
*  <div class="sapUiBlockCellContent">
*<div id="__layout0" data-sap-ui="__layout0" class="sapUiVlt sapuiVlt">
*  <div class="sapUiVltCell sapuiVltCell"><span id="__icon3-__clone1068-__clone1213-__clone2335-__clone2343-__clone2360-__clone2371-__clone2376" data-sap-ui="__icon3-__clone1068-__clone1213-__clone2335-__clone2343-__clone2360-__clone2371-__clone2376"
*role="presentation" aria-hidden="true" data-sap-ui-icon-content="" class="sapUiIcon sapUiIconColorDefault" style="font-family: 'SAP\2dicons'; font-size: 2.5rem;"></span></div>
*  <div class="sapUiVltCell sapuiVltCell">
*<h3 id="container-toolpageapp---home--administrationTile" data-sap-ui="container-toolpageapp---home--administrationTile" class="sapMTitle sapMTitleStyleH2 sapMTitleNoWrap sapUiSelectable sapMTitleMaxWidth sapUiTinyMarginTopBottom"><span
*id="container-toolpageapp---home--administrationTile-inner">% de Inadimplência</span></h3>
*  </div>
*  <br>
*  <h3>
*<footer class="" id="__list1-footer">% #PINA</footer>
*  </h3>
*</div>
*  </div>
*</div>
*<div id="__cell2" data-sap-ui="__cell2" style="-webkit-flex: 1; -ms-flex: 1; flex: 1;" class="sapUiBlockLayoutCell sapUiBlockLayoutCellColor11B sapUiBlockLayoutEvenCell sapUiBlockHorizontalCell">
*  <div class="sapUiBlockCellContent">
*<div id="__layout1" data-sap-ui="__layout1" class="sapUiVlt sapuiVlt">
*  <div class="sapUiVltCell sapuiVltCell"><span id="__icon3-__clone1068-__clone1213-__clone2335-__clone2343-__clone2360-__clone2371-__clone2373" data-sap-ui="__icon3-__clone1068-__clone1213-__clone2335-__clone2343-__clone2360-__clone2371-__clone2373"
*role="presentation" aria-hidden="true" data-sap-ui-icon-content="" class="sapUiIcon sapUiIconColorDefault" style="font-family: 'SAP\2dicons'; font-size: 2.5rem;"></span></div>
*  <div class="sapUiVltCell sapuiVltCell">
*<h3 id="container-toolpageapp---home--productTile" data-sap-ui="container-toolpageapp---home--productTile" class="sapMTitle sapMTitleStyleH2 sapMTitleNoWrap sapUiSelectable sapMTitleMaxWidth sapUiTinyMarginTopBottom"><span
*id="container-toolpageapp---home--productTile-inner">Valor Pago</span></h3>
*  </div>
*  <br>
*  <h3>
*<footer class="" id="__list1-footer">#VLPAG</footer>
*  </h3>
*</div>
*  </div>
*</div>
*<div id="__cell1" data-sap-ui="__cell1" style="-webkit-flex: 1; -ms-flex: 1; flex: 1;" class="sapUiBlockLayoutCell sapUiBlockLayoutCellColor11D  sapUiBlockLayoutOddCell sapUiBlockHorizontalCell">
*  <!-- sapUiBlockLayoutCellColor11D é escuro e sapUiBlockLayoutCellColor11B Claro-->
*  <div class="sapUiBlockCellContent">
*<div id="__layout0" data-sap-ui="__layout0" class="sapUiVlt sapuiVlt">
*  <div class="sapUiVltCell sapuiVltCell"><span id="__icon1" data-sap-ui="__icon1" role="presentation" aria-hidden="true" aria-label="add-product" data-sap-ui-icon-content="" class="sapUiIcon sapUiIconMirrorInRTL sapUiIconColorDefault"
*style="font-family: 'SAP\2dicons'; font-size: 2.5rem;"></span></div>
*  <div class="sapUiVltCell sapuiVltCell">
*<h3 id="container-toolpageapp---home--administrationTile" data-sap-ui="container-toolpageapp---home--administrationTile" class="sapMTitle sapMTitleStyleH2 sapMTitleNoWrap sapUiSelectable sapMTitleMaxWidth sapUiTinyMarginTopBottom"><span
*id="container-toolpageapp---home--administrationTile-inner">Valor Total Estoque</span></h3>
*  </div>
*  <br>
*  <h3>
*<footer class="" id="__list1-footer">#VLEST</footer>
*  </h3>
*</div>
*  </div>
*</div>
*  </div>
*</div>
*<div id="__row1" data-sap-ui="__row1" class="sapUiBlockLayoutRow sapUiBlockHorizontalCellsRow sapUiBlockLayoutBackgroundColorSet2">
*  <div style="display: flex;">
*<div id="__cell2" data-sap-ui="__cell2" style="-webkit-flex: 1; -ms-flex: 1; flex: 1;" class="sapUiBlockLayoutCell sapUiBlockLayoutCellColor11B sapUiBlockLayoutEvenCell sapUiBlockHorizontalCell">
*  <div class="sapUiBlockCellContent">
*<div id="__layout1" data-sap-ui="__layout1" class="sapUiVlt sapuiVlt">
*  <div class="sapUiVltCell sapuiVltCell"><span id="__icon3-__clone1068-__clone1213-__clone1397" data-sap-ui="__icon3-__clone1068-__clone1213-__clone1397" role="presentation" aria-hidden="true" data-sap-ui-icon-content="" class="sapUiIcon
*sapUiIconColorDefault" style="font-family: 'SAP\2dicons'; font-size: 2.5rem;"></span></div>
*  <div class="sapUiVltCell sapuiVltCell">
*<h3 id="container-toolpageapp---home--productTile" data-sap-ui="container-toolpageapp---home--productTile" class="sapMTitle sapMTitleStyleH2 sapMTitleNoWrap sapUiSelectable sapMTitleMaxWidth sapUiTinyMarginTopBottom"><span
*id="container-toolpageapp---home--productTile-inner">Valor à Faturar</span></h3>
*  </div>
*  <br>
*  <h3>
*<footer class="" id="__list1-footer">#VLAFAT</footer>
*  </h3>
*</div>
*  </div>
*</div>
*<div id="__cell1" data-sap-ui="__cell1" style="-webkit-flex: 1; -ms-flex: 1; flex: 1;" class="sapUiBlockLayoutCell sapUiBlockLayoutCellColor11D  sapUiBlockLayoutOddCell sapUiBlockHorizontalCell">
*  <!-- sapUiBlockLayoutCellColor11D é escuro e sapUiBlockLayoutCellColor11B Claro-->
*  <div class="sapUiBlockCellContent">
*<div id="__layout0" data-sap-ui="__layout0" class="sapUiVlt sapuiVlt">
*  <div class="sapUiVltCell sapuiVltCell"><span id="__icon0" data-sap-ui="__icon0" role="presentation" aria-hidden="true" aria-label="role" data-sap-ui-icon-content="" class="sapUiIcon sapUiIconMirrorInRTL sapUiIconColorDefault" style="font-family:
*'SAP\2dicons'; font-size: 2.5rem;"></span></div>
*  <div class="sapUiVltCell sapuiVltCell">
*<h3 id="container-toolpageapp---home--administrationTile" data-sap-ui="container-toolpageapp---home--administrationTile" class="sapMTitle sapMTitleStyleH2 sapMTitleNoWrap sapUiSelectable sapMTitleMaxWidth sapUiTinyMarginTopBottom"><span
*id="container-toolpageapp---home--administrationTile-inner">Valor à Receber</span></h3>
*  </div>
*  <br>
*  <h3>
*<footer class="" id="__list1-footer">#VLAREC</footer>
*  </h3>
*</div>
*  </div>
*</div>
*<div id="__cell2" data-sap-ui="__cell2" style="-webkit-flex: 1; -ms-flex: 1; flex: 1;" class="sapUiBlockLayoutCell sapUiBlockLayoutCellColor11B sapUiBlockLayoutEvenCell sapUiBlockHorizontalCell">
*  <div class="sapUiBlockCellContent">
*<div id="__layout1" data-sap-ui="__layout1" class="sapUiVlt sapuiVlt">
*  <div class="sapUiVltCell sapuiVltCell"><span id="__icon3-__clone1068-__clone1213-__clone2335-__clone2343-__clone2360-__clone2371-__clone2398" data-sap-ui="__icon3-__clone1068-__clone1213-__clone2335-__clone2343-__clone2360-__clone2371-__clone2398"
*role="presentation" aria-hidden="true" data-sap-ui-icon-content="" class="sapUiIcon sapUiIconColorDefault" style="font-family: 'SAP\2dicons'; font-size: 2.5rem;"></span></div>
*  <div class="sapUiVltCell sapuiVltCell">
*<h3 id="container-toolpageapp---home--productTile" data-sap-ui="container-toolpageapp---home--productTile" class="sapMTitle sapMTitleStyleH2 sapMTitleNoWrap sapUiSelectable sapMTitleMaxWidth sapUiTinyMarginTopBottom"><span
*id="container-toolpageapp---home--productTile-inner">% Margem</span></h3>
*  </div>
*  <br>
*  <h3>
*<footer class="" id="__list1-footer">#PMARGC</footer>
*  </h3>
*</div>
*  </div>
*</div>
*<div id="__cell1" data-sap-ui="__cell1" style="-webkit-flex: 1; -ms-flex: 1; flex: 1;" class="sapUiBlockLayoutCell sapUiBlockLayoutCellColor11D  sapUiBlockLayoutOddCell sapUiBlockHorizontalCell">
*  <!-- sapUiBlockLayoutCellColor11D é escuro e sapUiBlockLayoutCellColor11B Claro-->
*  <div class="sapUiBlockCellContent">
*<div id="__layout0" data-sap-ui="__layout0" class="sapUiVlt sapuiVlt">
*  <div class="sapUiVltCell sapuiVltCell"><span id="__icon3-__clone1068-__clone1213-__clone1367" data-sap-ui="__icon3-__clone1068-__clone1213-__clone1367" role="presentation" aria-hidden="true" data-sap-ui-icon-content="" class="sapUiIcon
*sapUiIconColorDefault" style="font-family: 'SAP\2dicons'; font-size: 2.5rem;"></span></div>
*  <div class="sapUiVltCell sapuiVltCell">
*<h3 id="container-toolpageapp---home--administrationTile" data-sap-ui="container-toolpageapp---home--administrationTile" class="sapMTitle sapMTitleStyleH2 sapMTitleNoWrap sapUiSelectable sapMTitleMaxWidth sapUiTinyMarginTopBottom"><span
*id="container-toolpageapp---home--administrationTile-inner">Valor à Pagar</span></h3>
*  </div>
*  <br>
*  <h3>
*<footer class="" id="__list1-footer">#VLAPAG</footer>
*  </h3>
*</div>
*  </div>
*</div>
*<div id="__cell2" data-sap-ui="__cell2" style="-webkit-flex: 1; -ms-flex: 1; flex: 1;" class="sapUiBlockLayoutCell sapUiBlockLayoutCellColor11B sapUiBlockLayoutEvenCell sapUiBlockHorizontalCell">
*  <div class="sapUiBlockCellContent">
*<div id="__layout1" data-sap-ui="__layout1" class="sapUiVlt sapuiVlt">
*  <div class="sapUiVltCell sapuiVltCell"><span id="__icon3-__clone1068-__clone1213-__clone1727" data-sap-ui="__icon3-__clone1068-__clone1213-__clone1727" role="presentation" aria-hidden="true" data-sap-ui-icon-content="" class="sapUiIcon
*sapUiIconMirrorInRTL sapUiIconColorDefault" style="font-family: 'SAP\2dicons'; font-size: 2.5rem;"></span></div>
*  <div class="sapUiVltCell sapuiVltCell">
*<h3 id="container-toolpageapp---home--productTile" data-sap-ui="container-toolpageapp---home--productTile" class="sapMTitle sapMTitleStyleH2 sapMTitleNoWrap sapUiSelectable sapMTitleMaxWidth sapUiTinyMarginTopBottom"><span
*id="container-toolpageapp---home--productTile-inner">Ativo Imobilizado</span></h3>
*  </div>
*  <br>
*  <h3>
*<footer class="" id="__list1-footer">0,00</footer>
*  </h3>
*</div>
*  </div>
*</div>
*  </div>
*</div>
*<div id="__row1" data-sap-ui="__row1" class="sapUiBlockLayoutRow sapUiBlockHorizontalCellsRow sapUiBlockLayoutBackgroundColorSet2">
*  <div style="display: flex;">
*<div id="__cell1" data-sap-ui="__cell1" style="-webkit-flex: 1; -ms-flex: 1; flex: 1;" class="sapUiBlockLayoutCell sapUiBlockLayoutCellColor11D  sapUiBlockLayoutOddCell sapUiBlockHorizontalCell">
*  <!-- sapUiBlockLayoutCellColor11D é escuro e sapUiBlockLayoutCellColor11B Claro-->
*  <div class="sapUiBlockCellContent">
*<div id="__layout0" data-sap-ui="__layout0" class="sapUiVlt sapuiVlt">
*  <div class="sapUiVltCell sapuiVltCell"><span id="__icon3-__clone1068-__clone1213-__clone1740" data-sap-ui="__icon3-__clone1068-__clone1213-__clone1740" role="presentation" aria-hidden="true" data-sap-ui-icon-content="" class="sapUiIcon
*sapUiIconColorDefault" style="font-family: 'SAP\2dicons'; font-size: 2.5rem;"></span></div>
*  <div class="sapUiVltCell sapuiVltCell">
*<h3 id="container-toolpageapp---home--administrationTile" data-sap-ui="container-toolpageapp---home--administrationTile" class="sapMTitle sapMTitleStyleH2 sapMTitleNoWrap sapUiSelectable sapMTitleMaxWidth sapUiTinyMarginTopBottom"><span
*id="container-toolpageapp---home--administrationTile-inner">Prazo médio</span></h3>
*<h3 id="container-toolpageapp---home--administrationTile" data-sap-ui="container-toolpageapp---home--administrationTile" class="sapMTitle sapMTitleStyleH2 sapMTitleNoWrap sapUiSelectable sapMTitleMaxWidth sapUiTinyMarginTopBottom"><span
*id="container-toolpageapp---home--administrationTile-inner">Recebimento</span></h3>
*  </div>
*  <br>
*  <h3>
*<footer class="" id="__list1-footer">#PZMEDREC Dias</footer>
*  </h3>
*</div>
*  </div>
*</div>
*<div id="__cell2" data-sap-ui="__cell2" style="-webkit-flex: 1; -ms-flex: 1; flex: 1;" class="sapUiBlockLayoutCell sapUiBlockLayoutCellColor11B sapUiBlockLayoutEvenCell sapUiBlockHorizontalCell">
*  <div class="sapUiBlockCellContent">
*<div id="__layout1" data-sap-ui="__layout1" class="sapUiVlt sapuiVlt">
*  <div class="sapUiVltCell sapuiVltCell"><span id="__icon3-__clone1068-__clone1213-__clone2055" data-sap-ui="__icon3-__clone1068-__clone1213-__clone2055" role="presentation" aria-hidden="true" data-sap-ui-icon-content="" class="sapUiIcon
*sapUiIconMirrorInRTL sapUiIconColorDefault" style="font-family: 'SAP\2dicons'; font-size: 2.5rem;"></span></div>
*  <div class="sapUiVltCell sapuiVltCell">
*<h3 id="container-toolpageapp---home--productTile" data-sap-ui="container-toolpageapp---home--productTile" class="sapMTitle sapMTitleStyleH2 sapMTitleNoWrap sapUiSelectable sapMTitleMaxWidth sapUiTinyMarginTopBottom"><span
*id="container-toolpageapp---home--productTile-inner">Valor à Receber</span></h3>
*<h3 id="container-toolpageapp---home--productTile" data-sap-ui="container-toolpageapp---home--productTile" class="sapMTitle sapMTitleStyleH2 sapMTitleNoWrap sapUiSelectable sapMTitleMaxWidth sapUiTinyMarginTopBottom"><span
*id="container-toolpageapp---home--productTile-inner">Cheque</span></h3>
*  </div>
*  <br>
*  <h3>
*<footer class="" id="__list1-footer">#cheque</footer>
*  </h3>
*</div>
*  </div>
*</div>
*<div id="__cell1" data-sap-ui="__cell1" style="-webkit-flex: 1; -ms-flex: 1; flex: 1;" class="sapUiBlockLayoutCell sapUiBlockLayoutCellColor11D  sapUiBlockLayoutOddCell sapUiBlockHorizontalCell">
*  <!-- sapUiBlockLayoutCellColor11D é escuro e sapUiBlockLayoutCellColor11B Claro-->
*  <div class="sapUiBlockCellContent">
*<div id="__layout0" data-sap-ui="__layout0" class="sapUiVlt sapuiVlt">
*  <div class="sapUiVltCell sapuiVltCell"><span id="__icon3-__clone1068-__clone1213-__clone1710" data-sap-ui="__icon3-__clone1068-__clone1213-__clone1710" role="presentation" aria-hidden="true" data-sap-ui-icon-content="" class="sapUiIcon
*sapUiIconColorDefault" style="font-family: 'SAP\2dicons'; font-size: 2.5rem;"></span></div>
*  <div class="sapUiVltCell sapuiVltCell">
*<h3 id="container-toolpageapp---home--administrationTile" data-sap-ui="container-toolpageapp---home--administrationTile" class="sapMTitle sapMTitleStyleH2 sapMTitleNoWrap sapUiSelectable sapMTitleMaxWidth sapUiTinyMarginTopBottom"><span
*id="container-toolpageapp---home--administrationTile-inner">Margem de</span></h3>
*<h3 id="container-toolpageapp---home--administrationTile" data-sap-ui="container-toolpageapp---home--administrationTile" class="sapMTitle sapMTitleStyleH2 sapMTitleNoWrap sapUiSelectable sapMTitleMaxWidth sapUiTinyMarginTopBottom"><span
*id="container-toolpageapp---home--administrationTile-inner">Contribuição</span></h3>
*  </div>
*  <br>
*  <h3>
*<footer class="" id="__list1-footer">#MARGC</footer>
*  </h3>
*</div>
*  </div>
*</div>
*<div id="__cell2" data-sap-ui="__cell2" style="-webkit-flex: 1; -ms-flex: 1; flex: 1;" class="sapUiBlockLayoutCell sapUiBlockLayoutCellColor11B sapUiBlockLayoutEvenCell sapUiBlockHorizontalCell">
*  <div class="sapUiBlockCellContent">
*<div id="__layout1" data-sap-ui="__layout1" class="sapUiVlt sapuiVlt">
*  <div class="sapUiVltCell sapuiVltCell"><span id="__icon3-__clone1068-__clone1213-__clone1611" data-sap-ui="__icon3-__clone1068-__clone1213-__clone1611" role="presentation" aria-hidden="true" data-sap-ui-icon-content="" class="sapUiIcon
*sapUiIconMirrorInRTL sapUiIconColorDefault" style="font-family: 'SAP\2dicons'; font-size: 2.5rem;"></span></div>
*  <div class="sapUiVltCell sapuiVltCell">
*<h3 id="container-toolpageapp---home--productTile" data-sap-ui="container-toolpageapp---home--productTile" class="sapMTitle sapMTitleStyleH2 sapMTitleNoWrap sapUiSelectable sapMTitleMaxWidth sapUiTinyMarginTopBottom"><span
*id="container-toolpageapp---home--productTile-inner">Prazo Médio</span></h3>
*<h3 id="container-toolpageapp---home--productTile" data-sap-ui="container-toolpageapp---home--productTile" class="sapMTitle sapMTitleStyleH2 sapMTitleNoWrap sapUiSelectable sapMTitleMaxWidth sapUiTinyMarginTopBottom"><span
*id="container-toolpageapp---home--productTile-inner">Pagamento</span></h3>
*  </div>
*  <br>
*  <h3>
*<footer class="" id="__list1-footer">#PZMEDPAG Dias</footer>
*  </h3>
*</div>
*  </div>
*</div>
*<div id="__cell1" data-sap-ui="__cell1" style="-webkit-flex: 1; -ms-flex: 1; flex: 1;" class="sapUiBlockLayoutCell sapUiBlockLayoutCellColor11D  sapUiBlockLayoutOddCell sapUiBlockHorizontalCell">
*  <!-- sapUiBlockLayoutCellColor11D é escuro e sapUiBlockLayoutCellColor11B Claro-->
*  <div class="sapUiBlockCellContent">
*<div id="__layout0" data-sap-ui="__layout0" class="sapUiVlt sapuiVlt">
*</div>
*  </div>
*</div>
*  </div>
*</div>
*  </div>
*</section>
*  </div>
*</div>
*  </div>
*</div>
*  </div>
*</div>
*  </div>
*</div>
*  </div>
*</div>
*  </div>
*</div>
*<div aria-hidden="true" id="sap-ui-preserve" class="sapUiHidden sapUiForcedHidden" style="width: 0px; height: 0px; overflow: hidden;"></div>
*<meta charset="utf-8">
*<meta name="viewport" content="width=device-width, initial-scale=1.0">
*<title>Shop Administration Tool</title>
*<script id="sap-ui-bootstrap" src="https://openui5.hana.ondemand.com/resources///sap-ui-core.js" data-sap-ui-theme="sap_belize" data-sap-ui-resourceroots="{
*  &quot;sap.ui.demo.toolpageapp&quot;: &quot;./&quot;
*  }" data-sap-ui-oninit="module:sap/ui/core/ComponentSupport" data-sap-ui-compatversion="edge" data-sap-ui-async="true"></script><script src="https://openui5.hana.ondemand.com/resources///sap/ui/core/library-preload.js"
*data-sap-ui-module="sap/ui/core/library-preload.js"></script>
*<link rel="stylesheet" href="https://openui5.hana.ondemand.com/resources///sap/ui/core/themes/sap_belize/library.css" id="sap-ui-theme-sap.ui.core" data-sap-ui-ready="true">
*<script src="./Component-preload.js" data-sap-ui-module="sap/ui/demo/toolpageapp/Component-preload.js"></script><script src="https://openui5.hana.ondemand.com/resources///sap/m/library-preload.js"
*data-sap-ui-module="sap/m/library-preload.js"></script><script src="https://openui5.hana.ondemand.com/resources///sap/tnt/library-preload.js" data-sap-ui-module="sap/tnt/library-preload.js"></script><script
*src="https://openui5.hana.ondemand.com/resources///sap/ui/layout/library-preload.js" data-sap-ui-module="sap/ui/layout/library-preload.js"></script><script src="https://openui5.hana.ondemand.com/resources///sap/uxap/library-preload.js"
*data-sap-ui-module="sap/uxap/library-preload.js"></script>
*<link rel="stylesheet" href="https://openui5.hana.ondemand.com/resources///sap/ui/layout/themes/sap_belize/library.css" id="sap-ui-theme-sap.ui.layout" data-sap-ui-ready="true">
*<link rel="stylesheet" href="https://openui5.hana.ondemand.com/resources///sap/m/themes/sap_belize/library.css" id="sap-ui-theme-sap.m" data-sap-ui-ready="true">
*<link rel="stylesheet" href="https://openui5.hana.ondemand.com/resources///sap/tnt/themes/sap_belize/library.css" id="sap-ui-theme-sap.tnt" data-sap-ui-ready="true">
*<link rel="stylesheet" href="https://openui5.hana.ondemand.com/resources///sap/uxap/themes/sap_belize/library.css" id="sap-ui-theme-sap.uxap" data-sap-ui-ready="true">
*<script src="./Component.js" data-sap-ui-module="sap/ui/demo/toolpageapp/Component.js"></script><script src="./model/models.js" data-sap-ui-module="sap/ui/demo/toolpageapp/model/models.js"></script><script src="./controller/Home.controller.js"
*data-sap-ui-module="sap/ui/demo/toolpageapp/controller/Home.controller.js"></script><script src="./controller/App.controller.js" data-sap-ui-module="sap/ui/demo/toolpageapp/controller/App.controller.js"></script><script
*src="./controller/BaseController.js" data-sap-ui-module="sap/ui/demo/toolpageapp/controller/BaseController.js"></script><script src="./model/formatter.js" data-sap-ui-module="sap/ui/demo/toolpageapp/model/formatter.js"></script>
*<style type="text/css">@font-face {font-family: 'SAP-icons';src: url('https://openui5.hana.ondemand.com/resources///sap/ui/core/themes/base/fonts/SAP-icons.woff2') format('woff2'),url(
*'https://openui5.hana.ondemand.com/resources///sap/ui/core/themes/base/fonts/SAP-icons.woff') format('woff'),url('https://openui5.hana.ondemand.com/resources///sap/ui/core/themes/base/fonts/SAP-icons.ttf') format('truetype'),local('SAP-icons')
*;font-weight: normal;font-style: normal;}</style>
*<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
*<div id="sap-ui-static" style="height: 0px; width: 0px; overflow: hidden; float: left;" data-sap-ui-area="sap-ui-static"><span id="__text0" data-sap-ui="__text0" class="sapUiInvisibleText" aria-hidden="true"></span><span id="__text14"
*data-sap-ui="__text14" class="sapUiInvisibleText" aria-hidden="true">Mais</span><span id="__text15" data-sap-ui="__text15" class="sapUiInvisibleText" aria-hidden="true">Container de lista tabelar</span><span id="__text16" data-sap-ui="__text16"
*class="sapUiInvisibleText" aria-hidden="true">Lista tabelar</span></div>
*<div aria-hidden="true" id="sap-ui-preserve" class="sapUiHidden sapUiForcedHidden" style="width: 0px; height: 0px; overflow: hidden;"></div>
*  </body>
*</html>
