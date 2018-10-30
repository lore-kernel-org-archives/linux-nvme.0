From: bvanassche@acm.org (Bart Van Assche)
Date: Tue, 30 Oct 2018 12:43:32 -0700
Subject: [PATCH v3 0/2] nvmet-rdma: Rework the DoS mitigation code
In-Reply-To: <5de7d107-47b5-bf4d-1e7c-b4782b92acc3@grimberg.me>
References: <20181025211309.100564-1-bvanassche@acm.org>
 <56c7461f-d6c1-0fd2-30c8-334967fc3013@grimberg.me>
 <1540579520.66186.118.camel@acm.org>
 <5de7d107-47b5-bf4d-1e7c-b4782b92acc3@grimberg.me>
Message-ID: <1540928612.196084.129.camel@acm.org>

On Tue, 2018-10-30@11:30 -0700, Sagi Grimberg wrote:
> But are we sure we can't simply resolve the false lockdep complaint?

Hi Sagi,

Although I agree that the code that is currently upstream is fine, it is
hard to teach this to lockdep. The flush_workqueue(nvmet_rdma_delete_wq)
call waits for all work that has been queued on nvmet_rdma_delete_wq and is
called with a CM ID handler mutex held. Work items queued on that work queue
lock and unlock the CM ID handler mutex. This is fine because each work
queue flush call waits for deletion of previously created CM IDs to finish.
I think that teaching this to lockdep would require to model the handler
mutex of later created CM IDs as outer locks and the handler mutexes of
earlier created CM IDs as inner locks. The 'subclass' argument of the
functions in <linux/lockdep.h> represents the locking nesting level. A
subclass could be associated with the handler mutex by setting it at CM ID
creation time. Since CM IDs associated with logins are created from inside
the RDMA CM I'm not sure how to implement this. Additionally, the maximum
number of subclasses supported by lockdep is not that high:

#define MAX_LOCKDEP_SUBCLASSES 8UL

It's not clear to me how to model CM ID cleanup as nested locking after more
than MAX_LOCKDEP_SUBCLASSES logins.

Since I am not aware of an elegant way to suppress this lockdep complaint
without also suppressing useful reports I came up with this patch series.

This patch series brings two additional benefits:
- Lower latency for login due to the removal of a flush_workqueue() call from
  the login code.
- Removal of a global workqueue. 

If you would prefer to implement another solution to get rid of this lockdep
complaint, alternative proposals are welcome.

Bart.
