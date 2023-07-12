Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F57FC04FE0
	for <linux-nvme@archiver.kernel.org>; Wed, 12 Jul 2023 16:17:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-Type:
	Content-Transfer-Encoding:References:In-Reply-To:Message-Id:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=tGmikXlWpBVEdep+UFvuOmzap5BM5TCMJkrHiNELkv0=; b=2rAk/+ibNAO/K5o3YcbJ3Ro4n6
	8RSsrHTfnu1esjGqFzUa00DY2EKWK2APzoCN/FljKEY62iO+sWexvCSXymcJJwQl63+36KPokV9TJ
	sGduTGxEzwuuRyRgKuggCnr/Y00kGlDm42ljzWjMVz5JBaXuYjE98bQPuI21WzOxiLHX734MBuACq
	dleCALVUxL1J8QPUHLmUxvaxnG3VU5CX2mrsq20uZlOrmzW2fIEit8C+ZVNKsHvd/1jGUR3kaoo33
	pYaT1QksqStOqBZFQttA959MQ3ZUa6w1oNL/69cYLgl0wm2eS5G4Xb54Psd2DbrbAk23vvM73RO9M
	DLNXx2dw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qJcWk-000VzX-1h;
	Wed, 12 Jul 2023 16:17:18 +0000
Received: from mail-bn8nam12on20620.outbound.protection.outlook.com ([2a01:111:f400:fe5b::620] helo=NAM12-BN8-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qJcWY-000VK2-1y
	for linux-nvme@lists.infradead.org;
	Wed, 12 Jul 2023 16:17:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Uc6lFfoBaLj7p9SHnXjEN7wW6tpyHESFgnhjKAOf1+151/hWN8vTbUlGozpfA/Dhwy9VLXksJWJs74ojgixA9hidTj/ytRopn03ib3dncnMfcHHCmpo7Z40IeJ8sRcRUV6unNDZ0gjrq+w2u4I51ojZ9BAU9wbQmYPK7T3IRVPIPV4IZSgx7oW7PIxj4Udp5SodtzL82L65HMuxG7C7g3bJZrsqltw9TPwWdonfu5rrZ31iYYrqqUbdcKkGZfx51In28tKrEaMTW0/wTBvWh5fmREYfjelYC66fMWANamfaHfRM9IiZnzeMQJ8pYnhNtf9N2U604jN1HnpSpvvAgBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tGmikXlWpBVEdep+UFvuOmzap5BM5TCMJkrHiNELkv0=;
 b=bBHD0qVXI/D4qLfLqz+DRlxwjWslzXcLoiei637F5HoF4dVQHp1VhWGG1lT9mI7+SNjxTvWCREWRadJPW2cC+nplhvgUU4mlSMT9kYt48SDKfJ9bpbVBX9Yb7OB+D9QSJPBUZuAwDlx/F+b9aLoOneGMLOXBwPuXdjVH8o909sR1J16ASjHXnL3YTxyGN9IIlU7ptLnm8NItHSpjkp/7su8Ffj7Hhqo7u7T6xmWskKd7Xn5L8hCKkpYSiX1/vvk7FbtfhcXxe576C9F8XpbJo1QRbrTd073vsIjkUsE00Sa6ofy7N1jurOFhf27EeKIRuXwVg3LCYl74iGaQvEK5gA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tGmikXlWpBVEdep+UFvuOmzap5BM5TCMJkrHiNELkv0=;
 b=Cz1MhPVs96l9ctGZeVax7hZIcm5bx0CZCsKMvcBcPE6PZG+Y/AoFjkYuCXgNaXXx7XNJsai2tXzXewi7gKZ2eoLue1aJa6ZzqA49Bu3KQdvOcg48PZzQUJ/rVWMSBDoCre+eq836Eik+ooWpVLDnMLV6AkHu02SNS6hsXbivWzq1GAiZhGF+YRtGkBfPzW2D5MV1kacQm/qRl544bXDTAyHXtne+i7Sa03WgRRnwK3r97ZMBwEEpyD9svjVqtaYDKb0GS0Uaobs6RjAGQAv7EAmN7FjBvALGVUD7VbEz0mRX2gwBzloBzxGVPWn7ru4k2ImdU+G8j6UXiM5kOv3Q7A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com (2603:10b6:a03:45e::8)
 by PH7PR12MB7212.namprd12.prod.outlook.com (2603:10b6:510:207::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.20; Wed, 12 Jul
 2023 16:16:59 +0000
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::3f6a:7977:dcd4:9ad1]) by SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::3f6a:7977:dcd4:9ad1%4]) with mapi id 15.20.6588.017; Wed, 12 Jul 2023
 16:16:59 +0000
