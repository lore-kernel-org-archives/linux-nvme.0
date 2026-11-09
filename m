Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B5EF606A31C
	for <linux-nvme@archiver.kernel.org>; Mon,  9 Nov 2026 12:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=KGCXKn59;
	dkim=pass (1024-bit key, unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=TOCMc/A8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=l6oQAKU6L4xOX3anBu1nSTZENby6wcsKmNwcAyInJWs=; b=KGCXKn59n982gP
	x6SQe3H0mhq4o62NEXOhMXV67hHSIRbxOCmiw38M+d2iu9unK+VRsr62P+pZGBwpxzxC5I2ohDhOP
	8jJkfpVOm6Q5UDrkPhWewxrOzxQ1QDW1ql+xho++WVz/x/Luvr8oggaJT4xqpBXBdGQSp/UM77vep
	R2zdNvCz8WC+wfLNalcGaRawg8jQCeUnkd4eXXXRxAoZ6pZgqD56AM0KrB67zjF7EICFspyXG8rGw
	bkMf0v6/pKfaWZzyrirVYPkPCn4NHZfA0wDXzVLmwRCQkrw4yFXo8T1S3eUFjFIXB/nv+GaoFAhKp
	js6guKL5AIaXFGCCMLBQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQO4x-00000000bQF-2Sie;
	Mon, 09 Nov 2026 12:02:27 +0000
Received: from out30-124.freemail.mail.aliyun.com ([115.124.30.124])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQO4p-00000000bN1-1LZ4
	for linux-nvme@lists.infradead.org;
	Mon, 09 Nov 2026 12:02:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1794225734; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=l6oQAKU6L4xOX3anBu1nSTZENby6wcsKmNwcAyInJWs=;
	b=TOCMc/A8PBcKpojouI8tcmg1mQFNZceoErVE4CIWKpmZm9fsICR9RMztAUOz+tRB4dd4GO/Z+Gz3BHepsKLI81qfZbdtGg91M7Dp+NTHk4p16XZqAL+1oVdOUIp5VJflOvIv8MamD3rt1c1xD2fp/2rDoYDk26kjbTZ8c0OcTP4=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045098064;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0XEOSQVP_1794225733;
Received: from localhost(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0XEOSQVP_1794225733 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 09 Nov 2026 20:02:14 +0800
From: Guixin Liu <kanie@linux.alibaba.com>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Nilay Shroff <nilay@linux.ibm.com>,
	Daniel Wagner <dwagner@suse.de>,
	Hannes Reinecke <hare@suse.de>
Cc: linux-nvme@lists.infradead.org
Subject: [PATCH 1/2] nvme: define the SMART / Health Status async event bit
Date: Mon,  9 Nov 2026 20:02:03 +0800
Message-ID: <20261109120207.1352165-2-kanie@linux.alibaba.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20261109120207.1352165-1-kanie@linux.alibaba.com>
References: <20261109120207.1352165-1-kanie@linux.alibaba.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261109_040219_954927_14940AE5 
X-CRM114-Status: GOOD (  10.01  )
X-Spam-Score: -17.6 (-----------------)
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
X-Spam-Status: No, score=-26.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

NVMe 2.x requires controllers to support the SMART / Health Status
asynchronous event (OAES bit 1), but the only event bits the header
defines are namespace attribute, firmware activation, ANA change and
discovery change. Define the missing bit so the host can subscribe to
the event.

Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
---
 include/linux/nvme.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index 6248711784b37..2b4f8e269d12d 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -867,6 +867,7 @@ enum {
 };
 
 enum {
+	NVME_AEN_BIT_SMART		= 1,
 	NVME_AEN_BIT_NS_ATTR		= 8,
 	NVME_AEN_BIT_FW_ACT		= 9,
 	NVME_AEN_BIT_ANA_CHANGE		= 11,
@@ -874,6 +875,7 @@ enum {
 };
 
 enum {
+	NVME_AEN_CFG_SMART		= 1 << NVME_AEN_BIT_SMART,
 	NVME_AEN_CFG_NS_ATTR		= 1 << NVME_AEN_BIT_NS_ATTR,
 	NVME_AEN_CFG_FW_ACT		= 1 << NVME_AEN_BIT_FW_ACT,
 	NVME_AEN_CFG_ANA_CHANGE		= 1 << NVME_AEN_BIT_ANA_CHANGE,
-- 
2.43.7


