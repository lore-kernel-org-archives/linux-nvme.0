Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D51FC43458
	for <linux-nvme@archiver.kernel.org>; Tue,  7 Jul 2026 12:11:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=fFdOIgps0nzKNrV1jafg2ZMKQtxoa8DmsXsYlSCxZXo=; b=tqAyXcn/EO3ctcTln9636XtFl8
	ygZ8zX8Ve0fogld+gwl6rzdD38CFTE/N+lNbPi4sZ4PKg7kDzYqqhjkdCvAMYW54z6uor9QHu3yd/
	0VUoFs0AHKzf5MhgjCSYTmwM0WaPkWobPTKSQPOdv0nKUc+/jNhJPECPUwzlXTZZuqxEzX238eNhm
	op9s3LoIAZOL/lFKN8Dc2eRvDWsPPW7bVjvsOBhBCRwTM5raF2oR/Gg7TPFfNtCVE8/gCHChWMxJs
	qfuO89sP+d6vA9JwWcq2+ikbWkvWmMZcABp7m4ClSsjae9tgxB9viKXxm0O+i3zwA4t7JSbm0DOk+
	pVzPU8pQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wh4eA-0000000Ev4c-49AP;
	Tue, 07 Jul 2026 12:11:30 +0000
Received: from out30-113.freemail.mail.aliyun.com ([115.124.30.113])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wh4e7-0000000Ev2s-1277
	for linux-nvme@lists.infradead.org;
	Tue, 07 Jul 2026 12:11:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1783426284; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=fFdOIgps0nzKNrV1jafg2ZMKQtxoa8DmsXsYlSCxZXo=;
	b=fCBvimHH9KkqLTSYeYWP7nb602yc9ROHoiLKIfWmPtud+1IbmmSt92zp6oAxjD1v0jSvOR4l1nbZ8cT6sHflhYEoS8Cb+oeyK+tng/+I7aE5CSq9eSuhRsxp3S/lmWHtl4S1Z+0OyfCpF7/z8rEZ4iUrKbdsQpdcQjv0WUU6NKI=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R781e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045133197;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0X6dVoxM_1783426283;
Received: from localhost(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0X6dVoxM_1783426283 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 07 Jul 2026 20:11:23 +0800
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
Subject: [PATCH v2 2/2] nvmet: expose reservation state through debugfs
Date: Tue,  7 Jul 2026 20:11:14 +0800
Message-ID: <20260707121114.2273629-3-kanie@linux.alibaba.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260707121114.2273629-1-kanie@linux.alibaba.com>
References: <20260707121114.2273629-1-kanie@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260707_051127_805423_A0080FB8 
X-CRM114-Status: GOOD (  14.12  )
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

Each attribute is emitted as a single "key=value" line so the output is
easy to parse from scripts. The registrant list is emitted as repeated
"reg=" lines. The notify mask is emitted as a comma-separated list of
masked notification names. Empty values are reported as "none". Example
output:

    enable=1
    generation=2
    notify_mask=reg_preempted,resv_released,resv_preempted
    rtype=write_exclusive
    holder=11111111-1111-1111-1111-111111111111,0x1111
    reg=11111111-1111-1111-1111-111111111111,0x1111
    reg=22222222-2222-2222-2222-222222222222,0x2222

When reservation is not enabled only "enable=0" is printed.

The output uses rcu_read_lock() for safe access to the holder and
registrant_list, consistent with other PR read paths.

Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
---
 drivers/nvme/target/debugfs.c | 82 +++++++++++++++++++++++++++++++++++
 1 file changed, 82 insertions(+)

diff --git a/drivers/nvme/target/debugfs.c b/drivers/nvme/target/debugfs.c
index e6f51eb59010..e85fe1d4c9f8 100644
--- a/drivers/nvme/target/debugfs.c
+++ b/drivers/nvme/target/debugfs.c
@@ -153,6 +153,86 @@ static int nvmet_ctrl_tls_concat_show(struct seq_file *m, void *p)
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
+static const char *const nvmet_pr_notify_names[] = {
+	[NVME_PR_NOTIFY_BIT_REG_PREEMPTED]	= "reg_preempted",
+	[NVME_PR_NOTIFY_BIT_RESV_RELEASED]	= "resv_released",
+	[NVME_PR_NOTIFY_BIT_RESV_PREEMPTED]	= "resv_preempted",
+};
+
+static void nvmet_pr_notify_mask_to_str(struct seq_file *m, unsigned long mask)
+{
+	bool sep = false;
+	int i;
+
+	if (!mask) {
+		seq_puts(m, "none");
+		return;
+	}
+
+	for (i = 0; i < ARRAY_SIZE(nvmet_pr_notify_names); i++) {
+		if (!test_bit(i, &mask) || !nvmet_pr_notify_names[i])
+			continue;
+		if (sep)
+			seq_putc(m, ',');
+		seq_puts(m, nvmet_pr_notify_names[i]);
+		sep = true;
+	}
+}
+
+static int nvmet_ns_pr_show(struct seq_file *m, void *p)
+{
+	struct nvmet_ns *ns = m->private;
+	struct nvmet_pr *pr = &ns->pr;
+	struct nvmet_pr_registrant *holder, *reg;
+
+	seq_printf(m, "enable=%d\n", pr->enable);
+	if (!pr->enable)
+		return 0;
+
+	seq_printf(m, "generation=%u\n", atomic_read(&pr->generation));
+	seq_puts(m, "notify_mask=");
+	nvmet_pr_notify_mask_to_str(m, pr->notify_mask);
+	seq_putc(m, '\n');
+
+	rcu_read_lock();
+	holder = rcu_dereference(pr->holder);
+	if (holder) {
+		seq_printf(m, "rtype=%s\n",
+			   nvmet_pr_type_to_str(holder->rtype));
+		seq_printf(m, "holder=%pUb,0x%llx\n",
+			   &holder->hostid, holder->rkey);
+	} else {
+		seq_puts(m, "rtype=none\n");
+		seq_puts(m, "holder=none\n");
+	}
+
+	list_for_each_entry_rcu(reg, &pr->registrant_list, entry) {
+		seq_printf(m, "reg=%pUb,0x%llx\n",
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
@@ -166,6 +246,8 @@ void nvmet_debugfs_ns_setup(struct nvmet_ns *ns)
 		ns->debugfs_dir = NULL;
 		return;
 	}
+	debugfs_create_file("reservation", 0400, ns->debugfs_dir, ns,
+			    &nvmet_ns_pr_fops);
 }
 
 void nvmet_debugfs_ns_free(struct nvmet_ns *ns)
-- 
2.43.7


