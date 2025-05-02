Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63132C3ABAC
	for <linux-nvme@archiver.kernel.org>; Fri,  2 May 2025 09:17:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=8YuWhIIpW4YSF23jOWVtFJD6J52ObCvSZFLhHvvs3DY=; b=y6r9WyfLczgB8nEIPaNC+GVX7K
	H3JliMXC7iY4VK1ne0EHwM+rka+EMSWAr357HqZlk/uLF2D7j+Tinl5xeNwgGMKJEcSxdQIVbQREa
	E7LK8UMEYS709QemsLX0Ggz+YXGoqfYHCglcVwdR5CNOsjhqrzHMbgRjVQ3VJssf9pqlN8wITJYLT
	v9Cqb974cvWEvFe200EfkQ3XS67tdP9totu00M1Ylnr0+h2kr6PXvDObIIDRDtk19PtDH3JFWU/4i
	9h8q6hu3NZ1geJ0C0efTmUMyAXuZMkgkeG+qzIktC8sU7hRQxLSd1KF576/j+zoh9ljCzIz85OxpV
	BF3R1Rrw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uAmWf-00000001Jtt-0mvB;
	Fri, 02 May 2025 09:17:45 +0000
Received: from nyc.source.kernel.org ([147.75.193.91])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uAmDc-00000001GBF-3cZH
	for linux-nvme@lists.infradead.org;
	Fri, 02 May 2025 08:58:06 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 16D9BA4BBF0;
	Fri,  2 May 2025 08:52:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECC55C4CEE4;
	Fri,  2 May 2025 08:58:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746176283;
	bh=ZuiskJpGWxLu4eAPDCVIKrsFcyDHCI0/cLWzm/xfpgU=;
	h=From:Date:Subject:To:Cc:From;
	b=ZAaE7RbMned7hCMAWLGak6h15MF1eIy0ByRjIOVxbiI7o4WF7/Xh2BVjNdw4/uAVl
	 7KeN/fKxNky3V92sbLtvWMO6a/G7owtAJIEn5agB/iv0BGjLxas6W8K9rLCD/b49ZF
	 4ZuuGhvAtvrhvlPk/42PlT2wfU82ptJhIL8oJqSrI88jpVLhDsj6nyrZeOeenTmsbB
	 B/H92L8clzSteNApaASEUYxC+zTfin61AkB1EvmcT7Pz1utPmqNxacVua2QC46Ni5g
	 BlX7tFtJpX6VuVSEuQbljGkbaxf7Vzy6FLJnKCDDTv5qTtqX2Kt96FbhJizuEXUZLP
	 JraEh4uDUEvpw==
From: Daniel Wagner <wagi@kernel.org>
Date: Fri, 02 May 2025 10:58:00 +0200
Subject: [PATCH] nvme: unblock ctrl state transition for firmware update
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250502-nvme-fix-fw-update-v1-1-cd7a9f3031f7@kernel.org>
X-B4-Tracking: v=1; b=H4sIABeJFGgC/x2MuwqAMAwAf0UyG2gDdfBXxEFN1AxWaX1B6b9bH
 A/uLkGUoBKhrRIEuTXq7gvYuoJpHfwiqFwYyJAzzhD6exOc9cX5wevg4RS0rhmZDQnTCCU8ghT
 hn3Z9zh+ziGFrZAAAAA==
X-Change-ID: 20250502-nvme-fix-fw-update-156bdd02ed2b
To: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Guenter Roeck <linux@roeck-us.net>, Daniel Wagner <wagi@kernel.org>
X-Mailer: b4 0.14.2
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250502_015804_973161_A96D75B8 
X-CRM114-Status: GOOD (  13.98  )
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

The original nvme subsystem design didn't have a CONNECTING state; the
state machine allowed transitions from RESETTING to LIVE directly.

With the introduction of nvme fabrics the CONNECTING state was
introduce. Over time the nvme-pci started to use the CONNECTING state as
well.

Eventually, a bug fix for the nvme-fc started to depend that the only
valid transition to LIVE was from CONNECTING. Though this change didn't
update the firmware update handler which was still depending on
RESETTING to LIVE transition.

The simplest way to address it for the time being is to switch into
CONNECTING state before going to LIVE state.

Fixes: d2fe192348f9 ("nvme: only allow entering LIVE from CONNECTING state")
Reported-by: Guenter Roeck <linux@roeck-us.net>
Closes: https://lore.kernel.org/all/0134ea15-8d5f-41f7-9e9a-d7e6d82accaa@roeck-us.net
Reviewed-by: Keith Busch <kbusch@kernel.org>
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Daniel Wagner <wagi@kernel.org>
---
 drivers/nvme/host/core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index eb6ea8acb3cca7421d7fb218e51d855f2c056825..ac53629fce68d4c8c12cddc112986289eae79b43 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -4493,7 +4493,8 @@ static void nvme_fw_act_work(struct work_struct *work)
 		msleep(100);
 	}
 
-	if (!nvme_change_ctrl_state(ctrl, NVME_CTRL_LIVE))
+	if (!nvme_change_ctrl_state(ctrl, NVME_CTRL_CONNECTING) ||
+	    !nvme_change_ctrl_state(ctrl, NVME_CTRL_LIVE))
 		return;
 
 	nvme_unquiesce_io_queues(ctrl);

---
base-commit: ebd297a2affadb6f6f4d2e5d975c1eda18ac762d
change-id: 20250502-nvme-fix-fw-update-156bdd02ed2b

Best regards,
-- 
Daniel Wagner <wagi@kernel.org>


