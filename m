From: logang@deltatee.com (Logan Gunthorpe)
Date: Wed, 4 Apr 2018 10:47:26 -0600
Subject: [PATCH 2/4] nvmet-rdma: Use new SGL alloc/free helper for requests
In-Reply-To: <2fbc3260-6682-f789-9500-2961293ff3b4@grimberg.me>
References: <20180329160721.4691-1-logang@deltatee.com>
 <20180329160721.4691-3-logang@deltatee.com>
 <2fbc3260-6682-f789-9500-2961293ff3b4@grimberg.me>
Message-ID: <17515a8d-df59-9bb7-0d51-a5134858db0a@deltatee.com>

On 4/4/2018 6:43 AM, Sagi Grimberg wrote:
> IIRC, this might result in nvmet-rdma executing data-transfer even
> for failed requests in some error cases. I'm not sure this is the
> only case, but have you tested what happens in error cases?

That's why I set transfer_len to zero when we exit this function on 
error (see the error_out label):

> +error_out:
> +    rsp->req.transfer_len = 0;
> +    return NVME_SC_INTERNAL; 

I haven't tested the error path, but I can. Is it sufficient to just 
change the code to create an error or do you know of a better way to 
test this?

Thanks,

Logan
