Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36B0CCD8C88
	for <linux-nvme@archiver.kernel.org>; Sat,  6 Jun 2026 18:13:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=vs9sOPs398rODDZTFwVgFO5RKpuWAqMg6hg4GuJ04No=; b=DsqdDYbI0QJd8rt7Cgom8e88G3
	aad40i+6351dnKp0B6NWdsB4+NVJVdI0x437cUg5OtAXRrMuvGykg0kw7RLq/qXW87barn8yRiaxE
	UDRXOzwG5e1dmZTBJzgp0tVm7KSjkle338wGpI5jj/jJm9TMjaYlpCtlHCFoAVi/9QQkX+stdXNkV
	AomnWjJgyh9Q5yE7Zaoybbq7t9VlwE3zqdyK6L+M3x2QXS3IBR3c6ciS0JIFyF7hMem3DD0yr0CAx
	8mIE/HF/4P7oBeWO4wyOc2mNioCIkw1v2VMROrX1goKZf4LBzMz030Xp2JbbucfcMRXwX6V3yuMHS
	1XyCQYRA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wVvWS-00000001kQN-09Jw;
	Sat, 06 Jun 2026 18:13:28 +0000
Received: from mail-qt1-x834.google.com ([2607:f8b0:4864:20::834])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wVvWP-00000001kQ1-1l3O
	for linux-nvme@lists.infradead.org;
	Sat, 06 Jun 2026 18:13:26 +0000
Received: by mail-qt1-x834.google.com with SMTP id d75a77b69052e-5176d4c14f5so24908241cf.0
        for <linux-nvme@lists.infradead.org>; Sat, 06 Jun 2026 11:13:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780769603; x=1781374403; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vs9sOPs398rODDZTFwVgFO5RKpuWAqMg6hg4GuJ04No=;
        b=PxGkKRaqjNqxjXn59eZ6AUkFe09EW73qHSVWHrDRJQr+wZ3CpCcACzFWO9DRXrzIGu
         YHA9fAuaqW4sw3ANY9SXPL+JCNqatT4Yy9Qzq850Sc6aa84b9czUjhptrb6BIhkoo6HP
         NircKnG0NN/ZszveOuuiPBbt+NcxqBXg04a7Z8iEqQnk3QVGr3wmzuA3NR6zG2m6Hk1w
         YABH/aBWURqapmo8zfOeXvWd1cH8PfJeCENvORCppX9mzgLy8skeIOC6vs+vFbcRSH5H
         2EhuZynB7HrAdwJ9yqv2EywNsa1fobhwQK6CQDrbEOuwRq1Gt3aavyhAWWIvSVg8v/gb
         xyYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780769603; x=1781374403;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vs9sOPs398rODDZTFwVgFO5RKpuWAqMg6hg4GuJ04No=;
        b=iM6e9Qcgr81sE/k065iULfezZ/zjFU9I5bzXNrpRr5tjZ/4jkMabvGW7Tj3DoNolQc
         e4YVaphBIeYLYIa7vAjNrLCKq0mtW9ZMfOyK5UtLQrhUhfyFBfZyZYg9dx4aRvEppNJP
         +1vCk3TFRBcpL7g07mOYewcWML3mzIAiJHYGCMYwRaQYYk2n+ueVeky39aZoH6hdTetv
         hvg2Q7yf5eGG8FYY5vYnPR5kAe36XeKzqLePjuSJSsmjeqGEplxIivyduJmckcZz/29K
         T0O9EPUJ1JQSztWWxGdIYbRvNHT1eN3YMIHPKIgNJJn8dYDVuLNnXHagemRKbqwIdneh
         5GuA==
X-Forwarded-Encrypted: i=1; AFNElJ8Hyyi9KuwasrWQ+p7vHnyGR/SIzX6FPeDrPnr7H1Q5GiTFnj88dAiqEPm7RrS5e9M9h3km85acMh/U@lists.infradead.org
X-Gm-Message-State: AOJu0YyvdAldk4clvaCOF9ywnAzkdWiAXF6sxN28nULodAzHOwZLvMRG
	TTQr7veQJSC1OofJrkk1BFM8zZU/RCe4Zp/SnVSBlF/qrA0FJImuPDOL
X-Gm-Gg: Acq92OE/bbktYhWg5GzwKvcks9C7DkiEE5XCSm00wOUu52w9RSktHnYPTbb+gOOdfFJ
	SzUTolFJneJtJVIuj32r6dGJqAgvBXoCb7OuWGh6ODX/wqqB6p/wDuGK0P2eWTEKkF+h030yFFP
	0gpuCDxVsdJiv6JHi7d1OVSe7ippLVBuTFq5x7iMY18YjOEg/QZtIrvmvfUaAd0l4JPrDzSq+eK
	a7cHsUDPKdsiEFj/bBHwspbrH2gEYy9eHer5+C5O7dzXIQkcTOSYcpQpRMYBzxZhJXYOYUPyPzS
	hFUSOOkWI3byvLguBeiaOB+QryMgh9AfHdMJMqA7mijhy/PA/GyIpJtpzUD2UUX6MYGOo7a1FCM
	Y64bZXu8H3Bg/LsvEyvYGGfrgMLdNKKYWzlRhidhKNkNKxhmLJrNv2UvFtKS8M8+8cQd75O76x1
	LPNsUHx3xPF+kQhG7AOb68YoMTn0dpaH/wyeCnf+dPIERY8ilfyWj5wofwN3MU8W7Mbaxod6Lkf
	N4WtgiR0pOLcBHQ79jyk5yHqqzbRls=
