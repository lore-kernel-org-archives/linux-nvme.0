Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CAE4C88E75
	for <linux-nvme@archiver.kernel.org>; Fri, 18 Sep 2026 03:38:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=jwjTDpXRLKwSG5jQ/T+xkPxqn2gUzROn+dUGeCLEO1s=; b=3R1R7xOYijK6+wrimEF4uc4DP6
	KF0niHJWwngnj9HAOwVYMJk3Dpxz3cAM1oHg9iPl3kjUkWU2hLn78Gf+nGAFt9MrlkTDB2gM/2vj+
	WaUS3JqD+0jPLF9OE2+JDtSfUAwxcdE5jVIf8eqDQb+/no/TNeQvRTI2kJp77H3nJrl5zWvJXKe+B
	YZJyH4U83Sa5CyCBtLRYlyegyklHcdgcYa1/AtkIaU3O41eoUBfcW+qkPAYyOLCbe67QeXDst0KA0
	xQEmnupokbhe+ZqKzSZbT1GAhsURkLJSBdduylaQHtxAmVDe+f0hnPmoSkD6/Os4Tm+PORlIlleVG
	hzlpSFMQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x7PQm-0000000DOok-0R5m;
	Fri, 18 Sep 2026 03:38:32 +0000
Received: from out30-98.freemail.mail.aliyun.com ([115.124.30.98])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x7PQk-0000000DOo3-266i
	for linux-nvme@lists.infradead.org;
	Fri, 18 Sep 2026 03:38:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1789702708; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=jwjTDpXRLKwSG5jQ/T+xkPxqn2gUzROn+dUGeCLEO1s=;
	b=gTCzktzbgBfcHjDjknckAsm4Ccq4zc7jIMs2x8hWZwzZJSe6GPWWKz06vi4Ip35BzYoDJmdMaY8XVV6MXbc/++/pqvDO6lsFn1KHcAkieJpXkmTxVZiSExEdq0Pdi7F+H8H4+RczOMi++SJeUz+dY1TK30eE0oCJxjuze4l655o=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045133197;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0XB9nYzH_1789702707;
Received: from localhost(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0XB9nYzH_1789702707 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 18 Sep 2026 11:38:27 +0800
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
Date: Fri, 18 Sep 2026 11:38:26 +0800
Message-ID: <20260918033826.3863309-1-kanie@linux.alibaba.com>
X-Mailer: git-send-email 2.43.7
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260917_203830_673897_14F035A5 
X-CRM114-Status: UNSURE (   8.34  )
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

