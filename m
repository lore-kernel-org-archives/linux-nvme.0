Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBC39C0032E
	for <linux-nvme@archiver.kernel.org>; Wed, 25 Oct 2023 10:51:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=GjqLB3n/3wM9GLzr63LISYPuPKRe45txi1u/PioJ9As=; b=e5HEnv40CkzIhoxX0JpUE+bXVY
	8rYDH7SmlW4tpU+4RyR09vItUtT550U74XAPtua8gY1D/FSoquX0/Z4LamlFNlEG8mf4VOEZV9Y6t
	sQHiy7qBkzhA65SYZfgkG81gwARZW3dYGGiWFmd5vKdmV35l2iSmNeA2L/cccXUgFu0FkdJfOd3Fr
	/yS2WoejIcjSUHGml2JxotOT6b9M0qdV1lSnd2+Z22o2IEFj8T+W+QX/TzsU2/qOktUw0i0GKnngl
	ifk3xuKa4Ug2kn6P3ai9C6IpWdzm+9uXXbi+Rz1iMm/7jHQNLhX2efEc6nREo+MJfrRXL2Q0Ix/0d
	11lR2gfQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qvbUI-00C7JP-2S;
	Wed, 25 Oct 2023 10:51:46 +0000
Received: from mout02.posteo.de ([185.67.36.66])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qvbUF-00C7HS-39
	for linux-nvme@lists.infradead.org;
	Wed, 25 Oct 2023 10:51:45 +0000
Received: from submission (posteo.de [185.67.36.169]) 
	by mout02.posteo.de (Postfix) with ESMTPS id 811DC240103
	for <linux-nvme@lists.infradead.org>; Wed, 25 Oct 2023 12:51:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
	t=1698231098; bh=jTnT/chsOtzfuw6NmZuyV4Fm9a93YfuqFYlLWZRZY3Q=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:
	 Content-Transfer-Encoding:From;
	b=fzzKsHIsQKX/JSmLFfIJeoRn8YWtpU7rmdb4t43E50CthymzErREjllwxUr7GDapJ
	 L1O5yv8kPfS1KCMDdfvOLNeCmiYnabQ69zM3uHpF2MAxMPWO4/KGmBMcV08n1z6c1H
	 E5CytkHMvHIXBBiq8eu5zExYkJZsciwAczgZsCfe6ccS2yxeJE4iLJ+JtxqeDvWJYB
	 LLGOJPQxXHl7IIbY5bR+/PuwpQ/W2CMfm29BnkgfnPgJ0H6Raib5xTAxommQpy7H2u
	 yY6bTq1sCK2iGyUf57eP9v0XYKBdXUqj3qdJsUEBwLLvfBWejwR+29PKdyGb6/N902
	 9jfmsaRsqLZfA==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4SFm2J70n8z9rxH;
	Wed, 25 Oct 2023 12:51:36 +0200 (CEST)
From: Mark O'Donovan <shiftee@posteo.net>
To: linux-kernel@vger.kernel.org
Cc: linux-nvme@lists.infradead.org,
	sagi@grimberg.me,
	hch@lst.de,
	axboe@kernel.dk,
	kbusch@kernel.org,
	hare@suse.de,
	Mark O'Donovan <shiftee@posteo.net>
Subject: [PATCH v3 1/3] nvme-auth: auth success1 msg always includes resp
Date: Wed, 25 Oct 2023 10:51:23 +0000
Message-Id: <20231025105125.134443-2-shiftee@posteo.net>
In-Reply-To: <20231025105125.134443-1-shiftee@posteo.net>
References: <20231025105125.134443-1-shiftee@posteo.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231025_035144_158995_AF781E23 
X-CRM114-Status: GOOD (  13.97  )
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
Reviewed-by: Christoph Hellwig <hch@lst.de>

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


