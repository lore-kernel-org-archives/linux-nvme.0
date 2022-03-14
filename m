Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3339C433F5
	for <linux-nvme@archiver.kernel.org>; Mon, 14 Mar 2022 19:30:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:References:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=CykSuc5qyJTFbsbeFwQ5fYlGod4C1KhaT3MGdFKIhNI=; b=tzUBGZZyzwKhHzditvYIdjzkHK
	GRKJhmlU3MOdmyU9/Ic3CXgVCiUOKwDOipbVAm8LthXLO7T6KYV7slRwY8z2K9qnbV/rgu39stjYa
	UauIaptZE3JT0Asg4cMGEqu+C/3PQbCJod5fnamjwb7T/3eUJ5cOLDdDd5ohUZ6d6GPMc/zodFFiv
	vxswr0izXYKJbe1x5Z6XQhKr8Ie7BlcaPqdssCVfnX5rxvvthV/hUUMX5Kt9q969asStQUhgl3NSv
	pu5u7/XrD6PYyOnXQnGcC56H/nK6QuYN499HRWfi4QIs4LR7kBPyCM1VR3nWeHXEt2n7icNXCM7qK
	qF+pq8HA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nTqOn-006bK7-NQ; Mon, 14 Mar 2022 19:30:33 +0000
Received: from esa1.hgst.iphmx.com ([68.232.141.245])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nTqOk-006bJC-8U
 for linux-nvme@lists.infradead.org; Mon, 14 Mar 2022 19:30:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1647286230; x=1678822230;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=CykSuc5qyJTFbsbeFwQ5fYlGod4C1KhaT3MGdFKIhNI=;
 b=kxbsIpBZpu5IzPLrxy5Zmwbbmz1WnYX1XttBzxxBxdB0wSmdW5ad9cvV
 wJ3pPdU89IfdwWWtGW9t3y4z3vSElTuHfaq/Y/Wd1mTBn+IPJCpXhKED1
 2NBBa40UCkbX40Twm9WSnJPNgnv+Ct+gcOhNIiMMrlpGjcAp7WGLqfdaC
 7aS9xNrAUCDDXZk5z9ieHbJWN2Y1nspGEuw7juCWetQeSR8OOJScLNZqI
 xyiDLJY5vUtHkfLopIvtPL8NArofm1J0qfLK9XO1iwaNvx0xPB+sT+454
 rUPUGBmMc4X7iquBck+1+f+rP9PL4xJFS5qVkJPsMVtHz7pBY3i6t9jYI A==;
X-IronPort-AV: E=Sophos;i="5.90,181,1643644800"; d="scan'208";a="307290837"
Received: from mail-dm6nam12lp2174.outbound.protection.outlook.com (HELO
 NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.174])
 by ob1.hgst.iphmx.com with ESMTP; 15 Mar 2022 03:30:27 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QDWSPJzCbWdEM8OUQT7I3bpC3i6uBlD6B8MNfrsPQf1BeD56EjqrVGhhGJEW5ezp+X3sSOjnTRRIGn/6MBWWYUMQTGm/xspf7GD3lwnp/dam7hmpkKmIHA+nviz3/8zrDADCmHC9D7yGw9cdEh2dqvoKYGtngn6ROTkqN83H6Z7DT0xGKrIho028bX2iimE1h4LcfpjvZYK6fCQtiuU+BtEU89OvfpKm5JA40UN3zhuPQ0YqGwrVzBRBDbS34bifydS+lWy4vI4xRE96uRyClHK5ihLuatUKyrB2c8rhCDQyT//nu9d9ZOcgc6qOzOWVqus1f3NcWlWCMH6RL4ZLSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CykSuc5qyJTFbsbeFwQ5fYlGod4C1KhaT3MGdFKIhNI=;
 b=djiG8axQd0zsarmzDhzzb/OA9gb9PAGawKph4cHdDI8+Nnop0nUkeEBvjq/N7AyOZO6s+npV7CjaFhOoVSpu6E3a8pfZ5aUm5zAS9vEwIG45a6xeyAD6P6xMSXRtes9KG56Gjn7rYbLzGA0nmYvHXiWXVFcMZvGUKGdHF3HeUPiwOmJTkYVu70LsMaP40d6qCmnlyQZITnNKNxiHR2rqQ9qqpFYFYBaOWP1925IAYvRNXSDS1LuAiQFYrcIyJ2aiV+w4pVBW6t+fjdo6mOBeY27zOI68glikEk/lql7f+d3Y6TN5lwt7ONQ0iqM+FNeLWfTtc6KwM/0U8uwNrhsK9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CykSuc5qyJTFbsbeFwQ5fYlGod4C1KhaT3MGdFKIhNI=;
 b=BZYG417HlW0hI/5fXFz9cSSD/S07x4BlOkKTOawFlnTwrC/jyEuquXd7sTg0mcUu0SF0c3rMa4S2mBV8KXFvODihSVnQyI6oPhm2F3O99IzhYdme8kVXuPyzjj+fvgcEkQxU15gpNqumf4UUtVX+o9KQZR6/OxkVoSsRdZfCPV4=
