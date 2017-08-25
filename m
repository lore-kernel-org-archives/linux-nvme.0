From: martin.petersen@oracle.com (Martin K. Petersen)
Date: Fri, 25 Aug 2017 19:16:21 -0400
Subject: [PATCH v3] nvme: Honor RTD3 Entry Latency for shutdowns
In-Reply-To: <20170825195605.GC1207@localhost.localdomain> (Keith Busch's
 message of "Fri, 25 Aug 2017 15:56:05 -0400")
References: <20170824090222.GA2543@infradead.org>
 <20170825022641.1424-1-martin.petersen@oracle.com>
 <20170825195605.GC1207@localhost.localdomain>
Message-ID: <yq1378f5jcq.fsf@oracle.com>


Keith,

> My first experience with the kernel's 'clamp', so I had to look up
> that macro. The above does not appear to fit the usage since 'clamp'
> returns a value rather than directly clamp the parameter; I think it
> should be:
>
> 	transition_time = clamp(transition_time, shutdown_timeout, 60);

Ah, my brain was seduced by the do_div() above.

Fixed and tested in qemu.

-- 
Martin K. Petersen	Oracle Linux Engineering