X-Received: by 2002:a05:622a:4d09:b0:516:e290:991a with SMTP id d75a77b69052e-51795be8192mr140592791cf.40.1780769603612;
        Sat, 06 Jun 2026 11:13:23 -0700 (PDT)
Received: from server0 (c-68-48-65-54.hsd1.mi.comcast.net. [68.48.65.54])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51775da6f41sm104769301cf.22.2026.06.06.11.13.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Jun 2026 11:13:23 -0700 (PDT)
From: Michael Bommarito <michael.bommarito@gmail.com>
To: Hannes Reinecke <hare@suse.de>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>
Cc: Jens Axboe <axboe@kernel.dk>,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] nvmet-auth: reject short AUTH_RECEIVE buffers
Date: Sat,  6 Jun 2026 14:13:06 -0400
Message-ID: <20260606181306.1651139-1-michael.bommarito@gmail.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260606_111325_470851_401CCC8A 
X-CRM114-Status: GOOD (  15.79  )
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

nvmet_execute_auth_receive() trusts the AUTH_RECEIVE allocation length
after checking only that it is nonzero and matches the transfer length.
In SUCCESS1 and FAILURE1/default states, that lets a remote NVMe-oF
initiator reach fixed-size DHCHAP response builders with a kmalloc()
buffer shorter than the response, so the builder writes past the
allocation.

Reject AUTH_RECEIVE commands whose allocation length is shorter than the
response for the current state before allocating the buffer. Keep the
existing CHALLENGE variable-length guard in nvmet_auth_challenge().

This is the AUTH_RECEIVE response-write counterpart to the separately
posted AUTH_SEND read-side bounds fix in nvmet_auth_reply() [1]; the two
paths do not overlap.

Link: https://lore.kernel.org/all/f4aca9b14e74a7f7f8cd9620e13cc32a6a2b7746@linux.dev/ [1]
Fixes: db1312dd95488 ("nvmet: implement basic In-Band Authentication")
Cc: stable@vger.kernel.org
Assisted-by: Codex:gpt-5-5-xhigh
Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
---
A temporary KUnit harness, not included in this patch, ran under UML
with KASAN enabled. The stock run crashed in
nvmet_execute_auth_receive() on the SUCCESS1 path with "memset:
detected buffer overflow: 16 byte write of buffer size 1"; the patched
run passed the same harness. The harness source is available on
request.

 drivers/nvme/target/fabrics-cmd-auth.c | 27 ++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/drivers/nvme/target/fabrics-cmd-auth.c b/drivers/nvme/target/fabrics-cmd-auth.c
index f1e613e7c63e5..77c7b412a8691 100644
--- a/drivers/nvme/target/fabrics-cmd-auth.c
+++ b/drivers/nvme/target/fabrics-cmd-auth.c
@@ -487,11 +487,30 @@ u32 nvmet_auth_receive_data_len(struct nvmet_req *req)
 	return le32_to_cpu(req->cmd->auth_receive.al);
 }
 
+static u32 nvmet_auth_receive_min_len(struct nvmet_req *req)
+{
+	struct nvmet_ctrl *ctrl = req->sq->ctrl;
+	u32 hash_len = 0;
+
+	switch (req->sq->dhchap_step) {
+	case NVME_AUTH_DHCHAP_MESSAGE_CHALLENGE:
+		return 0;
+	case NVME_AUTH_DHCHAP_MESSAGE_SUCCESS1:
+		if (req->sq->dhchap_c2)
+			hash_len = nvme_auth_hmac_hash_len(ctrl->shash_id);
+
+		return sizeof(struct nvmf_auth_dhchap_success1_data) + hash_len;
+	default:
+		return sizeof(struct nvmf_auth_dhchap_failure_data);
+	}
+}
+
 void nvmet_execute_auth_receive(struct nvmet_req *req)
 {
 	struct nvmet_ctrl *ctrl = req->sq->ctrl;
 	void *d;
 	u32 al;
+	u32 min_len;
 	u16 status = 0;
 
 	if (req->cmd->auth_receive.secp != NVME_AUTH_DHCHAP_PROTOCOL_IDENTIFIER) {
@@ -524,6 +543,14 @@ void nvmet_execute_auth_receive(struct nvmet_req *req)
 		return;
 	}
 
+	min_len = nvmet_auth_receive_min_len(req);
+	if (al < min_len) {
+		status = NVME_SC_INVALID_FIELD | NVME_STATUS_DNR;
+		req->error_loc =
+			offsetof(struct nvmf_auth_receive_command, al);
+		goto done;
+	}
+
 	d = kmalloc(al, GFP_KERNEL);
 	if (!d) {
 		status = NVME_SC_INTERNAL;
-- 
2.53.0


