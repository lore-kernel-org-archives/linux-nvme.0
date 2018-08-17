From: hch@lst.de (Christoph Hellwig)
Date: Fri, 17 Aug 2018 10:09:24 +0200
Subject: [PATCH 1/6] nvme-ana-log: fixup compiler warning in show_ana_log()
In-Reply-To: <20180817072908.56784-2-hare@suse.de>
References: <20180817072908.56784-1-hare@suse.de>
 <20180817072908.56784-2-hare@suse.de>
Message-ID: <20180817080924.GA13230@lst.de>

On Fri, Aug 17, 2018@09:29:03AM +0200, Hannes Reinecke wrote:
> Add the correct type cast to keep the compiler happy.
> 
> Signed-off-by: Hannes Reinecke <hare at suse.com>
> ---
>  nvme-print.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/nvme-print.c b/nvme-print.c
> index e0da949..8a604c5 100644
> --- a/nvme-print.c
> +++ b/nvme-print.c
> @@ -1460,7 +1460,8 @@ void show_ana_log(struct nvme_ana_rsp_hdr *ana_log, const char *devname)
>  		offset += sizeof(*desc);
>  		printf("grpid	:	%u\n", le32_to_cpu(desc->grpid));
>  		printf("nnsids	:	%u\n", le32_to_cpu(desc->nnsids));
> -		printf("chgcnt	:	%"PRIu64"\n", le64_to_cpu(desc->chgcnt));
> +		printf("chgcnt	:	%"PRIu64"\n",
> +		       (uint64_t)le64_to_cpu(desc->chgcnt));

Wouldn't it be easier to just use %llu as the printf specified, given
that u64/__u64 are always and unsigned long long?
