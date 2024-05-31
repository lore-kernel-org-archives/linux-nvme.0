Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3114FC25B75
	for <linux-nvme@archiver.kernel.org>; Fri, 31 May 2024 09:24:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=mrKkBvog5oyiwqctC5TCQKtV++LMDGUX2RPtvKV8xCI=; b=vS8lcBA1zmQt76FryvzO6jzE3G
	jEypQBvy9vSzgHyNLcB76uEX88B15uESdk4RcoDBTL9wECZFxw+DBg2YH+8lj8NlT47tWFZylrl/N
	1rV8hnK0Lg3XYXTy9uigr7STKVeaPRT8bE+S0VgsYA6Rg+08BDbn4LZ8Gx3xvDEdbuf33LOtjVft2
	yg7xzRWAG2lpO4f8RUYxpCI2pUXEHmf0AEUPiE2rRP8zcl2C2BXxZs3ZB03Da0xaLjTFkwXa3wB65
	3eMfUWQ5XOjgMl4fzn3wH+Cb8Obcs1Q6V/xk3VbMfoRjmnrPXw2ngO8lTXJWVRtAS6XPHwF3LtTjb
	0deqXCtQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sCyUx-00000009mxP-1Jx7;
	Fri, 31 May 2024 09:24:31 +0000
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sCyUt-00000009mwS-0thn
	for linux-nvme@lists.infradead.org;
	Fri, 31 May 2024 09:24:29 +0000
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1f63642ab8aso4060905ad.3
        for <linux-nvme@lists.infradead.org>; Fri, 31 May 2024 02:24:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717147463; x=1717752263; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mrKkBvog5oyiwqctC5TCQKtV++LMDGUX2RPtvKV8xCI=;
        b=HChww3OWtkdAMjSdjz0sZzugedInFFnEalSqhWn7YmiNvwihrgBjY8J/OcwLsTGl7j
         OnV53VmXUN2d+5EHU9KtF+bWQ/TihI8wk5JKHZqj6q/7xdAFG8kCXV1Le3kE7JBudiiq
         4bdrlWmun330UjM6Z+GRA01Xe7e+R1uXblCB0gJubyJRrorFRZvwkfnSsRv9xs+e9lR4
         +wU1Yc3IyeovYLZR2Bchag+GaVQujIKzvUppGi5HTQPMJMYkSJSs2uF98xbIXfeiWG1N
         j7pOVcwpAgBA3a0KJ3P21Z+nOFxIZS0Lc9dvdJtCja1fkvT5q6+bL3RTpXbBobrs1eoZ
         yjdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717147463; x=1717752263;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mrKkBvog5oyiwqctC5TCQKtV++LMDGUX2RPtvKV8xCI=;
        b=Hiqpao2rFJHQvWJem9MAxNaR5Cww4YJ4bfZzLaVkNCWFeHw6l//MgNhrxtQWESgx4i
         s7z9C5c2IoQwfB2gh1u+pXJykRVhp8BFBU/voEVWL2gzGgkeNWG1JiHbthcNHaAKkBoH
         NahPZuj6YnvDH4NVEsF7+NVbUuoba8g2WbfJ0s/MvyIaXBo/DL+sX/N6hEyKz41KqadO
         UksMKW+ouXSf4Nj0UCPU9AKTbwwrz+jR4eFb3EhK7LqzHODQ9sfEkmm5Jfp1/mj2PfIk
         a0HuvkhhO7hmN+Dz8ovUM8LbjQ9v81apDgUbAg9Xd0NZvxGsNap55EyS/kYcpIl7UWz+
         bMzQ==
X-Gm-Message-State: AOJu0Yw6We3ZuktUq10Z4Un3GzZNwylHFKBgQkU6SARXk/NDQZsJQVuG
	724QxsfpzMW1gn1/IGUhmRqDSsG1AShNc/daNLTBUKX5hz0RR49y
X-Google-Smtp-Source: AGHT+IE6gGq+eCrjF3uWKXdUrVl9nCO1Z75cjEF8h5pRBPogQzDAKCEb/EdSACkI92nCASHWM37d5g==
X-Received: by 2002:a17:903:1249:b0:1f4:b858:5fe7 with SMTP id d9443c01a7336-1f6370cefbbmr14952105ad.61.1717147462737;
        Fri, 31 May 2024 02:24:22 -0700 (PDT)
Received: from localhost.localdomain ([143.92.64.17])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f6323dde85sm11870975ad.149.2024.05.31.02.24.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 May 2024 02:24:21 -0700 (PDT)
From: "brookxu.cn" <brookxu.cn@gmail.com>
To: kbusch@kernel.org,
	axboe@kernel.dk,
	hch@lst.de,
	sagi@grimberg.me,
	kch@nvidia.com
Cc: linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [RESEND PATCH] nvme-fabrics: use reserved tag for reg read/write command
Date: Fri, 31 May 2024 17:24:21 +0800
Message-Id: <20240531092421.317296-1-brookxu.cn@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240531_022428_113652_2E964386 
X-CRM114-Status: GOOD (  12.93  )
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

In some scenarios, if too many commands are issued by nvme command in
the same time by user tasks, this may exhaust all tags of admin_q. If
a reset (nvme reset or IO timeout) occurs before these commands finish,
reconnect routine may fail to update nvme regs due to insufficient tags,
which will cause kernel hang forever. In order to workaround this issue,
maybe we can let reg_read32()/reg_read64()/reg_write32() use reserved
tags. This maybe safe for nvmf:

1. For the disable ctrl path,  we will not issue connect command
2. For the enable ctrl / fw activate path, since connect and reg_xx()
   are called serially.

So the reserved tags may still be enough while reg_xx() use reserved tags.

Signed-off-by: Chunguang Xu <chunguang.xu@shopee.com>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>

---
 drivers/nvme/host/fabrics.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
index 1f0ea1f32d22..f6416f8553f0 100644
--- a/drivers/nvme/host/fabrics.c
+++ b/drivers/nvme/host/fabrics.c
@@ -180,7 +180,7 @@ int nvmf_reg_read32(struct nvme_ctrl *ctrl, u32 off, u32 *val)
 	cmd.prop_get.offset = cpu_to_le32(off);
 
 	ret = __nvme_submit_sync_cmd(ctrl->fabrics_q, &cmd, &res, NULL, 0,
-			NVME_QID_ANY, 0);
+			NVME_QID_ANY, NVME_SUBMIT_RESERVED);
 
 	if (ret >= 0)
 		*val = le64_to_cpu(res.u64);
@@ -226,7 +226,7 @@ int nvmf_reg_read64(struct nvme_ctrl *ctrl, u32 off, u64 *val)
 	cmd.prop_get.offset = cpu_to_le32(off);
 
 	ret = __nvme_submit_sync_cmd(ctrl->fabrics_q, &cmd, &res, NULL, 0,
-			NVME_QID_ANY, 0);
+			NVME_QID_ANY, NVME_SUBMIT_RESERVED);
 
 	if (ret >= 0)
 		*val = le64_to_cpu(res.u64);
@@ -271,7 +271,7 @@ int nvmf_reg_write32(struct nvme_ctrl *ctrl, u32 off, u32 val)
 	cmd.prop_set.value = cpu_to_le64(val);
 
 	ret = __nvme_submit_sync_cmd(ctrl->fabrics_q, &cmd, NULL, NULL, 0,
-			NVME_QID_ANY, 0);
+			NVME_QID_ANY, NVME_SUBMIT_RESERVED);
 	if (unlikely(ret))
 		dev_err(ctrl->device,
 			"Property Set error: %d, offset %#x\n",
-- 
2.25.1


