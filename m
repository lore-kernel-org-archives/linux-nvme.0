Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3DF1E93804
	for <linux-nvme@archiver.kernel.org>; Mon, 13 Apr 2026 00:11:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vFZpjNtL2FHuyr6WuH7vbhJPv0y6aIFTJPbUQFkfCk0=; b=zUF8dtpWBkeCVRhno1k8PKXVmy
	Q5OOSnfSM+mR7mwjL1Ku6OA18Jg1vkK8tNeKz0A737BadBSUDno0Qq6yuwJPFxFghDKvku8p44Oqo
	wXmFbljoYStPtxPwLI/JTBibqFofh4JJiO0eanyVeNq7rHvj8HJUPz9gDcMlknIT7Il+CYpWdwjGe
	ro+ShMM6M7SPmCVVb9lVxZkNj7EiO1wPb+Vibhu2u4meSX8iRFjZyM7ShMsGNIqxl2/xMqGDqRE0Q
	PmntqknW6Ag+hDOruzQtqh6dFZZbfEzR6CIdPdJMLkNPNKPglHoByWJGk2lWi9lo4cQQyT6YQSu7X
	lyWZNQYQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wC4tV-0000000EnVE-2Xrj;
	Mon, 13 Apr 2026 00:11:13 +0000
Received: from mail-eastus2azon11011054.outbound.protection.outlook.com ([52.101.57.54] helo=BN8PR05CU002.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wC4tQ-0000000EnUn-3CEs
	for linux-nvme@lists.infradead.org;
	Mon, 13 Apr 2026 00:11:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cySjqk0rV9f18BlpebiXfd5EVXbc4n+tuKW080BYwroTn+24HUJbsDoCLyRuhoha6xorNilLKzfOjZGVEf5yoi/OVuU5Vb1B01rSb4ML/iQ+8wpTo5wmv5J2eZ3PBcZwT0x5qNnwNzfsvf6iyVNsf7Lgu+mQLKFmR3YhFjeMpQnFlS8xMrkx45/7IBDhK1rKdBUV5f2pQs6Jd2JyGiXQHthNvaL5bRU4bVSDG3qFfoiVPh7DIRI2qbVrAPjNy3tHyz6evjcRzECwkI0PKxoqIbjgyC6pKpcxrcWQ9cShOXExhU2gNo6b74BLwzTTTd73SEzFVDATCbFJ8bPl0UgOjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vFZpjNtL2FHuyr6WuH7vbhJPv0y6aIFTJPbUQFkfCk0=;
 b=X/vsQpy09PXnm1g35NHhgR5RolUEP0MWJcQ/AwzzQnRYJ4QKYvrvwDwR3YbpUuhcuHo8vBiuUthSLlg3QTO3QxUEeMr5YsS3FMhHoAWlajZPhb5pzhhZ4dquJWjVbOhlOdo2/e0Nyf63eM8gNHd4LCU18U6eTd6mPHc+1wIew9EQcVhW7x9NpPNdN9XsKbu2ox+BUpqE2i+pW1wem7BLWXgBhLtP50Uk2aiRDdI5gilpkR+DeqYxWSmGsM/0mNi78C+dXpjwj0s/ZZo3gZVRJvtJX0zMbsO8hkoMUHxP+wnaCkEx6i80Fw6Z98SHlQMk2walr7p8knIPs7I1hnoTcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vFZpjNtL2FHuyr6WuH7vbhJPv0y6aIFTJPbUQFkfCk0=;
 b=fHSYINx2qsnt/WRDVL/oBcOeMdnzvFW1j79wmW9daMipY0WkBygcG7TY6K3yNqMySD8auDavfBaUL+h6BnIwqw2gkZfeGxjxCBurF2TzQRmiGBgiZPOXnB6Set8xZD261Uf2r1BUP80sox7FZRCzEDptrvQw0obeZx1P8IKTGSfTgNOFJ3/XJwHx6csICxzR2komk5UmRkMvMyNxTpPPII/AaP1ja4Bz8Df5AJjy2RsCJ3iX3+TjOI8DFdrzFJW4SgL4HwlUSzW+7d7uSF9O/PKuiArT2070z0KPzQLWcWWsdRJnT9615yZneFpdzB+gdZRps8ED+K0Mypk/QnqqnQ==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by SA1PR12MB7125.namprd12.prod.outlook.com (2603:10b6:806:29f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.15; Mon, 13 Apr
 2026 00:11:03 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::2109:679c:3b3e:b008]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::2109:679c:3b3e:b008%6]) with mapi id 15.20.9818.017; Mon, 13 Apr 2026
 00:11:03 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: "kbusch@kernel.org" <kbusch@kernel.org>
