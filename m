Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 496BDC74A5B
	for <linux-nvme@archiver.kernel.org>; Wed, 15 Mar 2023 10:59:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=iOZO5Qu8KBEM9Zhk3CO3PPT6phRgQpIB023QXNhmd3A=; b=0nfaxkXAWkmhRS+5ptSx8RW/A7
	XNskbnmwsFvy6s9N1IzCQ6j3jDcPy38W9RLoct1B34t8e1eCTkR468KYmX3lJlr8U7oeTz+h1vFet
	RfwNBI8TLduFGfCVbX9Wdxe4GW8BJugOU8VKrZxnv+dZd8pFFGCW4nx7uPkzQhuJDasmKVVlbpKG0
	R3QW8l+fqMmG2iEtsU2hSxX5QubhqKTLfq2Lw3nCUSVn8zF0ACZLpq6TIE4eKiqQOz3fU7nL5Dibf
	dNzvlhoCef4Do2osEBqbdbqaNYAiI3AZVSyf3kHhSTv/AnZhv2Cn7cp8nbNFWIe1bMByynjenFX89
	RJ6kRaBg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pcOrL-00D8BG-1m;
	Wed, 15 Mar 2023 10:59:55 +0000
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pcOrD-00D87Z-0X
	for linux-nvme@lists.infradead.org;
	Wed, 15 Mar 2023 10:59:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1678877986; x=1710413986;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=GtBm0m+Dob/oGuvMFXSUOcv0b4/rHsjr1t8rK3y7XZ8=;
  b=hpPgjrQ0QXyBMi3Xswat9VEwpgy+cvLe0ZPKo7wIKLIXTK07XeYHJPmw
   xNinE/JHqgyjNBnuJt2cBFhHJY3pLA/IiLftBjqylhyQOJUgIpN5D4XGy
   5dhR/56CbU/M8IJS2hlwIBxu87TiXVpnM6ULkt5grrUIwPaZNwjMpRN4u
   vCT6Ug3jcyShruvEuK9+jIEA3+Lv+Of7Pb/FVDl0tEuIdU6KqRIKproDq
   VK2xWKzfXBw+ZeQDAuIKxu+ZzJ+65xDVB9S0CYeOpCJjU39s68tUEqTSt
   imo8WxOyTOOccvTmUkOuWuBWnHdA6/4F4wC9d92G2ZcA9486ORYWk8ycf
   g==;
X-IronPort-AV: E=Sophos;i="5.98,262,1673884800"; 
   d="scan'208";a="223966391"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 15 Mar 2023 18:59:43 +0800
IronPort-SDR: QQQnqJS+fFvf9hq+rQker8xLJ105S8Q7iFlwc/+OTc/fyKdFMzK10g3QphD4kn9O7RZamdegGB
 oulAaynV8p4i25lYuDCbQOx6OO9UTPCWaOtHogvOOmecbR9ecnjEuC80wpFAJ5fzOw3J8TNbpU
 zZSjz8UzjS1ja6Z3ceVuFopLSEUaJxgJZp2ZjYz1OhQTHDBUX9somtDanF3QpeRzjluAOTKA3B
 qfAoovI5gQ9qEuYeBx84lcXW6VbeK88MMaUaw+VZA9XFiXRvmtZ44vvxQo+Ufrrj4NwGl4mub1
 p60=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 15 Mar 2023 03:16:10 -0700
