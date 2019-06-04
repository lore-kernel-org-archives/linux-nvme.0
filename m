From: akinobu.mita@gmail.com (Akinobu Mita)
Date: Tue, 4 Jun 2019 22:36:22 +0900
Subject: [PATCH v2 2/3] nvme: enable to inject errors into admin commands
In-Reply-To: <20190604072336.GC15680@lst.de>
References: <1559483421-11361-1-git-send-email-akinobu.mita@gmail.com>
 <1559483421-11361-3-git-send-email-akinobu.mita@gmail.com>
 <20190604072336.GC15680@lst.de>
Message-ID: <CAC5umyho33qSbyxDo3m0mUd4nkxBuorXDs3TxcgAM0fao+1DqQ@mail.gmail.com>

2019?6?4?(?) 16:24 Christoph Hellwig <hch at lst.de>:
>
> >       struct nvme_fault_inject *fault_inject = NULL;
> >       u16 status;
> >
> > -     /*
> > -      * make sure this request is coming from a valid namespace
> > -      */
> >       if (disk) {
> >               struct nvme_ns *ns = disk->private_data;
> >
> >               if (ns)
> >                       fault_inject = &ns->fault_inject;
>
>
> Not new in this code, but how could ns ever be NULL here?

Not likely.  Should we simply remove this check or add WARN_ON_ONCE()?

> > @@ -257,6 +266,8 @@ struct nvme_ctrl {
> >        */
> >       struct thermal_zone_device *tzdev[9];
> >  #endif
>
> Looks like this series seem to be based on the thermal zone series.

Oops.

> > -struct nvme_fault_inject {
> > -#ifdef CONFIG_FAULT_INJECTION_DEBUG_FS
> > -     struct fault_attr attr;
> > -     struct dentry *parent;
> > -     bool dont_retry;        /* DNR, do not retry */
> > -     u16 status;             /* status code */
> > -#endif
>
> It would be nicer to already move it up earlier when you change the ifdef
> guared.

OK.

> Otherwise the whole series looks fine:
>
> Reviewed-by: Christoph Hellwig <hch at lst.de>
