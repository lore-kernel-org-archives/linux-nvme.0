Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82050C83F12
	for <linux-nvme@archiver.kernel.org>; Mon, 28 Aug 2023 21:29:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=XRc2z06IQ0xX0hd3NlyW8/D+DBZ6AWXltpZVDscuFZ8=; b=dSajsiOhNdzwVGbT2xNfsJJO9L
	DvnjyQVFfXOxhzV8FfybUOZsB1xQ7fOc23rOjUWzPCxyjjBJDwJ6GcykSdBs0DoiKir3AP3ONZjcc
	cWp9y6o/sxI5mFQgDNvv6C5jaBLfWwqJohQmpinnmClLvGClmhWC7jsEavBU4cEdKbLaXkrGz1khw
	w5cCV4LW9VIFvVZwDyY2kePPc4Nhf6ltoKIUyUg1oD58uIaS6UURpXDGvKZgKSEBPIVkgIYBcYiYm
	mrUvV9WVstCmouC8UAeFItwPxurWKarGsnLIenGxPZs7b7qiT3cFnAIgbOkHW/8Wd8VBGUFQKDbmd
	jGEgrisw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qajnn-00AJHB-1A;
	Mon, 28 Aug 2023 21:29:39 +0000
Received: from mout02.posteo.de ([185.67.36.66])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qajnj-00AJGQ-39
	for linux-nvme@lists.infradead.org;
	Mon, 28 Aug 2023 21:29:37 +0000
Received: from submission (posteo.de [185.67.36.169]) 
	by mout02.posteo.de (Postfix) with ESMTPS id 39AB2240105
	for <linux-nvme@lists.infradead.org>; Mon, 28 Aug 2023 23:29:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
	t=1693258170; bh=Fbrv6/1iFxoYEdTeMNow9HZyGp6d2072/70AjKQfGu8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:
	 Content-Transfer-Encoding:From;
	b=gHnzD2jfa5EwKk0y8cVO0HUbZfLPgkpwpzU39zpHW1RmNfcv08q1QP6qyx7dFwAm/
	 tOORthrr1vRWGRGERUlLlji0p323UEvY12eQALd/FKSxw0An+4LruXTZ+yIo7stE6m
	 I9V9rt3vyhCUQgdJ2UYFeU3c8t/GvzrK6Hmk/R2sx5wl+wwRGgv84tX+lrv81ypBLk
	 0v8fGcWocxJFkOOK1oYFbHFg87vFtN5ZftUz588nUdvj78Lt1wQamSB1c4wB/UsaNl
	 L/fjgs9mRF2zy+SRvZ6L2LGtbiHxXbPuEUb1zgUG/EK4bNxCtqxivTyg2jjdYaf5KZ
	 fSjCIFm/sfBGA==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4RZNwv0SkDz9s0P;
	Mon, 28 Aug 2023 23:29:18 +0200 (CEST)
From: Mark O'Donovan <shiftee@posteo.net>
To: linux-kernel@vger.kernel.org
Cc: linux-nvme@lists.infradead.org,
	sagi@grimberg.me,
	hch@lst.de,
	axboe@kernel.dk,
	kbusch@kernel.org,
	hare@suse.de,
	Mark O'Donovan <shiftee@posteo.net>
Subject: [PATCH 1/2] nvme-tcp: auth success1 msg always includes resp
Date: Mon, 28 Aug 2023 21:20:32 +0000
Message-Id: <20230828212033.3244512-1-shiftee@posteo.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230828_142936_211122_60EEBE4A 
X-CRM114-Status: GOOD (  11.67  )
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
---
 drivers/nvme/host/auth.c | 5 +----
 include/linux/nvme.h     | 2 +-
 2 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/nvme/host/auth.c b/drivers/nvme/host/auth.c
index daf5d144a8ea..49f8c46bddf1 100644
--- a/drivers/nvme/host/auth.c
+++ b/drivers/nvme/host/auth.c
@@ -339,10 +339,7 @@ static int nvme_auth_process_dhchap_success1(struct nvme_ctrl *ctrl,
 		struct nvme_dhchap_queue_context *chap)
 {
 	struct nvmf_auth_dhchap_success1_data *data = chap->buf;
-	size_t size = sizeof(*data);
-
-	if (chap->ctrl_key)
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


