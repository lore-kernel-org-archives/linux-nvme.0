Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79F20C433FE
	for <linux-nvme@archiver.kernel.org>; Wed,  2 Nov 2022 07:52:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=HelH4Qe0yz4zpnWuYQ/Mj9HweJquLKt+poP1bMXsQoM=; b=tQBjn1rN6b2wfLWsFUMZLJka1/
	c+/Xh6n51HqChntrpO4xxrXQpiasUgXU+4UDCicDba3QiPTjGtxQV7uAywbWahM0MMCOX1pXl4tPn
	87wykRB87nwZKZNeqSAz23QOwFYQvOToztYtYOYOtXoqIoXM4kCOuDFhTONp8Jt0UnJhVZXRx2G1R
	4YKhwC1M4hepvPAXwmCSitFCh9ZJgueYyfvMFLdqh59XCe6oouRQUdxzpEj3VnRk/tG2SY30XJsiD
	4h85q24DdsEElw7+vUl0TraPPEs/CaNWWG8SrZmMsFmDqx6r5pXBLL5+OUklRco/PN/0Izj1DFImb
	PG17sVtw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oq8Y8-008gZE-FC; Wed, 02 Nov 2022 07:52:36 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oq8Y1-008gVU-49
	for linux-nvme@lists.infradead.org; Wed, 02 Nov 2022 07:52:30 +0000
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
	by smtp-out1.suse.de (Postfix) with ESMTP id B17443398D;
	Wed,  2 Nov 2022 07:52:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1667375547; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HelH4Qe0yz4zpnWuYQ/Mj9HweJquLKt+poP1bMXsQoM=;
	b=QHTOZz1TsxT+8K2BtY9oYMrQfOhiGSvuFVtiKaAhFXDwiGT7t4OPaN8nlCaitWANQf6sg9
	Ys4wtNNS0aXoBI3wM7qOxK+T/UeGsZ7s5473yNyv16rxqpGxUwViMDqGGaN3UffleeKwF+
	CKUrXQbcFsQbeJppcIaEtd8xxE54HTU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1667375547;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HelH4Qe0yz4zpnWuYQ/Mj9HweJquLKt+poP1bMXsQoM=;
	b=G0Ikm4KK3CHrcryalAOy5d7D+Q6aILFQ4efd8Lb86SmiaRSZGDPwN7wXQZqwGZ5bQP3iO4
	ovq+zSbNe/NkAuBw==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
	by relay2.suse.de (Postfix) with ESMTP id AC21F2C149;
	Wed,  2 Nov 2022 07:52:27 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
	id A845C51AD6CB; Wed,  2 Nov 2022 08:52:27 +0100 (CET)
From: Hannes Reinecke <hare@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCH 5/6] nvme-auth: set DNR bit on non-retryable errors
Date: Wed,  2 Nov 2022 08:52:23 +0100
Message-Id: <20221102075224.70869-6-hare@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20221102075224.70869-1-hare@suse.de>
References: <20221102075224.70869-1-hare@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221102_005229_373551_B17B5A1F 
X-CRM114-Status: GOOD (  15.21  )
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

If the negotiation fails due to protocol errors or unsupported
hash algorithms we need to set the DNR bit on the final status
to avoid retries.

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/nvme/host/auth.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/nvme/host/auth.c b/drivers/nvme/host/auth.c
index b4af8661c988..6ca0c2bb06c0 100644
--- a/drivers/nvme/host/auth.c
+++ b/drivers/nvme/host/auth.c
@@ -151,7 +151,7 @@ static int nvme_auth_process_dhchap_challenge(struct nvme_ctrl *ctrl,
 
 	if (chap->buf_size < size) {
 		chap->status = NVME_AUTH_DHCHAP_FAILURE_INCORRECT_PAYLOAD;
-		return NVME_SC_INVALID_FIELD;
+		return NVME_SC_DNR | NVME_SC_INVALID_FIELD;
 	}
 
 	hmac_name = nvme_auth_hmac_name(data->hashid);
@@ -160,7 +160,7 @@ static int nvme_auth_process_dhchap_challenge(struct nvme_ctrl *ctrl,
 			 "qid %d: invalid HASH ID %d\n",
 			 chap->qid, data->hashid);
 		chap->status = NVME_AUTH_DHCHAP_FAILURE_HASH_UNUSABLE;
-		return NVME_SC_INVALID_FIELD;
+		return NVME_SC_DNR | NVME_SC_INVALID_FIELD;
 	}
 
 	if (chap->hash_id == data->hashid && chap->shash_tfm &&
@@ -198,7 +198,7 @@ static int nvme_auth_process_dhchap_challenge(struct nvme_ctrl *ctrl,
 		crypto_free_shash(chap->shash_tfm);
 		chap->shash_tfm = NULL;
 		chap->status = NVME_AUTH_DHCHAP_FAILURE_HASH_UNUSABLE;
-		return NVME_SC_AUTH_REQUIRED;
+		return NVME_SC_DNR | NVME_SC_AUTH_REQUIRED;
 	}
 
 	/* Reset host response if the hash had been changed */
@@ -220,7 +220,7 @@ static int nvme_auth_process_dhchap_challenge(struct nvme_ctrl *ctrl,
 			 chap->qid, data->dhgid);
 		chap->status = NVME_AUTH_DHCHAP_FAILURE_DHGROUP_UNUSABLE;
 		/* Leave previous dh_tfm intact */
-		return NVME_SC_AUTH_REQUIRED;
+		return NVME_SC_DNR | NVME_SC_AUTH_REQUIRED;
 	}
 
 	/* Clear host and controller key to avoid accidental reuse */
