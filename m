Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4091C7EE2E
	for <linux-nvme@archiver.kernel.org>; Mon, 29 May 2023 10:59:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=14IeKFKyO0pcEcP2T20UmiR679IiGg3A2D145C6b2n0=; b=F01MlKgIKN0op1QDxo92qTo6Le
	79CgSkxhqibd2b47AwNydy2RgMXklr57DJEJRI6lmyCrv6N2eMm4/dkEtTsb3Q/o2Q063W02AOupS
	vh4PsUZ6UgtFnitc6btvImagpae6Ou3LfKqq+P8VYpYr9L4DGoru0EyfuZ0w+CPdWpPnem/KB7tkZ
	fC9NPcZjN+jqcSNUmQIHGxvBJdZAKahyh5fINBm8IMxPUCxXid58zX2pFdPUsnzFo9tAI4DNlg1Qq
	3JcuQFm4Yk8BlLW7J1fz3nbzzd8D5s8D+rE7Yo+qGJsiW8zfCCG8hSXGu+MULCzSiGUlRlbuIYIz/
	wTCOJwaA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q3abD-00AD0D-2u;
	Mon, 29 May 2023 10:59:39 +0000
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q3abB-00ACyh-1p
	for linux-nvme@lists.infradead.org;
	Mon, 29 May 2023 10:59:38 +0000
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-64d30ab1f89so2127007b3a.3
        for <linux-nvme@lists.infradead.org>; Mon, 29 May 2023 03:59:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685357976; x=1687949976;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=14IeKFKyO0pcEcP2T20UmiR679IiGg3A2D145C6b2n0=;
        b=rtw4s0zcr86QVVIPEt0FBcZ14qSZwrUwBbG7EXWGEcEazWjxryPP+540XqF70NitCE
         m4wWSIy0DTOxYr9NASRF2v7CsqTg0L+s5CnP+ocad2v8kmMkjfy+JEF/U6B8BTnhgZtX
         Ow+lQq2udEM8cV7mfH6vX7dLsIAwwK+FolvsM/oG5PGQ0HDbSmWenyzkbX+t4h/Avij1
         bsc4V34eTOynYW/TlICn+55fQtzAVuG3fMkLrrtYHOVSBttRhYtG95miMjY5hZ0CgT+6
         4wFhAJE5uba/FwMSfNzeeSPzRMNz42R8nIx6rP3ZuPXazLhAvaoXDxITLUKWpyNmItzZ
         5r3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685357976; x=1687949976;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=14IeKFKyO0pcEcP2T20UmiR679IiGg3A2D145C6b2n0=;
        b=Ikm7mEBHkN4tJntPiZN668LVXxsIDtGbCcX5k7ef1gFQ3foFGFUug0Q014VtRyoP95
         mNI6Ki1hyX3CYQy1ObeiRXowT6fjVrvaSt56efq6QoJgbKDrUYtrNhQpeQ8DvCx4X3ur
         vHjB27PpC/LzQeeC+wcRv0LbaKE6eDIwcBYuiqYIByqZFxZ3PeyvTKWFfiJSlnJkrKh2
         wX46bLYOaadLbAsDfhFGh8xY712ZTUq+gjUcC/7Ndhoh3HSeuVVRgF1bIHPQoBaWjuOz
         T0YHvjCqvsfFoP6z4FhxTC2CPJBKHgGztl1UWuGJ5Gyg/3keoRL2g3CbkGb2E4jKAC6i
         4jUA==
X-Gm-Message-State: AC+VfDyvjcl5eoog3ZkfBU81tnEIGU/a+rqs1b9ff7QXBo9tzjKtFq+I
	l2lvniNBNiKtxQ8lMFImFSY=
X-Google-Smtp-Source: ACHHUZ7I+haGz9+NyjW+6/WdCddkapRJgOEh18pWpXYq10OABHqcb4cm/F8vXLMGzrJL7vwCVhZh5A==
X-Received: by 2002:a05:6a20:8428:b0:10c:b441:5bd3 with SMTP id c40-20020a056a20842800b0010cb4415bd3mr8901649pzd.11.1685357976278;
        Mon, 29 May 2023 03:59:36 -0700 (PDT)
Received: from localhost.localdomain ([143.92.64.20])
        by smtp.gmail.com with ESMTPSA id v7-20020a63d547000000b0053f22b76cdcsm6863110pgi.82.2023.05.29.03.59.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 May 2023 03:59:35 -0700 (PDT)
From: "brookxu.cn" <brookxu.cn@gmail.com>
To: kbusch@kernel.org,
	axboe@kernel.dk,
	hch@lst.de,
	sagi@grimberg.me
Cc: linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 3/4] nvme: optimize nvme_check_ready() for NVME_CTRL_DELETING_NOIO
Date: Mon, 29 May 2023 18:59:25 +0800
Message-Id: <32d00d1689773fcb2a177ca3ce89a3b12c1fa4c5.1685350577.git.chunguang.xu@shopee.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1685350577.git.chunguang.xu@shopee.com>
References: <cover.1685350577.git.chunguang.xu@shopee.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230529_035937_608626_7C6F8853 
X-CRM114-Status: GOOD (  12.32  )
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

From: Chunguang Xu <chunguang.xu@shopee.com>

nvme_check_ready() will directly return queue_alive while
controller is NVME_CTRL_DELETING, maybe we should do the
same things for NVME_CTRL_DELETING_NOIO.

Signed-off-by: Chunguang Xu <chunguang.xu@shopee.com>
---
 drivers/nvme/host/nvme.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index a2d4f59e0535..35066ad10cd9 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -793,7 +793,8 @@ static inline bool nvme_check_ready(struct nvme_ctrl *ctrl, struct request *rq,
 	if (likely(ctrl->state == NVME_CTRL_LIVE))
 		return true;
 	if (ctrl->ops->flags & NVME_F_FABRICS &&
-	    ctrl->state == NVME_CTRL_DELETING)
+	    (ctrl->state == NVME_CTRL_DELETING ||
+	     ctrl->state == NVME_CTRL_DELETING_NOIO))
 		return queue_live;
 	return __nvme_check_ready(ctrl, rq, queue_live);
 }
-- 
2.25.1


