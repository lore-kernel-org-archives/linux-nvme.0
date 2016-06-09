From: swise@opengridcomputing.com (Steve Wise)
Date: Thu, 9 Jun 2016 10:40:32 -0500
Subject: nvme-fabrics: crash at nvme connect-all
In-Reply-To: <1118189510.33005805.1465484651257.JavaMail.zimbra@kalray.eu>
References: <53708289.31891804.1465463883806.JavaMail.zimbra@kalray.eu>
 <5759614D.5080703@lightbits.io>
 <004901d1c252$b5978d10$20c6a730$@opengridcomputing.com>
 <005701d1c253$f9590550$ec0b0ff0$@opengridcomputing.com>
 <575973A4.9080001@lightbits.io>
 <006501d1c258$835dacc0$8a190640$@opengridcomputing.com>
 <006a01d1c25a$5b23c0d0$116b4270$@opengridcomputing.com>
 <007501d1c25b$574f43c0$05edcb40$@opengridcomputing.com>
 <1118189510.33005805.1465484651257.JavaMail.zimbra@kalray.eu>
Message-ID: <009201d1c265$41fead30$c5fc0790$@opengridcomputing.com>

> > I don't see this on my 16 core/64GB memory note, I successfully did a
> > discover/connect-all with the target/host on the same node with 7 target devices
> > w/o any errors.   Note I'm using the nvmf-all.2 branch Christoph setup up
> > yesterday.
> >
> > Marta, I need to learn more about your T5 setup and the "stats" file output.
> > Thanks!
> >
> > Steve.
> 
> Steve, It seems to me that there's a PBLMEM exhaustion because my card has less
> resources than yours (224 MRs if I repeat your calculations):
> # cat /sys/kernel/debug/iw_cxgb4/0000\:09\:00.4/stats
>    Object:      Total    Current        Max       Fail
>      PDID:      65536          1          2          0
>       QID:       1024          0          0          0
>    TPTMEM:      91136          0          0          0
>    PBLMEM:     227840          0          0          0
>    RQTMEM:     318976          0          0          0
>   OCQPMEM:          0          0          0          0
>   DB FULL:          0
>  DB EMPTY:          0
>   DB DROP:          0
>  DB State: NORMAL Transitions 0 FC Interruptions 0
> TCAM_FULL:          0
> ACT_OFLD_CONN_FAILS:          0
> PAS_OFLD_CONN_FAILS:          0
> NEG_ADV_RCVD:          0
> AVAILABLE IRD:       1024
> 
> Fore the more exact reference, it's:
> [   18.651764] cxgb4 0000:09:00.4 eth1: eth1: Chelsio T580-LP-SO (0000:09:00.4)
> 40GBASE-R QSFP
> [   18.651979] cxgb4 0000:09:00.4 eth2: eth2: Chelsio T580-LP-SO (0000:09:00.4)
> 40GBASE-R QSFP
> [   18.652025] cxgb4 0000:09:00.4: Chelsio T580-LP-SO rev 0
> 
> No config file in the firmware directory.
> 


Thanks Marta.  That card has less memory than the T580-CR.  I'm checking with Chelsio on the details.  The "-SO" might mean a mem-free card.   

Also, can you email me the output of 'cat /sys/kernel/debug/cxgb4/blah/meminfo'?

So to make it work given the adapter resources, you need to make the queues shallower and have less of them.  If I can get you a config file that increases the available rdma memory, I'll send it to you.  But perhaps this card is just a low/no memory card more tailored for NIC only vs RDMA. (I'll confirm this soon).

Steve
