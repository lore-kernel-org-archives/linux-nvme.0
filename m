Return-Path: <SRS0=jca5=JN=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00E1AC433B4
	for <linux-nvme@archiver.kernel.org>; Fri, 16 Apr 2021 03:06:06 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D53C6117A
	for <linux-nvme@archiver.kernel.org>; Fri, 16 Apr 2021 03:06:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D53C6117A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=kl18N5CroCUsVP9vRpXMP9Yn0KdM71V0XZ+C+5E5Ta0=; b=J1zKJFq3+XAFuQ++M7LATZhPw
	Orr2MgvfDg7d22V/r1Tmd8vvI9MeFgOgb+YaNOnvIC4VLV/zc+vxlGF7tPnAKv77jjdJB8jrvlmrU
	RjI0EaN9COXssr/SKqDivoxpZWu1EIf84XWjO7rX9yHrX3VYtzZrcTuvpTySuCuhNNpifAKOpqeaK
	rF4+w+h1yAGVLnQ8VB6f0vnZjXfOknhE/PPpn3+jviM3DVRCts20KZ4k0Bo2jSs27CN7KAvxCusZi
	mALkptsBTxNEnCBYcnyXGGrMXUu4hb9go1dM6yvudjfKt1iM4UkpvzT2JX7Z03twaTZYfikoHwaSB
	x3BxikSLA==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lXEnu-000aEe-IW; Fri, 16 Apr 2021 03:05:58 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lXEnf-000aCW-Hr
 for linux-nvme@desiato.infradead.org; Fri, 16 Apr 2021 03:05:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
 :Reply-To:Content-Type:Content-ID:Content-Description;
 bh=lDZlD0lJ1k/gqmILyCwKAtlKENC0RJifu3ZViKiFd9o=; b=s0zL8ooiGXWmzlV6w3TCFPuyXB
 eMpWu8TZ7W5ZUjP1fiJxA2Smmhe2T65DlyAZ7AlQc4W6r7HPaB7AkJMvSYvG0SwWg8TQ5Xt0W4N/3
 lvtUSwcuFBNedCtYedrvT6l5u6ireA18Ba7YpMkovJhARD/1RFOn3InJwV8IakqF6gyPnHdaAV4we
 m2oSunBFg2jFQ2qPfHWceG71N8CTPdYS6Lin6TXd6zGq5RdeWxIxu78zNjNb/zX9thOM61SXkA4+9
 +T5rsPt5lB03hbj4OPRdln25zlRNV9xxU1VK9GN8JxgercV4eSofVwaa1AvQpGgXRNv4gdDFMCaTF
 Id8hap7w==;
Received: from esa1.hgst.iphmx.com ([68.232.141.245])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lXEnd-0092yZ-7E
 for linux-nvme@lists.infradead.org; Fri, 16 Apr 2021 03:05:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1618542340; x=1650078340;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=dQ6+wwXkURXembXlQMNkynRjOBYDsHmNyV1LL8+afz8=;
 b=blJrdmzkvlopGoIZQsszKqRP1Tdx4+Lpxc9orHVkERgadxHdWNeUU/xP
 jUiG+UJjDSBeGW2qL+XZxDApT/FqgWWNmdhGhOn71yvdWpSQwaF62DCvZ
 y7yfQpJ2bRtw3m3Yt4Ck7KOAdfu/gCtWOUd5dnKugs/y4psC54ESugMSD
 NakKB/yoRG0H/mO2A0H/eNgvOdChucNFyRp8/H/Nv2l3lbp9ptZKFRjpQ
 L6uOz3yzNvbYjXri8FDn4nwXi0z9wd3XDAIKJasru8JogbMVzo4JysGUR
 Go0a9T18WOswHSMeSSQCACjBYRXL9ckNkZ0PIXX9UDlFH+XjnNPRFCRam w==;
IronPort-SDR: 68T7Sx5rGBHdAGT06/BHufCmYlhyXM3htp9AkbTAwFxx62Aw1xkthsGMu18Ctx2vDlrdi4XIXu
 oUWs9W8ag5wzhNdYB2mA0fgL2hsw/n25/u7Jo6RTVo/qC5OO/TYNNnNnP8Brnkr3bskZOmJirb
 JYChk/l7FGUY7a9Igvht45aSgZfLjVThg9WslNkDiryd+/UyAg4ByECdJANMnvPsARydcBcQ2R
 iAoRuCKZm1qd9vkQNjjO5eBhdZjM6hSAqgrfdDI0lz4SVW7y9FuiGsGpLUjNamr6qDETLgCuIK
 wD4=
