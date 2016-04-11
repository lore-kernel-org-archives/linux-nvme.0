From: gpiccoli@linux.vnet.ibm.com (Guilherme G. Piccoli)
Date: Mon, 11 Apr 2016 17:57:19 -0300
Subject: [PATCH 1/2] nvme: Fix pci_device_id table by adding the most
 generic devices in the end
In-Reply-To: <20160411204823.GL2781@linux.intel.com>
References: <1460405751-8884-1-git-send-email-gpiccoli@linux.vnet.ibm.com>
 <20160411204823.GL2781@linux.intel.com>
Message-ID: <570C0FAF.6030000@linux.vnet.ibm.com>

On 04/11/2016 05:48 PM, Matthew Wilcox wrote:
> On Mon, Apr 11, 2016@05:15:50PM -0300, Guilherme G. Piccoli wrote:
>> The struct pci_device_id is used on a PCI driver probe by the PCI core
>> mechanism to match the devices present on the system with the driver
>> being probed. For each device, the match procedure reads each entry in
>> the pci_device_id struct provided by the driver and tries to match the
>> first entry it is able to do.
>
> What you're missing is that the Apple device doesn't have the NVMe
> programming model / class code.  So this patch actually has no effect.
>

Oh, okay. Thanks for pointing this. I imagined that it would be possible 
that this Apple device does not have NVMe class code (or it would been a 
mistake have added the entry after the PCI_DEVICE_CLASS() in that table).

Anyway, my choice was to send the patch and take the shot. Do you want 
me to re-send the 2nd part of this patch alone, as v2?

Cheers,



Guilherme
