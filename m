Return-Path: <SRS0=enG1=OI=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F681C433F5
	for <linux-nvme@archiver.kernel.org>; Sat, 18 Sep 2021 21:58:30 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F353860F6E
	for <linux-nvme@archiver.kernel.org>; Sat, 18 Sep 2021 21:58:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org F353860F6E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=67zffREdmDFZvWW1jHrM+Ao4f87+rTdZG/M/jZqyLxo=; b=FPp7uyfAmexH0E
	WocHf2vJlJ/tXAJMxRE8ORCLkyq8BFGRsTqq4DpkirKqcQj3VJJaSePB/LX3dRmc8WkzxStYJOxKB
	qcUAFYqeIGhN0wdLYvkE+DcRpLOdv5qAI+/C766fwcqR3rrvnTanjOb4RWiASM8eaGWXNol7nxn90
	tDY1TsCdZfvziwBuqwEO9X1I9TtEPr+tzanc/Oa9D8luaGZh5pL09sA1ksG1Hs0alNcU8ZcOgD7st
	XEdcIFR1jOZQcvdx1TSOgm4C8blYpTrdJcQ5PiDozxZu7g3AmJHjfeoeBiabYoJLByvFdN8bZzOUB
	9q0GmbSpRuQOaANYGxGw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mRiLX-00GPae-Vf; Sat, 18 Sep 2021 21:58:08 +0000
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mRiLU-00GPa8-FP
 for linux-nvme@lists.infradead.org; Sat, 18 Sep 2021 21:58:06 +0000
Received: by mail-wr1-x434.google.com with SMTP id u18so19601631wrg.5
 for <linux-nvme@lists.infradead.org>; Sat, 18 Sep 2021 14:58:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=Re6Y9uLz0ma5rhEfsZ/3FXdaCpq3shGQ7vCMU07wFLA=;
 b=qtoQ6HtC1C2R7LharIOO/VkjNQbd1Q2JC24Jd50hBkZSoQXoAEfGB+8/GDRvFnGzXo
 urQQw/y9011jlTDYJ6C0DfQuEakM53XvBgKRlYgVKyvwKHdvNsfVxjD4aK/VxJNMr4gq
 DBXnt9s3H1sG045AmRQMXHGi4eXH4fc+HZFBZWUKwAAvreMGREI/P8BOJmqeraNzS9xH
 kZKzIZBfKdjJafRyC+ODU94oWp/oSc3k5F8VfT43BNfi6ZX3G/O8u7mi0g4nuKDLa/c0
 7qwcP6aV27v4wcbTA8p8Dv4PjTEdgIG/x8epSZjIcfwRAdXPFDrZCHidW6U4yEttm8aa
 Olgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=Re6Y9uLz0ma5rhEfsZ/3FXdaCpq3shGQ7vCMU07wFLA=;
 b=rzJjPAqSxxVFEDXzFcmuaDv5tHjlNRiWLSYZsOao1g1RCnm1BjeDSo6Ft95GH6Qc68
 F2BMR1ktoPisoLlTr60UwKG03x4Csjgov3zKwwZt+bQXIVzbqXSx2iO687u94QcHKomX
 5yU1cbYOzdPi1vf7Hs3yNXL9nS9/FN7cTuW5UkeHSLowFl2kui0YpBGnRrmZ5gF6OGAm
 eNHdfPW/RdMQGTMtkE9Iz0sUBMX/9j/SI7baKcay5RzMlvLQSu8DjMoVQyS7RpPRveYw
 RQqXYDg5kD46cZfy0ufD92Uydb98tTrjGxOKRBxcdF/fgTDUT/eH9/379ztfRwAkvk4J
 ctMw==
X-Gm-Message-State: AOAM532pMizIbch6WcP1ydYnCVEBKYaItWn5DtJ7zYyM5RaAEs30gIhf
 kt0w5GmwSNcsMuvkq9NCuPqYkg9g2mIfqA==
