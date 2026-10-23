Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 611FD606A31A
	for <linux-nvme@archiver.kernel.org>; Fri, 23 Oct 2026 08:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=tCQEeDft;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=GATCoaqP;
	dkim=pass (1024-bit key, unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=ha3fVfRf
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=BDtHg5bRA3jFLuCkWJLZnpU5fxK+OQEGMx8v5mEz8Wg=; b=tCQEeDft/rG42D
	S5PaOVVhdy23ceFwiz9MjpOP+ZmdM29V93cSx+xXOt7Px5fkv98mNMA6FFQgA34HkRi1Jq1+65sLQ
	y/aFsL+epwEjrMCzjTWcwpxkzJ8fsQWZ4Y2/JNtbCCoEnYcoA02cyp02limLMyPQUwqSUZCbR9oUq
	o7Cprqo8ByY4avTfu3WdkKYddWC/Tup91fsNwyBRuckJ6/k48FxUEORjfesGrZ4PpPStP25HYJark
	6bLz7t37vI6vK11oSZlUmXAWzJmBmsFl+oJaF0slm8YHM69YTjzm6D2hMiTUu1mMHgLdyE9VZD4cU
	Z2Fj96JCCkeNFLrarbxg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xKAFJ-0000000Fr4H-3fcY;
	Fri, 23 Oct 2026 08:03:25 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xKAFJ-0000000Fr2l-0ttx
	for linux-nvme@bombadil.infradead.org;
	Fri, 23 Oct 2026 08:03:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=BDtHg5bRA3jFLuCkWJLZnpU5fxK+OQEGMx8v5mEz8Wg=; b=GATCoaqPpTzuqFWeoOCBin/Z3G
	s3DrHts56y4PketfTuiZ9Fd7fWYKnLXeI+oMAgs/SrxnXNRyR/gIT/JxrtaSQNKfPf9DebORvby+8
	S6/rd7olxkeIhpwnRfCurby/OpTo9E57AQ5uRbb+8YYQV8fysgm9Fbbfm9kYOjpZv/TkFp1p4pF5U
	iTwYfOqX16U2Q6mJKPVkxf+GjlqQQcp+CMCkHGxkJ1jTw93rKp6N3o6lKOyKJ7ky1Cchm5MdhE3Ma
	/5UKWtY5/m/uUZlq82TfVrAOFw02YxYdIpVGoLLvWsJW9IcGqbWeZemqa/tOSwt90JaLNrGdLnZZz
	NtyGBj6w==;
Received: from out30-119.freemail.mail.aliyun.com ([115.124.30.119])
	by desiato.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xKAFE-000000095ci-07Yf
	for linux-nvme@lists.infradead.org;
	Fri, 23 Oct 2026 08:03:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1792742586; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=BDtHg5bRA3jFLuCkWJLZnpU5fxK+OQEGMx8v5mEz8Wg=;
	b=ha3fVfRfZZ6sppx0fKMNDyyGwhTo66LFvc2qlRBCEDO5lrLSUOSUvT7etDccdLjJjGHm0NWwylWM7eZSi6gjmtn8ZHyrByIL69DWxh47Q4uQw+EJ+8Q4uGBkw5AH8vnBdi+hW1M9xVCLstXjODQbVAfmGd2Kh7xYvxWWQieEfd4=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045098064;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0XDLZI2a_1792742585;
Received: from localhost(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0XDLZI2a_1792742585 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 23 Oct 2026 16:03:05 +0800
From: Guixin Liu <kanie@linux.alibaba.com>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Nilay Shroff <nilay@linux.ibm.com>,
	Daniel Wagner <dwagner@suse.de>,
	Hannes Reinecke <hare@suse.de>
Cc: linux-nvme@lists.infradead.org
Subject: [PATCH 06/11] nvmet: advertise the FDP capability
Date: Fri, 23 Oct 2026 16:02:46 +0800
Message-ID: <20261023080251.2606443-7-kanie@linux.alibaba.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20261023080251.2606443-1-kanie@linux.alibaba.com>
References: <20261023080251.2606443-1-kanie@linux.alibaba.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261023_090321_506943_0DFD0A1B 
X-CRM114-Status: GOOD (  10.56  )
X-Spam-Score: -15.7 (---------------)
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

Set the Flexible Data Placement Supported (FDPS) bit in the Identify
Controller ctratt field whenever at least one enabled namespace of
the subsystem bridges FDP.  Hosts use the FDPS bit to decide whether
to query the FDP feature and configuration for each namespace, so
without it the bridge stays invisible.  The FDP log pages are listed
in the Supported Log Pages log page by the patches that serve them.

Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
---
 drivers/nvme/target/admin-cmd.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index aad5abdb6ef96..b293ce418e2c3 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -699,6 +699,8 @@ static void nvmet_execute_identify_ctrl(struct nvmet_req *req)
 	ctratt = NVME_CTRL_ATTR_HID_128_BIT | NVME_CTRL_ATTR_TBKAS;
 	if (nvmet_is_pci_ctrl(ctrl))
 		ctratt |= NVME_CTRL_ATTR_RHII;
+	if (nvmet_fdp_subsys_configured(ctrl->subsys))
+		ctratt |= NVME_CTRL_ATTR_FDPS;
 	id->ctratt = cpu_to_le32(ctratt);
 
 	id->oacs = 0;
-- 
2.43.7


