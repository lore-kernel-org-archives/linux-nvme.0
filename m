Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C04A8C433FE
	for <linux-nvme@archiver.kernel.org>; Wed,  2 Nov 2022 07:52:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=QynfWja9Pd2hhgSfxzRlevrenHhiR2YEmw0o8b+MmZs=; b=iYzUhL7G2acyUf+o89zWP4rlG8
	pfvXS782VrUmIsrEN1LukXLCdOM9yUi//zWxSbixC4vFH3KSt/lvsDQvia8xDRHtXHBfv9rA1slj3
	hJn8EWNgTO23O4XJ4gbfJ6TdoAnprRZVRPKQiKcaCjv/8J3xnbUGcunk38RRNQBZwkngllnK7npW1
	csqrAQ/KlaClLe+go5nwfXdB8ZItKliWTY/CzMn6uiSt+hArIM4U/TIJcw85LwcmRhbkCGvFUGrfd
	mXC49yc+1XSKmkcum4OVY+Iv/7REZxxCbK9X19YBHDaTnJDht5fypOLgj+Y/z4JX9Gcoz3CGphBmR
	QTg+77aQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oq8YD-008gat-A7; Wed, 02 Nov 2022 07:52:41 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oq8Y1-008gVT-48
	for linux-nvme@lists.infradead.org; Wed, 02 Nov 2022 07:52:32 +0000
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
	by smtp-out2.suse.de (Postfix) with ESMTP id A8BAA1F8E3;
	Wed,  2 Nov 2022 07:52:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1667375547; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QynfWja9Pd2hhgSfxzRlevrenHhiR2YEmw0o8b+MmZs=;
	b=xQYL2P4MfzM5QQyW38cynfBa5aIOhJqdUFE4zpNai0g7Wp0s6xGRRUzBOdOCv2xBoa/5mF
	MxWvod5X3wWidpEncXQYGxJeoTNyRYnTV2fpvlzZfSE3c9FBxEfeCszOov/kP9z4K0wOym
	6VQ4d7RsLoKwrrK8Q+Lq/DLNFo2VY+k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1667375547;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QynfWja9Pd2hhgSfxzRlevrenHhiR2YEmw0o8b+MmZs=;
	b=jitC2coRW64og7WYa270seG1dlDqQx3N2TObnyYKF5HViNsX8zXFnB/XkJ6Ij+uXIiR+0Z
	L4+b77VcSPJij+DA==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
	by relay2.suse.de (Postfix) with ESMTP id A40E12C146;
	Wed,  2 Nov 2022 07:52:27 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
	id 9FE2251AD6C9; Wed,  2 Nov 2022 08:52:27 +0100 (CET)
From: Hannes Reinecke <hare@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCH 4/6] nvme-auth: return real error instead of NVME_SC_AUTH_REQUIRED
Date: Wed,  2 Nov 2022 08:52:22 +0100
Message-Id: <20221102075224.70869-5-hare@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20221102075224.70869-1-hare@suse.de>
References: <20221102075224.70869-1-hare@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221102_005229_373957_550ABBC3 
X-CRM114-Status: GOOD (  14.34  )
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

The caller should be equipped to handle combined nvme errors
(where a negative value indicates an error number and positive
ones an nvme status), so there is no need to return
NVME_SC_AUTH_REQUIRED on failure.

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/nvme/host/auth.c    | 18 +++++++++++-------
 drivers/nvme/host/fabrics.c |  2 --
 2 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/drivers/nvme/host/auth.c b/drivers/nvme/host/auth.c
index cece4f33e3a8..b4af8661c988 100644
--- a/drivers/nvme/host/auth.c
+++ b/drivers/nvme/host/auth.c
@@ -72,10 +72,12 @@ static int nvme_auth_submit(struct nvme_ctrl *ctrl, int qid,
 				     0, flags, nvme_max_retries);
 	if (ret > 0)
 		dev_warn(ctrl->device,
-			"qid %d auth_send failed with status %d\n", qid, ret);
+			"qid %d auth_%s failed with status %d\n",
+			 qid, auth_send ? "send" : "recv", ret);
 	else if (ret < 0)
 		dev_err(ctrl->device,
-			"qid %d auth_send failed with error %d\n", qid, ret);
+			"qid %d auth_%s failed with error %d\n",
+			qid, auth_send ? "send" : "recv", ret);
 	return ret;
 }
 
