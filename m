Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14A22C5DF8C
	for <linux-nvme@archiver.kernel.org>; Sun, 23 Aug 2026 08:49:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:Cc:To:From:Content-Type:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vDYc6QP9sfuhxwYPcjWahD2JEJo/me+15SGsQqAVp+s=; b=JcBJ8/dv3Zc2etWko0C5a0ujOY
	lgDouOMoAtmBPda/VmjHip4qu9/XsLiOiUf6RYuYuIrLahp1thVgHRpWozYoJwj3GtohtcEVs79lW
	UkqLD/g/z54iFPHjMiB6UQ2glGYg+w+lu3RBPFo6wVwUB0N1arCeinjJGWPyVC1dkWTEu3cdB0K/T
	Rebf0pKQcW4fqd0ejEZLRab67V16l4aB3bf6cSaOAdpM6y9NYsM4F3OndDNV6hteCc1mHJJX6cI4Q
	4mxZm6NWItW2aclCkVGahVhx0wIR5F3FxHRTVbnc/2LZFyr2gMSBpYloYUY0yrZYQR+cTDzKCrijS
	3Be4NnrQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wy3tM-0000000FBbr-31kZ;
	Sun, 23 Aug 2026 08:49:24 +0000
Received: from mail-ej1-f50.google.com ([209.85.218.50])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wy3tF-0000000FBWY-2ArR
	for linux-nvme@lists.infradead.org;
	Sun, 23 Aug 2026 08:49:20 +0000
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-c1600d040e4so371445466b.1
        for <linux-nvme@lists.infradead.org>; Sun, 23 Aug 2026 01:49:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787474955; x=1788079755;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vDYc6QP9sfuhxwYPcjWahD2JEJo/me+15SGsQqAVp+s=;
        b=KOM6PpajxVBayzTygFFLBgqTtjy1cHN2vfgE6TiZzhYWP7dWNFQfwHMrfQGTdj07gP
         XV7CkVLt+/CoOuXTP6HqJ3WyD1Ybm0pkNw84f1heWEPC5ick/xbJmcrFvEGW51yQBm1g
         vdtWjhU+9EkxWQySLu6Mw8yRF9WXkwmTVjGjRvdV/aVoTmRtUMc6Vb1N9fvUAkhgEU7W
         yNZ4Ez+OHnJ+qdFSRSmvmEGGDbkwY7wO3NMUMBQAoLbxY9+whnl06g2wgp4PCQo+R3MQ
         45LsGaIeAeHL6+A9sUwbd5ZMm/7w2KQogMr0LktMvxR48J37LcMn8wvsw4ByluYtS5GO
         ZEpQ==
X-Gm-Message-State: AFuF++ntYx61ZLJHkTyUcYDIygmWU8SkT41HFy707+AI1rGCB7B+01R3
	nLheUCOO1hG4Q3BqdplAV+YmA5yIyMM7Q7H716EEgbSvcWPnebBUJR76/hMI1Q==
X-Gm-Gg: AR+sD12lXa33BjUZOOeLK1p2Yms/JuGcqV+IeEikwKLWb1uiHE9z81A6FvUB0ULh3nF
	qpPQPcCze5m/Q1LL+GWtubT/FGZmLoRENJa1q5UX/ntWokvxInzLrlmF1H81UP2LLdws3BJ0JtL
	fwhMgBBO3ihkrcvV8MqSSGLquFwHqjrFEX7xvE8GmYS5Pqh/qNETWFU0q25DGDjeAdWJnpWalsE
	m2UH8CWejMzDSfW3FYtuqqAeu7JDG3Nu44SDGlBl8lSYr8zvbnXNrdqiodsjCQ6063BQfwnEF8g
	kI4ZNODElNIFnMGVb/OFdYTnl0w8/EcUUU6Z50gIk34Nd1S64ocjPd5iQMLS+0mN3UnaGh6zK8C
	XV7Rqe4C4wNwnkFAsf3sHnhWKm93u8LeFPwJ0XxiqXrZ1w/T2dBWcvXeuAq1qH472rx5h5MtpqY
	wt0VBa8JP8vgCHimzwbPXoK7Qm6S80joJyVLJ2NMMd4nbycG7Z3h6NHwFmLvyw2kKFVw+/KLV6e
	d36bXkNbFyx5kO4NEuM8myARdQRzPqRag/fzPqm2FMGg3VneKQ=
