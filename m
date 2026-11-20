Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08740606A32A
	for <linux-nvme@archiver.kernel.org>; Sat, 21 Nov 2026 16:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=Tq0SPwsX;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=JEKizbU2
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:Cc:To:
	In-Reply-To:References:Message-Id:Content-Transfer-Encoding:Content-Type:
	Subject:Date:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=M0/rHJKyNkkYtoCG+uw9pgVO/PkOCjE650UW66QdnHU=; b=Tq0SPwsXS3FFjV8RIopIz/RAHW
	BmiYysY87upD/XZhNaHvwpDnuLIz7BibuI/95vAu8ukibE2FHnQcDnD4m9X+K3E+4+FYO+Rlsyt0N
	30a5qFqQzqdW8+Zlu27zqm7yoNN51TIJ7hLf7H2NnDeczDC2DrzDh7HwoWg2YJJ0b7YoJ6aTbSWMi
	5yPasY2sOhuczBKh1da8D8B8R6dztjKWrn/M6rZXHecZH0gs8Ecr1pMBRMJ4BqfgWlZN9WF1g6+FK
	heKOIix/i1ySbXE6q7qOxTG+pXXAvud83BW07fLo6fdO3YeJm/RJ3b8VcyUahnOpn2ukyHDfCtTap
	9GfkbXSw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xUnbi-0000000HQ86-3T3l;
	Sat, 21 Nov 2026 16:06:31 +0000
