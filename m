Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DB0BC88E50
	for <linux-nvme@archiver.kernel.org>; Fri, 11 Sep 2026 15:03:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=NtWTVquGIF6A3jVgsjHgY3Sb9j0F5MYubIQ9/EHOvQ4=; b=DQSG0GoeS/8JNGux9y006ZKRYN
	8fO0ApJ2j6CJDlr2ojp8kF6n0Jz2ZD89vhWHb+25zIilpT2mgytGiGzUDtHaWjdLxNI0tZhOi3mtL
	41nMHQRKlYE+/dDMYE81qOlK0OckneeXN187pUiQ4r3XydBgs9uvTzoGw7wLjZLzm6BFq7GmLtU0W
	d93mg0fJLo1Rxr/yo2JeCUskdJh1ToPb+vYPK6ohbFBdRqKakmrPqWeAjpf498EGG5unvpCIlDgQy
	Vdt0yzjZqU1h6Rty9T69HC6sGDiPJJSieb+Qi0LUwyqzEhCIObwJJTAh0pQvC6neZhPIUk240EyZ3
	uTzZJRkg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x52me-0000000Gzcg-0uRL;
	Fri, 11 Sep 2026 15:03:20 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x52ma-0000000GzcB-222l
	for linux-nvme@lists.infradead.org;
	Fri, 11 Sep 2026 15:03:18 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 9A4506020C;
	Fri, 11 Sep 2026 15:03:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E05841F000FF;
	Fri, 11 Sep 2026 15:03:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789138995;
	bh=NtWTVquGIF6A3jVgsjHgY3Sb9j0F5MYubIQ9/EHOvQ4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=LbeM/JGDab4DkMoCpxVqado8u3MP6yLSvHpLbQ4FUMItpdQcRqigTnx8wo6TiVOZd
	 ThLZCyAvqZ3luvs/fQjZ2d91xu1grVyRt06tGtKGGnM0DGmNMW7Cucdl2mMse3ZprU
	 AO7BrUZ3/cl5ZIJ2ZT6amT3b5eWeV7CbuB2EamKsPAtMxSmKUPYDFebRTlupM3q4GN
	 ZF0dPrA4RRdB27/PhV0QsAxoEdq2NIcEuLqf1PBM+iPQ9k81nf+pRfPIvLQSMThdiJ
	 CyTi0jFugvJnKME8Ia1W1T1QeFvr+9U86Co11at3jOQfyl2ZiOn7U+yeqtCyZeRtG4
	 2qj8UZPVIMtlA==
Date: Fri, 11 Sep 2026 09:03:13 -0600
From: Keith Busch <kbusch@kernel.org>
To: Bean Huo <beanhuo@iokpp.de>
Cc: linux-nvme@lists.infradead.org, hch@lst.de, axboe@kernel.dk,
	sagi@grimberg.me, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, bob.beckett@collabora.com,
	Bean Huo <beanhuo@micron.com>, Gaurav Sinha <gsinha@micron.com>
Subject: Re: [PATCH] nvme-pci: add NVME_QUIRK_DMAPOOL_ALIGN_512 for Micron
 4100AT
Message-ID: <aqQYMR2uaKcHosYD@kbusch-mbp>
References: <20260904105155.1402065-1-beanhuo@iokpp.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260904105155.1402065-1-beanhuo@iokpp.de>
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
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Fri, Sep 04, 2026 at 12:51:55PM +0200, Bean Huo wrote:
> From: Bean Huo <beanhuo@micron.com>

...

> Signed-off-by: Gaurav Sinha <gsinha@micron.com>
> Signed-off-by: Bean Huo <beanhuo@micron.com>

I've applied the patch as-is, however usually the first "Signed-off-by"
is who the patch is attributed to as being "from".

Thanks, applied to nvme-7.3.

