*<!DOCTYPE html>
*<html>
*<head>
*  <meta charset='utf-8'>
*  <meta name='viewport' content='width=device-width, initial-scale=1.0'>
*  <meta name='description' content=''>
*  <meta name='author' content='ThemeBucket'>
*
*  <meta http-equiv=”X-UA-Compatible” content=”IE=EmulateIE9”>
*  <meta http-equiv=”X-UA-Compatible” content=”IE=9”>
*  <title>H2 Projetos</title>
*  <link href='https://maxcdn.bootstrapcdn.com/font-awesome/4.2.0/css/font-awesome.min.css' rel='stylesheet'>
*<style>
*@import url(http://fonts.googleapis.com/css?family=Open+Sans:400,300,300italic,400italic,600,600italic,700,700italic,800,800italic);
*@import url(http://fonts.googleapis.com/css?family=Lato:400,100,100italic,300,300italic,400italic,700,700italic,900,900italic);
*@import url(bucket-ico-fonts.css);
*
*html {
*    text-rendering: optimizeLegibility !important;
*    -webkit-font-smoothing: antialiased !important;
*}
*body {
*    color:#767676;
*    background:#f1f2f7;
*    font-family:'Open Sans',sans-serif;
*    padding:0px !important;
*    margin:0px !important;
*    font-size:13px;
*    text-rendering:optimizeLegibility;
*}
*ul, .list-unstyled {
*    padding-left: 30px;
*}
*ul li {
*    /*list-style:none;*/
*}
*
*a,a:hover,a:focus {
*    text-decoration:none;
*    outline:none;
*}
*::selection {
*    background:#1FB5AD;
*    color:#fff;
*}
*::-moz-selection {
*    background:#1FB5AD;
*    color:#fff;
*}
*#container {
*    width:100%;
*    height:100%;
*    -webkit-transition:all .3s ease-in-out;
*    -moz-transition:all .3s ease-in-out;
*    -o-transition:all .3s ease-in-out;
*    transition: all .3s ease-in-out;
*}
*/*login page*/
*.login-body {
*    background:#32323A;
*    background-size:cover;
*    width:100%;
*    height:100%;
*}
*.form-signin {
*    max-width:330px;
*    margin:100px auto;
*    background:#fff;
*    border-radius:5px;
*    -webkit-border-radius:5px;
*}
*.form-signin h2.form-signin-heading {
*    margin:0;
*    padding:35px 15px;
*    text-align:center;
*    background:#aec785;
*    border-radius:5px 5px 0 0;
*    -webkit-border-radius:5px 5px 0 0;
*    color:#fff;
*    font-size:18px;
*    text-transform:uppercase;
*    font-weight:300;
*    font-family:'Open Sans',sans-serif;
*    border-bottom:10px solid #a0b87e;
*}
*.form-signin .checkbox {
*    margin-bottom:14px;
*    padding-left: 20px;
*}
*.form-signin .checkbox {
*    font-weight:normal;
*    color:#b6b6b6;
*    font-weight:300;
*    font-family:'Open Sans',sans-serif;
*}
*.form-signin .form-control {
*    position:relative;
*    font-size:16px;
*    height:auto;
*    padding:10px;
*    -webkit-box-sizing:border-box;
*    -moz-box-sizing:border-box;
*    box-sizing:border-box;
*}
*.form-signin .form-control:focus {
*    z-index:2;
*}
*.form-signin input[type='text'],.form-signin input[type='password'] {
*    margin-bottom:15px;
*    border-radius:5px;
*    -webkit-border-radius:5px;
*    border:1px solid #eaeaea;
*    box-shadow:none;
*    font-size:12px;
*}
*.form-signin .btn-login {
*    background:#1fb5ac;
*    color:#fff;
*    text-transform:uppercase;
*    font-weight:300;
*    font-family:'Open Sans',sans-serif;
*    margin:20px 0 5px;
*}
*.form-signin p {
*    text-align:left;
*    color:#b6b6b6;
*    font-size:16px;
*    font-weight:300;
*}
*.form-signin a,.form-signin a:hover {
*    color:#1fb5ac;
*}
*.form-signin a:hover {
*    text-decoration:underline;
*}
*.login-wrap {
*    padding:20px;
*    position:relative;
*}
*.user-login-info {
*    background:#eaeaec;
*    margin:-20px -20px 20px -20px;
*    padding:20px;
*}
*.user-login-info .form-control:last-child {
*    margin-bottom:0 !important;
*}
*.registration {
*    position:absolute;
*    right:0;
*    bottom:-35px;
*    color: #b8bab9;
*}
*/*sidebar navigation*/
*#sidebar {
*    width:240px;
*    height:100%;
*    position:fixed;
*    background:#32323a;
*    -webkit-transition:all .3s ease-in-out;
*    -moz-transition:all .3s ease-in-out;
*    -o-transition:all .3s ease-in-out;
*    transition:all .3s ease-in-out;
*}
*#sidebar ul li {
*    position: relative;
*}
*
*.leftside-navigation,.right-stat-bar{
*    height: 100%;
*}
*
*.right-stat-bar ul {
*    list-style-type: none;
*    padding-left: 0;
*}
*/*LEFT NAVIGATION ICON*/
*.dcjq-icon {
*    height:17px;
*    width:17px;
*    display:inline-block;
*    background:url(../images/nav-expand.png) no-repeat top;
*    border-radius:3px;
*    -moz-border-radius:3px;
*    -webkit-border-radius:3px;
*    position:absolute;
*    right:10px;
*}
*.active .dcjq-icon {
*    background:url(../images/nav-expand.png) no-repeat bottom;
*    border-radius:3px;
*    -moz-border-radius:3px;
*    -webkit-border-radius:3px;
*}
*.right-side-accordion .dcjq-icon {
*    height:17px;
*    width:17px;
*    display:inline-block;
*    background:url(../images/acc-expand.png) no-repeat top;
*    border-radius:3px;
*    -moz-border-radius:3px;
*    -webkit-border-radius:3px;
*    position:absolute;
*    right:10px;
*}
*.right-side-accordion .active .dcjq-icon {
*    background:url(../images/acc-expand.png) no-repeat bottom;
*    border-radius:3px;
*    -moz-border-radius:3px;
*    -webkit-border-radius: 3px;
*}
*
*.right-side-accordion li:nth-child(2) ul li .prog-row {
*    border: none;
*}
*/*---*/
*.nav-collapse.collapse {
*    display:inline;
*}
*ul.sidebar-menu,ul.sidebar-menu li ul.sub {
*    margin:-2px 0 0;
*    padding:0;
*}
*ul.sidebar-menu {
*    padding-top:80px;
*
*}
*#sidebar>ul>li>ul.sub {
*    display:none;
*}
*#sidebar .sub-menu>.sub li a {
*    padding-left:46px;
*}
*#sidebar>ul>li.active>ul.sub,#sidebar>ul>li>ul.sub>li>a {
*    display:block;
*}
*ul.sidebar-menu li ul.sub li {
*    background:#28282e;
*    margin-bottom:0;
*    margin-left:0;
*    margin-right:0;
*}
*ul.sidebar-menu li ul.sub li a {
*    font-size:12px;
*    padding-top:13px;
*    padding-bottom:13px;
*    -webkit-transition:all 0.3s ease;
*    -moz-transition:all 0.3s ease;
*    -o-transition:all 0.3s ease;
*    -ms-transition:all 0.3s ease;
*    transition:all 0.3s ease;
*    color:#aeb2b7;
*}
*ul.sidebar-menu li ul.sub li a:hover,ul.sidebar-menu li ul.sub li.active a {
*    color:#1fb5ad;
*    -webkit-transition:all 0.3s ease;
*    -moz-transition:all 0.3s ease;
*    -o-transition:all 0.3s ease;
*    -ms-transition:all 0.3s ease;
*    transition:all 0.3s ease;
*    display:block;
*    background:#202025;
*}
*ul.sidebar-menu li {
*    border-bottom:1px solid rgba(255,255,255,0.05);
*}
*ul.sidebar-menu li.sub-menu {
*    line-height:15px;
*}
*ul.sidebar-menu ul.sub li {
*    border-bottom:none;
*}
*ul.sidebar-menu li a span {
*    display:inline-block;
*}
*ul.sidebar-menu li a {
*    color:#aeb2b7;
*    text-decoration:none;
*    display:block;
*    padding:18px 0 18px 25px;
*    font-size:12px;
*    outline:none;
*    -webkit-transition:all 0.3s ease;
*    -moz-transition:all 0.3s ease;
*    -o-transition:all 0.3s ease;
*    -ms-transition:all 0.3s ease;
*    transition:all 0.3s ease;
*}
*ul.sidebar-menu li a.active,ul.sidebar-menu li a:hover,ul.sidebar-menu li a:focus {
*    background:#28282e;
*    color:#1FB5AD;
*    display:block;
*    -webkit-transition:all 0.3s ease;
*    -moz-transition:all 0.3s ease;
*    -o-transition:all 0.3s ease;
*    -ms-transition:all 0.3s ease;
*    transition:all 0.3s ease;
*}
*ul.sidebar-menu li a i {
*    font-size:15px;
*    padding-right:6px;
*}
*ul.sidebar-menu li a:hover i,ul.sidebar-menu li a:focus i {
*    color:#1fb5ad;
*}
*ul.sidebar-menu li a.active i {
*    color:#1fb5ad;
*}
*.mail-info,.mail-info:hover {
*    margin:-3px 6px 0 0;
*    font-size: 11px;
*}
*/*main content*/
*#main-content {
*    margin-left:240px;
*    -webkit-transition:all .3s ease-in-out;
*    -moz-transition:all .3s ease-in-out;
*    -o-transition:all .3s ease-in-out;
*    transition:all .3s ease-in-out;
*}
*.footer {
*    min-height:60px;
*    padding:0 15px;
*}
*.header {
*    left:0;
*    right:0;
*    z-index:1002;
*    background:#fff;
*    -webkit-transition:all .3s ease-in-out;
*    -moz-transition:all .3s ease-in-out;
*    -o-transition:all .3s ease-in-out;
*    transition:all .3s ease-in-out;
*}
*.merge-header {
*    margin-right:240px;
*}
*.fixed-top {
*    position:fixed;
*    box-shadow:1px 0 3px rgba(0,0,0,.15);
*}
*.wrapper {
*    display:inline-block;
*    margin-top:80px;
*    padding:15px;
*    width:100%;
*
*}
*.brand {
*    background:#1fb5ad;
*    float:left;
*    width:240px;
*    height:80px;
*    position:relative;
*}
*a.logo {
*    font-size:21px;
*    color:#2e2e2e;
*    float:left;
*    margin:20px 0 0 25px;
*    text-transform:uppercase;
*}
*a.logo:hover,a.logo:focus {
*    text-decoration:none;
*    outline:none;
*}
*a.logo span {
*    color: #FF6C60;
*}
*/*notification*/
*#top_menu .nav>li,ul.top-menu>li {
*    float:left;
*}
*.notify-row {
*    float:left;
*    margin-top:23px;
*    margin-left:25px;
*}
*ul.top-menu {
*    margin-right:15px;
*    margin-top: 0;
*}
*ul.top-menu > li > a {
*    color:#666666;
*    font-size:16px;
*    background:#f6f6f6;
*    padding:4px 8px;
*    margin-right:15px;
*    border-radius:50%;
*    -webkit-border-radius:50%;
*    padding-right:8px !important;
*}
*ul.top-menu>li>a:hover,ul.top-menu>li>a:focus {
*    background:#32D2C9;
*    text-decoration:none;
*    color:rgba(0,0,0,0.3) !important;
*    padding-right:8px !important;
*}
*.notify-row .badge {
*    position:absolute;
*    right:-10px;
*    top:-10px;
*    z-index:100;
*}
*.dropdown-menu.extended {
*    max-width:320px !important;
*    min-width:160px !important;
*    top:42px;
*    width:300px !important;
*    padding:0 10px;
*    box-shadow:0 0px 5px rgba(0,0,0,0.1) !important;
*    border-radius:5px;
*    -webkit-border-radius:5px;
*    background:#fff;
*    border:none;
*    left:-10px;
*}
*.notify-row .notification span.label {
*    display:inline-block;
*    height:21px;
*    padding:5px;
*    width:22px;
*    font-size:12px;
*    margin-right:10px;
*}
*.dropdown-menu.extended .alert-icon,.noti-info {
*    float:left;
*}
*.noti-info {
*    padding-left:10px;
*    padding-top:6px;
*    color:#414147;
*}
*.dropdown-menu.extended .alert {
*    margin-bottom:10px;
*}
*.dropdown-menu.extended .alert-icon {
*    border-radius:100%;
*    display:inline-block;
*    height:35px;
*    width:35px;
*}
*.dropdown-menu.extended .alert-icon i {
*    font-size:16px;
*    width:35px;
*    line-height:35px;
*    height:35px;
*}
*.dropdown-menu.extended.inbox li a,.dropdown-menu.extended.tasks-bar li a {
*    background:#f1f2f7;
*    border-radius:5px;
*    -webkit-border-radius:5px;
*    padding:10px;
*    margin-bottom:10px;
*    float:left;
*    width:100%;
*}
*.dropdown-menu.extended li p {
*    margin:0;
*    padding:10px 0;
*    border-radius:0px;
*    -webkit-border-radius:0px;
*}
*.dropdown-menu.extended li a {
*    font-size:12px;
*    list-style:none;
*}
*.dropdown-menu.extended.logout {
*    padding:10px;
*}
*.dropdown-menu.extended.logout li a {
*    padding:10px;
*}
*.dropdown-menu.extended li a:hover {
*    color:#32323a;
*}
*.dropdown-menu.tasks-bar .task-info .desc {
*    font-size:13px;
*    font-weight:normal;
*    float:left;
*    width:80%;
*}
*.dropdown-menu.tasks-bar .task-info .desc h5 {
*    color:#32323a;
*    text-transform:uppercase;
*    font-size:12px;
*    font-weight:600;
*    margin-bottom:5px;
*    margin-top:0;
*}
*.dropdown-menu.tasks-bar .task-info .desc p {
*    padding-top:0;
*    color:#8f8f9b;
*    font-weight:300;
*}
*.dropdown-menu.tasks-bar .task-info .percent {
*    width:20%;
*    float:right;
*    font-size:13px;
*    font-weight:600;
*    padding-left:10px;
*    line-height:normal;
*}
*.dropdown-menu.tasks-bar .progress {
*    background:#fff;
*}
*.dropdown-menu.extended .progress {
*    margin-bottom:0 !important;
*    height:10px;
*}
*.dropdown-menu.inbox li a .photo img {
*    border-radius:2px 2px 2px 2px;
*    -webkit-border-radius:2px 2px 2px 2px;
*    float:left;
*    height:40px;
*    margin-right:10px;
*    width:40px;
*}
*.dropdown-menu.inbox li a .subject {
*    display:block;
*}
*.dropdown-menu.inbox li a .subject .from {
*    font-size:12px;
*    font-weight:600;
*}
*.dropdown-menu.inbox li a .subject .time {
*    font-size:11px;
*    font-style:italic;
*    font-weight:bold;
*    position:absolute;
*    right:20px;
*}
*.dropdown-menu.inbox li a .message {
*    display:block !important;
*    font-size:11px;
*}
*.top-nav {
*    margin-top:20px;
*}
*.top-nav img {
*    border-radius:50%;
*    -webkit-border-radius:50%;
*    width:33px;
*}
*.top-nav .icon-user i {
*    height: 33px;
*    width:33px;
*    line-height: 33px;
*    display: inline-block;
*    font-size: 1.7em;
*    padding-left: 10px;
*}
*
*.top-nav .icon-user .username {
*    color: #555555;
*    font-size: 13px;
*    position: relative;
*    top: -5px;
*}
*
*.top-nav .icon-user .caret {
*    position: relative;
*    top: -4px;
*}
*
*.top-nav ul.top-menu>li .dropdown-menu.logout {
*    width:170px !important;
*}
*.top-nav li.dropdown .dropdown-menu {
*    float:right;
*    right:0;
*    left:auto;
*}
*.dropdown-menu.extended.logout>li {
*    float:left;
*    width:100%;
*}
*.log-arrow-up {
*    background:url('../images/top-arrow.png') no-repeat;
*    width:18px;
*    height:10px;
*    margin-top:-20px;
*    float:right;
*    margin-right:15px;
*}
*.dropdown-menu.extended.logout>li>a {
*    border-bottom:none !important;
*}
*.full-width .dropdown-menu.extended.logout>li>a:hover {
*    background:#F1F2F7 !important;
*    color:#32323a !important;
*}
*.dropdown-menu.extended.logout>li>a:hover {
*    background:#F1F2F7 !important;
*    border-radius:5px;
*}
*.dropdown-menu.extended.logout>li>a:hover i {
*    color:#32D2C9;
*}
*.dropdown-menu.extended.logout>li>a i {
*    font-size:17px;
*}
*.dropdown-menu.extended.logout>li>a>i {
*    padding-right:10px;
*}
*.top-nav .username {
*    font-size:13px;
*    color:#555555;
*}
*.top-nav ul.top-menu>li>a {
*    border-radius:100px;
*    -webkit-border-radius:100px;
*    padding:0px;
*    background:none;
*    margin-right:0;
*    border:1px solid #F6F6F6;
*    background:#F6F6F6;
*}
*.top-nav ul.top-menu>li.language>a {
*    margin-top:-2px;
*    padding:4px 12px;
*    line-height:20px;
*}
*.top-nav ul.top-menu>li.language>a img {
*    border-radius:0;
*    -webkit-border-radius:0;
*    width:18px;
*}
*.top-nav ul.top-menu>li.language ul.dropdown-menu li img {
*    border-radius:0;
*    -webkit-border-radius:0;
*    width:18px;
*}
*.top-nav ul.top-menu>li {
*    margin-left:10px;
*}
*.top-nav ul.top-menu>li>a:hover,.top-nav ul.top-menu>li>a:focus {
*    border:1px solid #f6f6f6;
*    background:#f6f6f6 !important;
*    border-radius:100px;
*    -webkit-border-radius:100px;
*}
*.top-nav .dropdown-menu.extended.logout {
*    top:50px;
*}
*.top-nav .nav .caret {
*    border-bottom-color:#A4AABA;
*    border-top-color:#A4AABA;
*}
*.top-nav ul.top-menu>li>a:hover .caret {
*    border-bottom-color:#000;
*    border-top-color: #000;
*}
*/*form*/
*.position-center {
*    width:62%;
*    margin: 0 auto;
*}
*/*----*/
*.notify-arrow {
*    background:url('../images/top-arrow.png') no-repeat;
*    width:18px;
*    height:10px;
*    margin-top:0;
*    opacity:0;
*    position:absolute;
*    left:16px;
*    top:-20px;
*    transition:all 0.25s ease 0s;
*    z-index:10;
*    margin-top:10px;
*    opacity: 1;
*}
*/*search*/
*.search {
*    width:20px;
*    -webkit-transition:all .3s ease;
*    -moz-transition:all .3s ease;
*    -ms-transition:all .3s ease;
*    -o-transition:all .3s ease;
*    transition:all .3s ease;
*    border:1px solid #fff;
*    box-shadow:none;
*    background:#f6f6f6 url('../images/search-icon.png') no-repeat 10px 8px;
*    padding:0 5px 0 30px;
*    color:#fff;
*    border-radius:100px;
*    -webkit-border-radius:100px;
*}
*.search:focus {
*    width:180px;
*    border:1px solid #f6f6f6;
*    box-shadow:none;
*    -webkit-transition:all .3s ease;
*    -moz-transition:all .3s ease;
*    -ms-transition:all .3s ease;
*    -o-transition:all .3s ease;
*    transition:all .3s ease;
*    color:#c8c8c8;
*    font-weight: 300;
*}
*.todo-search:focus{
*    width:100% !important;
*}
*/*--sidebar toggle---*/
*.sidebar-toggle-box {
*    float:left;
*    margin-top:23px;
*    margin-left:-15px;
*    background:#32d2c9;
*    border-radius:50%;
*    -webkit-border-radius:50%;
*    width:32px;
*    height:32px;
*    position:absolute;
*    right:-15px;
*}
*.sidebar-toggle-box .fa-bars {
*    cursor:pointer;
*    display:inline-block;
*    font-size:15px;
*    padding:8px 8px 8px 9px;
*    color:rgba(0,0,0,.3);
*}
*.sidebar-toggle-box:hover {
*    background:#F6F6F6;
*}
*.hide-left-bar {
*    margin-left:-240px !important;
*    -webkit-transition:all .3s ease-in-out;
*    -moz-transition:all .3s ease-in-out;
*    -o-transition:all .3s ease-in-out;
*    transition:all .3s ease-in-out;
*}
*.open-right-bar {
*    right:0px !important;
*    -webkit-transition:all .3s ease-in-out;
*    -moz-transition:all .3s ease-in-out;
*    -o-transition:all .3s ease-in-out;
*    transition:all .3s ease-in-out;
*}
*.merge-left {
*    margin-left:0px !important;
*}
*.hide-right-bar {
*    margin-right:-240px !important;
*    -webkit-transition:all .3s ease-in-out;
*    -moz-transition:all .3s ease-in-out;
*    -o-transition:all .3s ease-in-out;
*    transition:all .3s ease-in-out;
*}
*.toggle-right-box {
*    float:left;
*    background:#f6f6f6;
*    border-radius:50%;
*    -webkit-border-radius:50%;
*    width:35px;
*    height:35px;
*}
*.toggle-right-box:hover {
*    background:#32D2C9;
*}
*.toggle-right-box:hover .fa-bars {
*    color:rgba(0,0,0,0.3);
*}
*.toggle-right-box .fa-bars {
*    cursor:pointer;
*    display:inline-block;
*    font-size:15px;
*    padding:10px;
*    color: #bfbfc1;
*}
*/*right sidebar*/
*.right-sidebar {
*    background:#32323A;
*    width:240px;
*    position:fixed;
*    height:100%;
*    z-index:1000;
*    right:-240px;
*    top:0;
*    -webkit-transition:all .3s ease-in-out;
*    -moz-transition:all .3s ease-in-out;
*    -o-transition:all .3s ease-in-out;
*    transition:all .3s ease-in-out;
*}
*.open-right-panel {
*    margin-left:-240px !important;
*}
*.right-sidebar .search-row {
*    padding:20px;
*}
*.right-sidebar .search-row input {
*    background:rgba(0,0,0,0.3);
*    border:none;
*    color:#707076;
*    font-size:12px;
*}
*.right-side-accordion {
*    margin-top:6px;
*}
*.right-side-accordion .head {
*    padding:20px;
*    text-transform:uppercase;
*    width:100%;
*    display:inline-block;
*}
*.right-side-accordion .red-bg {
*    background:#fa8564;
*    color:#fff;
*}
*.right-side-accordion .terques-bg {
*    background:#45c9c4;
*    color:#fff;
*}
*.right-side-accordion .purple-bg {
*    background:#a48ad4;
*    color:#fff;
*}
*.right-side-accordion .yellow-bg {
*    background:#f3c022;
*    color:#fff;
*}
*.prog-row {
*    border-bottom:1px solid #3C3C44;
*    display:inline-block;
*    padding:20px 0;
*    width:100%;
*}
*.prog-row .progress {
*    margin-bottom:0;
*}
*.prog-row h4 {
*    margin:0;
*    font-size:12px;
*    text-transform:uppercase;
*    color:#fff;
*    font-weight:400;
*}
*.user-details h4 {
*    text-transform:none;
*    font-size:14px;
*    font-weight:300;
*}
*.prog-row p {
*    font-size:10px;
*    color:#8f8f9b;
*    margin-bottom:0;
*}
*.mtop10 {
*    margin-top:10px;
*}
*.user-thumb,.user-details,.user-status,.rsn-details {
*    float:left;
*}
*.user-thumb {
*    width:30px;
*    margin:0 10px 0 20px;
*}
*.user-thumb img {
*    border-radius:50%;
*    -webkit-border-radius:50%;
*    width:30px;
*    height:30px;
*}
*.user-details {
*    width:150px;
*}
*.rsn-details {
*    width:170px;
*}
*.rsn-details a,.rsn-details a:hover {
*    color:#a48ad4;
*    font-size:11px;
*}
*.user-details a {
*    color:#fff;
*}
*.user-status {
*    width:25px;
*    margin-top:5px;
*}
*.view-btn,.view-btn:hover {
*    color:#6c6c72;
*    margin:10px 0;
*    display:inline-block;
*}
*.view-btn:hover {
*    text-decoration:underline;
*}
*.rsn-activity i {
*    font-size: 30px;
*}
*/*state overview*/
*.state-overview .symbol,.state-overview .value {
*    display:inline-block;
*    text-align:center;
*}
*.state-overview .value {
*    float:right;
*}
*.state-overview .value h1,.state-overview .value p {
*    margin:0;
*    padding:0;
*    color:#c6cad6;
*}
*.state-overview .value h1 {
*    font-weight:300;
*}
*.state-overview .symbol i {
*    color:#fff;
*    font-size:50px;
*}
*.state-overview .symbol {
*    width:40%;
*    padding:25px 15px;
*    -webkit-border-radius:4px 0px 0px 4px;
*    border-radius:4px 0px 0px 4px;
*}
*.state-overview .value {
*    width:58%;
*    padding-top:21px;
*}
*.state-overview .terques {
*    background:#6ccac9;
*}
*.state-overview .red {
*    background:#ff6c60;
*}
*.state-overview .yellow {
*    background:#f8d347;
*}
*.state-overview .blue {
*    background: #57c8f2;
*}
*/*main chart*/
*.border-head h3 {
*    border-bottom:1px solid #c9cdd7;
*    margin-top:0;
*    margin-bottom:20px;
*    padding-bottom:5px;
*    font-weight:normal;
*    font-size:18px;
*    display:inline-block;
*    width:100%;
*    font-weight:300;
*}
*.custom-bar-chart {
*    height:290px;
*    margin-top:20px;
*    margin-left:10px;
*    position:relative;
*    border-bottom:1px solid #c9cdd7;
*}
*.custom-bar-chart .bar {
*    height:100%;
*    position:relative;
*    width:4.3%;
*    margin:0px 2%;
*    float:left;
*    text-align:center;
*    -webkit-border-radius:5px 5px 0 0;
*    -moz-border-radius:5px 5px 0 0x;
*    border-radius:5px 5px 0 0;
*    z-index:10;
*}
*.custom-bar-chart .bar .title {
*    position:absolute;
*    bottom:-30px;
*    width:100%;
*    text-align:center;
*    font-size:12px;
*}
*.custom-bar-chart .bar .value {
*    position:absolute;
*    bottom:0;
*    background:#bfc2cd;
*    color:#bfc2cd;
*    width:100%;
*    -webkit-border-radius:5px 5px 0 0;
*    -moz-border-radius:5px 5px 0 0;
*    border-radius:5px 5px 0 0;
*    -webkit-transition:all .3s ease;
*    -moz-transition:all .3s ease;
*    -ms-transition:all .3s ease;
*    -o-transition:all .3s ease;
*    transition:all .3s ease;
*}
*.custom-bar-chart .bar .value:hover {
*    background:#e8403f;
*    color:#fff;
*}
*.y-axis {
*    color:#555555;
*    position:absolute;
*    text-align:right;
*    width:100%;
*}
*.y-axis li {
*    border-top:1px dashed #dbdce0;
*    display:block;
*    height:58px;
*    width:100%;
*}
*.y-axis li:last-child {
*    border-top:none;
*}
*.y-axis li span {
*    display:block;
*    margin:-10px 0 0 -25px;
*    padding:0 10px;
*    width:40px;
*}
*.y-axis {
*    color:#555555;
*    text-align: right;
*}
*/*spark line*/
*.chart {
*    display:inline-block;
*    text-align:center;
*    width:100%;
*}
*.chart .heading {
*    text-align:left;
*}
*.chart .heading span {
*    display:block;
*}
*.panel.green-chart .chart-tittle {
*    font-size:16px;
*    padding:15px;
*    display:inline-block;
*    font-weight:normal;
*    background:#99c262;
*    width:100%;
*    -webkit-border-radius:0px 0px 4px 4px;
*    border-radius:0px 0px 4px 4px;
*}
*#barchart {
*    margin-bottom:-15px;
*    display:inline-block;
*}
*.chart-tittle .title {
*}
*.panel.green-chart .chart-tittle .value {
*    float:right;
*    color:#c0f080;
*}
*.panel.green-chart {
*    background:#a9d96c;
*    color:#fff;
*}
*.panel.terques-chart {
*    background:#41cac0;
*    color:#fff;
*}
*.panel.terques-chart .chart-tittle .value {
*    float:right;
*    color:#fff;
*}
*.panel.terques-chart .chart-tittle .value a {
*    color:#fff;
*    font-size:12px;
*}
*.panel.terques-chart .chart-tittle .value a:hover,.panel.terques-chart .chart-tittle .value a.active {
*    color:#55f2e7;
*    font-size:12px;
*}
*.panel.terques-chart .chart-tittle {
*    font-size:16px;
*    padding:15px;
*    display:inline-block;
*    font-weight:normal;
*    background:#39b7ac;
*    width:100%;
*    -webkit-border-radius:0px 0px 4px 4px;
*    border-radius:0px 0px 4px 4px;
*}
*.inline-block {
*    display:inline-block;
*}
*.gen-case {
*    text-transform: none;
*}
*/**/
*/*personal task*/
*.task-thumb {
*    width:90px;
*    float:left;
*}
*.task-thumb img {
*    border-radius:4px;
*    -webkit-border-radius:4px;
*}
*.task-thumb-details {
*    display:inline-block;
*    margin:25px 0 0 10px;
*}
*.task-progress {
*    float:left;
*}
*.task-thumb-details h1,.task-thumb-details h1 a,.task-progress h1,.task-progress h1 a {
*    color:#39b5aa;
*    font-size:18px;
*    margin:0;
*    padding:0;
*    font-weight:400;
*}
*.task-thumb-details p,.task-progress p {
*    padding-top:5px;
*    color:#a4aaba;
*}
*.personal-task tbody tr td {
*    padding:11px 15px;
*    border-color:#eeeff1;
*}
*.personal-task tbody tr td i {
*    font-size:20px;
*    color:#c7cbd4;
*}
*.personal-task.table-hover>tbody>tr:hover>td,.table-hover>tbody>tr:hover>th {
*    background-color:#f7f8fc;
*}
*.personal-task.table-hover>tbody>tr:hover>td i {
*    color:#39b5aa;
*}
*.personal-task>tbody>tr>td:last-child {
*    text-align:right;
*}
*.task-option {
*    float:right;
*}
*.task-option select {
*    height:35px;
*    border:1px solid #eaeaea;
*    border-radius:4px;
*    -webkit-border-radius:4px;
*    padding:8px;
*    color:#a4abbb;
*}
*.progress-panel {
*    padding-bottom: 5px;
*}
*/*badge*/
*.badge.bg-primary {
*    background:#8075c4;
*}
*.badge.bg-success {
*    background:#a9d86e;
*}
*.badge.bg-warning {
*    background:#FCB322;
*}
*.badge.bg-important {
*    background:#ff6c60;
*}
*.badge.bg-info {
*    background:#41cac0;
*}
*.badge.bg-inverse {
*    background: #2A3542;
*}
*/*timeline*/
*.timeline {
*    border-collapse:collapse;
*    border-spacing:0;
*    display:table;
*    position:relative;
*    table-layout:fixed;
*    width:100%;
*}
*.timeline .time-show {
*    margin-right:-75px;
*    margin-top:30px;
*    position:relative;
*    margin-bottom:30px;
*}
*.timeline .time-show.first {
*    /*margin-top:-80px;*/
*}
*.time-show .btn {
*    width:150px;
*}
*.timeline .time-show a {
*    color:#fff;
*}
*.timeline:before {
*    background-color:#d8d9df;
*    bottom:0px;
*    content:'';
*    left:50%;
*    position:absolute;
*    top:30px;
*    width:1px;
*    z-index:0;
*}
*h3.timeline-title {
*    margin:0;
*    color:#C8CCD7;
*    font-size:20px;
*    font-weight:400;
*    margin:0 0 5px;
*    text-transform:uppercase;
*}
*.t-info {
*    color:#C8CCD7;
*}
*.timeline-item:before,.timeline-item.alt:after {
*    content:'';
*    display:block;
*    width:50%;
*}
*.timeline-item {
*    display:table-row;
*}
*.timeline-desk {
*    display:table-cell;
*    vertical-align:top;
*    width:50%;
*}
*.timeline-desk h1 {
*    font-size:16px;
*    font-weight:300;
*    margin:0 0 5px;
*}
*.timeline-desk .panel {
*    display:block;
*    margin-left:45px;
*    position:relative;
*    text-align:left;
*    background:#fff;
*}
*.timeline-item .timeline-desk .arrow {
*    border-bottom:8px solid transparent;
*    border-top:8px solid transparent;
*    display:block;
*    height:0;
*    left:-7px;
*    position:absolute;
*    top:13px;
*    width:0;
*}
*.timeline-item .timeline-desk .arrow {
*    border-right:8px solid #fff !important;
*}
*.timeline-item.alt .timeline-desk .arrow-alt {
*    border-bottom:8px solid transparent;
*    border-top:8px solid transparent;
*    display:block;
*    height:0;
*    right:-7px;
*    position:absolute;
*    top:13px;
*    width:0;
*    left:auto;
*}
*.timeline-item.alt .timeline-desk .arrow-alt {
*    border-left:8px solid #fff !important;
*}
*.timeline .timeline-icon {
*    left:-60px;
*    position:absolute;
*    top:5px;
*}
*.timeline .timeline-icon {
*    background:#C7CBD6;
*    /*box-shadow:0 0 0 3px #C7CBD6;*/
*}
*.timeline-desk span a {
*    text-transform:uppercase;
*}
*.timeline-desk h1.red,.timeline-desk span a.red {
*    color:#EF6F66;
*}
*.timeline-desk h1.green,.timeline-desk span a.green {
*    color:#39B6AE;
*}
*.timeline-desk h1.blue,.timeline-desk span a.blue {
*    color:#56C9F5;
*}
*.timeline-desk h1.purple,.timeline-desk span a.purple {
*    color:#8074C6;
*}
*.timeline-desk h1.light-green,.timeline-desk span a.light-green {
*    color:#A8D76F;
*}
*.timeline-desk h1.yellow,.timeline-desk span a.yellow {
*    color:#fed65a;
*}
*.timeline .timeline-icon.red {
*    background:#EF6F66;
*}
*.timeline .timeline-icon.green {
*    background:#39B6AE;
*}
*.timeline .timeline-icon.blue {
*    background:#56C9F5;
*}
*.timeline .timeline-icon.purple {
*    background:#8074C6;
*}
*.timeline .timeline-icon.light-green {
*    background:#A8D76F;
*}
*.timeline .timeline-icon.yellow {
*    background:#fed65a;
*}
*.timeline .timeline-icon {
*    border-radius:50%;
*    -webkit-border-radius:50%;
*    display:block;
*    height:30px;
*    width:30px;
*    text-align:center;
*    color:#fff;
*}
*.timeline .timeline-icon i {
*    margin-top:9px;
*}
*.timeline-item.alt .timeline-icon {
*    left:auto;
*    right:-60px;
*}
*.timeline .time-icon:before {
*    font-size:16px;
*    margin-top:5px;
*}
*.timeline .timeline-date {
*    left:-245px;
*    position:absolute;
*    text-align:right;
*    top:12px;
*    width:150px;
*    display:none;
*}
*.timeline-item.alt .timeline-date {
*    left:auto;
*    right:-245px;
*    text-align:left;
*    display:none;
*}
*.timeline-desk h5 span {
*    color:#999999;
*    display:block;
*    font-size:12px;
*    margin-bottom:4px;
*}
*.timeline-item.alt:before {
*    display:none;
*}
*.timeline-item:before,.timeline-item.alt:after {
*    content:'';
*    display:block;
*    width:50%;
*}
*.timeline-desk p {
*    font-size:14px;
*    margin-bottom:0;
*    color:#999;
*}
*.timeline-desk a {
*    color:#1fb5ad;
*}
*.timeline-desk .panel {
*    margin-bottom:5px;
*}
*.timeline-desk .album {
*    margin-top:20px;
*}
*.timeline-item.alt .timeline-desk .album {
*    margin-top:20px;
*    float:right;
*}
*.timeline-desk .album a {
*    margin-right:5px;
*    float:left;
*}
*.timeline-item.alt .timeline-desk .album a {
*    margin-left:5px;
*    float:right;
*}
*.timeline-desk .notification {
*    background:none repeat scroll 0 0 #FFFFFF;
*    margin-top:20px;
*    padding:8px;
*}
*.timeline-item.alt .panel {
*    margin-left:0;
*    margin-right:45px;
*}
*.mbot30 {
*    margin-bottom:30px;
*}
*.timeline-item.alt h1,.timeline-item.alt p {
*    text-align: right;
*}
*/*---revenue----*/
*.revenue-head {
*    background:#ff6c60;
*    -webkit-border-radius:4px 4px 0px 0px;
*    border-radius:4px 4px 0px 0px;
*    color:#fff;
*    line-height:50px;
*}
*.revenue-head span {
*    background:#e56155;
*    padding:16px;
*    -webkit-border-radius:4px 0px 0px 0px;
*    border-radius:4px 0px 0px 0px;
*}
*.revenue-head span i {
*    font-size:18px;
*}
*.revenue-head h3 {
*    display:inline;
*    padding:0 10px;
*    font-size:16px;
*    font-weight:300;
*}
*.revenue-head span.rev-combo {
*    background:#e56155;
*    padding:16px;
*    line-height:normal;
*    -webkit-border-radius:0px 4px 0px 0px;
*    border-radius: 0px 4px 0px 0px;
*}
*/*easy pie chart*/
*.easy-pie-chart {
*    display:inline-block;
*    padding:30px 0;
*}
*.chart-info,.chart-info .increase,.chart-info .decrease {
*    display:inline-block;
*}
*.chart-info {
*    width:100%;
*    margin-bottom:5px;
*}
*.chart-position {
*    margin-top:70px;
*}
*.chart-info span {
*    margin:0 3px;
*}
*.chart-info .increase {
*    background:#ff6c60;
*    width:10px;
*    height:10px;
*}
*.chart-info .decrease {
*    background:#f2f2f2;
*    width:10px;
*    height:10px;
*}
*.panel-footer.revenue-foot {
*    background-color:#e6e7ec;
*    -webkit-border-radius:0px 0px 4px 4px;
*    border-radius:0px 0px 4px 4px;
*    border:none;
*    padding:0;
*    width:100%;
*    display: inline-block;
*}
*@media screen and (-webkit-min-device-pixel-ratio:0) {
*    /* Safari and Chrome */
*    .panel-footer.revenue-foot {
*        margin-bottom:-4px;
*    }
*}
*.panel-footer.revenue-foot ul {
*    margin:0;
*    padding:0;
*    width:100%;
*    display:inline-flex;
*}
*.panel-footer.revenue-foot ul li {
*    float:left;
*    width:33.33%;
*}
*.panel-footer.revenue-foot ul li.first a:hover,.panel-footer.revenue-foot ul li.first a {
*    -webkit-border-radius:0px 0px 0px 4px;
*    border-radius:0px 0px 0px 4px;
*}
*.panel-footer.revenue-foot ul li.last a:hover,.panel-footer.revenue-foot ul li.last a {
*    -webkit-border-radius:0px 0px 4px 0px;
*    border-radius:0px 0px 4px 0px;
*    border-right:none;
*}
*.panel-footer.revenue-foot ul li a {
*    display:inline-block;
*    width:100%;
*    padding:14px 15px;
*    text-align:center;
*    border-right:1px solid #d5d8df;
*    color:#797979;
*}
*.panel-footer.revenue-foot ul li a:hover,.panel-footer.revenue-foot ul li.active a {
*    background:#fff;
*    position:relative;
*}
*.panel-footer.revenue-foot ul li a i {
*    color:#c6cad5;
*    display:block;
*    font-size:16px;
*}
*.panel-footer.revenue-foot ul li a:hover i,.panel-footer.revenue-foot ul li.active a i {
*    color:#ff6c60;
*    display:block;
*    font-size: 16px;
*}
*/*flatlab carousel model*/
*.flat-carousal {
*    background:#58c9f3;
*    -webkit-border-radius:4px 4px 0px 0px;
*    border-radius:4px 4px 0px 0px;
*    padding:10px;
*    color:#fff;
*    position:relative;
*}
*.flat-carousal h1 {
*    text-align:center;
*    font-size:16px;
*    margin:30px 20px;
*    line-height:20px;
*    font-weight:300;
*    font-style:italic;
*}
*a.view-all {
*    color:#fff;
*    background:rgba(0,0,0,0.1);
*    padding:8px 15px;
*    text-align:center;
*    border-radius:25px;
*    -webkit-border-radius:25px;
*    margin-bottom:18px;
*    display:inline-block;
*    text-transform:uppercase;
*    font-size:12px;
*}
*ul.ft-link {
*    margin:0;
*    padding:0;
*}
*ul.ft-link li {
*    border-right:1px solid #E6E7EC;
*    display:inline-block;
*    line-height:30px;
*    margin:8px 0;
*    text-align:center;
*    width:24%;
*}
*ul.ft-link li a {
*    color:#74829c;
*    text-transform:uppercase;
*    font-size:12px;
*}
*ul.ft-link li a:hover,ul.ft-link li.active a {
*    color:#58c9f3;
*}
*ul.ft-link li:last-child {
*    border-right:none;
*}
*ul.ft-link li a i {
*    display: block;
*}
*/*product post*/
*.post-wrap aside {
*    display:table-cell;
*    float:none;
*    height:100%;
*    padding:0;
*    vertical-align:top;
*}
*.pro-box {
*    border-collapse:collapse;
*    border-spacing:0;
*    display:table;
*    table-layout:fixed;
*    width:100%;
*}
*.post-info {
*    position:relative;
*}
*.arrow-pro.right:after {
*    border-left-color:#FFFFFF;
*    border-right-width:0;
*    top:85px;
*    content:' ';
*}
*.arrow-pro.left:after {
*    border-right-color:#FFFFFF;
*    border-left-width:0;
*    top:80px;
*    content:' ';
*}
*.arrow-pro.left {
*    left:-8px;
*}
*.arrow-pro:after {
*    border-width:7px;
*    content:'';
*}
*.arrow-pro,.arrow-pro:after {
*    border-color:rgba(0,0,0,0);
*    border-style:solid;
*    display:block;
*    height:0;
*    position:absolute;
*    width:0;
*    right:-5px;
*}
*.post-highlight.yellow {
*    background:#f8d347;
*    border-radius:0px 4px 4px 0px;
*    -webkit-border-radius:0px 4px 4px 0px;
*}
*.post-highlight.terques {
*    background:#41cac0;
*    border-radius:4px 0px 0px 04px;
*    -webkit-border-radius:4px 0px 0px 04px;
*}
*.post-info h1 {
*    margin:0;
*    font-size:18px;
*    color:#a19899;
*    font-weight:300;
*}
*.post-highlight.terques h2 {
*    font-size:16px;
*    color:#fff;
*    font-style:italic;
*    padding:0 20px;
*    line-height:22px;
*    margin:0;
*    font-weight:300;
*}
*.post-highlight.terques h2 span,.post-highlight.terques h2 a {
*    color:#92faf3;
*}
*.post-info h1 strong {
*    text-transform:uppercase;
*    color:#937b7b;
*}
*.post-info .desk {
*    display:inline-block;
*}
*.post-info .desk h3 {
*    font-size:16px;
*}
*.post-info .desk.yellow h3 {
*    color:#f8d347;
*}
*.post-btn {
*}
*.post-btn a {
*    float:left;
*    margin-right:8px;
*    font-size:18px;
*    color:#9a9a9a;
*}
*.post-btn a:hover {
*    color:#727272;
*}
*.pro-thumb {
*    text-align:center;
*    display:inline-block;
*    border-radius:50%;
*    -webkit-border-radius:50%;
*    border:10px solid rgba(256,256,256,0.4);
*}
*.pro-thumb img {
*    text-align:center;
*    width:112px;
*    height:112px;
*    border-radius:50%;
*    -webkit-border-radius:50%;
*}
*.v-align {
*    vertical-align:middle !important;
*}
*.twite h1 {
*    margin:50px 0;
*}
*.social-footer {
*    display:inline;
*    text-align:center;
*}
*.social-footer ul {
*    text-align:center;
*    margin:0;
*    padding:0;
*}
*.social-footer ul li {
*    display:inline-block;
*    margin:0 20px;
*}
*.social-footer ul li a {
*    font-size:25px;
*    color:#ceced0;
*}
*.social-footer ul li a:hover i.fa-facebook,.social-footer ul li.active a i.fa-facebook {
*    color:#486eac;
*}
*.social-footer ul li a:hover i.fa-twitter,.social-footer ul li.active a i.fa-twitter {
*    color:#58c9f3;
*}
*.social-footer ul li a:hover i.fa-google-plus,.social-footer ul li.active a i.fa-google-plus {
*    color:#4a4a4a;
*}
*.social-footer ul li a:hover i.fa-pinterest,.social-footer ul li.active a i.fa-pinterest {
*    color: #d1282d;
*}
*/*pie chart */
*.pie-foot {
*    background:#6b6b6b;
*    padding:18px 15px;
*    color:#fff;
*    border-radius:0 0 4px 4px;
*    -webkit-border-radius:0 0 4px 4px;
*    text-align:center;
*    font-size:16px;
*    font-weight: 300;
*}
*/*follower*/
*.follower {
*    background:#01a89e;
*    color:#fff;
*    text-align:center;
*    border-radius:4px 4px 0 0;
*    -webkit-border-radius:4px 4px 0 0;
*}
*.follower-foot {
*    padding:8px 5px 5px 5px;
*    color:#757575;
*    border-radius:0 0 4px 4px;
*    -webkit-border-radius:0 0 4px 4px;
*    font-weight:300;
*}
*.follower-foot ul {
*    padding:0;
*    margin:0;
*}
*.follower-foot ul li {
*    display:inline-block;
*    text-align:center;
*    width:48%;
*    line-height:normal;
*}
*.follower-foot ul li h5 {
*    margin:5px 0 0 0;
*}
*.follower h4 {
*    margin:0 0 10px 0;
*    font-size:15px;
*    font-weight:300;
*}
*.follow-ava {
*    border-radius:50%;
*    -webkit-border-radius:50%;
*    border:5px solid #18b2a6;
*    display:inline-block;
*}
*.follower img {
*    border-radius:50%;
*    -webkit-border-radius:50%;
*    width:62px;
*    height:62px;
*    /*display: inline-block;*/
*}
*/*weather*/
*.weather-bg {
*    background:#8175c7;
*    border-radius:4px 4px 0 0;
*    -webkit-border-radius:4px 4px 0 0;
*    color:#fff;
*    text-align:center;
*    font-size:16px;
*    font-weight:300;
*}
*.weather-bg i {
*    font-size:60px;
*    display:block;
*}
*.weather-bg .degree {
*    font-size:60px;
*}
*.weather-category {
*    padding:15px 0;
*    color:#74829C;
*}
*.weather-category ul {
*    padding:0;
*    margin:0;
*    display:inline-block;
*    width:100%;
*}
*.weather-category ul li {
*    display:inline-block;
*    width:32%;
*    text-align:center;
*    border-right:1px solid #e6e6e6;
*    display:inline-block;
*}
*.weather-category ul li h5 {
*    margin:0 0 5px 0;
*    text-transform:uppercase;
*    font-weight:300;
*}
*.weather-category ul li a {
*}
*.weather-category ul li:last-child {
*    border-right: none;
*}
*/*fontawesome*/
*.fontawesome-icon-list h2 {
*    margin-top:0;
*    font-size:20px;
*    font-weight:300;
*}
*.fontawesome-icon-list .col-sm-4,.fontawesome-icon-list .col-md-3,.fontawesome-icon-list .col-xs-6 {
*    margin-bottom:10px;
*}
*.fontawesome-icon-list .page-header {
*    border-bottom:1px solid #C9CDD7;
*}
*.fontawesome-icon-list a {
*    color:#797979;
*}
*.fontawesome-icon-list a:hover {
*    color:#35404D;
*}
*.fontawesome-icon-list i {
*    font-size:16px;
*    padding-right:10px;
*}
*#web-application,#text-editor,#directional,#video-player,#brand,#medical,#currency {
*    margin-top: 10px;
*}
*/*mail inbox*/
*.mail-nav {
*    margin:15px -15px 0 -15px;
*}
*.mail-nav li a {
*    border-radius:0;
*    -webkit-border-radius:0;
*    border-top:1px solid #f2f3f6;
*    padding:15px;
*    border-right:3px solid rgba(0,0,0,0);
*}
*.mail-nav>li>a:hover,.mail-nav>li>a:focus {
*    background:#fafafa;
*    color:#1fb5ad;
*    border-right:3px solid #1fb5ad;
*}
*.mail-nav>li.active>a,.mail-nav>li.active>a:hover,.mail-nav>li.active>a:focus {
*    background:#fafafa;
*    color:#1fb5ad;
*    border-right:3px solid #1fb5ad;
*}
*.mail-nav>li+li {
*    margin-left:0;
*    margin-top:0px;
*}
*.mail-nav i {
*    font-size:16px;
*    margin-right:10px;
*}
*.inbox-notification {
*    margin-top:-2px;
*}
*.user-head .inbox-avatar {
*    width:65px;
*    float:left;
*}
*.user-head .inbox-avatar img {
*    border-radius:4px;
*    -webkit-border-radius:4px;
*}
*.user-head .user-name {
*    display:inline-block;
*    margin:0 0 0 10px;
*}
*.user-head .user-name h5 {
*    font-size:14px;
*    margin-top:15px;
*    margin-bottom:0;
*    font-weight:300;
*}
*.user-head .user-name h5 a {
*    color:#fff;
*}
*.user-head .user-name span a {
*    font-size:12px;
*    color:#87e2e7;
*}
*a.mail-dropdown {
*    background:#80d3d9;
*    padding:3px 5px;
*    font-size:10px;
*    color:#01a7b3;
*    border-radius:2px;
*    margin-top:20px;
*}
*.inbox-body {
*    padding:20px;
*}
*.btn-compose {
*    background:#1fb5ad;
*    padding:12px 0;
*    text-align:center;
*    width:100%;
*    color:#fff;
*}
*.btn-compose:hover,.btn-compose:focus {
*    background:#1ca59e;
*    color:#fff;
*}
*ul.inbox-nav {
*    display:inline-block;
*    width:100%;
*    margin:0;
*    padding:0;
*}
*.inbox-divider {
*    border-bottom:1px solid #d5d8df;
*}
*.inbox-action {
*    margin-top:50px;
*}
*.src-position {
*    margin-top:-7px;
*}
*.mail-src-position {
*    margin-top:-3px;
*}
*ul.labels-info {
*    border-bottom:1px solid #f1f2f7;
*    margin-bottom:10px;
*}
*ul.inbox-nav li {
*    display:inline-block;
*    line-height:45px;
*    width:100%;
*}
*ul.inbox-nav li a {
*    color:#6a6a6a;
*    line-height:45px;
*    width:100%;
*    display:inline-block;
*    padding:0 20px;
*}
*ul.inbox-nav li a:hover,ul.inbox-nav li.active a,ul.inbox-nav li a:focus {
*    color:#6a6a6a;
*    background:#d5d7de;
*}
*ul.inbox-nav li a i {
*    padding-right:10px;
*    font-size:16px;
*    color:#6a6a6a;
*}
*ul.inbox-nav li a span.label {
*    margin-top:13px;
*}
*ul.labels-info li h4 {
*    padding-top:5px;
*    color:#5c5c5e;
*    font-size:15px;
*    text-transform:uppercase;
*}
*ul.labels-info li {
*    margin:0;
*}
*ul.labels-info li a {
*    color:#6a6a6a;
*    border-radius:0;
*    padding-left:0;
*    padding-right:0;
*}
*ul.labels-info li a:hover,ul.labels-info li a:focus {
*    color:#6a6a6a;
*    background:none;
*}
*ul.labels-info li a i {
*    padding-right:10px;
*}
*.nav.nav-pills.nav-stacked.labels-info p {
*    margin-bottom:0;
*    padding:0 22px;
*    color:#9d9f9e;
*    font-size:11px;
*}
*.inbox-head {
*    padding:20px;
*    background:#41cac0;
*    color:#fff;
*    border-radius:0 4px 0 0;
*    -webkit-border-radius:0 4px 0 0;
*    min-height:80px;
*}
*.inbox-head h3 {
*    margin:0;
*    display:inline-block;
*    padding-top:6px;
*    font-weight:300;
*}
*.inbox-head .sr-input {
*    height:40px;
*    border:none;
*    box-shadow:none;
*    padding:0 10px;
*    float:left;
*    border-radius:4px 0 0 4px;
*    color:#8a8a8a;
*}
*.inbox-head .sr-btn {
*    height:40px;
*    border:none;
*    background:#00a6b2;
*    color:#fff;
*    padding:0 20px;
*    border-radius:0 4px 4px 0;
*    -webkit-border-radius:0 4px 4px 0;
*}
*.wht-bg {
*    background:#fff;
*}
*.wht-bg h4 {
*    font-size:24px;
*    color:#a2a2a2;
*    font-weight:300;
*}
*.table-inbox-wrap {
*    margin:0 -15px;
*}
*.mail-checkbox {
*    margin-right:10px;
*}
*.table-inbox {
*    margin:0;
*}
*.table-inbox tr td {
*    padding:12px !important;
*}
*.table-inbox tr td:first-child {
*    width:5%;
*}
*.table-inbox tr td:first-child .icheckbox_minimal {
*    margin-left:15px;
*}
*.table-inbox tr td:hover {
*    cursor:pointer;
*}
*.table-inbox tr td .fa-star.inbox-started,.table-inbox tr td .fa-star:hover {
*    color:#f78a09;
*}
*.table-inbox tr td .fa-star {
*    color:#d5d5d5;
*}
*.table-inbox tr.unread td {
*    font-weight:600;
*    background:#f7f7f7;
*}
*
*.table-inbox tr.unread a {
*    color: #32323a;
*}
*.table-inbox tr a {
*    color: #767676;
*}
*
*ul.inbox-pagination {
*    float:right;
*    list-style-type: none;
*}
*ul.inbox-pagination li {
*    float:left;
*}
*
*.pagination li a {
*    color: #32323a;
*}
*.mail-option {
*    display:inline-block;
*    margin-bottom:10px;
*    width:100%;
*}
*.mail-option .chk-all {
*    float:left;
*}
*.mail-option .chk-all,.mail-option .btn-group {
*    margin-right:5px;
*}
*.mail-option .chk-all,.mail-option .btn-group a.btn {
*    border:1px solid #e7e7e7;
*    padding:5px 10px;
*    display:inline-block;
*    background:#fcfcfc;
*    color:#afafaf;
*    border-radius:3px !important;
*    -webkit-border-radius:3px !important;
*}
*.inbox-pagination a.np-btn {
*    border:1px solid #e7e7e7;
*    padding:5px 15px;
*    display:inline-block;
*    background:#fcfcfc;
*    color:#afafaf;
*    border-radius:3px !important;
*    -webkit-border-radius:3px !important;
*}
*.mail-option .chk-all input[type=checkbox] {
*    margin-top:0;
*}
*.mail-option .btn-group a.all {
*    padding:0;
*    border:none;
*}
*.inbox-pagination a.np-btn {
*    margin-left:5px;
*}
*.inbox-pagination li span {
*    display:inline-block;
*    margin-top:7px;
*    margin-right:5px;
*}
*.fileinput-button {
*    border:1px solid #e6e6e6;
*    background:#eeeeee;
*}
*.inbox-body .modal .modal-body input,.inbox-body .modal .modal-body textarea {
*    border:1px solid #e6e6e6;
*    box-shadow:none;
*}
*.btn-send,.btn-send:hover {
*    background:#00A8B3;
*    color:#fff;
*}
*.btn-send:hover {
*    background:#009da7;
*}
*.modal-header h4.modal-title {
*    font-weight:300;
*    font-family:'Open Sans',sans-serif;
*}
*.modal-body label {
*    font-weight:400;
*    font-family: 'Open Sans',sans-serif;
*}
*
*.compose-mail {
*    width: 100%;
*    display: inline-block;
*    position: relative;
*    margin-top: 20px;
*}
*
*
*.compose-mail .compose-options {
*    color: #979797;
*    cursor: pointer;
*    display: inline-block;
*    font-size: 14px;
*    position: absolute;
*    right: 10px;
*    top: 7px;
*}
*
*.compose-mail input, .compose-mail input:focus {
*    border:none;
*    padding: 0;
*    width: 80%;
*    float: left;
*}
*.compose-mail .form-group {
*    border:1px solid #F2F3F6;
*    display: inline-block;
*    width: 100%;
*    margin-bottom: 0;
*}
*
*.compose-mail .form-group label {
*    line-height: 34px;
*    width: 10%;
*    float: left;
*    padding-left: 5px;
*    margin-bottom: 0;
*}
*
*.compose-editor input {
*    margin-top: 15px;
*}
*
*.compose-editor {
*    margin-bottom: 15px;
*    display: inline-block;
*    width: 100%;
*}
*
*.compose-btn {
*    float: left;
*    margin-top: 6px;
*}
*
*.mail-header h4 {
*    font-weight: 300;
*}
*
*.mail-sender, .attachment-mail {
*    width: 100%;
*    display: inline-block;
*    margin: 20px 0;
*    border-top:1px solid #EFF2F7 ;
*    border-bottom:1px solid #EFF2F7 ;
*    padding: 10px 0;
*
*}
*
*.mail-sender img {
*    width: 30px;
*    border-radius: 3px;
*    -webkit-border-radius: 3px;
*}
*
*.mail-sender .date {
*    line-height: 30px;
*    margin-bottom: 0;
*    text-align: right;
*}
*
*.view-mail a, .attachment-mail a:hover {
*    color: #35bcb5;
*}
*
*.attachment-mail a{
*    color: #32323a;
*}
*
*.attachment-mail ul li  {
*    float: left;
*    width: 200px;
*    margin-right: 15px;
*    margin-top: 15px;
*    list-style: none;
*}
*
*.attachment-mail ul li a.atch-thumb img {
*    width: 200px;
*    height: 180px;
*    margin-bottom: 10px;
*}
*
*.attachment-mail ul li a.name span {
*    float: right;
*    color: #767676;
*}
*
*/*404 page*/
*.body-404 {
*    background:#35bcb5;
*    color:#fff;
*}
*.error-head {
*    background:#fff;
*    height:280px;
*}
*.error-wrapper {
*    text-align:center;
*}
*.error-wrapper h1 {
*    font-size:90px;
*    font-weight:300;
*    margin:-141px 0 0 0;
*    text-align:center;
*}
*.error-wrapper h2 {
*    font-size:58px;
*    font-weight:300;
*    margin:0;
*    text-transform:uppercase;
*}
*.error-desk {
*    background:rgba(0,0,0,0.05);
*    margin-top:-27px;
*    padding:30px 0;
*}
*.error-wrapper p,.error-wrapper p a {
*    font-size:18px;
*    font-weight:300;
*    margin:0;
*}
*.error-wrapper p.nrml-txt {
*    color:#03f1e4;
*    font-size:40px;
*    margin:0;
*}
*.back-btn,.back-btn:hover {
*    border:1px solid rgba(255,255,255,.5);
*    padding:10px 15px;
*    margin-top:100px;
*    display:inline-block;
*    border-radius:5px;
*    -webkit-border-radius:5px;
*    color:#fff;
*    font-size:16px;
*    font-weight:300;
*}
*.back-btn:hover {
*    background:#fff;
*    color: #02a9a0;
*}
*/*500 page*/
*.body-500 {
*    background:#a48ad4;
*    color:#fff;
*}
*.error-wrapper p.page-500 {
*    color:#afa5f1;
*}
*.body-500 .back-btn:hover {
*    background:#fff;
*    color:#a48ad4;
*}
*.error-wrapper p.nrml-txt-alt {
*    color:#fff;
*    font-size:34px;
*    margin:0;
*    text-transform:uppercase;
*}
*.sp-link,.sp-link:hover {
*    color:#ffef3b;
*    text-decoration:underline;
*}
*.sp-link:hover {
*    text-decoration: none;
*}
*/*profile*/
*.profile-information .profile-pic img {
*    width:160px;
*    height:160px;
*    border-radius:50%;
*    -webkit-border-radius:50%;
*    border:10px solid #f1f2f7;
*    margin-top:20px;
*}
*.profile-information .profile-desk {
*    border-right:1px solid #ddd;
*    padding-right:30px;
*}
*.profile-information .profile-desk h1 {
*    color:#1fb5ad;
*    font-size:24px;
*    font-weight:bold;
*    margin-bottom:0;
*}
*.profile-information .profile-desk span,.profile-information .profile-desk p {
*    padding-bottom:25px;
*    display:inline-block;
*}
*.profile-information .profile-statistics h1 {
*    color:#757575;
*    font-size:24px;
*    font-weight:400;
*    margin-bottom:5px;
*}
*.profile-information .profile-statistics p {
*    margin-bottom:15px;
*    display:inline-block;
*}
*.profile-information .profile-statistics ul {
*    margin-top:10px;
*}
*.profile-information .profile-statistics ul li {
*    float:left;
*    margin-right:10px;
*    list-style: none;
*}
*.profile-information .profile-statistics ul li a {
*    background:#f6f6f6;
*    text-align:center;
*    border-radius:50%;
*    -webkit-border-radius:50%;
*    width:30px;
*    height:30px;
*    line-height:30px;
*    float:left;
*}
*.profile-information .profile-statistics ul li a:hover {
*    color: #1fb5ad;
*}
*/*-----*/
*.profile-nav .user-heading {
*    color:#fff;
*    border-radius:4px 4px 0 0;
*    -webkit-border-radius:4px 4px 0 0;
*    padding:30px;
*    text-align:center;
*}
*.profile-nav .user-heading.round a {
*    border-radius:50%;
*    -webkit-border-radius:50%;
*    border:10px solid rgba(256,256,256,0.3);
*    display:inline-block;
*}
*.profile-nav .user-heading a img {
*    width:112px;
*    height:112px;
*    border-radius:50%;
*    -webkit-border-radius:50%;
*}
*.profile-nav .user-heading h1 {
*    font-size:20px;
*    font-weight:300;
*    margin-bottom:5px;
*}
*.profile-nav .user-heading p {
*    font-size:16px;
*    color:#8b8b8b;
*    line-height:25px;
*}
*.profile-nav ul {
*    margin-top:1px;
*}
*.profile-nav ul>li {
*    border-bottom:1px solid #ebeae6;
*    margin-top:0;
*    line-height:30px;
*}
*.profile-nav ul>li:last-child {
*    border-bottom:none;
*}
*.profile-nav ul>li>a {
*    border-radius:0;
*    -webkit-border-radius:0;
*    color:#89817f;
*}
*.profile-nav ul>li>a:hover,.profile-nav ul>li>a:focus,.profile-nav ul li.active a {
*    background:#f8f7f5 !important;
*    color:#89817f !important;
*}
*.profile-nav ul>li:last-child>a:last-child {
*    border-radius:0 0 4px 4px;
*    -webkit-border-radius:0 0 4px 4px;
*}
*.profile-nav ul>li>a>i {
*    font-size:16px;
*    padding-right:10px;
*    color:#bcb3aa;
*}
*.r-activity {
*    margin:6px 0 0;
*    font-size: 12px;
*}
*/*-----*/
*.recent-act {
*    border-collapse:collapse;
*    border-spacing:0;
*    display:table;
*    position:relative;
*    table-layout:fixed;
*    width:100%;
*}
*.recent-act:before {
*    background-color:#eeeeee;
*    bottom:0;
*    content:'';
*    left:50%;
*    position:absolute;
*    top:50px;
*    width:2px;
*    z-index:0;
*}
*.recent-act h1 {
*    text-align:center;
*    color:#1fb5ad;
*    font-size:16px;
*    font-weight:bold;
*    text-transform:uppercase;
*}
*.activity-icon.terques {
*    background:#8fd6d6;
*}
*.activity-icon.red {
*    background:#EF6F66;
*}
*.activity-icon.purple {
*    background:#bda4ec;
*}
*.activity-icon.green {
*    background:#aec785;
*}
*.activity-icon.yellow {
*    background:#fed65a;
*}
*.activity-icon {
*    border-radius:50%;
*    -webkit-border-radius:50%;
*    color:#FFFFFF;
*    height:30px;
*    line-height:30px;
*    text-align:center;
*    width:30px;
*    margin:20px auto 20px;
*    position:relative;
*}
*.activity-icon {
*    background:#C7CBD6;
*}
*.activity-desk {
*    padding:15px 30px;
*    background:#f2f2f2;
*    border-radius:5px;
*    -webkit-border-radius:5px;
*    position:relative;
*    text-align:center;
*}
*.activity-desk h2 {
*    color:#1fb5ad;
*    font-size:14px;
*    font-weight:bold;
*    margin:0 0 10px 0;
*    text-transform:uppercase;
*}
*.activity-desk .terques {
*    color:#1fb5ad;
*}
*.activity-desk .red {
*    color:#EF6F66;
*}
*.activity-desk .purple {
*    color:#bda4ec;
*}
*.activity-desk .green {
*    color:#aec785;
*}
*.activity-desk .yellow {
*    color:#fed65a;
*}
*.activity-desk .blue {
*    color:#20aaf1;
*}
*.photo-gl {
*    margin-top:10px;
*    display:inline-block;
*}
*.photo-gl a {
*    margin:0 10px;
*}
*.photo-gl a img {
*    border:1px solid #c8c8c8;
*    width:150px;
*    height:120px;
*}
*.prf-box {
*    display:inline-block;
*    width:100%;
*    margin-bottom:30px;
*}
*.prf-border-head {
*    color:#1fb5ad;
*    border-bottom:1px solid #f1f2f7;
*    font-size:16px;
*    font-weight:bold;
*    padding-bottom:10px;
*    margin-bottom:20px;
*    text-transform:uppercase;
*}
*.wk-progress {
*    border-bottom:1px solid #f1f2f7;
*    margin-bottom:20px;
*    width:100%;
*    display:inline-block;
*}
*.pf-status {
*    padding-bottom:25px;
*}
*.tm-avatar img {
*    width:50px;
*    height:50px;
*    border-radius:50%;
*    -webkit-border-radius:50%;
*}
*.tm-membr {
*    padding-bottom:12px;
*    margin-bottom:10px;
*}
*.tm-membr .tm {
*    padding-top:10px;
*    display:inline-block;
*    padding-left: 10px;
*}
*/*profile contact*/
*.prf-contacts h2 {
*    color:#1fb5ad;
*    font-size:16px;
*    margin-top:0;
*    text-transform:uppercase;
*}
*.prf-contacts h2 span {
*    width:40px;
*    height:40px;
*    line-height:42px;
*    background:#1fb5ad;
*    color:#fff;
*    border-radius:50%;
*    -webkit-border-radius:50%;
*    display:inline-block;
*    text-align:center;
*    margin-right:15px;
*}
*.prf-contacts h2 span i {
*    font-size:16px;
*}
*.prf-contacts .location-info {
*    margin-left:60px;
*}
*.prf-contacts .location-info p {
*    padding-bottom:30px;
*}
*.prf-map {
*    width:430px;
*    height:430px;
*    border-radius:50%;
*    -webkit-border-radius:50%;
*    border:10px solid #e6e6e6;
*    margin-top:50px;
*}
*.sttng h2 {
*    margin: 20px 0;
*}
*/*invoice*/
*.invoice p {
*    color:#aeaeb1;
*    margin-bottom: 0;
*}
*
*.logo-print {
*    float: left;
*    margin:-50px 0 0 250px;
*}
*.invoice-header {
*    border:1px solid #ddd;
*    display:inline-block;
*    width:100%;
*    margin-bottom:40px;
*}
*.invoice-title {
*    background:#1fb5ad;
*    color:#fff;
*    display:inline-block;
*}
*.inv-label {
*    color:#1fb5ad;
*}
*.itatic {
*    font-style:italic;
*}
*.inv-label h3 {
*    font-weight:300;
*}
*ul.amounts li.grand-total {
*    background:#1fb5ad;
*    color:#fff;
*    font-weight:bold;
*}
*.amnt-value,.table-invoice h4 {
*    margin:0;
*    font-weight:400;
*}
*.invoice-title h1 {
*    font-size:50px;
*    font-weight:lighter;
*    text-align:center;
*    margin:0;
*    text-transform:uppercase;
*    padding:5px;
*    letter-spacing:2px;
*}
*.invoice-list {
*    margin-bottom:30px;
*}
*.invoice-info,.invoice-title {
*    padding:20px;
*}
*.invoice-info {
*    margin-top:5px;
*}
*.invoice-list h4 {
*    font-weight:300;
*    font-size:16px;
*}
*.invoice-to h2 {
*    margin:0;
*    font-size:24px;
*    color:#73737b;
*    font-weight:600;
*}
*.table-invoice {
*    margin-top:30px;
*    border-spacing:5px;
*    border-collapse:separate;
*}
*.table-invoice>thead>tr>th {
*    border-bottom:none;
*}
*.table-invoice>tbody>tr>td {
*    border-top:none;
*}
*.table-invoice thead tr th {
*    background:#e8e9f0;
*    border-radius:5px;
*    -webkit-border-radius:5px;
*    vertical-align:middle;
*}
*.table-invoice thead tr th:first-child,.table-invoice tbody tr td:first-child {
*    text-align:center;
*}
*.table-invoice tbody tr td {
*    background:#f5f6f9;
*    border-radius:5px;
*    -webkit-border-radius:5px;
*    vertical-align:middle;
*}
*.invoice-block {
*    text-align:right;
*}
*.payment-method p {
*    margin-bottom:0;
*}
*ul.amounts li {
*    background:#f5f6f9;
*    margin-bottom:5px;
*    padding:10px;
*    border-radius:4px;
*    -webkit-border-radius:4px;
*    font-weight:300;
*    font-size:16px;
*    list-style: none;
*}
*.invoice-btn {
*    margin-top:30px;
*}
*.invoice-btn a {
*    font-weight:300;
*    margin:0 5px;
*    font-size:16px;
*}
*.corporate-id {
*    margin-bottom: 30px;
*}
*/*panel heading color*/
*.panel-primary>.panel-heading.navyblue {
*    background-color:#2A3542;
*    border-color:#2A3542;
*    color: #FFFFFF;
*}
*/*table*/
*.table-advance tr td {
*    vertical-align:middle !important;
*}
*.no-border {
*    border-bottom:none;
*}
*.dataTables_length,.dataTables_filter {
*    padding:15px;
*}
*.dataTables_info {
*    padding:0 15px;
*}
*.dataTables_filter {
*    float:right;
*}
*.dataTables_length select {
*    width:65px;
*    padding:5px 8px;
*}
*.dataTables_length label,.dataTables_filter label {
*    font-weight:300;
*}
*.dataTables_filter label {
*    width:100%;
*}
*.dataTables_filter label input {
*    width:78%;
*}
*.border-top {
*    border-top:1px solid #ddd;
*}
*.dataTables_paginate.paging_bootstrap.pagination li {
*    float:left;
*    margin:0 1px;
*    border:1px solid #ddd;
*    border-radius:3px;
*    -webkit-border-radius:3px;
*    list-style: none;
*}
*.dataTables_paginate.paging_bootstrap.pagination li.disabled a {
*    color:#c7c7c7;
*}
*.dataTables_paginate.paging_bootstrap.pagination li a {
*    color:#797979;
*    padding:5px 10px;
*    display:inline-block;
*}
*.dataTables_paginate.paging_bootstrap.pagination li:hover a,.dataTables_paginate.paging_bootstrap.pagination li.active a {
*    color:#797979;
*    background:#eee;
*    border-radius:3px;
*    -webkit-border-radius:3px;
*}
*.dataTables_paginate.paging_bootstrap.pagination {
*    float:right;
*    margin-top:-5px;
*    margin-bottom:15px;
*}
*.dataTable tr:last-child {
*    border-bottom: 1px solid #ddd;
*}
*/*calender*/
*.has-toolbar.fc {
*    margin-top:50px;
*}
*.fc-header-title {
*    display:inline-block;
*    margin-top:-45px;
*    vertical-align:top;
*}
*.fc-header-center {
*    text-align:left;
*}
*.fc-header-left {
*    text-align:left;
*    width:18%;
*}
*.fc-view {
*    margin-top:-50px;
*    overflow:hidden;
*    width:100%;
*}
*.fc-state-default,.fc-state-default .fc-button-inner {
*    background:#F3F3F3 !important;
*    border-color:#DDDDDD;
*    border-style:none solid;
*    color:#646464;
*}
*.fc-state-active,.fc-state-active .fc-button-inner,.fc-state-active,.fc-button-today .fc-button-inner,.fc-state-hover,.fc-state-hover .fc-button-inner {
*    background:#32323A !important;
*    color:#fff !important;
*}
*.fc-event-skin {
*    background-color:#1FB5AD !important;
*    border-color:#1FB5AD !important;
*    color:#FFFFFF !important;
*}
*.fc-grid th {
*    height:50px;
*    line-height:50px;
*    text-align:center;
*    background:#e4e4e4 !important;
*}
*.fc-header-title h2 {
*    font-size:18px !important;
*    color:#474752;
*    font-weight:300;
*    padding:0 10px;
*}
*.external-event {
*    cursor:move;
*    display:inline-block !important;
*    margin-bottom:6px !important;
*    margin-right:6px !important;
*    padding:8px;
*}
*#external-events p input[type='checkbox'] {
*    margin:0;
*}
*.drg-event-title {
*    font-weight:300;
*    margin-top:0;
*    margin-bottom:15px;
*    border-bottom:1px solid #ddd;
*    padding-bottom:10px;
*}
*.fc-content .fc-event {
*    border-radius:4px;
*    webkit-border-radius:4px;
*    padding: 4px 6px;
*}
*.fc-corner-left {
*    /*border-radius:4px 0 0 4px;*/
*    /*-webkit-border-radius:4px 0 0 4px;*/
*}
*.fc-corner-right {
*    /*border-radius:0 4px 4px 0;*/
*    /*-webkit-border-radius:0 4px 4px 0;*/
*}
*.drp-rmv {
*    padding-top:10px;
*    margin-top: 10px;
*}
*/*button*/
*.btn-row {
*    margin-bottom: 10px;
*}
*/*tabs*/
*.tab-head {
*    background:#7087a3;
*    display:inline-block;
*    width:100%;
*    margin-top:60px;
*}
*.tab-container {
*    margin-top:10px;
*}
*.tab-head .nav-tabs>li>a {
*    border-radius:0;
*    margin-right:1px;
*    color:#fff;
*}
*.tab-head .nav-tabs>li.active>a,.tab-head .nav-tabs>li>a:hover,.tab-head .nav-tabs>li.active>a:hover,.tab-head .nav-tabs>li.active>a:focus {
*    background-color:#f1f2f7;
*    border-color:#f1f2f7;
*    color: #797979;
*}
*/*general page*/
*.progress-xs {
*    height:10px;
*}
*.progress-sm {
*    height:12px;
*}
*.panel-heading .nav {
*    border:medium none;
*    font-size:13px;
*    margin:-15px -15px -15px;
*}
*.tab-bg-dark-navy-blue ul>li>a {
*    display:block;
*    padding:20px 15px !important;
*}
*.tab-bg-dark-navy-blue {
*    background:#e0e1e7 !important;
*    border-radius:5px 5px 0 0;
*    -webkit-border-radius:5px 5px 0 0;
*    border-bottom:none;
*}
*
*.tab-bg-dark-navy-blue li a:hover, .tab-bg-dark-navy-blue li.active a {
*    border-radius: 0 !important;
*    background: #fff !important;
*    color: #1FB5AD !important;
*}
*.panel-heading .nav>li>a,.panel-heading .nav>li.active>a,.panel-heading .nav>li.active>a:hover,.panel-heading .nav>li.active>a:focus {
*    border-width:0;
*    border-radius:0;
*}
*.panel-heading .nav>li>a {
*    color:#898989;
*}
*.panel-heading .nav>li.active>a,.panel-heading .nav>li>a:hover {
*    color:#1fb5ad;
*    background:#fff;
*}
*.panel-heading .nav>li:first-child.active>a,.panel-heading .nav>li:first-child>a:hover {
*    border-radius:4px 0 0 0 !important;
*    -webkit-border-radius:4px 0 0 0 !important;
*}
*.tab-right {
*    height:58px;
*}
*.panel-heading.tab-right .nav>li:first-child.active>a,.tab-right.panel-heading .nav>li:first-child>a:hover {
*    border-radius:0;
*    -webkit-border-radius:0;
*}
*.panel-heading.tab-right .nav>li:last-child.active>a,.tab-right.panel-heading .nav>li:last-child>a:hover {
*    border-radius:0 4px 0 0;
*    -webkit-border-radius:0 4px 0 0;
*}
*.panel-heading.tab-right .nav-tabs>li>a {
*    margin-left:1px;
*    margin-right:0px;
*}
*.m-bot20 {
*    margin-bottom:20px;
*}
*.m-bot-none {
*    margin-bottom:0;
*}
*.wht-color {
*    color:#fff;
*}
*.close-sm {
*    font-size: 14px;
*}
*/*carousel*/
*.carousel-indicators li {
*    background:rgba(0,0,0,0.2);
*    border:none;
*    transition:background-color 0.25s ease 0s;
*    -moz-transition:background-color 0.25s ease 0s;
*    -webkit-transition:background-color 0.25s ease 0s;
*}
*.carousel-indicators .active {
*    background:#333;
*    height:10px;
*    margin:1px;
*    width:10px;
*}
*.carousel-indicators.out {
*    bottom:-5px;
*}
*.carousel-indicators.out {
*    bottom:-5px;
*}
*.carousel-control {
*    color:#999999;
*    text-shadow:none;
*    width:45px;
*}
*.carousel-control i {
*    display:inline-block;
*    height:25px;
*    left:50%;
*    margin-left:-10px;
*    margin-top:-10px;
*    position:absolute;
*    top:50%;
*    width:20px;
*    z-index:5;
*}
*.carousel-control.left,.carousel-control.right {
*    background:none;
*    filter:none;
*}
*.carousel-control:hover,.carousel-control:focus {
*    color:#CCCCCC;
*    opacity:0.9;
*    text-decoration:none;
*}
*.carousel-inner h3 {
*    font-weight:300;
*    font-size:16px;
*    margin:0;
*}
*.carousel-inner {
*    margin-bottom: 15px;
*}
*/*gritter*/
*.gritter-close {
*    left:auto !important;
*    right: 3px !important;
*}
*/*form*/
*.sm-input {
*    width:175px;
*}
*.form-horizontal.bucket-form .form-group {
*    border-bottom:1px solid #eff2f7;
*    padding-bottom:15px;
*    margin-bottom:15px;
*}
*.form-horizontal.bucket-form .form-group:last-child {
*    border-bottom:none;
*    padding-bottom:0px;
*    margin-bottom:0px;
*}
*.form-horizontal.bucket-form .form-group .help-block {
*    margin-bottom:0;
*}
*.round-input {
*    border-radius:500px;
*    -webkit-border-radius:500px;
*}
*.m-bot15 {
*    margin-bottom:15px;
*}
*.form-horizontal.bucket-form .checkbox-inline>input {
*    margin-top:1px;
*    border:none;
*}
*.btn.btn-info.dropdown-toggle {
*    border-left: 1px solid #1fadea;
*}
*/*custom checkox & radio btn*/
*.icheck div,.icheck .disabled {
*    float:left;
*}
*.icheck div {
*    margin-right:10px;
*}
*.icheck label {
*    font-weight:normal;
*}
*.icheck .checkbox,.icheck .radio {
*    margin-bottom:10px;
*}
*.icheck .single-row {
*    display:inline-block;
*    width: 100%;
*}
*/*form validation*/
*.cmxform .form-group label.error {
*    display:inline;
*    margin:5px 0;
*    color:#B94A48;
*    font-weight:400;
*}
*input:focus:invalid:focus,textarea:focus:invalid:focus,select:focus:invalid:focus,.cmxform .form-group input.error,.cmxform .form-group textarea.error {
*    border-color:#B94A48 !important;
*}
*#signupForm label.error {
*    display:inline;
*    margin:5px 0px;
*    width:auto;
*    color:#B94A48;
*}
*.checkbox,.checkbox:hover,.checkbox:focus {
*    border: none;
*}
*/*slider*/
*.slider-table tr td {
*    padding:30px 0 !important;
*    border: none !important;
*}
*/*date picker*/
*.add-on {
*    float:right;
*    margin-top:-37px;
*    padding:3px;
*    text-align:center;
*}
*.add-on .btn {
*    padding:9px;
*}
*.daterangepicker .ranges .range_inputs>div:nth-child(2) {
*    margin-bottom:10px;
*    padding-left:0px;
*}
*.daterangepicker .ranges label {
*    padding-bottom:0;
*    padding-top:8px;
*}
*.daterangepicker td.active,.daterangepicker td.active:hover,.datepicker td.active:hover,.datepicker td.active:hover:hover,.datepicker td.active:active,.datepicker td.active:hover:active,.datepicker td.active.active,.datepicker td.active.active:hover,
*.datepicker td.active.disabled,.datepicker td.active.disabled:hover,
*.datepicker td.active[disabled],.datepicker td.active[disabled]:hover,.datepicker td span.active:hover,.datepicker td span.active:active,.datepicker td span.active.active,.datepicker td
*span.active.disabled,.datepicker td span.active[disabled] {
*    background:#41CAC0;
*}
*.daterangepicker .calendar th,.daterangepicker .calendar td {
*    font-family:'Open Sans',sans-serif;
*    font-weight:300;
*    text-align:center;
*    white-space:nowrap;
*}
*.daterangepicker td.active,.daterangepicker td.active:hover,.datepicker td.active,.datepicker td.active:hover,.datepicker td span.active {
*    text-shadow:none;
*}
*.datepicker th.switch {
*    width:125px;
*}
*.datepicker td span {
*    height:40px;
*    line-height:40px;
*}
*.bootstrap-timepicker table td input {
*    border:1px solid #ccc;
*    border-radius:3px;
*    -webkit-border-radius: 3px;
*}
*/*ck editor*/
*.cke_top,.cke_bottom {
*    background:#F5F5F5 !important;
*    background:-moz-linear-gradient(center top,#F5F5F5,#F5F5F5) repeat scroll 0 0 #F5F5F5 !important;
*    background:-webkit-linear-gradient(center top,#F5F5F5,#F5F5F5) repeat scroll 0 0 #F5F5F5 !important;
*    background:-o-linear-gradient(center top,#F5F5F5,#F5F5F5) repeat scroll 0 0 #F5F5F5 !important;
*    box-shadow:none;
*    padding:6px 8px 2px;
*}
*.cke_top {
*    border-bottom:1px solid #cccccc !important;
*}
*.cke_chrome {
*    display:block;
*    padding: 0;
*}
*/*widget*/
*.user-heading.alt {
*    display:inline-block;
*    width:100%;
*    text-align:left;
*}
*.alt.gray-bg {
*    background:#474751;
*}
*.terques-bg {
*    background:#1fb5ad;
*}
*.profile-nav.alt.green-border ul>li>a:hover i {
*    color:#1fb5ad;
*}
*.user-heading.alt a {
*    float:left;
*    margin-right:15px;
*    margin-left:-10px;
*    display:inline-block;
*    border:5px solid rgba(255,255,255,0.3);
*    border-radius:50%;
*    -webkit-border-radius:50%;
*}
*.user-heading.alt a img {
*    width:85px;
*    height:85px;
*    border-radius:50%;
*    -webkit-border-radius:50%;
*}
*.twt-feed {
*    border-radius:4px 4px 0 0;
*    -webkit-border-radius:4px 4px 0 0;
*    color:#FFFFFF;
*    padding:40px 10px 10px;
*    position:relative;
*    min-height:170px;
*}
*.corner-ribon {
*    text-align:center;
*    width:71px;
*    height:71px;
*    position:absolute;
*    right:0;
*    top:0;
*    font-size:20px;
*}
*.corner-ribon i {
*    padding:10px 0 0 35px;
*    color:#fff;
*}
*.blue-ribon {
*    background:url('../images/twitter_corner_blue.png') no-repeat;
*}
*.black-ribon {
*    background:url('../images/twitter_corner_black.png') no-repeat;
*}
*.twt-feed.blue-bg {
*    background:#58C9F3;
*}
*.twt-feed h1 {
*    font-size:18px;
*    font-weight:300;
*    margin-bottom:5px;
*}
*.twt-feed a {
*    border-radius:50%;
*    -webkit-border-radius:50%;
*    float:left;
*    margin:0 10px;
*}
*.twt-feed a img {
*    height:85px;
*    width:85px;
*    border-radius:50%;
*    -webkit-border-radius:50%;
*}
*.twt-category {
*    display:inline-block;
*    margin-bottom:11px;
*    margin-top:10px;
*    width:100%;
*}
*.twt-feed .wtt-mark {
*    color:rgba(255,255,255,0.15);
*    font-size:160px;
*    position:absolute;
*    top:10px;
*    left:40%;
*}
*.twt-category ul li {
*    color:#bdbdbd;
*    font-size:13px;
*}
*.twt-category h5 {
*    font-size:18px;
*    font-weight:400 !important;
*}
*.twt-write .t-text-area {
*    background:#f4f4f6;
*    border-radius:4px;
*    -webkit-border-radius:4px;
*    border:none;
*    height:40px;
*    color:#c9c9c9;
*    margin-bottom:20px;
*    padding-top:10px;
*}
*.twt-footer {
*    padding:12px 15px;
*}
*.twt-footer,.twt-footer a {
*    color:#d2d2d2;
*}
*.twt-footer i {
*    padding-right:10px;
*}
*.btn-space {
*    padding-left:11.6%;
*    padding-right:11%;
*}
*.p-head {
*    color:#f77b6f;
*    font-weight:400;
*    font-size:14px;
*}
*.cmt-head {
*    font-weight:400;
*    font-size:13px;
*}
*.p-thumb img {
*    width:50px;
*    height:50px;
*    border-radius:3px;
*    -webkit-border-radius:3px;
*}
*.tasi-tab .media-body p {
*    /*color:#b8bac6;*/
*}
*.feed-box {
*    position:relative;
*}
*.feed-box img {
*    border-radius:50%;
*    -webkit-border-radius:50%;
*    width:85px;
*    height:85px;
*}
*.feed-box h1 {
*    font-size:20px;
*    color:#8b8b8b;
*    font-weight:400;
*}
*.feed-box a {
*    color:#3ac7f9;
*}
*.profile-nav .user-heading.clock-row {
*    padding:20px;
*}
*.clock-row {
*    text-transform:uppercase;
*    min-height:170px;
*}
*ul.clock-category {
*    padding:15px 0;
*}
*ul.clock-category li {
*    display:inline-block;
*    width:24%;
*    text-align:center;
*    border:none;
*}
*ul.clock-category li a span {
*    display:block;
*    line-height:normal;
*}
*ul.clock-category li a i {
*    font-size:30px;
*    padding-right:0;
*}
*ul.clock-category li a:hover,ul.clock-category li a.active {
*    color:#1fb5ad !important;
*    background:none !important;
*}
*ul.clock-category li a:hover i,ul.clock-category li a.active i {
*    color:#1fb5ad !important;
*}
*.clock-row h1 {
*    font-size:22px !important;
*    font-weight:400 !important;
*    letter-spacing:1px;
*    margin:0 0 5px 0!important;
*    letter-spacing:1px;
*}
*.clock-row p {
*    font-size:18px;
*    font-weight:300;
*    color:#fff !important;
*    margin:0;
*}
*.wdgt-row {
*    text-align:center !important;
*}
*.wdgt-row i {
*    font-size:50px;
*}
*.wdgt-value h1 {
*    color:#c7cbd6;
*    font-size:30px;
*    font-weight:400;
*    margin:0;
*}
*.wdgt-value p {
*    color:#c7cbd6;
*    font-size:14px;
*    font-weight:300;
*    margin:0;
*}
*.red-bg {
*    background:#fa8564;
*}
*.purple-bg {
*    background:#9466b5;
*    color:#fff;
*}
*.weather-box {
*    float:left;
*    width:100%;
*}
*.weather-box .symbol {
*    border-radius:4px 0 0 4px;
*    -webkit-border-radius:4px 0 0 4px;
*    padding:61px 15px;
*    width:50%;
*    float:left;
*    text-align:center;
*}
*.weather-box .symbol i {
*    font-size:70px;
*    text-shadow:-5px 6px 5px rgba(0,0,0,0.3);
*}
*.weather-box .value {
*    float:right;
*    width:50%;
*    text-align:center;
*    padding:33px 0;
*    font-size:14px;
*    color:#bdbdbd;
*}
*.weather-box .value i {
*    font-size:20px;
*}
*.wdgt-row,.prd-img {
*    position:relative;
*}
*.wdgt-row img {
*    width:100%;
*    border-radius:4px 4px 0 0;
*    -webkit-border-radius:4px 4px 0 0;
*}
*.wdt-head {
*    text-transform:uppercase;
*    font-size:16px;
*    font-weight:400;
*    text-shadow:0 0 3px rgba(0,0,0,0.8);
*    color:#fff;
*    position:absolute;
*    left:20px;
*    bottom:15px;
*}
*.country-select {
*    position:absolute;
*    top:10px;
*    right:10px;
*}
*.weather-full-info {
*    color:#cbcbcb;
*}
*.weather-full-info h1 {
*    font-size:14px;
*    font-weight:600;
*    margin:0 0 10px 0;
*    text-transform:uppercase;
*}
*.weather-full-info h2 {
*    font-size:14px;
*    font-weight:300;
*    margin:0 0 5px 0;
*}
*.weather-full-info .today-status i {
*    font-size:40px;
*    color:#1fb5ad;
*}
*.weather-full-info .degree {
*    font-size:30px;
*    font-weight:600;
*    display:inline-block;
*    padding-left:20px;
*}
*.weather-full-info .degree:after {
*    content:'o';
*    position:relative;
*    top:-12px;
*    font-size:16px;
*}
*.weather-full-info ul {
*    margin-bottom:0;
*}
*.weather-full-info ul li {
*    display:inline-block;
*    width:16%;
*    text-align:center;
*    border-left:1px solid #f1f2f7;
*}
*.weather-full-info ul li i {
*    font-size:25px;
*}
*.weather-full-info .statistics {
*    padding-top:5px;
*}
*.weather-full-info .statistics:after {
*    content:'o';
*    position:relative;
*    top:-5px;
*    font-size:10px;
*}
*.prd-row {
*    position:relative;
*}
*.btn-add-cart {
*    bottom:9px;
*    padding:12px;
*    position:absolute;
*    right:15px;
*}
*.prd-row img {
*    width:100%;
*}
*.prd-row .action {
*    width:100px;
*    height:45px;
*    position:absolute;
*    bottom:10px;
*    right:-35px;
*    background:rgba(0,0,0,0.5);
*    border-radius:5px;
*    -webkit-border-radius:5px;
*}
*.prd-row .action .part1 {
*    width:50%;
*    float:left;
*    text-align:center;
*    line-height:45px;
*    color:#fff;
*    font-size:18px;
*}
*.yellow-bg-prd {
*    background:#ffdd00;
*    border-radius:0 5px 5px 0;
*    -webkit-border-radius:0 5px 5px 0;
*}
*.prd-row h1 {
*    font-size:24px;
*    font-weight:400;
*    color:#5f6165;
*    margin:5px 0;
*}
*.prd-row p {
*    margin:0;
*    color:#bfc2c4;
*}
*.prd-row p.normal {
*    color:#bfc2c4;
*}
*.prd-row p.terques {
*    color:#1fb5ad;
*}
*.prd-row .price {
*    margin-top:20px;
*    margin-bottom:20px;
*}
*.prd-row .price .amnt {
*    color:#1fb5ad;
*    font-size:25px;
*    font-weight:600;
*}
*.prd-row .price .amnt:after {
*    content:'.00';
*    position:relative;
*    top:-10px;
*    font-size:12px;
*}
*.clock-place {
*    margin:-76px auto 0;
*}
*.btn-gap button {
*    margin-right: 10px;
*}
*/*custom select*/
*span.customSelect {
*    font-size:12px;
*    background-color:#ffffff;
*    padding:6px 10px;
*    border:1px solid #EAEAEA;
*    -moz-border-radius:50px;
*    -webkit-border-radius:50px;
*    border-radius:50px;
*    color:#A4AABA;
*    text-align:left;
*}
*span.customSelect.changed {
*    background-color:#fff;
*}
*.customSelectInner {
*    background: url(../images/customSelect-arrow.gif) no-repeat center right;
*}
*/*Timeline chat*/
*.chat-form {
*    margin-top:25px;
*    clear:both;
*}
*.chat-form .input-cont {
*    margin-bottom:10px;
*}
*.chat-form .input-cont input {
*    margin-bottom:0px;
*}
*.chat-form .input-cont input {
*    border:1px solid #d3d3d3 !important;
*    margin-top:0;
*    min-height:45px;
*}
*.chat-form .input-cont input {
*    background-color:#fff !important;
*}
*.chat-features a {
*    margin-left:10px;
*}
*.chat-features a i {
*    color:#d0d0d0;
*}
*.timeline-messages h3 {
*    margin-bottom:30px;
*    color:#1fb5ad;
*    font-size:16px;
*    text-transform:uppercase;
*    background:#fff;
*    padding:20px;
*    margin-top:-3px;
*    position:relative;
*}
*.timeline-messages:before {
*    background:rgba(0,0,0,0.05);
*    bottom:0;
*    top:0;
*    width:2px;
*}
*.timeline-messages:before,.msg-time-chat:before,.msg-time-chat .text:before {
*    content:'';
*    left:20px;
*    position:absolute;
*    top:-2px;
*}
*.timeline-messages,.msg-time-chat,.timeline-messages .msg-in,.timeline-messages .msg-out {
*    position:relative;
*}
*.timeline-messages .msg-in .arrow {
*    border-right:8px solid #949496 !important;
*}
*.timeline-messages .msg-in .arrow {
*    border-bottom:8px solid transparent;
*    border-top:8px solid transparent;
*    display:block;
*    height:0;
*    left:-8px;
*    position:absolute;
*    top:25px;
*    width:0;
*}
*.timeline-messages .msg-out .arrow {
*    border-right:8px solid #41cac0 !important;
*}
*.timeline-messages .msg-out .arrow {
*    border-bottom:8px solid transparent;
*    border-top:8px solid transparent;
*    display:block;
*    height:0;
*    left:-8px;
*    position:absolute;
*    top:25px;
*    width:0;
*}
*.msg-time-chat:first-child:before {
*    margin-top:27px;
*}
*.msg-time-chat:before {
*    background:#CCCCCC;
*    border:2px solid #FAFAFA;
*    border-radius:100px;
*    -moz-border-radius:100px;
*    -webkit-border-radius:100px;
*    height:16px;
*    margin:35px 0 0 -7px;
*    width:16px;
*}
*.msg-time-chat:hover:before {
*    background:#41cac0;
*}
*.msg-time-chat:first-child {
*    padding-top:0;
*}
*.message-img {
*    float:left;
*    margin-right:30px;
*    overflow:hidden;
*}
*.message-img img {
*    display:block;
*    height:44px;
*    width:44px;
*}
*.message-body {
*    margin-left:50px;
*    display: inline-block;
*}
*.msg-time-chat .msg-in .text {
*    /*border:1px solid #e3e6ed;*/
*    /*padding:10px;*/
*    border-radius:4px;
*    -webkit-border-radius:4px;
*    margin-top:14px;
*}
*.msg-time-chat .msg-in .text .first {
*    background:#949496;
*    padding:10px;
*    color:#fff;
*    float:left;
*    border-radius:4px;
*    -webkit-border-radius:4px;
*    margin-right:5px;
*    width:130px;
*    text-align:right;
*}
*.msg-time-chat .msg-in .text .second {
*    background:#8fd6d6;
*    padding:10px;
*    color:#fff;
*    float:left;
*    border-radius:4px;
*    -webkit-border-radius:4px;
*}
*.msg-time-chat .msg-out .text {
*    border:1px solid #e3e6ed;
*    padding:10px;
*    border-radius:4px;
*    -webkit-border-radius:4px;
*}
*.msg-time-chat p {
*    margin:0;
*}
*.msg-time-chat .attribution {
*    font-size:11px;
*    margin:0px 0 5px;
*}
*.msg-time-chat {
*    overflow:hidden;
*    padding:8px 0;
*}
*.msg-in a,.msg-in a:hover {
*    color:#b64c4c;
*    text-decoration:none;
*    border-radius:4px;
*    -webkit-border-radius:4px;
*    margin-right:10px;
*    font-weight:400;
*    font-size:13px;
*}
*.msg-out a,.msg-out a:hover {
*    color:#288f98;
*    text-decoration:none;
*    border-radius:4px;
*    -webkit-border-radius:4px;
*    margin-right:10px;
*    font-weight:400;
*    font-size:13px;
*}
*.bg-terques {
*    background:#8fd6d6 !important;
*}
*.bg-red {
*    background:#ffa991 !important;
*}
*.bg-purple {
*    background:#bda4ec !important;
*}
*.bg-green {
*    background:#aec785 !important;
*}
*.bg-yellow {
*    background:#fed65a !important;
*}
*.bg-blue {
*    background: #99cce3 !important;
*}
*/*boxed page */
*.boxed-page {
*    background-color:#000 !important;
*}
*.box-head {
*    background:none;
*}
*.boxed-page .container {
*    background:#32323A;
*    padding-left:0;
*    padding-right:0;
*}
*.boxed-page>.container {
*    overflow:hidden;
*}
*.boxed-page .container #sidebar {
*    position:inherit;
*}
*.boxed-page .container .header .container {
*    background:#fff;
*}
*.boxed-page .container aside {
*    float:left;
*}
*.boxed-page .container .wrapper {
*    background:#F1F2F7;
*    min-height:900px;
*}
*.boxed-page .brand {
*    margin-left: 0;
*}
*/*collapsible*/
*.tools a {
*    margin-left:10px;
*    color:#a7a7a7;
*    font-size: 12px;
*}
*/* google maps */
*.gmaps {
*    height:300px;
*    width:100%;
*}
*.ullist {
*    border-bottom:#ccc 1px solid;
*    margin-left:20px;
*}
*.ullist li {
*    display:inline-block;
*    margin-left:5px;
*}
*.ullist li a {
*    display:inline-block;
*    padding:10px 20px !important;
*    border-top:#ccc 1px solid;
*    border-left:#ccc 1px solid;
*    border-right:#ccc 1px solid;
*    -moz-border-radius:3px 3px 0 0;
*    -webkit-border-radius:3px 3px 0 0;
*    border-radius:3px 3px 0 0;
*    background:#f1f1f1;
*}
*.ullist li.active a {
*    background:#fff;
*    border-bottom:#fff 1px solid;
*    position:relative;
*    top:1px;
*    margin-bottom: -1px;
*}
*/* star rating */
*.rating {
*    unicode-bidi:bidi-override;
*    direction:rtl;
*    font-size:30px;
*}
*.rating span.star,.rating span.star {
*    font-family:FontAwesome;
*    font-weight:normal;
*    font-style:normal;
*    display:inline-block;
*}
*.rating span.star:hover,.rating span.star:hover {
*    cursor:pointer;
*}
*.rating span.star:before,.rating span.star:before {
*    content:'\f006';
*    padding-right:5px;
*    color:#BEC3C7;
*}
*.rating span.star:hover:before,.rating span.star:hover:before,.rating span.star:hover ~ span.star:before,.rating span.star:hover ~ span.star:before {
*    content:'\f005';
*    color: #41CAC0;
*}
*/*ckEditor*/
*#editor-container {
*    width:100%;
*    margin:10px auto 0;
*}
*#header-editor {
*    overflow:hidden;
*    padding:0 0 30px;
*    border-bottom:1px solid #eaeaea;
*    position:relative;
*}
*#headerLeft,#headerRight {
*    width:100%;
*    overflow:hidden;
*}
*#headerLeft {
*    float:left;
*    padding:10px 1px 1px;
*}
*#headerLeft h2,#headerLeft h3 {
*    margin:0;
*    overflow:hidden;
*    font-weight:normal;
*    font-family:'Open Sans',sans-serif;
*}
*#headerLeft h2 {
*    font-size:2.6em;
*    line-height:1.1em;
*    text-transform:capitalize;
*    color:#32323a;
*    margin-bottom:30px;
*}
*#headerLeft h3 {
*    font-size:1.5em;
*    line-height:1.1em;
*    margin:.2em 0 0;
*    color:#32323a;
*}
*#headerRight {
*    float:right;
*    padding:1px;
*}
*#headerRight p {
*    line-height:1.8em;
*    text-align:justify;
*    margin:0;
*}
*#headerRight p+p {
*    margin-top:20px;
*}
*#headerRight>div {
*    padding:20px 0;
*    margin:0;
*    font-size:1.1em;
*    color:#757575;
*}
*#columns {
*    color:#757575;
*    overflow:hidden;
*    padding:20px 0;
*}
*#columns h3 {
*    color:#32323a;
*}
*#columns>div {
*    float:left;
*    width:33.3%;
*}
*#columns #column1>div {
*    margin-left:1px;
*}
*#columns #column3>div {
*    margin-right:1px;
*}
*#columns>div>div {
*    margin:0px 10px;
*    padding:10px 0;
*}
*#columns blockquote {
*    margin-left:15px;
*}
*#taglist {
*    display:inline-block;
*    margin-left:20px;
*    font-weight:bold;
*    margin:0 0 0 20px;
*}
*.cke_editable.cke_editable_inline.cke_focus {
*    background:#fcfcfc;
*    border:1px solid #eaeaea;
*    cursor:text;
*    outline: medium none;
*}
*/*advanced table*/
*.general-table .progress {
*    margin-bottom:0;
*}
*.adv-table table tr td {
*    padding:10px;
*}
*.adv-table table.display thead th {
*    border-bottom:1px solid #DDDDDD;
*    padding:10px;
*}
*tr.odd.gradeA td.sorting_1,tr.odd td.sorting_1,tr.even.gradeA td.sorting_1 {
*    background:none;
*}
*td.details {
*    background-color:#eee;
*}
*td.details table tr td,.dataTable tr:last-child {
*    border:none;
*}
*.adv-table table.display tr.odd.gradeA {
*    background-color:#F9F9F9;
*}
*.adv-table table.display tr.even.gradeA {
*    background-color:#FFFFFF;
*}
*.adv-table .dataTables_filter label input {
*    float:right;
*    margin-left:10px;
*    width:78%;
*}
*.adv-table .dataTables_filter label {
*    line-height:33px;
*    width:100%;
*}
*.adv-table .dataTables_length select {
*    display:inline-block;
*    margin:0 10px 0 0;
*    padding:5px 8px;
*    width:65px;
*}
*.adv-table .dataTables_info,.dataTables_paginate {
*    padding:15px 0;
*}
*.adv-table .dataTables_length,.adv-table .dataTables_filter {
*    padding:15px 0;
*}
*.cke_chrome {
*    border:none !important;
*}
*.editable-table .dataTables_filter {
*    width:80%;
*}
*tr.odd.gradeX td.sorting_1,tr.even.gradeX td.sorting_1,table.display tr.even.gradeX,table.display tr.gradeX,tr.even.gradeU td.sorting_1,tr.even td.sorting_1,table.display tr.even.gradeC,table.display tr.gradeC,tr.odd.gradeC td.sorting_1,table.display
*tr.even.gradeU,table.display tr.gradeU,tr.odd.gradeU td.sorting_1 {
*    background: none !important;
*}
*/*flot chart*/
*.flot-chart .chart,.flot-chart .pie,.flot-chart .bars {
*    height: 300px;
*}
*/*xchart*/
*.demo-xchart {
*    height:400px;
*    width: 100%;
*}
*/*Horizontal menu*/
*.full-width #main-content {
*    margin-left:0;
*}
*.horizontal-menu {
*    margin-top:18px;
*    float:left;
*}
*.horizontal-menu .navbar-nav>li {
*    margin-right:5px;
*}
*.horizontal-menu .navbar-nav>li>a {
*    padding:10px 20px;
*    border-radius:30px;
*    -webkit-border-radius:30px;
*    -webkit-transition:all 0.3s ease;
*    -moz-transition:all 0.3s ease;
*    -o-transition:all 0.3s ease;
*    -ms-transition:all 0.3s ease;
*    transition:all 0.3s ease;
*}
*.horizontal-menu>.navbar-nav>li>.dropdown-menu {
*    margin-top:23px;
*    box-shadow:0 0 5px rgba(0,0,0,0.1) !important;
*    border:none;
*}
*.full-width .navbar-header {
*    width:100%;
*}
*.full-width .nav>li>a:hover,.full-width .nav li.active a,.full-width .nav li.dropdown a:hover,.full-width .nav li.dropdown.open a:focus,.full-width .nav .open>a,.full-width .nav .open>a:hover,.full-width .nav .open>a:focus {
*    background-color:#1FB5AD;
*    text-decoration:none;
*    color:#fff;
*    transition:all 0.3s ease 0s;
*    -webkit-transition:all 0.3s ease 0s;
*    border-radius:30px;
*    -webkit-border-radius:30px;
*}
*.full-width .dropdown-menu {
*    box-shadow:none;
*}
*.full-width .dropdown-menu>li>a {
*    padding:10px 20px;
*    font-size: 13px;
*}
*
*.horizontal-menu .dropdown-menu>li>a {
*    padding:10px 20px;
*    font-size: 13px;
*    margin: 5px 10px;
*}
*
*
*/*advanced form*/
*.form-body {
*    padding: 20px;
*}
*/*multiselect*/
*.ms-container .ms-selectable li.ms-hover,.ms-container .ms-selection li.ms-hover {
*    background-color:#2A3542;
*    color:#FFFFFF;
*    cursor:pointer;
*    text-decoration:none;
*}
*.ms-container .ms-list,.ms-container .ms-list.ms-focus {
*    box-shadow:none !important;
*}
*.ms-container .ms-list.ms-focus {
*    border:1px solid #2A3542;
*}
*.ms-selectable .search-input,.ms-selection .search-input {
*    margin-bottom: 10px;
*}
*/*spinner*/
*.spinner-buttons.btn-group-vertical .btn {
*    height:17px;
*    margin:0;
*    padding-left:6px;
*    padding-right:6px;
*    text-align:center;
*    width:22px;
*}
*.spinner-buttons.btn-group-vertical .btn i {
*    margin-top:-3px;
*}
*.spinner-buttons.btn-group-vertical .btn:first-child {
*    border-radius:0 4px 0 0 !important;
*    -webkit-border-radius:0 4px 0 0 !important;
*}
*.spinner-buttons.btn-group-vertical .btn:last-child {
*    border-radius:0 0 4px !important;
*    -webkit-border-radius: 0 0 4px !important;
*}
*/**/
*.wysihtml5-toolbar .btn-default {
*    background:#fff;
*    color: #757575;
*}
*/*lock screen*/
*.lock-screen {
*    background: #1FB3A3 url('../images/lock-screen.jpg') no-repeat fixed 0 0 / cover;
*}
*.lock-wrapper {
*    margin:10% auto;
*    max-width:500px;
*}
*.lock-box {
*    position:relative;
*}
*.lock-name {
*    background:#fff;
*    width:50%;
*    float:left;
*    height:50px;
*    line-height:50px;
*    margin-top:55px;
*    padding:0 20px;
*    text-align:left;
*    border-radius:5px 0 0 5px;
*    -webkit-border-radius:5px 0 0 5px;
*    color:#1fb5ad;
*}
*.lock-pwd {
*    background:#fff;
*    width:50%;
*    float:right;
*    height:50px;
*    line-height:50px;
*    margin-top:55px;
*    padding:0 0 0 80px;
*    border-radius:0 5px 5px 0;
*    -webkit-border-radius:0 5px 5px 0;
*    color:#1fb5ad;
*}
*.lock-pwd input {
*    width:72% !important;
*    margin-top:6px;
*    color:#626f81;
*}
*.lock-pwd input:focus,.lock-pwd input:hover {
*    border-color:#fff;
*}
*.lock-wrapper img {
*    position:absolute;
*    left:33%;
*    border-radius:50%;
*    -webkit-border-radius:50%;
*    border:10px solid #fff;
*    width:160px;
*    height:160px;
*    background: #fff;
*}
*.lock-wrapper .locked {
*    margin-bottom:20px;
*    display:inline-block;
*    color:#026f7a;
*}
*.btn-lock,.btn-lock:hover {
*    background:#fff;
*    color:#626f81;
*    margin-top:-8px;
*}
*.lock-input {
*    width:83%;
*    border:none;
*    float:left;
*    margin-right:3px;
*}
*#time {
*    width:100%;
*    color:#fff;
*    font-size:125px;
*    margin-bottom:50px;
*    display:inline-block;
*    text-align:center;
*    font-family:'Lato',sans-serif;
*    font-weight: 100;
*}
*/*language*/
*.language {
*    margin-top:4px;
*}
*.language .dropdown-menu {
*    border:none;
*    box-shadow:0 0 5px rgba(0,0,0,0.1) !important;
*    margin-top: 18px;
*}
*.language .dropdown-menu li a {
*    /*border-bottom:1px solid #eee;*/
*    padding:10px;
*}
*.language .dropdown-menu li:last-child a {
*    border-bottom:none;
*}
*.language .dropdown-menu li a {
*    font-size:13px;
*    padding:10px;
*}
*.language .dropdown-menu li a:hover {
*    background:#F1F2F7;
*    color:#32323a;
*}
*.language-menu {
*    margin-top:15px !important;
*    padding:0;
*}
*.lang-arrow-up {
*    background:url('../images/top-arrow.png') no-repeat;
*    width:18px;
*    height:10px;
*    margin-top:-15px;
*    float:right;
*    margin-right: 15px;
*}
*/*breadcrumbs-alt*/
*.breadcrumbs-alt {
*    list-style-type:none;
*    margin:0px 0 20px;
*    overflow:hidden;
*    padding:0;
*    width:100%;
*}
*.breadcrumbs-alt li {
*    float:left;
*    margin:0 25px 0 0;
*    transition:all 0.3s ease-in-out 0s;
*}
*.breadcrumbs-alt a:before {
*    border-color:#E0E1E7 #E0E1E7 #E0E1E7 rgba(0,0,0,0);
*    border-style:solid;
*    border-width:1.5em 0 1.7em 1em;
*    content:'';
*    left:-1em;
*    margin-top:-1.6em;
*    position:absolute;
*    top:50%;
*    transition:all 0.3s ease-in-out 0s;
*}
*.breadcrumbs-alt a:after {
*    border-bottom:1.5em solid rgba(0,0,0,0);
*    border-left:1em solid #E0E1E7;
*    border-top:1.5em solid rgba(0,0,0,0);
*    content:'';
*    margin-top:-1.5em;
*    position:absolute;
*    right:-1em;
*    top:50%;
*    transition:all 0.3s ease-in-out 0s;
*}
*.breadcrumbs-alt a {
*    background:#E0E1E7;
*    color:#444444;
*    float:left;
*    font-size:12px;
*    padding:10px;
*    position:relative;
*    text-decoration:none;
*    transition: all 0.3s ease-in-out 0s;
*}
*/*active and hover*/
*.breadcrumbs-alt a:hover:before,.breadcrumbs-alt a.current:before {
*    border-color:#1FB5AD #1FB5AD #1FB5AD rgba(0,0,0,0);
*    border-style:solid;
*    border-width:1.5em 0 1.7em 1em;
*    content:'';
*    left:-1em;
*    margin-top:-1.6em;
*    position:absolute;
*    top:50%;
*    transition:all 0.3s ease-in-out 0s;
*}
*.breadcrumbs-alt a:hover:after,.breadcrumbs-alt a.current:after {
*    border-bottom:1.5em solid rgba(0,0,0,0);
*    border-left:1em solid #1FB5AD;
*    border-top:1.5em solid rgba(0,0,0,0);
*    content:'';
*    margin-top:-1.5em;
*    position:absolute;
*    right:-1em;
*    top:50%;
*    transition:all 0.3s ease-in-out 0s;
*}
*.breadcrumbs-alt a:hover,.breadcrumbs-alt a.current {
*    background:#1FB5AD;
*    color:#fff;
*    float:left;
*    font-size:12px;
*    padding:10px;
*    position:relative;
*    text-decoration:none;
*    transition: all 0.3s ease-in-out 0s;
*}
*/*footer*/
*.footer-section {
*    background:#32323A;
*    color:#fff;
*    padding:10px 0;
*    /*position:fixed;*/
*    bottom:0;
*    width:100%;
*    margin-top:30px;
*}
*.go-top {
*    margin-right:1%;
*    float:right;
*    background:rgba(0,0,0,.4);
*    width:25px;
*    height:25px;
*    border-radius:2%;
*    -webkit-border-radius:2%;
*}
*.go-top i {
*    color:#fff;
*    font-size:18px;
*    padding-top:2px;
*}
*.site-min-height {
*    min-height: 900px;
*}
*/*pricing table*/
*.price-head {
*    padding:10px 0 50px;
*}
*.price-head h1 {
*    font-size:32px;
*    font-weight:normal;
*    color:#1fb5ad;
*}
*.pricing-table {
*    background:#F1F2F7;
*    text-align:center;
*    padding:0 0 25px 0;
*    border-radius:5px;
*    -moz-border-radius:5px;
*    -webkit-border-radius:5px;
*}
*.pricing-table.most-popular {
*    position:relative;
*}
*.most-popular {
*    background:#f1f2f7;
*    color:#7d7d7d;
*}
*.most-popular .pricing-head {
*    background:#1fb5ad;
*    border-radius:5px 5px 0 0;
*    -webkit-border-radius:5px 5px 0 0;
*    position:relative;
*    height:170px;
*}
*.most-popular .pricing-quote,.most-popular ul li i {
*    color:#1fb5ad;
*}
*.most-popular ul li {
*}
*.most-popular .price-actions .btn {
*    background:#1fb5ad !important;
*    cursor:pointer;
*}
*.pricing-table .price-actions .btn {
*    border-radius:5px;
*    -moz-border-radius:5px;
*    -webkit-border-radius:5px;
*    background:#7d7d7d;
*    color:#fff;
*    border:none;
*    box-shadow:none;
*    text-shadow:none;
*    padding:10px 20px;
*    cursor:pointer;
*}
*.pricing-head {
*    background:#7d7d7d;
*    border-radius:5px 5px 0 0;
*    -webkit-border-radius:5px 5px 0 0;
*    position:relative;
*    height:170px;
*}
*.pricing-head h1 {
*    font-size:24px;
*    font-weight:300;
*    padding-top:30px;
*    color:#fff;
*    text-transform:uppercase;
*}
*.pricing-quote {
*    background:#fff;
*    padding:22px 0;
*    color:#7d7d7d;
*    font-size:45px;
*    font-weight:100;
*    width:150px;
*    height:150px;
*    border-radius:50%;
*    -webkit-border-radius:50%;
*    margin:-85px auto;
*    z-index:100;
*    position:relative;
*}
*.pricing-quote:after {
*    width:170px;
*    height:170px;
*    border-radius:50%;
*    -webkit-border-radius:50%;
*    border:10px solid rgba(255,255,255,0.5);
*    margin:-85px auto;
*    z-index:100;
*    position:absolute;
*    content:'';
*    left:-10px;
*    top:75px;
*}
*.pricing-table ul {
*    margin:120px 0 50px;
*    padding:0;
*}
*.pricing-table ul li {
*    margin:0 2em;
*    padding:1em 0;
*    text-align:left;
*    font-weight:300;
*}
*.pricing-table ul li i {
*    margin-right:10px;
*}
*.pricing-quote span.note {
*    display:inline;
*    font-size:18px;
*    line-height:0.8em;
*    position:relative;
*    top:-18px;
*}
*.pricing-quote p {
*    font-size:16px;
*    color:#d2d2d6;
*}
*.pricing-quotation,.team-info {
*    background:#EEEEEE;
*    padding:20px 20px 35px 20px;
*    margin-bottom:100px;
*    display:inline-block;
*    width:100%;
*    text-align:center;
*    border-radius:5px;
*    -moz-border-radius:5px;
*    -webkit-border-radius:5px;
*}
*.pricing-quotation h3,.team-info h3 {
*    font-weight:300;
*}
*.pricing-quotation p,.team-info p {
*    margin-bottom:0px;
*}
*.pricing-plan,.team-info-wrap {
*    position:relative;
*}
*.pricing-quotation:before,.team-info:before {
*    background-color:#EEEEEE;
*    border-color:#EEEEEE;
*    border-image:none;
*    border-right:1px solid #EEEEEE;
*    border-style:none;
*    top:-7px;
*    content:'';
*    display:block;
*    height:14px;
*    left:48%;
*    position:absolute;
*    transform:rotate(45deg);
*    -moz-transform:rotate(45deg);
*    -webkit-transform:rotate(45deg);
*    width: 15px;
*}
*/*dragable portlet*/
*.sortable .panel .panel-heading {
*    cursor: move;
*}
*/*switch btn*/
*.has-switch span.switch-left,.has-switch span.switch-right {
*    border-radius:40px;
*    -webkit-border-radius: 40px;
*}
*/*toggle style*/
*.toggle-heading h3 {
*    font-size:16px;
*    margin:0 0 10px 0;
*    /*border-bottom:1px solid #ddd;*/
*    padding-bottom:10px;
*    font-weight:300;
*}
*/*tags input*/
*.tagsinput {
*    height:40px !important;
*    min-height:41px !important;
*    margin:0 !important;
*    overflow:auto !important;
*    padding:5px !important;
*}
*div.tagsinput span.tag {
*    background:none repeat scroll 0 0 #CDE69C !important;
*    border:0 none !important;
*    color:#638421 !important;
*    margin-bottom:4px !important;
*    padding:5px 6px !important;
*}
*.hd-title {
*    font-size:16px;
*    margin: 10px 0;
*}
*/*DASHBOARD -jaman*/
*.main-chart {
*    width:100%;
*    height:265px;
*}
*#flotTip {
*    background:#fff;
*    border:#ccc 1px solid;
*    padding:10px;
*}
*#legendcontainer26 {
*    padding:10px 0px;
*}
*#legendcontainer26 .legendColorBox {
*    padding-right:5px;
*}
*#legendcontainer26 .legendColorBox div {
*    border-radius:100% !important;
*}
*.widget-h {
*    color:#afaebc;
*    font-size:16px;
*    text-transform:uppercase;
*    margin:0px 0px 10px 0px;
*    text-align:center;
*}
*.gauge-canvas {
*    text-align:center;
*}
*.gauge-value {
*    color:#fa8564;
*    font-size:16px;
*    font-weight:bold;
*    padding-left:20px;
*}
*.gauge-title {
*    color:#ccc;
*    font-size:14px;
*    padding-right:20px;
*}
*.gauge-meta {
*    margin:0px;
*    padding-top:7px;
*    list-style: none;
*    padding-left: 0;
*}
*.daily-visit {
*    text-align:center;
*}
*.daily-visit-spark {
*    padding:10px 0px;
*}
*.sm-pie .legendColorBox {
*    padding-right:5px;
*}
*.sm-pie .legendColorBox>div {
*    border:#fff 0px solid !important;
*}
*.sm-pie .legendColorBox div {
*    border-radius:100% !important;
*}
*.epie-chart {
*    position:relative;
*    display:inline-block;
*    width:80px;
*    height:80px;
*    text-align:center;
*}
*.epie-chart canvas {
*    position:absolute;
*    top:0;
*    left:0;
*}
*.percent {
*    display:inline-block;
*    line-height:80px;
*    z-index:2;
*}
*.pc-epie-chart {
*    position:relative;
*    display:inline-block;
*    width:50px;
*    height:50px;
*    text-align:center;
*}
*.pc-epie-chart canvas {
*    position:absolute;
*    top:0;
*    left:0;
*}
*.pc-epie-chart .percent {
*    display:inline-block;
*    line-height:50px;
*    z-index:2;
*    font-size:10px;
*    color:#5bc6f0;
*}
*.percent:after {
*    content:'%';
*    margin-left:0.1em;
*    font-size:.8em;
*}
*.chart-meta {
*    margin:0px;
*    padding-left: 0;
*    list-style: none;
*}
*.visit-chart-value {
*    font-size:18px;
*    color:#3acdc7;
*    font-weight:600;
*    padding-top:10px;
*}
*.visit-chart-title {
*    font-size:16px;
*    padding-top:10px;
*    color:#ccc;
*}
*.visit-chart-title i {
*    color:#3acdc7;
*}
*.top-stats-panel {
*    min-height:164px;
*}
*.top-stats-panel .sm-pie {
*    margin-top:30px;
*}
*.sm-pie {
*    height:100px;
*    width:100%;
*    display:block;
*}
*.target-sell {
*    height:40px;
*    width:100%;
*    display:block;
*}
*.side-graph-info {
*    float:left;
*    padding-top:7px;
*    padding-bottom:7px;
*    padding-left:15px;
*}
*.side-mini-graph {
*    float:right;
*    width:70px;
*    margin-right:10px;
*    text-align:center;
*}
*.side-graph-info.payment-info {
*    padding-top:10px;
*}
*.monthly-stats {
*    -webkit-border-radius:4px 4px 0px 0px;
*    border-radius:4px 4px 0px 0px;
*    margin:-15px -15px 15px -15px;
*    padding:15px;
*}
*.monthly-stats.pink {
*    background-color:#9972b5 !important;
*;
*}
*.sparkline {
*    text-align:center;
*}
*.monthly-stats h4 {
*    color:#fff;
*    font-weight:normal;
*    text-transform:uppercase;
*    margin:0px;
*    padding:5px 0px 10px 0px;
*}
*.circle-sat ul {
*    text-align:center;
*}
*.circle-sat ul li {
*    display:inline-block;
*}
*.circle-sat ul li span {
*    display:block;
*    text-transform:uppercase;
*}
*.left-stat-label span,.right-stat-label span {
*    display:block;
*}
*.left-stat-label {
*    text-align:right;
*    font-size:11px;
*    position:relative;
*    top:10px;
*    padding-right:10px;
*}
*.right-stat-label {
*    text-align:left;
*    font-size:11px;
*    position:relative;
*    top:10px;
*    padding-left:10px;
*}
*.left-stat-label .sell-percent {
*    color:#f9a10c;
*    font-size:14px;
*}
*.right-stat-label .sell-percent {
*    color:#36d8c0;
*    padding-top:30px;
*    font-size:14px;
*}
*.spark-bar-label span {
*    display:block;
*    color:#bbb;
*}
*.bar-label-value {
*    font-size:20px;
*    color:#666 !important;
*}
*.prospective-spark-bar {
*    margin:0px;
*    padding-left: 0;
*}
*.prospective-spark-bar li {
*    padding:20px 0px 20px 0px;
*    list-style: none;
*}
*.jqstooltip:after {
*    top:100%;
*    left:50%;
*    border:solid transparent;
*    content:' ';
*    height:0;
*    width:0;
*    position:absolute;
*    pointer-events:none;
*    border-color:rgba(136,183,213,0);
*    border-top-color:rgba(0,0,0,0.6);
*    border-width:4px;
*    margin-left:-4px;
*}
*.stat-btn {
*    padding:3px;
*    background-color:#eee6f5;
*    border-radius:3px;
*    height:24px;
*    color:#cab1d9;
*}
*.stat-btn:hover {
*    background-color:#422c50;
*    color:#cab1d9;
*}
*.stat-btn.active {
*    background-color:#422c50;
*    color:#cab1d9;
*}
*.region-earning-stats {
*    text-align:center;
*    color:#6d6d6d;
*    text-transform:uppercase;
*    padding:40px 30px;
*    font-family:'Open Sans',sans-serif;
*    font-weight:600;
*}
*.region-earning-stats span {
*    display:block;
*    color:#b0c781;
*    font-size:20px;
*}
*.location-earning-stats {
*    text-align:center;
*    font-family:'Open Sans',sans-serif;
*    font-weight:600;
*    margin-bottom:30px;
*    padding-left: 0;
*}
*.location-earning-stats li {
*    padding:0px 15px;
*}
*.location-earning-stats li {
*    display:inline-block;
*    text-transform:uppercase;
*    font-size:12px;
*}
*.location-earning-stats li span {
*    display:block;
*    font-size:14px;
*}
*.stat-divider {
*    border-right:#dadada 1px dashed;
*}
*.vector-stat {
*    height:150px;
*    margin-top:20px;
*}
*.alert-icon {
*    width:40px;
*    height:40px;
*    display:inline-block;
*    -webkit-border-radius:100%;
*    -moz-border-radius:100%;
*    border-radius:100%;
*}
*.alert-icon i {
*    width:40px;
*    height:40px;
*    display:block;
*    text-align:center;
*    line-height:40px;
*    font-size:20px;
*    color:#fff;
*}
*.notification-info {
*    margin-left:56px;
*    margin-top:-40px;
*}
*.notification-meta {
*    margin-bottom:3px;
*    padding-left: 0;
*    list-style: none;
*}
*.notification-info p {
*    margin:0px;
*    color:#999;
*    font-size:12px;
*}
*.alert-info .alert-icon {
*    background-color:#99cce3;
*}
*.alert-danger .alert-icon {
*    background-color:#fcb1ae;
*}
*.alert-success .alert-icon {
*    background-color:#98d7ad;
*}
*.alert-warning .alert-icon {
*    background-color:#ffe699;
*}
*.notification-sender {
*    color:#414147;
*}
*.notification-time {
*    font-style:italic;
*    color:#999;
*}
*.alert-info .notification-info a {
*    color:#45a2c9;
*}
*.alert-danger .notification-info a {
*    color:#fb6f6b;
*}
*.alert-success .notification-info a {
*    color:#42b663;
*}
*.alert-warning .notification-info a {
*    color:#e6cb76;
*}
*.alert-info.bucket-notification {
*    background-color:#eef7fd;
*}
*.alert-danger.bucket-notification {
*    background-color:#fef3f2;
*}
*.alert-success.bucket-notification {
*    background-color:#eef8f8;
*}
*.alert-warning.bucket-notification {
*    background-color: #fff7e1;
*}
*/*=Chat=*/
*.conversation-list {
*    list-style: none;
*    padding-left: 0;
*}
*.conversation-list li {
*    margin-bottom:24px;
*}
*.conversation-list .chat-avatar {
*    width:40px;
*    display:inline-block;
*    text-align:center;
*    float:left;
*}
*.conversation-list .chat-avatar i {
*    font-size:12px;
*    font-style:normal;
*}
*.conversation-list .ctext-wrap i {
*    display:block;
*    font-style:normal;
*    font-weight:bold;
*    position:relative;
*    font-size:12px;
*    color:#2cb9b3;
*}
*.conversation-list .conversation-text {
*    display:inline-block;
*    font-size:12px;
*    float:left;
*    margin-left:12px;
*    width:70%;
*}
*.conversation-list .ctext-wrap {
*    padding:10px;
*    background:#d5f2ef;
*    -webkit-border-radius:3px;
*    -moz-border-radius:3px;
*    border-radius:3px;
*    position:relative;
*    display:inline-block;
*}
*.conversation-list .ctext-wrap p {
*    margin:0px;
*    padding-top:3px;
*}
*.conversation-list .ctext-wrap:after {
*    right:100%;
*    top:20%;
*    border:solid transparent;
*    content:' ';
*    height:0;
*    width:0;
*    position:absolute;
*    pointer-events:none;
*    border-color:rgba(213,242,239,0);
*    border-right-color:#d5f2ef;
*    border-width:5px;
*    margin-top:-5px;
*}
*.conversation-list .odd .chat-avatar {
*    float:right !important;
*}
*.conversation-list .odd .conversation-text {
*    width:70% !important;
*    margin-right:12px;
*    text-align: right;
*    float:right !important;
*}
*.conversation-list .odd .ctext-wrap {
*    background:#eeeef2 !important;
*}
*.conversation-list .odd .ctext-wrap i {
*    color:#acacac;
*}
*.conversation-list .odd .ctext-wrap:after {
*    left:100% !important;
*    top:20% !important;
*    border-color:rgba(238,238,242,0)!important;
*    border-left-color:#eeeef2!important;
*}
*.chat-send {
*    padding-left:0px;
*}
*.chat-send button {
*    width: 100%;
*}
*/*=Event Calendar=*/
*.event-calendar {
*    background:#1fb5ac;
*    -webkit-border-radius:6px;
*    -moz-border-radius:6px;
*    border-radius:6px;
*    min-height:474px;
*}
*.calendar-block {
*    float:right !important;
*    -webkit-border-radius:0 5px 5px 0px;
*    -moz-border-radius:0 5px 5px 0px;
*    border-radius:0 5px 5px 0px;
*    background:#fff;
*    min-height:474px;
*    z-index: 1000;
*}
*.event-list-block {
*    -webkit-border-radius:5px 0px 0px 5px;
*    -moz-border-radius:5px 0px 0px 5px;
*    border-radius:5px 0px 0px 5px;
*}
*.calendar-block .clndr {
*    margin:40px 0;
*}
*.calendar-block .clndr {
*    margin:40px 0;
*}
*.calendar-block .clndr-controls {
*    margin:45px 0px !important;
*}
*.calendar-block .day-contents {
*    width:30px;
*    margin:auto;
*}
*.today .day-contents {
*    width:30px;
*    background:#1fb0ab;
*    cursor:pointer;
*    color:#fff;
*    -webkit-border-radius:3px;
*    -moz-border-radius:3px;
*    border-radius:3px;
*}
*.calendar-block .day-contents:hover {
*    width:30px;
*    background:#1fb0ab;
*    cursor:pointer;
*    color:#fff;
*    -webkit-border-radius:3px;
*    -moz-border-radius:3px;
*    border-radius:3px;
*}
*.event-list {
*    padding-left: 0;
*}
*.event-list li {
*    background:rgba(255,255,255,.2);
*    padding:10px 30px 10px 10px;
*    color:#fff;
*    margin-bottom:5px;
*    -webkit-border-radius:3px;
*    -moz-border-radius:3px;
*    border-radius:3px;
*    position:relative;
*    list-style: none;
*}
*
*.event-close {
*    display:inline-block;
*    font-size:20px;
*    color:#fff;
*    position:absolute;
*    right:4px;
*    top:8px;
*}
*.cal-day {
*    font-size:30px;
*    font-weight:300;
*    text-transform:uppercase;
*    color:#fff;
*    padding-top:15px;
*    padding-bottom:30px;
*}
*.cal-day span {
*    font-size:14px;
*    display:block;
*}
*.evnt-input,.evnt-input:focus {
*    background:none;
*    border:none;
*    border-bottom:#fff 1px solid;
*    -webkit-border-radius:0px;
*    -moz-border-radius:0px;
*    border-radius:0px;
*    color:#fff;
*    padding-left:0px;
*    margin-top:10px;
*}
*.widget-head {
*    position:relative;
*}
*.widget-collapse {
*    width:20px;
*    height:20px;
*    display:block;
*    text-align:center;
*    position:absolute;
*    right:10px;
*}
*.widget-collapse i {
*    width:20px;
*    height:20px;
*    display:block;
*    text-align:center;
*    line-height:20px;
*    font-size:8px;
*}
*.mini-stat {
*    background:#fff;
*    padding:20px;
*    -webkit-border-radius:3px;
*    -moz-border-radius:3px;
*    border-radius:3px;
*    margin-bottom:20px;
*}
*.mini-stat-icon {
*    width:60px;
*    height:60px;
*    display:inline-block;
*    line-height:60px;
*    text-align:center;
*    font-size:30px;
*    background:#eee;
*    -webkit-border-radius:100%;
*    -moz-border-radius:100%;
*    border-radius:100%;
*    float:left;
*    margin-right:10px;
*    color:#fff;
*}
*.mini-stat-info {
*    font-size:12px;
*    padding-top:2px;
*}
*.mini-stat-info span {
*    display:block;
*    font-size:24px;
*    font-weight:600;
*}
*.orange {
*    background:#fa8564 !important;
*}
*.tar {
*    background:#1fb5ac !important;
*}
*.mini-stat .green {
*    background:#aec785 !important;
*}
*.pink {
*    background:#a48ad4 !important;
*}
*.yellow-b {
*    background: #fdd752 !important;
*}
*/*== Weather Widget ==*/
*.weather-widget {
*    background:#fff;
*    -webkit-border-radius:3px;
*    -moz-border-radius:3px;
*    border-radius:3px;
*    margin-bottom:20px;
*    padding:12px 15px;
*}
*.weather-info {
*    margin:0px;
*}
*.weather-info li {
*    font-size:14px;
*    color:#ccc;
*    list-style: none;
*}
*.weather-icon {
*    margin-right:10px;
*    padding-right:10px;
*}
*.weather-icon canvas {
*    margin-top:15px;
*}
*.weather-cent span {
*    font-size:30px;
*    font-weight:700;
*    color:#aec785;
*}
*.weather-cent span:after {
*    content:'o';
*    font-size:16px;
*    position:relative;
*    top:-15px;
*}
*.bar-stats {
*    height:80px;
*    margin-top:20px;
*    border-bottom:#aec785 2px solid;
*    position:relative;
*}
*.progress-stat-bar {
*    padding-left:10px;
*}
*.progress-stat-bar li {
*    height:78px;
*    width:20px;
*    background:#f1f1f1;
*    position:relative;
*    margin-right:5px;
*    float:left;
*    list-style: none;
*}
*.progress-stat-percent {
*    background:#aec785;
*    display:block;
*    position:absolute;
*    bottom:0px;
*    left:0px;
*    width:100%;
*}
*.bar-legend {
*    position:absolute;
*    top:0px;
*    right:0px;
*    padding-left: 0;
*}
*.bar-legend li {
*    font-size:11px;
*    margin-bottom:5px;
*    list-style: none;
*}
*.bar-legend-pointer {
*    height:10px;
*    width:10px;
*    display:inline-block;
*    position:relative;
*    top:1px;
*    margin-right:5px;
*}
*.bar-legend-pointer.green {
*    background:#AEC785;
*}
*.daily-sales-info {
*    color:#ccc;
*}
*.daily-sales-info span {
*    display:inline-block;
*}
*.daily-sales-info span.sales-count {
*    font-size:18px;
*    color:#aec785;
*    font-weight:600;
*}
*.daily-sales-info {
*    padding-top:6px;
*}
*.daily-sales-info span.sales-label {
*    position:relative;
*    top:-2px;
*}
*.todo-title {
*    margin-right:70px;
*}
*.to-do-list {
*    padding-left: 0;
*}
*.to-do-list li {
*    background:#f3f3f3;
*    -webkit-border-radius:3px;
*    -moz-border-radius:3px;
*    border-radius:3px;
*    position:relative;
*    padding:13px;
*    margin-bottom:5px;
*    cursor:move;
*    list-style: none;
*}
*.to-do-list li p {
*    margin-bottom:0px;
*}
*.todo-actionlist {
*    position:absolute;
*    right:15px;
*    top:13px;
*}
*.todo-actionlist a {
*    height:24px;
*    width:24px;
*    display:inline-block;
*    float:left;
*}
*.todo-actionlist a i {
*    height:24px;
*    width:24px;
*    display:inline-block;
*    text-align:center;
*    line-height:24px;
*    color:#ccc;
*}
*.todo-actionlist a:hover i {
*    color:#666;
*}
*.todo-done i {
*    font-size:14px;
*}
*.todo-remove i {
*    font-size:10px;
*}
*.line-through {
*    text-decoration:line-through;
*}
*.todo-action-bar {
*    margin-top:20px;
*}
*.drag-marker {
*    height:17px;
*    display:block;
*    float:left;
*    width:7px;
*    position:relative;
*    top:2px;
*}
*.drag-marker i {
*    height:2px;
*    width:2px;
*    display:block;
*    background:#ccc;
*    box-shadow:5px 0 0 0px #ccc,0px 5px 0 0px #ccc,5px 5px 0 0px #ccc,0px 10px 0 0px #ccc,5px 10px 0 0px #ccc,0px 15px 0 0px #ccc,5px 15px 0 0px #ccc;
*    -webkit-box-shadow:5px 0 0 0px #ccc,0px 5px 0 0px #ccc,5px 5px 0 0px #ccc,0px 10px 0 0px #ccc,5px 10px 0 0px #ccc,0px 15px 0 0px #ccc,5px 15px 0 0px #ccc;
*    -moz-box-shadow: 5px 0 0 0px #ccc,0px 5px 0 0px #ccc,5px 5px 0 0px #ccc,0px 10px 0 0px #ccc,5px 10px 0 0px #ccc,0px 15px 0 0px #ccc,5px 15px 0 0px #ccc;
*}
*/* To-Do Check*/
*.to-do-list li .todo-check input[type=checkbox] {
*    visibility:hidden;
*}
*.todo-check {
*    width:20px;
*    position:relative;
*    margin-right:10px;
*    margin-left:10px;
*}
*.todo-check label {
*    cursor:pointer;
*    position:absolute;
*    width:20px;
*    height:20px;
*    top:0;
*    left:0px;
*    -webkit-border-radius:2px;
*    border-radius:2px;
*    border:#ccc 1px solid;
*}
*.todo-check label:after {
*    -ms-filter:'progid:DXImageTransform.Microsoft.Alpha(Opacity=0)';
*    filter:alpha(opacity=0);
*    opacity:0;
*    content:'';
*    position:absolute;
*    width:13px;
*    height:8px;
*    background:transparent;
*    top:3px;
*    left:3px;
*    border:3px solid #cfcfcf;
*    border-top:none;
*    border-right:none;
*    -webkit-transform:rotate(-45deg);
*    -moz-transform:rotate(-45deg);
*    -o-transform:rotate(-45deg);
*    -ms-transform:rotate(-45deg);
*    transform:rotate(-45deg);
*}
*.todo-checklabel:hover::after {
*    -ms-filter:'progid:DXImageTransform.Microsoft.Alpha(Opacity=30)';
*    filter:alpha(opacity=30);
*    opacity:0.3;
*}
*.todo-check input[type=checkbox]:checked+label:after {
*    -ms-filter:'progid:DXImageTransform.Microsoft.Alpha(Opacity=100)';
*    filter:alpha(opacity=100);
*    opacity:1;
*}
*.btn-todo-select button,.btn-add-task button {
*    width:100%;
*    font-size: 12px;
*}
*.todo-search-wrap {
*    padding:0px;
*}
*.todo-search {
*    -moz-border-radius:3px !important;
*    -webkit-border-radius:3px !important;
*    border-radius:3px !important;
*}
*.side-mini-stat {
*    padding:10px 0 !important;
*}
*.notification-pie-chart {
*    position:relative !important;
*    display:block;
*    height:50px;
*    width:50px;
*}
*.notification-pie-chart .pie-percent,.notification-pie-chart .percent {
*    width:50px !important;
*    height:50px !important;
*    display:block;
*    line-height:52px !important;
*    text-align:center;
*    margin-left:0px !important;
*    padding-left:0px !important;
*    position:absolute;
*    top:0px;
*    font-size:11px !important;
*    font-weight:normal !important;
*    color:#666;
*}
*.legendLabel {
*    padding-bottom:3px;
*}
*.notification-pie-chart .percent:after {
*    content:'%';
*    margin-left:0.1em;
*    font-size:.8em;
*}
*.first-city {
*    color:#7bd0d1;
*}
*.second-city {
*    color:#c5cc73;
*}
*.third-city {
*    color:#e47578;
*}
*.top-menu .dropdown-menu:after,.top-menu .dropdown-menu:before {
*    bottom:100%;
*    left:9%;
*    border:solid transparent;
*    content:' ';
*    height:0;
*    width:0;
*    position:absolute;
*    pointer-events:none;
*}
*.top-menu .dropdown-menu:after {
*    border-color:rgba(255,255,255,0);
*    border-bottom-color:#ffffff;
*    border-width:7px;
*    margin-left:-7px;
*}
*.top-menu .dropdown-menu:before {
*    border-color:rgba(238,238,238,0);
*    border-bottom-color:#eeeeee;
*    border-width:8px;
*    margin-left:-8px;
*}
*.pull-right.top-menu .dropdown-menu:after,.pull-right.top-menu .dropdown-menu:before {
*    bottom:100%;
*    left:90%;
*    border:solid transparent;
*    content:' ';
*    height:0;
*    width:0;
*    position:absolute;
*    pointer-events:none;
*}
*.pull-right.top-menu .dropdown-menu:after {
*    border-color:rgba(255,255,255,0);
*    border-bottom-color:#ffffff;
*    border-width:7px;
*    margin-left:-7px;
*}
*.pull-right.top-menu .dropdown-menu:before {
*    border-color:rgba(238,238,238,0);
*    border-bottom-color:#eeeeee;
*    border-width:8px;
*    margin-left: -8px;
*}
*/*Chart JS*/
*.chartJs {
*    width:100%;
*    display:block;
*}
*#gmap-list,#gmap-tabs {
*    height:450px;
*}
*#graph-area-line>svg,#graph-bar>svg {
*    width:100% !important;
*}
*.task-info .desc p {
*    padding-bottom:0px !important;
*}
*.task-info .desc h5 {
*    padding-top:8px;
*}
*.evnt-input:-moz-placeholder {
*    color:#fff !important;
*    font-size:12px;
*}
*.evnt-input::-moz-placeholder {
*    color:#fff !important;
*    font-size:12px;
*}
*.evnt-input:placeholder {
*    color:#fff !important;
*    font-size:12px;
*}
*.evnt-input::-webkit-input-placeholder {
*    color:#fff !important;
*    font-size: 12px;
*}
*
*#map-canvas{
*    margin-top: 40px;
*    width:400px;
*    height:400px;
*    webkit-border-radius:100%; -moz-border-radius:100%; border-radius:100%;
*    border:#eee 10px solid;
*}
*
*
*.gear-settings{ width: 35px; height: 35px; -webkit-border-radius: 0 30% 0 0; -moz-border-radius: 0 30% 0 0; border-radius: 0 30% 0 0;}
*
*.gear-settings i{
*    width: 35px; height: 35px;
*    display: inline-block;
*    text-align: center;
*    line-height: 33px;
*    font-size: 18px;
*    position: relative;
*    color: #BFBFC1;
*
*}
*
*.gear-settings:hover i{
*    color: #666;
*}
*
*
*.theme-switcher{ width: 228px;
*    padding-left: 7px;
*    border: #eee 1px solid;
*    position: fixed; top: -240px; right:-1px;  z-index:1000; background: #fff;  -webkit-transition:all .3s ease-in-out;
*    -moz-transition:all .3s ease-in-out;
*    -o-transition:all .3s ease-in-out;
*    transition: all .3s ease-in-out;
*
*}
*.show-switcher{
*right: -1px;
*    top:80px;
*    -webkit-transition:all .3s ease-in-out;
*    -moz-transition:all .3s ease-in-out;
*    -o-transition:all .3s ease-in-out;
*    transition: all .3s ease-in-out;
*}
*.theme-switcher h6{
*    padding: 10px 10px 0px 10px;
*    margin: 0px;
*}
*.color-list{
*    padding: 5px;
*
*}
*.select-layout{
*    padding: 10px;
*}
*.select-layout li a, .layout-option li a, .layout-option li .btn {
*    border-radius: 3px;
*    font-size: 12px;
*    padding: 3px 10px;
*    margin-right: 5px;
*}
*
*.color-list li{
*    width: 24px;
*    height: 24px;
*    display: inline-block;
*    float: left;
*    margin: 5px;
*}
*
*.theme-color {
*    cursor:pointer;
*}
*.default-theme {
*    background-color:#1FB5AD;
*}
*.blue-theme {
*    background-color:#38bbeb;
*}
*.green-theme {
*    background-color:#8ebf4e;
*}
*.orange-theme {
*    background-color:#fea352;
*}
*.purple-theme {
*    background-color:#9488dd;
*}
*.turquoise-theme {
*    background-color: #6ccac9;
*}
*
*.fixed-width{
*    background: #aeaeae;
*}
*.fixed-width #container{
*    width: 90%;
*    margin: auto;
*    overflow: hidden !important;
*    position: relative;
*}
*
*.fixed-width #container .header{
*    width: 90%;
*    left: auto;
*    right: auto;
*}
*
*
*.fixed-width #main-content{ background: #F1F2F7;}
*
*.fixed-width #container #sidebar{
*    position: absolute;
*}
*
*/*gallery*/
*
*.media-filter {
*    float: left;
*    margin: 10px 0;
*    padding-left: 0;
*}
*
*.media-filter li{
*    float: left;
*    margin-right: 10px;
*    list-style: none;
*}
*
*.media-filter li a{
*    background: #e6e6e6;
*    padding: 5px 10px;
*    border-radius: 4px;
*    -webkit-border-radius: 4px;
*}
*
*.media-filter li a:hover, .media-filter li a:focus{
*    background: #1FB5AD;
*    color: #fff;
*}
*
*.media-gal {
*    float: left;
*    width: 100%;
*    margin-top: 20px;
*}
*.media-gal .item {
*    float: left;
*}
*
*.media-gal .item {
*    margin-bottom: 1%;
*    margin-right: 1%;
*    width: 233px;
*    padding: 10px;
*    border: 1px solid #ddd;
*}
*
*.media-gal .item p {
*    margin-bottom: 0;
*    margin-top: 10px;
*    text-align: center;
*}
*
*.media-gal .item img {
*    height: 200px;
*    width: 100%;
*}
*
*.img-modal img{
*    width: 100%;
*    margin-bottom: 10px;
*}
*
*/* Start: Recommended Isotope styles */
*
*/* Isotope Filtering */
*
*.isotope-item {
*    z-index: 2;
*}
*
*.isotope-hidden.isotope-item {
*    pointer-events: none;
*    z-index: 1;
*}
*
*/*Isotope CSS3 transitions */
*
*.isotope,
*.isotope .isotope-item {
*    -webkit-transition-duration: 0.8s;
*    -moz-transition-duration: 0.8s;
*    -ms-transition-duration: 0.8s;
*    -o-transition-duration: 0.8s;
*    transition-duration: 0.8s;
*}
*
*.isotope {
*    -webkit-transition-property: height, width;
*    -moz-transition-property: height, width;
*    -ms-transition-property: height, width;
*    -o-transition-property: height, width;
*    transition-property: height, width;
*}
*
*.isotope .isotope-item {
*    -webkit-transition-property: -webkit-transform, opacity;
*    -moz-transition-property: -moz-transform, opacity;
*    -ms-transition-property: -ms-transform, opacity;
*    -o-transition-property: -o-transform, opacity;
*    transition-property: transform, opacity;
*}
*
*/*disabling Isotope CSS3 transitions */
*
*.isotope.no-transition,
*.isotope.no-transition .isotope-item,
*.isotope .isotope-item.no-transition {
*    -webkit-transition-duration: 0s;
*    -moz-transition-duration: 0s;
*    -ms-transition-duration: 0s;
*    -o-transition-duration: 0s;
*    transition-duration: 0s;
*}
*
*
*/* disable CSS transitions for containers with infinite scrolling*/
*.isotope.infinite-scrolling {
*    -webkit-transition: none;
*    -moz-transition: none;
*    -ms-transition: none;
*    -o-transition: none;
*    transition: none;
*}
*
*/*draggable portlet*/
*
*.sortable-box-placeholder {
*    height:200px !important;;
*    border: 2px dashed #828295;
*    margin-bottom: 20px;
*    background: #e5e6eb;
*}
*
*.sortable{
*    min-height: 400px;;
*}

