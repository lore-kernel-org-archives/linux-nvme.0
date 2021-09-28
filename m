Return-Path: <SRS0=nS76=OS=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CB29C433F5
	for <linux-nvme@archiver.kernel.org>; Tue, 28 Sep 2021 06:04:53 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F24CC61159
	for <linux-nvme@archiver.kernel.org>; Tue, 28 Sep 2021 06:04:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org F24CC61159
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=NBqoSU8F1iB0qTmV1jTxX9DddmYiszAx3OBs+2W+txQ=; b=gUx4n8EDyfm2Ou
	Ao539QXI6iNP9p2cxIFLdw/q4yYmPkypNIsoIj9yj+HM6lfN932kGDTWoy7IIwM8tvwW+SMQJr08o
	YTvpEJsvKzyynweUWe+P1BtsUCGFmv8hLJk1Y0jn2xY6eoyKRrspd7Vu6bDD1GwtlCHat+Ce/m3ah
	Qc+qhB69XQvlkYRwt1nM4u8iDNk5a+qwxzCmp1phxwnvj/cvlRsMHNiU5O3vnGubwFhMkl6MUntG/
	ikuW2gcTT1WOknSDcpfhJli6+0b5CWkGWzwbNcJzeFpsItvQ8PfznHD9tnZFH1YlBiGLU/mo5LFqC
	ba78NVwKQaWnImkPKZcQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mV6EU-005kTS-Uw; Tue, 28 Sep 2021 06:04:50 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mV6Dq-005kGa-Uo
 for linux-nvme@lists.infradead.org; Tue, 28 Sep 2021 06:04:14 +0000
Received: from relay1.suse.de (relay1.suse.de [149.44.160.133])
 by smtp-out2.suse.de (Postfix) with ESMTP id CD0B0201C0;
 Tue, 28 Sep 2021 06:04:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1632809047; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BCgZ0I21op2rmk/0qxbb2ua4ccLEQtSuTqpSWY9TiDk=;
 b=FaIXWAgfNZPKXHk4bG9Bm6Z8RmZaxmEiFozjCroBudwYZwU0FvtT/V4iT2LIl0l0Q9BzCf
 yNtxleGUmQlhEs9FPTTJSQ/UP0SgGTRhbn9wVIbHWsxapIEm54yVQf99yffBFAGXJTGq+r
 12a577CV7H6HTq0zzk1eKZNsQuxYiOs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1632809047;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BCgZ0I21op2rmk/0qxbb2ua4ccLEQtSuTqpSWY9TiDk=;
 b=A762eSe3plZ1InwbMgHrGXVqcuHx9QAvazsbWfPejCgYhZF/9TF+/H5YBmt2aLbg8yr9pE
 WM/DhZmBX7M0OHDw==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
 by relay1.suse.de (Postfix) with ESMTP id C352625E6B;
 Tue, 28 Sep 2021 06:04:07 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
 id 6B462518EE30; Tue, 28 Sep 2021 08:04:06 +0200 (CEST)
From: Hannes Reinecke <hare@suse.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <keith.busch@wdc.com>,
 Herbert Xu <herbert@gondor.apana.org.au>,
 "David S . Miller" <davem@davemloft.net>, linux-nvme@lists.infradead.org,
 linux-crypto@vger.kernel.org, Hannes Reinecke <hare@suse.de>
Subject: [PATCH 09/12] nvmet: Parse fabrics commands on all queues
Date: Tue, 28 Sep 2021 08:03:53 +0200
Message-Id: <20210928060356.27338-10-hare@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210928060356.27338-1-hare@suse.de>
References: <20210928060356.27338-1-hare@suse.de>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210927_230411_258902_D2CA3A7C 
X-CRM114-Status: GOOD (  12.18  )
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
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
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
