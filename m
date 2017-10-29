From: anish.jhaveri@paviliondata.com (Anish Jhaveri)
Date: Sun, 29 Oct 2017 08:00:00 +0000
Subject: [PATCH 06/17] block: introduce GENHD_FL_HIDDEN
In-Reply-To: <99f3c781-71ce-f915-d6f4-88d6dd115876@huawei.com>
References: <20171023145126.2471-1-hch@lst.de>
 <20171023145126.2471-7-hch@lst.de> <20171024213959.GB23307@redhat.com>
 <20171028063825.GA14261@lst.de>
 <dc988a8a-8c88-fe20-34a0-de5cdd615b6b@huawei.com>
 <20171028074245.GA15510@lst.de>
 <99f3c781-71ce-f915-d6f4-88d6dd115876@huawei.com>
Message-ID: <DM3PR17MB0825BEF3B830E3ADF08688B097580@DM3PR17MB0825.namprd17.prod.outlook.com>

On Saturday, October 28, 2017 3:10 AM,  Guan Junxiong wrote:

>Does it mean some extra works such as:
>1) showing the path topology of nvme multipath device
Isn't connection to the target suppose guide the host to the shortest and fastest path available path or so called most optimized path. Sysfs entry can easily store that as we store path related info over there. 

>2) daemon to implement immediate and delayed failback
This is also based on target, whenever target is ready for immediate or delayed failback it will let the connect from host succeed. Until then host is in reconnecting state across all path until it finds an optimized or un-optimized path. Why is this extra daemon needed ?
 
>4) grouping paths besides ANA
Why we cannot use NS Group here.

Would be good idea to move away from legacy way of doing things for NVME devices. NVME Multipath implementation by Christoph is very simple. How about not making it super complicated.  

Best regards,
Anish
