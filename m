Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5B1BECAAA1
	for <linux-nvme@archiver.kernel.org>; Tue, 30 Aug 2022 12:49:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ngJzpoRNA9Z/7R414vcrZldjDhowsYPCgcln0pOXvw8=; b=Dq9tX06ymOOy+0QfGvxp5zj46w
	QbY8KcE2bQQY9loE6YSJSRd6RIzUvoOr2M55hh5p64n0kevjdrgwtQ3zaiBOUvF5w1zTse1a6VNE9
	+arnbtU4FuGxGLu+Vd6NenQixCyNAfBfLG7qXyjQLknS0zScXls1473ICtls33WoDfc0LsOjHl69w
	kzPmS3pF7wZ46Z7ZLxUsQZqlPVOu7W9go6kPdlcbB0uI+5C+95XyUu8/G9vn/GcITaILCK+12ZXkI
	Oklbbpg8JjniNMgcHYepFOnzKTpS4GezEnULuNDOMyBdNRmUu3RAM1rHt9q50KHF5zE+VdMMaXc+f
	qsYAa8Bg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oT0gd-00Gx9A-Ha; Tue, 30 Aug 2022 12:49:47 +0000
Received: from smtp-out2.suse.de ([2001:67c:2178:6::1d])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oT0gO-00Gwvz-4K
	for linux-nvme@lists.infradead.org; Tue, 30 Aug 2022 12:49:35 +0000
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
	by smtp-out2.suse.de (Postfix) with ESMTP id 1657F1FA77;
	Tue, 30 Aug 2022 12:49:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1661863767; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ngJzpoRNA9Z/7R414vcrZldjDhowsYPCgcln0pOXvw8=;
	b=hi160e0fsLDmUkNDkeaDpueFI/1LSMIpJuHD6cnrJQrV5Lx+nu7ehQM5cGijaVv4N6Kyuy
	FMo89yvpy6pdxdhXL1kjAR+rRgKAcmKiBj3KDuk+NWF2XdFZx2wyOOzAuYqHqIxGRPwzbA
	E64flPgWtYLeOq9CUnEFI/8TlAWK2wQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1661863767;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ngJzpoRNA9Z/7R414vcrZldjDhowsYPCgcln0pOXvw8=;
	b=ti9A1lMs/LH+Jlz6Yhek6wZW0Xp8L+wPI1AHDB9EJqxEidyGaBmkJs/2SsqcuqHOvQJQYw
	ZChxBxVgP3O0dhBA==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
	by relay2.suse.de (Postfix) with ESMTP id 0C21B2C143;
	Tue, 30 Aug 2022 12:49:27 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
	id 063A351AA5BC; Tue, 30 Aug 2022 14:49:27 +0200 (CEST)
From: Hannes Reinecke <hare@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCH 2/2] nvme-auth: set the DNR bit if authentication failed
Date: Tue, 30 Aug 2022 14:49:25 +0200
Message-Id: <20220830124925.40711-3-hare@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220830124925.40711-1-hare@suse.de>
References: <20220830124925.40711-1-hare@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220830_054932_514646_58E86CF2 
X-CRM114-Status: GOOD (  14.74  )
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

If authentication failed we should be setting the 'DNR' bit, as
each retry will yield exactly the same result; we rather should
change the parameters to 'nvme connect' to fixup the situation.

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/nvme/host/auth.c    | 20 ++++++++++----------
 drivers/nvme/host/fabrics.c |  4 ++--
 2 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/nvme/host/auth.c b/drivers/nvme/host/auth.c
index 4ca3f7d042f1..ad0decc5523f 100644
--- a/drivers/nvme/host/auth.c
+++ b/drivers/nvme/host/auth.c
@@ -158,7 +158,7 @@ static int nvme_auth_process_dhchap_challenge(struct nvme_ctrl *ctrl,
 			 "qid %d: invalid HASH ID %d\n",
 			 chap->qid, data->hashid);
 		chap->status = NVME_AUTH_DHCHAP_FAILURE_HASH_UNUSABLE;
-		return NVME_SC_INVALID_FIELD;
+		return NVME_SC_DNR | NVME_SC_INVALID_FIELD;
 	}
 
 	if (chap->hash_id == data->hashid && chap->shash_tfm &&
@@ -194,7 +194,7 @@ static int nvme_auth_process_dhchap_challenge(struct nvme_ctrl *ctrl,
 		crypto_free_shash(chap->shash_tfm);
 		chap->shash_tfm = NULL;
 		chap->status = NVME_AUTH_DHCHAP_FAILURE_HASH_UNUSABLE;
-		return NVME_SC_AUTH_REQUIRED;
+		return NVME_SC_DNR | NVME_SC_AUTH_REQUIRED;
 	}
 
 	/* Reset host response if the hash had been changed */
@@ -216,7 +216,7 @@ static int nvme_auth_process_dhchap_challenge(struct nvme_ctrl *ctrl,
 			 chap->qid, data->dhgid);
 		chap->status = NVME_AUTH_DHCHAP_FAILURE_DHGROUP_UNUSABLE;
 		/* Leave previous dh_tfm intact */
-		return NVME_SC_AUTH_REQUIRED;
+		return NVME_SC_DNR | NVME_SC_AUTH_REQUIRED;
 	}
 
 	/* Clear host and controller key to avoid accidental reuse */
