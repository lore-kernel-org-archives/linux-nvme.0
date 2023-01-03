Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C04E0C46467
	for <linux-nvme@archiver.kernel.org>; Tue,  3 Jan 2023 10:15:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+UrPlhVbvMGxYYFr55itH3meDxeO1DdYUgEw5xf81Pk=; b=NxnbGYi6N+YjUSILq7EdV4+4FA
	VHo6rZ2uq4lsVetyI+Dh+UYM4eDdSFf3LW+GTsAhoBJYNxV6grrVOLQxBkvWaAORX6841CoNgVbs3
	4AwCRn0FCQktoG5hLyMlorHvSCfDdgoEgdSrH+kqBm3XlxlrX9O8j+YkSnlYc58xvKy9JAkfN1YUe
	iObmOQ5bhGi5Bj8iTeLm64H4iDBN70ktl8auVJfHfBIxuIAX0WtpSRyYIWEaHoWfcodmcmVN6cOCq
	JvN1KShZrfDau7xEnENyv19za6lqzlNfN3ESyeimWxT6LWc6Lv0pNl95V7B896w/pKGXHnBaffhaW
	lzWL7g+w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pCeKS-000f7a-EW; Tue, 03 Jan 2023 10:15:32 +0000
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pCe9t-000bj0-6A
	for linux-nvme@lists.infradead.org; Tue, 03 Jan 2023 10:04:39 +0000
Received: by mail-pl1-x636.google.com with SMTP id d3so32085311plr.10
        for <linux-nvme@lists.infradead.org>; Tue, 03 Jan 2023 02:04:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+UrPlhVbvMGxYYFr55itH3meDxeO1DdYUgEw5xf81Pk=;
        b=YzuJOSskLRuuA1Er8uFclIrEossKOqAIv82ELvTXBAqF1YXAsugi406Imq62kou9nh
         oG0dfUdbqS8m3NhIN/bT5bOVe6Jllyc3W4BJ53oHbfaunYxXzJmry+KzfTBZ/FDZT0za
         myKulvDxmXlBkl/wsstVxR4rvW91bCksX8H8Us+mwlsy+LJDevmbiAhwe31tdT97JDEF
         wXyiMyTRS8+9l2G2o18WJYtx8eOI6erSHfArThC8PvuTmTxIZkFpOJ/KU9UkEVbJQp0/
         2zrKNmuif3+CAtn/m04NJMFJaODGdPCy9AP1hYMkBWrQiv1JlRBnHxGQwkCWT4jTkrFS
         f21g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+UrPlhVbvMGxYYFr55itH3meDxeO1DdYUgEw5xf81Pk=;
        b=dFDNwzgz5nHZVIOx7IJCYHJFjzCnk9/XtSs71uX1gDD6B9mFq6zhFAk9mharU5fW1/
         BUd0q9aTgCuzlU9Sc84ATK61LLeGxO300zxna0w2TpeEb/QZn4gLDmGcOLmKKEnxZ8b5
         ZT/bJxYX8j8Mc+L0zNYaedc5pxMrdfPxNFkAbFb2RH63BGqzTonurjMN27jGFnmGhKkL
         4NFEEAuGBfw9IlZ5WTIOhAujmSkSvHQksMEmyAZGO5YTF/yoDTiiZSxzdZozr4TiVoV1
         MpB3TF1ob1UPBkEesZ6fZUM95S7bWm6DMN8tlo/z+fD1v2qIjyElEhqhhwLKYGC4j3o2
         CHow==
X-Gm-Message-State: AFqh2kpIzmBEfD8V0+NSMwUH65mNU9+Ca89d4fyMOVPPvlTtbQUyISxu
	8aHEhESiuKAjSS3ekGg/ZoMxAWg8JE//Lg==
X-Google-Smtp-Source: AMrXdXvnw21aOUPHNx22YpqSiCHS8YRlA8OyFmhfIA8ZyvLj73lAcMpcmHc5fxMRqrlEVNUlPwDmIg==
X-Received: by 2002:a17:90a:b102:b0:225:c712:5df8 with SMTP id z2-20020a17090ab10200b00225c7125df8mr45528233pjq.3.1672740274636;
        Tue, 03 Jan 2023 02:04:34 -0800 (PST)
