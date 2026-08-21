Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDC23C5DF87
	for <linux-nvme@archiver.kernel.org>; Fri, 21 Aug 2026 09:02:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:Message-ID:Date:Subject:CC:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=c+jzObGWUnALohtuuXnoSsaQCpp91PLh/Bvek2+V1FM=; b=mbjK7+QcdB03Tb6y3ml9Kh5rzD
	LtQjG3gCw4eMu79x+nrU0rqtFPtSQge2lQyDSp6NO4X9QGHQYGrUG+wJu1kp10Bv3vzPaY0PEiIih
	1eu/g+Im+NLI1lt+RR3fYG8g8RjW8AkZ6FLDPinPGev0IBsi3Wf5OLuACZVsfKGf7ZFSxH1bFo7MU
	2yduL+9Kp3Eserr4Qvb+NpFDsHRPY3RGqmTwo0gzDx6q8c6HN6Sq+IHCmiH2cif5opkgDiydVBNQM
	RXbgbD9EqwNxrlm/YYPQuvFamdZF7RzDvSiNZ6LLeXRcsY5a2hsN22dgaKl0Cqc7J2+oVaHjCJZV2
	6WHm51pQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wxL8g-0000000CsIb-08mT;
	Fri, 21 Aug 2026 09:02:14 +0000
