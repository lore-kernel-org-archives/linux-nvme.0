Return-Path: <SRS0=w+e8=AG=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C736C433DF
	for <linux-nvme@archiver.kernel.org>; Thu, 25 Jun 2020 00:19:22 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 22B672078D
	for <linux-nvme@archiver.kernel.org>; Thu, 25 Jun 2020 00:19:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="S368xNWp";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Kpag0y4P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22B672078D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe
	:List-Id:MIME-Version:Message-Id:Date:Subject:To:From:Reply-To:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=RKRFTnleR+NxtTc+6s77Du0ST60bK75wB96NVHIr1P0=; b=S368xNWpuT+vrWT5PnvIjBObfl
	MEe9YeEiCcR/X9nKf3u8ziZ6EoNUJyRMB7aE4Dble4GDqHA4CzU1Kw9U8mZq6MtjoD9BEhfHp/wBh
	Rlyfclyi6/pxmnzRTs+1oe6RH/wG6mOmVksUClv1yjZyIqmLxbskupAd01v/KrKsd6prDsnonWTfE
	hwSC75CavxhKakH9qSZb5DItgpyjqxkeFTA9h3YlUYCZDIxCIPzRLNjYiz+dJCybY2sJroYEHkwUL
	pRg1BNay/CI5q0kZ/NhlOZCdgtH+lZNgkVP330cYYM1uP+bWrstLUxsNLNrbUZeAQF7LSKbpjRZ8G
	1zjNMT8A==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1joFbo-0003fj-I0; Thu, 25 Jun 2020 00:19:16 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1joFbm-0003Ap-7u
 for linux-nvme@merlin.infradead.org; Thu, 25 Jun 2020 00:19:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:In-Reply-To:References;
 bh=wywlvmRu1mfUIVJ41TRmrfAx3KPPFw8gsPRSshHGf0A=; b=Kpag0y4PlQWagh1xdifQNA4MJq
 ex0hIh88s2ZdBMsXkojlAntAce732jCgSFnmSI5UeXWjH/i1cKwqhW+i1z8VmTp8Rsb7+LdzB2Mvn
 dTZe8pRkoznEqYCNYHrjXwX33c0H+nofLcI6xco5LpMN9ddGdNDJDP87UBWo9ASPtITPkcI3gKPha
 534WHdVvIHlxGgkzBAH2V8qNM3X80JefKbiFBXeuJnQUm5RaxlADjp4WI4MjEln6R5zK+0i1PiMgj
 Km/87EyobYczacIypAMCpoX24Jv2+PPC9THLex7zs84OqL/2gj3s49u8OhMsWjmmxhzhnem2Lz03q
 swsm5pNQ==;
Received: from [2601:647:4802:9070:4c08:474f:e61d:6947]
 (helo=localhost.localdomain)
 by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1joFGK-0003RJ-EG; Wed, 24 Jun 2020 23:57:04 +0000
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
 Keith Busch <kbusch@kernel.org>
Subject: [PATCH] nvme: fix identify error status silent ignore
Date: Wed, 24 Jun 2020 16:56:59 -0700
Message-Id: <20200624235659.28722-1-sagi@grimberg.me>
X-Mailer: git-send-email 2.25.1
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
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Patch 59c7c3caaaf8 intended to only silently ignore
non retry-able errors (DNR bit set) such that we can still
identify misbehaving controllers, and in the other hand
propagate retry-able errors (DNR bit cleared) so we don't
wrongly abandon a namespace just because it happens to be
temporarily inaccessible.

The goal remains the same as the original commit where this
was introduced but unfortunately had the logic backwards.

Fixes: 59c7c3caaaf8 ("nvme: fix possible hang when ns
scanning fails during error recovery")
Reported-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/host/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 2afed32d3892..3e84ab6c2bd3 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1130,7 +1130,7 @@ static int nvme_identify_ns_descs(struct nvme_ctrl *ctrl, unsigned nsid,
 		  * Don't treat an error as fatal, as we potentially already
 		  * have a NGUID or EUI-64.
 		  */
-		if (status > 0 && !(status & NVME_SC_DNR))
+		if (status > 0 && (status & NVME_SC_DNR))
 			status = 0;
 		goto free_data;
 	}
-- 
2.25.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
