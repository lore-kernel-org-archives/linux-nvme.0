Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C5CBCD1296
	for <linux-nvme@archiver.kernel.org>; Wed, 10 Apr 2024 06:31:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:References:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3T0tFNf2cpTB1ks9j87C9XXSi0Y22XV2QiuJ/numiJE=; b=GXmYE1QdUqjMQpeqQBPq0apZe2
	lACt5RpZgw4Qh3QqEWo3p+Q8obZEvzCHt6hNlV/TVlRr16eb28iEq8uwK+WElqpokhHBBO1ignpBU
	TSJeHuql/mjgRNufHQFceX4jM1sIwR0CBG1u8AYcMkMFc7w97b1jzh9A55U7cbFbCaIwdXJ0Byy3b
	Jfz60f1UO9yoXWvmcQOodgc+bzKrJ9sPlKzsgfFDSa2WShesyVMeFDmdYJRAukZlTB+Gf6YonhgwS
	VUu8RnMsD52H1i1iUF1eE6xRvW5l84HOwZXX3yHDm/NSGQY+R2GtvDhT+ertMqIovBYWHdWSIkrGp
	Uu0OgbFg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1ruRUI-00000005Of4-3onX;
	Wed, 10 Apr 2024 06:31:14 +0000
Received: from mail-mw2nam10on20700.outbound.protection.outlook.com ([2a01:111:f403:2412::700] helo=NAM10-MW2-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1ruRUF-00000005Och-3iYT
	for linux-nvme@lists.infradead.org;
	Wed, 10 Apr 2024 06:31:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DxP+d5ZJa+aPIUqlCnUNrhkPuI2yXymYQs0w2JZgQSk1/+1WVZ5htAzo5sg2ZkHdjeHfbgoVachKHoX/w+GB30jSI4fMtgv9GP0TaX7ZGhN9A/z3iFZ1ZrVx+n8Ydv+SDH/mENsIobEo65TD76XHU4TBTXbIuZIL18tFOKdYkS2hEGczdeydCZek6IHKBxz37KE1eWT/l4L1I0StdUF70FFjJLVOXt68tHsOEqi2IIKFSd8W6bY1lxXbvYZr/nRWQZvPtBeASjXEcK/JjId9fcRBM9J5uGcvm7qb6SJDXvjBobGCL0Mc+UJRzOD5unWBbFY3+CJeta6rReqNCxBVPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3T0tFNf2cpTB1ks9j87C9XXSi0Y22XV2QiuJ/numiJE=;
 b=JfpYbo1rbWQN5jZFyX5zxGGcKZe/IomBr2ndm/Rbpi3sll4gfJzvXGNdZD3Tyu7AiE5MAURIVFboUB2CRirU6iHTOsQJrn3VLcVUvmHMm92NZmbdBRf5dx5QbTggqmf5bk4tndt8HhCM5A66yvXLhKh/JHQngkECGAOQa3VWmQn6kFmpSxSvjtHXVW8Vm7G0IePJh2/idzdPEPcV98iLDv2tl7i8+56iN19bMhuo/1vy8rRJX7gd/JoVc09G6xrpxZrNvq2BcxmbYksnGwya6oIFVHiZC0UKCqT8j1dY6bE8DpT9qCxOvYNjIQnOYiSjBVAaLU+6+xhu3lkZykBBIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3T0tFNf2cpTB1ks9j87C9XXSi0Y22XV2QiuJ/numiJE=;
 b=l6O/XGyVk7XAjun/3u8RYuxhDPvyIm923lgH8byu0lInNoOalcLsOoPn0lDNftyKjPeCmrVJ4d7/Xm8+QJQOCu0OFUP1klt6imIPPQ3ltikHRedCcpCKUAm1yZwX5MTFz+Wb/jbzUEWtO+V12ETLXLkXp44Oi7kuROH0OU6QXPsXCMED0IJpDu+ZYZ7qhDVPxDb1X3TaIQ6wG763MKz14yXc7ykUMnpndbLJbaugK/TaAux8jqsGj2d87TBaxBBOB/je5Cfb7+tfjOh/gVzuMwoMMRIuGna4hOmGk6AZxEzk/AakHnqFdUnJL28KT5Cvqm6R3oYx8XSYW4UzwbNwyA==
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com (2603:10b6:a03:45e::8)
 by SJ2PR12MB7896.namprd12.prod.outlook.com (2603:10b6:a03:4c6::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Wed, 10 Apr
 2024 06:31:04 +0000
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::aa05:b8a0:7d5:b463]) by SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::aa05:b8a0:7d5:b463%3]) with mapi id 15.20.7409.042; Wed, 10 Apr 2024
 06:31:04 +0000
