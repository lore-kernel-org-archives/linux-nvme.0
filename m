Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE814FF8864
	for <linux-nvme@archiver.kernel.org>; Wed, 29 Apr 2026 08:11:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=4luoH6khuhqnxfmTEORpTdVfrcz2VCE+xEJQwn3VEp0=; b=hW4DMRbh1bi1UHV1KSA8N5OOIV
	uR+D61YTwA7wPOMDRmGIZi9j3EWfGblfbRb+IgupsVKZ6L0wOlg4N5B5XUuogb4g/024MXSd8ewwn
	rtM9VNnG36F4OufEzPYsBAOUk+bZ9H9wB9DDiry2em3lUpsV4JOZH7d8gs0p3h3iIbKXzAwsuzek1
	ZBVZK+1aEqjQ6cH+BPUiQzBFLuAimqh4Hpx8g6TC+zPhKZIIJNi9352xM130PVWgtsZLKzYvUIcm4
	0HQ9CcAN0ImUPCOE27wwXsIAwk2W3HRyLjoW6GWeB7PTiPQuMyl/bArLzf3yv7Mw9BDeAGzBTFr8u
	Kxi1ACDA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wI016-00000003ED9-00Ay;
	Wed, 29 Apr 2026 08:11:32 +0000
Received: from mail-qt1-x82b.google.com ([2607:f8b0:4864:20::82b])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wI013-00000003ECm-1IrW
	for linux-nvme@lists.infradead.org;
	Wed, 29 Apr 2026 08:11:30 +0000
Received: by mail-qt1-x82b.google.com with SMTP id d75a77b69052e-506362ac5f7so100521921cf.1
        for <linux-nvme@lists.infradead.org>; Wed, 29 Apr 2026 01:11:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777450287; x=1778055087; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=4luoH6khuhqnxfmTEORpTdVfrcz2VCE+xEJQwn3VEp0=;
        b=bYxGzELG+2YO8EKR2h9qfxB+sRJuK26CtheW9wZRcBt8mbibzW2xD1S+JiLyIhhgKx
         5i0c+55aUZcUNBlslWbwSh5BzhQHPDnI21kgmZEKFKMJdzakyfoQCAi4y0RW1cnTYl22
         Px1RDe1B35NIFteRduy3ledy/gXbQO6cWmY2fsEOnR3oF6PrPUl6WxpKUsTQUT0fAi9U
         BFPgLZwg39q5fjke/ywKuSjwNoINFn4Rjeod3h/hEMtNDzrqynC7IGHeLSsHHtjQACOV
         ATW0ISo4M6Tp4K38keSX+rxRtqay7KqR0NtJziXkfFq9hn38HcYAkog1Pe+wQnpiNN+t
         v6xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777450287; x=1778055087;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4luoH6khuhqnxfmTEORpTdVfrcz2VCE+xEJQwn3VEp0=;
        b=iEm2+b0hS6tGKFbWxY9Lj6jTMECjxkb6VksWIJ4W0AQJqdFVuLit249u3glc2gbrKf
         Im+nCFTseS6xo7sNQgUcznsy0e9aKhWCga0TIW1lqi/SUrUlSBN3eTsUnYeAVI/SsK4s
         6bIa7dEROybnKz+92dhi7ICf3Jka5xR6Q00UABFHBpSXLqLHc7wgrzFFDSY+7iXicKbj
         le0RDeLhrfWJRkO8wuaWn3PO35L+aECJD32wvnIF17mMOg7rpAYcjA6t7hEJkGEyswWG
         tvKit9/zTlEepoAMkvWI3b9rbpD5URZdbu+C7KmbG+8uAh85YbrfFX8xdufhPHkBUyn1
         1GgA==
X-Gm-Message-State: AOJu0Yz5LSKWyNgN92XjOGTB27MyaieW+oLMwTOtMsKFO20vGRd7GLGp
	+Hz+TD3SOP9GnkMdjcmtHi7pPlK2tMhx6uDERlH/ZNoHI9+qvFpF1miE
X-Gm-Gg: AeBDietiinTEeDvvtC7f2oLhUChjLlH0P2WlLbZTT/UcfRhfj5vXGBScseHNy1sqdqH
	prNVpHd7N0vb8krbn9C9I0vjBqoq/mNwz3gB/gTM6oq6mAdONdh8DET6C7/K9Sm4lJbosp+KohE
	PIDv11Qy/4JYd9exF5StpEicmHrKefoNhf28YJIUrsOmYPvF9dJ5vj1awC0ERyoonSpK5tct9ZG
	r9SP3SnqyESsN39Tr/Gv7B4tKcM8/t9XnPhJdj3iLBdlcfDpga1rRmi/vic8U1FN6go1fnQ8Gny
	fw9iSsdYQlWO+0ggsdI0caGA3dKo9bpfe0ApqQOwlAyQ0T8gTIaHvV4nhUKgmuA1ZEwXpqKaoeF
	OG6+SKr58U+WdrAFi8mV3xVhWW9s/1KdT+aNBbe4e8SNNd5UWpDS7DgmU9MHwfuG6Vyu727OGjv
	GnU4VG/tIT0jngsCSz
