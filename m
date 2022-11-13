Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAB7EC4332F
	for <linux-nvme@archiver.kernel.org>; Sun, 13 Nov 2022 11:25:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zXRivWJrqsRiKTm3RHD6Aq6IDrCj6qAFkMIyfFEBKRo=; b=pbwSgUlVZVmauCGuT6WBjjISg/
	4C1AFmhJqUdth+U3f2IJLVPJUdI2KLVl10ah4r292/GATBp5izCGXVreukS13U5u7EW6qtwVJsb7Q
	N+nzgPqjKNpWn3wCyhzrejJHvzxHhBoSiSrcCM+0A2nDDiHI6bQI76MjIVBqUUEi3N3UXm6sPbWWh
	0imwBKp3ILf2+pj3pNr083gmghuFVz5F703QhGYtismDgwRVLYzSU+uRuqc5C0x9wg3+btB0nSiFH
	FIvFGjqx3tIbz7s7k42IqdSaYZ/MqllZOg8xMIuGf70ZT3ki0wBi8pwr/AvjMpEQR50TNIPRgygdj
	JLe0y0AQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ouB6z-00B6iz-Jx; Sun, 13 Nov 2022 11:25:17 +0000
Received: from mail-wr1-f47.google.com ([209.85.221.47])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ouB6M-00B6PR-Ao
	for linux-nvme@lists.infradead.org; Sun, 13 Nov 2022 11:24:39 +0000
Received: by mail-wr1-f47.google.com with SMTP id j15so12421339wrq.3
        for <linux-nvme@lists.infradead.org>; Sun, 13 Nov 2022 03:24:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zXRivWJrqsRiKTm3RHD6Aq6IDrCj6qAFkMIyfFEBKRo=;
        b=SFFRo8Ti0CZz7md/R9bduHX63eJoZzDiyV3dz78S0wENhVjeQH9Ys8TTnElasEHaHC
         EZL5LybCu12EZsp57HcOF3A1zaXIs/iCdqqWaFwI1AH7xbItVYVu76JTEUslanCfQ/Zp
         pK++8Y4Zd6KUaW/PQ8KXzQ+STMnmsk0DkEvM4VFZR/ZcxFXK3hKGrTlBz4KfIBU7AUYB
         XH6hKO79KdFjYv0TpP9Vba9HhSKU7ZzN8xpQRXFfhTtbYOl05OoXsYNq4LUeNCUeWcVW
         kw2Q1wwyAesreraZ6oRyamWk5WTGpU4ZVhu09PavF+3g/d3fR9SoWegfIC0u8AnuZK+E
         t/qQ==
X-Gm-Message-State: ANoB5plozxdpcnnIhFc/WvFjChrQUS3FDTyi2IvcsrP19l5xUKK1Ajif
	fbh0rcotf9OIPi10OpS4QrvI8gatdL4=
X-Google-Smtp-Source: AA0mqf7Xnm3uDokjk5t4NEm0xj+Bz9tXL3DQhxNE3EmKrKaam+xOKi1/rdiE79dMuYPaHCjF44dqow==
X-Received: by 2002:a5d:5270:0:b0:238:3d85:8e2c with SMTP id l16-20020a5d5270000000b002383d858e2cmr5275145wrc.650.1668338676371;
        Sun, 13 Nov 2022 03:24:36 -0800 (PST)
Received: from localhost.localdomain (46-116-236-159.bb.netvision.net.il. [46.116.236.159])
        by smtp.gmail.com with ESMTPSA id p1-20020a1c5441000000b003b4868eb71bsm14318393wmi.25.2022.11.13.03.24.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Nov 2022 03:24:35 -0800 (PST)
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-nvme@lists.infradead.org
Cc: Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCH v2 08/20] nvme-auth: remove redundant if statement
Date: Sun, 13 Nov 2022 13:24:12 +0200
Message-Id: <20221113112424.1049834-9-sagi@grimberg.me>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221113112424.1049834-1-sagi@grimberg.me>
References: <20221113112424.1049834-1-sagi@grimberg.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221113_032438_385003_B790CCEF 
X-CRM114-Status: GOOD (  11.62  )
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

No one passes NVME_QID_ANY to nvme_auth_negotiate.

Reviewed-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/host/auth.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/auth.c b/drivers/nvme/host/auth.c
index d62862ef5b3f..e7e4a00ee37e 100644
--- a/drivers/nvme/host/auth.c
+++ b/drivers/nvme/host/auth.c
@@ -874,7 +874,7 @@ int nvme_auth_negotiate(struct nvme_ctrl *ctrl, int qid)
 		mutex_unlock(&ctrl->dhchap_auth_mutex);
 		return -ENOMEM;
 	}
-	chap->qid = (qid == NVME_QID_ANY) ? 0 : qid;
+	chap->qid = qid;
 	chap->ctrl = ctrl;
 
 	/*
-- 
2.34.1


