Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB11DEC1112
	for <linux-nvme@archiver.kernel.org>; Mon, 23 Feb 2026 17:24:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=WNHyGNAyEqFR3uHLeuiUimMy9GKVCPy3eo7HwiOI0Rs=; b=lC9+TkM5Wo5ChlIxS8T3mfc6Vw
	3tOwwr3fOccIApWkAopz1bw99o7Ac3ZW1FZ/S9UFJ7PI9/t2TVC0dYMddz6eZZMv20CmuJTlCNcxw
	sVr84cNWV33MakYXxTPB0wkRc0auj0qtcBknRBgorUAb+9qPPrCuAfUdzJyDkTcJFC0HhX2e/LKMF
	g4gACuFwQqOpBJ4v14tAPptTCh0+Uv4Tz2cGfQrITvBRsb/1flus21mF82R1vDuIc3mgI6txjjdZI
	FQ0nugWTJgDtjP4T7x/sFQffa7SsvbHn0O9dgAfGL2LZB7g0E5m09AOP8BzKS7Q64weGGUCfw0zm+
	WamfIBKw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vuZfQ-00000000m9W-0v1L;
	Mon, 23 Feb 2026 17:24:20 +0000
Received: from mail-pg1-x533.google.com ([2607:f8b0:4864:20::533])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vuZfN-00000000m7J-2fMQ
	for linux-nvme@lists.infradead.org;
	Mon, 23 Feb 2026 17:24:18 +0000
Received: by mail-pg1-x533.google.com with SMTP id 41be03b00d2f7-c6de0527ce1so2596478a12.2
        for <linux-nvme@lists.infradead.org>; Mon, 23 Feb 2026 09:24:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudlinux.com; s=google; t=1771867457; x=1772472257; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WNHyGNAyEqFR3uHLeuiUimMy9GKVCPy3eo7HwiOI0Rs=;
        b=hAc88JFI7vm/cvxZmTqZcl4FOzL/mCzxEwjSMXqujxBboX8UXkRmIkvP1A+B2ywtm8
         qPBc7bGTFpTlGSxmDp2SdDBkrprN55kbs5MLsZVM2J+hTq7BWsQcdDecKkO8FHaYDvc5
         7GNvCPQkFqIqXD8/4krS+Y5xYOCaUcIGPP1c8ldN52CrVJk9HDcQCrIgB9UaxqQfZT1r
         TFW8FxWDq+wMKuhkEKINcpLRK74lPWU+wOoLld6EK+xj8TJWAIYQSTU55pkxoFMKiaaL
         ORbJmDp7UxYkL0DfVVFRpd36LqLEXcIA2kJsk/3cjUn0b9eIzDic225u/QKlmVXQOBCg
         kTow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771867457; x=1772472257;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WNHyGNAyEqFR3uHLeuiUimMy9GKVCPy3eo7HwiOI0Rs=;
        b=xBzAuUpGwhp5tbXwFShkX4al9xn9vtpVhFHCR1eaoNls7GMg9mJYxtBptRymDG+LlR
         BnXAhqyo/ZtGnxlM+ybd6DFMI7dzKFfslysG9YAl57dPepqiI1M058v7AhpG4UhUjxgl
         O4C1EwSXeHgMKalUJs51w0t7EQhgjJRyiGce3AmwXfkxcfMzXqSGVOIKKd8JyNrKAEUg
         wGPM7fqHpKL4r5jqghpvoqGv8YBASaOh5kRQ2b7/7wemhJmgWEdPECNnWRkCfHQNzphk
         4BHoszzWl6qa8lFHM+m0TA05I3jv74PFOFMyRHpzNBSUkwua8SlD3oIJlTlg4O6fhzxw
         QW+w==
X-Gm-Message-State: AOJu0YyCBxuFbyBHg7qyoJEZ5XueVeZg0zRSO1okDNkJP7UFUMF+WVj+
	Fp0m1FFHLT7Gfl3HtgGlRx5zgMLFa/C+xZkdIEY/EQfhKkIK+hYNU7S/32c+kF5lR8g=
