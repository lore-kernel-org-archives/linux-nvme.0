Return-Path: <SRS0=BHyj=6F=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B970BC54FD0
	for <linux-nvme@archiver.kernel.org>; Tue, 21 Apr 2020 12:20:38 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F0142075E
	for <linux-nvme@archiver.kernel.org>; Tue, 21 Apr 2020 12:20:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="F6F9dT8b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F0142075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=hpR5PFlbVqyLW3002PWZrGHGJJW7xogiDCPXx2LEXyo=; b=F6F9dT8bLCi4Vc
	xK1qKVZkhjm8LslUGQl+ixHoLmFJRCVwXRZ0z1LdcG8abwl367cPSClSIDK81eTVVOaCTrz01u8pB
	wYZbplbWqCsBRhP/Bffms5gmH81o6ZXUWrnhkIBTfMsPXWsNe6ABZVcprbvpY1MpYYu4oAdYc61v7
	YISYxbN00erauVV/5ygJtnTrqA9c3n4GR3HxFF4Arh5eT5rYtnCNJji/wh0XMtz8PG42EtItTs/9h
	bxpnPRRroQY10gzc+rgiZFr6KIJGjeQqCtHg8AM30Oq4YZx+JqWrwxzX8GgbJ5ybmJGv0SnZlcxIJ
	uBnOlAMiDL4rkUrwMLyQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jQrtE-0000fC-A2; Tue, 21 Apr 2020 12:20:36 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jQrtB-0000e2-GR
 for linux-nvme@lists.infradead.org; Tue, 21 Apr 2020 12:20:34 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 92A6668C4E; Tue, 21 Apr 2020 14:20:30 +0200 (CEST)
Date: Tue, 21 Apr 2020 14:20:30 +0200
From: Christoph Hellwig <hch@lst.de>
To: Max Gurtovoy <maxg@mellanox.com>
Subject: Re: [PATCH 08/17] nvme-rdma: add metadata/T10-PI support
Message-ID: <20200421122030.GI26432@lst.de>
References: <20200327171545.98970-1-maxg@mellanox.com>
 <20200327171545.98970-10-maxg@mellanox.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200327171545.98970-10-maxg@mellanox.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200421_052033_696116_AB6134C1 
X-CRM114-Status: GOOD (  17.15  )
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
Cc: axboe@kernel.dk, jsmart2021@gmail.com, sagi@grimberg.me,
 martin.petersen@oracle.com, shlomin@mellanox.com, linux-rdma@vger.kernel.org,
 israelr@mellanox.com, vladimirk@mellanox.com, linux-nvme@lists.infradead.org,
 idanb@mellanox.com, jgg@mellanox.com, oren@mellanox.com, kbusch@kernel.org,
 hch@lst.de
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Fri, Mar 27, 2020 at 08:15:36PM +0300, Max Gurtovoy wrote:
> For capable HCAs (e.g. ConnectX-5/ConnectX-6) this will allow end-to-end
> protection information passthrough and validation for NVMe over RDMA
> transport. Metadata offload support was implemented over the new RDMA
> signature verbs API and it is enabled per controller by using nvme-cli.
> 
> usage example:
> nvme connect --pi_enable --transport=rdma --traddr=10.0.1.1 --nqn=test-nvme
> 
> Signed-off-by: Max Gurtovoy <maxg@mellanox.com>
> Signed-off-by: Israel Rukshin <israelr@mellanox.com>
> ---
>  drivers/nvme/host/rdma.c | 330 ++++++++++++++++++++++++++++++++++++++++++-----
>  1 file changed, 296 insertions(+), 34 deletions(-)
> 
> diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
> index e38f8f7..23cc77e 100644
> --- a/drivers/nvme/host/rdma.c
> +++ b/drivers/nvme/host/rdma.c
> @@ -67,6 +67,9 @@ struct nvme_rdma_request {
>  	struct ib_cqe		reg_cqe;
>  	struct nvme_rdma_queue  *queue;
>  	struct nvme_rdma_sgl	data_sgl;
> +	/* Metadata (T10-PI) support */
> +	struct nvme_rdma_sgl	*md_sgl;
> +	bool			use_md;

Do we need a use_md flag vs just using md_sgl as a boolean and/or
using blk_integrity_rq?

>  enum nvme_rdma_queue_flags {
> @@ -88,6 +91,7 @@ struct nvme_rdma_queue {
>  	struct rdma_cm_id	*cm_id;
>  	int			cm_error;
>  	struct completion	cm_done;
> +	bool			pi_support;

Why do we need this on a per-queue basis vs always checking the
controller?

> +	u32 max_page_list_len =
> +		pi_support ? ibdev->attrs.max_pi_fast_reg_page_list_len :
> +			     ibdev->attrs.max_fast_reg_page_list_len;
> +
> +	return min_t(u32, NVME_RDMA_MAX_SEGMENTS, max_page_list_len - 1);

Can you use a good old if / else here?

> +#ifdef CONFIG_BLK_DEV_INTEGRITY
> +static void nvme_rdma_set_sig_domain(struct blk_integrity *bi,
> +		struct nvme_command *cmd, struct ib_sig_domain *domain,
> +		u16 control)
>  {
> +	domain->sig_type = IB_SIG_TYPE_T10_DIF;
> +	domain->sig.dif.bg_type = IB_T10DIF_CRC;
> +	domain->sig.dif.pi_interval = 1 << bi->interval_exp;
> +	domain->sig.dif.ref_tag = le32_to_cpu(cmd->rw.reftag);
>  
>  	/*
> +	 * At the moment we hard code those, but in the future
> +	 * we will take them from cmd.

I don't understand this comment.  Also it doesn't use up all 80 chars.


> +static void nvme_rdma_set_sig_attrs(struct blk_integrity *bi,
> +		struct nvme_command *cmd, struct ib_sig_attrs *sig_attrs)
> +{
> +	u16 control = le16_to_cpu(cmd->rw.control);
> +
> +	WARN_ON(bi == NULL);

I think this WARN_ON is pointless, as we'll get a NULL pointer derference
a little later anyway.

> +mr_put:
> +	if (req->use_md)
> +		ib_mr_pool_put(queue->qp, &queue->qp->sig_mrs, req->mr);
> +	else
> +		ib_mr_pool_put(queue->qp, &queue->qp->rdma_mrs, req->mr);

I've seen this patterns a few times, maybe a little helper to return
the right mr pool for a request?

> +	if (blk_integrity_rq(rq)) {
> +		memset(req->md_sgl, 0, sizeof(struct nvme_rdma_sgl));

Why do we need this memset?

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
