Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAE2FC54EBD
	for <linux-nvme@archiver.kernel.org>; Mon,  9 Jan 2023 07:39:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0rTuFt59GqZkDa7mJho504aMHGw2aMTcu/YAi5hAxHU=; b=Of9gcp5oT2avt01l6HAJURE2gv
	kPus/v+q3EH0l2vq3LX0A6Q3ZJ+rKioPohl/gW7CbTSvlu675Fbzf8Pwv86AatdLLKc54LQgrELVD
	+vejddQfle6RqVvj3lo/fni3qdg/zI81R/zNLSTBrL3g0BAYSh4UpAUTMaucBoJ+mTUItXWfmBup0
	k6hlJ5L7vvJNJeRrVqSEzFndqbLOjffdmv9w958hsQ9louKrWWCo22AvjYw1zAF0I4m1lux7YA6lS
	5OyFR92senoDUwmRWwLZdiZvDqpeasHpAwi7beT6lDoRETq0FeB8/7GM0aOfoIgwqaOqpXiteNkU5
	SKZM5aaQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pEmkX-000EPo-Cl; Mon, 09 Jan 2023 07:39:17 +0000
Received: from mail-mw2nam12on2064.outbound.protection.outlook.com ([40.107.244.64] helo=NAM12-MW2-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pEmkU-000ENo-18
	for linux-nvme@lists.infradead.org; Mon, 09 Jan 2023 07:39:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TRjCi6CBYwMLQkT/k4GqWVhr0/iiszc9kDTId9N1D5OZUB37hdlzspF/DOsdO1kOTH14rG2d0Hu74kNDUpcDGpbD4GMLNUoAzEuHSdErwb5239STbZOaAutvE5CHlD1ZvUJ1mTwtD860mnawDP0abQKHk0p7WJsc+uIueHUnFQg1rzhjAjI4gMsUTEt6Zt2joHT1+dlSs+ZF80n8150pDSBxjHgnNjPNqpkBZ7wm2nZsHNizJvUmWZwueXD5TD0L3I5D9DNHS+MdAaN7fdfJsyt06JSbgnGjkjIod2aRcOStx8EOIzpsxHEyimrIcUgwMghUwCXzSG0DECS+EfTq2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0rTuFt59GqZkDa7mJho504aMHGw2aMTcu/YAi5hAxHU=;
 b=L8lZLARRkN1SWYQCN7xGj0On+2cmrAnmjZ2WPbNZja8Gc5i9ph7Xrpv9fBHXsWXiEWh3tox/wPh+sHVX8XefAh8Od/JRulCjnbfCL+/21ZKhf9UCsHWFwQIGOGVWwx3m+uFXl8LeA/MRi7ZKoEqLkqqJTnIapFl5wQOjNd6zXlTVCFMbEKVIp/yQSkQ3QbeIOkRYD09XVNVp+dzp5Pr1CrOtjEtudEY6ZeHyYMigwi8A0xWZt7fOVOH6IYdYJ+6/Fk9NMyUawSq45K6VCe/+gdVsZXTRk3OkqMu+6XStZFAMxQeQCrZD99ZEpp4M94Y6TmlO8hqhOeNjTxCj60nxQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0rTuFt59GqZkDa7mJho504aMHGw2aMTcu/YAi5hAxHU=;
 b=CiJh/z46UY5gKcvslaVQkx2CfTadMTbhm7IBskzZxU0r8+6aOn501BTJeeOWUkSnIeFIrGNhs8R/vf1i9bh2uolSqatsxvdjr5VYk971v9Jf3zBMTBH0qJAqLQwhY44OZoKDJDjmWyStrRWzBUyUfF0Nn/xAgk9M2g1TQ7X6Z15JLfQJEqZBSmEv+vLCqkGFrHaUIebF/9B4T/4TJXR/uaAJjhMNrhSDGfwBpY5SkhGMtKqj8wDOp3Jt2tH8pP7MlsK7x6G9pBCc94WJxcycFu31/7YPILYjD+ySmTd63UesX/pp1MQdf8fQ7iMqXU1p+lrnGA5244eu5rgDerl4rw==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by SN7PR12MB7250.namprd12.prod.outlook.com (2603:10b6:806:2aa::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Mon, 9 Jan
 2023 07:39:09 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::b84c:b6e:dc0:8d7]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::b84c:b6e:dc0:8d7%2]) with mapi id 15.20.5986.018; Mon, 9 Jan 2023
 07:39:09 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Christoph Hellwig <hch@lst.de>
