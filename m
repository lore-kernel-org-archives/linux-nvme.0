Return-Path: <SRS0=FbzM=CZ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63150C43461
	for <linux-nvme@archiver.kernel.org>; Wed, 16 Sep 2020 07:09:30 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D2247206C9
	for <linux-nvme@archiver.kernel.org>; Wed, 16 Sep 2020 07:09:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="GIYy+BI5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2247206C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=L7r6NRRxo4yxyZqOGYYGR1bQuQ953EovWg4g67lDnG4=; b=GIYy+BI5eDpxuXAAxJtzHts//
	Kg0yf5ZZrmQ3BC8bnu9ysgVwQXHGShcoZIuMIydfHpiEvRIpw7NNfnrmXV6YErBSEX78bCNWY0r0K
	kTKWKMiEj4OQ9CZTYYr2wB2bUGIYaCIO7xPcQwp8bcOH9Fff5R5+ZqsyZLx/t21FzfYIeLmp+vMQr
	83bQ7RphC1ztLwAdWputTazPWNRsnSaU6o7c9vbQjEsQoOeSOZmMaBC9hpQp0EW69Jvg2fpaELoSK
	H6Qy/hlzb5L1C817097Z4iFzZNc8C1AFLWmRxsHNPY6W+w9uFL//LbidcYIc8KKsFrISeo6rvkYi1
	vMhnR8MGw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kIRZG-0004kj-Jx; Wed, 16 Sep 2020 07:09:26 +0000
Received: from verein.lst.de ([213.95.11.211])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kIRZD-0004kJ-Rb
 for linux-nvme@lists.infradead.org; Wed, 16 Sep 2020 07:09:24 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 8300468B05; Wed, 16 Sep 2020 09:09:21 +0200 (CEST)
Date: Wed, 16 Sep 2020 09:09:21 +0200
From: Christoph Hellwig <hch@lst.de>
To: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: Re: [PATCH V3 1/7] nvme-core: use I/O timeout in submit sync cmd
Message-ID: <20200916070921.GA9592@lst.de>
References: <20200915215118.3934-1-chaitanya.kulkarni@wdc.com>
 <20200915215118.3934-2-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200915215118.3934-2-chaitanya.kulkarni@wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200916_030923_999225_5DC7A0B9 
X-CRM114-Status: GOOD (  24.57  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: kbusch@kernel.org, hch@lst.de, linux-nvme@lists.infradead.org,
 sagi@grimberg.me
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Tue, Sep 15, 2020 at 02:51:12PM -0700, Chaitanya Kulkarni wrote:
> In the function __nvme_submit_sync_cmd() it uses ADMIN_TIMEOUT when
> caller doesn't specify value for the timeout variable. This function is
> also called from the NVMe commands contexts (nvme_pr_command()/
> nvme_ns_report_zones()) where NVME_IO_TIMEOUT can be used instead of
> ADMIN_TIMEOUT.
> 
> For now we don't set the request queue's queuedata for admin command.
> 
> Introduce a helper nvme_default_timeout() and when timeout is not set
> for the block layer request  based on the request queue's queuedata,
> set Admin timeout else I/O timeout.
> 
> Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
> ---
>  drivers/nvme/host/core.c |  2 +-
>  drivers/nvme/host/nvme.h | 15 +++++++++++++++
>  2 files changed, 16 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 8b75f6ca0b61..0f878f5e07f0 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -885,7 +885,7 @@ int __nvme_submit_sync_cmd(struct request_queue *q, struct nvme_command *cmd,
>  	if (IS_ERR(req))
>  		return PTR_ERR(req);
>  
> -	req->timeout = timeout ? timeout : ADMIN_TIMEOUT;
> +	nvme_default_timeout(req, timeout);
>  
>  	if (buffer && bufflen) {
>  		ret = blk_rq_map_kern(q, req, buffer, bufflen, GFP_KERNEL);
> diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
> index 9fd45ff656da..78dc422ee42c 100644
> --- a/drivers/nvme/host/nvme.h
> +++ b/drivers/nvme/host/nvme.h
> @@ -638,6 +638,21 @@ struct nvme_ns *nvme_get_ns_from_disk(struct gendisk *disk,
>  		struct nvme_ns_head **head, int *srcu_idx);
>  void nvme_put_ns_from_disk(struct nvme_ns_head *head, int idx);
>  
> +static inline void nvme_default_timeout(struct request *req,
> +					unsigned int timeout)
> +{
> +	void *queuedata = req->q->queuedata;
> +
> +	/*
> +	 * For now admin request queue's queue data == NULL, if that assumption
> +	 * changes it should reflect here.
> +	 */
> +	if (!timeout)
> +		timeout = queuedata ? NVME_IO_TIMEOUT : ADMIN_TIMEOUT;
> +
> +	req->timeout = timeout;

The void *queuedata thing is really weird.

I'd keep the check for an existing timeout in the callers and just
write this as:

static inline void nvme_req_set_default_timeout(struct request *req)
{
	if (req->queuedata)
		req->timeout = NVME_IO_TIMEOUT
	else /* no queuedata implies admin queue */
		req->timeout = ADMIN_TIMEOUT;
}

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
