From: jmoyer@redhat.com (Jeff Moyer)
Date: Tue, 21 Apr 2015 09:44:44 -0400
Subject: [PATCH 1/2] added stream id write support
In-Reply-To: <1429580863-3451-2-git-send-email-kwan.huen@samsung.com> (kwan
 huen's message of "Mon, 20 Apr 2015 18:47:42 -0700")
References: <1429580863-3451-1-git-send-email-kwan.huen@samsung.com>
 <1429580863-3451-2-git-send-email-kwan.huen@samsung.com>
Message-ID: <x49y4ll8uk3.fsf@segfault.boston.devel.redhat.com>

"kwan.huen" <kwan.huen at samsung.com> writes:

> ---
>  drivers/block/nvme-core.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c
> index 85b8036..332341a 100644
> --- a/drivers/block/nvme-core.c
> +++ b/drivers/block/nvme-core.c
> @@ -769,6 +769,9 @@ static int nvme_submit_iod(struct nvme_queue *nvmeq, struct nvme_iod *iod,
>  	if (req->cmd_flags & REQ_RAHEAD)
>  		dsmgmt |= NVME_RW_DSM_FREQ_PREFETCH;
>  
> +	if (rq_data_dir(req))
> +		dsmgmt |= bio_get_streamid(req->bio) << 8;
> +

There's no public specification for this, yet.  How many bits are set
aside for the stream id?  Do you need to do bounds checking/input
validation?  What happens on adapters with older firmware when these
bits are set?

Cheers,
Jeff
