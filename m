Return-Path: <SRS0=TQUi=PD=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEB92C433EF
	for <linux-nvme@archiver.kernel.org>; Fri, 15 Oct 2021 14:03:53 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8BCA260F70
	for <linux-nvme@archiver.kernel.org>; Fri, 15 Oct 2021 14:03:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 8BCA260F70
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=KanmlaFBwV6DRdQ41vIsGhe17Tn0ouHRuztKUsQZtZ0=; b=Yfw5OWuCtdv2vsCEaUN4HHQ9Tb
	dCs+eUCxKvc/GpMVLpVVAE92b9JtQms/gRIq4tFQGt7VNNz52vdlplHXH1gosG6nQiTCM4RIlQeni
	CvtZhHuYVmUAfUhKi1OG75FXFdA0hX68tEAw/hQGNTJKNtYlI2VYyxN8nokzuQhdrUdnh03zB7Bq3
	W5cvw7xi3up+WQt5A8ivWt6ar5GpGvJkHi6GrwbnAbv4PNlQMdaUOfh8fSMravyqfqXTxm4EOVKO6
	ciCj/ezwjkgQb+4GdTWj9Kcnxt/8IcDVInEf/JccOqyTI3Uk7kipyMBtjaO7eId6VnC1RWDSssXnK
	ssHiJU0Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mbNoM-007RMs-CJ; Fri, 15 Oct 2021 14:03:50 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mbNNV-007HSu-LJ
 for linux-nvme@bombadil.infradead.org; Fri, 15 Oct 2021 13:36:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=KanmlaFBwV6DRdQ41vIsGhe17Tn0ouHRuztKUsQZtZ0=; b=Sp0mzcOz6fCy6w+SFxvFJT113O
 5glduGFb7LrPQcGlbPxTVXMdHUuiHlqKZMAdoOUuvr7VmdXF1ZROQXYx/SURx8NNGczFxd78OKEWX
 g1EVnRcaMy66kxGA0Ycz2sVxG+Jq6Xakmu96RSvhrCic177Aboi4kmhdgF1+i/MmTps4PefQxR1U9
 R0lWGSxbM9vlrOVzh3s4+nOS+3Fdq1Tv3nAaot4M9Z7iIxha6Lnwv+o1M6OB/txkN3fli+COyWBGO
 MCf3+V04TrhkegQ0Jg+SGb+t7IWveuPWDgrPUju8wVNJF/jSdrYZ56qZJb0uP40KoBw/AcVk6NLsV
 0KeMg3+w==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red
 Hat Linux)) id 1mbNMh-0092n0-E6; Fri, 15 Oct 2021 13:35:28 +0000
Date: Fri, 15 Oct 2021 14:35:15 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Coly Li <colyli@suse.de>,
 Mike Snitzer <snitzer@redhat.com>, Song Liu <song@kernel.org>,
 David Sterba <dsterba@suse.com>, Josef Bacik <josef@toxicpanda.com>,
 Theodore Ts'o <tytso@mit.edu>,
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
Message-ID: <YWmDk8YQKVPRGBfR@casper.infradead.org>
References: <20211015132643.1621913-1-hch@lst.de>
 <20211015132643.1621913-3-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211015132643.1621913-3-hch@lst.de>
X-Mailman-Approved-At: Fri, 15 Oct 2021 06:36:25 -0700
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

On Fri, Oct 15, 2021 at 03:26:15PM +0200, Christoph Hellwig wrote:
> +static inline sector_t bdev_nr_bytes(struct block_device *bdev)
> +{
> +	return i_size_read(bdev->bd_inode);

Uh.  loff_t, surely?

