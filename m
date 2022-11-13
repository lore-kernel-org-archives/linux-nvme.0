Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 349B7C433FE
	for <linux-nvme@archiver.kernel.org>; Sun, 13 Nov 2022 11:27:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2ehMuDlgR2CY/hMcCMEEbnRlGAl6gpxYXNI7sVp1nDQ=; b=G9In9sCVjUoGblAy9DGaF57P/m
	Tr1rRg+upiMsaEEtKigHDr+GRj1btjkIWmm0f2aRdIWOLB3I9KJ0Y1kZiN0cI5hr3XKFz+/ShFaRl
	ReNUClugCSElhDLQacTxA4eRW2iAIGDHm8z6QCUXTPzn94HCknCFVkuTcGH+Z3uCVmI30xmlgJ9AA
	tYz+vBCIU3UDKZwpevbnaiqKINGEifV5DHvg1qWPLMwLNfx+XbVtIQCYSBU/OTURsqpFe7+7IvSch
	2tYIO72knZmPYkCecsjkCAm+8bil6pbpamsF2YpMdEEIcd587BkLmGoL+sTYHUmiSrTE5LZT+QDYW
	4mejmxyQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ouB98-00B7dq-FY; Sun, 13 Nov 2022 11:27:30 +0000
Received: from mail-wr1-f41.google.com ([209.85.221.41])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ouB6S-00B6Nc-G1
	for linux-nvme@lists.infradead.org; Sun, 13 Nov 2022 11:24:45 +0000
Received: by mail-wr1-f41.google.com with SMTP id w14so12381289wru.8
        for <linux-nvme@lists.infradead.org>; Sun, 13 Nov 2022 03:24:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2ehMuDlgR2CY/hMcCMEEbnRlGAl6gpxYXNI7sVp1nDQ=;
        b=fH3um7WzZn/10H3UqY5w07BWsx5O2PyiRcbH1pNJKyrVwQPQps/6x62HMlhrZLx/ZF
         ldCtuioiE6ZrCk7wg6W86wLWiKCCilueixfWFrXtf3CUxfOZC5dxvoPOiOzTQT0oe3Q0
         Ei6Tn1d80z5lUGtCGl3MsYE4yKELbH1qzRQSc/0AiWVAjH3lFajEKqYd+UxbvJfv4ACr
         E9GKZ3ggatBJXXZ1ADAR3znQkOoxz7MWgK0/ijLo19gNMWQ1D1CgCl2dGEdOHQ9/yxxV
         n3vkNN7wQ3X4L6/gDzfFdMVcAOx9f2wcSrDhrcnfX2AS2xF5PdzbBdr4bE/U94P0NjdP
         JFHQ==
X-Gm-Message-State: ANoB5pkIt4j9YcvbTfpnyxz91mnj2EQEd8fXziOWejDBYHgt3KbK6rSt
	TAod1hdOilsWvDtC9OTfqUI6P15nFB4=
X-Google-Smtp-Source: AA0mqf79lqjs2OtoXGVEBCAPveXqgwz+F64z+HufUL36U7Ts4LasPKAdnaDu3bgIzf0LlWdWyE0Yhw==
X-Received: by 2002:adf:d84b:0:b0:236:c65e:dcbd with SMTP id k11-20020adfd84b000000b00236c65edcbdmr5281238wrl.62.1668338683715;
        Sun, 13 Nov 2022 03:24:43 -0800 (PST)
Received: from localhost.localdomain (46-116-236-159.bb.netvision.net.il. [46.116.236.159])
        by smtp.gmail.com with ESMTPSA id p1-20020a1c5441000000b003b4868eb71bsm14318393wmi.25.2022.11.13.03.24.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Nov 2022 03:24:43 -0800 (PST)
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-nvme@lists.infradead.org
Cc: Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCH v2 14/20] nvme-auth: check chap ctrl_key once constructed
Date: Sun, 13 Nov 2022 13:24:18 +0200
Message-Id: <20221113112424.1049834-15-sagi@grimberg.me>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221113112424.1049834-1-sagi@grimberg.me>
References: <20221113112424.1049834-1-sagi@grimberg.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221113_032444_556210_EEF4633F 
X-CRM114-Status: GOOD (  14.38  )
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

ctrl ctrl_key member may be overwritten from a sysfs context driven
by the user. Once a queue local copy was created, use that instead
to minimize checks on a shared resource.

Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/host/auth.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/auth.c b/drivers/nvme/host/auth.c
index a502e159e14e..2bcb33c83534 100644
--- a/drivers/nvme/host/auth.c
+++ b/drivers/nvme/host/auth.c
@@ -333,7 +333,7 @@ static int nvme_auth_process_dhchap_success1(struct nvme_ctrl *ctrl,
 	struct nvmf_auth_dhchap_success1_data *data = chap->buf;
 	size_t size = sizeof(*data);
 
-	if (ctrl->ctrl_key)
+	if (chap->ctrl_key)
 		size += chap->hash_len;
 
 	if (CHAP_BUF_SIZE < size) {
@@ -809,7 +809,7 @@ static void nvme_queue_auth_work(struct work_struct *work)
 		goto fail2;
 	}
 
-	if (ctrl->ctrl_key) {
+	if (chap->ctrl_key) {
 		/* DH-HMAC-CHAP Step 5: send success2 */
 		dev_dbg(ctrl->device, "%s: qid %d send success2\n",
 			__func__, chap->qid);
-- 
2.34.1


