Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 895B6C4345F
	for <linux-nvme@archiver.kernel.org>; Sun,  5 May 2024 12:03:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=/QZGKL8fTE+NGn+Bj35qjL86s9HWjqNK29yhGguCU0A=; b=H5awzWO7AtgwTUvHJb2k8FGgAd
	J/HKmhw0hh/ywaPuSxfcsNOLddMamjR+OZ41QUryfuuoGk5yJIjeDbO0hbPcJzCAFK8HG7F6cArPw
	J5k0ExVJ8fUzrjFpN/AllOVvSLgc6pC/CUyfCjFfmZYv3jSUWmbcCtWKcnJEHlTYyrJZJSZoL5qhE
	0gT+uZIz6Bz3gcsvBR6Qb8fdOb2x8aCoAQ0Tz8ysb/bXQ0tOUE/MH+mvZxYKUHMvDuBOjO5s5B0Ip
	SPsG9H1eEW8AcMZuJIqCZJThE0WpBVHv5xdzxCg/TtqgXPrHdZ5me3JEFOOSO05UVtfSNAb7qDNwQ
	3MGLPzGQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s3aae-00000004Cnf-2hJc;
	Sun, 05 May 2024 12:03:36 +0000
Received: from mail-io1-xd30.google.com ([2607:f8b0:4864:20::d30])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s3aaa-00000004Cmm-2csJ
	for linux-nvme@lists.infradead.org;
	Sun, 05 May 2024 12:03:35 +0000
Received: by mail-io1-xd30.google.com with SMTP id ca18e2360f4ac-7dee0dfd57aso60107039f.1
        for <linux-nvme@lists.infradead.org>; Sun, 05 May 2024 05:03:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714910610; x=1715515410; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/QZGKL8fTE+NGn+Bj35qjL86s9HWjqNK29yhGguCU0A=;
        b=lpavYPE5AIJlRajUWVMkC48twXW+hPC4YNlD+lcir5jLmccDNdqvIJTq8WcvPCje8h
         70HMO4TRr5jR+GgLjKZlat34j8UX87AXiJa7CJPrbj4IhsoMmijDWs2A4VD0xHBPONKR
         YIb1Tyf6j+bnsDWMFPQ+H1AGJYIUvgOFKvo5DMNwqCWugzQ+2PEu+0lvD2OcMDwvpTvQ
         5W7UakSpFOu//HLslyUdnrhPQj3pxyckfVJR1NJjp+NrC+ONBxtT9hkBu7uw01aaUlo3
         F9I4cow62DS4XERMUv4sFFPTDjf0UXW3VjHikoUePbtV/nXMuv4U7WufjbIHgyaIOFSL
         8uGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714910610; x=1715515410;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/QZGKL8fTE+NGn+Bj35qjL86s9HWjqNK29yhGguCU0A=;
        b=pI9NN/0Dz1ynDRwS9gwV9rBl0rDgtirZABT8BA3LAEJP+sZ31e8iB0imgDKbVxVFDR
         NMKWyKY+dwIJxrDxViGJ7ISCA5gYH9fJ4d9r/3nZmFWdmYEtku4FjciEmlv6NYc/a4y4
         AeeR6OB4sl8ToP5MM3X3KqcchoKWWjzNuBbI46cRyIAHGOm264lYGbPLwwNfIadUzkia
         POYF3vdOtbyOqoEy0DTkMi0CU9XCf/Mf3MYXxwGmHixKhY+CrCfJ19SzeW1J5WGo07Go
         qqYp8oUWU28YLiVYxLq0cY/BitFNYMB4qmbaTf0eFqKhBqoGr9kMASOL0Z5f7NywlKDJ
         u+ew==
X-Gm-Message-State: AOJu0YxDcpe0uL/KtGGf/+p+2EACOWcNjAkqNYVijFI/MkZ0nXVkBkld
	hOMbKxOjpkdYfJkFQcj1OrEVRVzOtEO0uqvPRGBLwSs146IAvhv0z4YDuuDE
X-Google-Smtp-Source: AGHT+IFrcJ65rAOhgvWUaqKaFYdDxW4rQw2cy17SUgsHzUidVXLbhSJD+uqRaD363IWGFlHB+mqfzg==
X-Received: by 2002:a6b:7210:0:b0:7de:a107:913c with SMTP id n16-20020a6b7210000000b007dea107913cmr9665522ioc.13.1714910610045;
        Sun, 05 May 2024 05:03:30 -0700 (PDT)
Received: from tokunori-desktop.flets-east.jp ([240b:10:2720:5500:23e0:c465:86b0:be4c])
        by smtp.gmail.com with ESMTPSA id o18-20020a639a12000000b0061ce6606203sm4380088pge.58.2024.05.05.05.03.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 May 2024 05:03:29 -0700 (PDT)
From: Tokunori Ikegami <ikegami.t@gmail.com>
To: linux-nvme@lists.infradead.org
Cc: Tokunori Ikegami <ikegami.t@gmail.com>
Subject: [PATCH] nvme-rdma, nvme-tcp: include max reconnects for failed reconnect logging
Date: Sun,  5 May 2024 21:03:05 +0900
Message-ID: <20240505120324.20858-1-ikegami.t@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240505_050332_690725_B2210C3F 
X-CRM114-Status: UNSURE (   9.46  )
X-CRM114-Notice: Please train this message.
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

Makes clear max reconnects translated by ctrl loss tmo and reconnect delay.

Signed-off-by: Tokunori Ikegami <ikegami.t@gmail.com>
---
 drivers/nvme/host/rdma.c | 4 ++--
 drivers/nvme/host/tcp.c  | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 366f0bb4ebfc..fc33f16f9f0e 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -1118,8 +1118,8 @@ static void nvme_rdma_reconnect_ctrl_work(struct work_struct *work)
 	return;
 
 requeue:
-	dev_info(ctrl->ctrl.device, "Failed reconnect attempt %d\n",
-			ctrl->ctrl.nr_reconnects);
+	dev_info(ctrl->ctrl.device, "Failed reconnect attempt %d of %d\n",
+		 ctrl->ctrl.nr_reconnects, ctrl->ctrl.opts->max_reconnects);
 	nvme_rdma_reconnect_or_remove(ctrl);
 }
 
diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 28bc2f373cfa..4c4c363d2025 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -2272,8 +2272,8 @@ static void nvme_tcp_reconnect_ctrl_work(struct work_struct *work)
 	return;
 
 requeue:
-	dev_info(ctrl->device, "Failed reconnect attempt %d\n",
-			ctrl->nr_reconnects);
+	dev_info(ctrl->device, "Failed reconnect attempt %d of %d\n",
+		 ctrl->nr_reconnects, ctrl->opts->max_reconnects);
 	nvme_tcp_reconnect_or_remove(ctrl);
 }
 
-- 
2.43.0


