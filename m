Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDF57C77B78
	for <linux-nvme@archiver.kernel.org>; Wed,  3 May 2023 16:24:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=YZ3bFcVqPhta2kbqEtRw204ZWP42lGO0o/HgLJRinAQ=; b=iZ3Ui/s70cu3iMHxQxylZlkJOc
	T2oy/dOGFa5HK/11KgODbPp1riZf44pUirMNHefW9jRZp65Jyp322JLU6fynmKiq6QCUmj2bwHkOV
	ZGmM+kp//ov2XsEnVomGaWQ4m+9Zcxgxp01Jtdk9zTINszH5T30Dn8SK4tY8X1W0xlo2UJLV6KW+t
	+UFuyXulkKJ+uGVWhGcAa9IJChNXrD5Runj1y5pHCdkpy4WBnvM0Dc/E8wP3al4H6UI5DPa51qpU3
	Tvn2TKxi1979zsFs+KXDbOOGsAMSiulQ9dTXmTfNbsAy84amGbwrbZmDJzTp3AlYhquZlajUcUu+C
	Nfo0VIWQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1puFGw-0054hJ-0V;
	Wed, 03 May 2023 16:24:06 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1puFGt-0054ga-2l
	for linux-nvme@lists.infradead.org;
	Wed, 03 May 2023 16:24:05 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 6D40468B05; Wed,  3 May 2023 18:24:00 +0200 (CEST)
Date: Wed, 3 May 2023 18:24:00 +0200
From: Christoph Hellwig <hch@lst.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Andrey God <andreygod83@protonmail.com>
Subject: Re: [PATCH] nvme-pci: add NVME_QUIRK_BOGUS_NID for HS-SSD-FUTURE
 2048G
Message-ID: <20230503162400.GA2088@lst.de>
References: <20230503155733.866408-1-sagi@grimberg.me> <20230503162322.GA2028@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230503162322.GA2028@lst.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230503_092404_034918_DC4F0FE0 
X-CRM114-Status: GOOD (  12.36  )
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

On Wed, May 03, 2023 at 06:23:22PM +0200, Christoph Hellwig wrote:
> Thanks,
> 
> applied to nvme-6.3.

nvme-6.4 even.

