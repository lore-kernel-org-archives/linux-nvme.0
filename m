From: ming.lei@redhat.com (Ming Lei)
Date: Wed, 21 Mar 2018 19:50:43 +0800
Subject: [RFC PATCH] nvme: avoid race-conditions when enabling devices
In-Reply-To: <744877924.5841545.1521630049567.JavaMail.zimbra@kalray.eu>
References: <744877924.5841545.1521630049567.JavaMail.zimbra@kalray.eu>
Message-ID: <20180321115037.GA26083@ming.t460p>

On Wed, Mar 21, 2018@12:00:49PM +0100, Marta Rybczynska wrote:
> NVMe driver uses threads for the work at device reset, including enabling
> the PCIe device. When multiple NVMe devices are initialized, their reset
> works may be scheduled in parallel. Then pci_enable_device_mem can be
> called in parallel on multiple cores.
> 
> This causes a loop of enabling of all upstream bridges in
> pci_enable_bridge(). pci_enable_bridge() causes multiple operations
> including __pci_set_master and architecture-specific functions that
> call ones like and pci_enable_resources(). Both __pci_set_master()
> and pci_enable_resources() read PCI_COMMAND field in the PCIe space
> and change it. This is done as read/modify/write.
> 
> Imagine that the PCIe tree looks like:
> A - B - switch -  C - D
>                \- E - F
> 
> D and F are two NVMe disks and all devices from B are not enabled and bus
> mastering is not set. If their reset work are scheduled in parallel the two
> modifications of PCI_COMMAND may happen in parallel without locking and the
> system may end up with the part of PCIe tree not enabled.

Then looks serialized reset should be used, and I did see the commit
79c48ccf2fe ("nvme-pci: serialize pci resets") fixes issue of 'failed
to mark controller state' in reset stress test.

But that commit only covers case of PCI reset from sysfs attribute, and
maybe other cases need to be dealt with in similar way too.

Thanks,
Ming
