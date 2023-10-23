Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E170C004C0
	for <linux-nvme@archiver.kernel.org>; Mon, 23 Oct 2023 14:00:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=QnAjvfjWFnCpRxuxioGHpQr5KpcVIkWFE2DSEbIq2A4=; b=hkMAgk39SUGrSE0xrx3TWbP3Oo
	xxSLYVSW0qf2eIc/FiUD9icy3EqgxHoTG6pqzXY8x7GUpvDyqgVtsGq8k7x/h9vrQJMnqFfB+88oL
	d4IYIsSsTCV5L+rDaM4UhsZO5qdV/ZqEH3f49KmzsFI7G5y8F4Rc+tImO+htM7Ha6+jWM64y1Wl76
	iM7vp5Kd12rD23rTHv6Lf49hKKzqtKn6eE33fl37zYQxmntv5boPf2cvW7T9k/043sbg2YjcV0L09
	VsDbhJElXXUAjbjCqn/vnUhkVF5klnUMOhBA9L8jJ4VrB85LY499AKds/strIoTtFP/34ZB+j3nt3
	w24hWtUQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1quvTm-007UdI-00;
	Mon, 23 Oct 2023 14:00:26 +0000
Received: from mout01.posteo.de ([185.67.36.65])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1quvTg-007Ub0-1z
	for linux-nvme@lists.infradead.org;
	Mon, 23 Oct 2023 14:00:21 +0000
Received: from submission (posteo.de [185.67.36.169]) 
	by mout01.posteo.de (Postfix) with ESMTPS id 6756C24002D
	for <linux-nvme@lists.infradead.org>; Mon, 23 Oct 2023 16:00:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
	t=1698069615; bh=Fig6sNGtNPtLEqdibiKwrPwhe4ldPvHG+L+Zwf6xQc0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:
	 Content-Transfer-Encoding:From;
	b=qpGm7DQ7F5jjomuPr+/Fq4TA4UceNKtt5zNG8KACUt/gWWCQh5ca7oRofj833f3ns
	 1HcLzNJTLA36h4OiLeGfZrMxFSS1JrGY/EM4Hom0Y93KKvUANBnV+B8AlZYG0/Nyq7
	 R6bAdpqL6ZfKMCbQhsj3RUkaFR6M/q+B/lKgFElW/AkZ/W6uPvp/CA1BGxG9hpLfpG
	 c2JHS8QGRKILvD5891iRTr37j8dE0OoihV0den5o1fu1xVbBpZ2RGG1GeFzRiI3p2m
	 5s1cg8cGfKOKfCh2mke5k0YJ6cMdeawc8rq3XHZc55qgeoqU6ExdQ4OJOA9uJALo/7
	 BA+8zCZTEQ2Iw==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4SDcJt0HvNz6tsB;
	Mon, 23 Oct 2023 16:00:13 +0200 (CEST)
From: Mark O'Donovan <shiftee@posteo.net>
To: linux-kernel@vger.kernel.org
Cc: linux-nvme@lists.infradead.org,
	sagi@grimberg.me,
	hch@lst.de,
	axboe@kernel.dk,
	kbusch@kernel.org,
	hare@suse.de,
	Mark O'Donovan <shiftee@posteo.net>
Subject: [PATCH v2 1/3] nvme-auth: auth success1 msg always includes resp
Date: Mon, 23 Oct 2023 14:00:01 +0000
Message-Id: <20231023140003.58019-2-shiftee@posteo.net>
In-Reply-To: <20231023140003.58019-1-shiftee@posteo.net>
References: <20231023140003.58019-1-shiftee@posteo.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231023_070020_803633_09AB41CB 
X-CRM114-Status: GOOD (  12.79  )
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

In cases where RVALID is false, the response is still transmitted,
but is cleared to zero.

Relevant extract from the spec:
Response R2, if valid (i.e., if the RVALID field is set to 01h),
cleared to 0h otherwise

Signed-off-by: Mark O'Donovan <shiftee@posteo.net>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

---
v1: used incorrect prefix nvme-tcp
v2: rebase on latest git

 drivers/nvme/host/auth.c | 5 +----
 include/linux/nvme.h     | 2 +-
 2 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/nvme/host/auth.c b/drivers/nvme/host/auth.c
index 064592a5d546..e0fc33d41baa 100644
--- a/drivers/nvme/host/auth.c
+++ b/drivers/nvme/host/auth.c
@@ -339,10 +339,7 @@ static int nvme_auth_process_dhchap_success1(struct nvme_ctrl *ctrl,
 		struct nvme_dhchap_queue_context *chap)
 {
 	struct nvmf_auth_dhchap_success1_data *data = chap->buf;
-	size_t size = sizeof(*data);
-
-	if (chap->s2)
-		size += chap->hash_len;
+	size_t size = sizeof(*data) + chap->hash_len;
 
 	if (size > CHAP_BUF_SIZE) {
 		chap->status = NVME_AUTH_DHCHAP_FAILURE_INCORRECT_PAYLOAD;
diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index 26dd3f859d9d..8d8df9c15b74 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -1722,7 +1722,7 @@ struct nvmf_auth_dhchap_success1_data {
 	__u8		rsvd2;
 	__u8		rvalid;
 	__u8		rsvd3[7];
-	/* 'hl' bytes of response value if 'rvalid' is set */
+	/* 'hl' bytes of response value */
 	__u8		rval[];
 };
 
-- 
2.39.2


