From: m@bjorling.me (Matias Bjorling)
Date: Mon, 16 Jun 2014 18:49:43 +0200
Subject: [PATCH v8] NVMe: convert to blk-mq
In-Reply-To: <alpine.LRH.2.03.1406160931400.4699@AMR>
References: <1402661396-19207-1-git-send-email-m@bjorling.me>
 <1402661396-19207-2-git-send-email-m@bjorling.me>
 <alpine.LRH.2.03.1406160931400.4699@AMR>
Message-ID: <539F2027.1060805@bjorling.me>

Den 16-06-2014 17:57, Keith Busch skrev:
> On Fri, 13 Jun 2014, Matias Bj?rling wrote:
>> This converts the current NVMe driver to utilize the blk-mq layer.
>
>> static void nvme_reset_notify(struct pci_dev *pdev, bool prepare)
>> {
>> -       struct nvme_dev *dev = pci_get_drvdata(pdev);
>> +    struct nvme_dev *dev = pci_get_drvdata(pdev);
>>
>> -       if (prepare)
>> -               nvme_dev_shutdown(dev);
>> -       else
>> -               nvme_dev_resume(dev);
>> +    spin_lock(&dev_list_lock);
>> +    if (prepare)
>> +        list_del_init(&dev->node);
>> +    else
>> +        list_add(&dev->node, &dev_list);
>> +    spin_unlock(&dev_list_lock);
>> }
>> +        if (nvme_create_queue(dev->queues[i], i))
>>             break;
>> }
>
> The above change was just error injection test code so you can cause
> a device to become unresponsive and trigger the timeout handling.

Thanks, I'll take it off

>
> This latest is otherwise stable on my dev machine.

I'm very happy to hear!
