From: mundu2510@gmail.com (mundu agarwal)
Date: Tue, 22 Jul 2014 23:27:17 +0530
Subject: [PATCH 1/1] If device hotplug out, controller status become
 0xFFFF_FFFF 1. Controller fatal status become true in nvme_kthread() 2. Ready
 bit will not be reset to 0 in nvme_wait_ready() for controller disable above
 two scenarios controller status data is not a valid data, since
 device/controller is already removed (hotplug)
In-Reply-To: <alpine.LRH.2.03.1407221129110.4703@AMR>
References: <1406049939-29310-1-git-send-email-mundu2510@gmail.com>
 <1406049939-29310-2-git-send-email-mundu2510@gmail.com>
 <alpine.LRH.2.03.1407221129110.4703@AMR>
Message-ID: <CACuVHZneftmar+v5mUF-ufAYtt=vNhCrVGozJWpswwwHNcR-rA@mail.gmail.com>

>> In nvme_dev_map, we already return -ENODEV if reading CSTS returns
>> -1. That happens before we call nvme_wait_ready. Are you just shorting
>> the probe in the event someone hot removes a drive the moment after the
>> driver ioremaps the BAR, but before it enables the device?

Yes

On Tue, Jul 22, 2014@11:10 PM, Keith Busch <keith.busch@intel.com> wrote:
> On Tue, 22 Jul 2014, Mundu wrote:
>>
>> Signed-off-by: Mundu <mundu2510 at gmail.com>
>> ---
>> drivers/block/nvme-core.c | 13 +++++++++++--
>> 1 file changed, 11 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c
>> index 28aec2d..6c6998e 100644
>> --- a/drivers/block/nvme-core.c
>> +++ b/drivers/block/nvme-core.c
>> @@ -1396,10 +1396,14 @@ static int nvme_wait_ready(struct nvme_dev *dev,
>> u64 cap, bool enabled)
>> {
>>         unsigned long timeout;
>>         u32 bit = enabled ? NVME_CSTS_RDY : 0;
>> +       u32 csts;
>>
>>         timeout = ((NVME_CAP_TIMEOUT(cap) + 1) * HZ / 2) + jiffies;
>>
>> -       while ((readl(&dev->bar->csts) & NVME_CSTS_RDY) != bit) {
>> +       while (((csts = readl(&dev->bar->csts)) & NVME_CSTS_RDY) != bit) {
>> +               /* If device is hot plugout, csts become 0xFFFFFFFF */
>> +               if (csts == -1)
>> +                       return -ENODEV;
>
>
> In nvme_dev_map, we already return -ENODEV if reading CSTS returns
> -1. That happens before we call nvme_wait_ready. Are you just shorting
> the probe in the event someone hot removes a drive the moment after the
> driver ioremaps the BAR, but before it enables the device?
>
>
>>                 msleep(100);
>>                 if (fatal_signal_pending(current))
>>                         return -EINTR;
>> @@ -1905,14 +1909,19 @@ static int nvme_submit_async_req(struct nvme_queue
>> *nvmeq)
>> static int nvme_kthread(void *data)
>> {
>>         struct nvme_dev *dev, *next;
>> +       u32 csts;
>>
>>         while (!kthread_should_stop()) {
>>                 set_current_state(TASK_INTERRUPTIBLE);
>>                 spin_lock(&dev_list_lock);
>>                 list_for_each_entry_safe(dev, next, &dev_list, node) {
>>                         int i;
>> -                       if (readl(&dev->bar->csts) & NVME_CSTS_CFS &&
>> +                       if ((csts = readl(&dev->bar->csts)) &
>> NVME_CSTS_CFS &&
>>                                                         dev->initialized)
>> {
>> +                               /* If device is hot plugout,
>> +                                  csts become 0xFFFFFFFF */
>> +                               if (csts == -1)
>> +                                       continue;
>
>
> You definitely want to let the reset work get scheduled here instead of
> continuing. Some platforms do not support "surprise removal", so this
> check guards against that by triggering a reset which will bail on the
> device if it appears gone and remove it from pci.
>
>
>>                                 if (work_busy(&dev->reset_work))
>>                                         continue;
>>                                 list_del_init(&dev->node);
