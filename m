From: okaya@codeaurora.org (okaya@codeaurora.org)
Date: Thu, 14 Jun 2018 06:33:41 -0400
Subject: Requirement to get BAR pci_bus_address in user space
In-Reply-To: <CABe79T6k387EnDrpydTbQYQ+sZoWXKUee23EDzDJqnkroOmodA@mail.gmail.com>
References: <CABe79T41Cr0mjH_k2drzccHvObFwRcW3n+WKCj0JvFUBy0wz-A@mail.gmail.com>
 <20180614102001.GA20836@lst.de>
 <CABe79T6k387EnDrpydTbQYQ+sZoWXKUee23EDzDJqnkroOmodA@mail.gmail.com>
Message-ID: <92a9eeced36f863458ca2fd029f17a20@codeaurora.org>

On 2018-06-14 06:29, Srinath Mannam wrote:
> ++ Alex Williamson, kvm,
> 
> Hi Christoph,
> 
> Thank you for quick reply.
> 
> If we want to add this in vfio then I think we need to do the same in
> uio case also.
> 
> As I mentioned in previous mail, in the current implementation
> resource information (address and size) is gathering from resource
> named file created in /sys directory.
> So I expect it would be better to have similar method as existing in 
> sysfs.
> 

Can you give some info on why you need the actual bar address value?

> 
> Regards,
> Srinath.
> 
> On Thu, Jun 14, 2018@3:50 PM, Christoph Hellwig <hch@lst.de> wrote:
>> The only safe way to use PCI(e) devices in userspace is through vfio.
>> I think that is where you need to take your inquiries.
