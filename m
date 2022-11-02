Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A43AC4332F
	for <linux-nvme@archiver.kernel.org>; Wed,  2 Nov 2022 07:52:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Z2WaX/L/MjeHA8jxtcn+0bdji8JCg/v51nAWbr4DWZU=; b=so5TOYS7Eore/1eHPjnJnZ/RF8
	6UhyP3y9clcD123M76vYdo2wn40xlsGvCrdHDUpQZ5s++FNj1ipob8iL22PvytKC6ifUMkPYvX8YK
	mVh7thkRIjufHson63zeeUKsVF/sUUgO2hu4Fgq1rdaYjqPZfv+TAky83cvUiYGe2cCnR0X6Xl4nG
	8fF05JBd53k9PwzE438L/68ewc6lHu/OUp6ov/lxHqrlUlEwsc+ydJQOGjNWkata+GnjaWqDni/II
	d3Xtxb/pMEdsBOAyP4ory9ncljYG/h8vgAc3CsHB2KB44RRhk1Iz99gip9YRQ5NNEygloMKWcu43o
	v92xIbeA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oq8Y3-008gWu-LD; Wed, 02 Nov 2022 07:52:31 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oq8Y1-008gVV-4A
	for linux-nvme@lists.infradead.org; Wed, 02 Nov 2022 07:52:30 +0000
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
	by smtp-out2.suse.de (Postfix) with ESMTP id BB87A1F90D;
	Wed,  2 Nov 2022 07:52:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1667375547; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Z2WaX/L/MjeHA8jxtcn+0bdji8JCg/v51nAWbr4DWZU=;
	b=y2aFsqo3HMd1pEEXxXfieZigHF9cxcfalo7As3mFjhNg9yh7NHzS6cnNdYw7rU/Isg8n4q
	4ZLyUikjR6yNNhIFa1s0Ijd+CbQy+giX/eN0TxaEW+hb37MZSiIvVtjImWrVGoarMcJjSm
	AyTvUMg07o6Eck7Tf/RXn3y5UtCTfc0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1667375547;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Z2WaX/L/MjeHA8jxtcn+0bdji8JCg/v51nAWbr4DWZU=;
	b=cYTDdPSl9leL+nj6OLqUhzRtXEtG0Rl1K42e54ls/1bfnhBpMJTuidCH+dk9eogIRmyP48
	LDV0zDBk08rB9fAg==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
	by relay2.suse.de (Postfix) with ESMTP id B60602C14B;
	Wed,  2 Nov 2022 07:52:27 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
	id B165851AD6CD; Wed,  2 Nov 2022 08:52:27 +0100 (CET)
From: Hannes Reinecke <hare@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCH 6/6] nvme-auth: use a define for chap buffer size
Date: Wed,  2 Nov 2022 08:52:24 +0100
Message-Id: <20221102075224.70869-7-hare@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20221102075224.70869-1-hare@suse.de>
References: <20221102075224.70869-1-hare@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221102_005229_373560_6BDF19BE 
X-CRM114-Status: GOOD (  15.75  )
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

The chap buffer size is pretty much static, so we can make it
a define and save the variable.

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/nvme/host/auth.c | 25 ++++++++++++-------------
 1 file changed, 12 insertions(+), 13 deletions(-)

diff --git a/drivers/nvme/host/auth.c b/drivers/nvme/host/auth.c
index 6ca0c2bb06c0..444f56399ffc 100644
--- a/drivers/nvme/host/auth.c
+++ b/drivers/nvme/host/auth.c
@@ -13,6 +13,8 @@
 #include "fabrics.h"
 #include <linux/nvme-auth.h>
 
