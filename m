Return-Path: <SRS0=DeHG=HD=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53FB7C433E0
	for <linux-nvme@archiver.kernel.org>; Mon,  1 Feb 2021 14:49:28 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E69AE64DF5
	for <linux-nvme@archiver.kernel.org>; Mon,  1 Feb 2021 14:49:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E69AE64DF5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=Gy7UWjXeccmI9bfVH6TR62dQh8P7l7b1twTxB6Y4kuY=; b=onWKrMfqMcy+kw24SRNxjw6ULQ
	Gp2OL858X1sc1Ny3e+l/4xd8lvgkmS/Pf2AINChybgIZfxMO993z7i9Vib5lHwAoq+MLx73RXKwPv
	l7YdRWc4xGyvviElTlQ/bO596eHpeMl//pbhMLvGYnGBRYSd/mcRrWO+Z9BjRWEp4r7MWA4iABS7t
	itdQeB1fPE+8k7y/diyugo7NvuLgeKgJakUaPHLC2IMk4mFGA/Ac8gfC2EIXKFSRmGCFhb1gbcQvk
	K+JYnhQ3NErX7VEy3G+nHiYRqaUrN/qwRoUPlEcPtLME6Bp7xb3tOhN/878BNyEhXFAc7FDCIYZjW
	zc4wGZcQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l6aW3-0000Bo-KD; Mon, 01 Feb 2021 14:49:23 +0000
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l6aW1-0000BC-6v
 for linux-nvme@lists.infradead.org; Mon, 01 Feb 2021 14:49:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1612190960;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=ZT6P6Xzb1dLaM7xdsRRrWvE5kOIaWFc/Q27nctfZZkE=;
 b=EI6T65MWlukk3YG/ASzdsCxrybhuRjdu/HZdear8gzKVd42rRU2Qh1czhEXrOO0zRMIDF3
 b3EEO/IFuzX5nLZDlqjs18FMIiux3kOvjgG+kR9x9t5tcdiUIIKiojdq/u0keIDiyq86uy
 UyIG5OuyjZ4GOOGGI09bxtvqe7BqUD0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-295-ew9ILskyPPOFmOicUVyGoQ-1; Mon, 01 Feb 2021 09:47:59 -0500
X-MC-Unique: ew9ILskyPPOFmOicUVyGoQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 84D4F8144E6;
 Mon,  1 Feb 2021 14:47:58 +0000 (UTC)
Received: from nangaparbat.redhat.com (unknown [10.40.193.129])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7D9E760C5F;
 Mon,  1 Feb 2021 14:47:57 +0000 (UTC)
From: Maurizio Lombardi <mlombard@redhat.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH] nvmetcli documentation: fix typo
Date: Mon,  1 Feb 2021 15:47:56 +0100
Message-Id: <20210201144756.37538-1-mlombard@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mlombard@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210201_094921_296873_15EC6F95 
X-CRM114-Status: GOOD (  12.08  )
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
Cc: hch@lst.de
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Signed-off-by: Maurizio Lombardi <mlombard@redhat.com>
---
 Documentation/nvmetcli.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/nvmetcli.txt b/Documentation/nvmetcli.txt
index 05a0344..7d6ffda 100644
--- a/Documentation/nvmetcli.txt
+++ b/Documentation/nvmetcli.txt
@@ -116,7 +116,7 @@ your devices and all dependent modules are loaded,
 and configfs is mounted on /sys/kernel/config
 using:
 
-	mount -t configs none /sys/kernel/config
+	mount -t configfs none /sys/kernel/config
 
 The following section walks through a configuration example.
 
-- 
2.29.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
