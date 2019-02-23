From: gustavo@embeddedor.com (Gustavo A. R. Silva)
Date: Sat, 23 Feb 2019 14:28:24 -0600
Subject: [PATCH] nvmet-fc: use zero-sized array and struct_size() in
 kzalloc()
In-Reply-To: <a38ddf4132398ca7f1705fa377fb52a2b09a2801.camel@perches.com>
References: <20190223185108.GA6706@embeddedor>
 <a38ddf4132398ca7f1705fa377fb52a2b09a2801.camel@perches.com>
Message-ID: <ed832c4d-2d40-b63e-8708-ad7819875a39@embeddedor.com>

Hey Joe,

On 2/23/19 2:05 PM, Joe Perches wrote:
> On Sat, 2019-02-23@12:51 -0600, Gustavo A. R. Silva wrote:
>> Update the code to use a zero-sized array instead of a pointer in
>> structure nvmet_fc_tgt_queue and use struct_size() in kzalloc().
> []
>> This code was detected with the help of Coccinelle.
> 
> Really?
> Impressive script that found this one.
> 

See my comments below.

>> diff --git a/drivers/nvme/target/fc.c b/drivers/nvme/target/fc.c
> []
>> @@ -128,12 +128,12 @@ struct nvmet_fc_tgt_queue {
>>  	struct nvmet_cq			nvme_cq;
>>  	struct nvmet_sq			nvme_sq;
>>  	struct nvmet_fc_tgt_assoc	*assoc;
>> -	struct nvmet_fc_fcp_iod		*fod;		/* array of fcp_iods */
>>  	struct list_head		fod_list;
>>  	struct list_head		pending_cmd_list;
>>  	struct list_head		avail_defer_list;
>>  	struct workqueue_struct		*work_q;
>>  	struct kref			ref;
>> +	struct nvmet_fc_fcp_iod		fod[];		/* array of fcp_iods */
>>  } __aligned(sizeof(unsigned long long));
> 
> Moving a pointer from the middle of a struct to
> the end seems unusual for coccinelle.
> 
> 

Notice that the commit log says "detected", which does not imply
the script made the transformation by itself. :)

And all the script detected was this piece of code:

	queue = kzalloc((sizeof(*queue) +
				(sizeof(struct nvmet_fc_fcp_iod) * sqsize)),
				GFP_KERNEL);


Thanks
--
Gustavo