+#define CHAP_BUF_SIZE 4096
+
 struct nvme_dhchap_queue_context {
 	struct list_head entry;
 	struct work_struct auth_work;
@@ -20,7 +22,6 @@ struct nvme_dhchap_queue_context {
 	struct crypto_shash *shash_tfm;
 	struct crypto_kpp *dh_tfm;
 	void *buf;
-	size_t buf_size;
 	int qid;
 	int error;
 	u32 s1;
@@ -114,7 +115,7 @@ static int nvme_auth_set_dhchap_negotiate_data(struct nvme_ctrl *ctrl,
 	struct nvmf_auth_dhchap_negotiate_data *data = chap->buf;
 	size_t size = sizeof(*data) + sizeof(union nvmf_auth_protocol);
 
-	if (chap->buf_size < size) {
+	if (CHAP_BUF_SIZE < size) {
 		chap->status = NVME_AUTH_DHCHAP_FAILURE_INCORRECT_PAYLOAD;
 		return -EINVAL;
 	}
@@ -149,7 +150,7 @@ static int nvme_auth_process_dhchap_challenge(struct nvme_ctrl *ctrl,
 	const char *gid_name = nvme_auth_dhgroup_name(data->dhgid);
 	const char *hmac_name, *kpp_name;
 
-	if (chap->buf_size < size) {
+	if (CHAP_BUF_SIZE < size) {
 		chap->status = NVME_AUTH_DHCHAP_FAILURE_INCORRECT_PAYLOAD;
 		return NVME_SC_DNR | NVME_SC_INVALID_FIELD;
 	}
@@ -306,7 +307,7 @@ static int nvme_auth_set_dhchap_reply_data(struct nvme_ctrl *ctrl,
 	if (chap->host_key_len)
 		size += chap->host_key_len;
 
-	if (chap->buf_size < size) {
+	if (CHAP_BUF_SIZE < size) {
 		chap->status = NVME_AUTH_DHCHAP_FAILURE_INCORRECT_PAYLOAD;
 		return -EINVAL;
 	}
@@ -351,7 +352,7 @@ static int nvme_auth_process_dhchap_success1(struct nvme_ctrl *ctrl,
 	if (ctrl->ctrl_key)
 		size += chap->hash_len;
 
-	if (chap->buf_size < size) {
+	if (CHAP_BUF_SIZE < size) {
 		chap->status = NVME_AUTH_DHCHAP_FAILURE_INCORRECT_PAYLOAD;
 		return NVME_SC_DNR | NVME_SC_INVALID_FIELD;
 	}
@@ -711,11 +712,9 @@ static void __nvme_auth_work(struct work_struct *work)
 	chap->error = 0;
 
 	/*
-	 * Allocate a large enough buffer for the entire negotiation:
-	 * 4k should be enough to ffdhe8192.
+	 * Allocate a buffer large enough for the entire negotiation
 	 */
-	chap->buf_size = 4096;
-	chap->buf = kzalloc(chap->buf_size, GFP_KERNEL);
+	chap->buf = kzalloc(CHAP_BUF_SIZE, GFP_KERNEL);
 	if (!chap->buf) {
 		chap->error = -ENOMEM;
 		return;
@@ -740,8 +739,8 @@ static void __nvme_auth_work(struct work_struct *work)
 	dev_dbg(ctrl->device, "%s: qid %d receive challenge\n",
 		__func__, chap->qid);
 
-	memset(chap->buf, 0, chap->buf_size);
-	ret = nvme_auth_submit(ctrl, chap->qid, chap->buf, chap->buf_size, false);
+	memset(chap->buf, 0, CHAP_BUF_SIZE);
+	ret = nvme_auth_submit(ctrl, chap->qid, chap->buf, CHAP_BUF_SIZE, false);
 	if (ret) {
 		dev_warn(ctrl->device,
 			 "qid %d failed to receive challenge, %s %d\n",
@@ -803,8 +802,8 @@ static void __nvme_auth_work(struct work_struct *work)
 	dev_dbg(ctrl->device, "%s: qid %d receive success1\n",
 		__func__, chap->qid);
 
-	memset(chap->buf, 0, chap->buf_size);
-	ret = nvme_auth_submit(ctrl, chap->qid, chap->buf, chap->buf_size, false);
+	memset(chap->buf, 0, CHAP_BUF_SIZE);
+	ret = nvme_auth_submit(ctrl, chap->qid, chap->buf, CHAP_BUF_SIZE, false);
 	if (ret) {
 		dev_warn(ctrl->device,
 			 "qid %d failed to receive success1, %s %d\n",
-- 
2.35.3


