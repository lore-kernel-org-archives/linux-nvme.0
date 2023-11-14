Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B649AC4167B
	for <linux-nvme@archiver.kernel.org>; Tue, 14 Nov 2023 12:43:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-Type:
	Content-Transfer-Encoding:References:In-Reply-To:Message-Id:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=DBWhjRMWENmzbh8QLanUB2GQj5WfzKlPq9b/jB1l1QU=; b=j5GBbvd1QkWzbaYLCzit+YpbdH
	j1GDkD155W29qCoId5gmyEkWJW8N9SjU9/dRCS0qM+ngp94Z7+anNKV6nPCpESDlNKt0v4zl3LNtw
	pbJGub//jMfXIpby9w4RqycZbZ1XJ1T9wHQbaJ101jAtykLG8XxI2CRXYWb7JPeNOhiALh28ql6Xa
	vPCHx9SaHWP05AZUMEKPnNpUa3+VVaVNx5lgRu1CN5L85pg5cOds/u/gLba5NubDd4dUtqb6CvYDF
	L9P+wey6aEzZtw/2mCpCj1VDPFtJ7fbw5haTcCcKdG8P1grOtIbIIIKGLSOhhN5qFozvsBTjfDuz8
	wtazB6Dw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r2slQ-00Fv1U-3B;
	Tue, 14 Nov 2023 12:43:32 +0000
Received: from mail-bn8nam12on20603.outbound.protection.outlook.com ([2a01:111:f400:fe5b::603] helo=NAM12-BN8-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r2slO-00Fux2-0t
	for linux-nvme@lists.infradead.org;
	Tue, 14 Nov 2023 12:43:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GXf4SnvpD9aa8SY62CTWtRSLVZAIyAYiv/3pH6mvuZRTvQzS2ty2jqUUTYjlKRFXx2Dx23DQlTWYqQFNxXInDWgBwW9HCKzm6wXGCxdGjDSUa/wSjAKoW0W94o7K3old153zMemWIxB6V/e59m3IYuFlFZnd8Qhw2aWWIeNX7RqhHoFo0ccTXo9okwDko8csp3Nc8UthTWhS2aL3OvdT8Me5bLsvDxSx29hqxB8157SOMzhG9wlNTms56KGNMNAdwYXfiixB1RSkBbPiOLUmJCvKbTWWSUT13OQuxJ7NSgTR0qwdlsm0+gZHpERNrVqPI/vMEj5YnBCp+yKeI9XQpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DBWhjRMWENmzbh8QLanUB2GQj5WfzKlPq9b/jB1l1QU=;
 b=KmJA50ybAPuN4lQtcMLZoGNwwE4mQEHrLvxEXmus3cwNfaNy9ZcyLag949gENiN+hI5kIWPpvEVD1748e1p+qEbrCmVoEXsOEoYCf9nGb//GUzgdMRx/CJDI5YCDEc6t3EJ0Igc8Kk+Oj08SICT2tUqRdAG8BBelet+/zcqIReKj5XA3mCq4+R8Dqeg1y3WwYipHdTr3CsyMqIpGpLJILV/AumFv0nIXW6+5gPDVoUd0eOKYvBM6Ma01xz73T8inYS6THU4FiN/Xt852SOX6c99zMetE1QV0Hu2JZSWNDfxpcb7OzvzDhyzgcTrKkWD1gwXqVoOup4qEl3ulW6Wp+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DBWhjRMWENmzbh8QLanUB2GQj5WfzKlPq9b/jB1l1QU=;
 b=TpY6a0QBA9NLjqf0rlor0uq9TO9gDVlHsajc22hVhru/mvG/9mGrrPmg7n5k476nRCfnAiaw4t7jpxBD/DkUKVUo4jm/PW/MfoRY2idlTDbRW8vVInWAT4FmofV0Tli0PCD4E0aUe7q9+rXhoZ188t0TtKdfGVtwdR2S+KphS++00rkTRnUFEEwMWLNLqo+u6d9UXczQkqNxdnkeTyXsPn11duszmdmIFEA3SALproh6E+OirUsKzDnWv7ntatM635kSSlKJ+ha6XufuYXBaHHJQmhKUT/tOj1HPNgxf8gw5ymnuZGctg+B0Vpt3hwwIYFmRcZQU8xW6f6vK6xIVhw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com (2603:10b6:a03:45e::8)
 by BL3PR12MB6476.namprd12.prod.outlook.com (2603:10b6:208:3bc::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.31; Tue, 14 Nov
 2023 12:43:24 +0000
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::42b4:7f1:b049:39b2]) by SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::42b4:7f1:b049:39b2%7]) with mapi id 15.20.6977.029; Tue, 14 Nov 2023
 12:43:24 +0000
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
Cc: aaptel@nvidia.com,
	aurelien.aptel@gmail.com,
	smalin@nvidia.com,
	malin1024@gmail.com,
	ogerlitz@nvidia.com,
	yorayz@nvidia.com,
	borisp@nvidia.com,
	galshalom@nvidia.com,
	mgurtovoy@nvidia.com,
	viro@zeniv.linux.org.uk
