Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43839EF48C4
	for <linux-nvme@archiver.kernel.org>; Sat, 14 Feb 2026 04:28:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=aUvJMxt7knmUTeOZs2dmIkt23G0xfZRWuCisOpX3yO8=; b=FfFI5dSIHUwXiAWQaCakL8lmx4
	l3P5GDyHLsyrEVML6kK7wBOsop8Ss5BAQZ4BLFbYvn9optwzeUS8JDbwlVZ6Z2I+B+J137eTjwHJz
	f5jcnGjfVkW0ISTte4qT/NXp1KSnEyh35HAKC0ZVR7wln6Y+HlbZ/pX7MydgWyLjWV+88vZn260Oj
	U3LW1v9f5kuyG8pLFfpvqFOmlMz3DYkDMtofCtu+7pdkt8jcWk9LldsLYlWXdqmuR/0ynWcEid7G6
	iYx+6Pdd8L2beYrpb0rastj30svqLDhV9qPEuvPB7kdQ7hxb7FcKfkMMqr9FQgFDhICAu/JJT9QEm
	tKAIsYLw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vr7Gf-00000004F0M-1n84;
	Sat, 14 Feb 2026 04:28:29 +0000
Received: from mail-dl1-x1235.google.com ([2607:f8b0:4864:20::1235])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vr7Gc-00000004Ewb-1p3k
	for linux-nvme@lists.infradead.org;
	Sat, 14 Feb 2026 04:28:27 +0000
Received: by mail-dl1-x1235.google.com with SMTP id a92af1059eb24-124afd03fd1so2559663c88.0
        for <linux-nvme@lists.infradead.org>; Fri, 13 Feb 2026 20:28:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1771043305; x=1771648105; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aUvJMxt7knmUTeOZs2dmIkt23G0xfZRWuCisOpX3yO8=;
        b=TXN2yOCX4QA4G5NWf4fB5uCSruKAWYgtX4VSBLE0WhJ6XPkgp6HHlw5Jx3pJ5Z0Lgt
         GukWaaGWGJ0RWtqp9zIyLHs42Bpax341uIA6R8vRmtWJ592YJXMUFs2kb3Le5ZWC2LP3
         6HuoJA3C5C+1wrFB2fP+x8oR+oTxTA2Rk0wjlLFnKPLcj04vNhwtYtK6t6q60i3nrNrb
         Y62DMCBEjoYHFhp7/fa+DhVnZBVaFQIgAZaZLDWB16P17E+yQv1w1c7SeIwQXpiml896
         TQN/xHNtRz6AiMCbz91nJ5HjqvargPNBK9s9XHVQMbMn12RxifkKOEu9PIfxYXwuYfcZ
         96Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771043305; x=1771648105;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=aUvJMxt7knmUTeOZs2dmIkt23G0xfZRWuCisOpX3yO8=;
        b=KsWLdkiuwZYRntrBBw+OyBo8K4VP19Cxyqx5Zal86v6Ut9AOxfpKH0W5OsqfZjmSbE
         sEFNKRdsHaM4LHGT/l4c00DzNGitGJRhS1LwY22IEtYA0xfBLHQIQ3V3+1ZvKkeahPUC
         u3Zb42UeNJDuy6rK9rNmzYu2+ya/3rf+HDuaqcqQzNX4RshZhSLB31N8NYZYH5l9sPIE
         0uvG01PYSMJcWqOBcbqHQbQgMaA9kLn5MgfRnCa/WdI3qGPoJMfnm+Nou/wlwGSLhq4Y
         UACzI2Wsux2VSI5n083KGHQg6hGKkJn9PHjbbILohFD9f+KhSiGwldwCsUZd/fcFMIZb
         aUng==
X-Forwarded-Encrypted: i=1; AJvYcCU/D4W3s296it1CDS6tCFHyy6G/hyZzpmeF21JKmjV0MD35s5BxNOXDDNrpoFVENaztzaQxLKPpcjhA@lists.infradead.org
X-Gm-Message-State: AOJu0YyUqdBl7ZdwOHHI2ApXKfky2fbk2IMtxtTf3o/O+W6B3H4NVRgP
	CljtcPVCfVOssT6fsHrs4ub2Ve1j6HsUZT1IV4ossQnCClw6RqOMXr+RDNWAjoRsj/c=
