Return-Path: <SRS0=jy92=BI=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D3A3C433DF
	for <linux-nvme@archiver.kernel.org>; Wed, 29 Jul 2020 05:44:29 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0523720786
	for <linux-nvme@archiver.kernel.org>; Wed, 29 Jul 2020 05:44:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="PUoMuVQo";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="fo1RGdLe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0523720786
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=n5n27GUNG91IPXGp8hneS6GadesOAj4tszbpzGN6rMk=; b=PUoMuVQo+xKXvZqq7uQ5TlwWYZ
	PSo8HFe70OMPHi1suPkV8ECVHavceoEUNIOFXU/d+usZoxzrFGSeprctSwKqXREvRyQom/P9ykTCD
	15IhBCvBixQ7I1fLoCg8+ckfNIsqZun0BlIz2/P0gwQbUcTKWnxWEodBjXR7/6MT6nYG/HZpyirqm
	nnOFi3nxoAu8XiFZ92n51SHLEzKIQQJbL4QQOHOwwfL+jpAn/teQ6KFC7+/6fMVXok5FzMq6vVRdz
	EIYn4ky1Wd+Myk2hI/ORIW00rkYGLlv4x7HrNI6zoaIQjlczVS4PRyrZnPsJcWbAvKBLkiakeUfxI
	I6zYdW1w==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k0et7-0007GL-1n; Wed, 29 Jul 2020 05:44:25 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k0et5-0007Cx-IM
 for linux-nvme@merlin.infradead.org; Wed, 29 Jul 2020 05:44:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:In-Reply-To:References;
 bh=Up9tpBFuVqmEjuU7wrYXJqvcP7rk5ZrSMzTJOLFM3Eo=; b=fo1RGdLe5ALD3fp4e+J0XE4gBW
 ISNOMD+id+Qo+Yes7kWOOq2/LWztYd0fL8bOHnv00Z61DoUH8yjUEXBl4NHuCCC+Iz8jFZ12YNoZa
 jfDYHlEkUq+xvHMqx1jgskAAPC0V6Alx5sjrdOHJ8ks/FmguucNSZHv5cPpaSGWsNrfz5OeBw8xXj
 tZ81tuTLoaRFY6Qu9mP6TrWoj+3QJsMrRbbEXzd6nF3UtsUvWv59fujVcnCm2OHNUkXFnQMfS/xxL
 avgbMZSrCy7mL9vn1gbmQr5e5xO7TrPe5E42DvsaQNS8TKbS9F21g2NUxfcVrKEbfBnkeLjNXIii2
 le03Txvg==;
Received: from 089144218008.atnat0027.highway.a1.net ([89.144.218.8]
 helo=localhost)
 by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k0et4-000270-7K; Wed, 29 Jul 2020 05:44:22 +0000
From: Christoph Hellwig <hch@lst.de>
To: kbusch@kernel.org,
	linux-nvme@lists.infradead.org
Subject: [PATCH v2] nvme: add a Identify Namespace Identification Descriptor
 list quirk
Date: Wed, 29 Jul 2020 07:44:20 +0200
Message-Id: <20200729054420.9049-1-hch@lst.de>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: Ingo Brunberg <ingo_brunberg@web.de>, Sagi Grimberg <sagi@grimberg.me>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Add a quirk for a device that does not support the Identify Namespace
Identification Descriptor list despite claiming 1.3 compliance.

Reported-by: Ingo Brunberg <ingo_brunberg@web.de>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Tested-by: Ingo Brunberg <ingo_brunberg@web.de>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
---

Now actually against nvme-5.8, and with cosmetic modifications to
reduce the amount of merge conflicts vs the 5.9 branch..

 drivers/nvme/host/core.c | 15 +++------------
 drivers/nvme/host/nvme.h |  7 +++++++
 drivers/nvme/host/pci.c  |  2 ++
 3 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index add040168e67e2..4ee2330c603e77 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1102,6 +1102,9 @@ static int nvme_identify_ns_descs(struct nvme_ctrl *ctrl, unsigned nsid,
 	int pos;
 	int len;
 
+	if (ctrl->quirks & NVME_QUIRK_NO_NS_DESC_LIST)
+		return 0;
+
 	c.identify.opcode = nvme_admin_identify;
 	c.identify.nsid = cpu_to_le32(nsid);
 	c.identify.cns = NVME_ID_CNS_NS_DESC_LIST;
@@ -1115,18 +1118,6 @@ static int nvme_identify_ns_descs(struct nvme_ctrl *ctrl, unsigned nsid,
 	if (status) {
 		dev_warn(ctrl->device,
 			"Identify Descriptors failed (%d)\n", status);
-		 /*
-		  * Don't treat non-retryable errors as fatal, as we potentially
-		  * already have a NGUID or EUI-64.  If we failed with DNR set,
-		  * we want to silently ignore the error as we can still
-		  * identify the device, but if the status has DNR set, we want
-		  * to propagate the error back specifically for the disk
-		  * revalidation flow to make sure we don't abandon the
-		  * device just because of a temporal retry-able error (such
-		  * as path of transport errors).
-		  */
-		if (status > 0 && (status & NVME_SC_DNR))
-			status = 0;
 		goto free_data;
 	}
 
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 1de3f9b827aa56..09ffc3246f60e4 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -129,6 +129,13 @@ enum nvme_quirks {
 	 * Don't change the value of the temperature threshold feature
 	 */
 	NVME_QUIRK_NO_TEMP_THRESH_CHANGE	= (1 << 14),
+
+	/*
+	 * The controller doesn't handle the Identify Namespace
+	 * Identification Descriptor list subcommand despite claiming
+	 * NVMe 1.3 compliance.
+	 */
+	NVME_QUIRK_NO_NS_DESC_LIST		= (1 << 15),
 };
 
 /*
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 25a187e43dbe74..d4b1ff7471231b 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -3099,6 +3099,8 @@ static const struct pci_device_id nvme_id_table[] = {
 	{ PCI_VDEVICE(INTEL, 0x5845),	/* Qemu emulated controller */
 		.driver_data = NVME_QUIRK_IDENTIFY_CNS |
 				NVME_QUIRK_DISABLE_WRITE_ZEROES, },
+	{ PCI_DEVICE(0x126f, 0x2263),	/* Silicon Motion unidentified */
+		.driver_data = NVME_QUIRK_NO_NS_DESC_LIST, },
 	{ PCI_DEVICE(0x1bb1, 0x0100),   /* Seagate Nytro Flash Storage */
 		.driver_data = NVME_QUIRK_DELAY_BEFORE_CHK_RDY, },
 	{ PCI_DEVICE(0x1c58, 0x0003),	/* HGST adapter */
-- 
2.27.0


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
