Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9865C43334
	for <linux-nvme@archiver.kernel.org>; Wed, 22 Jun 2022 10:26:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xBM3SjSADpCtaGTcU20MqvmhiyUnvgFDR0aC/pBuNI4=; b=JkYIYcbEMuTU3QpFft82eDjKfd
	lHY+qdCcilnvidwIqxO0ZNBH6zCE08IjOt86uI2bxpNIFCwk8gYcryBhG4YYuttJIUAZO8dc3PSVK
	mZQRoUgCMBKDuMjjZqvFLOlEZBoDCL/YeCrkWj+YPecwMorPEaDDR5mpXJvfhAzd8hThZCRL1Jp8Y
	PGWQnLSBZgbBkMS+E/yzcNY/7D1W90GPQD43TiM2SVQ7E50m8BhWgVaz+q+Koc0HfZSzJVFoXvRdt
	Anw4esKu2pxDFM8rjeuMcgGVcxbpaUTOdWsyETv31p8GAD7Ma57VmjQaaKBXa5Ca/B72GbiGdJF4f
	0dnbAbFw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o3xYw-009stx-OV; Wed, 22 Jun 2022 10:26:18 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o3xYm-009smQ-Ta
	for linux-nvme@lists.infradead.org; Wed, 22 Jun 2022 10:26:10 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 0DF4368AA6; Wed, 22 Jun 2022 12:25:58 +0200 (CEST)
Date: Wed, 22 Jun 2022 12:25:57 +0200
From: Christoph Hellwig <hch@lst.de>
To: Joel Granados <j.granados@samsung.com>
Cc: hch@lst.de, kbusch@kernel.org, gost.dev@samsung.com,
	linux-nvme@lists.infradead.org, joshi.k@samsung.com
Subject: Re: [PATCH v3] nvme: Fix CRMS masks for TP4084 - Time-to-ready
Message-ID: <20220622102557.GA27077@lst.de>
References: <CGME20220621070724eucas1p186a9c118c37b140e60c2d1f8cacf636a@eucas1p1.samsung.com> <20220621070500.1381155-1-j.granados@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220621070500.1381155-1-j.granados@samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220622_032609_120935_6CFF199B 
X-CRM114-Status: UNSURE (   7.31  )
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

Thanks,

applied to nvme-5.19.

