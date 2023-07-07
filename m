Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0490C001B0
	for <linux-nvme@archiver.kernel.org>; Fri,  7 Jul 2023 21:22:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qePnr6uiJhFW8uqqgQKYEeqUN+FbLijUv9XlnK/VDqc=; b=HjLG1q7+NQ4VdMaUeU9/kX6wzb
	ENbJR6VDSwVwYtyQdLIXbOBqKXMJsXHqUcS2zKynJ6yCmlSFOGjJoIGqCquG98zR2HZhpSNIhYlW6
	uuOWg/J1Xh1fZPXJXtP5T4Yhk8F7jgDAvKI2qtX0CApGLfr77dOflcMIqlt+PQNuFiq2SnosGcpLN
	hRPp5Qd/qSzWAAU+6FPnz+V7Cc414XsU0GsQVezXkCSd+KYKUZoQTcDIEhFXls3nA4b6y9haosKAL
	0RoaiG0+b7SDL3A68apudlAFESyBIwPDPzIvwpLvI6rWwMqxA0jSxIAbTTMkrm10Ne9DrOxNZPbCC
	WK6h/pyA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qHsu8-005ig9-1J;
	Fri, 07 Jul 2023 21:22:16 +0000
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qHsu5-005ifC-19
	for linux-nvme@lists.infradead.org;
	Fri, 07 Jul 2023 21:22:15 +0000
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-666e6541c98so1924538b3a.2
        for <linux-nvme@lists.infradead.org>; Fri, 07 Jul 2023 14:22:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1688764931; x=1691356931;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qePnr6uiJhFW8uqqgQKYEeqUN+FbLijUv9XlnK/VDqc=;
        b=Z2H0Ut4vA9+F1aIiTD+LqyluKeIcn2sC8kxO/vJyJaTR03h9qiC0F/E2ScVec4zNWT
         t5cejQKXq1m0kyINfzC/pAhImHPvmKMyO5uMLHRCYfqBwUNn0Mo4QPZd61j3JEnLDzcC
         9z71YqCBe+6nAd6+nnsltetsaIm6Gh/VFoIHpHzG504iWu9It4+gaXlz3GxP2V9BmGOV
         fUCNGjfJZYYaaAFlTHUsuG2KoTmkbs0R0oKJhqru5A7DQa1rZXjD/UG8bGfZ/3WtJjrh
         gyNN9fgMjLAqqQK0zWPJmzCUutqzCsWJQEgRKnlNzLy10Arkodtu5gLA+jZ8IIJel34C
         JCgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688764931; x=1691356931;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qePnr6uiJhFW8uqqgQKYEeqUN+FbLijUv9XlnK/VDqc=;
        b=GiuzIk6sJIYTxLv2+uV3g/RZgj65sQD1oAeACXVxzZc3RXDX959Cr1Xt901ApH6C1l
         fCj5R3r0tqEExzypFu++OdO5opqirVxyeytZhYtIFU8/TS+jjM9WHPMSOnpSlw5A8rTM
         UzZI5VE1XDUMmPd+nKm5sHtv8AsiV91OCrsUN5VRsQmR1Nvi1toT2Fywb3CYLDJvm16V
         xiDJfGGKRTV0S77NPFeOzuJgOXvRw/uztLAcN6ahfFfHgeGqEs6aKkC9pxyra0euV59Z
         W2ayFprrhuw4YVkLuW7TZpEF42dEf4b34kRbq7yDjSM+adVvH8YbX7LY+J4gIo+PVEP0
         MsEg==
X-Gm-Message-State: ABy/qLbT9xxEOM2E4kW+VfbBuQZsSAGmhR8B7L7+T7u+t/MNKyGbbmM+
	iJ19p3rw/DnT5V3hGGuEcRy11aXzjwbSeQhZwzMRcapWBiewIjlwVvT4zj7RannjZQblp/qED8B
	H7R8r3OBZtRuX9FiqGtIlEEtDoC7q9lpcVzeSwjTWAXryr9fEQ2zS5L3EPaWLsEXzWbHiz76rCG
	RVHxpURfiC2NPY
X-Google-Smtp-Source: APBJJlFdCAw2n6Ll+WuReBa6gK3YZ1X9/cnpUyysQ088csYTm2pJrCRAMaGyMoAne8ilM09fce0/SA==
X-Received: by 2002:a05:6a20:938b:b0:12f:d350:8a05 with SMTP id x11-20020a056a20938b00b0012fd3508a05mr6389762pzh.39.1688764930934;
        Fri, 07 Jul 2023 14:22:10 -0700 (PDT)
