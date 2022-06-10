Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14212C433EF
	for <linux-nvme@archiver.kernel.org>; Fri, 10 Jun 2022 09:18:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1CUInpGsZONKKULZeGqEaJb7tCYr3WfGzOjhT7PIq5U=; b=IgNQ7+FK9GdWFkAwNBuvYNqcSX
	9NSY8Ydtw4SX8xzJmpb3X10s3SUWIWSXkL9fypONTkmO7pCPc+Cfe2lMcLFJXEPNQe/8OuYH/gi0f
	aQv6YmMScVzitCF0SnT9TCfUN+C/r7z4Cov8UlY+vJEr6Aiqkp7miCwQmz8Q+V4y/rcIj8O9J/O3R
	prbOXGNP/17msQdHXR8TKT+BBhj//gf1Hgt4mdI7CaI4dllqzqX5hhl6Ya8rUJtBz2ncOpswHJIsA
	aLLkYvVOy6o/VdJm0dEPk92SjnXskC40ECoyNBq6D7EEFsNSuDSVKFR6RdrsKcxiC7vFGRIesn3VC
	I2yvuyBw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nzamk-0075Cv-TO; Fri, 10 Jun 2022 09:18:30 +0000
Received: from mail-bn8nam12on20604.outbound.protection.outlook.com ([2a01:111:f400:fe5b::604] helo=NAM12-BN8-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nzami-0075BM-Ci
	for linux-nvme@lists.infradead.org; Fri, 10 Jun 2022 09:18:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JQsS0FXOF3mwaVPJuNbbscJU1zvA/Kl8js+x9we10RuHukAy4U7LK2HozY8f9kOsJKRGV2hJuB08wHrUts4cLrAuZ/V0bYg3KW8AiaKBKrPkVKqIvpqInujWY5sjWIAKD7qhK8qGWb1aCBURq7ec1JvuWStsnCheOlxeTIvt04g24oLYCCQdiw/mxDoPrf6z4VpW+5gMN6R58cG1PPRY4OtNYdIplDxfQTua4zlNV3R6wEeBcQvjZbdYCM/jL/X9Lb062ckewa3itJBPbEWOQDNDQjXafzViF4/bykyKp0bKUledPqVy5knozmeZ0wedfLzOVAC/GC0f9Gxv2YIHdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1CUInpGsZONKKULZeGqEaJb7tCYr3WfGzOjhT7PIq5U=;
 b=io+9NPFG611uzWtGkJV9NOov2b/NDPR33mTeKcZuS61kw0EpHh3+xavGCgZXdSDVnAWgUCvhyhza/wrZDoxmaxTW6zV2heIj+n+boRqSK3mM8GBS8fZmRKprNDl3HycP3pH+C8Tr2hb+FdCTpOyQxZV2i0CdTK6CdRxrBu0kz7vniOCZA9ZK46WAw5gMfVzsBNrzzgctj09CkljizgjJ1EVw7HJ0x5foJr7PhNK/1/CrV+Yb3jGPkD+HxS+WWw37I2H5VqPvVdPCyatBc+0iFJLiAipp+EhHIC9lNDwjZEuqAFdB5kGK786VhvpMYJY3IJK0i/WLP30hqmj7/slAUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1CUInpGsZONKKULZeGqEaJb7tCYr3WfGzOjhT7PIq5U=;
 b=QjhUojivQAHKAcad4wTdEE4ksQrRZFhSRfDpbcJiN7Drt4aChFbrBT2orfLqokP04DCFlZojp6xBDWbUVS+/Zbejr4izRzv0giPS8QXxam5fsWediwgYylsA1/n1uMqFnSUdV1OhUiRlbrgnRED6JXdh9ISQCHzOebNL0bjovWraV3VsYtwNTqb7+mxzgTKOFvtNBvqGyJMFjm58Y3d16axuJiUndTvbHLnJ5hJHFqFYUqE0SbtqDOiTJ+XnTX424GZCttEcsXOwOJ8K22TWDICXvvubm4+0Kpw+yhv861D/GLDZdG//1k/ahtiy35f93ZI+gRSNL7y/g2cW5FtbLw==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by DM6PR12MB3675.namprd12.prod.outlook.com (2603:10b6:5:14a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.15; Fri, 10 Jun
 2022 09:18:23 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::6dff:6121:50c:b72e]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::6dff:6121:50c:b72e%7]) with mapi id 15.20.5314.019; Fri, 10 Jun 2022
 09:18:23 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: rasheed.hsueh <rasheed.hsueh@lcfc.corp-partner.google.com>,
	"kbusch@kernel.org" <kbusch@kernel.org>, "axboe@fb.com" <axboe@fb.com>,
	"hch@lst.de" <hch@lst.de>, "sagi@grimberg.me" <sagi@grimberg.me>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: "Rasheed.Hsueh@lcfuturecenter.com" <Rasheed.Hsueh@lcfuturecenter.com>,
	"wuxy23@lenovo.com" <wuxy23@lenovo.com>, "gwendal@chromium.org"
	<gwendal@chromium.org>, "rasheed.yh@gmail.com" <rasheed.yh@gmail.com>
