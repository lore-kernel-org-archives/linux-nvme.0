Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08DECCD8C9F
	for <linux-nvme@archiver.kernel.org>; Wed, 11 Oct 2023 08:45:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=x2nUGOzA90IadMHqOcCFazHYvGl83g0lQGxbqBMAidk=; b=rPFmodvxJyhw81prweRKmDxBzY
	jCRuaJDtQADmu3wWNAMs8u2T444agwX3YybS100MqtAAscZOyYYcCFLtifYEf45lAOwJ1IE27LDat
	zEnTBWcQ+wp13gnfUZANCzX8juC+tGQIhX8JChJtWzpIEPfdr+hhuhPVDQhqnAw6hnpmOpRW02eq5
	45PKwGZSUoKGm3CG0JHwGztlJdppnRt91/sGRDrQ2NQueOyNrUxzxQ/pHq017MhEie1Scplf+jtJ1
	nwfvob1DZz9TuQjvUeNxU3D10fRZptISVVOYgqWLbS+pEm/UmzlBXu+zcEV+0XwMbXyVOe7Eu3jKy
	qWigz31A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qqUqY-00FFsm-0v;
	Wed, 11 Oct 2023 08:45:38 +0000
Received: from mout01.posteo.de ([185.67.36.65])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qqUqU-00FFo8-2q
	for linux-nvme@lists.infradead.org;
	Wed, 11 Oct 2023 08:45:36 +0000
Received: from submission (posteo.de [185.67.36.169]) 
	by mout01.posteo.de (Postfix) with ESMTPS id 4AA71240028
	for <linux-nvme@lists.infradead.org>; Wed, 11 Oct 2023 10:45:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
	t=1697013928; bh=RGojVmI/xMEaWWuoMnRdbYay89Aw9vZzsbfx00TeLGM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:
	 Content-Transfer-Encoding:From;
	b=NS2SIyYDfWwCm1vbn1xUC9u1FY8J+OMWFxFraGRHfG5hLMUnPgRAGefHgDyU8gS8+
	 n02WKwA5nr4L1quo9a3cPzQsEQCZrwNtslIzLe3vxeZpju/WJswNGaWzWh6fusvspE
	 zddZBbAyFFYWG8MiSNcLHHJ8wSbwYbckcCwgm+pxY3L013zcsDY3DalI2j60uidqe9
	 rfNp2tWQa2BmsGMC3nbC+RIDxzegiPq22psCWnDfkBDtq5mCFVN5aQr17YDBCTwlZA
	 p3SGqhGN4UtIbVJ5cgq/kNSidyEECS2c11L+VTcIFnEafd6KoKAUe/zP2L6DFW7+zz
	 5ZUe3PaDzhA9w==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4S55v9353sz6tw0;
	Wed, 11 Oct 2023 10:45:25 +0200 (CEST)
From: Mark O'Donovan <shiftee@posteo.net>
To: linux-kernel@vger.kernel.org
Cc: linux-nvme@lists.infradead.org,
	sagi@grimberg.me,
	hch@lst.de,
	axboe@kernel.dk,
	kbusch@kernel.org,
	hare@suse.de,
	Mark O'Donovan <shiftee@posteo.net>
Subject: [PATCH 1/2 RESEND] nvme-auth: unlock mutex in one place only
Date: Wed, 11 Oct 2023 08:45:11 +0000
Message-Id: <20231011084512.1835614-1-shiftee@posteo.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231011_014535_068371_F8F2E2CA 
X-CRM114-Status: UNSURE (   8.26  )
X-CRM114-Notice: Please train this message.
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

Signed-off-by: Mark O'Donovan <shiftee@posteo.net>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Reviewed-by: Hannes Reinecke <hare@suse.de>
---
 drivers/nvme/host/auth.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/nvme/host/auth.c b/drivers/nvme/host/auth.c
index daf5d144a8ea..e1a98647c3a2 100644
--- a/drivers/nvme/host/auth.c
+++ b/drivers/nvme/host/auth.c
@@ -758,12 +758,11 @@ static void nvme_queue_auth_work(struct work_struct *work)
 		__func__, chap->qid);
 	mutex_lock(&ctrl->dhchap_auth_mutex);
 	ret = nvme_auth_dhchap_setup_host_response(ctrl, chap);
+	mutex_unlock(&ctrl->dhchap_auth_mutex);
 	if (ret) {
-		mutex_unlock(&ctrl->dhchap_auth_mutex);
 		chap->error = ret;
 		goto fail2;
 	}
-	mutex_unlock(&ctrl->dhchap_auth_mutex);
 
 	/* DH-HMAC-CHAP Step 3: send reply */
 	dev_dbg(ctrl->device, "%s: qid %d send reply\n",
-- 
2.39.2


