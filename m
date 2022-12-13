Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FE50C4332F
	for <linux-nvme@archiver.kernel.org>; Tue, 13 Dec 2022 19:00:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=L1Fg0TlPAq+kprLi2thLPdL1grmIMm08dag2HdLw148=; b=W2jP8Uu4FwmF3+kM/yL28ScWtc
	p7C21IBX8b9dzLxEF+OKx4u8Yw9WLyyuFMDpRosAC9YFEaA9XCiKm8DQsI/QZLomnkL7jbNKb6CwA
	N4w6UK4FzbZFEevnw6jkXBigI5Y7+C78jxv+zQF7lKLkxBLTGsgfR5Ax3ArotcmLKw09Y4iWvZq31
	aXlWnOJR/BIVx4TlBVGGyha/VfnTtMDprO+3CBKsx+jnrooEJQWQnjQnCqb19jAZPeuWArS0Pyaje
	rPZ3OqWeltrKon7zbdmXoUFJuxJaNXHZQbszk6MYN5jaCbWW4AZjrbezg1qsZnVINyX3LOPXdlMjO
	cwn0GBeQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p5AW5-0059se-1x; Tue, 13 Dec 2022 19:00:37 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p5AW1-0059qc-J4
	for linux-nvme@lists.infradead.org; Tue, 13 Dec 2022 19:00:35 +0000
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
	by smtp-out1.suse.de (Postfix) with ESMTP id E7775228CB;
	Tue, 13 Dec 2022 19:00:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1670958027; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=L1Fg0TlPAq+kprLi2thLPdL1grmIMm08dag2HdLw148=;
	b=SCP3B3DIxwnO1W6TEJajzRARcY63j/mLuzcuwxLx6+PCFjau1sABuRcH0mAXnIgSFK1P/Z
	06TbN6oi38ah8RloYFN47stq5FLgt/Y6MQJPlO5Ik+zv/p25jscnHYIElwH+12AwSF/oAK
	MwY/42RGzwqFWaof9pYcqB+/gz7s5GY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1670958027;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=L1Fg0TlPAq+kprLi2thLPdL1grmIMm08dag2HdLw148=;
	b=0yCRk7pWRbPONzdFQs9Z2mb08tUh2WRlnn5nR7aREcbYW7t6hFCIf8OpUiOmc1cACZ5mDu
	FMJBTO2zPCDkxaAA==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
	by relay2.suse.de (Postfix) with ESMTP id DFB852C142;
	Tue, 13 Dec 2022 19:00:27 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
	id D352C51B60D3; Tue, 13 Dec 2022 20:00:27 +0100 (CET)
From: Hannes Reinecke <hare@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCH] nvme-auth: don't use NVMe status codes
Date: Tue, 13 Dec 2022 20:00:26 +0100
Message-Id: <20221213190026.36036-1-hare@suse.de>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221213_110033_827222_6EBF3756 
X-CRM114-Status: GOOD (  12.37  )
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

NVMe status codes are part of the wire protocol, and shouldn't be
fabricated in the stack. So with this patch the authentication code
is switched over to use error codes; as a side effect authentication
failures due to internal error won't be retried anymore.
But that shouldn't have happened anyway.

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/nvme/host/auth.c | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/nvme/host/auth.c b/drivers/nvme/host/auth.c
index bb0abbe4491c..980f9125b751 100644
--- a/drivers/nvme/host/auth.c
+++ b/drivers/nvme/host/auth.c
@@ -158,7 +158,7 @@ static int nvme_auth_process_dhchap_challenge(struct nvme_ctrl *ctrl,
 
 	if (size > CHAP_BUF_SIZE) {
 		chap->status = NVME_AUTH_DHCHAP_FAILURE_INCORRECT_PAYLOAD;
-		return NVME_SC_INVALID_FIELD;
+		return -EINVAL;
 	}
 
 	hmac_name = nvme_auth_hmac_name(data->hashid);
@@ -167,7 +167,7 @@ static int nvme_auth_process_dhchap_challenge(struct nvme_ctrl *ctrl,
 			 "qid %d: invalid HASH ID %d\n",
 			 chap->qid, data->hashid);
 		chap->status = NVME_AUTH_DHCHAP_FAILURE_HASH_UNUSABLE;
-		return NVME_SC_INVALID_FIELD;
+		return -EPROTO;
 	}
 
 	if (chap->hash_id == data->hashid && chap->shash_tfm &&
@@ -193,7 +193,7 @@ static int nvme_auth_process_dhchap_challenge(struct nvme_ctrl *ctrl,
 			 chap->qid, hmac_name, PTR_ERR(chap->shash_tfm));
 		chap->shash_tfm = NULL;
 		chap->status = NVME_AUTH_DHCHAP_FAILURE_FAILED;
-		return NVME_SC_AUTH_REQUIRED;
+		return -ENOMEM;
 	}
 
 	if (crypto_shash_digestsize(chap->shash_tfm) != data->hl) {
@@ -203,7 +203,7 @@ static int nvme_auth_process_dhchap_challenge(struct nvme_ctrl *ctrl,
 		crypto_free_shash(chap->shash_tfm);
 		chap->shash_tfm = NULL;
 		chap->status = NVME_AUTH_DHCHAP_FAILURE_HASH_UNUSABLE;
-		return NVME_SC_AUTH_REQUIRED;
+		return -EPROTO;
 	}
 
 	chap->hash_id = data->hashid;
@@ -219,7 +219,7 @@ static int nvme_auth_process_dhchap_challenge(struct nvme_ctrl *ctrl,
 			 chap->qid, data->dhgid);
 		chap->status = NVME_AUTH_DHCHAP_FAILURE_DHGROUP_UNUSABLE;
 		/* Leave previous dh_tfm intact */
-		return NVME_SC_AUTH_REQUIRED;
+		return -EPROTO;
 	}
 
 	if (chap->dhgroup_id == data->dhgid &&
@@ -242,7 +242,7 @@ static int nvme_auth_process_dhchap_challenge(struct nvme_ctrl *ctrl,
 				 "qid %d: empty DH value\n",
 				 chap->qid);
 			chap->status = NVME_AUTH_DHCHAP_FAILURE_DHGROUP_UNUSABLE;
-			return NVME_SC_INVALID_FIELD;
+			return -EPROTO;
 		}
 
 		chap->dh_tfm = crypto_alloc_kpp(kpp_name, 0, 0);