X-IronPort-AV: E=Sophos;i="5.82,226,1613404800"; d="scan'208";a="275938869"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 16 Apr 2021 11:05:40 +0800
IronPort-SDR: ADpCbzEmEgp4nzIlICLxU9JUFNPO8bN3rt7R5DF7KILHbDs8B4od95xnEwMc5H6Gjm747IbVJV
 IGTkI1vKRFafLnMkB13c4hrzxCslly1oObc6tq+x7EI0eDj2caL9lPTn3FK+EgEjEKwpYoZ3Dq
 PvEMmtPitASKGjDn89MYFJNjWHcukleoQxWTUWZy2Or2flMjqGwLLnpZiMxyeOTRI46coUzr91
 +Zgi5w/XZKsuCzmZ0Ga2OfHpEdItqtfa/Ej52eTGoFC7wbzDEJ9uLbiDo+hz9PicCHPE8fZBIO
 Z9PWLTCHE8WaDk4NabKHR47O
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Apr 2021 19:46:32 -0700
IronPort-SDR: XeFcQprEuAFYDJO6DpiQxcsC7N+LCT2SR+Mu5LEf4Xaflth/DDQwNi/0LW5UM7TnbJeuRqTSwF
 A2caLaeVJPDIYpfpbqPdd+zoeTtgjcmwbGRtXPz+zFA/vSzLCL5oDZB1U1YXfv4rUoljrjQEml
 /GhFt+gXWizqvsuzIuD6xmX3mwwUI6vOaANrC/xXYqaNcz/AyDVJCnaZPyBki04K2v/eRMhvDK
 QTOVUkM8S+NS7fijSsafqxW0t+EdNdG09b4gvBZhddV08G/EQ+6pPc6oENmirSES3hRM8Xy5PG
 Eqo=
WDCIronportException: Internal
Received: from washi.fujisawa.hgst.com ([10.149.53.254])
 by uls-op-cesaip02.wdc.com with ESMTP; 15 Apr 2021 20:05:37 -0700
From: Damien Le Moal <damien.lemoal@wdc.com>
To: dm-devel@redhat.com, Mike Snitzer <snitzer@redhat.com>,
 linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
 linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
 linux-scsi@vger.kernel.org,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org,
 David Sterba <dsterba@suse.com>, Josef Bacik <josef@toxicpanda.com>
Cc: Johannes Thumshirn <johannes.thumshirn@wdc.com>,
 Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH 3/4] btrfs: zoned: fail mount if the device does not support
 zone append
Date: Fri, 16 Apr 2021 12:05:27 +0900
Message-Id: <20210416030528.757513-4-damien.lemoal@wdc.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210416030528.757513-1-damien.lemoal@wdc.com>
References: <20210416030528.757513-1-damien.lemoal@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210415_200541_287794_E236B3DC 
X-CRM114-Status: GOOD (  11.98  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

From: Johannes Thumshirn <johannes.thumshirn@wdc.com>

For zoned btrfs, zone append is mandatory to write to a sequential write
only zone, otherwise parallel writes to the same zone could result in
unaligned write errors.

If a zoned block device does not support zone append (e.g. a dm-crypt
zoned device using a non-NULL IV cypher), fail to mount.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
---
 fs/btrfs/zoned.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index eeb3ebe11d7a..70b23a0d03b1 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -342,6 +342,13 @@ int btrfs_get_dev_zone_info(struct btrfs_device *device)
 	if (!IS_ALIGNED(nr_sectors, zone_sectors))
 		zone_info->nr_zones++;
 
+	if (bdev_is_zoned(bdev) && zone_info->max_zone_append_size == 0) {
+		btrfs_err(fs_info, "zoned: device %pg does not support zone append",
+			  bdev);
+		ret = -EINVAL;
+		goto out;
+	}
+
 	zone_info->seq_zones = bitmap_zalloc(zone_info->nr_zones, GFP_KERNEL);
 	if (!zone_info->seq_zones) {
 		ret = -ENOMEM;
-- 
2.30.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
