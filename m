Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7A22C433EF
	for <linux-nvme@archiver.kernel.org>; Wed, 11 May 2022 06:54:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=BBvW/7M7cw10fx79GxqESFndaLtZqGJrpgxHrX0Y4r8=; b=buQ+qSItGbU7ymnPXUq4F6tpRR
	kkEe6Sv0oIibbpMWhaQHRYlDVUF1GFwRRO+G7xRCnhjM7tsqnsdiaHiz1cGR0zrS2kS6XJIbAQxKl
	sry1n3FAQtS45/XHGhGFmcrX/IqVxl22tkaLqmowNuTE3lisWWSP3RGfkLaJNFLJffKEQP7LCl3g9
	yOx8S/ibXDo8lc5FmgDuqojDLXikWL1AGhTnbRtIiCI5NNbbagjVertYbVTbobQoso4FAtVXYURdb
	MTYK43eZXHpV21iTsBH+LcB47R10AdcDHI70zntks1gjBgn6ie9PNrngFBtE748ZhvpspyEbLypKx
	ouDJ+5SQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nogEw-005aa2-20; Wed, 11 May 2022 06:54:30 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nogEt-005aYz-It
 for linux-nvme@lists.infradead.org; Wed, 11 May 2022 06:54:28 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id BAAE368C4E; Wed, 11 May 2022 08:54:23 +0200 (CEST)
Date: Wed, 11 May 2022 08:54:23 +0200
From: Christoph Hellwig <hch@lst.de>
To: Kanchan Joshi <joshi.k@samsung.com>
Cc: axboe@kernel.dk, hch@lst.de, io-uring@vger.kernel.org,
 linux-nvme@lists.infradead.org, asml.silence@gmail.com,
 ming.lei@redhat.com, mcgrof@kernel.org, shr@fb.com,
 joshiiitr@gmail.com, anuj20.g@samsung.com, gost.dev@samsung.com
Subject: Re: [PATCH v5 6/6] io_uring: finish IOPOLL/ioprio prep handler removal
Message-ID: <20220511065423.GA814@lst.de>
References: <20220511054750.20432-1-joshi.k@samsung.com>
 <CGME20220511055320epcas5p2457aaf8e7405387282f60831f5a4eca9@epcas5p2.samsung.com>
 <20220511054750.20432-7-joshi.k@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220511054750.20432-7-joshi.k@samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220510_235427_804312_67BDF5F5 
X-CRM114-Status: GOOD (  10.66  )
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

I think this should go first, and the uring_cmd bits need to do the
right thing from the beginning.

On Wed, May 11, 2022 at 11:17:50AM +0530, Kanchan Joshi wrote:
> From: Jens Axboe <axboe@kernel.dk>
> 
> Commit 73911426aaaa unified the checking of this, but was done before we
> had a few new opcode handlers.

Also please quote the actual commit subject as well here per the usual
Fixes-like refernence style.