@@ -247,7 +247,7 @@ static int nvme_auth_process_dhchap_challenge(struct nvme_ctrl *ctrl,
 				 "qid %d: empty DH value\n",
 				 chap->qid);
 			chap->status = NVME_AUTH_DHCHAP_FAILURE_DHGROUP_UNUSABLE;
-			return NVME_SC_INVALID_FIELD;
+			return NVME_SC_DNR | NVME_SC_INVALID_FIELD;
 		}
 
 		chap->dh_tfm = crypto_alloc_kpp(kpp_name, 0, 0);
@@ -268,7 +268,7 @@ static int nvme_auth_process_dhchap_challenge(struct nvme_ctrl *ctrl,
 			 "qid %d: invalid DH value for NULL DH\n",
 			 chap->qid);
 		chap->status = NVME_AUTH_DHCHAP_FAILURE_INCORRECT_PAYLOAD;
-		return NVME_SC_INVALID_FIELD;
+		return NVME_SC_DNR | NVME_SC_INVALID_FIELD;
 	}
 	chap->dhgroup_id = data->dhgid;
 
@@ -357,7 +357,7 @@ static int nvme_auth_process_dhchap_success1(struct nvme_ctrl *ctrl,
 			 "qid %d: invalid hash length %u\n",
 			 chap->qid, data->hl);
 		chap->status = NVME_AUTH_DHCHAP_FAILURE_HASH_UNUSABLE;
-		return NVME_SC_INVALID_FIELD;
+		return NVME_SC_DNR | NVME_SC_INVALID_FIELD;
 	}
 
 	/* Just print out information for the admin queue */
@@ -381,7 +381,7 @@ static int nvme_auth_process_dhchap_success1(struct nvme_ctrl *ctrl,
 			 "qid %d: controller authentication failed\n",
 			 chap->qid);
 		chap->status = NVME_AUTH_DHCHAP_FAILURE_FAILED;
-		return NVME_SC_AUTH_REQUIRED;
+		return NVME_SC_DNR | NVME_SC_AUTH_REQUIRED;
 	}
 
 	/* Just print out information for the admin queue */
@@ -733,7 +733,7 @@ static void __nvme_auth_work(struct work_struct *work)
 					 NVME_AUTH_DHCHAP_MESSAGE_CHALLENGE);
 	if (ret) {
 		chap->status = ret;
-		chap->error = NVME_SC_AUTH_REQUIRED;
+		chap->error = NVME_SC_DNR | NVME_SC_AUTH_REQUIRED;
 		return;
 	}
 
@@ -797,7 +797,7 @@ static void __nvme_auth_work(struct work_struct *work)
 					 NVME_AUTH_DHCHAP_MESSAGE_SUCCESS1);
 	if (ret) {
 		chap->status = ret;
-		chap->error = NVME_SC_AUTH_REQUIRED;
+		chap->error = NVME_SC_DNR | NVME_SC_AUTH_REQUIRED;
 		return;
 	}
 
@@ -815,7 +815,7 @@ static void __nvme_auth_work(struct work_struct *work)
 	ret = nvme_auth_process_dhchap_success1(ctrl, chap);
 	if (ret) {
 		/* Controller authentication failed */
-		chap->error = NVME_SC_AUTH_REQUIRED;
+		chap->error = ret;
 		goto fail2;
 	}
 
diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
index 83b505358859..633e5fe8e832 100644
--- a/drivers/nvme/host/fabrics.c
+++ b/drivers/nvme/host/fabrics.c
@@ -416,7 +416,7 @@ int nvmf_connect_admin_queue(struct nvme_ctrl *ctrl)
 		if (ret) {
 			dev_warn(ctrl->device,
 				 "qid 0: authentication setup failed\n");
-			ret = NVME_SC_AUTH_REQUIRED;
+			ret = NVME_SC_DNR | NVME_SC_AUTH_REQUIRED;
 			goto out_free_data;
 		}
 		ret = nvme_auth_wait(ctrl, 0);
@@ -492,7 +492,7 @@ int nvmf_connect_io_queue(struct nvme_ctrl *ctrl, u16 qid)
 		if (ret) {
 			dev_warn(ctrl->device,
 				 "qid %d: authentication setup failed\n", qid);
-			ret = NVME_SC_AUTH_REQUIRED;
+			ret = NVME_SC_DNR | NVME_SC_AUTH_REQUIRED;
 		} else {
 			ret = nvme_auth_wait(ctrl, qid);
 			if (ret)
-- 
2.35.3


