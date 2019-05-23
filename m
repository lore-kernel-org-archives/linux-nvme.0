From: hch@lst.de (Christoph Hellwig)
Date: Thu, 23 May 2019 17:33:23 +0200
Subject: [PATCH 1/1] nvme-rdma: Add association between ctrl and
 transport dev
In-Reply-To: <264c1ab2-a097-3384-381f-2b8c56c4442c@mellanox.com>
References: <1558444796-5190-1-git-send-email-maxg@mellanox.com>
 <20190523102236.GC15492@lst.de>
 <264c1ab2-a097-3384-381f-2b8c56c4442c@mellanox.com>
Message-ID: <20190523153323.GA21083@lst.de>

On Thu, May 23, 2019@02:05:23PM +0300, Max Gurtovoy wrote:
>
> On 5/23/2019 1:22 PM, Christoph Hellwig wrote:
>>> +static void nvme_rdma_ctrl_dev_put(struct nvme_rdma_ctrl *ctrl,
>>> +				   struct nvme_rdma_device *dev)
>>> +{
>>> +	ctrl->device = 	NULL;
>> double whitespace here.
> thanks.
>>
>>> +	kref_put(&dev->ref, nvme_rdma_free_dev);
>>> +}
>>> +
>>> +static void nvme_rdma_ctrl_dev_get(struct nvme_rdma_ctrl *ctrl,
>>> +				   struct nvme_rdma_device *dev)
>>> +{
>>> +	kref_get(&dev->ref);
>>> +	ctrl->device = dev;
>> Why aren't these using nvme_rdma_dev_put / nvme_rdma_dev_get?
>
> Since we change the ctrl->device pointer here.
>
> Do you prefer doing it without helper ?

We can still use the helper underneath instead of open coding the kref
calls, right?
