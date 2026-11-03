Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 275DD606A324
	for <linux-nvme@archiver.kernel.org>; Tue,  3 Nov 2026 06:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=AL6iSpFu
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Unsubscribe-Post:List-Owner;
	bh=qfAtoIcGCBg87uuZW1y9XaJODikXP+EnVxZyeJ9W7jc=; b=AL6iSpFu6NAsnUkBvRAOehWHOh
	k5TaEjd7pXXckHrwv0QU7wV9Q9sdbtyks/OMlIwXawlEoifAnmzzVVmqHsv8h5OGsprIgJhjz1nSs
	Yz7mqIicTW9RjIVT9LrwxqN3mmCZ0wdi6wAXzmfeLrBQocuwtWWBnuX/xRa5rHz4VzCYNBFn+j6u1
	XSr/r1Mj+c+QsbnCL4Lr6uDlZu+twaUwYkZ3uC0ZH72wXM1kcCbbt6O9OXt52kroHSt1A/nRf0G8C
	OCPU7UFbalzKVm2s8blxbAlUOfUUvgH73jBvkGknR/TJDNri9h3Io9Re34lLmLRlfkw/TJJzsueoJ
	7Utgtk+g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xO84t-00000001FmD-3ZuW;
	Tue, 03 Nov 2026 06:33:03 +0000
Received: from out28-124.mail.aliyun.com ([115.124.28.124])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xO84q-00000001Flp-3XK0
	for linux-nvme@lists.infradead.org;
	Tue, 03 Nov 2026 06:33:02 +0000
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.9170154|0.100999;CH=green;DM=|AD|false|;DS=CONTINUE|ham_alarm|0.00322135-0.00151948-0.995259;FP=11438868440337108543|1|1|1|0|-1|-1|-1;HT=maildocker-contentspam033037026024;MF=liaoxuan@open-hieco.net;NM=1;PH=DS;RN=7;RT=7;SR=0;TI=SMTPD_---.jvPeWBu_1793687571;
Received: from Ubuntu2404-XLH.hygon.cn(mailfrom:liaoxuan@open-hieco.net fp:SMTPD_---.jvPeWBu_1793687571 cluster:ay29)
          by smtp.aliyun-inc.com;
          Tue, 03 Nov 2026 14:32:57 +0800
From: Liao Xuan <liaoxuan@open-hieco.net>
To: kbusch@kernel.org,
	axboe@kernel.dk,
	hch@lst.de,
	sagi@grimberg.me
Cc: linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Liao Xuan <liaoxuan@open-hieco.net>
Subject: [PATCH] nvme-pci: Fix performance regression with completion batching for Hygon processors
Date: Tue,  3 Nov 2026 14:32:49 +0800
Message-ID: <20261103063249.3212198-1-liaoxuan@open-hieco.net>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261102_223301_045833_BE426AEF 
X-CRM114-Status: GOOD (  14.14  )
X-Spam-Score: -1.9 (-)
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
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Commit 4f5022453acd ("nvme: wire up completion batching for the IRQ path")
introduced completion batching to the NVMe IRQ handling path. While this
change brings performance gains on mainstream platforms, it causes a
severe random read performance regression on Hygon platforms.

The batching logic defers CQE processing until after the doorbell is
written. On Hygon microarchitectures, this specific execution order
accelerates the NVMe controller's interrupt generation. This leads to an
interrupt storm: the overall interrupt count increases significantly,
and each interrupt handles fewer CQEs. Consequently, a massive amount of
CPU cycles are consumed by the fixed overhead of interrupt entry/exit
rather than useful I/O processing, drastically degrading random read
efficiency.

Interrupt statistics were collected on a Hygon platform using a 10-second
workload of 16 jobs with 4 KiB random reads:
With batching: average IOPS ~2.29M; interrupts per queue ~1.82M
Without batching: average IOPS ~2.89M; interrupts per queue ~1.52M

By restoring the single-completion fast path, the interrupt rate is
reduced by ~16%, eliminating the interrupt storm.

Performance results (fio 4k randread, 16 jobs) show
significant improvements across various CPU pinning topologies:

CPU Pinning     | With Batching (kops) | This Patch (kops) | Improvement
0-15,128-143    | 1,747.9              | 2,053.9           | +17.5%
0-11,128-139    | 1,939.8              | 2,437.6           | +25.7%
0-7,128-135     | 2,341.9              | 2,891.3           | +23.5%
0-15            | 1,754.1              | 2,018.6           | +15.1%
0-11            | 2,051.2              | 2,510.5           | +22.4%

It is worth noting that this issue is not necessarily exclusive to Hygon
CPUs. Architectures with higher interrupt latency or lower overall
performance characteristics may also suffer from similar regressions,
where the overhead of the batching fast path outweighs the benefit of
amortizing the doorbell write.

Instead of hardcoding a permanent revert, introduce a flag 'use_comp_batch'
and disable IRQ completion batching if running on a Hygon CPU. This
preserves the performance benefits for platforms that favor batching
while restoring the optimal single-completion fast path for Hygon, and
provides a scalable mechanism to disable it on other affected platforms
in the future.

Fixes: 4f5022453acd ("nvme: wire up completion batching for the IRQ path")
Signed-off-by: Liao Xuan <liaoxuan@open-hieco.net>
---
 drivers/nvme/host/pci.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 69932d640..a3ecbac40 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -276,6 +276,15 @@ static bool noacpi;
 module_param(noacpi, bool, 0444);
 MODULE_PARM_DESC(noacpi, "disable acpi bios quirks");
 
+static bool use_comp_batch __ro_after_init = true;
+static void nvme_setup_comp_batch(void)
+{
+#ifdef CONFIG_X86
+	if (boot_cpu_data.x86_vendor == X86_VENDOR_HYGON)
+		use_comp_batch = false;
+#endif
+}
+
 struct nvme_dev;
 struct nvme_queue;
 
@@ -1630,8 +1639,11 @@ static inline bool nvme_poll_cq(struct nvme_queue *nvmeq,
 static irqreturn_t nvme_irq(int irq, void *data)
 {
 	struct nvme_queue *nvmeq = data;
-	DEFINE_IO_COMP_BATCH(iob);
 
+	if (!use_comp_batch)
+		return nvme_poll_cq(nvmeq, NULL) ? IRQ_HANDLED : IRQ_NONE;
+
+	DEFINE_IO_COMP_BATCH(iob);
 	if (nvme_poll_cq(nvmeq, &iob)) {
 		if (!rq_list_empty(&iob.req_list))
 			nvme_pci_complete_batch(&iob);
@@ -3767,6 +3779,8 @@ static int nvme_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 
 	dev_info(dev->ctrl.device, "pci function %s\n", dev_name(&pdev->dev));
 
+	nvme_setup_comp_batch();
+
 	result = nvme_pci_enable(dev);
 	if (result)
 		goto out_release_iod_mempool;
-- 
2.43.0


