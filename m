Return-Path: <SRS0=O63G=CN=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA156C43461
	for <linux-nvme@archiver.kernel.org>; Fri,  4 Sep 2020 00:17:04 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A76AF2075D
	for <linux-nvme@archiver.kernel.org>; Fri,  4 Sep 2020 00:17:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="U40MdVVj";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="b9fJLhM1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A76AF2075D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=HdtkS7mItBfvRttev3qkvosqbMJF89Nwyn3Vq/v5L9c=; b=U40MdVVjLS33QxxojVaZrV+jD
	qULHpdlDLfQgaeFdpxjVpF7dHvdondlKx33bwjgXIG5A1kQMFLa8ZjAD5U5SSv3WgCqQB6HM+jSrq
	CkubkdDSreTSeMKEapVp4btboIpSmO3fyuBOeiYbeOnH5GUuBV8Oeq76k10KGb8VTmmTlzMtbijNs
	fIfQ9Jj7PaFiXBHuSSNt6mFj/QZJZiWyi5/gzEgarEdjhoAXvyJg5IAWtCttXpRRcxlaCJJo8vVvA
	uBm5ZEq/SCOso+aNSk4/oO1CoPiLeADW0pmBqBFcz97k6kzQuZrzsPRaq6HCVkY1PP7pvCdUuI5UD
	lXNjoRtpA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kDzPZ-0003w5-6I; Fri, 04 Sep 2020 00:17:01 +0000
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kDzPW-0003v6-92
 for linux-nvme@lists.infradead.org; Fri, 04 Sep 2020 00:16:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1599178619; x=1630714619;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=HoH/ydGqhqJQigPmFb90/bSx/+1WhIX8IaMbdWIRl30=;
 b=b9fJLhM1+lxnsSJFX2K9sGU3+k50GT0q9iE+yayAIfN33VcnDcrsh7Sr
 ug3Af5rfaCrSXIpuyKG+rjQxsGiRwRL64AJr8kUUche8q2iJUAc8JrMoJ
 AA8F80l1O5GjcvRuVT0Q9b2O110EokG3uCicXBPMk+VNLiRq9IruWBJuo
 CQao2QxZw8W6G1L4LJnKbh7DNwHd9HEJo2+jHH55fuzeNL4KD5Zde0V2V
 BfJsoL0r7GR/0kiM7BurF3I7kemOFr0o9/sF8Vii19gaS+s3XlMeb5dju
 0ZT0ChloG5aFaqWE0CPSgijL+t75+o29h6QQ89KSMHAreRv0ISRsWPBv7 w==;
IronPort-SDR: 2mZ9wN0S5S3nZWaE/0QLvTNWsg0SssoVNSBJYpHs1h/CtuLPsNvOAUtmkMgA2FFRMR+1hGIt8R
 uw8HzKArpzMfoEAF/Qke5CDKZr/sLDBJbKvOHX35aQNMPtLL08WT2M1YoOq4lOqJXzWYOgUhrv
 YGVYncu54ymi1Npu2334yWhTVEG5lVwzLbEZjKbL5c2eup+PKWMIE3RpfTFrL1TTrRdjrMmEY+
 dzsAvXIcU8W7HM5Q+cwS5N7GxAtaUK0jabMCVKjcDiXHlcVQXRXuuXibFU3+MXeaPQHxD6Ln1a
 ntE=
X-IronPort-AV: E=Sophos;i="5.76,387,1592841600"; d="scan'208";a="146532562"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 04 Sep 2020 08:16:58 +0800
IronPort-SDR: R0c6KxBiGonD6RyphHSg25o3xNb9RHrYjubWDCtP/98/F8oAosYb1Xx9CIyeEXEIacY9i5gvQE
 HZqgDKplKVjw==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Sep 2020 17:03:30 -0700
IronPort-SDR: VEtDcU0IHihFYBJmedWxPs/VjgLWmlPSVaRC5Ac6yTHkbnXPs0onLTy3biY+tfSXQvhPsm1vh7
 QS1tshOh5PuQ==
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip02.wdc.com with ESMTP; 03 Sep 2020 17:16:57 -0700
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH V2 2/6] nvme-core: use I/O timeout in nvme_submit_user_cmd
Date: Thu,  3 Sep 2020 17:16:22 -0700
Message-Id: <20200904001626.5694-3-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20200904001626.5694-1-chaitanya.kulkarni@wdc.com>
References: <20200904001626.5694-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200903_201658_486355_20D2EDAC 
X-CRM114-Status: GOOD (  15.24  )
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
Cc: keith.busch@intel.com, hch@lst.de,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>, sagi@grimberg.me
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

In the function nvme_submit_user_cmd() it uses ADMIN_TIMEOUT when
caller doesn't specify value for the timeout variable. This function is
also called from the user I/O command contexts (nvme_submit_io,
nvme_user_cmdXXX)) where NVME_IO_TIMEOUT can be used instead of
ADMIN_TIMEOUT.

For now we don't set the request queue's queuedata for admin command.

When timeout is not specified based on the request queue's queuedata
set Admin timeout else I/O timeout.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/nvme/host/core.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index e6c980962d51..a2ef4249ce6a 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1086,7 +1086,14 @@ static int nvme_submit_user_cmd(struct request_queue *q,
 	if (IS_ERR(req))
 		return PTR_ERR(req);
 
-	req->timeout = timeout ? timeout : ADMIN_TIMEOUT;
+	req->timeout = timeout;
+	/*
+	 * For now admin request queue's queue data == NULL, if that assumption
+	 * changes it should reflect here.
+	 */
+	if (!req->timeout)
+		req->timeout = q->queuedata ? NVME_IO_TIMEOUT : ADMIN_TIMEOUT;
+
 	nvme_req(req)->flags |= NVME_REQ_USERCMD;
 
 	if (ubuffer && bufflen) {
-- 
2.22.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
