Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8E0EC88E75
	for <linux-nvme@archiver.kernel.org>; Fri, 18 Sep 2026 03:39:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=jwjTDpXRLKwSG5jQ/T+xkPxqn2gUzROn+dUGeCLEO1s=; b=sxK9vNNsGXI7v14tsZrrEWTfnH
	ElXWJCmHM5XSmaUMj0JBjnEbRiKCvxHWgaWlPx40Whxl+spCgqoV8XDNWpTSBra7EJRIGhZSHRD/f
	QQDZ/ATh3vOJAigVHeIwKTu8TtgoX9QqoAvb2JSkDjqHYo9r+rj17CVIQGguiYNTyUfUgrq1GMnQk
	+5jKtocOAkN76m80WGNLXucBcqpGbIBgt6n1OyJmEQHjR45xZ4su7RhaTyp22e/5WQhUzJvZJj26j
	rbFUyypTnt+NwXoKOKlpMiByfjnTeYLvRk3GxHPTe5BNLAiuL3lQqVx40g+Q/LNgexc4u6phm/Kol
	nLqVSQaA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x7PRq-0000000DP1k-1fCP;
	Fri, 18 Sep 2026 03:39:38 +0000
Received: from out30-124.freemail.mail.aliyun.com ([115.124.30.124])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x7PRn-0000000DP0J-3b2w
	for linux-nvme@lists.infradead.org;
	Fri, 18 Sep 2026 03:39:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1789702774; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=jwjTDpXRLKwSG5jQ/T+xkPxqn2gUzROn+dUGeCLEO1s=;
	b=dwp8ADHQhjrXTXQMJxdjZ0eo74ad2WPGbLhP5kuD28288h5uTkndSwcqp1CixCNjUVs6j4+cuu0JFDbGV+3ql7pXBRaqoklew2OdTmSAhrBhgY9QD6SEtVATEiuquqlA9iRCkfmfKP6s8UUrs7TPguNaoGZGgMbEfe/2XIZYNpU=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033032089153;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0XB9qvtE_1789702773;
Received: from localhost(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0XB9qvtE_1789702773 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 18 Sep 2026 11:39:33 +0800
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
Subject: [PATCH 0/2] nvmet: fix FID 82h status codes for invalid NSIDs
Date: Fri, 18 Sep 2026 11:39:30 +0800
Message-ID: <20260918033932.3864965-1-kanie@linux.alibaba.com>
X-Mailer: git-send-email 2.43.7
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260917_203936_025752_C7D07DC9 
X-CRM114-Status: UNSURE (   8.42  )
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

Guixin Liu (2):
  nvmet: return Invalid Field for invalid NSIDs in Set Features 82h
  nvmet: return Invalid Field for invalid NSIDs in Get Features 82h

 drivers/nvme/target/pr.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

-- 
2.43.7

