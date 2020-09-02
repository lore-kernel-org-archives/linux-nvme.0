Return-Path: <SRS0=9ikG=CL=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77587C433E2
	for <linux-nvme@archiver.kernel.org>; Wed,  2 Sep 2020 02:13:33 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 374DD2068F
	for <linux-nvme@archiver.kernel.org>; Wed,  2 Sep 2020 02:13:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="m193roZu";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Li9Txggo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 374DD2068F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=KCYXv+eXqSC4eWkVSvC6dHUTIkWVKO7jZBcnsQK4d/k=; b=m193roZu58ttittjdeJRHZjVIJ
	xyCFpPV3s6WeN31BLTplFTmYJOBstXL50C64YXER7d9XzfV4Z983AAj/Wod6MxlJ4+vV862kDUOah
	jR6Iac26YILItFyf1NV0uYcPCN2nWndgpzd76vxnULrsif8lvxraW6fkmy/3HKeM4w5MMZgS/M6m8
	CB2ZonsP6znjVSwROOinBSooQ9dOG022J+w/ob+5WvX+dwzt3xWa36UrgjnKEHOyjB8nhu+22GNOr
	+1n2JAHNBxNqpsA9v34H/sLmrunlp7UCjT/cqngybI8tFruTw1Jhi9hb2lRoy2sQ5QOmQAlVkNhOD
	RlrQu44A==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kDIH9-00018s-PD; Wed, 02 Sep 2020 02:13:27 +0000
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kDIH3-00017V-Jc
 for linux-nvme@lists.infradead.org; Wed, 02 Sep 2020 02:13:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1599012804; x=1630548804;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=A8dSK5H6+XnLakaL2IQ/Q8FjNcLnzMspOkHAkxwvGPY=;
 b=Li9TxggolUElslXVLWi/sYjAXNJ3XPfZc2IBgQvShiK8G3mAtuD3kZUs
 uNgSmsk4yMrCt6+DjKP+rOMqC0k8IQNkY3G1bd1/ijtHS3/yhR2m67+n0
 At5N7JhXISsvX8CYedjdfXxOyGIdrdOXKiaovUGTH/VzHq+h5DRJ7WaDY
 nqoPyDw/1fHo0yKHlAHNj5JzFPVufqAmQOy3iW37SyseyeGCkPLUXu1/L
 wqeVACObquT+ZV8/vMvNo8kOHSpzxDBVmuvhNKfGGGY86KYzIMuQUG83F
 uIspfT/Da2/aamdGcJJuuPDd9BR21PMkXXYh9gTDUM48fxr77pvAFs3Sm Q==;
IronPort-SDR: FOQcXXc2ghuimY35XKJBXwNWR8bOKUUqaq2H6TCQycHSRetHE1YqEBJhHqINp/Vcn4mvePDeHq
 ZH5KUu9SKmBU2jUccMbvqA3a9NGltn0B63N9N4vZ21lLwnNhwvFLe3vzLvFDNG2jDKSHt0mV2c
 3pwTYaIBIQmuZtjA8n0oWDdiBWH0HveHxrvXakc3IVtHwMHHH1BgSb5s9Ji29OalapU4doO86k
 UfS2rIPUpikO2wsD6hjxP19mYwguTfZc1oQ1vP1FSfgOg/Ty+s75hGhFskTfFpYuup3bMVJoRB
 ils=
X-IronPort-AV: E=Sophos;i="5.76,381,1592841600"; d="scan'208";a="249629992"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 02 Sep 2020 10:13:19 +0800
IronPort-SDR: U6LoeluP3E2NgW18hMJWoag1oMnfPkWnXUmZQUwRkLQw12F6B52WAT1fik1dC3yobzT18R/nZE
 S9ScwqiJQI+g==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Sep 2020 18:59:54 -0700
IronPort-SDR: vdnnBxKol4YbQ/vVdM3RI8P0XdtYgjFL+r+EjCCP+11MsJeYjYpec9u6HWFeAuOZeyqjQ1GyIP
 55CJeWOXzHRQ==
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip01.wdc.com with ESMTP; 01 Sep 2020 19:13:18 -0700
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH 1/2] nvme-core: use I/O timeout for I/O requests
Date: Tue,  1 Sep 2020 19:13:07 -0700
Message-Id: <20200902021308.49606-1-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200901_221322_151501_6AE37D80 
X-CRM114-Status: GOOD (  13.58  )
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

In the function __nvme_submimt_sync_cmd() it uses ADMIN_TIMEOUT when
caller doesn't specify value for the timeout variable. This function is
also called from the I/O queue contexts (nvmf_connect_io_queue()) where 
NVME_IO_TIMEOUT can be used instead of admin timeout.

When timeout is not specified based on the qid set the I/O or Admin
timeout respectively.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/nvme/host/core.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 5702a3843746..f4b1df32078e 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -885,7 +885,9 @@ int __nvme_submit_sync_cmd(struct request_queue *q, struct nvme_command *cmd,
 	if (IS_ERR(req))
 		return PTR_ERR(req);
 
-	req->timeout = timeout ? timeout : ADMIN_TIMEOUT;
+	req->timeout = timeout;
+	if (!req->timeout)
+		req->timeout = qid > 0 ? NVME_IO_TIMEOUT : ADMIN_TIMEOUT;
 
 	if (buffer && bufflen) {
 		ret = blk_rq_map_kern(q, req, buffer, bufflen, GFP_KERNEL);
-- 
2.22.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
