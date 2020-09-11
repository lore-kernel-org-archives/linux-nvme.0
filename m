Return-Path: <SRS0=9POq=CU=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6AEAC433E2
	for <linux-nvme@archiver.kernel.org>; Fri, 11 Sep 2020 20:03:14 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 80E6721D79
	for <linux-nvme@archiver.kernel.org>; Fri, 11 Sep 2020 20:03:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="A4iq+Oxb";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="SPgIfqSE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80E6721D79
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=wATscMD537MKqZaGa1uVw/DzC87I1/FRcCkZlTPyYVQ=; b=A4iq+OxbMEn7UyzkUw81gZKf5r
	dhHjvmL7eaalnkhUEQaWslH9XHlr3LakRTjDiwAecdDCg2lDrMs7r+sQki61uQtmfxPeFqHKNVb0l
	sxs0XFBRxHrF3Opm+SbUs65bxRcwb0pixWXVqhfamUUIbEaJTxC1WDjP62HDnBB59mWLaJjylVeaJ
	sOGccj+oARebm7pnqWv/vNaelfU7nFsvwqc8bbDAJY0+SQJBB9cPfHGE/9zwlD5iGtjFAXYplQkAJ
	22uGpdJz8c+7q7l8r+jvSPe6+MLXtUCIXuMkqLvcM1XIdGN+CKfEf3UVNfRCE+HmyOsSe3Xh+KZGE
	Prv1Sz6g==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kGpGF-0005SG-W3; Fri, 11 Sep 2020 20:03:08 +0000
Received: from mail-pj1-x1041.google.com ([2607:f8b0:4864:20::1041])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kGpGD-0005Rq-9J
 for linux-nvme@lists.infradead.org; Fri, 11 Sep 2020 20:03:06 +0000
Received: by mail-pj1-x1041.google.com with SMTP id t7so2225849pjd.3
 for <linux-nvme@lists.infradead.org>; Fri, 11 Sep 2020 13:03:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=broadcom.com; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=mTLqe3uMrdC6QyuFy1CGVzk/6PlchkqT05rhzvCHRUc=;
 b=SPgIfqSEMfdVIs2BPeGZpe4HSCAKufLLlOcdg/4h8qT+B0ojkkrGjJLYHlJgaw5J7G
 JRFVQZ9YTWgyNXzDtwt1TaB90oWOz16n5hnjcr9IHacum78HGZ4Vci1eDTEw2pHKICBL
 xGZOudManwQEQtxqvcFaVBLFSuLaYuZNK9g9c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=mTLqe3uMrdC6QyuFy1CGVzk/6PlchkqT05rhzvCHRUc=;
 b=gkMNfMlJyRqivHE8PiYI346v9cjOISSGSf2/2SYdiI9zOjnDtVF+wtnDjZ9rMApSIu
 LuN5YSzCyDmui9cLtSIk0e2SzTBh9oasOGguS4OsLh6OCFMwzbZMMJYl2Igtx7WFv85a
 pUMvPsydxC7O+MEDylC0bQtxVBJpvheAnjtWUATi9f8Qrf7m45w32IqarU5XIJ6J935r
 1+Tn5DHxJQBjjscf2toTrKEIVO4a7BYTSA4WeYagUKNximqij97Ezt5LZmRI4YFZCUco
 r6NBEpl6PoyTuaACC3qfq3DPoikq8zfLwyr54//Sk9U6IFdIJvD906g3sPXQao0q+XNb
 vtrg==
X-Gm-Message-State: AOAM53034SbIaUDGy1q5jiGGoXrsSp14BQ03XFRva8C4fXOHZKC3HfYZ
 9hKnYXVR0vyVzvy/xOxUdAROejgWjvW17Iitq78yYD03Nt+ZbRWH6olY1G7V+JkElSKr29UyQ9v
 nJUFYe0N5AV+13vitmGxJWFI9xHWNxE9O5nb/YUjEfaJRS9cq3ajUMTdueFmuXM+MQfJqEK/Ubd
 7g+B9C72Sjbr0=
X-Google-Smtp-Source: ABdhPJw+fKIYnPim7x6sk+cI7wcx5jvJx8yDBx0A6gLJ1Wkr13S3DiTr61766KOGCLeeTxRJfOmTUQ==
X-Received: by 2002:a17:902:b205:b029:d0:92cc:a8e1 with SMTP id
 t5-20020a170902b205b02900d092cca8e1mr3886405plr.17.1599854580321; 
 Fri, 11 Sep 2020 13:03:00 -0700 (PDT)
Received: from localhost.localdomain ([192.19.223.252])
 by smtp.gmail.com with ESMTPSA id r15sm2645182pgg.17.2020.09.11.13.02.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Sep 2020 13:02:59 -0700 (PDT)
From: James Smart <james.smart@broadcom.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH] nvme-fc: soften messages logged by error_recovery
Date: Fri, 11 Sep 2020 13:02:54 -0700
Message-Id: <20200911200254.111005-1-james.smart@broadcom.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200911_160305_325961_224A1D6C 
X-CRM114-Status: GOOD (  13.58  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: James Smart <james.smart@broadcom.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Several of the messages logged vi nvme_fc_error_recovery() come across
as rather strong events due to the use of the word "error". This is
causing some interpretations to be overly worried.

Soften the wording of the messages.

Signed-off-by: James Smart <james.smart@broadcom.com>
---
 drivers/nvme/host/fc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index e8ef42b9d50c..bc4e1af587cc 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -2433,7 +2433,7 @@ nvme_fc_error_recovery(struct nvme_fc_ctrl *ctrl, char *errmsg)
 		return;
 
 	dev_warn(ctrl->ctrl.device,
-		"NVME-FC{%d}: transport association error detected: %s\n",
+		"NVME-FC{%d}: transport association event: %s\n",
 		ctrl->cnum, errmsg);
 	dev_warn(ctrl->ctrl.device,
 		"NVME-FC{%d}: resetting controller\n", ctrl->cnum);
@@ -2454,7 +2454,7 @@ nvme_fc_timeout(struct request *rq, bool reserved)
 	 * the host/io stack, terminate the association on the link,
 	 * and recreate an association on the link.
 	 */
-	nvme_fc_error_recovery(ctrl, "io timeout error");
+	nvme_fc_error_recovery(ctrl, "io timeout");
 
 	/*
 	 * the io abort has been initiated. Have the reset timer
-- 
2.26.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
