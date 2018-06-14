From: srinath.mannam@broadcom.com (Srinath Mannam)
Date: Thu, 14 Jun 2018 16:18:15 +0530
Subject: Requirement to get BAR pci_bus_address in user space
In-Reply-To: <92a9eeced36f863458ca2fd029f17a20@codeaurora.org>
References: <CABe79T41Cr0mjH_k2drzccHvObFwRcW3n+WKCj0JvFUBy0wz-A@mail.gmail.com>
 <20180614102001.GA20836@lst.de>
 <CABe79T6k387EnDrpydTbQYQ+sZoWXKUee23EDzDJqnkroOmodA@mail.gmail.com>
 <92a9eeced36f863458ca2fd029f17a20@codeaurora.org>
Message-ID: <CABe79T5ZRBToOgCY0Myo47mkeOQ5FWrxgF-Bbdx-Pa3fmYPDGw@mail.gmail.com>

Hi Sinan Kaya,

Here are the details,

The issue is, For CMB cards SQs are allocated inside device BAR memory
which is different from normal cards.
In Normal cards SQ memory allocated at host side.
In both the cases physical address of CQ memory is programmed in NVMe
controller register.
This method works for normal cards because CQ memory is at host side.
But in CMB cards pci bus address equivalent to CQ memory needs to program.

More details are in the patch: nvme-pci: Use PCI bus address for
data/queues in CMB.

With the above patch issue is fixed in the NVMe kernel driver, But
similar fix is required in SPDK library also.
So, We need a mechanism to get pci_bus_address in user space libraries
to address this issue.

Regards,
Srinath.


On Thu, Jun 14, 2018@4:03 PM,  <okaya@codeaurora.org> wrote:
> On 2018-06-14 06:29, Srinath Mannam wrote:
>>
>> ++ Alex Williamson, kvm,
>>
>> Hi Christoph,
>>
>> Thank you for quick reply.
>>
>> If we want to add this in vfio then I think we need to do the same in
>> uio case also.
>>
>> As I mentioned in previous mail, in the current implementation
>> resource information (address and size) is gathering from resource
>> named file created in /sys directory.
>> So I expect it would be better to have similar method as existing in
>> sysfs.
>>
>
> Can you give some info on why you need the actual bar address value?
>
>>
>> Regards,
>> Srinath.
>>
>> On Thu, Jun 14, 2018@3:50 PM, Christoph Hellwig <hch@lst.de> wrote:
>>>
>>> The only safe way to use PCI(e) devices in userspace is through vfio.
>>> I think that is where you need to take your inquiries.
