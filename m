Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AF08CD98F2
	for <linux-nvme@archiver.kernel.org>; Mon, 22 Jun 2026 10:44:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=KzlIfsOwVllmz37cbKp3LC/yt8A+ZRsCeovrWoycdqk=; b=sWq6ONsyKhhdycHmELN36P+e6C
	CI2pNTjEPR7iU5JFpsoQJbeHB2DqLFqVvXrpOn+CFHimDdJiN2HwhPkcrN0IJNSzMm3bJNihE69vI
	lkreDT4zNgyJ8HGdyZA264nR+o1QfhKyt87UgObhOot2FMZ8ivgofAH7fXUgN52P+IM/v2plCg8X7
	Un7zNFdj/KsHmt0z4DwvJxhwseYp3L6f3aHGf6SgHLA2KxX7YO9MQY04ItuBdERZYnnwX7RfBEsiU
	ydfGxQyk4jHRIkHF5frJxAVvRUvs7WfXzGObqdGz3s0WZnfV1zEaRkgW1k6fQSMvpJ+jDU/w2NYRL
	x6ujy8yw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wbc8v-00000004qu2-3R9X;
	Mon, 22 Jun 2026 10:44:41 +0000
Received: from out30-118.freemail.mail.aliyun.com ([115.124.30.118])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wbc8t-00000004qsO-24pN
	for linux-nvme@lists.infradead.org;
	Mon, 22 Jun 2026 10:44:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1782125077; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=KzlIfsOwVllmz37cbKp3LC/yt8A+ZRsCeovrWoycdqk=;
	b=wwZfdYeudHGhRJutFCE6d6oRylsPwXlBI96Els5rLccn7cgEgFfz7QKY3ehcgeAGzbDKnsSFEaKCoi9qqpS8oWXzqGZ+aihVPQc/GcbjbJHottK8nf2wanfK0XQ7JWna9LxCGlwdtMnuZ4Hug3gHKezWxKvrhe7IoRsLQBXbjrw=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045098064;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0X5M.r5f_1782125071;
Received: from localhost(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0X5M.r5f_1782125071 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 22 Jun 2026 18:44:37 +0800
From: Guixin Liu <kanie@linux.alibaba.com>
To: Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Hannes Reinecke <hare@suse.com>
Cc: linux-nvme@lists.infradead.org
Subject: [PATCH 2/2] nvmet: expose reservation state through debugfs
Date: Mon, 22 Jun 2026 18:44:18 +0800
Message-ID: <20260622104418.2070277-3-kanie@linux.alibaba.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260622104418.2070277-1-kanie@linux.alibaba.com>
References: <20260622104418.2070277-1-kanie@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260622_034439_682242_700CB35D 
X-CRM114-Status: GOOD (  10.23  )
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

Add a 'reservation' debugfs file under each namespace directory that
shows the persistent reservation state, including enable status,
generation counter, notify mask, current holder info, and the full
registrant list with hostid and reservation key.

The output uses rcu_read_lock() for safe access to the holder and
registrant_list, consistent with other PR read paths.

Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
---
 drivers/nvme/target/debugfs.c | 54 +++++++++++++++++++++++++++++++++++
 1 file changed, 54 insertions(+)

diff --git a/drivers/nvme/target/debugfs.c b/drivers/nvme/target/debugfs.c
index e6f51eb59010..96d81d446d13 100644
--- a/drivers/nvme/target/debugfs.c
+++ b/drivers/nvme/target/debugfs.c
@@ -153,6 +153,58 @@ static int nvmet_ctrl_tls_concat_show(struct seq_file *m, void *p)
 NVMET_DEBUGFS_ATTR(nvmet_ctrl_tls_concat);
 #endif
 
+static const char *const nvmet_pr_type_names[] = {
+	[NVME_PR_WRITE_EXCLUSIVE]		= "write_exclusive",
+	[NVME_PR_EXCLUSIVE_ACCESS]		= "exclusive_access",
+	[NVME_PR_WRITE_EXCLUSIVE_REG_ONLY]	= "write_exclusive_reg_only",
+	[NVME_PR_EXCLUSIVE_ACCESS_REG_ONLY]	= "exclusive_access_reg_only",
+	[NVME_PR_WRITE_EXCLUSIVE_ALL_REGS]	= "write_exclusive_all_regs",
+	[NVME_PR_EXCLUSIVE_ACCESS_ALL_REGS]	= "exclusive_access_all_regs",
+};
+
+static const char *nvmet_pr_type_to_str(enum nvme_pr_type type)
+{
+	if (type < ARRAY_SIZE(nvmet_pr_type_names) &&
+	    nvmet_pr_type_names[type])
+		return nvmet_pr_type_names[type];
+	return "unknown";
+}
+
+static int nvmet_ns_pr_show(struct seq_file *m, void *p)
+{
+	struct nvmet_ns *ns = m->private;
+	struct nvmet_pr *pr = &ns->pr;
+	struct nvmet_pr_registrant *holder, *reg;
+
+	seq_printf(m, "enable : %d\n", pr->enable);
+	if (!pr->enable)
+		return 0;
+
+	seq_printf(m, "generation : %u\n", atomic_read(&pr->generation));
+	seq_printf(m, "notify_mask : 0x%lx\n", pr->notify_mask);
+
+	rcu_read_lock();
+	holder = rcu_dereference(pr->holder);
+	if (holder) {
+		seq_printf(m, "rtype : %s\n",
+			   nvmet_pr_type_to_str(holder->rtype));
+		seq_printf(m, "holder : hostid=%pUb, rkey=0x%llx\n",
+			   &holder->hostid, holder->rkey);
+	} else {
+		seq_puts(m, "holder : none\n");
+	}
+
+	seq_puts(m, "registrants:\n");
+	list_for_each_entry_rcu(reg, &pr->registrant_list, entry) {
+		seq_printf(m, "  hostid=%pUb, rkey=0x%llx\n",
+			   &reg->hostid, reg->rkey);
+	}
+	rcu_read_unlock();
+
+	return 0;
+}
+NVMET_DEBUGFS_ATTR(nvmet_ns_pr);
+
 void nvmet_debugfs_ns_setup(struct nvmet_ns *ns)
 {
 	char name[16];
@@ -166,6 +218,8 @@ void nvmet_debugfs_ns_setup(struct nvmet_ns *ns)
 		ns->debugfs_dir = NULL;
 		return;
 	}
+	debugfs_create_file("reservation", 0400, ns->debugfs_dir, ns,
+			    &nvmet_ns_pr_fops);
 }
 
 void nvmet_debugfs_ns_free(struct nvmet_ns *ns)
-- 
2.43.7


