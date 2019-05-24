From: maxg@mellanox.com (Max Gurtovoy)
Date: Fri, 24 May 2019 22:36:31 +0300
Subject: [PATCH 1/1] nvme-rdma: Add association between ctrl and transport
 dev
In-Reply-To: <20190523153323.GA21083@lst.de>
References: <1558444796-5190-1-git-send-email-maxg@mellanox.com>
 <20190523102236.GC15492@lst.de>
 <264c1ab2-a097-3384-381f-2b8c56c4442c@mellanox.com>
 <20190523153323.GA21083@lst.de>
Message-ID: <d5568362-3589-6670-dd83-56502757fe87@mellanox.com>


On 5/23/2019 6:33 PM, Christoph Hellwig wrote:
> On Thu, May 23, 2019@02:05:23PM +0300, Max Gurtovoy wrote:
>> On 5/23/2019 1:22 PM, Christoph Hellwig wrote:
>>>> +static void nvme_rdma_ctrl_dev_put(struct nvme_rdma_ctrl *ctrl,
>>>> +				   struct nvme_rdma_device *dev)
>>>> +{
>>>> +	ctrl->device = 	NULL;
>>> double whitespace here.
>> thanks.
>>>> +	kref_put(&dev->ref, nvme_rdma_free_dev);
>>>> +}
>>>> +
>>>> +static void nvme_rdma_ctrl_dev_get(struct nvme_rdma_ctrl *ctrl,
>>>> +				   struct nvme_rdma_device *dev)
>>>> +{
>>>> +	kref_get(&dev->ref);
>>>> +	ctrl->device = dev;
>>> Why aren't these using nvme_rdma_dev_put / nvme_rdma_dev_get?
>> Since we change the ctrl->device pointer here.
>>
>> Do you prefer doing it without helper ?
> We can still use the helper underneath instead of open coding the kref
> calls, right?

since nvme_rdma_ctrl_dev_get is void function I preferred calling void 
function kref_get instead of the non-void nvme_rdma_dev_get.
