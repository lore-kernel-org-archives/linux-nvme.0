Return-Path: <SRS0=Gu9/=BD=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD609C433E3
	for <linux-nvme@archiver.kernel.org>; Fri, 24 Jul 2020 19:34:05 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D879206D7
	for <linux-nvme@archiver.kernel.org>; Fri, 24 Jul 2020 19:34:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="2+p4nagn";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="yIvtZ+7q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D879206D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=0X9fElKci5djqzU0/Kvr/29raKjU4Bd9nj4REpBVXoA=; b=2+p4nagnQW0nglB6SPyI5oj0s
	h02YB3zOMOBPZlV49eOBzokYNEXu0JamFmGl+MNVnHPU+rl1L2ygM41sOxomwgn0yLm4CxCH6qC1x
	U5/rel3B9eeJpa8uEOBUn+Qy+YB8WPZMkkHu8u5mc/qYY4eBbpozhueS/XhfkJ6dnNdmS66rwWmqM
	7WzsLUIPogSAjTD6/YMzzgRyUPOfnhQBChf4kFj6WEG33pifOtOIZh25jifHu8xAaBPGvjQaHFCem
	94lI3KcTLeRMMt0dGuwvCPCft8YjDPC1UuCgYuAzRXF343bAa+9Y3EesSuc20/pay99CEu9qIZeEC
	FpwKxxtsQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jz3S9-0003HF-Mg; Fri, 24 Jul 2020 19:33:57 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jz3S7-0003Ga-Bk
 for linux-nvme@lists.infradead.org; Fri, 24 Jul 2020 19:33:56 +0000
Received: from dhcp-10-100-145-180.wdl.wdc.com (unknown [199.255.45.60])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 3247E206F6;
 Fri, 24 Jul 2020 19:33:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1595619233;
 bh=s5Pq4+FkzTO2HXeCm8z0SJMPOsSTRJlA1F4DZgLYN/Q=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=yIvtZ+7quaXQuQVKxcGyfJkgORWLVgyZEvgUt3L9Qy6wPKcv5JXSv9CJw8mX6rpPo
 ln7POMC62kiPDLQSOifNTEOSknHkwS89tW83OQrFMKfdPVVs/3Xxeqvl4VH6cpYRMX
 wIocWzdrKGQGThstNc0JvAKZYZ+QSpQZMf0R1L8w=
Date: Fri, 24 Jul 2020 12:33:51 -0700
From: Keith Busch <kbusch@kernel.org>
To: Logan Gunthorpe <logang@deltatee.com>
Subject: Re: [PATCH v16 6/9] nvmet-passthru: Add passthru code to process
 commands
Message-ID: <20200724193351.GA2857771@dhcp-10-100-145-180.wdl.wdc.com>
References: <20200724172520.16318-1-logang@deltatee.com>
 <20200724172520.16318-7-logang@deltatee.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200724172520.16318-7-logang@deltatee.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200724_153355_490714_8BB08F6A 
X-CRM114-Status: GOOD (  10.42  )
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
 Jens Axboe <axboe@fb.com>, Max Gurtovoy <maxg@mellanox.com>,
 Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Fri, Jul 24, 2020 at 11:25:17AM -0600, Logan Gunthorpe wrote:
> +	/*
> +	 * The passthru NVMe driver may have a limit on the number of segments
> +	 * which depends on the host's memory fragementation. To solve this,
> +	 * ensure mdts is limitted to the pages equal to the number of

                          limited

> +	/* don't support fuse commands */
> +	id->fuses = 0;

If a host were to set a fuse, the target should return an Invalid Field
error. Just to future-proof, rejecting commands with any flags set
(other than SGL, which you handled in patch 1/9) is probably what should
happen, like:

> +u16 nvmet_parse_passthru_io_cmd(struct nvmet_req *req)
> +{

	if (req->cmd->common.flags & ~NVME_CMD_SGL_ALL)
		return NVME_SC_INVALID_FIELD;

Or maybe we could obviate the need for 1/9 with something like:

	req->cmd->common.flags &= ~NVME_CMD_SGL_ALL;
	if (req->cmd->common.flags)
		return NVME_SC_INVALID_FIELD;

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
