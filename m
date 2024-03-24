Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF607C6FD1F
	for <linux-nvme@archiver.kernel.org>; Sun, 24 Mar 2024 17:07:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=RCrTOeGK2U2LiUabkjX9ZBunFMExC6xWVq3H0lZkDkA=; b=kzrY/l2pwUW3AvRVmdnTX0FQ1H
	Vjhu8a6uqqUsPCifaQIeKXFZNhgycxwpIurBsjkj0NkImeeX4yXmZcORiLe/l86JVTtB59GZicPbl
	/KE/WIO4N8tdu2bN/2QM0lMqgrkOXxLn17QkZiceXjJAdidxu0KwnVvWi3tKyaThJpzoSvNPVlIzl
	vDGIzf62JbPeW3mAw7OnhMUCgj3UoX7oTzrKDQmJP3LWl+Ax9deRY09r53qTLWd1N9sG2wgiU2GH/
	ukwyK7PJxF065gTi6hXXZXq0UE4inZsyXy920LVF41s5zNR/LDOpsyXKLcSaDtaEmiDWyU/UvIZM8
	0y5OI3Ng==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1roRJO-0000000D1iP-1wRC;
	Sun, 24 Mar 2024 17:07:10 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1roRJL-0000000D1h2-1cyo
	for linux-nvme@lists.infradead.org;
	Sun, 24 Mar 2024 17:07:08 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 6919C60C8C;
	Sun, 24 Mar 2024 17:07:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36E67C433B1;
	Sun, 24 Mar 2024 17:07:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711300026;
	bh=RDb3xLJ5GXEXzKnyGjx42fYqsVclF72OeRAWNWggeaI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dlZbe3HoOwfgkUQrzWMtCjcWMfmJYRTrmM+kFXSWtOlC+P0ctjRCsRNvItoa65Aco
	 ri82Ryae63oGJMChzikWAh2JH6t8YU0QG0fOa04G7sv43Gc82ccIWlytGOsiHRAImD
	 fNmUrL6DPTv3CwHaOZ8pEXjoIVTDAP+tNCg6QL1661+F3E/PXpBsbf1cLeu8hK1KKB
	 ZpLyrsBCh57xtj1SCxfLsqnaxqy0PdVdBpVPI+Fg6NA371z0mHrDcxEcHbCNbEwjBN
	 TlLI+9f5sUw10weQ/WILTMGFEiF+BejJJ6nsUzVuTdPcxy2/fVszucoiyB58P46pjz
	 2nbD8ABI9NabA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Sasha Levin <sashal@kernel.org>,
	sagi@grimberg.me,
	linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 6.6 11/11] nvme: clear caller pointer on identify failure
Date: Sun, 24 Mar 2024 13:06:41 -0400
Message-ID: <20240324170645.546220-11-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324170645.546220-1-sashal@kernel.org>
References: <20240324170645.546220-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.22
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240324_100707_509919_004265E2 
X-CRM114-Status: GOOD (  12.61  )
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

From: Keith Busch <kbusch@kernel.org>

[ Upstream commit 7e80eb792bd7377a20f204943ac31c77d859be89 ]

The memory allocated for the identification is freed on failure. Set
it to NULL so the caller doesn't have a pointer to that freed address.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/core.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index d4564a2517eb5..63d9ec076792a 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1333,8 +1333,10 @@ static int nvme_identify_ctrl(struct nvme_ctrl *dev, struct nvme_id_ctrl **id)
 
 	error = nvme_submit_sync_cmd(dev->admin_q, &c, *id,
 			sizeof(struct nvme_id_ctrl));
-	if (error)
+	if (error) {
 		kfree(*id);
+		*id = NULL;
+	}
 	return error;
 }
 
@@ -1463,6 +1465,7 @@ static int nvme_identify_ns(struct nvme_ctrl *ctrl, unsigned nsid,
 	if (error) {
 		dev_warn(ctrl->device, "Identify namespace failed (%d)\n", error);
 		kfree(*id);
+		*id = NULL;
 	}
 	return error;
 }
-- 
2.43.0


