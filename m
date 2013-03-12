From: David.Darrington@hgst.com (David.Darrington@hgst.com)
Date: Tue, 12 Mar 2013 10:12:26 -0500
Subject: [PATCH 3/4] NVMe: End-to-end data protection
In-Reply-To: <alpine.LRH.2.03.1303111611440.17928@localhost.localdom>
Message-ID: <OF4D215762.7078BEB8-ON86257B2C.004F99F8-86257B2C.00538982@hgst.com>

I first noticed the kernels CONFIG_BLK_DEV_INTEGRITY option when I was 
trying to understand end-to-end protection and meta-data. When I saw the 
'struct bio_integrity_payload *' in the definition of the strucure, I 
figured that hte block layer (or perhaps above) could setup a 
bio_integrity_payload. In which case, the bio's received by the driver 
would already include bips and woudl simply write the meta-data to the 
drive. 

>From Documentation/block/data-integrity.txt in the kernel tree:

"...
The current implementation allows the block layer to automatically 
generate the protection information for any I/O.  Eventually the intent is 
to move the integrity metadata calculation to userspace for user data. 
Metadata and other I/O that originates within the kernel will still use 
the automatic generation interface.
...
"




 

"Linux-nvme" <linux-nvme-bounces at lists.infradead.org> wrote on 03/11/2013 
05:32:56 PM:

> On Mon, 11 Mar 2013, David.Darrington@hgst.com wrote:
> 
> > Is this correct:
> >> +/*
> >> + * Valid formats must have either no meta-data, or meta-data equal 
to
> > the DIF
> >> + * size and formatted for protection information. The driver has no 
use
> > for
> >> + * meta-data for any other purpose.
> >> + */
> >
> > This patch fails nvme_alloc_ns() if there is meta data, but data
> > protection is not enabled.
> >
> > Are there valid use cases where the driver passes through the 
meta-data to
> > and from the controller, without generating  or verifying? Is it 
possible
> > for applications to provided there own meta-data?
> 
> Other than the integrity extensions, I don't think there is anything in
> a bio request that a block driver can use to set the command meta-data
> pointer, whether an application wants to provide it or otherwise. Please
> let me know if I've missed something, though.
> 
> _______________________________________________
> Linux-nvme mailing list
> Linux-nvme at lists.infradead.org
> http://merlin.infradead.org/mailman/listinfo/linux-nvme
