Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70D21C6FA83
	for <linux-nvme@archiver.kernel.org>; Tue,  6 Sep 2022 07:40:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=3Avb4fjfxA+Kn3/2n+lkgs+qdnnJG3bNmFw7yPPMvT0=; b=HNvBlqDiCcOJnaKvyb5U5H1Chi
	ypFhcGUgPVIzM8mVkLhPT+fJQiexmu2lOZVDEJS3mR1r0FcIvQN1mIUge7iKYwrHyjemjgxbiv5M/
	YknhMrLNRY53z4mtqOslZgYHEeB5u69anexmCSlCvRF+TGFsAPh95X+YHLXhESnYi3sgThAVs/Roi
	q7cgeuB4e63QT9tWYtueSLcz2Xd4a+SE80qpgeLHcjH5SBty+frsABm0UPFZ4s2icgMx70nW067Eg
	3a/uP/PxcfRbkgpyU05Y0RVXhvQkJPNu+5tN0TLnZCXygbsm0GdpdCSS04GSRCFMYYBj12I+O1+xY
	gwdnnWXQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oVTBc-00Arxn-R6; Tue, 06 Sep 2022 07:39:56 +0000
Received: from esa6.hgst.iphmx.com ([216.71.154.45])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oVTBO-00Aruh-Lq
	for linux-nvme@lists.infradead.org; Tue, 06 Sep 2022 07:39:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1662449982; x=1693985982;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=qM4br7msd94mIardao6ZSlhF1fdL3fJcAnMyZj5ax9s=;
  b=Q8Sg+wsccNLXb9R/U1f8K2vH5hFDHP59Ncn5xYaQNk9tCItuUxbNtguN
   q7U4tdlZyJAEJpaiK8OmwFSJsZRWTBmDyZBciTjbkolff1JyEvQV/GSF3
   /BQmzV8Z74fZOUzRSx38MKfb5/06WpPLLeDi6wgsJQ8Hx0JVEOTyN0Do0
   E54ViQakq3eanVwRTYP9C8HUpHguemwFUGb7dDfFfHOLuHjczvHHKTnFI
   Hq/CBr9EPoosRZdlf5pb/hAx64SEl6SJd4NgsVCAQ7mi1qJ8p1v+ktX+C
   DPiVcRU41qskB94GhJTKfQAfJOa7BIqM/zMew72A5baW2gmb6N2NOcydr
   g==;
X-IronPort-AV: E=Sophos;i="5.93,293,1654531200"; 
   d="scan'208";a="211077471"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 06 Sep 2022 15:39:34 +0800
IronPort-SDR: 7W/Ea+XFSI8no9EQ2nwDAppOQ2I0h9gA+rt4P6k3N6LXb8Rlg+lHXngK+buqgsnoUU25yCuPMK
 aQ4jFC81QBQrVa+7eIzfQIXhDPk+I15I4vP10mftoOrgw20mpnpFUkgd+y2yYVTo1uh8g54dhQ
 hepo9xvCftYhgu3Kgxd9vw0fnWwIQLEsit6umuO4ftip8joYEm3BOogxvLFQano98g7Dhpkzhr
 T854dymGkOGDqcM5eYi3rPbbc4S63sPLLfAb4EN/WvY/01ioz+TYpmBRpVqhbv9ApeTTE0jXcE
 wJudv9BBboUnDzn7uxYeehO9
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 05 Sep 2022 23:59:57 -0700
IronPort-SDR: Wnq75+XBAxLJJUeIO6lT8YWaMU1mTQX900G6CNL3z/at4WdSp9iGMJCMebkQBJ3Jyc/4gcjGtP
 JcImDJohIs4FRCqkmi/KFoaxLAzUoHhhe+k0RXMzOKinqqfadTg2d9HzuVRhIs6Ck9naRKG8ru
 2SM/gn8BMnFfSoqyrBn/ZIsewKt+ggIKN11EG3lMkrh5u0eNOcPEKW8gJjysxGbUeBi//rr/vU
 dmlICTNkS0Kz0RUPGjnaIt90ICldpOu98nyIjOP6DYzrgMMHSbmLRABo1sQDPOc3kzJmTuk91J
 by8=
WDCIronportException: Internal
Received: from dellx5.wdc.com (HELO dellx4.cphwdc) ([10.200.210.81])
  by uls-op-cesaip02.wdc.com with ESMTP; 06 Sep 2022 00:39:32 -0700
From: Dennis Maisenbacher <Dennis.Maisenbacher@wdc.com>
To: linux-nvme@lists.infradead.org
Cc: Dennis Maisenbacher <dennis.maisenbacher@wdc.com>,
	Niklas Cassel <niklas.cassel@wdc.com>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Damien Le Moal <damien.lemoal@wdc.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] nvmet: fix mar and mor off-by-one errors
Date: Tue,  6 Sep 2022 09:39:28 +0200
Message-Id: <20220906073929.3292899-1-Dennis.Maisenbacher@wdc.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220906_003942_813522_F0FE9653 
X-CRM114-Status: GOOD (  14.60  )
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

Decrement the values that are returned by bdev_max_open_zones and
bdev_max_active_zones as the block layer helpers are not 0's based.
A 0 returned by the block layer helpers indicates no limit, thus convert
it to 0xffffffff (U32_MAX).

Fixes: aaf2e048af27 ("nvmet: add ZBD over ZNS backend support")
Suggested-by: Niklas Cassel <niklas.cassel@wdc.com>
Signed-off-by: Dennis Maisenbacher <dennis.maisenbacher@wdc.com>
---
Changes in v2:
    - Add explicit check if block layer helpers return a 0 and if so
    convert it to U32_MAX.
    - Add Fixes tag.

 drivers/nvme/target/zns.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/target/zns.c b/drivers/nvme/target/zns.c
index c7ef69f29fe4..eae81f939067 100644
--- a/drivers/nvme/target/zns.c
+++ b/drivers/nvme/target/zns.c
@@ -100,6 +100,7 @@ void nvmet_execute_identify_cns_cs_ns(struct nvmet_req *req)
 	struct nvme_id_ns_zns *id_zns;
 	u64 zsze;
 	u16 status;
+	u32 mar, mor;
 
 	if (le32_to_cpu(req->cmd->identify.nsid) == NVME_NSID_ALL) {
 		req->error_loc = offsetof(struct nvme_identify, nsid);
@@ -130,8 +131,20 @@ void nvmet_execute_identify_cns_cs_ns(struct nvmet_req *req)
 	zsze = (bdev_zone_sectors(req->ns->bdev) << 9) >>
 					req->ns->blksize_shift;
 	id_zns->lbafe[0].zsze = cpu_to_le64(zsze);
-	id_zns->mor = cpu_to_le32(bdev_max_open_zones(req->ns->bdev));
-	id_zns->mar = cpu_to_le32(bdev_max_active_zones(req->ns->bdev));
+
+	mor = bdev_max_open_zones(req->ns->bdev);
+	if (!mor)
+		mor = U32_MAX;
+	else
+		--mor;
+	id_zns->mor = cpu_to_le32(mor);
+
+	mar = bdev_max_active_zones(req->ns->bdev);
+	if (!mar)
+		mar = U32_MAX;
+	else
+		--mar;
+	id_zns->mar = cpu_to_le32(mar);
 
 done:
 	status = nvmet_copy_to_sgl(req, 0, id_zns, sizeof(*id_zns));
-- 
2.25.1


