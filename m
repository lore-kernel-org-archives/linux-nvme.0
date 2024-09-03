Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5DCCCD3420
	for <linux-nvme@archiver.kernel.org>; Tue,  3 Sep 2024 11:49:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=4ruBMBZn9qeCERyCNCnpSOoPMPMxWbm0ix0NRz6/dA4=; b=KD2t4FTLJa1wNfvJfejAFRde3D
	Tl8RCyT6f2/T196Y3BenotOcnhtO9ErAPN2pkI7EJR8e4BVed3IO2ckJm2HZHHEDGCTTGFRpFc3o1
	HNt9yX4P6yiRvg2JMyhcUDiBWdRii0KNF2adkkFntd8epZVmkscH7NJ2AAYNjhyr015AOL2p99ASv
	kZAmUV8wb7DJo9qJDXlh4tL5g7Tosv8OEkeT005zrEa93c7z0HKu81UBkMl8DMq1/2EF78k0cQvpj
	W5fFdQsZLd2euL2NMUIRYnork72M/kF+ZAxin/t4Gu4a7K09xC19FTw7sGI4KgqwUHRNEd3XOXTLf
	LZmF6jgA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1slS2D-0000000016Q-11Yu;
	Tue, 03 Sep 2024 11:49:21 +0000
Received: from a7-46.smtp-out.eu-west-1.amazonses.com ([54.240.7.46])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1slS2A-0000000015X-0C0U
	for linux-nvme@lists.infradead.org;
	Tue, 03 Sep 2024 11:49:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=4232tfv5ebdrjdwkr5zzm7kytdkokgug; d=collabora.com; t=1725364154;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Transfer-Encoding;
	bh=ObT60zcbCbi35EjoJKU5eE2w1p2W/0osNYaH1E6YL3g=;
	b=Cs1iL06JJ8AVKJEAn7FtXcpy06VqD4M9iex8FAVjFsMgZH2XawvAkmK9ea0qRxcZ
	V/YCzDssBJN8pAmZR/USHUOCshQpGBHkPivHX8JNrr0Omrvtsi8FvIfqVPCFR6k19Dg
	ki+dbC0YTyUiLc3qpQ+3xyrvv9KPEIPpN5R3sBGN0fBVHOskkL2geN7xDDh5YuddtO8
	stZiI7+4iSFg8hoBCItOy9MQcn1trtP9AyAvT8kVJaD90TA3EiXUqaKgFMIlYJqZwzz
	JVNL9LLOgpEjz5Z7bDAzdArEuPIymN1iZ5kvNtQC6ekuHS5mn2N0jJpMJzeU32flkNA
	4KhELCB9yg==
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=uku4taia5b5tsbglxyj6zym32efj7xqv; d=amazonses.com; t=1725364153;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Transfer-Encoding:Feedback-ID;
	bh=ObT60zcbCbi35EjoJKU5eE2w1p2W/0osNYaH1E6YL3g=;
	b=fR6X6WaDNaqrb/eC3ZaNPg+1+ZkkFeCZq95YiWsrrezI8ufsUoKaYm6+ITxxn7NP
	zNat38Rg9+KX3hcCXaTy6fMColjxO5G/32S4x8psCveXY6/ENm+1y89ECuACjZJw2bq
	INtloZw7ckGpEUI3NvuZwadBh5rECGruVVjeBO9A=
From: Eugen Hristev <eugen.hristev@collabora.com>
To: linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org
Cc: kbusch@kernel.org, sagi@grimberg.me, hch@lst.de, 
	Eugen Hristev <eugen.hristev@collabora.com>
Subject: [PATCH] nvme-pci: refresh visible attrs after being checked
Date: Tue, 3 Sep 2024 11:49:13 +0000
Message-ID: <01020191b7b7adc0-bca16d06-b051-4ce2-bfee-c8038a62462f-000000@eu-west-1.amazonses.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Feedback-ID: ::1.eu-west-1.YpP9ZbxnARFfy3Cb5pfsLd/pdsXBCNK0KEM7HforL4k=:AmazonSES
X-SES-Outgoing: 2024.09.03-54.240.7.46
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240903_044918_457440_6621EFCB 
X-CRM114-Status: GOOD (  11.87  )
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

The sysfs attributes are registered early, but the driver does not
know whether they are needed or not at that moment.
For the cmb attributes, commit
e917a849c3fc ("nvme-pci: refresh visible attrs for cmb attributes")
solved this problem by calling `nvme_update_attrs` after mapping the cmb.
However the issue persists for the hmb attributes.
To solve the problem, moved the call to `nvme_update_attrs` after
`nvme_setup_host_mem` is called, the one that sets up the hmb, in probe
and in reset_work functions.

Fixes: e917a849c3fc ("nvme-pci: refresh visible attrs for cmb attributes")
Fixes: 86adbf0cdb9e ("nvme: simplify transport specific device attribute handling")
Signed-off-by: Eugen Hristev <eugen.hristev@collabora.com>
---
 drivers/nvme/host/pci.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index e6267a6aa380..9455c4d53d7d 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1878,8 +1878,6 @@ static void nvme_map_cmb(struct nvme_dev *dev)
 	if ((dev->cmbsz & (NVME_CMBSZ_WDS | NVME_CMBSZ_RDS)) ==
 			(NVME_CMBSZ_WDS | NVME_CMBSZ_RDS))
 		pci_p2pmem_publish(pdev, true);
-
-	nvme_update_attrs(dev);
 }
 
 static int nvme_set_host_mem(struct nvme_dev *dev, u32 bits)
@@ -2736,6 +2734,8 @@ static void nvme_reset_work(struct work_struct *work)
 	if (result < 0)
 		goto out;
 
+	nvme_update_attrs(dev);
+
 	result = nvme_setup_io_queues(dev);
 	if (result)
 		goto out;
@@ -3046,6 +3046,8 @@ static int nvme_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	if (result < 0)
 		goto out_disable;
 
+	nvme_update_attrs(dev);
+
 	result = nvme_setup_io_queues(dev);
 	if (result)
 		goto out_disable;
-- 
2.34.1


