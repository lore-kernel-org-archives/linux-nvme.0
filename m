Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14891FD8FCB
	for <linux-nvme@archiver.kernel.org>; Thu, 26 Feb 2026 15:33:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=Um5XKdHFHdKO7eEizRLi1UqXAL
	ETULAXlEld2y0MCMxyC7DnKgekzOD/pDw7ZmEeKF7scI29TMLiDtz0JKNOiAyfJNMguPlBQktMqeD
	tCYYaKAAV6msIndck4ceaLuk4YU/JzeJXC6EI8l6FppxnMH7pWQE6Fvq7ryFe6I7I+xJqFQ5EUeOU
	Etl+TzCeoNbrczJwPwr6+sMocn7OW+O2ATV5LYO5M91y6qSESUiaMwYUkIufOseKDl35NUIWJp+Pd
	GMJpUSFr3wkZJ/bEQkU2dcEE7NVjqUZmoKDGdFJTS7AkfnL9b1ma0ov/bz05oLRCWAG6K8jNoZ87U
	z3MPmS3w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vvdN4-00000006WGQ-29Qq;
	Thu, 26 Feb 2026 15:33:46 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vvdN2-00000006WFa-03ci
	for linux-nvme@lists.infradead.org;
	Thu, 26 Feb 2026 15:33:45 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 063D868C4E; Thu, 26 Feb 2026 16:33:40 +0100 (CET)
Date: Thu, 26 Feb 2026 16:33:39 +0100
From: Christoph Hellwig <hch@lst.de>
To: Chaitanya Kulkarni <kch@nvidia.com>
Cc: kbusch@kernel.org, hch@lst.de, sagi@grimberg.me, wagi@monom.org,
	linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: [PATCH V2 2/2] block: clear BIO_QOS flags in blk_steal_bios()
Message-ID: <20260226153339.GB31398@lst.de>
References: <20260226031243.87200-1-kch@nvidia.com> <20260226031243.87200-3-kch@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260226031243.87200-3-kch@nvidia.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260226_073344_195920_3EC4A053 
X-CRM114-Status: UNSURE (   9.31  )
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


