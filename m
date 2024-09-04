Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E650CD37AE
	for <linux-nvme@archiver.kernel.org>; Wed,  4 Sep 2024 04:11:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=KFt7dD2tOiC0rdww9mkr6ic3Ub
	5IYOecK4QJkDYDj8bWjPrqlWwifBIi85qnbkgLh41I/aEpcMYiZvJxvEbcur0PGIJb2ZCHbvIDcJA
	C+rf1YlIP000JfdRQVI+EbcQtrSIxgVni2dbzol76n46V0FS7ftvpYHcAskXGx5Fewwrkh8JmPcNg
	73ORtdcHKvMtL3OJWuDVEHbdyF3uBV4C4c3KSnvDH6NdfLFUeOa8I8Qz7NNMtL5YJrgNd4JXoUWdZ
	8NeaIoSsVK1jXhr7HcTX3vLigvWMRbWiKS0ENZ+PenTOkosZe1V8W12swjzRJ7KUhw56vfr1d4N86
	xPVJozLA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1slhMH-00000002kvQ-0xhU;
	Wed, 04 Sep 2024 04:11:05 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1slhME-00000002kue-1Suk
	for linux-nvme@lists.infradead.org;
	Wed, 04 Sep 2024 04:11:03 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id D06C068AA6; Wed,  4 Sep 2024 06:10:57 +0200 (CEST)
Date: Wed, 4 Sep 2024 06:10:57 +0200
From: Christoph Hellwig <hch@lst.de>
To: Eugen Hristev <eugen.hristev@collabora.com>
Cc: linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
	kbusch@kernel.org, sagi@grimberg.me, hch@lst.de
Subject: Re: [PATCH] nvme-pci: refresh visible attrs after being checked
Message-ID: <20240904041057.GA13313@lst.de>
References: <01020191b7b7adc0-bca16d06-b051-4ce2-bfee-c8038a62462f-000000@eu-west-1.amazonses.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <01020191b7b7adc0-bca16d06-b051-4ce2-bfee-c8038a62462f-000000@eu-west-1.amazonses.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240903_211102_551265_318A2745 
X-CRM114-Status: UNSURE (   9.25  )
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

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

