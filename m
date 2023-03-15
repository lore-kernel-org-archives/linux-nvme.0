Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92A9BC7618D
	for <linux-nvme@archiver.kernel.org>; Wed, 15 Mar 2023 05:17:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xbKfm6d4IjrSqEUOh35aX+GBlWuckwaAZHijqYLuDVI=; b=DfJu+C8bd3LOR2oEP4myNbYT9l
	PDnGwF5Id8vhxB2/TI5XAu6BwzkkHxm+60o+rNQNWc4ZhPYq/9dzGsNv6znpGhtLjdy/eBNOXj8Fx
	QvRdV5ri+RSTS+I8K6Sa+SFOXv+6RdSCLwWSgxOCUuR19a4MeVNdkqmr7Fz9dvdyphQXbKSCqs3eR
	0aEZ6jrpYd1Zk9X4qfzN7YHC2pOGGPGzOCi7OgutPRZjlk3WHZwfumHk1pmWkZVo5uwD06KpI7ZEW
	AUQ2QPHGyKfKTXZWsicP4AA5CokfIH2BXEoAK7WkdpZuCTwx0wC1Lwd2LZ5gCUjJ7PBEMLhDhTuio
	O6A9jNCg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pcJVk-00CNw7-18;
	Wed, 15 Mar 2023 05:17:16 +0000
Received: from mail-bn8nam12on20603.outbound.protection.outlook.com ([2a01:111:f400:fe5b::603] helo=NAM12-BN8-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pcJVf-00CNs0-02
	for linux-nvme@lists.infradead.org;
	Wed, 15 Mar 2023 05:17:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E+XUxKocK07rZal/5H81ypK+fMyuisf874QF0Dfk7jOkgWUUaa76fS4WEe7BnXJla9vlASjcd0Gz93agAqUB2fur5vfwuH9GJf3Iorz9aBLly8gjVInj3As6KClBddEEEu69YXTOwds2Wcc+aUCRMFqHDkmR72D1zuTnGz5ZMJHusoO+mKdxl7ZS1qoF3/ZkjsdlnyA59rplFqSQH2iJbpW6ad451slD+YEuEwSuQGd21X05yiqSCIYLxoAkrnKdp9pS8VSJc0VSXQyZF2eC7c1F42u3ePPXnwdIuLwJ1OdGzMj62QYsZQHB4/tJsIkUHF+hoMw1OAMSHfUku2/vfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xbKfm6d4IjrSqEUOh35aX+GBlWuckwaAZHijqYLuDVI=;
 b=dXNWglU0uEVZdWYz12cHatB2ZIFql5CmiOWISopmr0toy4reO4RAlpJHoGLfDgQ6kU0kVajiwOuyq/lLGIuQJGSIK1TmbLf3uZF5jnQIAIpD2qj67XVRN9iRo0q+QvFRXB7NmuzS1rS8E1tQd4k3K7GZxhaqcv6galEDHrlTnxdDsjRiE6hXbuMELk6pvr34s/5jOjh/6++nGGrrZlsqEWsF+pbr2T3ye5MLxNeN+JJIFEgLFKAfgOGvE4cxXBHJ2fV21TWTIlchz8K6xfQr6Qt60l8gb8Yl/rF73DKa7EnXnuJiLaeN1rNhiaF1YpPky0GlBH0jM4HyFoTjRIpJIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xbKfm6d4IjrSqEUOh35aX+GBlWuckwaAZHijqYLuDVI=;
 b=Zpnbq8eYaYJfFaLKi2PHh1y33nCkEiVHbun6UXFznWRpzX2rxMEDN6WFmXFm1X0uNcob2db1ZWkm5queMXwgKdGg+tixEvKGZpZmAlKJpN1P1GNsliF3EHPck4Atap22EL0067aERZVNHlEtc/YVW/6YFjn80zH9L1YEb1/xLb5EUe4LMOQXvERRGVrbCsjA6INniCDQoccDORxqcb8z27kpv5CYHiuNleZHCSvAGSZV+9+H3EGaFQSI8I/gLmF/2wfmcYARKe9tL+uPL8r6eZmkcj5zAojgRKxmxJJv9PMtyfEkqiJRNcVZZQSc0gGzo75pzyP+MZvNLDvUhB0Rkw==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by IA0PR12MB7773.namprd12.prod.outlook.com (2603:10b6:208:431::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.26; Wed, 15 Mar
 2023 05:17:07 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::4aaa:495:78b4:1d7c]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::4aaa:495:78b4:1d7c%3]) with mapi id 15.20.6178.023; Wed, 15 Mar 2023
 05:17:07 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Philipp Geulen <p.geulen@js-elektronik.de>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