Received: from dev-mliang.dev.purestorage.com ([208.88.159.128])
        by smtp.gmail.com with ESMTPSA id fm15-20020a056a002f8f00b006828ee9fdaesm3274967pfb.127.2023.07.07.14.22.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jul 2023 14:22:10 -0700 (PDT)
From: Michael Liang <mliang@purestorage.com>
To: linux-nvme@lists.infradead.org,
	jsmart2021@gmail.com
Cc: randyj@purestorage.com,
	csander@purestorage.com,
	ushankar@purestorage.com,
	psajeepa@purestorage.com,
	Michael Liang <mliang@purestorage.com>
Subject: [PATCH 1/2] nvme-fc: return non-zero status code when fails to create association
Date: Fri,  7 Jul 2023 15:21:56 -0600
Message-Id: <20230707212157.1158725-2-mliang@purestorage.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230707212157.1158725-1-mliang@purestorage.com>
References: <20230707212157.1158725-1-mliang@purestorage.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230707_142213_916604_0E5D53B9 
X-CRM114-Status: GOOD (  10.13  )
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

Return non-zero status code(-EIO) when needed, so re-connecting or
deleting controller will be triggered properly.

Signed-off-by: Michael Liang <mliang@purestorage.com>
Reviewed-by: Caleb Sander <csander@purestorage.com>
---
 drivers/nvme/host/fc.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index 691f2df574ce..ad9336343e01 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -2551,6 +2551,9 @@ nvme_fc_error_recovery(struct nvme_fc_ctrl *ctrl, char *errmsg)
 	if (ctrl->ctrl.state == NVME_CTRL_CONNECTING) {
 		__nvme_fc_abort_outstanding_ios(ctrl, true);
 		set_bit(ASSOC_FAILED, &ctrl->flags);
+		dev_warn(ctrl->ctrl.device,
+			"NVME-FC{%d}: transport error during (re)connect\n",
+			ctrl->cnum);
 		return;
 	}
 
@@ -3110,7 +3113,9 @@ nvme_fc_create_association(struct nvme_fc_ctrl *ctrl)
 	 */
 
 	ret = nvme_enable_ctrl(&ctrl->ctrl);
-	if (ret || test_bit(ASSOC_FAILED, &ctrl->flags))
+	if (!ret && test_bit(ASSOC_FAILED, &ctrl->flags))
+		ret = -EIO;
+	if (ret)
 		goto out_disconnect_admin_queue;
 
 	ctrl->ctrl.max_segments = ctrl->lport->ops->max_sgl_segments;
@@ -3120,7 +3125,9 @@ nvme_fc_create_association(struct nvme_fc_ctrl *ctrl)
 	nvme_unquiesce_admin_queue(&ctrl->ctrl);
 
 	ret = nvme_init_ctrl_finish(&ctrl->ctrl, false);
-	if (ret || test_bit(ASSOC_FAILED, &ctrl->flags))
+	if (!ret && test_bit(ASSOC_FAILED, &ctrl->flags))
+		ret = -EIO;
+	if (ret)
 		goto out_disconnect_admin_queue;
 
 	/* sanity checks */
@@ -3165,7 +3172,9 @@ nvme_fc_create_association(struct nvme_fc_ctrl *ctrl)
 		else
 			ret = nvme_fc_recreate_io_queues(ctrl);
 	}
-	if (ret || test_bit(ASSOC_FAILED, &ctrl->flags))
+	if (!ret && test_bit(ASSOC_FAILED, &ctrl->flags))
+		ret = -EIO;
+	if (ret)
 		goto out_term_aen_ops;
 
 	changed = nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_LIVE);
@@ -3180,6 +3189,9 @@ nvme_fc_create_association(struct nvme_fc_ctrl *ctrl)
 out_term_aen_ops:
 	nvme_fc_term_aen_ops(ctrl);
 out_disconnect_admin_queue:
+	dev_warn(ctrl->ctrl.device,
+		"NVME-FC{%d}: create_assoc failed, assoc_id %llx ret %d\n",
+		ctrl->cnum, ctrl->association_id, ret);
 	/* send a Disconnect(association) LS to fc-nvme target */
 	nvme_fc_xmt_disconnect_assoc(ctrl);
 	spin_lock_irqsave(&ctrl->lock, flags);
-- 
2.34.1


