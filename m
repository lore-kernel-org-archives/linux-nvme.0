Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6DF0606A320
	for <linux-nvme@archiver.kernel.org>; Sat, 21 Nov 2026 16:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=fwitm4+B;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=M6UGIiEo
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:Cc:To:
	In-Reply-To:References:Message-Id:Content-Transfer-Encoding:Content-Type:
	Subject:Date:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=L59wo4PaXs89ZVWJC/mZumnrFEozQFJVheUhVb609hE=; b=fwitm4+BPg+G0Vw1Ob9KSoz2vB
	OUbM0W3HXBsqB3PCfgQILUef9xyp+s7aolyJ3O6LirDz3sd4zaizWSHlfhFK/25KIU5fa3ZM4SELn
	evYP4ZXdWP9xNss6mT+d7y+HRFE9WWZVetH7jvoDuTnkiqzC5ejJGGnyWwIfHE8mFpniGA0AK2nz5
	xSO8Q/ShijA2xSLQqUu2DD1s05o3ZmOZR6S9P3+28lbUjOIniKUjE6ZEVci58OL/9JnkLFicU34b+
	RocDwV/AHYcxmdA7lS0khE0lsbK7r4bzU4j+o4FqblZ94r8pb4+p7fCouItzfBEkiZ4TSBM+m9fJB
	gjm4Mh9w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xUnbg-0000000HQ30-23Pl;
	Sat, 21 Nov 2026 16:06:28 +0000
