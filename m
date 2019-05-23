From: maxg@mellanox.com (Max Gurtovoy)
Date: Thu, 23 May 2019 14:05:23 +0300
Subject: [PATCH 1/1] nvme-rdma: Add association between ctrl and transport
 dev
In-Reply-To: <20190523102236.GC15492@lst.de>
References: <1558444796-5190-1-git-send-email-maxg@mellanox.com>
 <20190523102236.GC15492@lst.de>
Message-ID: <264c1ab2-a097-3384-381f-2b8c56c4442c@mellanox.com>


On 5/23/2019 1:22 PM, Christoph Hellwig wrote:
>> +static void nvme_rdma_ctrl_dev_put(struct nvme_rdma_ctrl *ctrl,
>> +				   struct nvme_rdma_device *dev)
>> +{
>> +	ctrl->device = 	NULL;
> double whitespace here.
thanks.
>
>> +	kref_put(&dev->ref, nvme_rdma_free_dev);
>> +}
>> +
>> +static void nvme_rdma_ctrl_dev_get(struct nvme_rdma_ctrl *ctrl,
>> +				   struct nvme_rdma_device *dev)
>> +{
>> +	kref_get(&dev->ref);
>> +	ctrl->device = dev;
> Why aren't these using nvme_rdma_dev_put / nvme_rdma_dev_get?

Since we change the ctrl->device pointer here.

Do you prefer doing it without helper ?

>
>>   static void nvme_rdma_destroy_admin_queue(struct nvme_rdma_ctrl *ctrl,
>>   		bool remove)
>>   {
>> +	struct nvme_rdma_device *ndev = ctrl->device;
>> +
>>   	if (remove) {
>>   		blk_cleanup_queue(ctrl->ctrl.admin_q);
>>   		blk_mq_free_tag_set(ctrl->ctrl.admin_tagset);
>> +		/* ctrl releases refcount on device */
>> +		nvme_rdma_ctrl_dev_put(ctrl, ctrl->device);
>>   	}
>>   	if (ctrl->async_event_sqe.data) {
>> -		nvme_rdma_free_qe(ctrl->device->dev, &ctrl->async_event_sqe,
>> +		nvme_rdma_free_qe(ndev->dev, &ctrl->async_event_sqe,
> What guarantees ndev is not freed here?

The admin queue is the last reference for the device (will be freed 
during nvme_rdma_free_queue(&ctrl->queues[0]);)
