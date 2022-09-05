Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17C06ECAAD5
	for <linux-nvme@archiver.kernel.org>; Mon,  5 Sep 2022 15:32:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=K/HhzQQcQF0znmsCjkAykW8+2UlAaUoR1Wv0JTTHWhQ=; b=AN554DJeFer66rK6AXHI/Cizrw
	m1pGR4svjCz3tFY6LL9NgplpK4PS9gFbx5rItrsfDhgVMHhdbOYUUbUMAM4JwGNO9IIyKf7FP3yaw
	+O1n8axzWcO+g8JFaRZoGZoKjec2VIPM1IDNUfUWjuuAj4ME15VcZhWxGkJup6jUyWnh6OlR1n2Md
	EIOduQVfIJb2toz7bK7LDSpYBNEF+1YGjLxa2o/ZAic8qJ2xqYWx35E86wSL/xWAalBnTEGZjfSk/
	Uqg6N1o2DOh8i8l27ZRAlfoLaURagU3HsJzcN9sdHUNp6pCQct/VBaRzJbi6NHlHC5ndvVAhAuHVx
	VQnCIz0A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oVE4u-005zw6-5J; Mon, 05 Sep 2022 15:32:00 +0000
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oVB8o-0027Ss-HM
	for linux-nvme@lists.infradead.org; Mon, 05 Sep 2022 12:23:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1662380630; x=1693916630;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ZUsJNKl9kM4XrO+bzq6rMd4l+h94hGBCGq7tktFiIIQ=;
  b=rFiDE2p2eLzQlD1mjBLwpdnLCGpsbrBgHdgE1kgZEHQKKaS1shd2SKTG
   oVxZUWaFhbC9qQEkIulszAkucxnJBdXq/nU44QhzuSCp/rYeYvDcoVOKy
   gmd2fxSXJS4OZOpeQAQdlAdKwHB0BLTtcJhcH2EAAtUfmfvxKmBoD/Xmp
   L1aB+KdxZup8xpHppO8de6mH3O/l4pPuCgimSN9nOMgyakcs9nqulcoBH
   AnFpszk2Ls3hoCweQH+QmGct/hjY8Ba4k79RQ2tKV30dsE17xdHghIHg/
   eOw9oCMVuxIyjUcJ/vKkPCjyMqJol7NPTtq+WfaIDaHmFga4R9FlpEyGa
   Q==;
X-IronPort-AV: E=Sophos;i="5.93,291,1654531200"; 
   d="scan'208";a="314815549"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 05 Sep 2022 20:23:46 +0800
IronPort-SDR: rtxssDDfBAVSq2E5HQr6If/3/9QNA5+LfpXWMLvoRDYyFsEBYJhm58tMfu+o1D2+su8mvepVxs
 t21hwthONL+1x6R6SUsw+XFdqQkrlmSqwtUMuZETpDctK+1wC4M9CqaTu2o8cQ2qGXSeg3k8It
 p6wwNWt7QtjKmTwBMNMn39Xeyzzk2x+TTx2uCkTbHYHqM5l3upekx/rBh/DNhwFYqQaUH1xNtH
 5R+lUP+HOgwmppXRxKmf3Y1UQZtjqUU3go7NkVQhNWBl9Kd6bxH0QRzXTqNI7Ryq8SvGBJmR+Y
 nTTGfOXzHBxhBlAHWgUAfXRr
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 05 Sep 2022 04:44:08 -0700
IronPort-SDR: 8dcfSLnIvZGdzY/wgFlmxn9ul7k1JgAU4lPkFxVrWiWs3OHLEzJMFKX+hCGBOxrZJxSe98SF+i
 kOgib49keGaFjuR5lmQKiPLm+Iq+mvm2JU4aCaAIqchI60k15kdGtpNTXn+GY2cu638ZWtNyrD
 YHMldbx7IZv8fUtGtVBsZ1ETnfvs7+eY9qMVm5D+9L/HCJVKY7kXyhXoIHxgtYhDkRN2eQCtMe
 CHclfAFhL/PGcmTBrowym8Rw0WO7kQgsXTxTKHeEneqzoAad46MNzi+xqqG3rNbGRZBlyRSXAL
 1qs=
WDCIronportException: Internal
Received: from dellx5.wdc.com (HELO dellx4.cphwdc) ([10.200.210.81])
  by uls-op-cesaip02.wdc.com with ESMTP; 05 Sep 2022 05:23:44 -0700
From: Dennis Maisenbacher <Dennis.Maisenbacher@wdc.com>
To: linux-nvme@lists.infradead.org
Cc: Dennis Maisenbacher <dennis.maisenbacher@wdc.com>,
	Niklas Cassel <niklas.cassel@wdc.com>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] nvmet: fix mar and mor off-by-one errors
Date: Mon,  5 Sep 2022 14:21:16 +0200
Message-Id: <20220905122116.2678206-1-Dennis.Maisenbacher@wdc.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220905_052351_239587_63EC9645 
X-CRM114-Status: GOOD (  12.80  )
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

From: Dennis Maisenbacher <dennis.maisenbacher@wdc.com>

Maximum Active Resources (MAR) and Maximum Open Resources (MOR) are 0's
based vales where a value of 0xffffffff indicates that there is no limit.

Cast the unsigned int values that are returned by bdev_max_open_zones and
bdev_max_active_zones into u32 vales which need to be decremented as the
returned values of the block layer helpers are not 0's based.
The cast to u32 is necessary because the size of unsigned int is
architecture dependent and a 0 reported by the block layer helpers
indicates no limit, thus it needs to be converted to 0xffffffff which
happens by underflowing the u32.

Suggested-by: Niklas Cassel <niklas.cassel@wdc.com>
Signed-off-by: Dennis Maisenbacher <dennis.maisenbacher@wdc.com>
---
 drivers/nvme/target/zns.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/target/zns.c b/drivers/nvme/target/zns.c
index c7ef69f29fe4..606f21ee21bf 100644
--- a/drivers/nvme/target/zns.c
+++ b/drivers/nvme/target/zns.c
@@ -100,6 +100,7 @@ void nvmet_execute_identify_cns_cs_ns(struct nvmet_req *req)
 	struct nvme_id_ns_zns *id_zns;
 	u64 zsze;
 	u16 status;
+	u32 mar, mor;
 
 	if (le32_to_cpu(req->cmd->identify.nsid) == NVME_NSID_ALL) {
 		req->error_loc = offsetof(struct nvme_identify, nsid);
@@ -130,8 +131,10 @@ void nvmet_execute_identify_cns_cs_ns(struct nvmet_req *req)
 	zsze = (bdev_zone_sectors(req->ns->bdev) << 9) >>
 					req->ns->blksize_shift;
 	id_zns->lbafe[0].zsze = cpu_to_le64(zsze);
-	id_zns->mor = cpu_to_le32(bdev_max_open_zones(req->ns->bdev));
-	id_zns->mar = cpu_to_le32(bdev_max_active_zones(req->ns->bdev));
+	mor = bdev_max_open_zones(req->ns->bdev);
+	id_zns->mor = cpu_to_le32(--mor);
+	mar = bdev_max_active_zones(req->ns->bdev);
+	id_zns->mar = cpu_to_le32(--mar);
 
 done:
 	status = nvmet_copy_to_sgl(req, 0, id_zns, sizeof(*id_zns));
-- 
2.25.1


