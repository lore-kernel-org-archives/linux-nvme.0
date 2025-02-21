Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F35EC021B6
	for <linux-nvme@archiver.kernel.org>; Fri, 21 Feb 2025 10:07:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-Type:
	Content-Transfer-Encoding:References:In-Reply-To:Message-Id:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=EmUmXa/h84STnkxmlmVdHSs4qiAdNSquzo7hY4S5Ebw=; b=ocHxZYj7VvJcZ/eTb4TdpfTpeV
	FZxqiJatx1ZWYk+9daXczAqmCkOHKtjHFfRm2Vvc7AcfntZYk8znTxkfWn89ylR0PTHr38gKCkLCd
	gn8l51wbJVMzKWS3gONubRXLLB/XSmn20pHBL9S/kJt9N2RgN1ucwJMmbSib11898O7LeH2PfcmjD
	Ris1J95wh7ehN0ZpXNgXErMTz0FsS3ILanVwx7TRFE3/bRDIdb6LF0UmxB5JjhyB5/0IsBU62ZpQ9
	MnAJwY6fMJSFOyviquZqjX3YwNljHX/GS5wHFBBxRnCIkel/uuV6Fxil+PDE/XCA2bvsLbuDBQrQP
	3qMkFVoA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tlPwm-000000054oJ-0Z2I;
	Fri, 21 Feb 2025 10:07:52 +0000
