Return-Path: <SRS0=hCdm=2C=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BBE5C2D0C9
	for <linux-nvme@archiver.kernel.org>; Thu, 12 Dec 2019 15:47:56 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 60AA222527
	for <linux-nvme@archiver.kernel.org>; Thu, 12 Dec 2019 15:47:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="YQiKktXK";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="oe1rd8F5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60AA222527
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=23MnkdPh/blATnT0TpjE9Yu0xW996ZGkVgH7LeVAtJk=; b=YQiKktXKQrnGKF
	6FrKeZa1bFaxRZRUpiHAWVhrNP5+LjRbBvW7VfvmZkrwOk34lW19D1FrpkXInH4UH2Umcg+lwRGO2
	nne0P6J5pN7n8X4zLymuCCg1Hw8q2jhOJW8/N18zgpY9wf5Rk+1x/ZDlDXV3Q8hnrA3d4xOtxadcT
	cGP8OiMMipdzFdMwfYMea3dOJ0KqXS/sq90K76gtKlp6dk/ZFiHShMLXI+wuWyu390foQe6xnn6/B
	7VDBfLx1IYqEyQHT8h/ZL1Njtc9ymKJ+BvL7kV3M6tNTTKG9d0s3Nt2o8h4eE2sk+V27F4Zs168XZ
	DmXEATVxJ+aflfXmEUBg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1ifQh0-0002qm-MF; Thu, 12 Dec 2019 15:47:54 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1ifQgx-0002qH-2p
 for linux-nvme@lists.infradead.org; Thu, 12 Dec 2019 15:47:53 +0000
Received: from redsun51.ssa.fujisawa.hgst.com (unknown [199.255.47.7])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 36CE2214AF;
 Thu, 12 Dec 2019 15:47:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1576165670;
 bh=aCeyeWbAjI6+MrwroIhu0h6KNUchxY9YMnO+ynW2I7Q=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=oe1rd8F5DcdKTm48lFMGBmWcMQHTHtOfvriQOmhmkb2gbu+AbY5laFqT7sjLfmQ5B
 34LFcUwZxZTdSpeSy+JQ7NAi4SKkpDXBmpmFzK9lw/o27+7qwuQEErcZP69Y0x1wov
 fHSESJKM90d23PVhlmR9D8XEOjQEoFU4ts8sZDs4=
Date: Fri, 13 Dec 2019 00:47:47 +0900
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] nvme/pci: Remove last_sq_tail
Message-ID: <20191212154747.GB30534@redsun51.ssa.fujisawa.hgst.com>
References: <20191205200825.27651-1-kbusch@kernel.org>
 <20191212092013.GE2399@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20191212092013.GE2399@lst.de>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191212_074751_976130_7A29158A 
X-CRM114-Status: GOOD (  14.21  )
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
Cc: sagi@grimberg.me, linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Thu, Dec 12, 2019 at 10:20:13AM +0100, Christoph Hellwig wrote:
> On Fri, Dec 06, 2019 at 05:08:25AM +0900, Keith Busch wrote:
> > We don't allocate enough tags to wrap the submission queue. Remove
> > tracking for this condition.
> 
> We can totally wrap the sq - just a single command at the end of
> the SQ will wrap it.  We are however never going to wrap it around
> to the point that we'll overwrite other unsubmitted entries.  So
> I think you change looks good, but the commit log needs a better
> explanation.

Right, I mean "wrap" to indicate the tail passes the head.
 
> > @@ -502,8 +492,7 @@ static void nvme_commit_rqs(struct blk_mq_hw_ctx *hctx)
> >  	struct nvme_queue *nvmeq = hctx->driver_data;
> >  
> >  	spin_lock(&nvmeq->sq_lock);
> > -	if (nvmeq->sq_tail != nvmeq->last_sq_tail)
> > -		nvme_write_sq_db(nvmeq, true);
> > +	nvme_write_sq_db(nvmeq);
> >  	spin_unlock(&nvmeq->sq_lock);
> 
> Also this change means we now always submit in commit_rqs.  This makes
> total sense as we only commit after having submitted commands, but it
> is another thing worth mentioning in the commit log.

Yes, will update the comments.

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
