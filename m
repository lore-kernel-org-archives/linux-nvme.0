Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CAA7C76196
	for <linux-nvme@archiver.kernel.org>; Wed, 15 Mar 2023 10:59:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7VNaEN0uTUov3LOeaoxmPbmPcwOGlRoH4e47YKCxdrU=; b=MT9rLfNiAQHIa2kTtgrPt+iFNA
	NEncjvdIk/yJKwW/DDe1E6CZV19SyDFh0B7nqpr+m18BM8ZO1bpj/m8WBhkqGTSUEoL+ACow3vHCx
	J9sq+G6h2Afwh/bJBl3oIIMofMQwGsdcz9Ymqjd5KXPeoofHox4xrW3whelOLRiY3GOXVIvn0eWGa
	X8Sz0eh2LuKZaZzKc58g5IxTAK4NikZlpqK/SND42XERn7HPNa0Ndx57xfgebeX+hp1F+NwzCcbkZ
	iZiJgCEaJcIN45SznLJmlz+q4PjiyX7YHWE7c0Zwvdk4bBZ85zBkJPSdJgN1bQWpT2+gueGqax+iy
	fOb+wa+A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pcOrM-00D8Be-1L;
	Wed, 15 Mar 2023 10:59:56 +0000
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pcOrH-00D87L-1r
	for linux-nvme@lists.infradead.org;
	Wed, 15 Mar 2023 10:59:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1678877991; x=1710413991;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=eB4J4LEmlW+ZCNAjNNTZn2Pg3gpp07L5+XKwVR/xTxY=;
  b=VvRxGEjoFHAEXx/p1rlRQc2i2n+y77mjWY3AOllduoGNN9Lof44AbBAA
   0eru33knbpJ96aUo8zMwi+iLeCtLCEWCbpiO5WkFZ+4PozhU/SGy73Fi+
   Hu7zlDZGH7wSJIS78BAHgSm4zLKLFk4QLRsPheT1s23/gmzYrJyDtBdXd
   GgLLz3/blZjrQDzcU+mYaRJ6BYeBw6xCHdjTbM3lgfoTBtmm3M0maUYZA
   uDjlFAv1zDKSLxCepTE+KHnlXyndTrUOHeacbJIUxRdiRJxtZc/PjHXDr
   ZtZY3/sgDwacbc41pVOodz3m2WXIi7ghq+3096pg0zRUV2+c3oR/hu26v
   Q==;
X-IronPort-AV: E=Sophos;i="5.98,262,1673884800"; 
   d="scan'208";a="223966394"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 15 Mar 2023 18:59:45 +0800
IronPort-SDR: rdnRReMXGQEH9P8zTWeLpZqhddJFcfFwTv23Gy5biNKBCiK3BAGuzFoFv1ij5/c+fz7JXCku1g
 jAMUtFkzmiBEO0ncn8u0oE5VR70FIxidXRmkOhrd9mRPJO6e2mo5/AHhZj2+DMyybDTjAOIMCP
 pYSxf79Sugq3jSE1Zl5d3V3PWcLxNACgfRcNOELlJIa0CB6fzvLxZgeeSGjMDpTBWg90cR6wUE
 JfvcCuQC7z2koy0sZVsilm31DcUSQc9PSHy/ZHb/mnM8a9KRFsP2dzonsD5nlPrcMjsN/FCDi5
 2Ow=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 15 Mar 2023 03:16:11 -0700
