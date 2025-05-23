Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2B3DC54ED1
	for <linux-nvme@archiver.kernel.org>; Fri, 23 May 2025 14:52:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Y1LgnuGdwEgioTvPhAVNNhp4orxAU/cHH/seSfn+ygQ=; b=26P5wMvHJDUw6tBqTNdoj+ARw3
	dmnMKx+dAvtD8oqKCBCIdxk27ZHh+VH5qsux3pyi9ngPE8gsRt7w5aPo5t9DtW2VsOYIVhBR0WVI1
	mFsPBWDCKcDzQWOEx8ZsXTV/zh6HRql/Urf6p29ABXu9MdEQRr0dKD7JlcwsdXwMOTkUpGtMoZYS8
	0BogQJPnG6ukTR43/k11sgnNfHXXAMvMU/jr4DlFnkq/Oir7tqfhiGunDlf3SAjm1S83N44XUYbY9
	5rezLv8evxLKDK7eIZN6F6mJbUhHYaAAXLm1x6E4N7y2M3iEmG46rK5+kDotlPiC6Av9b94txCrzR
	q8zqIaZQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uITlU-000000049XE-3Qu0;
	Fri, 23 May 2025 14:52:52 +0000
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uISyy-000000042O5-0qml;
	Fri, 23 May 2025 14:02:44 +0000
Date: Fri, 23 May 2025 07:02:44 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>, Keith Busch <kbusch@meta.com>,
	linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: [PATCH 5/5] nvmet: implement copy support for bdev backed target
Message-ID: <aDCABK5Nzxvtrocz@infradead.org>
References: <20250521223107.709131-1-kbusch@meta.com>
 <20250521223107.709131-6-kbusch@meta.com>
 <aDB1p8XIhsauGFhc@infradead.org>
 <aDB_mIZ5YUG32sHx@kbusch-mbp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aDB_mIZ5YUG32sHx@kbusch-mbp>
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

On Fri, May 23, 2025 at 08:00:56AM -0600, Keith Busch wrote:
> On Fri, May 23, 2025 at 06:18:31AM -0700, Christoph Hellwig wrote:
> > I need this additional bit so that the host code actually see the
> > copy support:
> 
> Thanks! I think it just needs to be constrained to bdev backed targets
> since I don't have file support for copy offload here. And less
> important, but for spec compliance, I need to update the Command Effects
> Log too.

A file backend should be pretty trivial using vfs_copy_file_range.
On reflink-enabled file systems it might end up beeing to fast to
be useful, though :)

