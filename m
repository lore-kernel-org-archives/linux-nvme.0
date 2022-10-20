Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5219CC4332F
	for <linux-nvme@archiver.kernel.org>; Thu, 20 Oct 2022 10:37:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-Type:
	Content-Transfer-Encoding:References:In-Reply-To:Message-Id:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=F7Xo/YVyn/TKsPnakf/nUb1picyHcYQeAWM9+GcWnaw=; b=Ds6J6GQHyhF5dLFcwXgz/KOCTV
	YAA1xRICbKILNL16EZmDmI8ptOyDbJnR+mpKey9WAsUPEatnbumSVhlYhI0FJaLitYVA/8TPX3Zv/
	If4oTfLTN8frAA4tPi9fOhk5jVEJEAyHmq77adQcQAk9257PgKb1jW9zq8gE3f1D74C4ug6479Xmu
	hHmHd5wUjOL/xaRnsrvQqEyxHI1zBgt9pH8akGVpaLAMUAzBSGeOQFolPepEVJ+Cm+Odr3Z+mcYch
	tUVjPX1QbkzIGPeqr6ARVvor3YRxbFrYjoYIaDDwE1u5mOJFkOwkOvS2/m0pFLJPV9ardLtpQ6XLG
	Voj6Uutg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1olSvW-00DeBz-0W; Thu, 20 Oct 2022 10:37:26 +0000
Received: from mail-dm6nam11on2074.outbound.protection.outlook.com ([40.107.223.74] helo=NAM11-DM6-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1olSdn-00DSqV-2Q
	for linux-nvme@lists.infradead.org; Thu, 20 Oct 2022 10:19:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ISj8oiSUnH9LzSiT7PkcHasuDz4wzg49cn73dRw4bOUABgAVZ2nl2kdoLF+VokXk/JuTSJSEO/UXxgBUNW+qrWx+I543do0yxZQCL3WOLFjROcl6BL+/xlbz29VbYW/3HNqplzPnxHYs2AkrxDwD/m6aOSwW6B75udnqpSOg46F/UxugU64cK7+pkmNSYAn/pf7zeTqyvgNUMkBR3ivVVw6QFZezlBBCChaTcho/c8BaO7RJJz88i1SFvZIDQyWCyQ9Pa02Rk8w/psj/hWJ6J45u0IUwgP7SlTZjODV9E7U+T7oMVZo4caevtnDV5weohQXPx7w/ilc6yhgngsQkWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F7Xo/YVyn/TKsPnakf/nUb1picyHcYQeAWM9+GcWnaw=;
 b=cPWaE/dZ7/3MxeHqtigMYzcVQtNaP5DpfzwBIjeGZepv39v1WkqpvuEYTq4CpC7gufqTOKwAjMso1ZH4QZUm5WsiNK0626d9FsbZ9wgHRXehLTiS9iBREpJxEYrzl9RkwSRYJW6KDQG51NnXn3ef5rYxuyA3g4XNnIJkt79KxzAaP1X71VXhlFozaDNxNVp9bHsSLZb524WP14RImFqvb8MfgmIUajItG56EuUfKHdTgWiMt2/sYC4V8fjUbWaUXC9/7JY73+zQ9mc/z4JkzB7gCjcUnURJ0F34FYMf/s4Teh3k7xb/cVi0yPXqVe0vKdZk/DdSPVs2tXc6h9cnViw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F7Xo/YVyn/TKsPnakf/nUb1picyHcYQeAWM9+GcWnaw=;
 b=PAeHA0FAmbG1iIqb9KhURWgQi6ykTsC7uvhgHIpgXc3mJdyjekokI72aF1+vhqCHyuhLI1ISx5UfM6izAnfyjwfONTTLF0T15rzb3FVh3aklRE2BbhHywjRU1q85VKvGZ3kE4wSxjyNRaPDgRmNyQdta8XJPJLbZfyCHQ9gWZG7XnafniWLLUcpOd8ZsCtAHMbTPBcpQDoTaxAnAcYdW+2S0E65Z09ApiN6FLC19GECTaSggWmKT3aDuEz9SgA+DMwq9tOkrVD2sdtyYuQThubncFsao3Wtx4yXqkRgDCADP4KSBIB4zqyTNYnAgMH06psDXhVWjK2+JZMrnX7JsYA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com (2603:10b6:a03:45e::8)
 by IA1PR12MB7568.namprd12.prod.outlook.com (2603:10b6:208:42c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.29; Thu, 20 Oct
 2022 10:19:03 +0000
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::b8be:60e9:7ad8:c088]) by SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::b8be:60e9:7ad8:c088%3]) with mapi id 15.20.5723.033; Thu, 20 Oct 2022
 10:19:03 +0000
