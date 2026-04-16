Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AD21F433E2
	for <linux-nvme@archiver.kernel.org>; Thu, 16 Apr 2026 05:15:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=Ay+NaFgbZhRSOMEODrnle9a4uh
	JE3+V6l3gFKpOqFU1BIOZU2DRNX0xTxQfzR4zrEeQsFZ9rSecZpSnH9F7GH/+2On9YZJNy1YYOGPU
	QPvO8TxCmnmualUnyaw8wsxMqyAvhFHrAksuIZedfS5YlIIImDZWSpGZSG9VZOuCu8TeRmk9Kzw+W
	Cy+c/rfU592Dl+okCwH+qR/L5nUR2H3K768pitNpXjyPkgnTgy9KRFnNEVmzlb2eR7NrWsWuFGrGt
	qjXSUztOQVkSixbJRcRBAIt/i28aqjLqB4nHti5kmo+8e/lYPPHxjzzdIBQZ8cxGndXpZoLQ2f2Qh
	fbSKhvbg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wDF4n-00000001yp5-3tfm;
	Thu, 16 Apr 2026 05:15:41 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wDF4j-00000001yoG-3bxL
	for linux-nvme@lists.infradead.org;
	Thu, 16 Apr 2026 05:15:40 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 3BFE768C7B; Thu, 16 Apr 2026 07:15:34 +0200 (CEST)
Date: Thu, 16 Apr 2026 07:15:33 +0200
From: Christoph Hellwig <hch@lst.de>
To: alistair23@gmail.com
Cc: hare@suse.de, hch@lst.de, sagi@grimberg.me, kch@nvidia.com,
	kbusch@kernel.org, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org, yi.zhang@redhat.com,
	mlombard@arkamax.eu, linux-block@vger.kernel.org,
	shinichiro.kawasaki@wdc.com,
	Alistair Francis <alistair.francis@wdc.com>
Subject: Re: [PATCH] nvmet-tcp: Ensure old keys are freed before replacing
 new ones
Message-ID: <20260416051533.GB14802@lst.de>
References: <20260415230250.2783414-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260415230250.2783414-1-alistair.francis@wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260415_221538_472086_97E915E1 
X-CRM114-Status: UNSURE (   8.07  )
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


