Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ECEC606A8A2
	for <linux-nvme@archiver.kernel.org>; Wed, 11 Nov 2026 21:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=nuHylBnB;
	dkim=pass (2048-bit key) header.d=zte.com.cn header.i=@zte.com.cn header.a=rsa-sha256 header.s=z202610 header.b=C2oy3SkJ
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Subject:Cc:To:
	From:Mime-Version:Date:References:In-Reply-To:Message-ID:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=sXxgGhcF0mTkYDF8HuHev/I0qLZckh9PHUK6grJLeg0=; b=nuHylBnBlU8WlS5u6TWgJUymmj
	Gc7rCH2KQJyqKywxVtFTLGFA7hne1NjkusEP1XORXhbzyCH+ZLyRQnXsWVQL+v8/fhQtSdVLjFj81
	1uIGgVV7Bo8TEhxZjs3dDf6Vqp//xR7s7ONJ/hBHUNBN0Iyx3v0L6bZcAFgDGNp1CcVah3AQ4Qrl7
	lPjWZEEqhIK2ZNBxychIE5hbcHnO01n9SI8sev7Zv72VGjBg1qTDS8wJSuKZHJefmnDMTvzveQhnv
	tbXYZTlZcnEzj28Qr4zloPGmhppQfm9y/+bAxT9U8EUcRNvtZwlYeFl9oLZ6M6qERIGH8qDawxWlV
	03NNlV/Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRFi0-00000007lh9-3Jv3;
	Wed, 11 Nov 2026 21:18:20 +0000
Received: from mxhk.zte.com.cn ([160.30.148.35])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQnNc-00000004J8w-2uyY
	for linux-nvme@lists.infradead.org;
	Tue, 10 Nov 2026 15:03:25 +0000
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4jP8zZ4xTfz8XrrX;
	Tue, 10 Nov 2026 23:03:22 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=zte.com.cn;
	s=z202610; t=1794323002;
	bh=/88cOaiDZMOr8DKkibMc9irzW48otaXY8hW0OxygJss=;
	h=In-Reply-To:References:Date:From:To:Cc:Subject;
	b=C2oy3SkJirJtL/VeI3Bl74p7zgL9ki0z3hEKoXKqamobDKNGEjGsTYBg9Fg3HaSi4
	 LGjBwn3SA13H5YlGpIct25UErCZ7I+OQ04cDGXvLEIq2Ar+/wClgxmZ0THwcrwnwlX
	 2P8xw+FgMn2MFMrFM+3I5S8VW+14Wp3goA86QZlFD0CphKcdHQrK8oEFwAN0hN9FuF
	 V3/z2+zd64SvLKam30rgDVyhCwLhz7+qwXXQ1PCR6fJUboEQTeNaoZPBqKULzl+Nvn
	 t751+U/ZLRUtqHVMNaLifnAI2yCcjrMfiQ2tTPzFXJPXd6S+0PyRRTT+irCiTooTwV
	 MWaELsN6fgaGg==
Received: from xaxapp01.zte.com.cn ([10.88.99.176])
	by mse-fl1.zte.com.cn with SMTP id 6AAF3AXW011142;
	Tue, 10 Nov 2026 23:03:10 +0800 (+08)
	(envelope-from shao.mingyin@zte.com.cn)
Received: from mapi (xaxapp04[null])
	by mapi (Zmail) with MAPI id mid32;
	Tue, 10 Nov 2026 23:03:13 +0800 (CST)
X-Zmail-TransId: 2afb6af332310c0-076fe
X-Mailer: Zmail v1.0
Message-ID: <20261110230313720JCGXeTg2zOideed82vWy9@zte.com.cn>
In-Reply-To: <20261110230304050fijuDcYKyYPS3lffioSeA@zte.com.cn>
References: 20261110230304050fijuDcYKyYPS3lffioSeA@zte.com.cn
Date: Tue, 10 Nov 2026 23:03:13 +0800 (CST)
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
From: <shao.mingyin@zte.com.cn>
To: <kbusch@kernel.org>, <axboe@kernel.dk>, <hch@lst.de>, <sagi@grimberg.me>,
        <linux-nvme@lists.infradead.org>