Subject: [PATCH v19 03/20] iov_iter: skip copy if src == dst for direct data placement
Date: Tue, 14 Nov 2023 12:42:37 +0000
Message-Id: <20231114124255.765473-4-aaptel@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231114124255.765473-1-aaptel@nvidia.com>
References: <20231114124255.765473-1-aaptel@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0237.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:b::33) To SJ1PR12MB6075.namprd12.prod.outlook.com
 (2603:10b6:a03:45e::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR12MB6075:EE_|BL3PR12MB6476:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c9ea449-88e9-4244-14a4-08dbe50f4ac0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mRe78zGkXt4Rf3fynwF2dWVIzxxkObEP1OlTYwaWs02gfexKNtUP/gBMBxDluDu5UBDhJr0F/lOW9XL7ZueGx3gisCFLBIMcoa/GpkoToI/e3KKr/Y3mjQY2j26YNYBHgilz1/XuViJxcJ8mGLZPAxwQDsuqIZ71q895Lwi1k0nDWOKQYnD/oAqRfzLGdL2lmTmZiZPAebC58vIx1fjwJCZJNSqVBok+IXALLZ+5wOmVEp5L/y/Dl3pz3hH6Y5NTQtJx8vMtBqY+iHUalqyF8kzw3LkEo+2FL+wbRmA/pt85akGM3MC4UcYJ32d+qlhYtk9GqUje+TCQeV0YJnNZYOObCXatsytu4/vyz+2mdXpdxZ1349yxsB29iPBOl9++C50wQFiXFG4zHdGUK8Zzz6L8+oWinGzg35sszRPMiwiLl48zwabQ8s+79ztycFWKf5ZXSSI50HcMCfv/a+ofrR+bTWA/ZZ0pSRCu/RkYOhJj8r7f4NEYbedJwSaFJg+MNAhAzEPnLJR52T5hbyM5/B8E6pLonNpZaL3tnJODP4WVxirr6H4rMj4gHzdSspkn
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR12MB6075.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(136003)(346002)(396003)(366004)(230922051799003)(451199024)(1800799009)(186009)(64100799003)(26005)(86362001)(1076003)(2616005)(2906002)(6506007)(6666004)(6512007)(83380400001)(8936002)(8676002)(4326008)(7416002)(41300700001)(5660300002)(6486002)(316002)(478600001)(66946007)(66476007)(66556008)(36756003)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?r2BUKVA+MUzZ2NZFlGApiRqQxvqgGjIdOYSW5RzzV1c810lh/I913rZo6bia?=
 =?us-ascii?Q?07PTQhtPJveokLobwGkhdSRcqf6KaPIl0fS6m56V9o7WsaaTY7mKR4Rlw7nM?=
 =?us-ascii?Q?uOg44JloAtq4HPZF73m7boCONLTOPRV7152CPNw9IYgL4tkLWUofJNDQ6ZlC?=
 =?us-ascii?Q?GwXAP5pRR3wTvMojBzDG7BV6qBbktMya6oWNOKSJlrH56HwU/we+1B8CSVQv?=
 =?us-ascii?Q?QkcA87oRsOAqJ3kZPuak+Dbyy0HZE35Ho8FxE98/0+ElD04wy2Ijo4oE7+8T?=
 =?us-ascii?Q?/epGeFOtHLBQm5F976qFqFnIw6k8yoGUUPLWgKB0qEtkL+R+vNRmR7s5vjfZ?=
 =?us-ascii?Q?vAQzjuQ0URzRFuluf4yiqwMt0pQs9PFhseBMPiMD7QcX4mXekBOnMaLqOWps?=
 =?us-ascii?Q?HCvcUHo3FcgcHyRQ9Vpp4bfIobJngk8r5iowausV25ccB3fMBhJM/rN538UF?=
 =?us-ascii?Q?tDUANkQCo/fVBKpdxU1XSyxKLA11GDAk8bdefWTSD0EiATQWvLRcDAlHXZMl?=
 =?us-ascii?Q?OJ7mWUnqIG2XHPXdiKsUk12YskwIrh5OTnsUZ9cWdMj1T1cU3WYzfnobzUoE?=
 =?us-ascii?Q?QR8MDhCvwsjr4MuXSBKMpvSNZ2w2QifGYQdA3AXar9MgKBGcdGzT+bDywnp+?=
 =?us-ascii?Q?j84OowUiaVJOg6IvXQRof90N6cDCfdAc5IR7ezl1TNzt0J894tXkhz5PL29P?=
 =?us-ascii?Q?YGFv3RxtjqpuneVpyctRKJ+m81VofKPkWnctdWnt7xdSQ/6/Gwkb4B7ZgOI/?=
 =?us-ascii?Q?kAjFmHneQoWuooAnOcK19rMnpISwa6mo/NHug3FQeqR/VzTKMKS5S2AFq9Jq?=
 =?us-ascii?Q?G5ZsrdHYGiq+BGTVdsy6TKj0iB5UqzLX4eybcPIigGnIktnuJrJKtwms/PC2?=
 =?us-ascii?Q?puKLE3mcTytM/ZGZ7ph4nQpIN6NTOHVHZ9R+jDBKfRUp6zglQQ3WUJSD4KuX?=
 =?us-ascii?Q?uhes6eTEXVvl8TZ5wN4uEKkqmsT7cE0UJnwxq2I7JrkVmbK76pIoiz9Q81XX?=
 =?us-ascii?Q?5AYfAHTRUnwkky/ZN7heS942BeIjrXZtuB4IiGdj1jhO37GPfPObhEEBo3Dw?=
 =?us-ascii?Q?eUu6OqLxFWyLzTvcELmX51S7Mmsqj2L43n2QzSeNLwZjEsSouZyzHZR9qv7T?=
 =?us-ascii?Q?7GSV1dPo+r9Di7rCHCwDizNOcs8k7Om0kcLDkUigHZud2eQx72MhIbq2iPby?=
 =?us-ascii?Q?e4QesSsolR5AShvnv0DSG2pK7sRyi60fkpztJi6Tv0HkaRyAZQp+c3jK96af?=
 =?us-ascii?Q?Wd1e/ZJkrLPz8FGGvIgDHOKgvqSCOHymjPNMly3gUGnIQfLZz7dQr3bC88/j?=
 =?us-ascii?Q?OiHB+F3hnmPCAtu4iLH2XI6EzjnvJNl3FhHG0hcm5i1ycssjUxoPV+SCrcsH?=
 =?us-ascii?Q?2bKNr/isqaDraDhZiWRq0nlLvds3nDdYw477H8IyEe/5KL7Ueb3kymS5evpI?=
 =?us-ascii?Q?RRKHS+QcdavDEjTl1qHy0fWkK3sLQbDfrGgbTgQXpyMYKIXjmkAQ158KP1Mp?=
 =?us-ascii?Q?1v5flrWbfmw9DuV6YlfKca4bQzP3qrEQfWdcOUj+JSAKTKjV8J4QvSuo/BlZ?=
 =?us-ascii?Q?NGE5/kcj3jhOzgDNQRKMmaoyKn+QMzpsZQAhvgy6?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c9ea449-88e9-4244-14a4-08dbe50f4ac0
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2023 12:43:24.7055
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H84ZBpCoTdHUJmo/oFxt+RbWkt0u2T95xCPbH9cndRELfQYVJ2XuMSzdi5hRPuvfu3pz/SDOBvN6gRaLVMrMvA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6476
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231114_044330_318468_50545DF5 
X-CRM114-Status: GOOD (  10.69  )
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

When using direct data placement (DDP) the NIC could write the payload
directly into the destination buffer and constructs SKBs such that
they point to this data. To skip copies when SKB data already resides
in the destination buffer we check if (src == dst), and skip the copy
when it's true.

Signed-off-by: Ben Ben-Ishay <benishay@nvidia.com>
Signed-off-by: Boris Pismenny <borisp@nvidia.com>
Signed-off-by: Or Gerlitz <ogerlitz@nvidia.com>
Signed-off-by: Yoray Zack <yorayz@nvidia.com>
Signed-off-by: Shai Malin <smalin@nvidia.com>
Signed-off-by: Aurelien Aptel <aaptel@nvidia.com>
Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
---
 lib/iov_iter.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index de7d11cf4c63..72049621aaa1 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -62,7 +62,14 @@ static __always_inline
 size_t memcpy_to_iter(void *iter_to, size_t progress,
 		      size_t len, void *from, void *priv2)
 {
-	memcpy(iter_to, from + progress, len);
+	/*
+	 * When using direct data placement (DDP) the hardware writes
+	 * data directly to the destination buffer, and constructs
+	 * IOVs such that they point to this data.
+	 * Thus, when the src == dst we skip the memcpy.
+	 */
+	if (iter_to != from + progress)
+		memcpy(iter_to, from + progress, len);
 	return 0;
 }
 
-- 
2.34.1


