Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F1C7CFA466
	for <linux-nvme@archiver.kernel.org>; Mon, 24 Nov 2025 06:22:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=dp3mlPd1tGPSHjwalGRl3+OXBzlUltt5c2g4rrDWar4=; b=n+YkG3PZwEgWY85WPR6GQ3X0gk
	Unfj+jwSJzeRJjcDSZKMbHvmvPiGMuHlufA61NwOBTx1E1M8IpNn7aZAH8HgtIRpPwvVNV4YK9H9F
	HO0v684ejdBH5wCS6pVhN/z0RwCu6Gc+In24jXlLJPm2uPgbO0bXU+titjaIe6vqI0C/UCLyH/21t
	MH9mqmUJFQ3hR7HZjW3J/Fg+6vTd00IdqoknJKC4pLMtIxkQX9gIvWKte2yRhY/NcSk5+yQCHBsbo
	Y8HkS2SruPd7f8KfTqT0G/oxf37dyWxnGxzjUM+MAXHutiENNIVd8d2O5BY0D1tGB9+1VCRc5iEOu
	Sl1bTAjA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vNPyF-0000000B913-46s5;
	Mon, 24 Nov 2025 06:22:43 +0000
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vNPyE-0000000B90n-31B1;
	Mon, 24 Nov 2025 06:22:42 +0000
Date: Sun, 23 Nov 2025 22:22:42 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Stephen Zhang <starzhangzsd@gmail.com>
Cc: Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org, nvdimm@lists.linux.dev,
	virtualization@lists.linux.dev, linux-nvme@lists.infradead.org,
	gfs2@lists.linux.dev, ntfs3@lists.linux.dev,
	linux-xfs@vger.kernel.org, zhangshida@kylinos.cn
Subject: Re: Fix potential data loss and corruption due to Incorrect BIO
 Chain Handling
Message-ID: <aSP5svsQfFe8x8Fb@infradead.org>
References: <20251121081748.1443507-1-zhangshida@kylinos.cn>
 <aSBA4xc9WgxkVIUh@infradead.org>
 <CANubcdVjXbKc88G6gzHAoJCwwxxHUYTzexqH+GaWAhEVrwr6Dg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANubcdVjXbKc88G6gzHAoJCwwxxHUYTzexqH+GaWAhEVrwr6Dg@mail.gmail.com>
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

On Sat, Nov 22, 2025 at 02:38:59PM +0800, Stephen Zhang wrote:
> ======code analysis======
> In kernel version 4.19, XFS handles extent I/O using the ioend structure,

Linux 4.19 is more than four years old, and both the block I/O code
and the XFS/iomap code changed a lot since then.

> changes the logic. Since there are still many code paths that use
> bio_chain, I am including these cleanups with the fix. This provides a reason
> to CC all related communities. That way, developers who are monitoring
> this can help identify similar problems if someone asks for help in the future,
> if that is the right analysis and fix.

As many pointed out something in the analysis doesn't end up.  How do
you even managed to call bio_chain_endio as almost no one should be
calling it.  Are you using bcache?  Are the others callers in the
obsolete kernel you are using?  Are they calling it without calling
bio_endio first (which the bcache case does, and which is buggy).


