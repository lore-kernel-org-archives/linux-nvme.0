From: shan.hai@oracle.com (Shan Hai)
Date: Thu, 27 Dec 2018 09:53:44 +0800
Subject: [PATCH v2 2/2] nvme-pci: take the io_queue_number into account
 when setting number of io queues
In-Reply-To: <20181226103147.GC32113@ming.t460p>
References: <1545624739-9848-1-git-send-email-shan.hai@oracle.com>
 <1545624739-9848-2-git-send-email-shan.hai@oracle.com>
 <20181226103147.GC32113@ming.t460p>
Message-ID: <87f86167-d1c0-2fe5-5336-75ce0cd80f2b@oracle.com>



On 2018/12/26 ??6:31, Ming Lei wrote:
> On Mon, Dec 24, 2018@12:12:19PM +0800, Shan Hai wrote:
>> Add a wrapper around num_possible_cpus() to take the new added module
>> parameter account when setting number of io queues.
>>
>> Signed-off-by: Shan Hai <shan.hai at oracle.com>
>> ---
>>   drivers/nvme/host/pci.c | 11 ++++++++---
>>   1 file changed, 8 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
>> index 0d60451..e359e90 100644
>> --- a/drivers/nvme/host/pci.c
>> +++ b/drivers/nvme/host/pci.c
>> @@ -219,6 +219,11 @@ struct nvme_iod {
>>   	struct scatterlist inline_sg[0];
>>   };
>>   
>> +static inline unsigned int nvme_io_queue_number(void)
>> +{
>> +	return min_t(unsigned int, io_queue_number, num_possible_cpus());
>> +}
>> +
>>   /*
>>    * Check we didin't inadvertently grow the command struct
>>    */
>> @@ -241,7 +246,7 @@ static inline void _nvme_check_size(void)
>>   
>>   static inline unsigned int nvme_dbbuf_size(u32 stride)
>>   {
>> -	return ((num_possible_cpus() + 1) * 8 * stride);
>> +	return ((nvme_io_queue_number() + 1) * 8 * stride);
>>   }
>>   
>>   static int nvme_dbbuf_dma_alloc(struct nvme_dev *dev)
>> @@ -1923,7 +1928,7 @@ static int nvme_setup_io_queues(struct nvme_dev *dev)
>>   		.pre_vectors = 1
>>   	};
>>   
>> -	nr_io_queues = num_possible_cpus();
>> +	nr_io_queues = nvme_io_queue_number();
>>   	result = nvme_set_queue_count(&dev->ctrl, &nr_io_queues);
>>   	if (result < 0)
>>   		return result;
>> @@ -2512,7 +2517,7 @@ static int nvme_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>>   	if (!dev)
>>   		return -ENOMEM;
>>   
>> -	dev->queues = kcalloc_node(num_possible_cpus() + 1,
>> +	dev->queues = kcalloc_node(nvme_io_queue_number() + 1,
>>   			sizeof(struct nvme_queue), GFP_KERNEL, node);
>>   	if (!dev->queues)
>>   		goto free;
>> -- 
>> 2.7.4
> 
> You need to make the patch against block/for-4.21, or the latest linus
> tree after Linus pulls in block/for-4.21, so far not done yet.
> 
> Especially max_queue_count() and max_io_queues() are introduced, and
> looks you just need to change max_io_queues().
> 
> So please fold the two into one patch, and the shape may be something
> like the following:
> 

Hi Ming,

Would you please go ahead and finish it? Please add me as Reported-by,
I am just fine with it, thanks for the review.

Thanks
Shan Hai

> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index d839bbe408c3..a2d1da6ca6c0 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -81,6 +81,12 @@ static const struct kernel_param_ops queue_count_ops = {
>   	.get = param_get_int,
>   };
>   
> +static int default_queues;
> +module_param_cb(default_queues, &queue_count_ops, &default_queues, 0644);
> +MODULE_PARM_DESC(default_queues,
> +	"Number of queues to use DEFAULT queue type. If not set, "
> +	"num_possible_cpus() will be used.");
> +
>   static int write_queues;
>   module_param_cb(write_queues, &queue_count_ops, &write_queues, 0644);
>   MODULE_PARM_DESC(write_queues,
> @@ -254,7 +260,9 @@ static inline void _nvme_check_size(void)
>   
>   static unsigned int max_io_queues(void)
>   {
> -	return num_possible_cpus() + write_queues + poll_queues;
> +	int def_io_queues = default_queues ?: num_possible_cpus();
> +
> +	return def_io_queues + write_queues + poll_queues;
>   }
>   
>   static unsigned int max_queue_count(void)
> 
> Thanks,
> Ming
> 
> _______________________________________________
> Linux-nvme mailing list
> Linux-nvme at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-nvme
> 
