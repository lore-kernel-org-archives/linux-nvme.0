Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9084CCA470
	for <linux-nvme@archiver.kernel.org>; Wed,  1 Oct 2025 14:22:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=uNevoi5c4TYxxgrSOibABnfZWKKnkQvMRPHww3HP3sI=; b=pHSPjk58ViChL8Px08HSMAfmNb
	RP9hcJLUOQbkNtUgCQGip7CxR46fkQGb8dDl+9YzXnvCxdm02hRFGaJSq+1xH6OruHjD+HpnXQ4OR
	u3lzjGr3Ior7aK1mu3q2ylspD02Ry5j1JiFijOjappvjxP16krRiVG3ebC+hDeOxRgXrPS1zFSWyB
	bhS5UNVizk0A/fUqWJh6B1pXJq13riYGc7/pU23QF6perSFz5lyxWAcKeNrrI5ebEFDFfp5Etmvwb
	kAsCOFfsGKmjtYN1RdICuainGLy2h+5N75sLBeznvO3cw45iCWe8U0vTZztQxGXMAHQ4AfnrgUS9p
	GBlNDflA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v3xih-00000008A2T-0Z6M;
	Wed, 01 Oct 2025 14:22:15 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v3xif-00000008A19-3har
	for linux-nvme@lists.infradead.org;
	Wed, 01 Oct 2025 14:22:13 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 0D9706251B;
	Wed,  1 Oct 2025 14:22:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A05CC4CEF5;
	Wed,  1 Oct 2025 14:22:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759328532;
	bh=GygyjBV1IvwFur06Xj721FAxbExPs88wo7lsMzjuK+I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jw7PChbn+KTMF5Xw17f5HPyelEY3wySMfgVsyDfHlKoGYD92o+jVvYGu8e2N8NIrT
	 3xtY0DF/UvjZBGS8f0NMWsjlETcAQy0TDMTsBOnkGgF7xh7l1HP4d/tGTqLWl/T6x6
	 PLK85cF6Q5ov9lsDVrzD+FzTuwcTisVmxXLCrnSpEnrPQc0OkCZfEOR3LKpbKhDgZy
	 u1eiTIJ7JTb73LGgzhMAVxPHhakcJ1m+mzW1HbxRYmTXZmLoxTHzetERyWnDYPR4pe
	 noqXzkxZHTFoyUOsvyX7rfIiwmNK64XFJAy86kBcmVYjIk2g12ivqBBE67VudhKjcq
	 qKLntlTsOCKRQ==
From: Hannes Reinecke <hare@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@kernel.org>,
	kernel test robot <lkp@intel.com>
Subject: [PATCH 1/3] nvme-keyring: use correct format specifier
Date: Wed,  1 Oct 2025 16:21:58 +0200
Message-ID: <20251001142200.61696-2-hare@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251001142200.61696-1-hare@kernel.org>
References: <20251001142200.61696-1-hare@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Use correct format specifier for pr_debug.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202509302151.WHyjRfcE-lkp@intel.com/

Signed-off-by: Hannes Reinecke <hare@kernel.org>
---
 drivers/nvme/common/keyring.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/common/keyring.c b/drivers/nvme/common/keyring.c
index a58c93c6d495..5fdfaf7abd30 100644
--- a/drivers/nvme/common/keyring.c
+++ b/drivers/nvme/common/keyring.c
@@ -340,7 +340,7 @@ static int nvme_dhchap_psk_preparse(struct key_preparsed_payload *prep)
 		keylen = 70;
 		break;
 	default:
-		pr_debug("%s: Invalid data length %lu\n", __func__, datalen);
+		pr_debug("%s: Invalid data length %u\n", __func__, datalen);
 		prep->payload.data[0] = NULL;
 		prep->quotalen = 0;
 		return -EINVAL;
-- 
2.43.0


