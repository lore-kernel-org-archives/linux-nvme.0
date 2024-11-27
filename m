Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B003D6ACF0
	for <linux-nvme@archiver.kernel.org>; Wed, 27 Nov 2024 15:48:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nfxV7hkFAKG1s2/PJky7VvEDOCVAmoJ1WMegje3F+sw=; b=0gOVwrh9Z5lJxsgclqcCVHn4D0
	QFT+oInTo3ib2rXFoGAZhMq7GPwWSMv5o9fOzEysrWhTFDpXUEb6LWUu/azs191k4jHUFAtkJQ7IH
	FKVJI9396OLSztb71FeZU6p+uRwtfXTuJOeS+u1kZsgS7aHMmr7C+zZoboJuKBY9tsuYFVeMtWhoW
	kzb9g4Df6BhFqtyXpP3+RLAl39l9hdE2xELXKSgpTMv2ejfTTpzMPGjXvzIus4m0zy4o8QxVB1h8T
	Bl8AbBEROhMKAbRqMfOHfRcF3pczC6rBgeNcLpe/q/GfCtAx5hG4iZYs4e50UBunuaol+ymT2GSpD
	TxjaKr9w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tGKH8-0000000DY46-25Ps;
	Wed, 27 Nov 2024 15:48:22 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tGKH4-0000000DY3l-2ouJ
	for linux-nvme@lists.infradead.org;
	Wed, 27 Nov 2024 15:48:20 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 4323468D0E; Wed, 27 Nov 2024 16:48:13 +0100 (CET)
Date: Wed, 27 Nov 2024 16:48:12 +0100
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, sagi@grimberg.me, axboe@kernel.dk,
	linux-nvme@lists.infradead.org,
	Saeed Mirzamohammadi <saeed.mirzamohammadi@oracle.com>
Subject: Re: [PATCH] nvme: don't apply NVME_QUIRK_DEALLOCATE_ZEROES when
 DSM is not supported
Message-ID: <20241127154812.GA24372@lst.de>
References: <20241127064218.42688-1-hch@lst.de> <Z0c-gFbw4n0SaKD9@kbusch-mbp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z0c-gFbw4n0SaKD9@kbusch-mbp>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241127_074818_850674_2D067176 
X-CRM114-Status: GOOD (  16.29  )
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

On Wed, Nov 27, 2024 at 08:45:04AM -0700, Keith Busch wrote:
> I still think this is wrong, and we should just remove the quirk for
> this device. With the exception to this firmware version, this device
> generally supports both discards and write zeroes. The only reason it
> added this quirk was because the quirk used to mean something completely
> different (specifically, it would set the "discard_zeroes_data"
> attribute that's no longer used). It didn't mean to prefer discards over
> write zeroes, but that's what it means now, and that's not what this
> drive wants.

I'll have to trust you on this device, and certainly won't object
removing this weirdo quick.  But as long as we don't remove the
quirk entirely we'll also need this fix.  So I guess we should go
for both?

