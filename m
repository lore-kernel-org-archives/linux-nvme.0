From: hch@lst.de (Christoph Hellwig)
Date: Sun, 18 Jun 2017 15:12:30 +0200
Subject: [PATCH 3/3] nvme-pci: open-code polling logic in nvme_poll
In-Reply-To: <8d592838-8681-16bf-a561-8c5feee08efa@grimberg.me>
References: <1497548508-29447-1-git-send-email-sagi@grimberg.me>
 <1497548508-29447-4-git-send-email-sagi@grimberg.me>
 <20170616070548.GC7672@lst.de>
 <8d592838-8681-16bf-a561-8c5feee08efa@grimberg.me>
Message-ID: <20170618131229.GA32384@lst.de>

On Sun, Jun 18, 2017@12:29:33PM +0300, Sagi Grimberg wrote:
>
>>>   static int __nvme_poll(struct nvme_queue *nvmeq, unsigned int tag)
>>>   {
>>> +	struct nvme_completion cqe;
>>> +	int found = 0, consumed = 0;
>>
>> found should be a bool.
>
> I'm returning found back from ->poll() callout so
> I think I'll keep it int, unless you want me to modify
> poll_fn signature?

Let's keep it as-is for now.