From: Aurelien Aptel <aaptel@nvidia.com>
To: Sagi Grimberg <sagi@grimberg.me>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "hch@lst.de" <hch@lst.de>, "kbusch@kernel.org"
	<kbusch@kernel.org>, "axboe@fb.com" <axboe@fb.com>, Chaitanya Kulkarni
	<chaitanyak@nvidia.com>, "davem@davemloft.net" <davem@davemloft.net>,
	"kuba@kernel.org" <kuba@kernel.org>
CC: Boris Pismenny <borisp@nvidia.com>, "aurelien.aptel@gmail.com"
	<aurelien.aptel@gmail.com>, Shai Malin <smalin@nvidia.com>,
	"malin1024@gmail.com" <malin1024@gmail.com>, Or Gerlitz
	<ogerlitz@nvidia.com>, Yoray Zack <yorayz@nvidia.com>, Gal Shalom
	<galshalom@nvidia.com>, Max Gurtovoy <mgurtovoy@nvidia.com>
Subject: RE: [PATCH v24 06/20] nvme-tcp: Add DDP data-path
Thread-Topic: [PATCH v24 06/20] nvme-tcp: Add DDP data-path
Thread-Index: AQHahozr1CSHzxR3ZUO2E0aMrm+r7rFdYxQAgAOw87A=
Date: Wed, 10 Apr 2024 06:31:03 +0000
Message-ID: <SJ1PR12MB6075F997ED346A333A86D763A5062@SJ1PR12MB6075.namprd12.prod.outlook.com>
References: <20240404123717.11857-1-aaptel@nvidia.com>
 <20240404123717.11857-7-aaptel@nvidia.com>
 <a307cd8b-510d-4bb0-9e5d-68fdbd8a362c@grimberg.me>
