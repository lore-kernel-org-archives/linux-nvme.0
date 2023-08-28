Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0877CC83F1E
	for <linux-nvme@archiver.kernel.org>; Tue, 29 Aug 2023 15:05:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=QtirhpZ6M4wRBs0PcZuQKaZInNnIQCord7zI9oR3eYc=; b=cHU4KiOS0E8S95CElNF3gaOSN6
	/Tw9ivTm7DCSk9bIByHSJlqtTPbF7htoCf+ZAXdt6X6dL48Nh5HG8ydQcd4uaFpWscQuR8u9qS12u
	eJDD5kHL+l0HUQDIIE20UlExcFj9BzJZuzue28pf8ooZqCExK06dosThEoptxCfr4rt+RK8WaPWHc
	BnkRFwTQBAYdeHachZktJVIkufkGp0SleXKBtQuyCXJXGWxFntjWEx4AnFyZb+0g2oomlH00Mt99c
	wpv1VGwUMRiYOS3/nwqfJZ6T4nOQuaiisrJuMSvL7B/+fztgUuSeiEKCyIxFofl+7m6cseKGpJ3ml
	yIPDTOtg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qb0HO-00BkeI-17;
	Tue, 29 Aug 2023 15:05:18 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qacAz-009cvq-1z;
	Mon, 28 Aug 2023 13:21:06 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 1E9A96187E;
	Mon, 28 Aug 2023 13:21:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6569C433C8;
	Mon, 28 Aug 2023 13:20:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1693228864;
	bh=QtirhpZ6M4wRBs0PcZuQKaZInNnIQCord7zI9oR3eYc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dGzUUvJG87+eWzsz6xzROYCBNDl7W5LTOJNZSdrdj6kC4UZhu/D9tYCBTY1kzrQPe
	 x7WILXB1VLYusnI7i57xbkDNp7AlezoIITxDEYtPZbpKeaRaDjmpnSpx19pqxTzCO1
	 eHWv5jG6Kk405k0HzfGlQ5FnGrphH6RQF/qbsChQZpHtUi1E5k/RJY2W8E0veW1Pw4
	 WmlHIAC8kSpEcFeEGWLjHX2ee4G742ubGUZGwha6A7RHD325wN5SUYbEQ3omUMFDG/
	 CM1aA/cNlMXqkEYlHa/Phek8pvPKy4SQPmUA3IhuobWAQwG6yFUbEhG6jgGYrQO+H2
	 J9dq9/E4F2ZeQ==
Date: Mon, 28 Aug 2023 15:20:47 +0200
From: Christian Brauner <brauner@kernel.org>
To: Jan Kara <jack@suse.cz>
Cc: Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org,
	linux-block@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
	Alasdair Kergon <agk@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Anna Schumaker <anna@kernel.org>, Chao Yu <chao@kernel.org>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Dave Kleikamp <shaggy@kernel.org>, David Sterba <dsterba@suse.com>,
	dm-devel@redhat.com, drbd-dev@lists.linbit.com,
	Gao Xiang <xiang@kernel.org>, Jack Wang <jinpu.wang@ionos.com>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	jfs-discussion@lists.sourceforge.net,
	Joern Engel <joern@lazybastard.org>,
	Joseph Qi <joseph.qi@linux.alibaba.com>,
	Kent Overstreet <kent.overstreet@gmail.com>,
	linux-bcache@vger.kernel.org, linux-btrfs@vger.kernel.org,
	linux-erofs@lists.ozlabs.org, linux-ext4@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net, linux-mm@kvack.org,
	linux-mtd@lists.infradead.org, linux-nfs@vger.kernel.org,
	linux-nilfs@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-pm@vger.kernel.org, linux-raid@vger.kernel.org,
	linux-s390@vger.kernel.org, linux-scsi@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	"Md. Haris Iqbal" <haris.iqbal@ionos.com>,
	Mike Snitzer <snitzer@kernel.org>, Minchan Kim <minchan@kernel.org>,
	ocfs2-devel@oss.oracle.com, reiserfs-devel@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Song Liu <song@kernel.org>, Sven Schnelle <svens@linux.ibm.com>,
	target-devel@vger.kernel.org, Ted Tso <tytso@mit.edu>,
	Trond Myklebust <trond.myklebust@hammerspace.com>,
	xen-devel@lists.xenproject.org, Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH v2 0/29] block: Make blkdev_get_by_*() return handle
Message-ID: <20230828-durften-hauswand-67319ee0c17c@brauner>
References: <20230810171429.31759-1-jack@suse.cz>
 <20230825015843.GB95084@ZenIV>
 <20230825134756.o3wpq6bogndukn53@quack3>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230825134756.o3wpq6bogndukn53@quack3>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230828_062105_700467_5F1AE83C 
X-CRM114-Status: GOOD (  10.56  )
X-Mailman-Approved-At: Tue, 29 Aug 2023 08:05:16 -0700
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

> So besides my last fput() worry about I think this could work and would be
> probably a bit nicer than what I have. But before going and redoing the whole
> series let me gather some more feedback so that we don't go back and forth.
> Christoph, Christian, Jens, any opinion?

I'll be a bit under water for the next few days, I expect but I'll get
back to this. I think not making you redo this whole thing from scratch
is what I'd prefer unless there's really clear advantages. But I don't
want to offer a haphazard opinion in the middle of the merge window.

