Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BEBCC32772
	for <linux-nvme@archiver.kernel.org>; Sun, 21 Aug 2022 05:46:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=lURQ8F7BGFS7aLjKoi+mm1vzhPa6mY4vW57qU3+4Ha4=; b=NpeFNHXcw+FJ3d1UbF/DaNH2+s
	8wZrTgIMDLDcYar6HZPwgiT1N0ULSLgGgVXhl/wCtg2sK8Gbmv7XvjyGQwSBVG/Rw6fa7fSVZ1Utr
	MU1eeQkCjhQf5F7Hf15p+LZyd/2mF3RB+KLe2k7SHAnI20B59mdrrpk7JsMT7MGNwNew/1Xw650WM
	uVSHy+JNeVvR5D4GZ6MCftK17EjNKqvQp+SgrAqYVv24Mv4cgov6JUgFWyb/NLYLoVWYlNjUUw6tl
	IF+Jsaq1uJZlFRbexeD2Q3GA1rpY0f56xl3rp46iHPPnf4RkFGKWqGMNAkLgrpDRyMsmpxBDNAwqc
	kyDWRz+w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oPdmt-006QKo-TN; Sun, 21 Aug 2022 05:46:20 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oPdml-006QGF-JM
	for linux-nvme@lists.infradead.org; Sun, 21 Aug 2022 05:46:13 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 6548468C4E; Sun, 21 Aug 2022 07:46:02 +0200 (CEST)
Date: Sun, 21 Aug 2022 07:46:02 +0200
From: Christoph Hellwig <hch@lst.de>
To: "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	Keith Busch <kbusch@kernel.org>, Ira Weiny <ira.weiny@intel.com>
Subject: Re: [PATCH v2] nvmet-tcp: Don't kmap() pages which can't come from
 HIGHMEM
Message-ID: <20220821054602.GA25754@lst.de>
References: <20220817184519.25141-1-fmdefrancesco@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220817184519.25141-1-fmdefrancesco@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220820_224611_905057_126E178D 
X-CRM114-Status: UNSURE (   8.76  )
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

This introduced tons of pointless over 80 character lines, please stick
to a proper coding style.

Also or in-kernel I/O wouldn't it make more sense to use a BVEC iter
insted of a KVEC if we have the pages anyway?  Or does networking not
support them properly?

