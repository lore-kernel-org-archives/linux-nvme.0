Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEEC7606A8A7
	for <linux-nvme@archiver.kernel.org>; Wed, 11 Nov 2026 21:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=RQCAX3dt;
	dkim=pass (2048-bit key) header.d=zte.com.cn header.i=@zte.com.cn header.a=rsa-sha256 header.s=z202610 header.b=FJNalWXa
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Subject:Cc:To:
	From:Mime-Version:Date:References:In-Reply-To:Message-ID:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=8IfQhFatm69/QzUFwynlM3k1WKbnUbQP37INwDNgvZQ=; b=RQCAX3dteXTICC6+p0GqVZ4zPM
	il7kPcYBy5Atcg9kcZnO6pRYMLj2N+LokhFRRr5f7QkkFP0csAEpKP+r1KJsB5PftzcLQRH8xW9DP
	nDJovMUROkT3EYY7+DvxuyS2qDTCDBvihgvUfLzJtbVdNI6PB03gL+tCXYSsM14EXIAUqxcuPk5/P
	xeV9uL2Do7r+glYY/5lNmG11w0t36Bt6wzKSrGASLig2uUqjhGJUMqRFe1326oHUrtPjuVGV9sXaU
	yBRRq0bEE05YpNWZvKlEY3UepPrQ2D3Qrr4qDQZAXwBd8CL1YLSb0GxtmzZ9DFk/FcUGYe2xtvwOD
	3YMk+R1g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRFi2-00000007llS-292j;
	Wed, 11 Nov 2026 21:18:22 +0000
Received: from mxct.zte.com.cn ([183.62.165.209])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQnNd-00000004J98-0zWY
	for linux-nvme@lists.infradead.org;
	Tue, 10 Nov 2026 15:03:26 +0000
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxct.zte.com.cn (FangMail) with ESMTPS id 4jP8zW1PKtz4xPS3;
	Tue, 10 Nov 2026 23:03:19 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=zte.com.cn;
	s=z202610; t=1794322999;
	bh=IBidnU3G++uWwfv2iMzuGg55NnOYFg7OCGfTXFLXIjY=;
	h=In-Reply-To:References:Date:From:To:Cc:Subject;
	b=FJNalWXaS5WB708ZczLwpF4u2QcRYHnKAjt+JHENSuf7TdbOmKU+wyZDarmXkw54Q
	 oOmWZHK2mh0DSpZqE8Xf75W+GmTYJBglQ+aJZytRN1y+s2TUoJLqBzK0z3A6KNZ1ZF
	 oR2Ei/Zm9sIfY0I7lreVzFk0HmSXOxVEDoG6nm/foJjrVleYy6pLGZkzJY2BT3T4kw
	 SCl4YDsvfOoyyuBW8EZiyVlGC8NfYKb1/cIRlY2I3zd1cJxtWmjKv0dsLDp858ucrn
	 0murj3y+j3konWnqR/DD1S0PAYJL57t5j57T5kcNpVSEhmMc867GtI4e2o24f238gc
	 2SeqOA3/ePzpw==
Received: from xaxapp02.zte.com.cn ([10.88.97.241])
	by mse-fl1.zte.com.cn with SMTP id 6AAF3DJO011153;
	Tue, 10 Nov 2026 23:03:13 +0800 (+08)
	(envelope-from shao.mingyin@zte.com.cn)
Received: from mapi (xaxapp05[null])
	by mapi (Zmail) with MAPI id mid32;
	Tue, 10 Nov 2026 23:03:16 +0800 (CST)
X-Zmail-TransId: 2afc6af332343da-01a1e
X-Mailer: Zmail v1.0
Message-ID: <20261110230316687z-VG9wgpFwmzFNKVnMGKY@zte.com.cn>
In-Reply-To: <20261110230304050fijuDcYKyYPS3lffioSeA@zte.com.cn>
References: 20261110230304050fijuDcYKyYPS3lffioSeA@zte.com.cn
Date: Tue, 10 Nov 2026 23:03:16 +0800 (CST)
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
From: <shao.mingyin@zte.com.cn>
To: <kbusch@kernel.org>, <axboe@kernel.dk>, <hch@lst.de>, <sagi@grimberg.me>,
        <linux-nvme@lists.infradead.org>
Cc: <justin.tee@broadcom.com>, <nareshgottumukkala83@gmail.com>,
        <paul.ely@broadcom.com>, <kch@nvidia.com>,
        <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
Subject: =?UTF-8?B?W1BBVENIIDYvNl0gbnZtZXQ6IHJvbGwgYmFjayBxdWV1ZSBiaW5kaW5ncyBvbiBjb25uZWN0aW9uIGZhaWx1cmU=?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL: mse-fl1.zte.com.cn 6AAF3DJO011153
X-TLS: YES
X-ENVELOPE-SENDER: shao.mingyin@zte.com.cn
X-SOURCE-IP: 10.5.228.132 unknown Tue, 10 Nov 2026 23:03:19 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6AF33237.000/4jP8zW1PKtz4xPS3
X-Bad-Reply: References and In-Reply-To but no 'Re:' in Subject.
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261110_070325_436876_38C16D71 
X-CRM114-Status: GOOD (  10.36  )
X-Spam-Score: -4.4 (----)
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

nvmet_install_queue() publishes the SQ controller pointer before
claiming the CQ. If the CQ is already connected, it leaves the SQ
pointer and the controller reference taken for it behind on failure.

An install_queue() callback failure also leaves the CQ bound after
clearing the SQ pointer. The reference taken in nvmet_install_queue()
is in addition to the one the caller already holds: the caller's put
releases the reference acquired before the call, while this one belongs
to the CQ binding. It is not released on this path, so the controller
stays alive and a Connect retry on the same queue keeps finding the
stale binding.

Clear the tentative SQ binding and release the extra reference on a CQ
conflict. On a transport installation failure, destroy the CQ binding
as well, so its controller table entry and reference are released.

Link: https://lore.kernel.org/all/20261106015842.3534898-6-kanie@linux.alibaba.com/
Fixes: bb78836b3a7c ("nvmet: fabrics: add CQ init and destroy")
Cc: stable@vger.kernel.org
Signed-off-by: Shao Mingyin <shao.mingyin@zte.com.cn>
---
 drivers/nvme/target/fabrics-cmd.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/nvme/target/fabrics-cmd.c b/drivers/nvme/target/fabrics-cmd.c
index fc626c2fd2c9..6f0fc695e649 100644
--- a/drivers/nvme/target/fabrics-cmd.c
+++ b/drivers/nvme/target/fabrics-cmd.c
@@ -216,6 +216,8 @@ static u16 nvmet_install_queue(struct nvmet_ctrl *ctrl, struct nvmet_req *req)
 	if (old) {
 		pr_warn("queue already connected!\n");
 		req->error_loc = offsetof(struct nvmf_connect_command, opcode);
+		req->sq->ctrl = NULL;
+		nvmet_ctrl_put(ctrl);
 		return NVME_SC_CONNECT_CTRL_BUSY | NVME_STATUS_DNR;
 	}
 
@@ -242,6 +244,7 @@ static u16 nvmet_install_queue(struct nvmet_ctrl *ctrl, struct nvmet_req *req)
 
 err:
 	req->sq->ctrl = NULL;
+	nvmet_cq_destroy(req->cq);
 	return ret;
 }
 
-- 
2.27.0

