Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD790CD5BB4
	for <linux-nvme@archiver.kernel.org>; Tue, 26 May 2026 07:52:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=4w4YDVU9FCAe4woIXkwK7wnANjG8Ql/SZsjHSJVgUOk=; b=foG+lgp47b/wRBBSBTLUnU4v2J
	isV3rcuUUyk0xCBTrK/vrHF3zaKbn1b+UZT6RKWCP0RfPWg8nVo5tOAMNNipLW7IGTcYSkzg4s/sn
	3f3tDg/zD5BfBac1Ei0+ZTKyjV+/wv3d/DE3IXnrPc7aYBOtcIs611dL66+b4By6jQqAzzVfxio2+
	hnt485igbCoFRDaBAfsw1A1O5z+mq/9G4gZiqGuZ3HOfarm8VjJpFmtonrkdQrq72241p3YsT6euB
	+heOfsr2l83WOAh14gKIOuffm+GfLlJ9MnYCMdlcqrRyt0eWuGkhTtuZ/Uf1OM2ctuxoe8FjNIytP
	y/3fZs2A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wRmak-00000001JYb-0XC4;
	Tue, 26 May 2026 07:52:46 +0000
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wRmah-00000001JWc-2LsW
	for linux-nvme@lists.infradead.org;
	Tue, 26 May 2026 07:52:44 +0000
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-48a3e9862f0so54125445e9.1
        for <linux-nvme@lists.infradead.org>; Tue, 26 May 2026 00:52:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779781962; x=1780386762; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4w4YDVU9FCAe4woIXkwK7wnANjG8Ql/SZsjHSJVgUOk=;
        b=EynDH0FPj435A6hO+TYs15hUkThXn/zI33nIyFRRjjKqvuoc9LKFp4/r9jsY8kxrj+
         cdc+lu9PDKV3wKB/3uYd8bVkeHyHi5jA2mtu2FYn0nsYC1OK5rLlkUIfbmK6axWae6Fp
         +rCapnrxHmnGVwUBDmHX/92SJDaiULVLUHAvH0Y7bPXGGYxJatfEU571w9tK+/csgKSe
         +6HYgpEAEloeKzDspAR6iTB58hMyAvkUH3SEJ/AnxHvXF41z2DDN9G0FZAynGWe1Xt4m
         UmljKGua/rpVokQtDseesmT+QfU8Si3Zxf6qzPCsXQ3gfTXqU4miCRMW8qrcwZ5sQjOI
         vrrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779781962; x=1780386762;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4w4YDVU9FCAe4woIXkwK7wnANjG8Ql/SZsjHSJVgUOk=;
        b=p2togiXiycEnvEqD7VPLOUd19MZmCufGAVeXb1fB5V9JqH0edVIIDBxcXVHwpkWLGh
         XgBNMPMbvuhjZgPE30T2Cwz76v8AJx6BJRy7Q+6cu/u/frertmcNlO/FlTlobreOkYp9
         9LryiLWkbRKxttXV1wVjfM0sUsx/eTEx46GHiQojXZQzAgOYNPFwbWFyAX9DuM8RxzpB
         DyX78SbmD9V+ZLsEHzOVTIdmCx0MeH4PYUWGIXSzq2K34n4uHMcujose+WYE8hIso/N7
         eCUXxacsYi+b1QxSQaLhAXwuhoCjTfVlZC17jCyGB3ku8YL48tHgv8cX0JKW2hDwaHC0
         /UBQ==
X-Gm-Message-State: AOJu0Yyl0xggcere+qKk9TlPCFrl0QqPr3+QTHhEqYwm9XN+LGGktcZb
	v5Xl9xGjx+cqPcrG2lJz8+8T1gpQdkN+z0n8uaam7tieMfYJ1pkPyYXzcsYchtzCdtEQVsiv