Received: from mail-southcentralusazlp170130001.outbound.protection.outlook.com ([2a01:111:f403:c10c::1] helo=SA9PR02CU001.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xUHdJ-0000000E7Q3-0csG
	for linux-nvme@lists.infradead.org;
	Fri, 20 Nov 2026 05:58:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QfVT2lV82+zOMZay7JaHybjU1TE5hApVR5GzSWUUMonf6gzzb1QsUBqWyQW8UpZnNnhftIVFWT/5CJu+0nhuFgkQGy7uWkk0DflwauuWmy70cYsF42gHTWYgXDM3zsYH7RJ+p1OY1jKuWaywmW/m2fD1Bn/QYL9FqlBea2tonVCBhEpufsq06k6CoK+j3CbQmoz+oYXHDWMVg8JQSr6zmDo1VKvkoX3a+XJyGvupSUkTTwYYefsrAyZrUXAoTI9m/JQLnK1xpqWVwWbC/1XOHvP2XsVB+wYmO8bbf7NGAukh4wlGEy3X1ODOKEsLgDtMsVMkS9EOCiE95mYLxF7oJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L59wo4PaXs89ZVWJC/mZumnrFEozQFJVheUhVb609hE=;
 b=iXNFEmW68VVPzMho+EFQXvoq2s6Y0e5J7Kq5Xer2844uZzTbZQp81suQsFxy2s2OypPQ4IUfPOvpvriGAg5Id5Yq7fPk3Xjlp/s6udzuHb1OeIkLAVqGqhyW3FONg0bx6NaK0cKQFUX5e6w5os0QXkQdERhLuZOHPxCHfNoauKesxSLog8ENWgsPzDrX8ruS4hVmVXoJV80u5PVriimKVmN6sEkpysidXBPHNNa2VNyU7DajSyw1JfdGDcaiiBPmSes5yucFGgg1b7ieDnDO0yQwXV0fU17SN5eKRVLIvZe65FWKTauo/dvBX9qcshMDsWfGUw7FwQYhFBbZvnEuCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L59wo4PaXs89ZVWJC/mZumnrFEozQFJVheUhVb609hE=;
 b=M6UGIiEoC3nb7Vo6UWECUk8yAoSWjTdeCFL3XW9/M3TMsMXguNKelJ8KZVWQtpnLNGqsVPM+Q9CEztZ9/vD4ya/yKpH6R8CjLw/hx06QWA9pecsIj+7+xeusHiMQSl8oQQVKc8xeZGOCdIvPTYfwU6F5I/8x6ljdaQyuyZtVSHFkkxCIHmBzw4W+l7ubFTVb/ENvIQf3nvYyFv2x/oWX8Gzf9u4YQea9O5lQma9/kXU2IVZsHseVZtqkTVq+N0NkYgP8b9fzgLJ1X0vxlTnEjFpk4JB6yyQWlktxHGMWVyMHjkS3d3HdxFAnfet0O/KyKOduCiHCzoFrfvjCbApp3A==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB598757.namprd12.prod.outlook.com
 (2603:10b6:806:52d::14) by IA0PR12MB7675.namprd12.prod.outlook.com
 (2603:10b6:208:433::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Fri, 20 Nov
 2026 05:57:53 +0000
Received: from SA3PR12MB598757.namprd12.prod.outlook.com
 ([fe80::e206:100:5946:a777]) by SA3PR12MB598757.namprd12.prod.outlook.com
 ([fe80::e206:100:5946:a777%5]) with mapi id 15.21.0639.011; Fri, 20 Nov 2026
 05:57:53 +0000
From: Alistair Popple <apopple@nvidia.com>
Date: Fri, 20 Nov 2026 16:55:54 +1100
Subject: [PATCH v3 16/24] drm/vmwgfx: Use match_mapping instead of dummy
 calls
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261120-dma_mapping_type_v4-v3-16-c0183a409bdf@nvidia.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795154186; l=2254;
 i=apopple@nvidia.com; s=20261105; h=from:subject:message-id;
 bh=N8Cz8s3LFNUxkaqgxPAF91k6HaUkzBxE7X9L+ZZp09M=;
 b=r6wPUpn3HpK6815ge7Bpuzkrgh2CgH1ZufRPsRYTjh1XwXo+fJyhW5j5ynCjtiFg6kQtoRbc+
 1cBM9yxkGsqD2GzDggrmNLgdX281xbJ+w+paksBylgQJNd1fBdbiCbW
X-Developer-Key: i=apopple@nvidia.com; a=ed25519;
 pk=WdWPT9rAq3YNfXldbGv1NSGVLGxzQGFGJvRUiShhNqs=
X-ClientProxiedBy: SY5P282CA0179.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:249::19) To SA3PR12MB598757.namprd12.prod.outlook.com
 (2603:10b6:806:52d::14)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB598757:EE_|IA0PR12MB7675:EE_
X-MS-Office365-Filtering-Correlation-Id: c1436d7c-87a1-4fca-4b72-08df46cb372f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|23010399003|7416014|366016|1800799024|921020|10067099003|11063799006|56012099006|261021123027099003|261028144727099003|261022105027099003|261026121527099003|261026140227099003|261021121427099003|261102130727099003|261102123227099003|261009223027099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: 8vOUbd37rhUKdcPsEodJF5sNtN+9ByHC9xHGvBvZUGuprewdzH4uSNKGZjXGqYfAHKaYjzmm4xbF+FGlSeeM2cn/D+oO7rFY6jIATbMiovBevHalXJ+mMabCltdynVPf717PIGlGOMNK2aIJ2B8GVu4Spur19LJ9/eXL3ajSHv6aD1yDuIJwm9odaUGS5Bs1t2AXuR0SnqFM8SJvb2jGQG0tmtZgm6OnWoLXqgl6aTcAhEzFG3FULh/rhlr6Wcg1sTjcENVvJt2VfX2szFChuMuZ6gaPdByiY9DwqUn9Jx1mlJh0svqwKyvUdn3n8Uix5AzqvoQD7JPAxSiYn5W9XOdDD9bZsSPiLAcnx/9K/IEUGVQYudVfdCo5ETUuRR9luEgAqAfBwqiYeUGBKt6BLTET96L3a3dPIcXmEQGmCssllfsXudWTG5bO6pXPgYpZHuR9R9Xij3C9GNCOVGnKtkKJ+tAs0q0PWSgwzFE3AE8PSUbLVgSZ56PStklSr5NJNVbF6Q4LR0CJMvsT4ow4qycX4+/E9iSBbz5wkoMiiDLXGTKRVUlHdzY5r821s9vbkoXh/TSQdoWlLKUxNEc6LSCLub/stSemG9GfphAAx2EURnks3VzBLF8wpeSlvDCdqY3S3ETs+l0bIUFSVILSHewrCB/e+9wCCXJsaD2RyzsimIgvzKMQki8gkuBPy+QEErAmhx1b+vlDcGfLJ6rVvQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB598757.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(7416014)(366016)(1800799024)(921020)(10067099003)(11063799006)(56012099006)(261021123027099003)(261028144727099003)(261022105027099003)(261026121527099003)(261026140227099003)(261021121427099003)(261102130727099003)(261102123227099003)(261009223027099003)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZGw1SkV0TjZXSnBqbU5yMjMwOUh6OXBndDBNQ0ViU2hMT3phc29aMW1ZRzdy?=
 =?utf-8?B?dENTVXRDb010VWpiaXVDZ2JtNHJtRmtBN2dTS0lHQnppYmlxUGVROHJnOTZz?=
 =?utf-8?B?R2hScGJsbmNzdERCTTFYbDJpSWNaTmZiK3BWT0JPWjlxZTcwVFJVVlI2Yzds?=
 =?utf-8?B?VnhmWkVaUkVIb3Zvd3Y3UWtVby8zMXZOOGZ3YUdIT2NXNTltU05nZGFOZlJp?=
 =?utf-8?B?alZCcjh2bFhOczZFNm9TQTZQSG15YjdWQW1oZzVacVdEelcwM2RkQ1ViSHVu?=
 =?utf-8?B?d1Rwci9Sc2k3UzRZeFlUaVByblhYZEVWVFVCbWl1eXlNUzNaRGI2cGFmWUR5?=
 =?utf-8?B?YjdVdDFBeGxvOC9WVEdIbmtLTXMxeFQyYjRoRENIZ3VvVHIwenNRWEs0V0Uv?=
 =?utf-8?B?aHVMbU9OVENyU0ltTDhKVWswUEkzREFLSkpFbHhENDBTdzdTOXQvK0ZwcmR1?=
 =?utf-8?B?WURwWHI4dTRidUV4RkhqcWN4SmFLZ3RoWlg3dExCRG44MHhNZFV6Z3VMVmo3?=
 =?utf-8?B?YWtYZlhFeUNncDlaMUxjZlZJYm03QnRoZFdXd0t0bk45dEZ6VGZaRWRKRnFW?=
 =?utf-8?B?dC9va3ZTV1hWQmU2VkkrTUJaaklKZ3ZqclcrR1hsV2ZoQ2NqcThwMVprcFd0?=
 =?utf-8?B?ZEc5TzlWMFJxTnFzMFNkdjdoWDJLdVFQSzdDaWRJTkU3bkRMaVdrdGlQMXY1?=
 =?utf-8?B?L0NwUkdoSUJNTHpMVE1UNkVqQkJneWRDWHdDa05Rckk5RFVPc0VualBqUUdX?=
 =?utf-8?B?TVNwcWVubnhkS3JFWi9LcER2dTZja0JCaXFqM280ZG80eVlNbmN4THY2MzQ4?=
 =?utf-8?B?czh6bEF1WkIwTHJKT0RTSnlzaHo4VVJhU2hJTmg3dFFDRVNjdjM1cXBRZVc5?=
 =?utf-8?B?WGtsa0NJNTVYTlhoY2RTODkwRU1lL0c4L3AxMEkxdzBoZGo1VHdnVDZ0aGpX?=
 =?utf-8?B?cXZPWUV6K3dJUUN4dGxXTWNoMWhsNUFXZnRnUnRBeUdPYTVmT3kvbVAxVjRj?=
 =?utf-8?B?U1JIajZDdGxhcVNtbUx1dnh3TCtIb1FubWxuQmxxMTlHc3V4Q20wUzZMQzBF?=
 =?utf-8?B?ZjJEdzZ0dnJZdVhWQkZCVWIrQlpUczR4K2VZeHduaXlFbmFPZVpBNWlESjBF?=
 =?utf-8?B?bmlLdXJwWkkxdStmbVFDR05KQ3ZxMHJjZkFsT0h2NEd6alB6YmEzaVRVSjhh?=
 =?utf-8?B?NVNCUmY2TFFENDVmSGdONnBMTUYrMHJnUkplM3hmbU5xZFc2MjIvL0cyM3VH?=
 =?utf-8?B?dzVwckwraTNFT2lyQURTWXJYV0NnZ3E4N2xxR1ZPQkkwVU1XcmJINFJ0QWE5?=
 =?utf-8?B?NkhiZUxGOHNJZlhEWFJHQTNBTUhxMkQzSnp1WjZ6eHNrV1dCdExQRXMvSjBV?=
 =?utf-8?B?TVhmdmsrS3JyS1BzNE1ycEViNkE4TVhFMllPcnNFb1dhZTY0UVVlT2ltNmlE?=
 =?utf-8?B?bzFCQUhaNVNXQ3RoekZUQi9KUTN5RnBDQVFVd0c3UnIybjhEd1dGamRoaXFN?=
 =?utf-8?B?dHo1Z29uUHJsemh1UHY0ZXk0dXBZZS9nSmZVRXR4MHVLL0hCVmtuS3Z1SGNW?=
 =?utf-8?B?bC9BSDJtTHVuZXVLcGRRdVUwclVramtJR0RiMDFJVGJLZVNGQXVybTVNSHZn?=
 =?utf-8?B?aTVMcWFGR01TRmVyYlZzbmhpU3hsL3dlcHpkOWFWNjRuTmREcXg3K2IwamVC?=
 =?utf-8?B?bkhmai90QlJwamZLVFh0MC9BaWtKK084bC9iSzRUK01yRCt1WGlzSzM4UEQ5?=
 =?utf-8?B?b2JtR0FucXpQOFozK2d2NnFLNmJFNWRrMGNhVEhuRUx6SnhCVUczZDl0a1lS?=
 =?utf-8?B?TEMwRGd6cXhCZHdGQWJpMjhydzg5T0FIdWRncWc1Y1dRbTNlZFJWVGlsN0Nr?=
 =?utf-8?B?TzZNdE41V3dEb3BkOE1jelpkSHhtRmk5bGE0Y3VzSHZ4WW03ZVZqdXJrbVpN?=
 =?utf-8?B?RCt5YVlGTlc1TTNENHh0dlJFeGlzZ3k4SlpiUlVONmY1K3krUDZ1ZGo3WVpi?=
 =?utf-8?B?dXZ3TlFvZmZiU2J2bEdiTEw2TlhSZVZmZnUvM3FhNm5NN0w4ZDBqcURySWFL?=
 =?utf-8?B?NTRUL0RKeUh0S1QrWlRMOFE0QTUydmZVT3lXQzA0YWU0Z0t4Wk9RcEdZTThr?=
 =?utf-8?B?S0RMbjIrZXFybUxIUVpJZEtNOUF1QVVSdFdESE9JUUlndEUzQzJZQlQvN0px?=
 =?utf-8?B?ckdoT2ltS1ZWTFIxOE1QU29tL0hjT0NZYWd4Q2tKVEhidytmRnN6bnBUTkFD?=
 =?utf-8?B?Qk41L05IdFpJUUx4bURMR2F3UHJXdlpEcVFlSUI3VllsVHJzZlRPakNpYWs5?=
 =?utf-8?B?M29rN1F2SHRqdSt1TUZoejluV0ZMZHpremllNk54U0IxOU5TL3dtQT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1436d7c-87a1-4fca-4b72-08df46cb372f
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB598757.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2026 05:57:53.0297
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RhvHqu1QMdLeHH7ert62FRTRhIBYZ09QRYZHv+WMmFQd6clDvKQWkGczNwx4YjClAQVtUnW1FIvl7YfKQDY0WQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7675
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261119_215801_223948_25638180 
X-CRM114-Status: GOOD (  12.66  )
X-Spam-Score: -2.1 (--)
X-Mailman-Approved-At: Sat, 21 Nov 2026 08:05:55 -0800
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

vmwgfx is creating a DMA-buf that cannot be attached by providing
always fail functions for dma_buf_ops.

The attach/detach callbacks are already optional inside DMA-buf, but
dma_buf_export() is checking for non-null map/unmap callbacks.

Instead use the mapping type interface and provide an always fail
match_mapping(). Remove the unused SGT and attach/detach functions, they
can never be called if match_mapping() fails.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Alistair Popple <apopple@nvidia.com>
---
 drivers/gpu/drm/vmwgfx/vmwgfx_prime.c | 32 +++++---------------------------
 1 file changed, 5 insertions(+), 27 deletions(-)

diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_prime.c b/drivers/gpu/drm/vmwgfx/vmwgfx_prime.c
index 598b90ac7590..90e4342a378d 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_prime.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_prime.c
@@ -35,41 +35,19 @@
 #include "vmwgfx_bo.h"
 #include "ttm_object.h"
 #include <linux/dma-buf.h>
+#include <linux/dma-buf-mapping.h>
 
 /*
- * DMA-BUF attach- and mapping methods. No need to implement
- * these until we have other virtual devices use them.
+ * No need to implement these until we have other virtual devices use them.
  */
-
-static int vmw_prime_map_attach(struct dma_buf *dma_buf,
-				struct dma_buf_attachment *attach)
-{
-	return -ENOSYS;
-}
-
-static void vmw_prime_map_detach(struct dma_buf *dma_buf,
-				 struct dma_buf_attachment *attach)
-{
-}
-
-static struct sg_table *vmw_prime_map_dma_buf(struct dma_buf_attachment *attach,
-					      enum dma_data_direction dir)
-{
-	return ERR_PTR(-ENOSYS);
-}
-
-static void vmw_prime_unmap_dma_buf(struct dma_buf_attachment *attach,
-				    struct sg_table *sgb,
-				    enum dma_data_direction dir)
+static int vmw_prime_match_mapping(struct dma_buf_match_args *args)
 {
+	return -EOPNOTSUPP;
 }
 
 const struct dma_buf_ops vmw_prime_dmabuf_ops =  {
-	.attach = vmw_prime_map_attach,
-	.detach = vmw_prime_map_detach,
-	.map_dma_buf = vmw_prime_map_dma_buf,
-	.unmap_dma_buf = vmw_prime_unmap_dma_buf,
 	.release = NULL,
+	.match_mapping = vmw_prime_match_mapping,
 };
 
 int vmw_prime_fd_to_handle(struct drm_device *dev,

-- 
2.54.0


