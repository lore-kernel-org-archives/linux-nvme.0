Return-Path: <SRS0=Ap99=CK=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB829C433E7
	for <linux-nvme@archiver.kernel.org>; Tue,  1 Sep 2020 16:39:39 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9516C2078B
	for <linux-nvme@archiver.kernel.org>; Tue,  1 Sep 2020 16:39:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="RYJi1zZu";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="dv/qp1cv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9516C2078B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=PoaoAjwjW4llUF+nj7ixiqPQF5igi+EsiHx211UBJK4=; b=RYJi1zZuNz2TkpaFauxlQW7Ih
	BFEE2vcm+sGkUBytql0Vx7i4RpmTdSPlcLb1t2fe/EHeI/Epkbipm3QalUEdj8UC2AgNeo3S++/uP
	/ta1TCgkR/zO7c6kiF8K4CmcUYjvWpardkLuOl49JipoeYTkDUoFq/cRabtcsw2UhGPcBhYL6cpCe
	am+3bYHmINlbZ2yg54etqOtxb7+io38xSJMNBP9hyixPzhEgRR7hFF6Q7WM6Qf7vphYFzKWm4TwAT
	EiMTVSu476GV/o0PHQ+ubAbZ5Jc/NYa392dofpawfvAUmtl5pA/rxJQvhbp1LU9Qku9Ofr8BTkPUk
	s74NJRVhA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kD9Jm-0003xl-Cm; Tue, 01 Sep 2020 16:39:34 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kD9Ji-0003xJ-6m
 for linux-nvme@lists.infradead.org; Tue, 01 Sep 2020 16:39:30 +0000
Received: from dhcp-10-100-145-180.wdl.wdc.com (unknown [199.255.45.60])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 18E3120767;
 Tue,  1 Sep 2020 16:39:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1598978369;
 bh=dr8lHwwOag/AEGKr0f2JEzvp5F69En5NKrtfPtmoJsU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=dv/qp1cvjo4u1Q6QF8ETb659T0g0+yajEQdEqw8WyWSdiVqK4NIr+lbll5oPtdPCR
 i0klifYzBqWT+ycUZ7i6+OQZL/05aPSXpEQmenRQrJiL7Gw41mVsH+2iqw3NhpsQ42
 oKZ51Cvyt5xpKsGv+DOutjEoRCNUsInwthq5Po1E=
Date: Tue, 1 Sep 2020 09:39:27 -0700
From: Keith Busch <kbusch@kernel.org>
To: Xianting Tian <tian.xianting@h3c.com>
Subject: Re: [PATCH] [v2] nvme-pci: check req to prevent crash in
 nvme_handle_cqe()
Message-ID: <20200901163927.GC2831246@dhcp-10-100-145-180.wdl.wdc.com>
References: <20200831105553.1621-1-tian.xianting@h3c.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200831105553.1621-1-tian.xianting@h3c.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200901_123930_319751_CAB9176C 
X-CRM114-Status: GOOD (  13.25  )
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
Cc: axboe@fb.com, linux-kernel@vger.kernel.org, hch@lst.de,
 linux-nvme@lists.infradead.org, sagi@grimberg.me
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Mon, Aug 31, 2020 at 06:55:53PM +0800, Xianting Tian wrote:
> As blk_mq_tag_to_rq() may return null, so it should be check whether it is
> null before using it to prevent a crash.

It may return NULL if the command id exceeds the number of tags. We
already have a check for a valid command id value, so something is not
adding up here if we're still getting NULL.

>  	req = blk_mq_tag_to_rq(nvme_queue_tagset(nvmeq), cqe->command_id);
> +	if (unlikely(!req)) {
> +		dev_warn(nvmeq->dev->ctrl.device,
> +			"req is null(tag:%d) on queue %d\n",
> +			cqe->command_id, le16_to_cpu(cqe->sq_id));
> +		return;
> +	}

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