Received: from mail-bn8nam04on20626.outbound.protection.outlook.com ([2a01:111:f403:2408::626] helo=NAM04-BN8-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tlPiV-000000051hL-1GOA
	for linux-nvme@lists.infradead.org;
	Fri, 21 Feb 2025 09:53:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p8/5YhMr9x5jkE2m/XqqiayxND22D/Nvzanfyle/tSzQWR1kD8jCQjwehz/OcjyMk6kKc2USLqAc3S+9yZZJojUG8UZAeOBjJlwAejXyzsHbBP4MPjYJR0qzO0NnTrQyUsw0Ra1xEgZ/GxF40T+TTnwkPwBmKncLt//6FGNKCOdAYAkOiwIbGjdZePtjNGrNUpxl9P8F9WfXv8Zgxub8aujUZemuMw4dyaGsPrhp+dbRMmg+ClRm7XnIgLjhyZXZ+NiCSt+1/M80qfNq8XiX7PNmRl/sMNomVg534YXAEuvtjjHrgqYlYUBPrdlxAZNFuo+EyiTSrfWtna4vrH5/4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EmUmXa/h84STnkxmlmVdHSs4qiAdNSquzo7hY4S5Ebw=;
 b=rMAdtMn3mAWz6HRnB2Lly7ws6FMMpHi6410Ygn2sIbUf0+khaKICTq8OhAycRYiLnf2YITlE9FvrqGWG2iE9sVlBOBo+km5oWbHa36VfB3d1mF57/hymagn3CzaomnRPrYK6rMinWc7QpuKOVv/5x7BT3CDjFzsDAV5/fn5ZHmmeiwhugVuwG3u3/nnTPsocTvd77uDcClVWZ47MUZH7L3oRgCZJhjl/E4NlQIxicqT3crM0wMVkrIZGcU+X8lPuHOuAn+WwTC2uOAjvSRrMHLkvTgrWj64WOOeazQtt3rQlA41H5uvnZto8VL0n/9+k5iNDCr+sIctBQ2k+tftisQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EmUmXa/h84STnkxmlmVdHSs4qiAdNSquzo7hY4S5Ebw=;
 b=c8Y64LqnAK18HBTcs6KmXKv+vi+l+j3GbMHSEyjM3bXKsOzLFrroXIspWx2ZDovHRtI0dvb+k+IvtO4zrCAH2fIc7HjmMwDV+WbnNkVuv2ObnGQA+m5814BEN7fgSDZsBvvLESE9u9kYaPgrupFx1HUMsMPpi5bfFjQrX177plshKNbRW31EGoMS32k3VRfaY2iRnS9T2f5CL0pnLllahgMStFWMP7KW/wedJrU2HjH36AmSX4TBWHL+ThnaxSqd1fyU8lWfdJerj4viNOKO0mF4bCne/5eWZns/GIv6FrvSjLI5efrjYl6Gmn1oq6+NE6aGp719g88YUKRx7SpGHg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB8943.namprd12.prod.outlook.com (2603:10b6:a03:547::17)
 by PH7PR12MB9127.namprd12.prod.outlook.com (2603:10b6:510:2f6::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.15; Fri, 21 Feb
 2025 09:53:05 +0000
Received: from SJ2PR12MB8943.namprd12.prod.outlook.com
 ([fe80::7577:f32f:798c:87cc]) by SJ2PR12MB8943.namprd12.prod.outlook.com
 ([fe80::7577:f32f:798c:87cc%5]) with mapi id 15.20.8466.016; Fri, 21 Feb 2025
 09:53:05 +0000
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
	mgurtovoy@nvidia.com,
	edumazet@google.com,
	pabeni@redhat.com,
	john.fastabend@gmail.com,
	daniel@iogearbox.net
Subject: [PATCH v26 04/20] net/tls,core: export get_netdev_for_sock
Date: Fri, 21 Feb 2025 09:52:09 +0000
Message-Id: <20250221095225.2159-5-aaptel@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250221095225.2159-1-aaptel@nvidia.com>
References: <20250221095225.2159-1-aaptel@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO0P123CA0004.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:354::9) To SJ2PR12MB8943.namprd12.prod.outlook.com
 (2603:10b6:a03:547::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8943:EE_|PH7PR12MB9127:EE_
X-MS-Office365-Filtering-Correlation-Id: eaa9b991-562a-4683-fb0f-08dd525d89bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?psm8k8usCxuEE2lbn/spteVMZv9hXHP4mkyGb2n+3QgRQIyaa+jmkpGxnK1S?=
 =?us-ascii?Q?5PyQFIjJCuCeHVJ5tRKZyls7gzO7U7LYZtGLcs2TOweT1/obDW0ROe9srvjb?=
 =?us-ascii?Q?o/f8m4Kv5Itj57vmuF9FgE3M85ECqlK9jNIbpwn2Qx6Ntab4R0452M34Oedz?=
 =?us-ascii?Q?00H8wn/1ZNuyuAnTrQpJxYyHu5PKJGWPdnfRhUu0v7THcQn6ETp0rpVfWQCJ?=
 =?us-ascii?Q?8fteDo5uPEwv2Wn7WXi2AxbkwFaPjchhLAqjIAnGqN6mDJBH+NT1Gsh20A1i?=
 =?us-ascii?Q?+GSAIRj9aT59qUmNVUORSrleMYE2bGyK66oPUteucgC/rwtf95wPXW1WMRJZ?=
 =?us-ascii?Q?vZi+ODt/Wh1H6FRMuD/F6qfcPzWpTRu7zWA+XDX2lfAopYp0qAKU1exWVQ+y?=
 =?us-ascii?Q?J9d9xP3sk8j8Ho2U4kebuY4FTnXKtde2q3jQYRO7zkZsvGbQU9f/86l3hEOm?=
 =?us-ascii?Q?DQyLHdAge6nMpyqrgZC5X0cxITYnqLGZZPci5/8oZ0OUgXNajtACCpP+nchY?=
 =?us-ascii?Q?vEq8uPU1Jh4FrTtuYlePsVr33S98cJHwGGqzKba6BzBdDy+qcFP/NoSs4Izw?=
 =?us-ascii?Q?7SUCpWVZ09zOWyoYWIfyQKJINkYqAlu7TglOMpFWoOPTGCyJkPnTUTDjb1Cy?=
 =?us-ascii?Q?QrdgT9iXweghTStWU9AR03A0yORYi0IGrjJF7YR64JUoe0BRAelNTwCMdOi7?=
 =?us-ascii?Q?7/jhxhFusmOftJEltO59MBt5CS31TMwCpG/YTfu7lnXttc59VxLTDvr9cRUw?=
 =?us-ascii?Q?aHRtNDpwdcZEfuCRndeFrn8rqmIxq1lLHvQjZHQJz9pyRrGZOngKse4u0Ez3?=
 =?us-ascii?Q?QDMvsrhjwHumTL6p1npD90l58OlhzHPmmX6WBWaetepVZP18WEYp2snu59da?=
 =?us-ascii?Q?BeXf2Oez0lSOlTHcNnBFd6lHbXDjwEY9j97akIGqzUGUm/RTtFr8P8nQBxs8?=
 =?us-ascii?Q?GrD/Fen2UGoa0XkqHKM55KpWus4F5iGf5XA6x3anx0jrjMAI4U+8U2yPgm5S?=
 =?us-ascii?Q?AwxArttbN9jvxA8HX9n/2lKYc/Zy3imxMPLQ3Qm1Fez7IWPViDo/+eFdflGe?=
 =?us-ascii?Q?OY5G/LVOrfCJEzr4IGgUZhQPPYK86f0CB6kiMNcis29EYv3GmUtJM+n/9kf0?=
 =?us-ascii?Q?ja8lyvlLzvFSgL1owsNckoJfRBsJf05TAgASSY5mDr6qSL4GCrvy1DjT2kjY?=
 =?us-ascii?Q?wHWvwMlqmsKHgqnO05Fo5QeInzWArIGe28JCzaxqntAgn+KCN0YsNM7BLbe7?=
 =?us-ascii?Q?0ttpfmyS0ALNccurwoEhVd94dMNI21hhVHbIK4y/g3TLzKGTaejEJrcXK0sE?=
 =?us-ascii?Q?Feyrlb86ZbNu9Owmv1kH/WdR960q8hFa+0VjRFCQdO8xcUgTFo+DCOFtGqUg?=
 =?us-ascii?Q?bb6TUzBPnmbU8pZwrDaJ7HXM0FrC?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8943.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?aF12LPMbdEC332G+8WlvVQKvFzTFbKJ77aS2ecLGHRWMysJnS8nK+zEYdf+p?=
 =?us-ascii?Q?Aw4cGsiNm2qRSfT07RKfm4EY1F4ZLydimu5cZdhIEpiyaAYQF9l7hh+XrnBe?=
 =?us-ascii?Q?tT4eYHHvqyoBLvoS7Qd8aw13V+I2QLZ3ptJDMuNort61W/nARvjF7wptQNJe?=
 =?us-ascii?Q?7a3uQVWizp/U1qoZzm/wAv7O+6dlILO4MOYwum0d4C6jlcyKiFN1BtiWatZe?=
 =?us-ascii?Q?lcHJ4TiaS0m3ZUU0Mk+8Lpsu5lD9WB010vwoL69s/0ZH/c6Jjvik6MdviCft?=
 =?us-ascii?Q?laXkbC0pINH+ztfgv/T8D5fGcwjYPoWE/gGZ7+JsIcL+uQIcFFyVJB0dP73E?=
 =?us-ascii?Q?ywY+sdVKBPTsMKWYGANH+r1GQOTehMD0OYd0/EzrYySZXRhcDJysa5rS+yeZ?=
 =?us-ascii?Q?yLtnwbmPWgAVPLxe+VGn06HO/38agqsMN8kBcOjrCrnr02hKej9GBvEcN1AX?=
 =?us-ascii?Q?57oqe68Nw064uCRo9Sa4jYdM877TLgmsxAexuNvjScrMdai8n1jWEaB3Hq/W?=
 =?us-ascii?Q?Ut6sW/OAfo8qoOCHZV9DQBS/7lL0t9Ou97tdMmcj5tbRplibruYxPF/10hgz?=
 =?us-ascii?Q?cUyFsS3z3UizNYvq9rjJx9ZNiWvnrOv8f0KNkxOK+yD9Hw2iXOJMdNyFQWDz?=
 =?us-ascii?Q?NyqqH/l129XAVkbFwQF1TXjVWeUBrRZ4c7RjsD79Vw/cJRRdUDAB+uagpncx?=
 =?us-ascii?Q?f+m95nxX6SdAJxR1QUKD0fDUl2IUnHf6N+5pgcVVM9ltYEafW7Hb5J0mKGcl?=
 =?us-ascii?Q?azcWIOxpE60ZACl5WpoRn93r3GuJAYIEybwNaxeZDWis4k82VTHMavox4/kV?=
 =?us-ascii?Q?X8DDyvDwLzKI/feTQiF/oyssRrLFhDUMuE7VOjXYE8X4PgtqvWpfHv4JVv1X?=
 =?us-ascii?Q?b1bSL7pg8qfzWef6ZKyhA6AGhP0aBRAgQy0ywABXsY+pnffmXx7jkT8yVbN6?=
 =?us-ascii?Q?iMxfOeGRm9aFU1FQsqOxorK1NKCD9qI+WYxwnX86Mh3B/3adA7SwmeCO+qOV?=
 =?us-ascii?Q?kwLajQhJ1WDHevwH6zGip76aihPT+dcReR/6XoyOeUhKklnz+bdv4tGhJE3n?=
 =?us-ascii?Q?HnO1WAhHK143oLa0J4KA05V9/RnrFWL/Bo4QbwL4zUC1QsZ4KV0nXCVIvOah?=
 =?us-ascii?Q?usLww7UQ2nyd+tqStkEBiVCDIbqAzUYjoOkzOmSDjXnDSltZrkGpF8h4HkVG?=
 =?us-ascii?Q?OepmDuNOCSdKZhhI5cbSFyWCGtF8Qz5M+KAIsuquSkWtwvWDmJAFSYMD1d1D?=
 =?us-ascii?Q?rfp1Q4LJB7YhF0Cf4NWEfh5gbHlYKJkPZ0T42X4/TyBIIrW2DIeyOShMzauZ?=
 =?us-ascii?Q?ghtoXdq/H0NofKTRZh2zjSNCaYdI/aZWqGw6/mmbNA+uj9/XYhks/CheLm6h?=
 =?us-ascii?Q?NHmAriKXx44KS4z7w6YPO1Y1CojVmxQWVrABkmtaTyERz5jXB/EkxbMCMJLA?=
 =?us-ascii?Q?UQ379nXe9hfS+sTIbtW+NXZbr62pIZsHqf4wQv6F7DvH1RIbQki0eqh3Id3p?=
 =?us-ascii?Q?XmuEpW3fsywwosbrFDDbVESUsLvfezGp3qYWMlR2sfmaGn+A4eg6m7BqMMWi?=
 =?us-ascii?Q?yoR7bppGNs/lHlgJfIqentaqr41bYdC2qqaDPexB?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eaa9b991-562a-4683-fb0f-08dd525d89bd
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8943.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2025 09:53:05.3741
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sjW3o5i8WQbEoOE7h7qWh4A/aPDGDtHPOUw+5VIq8JjkQBvIrWtqnq0uYB2xemihMeU7kXZPvuJoX8lTAJIGMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9127
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250221_015307_341368_3D94F1E3 
X-CRM114-Status: GOOD (  15.36  )
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
* update existing users in net/tls/tls_device.c

get_netdev_for_sock() is a utility that is used to obtain
the net_device structure from a connected socket.

Later patches will use this for nvme-tcp DDP and DDP DDGST offloads.

Suggested-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Ben Ben-Ishay <benishay@nvidia.com>
Signed-off-by: Shai Malin <smalin@nvidia.com>
Signed-off-by: Aurelien Aptel <aaptel@nvidia.com>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
---
 include/linux/netdevice.h |  5 +++--
 net/core/dev.c            | 32 ++++++++++++++++++++------------
 net/tls/tls_device.c      | 31 +++++++++----------------------
 3 files changed, 32 insertions(+), 36 deletions(-)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 405229e378ea..2880716e9595 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -3347,8 +3347,9 @@ void free_netdev(struct net_device *dev);
 struct net_device *netdev_get_xmit_slave(struct net_device *dev,
 					 struct sk_buff *skb,
 					 bool all_slaves);
-struct net_device *netdev_sk_get_lowest_dev(struct net_device *dev,
-					    struct sock *sk);
+struct net_device *get_netdev_for_sock(struct sock *sk,
+				       netdevice_tracker *tracker,
+				       gfp_t gfp);
 struct net_device *dev_get_by_index(struct net *net, int ifindex);
 struct net_device *__dev_get_by_index(struct net *net, int ifindex);
 struct net_device *netdev_get_by_index(struct net *net, int ifindex,
diff --git a/net/core/dev.c b/net/core/dev.c
index ebc000b56828..2aba27a62416 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -8797,27 +8797,35 @@ static struct net_device *netdev_sk_get_lower_dev(struct net_device *dev,
 }
 
 /**
- * netdev_sk_get_lowest_dev - Get the lowest device in chain given device and socket
- * @dev: device
+ * get_netdev_for_sock - Get the lowest device in socket
  * @sk: the socket
+ * @tracker: tracking object for the acquired reference
+ * @gfp: allocation flags for the tracker
  *
- * %NULL is returned if no lower device is found.
+ * Assumes that the socket is already connected.
+ * Returns the lower device or %NULL if no lower device is found.
  */
-
-struct net_device *netdev_sk_get_lowest_dev(struct net_device *dev,
-					    struct sock *sk)
+struct net_device *get_netdev_for_sock(struct sock *sk,
+				       netdevice_tracker *tracker,
+				       gfp_t gfp)
 {
-	struct net_device *lower;
+	struct dst_entry *dst = sk_dst_get(sk);
+	struct net_device *dev, *lower;
 
-	lower = netdev_sk_get_lower_dev(dev, sk);
-	while (lower) {
+	if (unlikely(!dst))
+		return NULL;
+
+	dev = dst->dev;
+	while ((lower = netdev_sk_get_lower_dev(dev, sk)))
 		dev = lower;
-		lower = netdev_sk_get_lower_dev(dev, sk);
-	}
+	if (is_vlan_dev(dev))
+		dev = vlan_dev_real_dev(dev);
 
+	netdev_hold(dev, tracker, gfp);
+	dst_release(dst);
 	return dev;
 }
-EXPORT_SYMBOL(netdev_sk_get_lowest_dev);
+EXPORT_SYMBOL_GPL(get_netdev_for_sock);
 
 static void netdev_adjacent_add_links(struct net_device *dev)
 {
diff --git a/net/tls/tls_device.c b/net/tls/tls_device.c
index e50b6e71df13..1a5c348a2991 100644
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
@@ -1060,6 +1044,7 @@ int tls_set_device_offload(struct sock *sk)
 	struct tls_offload_context_tx *offload_ctx;
 	const struct tls_cipher_desc *cipher_desc;
 	struct tls_crypto_info *crypto_info;
+	netdevice_tracker netdev_tracker;
 	struct tls_prot_info *prot;
 	struct net_device *netdev;
 	struct tls_context *ctx;
@@ -1072,7 +1057,7 @@ int tls_set_device_offload(struct sock *sk)
 	if (ctx->priv_ctx_tx)
 		return -EEXIST;
 
-	netdev = get_netdev_for_sock(sk);
+	netdev = get_netdev_for_sock(sk, &netdev_tracker, GFP_KERNEL);
 	if (!netdev) {
 		pr_err_ratelimited("%s: netdev not found\n", __func__);
 		return -EINVAL;
@@ -1166,7 +1151,7 @@ int tls_set_device_offload(struct sock *sk)
 	 * by the netdev's xmit function.
 	 */
 	smp_store_release(&sk->sk_validate_xmit_skb, tls_validate_xmit_skb);
-	dev_put(netdev);
+	netdev_put(netdev, &netdev_tracker);
 
 	return 0;
 
@@ -1180,7 +1165,7 @@ int tls_set_device_offload(struct sock *sk)
 free_marker_record:
 	kfree(start_marker_record);
 release_netdev:
-	dev_put(netdev);
+	netdev_put(netdev, &netdev_tracker);
 	return rc;
 }
 
@@ -1188,13 +1173,15 @@ int tls_set_device_offload_rx(struct sock *sk, struct tls_context *ctx)
 {
 	struct tls12_crypto_info_aes_gcm_128 *info;
 	struct tls_offload_context_rx *context;
+	netdevice_tracker netdev_tracker;
 	struct net_device *netdev;
+
 	int rc = 0;
 
 	if (ctx->crypto_recv.info.version != TLS_1_2_VERSION)
 		return -EOPNOTSUPP;
 
-	netdev = get_netdev_for_sock(sk);
+	netdev = get_netdev_for_sock(sk, &netdev_tracker, GFP_KERNEL);
 	if (!netdev) {
 		pr_err_ratelimited("%s: netdev not found\n", __func__);
 		return -EINVAL;
@@ -1243,7 +1230,7 @@ int tls_set_device_offload_rx(struct sock *sk, struct tls_context *ctx)
 	tls_device_attach(ctx, sk, netdev);
 	up_read(&device_offload_lock);
 
-	dev_put(netdev);
+	netdev_put(netdev, &netdev_tracker);
 
 	return 0;
 
@@ -1256,7 +1243,7 @@ int tls_set_device_offload_rx(struct sock *sk, struct tls_context *ctx)
 release_lock:
 	up_read(&device_offload_lock);
 release_netdev:
-	dev_put(netdev);
+	netdev_put(netdev, &netdev_tracker);
 	return rc;
 }
 
-- 
2.34.1