From: Aurelien Aptel <aaptel@nvidia.com>
To: linux-nvme@lists.infradead.org,
	netdev@vger.kernel.org,
	sagi@grimberg.me,
	hch@lst.de,
	kbusch@kernel.org,
	axboe@fb.com,
	chaitanyak@nvidia.com,
	davem@davemloft.net,
	kuba@kernel.org
Cc: Aurelien Aptel <aaptel@nvidia.com>,
	aurelien.aptel@gmail.com,
	smalin@nvidia.com,
	malin1024@gmail.com,
	ogerlitz@nvidia.com,
	yorayz@nvidia.com,
	borisp@nvidia.com,
	galshalom@nvidia.com,
	mgurtovoy@nvidia.com
Subject: [PATCH v12 06/26] net/tls,core: export get_netdev_for_sock
Date: Wed, 12 Jul 2023 16:14:53 +0000
Message-Id: <20230712161513.134860-7-aaptel@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230712161513.134860-1-aaptel@nvidia.com>
References: <20230712161513.134860-1-aaptel@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0212.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ac::11) To SJ1PR12MB6075.namprd12.prod.outlook.com
 (2603:10b6:a03:45e::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR12MB6075:EE_|PH7PR12MB7212:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f478113-2603-42d5-612b-08db82f36b75
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IHnES6+37eaFJ5MNQklelBTfvbys3aS3r1h0Ytq/ZkBsi1kAX5zVwLP82KkBk1BA4KnFVc8wGncPGdxayIeOEDwYlbRMMNEFgUlYWNXB8F1YJT/Zn/tkLJbEHsENe2acNaNlFUs3ugSxuxAYe8D5Unu/kWojvis6BeU1/FMMV9jYjFAxSAWBend4dhgQCoFnPF+6D/yFqONTxmCZ46n7UyqG3D8PR0ZpbNwZhqR30/KvXpO14Jfv0ivldG533j3H2jnZQOMAG20RF85j/xaklEF/qaj4jkg7KIGPjyqVZ8O0XrlPAokV+dEE8GG0n8RVta7dZ8lwFrlu2XeZfPKPILl7Ed15tkY9B/YahUBEnOrbXxUVMMbeUgqoa1cpxZWrtehwqfgn6Gs73zxemXSXNi+pWmJ0nxAk44R6BR1yuHwcL2cVukXGuRpdmkGn8D8FdLI34k0GMl3/Ju4ScVfFqZ+IvLsv8rECXeKnpiad8lMmqFDfPUGH3IKjtJz1wrKFBS9tP0ULkTf3E84LQtxJ+jsfEi8DjXGiatidl1ZtuiYf/63qvrtVhk7Lz0t2z3BT
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR12MB6075.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(366004)(136003)(346002)(376002)(396003)(451199021)(186003)(2616005)(86362001)(66476007)(66946007)(66556008)(316002)(83380400001)(107886003)(4326008)(6512007)(1076003)(26005)(6506007)(478600001)(2906002)(6486002)(36756003)(6666004)(38100700002)(41300700001)(7416002)(8676002)(8936002)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qSEn8Ln4LerD5/ZY3LXfh3cjYgXqwL+g6mqdUhApB9KlYzyB1P8Fhl97sjD2?=
 =?us-ascii?Q?heTBZFiHPK8jHQVtjSROYmYFeMAgxWdjzeXBtKlnYOGZ17fKnib2uyXzYkLx?=
 =?us-ascii?Q?cM8EnAQ3c4Ww3bIvtTckt4pIVmcPJJrZc6NpD6MoC5tPSwtGRpm+gwC19bIb?=
 =?us-ascii?Q?0wUHK6HgwxM0+MldgnOPKdRKED/IBTSLR+Pxsd2X4vhZWHahH0zzx83ccYhh?=
 =?us-ascii?Q?ORHNsEKIfQ0aJgzRcbiXS2N8KE/uIqQRpX7JtK7RW3+TsPDlvuPihyfDiAs0?=
 =?us-ascii?Q?ZdIRUG8mLtgBQON001OeO52MLPIomeJxsgs2kQ6JjQsZcjYs+G5GSTvxQ5x6?=
 =?us-ascii?Q?DvQogzTTaGXjX9FU4YkO4lo7bL9ElPt2UGh5LYGPbqMnBoHw2F/kBsYgtYBR?=
 =?us-ascii?Q?ICh23DedHeKVEzA5j4T/GJrLWbp1KBy26g8CMrkCEv7d/9yLyxArMuGRdMTE?=
 =?us-ascii?Q?UerVkzmoPQhexApjR3SoI9cE48O+VDErgJQ6MF7spu1KqhtwMSBjO1tLIZjd?=
 =?us-ascii?Q?5bNltxk/DeYJZOb1sLBE6SEDGsYmXUjdJ+sXo57BZd6T/AMRPIangfjWu0tL?=
 =?us-ascii?Q?DqFK4d+4zObLngfCuQoB5yXcU1TAtpX+HAxUCBJeBi6x1ESVv1rCwH6nTP96?=
 =?us-ascii?Q?dwAtzLhFNo8bF0fU2qa31QDDq/waxGR9p949xs1h3XlXhlgSjHpuy9D7xG8L?=
 =?us-ascii?Q?JngEHXFCOmiPldjIsXxkSFxZTclyHHqWzbCIMJy4Sz1LJgP9IU0WjEYfr/dz?=
 =?us-ascii?Q?3kdodYDp8KbwNvSRhTZoxwwb3KpKPFESTZzq+ykLoBg4zUROlPSs+jT3nh5D?=
 =?us-ascii?Q?zMTX7CLsUkbtAptUPcKdmRTvd4Guo23AH0fs5SQKXPlT/oqGgCeqo48TFUkS?=
 =?us-ascii?Q?hBwG2UcyhBFDked1nWJnSd4ojmPyQcV/8hFkwDpIU/FkMd+y46TMoYooQqjh?=
 =?us-ascii?Q?luT8ZpV7K9bO75ljm4nCYB2560Ie3rr/Xh+RZM9JqdrrwTvXE18tj5r2r6/+?=
 =?us-ascii?Q?yS+MqeS5h6GiwtEwZewNHShKjAy7Arm/w54GPUHt36NXgc6L+XJ7qw29h1Mp?=
 =?us-ascii?Q?OTSsIpLpat42a8urfKGLP8/h32rs96Q13bIKDABbO4NECMN1+r8REfOVd+QY?=
 =?us-ascii?Q?/AXGMGMUIdzKTMOAZr6BrrmIEmHJfM4rEJOAQw4WHmxTHpJTV15RA+uORQo1?=
 =?us-ascii?Q?jkgJSMpZfZVyePsCbBpxyJoN3e20uCSylqPu0Xomxky60wHXe5fMQGpy46mt?=
 =?us-ascii?Q?6Vp57EyHS1uSqcYHhAEmAK7rjutCsGgoy3jM8Tqzbels3LIxZcOCiyIlRbWi?=
 =?us-ascii?Q?dwrpynydx+j7OucyaPTslCLjV1iUytXy+RFIblWFaxDuYmO/LbKoYHQHQph0?=
 =?us-ascii?Q?CC7E1bSCzpfVWxDRR9tSxbF1J0iire4TooK4kZnph5KRvOuG7b+LlXabfdP1?=
 =?us-ascii?Q?Gql6fI1obZyACxwr2V8zAPgcDHPTWyz/q/+tDIYo7vL2X1fTVYhtELhKNCVb?=
 =?us-ascii?Q?PbbzMFrKibfWjfSnAiPz4BL8qfNfc4I8OwHZ6ThVkqPTPohBTMrtDUvNTpAx?=
 =?us-ascii?Q?NGDEXTi1rOc0N1Qk7+2Foi2VGkjEJVKQixEPIInD?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f478113-2603-42d5-612b-08db82f36b75
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2023 16:16:59.6797
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DTK6l2FWryEkZHyK1wuQtxsNeeXWE/HRP733dRW5ZkLlrsBTzFqji2ovarcoYecDoijbpvUuTMqlwaU/cN5naA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7212
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230712_091706_714251_1B6941C8 
X-CRM114-Status: GOOD (  13.63  )
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

* remove netdev_sk_get_lowest_dev() from net/core
* move get_netdev_for_sock() from net/tls to net/core

get_netdev_for_sock() is a utility that is used to obtain
the net_device structure from a connected socket.

Later patches will use this for nvme-tcp DDP and DDP DDGST offloads.

Suggested-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Ben Ben-Ishay <benishay@nvidia.com>
Signed-off-by: Shai Malin <smalin@nvidia.com>
Signed-off-by: Aurelien Aptel <aaptel@nvidia.com>
---
 include/linux/netdevice.h |  3 +--
 net/core/dev.c            | 26 +++++++++++++-------------
 net/tls/tls_device.c      | 16 ----------------
 3 files changed, 14 insertions(+), 31 deletions(-)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 26e25b2df6fa..30d634166972 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -3135,8 +3135,7 @@ int init_dummy_netdev(struct net_device *dev);
 struct net_device *netdev_get_xmit_slave(struct net_device *dev,
 					 struct sk_buff *skb,
 					 bool all_slaves);
-struct net_device *netdev_sk_get_lowest_dev(struct net_device *dev,
-					    struct sock *sk);
+struct net_device *get_netdev_for_sock(struct sock *sk);
 struct net_device *dev_get_by_index(struct net *net, int ifindex);
 struct net_device *__dev_get_by_index(struct net *net, int ifindex);
 struct net_device *netdev_get_by_index(struct net *net, int ifindex,
diff --git a/net/core/dev.c b/net/core/dev.c
index 69a3e544676c..683f560292ff 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -8151,27 +8151,27 @@ static struct net_device *netdev_sk_get_lower_dev(struct net_device *dev,
 }
 
 /**
- * netdev_sk_get_lowest_dev - Get the lowest device in chain given device and socket
- * @dev: device
+ * get_netdev_for_sock - Get the lowest device in socket
  * @sk: the socket
  *
- * %NULL is returned if no lower device is found.
+ * Assumes that the socket is already connected.
+ * Returns the lower device or %NULL if no lower device is found.
  */
-
-struct net_device *netdev_sk_get_lowest_dev(struct net_device *dev,
-					    struct sock *sk)
+struct net_device *get_netdev_for_sock(struct sock *sk)
 {
-	struct net_device *lower;
+	struct dst_entry *dst = sk_dst_get(sk);
+	struct net_device *dev, *lower;
 
-	lower = netdev_sk_get_lower_dev(dev, sk);
-	while (lower) {
+	if (unlikely(!dst))
+		return NULL;
+	dev = dst->dev;
+	while ((lower = netdev_sk_get_lower_dev(dev, sk)))
 		dev = lower;
-		lower = netdev_sk_get_lower_dev(dev, sk);
-	}
-
+	dev_hold(dev);
+	dst_release(dst);
 	return dev;
 }
-EXPORT_SYMBOL(netdev_sk_get_lowest_dev);
+EXPORT_SYMBOL_GPL(get_netdev_for_sock);
 
 static void netdev_adjacent_add_links(struct net_device *dev)
 {
diff --git a/net/tls/tls_device.c b/net/tls/tls_device.c
index 0906e3daed5b..245142f94c9c 100644
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
2.34.1


