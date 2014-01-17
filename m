From: keith.busch@intel.com (Keith Busch)
Date: Fri, 17 Jan 2014 15:01:10 -0700 (MST)
Subject: [PATCH v2 5/9] nvme: Fix invalid call to irq_set_affinity_hint()
In-Reply-To: <CAErSpo4g_xm4vZWZDgyjtJu+z5ARSerQLrtJ6W_peXv4bKwcgg@mail.gmail.com>
References: <cover.1389904166.git.agordeev@redhat.com>
 <1c441f670f33375b6c41e074baf6e84e6c7bb0c2.1389904166.git.agordeev@redhat.com>
 <CAErSpo4g_xm4vZWZDgyjtJu+z5ARSerQLrtJ6W_peXv4bKwcgg@mail.gmail.com>
Message-ID: <alpine.LRH.2.03.1401171419370.25844@AMR>

On Fri, 17 Jan 2014, Bjorn Helgaas wrote:

> On Fri, Jan 17, 2014@9:02 AM, Alexander Gordeev <agordeev@redhat.com> wrote:
>> In case MSI-X and MSI initialization failed the function
>> irq_set_affinity_hint() is called with uninitialized value
>> in dev->entry[0].vector. This update fixes the issue.
>
> dev->entry[0].vector is initialized in nvme_dev_map(), and it's used
> for free_irq() above the area of your patch, so I don't think this is
> actually a bug, though it might be somewhat confusing.

It is confusing, but there's a reason. :)

We send a single command using legacy irq to discover how many msix
vectors we want. The legacy entry needs to be set some time before calling
request_irq in nvme_configure_admin_queue, but also within nvme_dev_start
(for power-management). I don't think there's a place to set it that
won't look odd when looking at nvme_setup_io_queues. I settled on
'nvme_dev_map' was because 'nvme_dev_unmap' invalidates the entries,
so this seemed to provide some amount of symmetry.

>> Signed-off-by: Alexander Gordeev <agordeev at redhat.com>
>> ---
>>  drivers/block/nvme-core.c |   12 ++++++------
>>  1 files changed, 6 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c
>> index 26d03fa..e292450 100644
>> --- a/drivers/block/nvme-core.c
>> +++ b/drivers/block/nvme-core.c
>> @@ -1790,15 +1790,15 @@ static int nvme_setup_io_queues(struct nvme_dev *dev)
>>                         vecs = 32;
>>                 for (;;) {
>>                         result = pci_enable_msi_block(pdev, vecs);
>> -                       if (result == 0) {
>> -                               for (i = 0; i < vecs; i++)
>> -                                       dev->entry[i].vector = i + pdev->irq;
>> -                               break;
>> +                       if (result > 0) {
>> +                               vecs = result;
>> +                               continue;
>>                         } else if (result < 0) {
>>                                 vecs = 1;
>> -                               break;
>>                         }
>> -                       vecs = result;
>> +                       for (i = 0; i < vecs; i++)
>> +                               dev->entry[i].vector = i + pdev->irq;
>> +                       break;
>>                 }
>>         }
