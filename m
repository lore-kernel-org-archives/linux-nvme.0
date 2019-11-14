Return-Path: <SRS0=270x=ZG=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 084D1C432C3
	for <linux-nvme@archiver.kernel.org>; Thu, 14 Nov 2019 04:57:03 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DEF5B206EF
	for <linux-nvme@archiver.kernel.org>; Thu, 14 Nov 2019 04:57:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="s7jUV4wt";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nlfxm6aG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DEF5B206EF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=yAbDrSAEKUBTXLpeGoolV+KmPkpw2e1k9SH87z8NWJY=; b=s7jUV4wtgpjmsU
	v/mmR/UfcYPpd4QIBzM75THDwFktSzybVNGWMuQEjDx7P9Cm5n9x1LpqSgXfJlhKigtK5tQHXJHRX
	CxiYyZp1nl8ur4NfRF8RuGxj2J2EGVmIqsqQBhdcdP4/X5t5d6gH0IXsWCZdrC6t6ncWQkT68b99W
	0krxvhwh2/iKMyy/knJG5dZQ0zCG4CCCCa4+MPIU4Xw9sTpMn3Gd8eXMhYbcd7eN/IoEI+mdMLeQ3
	MEQL3x+ZOS7alFVYcg+nIF24c07Zt6u4QmJOXFoc5dicgkSHeRz1h/zXLdwUxQu2netx3uIi/th+r
	YfxbdNiSuSlRqf//qlpQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iV7BY-0000UD-54; Thu, 14 Nov 2019 04:56:48 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iV7BW-0000Tp-GB
 for linux-nvme@lists.infradead.org; Thu, 14 Nov 2019 04:56:47 +0000
Received: from C02WT3WMHTD6 (rap-us.hgst.com [199.255.44.250])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 44305206EF;
 Thu, 14 Nov 2019 04:56:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1573707405;
 bh=ZybG0U1xdPivojU1aM7/ARWNkO4aTSHoq2U65hEhQM8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Nlfxm6aG8zxVLFEigistX/daoshfuGSG0pvD2Xs5rmu51b/JqTNCQjJ4RdEyRvjl3
 r7Rb8NbwWOa+zDmzeqbxzwnR0xiTIKKiVG2vWDcAUa5brAtUXW6Y0ImeZm4D1JSwhh
 xxDYRHjUlfY/V8jvkEFSDid2Qep3559LSvDOxiSo=
Date: Wed, 13 Nov 2019 21:56:43 -0700
From: Keith Busch <kbusch@kernel.org>
To: Ming Lei <ming.lei@redhat.com>
Subject: Re: [PATCH V3 2/2] nvme-pci: check CQ after batch submission for
 Microsoft device
Message-ID: <20191114045643.GA97802@C02WT3WMHTD6>
References: <20191114025917.24634-1-ming.lei@redhat.com>
 <20191114025917.24634-3-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20191114025917.24634-3-ming.lei@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191113_205646_564306_BE2EF245 
X-CRM114-Status: UNSURE (   8.76  )
X-CRM114-Notice: Please train this message.
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
Cc: Sagi Grimberg <sagi@grimberg.me>, Long Li <longli@microsoft.com>,
 linux-nvme@lists.infradead.org, Jens Axboe <axboe@fb.com>,
 Nadolski Edmund <edmund.nadolski@intel.com>, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Thu, Nov 14, 2019 at 10:59:17AM +0800, Ming Lei wrote:
> @@ -912,6 +917,10 @@ static blk_status_t nvme_queue_rq(struct blk_mq_hw_ctx *hctx,
>  
>  	blk_mq_start_request(req);
>  	nvme_submit_cmd(nvmeq, &cmnd, bd->last);
> +
> +	if (bd->last && test_bit(NVMEQ_CHECK_CQ, &nvmeq->flags))
> +		nvme_check_cq(nvmeq);
> +

You've given this quirk a special completion handler, how about giving
it a special queue_rq as well. Then you can check the completion queue
during submission while holding the same lock as before.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
