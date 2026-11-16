Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CC29606A33F
	for <linux-nvme@archiver.kernel.org>; Mon, 16 Nov 2026 08:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=qlwhihLQ;
	dkim=pass (1024-bit key, unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=PYB5VfM+
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=tzz+VelZTXmy3j9K3KRYtdMaE/Ht3pEvljITiqa41I4=; b=qlwhihLQ1FdL4l
	x69XFJT6cUvwgyi2lGKPNB5XZnGgXbWsJguimovTesQzH5PPKHeWugqLhGqCdQLh6sMSngtiN7J1C
	cNOLkWdzB3p1Zov9S0qlOSrO+J6ZSLRSPjr/SX5tpoh7jT3YGvAecrYcz6YeQawjei4dm8QmrU1f3
	NwXXtMf8/8vb/gbXm/Rkl5I+P7xfJNV5feaih3ImDTUWYSKKoC8lAv4JGrzS85yGf/9B3zV19UQNI
	gy57lupN0Y5w6mVVx4eW+5irWEH0/MV/X1nRax0nLdvSiYvLRu8H+bNZfSOqxeC6nsFI85jaGIuVm
	8agEajjwPD9PLicSu4Pg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xSrpC-00000001WoR-3d3u;
	Mon, 16 Nov 2026 08:12:26 +0000
Received: from out199-18.us.a.mail.aliyun.com ([47.90.199.18])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xSrpA-00000001WnE-0Rat
	for linux-nvme@lists.infradead.org;
	Mon, 16 Nov 2026 08:12:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1794816740; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=tzz+VelZTXmy3j9K3KRYtdMaE/Ht3pEvljITiqa41I4=;
	b=PYB5VfM+IkFxQZU+DHnxtMjMAqMO+pJUswkNVWYseAg2jBDnPndBsD0fcyoBeOY2RwOZeWZ0xjW4fTiAHYEQCvT0Zl3iuenDbx7n4XpedpkpXCMjUI7aYZ0vpmbb11TQmdg2i4El2dGAbpFGCU3IcC+vkagqkHcIbwZSpsEwzQY=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045133197;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0XEoakSV_1794816738;
Received: from localhost(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0XEoakSV_1794816738 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 16 Nov 2026 16:12:18 +0800
From: Guixin Liu <kanie@linux.alibaba.com>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Nilay Shroff <nilay@linux.ibm.com>,
	Daniel Wagner <dwagner@suse.de>,
	Hannes Reinecke <hare@suse.de>
Cc: linux-nvme@lists.infradead.org
Subject: [PATCH v3 2/2] nvme-auth: fix data race on ctrl->transaction
Date: Mon, 16 Nov 2026 16:12:11 +0800
Message-ID: <20261116081211.1757155-3-kanie@linux.alibaba.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20261116081211.1757155-1-kanie@linux.alibaba.com>
References: <20261116081211.1757155-1-kanie@linux.alibaba.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261116_001224_405620_C266BA12 
X-CRM114-Status: GOOD (  12.89  )
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

nvme_ctrl_auth_work() queues the DH-HMAC-CHAP exchange of every queue
on nvme-auth-wq without waiting for them, so multiple
nvme_queue_auth_work() instances run concurrently and all increment
ctrl->transaction in nvme_queue_auth_work(). The plain increment is a
data race, and the lost updates hand the same transaction id to
concurrent queues.

The counter does not need to be shared at all: the controller only
echoes the transaction id within a queue, so a per-queue counter is
sufficient. Increment chap->transaction instead, drop the reset in
nvme_auth_reset_dhchap() so the id stays monotonic across
re-authentication, and remove the now unused ctrl->transaction field.

Fixes: f50fff73d620 ("nvme: implement In-Band authentication")
Cc: stable@vger.kernel.org
Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
---

Changes since v2: reworked per review to use a per-queue counter and
drop the shared field entirely (Keith Busch), and the Fixes tag was
added (sashiko).  The Reviewed-by on v2 covered the atomic_t version
of this change and is dropped.
---
 drivers/nvme/host/auth.c | 3 +--
 drivers/nvme/host/nvme.h | 1 -
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/nvme/host/auth.c b/drivers/nvme/host/auth.c
index 9a3da74dec5a..54f3354ecae9 100644
--- a/drivers/nvme/host/auth.c
+++ b/drivers/nvme/host/auth.c
@@ -644,7 +644,6 @@ static void nvme_auth_reset_dhchap(struct nvme_dhchap_queue_context *chap)
 	chap->s1 = 0;
 	chap->s2 = 0;
 	chap->bi_directional = false;
-	chap->transaction = 0;
 	memset(chap->c1, 0, sizeof(chap->c1));
 	memset(chap->c2, 0, sizeof(chap->c2));
 	mempool_free(chap->buf, nvme_chap_buf_pool);
@@ -764,7 +763,7 @@ static void nvme_queue_auth_work(struct work_struct *work)
 		return;
 	}
 
-	chap->transaction = ctrl->transaction++;
+	chap->transaction++;
 
 	/* DH-HMAC-CHAP Step 1: send negotiate */
 	dev_dbg(ctrl->device, "%s: qid %d send negotiate\n",
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 2543e52d6358..e015d3a3e29c 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -463,7 +463,6 @@ struct nvme_ctrl {
 	struct nvme_dhchap_queue_context *dhchap_ctxs;
 	struct nvme_dhchap_key *host_key;
 	struct nvme_dhchap_key *ctrl_key;
-	u16 transaction;
 #endif
 	key_serial_t tls_pskid;
 
-- 
2.43.7


