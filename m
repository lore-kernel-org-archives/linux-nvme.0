From: ednadols@linux.microsoft.com (Edmund Nadolski)
Date: Mon, 29 Apr 2019 21:46:13 -0700
Subject: [PATCH 2/2] nvme: add clarifying comments and fix some typos
In-Reply-To: <ac3905e6-208b-a528-f1ff-189c2f8048f8@grimberg.me>
References: <20190429173533.10366-1-ednadols@linux.microsoft.com>
 <20190429173533.10366-3-ednadols@linux.microsoft.com>
 <ac3905e6-208b-a528-f1ff-189c2f8048f8@grimberg.me>
Message-ID: <6a984000-0b1c-d091-6d92-28fa44b9c475@linux.microsoft.com>

On 4/29/19 4:23 PM, Sagi Grimberg wrote:
> 
>> Add comment descriptions for struct fields per NVMe spec.
> 
> Lets split typos from this patch. Not sure that the comments are all
> that useful, as we usually have a spec/tp at hand...

They could be useful to save a lookup (or when a spec isn't handy). I had
also thought of doing the nvm_id_ctrl and  nvme_id_ns structs, but I'll hold
off as it seems folks see this as extraneous.

I will split out the typos out and re-send.

Thanks,
Ed