X-Google-Smtp-Source: ABdhPJwsgvOZD9Pb3Xl7WXffuRNtqwRp86WAk3CIIDsGn5P2JfrDGIRJ/V6HkqZkmDfyIXIDnt5HSw==
X-Received: by 2002:a05:6000:c3:: with SMTP id
 q3mr19591088wrx.361.1632002281797; 
 Sat, 18 Sep 2021 14:58:01 -0700 (PDT)
Received: from anton-latitude..lbits (c-76-23-2-87.hsd1.ut.comcast.net.
 [76.23.2.87])
 by smtp.googlemail.com with ESMTPSA id o2sm12004006wrh.13.2021.09.18.14.57.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 18 Sep 2021 14:58:01 -0700 (PDT)
From: Anton Eidelman <anton.eidelman@gmail.com>
X-Google-Original-From: Anton Eidelman <anton@lightbitslabs.com>
To: linux-nvme@lists.infradead.org, hch@lst.de, kbusch@kernel.org,
 sagi@grimberg.me, axboe@fb.com
Cc: Anton Eidelman <anton@lightbitslabs.com>
Subject: [PATCH] nvme/mpath: fix hang when disk goes live over reconnect
Date: Sat, 18 Sep 2021 15:57:29 -0600
Message-Id: <20210918215729.388968-1-anton@lightbitslabs.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210918_145804_580208_38648548 
X-CRM114-Status: GOOD (  17.95  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

nvme_mpath_init_identify() invoked from nvme_init_identify()
fetches a fresh ANA log from the ctrl.
This is essential to have an up to date path states
for both existing namespaces and for those scan_work
may discover once the ctrl is up.

This happens in the following cases:
1) A new ctrl is being connected.
2) An existing ctrl is successfully reconnected.
3) An existing ctrl is being reset.

While in (1) ctrl->namespaces is empty, (2 & 3) may have namespaces,
and nvme_read_ana_log() may call nvme_update_ns_ana_state().

This result in a hang when the ANA state of an existing namespace
changes and makes the disk live: nvme_mpath_set_live() issues
IO to the namespace through the ctrl, which does NOT have IO queues yet.
See sample hang below.

Solution:
- move nvme_read_ana_log() call from nvme_mpath_init_identify()
into a separate function, nvme_mpath_update().
- call this function in nvme_start_ctrl() - here the ctrl is ready.

Downside: in case nvme_read_ana_log() fails, we do not find this out
  in nvme_mpath_init_identify().

Alernative solution:
  nvme_get_log() in nvme_mpath_init_identify(), but don't parse.
  Then nvme_start_ctrl() can just queue_work(nvme_wq, &ctrl->ana_work),
  along with scan_work.
  The ctrl->ana_log_buf contents is valid for scan_work,
  and ana_work will re-fetch and parse it.
  Downside: fetching an ANA log from the ctrl twice.

