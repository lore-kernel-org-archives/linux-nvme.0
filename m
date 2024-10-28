Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 529F9D13596
	for <linux-nvme@archiver.kernel.org>; Mon, 28 Oct 2024 11:52:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8pdLifHffGehFinSUpxYSdLgGVpxf+AHGtMieTsoQxo=; b=jiN2tavLolj6yHyamkjce+iGmX
	b/s8jDTCXXGF0aGH4e1u4dmbv1R+m+wpBTDyZSyyYBCRXcboZsJvW5/S+772WPz6EPXY4mGqvjB4r
	Q825FG6/jfdLUjX4IMbC5e6yQ9I1JT2S4rBuGCP/V0E9myDEXbPCkn4Q5txLDiqsmKLD+xbEbrVu3
	MMMZMk91iyNsUPdrI2h5V/iilywouqQ5y4SgocCMTpV2QAyCBNPBG6PciDmJ8egfc0tPmC/91kWJ5
	46XUksDbswwiVnmcCTKhsNpnHKVWpE9D+Y0HmjE1Fu+XjzvvVxxPBBHR05zEsCv11lsAyw4A4Ly5x
	CcCKjRug==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t5OID-0000000AdGc-3ARm;
	Mon, 28 Oct 2024 11:52:17 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t5OIB-0000000AdFY-25Au
	for linux-nvme@lists.infradead.org;
	Mon, 28 Oct 2024 11:52:16 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id D7A58227AAC; Mon, 28 Oct 2024 12:52:12 +0100 (CET)
Date: Mon, 28 Oct 2024 12:52:11 +0100
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@meta.com>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-scsi@vger.kernel.org, io-uring@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, hch@lst.de, joshi.k@samsung.com,
	javier.gonz@samsung.com, bvanassche@acm.org,
	Keith Busch <kbusch@kernel.org>, Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCHv9 2/7] block: introduce max_write_hints queue limit
Message-ID: <20241028115211.GC8517@lst.de>
References: <20241025213645.3464331-1-kbusch@meta.com> <20241025213645.3464331-3-kbusch@meta.com> <20241028115132.GB8517@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241028115132.GB8517@lst.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241028_045215_699879_44C4A9A1 
X-CRM114-Status: GOOD (  12.07  )
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

On Mon, Oct 28, 2024 at 12:51:32PM +0100, Christoph Hellwig wrote:
> As pointed out by Bart last time, you can't simply give the write hints
> to all block device.  Assume we'd want to wire up the write stream based
> separate to f2fs (which btw would be a good demonstration), and you'd
> have two different f2fs file systems on separate partitions that'd
> now start sharing the write streams if they simply started from stream
> 1.  Same for our pending XFS data placement work.

And I'm an idiot and should have looked at the next patch patch first.
Sorry for that.