Received: from ap.. ([182.213.254.91])
        by smtp.gmail.com with ESMTPSA id j14-20020a17090a2a8e00b002187a4dd830sm14311691pjd.46.2023.01.03.02.04.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Jan 2023 02:04:33 -0800 (PST)
From: Taehee Yoo <ap420073@gmail.com>
To: linux-nvme@lists.infradead.org,
	kbusch@kernel.org,
	axboe@fb.com,
	hch@lst.de,
	sagi@grimberg.me,
	kch@nvidia.com
Cc: james.p.freyensee@intel.com,
	ming.l@ssi.samsung.com,
	larrystevenwise@gmail.com,
	anthony.j.knapp@intel.com,
	pizhenwei@bytedance.com,
	ap420073@gmail.com
Subject: [PATCH 2/4] nvme: fix reset uninitialized controller
Date: Tue,  3 Jan 2023 10:03:55 +0000
Message-Id: <20230103100357.875854-3-ap420073@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230103100357.875854-1-ap420073@gmail.com>
References: <20230103100357.875854-1-ap420073@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230103_020437_287091_90A04644 
X-CRM114-Status: GOOD (  18.70  )
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

nvme-fabric controllers can be reset by
/sys/class/nvme/nvme#/reset_controller
echo 1 > /sys/class/nvme/nvme#/reset_controller
The above command will call nvme_sysfs_reset().

This function internally calls ctrl->reset_work synchronously or
asynchronously.
At this point, it doesn't sure if the controller will be reset after
initialization.

So kernel panic would occur because ctrl->reset_work dereferences
uninitialized values.

In order to avoid this, nvme_sysfs_reset checks
the NVME_CTRL_STARTED_ONCE flag. This flag indicates the controller is
initialized fully. So, reset logic can be executed safely.

WARNING: CPU: 1 PID: 462 at kernel/workqueue.c:3066 __flush_work+0x74f/0x960
Modules linked in: nvme_tcp xt_conntrack xt_MASQUERADE nf_conntrack_netlink xfrm_user xt_addrtype iptable_filter iptable_nat br_netfilter bridge stp llc crct10dif_pclmul crc32_generic crc32_pclmul crc32c_intel ghash_clmulni_intel sha512_ssse3 overlay openvswitch nsh nf_conncount nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 mlx5_ib ib_uverbs ib_core xts cts ecb mlx5_core aesni_intel crypto_simd cryptd mlxfw ptp sch_fq_codel nf_tables nfnetlink ip_tables x_tables unix
CPU: 1 PID: 462 Comm: kworker/u16:5 Not tainted 6.1.0+ #52 1d16bdc3867491ba5cf2147d49bd76d7eacb8fd9
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1ubuntu1 04/01/2014
Workqueue: nvme-reset-wq nvme_reset_ctrl_work [nvme_tcp]
RIP: 0010:__flush_work+0x74f/0x960
Code: c0 74 6c e8 53 97 17 00 48 c7 c6 c8 4a 1b 84 48 c7 c7 80 70 b9 8e 45 31 f6 e8 cd 53 0f 00 e9 5d fd ff ff 0f 0b e9 56 fd ff ff <0f> 0b 45 31 f6 e9 4c fd ff ff 4c 89 ef e8 4f 81 2a 02 e8 ea 75 16
RSP: 0018:ffff888116507a50 EFLAGS: 00010246
RAX: ffff88800646b490 RBX: 0000000000000011 RCX: 1ffffffff1e59f99
RDX: dffffc0000000000 RSI: 0000000000000001 RDI: ffff88800646b490
RBP: ffff888116507be8 R08: 0000000000000000 R09: 0000000000000000
R10: ffffed1000c8d692 R11: 0000000000000001 R12: 1ffff11022ca0f50
R13: 1ffff11022ca0f80 R14: 0000000000000001 R15: ffff88800646b4a8
FS:  0000000000000000(0000) GS:ffff888117a00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055953af11fd0 CR3: 0000000106f62001 CR4: 00000000003706e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 ? _raw_spin_unlock_irqrestore+0x59/0x70
 ? queue_delayed_work_on+0xa0/0xa0
 ? lock_release+0x631/0xe80
 ? __up_read+0x192/0x730
 ? up_write+0x520/0x520
 ? rcu_read_lock_sched_held+0x12/0x80
 ? lock_release+0x631/0xe80
 ? rcu_read_lock_sched_held+0x12/0x80
 ? try_to_grab_pending.part.0+0x23/0x540
 __cancel_work_timer+0x2cb/0x3f0
 ? cancel_delayed_work+0x10/0x10
 ? rcu_read_lock_sched_held+0x12/0x80
 ? lock_acquire+0x4f4/0x630
 ? lockdep_hardirqs_on_prepare+0x410/0x410
 ? lock_downgrade+0x700/0x700
 ? finish_task_switch.isra.0+0x23b/0x870
 ? trace_hardirqs_on+0x3c/0x190
 nvme_stop_ctrl+0x17/0x150
 nvme_reset_ctrl_work+0x19/0x120 [nvme_tcp aa1d0deebfd175637ed368a54a16dfbb09be290f]
