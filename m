Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADF15C71133
	for <linux-nvme@archiver.kernel.org>; Fri, 25 Aug 2023 04:08:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=czbolVCNdiRIhtzRMydBVuDGtNoMVf0uK7rI8VUw4Wg=; b=PPMxh5bVIbCF09W49seDJstE/8
	xsE8O7qqSW+zgfU+QP2vYeLpbcx9yBMae4pFT6P576Zbb21e4Eolg8NgVfvvD22ebkgeVVuSOdyT2
	VD3qJn+uiHeIS1vy1+5R14w8VDHyqD/8e4zScCGJWTEicMsYE34S9GkgSGbh1KPFMHdd5uQbZxWys
	TJtEfTuaJwSAfkeOrjRX0H3+bVZRVz4NaNPt0gyvbv9qTOOPs522hzTXiUFvSMrNWENVQ4DzvsAhf
	yTRcGbXEw6brExnCi+ioXwBdwjs9p4E2uNzcKv8kaOE2Aq0SATPPyusDzAjQwbhIn4naPl+fb3UHF
	uUENIYfA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qZO73-004EsF-1d;
	Fri, 25 Aug 2023 04:07:57 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qYlQ6-000MUI-10;
	Wed, 23 Aug 2023 10:49:06 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 1F89B21EDA;
	Wed, 23 Aug 2023 10:48:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1692787738; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=czbolVCNdiRIhtzRMydBVuDGtNoMVf0uK7rI8VUw4Wg=;
	b=cea+STFByaV36NWMjg8zifEKP9bUJaVFrhrdsQ1BHrDjc+6YKTyOk0XUYe/aGcn7z1GdBW
	Sp5Xg8/PcrR30C9G8GkmtNgleVHgoFT9VpO4HmYAD81nOJQ/2ts6Z2GJ97FCPouubZqTfM
	7Ki5cRwEgj/8O3iByHVAhCDVhrdgZS0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1692787738;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=czbolVCNdiRIhtzRMydBVuDGtNoMVf0uK7rI8VUw4Wg=;
	b=ccloVX/Tox8MPvEstSnU1swyihs7KV2puBqol0j3M4wpbT7Z67JF74RuKmYp8i9zsSQ2aK
	Q/J06H24OiSZjOBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0486813592;
	Wed, 23 Aug 2023 10:48:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id hdjcABrk5WQsIAAAMHmgww
	(envelope-from <jack@suse.cz>); Wed, 23 Aug 2023 10:48:58 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 0E216A0774; Wed, 23 Aug 2023 12:48:57 +0200 (CEST)
From: Jan Kara <jack@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>,
	<linux-fsdevel@vger.kernel.org>,
	<linux-block@vger.kernel.org>,
	Christoph Hellwig <hch@infradead.org>,
	Jan Kara <jack@suse.cz>,
	Alasdair Kergon <agk@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Anna Schumaker <anna@kernel.org>,
	Chao Yu <chao@kernel.org>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Dave Kleikamp <shaggy@kernel.org>,
	David Sterba <dsterba@suse.com>,
	dm-devel@redhat.com,
	drbd-dev@lists.linbit.com,
	Gao Xiang <xiang@kernel.org>,
	Jack Wang <jinpu.wang@ionos.com>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	jfs-discussion@lists.sourceforge.net,
	Joern Engel <joern@lazybastard.org>,
	Joseph Qi <joseph.qi@linux.alibaba.com>,
	Kent Overstreet <kent.overstreet@gmail.com>,
	linux-bcache@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	linux-erofs@lists.ozlabs.org,
	linux-ext4@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	linux-mm@kvack.org,
	linux-mtd@lists.infradead.org,
	linux-nfs@vger.kernel.org,
	linux-nilfs@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	linux-pm@vger.kernel.org,
	linux-raid@vger.kernel.org,
	linux-s390@vger.kernel.org,
	linux-scsi@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	"Md. Haris Iqbal" <haris.iqbal@ionos.com>,
	Mike Snitzer <snitzer@kernel.org>,
	Minchan Kim <minchan@kernel.org>,
	ocfs2-devel@oss.oracle.com,
	reiserfs-devel@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Song Liu <song@kernel.org>,
	Sven Schnelle <svens@linux.ibm.com>,
	target-devel@vger.kernel.org,
	Ted Tso <tytso@mit.edu>,
	Trond Myklebust <trond.myklebust@hammerspace.com>,
	xen-devel@lists.xenproject.org
