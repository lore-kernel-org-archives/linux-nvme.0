Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43DE1CCF2DA
	for <linux-nvme@archiver.kernel.org>; Mon, 19 Oct 2026 03:36:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=LGoilnHoIrnwTalaQV+rlXqkoYFove36Hb60thRpVIM=; b=xrbIDkJCrtNTBeIBzj10MivQFD
	GE2KqHyaGW8vDr2sQZFeEgZLOtPZk/bblE+P7T82cTYS9J+OhKFbH/C08hbeyxSfuN93yy+lIQ5Ms
	q6rMT/cTMdM7fQZwV0A0rNuLr8pQxM/Xp3m29Ap+eXLDonc32hXpdFQwUGc6k1zshucuYsxg5zrq4
	klWMNbcLPgJZxMXwTv7TDNkkiXxxTx0vfCQoVHBKeODVASDn4scv94xoIY0xEvsh5dKjcZpG7nzLw
	QMiNwyhkzidQokvio+H3fgeOL3Jd96AK/jkW3die+bS/6vUgxWmDMkTQ9HbUkRIdEgdG+0fFcpHXX
	3rbBTY1g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xIeB3-00000006Xk5-3lIu;
	Mon, 19 Oct 2026 03:36:45 +0000
Received: from out30-98.freemail.mail.aliyun.com ([115.124.30.98])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xIeAv-00000006Xch-0SvB
	for linux-nvme@lists.infradead.org;
	Mon, 19 Oct 2026 03:36:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1792380995; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=LGoilnHoIrnwTalaQV+rlXqkoYFove36Hb60thRpVIM=;
	b=Vdw3uISkFjXom6KQYjh+RZMIuTAg21NenJ5Zpn5o6VIagOBANHBb4DBvmU/qaVc2GiraITr7j4m3YOKWxOXbHTEHJImc5YACPXlILBPj0i+EkHFJE5WEGj8gzjVSRKcpAW8yJ92wjj+FggyxJqR5ZAL5EFYdaVlJUfqcoXZn5Yw=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033032089153;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0XD-R1Kl_1792380994;
Received: from localhost(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0XD-R1Kl_1792380994 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 19 Oct 2026 11:36:34 +0800
From: Guixin Liu <kanie@linux.alibaba.com>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Nilay Shroff <nilay@linux.ibm.com>,
	Daniel Wagner <dwagner@suse.de>,
	Hannes Reinecke <hare@suse.de>
Cc: linux-nvme@lists.infradead.org
Subject: [PATCH 05/11] nvmet: report the Endurance Group Identifier in the CS-INDEP identify data
Date: Mon, 19 Oct 2026 11:36:18 +0800
Message-ID: <20261019033624.402337-6-kanie@linux.alibaba.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20261019033624.402337-1-kanie@linux.alibaba.com>
References: <20261019033624.402337-1-kanie@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261018_203637_294794_5F8C316C 
X-CRM114-Status: UNSURE (   9.72  )
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

The Identify Namespace data structure (CNS 00h) reports the Endurance
Group Identifier of the namespace, but the I/O Command Set Independent
Identify Namespace data structure (CNS 08h) leaves the field zeroed.
Hosts that implement NVMe 2.0 or later, or that cannot use CNS 00h,
take the Endurance Group Identifier from the CS-INDEP data structure
and thus always see 0, which breaks the consumers of the identifier:
the FDP feature and log pages, and the Rotational Media Information
log page, are addressed by it.

Report the same Endurance Group Identifier as CNS 00h: each namespace
is its own endurance group, so the identifier equals the namespace
identifier.

Assisted-by: LLM
Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
---
 drivers/nvme/target/admin-cmd.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index 7764a3c0195c9..aad5abdb6ef96 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -1081,6 +1081,7 @@ static void nvmet_execute_id_cs_indep(struct nvmet_req *req)
 	id->nstat = NVME_NSTAT_NRDY;
 	id->anagrpid = cpu_to_le32(req->ns->anagrpid);
 	id->nmic = NVME_NS_NMIC_SHARED;
+	id->endgid = cpu_to_le16(req->ns->nsid);
 	if (req->ns->readonly)
 		id->nsattr |= NVME_NS_ATTR_RO;
 	if (req->ns->bdev && bdev_rot(req->ns->bdev))
-- 
2.43.7