[ ... ]

Fixes: f3ca80fc11c3 ("nvme: move chardev and sysfs interface to common code")
Signed-off-by: Taehee Yoo <ap420073@gmail.com>
---
 drivers/nvme/host/core.c | 28 +++++++++++++++++++---------
 1 file changed, 19 insertions(+), 9 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index cd4c80ca66d4..418bd865c838 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -134,6 +134,14 @@ void nvme_queue_scan(struct nvme_ctrl *ctrl)
 		queue_work(nvme_wq, &ctrl->scan_work);
 }
 
+void nvme_queue_scan_sync(struct nvme_ctrl *ctrl)
+{
+	if (ctrl->state == NVME_CTRL_LIVE && ctrl->tagset) {
+		queue_work(nvme_wq, &ctrl->scan_work);
+		flush_work(&ctrl->scan_work);
+	}
+}
+
 /*
  * Use this function to proceed with scheduling reset_work for a controller
  * that had previously been set to the resetting state. This is intended for
@@ -1150,10 +1158,8 @@ void nvme_passthru_end(struct nvme_ctrl *ctrl, u32 effects,
 		dev_info(ctrl->device,
 "controller capabilities changed, reset may be required to take effect.\n");
 	}
-	if (effects & (NVME_CMD_EFFECTS_NIC | NVME_CMD_EFFECTS_NCC)) {
-		nvme_queue_scan(ctrl);
-		flush_work(&ctrl->scan_work);
-	}
+	if (effects & (NVME_CMD_EFFECTS_NIC | NVME_CMD_EFFECTS_NCC))
+		nvme_queue_scan_sync(ctrl);
 
 	switch (cmd->common.opcode) {
 	case nvme_admin_set_features:
@@ -3350,9 +3356,11 @@ static ssize_t nvme_sysfs_reset(struct device *dev,
 	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
 	int ret;
 
-	ret = nvme_reset_ctrl_sync(ctrl);
-	if (ret < 0)
-		return ret;
+	if (test_bit(NVME_CTRL_STARTED_ONCE, &ctrl->flags)) {
+		ret = nvme_reset_ctrl_sync(ctrl);
+		if (ret < 0)
+			return ret;
+	}
 	return count;
 }
 static DEVICE_ATTR(reset_controller, S_IWUSR, NULL, nvme_sysfs_reset);
@@ -4994,16 +5002,18 @@ void nvme_start_ctrl(struct nvme_ctrl *ctrl)
 	 * that were missed. We identify persistent discovery controllers by
 	 * checking that they started once before, hence are reconnecting back.
 	 */
-	if (test_and_set_bit(NVME_CTRL_STARTED_ONCE, &ctrl->flags) &&
+	if (test_bit(NVME_CTRL_STARTED_ONCE, &ctrl->flags) &&
 	    nvme_discovery_ctrl(ctrl))
 		nvme_change_uevent(ctrl, "NVME_EVENT=rediscover");
 
 	if (ctrl->queue_count > 1) {
-		nvme_queue_scan(ctrl);
+		nvme_queue_scan_sync(ctrl);
 		nvme_unquiesce_io_queues(ctrl);
 		nvme_mpath_update(ctrl);
 	}
 
+	set_bit(NVME_CTRL_STARTED_ONCE, &ctrl->flags);
+
 	nvme_change_uevent(ctrl, "NVME_EVENT=connected");
 }
 EXPORT_SYMBOL_GPL(nvme_start_ctrl);
-- 
2.34.1


