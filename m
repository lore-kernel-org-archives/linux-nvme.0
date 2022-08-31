Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B5F1ECAAD1
	for <linux-nvme@archiver.kernel.org>; Wed, 31 Aug 2022 19:13:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=24tbC8FDH0GSGZRbxMAsAvDQ7qVrQl3rdU+fiiccpF8=; b=KGTk/Bwlk3vFk+MaLf82+NbpDh
	LpasgYzeOI/CMEW9tsrXrXQoqCq7h/UIrATxu2ss4rVCvxPQ2epaIuzezkRGh1Mdvp2YdOxiQh02O
	2OA55xNgePTsvvZO/qHnsUNdTFFn7XL0Dp/AhLlSFiXbbHMHtj5ozeOls7dnpnD+lOSNPTWl66vnR
	bgdOVBKZIi9nKojhO06mWkLpU2a+i2hIrgtrn6+WcA0BXDrXCDuiAUt5ELAXFXS7T/D8ZJPoZsjKQ
	lxMaj0o87JabGuHvDp3xR4p9rSDGoIIWUgtySxwE3JmSNXaGerTU9GS2U8iuSVHhgxr0oNvOCyeRi
	ouaGRSEQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oTT9O-007nNm-Ai; Wed, 31 Aug 2022 19:13:22 +0000
Received: from mail-dm6nam04on2052.outbound.protection.outlook.com ([40.107.102.52] helo=NAM04-DM6-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oTT9L-007nMk-JC
	for linux-nvme@lists.infradead.org; Wed, 31 Aug 2022 19:13:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NHn5kMczLUGL89Bs8a8XHhq0vxgGlZq5A+aq2E4TY0yYQugm3L8ysheXJrkf+4pDD8/9wSuiX5S9XsWV+KmncWtqwsHsgAUNjhxPUJJ0USv2IN3umQmfChKTWKoAgA98cNEbRyuYEvaNrSiHIQFx1fOAbrMd6shPFAbU/RW4f+GEBYkX2bEqYVpDFYaeWlh8RPRk9IcgG2EL65qnQYyquE7+h+gZUSGzuS51RyR47O6kpnHhRbV1uRHh20sstF7U+0JI7uW/XygqV9lzSYxtdmzjO9JrnmOwcVVBQELKMZoNu+5TMZVs4UcC9i/mabhlD73J8nK7kr/DF+GCr7jaAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=24tbC8FDH0GSGZRbxMAsAvDQ7qVrQl3rdU+fiiccpF8=;
 b=ZbaHBmxSevDxKUbF40EsnypZK1nLPvZrHXW9QvX5pvUHNsCAFuzKnEljrZUfDvVY0G4x8BHvJLxBOU/qyUhv/HAs/ha+Dqv9cywQBoX4wMmqTnWM8Im5BE5CY05K88ANub0XoZcuWry9LuI4OL3hY5H4S1n/8VfWOgdfUgGFONDFr7PY2avt8I2abVLpGu70Ouvr6zxCswy0EP3zZlPW5k3OvVBM/S7/IDdiNeLS4fnZFoyIOOhfrO5xGPqEBzkB87BAad4siFCXJeV0ieuj/Cs/X5J9YS1D9nXf3zkG4KFeub/Ozj19anhdfaDYcNIa/3zdYMId74fHgexLEjCxIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=24tbC8FDH0GSGZRbxMAsAvDQ7qVrQl3rdU+fiiccpF8=;
 b=S4atq9WIzUqLNJqI0TBg5HXQ8vn9pJWsB7Rie7BXksIG2QwHpxJYTYNy/80vCb/rEEC7f2zQR5kUbTaGMEahRy95P5plkrh198kyK2A+2Yrwqylj8RezVZe7gU92f+Y75poi62lkqgLIbUDcckfu0HlDl1G4jMv0M/JE/c3lrwheBs/Fme3cAPejzJ/D3EIInhLcia7D4CA5q8q0o0NAB9p1URm/hS/s0SlEcfAMcdaQz7tfuAcu/9YJBs6Sn75oMyT27JJ/ppZ70tL616i3koGIRfMh2Y1M/2nRt3iQ+2CWaqbZvOH/Ya8BWEDkcnSyRkVPEybg8+NF6eXqgcD3nw==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by MN2PR12MB4222.namprd12.prod.outlook.com (2603:10b6:208:19a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Wed, 31 Aug
 2022 19:13:15 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::c04:1bde:6484:efd2]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::c04:1bde:6484:efd2%4]) with mapi id 15.20.5588.010; Wed, 31 Aug 2022
 19:13:15 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Martin Belanger <nitram_67@hotmail.com>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>
