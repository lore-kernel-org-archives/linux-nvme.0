Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06A6EC4332F
	for <linux-nvme@archiver.kernel.org>; Mon,  7 Nov 2022 20:46:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Mo1IoZxL2Rc3as4wkOOmjS2i89Ql8ugECSEPpbB7MWg=; b=yK7jU48ihNWf6mK4PWAKoFEd2g
	cuvgLBRZmR6kDCcezujFId9LYSNJvL2Ai1y9G0FOiai6u7m/3WDqQPvmLAODKAFZePTEVuLtzahxy
	X15X+kcJ9eXVYBjf9/0gULCTZ5rGPxJyWFZkOUeA9az+3e1gD7FJTbo0ww7amhsX0eLLbBFa+0lhR
	5Bo5BpyAfNhBGqnpZDp7+KZKlkBoFsT7n0c/AzZ79qsQquCImef6nRsdr3pd89o2hhyLG1a4uSmhd
	vIrXy8Z6XdsLGTU/JY9Fys0zNnQ71ZNUgrm/W6m2Pn72D7x7E9jwGFUCNl26qb0IyC1oGwZzut0de
	mw0xLljw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1os90Z-000O8f-F9; Mon, 07 Nov 2022 20:46:15 +0000
Received: from post.baikalelectronics.com ([213.79.110.86])
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1os90S-000O7e-1z
	for linux-nvme@lists.infradead.org; Mon, 07 Nov 2022 20:46:10 +0000
Received: from post.baikalelectronics.com (localhost.localdomain [127.0.0.1])
	by post.baikalelectronics.com (Proxmox) with ESMTP id 34930E0EAB;
	Mon,  7 Nov 2022 23:39:52 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	baikalelectronics.ru; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:from:from:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=post;
	 bh=Mo1IoZxL2Rc3as4wkOOmjS2i89Ql8ugECSEPpbB7MWg=; b=HSnlfG0Qw9cV
	EUSsAE5gB5l5RsG7gI/yi6CDe4s5N3vm3ieRL+4mVVTCib1v3Qe8hMYO5JyK1oeM
	DkkeZ/pjHPRUfJvXkjb7UBvC3jPj7K8/3mGzx0DIQTljXbUrP99lf9FO/oXxLaBO
	3BSmLZTy88JYSOFHHyVMBYOXodfcWjI=
Received: from mail.baikal.int (mail.baikal.int [192.168.51.25])
	by post.baikalelectronics.com (Proxmox) with ESMTP id EE6EAE0E1D;
	Mon,  7 Nov 2022 23:39:51 +0300 (MSK)
Received: from localhost (192.168.168.10) by mail (192.168.51.25) with
 Microsoft SMTP Server (TLS) id 15.0.1395.4; Mon, 7 Nov 2022 23:39:51 +0300
From: Serge Semin <Sergey.Semin@baikalelectronics.ru>
To: Jens Axboe <axboe@kernel.dk>, Jens Axboe <axboe@fb.com>, Keith Busch
	<kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>, Jonathan Derrick
	<jonathan.derrick@linux.dev>, Sagi Grimberg <sagi@grimberg.me>, Scott Bauer
	<scott.bauer@intel.com>, Rafael Antognolli <Rafael.Antognolli@intel.com>
CC: Serge Semin <Sergey.Semin@baikalelectronics.ru>, Serge Semin
	<fancer.lancer@gmail.com>, Alexey Malahov
	<Alexey.Malahov@baikalelectronics.ru>, Pavel Parkhomenko
	<Pavel.Parkhomenko@baikalelectronics.ru>, <linux-nvme@lists.infradead.org>,
	<linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v3] block: sed-opal: kmalloc the cmd/resp buffers
Date: Mon, 7 Nov 2022 23:39:44 +0300
Message-ID: <20221107203944.31686-1-Sergey.Semin@baikalelectronics.ru>
X-Mailer: git-send-email 2.38.0
In-Reply-To: <20220929224648.8997-4-Sergey.Semin@baikalelectronics.ru>
References: <20220929224648.8997-4-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [192.168.168.10]
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221107_124608_686100_6EC4D7A2 
X-CRM114-Status: GOOD (  17.13  )
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

