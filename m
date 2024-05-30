Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9586AC25B74
	for <linux-nvme@archiver.kernel.org>; Thu, 30 May 2024 14:24:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-Type:
	Content-Transfer-Encoding:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mXyPTjSX0sG4zzXDMHIlAtzkqrxPxSoExsIIIIGAj/c=; b=AElS2nSxpj+85gnBN2kYYRxjNx
	Axn5MursHNTknKqoBrKi78FtezqbLHGn3Zwu0G+3PeEhzxJBanHOWVsGEGd7J53GtVyVEGnHhHJQK
	qg81Mdm8iXcuFiCZ2iRFeC8WooWO0DOLUWQCHglm5M5bv/ypNBiqXIQCuqq10O/DAQEItn9lN0hEH
	6ZcX6fsEt5nZYDx/3uo0uU7biSZXEEfnr61VnOlt/lxD7egOiJ1waugEQgK2CVGVrHL78vW5hdxcY
	bQXUTdvgEJwb28j1NjoKlCqUaIrps580a1yuyRHMQfSh81TmSDafsUF47MJIe5FqYdqICru/8c8o1
	wIgUef3A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sCgi1-00000007WWn-0ArI;
	Thu, 30 May 2024 14:24:49 +0000
Received: from mail-db3eur04on070c.outbound.protection.outlook.com ([2a01:111:f400:fe0c::70c] helo=EUR04-DB3-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sCghy-00000007WPH-1VgQ
	for linux-nvme@lists.infradead.org;
	Thu, 30 May 2024 14:24:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fqAn24e/KPfmNaV4cO96zWyBlrH/5G5T3ewYK89N0qGpG8nUWwuSJQz23TkX9nKODn2/ctxJWomct0Cq+HIIss7AJeTQ+A0xm7AnedUNKjgmu7A1HrBRq3XLThwAHP8+fLO16XSt5MRTzmyK3rdqrs6+kajF2cM5sk2COjOw1rZ4HDOe9jBFTfhmHGzyVg8nzFVTfgjQZChkiS99i5moBXN9GDaZiFsWqOwtUGb1gli1nw7hrw/J0h0C30zmKcADCaFcb2Oc33GYfSE28EotddqoJr3cbt7oSlICPqnOAniTYFw0cUqF1G8iSCU5v6yPEqMgwOs5A6lGHzOsx90GxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mXyPTjSX0sG4zzXDMHIlAtzkqrxPxSoExsIIIIGAj/c=;
 b=UlGkRI38CJc9E1EEMnJgpmSwjilcDF2rKMOuvx1wV/p1+wRRk4iVzwebiJY4Hiwf4aF+IzLI2hHkr4flrg34KYNYqEPRRBXFXmMm0ryLwzdkEWclcB5hWGI1sRN57nVA32CHGnvO8prkPccbypiKpX62+38+sXNfBOCt0ENh8lfNaZY7KsYZtPeZg4G9MVnOmghA8OF9Tb/giLCiKrIdTzmCO/A/ntvqVbnizaap8Aa28b5pu1S0QrCeHpoSDAeG2HmSOVt837wkBND0jptc8kExsSDQq2xR8GwJufex4dJ40tgb9LA2BdyfqGiPahWGboqk6vrpt7w/Oc9kYn2H1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=volumez.com; dmarc=pass action=none header.from=volumez.com;
 dkim=pass header.d=volumez.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=storingio.onmicrosoft.com; s=selector1-storingio-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mXyPTjSX0sG4zzXDMHIlAtzkqrxPxSoExsIIIIGAj/c=;
 b=Hj7TA7Z7rzhsDjEJHqoB16FJAPQtyJsyEruSNMFOVD357UOI+oV41OfXw81PBVBSIXrY7Bh1J2rrNqUv+RACjjXFIPEbBPeqH6KZqAg1jb8xYc12TiAZa43Qakmj/+ITcY6RAJFFnxFOjYi5divBivWvq0HPA+BRDOhtKaSM7bYl6CSK+8RqKOnOblbbAHk+8QsvKhSWnCJ+VPjKW1Ek9GAWnPU3Ly+Z17tcRfFAoKOQt9sFFYVt4OTnKazzo0wzKqosJOchjdpcNMy70E3TQX3M3FMxlOV8QXsYxAam9N9dNL/j9D8hhKjoXny0LAeYu1WlM86WgiME0zVwQ7V6mg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=volumez.com;
Received: from AM0PR04MB5107.eurprd04.prod.outlook.com (2603:10a6:208:cb::11)
 by GV1PR04MB9216.eurprd04.prod.outlook.com (2603:10a6:150:2b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.19; Thu, 30 May
 2024 14:24:36 +0000
Received: from AM0PR04MB5107.eurprd04.prod.outlook.com
 ([fe80::de53:c058:7ef:21fb]) by AM0PR04MB5107.eurprd04.prod.outlook.com
 ([fe80::de53:c058:7ef:21fb%3]) with mapi id 15.20.7611.030; Thu, 30 May 2024
 14:24:36 +0000
From: Ofir Gal <ofir.gal@volumez.com>
To: davem@davemloft.net,
	linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	netdev@vger.kernel.org,
	ceph-devel@vger.kernel.org
Cc: dhowells@redhat.com,
	edumazet@google.com,
	pabeni@redhat.com,
	philipp.reisner@linbit.com,
	lars.ellenberg@linbit.com,
	christoph.boehmwalder@linbit.com
Subject: [PATCH v2 3/4] drbd: use sendpages_ok() instead of sendpage_ok()
Date: Thu, 30 May 2024 17:24:13 +0300
Message-ID: <20240530142417.146696-4-ofir.gal@volumez.com>
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
X-MS-Office365-Filtering-Correlation-Id: 96602cd0-cff3-4268-08eb-08dc80b43b94
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|7416005|1800799015|52116005|366007|38350700005;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?at8Roi5anQxV0RZn6xn2t7bWx0V8oQiz4G888lDO1gnv4T0LkYzUWoBpWcZ5?=
 =?us-ascii?Q?yFd3pa+hYpY704ydaHVUPzA3gEmzI+Gjewn8S4bxSUE0juWZDuRABpbUaVZ/?=
 =?us-ascii?Q?8/3XT5oL+YPTL3H/CuGLL+tA4a6vhm3BaLUlfx8+HrpQG6DY4ytRcejijHLf?=
 =?us-ascii?Q?mc2aUMoZmafZ29LJwPAhlWPGsAqndteLSTH34YXcMpRNTprpj6mBwAS9mc3D?=
 =?us-ascii?Q?IHrWiKgEWcR8Ph8bFah3KfCGgvEqZvPkiV5aFrrlfBcJ6s8bmKZEN2quhBKB?=
 =?us-ascii?Q?q7icZ7kTtWiWj635SmzrE0Nn8ohqD+5RcAD5wxKg1Y27ntGpVkp1oV+X++/v?=
 =?us-ascii?Q?JcnXyywDgARNROpGCPA9Mg6wz/KZa95tH86hM9g0m7EmlP9GdpdmJuIhvuxL?=
 =?us-ascii?Q?8JzIyqp4C1YLmMbN9V+jHYyXf9j3LFOEB5QHePxcZE5BdM1HzyG87je9CwRC?=
 =?us-ascii?Q?A2UCvGAY6aNXKd9sn+I9HLdg8bULNw8s85tRs1MB2GryNcG3VUgM8CGanuGd?=
 =?us-ascii?Q?t5iptja7qs8rakuVTFCU9ZxwGysKivayy2exPFeC9uHsKhziOieST1U6GKW+?=
 =?us-ascii?Q?O8Cur5DZlMVUeWyyXN+BXgiveqE02lrFt0MArCbjNN/plTG7LRIOlEz+cqjx?=
 =?us-ascii?Q?F9m7gaXLJeWSZGJlvK/vMAR7663WLzRHiYXh1kQcgll40WrVRxKmxQ0pwu5F?=
 =?us-ascii?Q?C91x3wUGxmJjTFVkXZtT9AqPUobNTDpOrPV9JAhXo89R1V87Nkp8NQ0f15gf?=
 =?us-ascii?Q?je7bckaPQWNY1jsLCxQxRcOYvoMbu7PAm5TE44WJFm4z4vRsjjStnWqum/j1?=
 =?us-ascii?Q?LlPC6gUeNJg/D2/DZJ1zkLWEODztWPd1RzzLugQ72LhwogkAqZbLZcVgpYLN?=
 =?us-ascii?Q?/ddLegeajNEfgEqPLxnLdl1TqrvivF+tC1Xc0JfrkmhPlwx7ZAio9Ncqcuau?=
 =?us-ascii?Q?2rIrWdgKVBRQigRXwe23L5AgaUmnI3CbALGnjBa5RJJF9AulS9cvfO3rx7fP?=
 =?us-ascii?Q?OoEywECtJk8s3ol/5B8r13mqwrdErxfMeNL51G8K9BMkq6xvqCYXbAgRxB8w?=
 =?us-ascii?Q?1bzyu89pfVZ6XqsLY0jB6YPokOrwP3dzo2CaILL2s5kWVT0Fc3KovZqA4JKA?=
 =?us-ascii?Q?jAQyNUWPmYnTDGIucMJmDlwA6XkrwiJJ9kKLuRWSDmiVLL1XKTyTkSI4M2yt?=
 =?us-ascii?Q?x69fTe2T9KI0tP1XA3wP6AafaHbl6daBwc8m22MfpyEbl/9/WAHj0N8B05n9?=
 =?us-ascii?Q?4jhL3b4SPS7AwMbuuieGC8T1yENgVhlhdSQIg5nY8y/wV3Gpw+P0ey6RrJuv?=
 =?us-ascii?Q?yI0S+PJSWrg+aXYZDnY7ZYOVr9bTkYaRR4QLdViltUAUyg=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB5107.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(7416005)(1800799015)(52116005)(366007)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/lmPfXsqZsfftnSXYY3iLgnzah9wmRMS6fJGeNKC4EvE2/tzqyclaMID8ytK?=
 =?us-ascii?Q?sejFyAcnU3EFfZHb3T4mz811hqJyW8kVTYxX3UJ8KcG7NjsHEeZmROUpkU+C?=
 =?us-ascii?Q?S197JrnK4l4f3qOonVX0V9VSKlG6d1KBigZmb3CAl/H133br4bYY9HFQANRC?=
 =?us-ascii?Q?FjqiSnuWuMVb24JdIfDGbxIECCWYe6qTBigkYY2nGwa5SHsEb2SfLpzKnfVq?=
 =?us-ascii?Q?FRI2+hnWqK3amjcPXURnuapUHIiUWYDpXum3LdYtfsxzDvwJKX3UGxASzWzl?=
 =?us-ascii?Q?NcdktJls3vYMTJN9vpD8MAPW4Rf5vmAXEmFoYvFVZrNvz97rG0EzEC2w8AmI?=
 =?us-ascii?Q?60c/6ixEBWlW6MmjhpQEPC4g3+srui1V6rsocmgiOVrnffUAQJYR10nxFPCP?=
 =?us-ascii?Q?oihKa7iK9h+mF296zYUf2I4XyPLIWnNlEejQYUZiF9/AXIjz0ojorQ1nI4mm?=
 =?us-ascii?Q?DJOhK7MOrh/HSXobWZCTkB7ofwaGRprQgXq07sopF774ycc0zd2BZhKRnMy8?=
 =?us-ascii?Q?NpXBGcd/+fHPXfYGu/UBIugKyT+fpN0iAkByhCGhaeqLi3LfVWxf2qETmJN8?=
 =?us-ascii?Q?B8yQ/wDskdel/Fj3Ui+Zv2nacImGk4qGwlOyO9BWHvHPvgLGpvBp7EAfLc03?=
 =?us-ascii?Q?7IP0UHfSzlyyeHZ/OX4XLC5/g7zrbwtncFpPWCmg/AglvoEKfQhp+9c2emOx?=
 =?us-ascii?Q?r7vSx6cMAX/gakdGVCh9HgQzad3bJAjm7KKPYR2c7FraE2Db1007LhW3yuQz?=
 =?us-ascii?Q?jaZIAkT+XU9uaOEpt8W4JT2OPqXquGVUIybTnYh+UtCk7pDITNIA30DHUqGH?=
 =?us-ascii?Q?2V1hN20UMbdY02VnBygreJL3MWLwUy0fHhLJN5aMj3LwGMzAp7kW8QHD1Tvl?=
 =?us-ascii?Q?ylKjmO2qOe7bygDCb/OFqwVFgmYCXTIW+j/3aihC3eNUNcjHqYqV9pG8X/su?=
 =?us-ascii?Q?7uclzrDYBWeXWq8jcdB9Y3dw6P3X0+3y1PFPtaPJECxwz8DUIwWO0XumKMg6?=
 =?us-ascii?Q?41krhd1+o/gEyylvgl5/eCkYeb9qbxH4/PTuH4vislxj0amsbTytk7GRG3J1?=
 =?us-ascii?Q?oyXPQfq+5v/8q8Az7hFdJt8MAHmIJ5yHflnlaV6bPpGAYhU66f50lY8wu3La?=
 =?us-ascii?Q?iFu4WaLDti6ZWB1GH5B3ajUt4QFSZlV46DN/2jEtsBHx3AG+G57IPSMudXSb?=
 =?us-ascii?Q?5H8roV/VzWCQvIxxGylmN9hcdM34Hz9oLsSYGsQ7IyUGNAFwyUuW1jQdtZhd?=
 =?us-ascii?Q?VRgoPplwh39/i6LUGZp8MfkCvavQnSS+o2oZQVcepz/FeW11KGGe1zCNR4hO?=
 =?us-ascii?Q?KAaNuqMgzxzWlf0zrdgj9xEIgBdoOAyqUDshs8xwfTySyq2JNyMlKqtYEN5M?=
 =?us-ascii?Q?ZElzlX1s4ilWJGoh0JGpc4Y0EeCQqPhwCBy3DWIXZuPCJO7elne+/WINw5MN?=
 =?us-ascii?Q?Yk6h/bweEpp7xVPUrgzlQMmTBNcu/wSyYnplzE41+9jeWyRnTd8juVMmqYQV?=
 =?us-ascii?Q?b/wnc8vDZyj9obfan52XoazG1R8CTwVfI3Izl9eB/fmqIQbqzf8HkZzDZzv4?=
 =?us-ascii?Q?5E/cUHMSH7Iam64wV9ey0uuLYXBku2jZ9YpuKMBg?=
X-OriginatorOrg: volumez.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96602cd0-cff3-4268-08eb-08dc80b43b94
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB5107.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2024 14:24:36.2533
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b1841924-914b-4377-bb23-9f1fac784a1d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SUCbeffQpUOvvXUa3qDMHhqWL8+QpQPpWqf21/pvFIU5Npwozm/49vdMFXnQM1iStAlhOihDbjOHTa6f+yC3uQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB9216
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240530_072446_422407_2971343B 
X-CRM114-Status: GOOD (  13.90  )
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

Currently _drbd_send_page() use sendpage_ok() in order to enable
MSG_SPLICE_PAGES, it check the first page of the iterator, the iterator
may represent contiguous pages.

MSG_SPLICE_PAGES enables skb_splice_from_iter() which checks all the
pages it sends with sendpage_ok().

When _drbd_send_page() sends an iterator that the first page is
sendable, but one of the other pages isn't skb_splice_from_iter() warns
and aborts the data transfer.

Using the new helper sendpages_ok() in order to enable MSG_SPLICE_PAGES
solves the issue.

Signed-off-by: Ofir Gal <ofir.gal@volumez.com>
---
 drivers/block/drbd/drbd_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/drbd/drbd_main.c b/drivers/block/drbd/drbd_main.c
index 113b441d4d36..a5dbbf6cce23 100644
--- a/drivers/block/drbd/drbd_main.c
+++ b/drivers/block/drbd/drbd_main.c
@@ -1550,7 +1550,7 @@ static int _drbd_send_page(struct drbd_peer_device *peer_device, struct page *pa
 	 * put_page(); and would cause either a VM_BUG directly, or
 	 * __page_cache_release a page that would actually still be referenced
 	 * by someone, leading to some obscure delayed Oops somewhere else. */
-	if (!drbd_disable_sendpage && sendpage_ok(page))
+	if (!drbd_disable_sendpage && sendpages_ok(page, len, offset))
 		msg.msg_flags |= MSG_NOSIGNAL | MSG_SPLICE_PAGES;
 
 	drbd_update_congested(peer_device->connection);
-- 
2.34.1


