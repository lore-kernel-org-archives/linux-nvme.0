From: maxg@mellanox.com (Max Gurtovoy)
Date: Tue, 5 Jun 2018 11:24:11 +0300
Subject: [PATCH v2 1/8] nvme-rdma: use ib_client API to wrap ib_device
In-Reply-To: <20180604213834.GB24926@ziepe.ca>
References: <20180604123003.24748-1-roman.penyaev@profitbricks.com>
 <20180604123003.24748-2-roman.penyaev@profitbricks.com>
 <20180604213834.GB24926@ziepe.ca>
Message-ID: <338eb01d-77dc-a433-8912-30db6e5bcafb@mellanox.com>



On 6/5/2018 12:38 AM, Jason Gunthorpe wrote:
> On Mon, Jun 04, 2018@02:29:56PM +0200, Roman Pen wrote:
>> ib_client API provides a way to wrap an ib_device with a specific ULP
>> structure.  Using that API local lists and mutexes can be completely
>> avoided and allocation/removal paths become a bit cleaner.
>>
>> Signed-off-by: Roman Pen <roman.penyaev at profitbricks.de>
>> Cc: Christoph Hellwig <hch at lst.de>
>> Cc: Steve Wise <swise at opengridcomputing.com>
>> Cc: Bart Van Assche <bart.vanassche at sandisk.com>
>> Cc: Sagi Grimberg <sagi at grimberg.me>
>> Cc: Doug Ledford <dledford at redhat.com>
>> Cc: linux-nvme at lists.infradead.org
>>   drivers/nvme/host/rdma.c | 82 ++++++++++++++++++++++--------------------------
>>   1 file changed, 38 insertions(+), 44 deletions(-)
>>
>> diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
>> index 1eb4438a8763..dd79250c9df4 100644
>> +++ b/drivers/nvme/host/rdma.c
>> @@ -46,7 +46,6 @@ struct nvme_rdma_device {
>>   	struct ib_device	*dev;
>>   	struct ib_pd		*pd;
>>   	struct kref		ref;
>> -	struct list_head	entry;
>>   };
>>   
>>   struct nvme_rdma_qe {
>> @@ -124,9 +123,7 @@ static inline struct nvme_rdma_ctrl *to_rdma_ctrl(struct nvme_ctrl *ctrl)
>>   	return container_of(ctrl, struct nvme_rdma_ctrl, ctrl);
>>   }
>>   
>> -static LIST_HEAD(device_list);
>> -static DEFINE_MUTEX(device_list_mutex);
>> -
>> +static struct ib_client nvme_rdma_ib_client;
>>   static LIST_HEAD(nvme_rdma_ctrl_list);
>>   static DEFINE_MUTEX(nvme_rdma_ctrl_mutex);
>>   
>> @@ -325,17 +322,14 @@ static void nvme_rdma_free_dev(struct kref *ref)
>>   	struct nvme_rdma_device *ndev =
>>   		container_of(ref, struct nvme_rdma_device, ref);
>>   
>> -	mutex_lock(&device_list_mutex);
>> -	list_del(&ndev->entry);
>> -	mutex_unlock(&device_list_mutex);
>> -
>> +	ib_set_client_data(ndev->dev, &nvme_rdma_ib_client, NULL);
>>   	ib_dealloc_pd(ndev->pd);
>>   	kfree(ndev);
>>   }
>>   
>> -static void nvme_rdma_dev_put(struct nvme_rdma_device *dev)
>> +static int nvme_rdma_dev_put(struct nvme_rdma_device *dev)
>>   {
>> -	kref_put(&dev->ref, nvme_rdma_free_dev);
>> +	return kref_put(&dev->ref, nvme_rdma_free_dev);
>>   }
>>   
>>   static int nvme_rdma_dev_get(struct nvme_rdma_device *dev)
>> @@ -348,43 +342,42 @@ nvme_rdma_find_get_device(struct rdma_cm_id *cm_id)
>>   {
>>   	struct nvme_rdma_device *ndev;
>>   
>> -	mutex_lock(&device_list_mutex);
>> -	list_for_each_entry(ndev, &device_list, entry) {
>> -		if (ndev->dev->node_guid == cm_id->device->node_guid &&
>> -		    nvme_rdma_dev_get(ndev))
>> -			goto out_unlock;
>> +	ndev = ib_get_client_data(cm_id->device, &nvme_rdma_ib_client);
>> +	if (ndev && WARN_ON(!nvme_rdma_dev_get(ndev)))
>> +		ndev = NULL;
> 
> I think this is a much better idea to use the client data than
> maintaining an internal list - this is what client data was for..
> 
> But I wonder if the allocation of the client data should be deferred
> until the ulp actually needs to use the device?

I agree with Jason here. You will create ndev for every ib_device and 
this is redundant.

Also, any reason you use likely/unlikely statements not in the fast path ?

Max

> 
> Jason
> --
> To unsubscribe from this list: send the line "unsubscribe linux-rdma" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
