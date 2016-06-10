From: swise@opengridcomputing.com (Steve Wise)
Date: Fri, 10 Jun 2016 08:49:20 -0500
Subject: nvme-fabrics: crash at nvme connect-all
In-Reply-To: <2067929658.34819006.1465566159158.JavaMail.zimbra@kalray.eu>
References: <53708289.31891804.1465463883806.JavaMail.zimbra@kalray.eu>
 <006a01d1c25a$5b23c0d0$116b4270$@opengridcomputing.com>
 <007501d1c25b$574f43c0$05edcb40$@opengridcomputing.com>
 <1118189510.33005805.1465484651257.JavaMail.zimbra@kalray.eu>
 <009201d1c265$41fead30$c5fc0790$@opengridcomputing.com>
 <009601d1c266$5820eaa0$0862bfe0$@opengridcomputing.com>
 <135617120.33923984.1465549423989.JavaMail.zimbra@kalray.eu>
 <013001d1c31d$ae9b3450$0bd19cf0$@opengridcomputing.com>
 <2067929658.34819006.1465566159158.JavaMail.zimbra@kalray.eu>
Message-ID: <014201d1c31e$e3a45d10$aaed1730$@opengridcomputing.com>

> >> Here it is:
> >> # cat /sys/kernel/debug/cxgb4/0000\:09\:00.4/meminfo
> >> EDC0:           0x0-0x2fffff [3.00 MiB]
> >> EDC1:           0x300000-0x5fffff [3.00 MiB]
> >
> >
> > The "-SO" cards have no external off-chip memory, as seen above.  If it did have
> > off-chip memory there would be a "MC0" and possibly "MC1" lines above with a
> > large amount of memory.    Like this (T580-CR):
> >
> > MC0:            0x600000-0x405fffff [1.00 GiB]
> > MC1:            0x40600000-0x805fffff [1.00 GiB]
> >
> > So your -SO cards will only handle a very small amount of RDMA load.
> >
> 
> Thanks Steve for looking up into this. It's a good testcase then :)
> 
> Marta

Indeed!
