From: mrybczyn@kalray.eu (Marta Rybczynska)
Date: Tue, 25 Jun 2019 07:52:05 +0200 (CEST)
Subject: [PATCH] nvmet-rdma: Suppress a lockdep complaint
In-Reply-To: <1554392625.118779.243.camel@acm.org>
References: <20190403230402.119428-1-bvanassche@acm.org>
 <1554392625.118779.243.camel@acm.org>
Message-ID: <1035014818.27150671.1561441925414.JavaMail.zimbra@kalray.eu>

----- On 4 Apr, 2019,@17:43, Bart Van Assche bvanassche@acm.org wrote:
> On Wed, 2019-04-03@16:04 -0700, Bart Van Assche wrote:
>> Although the code that waits for controllers that are being teared down
>> in nvmet_rdma_queue_connect() is fine, lockdep complains about that code.
>> Lockdep complains because all release_work instances are assigned the
>> same static lockdep key. Avoid that lockdep complains by using dynamic
>> lockdep keys instead of static lockdep keys. See also the following
>> commits:
>> * 87915adc3f0a ("workqueue: re-add lockdep dependencies for flushing").
>> * 777dc82395de ("nvmet-rdma: occasionally flush ongoing controller teardown").
>> * 108c14858b9e ("locking/lockdep: Add support for dynamic keys").
>> 
>> This patch avoids that lockdep reports the following:
>> 
>> ======================================================
>> WARNING: possible circular locking dependency detected
>> 4.19.0-dbg #1 Not tainted
>> ------------------------------------------------------
>> kworker/u12:0/7 is trying to acquire lock:
> 
> Please drop this patch - it is not sufficient to suppress the lockdep complaint.
> I will see whether I can come up with a better solution.
> 

Bart,
Have you had time to work on this one further? We're seeing the same issue.

Thanks,
Marta
