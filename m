From: mgandhi@redhat.com (Milan P. Gandhi)
Date: Thu, 9 Aug 2018 19:33:38 +0530
Subject: [PATCH] Remove extra goto label from nvmet_ns_enable
In-Reply-To: <CAMNNMLFyLwk1n2_WTzqEhTJ=U+qseoFKe0=BV94aDZDekVrmuA@mail.gmail.com>
References: <20180809133344.GA11707@machine1>
 <CAMNNMLFyLwk1n2_WTzqEhTJ=U+qseoFKe0=BV94aDZDekVrmuA@mail.gmail.com>
Message-ID: <20180809140338.GA11901@machine1>

Hello,
On Thu, Aug 09, 2018@07:22:50PM +0530, Nikhil Kshirsagar wrote:
> Hello Milan!
> 
> I may be completely offtrack here, but was wondering about the fact
> that percpu_ref_init()
> seems to return -ENOMEM (ENOMEM seems #defined to 12) in specific cases,
> (not sure if that's handled even in the code as it is right now,) but if we
> allow for negative returns from percpu_ref_init() , then the ret=0 is not
> redundant because it still will return 0 to the caller function in cases
> like these.
> 
> Of course i am no expert in this code and have only just glanced at the
> code during our brief IRC discussion but just thought I'd put this note out
> there for reference. So do forgive me if I am mistaken and if there is a
> valid reason that -ENOMEM is not handled.
> 

In the following code if percpu_ref_init returns -ve, then we would be
dropped into if block (yes for both -ve and +ve ret value). Then the
control would be passed to out_unlock, where we exit the function as 
before. So if percpu_ref_init returns -ve, then in previous version of 
the code as well, we were just exiting from nvmet_ns_enable without
returning 0. 

 	ret = percpu_ref_init(&ns->ref, nvmet_destroy_namespace,
 				0, GFP_KERNEL);
-	if (ret)
-		goto out_dev_put;
-
+	if (ret) {
+		nvmet_ns_dev_disable(ns);
+		goto out_unlock;
+	}

if percpu_ref_init returns any -ve or +ve error code, then ideally the 
control should go to out_unlock with error return code passed back to
caller, but in either case we should not return 0.

So, the only possibility for reaching upto the following code block
seems to be that we already had ret value of 0. If ret was not zero,
and it had any -ve/+ve error return codes, then we should not have
reached to the below code block. This is because, as described above
the if (ret) statement will pass the control to out_unlock for both
-ve/+ve values of ret. I used a small c program to test the same
locally to confirm code flow for both -ve and +ve return values:


 	nvmet_ns_changed(subsys, ns->nsid);
 	ns->enabled = true;
-	ret = 0;
> 
> 
> 
> On Thu, Aug 9, 2018@7:03 PM, Milan P. Gandhi <mgandhi@redhat.com> wrote:
> 
> > Currently nvmet_ns_enable has two labels viz. out_unlock and
> > out_dev_put, and the reverse call from out_dev_put to out_unlock
> > is little bit confusing. We could simplify it by calling
> > nvmet_ns_dev_disable before. This would eliminate need for
> > 2nd label out_dev_put.
> >
> > Also, this function already initializes ret variable to 0,
> > so there is no need to initialize it to 0 before out_unlock,
> > so removing it.
> >
> > Signed-off-by: Milan P. Gandhi <mgandhi at redhat.com>
> > ---
> >  drivers/nvme/target/core.c | 12 +++++-------
> >  1 file changed, 5 insertions(+), 7 deletions(-)
> >
> > diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
> > index 9838103f2d62..b40fb6d724b4 100644
> > --- a/drivers/nvme/target/core.c
> > +++ b/drivers/nvme/target/core.c
> > @@ -346,9 +346,10 @@ int nvmet_ns_enable(struct nvmet_ns *ns)
> >
> >         ret = percpu_ref_init(&ns->ref, nvmet_destroy_namespace,
> >                                 0, GFP_KERNEL);
> > -       if (ret)
> > -               goto out_dev_put;
> > -
> > +       if (ret) {
> > +               nvmet_ns_dev_disable(ns);
> > +               goto out_unlock;
> > +       }
> >         if (ns->nsid > subsys->max_nsid)
> >                 subsys->max_nsid = ns->nsid;
> >
> > @@ -372,13 +373,10 @@ int nvmet_ns_enable(struct nvmet_ns *ns)
> >
> >         nvmet_ns_changed(subsys, ns->nsid);
> >         ns->enabled = true;
> > -       ret = 0;
> > +
> >  out_unlock:
> >         mutex_unlock(&subsys->lock);
> >         return ret;
> > -out_dev_put:
> > -       nvmet_ns_dev_disable(ns);
> > -       goto out_unlock;
> >  }
> >
> >  void nvmet_ns_disable(struct nvmet_ns *ns)
> > --
> > 2.14.3
> >
> >
> > _______________________________________________
> > Linux-nvme mailing list
> > Linux-nvme at lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-nvme
> >
