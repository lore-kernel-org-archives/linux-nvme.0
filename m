From: ravi.android@gmail.com (Ravi Kumar)
Date: Tue, 31 Dec 2013 14:18:52 +0530
Subject: [PATCH RFC 2/5] NVMe: Basic NVMe device hotplug support
In-Reply-To: <alpine.LRH.2.03.1312300946520.4958@AMR>
References: <1388399240-13828-1-git-send-email-santoshsy@gmail.com>
 <1388399240-13828-3-git-send-email-santoshsy@gmail.com>
 <alpine.LRH.2.03.1312300946520.4958@AMR>
Message-ID: <CAHgZpFCLTqf_MVrqSRVufRH_V9DXgnamkLXcwh9BenJoAsUF8w@mail.gmail.com>

 Keith,

>> When a NVMe device is surprise removed and inserted back the
>> device may need some time to respond to host IO commands, and
>> will return NVME_SC_NS_NOT_READY. In this case the requests
>> will be requeued until the device responds to the IO commands
>> with status response or until the commands timeout.


> Does your device violate the spec? The driver can't send IO commands
> until the controller sets CSTS.RDY to 1, and the controller should not
> do that until it is ready to handle host commands.

Does spec mandate that CSTS.RDY should be set after Namespace ready. I can
see the case where as device have multiple Namespaces and out of many few
are ready for processing the commands rests are not ready. Don't we have to
handle the same.

I have checked the spec CSTS.RDY can be set by device without Namespace ready.

Regards,
Ravi

