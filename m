Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67C94C4332F
	for <linux-nvme@archiver.kernel.org>; Wed,  2 Nov 2022 07:53:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=P+SMz+QIwpwtT0MLWlOo+1pXY1jnIaf51KPe82iifCU=; b=4AUfgvUZq7IM5eg4etE56QgZhJ
	UJWVGgyBe+8tVGxGDaIFVx2TjhOXi39M10XFOO8N7OObx13Tk1FchSrqf1smcGEHUeXWcrS5LOl7+
	P40Wdfm/Ebu+RIQETVbH8bk6wWX70sWGO1tPQucm3u+r6GQn9Jj0aXoUo5OQDaazrMXxZss6JuSXD
	k09q3C/nXS1ToXIpbYClOVp3MA6h+YaW26VSx5OtfAkTx8hY9EMVWAlhJi2LULtBr+lpjvv32Buuj
	qdAb0SL3WODoyPpdg7S83ElNpCSag2lPBTWpcMH7p2Eqk6frLHK81zB9R/y2tBFI97Y/RLcal5FhP
	fB+ghTmg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oq8YY-008glT-IZ; Wed, 02 Nov 2022 07:53:02 +0000
Received: from smtp-out1.suse.de ([2001:67c:2178:6::1c])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oq8Y5-008gVO-SF
	for linux-nvme@lists.infradead.org; Wed, 02 Nov 2022 07:52:36 +0000
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
	by smtp-out1.suse.de (Postfix) with ESMTP id 980F733974;
	Wed,  2 Nov 2022 07:52:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1667375547; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=P+SMz+QIwpwtT0MLWlOo+1pXY1jnIaf51KPe82iifCU=;
	b=pl2UX6mKOgRnkx+j6GrC8l5pUI4eaLl+LTyNSl3jswQkU3n7WXI06xiHebnohXXcGM2AY6
	1rdopsX/HPfTi8MitAqvZDs1hKTCf6LVlS4mD/8y2jzbBkU5d0OOY8dYyc42qiVSo2ulbb
	1Cmk7E9RuRxLcL4WEhSWwEcedzEts1c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1667375547;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=P+SMz+QIwpwtT0MLWlOo+1pXY1jnIaf51KPe82iifCU=;
	b=b+i/pALIPtPKVU9JcTjzOHN8JI16F2skiKMBWdIwUoWiUWwnHdXw7qcLbU8M/F7D3T9Y9L
	jBtbwja8q1mw2VAQ==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
	by relay2.suse.de (Postfix) with ESMTP id 8FB9B2C142;
	Wed,  2 Nov 2022 07:52:27 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
	id 8634F51AD6C3; Wed,  2 Nov 2022 08:52:27 +0100 (CET)
From: Hannes Reinecke <hare@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCH 1/6] nvme-auth: allocate authentication buffer only during transaction
Date: Wed,  2 Nov 2022 08:52:19 +0100
Message-Id: <20221102075224.70869-2-hare@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20221102075224.70869-1-hare@suse.de>
References: <20221102075224.70869-1-hare@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221102_005234_118730_7CD56F91 
X-CRM114-Status: GOOD (  16.45  )
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

The authentication buffer is only used during the authentication
transaction, so no need to keep it around.

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/nvme/host/auth.c | 49 +++++++++++++++++++---------------------
 1 file changed, 23 insertions(+), 26 deletions(-)

diff --git a/drivers/nvme/host/auth.c b/drivers/nvme/host/auth.c
index 3b63aa155beb..b68fb2c764f6 100644
--- a/drivers/nvme/host/auth.c
+++ b/drivers/nvme/host/auth.c
@@ -667,8 +667,6 @@ static void __nvme_auth_reset(struct nvme_dhchap_queue_context *chap)
 	kfree_sensitive(chap->sess_key);
 	chap->sess_key = NULL;
 	chap->sess_key_len = 0;
-	chap->status = 0;
-	chap->error = 0;
 	chap->s1 = 0;
 	chap->s2 = 0;
 	chap->transaction = 0;
@@ -687,7 +685,6 @@ static void __nvme_auth_free(struct nvme_dhchap_queue_context *chap)
 	kfree_sensitive(chap->host_key);
 	kfree_sensitive(chap->sess_key);
 	kfree_sensitive(chap->host_response);
-	kfree(chap->buf);
 	kfree(chap);
 }
 
@@ -700,6 +697,19 @@ static void __nvme_auth_work(struct work_struct *work)
 	int ret = 0;
 
 	chap->transaction = ctrl->transaction++;
