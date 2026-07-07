Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8612C44501
	for <linux-nvme@archiver.kernel.org>; Tue,  7 Jul 2026 12:11:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=ojbX1nEXLeAoCWFrpN7CBWt+bZr7+t+rdnMp6zKWArU=; b=wXpLYR9lkW2irN8yUvxBbDNqP3
	iIu/eY6yme1ZNE/FtvZNImcrftx3mpsTKf/YfIKB0lH04BW+RxeDV0BBkpJeRK10k5DCtQdvIVVzo
	DHRSAX9TRqmQ2hkGv9ZPxtDQmHPxjVPmToYDZEg7RY0hpq+N+3Xi/lfqhl+7Cc47dqK0EybDf503p
	dDX4NTbQgdEM9zwU5wCljbEj02MOAcD+swxKyKXci/OW2l6UWu7J1NpeVqIXkxp+e5dLLs9ZILMLT
	FI6thrfnBHmf53LNvqfM4Bl6MwMeTCDM1vQmOnz1cztG5/KBFldOESfYxEtJapDqXf05IWUwHI7j+
	NpVNRqLg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wh4eA-0000000Ev4V-3lwc;
	Tue, 07 Jul 2026 12:11:30 +0000
Received: from out30-118.freemail.mail.aliyun.com ([115.124.30.118])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wh4e7-0000000Ev2v-2X4E
	for linux-nvme@lists.infradead.org;
	Tue, 07 Jul 2026 12:11:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1783426285; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=ojbX1nEXLeAoCWFrpN7CBWt+bZr7+t+rdnMp6zKWArU=;
	b=cnGiP0KVPADoemrPeql1syhwTu7q33t44z8eiw7RVvvyz3sscu4M6yCBCwX2q2Ff+P9uGDQFl9Wkyzu67+QSVjR9uX1KkZp2baCp1u0roORBQ+OVq26Wcwx4iBhFRgguuNTwuKDVKsUfoJEvp3z70Trf3UApxvShhUZojyUbI5g=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037026112;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0X6dZSVX_1783426281;
Received: from localhost(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0X6dZSVX_1783426281 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 07 Jul 2026 20:11:21 +0800
From: Guixin Liu <kanie@linux.alibaba.com>
To: Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Hannes Reinecke <hare@suse.com>,
	Daniel Wagner <dwagner@suse.de>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: linux-nvme@lists.infradead.org,
	xlpang@linux.alibaba.com,
	oliver.yang@linux.alibaba.com
Subject: [PATCH v2 0/2] nvmet: add namespace-level debugfs for reservation state
Date: Tue,  7 Jul 2026 20:11:12 +0800
Message-ID: <20260707121114.2273629-1-kanie@linux.alibaba.com>
X-Mailer: git-send-email 2.43.7
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260707_051127_804801_43A7385E 
X-CRM114-Status: UNSURE (   8.83  )
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

This series adds debugfs support for inspecting NVMe target reservation
(PR) state at the namespace level.

Patch 1 introduces per-namespace debugfs directories under each subsystem,
providing the infrastructure for namespace-specific debug entries.

Patch 2 adds a 'reservation' file that exposes the persistent reservation
state including enable status, generation counter, notification mask,
holder information, and the full registrant list.

Example output with two registered hosts and an active holder:

  $ cat /sys/kernel/debug/nvmet/testnqn/ns1/reservation
  enable=1
  generation=2
  notify_mask=reg_preempted,resv_released,resv_preempted
  rtype=write_exclusive
  holder=11111111-1111-1111-1111-111111111111,0x1111
  reg=11111111-1111-1111-1111-111111111111,0x1111
  reg=22222222-2222-2222-2222-222222222222,0x2222

v1->v2:
  - Switch the output to a "key=value" line format so it is easier to
    parse from scripts (Daniel Wagner).
  - Emit the registrant list as repeated "reg=" lines instead of a
    "registrants:" header with indented entries.
  - Print the holder as "holder=<uuid>,0x<rkey>" and report an empty
    holder/rtype as "none".
  - Stringify notify_mask as a comma-separated list of masked
    notification names (reg_preempted, resv_released, resv_preempted)
    instead of a raw hex bitmask; empty mask is reported as "none".
  - When reservation is not enabled, print only "enable=0".

Guixin Liu (2):
  nvmet: add namespace-level debugfs directory
  nvmet: expose reservation state through debugfs

 drivers/nvme/target/core.c    |   2 +
 drivers/nvme/target/debugfs.c | 103 ++++++++++++++++++++++++++++++++++
 drivers/nvme/target/debugfs.h |   5 ++
 drivers/nvme/target/nvmet.h   |   3 +
 4 files changed, 113 insertions(+)

-- 
2.43.7


