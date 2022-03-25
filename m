Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E735C433F5
	for <linux-nvme@archiver.kernel.org>; Fri, 25 Mar 2022 05:39:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zhcspDf6rKbAQmJn667SxCPvXJNHQq8k7yb38mH1nAY=; b=Qq29ycMg2OmudqD04wWGVMTH6n
	SGF/t8UX133Nuo67X1r7uchM/3Gu5LnDP31BYHLWBBGHx/LKIo3TtYMhOUh6AIOwYQu+l5K9RHuuc
	Lh4sf3/OnABJIwTDdpU6jX68YMT3t33h+/qFuGxkfVxJqB8R3vl3wt+3whmMp38UH0lQLrDNVdByr
	r+fzpgI43PAv0VxXeD/UKSAMdILseVrBYWFwPN7r8o9iWl6yhD7m+mn/wN9WD/nCyuxNGwIs7oS+k
	xU3ehgmovwMxrf9qOjShbgyOSwTbEDIyfTVYigh0eyaJJW3qAdz6Nw3U3+FKfq4g2g1niQZmUAayY
	iWzX2TcQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nXcf8-001ApN-Oj; Fri, 25 Mar 2022 05:39:02 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nXcf5-001AoH-QM
 for linux-nvme@lists.infradead.org; Fri, 25 Mar 2022 05:39:01 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 009BE68B05; Fri, 25 Mar 2022 06:38:55 +0100 (CET)
Date: Fri, 25 Mar 2022 06:38:55 +0100
From: Christoph Hellwig <hch@lst.de>
To: Kanchan Joshi <joshiiitr@gmail.com>
Cc: Christoph Hellwig <hch@lst.de>, Kanchan Joshi <joshi.k@samsung.com>,
 Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
 Pavel Begunkov <asml.silence@gmail.com>, io-uring@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
 sbates@raithlin.com, logang@deltatee.com,
 Pankaj Raghav <pankydev8@gmail.com>,
 Javier =?iso-8859-1?Q?Gonz=E1lez?= <javier@javigon.com>,
 Luis Chamberlain <mcgrof@kernel.org>,
 Adam Manzanares <a.manzanares@samsung.com>,
 Anuj Gupta <anuj20.g@samsung.com>
Subject: Re: [PATCH 11/17] block: factor out helper for bio allocation from
 cache
Message-ID: <20220325053855.GA5344@lst.de>
References: <20220308152105.309618-1-joshi.k@samsung.com>
 <CGME20220308152716epcas5p3d38d2372c184259f1a10c969f7e4396f@epcas5p3.samsung.com>
 <20220308152105.309618-12-joshi.k@samsung.com>
 <20220310083503.GE26614@lst.de>
 <CA+1E3rLF7D4jThUPZYbxpXs9LLdQ7Ek=Qy+rXZE=xgwBcLoaWQ@mail.gmail.com>
 <20220324063011.GA12660@lst.de>
 <CA+1E3rJAK9fPuS6g_po_vpvde_LpOjkuoU=E5h=v9rnHhc3+mw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+1E3rJAK9fPuS6g_po_vpvde_LpOjkuoU=E5h=v9rnHhc3+mw@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220324_223900_031556_56BE1778 
X-CRM114-Status: GOOD (  11.26  )
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

On Thu, Mar 24, 2022 at 11:15:20PM +0530, Kanchan Joshi wrote:
> Thanks, that can be reused here too. But to enable this feature - we
> need to move to a bioset from bio_kmalloc in nvme, and you did not
> seem fine with that.

Yeah, kmalloc already does percpu caches, so we don't even need it.

