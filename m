Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F472C3DA49
	for <linux-nvme@archiver.kernel.org>; Tue, 23 Jul 2024 06:56:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-Type:
	Content-Transfer-Encoding:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=KNG97TuOAGpfO0lEV0dlgvvbLwlFxs35j0ufNuZ6alE=; b=4mCwumaDBOI2CFpblQs9d3/y0/
	0LAXZRUyPHq/SpxobXbDAfRfm0VjhhVhVJeLECes7hiRkucL80N0yNXnctL09W6BX3keerxbR8XjU
	oR+RChleb0ACRvz3Ypq5MpI6uIbgI3Ku2QG/DIxh5pPcEhZfSEqdpxtnpNh7EY4+Rc1DG6rLIEatw
	Xx8eHjy5IhkHhEXhe60u+jYJs1ziu+viDkL/Ri/N7D6gwlscWyr3Il6BVLrZwcBQCJQ5sbMm5DdEl
	BkZhmQaiVHKzTx0bv+Wrm/dDX4CVLCn3qcOG6aCEQUhgUpjG3Qu9rWKrwHYUW9OZSLIFEOMQ3xsV2
	CD5JFbsw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sW9Rq-0000000BdiM-1yrp;
	Tue, 23 Jul 2024 06:56:34 +0000
Received: from mail-westeuropeazlp170110003.outbound.protection.outlook.com ([2a01:111:f403:c201::3] helo=AS8PR04CU009.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sW9Rm-0000000BdhG-2Cju
	for linux-nvme@lists.infradead.org;
	Tue, 23 Jul 2024 06:56:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=niQIOCWh4jeLKmo5wMGwMB2AQJJdU3HFnQgf7zcpGsqptX6NEHZ4HNItEzhRcSFXCMGDJnCOOEIa2Z2afJbfaMvRvxeFeR491QuZIzSZZfCo3mp52OjLXOsqCg5FvyM2+EXXGyyyJHYCks4VKuLE1QYecTar4Jr7EaK9XJ9Kh9YC8ZoZMJ4Rdr26SSNMGV/4198vj6b3VNtkr4nPQ/sE/Cz/f2roayCrgXVV3dUD2UlsEh9xdvaDJcKgQAmGlwN6VIB9AgU2fZ2LPdA6P21PFY4vjJ3E+xzljrSQPlP/auBeldMjkA5fBE1V3GKEGTwHg7M+coB8w7vC/i/QCQ40LQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KNG97TuOAGpfO0lEV0dlgvvbLwlFxs35j0ufNuZ6alE=;
 b=LIlyyzGHuOxx19X+MRsFHE5cGXig9XdqSxVRsbcs9Ml39NvPAGPln/iGZyzysjn/nT6eoypWTyFQnqrKbmWfVIskp82C1aKzVX4GlO/+jlfhB0txGTfPhDc+k7yKfXWdgq8CB7BX/RtrVonDBvHyUvYbVxum2fDZWEYN7ONFiT2gnycehvBb1mfUMBR+4vMIuXxvuIuWIR/SVlGjDUiLO2IO4Vk9+b+gvTRsJrMWkPViN4PIIINW+qv9NTv2AkXmAGi3TZTEoPKB8anpJ7FuAgrSoM88cFC6wgst3CZMLKCbz7Ztq3ig/oYHCODcwiwCHo8/kWuirNKP8mwWQaBs2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=volumez.com; dmarc=pass action=none header.from=volumez.com;
 dkim=pass header.d=volumez.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=storingio.onmicrosoft.com; s=selector1-storingio-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KNG97TuOAGpfO0lEV0dlgvvbLwlFxs35j0ufNuZ6alE=;
 b=PBD5U4lKRSaenctfRCXNsB3WaEFuS2HFXjRgqspkhnQc09c7H5ZA5ZK90gRF3N6MsASMKoRso9jZlrTtqkSZa625hB/BTpPdRY93SE9jLGG8X4lgM89gicFh75UTm9SCiyQJrrE8OwgdccgpP/dg8oxeJy2SbV7/HN3oTA30Qtao3GZv2qzFjIF2hnvRK81/T3aSrEnohL9cvgP6Xd1Q5tFcrytpa4VZGMajBYY0iJvrdnD0TyZImrHxADGR8bsCbLe6eQhIFrD8oxTEhXeuAaPIfxtbPLYqtfxkcD7wUepETYMNpZZOcPVoofnQzg/oDcENWpQV/fyO9CIJiUYDJA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=volumez.com;
Received: from AS8PR04MB8344.eurprd04.prod.outlook.com (2603:10a6:20b:3b3::20)
 by DBBPR04MB8044.eurprd04.prod.outlook.com (2603:10a6:10:1e5::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.19; Tue, 23 Jul
 2024 06:56:21 +0000
Received: from AS8PR04MB8344.eurprd04.prod.outlook.com
 ([fe80::d3e7:36d9:18b3:3bc7]) by AS8PR04MB8344.eurprd04.prod.outlook.com
 ([fe80::d3e7:36d9:18b3:3bc7%5]) with mapi id 15.20.7784.016; Tue, 23 Jul 2024
 06:56:21 +0000
From: Ofir Gal <ofir.gal@volumez.com>
To: davem@davemloft.net,
	linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	netdev@vger.kernel.org
Cc: dhowells@redhat.com,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	kbusch@kernel.org,
	axboe@kernel.dk,
	hch@lst.de,
	sagi@grimberg.me,
	philipp.reisner@linbit.com,
	lars.ellenberg@linbit.com,
	christoph.boehmwalder@linbit.com
Subject: [PATCH v6 1/3] net: introduce helper sendpages_ok()
Date: Tue, 23 Jul 2024 09:56:05 +0300
Message-ID: <20240723065608.338883-2-ofir.gal@volumez.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240723065608.338883-1-ofir.gal@volumez.com>
References: <20240723065608.338883-1-ofir.gal@volumez.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TL2P290CA0021.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:3::15) To AS8PR04MB8344.eurprd04.prod.outlook.com
 (2603:10a6:20b:3b3::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8344:EE_|DBBPR04MB8044:EE_
X-MS-Office365-Filtering-Correlation-Id: b2de60a6-bef5-424c-bdd0-08dcaae48f0a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?nwbp5Nhp6kL+FwSqKv2jYc/UicEgHR2BsXmj9L45Wcb6hXWBqGgngcyuow7O?=
 =?us-ascii?Q?pWBfASpQluqlb6nni0gRPnDCQb5UHkxRimhOIDDEWSgS1rPJhnfa2DjtlyWJ?=
 =?us-ascii?Q?GCU2TdohT6Je+dgEyweTPV9bIiHTZ217jUM/6P8mmkgwrskNY8c6+EFn7zzq?=
 =?us-ascii?Q?SawyTNP5vxT2exxQE2joIGgY/FmybGNq/CjQ35xtMHm6/3v8jBarobTUt7Mh?=
 =?us-ascii?Q?xREM3wEbz0GdVOiyJ+SREovQbZ9R77wdpONxcCkpyoNqbFDi3KGMjaPAzx3t?=
 =?us-ascii?Q?vDt9nCHesmpJy3gVykmRyOf5o35QFGGEHU+J/tV6fZcmZTQ26sQ22TsPxUG0?=
 =?us-ascii?Q?z/SxmXlfdtsWLP4uiW0xXGfPDFRQeyNXurOXb7pwvFnWv2paNZ9+dy4Hxsiz?=
 =?us-ascii?Q?c+K2DUHnXI8SfyQQvS5ciPQjqzgwncVKRikUzyW+XrwoOWQfxysIexw4PS/t?=
 =?us-ascii?Q?6SUAssZGcXSFVRJc8YE40H6YBRuqBkJAviDX9LboCKaLcEo6S6JWT8Zs0SXB?=
 =?us-ascii?Q?xH2GERq1cxl2NBGKJIpOjk/5VdYisrlGAEJhUUwggC+e+NUDG1WFNufT4pyL?=
 =?us-ascii?Q?r537fcdGGvz5wG5+vwOLbIEtjpR33LYpEugTs/JHGKSeWptgbt4Zohcz9sqt?=
 =?us-ascii?Q?WqxD+DR8MxZLP8nYjrIK6iBHCJsU/gqvubW9V3SwmMp03ETbxXoiH69X6xVO?=
 =?us-ascii?Q?DZMtZx+H+lwDUTWABNHo+6SyCP29UJ/BXeORR2QnRn2UKxiQRNSduutgv8XV?=
 =?us-ascii?Q?1y01cqIqop8I2+gMK2ebg32DEqfXPNNNWHHM0iL17uQ5jsQFBSHkRGxWW9sY?=
 =?us-ascii?Q?gzMpTgj1sUvZUgi4qccoWhwvi8xcB9FecunwhjcjfRXC2u2Uxhb6eTgrVNn8?=
 =?us-ascii?Q?5v9MAnL+Ag+I8T7rQfrRl5sOM3DvfZC50GNNptAzWQ7/ix+1fISKEo1JZNPK?=
 =?us-ascii?Q?GTZtC+edgGoL0ibSxB5SnUykCsj2OLvmCK0WvuruhVlHkl2Ftzgj8RPeq4qy?=
 =?us-ascii?Q?fn/qTmiQDOUYlLnCIJKRtXc6+QKMJZ1rbIgO1t80btEgb5hqDHyd83vi0o+U?=
 =?us-ascii?Q?WWst12kYp0D9PncuVt7bO+UFTJlTmKU4a8jyZQjSwJkfZqbj2ucGoi4s2auv?=
 =?us-ascii?Q?0GB2gEkbalb27tpz7MmtN/WGRO9niIZntZdLWmCF8B3RsIV8Ro2nziqtpVfH?=
 =?us-ascii?Q?KpAJEgyL36wiDyIfy5RnLUxFIel6pNqMDNsaoaq7eDUXmXOEz7M00mEQZnb4?=
 =?us-ascii?Q?+1t4o5gWvyjQaAwQSnx96FyDp293t1jtwJWs7X28IwcDxPPgQoKMbHWdj7Al?=
 =?us-ascii?Q?nVT/Ql5IwV89IwIFmL0fmrvDhyBVqbKYDRvMUs4EG8HSkbMqY5DVWgYGxaj6?=
 =?us-ascii?Q?/szown4oSRdVGuMI+xJAlYMwcCdJo9YBcrMhhY6S2WSl9Xj2+A=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8344.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(52116014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?sqRLBV3zHBR/L5TqjaWMk07CyyxYfw5F65UMsQWkmvPlX0VbyxuNedf4i8fj?=
 =?us-ascii?Q?pCLtKVFz4RbcazWimxbdGIkzbjA3G9bCHkBwAOXj1xEj2QBobg7O/IvKotI8?=
 =?us-ascii?Q?YNC7BmoS8GxWbOd4AJr/imOR+uLneUZ9S5SIBXDKjHS0lDL6X/owWJlv+aQi?=
 =?us-ascii?Q?0diPrtiCgtuSIWHDoSAKsLx7X1ZKj/IPqEEjvTBctTraVUChwYELmHiZhge/?=
 =?us-ascii?Q?OSEQX5LhUbmKOPPaoMjENLtd4p4mcuEM2xr87dH9IGZKeoWXZJrzaImORncG?=
 =?us-ascii?Q?B50QHIRt9euL8O5HbL2Ivvdu1OBsRZzeIXKAzVYd9xaumF90fM3ADoNhDGM4?=
 =?us-ascii?Q?+HuZpW0DHpjAvGwq2u4f53ZwrDa0kZWjq5mq2vQA7aekykHMGHJb291QJXRh?=
 =?us-ascii?Q?ibSl9Z25OmnbFn3Aqo9aXc4dZVBST1ClK8TrTBRSSpp3tcgkzX3gp3Kd/ZIH?=
 =?us-ascii?Q?N8scqm03JI2C3A1VPjn8IMXct4TFiwEnPYbwGh35KJ8GHTBDWIYrFgqfscZO?=
 =?us-ascii?Q?CJsS9c84KFPgZnLuggw9yUw38PNoaJHXd0RbqKOLctOvt6jx7jJLBKAJ+FKT?=
 =?us-ascii?Q?4Ob1EnGmiu4CLRvq/MLeogcD0guQ1Y0JjMLV/jYVXhLzlpcJQ45nSZ2LNSw9?=
 =?us-ascii?Q?pTtLe3MHJ4+K8Cc+38pIxFsDdAKcN4PfkFt/VdLdZjDveo0N4m+SN7Y1V9It?=
 =?us-ascii?Q?SqZP0iy20XGK+BW/tsXQixvidoovWgCVrWvVuBmmSV/EbMlQADs0wgQ99pTx?=
 =?us-ascii?Q?zdZW8sT04f8cUZRHuCM+wmAojAz4s+HrEOugvnnBaDU+rYyABQYi0MR1sciU?=
 =?us-ascii?Q?YvBwblO+8pi3/5zIeYgjc+/nSz0cZu2LuwJVanimMcK/ZdKVw48uMSTFGnHa?=
 =?us-ascii?Q?avIrKmA0jt/r46uB68PogID5K/uZciIn45Z5V/U1kWmeF0PZDxpuF2OTtWOn?=
 =?us-ascii?Q?qI8/cNrGtBZFTUpAmouHaQCNBcDd2BSnlOjotdczsmqUXKon1VJm4oJV0G23?=
 =?us-ascii?Q?EZowgnssm2dQKJciZF2MjhPlHCdmOXxdxoWwVvF25r2IRyOk3NBphdJv3zx7?=
 =?us-ascii?Q?0DSJT6+WdbozauXjv5XMjqHFCIN5Hi/WMWxUpXkPkt4QRO6uD20EvIQ/u9Cj?=
 =?us-ascii?Q?shJu9eoo/ZrId3EHVzpzOaQ/alfTzO+LpoAMJmMzX+aAmb7EqIjRbNJ7smr2?=
 =?us-ascii?Q?tsu/qww45SM1q4scq7DiP9HMvHTnW81Wa3TLGNdEzR+iMbxnc3N+X+6436Ht?=
 =?us-ascii?Q?YbRxvxUfRNTeKH2bpvXFYjmM0JtS1/mZQN64FfvNbQL1EVOhL+LCl5alhy6T?=
 =?us-ascii?Q?ktnRb+jFeXPZ07/jHqjvO8yQKKEYw8/BLsRPm87YKoK+4z9cfk6ylWLnRYzy?=
 =?us-ascii?Q?dpj5/jaDNAeZl2uBYgSnFQPVBAcIZ9yl7/1iceASlPg8wfPjrrg5g755sa0A?=
 =?us-ascii?Q?ZWVtV4U50YnVEqVoOeR6cRMb/NowzE9ciL6CKzC3+IGemx4AmDQAoZiXyCNF?=
 =?us-ascii?Q?kWV2m9rCmuUQ+7lDtpdH0Kb4EobITMSRa3nYSY6Zol43dTkHj2IFisuNuUwO?=
 =?us-ascii?Q?pfRo/JV4MQODBq/FWFXXlJqggcL3G9J9QIptUWQC?=
X-OriginatorOrg: volumez.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2de60a6-bef5-424c-bdd0-08dcaae48f0a
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8344.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2024 06:56:21.0099
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b1841924-914b-4377-bb23-9f1fac784a1d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nn7QlA+iC8yz/pBCV/mm0RR8FrMgEtldX3VsfdOuYqZDxykukNRYR66vLgSJPuWERBdySmWeFGqEg+8VLJl1qA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB8044
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240722_235630_596543_67E4E985 
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

Network drivers are using sendpage_ok() to check the first page of an
iterator in order to disable MSG_SPLICE_PAGES. The iterator can
represent list of contiguous pages.

When MSG_SPLICE_PAGES is enabled skb_splice_from_iter() is being used,
it requires all pages in the iterator to be sendable. Therefore it needs
to check that each page is sendable.

The patch introduces a helper sendpages_ok(), it returns true if all the
contiguous pages are sendable.

Drivers who want to send contiguous pages with MSG_SPLICE_PAGES may use
this helper to check whether the page list is OK. If the helper does not
return true, the driver should remove MSG_SPLICE_PAGES flag.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Acked-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Ofir Gal <ofir.gal@volumez.com>
---
 include/linux/net.h | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/include/linux/net.h b/include/linux/net.h
index 688320b79fcc..b75bc534c1b3 100644
--- a/include/linux/net.h
+++ b/include/linux/net.h
@@ -322,6 +322,25 @@ static inline bool sendpage_ok(struct page *page)
 	return !PageSlab(page) && page_count(page) >= 1;
 }
 
+/*
+ * Check sendpage_ok on contiguous pages.
+ */
+static inline bool sendpages_ok(struct page *page, size_t len, size_t offset)
+{
+	struct page *p = page + (offset >> PAGE_SHIFT);
+	size_t count = 0;
+
+	while (count < len) {
+		if (!sendpage_ok(p))
+			return false;
+
+		p++;
+		count += PAGE_SIZE;
+	}
+
+	return true;
+}
+
 int kernel_sendmsg(struct socket *sock, struct msghdr *msg, struct kvec *vec,
 		   size_t num, size_t len);
 int kernel_sendmsg_locked(struct sock *sk, struct msghdr *msg,
-- 
2.45.1


