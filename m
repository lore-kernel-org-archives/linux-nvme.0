Return-Path: <SRS0=KS3B=PB=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36E25C433EF
	for <linux-nvme@archiver.kernel.org>; Wed, 13 Oct 2021 15:54:35 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E9F40610EA
	for <linux-nvme@archiver.kernel.org>; Wed, 13 Oct 2021 15:54:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org E9F40610EA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mit.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ennSWJ4G+CKe4VAbanQzjP3z4q4QH6hNOgHXNSd8FUs=; b=hk6rwdQCdB437P2VJSRXDy3zDA
	mnKWZSyxCvQqJRs8b72gKI8/lFrIDBDrEaXbFLDGuGSXOWh1W1d9ngUXP6T0Axza8kzhI47etCUBR
	Lt7iek4AJoH5+44GY1BjEK8/BStr/7rhwHrux1T5zah5dkXBz/7ra9BKHuo86z//gqRt9y/s81QiS
	83toSl6YV2PvMXeYkl0I/YRWshhvCtTm1GJbrONWcOB4gROrXoslAg6GVnEpE7QcoktncSEURvh1q
	hv04Enz5UGs/13d6o+zBXifP0F4Ga1F+J6QB8xSRvN98CN+QafArcqGKmNaZAoBLP/Eyfm375yaNL
	PfUze4pg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1magaA-00HSRN-Jh; Wed, 13 Oct 2021 15:54:18 +0000
Received: from outgoing-auth-1.mit.edu ([18.9.28.11] helo=outgoing.mit.edu)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1magXE-00HRs8-U3; Wed, 13 Oct 2021 15:51:18 +0000
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net
 [72.74.133.215]) (authenticated bits=0)
 (User authenticated as tytso@ATHENA.MIT.EDU)
 by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 19DFp2vF009493
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 13 Oct 2021 11:51:03 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
 id 9296B15C00CA; Wed, 13 Oct 2021 11:51:02 -0400 (EDT)
Date: Wed, 13 Oct 2021 11:51:02 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Coly Li <colyli@suse.de>,
 Mike Snitzer <snitzer@redhat.com>, Song Liu <song@kernel.org>,
 David Sterba <dsterba@suse.com>, Josef Bacik <josef@toxicpanda.com>,
 OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
 Dave Kleikamp <shaggy@kernel.org>,
 Ryusuke Konishi <konishi.ryusuke@gmail.com>,
 Anton Altaparmakov <anton@tuxera.com>,
 Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
 Kees Cook <keescook@chromium.org>,
 Phillip Lougher <phillip@squashfs.org.uk>, Jan Kara <jack@suse.com>,
 linux-block@vger.kernel.org, dm-devel@redhat.com,
 drbd-dev@lists.linbit.com, linux-bcache@vger.kernel.org,
 linux-raid@vger.kernel.org, linux-mtd@lists.infradead.org,
 linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org,
 target-devel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-btrfs@vger.kernel.org, linux-ext4@vger.kernel.org,
 jfs-discussion@lists.sourceforge.net, linux-nfs@vger.kernel.org,
 linux-nilfs@vger.kernel.org, linux-ntfs-dev@lists.sourceforge.net,
 ntfs3@lists.linux.dev, reiserfs-devel@vger.kernel.org
Subject: Re: [PATCH 25/29] ext4: use sb_bdev_nr_blocks
Message-ID: <YWcAZq8eGQiZyxZS@mit.edu>
References: <20211013051042.1065752-1-hch@lst.de>
 <20211013051042.1065752-26-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211013051042.1065752-26-hch@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211013_085117_200250_2736FBF6 
X-CRM114-Status: UNSURE (   9.71  )
X-CRM114-Notice: Please train this message.
X-Mailman-Approved-At: Wed, 13 Oct 2021 08:54:17 -0700
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

On Wed, Oct 13, 2021 at 07:10:38AM +0200, Christoph Hellwig wrote:
> Use the sb_bdev_nr_blocks helper instead of open coding it.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Acked-by: Theodore Ts'o <tytso@mit.edu>

