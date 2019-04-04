From: bvanassche@acm.org (Bart Van Assche)
Date: Thu, 04 Apr 2019 08:43:45 -0700
Subject: [PATCH] nvmet-rdma: Suppress a lockdep complaint
In-Reply-To: <20190403230402.119428-1-bvanassche@acm.org>
References: <20190403230402.119428-1-bvanassche@acm.org>
Message-ID: <1554392625.118779.243.camel@acm.org>

On Wed, 2019-04-03@16:04 -0700, Bart Van Assche wrote:
> Although the code that waits for controllers that are being teared down
> in nvmet_rdma_queue_connect() is fine, lockdep complains about that code.
> Lockdep complains because all release_work instances are assigned the
> same static lockdep key. Avoid that lockdep complains by using dynamic
> lockdep keys instead of static lockdep keys. See also the following
> commits:
> * 87915adc3f0a ("workqueue: re-add lockdep dependencies for flushing").
> * 777dc82395de ("nvmet-rdma: occasionally flush ongoing controller teardown").
> * 108c14858b9e ("locking/lockdep: Add support for dynamic keys").
> 
> This patch avoids that lockdep reports the following:
> 
> ======================================================
> WARNING: possible circular locking dependency detected
> 4.19.0-dbg #1 Not tainted
> ------------------------------------------------------
> kworker/u12:0/7 is trying to acquire lock:

Please drop this patch - it is not sufficient to suppress the lockdep complaint.
I will see whether I can come up with a better solution.

Bart.
