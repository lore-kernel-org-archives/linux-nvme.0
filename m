Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BBCBE98FD0
	for <linux-nvme@archiver.kernel.org>; Thu,  9 Apr 2026 06:32:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=BH7+ZlJpxpPSCdYTQpu7JDrSqF
	4l38yyg+Kb6lNaIAOrw1xm3YsVaW2t6Snv0uwuEtl6rvY6w/uhaeEcmS3UYFZ2uCebvFSMk6d3Dlt
	8cCyQALcJAAtVtCBchF9mFLM4euiaTXYUtX2tV6XtvIEXD1KNq7aD23TrxFipnbgzZvbXunQC81ej
	800C5cHfIJqm68lPqYf2Q0OGyWtdxdudpPcLLiyaZ7hBHIqcQnQwgDCf8Y6ek3NrP1qc0l/ZDhbs9
	KkDbOxJVid+6CROWvtWuIZgDpG88drimHXjYj1f7xp4DYwzW52l04fLR6sc320/awSOZMV2FUV6QY
	Fe10WZfw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wAivz-00000009mKI-1BVv;
	Thu, 09 Apr 2026 06:32:11 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wAivx-00000009mJl-1ivv
	for linux-nvme@lists.infradead.org;
	Thu, 09 Apr 2026 06:32:10 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 6DC3D68BFE; Thu,  9 Apr 2026 08:32:05 +0200 (CEST)
Date: Thu, 9 Apr 2026 08:32:04 +0200
From: Christoph Hellwig <hch@lst.de>
To: Daniel Wagner <wagi@kernel.org>
Cc: Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>, Hannes Reinecke <hare@suse.de>,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] nvme: expose TLS mode
Message-ID: <20260409063204.GA7788@lst.de>
References: <20260408-expose-tls-mode-v3-1-b869da028eff@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260408-expose-tls-mode-v3-1-b869da028eff@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260408_233209_583726_066D764A 
X-CRM114-Status: UNSURE (   9.05  )
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

