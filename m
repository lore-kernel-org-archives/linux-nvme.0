Return-Path: <SRS0=rzv5=EW=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF40AC388F9
	for <linux-nvme@archiver.kernel.org>; Mon, 16 Nov 2020 23:41:23 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 28E6F20729
	for <linux-nvme@archiver.kernel.org>; Mon, 16 Nov 2020 23:41:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="iTSOHbeu";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="AoFFMrRx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28E6F20729
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=FJmWt+svaOrXn9cCvIqGGkyDRLT70I4MVQ/XJjPETnk=; b=iTSOHbeu3GJfkM9jqRgcioGIoK
	yZUr73BxkDdDn60MDrWg35ZcbiNyK1qqWf4X/8LNmFP5nhZfZmuxLKuWmvkARnGv8G53iXqbdUkqy
	RVPfjDuxmW1rTp/yeqQbpp+aNM+Jzi3iv12qra2PQD/XaqXU19IuWRlnu+BucNevD8MO2vS9V2hp4
	hVH1QeaHfjDcO9/y7iM9x2yKpJwFdp3J5BHGe4ERPG118eZPy+BqaOtmNG8MHP9LKfLy6M7TjvHUF
	YUgMZu2bxdR/p6L3HuWKWwrA6x4a02n3HfRt+x5EHoWUfMp530EXVS8pMSJo4Tzgogt7LAj9ubmzz
	c1IjXqEg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1keo7a-00063q-9e; Mon, 16 Nov 2020 23:41:18 +0000
Received: from esa1.hgst.iphmx.com ([68.232.141.245])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1keo7X-00062m-9l
 for linux-nvme@lists.infradead.org; Mon, 16 Nov 2020 23:41:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1605570075; x=1637106075;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=5BLqcqLmjFKIC2/e79lGXOlYGQ984iau8g8CC/lDa/s=;
 b=AoFFMrRxE3Q7obJza9epzaUrzPpYXzVdcMTC1zAeWQcqdivEMNMMuJ3e
 nGMeWLgdcCM8jkmyncONzqZJXmgW4ntH0P7ysZdnq3bUyny1dT66U+6SS
 D6DJBfVFvDyt72mDQgc6PCAxzMdhY+a35/RuOLnCqWcV4ITNaL1uWv6nm
 cQyMU4MnWXkV4/KDnGoTBmDBqKVGCXnF5J7NN6ZuSKpjL5GWe66E8t/s4
 CSGz2BoFGNpAMLKcN9zHf8DyPxCbGJXRBixQb43nzR+oUKyYzMBk8aDoq
 kvW5kQ/11Wxd+8qC805JM3sIK1DIfDbhE+oRtK5ovZ1seiDpuWa6w6MLo w==;
IronPort-SDR: DS/qLzn9W7Xd0Qy3mUWofF1jtNPB5x/jziECllrLspt5j0AX+h8OLkPmtFr35+vCs8zFenPKDs
 q1boHYD/3GumZeyCdhjCHArA3GpqEG6MjB1sberVDmAIvQuiF+39OPQn5aVuJecTuo5osIjY2E
 ILZfVj7UQ3dhiJAf4piD4gzwVxXlppBn9Svij63Mv3rRkSwIgiuWTmVzxD2nFv3QUIMFySniHW
 ZguXUC7KCKlh6TXhc+RMb+AKIqpoQ6EgsIE+WgxTO5XHd8C5+DWTLK8AAy6stAXMRUBEqXV/WQ
 BdA=
X-IronPort-AV: E=Sophos;i="5.77,483,1596470400"; d="scan'208";a="262774390"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 17 Nov 2020 07:41:13 +0800
IronPort-SDR: IEFRVII0UDQLvCTW3MiD1GxWIS0Iotd7GZpaw5j/E5xZyALCk+cA2zifWYfmJB7AMuD/r9HHxa
 EtcMCrXtRXby8ObM1bxOPDm/7Nz+fKbl1H2m+IMBdXtEkwXPMafy6ZQLdPwHvB3+1zROC4xgTY
 0RcDHnBfocY8FCHoo+cYNTK9uhCYACgQvcQP7iNY8xW5cjPBSWr8Fup3HeN4z9rRWAVqRlMwi8
 SpSpP/SIJbEnvMimWoS0enyK1qLTFouQqzDGZjFT8RbtN8fc7r3dPvNtbuNjlMS1CdHBNgsQhK
 QYYVEnvA1JapRzGxz5IDZNMj
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Nov 2020 15:25:46 -0800
IronPort-SDR: jr/kNC3CgdcGsSh+tffRxsno7bTefWkFq2FzxwSscDOJX00Hfp1v/89e2tuLWBAFL0056pMhEV
 /mV+bQOkvsOazdOhIhZeYRyuPeQ7XbLGbt7QrNXQ2REqDUG7S36Nqce8MIRX+33ZqcmemTvIQw
 ITa0LxktPcrqz+wia4FdDsw5XgVwbWzR+4nAeDKj7WwKui8b7XQiY4xrgC43Rlvu6sDBXfJ8TE
 3m0WaUKesL9I/Moq1b7DfphUh6ovp5qqAlgsOdfdLVlWZJKMu3tGPODH7lEw2dveH8fuMWscO3
 uCA=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip02.wdc.com with ESMTP; 16 Nov 2020 15:41:13 -0800
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH] nvme-core: get rid of the extra space
Date: Mon, 16 Nov 2020 15:41:12 -0800
Message-Id: <20201116234112.38788-1-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201116_184115_587699_47AC8543 
X-CRM114-Status: GOOD (  12.59  )
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
Cc: kbusch@kernel.org, hch@lst.de,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Remove the extra space in the nvme_free_cels() when calling
xa_for_each loop which is not a common practice
(except drivers/infiniband/core/ not sure why).

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/nvme/host/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 9a270e49df17..1fb35d3d6f7d 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -4378,7 +4378,7 @@ static void nvme_free_cels(struct nvme_ctrl *ctrl)
 	struct nvme_effects_log	*cel;
 	unsigned long i;
 
-	xa_for_each (&ctrl->cels, i, cel) {
+	xa_for_each(&ctrl->cels, i, cel) {
 		xa_erase(&ctrl->cels, i);
 		kfree(cel);
 	}
-- 
2.22.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
