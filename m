Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43BA8606A324
	for <linux-nvme@archiver.kernel.org>; Fri, 23 Oct 2026 10:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=buBAk5Iv;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=HufGYHA1
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Unsubscribe-Post:List-Owner;
	bh=t/XVWB9JGMXxVax5GCMXvBykzO5MzXEB215/VJtVKmY=; b=buBAk5Iv5d5VZ3Amhdlum2l5vy
	Eylt+wRrpeUWPJW7+klBRRRIczVmouvi9FQsbQ8K5OS++00Eg3DG3jv91Wr2DgbYCXlM1kFAHuzYz
	QtndmpfO/LVIKIC6uMb/s17Ah1Yh0dOyRc2oamPyJHDaPhAWPj3xDg7Otn609xiilJ7WdYRmWKcEq
	AyGy9TiNe79ZZxacdLuNuMPMtv9Wi1GMfr6ByhXj0WuTUKVwAVPzx2BsGtLYz5MzOfEbb4FlUsVol
	04PxuhevbGpI0PeCOVn6KdUUgV7sdRH6nsVQGih6L7Mul9USJbFlp+QSsu7cmIakCGB7duAPWYNRt
	/mqUbjSQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xKCM7-0000000G8X8-0Qer;
	Fri, 23 Oct 2026 10:18:35 +0000
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xKCM4-0000000G8WV-11AV
	for linux-nvme@lists.infradead.org;
	Fri, 23 Oct 2026 10:18:33 +0000
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-4a20bde60a0so5738785e9.3
        for <linux-nvme@lists.infradead.org>; Fri, 23 Oct 2026 03:18:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792750710; x=1793355510; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=t/XVWB9JGMXxVax5GCMXvBykzO5MzXEB215/VJtVKmY=;
        b=HufGYHA1QyqJn+ZpwSWnEuFtQsODo2YNPAWaU2mtMeH6d0tqBXXy6zrgOte5it8vN1
         tNyAyQGS4g2a0ZnFvME/ceDgKpt+qUmr1Grja2BlGFaZS8g+DCpGhpRLTLeDH6+FZGrQ
         g8oYpivcqclwD2DyXxGsAP/kUbI3REwkQQnwMA7/O6GZuSJ2L9gTsLnobs/ZGRftgPoz
         dQKT3NzJGuxK/fyfXv0iX7a+57cDq/BaFyTMjDh3S4gjixFVqdeqZUTiL1VyZl0bNvwM
         UbjQb3j1FaEZsER8yWXBjk65EPmficrppQ4inYAce4eqjKRothooVkufzXDBp/cVsvU9
         Juew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792750710; x=1793355510;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=t/XVWB9JGMXxVax5GCMXvBykzO5MzXEB215/VJtVKmY=;
        b=AtvEbqH1LxBh/Bhca+WD7Ft97Ed2AILh64Qs7IHb/Gyb7I6iCtA7oetjFZTpaFx0/F
         WqqG59kNjYyE9Sn67j6Z+Wa5wbPmgAxj8XPI6OtkWprOnyGtYKVaOYnzpMMdEswc8+E2
         7oaRqIrx0qNY5VkZ1qbTb3v6B6+5jBMngqS29TBZ5FNwixM8mDlnp6bSVBGv6MnWotoO
         ylWCKhiGYwqrFNdVsMbSyCtWwx2SFxXFEoM4/VoXlRxs6TJB2N2LsRzgy1zwBNeAIVM+
         IrkQryJoLdVTEY0ecBslIj1gkltH5THQCOIS2BFNKk9bjfshzBhJENObOuu6BtEnYsrR
         A6LQ==
X-Forwarded-Encrypted: i=1; AKwUvBytmBypuhtm+vODrjr/+/7hwPlQt4Nr12TUpWvDBSmuMbAntJFSY+eHn4qkROSuadjYIP7S8oyDDMGS@lists.infradead.org
X-Gm-Message-State: AFq9FYLeXq0Fgc3AQo9WATVzmTf1TFGKyqNaiaK4QpdzPma46HBFXHPu
	lQ8/0NjeDGlnAMOP8QRcAtPS7oRTQX0G7xc5/XKsPcnerEslfgS+oAAV
X-Gm-Gg: AYBFou2yb0iP8+CueN2KC+wQyg1Ipe5kopgkt8S4oVLNE7pCjoAmn7DHtDlMubE7VH7
	xit3eSCBT3oiMz40lVBxHRKUsYBwNYJ1HQXPj+uZ0c7OxXacWhQaZj6QmkJEg7Uxd/DkR8Oj5fz
	KF1PXOXujP75pq/BTr9zz8jhGTBhlUmD+1kJIee0hGTSXfgoSAC8dE3LXdP5bYl/WyjWYdq2lpA
	6Z6JRtkpIWwh8E0xz0Yz519f/dnv6b58vQR16cUt/jekB1a3UwNwmQu1x7VTdkKmf9biMrkgNep
	Z93cc8nmokG0stOBXBbrlCdRwO8vKEHEZYhX1EAWwgJX6m6e+KizSFE1Jnx6lt7NRM/E5WGUwNh
	jEvM4WxIP2zuLEafw97vhNisSCgg05njErnbBj/vkIZWCcRrpeFwY5j88Z7edNl2RNIkHBSXZqs
	6f/qd3yBxF92voz/qXxk6sMxGzF1GRS6Fh+7DmpljAFBXaLhg/rlw+JB9zfj0M4DDjObq4iZXND
	x+ANXUpY8M8i3Wqcus1WXAOyqjylZqsHs+larDRKrIngDZXdeuAKs1SMw==
