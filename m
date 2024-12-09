Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC3ACE77185
	for <linux-nvme@archiver.kernel.org>; Mon,  9 Dec 2024 13:12:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=iX1c+XfthbeERkdIk5PwTAc7Gbg6eO8nam9B7f1ZhS8=; b=aGQFSCFprd1DI3l/Emm7artj+W
	jC7uIF8rT7vVL8huXFk6KLS3NytT62Waj4fzMfUYxX9YIXAA/JSFrGXw4NqQLo3cYq+HmFp6jfwRu
	u+ZnHA0/qVUmp3Ua0cNZ6P7PNZKfrxc6Mh8Jgs6aLnen9o4Ka1dpdDykZs6EOlZyGWsfU7PGEx1RG
	+j8G7Uz/z6G1i7Yx68QtjPHXoyPE3v16zvE5s7lLZRDzovkri4L6dA1tYF1wgxjLUIaRwKUAEdrrC
	U4BOhAix+6lLF39tg2ZKbWaKgabQQrI8/y46SoAnkTsMm3TZax8Q/SwH0+wr6YoAcBCklkW4gG0Aw
	WznBjKyg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tKdYU-00000007twx-0FwQ;
	Mon, 09 Dec 2024 13:12:06 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tKdIC-00000007ob6-3PMQ
	for linux-nvme@lists.infradead.org;
	Mon, 09 Dec 2024 12:55:18 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id AD09C68D09; Mon,  9 Dec 2024 13:55:11 +0100 (CET)
Date: Mon, 9 Dec 2024 13:55:11 +0100
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@meta.com>
Cc: axboe@kernel.dk, hch@lst.de, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org,
	io-uring@vger.kernel.org, sagi@grimberg.me, asml.silence@gmail.com,
	anuj20.g@samsung.com, joshi.k@samsung.com,
	Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCHv12 00/12] block write streams with nvme fdp
Message-ID: <20241209125511.GB14316@lst.de>
References: <20241206221801.790690-1-kbusch@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241206221801.790690-1-kbusch@meta.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241209_045516_989045_7FCD5E6B 
X-CRM114-Status: GOOD (  12.31  )
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

I just compared this to a crude rebase of what I last sent out, and
AFAICS the differences are:

 1) basically all new io_uring handling due to the integrity stuff that
   went in
 2) fixes for the NVMe FDP log page parsing
 3) drop the support for the remapping of per-partition streams
 
conceptually this all looks fine to me.  I'll throw in a few nitpicks
on the nvme bits, and I'd need to get up to speed a bit more on the
io_uring bits before commenting useful.

One thing that came I was pondering for a new version is if statx
really is the right vehicle for this as it is a very common fast-path
information.  If we had a separate streaminfo ioctl or fcntl it might
be easier to leave a bit spare space for extensibility.  I can try to
prototype that or we can leave it as-is because everyone is tired of
the series.


