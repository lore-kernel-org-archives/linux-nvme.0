From: james_p_freyensee@linux.intel.com (J Freyensee)
Date: Thu, 01 Oct 2015 09:35:38 -0700
Subject: [PATCH 3/4] nvme: split pci specific functionality out of core
 code
In-Reply-To: <560D2D26.5000703@dev.mellanox.co.il>
References: <1443493257.3449.15.camel@linux.intel.com>
 <560D2D26.5000703@dev.mellanox.co.il>
Message-ID: <1443717338.2803.58.camel@linux.intel.com>

On Thu, 2015-10-01@15:55 +0300, Sagi Grimberg wrote:
> On 9/29/2015 5:20 AM, J Freyensee wrote:
> >  From d4d0aa24c3e422dbf01b400b2992f76a7d7691b2 Mon Sep 17 00:00:00 
> > 2001
> > From: Jay Sternberg <jay.e.sternberg at intel.com>
> > Date: Mon, 28 Sep 2015 11:38:12 -0700
> > Subject: [PATCH 3/4] nvme: split pci specific functionality out of 
> > core
> > code
> 
> As said in other patch, empty change logs usually are for trivial
> patches only...

What is not clear that the summary email and the the 'Subject' line is
not explaining?  Would you like me to just include the summary email
into patch 2/4 and 3/4?  Without knowing what is not clear, all I would
add is basically the 'subject' description, which is this patch is
splitting out the pci from the current nvme code and making it a
transport extension.  Any more explanation seems I am just re
-documenting the code?

Other than that, is the actual patch ok?  I was about ready to send an
email asking if the silence of this patch set means it is OK and will
be applied to the nvme tree to submission to the upstream kernel?

