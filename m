Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 965FAFD45F9
	for <linux-nvme@archiver.kernel.org>; Wed, 25 Feb 2026 23:59:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=a+AySHUo/VAYAYjCWOV59JyUUuSaERxcrayuBvdavaE=; b=iir0MYg/T8SHbLLwXhfz8Lz3SM
	XaJQJKJVXtbG1jjR0wC7KzXpN5Mip0f/WCfYRpUKI64kMdvI+2bT72bY94HRE0J7/ikZeLYzzxt6T
	3uqGo5UsV8uctvjfuTkIklM9olcsFSUAz36Oncovn0VWzDkxuaS7bSHs+sLrajYbtfqykcT+FVosH
	Xt0JXCGQytZC6Ah8b4poPM1Jg9JsK8KHrIfw4VOK+lvwXR8FkQJhY7rSJmCY03xHYi9ug1yA8tQ41
	ZHsVOD888KBugkfVo1x2UXotCPdd1lPmgIAWmdHaTBVMoaRMRzJTVezT4Nv7mYQ5PsbiFF6SYFdoW
	z8kyQp8g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vvOmY-000000056lW-0gPD;
	Wed, 25 Feb 2026 23:59:06 +0000
Received: from mail-northcentralusazlp170120005.outbound.protection.outlook.com ([2a01:111:f403:c105::5] helo=CH5PR02CU005.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vvOmU-000000056l8-42GX
	for linux-nvme@lists.infradead.org;
	Wed, 25 Feb 2026 23:59:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FuICc5WJMcaz0Nnf43kWg1mohu3vGhqEWTf1uIB9vNRR4I4V3FloqX7MTSLsRzruAzgqNykGQ6wgVvNK+nvH/OMXGhUOjFOwy12TS6uYiqZ3BiHZGyZ2qv80ltrVOOWGkStVTu7iknL7zmgd26nUXhoidA4lSluV8S4KjkxZksYifSJh654qKhhZIQp5xkSZJHBgy3vl3xiHM/C0Lj2dH6RYktJl8t3QVEZCjF5XvgvuK6VpdSLEVy7V/kDI0m3jcm9PVc31F3Zmi0+lIHqWhSY3eGw985md2OoUZxeQjuFNyOds87WcR/zjfpd0JOyX/hvgeKGpWL3xX3VVwWa3fQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a+AySHUo/VAYAYjCWOV59JyUUuSaERxcrayuBvdavaE=;
 b=hQ1ERe7e/DDQuolJRIuP4cUkmLAjqTfHwQlxaoFuTbnx5/2PN3WbkTNt4/oodvloZvRR6SU9Dz/UuJWAd3MKd9htwZoAGT0SJe0O6UER+geJD5oaTCY+rgS8GV3ANyhTIkMgbH2quoXKVuHCehToFplHB8lhFjI5+nO6l0Uqo1N2fGpR8B5lY4dc3nzCW+RKnb62PMepQY4zzpXIRce/NBeXDaqXO0TWBV/7pnBo2EXj70LRaZ+FJ207DWOZ0oSbOLTq5b+6bcoH/rmzYv3lk/8rGC7bDtzr3eznFwBedg2kndPIqAQ5Sv1Lkeo2CMaCMllvtbgeUBr9oMEyBOBP8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a+AySHUo/VAYAYjCWOV59JyUUuSaERxcrayuBvdavaE=;
 b=RpzAGl1kdxzOoZ2DZgKGQT3sr92W1OHA9LQQSBQVIWk4KSGOuiMrvk7Amd2DLus62hdEbEw7fULkktp4z8FPMibSMmdOu8M7c5jNSSq9bwTAVIa9SCGrULRpDozMrVewuu7P3OGoYLFf1YA8OUfrzaXgq5EgrfdP2RUoMi83EZaEKErwR04IQ5A0yPHQNvlg+eqrnyEo8iF9f6TvcrxerpselCFxIQS4kqBEt7fNqNCmTV05zwgdsuB6TQb5BVEpDRjnUHJ5zrD1YMqOQWotavBTasYwvLfr4SwfOZ/oOKotbJQcLw93KlZaGo1ZK9Mymxbc97pekt6eTz+e5aQ85Q==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by LV3PR12MB9235.namprd12.prod.outlook.com (2603:10b6:408:1a4::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.23; Wed, 25 Feb
 2026 23:58:55 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::2109:679c:3b3e:b008]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::2109:679c:3b3e:b008%6]) with mapi id 15.20.9654.007; Wed, 25 Feb 2026
 23:58:55 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Daniel Wagner <wagi@monom.org>, Chaitanya Kulkarni
	<ckulkarnilinux@gmail.com>
