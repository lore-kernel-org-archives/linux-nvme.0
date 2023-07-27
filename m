Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5BECC001E0
	for <linux-nvme@archiver.kernel.org>; Thu, 27 Jul 2023 13:58:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=a3JqXahHu0shDXE+GkcO+YOLNEhc9HOLT6Dsw+IT9us=; b=sjb4wsswXRsYYSUqyEpO7DQ3dg
	AsgCZ50bphjJnMRs37vT8+0oyHSquDQCPinPccZSUrEhf4w6WNFv3ghbb9bZovk6d5sr1PayZG6e2
	Q8ClqKkGhotBorhVt8CItgGINLUCa6v76lsViCLeAdLUXep1Gd0UyL95ZQ4DxPKT0iTvvGvGS99hU
	77ZsiP5cRSArKCSWTn4EBphr/zAtTS8tLD4FGPRTd6ScufC1EEkRep25IUgDzHWoJ+kSfNdLxvqC3
	OsPSFx/ZNeVBv6mFmnuZhCWzvVdWon8kSX8eW0QEEQmyiT+sgcU4U723RSnUotUdeautV0P3VaVMc
	8Lv4tmDA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qP1VU-00Eqq9-1D;
	Thu, 27 Jul 2023 13:58:20 +0000
Received: from mout02.posteo.de ([185.67.36.66])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qP1VO-00Eqi9-1T
	for linux-nvme@lists.infradead.org;
	Thu, 27 Jul 2023 13:58:16 +0000
Received: from submission (posteo.de [185.67.36.169]) 
	by mout02.posteo.de (Postfix) with ESMTPS id 7ED80240104
	for <linux-nvme@lists.infradead.org>; Thu, 27 Jul 2023 15:58:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
	t=1690466289; bh=wuGCYUOgNBYqBLJZagw6Q9jgYZ2fW49Hn985P9qL1/U=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:
	 Content-Transfer-Encoding:From;
	b=VjnduoM4Lo9OwAGhAxXxq1WBSTYlsn0t42BlVk4L/TQrbLlNvd7umePMyaO/LHrrr
	 1zQtyKVCvbA9JENcQ6ijtirpexaI30l1Q/KYhAZ8cgdzxpTXpssGhKNw0Ds5bsC9Qh
	 Rqt+Xbj6e/XMAntbPMxUHNh+8G8Uefv1yH4QA9TlE3vEmuNb80KZpH884TDwAFUq/T
	 kV6PGEaDHEFSdaxfNjdMDD/ErasGm/gFhQxVu/5abTuwuZeppOO08l9tF1Sqe9qiQm
	 qrAfBIGlohq9sGM9rkES+3pRNyt/AT0vyxKuW4e7w64oPd4yyvwiUtL9AozGnyDFQV
	 r+s06kQlOVNSA==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4RBXR31sK4z6txb;
	Thu, 27 Jul 2023 15:58:07 +0200 (CEST)
From: Mark O'Donovan <shiftee@posteo.net>
To: linux-kernel@vger.kernel.org
Cc: linux-nvme@lists.infradead.org,
	sagi@grimberg.me,
	hch@lst.de,
	axboe@kernel.dk,
	kbusch@kernel.org,
	hare@suse.de,
	Mark O'Donovan <shiftee@posteo.net>
Subject: [PATCH 2/2] nvme-auth: set explanation code for failure2 msgs
Date: Thu, 27 Jul 2023 13:47:48 +0000
Message-Id: <20230727134748.4163796-2-shiftee@posteo.net>
In-Reply-To: <20230727134748.4163796-1-shiftee@posteo.net>
References: <20230727134748.4163796-1-shiftee@posteo.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230727_065814_668802_B743C928 
X-CRM114-Status: GOOD (  10.24  )
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

These error cases were not setting an auth-failure-reason-code-explanation.
This means an AUTH_Failure2 message will be sent with an explanation value
of 0 which is a reserved value.

Signed-off-by: Mark O'Donovan <shiftee@posteo.net>
---
 drivers/nvme/host/auth.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/auth.c b/drivers/nvme/host/auth.c
index e1a98647c3a2..094f37e11921 100644
--- a/drivers/nvme/host/auth.c
+++ b/drivers/nvme/host/auth.c
@@ -760,6 +760,7 @@ static void nvme_queue_auth_work(struct work_struct *work)
 	ret = nvme_auth_dhchap_setup_host_response(ctrl, chap);
 	mutex_unlock(&ctrl->dhchap_auth_mutex);
 	if (ret) {
+		chap->status = NVME_AUTH_DHCHAP_FAILURE_FAILED;
 		chap->error = ret;
 		goto fail2;
 	}
@@ -776,6 +777,7 @@ static void nvme_queue_auth_work(struct work_struct *work)
 	tl = ret;
 	ret = nvme_auth_submit(ctrl, chap->qid, chap->buf, tl, true);
 	if (ret) {
+		chap->status = NVME_AUTH_DHCHAP_FAILURE_FAILED;
 		chap->error = ret;
 		goto fail2;
 	}
@@ -811,6 +813,7 @@ static void nvme_queue_auth_work(struct work_struct *work)
 		ret = nvme_auth_dhchap_setup_ctrl_response(ctrl, chap);
 		if (ret) {
 			mutex_unlock(&ctrl->dhchap_auth_mutex);
+			chap->status = NVME_AUTH_DHCHAP_FAILURE_FAILED;
 			chap->error = ret;
 			goto fail2;
 		}
@@ -830,8 +833,10 @@ static void nvme_queue_auth_work(struct work_struct *work)
 			__func__, chap->qid);
 		tl = nvme_auth_set_dhchap_success2_data(ctrl, chap);
 		ret = nvme_auth_submit(ctrl, chap->qid, chap->buf, tl, true);
-		if (ret)
+		if (ret) {
+			chap->status = NVME_AUTH_DHCHAP_FAILURE_FAILED;
 			chap->error = ret;
+		}
 	}
 	if (!ret) {
 		chap->error = 0;
-- 
2.39.2


