Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF081FA373D
	for <linux-nvme@archiver.kernel.org>; Tue,  1 Nov 2022 07:52:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=OA1qT8cygRlBgWvxM1EZRhTJJYK6oEnILjsD8BmDs68=; b=iFnBVDVqOq6lbOkqVM4OmzGiGS
	Pfh6ezm4wAqI09YSNGUJismNyGro7pog/t+kTZk+abP3g3o03l1fHDL6qNQwHI/UYK6eUsHod5ohA
	Vlu97HdIdMlsb2lB7sVAKck4oDKOhnw90skqZelsEXsr0U0ss37J/h0rPaTJcWOiF42lhR00yEJnD
	K374k0T/h9q8rDy4gvWK2RisWgbEExsC0pUYXdQt46aXsUrpBUFnpBC0AktzUG972VAqP4IsoKFGV
	ciQnx1ZmxgFy7zfkYHZNPnGDNjd6QBzaQzjQCFSUgGc0Fo4LsqV6RBLnwLEHii8/SUFCDAQhyTZug
	NA9/XLdA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1opm3x-002rkn-IG; Tue, 01 Nov 2022 07:51:57 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1opm3u-002rVG-CJ
	for linux-nvme@lists.infradead.org; Tue, 01 Nov 2022 07:51:56 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 1FFE868AA6; Tue,  1 Nov 2022 08:51:41 +0100 (CET)
Date: Tue, 1 Nov 2022 08:51:40 +0100
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@meta.com>
Cc: linux-nvme@lists.infradead.org, hch@lst.de, sagi@grimberg.me,
	Keith Busch <kbusch@kernel.org>,
	Alan Adamson <alan.adamson@oracle.com>,
	Daniel Wagner <dwagner@suse.de>,
	Kanchan Joshi <joshi.k@samsung.com>, Jens Axboe <axboe@kernel.dk>,
	Chaitanya Kulkarni <kch@nvidia.com>
Subject: Re: [PATCH-v3] nvme: quiet user passthrough command errors
Message-ID: <20221101075140.GA11107@lst.de>
References: <20221028201415.3487291-1-kbusch@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221028201415.3487291-1-kbusch@meta.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221101_005154_591290_7CD0A8CA 
X-CRM114-Status: UNSURE (   8.34  )
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

applied to nvme-6.1.