On Mon, Dec 30, 2013@10:51 PM, Keith Busch <keith.busch@intel.com> wrote:
> On Mon, 30 Dec 2013, Santosh Y wrote:
>>
>> This patch provides basic hotplug support for NVMe.
>> For NVMe hotplug to work the PCIe slot must be hotplug capable.
>
>
> I think the current code should handle hot-plug events just fine. I
> would be very interested to know what you're doing that breaks this if
> it is not working for you.
>
>
>> When a NVMe device is surprise removed and inserted back the
>> device may need some time to respond to host IO commands, and
>> will return NVME_SC_NS_NOT_READY. In this case the requests
>> will be requeued until the device responds to the IO commands
>> with status response or until the commands timeout.
>>
>
> Does your device violate the spec? The driver can't send IO commands
> until the controller sets CSTS.RDY to 1, and the controller should not
> do that until it is ready to handle host commands.
>
>
>> Signed-off-by: Ravi Kumar <ravi.android at gmail.com>
>> Signed-off-by: Santosh Y <santoshsy at gmail.com>
>>
>> diff --git a/drivers/block/Kconfig b/drivers/block/Kconfig
>> index 86b9f37..f92ec96 100644
>> --- a/drivers/block/Kconfig
>> +++ b/drivers/block/Kconfig
>
>
> [snip]
>
>
>> static void nvme_make_request(struct request_queue *q, struct bio *bio)
>> {
>> -       struct nvme_ns *ns = q->queuedata;
>> -       struct nvme_queue *nvmeq = get_nvmeq(ns->dev);
>> +       struct nvme_ns *ns = NULL;
>> +       struct nvme_queue *nvmeq = NULL;
>>         int result = -EBUSY;
>>
>> +       if (likely(q && q->queuedata))
>> +               ns = q->queuedata;
>> +       if (unlikely(!ns)) {
>> +               bio_endio(bio, -ENODEV);
>> +               return;
>> +       }
>> +
>> +#ifdef CONFIG_BLK_DEV_NVME_HP
>> +       if (test_bit(NVME_HOT_REM, &ns->dev->hp_flag) ||
>> +               !(bio->bi_bdev->bd_disk->flags & GENHD_FL_UP)) {
>> +               bio_endio(bio, -ENODEV);
>
>
> I don't know if ENODEV is a valid error here. You can't get here unless
> the device has already been opened, and it cann't be opened if the device
> does not exist, so I think this is an incorrect errno to use. Maybe ENXIO?
>
> But why is this check even necessary? Let's say the device has been
> hot-removed. If the platform is truely capable of handling such
> events, the pci layer will call the driver's 'remove', and it will suspend
> all the queues, then cancel everything. New IO submitted at this point
> will get put on the bio_list and be failed shortly after.
>
> If you're platform is not capable of pcie hot-plug events, the kthread
> reset handler will pick up on this since the CSTS.CFS bit will be set
> and the device will be queued for reset, which will fail and trigger a
> forced device removal. From there, it will look the same to the driver
> as if it was called from the pci layer.
>
>
>> +               return;
>> +       }
>> +#endif
>> +       nvmeq = get_nvmeq(ns->dev);
>> +
>>         if (!nvmeq) {
>>                 put_nvmeq(NULL);
>>                 bio_endio(bio, -EIO);
>> @@ -1120,6 +1169,12 @@ static void nvme_cancel_ios(struct nvme_queue
>> *nvmeq, bool timeout)
>>                         .status = cpu_to_le16(NVME_SC_ABORT_REQ << 1),
>>                 };
>>
>> +#ifdef CONFIG_BLK_DEV_NVME_HP
>> +               if (test_bit(NVME_HOT_REM, &nvmeq->dev->hp_flag)) {
>> +                       cqe.status |= (NVME_SC_INVALID_NS << 1);
>> +                       info[cmdid].timeout = jiffies - NVME_IO_TIMEOUT;
>> +               }
>> +#endif
>
>
> If the device is hot removed, the existing code will force cancel all
> IOs, so this doesn't seem necessary. Also, OR'ing in invalid namespace
> on top of abort status wouldn't be right.
>
>
>>                 if (timeout && !time_after(now, info[cmdid].timeout))
>>                         continue;
>>                 if (info[cmdid].ctx == CMD_CTX_CANCELLED)
>> @@ -1205,7 +1260,7 @@ static void nvme_disable_queue(struct nvme_dev *dev,
>> int qid)
>>
>>         /* Don't tell the adapter to delete the admin queue.
>>          * Don't tell a removed adapter to delete IO queues. */
>> -       if (qid && readl(&dev->bar->csts) != -1) {
>> +       if (qid && !nvme_check_surprise_removal(dev)) {
>>                 adapter_delete_sq(dev, qid);
>>                 adapter_delete_cq(dev, qid);
>>         }
>> @@ -1724,6 +1779,13 @@ static void nvme_resubmit_bios(struct nvme_queue
>> *nvmeq)
>>                 struct bio *bio = bio_list_pop(&nvmeq->sq_cong);
>>                 struct nvme_ns *ns = bio->bi_bdev->bd_disk->private_data;
>>
>> +#ifdef CONFIG_BLK_DEV_NVME_HP
>> +               if (test_bit(NVME_HOT_REM, &ns->dev->hp_flag) ||
>> +                       !(bio->bi_bdev->bd_disk->flags & GENHD_FL_UP)) {
>> +                       bio_endio(bio, -ENODEV);
>> +                       continue;
>> +               }
>> +#endif
>
>
> If your device is hot removed, it won't be in the nvme dev_list so it
> can't be polled to resubmit bio's, right?
>
> GENHD_FL_UP won't be unset either until we call del_gendisk, and that
> doesn't happen while the device is polled, so this would be dead code.
>
> ... but ...
>
>
>> @@ -2556,6 +2625,16 @@ static void nvme_remove(struct pci_dev *pdev)
>> {
>>         struct nvme_dev *dev = pci_get_drvdata(pdev);
>>
>> +#ifdef CONFIG_BLK_DEV_NVME_HP
>> +       if (!pdev || !dev)
>> +               return;
>> +       if (nvme_check_surprise_removal(dev)) {
>> +               set_bit(NVME_HOT_REM, &dev->hp_flag);
>> +               dev_info(&pdev->dev,
>> +                       "Surprise removal of device 0x%x\n",
>> pdev->device);
>> +       }
>> +       pci_dev_get(pdev);
>> +#endif
>
>
> Aha! The above wouldn't be necessary if you didn't remove the list_del
> operation from your previous patch.
>
>
>>         pci_set_drvdata(pdev, NULL);
>>         flush_work(&dev->reset_work);
>>         misc_deregister(&dev->miscdev);
>> @@ -2565,6 +2644,9 @@ static void nvme_remove(struct pci_dev *pdev)
>>         nvme_release_instance(dev);
>>         nvme_release_prp_pools(dev);
>>         kref_put(&dev->kref, nvme_free_dev);
>> +#ifdef CONFIG_BLK_DEV_NVME_HP
>> +       pci_dev_put(pdev);
>> +#endif
>> }
