From: sbates@raithlin.com (Stephen Bates)
Date: Wed, 5 Oct 2016 08:38:43 -0600
Subject: [PATCH 1/1] nvme : Add sysfs entry for NVMe CMBs when appropriate
In-Reply-To: <9d062df7-d895-4c21-ca0d-b4fc3cb878c1@grimberg.me>
References: <1475014513-18083-1-git-send-email-sbates@raithlin.com>
 <1475014513-18083-2-git-send-email-sbates@raithlin.com>
 <9d062df7-d895-4c21-ca0d-b4fc3cb878c1@grimberg.me>
Message-ID: <20161005143843.GA23281@cgy1-donard.priv.deltatee.com>

On Wed, Oct 05, 2016@11:22:51AM +0300, Sagi Grimberg wrote:
>
> >Add a sysfs attribute that contains salient information about the NVMe
> >Controller Memory Buffer when one is present. For now, just display the
> >information about the CMB available from the control registers. We attach
> >the CMB attribute file to the existing nvme_ctrl sysfs group so it can
> >handle the sysfs teardown.
>
> Hey Stephen,
>
> I'm wandering if placing this only for pci is correct. In theory, we
> could have fabrics expose a cmb (while its usage is still somewhat
> unknown at the moment).
>
> Perhaps cmbloc/cmbsize should exist in ctrl and be queried by
> ->reg_read32() callout. In addition, we would need a new map_cmb()
> callout in ctrl->ops.
>
> Thoughts?

Sagi

The fabrics specification currently denotes the CMBLOC and CMBSZ
properties as reserved [1]. So it is not currently possible to
advertise a CMB in a fabrics controller. While that might change down
the road we can't assume that is going to happen.

I am inclined to keep thingsin pci.c for now and then address this
again when (if) the fabrics specification gets updated.

Also I am wondering where the physical memory backing a fabrics CMB
would reside. Would this be memory in the fabric NIC on the host, in
the NIC on the target or somewhere else?

1. See Figure 27 of http://www.nvmexpress.org/wp-content/uploads/\
   NVMe_over_Fabrics_1_0_Gold_20160605.pdf

Cheers

Stephen
