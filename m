From: maxg@mellanox.com (Max Gurtovoy)
Date: Fri, 24 May 2019 22:30:50 +0300
Subject: [PATCH 1/1] nvme-rdma: Add association between ctrl and transport
 dev
In-Reply-To: <da6603ee-4a71-e057-5c88-656455956eba@grimberg.me>
References: <1558444796-5190-1-git-send-email-maxg@mellanox.com>
 <da6603ee-4a71-e057-5c88-656455956eba@grimberg.me>
Message-ID: <ceb1744a-cc68-9588-bd07-d3060630e857@mellanox.com>


On 5/24/2019 10:05 AM, Sagi Grimberg wrote:
>
>> @@ -758,23 +777,26 @@ static void 
>> nvme_rdma_destroy_admin_queue(struct nvme_rdma_ctrl *ctrl,
>> ? static int nvme_rdma_configure_admin_queue(struct nvme_rdma_ctrl 
>> *ctrl,
>> ????????? bool new)
>> ? {
>> +??? struct ib_device *ibdev;
>> ????? int error;
>> ? ????? error = nvme_rdma_alloc_queue(ctrl, 0, NVME_AQ_DEPTH);
>> ????? if (error)
>> ????????? return error;
>> ? -??? ctrl->device = ctrl->queues[0].device;
>> -??? ctrl->ctrl.numa_node = dev_to_node(ctrl->device->dev->dma_device);
>> +??? ibdev = ctrl->queues[0].device->dev;
>> +??? ctrl->ctrl.numa_node = dev_to_node(ibdev->dma_device);
>> +??? ctrl->max_fr_pages = nvme_rdma_get_max_fr_pages(ibdev);
>> ? -??? ctrl->max_fr_pages = 
>> nvme_rdma_get_max_fr_pages(ctrl->device->dev);
>> -
>> -??? error = nvme_rdma_alloc_qe(ctrl->device->dev, 
>> &ctrl->async_event_sqe,
>> +??? error = nvme_rdma_alloc_qe(ibdev, &ctrl->async_event_sqe,
>> ????????????? sizeof(struct nvme_command), DMA_TO_DEVICE);
>> ????? if (error)
>> ????????? goto out_free_queue;
>> ? ????? if (new) {
>> +??????? /* ctrl takes refcount on device */
>> +??????? nvme_rdma_ctrl_dev_get(ctrl, ctrl->queues[0].device);
>> +
>
> Do you actually need the extra reference on the device? why doesn't just
> the set/clear of ctrl->device sufficient? these routines should be
> serialized..

Yes we need this reference since the queues are freed during 
reconnection. And without ctrl reference, also the device will be freed.

And when you disconnect during reconnection, the block layer will call 
exit_request for each request (but the device is freed) and we will do 
the need unmapping from the device..

Not so plesent..
