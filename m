Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40043CA5FAD
	for <linux-nvme@archiver.kernel.org>; Wed, 30 Sep 2026 02:42:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=ZXAnOf/NZJgORhbHe0MffVtfrlsAlZFWtlHgqEl8yV0=; b=xg8EePy+GCREnD+ReiiZwSo9aR
	2+kfOuOJJL3d/n5L5IccStNnh350GDU4JemaIpDER+Gz/Nc9K+DWPFM/kD1biG8KcWs0EksAGNo7+
	u78DKOf6uSVar69fcSppYsx/yE1np5JgX1ugCpayUm5IXC23ln3beQ7lEaPPoBcOqIXAHUlTiN2Jv
	uNJ88xJaN7+FaYHZ46RUK4kniNCThN1mtKrU76jnF7r9Pyfyz24moJXmdbLhi7mcXkjhZuH90D2ud
	Vhc2HbtIDMTYLTGvDrGLpuz60J5TWZIGiVMpv4ue4xMvzZF//7GWluLzY0MR4BwMddw7O2wrTmmok
	y9oTPBNQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xBkHI-00000004vEZ-2So2;
	Wed, 30 Sep 2026 02:42:40 +0000
Received: from mail-dy2-x0f.google.com ([2607:f8b0:4864:36::f])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xBkHF-00000004vEA-3N1N
	for linux-nvme@lists.infradead.org;
	Wed, 30 Sep 2026 02:42:39 +0000
Received: by mail-dy2-x0f.google.com with SMTP id 5a478bee46e88-340f56c44b0so1955148eec.1
        for <linux-nvme@lists.infradead.org>; Tue, 29 Sep 2026 19:42:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=trailofbits.com; s=google; t=1790736157; x=1791340957; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ZXAnOf/NZJgORhbHe0MffVtfrlsAlZFWtlHgqEl8yV0=;
        b=eTikhJk/oXGvl1Z52esnoxzTB9iYD+x8GZ6mv/BcYUIvCw3sQJY313wJPDCo4Q0ZNo
         6e/CmVIK2kjKWlkDpMoUfmi5cKqn/v/OSAo7CmWIU/Su1LwgICIVLSveosalvx8UDe/T
         /gUR80WyF1F33RPAZO2HY38wP0tJcVE2wIgYxfv7kYEPemZ98eJShLgSDm1ZgVjkn917
         GTm8CPrBYGoKCabfuqFlqwqdwcQzmGmFKm/GQT38xv6n+f5UZ7ZcG6QQmvVCbPeFtpMi
         sRS0f8j4p7k4CbSWcyeUVw4oQXDYC81uYsEeBTS83hD2jFOeKrSfVSYYCsOWPFcJGNHe
         krtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790736157; x=1791340957;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZXAnOf/NZJgORhbHe0MffVtfrlsAlZFWtlHgqEl8yV0=;
        b=RsXhFOxISKOWgCrCnEBfqbyPIQk4n0hkNmcyKDIL+SVqnI084NbMOce6ktHLoOPIgD
         yl2g6eJu/irtUy+3iUnVW7sDwnNB/azkSKYYX7C6QLTawELSHwnFNDJkLPGi/O5+AWzJ
         GwkuNS5zq4KwCkAbAJvT6ixF0+r9rn23hQHcsUg0LQvtc//JecwXGSTYRsJGeG4Oqkxn
         SgUpxh7Tkxm9I4yQmNwJzGm4hCNYTPieV5AxQhvGhs/byD2fDMrUiH0jbigTYxnXP4Qf
         bbNiVtvCwjHHlRBGcxY0mktBxb1bLwMs6UK1WQ/UCP5H6XNVBd7EMySwjniD2HNbEEeN
         +DZA==
X-Forwarded-Encrypted: i=1; AKwUvBwBqzCP3GcryLjyzdQevSzwc8mC+Q6WJFhO40Mdwu1qVCTfzpv+s/nM+F1KQiSbJuvd+CW3oBaDTKVV@lists.infradead.org
X-Gm-Message-State: AFq9FYKpAfeLsBvrCswx/sDy7Md7jWwJw1ezKsimBbxlVslPCWjjGGzT
	RgX5se10jqWjtJLAPMvdqapexz5e2KN/8HFZ6F1vmCLRSMykaScPSzMkmVzZNE9/89A=
