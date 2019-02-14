From: keith.busch@intel.com (Keith Busch)
Date: Thu, 14 Feb 2019 14:17:15 -0700
Subject: [PATCH] nvme: Enable acceleration feature of A64FX processor
In-Reply-To: <AT5PR8401MB1169E9738C0A4754D0190F2FAB670@AT5PR8401MB1169.NAMPRD84.PROD.OUTLOOK.COM>
References: <20190201124615.16107-1-indou.takao@jp.fujitsu.com>
 <20190201145414.GA22199@localhost.localdomain>
 <20190205124757.GA28465@esprimo>
 <20190205143905.GG22199@localhost.localdomain>
 <AT5PR8401MB1169E9738C0A4754D0190F2FAB670@AT5PR8401MB1169.NAMPRD84.PROD.OUTLOOK.COM>
Message-ID: <20190214211715.GA9613@localhost.localdomain>

On Thu, Feb 14, 2019@12:44:48PM -0800, Elliott, Robert (Persistent Memory) wrote:
> 
> The PCIe and NVMe specifications dosn't standardize a way to tell the device
> when to use RO, which leads to system workarounds like this.
> 
> The Enable Relaxed Ordering bit defined by PCIe tells the device when it
> cannot use RO, but doesn't advise when it should or shall use RO.

In general, it is always safe to use RO for any memory writes that have
no order dependency on other RO writes. It's impossible for the PCIe spec
to standardize what packets may or may not have a such a dependency:
that is specific to the higher protocol of device, so RO behavior has
to be out of scope for PCI spec. It only says to don't use it when it
isn't safe to do so, like for MSI.

For NVMe, there is no order dependency on PRP/SGL data since it is
perfectly valid for the controller to transfer these out-of-order
already. Letting the memory controller re-order them would also have to
be spec compliant.

The host is not allowed to assume the data is there until it observes
the CQE for that command, so the CQE is the only NVMe protocol dev->host
transfer that has a strict order depenency and not valid for RO (you
risk data corruption if you do this wrong).

The NVMe spec does't spell this out, but some controller implementations
do this today anyway. If it is really that confusing to hardware vendors,
though, I don't think it'd be harmful to propose an ECN to clarify
appropriate RO usage, and also a plus if it would get more vendors to
take notice of this optimization.
 
> For SCSI Express (SOP+PQI), we were going to allow specifying these
> on a per-command basis:
> * TLP attributes (No Snoop, Relaxed Ordering, ID-based Ordering)
> * TLP processing hints (Processing Hints and Steering Tags)
>
> to be used by the data transfers for the command. In some systems, one
> setting per queue or per device might suffice. Transactions to the
> queues and doorbells require stronger ordering.
> 
> For this workaround:
> * making an extra pass through the SGL to set the address bit is
> inefficient; it should be done as the SGL is created.
> * why doesn't it support PRP Lists?
> * how does this interact with an iommu, if there is one? Must the
> address with bit 56 also be granted permission, or is that
> stripped off before any iommu comparisons?
