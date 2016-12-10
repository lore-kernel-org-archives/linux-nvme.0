From: dan.carpenter@oracle.com (Dan Carpenter)
Date: Sat, 10 Dec 2016 23:24:11 +0300
Subject: [patch] nvme-fabrics: correct some printk information
In-Reply-To: <alpine.DEB.2.20.1612102104050.1986@hadrien>
References: <20161210090618.GA11680@elgon.mountain>
 <1481369270.5946.51.camel@perches.com>
 <20161210184029.GY8176@mwanda>
 <alpine.DEB.2.20.1612102104050.1986@hadrien>
Message-ID: <20161210202411.GZ8176@mwanda>

For my check, most of the results fall into three categories.

1) False positives (40% of results)
2) Badly designed interfaces that take a pointer to a pointer for no
   reason and can be cleaned up. (5%)
3) Bugs where we modified the code, but haven't tested it.  Most of the
   time passing the wrong pointer will be detected right away during
   testing so it's not like this is a super common type of bug. (55%)

I haven't pushed the check because 40% false positives is probably
enough to make people complain.

regards,
dan carpenter