Subject: Re: [PATCH v1 1/1] nvme-pci: disable write zeros support on UMIC and
 Samsung SSDs
Thread-Topic: [PATCH v1 1/1] nvme-pci: disable write zeros support on UMIC and
 Samsung SSDs
Thread-Index: AQHYfJNO1CYCbpdOe0WUjDSrwY+d+K1IXOqA
Date: Fri, 10 Jun 2022 09:18:23 +0000
Message-ID: <64e6741b-b9e7-51a6-7f72-fa5fd75a844c@nvidia.com>
References: <20220610062734.9927-1-rasheed.hsueh@lcfc.corp-partner.google.com>
 <20220610062734.9927-2-rasheed.hsueh@lcfc.corp-partner.google.com>
In-Reply-To:  <20220610062734.9927-2-rasheed.hsueh@lcfc.corp-partner.google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d661dd07-d13a-4603-0c99-08da4ac22b1c
x-ms-traffictypediagnostic: DM6PR12MB3675:EE_
x-microsoft-antispam-prvs:  <DM6PR12MB3675D5C837E6C846D1137E4EA3A69@DM6PR12MB3675.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  MbzcEkpbrGarjGGKXNeJn/CsyUbN68c8F0Q/ycq0bH2HwD6TPOgfIkZwgVQJw34CapBGxVr/QnorZS1fsnAmYqdu9FqHHrv/CpdM7W8+KyecZnrLazp2h08jqme1C7r391LhgkK6QPWPROqrTV/fron5D+sBTd1Wb5um0eL5I0TO5XszS6oCzl/hqzQP2BcRaJ+r2+Ny3EdP1tByYwcXKVPaWAzlp7QGqeLF2XfRyZP99OPlc/qbVa0UO//VRWY0mxIWVYpmGdotrAx8RI+CHuIoNHTe8nvnuKI6cqAlmCplqvZPBTaGc2LGiUaEbQ1acY4seOzX1oRqqrti1GjdgIe7/kKTNaQxqj3slvguVFpixnOOp8UD6dMlm5Er+Hxnsia8p2hFBvWqNmPLWOnrVhpvixsDDGkkAhZvnHa8XZr8r9U6H+lQGUcpOYU7tGLKn5c3NRe/sqxmWFNFhZcNCqS55CdKZsmIe4ZbBtTTo3dvTmKQAqt9z42flScp1NU8EkW0TvB6pasZpt+p1Q5R6WY4Zhd2QwX3Et4vt08DXkX0tJvWjal3lFVJLUc0dPTBiUWaQ6JinDHWRlrUfOz/k+DJGaH5IMp/wxW+XtRm2rdWdA64eIuKBWmmgQqaHQT7TJBU411PiwB5YBp4uFK2FeMAg3msebA3l8sewmlC3BCzbYJl74Yb4lUKi1RniTdJ2AMCTNranGKPh0K319jgEig/ppobxU4OBxgthypjvpLxxBMuYRTnX+T8rydTfzSbDUygQvPSPiuImh0ddshGEA==
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(38100700002)(36756003)(31686004)(6512007)(2616005)(7416002)(91956017)(4326008)(83380400001)(508600001)(26005)(4744005)(5660300002)(186003)(110136005)(54906003)(66476007)(66946007)(64756008)(66446008)(66556008)(8676002)(76116006)(316002)(31696002)(86362001)(53546011)(71200400001)(122000001)(6486002)(38070700005)(8936002)(2906002)(6506007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:  =?utf-8?B?ZlhTdk5CWURqcnNBL3JSRlRxNXdqLzRPdWhvdnFkYXhxczFzY1g4T01hQ01w?=
 =?utf-8?B?RDJYTlVaWWc3MlI1a0NOc0g5M2FLWU9RSVpYZXE3NlFPUDFBRi9vbm1yWlBk?=
 =?utf-8?B?VllucW9nalE3bWRHcDBWMmhtVWtiVkNpQU56bEF3N1RoVVNoT1BQVnlLWDcz?=
 =?utf-8?B?b2xGa0NqKzR2Z2RLVUFZeWd0MnB2R2tlb2VTcjZiWllzMW1URXhKekpqbDUy?=
 =?utf-8?B?RlRVTWNybjlRZlJOSy9nR2RpczIvQzlHV2laWG1ENG9pelRzU3VQSGpWYWRr?=
 =?utf-8?B?Mm0ycnloc3JjTytmWjBlcVpLQ3RWN3lSOFFYMnE3d0ptUVFJMVQ0K214NFYy?=
 =?utf-8?B?bVRabi9UaGJBek9sbEdxV1hseCtub085TVlLdU9MeFpJZDdGenAyTGRQSVpN?=
 =?utf-8?B?QWYwUkgzMjJla3U5MDVYaFo5czV2WDlBbEJ3U2N1NWRJN2NOdnR2TERpUFg1?=
 =?utf-8?B?ZFRSMi9sTUdJMkNUakV6RTNjbHVjaWFXNUhYeVVqVzBPT09xeEZXZzBRaXUw?=
 =?utf-8?B?VVpCMzZXZ3R6ZDVJVnExbmhORDJ4R3JUZVpXYkRRUVhTekx0aTdlT3hFMkNJ?=
 =?utf-8?B?K3ZBV2hSVFFabmFPYWQzY0RIdDA3eTVmMXBiUFlsaWViOWE0SVcxdW14K2wy?=
 =?utf-8?B?SGZkbHJEQnBBSGV5dTZESk8rcktidUxxajJWZnVHKzlPeTdJYTdDNmlYQ2ZC?=
 =?utf-8?B?UWszeWtZTVh5QldDdlU3RDJnMU5JQXlBMG1ETGc5SGJiSXBsVVZCNlA5WmEv?=
 =?utf-8?B?ak02MXBWVTk0Q25ZUENHZGs1Y0RMT2RyWGdEcWlDbVJLYmd2YnJxSWlUbHRm?=
 =?utf-8?B?UkM0NnFaRlBkcW1hV1RYb2l6aDY1UDlKSkd3dnlFLzNqSkduNFZPNm9mbjc5?=
 =?utf-8?B?YkJLUm1GdUpmRFdPdFJhRnMzV1B5eFhJWWVUdVJCNmptZE5sZ2x3ejZFNGk4?=
 =?utf-8?B?OE9uSWhRODB0REFxSkJzQ25WS1VLcmU0SUlOKy8yVnNNY3RCS3VCNk05NUt2?=
 =?utf-8?B?UVJLZjdaV0FWTUYwMllvbG93dXhVb0ErNFNFMUFpWEpwOW55ekFTa09kL3hT?=
 =?utf-8?B?SzlvVjVkWHpOeElTcHFPYXhEZDl2WUhNSExCd2t1VU10VkFPaVRmSE1MeHNE?=
 =?utf-8?B?bzJMbjNVc0tZajREbHRzYnd0QVhyK1d6SFFnS2VjNHBOSSsxZ2hCQjNhM2ZG?=
 =?utf-8?B?RkxuemJqNGpvbnh5ak5RNVRkdUF4Zk9MK0h6SkxmcCtYNVVYZXJVSDRLeHN4?=
 =?utf-8?B?TERMUlZjcnNOS1BqSnFCQnljR1JVOGVDdWpCZTFHalRRMThMSytsRlBvaHBG?=
 =?utf-8?B?MEswR1RmamJHZkRQdkxLYWRkOEZrT1NkMnVxeUcweGE0WERjUG41Q3pGVEpU?=
 =?utf-8?B?cmhFMHkwT1luY1pFT2ZLZ04xREFxemZKV0VIZHVYNHNZYmthWCtpNnJZdGdL?=
 =?utf-8?B?NmlWR0lOeEo4WHA1ZFV1QnhGUm1QM3RCN1lUdnpBTHFrUWVIVWlmdVBvSVF4?=
 =?utf-8?B?WXRENldsZWN0Z0laaldSKzladVdRRmFzNlBuajh2VTNTNjdrTDJOaEM3ZG4w?=
 =?utf-8?B?Q1lzd3J1L1JJejM1VXY4MS9lbDBaTnJQYjVBZ3RBVDFxdFo0QWxvWEZZa3E3?=
 =?utf-8?B?ZDUrS2dHV3kzMDQ4V1VDZ0ZNbFoyYzJUeHIxMGxtUkRHRVRua0E0YnFTby8v?=
 =?utf-8?B?NFptWWE3TSt1ZWlNVGE3SVk1bk5palRmNytLdlZ0NFBDa29YU0V1YnJCUmMv?=
 =?utf-8?B?NjRQL1pybVczby84akFybzlkcGprbS9MbER2ZlE1NWNiS2QvVCs5b0o3U1VN?=
 =?utf-8?B?NkwzQmpLTGZKRm52ZTJ0NDdWUVp2N0c0Z1BJN2RmQVZ2ZGVna3JLT29ybFdE?=
 =?utf-8?B?bzhQYmpodXFlbXdkS3dhUXY0WGV5VHZQelMzMUJkZTNFTC9udlYxZG5qTFdU?=
 =?utf-8?B?WHNnWHRIMjVyRm01T3VjN3hDS0VyMGhuNXUxbnNRMWJwRVdPaS9Nb2Iva0Mw?=
 =?utf-8?B?RmlnQmZheWlIbktjMUxYcEIzcnNvNHFKc3NOM0xLTlRuWng3c0ZiVmZQaFVo?=
 =?utf-8?B?NEFRQ1VJbXhHNnBWWGpmLzhVZEU2SnU2UDdOYjU1RWVPL255Zy9POTBLWVlW?=
 =?utf-8?B?WGNtSTRleWFqYVplUmFsSGhsck5Mejk5clhUZUEvSFFBc1hqNVo0WlRHZFFv?=
 =?utf-8?B?NmNJZ0g0MGdKOUxiZVZEQm1ZUm9LWEczNHJaUUZ6NUhYMG8rR21ORnZVSGpP?=
 =?utf-8?B?MkZZVmZJQ2lXVHJqdW93cTd2S0RVU1VaSUlNOUUrYXhGb0xKSnI4NHZMRkdL?=
 =?utf-8?B?a2gxWlc1a3dBWjBCMXQyMHplU0Q5YnBycGxCZHNFMzJvTWJCVkRnZz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8D8790D5F96E1745AD64BCF1DFCA591B@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d661dd07-d13a-4603-0c99-08da4ac22b1c
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jun 2022 09:18:23.3559
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: b0BsiS2UmHjcN1FWcc86JhnmnGWnWrXFIuhP2Rk4etgLA8LTRTHroIs01NdqbY2EPOOXtFe3tjuWVuMnL8afHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3675
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220610_021828_501325_F4432BA0 
X-CRM114-Status: UNSURE (   9.34  )
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

T24gNi85LzIyIDIzOjI3LCByYXNoZWVkLmhzdWVoIHdyb3RlOg0KPiBMaWtlIGNvbW1pdCA1NjEx
ZWMyYjk4MTQgKCJudm1lLXBjaTogcHJldmVudCBTSyBoeW5peCBQQzQwMCBmcm9tIHVzaW5nDQo+
IFdyaXRlIFplcm9lcyBjb21tYW5kIiksIFVNSVMgYW5kIFNhbXN1bmcgaGFzIHRoZSBzYW1lIGlz
c3VlOg0KPiBbIDYzMDUuNjMzODg3XSBibGtfdXBkYXRlX3JlcXVlc3Q6IG9wZXJhdGlvbiBub3Qg
c3VwcG9ydGVkIGVycm9yLA0KPiBkZXYgbnZtZTBuMSwgc2VjdG9yIDM0MDgxMjAzMiBvcCAweDk6
KFdSSVRFX1pFUk9FUykgZmxhZ3MgMHgwDQo+IHBoeXNfc2VnIDAgcHJpbyBjbGFzcyAwDQo+IA0K
PiBTbyBhbHNvIGRpc2FibGUgV3JpdGUgWmVyb2VzIGNvbW1hbmQgb24gVU1JUyBhbmQgU2Ftc3Vu
Zy4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IHJhc2hlZWQuaHN1ZWggPHJhc2hlZWQuaHN1ZWhAbGNm
Yy5jb3JwLXBhcnRuZXIuZ29vZ2xlLmNvbT4NCj4gLS0tDQoNCkxvb2tzIGdvb2QuDQoNClJldmll
d2VkLWJ5OiBDaGFpdGFueWEgS3Vsa2FybmkgPGtjaEBudmlkaWEuY29tPg0KDQotY2sNCg0KDQo=