@@ -254,7 +254,7 @@ static int nvme_auth_process_dhchap_challenge(struct nvme_ctrl *ctrl,
 				 chap->qid, ret, gid_name);
 			chap->status = NVME_AUTH_DHCHAP_FAILURE_DHGROUP_UNUSABLE;
 			chap->dh_tfm = NULL;
-			return NVME_SC_AUTH_REQUIRED;
+			return -ret;
 		}
 		dev_dbg(ctrl->device, "qid %d: selected DH group %s\n",
 			chap->qid, gid_name);
@@ -263,7 +263,7 @@ static int nvme_auth_process_dhchap_challenge(struct nvme_ctrl *ctrl,
 			 "qid %d: invalid DH value for NULL DH\n",
 			 chap->qid);
 		chap->status = NVME_AUTH_DHCHAP_FAILURE_INCORRECT_PAYLOAD;
-		return NVME_SC_INVALID_FIELD;
+		return -EPROTO;
 	}
 	chap->dhgroup_id = data->dhgid;
 
@@ -274,7 +274,7 @@ static int nvme_auth_process_dhchap_challenge(struct nvme_ctrl *ctrl,
 		chap->ctrl_key = kmalloc(dhvlen, GFP_KERNEL);
 		if (!chap->ctrl_key) {
 			chap->status = NVME_AUTH_DHCHAP_FAILURE_FAILED;
-			return NVME_SC_AUTH_REQUIRED;
+			return -ENOMEM;
 		}
 		chap->ctrl_key_len = dhvlen;
 		memcpy(chap->ctrl_key, data->cval + chap->hash_len,
@@ -344,7 +344,7 @@ static int nvme_auth_process_dhchap_success1(struct nvme_ctrl *ctrl,
 
 	if (size > CHAP_BUF_SIZE) {
 		chap->status = NVME_AUTH_DHCHAP_FAILURE_INCORRECT_PAYLOAD;
-		return NVME_SC_INVALID_FIELD;
+		return -EINVAL;
 	}
 
 	if (data->hl != chap->hash_len) {
@@ -352,7 +352,7 @@ static int nvme_auth_process_dhchap_success1(struct nvme_ctrl *ctrl,
 			 "qid %d: invalid hash length %u\n",
 			 chap->qid, data->hl);
 		chap->status = NVME_AUTH_DHCHAP_FAILURE_HASH_UNUSABLE;
-		return NVME_SC_INVALID_FIELD;
+		return -EPROTO;
 	}
 
 	/* Just print out information for the admin queue */
@@ -376,7 +376,7 @@ static int nvme_auth_process_dhchap_success1(struct nvme_ctrl *ctrl,
 			 "qid %d: controller authentication failed\n",
 			 chap->qid);
 		chap->status = NVME_AUTH_DHCHAP_FAILURE_FAILED;
-		return NVME_SC_AUTH_REQUIRED;
+		return -ECONNREFUSED;
 	}
 
 	/* Just print out information for the admin queue */
@@ -730,7 +730,7 @@ static void nvme_queue_auth_work(struct work_struct *work)
 					 NVME_AUTH_DHCHAP_MESSAGE_CHALLENGE);
 	if (ret) {
 		chap->status = ret;
-		chap->error = NVME_SC_AUTH_REQUIRED;
+		chap->error = -ECONNREFUSED;
 		return;
 	}
 
@@ -798,7 +798,7 @@ static void nvme_queue_auth_work(struct work_struct *work)
 					 NVME_AUTH_DHCHAP_MESSAGE_SUCCESS1);
 	if (ret) {
 		chap->status = ret;
-		chap->error = NVME_SC_AUTH_REQUIRED;
+		chap->error = -ECONNREFUSED;
 		return;
 	}
 
@@ -819,7 +819,7 @@ static void nvme_queue_auth_work(struct work_struct *work)
 	ret = nvme_auth_process_dhchap_success1(ctrl, chap);
 	if (ret) {
 		/* Controller authentication failed */
-		chap->error = NVME_SC_AUTH_REQUIRED;
+		chap->error = -ECONNREFUSED;
 		goto fail2;
 	}
 
-- 
2.35.3


