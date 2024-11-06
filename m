Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C339D3E78D
	for <linux-nvme@archiver.kernel.org>; Wed,  6 Nov 2024 06:17:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Cv/HOo66oPzh5VZd9BYmqXn4TzhV2QEP3OfK0aev3jE=; b=DgvS0M6aNJbWw0xiua5xPo3FUU
	IZyjzGZd5ihcxNycAsQGrRki0fow8e9lzO5V7Dzs11c1SYjTmxeTYzTlBo6nTFepfql0KurR1u7zI
	SLqmToqdNBJ6Ly6TBwxDwDSfNTdcb0F7kCz76J67Cjoe8A2BkJLSRT0bc9XxpLAfYV9SdIaQ85Wqf
	+0g2R9ngD4d3FaKPcUHFQyPpQohbGwylO3LrDd9xgzacB/PlDjogzeqA6ASMOPJFXzpWY6er65LD2
	thiC2SNFlLZYmNGXiiHwstshQkk+kf/++VVpeyUaNYrR8ys5pHmfqhcnE772eJbfjaDGKC3WAVqav
	rVt+DSxw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t8ZMG-00000001y0D-0uEd;
	Wed, 06 Nov 2024 06:17:36 +0000
Received: from mail-dm6nam11on20619.outbound.protection.outlook.com ([2a01:111:f403:2415::619] helo=NAM11-DM6-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t8ZIk-00000001xUY-1YTi
	for linux-nvme@lists.infradead.org;
	Wed, 06 Nov 2024 06:13:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mD8gX2xPabQ8FJbo2GOeC6IrKRWLwd1x9++uqsfOxNBCwJlS73mNgZoe/GZM+BKbLy8UhsAxHSXtC5r2NhcVfqsIYjXxth2ntD9AL9YrxBGT146ZbSNgBQNen0cJobO9gGudUVeqWo8t6iAbRlqCJuCFCbwpcwwayGysm2IrpMjInQhiBNkvXYL/kcxJYSF4CTBdvlYOYwUyu8xKVDDn2Z7/VVSkRK7r8XFixAVhvTYUyLYd2yrhCdbaeUkuq/pG6SldB+0iIXh4pW0Fk+4lVIAM9IliU6Nyex7L5nuBDqAMZIQiO5HGNYwfmf9KYVv+QzTkLfGJnKUYSe3Di/029w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cv/HOo66oPzh5VZd9BYmqXn4TzhV2QEP3OfK0aev3jE=;
 b=CpgcfNZcpCyVXOTKS/XAE+n1lkXA/SQYvYDtMn98gCceuqx/5hnpY3zixD+SCcM+kE9lbG8Fw7DGPyemUI4RyUh2/Wf0UOk96fZ5N0/Soaag1zUteCRlyxqjwu9Bm4WwxpPrKnC8qERymRpBHqXTERGVwwBsbHgNRdImsYx0JUkgGp76c80ZZXenG/LD/DZE2qXDFvKEkpHjX3l4lSTU6njf30+ev7xmTI01OIKfRdA003pzgzo6U0sXty8WN+Z3Ec5s8/dyKR+cTPyXAjXTHT1ohfpkxXsP8h4qpZawuZYBVxVqtrak8j+HAnFcGwNtIAq+b7A74b+iZ1EaSgeEnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cv/HOo66oPzh5VZd9BYmqXn4TzhV2QEP3OfK0aev3jE=;
 b=BrlpNQ408a+3Nm5WE4SgL4nCU5m3gavWajKbpUxgkl7blXtwzOKjoQswhQ/DSEHu0AL/jmGqBPfAl4LpRb8rV8LFQy9Jd8pFFC1zEmPyD+yYYoNG43SL10yTjLWE5h2v+W0zEvJJ1JdNksFra8xhFW3C6+vbMIOdcRIMWPXfDA693lIf5dCLXLIR+hm/Omay0ebVZu7dyeWNWBiLA71oT5RBIPTG/ZSesEEcz5ciPdlaFbPukSIpchKJsNxwazIgNaz12/NYzHYl/jA4mCCOaXdRNuIUiZktpVuQoLnS/CzoVu6CV0qCdpI7iIMvAPPTv4SAntaP7iGQdRLC917g1w==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by MN0PR12MB5810.namprd12.prod.outlook.com (2603:10b6:208:376::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.30; Wed, 6 Nov
 2024 06:13:49 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b%5]) with mapi id 15.20.8137.018; Wed, 6 Nov 2024
 06:13:49 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Christoph Hellwig <hch@lst.de>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"m@bjorling.me" <m@bjorling.me>, Keith Busch <kbusch@meta.com>,
	"matias.bjorling@wdc.com" <matias.bjorling@wdc.com>, Keith Busch
	<kbusch@kernel.org>
