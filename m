Return-Path: <SRS0=oqNq=DJ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB852C4363D
	for <linux-nvme@archiver.kernel.org>; Fri,  2 Oct 2020 08:28:03 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 53A6B206B8
	for <linux-nvme@archiver.kernel.org>; Fri,  2 Oct 2020 08:28:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Urenh21b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53A6B206B8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=0DZ6uq52oaVfREwUDiU99gNKtyIk+xcekokl6N97JCI=; b=Urenh21bnHayoSqUIS9GUv64Rx
	mZMvYMxG118PylWDRFg4tVxur35oPKh5w/x0AIqfUiC+krWQGd5pT3YU9nQe+U9p7g1V509zuEk/V
	h8hevhiRE91UdcQPpTwdIgD9tst94H+dHu39Mqa9bCzwlIy313W7LZ4J/dlaPquJKuZdEaJnCIziT
	pBnrdi4Da+jJwTUxStkM7+i2h5gnOAKVC2IxSHN9T66Vl1lijMMjKZmTFlWFNHq6FzKGBjX9han9T
	xDORGr0exqusy98ygFQG3P0nx9KMk+bP8c94jESKpU9blwy2wZVCGzAC9kBz3G7a+BWv/K0XtLpVZ
	pCE3dZ5Q==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kOGQ1-0006DZ-NH; Fri, 02 Oct 2020 08:27:57 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kOGPy-0006Cn-Qx
 for linux-nvme@lists.infradead.org; Fri, 02 Oct 2020 08:27:55 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 37D19AC82;
 Fri,  2 Oct 2020 08:27:52 +0000 (UTC)
From: Coly Li <colyli@suse.de>
To: davem@davemloft.net, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org, netdev@vger.kernel.org,
 open-iscsi@googlegroups.com, linux-scsi@vger.kernel.org,
 ceph-devel@vger.kernel.org
Subject: [PATCH v10 0/7] Introduce sendpage_ok() to detect misused sendpage in
 network related drivers
Date: Fri,  2 Oct 2020 16:27:27 +0800
Message-Id: <20201002082734.13925-1-colyli@suse.de>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201002_042755_084641_19F2B80C 
X-CRM114-Status: GOOD (  16.21  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: Jens Axboe <axboe@kernel.dk>, Chris Leech <cleech@redhat.com>,
 Vasily Averin <vvs@virtuozzo.com>, Vlastimil Babka <vbabka@suse.com>,
 Cong Wang <amwang@redhat.com>, Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
 Mikhail Skorzhinskii <mskorzhinskiy@solarflare.com>,
 Jeff Layton <jlayton@kernel.org>, linux-kernel@vger.kernel.org,
 Philipp Reisner <philipp.reisner@linbit.com>, Coly Li <colyli@suse.de>,
 Mike Christie <michaelc@cs.wisc.edu>, Hannes Reinecke <hare@suse.de>,
 Lee Duncan <lduncan@suse.com>, Jan Kara <jack@suse.com>,
 Ilya Dryomov <idryomov@gmail.com>, Eric Dumazet <eric.dumazet@gmail.com>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

As Sagi Grimberg suggested, the original fix is refind to a more common
inline routine:
    static inline bool sendpage_ok(struct page *page)
    {
        return  (!PageSlab(page) && page_count(page) >= 1);
    }
If sendpage_ok() returns true, the checking page can be handled by the
concrete zero-copy sendpage method in network layer.

The v10 series has 7 patches, fixes a WARN_ONCE() usage from v9 series,
- The 1st patch in this series introduces sendpage_ok() in header file
  include/linux/net.h.
- The 2nd patch adds WARN_ONCE() for improper zero-copy send in
  kernel_sendpage().
- The 3rd patch fixes the page checking issue in nvme-over-tcp driver.
- The 4th patch adds page_count check by using sendpage_ok() in
  do_tcp_sendpages() as Eric Dumazet suggested.
- The 5th and 6th patches just replace existing open coded checks with
  the inline sendpage_ok() routine.

Coly Li

Cc: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Cc: Chris Leech <cleech@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Cong Wang <amwang@redhat.com>
Cc: David S. Miller <davem@davemloft.net>
Cc: Eric Dumazet <eric.dumazet@gmail.com>
Cc: Hannes Reinecke <hare@suse.de>
Cc: Ilya Dryomov <idryomov@gmail.com>
Cc: Jan Kara <jack@suse.com>
Cc: Jeff Layton <jlayton@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: Lee Duncan <lduncan@suse.com>
Cc: Mike Christie <michaelc@cs.wisc.edu>
Cc: Mikhail Skorzhinskii <mskorzhinskiy@solarflare.com>
Cc: Philipp Reisner <philipp.reisner@linbit.com>
Cc: Sagi Grimberg <sagi@grimberg.me>
Cc: Vasily Averin <vvs@virtuozzo.com>
Cc: Vlastimil Babka <vbabka@suse.com>
---
Changelog:
v10, fix WARN_ONCE() usage, and add Reivewed-by tag from Lee Duncan.
v9, fix a typo pointed out by Greg KH.
    add Acked-by tags from Martin K. Petersen and Ilya Dryomov.
v8: add WARN_ONCE() in kernel_sendpage() as Christoph suggested.
v7: remove outer brackets from the return line of sendpage_ok() as
    Eric Dumazet suggested.
v6: fix page check in do_tcp_sendpages(), as Eric Dumazet suggested.
    replace other open coded checks with sendpage_ok() in libceph,
    iscsi drivers.
v5, include linux/mm.h in include/linux/net.h
v4, change sendpage_ok() as an inline helper, and post it as
    separate patch, as Christoph Hellwig suggested.
v3, introduce a more common sendpage_ok() as Sagi Grimberg suggested.
v2, fix typo in patch subject
v1, the initial version. 

Coly Li (7):
  net: introduce helper sendpage_ok() in include/linux/net.h
  net: add WARN_ONCE in kernel_sendpage() for improper zero-copy send
  nvme-tcp: check page by sendpage_ok() before calling kernel_sendpage()
  tcp: use sendpage_ok() to detect misused .sendpage
  drbd: code cleanup by using sendpage_ok() to check page for
    kernel_sendpage()
  scsi: libiscsi: use sendpage_ok() in iscsi_tcp_segment_map()
  libceph: use sendpage_ok() in ceph_tcp_sendpage()

 drivers/block/drbd/drbd_main.c |  2 +-
 drivers/nvme/host/tcp.c        |  7 +++----
 drivers/scsi/libiscsi_tcp.c    |  2 +-
 include/linux/net.h            | 16 ++++++++++++++++
 net/ceph/messenger.c           |  2 +-
 net/ipv4/tcp.c                 |  3 ++-
 net/socket.c                   |  6 ++++--
 7 files changed, 28 insertions(+), 10 deletions(-)

-- 
2.26.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
