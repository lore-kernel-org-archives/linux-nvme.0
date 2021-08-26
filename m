Return-Path: <SRS0=DYpX=NR=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78518C4320A
	for <linux-nvme@archiver.kernel.org>; Thu, 26 Aug 2021 21:17:02 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2D6C5604D7
	for <linux-nvme@archiver.kernel.org>; Thu, 26 Aug 2021 21:17:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 2D6C5604D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:References:MIME-Version:In-Reply-To:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=PD+DVbNHJkWDfZSOdy4+E/q8eE+I3v/jOLbmPbVkN0s=; b=CB/W4XEFtLHMOl
	ylT/+EUEfX5qR6sg63ID2/A+awVxYjYqp1uKafbVJ4XKoT1qnVVqKpZlDRVwPNDeH3RaLR4f1323I
	JAA35PUfzbyoI3rE7fNydN0BZwz/KdrOCQzQYOrYh1GqXkqSV1rxwhy5XxVv/QQFkJba8BIeP3GzL
	Y/4LuskCMm1G7atxujSNOy6n+USu3kLESKXjpGPR7ou4uFAKQ/11wtTJHJBP3PdFTtKxb//P7C40G
	wUzI9d1efGdybwBlTBQB3SV109AFZ2by2oSHCJYbklZtJteSY73YdtmppesnUKV2yLZ/4Isy/SZpa
	bcB01a2IYUaDAl4MModw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mJMjz-00AujD-2i; Thu, 26 Aug 2021 21:16:51 +0000
Received: from mailout2.w2.samsung.com ([211.189.100.12])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mJMj3-00AufN-PG
 for linux-nvme@lists.infradead.org; Thu, 26 Aug 2021 21:16:01 +0000
Received: from uscas1p2.samsung.com (unknown [182.198.245.207])
 by mailout2.w2.samsung.com (KnoxPortal) with ESMTP id
 20210826211547usoutp026c3122b6809d5753496c8dc1f33cd994~e98aKxmZG2107221072usoutp02G;
 Thu, 26 Aug 2021 21:15:47 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w2.samsung.com
 20210826211547usoutp026c3122b6809d5753496c8dc1f33cd994~e98aKxmZG2107221072usoutp02G
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1630012547;
 bh=8z0mOKVSmIjZ2gAb2k1jTA98o9P4G/zxpsmQ2t4GJ7o=;
 h=From:To:CC:Subject:Date:In-Reply-To:References:From;
 b=eLNjYRBAS43Cd3UmPc0Y4xbP9Y5Gj3kSMlsQlKV76PxaRXvfpF9XcWZwKfjCATVL2
 a9i0YYAl9BHaXQVk9tOW3HtyJHDVdCV3ip/iv7BkcDgG/LOiLAcF3vZmMASxJlOTt8
 JLl5Cxya7eE0pXZdB0YGA0VhIay98n3zhpTn6520=
Received: from ussmges3new.samsung.com (u112.gpu85.samsung.co.kr
 [203.254.195.112]) by uscas1p1.samsung.com (KnoxPortal) with ESMTP id
 20210826211547uscas1p14750726aad7c8df2f27f4dc01827b665~e98Z8FfcX0254002540uscas1p1N;
 Thu, 26 Aug 2021 21:15:47 +0000 (GMT)
Received: from uscas1p2.samsung.com ( [182.198.245.207]) by
 ussmges3new.samsung.com (USCPEMTA) with SMTP id 2A.7A.19318.28408216; Thu,
 26 Aug 2021 17:15:46 -0400 (EDT)
Received: from ussmgxs1new.samsung.com (u89.gpu85.samsung.co.kr
 [203.254.195.89]) by uscas1p1.samsung.com (KnoxPortal) with ESMTP id
 20210826211546uscas1p1e181ca820e506c7c195b933168301dd0~e98ZpQRWB3073030730uscas1p1a;
 Thu, 26 Aug 2021 21:15:46 +0000 (GMT)
X-AuditID: cbfec370-c37ff70000014b76-72-612804825d42
Received: from SSI-EX1.ssi.samsung.com ( [105.128.2.146]) by
 ussmgxs1new.samsung.com (USCPEXMTA) with SMTP id E3.DD.47905.28408216; Thu,
 26 Aug 2021 17:15:46 -0400 (EDT)
Received: from SSI-EX1.ssi.samsung.com (105.128.2.226) by
 SSI-EX1.ssi.samsung.com (105.128.2.226) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.2242.4; Thu, 26 Aug 2021 14:15:45 -0700
Received: from SSI-EX1.ssi.samsung.com ([fe80::4df0:41c8:8343:b407]) by
 SSI-EX1.ssi.samsung.com ([fe80::4df0:41c8:8343:b407%7]) with mapi id
 15.01.2242.008; Thu, 26 Aug 2021 14:15:45 -0700
