Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CD28C2BD09
	for <linux-nvme@archiver.kernel.org>; Thu, 27 Jun 2024 06:23:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4U7n/tF1igQ8AmhG4GsA42ydDBVpBVaxXnqO8or4aPY=; b=FaqflWOcqCapn5tMzEiT5kd7Kr
	eV5H8/0pujKXHbAx6OBpPVAiww8ORDWWuJCFN/HeSMCTSQG1E5hu1s2FC/beCadT7iEFR+4lZiIdA
	RCVym8B16n0HyhYmdGHLiwSteC+8SCfPIw1WQiyl5lRcLjzTd2EjQrZaIAHTVCamEDJcPkM+eE/DQ
	jsONgkBJg3OSLGKXMOPx/l1AybDUfhKaCB/LQgZXP+rvoBLFXTsDn+tDhMfNidcbe7mevwd7Xg7Su
	bFl/U/ELHMtZnbGOUC1VwGff5B5G9rgRnxSqP5HxhXEpIo3v2ObGcM9cCAuu64ey++qdgiTlLjRnv
	VCzAR5/w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sMiXB-00000009NCy-2lWk;
	Thu, 27 Jun 2024 06:23:05 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sMiX8-00000009NC5-12Ps
	for linux-nvme@lists.infradead.org;
	Thu, 27 Jun 2024 06:23:03 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id B9ECF68AFE; Thu, 27 Jun 2024 08:22:59 +0200 (CEST)
Date: Thu, 27 Jun 2024 08:22:59 +0200
From: Christoph Hellwig <hch@lst.de>
To: Anuj Gupta <anuj20.g@samsung.com>
Cc: asml.silence@gmail.com, mpatocka@redhat.com, axboe@kernel.dk,
	hch@lst.de, kbusch@kernel.org, martin.petersen@oracle.com,
	io-uring@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org, Kanchan Joshi <joshi.k@samsung.com>
Subject: Re: [PATCH v2 07/10] block: define meta io descriptor
Message-ID: <20240627062259.GD16047@lst.de>
References: <20240626100700.3629-1-anuj20.g@samsung.com> <CGME20240626101523epcas5p2616cf568575685bd251d28fc1398d4cd@epcas5p2.samsung.com> <20240626100700.3629-8-anuj20.g@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240626100700.3629-8-anuj20.g@samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240626_232302_445323_6FDF07F4 
X-CRM114-Status: UNSURE (   8.26  )
X-CRM114-Notice: Please train this message.
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

> +struct uio_meta {
> +	u16 flags;
> +	u16 apptag;
> +	struct iov_iter iter;
> +};

Everything else in the kernel uses app_tag instead of apptag, maybe
follow that here.

What flags go into flags?  Should this be a __bitwise type?
Also bio.h is used by every file system and all block drivers.
Should this be in bio-integrity.h instead?


