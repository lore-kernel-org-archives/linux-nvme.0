Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17360C83F17
	for <linux-nvme@archiver.kernel.org>; Mon, 14 Jul 2025 20:44:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ndU6ZoWF/TMOnykXnplQzHaoAZiqhg7odOuw73DinmM=; b=G/kmYpX1/R7phQTMA1Ih5qNjvi
	CnYZQdcHXmch6MLQCgd1vWhIIVRgnS+A5MeXVx8PDzv7ppqekIS171SEXyfRAPKBu9pdHmAjmwln7
	vmy3zAUJa5HhzTaYM9xs6qqrOwj5LLGlFMHcCpHDuYQci6uTY3pbCszJCq7Apjg72JJhw6Q31fT/B
	fzU35boGupuqyLLuThzwWJof6VFuMttU5NUxmhlf34U+B9mcxA9lyFU/p7hfgsye5OpKYk3K2kvyo
	jMWJYUka3BbdvEbBrxkirY7SXmxlosoJIBKCNxS7OYoAPA6Px2XsWZM84de1nDUGROgmlrh8sV6R7
	LT+H+GPQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ubQ24-00000003Et6-0yYq;
	Mon, 14 Jul 2025 20:44:16 +0000
Received: from mail-dm6nam04on2061a.outbound.protection.outlook.com ([2a01:111:f403:2409::61a] helo=NAM04-DM6-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ubQ21-00000003Esi-1jYs
	for linux-nvme@lists.infradead.org;
	Mon, 14 Jul 2025 20:44:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qXrYaF25+jE3N4su0xSPFSElTvi8b8rducenhzH82bp7NFDbNPs2uXxiJXy+yoF+TgS+Gj01sfUMkp+aN1cGm3Cq3FjBMEKYAN/G88AQu5AJEN623IssCjG1i4macJ23+Co7ljDc+3xuY4Fx1amwFVDzjR96VaDQcGwIgKQUJErk5QvkwpSSoc2Vl5mnn/8M5LCqzkllOpdL0c3QQLb7w8NNmmcZ6m1BoccCSs7TMyYXlnJy06taN7YSejfDPpJ0Dfe0kVSkEx8LjQ6H1Koa631ptvXGQHD6flGPTJk/kQnoa49cpxmlYkw8r3PHq9GSMY48AwbeceOYsS4lB+toGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ndU6ZoWF/TMOnykXnplQzHaoAZiqhg7odOuw73DinmM=;
 b=P+lBh6CK4ZBHMIJm3k11kTn9r97JKH4IZ9G7Dpspw63xQf6zHpYvrUiXrChcxC5n5J9tFWfMK95rjtBo3U8JiMAreTPzFHATHNLLkBipBYOLu66nZ+x3L+frYhW3aklqYa4KkdUJw2aMGK9zJidtd5pstjjdp/9f/NJLte7++TCLxuzDwGiaNyUhhz6Cr9FvSPNKDZXxImCZ9czkIr6+kkjH5H8F/F4IfBsB7tndcoFIafUiAgVGBxcIQ59cH+D3WEBHnn6Dp6duT8HC40zVRmswriH8aUom4/GW0X+SaPSulRomO1W110pL843fM1kI1vL713AlHmAdHVY88LSReA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ndU6ZoWF/TMOnykXnplQzHaoAZiqhg7odOuw73DinmM=;
 b=FMyZuKaa7WW4LEK1MJy8GnEHp60w5UOYVUuQ26Bjg+oXQZjGE52Gqvt+jKorglXZZM5PMxxjKh0cHuU6QX4i+VJHj/LeO4ka0M/EQBUAP6cxYKTmRZOV9MH8FiChT201gKcM39hyLjPCnRvfRNX6mCwgh26sVhw6Xwa+JfAjTxxx6m6m0UrbXulOa7vpCJtXz6WxJlKFDYDaw9q27Earsn/9SeyJA3LH9sZkOpQIXMKJLLF2aT+MKGf4Np7rmmk/T1ohzXeJhI77d0t5luKprDtrcCHKr0j4g0H+yNSsBaG7Xh9aL96j21tcfqlxmCYPRmZ02huI/xIIvv9pcxhm6Q==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by CY5PR12MB6348.namprd12.prod.outlook.com (2603:10b6:930:f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.35; Mon, 14 Jul
 2025 20:43:53 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b%3]) with mapi id 15.20.8901.024; Mon, 14 Jul 2025
 20:43:52 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>, Jens
 Axboe <axboe@kernel.dk>, Sagi Grimberg <sagi@grimberg.me>
