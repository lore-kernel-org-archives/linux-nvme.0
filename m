From: sim@linux.vnet.ibm.com (Narasimhan V)
Date: Fri, 30 Mar 2018 22:16:51 +0530
Subject: nguid for nvme over fabrics
In-Reply-To: <20180328082708.GA31409@infradead.org>
References: <410a2655c6f5e4ed9e1c2af36b72f3ee@linux.vnet.ibm.com>
 <4ab62a0f-5cee-cf62-33b3-f4097d34cf72@grimberg.me>
 <0832b33613cb166a1c3f46dd3c5d407d@linux.vnet.ibm.com>
 <20180328082708.GA31409@infradead.org>
Message-ID: <a4f728e9ce2ca0905c641614d1330a1f@linux.vnet.ibm.com>

On 2018-03-28 13:57, Christoph Hellwig wrote:
> On Fri, Mar 23, 2018@12:59:53PM +0530, Narasimhan V wrote:
>> Shouldn't it be unique ?
>> I have instances where for NVMef, multiple devices can have same 
>> nguids.
>> Which component should be responsible to generate nguid in NVMef ?
> 
> You must only usea nguid if you have a ieee id, and then it is your
> responsibility to hand out ids based on that.

Thnaks Chris,
I get it now.

> 
> Which means that you generally should not set a nguid unless you
> are building an appliance and really know what you are doing.
> 

For my confirmation, if we are setting duplicate nguids, it is user's
responsibility, and system does not give any warning / error ?

> _______________________________________________
> Linux-nvme mailing list
> Linux-nvme at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-nvme

-- 
Regards
Narasimhan V
