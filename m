Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3C22D3C54C
	for <linux-nvme@archiver.kernel.org>; Fri, 18 Oct 2024 06:00:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Mu8ePBuM1hTlt4BgoY36fiQOomwZV+Y1FxAx63DxMJk=; b=G6GoFoIRduoVFC/fuHA0eDDBYj
	EVbq3tUKc+oEreJ6QVEmXIu02MRPR2WddTxmlIUdGduC2CPf+9MTzFNhzuRD3hPmC4LVa+OAbelsa
	tPdx+4q9rPlbBogpphA+yur2HGTWoSaq8aMRJGyOUiCMk+l3pBH+3Q/HTzV9Z31wvGuiDLNO4YnPe
	6lSP6TS9G1ZdxcLGj1XP/awi7pUykLD4jDm/xXWHEnZLyBz/kNjb1cCUbxdcpGiEebBKJrrOgpPkn
	lkwz7Do65kv7r+4dMzrL7Uu1Fju/gzA5K95zmseuYFJcjydlfOelMoDMYzWLNvrJjH5xNtq7YeK/0
	BVvMq/8Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t1g1x-0000000H4It-0o3o;
	Fri, 18 Oct 2024 06:00:09 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t1fvq-0000000H23R-2lep
	for linux-nvme@lists.infradead.org;
	Fri, 18 Oct 2024 05:53:52 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 19FA0227AAF; Fri, 18 Oct 2024 07:53:48 +0200 (CEST)
Date: Fri, 18 Oct 2024 07:53:47 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@meta.com>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
	axboe@kernel.dk, hch@lst.de, io-uring@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, joshi.k@samsung.com,
	javier.gonz@samsung.com, Nitesh Shetty <nj.shetty@samsung.com>,
	Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCHv8 5/6] io_uring: enable per-io hinting capability
Message-ID: <20241018055347.GE20262@lst.de>
References: <20241017160937.2283225-1-kbusch@meta.com> <20241017160937.2283225-6-kbusch@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241017160937.2283225-6-kbusch@meta.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241017_225350_862280_6B149355 
X-CRM114-Status: UNSURE (   9.49  )
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

Same hint vs write stream thing here as well.

> +	if (ddir == ITER_SOURCE &&
> +	    req->file->f_op->fop_flags & FOP_PER_IO_HINTS)
> +		rw->kiocb.ki_write_hint = READ_ONCE(sqe->write_hint);
> +	else
> +		rw->kiocb.ki_write_hint = WRITE_LIFE_NOT_SET;

WRITE_LIFE_NOT_SET is in the wrong namespae vs the separate streams.

Either use 0 directly or add a separate constant for it.


