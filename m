Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67B9D606A31C
	for <linux-nvme@archiver.kernel.org>; Fri, 30 Oct 2026 03:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=1BRhXkAa;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=robsoncassiano.software header.i=@robsoncassiano.software header.a=rsa-sha256 header.s=cf-bounce header.b=H0vxPB8h;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=cloudflare-smtp.net header.i=@cloudflare-smtp.net header.a=rsa-sha256 header.s=cf2024-1 header.b=PHiHeAIK
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Date:Subject:Cc:To:From:Message-ID:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Unsubscribe-Post:List-Owner;
	bh=5RMaJLdOqxhz6uN3b9vGcTDRWt0U48Knz5DQ3YYyltM=; b=1BRhXkAaW2hvHtxEEGlJFj3zIx
	R+aJxx57lJs3260ETPFGLPe0fM9+riy5QIAdB/nJK03LGt1zbnWcYZoXAUVtV1MztApMrtHmnwIFw
	pRvzfS0VcN1DSFerO+jE+RuHkgocJkzi7VweHwFwhWWW2NxVoq9UF2QFXt4Gc4Fh7XvAOOq7cliXP
	Xmz27FGd6sXaVqvz/RZy4hmKFHOxPe8kBPaccvbLRUnsE7oWNvp8zUf0CvT4nDwu2MaZG6Iz+RPg7
	x43UGvaw7e/BVHI0q03FxpRXiQcjj9zS0GcvkGfmkEkhrMEhZKvkTxJJt0enGwRwdm82ZJzIjKI9W
	kBPrd11w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xMcvv-0000000Ahpy-3WGI;
	Fri, 30 Oct 2026 03:05:35 +0000
Received: from bg-jh.cloudflare-smtp.net ([104.30.16.97])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xMcvq-0000000AhoV-3ILY
	for linux-nvme@lists.infradead.org;
	Fri, 30 Oct 2026 03:05:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; s=cf-bounce; d=robsoncassiano.software; c=relaxed/relaxed;
	h=Date:Subject:Cc:To:From:Feedback-ID:from:reply-to:resent-date
	:resent-from:resent-to:resent-cc:in-reply-to:references:list-id:list-help
	:list-unsubscribe:list-unsubscribe-post:list-subscribe:list-post
	:list-owner:list-archive; t=1793329530; x=1793934330; bh=5RMaJLdOqxhz6uN3b9
	vGcTDRWt0U48Knz5DQ3YYyltM=; b=H0vxPB8hvqFHLKvl1j42rGp3Xv3ZbnpJ5UT1lxlj+HNCy
	1oBeV000DLBPCZyrRIfto2PBpfhz3UUowen3u6qELEZaCU43Qr/YKlwYc1/k4+7BV2+aMdx36T4
	hzxz9DS29wralQPXU91oHXXOUo/J13frURcJKVnygGks3CjqGySIiIp1fp8OzQ2rMAPuAFyjx+W
	r/fL95K735PDb4AlQ1Ziq7KmmWKI7e7uXCEOpyzHaIM6sFubrIf3DuOfvCBDVRQNIawOqOLtOl+
	RuQ/726b9zLob5PCFDg6R8lzgswLyjlYZN2mRCuWEIBL86+z/0yMHyiYfoB819A+beXp1zog==;
DKIM-Signature: v=1; a=rsa-sha256; s=cf2024-1; d=cloudflare-smtp.net; c=relaxed/relaxed;
	h=Date:Subject:Cc:To:From:Feedback-ID:from:reply-to:resent-date
	:resent-from:resent-to:resent-cc:in-reply-to:references:list-id:list-help
	:list-unsubscribe:list-unsubscribe-post:list-subscribe:list-post
	:list-owner:list-archive; t=1793329530; x=1793934330; bh=5RMaJLdOqxhz6uN3b9
	vGcTDRWt0U48Knz5DQ3YYyltM=; b=PHiHeAIKpj5l8lYddqy0ZGRkYBRnRDiZ3vg6YAiL7zUtS
	Ry4OgGNrNKDZaL3Xz9sg3+DEVv3XmbVFbaPrgWpX7Q7ipPFBSvuhzc0V8g99QZgXMj01xqbvz75
	YAuwvZW4QGl+4c8MLJeA0obB9eshyTVsrWNfiRGCgvBSrSW8yqIN45SVs0GzT+/oxdwEXY32GWY
	VMw0k/EOTnbhYeJJYFVZRna2u33/9ppnNdS64WkA3QcVZu/yhuZDB8c53cCeq3eEO1FGhGbmhYc
	l8a7V9+Srm1zFIjgeDm/rl89+pNfJyCbiZuzMINpgSpeAL0h65F+N9jdGGgcELEmqSWdmJKw==;