Received: from BYAPR04MB4968.namprd04.prod.outlook.com (2603:10b6:a03:42::29)
 by MWHPR04MB0737.namprd04.prod.outlook.com (2603:10b6:300:f8::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.24; Mon, 14 Mar
 2022 19:30:25 +0000
Received: from BYAPR04MB4968.namprd04.prod.outlook.com
 ([fe80::70e4:4413:4d68:a4c0]) by BYAPR04MB4968.namprd04.prod.outlook.com
 ([fe80::70e4:4413:4d68:a4c0%3]) with mapi id 15.20.5061.028; Mon, 14 Mar 2022
 19:30:25 +0000
From: =?utf-8?B?TWF0aWFzIEJqw7hybGluZw==?= <Matias.Bjorling@wdc.com>
To: Luis Chamberlain <mcgrof@kernel.org>
CC: =?utf-8?B?SmF2aWVyIEdvbnrDoWxleg==?= <javier@javigon.com>, Damien Le Moal
 <damien.lemoal@opensource.wdc.com>, Christoph Hellwig <hch@lst.de>, Keith
 Busch <kbusch@kernel.org>, Pankaj Raghav <p.raghav@samsung.com>, Adam
 Manzanares <a.manzanares@samsung.com>, "jiangbo.365@bytedance.com"
 <jiangbo.365@bytedance.com>, kanchan Joshi <joshi.k@samsung.com>, Jens Axboe
 <axboe@kernel.dk>, Sagi Grimberg <sagi@grimberg.me>, Pankaj Raghav
 <pankydev8@gmail.com>, Kanchan Joshi <joshiiitr@gmail.com>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: RE: [PATCH 0/6] power_of_2 emulation support for NVMe ZNS devices
Thread-Topic: [PATCH 0/6] power_of_2 emulation support for NVMe ZNS devices
Thread-Index: AQHYMw0pKwzLiS9sG0y93Ei4j88vWKy4YZeAgAA1PQCAAB3agIAB7+EAgAAI7YCAAAOigIAAB2QAgAAO1ACAAKBiAIADHl+AgAACrQCAADOIAIAAHFbggABBCgCAAAuaUA==
Date: Mon, 14 Mar 2022 19:30:25 +0000
Message-ID: <BYAPR04MB49681A28DEBF815225019BECF10F9@BYAPR04MB4968.namprd04.prod.outlook.com>
References: <Yiuu2h38owO9ioIW@bombadil.infradead.org>
 <20220311205135.GA413653@dhcp-10-100-145-180.wdc.com>
 <Yiu5YzxU/PjxLiUL@bombadil.infradead.org>
 <20220311213102.GA2309@dhcp-10-100-145-180.wdc.com>
 <YivMBj7+j/EZcMVV@bombadil.infradead.org>
 <bc0e53a9-f623-c69f-002e-d62e697a43d1@opensource.wdc.com>
 <20220314073537.GA4204@lst.de>
 <05a1fde2-12bd-1059-6177-2291307dbd8d@opensource.wdc.com>
 <20220314104938.hv26bf5vah4x32c2@ArmHalley.local>
 <BYAPR04MB49682B9263F21EE67070A4B1F10F9@BYAPR04MB4968.namprd04.prod.outlook.com>
 <Yi9sFmQ3pN6+drKE@bombadil.infradead.org>
In-Reply-To: <Yi9sFmQ3pN6+drKE@bombadil.infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bbede30c-b828-4abc-c6b6-08da05f116d5
x-ms-traffictypediagnostic: MWHPR04MB0737:EE_
x-microsoft-antispam-prvs: <MWHPR04MB0737996E08A800D1E3A93649F10F9@MWHPR04MB0737.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: z9rLddY6+KxhQAxn+OcFXel4HvAd30sBg5aWaQjzCEUv6H7yOfnu+MOHcdHUUpZL3zdDJuSWcbzSMPWi4JJYUNDh3F05u6buVZomtWPULnqe6Uxkw4DdCLHK0o5MCBKevVoth0lgF56i4x1p28zG7FE1l5/ageWOP0iQkZNfTb/WwvnUPuHtLErTcxfYm8pq9ih/LMI5gcqTEi6n/KelZu48z4dg+TiA0J/EG4BWYjXyaRRhYggn4Bwq/g1xYgCIRLAF1MeShiOculn29rAG51nu2XhVlu4yogiZoDvegekigsEuy2YZUQnPmmQght/mmATO0srBT/0dkyVR8DNRu1kr534SriFwxQ8w4HGVkSs+EiEejy81peHbUZ0pU3UYHY3UneoHlU0ilXptn6U+4IDMGz26AWIl8WlSyBdhzKov+58kAYAu2WygR17VTpztvlp85HB7JOr8FEEs+DgXBSRCOdycOY3IppHQYBRYkgUYhFC5Q0w2KOGmvtpIFWQf79yg3Z6J+hjh/OX2sd68imHyKQc0yI7An63sEYFlVKP6DMcda5DU7tG3ox9mqfdG0x3ZdHY0PedseGelLan8kg9tzcjBTFpHWIxFC418SQPha9Xmu0diEDfyJzODzT8O4Rn5uFZs5fGE2DFirH0kCVwLEYOJBTu9zx0TRFy7hL+DlpioCoJkt87kxfZcmHhj1cAvzQTStb3DicsYityxfQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4968.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(26005)(186003)(122000001)(71200400001)(82960400001)(38070700005)(66574015)(86362001)(6506007)(7696005)(2906002)(9686003)(38100700002)(508600001)(85182001)(7416002)(66556008)(4326008)(8676002)(66476007)(76116006)(66946007)(66446008)(64756008)(5660300002)(8936002)(52536014)(85202003)(55016003)(33656002)(6916009)(54906003)(83380400001)(316002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YW80SkRvalVTc2JOaWpGdDhZVURlQytMZjhtb05lZ0Ird2loNEFiZnF3c3o1?=
 =?utf-8?B?bXIxaVpHeTFoRnEyR0FiZGtNMVhYRUNKRHdCeTFqQ0V4NWZUTS96Sm95NHZs?=
 =?utf-8?B?eFNTNVVIRVVwaWVDRC9lL0VNekhSdXFFRWkrdm0rc0xIRjlkdGtqc3RYL1pQ?=
 =?utf-8?B?MVZRR1dkWC92SndyZlBHVkRNMXgva2d6bmtNOXhEQjZsSURPVWNjUHdPVi85?=
 =?utf-8?B?akNmdEd4WmxMTHY5NjQwK1JRd1ZzUFArZVpTN1JLSnNDSW95RllHZG4yTWhO?=
 =?utf-8?B?bTlDcFJ6WXlkU2VZODBWTWl0SU1Wb2tEQkRzV3pZZHY5TlpnTG1qSXZoOFRL?=
 =?utf-8?B?VFU2WWVVc1hTdnA5bkRDSkt4b3pkLzNwRU9lSzR2TVhvOFlUU25weU9TUEtp?=
 =?utf-8?B?Z0IyNmJDYXFvbGdJYU1idWpuQlZPNnJQL1JXYlprY0FJemJvMmp2bEJscXI4?=
 =?utf-8?B?K2QraVVRVSswNE5NSWtDK1Z2Q29RT2xFei9HbTEyRDdrMnI5ZG4wdHpVajhq?=
 =?utf-8?B?Vy9mSzltM3lIQXBOeThPTVd2Z0JNVWdaMzl0SXYzRytHSnZHLzRISU5GTjg4?=
 =?utf-8?B?Q2ZhY2RSY0FVc0lwYXc0NTFwT2lzYittaHE1eFhWRk4wWkZvNEtkOExTVUx0?=
 =?utf-8?B?UEhlMTBWRWp0UHp6YVVsaXNoNmtnMHFsdjFGSDhycjZ5SmpITStpVmg0b0tp?=
 =?utf-8?B?aUdXc3RsL2RkekMrV3RwRnFuM0NsdUMySUc3NmZkSklQS2RGNm9waHU0anZE?=
 =?utf-8?B?ZEpaaDY2L0hQOEFmQmdYSzJKMnd6SmxKTGpYZXBZamVkaEozWHFra3ZVdlIw?=
 =?utf-8?B?dXlpc3V3MmZxL3Q1TkVhQm1kSDlpU25lbW9HL25jQ1pLZmluc0JRNDJ5K2I2?=
 =?utf-8?B?RGVWWWFYZndFR0gwNVBYWWxtTUZrYUNTbnkrRE5HWHlXQUVVWVNEL2hHYi96?=
 =?utf-8?B?ZldYVFZXcDZ4UkJEeVpTcXEvZHVkYTQ5MnJwblYwQzNYN3BJNUR3MUJ0SXhG?=
 =?utf-8?B?dGhFOS95OTdLQkhkSDA5dTJqTno0V2xYTHJURWFDNzFyOG1lYWZ1VGlNSUZB?=
 =?utf-8?B?RWxPdHlaWndDMGpDU3FZQjdLZlVCV296Tm1uT1Zrb3FOemNsMGErUkhOL0NE?=
 =?utf-8?B?VmhRU0JFRTBaekoyU1Q2Y0R0eUNIMDFLNTE4ZkNZNlVFVDJ1SUU1YUtkcEg3?=
 =?utf-8?B?LzdsWEVVSWRrOEdvM3YrelBXa1NTSEkxN21Ea0EzMTE5VldsWSthTmRETzNE?=
 =?utf-8?B?WEZjR2pjYTk5aUhnVEpMR2x3a1JZWXJ4SzVUR08wNnZWTjVLL3FOOGtrRndB?=
 =?utf-8?B?eVdyUmNrVzJkNFh2TXhGdnl3ZlBscUJRWFpjWHE5TXhYVnVPQmlybDVKQU9k?=
 =?utf-8?B?L1VQOGZ4aEtack4zR0dFdktsRm1ETW1BQU1mdmg1OThML3RBL0hsUE4zclJy?=
 =?utf-8?B?dlZzUlJXeGlUcTJ5UThaVmplUjd1NENCRnd3d3pTZ2Jac2t1R2FNcUJBV1Vh?=
 =?utf-8?B?czNmMWFXbE5DZkt6TEI1VUVaRUVSZXJxT1ZMd3dmQ2hybUJpcUFUUHRmamJ1?=
 =?utf-8?B?NkVzNCs1b3pNWnVtWHJ6WFF3anJCRFRid0hZTy9OOVpTOHBUQkgrZWJKVVdL?=
 =?utf-8?B?ZHBDN2FWOStvYnZ4K3hxTzQwWTBTaEo5cHo3cmgwOVQ3T3BYUGF1bFBVMmd3?=
 =?utf-8?B?a0ZHMU0vQmJydlBRemhTaUxpc3dia3dzMEc5d2N4VWNCcHFpamFQZ3lZQjFv?=
 =?utf-8?B?QXJuUTRaZTBRYlVzcTMxVS9ML0FIbmdXSGI3dVVDV3FKVnN3UjB0NjI1TUs2?=
 =?utf-8?B?ZmF6RHBsZUF0T3dwZWZIY0JWSitjdEhnOElWVEdvR3pjMjFHaGJTVXhWNlYx?=
 =?utf-8?B?Wkl2Y3hZK2V4NU9Pd3RabDExQjlWQWk5bnl1QTBVNTFUeFFSVDdSNG9Sc3lJ?=
 =?utf-8?Q?w4fQ3JBQdrdyY5ZMoCTSpXb5c+8A0MEe?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4968.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bbede30c-b828-4abc-c6b6-08da05f116d5
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Mar 2022 19:30:25.3150 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Xb8ZNjChnARE1x5o/7nIAg+d0b+8MYGesNsXFpZl6/xBMZJbx9/VYAhqlS02d0BvEAsjfQIpSBGzwAQcK0MgcQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR04MB0737
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220314_123030_350307_0F900EA8 
X-CRM114-Status: GOOD (  31.88  )
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

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBMdWlzIENoYW1iZXJsYWluIDxt
Y2dyb2ZAaW5mcmFkZWFkLm9yZz4gT24gQmVoYWxmIE9mIEx1aXMNCj4gQ2hhbWJlcmxhaW4NCj4g
U2VudDogTW9uZGF5LCAxNCBNYXJjaCAyMDIyIDE3LjI0DQo+IFRvOiBNYXRpYXMgQmrDuHJsaW5n
IDxNYXRpYXMuQmpvcmxpbmdAd2RjLmNvbT4NCj4gQ2M6IEphdmllciBHb256w6FsZXogPGphdmll
ckBqYXZpZ29uLmNvbT47IERhbWllbiBMZSBNb2FsDQo+IDxkYW1pZW4ubGVtb2FsQG9wZW5zb3Vy
Y2Uud2RjLmNvbT47IENocmlzdG9waCBIZWxsd2lnIDxoY2hAbHN0LmRlPjsNCj4gS2VpdGggQnVz
Y2ggPGtidXNjaEBrZXJuZWwub3JnPjsgUGFua2FqIFJhZ2hhdiA8cC5yYWdoYXZAc2Ftc3VuZy5j
b20+Ow0KPiBBZGFtIE1hbnphbmFyZXMgPGEubWFuemFuYXJlc0BzYW1zdW5nLmNvbT47DQo+IGpp
YW5nYm8uMzY1QGJ5dGVkYW5jZS5jb207IGthbmNoYW4gSm9zaGkgPGpvc2hpLmtAc2Ftc3VuZy5j
b20+OyBKZW5zDQo+IEF4Ym9lIDxheGJvZUBrZXJuZWwuZGs+OyBTYWdpIEdyaW1iZXJnIDxzYWdp
QGdyaW1iZXJnLm1lPjsgUGFua2FqDQo+IFJhZ2hhdiA8cGFua3lkZXY4QGdtYWlsLmNvbT47IEth
bmNoYW4gSm9zaGkgPGpvc2hpaWl0ckBnbWFpbC5jb20+OyBsaW51eC0NCj4gYmxvY2tAdmdlci5r
ZXJuZWwub3JnOyBsaW51eC1udm1lQGxpc3RzLmluZnJhZGVhZC5vcmcNCj4gU3ViamVjdDogUmU6
IFtQQVRDSCAwLzZdIHBvd2VyX29mXzIgZW11bGF0aW9uIHN1cHBvcnQgZm9yIE5WTWUgWk5TIGRl
dmljZXMNCj4gDQo+IE9uIE1vbiwgTWFyIDE0LCAyMDIyIGF0IDAyOjE2OjM2UE0gKzAwMDAsIE1h
dGlhcyBCasO4cmxpbmcgd3JvdGU6DQo+ID4gSSB3YW50IHRvIHR1cm4gdGhlIGFyZ3VtZW50IGFy
b3VuZCB0byBzZWUgaXQgZnJvbSB0aGUga2VybmVsDQo+ID4gZGV2ZWxvcGVyJ3MgcG9pbnQgb2Yg
dmlldy4gVGhleSBoYXZlIGNvbW11bmljYXRlZCB0aGUgUE8yIHJlcXVpcmVtZW50DQo+ID4gY2xl
YXJseSwNCj4gDQo+IFN1Y2ggcmVxdWlyZW1lbnQgaXMgYmFzZWQgb24gaGlzdG9yeSBhbmQgZWZm
b3J0IHB1dCBpbiBwbGFjZSB0byBhc3N1bWUgYSBQTzINCj4gcmVxdWlyZW1lbnQgZm9yIHpvbmUg
c3RvcmFnZSwgYW5kIGNsZWFybHkgaXQgaXMgbm90LiBBbmQgY2xlYXJseSBldmVuIHZlbmRvcnMN
Cj4gd2hvIGhhdmUgZW1icmFjZWQgUE8yIGRvbid0IGtub3cgZm9yIHN1cmUgdGhleSdsbCBhbHdh
eXMgYmUgYWJsZSB0byBzdGljayB0bw0KPiBQTzIuLi4NCg0KU3VyZSAtIEl0J2xsIGJlIG5hw692
ZSB0byBnaXZlIGEgY2FydGUgYmxhbmNoZSBwcm9taXNlLg0KDQpIb3dldmVyLCB5b3UncmUgc2tp
cHBpbmcgdGhlIG5leHQgdHdvIGVsZW1lbnRzLCB3aGljaCBzdGF0ZSB0aGF0IHRoZXJlIGFyZSBi
b3RoIGdvb2QgcHJlY2VkZW5jZSB3b3JraW5nIHdpdGggUE8yIHpvbmUgc2l6ZXMgYW5kIHRoYXQg
aG9sZXMvdW5tYXBwZWQgTEJBcyBjYW4ndCBiZSBhdm9pZGVkLiBNYWtpbmcgYW4gYXJndW1lbnQg
Zm9yIHdoeSBOUE8yIHpvbmUgc2l6ZXMgbWF5IG5vdCBicmluZyB3aGF0IG9uZSBpcyBsb29raW5n
IGZvci4gSXQncyBhIGxvdCBvZiB3b3JrIGZvciBsaXR0bGUgcHJhY3RpY2FsIGNoYW5nZSwgaWYg
YW55LiANCg0KPiANCj4gPiB0aGVyZSdzIGdvb2QgcHJlY2VkZW5jZSB3b3JraW5nIHdpdGggUE8y
IHpvbmUgc2l6ZXMsIGFuZCBhdCBsYXN0LA0KPiA+IGhvbGVzIGNhbid0IGJlIGF2b2lkZWQgYW5k
IGFyZSBwYXJ0IG9mIHRoZSBvdmVyYWxsIGRlc2lnbiBvZiB6b25lZA0KPiA+IHN0b3JhZ2UgZGV2
aWNlcy4gU28gd2h5IHNob3VsZCB0aGUga2VybmVsIGRldmVsb3BlcidzIHRha2Ugb24gdGhlDQo+
ID4gbG9uZy10ZXJtIG1haW50ZW5hbmNlIGJ1cmRlbiBvZiBOUE8yIHpvbmUgc2l6ZXM/DQo+IA0K
PiBJIHRoaW5rIHRoZSBiZXR0ZXIgcXVlc3Rpb24gdG8gYWRkcmVzcyBoZXJlIGlzOg0KPiANCj4g
RG8gd2UgKm5vdCogd2FudCB0byBzdXBwb3J0IE5QTzIgem9uZSBzaXplcyBpbiBMaW51eCBvdXQg
b2YgcHJpbmNpcGFsPw0KPiANCj4gSWYgd2UgKmFyZSogb3BlbiB0byBzdXBwb3J0IE5QTzIgem9u
ZSBzaXplcywgd2hhdCBwYXRoIHNob3VsZCB3ZSB0YWtlIHRvDQo+IGluY3VyIHRoZSBsZWFzdCBw
YWluIGFuZCBmcmFnbWVudGF0aW9uPw0KPiANCj4gRW11bGF0aW9uIHdhcyBhIHBhdGggYmVpbmcg
Y29uc2lkZXJlZCwgYW5kIEkgdGhpbmsgYXQgdGhpcyBwb2ludCB0aGUgYW5zd2VyIHRvDQo+IGV2
ZWx1YXRpbmcgdGhhdCBwYXRoIGlzOiB0aGlzIGlzIGN1bWJlcnNvbWUsIHByb2JhYmx5IG5vdC4N
Cj4gDQo+IFRoZSBuZXh0IHF1ZXN0aW9uIHRoZW4gaXM6IGFyZSB3ZSBvcGVuIHRvIGV2YWx1YXRl
IHdoYXQgaXQgbG9va3MgbGlrZSB0byBzbG93bHkNCj4gc2hhdmUgb2ZmIHRoZSBQTzIgcmVxdWly
ZW1lbnQgaW4gZGlmZmVyZW50IGxheWVycywgd2l0aCBhbiBnb2FsIHRvIGF2b2lkIGZ1cnRoZXIN
Cj4gZnJhZ21lbnRhdGlvbj8gVGhlcmUgaXMgZWZmb3J0IG9uIGV2YWx1YXRpbmcgdGhhdCBwYXRo
IGFuZCBpdCBkb2Vzbid0IHNlZW0gdG8NCj4gYmUgdGhhdCBiYWQuDQo+IA0KPiBTbyBJJ2QgYWR2
aXNlIHRvIGV2YWx1YXRlIHRoYXQsIHRoZXJlIGlzIG5vdGhpbmcgdG8gbG9vc2Ugb3RoZXIgdGhh
biBhd2FyZW5lc3Mgb2YNCj4gd2hhdCB0aGF0IHBhdGggbWlnaHQgbG9vayBsaWtlLg0KPiANCj4g
VW5lc3Mgb2YgY291cnNlIHdlIGFscmVhZHkgaGF2ZSBhIGNsZWFyIHBhdGggZm9yd2FyZCBmb3Ig
TlBPMiB3ZSBjYW4gYWxsDQo+IGFncmVlIG9uLg0KDQpJdCBsb29rcyBsaWtlIHRoZXJlIGlzbid0
IGN1cnJlbnRseSBvbmUgdGhhdCBjYW4gYmUgYWdyZWVkIHVwb24uDQoNCklmIGV2YWx1YXRpbmcg
ZGlmZmVyZW50IGFwcHJvYWNoZXMsIGl0IHdvdWxkIGJlIGhlbHBmdWwgdG8gdGhlIHJldmlld2Vy
cyBpZiBpbnRlcmZhY2VzIGFuZCBhbGwgb2YgaXRzIGtlcm5lbCB1c2VycyBhcmUgY29udmVydGVk
IGluIGEgc2luZ2xlIHBhdGNoc2V0LiBUaGlzIHdvdWxkIGFsc28gaGVscCB0byBhdm9pZCB1c2Vy
cyBnZXR0aW5nIGhpdCBieSB3aGF0IGlzIHN1cHBvcnRlZCwgYW5kIHdoYXQgaXNuJ3Qgc3VwcG9y
dGVkIGJ5IGEgcGFydGljdWxhciBkZXZpY2UgaW1wbGVtZW50YXRpb24gYW5kIGFsbG93IGJldHRl
ciB0byByZXZpZXcgdGhlIGZ1bGwgc2V0IG9mIGNoYW5nZXMgcmVxdWlyZWQgdG8gYWRkIHRoZSBz
dXBwb3J0Lg0KDQo=