Sample failure:
    nvme nvme0: starting error recovery
    nvme nvme0: Reconnecting in 10 seconds...
    block nvme0n6: no usable path - requeuing I/O
    INFO: task kworker/u8:3:312 blocked for more than 122 seconds.
          Tainted: G            E     5.14.5-1.el7.elrepo.x86_64 #1
    Workqueue: nvme-wq nvme_tcp_reconnect_ctrl_work [nvme_tcp]
    Call Trace:
     __schedule+0x2a2/0x7e0
     schedule+0x4e/0xb0
     io_schedule+0x16/0x40
     wait_on_page_bit_common+0x15c/0x3e0
     do_read_cache_page+0x1e0/0x410
     read_cache_page+0x12/0x20
     read_part_sector+0x46/0x100
     read_lba+0x121/0x240
     efi_partition+0x1d2/0x6a0
     bdev_disk_changed.part.0+0x1df/0x430
     bdev_disk_changed+0x18/0x20
     blkdev_get_whole+0x77/0xe0
     blkdev_get_by_dev+0xd2/0x3a0
     __device_add_disk+0x1ed/0x310
     device_add_disk+0x13/0x20
     nvme_mpath_set_live+0x138/0x1b0 [nvme_core]
     nvme_update_ns_ana_state+0x2b/0x30 [nvme_core]
     nvme_update_ana_state+0xca/0xe0 [nvme_core]
     nvme_parse_ana_log+0xac/0x170 [nvme_core]
     nvme_read_ana_log+0x7d/0xe0 [nvme_core]
     nvme_mpath_init_identify+0x105/0x150 [nvme_core]
     nvme_init_identify+0x2df/0x4d0 [nvme_core]
     nvme_init_ctrl_finish+0x8d/0x3b0 [nvme_core]
     nvme_tcp_setup_ctrl+0x337/0x390 [nvme_tcp]
     nvme_tcp_reconnect_ctrl_work+0x24/0x40 [nvme_tcp]
     process_one_work+0x1bd/0x360
     worker_thread+0x50/0x3d0

Signed-off-by: Anton Eidelman <anton@lightbitslabs.com>
---
 drivers/nvme/host/core.c      | 1 +
 drivers/nvme/host/multipath.c | 9 ++++++---
 drivers/nvme/host/nvme.h      | 4 ++++
 3 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 97f8211cf92c..884ca1f6f80b 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -4325,6 +4325,7 @@ void nvme_start_ctrl(struct nvme_ctrl *ctrl)
 	nvme_enable_aen(ctrl);
 
 	if (ctrl->queue_count > 1) {
+		nvme_mpath_update(ctrl);
 		nvme_queue_scan(ctrl);
 		nvme_start_queues(ctrl);
 	}
diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index e8ccdd398f78..8bd133f66636 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -850,9 +850,7 @@ int nvme_mpath_init_identify(struct nvme_ctrl *ctrl, struct nvme_id_ctrl *id)
 			return -ENOMEM;
 	}
 	ctrl->ana_log_size = ana_log_size;
-	error = nvme_read_ana_log(ctrl);
-	if (error)
-		goto out_uninit;
+
 	return 0;
 
 out_uninit:
@@ -860,6 +858,11 @@ int nvme_mpath_init_identify(struct nvme_ctrl *ctrl, struct nvme_id_ctrl *id)
 	return error;
 }
 
+void nvme_mpath_update(struct nvme_ctrl *ctrl)
+{
+	nvme_read_ana_log(ctrl);
+}
+
 void nvme_mpath_uninit(struct nvme_ctrl *ctrl)
 {
 	kfree(ctrl->ana_log_buf);
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 9871c0c9374c..1560ea7adc6b 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -746,6 +746,7 @@ void nvme_mpath_add_disk(struct nvme_ns *ns, struct nvme_id_ns *id);
 void nvme_mpath_remove_disk(struct nvme_ns_head *head);
 int nvme_mpath_init_identify(struct nvme_ctrl *ctrl, struct nvme_id_ctrl *id);
 void nvme_mpath_init_ctrl(struct nvme_ctrl *ctrl);
+void nvme_mpath_update(struct nvme_ctrl *ctrl);
 void nvme_mpath_uninit(struct nvme_ctrl *ctrl);
 void nvme_mpath_stop(struct nvme_ctrl *ctrl);
 bool nvme_mpath_clear_current_path(struct nvme_ns *ns);
@@ -820,6 +821,9 @@ static inline int nvme_mpath_init_identify(struct nvme_ctrl *ctrl,
 "Please enable CONFIG_NVME_MULTIPATH for full support of multi-port devices.\n");
 	return 0;
 }
+static void nvme_mpath_update(struct nvme_ctrl *ctrl)
+{
+}
 static inline void nvme_mpath_uninit(struct nvme_ctrl *ctrl)
 {
 }
-- 
2.25.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
