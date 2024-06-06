Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C23A1C27C54
	for <linux-nvme@archiver.kernel.org>; Thu,  6 Jun 2024 16:13:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-Type:
	Content-Transfer-Encoding:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=gR9RZ2XAe++YKE4yhZYyM3HdbhJrpHDV7vjsbzCN2fE=; b=O6Veud6Zh4TmjEsGjaHQ0w3XpC
	L3xbQOddKyv9GEU1cGjprmDpP8ZbIXT/gn2ADEWS0l/9SMgi/6U/48H0UwRcIjD0W+koqr6PpTVSL
	k2DR7NxCn2/F5wj8aQ/M8QdCc5Ui0+AN+D/v12VCw6qCCY4STBCGOngaRs6I93PHAU+0eADMt9gX7
	AKu2Xna4Mxu4SgCSRMrMhGZdZ+JwcosjhuszhvTNmy0eDZJQZLi9gWm/+D3dCVYEDcl4yTXNWizVv
	nipwhDZBbHrngT5BwFiorXBb6S/vAVyG1hibQMGcEIUbKFzlWLIyodhotN2tbaBvNszdxp+8RHjtM
	NWzKYfRA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sFFja-0000000AS4N-1QvO;
	Thu, 06 Jun 2024 16:13:02 +0000
