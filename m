Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECF8BC19F2A
	for <linux-nvme@archiver.kernel.org>; Thu, 11 Aug 2022 12:10:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=bc9/3RFQ3/BYv5GKcvhxJWM/+fz93rvd/+K14B4oPhk=; b=GpPVX6pF+oG9kPv2dwawOAeU0j
	b+t8uot7mPxsnyuBp2rwQGimFqfd6BTzQu/cUuPFTuRCKEYpQUj/bVAtkv51nFUvSDrkAsuzoy2IC
	zcbvkEEdHdnHWZ3jLyijmNd2mJtIWmN/PDKzfim0R0Rc8hmsOClZyqosASwEf4ed+xG4FrS45VSze
	X3a6Hnldo1lcscg0pU0Lz+4eD404xEPn5yBXtkcE0/WZmh/3wUsAWoqUMbX6JNIGiQXbw6dKb5zXB
	Wyn8OusOf7v0fvvMo9MXtSeGOUGc2OyQ/xEXt2m3LvcnPFJreFbHeUB8GLUHjzC5ksgCV3DYNdYyD
	Z1bLmgoQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oM71N-00BzW7-B9; Thu, 11 Aug 2022 12:10:41 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oM71H-00BzRs-K8
	for linux-nvme@lists.infradead.org; Thu, 11 Aug 2022 12:10:37 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 1336668AA6; Thu, 11 Aug 2022 14:10:28 +0200 (CEST)
Date: Thu, 11 Aug 2022 14:10:27 +0200
From: Christoph Hellwig <hch@lst.de>
To: "Dennis P. Kliem" <dpkliem@gmail.com>
Cc: kbusch@kernel.org, axboe@fb.com, hch@lst.de, sagi@grimberg.me,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvme-pci: add NVME_QUIRK_BOGUS_NID for ADATA XPG
 GAMMIX S70
Message-ID: <20220811121027.GA1665@lst.de>
References: <20220811105657.9493-1-dpkliem@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220811105657.9493-1-dpkliem@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220811_051035_827207_EC3B5ADC 
X-CRM114-Status: UNSURE (   8.21  )
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

applied to nvme-6.0.

