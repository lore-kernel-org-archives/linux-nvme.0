Return-Path: <SRS0=yFSL=I5=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3CB1C433DB
	for <linux-nvme@archiver.kernel.org>; Wed, 31 Mar 2021 00:30:30 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3999360295
	for <linux-nvme@archiver.kernel.org>; Wed, 31 Mar 2021 00:30:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3999360295
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=zgXnDo7IFxMxFsN/TREcJaJfYiXybllIB5yJ+KH0hV8=; b=gYf6+CSH910tHgKDdWF7407k4
	gU0ZhNaq4Mqh9ZH9TyAHFe1nDri5kLIQ28AZ0/AL0QmLoIfTC0VrLQ3fS1dQsCGzL2vEwhCDnMhvd
	X1B1wJSRDhVeEaXEuH3t+kT2qHffZan8xs7TISPQ/v3qXjkW1zREaAX69vUhfcC358wNfqoU+OzKM
	tcL2AHKAacrsftPlIutewZLbXASu9sas2drYhENTWFPPQ6x5CpigWUXAS//N1rIEcW78GMU0rAWjU
	qnZGyKsRra+g97s+zGmTygt7a+QDzoeKKbwMNsTMoe/RWcHThAdgtvVUqJJCh1DCPjvl3oLhbDjFt
	ZsRBtBhjA==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lROkO-005Ar7-Jw; Wed, 31 Mar 2021 00:30:12 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lROkF-005Aol-Hy
 for linux-nvme@lists.infradead.org; Wed, 31 Mar 2021 00:30:05 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6CBCB60295;
 Wed, 31 Mar 2021 00:29:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1617150599;
 bh=uL+3oDtool6gKjcD+2WXWtUYlfUT6XqG5xlO+lYpOGQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=JbHC3VA8jcl7FLzY0SAbKEEveZI0Vutp4X3mw4qlzhWY1MdF7VpCEaNXmtDuVFHeI
 q0x8gv0IhpviBaKfGCUteR8krKPO6PPhilTK9yjyUCgVTPLRHjWKiJ29H9KMKU4kls
 YFpy/ZeGbfoj3GqZeWC2mLuAhHQpGiDAnSVej4lQcV/LPcKBVLp4Nb3r3PvS/9CaoC
 2pBsfVEXnFKvVkURBCHvdZi7MvsAtV1rgRLwfSWvH7CWRzI4Wm5vPM9CizORV5ht0E
 sGvGtyjzTszWAygplVbIXcM0uq+MFO+iS9kxI4tPh4sQrzyfiAGzx5QrkXEcK83pGH
 83ekS2SBTGbeg==
Date: Wed, 31 Mar 2021 09:29:52 +0900
From: Keith Busch <kbusch@kernel.org>
To: Max Gurtovoy <mgurtovoy@nvidia.com>
Cc: linux-nvme@lists.infradead.org, sagi@grimberg.me, hch@lst.de,
 chaitanya.kulkarni@wdc.com, jsmart2021@gmail.com
Subject: Re: [PATCH 1/2] nvme-tcp: check sgl supported by target
Message-ID: <20210331002952.GA23886@redsun51.ssa.fujisawa.hgst.com>
References: <20210330230120.268671-1-mgurtovoy@nvidia.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210330230120.268671-1-mgurtovoy@nvidia.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210331_013004_035645_6318AC5A 
X-CRM114-Status: GOOD (  17.14  )
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

On Tue, Mar 30, 2021 at 11:01:19PM +0000, Max Gurtovoy wrote:
> SGLs support is mandatory for NVMe/tcp, make sure that the target is
> aligned to the specification.

Logging an error seems fine. Are there existing controllers that do
this? If so, what currently happens? If they just have a broken Identify
Controller structure but still work with this driver, should we proceed
with trying to use it anyway with the existing assumption?
 
> Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
> ---
>  drivers/nvme/host/tcp.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> index a0f00cb8f9f3..e5fbb921165e 100644
> --- a/drivers/nvme/host/tcp.c
> +++ b/drivers/nvme/host/tcp.c
> @@ -1973,6 +1973,11 @@ static int nvme_tcp_setup_ctrl(struct nvme_ctrl *ctrl, bool new)
>  		goto destroy_admin;
>  	}
>  
> +	if (!(ctrl->sgls & ((1 << 0) | (1 << 1)))) {
> +		dev_err(ctrl->device, "Mandatory sgls are not supported!\n");
> +		goto destroy_admin;
> +	}
> +
>  	if (opts->queue_size > ctrl->sqsize + 1)
>  		dev_warn(ctrl->device,
>  			"queue_size %zu > ctrl sqsize %u, clamping down\n",
> -- 

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
