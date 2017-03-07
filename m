From: sagi@grimberg.me (Sagi Grimberg)
Date: Tue, 7 Mar 2017 15:33:27 +0200
Subject: nvmet: race condition while CQE are getting processed
 concurrently with the DISCONNECTED event
In-Reply-To: <CY1PR12MB077418C35F6EA2499CBACA45BC2C0@CY1PR12MB0774.namprd12.prod.outlook.com>
References: <CY1PR12MB077418C35F6EA2499CBACA45BC2C0@CY1PR12MB0774.namprd12.prod.outlook.com>
Message-ID: <7dc99796-899e-b1a0-6ddb-cbfc497195dd@grimberg.me>

> Hello Sagi/Christoph,

Hi Raju,

CCing linux-nvme because I think I read a similar bug
report from Yi Zhang.

> Could you please help me with the below issue...
> I'm seeing a race condition when the CQEs are getting processed concurrently with the disconnected event. This ends up with NULL pointer dereference.
> The issue is seen when the interface is brought down while the nvme io is in progress.
>
> Below is the race that is seen between two threads....
>
>       Thread 1:                                                                                                           Thread 2:
>
> -> RDMA_CM_EVENT_DISCONNECTED event is received
> -> nvmet_rdma_queue_disconnect() gets called
>                                                                                                            -> nvmet_rdma_recv_done()  gets called
>       -> rdma_disconnect() and
>       -> schedule_work(&queue->release_work);
>                                                                                                                 -> nvmet_rdma_put_rsp()
> -> nvmet_rdma_release_queue_work() gets called
>       -> nvmet_rdma_free_queue() is called
>             -> nvmet_sq_destroy()
>             -> nvmet_rdma_destroy_queue_ib()
>                   -> ib_drain_qp(queue->cm_id->qp);
>                   -> rdma_destroy_qp(queue->cm_id);
>                   ->ib_free_cq(queue->cq);
>             -> nvmet_rdma_free_rsps(queue);
>                   -> nvmet_rdma_free_rsp(ndev, rsp)
>                                                                                                                       -> spin_lock_irqsave(&rsp->queue->rsps_lock, flags)
>                                                                                                                       BUG: unable to handle kernel NULL pointer dereference at 00000000000000b8
>                                                                                                                       IP: _raw_spin_lock_irqsave+0x18/0x40
>            -> kfree(queue)
> ------
>
> I would be happy to provide any details. I could also share the reproduction steps if you are interested.

Hmm, that's interesting,

So what I don't understand is how do we get a successful completion
after all the below finished successfully:
1. rdma_diconnect
2. ib_drain_qp
3. rdma_destroy_qp
4. ib_free_cq (which flushes the cq worker)

Only then we free the responses array and the queue itself.

Looking at the code there are two possible sources from this that
I can think of:

1. nvmet_sq_destroy is not doing its job for completing all
    its inflight requests. Although we do wait for the final
    ref on the nvmet_sq to drop to zero.

from percpu-refcount.h:
/**
  * percpu_ref_tryget_live - try to increment a live percpu refcount
  * @ref: percpu_ref to try-get
  *
  * Increment a percpu refcount unless it has already been killed.  Returns
  * %true on success; %false on failure.
  *
  * Completion of percpu_ref_kill() in itself doesn't guarantee that this
  * function will fail.  For such guarantee, percpu_ref_kill_and_confirm()
  * should be used.  After the confirm_kill callback is invoked, it's
  * guaranteed that no new reference will be given out by
  * percpu_ref_tryget_live().
  *
  * This function is safe to call as long as @ref is between init and exit.
  */

For that perhaps you can try patch [1].

2. ib_destroy_cq does not really protect against a case where
    the work requeue itself because it runs flush_work(). In this
    case when the work re-executes it polls a cq array that is
    already freed and sees a bogus successful completion. Perhaps
    ib_free_cq should run cancel_work_sync() instead? see [2].

Both of these options are far fetched... I'd try each individually
to see if one is a possible source of the problem.

Christoph, do you have a better idea?


[1]:
--
diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index 5267ce20c12d..b29e7483affb 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -423,6 +423,13 @@ void nvmet_sq_setup(struct nvmet_ctrl *ctrl, struct 
nvmet_sq *sq,
         ctrl->sqs[qid] = sq;
  }

+static void nvmet_confirm_sq(struct percpu_ref *ref)
+{
+       struct nvmet_sq *sq = container_of(ref, struct nvmet_sq, ref);
+
+       complete(&sq->confirm_done);
+}
+
  void nvmet_sq_destroy(struct nvmet_sq *sq)
  {
         /*
@@ -431,7 +438,8 @@ void nvmet_sq_destroy(struct nvmet_sq *sq)
          */
         if (sq->ctrl && sq->ctrl->sqs && sq->ctrl->sqs[0] == sq)
                 nvmet_async_events_free(sq->ctrl);
-       percpu_ref_kill(&sq->ref);
+       percpu_ref_kill_and_confirm(&sq->ref, nvmet_confirm_sq);
+       wait_for_completion(&sq->confirm_done);
         wait_for_completion(&sq->free_done);
         percpu_ref_exit(&sq->ref);

@@ -459,6 +467,7 @@ int nvmet_sq_init(struct nvmet_sq *sq)
                 return ret;
         }
         init_completion(&sq->free_done);
+       init_completion(&sq->confirm_done);

         return 0;
  }
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index 6ea32c49de58..1bbb67bf72d2 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -73,6 +73,7 @@ struct nvmet_sq {
         u16                     qid;
         u16                     size;
         struct completion       free_done;
+       struct completion       confirm_done;
  };

  /**
--

[2]:
--
diff --git a/drivers/infiniband/core/cq.c b/drivers/infiniband/core/cq.c
index e95510117a6d..2746d2eb3d52 100644
--- a/drivers/infiniband/core/cq.c
+++ b/drivers/infiniband/core/cq.c
@@ -196,7 +196,7 @@ void ib_free_cq(struct ib_cq *cq)
                 irq_poll_disable(&cq->iop);
                 break;
         case IB_POLL_WORKQUEUE:
-               flush_work(&cq->work);
+               cancel_work_sync(&cq->work);
                 break;
         default:
                 WARN_ON_ONCE(1);
--
