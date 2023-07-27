Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D546C0015E
	for <linux-nvme@archiver.kernel.org>; Thu, 27 Jul 2023 13:58:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=wJHPqyoHtiQksRg5iRHZydgfRAjfBsbfV0NVzNon1EE=; b=kTEmp5ZjTYMrqn2+gLk1UyElk9
	5FBILeQTM9dnGGjLjU/t+O0J7CnRHrHoaJ+8Ap8m4Z4oAOQ10mDGHzUy441eevhRAvIZPZx5EXzPr
	ZB1vUgRa+0wcWgGKIX7LIAI3xq9+CiQkGwtmN2dD5v8uiC9oWtBVRnNqaDj4dzOKa9Y2MWEmSwlq2
	NS9tZ875y/0glfVOZVKkJEBTh1b8OrOfR5GJIJgyrWJwwyijKUCpwzxBRlTYLqoXTD77J/bxUXsy9
	flAphYFgqqWjx/VjMZkcKaeYCGt6FN0OWM2v+chpKElvfkuiyhj8ZLQwaMvoMz+Ou1/+aQh3nBnrg
	AANPD0Vw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qP1VT-00Eqp8-15;
	Thu, 27 Jul 2023 13:58:19 +0000
Received: from mout01.posteo.de ([185.67.36.65])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qP1VP-00EqhU-0E
	for linux-nvme@lists.infradead.org;
	Thu, 27 Jul 2023 13:58:16 +0000
Received: from submission (posteo.de [185.67.36.169]) 
	by mout01.posteo.de (Postfix) with ESMTPS id 6A14E240028
	for <linux-nvme@lists.infradead.org>; Thu, 27 Jul 2023 15:58:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
	t=1690466288; bh=AQUkhOUuCll+t4Bc33a3LEsUOgQSYv/ROCYEwaxRzJg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:
	 Content-Transfer-Encoding:From;
	b=NgurT1C7XBvYhQ3qrz42iZliwB209Aa+zA44atRSwjitC+UnGdlzbUHkGSwBKre0Y
	 3EuGFYf8MmGut0d7BxxT/YhTp5S97tEmAjdu8YmGIPrwBHn61ESfOJ8h2fhUCX7Izm
	 4kZpl39Z5xpTP274HwG2uBA6Bgf6TFj26rYJiMGiRAqJ7WnyV+x8ysrDPeg+6UqdDi
	 WgrDoPvNC+5jUyKhlYPJIikbFUL+eypUqKV/DRaCrjYXR6SGpIYm3BBB9KfLVzyWgC
	 6AAYQ1slOAUwb5RvNjjXCltFRdAqNetW+VEEd5VDdXHuT8RWgGdK6x7MNf1XvA3InU
	 cYIkGZV0j5Zfw==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4RBXR15gqpz6tsb;
	Thu, 27 Jul 2023 15:58:05 +0200 (CEST)
From: Mark O'Donovan <shiftee@posteo.net>
To: linux-kernel@vger.kernel.org
Cc: linux-nvme@lists.infradead.org,
	sagi@grimberg.me,
	hch@lst.de,
	axboe@kernel.dk,
	kbusch@kernel.org,
	hare@suse.de,
	Mark O'Donovan <shiftee@posteo.net>
Subject: [PATCH 1/2] nvme-auth: unlock mutex in one place only
Date: Thu, 27 Jul 2023 13:47:47 +0000
Message-Id: <20230727134748.4163796-1-shiftee@posteo.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230727_065815_274045_8D104706 
X-CRM114-Status: UNSURE (   7.56  )
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