X-Gm-Gg: AZuq6aJtfbW4pBekE6qUnBZwL/0RrMbn0Ei56Y5XY8kL8ZkpL4J9wMgbTQYnqRn+eUp
	l1xt5bqMNt6IupIwj6tLrURh+ly9gdrnw8iXXZKuBnhp5wih/23cZWs+Lvbfjb0JR4H+kHLbg5e
	u1ehD5hiZ07gnCXTzSXo/p8yQ0BV1oGP3TXD5VQxw/JUGc2M+0/9dHe36730PnAjwLAPYlDb8Uh
	Ub8P1Gh3aOcKJwc4tdRjSONbJ45Noxc1DXaV9wXsZGTXsjjh4vU2zyjfj7wX2GYnZlhW2i9rF14
	MGhE62B7ybH6EKf95ajwp4FBVkriE6Lwq9GG0YpzRfs31c782Awl80M/oKUim4hOtz7gyYPxB92
	a3rI+90R67QEDv2OYEhJbWsuSh5nYro4eItfVQ9bPYISBeFhBEC59Kl4tfcj9vEcJATGuSkutPH
	e1tXdptYyZFteiCAVg3wg9Yj9lihJkFOh8c2sG8ul2eUOlVg==
X-Received: by 2002:a05:7022:6897:b0:123:35a4:e8be with SMTP id a92af1059eb24-12741b6dae9mr681320c88.13.1771043305340;
        Fri, 13 Feb 2026 20:28:25 -0800 (PST)
Received: from apollo.purestorage.com ([208.88.152.253])
        by smtp.googlemail.com with ESMTPSA id a92af1059eb24-12742cbc900sm1021042c88.14.2026.02.13.20.28.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Feb 2026 20:28:25 -0800 (PST)
From: Mohamed Khalfella <mkhalfella@purestorage.com>
To: Justin Tee <justin.tee@broadcom.com>,
	Naresh Gottumukkala <nareshgottumukkala83@gmail.com>,
	Paul Ely <paul.ely@broadcom.com>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>,
	Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	James Smart <jsmart833426@gmail.com>,
	Hannes Reinecke <hare@suse.de>
Cc: Aaron Dailey <adailey@purestorage.com>,
	Randy Jennings <randyj@purestorage.com>,
	Dhaval Giani <dgiani@purestorage.com>,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Mohamed Khalfella <mkhalfella@purestorage.com>
Subject: [PATCH v3 05/21] nvmet: Send an AEN on CCR completion
Date: Fri, 13 Feb 2026 20:25:06 -0800
Message-ID: <20260214042753.4073668-6-mkhalfella@purestorage.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260214042753.4073668-1-mkhalfella@purestorage.com>
References: <20260214042753.4073668-1-mkhalfella@purestorage.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260213_202826_474744_F5C79E67 
X-CRM114-Status: GOOD (  14.40  )
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

Send an AEN to initiator when impacted controller exists. The
notification points to CCR log page that initiator can read to check
which CCR operation completed.

Signed-off-by: Mohamed Khalfella <mkhalfella@purestorage.com>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/target/core.c  | 25 ++++++++++++++++++++++---
 drivers/nvme/target/nvmet.h |  3 ++-
 include/linux/nvme.h        |  3 +++
 3 files changed, 27 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index 38f71e1a1b8e..a9f8a2242703 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -203,7 +203,7 @@ static void nvmet_async_event_work(struct work_struct *work)
 	nvmet_async_events_process(ctrl);
 }
 
