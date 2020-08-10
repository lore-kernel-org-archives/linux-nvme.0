Return-Path: <SRS0=L2sc=BU=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92C29C433E0
	for <linux-nvme@archiver.kernel.org>; Mon, 10 Aug 2020 18:55:13 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A08A20885
	for <linux-nvme@archiver.kernel.org>; Mon, 10 Aug 2020 18:55:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="MIyuyC2I";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="PAzXOtHw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A08A20885
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=TQ2mQv1xoNe2TU6hN70JWEP8WnBEREnmdWsvUqghV1g=; b=MIyuyC2IMaE9j7NCTJjljtHNv
	BhYqavR3zswd2Ue7C5gfes63mkzDs7hhLQeu6s8i1Gjs3PMgxHYCG7nAWr5kk6FTMMBEbYkGd1DTz
	fy4CPV0hGkcmDHy5McbwyM23+6Qd/Al73/5YWvuojpMeBY+luS/ywDu6b7Sr+Nw+jL5HE/IvqUi/a
	mjV/wLJwL7A11HnEgkkHUHkt53ZoWyTKhBE6OvIQ9ShLZI2PNGMT6xf57oGezKWnl8hQST0xL+AuJ
	WfabBV3NQrXgYfgp4FFZCkxSs5+4uqJuSoVcUaOklwcAh+IFSxQOGr3H5UEzK+7ahJpThJZuJQgwp
	r9nzC5ofw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k5Cwx-0006vV-0J; Mon, 10 Aug 2020 18:55:11 +0000
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k5Cwt-0006un-Ke
 for linux-nvme@lists.infradead.org; Mon, 10 Aug 2020 18:55:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1597085708; x=1628621708;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=XFFUdE5KSUMEpRfOB2JxWn50o7NqhqP83VhO7tD3A+4=;
 b=PAzXOtHwZTTyM9ZncKMjLk6ucUFW9cUW/EtJvqDgmw5Pu9ycjV/ZlhCS
 TI9G+MI20ajm11ARxZh1Puua3kYCH47eS7nke0a4iW+Sg+E5leNOKbtfU
 je4nL7xS0iUbBrUfl62ISwJtP13nmoAXxHk1ad+QomZ4bdNG/lD5GAYkF
 9BD39bk9+VBQJ2pGETT6otIyZctEMP841nDlSC9zM33IdnXJ/7sE9oDxn
 m2hALagaPRejNEqlXzfWpqT7K3tm8LbZbZPBgUHMi7Bm66HbdYS7G6TH9
 neUM0w9dP3/WBSA5vHwaqBF33YVgrNkX/Vqn9oUwG2W6awE2PZlzxPDHI w==;
IronPort-SDR: H7L3Nq69UQYjAckMLeIWJL1xHwM7KRyOGfqP8c+CMr57s3TEofdInk88VK1aV3Lln+hJsxvon9
 5/y0wNDP26Hhkls70TAvi9zuqBHy82zOvFcXL59fqSms3glaQxtqvRaRuZhv2fj80GrVCJTb8/
 otEoloINUaZ+JEAy2jOYKhUsspmjlbWW6COWCRav/zYXHPt1jS9cEDfei3uDkwZqDnOT9b2V/6
 UC1VSMoRwr0BQVBLgqtZ1yeZBD7AY6Q6o00kgiXog+2JQ3pi37fh0XIZsCqkOJfYrV+P8hAqpe
 hqQ=
X-IronPort-AV: E=Sophos;i="5.75,458,1589212800"; d="scan'208";a="144651197"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 11 Aug 2020 02:55:07 +0800
IronPort-SDR: 6R31RidPGjRo7k53dX5Ic72JDHuQ3LQZ0gPrBAl5xUEfq/XJPf11c3q17qUjQSm1OCKmk3loQ6
 nndTgvoUFpFA==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Aug 2020 11:42:17 -0700
IronPort-SDR: 23/E0pcc9m6VWRxGeYAHVD+9TjYlJ+EZBUxn8EbjhLLQO+2uoALiB3ydYy59LWPlzDJYq2r4t/
 5cGThYAHNvUA==
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip02.wdc.com with ESMTP; 10 Aug 2020 11:55:06 -0700
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH 01/14] nvmet: for pt I/O cmds annotate req->sg_cnt likely
Date: Mon, 10 Aug 2020 11:54:43 -0700
Message-Id: <20200810185456.7713-2-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20200810185456.7713-1-chaitanya.kulkarni@wdc.com>
References: <20200810185456.7713-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200810_145507_819657_8A2293AA 
X-CRM114-Status: GOOD (  13.48  )
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
Cc: hch@lst.de, Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
 sagi@grimberg.me
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

I/O Commands (nvme_cmd_read, nvme_cmd_write) are most command commands
when accessing passthru controller. For I/O commands data is represented
in SG list, so sg_cnt != 0 in most cases.

Annotate req->sg_cnt check with likely.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/nvme/target/passthru.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/target/passthru.c b/drivers/nvme/target/passthru.c
index 68701754b036..fd1f754de5b4 100644
--- a/drivers/nvme/target/passthru.c
+++ b/drivers/nvme/target/passthru.c
@@ -242,7 +242,7 @@ static void nvmet_passthru_execute_cmd(struct nvmet_req *req)
 		goto out_put_ns;
 	}
 
-	if (req->sg_cnt) {
+	if (likely(req->sg_cnt)) {
 		ret = nvmet_passthru_map_sg(req, rq);
 		if (unlikely(ret)) {
 			status = NVME_SC_INTERNAL;
-- 
2.22.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
