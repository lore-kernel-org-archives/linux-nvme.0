Return-Path: <SRS0=fGVD=A7=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13A7DC433E3
	for <linux-nvme@archiver.kernel.org>; Mon, 20 Jul 2020 14:16:19 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA65820B1F
	for <linux-nvme@archiver.kernel.org>; Mon, 20 Jul 2020 14:16:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="v4VmIdeB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA65820B1F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=okLVf8VxUZsOUGdoNOfiHnlNhUbD4WUYbLjvepxfVaw=; b=v4VmIdeBTdqq/GMB9tdo2cQGD
	c54QzlaM4uGOOW+o+FqTX8xBl6dma8g/aSgESzQcmBr4hUuMPldAbairC1qo6KNas1mh9+O+RmAg4
	+R1rytwcSyX7u2Epn5Iy8yDj+w3DZHE5Q2mtlnVlr43SwYtyPBDbijEDqfmjx3S87gOvZRRDKUvbS
	4EkzsNQruus4DFmnu7o5TJPYfyvoH8FyvcRa+55XhTDz0CJkTsl8XoDxR5tCLuHbCFYfJpwS3s3aJ
	kB97LB2NkAa0A49YrUQxI9W2BELvf3KI7vdpNRIz16cE9qeOqkD8nn2I96k0EAwgs7yfW7il+vZjV
	T4EuygLcQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jxWaT-0001uA-Hj; Mon, 20 Jul 2020 14:16:13 +0000
Received: from verein.lst.de ([213.95.11.211])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jxWaP-0001ss-1d
 for linux-nvme@lists.infradead.org; Mon, 20 Jul 2020 14:16:11 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 8A90468BFE; Mon, 20 Jul 2020 16:16:06 +0200 (CEST)
Date: Mon, 20 Jul 2020 16:16:06 +0200
From: Christoph Hellwig <hch@lst.de>
To: Logan Gunthorpe <logang@deltatee.com>
Subject: Re: [PATCH v15 7/9] nvmet-passthru: Add passthru code to process
 commands
Message-ID: <20200720141606.GF4627@lst.de>
References: <20200716203319.16022-1-logang@deltatee.com>
 <20200716203319.16022-8-logang@deltatee.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200716203319.16022-8-logang@deltatee.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200720_101609_339447_0101A067 
X-CRM114-Status: GOOD (  24.06  )
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
Cc: Sagi Grimberg <sagi@grimberg.me>,
 Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, Stephen Bates <sbates@raithlin.com>,
 Jens Axboe <axboe@fb.com>, Keith Busch <kbusch@kernel.org>,
 Max Gurtovoy <maxg@mellanox.com>, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Thu, Jul 16, 2020 at 02:33:17PM -0600, Logan Gunthorpe wrote:
> Add passthru command handling capability for the NVMeOF target and
> export passthru APIs which are used to integrate passthru
> code with nvmet-core.
> 
> The new file passthru.c handles passthru cmd parsing and execution.
> In the passthru mode, we create a block layer request from the nvmet
> request and map the data on to the block layer request.
> 
> Admin commands and features are on a white list as there are a number
> of each that don't make too much sense with passthrough. We use a
> white list so that new commands can be considered before being blindly
> passed through. In both cases, vendor specific commands are always
> allowed.
> 
> We also blacklist reservation IO commands as the underlying device
> cannot differentiate between multiple hosts behind a fabric.

I'm still not so happy about having to look up the namespace and still
wonder if we should generalize the connect_q to a passthrough_q.  But
I guess we can do that later and then reduce some of the exports here..

A few more comments below:

> +		struct {
> +			struct request		*rq;
> +			struct work_struct      work;
> +			u16 (*end_req)(struct nvmet_req *req);
> +		} p;

Do we really need the callback for the two identify fixups, or
should we just hardcode them to avoid indirection function calls?

> +++ b/drivers/nvme/target/passthru.c
> @@ -0,0 +1,457 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * NVMe Over Fabrics Target Passthrough command implementation.
> + *
> + * Copyright (c) 2017-2018 Western Digital Corporation or its
> + * affiliates.
> + */

I think you forgot to add your own copyrights here.

> +static int nvmet_passthru_map_sg(struct nvmet_req *req, struct request *rq)
> +{
> +	int sg_cnt = req->sg_cnt;
> +	struct scatterlist *sg;
> +	int op_flags = 0;
> +	struct bio *bio;
> +	int i, ret;
> +
> +	if (req->cmd->common.opcode == nvme_cmd_flush)
> +		op_flags = REQ_FUA;
> +	else if (nvme_is_write(req->cmd))
> +		op_flags = REQ_SYNC | REQ_IDLE;
> +
> +

Double empty line here..

> +	bio = bio_alloc(GFP_KERNEL, min(sg_cnt, BIO_MAX_PAGES));
> +	bio->bi_end_io = bio_put;
> +
> +	for_each_sg(req->sg, sg, req->sg_cnt, i) {
> +		if (bio_add_page(bio, sg_page(sg), sg->length,
> +				 sg->offset) != sg->length) {

bio_add_pages is only for non-passthrough requests, this needs to use
bio_add_pc_page.

> +	if (blk_rq_nr_phys_segments(rq) > queue_max_segments(rq->q)) {
> +		status = NVME_SC_INVALID_FIELD;
> +		goto fail_out;
> +	}
> +
> +	if ((blk_rq_payload_bytes(rq) >> 9) > queue_max_hw_sectors(rq->q)) {
> +		status = NVME_SC_INVALID_FIELD;
> +		goto fail_out;
> +	}

Which should also take care of these checks.

> +static void nvmet_passthru_set_host_behaviour(struct nvmet_req *req)
> +{
> +	struct nvme_ctrl *ctrl = nvmet_req_passthru_ctrl(req);
> +	struct nvme_feat_host_behavior *host;
> +	u16 status;
> +	int ret;
> +
> +	host = kzalloc(sizeof(*host) * 2, GFP_KERNEL);
> +	ret = nvme_get_features(ctrl, NVME_FEAT_HOST_BEHAVIOR, 0,
> +				host, sizeof(*host), NULL);

Mising kzalloc return check.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
