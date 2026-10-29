Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2848D606A31C
	for <linux-nvme@archiver.kernel.org>; Thu, 29 Oct 2026 12:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=EqhY7Ze1;
	dkim=pass (1024-bit key, unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=TQCqbhVc
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=l5QlWBz5SNXU54j6/wQzk0/kmR9RqV5Lu5S4RPKmZDU=; b=EqhY7Ze1oCTM79
	zLsBvVFTBZn6yy2HA8W1yMqYzXpzco8fQrp0WNCPDD9Qyk76D9fVQCVKYZBol60Hb4KCUromwEuD9
	vhHgQ/ti3K7bYeijCCnV6I38woeDNkIyRLKwJ4w4ckerio0OXkiLdlsZGQlyzqSYRAZI3KZuCtqrm
	ZZ/4GEag7xTnbeXCAaeGvXyE7mG+d2DuBUI09vceshN9ULA0kGuKQr6Suz7Q67Jp26LGvA87C6mBk
	lnQ317X88fiV8wZJhUZ7Q8JdoHD8hRhrb5PeoKea5ciOI9loRYw5Y3GMu30sAF1u7ewiIfZSLg22O
	sUCfbBv5X01M66sNnAHQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xMPFx-000000099NI-3BhX;
	Thu, 29 Oct 2026 12:29:21 +0000
Received: from out30-119.freemail.mail.aliyun.com ([115.124.30.119])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xMPFt-000000099FA-2Dm8
	for linux-nvme@lists.infradead.org;
	Thu, 29 Oct 2026 12:29:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1793276955; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=l5QlWBz5SNXU54j6/wQzk0/kmR9RqV5Lu5S4RPKmZDU=;
	b=TQCqbhVcuEK0aRB7X4jPagPzRTedtd8CPh0Xjxljh3d8HiBMGi+DlaQPaU29AtXS/S852DbKU7h1OPW06laxcx+wXB4rLssKMf1Y547v4UIFVIDSmqEyWtp1ZSLB9Wlay58AY4HK5co2wjeWLVpAeT5ZZfTT81YTu69ZUodEOt4=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037009110;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0XDjOCBb_1793276953;
Received: from localhost(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0XDjOCBb_1793276953 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 29 Oct 2026 20:29:14 +0800
From: Guixin Liu <kanie@linux.alibaba.com>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Nilay Shroff <nilay@linux.ibm.com>,
	Daniel Wagner <dwagner@suse.de>,
	Hannes Reinecke <hare@suse.de>
Cc: linux-nvme@lists.infradead.org
Subject: [PATCH v3 06/12] nvmet: report the Endurance Group Identifier in the CS-INDEP identify data
Date: Thu, 29 Oct 2026 20:28:27 +0800
Message-ID: <20261029122833.284572-7-kanie@linux.alibaba.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20261029122833.284572-1-kanie@linux.alibaba.com>
References: <20261029122833.284572-1-kanie@linux.alibaba.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261029_052917_959625_C13E48AB 
X-CRM114-Status: UNSURE (   8.97  )
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
index 7764a3c0195c..aad5abdb6ef9 100644
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


