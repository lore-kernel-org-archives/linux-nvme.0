Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31FADC52CD8
	for <linux-nvme@archiver.kernel.org>; Mon, 22 Jul 2024 12:02:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=oLQyJLpqfAdFkJXnxgEIBqmjb0XINeSVQ+CxRDn9XtM=; b=HTQ+SCnKQw7vdJAbdbniqoF387
	oFLRYyvEcz860XoA/GfM4BtVYhv0EItKWBfmKlMqVcNOc7/lmVTOW/rIi1fL5WBUUrt+1HkmeImjV
	GuvPP5lPjPpjf2j36UKpTJnoLvVuaAhlsiUUjn4G7PQq51Am9N/GsPNXwZbgb5stEK4f/xd/92vi6
	xSQrDbVaFdP36AtYsXMgwDIOsYg79VLlHhHjj6CtqhbNKelQPNGVLyHi8nu2nvdRz9/CpelADn/Vp
	WbXZ541JxcBnbUuMG+8Pb1NWwik8iHkdH11r/QTwPy0eQiMy7kA3RB3FXoKYiE4wRLie6ctE7o+FL
	fzDSzDqA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sVrkY-00000009SaF-3Ew4;
	Mon, 22 Jul 2024 12:02:42 +0000
Received: from sin.source.kernel.org ([2604:1380:40e1:4800::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sVrkV-00000009SXF-2Bsg
	for linux-nvme@lists.infradead.org;
	Mon, 22 Jul 2024 12:02:41 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id D17F6CE0764;
	Mon, 22 Jul 2024 12:02:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1A98C116B1;
	Mon, 22 Jul 2024 12:02:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721649757;
	bh=FmPlUIHoCmFMgHseJZrvVh9i0TiwVeYiFuAHc9ZSRBo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=u9j8FCFp2uXo3lvNiacL96UPwE+MTH3/Q+/lDyubvX8ivzlmrXhZ61rZNwtiKrQuc
	 O16gZ+nfRDIzDBG5tfH7MvWfnVegeMI+rFLRuiFlmUsLWb6aOmXxCjmZrnI2SR2hgz
	 lZiLY6zPhNphrYYm94DSDvL4grTEXyGa91S+uSr3X2dAPr+M5UvtlAP9gwOmLxEBBF
	 V2de4jRFVorkf6mHbwVZpUS4CJP6g1CobC8KYc3NZ8PLCo9wsgeMeGvLr1TuD+uGcY
	 mT9EYgJKFQ7Z3rMzrTIBpi0aV1aLZEr4A9vHOekDVk/Y4pGgRVg1A9nPivyWVccmib
	 ObpnNT+HuDUkA==
From: Hannes Reinecke <hare@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@kernel.org>
Subject: [PATCH 4/9] nvme: add a newline to the 'tls_key' sysfs attribute
Date: Mon, 22 Jul 2024 14:02:21 +0200
Message-Id: <20240722120226.88737-5-hare@kernel.org>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240722120226.88737-1-hare@kernel.org>
References: <20240722120226.88737-1-hare@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240722_050239_777938_38FDB9BB 
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

Print a newline for easier userspace handling.

Signed-off-by: Hannes Reinecke <hare@kernel.org>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Reviewed-by: Christoph Hellwig <hch@lst.de>
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


