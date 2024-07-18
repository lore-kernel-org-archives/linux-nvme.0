Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20C7BC3DA6F
	for <linux-nvme@archiver.kernel.org>; Thu, 18 Jul 2024 14:49:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9w6w8fj/NVeuDaz/n3xt5HI9PfhJPlkXbn8b7STLeyo=; b=mcWY7/s7cc4pighBA6g1qyVdRr
	vR+0TyiS/PP9kZyYQLDPIS+DohCUukJ3ikKUiUaABxfVmQ3lOEchjgRwSOR0uWs088+YtshpTHgye
	qH53IklF2i6Iy6CeS9pQIBXjvUnkYgMWOXDgIlxPQj/7GHfPjOZ+dD17e6WwPcCdQC6UgOawS1d8R
	GXecy3v3mC0u6Rly2ERSRiRQzSF+k3G12MAR4Rgs33DA0hVVwTMfVYhUHp1g917zdenwaLFJ0d+MR
	ul7xAmiuJbi7j3fJ7MqujYBFaVCIyh3RO2qB6xxv83eK0j2iAIqwdd0vnjshEd1Efo5cw3EtbvieF
	QCAEkW4g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sUSRj-0000000HKQD-3JYq;
	Thu, 18 Jul 2024 14:49:27 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sUSRf-0000000HKMf-0ZyQ
	for linux-nvme@lists.infradead.org;
	Thu, 18 Jul 2024 14:49:24 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 779E061B8D;
	Thu, 18 Jul 2024 14:49:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06C8FC4AF0D;
	Thu, 18 Jul 2024 14:49:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721314162;
	bh=IGQN+3vToEKGkbZeMg19jxplp7X75dKvMwMRNaa/cYg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QrSJSAhCemgiZabQ8d1iL08ayvT/zqs0KI8O7uswsJtxns/2ioTQMQK/NAleFU6UI
	 WoPm2Jrj19AjRfZH9AIXxm9y517aUmr7+wJ8PNnUjoedhCX+45bDPK3U8bNaGWjvYF
	 +K56gC5Kfs8xIoHfSWxuA3/GX8FC/b7ERnIJsmZEuLyYfq1xQMXceixIT9btLui1Hr
	 oZjkLPjm18Eu+nX3kmKPIOEM5DJIdCfzukA2DHVZp8poGN3JgLI/MnQfbQbZu3JUIh
	 2/e9asV8mTkmZTOnCXVpUQVZEDXDC9U4XrlnUL001VAvCig42/hCLOInm8CWByUjOi
	 N4KuiyDh//LCA==
From: Hannes Reinecke <hare@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@kernel.org>
Subject: [PATCH 4/8] nvme: add a newline to the 'tls_key' sysfs attribute
Date: Thu, 18 Jul 2024 16:48:54 +0200
Message-Id: <20240718144858.19074-5-hare@kernel.org>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240718144858.19074-1-hare@kernel.org>
References: <20240718144858.19074-1-hare@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240718_074923_261347_6617C90A 
X-CRM114-Status: GOOD (  11.37  )
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

Print a newline for easier userspace handling.

Signed-off-by: Hannes Reinecke <hare@kernel.org>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/host/sysfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/sysfs.c b/drivers/nvme/host/sysfs.c
index 72675b59a7a7..c391ad6c5a88 100644
--- a/drivers/nvme/host/sysfs.c
+++ b/drivers/nvme/host/sysfs.c
@@ -672,7 +672,7 @@ static ssize_t tls_key_show(struct device *dev,
 
 	if (!ctrl->tls_pskid)
 		return 0;
-	return sysfs_emit(buf, "%08x", ctrl->tls_pskid);
+	return sysfs_emit(buf, "%08x\n", ctrl->tls_pskid);
 }
 static DEVICE_ATTR_RO(tls_key);
 #endif
-- 
2.35.3


