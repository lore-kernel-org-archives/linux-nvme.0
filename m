Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 330ACC433EF
	for <linux-nvme@archiver.kernel.org>; Mon, 11 Apr 2022 10:50:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=A5LBMlaJn3vIeXOZDM8/rxwD+G76/xlksGugWe99TWI=; b=KPMFxr1/DsX+pnznxwobnBQv76
	lG8O6R7aKFDbc3adBXUGaM+f3NjCfz25YOLXiYqqQmURdUGq9Hxv2Wc5oc9oEIHpJuoITXjtVRUN8
	fr8FCBoKyTHqkPS0MoHMwrb8/mxX1HUjwHBLT+uMFVAzwAgVjVJ+bLU1fwbr5+EzZY+iehVk3X6Gx
	0kAts2v40RIdwV2DlyA77HCyx9ujFOFt284XOoEbzDWiiZZLRkAdKYbHdzpybkgzd5BcM9zC9eu3g
	U99torgnAhWnHRRGcOtHWBLdaacPPo15H86mll4baz94M+5xNk5/d1mB+eh1d2NvZj0wvKLoMcyXm
	PGiMP1JQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ndrcQ-008UmI-Rs; Mon, 11 Apr 2022 10:50:02 +0000
Received: from mail-bn7nam10on20617.outbound.protection.outlook.com
 ([2a01:111:f400:7e8a::617]
 helo=NAM10-BN7-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1ndrbb-008UO9-D0
 for linux-nvme@lists.infradead.org; Mon, 11 Apr 2022 10:49:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G2Y9STFx8rTJCYBtEzJcFuZzEDes4nu9cuGW+kN45Z7LCzLoN741b2Qw1j4W7cOUClGoy7NykHjJEfeGEo4CosGLl9nczqR5zMd2yOC5HtnygaOZqvo8IgQYo7ij0K1Js7OOVnHI+xEWzbtKi/82fDSWtNaXueUqTpY1KSWpswCGdsMFpgHl38wQ79ftthOMo2/R7MyxMzSUPVdZiDWNiiB7TAAJ+XQogQXo91A7lJGlOcmixIjskDpXl8j2zpltFh8gnuzmgTgM8pzHMsiZIZTZmMj11i+Y5tlDovb8BNJksFm+Z7BmIUf0JO1wdtB2J5z1zbprHSa6lxC0Ap0Row==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A5LBMlaJn3vIeXOZDM8/rxwD+G76/xlksGugWe99TWI=;
 b=ATnLpgWdqXYInp5GvzOglzsGfxJ71hJisBIyitiZGNlD6MWo3AUfZsMf212xDcKA/p6T7frPCyRvZAWK4YjkkZACPE/mSWFdGvX0Hamk2HwZQhzZhZz+KekYXWF0kiS5MIBE9wjH8QzVyeiZxxlrcdRdIbBBGoGns8kOjikZdtPNzAlFndIjLSxEh/jpP6lSOcIik6aOhKIWc2UDGhHlRBBnTpzu1Uwt7XE4z0ztUOvc5ThTWzS4sGa1qXViToKYtxR0CCCOLNht5Wrf1fxop4i2LtgOYT8d3RxuSe34F5yKLfmTGHLyz/FZTyCsqR2l+6W28G/29UXQAwCVEPKBmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A5LBMlaJn3vIeXOZDM8/rxwD+G76/xlksGugWe99TWI=;
 b=LfH/dd2DMh+rIKEYqrdy4XDToEtzMz0F/ZFVEnDluU+QhTzUN/HkuHisaDzOqqvl96jxYH4Jxocr3CyOw8UGZJSAQoqXdCGTYKsqikHNir/ndeMaSBUR4fuQLT4jHwkCu+npp/9JMxOby/jta02Cq5S25UFLZ92CuvT8ln8wv4Pps1zXrF4uicOALBa3YlqJuuHgmtZ46WScUNDMGe7PCmO3sNQ2xsryFJMS6b8D6qTi/NLG+XX009tTHEq+lFH6h8YHc98Xt8itdc+QFQc6yq1rD2PpeUrqyAconR++mUeJxbVZpDO+L7Hd3BMR4Y/GURDfmLxJzO7aVlSjnmh/tg==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by DM5PR1201MB0042.namprd12.prod.outlook.com (2603:10b6:4:50::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29; Mon, 11 Apr
 2022 10:49:05 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::a90b:9df2:370c:e76b]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::a90b:9df2:370c:e76b%3]) with mapi id 15.20.5144.029; Mon, 11 Apr 2022
 10:49:05 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni
 <chaitanyak@nvidia.com>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>
