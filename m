Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F835C47DD9
	for <linux-nvme@archiver.kernel.org>; Wed, 28 Feb 2024 05:25:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=CCgOLz4VqNYcUxXOL9/8AWEDMrZp70d+A9hTfND7U2U=; b=M2pBJlfvo2Bx2N4j5H5ceBmCkQ
	ZQFo3Xy+OpwGx/Awfz6bvr3JtDs7yYfiA5wP9vZlqlhoYaFkDWbg0AnFU5PcVpyYBLZ+sBpSM8RR3
	BZ9P7qcgjPfI3y9/qF2yYjBwZop+ucGaIEyoQH6XWnIseJs0KK61acSGHCPqhuKjvLdpWjsp36kQU
	x7Lw8ZPcKo+5qmawnBpkfnRH9gFrwl7ubko+UKYX+iBgh++pCKo9tvDwMrdKWBkqCiGdRE5m467DN
	s4dtxV+cv6PdNwJvNrrNXInO4+njAc9ewXBZvZmvq+576/C+IZsVriZSYClQ46bB41LAsyLkGw+df
	lVj5OS9w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rfCRd-000000084Ls-370A;
	Wed, 28 Feb 2024 05:25:29 +0000
Received: from mail-dm6nam11on20600.outbound.protection.outlook.com ([2a01:111:f403:2415::600] helo=NAM11-DM6-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rfCRa-000000084Ku-2gSP
	for linux-nvme@lists.infradead.org;
	Wed, 28 Feb 2024 05:25:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LbDqyMhOjXojXk7S0AQDsKjkBH4as39cNpk1HNBSskJD0rjpva/kYki1NQSJ1yDMJ13La2lTxSj82+6QejvrRojNu0RBz3IVC6z7/aKaUyck1yt2ACCyLisQwnjf6fAfpjnNUeNQt+8LyKGAosn/WRFqnCFcyzXataKj6VTl1SHNXeLrzLDBHbB6oEjhsTy5YePyBAMnaYdkh/z1YKbk1mYThFtxblqyNz5P6F5TxGJJT8rZvR7Xx2H5Z0t/3yoqGMM108ipfftMfIIk2pcElsOwnMYPnNY9d6IErRh+pTyq9QYFQwIeuUD3LSKhayejfco2j54yBYW/VQo4uNyg/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CCgOLz4VqNYcUxXOL9/8AWEDMrZp70d+A9hTfND7U2U=;
 b=ehjD/+zIi+jkeiNy/q+Fvr0b9z8b2a8V2PMsDWyzeCwUwt/v9RDYBNgMZ4SVSrvaFMR2SR8S5fomoEajzkqiNyjaQggY9iEKhC6CfYlUvHAplSPgnwjdeDu0AKFyTc/fqSEQrLIKhPcUMd3D7Hgr+Ofm2tj9p4RkR3I8F72VtlTp8rPP1PS5LIgRglmsSet/Vyhyt/ngIdDoirNppFROBLCFzP27R0hw7kqjEVz5MdapvpNBQkU+MLJSvaDfVGoAosEUC5CBfd2MIN3Vo2EaloUIR3Gazgs2VgWcKcV1MYX2FElVsgzkIZZX2VTXsCFVeoKGZKtukznyzSAaXzEy3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CCgOLz4VqNYcUxXOL9/8AWEDMrZp70d+A9hTfND7U2U=;
 b=cWTng+yCTjwcb62gtD3fVoDddQJ782IZHZUbfCVw0B3hhGjYIwvryek9KgoO9soZHiSrxdilKiByOZ6whMHIAgoMSvq2xI38F07ShmK3xHOUgv04NfFAk6fHJpREAu3OI794UMHUNeIxfRww4up4k77ekkZ/Rgq4S0Co0DV6Ue0McY5QjWx2f4SXKWTgSxrZaoJi5gz+kZEaJBCd7Wh3oyYmKce1Qt8cEhp6WAlqbnzPV/sPK8zMnsW+L7PQjWd9aiVFDDhRF0RX16Srbf5RGoIFkGohU3DcrcUUEE9KT28ymA0pbCi2CRc/6QW8sjraYWUdwpk+1j8WboPhQPLT0A==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by BY5PR12MB4952.namprd12.prod.outlook.com (2603:10b6:a03:1d8::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.39; Wed, 28 Feb
 2024 05:25:08 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::ffce:bbde:c1ca:39ed]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::ffce:bbde:c1ca:39ed%4]) with mapi id 15.20.7316.034; Wed, 28 Feb 2024
 05:25:07 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Guixin Liu <kanie@linux.alibaba.com>, "hch@lst.de" <hch@lst.de>,
	"sagi@grimberg.me" <sagi@grimberg.me>, Chaitanya Kulkarni
	<chaitanyak@nvidia.com>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH v2 1/2] nvmet: add tracing of zns commands
