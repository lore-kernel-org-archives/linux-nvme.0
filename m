From: sagi@grimberg.me (Sagi Grimberg)
Date: Thu, 22 Mar 2018 21:08:44 +0200
Subject: Nvme over fabrics controller reset issue
In-Reply-To: <CADLzrv8jrv4SMYa9BOFOi4rkyBkfYQD5QJ64QVqyXrCnDddVKg@mail.gmail.com>
References: <CADLzrv8jrv4SMYa9BOFOi4rkyBkfYQD5QJ64QVqyXrCnDddVKg@mail.gmail.com>
Message-ID: <0a04da62-0b81-df13-6b38-7d5a067f255d@grimberg.me>

> Hi All,
> 
> I found a strange behaviour when I used NVMe Fabrics target.  From
> Host I sent a Set property command to make CC.EN=0. And then again I
> made CC.EN=1. I was expecting all the transport and nvme queus will be
> deleted. But didn't happen, rather queus are retained connection is
> still active.
> 
>   Isn't violation of NVMe spec. Is there any reason for implementing this way?

No good reason, just an oversight I guess..

Does this (untested) patch get it right?
--
diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index fa2a02c6f0c6..c01490c924bd 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -637,9 +637,11 @@ static void nvmet_clear_ctrl(struct nvmet_ctrl *ctrl)
  {
         lockdep_assert_held(&ctrl->lock);

-       /* XXX: tear down queues? */
         ctrl->csts &= ~NVME_CSTS_RDY;
         ctrl->cc = 0;
+
+       /* tear down controller queues (or what's left of them) */
+       ctrl->ops->delete_ctrl(ctrl);
  }

  void nvmet_update_cc(struct nvmet_ctrl *ctrl, u32 new)
--
