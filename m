Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E56BFC27C43
	for <linux-nvme@archiver.kernel.org>; Thu, 30 May 2024 14:25:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-Type:
	Content-Transfer-Encoding:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1Rfv8LDVgRTz9jiC1OhOxn9YPDgrbU5FKBlQ7Avcww4=; b=uP0Mzcb8/Kn/3/Y6z9M1EpHNzc
	Z/zZCE7Pi/LvoJYhyUzkmWc7j58W2K3Oej2a0QViiT7xQPsbJvKNUuoITYO/Zf4zAcDjhSaozVMyg
	Urbkfn0oozXgwUKSkqcc3qPti0nC3gfuZpW1FvGqgFrojHBDF5/19oM4RyELbxzReF49J3cIrHpeY
	ITospmOC+5yAnqdy5sONNwS5Ho8IMycl5GIlaQI+XXLfpjbz/gAb8ucGoULbh5sLkhSJ0uwmepU0I
	nac20hhjAfEYYfH1GZ2T4dt0heEOY2Xn1hi3DV5nwGDxbGLbbb5c09Q3gdYm2NPR1pVB0kg5h6mti
	JlDMpFFw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sCgiF-00000007WfW-2PAL;
	Thu, 30 May 2024 14:25:03 +0000
Received: from mail-db3eur04on070c.outbound.protection.outlook.com ([2a01:111:f400:fe0c::70c] helo=EUR04-DB3-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sCgiC-00000007WPH-0qIg
	for linux-nvme@lists.infradead.org;
	Thu, 30 May 2024 14:25:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CiHAveJnL6YbHJxKvpjO1zMgHCNvNtqKeIYkc5lHwF9gbFffN966JGI0jsghHcrqbsOyTWpIwlJg6yKs3BYYd49MW5ZmwcgrXgV7Yr+s9Z70UsLqGIYWQX4SY7hNQrRiiRL07bUK4roTHxaebkE103FZPX0udc+mzw5ovIBCVhmRSNj8VhhaanqzIVJrz82j0pwbl3bMtY599uokVcG1enUXRorqwzhfZSp6aIirqeMkibrBv7OwLhmWTF3czUsVvXGtBZXW0IgLM9b/QjG/hDRNVpUJIw6vpaxgAeZO+ctdbzxjtb8bacboOlSWOg5aXFR5g/rNytmnkSf83DTU4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1Rfv8LDVgRTz9jiC1OhOxn9YPDgrbU5FKBlQ7Avcww4=;
 b=QR/uQOORYHc+A/s/H72fskenTHs0t/tjAI1i35qQSq9bdJbYJUys5NsTZrZD1QhxDy05+pUtGA4PW+bSdirtjkC0chn+ex+AWm19yTz+rGAKzOR8k2evtpRHybuv5sEKIk4m989ShwrzanXaUr/lpfILXEb+Qjz/bKVPkoOXlhAQT77HPeO7bY6yEsqsWlkkiwQGGg/jAqvVQDn19d5QZnFBbX3aE3jJ9CzfGtiwvHIkMLxjEqYHG+NTUlCjgrqUbDnmupOEatELFFCZT2DaGZoToKEhgIhOikymLRiie37WiZPNr5Ok9TNLKK1OpurWArU/Lcb/l/D8W9rCnruh6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=volumez.com; dmarc=pass action=none header.from=volumez.com;
 dkim=pass header.d=volumez.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=storingio.onmicrosoft.com; s=selector1-storingio-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1Rfv8LDVgRTz9jiC1OhOxn9YPDgrbU5FKBlQ7Avcww4=;
 b=mjxLnEl4eu2bSrIUS83OqzUtoh3HNuU9SLnJ3+YTNZ4zDLjDTLtWKtkQ2rY+DjdrXdT5/RBGIpKI2Q2/EEff+uSxs1C6ZNYRIv3uelcQ+fNNUhCY5WU7rAqTLSV9LasoPhCdEkoeIsJqctaOzNsmJbOfkwm5FrwamuoXfpsift87uU4ekT+eapJhLT53U8xPSo9iGHazg3KN02Hm/K4d2h+mZZ6qM+aBw+Yaw1yGLDPFMmyb+1xXNjbqFB4khsPIfD6/nfXXEUx7pQYWY+s7eMqKEmm/oPScn1bOKQvhQdQwtXLbtGyqNPEOr2BPTO2GwPPlEL6o3KsY5giHwW1sWw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=volumez.com;
Received: from AM0PR04MB5107.eurprd04.prod.outlook.com (2603:10a6:208:cb::11)
 by GV1PR04MB9216.eurprd04.prod.outlook.com (2603:10a6:150:2b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.19; Thu, 30 May
 2024 14:24:39 +0000
Received: from AM0PR04MB5107.eurprd04.prod.outlook.com
 ([fe80::de53:c058:7ef:21fb]) by AM0PR04MB5107.eurprd04.prod.outlook.com
 ([fe80::de53:c058:7ef:21fb%3]) with mapi id 15.20.7611.030; Thu, 30 May 2024
 14:24:38 +0000
From: Ofir Gal <ofir.gal@volumez.com>
To: davem@davemloft.net,
	linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	netdev@vger.kernel.org,
	ceph-devel@vger.kernel.org
Cc: dhowells@redhat.com,
	edumazet@google.com,
	pabeni@redhat.com,
	idryomov@gmail.com,
	xiubli@redhat.com
Subject: [PATCH v2 4/4] libceph: use sendpages_ok() instead of sendpage_ok()
Date: Thu, 30 May 2024 17:24:14 +0300
Message-ID: <20240530142417.146696-5-ofir.gal@volumez.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240530142417.146696-1-ofir.gal@volumez.com>
References: <20240530142417.146696-1-ofir.gal@volumez.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TL0P290CA0001.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:5::15) To AM0PR04MB5107.eurprd04.prod.outlook.com
 (2603:10a6:208:cb::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB5107:EE_|GV1PR04MB9216:EE_
X-MS-Office365-Filtering-Correlation-Id: 098d4a6f-7f93-4ea9-ed34-08dc80b43cc8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|7416005|1800799015|52116005|366007|38350700005;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?oTYtWA9BMj49DaXyDpz1Z37O4Y8mcHDr3QFsXZiX+ZzYgiIhFuBdbA+7FO7R?=
 =?us-ascii?Q?ndTGdK9lxo3cg6Dkc2tdmOJn9rd3GU+6r8bmGAPCHUdy8Qa5HXZMSaEf9sxd?=
 =?us-ascii?Q?JSXgj0eglM7ItVl9sMhcVhBcU8n/NZXitK/DXaSWGFt0vYRe8b7ZHfPSmtoG?=
 =?us-ascii?Q?VeGjXrwCF90mu8Fc9EWvvcewVnil7+f5Wx2Hw22QhoE3X07uiBGG+IDWoBA7?=
 =?us-ascii?Q?RuKYvLh6D4n7P9FSbC636FBZR8Dqk11cm8wJTpTMua+c2Gi53THjCE0awvpA?=
 =?us-ascii?Q?KuF81XsPMlE3FRdAoDAJo5e2fJTmYAoHot2gOiOGVDiaBqlumdygn7f5ZEQt?=
 =?us-ascii?Q?qc6gp9llozoc5gakWAEdPU2mfoXXiFR6jP24lQCZi9EvluXTJkuxaU7TyxmG?=
 =?us-ascii?Q?3J9a4ZIxXtxqrP0d+/3Vcdwt27UazslyDby+vVbt5SmyD3qB0eFiVaIWhPV0?=
 =?us-ascii?Q?8ItbJJRXnLkyhBCGw7MEQpJwq7SLB5xKYDBw5ScKBMdu4YGUzKRkSszqbfsS?=
 =?us-ascii?Q?+e7hV9v760Lf34ryJaCLh5t/SJpXS39+SKLJ7ylpKGQDIeMDPnS5P9n9T/5i?=
 =?us-ascii?Q?bJHOkbxxKpdVTXzext4XtWoeGxeZh2LNpuDNwIFxGrracI2PG2aOVHNbjOke?=
 =?us-ascii?Q?Nyo0pSFbkk6YX7wl6rKSkOZuSo+udQJruTrP/EzfNPRTT+dffGph3enuXZzL?=
 =?us-ascii?Q?YHfxWA7mDK6AO5lKle0mdJHovxDjrgBMuFkdNh3TWb75G5ayVlVvyED6haCS?=
 =?us-ascii?Q?R9I/aBY/ryjCIT2NXpsnN3cETdamBHmjT1q+M+aaJ/oHb7mMPBelVaI81WgR?=
 =?us-ascii?Q?OAoRf2wd3ZhIGal2T6tsc4fpTdJsOp8kelsVeZeANecCHkdCLhY4f9a6P08m?=
 =?us-ascii?Q?s3+FLp/ZZo59NPjP7N11QZxHLR0aMyNI5p/OePB1lKv7wMVZ5GmNCBYgDGD7?=
 =?us-ascii?Q?foUS12uqh4R6IAk528+LxZ+Bd0UZMyjQVc8fG1QgGip6cK8S2zeDfuwRvnlw?=
 =?us-ascii?Q?ZRIpRcVVJ47QBRK3cIxU7MnasdDqwZT1UPxvUiReFDOhu7GLkNsB386vXVJa?=
 =?us-ascii?Q?oyGkp4YPA1jLqwMLObZotXUA5Lwp+fau7F2HNrGGt0A/QuRCJ466IFamxhiq?=
 =?us-ascii?Q?l26lkDwO0TIv6fhsS7TURTarOdcTSKGySqqzxFVQVk/SRk1bxawQdpiL6COJ?=
 =?us-ascii?Q?OOxAL1YcDasIdMRcx7yKi0tfzw3uJgKdXPhGuaw/2etocL8iRWKDdK6xkQLU?=
 =?us-ascii?Q?VVByqQ9+w7zptNEEs8x7eGRz7NBTC4TTkb15OVAV6pkbFn4rfWDv3B1QFSjR?=
 =?us-ascii?Q?4ds+Gb//CL8LHV6QGA4wqwbDiLHJzHLB+MUc1XXAUtD28Q=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB5107.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(7416005)(1800799015)(52116005)(366007)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?GneuxvJmFXOR1NzOJJ9Pd/nAr2iKW5NVnUVsqBREjttgsSj8pup4osM0f57s?=
 =?us-ascii?Q?EerR4THBMKet1vLDXWI3upe+M9SooisaskjEZZo6fBfHGjyBZLEKfYvcC35A?=
 =?us-ascii?Q?ZsJcaz4R7rar/hzdNIHnAv2Ze8zAIgOAsGM4sMrE+uiLbGkAXfQMyMkCcl8D?=
 =?us-ascii?Q?SMaGR61bHSfRJU3OlBPcmNcXFIwk+OvEAv/fgMrSmZAPbmL2A78UtdJBVhlk?=
 =?us-ascii?Q?cKMaeRYsw/7QJUOcfj6e81/BwJTzqttwUHhc5ihehHp7qfMlKLiFqXmjY/E7?=
 =?us-ascii?Q?VqQHABX3j7j976GWW0pFvZZZhmnuO5ni6JPW1u5zouUI+EStBidFfOGrPqca?=
 =?us-ascii?Q?cxBLz/FUoEw9zO8MIZTTFToxS6G1eLI97qQUdwghjXVEKnAI/ntBOdnx6BaE?=
 =?us-ascii?Q?q8rOZOdF6FNNhaG/FtllE2RhVBTZDEBSFFJsQpyfGJ3PFXcEXVYHYY1dmDHh?=
 =?us-ascii?Q?W5dD78VYGnK+6xwxK6l8GWm/HFVqqWmWGeU+i4GWM/kmEBAd4SyNmm5Bk3oR?=
 =?us-ascii?Q?S6XqztrnPQu77u1ysi489GMivkS1KztFi8/3kFBp5GzvTTjA+NksHgYxsVgl?=
 =?us-ascii?Q?L50hFiuDy3dsRg+kKVsjceSEhbhWHVECfazUpPcNEIbdzVSj9V3HL/TKmBaf?=
 =?us-ascii?Q?a0FMfTHTsy8D52GTwTyumxwtvIpccuuKbIBm4dW9nRsKvashgvU0oAlE9J5o?=
 =?us-ascii?Q?N2Jmn2AG0S50T/sRYELEGeUKU4MPaq3UZKY3y2zWcrUiV6pc00VgQ3FGpsHe?=
 =?us-ascii?Q?xkiGWqrkaV++3aCZsPZaHssBsPxkED1lUyr5ZyeYWJ2sjSTYXgRrPttK9qBy?=
 =?us-ascii?Q?w3zwJgnA/J6ke1JXJ3T3r2WOs/yDOKON90VdfdCp33fa4ktETsxdLibIFi6Y?=
 =?us-ascii?Q?WYy9mHszbyHR3IUetW4ldncDQsOqVNOR+rtGyxrKxJNC78BrgqCozucgL8UL?=
 =?us-ascii?Q?8Obr7+lTOUhTh6RZNJ3SCLMUwCRxaagOlp1FyC6BNVCpUjmCDcun1FHm7Mzo?=
 =?us-ascii?Q?NnpR7k1AUWVpW//H8AduKx2XpHqmFh+keXCALAiRKY1W6EPLOdISSR3E+E5S?=
 =?us-ascii?Q?lQegjTQr+1ldAd0OFDPr4nGKmx6iei+w18QWMmmg0gGSD1NmHP16NT+Fz2Dm?=
 =?us-ascii?Q?AUWFhDKyLGfsXf9s2vB0hgV2YoC1pHDO1dQwpZWIreuEJ/mpCCfnVgbTmGC6?=
 =?us-ascii?Q?nQu7KW50y87N0T61LsiBUyLCOlTU+uzRPTKUDiIOP9OLVrlMVS2VLJaPh8jK?=
 =?us-ascii?Q?mS3OII0HdwvF6LKbpJSEWvb/6mWLp7REFbkQvVAHVovh5rR2RBiDQXahqPsU?=
 =?us-ascii?Q?hRaXJeTmCIXhadrLkBKMn8gg+J4L+HBMeX6u36IhrXHp7+wavr/+Kebp/npK?=
 =?us-ascii?Q?IQkLOO/si0hFpNTh8Iam6M4xUcMzV67GfW1YxG68Wa8D46Ta9fNWIUBChiqg?=
 =?us-ascii?Q?z++5YvAGNTHLDP4ol1RqLQLvSxhVIhAuef22glrkD4ORVGxWeWxmV2x3CGf8?=
 =?us-ascii?Q?0sOxQtVs2ieC/3IgA56mW2cqaYkXKkgbWZ96kLvfq/QByPrui4q2HGWPnnAC?=
 =?us-ascii?Q?YtV9fXSR5lT7F448ydcMhUIFdHsHyj2nGLJDDLIL?=
X-OriginatorOrg: volumez.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 098d4a6f-7f93-4ea9-ed34-08dc80b43cc8
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB5107.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2024 14:24:38.2864
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b1841924-914b-4377-bb23-9f1fac784a1d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rrDZeKBWZAoNXt1n+KcAUd3ZUOqddFaZEvFKWTJ44/IqmneyE+Hxuv0H1e5nxDQfCIf6NQjG4AJI+Mi2aiMIgA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB9216
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240530_072500_332856_986CA7DA 
X-CRM114-Status: GOOD (  12.92  )
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

Currently ceph_tcp_sendpage() and do_try_sendpage() use sendpage_ok() in
order to enable MSG_SPLICE_PAGES, it check the first page of the
iterator, the iterator may represent contiguous pages.

MSG_SPLICE_PAGES enables skb_splice_from_iter() which checks all the
pages it sends with sendpage_ok().

When ceph_tcp_sendpage() or do_try_sendpage() send an iterator that the
first page is sendable, but one of the other pages isn't
skb_splice_from_iter() warns and aborts the data transfer.

Using the new helper sendpages_ok() in order to enable MSG_SPLICE_PAGES
solves the issue.

Signed-off-by: Ofir Gal <ofir.gal@volumez.com>
---
 net/ceph/messenger_v1.c | 2 +-
 net/ceph/messenger_v2.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/ceph/messenger_v1.c b/net/ceph/messenger_v1.c
index 0cb61c76b9b8..a6788f284cd7 100644
--- a/net/ceph/messenger_v1.c
+++ b/net/ceph/messenger_v1.c
@@ -94,7 +94,7 @@ static int ceph_tcp_sendpage(struct socket *sock, struct page *page,
 	 * coalescing neighboring slab objects into a single frag which
 	 * triggers one of hardened usercopy checks.
 	 */
-	if (sendpage_ok(page))
+	if (sendpages_ok(page, size, offset))
 		msg.msg_flags |= MSG_SPLICE_PAGES;
 
 	bvec_set_page(&bvec, page, size, offset);
diff --git a/net/ceph/messenger_v2.c b/net/ceph/messenger_v2.c
index bd608ffa0627..27f8f6c8eb60 100644
--- a/net/ceph/messenger_v2.c
+++ b/net/ceph/messenger_v2.c
@@ -165,7 +165,7 @@ static int do_try_sendpage(struct socket *sock, struct iov_iter *it)
 		 * coalescing neighboring slab objects into a single frag
 		 * which triggers one of hardened usercopy checks.
 		 */
-		if (sendpage_ok(bv.bv_page))
+		if (sendpages_ok(bv.bv_page, bv.bv_len, bv.bv_offset))
 			msg.msg_flags |= MSG_SPLICE_PAGES;
 		else
 			msg.msg_flags &= ~MSG_SPLICE_PAGES;
-- 
2.34.1


