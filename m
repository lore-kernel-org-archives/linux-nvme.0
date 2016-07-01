From: famz@redhat.com (Fam Zheng)
Date: Fri, 1 Jul 2016 09:03:07 +0800
Subject: [PATCH v2 04/12] axonrom: Generate uevent after attribute
 available
In-Reply-To: <CAA9_cmf0cKZXdQ2N3iSbwVqgLDGJ7TMvVYuZTqjVE-7EqHHcdg@mail.gmail.com>
References: <20160630015953.6888-1-famz@redhat.com>
 <20160630015953.6888-5-famz@redhat.com>
 <CAA9_cmf0cKZXdQ2N3iSbwVqgLDGJ7TMvVYuZTqjVE-7EqHHcdg@mail.gmail.com>
Message-ID: <20160701010307.GC10122@ad.usersys.redhat.com>

On Thu, 06/30 15:10, Dan Williams wrote:
> On Wed, Jun 29, 2016@6:59 PM, Fam Zheng <famz@redhat.com> wrote:
> > It is documented that KOBJ_ADD should be generated after the object's
> > attributes and children are ready.  We can achieve this with the new
> > disk_gen_uevents interface.
> >
> > Signed-off-by: Fam Zheng <famz at redhat.com>
> > ---
> >  arch/powerpc/sysdev/axonram.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/arch/powerpc/sysdev/axonram.c b/arch/powerpc/sysdev/axonram.c
> > index 4efd69b..27e7175 100644
> > --- a/arch/powerpc/sysdev/axonram.c
> > +++ b/arch/powerpc/sysdev/axonram.c
> > @@ -238,7 +238,7 @@ static int axon_ram_probe(struct platform_device *device)
> >         set_capacity(bank->disk, bank->size >> AXON_RAM_SECTOR_SHIFT);
> >         blk_queue_make_request(bank->disk->queue, axon_ram_make_request);
> >         blk_queue_logical_block_size(bank->disk->queue, AXON_RAM_SECTOR_SIZE);
> > -       add_disk(bank->disk, true);
> > +       add_disk(bank->disk, false);
> >
> >         bank->irq_id = irq_of_parse_and_map(device->dev.of_node, 0);
> >         if (bank->irq_id == NO_IRQ) {
> > @@ -262,6 +262,7 @@ static int axon_ram_probe(struct platform_device *device)
> >                 rc = -EFAULT;
> >                 goto failed;
> >         }
> > +       disk_gen_uevents(bank->disk);
> 
> I assume you are doing this after:
> 
>    rc = device_create_file(&device->dev, &dev_attr_ecc);
> 
> ...so that userspace gets notified of the new attribute, but this
> attribute is on the parent device, not the disk itself.  Instead I
> think this attribute should simply be registered before the call to
> add_disk().  Then the KOBJ_ADD event for the disk comes after the
> attribute is available.  It's still not a clean fit, because userspace
> should not be expecting a child device uevent to signal new attributes
> available on the parent.

Yes you are right, this patch is a mistake. Moving to before add_disk makes
sense to me.

Thanks for taking a look!

Fam