Received: from mail-he1eur04on20714.outbound.protection.outlook.com ([2a01:111:f403:260f::714] helo=EUR04-HE1-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sFFjM-0000000ARzV-1WlN
	for linux-nvme@lists.infradead.org;
	Thu, 06 Jun 2024 16:12:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IbdQkB6PYKm1kuCLm+8TL7CNSJ2TCshHsW+sH9KCvIfYIqf+0Wz64xV4MYEQN26RTZWSl6GpPUaCSiK5REXBYCTpkjyAnTwTCdCF2KYbO28Fj5qEXqtCarhQQ8Ubchqpc6bTjsOR3YpdzLA+aIMlEYfEe2oi5XvEjLItPFMGzouxYzhLc4J050wrnp0LgV3DIZcQNMZCDTv/u6DQXRQZXcaok4VMn0OeUGJngxTK9IOWI7tRQV3Qoi6RZAHmSgs92svgvLpIINxv1qzeJ49D5SwOrOT0zz39QYDhEzQ5xDvGlgDHdBrndj366Fduu3h20uXyrn2MXnsCVB3TTAFx6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gR9RZ2XAe++YKE4yhZYyM3HdbhJrpHDV7vjsbzCN2fE=;
 b=OUUirCL85cLBSs5OEfoStzR3JqSIBKccfv5WKGCIbB2CfPhcd2fjabXrgI2Pl5dJR+3u7xk7RnPQK0BBmqR4k2GIAMDeP9VyM6YL5kf5SIcdw9GcPXFkTniALBho0sKmSyDAXy7Qu8AWNr678qcMI1nzX8ne1ltoaqr4Zbqzhh+kVozMpho8hMop/35jWGTXVNmxGeLTUBfCuY7nwwpxtN5aujGfRw4V6JCmoanyhDjzUquRFZ+spGysurMQZ2PTDu6N7zWXIEt9ZzFS8axhxhZcDWfTIrdFBaXmNL5Ig+Vb8xiq73xrbpsUeN+D924DkYygFAbgQcoiTOk4aPHsmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=volumez.com; dmarc=pass action=none header.from=volumez.com;
 dkim=pass header.d=volumez.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=storingio.onmicrosoft.com; s=selector1-storingio-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gR9RZ2XAe++YKE4yhZYyM3HdbhJrpHDV7vjsbzCN2fE=;
 b=WlsC6oIi08M8SvaWv+nMVCEiThcDw8JBfc4EpXlNMKDsHU2+jIYRpjYUf9PBjuF1YPPycF4vgnuhg9SO3QhSWYvzntARO8AUiVKXXbRvakWRakJbtKN24jlUm40l+yvRYk/hv4LsQ1CrLm+zOIhfSV2qWHrojxH7sw8owBfsEehj1I5w9cMarhbQihua+UFA8AS4W1s7O0rRaCUCv0ZOhgJ/zr7i05ZSELIiqZSJabQHDZkw70ERWTxXIkrltfsfHQskWRCX8uyCGj6ATzXXrhLpq+e87veNqDnVVsuwqQSaltgoS2sfSl98XpiSnI1v07w9sRYe6JFtmmzvMmUwpw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=volumez.com;
Received: from AM0PR04MB5107.eurprd04.prod.outlook.com (2603:10a6:208:cb::11)
 by AS8PR04MB7815.eurprd04.prod.outlook.com (2603:10a6:20b:28a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.33; Thu, 6 Jun
 2024 16:12:40 +0000
Received: from AM0PR04MB5107.eurprd04.prod.outlook.com
 ([fe80::de53:c058:7ef:21fb]) by AM0PR04MB5107.eurprd04.prod.outlook.com
 ([fe80::de53:c058:7ef:21fb%4]) with mapi id 15.20.7633.021; Thu, 6 Jun 2024
 16:12:40 +0000
From: Ofir Gal <ofir.gal@volumez.com>
To: davem@davemloft.net,
	linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	netdev@vger.kernel.org,
	ceph-devel@vger.kernel.org
Cc: dhowells@redhat.com,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	kbusch@kernel.org,
	axboe@kernel.dk,
	hch@lst.de,
	sagi@grimberg.me,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCH v3 2/4] nvme-tcp: use sendpages_ok() instead of sendpage_ok()
Date: Thu,  6 Jun 2024 19:12:14 +0300
Message-ID: <20240606161219.2745817-3-ofir.gal@volumez.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240606161219.2745817-1-ofir.gal@volumez.com>
References: <20240606161219.2745817-1-ofir.gal@volumez.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TL0P290CA0009.ISRP290.PROD.OUTLOOK.COM (2603:1096:950:5::6)
 To AM0PR04MB5107.eurprd04.prod.outlook.com (2603:10a6:208:cb::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB5107:EE_|AS8PR04MB7815:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ad05692-f5f5-4f8b-bd20-08dc86437d5b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|7416005|376005|1800799015|52116005|366007|38350700005;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Oa8CILbqAUz03+aKsStymH+zp2FTIU/BzjTFb3L3eivNDwfFj6/8Xu/j5tGK?=
 =?us-ascii?Q?E9Oc5bZEPdW9obVv/iLbkvb7dEoCByihmCNKKh/1Bn0EMkIuetl5DtpYPMCR?=
 =?us-ascii?Q?CrDuP7ePaZM+GAPJxSZ66gQkNZJO9iOBXtTP9x7MYL4a+U5a2F4FuBFMI8+q?=
 =?us-ascii?Q?0aKTDABExvd3KuXGnBgFN6Zg0G7vZ1FfFuR2v5IUPN/8Q3jOwPjy+KxFHCpW?=
 =?us-ascii?Q?Bu/x+BnK22d+RyrGVZV7GAc/p5x4byudVm2EBy2ZSM00kzg6EZrLXATIZiJf?=
 =?us-ascii?Q?GO9UorPus/66dxWGpgx4XzU1oKtR1WOQmow3qVCCzkEQdQpggbt+5dGRRA4G?=
 =?us-ascii?Q?8GQ2x2sjIA+rN8vPWb+bsNdukx9gOLHKioVTzGp33hjTo28ooCcIlE87T0xq?=
 =?us-ascii?Q?AjxXOGo/smp9i0Yk/+oGESG+I0smZKNLZ/02TxZKXLKV99jYvesLbl+JNeVA?=
 =?us-ascii?Q?iYIlEnyhBH7QyunUJL+z9XT3Yvk9iGui/DgmfKk+ADgCA1mVdKexJCSkajlZ?=
 =?us-ascii?Q?MmE8jn4adL9xe0ZanOWCTkRW7IsiEFqGCAAV81KUpFojgXrFfVE7MMsQSPl6?=
 =?us-ascii?Q?uzXRBmEyRox3OAIgBrGXr2JNpST/sFfE65e30kzzOWgwHnTMV+5srePDREys?=
 =?us-ascii?Q?G7MPDch39VhDXhzv9tHWmUK105yhwNTOIMGvlTS/btkICsw0Y4DDHxPKTjk0?=
 =?us-ascii?Q?FF2JQO+rl+Im5B5c8sJ6YMOYnaM23v50MttU8a9UBOepIYr9NyxbGFax4MO7?=
 =?us-ascii?Q?mEjse8+6pO/9R9cZeXGUS/951r93wATChP0/UDS9jSHd+BQ1QnvSjO7nQLm/?=
 =?us-ascii?Q?udAktMTTBCsJMrf7nGUjANg07j3bsowfbzGL9qBiNNRyZ9cgMjDtetg2Vvrq?=
 =?us-ascii?Q?RU0Zz3H6RzeUMhUnE7ioEHsqmHXzgTfyFCfYX6J2hK42qWfI13Td3A0OCseq?=
 =?us-ascii?Q?V+wrb6XeGD8dLQx0PbpemF/kQv9SDA+YdFaYSRMFcEVIqDCl+l0oT+Op9XwK?=
 =?us-ascii?Q?4dn8Kt8wgoYJF6ZERquZ1zYN8XJ1tJ1xc5b/jmcC6wj5M6aWhQF6ZRFcF8Fx?=
 =?us-ascii?Q?+whCfuWL0qJf7aoKkRVvDRTrRBPswfnyuVvN+CjLE/d4cD30UAuB1PwIhTuP?=
 =?us-ascii?Q?GBmTfXMyE1PH8AXfTEwl4yXZZYOKTNs5pXX4y0YPDhwVdjRhftIx+IIU6c/N?=
 =?us-ascii?Q?MMnAepp8UOEvihpNPhbPBx/FuD6DsEMPEsnItDSJw3luzttxgrypdrW5eK1B?=
 =?us-ascii?Q?SS443TUWWunG0OxIHDgb54/cg1pkpZVMo98s85OOmFAx7kf5/wy1jH01tOOM?=
 =?us-ascii?Q?gke53gog1sTDK85JjrghK+/iN2U4yq9dTSLsJai0pSEEjdWQK/8+E51a0fom?=
 =?us-ascii?Q?cb7xSOU=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB5107.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(376005)(1800799015)(52116005)(366007)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?TwkScCQs4N+AXjO0/uKInuKPC9J0HPkDKOR+EBZnMTBoqY7yWWXXn1gFrGuJ?=
 =?us-ascii?Q?/KzEg0ylgt3tX119KHatRFrulewCHNrRsaQK1n5YrUzVD4LjGkqaAFlxx23R?=
 =?us-ascii?Q?WXQ9alOXCMNEKJ9ey++vuQNQbxR/paPFOsFtNLrkXcX8jYXVkMsobveoLqmF?=
 =?us-ascii?Q?A8+SJjVqC3ppB/8P3vtwL/1GnRXf7XseiB3ekLPmIoS0ck+AdjUYr3NkEENd?=
 =?us-ascii?Q?5qUyh8mHXJN0ytdM05lfJ2w9qIQRtNR3FQfxEYt+ieGpYbhBpWRa0rH9RnVt?=
 =?us-ascii?Q?uJj9nsBXx6KO0RL0kYr+6U+D0bizp8lu0dWS9GlyM3kKE0+X6sFY3L8ZYl5d?=
 =?us-ascii?Q?Mlwu1JAsKne3pKpuMk74bqevWypn3aibKX4PcDZ5TOEUXtDid0CsdwOH49l0?=
 =?us-ascii?Q?i2FgPtfsa/2PE4a6rzFbRfWLWD3F6J3J5YdWebyDIh9eCFRT2tpzVsxv2PZg?=
 =?us-ascii?Q?UGbN62mHFiVkBuUWFsFOeVQIJdYfhNEPUmDNcBCW+H9n/HyMivc6XxXkcLDl?=
 =?us-ascii?Q?6MVgkT4oGUXQyWXD0KXJZdoBU8CHDPQ+KzHYbHCQT19Hr6xspe9/EhudyQM0?=
 =?us-ascii?Q?WtmH8qX97WULSVgvnuOsZq8yCbUOb63LgdqZWXFnDSNAh5ADdDAYnwc7d7DN?=
 =?us-ascii?Q?Nv7k5htEIx6YYusjUTU7+8n64DZtgqWmHmLHs9bA8uLufWlCg5Db/ijgy6gF?=
 =?us-ascii?Q?Pb+Wc6fX7HlDPMoFGRGRWqx/4AUAE3Ezcbd3SW8fwH3wZsEHn8gZfufT7MRN?=
 =?us-ascii?Q?8jHjo0UH8GhNmjgoReiLDNvc/FFTHdpVOAXIzku14OoHYQ5W4pFwDNNqHwSz?=
 =?us-ascii?Q?eo4jFjFhT5OeL4ylj+uGGmZ7j/M4K8XbijyQqXWi2gecf4/kCtHwC7s8EcJP?=
 =?us-ascii?Q?Ff/yqoja4lOMdR1oDY0WtRb5aapxs1yIce8xJ9Y3jY9Tf53cAHIWzZK+2XJU?=
 =?us-ascii?Q?JIuJYVWUEus3PWtXOufXh0zpKZQMpk25c36GnJvXV2I69MmSQSRV+uWSd/Bn?=
 =?us-ascii?Q?BGgn+1upuyoYDou8PsaSRFvVM+2KuRjzUscrsPC4vkJvZcHLtIDVb0ccYeVg?=
 =?us-ascii?Q?D6o619KuwKsDCgiJKbUES0mG3gkxOatbbcyWlKMfAjkQtfbJvVSjeclooQ10?=
 =?us-ascii?Q?PjsQgjMi5IUOhHXzqd4RSDimVkSqKlF4WeseTZrKEx+vdd/M2fSToohxCFlU?=
 =?us-ascii?Q?5yd/yuGN0OTYnx5ufnrmmoPMPciTZNVnaM5pmTpT5B331TiM3feKBm+cuv23?=
 =?us-ascii?Q?aDmyoeaBJBtAFFicytG/Y5L4XwMKx/yMkpGq2ADx3rTWU09PBmeyopP2mWR1?=
 =?us-ascii?Q?R4a03dF9ug5+5/9tWgX9C5cMnCGFXi/8/JPcQUcHOBQdIc6v378w0NwAW//L?=
 =?us-ascii?Q?m4NuOk5Y6EEw9a4ZS+bfNjuaU5BK5NyZlEoezRRQlMdZMabvbaQZl0AvnJHv?=
 =?us-ascii?Q?7JSIiYNrE6NVxXg2Bzh6tQsgm70KdH/QAZwiJDG885V8jwUJ1KNwYBqG9tRI?=
 =?us-ascii?Q?10MqC0rHSEgjglWtqQIwOlPYrAmk44dyVtxpxo7MqRZRtQCerRUJmrXD7ExA?=
 =?us-ascii?Q?6NQojmaGC1p4TRm1/49dY4qnRwwj3G1elAbHQF4V?=
X-OriginatorOrg: volumez.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ad05692-f5f5-4f8b-bd20-08dc86437d5b
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB5107.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2024 16:12:40.5508
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b1841924-914b-4377-bb23-9f1fac784a1d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c7fLwV0+sJMNc/NVA9yl7xejSTjlTRlFkVR3DCWH3mHB37T5yOYVgVyIeYVcGtsIKr1YkEPpDulv0pwi9hUmvg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7815
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240606_091248_429873_A6C8A71F 
X-CRM114-Status: GOOD (  12.86  )
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

Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Hannes Reinecke <hare@suse.de>
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
2.45.1


