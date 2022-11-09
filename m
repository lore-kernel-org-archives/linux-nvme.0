Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3145C433FE
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Nov 2022 03:45:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=CyLUl5CXa8Zp+z7zCS4gLjck9PgW++EZOpzfwDj6Kzk=; b=Ba7KF1zdXi1FbCPW/N3xSxZNbX
	q4KxN/ugoEJ/56EoNjbp/lobbpTDQCBKPugJRanuUCI/f1gIQsfB41M8zyK6zJlHrjFIIHS4CtKg0
	8EUx8lQzMWLsUeiRVjInYIh2ow46td5DwpJL6EldxuU1ih6YalM4uQy/w1MvqjbbBLCg6xfBltTGm
	fGjdf2aG7jIXY/85Ulg8U+n1xBB1mqURxiiICuk7CX38BF1FVX5M0sV3tP2fdhjnRI4wn2RJaDJe3
	t5GxqX37Recjyi1cieQjyobwYYiMO/qmRuQe2Qm5dO3zP40Po9txku6yy8dklvxdZRI4WTbMm3GYx
	oNSNBmzA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1osc25-00AOqX-Rw; Wed, 09 Nov 2022 03:45:45 +0000
Received: from mail-pl1-f174.google.com ([209.85.214.174])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1osc0w-00AOLi-RB
	for linux-nvme@lists.infradead.org; Wed, 09 Nov 2022 03:44:36 +0000
Received: by mail-pl1-f174.google.com with SMTP id g24so15956005plq.3
        for <linux-nvme@lists.infradead.org>; Tue, 08 Nov 2022 19:44:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CyLUl5CXa8Zp+z7zCS4gLjck9PgW++EZOpzfwDj6Kzk=;
        b=6OpoqDCUVsMlmkXgnkpHrgvekJY1hckMEhOuD6afAjr+xOMkeHKr5GnTV5YwEGutQK
         JRES2Rg6KhtCRO4PLmau7CIMx/CRsp5NvVc1SkCEJVB5JzzrulJVOuOr2+g1mqyIB+uT
         ThO3gd4kui+hNackDa9GvbrwWVD+sFD/Z3pIOFaAS49mX/VuYxbjqVVxSsyNQSyDOCuu
         7P29eUgmHuyZ6ztlFrN6/sxEMUVae/S9uneNKdMJWKHadcZUk0vJee0TdB5O9a4s72DR
         uYplnXlkdoxvrtm2Zrz5ahEYOQBv3c2Xw7CySDSxgggyNawrSypkiZ+K734C/p0DTwio
         Pd9Q==
X-Gm-Message-State: ACrzQf13u0s3OLHwJmO2kWZjU11Ke8V7C9p3lWrwyOpbLI44czyAFZk6
	XK5HWZfC2ZBasy7B21J60iGGa+x282AtwBNE
X-Google-Smtp-Source: AMsMyM7Mnoqr5O1uvGV8OSxkaaIGZ6LeObRLtEDhqZ784eXMPyS/EmfVNbbFnt/R6FHWpRHhwTT5Kw==
X-Received: by 2002:a17:903:1c9:b0:186:91ce:1658 with SMTP id e9-20020a17090301c900b0018691ce1658mr58861460plh.122.1667965473695;
        Tue, 08 Nov 2022 19:44:33 -0800 (PST)
Received: from localhost.localdomain (69-170-33-158.static-ip.telepacific.net. [69.170.33.158])
        by smtp.gmail.com with ESMTPSA id i10-20020a17090332ca00b00186cd4a8aedsm7765612plr.252.2022.11.08.19.44.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Nov 2022 19:44:33 -0800 (PST)
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-nvme@lists.infradead.org
Cc: Christoph Hellwig <hch@lst.de>,
	Hannes Reinecke <hare@suse.de>,
	Keith Busch <kbusch@kernel.org>,
	Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Subject: [PATCH 08/16] nvme-auth: don't keep long lived 4k dhchap buffer
Date: Wed,  9 Nov 2022 05:44:11 +0200
Message-Id: <20221109034420.1000086-9-sagi@grimberg.me>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221109034420.1000086-1-sagi@grimberg.me>
References: <20221109034420.1000086-1-sagi@grimberg.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221108_194434_892762_37EA40AA 
X-CRM114-Status: GOOD (  15.41  )
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

dhchap structure is per-queue, it is wasteful to keep it for the entire
lifetime of the queue. Allocate it dynamically and get rid of it after
authentication. We don't need kzalloc because all accessors are clearing
it before writing to it.

Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/host/auth.c | 27 +++++++++++++--------------
 1 file changed, 13 insertions(+), 14 deletions(-)

diff --git a/drivers/nvme/host/auth.c b/drivers/nvme/host/auth.c
index 07d497f49e4b..201f25267685 100644
--- a/drivers/nvme/host/auth.c
+++ b/drivers/nvme/host/auth.c
@@ -674,6 +674,8 @@ static void nvme_auth_reset_dhchap(struct nvme_dhchap_queue_context *chap)
 	chap->transaction = 0;
 	memset(chap->c1, 0, sizeof(chap->c1));
 	memset(chap->c2, 0, sizeof(chap->c2));
+	kfree(chap->buf);
+	chap->buf = NULL;
 }
 
 static void nvme_auth_free_dhchap(struct nvme_dhchap_queue_context *chap)
@@ -683,7 +685,6 @@ static void nvme_auth_free_dhchap(struct nvme_dhchap_queue_context *chap)
 		crypto_free_shash(chap->shash_tfm);
 	if (chap->dh_tfm)
 		crypto_free_kpp(chap->dh_tfm);
-	kfree(chap->buf);
 	kfree(chap);
 }
 
@@ -695,6 +696,17 @@ static void __nvme_auth_work(struct work_struct *work)
 	size_t tl;
 	int ret = 0;
 
+	/*
+	 * Allocate a large enough buffer for the entire negotiation:
+	 * 4k should be enough to ffdhe8192.
+	 */
+	chap->buf_size = 4096;
+	chap->buf = kmalloc(chap->buf_size, GFP_KERNEL);
+	if (!chap->buf) {
+		chap->error = -ENOMEM;
+		return;
+	}
+
 	chap->transaction = ctrl->transaction++;
 
 	/* DH-HMAC-CHAP Step 1: send negotiate */
@@ -876,19 +888,6 @@ int nvme_auth_negotiate(struct nvme_ctrl *ctrl, int qid)
 	}
 	chap->qid = qid;
 	chap->ctrl = ctrl;
-
-	/*
-	 * Allocate a large enough buffer for the entire negotiation:
-	 * 4k should be enough to ffdhe8192.
-	 */
-	chap->buf_size = 4096;
-	chap->buf = kzalloc(chap->buf_size, GFP_KERNEL);
-	if (!chap->buf) {
-		mutex_unlock(&ctrl->dhchap_auth_mutex);
-		kfree(chap);
-		return -ENOMEM;
-	}
-
 	INIT_WORK(&chap->auth_work, __nvme_auth_work);
 	list_add(&chap->entry, &ctrl->dhchap_auth_list);
 	mutex_unlock(&ctrl->dhchap_auth_mutex);
-- 
2.34.1