X-Received: by 2002:a17:907:ea8a:b0:c21:3c4e:cb9d with SMTP id a640c23a62f3a-c244d7e3862mr2123709066b.14.1787474955533;
        Sun, 23 Aug 2026 01:49:15 -0700 (PDT)
Received: from vastdata-ubuntu2.vastdata.com (bzq-84-110-32-226.static-ip.bezeqint.net. [84.110.32.226])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a59e00129fsm2566761a12.1.2026.08.23.01.49.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Aug 2026 01:49:15 -0700 (PDT)
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-nvme@lists.infradead.org,
	Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Chaitanya Kulkarni <kch@nvidia.com>
Cc: Daniel Wagner <dwagner@suse.de>,
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCH 6/6] nvme/fault-injection: Support for error injection with custom crd
Date: Sun, 23 Aug 2026 11:49:02 +0300
Message-ID: <20260823084903.193188-7-sagi@grimberg.me>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260823084903.193188-1-sagi@grimberg.me>
References: <20260823084903.193188-1-sagi@grimberg.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260823_014918_962169_86AF08DE 
X-CRM114-Status: GOOD (  12.96  )
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
Reply-To: sagi@grimberg.me
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

This assumes that the controller exposed crdt[1,2,3] that are actually
meaningful in order to have make difference.

Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/host/fault_inject.c | 8 ++++++--
 drivers/nvme/host/nvme.h         | 1 +
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/fault_inject.c b/drivers/nvme/host/fault_inject.c
index 105d6cb41c72..98363fc6dde7 100644
--- a/drivers/nvme/host/fault_inject.c
+++ b/drivers/nvme/host/fault_inject.c
@@ -42,11 +42,13 @@ void nvme_fault_inject_init(struct nvme_fault_inject *fault_inj,
 	}
 	fault_inj->parent = parent;
 
-	/* create debugfs for status code and dont_retry */
+	/* create debugfs for status code, dont_retry and crd */
 	fault_inj->status = NVME_SC_INVALID_OPCODE;
 	fault_inj->dont_retry = true;
+	fault_inj->crd = 0;
 	debugfs_create_x16("status", 0600, dir,	&fault_inj->status);
 	debugfs_create_bool("dont_retry", 0600, dir, &fault_inj->dont_retry);
+	debugfs_create_u8("crd", 0600, dir, &fault_inj->crd);
 }
 
 void nvme_fault_inject_fini(struct nvme_fault_inject *fault_inject)
@@ -73,10 +75,12 @@ void nvme_should_fail(struct request *req)
 	}
 
 	if (fault_inject && should_fail(&fault_inject->attr, 1)) {
-		/* inject status code and DNR bit */
+		/* inject status code, optional DNR and CRD */
 		status = fault_inject->status;
 		if (fault_inject->dont_retry)
 			status |= NVME_STATUS_DNR;
+		if (fault_inject->crd && fault_inject->crd <= 3)
+			status |= (fault_inject->crd << 11) & NVME_STATUS_CRD;
 		nvme_req(req)->status =	status;
 	}
 }
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index e63f21b3110c..9aa0fc5e473a 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -318,6 +318,7 @@ struct nvme_fault_inject {
 	struct fault_attr attr;
 	struct dentry *parent;
 	bool dont_retry;	/* DNR, do not retry */
+	u8 crd;			/* Command Retry Delay (0-3) */
 	u16 status;		/* status code */
 #endif
 };
-- 
2.43.0


