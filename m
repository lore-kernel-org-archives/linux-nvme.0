Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 560B3C36002
	for <linux-nvme@archiver.kernel.org>; Mon, 24 Mar 2025 17:49:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Yz2osXWrElalCzIio0fRrS4N7V336cnORYficYcWn18=; b=lLBKJVYm0DiMMOSc2X1zaZb+xU
	tNRYm4DTZiqC6spISPS3ke6e4h/22mT5ia9I2Biw18wcqfr/DYIS7L8UpRspvSdAKhgsL+0+WPOlJ
	zqvYyOJ3Q/j6PbcrMwdONnZ67BEIEIexBnRXt11U0ClMfRYPw4ETU6gYRXW6HXdPWNcu86EvR043K
	WWsRlAlLUniXQX/Tq98I5YCOjh+bnV14pLfo2X3AK9oWfF8Jtyxu6jHIc7w0Bb37v3DxiAiJZNWyx
	vIHVwsFyndCasXHCS0d2Zx7RiTKz1JJh5hcUE50Ztw+8oTFeFkb9PowzflyNxDuo01xPaKyCcy86z
	gZCYkChQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1twlvj-00000003rPA-2NaG;
	Mon, 24 Mar 2025 17:49:43 +0000
Received: from mail-pj1-x1029.google.com ([2607:f8b0:4864:20::1029])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1twlvh-00000003rLj-1gq4
	for linux-nvme@lists.infradead.org;
	Mon, 24 Mar 2025 17:49:42 +0000
Received: by mail-pj1-x1029.google.com with SMTP id 98e67ed59e1d1-2ff6e91cff5so8088691a91.2
        for <linux-nvme@lists.infradead.org>; Mon, 24 Mar 2025 10:49:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1742838580; x=1743443380; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yz2osXWrElalCzIio0fRrS4N7V336cnORYficYcWn18=;
        b=eHtUsfquvI4L5qHgj8jQAavfZd/WrRcRD/+Lv2Dxs1aC/AmN6nc883i+GyddeJ1n/H
         EcTQCrb2w5KE8FBHfZTo/TMY5C2c34aZ8+9h/vrRZGrNeHElz0oE0lHwOfJJQ/LbxkE5
         B6/Ci2sCM2ux37Q9ZcYJBlqnnSiKbVu7IHI9g4Fg6HrCuXz21+QqyLG4wD9yzl84543D
         Zjv/uTmUeb3BsnU3e5NF2x9e4n1WialbWn2rD+c/dIy5UbvJIf6dqn2sEeKUdsEHb11y
         vKg7ZvH4yMrItmXgyevmKXiCMa0tXeN4r0AfXP9foKzGj8T5D8mjIn1tQeKQe37OAvJc
         2PDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742838580; x=1743443380;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Yz2osXWrElalCzIio0fRrS4N7V336cnORYficYcWn18=;
        b=HskIHR5NC0jZdg3B6rM0DUNZm5Uv8oWIAbqWXD7YV5MoWHX7MC7KFE1sJZzjMRy+C6
         ySYt3hyKGhCGOanMElfUnPXZf0rvyoDdyZQXpzZWeoX0Q0FVnnY7tB1v7QEktgiOLlxy
         l4KLt57hyTzvQboWHS2BY3EKcFJYY3iUh0eje+Lix1AA+3gr4hBkA6nwMdHQJd4cKNfi
         napQG0PIEafTYkVYN7cYEJvtWfyCo7St2y9qQepT5USM4bPmf7h5nJrNTWTjMqnlTKB5
         1PUdrfHzS/Hn4HGx0zGvN8noA+U2odnKM4R/WaT1LxqgpGryFilhGBW+kn0ZOkNdKRmP
         6sHQ==
