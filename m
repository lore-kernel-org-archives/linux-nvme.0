From: bvanassche@acm.org (Bart Van Assche)
Date: Tue, 12 Feb 2019 16:47:16 -0800
Subject: v5.0-rc2 and NVMeOF
In-Reply-To: <20190212174715.GP4240@linux.ibm.com>
References: <1547579226.83374.114.camel@acm.org>
 <6c18d8f8-949f-9502-566a-643d384e9113@grimberg.me>
 <1549905891.19311.5.camel@acm.org> <20190211210808.GS4240@linux.ibm.com>
 <1549924039.19311.26.camel@acm.org> <20190212012422.GX4240@linux.ibm.com>
 <1549990020.19311.40.camel@acm.org> <20190212174715.GP4240@linux.ibm.com>
Message-ID: <1550018836.19311.47.camel@acm.org>

On Tue, 2019-02-12@09:47 -0800, Paul E. McKenney wrote:
> It looks to me like you need an srcu_barrier(&head->srcu) just before
> the call to cleanup_srcu_struct_quiesced() in nvme_free_ns_head().
> Or maybe earlier in the cleanup flow, but most definitely -after- the
> last invocation of call_srcu().
> 
> Does that help?  Or is there a call to srcu_barrier() somewhere that I
> am blind to?

Hi Paul,

Even with this patch applied I still see the KASAN use-after-free warning:

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 6a9dd68c0f4f..f2e47af6f8ee 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -391,6 +391,7 @@ static void nvme_free_ns_head(struct kref *ref)
        nvme_mpath_remove_disk(head);
        ida_simple_remove(&head->subsys->ns_ida, head->instance);
        list_del_init(&head->entry);
+       srcu_barrier(&head->srcu);
        cleanup_srcu_struct_quiesced(&head->srcu);
        nvme_put_subsystem(head->subsys);
        kfree(head);

Does that mean that I misunderstood you?

Thanks,

Bart.
