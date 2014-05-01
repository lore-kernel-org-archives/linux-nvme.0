From: bhelgaas@google.com (Bjorn Helgaas)
Date: Thu, 1 May 2014 14:10:40 -0600
Subject: [PATCH 1/2] PCI: Device driver function reset notification
In-Reply-To: <alpine.LRH.2.03.1405011344330.5666@AMR>
References: <1397000541-1085-1-git-send-email-keith.busch@intel.com>
 <20140430224637.GA31315@google.com> <alpine.LRH.2.03.1405011344330.5666@AMR>
Message-ID: <CAErSpo7R9BZtJpb3ekR=8D+tkWR9tPzsT0YLY5YS-hOGQJuxQA@mail.gmail.com>

On Thu, May 1, 2014@1:57 PM, Keith Busch <keith.busch@intel.com> wrote:
> On Wed, 30 Apr 2014, Bjorn Helgaas wrote:
>>
>> On Tue, Apr 08, 2014@05:42:20PM -0600, Keith Busch wrote:
>> You put the notify in these functions:
>>
>>  pci_reset_function()
>>  pci_try_reset_function()
>>
>> but what about these:
>>
>>  pci_reset_slot()
>>  pci_try_reset_slot()
>>  pci_reset_bus()
>>  pci_try_reset_bus()
>
>
> Good point. These all call pci_dev_save_and_disable at the start and
> pci_dev_restore after, so I think just adding the reset prepare/complete
> to those functions should cover all scenarios. Does this sound ok?

Sound OK to me, as long as the save/restore functions aren't used elsewhere.
