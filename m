Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02980CA0ED3
	for <linux-nvme@archiver.kernel.org>; Mon, 11 Aug 2025 15:48:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=N05B15izMQlfIgzKZi/SgcWMdWbGtwHIHP/ZXSEVEkE=; b=lY7DBmVyfYEMAqBuYp2KocRcQz
	ptdpSAGoMJ1vQDJKSREfwV+iM5O2ekHhtx7H6XszYQLbCagH93u/3xDr7j/qvU4V8/S3T6YmmqdLv
	bZAKOd04u1t3EMJF2bCqDsIUylMYAzJTWwvqHTrFcI6BclQ1vhylGyZ+ishO1J1I6N7kYjA8+v7GH
	y0cx9YOT1ymROY3IFU/2+Ld6ukpa+UDZ+SnW87rMbhuwCTtDDcLWoUHxIZ2R5i5qr1geEPx10ggg4
	zKj/BohFXml4bswGPymMDPVz9mdFpsENq5gL4E0tjSJoms252RLL4fQDmX2ce5Gl8dBjEMvi9Waef
	kk7HARig==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ulUkz-00000008G4M-14jI;
	Mon, 11 Aug 2025 15:48:17 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ulTA6-00000007woZ-1zqL
	for linux-nvme@lists.infradead.org;
	Mon, 11 Aug 2025 14:06:09 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 258A568BFE; Mon, 11 Aug 2025 16:05:51 +0200 (CEST)
Date: Mon, 11 Aug 2025 16:05:50 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@meta.com>,
	linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
	axboe@kernel.dk, joshi.k@samsung.com
Subject: Re: [PATCHv5 1/8] blk-mq-dma: introduce blk_map_iter
Message-ID: <20250811140550.GA19377@lst.de>
References: <20250808155826.1864803-1-kbusch@meta.com> <20250808155826.1864803-2-kbusch@meta.com> <20250810140448.GA4262@lst.de> <aJnwjVm7tTJwoQhj@kbusch-mbp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aJnwjVm7tTJwoQhj@kbusch-mbp>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250811_070606_658221_904565C4 
X-CRM114-Status: GOOD (  13.68  )
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

On Mon, Aug 11, 2025 at 07:30:53AM -0600, Keith Busch wrote:
> Perhaps I misunderstood the assignment:
> 
>   https://lore.kernel.org/linux-block/20250722055339.GB13634@lst.de/
> 
> I thought you were saying you wanted the lower (bvec pages -> phys
> addrs) and upper part (phys -> dma) available as an API rather than
> keeping the lower part private to blk-dma. This patch helps move towards
> that, and in the next patch provides a common place to stash the bvec
> array that's being iterated.

Eventually we might want to make it public, yes.  But that works just
fine with the phys_vec.  In fact Leon has a series outstanding currently
that makes struct phys_vec public without any other changes to this
code.