Thread-Topic: [PATCH v2 1/2] nvmet: add tracing of zns commands
Thread-Index: AQHaae4/VwEYF+yoD029s/dDzTAiwbEfOR6A
Date: Wed, 28 Feb 2024 05:25:07 +0000
Message-ID: <b6e63b26-f5df-4ead-aad6-06f7c214373e@nvidia.com>
References: <20240228023118.84959-1-kanie@linux.alibaba.com>
 <20240228023118.84959-2-kanie@linux.alibaba.com>
In-Reply-To: <20240228023118.84959-2-kanie@linux.alibaba.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|BY5PR12MB4952:EE_
x-ms-office365-filtering-correlation-id: a70d6d31-3557-4264-9386-08dc381da093
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: n/rdh/q+ckxz7WxLTMOQuRDCzkCC89PbTQSNVlrie57WfDgxnwprTlvYy83Vyju60RIIPPhGInbA90ejQGvg1YKl54o0R6fd28MugESKRMAYNAeDMFw2qpgxGxIh84tY79lDvEovR4gfIPnsbEHzvAi3hP+M5W5rpCBw/EwlqLXbkBdut+xF7eyq3QYSSpNQa/DZzSxVGvKrykTEx31PE71KP1E7c8UslJIZnlbliu/67cIHwXJzkVG7fxfvstAHLBxSQXk/xn0uZO/gAw/78X7xbwMMj2mH2pa1MOv90ANEimR24pkQGwy7YLga1JF6iJy9V9h8/Lm75BtS+CAcFkDtohO9+40W2jpxrVJZHkAoe+BEJQvLkvZpU+U2MmDMC+WJeKEwwZYm4to70zVw/kMJz1cfU4K4d6662tDqfeZ4cVuMM1mzONuR8CaaJybBb+bfz8v4C/dPS0JAqIKqUgYSp07n9q2+t6u+1hKyaRtxthUB0SQ8xUTCv8SV6iR2GBsc+CpdBOjwQCcajC/hiJfXnPJK+vnVA/r5zZ/HmmCjTpyP+Hahjf3sgbrOHCiJ0Vdj9evZl66PlZGr2qd3JkkpttkPIuKZ9tNWyt1N9uB9u5TCk0a0RsseWj6KDRio4CXPfUAaWbJU/C6F3ncrYfP+jS3ADNuW4dxkju7ELqAvRlBCV9lS6U2NmHNxHHsyfiFPyoyml22ZmPdzzh/2Ug==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TFlJNW1saE5sVDBhZEdmUUloV2tnZyt0cEo1MWxTNDVpREFWMHFNbURYdSs3?=
 =?utf-8?B?Nm5JN2EzRmEyelNWQ0xrMHdncmZnSDdGY3NkYkJpM3UzNG1yTVNLcEMyUUhW?=
 =?utf-8?B?OEdUM2dsdytISFA3N2tIQmxzRFhDYjBiazU2WDM0MVpZVDFNZHNNbmRkRWRC?=
 =?utf-8?B?SEtZMkVkeENpbTk1TmFvS1cwWU4yTXI0djc4V01oeDBQTng2dGxxaFVkd2Ro?=
 =?utf-8?B?ZC9KWEtFcXBiRXhRY2FTbXBVVlNIWDJ1c01hYVo0RzV6bi9tMlYyeDdWRkdH?=
 =?utf-8?B?OFJ1ZHVROTlEeUM0TmJPTkVwVnVZYVVjVGpCaTJtNThBU2ZNdkJWVTYwdVpW?=
 =?utf-8?B?VWlTelMrbkxORWdtQjVsQUJ5ZkJMbHNnSzVPSnhNelRLc0hPNEFRVGN3TFpx?=
 =?utf-8?B?NkVaM2MxZlplTE91eEZqY1FKUllXcVFkbll6bVgvem5CN2o3NXUxaTdRV1h5?=
 =?utf-8?B?NkRZSUFtbjNwREZWWG0zSVFaMDVla3hNVmFCWkpWNk5HSlN5cGxGa0xMeFZm?=
 =?utf-8?B?MDRYZlVQVlh0RzdPV1MyMGliZXRBdWc4TktQRmdEVEQvaDAvQ3BMVytneHNm?=
 =?utf-8?B?c3N2WExqNzkvbkpuaEMwQlJVaG1IOE90eHpFRTNUS0hHdlBhQ2p1OWZTcjNs?=
 =?utf-8?B?OTk1dncrYTJ5YldibG83QURvWHBEQlpZWlFQUDZEZzRmRXBjeVA3UUM5SjR6?=
 =?utf-8?B?MENlQVVHSVZ1V05BM1FDOVVzb1NkZzFsaGp0TXZnS0xuL2VqQllJN09YVDll?=
 =?utf-8?B?L3hCU1lMWU5mcXpPaUZZTStxdHlGQWd0MlUzN1c0SzdEbm1QMm9MMExFZ01M?=
 =?utf-8?B?cUNoZWhTNzZwV2dLN3NWVzR0WWFRRGRpekp0OVFPTGtndE9SaS94dnpsSHJj?=
 =?utf-8?B?TmNYMGdpMi9SUjlETFpjUUU0WXlNWkFzYS95NXJ2VXZPL2djWHhacUlBUCti?=
 =?utf-8?B?STJmaEEyRGxBeWZ5QmtyclR6K1VLUHVUZHBMT21KZXRPZU1vOGJwSlFCeVIw?=
 =?utf-8?B?T0dMRTB5U3F6clpwcTVTK29Pa1VIczhaeW1sZVFuRTBSc3kwb2IrMmNLbm4r?=
 =?utf-8?B?K1dGZ0tQcmEzaFB2Um5rOEJ6cWIrcEdwbEFsSjhNM2E5b3dxbFBwZ3dUblk5?=
 =?utf-8?B?Z3NKY1IwL2FJb3l6N1psaDBJUkkraTc0NzYxdjdkSkYyc0sxbU1GQklhNjZ0?=
 =?utf-8?B?SnI0Z2xuQnN0a3FLTEJzL0ZLQUZUQU1uOG5hYmdTTzRON2s2K0lrMzVrRnlI?=
 =?utf-8?B?b05LWFVjeXB4MFQ2czIrdkltaFU2dWNtR0NxTFNDc1NJNmhRVWdneEpmZHBZ?=
 =?utf-8?B?SVQzQmtsbXVlQU1hbGVyUUR1eS9nSjE2VlkrZmRUNFJKdG9kKzNIM0hLRnkz?=
 =?utf-8?B?TUdud01Od2NBOFhuazdVZUwwYTdmZ0VleTFWeG8vc3I1MW9UbUZUdWgreHVr?=
 =?utf-8?B?RG5YVldVbnBCdkU2WDRGMWt5QkZLZ2I2NmY1cjFUWUMrWHFRMUtyaUt6ak5M?=
 =?utf-8?B?ZE9peS9XMzNVVkhLcXlLa1pnVkh4aWZHQlZIVXRiNGxTbzMrNzZnR25RV0Rx?=
 =?utf-8?B?SXR2MTdDcXhQV3JVU1g3L1ZvdFVGZ0JnU3U5ZGRCcG9ydG5tOWUwRnZPdnl3?=
 =?utf-8?B?cGR2Z1VMUVdIWHRUR3plcWhrOVlnU0U2TGR6UHZ3RmFEem5aVUxmQXh1L1Bj?=
 =?utf-8?B?K244KzBjWDE2YjJlbUtWU1YxOFphWTcxS3Z5d09qRk8yVWJlczIrcmNzTDJJ?=
 =?utf-8?B?MmxUd1dIcngrSWo5d2YvVVBOZGp6aFhVd042aVRRc0ZMOWZtZWNhQit5cmJG?=
 =?utf-8?B?Z1hDVFBCdTQ2SEJSbU9yQW91T0xpSElvMCtBOURhRmt1L1VkUEE5YWpSeWNv?=
 =?utf-8?B?RFJzYVh4UjdzVkhVeUZYN3ZaekJpT2wvZkxXZlA5ZXhGbmwra0tNaU5pMS9y?=
 =?utf-8?B?MWJHY2pBMGIzOGM5RG80dElHVC9ybXB4VEVySGl5TVFSWGwyWnNUS1R2V2xt?=
 =?utf-8?B?WURQZFppODFFaHZTZlc1OHRvdGMwanRyOFhNYkpSVFFPblBrV1NUV3ZManNL?=
 =?utf-8?B?cEZEcGZvallpL2RPSFQycTg0RGE1dnBITDlyK2VPV2VVdEJwUjk0MTJpRXFU?=
 =?utf-8?Q?jMkU9HqB6c4/55BDelAeBgSXa?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DE7C36030E3FDE4DB04EA7AD1ECC0B76@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9404.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a70d6d31-3557-4264-9386-08dc381da093
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Feb 2024 05:25:07.8788
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jJ69IAUWoxtGejyLHrmQFqnRS28mXtRvK+S18SxEwwLc7Lw+d3pKQAwu6Hr67ff7L9ZH0zUcWAhWl5Ux+nDv2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4952
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240227_212526_738657_0454AB38 
X-CRM114-Status: GOOD (  15.61  )
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

