Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C843D606A31B
	for <linux-nvme@archiver.kernel.org>; Fri,  6 Nov 2026 02:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=dCMnKY24;
	dkim=pass (1024-bit key, unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=YMPp7uue
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=Bs5S28x6XYUjwfF+VPzRky74EKLnBxK9WSlFo1NqdHk=; b=dCMnKY24C1PYeU
	LBrgrOPDe2MxMxTxOQd5PWhZzJjP1zZvMxQa7WR9P6SWa1vZbimFID4PfShshsvmdQGd8NCQlQDRF
	C0xROJXPMp4WFwj0+LO8TSfJ5nYsitCSpgECNozRM/8MIOejQKbwxCG1qbm90amWODfeYTCWLNMx0
	eSq60CjpJVOcyY0sDZ/yT3vmj73PtFZoS5odkz13uwp0Hfg8yQEoiuYvcp8wMlk2VRm0ZxBNMyKNT
	lKZmqhpDXELtJQWYlSG/ioHKO5j+8CIFXvUmWvvJW424fiwhPgU6hZ6iaucX+Yu8ebJAWJsgCvrrc
	v6BKAMtedWO8DhWyNXsw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xP9gI-0000000B43a-1qeC;
	Fri, 06 Nov 2026 02:27:54 +0000
Received: from out30-99.freemail.mail.aliyun.com ([115.124.30.99])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xP9gD-0000000B3vA-1V1L
	for linux-nvme@lists.infradead.org;
	Fri, 06 Nov 2026 02:27:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1793932067; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=Bs5S28x6XYUjwfF+VPzRky74EKLnBxK9WSlFo1NqdHk=;
	b=YMPp7uuevkQARXPAcEPi1glSoUb/Hb25VayxVKXe1aVDkcD/D+8o2G2H8RZJnViWXL+OKDji5fGc/dnCqf2icKLBieGJOjoeBCnIfRhnl1CyEsn6W2ehk2uaEs/kKKVK87zfuKv5GyOWCj5uoal5ay27AZLLkGaV/b90MOrqpfU=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R211e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045098064;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0XEA90DT_1793932066;
Received: from localhost(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0XEA90DT_1793932066 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 06 Nov 2026 10:27:47 +0800
From: Guixin Liu <kanie@linux.alibaba.com>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Nilay Shroff <nilay@linux.ibm.com>,
	Daniel Wagner <dwagner@suse.de>,
	Hannes Reinecke <hare@suse.de>
Cc: linux-nvme@lists.infradead.org
Subject: [PATCH v2 6/9] nvmet-fc: remove dead fields in nvmet_fc_ls_iod and nvmet_fc_tgt_queue
Date: Fri,  6 Nov 2026 10:27:33 +0800
Message-ID: <20261106022736.3582824-7-kanie@linux.alibaba.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20261106022736.3582824-1-kanie@linux.alibaba.com>
References: <20261106022736.3582824-1-kanie@linux.alibaba.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261105_182749_573923_B67D76C8 
X-CRM114-Status: UNSURE (   9.59  )
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

The fcpreq field of struct nvmet_fc_ls_iod is only ever assigned NULL
and never read, and the ninetypercent field of struct nvmet_fc_tgt_queue
is never referenced as the 90% queue state is recomputed on demand.
Drop both.

Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
---
 drivers/nvme/target/fc.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/nvme/target/fc.c b/drivers/nvme/target/fc.c
index 2b7dc3f03912..bccfbaea6dfc 100644
--- a/drivers/nvme/target/fc.c
+++ b/drivers/nvme/target/fc.c
@@ -27,7 +27,6 @@ struct nvmet_fc_tgt_assoc;
 
 struct nvmet_fc_ls_iod {		/* for an LS RQST RCV */
 	struct nvmefc_ls_rsp		*lsrsp;
-	struct nvmefc_tgt_fcp_req	*fcpreq;	/* only if RS */
 
 	struct list_head		ls_rcv_list; /* tgtport->ls_rcv_list */
 
@@ -129,7 +128,6 @@ struct nvmet_fc_defer_fcp_req {
 };
 
 struct nvmet_fc_tgt_queue {
-	bool				ninetypercent;
 	u16				qid;
 	u16				sqsize;
 	u16				ersp_ratio;
@@ -2076,7 +2074,6 @@ nvmet_fc_rcv_ls_req(struct nvmet_fc_target_port *target_port,
 	}
 
 	iod->lsrsp = lsrsp;
-	iod->fcpreq = NULL;
 	memcpy(iod->rqstbuf, lsreqbuf, lsreqbuf_len);
 	iod->rqstdatalen = lsreqbuf_len;
 	iod->hosthandle = hosthandle;
-- 
2.43.7


