From: Chaitanya.Kulkarni@wdc.com (Chaitanya Kulkarni)
Date: Fri, 17 Aug 2018 21:44:34 +0000
Subject: [PATCH 1/6] nvme-ana-log: fixup compiler warning in show_ana_log()
In-Reply-To: <20180817080924.GA13230@lst.de>
References: <20180817072908.56784-1-hare@suse.de>
 <20180817072908.56784-2-hare@suse.de>,<20180817080924.GA13230@lst.de>
Message-ID: <BYAPR04MB4502A06AE5FE20A06720D95F863D0@BYAPR04MB4502.namprd04.prod.outlook.com>


Not sure if this is relevant but le64_to_cpu() we are fixing warnings by the cast,
maybe follow the same pattern everywhere?

http://lists.infradead.org/pipermail/linux-nvme/2018-June/018585.html



From: Linux-nvme <linux-nvme-bounces@lists.infradead.org> on behalf of Christoph Hellwig <hch@lst.de>
Sent: Friday, August 17, 2018 1:09 AM
To: Hannes Reinecke
Cc: Keith Busch; Hannes Reinecke; Sagi Grimberg; linux-nvme at lists.infradead.org; Christoph Hellwig
Subject: Re: [PATCH 1/6] nvme-ana-log: fixup compiler warning in show_ana_log()
? 
 
On Fri, Aug 17, 2018@09:29:03AM +0200, Hannes Reinecke wrote:
> Add the correct type cast to keep the compiler happy.
> 
> Signed-off-by: Hannes Reinecke <hare at suse.com>
> ---
>? nvme-print.c | 3 ++-
>? 1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/nvme-print.c b/nvme-print.c
> index e0da949..8a604c5 100644
> --- a/nvme-print.c
> +++ b/nvme-print.c
> @@ -1460,7 +1460,8 @@ void show_ana_log(struct nvme_ana_rsp_hdr *ana_log, const char *devname)
>??????????????? offset += sizeof(*desc);
>??????????????? printf("grpid?? :?????? %u\n", le32_to_cpu(desc->grpid));
>??????????????? printf("nnsids? :?????? %u\n", le32_to_cpu(desc->nnsids));
> -???????????? printf("chgcnt? :?????? %"PRIu64"\n", le64_to_cpu(desc->chgcnt));
> +???????????? printf("chgcnt? :?????? %"PRIu64"\n",
> +??????????????????? (uint64_t)le64_to_cpu(desc->chgcnt));

Wouldn't it be easier to just use %llu as the printf specified, given
that u64/__u64 are always and unsigned long long?

_______________________________________________
Linux-nvme mailing list
Linux-nvme at lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme


Linux-nvme Info Page - lists.infradead.org
lists.infradead.org
To see the collection of prior postings to the list, visit the Linux-nvme Archives.. Using Linux-nvme: To post a message to all the list members, send email to linux-nvme at lists.infradead.org.

    