@@ -179,12 +181,14 @@ static int nvme_auth_process_dhchap_challenge(struct nvme_ctrl *ctrl,
 	chap->shash_tfm = crypto_alloc_shash(hmac_name, 0,
 					     CRYPTO_ALG_ALLOCATES_MEMORY);
 	if (IS_ERR(chap->shash_tfm)) {
+		int ret = PTR_ERR(chap->shash_tfm);
+
 		dev_warn(ctrl->device,
 			 "qid %d: failed to allocate hash %s, error %ld\n",
 			 chap->qid, hmac_name, PTR_ERR(chap->shash_tfm));
 		chap->shash_tfm = NULL;
 		chap->status = NVME_AUTH_DHCHAP_FAILURE_FAILED;
-		return NVME_SC_AUTH_REQUIRED;
+		return ret;
 	}
 
 	if (crypto_shash_digestsize(chap->shash_tfm) != data->hl) {
@@ -259,7 +263,7 @@ static int nvme_auth_process_dhchap_challenge(struct nvme_ctrl *ctrl,
 				 chap->qid, ret, gid_name);
 			chap->status = NVME_AUTH_DHCHAP_FAILURE_DHGROUP_UNUSABLE;
 			chap->dh_tfm = NULL;
-			return NVME_SC_AUTH_REQUIRED;
+			return ret;
 		}
 		dev_dbg(ctrl->device, "qid %d: selected DH group %s\n",
 			chap->qid, gid_name);
@@ -279,7 +283,7 @@ static int nvme_auth_process_dhchap_challenge(struct nvme_ctrl *ctrl,
 		chap->ctrl_key = kmalloc(dhvlen, GFP_KERNEL);
 		if (!chap->ctrl_key) {
 			chap->status = NVME_AUTH_DHCHAP_FAILURE_FAILED;
-			return NVME_SC_AUTH_REQUIRED;
+			return -ENOMEM;
 		}
 		chap->ctrl_key_len = dhvlen;
 		memcpy(chap->ctrl_key, data->cval + chap->hash_len,
@@ -831,7 +835,7 @@ static void __nvme_auth_work(struct work_struct *work)
 	ret = nvme_auth_process_dhchap_success1(ctrl, chap);
 	if (ret) {
 		/* Controller authentication failed */
-		chap->error = NVME_SC_AUTH_REQUIRED;
+		chap->error = ret;
 		goto fail2;
 	}
 
@@ -960,7 +964,7 @@ static void nvme_dhchap_auth_work(struct work_struct *work)
 	ret = nvme_auth_wait(ctrl, 0);
 	if (ret) {
 		dev_warn(ctrl->device,
-			 "qid 0: authentication failed\n");
+			 "qid 0: authentication failed with %d\n", ret);
 		return;
 	}
 
diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
index f4bfbaf733e9..7b64357ecd1d 100644
--- a/drivers/nvme/host/fabrics.c
+++ b/drivers/nvme/host/fabrics.c
@@ -416,7 +416,6 @@ int nvmf_connect_admin_queue(struct nvme_ctrl *ctrl)
 		if (ret) {
 			dev_warn(ctrl->device,
 				 "qid 0: authentication setup failed\n");
-			ret = NVME_SC_AUTH_REQUIRED;
 			goto out_free_data;
 		}
 		ret = nvme_auth_wait(ctrl, 0);
@@ -492,7 +491,6 @@ int nvmf_connect_io_queue(struct nvme_ctrl *ctrl, u16 qid)
 		if (ret) {
 			dev_warn(ctrl->device,
 				 "qid %d: authentication setup failed\n", qid);
-			ret = NVME_SC_AUTH_REQUIRED;
 		} else {
 			ret = nvme_auth_wait(ctrl, qid);
 			if (ret)
-- 
2.35.3