Received: from mail-northcentralusazlp170100001.outbound.protection.outlook.com ([2a01:111:f403:c105::1] helo=CH1PR05CU001.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wxL8e-0000000CsHg-0q59
	for linux-nvme@lists.infradead.org;
	Fri, 21 Aug 2026 09:02:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mY3zhpMFCr3p2Q9DFImMsITvKUySvWUxNRhP4wPttSpG/eiI2j+jwRcxWNOeVp0t0ir65otW6xgzmxozGnJ/D1/42aHD78ajO/ttI2oyPPk/JMQf8bAyYzm4wL+AnykGCvdkyke1fEvYar58JMWEnFPvP6DLTxItyYkGWeBvNM5V6sKlcMJPRaM2aZ7hZQZc7z7WRmMhYj28aHm2GVcLt3ojtohoS0YxuzVJ6dgs90ydvBuGrXHI8UkPiL7MADR03/S4FKuTJUYbKcUQ3ijuLGtlL9GbHMs8JLGITeETvJx5u93VYd/XTKJu21IT34HlsUeHQQevr6F5n/FZDSTQMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c+jzObGWUnALohtuuXnoSsaQCpp91PLh/Bvek2+V1FM=;
 b=BDauIGrvJpymrQ3Y+rwn+ReyDJ1ziFHxLO/yEHE3rFw0j3KwVNOoSpaOldPGKIGZrKGO7vRQosbdH3zfxzHEFc/l/DXPPP4IuAPhhFbkDdll2RWHgZE7sL73D9WeKfu90DdmrYXcpcB3riVVbfrEWDB0fs8XQsBqm/nCqbHn9zT07NEhmJilKmQMnx2OubRkz/N1aeCRR9A39J/XG0ZyUI3tw2vtYtteXdtO86GQVcpOWeWYt9EVORcqmK9jIgMHxcr8P9l1TXM3svMXWT+PJD7E9GCBkj8uK3+3mUyGAM5TS4zISFNMn4osD0AFovCq5ftZYd/L938VQpLSrjCNLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=helsinkimemorytech.com; dmarc=pass action=none
 header.from=helsinkimemorytech.com; dkim=pass
 header.d=helsinkimemorytech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=helsinkimemorytech.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c+jzObGWUnALohtuuXnoSsaQCpp91PLh/Bvek2+V1FM=;
 b=SkhBRKnjIougXEpQLDnoky5G8EroSl//UwxXKA3OB2oHqaTker8yxCZo1sz1WTEatkq6ksqAXzLbadQ0q45Zsr87Abrko0pXvY04VFyJ5vDS/PfJeFsAp+f2dtUQdo35P53NgwvCR3NC+4CNB0HVe7LJFBVk5iIodJcZlTgvZwYDav5sTzBMt3TxfWSzH5wJeLyArlQu3oHkvr7UrXrOEeBy8f8gLJX1n5KBhGD4S0zdJRIbdiLhrC7fyw2pWXy2/6VGCRjb2eWmETk9S6EA68xeEgyqW1LLGRUajCykhDC3heniMZaXPpW5Lx0d1WigrYmp8VExyvYB6IMU2WlHsw==
Received: from IA4P221MB1623.NAMP221.PROD.OUTLOOK.COM (2603:10b6:208:56c::20)
 by SJ5PPF510DEBE1D.NAMP221.PROD.OUTLOOK.COM (2603:10b6:a0f:fc02::6a3) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Fri, 21 Aug
 2026 09:02:05 +0000
Received: from IA4P221MB1623.NAMP221.PROD.OUTLOOK.COM
 ([fe80::5c00:6f89:8496:336c]) by IA4P221MB1623.NAMP221.PROD.OUTLOOK.COM
 ([fe80::5c00:6f89:8496:336c%4]) with mapi id 15.21.0339.010; Fri, 21 Aug 2026
 09:02:05 +0000
From: Marko Ahvenainen <marko.ahvenainen@helsinkimemorytech.com>
To: "hch@lst.de" <hch@lst.de>, "sagi@grimberg.me" <sagi@grimberg.me>,
	"kch@nvidia.com" <kch@nvidia.com>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Marko
 Ahvenainen <marko.ahvenainen@helsinkimemorytech.com>
Subject: [RFC PATCH] nvmet: passthru: use Invalid Field, not Invalid Opcode,
 for unhandled Get/Set Features FIDs
Thread-Topic: [RFC PATCH] nvmet: passthru: use Invalid Field, not Invalid
 Opcode, for unhandled Get/Set Features FIDs
Thread-Index: Ad0xS1MlsSFko5cdQN2aGdEMG+HkzA==
Date: Fri, 21 Aug 2026 09:02:05 +0000
Message-ID: <IA4P221MB1623401F07A6952EFC9895FDF4A32@IA4P221MB1623.NAMP221.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=helsinkimemorytech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA4P221MB1623:EE_|SJ5PPF510DEBE1D:EE_
x-ms-office365-filtering-correlation-id: 3a1d11f1-f39c-4ba8-fc85-08deff62df6c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|10070799003|23010399003|1800799024|366016|376014|56012099006|18002099003|3023799007|38070700021|6133799003|10067099003;
x-microsoft-antispam-message-info: RdCoLV/wRlDkLB7HjYFAZ/uCpQDuZtwN3Vp+D6Kai7t4/WAzNHYM1JzGI7SBlih1qRHjSxdVavjINN5lNnwSL4Men423RF1KriUIZjBHJ76WUAmTZCZj2tMN3XjHUHKjqgPtxMHSZUtEdDPTkMqawbqCeUFqtbQqRHZL9UjOdYe02iu/oOIESLI3qILKzwOXu0AZjD7+RQsEov68iMrBnkZudv+ZpmcKZhwsHvn3+ttlhy26pzIMFV0WvBoOYG3daA1dIjYJYVlajDKKayUIVOJpbSgYx/3tb5POujG91t5BEcPy20m3JzjFr9CE2u6RhxDhez5ls5OJ2Yl8bZNrkQX0Fr/61+SiXXGJG7w+0lOot0M6z9Fk644pptuJ0uWk1BsbA4dGw/XRA0g0BxebGJc9EdHvmLY/4BayB6ZcL+Gpuqr0dV6OZjEe9evfewFAgZs0o/EPw8SuIOyk95rq6vDUGeDg2cfuDZCFA93T7T6hPuRvX0yeMzAvpxk6sw+n0SQIMGBgNbKyHNSMDXWRmRSdrqM1qYLZx3BBWh6ZBPRddZW+BV3cFXICmPayD6moPk6zBKmRbdU1pbf5waL3DyphbEgdS388WFt6dAkrp0k8QZEOGTiYh9MU8lznpZ2louWsZnm0mrI+uNsn9U1iHj5abcE/1bSXk/gbMcHwzsFc3pbnhqjpaWvIoDqvjZssLpBsrSLEnEoP5k4GhFuOww==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA4P221MB1623.NAMP221.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(23010399003)(1800799024)(366016)(376014)(56012099006)(18002099003)(3023799007)(38070700021)(6133799003)(10067099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bmh6SGNaK0VBd09LdW1KTmFJT0g5NkJ6R2N1b2FFQm13M0tSdXhQaDlNdTE3?=
 =?utf-8?B?RS90QUVFUzFjU0Y5VlFQaStiS1FaV0x4R1FPOVdoMmtkbDQwaWt3bEdGbzBh?=
 =?utf-8?B?Y1d6TURIcFVSYzY0SUVOdFBkN0NnbGpsOExHYktXWHBtUWIzRFhVUktsL2ZC?=
 =?utf-8?B?TzJtSEpSZ3N2OXhhaklxelI3eWN4VGdrSUZIMjVrcFRkL0tiWkxZYmdrSGNR?=
 =?utf-8?B?cGFDRmpoT1J3TXNSTHo0UHNWNDNGb1NJRmFxMC9zMk5wTW5DWjh6THVrTnhi?=
 =?utf-8?B?R2ZqVXVhYTJkQ2hJZkNlSng3dEZuNk9HNTk3VEFpdUFvaHBnT0lmbUhnSmRj?=
 =?utf-8?B?Z3JiSjBlekNqdHlvMnQxckxYZGF6U0RXUnJlbHhDWVdBc1NLc0ZBay9RaE0y?=
 =?utf-8?B?SUNtei9OMXpPNlZ2dDBEQXN1TnJHQVZ0d2VIWm5mY0V2NXFKQUNXQzUrS0Zw?=
 =?utf-8?B?dmFoSG04bmxOQm9WT0tYTGZoMlAxaEpMZjhNajczSFNHcUh3ZWFzdnZiWS9l?=
 =?utf-8?B?cSsySHJxd0R6Q0pmSkJsNW1vSWg3dlM1YWxSeUYvQmZlc0E4cEZCMUVqWVhE?=
 =?utf-8?B?UTRjamFseUlNbjJVNTl1SFBzTjYyNDI5NWhtNFlYUU9UOWxIcjV3ekFWckZm?=
 =?utf-8?B?ZlcyaElZYUdiS1RMY2FPVjBNZi90WXFmY2hZdXh6djhjdHVHRjEzTUtiOGZk?=
 =?utf-8?B?MmRYR1JySkNzSm9FbGpQV09lbjVrYlkwL3ZXQjB4ZnNFbTlubDJjeEZ1NTRN?=
 =?utf-8?B?ck44aktPTVVYb0NFbWxpVkNHK3VuMmVzMk1QN1ZHR1p1VmEySTVYMGRPbTlW?=
 =?utf-8?B?b240S2tFY2dCb3NqSzgvSHZNMVdYdGRtWTRDUlQweWdVTENYbERwMG05MmtR?=
 =?utf-8?B?bzdEYS9WUWtMZGpKMTlodUtKeTNKaXF4TnAxVjg1blRyN0dXR25nc1Rxa1pR?=
 =?utf-8?B?cERmdTN1Y1h3TFh0aWcrc0VWRlJRK3J1ZVdMa2tTTmFHMG0zOFBEYWJCNThM?=
 =?utf-8?B?L2Vtb3c4Y1o2OXBnTXBaNjFGSytPMko5eXJNK2twRWlhTVNMVmNvQVRLSnN3?=
 =?utf-8?B?SFF6NHY1QmR2SGRSLzlLdFhlYktycFlkVGgrNnlJaWJJNHdrYkdFVXZrVng0?=
 =?utf-8?B?dmY1UzlTUnZWengwV2FqdUdZK1N0Y0plZ0lNU29qVHhxeHlqbHp0c2xWalQy?=
 =?utf-8?B?S0R6Qm5TMVg4ZWkyUzQ4UFR0Um8ycmpWaUs1WVFvdWxTaC9VeWxEY21qUS9J?=
 =?utf-8?B?NDhiWlV5NlNEcmFiMkF6QUE2QitHbWZxOTN2RU5Yd2VzTk9SQ1pFYThieTdS?=
 =?utf-8?B?bVh6NFphbXdpYjVYTmlJWTZQbWdMMVZ4SExzdlhWUW9neUhwRXBpbHJUTitj?=
 =?utf-8?B?K2JCbE5YS0lxMWVVQUU5cW9WMmFPS1Btd1VzZFpESWo0REYybXRsMkdOYTZY?=
 =?utf-8?B?bHhJbXp0bmo1WEZUY0x4enNOYzI2aDYzSU91RGx0RzZvdGxDclI4dk5HK0Zj?=
 =?utf-8?B?OXQ5b2JablBvalFwSTI2RDZKTEpPSFlNVitJWnpwT3JUL0dpc1dIeHpjL1B2?=
 =?utf-8?B?V0tlWVMyY1dCNWY2bG9UMEVYM0FuMGsrVVBOaGtPd1B0anIyZklmbW9oa3F4?=
 =?utf-8?B?TzE5NEpDNDQwd2ZpM0lKNDNjdm1VM2laOVpFV0k5ZC9iMVFidUR6dG1TUFlo?=
 =?utf-8?B?ZkY5b1I4WDNYc2hOZTdobm1BS3AzdnZ1VmUzRDYwNjBmT0dOR2F6c1Z0Z0tC?=
 =?utf-8?B?RUYydU8wZDBMckgvWE1ZUDZrdSs2VWJUZzA0OVBKSkFxRUJKaDFBb0NDOTkr?=
 =?utf-8?B?c3BFVkhnMm9tbUNFZTB5c1oxZTIwVGFra3JHaXVCTm1jcnM3aHpvSmhCV1Ji?=
 =?utf-8?B?aTlvamlrd1VpZXQ3Z1JLdXQ0MGFnb3dYb2ZJWjZPWGVNT0FIc1NocG96RkpV?=
 =?utf-8?B?SFI2TkE2dnR2YUJsOURPM3dGSVpWQyszbHBRck45UVRtVmpsOHlBbWU3OGVi?=
 =?utf-8?B?eVE2M2VBd2VTSjVOWUpyaDFFVVp3Uy82NjlLL2x4Y00rb3Voc1hLNERXdkNN?=
 =?utf-8?B?YkJGOTJOcDhvS04zbmU3WHRtemZkb21qVkJNQ05kaFc4UlU5S0UyQUxjZTNO?=
 =?utf-8?B?R2psdUVncmVzbnRhVDAvSTZwb1NEbS9vR1VkYk5CcG1NU2pRTGR6dHU2Z3Fs?=
 =?utf-8?B?NU9TcmFuRlVzTkVCR215WnNZR0JreXdhaExUbzFRN3lhNEVJK1NMUkhPQXlh?=
 =?utf-8?B?Vmg2eFE2L1J4aE9nZ3d4WjVrSkNYMStpdjE2UGZiQjVJREsyK1R2S3lyWm1N?=
 =?utf-8?B?ZXRlcjE4MUk2VVRnUHRyWW9hL3QycktDRDQ3S21qOUhYR3M4aHljbEErWGRL?=
 =?utf-8?Q?1wUjINM4iHlEvV4Yk1XxKfOS7a1yBNEaI+msbhZ37xiD8?=
x-ms-exchange-antispam-messagedata-1: elYRzna/vWYdYj/3q7dy59p/N6euPhQo6Q7i1IHNUPaSsdoVYCyccmEc
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: helsinkimemorytech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA4P221MB1623.NAMP221.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a1d11f1-f39c-4ba8-fc85-08deff62df6c
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Aug 2026 09:02:05.3299
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9bffc3a-91d7-425f-aa80-f1c3728b9da4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xqyAoV/c7ciKRPy1yu5aF5meQ52A6SybShVBjIB3ATlNNr32ny7z2ezMOXldw4kwy994mPuYTcJxbA9Wah1GQ1a7YuL7Qrhm3WymN9x5+d/EGzyzLabtEDKVKe+fzmrD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF510DEBE1D
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260821_020212_263733_B02CB1AC 
X-CRM114-Status: GOOD (  15.59  )
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

SGVsbG8gYWxsLA0KDQpNeSBmaXJzdCBrZXJuZWwgcGF0Y2gsIGJlIGdlbnRsZSA7KQ0KDQpudm1l
dF9wYXNzdGhydV9nZXRfc2V0X2ZlYXR1cmVzKCkgcmVqZWN0cyBhbnkgRklEIHRoYXQgcmVhY2hl
cyBpdHMNCmRlZmF1bHQgY2FzZSAtIHdoZXRoZXIgaW50ZW50aW9uYWxseSBibG9ja2VkIChJUlFf
Q09BTEVTQ0UsDQpJUlFfQ09ORklHLCBIT1NUX01FTV9CVUYsIFNXX1BST0dSRVNTLCBSRVNWX01B
U0ssIFJFU1ZfUEVSU0lTVCkgb3INCnNpbXBseSB1bmxpc3RlZCAoZS5nLiBGSUQgMCwgdW5hc3Np
Z25lZCBieSB0aGUgc3BlYykgLSB3aXRoDQpOVk1FX1NDX0lOVkFMSURfT1BDT0RFIHwgTlZNRV9T
VEFUVVNfRE5SLiBUaGF0J3MgdGhlIHdyb25nIGNsYXNzOiB0aGUNCkdldC9TZXQgRmVhdHVyZXMg
b3Bjb2RlIGlzIGFsd2F5cyB2YWxpZCBoZXJlLCBpdCdzIHRoZSBGSUQgdGhhdCdzDQpyZWplY3Rl
ZCwgc28gTlZNRV9TQ19JTlZBTElEX0ZJRUxEIGlzIGNvcnJlY3QuDQoNClRoaXMgc3VyZmFjZWQg
d2hpbGUgZGVidWdnaW5nIHdoeSBudm1lLWNsaSdzICJkdW1wIGFsbCBrbm93bg0KZmVhdHVyZXMi
IG1vZGUgKGdldC1mZWF0dXJlIC1mIDApIGNvbXBsZXRlcyBhZ2FpbnN0IGEgbmF0aXZlDQpjb250
cm9sbGVyIGJ1dCBhYm9ydHMgb3ZlciBudm1ldCBwYXNzdGhydTogbmF0aXZlbHksIEZJRCAwIGdl
dHMgYQ0KcGxhaW4gSW52YWxpZCBGaWVsZCByZWplY3Rpb24gKG5vIEROUikgdGhhdCBudm1lLWNs
aSB0b2xlcmF0ZXMgYW5kDQpjb250aW51ZXMgcGFzdDsgbnZtZXQncyBJbnZhbGlkIE9wY29kZSAr
IEROUiBpcyBub3QgdG9sZXJhdGVkIHRoZQ0Kc2FtZSB3YXkuDQoNClZlcmlmaWVkIHdpdGggdGhp
cyBmaXggYXBwbGllZDogZ2V0LWZlYXR1cmUgLWYgMCBub3cgZW51bWVyYXRlcyBldmVyeQ0KRklE
IG92ZXIgbnZtZXQgcGFzc3RocnUgKE5WTWUvVENQKSB3aXRob3V0IGFib3J0aW5nIGVhcmx5LiBU
aGUgRE5SDQpmbGFnIHdhcyBub3QgdGhlIG9ic3RhY2xlIC0gb25seSB0aGUgc3RhdHVzIGNsYXNz
IHdhcy4NCg0KVGhpcyBpcyBhIHN0YXR1cy1jb2RlIGZpeCBvbmx5LCBub3QgYSBwb2xpY3kgY2hh
bmdlOiBHZXQvU2V0IEZlYXR1cmVzDQpGSURzIGFyZSBzdGlsbCBpbnRlcmNlcHRlZCBhdCBtb3Jl
IHRoYW4gb25lIGxheWVyIGJlZm9yZSByZWFjaGluZw0KdGhpcyBmdW5jdGlvbiAobnZtZXRfcGFy
c2VfYWRtaW5fY21kKCkvbnZtZXRfcGFyc2VfcGFzc3RocnVfYWRtaW5fY21kKCkNCmFscmVhZHkg
c2VydmljZSBBU1lOQ19FVkVOVCwgS0FUTywgTlVNX1FVRVVFUywgSE9TVF9JRCBhbmQgRkRQIHdp
dGgNCm52bWV0J3Mgb3duIGVtdWxhdGlvbiksIHNvIG5hdGl2ZSBhbmQgcGFzc3RocnUgcXVlcmll
cyBzdGlsbCB3b24ndA0KcmV0dXJuIGlkZW50aWNhbCByZXN1bHRzIGZvciBldmVyeSBGSUQgLSBv
bmx5IHRoaXMgZWFybHktYWJvcnQNCmZhaWx1cmUgbW9kZSBpcyBmaXhlZC4gSSdkIHJhdGhlciBs
ZWF2ZSBhbnkgYnJvYWRlciBmb3J3YXJkaW5nLXBvbGljeQ0KY2hhbmdlIHRvIGEgc2VwYXJhdGUg
ZGlzY3Vzc2lvbi4NCg0KVW5yZWxhdGVkIGFzaWRlIG5vdGljZWQgd2hpbGUgcmVhZGluZyB0aGlz
IGNvZGU6IHRoZQ0KTlZNRV9GRUFUX0FTWU5DX0VWRU5UIGNhc2UgKGFuZCBwcm9wYWJseSBzb21l
IG90aGVyKSBpbnNpZGUgdGhpcw0KZnVuY3Rpb24gaXMgZGVhZCBjb2RlLCBzaW5jZSB0aGUgY2Fs
bGVycyBhYm92ZSBhbHJlYWR5IGludGVyY2VwdA0KdGhhdCBGSUQgYmVmb3JlIGl0IGNhbiBiZSBy
ZWFjaGVkLg0KDQpTaWduZWQtb2ZmLWJ5OiBNYXJrbyBBaHZlbmFpbmVuIDxtYXJrby5haHZlbmFp
bmVuQGhlbHNpbmtpbWVtb3J5dGVjaC5jb20+DQotLS0NCiBkcml2ZXJzL252bWUvdGFyZ2V0L3Bh
c3N0aHJ1LmMgfCAyICstDQogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0
aW9uKC0pDQoNCmRpZmYgLS1naXQgYS9kcml2ZXJzL252bWUvdGFyZ2V0L3Bhc3N0aHJ1LmMgYi9k
cml2ZXJzL252bWUvdGFyZ2V0L3Bhc3N0aHJ1LmMNCmluZGV4IGUyN2Y4NGUzY2YyYi4uZGYxMzk2
MDgxZjg3IDEwMDY0NA0KLS0tIGEvZHJpdmVycy9udm1lL3RhcmdldC9wYXNzdGhydS5jDQorKysg
Yi9kcml2ZXJzL252bWUvdGFyZ2V0L3Bhc3N0aHJ1LmMNCkBAIC00ODMsNyArNDgzLDcgQEAgc3Rh
dGljIHUxNiBudm1ldF9wYXNzdGhydV9nZXRfc2V0X2ZlYXR1cmVzKHN0cnVjdCBudm1ldF9yZXEg
KnJlcSkNCiAgICAgICAgY2FzZSBOVk1FX0ZFQVRfUkVTVl9QRVJTSVNUOg0KICAgICAgICAgICAg
ICAgIC8qIE5vIHJlc2VydmF0aW9ucywgc2VlIG52bWV0X3BhcnNlX3Bhc3N0aHJ1X2lvX2NtZCgp
ICovDQogICAgICAgIGRlZmF1bHQ6DQotICAgICAgICAgICAgICAgcmV0dXJuIE5WTUVfU0NfSU5W
QUxJRF9PUENPREUgfCBOVk1FX1NUQVRVU19ETlI7DQorICAgICAgICAgICAgICAgcmV0dXJuIE5W
TUVfU0NfSU5WQUxJRF9GSUVMRCB8IE5WTUVfU1RBVFVTX0ROUjsNCiAgICAgICAgfQ0KIH0NCg0K
LS0NCjIuNDMuMA0KDQpUaGlzIGUtbWFpbCBhbmQgYW55IGF0dGFjaG1lbnRzIG1heSBjb250YWlu
IHByaXZpbGVnZWQgb3IgY29uZmlkZW50aWFsIGluZm9ybWF0aW9uIGFuZCBpcyBmb3IgdGhlIHNv
bGUgdXNlIG9mIHRoZSBpbnRlbmRlZCByZWNpcGllbnQocykuIEFueSB1bmF1dGhvcml6ZWQgdXNl
IG9yIGRpc2Nsb3N1cmUgb2YgdGhpcyBjb21tdW5pY2F0aW9uIGlzIHByb2hpYml0ZWQuIElmIHlv
dSBiZWxpZXZlIHRoYXQgeW91IGhhdmUgcmVjZWl2ZWQgdGhpcyBlLW1haWwgaW4gZXJyb3IsIHBs
ZWFzZSBub3RpZnkgdGhlIHNlbmRlciBpbW1lZGlhdGVseSBhbmQgZGVzdHJveSBhbGwgY29waWVz
Lg0K