Cc: <justin.tee@broadcom.com>, <nareshgottumukkala83@gmail.com>,
        <paul.ely@broadcom.com>, <kch@nvidia.com>,
        <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
Subject: =?UTF-8?B?W1BBVENIIDQvNl0gbnZtZXQtZmNsb29wOiBmcmVlIHRoZSBMUyByZXF1ZXN0IHdoZW4gZGVsaXZlcnkgZmFpbHM=?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL: mse-fl1.zte.com.cn 6AAF3AXW011142
X-TLS: YES
X-ENVELOPE-SENDER: shao.mingyin@zte.com.cn
X-SOURCE-IP: 10.5.228.132 unknown Tue, 10 Nov 2026 23:03:22 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6AF3323A.002/4jP8zZ4xTfz8XrrX
X-Bad-Reply: References and In-Reply-To but no 'Re:' in Subject.
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261110_070324_913318_CDB33210 
X-CRM114-Status: UNSURE (   8.01  )
X-CRM114-Notice: Please train this message.
X-Spam-Score: -2.1 (--)
X-Mailman-Approved-At: Wed, 11 Nov 2026 13:17:03 -0800
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
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Shao Mingyin <shao.mingyin@zte.com.cn>

fcloop_h2t_ls_req() allocates a fcloop_lsreq from lsreq_cache and hands
it to nvmet_fc_rcv_ls_req().  That function only takes ownership on
success and returns an error without invoking any completion callback
when the target port is shutting down, the LS payload is too large, or
the target has no free LS request slot.  The error is returned as-is, so
the fcloop_lsreq is leaked; every failed LS during a target port
teardown or an LS slot exhaustion loses one slab object.

The target-to-host direction already frees the request when
nvme_fc_rcv_ls_req() fails.  Do the same here.

Fixes: 772042dd38ee ("nvmet-fcloop: allocate/free fcloop_lsreq directly")
Cc: stable@vger.kernel.org
Signed-off-by: Shao Mingyin <shao.mingyin@zte.com.cn>
---
Tested on 7.3.0-next-20261030 (QEMU/TCG guest) with the fcloop
loopback transport (nvme-fc host + nvmet-fc/fcloop target); no real
FC HBA is required.

The -ESHUTDOWN error path is otherwise only hit in a sub-instruction
teardown race, so it is exercised with two TEST-ONLY changes (not part
of this patch): a debugfs knob that makes nvmet_fc_rcv_ls_req() return
-ESHUTDOWN, and SLAB_NO_MERGE on lsreq_cache so the 72-byte
fcloop_lsreq does not merge into a kmalloc cache.  A stock host sends
120 Create Association LS with ctrl_loss_tmo=0 (each failure deletes
the controller); the cache is shrunk afterwards, which only reclaims
empty slabs:

  unpatched                            patched
  lsreq_cache objects 0 -> 120         lsreq_cache objects stays 0
  slabs 0 -> 4                         slabs stay 0

diff --git a/drivers/nvme/target/fcloop.c b/drivers/nvme/target/fcloop.c
index b63af3b643a6..a9cde536c33b 100644
--- a/drivers/nvme/target/fcloop.c
+++ b/drivers/nvme/target/fcloop.c
@@ -379,6 +379,8 @@ fcloop_h2t_ls_req(struct nvme_fc_local_port *localport,
 	ret = nvmet_fc_rcv_ls_req(rport->targetport, rport,
 				  &tls_req->ls_rsp,
 				  lsreq->rqstaddr, lsreq->rqstlen);
+	if (ret)
+		kmem_cache_free(lsreq_cache, tls_req);
 
 	return ret;
 }

