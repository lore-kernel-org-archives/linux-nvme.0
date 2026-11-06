Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7CFE606A31B
	for <linux-nvme@archiver.kernel.org>; Fri,  6 Nov 2026 02:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=iQ2yy1MK;
	dkim=pass (1024-bit key, unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=CaKfawhm
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=hfN+ODporswz5llDQlK6X/Z3Zm7tniw4gJ/mE93Bt0I=; b=iQ2yy1MKwkkRyg
	Ax76XPi/mRpMnIstafSuNo+aoQCYwNYNhZ0xakmQXWYJs4mL6rnjsFj2vLFC+fPS7UaO6XfQSvxWf
	3gfdRTLyk8NdDOZTvA44ZE/6kvsYAY/AcxoXHD87wApDDPKOTo3ueaLq6+Z/1X11WX4zm8LSEJuq4
	HSAEqwZKZCTALb9EnuR9buekp4EhdHE6tkl0MZhcZCtmgx6QtCV1SBoTyOyjS+tM59IfF9jyeV0UI
	0xBjb3vu6eHOjgRIusoSx9+ALbVN2Qk9958VxZXkP7/TGmGeWwm4L5xR+CDbLdHhzNFAo3RPIGli/
	S9KAXidtGiCD1/zImcTg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xP9gD-0000000B3wJ-1mTM;
	Fri, 06 Nov 2026 02:27:49 +0000
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xP9gB-0000000B3ua-07GH
	for linux-nvme@lists.infradead.org;
	Fri, 06 Nov 2026 02:27:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1793932064; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=hfN+ODporswz5llDQlK6X/Z3Zm7tniw4gJ/mE93Bt0I=;
	b=CaKfawhme/bB/WZR771uUhbsUgWxX2Im/nqifEJ0SjDwk48BzE9ykqCEI4MZ0JMsmabTJE5OAdPwJdT2FYPIJx1/JCOCCeFubxo4FbemPCNKLi1tuCQF+Mt5lPua9CcEu2MpMVjsjQWwaEB2Oaruhzg9EROqA4OO8qxOC0l2vRY=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033032089153;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0XEA2.h._1793932062;
Received: from localhost(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0XEA2.h._1793932062 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 06 Nov 2026 10:27:43 +0800
From: Guixin Liu <kanie@linux.alibaba.com>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Nilay Shroff <nilay@linux.ibm.com>,
	Daniel Wagner <dwagner@suse.de>,
	Hannes Reinecke <hare@suse.de>
Cc: linux-nvme@lists.infradead.org
Subject: [PATCH v2 2/9] nvme-fc: remove dead seqno field in nvme_fc_queue
Date: Fri,  6 Nov 2026 10:27:29 +0800
Message-ID: <20261106022736.3582824-3-kanie@linux.alibaba.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20261106022736.3582824-1-kanie@linux.alibaba.com>
References: <20261106022736.3582824-1-kanie@linux.alibaba.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261105_182747_221148_1516E964 
X-CRM114-Status: UNSURE (   9.44  )
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

The seqno field of struct nvme_fc_queue has never been referenced
since it was introduced in commit e399441de9115 ("nvme-fabrics: Add
host support for FC transport"). Drop it.

Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
---
 drivers/nvme/host/fc.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index 0b9ff50d26ff..2cbd744ffd22 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -39,7 +39,6 @@ struct nvme_fc_queue {
 	size_t			cmnd_capsule_len;
 	u32			qnum;
 	u32			rqcnt;
-	u32			seqno;
 
 	u64			connection_id;
 	atomic_t		csn;
-- 
2.43.7