T24gMi8yNy8yNCAxODozMSwgR3VpeGluIExpdSB3cm90ZToNCj4gQWRkIG52bWVfY21kX3pvbmVf
YXBwZW5kLCBudm1lX2NtZF96b25lX21nbXRfc2VuZCBhbmQNCj4gbnZtZV9jbWRfem9uZV9tZ210
X3JlY3YgcGFyc2UgdG8gbnZtZSB0YXJnZXQgdHJhY2luZy4NCj4NCj4gU2lnbmVkLW9mZi1ieTog
R3VpeGluIExpdSA8a2FuaWVAbGludXguYWxpYmFiYS5jb20+DQo+IC0tLQ0KPiAgIGRyaXZlcnMv
bnZtZS90YXJnZXQvdHJhY2UuYyB8IDM0ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysNCj4gICAxIGZpbGUgY2hhbmdlZCwgMzQgaW5zZXJ0aW9ucygrKQ0KPg0KPiBkaWZmIC0tZ2l0
IGEvZHJpdmVycy9udm1lL3RhcmdldC90cmFjZS5jIGIvZHJpdmVycy9udm1lL3RhcmdldC90cmFj
ZS5jDQo+IGluZGV4IDY1N2JkMzE4NDFiMi4uNjYwNGU1ZmU1N2Q4IDEwMDY0NA0KPiAtLS0gYS9k
cml2ZXJzL252bWUvdGFyZ2V0L3RyYWNlLmMNCj4gKysrIGIvZHJpdmVycy9udm1lL3RhcmdldC90
cmFjZS5jDQo+IEBAIC0xMTksNiArMTE5LDM1IEBAIGNvbnN0IGNoYXIgKm52bWV0X3RyYWNlX3Bh
cnNlX2FkbWluX2NtZChzdHJ1Y3QgdHJhY2Vfc2VxICpwLA0KPiAgIAl9DQo+ICAgfQ0KPiAgIA0K
PiArc3RhdGljIGNvbnN0IGNoYXIgKm52bWV0X3RyYWNlX3pvbmVfbWdtdF9zZW5kKHN0cnVjdCB0
cmFjZV9zZXEgKnAsIHU4ICpjZHcxMCkNCj4gK3sNCj4gKwljb25zdCBjaGFyICpyZXQgPSB0cmFj
ZV9zZXFfYnVmZmVyX3B0cihwKTsNCj4gKwl1NjQgc2xiYSA9IGdldF91bmFsaWduZWRfbGU2NChj
ZHcxMCk7DQo+ICsJdTggenNhID0gY2R3MTBbMTJdOw0KPiArCXU4IGFsbCA9IGNkdzEwWzEzXTsN
Cj4gKw0KPiArCXRyYWNlX3NlcV9wcmludGYocCwgInNsYmE9JWxsdSwgenNhPSV1LCBhbGw9JXUi
LCBzbGJhLCB6c2EsIGFsbCk7DQo+ICsJdHJhY2Vfc2VxX3B1dGMocCwgMCk7DQo+ICsNCj4gKwly
ZXR1cm4gcmV0Ow0KPiArfQ0KPiArDQo+ICtzdGF0aWMgY29uc3QgY2hhciAqbnZtZXRfdHJhY2Vf
em9uZV9tZ210X3JlY3Yoc3RydWN0IHRyYWNlX3NlcSAqcCwgdTggKmNkdzEwKQ0KPiArew0KPiAr
CWNvbnN0IGNoYXIgKnJldCA9IHRyYWNlX3NlcV9idWZmZXJfcHRyKHApOw0KPiArCXU2NCBzbGJh
ID0gZ2V0X3VuYWxpZ25lZF9sZTY0KGNkdzEwKTsNCj4gKwl1MzIgbnVtZCA9IGdldF91bmFsaWdu
ZWRfbGUzMihjZHcxMCArIDgpOw0KDQpwbGVhc2UgdXNlIGNvbnNpc3RlbnQgbm90YXRpb24gOi0g
JmNkdzEwWzhdDQoNCj4gKwl1OCB6cmEgPSBjZHcxMFsxMl07DQo+ICsJdTggenJhc2YgPSBjZHcx
MFsxM107DQoNCndoeSBub3QgZGVjb2RlIHpyYXNmIHZhbHVlcyAwaC05aCB0byBtYWtlIGl0IG1v
cmUgcmVhZGFibGUgPw0KcHJpbnRpbmcgbnVtYmVyIG9ubHkgd2lsbCBtYWtlIGEgdHJpcCB0byB0
aGUgc3BlYyBzaW5jZSBJIGRvbid0IHRoaW5rDQpldmVyeW9uZSB3aWxsIHJlbWVtYmVyIHRob3Nl
IHZhbHVlcyBhbGwgdGhlIHRpbWUgLCBtb3JlIGltcG9ydGFudGx5DQp0aGlzIHdpbGwgYWxzbyBo
ZWxwIGluIHRlc3RpbmcgdG8gZ3JlcCBmb3IgcmlnaHQgc3RyaW5nIHdoZW4gdXNpbmcgenJhc2Yu
DQoNCnNhbWUgZ29lcyBmb3IgenNhIEkgZ3Vlc3MgYWJvdmUgLi4uDQo+ICsJdTggcHIgPSBjZHcx
MFsxNF07DQo+ICsNCj4gKwl0cmFjZV9zZXFfcHJpbnRmKHAsICJzbGJhPSVsbHUsIG51bWQ9JXUs
IHpyYT0ldSwgenJhc2Y9JXUsIHByPSV1IiwNCj4gKwkJCSBzbGJhLCBudW1kLCB6cmEsIHpyYXNm
LCBwcik7DQo+ICsJdHJhY2Vfc2VxX3B1dGMocCwgMCk7DQo+ICsNCj4gKwlyZXR1cm4gcmV0Ow0K
PiArfQ0KPiArDQo+ICAgY29uc3QgY2hhciAqbnZtZXRfdHJhY2VfcGFyc2VfbnZtX2NtZChzdHJ1
Y3QgdHJhY2Vfc2VxICpwLA0KPiAgIAkJdTggb3Bjb2RlLCB1OCAqY2R3MTApDQo+ICAgew0KPiBA
QCAtMTI2LDkgKzE1NSwxNCBAQCBjb25zdCBjaGFyICpudm1ldF90cmFjZV9wYXJzZV9udm1fY21k
KHN0cnVjdCB0cmFjZV9zZXEgKnAsDQo+ICAgCWNhc2UgbnZtZV9jbWRfcmVhZDoNCj4gICAJY2Fz
ZSBudm1lX2NtZF93cml0ZToNCj4gICAJY2FzZSBudm1lX2NtZF93cml0ZV96ZXJvZXM6DQo+ICsJ
Y2FzZSBudm1lX2NtZF96b25lX2FwcGVuZDoNCj4gICAJCXJldHVybiBudm1ldF90cmFjZV9yZWFk
X3dyaXRlKHAsIGNkdzEwKTsNCj4gICAJY2FzZSBudm1lX2NtZF9kc206DQo+ICAgCQlyZXR1cm4g
bnZtZXRfdHJhY2VfZHNtKHAsIGNkdzEwKTsNCj4gKwljYXNlIG52bWVfY21kX3pvbmVfbWdtdF9z
ZW5kOg0KPiArCQlyZXR1cm4gbnZtZXRfdHJhY2Vfem9uZV9tZ210X3NlbmQocCwgY2R3MTApOw0K
PiArCWNhc2UgbnZtZV9jbWRfem9uZV9tZ210X3JlY3Y6DQo+ICsJCXJldHVybiBudm1ldF90cmFj
ZV96b25lX21nbXRfcmVjdihwLCBjZHcxMCk7DQo+ICAgCWRlZmF1bHQ6DQo+ICAgCQlyZXR1cm4g
bnZtZXRfdHJhY2VfY29tbW9uKHAsIGNkdzEwKTsNCj4gICAJfQ0KDQotY2sNCg0KDQo=

