Return-Path: <SRS0=S/y/=OA=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49B50C433F5
	for <linux-nvme@archiver.kernel.org>; Fri, 10 Sep 2021 06:44:30 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A7F26109F
	for <linux-nvme@archiver.kernel.org>; Fri, 10 Sep 2021 06:44:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 0A7F26109F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=K0nNC/cj2hxHmpf7Y6T0oQpxrBcEzwEbOz3Pubz1a4Y=; b=QdnaE6vbvgeL3V
	ewXQ9ghbM6M8ru/CrF9mrIjxwebrhLnIESeDZSxfBYw/PCXLQ/2Qhr7I3+mTsO2uAMh96JNTZmzIF
	Cz5FOh+zfVEUzGa03rMFf99FiC3FkWxphL0U1gXOuuNsI4Z3gLYn44d5d8LO3DMcClIRfDaWXORlD
	pqPV71dOu2HUZO1PZrI+v7rZdgV/HOr1vMAdZy8IxRQoQlPzkkDR4gMm838sEnJrjysEN5UdChsJ6
	Ij2INrw/zt8jvaR+z2CywUTYghf7fVNeF7q46UkRk8H71ouhBgULLDiYiInIvg7KDuznmre4ZPJ1v
	yaoKASqjIKHRGs1axv5A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mOaGf-00Bylf-Jj; Fri, 10 Sep 2021 06:44:09 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mOaGH-00ByiJ-50
 for linux-nvme@lists.infradead.org; Fri, 10 Sep 2021 06:43:46 +0000
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id 31FB022405;
 Fri, 10 Sep 2021 06:43:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1631256219; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=srhVZYwLz0PjQrcrJn5O0lC8HINyMZgoDRzmicTlgRo=;
 b=u/s/35QDywYnVLFhjZWl2ky2RtOOpBczfJGVh0EWPbffxBlDScJNH1OTYu320J4+rDkfLZ
 Qwsz36q1ux6EzCuhfLS0ykMPbV7lKuVhx+Dd2zLrN2T6eWZzJnkwClz+LTaTi2Y2m/cpSP
 30Fzg2+GxD+QQQ9rLYxfIvSkDi8BuC0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1631256219;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=srhVZYwLz0PjQrcrJn5O0lC8HINyMZgoDRzmicTlgRo=;
 b=VAL3R5eczgCQZiCbIwZC3lA5tK7DTmUQF/0xTy2lnvTwmI6qEs7ubd4O0eB5Q8ZqWRMXA1
 7YQzZecm/81nIXBw==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
 by relay2.suse.de (Postfix) with ESMTP id 2A205A3BAF;
 Fri, 10 Sep 2021 06:43:39 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
 id B8DCD518E32C; Fri, 10 Sep 2021 08:43:36 +0200 (CEST)
From: Hannes Reinecke <hare@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>, Keith Busch <keith.busch@wdc.com>,
 Herbert Xu <herbert@gondor.apana.org.au>,
 "David S . Miller" <davem@davemloft.net>, linux-nvme@lists.infradead.org,
 linux-crypto@vger.kernel.org, Hannes Reinecke <hare@suse.de>
Subject: [PATCH 09/12] nvmet: Parse fabrics commands on all queues
Date: Fri, 10 Sep 2021 08:43:19 +0200
Message-Id: <20210910064322.67705-10-hare@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210910064322.67705-1-hare@suse.de>
References: <20210910064322.67705-1-hare@suse.de>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210909_234345_445061_522EC656 
X-CRM114-Status: GOOD (  10.62  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Fabrics commands might be sent to all queues, not just the admin one.

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/nvme/target/core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index b8425fa34300..6e253c3c5e0f 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -943,6 +943,8 @@ bool nvmet_req_init(struct nvmet_req *req, struct nvmet_cq *cq,
 	if (unlikely(!req->sq->ctrl))
 		/* will return an error for any non-connect command: */
 		status = nvmet_parse_connect_cmd(req);
+	else if (nvme_is_fabrics(req->cmd))
+		status = nvmet_parse_fabrics_cmd(req);
 	else if (likely(req->sq->qid != 0))
 		status = nvmet_parse_io_cmd(req);
 	else
-- 
2.29.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
