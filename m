Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8415AC369A9
	for <linux-nvme@archiver.kernel.org>; Thu, 10 Apr 2025 11:47:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=L6mLGiZVRj/r2kEbAgsXZBAaxL59dgmF4U61U9Y6bTY=; b=TZI3GrA2GYc3afX8chBascKwu4
	qxAxv93Ac0yfeX7plDCRHOy7Knqa1+QBYE18vQNI08Ij8spO8zJ94n2RVbV165Mzwus6VV6EgPdi1
	KaU4JxvRuV4cWgmACaJlvCKdx/yiC0XQ7RGKbFqXjnRQztMX5osP9vjUyNegsPOIRx9pK9ISIcTQk
	ajZ5RdvBuFwaiVe4gyuYLCUgaoFhuCdP7IKtDS0GIzEf08vNpCK/0BsiHS7mEqb31SfTnOSzUczU6
	rqgGlqJO966GzvVCCnro8B8xyfLZSrSPGJnv8KTjg6pKfK2GOkoi/1L3N/8S0NVGJG4XfkAdpnz+p
	SqoEvd4w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u2qN7-0000000AMB7-2SkS;
	Thu, 10 Apr 2025 11:47:05 +0000
Received: from nyc.source.kernel.org ([147.75.193.91])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u2qHr-0000000AKxa-2giG
	for linux-nvme@lists.infradead.org;
	Thu, 10 Apr 2025 11:41:40 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 5DDCAA4A74B;
	Thu, 10 Apr 2025 11:36:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 527F5C4CEE3;
	Thu, 10 Apr 2025 11:41:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744285298;
	bh=6MtNYpYf3+gfKph3AscTQcqFhTmhfVMJlOnasxAT7Vg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=RKYrhUOPJX2S7Twyok9CWRNVkP79/thYWfoZHsLWwPfQUys5rs3pPZi07wg4FMbEo
	 tmo1PY40RnSuE8kNIejj6yqiQm5E9Mj71/XfQXO5VENYiPuQPgzP5Bel1NYbj91y9L
	 ra6qH67yPlJWLkNyO/5m4YZeC6nRVCY37emDAEcDhkJOOCBpH9T7K+UhVNpgkjrwEa
	 pQbMB8RKlNa8yJA0nAZCh45s1OgykraEQ9S5I/a6B8yaNFzu4Zl9f6EfamRqfkTrSr
	 gZ02aGF8tFQgFtsp3iwTB/R/7smIN3OVEzlGbx3aZ5sp7gT4UGVO1IVT+/DyvBP9ZJ
	 +K1sEGW9jqv9A==
From: Daniel Wagner <wagi@kernel.org>
Date: Thu, 10 Apr 2025 13:41:14 +0200
Subject: [PATCH v4 11/14] nvmet-fcloop: drop response if targetport is gone
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250410-nvmet-fcloop-v4-11-7e5c42b7b2cb@kernel.org>
References: <20250410-nvmet-fcloop-v4-0-7e5c42b7b2cb@kernel.org>
In-Reply-To: <20250410-nvmet-fcloop-v4-0-7e5c42b7b2cb@kernel.org>
To: James Smart <james.smart@broadcom.com>, Christoph Hellwig <hch@lst.de>, 
 Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>
Cc: Hannes Reinecke <hare@suse.de>, Keith Busch <kbusch@kernel.org>, 
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Daniel Wagner <wagi@kernel.org>
X-Mailer: b4 0.14.2
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250410_044139_749494_088E5AD0 
X-CRM114-Status: GOOD (  12.96  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

When the target port is gone, the lsrsp pointer is invalid. Thus don't
call the done function anymore instead just drop the response.

This happens when the target sends a disconnect association. After this
the target starts tearing down all resources and doesn't expect any
response.

Signed-off-by: Daniel Wagner <wagi@kernel.org>
---
 drivers/nvme/target/fcloop.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/drivers/nvme/target/fcloop.c b/drivers/nvme/target/fcloop.c
index ca11230bffedb0f2313a99e24e54e892daf0d644..bb45721ec0f028399d810cbd7891bc6975801752 100644
--- a/drivers/nvme/target/fcloop.c
+++ b/drivers/nvme/target/fcloop.c
@@ -493,16 +493,25 @@ fcloop_t2h_xmt_ls_rsp(struct nvme_fc_local_port *localport,
 	struct nvmet_fc_target_port *targetport = rport->targetport;
 	struct fcloop_tport *tport;
 
-	memcpy(lsreq->rspaddr, lsrsp->rspbuf,
-		((lsreq->rsplen < lsrsp->rsplen) ?
-				lsreq->rsplen : lsrsp->rsplen));
-	lsrsp->done(lsrsp);
-
 	if (!targetport) {
+		/*
+		 * The target port is gone. The target doesn't expect any
+		 * response anymore and the ->done call is not valid
+		 * because the resources have been freed by
+		 * nvmet_fc_free_pending_reqs.
+		 *
+		 * We end up here from delete association exchange:
+		 * nvmet_fc_xmt_disconnect_assoc sends an async request.
+		 */
 		kmem_cache_free(lsreq_cache, tls_req);
 		return 0;
 	}
 
+	memcpy(lsreq->rspaddr, lsrsp->rspbuf,
+		((lsreq->rsplen < lsrsp->rsplen) ?
+				lsreq->rsplen : lsrsp->rsplen));
+	lsrsp->done(lsrsp);
+
 	tport = targetport->private;
 	spin_lock(&tport->lock);
 	list_add_tail(&tls_req->ls_list, &tport->ls_list);

-- 
2.49.0


