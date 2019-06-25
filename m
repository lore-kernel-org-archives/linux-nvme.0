From: bvanassche@acm.org (Bart Van Assche)
Date: Tue, 25 Jun 2019 08:18:28 -0700
Subject: [PATCH] nvmet-rdma: Suppress a lockdep complaint
In-Reply-To: <1035014818.27150671.1561441925414.JavaMail.zimbra@kalray.eu>
References: <20190403230402.119428-1-bvanassche@acm.org>
 <1554392625.118779.243.camel@acm.org>
 <1035014818.27150671.1561441925414.JavaMail.zimbra@kalray.eu>
Message-ID: <7d28ee3d-0326-6d31-1cc6-13acc48e0d4d@acm.org>

On 6/24/19 10:52 PM, Marta Rybczynska wrote:
> ----- On 4 Apr, 2019,@17:43, Bart Van Assche bvanassche@acm.org wrote:
>> On Wed, 2019-04-03@16:04 -0700, Bart Van Assche wrote:
>>> Although the code that waits for controllers that are being teared down
>>> in nvmet_rdma_queue_connect() is fine, lockdep complains about that code.
>>> Lockdep complains because all release_work instances are assigned the
>>> same static lockdep key. Avoid that lockdep complains by using dynamic
>>> lockdep keys instead of static lockdep keys. See also the following
>>> commits:
>>> * 87915adc3f0a ("workqueue: re-add lockdep dependencies for flushing").
>>> * 777dc82395de ("nvmet-rdma: occasionally flush ongoing controller teardown").
>>> * 108c14858b9e ("locking/lockdep: Add support for dynamic keys").
>>>
>>> This patch avoids that lockdep reports the following:
>>>
>>> ======================================================
>>> WARNING: possible circular locking dependency detected
>>> 4.19.0-dbg #1 Not tainted
>>> ------------------------------------------------------
>>> kworker/u12:0/7 is trying to acquire lock:
>>
>> Please drop this patch - it is not sufficient to suppress the lockdep complaint.
>> I will see whether I can come up with a better solution.
>>
> 
> Have you had time to work on this one further? We're seeing the same issue.

Hi Marta,

I'm running all NVMe tests on my setup with the attached patch applied.

Bart.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0001-nvmet-rdma-Rework-DoS-attack-mitigation.patch
Type: text/x-patch
Size: 6984 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-nvme/attachments/20190625/87f6f945/attachment.bin>
