Return-Path: <SRS0=ANWg=B6=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8D7CC433E1
	for <linux-nvme@archiver.kernel.org>; Thu, 20 Aug 2020 06:09:50 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8611D2078D
	for <linux-nvme@archiver.kernel.org>; Thu, 20 Aug 2020 06:09:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="dbECI0vV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8611D2078D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=7kz4h9sVFN/+ktlyfRhBcTPa2g+jsOm4EFPxMm1+Vcg=; b=dbECI0vVBgJuhKWLGF1cQIOHr
	9QHDY9zbHdcIjcx3HVsVohsBpiSzGcyee10zxqhw9yBArBPjdh7J+gbDwYML9sHJotI/Jf+PijH5l
	WupGn494pYRDsknkUGdUvO5w00uU6fB+4bWQkw6/57u65IWz6LCNmFr5md3qnzq57eLh+fxyh2mSo
	KX4+1jqpfyRF2q3HnCRoKXgfnjCm8ztybbIAkhUltzkyAvCzFyeMynM5CS/ci2vtoh5HKn3+zja/+
	bL3Ih5hlM5vP85zvikWWNMZP14js6LyuWr7NrWvxFCmmrf3ObiFvsg0lBU3/5+PgoThvX4DiPSJjs
	7JE2nM9fg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k8dlh-0006Xv-Rr; Thu, 20 Aug 2020 06:09:45 +0000
Received: from verein.lst.de ([213.95.11.211])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k8dlf-0006X9-RQ
 for linux-nvme@lists.infradead.org; Thu, 20 Aug 2020 06:09:44 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 6D6C368BEB; Thu, 20 Aug 2020 08:09:41 +0200 (CEST)
Date: Thu, 20 Aug 2020 08:09:41 +0200
From: Christoph Hellwig <hch@lst.de>
To: Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH v3 2/9] nvme-fabrics: allow to queue requests for live
 queues
Message-ID: <20200820060941.GB6188@lst.de>
References: <20200820053651.197057-1-sagi@grimberg.me>
 <20200820053651.197057-3-sagi@grimberg.me>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200820053651.197057-3-sagi@grimberg.me>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200820_020944_029169_11BC6C5B 
X-CRM114-Status: GOOD (  20.16  )
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

On Wed, Aug 19, 2020 at 10:36:44PM -0700, Sagi Grimberg wrote:
> Right now we are failing requests based on the controller state (which
> is checked inline in nvmf_check_ready) however we should definitely
> accept requests if the queue is live.
> 
> When entering controller reset, we transition the controller into
> NVME_CTRL_RESETTING, and then return BLK_STS_RESOURCE for non-mpath
> requests (have blk_noretry_request set).
> 
> This is also the case for NVME_REQ_USER for the wrong reason. There
> shouldn't be any reason for us to reject this I/O in a controller reset.
> We do want to prevent passthru commands on the admin queue because we
> need the controller to fully initialize first before we let user passthru
> admin commands to be issued.
> 
> In a non-mpath setup, this means that the requests will simply be
> requeued over and over forever not allowing the q_usage_counter to drop
> its final reference, causing controller reset to hang if running
> concurrently with heavy I/O.

I'm still rather bothered with the admin queue exception.  And given that
the q_usage_counter problem should only really be an issue for file system
requests, as passthrough requests do not automatically get retried why
can't we just reject all user command to be symetric and straight forward?
The callers in userspace need to be able to cope with retryable errors
anyway.

>  	/*
> +	 * currently we have a problem sending passthru commands
> +	 * on the admin_q if the controller is not LIVE because we can't
> +	 * make sure that they are going out after the admin connect,
> +	 * controller enable and/or other commands in the initialization
> +	 * sequence. until the controller will be LIVE, fail with
> +	 * BLK_STS_RESOURCE so that they will be rescheduled.
>  	 */

Nit: please start multi-line comments with a capital letter.  Also I
think some of the lines do not nearly use up the 80 characters available.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
