Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68EC7C982CC
	for <linux-nvme@archiver.kernel.org>; Sun, 20 Sep 2026 03:35:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=85yFdDw7PF3SrJgkZD1DJpFfIoIxAhooFQVZofk5q3U=; b=qW9lqnxRI9kHl7/obwvUsIvT8D
	TlGNX1yoHhT99jL5MtdUlySVuO9WCy5DYuZoubGxEkzp1sa69t6ese3FWxNfaRFVoUYxajmb6D8S1
	Rh2/CvFaFWKzNuxydSL54gT+Bxwj23I5CnjebiQY3DjyhKyhIZ7lVXVtLlvFBkYtSr4xtaFhBppJa
	PK/vniXXW9nfMVwiRvlOOemxIEWmpxTM/PtudAWyafRHKeeC5Z09qbtIFdvqeYlJgymtV1sRB4xKi
	QNYi00mQZEv1fSUrCe7WjGG1H6l3JPLuuwzwygM+bIT1ACrNBKiUQxrVkseFnjhg3/r0GLJw7/ynQ
	IyfvyvsQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x88Kj-0000000GoRf-2Oqm;
	Sun, 20 Sep 2026 03:35:17 +0000
Received: from out30-97.freemail.mail.aliyun.com ([115.124.30.97])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x88Kg-0000000GoQM-1NiN
	for linux-nvme@lists.infradead.org;
	Sun, 20 Sep 2026 03:35:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1789875312; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=85yFdDw7PF3SrJgkZD1DJpFfIoIxAhooFQVZofk5q3U=;
	b=pwvUjvGp2upL7eLyVg2MDvfHcBaPQtfCTqT3TUozbQf9M0jqS4t5To0Q75kerD7hFA1V5z1ZKMhHNmXdR/il5Ueh3ChZlcdzC/b5kf+lLkB6eIRocthXul3DgnD5tSqtH4T5QkKuuHOp5ZecyB/tCOgpt4gb6+V8wJiarora+yU=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037033178;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0XBEwMjz_1789875311;
Received: from localhost(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0XBEwMjz_1789875311 cluster:ay36)
          by smtp.aliyun-inc.com;
          Sun, 20 Sep 2026 11:35:11 +0800
From: Guixin Liu <kanie@linux.alibaba.com>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Nilay Shroff <nilay@linux.ibm.com>,
	Daniel Wagner <dwagner@suse.de>,
	John Garry <john.g.garry@oracle.com>,
	Hannes Reinecke <hare@suse.de>
Cc: linux-nvme@lists.infradead.org
Subject: [PATCH v2 0/2] nvmet: fix FID 82h status codes for invalid NSIDs
Date: Sun, 20 Sep 2026 11:34:58 +0800
Message-ID: <20260920033500.3209138-1-kanie@linux.alibaba.com>
X-Mailer: git-send-email 2.43.7
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260919_203514_882459_7FDCEDFA 
X-CRM114-Status: UNSURE (   9.07  )
X-CRM114-Notice: Please train this message.
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

The Reservation Notification Mask feature (FID 82h) defines its own
status code for NSIDs that do not name a namespace supporting
reservations:

  "A Get Features command that uses a namespace ID of FFFFFFFFh
  shall be aborted with status code of Invalid Field in Command. [...]
  If a Set Features command or a Get Features command attempts to
  access the Reservation Notification Mask on a namespace that does
  not support reservations or is invalid, then that command is
  aborted with status code of Invalid Field in Command."

  -- NVMe Base Specification, section 5.2.26.1.33

nvmet routes the namespace lookup of both handlers through
nvmet_req_find_ns(), which returns Invalid Namespace or Format for an
unknown NSID.  That is the correct status for the generic
namespace-scoped admin commands, but not for this feature.  A Set
Features 82h naming a nonexistent NSID, a Get Features 82h naming a
nonexistent NSID, and a Get Features 82h using the broadcast NSID are
all aborted with Invalid Namespace or Format instead of Invalid Field
in Command.

Each patch fixes one handler and translates the lookup failure to
Invalid Field in Command.  The Set Features broadcast, the
namespace-without-reservations case, the disabled namespace path
(Internal Path Error, commit 505363957fad ("nvmet: fix nvme status
code when namespace is disabled")) and everything else keep their
current behavior.

Verified with two hosts (distinct host identifiers) connected over
NVMe/TCP to an nvmet subsystem exporting two reservation-enabled
null_blk namespaces: all three rejected cases now return 0x6002,
while Set/Get Features on an active namespace, the Set Features
broadcast and the reservation commands behave as before, with no
splat in dmesg.

Changes since v1:

 - drop the comments above the status translation.(Christoph Hellwig)
 - return Invalid Field in Command directly instead of assigning it
   to status first, which also removes the braces and the overly long
   (Christoph Hellwig)

Guixin Liu (2):
  nvmet: return Invalid Field for invalid NSIDs in Set Features 82h
  nvmet: return Invalid Field for invalid NSIDs in Get Features 82h

 drivers/nvme/target/pr.c | 4 ++++
 1 file changed, 4 insertions(+)

-- 
2.43.7


