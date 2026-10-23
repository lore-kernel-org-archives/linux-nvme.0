Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DE6F606A31A
	for <linux-nvme@archiver.kernel.org>; Fri, 23 Oct 2026 08:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=L6mIJEU4;
	dkim=pass (1024-bit key, unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=NKZhAsuv
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=IDeM7YsEZ4ifkdn8oVcb47xTY9dtW2yaDw5e6gon9As=; b=L6mIJEU4CPMk2g
	1MwzsIiRFa1HYOEbYWiPPL61l37hrRg2FcvGMIaIVK+j+61jIJ/JIvbBsxvu329AL55cPjGfb+aan
	X9QX6GzL8w5AIv1GpEt2Dipu2CePv8fX6W4bMsQA3yXQZJwceLPbN8UmkUv6eZKv+VG4Bdy2bBU+7
	N+tUInuvYY/nHn1/WhRGsGMrG+qXdI9tdbRpitvBVPVaME8GsW6F5IxmTm4WeR/8ofOrROvh79uov
	bCiYzAooAEDoAlJ6KcAlGZ6tJOyqVJA+M1A6z309WALYh+gGikcTNFwLSh/Ih9MhW4g12U3qLUapD
	Tegjrjt4MjKwfaALmvIg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xKAF9-0000000FqrL-3ZIO;
	Fri, 23 Oct 2026 08:03:15 +0000
Received: from out199-7.us.a.mail.aliyun.com ([47.90.199.7])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xKAF4-0000000Fqkd-0AQA
	for linux-nvme@lists.infradead.org;
	Fri, 23 Oct 2026 08:03:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1792742586; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=IDeM7YsEZ4ifkdn8oVcb47xTY9dtW2yaDw5e6gon9As=;
	b=NKZhAsuv5qQYB6c6w3TKM2gjR4KYfiwRxQ/6AdMYxq8xJSfwbHpBtpeyb527LlcwGQlrsWQCmcGjHjRHVtSPF9UGtB4bjYtgtS37Uyzc6PBxwLl3vvOUKAFKn+wgzMwtbH809FwescteeqZhcuHztURJx/CxpAy5FL+eWqXU3iQ=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R581e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037026112;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0XDLNnGg_1792742584;
Received: from localhost(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0XDLNnGg_1792742584 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 23 Oct 2026 16:03:04 +0800
From: Guixin Liu <kanie@linux.alibaba.com>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Nilay Shroff <nilay@linux.ibm.com>,
	Daniel Wagner <dwagner@suse.de>,
	Hannes Reinecke <hare@suse.de>
Cc: linux-nvme@lists.infradead.org
Subject: [PATCH 05/11] nvmet: report the Endurance Group Identifier in the CS-INDEP identify data
Date: Fri, 23 Oct 2026 16:02:45 +0800
Message-ID: <20261023080251.2606443-6-kanie@linux.alibaba.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20261023080251.2606443-1-kanie@linux.alibaba.com>
References: <20261023080251.2606443-1-kanie@linux.alibaba.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261023_010311_699404_B23F63CF 
X-CRM114-Status: UNSURE (   8.64  )
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
X-Spam-Status: No, score=-26.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The Identify Namespace data structure (CNS 00h) reports the Endurance
Group Identifier of the namespace, but the I/O Command Set Independent
Identify Namespace data structure (CNS 08h) leaves the field zeroed.
Hosts that implement NVMe 2.0 or later, or that cannot use CNS 00h,
take the Endurance Group Identifier from the CS-INDEP data structure
and thus always see 0, which breaks every consumer of the identifier:
the FDP feature and log pages and the Rotational Media Information
log page are addressed by it.

Report the same Endurance Group Identifier as CNS 00h: each namespace
is its own endurance group, so the identifier equals the namespace
identifier.

Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
---
 drivers/nvme/target/admin-cmd.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index 7764a3c0195c9..aad5abdb6ef96 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -1081,6 +1081,7 @@ static void nvmet_execute_id_cs_indep(struct nvmet_req *req)
 	id->nstat = NVME_NSTAT_NRDY;
 	id->anagrpid = cpu_to_le32(req->ns->anagrpid);
 	id->nmic = NVME_NS_NMIC_SHARED;
+	id->endgid = cpu_to_le16(req->ns->nsid);
 	if (req->ns->readonly)
 		id->nsattr |= NVME_NS_ATTR_RO;
 	if (req->ns->bdev && bdev_rot(req->ns->bdev))
-- 
2.43.7