X-Gm-Gg: Acq92OEUPGZKtd7KDXW/H3jm5JCGl3+QqX+yCQUnaeHMogl9gW5qgu6wA5qweIu1j+v
	enZJ5pO8BrN6CL0O/5SBjQjJbnkXT5C0uMQfWhKbzfYos241KXpEMPfOWQniIqPNFr+zn1YbyXr
	nWawTdZhNT/EZoRAgAo5ABiuS9YDddlkLnNa06+rxXRxPI9Nuz2J7RKa5VCSZ888CU+uS0sX68o
	8aYhn0VqY5s65kqHGH8kQFblO/HDs270DSk6HSv0+ryw57OmON8Ubu+NXnTJzAGfKA6yPI/FLyV
	MM2602JppMB7K09Dni9xNy2j0EI9Fvj+M2FevRoT5G0gptdAFTjg0qAq3vkKux1ujiDl2PgDFn5
	C44F4HAsaa0d7Lr/UQbLQxtb+gvLIHN06TWHMiEVAV4a0Yl47/tBtu/0YneMJ1LpJ1v+0AQ0rDj
	J0gQ7tiGM=
X-Received: by 2002:a05:600c:1d19:b0:48a:761:5816 with SMTP id 5b1f17b1804b1-4904245fe58mr245857735e9.8.1779781961488;
        Tue, 26 May 2026 00:52:41 -0700 (PDT)
Received: from [127.0.1.1] ([2a09:bac5:3803:1cdc::2e0:83])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4904526c926sm540682825e9.1.2026.05.26.00.52.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2026 00:52:41 -0700 (PDT)
From: liuxixin <gliuxen@gmail.com>
To: linux-nvme@lists.infradead.org
Cc: kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me, linux-kernel@vger.kernel.org
Subject: [PATCH v1 1/1] nvme: fix FDP configuration log parsing
Date: Tue, 26 May 2026 15:52:38 +0800
Message-ID: <177978195864.4106423.11658267582906445997@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailer: send-local.py
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260526_005243_624575_2979AF3A 
X-CRM114-Status: GOOD (  14.84  )
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

NUMFDPC in the FDP Configurations log (NVMe Base Specification, Figure 279)
is a 0-based count of configuration descriptors. Valid fdpcidx values are 0
through the NUMFDPC field value inclusive.

Fix the off-by-one check which incorrectly accepts fdpcidx == NUMFDPC+1.
Also validate descriptor sizes while walking the list so dsze == 0 or a
descriptor past the log end cannot cause unbounded iteration or reads past
the buffer.

Fixes: 30b5f20bb2ddab013035399e5c7e6577da49320a ("nvme: register fdp parameters with the block layer")

Signed-off-by: liuxixin <gliuxen@gmail.com>
---
 drivers/nvme/host/core.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index c3032d6ad..c5e77f5bc 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2231,7 +2231,8 @@ static int nvme_query_fdp_granularity(struct nvme_ctrl *ctrl,
 	struct nvme_fdp_config_desc *desc;
 	size_t size = sizeof(hdr);
 	void *log, *end;
-	int i, n, ret;
+	int i, ret;
+	u16 numfdpc;
 
 	ret = nvme_get_log_lsi(ctrl, 0, NVME_LOG_FDP_CONFIGS, 0,
 			       NVME_CSI_NVM, &hdr, size, 0, info->endgid);
@@ -2262,10 +2263,10 @@ static int nvme_query_fdp_granularity(struct nvme_ctrl *ctrl,
 		goto out;
 	}
 
-	n = le16_to_cpu(h->numfdpc) + 1;
-	if (fdp_idx > n) {
+	numfdpc = le16_to_cpu(h->numfdpc);
+	if (fdp_idx > numfdpc) {
 		dev_warn(ctrl->device, "FDP index:%d out of range:%d\n",
-			 fdp_idx, n);
+			 fdp_idx, numfdpc);
 		/* Proceed without registering FDP streams */
 		ret = 0;
 		goto out;
@@ -2275,7 +2276,15 @@ static int nvme_query_fdp_granularity(struct nvme_ctrl *ctrl,
 	desc = log;
 	end = log + size - sizeof(*h);
 	for (i = 0; i < fdp_idx; i++) {
-		log += le16_to_cpu(desc->dsze);
+		u16 dsze = le16_to_cpu(desc->dsze);
+
+		if (!dsze || log + dsze > end) {
+			dev_warn(ctrl->device,
+				 "FDP invalid config descriptor at index %d\n", i);
+			ret = 0;
+			goto out;
+		}
+		log += dsze;
 		desc = log;
 		if (log >= end) {
 			dev_warn(ctrl->device,
-- 
2.43.0


