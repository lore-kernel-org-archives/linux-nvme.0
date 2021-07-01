Return-Path: <SRS0=jgW7=LZ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95429C11F64
	for <linux-nvme@archiver.kernel.org>; Thu,  1 Jul 2021 13:34:42 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 30BB4613FD
	for <linux-nvme@archiver.kernel.org>; Thu,  1 Jul 2021 13:34:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30BB4613FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=X3p00HVakW7Q50AnVxN/SP3dKRnIkZsZSvxhupUpL2w=; b=znumlAT8R2L5sP
	JTSQfHn0DO00hXe9scWfFfuXZx9dyxmC4n+OJh9fm6IJtupGxOPpXUuOV1828DaboDhjYC9Oq6FIx
	BL4pOkZ4n6Oujq2FVeWjZu0O3zKGqJZc1V4wL/PSxJ3ONH4s42K9ZOhsRd/YBEPJ9EyyblqMpGa06
	dOKDIOafrXkJyCHI40TL7JEVl4FI5HROu3Bw0W2vaLc0bXRaeYdmNOD4bfUcPlEAgFyvh6FE6fk64
	eaVy/zuvMFfpSg2dlN5hhcPGMCYbqbm3tOOWG4Z3Jlj5wMYNZ+QDKrBfLLeRcoYfmTywkbYDzVGAY
	6f3Cyh3nLTnqJmsV1l5Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lywpr-00HU3h-9P; Thu, 01 Jul 2021 13:34:31 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lywpo-00HU2b-8D
 for linux-nvme@lists.infradead.org; Thu, 01 Jul 2021 13:34:29 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 583B767357; Thu,  1 Jul 2021 15:34:24 +0200 (CEST)
Date: Thu, 1 Jul 2021 15:34:24 +0200
From: Christoph Hellwig <hch@lst.de>
To: Prabhakar Kushwaha <pkushwaha@marvell.com>
Cc: linux-nvme@lists.infradead.org, sagi@grimberg.me, hch@lst.de,
 axboe@fb.com, kbusch@kernel.org, davem@davemloft.net,
 kuba@kernel.org, smalin@marvell.com, aelior@marvell.com,
 mkalderon@marvell.com, okulkarni@marvell.com,
 prabhakar.pkin@gmail.com, malin1024@gmail.com,
 Dean Balandin <dbalandin@marvell.com>
Subject: Re: [PATCH v4 01/20] nvme-tcp-offload: Add nvme-tcp-offload -
 NVMeTCP HW offload ULP
Message-ID: <20210701133424.GB18548@lst.de>
References: <20210629124743.6898-1-pkushwaha@marvell.com>
 <20210629124743.6898-2-pkushwaha@marvell.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210629124743.6898-2-pkushwaha@marvell.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210701_063428_486255_42A9ABCF 
X-CRM114-Status: GOOD (  23.30  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

> +/* Kernel includes */


> +/* Driver includes */

I think these comments are a little pointless.

> +int nvme_tcp_ofld_register_dev(struct nvme_tcp_ofld_dev *dev)

Can you spell out offload everywhere?

> +int nvme_tcp_ofld_report_queue_err(struct nvme_tcp_ofld_queue *queue)
> +{
> +	/* Placeholder - invoke error recovery flow */
> +
> +	return 0;
> +}

Please don't add any placeholders like this.  The whole file is
still pretty small with all the patches applied, so no need to split it.

> +static struct nvmf_transport_ops nvme_tcp_ofld_transport = {
> +	.name		= "tcp_offload",
> +	.module		= THIS_MODULE,
> +	.required_opts	= NVMF_OPT_TRADDR,
> +	.allowed_opts	= NVMF_OPT_TRSVCID | NVMF_OPT_NR_WRITE_QUEUES  |
> +			  NVMF_OPT_HOST_TRADDR | NVMF_OPT_CTRL_LOSS_TMO |
> +			  NVMF_OPT_RECONNECT_DELAY | NVMF_OPT_HDR_DIGEST |
> +			  NVMF_OPT_DATA_DIGEST | NVMF_OPT_NR_POLL_QUEUES |
> +			  NVMF_OPT_TOS | NVMF_OPT_HOST_IFACE,
> +};
> +
> +static int __init nvme_tcp_ofld_init_module(void)
> +{
> +	nvmf_register_transport(&nvme_tcp_ofld_transport);
> +
> +	return 0;
> +}
> +
> +static void __exit nvme_tcp_ofld_cleanup_module(void)
> +{
> +	nvmf_unregister_transport(&nvme_tcp_ofld_transport);
> +}

Looking at the final result this doesn't do much.  Assuming we want
to support these kinds of whacky offloads (which I'd rather not do),
the proper way would be to allow registering multiple transport_ops
structures for a given name rather adding an indirection that duplicates
a whole lot of code.

> +	/* Offload device specific driver context */
> +	int num_hw_vectors;
> +};

As far as I can tell this is about queues, not "vectors" of some kind.

> +struct nvme_tcp_ofld_req {
> +	struct nvme_request req;
> +	struct nvme_command nvme_cmd;
> +	struct list_head queue_entry;
> +	struct nvme_tcp_ofld_queue *queue;
> +
> +	/* Offload device specific driver context */
> +	void *private_data;
> +
> +	/* async flag is used to distinguish between async and IO flow
> +	 * in common send_req() of nvme_tcp_ofld_ops.
> +	 */
> +	bool async;
> +
> +	void (*done)(struct nvme_tcp_ofld_req *req,
> +		     union nvme_result *result,
> +		     __le16 status);

This always points to nvme_tcp_ofld_req_done, why the costly indirection?

> +	/* Error callback function */
> +	int (*report_err)(struct nvme_tcp_ofld_queue *queue);
> +};

This seems to always point to nvme_tcp_ofld_report_queue_err, why the
indirection?

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
