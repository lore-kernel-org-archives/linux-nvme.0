Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3048C606A334
	for <linux-nvme@archiver.kernel.org>; Mon,  9 Nov 2026 02:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=JQ5w5sLo;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=oRFR1O0w
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Unsubscribe-Post:List-Owner;
	bh=IJhgZksLq/zxKIdh0ID3t9UQ/fUkyT8exWC4Ufe3Ijc=; b=JQ5w5sLoJYFyz2usP5eUd3vgvg
	iB/KtYmLpnTwZu4+7263KOXa1/DpzLvf+Eiu9UTFSZvzIYabIQC8g1KkU8dk3PwAlkXkaf07OJvss
	vtSrG0g9i88Isbtv+z6n0UIg/MOjkkeHIWtam+JFNxMbNUT7x4/n0d5ESiGp13PaVUrI6jWi02skA
	XMNMkEnKgVLKkfCvmDOAHFz0aDvYQtL6Bn4Faif4+KEyBBddKy0obgrGsKHN5aPeoWqdNktvVnJE4
	morHGgrgsOagyuIR+dX/QKSP4P4d7fpSuTQxJKWdOPXS1k+NsdtqOq3c2BPobrqypjGdd8IaHYPhe
	/Zd22PhA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQF67-0000000H7fS-3SPI;
	Mon, 09 Nov 2026 02:27:03 +0000
Received: from out30-98.freemail.mail.aliyun.com ([115.124.30.98])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQF63-0000000H7cm-2eAD
	for linux-nvme@lists.infradead.org;
	Mon, 09 Nov 2026 02:27:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1794191212; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=IJhgZksLq/zxKIdh0ID3t9UQ/fUkyT8exWC4Ufe3Ijc=;
	b=oRFR1O0wHXq5UN1mNtY1fK/BQIfGgdF05A8JU1ocyxP09Es37p1QMxbIt1fXgSxSXwBF1KebSXjJ9oU/NFXcrm8ST34X4TU3LE1rXcZnt2dw33H18K2L2cTDuUhY0X2eOovhcJr85/ktqmbxJeTcX+8JwhRkBqQ7VgrGmjcprS0=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam011083073210;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0XEIBGf4_1794191211;
Received: from localhost(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0XEIBGf4_1794191211 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 09 Nov 2026 10:26:51 +0800
From: Guixin Liu <kanie@linux.alibaba.com>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Nilay Shroff <nilay@linux.ibm.com>,
	Daniel Wagner <dwagner@suse.de>,
	Hannes Reinecke <hare@suse.de>
Cc: linux-nvme@lists.infradead.org
Subject: [PATCH v2 0/5] nvme: fabrics and target fixes
Date: Mon,  9 Nov 2026 10:26:41 +0800
Message-ID: <20261109022646.290792-1-kanie@linux.alibaba.com>
X-Mailer: git-send-email 2.43.7
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261108_182659_993002_A0AC0744 
X-CRM114-Status: GOOD (  12.83  )
X-Spam-Score: -17.6 (-----------------)
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
X-Spam-Status: No, score=-21.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Five fixes found by code inspection of the nvme host and target
drivers:

 - a reconnect_delay of 0 is accepted through sysfs and makes the
   ctrl_loss_tmo store divide by zero; reproduced on an unfixed
   kernel, rejected on the patched one
 - a use-after-free in nvme_fc_match_disconn_ls(): no iterator is
   sound across the rport lock drop inside the loop, so the loop is
   reworked to run entirely under the rport lock and to take a
   reference only for the match; reproduced under KASAN through fcloop
 - a data race on ctrl->transaction between concurrent per-queue
   DH-HMAC-CHAP exchanges
 - nvmet_subsys_attr_tbkas_store() walks subsys->ctrls without
   subsys->lock, the same bug fixed for qid_max_store() in patch 4
   of this series
 - needless GFP_ATOMIC allocations in the nvmet persistent reservation
   code

The reconnect_delay, tbkas, nvme-auth and persistent reservation fixes
are verified on an initiator/target VM pair running the patched
kernel: connect/IO/disconnect cycles, tbkas toggles racing connection
churn, persistent reservation operations across all six reservation
types, and a full DH-HMAC-CHAP authenticated session with I/O.  The
reworked nvme-fc loop is compile tested and exercised under KASAN
through fcloop with six controllers on one remote port across tbkas
force-reconnect cycles and concurrent disconnects, with no reports.

Changes since v1:

 - rework the nvme-fc fix: neither the _safe iterator nor a plain one
   is sound across the lock drop, as the loop's own put can be the
   final reference; the loop now runs entirely under the rport lock
   and takes a reference only for the match (Hannes Reinecke, sashiko)
 - drop the nvmet_install_queue() patch: the callers already release
   their reference on failure (Hannes Reinecke)
 - use atomic_inc_return() in the nvme-auth patch (Hannes Reinecke)
 - correct the Fixes tag of the reconnect_delay patch to the commit
   that introduced the sysfs store (sashiko, confirmed by Christoph
   Hellwig)

Link: https://lore.kernel.org/all/20261106015842.3534898-1-kanie@linux.alibaba.com/

Guixin Liu (5):
  nvme: reject a reconnect_delay of 0 through sysfs
  nvme-fc: fix use-after-free in nvme_fc_match_disconn_ls()
  nvme-auth: fix data race on ctrl->transaction
  nvmet: take subsys->lock in nvmet_subsys_attr_tbkas_store()
  nvmet: use GFP_KERNEL for PR allocations

 drivers/nvme/host/auth.c       |  2 +-
 drivers/nvme/host/fc.c         | 22 ++++++++++++----------
 drivers/nvme/host/nvme.h       |  2 +-
 drivers/nvme/host/sysfs.c      |  3 +++
 drivers/nvme/target/configfs.c |  2 ++
 drivers/nvme/target/pr.c       |  4 ++--
 6 files changed, 21 insertions(+), 14 deletions(-)

-- 
2.43.7