CC: Kanchan Joshi <joshi.k@samsung.com>, Chaitanya Kulkarni
	<chaitanyak@nvidia.com>, Sagi Grimberg <sagi@grimberg.me>, Keith Busch
	<kbusch@kernel.org>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>
Subject: Re: [PATCH 2/3] nvme: replace the "bool vec" arguments with flags in
 the ioctl path
Thread-Topic: [PATCH 2/3] nvme: replace the "bool vec" arguments with flags in
 the ioctl path
Thread-Index: AQHZI4Fd5MqEcxCJgEmDwZldy8UzsK6Vs+cA
Date: Mon, 9 Jan 2023 07:39:09 +0000
Message-ID: <e505dc08-8243-d10b-8e9b-5da49e5414c1@nvidia.com>
References: <20230108165033.380842-1-hch@lst.de>
 <20230108165033.380842-3-hch@lst.de>
In-Reply-To: <20230108165033.380842-3-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|SN7PR12MB7250:EE_
x-ms-office365-filtering-correlation-id: 03035aad-a944-446f-044d-08daf2149825
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  vwRFf+1EvNv/yioQ3RXlx+vwfjz2NPVv3phb0xUKQzxA5BwxYBj2UNq7lxVLIbux7lvC6EMAonB80tFW0GBgTIRTKHxjKYEWzfStFGlSoNQMu0qQ9B1fOZALw/BBi0398I6nN/7RGNQPqVMoOJtd+bxV8J9RCsvIYV4wdWF3Hkk7OP48/cZIKit2hnGMehmrERa2fYOQ3PDu6lgdCibVqxEdAbW+RKIOXEooAu07QCLIbVz/RG5orYewoh5Z+wTG48Azyh0FhsX/+Sqky+srb6XHAzJRN7kEMRqm2HcsI8TIaZDlZrtHZz3jyJWqc762XAWaSbBKuKKdbKWv0Je46p5cl05+x3hKybkTnBGIBxKKriQm1lr9U/kqNupWz7ZC/KdXEK7ff4kCI5HQisnUCqKog2q/Wkvh6HMv22FGEpyglNW+8o+I/QeCyr/V5Dv3FYdGHQUZieOUnfOMgF1VNEJY6aH+nT9EtnnXjt6jPvR1uWR/lpwzY9CWxRZhNGeeGaQw3JS+hQobiZcDlQ1SW31sb4K/QPSVoYP2mas246oDB0n6stgSwSp25lPeEuthXwZXH7AzNhHaYb4GiG+s3g46J3YsMXEGDghImiW3iwpDbCDVtTKgW2tyDoc3zC7MV7TnAsDAFGIZLSLs0WCnXF9yn3km8NoCLPe08R6pEVRFMqw1G/2mDaPk9eRT2vMwpOvt6an9ZHmGYiObHgvw2gAccyg0+/sjADSGrED8RrDG3IFuQ5n777KKtSfHwt0Ri0ZsCBgurfLmR4r4rUCkRw==
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(396003)(366004)(376002)(136003)(39860400002)(451199015)(6506007)(38100700002)(122000001)(53546011)(31686004)(2906002)(6486002)(478600001)(2616005)(558084003)(186003)(6512007)(5660300002)(316002)(71200400001)(8936002)(36756003)(38070700005)(86362001)(31696002)(41300700001)(76116006)(66476007)(8676002)(91956017)(66946007)(64756008)(4326008)(6916009)(66556008)(54906003)(66446008)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:  =?utf-8?B?bkJDclVTcmM5d0lBb3RVVksrNEpON2RSLytoaThLbTQzU0ttZlMwUTBhY1ph?=
 =?utf-8?B?RUpSOFNnM1R0Q0UwamdpaEp4bGFTcXBBNFlYdDdNSzFGRXVWWDgrblppQTRY?=
 =?utf-8?B?ZFI5RnFKZERZODk1eUgzbXBrcUE2L1hVUERBOVYzWkV0QU43aE5oR2NpQ3o3?=
 =?utf-8?B?Z0lrOUpIUHVNQlJSQnFHaEN3dHVucVJsRnkxNy9sUGZOaEZrZjlFUDNYY2Vj?=
 =?utf-8?B?UFZ2OGNIS0d6WVdMdjRFV1E4SXg3RVlXb0w3bHNoWm1kd0dJaXk2d01INFNl?=
 =?utf-8?B?UG92a2E1eFRQLzRYVFBJVm84anZQalRQUzk3amhYcGMzZUdyc1JsbG1RVFpF?=
 =?utf-8?B?QWRFN1N1Sm1XSS9NUXBVaFJ4RnY2TFpmSzV0TnhheXhJdTJQSW5MN0xZYUJ5?=
 =?utf-8?B?TS9pY01Nek9XWTVBaXBWcUx5cWNNNlRSNUViY24xN3crVTZqU2Znak5aZHBj?=
 =?utf-8?B?UndoVzIvSWhZam5NeDE0eUplZUZWelFqZ3lnTmxCdVhoWi9yM3JsRjdlZ09h?=
 =?utf-8?B?dHRLOFIvZkp3OXNaWGNaTG9mc2x1SEsxMG1XK2dWMGw4V2pTYno3czRyWEJ3?=
 =?utf-8?B?QmNyQ1IrOHVYUUlpU0hkdHFNTDV2bHdXV0l3QW1kZUViM0VacmdGZXd5bXFn?=
 =?utf-8?B?RFV1SmlEV3MzVGZDSUkyU2Nzd04zZy8yelV5TW9NZVFVekIyenlPQjdSMDM2?=
 =?utf-8?B?ZjZBK1FvVHR3N3FYdFFhUVFsYUN6eDhHNGQwZ24xUWN5UGVWT05nSVBKbTM1?=
 =?utf-8?B?NURGTWxsNkhZeVQ4elJ3aUxvUGUrU1paNmFNdCs4S2NxUUxtTUZ0cFlNaHM4?=
 =?utf-8?B?T05tWXJpb0lOVStsaDlOTVFqSVFuODk3WFZoNmw4TUxQbkMrVDNKcFRDZlVo?=
 =?utf-8?B?Y3dlQVNrVXZodDUvSGNsaTBJaWQ3MjkzekEvYXlrK2xWY0s2dEJuWE5Ed3VR?=
 =?utf-8?B?V2d0M2JMeHRXaE93NlZpOWsyMElSYy9yUGdSdXJvbWMycGdYYzFGVG1SYjNr?=
 =?utf-8?B?Ky9oNjI5ekd4dlgwK1hqemI0V1MrMUtTU2pSVUVCdjQvM0tPNEphdGVxT21n?=
 =?utf-8?B?S3FOL0tVbnROd0EraEl5YkF0eTBuMFdjUkhjSmFGRjRySUg2SFJsUE43ZFF0?=
 =?utf-8?B?aGI4WXh6VTlOdHM1ZTJFMWJXLzNzdENPdTZYTXU5K25FOFlVV1BwVXhablpZ?=
 =?utf-8?B?bEZhSms3TTc1L1VjcUhXRUcrRnNxazV5VjRMRVRDNWZKT0lSREhJQXp1ZjVw?=
 =?utf-8?B?NjJReGxMUkRLVVNHa2trQVlGaStjT1ZkUnNtbjdFVWZWdWxHR1N0Y3N4RHZ0?=
 =?utf-8?B?WUZhL0k0bld6ZU83Z3pGNGsyYVNETENBakF5S2Q5M0dhMHBwbUQwL1p1dlRz?=
 =?utf-8?B?OVRHUUt4Rzd1VDdQTWNrelgxcTVIaXhzdTBaMEpweFVKbTRtV0FURjBhYmwx?=
 =?utf-8?B?ajZKUTVLc1UwWmREM0ZWc240S2ROMVQ1RWxJRGIxTk9KaVJoZHNzeUh2SGRS?=
 =?utf-8?B?cm5SY2RPUHR0VldnQXFJTjNLR3BTWHhXNUw3dkVDbnpKcDBwTXF2Ym9xQWly?=
 =?utf-8?B?MERWbzhkVXRYR3RvSWtQWjB2OWlPL0o2ZDE1bU1MQmVxNkZSRmtSM2ZWU0Jw?=
 =?utf-8?B?bExaeERUV1ZBUWJiSktwNFM2N2djL3loQTBWdVUxeEw3bm9JK2pZRVNmeGds?=
 =?utf-8?B?SC9VK21DWGt6T081d2Npd2FTWThqQ21nU3RuOWZuTWdtQTc5dTIvd1RveEl2?=
 =?utf-8?B?QkRPTHBaQVF4TUtnaXIwZS9ad0dKcTlpR1R4cXRwZVZ3bWxPTWVtQm0ybzh3?=
 =?utf-8?B?ZUtpNjlLY0I2QmJsd0Q0Wm9UNndFY2lpdGE0UDUyb3hlTUU2OWJTVi9jdWNx?=
 =?utf-8?B?QVhQUzI2SE54R1pFMi9ZRXl6azhiL0J3dkhoNlQxZFpPTDBEeVlwQmg1Zjhy?=
 =?utf-8?B?TGlrcGFDaExWTllROEc5MXY5ckhFM2hQVzlramZ0ODF4Z201Z04wMWIvS1VN?=
 =?utf-8?B?TFdLYi95NUdiRktzVVdNQlN2Qy9Tb25jTndvWlM1ais0b3I1YWxRK0ljRTA2?=
 =?utf-8?B?Q1U2Q3FDYit1aFRsRlBQYUdtODc4bGR5Uk9DSnRSS2hPbzlLRk5KN3JtMFE0?=
 =?utf-8?B?TzJNOGk0bTV3REhQblh1MmhUdU05Y3VtM0tzc0hJSWJ2bVZwcHpKcHVDZk1N?=
 =?utf-8?B?d3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CFCEE12A73D84345A304A14A25A7B561@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03035aad-a944-446f-044d-08daf2149825
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jan 2023 07:39:09.1864
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6RJf3jAq7wac/R8LJR+v3P/Gq3L0QMyI6GrytvMxoGrGvy8TUmTf1en6VeOuxCNTDdN9YimOrZIYLHTgBL58JQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7250
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230108_233914_092555_A5491901 
X-CRM114-Status: UNSURE (   9.78  )
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

T24gMS84LzIzIDA4OjUwLCBDaHJpc3RvcGggSGVsbHdpZyB3cm90ZToNCj4gVG8gcHJlcGFyZSBm
b3IgcGFzc2luZyBkb3duIG1vcmUgaW5mb3JtYXRpb24sIHJlcGxhY2UgdGhlIGJvb2xlYW4NCj4g
dmVjIGFyZ3VtZW50IHdpdGggYSBtb3JlIGV4dGVuc2libGUgZmxhZ3Mgb25lLg0KPiANCj4gU2ln
bmVkLW9mZi1ieTogQ2hyaXN0b3BoIEhlbGx3aWcgPGhjaEBsc3QuZGU+DQo+IC0tLQ0KDQpMb29r
cyBnb29kLg0KDQpSZXZpZXdlZC1ieTogQ2hhaXRhbnlhIEt1bGthcm5pIDxrY2hAbnZpZGlhLmNv
bT4NCg0KLWNrDQoNCg0K