@@ -251,7 +251,7 @@ static int nvme_auth_process_dhchap_challenge(struct nvme_ctrl *ctrl,
 				 "qid %d: empty DH value\n",
 				 chap->qid);
 			chap->status = NVME_AUTH_DHCHAP_FAILURE_DHGROUP_UNUSABLE;
-			return NVME_SC_INVALID_FIELD;
+			return NVME_SC_DNR | NVME_SC_INVALID_FIELD;
 		}
 
 		chap->dh_tfm = crypto_alloc_kpp(kpp_name, 0, 0);
@@ -272,7 +272,7 @@ static int nvme_auth_process_dhchap_challenge(struct nvme_ctrl *ctrl,
 			 "qid %d: invalid DH value for NULL DH\n",
 			 chap->qid);
 		chap->status = NVME_AUTH_DHCHAP_FAILURE_INCORRECT_PAYLOAD;
-		return NVME_SC_INVALID_FIELD;
+		return NVME_SC_DNR | NVME_SC_INVALID_FIELD;
 	}
 	chap->dhgroup_id = data->dhgid;
 
@@ -353,7 +353,7 @@ static int nvme_auth_process_dhchap_success1(struct nvme_ctrl *ctrl,
 
 	if (chap->buf_size < size) {
 		chap->status = NVME_AUTH_DHCHAP_FAILURE_INCORRECT_PAYLOAD;
-		return NVME_SC_INVALID_FIELD;
+		return NVME_SC_DNR | NVME_SC_INVALID_FIELD;
 	}
 
 	if (data->hl != chap->hash_len) {
@@ -361,7 +361,7 @@ static int nvme_auth_process_dhchap_success1(struct nvme_ctrl *ctrl,
 			 "qid %d: invalid hash length %u\n",
 			 chap->qid, data->hl);
 		chap->status = NVME_AUTH_DHCHAP_FAILURE_HASH_UNUSABLE;
-		return NVME_SC_INVALID_FIELD;
+		return NVME_SC_DNR | NVME_SC_INVALID_FIELD;
 	}
 
 	/* Just print out information for the admin queue */
@@ -385,7 +385,7 @@ static int nvme_auth_process_dhchap_success1(struct nvme_ctrl *ctrl,
 			 "qid %d: controller authentication failed\n",
 			 chap->qid);
 		chap->status = NVME_AUTH_DHCHAP_FAILURE_FAILED;
-		return NVME_SC_AUTH_REQUIRED;
+		return NVME_SC_DNR | NVME_SC_AUTH_REQUIRED;
 	}
 
 	/* Just print out information for the admin queue */
@@ -753,7 +753,7 @@ static void __nvme_auth_work(struct work_struct *work)
 					 NVME_AUTH_DHCHAP_MESSAGE_CHALLENGE);
 	if (ret) {
 		chap->status = ret;
-		chap->error = NVME_SC_AUTH_REQUIRED;
+		chap->error = NVME_SC_DNR | NVME_SC_AUTH_REQUIRED;
 		goto out_free;
 	}
 
@@ -817,7 +817,7 @@ static void __nvme_auth_work(struct work_struct *work)
 					 NVME_AUTH_DHCHAP_MESSAGE_SUCCESS1);
 	if (ret) {
 		chap->status = ret;
-		chap->error = NVME_SC_AUTH_REQUIRED;
+		chap->error = NVME_SC_DNR | NVME_SC_AUTH_REQUIRED;
 		goto out_free;
 	}
 
-- 
2.35.3


