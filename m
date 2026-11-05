Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C50D606A339
	for <linux-nvme@archiver.kernel.org>; Thu,  5 Nov 2026 17:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=DIziQsM5
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Subject:Cc:To:
	From:Mime-Version:Date:References:In-Reply-To:Message-ID:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=Y3NyyVjQB+A++lsAg4cv+f/TphKmY+7HKHATxrw4K5w=; b=DIziQsM5GGBi9YpHq+BYVaL/Wp
	goXR3ror26RL9Uodp+pWfZxG27AiWdxQ3b2k0oi0YYtKbSvRZ7g8jhZw3MdIIZzF1t/fxHG7fkPee
	bgl7lDMTQRsw8o5fphkUPYls1t7rSInXLfyKeNTvrueE6isvF8sc9+4H0BwEIJUzJgOLO2In6P8XP
	WKtv3FXBSXqaHNkNti90xbRQCQ2ERWcRB+KlAbEZ7OXRryCElZFUGIVn+NSmYazC0z35KVS+BAtCs
	xInpbMr8tLd+ZPi6yCul+XMN7Rp4Ci2kU7TvMmvTJrcJVR0hfTeFFt8b2rDNivZPO9Qc3GDAxLyRr
	ZkBJuYnQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xP0xT-00000009mch-26zb;
	Thu, 05 Nov 2026 17:09:03 +0000
Received: from mxhk.zte.com.cn ([160.30.148.35])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOxym-00000009CT4-0M9n
	for linux-nvme@lists.infradead.org;
	Thu, 05 Nov 2026 13:58:13 +0000
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4jL3mf2cjSz8Xrr9;
	Thu, 05 Nov 2026 21:58:10 +0800 (CST)
Received: from xaxapp04.zte.com.cn ([10.99.98.157])
	by mse-fl2.zte.com.cn with SMTP id 6A5Dvwkk060232;
	Thu, 5 Nov 2026 21:57:58 +0800 (+08)
	(envelope-from shao.mingyin@zte.com.cn)
Received: from mapi (xaxapp05[null])
	by mapi (Zmail) with MAPI id mid32;
	Thu, 5 Nov 2026 21:57:59 +0800 (CST)
X-Zmail-TransId: 2afc6aec8b67eb2-cf609
X-Mailer: Zmail v1.0
Message-ID: <20261105215759419k4-bV6cgNlque5OLcc4E9@zte.com.cn>
In-Reply-To: <20261105215753914RuQA4AVkFtXzpBkieEscY@zte.com.cn>
References: 20261105215753914RuQA4AVkFtXzpBkieEscY@zte.com.cn
Date: Thu, 5 Nov 2026 21:57:59 +0800 (CST)
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
From: <shao.mingyin@zte.com.cn>
To: <kbusch@kernel.org>, <axboe@kernel.dk>, <hch@lst.de>, <sagi@grimberg.me>,
        <linux-nvme@lists.infradead.org>
Cc: <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
Subject: =?UTF-8?B?W1BBVENIIDEvMl0gbnZtZXQ6IHplcm8gb3V0IHVudXNlZCBkYXRhIG9mIGZpeGVkLXNpemUgbG9nIHBhZ2Vz?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL: mse-fl2.zte.com.cn 6A5Dvwkk060232
X-TLS: YES
X-ENVELOPE-SENDER: shao.mingyin@zte.com.cn
X-SOURCE-IP: 10.5.228.133 unknown Thu, 05 Nov 2026 21:58:10 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6AEC8B72.000/4jL3mf2cjSz8Xrr9
X-Bad-Reply: References and In-Reply-To but no 'Re:' in Subject.
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261105_055812_471855_9EFEA7A4 
X-CRM114-Status: GOOD (  22.76  )
X-Spam-Score: -1.9 (-)
X-Mailman-Approved-At: Thu, 05 Nov 2026 09:06:26 -0800
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
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Shao Mingyin <shao.mingyin@zte.com.cn>

Several Get Log Page handlers copy a fixed-size structure to the host
buffer and return success, without initializing the rest of the buffer
the host asked for.  The requested data length (NUMD) is supplied by the
host, so it can be larger than the structure being returned.

