From: srinath.mannam@broadcom.com (Srinath Mannam)
Date: Fri, 15 Jun 2018 11:41:47 +0530
Subject: Requirement to get BAR pci_bus_address in user space
In-Reply-To: <fc8795b0a4619d4c4abc55fdf010015db7272db5.camel@intel.com>
References: <CABe79T41Cr0mjH_k2drzccHvObFwRcW3n+WKCj0JvFUBy0wz-A@mail.gmail.com>
 <20180614102001.GA20836@lst.de>
 <CABe79T6k387EnDrpydTbQYQ+sZoWXKUee23EDzDJqnkroOmodA@mail.gmail.com>
 <92a9eeced36f863458ca2fd029f17a20@codeaurora.org>
 <CABe79T5ZRBToOgCY0Myo47mkeOQ5FWrxgF-Bbdx-Pa3fmYPDGw@mail.gmail.com>
 <20180614085015.3f39b367@w520.home>
 <fc8795b0a4619d4c4abc55fdf010015db7272db5.camel@intel.com>
Message-ID: <CABe79T4yopn4FJqSv+igvekNBZOgmySxyoxFfFzQP=grd9p=vg@mail.gmail.com>

Thank you very much Alex and Ben for all the details.

Please find my comments in lined..


On Fri, Jun 15, 2018 at 1:34 AM, Walker, Benjamin
<benjamin.walker@intel.com> wrote:
> On Thu, 2018-06-14@08:50 -0600, Alex Williamson wrote:
>> On Thu, 14 Jun 2018 16:18:15 +0530
>> Srinath Mannam <srinath.mannam@broadcom.com> wrote:
>>
>> > Hi Sinan Kaya,
>> >
>> > Here are the details,
>> >
>> > The issue is, For CMB cards SQs are allocated inside device BAR memory
>> > which is different from normal cards.
>> > In Normal cards SQ memory allocated at host side.
>> > In both the cases physical address of CQ memory is programmed in NVMe
>> > controller register.
>> > This method works for normal cards because CQ memory is at host side.
>> > But in CMB cards pci bus address equivalent to CQ memory needs to program.
>> >
>> > More details are in the patch: nvme-pci: Use PCI bus address for
>> > data/queues in CMB.
>> >
>> > With the above patch issue is fixed in the NVMe kernel driver, But
>> > similar fix is required in SPDK library also.
>> > So, We need a mechanism to get pci_bus_address in user space libraries
>> > to address this issue.
>>
>> I don't understand the CQ vs CMB, but I think I gather that there's some
Sorry, It was mistake, I meant SQ not CQ.
>> sort of buffer that's allocated from within the devices MMIO BAR and
>> some programming of the device needs to reference that buffer.
>> Wouldn't you therefore use the vfio type1 IOMMU MAP_DMA ioctl to map
>> the BAR into the IOVA address space and you can then use the IOVA +
>> offset into the BAR for the device to reference the buffer?  It seems
>> this is the same way we'd setup a peer-to-peer mapping, but we're using
>> it for the device to reference itself effectively.  Thanks,
>
> SPDK already does this today. It's capable of placing submission and completion
> queues in the device's controller memory buffer (CMB) and will do all of the
> right things for both uio (look up physical address) and vfio (send
> IOMMU_MAP_DMA ioctl to set a iova and use that). It additionally already
> supports using the CMB as a target for peer-to-peer data transfers.
>
> This was just confirmed to work on the most recent SPDK release. If you are not
> on the most recent release, I recommend trying that first. If there is still
> some issue, please do take it to the SPDK mailing list.
>
We are using SPDK version 18.04.
Is fix available in 18.04? Please point me to the patch with which fix
was added.

> Thanks,
> Ben
