Return-Path: <SRS0=kiw1=GR=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CA54C433E6
	for <linux-nvme@archiver.kernel.org>; Thu, 14 Jan 2021 13:31:52 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6996723A55
	for <linux-nvme@archiver.kernel.org>; Thu, 14 Jan 2021 13:31:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6996723A55
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:References:In-Reply-To:Message-Id:Date:Subject:To:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ScdeME8PkMoTPVb1yorsBzeR+mLFc18RQ6HtsKdj/WI=; b=cLth7lQx859JwshJsTXkL3FDQp
	jzhQNYWCFrFQDnVUK/Jh02uYCrMlxgJ5Kp4Bvw47upMlUUg3wbsPQh/updJrEqRJcexmsNkn8Pt4C
	fRLTiG0k5K9VIlSsMeWMRq0BT0W5NJfVGbMAHQi8lkDsG6EfIiOEMTDumESTsd1SjjQLAXAFuQOuH
	XNUlAiQzigFqUG1O4KEayxe1m8OjHpN+BYvk1W5szV8ErBnnbCiEo335kH/RTo3iwJBC9gEfaBSMf
	unT6GvBJYPB1yiZCCZfoZO2FaRWohnBDB2XfYnjvTeRf20FFx/R+IBNTyM3p9ndzFvBJFUcTR6rVY
	TZXrh24A==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l02ir-0001Vd-5P; Thu, 14 Jan 2021 13:31:33 +0000
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l02im-0001TW-Th
 for linux-nvme@lists.infradead.org; Thu, 14 Jan 2021 13:31:29 +0000
Received: by mail-pj1-x1031.google.com with SMTP id w1so4631939pjc.0
 for <linux-nvme@lists.infradead.org>; Thu, 14 Jan 2021 05:31:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=abrmuriKeRQQNnC72wbPvfrPo7iP4ZN8oVMAJWoyhjg=;
 b=Eh5peuxPnS8z2HFmkxRdUlxvCBiM6wd8g5ONktzp+eViectNxQdpz0mNS/RP9x2XGj
 TJjdQJK8evKhSzI/9fl1ZQ1w4mFOLXwVxi7clNxXmAg0L1STNSj2VClh/WtJcBy3TMXP
 P6O2+VJy+15Ev2AKtlM7EWgYJSaXEGpHC27GD1DcyjDAK8ha5QwL7Gv2jju+geM6mnVP
 LrgL4LyC7zJzi0VrUUPSfMxxlNQmCNVIAiubewK5UCw4WjJoQT90DyaaUVgjBns2oEC5
 pgESogvE92WGptZd5vLM/rKkF8+go7xGbP8D571T4Cngd66ggOo6C9rltQSL54mSiy3v
 5xww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=abrmuriKeRQQNnC72wbPvfrPo7iP4ZN8oVMAJWoyhjg=;
 b=nPYYhXH42McFdi2uwYsg2TKiw8IyqEHh2MZdsRZJydpDjT/2pwMLxlugvI7lfufqpV
 CsHomGS8Jinzgdrg+cMIC9OK3nKoP40zsgsCO2xQ5flNpufMQw3IMPBWH9hIESHESFUl
 ZEzVR4m3Af3HeSYcVYDCnmverxe7KqpxPNev9QWZTEpD+CBMVuOYtk5nI56/zEC9I4pO
 ekuWBk2Op9Qt8DswPELCdhhEMKD/zQE7Xch2/OxtfuO6QrDNiBPYjVI1RVzCGPE+0OCo
 hBwMPaxR+iNmzd6yABp+RU6vNY57KyLDFnW+oJzajIg7esGWLyTutE3Gh90XrmUdFrw7
 ybnw==
X-Gm-Message-State: AOAM531SytB7hBvCXfPzzJ8EWO5bn8tfSn1U3iSKM09KnTZwW7xbSeIB
 dV0EYU2JiQaUrVn4qYXQRcTYNOwV+hgv5w==
X-Google-Smtp-Source: ABdhPJz6t8DD/6swnSOhBkWnXVQNM/C2cesHi+6Ih+I6zMj1x+UsJp7TM0DXLEWbqqnDLfKm4+ZhLQ==
X-Received: by 2002:a17:902:b203:b029:dc:973:3ad0 with SMTP id
 t3-20020a170902b203b02900dc09733ad0mr7543065plr.44.1610631086461; 
 Thu, 14 Jan 2021 05:31:26 -0800 (PST)
Received: from localhost.localdomain ([211.108.35.36])
 by smtp.gmail.com with ESMTPSA id gb9sm5549860pjb.40.2021.01.14.05.31.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Jan 2021 05:31:26 -0800 (PST)
From: Minwoo Im <minwoo.im.dev@gmail.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH V3 3/3] nvme: retry commands based on ACRE flag
Date: Thu, 14 Jan 2021 22:31:10 +0900
Message-Id: <20210114133110.20779-4-minwoo.im.dev@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210114133110.20779-1-minwoo.im.dev@gmail.com>
References: <20210114133110.20779-1-minwoo.im.dev@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210114_083129_052943_4CA02F5A 
X-CRM114-Status: GOOD (  15.99  )
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
Cc: Sagi Grimberg <sagi@grimberg.me>, Jens Axboe <axboe@fb.com>,
 Minwoo Im <minwoo.im.dev@gmail.com>, Chao Leng <lengchao@huawei.com>,
 Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Allow nvme_decide_disposition() to retry commands with error by checking
Advanced Command Retry Enable (ACRE) flag of controller first than
REQ_FAILFAST_* cmd_flags.  But, we just can't allow all command failures
to be retried due to reasons like connecting may take too long due to
the retries.  This patch only allows non-host path error commands to be
retried.

Cc: Chao Leng <lengchao@huawei.com>
Cc: Sagi Grimberg <sagi@grimberg.me>
Cc: Keith Busch <kbusch@kernel.org>
Signed-off-by: Minwoo Im <minwoo.im.dev@gmail.com>
---
 drivers/nvme/host/core.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index a286e3422c61..e4f7c49c2f39 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -303,8 +303,7 @@ static inline enum nvme_disposition nvme_decide_disposition(struct request *req)
 	if (likely(nvme_req(req)->status == 0))
 		return COMPLETE;
 
-	if (blk_noretry_request(req) ||
-	    (nvme_req(req)->status & NVME_SC_DNR) ||
+	if ((nvme_req(req)->status & NVME_SC_DNR) ||
 	    nvme_req(req)->retries >= nvme_max_retries)
 		return COMPLETE;
 
@@ -317,6 +316,13 @@ static inline enum nvme_disposition nvme_decide_disposition(struct request *req)
 			return COMPLETE;
 	}
 
+	if (nvme_req(req)->ctrl->acre &&
+	    !nvme_is_path_error(nvme_req(req)->status) &&
+	    !blk_queue_dying(req->q))
+		return RETRY;
+	else if (blk_noretry_request(req))
+		return COMPLETE;
+
 	return RETRY;
 }
 
-- 
2.17.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
