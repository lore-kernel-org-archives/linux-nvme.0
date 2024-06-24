Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AB3DC2BD09
	for <linux-nvme@archiver.kernel.org>; Mon, 24 Jun 2024 17:36:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=jV12oB5ihWTqRR2X2S+3DUy01t
	KGIHLBfcG5Oxijz6VdQu9sqwq9EvNzogTrs8XgEngcCJEA5KTpSbCZx+LYxsPFIHzo82gtAHVyebG
	fquku/hPKq5j7GXkRCAh3/i/+7C+zP4H8Fgruti05QhV/dOx46/ztsEX4RDSXkD+WaScl62VgM2a0
	CgepJt8YJrHRytvDFeFZq9tGN5gV9eqoKP/7RlbEL4sbNEX9po+zgc20u789+4l4szR516rr6pIaC
	XjjFIDECnkH4gvcC3Sm+E2YmZkVpnD7RixENa9hPHPTUqOcLzxL3x1jVD+NbPEqAXMq/E9vtUim9h
	2DwQRz9Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sLncC-000000007Bj-3j61;
	Mon, 24 Jun 2024 17:36:28 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sLnc9-000000007BH-0cBF
	for linux-nvme@lists.infradead.org;
	Mon, 24 Jun 2024 17:36:26 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id A12D268CFE; Mon, 24 Jun 2024 19:36:19 +0200 (CEST)
Date: Mon, 24 Jun 2024 19:36:19 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@meta.com>
Cc: hch@lst.de, sagi@grimberg.me, linux-nvme@lists.infradead.org,
	Keith Busch <kbusch@kernel.org>, Nilay Shroff <nilay@linux.ibm.com>
Subject: Re: [PATCHv2] nvme-pci: do not directly handle subsys reset fallout
Message-ID: <20240624173619.GB23483@lst.de>
References: <20240624172649.2268634-1-kbusch@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240624172649.2268634-1-kbusch@meta.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240624_103625_338390_2F483430 
X-CRM114-Status: UNSURE (   7.90  )
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