CC: "kbusch@kernel.org" <kbusch@kernel.org>, "hare@suse.de" <hare@suse.de>,
	"axboe@fb.com" <axboe@fb.com>, "hch@lst.de" <hch@lst.de>, "sagi@grimberg.me"
	<sagi@grimberg.me>, Martin Belanger <martin.belanger@dell.com>
Subject: Re: [PATCH] nvme-tcp: Print actual source IP address in address
 attribute
Thread-Topic: [PATCH] nvme-tcp: Print actual source IP address in address
 attribute
Thread-Index: AQHYvWq53gYP6tR9BkaNP+6b8nc8Qa3JYJoA
Date: Wed, 31 Aug 2022 19:13:15 +0000
Message-ID: <e75c7e55-ca67-6c77-a31a-82040386b0c4@nvidia.com>
References:  <BL0PR13MB4291FE38A1741F311081106B9C789@BL0PR13MB4291.namprd13.prod.outlook.com>
In-Reply-To:  <BL0PR13MB4291FE38A1741F311081106B9C789@BL0PR13MB4291.namprd13.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 76c1f6c1-c5b3-4415-971f-08da8b84dafe
x-ms-traffictypediagnostic: MN2PR12MB4222:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  5oGOEnfGlx5YchNI+w9Io2EU5k8/oHD1Wq0dhy5ZI0af79Np/kkgZ2tTHQSU0Tv5Sfh0B8Z83x/3CBzuVqWI0OIbMK4rTPFecoc0MON2h2iDTCPMkvEC03wbPBWrUg+VD+LDYfWsZUP1++K49vcp7lfV62kJChRSTXoXuLj95KiZmWowtm8DE5SepMv7z6KKdojs0oyknVMBsHIZh/QtC0r6yesNaz8fuSlrzcibhDNPOgqw0aJuitoDw+XXlXfyQBCl81ptGbfx0VjoqrvGDWnBOdPTCPjs7vM1yggiH0S6C5uShRcgs7EctBiaT6VDGEUZvC+bsjgrJmLkmZSA4wWnl6moRB1bE/jkeB5nJzLvP0++hnsVv9Ifjqt4yPop13aiqWhVBEpZg8+MQAE3eHZFR+Kwr193V3VnMD9+DpcV2V8zUcMxuQ+kQ+qSuaQDtFAFv16XW4j/7i42/nJrG22SpA9wjGgcgJHs80WdBX8ybRyiZCjAJDfGnQ285yTSjlvmQGUen2dU0KQa9Q+gVRD3OzPrSIMY2hB6lLmK8ktyRlG94utaHcBQHPRhjSBjpedILjRy3LOGZ6YZC3rxDnMlBVxfIUT36bnTJuCWJhWgH8KQP5Cv6s1it898oJjbekYK9c5fxP4rX+Xs0JiP40Uw0UZWjzLCsWJluPpS6FLHo1fGpCVo8FV7yRxlx5dGQBJqXTA7PPW67LHwefkGsayh4B+wssoXSyVlUsJAtLAnQWsuSjU8BLYNPYz3t+g1TIStwEf71Ek9ZIa6vJSO/ENhvn2VchPtsoEEJls6iaAfbn56H5UY8IYBktBqUYsE9T/LXqjYO29O9h/lTtkvdg==
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(396003)(39860400002)(376002)(346002)(366004)(31686004)(76116006)(64756008)(66446008)(2906002)(91956017)(66946007)(4326008)(6506007)(66556008)(8676002)(66476007)(6512007)(8936002)(316002)(41300700001)(71200400001)(54906003)(6486002)(478600001)(110136005)(53546011)(36756003)(86362001)(186003)(2616005)(122000001)(83380400001)(38070700005)(5660300002)(31696002)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:  =?utf-8?B?dFVCYWdYZUFWYXhNclN4bXpGbk9lSDlVNGhVNUlTYmpkVU5ZeUZ2TWN2cDlu?=
 =?utf-8?B?UVZtbk4ydUtTbVpFRzNaVEFtRW9ZUHI5NURjRVVkbkQ5Z0JHck43WXR3d2Iv?=
 =?utf-8?B?dHdrZUhnVGFQSDErdUoyZ0ZkYmZyZE5sdjJxckU2WFJIbFRtb2NQTE5xS2Fk?=
 =?utf-8?B?bUhMSlpWc2V1UEdDWGEyd3FnaUJ5cllobjgxSVdrSllWdTd4dnhnVy9tWGxn?=
 =?utf-8?B?QW4vQm1WSGpKYm9IZ3hGSDBRcGZCVFVydkZ2c3BSUjMrZ0t5cmVkcUhnNVho?=
 =?utf-8?B?SjBva0Y5Q2FpbzdSSmt5VjByRkdqaHRaZnZteGxtRUNKT3ozL3pLdlpOQi9m?=
 =?utf-8?B?akZuNXN0M1g0S1orZTJQd0dPd3l0dnVVYnhMYjI1c0NvREk2Y2QxRFVUZ3pD?=
 =?utf-8?B?NjJ0ZTlMRlZPT3J5U3pJRmdTdDZHSEJGSDFUWGN2ZGdPSzN5Rno4YWNvNUd1?=
 =?utf-8?B?YjYyVmUzRHNWR2Z6Zjk0UEtaTDR5YTRDbVBRczVCWHBRSStURFQ4cEpsTEps?=
 =?utf-8?B?TUM4dGttblJDb1A3eWFrNU50SGYyKy9rdDBzT2xFTG9jR2FsY1VOaFYreDFj?=
 =?utf-8?B?TDgzMWFMZzc0VjJpSmNuN20yUEhlSnltTVp5QW1XV25PdmZsekJ1U0Vud3B0?=
 =?utf-8?B?Q0hyeXI2Y0Q0MHl6dXc4aHF6SE9HZGVSY3kyVWlJMEZpYUpaUUNpTmo1d2dm?=
 =?utf-8?B?Y2xQLzNXT1czQmE4d2FUVVBWa2pLRWFWVmpEa056N3V6UlljRzJBaW84aVFm?=
 =?utf-8?B?S3Q1ZzZHL1ZYUG91Y0NqYWpOYm5GV1M2MkRrYUlNblAyS0ZVSjh1R0E0cGFp?=
 =?utf-8?B?WGZzL0dsV0Q1REtTVWFaSnBVRitxcWltTzg1WFRDUWhkUHhDbEpmd1B4WkJr?=
 =?utf-8?B?Q2I2ZTJzdnRseUs2ZDl4NzhtS3FlcGhzM2hXZGdwTFFRbGxjMG1LWCtncVZs?=
 =?utf-8?B?eDhsVFZFNHJ1OXlYcE96UGxzL3ZFMUVvaERaZUtuRTlUditHaWZ5UDdwSFBH?=
 =?utf-8?B?NERmNXdWR1Z2bWNEYTRKUmRpL2t2Qmswb3hQaVpFQ1Bsay83VDNCZnZFVEtt?=
 =?utf-8?B?VWpIMjRQVmo5RThZK0s3dXRxRjlJYms0UGFWV0xRMFNlbEw2dHFhS05vUmhI?=
 =?utf-8?B?QnFmMEUrVDU0bVlabXpqbUtONWZ1UGJieHBNS2xObm80azRxMVFTVkhCMFdv?=
 =?utf-8?B?YVc0UTdDWXlsWWpRMGJGdjdqc2lvYUxkUkRlYmlibUkxZHllOTRJWVZBZ1Nx?=
 =?utf-8?B?V2NUYVhjbEVBcEtvWUR4WHliS2Q1Rm9zTkk0RVV3bENjbDU0VHVTSUh0WEVF?=
 =?utf-8?B?YTRUbmFyNm5vZmFSYmp3SWdML3Q2NTgwYi92ckpoWDVoRGpBQ1pxYUZhSGVV?=
 =?utf-8?B?MnQ5QUFqaUVxV3kvLyt5aWlvZExEaEZJVHZRQmhwSERtQWJXZWlSZ1hqZmhP?=
 =?utf-8?B?U2pBYlBMUTNvSDVNWXpGRkVYR2lVOTV5MVpkbWRlWDdRdHErUHZpZmhRaE9Y?=
 =?utf-8?B?MERtOG1Dek9NMnBKSUtQZkFvaEg1RExVSStEMXJLa2xqbHE2NkNQblZRVEpQ?=
 =?utf-8?B?Q3ExRFJ2Qm43SzVBQVJ3OXVIQWZuU2dnQzJZOG1xNC9aVjJ6T3RVZGgvUkFH?=
 =?utf-8?B?ekxqNWdBelNyeEJoajM4ZHhNYyt4aXZsdlNhOVY0WkFuMmh5aktGUGE2ekdC?=
 =?utf-8?B?SHJIYW1kbTI5N1g2dmNnSTUrVzVPaFhIVSs4UjdTRU9FRFZUVEdZNm0vbW9j?=
 =?utf-8?B?S1JzN1VrM0JFUStsTUh3U1JsWm5CM2JneHdPVitvU2gvbVNRZ2UvTTFWcndO?=
 =?utf-8?B?bTc2TVc3SDZTbFBETHE4WDRZSk9UWVl0SzhyL2dodmoyL3RBVmN0Qm40eUtj?=
 =?utf-8?B?aHc1UmU5MDc2N0RlMFg1bEJ5ZmNHcFh0dS9CREdVWkQ5K1hFUDJHb0tyc1d4?=
 =?utf-8?B?TWFTMGp3NzVJNnBBQWdWOG56TXJ5R1haS0NzVDRTQWEyOHREY0xOUXZxMVdu?=
 =?utf-8?B?MjZONDhNZ1Q3dG9CWDRiN1hTd05qbUZ0MWpPZmZXTXZnZzV1U003Z084NVU2?=
 =?utf-8?B?bnhZZ05nWWI2dWsrcHlaZDRwNTVyMTYxdzVJRzZLMWI2ZkZUQXJPN2FlamFJ?=
 =?utf-8?B?dEpPdm5yMmd6QmU3cE5aR1Z0RUNaR3I3UVpOR0lmNHdicnpMSlNuMUZ0Zi9Z?=
 =?utf-8?B?SVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3C35899ABC1AED458022D6E964ABF42A@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76c1f6c1-c5b3-4415-971f-08da8b84dafe
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Aug 2022 19:13:15.2095
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lyWuSTxvmscIMWFU1x+f94Q7bNJYwKxwQETUvSemWBLNVzvOIikOd+IWDoBqTohYGhiexMVD2Rl2rGI8U4PHtw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4222
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220831_121319_872491_39D1CD90 
X-CRM114-Status: GOOD (  33.98  )
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