The transports allocate those buffers with sgl_alloc() or kmalloc(),
none of them with __GFP_ZERO, and on success they send the whole
transfer length back to the host.  A host requesting more than the size
of the log page therefore receives stale kernel memory from the target.
This is the same class of bug as the one fixed for Zone Management
Receive in commit 31b8a6af19b7 ("nvmet: zns: don't leak stale memory in
zone management receive").

Zero the unused tail after filling the Supported Log Pages, Commands
Supported and Effects, Supported Features, Endurance Group, Reservation
and Rotational Media Information log pages.

The Rotational Media Information log used to reject a host buffer that
was larger than the fixed structure.  Accept that and zero the tail
instead, like the other handlers.

The Error log page needs more than a zeroed tail.  Clamp the ring walk
to the requested length, zero the remaining bytes, and propagate
nvmet_copy_to_sgl() failures instead of completing with success.  The
ring is walked backwards from the slot of the last error because the
NVMe base specification requires the most recent error to be the first
log entry.

The Reservation log tail is zeroed after the log_mgr lock is dropped:
the host controls the length, so the buffer can be large.

Fixes: 11ad507784ed ("nvmet: add error log page cmd handler")
Fixes: 83acb24e6de7 ("nvmet: implement supported log pages")
Fixes: 0866bf0c3778 ("nvmet: add commands supported and effects log page")
Fixes: e973c91727d4 ("nvmet: implement supported features log")
Fixes: 266b652c65b4 ("nvmet: implement endurance groups")
Fixes: 5fd075cdaf36 ("nvmet: implement rotational media information log")
Fixes: 5a47c2080a73 ("nvmet: support reservation feature")
Cc: stable@vger.kernel.org
Signed-off-by: Shao Mingyin <shao.mingyin@zte.com.cn>

---
Tested on 7.3.0-next-20261030 (QEMU/TCG guest) with an nvmet-tcp target
and a file-backed namespace; the target's data pages are primed with
0xaa by a preceding 1 MiB write.

A Get Log Page for Supported Log Pages with a 4096-byte transfer
(NUMD 1023) asks for four times sizeof(struct nvme_supported_log), so
bytes 1024..4095 are never written by the handler:

  unpatched                            patched
  tail[1024..4095] = 0xaa (10/10)      tail zeroed (0/10)

The Rotational Media Information and Reservation log changes, and the
error log ring clamp, are not runtime-tested: the test guest has no
rotational namespace, no persistent-reservation setup, and no injected
command error.
---
 drivers/nvme/target/admin-cmd.c | 53 +++++++++++++++++++++++++++++----
 drivers/nvme/target/pr.c        |  7 +++++
 2 files changed, 54 insertions(+), 6 deletions(-)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index 26028be8fe4d..434fa543019a 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -176,16 +176,29 @@ static void nvmet_execute_get_log_page_error(struct nvmet_req *req)
 {
 	struct nvmet_ctrl *ctrl = req->sq->ctrl;
 	unsigned long flags;
-	off_t offset = 0;
+	u32 offset = 0;
+	u32 len;
 	u64 slot;
 	u64 i;
+	u16 status = 0;
+
+	len = min_t(u32, req->transfer_len,
+		    NVMET_ERROR_LOG_SLOTS * sizeof(struct nvme_error_slot));
 
 	spin_lock_irqsave(&ctrl->error_lock, flags);
+
+	/*
+	 * The NVMe base specification requires the most recent error to be
+	 * the first log entry, so walk the ring backwards from the slot of
+	 * the last error and stop at the end of the requested buffer.
+	 */
 	slot = ctrl->err_counter % NVMET_ERROR_LOG_SLOTS;
 
-	for (i = 0; i < NVMET_ERROR_LOG_SLOTS; i++) {
-		if (nvmet_copy_to_sgl(req, offset, &ctrl->slots[slot],
-				sizeof(struct nvme_error_slot)))
+	for (i = 0; i < NVMET_ERROR_LOG_SLOTS &&
+	     offset + sizeof(struct nvme_error_slot) <= len; i++) {
+		status = nvmet_copy_to_sgl(req, offset, &ctrl->slots[slot],
+					   sizeof(struct nvme_error_slot));
+		if (status)
 			break;
 
 		if (slot == 0)
@@ -195,7 +208,20 @@ static void nvmet_execute_get_log_page_error(struct nvmet_req *req)
 		offset += sizeof(struct nvme_error_slot);
 	}
 	spin_unlock_irqrestore(&ctrl->error_lock, flags);
-	nvmet_req_complete(req, 0);
+
+	/*
+	 * Zero what the ring walk did not fill: either the tail beyond the
+	 * fixed log, or the partial entry at the end of a short request.
+	 */
+	if (req->transfer_len > offset) {
+		u16 zero_status;
+
+		zero_status = nvmet_zero_sgl(req, offset,
+					     req->transfer_len - offset);
+		if (!status)
+			status = zero_status;
+	}
+	nvmet_req_complete(req, status);
 }
 
 static void nvmet_execute_get_supported_log_pages(struct nvmet_req *req)
@@ -222,6 +248,9 @@ static void nvmet_execute_get_supported_log_pages(struct nvmet_req *req)
 	logs->lids[NVME_LOG_RESERVATION] = cpu_to_le32(NVME_LIDS_LSUPP);
 
 	status = nvmet_copy_to_sgl(req, 0, logs, sizeof(*logs));
+	if (!status && req->transfer_len > sizeof(*logs))
+		status = nvmet_zero_sgl(req, sizeof(*logs),
+					req->transfer_len - sizeof(*logs));
 	kfree(logs);
 out:
 	nvmet_req_complete(req, status);
@@ -303,7 +332,7 @@ static void nvmet_execute_get_log_page_rmi(struct nvmet_req *req)
 		goto out;
 	}
 
-	if (req->transfer_len != sizeof(*log)) {
+	if (req->transfer_len < sizeof(*log)) {
 		status = NVME_SC_SGL_INVALID_DATA | NVME_STATUS_DNR;
 		goto out;
 	}
@@ -322,6 +351,9 @@ static void nvmet_execute_get_log_page_rmi(struct nvmet_req *req)
 		log->numa = cpu_to_le16(1);
 
 	status = nvmet_copy_to_sgl(req, 0, log, sizeof(*log));
+	if (!status && req->transfer_len > sizeof(*log))
+		status = nvmet_zero_sgl(req, sizeof(*log),
+					req->transfer_len - sizeof(*log));
 	kfree(log);
 out:
 	nvmet_req_complete(req, status);
@@ -437,6 +469,9 @@ static void nvmet_execute_get_log_cmd_effects_ns(struct nvmet_req *req)
 	}
 
 	status = nvmet_copy_to_sgl(req, 0, log, sizeof(*log));
+	if (!status && req->transfer_len > sizeof(*log))
+		status = nvmet_zero_sgl(req, sizeof(*log),
+					req->transfer_len - sizeof(*log));
 free:
 	kfree(log);
 out:
@@ -528,6 +563,9 @@ static void nvmet_execute_get_log_page_endgrp(struct nvmet_req *req)
 	put_unaligned_le64(data_units_written, &log->duw[0]);
 copy:
 	status = nvmet_copy_to_sgl(req, 0, log, sizeof(*log));
+	if (!status && req->transfer_len > sizeof(*log))
+		status = nvmet_zero_sgl(req, sizeof(*log),
+					req->transfer_len - sizeof(*log));
 	kfree(log);
 out:
 	nvmet_req_complete(req, status);
@@ -602,6 +640,9 @@ static void nvmet_execute_get_log_page_features(struct nvmet_req *req)
 		cpu_to_le32(NVME_FIS_FSUPP | NVME_FIS_NSCPE);
 
 	status = nvmet_copy_to_sgl(req, 0, features, sizeof(*features));
+	if (!status && req->transfer_len > sizeof(*features))
+		status = nvmet_zero_sgl(req, sizeof(*features),
+					req->transfer_len - sizeof(*features));
 	kfree(features);
 out:
 	nvmet_req_complete(req, status);
diff --git a/drivers/nvme/target/pr.c b/drivers/nvme/target/pr.c
index 14eaa99f98fa..99fdcbf572a9 100644
--- a/drivers/nvme/target/pr.c
+++ b/drivers/nvme/target/pr.c
@@ -130,6 +130,13 @@ void nvmet_execute_get_log_page_resv(struct nvmet_req *req)
 out:
 	status = nvmet_copy_to_sgl(req, 0, &log, sizeof(log));
 	mutex_unlock(&log_mgr->lock);
+	/*
+	 * Zero the unused tail outside the log_mgr lock: the host controls
+	 * the length, so this can touch a large buffer.
+	 */
+	if (!status && req->transfer_len > sizeof(log))
+		status = nvmet_zero_sgl(req, sizeof(log),
+					req->transfer_len - sizeof(log));
 	nvmet_req_complete(req, status);
 }
 
-- 
2.27.0

