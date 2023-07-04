Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0980CC001E0
	for <linux-nvme@archiver.kernel.org>; Wed,  5 Jul 2023 12:05:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=fmLTdco5SVuopuSHDbZ7fgiCJT9fmPtnstwBD5O0cVs=; b=lRwW6dde2cc/yQQDGMXRnQBfeE
	4mw9CBl5WWYGCnU/45tCGkrWts9CieZEdrqFsEh+19yqoES3hQuSa3AYwWdAl0iOIRNfapYclkUHU
	IA7t2zuhNhIhVQKrBKT+n0jpe2DEVmD2MuCLVjtQQzNP6gCdJLJFOXdtQrL3CDA4qUlmNvJtW+Sqx
	643dC25RarxClzbZqK2nxs8LYJBVGxU5uBPQc4dRLE1St975gcPPSVM+Q/VmLdD3pIADfXr3FPAne
	0n0XaR8r9ebCeBlqmqEKCilYNhEfxM+KyeqgETydIHvYg/55nHNPio5IPuoBEK9pQkO+SDYIL3y+a
	lDJuMLhQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qH1Fx-00FnxJ-2A;
	Wed, 05 Jul 2023 12:05:13 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qGf38-00DFCT-3D;
	Tue, 04 Jul 2023 12:22:32 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 37C1422864;
	Tue,  4 Jul 2023 12:22:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1688473345; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=fmLTdco5SVuopuSHDbZ7fgiCJT9fmPtnstwBD5O0cVs=;
	b=LYS1cAt6t7JDeaXCZA2GfkFsvePsCKrBv683wLJKbeQdnB0RB5kex3lpjPlaO0WNrRIj/p
	OKov+tjGtn08tmzrJU88unG7OZdlwokmKgdGkl+OG4epxE3GA77hqhJZhG3Z0dN3YI1cPw
	0UrvrW8qrgzkAVKwdQJPDUFGAz/meEU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1688473345;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=fmLTdco5SVuopuSHDbZ7fgiCJT9fmPtnstwBD5O0cVs=;
	b=Dse69eRRr1j+O/QtQVzrTyIAnqxKgXzcDp3QAv4KDKTfaZG4HjcsXtXKNaEGDfzmeYyIxx
	WQrcOQN123NhV6Dg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1D4941346D;
	Tue,  4 Jul 2023 12:22:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id j8gfBwEPpGQFMAAAMHmgww
	(envelope-from <jack@suse.cz>); Tue, 04 Jul 2023 12:22:25 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 915DAA0722; Tue,  4 Jul 2023 14:22:24 +0200 (CEST)
From: Jan Kara <jack@suse.cz>
To: <linux-block@vger.kernel.org>
Cc: <linux-fsdevel@vger.kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
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
Subject: [PATCH RFC 0/32] block: Make blkdev_get_by_*() return handle
Date: Tue,  4 Jul 2023 14:21:27 +0200
Message-Id: <20230629165206.383-1-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2471; i=jack@suse.cz; h=from:subject:message-id; bh=ceZQTtdZjpsFiBb9Fva7YX0lOa2i6Zx53n9hl/3+KQM=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBkpA7DYrlV/5vfqjK0juEsCaKDoUZ39z4YDWexB9PO aQyP7ZaJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCZKQOwwAKCRCcnaoHP2RA2S48B/ 476l3pggtn8igKmRoHswxXv63Ks68g/08HDzIZqCtDPA84BSKd93Nq0m/Wn76G+ubHQpfg8PMw5+DG uV+DOTR+NEYKAToQQ8YzmS6RAGasKKWUg3k1pr7jK23l+wcq16ImmBXmWM3nr2j85QcDZeB+vpUKHh bdQJQsBOqKsA+qlImgVwvMS+V4UTLQcIYQo2bDBl0TIbJB0UiXYMYHcvrEkwNZWybXBs+wfERrXuF1 XlXO6rWvLyW94kkpvaZTvPY+yZd7tOLd+W8gsz2uBFG9QJg57aDkZxf6NA+Qxf2O8uwfWiyb1XXBN8 I1wYA/sSduibCw4tF4sYb/wERvIAO+
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230704_052231_199014_0D33B101 
X-CRM114-Status: GOOD (  14.17  )
X-Mailman-Approved-At: Wed, 05 Jul 2023 05:05:12 -0700
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

this patch series implements the idea of blkdev_get_by_*() calls returning
bdev_handle which is then passed to blkdev_put() [1]. This makes the get
and put calls for bdevs more obviously matching and allows us to propagate
context from get to put without having to modify all the users (again!).
In particular I need to propagate used open flags to blkdev_put() to be able
count writeable opens and add support for blocking writes to mounted block
devices. I'll send that series separately.

The series is based on Linus' tree as of yesterday + two bcache fixes which are
in the block tree. Patches have passed some basic testing, I plan to test more
users once we agree this is the right way to go.

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


