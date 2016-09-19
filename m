From: Bart.VanAssche@sandisk.com (Bart Van Assche)
Date: Mon, 19 Sep 2016 13:33:15 +0000
Subject: [PATCH RFC 00/21] blk-mq: Introduce combined hardware queues
References: <cover.1474014910.git.agordeev@redhat.com>
 <20160916210448.GA1178@localhost.localdomain>
 <20160919103805.GA22169@agordeev.lab.eng.brq.redhat.com>
Message-ID: <BLUPR02MB1683C205076B5CFAFAA87B1681F40@BLUPR02MB1683.namprd02.prod.outlook.com>

On 09/19/16 03:38, Alexander Gordeev wrote:
> On Fri, Sep 16, 2016@05:04:48PM -0400, Keith Busch wrote:
>
> CC-ing linux-block at vger.kernel.org
>
>> I'm not sure I see how this helps. That probably means I'm not considering
>> the right scenario. Could you elaborate on when having multiple hardware
>> queues to choose from a given CPU will provide a benefit?
>
> No, I do not keep in mind any particular scenario besides common
> sense. Just an assumption deeper queues are better (in this RFC
> a virtual combined queue consisting of multipe h/w queues).
>
> Apparently, there could be positive effects only in systems where
> # of queues / # of CPUs > 1 or # of queues / # of cores > 1. But
> I do not happen to have ones. If I had numbers this would not be
> the RFC and I probably would not have posted in the first place ;)
>
> Would it be possible to give it a try on your hardware?

Hello Alexander,

It is your task to measure the performance impact of these patches and 
not Keith's task. BTW, I'm not convinced that multiple hardware queues 
per CPU will result in a performance improvement. I have not yet seen 
any SSD for which a queue depth above 512 results in better performance 
than queue depth equal to 512. Which applications do you think will 
generate and sustain a queue depth above 512? Additionally, my 
experience from another high performance context (RDMA) is that reducing 
the number of queues can result in higher IOPS due to fewer interrupts 
per I/O.

Bart.
