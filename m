From: jianchao.w.wang@oracle.com (jianchao.wang)
Date: Fri, 5 Jan 2018 11:44:38 +0800
Subject: [PATCH V2] nvme-pci: fix NULL pointer reference in nvme_alloc_ns
In-Reply-To: <20180104102033.GA4834@lst.de>
References: <1515112799-1678-1-git-send-email-jianchao.w.wang@oracle.com>
 <20180104102033.GA4834@lst.de>
Message-ID: <29e565f1-95a7-96f3-6681-78af691c633c@oracle.com>

Hi Christoph 

Many thanks for your kindly response.

On 01/04/2018 06:20 PM, Christoph Hellwig wrote:
> This looks generally fine to me, ut a few nitpicks below:
> 
>>  - Based on Sagi's suggestion, add new state NVME_CTRL_ADMIN_LIVE.
> 
> Maybe call this NVME_CTRL_ADMIN_ONLY ?
Sound more in line with the new state. Use it in next version.
> 
>> -	if (ctrl->state != NVME_CTRL_LIVE)
>> +	if ((ctrl->state != NVME_CTRL_LIVE) &&
>> +		(ctrl->state != NVME_CTRL_ADMIN_LIVE))
> 
> No need for the inner braces, and odd indentation.  Also in general
> I'm tempted to just use switch statements for things like this, e.g.
> 
> 	switch (ctrl->state) {
> 	case NVME_CTRL_ADMIN_LIVE:
> 	case NVME_CTRL_LIVE:
> 		break;
> 	default:
> 		return -EWOULDBLOCK;
> 	}
> 
Yes, it looks clearer and more readable. Use it in next version
>> @@ -3074,6 +3087,8 @@ static void nvme_scan_work(struct work_struct *work)
>>  	if (ctrl->state != NVME_CTRL_LIVE)
>>  		return;
>>  
>> +	BUG_ON(!ctrl->tagset);
> 
> WARN_ON_ONCE() please.
Yes, use it in next version
> 
>> +	bool only_adminq = false;
> 
> How about a new_state variable instead that holds the new state value?
> 
Yes, it is more reasonable. Use it next version.

Thanks
Jianchao
