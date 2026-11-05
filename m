Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A485B606A31B
	for <linux-nvme@archiver.kernel.org>; Thu,  5 Nov 2026 02:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=A51NCViu;
	dkim=pass (1024-bit key, unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=PvkkrDYQ
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=GKMUjWiDTv0VGUEkn6M0uyZNDb9dzlNbnqpGQk5hjg8=; b=A51NCViu8VudvM
	Y402K8ltziyQIelpYx3mJQ0uJiLN+CuhsK9qrVYqmihnkPiHCuNZaZPYR+gNNBRZP/FziEBCAraeE
	rjq9is1PEoeFcb1XTa8lxPzd/sgn9OA0ou7/SZlJnhrDiAeLCOLIg4WALmFB3DtVJQbMepAQyWLI0
	2Z3XEwqrd5N7l7FMnQ/M9IcdyF8MyMq4Lb0sbc52qbCbWpUPaTisck1t0sfRrtU76pbOxri0iEyV2
	K9kx8NyPsXVPb6Y6hx4KdbHqexzB+vaG0vMrTvHRq7SbW2iNV/9Br1WUkqvExeIl5bv5nUjmSDTSq
	yJ2gQqLu8I0LkmjpmP3Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOmwe-00000007XZz-14Zn;
	Thu, 05 Nov 2026 02:11:16 +0000
Received: from out30-98.freemail.mail.aliyun.com ([115.124.30.98])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOmwW-00000007XNt-06Oq
	for linux-nvme@lists.infradead.org;
	Thu, 05 Nov 2026 02:11:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1793844666; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=GKMUjWiDTv0VGUEkn6M0uyZNDb9dzlNbnqpGQk5hjg8=;
	b=PvkkrDYQMhn4P8ytS3hgHIalGC4s7MgPIgg9nSsqKEX/y+KKlTKkD8LPUsi76AFEDo1g7qWzfyvC9Biw0UpVpCpvDSitWQsPs/d9v4ncFD0G1lO07T4uYtDMYBtYermdklKshXjC5wzl+gSU0u6dEVQzIoP1tK/3X36ZD8L6+1g=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R231e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033032089153;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0XE76GgO_1793844665;
Received: from localhost(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0XE76GgO_1793844665 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 05 Nov 2026 10:11:05 +0800
From: Guixin Liu <kanie@linux.alibaba.com>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Nilay Shroff <nilay@linux.ibm.com>,
	Daniel Wagner <dwagner@suse.de>,
	Hannes Reinecke <hare@suse.de>
Cc: linux-nvme@lists.infradead.org
Subject: [PATCH 8/9] nvmet: passthru: remove unreachable break statements
Date: Thu,  5 Nov 2026 10:10:50 +0800
Message-ID: <20261105021051.1667222-9-kanie@linux.alibaba.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20261105021051.1667222-1-kanie@linux.alibaba.com>
References: <20261105021051.1667222-1-kanie@linux.alibaba.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261104_181108_212150_F052E276 
X-CRM114-Status: UNSURE (   8.35  )
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


