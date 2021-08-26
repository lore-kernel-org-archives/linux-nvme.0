Return-Path: <SRS0=DYpX=NR=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68842C432BE
	for <linux-nvme@archiver.kernel.org>; Thu, 26 Aug 2021 21:16:53 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D9B1D60234
	for <linux-nvme@archiver.kernel.org>; Thu, 26 Aug 2021 21:16:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org D9B1D60234
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:References:MIME-Version:In-Reply-To:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=1RRz2Fu7X3Z4yAMg6nv8a9w6zlic3ZHshsoO2I8trr0=; b=woQ1GU1dBac5qV
	SsmXmk1V2Cn0Y3bgM2Y8E6Y7/Z0CBtz81TG9FIu8p4n5eexpixdJ5PhSHF01ZrUhK5gtzPG4LfDP/
	o/1a4nD7EDgwkRpVSfx5cY9/Lm2z/EiLFWYv1W3x/iajiSf3BDR209mHjuAxTPKmnW8YefHQFazsY
	2+XbnnCvWvCrCAj5miotV8zGa55Ka1cmZ3u7Z+L7+OBYa1j4xJ7ame1+/Bwf6Gie5uEhVpYEXYJHn
	tmKHm/Q9s3G7s0Gu2hSwVu/UCCaBgBhZh/omTVgyf+HvYYlc1B5ABadARbbwpMkTnnQ2YVGEDTy1+
	1eH/9XadITMRb1DPbmOg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mJMjo-00AuiX-Va; Thu, 26 Aug 2021 21:16:41 +0000
Received: from mailout1.w2.samsung.com ([211.189.100.11])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mJMj3-00AufO-PF
 for linux-nvme@lists.infradead.org; Thu, 26 Aug 2021 21:15:57 +0000
Received: from uscas1p1.samsung.com (unknown [182.198.245.206])
 by mailout1.w2.samsung.com (KnoxPortal) with ESMTP id
 20210826211547usoutp0134779bf08945a74b891f7df1a88fd241~e98aB1cvJ2507725077usoutp01H;
 Thu, 26 Aug 2021 21:15:47 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w2.samsung.com
 20210826211547usoutp0134779bf08945a74b891f7df1a88fd241~e98aB1cvJ2507725077usoutp01H
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1630012547;
 bh=sm2LA01+hgkQNLmHJig+tdHL7U+svZjhE9tJ7kweohE=;
 h=From:To:CC:Subject:Date:In-Reply-To:References:From;
 b=pYe6SpF+BDoqiktqDMxKr4koDalnsTIplONS1Pcr8nRvmJJTBDGfYldXDYOCIZcL+
 WzISFA8ZdhZ8lfKNOAsQbdBv5RkdC33rhUlhiqit0le+aNfUlvEXAPk/Hm9fywvArM
 V4gsGh+XJZekW9anfpmMX/FgH9z8huediTPiPxZs=
Received: from ussmges3new.samsung.com (u112.gpu85.samsung.co.kr
 [203.254.195.112]) by uscas1p1.samsung.com (KnoxPortal) with ESMTP id
 20210826211546uscas1p1adfd4780a4b4715cbeeed510a8438cbe~e98Z2JSX70253102531uscas1p1L;
 Thu, 26 Aug 2021 21:15:46 +0000 (GMT)
Received: from uscas1p1.samsung.com ( [182.198.245.206]) by
 ussmges3new.samsung.com (USCPEMTA) with SMTP id A9.7A.19318.28408216; Thu,
 26 Aug 2021 17:15:46 -0400 (EDT)
Received: from ussmgxs1new.samsung.com (u89.gpu85.samsung.co.kr
 [203.254.195.89]) by uscas1p2.samsung.com (KnoxPortal) with ESMTP id
 20210826211546uscas1p2488ecd33269aa6f71f1fe8271fad3cec~e98ZmwPkV1097710977uscas1p23;
 Thu, 26 Aug 2021 21:15:46 +0000 (GMT)
X-AuditID: cbfec370-c4fff70000014b76-71-612804820ba0
Received: from SSI-EX2.ssi.samsung.com ( [105.128.2.145]) by
 ussmgxs1new.samsung.com (USCPEXMTA) with SMTP id 63.DD.47905.28408216; Thu,
 26 Aug 2021 17:15:46 -0400 (EDT)
