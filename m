Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67BCEC25B74
	for <linux-nvme@archiver.kernel.org>; Thu, 30 May 2024 14:24:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-Type:
	Content-Transfer-Encoding:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=u6CD2Ca2T75xtBaR82rnXRMIKFDHu6ZHcG7APYtvi+I=; b=ezLn/KvaMvRnXrm8vdsKsKdPQf
	gtqSIA3SCdxQPANYtsiFJF5kkbeCQ3AV8EpDGqvZo2nfye1wIfg3FOwTs0akE/wJpoU9/lZhkVWPn
	pZKL0Ez4UOt+SJTSUJJVjBelK+xct97kq10iKxSU4yyT5KvwveT9ewsFPQKyHysU+gG8fkulz0OWL
	NHitq4TNt9b2L2OwaLtJejTKmMDNsfsnyzP6fz8VCxIS8TFsDkgW/pQkfJYTlM3IeSDtZcySQ0EDn
	8MXD90QDu1Oll1ZhN5fV2zM3ooW5tZfgGDYO39vSjbQ3EmNxSDZbDK2ScIa98V6DW/R2AhA89/q9+
	/tWyfbkA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sCghw-00000007WUQ-3BOJ;
	Thu, 30 May 2024 14:24:44 +0000
Received: from mail-db3eur04on070c.outbound.protection.outlook.com ([2a01:111:f400:fe0c::70c] helo=EUR04-DB3-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sCght-00000007WPH-0jFD
	for linux-nvme@lists.infradead.org;
	Thu, 30 May 2024 14:24:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mgvXXIz149Vytge/iL6oWjD6vkmG3wOeo1MHCSXqndYHq88uLvC3IlDxbLZzh+zyR8/kbiUeO2PcUkQKEV2fTe7hFEoyBZ4V2hKUMMKTuKVZ4QSVwovZG8RT48o6a+kMW8T7/s5Uz4M+tMK94xNrXkDREvcAXZOFVQzahEv/c7yin9+lEGDqxshLTEyE5ymZMLbNtM/HNYLbwZn1E8p9Ebq+106GCYNZFjAt+Jrvni4xtqRLrl6VJ+eRJROsyB0CIkqaBJQpSQPY/RqDIL852dsntYQBvnlXTTBMi47auPjnBqs8U99I6HMwylN5Fai2C9dxeq2g2N8qggBsDqawjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u6CD2Ca2T75xtBaR82rnXRMIKFDHu6ZHcG7APYtvi+I=;
 b=GzsOcyaw4xWcw7aoXnff4xJ832munv6w0lC4E8MgYRCQve1DwXPpoqC478KAsRuYqX2EoPonbGGV+R6+y5dhotc75Y/0Z9/4Q8ekU3/vgM9HwXkod+JHqPXuanDAzsg9Wp2Prfyx3Z3BwyyvME5F6JzXYD5gSJRIRWcEk2+0wN5kW3bD9aGXvLvg52hkjDXbppbrMCNUTPHU8lQ0lMrqruBYAQGFQjsrxgjI1KdH3gbzfBqGDl+niySn8pWtJHPuO/FFDWc/DPoPPH3XGx7zNdqcL3qxPdn6PW3fcs7W0Z1+UGgi+eu2dCz8YTFdtpkeI/i71kyl6EWlYZP8tyL/zA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=volumez.com; dmarc=pass action=none header.from=volumez.com;
 dkim=pass header.d=volumez.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=storingio.onmicrosoft.com; s=selector1-storingio-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u6CD2Ca2T75xtBaR82rnXRMIKFDHu6ZHcG7APYtvi+I=;
 b=PKyhePitMommsnSeVfdwZ9NpF5FHyaLloIfTKEAHYt/SzLCu3mMzjmW3hnCfzfTzz4sRVINqb+hiUHsFpRcRJL8lVyidQu2ZAp96pMk5JmkXOR+vF2fXNXwh3/IlpZURCob+xpEk8tVVDQ5r97NhvVIDzQ9E7g5J6Iej2eD6lLrBXNTpHy5yd9U6ZmHNwF3NQCSKEZ4oKS1GAt6r3/UxAfzS2H9H3LaWm+KpQa2XRV8XYhuav85GIp7n6wBTlJQJaE+4cJOqiIDTrNbUTrlrIdB/f6IGWxutWDndoB11PMBwFsJjP4C/+LdRK0jnrT6Gx9ACqcj+xOdqeNEH1mQT2g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=volumez.com;
Received: from AM0PR04MB5107.eurprd04.prod.outlook.com (2603:10a6:208:cb::11)
 by GV1PR04MB9216.eurprd04.prod.outlook.com (2603:10a6:150:2b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.19; Thu, 30 May
 2024 14:24:34 +0000
Received: from AM0PR04MB5107.eurprd04.prod.outlook.com
 ([fe80::de53:c058:7ef:21fb]) by AM0PR04MB5107.eurprd04.prod.outlook.com
 ([fe80::de53:c058:7ef:21fb%3]) with mapi id 15.20.7611.030; Thu, 30 May 2024
 14:24:34 +0000
From: Ofir Gal <ofir.gal@volumez.com>
To: davem@davemloft.net,
	linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	netdev@vger.kernel.org,
	ceph-devel@vger.kernel.org
Cc: dhowells@redhat.com,
	edumazet@google.com,
	pabeni@redhat.com,
	kbusch@kernel.org,
	axboe@kernel.dk,
	hch@lst.de,
	sagi@grimberg.me
Subject: [PATCH v2 2/4] nvme-tcp: use sendpages_ok() instead of sendpage_ok()
Date: Thu, 30 May 2024 17:24:12 +0300
Message-ID: <20240530142417.146696-3-ofir.gal@volumez.com>
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
X-MS-Office365-Filtering-Correlation-Id: 372f8a20-b1ed-4eed-d18e-08dc80b43a74
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|7416005|1800799015|52116005|366007|38350700005;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?+OHgp0t1w2/0ziLaquYowxwqU+DM/YqgWPsocd+FYT+zYKtEqvFQ9MHpXCm3?=
 =?us-ascii?Q?4y4+E2jsbnaC8Oel3E5WevqapHc84ELDXH3YMNZsYXm51l5r0/DZU7EIKVkA?=
 =?us-ascii?Q?P8ZDB6blj3BWKoTH9vmgDFKyNfVeBYBHt36bDF4B9OcyeE6W67X+nD/D8gm3?=
 =?us-ascii?Q?On/gjhwtQUJ1mpzBZ6ShcpsXHitsE1ox+xZGF7kO1nXBE14JAqwPXA66Nxm2?=
 =?us-ascii?Q?PjRZb9Jug/e1xvHYlkalQElaR98Y1Qe0lDWZ9Bp0Z8+VICLsVbOZh5/UGZKX?=
 =?us-ascii?Q?AZh5dYKmhWcFbyMdcdgcdTflozq16ChAUHpqSdGuPmK+sfDVASylUeoECBzm?=
 =?us-ascii?Q?O0WqxLa5HWW1FJQt1rKtcgYi5tdQxZEHjm+pCOsOE0XQC9NLMvNjlqX4JlxZ?=
 =?us-ascii?Q?c0sLDX2CnZB3gN/9eWkxvdY6xDKZgWiYCv78o/cgwoxMHRWM4RyzHLOZp1pH?=
 =?us-ascii?Q?WA/G6bKNLSk6DN1Si9z+/Y15Csqrxum6JhA+3SAdAYt67XQtWmewyte6OCJo?=
 =?us-ascii?Q?G30ZfVrQhKzPLPp2JZ76pDWve1u99JaHaRKv+PuWwsY7h8xGpjbFp9jT+bZN?=
 =?us-ascii?Q?hrSRRL3QZ2VpYiuZvy2gz5Kss2gbJf0wS8VJTjics6TZ3pWadD45dkFSwe9R?=
 =?us-ascii?Q?jjgaYK0MBeAMR6n7yGzO3gwNIGUCuP+qbCaY4VMJiMwr6IkW8bqhAozQFz2I?=
 =?us-ascii?Q?KGs5lUMn71QoCTt9TZIlcf+elTuy4BdqiA9tkcTyV/gkZPGkYjwlsJheyA3m?=
 =?us-ascii?Q?+03K2xIcXWhPfhHjJfsTqskJy8WaHH2/VZaNUWiHY2nYeMZ8JX0qKVbipvSw?=
 =?us-ascii?Q?URhALSBgztPuS4NH5ep3M0XPuyWxP1TSqscwXRDmCwYIDgPOWvnSC15eik+p?=
 =?us-ascii?Q?LXmlhCveZAdoJ0urt+k86SSqsFbyeDmwxBi9jldBnyYpbkp1yTE9jYNTHx4/?=
 =?us-ascii?Q?gnX6HSWdlegSux2ylPR5vYEvvJXbnjWkPAxfYNx/va4kfIrpoJ8zj255JKlO?=
 =?us-ascii?Q?VLRTv0157ufr8K5wGglojIkjAax3ragT27kl3FP1wFT3eoVcpGdpTSXIBYpF?=
 =?us-ascii?Q?sta1xddLZAvAXBHkj9xHkyP061v2IVOiF/nizZzec+MAyVJmBSoDCcHECWik?=
 =?us-ascii?Q?DqEeUhxJhZQHNUVBP9yjamCgJwRFdPxgTvRDBnoMEyhOyIbefYAn9S8zJjEV?=
 =?us-ascii?Q?JHIfIyIOXcQG4kj1BdjdhUONmQ2idJB+YRosLL81cz6fMq/5z2ciBwzcoFfB?=
 =?us-ascii?Q?1+Kd1uGO8oQRrtVii/8mmIEj8Em35LQ4d4QmgIgn3TUinLzCf4Wl8Hg9oErC?=
 =?us-ascii?Q?zWxZMYcqokxQq4kgOXEF+R+fzWD3RnxZJ/JZLkQOVligxA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB5107.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(7416005)(1800799015)(52116005)(366007)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fVA2Ekrc8Sjvrc1cTnMc+tjbi2r2gVKPYeZM5qrJ3/DAH4PQLGyVWsbF2rfa?=
 =?us-ascii?Q?hSu8UL7g0tV7iLV08Ds54BcKWfWmTwsEW1tTVZkAapNLUo2htSeiKvJxv+3T?=
 =?us-ascii?Q?0MJTg9oLpL966QwljM+TOnibSGHvYiUwR7Gpw7h9abPe+VB/VLpht7CkSPA5?=
 =?us-ascii?Q?/VLjOz7qIfYNz3risSJzV9bbc/2HbV6bC930YTWfWQDsUsaCiE3LnEdpKCvV?=
 =?us-ascii?Q?GrLQ8Nn4kDI5npPWMK+D8g+lVA/BEGTyFMO9GBO7qwnVfRnd9NBSzm+2aDiN?=
 =?us-ascii?Q?p3rZFHYbARMVE5/yOH/lZF3KL7m3Ax73boGhXZZ0Ow1wQRSANYjqRJFV7Pvo?=
 =?us-ascii?Q?iPneI3nYVWuI2R/Bknk7UCmALnVxwqbZXTtKJbetMggrdbWlfSEuDomTzE1A?=
 =?us-ascii?Q?q1J5Go+pzL1iXt473LizK0qoI0oZzxHoCFshnl0v38wVUcpzFt/urwK3LEno?=
 =?us-ascii?Q?esCqPP6JELWlOwxZOplxAacdaD7WUtGjjDKwLC0BxQoapacFt2TO4FtWn4RX?=
 =?us-ascii?Q?SKcNDWKxPsmXmOdyjWAtdhn3SdTUiTf6xLRlupdPmpZuw0hbyO5Klc7I8BAg?=
 =?us-ascii?Q?RGXAYMxHvWaxiBaGVycCtpXeRxj5EacR+Py44YptXpA78CPKJ+uiP9BKmuut?=
 =?us-ascii?Q?QsSWT75M6/kT8C6Apk0S2iPHkUH/KZkue60f0MPBZjAH890D1nwY5vumM7Gv?=
 =?us-ascii?Q?WLO8E1z8CY1atR5ygFGLOq6mr1+eCbpbVD9jT8Ild6pYd8aWo26N/6CTFSrH?=
 =?us-ascii?Q?JVnMPF5dHYvexPufRk2CwbfXY7V0IWhSourIHYKJ1nYn/GgbkltydikspTJ2?=
 =?us-ascii?Q?MCB8FZ3bewNgDY8IbnZSsQWAEE07AigaWH0645QgSt9zXFV+3ZggMBiBtB50?=
 =?us-ascii?Q?ujbUBodCZLSw4JAwaXxas2F9aQwuCh8saHBnlvvg3lMpP+SPt4V0R2zByH4C?=
 =?us-ascii?Q?5BQ/JMm6olIkRfdX3mOE+gkngrCBH/y/pfW1+re7ByzypEB8JDRpUXvMG2U0?=
 =?us-ascii?Q?ZJpHrc+GSj6TSpbI5GBfCdenrIeUGwHgR+efahxqLlI5rO0qy9/iT3EFlM2R?=
 =?us-ascii?Q?dFrMdjdPdXl55GPmk72KWQrk5hLZYUdrlkUoxQ/nXbHMp3UTESRa605YGj8+?=
 =?us-ascii?Q?qcIhJwlgJ8sJU2K4Zkod+NOB+Idbt/ZNxQd3kiBmTGYOPvpdLO2dh01uUMK9?=
 =?us-ascii?Q?QpsLGHycygSVzXMwIowzhlQa1CJqsICxfcgU8l71g4LP1Cf1mzh0cYOLe9jO?=
 =?us-ascii?Q?6HEwSvcKJrFvVOF54KWCUVKbR+noNw+DZkx8DWWr1XUaKmigNudEz8x9qdo7?=
 =?us-ascii?Q?CbtvD4m2qTzRIbFqM7roTxKy1ef+sYJLrPW2Be7P/ezFk2MUtrWJNh8H+zcI?=
 =?us-ascii?Q?0MqXwEwvu0YmeCgLrOlQQOr+fJHK+NFQIsX1SvnQAbZ64aEuvmyxTQ+idswy?=
 =?us-ascii?Q?td7Q9QB7GCYY2GzOHoLRQj4PXPYIuaWNZCRZ4FZNH85/BGiBknd7NaxtdVML?=
 =?us-ascii?Q?cevVFI66apnTNos3CveI5f73xeGxgEAmbJRJRJig4Lg22wMDhK0ARTAUnPTH?=
 =?us-ascii?Q?sUuSKlHZotdZBogW4LEQb8N1DSU6FbxCxQVZ6JbD?=
X-OriginatorOrg: volumez.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 372f8a20-b1ed-4eed-d18e-08dc80b43a74
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB5107.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2024 14:24:34.4810
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b1841924-914b-4377-bb23-9f1fac784a1d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RQNVMqOyFbj+dufFXMQbdAO45UsQ0wGpUHxlK2aJcP43KljOMTMUcvuaRN7XAvzjwX4dpH7swMtuBZI1RDwLow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB9216
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240530_072441_266007_8F82FB56 
X-CRM114-Status: GOOD (  12.60  )
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

Currently nvme_tcp_try_send_data() use sendpage_ok() in order to disable
MSG_SPLICE_PAGES, it check the first page of the iterator, the iterator
may represent contiguous pages.

MSG_SPLICE_PAGES enables skb_splice_from_iter() which checks all the
pages it sends with sendpage_ok().

When nvme_tcp_try_send_data() sends an iterator that the first page is
sendable, but one of the other pages isn't skb_splice_from_iter() warns
and aborts the data transfer.

Using the new helper sendpages_ok() in order to disable MSG_SPLICE_PAGES
solves the issue.

Signed-off-by: Ofir Gal <ofir.gal@volumez.com>
---
 drivers/nvme/host/tcp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 8b5e4327fe83..9f0fd14cbcb7 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -1051,7 +1051,7 @@ static int nvme_tcp_try_send_data(struct nvme_tcp_request *req)
 		else
 			msg.msg_flags |= MSG_MORE;
 
-		if (!sendpage_ok(page))
+		if (!sendpages_ok(page, len, offset))
 			msg.msg_flags &= ~MSG_SPLICE_PAGES;
 
 		bvec_set_page(&bvec, page, len, offset);
-- 
2.34.1