Received: from mail-westusazlp170100005.outbound.protection.outlook.com ([2a01:111:f403:c001::5] helo=BYAPR05CU005.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xUHdV-0000000E7Sh-3HNx
	for linux-nvme@lists.infradead.org;
	Fri, 20 Nov 2026 05:58:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kj5Qw1shf3gMfiUoHUW87977iwqohE1VJ+BP9SNQxofDeVDHEdRkcyR5T1I+B5cLJJwCowpSyjpvzfOf2Za0eFDNukX0gy9DrVsUxqjMXwfkhVacfwoDcv9uv5kN+L18RIFNpJC1jdQA4lhqUP4Lke+OedhJkZ/o/LMMo+sxPwx7GrK/Gt0jrznNa9KFjwzBtZnMLOCHhaZ1Lsc64aTGSH1xSOPAQipzJsgyCYWYBNlajUhJq9ntFz51u5Yn/+PDQOdEOZteuPIL2LmFf6AkMUTXVVJJ5MLSSwdF5MLRIwswaEhzQwZWgGbhKv9RPJFrfMz6o3s9ZgqRGhs2FYtGxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M0/rHJKyNkkYtoCG+uw9pgVO/PkOCjE650UW66QdnHU=;
 b=S+SGy4P2EVXHqSV/LhXeYd4OYKt1/D0aYLQuf5IqHiBKAwVcFQQOhbEkPZcWnha2g4p2jhf9HpS9/4p8M+17qPQRNvxHM+EQNl97ciDDqrByXg5lXhpxaLkzPPZpwth1bGwUNt8lzHdfXXk9EHVLjLcen7Oe7Lc/URBA0bMPrPq/0xCgnOQoUSjdv7slzZHfJ6XIakkr8gcfUxBFaTuy8CvlOpR/6YLZ+DuiCzIyIz9IciNzYudqbXRkN/6bi2QBgWsmhzCeiIb2XOs3kqFNvOliCGQTekx2Fud8kIgTJq7HWdmDinV5BB07Rej7rKxXApPMi1m+JK1+1sqBF8djwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M0/rHJKyNkkYtoCG+uw9pgVO/PkOCjE650UW66QdnHU=;
 b=JEKizbU2yKq/FEmlOfiLEjwrrbgDzpHh+a0XIlMc/ETRYUNLqVWOfVsa3Qj3HIODP/z+xuI2sJqPWALs/tqVDJPODHXU5f7FAGem3wT4HyIZDarhwuEho/msucbp+tvOG7sdv8jyCeNqvyXr64Ck2A+P5HB1nE9MBmc6IfDWPBGDtKWPUMsLRBke8Disur4ajxZ9dN02SjGLxYiQKo0TtHMT8A0lYtwcAhTPdzpzAXRVvhJa2sZ5IJuykOzpG5Vl/JGJD65SimpEV/dJU630ivLkubtWSccOwUEctV9AX1SJwO7DXpLuhhL2S99/jgfUYmEukYj9obXWYIgo0MnvNQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB598757.namprd12.prod.outlook.com
 (2603:10b6:806:52d::14) by PH7PR12MB6717.namprd12.prod.outlook.com
 (2603:10b6:510:1b0::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Fri, 20 Nov
 2026 05:58:09 +0000
Received: from SA3PR12MB598757.namprd12.prod.outlook.com
 ([fe80::e206:100:5946:a777]) by SA3PR12MB598757.namprd12.prod.outlook.com
 ([fe80::e206:100:5946:a777%5]) with mapi id 15.21.0639.011; Fri, 20 Nov 2026
 05:58:09 +0000
From: Alistair Popple <apopple@nvidia.com>
Date: Fri, 20 Nov 2026 16:55:57 +1100
Subject: [PATCH v3 19/24] functionfs: convert to use the SGT mapping type
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261120-dma_mapping_type_v4-v3-19-c0183a409bdf@nvidia.com>
References: <20261120-dma_mapping_type_v4-v3-0-c0183a409bdf@nvidia.com>
In-Reply-To: <20261120-dma_mapping_type_v4-v3-0-c0183a409bdf@nvidia.com>
To: =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Sumit Semwal <sumit.semwal@linaro.org>, 
 =?utf-8?q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>, 
 Simona Vetter <simona.vetter@ffwll.ch>, 
 Matthew Brost <matthew.brost@intel.com>, 
 Vivek Kasireddy <vivek.kasireddy@intel.com>, 
 Dongwon Kim <dongwon.kim@intel.com>, Kevin Tian <kevin.tian@intel.com>, 
 Xu Yilun <yilun.xu@linux.intel.com>, 
 Karl Mehltretter <kmehltretter@gmail.com>, 
 Baolu Lu <baolu.lu@linux.intel.com>, 
 Felix Kuehling <felix.kuehling@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>, linux-kernel@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, intel-xe@lists.freedesktop.org, 
 amd-gfx@lists.freedesktop.org, linux-media@vger.kernel.org, 
 linaro-mm-sig@lists.linaro.org, linux-rdma@vger.kernel.org, 
 iommu@lists.linux.dev, Keith Busch <kbusch@kernel.org>, 
 Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, 
 Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Mina Almasry <almasrymina@google.com>, 
 netdev@vger.kernel.org, Alexey Kardashevskiy <aik@amd.com>, 
 zhipingz@meta.com, treding@nvidia.com, jhubbard@nvidia.com, 
 chaitanyak@nvidia.com, Jason Gunthorpe <jgg@ziepe.ca>, 
 Leon Romanovsky <leon@kernel.org>
Cc: Alistair Popple <apopple@nvidia.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795154186; l=1510;
 i=apopple@nvidia.com; s=20261105; h=from:subject:message-id;
 bh=g4leWszYYOYQTMOVM+S9TZAQhclgsr0zjj3FSJdFZn8=;
 b=Wu50Fn666ID5auV0XSr6FFoDMa2zAZtj8Pz7fXyR82grJyncaVum72bQLv91Kn6g7FC2l0LD9
 XNWWCDjU7gaAkaY6I6puKQRH+/iS1WVH6i5yxwVKfXlQ6fzBnxm3Lnz
X-Developer-Key: i=apopple@nvidia.com; a=ed25519;
 pk=WdWPT9rAq3YNfXldbGv1NSGVLGxzQGFGJvRUiShhNqs=
X-ClientProxiedBy: SY6PR01CA0131.ausprd01.prod.outlook.com
 (2603:10c6:10:1b9::7) To SA3PR12MB598757.namprd12.prod.outlook.com
 (2603:10b6:806:52d::14)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB598757:EE_|PH7PR12MB6717:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b0994c0-dfd9-46f1-0003-08df46cb40e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|7416014|23010399003|366016|921020|261102123227099003|261021121427099003|10067099003|11063799006|261021123027099003|56012099006|261026140227099003|261028144727099003|261022105027099003|261009223027099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: ZePuUammKkNp6vT+wTCt399kmyGyqCh76cFovP4CECroflY42bg4e5FWZVEpLuL+gEMrF/lSrqIGayQeIRMlk26uUZUQD02URmHxtkAqzp4X4kr4Tbus7r8Gt8M8/7fhK2tmMDHWKMEOF2iwaQuBW/bU45XVVfw4ghU3zBu0IiRHl163A57k5qvkag0aTASwJQpuc8CD26vuqqTtM48EouuQGBa+TnDdmpM7eBY428qo5wA6h3RoX+FuLIxSNpd7itODgSPBZuOoT9K9lLphlPDiCdrJUpRG9AEoi9uEqKVJSw3/SPMBPrcXWUzHmzOIKUIgiicgCag9uYiEfNdGovmEN0KB08SWXmWT4Pyrq5FIzX+5aVsjZme4D0WMm+61PGCWLxzZu/o1eo4MdbFjimmU8BaJy4GWoMOv1ginNexW4SRS230eWP+kX4XvTcTgaw2YrNpj7gwqrduAjgy0/YDK5wv6Z+vk7+UCjix8Z6KIct1obBbuICbUHghiOkNNAdRZi+i/MZufuTa+80rhWLk3KO6rD3rtLRg9iecvUBLchY2OvOkzWTfbqyCx3EGQKYyK+KJAxFcXDqcyRItsQ0XQbxzMUvXQ/CBwyZdwPBB2371iCIud/Xw8ui/A1v847zvcqkwj9xCbld5s9sNI7KQ90Tct/x4jAN9qf0KvCZbPoV/BSoFakDniWqK07HI9++dkRSki4AnwkCuqmeeD9A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB598757.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(23010399003)(366016)(921020)(261102123227099003)(261021121427099003)(10067099003)(11063799006)(261021123027099003)(56012099006)(261026140227099003)(261028144727099003)(261022105027099003)(261009223027099003)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QkkzRG0wZmRxMHdXeGorR1lib1VZZ0E3VlRBTDk5SnFuMWh1UjNhNFlDa0lo?=
 =?utf-8?B?OVA1TVY2TU4wUUMvVFZwa1MvK1BVS0Zid3QwRjd1WkV3UzVOWVRvT2xIaDgy?=
 =?utf-8?B?VlZSeDlLNnBUaUZMd2NnVCtyWU9SNzdtQzNCc3NuU0RuYXVlWXRvWllSUjM3?=
 =?utf-8?B?cEhweTd6ZUN1Mi81cjFhay9QQ05vMHlGWUdTNlUwWlRxS0hYTStCUkIrOXlD?=
 =?utf-8?B?aTBZYklvbkg1djRpUWVub3dLVS83cGI0TlJRTHFzd0JYd3EwNDBJZjdPeW5V?=
 =?utf-8?B?a2Nid2dkcFl0TWdtUVhFcVMvQ28ydW8wUUd1WFJQR0dGSlFhS001TkZGcldm?=
 =?utf-8?B?ZVdBRktEc2k5MndDRDVPN0p6MTUyVnRxanZjS3hubXRCcXRnSERobmVjK0Jj?=
 =?utf-8?B?YmpIaVpGcjgwQTR4YW1vbTFjL3VKTmluRjJLa05MYy9UWnBZaXVjaU4zRjRq?=
 =?utf-8?B?aUU4eXdnWEpNM0pqVGd3cmZqM3daUnduamxiS1pRc3prck9rQzBSQzFnaVp3?=
 =?utf-8?B?cmVsYTFYdTJETlNaWTFIemt6R1Vid2JrVTJHYmpLd1JYaCtqdmpmdTlIM0k4?=
 =?utf-8?B?VVl2TzBBWWFnVHFRUW1MNTVmRG01d05jazNSMEI5YUU1MFd4dVMzRlMrQnB6?=
 =?utf-8?B?RCtKZ0JjVU5LYm9HMUJpTHFNNGNydWh3alVOaVYrL3FtZ250ZmhDcDN0VUZu?=
 =?utf-8?B?ZzU0Mi9kUU9TWHY0cVdtbUFvcDlsWktRaXN3bzJkc0V4Ym9PUnBBR2ZoNDJN?=
 =?utf-8?B?SUJWeUtQakQwMU9WN011bEFRMWkrTFRNblZHZWtieit4ZjBmekhDN0ZqMTVR?=
 =?utf-8?B?QXdjS3hsdWtsTk9uOHBqSzl0dDVNdHAyYm9QVmFYM1VockJIUDIrQzM1dHE5?=
 =?utf-8?B?MldhVWVzVUpINDhlSXJQb0p2VnZRL2dmOFFFdEpvTmdIRUFtRFV3czdjVnky?=
 =?utf-8?B?T3Z1TVl3VVZEQkkvQUYvaTNsUTFOMCtxLzBtc2wrVVFibjdobUlSbEhVZm1T?=
 =?utf-8?B?Sy9kcDlvcktud0JXc0ZYKzVOVWJVUThWeFA5TWxjY3NySE1YVGsvNEZCQlhs?=
 =?utf-8?B?QTBab0ZyNDdDMU9GQkR5aGFiSHlWazNjT2p3TTUxOHhPUEFFU1RqTWxLTkYy?=
 =?utf-8?B?b0FWTXl6RXViOUdNbzAvNHZvTmk2cERiTmFOTXk0M25RQ2dScUxRTTRoMlJx?=
 =?utf-8?B?czZlZzArdm1kcHpiUnpVektTTGVCcm5HRUNNSXoxVE1sQmZ2VUVaR0paYnhH?=
 =?utf-8?B?RGY5VGV4dHVGVTF3NXBCY29CL1Jtc01QdkhKeFBDdjFwWCs3dFRDRXgrWFZN?=
 =?utf-8?B?Sys3QUJHUVgxNDFUeDU2MTE4ZnhPOG1LZUdtNUVTbmlZbjJwbHZyOEJhMUhs?=
 =?utf-8?B?TVN5OWhncGxxdzRCdWxlRmM1OW1TUVdvMW92aWZVVjJ4V21wczdsR2RVYWo0?=
 =?utf-8?B?TmhtZlFyTUhvUi9WRGYrb2RmM3hOVmpRcFVleDJXM2RTd211MS9VSXlLdEVh?=
 =?utf-8?B?VGRSd0s3c2w2ZVhXYUxxK3doMXJ6NVRMVjR4aFMrM3dHRkR6TGs4WllRaVU1?=
 =?utf-8?B?cnZsMUlOUWdPc01DeEtCUW1PYVQvUHkxeVA0eHpJTkZvWktkY0NzM05KaGNM?=
 =?utf-8?B?U00zZjI5RDBXQTNkUkRuWDVxUFNEcnI1RlpNdHpvN1hvS0FhblY1c2I2VmhS?=
 =?utf-8?B?dTVuN1VhREVsUEZDczlBWk43NGlyaHN2TXMxVkQ5RjlwQ0pCcXpxbEpCQUly?=
 =?utf-8?B?Q3VseUFBMVdWZU5xUFVscGtLbElhOFFDdWNiZ1ZGZUFTb2VlSG8raVc2WkZP?=
 =?utf-8?B?cjNBbEQzLzlIRFdkNEhQY2pzVFE2a0V3Q3FMWUFuQkpDaTdlMk5iRm9RdUhu?=
 =?utf-8?B?ZmVSVERKN1RoRXliekNPVVN0NWVBTERUdnVHS3Fpd3N3eFUvMWtXQTQrSE9K?=
 =?utf-8?B?U2creldQSkNPa3o5L0huNTV4akc0elhiNDRhZzJXU1Zaczlyay9FeTM3SGlt?=
 =?utf-8?B?T0kxOVBCVlA0Z1NlN2FQdGVqUDJXOEtwWkUwaWtyOW9nY0hBYk5IK3JQQjVo?=
 =?utf-8?B?dXRaMk04bDRoelJ2UmJqWkg5ZUFKUW55dHJIU0JlbE4rTjUzaHUyd0tXU3Fu?=
 =?utf-8?B?ZUp1QVE4Z2dEMXpycmVjdTV1c0FUWjA2WGRxNng3Yy80Vnl6Y3dyNnNETXQr?=
 =?utf-8?B?ZFo1QzlpdXZvaFd5YnFzTkwvNXhPdGp2bjQvZzVldGpCMkVMVWNZUW5kWDRu?=
 =?utf-8?B?M2c0ZjlEekNYSWZleGg2OFJuUTF5YzFxU2REenovUnJqbUVNeUswQS96MitH?=
 =?utf-8?B?TENVRE1idGM5UGpyV3B6Mm01NmtBbEZoelZTNzhHNGlNTUt4R0c3UT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b0994c0-dfd9-46f1-0003-08df46cb40e6
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB598757.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2026 05:58:09.3254
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FOCJ8GL+SHouDAkP925qj5X03rFju3GaYcR0vdP6YddhjrsyUYF7M4kapKH55zE1qBDGbQl7izv5160YTzGf5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6717
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261119_215813_878082_08C32E31 
X-CRM114-Status: GOOD (  12.81  )
X-Spam-Score: -2.1 (--)
X-Mailman-Approved-At: Sat, 21 Nov 2026 08:05:59 -0800
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Jason Gunthorpe <jgg@nvidia.com>

These importer helper functions should call dma_buf_sgt_dma_device() as
they are always working with SGTs.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Alistair Popple <apopple@nvidia.com>
---
 drivers/usb/gadget/function/f_fs.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/gadget/function/f_fs.c b/drivers/usb/gadget/function/f_fs.c
index 2f221d0a983f..1efadf2c0f73 100644
--- a/drivers/usb/gadget/function/f_fs.c
+++ b/drivers/usb/gadget/function/f_fs.c
@@ -16,6 +16,7 @@
 
 #include <linux/blkdev.h>
 #include <linux/dma-buf.h>
+#include <linux/dma-buf-mapping.h>
 #include <linux/dma-fence.h>
 #include <linux/dma-resv.h>
 #include <linux/pagemap.h>
@@ -1514,7 +1515,7 @@ ffs_dmabuf_find_attachment(struct ffs_epfile *epfile, struct dma_buf *dmabuf)
 	mutex_lock(&epfile->dmabufs_mutex);
 
 	list_for_each_entry(priv, &epfile->dmabufs, entry) {
-		if (priv->attach->dev == dev
+		if (dma_buf_sgt_dma_device(priv->attach) == dev
 		    && priv->attach->dmabuf == dmabuf) {
 			attach = priv->attach;
 			break;
@@ -1616,7 +1617,7 @@ static int ffs_dmabuf_detach(struct file *file, int fd)
 	mutex_lock(&epfile->dmabufs_mutex);
 
 	list_for_each_entry_safe(priv, tmp, &epfile->dmabufs, entry) {
-		if (priv->attach->dev == dev
+		if (dma_buf_sgt_dma_device(priv->attach) == dev
 		    && priv->attach->dmabuf == dmabuf) {
 			/* Cancel any pending transfer */
 			spin_lock_irq(&ffs->eps_lock);

-- 
2.54.0


