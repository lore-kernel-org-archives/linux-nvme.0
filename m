From: swise@opengridcomputing.com (Steve Wise)
Date: Thu, 9 Jun 2016 10:48:19 -0500
Subject: nvme-fabrics: crash at nvme connect-all
In-Reply-To: <009201d1c265$41fead30$c5fc0790$@opengridcomputing.com>
References: <53708289.31891804.1465463883806.JavaMail.zimbra@kalray.eu>
 <5759614D.5080703@lightbits.io>
 <004901d1c252$b5978d10$20c6a730$@opengridcomputing.com>
 <005701d1c253$f9590550$ec0b0ff0$@opengridcomputing.com>
 <575973A4.9080001@lightbits.io>
 <006501d1c258$835dacc0$8a190640$@opengridcomputing.com>
 <006a01d1c25a$5b23c0d0$116b4270$@opengridcomputing.com>
 <007501d1c25b$574f43c0$05edcb40$@opengridcomputing.com>
 <1118189510.33005805.1465484651257.JavaMail.zimbra@kalray.eu>
 <009201d1c265$41fead30$c5fc0790$@opengridcomputing.com>
Message-ID: <009601d1c266$5820eaa0$0862bfe0$@opengridcomputing.com>


> 
> 
> Thanks Marta.  That card has less memory than the T580-CR.  I'm checking with
> Chelsio on the details.  The "-SO" might mean a mem-free card.
> 
> Also, can you email me the output of 'cat
/sys/kernel/debug/cxgb4/blah/meminfo'?
> 
> So to make it work given the adapter resources, you need to make the queues
> shallower and have less of them.  If I can get you a config file that
increases the
> available rdma memory, I'll send it to you.  But perhaps this card is just a
low/no
> memory card more tailored for NIC only vs RDMA. (I'll confirm this soon).

Yes, the -SO is a mem-free card, so very little rdma resources are available.
You need a non "-SO" card for more rdma resources.

Steve.
