Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDBE4C4707B
	for <linux-nvme@archiver.kernel.org>; Sun, 14 Jan 2024 09:24:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=l56WTWDeVzTThGHK323COXC1JmPuhWl/u/6lcIadfcs=; b=ek27YRjuWNp3vMdbUujGoTuojq
	gGfYBssqI9DTAKGkg3spYXaKaJiooF3HnHFMxMLtpaO6LcR2DFtStRkp84JH+rBMhNazy0PB7qkxP
	IfT6W6PyE7dHXE723yShc3gf/mF8aZW1/L3G4pvg3LIVURFYLSOW6x2VVg4Fu3odXuWyjCbIR36Cq
	lJGzf+qhewiKapMJwFEf73vuSe0GkLlXRhP5NNJULfzcArq6fjbG8NxDSF7LnH9v64DfQ4vCDLEcW
	TnSou+EyVQQXl47pgQny7r1Fw8VoOCdfH5vHQ/VrPy49ou2lKuvOocOJA04QMSnY02mId0Evs37f0
	3MCsfgIQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rOwiO-006NIj-1R;
	Sun, 14 Jan 2024 09:23:36 +0000
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rOwiK-006NHT-1X
	for linux-nvme@lists.infradead.org;
	Sun, 14 Jan 2024 09:23:34 +0000
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R641e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0W-XdCeK_1705224194;
Received: from localhost(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0W-XdCeK_1705224194)
          by smtp.aliyun-inc.com;
          Sun, 14 Jan 2024 17:23:20 +0800
From: Guixin Liu <kanie@linux.alibaba.com>
To: hch@lst.de,
	sagi@grimberg.me,
	kch@nvidia.com,
	chaitanyak@nvidia.com
Cc: linux-nvme@lists.infradead.org
Subject: [PATCH V2 0/3] *** Implement the NVMe reservation feature ***
Date: Sun, 14 Jan 2024 17:23:11 +0800
Message-ID: <20240114092314.63694-1-kanie@linux.alibaba.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240114_012332_674837_D71C8F85 
X-CRM114-Status: GOOD (  14.69  )
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

Hi guys,
    I've implemented the NVMe reservation feature. Please review it, all 
comments are welcome as usual.

Changes from v1 to v2:
- Implement the reservation notification report, includes registration
preempted, reservation released and reservation preempted.
  And also handle the reservation log page avaliable event and send get
reservation log page command to clear log page at host.

- Put the reservation check access after validate opcode. And remove
opcodes which nvmet not implement yet check.
  Now there is no admin opcode nvmet implemented needs reservation check,
so I dont add reservation check to admin command path.
  Next we need to do reservation check includes the situation of nsid is
0xffffffff at each admin command path, if it is needed.

- Add reservation commands support in nvmet_get_cmd_effects_nvm().

- From Chaitanya, change the local variable tree style to make it cleaner,
and add some comments about NVMe spec.
  And also change others advice from chaitanya.

- Put the nvmet_pr_check_cmd_access and nvmet_parse_pr_cmd into reservation
enable check warp.

- Remove kmem_cache instead to use kmalloc and kfree.

- Change others advice from Sagi.

- Add a blktest test case, this patch will be sent before these series of
pathes.

Advice I dont adopt:
- From Sagi, use rcu instead of rwlock.
  I need protect registrant_list, holder, type and generation simutaneously,
the rcu can not protect multiple units.

- From Sagi, use blkdev's pr_ops if it is exist.
  The backend is unable to distinguish connections from the frontend, If we
use the pr_ops of the block device, the block device's target would only
recognize it as a reservation by the nvme target.
  Could you plz give me more information? Sagi?

- From Keith, use nvmet_get_cmd_effects_nvm to see if a command would violate
a reservation.
  The information is missing in effects, for example the flush command should
be checked, but there is onely a  NVME_CMD_EFFECTS_CSUPP flag in effects, no
LBCC.

Guixin Liu (3):
  nvmet: support reservation feature
  nvmet: unify aer type enum
  nvme: introduce pr_work to handle resv event

 drivers/nvme/host/core.c        |  47 +-
 drivers/nvme/host/nvme.h        |   1 +
 drivers/nvme/target/Makefile    |   2 +-
 drivers/nvme/target/admin-cmd.c |  14 +-
 drivers/nvme/target/configfs.c  |  27 +
 drivers/nvme/target/core.c      |  53 +-
 drivers/nvme/target/discovery.c |   2 +-
 drivers/nvme/target/nvmet.h     |  33 ++
 drivers/nvme/target/pr.c        | 887 ++++++++++++++++++++++++++++++++
 include/linux/nvme.h            |  54 +-
 10 files changed, 1103 insertions(+), 17 deletions(-)
 create mode 100644 drivers/nvme/target/pr.c

-- 
2.43.0


