Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B474D606A326
	for <linux-nvme@archiver.kernel.org>; Fri, 27 Nov 2026 10:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=wchv+PlF;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=pc-heini.de header.i=@pc-heini.de header.a=rsa-sha256 header.s=default2410 header.b=dFvqVOY1
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=Mz0uhk3OFWJ0FNh9q5bukOUzm++jVY5/KHluP5c0a2Q=; b=wchv+PlFYk6jCF
	9CetO5LeEdQuYMrQWd0WxB954LCt0PX6FJ5MX8/sL656CJHGzAaZgj8wXZFMbQRSari2gkoHNjf3X
	Q6bYCkOxjOKtnePAVStVXk3Yq1VMzyR4AJC9JofRwpFX72MTTMCFKAUDvO1G9IBeIiO4R/F6WSqY2
	vmcHJrLxrtM3hYYoMRzDz4xFRoFJBs/tHCfptqxWvZWgbwPz7GkiNoOhNUrtGpuTwIuHth9YoD8/i
	UhvVyIefm9vIrtvbfxHTIql69rvuUrZSF4hlJRyh4x/2BjdG+wjoO/6dbYZSkgxow3zm0pDOp/iEi
	8In6r+UqTT7347IP2ZNA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xWtVv-0000000Ffbj-0tsq;
	Fri, 27 Nov 2026 10:49:11 +0000
Received: from www636.your-server.de ([168.119.26.116])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xWtVo-0000000FfN8-1mq1
	for linux-nvme@lists.infradead.org;
	Fri, 27 Nov 2026 10:49:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=pc-heini.de
	; s=default2410; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID;
	bh=Mz0uhk3OFWJ0FNh9q5bukOUzm++jVY5/KHluP5c0a2Q=; b=dFvqVOY1av0BLvIqCNUD8yPs/l
	sJhmj9kgosEvNGJfRUua7o+XkJ6I2hPhWQCNM4TQZeWiQ8EshgaQzvSA61bwUXSqWogAeymhuvjoX
	6EDR2P9VVInQmCZmMIGhSI9vYw7udHHFXUwKVcGv2OutwrnHwvcT1n/5mCtscV6UCOwR1Fejimc+t
	LTW3R0mVPLerL2298OcFF+N06eXGzVWwUgYBVTnD0I6ESR8ul9Eu9uccV9r/zrGCHhpkZR2XJ2jzk
	gr4CsLLjyH/5fdsf4KCZHleStmqqFzNQqbpvNS/FiFOkeh52D6E0mB6/gHoZ4Xpwzu8U6j0diiKoM
	0p+kDg4g==;
Received: from sslproxy06.your-server.de ([78.46.172.3])
	by www636.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <m.hiller@pc-heini.de>)
	id 1xWtVg-0004Xw-1P;
	Fri, 27 Nov 2026 11:48:56 +0100
Received: from localhost ([127.0.0.1])
	by sslproxy06.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <m.hiller@pc-heini.de>)
	id 1xWtVg-0008AK-0A;
	Fri, 27 Nov 2026 11:48:56 +0100
From: Moritz Hiller <m.hiller@pc-heini.de>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: Moritz Hiller <m.hiller@pc-heini.de>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	linux-nvme@lists.infradead.org,
	linux-pci@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] nvme-pci: wait for MMIO to come back after resume from suspend
Date: Fri, 27 Nov 2026 11:46:21 +0100
Message-ID: <20261127104637.219891-1-m.hiller@pc-heini.de>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261120180814.GB1810@lst.de>
References: <598ee2b4-32aa-4ad3-99c7-db7f9a7e7736@pc-heini.de> <20261120180814.GB1810@lst.de>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.4.6/28194/Wed Nov 25 07:26:59 2026)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261127_024904_863969_186F6478 
X-CRM114-Status: GOOD (  27.54  )
X-Spam-Score: -2.1 (--)
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
X-Spam-Status: No, score=-16.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On an ASUS ROG STRIX X570-F GAMING (BIOS 5044) with a Samsung 9100 PRO
attached directly to a CPU root port, the root NVMe drive sporadically
does not come back after resume from S3 (roughly 5-10% of resumes):

  nvme nvme0: Disabling device after reset failure: -19

The single readl() of CSTS in nvme_pci_enable() returns all-ones about
200 ms after resume. At that point config space answers, the link is
up, the device is in D0 and there are no AER errors. The controller is
not dead, it just needs a few hundred milliseconds longer before its
MMIO space responds.

