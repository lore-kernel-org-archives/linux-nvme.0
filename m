From: agordeev@redhat.com (Alexander Gordeev)
Date: Mon, 20 Jan 2014 09:38:36 +0100
Subject: [PATCH v2 5/9] nvme: Fix invalid call to irq_set_affinity_hint()
In-Reply-To: <alpine.LRH.2.03.1401171419370.25844@AMR>
References: <cover.1389904166.git.agordeev@redhat.com>
 <1c441f670f33375b6c41e074baf6e84e6c7bb0c2.1389904166.git.agordeev@redhat.com>
 <CAErSpo4g_xm4vZWZDgyjtJu+z5ARSerQLrtJ6W_peXv4bKwcgg@mail.gmail.com>
 <alpine.LRH.2.03.1401171419370.25844@AMR>
Message-ID: <20140120083835.GA19068@dhcp-26-207.brq.redhat.com>

On Fri, Jan 17, 2014@03:01:10PM -0700, Keith Busch wrote:
> >dev->entry[0].vector is initialized in nvme_dev_map(), and it's used
> >for free_irq() above the area of your patch, so I don't think this is
> >actually a bug, though it might be somewhat confusing.
> 
> It is confusing, but there's a reason. :)
> 
> We send a single command using legacy irq to discover how many msix
> vectors we want. The legacy entry needs to be set some time before calling
> request_irq in nvme_configure_admin_queue, but also within nvme_dev_start
> (for power-management). I don't think there's a place to set it that
> won't look odd when looking at nvme_setup_io_queues. I settled on
> 'nvme_dev_map' was because 'nvme_dev_unmap' invalidates the entries,
> so this seemed to provide some amount of symmetry.

I am sending v3 of the patch which concerns Bjorn's comment.

I am also sending two follow-up patches an attempt to make nvme_dev_start()
more readable and fix couple of (what I suspect are) issues.

Thanks!

-- 
Regards,
Alexander Gordeev
agordeev at redhat.com