X-Received: by 2002:a05:600c:8b32:b0:4a2:397:73e9 with SMTP id 5b1f17b1804b1-4a211ed726emr25539055e9.18.1792750709675;
        Fri, 23 Oct 2026 03:18:29 -0700 (PDT)
Received: from localhost ([205.147.201.218])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a211ba3ab5sm59959545e9.7.2026.10.23.03.18.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 03:18:28 -0700 (PDT)
From: Eduard Zateev <hackerowskiy@gmail.com>
To: kbusch@kernel.org
Cc: axboe@kernel.dk,
	hch@lst.de,
	sagi@grimberg.me,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Eduard Zateev <hackerowskiy@gmail.com>,
	syzbot+f4353e96f7004ae5a09e@syzkaller.appspotmail.com
Subject: [PATCH] nvme-pci: disable accessible controller on error paths
Date: Fri, 23 Oct 2026 12:18:25 +0200
Message-ID: <20261023101825.139040-1-hackerowskiy@gmail.com>
X-Mailer: git-send-email 2.55.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261023_031832_305328_6D8734AF 
X-CRM114-Status: GOOD (  14.25  )
X-Spam-Score: 1.2 (+)
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

nvme_dev_disable() skips nvme_disable_ctrl() when the controller reports
a fatal status or is not ready. PCI MMIO can still be accessible in this
state, allowing the controller to complete commands while the driver
cancels outstanding requests. This can race with blk-mq requeueing.

Separate PCI accessibility from controller health. Delete I/O queues
only for a healthy controller, but clear CC.EN whenever the PCI function
and channel remain accessible. Keep graceful shutdown and IRQ polling
limited to a healthy controller.

Reported-by: syzbot+f4353e96f7004ae5a09e@syzkaller.appspotmail.com
Link: https://syzkaller.appspot.com/bug?extid=f4353e96f7004ae5a09e
Assisted-by: LLM
Signed-off-by: Eduard Zateev <hackerowskiy@gmail.com>
---
 drivers/nvme/host/pci.c | 25 ++++++++++++++++++-------
 1 file changed, 18 insertions(+), 7 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 77317e5d00f..777615b4d25 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -3296,14 +3296,19 @@ static void nvme_dev_unmap(struct nvme_dev *dev)
 	pci_release_mem_regions(to_pci_dev(dev->dev));
 }
 
-static bool nvme_pci_ctrl_is_dead(struct nvme_dev *dev)
+static bool nvme_pci_ctrl_is_accessible(struct nvme_dev *dev)
 {
 	struct pci_dev *pdev = to_pci_dev(dev->dev);
+
+	return pci_is_enabled(pdev) && pci_device_is_present(pdev) &&
+		pdev->error_state == pci_channel_io_normal;
+}
+
+static bool nvme_pci_ctrl_is_dead(struct nvme_dev *dev)
+{
 	u32 csts;
 
-	if (!pci_is_enabled(pdev) || !pci_device_is_present(pdev))
-		return true;
-	if (pdev->error_state != pci_channel_io_normal)
+	if (!nvme_pci_ctrl_is_accessible(dev))
 		return true;
 
 	csts = readl(dev->bar + NVME_REG_CSTS);
@@ -3331,10 +3336,16 @@ static void nvme_dev_disable(struct nvme_dev *dev, bool shutdown)
 
 	nvme_quiesce_io_queues(&dev->ctrl);
 
-	if (!dead && dev->ctrl.queue_count > 0) {
+	if (!dead && dev->ctrl.queue_count > 0)
 		nvme_delete_io_queues(dev);
-		nvme_disable_ctrl(&dev->ctrl, shutdown);
-		nvme_poll_irqdisable(&dev->queues[0]);
+	if (dev->ctrl.queue_count > 0 && nvme_pci_ctrl_is_accessible(dev)) {
+		/*
+		 * Stop an accessible controller even if it reports itself dead.
+		 * Otherwise it may complete requests after they have been cancelled.
+		 */
+		nvme_disable_ctrl(&dev->ctrl, shutdown && !dead);
+		if (!dead)
+			nvme_poll_irqdisable(&dev->queues[0]);
 	}
 	nvme_suspend_io_queues(dev);
 	nvme_suspend_queue(dev, 0);
-- 
2.55.0


