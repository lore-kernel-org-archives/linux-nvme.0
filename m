Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F29B606A325
	for <linux-nvme@archiver.kernel.org>; Fri, 20 Nov 2026 08:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=fONSA5/k;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=CJl5095x
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Unsubscribe-Post:List-Owner;
	bh=URQ6jI4lhG0GBetCHfgTn1gYRTht/rN9HqmNBSc0BIE=; b=fONSA5/k40f61NpLJSemAid+87
	1aOC40NqeGG735SqWT95BFPj45P6RUUxKmkDdoJPMERgf3YV2ChUZFLG4HWv6E1Io3nJtnQr4ilas
	TBfmPMyT/ksJ3IEuytoquUA/n5XuBWa3+rzOr9ku2l8uQGojbsF4NQGAbxREkQBpEUpItLlAGHPKK
	lghTekj588LURsIMD3W35kM/IfPp4sbv+RnKEuR9Snhwor4e5LB2IxsrOa4pmhjzem5b3QAaQuMLo
	Xv9gwacCl0huL7Lvn8In0HZAfMNwtk8NVEFSWqvD4+rm9jOXqm68gsh2ozbxHlXxQ99sJ9llRM+M+
	aaQnv37Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xUJdy-0000000EIGH-0FQv;
	Fri, 20 Nov 2026 08:06:50 +0000
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xUJdt-0000000EIFj-3YaR
	for linux-nvme@lists.infradead.org;
	Fri, 20 Nov 2026 08:06:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1795162003; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=URQ6jI4lhG0GBetCHfgTn1gYRTht/rN9HqmNBSc0BIE=;
	b=CJl5095xZvDefCqSJe0Jnfy5UCaJGanXTpamZDB/vZbVNbiyDfK8N+m+DCg0P3FZYAOCRJy+wXNTfFr0kflepr18z1ZhpD5mLY4qAryA1/I3oIqw3NTyYiw9z4c9egnBqcHiBWP0AbFxtuGT2H8sMtwuo/HRfwv8gpNaJh+5WFg=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045133197;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0XF5rpwf_1795162002;
Received: from localhost(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0XF5rpwf_1795162002 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 20 Nov 2026 16:06:42 +0800
From: Guixin Liu <kanie@linux.alibaba.com>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Nilay Shroff <nilay@linux.ibm.com>,
	Daniel Wagner <dwagner@suse.de>,
	Hannes Reinecke <hare@suse.de>
Cc: linux-nvme@lists.infradead.org
Subject: [PATCH] nvmet: don't abort the preempting host itself
Date: Fri, 20 Nov 2026 16:06:42 +0800
Message-ID: <20261120080642.1179691-1-kanie@linux.alibaba.com>
X-Mailer: git-send-email 2.43.7
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261120_000646_481828_8E035C1A 
X-CRM114-Status: GOOD (  11.98  )
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

When a host issues a Reservation Acquire with the Preempt and Abort
action and its own reservation key matches the Preempt Reservation Key
(PRKEY), the host unregisters itself as the specification requires:
all paths in NVMe Base Specification section 8.1.25.7 that unregister
registrants by PRKEY (no reservation held, All Registrants types with
a non-zero PRKEY, and a PRKEY that does not match the holder's key)
apply to every registrant whose key matches, without excluding the
host that issued the command.

But nvmet also adds the issuing host's controllers to the abort set.
The abort flow kills the per-controller ref of every controller in the
set and waits for their counts to drop to zero before completing the
preempt command.  The preempt command itself holds a reference on its
own controller's per-controller ref until it completes, so the abort
flow ends up waiting for the very command it is supposed to complete
afterwards.  The namespace's pr_sem is never released and all further
reservation commands on the namespace hang.

The abort of commands as a side effect of preempting a reservation is
best effort, so skip the issuing host's controllers and just unregister
the registrant.

Fixes: 5a47c2080a73 ("nvmet: support reservation feature")
Cc: stable@vger.kernel.org
Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
---
 drivers/nvme/target/pr.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/target/pr.c b/drivers/nvme/target/pr.c
index 8c818f24815b..ed530d7362f5 100644
--- a/drivers/nvme/target/pr.c
+++ b/drivers/nvme/target/pr.c
@@ -502,7 +502,14 @@ static u16 nvmet_pr_unreg_all_host_by_prkey(struct nvmet_req *req, u64 prkey,
 		if (reg->rkey == prkey) {
 			status = NVME_SC_SUCCESS;
 			uuid_copy(&hostid, &reg->hostid);
-			if (abort)
+			/*
+			 * Aborting is best effort (NVMe Base Specification
+			 * section 8.1.25.7): skip the issuing host, as the
+			 * abort flow would otherwise wait for the preempt
+			 * command itself, which holds a reference on its
+			 * controller's per-controller ref until it completes.
+			 */
+			if (abort && !uuid_equal(&hostid, send_hostid))
 				nvmet_pr_set_ctrl_to_abort(req, &hostid);
 			nvmet_pr_unregister_one(pr, reg);
 			if (!uuid_equal(&hostid, send_hostid))
-- 
2.43.7


