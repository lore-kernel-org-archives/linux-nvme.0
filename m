Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4970C021A7
	for <linux-nvme@archiver.kernel.org>; Thu, 13 Feb 2025 05:59:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=QaN7AByJync8djg2pzMJZQBMz+
	LdKs8AcLxSe8hwVTNaUFgA/O0ytQI/eLjqkIY+jcErRpv1FW1YmpMElzf62oG2RYHCkCvb+/ewQQ/
	dXW6jcbEo+fx2UsmcX3Vw2uUCVFyLpEMVVctDG+HmrgZym8RmR9uWfrPpmDAwhgMu62WUqCukjFvp
	rUsqHe+VLwt0EOsdnUvslRNVr3ErWYfQutgyoSMKlq6q7aRDi3Nk6B270sXeyFUTdWmZU0K/1CUOC
	7CAbD1N9QnEANmJZZTdj89cdxiLh/NsT19w/+G2Yy8gBvATrAhBJ/PF3z1i60f5lXPvkTTclKXYFs
	iDKVRGbg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tiSFz-00000009roZ-3V0q;
	Thu, 13 Feb 2025 05:59:27 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tiSFw-00000009rnS-3NbG
	for linux-nvme@lists.infradead.org;
	Thu, 13 Feb 2025 05:59:25 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 6E58B67373; Thu, 13 Feb 2025 06:59:21 +0100 (CET)
Date: Thu, 13 Feb 2025 06:59:21 +0100
From: Christoph Hellwig <hch@lst.de>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: linux-nvme@lists.infradead.org, Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH 1/3] nvmet: pci-epf: Correctly initialize CSTS when
 enabling the controller
Message-ID: <20250213055921.GA19506@lst.de>
References: <20250210002815.1744205-1-dlemoal@kernel.org> <20250210002815.1744205-2-dlemoal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250210002815.1744205-2-dlemoal@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250212_215924_980091_50DD63E1 
X-CRM114-Status: UNSURE (   8.83  )
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


