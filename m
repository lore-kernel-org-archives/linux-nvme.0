Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1150606A31E
	for <linux-nvme@archiver.kernel.org>; Mon, 23 Nov 2026 22:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=DnV4/F20;
	dkim=pass (2048-bit key, unprotected) header.d=molgen.mpg.de header.i=@molgen.mpg.de header.a=rsa-sha256 header.s=20260906 header.b=lqRIXnIl
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Unsubscribe-Post:List-Owner;
	bh=P679Rl3XhQ1PcDNlcvazMnRpUQ1twsPQEDJNLqeUCt0=; b=DnV4/F20u2Jaag9D7xOPtyvoGo
	L4ALN0zkC88qRVQWAvIS9nhdcyT271ssirMMQrncCRzJrjwGxEexeQ6fpzIwWItK78kqGMZbLktkW
	a6ph5DczBekIGOSr4CJoZ+AR95ARvLEcM4ROPYCLU5W5j7OXRFIQWr08QNu0EDASKTuxyNnJvNHIy
	5Sjl7SPWS4wMbMUeHio3R9m9VZ1p/fndsEihZVl9uoyIGSUUm045A3gwxYwaj2kAQK35iZkDzbc/h
	V+WaTlr54QAtkqsEVYo4KQ5irRusvu5o39zOsR+n3PoiCk0OpDdrNd8PbplvIindtxshfDpuW1jXo
	6HiI1J4w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xVcj2-000000056Fs-3rr7;
	Mon, 23 Nov 2026 22:41:28 +0000
Received: from mx3.molgen.mpg.de ([141.14.17.11])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xVciy-000000056Eo-3KKc
	for linux-nvme@lists.infradead.org;
	Mon, 23 Nov 2026 22:41:27 +0000
Received: from abreu (ip-095-090-245-070.vkd79.pools.vodafone-ip.de [95.90.245.70])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 758B24C442F809;
	Mon, 23 Nov 2026 23:40:34 +0100 (CET)
From: Paul Menzel <pmenzel@molgen.mpg.de>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: Paul Menzel <pmenzel@molgen.mpg.de>,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] nvme-pci: Add IGNORE_DEV_SUBNQN quirk for Phison E19
Date: Mon, 23 Nov 2026 23:40:18 +0100
Message-ID: <20261123224020.134113-1-pmenzel@molgen.mpg.de>
X-Mailer: git-send-email 2.55.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=molgen.mpg.de; s=20260906; 
	t=1795473634; 
	h=from:from:subject:date:message-id:mime-version:content-type:content-transfer-encoding; 
	bh=P679Rl3XhQ1PcDNlcvazMnRpUQ1twsPQEDJNLqeUCt0=; 
	b=lqRIXnIllF9m9FMdQz2sCp8x6Q0K6x9rWIe7ifeKCi4g0ijxIOMgpHprI8kowuRfSTP/0uV9kIvQ
	dHFuN4+8H9EO2PEwjNGbHvZt6FexuTqCi3NEqAjorz8aKTCLLAQUIk7HRvc5UXijRlz9pY7t3AyW/C
	I/s8gFymp3cL6vgActokfdhFGjiyHmsNDc8cqWt4wL7x+UPcLqaj0YxfMOXRGH5gIvpOcJ2Qi+LEVE
	X+5eS9jbz/bVoPRGoGmdbiyXw27dNfPMz5W2mgVDb2ygyWSnYC3ctPFERyYDQvUKRam0CJJLGIzq8U
	cY4VU3vJGzZSH2DlVJRU5bFcZ8/o492A==
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261123_144125_296170_A1CE57A7 
X-CRM114-Status: GOOD (  12.06  )
X-Spam-Score: -4.4 (----)
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
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The Phison E19 (198:5019) in a Dell XPS 13 9315 reports:

    $ sudo nvme id-ctrl /dev/nvme0 | grep -E '^(vid|mn|fr|ver|subnqn) '
    vid       : 0x1987
    mn        : ESE2A044-512 NVMe Phison 512GB
    fr        : 19010008
    ver       : 0x10400
    subnqn    :

So every boot warns:

    nvme nvme0: missing or invalid SUBNQN field.

and the kernel falls back to the generated NQN anyway:

    $ cat /sys/class/nvme/nvme0/subsysnqn
    nqn.2014.08.org.nvmexpress:19871987298E07241E4B00121487ESE2A044-512 NVMe Phison 512GB

Add NVME_QUIRK_IGNORE_DEV_SUBNQN, as for the Phison E16 (1987:5016), to
use the generated NQN without the warning. For this drive the subsystem
NQN stays the same.

Signed-off-by: Paul Menzel <pmenzel@molgen.mpg.de>
---
 drivers/nvme/host/pci.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 076603df01abb..ba5b1cdbb95e1 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -4398,7 +4398,8 @@ static const struct pci_device_id nvme_id_table[] = {
 		.driver_data = NVME_QUIRK_IGNORE_DEV_SUBNQN |
 				NVME_QUIRK_BOGUS_NID, },
 	{ PCI_DEVICE(0x1987, 0x5019),  /* phison E19 */
-		.driver_data = NVME_QUIRK_DISABLE_WRITE_ZEROES, },
+		.driver_data = NVME_QUIRK_IGNORE_DEV_SUBNQN |
+				NVME_QUIRK_DISABLE_WRITE_ZEROES, },
 	{ PCI_DEVICE(0x1987, 0x5021),   /* Phison E21 */
 		.driver_data = NVME_QUIRK_DISABLE_WRITE_ZEROES, },
 	{ PCI_DEVICE(0x1b4b, 0x1092),	/* Lexar 256 GB SSD */
-- 
2.54.0