Received: from SSI-EX1.ssi.samsung.com (105.128.2.226) by
 SSI-EX2.ssi.samsung.com (105.128.2.227) with Microsoft SMTP Server
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
Subject: [PATCH 1/2] nvme: move nvme_multi_css into nvme.h
Thread-Topic: [PATCH 1/2] nvme: move nvme_multi_css into nvme.h
Thread-Index: AQHXmr+I0SsiXld9u0SAu8oWTXUGdg==
Date: Thu, 26 Aug 2021 21:15:45 +0000
Message-ID: <20210826211522.308649-2-a.manzanares@samsung.com>
In-Reply-To: <20210826211522.308649-1-a.manzanares@samsung.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [105.128.2.176]
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrNKsWRmVeSWpSXmKPExsWy7djXc7pNLBqJBl/3Gln833OMzWLW7dcs
 FitXH2WymHToGqPF5V1z2CzmL3vKbrHu9XsWB3aPic3v2D3O39vI4rFpVSebx+Yl9R67bzaw
 eXzeJOfRfqCbKYA9issmJTUnsyy1SN8ugSvj8OdPTAW/uSomrpzA3sC4nrOLkZNDQsBE4vKj
 L0wgtpDASkaJU0fDuxi5gOxWJomeWR3MMEUd5z4wQSTWMkpMffseyvnIKPH+9VoWCOcAo8TG
 ddvBZrEJGEj8Pr6RGSQhIrCHSaLv9AewBLNAocTetZ9ZQGxhASuJGX//s4PYIgL2EgfWHGXt
 YuQAsvUkXjbUgYRZBFQlXm38DnYGr4CdxIMn+8DKOYHKX856CjaGUUBM4vupNVDjxSVuPZnP
 BHG2oMSi2XugXhCT+LfrIRuErShx//tLdoh6PYkbU6ewQdjaEssWvobaJShxcuYTFoh6SYmD
 K26APSkhcIVD4uYjmAUuEkeW9bFC2NISV69PZYYousYosfzRHFYI5z6jRGvPX0aIKmuJhX/W
 Q53KJ/H31yPGCYzKs5BcPgvJVbOQXDULyVULGFlWMYqXFhfnpqcWG+ellusVJ+YWl+al6yXn
 525iBKan0/8OF+xgvHXro94hRiYOxkOMEhzMSiK8C76rJQrxpiRWVqUW5ccXleakFh9ilOZg
 URLnnRs5MV5IID2xJDU7NbUgtQgmy8TBKdXA1HFj9/vU2f/enPabvXrOGrdisYldDftlVMUn
 Hbv5Osoh5dJKoTdv53/sSZwbUT1lZX6lkum0C7P8PZ9/2TOp+td5RunfiReSJ77dr7jHZd7M
 yXG/5FeeU9c+uvdE2gNVuWDOnzO4e1N/RE21nRChaXTl0cU6a+cTu1etWfOc42KundLyKwLb
 wifa7vDfsO4Yk8OOu7Ey1c+/VqQdM7JZMavrbdfFZdeEH/pfWn1gZbC+LZOYJW/g+lvbio4V
 GLaLcGwOfOz0oGoyq1/JgyfWF3dyvZ7dxvP86P8lO5J7m23ddWZ6G/edVrRZGcaTxPBY/nPj
 h3vxWQZhwTd6ZbM1sow8NBJXTa4Xd3qzaeatJSVKLMUZiYZazEXFiQBlfqBUvgMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrNIsWRmVeSWpSXmKPExsWS2cA0UbeJRSPRYMNfSYv/e46xWcy6/ZrF
 YuXqo0wWkw5dY7S4vGsOm8X8ZU/ZLda9fs/iwO4xsfkdu8f5extZPDat6mTz2Lyk3mP3zQY2
 j8+b5DzaD3QzBbBHcdmkpOZklqUW6dslcGUc/vyJqeA3V8XElRPYGxjXc3YxcnJICJhIdJz7
 wNTFyMUhJLCaUWLt7IusEM5HRon/kx6xQDgHGCVu39/CCtLCJmAg8fv4RmaQhIjAHiaJvtMg
 /ZwczAKFEnvXfmYBsYUFrCRm/P3PDmKLCNhLHFhzFKiZA8jWk3jZUAcSZhFQlXi18TsziM0r
 YCfx4Mk+sHIhILtzwWywOCdQ68tZT8FGMgqISXw/tQZqlbjErSfzmSBeEJBYsuc8M4QtKvHy
 8T9WCFtR4v73l+wQ9XoSN6ZOYYOwtSWWLXwNtVdQ4uTMJywQ9ZISB1fcYJnAKD4LyYpZSNpn
 IWmfhaR9ASPLKkbx0uLi3PSKYsO81HK94sTc4tK8dL3k/NxNjMD4Pf3vcOQOxqO3PuodYmTi
 YDzEKMHBrCTCu+C7WqIQb0piZVVqUX58UWlOavEhRmkOFiVxXiHXifFCAumJJanZqakFqUUw
 WSYOTqkGJo8j7/xtYr/UVzEFnt/Q8CnEhrf2r+m1aVzGv46+cxcM2CEwwXLTVTMGkc6fl53b
 9XL+ra1Nlf3TWuRrmhGq9CvX6FTY7HYlx5WtCy2ep/H9elIWl805ddpk+VKrzTf82xXvvt7q
 35N3OaN7n2a15p613K9s36qeuDaX40XtHrb2c/uTzl8Vue9jv8Dc5MiZhhXCTVO3XhMyCfHg
 vxLTW+iwMm2lcqCnhG3XrTAZz43y91smLRRaIyUtqG9z4exkl6S/C/PuXNZ/faHUqSg2+bv6
 KaM1H8wfxx88Up3nWvNRUaVP3PDpyz89J438TDRKP7Oy9Gv7iQTy3X7lsmlq6Nc69ae3nlfK
 rT2p28umxFKckWioxVxUnAgAnFLDMk4DAAA=