X-Forwarded-Encrypted: i=1; AJvYcCXFyz/RJIx7Zn3KYWerX22G1SpOpdcqQvO4unfdu2syL+4Xpq52AapkD/ntUPimqCHuQnj5Pqddunga@lists.infradead.org
X-Gm-Message-State: AOJu0YzHY81EpeVRDB/4gFeICfDrqlWKy35SZCLueRnbkYr7nePCtnCq
	BYJ9nhovILQS3YYoBX2PVI7IzU7bLfiRM++voTaygZFY1CwF2lIurclw2dL5WqM=
X-Gm-Gg: ASbGncsezvAhS5YxoAfVFYn6FqEFmC3to/yNDM5Kgddq1KZqGc2K1y3QvrhWMaoQwJr
	ErDmCBppsURBAigVPl13IW5DaSHVZwJfAO0Cnrhe+NanUaKZB733ZiYjYEjez0/1SXdjIRNJP2v
	0GkoqaaPwtRaPQubMNkLHsmUbSp0hIvrMhcDVb0+GjlX1zCJ647rjqW8c7ZZdvblzVgQZ44En42
	/nM2cFG5B/v5Snidz8AyOCJPp9U2do0oaH3fe3vpMCTLN9/NpQyJFGf2YadvSU2UBs+iJs+GOSh
	V7mSaWprqyGoqWKkFImv1r0j2rOdT4PDgXWk5s0cJv2M4GS4sLVA+WRcmak8yQ==
X-Google-Smtp-Source: AGHT+IEvbZLBkadN8enrTpfI1MaG14FFBTGvRXIEJ2kVCjGfPPoMyljKBkm92M3bmOxmimTtPebNvA==
X-Received: by 2002:a17:90b:2647:b0:2ee:d7d3:3019 with SMTP id 98e67ed59e1d1-3030fe95343mr26865713a91.12.1742838580250;
        Mon, 24 Mar 2025 10:49:40 -0700 (PDT)
Received: from localhost.localdomain ([2601:640:8900:32c0::e120])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-301bf576c7dsm12505821a91.3.2025.03.24.10.49.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Mar 2025 10:49:39 -0700 (PDT)
From: Mohamed Khalfella <mkhalfella@purestorage.com>
To: Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>
Cc: Hannes Reinecke <hare@suse.de>,
	Daniel Wagner <wagi@kernel.org>,
	John Meneghini <jmeneghi@redhat.com>,
	randyj@purestorage.com,
	adailey@purestorage.com,
	jrani@purestorage.com,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	mkhalfella@purestorage.com
Subject: [RFC PATCH v1 6/7] nvme-core: Add support for holding inflight requests
Date: Mon, 24 Mar 2025 10:48:59 -0700
Message-ID: <20250324174909.3919131-7-mkhalfella@purestorage.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250324174909.3919131-1-mkhalfella@purestorage.com>
References: <20250324174909.3919131-1-mkhalfella@purestorage.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250324_104941_450482_6C1B4C15 
X-CRM114-Status: GOOD (  15.91  )
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

TP4129 requires nvme controller to hold inflight requests in case of
connection loss for a certain duration of time until it is safe for
these requests to be retried. In case there are inflight requests
held_req_work is scheduled with the appropriate delay to cancel the
requests. Add the necessary logic to nvme-core so that all fabric
transports can use it.

Signed-off-by: Mohamed Khalfella <mkhalfella@purestorage.com>
---
 drivers/nvme/host/core.c | 61 ++++++++++++++++++++++++++++++++++++++++
 drivers/nvme/host/nvme.h |  4 +++
 2 files changed, 65 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index f4b3c6a42e90..4170785ecf21 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -551,6 +551,65 @@ void nvme_cancel_admin_tagset(struct nvme_ctrl *ctrl)
 }
 EXPORT_SYMBOL_GPL(nvme_cancel_admin_tagset);
 
