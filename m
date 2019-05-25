From: keith.busch@gmail.com (Keith Busch)
Date: Sat, 25 May 2019 08:07:59 -0600
Subject: [PATCH 3/3] nvme: quiesce admin queue for fw activation
In-Reply-To: <20190525131710.GA342@minwooim-desktop>
References: <20190524202036.17265-1-keith.busch@intel.com>
 <20190524202036.17265-4-keith.busch@intel.com>
 <20190525131710.GA342@minwooim-desktop>
Message-ID: <CAOSXXT5QT4q7fbTgs-k50DU87xeidgFoGkJDboY59ypU6ovHzQ@mail.gmail.com>

On Sat, May 25, 2019@7:17 AM Minwoo Im <minwoo.im.dev@gmail.com> wrote:
> > diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> > index 96dac2292897..5a6d27823f7f 100644
> > --- a/drivers/nvme/host/core.c
> > +++ b/drivers/nvme/host/core.c
> > @@ -3604,7 +3604,10 @@ static void nvme_fw_act_work(struct work_struct *work)
> >               fw_act_timeout = jiffies +
> >                               msecs_to_jiffies(admin_timeout * 1000);
> >
> > +     dev_info(ctrl->device, "processing paused for fw activation\n");
> >       nvme_stop_queues(ctrl);
> > +     blk_mq_quiesce_queue(ctrl->admin_q);
>
> Keith,
>
> Can we have an warning here to indicate if device firmware has not set
> the CSTS.PP yet.  In that case, the information message that you have
> introduced here may be invalid.  It would be great if we check the
> CSTS.PP first, and then print it out.
>
> If it's not necessary to have it, please feel free to let me know.
> Of course, device has to prepared the processing paused status,
> though :)

Well, between the fw notice AEN and when the work can finally check
CSTS.PP, we really have no way of knowing if the controller paused and
resumed before we observed that controller status, so a warning would
be a bit much. We're still quiescing, so the print is valid.

In case the controller did pause processing, and we hit the unusual
timeout race that does not see CSTS.PP, the new prints make it clear
that's what happened.