-void nvmet_add_async_event(struct nvmet_ctrl *ctrl, u8 event_type,
+static void nvmet_add_async_event_locked(struct nvmet_ctrl *ctrl, u8 event_type,
 		u8 event_info, u8 log_page)
 {
 	struct nvmet_async_event *aen;
@@ -216,13 +216,19 @@ void nvmet_add_async_event(struct nvmet_ctrl *ctrl, u8 event_type,
 	aen->event_info = event_info;
 	aen->log_page = log_page;
 
-	mutex_lock(&ctrl->lock);
 	list_add_tail(&aen->entry, &ctrl->async_events);
-	mutex_unlock(&ctrl->lock);
 
 	queue_work(nvmet_wq, &ctrl->async_event_work);
 }
 
+void nvmet_add_async_event(struct nvmet_ctrl *ctrl, u8 event_type,
+		u8 event_info, u8 log_page)
+{
+	mutex_lock(&ctrl->lock);
+	nvmet_add_async_event_locked(ctrl, event_type, event_info, log_page);
+	mutex_unlock(&ctrl->lock);
+}
+
 static void nvmet_add_to_changed_ns_log(struct nvmet_ctrl *ctrl, __le32 nsid)
 {
 	u32 i;
@@ -1785,6 +1791,18 @@ struct nvmet_ctrl *nvmet_alloc_ctrl(struct nvmet_alloc_ctrl_args *args)
 }
 EXPORT_SYMBOL_GPL(nvmet_alloc_ctrl);
 
+static void nvmet_ctrl_notify_ccr(struct nvmet_ctrl *ctrl)
+{
+	lockdep_assert_held(&ctrl->lock);
+
+	if (nvmet_aen_bit_disabled(ctrl, NVME_AEN_BIT_CCR_COMPLETE))
+		return;
+
+	nvmet_add_async_event_locked(ctrl, NVME_AER_NOTICE,
+				     NVME_AER_NOTICE_CCR_COMPLETED,
+				     NVME_LOG_CCR);
+}
+
 static void nvmet_ctrl_complete_pending_ccr(struct nvmet_ctrl *ctrl)
 {
 	struct nvmet_subsys *subsys = ctrl->subsys;
@@ -1808,6 +1826,7 @@ static void nvmet_ctrl_complete_pending_ccr(struct nvmet_ctrl *ctrl)
 		list_for_each_entry(ccr, &sctrl->ccr_list, entry) {
 			if (ccr->ctrl == ctrl) {
 				ccr->ctrl = NULL;
+				nvmet_ctrl_notify_ccr(sctrl);
 				break;
 			}
 		}
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index b06d905c08c8..0ed41a3d0562 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -44,7 +44,8 @@
  * Supported optional AENs:
  */
 #define NVMET_AEN_CFG_OPTIONAL \
-	(NVME_AEN_CFG_NS_ATTR | NVME_AEN_CFG_ANA_CHANGE)
+	(NVME_AEN_CFG_NS_ATTR | NVME_AEN_CFG_ANA_CHANGE | \
+	 NVME_AEN_CFG_CCR_COMPLETE)
 #define NVMET_DISC_AEN_CFG_OPTIONAL \
 	(NVME_AEN_CFG_DISC_CHANGE)
 
diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index 9b6d93270c59..fc33ae48d149 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -860,12 +860,14 @@ enum {
 	NVME_AER_NOTICE_FW_ACT_STARTING = 0x01,
 	NVME_AER_NOTICE_ANA		= 0x03,
 	NVME_AER_NOTICE_DISC_CHANGED	= 0xf0,
+	NVME_AER_NOTICE_CCR_COMPLETED	= 0xf4,
 };
 
 enum {
 	NVME_AEN_BIT_NS_ATTR		= 8,
 	NVME_AEN_BIT_FW_ACT		= 9,
 	NVME_AEN_BIT_ANA_CHANGE		= 11,
+	NVME_AEN_BIT_CCR_COMPLETE	= 20,
 	NVME_AEN_BIT_DISC_CHANGE	= 31,
 };
 
@@ -873,6 +875,7 @@ enum {
 	NVME_AEN_CFG_NS_ATTR		= 1 << NVME_AEN_BIT_NS_ATTR,
 	NVME_AEN_CFG_FW_ACT		= 1 << NVME_AEN_BIT_FW_ACT,
 	NVME_AEN_CFG_ANA_CHANGE		= 1 << NVME_AEN_BIT_ANA_CHANGE,
+	NVME_AEN_CFG_CCR_COMPLETE	= 1 << NVME_AEN_BIT_CCR_COMPLETE,
 	NVME_AEN_CFG_DISC_CHANGE	= 1 << NVME_AEN_BIT_DISC_CHANGE,
 };
 
-- 
2.52.0


