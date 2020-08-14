Return-Path: <SRS0=5rXh=BY=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8371C433E1
	for <linux-nvme@archiver.kernel.org>; Fri, 14 Aug 2020 06:44:26 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8ECC220774
	for <linux-nvme@archiver.kernel.org>; Fri, 14 Aug 2020 06:44:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="vWrwCPRF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8ECC220774
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=cAOtWGXH8/BjJE5QHQ3QWCpvSfIUePYOtrJB6Gqiq5s=; b=vWrwCPRFGmq7q+1X1mHcV6I8n
	Ym3i/JSyd1zwV3rWESnICoezmJyFbXUzFe0HUVKZ3aPuF/pXUZzh+tw5E3UsqTumRGzyws6NXhWVn
	HyVNdea1wxxQXuhabu5mJ+hABjyy5YUTooWygE660ktgp5iGjSdMV5A31xOVajNAJyqz2COJA6fNh
	13o+eH+CV6VfORLaSt+cNfhD8kwbq0K04AvJDMuejkn7iTrtpnKRaD1r6eeycBJYCY5UFjFakl+9p
	hPt4UfTmhM1U0RIPNjMABWUzsjBYi89cHlXAIwHomkHVuvnhNLLZv1qvCbmbmZ+S70TPhRjQFHRYX
	r/3F+hWTA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k6TRr-0005Jl-Fu; Fri, 14 Aug 2020 06:44:19 +0000
Received: from verein.lst.de ([213.95.11.211])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k6TRp-0005JM-05
 for linux-nvme@lists.infradead.org; Fri, 14 Aug 2020 06:44:17 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id DBA2D68CEE; Fri, 14 Aug 2020 08:44:14 +0200 (CEST)
Date: Fri, 14 Aug 2020 08:44:14 +0200
From: Christoph Hellwig <hch@lst.de>
To: Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH v2 1/8] nvme-fabrics: allow to queue requests for live
 queues
Message-ID: <20200814064414.GA1719@lst.de>
References: <20200806191127.592062-1-sagi@grimberg.me>
 <20200806191127.592062-2-sagi@grimberg.me>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200806191127.592062-2-sagi@grimberg.me>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200814_024417_184945_3A5DE3DD 
X-CRM114-Status: GOOD (  19.18  )
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
Cc: Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
 linux-nvme@lists.infradead.org, James Smart <james.smart@broadcom.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Thu, Aug 06, 2020 at 12:11:20PM -0700, Sagi Grimberg wrote:
> Right now we are failing requests based on the controller
> state (which is checked inline in nvmf_check_ready) however
> we should definitely accept requests if the queue is live.
> 
> When entering controller reset, we transition the controller
> into NVME_CTRL_RESETTING, and then return BLK_STS_RESOURCE for
> non-mpath requests (have blk_noretry_request set).
> 
> This is also the case for NVME_REQ_USER for the wrong reason.
> There shouldn't be any reason for us to reject this I/O in a
> controller reset. We do want to prevent passthru commands on
> the admin queue because we need the controller to fully initialize
> first before we let user passthru admin commands to be issued.
> 
> In a non-mpath setup, this means that the requests will simply
> be requeued over and over forever not allowing the q_usage_counter
> to drop its final reference, causing controller reset to hang
> if running concurrently with heavy I/O.

Which will still happen with the admin queue user passthrough
commands with this patch, so I don't think it actually solves anything,
it just reduces the exposure a bit.

> 
> While we are at it, remove the redundant NVME_CTRL_NEW case, which
> should never see any I/O as it must first transition to
> NVME_CTRL_CONNECTING.

That probablyly should be a separate patch.

> -		if (nvme_is_fabrics(req->cmd) &&
> +		if (blk_rq_is_passthrough(rq) && nvme_is_fabrics(req->cmd) &&

And this (make sure we don't access garbage in ->cmd for non-passthrough)
should probably be a separate fix as well.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
