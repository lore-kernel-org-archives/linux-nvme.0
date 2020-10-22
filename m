Return-Path: <SRS0=3deH=D5=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69AAEC388F2
	for <linux-nvme@archiver.kernel.org>; Thu, 22 Oct 2020 13:37:19 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BCF1C222E9
	for <linux-nvme@archiver.kernel.org>; Thu, 22 Oct 2020 13:37:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="y08iVFbL";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="vK5Mcfgd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BCF1C222E9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=dfGG15TSfoH4hmmKRcLWihZO8neJKQHikyutt3jxdeY=; b=y08iVFbLydWQhHebBoqry2o9R
	3W55hD8A1Sj/GMel6WECKSkIiCc5VsrnkSb/ewOecf40AVXg5AaOg2/RLccwPtYSz0mt4SnUPUlmh
	P6xIm3UnWhCQuJisrNb1Qawl26afolkoyLZ7m68fOMwfIp0PBMdt8wRmC4qmvx41StqttTAgv+2cX
	haKcMxKewJABo/FzZFnkk6yN/jYUUKgQp/gnlivWgeEEAlsE8PXmR9v8LyDREQoSps9FzdLpSdzKs
	oRCm5Glb+KgMLQg+URFS81JZvwY7jIm/hau39zHY5ezyqbDZV6X0OzPA0D33zKw7BG+x8tx2sziF/
	iE4SvQE+A==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kVamG-0001l0-L0; Thu, 22 Oct 2020 13:37:12 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kVamD-0001j7-Hj
 for linux-nvme@merlin.infradead.org; Thu, 22 Oct 2020 13:37:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=Sq5FTZdZCuJGAIiKXu3zLR9CZVx0uxX1AdIquLrEsgI=; b=vK5McfgdzmEpFcPF1wbWLolJnq
 Fb1NOisWHJTc6QmVOLuxYjjFGVagJkvXO+W5xzvCemPY6Me7KWpbfnKbpMKHkcCQtfeDTz0Stt5Ni
 zIjqRXiREi2DyMmNUCqzkUAFhnEOWewYuJVRR0tJP4MFqVUv3JvUEPz61+SPQm/LyLQrv7L5RlH/E
 vRdYhGgopp2/iQLkZQshYfJhCMz7F+B8hyF7TYRIJP1FDp5xhzh6bSYfwrMlJekhW1xzrHhgwXuHX
 u9XL8nb2IxDuLQcKtBc4Hk+s2fyB6SHI/9nHX1osw+S3iYSPbt4uWAZuPZvHq4F3L98NO6blqaVb7
 wnDPobWg==;
Received: from verein.lst.de ([213.95.11.211])
 by casper.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kVaes-0007Hr-Ag
 for linux-nvme@lists.infradead.org; Thu, 22 Oct 2020 13:29:37 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id A37DC68B05; Thu, 22 Oct 2020 15:29:30 +0200 (CEST)
Date: Thu, 22 Oct 2020 15:29:30 +0200
From: Christoph Hellwig <hch@lst.de>
To: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: Re: [PATCH V2 1/1] nvmet: don't use BLK_MQ_REQ_NOWAIT for passthru
Message-ID: <20201022132930.GB8969@lst.de>
References: <20201020231404.9365-1-chaitanya.kulkarni@wdc.com>
 <20201020231404.9365-2-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201020231404.9365-2-chaitanya.kulkarni@wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201022_142934_530086_EAAC0C25 
X-CRM114-Status: UNSURE (   7.66  )
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
Cc: kbusch@kernel.org, logang@deltatee.com, hch@lst.de,
 linux-nvme@lists.infradead.org, sagi@grimberg.me
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Thanks,

applied.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