IronPort-SDR: tF07wSh28FOpBInkEt9YAU1epskNlO9wl9jyoDK4n9hq59yRd2S722aWiD2rf7zogvvE7mkT0O
 kpB9+HdvTIUO11C6yu8tfY+j2in4aSw/2BygGWGFnh0j2XErydDH5NGR/KLf5jhnc1OkUOlBfe
 E1poKux5kGVMl/khG5Nrvag0bn0rwmLvGDVBzPiNwcnNzMMptnFSY74JrP/iKSWxAPXlRKuE1c
 kVerWguxDov/XiWde+ZgnZFInBqpBD0pI+i7jixt7HQYLLNxYbhhPigkqrc/YqwDeC8F9N4INF
 WGU=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 15 Mar 2023 03:59:46 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
	by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4Pc6q50s3vz1RtVv
	for <linux-nvme@lists.infradead.org>; Wed, 15 Mar 2023 03:59:45 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
	reason="pass (just generated, assumed good)"
	header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
	opensource.wdc.com; h=content-transfer-encoding:mime-version
	:references:in-reply-to:x-mailer:message-id:date:subject:to
	:from; s=dkim; t=1678877984; x=1681469985; bh=eB4J4LEmlW+ZCNAjNN
	TZn2Pg3gpp07L5+XKwVR/xTxY=; b=qrzIJH+T+YE4rWxVyC9s+1HttQxiTi2e6n
	kUS9y5JK+UUovfCUGoVgYrIcp0oz0Dzii5c0+BgZL2mWbG8IcMTLDWo8mC+dtLGn
	MVhf9fL57T99MxLeQTgGmDGHKfP+wb1PCFd8AxTOiIytEaARX63tWgO72lZ7/osa
	TBPK0Mhd8P0GphMFhsVby2HKs0E5o93MiQgkOriwpipfABkJd5yDxycaE0Zd9K8Q
	YO7pMBPJ0q7Mk89kz01ndMTmlfFcF7GGnhAznE5+QM270G5cbdA29JvGs0tfcOVF
	vhz1UOO7s9qqbAzrssaU3Yv0oCrQ2LMuWfD3ENmR/qp5p32L0acA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
	by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 5dWaJ9Fzr4A2 for <linux-nvme@lists.infradead.org>;
	Wed, 15 Mar 2023 03:59:44 -0700 (PDT)
Received: from washi.fujisawa.hgst.com (washi.fujisawa.hgst.com [10.149.53.254])
	by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4Pc6q36k68z1RtVn;
	Wed, 15 Mar 2023 03:59:43 -0700 (PDT)
From: Damien Le Moal <damien.lemoal@opensource.wdc.com>
To: linux-nvme@lists.infradead.org,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>
Subject: [PATCH 3/5] nvmet: Fix Identify Active Namespace ID list handling
Date: Wed, 15 Mar 2023 19:59:37 +0900
Message-Id: <20230315105939.305825-4-damien.lemoal@opensource.wdc.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230315105939.305825-1-damien.lemoal@opensource.wdc.com>
References: <20230315105939.305825-1-damien.lemoal@opensource.wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230315_035952_098504_EDEA1EE3 
X-CRM114-Status: GOOD (  14.10  )
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

The identify command with cns set to NVME_ID_CNS_NS_ACTIVE_LIST does
not depend on the command set. The execution of this command should
thus not look at the csi field specified in the command. Simplify
nvmet_execute_identify() to directly call
nvmet_execute_identify_nslist() without the csi switch-case.

Fixes: ab5d0b38c047 ("nvmet: add Command Set Identifier support")
Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
---
 drivers/nvme/target/admin-cmd.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-=
cmd.c
index cd1b752c52cb..ed8faf7a3b2f 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -701,13 +701,8 @@ static void nvmet_execute_identify(struct nvmet_req =
*req)
 		}
 		break;
 	case NVME_ID_CNS_NS_ACTIVE_LIST:
-		switch (req->cmd->identify.csi) {
-		case NVME_CSI_NVM:
-			return nvmet_execute_identify_nslist(req);
-		default:
-			break;
-		}
-		break;
+		nvmet_execute_identify_nslist(req);
+		return;
 	case NVME_ID_CNS_NS_DESC_LIST:
 		nvmet_execute_identify_desclist(req);
 		return;
--=20
2.39.2