X-Gm-Gg: AZuq6aJcWOgk2um6WgeTx4VBtaz6hpPxQDVHiYAIo3Re7041c7UynppTbzkkPHFy9bg
	+RerowwolAggfnFQJ1O8p+q/smmCDEi8Mh3uaBam0vnBl1G04h0GWFvqwIuszNLWtS9RECr8G3o
	VGAoNGDtZkj03kbtF3ovFB/3tXThxGQXZjWFOA3LAEt4IuG+9u+iXZzHKOXc8KePSf8OxcxnHz7
	W4++UOSrEYLrs6Gs0wZnhoctIP4Sk7njLsXqEHnn6IvoCA/3dkhmLGyZKAMzmZNE1M+RgazaYrs
	8njwrZipr7/1ohlN9dVSPROWG1wvoPJhip68JsT3D94cxkxC29rgjXHpXcWKoeA2SHWDVtkJ9oE
	vEMherLKSF2v+KJrSYJQJvBpOIcobyJW0s7rd2pqSPPwzaM0Rpqm/5kWJO6+CV2n211+1UpVkGD
	q8JM4h9/s3+Of/ZbjXt4UcpKd4QUDxPrY=
X-Received: by 2002:a05:6a20:d43:b0:393:5fcd:cec5 with SMTP id adf61e73a8af0-39545f7b08emr6929576637.58.1771867456515;
        Mon, 23 Feb 2026 09:24:16 -0800 (PST)
Received: from outpost.localdomain ([110.44.9.85])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c70b724321esm7802332a12.16.2026.02.23.09.24.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 09:24:16 -0800 (PST)
From: Jaskaran Singh <jsingh@cloudlinux.com>
To: stable@vger.kernel.org,
	james.smart@broadcom.com,
	kbusch@kernel.org,
	axboe@fb.com,
	hch@lst.de,
	sagi@grimberg.me
Cc: linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	gregkh@linuxfoundation.org,
	Jaskaran Singh <jsingh@cloudlinux.com>
Subject: [PATCH 6.1.y 1/2] Revert "nvme: nvme-fc: Ensure ->ioerr_work is cancelled in nvme_fc_delete_ctrl()"
Date: Mon, 23 Feb 2026 22:54:04 +0530
Message-Id: <20260223172405.292040-2-jsingh@cloudlinux.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260223172405.292040-1-jsingh@cloudlinux.com>
References: <20260223172405.292040-1-jsingh@cloudlinux.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260223_092417_677549_B47754B3 
X-CRM114-Status: GOOD (  11.64  )
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

This reverts commit 3d81beae4753db3b3dc5b70dc300d4036e0d9cb8.

The backport of upstream commit 0a2c5495b6d1 was incorrectly applied.
The cancel_work_sync() call for ->ioerr_work was added to
nvme_fc_reset_ctrl_work() instead of nvme_fc_delete_ctrl().

Signed-off-by: Jaskaran Singh <jsingh@cloudlinux.com>
---
 drivers/nvme/host/fc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index 63bef22095b4..9b5976c80803 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -3264,6 +3264,7 @@ nvme_fc_delete_ctrl(struct nvme_ctrl *nctrl)
 {
 	struct nvme_fc_ctrl *ctrl = to_fc_ctrl(nctrl);
 
+	cancel_work_sync(&ctrl->ioerr_work);
 	cancel_delayed_work_sync(&ctrl->connect_work);
 	/*
 	 * kill the association on the link side.  this will block
@@ -3334,7 +3335,6 @@ nvme_fc_reset_ctrl_work(struct work_struct *work)
 
 	/* will block will waiting for io to terminate */
 	nvme_fc_delete_association(ctrl);
-	cancel_work_sync(&ctrl->ioerr_work);
 
 	if (!nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_CONNECTING))
 		dev_err(ctrl->ctrl.device,
-- 
2.43.7