Subject: Re: [PATCHv3 06/11] nvmet: declare 2.1 version compliance
Thread-Topic: [PATCHv3 06/11] nvmet: declare 2.1 version compliance
Thread-Index: AQHbL6sZi70sSe9ZGEeVa1ibZQBIJrKpvroAgAAIBQA=
Date: Wed, 6 Nov 2024 06:13:49 +0000
Message-ID: <26286cc6-21ef-43c9-975f-575c16364442@nvidia.com>
References: <20241105174904.3612888-1-kbusch@meta.com>
 <20241105174904.3612888-7-kbusch@meta.com> <20241106054506.GF31330@lst.de>
In-Reply-To: <20241106054506.GF31330@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|MN0PR12MB5810:EE_
x-ms-office365-filtering-correlation-id: fced9d82-8326-4c8e-9964-08dcfe2a2df2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|10070799003|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?S1FpNlFuRzFSTUN6UnlTVnpvVVU4ZWdibkRSLzB6d1VnR1dzRVVVeDVLTm5i?=
 =?utf-8?B?elRFME9YZWEvVlFqZkxONkRZNlYyL2RDS0tXaHhqdG9yYkI0MW1DVSs2Z2FG?=
 =?utf-8?B?cFpTa0RpT09vVGhNWklCVlRJQUFGREI3a0pmaVdlMU4vdW1BZVdSalBDbEsy?=
 =?utf-8?B?ZXhmbGxFejBweVM1N2hvY3E5MkoyU2NqQ21INGdoZnp5ZWNwYXVWaEFYa0c5?=
 =?utf-8?B?Q2hZbWdZSVdST2ttWW5qcHk1emx4TmFkQVBaT2MwRlZWempLNlhZMy9tVFM1?=
 =?utf-8?B?eDZJNUd3MG5DY21NQTMvbVBveU9jK0d5a2wva3lDYlkrRjZNOWhhR2dlOEZu?=
 =?utf-8?B?WHNJb3JtYWZKcGV5bGUwcnpMZDFUdThiSzEyZFFqZVZINUhuZER5QnN1ZUdl?=
 =?utf-8?B?d3Vxa2ZUV2dnb0JqYTc1SEZqalp3N3kxQWN2S0pJQ085OG9KK0hoRjI3U2pz?=
 =?utf-8?B?Q0pkbTJsd2txSE1DUlUwUlNJVXJDdWh0cUx0TGdzY2JXNVFYUFI2dEdBVUMz?=
 =?utf-8?B?NzdHVmNyR2h1YkJZZnd6QWhJR2RjVm1TN1BoMENLSkVOeTNFYVZXL1d1T21E?=
 =?utf-8?B?VDVCV2pyMWRabjNEODVXQWdhQU1OZlJTdXNKcGlFRG1vTWJ2Sm04OVFoc1ZW?=
 =?utf-8?B?U1l0dzVoYVc0UHZqaFByRDNwVFdFZW5FY1hGVHFCc0RvaEdEbVVIUUR2eG5S?=
 =?utf-8?B?ZHd6YzJ4KzcvWE9zeEhWZThaaUhIVEJpYmhoSkdFRFc5SWs4L1lZdjVGdCs0?=
 =?utf-8?B?UVpHT09yVEFHbEF2a1ZuUkEzdUNxczRWNWZEVlV6MEJBYVIyZVpKWi9RYUpB?=
 =?utf-8?B?U2lXaWpQTjVyMGdtTHVDWC9PUHNYN1czRFZyMGhHUkdHdDcyM2VXRTRLdExw?=
 =?utf-8?B?cUZDd3FjM0J2OVJmVHNxSXk1ci90bnFmZTZWQWlsOFhpQWhvVTNlZlN3WVNI?=
 =?utf-8?B?VjFBak16dDFoU3pHaDYrQ2owK0VxV3oyblFua1h6OENGVkp2K3QrMFV0OGt4?=
 =?utf-8?B?azUwRDE5NUdkemlrSlEyenlGY1VDY3JHMkZkTTZPUElia2ZJNGZEZUdqVjY4?=
 =?utf-8?B?eW5FNTRlNjZ4Sk10QnN6eStwOGMzL2JJQWwxMFNCTlBYWFpueStVWHB0Y0ls?=
 =?utf-8?B?YWhHVVpOU2w1a1VrQk9PcDc5RS83ZlliQ1ZQck9zUEtOQVZMQjRqVGY5V1lh?=
 =?utf-8?B?MHAvOU4yRlRzRFFURFlPQnlyaWVPRUwzYlYwK1dZR1RwNFFNb0VtVk93djY0?=
 =?utf-8?B?NmQ3ZXBITmR5NlNaTElmUWROZkptTzlmYnJSdjByN2N5RnZJaXRmc3pGSXpW?=
 =?utf-8?B?RFFEa2dIVGJkRWtPa01zVWJFU3d0NjNmOHFKK3hmRjJzaHNKSGpSeGNXckpi?=
 =?utf-8?B?Ym9jSjgwRjFhVUFsaHhBRnVDNGphUjhtcmMrUGFWMTVzeDRGT3JnWWxYNXoy?=
 =?utf-8?B?Ym8vVTBTZ2hTUDBxdGdYa2lWb0R6QlNmTTlvZWMyNmNqVE1NVjhwL1hEd2JO?=
 =?utf-8?B?OTE5S2Q3R1I5QlJZWDgyamNXVHZYVi9MaDNEK2VwbnQ0TlNZVEp4SU83UjZu?=
 =?utf-8?B?SEpMejJSVjdJTHlvL2kxNmNrQ0xjNWljT2pwSEhZaHFYbmpRanRXdlhaTXFY?=
 =?utf-8?B?dS92TTFqc05ZeUpaVXVMOXRrZDNsdFpKTysxbHhSbWRHRXZYR1cvRnU5Q0JR?=
 =?utf-8?B?Q3FVanltdXBOME1IL3F6Q281eFF3N0JrNERuQmtTdDlCak1qd1h0dkx0MGlV?=
 =?utf-8?B?SFZCeGZRQUtoMlhnTnNEYWYvMFNRVmQxWUlDRzhEMC9lMVhmdTJMWnhGUnBr?=
 =?utf-8?Q?ePz18xlOnAhuu6w/o6QecHC7tOS0UfaKV5AVE=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(10070799003)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SHpqaDRaRFM4SWxVMkJMeWpqcWJXUXNSVnBvZStzUy9vTzNublI5MXJrTG5r?=
 =?utf-8?B?UGxwWEVVdGdqUTRyR2F5clFhcUVPa3ZXNFZ1b0lNNWpXZnhzajlwWkFSQ0Ro?=
 =?utf-8?B?bnoyMEgzMGNmYTVzSG9aWGdsRTljTnM5NjJiaTZJcytlRlJMQlI2MzV5L1Fx?=
 =?utf-8?B?eUlXcVgvUS9GQ0toNHVleVg5bURsWENGbXpleVpPV05uSW1FZThJNmFhaFVK?=
 =?utf-8?B?WjBrZUtGd3ZHQnJyUlJZOVY3OFlvdWUxa2RmNmpoT2M5dVpzNWdGRUt1Mkk2?=
 =?utf-8?B?ZVBjZzFYbmJEUUk3Qm5BNGVuUng3TkMwcHBuUnEzSWIzWXZlSE9FOWFIV09u?=
 =?utf-8?B?dDUrcDc5OWJtZ1c5VGdYcUFocnhGdExVR09ub3NpNzZYOFhGTHpaMzRPOCt4?=
 =?utf-8?B?WG42YXdlSzRhS3ZqWDk1NzhkUlQ5MW9jRk1zU2JsZ1VvL1pxK2Ird0dVL05K?=
 =?utf-8?B?R1pORVExT2FHL2JMSDR5S2JJd2JCd08rUCtJeDc5VFdFbjNLUThJOVZ6RWdE?=
 =?utf-8?B?ZUZKbHdlVXluL3BMczQxVzBsVHV1eUZwRjMwWWJIWERrdzU1VHpRWlY2SU1m?=
 =?utf-8?B?bWMxV2JrWmNTaXBMeXEvZ04rcC80ZlAzT2N6SCtGN1ZabjhhK0RUOHZUSFow?=
 =?utf-8?B?bDFiZzlua21rcU1vSWluYW5TTWdMZGFBcUljeXJDd1VyK1NBaWhEemN3SU9a?=
 =?utf-8?B?QnlLRUpDY0toUUdRUE5GRnRkNVZsQmIvdml5M3JBd0QyZm5paVRXcW9ocXFr?=
 =?utf-8?B?Ri9yRzBSalMvY0I3QnVpM1c4eDdFZWp4ZWRaSVN0OXNUcEZKWE94RU92bk9X?=
 =?utf-8?B?MHM4R25wQ1BrY3hNY2RNbmh0NDI0bGVRLzM0VVpmSXpjOHViQzgwUEpDbVR4?=
 =?utf-8?B?SzRuQzRYM250THU4VmZ4Y1hXQy92UjVkSnUvem93Z0dvaWt1ZWNwVEd5ekQ0?=
 =?utf-8?B?UjJxMHdSWnVNUHZscGY0L1RrTktwNXY5TUF5b29VaGs0ZW5BMytERkpDcnFz?=
 =?utf-8?B?Q3FveFBYUlNhTW9lS2NodzZsQUZnc2FWNDJxT3VVcVNFVVcvNEhVOVVDNWR4?=
 =?utf-8?B?MGg5VUJTV1RSa0FFenZFL2lldHhaMW5lTFFTZFFOT095clBJMFFzYjJ6L25Q?=
 =?utf-8?B?N0JSUVJad0RyZGJXajBrMWkrN0xra0hVZHZnV00yZEVFKzVYcitzUnZybC9S?=
 =?utf-8?B?c0lOOG9XcW13Y1cwVzFNamxicGZiUkJ0N0UyS3g5VTNvekNhMVBJTWcySmht?=
 =?utf-8?B?OE5CMkg2Ty9mc2p4WGo4YitXNTZxQlhONXdWZ0RyRGRSZklLS25hck1KM3pK?=
 =?utf-8?B?MStQMWo5amVFa0oxWlVGNEdJcFcrV2N0end1U0x6QVJDRmgyTU5zeHpkRHMw?=
 =?utf-8?B?TklrMEhtQm9FVVZZRE9IM21NMUk4c3h5NyszMXlOT0ZTT0MyZ1lZZmxvVmVY?=
 =?utf-8?B?SU91MDhIY24vT1V0NGM5ZXprajgyRXNJUmYrVUlVRmRaRVVPdE9xMWtqQXZL?=
 =?utf-8?B?RnhIN20yRVgwS3VyL1ZjeHpGcjZtS0h3RVN4MnRySS9lU2JnbzFYZWszUFVn?=
 =?utf-8?B?M2E3dVdrTzdxUHNXWlBIbTlrTDdkcXY1eldmU3dlVEc5Y1UwRDJvZTY0SEJt?=
 =?utf-8?B?UXlmbzA1ZjVRUXZleXpJcGZ0enhycy83VFd5bXB2UFdScXVSbk5SVy9VSTVj?=
 =?utf-8?B?K0NXWVFWRzczb3hpZGoyQUZPVFNiemdQU1YyY05pUmg5ZUlxdi9teFFOWXJx?=
 =?utf-8?B?cmtBZGhrQldBS2NJck05SjlNdzJMUTBXMHlWZDNJMVB5OHZJY1ArdktMaDg1?=
 =?utf-8?B?YUgva1VZbGhCVWpLQ3VnaUdjVFoxR2tJdGxzWUFNcGpZUEdhWnp3dVAySkFq?=
 =?utf-8?B?dTM5ajE5b25PK2dlNEN1SXl6RW5EV1cxMklSeGNJZWpaOFd1bjI0bVVZMEZs?=
 =?utf-8?B?c3lMK0U1RUFJSllOTWF1bjRDbzdHVW41aENUK2dXaisxRDdxdG1lQ28wUFJD?=
 =?utf-8?B?N2VoUlpIM3EzUnVVRkFha0xtZFltNWhZc3RXbk5yRFpEUnhNRlVRSmlHb1JG?=
 =?utf-8?B?WWVMWkdIbGxTK3NsSWFvalR0Wmk0N2hyRmtrWE1kNUFXZTlMN2JoUEpyVG1j?=
 =?utf-8?B?aGdmazhvU2dxc3JrMG9ONFRBNjdvWllTdG5OMUVJNHpZcGtDK3R5dWhmU3Vp?=
 =?utf-8?Q?O4J38H7rLqNGozepmtpntufcgmAGsyrUdP62oSCvorMa?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <62A51DD5E40A4A49AD1E120F3F9A4667@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9404.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fced9d82-8326-4c8e-9964-08dcfe2a2df2
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2024 06:13:49.2299
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0kUIMryUgCSshCn/NHkA++VoVz9wNM6atIQNsfrGC2VnJCQ76hLDTVncy6CJ+wt1lpllbfHvXuSgg38NCVs76A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5810
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241105_221358_473353_063A2DF7 
X-CRM114-Status: GOOD (  13.03  )
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