CC: "wagi@monom.org" <wagi@monom.org>, "hch@lst.de" <hch@lst.de>,
	"shinichiro.kawasaki@wdc.com" <shinichiro.kawasaki@wdc.com>,
	"sagi@grimberg.me" <sagi@grimberg.me>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>, Chaitanya Kulkarni <chaitanyak@nvidia.com>
Subject: Re: [PATCH V2] nvmet: move async event work off nvmet-wq
Thread-Topic: [PATCH V2] nvmet: move async event work off nvmet-wq
Thread-Index: AQHcptixhf7e+Xh4a0aud5WZEflxqrWnVD+AgDUSFgA=
Date: Mon, 13 Apr 2026 00:11:03 +0000
Message-ID: <3c93edf3-87fd-486f-bb00-8db2cf925641@nvidia.com>
References: <20260226043003.160555-1-kch@nvidia.com>
 <010359e2-c219-4e2e-8b5b-5e86eda5653f@nvidia.com>
In-Reply-To: <010359e2-c219-4e2e-8b5b-5e86eda5653f@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|SA1PR12MB7125:EE_
x-ms-office365-filtering-correlation-id: 86e40510-1fad-4b11-2f55-08de98f1266a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|10070799003|1800799024|366016|22082099003|18002099003|56012099003|38070700021;
x-microsoft-antispam-message-info: 4b/ZPX/aasoKvRZHwZC/d1M2rV/lZI4m2CGASwnqL0NXQsS954qssFopQLbzKolRRwaw8ysOy1efEbLlfQGbfRGbVGNlNrdNPolExo19jES0ch4mEg0X+7dup8mQ26K0HSA7LuKv+XoIBddVesrgGzDE7jh9pYByLrbSmWT7O/95lNVCj/5I4oaRaim2YX6XqWCqH9MCIFh3RPlGXGuvw1dVO13WjhSyUVzK2cLm6g1PdY2fin/BrwGs9zQZaLxd4g0SzdRwLkZU9K6ruAmWu+CSTthwutA+XVkEuUEBE/1GSwLGw3Thv0HM4EJpaokxiP9wXP0pLCOMYCXnOgMwmDF8WODwhlyrV/1wQO8lD+NX9z4d16Gs35xqCutklrptnb9+oYGzMDMXQX+DgKwuBwgjl8ePFEw7FovCCY+mvIVZSPFaymxoX/TgzAmCtBtmXVaQB22gSdCTyvclLWYfbZpYGNIkkRXFBnlorHZiTjgG+KTaNV1I8ZcZkt4zTia8S11eOiwuWLXItojK8iNgE+Nd3CEdj8AXlt6CcqkELlomJTSAJgiio0B3hCgYvqSNpgBqn3vSZ+60wGqwQK4J3ir/hvvtv2VNFIxI4mt5fSiDfO4wRfbE8hLE/Sd3wmZ/2NPJhdNpgVy4XhRCfo1lgSKXqp3KpyunVsJSsW3mFZnml+tRNezlAptuR2sG1/ZniAoXAS50uzTPcs3VZ+NmxxTb+EjAv+hmkoP8FbX7s74euIjyaEaWL3xw43loRzTfbajxJBiu8QEXcisundY2sJPAOBLXIB4uj7aPQifIeyI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(10070799003)(1800799024)(366016)(22082099003)(18002099003)(56012099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RVo4UzJvYm9wM00wVFU5U0pqSURQWFBEZ1RWU0Q4TDhYN1RTMlBPUnc3UHZw?=
 =?utf-8?B?eWZxQmZjamtXSnBKcTgxZ291d0lINDBqUzR4aGhMNktPRDhBZjJZMDUzcHA4?=
 =?utf-8?B?OWNxWEw3bEQrZWhobXlhaHhLNEx3dmw3MmtVaXdtSFRSWDdVRm9iendPaHc4?=
 =?utf-8?B?VXlCN1FnQ0JZNUswZWdJQ1d6djdCS0FvRVZndXZWNzFYeFpzSWJ1QVQ0ZEN1?=
 =?utf-8?B?WU1ESHFGdnRDa0R6YVkvbEQvSklKWjhNUmdBa21KYVB1elJxVlBOR2hCbzFU?=
 =?utf-8?B?NEpXT2tmc3VUZEJ4KzM3b0hHT0dLQk1kSW9jckNuY05yZzZOTDY4b2hST2pz?=
 =?utf-8?B?NEp6YWtQNGZOYXEvS0ZOUmI0RkpvR1NjMEovb2xreFc0TTZQNHFMcEJ0Rldi?=
 =?utf-8?B?TEswSmg0YllEYVc4OStzUlJGUVFDNjNZTGdSY25tSFZkc09pdmZZSmkvRnl0?=
 =?utf-8?B?SE5ZN3Q3M1dXSlZoZ29zTnhsbVpWY1NUMlUrWSttRW1WMUttNWZBUnFObTFo?=
 =?utf-8?B?MDRVWC9ZTjRHQklzcTdmSXBJYVd4SEZ4OGNHeWI2RGVLcDVlalNQZUVTY0py?=
 =?utf-8?B?VDR0TzllOTgwWjFRT1B0c3VIK0dIQmVTK3kwdWRuZHg2Z2ovbFF6bGhlUzlj?=
 =?utf-8?B?dzZFWXJMUXBxV0ZxTzhzNzIwQnF2NXRDcDgzblpJZmVic1VTUWF5Qk1ZWTZ6?=
 =?utf-8?B?RUExa2pXRkdvdEltY3o0OVF3d1ZFV25xTFhuWUVjUGRRWEdKc2JIR2RlR3hN?=
 =?utf-8?B?WEZLMEw3Y0RZcU5CakF4ZC9pV3RYUjhqc2UxZGlpV2ZUcUcvTWl1c25JNGM4?=
 =?utf-8?B?Y1UrNlhhOGZxS2JPcWFqWmhrejcwazdTMUR0RGRQbzZOT1FVcy9NRUd6cHFV?=
 =?utf-8?B?QkU1QXpGc1BpckJrdmg0VlU3WURjQi9Id0pUTVlhMzhBYXpOVm5xcHlXY040?=
 =?utf-8?B?akpOVzJOMS9ORGphbkxubVFxQ0hKaWJCVTI4S05iTzcwUFNwYklsVW1vbU5F?=
 =?utf-8?B?RlRnVWlqMzFYOU9ydEZ6UUFMMm0zNVhYK2s1dVVGQWpYaGt4U3NCZFM0UTJm?=
 =?utf-8?B?L0phaGVYZ01xTW81VFkrb2lWVmtjRTB4S0w1UnZDVi8yOThCUk9QQlhJS084?=
 =?utf-8?B?cEMrTGhTd3B4SVNmcXgxL1p4QjFVQVY4ZUlVL245UkhPRU1LdGNrL01SS3d0?=
 =?utf-8?B?dXFmditTUFcwYlg5NTB3ZW05TG1GMGc5cXVhSVFNTWNqdHQ2RVpwZm1leXBh?=
 =?utf-8?B?aTUwdEVWL29tQTFTQUZRNDhlQ29sNDEwTlFBc0RDVUcxM2NUZVl6YXJTMnYy?=
 =?utf-8?B?cHdyWmROQnVhL2NkcjYxNzF3a014RmsyRjdOZmNQWmJlNWxzSUFlR1JYeGtw?=
 =?utf-8?B?dEtRVkp4RkZESSs4RFFXZjdXeHR1RzhSaU9VdmhzK1dqblAvRHJuYXA1ZmVQ?=
 =?utf-8?B?QlhGcTBHSVlIQ015czZYTTJNdFE0eVFsa0hackVMOFNMdGRMTmtjUU5YM3VB?=
 =?utf-8?B?MUFnODJLMktnNVRGTCtSUkt3SVRMRnUzY2JBUkdzUGM1UWlBdENnZlFsSVdq?=
 =?utf-8?B?N2FnNmZnaDJWOWJSNFJsbnVrSXliSmkyMXpaSXlGVkhydXVreUZvREpoaENG?=
 =?utf-8?B?VmxGb2phaDNxRk53dmRZejRLU3VPaXZjSVF3MHpnZkt4UUoxcTdHeXUrcUY5?=
 =?utf-8?B?N1ArYVJDRU9sRWNQekRXc1VxMndKTjdCV0U1Wnd2N0dxaURzMGJkNzNMbWE4?=
 =?utf-8?B?bjJuSGFRa3JWVGQ5dWloSjVKYmNFa2VTU1NmWDY5cXlWMHBQcjJGby83YWND?=
 =?utf-8?B?dUp3c3lHelFZcmkzdGN1QVZpRVQ1VVdSK3c2L1VGeEF3T1pQcFRGdDJ6ZjNX?=
 =?utf-8?B?dVN0bWk2QlhFWG4rOXFpUURFbnZtMUp6d0R5cW14MWZaNzlSK3hjQ3VFSy82?=
 =?utf-8?B?aEd6TCtuaXVMTEc1ci9BZ1hMN3lkanA1d0V1UzZsdkxlWnF5a0IxL2tpY3o0?=
 =?utf-8?B?cERobWRWb0lTSlFQTjBNRmt2Zkp2K1c3MmJCQkV6TUswNllQS09vNHQzclZC?=
 =?utf-8?B?ZVBQMjZnb2NXVXlkSTcxd0x6WFJxNVlaL1lFdXMyYnNmdW85RncxQVBZVEZU?=
 =?utf-8?B?VThzb3dVb3c1Nk9FVlAyeVN3dkhhMlJEbTE2Nyt5dDhFSzVBNVNKRVN2RnRy?=
 =?utf-8?B?aURjTkF5aXhkRGZWWmFYcFE0bTNsVkhLOEpPOHdSZDZJbUs4RExrYStQcWI3?=
 =?utf-8?B?VkJlcUZBNmlDMkgxSzJSb1hpVkMvWDBlQTB5VDBFbTlsd3JaU2Z1V08xYXpN?=
 =?utf-8?B?NVhrZC9HWmx1aGRPcUwyWWlwUzZsVDhJb0Faei8zUkVxVGN4bThldVM3NEFi?=
 =?utf-8?Q?TE8DM2Js51339ZmaG33dwS66XwSIp3evcf5T1nseULirU?=
x-ms-exchange-antispam-messagedata-1: i9eNA5k/dXIG1g==
Content-Type: text/plain; charset="utf-8"
Content-ID: <9E3BD60E58D8874B8EBC53084BB972E9@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9404.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86e40510-1fad-4b11-2f55-08de98f1266a
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Apr 2026 00:11:03.1902
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: j5NppKKDfxx80UlzyKLA/CYQFBhlgNwlvh2nnbj+bR8DtdBKuKfd+E57eHuluXIElH2UzrWtNQu9wAtruPTVtg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7125
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260412_171108_810828_E3F89774 
X-CRM114-Status: GOOD (  12.20  )
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

S2VpdGgsDQoNCk9uIDMvOS8yNiAyMjo0NCwgQ2hhaXRhbnlhIEt1bGthcm5pIHdyb3RlOg0KPiBP
biAyLzI1LzI2IDIwOjMwLCBDaGFpdGFueWEgS3Vsa2Fybmkgd3JvdGU6DQo+PiBGb3IgdGFyZ2V0
IG52bWV0X2N0cmxfZnJlZSgpIGZsdXNoZXMgY3RybC0+YXN5bmNfZXZlbnRfd29yay4NCj4+IElm
IG52bWV0X2N0cmxfZnJlZSgpIHJ1bnMgb24gbnZtZXQtd3EsIHRoZSBmbHVzaCByZS1lbnRlcnMg
d29ya3F1ZXVlDQo+PiBjb21wbGV0aW9uIGZvciB0aGUgc2FtZSB3b3JrZXI6LQ0KPj4NCj4+IEEu
IEFzeW5jIGV2ZW50IHdvcmsgcXVldWVkIG9uIG52bWV0LXdxIChwcmlvciB0byBkaXNjb25uZWN0
KToNCj4+IMKgwqAgbnZtZXRfZXhlY3V0ZV9hc3luY19ldmVudCgpDQo+PiDCoMKgwqDCoMKgIHF1
ZXVlX3dvcmsobnZtZXRfd3EsICZjdHJsLT5hc3luY19ldmVudF93b3JrKQ0KPj4NCj4+IMKgwqAg
bnZtZXRfYWRkX2FzeW5jX2V2ZW50KCkNCj4+IMKgwqDCoMKgwqAgcXVldWVfd29yayhudm1ldF93
cSwgJmN0cmwtPmFzeW5jX2V2ZW50X3dvcmspDQo+Pg0KPj4gQi4gRnVsbCBwcmUtd29yayBjaGFp
biAoUkRNQSBDTSBwYXRoKToNCj4+IMKgwqAgbnZtZXRfcmRtYV9jbV9oYW5kbGVyKCkNCj4+IMKg
wqDCoMKgwqAgbnZtZXRfcmRtYV9xdWV1ZV9kaXNjb25uZWN0KCkNCj4+IMKgwqDCoMKgwqDCoMKg
IF9fbnZtZXRfcmRtYV9xdWV1ZV9kaXNjb25uZWN0KCkNCj4+IMKgwqDCoMKgwqDCoMKgwqDCoCBx
dWV1ZV93b3JrKG52bWV0X3dxLCAmcXVldWUtPnJlbGVhc2Vfd29yaykNCj4+IMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgcHJvY2Vzc19vbmVfd29yaygpDQo+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCBsb2NrKCh3cV9jb21wbGV0aW9uKW52bWV0LXdxKcKgIDwtLS0tLS0tLS0gMXN0DQo+PiDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBudm1ldF9yZG1hX3JlbGVhc2VfcXVldWVfd29yaygp
DQo+Pg0KPj4gQy4gUmVjdXJzaXZlIHBhdGggKHNhbWUgd29ya2VyKToNCj4+IMKgwqAgbnZtZXRf
cmRtYV9yZWxlYXNlX3F1ZXVlX3dvcmsoKQ0KPj4gwqDCoMKgwqDCoCBudm1ldF9yZG1hX2ZyZWVf
cXVldWUoKQ0KPj4gwqDCoMKgwqDCoMKgwqAgbnZtZXRfc3FfZGVzdHJveSgpDQo+PiDCoMKgwqDC
oMKgwqDCoMKgwqAgbnZtZXRfY3RybF9wdXQoKQ0KPj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBu
dm1ldF9jdHJsX2ZyZWUoKQ0KPj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZmx1c2hfd29y
aygmY3RybC0+YXN5bmNfZXZlbnRfd29yaykNCj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCBfX2ZsdXNoX3dvcmsoKQ0KPj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCB0b3VjaF93cV9sb2NrZGVwX21hcCgpDQo+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgIGxvY2soKHdxX2NvbXBsZXRpb24pbnZtZXQtd3EpIDwtLS0tLS0tLS0gMm5kDQo+Pg0K
Pj4gTG9ja2RlcCBzcGxhdDoNCj4+DQo+PiDCoMKgID09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09DQo+PiDCoMKgIFdBUk5JTkc6IHBvc3NpYmxlIHJlY3Vyc2l2ZSBs
b2NraW5nIGRldGVjdGVkDQo+PiDCoMKgIDYuMTkuMC1yYzNudm1lKyAjMTQgVGFpbnRlZDogR8Kg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIE4NCj4+IMKgwqAgLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCj4+IMKgwqAga3dvcmtlci91MTkyOjQyLzQ0
OTMzIGlzIHRyeWluZyB0byBhY3F1aXJlIGxvY2s6DQo+PiDCoMKgIGZmZmY4ODgxMThhMDA5NDgg
KCh3cV9jb21wbGV0aW9uKW52bWV0LXdxKXsrLisufS17MDowfSwgYXQ6IA0KPj4gdG91Y2hfd3Ff
bG9ja2RlcF9tYXArMHgyNi8weDkwDQo+Pg0KPj4gwqDCoCBidXQgdGFzayBpcyBhbHJlYWR5IGhv
bGRpbmcgbG9jazoNCj4+IMKgwqAgZmZmZjg4ODExOGEwMDk0OCAoKHdxX2NvbXBsZXRpb24pbnZt
ZXQtd3EpeysuKy59LXswOjB9LCBhdDogDQo+PiBwcm9jZXNzX29uZV93b3JrKzB4NTNlLzB4NjYw
DQo+Pg0KPj4gwqDCoCAzIGxvY2tzIGhlbGQgYnkga3dvcmtlci91MTkyOjQyLzQ0OTMzOg0KPj4g
wqDCoMKgICMwOiBmZmZmODg4MTE4YTAwOTQ4ICgod3FfY29tcGxldGlvbiludm1ldC13cSl7Ky4r
Ln0tezA6MH0sIGF0OiANCj4+IHByb2Nlc3Nfb25lX3dvcmsrMHg1M2UvMHg2NjANCj4+IMKgwqDC
oCAjMTogZmZmZmM5MDAwZTZjYmUyOCANCj4+ICgod29ya19jb21wbGV0aW9uKSgmcXVldWUtPnJl
bGVhc2Vfd29yaykpeysuKy59LXswOjB9LCBhdDogDQo+PiBwcm9jZXNzX29uZV93b3JrKzB4MWM1
LzB4NjYwDQo+PiDCoMKgwqAgIzI6IGZmZmZmZmZmODJkNGRiNjAgKHJjdV9yZWFkX2xvY2spey4u
Li59LXsxOjN9LCBhdDogDQo+PiBfX2ZsdXNoX3dvcmsrMHg2Mi8weDUzMA0KPj4NCj4+IMKgwqAg
V29ya3F1ZXVlOiBudm1ldC13cSBudm1ldF9yZG1hX3JlbGVhc2VfcXVldWVfd29yayBbbnZtZXRf
cmRtYV0NCj4+IMKgwqAgQ2FsbCBUcmFjZToNCj4+IMKgwqDCoCBfX2ZsdXNoX3dvcmsrMHgyNjgv
MHg1MzANCj4+IMKgwqDCoCBudm1ldF9jdHJsX2ZyZWUrMHgxNDAvMHgzMTAgW252bWV0XQ0KPj4g
wqDCoMKgIG52bWV0X2NxX3B1dCsweDc0LzB4OTAgW252bWV0XQ0KPj4gwqDCoMKgIG52bWV0X3Jk
bWFfZnJlZV9xdWV1ZSsweDIzLzB4ZTAgW252bWV0X3JkbWFdDQo+PiDCoMKgwqAgbnZtZXRfcmRt
YV9yZWxlYXNlX3F1ZXVlX3dvcmsrMHgxOS8weDUwIFtudm1ldF9yZG1hXQ0KPj4gwqDCoMKgIHBy
b2Nlc3Nfb25lX3dvcmsrMHgyMDYvMHg2NjANCj4+IMKgwqDCoCB3b3JrZXJfdGhyZWFkKzB4MTg0
LzB4MzIwDQo+PiDCoMKgwqAga3RocmVhZCsweDEwYy8weDI0MA0KPj4gwqDCoMKgIHJldF9mcm9t
X2ZvcmsrMHgzMTkvMHgzOTANCj4+DQo+PiBNb3ZlIGFzeW5jIGV2ZW50IHdvcmsgdG8gYSBkZWRp
Y2F0ZWQgbnZtZXQtYWVuLXdxIHRvIGF2b2lkIHJlZW50cmFudA0KPj4gZmx1c2ggb24gbnZtZXQt
d3EuDQo+Pg0KPj4gU2lnbmVkLW9mZi1ieTogQ2hhaXRhbnlhIEt1bGthcm5pPGtjaEBudmlkaWEu
Y29tPg0KPj4gLS0tDQo+DQo+DQo+IGNhbiB3ZSBwbGVhc2UgbWVyZ2UgdGhpcyA/DQo+DQo+IC1j
aw0KPg0KPg0KTG9va3MgbGlrZSB0aGlzIHBhdGNoIGlzIG5vdCBtZXJnZWQgY2FuIHlvdSBtZXJn
ZSB0aGlzID8NCkl0IGhhcyBDaHJpc3RvcGgncyByZXZpZXdlZC1ieSA6LQ0KDQpodHRwczovL2xp
c3RzLmluZnJhZGVhZC5vcmcvcGlwZXJtYWlsL2xpbnV4LW52bWUvMjAyNi1GZWJydWFyeS8wNjEz
ODEuaHRtbA0KDQotY2sNCg0KDQo=

