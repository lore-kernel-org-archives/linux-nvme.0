Return-Path: <SRS0=GAdO=CY=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E46AFC2D0E0
	for <linux-nvme@archiver.kernel.org>; Tue, 15 Sep 2020 18:12:45 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 905C720936
	for <linux-nvme@archiver.kernel.org>; Tue, 15 Sep 2020 18:12:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="tY+S6Wd8";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="f2a3OJSr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 905C720936
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=tf/ziTr8dpqfGkKXb5sE7F9Cox8PtSB4cnxgIFB7f4I=; b=tY+S6Wd8JFoMSj2ty9GMWdT3pD
	ksSWf15z9H19Lohnctpoaoxcm0GBHf+k9usyW8S9oEK+iZ3CA6M1g8eDQ6HTRJlT2/U0o3LpTVCwR
	N9fCzBGBUCrRNT9UDqFLGW9kRAn45yPK32CRD5tZbRqFADZnj29IfoSCxmQ7Lz358C/zb6N1reN6F
	7IuR87o6rwwKQwM7vBdhrl20IYg1PQW3YDcV5Bwj19PmTFmGACxpuvckgQqWgot1t+N4prYEScKlO
	ez5vE+DidhN2mLVCZOfa0i5dLb48gLVCcQ6nSh/SCQ5YraYMWegGeA7hm0iBneP7QjeOnQi8e4LwN
	nZLGO80A==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kIFRW-000200-Fr; Tue, 15 Sep 2020 18:12:38 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kIFRR-0001yv-7C
 for linux-nvme@lists.infradead.org; Tue, 15 Sep 2020 18:12:34 +0000
Received: from dhcp-10-100-145-180.wdl.wdc.com (unknown [199.255.45.60])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id D8A6120738;
 Tue, 15 Sep 2020 18:12:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1600193552;
 bh=hzJSgz1OGjx2G5tfPUm4jcr3GLAgGd9HLB1Uqh8p94Y=;
 h=From:To:Cc:Subject:Date:From;
 b=f2a3OJSr+yb3zt6GCB8SOXhpsjdLaeW/jYof2N/rJJxVcFMK6yRn9xd+HDWSe/JIm
 LbaCm8WerF+DQG5H0rukzJCWTak4xlmrtOergqxsxjRdfikK8OZsw29+UNLMjwAYZI
 IyiZa9bdmsYJxkSvcuW93MOfwyBtxizt8VQLASkw=
From: Keith Busch <kbusch@kernel.org>
To: linux-nvme@lists.infradead.org,
	sagi@grimberg.me,
	hch@lst.de
Subject: [PATCHv2 1/2] block: map BLK_STS_ZONE_RESOURCE to errno
Date: Tue, 15 Sep 2020 11:12:29 -0700
Message-Id: <20200915181230.3674743-1-kbusch@kernel.org>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200915_141233_339987_8145D626 
X-CRM114-Status: GOOD (  13.52  )
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
Cc: axboe@kernel.dk, Keith Busch <kbusch@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

A zoned device with limited resources to open zones for writing may
return an error when the host exceeds those limits. Provide an
appropriate errno for this condition for drivers that return the zone
resource block status error when the device responds with these
conditions.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
v1->v2:

  Pick an errno to map BLK_STS_ZONE_RESOURCE

 block/blk-core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/block/blk-core.c b/block/blk-core.c
index 10c08ac50697..3594efe05117 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -186,6 +186,9 @@ static const struct {
 	/* device mapper special case, should not leak out: */
 	[BLK_STS_DM_REQUEUE]	= { -EREMCHG, "dm internal retry" },
 
+	/* too many zone resources in use */
+	[BLK_STS_ZONE_RESOURCE]	= { -ETOOMANYREFS, "zone resource exceeded" },
+
 	/* everything else not covered above: */
 	[BLK_STS_IOERR]		= { -EIO,	"I/O" },
 };
-- 
2.24.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
