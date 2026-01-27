Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F34BD2FED9
	for <linux-nvme@archiver.kernel.org>; Tue, 27 Jan 2026 19:59:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=nKA6grd9TSUxXHygtYoERb3nj6kHD+OMdXE+Y4uPQgc=; b=F7A4LI3wUeMh9ktjSKvoQQsLnf
	dv7Bez8YkGrs6EXP1mFFv7LEEU6EloeMhK8rQL3PDtPijnF3r1a3KNpYaiAs/nOxaQ7I8EV4xAGsB
	PJSQSDZFE2cb2o7xQ5MqUyKDgdoqNXbIfDlgd8ne5K3sS45KujA+QEZKAKBLRCSIGwu1iDtQ02Pm9
	S5SbTwaE/4KPEyGH6SEcJSmz9Sj1AUN0LmkpDWWQ/RxojlUNqgxA1KY4Edbfe9GbsvOfhY4x0IsJa
	xv75dNNoKl0uK/e1EX4KNJxpVgZqlD6YsN6XyPx5Mc9V9SwcEljatZTw+9oct0ZHkKnMRokRNpq7Z
	6KMkM7RQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vkpDe-0000000EyTJ-1PLw;
	Tue, 27 Jan 2026 19:59:22 +0000
Received: from mail-eastus2azon11010062.outbound.protection.outlook.com ([52.101.56.62] helo=BN1PR04CU002.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vkpDb-0000000EySb-2U6B
	for linux-nvme@lists.infradead.org;
	Tue, 27 Jan 2026 19:59:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HPgitN+J89ZxNCClSikbMmQZtGCOyFU2QEOfXjzlKplE4tbv9ueIwWj/7dxA4/6d3mxEF4OeUfb1mEo6TnuxDydNMfCSRkhMvZLIsfzCyDTUqC/CPefLq2f9pVi2vL6KHhxxs5A5Xq79h6wV7S4g3ftaRpMeIp5eBsMRBabSm2vWIvOLrl+8/4rq0zFlbu6GWzl4+Gp/LqwFMSvi+bGH/BZA4qf0Xd+EC+E3x1ZDu48+BLv3AK2ATIeBKcuBZiAdJwEgCYRJbmswzPhBn9uGdyVRkzfzdN4pHbBH4iYMHjSUqA+szkLdwSNxKEgLnbGffO1rUcbdNmmN8oZqCwS+aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nKA6grd9TSUxXHygtYoERb3nj6kHD+OMdXE+Y4uPQgc=;
 b=DIicVlHFC27XiWCEkFafx/BKqBRbPOShV8HYL7NbpWPAIKP449Z3fC+etw11nfjnERTiIG9Zh3G8nVJniRBZuYutpZmp8WoxqqAW6mldrHdQVErOsx14yHME7UzHN+83KGgfkPuFxa6DHvcp+tRhgFPgMrKht/nerDz5/MqPWcpYCEdgZHMoS4MEYqlbKj53c6kw9MHX0hNCG4JW1rfkFiKlcW0q+qPQWuHrHJ0OU6E+pr0QMRl/LKSrtrLqsl9GwPOrPUspMaAXWolxEJBllC+JPBvcMENosogKULRhPI4iwwcIgB3cU/uOs0opRxsgLIrJrIeHaoSjdncdelOD0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=citrix.com; dmarc=pass action=none header.from=citrix.com;
 dkim=pass header.d=citrix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=citrix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nKA6grd9TSUxXHygtYoERb3nj6kHD+OMdXE+Y4uPQgc=;
 b=k68wHbRc+Vu4EHVYgzO3elisQVgh/LVxCWA1qvbySpydvXeYm/jafS5r6BBe6djXFWX/QpHnfM7oHmHTL7VF3HmmHzyRJkdyQ6SoIiK8H2CmFTwKNIUlVuG2cHYP9YPa22nkCvQoTAnT5oijxWgarFO7e131eCqcLedXiTfrRns=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=citrix.com;
Received: from CH7PR03MB7860.namprd03.prod.outlook.com (2603:10b6:610:24e::14)
 by BY5PR03MB5201.namprd03.prod.outlook.com (2603:10b6:a03:221::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.16; Tue, 27 Jan
 2026 19:59:13 +0000
Received: from CH7PR03MB7860.namprd03.prod.outlook.com
 ([fe80::f5ba:35df:1c9f:b343]) by CH7PR03MB7860.namprd03.prod.outlook.com
 ([fe80::f5ba:35df:1c9f:b343%4]) with mapi id 15.20.9542.010; Tue, 27 Jan 2026
 19:59:12 +0000
From: Roger Pau Monne <roger.pau@citrix.com>
To: xen-devel@lists.xenproject.org,
	Jens Axboe <axboe@kernel.dk>,
	Keith Busch <kbusch@kernel.org>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Roger Pau Monne <roger.pau@citrix.com>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>
Subject: [PATCH] nvme-pci: fix parameter order in nvme_free_sgls() call
Date: Tue, 27 Jan 2026 20:59:06 +0100
Message-ID: <20260127195907.34563-1-roger.pau@citrix.com>
X-Mailer: git-send-email 2.51.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MR1P264CA0201.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:57::15) To CH7PR03MB7860.namprd03.prod.outlook.com
 (2603:10b6:610:24e::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH7PR03MB7860:EE_|BY5PR03MB5201:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d149d9d-85dc-48ac-8740-08de5dde8a99
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SGxaZmRrU1dCRktLNkYxMUpJaWUrNXZyWDVFSWUxc2hZSTdDSENwWEtXSXha?=
 =?utf-8?B?RW16WWN3OGk1RXhXSUZydWtnYTlrNUNlakcyUWNybElPclY4WUpuc0VoeFI2?=
 =?utf-8?B?RUJuNStZeVJPcGlkSCtPS2htTktYQnd0d0s3OWNTUjFRZjdsYTV0cDBBOEZz?=
 =?utf-8?B?VWxzblJFZ2ZxNFFsbTU4dWgrYjFma2ZOaFJYT0czUEN0bGFKRXR0a0Z3dHgx?=
 =?utf-8?B?MlJRODJ1VFhwakthTWpsODc1RytjWXlwWElHM0JZZEhLVlo0SUdVUXJFbUNS?=
 =?utf-8?B?MmNweVc0Rkg5ejNJMTFiem5QK2ppblUrbmVLYlBlKyt6ZzdXNDF3ZHl0NzZV?=
 =?utf-8?B?V2dZSnpVTTJ1TU9FWXUzVHhicDRFczcwc2NzNjdLM3J4ZzJzNFMzMHlRL1NK?=
 =?utf-8?B?WnJiSE1Qb0dKRi9ZbUp1TDVadHFGTEIzbUM1NGN0MzJpb1F3SWtzWWh0b1BV?=
 =?utf-8?B?VUZRbExrcmpva0prNVM3UWNEakdGZlZUOVc1RmZvbDNPeG82MnFRbk50bk96?=
 =?utf-8?B?ZDU1QW0vdXZLODRRTS9KK2syQ3I5YUNGdzh3bHJLNG42bXkwY3BvQVB0b1VT?=
 =?utf-8?B?Tk5taVROei9FY2o3NEVQUGQrVk1zOHZUbDg3UUk2dm5tbDNWeXhBVzRoZ3g4?=
 =?utf-8?B?djEvL2Q5YUdFQU1YSVc3MU85TXdLWnplSjdDTWxxQ2o4ZkI0Ymw0RDV6QlVj?=
 =?utf-8?B?aXEvZi84WWYxdHZKWmNlbmNvcUJkUlBqRHlBNkVVamEyZWtRSzdvUEt1WFMz?=
 =?utf-8?B?STVTRmQwMGZNeEpHa2JNamQxYVN4OHAzTC94SXAxQmFvU09za0FrMjNNc25S?=
 =?utf-8?B?dmswTHVKWC9NVTdNREgvbnpMUjZTMG1GdEUyeDFOSm5OcDl4QjMvUmlsWHVG?=
 =?utf-8?B?R1NaUHMyWEpEODJ3NnZOVHllb1JWb2xRVEV6L1hnNUJqQkVXTFYvNGpIclVH?=
 =?utf-8?B?eVRtOHJ1VWR3ZEZrTU9GU1F3RzdkLzI3dHRicEc1ZThLUWs0UUZpa3FacExS?=
 =?utf-8?B?OWFxUXNiUmloQ09FdDZzSkNxM1pLZTJ3TEVnWnp6M3Jhb3B1a1FnRXBhR3VW?=
 =?utf-8?B?L3I5ZG8rWElyZVRYaUU4UHZhRklPdUg0dWhNYWFkVEkxS29EdEpzenIzeVNX?=
 =?utf-8?B?TDBDaDl2NDB5OXczcHJlWnpnWHhRSUp2Y1hFU0NpamVNZ3cxbDhxRTBLSDh2?=
 =?utf-8?B?ZzFkL1hOYUp0WS9pMy9vUStZQll3OXlQdXBsN3JWUjlES1FqQkpZRTY2NGFs?=
 =?utf-8?B?Vmo3am9DYzMwc2JtUUVxYXNZZy9ydEZneEVjQ3BEU05HRk5BSUpyMVJxWVNM?=
 =?utf-8?B?WGExQklUdEdnb09iaVVuTWZERWVLRXNvTklsNlFwaGhQa0tpaEd3bjdKcm9a?=
 =?utf-8?B?bDJ3R21BS3RiN2Nwd1ZIYjV1SzNyRDNuNGxhUjRQNmQ2RVBIcHl6R1VLQk9j?=
 =?utf-8?B?c0VoaXVXUGdqZHZMQ3JUa0NqRHR5bjNzWXBQa3NvTlc1OHpWekg5SmdNcU1C?=
 =?utf-8?B?bVJYa1dmVFRDQkt5ckwwY3YvV1ZRYnFmaUk3V0pHMzZKd2xNL0lZUFBRSG5h?=
 =?utf-8?B?eFp5Y0J5d0dFWHNiZFpXVFFsWHVaZlYzd0U5M2djWXkvMDhNYzR5VEtYOXFm?=
 =?utf-8?B?OWZkc1JFOWdvcjVFK0thSk1ScGZlUkNXNkc4N3J3Vm4velArWS9qeDhGbWtG?=
 =?utf-8?B?TzkvVTZaMEVzTzlmczlvU0pudXZMaytyRFJQQlpqQmhzQzlRczRnOEd5MmZU?=
 =?utf-8?B?NzBCUU1GUUFKQkRqYnVtNis1dEh3UldUMG1WYkxGb3hEY2wzT3VjNkU3TUxq?=
 =?utf-8?B?ejZJVmt3UGRldTFIL3hBRlFEeEZCbHU3ajdmeFdwS1RiZ3hIZloxalpBOGVM?=
 =?utf-8?B?ZTFzeEJQMGEyUlRZNUkxZG9CUjFRVFB3SmtFSUhjQzVSSnJZQXVYRHB2SCtR?=
 =?utf-8?B?UUVzZTAvSDYxSktDckI1Nld1MGdSeDRiTDhCajFrSUZKNjEwQW9IZTJteWxx?=
 =?utf-8?B?aDF4L29jZTJKWGwxRmxObHg1RW9JcS9nRmg3Zm1SYjkyM1FmUjhra1NkaStU?=
 =?utf-8?B?ak1UVXY4UldwTlVqak42R3pTaE43VjRXUGVJZithVktqQktmMk53UWlVcFNm?=
 =?utf-8?Q?ujF4=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH7PR03MB7860.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dGdsWVczZDUwM1Jqa0ZWTHBPUmZXUEYybm5sRmdlNkp2QzFJQmhhSFZ2VVFi?=
 =?utf-8?B?a0FwYkU5UlB4Y1hCaGVDeHZmanRxNVVMMmxzNFkwdndwNks0YnNzRGVUb0d5?=
 =?utf-8?B?Mlh5dTRLNkxzd3Z2U3h1cCtIbDI3NVVmVEYxcXg3U281cU1BYlZlRGtuWENz?=
 =?utf-8?B?N2QxdnFrMnd1SjNCenJQS0RFTFZmNU1QOUJnV0pyOENHMU5oREhyb0NBTUVs?=
 =?utf-8?B?ZGd6RlliNlpvbW9jKzZsMmppQVVLRW5tMlFqa2d5TmRmcGN3bGFJcGNKS0d0?=
 =?utf-8?B?Y2k3alVRcHl2bG5Oa0tQckx3OE05MVZTdHV3VXNPV0NzYXZBK2ZvdWwwN0Fu?=
 =?utf-8?B?WkVjbDI5R3FxWVNmUnpkV3EveFRBUlhSMTBKWks3MGZML0Rxc3laZHgxMU1W?=
 =?utf-8?B?SXdiMHJUMDFtZHhDOEpvZXRNWksrMVQ4VnBtME1TR1RSS2xGZ1dkaHVtWlls?=
 =?utf-8?B?LzV1SE9RYzBWZTArejNNbEdYeGEzdmg5Vll4aHhvUEcwdUtvdU80UGh2M2pt?=
 =?utf-8?B?dXhUMWtvb0tDSjY0S3FIV1ZkZkphdDNuY0s2b3lmdXRRWnBzSm5aRUp5czNO?=
 =?utf-8?B?QU5PeDg0RTJnVDlLRzJSZ0p6QUhOTm4xNHVYN0lpRm1VV25CSjNXc0JQNzVU?=
 =?utf-8?B?SkxwYUp2aUhmZVJvVHJOdUhwYlgzV0ViRG56S1IzY0ZpaG05NXRvcmJwSTlh?=
 =?utf-8?B?N24yUkRrTitRM1FRUC9GejdSeEFtd3lwU2JSbERwNldId2c2cld0NDNNbklJ?=
 =?utf-8?B?UDVWdHNYTVRSS3pBWDZsSXM0bkRIZWhNZFllTWVUUG1PT29YaHgvaTllZUlr?=
 =?utf-8?B?a3NHVGovV2x1U243eUs2YzFEVUVlemVhUWZ1NlppUWdTY1FtZ1dPR3lqWlFz?=
 =?utf-8?B?L0kwNDV1VzdFanVwUTBNUndGY1VOby9ZWFhFenVPL1VjUVJzMFN0a29qVTBW?=
 =?utf-8?B?MFZBRHl2U1Q1cUtCNnV0cm9keDAzN0kyekp5WkR2SnlKTkowZzBHOUlIbTBX?=
 =?utf-8?B?MitONFB2a09aZTNoQ082eE9EcFNvL2lMM1dOMFlFN3FxNGhwV1QrSXl2aDJZ?=
 =?utf-8?B?QTN1NUlyekx6Z29hcmozZE9BV1piM1l2azUxRDFWWm1Ray9ZQXA4V24yQ1My?=
 =?utf-8?B?RklOV3ZOd2VOVDdZUWZ4VlpVaXVZWGF2NWNGb1BuM3kvcUQ0YUVBRjhGaStx?=
 =?utf-8?B?Y3dzVk40N0JkMjduL0QyKy9QeEliUUp5ZjJKMkNUVWNhTXZRUnJ5dzZ6Umlh?=
 =?utf-8?B?TDh5cm5BZzdlRmt6dTJKTW1STFlleGFQQ1k4azBzamFpMnBHZ1ZyTFlUNmFV?=
 =?utf-8?B?MWFkUTNiSzliTUQ2NHBWZmxuTmVDUW01dWh2Q1FRUjJpZDBuS0IyaENDb212?=
 =?utf-8?B?YmxxNlB3RkVLU3FKU0tkZ2VXSzV4RGdBQ2hKbllKSzRscFJpRzI3SnJjOUZZ?=
 =?utf-8?B?bnh5WWdBbCtpVklkcU9hVWdzMUZyQjNIRnkxdURRR3FISStXcy9OMTd3cHFn?=
 =?utf-8?B?bWZpL2hVK3U0Vms0UUR6aHQ4V2drQkhhcFlQWGplU0NhdlVOU2dLYllITDJk?=
 =?utf-8?B?U1Z3dWllZndnT0IyYmx6MVd4Lzl1RkxkK3c5YXl2VGcwTVV6OHhYYkNsa1Nh?=
 =?utf-8?B?VERkQVljZVllZmk2NERteUtFajVFcXpoZmNYbk1yUVJaVlplelBDR2M4b3Mx?=
 =?utf-8?B?blpkUmFLbGViSGpYcmpSeXlPb0hLSWt2RzhqRHVNR0d4SDZmbTNsdTFaV2la?=
 =?utf-8?B?dGk0cHJrU1lHNlNhSWs5N2ZCS3A1clIxVmpjTFlPMU4xR1JyUU5jVTJNRnoz?=
 =?utf-8?B?S3VOWndCa3JKS09GN3NpcmxxbnJJa3RteElFc0xsN2NLZEs0UlJoYkxPZGhm?=
 =?utf-8?B?emhabG04TVFPUWFHbW5HOFlzUFV2d2x2bFg4Rmh0bGhTdy8vRmdCV3VGanM0?=
 =?utf-8?B?aEI0dUtYR0IzajY0NkxYbHF4R1piZ1RzMUJ6RndhZ0E4OUVmbXZpbFBtU0JJ?=
 =?utf-8?B?eTB3RjlXMzM1MkdtSHVXTEZUVWxDWjBZdE41azNhZWovcFJZd0hCdk9BU2J4?=
 =?utf-8?B?S2N5cmttcnZOVGxUeXpaTlQ5elp5N1JKSkZ4WXR1dURHdTVYdjJkQ1Y4UnJt?=
 =?utf-8?B?dWpxOFNCSjZSK2lEL1djU1ZDWVVGOVEyMDNpb3IxckZyMm1BNjhtODhPQ2I4?=
 =?utf-8?B?bml5c3JJOTdJNytzNURQZXFQZmRFMkNFcmFGQTROcUhBcXFBU2p3OThOZ1l1?=
 =?utf-8?B?cjhYMlk4R1EwYVNPWm80VjZjc0dsOXArbUhVWm80RzBZUkl5QlY0dVhPMFBK?=
 =?utf-8?B?TjhMazlhbnNUUDUxUUdRN2xGUVhOcTFERGU1M29DQ2RBaDJCRnNLQT09?=
X-OriginatorOrg: citrix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d149d9d-85dc-48ac-8740-08de5dde8a99
X-MS-Exchange-CrossTenant-AuthSource: CH7PR03MB7860.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2026 19:59:12.8172
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335836de-42ef-43a2-b145-348c2ee9ca5b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DU7GSRHbA9f2Zh8k407/Dl1oo35XLP3FyiuO1r+gXwZ+3u08hRWvsIJft+fXieq7EVHa47bA6nMKFw7oLIv3Jw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR03MB5201
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260127_115919_648344_BD1461B1 
X-CRM114-Status: GOOD (  13.67  )
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

The call to nvme_free_sgls() in nvme_unmap_data() has the sg_list and sge
parameters swapped.  This wasn't noticed by the compiler because both share
the same type.  On a Xen PV hardware domain, and possibly any other
architectures that takes that path, this leads to corruption of the NVMe
contents.

Fixes: f0887e2a52d4 ("nvme-pci: create common sgl unmapping helper")
Signed-off-by: Roger Pau Monné <roger.pau@citrix.com>
---
If possible it would be good for this to go in 6.19.0-rc8, as corruption of
the root device as part of a kernel update is unexpected. Sadly 6.18
already contained this issue, and no-one noticed, so its impact is limited?
---
 drivers/nvme/host/pci.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 0e4caeab739c..c8c5ed3eeac7 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -806,8 +806,8 @@ static void nvme_unmap_data(struct request *req)
 	if (!blk_rq_dma_unmap(req, dma_dev, &iod->dma_state, iod->total_len,
 			      map)) {
 		if (nvme_pci_cmd_use_sgl(&iod->cmd))
-			nvme_free_sgls(req, iod->descriptors[0],
-				       &iod->cmd.common.dptr.sgl, attrs);
+			nvme_free_sgls(req, &iod->cmd.common.dptr.sgl,
+			               iod->descriptors[0], attrs);
 		else
 			nvme_free_prps(req, attrs);
 	}
-- 
2.51.0