Feedback-ID: robsoncassiano.software:5:5:Cloudflare
Received: from authenticated-submission.invalid
        by mx.cloudflare.net (Cloudflare Email Submission) with ESMTPSA id LKLvqPjuMPko; Fri, 30 Oct 2026 03:05:13 +0000
Message-ID: <WnzOhxjlW7w5jwpSIQmUzrvduOStpoX2h3FS@robsoncassiano.software>
From: Robson Cassiano <linux@robsoncassiano.software>
To: kbusch@kernel.org,
	axboe@kernel.dk,
	hch@lst.de,
	sagi@grimberg.me
Cc: linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Robson Cassiano <linux@robsoncassiano.software>
Subject: [PATCH] nvme-pci: add NVME_QUIRK_NO_SECONDARY_TEMP_THRESH for WD SN740
Date: Fri, 30 Oct 2026 00:05:13 -0300
X-Mailer: git-send-email 2.56.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261029_200531_899990_066F21C1 
X-CRM114-Status: UNSURE (   9.03  )
X-CRM114-Notice: Please train this message.
X-Spam-Score: -2.0 (--)
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

The WD SN740 (15b7:5017) reports two secondary temperature sensors in
the SMART/Health log but returns the 0 and 0xffff (Kelvin) sentinels
for their temperature thresholds. nvme-hwmon exposes those as
temp2_min/max and temp3_min/max, producing -273.15 C and 65261.85 C in
sysfs.

Mark the controller with NVME_QUIRK_NO_SECONDARY_TEMP_THRESH so only
the sensor inputs are exposed.

Assisted-by: LLM
Signed-off-by: Robson Cassiano <linux@robsoncassiano.software>
---
Tested on the affected system, WD SN740 512 GB, firmware 73100004:

  # lspci -nn -s 01:00.0
  01:00.0 Non-Volatile memory controller [0108]: Sandisk Corp WD SN560/SN740/SN770/SN5000 NVMe SSD [15b7:5017] (rev 01)

Before, on 7.2.8:

  temp2_label    Sensor 1
  temp2_input    53850
  temp2_min      -273150
  temp2_max      65261850
  temp3_label    Sensor 2
  temp3_input    38850
  temp3_min      -273150
  temp3_max      65261850

After, on 7.3.0 with this patch:

  temp1_label    Composite
  temp1_input    45850
  temp1_min      -40150
  temp1_max      83850
  temp1_crit     87850
  temp2_label    Sensor 1
  temp2_input    59850
  temp3_label    Sensor 2
  temp3_input    45850

temp1_* are the Composite thresholds and stay exposed; the quirk only
suppresses the secondary sensor thresholds.

The quirk also covers the other models sharing 15b7:5017 (SN560, SN770,
SN5000); only the SN740 was tested.

OEM systems: Dell OptiPlex 3000, Lenovo IdeaCentre AIO 5 and Samsung
NP750QFG-KS1BR (the test system).

 drivers/nvme/host/pci.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 77317e5..4f1f10b 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -4170,6 +4170,8 @@ static const struct pci_device_id nvme_id_table[] = {
 	{ PCI_DEVICE(0x15b7, 0x5009),   /* Sandisk SN550 */
 		.driver_data = NVME_QUIRK_BROKEN_MSI |
 				NVME_QUIRK_NO_DEEPEST_PS },
+	{ PCI_DEVICE(0x15b7, 0x5017),   /* Sandisk SN560/SN740/SN770/SN5000 */
+		.driver_data = NVME_QUIRK_NO_SECONDARY_TEMP_THRESH, },
 	{ PCI_DEVICE(0x1987, 0x5012),	/* Phison E12 */
 		.driver_data = NVME_QUIRK_BOGUS_NID, },
 	{ PCI_DEVICE(0x1987, 0x5016),	/* Phison E16 */
-- 
2.56.0


base-commit: c03c1a14507dfaf8b856c2608f9ac216021fc222