CC: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>, Sagi
 Grimberg <sagi@grimberg.me>, Shin'ichiro Kawasaki
	<shinichiro.kawasaki@wdc.com>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>, Chaitanya Kulkarni <chaitanyak@nvidia.com>
Subject: Re: nvme-tcp circular lockdep warning
Thread-Topic: nvme-tcp circular lockdep warning
Thread-Index: AQHcpn1taTkHQI13FEuUg9bhTatHNbWUGGqA
Date: Wed, 25 Feb 2026 23:58:55 +0000
Message-ID: <b4f340bc-8030-4d28-b90e-106ec20262fd@nvidia.com>
References: <c43fcd3b-fa12-461c-9b97-be51b12a74d0@nitrogen.local>
In-Reply-To: <c43fcd3b-fa12-461c-9b97-be51b12a74d0@nitrogen.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|LV3PR12MB9235:EE_
x-ms-office365-filtering-correlation-id: 676419dc-2ac2-4b24-d919-08de74c9d5b2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|10070799003|38070700021;
x-microsoft-antispam-message-info: Iqst7i2YAsQHXHdei0YEvSXvZV/iKSQIpk3e1m388vkbknpaLDpoXLSSUcdR6nXDVX2WJlYfMfvgfYJvrHt5/2dKdWdGtl9b0fH6QIf2odLC8HshlGgf8/c2OLTZSvekm8jt+ngv+LZNjT0DXXb7Vw6RNrT1GHLjQ3z6113qQtwZZHgnh/MxjzNW20f14ySBq81mnEP9D0/Xp2pb6TTx9htWW0QJmxeRo6zXKfxftJZwOET5THnIdcrCDGVuEiJPg02JD4vw2i1kgMHXqKTKJvhbGcQbxX/g98KcXVqCtN5ARp3tHzbY8svxtxS3+v+FIhoQTkhonXgoyH89chLPVi+aU2iE24FyVd6Z4FD/O4YKktYo/+VUR39lehKk7xL2FZmtxvByRal4qa6Mq2yyQzxcMx5qQNR/K7QX+U5lMl++GwEVUVtOFPWpgFx/3w36Cs4b5lJKu9kislt+HcKlSOJBd94DgRqCnTsfyoUBD/maKRzdL/kU/4NHKZZr8jldRlMVRnXa2I8aGEzj6LE+5JdmgoeF2ubB7TfdpeZyQQ3iUI6mb4iMjPUlwO/nSaQtD2KaqzHyVnIBmR9IcmQ+DSIluQtIJqottIQ4JeqRtX9eMdFw6LxUuvY8OvhxKgPK/+rw3HO7MRtujJVtN/9XS3h/orxOlynvXkSlLWy3f5woschZ7rfL3gXIgnvRJt/aahvy1SKYDu27ruT5VsJ5b8HFQwBoKojfHnUvcARDNg1TaXFezTu+nr2x9wudTFIx0iYzwmgf49Mtfva6yQzZf3R/FqRtl+VRi19I192JEU0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(10070799003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cE1uOUNBMjNFZHpOMWhmU1JtWFRuaHc4Q1Ura01wR054NEdlRVFSSEcwREJu?=
 =?utf-8?B?QXI4TTJacGJ4VDNjdm1zd3RtSlphNnQxWldmU3IwOGVKZ1NtWmx5aXIzTFpw?=
 =?utf-8?B?UTFYTDdIRkx4ZDhIT0U1RUFVdUQ3MlpXdDMwL2I5TVZYR1BocHYycmJ1dXBC?=
 =?utf-8?B?MXZHM0pUY1FJU3kybUhpemhvZGVvMnNiVCtzdHd4dzVxbjNVelY5b3ExWE81?=
 =?utf-8?B?dGNiYk1hcUVaaVVCSHJERjdad2F0WEhUT0xCYnBEYnFST2tUTG9CYU8xcERC?=
 =?utf-8?B?UzI1aHN3cVdpU2FoMm9VODZpaHNYenpDaHh1K2RxUUNoeXVYWmdyRk9HOUln?=
 =?utf-8?B?empCZ0hQU0h0Rmp3Tk9mNGxwbm9xMkdWNSt0WmhkRW9GL3ZFajlQdEUyZk1E?=
 =?utf-8?B?QUllUjl4OThhd1dscVJnTmpRenpBam5QNlhKN1NacVN2S1hxNkh2RjRDS3Fq?=
 =?utf-8?B?b2xaN3NLa2t1TjFCVEpmL0dlRlNOUk1zZUw3cVNyQmRJQldxUDJyODFERlhN?=
 =?utf-8?B?T3lkdG1wajFhUTE5ZUczOVlLYzVuK0F5WG0rSDNVTkJEaXlFWStBam14eHAx?=
 =?utf-8?B?VHR4QXYzNk13c2g1dlczV0FIdG41aU9iTzZjZjhVaExhUUZwZnZjT2hEUGlQ?=
 =?utf-8?B?bDUzdGkxTjRiMTNDRjRtSEZKVExKUEp5SzJGaWhaVS92WW1LRU44aWovNG9o?=
 =?utf-8?B?d1NhaDBXUjhOSklOb1VwVFIwZUFoWkhyTU9rdHlJbnBMNlRRNGZUM2NRV0J4?=
 =?utf-8?B?OVFGeldBTDR5K0hCM09VVHJpSVdCRmNjdldMZHRLUTFvSkZLS1UwT2ZSRXda?=
 =?utf-8?B?R3hsbytRK2gwQkdPVmovOFlzRlRtY21lWUFxWDJTREUvREtRMnNpSWZRemJh?=
 =?utf-8?B?OXZFQW93ckNEbndjZEZkMGwzUEJ3OW9Zdjh3QmExZmFPQkVOVjNDZ01FdjdW?=
 =?utf-8?B?by85T1gwWmZZRHcwYmp3WW9ZeS9XVnRCbitUVGM4a3pRS0lKU25xY0N6aWQ3?=
 =?utf-8?B?MVBuamdvN0EwaWphSVBhdzdiaVhJcTlsekFpV1RMczB3L0x6T0RYUnNEL2dh?=
 =?utf-8?B?TXNwUkU4UTZoMnZwdUgyRXRmRVhiNnZYUDdnaHd1bEV5eGZwNlcvNmVoRkFJ?=
 =?utf-8?B?YW9rdHlvZDJLNVc1bDRNc0VpamdpbXYvRFJ4anhCVEFUSTNsa0p5RjM0dHdr?=
 =?utf-8?B?T3ZLNnlEOWp3R2RJRDc1cjZRZldDSFN2TXNQVExWcnhUTlhISlJKSFY1MFlL?=
 =?utf-8?B?ckd0NTFZTTZ2OHpjcGVOSlBjdFZ0KzB3NWpvMllQZGRCUmZ0SFh2b0FUa3Ji?=
 =?utf-8?B?SXF2Z1VxU3hDakVqcHV3QldhTjl2SFYwR1I3dFFUVnNoVWxlWTR1RDFLa3BL?=
 =?utf-8?B?RU9TUUtHd1VJV3NuS0RxU2tFZWhDaWs0TXlFVXY2d3d1QWZMbzNYYklJRXVS?=
 =?utf-8?B?M3NINWJVWWNFdUM5QVI5NGMzRDc0bmxDTG5hK2dXb1lUYWlPR0lXbzlmaFIw?=
 =?utf-8?B?ZzZZZnArQXEwV2ZEVnU4dFZZU2dKcjFUTVl2anlWTzBzWElIQ05mM3NrdlU4?=
 =?utf-8?B?Y2hrWHA4dlo5QVFUdHFWSUdzQlRCNkdDVWN0TXNSU2lINWJySjdqSG01Q3k5?=
 =?utf-8?B?bWgyQ2tuYnJXRXUzNnlXbGd1R3lzenNDQjI4d1JhaDFSdjMzZ0FnVEo4V3NW?=
 =?utf-8?B?YWNrL0E2OEVBVmtjRWJnaWpXU2dxQ2JVUi9GZTVVa1NkN2tyRVpHZkVxeGpp?=
 =?utf-8?B?VVQ0ZGtORVc2elJ0UlRRZ1BodU96bUpJNjdrZHZ2RGVGbXd5QUtYMW9yaG5W?=
 =?utf-8?B?ekxEWXQ3VE4zOGhNZTZCQ1JhcVZWNlU4SVc0azJiWitsbk5QQmhyYmY3MHAv?=
 =?utf-8?B?Z3E5QUU1TXBkK0pQSzY5OHNoeTBudlZ2OVI5NU5vTE9lKzlvWitKYmplT3J3?=
 =?utf-8?B?ZUxMelV6SzV5cFp6ZE4rZERQaFVvQzFFakVrK0lkUkpNT0NWVkRSdzROQ2FF?=
 =?utf-8?B?VlNLTmFpejVJbnJUT3ZsYUNDMmFBWnIyZkF2ZWNQWVkrM2FsdkVXeU9SNUpP?=
 =?utf-8?B?dDVjU296L1U3Ync2VEk0b0ozdU1vYUVIVGZ2QnhnSHBobTUxUE0xQlMxc28z?=
 =?utf-8?B?Q21SMEdoTmtsVXE4NUxldEZTWCtodU5wWHo4bytpcEQ4eHJXZFZkZTJhRXp1?=
 =?utf-8?B?Uk04Skx1ZUEvUlpOdzNlNmxuSEhZN1dBc3ZCb1JTbWJ6YkFhaDk4UjczWjRu?=
 =?utf-8?B?dngzSkR6ZEswOUcxaHNOalZqUXcxNG5raHorOWVtTUdJWHJ6c2V4VGtFUWRU?=
 =?utf-8?B?UDBiWmRRMml6UVZQVFdFMWdiWU5Fc1pPM05WOFBGMUJnc1BVeGhNTkRwNlNr?=
 =?utf-8?Q?rmFTzkJoSKhadFUkARi9aRgw33QExorGqlflGjS6x5Ykl?=
x-ms-exchange-antispam-messagedata-1: HFAnZYUm8mZvRQ==
Content-Type: text/plain; charset="utf-8"
Content-ID: <69FA33F28C275A4E8F5E954B97E8E040@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9404.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 676419dc-2ac2-4b24-d919-08de74c9d5b2
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Feb 2026 23:58:55.5480
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tlIx5E2pEUki6IehH+SL/OMw1C/8D+OAjIPx7IfyFuVWKzaO9fQLMRS6MSq87H+k7A8C5+LfGr3XfuE3aPZ7zA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9235
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260225_155903_001970_05D1B2D0 
X-CRM114-Status: GOOD (  11.58  )
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

T24gMi8yNS8yNiAwOTozNiwgRGFuaWVsIFdhZ25lciB3cm90ZToNCj4gSGkgQ2hhaXRhbnlhLA0K
Pg0KPiBUaGUgbmlnaHRseSBDSSBidWlsZCBmb3IgbnZtZS1jbGkgcnVucyBpbnRvIHRoZSBsb25n
IHN0YW5kaW5nIGNpcmN1bGFyDQo+IGxvY2tkZXAgd2FybmluZyBpbiBudm1lLXRjcC4gSSBzYXcg
eW91IHdlcmUgd29ya2luZyBvbiB0aGlzLCBidXQgaXQNCj4gbG9va3MgbGlrZSB0aGUgd29yayBz
dGFsbGVkLiBJcyB0aGlzIGNvcnJlY3Q/IERvIHlvdSBuZWVkIGhlbHAgdG8gZ2V0DQo+IHRoaXMg
cHVzaGVkIG92ZXIgdGhlIGxpbmU/DQo+DQo+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xpbnV4
LW52bWUvYzZlODhiYzMtOGNjOS00NTAzLWE0NzItNzY5MjQ2OGFjMjE4QGxpbnV4LmlibS5jb20v
DQo+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2FsbC8yMDI1MTEyNTAwNTk1MC40MTA0Ni0xLWNr
dWxrYXJuaWxpbnV4QGdtYWlsLmNvbS8NCj4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvYWxsL2Ez
MTU5NDAzLTczNDQtNDYyNy1hNDEzLWYyODlhMzEzYzEyYUBudmlkaWEuY29tLw0KPg0KPiBDaGVl
cnMsDQo+IERhbmllbA0KPg0Kc29ycnksIHdpbGwgc2VuZCBwYXRjaGVzIGluIG5leHQgdHdvIGhv
dXJzIC4uLg0KDQotY2sNCg0KDQo=

