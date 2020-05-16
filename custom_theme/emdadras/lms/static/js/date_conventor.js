//
//
//    Change All of your date in your webpage .... 
//    Just set class="date" for that element ... 
//    for example: <span class="date">2014-06-08</span>
//    convert to:    <span class="date">1393-07-08</span>
//    Developed By Mohsen Moradnejadi
//    Email : mohsen.moradnejadi@gmail.com
//    CopyRight GPL. 2014
//
//

var g_days=[31,28,31,30,31,30,31,31,30,31,30,31], j_days=[31,31,31,31,31,31,30,30,30,30,30,29];
var basicArray = new Array();
basicArray["ŚŲ§Ł†ŁŪŁ‡"] = 1;
basicArray["ŁŁŲ±Ų±ŪŁ‡"] = 2;
basicArray["Ł…Ų§Ų±Ś†"] = 3;
basicArray["Ų¢Ł¾Ų±ŪŁ„"] = 4;
basicArray["Ł…Ū"] = 5;
basicArray["ŚŁŲ¦Ł†"] = 6;
basicArray["Ų¬ŁŁ„Ų§Ū"] = 7;
basicArray["Ų¢ŚÆŁŲ³ŲŖ"] = 8;
basicArray["Ų³Ł¾ŲŖŲ§Ł…ŲØŲ±"] = 9;
basicArray["Ų§Ś©ŲŖŲØŲ±"] = 10;
basicArray["Ł†ŁŲ§Ł…ŲØŲ±"] = 11;
basicArray["ŲÆŲ³Ų§Ł…ŲØŲ±"] = 12;

function gregorianToJalali(entered_date) {
	var entered_date = entered_date.split(' ');
	var entered_date_d = entered_date[1].split(',');
    g_y = parseInt(entered_date[2]);
    g_m = parseInt(basicArray[entered_date[0]]);
    g_d = parseInt(entered_date_d[0]);
    var gy = g_y-1600;
    var gm = g_m-1;
    var gd = g_d-1;
    var g_day_no = 365*gy+parseInt((gy+3) / 4)-parseInt((gy+99)/100)+parseInt((gy+399)/400);
    for (var i=0; i < gm; ++i)
        g_day_no += g_days[i];
    if (gm>1 && ((gy%4==0 && gy%100!=0) || (gy%400==0)))
        ++g_day_no;
    g_day_no += gd;
    var j_day_no = g_day_no-79;
    var j_np = parseInt(j_day_no/ 12053);
    j_day_no %= 12053;
    var jy = 979+33*j_np+4*parseInt(j_day_no/1461);
    j_day_no %= 1461;
    if(j_day_no >= 366)
    {
        jy += parseInt((j_day_no-1)/ 365);
        j_day_no = (j_day_no-1)%365;
    }
    for(var i = 0; i < 11 && j_day_no >= j_days[i]; ++i)
        j_day_no -= j_days[i];
    var jm = i+1;
    var jd = j_day_no+1;
    var date = jy+'/'+jm+'/'+jd;
	return date;
}

$(document).ready(function(){
	$("[class*='date']").html(function(){
		var data = $( this ).text();
		var data = gregorianToJalali(data);
		$( this ).html(data);
	});
});

