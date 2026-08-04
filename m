Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC5C9C55184
	for <linux-nvme@archiver.kernel.org>; Tue,  4 Aug 2026 16:30:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=MbYV/qV6qRxMH0K9atBnPjNPcX
	xqj1TL1pNvuKk0KGdc3ddHOCVYp7A9IZLS6RHSxER+E1sr+uBOFAbG0tSQyKJL3ifxgY6PRPT/zyQ
	JcYx0Nwi2un8GrhtJeM1IJuxtGyAJxyOGcQitNQKms9ZgGbnzPlOBilpTyWAap1DFpLq33aCx5Sjz
	9FIl+7kb8FmeWPIcV1SzsQxav/RyamwIoUPVQXSiL4elujT3OVybIaO/SeDNSmNCumLg/Wu0DN6XD
	iijN17J1K08yiJwGN/hiN/0J1YoM+dpsFFEcGQCtMhsqN966TrRIg/Rzc+wiqyYJi/Tj8Y2CIWhIJ
	xne5FCvw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wrI1k-00000002Kic-1zOl;
	Tue, 04 Aug 2026 16:30:04 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wrI1i-00000002KiB-1WNk
	for linux-nvme@lists.infradead.org;
	Tue, 04 Aug 2026 16:30:03 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 30B526732A; Tue,  4 Aug 2026 18:29:58 +0200 (CEST)
Date: Tue, 4 Aug 2026 18:29:57 +0200
From: Christoph Hellwig <hch@lst.de>
To: Zhengrong Li <zhengrong_li@linux.alibaba.com>
Cc: linux-nvme@lists.infradead.org, hch@lst.de, sagi@grimberg.me,
	kch@nvidia.com, mlombard@arkamax.eu, kanie@linux.alibaba.com
Subject: Re: [PATCH v4] nvmet: fix Reservation Register Replace for
 unregistered host with IEKEY
Message-ID: <20260804162957.GA12628@lst.de>
References: <178521959386.52051.17173420094473200063@linux.alibaba.com> <178527555910.84385.14037905470970123793@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <178527555910.84385.14037905470970123793@linux.alibaba.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260804_093002_540836_A2930FF2 
X-CRM114-Status: UNSURE (   8.77  )
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