T24gMTEvNS8yNCAyMTo0NSwgQ2hyaXN0b3BoIEhlbGx3aWcgd3JvdGU6DQo+IE9uIFR1ZSwgTm92
IDA1LCAyMDI0IGF0IDA5OjQ4OjU5QU0gLTA4MDAsIEtlaXRoIEJ1c2NoIHdyb3RlOg0KPj4gRnJv
bTogS2VpdGggQnVzY2ggPGtidXNjaEBrZXJuZWwub3JnPg0KPj4NCj4+IFRoZSB0YXJnZXQgZHJp
dmVyIGltcGxlbWVudHMgYWxsIHRoZSBtYW5kYXRvcnkgbG9ncywgaWRlbnRpZmljYXRpb25zLA0K
Pj4gZmVhdHVyZXMsIGFuZCBwcm9wZXJ0aWVzIHVwIHRvIG52bWUgc2VwY2lmaWNhdGlvbiAyLjEu
DQo+IA0KPiBMb29rcyBnb29kOg0KPiANCj4gUmV2aWV3ZWQtYnk6IENocmlzdG9waCBIZWxsd2ln
IDxoY2hAbHN0LmRlPg0KPiANCj4gTW9zdCB1bnJlbGF0ZWQgcXVlc3Rpb246IGRvIHdlIG5lZWQg
YSBtaW4vbWF4IHN1cHBvcnRlZCB2ZXJzaW9uIGZvcg0KPiBudm1ldF9zdWJzeXNfYXR0cl92ZXJz
aW9uX3N0b3JlPw0KPiANCj4gDQoNCkJ5IGFsbG93aW5nIHVzZXIgdG8gc2V0IHRoZSBtaW4gYW5k
IG1heCB2ZXJzaW9uIGl0IGNhbiBkZWZpbml0ZWx5IGhlbHANCmNvbmZpZ3VyZSB0YXJnZXQgdmVy
c2lvbiB0aGF0IGlzIGNvbXBsaWFudCB3aXRoIHRoZSBob3N0IHZlcnNpb24sIGUuZy4NCmlmIGhv
c3Qgb25seSBzdXBwb3J0cyAxLjMuMCB0aGVuIGJ5IHNldHRpbmcgbWF4IHZlcnNpb24gdG8gMS4z
LjAgaW4gdGhlDQp0YXJnZXQgc3Vic3lzdGVtIHdpbGwgbm90IGV4ZWN1dGUgYW55IGZ1bmN0aW9u
YWxpdHkgdGhhdCBpcyBhZGRlZCBpbg0KdGhpcyBzZXJpZXMgdGhhdCBiZWxvbmdzIHRvIG9ubHkg
Mi4xLjAgdmVyc2lvbi4NCg0KSXMgdGhlcmUgYW55IG90aGVyIHJlYXNvbiA/DQoNCi1jaw0KDQoN
Cg==

