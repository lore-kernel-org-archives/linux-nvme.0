From: hch@lst.de (Christoph Hellwig)
Date: Wed, 5 Jul 2017 21:08:11 +0200
Subject: [PATCH] nvme-rdma: stop keep_alive before nvme_uninit_ctrl
In-Reply-To: <9a40f029-9bd2-645a-d092-0656f279d94c@grimberg.me>
References: <1498746799-34110-1-git-send-email-dmilburn@redhat.com>
 <ccbe95fe-0711-52a6-4fec-22c2c05bc3ef@grimberg.me>
 <20170705174108.GE5417@lst.de>
 <9a40f029-9bd2-645a-d092-0656f279d94c@grimberg.me>
Message-ID: <20170705190811.GA7191@lst.de>

On Wed, Jul 05, 2017@10:04:31PM +0300, Sagi Grimberg wrote:
>>> +void nvme_stop_ctrl(struct nvme_ctrl *ctrl)
>>> +{
>>> +       __nvme_stop_ctrl(ctrl);
>>>          nvme_remove_namespaces(ctrl);
>>> +}
>>> +EXPORT_SYMBOL_GPL(nvme_stop_ctrl);
>>
>> And then this becomes nvme_remove_ctrl?
>
> Not a good idea as its not actually removing the controller...
>
> Maybe nvme_clear_ctrl?

Or just call both the new nvme_stop_ctrl and nvme_remove_namespaces
from each driver.  It's a bit more code, but additional logic..
