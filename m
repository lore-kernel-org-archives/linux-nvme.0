Return-Path: <SRS0=kA4j=JG=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C74FC43461
	for <linux-nvme@archiver.kernel.org>; Fri,  9 Apr 2021 18:14:14 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D29A161181
	for <linux-nvme@archiver.kernel.org>; Fri,  9 Apr 2021 18:14:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D29A161181
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=flawful.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=PkQwEob1QvHVcrr+Ajh80HgY3aiO9h7sbM2i9CYObJc=; b=kY+hO9jRy7q/LwOKgos1joNk6+
	GVlXbmlNlBRq4lojQYV65zc1AM2NQ01RFB1Nhd4cQf+roZQOLnVjZsawnD5tEPsY7nfoP36eqzDmR
	Ks6UmKNTba89qNZOO/WLEGEmvNk6WbvhwBPYmkcGGZGVQ/Qt6kfHsyAus0+ra1Cd63Iep/FqPpo4h
	crquNPdKXnRuozkoNrF+a9l5dfIxYReX0WY3UfM96bgGlXi9aPX4T9+Z+447U+aQjR7OH71rQ1goW
	IdVGl3GV+BY3NjiSDMzzTtnxqS11MrtgxoaBxRZwJfrjiStM2yXrElSbz9gWlY0eBQVHU6qSIWJTK
	DAuOzBuQ==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lUvdu-001IB7-C5; Fri, 09 Apr 2021 18:14:06 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lUvdp-001I6r-EM
 for linux-nvme@desiato.infradead.org; Fri, 09 Apr 2021 18:14:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:In-Reply-To:References;
 bh=d9+NVrEhCD/F0hqwPtTi0LWkrNwo6qZA/Ms9P1Fu/dE=; b=v8BvKTPTb79IVNf/MCKXu2QKvL
 ArUT/1kYn+u/PqK0gEGFsQX0LEetcXHwn4B+DdkWb61Waw5oX+IFMVOzAquJ1NoCXJvBvdVaUBsgv
 z6htw0nGCTxVlbmkJM+nQEjlT7naaPaXeNiF7B/x+ASN6D1nYbdo7djGwDqaEYfCmDSkdTRYTycSx
 QsCPwGscAlZmOka1G4C+QJgwmnoIk0lzTbdKjz8ZGHGOAHftoaq25BkLpku2OuGvpRQgdgU8lHWjH
 UOWurjq+Wa3zhK+dpvQypQZSOaT9LBwkDbycZ8RILnAlZ7vlmPNYnBfQ2CA3YCaWzX4DiU0a7ljGY
 WIETjSCw==;
Received: from pio-pvt-msa2.bahnhof.se ([79.136.2.41])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lUvdk-004ieI-Lm
 for linux-nvme@lists.infradead.org; Fri, 09 Apr 2021 18:14:00 +0000
Received: from localhost (localhost [127.0.0.1])
 by pio-pvt-msa2.bahnhof.se (Postfix) with ESMTP id 7AE903F455
 for <linux-nvme@lists.infradead.org>; Fri,  9 Apr 2021 20:13:36 +0200 (CEST)
Authentication-Results: pio-pvt-msa2.bahnhof.se; dkim=pass (1024-bit key;
 unprotected) header.d=flawful.org header.i=@flawful.org header.b=pwrfuTEn; 
 dkim=pass (1024-bit key) header.d=flawful.org header.i=@flawful.org
 header.b=vWJAMXWS; dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
Received: from pio-pvt-msa2.bahnhof.se ([127.0.0.1])
 by localhost (pio-pvt-msa2.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id GRz0bf6nzOGT for <linux-nvme@lists.infradead.org>;
 Fri,  9 Apr 2021 20:13:35 +0200 (CEST)
Received: by pio-pvt-msa2.bahnhof.se (Postfix) with ESMTPA id ABF5E3F451
 for <linux-nvme@lists.infradead.org>; Fri,  9 Apr 2021 20:13:35 +0200 (CEST)
Received: by flawful.org (Postfix, from userid 112)
 id D10591065; Fri,  9 Apr 2021 20:13:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flawful.org; s=mail;
 t=1617992027; bh=d9+NVrEhCD/F0hqwPtTi0LWkrNwo6qZA/Ms9P1Fu/dE=;
 h=From:To:Cc:Subject:Date:From;
 b=pwrfuTEniK87v6V5CD65BIbUv2zYpCcTKg6ZuoY+BdyZTFynIczUQNXkSoCyDER24
 9c+deaekvu50j27ilrOKVsc/TuNbB1xqWZTzylBo21MYwHD3A2gUeT4vbKMoB9y1GM
 IU8eLt7fNvKOE6FnRVcI0xmodZZxB7/wbQPmYkCs=
Received: from x1-carbon.lan (OpenWrt.lan [192.168.1.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by flawful.org (Postfix) with ESMTPSA id D2C50902;
 Fri,  9 Apr 2021 20:13:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flawful.org; s=mail;
 t=1617992012; bh=d9+NVrEhCD/F0hqwPtTi0LWkrNwo6qZA/Ms9P1Fu/dE=;
 h=From:To:Cc:Subject:Date:From;
 b=vWJAMXWS8k0oAnUQExQned5Wptkii57LjTBKwvRlPAMI1YVsn4yfgyBm47hLLqzP9
 wLJ0HZr2lszjuHIFj1jAnpMXThqG/jRDy6bmp9yJ3YiSUpE5vfzrF6ScmWL8LJpzNo
 aQiEAESB4hYsIK/qOu8ZTT2iAsk2wbCNPfkOEN+k=
From: Niklas Cassel <nks@flawful.org>
To: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Cc: Niklas Cassel <niklas.cassel@wdc.com>, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH] nvme-pci: don't simple map sgl when sgls are disabled
Date: Fri,  9 Apr 2021 20:12:55 +0200
Message-Id: <20210409181255.101847-1-nks@flawful.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210409_111357_063777_83237647 
X-CRM114-Status: GOOD (  14.43  )
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

From: Niklas Cassel <niklas.cassel@wdc.com>

According to the module parameter description for sgl_threshold,
a value of 0 means that SGLs are disabled.

If SGLs are disabled, we should respect that, even for the case
where the request is made up of a single physical segment.

Fixes: 297910571f08 ("nvme-pci: optimize mapping single segment requests using SGLs")
Signed-off-by: Niklas Cassel <niklas.cassel@wdc.com>
---
 drivers/nvme/host/pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index d47bb18b976a..b06e685d1250 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -854,7 +854,7 @@ static blk_status_t nvme_map_data(struct nvme_dev *dev, struct request *req,
 				return nvme_setup_prp_simple(dev, req,
 							     &cmnd->rw, &bv);
 
-			if (iod->nvmeq->qid &&
+			if (iod->nvmeq->qid && sgl_threshold &&
 			    dev->ctrl.sgls & ((1 << 0) | (1 << 1)))
 				return nvme_setup_sgl_simple(dev, req,
 							     &cmnd->rw, &bv);
-- 
2.30.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