X-CMS-MailID: 20210826211546uscas1p2488ecd33269aa6f71f1fe8271fad3cec
CMS-TYPE: 301P
X-CMS-RootMailID: 20210826211546uscas1p2488ecd33269aa6f71f1fe8271fad3cec
References: <20210826211522.308649-1-a.manzanares@samsung.com>
 <CGME20210826211546uscas1p2488ecd33269aa6f71f1fe8271fad3cec@uscas1p2.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210826_141554_051234_F661C5EB 
X-CRM114-Status: GOOD (  12.78  )
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

Preparatory patch in order to reuse nvme_multi_css in the nvme target code

Signed-off-by: Adam Manzanares <a.manzanares@samsung.com>
---
 drivers/nvme/host/core.c | 5 -----
 drivers/nvme/host/nvme.h | 5 +++++
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 42b69f3c6e20..cd5dc104d4b1 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1303,11 +1303,6 @@ static int nvme_identify_ctrl(struct nvme_ctrl *dev, struct nvme_id_ctrl **id)
 	return error;
 }
 
-static bool nvme_multi_css(struct nvme_ctrl *ctrl)
-{
-	return (ctrl->ctrl_config & NVME_CC_CSS_MASK) == NVME_CC_CSS_CSI;
-}
-
 static int nvme_process_ns_desc(struct nvme_ctrl *ctrl, struct nvme_ns_ids *ids,
 		struct nvme_ns_id_desc *cur, bool *csi_seen)
 {
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 8fd30ef19757..9871c0c9374c 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -892,4 +892,9 @@ struct nvme_ctrl *nvme_ctrl_from_file(struct file *file);
 struct nvme_ns *nvme_find_get_ns(struct nvme_ctrl *ctrl, unsigned nsid);
 void nvme_put_ns(struct nvme_ns *ns);
 
+static inline bool nvme_multi_css(struct nvme_ctrl *ctrl)
+{
+	return (ctrl->ctrl_config & NVME_CC_CSS_MASK) == NVME_CC_CSS_CSI;
+}
+
 #endif /* _NVME_H */
-- 
2.25.1

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