CC: Alan Adamson <alan.adamson@oracle.com>, John Garry
	<john.g.garry@oracle.com>, "yi.zhang@redhat.com" <yi.zhang@redhat.com>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH] nvme: revert the cross-controller atomic write size
 validation
Thread-Topic: [PATCH] nvme: revert the cross-controller atomic write size
 validation
Thread-Index: AQHb9NVuh8xkp9N6+0W56gUXCfbdoLQyFleA
Date: Mon, 14 Jul 2025 20:43:52 +0000
Message-ID: <f927a6d5-16c5-4a21-bdc1-22f5d5d09933@nvidia.com>
References: <20250714144406.1692041-1-hch@lst.de>
 <20250714144406.1692041-2-hch@lst.de>
In-Reply-To: <20250714144406.1692041-2-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|CY5PR12MB6348:EE_
x-ms-office365-filtering-correlation-id: 7bc5f707-0f42-452c-5d7b-08ddc31724a7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|10070799003|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?bUh6cGZqTWtwdFVzbk5PZ05jaGMrY29ZRU1SL3FtQ0VRT25DUEluenpOa25y?=
 =?utf-8?B?VS9SMXd4a2ZZQ1VqeFRHZmtHOWN0QVV6MnhYRW1IWkFOemgvL1N3N2V5Zmtv?=
 =?utf-8?B?RGNwbTZvc3NPTWthdzZBWForWFU1bHlpdWp2WkRiSkx1N3dLWWlQbWp2Wk5j?=
 =?utf-8?B?OFllKzFJTkNmZ3QxV2JaUUxHbnlTLzlpU3RDWmJUQU55TFFnTkhUZ1ZOM0g1?=
 =?utf-8?B?UXdSNTkwOEhPUmtBQlY5ZzJBSVpZQWI0VXdnRVN6bDBUWElPZm1aTitpTERx?=
 =?utf-8?B?aW8zQWVXaW0xU05GM25vKzdXNzNJZ1FHVDNjek03SndWWFVxVE82ZGNtL3hB?=
 =?utf-8?B?SHFKTGRTUlFMampKN0d5REo3V3NWNXgrY09yTG1FOGMyTUtNOWUwY3h5WVdo?=
 =?utf-8?B?elh0MFZNNE1qSmpwa1NwRG0xVDJ3SzJyci9lYWU1VnM0NFZGdVNGcGJRY0pZ?=
 =?utf-8?B?LzZUTlh5a0N0WkVvZEFzUUw4VGxuSEh1SGkvNVI5OG1SakNIU2JBeVlnMnRG?=
 =?utf-8?B?MmE4T0NPU3lLd0tYREpuNnYwSWhkWm40dlJra2V3UDhkbEFaMUV6NGZLYklu?=
 =?utf-8?B?eXpSZFRHNHpLd252bE1ra2lteFdLdk40K2NxK2R4a1NOaUR0bnFXcnhBMytP?=
 =?utf-8?B?Z0ZCUXB0WDhDQlRhcld0UXhxTHZBcGpkSzAvZEhGN3pETkVONEZlb0NIOHBi?=
 =?utf-8?B?SmFlMkdjT0hNZzVvYzVESEUvdjFNWGJtcWwxTDl1dWdXbThPeVVSVVVWZVdV?=
 =?utf-8?B?dUw2U3BhaHZrcFNPbzFKb1NXSk8yd3pYRXkzS0s2alNwZWxHdE80V0ZUZ0lu?=
 =?utf-8?B?V3lnTUQ3Rm5ockE2Q1NuS2tXb2t5YmZqRitjckkvazhJZkJjdGpmT2FvelpB?=
 =?utf-8?B?MjUzdDRvaG5wOXJ3NlBUdFg0cXVFV0Qxd2J1YjM2ZGQxckZoNnpHYWdXblBU?=
 =?utf-8?B?QURwbzRhSWI5ZmRGczhKNTdsZUVvS3JVbjhZMWljVC9SY3lkQ010V2thWGNw?=
 =?utf-8?B?QkI5cVBJZDBFNVgvT3NYS3R6dC90SjNabU8rVHV4RVVHSHZiY0RQeHIzWC9Q?=
 =?utf-8?B?alk1VHAwbXhZTE5YbW5lQzE5S29CcVJWTXZjcVptWGQxN24xOTNTUzZuUVBL?=
 =?utf-8?B?SUF2cTVkeUorVm96eDg2Vk9YazNjbFJrdVpVS3hGQkpMMC9aeU13NHVlRkFw?=
 =?utf-8?B?S0pNQVprdWVUVEVrUVdVdCtvVVQ3dUNYZUYzRTlNTzZJRzcwdkxHSGg2ZXBE?=
 =?utf-8?B?VE1sR1J6VytNUjdtd01OMWhzMmlNeUg5WFRWYkhoTnVidS94OEw1KzQ3T1Zi?=
 =?utf-8?B?UEdtL2VRUVIyaWZoOTNjQUQwLzBuSktWeUZBYTVPYUkzVW03N21rUHVncHFM?=
 =?utf-8?B?ak5QanNIOTRNREZ2MXdGdGtmWWoxWGJXU3kyaEVibDErSExpdkRpSHVwWkpu?=
 =?utf-8?B?VEFOckxhZ0c4L0hzUGluYVlLUVZ0SkdGVG52Qm5hQ2Q0R2NMV21rUW9oTy9o?=
 =?utf-8?B?cXRURUowZC95c1YrVTIzblNHdTVwZExPUytpak1uZUJMS1d2YU9OUWtJM0lD?=
 =?utf-8?B?TVh1Z0gxZW5mNE04ZVFVQy9OZzRtd0xnZFFPVy9mZ0RJTmtFYXkxWWhLQjRL?=
 =?utf-8?B?bTdvQUcvQjdYWFJhV3cxei9rckNqMWlPYXdZODFPWFcrbDdJbmNyREhLNWVj?=
 =?utf-8?B?UDRSdFRPV2l1YzhXS3p4T0pqWmt0OG1iOG1PczFQQUNOOGFxbE5Id2pOZm9j?=
 =?utf-8?B?WGorb2swT29VQzJZQUlyWTNPdVllTGxHY0FnOTcxWWZCZTFMei95Z0RINXJ4?=
 =?utf-8?B?d0szSTBGa2t1SDhFQUZyQ0x3Yk8vTkE5QkFubk1ERUpYcDB6dmx2eFB3S3do?=
 =?utf-8?B?eklrZVRxUk93dWtncGhvN3dZNjBYdHRJK0VDazNGbXJ1VnJlcHBpSm91VGV2?=
 =?utf-8?B?RnBBVHhwYSt3RzcvTEtybXh2WENyMFM2dUIrUEZjYkVtNDZMR3ViNC8rdUFG?=
 =?utf-8?B?TDNReDdBeUF3PT0=?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bWI0SFd5aXJ5ejZpS3YyV3FiZVRTbWFXRnlxaE03eHljb29pZUQ5UHhmQ1VE?=
 =?utf-8?B?Q2lLR3M3WTkrOStGaFVUMW5KUDFSZUZvNjVTblNsQjdGS01yQjhnTktQVHpu?=
 =?utf-8?B?WWd2NlhaK1NqMVRRRFRNRmx3TG1wcEhXbS9oUnE0ZHZnenpnZFY4TFBsZFF6?=
 =?utf-8?B?bGVQNllGTEVTWEVWbXFBazlKZWhjSDY3aWxVL3RNZUFLQXgyMWUwb0pCSVRp?=
 =?utf-8?B?U01VSThkU2k2UDVjbEszVzRJTm4vTWJqUG9ZSWpFVXVNWjcvSDJRWHpzbGtk?=
 =?utf-8?B?MUlJV2lkOE1TZXR6TmwzeUIyaWNBVXF5Z1hIZWVnZXZJNTVJUnV1Q0RyRHZo?=
 =?utf-8?B?dHhQRGFucDhtQlFnOThSbThBcnE5RUM0aXhyVzRnVktmaW0vM2RDdjJrd1BF?=
 =?utf-8?B?TFZwdXBzYVFDZHViYmNDcmVZeUhLNTQ4MnUzVUdoVXY2Tyt6UCs3d2FHZ3Uz?=
 =?utf-8?B?TmxhV0VxRmVlZEVudXBLSEY5c2dSKysxZ2pNdnMvNUlWTy9WRXVRNUV0dEFM?=
 =?utf-8?B?djF4OCs5bnU5aDVET3NiM0dnUXRvclMwaTIrUWNmUkM0QkhycmZvVldJWGNt?=
 =?utf-8?B?Vm5GQTE4SWU0NXNhVmM5a1g2Q29VSldOZWp2cDI4R0lhS09iVE5mQ1ZwL1Ny?=
 =?utf-8?B?YldXQU9Hd2JmS1dwNlZFbUtGY0d4cGRLa3JrRjlYU3pSQ3hLRjV3UnAweSto?=
 =?utf-8?B?dWpLM2pub2xIRWJxMWtFODRSS05mdmZFT2JqWkNuTTVCQmFra2tMWDVwRDVS?=
 =?utf-8?B?ZlkvZ0lkMXB3dG1lM2YxUTNqWWwrNWYrMFhTYWhOL2RyK0I1RkpaS2oweHBF?=
 =?utf-8?B?aCtmQXhxTDJSbXFRN09JYzAvN2RYY0RxRjVLWkllUWpqRVFjOGVFN1JjWlhX?=
 =?utf-8?B?VFFDbjJqZ1E4bVJCRGt5Z1ZEMXpvZmxMaGQzanpEb3Z3RHRmeUMxeEFtRW9B?=
 =?utf-8?B?YVBlQUlsRGUrZ3h2bW8vRDlEY2xPRlhRMy82R1BKMlE3NnFVLzB6dGxIaUFo?=
 =?utf-8?B?cGpqRTdFVFgrcVBROW96c0ZXTGNRMmVhell1b1JKc0VrTm5DZm5mZnZiaXVQ?=
 =?utf-8?B?RWdEWVNsWGJuRmRQM1JpOThlM1ZnbllSdHJqOG52OFdqVHpySk82bElQdWk2?=
 =?utf-8?B?cCsrTEFKc0NYMExJbEE5NkljMkxYSlhVbWUySGN2N28xUmFVUnVWUVdHUnRI?=
 =?utf-8?B?SkR2TzVEMzZHYm5GdDFPQWphVDdJbWVYYnFtNENqL3BmUitmeGtqcmxxbHA0?=
 =?utf-8?B?Znl2NWJJVWhVOFdsOHdwR0M0bkJVQlBBR3JiWm92M3ZBbnVmak44VHdkNXNZ?=
 =?utf-8?B?ZUs2TExnVXFGT1N3N054aWFJcHNKWFdVTWJkZmNtM3c0eXUvU3k5Y0tpNUNO?=
 =?utf-8?B?dnlpa24vUVdpNUNuaHBNdEFkemxBczgwdktBd1VFUXplRlJmbHN4QXg4UndB?=
 =?utf-8?B?dWdFVFg4ZkxLY0ZyYzdSeTVwTFpoNUYwYW52NGU4R3IrMVgyWUd2Q0tTNldq?=
 =?utf-8?B?WUgvbXYrS0p0TTRGV0JXSmxMMFE2Q1EyT0QxNjVJeWQyTTJHVFliRFJhelRD?=
 =?utf-8?B?WUo0bjBQaXNnRmVobnhSTlE3YXI3NFQvRDRTQXg2OW9pQjNKeXFzU0p5blk5?=
 =?utf-8?B?UlJnbzJXU1FXSEEvTFUyRWhtSTYvQkk1K2dwYndwcDZkSEhFL3BlUGZCUks5?=
 =?utf-8?B?cGhvZDNmNmVIb2NGOVNZRDRRYWwxVVlVekVxb1ZtU1FQSXQvYWxoRXA0NVg1?=
 =?utf-8?B?RnhoTjFWMDRSY0RHS0hHbkxxbGhlZ1ZHQllnT1c5em82ZlFwQ3JSM3NEeFE0?=
 =?utf-8?B?K21RMDJlT1RrQXhSV1V2SXdYRXdQbGgrV3h1UlN2RDRTM1dmMFdzMDRYdzU4?=
 =?utf-8?B?cTJWQTIxK1BvNzA3aEQvY205QWZmMFZWSDVsZ0RkMWdpWHdsRzdrRG5pYmgw?=
 =?utf-8?B?Yis1MXUzZWIvUi90VkZyT281YnhlUWVaVU82SXJsT3N2Ri9XOExoVjN6bzFG?=
 =?utf-8?B?Y3VkQkpkcDh5QXB3U01paTdjZWFFTXMySWFXMnp5eDVoSlVKU2RhTFhSaTVn?=
 =?utf-8?B?U3ljWGY5SUFMODk5cTFabXZsak9aKzZ5djZJcWpnMTUvMjlHUEVHaHhQMERm?=
 =?utf-8?B?NUI4d3NIVnBySXRyMlFvWi9ocVcxRU9BbzBJemJwTmlPUEtoT3lNY0lCcndm?=
 =?utf-8?Q?hwcLWmRya3jJ4h1cFsXuCbtarKmP27bVF1WngBDJ01vU?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2A9E8C380C11584BA452C7A07043BEF2@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9404.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7bc5f707-0f42-452c-5d7b-08ddc31724a7
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jul 2025 20:43:52.2850
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: f9W+bTbqP/oR2SzJ6P+OIbdCyTv2sffI8+c8kFsqBYFSUlMcqQiEGEWkRHKfVc94I5w0Ek/uuJXUJ3udFiI77g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6348
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250714_134413_470909_2F876A09 
X-CRM114-Status: GOOD (  15.40  )
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

