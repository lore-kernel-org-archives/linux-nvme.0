Return-Path: <SRS0=n/mE=MT=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02D30C4338F
	for <linux-nvme@archiver.kernel.org>; Tue, 27 Jul 2021 16:41:15 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B5F5961037
	for <linux-nvme@archiver.kernel.org>; Tue, 27 Jul 2021 16:41:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org B5F5961037
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=UPAmnPBn8XIiyoUOZa3Naivn3x32ClSwmWKgUKw9J4g=; b=oQbLjy8wK99ArM
	KadxECJfcRPWTKdNmAq+2vFm9NdSr54v0g7QhvTwQZgRXwdqHOSt6qGnvucQGjuUsuCJ2WJsYHrRM
	pelHH1mSNfyT0mqusiNfAlUL/UtX7kTWpz7Gbi3ADWblmNQ4EDdagGQU6DZyyFw3nd38HuV1XUFcT
	x2l+n/cc5/ZpAc6uYum3Ctryd/5w88YrMv/etiLH8gcR1hNj4uQs/I3R4XNQbvXKxVY6ByuGgChqO
	9Gk4xUtau4W+uFi60bKCMGjdPs7u8vSicZj//SgMdMHGVMgaTHqX+a09N14VxMU5D8DQPWre+nrrd
	BevUoakNyp+9cL4OA+Ig==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1m8Q8Z-00FP3d-G0; Tue, 27 Jul 2021 16:40:59 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1m8Q8M-00FP1Z-Sp
 for linux-nvme@lists.infradead.org; Tue, 27 Jul 2021 16:40:48 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3EA4A60551;
 Tue, 27 Jul 2021 16:40:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1627404046;
 bh=XigEvdU9y0nJEvkVjWutOq/QYbMJIxIgEc0j40yJmVo=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=FPJbUP1oHHTDrbkJZHlg/ZnWpR7nMOJ5+9kJAxtzvQIrRkhHcxj0b7DEXgvfsCQUu
 YFJ+eBdKYelMjKbAbrW0BzVhl3VzCST6h6x9iSD+sU8IiHh9m8IcPbKEHG1j6OyCou
 jV/qGiSnz3ANlIV4KkkptzrjP7HSTo7lncilolqRI/oLGKZt46sO4hs5Q8+AWL7vqs
 fJUnj2iJEj+56nqVpnG28EIw9IvQeU420HbLuqwz7mkMPeZ8dSKz02Ui4riQuP4g4M
 vw8QL74dlGMnIr+ZX+zcc1R6MNkRpQPEJ/VM6lbUmsmM879rgbaR/lzGHslmjWhRPP
 OKMHNE15jcz4Q==
From: Keith Busch <kbusch@kernel.org>
To: linux-nvme@lists.infradead.org,
	hch@lst.de
Cc: sagi@grimberg.me, kai.heng.feng@canonical.com,
 Keith Busch <kbusch@kernel.org>
Subject: [PATCH 2/2] nvme-pci: disable hmb on idle suspend
Date: Tue, 27 Jul 2021 09:40:44 -0700
Message-Id: <20210727164044.2285364-2-kbusch@kernel.org>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20210727164044.2285364-1-kbusch@kernel.org>
References: <20210727164044.2285364-1-kbusch@kernel.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210727_094046_985157_4FC272F6 
X-CRM114-Status: GOOD (  19.29  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

An idle suspend may or may not disable host memory access from devices
placed in low power mode. Either way, it should always be safe to
disable the host memory buffer prior to entering the low power mode, and
this should also always be faster than a full device shutdown.

Cc: Kai-Heng Feng <kai.heng.feng@canonical.com>
Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/nvme/host/pci.c | 24 +++++++++++++++++-------
 1 file changed, 17 insertions(+), 7 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index e8f3b32131d2..42d4cbe31a28 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -3130,8 +3130,13 @@ static int nvme_resume(struct device *dev)
 
 	if (ndev->last_ps == U32_MAX ||
 	    nvme_set_power_state(ctrl, ndev->last_ps) != 0)
-		return nvme_try_sched_reset(&ndev->ctrl);
+		goto reset;
+	if (ctrl->hmpre && nvme_setup_host_mem(ndev))
+		goto reset;
+
 	return 0;
+reset:
+	return nvme_try_sched_reset(ctrl);
 }
 
 static int nvme_suspend(struct device *dev)
@@ -3155,15 +3160,9 @@ static int nvme_suspend(struct device *dev)
 	 * the PCI bus layer to put it into D3 in order to take the PCIe link
 	 * down, so as to allow the platform to achieve its minimum low-power
 	 * state (which may not be possible if the link is up).
-	 *
-	 * If a host memory buffer is enabled, shut down the device as the NVMe
-	 * specification allows the device to access the host memory buffer in
-	 * host DRAM from all power states, but hosts will fail access to DRAM
-	 * during S3.
 	 */
 	if (pm_suspend_via_firmware() || !ctrl->npss ||
 	    !pcie_aspm_enabled(pdev) ||
-	    ndev->nr_host_mem_descs ||
 	    (ndev->ctrl.quirks & NVME_QUIRK_SIMPLE_SUSPEND))
 		return nvme_disable_prepare_reset(ndev, true);
 
@@ -3174,6 +3173,17 @@ static int nvme_suspend(struct device *dev)
 	if (ctrl->state != NVME_CTRL_LIVE)
 		goto unfreeze;
 
+	/*
+	 * Host memory access may not be successful in a system suspend state,
+	 * but the specification allows the controller to access memory in a
+	 * non-operational power state.
+	 */
+	if (ndev->hmb) {
+		ret = nvme_set_host_mem(ndev, 0);
+		if (ret < 0)
+			goto unfreeze;
+	}
+
 	ret = nvme_get_power_state(ctrl, &ndev->last_ps);
 	if (ret < 0)
 		goto unfreeze;
-- 
2.25.4


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