From: Adam Manzanares <a.manzanares@samsung.com>
To: "kbusch@kernel.org" <kbusch@kernel.org>, "axboe@fb.com" <axboe@fb.com>,
 "hch@lst.de" <hch@lst.de>, "sagi@grimberg.me" <sagi@grimberg.me>,
 "chaitanya.kulkarni@wdc.com" <chaitanya.kulkarni@wdc.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, open list
 <linux-kernel@vger.kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Adam
 Manzanares" <a.manzanares@samsung.com>
Subject: [PATCH 2/2] nvmet: use passthru cntrl in nvmet_init_cap
Thread-Topic: [PATCH 2/2] nvmet: use passthru cntrl in nvmet_init_cap
Thread-Index: AQHXmr+I7P+Y0y9860Sip666Pz8m2g==
Date: Thu, 26 Aug 2021 21:15:45 +0000
Message-ID: <20210826211522.308649-3-a.manzanares@samsung.com>
In-Reply-To: <20210826211522.308649-1-a.manzanares@samsung.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [105.128.2.176]
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Brightmail-Tracker: H4sIAAAAAAAAA02Se1BMURzH59x7272lbW5J/ZQJGcaglRQ7QmVqbMNgRsZUyE13ltHL3s17
 RlJSSwqlrsdumPSSNkWyWJsekseQ2AyNFJKJtcOa9GC720z/fX7n+z3nfM7MIXGnMhs3cke8
 gpHH07GeAjviZuOvZ14pxGza+8QHiWRE2yiQcG/7CElJWQMmOaVvR5KXdecFElVRj1BS0fed
 CBRKc470C6XP3msIaVVphkB648oh6R1DskBqqvKQpuuU2DphhN3SGCZ2x25GPn/5VrvthYdv
 oMRPDnt/5bTjyeiWfSayJYHyhaaPnTYWdqJKEDSfPpiJ7P5zGgblDanYWGlYVYfxwTUEbUNH
 ED8YERgMD4X8oEOgqbg1ukVAecPfJg1uCZwpLQZZj3+MBji1C+5eMxGZiCQnUoHwp4ayLDtT
 IaC7VIt4FkNqRssoE9RM+Kox4xYWUcuhoevpqKstFQC9XA9hYUS5gLml3Hq8K3R0q6zajnDp
 nBbn2QWG6z4IeJ4OneZeId8Xw5vcMwKe50JRYZ/1Lkd4VNBN8P3J8KD4DWF5C1BtJBTWXLce
 FAznvnyyltzh1etcnC+1I7jadd6GHzoRpB0fQnzLHwoHr1tVHWBooAtloxncOHNunBU3zoob
 Z6VGRClyTWLZOBnDLoxn9ohZOo5NipeJtyXEVaH//+nxcH1iLeroMIr1CCORHgGJezqL1OZZ
 tJMoht63n5EnRMmTYhlWj9xJwtNVdCE8J8qJktEKZifDJDLysRQjbd2SsWj/LxvQ7Fr1NwM6
 rPAIJDZ9bXMMUQwHmZSrjOn5wQt1JdqIsMioz1sigHuUGvC331TthuU99Tn6XKdjuTS/taX7
 lnlVmzen+qwJo7dOrRG1FYRcXGMKYlVP9JUHw5akx4aqsbz7DSsW1GfezE73vbBxUrLsRdGK
 y1lKxbSYWhtjR0q2u7JZNKHY3JNQPtS3f8NP+1X5fu/zGyvCq1+8th/xX5nbirU0Ry4+sNlb
 7QIpDsQB6dFWYb1CM6U+u1IrC/1uIMQZWT4ffxes7r/3JCEyZ+a86JPvogcHzk7vLvP10hfX
 +K0fXIpp36lSuPDGnkUxI8ZeZWJrtFfw7UrvY54Eu51eMAeXs/Q/WybVV74DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrNIsWRmVeSWpSXmKPExsWS2cA0SbeJRSPR4OYZZYv/e46xWcy6/ZrF
 YuXqo0wWkw5dY7S4vGsOm8X8ZU/ZLda9fs/iwO4xsfkdu8f5extZPDat6mTz2Lyk3mP3zQY2
 j8+b5DzaD3QzBbBHcdmkpOZklqUW6dslcGUsbNzMWPCMr+LrxGvMDYzbeboYOTkkBEwk/s3f
 xdTFyMUhJLCaUWLJlxMsEM5HRokpaw4zQzgHGCVu39/CCtLCJmAg8fv4RrCEiMAeJom+0x+Y
 QBLMAoUSe9d+Bmrn4BAWcJD4sVUAJCwi4CpxYNEORghbT6Kl8xSYzSKgKvFq43dmEJtXwE7i
 6KNzYPOFgOzOBbPB4pwC9hIvZz1lAbEZBcQkvp9aA7VKXOLWk/lMEC8ISCzZc54ZwhaVePn4
 HyuErShx//tLdoh6PYkbU6ewQdjaEssWvobaKyhxcuYTFoh6SYmDK26wTGAUn4VkxSwk7bOQ
 tM9C0r6AkWUVo3hpcXFuekWxYV5quV5xYm5xaV66XnJ+7iZGYPye/nc4cgfj0Vsf9Q4xMnEw
 HmKU4GBWEuFd8F0tUYg3JbGyKrUoP76oNCe1+BCjNAeLkjivkOvEeCGB9MSS1OzU1ILUIpgs
 EwenVAPTifUN8qvC3KozPr+4+n9q0pSsznP2t47qCv5f0Pky9FP98YVajHfS2hkX/sxVNJNI
 WdRzb7WkL9uEb/PeaFQ/3ZsU/MCepcxS+Ez072s3U67aR/LmagexvttTz/Zg30aDdoNTMf8L
 u0w+TDcJdjFz0rL7ef/ip+p4E7e7D+zfZohmM8+K9zH5X9K7Ye2B95MOnkldzyRxyazIyDLx
 cOa0R5/Frn3ODt854UyuU5CebtyeBQsyKhVSX5cHcgkcsPsbFX1bZ2ltdLWoSOaDwGyDN0HX
 8lZtu9cfqr/4wtZL13atVj9oMrPl9GIVv/vrF6Scc7izhbX23YMLFZUB+aoNX75+XPRzsUNa
 c+/RFqM2JZbijERDLeai4kQAvcdRRk4DAAA=