+static void nvme_held_req_work(struct work_struct *work)
+{
+	struct nvme_ctrl *ctrl = container_of(to_delayed_work(work),
+			struct nvme_ctrl, held_req_work);
+	dev_info(ctrl->device, "releasing inflight requests\n");
+	nvme_cancel_tagset(ctrl);
+	nvme_cancel_admin_tagset(ctrl);
+	complete(&ctrl->held_req_completion);
+}
+
+static bool nvme_check_inflight_request(struct request *req, void *data)
+{
+	bool *inflight_reqs = data;
+
+	if (blk_mq_rq_state(req) == MQ_RQ_IN_FLIGHT) {
+		*inflight_reqs = true;
+		return false;
+	}
+	return true;
+}
+
+bool nvme_queue_held_requests_work(struct nvme_ctrl *ctrl)
+{
+	unsigned long timeout = nvmef_req_hold_timeout_ms(ctrl);
+	bool inflight_reqs = false;
+
+	if (ctrl->queue_count > 1 && ctrl->tagset)
+		blk_mq_tagset_busy_iter(ctrl->tagset,
+			nvme_check_inflight_request, &inflight_reqs);
+	if (inflight_reqs)
+		goto schedule_work;
+
+	if (ctrl->admin_tagset)
+		blk_mq_tagset_busy_iter(ctrl->admin_tagset,
+					nvme_check_inflight_request, &inflight_reqs);
+	if (!inflight_reqs)
+		return false;
+
+schedule_work:
+	dev_info(ctrl->device, "holding inflight requests for %lums\n", timeout);
+	reinit_completion(&ctrl->held_req_completion);
+	schedule_delayed_work(&ctrl->held_req_work, msecs_to_jiffies(timeout));
+	return true;
+}
+EXPORT_SYMBOL_GPL(nvme_queue_held_requests_work);
+
+void nvme_wait_for_held_requests(struct nvme_ctrl *ctrl)
+{
+	/*
+	 * Inflight requests can be held for a duration of time that is longer
+	 * than hung_task timeout. Avoid hitting hung_task timeout while waiting
+	 * for held requests to be completed.
+	 */
+	while (!wait_for_completion_timeout(&ctrl->held_req_completion,
+					    secs_to_jiffies(1)))
+		;
+}
+EXPORT_SYMBOL_GPL(nvme_wait_for_held_requests);
+
 bool nvme_change_ctrl_state(struct nvme_ctrl *ctrl,
 		enum nvme_ctrl_state new_state)
 {
@@ -4846,6 +4905,8 @@ int nvme_init_ctrl(struct nvme_ctrl *ctrl, struct device *dev,
 
 	INIT_DELAYED_WORK(&ctrl->ka_work, nvme_keep_alive_work);
 	INIT_DELAYED_WORK(&ctrl->failfast_work, nvme_failfast_work);
+	INIT_DELAYED_WORK(&ctrl->held_req_work, nvme_held_req_work);
+	init_completion(&ctrl->held_req_completion);
 	memset(&ctrl->ka_cmd, 0, sizeof(ctrl->ka_cmd));
 	ctrl->ka_cmd.common.opcode = nvme_admin_keep_alive;
 	ctrl->ka_last_check_time = jiffies;
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 7563332b5b7b..ed8729f93ace 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -356,6 +356,8 @@ struct nvme_ctrl {
 	struct work_struct async_event_work;
 	struct delayed_work ka_work;
 	struct delayed_work failfast_work;
+	struct delayed_work held_req_work;
+	struct completion held_req_completion;
 	struct nvme_command ka_cmd;
 	unsigned long ka_last_check_time;
 	struct work_struct fw_act_work;
@@ -793,6 +795,8 @@ blk_status_t nvme_host_path_error(struct request *req);
 bool nvme_cancel_request(struct request *req, void *data);
 void nvme_cancel_tagset(struct nvme_ctrl *ctrl);
 void nvme_cancel_admin_tagset(struct nvme_ctrl *ctrl);
+bool nvme_queue_held_requests_work(struct nvme_ctrl *ctrl);
+void nvme_wait_for_held_requests(struct nvme_ctrl *ctrl);
 bool nvme_change_ctrl_state(struct nvme_ctrl *ctrl,
 		enum nvme_ctrl_state new_state);
 int nvme_disable_ctrl(struct nvme_ctrl *ctrl, bool shutdown);
-- 
2.48.1