Subject: [PATCH v3 0/29] block: Make blkdev_get_by_*() return handle
Date: Wed, 23 Aug 2023 12:48:11 +0200
Message-Id: <20230818123232.2269-1-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3781; i=jack@suse.cz; h=from:subject:message-id; bh=cMBb8bZk7tVGWo+BW5D78pH+ebOvNFFLsxdd3Uvzd/w=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBk5ePhrEMij+4xGF6e8K//xuADex0OXIFxlpO0VT6g 42vu5BeJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCZOXj4QAKCRCcnaoHP2RA2RqoB/ 91nt6Qs4NSStbt9M1WXY1akBbAqu+Bv3ZXdZ6WMy9kKyYwY7zCnyQziikP60M2MjCrud4NP9os4YAr 4uXdyOyVcdJ9TjbciDgTyoYdfkFl7g+rZhj1pyPeep1xmvDMn3QtNJ28EbhLegdC+nkmL6+bxPGEwd IdsuBKGrdIIEryWwhBq0+BWowL3nzmQjs5GoDtXLoHADfHYhgC8RKYK/4FaML1/SsAZRvGJ/C8wFB4 JUGsDGFE4CJx9XgiRx407CSIGNSoCciqBpMaMA7x/dbq9Tu76xcqN4/DZrtT2qyG4I7GZYetndEl3F vWMZMQFPauZmB2S1r30HY+nn2IOCrM
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230823_034902_504121_F751EB75 
X-CRM114-Status: GOOD (  17.32  )
X-Mailman-Approved-At: Thu, 24 Aug 2023 21:07:55 -0700
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

Hello,

this is a v3 of the patch series which implements the idea of blkdev_get_by_*()
calls returning bdev_handle which is then passed to blkdev_put() [1]. This
makes the get and put calls for bdevs more obviously matching and allows us to
propagate context from get to put without having to modify all the users
(again!). In particular I need to propagate used open flags to blkdev_put() to
be able count writeable opens and add support for blocking writes to mounted
block devices. I'll send that series separately.

The series is based on Christian's vfs tree as of today as there is quite
some overlap. Patches have passed some reasonable testing - I've tested block
changes, md, dm, bcache, xfs, btrfs, ext4, swap. More testing or review is
always welcome. Thanks! I've pushed out the full branch to:

git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git bdev_handle

to ease review / testing. Since there were not many comments for v2 and
Christoph has acked the series I think we should start discussing how to merge
the series. Most collisions with this series seem to happen in the filesystems
area so VFS tree would seem as the least painful way to merge this. Jens,
are you OK with that?

Changes since v2:
* Rebased on top of current vfs tree
* Added some acks
* Reflected minor nits from Christoph
* Added missing conversion of blkdev_put() calls in cramfs and erofs
* Fixed possible leak of bdev handle in xfs if logdev is the same as fs dev

Changes since v1:
* Rebased on top of current vfs tree
* Renamed final functions to bdev_open_by_*() and bdev_release()
* Fixed detection of exclusive open in blkdev_ioctl() and blkdev_fallocate()
* Fixed swap conversion to properly reinitialize swap_info->bdev_handle
* Fixed xfs conversion to not oops with rtdev without logdev
* Couple other minor fixups

								Honza

[1] https://lore.kernel.org/all/ZJGNsVDhZx0Xgs2H@infradead.org

CC: Alasdair Kergon <agk@redhat.com>
CC: Andrew Morton <akpm@linux-foundation.org>
CC: Anna Schumaker <anna@kernel.org>
CC: Chao Yu <chao@kernel.org>
CC: Christian Borntraeger <borntraeger@linux.ibm.com>
CC: Coly Li <colyli@suse.de
CC: "Darrick J. Wong" <djwong@kernel.org>
CC: Dave Kleikamp <shaggy@kernel.org>
CC: David Sterba <dsterba@suse.com>
CC: dm-devel@redhat.com
CC: drbd-dev@lists.linbit.com
CC: Gao Xiang <xiang@kernel.org>
CC: Jack Wang <jinpu.wang@ionos.com>
CC: Jaegeuk Kim <jaegeuk@kernel.org>
CC: jfs-discussion@lists.sourceforge.net
CC: Joern Engel <joern@lazybastard.org>
CC: Joseph Qi <joseph.qi@linux.alibaba.com>
CC: Kent Overstreet <kent.overstreet@gmail.com>
CC: linux-bcache@vger.kernel.org
CC: linux-btrfs@vger.kernel.org
CC: linux-erofs@lists.ozlabs.org
CC: <linux-ext4@vger.kernel.org>
CC: linux-f2fs-devel@lists.sourceforge.net
CC: linux-mm@kvack.org
CC: linux-mtd@lists.infradead.org
CC: linux-nfs@vger.kernel.org
CC: linux-nilfs@vger.kernel.org
CC: linux-nvme@lists.infradead.org
CC: linux-pm@vger.kernel.org
CC: linux-raid@vger.kernel.org
CC: linux-s390@vger.kernel.org
CC: linux-scsi@vger.kernel.org
CC: linux-xfs@vger.kernel.org
CC: "Md. Haris Iqbal" <haris.iqbal@ionos.com>
CC: Mike Snitzer <snitzer@kernel.org>
CC: Minchan Kim <minchan@kernel.org>
CC: ocfs2-devel@oss.oracle.com
CC: reiserfs-devel@vger.kernel.org
CC: Sergey Senozhatsky <senozhatsky@chromium.org>
CC: Song Liu <song@kernel.org>
CC: Sven Schnelle <svens@linux.ibm.com>
CC: target-devel@vger.kernel.org
CC: Ted Tso <tytso@mit.edu>
CC: Trond Myklebust <trond.myklebust@hammerspace.com>
CC: xen-devel@lists.xenproject.org

Previous versions:
Link: http://lore.kernel.org/r/20230629165206.383-1-jack@suse.cz # v1
Link: http://lore.kernel.org/r/20230810171429.31759-1-jack@suse.cz # v2