The platform apparently removes power from the device during S3 while
the PCI core still treats it as D3hot. pci_power_up() finds PMCSR
already in D0 and does not wait, and pci_bridge_wait_for_secondary_bus()
only runs after D3cold and only checks config space, so nothing waits
for MMIO to come back.

Move the CSTS check into a helper. If CSTS reads all-ones and the
controller was shut down for suspend (NVME_CC_SHN_NORMAL still set in
ctrl_config, the same test nvme_reset_work() uses), poll CSTS every
100 ms for up to 10 s while the device is still present. Controllers
that answer on the first read, probe and other resets are not affected.

Without the patch, 4 of 39 automated S3 cycles on the machine above
failed. With it, none of 45 failed (30 on a v7.3.4 based kernel, 15 on
v7.4-rc2), and whenever the wait triggered the controller answered
after 200-400 ms. This version has been running on the same machine
for several days of normal use: 9 resumes from S3, none failed, and
the wait triggered 4 times (200-400 ms).

The failure analysis, the code reading and this patch were done with
the help of an LLM assistant (Claude). I reviewed the change and ran
all tests on my hardware.

Link: https://lore.kernel.org/r/598ee2b4-32aa-4ad3-99c7-db7f9a7e7736@pc-heini.de
Signed-off-by: Moritz Hiller <m.hiller@pc-heini.de>
---

Notes:
    Changes since the proof of concept in the bug report:
    - Renamed the helper to nvme_pci_csts_readable() and moved the initial
      CSTS read into it, so the whole check is in one place (Christoph)
    - Rebased onto nvme-7.5, sorted the linux/delay.h include
    
    Open points from the report that I left as they were:
    - The 10 s upper bound is arbitrary.
    - The wait also triggers on thaw/restore after hibernation, because the
      same bit is set there.
    - The wait sleeps with shutdown_lock held, as nvme_wait_ready() already
      does in the same call chain.
    
    Build-tested with W=1 on nvme-7.5, checkpatch --strict is clean.

 drivers/nvme/host/pci.c | 38 +++++++++++++++++++++++++++++++++++++-
 1 file changed, 37 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index f8088d5aa..342cd0609 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -9,6 +9,7 @@
 #include <linux/blkdev.h>
 #include <linux/blk-mq-dma.h>
 #include <linux/blk-integrity.h>
+#include <linux/delay.h>
 #include <linux/dmi.h>
 #include <linux/init.h>
 #include <linux/interrupt.h>
@@ -3427,6 +3428,41 @@ static bool nvme_pci_update_nr_queues(struct nvme_dev *dev)
 	return true;
 }
 
+/*
+ * A controller that was shut down for suspend may have lost power while the
+ * PCI core still treats it as D3hot, so nothing waited for it to come back.
+ * Config space can already answer while MMIO still reads all-ones. Give such
+ * a controller some time instead of declaring it dead on the first read.
+ */
+#define NVME_RESUME_MMIO_TIMEOUT_MS	10000
+#define NVME_RESUME_MMIO_POLL_MS	100
+
+static bool nvme_pci_csts_readable(struct nvme_dev *dev)
+{
+	struct pci_dev *pdev = to_pci_dev(dev->dev);
+	unsigned int waited = 0;
+
+	if (readl(dev->bar + NVME_REG_CSTS) != -1)
+		return true;
+
+	/* Same test nvme_reset_work() uses to detect a resume. */
+	if (!(dev->ctrl.ctrl_config & NVME_CC_SHN_NORMAL))
+		return false;
+
+	while (waited < NVME_RESUME_MMIO_TIMEOUT_MS &&
+	       pci_device_is_present(pdev)) {
+		msleep(NVME_RESUME_MMIO_POLL_MS);
+		waited += NVME_RESUME_MMIO_POLL_MS;
+		if (readl(dev->bar + NVME_REG_CSTS) != -1) {
+			dev_warn(dev->ctrl.device,
+				 "CSTS read all-ones after resume, controller ready after %u ms\n",
+				 waited);
+			return true;
+		}
+	}
+	return false;
+}
+
 static int nvme_pci_enable(struct nvme_dev *dev)
 {
 	int result = -ENOMEM;
@@ -3438,7 +3474,7 @@ static int nvme_pci_enable(struct nvme_dev *dev)
 
 	pci_set_master(pdev);
 
-	if (readl(dev->bar + NVME_REG_CSTS) == -1) {
+	if (!nvme_pci_csts_readable(dev)) {
 		dev_dbg(dev->ctrl.device, "reading CSTS register failed\n");
 		result = -ENODEV;
 		goto disable;

base-commit: 524994430562e49610802a2c0c0859ce316a72f0
-- 
2.47.3