X-Gm-Gg: AYBFou1aeUUsih+f8tkh3sr6JOXYJHOD2TLoqFcKQw3lAJtXutjl9MgtEyYZzrHEr0N
	S8QqlopM267o5pLiG2qFUAtNRRioK4hywW25tquCoNZgFDH+UgDUSlx30gQRj6EPWBmBP/2A1TU
	QZau4hPVThUI1VMXDUrsYkkR7vKu+sZWgSteNUTK3lPWQlCE/ZDuCTaPswA5oQapqFaCuv3czYN
	gSMUBvQbirQxS208+ElHSZGFCr3X0jHw4S66tpdUUtC2Ubsg63MTsP9qhR2yKVSz4wueFfSuObH
	P96xB5Lcn9iYPeGR+paK8zLzQ20sIPrcLisuKAGwAwHKNpp7fSrOpgv+wO86hjYKCgxbQvWIgPG
	lnDZbZ/64UJqaCCKTiRY9/OkGsV1iOoFUhJ5Z7Dh0AONSnHGBScFCroBgtXBhp/L4vtA0P+5uJJ
	v7e0dSPvejFoGBSEuq8d3FaPIJvj7KpHulvbbhzHQBKQsGScnYs+TR/8fZFs4WPKFl/LnZt8PUI
	40sTcUeI2/XTy1BHidtln9iWWXeK5EA98YTlVL2Dq2FDX2fzw8CFKJ17l+W/7sV39vzg+6F
X-Received: by 2002:a05:693c:8954:20b0:33b:e75b:cc42 with SMTP id 5a478bee46e88-34cdc1ce146mr203864eec.19.1790736156602;
        Tue, 29 Sep 2026 19:42:36 -0700 (PDT)
Received: from localhost.localdomain ([2603:8001:5f01:8bab:3481:cbb6:f339:9e4e])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-34c386c2723sm2540580eec.18.2026.09.29.19.42.35
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 29 Sep 2026 19:42:36 -0700 (PDT)
From: Artem Dinaburg <artem@trailofbits.com>
To: stable@vger.kernel.org
Cc: Artem Dinaburg <artem@trailofbits.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	Chunguang Xu <chunguang.xu@shopee.com>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 6.6.y] nvme-fabrics: use reserved tag for reg read/write command
Date: Tue, 29 Sep 2026 22:42:31 -0400
Message-ID: <20260930024233.96200-1-artem@trailofbits.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260929_194237_846039_432823FE 
X-CRM114-Status: GOOD (  19.05  )
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

[ Upstream commit 7dc3bfcb4c9cc58970fff6aaa48172cb224d85aa ]

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

[ Backport to 6.6.y: used the older BLK_MQ_REQ_RESERVED request flag. ]

Signed-off-by: Chunguang Xu <chunguang.xu@shopee.com>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Keith Busch <kbusch@kernel.org>
Assisted-by: LLM
Signed-off-by: Artem Dinaburg <artem@trailofbits.com>
---
Hi Greg, Sasha, and nvme maintainers,

I am working through the small CVE backports still missing from 6.6.y.
This one addresses CVE-2024-41082. It reserves a request tag for
controller-register I/O during reconnect and reset.

The fix is already present in 6.12.y, 6.18.y, and 7.2.y, but not in 6.6.y.
This fix also affects 6.1.y, which will need a separate backport; this
submission contains only the 6.6.y patch.
The target-specific adjustment is recorded in the bracketed note above.

Could you please queue it for 6.6.y?

CVE: CVE-2024-41082
Upstream: 7dc3bfcb4c9cc58970fff6aaa48172cb224d85aa

AI assistance: An LLM helped identify, adapt, and validate this backport; I
reviewed the resulting code and validation evidence.

Thanks,
Artem Dinaburg

 drivers/nvme/host/fabrics.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
index fd01b86f10a4b0..8adcc8c97c42cf 100644
--- a/drivers/nvme/host/fabrics.c
+++ b/drivers/nvme/host/fabrics.c
@@ -179,7 +179,7 @@ int nvmf_reg_read32(struct nvme_ctrl *ctrl, u32 off, u32 *val)
 	cmd.prop_get.offset = cpu_to_le32(off);
 
 	ret = __nvme_submit_sync_cmd(ctrl->fabrics_q, &cmd, &res, NULL, 0,
-			NVME_QID_ANY, 0, 0);
+			NVME_QID_ANY, 0, BLK_MQ_REQ_RESERVED);
 
 	if (ret >= 0)
 		*val = le64_to_cpu(res.u64);
@@ -225,7 +225,7 @@ int nvmf_reg_read64(struct nvme_ctrl *ctrl, u32 off, u64 *val)
 	cmd.prop_get.offset = cpu_to_le32(off);
 
 	ret = __nvme_submit_sync_cmd(ctrl->fabrics_q, &cmd, &res, NULL, 0,
-			NVME_QID_ANY, 0, 0);
+			NVME_QID_ANY, 0, BLK_MQ_REQ_RESERVED);
 
 	if (ret >= 0)
 		*val = le64_to_cpu(res.u64);
@@ -270,7 +270,7 @@ int nvmf_reg_write32(struct nvme_ctrl *ctrl, u32 off, u32 val)
 	cmd.prop_set.value = cpu_to_le64(val);
 
 	ret = __nvme_submit_sync_cmd(ctrl->fabrics_q, &cmd, NULL, NULL, 0,
-			NVME_QID_ANY, 0, 0);
+			NVME_QID_ANY, 0, BLK_MQ_REQ_RESERVED);
 	if (unlikely(ret))
 		dev_err(ctrl->device,
 			"Property Set error: %d, offset %#x\n",
-- 
2.39.5