IronPort-SDR: dnyXW5iqB1PcJqScKIERXrz7RDCsZQ7iQ0gpR2bRKFgYs5iUyRRgT9g6F1HfSEEEKDqlzO8PbU
 lLBCydUo0ZPtR9y8DCICPM9d/T6K3xQ0r+eQyR/Se765tfXT0L7XltcGkR6SI/49vNGDgYCYdy
 ktlD6Wr0AqEDjjJkc/yDRc/40jw5ts9oYUReezF9OrSJkjRIb9Ax8aoCBAn2dgUxiPL57kHDrJ
 VSRTu+duUg20oetvDq3t/4Xgh/geY1q/EBhoYc/vkJSDynRY6+IdzuR1oCVTl8+t9c43LsgKdd
 HoM=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 15 Mar 2023 03:59:44 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
	by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4Pc6q31MjLz1RtVv
	for <linux-nvme@lists.infradead.org>; Wed, 15 Mar 2023 03:59:43 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
	reason="pass (just generated, assumed good)"
	header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
	opensource.wdc.com; h=content-transfer-encoding:mime-version
	:references:in-reply-to:x-mailer:message-id:date:subject:to
	:from; s=dkim; t=1678877982; x=1681469983; bh=GtBm0m+Dob/oGuvMFX
	SUOcv0b4/rHsjr1t8rK3y7XZ8=; b=FeTZCCAZDEAZrgxbB1HtVUg2LIZ0pNsQnp
	TekgtHAMHb6TuBPWZjwJJ8tQwEkNs5LmLBMNQcKw8d1VvxZjdj01mJqroZTUsirC
	eOsdBQyNFth7GaniUdme8b90CWtHwAKX00eeOo0Kmv6cYb2M3xkFZHh7LNHUmBc2
	jTHzxFx94bjhbtwm18vsZk/VsN3WeGEonJYnpe7zUVFUkuk0ujyAncxAtAC+YcnV
	Nfc6nGLxTQwUmAMtqS9J39cheXN8auXw0KIfQCBVJWTeClkXEys+oKdbKKWmpLp1
	n0qMNxJdjrUbudT7gmBWDBvB5J1NSNIyiQALP+0UI/g1c9bFC2EA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
	by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 0oodepAHLznO for <linux-nvme@lists.infradead.org>;
	Wed, 15 Mar 2023 03:59:42 -0700 (PDT)
Received: from washi.fujisawa.hgst.com (washi.fujisawa.hgst.com [10.149.53.254])
	by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4Pc6q20DfFz1RtVn;
	Wed, 15 Mar 2023 03:59:41 -0700 (PDT)
From: Damien Le Moal <damien.lemoal@opensource.wdc.com>
To: linux-nvme@lists.infradead.org,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>
Subject: [PATCH 1/5] nvmet: Fix identify Namespace handling
Date: Wed, 15 Mar 2023 19:59:35 +0900
Message-Id: <20230315105939.305825-2-damien.lemoal@opensource.wdc.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230315105939.305825-1-damien.lemoal@opensource.wdc.com>
References: <20230315105939.305825-1-damien.lemoal@opensource.wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230315_035947_293469_45369C51 
X-CRM114-Status: GOOD (  15.86  )
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

The identify command with cns set to NVME_ID_CNS_NS does not directly
depend on the command set. The NVMe specifications is rather confusing
here as it appears that this command only applies to the NVM command
set. However, footnote 8 of Figure 273 in the NVMe 2.0 base
specifications clearly state that this command applies to NVM command
sets that support logical blocks, that is, NVM and ZNS. Both the NVM and
ZNS command set specifications also list this identify as mandatory.

The command handling should thus not look at the csi field since it is
defined as unused for this command. Given that we do not support the
KV command set, simply remove the csi switch-case for that command
handling and call directly nvmet_execute_identify_ns() in
nvmet_execute_identify().

Fixes: ab5d0b38c047 ("nvmet: add Command Set Identifier support")
Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
---
 drivers/nvme/target/admin-cmd.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-=
cmd.c
index ceffe2989a91..7fa60b1aee58 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -675,13 +675,8 @@ static void nvmet_execute_identify(struct nvmet_req =
*req)
=20
 	switch (req->cmd->identify.cns) {
 	case NVME_ID_CNS_NS:
-		switch (req->cmd->identify.csi) {
-		case NVME_CSI_NVM:
-			return nvmet_execute_identify_ns(req);
-		default:
-			break;
-		}
-		break;
+		nvmet_execute_identify_ns(req);
+		return;
 	case NVME_ID_CNS_CS_NS:
 		if (IS_ENABLED(CONFIG_BLK_DEV_ZONED)) {
 			switch (req->cmd->identify.csi) {
--=20
2.39.2


