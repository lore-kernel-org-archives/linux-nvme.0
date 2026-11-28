Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FEBC606A31C
	for <linux-nvme@archiver.kernel.org>; Sat, 28 Nov 2026 06:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=l4Ttpy1y
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Unsubscribe-Post:List-Owner;
	bh=612l9hGtZR6jYCnlr2HjmvnUPOcGnYBIaLlGvgaiX7o=; b=l4Ttpy1yjyPvAzvilTpYOEtaIg
	6vUynVO1oo3TlJReIDlCdZsQbzdOOWjcRytrHfw6PCquBNXpHfP/MPZJWqGVtNbvnPDCALhial+Fr
	IF5+InV2bn9Fv4AJ3Z6rE153Z0yjyNErmhFpx3ItWOAuDPVKUUL/d1FHFvdWZRYYNwgaPVpK/JmpJ
	iojQXLvpspzOjMVSFT4B9hAASf8vAuNBhKRclZWyG8/AzaHAqhQCkLV3oBsYw1boCib7FeFftU52M
	51FedLvO/69a4yiRlnIKa0l8aoDBxcjruh0G9aChbZzabrGq0tIo9jN7SD9ZNdx+Xob2F2Uh80gDH
	OHOO7Jzw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xXBmx-00000000Pmf-1aJ5;
	Sat, 28 Nov 2026 06:19:59 +0000
Received: from mail-106111.protonmail.ch ([79.135.106.111])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xXBmm-00000000PlJ-0YJO
	for linux-nvme@lists.infradead.org;
	Sat, 28 Nov 2026 06:19:53 +0000
X-Pm-Submission-Id: 4jc0Vx6l1dz2ScQ9
From: Luke Macken <luke@phorex.org>
To: kbusch@kernel.org,
	axboe@kernel.dk,
	hch@lst.de,
	sagi@grimberg.me
Cc: linux-nvme@lists.infradead.org,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Luke Macken <luke@phorex.org>
Subject: [PATCH] nvme-pci: add NVME_QUIRK_DMAPOOL_ALIGN_512 for UMIS AM6B0
Date: Fri, 27 Nov 2026 23:19:28 -0700
Message-ID: <20261128061928.337587-1-luke@phorex.org>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261127_221948_354949_12BEEDDD 
X-CRM114-Status: GOOD (  18.49  )
X-Spam-Score: -2.6 (--)
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

A Lenovo ThinkPad T14s Gen 7 (arm64, arm-smmu-v3) with a UMIS AM6B0 SSD
(1cc4:6b04, model RPJTJ1T24MMW1QDQ, firmware 1.0Q06B0) hangs under
write load. One or two CPUs stop taking interrupts. With
irqchip.gicv3_pseudo_nmi=1 on the command line, they do not respond to
the backtrace NMI either:

  After 10 seconds, these CPUS still haven't responded to the NMI: 2,8

On writes, the drive accesses the page after a PRP list that ends at a
page boundary, and the machine hangs if that page is not mapped in the
IOMMU. Commit c64d9b2c1f4f ("nvme-pci: add NVME_QUIRK_DMAPOOL_ALIGN_512
for KIOXIA XG10d") describes the same access, but there the IOMMU
faults and the controller is reset. Here no fault is logged and the
controller is not reset; why the CPUs stop instead is not known.

The drive has no SGL support, so a request that spans 33 pages (4 KiB
each) gets a PRP list of 32 entries. That fills a 256 byte small pool
block completely, so in the last block of a dmapool page the list ends
at the page boundary. The hang starts with commit 2e8e30b3cf9f ("Revert
"nvme-pci: clamp max_hw_sectors based on DMA optimized limitation"").
Before that commit, requests behind an IOMMU were limited to 128 KiB on
kernels with 4 KiB pages. A page aligned 128 KiB request spans 32 pages
and gets 31 list entries, one short of a full block; only an unaligned
request could fill one.

A debug patch that puts every 32 entry list at the end of a page shows
that the next page matters. If it is mapped, writes complete and the
data is written correctly. If it is not mapped, reads complete, but the
first write with a 32 entry list hangs the machine.

Use 512 byte aligned small pool blocks for this controller, so that a
32 entry list no longer ends at a page boundary.

Tested with 32 dd processes doing 132 KiB O_DIRECT writes in parallel:
with the quirk they complete; without it they hang the machine.

Assisted-by: LLM
Signed-off-by: Luke Macken <luke@phorex.org>
---
Tested on v7.4-rc4 plus the out-of-tree patches this laptop still needs
(none in block, nvme, iommu or dma code). All v7.4-rc4 kernels below
share that base and one config; they differ only in this patch, the
debug patch or a revert of commit 2e8e30b3cf9f.

The hang was traced to commit 2e8e30b3cf9f with a workload that unpacks
container images. It ran 20 times without a hang on linux-next 20261019
and hung the machine in the sixth run on 20261020, the first to contain
that commit. On v7.4-rc4, it hung the machine in the first run on one
boot and in the second on another; with the commit reverted, it ran 30
times without a hang.

Reproducer, on ext4 on dm-crypt on the drive:

  for i in $(seq 32); do
          dd if=/dev/zero of=w$i bs=132k count=300 oflag=direct &
  done; wait

With the quirk, the loop completed five times, and also five times each
with 1, 2, 4, 8, 16 and 64 parallel dd processes instead of 32. Without
the quirk, the loop as shown hung the machine on its first run.

The debug patch (I can send it) makes nvme_pci_setup_data_prp() put
every 32 entry list into a separate two page buffer. A list at the end
of the buffer's first page has the second page after it. For a list in
the second page, the patch first checks in the IOMMU page table that
nothing is mapped after the buffer. Results for dd writing or reading
in 132 KiB O_DIRECT requests ("-" = not run):

  list ends                      next page    writing    reading
  at a page end                  mapped       complete   -
  at a page end                  not mapped   hang       complete
  256 bytes before a page end    not mapped   complete   -

With the list at a page end and the next page not mapped, a single dd
was enough: its first write with a 32 entry list hung the machine in
each of three boots. With the list 256 bytes before a page end, the
closest the quirk allows, more than 20000 such writes completed.

Only this one drive was tested, and only with the IOMMU enabled.

This patch, the analysis, the debug patch and the test scripts were
produced with Claude.

 drivers/nvme/host/pci.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 987ce5f536d6..b11360052c0d 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -4448,6 +4448,8 @@ static const struct pci_device_id nvme_id_table[] = {
 		.driver_data = NVME_QUIRK_DISABLE_WRITE_ZEROES, },
 	{ PCI_DEVICE(0x1cc4, 0x6302),   /* UMIS RPJTJ256MGE1QDY 256G */
 		.driver_data = NVME_QUIRK_DISABLE_WRITE_ZEROES, },
+	{ PCI_DEVICE(0x1cc4, 0x6b04),   /* UMIS AM6B0 */
+		.driver_data = NVME_QUIRK_DMAPOOL_ALIGN_512, },
 	{ PCI_DEVICE(0x2646, 0x2262),   /* KINGSTON SKC2000 NVMe SSD */
 		.driver_data = NVME_QUIRK_NO_DEEPEST_PS, },
 	{ PCI_DEVICE(0x2646, 0x2263),   /* KINGSTON A2000 NVMe SSD  */

base-commit: 08be423d20e892e2606172cf69015d34ac170786
-- 
2.43.0