T24gOC8zMS8yMiAxMTo1MCwgTWFydGluIEJlbGFuZ2VyIHdyb3RlOg0KPiBGcm9tOiBNYXJ0aW4g
QmVsYW5nZXIgPG1hcnRpbi5iZWxhbmdlckBkZWxsLmNvbT4NCj4gDQo+IFRDUCB0cmFuc3BvcnQg
cmVsaWVzIG9uIHRoZSByb3V0aW5nIHRhYmxlIHRvIGRldGVybWluZSB3aGljaA0KPiBzb3VyY2Ug
YWRkcmVzcyBhbmQgaW50ZXJmYWNlIHRvIHVzZSB3aGVuIG1ha2luZyBhIGNvbm5lY3Rpb24uDQo+
IEN1cnJlbnRseSwgdGhlcmUgaXMgbm8gd2F5IHRvIHRlbGwgZnJvbSB1c2Vyc3BhY2Ugd2hlcmUg
YQ0KPiBjb25uZWN0aW9uIHdhcyBtYWRlLiBUaGlzIHBhdGNoIGFsbG93cyBleHBvc2luZyB0aGUg
YWN0dWFsIHNvdXJjZQ0KPiBhZGRyZXNzIHVzaW5nIHRoZSBob3N0X3RyYWRkciBmaWVsZCBvZiB0
aGUgYWRkcmVzcyBhdHRyaWJ1dGUuDQo+IA0KPiBXaHkgaXMgdGhpcyBpbXBvcnRhbnQ/IFRoaXMg
d2lsbCBtYWtlIGl0IHBvc3NpYmxlIHRvIGRpYWdub3NlIGFuZA0KPiBpZGVudGlmeSBjb25uZWN0
aXZpdHkgaXNzdWVzLiBXaXRoIHRoaXMsIHdlJ2xsIGJlIGFibGUgdG8gdGVsbA0KPiB3aGljaCBp
bnRlcmZhY2UgYW5kIHNvdXJjZSBhZGRyZXNzIGlzIGFzc29jaWF0ZWQgd2l0aCBlYWNoDQo+IGNv
bm5lY3Rpb24uDQo+IA0KDQpQZXJoYXBzIHJlbW92ZSBxdWVzdGlvbiBpbiB0aGUgY29tbWl0IGxv
ZyBhbmQgcmVwaHJhc2UgaXQgOi0NCg0KVGhpcyBpcyBuZWVkZWQgdG8gZGlhZ25vc2UgYW5kIGlk
ZW50aWZ5IGNvbm5lY3Rpdml0eSBpc3N1ZXMgc2luY2UNCml0IGFsbG93cyB1cyB0byB0ZWxsIHdo
aWNoIGludGVyZmFjZSBhbmQgc291cmNlIGFkZHJlc3MgaXMgYXNzb2NpYXRlZA0Kd2l0aCBlYWNo
IGNvbm5lY3Rpb24uDQoNCj4gU2lnbmVkLW9mZi1ieTogTWFydGluIEJlbGFuZ2VyIDxtYXJ0aW4u
YmVsYW5nZXJAZGVsbC5jb20+DQo+IC0tLQ0KPiAgIGRyaXZlcnMvbnZtZS9ob3N0L3RjcC5jIHwg
MzQgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrLQ0KPiAgIDEgZmlsZSBjaGFuZ2Vk
LCAzMyBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJp
dmVycy9udm1lL2hvc3QvdGNwLmMgYi9kcml2ZXJzL252bWUvaG9zdC90Y3AuYw0KPiBpbmRleCAw
NDRkYTE4YzA2ZjUuLmFkYmI3NjQ4M2E3NCAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9udm1lL2hv
c3QvdGNwLmMNCj4gKysrIGIvZHJpdmVycy9udm1lL2hvc3QvdGNwLmMNCj4gQEAgLTE2NSw2ICsx
NjUsNyBAQCBzdHJ1Y3QgbnZtZV90Y3BfY3RybCB7DQo+ICAgCXN0cnVjdCBibGtfbXFfdGFnX3Nl
dAlhZG1pbl90YWdfc2V0Ow0KPiAgIAlzdHJ1Y3Qgc29ja2FkZHJfc3RvcmFnZSBhZGRyOw0KPiAg
IAlzdHJ1Y3Qgc29ja2FkZHJfc3RvcmFnZSBzcmNfYWRkcjsNCj4gKwlzdHJ1Y3Qgc29ja2FkZHJf
c3RvcmFnZSBzb2NrX2FkZHI7DQo+ICAgCXN0cnVjdCBudm1lX2N0cmwJY3RybDsNCj4gICANCj4g
ICAJc3RydWN0IHdvcmtfc3RydWN0CWVycl93b3JrOw0KPiBAQCAtMTU5Nyw2ICsxNTk4LDEyIEBA
IHN0YXRpYyBpbnQgbnZtZV90Y3BfYWxsb2NfcXVldWUoc3RydWN0IG52bWVfY3RybCAqbmN0cmws
DQo+ICAgCQlnb3RvIGVycl9yY3ZfcGR1Ow0KPiAgIAl9DQo+ICAgDQo+ICsJLyogUmV0cmlldmUg
dGhlIGFjdHVhbCBzb3VyY2UgYWRkcmVzcyBmcm9tIHRoZSBzb2NrZXQgKi8NCj4gKwlyZXQgPSBr
ZXJuZWxfZ2V0c29ja25hbWUocXVldWUtPnNvY2ssDQo+ICsJCShzdHJ1Y3Qgc29ja2FkZHIgKikm
Y3RybC0+c29ja19hZGRyKTsNCj4gKwlpZiAocmV0IDwgMCkNCj4gKwkJbWVtc2V0KCZjdHJsLT5z
b2NrX2FkZHIsIDAsIHNpemVvZihjdHJsLT5zb2NrX2FkZHIpKTsNCj4gKw0KDQp3aXRob3V0IGxv
b2tpbmcgaW50byB0aGUgZGV0YWlsZWQgY29kZSwgcXVpY2sgcXVlc3Rpb24gaXMgdGhlcmUgYSBo
YXJkDQpyZXF1aXJlbWVudCB0aGF0IHdlIG5lZWQgdG8gZG8gYWJvdmUgd29yayBpbiAgbnZtZV90
Y3BfYWxsb2NfcXVldWUoKQ0KYmVmb3JlIHdlIGNhbGwgbnZtZV90Y3BfaW5pdF9jb25uZWN0aW9u
KCkgPw0KDQpJZiBub3QgdGhlbiBjYW4gd2UgbW92ZSBhYm92ZSBjb2RlIHRvIHRoZSBudm1lX3Rj
cF9nZXRfYWRkcmVzcygpIHRvDQphdm9pZCBhZGRpbmcgYSBuZXcgbWVtYmVyIG52bWVfdGNwX2N0
cmwgc3RydWN0dXJlID8NCg0KPiAgIAlyZXQgPSBudm1lX3RjcF9pbml0X2Nvbm5lY3Rpb24ocXVl
dWUpOw0KPiAgIAlpZiAocmV0KQ0KPiAgIAkJZ290byBlcnJfaW5pdF9jb25uZWN0Ow0KPiBAQCAt
MjUzMiw2ICsyNTM5LDMxIEBAIHN0YXRpYyBpbnQgbnZtZV90Y3BfcG9sbChzdHJ1Y3QgYmxrX21x
X2h3X2N0eCAqaGN0eCwgc3RydWN0IGlvX2NvbXBfYmF0Y2ggKmlvYikNCj4gICAJcmV0dXJuIHF1
ZXVlLT5ucl9jcWU7DQo+ICAgfQ0KPiAgIA0KPiArc3RhdGljIGludCBudm1lX3RjcF9nZXRfYWRk
cmVzcyhzdHJ1Y3QgbnZtZV9jdHJsICpjdHJsLCBjaGFyICpidWYsIGludCBzaXplKQ0KPiArew0K
PiArCWludCBsZW4gPSAwOw0KPiArCXN0cnVjdCBzb2NrYWRkcl9zdG9yYWdlICpzYSA9ICZ0b190
Y3BfY3RybChjdHJsKS0+c29ja19hZGRyOw0KPiArDQoNCm5pY2UgdG8gaGF2ZSA6LQ0KDQoJc3Ry
dWN0IHNvY2thZGRyX3N0b3JhZ2UgKnNhID0gJnRvX3RjcF9jdHJsKGN0cmwpLT5zb2NrX2FkZHI7
DQoJaW50IGxlbiA9IDA7DQoNCj4gKwlpZiAoY3RybC0+b3B0cy0+bWFzayAmIE5WTUZfT1BUX1RS
QUREUikNCj4gKwkJbGVuICs9IHNjbnByaW50ZihidWYsIHNpemUsICJ0cmFkZHI9JXMiLCBjdHJs
LT5vcHRzLT50cmFkZHIpOw0KPiArCWlmIChjdHJsLT5vcHRzLT5tYXNrICYgTlZNRl9PUFRfVFJT
VkNJRCkNCj4gKwkJbGVuICs9IHNjbnByaW50ZihidWYgKyBsZW4sIHNpemUgLSBsZW4sICIlc3Ry
c3ZjaWQ9JXMiLA0KPiArCQkJCShsZW4pID8gIiwiIDogIiIsIGN0cmwtPm9wdHMtPnRyc3ZjaWQp
Ow0KPiArCWlmICgoc2EtPnNzX2ZhbWlseSA9PSBBRl9JTkVUKSB8fCAoc2EtPnNzX2ZhbWlseSA9
PSBBRl9JTkVUNikpIHsNCj4gKwkJbGVuICs9IHNjbnByaW50ZihidWYgKyBsZW4sIHNpemUgLSBs
ZW4sICIlc2hvc3RfdHJhZGRyPSVwSVNjIiwNCj4gKwkJCQkobGVuKSA/ICIsIiA6ICIiLCBzYSk7
DQo+ICsJfSBlbHNlIGlmIChjdHJsLT5vcHRzLT5tYXNrICYgTlZNRl9PUFRfSE9TVF9UUkFERFIp
IHsNCj4gKwkJbGVuICs9IHNjbnByaW50ZihidWYgKyBsZW4sIHNpemUgLSBsZW4sICIlc2hvc3Rf
dHJhZGRyPSVzIiwNCj4gKwkJCQkobGVuKSA/ICIsIiA6ICIiLCBjdHJsLT5vcHRzLT5ob3N0X3Ry
YWRkcik7DQo+ICsJfQ0KPiArCWlmIChjdHJsLT5vcHRzLT5tYXNrICYgTlZNRl9PUFRfSE9TVF9J
RkFDRSkNCj4gKwkJbGVuICs9IHNjbnByaW50ZihidWYgKyBsZW4sIHNpemUgLSBsZW4sICIlc2hv
c3RfaWZhY2U9JXMiLA0KPiArCQkJCShsZW4pID8gIiwiIDogIiIsIGN0cmwtPm9wdHMtPmhvc3Rf
aWZhY2UpOw0KPiArCWxlbiArPSBzY25wcmludGYoYnVmICsgbGVuLCBzaXplIC0gbGVuLCAiXG4i
KTsNCj4gKw0KPiArCXJldHVybiBsZW47DQoNCm5pdDotIGhvdyBhYm91dCBmb2xsb3dpbmcgPw0K
DQpyZXR1cm4gbGVuICsgc2NucHJpbnRmKGJ1ZiArIGxlbiwgc2l6ZSAtIGxlbiwgIlxuIik7DQoN
Cj4gK30NCj4gKw0KPiAgIHN0YXRpYyBjb25zdCBzdHJ1Y3QgYmxrX21xX29wcyBudm1lX3RjcF9t
cV9vcHMgPSB7DQo+ICAgCS5xdWV1ZV9ycQk9IG52bWVfdGNwX3F1ZXVlX3JxLA0KPiAgIAkuY29t
bWl0X3Jxcwk9IG52bWVfdGNwX2NvbW1pdF9ycXMsDQo+IEBAIC0yNTYzLDcgKzI1OTUsNyBAQCBz
dGF0aWMgY29uc3Qgc3RydWN0IG52bWVfY3RybF9vcHMgbnZtZV90Y3BfY3RybF9vcHMgPSB7DQo+
ICAgCS5mcmVlX2N0cmwJCT0gbnZtZV90Y3BfZnJlZV9jdHJsLA0KPiAgIAkuc3VibWl0X2FzeW5j
X2V2ZW50CT0gbnZtZV90Y3Bfc3VibWl0X2FzeW5jX2V2ZW50LA0KPiAgIAkuZGVsZXRlX2N0cmwJ
CT0gbnZtZV90Y3BfZGVsZXRlX2N0cmwsDQo+IC0JLmdldF9hZGRyZXNzCQk9IG52bWZfZ2V0X2Fk
ZHJlc3MsDQo+ICsJLmdldF9hZGRyZXNzCQk9IG52bWVfdGNwX2dldF9hZGRyZXNzLA0KPiAgIAku
c3RvcF9jdHJsCQk9IG52bWVfdGNwX3N0b3BfY3RybCwNCj4gICB9Ow0KPiAgIA0KDQo=

