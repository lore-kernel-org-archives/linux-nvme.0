From: tom.leiming@gmail.com (Ming Lei)
Date: Tue, 30 Jul 2019 10:09:23 +0800
Subject: [PATCH rfc 1/2] nvme: don't remove namespace if revalidate failed
 because of controller reset
In-Reply-To: <8bd6d219-f4fd-de58-a341-257c6274eddd@grimberg.me>
References: <20190729233201.27993-1-sagi@grimberg.me>
 <20190729233201.27993-2-sagi@grimberg.me>
 <CACVXFVM+WGwQeqiK-poVKoQR4hVxCMWu0n0-HdVGb8EDDCySSA@mail.gmail.com>
 <464bb489-552f-b67e-545d-48616a1e76dd@grimberg.me>
 <CACVXFVO+e5De4+o8cqzvaVbMU22geicCbpmfk6zZStykEiDVmw@mail.gmail.com>
 <82a91815-f7ed-5931-58ac-5893e68cc940@grimberg.me>
 <CACVXFVN6o+dOFwDV=FPSHjVnhYSLBUWNHsXc4B=fwE5PAny_dQ@mail.gmail.com>
 <8bd6d219-f4fd-de58-a341-257c6274eddd@grimberg.me>
Message-ID: <CACVXFVNT5sjk4MC6qJoBFug8K9YgEFQEy6LSknJT6=O-2ispMg@mail.gmail.com>

On Tue, Jul 30, 2019@9:40 AM Sagi Grimberg <sagi@grimberg.me> wrote:
>
>
>
> On 7/29/19 6:30 PM, Ming Lei wrote:
> > On Tue, Jul 30, 2019@9:19 AM Sagi Grimberg <sagi@grimberg.me> wrote:
> >>
> >>
> >>>>>> If a controller reset is racing with a namespace revalidation, the
> >>>>>> revalidation I/O will surely fail, but we should not remove the
> >>>>>
> >>>>> No, there is sync IO request in revalidation, and the sync IO can't be completed
> >>>>> during resetting.
> >>>>
> >>>> Why? of course it can. The controller reset is responsible to
> >>>> quiesce + abort + unquiesce both I/O and admin commands.
> >>>
> >>> Abort simply cancels the in-flight requests, which will be retried &
> >>> re-queued into
> >>> blk-mq queues, and will be dispatched again after reset is done. That is why the
> >>> revalidation IO won't be failed.
> >>
> >> These I/Os are admin which will not be retried (because we mark it with
> >> REQ_FAILFAST_DRIVER).
> >
> > Yeah, this way is fine since data loss won't be caused.
> >
> >> As for normal I/O that meant to be retried, it
> >> still must either failfast or failover to another path.
> >
> > Why?  If the IO is failed, dirty pages may be lost, and it is one generic
> > issue in either multipath or not, and I don't think the normal IO should be
> > failed at least in case of non-multipath.
>
> This was meant only when the namespace is going away.
> Yea, if the namespace is not going away as described in this patch, then
> yes, it will block until reset is completed.
>
> >> (see the patch I sent Logan for an issue in this area:
> >> [PATCH v3] nvme: fix controller removal race with scan work)
> >
> > The above patch is only for multipath.
>
> Yes, and again, addresses the case that the namespace is going away.
>
> So I think we are in agreement? I only need to change the commit
> message from: "the revalidation I/O" to "the admin I/O" ?

That words of 'admin I/O' isn't related with the patch or issue.

> Yea, this should do the trick I guess:
> --
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index fa31da0762b9..d01976c93160 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -3428,7 +3428,8 @@ static void nvme_validate_ns(struct nvme_ctrl
> *ctrl, unsigned nsid)
>
>          ns = nvme_find_get_ns(ctrl, nsid);
>          if (ns) {
> -               if (ns->disk && revalidate_disk(ns->disk))
> +               if (ns->disk && ctrl->state == NVME_CTRL_LIVE &&
> +                   revalidate_disk(ns->disk)
>                          nvme_ns_remove(ns);
>                  nvme_put_ns(ns);
>          } else

If RESET is triggered just inside revalidate_disk(), and not done after
revalidate_disk() returns,  there is still race between reset and scan work.

For example, nvme_ns_remove() may hang for ever since the ns may be
quiesced in RESET, and can't be un-quiesced any more.

Thanks,
Ming Lei