In accordance with [1] the DMA-able memory buffers must be
cacheline-aligned otherwise the cache writing-back and invalidation
performed during the mapping may cause the adjacent data being lost. It's
specifically required for the DMA-noncoherent platforms [2]. Seeing the
opal_dev.{cmd,resp} buffers are implicitly used for DMAs in the NVME and
SCSI/SD drivers in framework of the nvme_sec_submit() and sd_sec_submit()
methods respectively they must be cacheline-aligned to prevent the denoted
problem. One of the option to guarantee that is to kmalloc the buffers
[2]. Let's explicitly allocate them then instead of embedding into the
opal_dev structure instance.

Note this fix was inspired by the commit c94b7f9bab22 ("nvme-hwmon:
kmalloc the NVME SMART log buffer").

[1] Documentation/core-api/dma-api.rst
[2] Documentation/core-api/dma-api-howto.rst

Fixes: 455a7b238cd6 ("block: Add Sed-opal library")
Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>

---

Folks the NVME-part of the patchset has already been merged in
Link: https://lore.kernel.org/linux-nvme/20220929224648.8997-1-Sergey.Semin@baikalelectronics.ru/
This modification is only leftover of the original series. So I've resent
it as a separate patch.

Link: https://lore.kernel.org/linux-nvme/20220929224648.8997-4-Sergey.Semin@baikalelectronics.ru/
Changelog v3:
- Convert to allocating the cmd-/resp-buffers instead of cache-aligning
  them. (@Jonathan)
- Resubmit the patch separately from the original series.
- Rebase onto the kernel 6.1-rc3
---
 block/sed-opal.c | 32 ++++++++++++++++++++++++++++----
 1 file changed, 28 insertions(+), 4 deletions(-)

diff --git a/block/sed-opal.c b/block/sed-opal.c
index 2c5327a0543a..9bdb833e5817 100644
--- a/block/sed-opal.c
+++ b/block/sed-opal.c
@@ -87,8 +87,8 @@ struct opal_dev {
 	u64 lowest_lba;
 
 	size_t pos;
-	u8 cmd[IO_BUFFER_LENGTH];
-	u8 resp[IO_BUFFER_LENGTH];
+	u8 *cmd;
+	u8 *resp;
 
 	struct parsed_resp parsed;
 	size_t prev_d_len;
@@ -2175,6 +2175,8 @@ void free_opal_dev(struct opal_dev *dev)
 		return;
 
 	clean_opal_dev(dev);
+	kfree(dev->resp);
+	kfree(dev->cmd);
 	kfree(dev);
 }
 EXPORT_SYMBOL(free_opal_dev);
@@ -2187,6 +2189,18 @@ struct opal_dev *init_opal_dev(void *data, sec_send_recv *send_recv)
 	if (!dev)
 		return NULL;
 
+	/*
+	 * Presumably DMA-able buffers must be cache-aligned. Kmalloc makes
+	 * sure the allocated buffer is DMA-safe in that regard.
+	 */
+	dev->cmd = kmalloc(IO_BUFFER_LENGTH, GFP_KERNEL);
+	if (!dev->cmd)
+		goto err_free_dev;
+
+	dev->resp = kmalloc(IO_BUFFER_LENGTH, GFP_KERNEL);
+	if (!dev->resp)
+		goto err_free_cmd;
+
 	INIT_LIST_HEAD(&dev->unlk_lst);
 	mutex_init(&dev->dev_lock);
 	dev->flags = 0;
@@ -2194,11 +2208,21 @@ struct opal_dev *init_opal_dev(void *data, sec_send_recv *send_recv)
 	dev->send_recv = send_recv;
 	if (check_opal_support(dev) != 0) {
 		pr_debug("Opal is not supported on this device\n");
-		kfree(dev);
-		return NULL;
+		goto err_free_resp;
 	}
 
 	return dev;
+
+err_free_resp:
+	kfree(dev->resp);
+
+err_free_cmd:
+	kfree(dev->cmd);
+
+err_free_dev:
+	kfree(dev);
+
+	return NULL;
 }
 EXPORT_SYMBOL(init_opal_dev);
 
-- 
2.38.0