In-Reply-To: <a307cd8b-510d-4bb0-9e5d-68fdbd8a362c@grimberg.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR12MB6075:EE_|SJ2PR12MB7896:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Z98yYrECeOidF3xPjZL7KEv09V+v9Xdiv8gW3QS1C2QdAcXHWaBeUSHsUIEwzTBZybjppTuyRW8BG1WOIrbm1ujDkeDJErMw4TJxgdG7U+j/FOP1Jptz5rkor3Y8lN3pktiyJ7F9dcrC7duAb6+tSnkU8flpNNuMN8kvvv2a9hBSxJGFMTpmbkBkziCqYdrA9SoetOBKLchzk/09Wa9/7nZ5ZzRI3b0dfHtGb6xRWioMCi6vaKrA7QTvPqsD/3ttp38WMag3YS00Ppd5Ycqv1paolSS8PHP4+tMEzLnTcnZBze9qy9EmdpilUIJb1y4qKBwi8dAGIDsJneEzAjOb3llXI0cMSNyxe7gH2PP24Cv93Y1Mt6DiT+5pAXIpGjZZMQFrBTYCBGOEZKUpOLPf/Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR12MB6075.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015)(7416005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?M1FzempPOE1maVdDeDFoOStCTTZIbldPWUhmeUJMMGF4U2lRdVlGM0JSbTE2?=
 =?utf-8?B?WjBucU9PbjFQa2hSY3E1SHhLVFFHalkwRDlQVC9PSUxZa0w5Y25Dd2ZvT29H?=
 =?utf-8?B?WFJ0Sk9ZSVJSN2pyMGRieW9qaW5oR2tHUS9mOWd3dm5hTEljTlFLWEFjdEw3?=
 =?utf-8?B?amRVVUdvb0pOZFVBM0FvdTI1Unh1VUVBZE81QzNEZEVsK2UyL3lFdXE4WTBH?=
 =?utf-8?B?MmtCU2h0QzZEQkdQVXEwQTYzbk5rYnduUHRENE16ay9nVkNydHBUY0hWTjVq?=
 =?utf-8?B?cDFtQ0V4R2lSbkY2bXVubkFNaUw4YUNzdkhQc2k5U0JtMkJMa1llMmx0Wmh5?=
 =?utf-8?B?SGtQc1RDcEpSWFVxcW1GaFF0WDBOMmhvZUlrczVsb2gwL3R5R0NCT2ZhUS9r?=
 =?utf-8?B?SXZ4aHpjNTJuOXA4d0lzMmlQQTF1VVR6SDQwNUI4UjVtQjlMR01TTTdlVUps?=
 =?utf-8?B?MzI1M3NDV3FUb0czOEFBUGsyNEk4S1NhSVg5cnJXQTNSYVYvTWdZSFVHVGtV?=
 =?utf-8?B?a3lUMit1UEdpNnBtM3FNdmxOVUlmbHdzWlpUMVdrTStIY0tIMW8vR1FtZE5K?=
 =?utf-8?B?cFdNN1FuME1VVDRpWVZkWEMzcWdvaHJSNXNlMHN5UzBTZUFKUWx6N0tLUS92?=
 =?utf-8?B?Q09lN0paZ1BZN1hQY24yMXJyMUVLNGR3WTZTMncyakY3VUg0NjU2eUxMZ1Zi?=
 =?utf-8?B?R3lJMnUvcDB3SmVRK1NTSWJub1NkK2dnNWFhT0U5VWwxZkVkblljN21IRkY2?=
 =?utf-8?B?eXovZmFXeVRra3lCWXFtcHZ3dlgyMkJVL3V2bUNEb2ZKd2lSTVhHUGNwWk5v?=
 =?utf-8?B?SW5neERyQXY0TThzb0dsR2QzTUs1Vk9LNzBtSlg1dXJtOS9OTWVLREF5Vk1i?=
 =?utf-8?B?QU9iRTdVb3l4a1MwVGdVQWpIQUdSOU0xTXJrSU03S1JKc25XK0p0Y3Y1REJn?=
 =?utf-8?B?S2FOa0RBKzAxcFFDOTMzNXk1MU5aeFJublg5NEwxckRTb1pNMktzR2dhb0Ri?=
 =?utf-8?B?WlhuWVlySWZxQkx5b2ttQ29HYWx2L0cyemh0d1Vjc3cxbzhRY2NrOGhxa1No?=
 =?utf-8?B?WnlubjB6VEtjbHRPbEdnN2VFY3RaQzhUc0tkMU9mOGZLekVSQWRIdExGenVk?=
 =?utf-8?B?ZEl2TnJYdFhyYk5xQjUrY00yU1IrZDBPN01kUkhOTE1RMXZVWGdzcnlGckx0?=
 =?utf-8?B?eHlMOHh2ZFU3aE5jMFNRSlVvTVhTRnRJYnFNdTlGdVAvUng5d0NYNWJmUlJX?=
 =?utf-8?B?RjNMQVpJSXpzN1VGdWRQRHYzNzFsNFczeVUwbkx0TzB1UlVEUWtmWjlFQUxk?=
 =?utf-8?B?dHdERlE4UTFRdGd2ZndDUTB1RmxGbFE2SnpodXM1MnNLRlQ4b2VOd1VkU25j?=
 =?utf-8?B?OFhndktISE93UUFvY0lLbWg5UU92MXB3TFBlRUNwMi8yZUZvalVOcytEM2Zi?=
 =?utf-8?B?QWMxSERzb3ZEa0VrSHRPM2hoK29XS25PZEF5N01odGZvVlZ2QXh1VXFieHJy?=
 =?utf-8?B?Zkh3aG9iTkVNUjFwUjlOcTl1S1ZTaFVjOEx3dHlTYjZmbjJsUU1KQWFuU1k0?=
 =?utf-8?B?cEhac2haVmpSNHZTQXJyQ05ndzd2STNMRFJVUnBtZDJHSllFY2hxREpjamJK?=
 =?utf-8?B?eXFZd21wdEpncFAySkxMV0pPaHl0cnF5ZWRBOEhxeTRuSjBmVnQyTldOUzRU?=
 =?utf-8?B?Q2c5YSs0YjlXU2RwbmZBRFYyV2x6YWd0dDhpS3dzWEFSM1NIL1JtbHZjRUp0?=
 =?utf-8?B?bVhOWmEvQ3NKUFNwZ2NRcENFNWRrNE1xR0VtUlRzM3M3RUpGSEJGMTJUSkEx?=
 =?utf-8?B?TTkxZ3o3NW1GUjlTZm9abThyeXdYWmtoeDEzNXR3OWZQT0JIbnBLNVlqTlBH?=
 =?utf-8?B?QVlkSzJSa21uMVZIUWxVT1Nvd0lNZzZuSnJnVUcwMFNnRnM2UGpFUEdtQW9W?=
 =?utf-8?B?UFlOOVJwOXphWlJBMVdERkthaXNCYy81K01WbDNNaWpEMkl1Mnl3cXVTWnZE?=
 =?utf-8?B?Z3MyNmM2OGlyVDJBSkNmVktVRG1ZQ2lDcGVIWkY3UEtXTm9GeWN4S0pKcTd6?=
 =?utf-8?B?eFd0VUlqSm9QamUyTWFOa1RaQnNYcTVVM1ZaNXFFRWdNSDc5WHkzd0NRYWdr?=
 =?utf-8?Q?0zdM=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3db52e7f-b274-4471-fc31-08dc5927cbe0
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Apr 2024 06:31:03.8261
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gLNcuLaUVbLl1E07yv2LkjQC+ECVswHzrRzZ97vc/S3qPsg3V5UT4AzrE6vSElxUf2x9Ha7zyn20ENtipTnqXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7896
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240409_233111_963617_60F63E6C 
X-CRM114-Status: UNSURE (   5.47  )
X-CRM114-Notice: Please train this message.
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

VGhhbmtzIQ0K

