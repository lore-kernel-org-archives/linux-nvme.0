From: daniel.verkamp@intel.com (Daniel Verkamp)
Date: Tue, 29 May 2018 13:44:49 -0700
Subject: [PATCH 08/14] nvmet: implement the changed namespaces log
In-Reply-To: <20180529172458.GB1022@lst.de>
References: <20180526102735.31404-1-hch@lst.de>
 <20180526102735.31404-9-hch@lst.de>
 <A5F28D4A728A7E41839CDC5C3B5A01E8B74D2527@FMSMSX103.amr.corp.intel.com>
 <20180529172458.GB1022@lst.de>
Message-ID: <d8a81244-c6dc-5f25-6cb9-3e727b481a7b@intel.com>

On 05/29/2018 10:24 AM, Christoph Hellwig wrote:
> On Tue, May 29, 2018@04:59:05PM +0000, Verkamp, Daniel wrote:
>>> +	} else if (ctrl->nr_changed_ns == NVME_MAX_CHANGED_NAMESPACES) {
>>> +		ctrl->changed_ns_list[0] = cpu_to_le32(0xffffffff);
>>> +	}
>>
>> Unless I'm missing it happening somewhere else, the list-full case that sets element 0 to 0xffffffff should also explicitly zero out the rest of the list to satisfy the "remainder of the list shall be zero-filled" wording in the spec, since the other changed_ns_list entries will be filled with non-zero NSIDs when we get here.
> 
> True.  We actually zero out unused elements already, but that doesn't
> catch the ctrl->nr_changed_ns == NVME_MAX_CHANGED_NAMESPACES special
> case.  This relative patch should fix it:
> 
> diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
> index d7b6293e830b..7b69c348d608 100644
> --- a/drivers/nvme/target/admin-cmd.c
> +++ b/drivers/nvme/target/admin-cmd.c
> @@ -136,7 +136,10 @@ static void nvmet_execute_get_log_changed_ns(struct nvmet_req *req)
>  		goto out;
>  
>  	mutex_lock(&ctrl->lock);
> -	len = ctrl->nr_changed_ns * sizeof(__le32);
> +	if (ctrl->nr_changed_ns == NVME_MAX_CHANGED_NAMESPACES)
> +		len = sizeof(__le32);
> +	else
> +		len = ctrl->nr_changed_ns * sizeof(__le32);
>  	status = nvmet_copy_to_sgl(req, 0, ctrl->changed_ns_list, len);
>  	if (!status)
>  		status = nvmet_zero_sgl(req, len, req->data_len - len);
> 

I'm not sure that's quite right; if nr_changed_ns == NVME_MAX_CHANGED_NAMESPACES but we haven't overflowed (in other words, the list has exactly NVME_MAX_CHANGED_NAMESPACES NSIDs), this will still only copy over the first entry.

I think it needs a:
	&& ctrlr->changed_ns_list[0] == cpu_to_le32(0xffffffff)
in the NVME_MAX_CHANGED_NAMESPACES condition to make it fully correct.

Thanks,
-- Daniel
