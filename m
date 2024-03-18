Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C307C54E58
	for <linux-nvme@archiver.kernel.org>; Mon, 18 Mar 2024 15:04:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4m0uCWjvvJk5ELQ+0YQw5eem7SbfEHq2dOUHRsIVJ68=; b=DqomjzLA5jBgcSfiQNzZe0l6JE
	gQ1kVQJc+Dxv2DPtexs4vI+oiGMOPp5+pI/+Uz0dVUXh4JcWoganCjR4dyiyXW/dGtzEs4kAaszX1
	QDTFlobHS67uBtQJPPDo1JWwNlkMeA4g8RDYy5xc0c408F3sde59xPLIpzMg7XYsLXhLQPwk1iKpZ
	NccVN/A1ur2sQf8GjaVsdF9jUkKCvYOQWdrTGFlygo/EPLggVaHypfJNG/cXjf9H6xBAMY6r9MGUs
	5GTLFQGoCvnsjIGM1ALUbwhotuyPxknzxYolTDbSBgSkIELNYbyt8eOyicgbjaZLN7jKgnseh0x+L
	Rbz1YWAA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rmEXA-00000008uh5-1Q6B;
	Mon, 18 Mar 2024 15:04:16 +0000
Received: from sin.source.kernel.org ([145.40.73.55])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rmEWk-00000008uMk-0pUD
	for linux-nvme@lists.infradead.org;
	Mon, 18 Mar 2024 15:03:52 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 8BB90CE0A3C;
	Mon, 18 Mar 2024 15:03:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D4D6C433A6;
	Mon, 18 Mar 2024 15:03:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710774227;
	bh=vj03jVFuEyOzNv4kT1ZPRs/8WQqiLwSnh8DQ1T5E8Ig=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OqmEk6kkS0SCt2RoaxNOIpnDLskZSX7sSt3/dTbSnNuUhbmP7RDnfWc/KHzSpXTPW
	 y7Sav3XQZ1c76Rd+wvoxP7ojrCtUqPXvpq+3sMMLuJLMhcB1A8C6WG3k1Ku5mYpyjE
	 8xLrKKpxq0wwhLFydrLqUJZYvj335Xx1MyWy20F3z62PvHzybcb/fSihFAdB0isZTD
	 cW0t9eReiYH5Z9qXAvdReV20VXDUAYunjkJW3+mp6Y2s0cvrPhI3t9TTCFh9YcICX7
	 Cn3+9ulkakI0awSPzz4yOY92cI9yfb4eq4wHFU9+aV2bHQVd1jkmYery76ZkoA50KV
	 tBP411npkqZGg==
From: Hannes Reinecke <hare@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@kernel.org>,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCH 10/17] nvme: add a newline to the 'tls_key' sysfs attribute
Date: Mon, 18 Mar 2024 16:03:09 +0100
Message-Id: <20240318150316.138501-11-hare@kernel.org>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240318150316.138501-1-hare@kernel.org>
References: <20240318150316.138501-1-hare@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240318_080350_519974_D9AC5E84 
X-CRM114-Status: GOOD (  10.91  )
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

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/nvme/host/sysfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/sysfs.c b/drivers/nvme/host/sysfs.c
index 1f9e57fbfee3..07ec26de2d91 100644
--- a/drivers/nvme/host/sysfs.c
+++ b/drivers/nvme/host/sysfs.c
@@ -679,7 +679,7 @@ static ssize_t tls_key_show(struct device *dev,
 	    test_bit(KEY_FLAG_INVALIDATED, &key->flags))
 		return -EKEYREVOKED;
 
-	return sysfs_emit(buf, "%08x", key_serial(key));
+	return sysfs_emit(buf, "%08x\n", key_serial(key));
 }
 static DEVICE_ATTR_RO(tls_key);
 #endif
-- 
2.35.3


