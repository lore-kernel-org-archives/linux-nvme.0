Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43F2BC79FB7
	for <linux-nvme@archiver.kernel.org>; Thu, 10 Sep 2026 05:42:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=DmCMJvvUCRLi4PKSvMBevMOVuD
	0y1dapjXtZ/aCF7IwN2oiSUBrwUWsa795YKcVGFirUvdK59DIGQzftt3vg6yL6ywbgN7+OxQ6zgK5
	nT5qV9nNeYroEsE72mx7mwhSbRwai0THxN6B2OSmpb+1TnvJcAKPRTZgbxNqogmGWlGAwNax9nvER
	zTWVuAA1ami74npI4GBTNJ1gOnAy6VH1652w/qNjPS4AMsUFuGKLIHVIC9Nou9Xv0q2AbNn/oStJ/
	fwedv39KgEG/Nr9NZfGREvPk9u0JGVGoN16q/Rd/oMrII8eFDQzTUwDYmDt8u+5G0qLKY0Dm+nG98
	7tifsVlg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x4XYB-0000000DT7n-1GNv;
	Thu, 10 Sep 2026 05:42:19 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x4XY8-0000000DT7D-2DPH
	for linux-nvme@lists.infradead.org;
	Thu, 10 Sep 2026 05:42:17 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 231C268BFE; Thu, 10 Sep 2026 07:42:12 +0200 (CEST)
Date: Thu, 10 Sep 2026 07:42:11 +0200
From: Christoph Hellwig <hch@lst.de>
To: Julian Sun <sunjunchao@bytedance.com>
Cc: linux-nvme@lists.infradead.org, hch@lst.de, sagi@grimberg.me,
	kch@nvidia.com, armenx.baloyan@intel.com,
	james.p.freyensee@intel.com, ming.l@ssi.samsung.com
Subject: Re: [PATCH 1/2] nvmet: preserve device path on allocation failure.
Message-ID: <20260910054211.GB27511@lst.de>
References: <20260908033519.2721210-1-sunjunchao@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260908033519.2721210-1-sunjunchao@bytedance.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260909_224216_706051_3B1E863B 
X-CRM114-Status: UNSURE (   8.87  )
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


