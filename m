From: sagi@grimberg.me (Sagi Grimberg)
Date: Wed, 26 Oct 2016 11:36:26 +0300
Subject: [PATCH] rdma: force queue size to respect controller capability
In-Reply-To: <df71b855-c133-b3ad-ec81-e36a6f851531@intel.com>
References: <444159155.19898733.1477380154029.JavaMail.zimbra@kalray.eu>
 <df71b855-c133-b3ad-ec81-e36a6f851531@intel.com>
Message-ID: <89695878-8e93-94ea-653d-6381b92e9cbd@grimberg.me>

> I believe there's an off-by-one (or two) lurking here.
>
> It looks to me like ctrlr->ctrlr.sqsize is intended to be 0's-based:
> - sqsize is passed as HSQSIZE in the Connect private data, which is
> 0's-based
> - sqsize is set to opts->queue_size - 1 earlier in nvme_rdma_create_ctrlr()
>
> However, this new change assigns opts->queue_size (non-0's-based value)
> the current value of ctrlr->ctrlr.sqsize (0's-based value) without any
> adjustment.
>
> This is probably because there is another bug in
> nvme_rdma_configure_admin_queue(), where sqsize is set to a value based
> on CAP.MQES + 1.  MQES is a 0's-based value, so if sqsize is also
> supposed to be 0's based, no addition should be necessary.
>
> I think it is currently working only in the case where the original
> sqsize is already smaller than MQES, because then the min of MQES and
> sqsize will pick sqsize, which is already 0's based from the initial
> queue_size - 1 assignment.
>
> If I'm not missing anything, the correct fix should be removing the + 1
> adjustment of MQES as well as changing this patch to consider the 0's
> based nature of sqsize:
>
>     if (opts->queue_size > ctrlr->ctrlr->sqsize + 1) {
>         ...
>          opts->queue_size = ctrlr->ctrlr.sqsize + 1;
>     }

Your correct Daniel. I'll fix that in the patch itself.

Thanks!
