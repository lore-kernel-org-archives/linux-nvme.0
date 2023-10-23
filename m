Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99383C001E0
	for <linux-nvme@archiver.kernel.org>; Mon, 23 Oct 2023 14:00:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=XqA07HvUvcOA+3RenJOMQ9GBsQotLcUylVbTXtqnn4w=; b=cU8qNsON3w7uZprmPhFfHN5SLn
	YUOTK726Oc38wTfpO/w2/00+lHsnN4rXiISDQyYW0RG5MLTIiETR5SQBIu0p20xJhrdNN1rRjv7G8
	/00MWa1sinhYV8kuRaqi5i/9uTn+uLlup9L/yQqrFUjQ1T8aP7uI9SaszhRfqnfj6sw6spUkuEq3H
	xgVbnzMutxvxPy5BR1cuJiHTGDK/xAcadGzXbOrpk9cO92f3h7e6llgTgV8T5rsoNlbn5NQO96myY
	87A2g+0hEhLvsEvA5HRdzlw7T7zF0iGYtZIheahXykTsTHehKM9RvidrgOWd6DCaZSIVVTWqqBXLW
	hB8KmRfw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1quvTm-007UdW-25;
	Mon, 23 Oct 2023 14:00:26 +0000
Received: from mout01.posteo.de ([185.67.36.65])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1quvTg-007Ub5-1q
	for linux-nvme@lists.infradead.org;
	Mon, 23 Oct 2023 14:00:22 +0000
Received: from submission (posteo.de [185.67.36.169]) 
	by mout01.posteo.de (Postfix) with ESMTPS id DF80A240029
	for <linux-nvme@lists.infradead.org>; Mon, 23 Oct 2023 16:00:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
	t=1698069616; bh=0vrbnyHS0xkur/iRrIzIOiA16As3+vBu5X3xM21fRts=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:
	 Content-Transfer-Encoding:From;
	b=Jp4DwJ0n/3HJyx1M1Cy4sqSqnwAeHCRGXdighjLLYWiMVt2CW01aYRTixUJYKY85s
	 beLaZwHZRUJmncMUIpKY527kFUCsBa3Zg1dmjMHrLYzUnLd+wh0peRc13tTrbmRomV
	 1iacZUce7jT2Bmjq7JDv+H+578cTqy9SWs2FIT7V9+KK3DGX9BAITFsmK2hxr9xrXL
	 5zP6GFxRgdUmvlKoS+y9aee8pDZ9Nz4ySMvWKKN4ELGwQhZ0jvnL+M/cpHADRboeTM
	 PJ5KbxdUHz4xJ0ugSYeds2sycm84Y11kcs3SDij0gIt/d10JgRH71Yz2bQfW4vxMhl
	 46Mr0pEXMJHAw==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4SDcJv279xz6txG;
	Mon, 23 Oct 2023 16:00:15 +0200 (CEST)
From: Mark O'Donovan <shiftee@posteo.net>
To: linux-kernel@vger.kernel.org
Cc: linux-nvme@lists.infradead.org,
	sagi@grimberg.me,
	hch@lst.de,
	axboe@kernel.dk,
	kbusch@kernel.org,
	hare@suse.de,
	Mark O'Donovan <shiftee@posteo.net>
Subject: [PATCH v2 2/3] nvme-auth: add flag for bi-directional auth
Date: Mon, 23 Oct 2023 14:00:02 +0000
Message-Id: <20231023140003.58019-3-shiftee@posteo.net>
In-Reply-To: <20231023140003.58019-1-shiftee@posteo.net>
References: <20231023140003.58019-1-shiftee@posteo.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231023_070020_781034_E63071C8 
X-CRM114-Status: GOOD (  12.75  )
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