CC: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>, Christoph
 Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH] nvme-pci: add NVME_QUIRK_BOGUS_NID for Lexar NM620
Thread-Topic: [PATCH] nvme-pci: add NVME_QUIRK_BOGUS_NID for Lexar NM620
Thread-Index: AQHZVZSAfu+Xohrrz0aNONPKjGlw9a77T5yA
Date: Wed, 15 Mar 2023 05:17:07 +0000
Message-ID: <1dfb3d88-5c15-8e0b-8af8-1045bf0f0ace@nvidia.com>
References: <20230313101150.18146-1-p.geulen@js-elektronik.de>
In-Reply-To: <20230313101150.18146-1-p.geulen@js-elektronik.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|IA0PR12MB7773:EE_
x-ms-office365-filtering-correlation-id: bbddaf07-ea43-4c2f-270e-08db25148591
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  KsMMIlxyZEU97bxBH58U/UfDUmT/7q7xcf5yluS869halvcvm1+vjorNjApu4VLoe9unO1l8MvtmZmvS7nXSHNmrZkCSigu26wlIoPGC8FIMTaXEq2AIxNhmcnhriaiTgXMGxGAgb7uiOCypNkIlEKzaw40Vq4/vxK7mdWQTPHnnzVltNvseGXtm0XiNAwM7tUJUBb0hW8d35wpjzPZpB3hUwqGI+kkpC9lSk1DVJQ0jHugw27VN5ruvH6ejMfBy8K8oDvRvsPHJsPUrZdBQbIgeHEkITAjZkwdjvzs6JnuRcSIA8hgD5g4gWg9Tk/Tq4ubTkH/altsl49C7AOXbyWKW+QC44tHjNxxP2uaqpOZwb/wCS7ewmEC7AUXB3A9jgfiOC4/JOFsawVi5LEcfg3yHcJIcANn/6vWIiQqM+O8PJVlY6e+xooCR32sBP2hv9owh7aSMt94QaS/r05iEzNEuVxJ9pYDp9EVITdDqRlg8cK4zvqhNRjW4fbrO+fkUyCPfBC/WkLEefD7o9BcHk53bPSk2wtNQyNppu2QNb0KsmiX8N2I3Ho5J2KlW4+GAWtfecmPk0NFyXiAOgTW5QIVNWvqOsrFlApRGyzx/GH9MyYSaTNS3VJBJsxbiuccJKwlxDkbULXHSC+vJhB1TNjMYOjsOUElU9pfUbgmBiAb58akY+ZsRJAuvFM6EIw2myvm6O72Guc+OCg82rEt14j6beXdeNZ+izUBMBypKNAxeP7EcHiuBRKAwR20vj9kRxS5DV1z25KGqI0mr8dvn5A==
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(366004)(136003)(39860400002)(396003)(346002)(451199018)(31686004)(316002)(186003)(54906003)(110136005)(558084003)(36756003)(38100700002)(86362001)(38070700005)(31696002)(122000001)(53546011)(6512007)(2616005)(6506007)(71200400001)(5660300002)(41300700001)(478600001)(6486002)(66476007)(66446008)(2906002)(64756008)(8936002)(66556008)(76116006)(66946007)(8676002)(4326008)(91956017)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:  =?utf-8?B?TVlndGxaa3dFdTRXS2wvUWMzUC9VQmtJUUNkdTNlamxHZEpjL2pXZDVZOEFx?=
 =?utf-8?B?MmJsOUxSd0pxdXRMNFZqNFl5YndGRXBsNmN1MlRSOG10SnR1cHFpODVVZURl?=
 =?utf-8?B?V2lnWE9sZDFXdEVmTkJJVHEyR005WXBvZjdpSnpJL2h2K1dUOGw2M3pURDFi?=
 =?utf-8?B?WURkMklrMFV1UXJWbkhObFEyeURpRnptYXg2Zm15Si9OSFpmdzk5cm9xd0o4?=
 =?utf-8?B?REQ5L2VNQU1WUzlFMlFBMU1KckxvNktoK3liSjB2WVhsYlRJU2pveWdTQlEw?=
 =?utf-8?B?eUlyQWRpOGNhdW5HRzRzK0JzbEJwYW5ZKzVtNnl5a2xSSUNhZ20wYWVMbUs2?=
 =?utf-8?B?b05GY0oreVVSRW14MFJSNVRnNE9ybWlhSmdtNUYrYVpFc0Z2Vk1QSmc1YXht?=
 =?utf-8?B?OEd5VHpLeHB2elNjelZQMUt1ZFVnRGlHWHZTaGRIQVFmRnR1OVFkVlp1YVgz?=
 =?utf-8?B?ZnIrNmo3TGNydmsvQk4xN1lkeEVOeE52c25nS2tMa3F0NEd3YldnSVB5c29t?=
 =?utf-8?B?aHM5RHk4c05VdDNES3dReDIrSml3L3ZyY01uTGl3RWovZnA3N1FEQ0w5dldu?=
 =?utf-8?B?RzFJZEt6djcvSGNaWWZHZ0lacEpQSDNOdFdmY1VQUEpmS094M0Naa3ROaVM4?=
 =?utf-8?B?bStkQ2dLYVAvbVhXblpKeml1a2dFV1RPYkIxQWpCcUVxWGs3RTROdit5R05y?=
 =?utf-8?B?RjYrUElMYUQrL0FkQ0ZFSXArWkhnc3JlZXduTGhsbk9TQ0dnR256MkN3em15?=
 =?utf-8?B?bjY1V3o5a0swcTU0WWIzRk9DdWlxWlJBWlJNWE9NeGNDd3NEbDdYTjlCcnZm?=
 =?utf-8?B?SHFhTE9QQW9FcGE0RzE1UDFwbkw5ZWNxY1YwbzIyaTBnN1UzOVo3MytKRmM2?=
 =?utf-8?B?bmNrTXF4bzRLWGhXVW5FWk1zZ280WUlOM0ZMUVFhaDZUOWhjdlM2WTdKNDdr?=
 =?utf-8?B?U1lrY3BrUHQ0S0lmTjkrVlB2dExBNTRPWEJub0x1TlVrSjBLMGlrVTZxbGJ6?=
 =?utf-8?B?MzJtOU80YmFtUWpRVkwzL1dDRG1pNW5Sakx0b0w0MzR4UnQzTU9jRmxkY0lG?=
 =?utf-8?B?QVc5c291eHVrSTBsd2U4QXBkQnlLd3IwNW5icWJXVkhNb1N2Wnk1RE1IcjZZ?=
 =?utf-8?B?Lzd3WWIyQ0NUUXdnSmxnUFRTVjRrQXA3TUNER0NTdlJOMUFOL3VBU2V3QmRI?=
 =?utf-8?B?bzZWU1NBNHEvRzdCNTdibU9lcE85NGZaMGd0VHhNWnNGT3JpZGp0bWthSHNN?=
 =?utf-8?B?V1dsaWl0dTBaWE5PNEJYbEN3VTdxY2R3aFprdld6d0pvM3VTTzUyTHB1OWc5?=
 =?utf-8?B?NFo4OVBZY0JuK21FVVdSakE3d0w2Qnk2dkVUaU5qaW9hN2NLeUl6VDNHekpC?=
 =?utf-8?B?YXVmcm1RTExWNjd1VTd6YVM1eTlTNlltdkZPdExQQi9NaWlYTC92N2NZTlNa?=
 =?utf-8?B?WDUyVGhoWGlCMW1ONE5LYW9nbGZPdGV1aEcvQW9kNjNFNE8wVkNWYmo5cGIy?=
 =?utf-8?B?aElLR0JCeXF5emFuWWp2dDZuenh2QTJrVjI3YlVNTCt4M2pDVjVxais2dE5I?=
 =?utf-8?B?dU13ajJtNXBjWnZnb0FPSUUrQVgyTHJxdkhOQXB5bFRNeHgzcytiTmhLbGV2?=
 =?utf-8?B?b0xOTjlFNmhNeHFqaVl0RzZIRmUrejFTTEtWbGh1MTV2RGNqM0VZUDk1UnMr?=
 =?utf-8?B?akt2cjlYNGc5eWJVUFZaa3NueHBqYVBZUUxpVWhYa2hUQ2VqYThUeHRLRU4x?=
 =?utf-8?B?eEpDbzFJTFZ0WGs3M0pTR0tvWVgzUGhNVWFZMm4ydGxHZkIrNjVTS0FRSTIy?=
 =?utf-8?B?N25PYW4xS1kwNWhwRzhBNHZVano2MVd4MjcxOEZBczRYcXpqSGoyeXVVcDNY?=
 =?utf-8?B?WC9kUmFHM0JVWlQvM1JJWVFtNy91SGxQWVVWb3ZHZTBMeU5KUVJrOTI2cWU5?=
 =?utf-8?B?QUxqY2xNVU80M3BadGlyMlpiM2d5cnRVYUk5NDNqcHZ6N1NUNFZ0L0ZaVGtL?=
 =?utf-8?B?aHBVOFlIZiswUnF1VmVlKzJoQVl4UkF2WjhvaXM3QWJkODFidzlaUXhuYytP?=
 =?utf-8?B?N1pnNm0zOCs0a2FUcDY5ZnkvQlZhZWY2dUUzSkQyNGk3NEZkK1AxYkh5NjQz?=
 =?utf-8?B?d25BRHBCUHBla3J0TnhPVGNBR2o1dFdVWXZMYzZvejNWU2hrWUxTVlByalpy?=
 =?utf-8?Q?qEXM8tNPbEqbgoAPRuIIIUFqIYhR+xOh0YoW8kmaNGGr?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <447CB18AB6BF0548BC12C03BA6771746@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bbddaf07-ea43-4c2f-270e-08db25148591
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Mar 2023 05:17:07.3356
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: orBkn42q6mW3wjPYym4pCbcX8SeCi82Yvyj3g0uO69JEwhX7LADTghG3dNsh57eFL0GH9gFnThItKRW0bDZWfw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7773
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230314_221711_062022_EDA39296 
X-CRM114-Status: UNSURE (   8.06  )
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

T24gMy8xMy8yMDIzIDM6MTEgQU0sIFBoaWxpcHAgR2V1bGVuIHdyb3RlOg0KPiBBZGRlZCBhIHF1
aXJrIHRvIGZpeCBMZXhhciBOTTYyMCAxVEIgU1NEIHJlcG9ydGluZyBkdXBsaWNhdGUgTkdVSURz
Lg0KPiANCj4gU2lnbmVkLW9mZi1ieTogUGhpbGlwcCBHZXVsZW4gPHAuZ2V1bGVuQGpzLWVsZWt0
cm9uaWsuZGU+DQo+IC0tLQ0KDQpTZWVtcyBsaWtlIExleGFyIGhhcyBxdWlldCBhIGZldyBxdWly
a3MuDQoNCk1heWJlIGl0cyB0aW1lIHRvIGluZm9ybSB0aGVpciBmL3cgdGVhbS4uDQoNClJldmll
d2VkLWJ5OiBDaGFpdGFueWEgS3Vsa2FybmkgPGtrY2hAbnZpZGlhLmNvbT4NCg0KLWNrDQoNCg0K

