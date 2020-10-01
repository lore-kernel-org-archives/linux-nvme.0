Return-Path: <SRS0=dhBa=DI=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CF91C4727E
	for <linux-nvme@archiver.kernel.org>; Thu,  1 Oct 2020 07:54:46 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 207EB21707
	for <linux-nvme@archiver.kernel.org>; Thu,  1 Oct 2020 07:54:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="R823U7aL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 207EB21707
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=sTHMayh4Y6eTpiLzYolByXQ/39xiY02rGZxDXxlR6BI=; b=R823U7aLzNjIAdWtyybPsJMWFe
	/M6IfgfJlAHsvphz86pkEXTLgubGVW7aUxHIdVGB5QL6QRFL4XIOllvMmu+zTEdGtUG9zUU+6qNfT
	dox88s9fhWjvf/fsgcahDIfGdsIEl61luoMakq++upk8An25uKwdERpKUkSAVfhiVC24w6KCMPKzN
	molXDKRqf0mDKAvCe66k4m8c230tJbemRE25NIzC928Q+wbK9XQB6LrRXTM5Bmw4XRvIhQxj5RjQd
	KwZCoRKuncA4r7Bxt8mZZf30pcnIy8YAvYjw1q9+wHBjpw/ITXZavFmrpjgQv0EWxz7TmeyVRTJHa
	z/rKC03Q==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kNtQF-0004HV-VI; Thu, 01 Oct 2020 07:54:40 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kNtQD-0004GG-Fq
 for linux-nvme@lists.infradead.org; Thu, 01 Oct 2020 07:54:38 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 1A9C6AC97;
 Thu,  1 Oct 2020 07:54:35 +0000 (UTC)
From: Coly Li <colyli@suse.de>
To: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
 netdev@vger.kernel.org, open-iscsi@googlegroups.com,
 linux-scsi@vger.kernel.org, ceph-devel@vger.kernel.org
Subject: [PATCH v9 0/7] Introduce sendpage_ok() to detect misused sendpage in
 network related drivers
Date: Thu,  1 Oct 2020 15:54:01 +0800
Message-Id: <20201001075408.25508-1-colyli@suse.de>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201001_035437_748204_0F5137A1 
X-CRM114-Status: GOOD (  16.58  )
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
 "David S . Miller" <davem@davemloft.net>,
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

This series was original by a bug fix in nvme-over-tcp driver which only
checked whether a page was allocated from slab allcoator, but forgot to
check its page_count: The page handled by sendpage should be neither a
Slab page nor 0 page_count page.

As Sagi Grimberg suggested, the original fix is refind to a more common
inline routine:
    static inline bool sendpage_ok(struct page *page)
    {
        return  (!PageSlab(page) && page_count(page) >= 1);
    }
If sendpage_ok() returns true, the checking page can be handled by the
concrete zero-copy sendpage method in network layer.

The v9 series has 7 patches, no change from v8 series,
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