*.right-side-accordion .terques-bg,.slimScrollBar,.brand,.sidebar-toggle-box,ul.top-menu>li>a:hover,ul.top-menu>li>a:focus,.toggle-right-box:hover  {
*    background:#38bbeb !important;
*}
*
*
*ul.sidebar-menu li ul.sub li a:hover,ul.sidebar-menu li ul.sub li.active a ,ul.sidebar-menu li a.active, ul.sidebar-menu li a:hover, ul.sidebar-menu li a:focus,ul.sidebar-menu li a.active i,ul.sidebar-menu li a:hover i,ul.sidebar-menu li a:focus i{
*    color: #38bbeb;
*}
*</style>
*</head>
*<body>

*<section id='container'>

* <header class='header fixed-top clearfix'>
*     <div class='brand'>
*         <a href='index.html' class='logo'>
*             <img src='http://h2consult.com.br/images/H22.png' alt=''>
*         </a>
*     </div>
* </header>
* <aside>
*   <div id='sidebar' class='nav-collapse'>
*     <div class='leftside-navigation'>
*       <ul class='sidebar-menu' sap_tag='ABAP_MENU' id='nav-accordion'>
*       </ul>
*     </div>
*   </div>
* </aside>

*</section>

*<script src="http://h2consult.com.br/html/jquery.js"></script>
*<script src="http://h2consult.com.br/html/jquery.dcjqaccordion.2.7.js"></script>
*<script src="http://h2consult.com.br/html/scripts.js"></script>

*</body>
*</html>
