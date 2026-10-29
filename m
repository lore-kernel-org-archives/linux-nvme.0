Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DEE5606A31A
	for <linux-nvme@archiver.kernel.org>; Thu, 29 Oct 2026 12:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=CDK+vfJS;
	dkim=pass (1024-bit key, unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=dShWCLPj
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=eKNqxPXo2f1HlBX/QJt5hYYTo8TpTFFA9ZHyOxUkezg=; b=CDK+vfJSQVVY7C
	zUHjrJ0wDJPQQHAdRksaQCLxSb4R/Pc1Q5C5xp78cqjbyf4IcRi7iWqYQkxDAzTFkqhcqj2+i9Zii
	FoGUZIpLOSPSU3bC/oriViASZ/nKw+RXUlbieoLsQ/zBl7GofodLjhq/f6lurLCxP4rTeF57hiICf
	ypHoAJpSCG1b+AmZkJw8O1YywdFUGWFqkbbPXvHpI8XdCkLjHB1aPsliiyApbiNu8wGk4IHjKzL2v
	WwB+nwcNspWfurjmM/v6+XfKmINkPfwgWotoykGHq7ZOvSOuIjjebiAcwqSON82SCOX+idpjOZ+qp
	3E3MSSYbo+tPExLkghzA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xMPFu-000000099Ho-1wmH;
	Thu, 29 Oct 2026 12:29:18 +0000
Received: from out30-113.freemail.mail.aliyun.com ([115.124.30.113])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xMPFr-000000099Ds-2Mqp
	for linux-nvme@lists.infradead.org;
	Thu, 29 Oct 2026 12:29:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1793276952; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=eKNqxPXo2f1HlBX/QJt5hYYTo8TpTFFA9ZHyOxUkezg=;
	b=dShWCLPjowkpMIr5lNRqdetjar5tX5dy223qoOGGxBV3WGzgoHh/Bs2R4wbQgvTcWX5zsUvfWROI+fFM4/HKa9uyE4CMGtT4iE9bkzmOGTMJVBKv9iM38pZubLXrlXRSKLpFYxyPThbZH6TX+jxmnLJ/TlPNBdYtEjs0ezjY3VA=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam011083073210;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0XDjUB61_1793276950;
Received: from localhost(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0XDjUB61_1793276950 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 29 Oct 2026 20:29:11 +0800
From: Guixin Liu <kanie@linux.alibaba.com>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Nilay Shroff <nilay@linux.ibm.com>,
	Daniel Wagner <dwagner@suse.de>,
	Hannes Reinecke <hare@suse.de>
Cc: linux-nvme@lists.infradead.org
Subject: [PATCH v3 03/12] nvme: export nvme_bdev_ops
Date: Thu, 29 Oct 2026 20:28:24 +0800
Message-ID: <20261029122833.284572-4-kanie@linux.alibaba.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20261029122833.284572-1-kanie@linux.alibaba.com>
References: <20261029122833.284572-1-kanie@linux.alibaba.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261029_052915_790802_42DB8FCB 
X-CRM114-Status: UNSURE (   8.87  )
X-CRM114-Notice: Please train this message.
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

Export the NVMe block device operations so that other subsystems can
recognize a block device as an NVMe namespace through its operations
pointer and reach the NVMe structures behind it.  The NVMe target FDP
bridge uses this to detect an NVMe backing device of a namespace.

Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
---
 drivers/nvme/host/core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 7eb0f9fe6b18..0099ce5730b2 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2719,6 +2719,7 @@ const struct block_device_operations nvme_bdev_ops = {
 	.report_zones	= nvme_report_zones,
 	.pr_ops		= &nvme_pr_ops,
 };
+EXPORT_SYMBOL_GPL(nvme_bdev_ops);
 
 static int nvme_wait_ready(struct nvme_ctrl *ctrl, u32 mask, u32 val,
 		u32 timeout, const char *op)
-- 
2.43.7


