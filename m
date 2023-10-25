Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C495C0032E
	for <linux-nvme@archiver.kernel.org>; Wed, 25 Oct 2023 10:51:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ofbfEVVL4E62FvCq+MPrYUpLujp4AL1WHzfCF2qxQz0=; b=tku1DDp6rCXJkGgd7aXjL7RBCI
	MU5L8QNXhiVP32M8OZ7sQSQkY78SIwADODNQWRx5CD2hHIoehQfVQ5UmPN7d1L/VoK4fW5A42jO6x
	81WyMQanaHriArUFJb3eX5zK03xDjtYloJWz87HQ5UHC7d+9wETL6hoWMcQPFG5A7QO/9qiVTrLjG
	PKBOx2CJpEIO0ijzt/QkK1/UKzh4bmtaK976cM+cgNmsQ5g/X6y4kpzPoysBIUBCydGBG4D+gj0AE
	re27rukVjdvuy6LRTiB91D8fcKGNC1rZaQ+6EyRyKfdh0LRs/0JGlaWbU3Fpxs859/ECL5wVWZDyT
	N2I4ek1w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qvbUM-00C7Ka-30;
	Wed, 25 Oct 2023 10:51:50 +0000
Received: from mout02.posteo.de ([185.67.36.66])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qvbUG-00C7HU-0S
	for linux-nvme@lists.infradead.org;
	Wed, 25 Oct 2023 10:51:46 +0000
Received: from submission (posteo.de [185.67.36.169]) 
	by mout02.posteo.de (Postfix) with ESMTPS id BAAF5240105
	for <linux-nvme@lists.infradead.org>; Wed, 25 Oct 2023 12:51:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
	t=1698231099; bh=Todilzex7SY38WlYbvcVBDp8UXS6ZQgCTD4taXoUATI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:
	 Content-Transfer-Encoding:From;
	b=JGX6rTQ5l/c+IsLYz+Fd6acI09fZ+QEBh6zBkFTylzWg+7Fl6j15+JNAZp6OlMG23
	 s3oFVVd/G43XPTxGnbCTYHKyhfVab2CVTqr1i2FmAmzV0abFM2yLLgBNvZONgLOwUy
	 ONB4wPjvc6CLTJn30Kp12vuPQT4H6yUdYcqEuOdQRNVrnWqn2EG8c/Ti6p4f1n3COk
	 EauXS1ju/bKixX5MlKRJT3AUc5guC9OcFJk7aeEEOOyDwo/FL8JoO0+CVR28/Dw42+
	 HjXBplrM/J7qIGW9hG/hgpm/LpLt3wLvWTnZHa4eZxTcw9XV+i58FiHBGz5uFNc53Y
	 V6cel9BiM5AvQ==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4SFm2L1DMcz9rxN;
	Wed, 25 Oct 2023 12:51:38 +0200 (CEST)
From: Mark O'Donovan <shiftee@posteo.net>
To: linux-kernel@vger.kernel.org
Cc: linux-nvme@lists.infradead.org,
	sagi@grimberg.me,
	hch@lst.de,
	axboe@kernel.dk,
	kbusch@kernel.org,
	hare@suse.de,
	Mark O'Donovan <shiftee@posteo.net>
Subject: [PATCH v3 2/3] nvme-auth: add flag for bi-directional auth
Date: Wed, 25 Oct 2023 10:51:24 +0000
Message-Id: <20231025105125.134443-3-shiftee@posteo.net>
In-Reply-To: <20231025105125.134443-1-shiftee@posteo.net>
References: <20231025105125.134443-1-shiftee@posteo.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231025_035144_350190_39928951 
X-CRM114-Status: GOOD (  13.69  )
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

Introduces an explicit variable for bi-directional auth.
The currently used variable chap->s2 is incorrectly zeroed for
uni-directional auth. That will be fixed in the next patch so this
needs to change to avoid sending unexpected success2 messages

Signed-off-by: Mark O'Donovan <shiftee@posteo.net>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/host/auth.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/auth.c b/drivers/nvme/host/auth.c
index e0fc33d41baa..8558a02865ac 100644
--- a/drivers/nvme/host/auth.c
+++ b/drivers/nvme/host/auth.c
@@ -28,6 +28,7 @@ struct nvme_dhchap_queue_context {
 	int error;
 	u32 s1;
 	u32 s2;
+	bool bi_directional;
 	u16 transaction;
 	u8 status;
 	u8 dhgroup_id;
@@ -312,6 +313,7 @@ static int nvme_auth_set_dhchap_reply_data(struct nvme_ctrl *ctrl,
 	data->dhvlen = cpu_to_le16(chap->host_key_len);
 	memcpy(data->rval, chap->response, chap->hash_len);
 	if (ctrl->ctrl_key) {
+		chap->bi_directional = true;
 		get_random_bytes(chap->c2, chap->hash_len);
 		data->cvalid = 1;
 		chap->s2 = nvme_auth_get_seqnum();
@@ -660,6 +662,7 @@ static void nvme_auth_reset_dhchap(struct nvme_dhchap_queue_context *chap)
 	chap->error = 0;
 	chap->s1 = 0;
 	chap->s2 = 0;
+	chap->bi_directional = false;
 	chap->transaction = 0;
 	memset(chap->c1, 0, sizeof(chap->c1));
 	memset(chap->c2, 0, sizeof(chap->c2));
@@ -822,7 +825,7 @@ static void nvme_queue_auth_work(struct work_struct *work)
 		goto fail2;
 	}
 
-	if (chap->s2) {
+	if (chap->bi_directional) {
 		/* DH-HMAC-CHAP Step 5: send success2 */
 		dev_dbg(ctrl->device, "%s: qid %d send success2\n",
 			__func__, chap->qid);
-- 
2.39.2


