From: mrybczyn@kalray.eu (Marta Rybczynska)
Date: Mon, 10 Apr 2017 13:29:37 +0200 (CEST)
Subject: [PATCH RFC] nvme-rdma: support devices with queue size < 32
In-Reply-To: <c7e56394-feb3-282b-0eec-166ef0d8b13c@grimberg.me>
References: <1315914765.312051621.1490259849534.JavaMail.zimbra@kalray.eu>
 <3505b835-d0ba-70cb-dfe8-1265fc2bbb83@redhat.com>
 <2ba93b5b-ad36-5533-36e2-9db2e3198c19@grimberg.me>
 <1121115847.336382032.1490883808617.JavaMail.zimbra@kalray.eu>
 <1224897571.353404199.1491481743295.JavaMail.zimbra@kalray.eu>
 <20170406130207.GI2269@mtr-leonro.local>
 <1917497781.360337179.1491571916242.JavaMail.zimbra@kalray.eu>
 <c7e56394-feb3-282b-0eec-166ef0d8b13c@grimberg.me>
Message-ID: <303729965.362188822.1491823777140.JavaMail.zimbra@kalray.eu>

>>>> Mellanox guys, do you have an idea what it might do?
>>>
>>> It will continue to work as expected with long depths too.
>>> All that you need is do not to forget to issue signal if queue is terminated.
>>>
>>
>> Thanks Leon. I will then submit the v2.
> 
> Marta, can you please test with higher queue-depth? Say 512 and/or 1024?
> 

Yes, we'll do that.

Marta
