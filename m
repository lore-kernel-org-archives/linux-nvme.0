Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BABF6CD8CB9
	for <linux-nvme@archiver.kernel.org>; Wed, 10 Jun 2026 03:17:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=42e1W9Vhbx5KiHIrPfIZVIwOFgNuOXK6SANMk3c2IzY=; b=3h5KVHVWHxeWOW6+ZFdQw9tD0J
	J0ymQNaoviX3tgS668uRVutYEIbgWODmKuTg12pW3n0IS8rj7EbG67HUu2ZqqceMWia3FfzFJtNMh
	hf06PzpfPScNiOPPttuowWIqNXtiTsd7H2o9vH1Q/QjJACmGk2Xy2nHZ+Lic1FDoCdB0n6if0TnVI
	lWRomOFs0K8hBcJndmdbBLkZ0RWGrcwUHWl4/01BD/7mDhAK7RHs3/PH1JSXSWnphs0YvIY+TUBMM
	Rf0bP0o55KFodoh9dE3eJ/LkUTV/NYpde5r6VP5h0hxJfWLGN/PpcvvdMXMYBqiHrOuePKzrlTYrE
	T+aUBJVw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wX9S0-00000006jYF-18Rz;
	Wed, 10 Jun 2026 03:17:56 +0000
Received: from mailgw.kylinos.cn ([124.126.103.232])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wX9Rx-00000006jWs-0ylY
	for linux-nvme@lists.infradead.org;
	Wed, 10 Jun 2026 03:17:55 +0000
X-UUID: f09f2d02647a11f1aa26b74ffac11d73-20260610
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:f2a283f3-a5f1-409d-b560-466fe7d68dba,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:e7bac3a,CLOUDID:1d0b3bdf2bcd2ca600cbbf507f4303de,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102|136|865|898,TC:nil,Content:0|15|50,E
	DM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA
	:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: f09f2d02647a11f1aa26b74ffac11d73-20260610
X-User: liuxixin@kylinos.cn
Received: from [127.0.1.1] [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <liuxixin@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1735211475; Wed, 10 Jun 2026 11:17:41 +0800
From: Xixin Liu <liuxixin@kylinos.cn>
To: linux-nvme@lists.infradead.org
Cc: kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me, linux-kernel@vger.kernel.org, liuxixin@kylinos.cn
Subject: [PATCH v1 0/1] nvme-pci: tear down controller on ERS permanent failure
Date: Tue, 10 Jun 2026 10:55:00 +0800
Message-ID: <cover.nvme-ers-v1.1780449274.git.liuxixin@kylinos.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailer: nvme-ers-resetting/send-local.py
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260609_201753_593988_373EAA08 
X-CRM114-Status: UNSURE (   6.12  )
X-CRM114-Notice: Please train this message.
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

Hi,

This series fixes nvme-pci leaving the controller in NVME_CTRL_RESETTING
after PCIe ERS reports pci_channel_io_perm_failure.

On pci_channel_io_frozen the driver sets NVME_CTRL_RESETTING and quiesces
I/O, expecting slot_reset to restart the controller.  When pcie_do_recovery()
fails, the core reports perm_failure.  Reproduced on a QEMU 8.2.0 hotplug
NVMe when pci_bus_error_reset() fails: the Root Port LnkCap advertises
DLLLARC but LnkSta.DLLLA never sets within 100 ms after secondary bus
reset ("Data Link Layer Link Active not set in 100 msec"), slot_reset is
never invoked, and unpatched nvme-pci only logs and returns DISCONNECT.
sysfs state stays "resetting" and new I/O gets BLK_STS_RESOURCE — dd
and nvme list hang in uninterruptible D state.

Reuse the same teardown as the reset_work error path (DELETING, disable
with shutdown, mark namespaces dead, DEAD) so I/O fails immediately
instead of blocking.

Thanks,
Xixin Liu

---

Xixin Liu (1):
  nvme-pci: tear down controller on ERS permanent failure

 drivers/nvme/host/pci.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

-- 
2.43.0


