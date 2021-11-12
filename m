Return-Path: <SRS0=M30F=P7=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AE21C433EF
	for <linux-nvme@archiver.kernel.org>; Fri, 12 Nov 2021 12:59:56 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0952661078
	for <linux-nvme@archiver.kernel.org>; Fri, 12 Nov 2021 12:59:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 0952661078
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=FqRFmygRJ2NziF/2RX9SUZuxIA2Lc8m8hpwQLm+zOTE=; b=RBFltjlxtjgYusJgs57PUuBjjU
	B+bGvdya0ZWrs8WiM+5B+avUVIK9PuKGvKc9cAT9BVJgRhMhANaDVDQgexsSvgQXgYTgExU6pFnGq
	JMoUwvgTMyYnDzzaIoixMT4Exe9MvEcwwX/qrAjqjISGHNW49ek0dSa2E8XI35zLcKOhHCtMdGRpw
	8CZC75J7XFFRcwamIohCGJ8pryRi3wCJVjKbMGlPP/d5LratBqcUPhanPMz5maX/2F0r1KBaWoCl8
	Lj88EJKlWUDzQSSD9iGghBOPZlscdqjA08uzEpG8Bv0A4F/tdKPbHSy9A29S9K0mxxKTep+D4nWzN
	dO2XWTpg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mlW9j-00ARGt-Ox; Fri, 12 Nov 2021 12:59:47 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mlW9d-00ARDh-Ep
 for linux-nvme@lists.infradead.org; Fri, 12 Nov 2021 12:59:45 +0000
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id A86DF1FD5F;
 Fri, 12 Nov 2021 12:59:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1636721977; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FqRFmygRJ2NziF/2RX9SUZuxIA2Lc8m8hpwQLm+zOTE=;
 b=YbRMBMEZ1w/sIjcZC4c2Xx2/A8eQfy4TxXIzyHDlHv8S0A/pqOSvGAhhV1e6fXNuulC6Zx
 JUjhmv2D2X/42aJAawguEnih0c1GCLfANUq3jg5LVpFgzOt/LSdp5CayMtRMqoVPOZUHKw
 TD8ZtkT136Uf45psNSEdIC7gnzN95MA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1636721977;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FqRFmygRJ2NziF/2RX9SUZuxIA2Lc8m8hpwQLm+zOTE=;
 b=9OJOmg4dxXJPfICBBb7i7Pk8XikjwWwPYXPn5+cBgwZxPyURazl4OZoatseGwJMCN5FOUY
 45qL3sLllc4Fq/AA==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
 by relay2.suse.de (Postfix) with ESMTP id 9AF79A3B8B;
 Fri, 12 Nov 2021 12:59:37 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
 id 49DAD5191265; Fri, 12 Nov 2021 13:59:36 +0100 (CET)
From: Hannes Reinecke <hare@suse.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <keith.busch@wdc.com>,
 linux-nvme@lists.infradead.org, Herbert Xu <herbert@gondor.apana.org.au>,
 David Miller <davem@davemloft.net>, linux-crypto@vger.kernel.org,
 Hannes Reinecke <hare@suse.de>
Subject: [PATCH 09/12] nvmet: Parse fabrics commands on all queues
Date: Fri, 12 Nov 2021 13:59:25 +0100
Message-Id: <20211112125928.97318-10-hare@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20211112125928.97318-1-hare@suse.de>
References: <20211112125928.97318-1-hare@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211112_045941_718581_3416C0D1 
X-CRM114-Status: GOOD (  11.38  )
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

Fabrics commands might be sent to all queues, not just the admin one.

Signed-off-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/target/core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index 5119c687de68..a3abbf50f7e0 100644
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


