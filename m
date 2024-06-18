Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E416C2BB85
	for <linux-nvme@archiver.kernel.org>; Tue, 18 Jun 2024 12:37:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Gh1ftcBSctjyJfZ4Tmcg0C9iZKXNIXoK6IQhyYBBr7s=; b=UmtRWB7pV0qllXTinr8Hsgbg5A
	JbqdWxB+u5d9cUihPG7GUdIcEkmb5ZlNlrNEWC6lCUSTTSe70J8zJeDfq3BHWqToRLVrqB3FvU11Y
	yBSW8na0P0WkGnaYU/3V37zSsiOi0GHJLCtLDK4cnDKS8J4yoLu6Bi/e+OpvnqKg2gq8OuFnNSiYq
	Wah3e+ECQ7v5xFtC//IH1NLmfiUjCdX+hTcgwzDraKS4/a3c//uFME/6fANEknUhhorD0OGPq4YgH
	z/KDvG/EDQ8BTJ/ouSh8h3MEqKYbQlpiONTVUX3YMqC858vOnUkkKQH6AMc3YTECCcoSCEByax8dV
	4aXljWyA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sJY5d-0000000EuF4-4AIs;
	Tue, 18 Jun 2024 12:37:33 +0000
Received: from sin.source.kernel.org ([2604:1380:40e1:4800::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sJY5Z-0000000EuDQ-2plg
	for linux-nvme@lists.infradead.org;
	Tue, 18 Jun 2024 12:37:31 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id AA882CE1B14;
	Tue, 18 Jun 2024 12:37:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E794AC32786;
	Tue, 18 Jun 2024 12:37:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718714247;
	bh=YNwSeyUWooZMAG25GZh73ttHKehOSMr/3V06jP+H6BM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=J8wzSns31YlXmj41FMd5QHwEajY48U5u5RMNqXkSRyDN/y/cmY6/HA19wLkHRmaBL
	 Ilhx1UycLO4ejfxHVX/WudX8bX/PLzjrTzZdY6taCIl1iYwZrl4FW64iaXxuGNsk5F
	 mjYwM+HvDcWGIp3l1ETZT0pS+bTK/yQF2BYGr5YQ2xaQ2OQ3NYcrPaDUypBx+Ix0Zq
	 X8WGcyCSw9HUs0QGJhR5/VmSeDHTBg+ZmBCv17W1OhB4K6fwpkAdaY3SPllkjeLA4P
	 hUEdxSCUv9UQ7DtLnPoerqjqpCN4Gvhxycmgl1ESlTe4Gq0kaEPlXSAPv50NePuIV6
	 HnW9ASwDQ772w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Chunguang Xu <chunguang.xu@shopee.com>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 6.9 30/44] nvme-fabrics: use reserved tag for reg read/write command
Date: Tue, 18 Jun 2024 08:35:11 -0400
Message-ID: <20240618123611.3301370-30-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240618123611.3301370-1-sashal@kernel.org>
References: <20240618123611.3301370-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.9.5
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240618_053730_074929_90402046 
X-CRM114-Status: GOOD (  12.97  )
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

Signed-off-by: Chunguang Xu <chunguang.xu@shopee.com>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/fabrics.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
index 1f0ea1f32d22f..f6416f8553f03 100644
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
2.43.0


