From: mb@lightnvm.io (=?UTF-8?Q?Matias_Bj=c3=b8rling?=)
Date: Thu, 15 Feb 2018 09:57:39 +0100
Subject: [PATCH V2 4/4] nvme: lightnvm: add late setup of block size and
 metadata
In-Reply-To: <098A1343-A9FB-47BD-A4B5-6E77A1861A4B@cnexlabs.com>
References: <20180209092719.10679-1-mb@lightnvm.io>
 <20180209092719.10679-5-mb@lightnvm.io>
 <098A1343-A9FB-47BD-A4B5-6E77A1861A4B@cnexlabs.com>
Message-ID: <e4b51c0b-35da-705e-b723-2f568fee69a7@lightnvm.io>

On 02/12/2018 09:21 PM, Javier Gonzalez wrote:
> 
>> On 9 Feb 2018,@01.27, Matias Bj?rling <mb@lightnvm.io> wrote:
>>
>> The nvme driver sets up the size of the nvme namespace in two steps.
>> First it initializes the device with standard logical block and
>> metadata sizes, and then sets the correct logical block and metadata
>> size. Due to the OCSSD 2.0 specification relies on the namespace to
>> expose these sizes for correct initialization, let it be updated
>> appropriately on the LightNVM side as well.
>>
>> Signed-off-by: Matias Bj?rling <mb at lightnvm.io>
>> ---
>>
> 
> This late initialization breaks ligthnvm's core init since the sector
> size (csecs) is used on the first init part to set the logical block size.
> 
> nvm_core_init -> blk_queue_logical_block_size(dev->q, dev_geo->c.csecs);
> 
> We can do do a nvme_nvm_revalidate and set this on the revalidation path
> instead of simply updating the info as in nvme_nvm_update_nvm_info().'

I believe that is what the patch does (nvme_nvm_update_nvm_info is 
called from the nvme_revalidate_disk context).

The nvm_core_init initialization of the block size is redundant and 
should be removed. I'll update the patch.