X-CMS-MailID: 20210826211546uscas1p1e181ca820e506c7c195b933168301dd0
CMS-TYPE: 301P
X-CMS-RootMailID: 20210826211546uscas1p1e181ca820e506c7c195b933168301dd0
References: <20210826211522.308649-1-a.manzanares@samsung.com>
 <CGME20210826211546uscas1p1e181ca820e506c7c195b933168301dd0@uscas1p1.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210826_141554_051225_54220789 
X-CRM114-Status: GOOD (  13.21  )
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

For a passthru controller make cap initialization dependent on the cap of
the passthru controller.

Fixes: ab5d0b38c047 (nvmet: add Command Set Identifier support)
Signed-off-by: Adam Manzanares <a.manzanares@samsung.com>
---
 drivers/nvme/target/core.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index 66d05eecc2a9..220ba5ed5f3a 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -9,6 +9,7 @@
 #include <linux/rculist.h>
 #include <linux/pci-p2pdma.h>
 #include <linux/scatterlist.h>
+#include "../host/nvme.h"
 
 #define CREATE_TRACE_POINTS
 #include "trace.h"
@@ -1198,10 +1199,13 @@ void nvmet_update_cc(struct nvmet_ctrl *ctrl, u32 new)
 
 static void nvmet_init_cap(struct nvmet_ctrl *ctrl)
 {
+	struct nvme_ctrl *ptctrl = nvmet_passthru_ctrl(ctrl->subsys);
+
 	/* command sets supported: NVMe command set: */
 	ctrl->cap = (1ULL << 37);
 	/* Controller supports one or more I/O Command Sets */
-	ctrl->cap |= (1ULL << 43);
+	if ((ptctrl && nvme_multi_css(ptctrl)) || !ptctrl)
+		ctrl->cap |= (1ULL << 43);
 	/* CC.EN timeout in 500msec units: */
 	ctrl->cap |= (15ULL << 24);
 	/* maximum queue entries supported: */
@@ -1363,8 +1367,6 @@ u16 nvmet_alloc_ctrl(const char *subsysnqn, const char *hostnqn,
 		goto out_put_subsystem;
 	mutex_init(&ctrl->lock);
 
-	nvmet_init_cap(ctrl);
-
 	ctrl->port = req->port;
 
 	INIT_WORK(&ctrl->async_event_work, nvmet_async_event_work);
@@ -1378,6 +1380,7 @@ u16 nvmet_alloc_ctrl(const char *subsysnqn, const char *hostnqn,
 
 	kref_init(&ctrl->ref);
 	ctrl->subsys = subsys;
+	nvmet_init_cap(ctrl);
 	WRITE_ONCE(ctrl->aen_enabled, NVMET_AEN_CFG_OPTIONAL);
 
 	ctrl->changed_ns_list = kmalloc_array(NVME_MAX_CHANGED_NAMESPACES,
-- 
2.25.1

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
