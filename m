Return-Path: <SRS0=8cAR=IF=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65347C433E0
	for <linux-nvme@archiver.kernel.org>; Sun,  7 Mar 2021 13:58:27 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 024ED65111
	for <linux-nvme@archiver.kernel.org>; Sun,  7 Mar 2021 13:58:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 024ED65111
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=WogdRWgpAFyEm6hIx2vVaq1FD0VJCP1V0206SghGJYk=; b=npybky83ua/+LWVfZ3oxULzP6
	fa3mw1dY1vW7UmlF6Z1ZKEXnihzR/mXdMCTm1plyeTNnG8Y52XE9gM0BTK6o9/TiW3aAERWg3sF2G
	759aS8FH6zwVUHptKJGvsWXmg5nFsXKsiL9GVo2RZH+NJEyMTBRBCqOMY88Bc7HdunDU8ThMXggzK
	kQswDreFWZfgYDBj11ShlGIBVYhM1/K5vLgIbutpzOebqLOaacgB5fSdILhwPTfEnq2FFasHmKqyg
	tx7KX+o4YthM+fdvCCNVxV7o/R3N5uvbNPmEzuLyr37xbVanrREbxJVwQLf5fCsK6DLdE4C+lnLeZ
	TW7lHga9g==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lItvA-00AJ8m-Vz; Sun, 07 Mar 2021 13:58:13 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lItux-00AJ2g-Nn
 for linux-nvme@lists.infradead.org; Sun, 07 Mar 2021 13:58:01 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id ECEDB6510A;
 Sun,  7 Mar 2021 13:57:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1615125478;
 bh=Noy7VcIB02OQkZj4tP6uPONYLse8hIx5KNQ+rhvWrVA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Sv2qE/3/KB4iLF4e90n08KFatix/IveOmXOk3rnD+1onZyVO8wUglbj4QWvvOfTau
 LBz8nQp1UKVEEBaN372IFBFADJk8Wb4hWavP7qFt6zfpmMEFFdNhuuRJJ4Azluhikl
 Px/Ee3Is6UFeVBXT5uzCHRww3TlKq11WZtd8bEuXCXLQp/JMxMH6/Hc7vdIhtBY23Z
 fSvsossWCuKWwM5F2qPT2gmV0SlBI0D7yN3TFKlRWmsoPzQyyqdWZh4CKsAC37n1md
 jgdJ/5p3ps79BxFaSCo/WScCwS+lVmL4j/IOZThoPMygp92X0UbAqhO4qYTaiFMmn9
 LMre/VE22Y9fA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Pascal Terjan <pterjan@google.com>, Christoph Hellwig <hch@lst.de>,
 Sasha Levin <sashal@kernel.org>, linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 5.11 10/12] nvme-pci: add quirks for Lexar 256GB SSD
Date: Sun,  7 Mar 2021 08:57:44 -0500
Message-Id: <20210307135746.967418-10-sashal@kernel.org>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210307135746.967418-1-sashal@kernel.org>
References: <20210307135746.967418-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210307_135800_107886_725AAAA0 
X-CRM114-Status: UNSURE (   9.57  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

From: Pascal Terjan <pterjan@google.com>

[ Upstream commit 6e6a6828c517fb6819479bf5187df5f39084eb9e ]

Add the NVME_QUIRK_NO_NS_DESC_LIST and NVME_QUIRK_IGNORE_DEV_SUBNQN
quirks for this buggy device.

Reported and tested in https://bugs.mageia.org/show_bug.cgi?id=28417

Signed-off-by: Pascal Terjan <pterjan@google.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/pci.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 14c5b52400ef..806a5d071ef6 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -3245,6 +3245,9 @@ static const struct pci_device_id nvme_id_table[] = {
 				NVME_QUIRK_IGNORE_DEV_SUBNQN, },
 	{ PCI_DEVICE(0x1987, 0x5016),	/* Phison E16 */
 		.driver_data = NVME_QUIRK_IGNORE_DEV_SUBNQN, },
+	{ PCI_DEVICE(0x1b4b, 0x1092),	/* Lexar 256 GB SSD */
+		.driver_data = NVME_QUIRK_NO_NS_DESC_LIST |
+				NVME_QUIRK_IGNORE_DEV_SUBNQN, },
 	{ PCI_DEVICE(0x1d1d, 0x1f1f),	/* LighNVM qemu device */
 		.driver_data = NVME_QUIRK_LIGHTNVM, },
 	{ PCI_DEVICE(0x1d1d, 0x2807),	/* CNEX WL */
-- 
2.30.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