> > 
> > Signed-off-by: Jay Sternberg <jay.e.sternberg at intel.com>
> > ---
> >   drivers/nvme/host/Kconfig  |   23 +-
> >   drivers/nvme/host/Makefile |   12 +
> >   drivers/nvme/host/core.c   |  852 ++++++-------------------------
> > -----
> > ----
> >   drivers/nvme/host/ops.h    |   56 +++
> >   drivers/nvme/host/pci.c    |  954
> > ++++++++++++++++++++++++++++++++++++++++++++
> >   drivers/nvme/host/scsi.c   |   17 +-
> >   6 files changed, 1169 insertions(+), 745 deletions(-)
> >   create mode 100644 drivers/nvme/host/ops.h
> >   create mode 100644 drivers/nvme/host/pci.c
> > 
> > diff --git a/drivers/nvme/host/Kconfig b/drivers/nvme/host/Kconfig
> > index 4118c2e..2c7bc73 100644
> > --- a/drivers/nvme/host/Kconfig
> > +++ b/drivers/nvme/host/Kconfig
> > @@ -1,8 +1,6 @@
> >   config NVME_HOST
> >          tristate "NVM Express block device"
> > -       depends on NVME
> > -       depends on PCI
> > -       depends on BLOCK
> > +       depends on NVME && BLOCK
> >          ---help---
> >   	 The NVM Express driver is for solid state drives directly
> >   	 connected to the PCI or PCI Express bus.  If you know you
> > @@ -10,3 +8,22 @@ config NVME_HOST
> > 
> >   	 To compile this driver as a module, choose M here: the
> >   	 module will be called nvme.
> > +
> > +config NVME_INCLUDE_PCI
> > +       bool "Include Local PCIe Support"
> > +       depends on NVME_HOST && PCI
> > +       default y
> > +       ---help---
> > +	 The NVM Express driver is for solid state drives directly
> > +	 connected to the local PCI or PCI Express bus.  If you 
> > know
> > +	 you don't have one of these, it is safe to answer N.
> > +
> > +config NVME_PCI
> > +       tristate "PCI Support"
> > +       depends on NVME_INCLUDE_PCI
> > +       default y
> > +       ---help---
> > +	 choose y to have Local PCI support in the NVM Express 
> > module.
> > +	 choose m to have Local PCI support in a separate modules 
> > from
> > the
> > +	   NVM Express module.
> > +	   the module will be called nvme_pci.
> > diff --git a/drivers/nvme/host/Makefile 
> > b/drivers/nvme/host/Makefile
> > index 10cf9a5..373cd73 100644
> > --- a/drivers/nvme/host/Makefile
> > +++ b/drivers/nvme/host/Makefile
> > @@ -1,3 +1,15 @@
> >   obj-$(CONFIG_NVME_HOST)		+= nvme.o
> > 
> > +ifeq ("$(CONFIG_NVME_PCI)","m")
> > +  obj-$(CONFIG_NVME_HOST)	+= nvme_pci.o
> > +endif
> > +
> >   nvme-y				:= core.o scsi.o
> > +
> > +ifeq ("$(CONFIG_NVME_PCI)","m")
> > +  nvme_pci-y			+= pci.o
> > +else
> > +  ifeq ("$(CONFIG_NVME_PCI)","y")
> > +    nvme-y			+= pci.o
> > +  endif
> > +endif
> > diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> > index dec3961..cda911f 100644
> > --- a/drivers/nvme/host/core.c
> > +++ b/drivers/nvme/host/core.c
> > @@ -1,6 +1,6 @@
> >   /*
> >    * NVM Express device driver
> > - * Copyright (c) 2011-2014, Intel Corporation.
> > + * Copyright (c) 2011-2015, Intel Corporation.
> 
> This change is not related to the patch.
> 
> > diff --git a/drivers/nvme/host/ops.h b/drivers/nvme/host/ops.h
> > new file mode 100644
> > index 0000000..6727da2
> > --- /dev/null
> > +++ b/drivers/nvme/host/ops.h
> > @@ -0,0 +1,56 @@
> > +/*
> > + * Copyright (C) 2015 Intel Corporation. All rights reserved.
> > + *
> > + * This program is free software; you can redistribute it and/or
> > + * modify it under the terms of the GNU General Public License 
> > version
> > + * 2 as published by the Free Software Foundation.
> > + *
> > + * This program is distributed in the hope that it will be useful,
> > + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> > + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> > + * GNU General Public License for more details.
> > + */
> > +
> > +#ifndef _NVME_OPS_H
> > +#define _NVME_OPS_H
> > +
> > +void nvme_dev_shutdown(struct nvme_dev *dev);
> > +int nvme_dev_resume(struct nvme_dev *dev);
> > +void nvme_dead_ctrl(struct nvme_dev *dev);
> > +void nvme_remove(struct nvme_dev *dev);
> > +void nvme_common_reset_failed_dev(struct nvme_dev *dev);
> > +struct nvme_dev *nvme_common_create_dev(struct device *device, 
> > void
> > *context);
> > +void nvme_dev_reset(struct nvme_dev *dev);
> > +int nvme_dev_add(struct nvme_dev *dev);
> > +void nvme_scan_namespaces(struct nvme_dev *dev, unsigned nn);
> > +int nvme_process_cq(struct nvme_queue *nvmeq);
> > +
> > +int nvme_pci_get_version(struct nvme_dev *dev);
> > +int nvme_pci_get_vector(struct nvme_queue *nvmeq);
> > +int nvme_pci_is_active(struct nvme_dev *dev);
> > +int nvme_pci_is_status_fatal(struct nvme_dev *dev);
> > +int nvme_pci_is_ready(struct nvme_dev *dev);
> > +int nvme_pci_subsys_reset(struct nvme_dev *dev);
> > +int nvme_pci_is_io_incapable(struct nvme_dev *dev);
> > +void nvme_pci_process_cq(struct nvme_queue *nvmeq, u16 head);
> > +int nvme_pci_submit_sync_cmd(struct nvme_queue *nvmeq,
> > +				    struct nvme_command *cmd);
> > +int nvme_pci_submit_async_cmd(struct nvme_queue *nvmeq,
> > +				     struct nvme_command *cmd,
> > +				     struct nvme_iod *iod);
> > +void nvme_pci_set_irq_hints(struct nvme_dev *dev);
> > +int nvme_pci_setup_io_queues(struct nvme_dev *dev, int 
> > nr_io_queues);
> > +int nvme_pci_disable_ctrl(struct nvme_dev *dev);
> > +int nvme_pci_enable_ctrl(struct nvme_dev *dev);
> > +int nvme_pci_shutdown_ctrl(struct nvme_dev *dev);
> > +void nvme_pci_init_queue(struct nvme_queue *nvmeq);
> > +int nvme_pci_create_queue(struct nvme_queue *nvmeq);
> > +int nvme_pci_setup_admin_queue(struct nvme_queue *nvmeq);
> > +void nvme_pci_suspend_queue(struct nvme_queue *nvmeq, int vector);
> > +int nvme_pci_alloc_queue(struct nvme_queue *nvmeq);
> > +int nvme_pci_dev_add(struct nvme_dev *dev);
> > +int nvme_pci_dev_map(struct nvme_dev *dev);
> > +void nvme_pci_dev_unmap(struct nvme_dev *dev);
> > +void nvme_pci_remove_dead_ctrl(struct nvme_dev *dev);
> 
> This patch moved all the routines to pci.c but rather still
> keeps the core calls with nvme_pci_ prefix and the next patch
> just replaces them to function pointers and extends
> nvme_common_create_dev().
> 
> Maybe a better arrangement would be to start with extending
> nvme_common_create_dev() with ops and the functions implementation in
> pci.c and then replace the core calls to nvme_ops->op(). This way you
> can avoid adding code that is removed in a following patch (which is 
> a
> bit confusing).
> 
> Just a suggestion.
