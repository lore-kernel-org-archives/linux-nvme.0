Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64BDFD2C55F
	for <linux-nvme@archiver.kernel.org>; Tue, 22 Oct 2024 14:40:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=v9hkp8umGEzcLPxiw8ib6z3nj4VtLc64osafLPAU9lw=; b=KtHltCKh0Tn6GOcEE76F1P6mlV
	ZGCp9vc7MbVS02Toiw+TVn3ptsZ76JiftPxP8pS/x85hZc+no8D5bE4Yw2m9mX5M93+N8lDEdT19A
	ZjQIA6n5YYHsz2++4b+vVVc/1aXErJzzLvh4/wFn0rapoKOqJ5+TUGFO79iZN+WCU/3zAKQN4g5CX
	BTgyTSOQnOdFF6Xcu9JfWJB6uy5SOA8DmrpOIwAC9lAKZvmriFXi+luAqD99Tv5zQuupaFWfS3l2z
	dTgjXE2xCfO7Q2zH3gfIp2FbKYIvKUVtTu/WtQL5ilGOH/5wkt2k2WuNTEJOTL5ejZ4FIwvFupIkD
	AsHV0CIA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t3G3M-0000000B8I2-47H7;
	Tue, 22 Oct 2024 14:40:08 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t3G3J-0000000B8HL-0Htt
	for linux-nvme@lists.infradead.org;
	Tue, 22 Oct 2024 14:40:07 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id B88DA227AA8; Tue, 22 Oct 2024 16:40:00 +0200 (CEST)
Date: Tue, 22 Oct 2024 16:40:00 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@meta.com>,
	linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
	axboe@kernel.dk, io-uring@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, joshi.k@samsung.com,
	javier.gonz@samsung.com, Nitesh Shetty <nj.shetty@samsung.com>,
	Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCHv8 1/6] block, fs: restore kiocb based write hint
 processing
Message-ID: <20241022144000.GA19776@lst.de>
References: <20241017160937.2283225-1-kbusch@meta.com> <20241017160937.2283225-2-kbusch@meta.com> <20241018055032.GB20262@lst.de> <ZxZ3o_HzN8HN6QPK@kbusch-mbp> <20241022064309.GA11161@lst.de> <Zxe4xL-sM5yF2isM@kbusch-mbp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zxe4xL-sM5yF2isM@kbusch-mbp>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241022_074005_268822_CDA57C86 
X-CRM114-Status: GOOD (  13.42  )
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

On Tue, Oct 22, 2024 at 08:37:56AM -0600, Keith Busch wrote:
> No doubt it's almost certainly not a good idea to mix different stream
> usages, but that's not the kernels problem. It's user space policy. I
> don't think the kernel needs to perform any heroic efforts to split
> anything here. Just keep it simple.

Unfortunately it's not.  This complicated breaks any intelligent
scheme to manage them.  You can't write portable code assuming you
can know write streams when you need to cope with someone else using
some or all of the same resources.

