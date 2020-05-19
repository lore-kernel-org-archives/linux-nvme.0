Return-Path: <SRS0=SbN/=7B=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9348C433E0
	for <linux-nvme@archiver.kernel.org>; Tue, 19 May 2020 14:07:10 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7867D20823
	for <linux-nvme@archiver.kernel.org>; Tue, 19 May 2020 14:07:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="PQJ1r++q";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="fP+HHQmO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7867D20823
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mellanox.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=kckE7yMUyj+3kh+eoyyfBqKg1Dyq7R+Rfm8ATjBhQU0=; b=PQJ1r++qPuoIDh
	j62llNu3xvipnGwtG6vWUAmx7VZ38+s902MddKf4GxoegeHxCu9Mc9RKLLsxpRdNCSH7xY04kolGa
	1/ERpeTflsPIFIexFRexVl5s5bJm6dZ5lf7H8O2R/7gIEjEVLualfyNx9g875vfA070b/n5B9wJvI
	VEP61Jkg9AQO1ZXx5Z8nRpKggIs7cSTRe+z8+oU5y2YoKeJK25UbWEZ4Eb62Cund5hKPa5gQehDZ6
	2Lrxg/b8i7DMuVyBkvWI4sShjtlaY0i/96qByFC8nPg+R2+5KWNYhosD9jLUfr7DFlK0bTmIcHNUj
	C9or048LnDa0i0+OV51A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jb2te-00028x-Lk; Tue, 19 May 2020 14:07:06 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jb2sx-0001Z6-Gs
 for linux-nvme@bombadil.infradead.org; Tue, 19 May 2020 14:06:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description;
 bh=KVfwceqOfUpTXqxur0nZPqLz28I7+NRNiqBNJyVUAzk=; b=fP+HHQmOwdmXt01TDNPmp+E8jQ
 mC94IhQmqpTs+JFJQv+45lPZdaplPZSmKsf8deNUeDKB2JdhQibYden/xshqQh55lYrtGTk0SIRTX
 jTFkjxYwKfERSMdTSXT5Kiz1i6MiMEDepdB5mwNEibfzVGJiKf/vycYcL9FsvmeXUXcRnXfQc8fE6
 bqv/b6PYoauPBdQXKzP8ylnMWeuhcJziHbhJVw7Q/SioadHCtbvvXTgSRWibC4Wo4hzWBv5Wu5ot9
 Kd2HlXjAiYV6RS9D6QkPyxDJT8iV64VkQUwqumK2LMG/IsbBgDkStD+Bv6tkiTduZeyyXBSwDdiQm
 SC4DHkxQ==;
Received: from mail-il-dmz.mellanox.com ([193.47.165.129] helo=mellanox.co.il)
 by casper.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jb2so-0004WZ-Dx
 for linux-nvme@lists.infradead.org; Tue, 19 May 2020 14:06:21 +0000
Received: from Internal Mail-Server by MTLPINE1 (envelope-from
 maxg@mellanox.com)
 with ESMTPS (AES256-SHA encrypted); 19 May 2020 17:06:04 +0300
Received: from mtr-vdi-031.wap.labs.mlnx. (mtr-vdi-031.wap.labs.mlnx
 [10.209.102.136])
 by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id 04JE63xo006590;
 Tue, 19 May 2020 17:06:04 +0300
From: Max Gurtovoy <maxg@mellanox.com>
To: sagi@grimberg.me, linux-nvme@lists.infradead.org, kbusch@kernel.org,
 hch@lst.de, martin.petersen@oracle.com, jsmart2021@gmail.com,
 axboe@kernel.dk
Subject: [PATCH 07/16] nvme: introduce NVME_INLINE_METADATA_SG_CNT
Date: Tue, 19 May 2020 17:05:54 +0300
Message-Id: <20200519140603.166576-8-maxg@mellanox.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200519140603.166576-1-maxg@mellanox.com>
References: <20200519140603.166576-1-maxg@mellanox.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200519_150616_133448_98204547 
X-CRM114-Status: UNSURE (   9.93  )
X-CRM114-Notice: Please train this message.
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
Cc: vladimirk@mellanox.com, shlomin@mellanox.com, israelr@mellanox.com,
 James Smart <james.smart@broadcom.com>, idanb@mellanox.com, oren@mellanox.com,
 Max Gurtovoy <maxg@mellanox.com>, nitzanc@mellanox.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

From: Israel Rukshin <israelr@mellanox.com>

SGL size of metadata is usually small. Thus, 1 inline sg should cover
most cases. The macro will be used for pre-allocate a single SGL entry
for metadata. The preallocation of small inline SGLs depends on SG_CHAIN
capability so if the ARCH doesn't support SG_CHAIN, use the runtime
allocation for the SGL. This patch is a preparation for adding metadata
(T10-PI) over fabric support.

Signed-off-by: Israel Rukshin <israelr@mellanox.com>
Signed-off-by: Max Gurtovoy <maxg@mellanox.com>
Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: James Smart <james.smart@broadcom.com>
---
 drivers/nvme/host/nvme.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 6c7e76c..7c2e6d4 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -31,8 +31,10 @@
 
 #ifdef CONFIG_ARCH_NO_SG_CHAIN
 #define  NVME_INLINE_SG_CNT  0
+#define  NVME_INLINE_METADATA_SG_CNT  0
 #else
 #define  NVME_INLINE_SG_CNT  2
+#define  NVME_INLINE_METADATA_SG_CNT  1
 #endif
 
 extern struct workqueue_struct *nvme_wq;
-- 
1.8.3.1


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
