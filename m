Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6810606A328
	for <linux-nvme@archiver.kernel.org>; Wed,  4 Nov 2026 13:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=f3/fTlcE
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Subject:Cc:To:
	From:Mime-Version:Date:Message-ID:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Unsubscribe-Post:List-Owner;
	bh=aGr9gUhqRg9IWOMherHgHlP29txekxiSm0bPWBFR61k=; b=f3/fTlcEaWC0joowMd53vZidxU
	vd6yVn9coeF2hbb08tCLWX0MoFdqWRCZWDRDP7BPpbb6EMAVIDuelikXsafE/15OCQBU32taZtvhg
	iUgjECsO5eKXRKfypnLsh6JeVWhSyR5xCBSqpnaLmwLL5kibLRtfmNkZSmOHtX6YdaoMpjOGhKDIq
	AnbUpgz91dXM6OmOrO+U8LqjfMuwf/DP0GTvOgE+e8FT5KH260xkZ8xRra8J3ktzCazWzhjmQJXVG
	aVnslWDCaW35pdPFuMQ10m76i/5wJirWs+Bo2vngmzMOdrwVnWEmxW6Yc7YAyJGm54zZaP/uxKzfC
	Y6pdEOOA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOapY-00000005SH9-0AF2;
	Wed, 04 Nov 2026 13:15:08 +0000
Received: from mxhk.zte.com.cn ([160.30.148.35])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOapS-00000005SDv-15Qq
	for linux-nvme@lists.infradead.org;
	Wed, 04 Nov 2026 13:15:06 +0000
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4jKQs80Bbgz8Xrrd;
	Wed, 04 Nov 2026 21:14:52 +0800 (CST)
Received: from xaxapp02.zte.com.cn ([10.88.97.241])
	by mse-fl2.zte.com.cn with SMTP id 6A4DEhKN038352;
	Wed, 4 Nov 2026 21:14:43 +0800 (+08)
	(envelope-from shao.mingyin@zte.com.cn)
Received: from mapi (xaxapp02[null])
	by mapi (Zmail) with MAPI id mid32;
	Wed, 4 Nov 2026 21:14:46 +0800 (CST)
X-Zmail-TransId: 2afa6aeb2fc6685-f75ac
X-Mailer: Zmail v1.0
Message-ID: <20261104211446891tN1QRJiKV3CLPQqfb7gJu@zte.com.cn>
Date: Wed, 4 Nov 2026 21:14:46 +0800 (CST)
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
From: <shao.mingyin@zte.com.cn>
To: <hch@lst.de>, <sagi@grimberg.me>, <kch@nvidia.com>,
        <linux-nvme@lists.infradead.org>
Cc: <linux-kernel@vger.kernel.org>
Subject: =?UTF-8?B?W1BBVENIXSBudm1ldDogZHJvcCB0aGUgcmVkdW5kYW50IGF1dGggY2hlY2sgaW4gbnZtZXRfcGFyc2VfaW9fY21kKCk=?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL: mse-fl2.zte.com.cn 6A4DEhKN038352
X-TLS: YES
X-ENVELOPE-SENDER: shao.mingyin@zte.com.cn
X-SOURCE-IP: 10.5.228.133 unknown Wed, 04 Nov 2026 21:14:52 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6AEB2FCC.000/4jKQs80Bbgz8Xrrd
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261104_051502_934795_7AFABEDE 
X-CRM114-Status: UNSURE (   4.92  )
X-CRM114-Notice: Please train this message.
X-Spam-Score: -1.9 (-)
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
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Shao Mingyin <shao.mingyin@zte.com.cn>

nvmet_parse_io_cmd() calls nvmet_check_auth_status() and then
nvmet_check_ctrl_status(), which performs the same check again.  The
first call cannot fail either: this path only handles commands from I/O
queues, and nvmet_check_auth_status() returns true unconditionally for
qid > 0.  Drop the duplicate.

No functional change.

Signed-off-by: Shao Mingyin <shao.mingyin@zte.com.cn>
---
diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index a8171b88035c..12b82bb7e412 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -1120,9 +1120,6 @@ static u16 nvmet_parse_io_cmd(struct nvmet_req *req)
 	if (nvme_is_fabrics(cmd))
 		return nvmet_parse_fabrics_io_cmd(req);
 
-	if (unlikely(!nvmet_check_auth_status(req)))
-		return NVME_SC_AUTH_REQUIRED | NVME_STATUS_DNR;
-
 	ret = nvmet_check_ctrl_status(req);
 	if (unlikely(ret))
 		return ret;