+	chap->status = 0;
+	chap->error = 0;
+
+	/*
+	 * Allocate a large enough buffer for the entire negotiation:
+	 * 4k should be enough to ffdhe8192.
+	 */
+	chap->buf_size = 4096;
+	chap->buf = kzalloc(chap->buf_size, GFP_KERNEL);
+	if (!chap->buf) {
+		chap->error = -ENOMEM;
+		return;
+	}
 
 	/* DH-HMAC-CHAP Step 1: send negotiate */
 	dev_dbg(ctrl->device, "%s: qid %d send negotiate\n",
@@ -707,13 +717,13 @@ static void __nvme_auth_work(struct work_struct *work)
 	ret = nvme_auth_set_dhchap_negotiate_data(ctrl, chap);
 	if (ret < 0) {
 		chap->error = ret;
-		return;
+		goto out_free;
 	}
 	tl = ret;
 	ret = nvme_auth_submit(ctrl, chap->qid, chap->buf, tl, true);
 	if (ret) {
 		chap->error = ret;
-		return;
+		goto out_free;
 	}
 
 	/* DH-HMAC-CHAP Step 2: receive challenge */
@@ -727,14 +737,14 @@ static void __nvme_auth_work(struct work_struct *work)
 			 "qid %d failed to receive challenge, %s %d\n",
 			 chap->qid, ret < 0 ? "error" : "nvme status", ret);
 		chap->error = ret;
-		return;
+		goto out_free;
 	}
 	ret = nvme_auth_receive_validate(ctrl, chap->qid, chap->buf, chap->transaction,
 					 NVME_AUTH_DHCHAP_MESSAGE_CHALLENGE);
 	if (ret) {
 		chap->status = ret;
 		chap->error = NVME_SC_AUTH_REQUIRED;
-		return;
+		goto out_free;
 	}
 
 	ret = nvme_auth_process_dhchap_challenge(ctrl, chap);
@@ -790,7 +800,7 @@ static void __nvme_auth_work(struct work_struct *work)
 			 "qid %d failed to receive success1, %s %d\n",
 			 chap->qid, ret < 0 ? "error" : "nvme status", ret);
 		chap->error = ret;
-		return;
+		goto out_free;
 	}
 	ret = nvme_auth_receive_validate(ctrl, chap->qid,
 					 chap->buf, chap->transaction,
@@ -798,7 +808,7 @@ static void __nvme_auth_work(struct work_struct *work)
 	if (ret) {
 		chap->status = ret;
 		chap->error = NVME_SC_AUTH_REQUIRED;
-		return;
+		goto out_free;
 	}
 
 	if (ctrl->ctrl_key) {
@@ -828,10 +838,7 @@ static void __nvme_auth_work(struct work_struct *work)
 		if (ret)
 			chap->error = ret;
 	}
-	if (!ret) {
-		chap->error = 0;
-		return;
-	}
+	goto out_free;
 
 fail2:
 	dev_dbg(ctrl->device, "%s: qid %d send failure2, status %x\n",
@@ -844,6 +851,9 @@ static void __nvme_auth_work(struct work_struct *work)
 	 */
 	if (ret && !chap->error)
 		chap->error = ret;
+out_free:
+	kfree(chap->buf);
+	chap->buf = NULL;
 }
 
 int nvme_auth_negotiate(struct nvme_ctrl *ctrl, int qid)
@@ -863,7 +873,6 @@ int nvme_auth_negotiate(struct nvme_ctrl *ctrl, int qid)
 	mutex_lock(&ctrl->dhchap_auth_mutex);
 	/* Check if the context is already queued */
 	list_for_each_entry(chap, &ctrl->dhchap_auth_list, entry) {
-		WARN_ON(!chap->buf);
 		if (chap->qid == qid) {
 			dev_dbg(ctrl->device, "qid %d: re-using context\n", qid);
 			mutex_unlock(&ctrl->dhchap_auth_mutex);
@@ -881,18 +890,6 @@ int nvme_auth_negotiate(struct nvme_ctrl *ctrl, int qid)
 	chap->qid = (qid == NVME_QID_ANY) ? 0 : qid;
 	chap->ctrl = ctrl;
 
-	/*
-	 * Allocate a large enough buffer for the entire negotiation:
-	 * 4k should be enough to ffdhe8192.
-	 */
-	chap->buf_size = 4096;
-	chap->buf = kzalloc(chap->buf_size, GFP_KERNEL);
-	if (!chap->buf) {
-		mutex_unlock(&ctrl->dhchap_auth_mutex);
-		kfree(chap);
-		return -ENOMEM;
-	}
-
 	INIT_WORK(&chap->auth_work, __nvme_auth_work);
 	list_add(&chap->entry, &ctrl->dhchap_auth_list);
 	mutex_unlock(&ctrl->dhchap_auth_mutex);
-- 
2.35.3


