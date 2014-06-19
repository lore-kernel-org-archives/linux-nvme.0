From: willy@linux.intel.com (Matthew Wilcox)
Date: Thu, 19 Jun 2014 12:59:57 -0400
Subject: [PATCH] NVMe: Remove superfluous cqe_seen
In-Reply-To: <80B89753B40C5141A3E2D53FE7A2A8A9943A7ADC@NTXBOIMBX02.micron.com>
References: <537CED01.6040106@micron.com>
 <20140521231706.GP6121@linux.intel.com>
 <80B89753B40C5141A3E2D53FE7A2A8A9943A7ADC@NTXBOIMBX02.micron.com>
Message-ID: <20140619165957.GK12025@linux.intel.com>

On Thu, May 22, 2014@12:10:19AM +0000, Sam Bradshaw (sbradshaw) wrote:
> Performance problem, though not very easily measured.  At very high iops
> rates, most if not all cqe's are processed via nvme_process_cq() in 
> make_request(), leaving nvme_irq() with no work to do.  Nevertheless, it
> always writes cqe_seen, which invalidates a very hot cacheline.  This
> is somewhat exacerbated when IO submissions originate on a remote node
> relative to the cpu handling the irq.

I was thinking "Hey, we should move cqe_seen to a different cacheline".
So I looked at the cacheline assignments for the different variables,
and cqe_seen is on the same cacheline as cq_head and cq_phase, so that
cacheline is already being dirtied.  Indeed, it's in the same Dword as
cq_phase, so I'd be amazed if the CPU didn't coalesce the two writes.
That might be a more fruitful patch ... rearrange nvme_queue to put
cq_head, cq_phase and cqe_seen in the same Dword, and expect the CPU to
optimise the three assignments into a single Dword store.

I'll let you try it out since you have the setup to benchmark it.  Right now,
this is the layout I see:

        /* --- cacheline 3 boundary (192 bytes) --- */
        u32 *                      q_db;                 /*   192     8 */
        u16                        q_depth;              /*   200     2 */
        u16                        cq_vector;            /*   202     2 */
        u16                        sq_head;              /*   204     2 */
        u16                        sq_tail;              /*   206     2 */
        u16                        cq_head;              /*   208     2 */
        u16                        qid;                  /*   210     2 */
        u8                         cq_phase;             /*   212     1 */
        u8                         cqe_seen;             /*   213     1 */
        u8                         q_suspended;          /*   214     1 */

I notice a 4-byte hole after q_lock, so moving cq_head, cq_phase and
cqe_seen into that space would probably be a good idea (since that
cacheline is definitely dirty).  I really haven't tried to optimise the
frequently-updated parts of the data structure into the same cacheline,
and it should really help your bizarre setup :-).
