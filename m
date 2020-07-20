Return-Path: <SRS0=fGVD=A7=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38F9AC433E4
	for <linux-nvme@archiver.kernel.org>; Mon, 20 Jul 2020 14:01:59 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 05DD622BF3
	for <linux-nvme@archiver.kernel.org>; Mon, 20 Jul 2020 14:01:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="uXcmkRkw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05DD622BF3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=MnbsnqA5m6YuDk96Q+QS+SHO7SMPfn7w60WPUuIJedg=; b=uXcmkRkwpHtxpoYzLoW1p0d72
	MJ2Cah74MfwRkP/OQsAKoybA/LzbIpacSJRFB2rJd0M1cwoxMdIaiOwxHm5yJTKBAaJfgXlIyUFMC
	LG49Vw9bnaWgl18tlW+UPv+HKkaUIGYJh2PRFOMNgh/V2R7mc10HkCHNUalNEjCErFs6XaZOdkoZe
	Mrn9yOhGpeGl6NmuezT4LPjdmMdXxtu0n65jm9FFQqjTb/M+gIa6kruWA3N5EJXII107IZ7IRM15W
	dhk1suGz/LtnojN3dDpmm/nCJ9UWlRbK3M/In4rzdF1mWvc1cUyUvxCKAlgII5wHU2zLkc58NeqJF
	rz1A/0iGw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jxWMe-00073m-0m; Mon, 20 Jul 2020 14:01:56 +0000
Received: from verein.lst.de ([213.95.11.211])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jxWMc-00073L-1M
 for linux-nvme@lists.infradead.org; Mon, 20 Jul 2020 14:01:54 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 8993568BFE; Mon, 20 Jul 2020 16:01:51 +0200 (CEST)
Date: Mon, 20 Jul 2020 16:01:51 +0200
From: Christoph Hellwig <hch@lst.de>
To: Logan Gunthorpe <logang@deltatee.com>
Subject: Re: [PATCH v15 1/9] nvme-core: Clear any SGL flags in passthru
 commands
Message-ID: <20200720140151.GA4627@lst.de>
References: <20200716203319.16022-1-logang@deltatee.com>
 <20200716203319.16022-2-logang@deltatee.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200716203319.16022-2-logang@deltatee.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200720_100154_191763_54890919 
X-CRM114-Status: GOOD (  15.43  )
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

On Thu, Jul 16, 2020 at 02:33:11PM -0600, Logan Gunthorpe wrote:
> The host driver should decide whether to use SGLs or PRPs and they
> currently assume the flags are cleared after the call to
> nvme_setup_cmd(). However, passed-through commands may erroneously
> set these bits; so clear them for all cases.
> 
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
> Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
> ---
>  drivers/nvme/host/core.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index f49085bcaa42..63a59186e68b 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -759,6 +759,8 @@ blk_status_t nvme_setup_cmd(struct nvme_ns *ns, struct request *req,
>  	case REQ_OP_DRV_IN:
>  	case REQ_OP_DRV_OUT:
>  		memcpy(cmd, nvme_req(req)->cmd, sizeof(*cmd));
> +		/* passthru commands should let the driver set the SGL flags */
> +		cmd->common.flags &= ~NVME_CMD_SGL_ALL;
>  		break;

This probably wants to be split into a little helper like the
other cases.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
