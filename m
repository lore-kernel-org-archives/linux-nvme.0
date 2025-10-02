Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED0CBCAC5B8
	for <linux-nvme@archiver.kernel.org>; Thu,  2 Oct 2025 09:22:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=Jc18GZtrHqzSr/pDa9pzm2Av3OH9+j+09Y6i3Vb76QM=; b=AEbiJbJqbLVzFK5UB5sKbCZnys
	nKDLZrttkvi8VtdvpCCwohhU78/4SLpT+kO7vqZAExj0oJdgpUiDbWlGnP2JYNkume05IY2s41l6a
	V7prVpsU53T1u1iM47M9pjZFho+07tUvZAx3ybSCrRf+Yk5NEAcb6Dojtf35Pd+2Hap3fLBV2+vI8
	1k1bNZVvev8xtr0yZjkTM+EJbDTVZvH2BPIkjnXxD8mkyrDAfHzjLJkfzDklNlfcIiSd63FWgFabt
	cRkLq3PNee8WyqvuiI/sFfeltAPodzSjXPbnsGdgdk0oc4Grb6XcW3PxPt/DjOn4mEdikAQukt2ps
	1nq9ZzRA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v4FVq-0000000A8YE-1Q2s;
	Thu, 02 Oct 2025 09:22:10 +0000
Received: from mail-lj1-x236.google.com ([2a00:1450:4864:20::236])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v4FVo-0000000A8Xg-2LR9
	for linux-nvme@lists.infradead.org;
	Thu, 02 Oct 2025 09:22:09 +0000
Received: by mail-lj1-x236.google.com with SMTP id 38308e7fff4ca-368348d30e0so7329201fa.1
        for <linux-nvme@lists.infradead.org>; Thu, 02 Oct 2025 02:22:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759396926; x=1760001726; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Jc18GZtrHqzSr/pDa9pzm2Av3OH9+j+09Y6i3Vb76QM=;
        b=RnUOTm7mjb7c3iSNUEkQrbqxi4dhzMYtDoEByRx2/E4ratTC9G/I4DRCpHrECnlvm7
         FUjzgVcU4o4RXm0IhPy4xcgbHnDQjJeLJjbH0FeN2vbsgdmsgaJOijCAVuA+de+VcoF+
         vt9HXfCNJmw8aLbPRno3zI+kg/1BPApKxj5U6RwFPCc4eqohGcsIIbySGG6An6vdaClR
         +vHB3TgZ7dMtApD0+4ogPfBwlOxeWEGR/IuFgDulZDca3c6ZMvTSk3skcf+nIyQOiqxi
         JIUvVjZrNJb4SP9uXqxYSdzCTVK/6qfHcIpH36I5T2rpBPP64pCMyw7mESt7R89MqdP6
         XWxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759396926; x=1760001726;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Jc18GZtrHqzSr/pDa9pzm2Av3OH9+j+09Y6i3Vb76QM=;
        b=vvwbVX1jXOYWMVFiNsJCYFGaqvdWaIIJ8doM9+y3j7/0xFf9bIEPCc3AdrFpuBCrDW
         xlxoykk99CN1Uv9YMM5N16p4zQfEoQRgNdEm3vDh52H0Q/g2+A1IMcmyvO4aZekLMRZ7
         jJHkX4DsXnUrzRdpF2u57WGFX7MqO3Jr1s+8WpkTiXw9MOJMn60ZuPVWbEm1kyriqrb4
         Texp10iG0tDxdyKAp4iVPgNt7SZUG6WU40q5bXjECZKCGvkw6jbR7YEGbnOanZJOoIdW
         1Ck00PkQcgoRDzsTIiRB06TMWJVMbKftGbyf+uxz+bmB1wXKPDdkMlG+m2o6rZbElV8c
         NbNA==
