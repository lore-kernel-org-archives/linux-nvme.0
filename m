Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D053D2CE01
	for <linux-nvme@archiver.kernel.org>; Tue, 22 Oct 2024 16:49:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=RYYOyFye/hScKvvsdfSV5kUFbhBLHy5xS5VI3vFVDPU=; b=AD/JtNr1r4kGzRhZtbAFogGHCM
	aJT2ibG666h0sV9SaFt/QTd9hJKVZgdDmnrdB93JsVNzY5QG09d99uvgWLXGNSYC/8wELimORVO1X
	Yjd6uXmpo5v1fjI+fWDmHBV53LLUsoz7fNS3wBdL9q1Sb5GSgo23Fyd5ilRvEoLceZ08vgDZ3k3Ht
	CtFY96cxydaan8KVExgjnmvJDCBQPkIJAfkjLF8ANr9DCl64ot0Hr94+doqBs4X21oK/OJBn6A3lV
	RmvX9n77U+R8zmX71n3HHjQiMGo3lhAVvhh+Jsxf/d1q/7Da7tm82sm4Coh9KpisDwK8MU0D1Is0k
	6+gJ9H0g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t3I4d-0000000BXOF-3Rql;
	Tue, 22 Oct 2024 16:49:35 +0000
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t3Hqi-0000000BU63-1DQa
	for linux-nvme@lists.infradead.org;
	Tue, 22 Oct 2024 16:35:13 +0000
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-20ca7fc4484so42337555ad.3
        for <linux-nvme@lists.infradead.org>; Tue, 22 Oct 2024 09:35:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729614910; x=1730219710; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RYYOyFye/hScKvvsdfSV5kUFbhBLHy5xS5VI3vFVDPU=;
        b=Io/M0flPH+nyY5wSDAuMPHJIjkiSETu/tshnEGDfSslsjv1w+M2EEHT5bLnDHBFOjy
         07vXc0KzRC9hmn7V88Pj0XzmKCP+xm2WTn3ePLQ3TR369f3W1H0mS3o8iBNjBijzpb3g
         qj9E5jghvnNutlQrzmivtlKZzEOcs7hYjO0hU/BKCosE7d8aqjpmjSCjfWRo4kjNxzvu
         2ovyJ5Upll8+RGlkc/I1BWaI3jrmFj9N0iAOspGHJm7V9RwlH+Ag0NzWzZalAqa1fhdd
         ufVV4Er8+UM1Y5xd8iHi2h1n8t22FnaLw6jUITaW8YT6QLVQQKpazVBcVc5t/ga9kX2u
         W09g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729614910; x=1730219710;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RYYOyFye/hScKvvsdfSV5kUFbhBLHy5xS5VI3vFVDPU=;
        b=xPNoIjyP0/AXODgbhqLqPtemnYd1b4/Cf70CIaji/ehquh6gvtjWXsRHaKnBprIdUT
         jMQnT9eVMo4hgl9uC46TOpDm4jqHde8hzBS8hjlJ0KlJVyuIrmeQ8A5vsR/wnkVbtOLA
         kCF8owso0xX1GwHZRsgpF7RZ/Tsf93QPEjIiiZehf2eanu4Cgg9STFca/PJiQqtm1Pb4
         DHNcLoSUKk/dzLH+04V/M4GUDiCWB8TK843TwJWxGHSD0OTp1Z5iQoHkEwLBGlh7CE7T
         WyGZ6KA+OMkY1wgkvq8d9KJj3eXTwq2LHvnx/6MJ9Ksz22/WU32Q/VQy4bMX/VjJjnyV
         631g==
X-Gm-Message-State: AOJu0YztFeBfUTImqmkq6Me2DwjAB3ZIaeFjHM7C83oJzgYpIcyvrcty
	aycg0emmZXwkePvv0Qsk/fAIxd3pSrV27DunhdnNheJmzRCTk+f2nnacug==
X-Google-Smtp-Source: AGHT+IE9+tpxd3STDJ5JbCaF/KsSbGrybY0Hq9seZVSlr0163rl7JqCbaELV7cF517T/BCrV2wOYTA==
X-Received: by 2002:a17:902:d48d:b0:20b:5046:35b with SMTP id d9443c01a7336-20f52ba208amr40125ad.57.1729614909775;
        Tue, 22 Oct 2024 09:35:09 -0700 (PDT)
Received: from tokunori-desktop.flets-east.jp ([240b:10:2720:5500:f6f1:2f90:dd68:7e46])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20e7ef133dcsm45055165ad.115.2024.10.22.09.35.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2024 09:35:09 -0700 (PDT)
From: Tokunori Ikegami <ikegami.t@gmail.com>
To: linux-nvme@lists.infradead.org
Cc: Tokunori Ikegami <ikegami.t@gmail.com>
Subject: [PATCH] nvme: check PI size if metadata size or below
Date: Wed, 23 Oct 2024 01:34:27 +0900
Message-ID: <20241022163504.10738-1-ikegami.t@gmail.com>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241022_093512_355377_D81C34AE 
X-CRM114-Status: GOOD (  14.28  )
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

The PI is the first bytes or last bytes of the metadata.
So its size is not equal to hte metadata size only but below also.

Signed-off-by: Tokunori Ikegami <ikegami.t@gmail.com>
---
 drivers/nvme/host/ioctl.c | 4 ++--
 drivers/nvme/host/nvme.h  | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/host/ioctl.c b/drivers/nvme/host/ioctl.c
index b9b79ccfabf8..9fddaaddbbf1 100644
--- a/drivers/nvme/host/ioctl.c
+++ b/drivers/nvme/host/ioctl.c
@@ -232,8 +232,8 @@ static int nvme_submit_io(struct nvme_ns *ns, struct nvme_user_io __user *uio)
 
 	length = (io.nblocks + 1) << ns->head->lba_shift;
 
-	if ((io.control & NVME_RW_PRINFO_PRACT) &&
-	    (ns->head->ms == ns->head->pi_size)) {
+	if (io.control & NVME_RW_PRINFO_PRACT &&
+	    ns->head->ms >= ns->head->pi_size) {
 		/*
 		 * Protection information is stripped/inserted by the
 		 * controller.
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 093cb423f536..fbcb2243ba84 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -542,7 +542,7 @@ struct nvme_ns {
 /* NVMe ns supports metadata actions by the controller (generate/strip) */
 static inline bool nvme_ns_has_pi(struct nvme_ns_head *head)
 {
-	return head->pi_type && head->ms == head->pi_size;
+	return head->pi_type && head->ms >= head->pi_size;
 }
 
 struct nvme_ctrl_ops {
-- 
2.45.2