X-Received: by 2002:ac8:5d90:0:b0:50d:7384:a660 with SMTP id d75a77b69052e-5100e0f4cb1mr83974981cf.6.1777450287085;
        Wed, 29 Apr 2026 01:11:27 -0700 (PDT)
Received: from localhost ([2001:67c:1562:8007::aac:4468])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5101ac9ffefsm11973191cf.6.2026.04.29.01.11.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2026 01:11:25 -0700 (PDT)
From: "Chia-Lin Kao (AceLan)" <acelan.kao@canonical.com>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] nvme-pci: fix use-after-free in nvme_free_host_mem()
Date: Wed, 29 Apr 2026 16:11:16 +0800
Message-ID: <20260429081116.237733-1-acelan.kao@canonical.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260429_011129_361210_35BCACAA 
X-CRM114-Status: GOOD (  16.69  )
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

nvme_free_host_mem() frees dev->hmb_sgt via dma_free_noncontiguous()
but never clears the pointer afterward.  This leads to a use-after-free
if nvme_free_host_mem() is called twice in the same error path.

This can happen during nvme_probe() when nvme_setup_host_mem() succeeds
in allocating the HMB (setting dev->hmb_sgt) but nvme_set_host_mem()
fails with an I/O error:

  nvme_setup_host_mem()
    nvme_alloc_host_mem_single()   -> sets dev->hmb_sgt
    nvme_set_host_mem()            -> fails with -EIO
    nvme_free_host_mem()           -> frees hmb_sgt, but does NOT NULL it
    return error

  nvme_probe() error path:
    nvme_free_host_mem()           -> dev->hmb_sgt is stale, use-after-free

The second call dereferences the freed sgt, causing a NULL pointer
dereference in iommu_dma_free_noncontiguous() when it accesses
sgt->sgl->dma_address (the backing memory has been freed and zeroed).

This is reproducible on Thunderbolt-attached NVMe devices (e.g., OWC
Envoy Express behind a Dell WD22TB4 dock) where the device intermittently
returns I/O errors during HMB setup due to PCIe link instability.

 BUG: kernel NULL pointer dereference, address: 0000000000000010
 RIP: 0010:iommu_dma_free_noncontiguous+0x22/0x80
 Call Trace:
  <TASK>
  dma_free_noncontiguous+0x3b/0x130
  nvme_free_host_mem+0x30/0xf0 [nvme]
  nvme_probe.cold+0xcc/0x275 [nvme]
  local_pci_probe+0x43/0xa0
  pci_device_probe+0xeea/0x290
  really_probe+0xf9/0x3b0
  __driver_probe_device+0x8b/0x170
  driver_probe_device+0x24/0xd0
  __driver_attach_async_helper+0x6b/0x110
  async_run_entry_fn+0x37/0x170
  process_one_work+0x1ac/0x3d0
  worker_thread+0x1b8/0x360
  kthread+0xf7/0x130
  ret_from_fork+0x2d8/0x3a0
  ret_from_fork_asm+0x1a/0x30
  </TASK>

Fix this by setting dev->hmb_sgt to NULL after freeing it, so the
second call takes the multi-descriptor path which safely handles the
already-cleaned-up state.

Fixes: 63a5c7a4b4c4 ("nvme-pci: use dma_alloc_noncontigous if possible")
Signed-off-by: Chia-Lin Kao (AceLan) <acelan.kao@canonical.com>
---
 drivers/nvme/host/pci.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 9fd04cd7c5cb1..94c423bed947b 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2533,11 +2533,13 @@ static void nvme_free_host_mem_multi(struct nvme_dev *dev)
 
 static void nvme_free_host_mem(struct nvme_dev *dev)
 {
-	if (dev->hmb_sgt)
+	if (dev->hmb_sgt) {
 		dma_free_noncontiguous(dev->dev, dev->host_mem_size,
 				dev->hmb_sgt, DMA_BIDIRECTIONAL);
-	else
+		dev->hmb_sgt = NULL;
+	} else {
 		nvme_free_host_mem_multi(dev);
+	}
 
 	dma_free_coherent(dev->dev, dev->host_mem_descs_size,
 			dev->host_mem_descs, dev->host_mem_descs_dma);
-- 
2.53.0