CC: "hch@lst.de" <hch@lst.de>, "kbusch@kernel.org" <kbusch@kernel.org>
Subject: Re: [PATCH 3/3] nvme-core: mark internal passthru req REQ_QUIET
Thread-Topic: [PATCH 3/3] nvme-core: mark internal passthru req REQ_QUIET
Thread-Index: AQHYTVIguewqbSTMiE+3bgRKWDMtlKzqgwmAgAAF2AA=
Date: Mon, 11 Apr 2022 10:49:05 +0000
Message-ID: <8d29c59a-bb34-5f14-36f2-efd88659d5a5@nvidia.com>
References: <20220411031249.5158-1-kch@nvidia.com>
 <20220411031249.5158-4-kch@nvidia.com>
 <cffab35a-59b1-b5b5-a0fc-075268593235@grimberg.me>
In-Reply-To: <cffab35a-59b1-b5b5-a0fc-075268593235@grimberg.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 41bd69f0-9837-4637-245f-08da1ba8e5f6
x-ms-traffictypediagnostic: DM5PR1201MB0042:EE_
x-microsoft-antispam-prvs: <DM5PR1201MB00426FFF63C4E86894C61557A3EA9@DM5PR1201MB0042.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RCXEohV6NUwQUX/hOHchJVaQ6D4J4CQKIN2lgYDypBBgXa0W4dyxZzXCj2fPhQfrEuZ8WdP8va7UkWdzJ843QPYl0uo5XgUWfpz7o7HQX8l8JvjsiHd5qBBxCv/06mvgnqw7IFYlCVca5uBSwjYk8KpF4g4QrS6GU7n6HgnF9/2pQT6I8ZgMR4sgL0RWLYX2H4JkY3NJEQXrtQFd0NRPA/Y78Yj3BEbHqkxn3pYCyNzR2Ra995202Tku3TVFAPf9IvKUr1IS/h4iaJpNmxCQCU+zL6161CF/PJRDTHumhTizgjA/njAO0x54IE8c5DoJmWmXL7b11wQfX8lPO6THtTW/SVhsrbMGoTMmU9ASutkMRM99PX6NdxN10nazXxkE/0KEJD7O5KrA/14SWecspguppQY2Gvy90z3Q3BpyxKeLIqjdDqBRASS1yaV6TOVqNKT4vEucn5AHbdMQ56bm7WirrVihfAT1zQ/eDq3Sv4xAFZ0E8FdIl5b1cWauOBc0egUIR7b0BM0P+hdSGMcnwlhxtu0/OCVQJiwynZFZLso78TCK/cIzWkJrhH2wvf93G4g4n55XaFucnZ5GNBrmm9BaxO2N4KJA658DVUhUe+VESIlG1fEPA1H1ZsoC31FR76NYYGWomDYsQZrceG+GiaCI/iy+tIb0OloIYfjVrl51v/D/2KOwmqLJ8gk+DOGc57/v3YxqPDtr7flEPP+vKF3opoAQMdndDCnGa1KcciYfdPv+BvtpByu8c2XoVhQEznGWdJAwhSWIMWJY8su2Ug==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW2PR12MB4667.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(38070700005)(186003)(2906002)(66946007)(76116006)(31686004)(86362001)(4326008)(66476007)(2616005)(66446008)(64756008)(66556008)(122000001)(508600001)(38100700002)(36756003)(71200400001)(91956017)(316002)(31696002)(54906003)(110136005)(5660300002)(558084003)(8936002)(6506007)(6512007)(6486002)(8676002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dDB6WndWR3k2UmpsSnBEV2JtWittdjJNSGR0akh0VFNVVS9aeGRxcm5aT3ox?=
 =?utf-8?B?VHh1VVZDRlJnc1ZHc3BZSEl4MWNIVVhFNG1XUERYL3I0OHNBNUFYTEhtdjZY?=
 =?utf-8?B?NHBScFhxZTlKYlhnVVp4TFUrdWwwcDVicER4SWRlQmh5QjdrczI3cGV1Zmc3?=
 =?utf-8?B?Z0oyY1EvSGJKY1gzcUxGTGRuZUtzNTE1Mmh6LzZGNzhFSmFxWUVqdUQ1R3hU?=
 =?utf-8?B?NnpuTjVKZ1AvS3gveitBMVhUTXJBbWtMWWx5QnAwbnhQSFNEa0M4MFpXZlJj?=
 =?utf-8?B?eStjclFwaWVOaVJaV0RKVitrOHFRUDI1cHRNUGp1Y0JmMkp5YnkrTVZuUlQy?=
 =?utf-8?B?cmh1V1M1U2F1TDNHZ0FZeHRCVmNIbDFrV2FDekRIRGJacEtHT3E1Szd5aG9i?=
 =?utf-8?B?QkpSVWhVL2s3UVdUSy9BeGF6NVo2cEc1Vk83UWxXc3VxankzbjIvVHNEeGhw?=
 =?utf-8?B?Sms5SWQ0ODNFcjFQWjB0VUlvN2xNVUlUZEVnQno2SS91RGxsKzFPbHQ5T01n?=
 =?utf-8?B?N0hGRTVGZS9PdjhMRjBtSGw2SzI4WitIeW9pYVRZa1BvV1VjdW55TTJmQ29W?=
 =?utf-8?B?NHdJQnA2SHEyZ0pwRWo5YnRuMTRncG9tWlgyUndHQURjWUVNMHd4NkZLK3JO?=
 =?utf-8?B?VU5aZXBDTURxNFhKb1RLS2luNjRRTWJnWFcweXhhSzVLYTRpREIrZVVpOE1S?=
 =?utf-8?B?aDFGUXB1REprOEk0OGlWZjRDZWpwdnlESHhST29tK01ZdndKMjg4OWIwbUVs?=
 =?utf-8?B?VzEyRnlPUkZHQkFBNGJkYTlxQWgvL1NSdHZ0ZnBBSVV5a0tTcW9qOENnUHM4?=
 =?utf-8?B?RmdSVnBkMWlrNGRrbWJSWkdpV09rNlc4ckVzSllzRTBqc1h1T1NabXdkbWYr?=
 =?utf-8?B?VWFHbEVLa3hqV3VsYXZXZDNMd1JLbWVYOElIS0tNczhCT1NMeElJMHB1ZUUw?=
 =?utf-8?B?ZTU1UWJqWUNTSjZyRUpLYU1GUUFaOXBUY2k3bzhGdkJVSDNWUkRQSXdsN2JX?=
 =?utf-8?B?UUpwSVlDUVh5NVZzdzJSbmxrcEsrQkNoUWlHZ2VoVWpjeFdaU3VZRC84K0Nm?=
 =?utf-8?B?aWNCNWpobFdVdjVzb0tkUVI4c0ZOSm1ETHNzVFJwWi9raUJQcitWZWFJUDVw?=
 =?utf-8?B?YXl1MnRzdncvT2FOVTZrU2I3blp1MldhcGVxRll5dk1PelNRd09EcTd1cTMv?=
 =?utf-8?B?MDVWMWw5dExnWjJpWDJzb3ZGalBwalF4a2Q5QWZRVWZGSmE3RDJCeDhyWThR?=
 =?utf-8?B?QlVaM2UwRkQvaEZ3MU8zUE1JTXFJNmdBMzVsOU00bWJlM3RKMmIrYlp0MVU1?=
 =?utf-8?B?T29rSEVEa2ZIOUthWVd2TXQ0NHlGK09lYTVGaTB3dGtuekt2eGVwTkI4M0Y5?=
 =?utf-8?B?OXZjckZMb2ZjdVc4VUp0U3ZVWStKNmVuaElsdHkrUUNmbXZYcE5YT1NjTHls?=
 =?utf-8?B?emFoUlNwTXJuSjc3UlBsQmdZbnRnZUw3aFJ1dUFRN3Bvd1dqSjZwTVdFdzV6?=
 =?utf-8?B?TjVFOEtJa2MxZ2xRVU5GMCtpTkJDRUN3d01DODZDRWU3S3BpbnRJSVNtbUly?=
 =?utf-8?B?T0ZXL2hyYm8yM1IzSGR5R0Q4RlE2alRjWm1vMitpc2ttcHZSZnRaZ0crRUVD?=
 =?utf-8?B?ZFFFSTljWktqNy94UGJPSlloR0RyRWVFc09GNmh5WWc0bWVVTnpwNERwWFhs?=
 =?utf-8?B?bnY2cjB3ZG5UejVhNEVLa21LUG1aczV5MHk3bGxvOGZZZ0s1djVWUGJYTVg1?=
 =?utf-8?B?T3FPVVZmaHZrSXJXNlhrVEwzNkc2bmFUVERvVGQrMU4wMWFsNXJFTDd1YkRv?=
 =?utf-8?B?OTNjajlyblZxbmlkK05MS2JzYkN3UlowY2pBUGQ3aS94eXdaVzBRcVdxbGJM?=
 =?utf-8?B?bUQ3L0RreitoWG9FRmRvc2J1NUlPblJxSC81NTNmTmZJZFl6YzVnbHgzKzVr?=
 =?utf-8?B?a3FudlRLMGY5a1ZldWFxcTRja0JRTEI4cGtkUC9XRXlDTGxtS1VBOUJYSHVu?=
 =?utf-8?B?K2ZoV0VxdjhkVWt5d2xNRjVtRThYUThlQ1B5Y1BnTm1sR213eHVZeGVvWnJD?=
 =?utf-8?B?SXZGOFZxazlrV045T0VnYzVMV1JFOG9sT2tnWlhUVUFmWHplTW9oSWxGa0ZC?=
 =?utf-8?B?M3VZQkQzRWxIZjE4OE1qa1gzVE5TQUpycC9Za1k5ZXVqUjJPbGxGTHRTZ0Uz?=
 =?utf-8?B?QUZjeEFoWC9LN3hieXF6b2RwWUdlTmpQTlVjMi9XOS8vU1U3eFRjOTV6dkN6?=
 =?utf-8?B?Z0ljL2RzdE1aMTNBdEdxUzJudkR3VWxXZFUxVlphVUVYZzNuOWZMYkVjU2tj?=
 =?utf-8?B?TVFyMllyaW9FZDJWUDI5WWtRbzBqVmxyeVFTTENSY0RqelZ4cld4OFVteHAr?=
 =?utf-8?Q?klpo8RMmnPdjxW4ojGspYerODW5+fGZOnVoxTK45BtAEh?=
x-ms-exchange-antispam-messagedata-1: GOhVOxu5iMEM+Q==
Content-Type: text/plain; charset="utf-8"
Content-ID: <9FE3820DBEF69047B71D9B7E1627D83A@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41bd69f0-9837-4637-245f-08da1ba8e5f6
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Apr 2022 10:49:05.1509 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5x6d32McigV1J09LX0goQLB6FdwzxAuv/0K2cmcfqsbcbdshOqzV9NBFwl/pQj1eRk7k7E6b/IDcCUaC50ElQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0042
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220411_034911_484704_B2DD5DD8 
X-CRM114-Status: UNSURE (   8.01  )
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

DQo+IA0KPiBPdGhlciB0aGFuIHdoYXQgQ2hyaXN0b3BoIHBvaW50ZWQgb3V0LCB3aGljaCBjYW4g
YmUNCj4gYWRkZWQgaW5jcmVtZW50YWxseS4NCj4gDQo+IFJldmlld2VkLWJ5OiBTYWdpIEdyaW1i
ZXJnIDxzYWdpQGdyaW1iZXJnLm1lPg0KDQpJJ2xsIHNlbmQgb3V0IGFuIGluY3JlbWVudGFsIG9u
ZSwgdGhhbmtzIGZvciB0aGUgcmV2aWV3Lg0KDQotY2sNCg==