From: Aurelien Aptel <aaptel@nvidia.com>
To: netdev@vger.kernel.org,
	davem@davemloft.net,
	kuba@kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	saeedm@nvidia.com,
	tariqt@nvidia.com,
	linux-nvme@lists.infradead.org,
	sagi@grimberg.me,
	hch@lst.de,
	kbusch@kernel.org,
	axboe@fb.com,
	chaitanyak@nvidia.com
Cc: smalin@nvidia.com,
	aaptel@nvidia.com,
	ogerlitz@nvidia.com,
	yorayz@nvidia.com,
	borisp@nvidia.com,
	aurelien.aptel@gmail.com,
	malin1024@gmail.com
Subject: [PATCH v6 03/23] net/tls: export get_netdev_for_sock
Date: Thu, 20 Oct 2022 13:18:18 +0300
Message-Id: <20221020101838.2712846-4-aaptel@nvidia.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20221020101838.2712846-1-aaptel@nvidia.com>
References: <20221020101838.2712846-1-aaptel@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0658.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:316::7) To SJ1PR12MB6075.namprd12.prod.outlook.com
 (2603:10b6:a03:45e::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR12MB6075:EE_|IA1PR12MB7568:EE_
X-MS-Office365-Filtering-Correlation-Id: ccab9f40-da4d-48f9-b45b-08dab2848311
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 	+M4LuMsXcrrVorwiyrE0zveh61WsYQyl/LRkIBkU7qfwoIB18hPDzecfKx3ul0Fi1xXv36H8RZ3sxWBw3o7N12tDMmhGwceEJbBOf4V4QcQF8mD20AXq8p+HB3d2ZtI4HVsYFXi9jIzUTwSWHda4cKwMP8UGPakMfNKaBLszesrFs4qgyYnkp5LGT+4zyizCaiKuNegyymEs/IZBe0+s5SXa9wyw9jhXX6IOX38JHY4XBW9kpDCUA2OQ6oYyx46qwf55NOK2sWthLuXJMnt4wuq9jhRTkbH+vxPef6KjUnNjYrFW/Hlydk/PGjezLzDFQzsquVnp2a7kNT7bgZHHgzpv7IBBxv9t2Mnd13/gY6czkCppfdwcv3vbk4Ei/ka8oc8wVrAfo5BXNzbmc+j85zWvYaOjaPrHsk8i2YdckYjKLkjzZvY9nhzu6uO7CauuUk6XX0YFz4diy5n/+DLNAubed8oprgu4YTlUokS0xtV63kUz4JtoLnz6CcwMeLudYHqCkYO+je7iROFyYnFtRJXRWitpeDYsxiwnEjp7iZvQSRNxUqBhgw2VBBd18jnCUOTWFW23F/w7XrlyFSXsobswNgJTU1gjgW0oSKVzD8sroZVs6lmuK0DR50c67jgP7MzbutyI2DZCopNqoory84qNV+iXvWmA9/Iqrt2aTAVEf4qKAa4Wvj2MOQqXWFlz7xebgM2qGdUSSmwFH4uIgFKnhWCtbC1LoybLbRzX1vfytC3zj4UtwyuVJCYbgzNb
X-Forefront-Antispam-Report: 	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR12MB6075.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(39860400002)(376002)(396003)(346002)(366004)(451199015)(921005)(6486002)(38100700002)(478600001)(6506007)(36756003)(2616005)(4326008)(6636002)(86362001)(316002)(66946007)(66556008)(8676002)(6666004)(186003)(66476007)(5660300002)(1076003)(6512007)(26005)(2906002)(8936002)(7416002)(83380400001)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 	=?us-ascii?Q?se8hD9hWqmLZzQ9Znlyg2E1xJmu6bbNPqd8vF5BUgBH0cJNDKS53y0Ev4m6w?=
 =?us-ascii?Q?NubecR0A7E2ylPybBQU+FGQm1SWbKiEGuHdtb/2zCFHykvyBj1gh9KVqv2sI?=
 =?us-ascii?Q?5uVejyLPam4plBWh3MUx5SpPeTLAS8JHsEArjH2+3OMWTYMeg+c2kfZl+FmU?=
 =?us-ascii?Q?gBXf/Cj5C5V83J9ZM9mpAaPIcZsdXH6iuu7ZrdrS5ue3qOmx5hgNWSV54eGf?=
 =?us-ascii?Q?FDRorOXw2XcIxqioTjdjVGIr08ICeIhg7R2D2nHHRsAFqWITc3uRFBTGi0GQ?=
 =?us-ascii?Q?KtR9utu3cDauzhbD7Gqy+wp6732zjpRa5x/Uw7E6pFnqStGdJDzJuvZDa0H4?=
 =?us-ascii?Q?tmrrGBqB5IwsZ8GwFHtkvHN8chWUtZoDz2oFIjV8kJU25+0tQClbxj2+Db/r?=
 =?us-ascii?Q?67OB7p5Bgh37LHhcoNVSvUkFOhkeYrwzG5fgrYxhEqySW7wRUZ4HiY4fKxR6?=
 =?us-ascii?Q?JY/52Ho1e/LGLu2StvMRiBHeTTDhszAoqQbX2ToXkxL4co7qrrRmd/3972YO?=
 =?us-ascii?Q?SU53HYfbLsC7l8BKQ/5LMPpu+q+ebgM2ZGj5lcPxI5j11+ZxUY6cxRpFxHYU?=
 =?us-ascii?Q?NwAMn18QmNtzBA2FSXfr0XUUeZv5m9pTMMgPhe/OI4exGqHoNk2Z3A0sr5UH?=
 =?us-ascii?Q?yQ9ugKR2Y2g5TgQ0Esj/ldTO33OV+ynoZQFJZKiefzkWCV4I8jQ7ubMY++Db?=
 =?us-ascii?Q?yXG4QMh9DhIoYneKjJBZkCe0Jx5CuKB/RZWIC+1T7abQ0tQe9nBP3K/PeUKu?=
 =?us-ascii?Q?xRZbV/c4lWx6IKtsLkdnKDdO2wQuC8jx8gfi+m559nj2NoWv5ZimFfR+MUr/?=
 =?us-ascii?Q?VfMct8MDI+9Oodo7OE0AhFR+SiJiHjvcSBOXeCfLp6ouWtPK+CeOJnzBUYbz?=
 =?us-ascii?Q?PGzoXM/nlxWFRMDde2MdWeaCyXvsss+EezCadIbCOpLeXH/Vc7xAdpHdIF0t?=
 =?us-ascii?Q?+hftO4pCyF8KTq81ruxnEgv6RP6V1tSyRXrHVxtP7OJa1gQPAnEFC/y5fr6y?=
 =?us-ascii?Q?g0Q6BAM/MP9YE/rYYkrBm/+a1oTein5w70fTi588BTlRwF6V6u8UQds2YKJJ?=
 =?us-ascii?Q?3TpasQB0KB+FbrHu8YdxT+L8orvfP/O3TSEnPcXfybgIsNrjf3o/qIoMLvwS?=
 =?us-ascii?Q?kGtiX5m9YKT9wf95yayYW35HbD6RWbKP4fNaRt3jR3q8v5lZHopDsEbSysAC?=
 =?us-ascii?Q?mOMNopTFnJRpeL8BCaNQrKNVWz+unsCyFFoYMllexqOXwFJUKLBKTV8f/Xk3?=
 =?us-ascii?Q?trmElqGspGovh05RwZeQVCxdw7XnQJ03gJeKP+Bn/3/mUOxl9pMaBLLz3uPa?=
 =?us-ascii?Q?o5XBxJsIJn5YvSW6KDQNFJBWQDccPCTqXgTd3n8YTuNsoF4zjm4hfCp5LCJP?=
 =?us-ascii?Q?HCBPwG8ibL/uKOd2g+SAo6a1VHn9wYud4RXCdkBzv0hDHGXt2RDVeSFBOOxm?=
 =?us-ascii?Q?vlWuBPvW3pu8MQxIotjym4G2vTrPArrwzl+qiKOSF2qg+siEZudcRnzHvadA?=
 =?us-ascii?Q?zEd7mdyhu8FwYx6ed1mkdo0F8GYkRIVyg4Rmee9J56C6TsR840Po0ty470Cv?=
 =?us-ascii?Q?i7fc0Q48CJnyy0GQ7QPf9c/D/9Br0YfQ0woT15Vs?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ccab9f40-da4d-48f9-b45b-08dab2848311
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2022 10:19:03.1530
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bAmt7gcaw1fLs2Ak5/Jbd3980ORqo0uqFBKfjB4v0l4xQCMK1jLuqNvsAAqI+18HCQSjljeb9Hp8g8ClqpzWAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7568
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221020_031907_145092_B7ECFCC0 
X-CRM114-Status: GOOD (  12.72  )
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

From: Ben Ben-Ishay <benishay@nvidia.com>

get_netdev_for_sock is a utility that is used to obtain
the net_device structure from a connected socket.

Later patches will use this for nvme-tcp DDP and DDP DDGST offloads.

Signed-off-by: Ben Ben-Ishay <benishay@nvidia.com>
Signed-off-by: Shai Malin <smalin@nvidia.com>
Signed-off-by: Aurelien Aptel <aaptel@nvidia.com>
---
 include/net/sock.h   | 23 +++++++++++++++++++++++
 net/tls/tls_device.c | 16 ----------------
 2 files changed, 23 insertions(+), 16 deletions(-)

diff --git a/include/net/sock.h b/include/net/sock.h
index 08038a385ef2..ef9ff0de610d 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -2962,6 +2962,29 @@ int sock_get_timeout(long timeo, void *optval, bool old_timeval);
 int sock_copy_user_timeval(struct __kernel_sock_timeval *tv,
 			   sockptr_t optval, int optlen, bool old_timeval);
 
+/**
+ * get_netdev_for_sock() - get net_device from a connected socket.
+ * @sk:	Connected socket.
+ *
+ * get_netdev_for_sock() is a utility that is used to obtain the net_device
+ * structure from a connected socket. This function assumes that the socket
+ * is already connected. This function is used by TLS and ULP DDP offloads.
+ */
+static inline struct net_device *get_netdev_for_sock(struct sock *sk)
+{
+	struct dst_entry *dst = sk_dst_get(sk);
+	struct net_device *netdev = NULL;
+
+	if (likely(dst)) {
+		netdev = netdev_sk_get_lowest_dev(dst->dev, sk);
+		dev_hold(netdev);
+	}
+
+	dst_release(dst);
+
+	return netdev;
+}
+
 static inline bool sk_is_readable(struct sock *sk)
 {
 	if (sk->sk_prot->sock_is_readable)
diff --git a/net/tls/tls_device.c b/net/tls/tls_device.c
index a03d66046ca3..1eb92dab4f34 100644
--- a/net/tls/tls_device.c
+++ b/net/tls/tls_device.c
@@ -120,22 +120,6 @@ static void tls_device_queue_ctx_destruction(struct tls_context *ctx)
 		tls_device_free_ctx(ctx);
 }
 
-/* We assume that the socket is already connected */
-static struct net_device *get_netdev_for_sock(struct sock *sk)
-{
-	struct dst_entry *dst = sk_dst_get(sk);
-	struct net_device *netdev = NULL;
-
-	if (likely(dst)) {
-		netdev = netdev_sk_get_lowest_dev(dst->dev, sk);
-		dev_hold(netdev);
-	}
-
-	dst_release(dst);
-
-	return netdev;
-}
-
 static void destroy_record(struct tls_record_info *record)
 {
 	int i;
-- 
2.31.1