X-Forwarded-Encrypted: i=1; AJvYcCX+kRyGToSEy54YtHPYJ8FOGRjbAwtbI7+IMvhXNyWC0brDp+5x1VZa4t2ipH4/cJzHUpzj1lZ5heFB@lists.infradead.org
X-Gm-Message-State: AOJu0YyRTzXz5LRQCD0uE1CutUshbIXHh1S4qKwr2Zv5Fw1S5XrbBXE+
	85bgeqcjvoqFPUcK44dCID3/KI6GS3lxq1bSrEsqXqxfJN/kQgiOuD+iwYbb6vnEPio=
X-Gm-Gg: ASbGnctOlGtARwIUkqUIaJMytUS724Vruf6UHhfdALRuhXzhkfAxHZRwukFkQakUcI8
	bo+LLmaB2cPrhk+/FRhBgoPYhy3sVrHuSZ4KH4P3VlVKf9YaCPo00KHWrBTImRFci44o4Y2vKoh
	0AVbMRvKRZHDbhz2MDbpg2EiW8ClNXdoK1+6Drno2q74/MGzQ2VuwyKXhWflP3YVMQEsQ8vIr9O
	2MoHAu6eQ8U9BrQnBJzaB3t2kOeBKs8BiimJ87q+Z7lhoSFouts7Fbmm6W66kNf3Myp8PZuIrmf
	e3Hs68QN8cRa1SSKsaemqY4C161SmmDb66yQdWcTu+FmwbpsLTSE7uQQu1//cbj/yHRSaBB3J1r
	akWCrH10FzIXC7yRqBYGiF5nzhRcfBXtFzReKiJv5vbMagJ6tKgQ27a70bjaMOORgH+ehm1+jXp
	o5aZdPEfjjdfNl+FDciCHUByq3vxTA2LcsIY+wm8KZ
X-Google-Smtp-Source: AGHT+IE8i0+6YbCw8yKaxx00ipzKZM5vQ/ktJ4J5ogZF04+s2uzUegs2HA0XBU3rhglvN15ySQRqxg==
X-Received: by 2002:a05:651c:512:b0:372:96c1:b276 with SMTP id 38308e7fff4ca-373a74d5c50mr19350441fa.45.1759396925877;
        Thu, 02 Oct 2025 02:22:05 -0700 (PDT)
Received: from localhost.localdomain (broadband-109-173-93-221.ip.moscow.rt.ru. [109.173.93.221])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-373ba44455dsm5531951fa.39.2025.10.02.02.22.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Oct 2025 02:22:05 -0700 (PDT)
From: Alexandr Sapozhnkiov <alsp705@gmail.com>
To: James Smart <james.smart@broadcom.com>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Alexandr Sapozhnikov <alsp705@gmail.com>,
	lvc-project@linuxtesting.org
Subject: [PATCH] nvme: target: fix error checking in nvmet_fc_schedule_delete_assoc()
Date: Thu,  2 Oct 2025 12:22:01 +0300
Message-ID: <20251002092202.11-1-alsp705@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251002_022208_604519_F2B85B20 
X-CRM114-Status: GOOD (  12.35  )
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

From: Alexandr Sapozhnikov <alsp705@gmail.com>

The nvmet_fc_tgtport_get() function may return an error.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Signed-off-by: Alexandr Sapozhnikov <alsp705@gmail.com>
---
 drivers/nvme/target/fc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/target/fc.c b/drivers/nvme/target/fc.c
index 337ee1cb09ae..68a416a92bfc 100644
--- a/drivers/nvme/target/fc.c
+++ b/drivers/nvme/target/fc.c
@@ -1110,8 +1110,8 @@ nvmet_fc_delete_assoc_work(struct work_struct *work)
 static void
 nvmet_fc_schedule_delete_assoc(struct nvmet_fc_tgt_assoc *assoc)
 {
-	nvmet_fc_tgtport_get(assoc->tgtport);
-	queue_work(nvmet_wq, &assoc->del_work);
+	if (nvmet_fc_tgtport_get(assoc->tgtport))
+		queue_work(nvmet_wq, &assoc->del_work);
 }
 
 static bool
-- 
2.43.0


