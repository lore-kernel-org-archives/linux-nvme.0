Return-Path: <SRS0=TQUi=PD=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26513C433F5
	for <linux-nvme@archiver.kernel.org>; Fri, 15 Oct 2021 14:05:42 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E598A61037
	for <linux-nvme@archiver.kernel.org>; Fri, 15 Oct 2021 14:05:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org E598A61037
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0/1fg8ZfMoq3cTXowu7jEwUyGGHgYFQBxdNPZawD6m4=; b=xvyLKHZBPiDCPQ/srTfsS1lGFG
	LGybiFIdOUrxuSq7nOFsCsfhEMf33L79xpzOiMn6G8fc1+UIuqMmn7ReTAsNrIC8MUBsQ1oEq8j5m
	rBaoMEmw67GZHAx1ArNSVEMh9MKTAA4Ac3Jed9VDNRizMmLqa+uYH531X50cL/WcmsH3BRhc8yhCa
	FuvgQ/+bE6kRZNahwp1W9AgncDJlcdcF7avoyoDmHOg93BbYUzWDStO2EpC+QB0FkLmOM63EOiexy
	Dqa9KuG5sUQ/oqQDkxQ5cA5Xya5I8xqH8C+9juHvuySW5bLTw2Kezq17HuEH7jQS8CaI/Npk4YgLi
	OiqDAIDQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mbNq5-007RuL-F8; Fri, 15 Oct 2021 14:05:37 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mbNOT-007Hoe-Gm
 for linux-nvme@lists.infradead.org; Fri, 15 Oct 2021 13:37:06 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 7D96568BEB; Fri, 15 Oct 2021 15:37:02 +0200 (CEST)
Date: Fri, 15 Oct 2021 15:37:01 +0200
From: Christoph Hellwig <hch@lst.de>
To: Matthew Wilcox <willy@infradead.org>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
 Coly Li <colyli@suse.de>, Mike Snitzer <snitzer@redhat.com>,
 Song Liu <song@kernel.org>, David Sterba <dsterba@suse.com>,
 Josef Bacik <josef@toxicpanda.com>, Theodore Ts'o <tytso@mit.edu>,
 OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
 Dave Kleikamp <shaggy@kernel.org>,
 Ryusuke Konishi <konishi.ryusuke@gmail.com>,
 Anton Altaparmakov <anton@tuxera.com>,
 Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
 Kees Cook <keescook@chromium.org>,
 Phillip Lougher <phillip@squashfs.org.uk>, Jan Kara <jack@suse.com>,
 linux-block@vger.kernel.org, dm-devel@redhat.com,
 drbd-dev@lists.linbit.com, linux-bcache@vger.kernel.org,
 linux-raid@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-scsi@vger.kernel.org, target-devel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org,
 linux-ext4@vger.kernel.org, jfs-discussion@lists.sourceforge.net,
 linux-nfs@vger.kernel.org, linux-nilfs@vger.kernel.org,
 linux-ntfs-dev@lists.sourceforge.net, ntfs3@lists.linux.dev,
 reiserfs-devel@vger.kernel.org
Subject: Re: [PATCH 02/30] block: add a bdev_nr_bytes helper
Message-ID: <20211015133701.GA31240@lst.de>
References: <20211015132643.1621913-1-hch@lst.de>
 <20211015132643.1621913-3-hch@lst.de> <YWmDk8YQKVPRGBfR@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YWmDk8YQKVPRGBfR@casper.infradead.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211015_063705_742559_FBBD817B 
X-CRM114-Status: GOOD (  13.33  )
X-Mailman-Approved-At: Fri, 15 Oct 2021 06:37:16 -0700
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

On Fri, Oct 15, 2021 at 02:35:15PM +0100, Matthew Wilcox wrote:
> On Fri, Oct 15, 2021 at 03:26:15PM +0200, Christoph Hellwig wrote:
> > +static inline sector_t bdev_nr_bytes(struct block_device *bdev)
> > +{
> > +	return i_size_read(bdev->bd_inode);
> 
> Uh.  loff_t, surely?

Yes, that wuld be the right type.  Note that it makes a difference
outside of documentation purposes.

