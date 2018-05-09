From: ddutile@redhat.com (Don Dutile)
Date: Wed, 9 May 2018 11:53:19 -0400
Subject: [PATCH v4 04/14] PCI/P2PDMA: Clear ACS P2P flags for all devices
 behind switches
In-Reply-To: <3C9FB262-A93C-4C8F-B1E0-85C6D6F78BC2@raithlin.com>
References: <20180423233046.21476-1-logang@deltatee.com>
 <20180423233046.21476-5-logang@deltatee.com>
 <CAPcyv4g+5N_n03J-VhmJfrr60Sqk95ZapLKBkwSsGvV4nQ+ZRw@mail.gmail.com>
 <64C231F5-DE36-415F-B308-3A423B0BBACB@raithlin.com>
 <15433946-f7f5-f610-4e80-380fb59920e5@redhat.com>
 <3C9FB262-A93C-4C8F-B1E0-85C6D6F78BC2@raithlin.com>
Message-ID: <9c85f5a1-a6dc-4a59-4162-03749088a87d@redhat.com>

On 05/08/2018 05:27 PM, Stephen  Bates wrote:
> Hi Don
> 
>> Well, p2p DMA is a function of a cooperating 'agent' somewhere above the two devices.
>>     That agent should 'request' to the kernel that ACS be removed/circumvented (p2p enabled) btwn two endpoints.
>>     I recommend doing so via a sysfs method.
> 
> Yes we looked at something like this in the past but it does hit the IOMMU grouping issue I discussed earlier today which is not acceptable right now. In the long term, once we get IOMMU grouping callbacks to VMs we can look at extending p2pdma in this way. But I don't think this is viable for the initial series.
> 
>      
>>             So I don't understand the comments why VMs should need to know.
> 
> As I understand it VMs need to know because VFIO passes IOMMU grouping up into the VMs. So if a IOMMU grouping changes the VM's view of its PCIe topology changes. I think we even have to be cognizant of the fact the OS running on the VM may not even support hot-plug of PCI devices.
>      
>> Is there a thread I need to read up to explain /clear-up the thoughts above?
> 
> If you search for p2pdma you should find the previous discussions. Thanks for the input!
> 
under linux-pci I'm assuming...
you cc'd a number of upstream lists; I picked this thread up via rdma-list.

> Stephen
>      
>      
> 