T24gNy8xNC8yNSAwNzo0NCwgQ2hyaXN0b3BoIEhlbGx3aWcgd3JvdGU6DQo+IFRoaXMgd2FzIG9y
aWdpbmFsbHkgYWRkZWQgYnkgY29tbWl0IDg2OTVmMDYwYTAyOSAoIm52bWU6IGFsbCBuYW1lc3Bh
Y2VzDQo+IGluIGEgc3Vic3lzdGVtIG11c3QgYWRoZXJlIHRvIGEgY29tbW9uIGF0b21pYyB3cml0
ZSBzaXplIikgdG8gY2hlY2sNCj4gdGhlIGFsbCBjb250cm9sbGVycyBpbiBhIHN1YnN5c3RlbSBy
ZXBvcnQgdGhlIHNhbWUgYXRvbWljIHdyaXRlIHNpemUsDQo+IGJ1dCB0aGUgY2hlY2sgd2Fzbid0
IHF1aXRlIGNvcnJlY3QgYW5kIGNhdXNlZCBwcm9ibGVtcyBmb3IgZGV2aWNlcw0KPiB3aXRoIG11
bHRpcGxlIG5hbWVzcGFjZXMgdGhhdCByZXBvcnQgZGlmZmVyZW50IExCQSBzaXplcy4gIENvbW1p
dA0KPiBmNDZkMjczNDQ5YmEgKCJudm1lOiBmaXggYXRvbWljIHdyaXRlIHNpemUgdmFsaWRhdGlv
biIpIHRyaWVkIHRvIGZpeA0KPiB0aGlzLCBidXQgdGhlbiBjYXVzZWQgcHJvYmxlbXMgZm9yIG5h
bWVzcGFjZSByZWRpc2NvdmVyeSBhZnRlciBhDQo+IGZvcm1hdCB3aXRoIGFuIExCQSBzaXplIGNo
YW5nZSB0aGF0IGNoYW5nZXMgdGhlIEFXVVBGIHZhbHVlLg0KPg0KPiBUaGlzIGRyb3AgdGhlIHZh
bGlkYXRpb24gYW5kIGVzc2VudGlhbGx5IHJldmVycyB0aG9zZSB0d28gY29tbWl0cyB3aGlsZQ0K
DQpzL1RoaXMgZHJvcC9UaGlzIGRyb3BzID8NCnMvcmV2ZXJzL3JldmVydHMgPw0KDQo+IGtlZXBp
bmcgdGhlIGNsZWFudXAgdGhhdCB3ZW50IGluIGJldHdlZW4gdGhlIHR3by4gIFdlJ2xsIG5lZWQg
dG8gZmlndXJlDQo+IG91dCBob3cgdG8gcHJvcGVybHkgY2hlY2sgZm9yIHRoZSBtb3VzZSB0cmFw
IHRoYXQgbnZtZSBsZWZ0IHVzLCBidXQgZm9yDQo+IG5vdyByZXZlcnQgdGhlIGNoZWNrIHRvIGtl
ZXAgZGV2aWNlcyB3b3JraW5nIGZvciB1c2VycyB3aG8gY291bGRuJ3QgY2FyZQ0KPiBsZXNzIGFi
b3V0IHRoZSBhdG9taWMgd3JpdGUgZmVhdHVyZS4NCj4NCj4gRml4ZXM6IDg2OTVmMDYwYTAyOSAo
Im52bWU6IGFsbCBuYW1lc3BhY2VzIGluIGEgc3Vic3lzdGVtIG11c3QgYWRoZXJlIHRvIGEgY29t
bW9uIGF0b21pYyB3cml0ZSBzaXplIikNCj4gRml4ZXM6IGY0NmQyNzM0NDliYSAoIm52bWU6IGZp
eCBhdG9taWMgd3JpdGUgc2l6ZSB2YWxpZGF0aW9uIikNCj4gU2lnbmVkLW9mZi1ieTogQ2hyaXN0
b3BoIEhlbGx3aWcgPGhjaEBsc3QuZGU+DQo+IC0tLQ0KPg0KDQoNCkxvb2tzIGdvb2QuDQoNClJl
dmlld2VkLWJ5OiBDaGFpdGFueWEgS3Vsa2FybmkgPGtjaEBudmlkaWEuY29tPg0KDQotY2sNCg0K
DQo=

