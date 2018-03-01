From: sbates@raithlin.com (Stephen  Bates)
Date: Thu, 1 Mar 2018 18:54:01 +0000
Subject: [PATCH v2 04/10] PCI/P2PDMA: Clear ACS P2P flags for all devices
 behind switches
In-Reply-To: <20180301180257.GH13722@bhelgaas-glaptop.roam.corp.google.com>
References: <20180228234006.21093-1-logang@deltatee.com>
 <20180228234006.21093-5-logang@deltatee.com>
 <20180301180257.GH13722@bhelgaas-glaptop.roam.corp.google.com>
Message-ID: <0D05579B-789C-4A19-B3A2-C1A630BE31C0@raithlin.com>

Thanks for the detailed review Bjorn!

>>  
>> +	  Enabling this option will also disable ACS on all ports behind
>> +	  any PCIe switch. This effictively puts all devices behind any
>> +	  switch into the same IOMMU group.

>
>  Does this really mean "all devices behind the same Root Port"?

Not necessarily. You might have a cascade of switches (i.e switches below a switch) to achieve a very large fan-out (in an NVMe SSD array for example) and we will only disable ACS on the ports below the relevant switch.

> What does this mean in terms of device security?  I assume it means,
> at least, that individual devices can't be assigned to separate VMs.

This was discussed during v1 [1]. Disabling ACS on all downstream ports of the switch means that all the EPs below it have to part of the same IOMMU grouping. However it was also agreed that as long as the ACS disable occurred at boot time (which is does in v2) then the virtualization layer will be aware of it and will perform the IOMMU group formation correctly.
    
> I don't mind admitting that this patch makes me pretty nervous, and I
> don't have a clear idea of what the implications of this are, or how
> to communicate those to end users.  "The same IOMMU group" is a pretty
> abstract idea.
    
Alex gave a good overview of the implications in [1].

Stephen 

[1] https://marc.info/?l=linux-pci&m=151512320031739&w=2
