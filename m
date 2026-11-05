Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEBFA606A31B
	for <linux-nvme@archiver.kernel.org>; Thu,  5 Nov 2026 02:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=PfOA9BDz;
	dkim=pass (1024-bit key, unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=GMDWSEus
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=us17qNeZKJBOOqipThe8pcF3m12DtmVM17xfCLicUtM=; b=PfOA9BDzehvONN
	bLJgitwZYEogA9VdBoX3LldmNZAFpRvQdJL8AcW2Kn9zpaQybhd3vzR8p98OLPhqRxGz79lBm3cu9
	aHXAuzeZc8/nZ3qCE/Whv8QGjRjvMua8nPPQJ83j4pLqRlG7BbNIjgQSehVVL6/+QWR3ekJrtC9Wb
	wjQMl/FbwB3tCkeP5qRg8Kp8PQzKJNZJc3fRUMjrLR0teCgWNnNB56dTwCzGTN01DrxCRD4F5jPNG
	eyw88P7BRpgID3XJvZkx6cL3Ikzvc8+uXFj5yz5uB4scVcXx/nPn83Q7mwEOa0fhd9QRXz54s6ewi
	k59Jo3y9/nFaNAiaMT9Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOmwV-00000007XOK-1NDe;
	Thu, 05 Nov 2026 02:11:07 +0000
Received: from out30-101.freemail.mail.aliyun.com ([115.124.30.101])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOmwS-00000007XLt-1aOJ
	for linux-nvme@lists.infradead.org;
	Thu, 05 Nov 2026 02:11:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1793844662; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=us17qNeZKJBOOqipThe8pcF3m12DtmVM17xfCLicUtM=;
	b=GMDWSEusfu/FXR2KLyDw3ziTujg95HOESh/YnDwBUQDqRHBNokN/5dikKF5iF4JUF8XZZ6g7et2vKVFwvxPMki9D+CH1E9PsfEjJ/JhbTZbqKEU7anx6wpIdjeSc0i63JEeJCe79guY0SLZ375HOeTfMhQbHQOM9N8j+TsM828c=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R221e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam011083073210;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0XE770bd_1793844660;
Received: from localhost(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0XE770bd_1793844660 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 05 Nov 2026 10:11:01 +0800
From: Guixin Liu <kanie@linux.alibaba.com>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Nilay Shroff <nilay@linux.ibm.com>,
	Daniel Wagner <dwagner@suse.de>,
	Hannes Reinecke <hare@suse.de>
Cc: linux-nvme@lists.infradead.org
Subject: [PATCH 3/9] nvme-auth: remove dead entry field in nvme_dhchap_queue_context
Date: Thu,  5 Nov 2026 10:10:45 +0800
Message-ID: <20261105021051.1667222-4-kanie@linux.alibaba.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20261105021051.1667222-1-kanie@linux.alibaba.com>
References: <20261105021051.1667222-1-kanie@linux.alibaba.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261104_181104_656728_5E5F5A3F 
X-CRM114-Status: GOOD (  10.23  )
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


