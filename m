Return-Path: <SRS0=S8v+=4A=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AAC6C352A4
	for <linux-nvme@archiver.kernel.org>; Wed, 12 Feb 2020 20:02:12 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B2D821739
	for <linux-nvme@archiver.kernel.org>; Wed, 12 Feb 2020 20:02:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="VpXyz97H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B2D821739
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=wgY4HXeuiQ0lvPo+iam5QS5G8C7vya2Y2fV1NgnimcY=; b=VpXyz97H06lS6/
	RPHGVmbMuzivm/zbtDbp+uZ+RUdjcCcqiOvuJ6moNJErQ2VY3OZJil84TcuLqoEwwQSpN6J8YJrcU
	kKIy8EPpUYkXT8UnJ95xb6TfEmLWIYJpgeaKuFOKwsKsqeKSl/Xf357SWl5jDcXc3ogTvMkxqiUwY
	3HTg+hQvvSIluzZTcV15RBJysVq4BNG4mBxwSB120TgmRwCAkXCBjSHxMmeSPnKhIRy5rC/cZYxFA
	gtyBATiO92Qqo8v1aF1+EG5qLbdxMtrIcnzqiEf2ilAjGU5Y7nB3yTdeEiEbMaCrUUC3B5BwpkPlg
	nT2myE/g08bQ9H/nOADQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1j1yD3-0007co-3B; Wed, 12 Feb 2020 20:02:09 +0000
Received: from [2600:1700:65a0:78e0:514:7862:1503:8e4d]
 (helo=sagi-Latitude-E7470.lbits)
 by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1j1yCx-0007bx-Cm; Wed, 12 Feb 2020 20:02:03 +0000
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-nvme@lists.infradead.org,
	Keith Busch <kbusch@kernel.org>
Subject: [PATCH 1/2] fabrics: ignore hostnqn file if its empty
Date: Wed, 12 Feb 2020 12:01:57 -0800
Message-Id: <20200212200158.14237-1-sagi@grimberg.me>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
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
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

If we read an empty string from /etc/nvme/hostnqn we should
ignore it instead of passing an empty string to the
driver resulting in the error:

nvme_fabrics: unknown parameter or missing value 'hostnqn=' in ctrl creation request

Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
 fabrics.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fabrics.c b/fabrics.c
index 254a2be615ac..4b5c9669edc7 100644
--- a/fabrics.c
+++ b/fabrics.c
@@ -677,7 +677,8 @@ static char *hostnqn_read_file(void)
 	if (f == NULL)
 		return false;
 
-	if (fgets(hostnqn, sizeof(hostnqn), f) == NULL)
+	if (fgets(hostnqn, sizeof(hostnqn), f) == NULL ||
+	    !strlen(hostnqn))
 		goto out;
 
 	ret = strndup(hostnqn, strcspn(hostnqn, "\n"));
-- 
2.20.1


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
