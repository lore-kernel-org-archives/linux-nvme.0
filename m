Return-Path: <SRS0=pUqL=YS=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3719CA9EA0
	for <linux-nvme@archiver.kernel.org>; Fri, 25 Oct 2019 04:06:13 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F42A2166E
	for <linux-nvme@archiver.kernel.org>; Fri, 25 Oct 2019 04:06:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="eSOcVacC";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="VltNE7nH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F42A2166E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=X2NT01aZdu6fYok4tBPhiCDdiVkSoT5VoPZ6dYfpFos=; b=eSOcVacCn1n80P
	o9uiOvzDVgYoF9tHwHy/APMCG3IMNXcgNZQrBuWcAm2x7SXPT5VMU6oMRBkzL10yMfcEG4B93fuDu
	6T/bTwbWKbqyOxlDyRRiyoyHrdknJW4J+30D3A/C77EOtcUM/e4o9WQwOvhgY9SO0MNU0x2rVPdi+
	hnxxXM+wa1pCBdmCm20fwFg/sAjfcCAx061Dzx6Cram1UbJY1RwBR1iJd9+RQy8IdmhGw4tHuCZ4v
	RwfsTIrN9k7sr3a7EJ0BaatsO3wzoVdOGNlrXpfGWyN3aTr9cjt49ls6xDpISAypoRCTMoo3h+Isn
	pNreFHEk273LGi8+CmAA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iNqrG-0004XN-Gq; Fri, 25 Oct 2019 04:05:50 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iNqrD-0004Wl-Ta
 for linux-nvme@lists.infradead.org; Fri, 25 Oct 2019 04:05:49 +0000
Received: from redsun51.ssa.fujisawa.hgst.com (unknown [199.255.47.7])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 174EE2166E;
 Fri, 25 Oct 2019 04:05:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1571976346;
 bh=783JW7VAD1i02CGDDYPkfY/d/W/xC/KXd7P1XEsEZiY=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=VltNE7nHSC6DJEZSHNd1m2c7eYilLS2zLbSK+f5RW9HB55h8AZ+aJh3grFPQ+5HNN
 kboBd54dE8hu/izhvpOT2Qrk7RpL372lQP/hKy9u6ODxpKY2UoaDR7A6QqZAkjOsyf
 QPOw2OcB1LJs6fyt7QqfpRKHKXfxDPx6CoSU2UXg=
Date: Fri, 25 Oct 2019 13:05:40 +0900
From: Keith Busch <kbusch@kernel.org>
To: Mark Ruijter <MRuijter@onestopsystems.com>
Subject: Re: [PATCH] nvmet: introduce use_vfs ns-attr
Message-ID: <20191025040540.GA19941@redsun51.ssa.fujisawa.hgst.com>
References: <20191023201715.4236-1-chaitanya.kulkarni@wdc.com>
 <20191024020003.GA2148@redsun51.ssa.fujisawa.hgst.com>
 <FA6B6A9F-649B-4B58-99D0-2D09076E2482@onestopsystems.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <FA6B6A9F-649B-4B58-99D0-2D09076E2482@onestopsystems.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191024_210547_979159_B4F19AD8 
X-CRM114-Status: GOOD (  10.12  )
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
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "hch@lst.de" <hch@lst.de>, Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
 "sagi@grimberg.me" <sagi@grimberg.me>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Thu, Oct 24, 2019 at 11:30:18AM +0000, Mark Ruijter wrote:
> Note that I wrote this patch to prove that a performance problem exists when using raid1.
> Either the md raid1 driver or the io-cmd-bdev.c code has issues.
> When you add an additional layer like the VFS the performance should typically drop with 5~10%.
> However in this case the performance increases even though the nvme target uses direct-io and the random writes do not get merged by the VFS.

Are we really using direct io when nvme target is going through vfs,
though? That should happen if we've set IOCB_DIRECT in the ki_flags,
but I don't see that happening, and if that's right, then the difference
sounds like it's related to buffered IO.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
