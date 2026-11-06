Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E06DE606A326
	for <linux-nvme@archiver.kernel.org>; Fri,  6 Nov 2026 02:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=yD30Hvap;
	dkim=pass (1024-bit key, unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=OdCxdmju
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=GKMUjWiDTv0VGUEkn6M0uyZNDb9dzlNbnqpGQk5hjg8=; b=yD30HvaplIj8F/
	TsCXqQHpGdqAeFQMvMYsOJt4TPfxn0rmg+5qoNWqdsVeJBALtVu2Puoaup+y/YQYmVnidjNJqZOGj
	f1qYEG2RsFutl8dRGyCvoTioH16bSMfeidVdSICLP5RcNEPJrgK1HLPvIhywAzXtC3NxCQz9eIP9j
	veh7FP18knhU6asy3lCtKQ13U7KBxSYzuPAqyPTw24X50/kJ7DTkWmTeBRDyeXtASrWc4pcAj629r
	3ZRddeRn1+C0lnLwFFUvsOV7GrrkQuhdXAvwo1H5Euabqnu8uqTK5B/aWEpJ44NwKTFDDtBKBbzcm
	Kr6kveNPDKugrAoFmMtw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xP9gI-0000000B43u-2Q03;
	Fri, 06 Nov 2026 02:27:54 +0000
Received: from out30-99.freemail.mail.aliyun.com ([115.124.30.99])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xP9gF-0000000B3wt-0Fpy
	for linux-nvme@lists.infradead.org;
	Fri, 06 Nov 2026 02:27:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1793932069; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=GKMUjWiDTv0VGUEkn6M0uyZNDb9dzlNbnqpGQk5hjg8=;
	b=OdCxdmjun2e+4UfBLPT8zvPY2YgIW2KcgjDspSJGp9FMN10rHeRHpyhqVWugGelB8u+NkWjjx3bUIOm3nThrvLTORpc0iDDKnZtfGXMGbnKGy/FLZBHDUAmTX9cqgER32ssfY/OZRn+E+Ga/ozjcgU8d3qOoG/JFRSkUfI5MPK8=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045133197;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0XEA90ET_1793932068;
Received: from localhost(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0XEA90ET_1793932068 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 06 Nov 2026 10:27:48 +0800
From: Guixin Liu <kanie@linux.alibaba.com>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Nilay Shroff <nilay@linux.ibm.com>,
	Daniel Wagner <dwagner@suse.de>,
	Hannes Reinecke <hare@suse.de>
Cc: linux-nvme@lists.infradead.org
Subject: [PATCH v2 8/9] nvmet: passthru: remove unreachable break statements
Date: Fri,  6 Nov 2026 10:27:35 +0800
Message-ID: <20261106022736.3582824-9-kanie@linux.alibaba.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20261106022736.3582824-1-kanie@linux.alibaba.com>
References: <20261106022736.3582824-1-kanie@linux.alibaba.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261105_182751_272891_0591DF3B 
X-CRM114-Status: UNSURE (   8.71  )
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

In the nvme_admin_set_features and nvme_admin_get_features handlers of
nvmet_passthru_parse_cmd(), every path of the inner switch over the
feature id returns, so the break statement following the switch can
never be reached. Remove them.

Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
---
 drivers/nvme/target/passthru.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/nvme/target/passthru.c b/drivers/nvme/target/passthru.c
index 6b67880c7bb2..32ae4b6b59bf 100644
--- a/drivers/nvme/target/passthru.c
+++ b/drivers/nvme/target/passthru.c
@@ -550,7 +550,6 @@ u16 nvmet_parse_passthru_admin_cmd(struct nvmet_req *req)
 		default:
 			return nvmet_passthru_get_set_features(req);
 		}
-		break;
 	case nvme_admin_get_features:
 		switch (le32_to_cpu(req->cmd->features.fid)) {
 		case NVME_FEAT_ASYNC_EVENT:
@@ -564,7 +563,6 @@ u16 nvmet_parse_passthru_admin_cmd(struct nvmet_req *req)
 		default:
 			return nvmet_passthru_get_set_features(req);
 		}
-		break;
 	case nvme_admin_identify:
 		switch (req->cmd->identify.cns) {
 		case NVME_ID_CNS_CS_CTRL:
-- 
2.43.7


