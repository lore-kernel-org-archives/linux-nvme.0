Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A2AE606A326
	for <linux-nvme@archiver.kernel.org>; Fri,  6 Nov 2026 02:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=OI9tayzh;
	dkim=pass (1024-bit key, unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=Fc7JTOyY
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=us17qNeZKJBOOqipThe8pcF3m12DtmVM17xfCLicUtM=; b=OI9tayzhZTGhHX
	sTvfJ1nUpmU/CY2e84CZiD5G0cxqzXonE3VF4DJtNmOqsTMM0cyDs3C7xstXllWhdadsqyClIFj7n
	r56BtFhVl1WHJqcz7Iox4dnspTIfRaJo2F84sw/O62cEvAxnKYFCtbcJ3dkbdnXYuKA0f+8N0XEhg
	FwRRN4BLRN+fvwS+eqqMN2MYln8HWx8/hcU4UWLbVQgoYrRvtCMIKFf+zrQ9eCi5tLhyfSQ4ZB7GX
	gf6bspRIafseGG2aBt1zNYpAIscZHGXxR06MBzvGwaR382mShXq1WDUyf7Smf2yZI5d2lDqwzEIeR
	uK1uC021tEcBy3ufm1fA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xP9gE-0000000B3xn-3V19;
	Fri, 06 Nov 2026 02:27:50 +0000
Received: from out30-110.freemail.mail.aliyun.com ([115.124.30.110])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xP9gB-0000000B3ue-2jOh
	for linux-nvme@lists.infradead.org;
	Fri, 06 Nov 2026 02:27:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1793932065; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=us17qNeZKJBOOqipThe8pcF3m12DtmVM17xfCLicUtM=;
	b=Fc7JTOyY3NQnO8WjsTziyuEzKjRoXEWZcyGTgZx94QeGO1JMnWjTrGF97TLrnHjMdJCf1piCrTC/JZVuEmIuoIv0nfwkdStuIDOniICVUO61aYBiJi4bB0zFPVBDUePS8ZsCyWg7hg8VQk/uDiRqt+890s0+uhNAkGtY/tB6eek=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037033178;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0XEA90Cd_1793932063;
Received: from localhost(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0XEA90Cd_1793932063 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 06 Nov 2026 10:27:44 +0800
From: Guixin Liu <kanie@linux.alibaba.com>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Nilay Shroff <nilay@linux.ibm.com>,
	Daniel Wagner <dwagner@suse.de>,
	Hannes Reinecke <hare@suse.de>
Cc: linux-nvme@lists.infradead.org
Subject: [PATCH v2 3/9] nvme-auth: remove dead entry field in nvme_dhchap_queue_context
Date: Fri,  6 Nov 2026 10:27:30 +0800
Message-ID: <20261106022736.3582824-4-kanie@linux.alibaba.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20261106022736.3582824-1-kanie@linux.alibaba.com>
References: <20261106022736.3582824-1-kanie@linux.alibaba.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261105_182747_853879_6BF6E1A4 
X-CRM114-Status: GOOD (  10.29  )
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

The entry list_head of struct nvme_dhchap_queue_context has never been
used since it was introduced in commit f50fff73d620c ("nvme: implement
In-Band authentication"). Drop it.

Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
---
 drivers/nvme/host/auth.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/nvme/host/auth.c b/drivers/nvme/host/auth.c
index 85f005a5efd0..9a3da74dec5a 100644
--- a/drivers/nvme/host/auth.c
+++ b/drivers/nvme/host/auth.c
@@ -19,7 +19,6 @@ static struct kmem_cache *nvme_chap_buf_cache;
 static mempool_t *nvme_chap_buf_pool;
 
 struct nvme_dhchap_queue_context {
-	struct list_head entry;
 	struct work_struct auth_work;
 	struct nvme_ctrl *ctrl;
 	struct crypto_kpp *dh_tfm;
-- 
2.43.7


