Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75843C433EF
	for <linux-nvme@archiver.kernel.org>; Mon, 13 Dec 2021 22:59:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=BKeOO6ZUXRQs5BxpEB/IWWAztg2YWK0AJ8pl/rHx8eI=; b=MfeBOzcx3NTw/bSHtsgaHi9PB7
	uL03fw64v0bbw/7i9RaI6LFQBNdRYdb890UvY69TZUu1rgly4pn3i1OOrGUAWTaSZh1El/Jlqvfcy
	0GTdv8PhGGpAUyqKFhR1CLHURle1tX6yekGzufEafKwDwsIJRkAibcfBaCrMsRXlv5x4WDwSaLwcW
	d3RbP7N/jzaRMNQEa0KIZjuclDXuFBrPe9vDDoiqwf+nPLWV0d/atmt6r9JKQhjS6IIy18wtuT4d+
	BO6zNRGoBp5RDV+lzPmmXnn4PVVpswHkEYsWE/kOSXod7cNj9obQHwXcBeq4OvTcoRrwJQnLa09fF
	oiwfAaQw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mwuHZ-00Btc1-25; Mon, 13 Dec 2021 22:58:57 +0000
Received: from mail-dm6nam12on2049.outbound.protection.outlook.com
 ([40.107.243.49] helo=NAM12-DM6-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mwuAZ-00BryO-00
 for linux-nvme@lists.infradead.org; Mon, 13 Dec 2021 22:51:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hGfuyFc2ducpbRRywHa8AStUxUHn4EwDghsu1hiU87OZcJv1bXNSyO+UeIheVl947FhXVjQfsv4Nm85wzWf8rTYNx0/QtJroFxFb3B8j39T8oENfvOQuoJIsBMyCGbH2Db2IhSYie01NDAKH78NGHGPDVbS+FQPOmDJZmDrwvt4cwkqhf2N/VNZDbavWbAqKFqaZsI9oi6JPxllFgML+fgOhg/DC03adrrcTVGJuFYoISbGOXBP/pVS07miWtaABLJh2EN42uKpV7svk9+MKL0sRREZeYJ8h8ctiAnbkFcuhaFcqyw6Jd/EC84EaOBGjMgJql51oAcXIDsyWOqP4wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BKeOO6ZUXRQs5BxpEB/IWWAztg2YWK0AJ8pl/rHx8eI=;
 b=jHnNE377D+9ks2kO2Dt+MeJpwyOQB6jJoQ9BrNabTPanjmMQLneA1DECzrcZDE5fzauN3TPgAJxwZ+YndasGAo8chCG9m9ZYRaSlgMecITTpifw1IkOVDZm5O5KqdxGua4Pv5g9ZNnhHp2NQmfZlRsxt6t/5VQEyU08HLWvL0sH2yEwfRxKDAo1VB82YBPSvx2/aEUuUTWaD12rsBG20bZTUvmTAMMpFRtuxQDHrKv7XQfdpiNZLCQgiCclQgEW/NW4/v30hPLUwOxcytpRYSs/oTgWS9VotjUyBUbAcQd/11wy1nNpkf90zdjuZd+6LalfQ4PrvrEhKk8yTpgY/Yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BKeOO6ZUXRQs5BxpEB/IWWAztg2YWK0AJ8pl/rHx8eI=;
 b=F3GZ4CHlI710dS8H1gFkx7e3cH3jfz2PhUbHdp6ecSnQKN+6iIVjNP+qqFnWcqDFmTQhqQKjCHO51PJ3Hc2tV8diB4D3SELWaEyprqm8ACANt5nHE5Zhd+RDLknL/Os7jxTsoIs87QQE9D3B6WTAQv2MRkXyK0G6ljktQFykL8HGhsLxlbcetMD2q9w3Ur9PCMDnkKNYyXaj3RI91euw0gU+C8l/zOMw/KCEWtF49T8KBavgfCrjEMH5ne4zCxGZarW5f/vh0yN0i8XlMX8qlBed730gRMYBfxN95IXC7uxUKz7qPHKR/Nfl4LXzduXMTsVLrxXToUnZODImaghCrA==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by MW2PR12MB4668.namprd12.prod.outlook.com (2603:10b6:302:e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.16; Mon, 13 Dec
 2021 22:51:39 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::6df1:639d:74ea:d39e]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::6df1:639d:74ea:d39e%7]) with mapi id 15.20.4778.017; Mon, 13 Dec 2021
 22:51:37 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Hannes Reinecke <hare@suse.de>, Sagi Grimberg <sagi@grimberg.me>
CC: Christoph Hellwig <hch@lst.de>, Keith Busch <keith.busch@wdc.com>, Omar
 Sandoval <osandov@fb.com>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>, Hannes Reinecke <hare@suse.com>
Subject: Re: [PATCH 05/10] nvme/rc: add more arguments to
 _nvme_connect_subsys()
Thread-Topic: [PATCH 05/10] nvme/rc: add more arguments to
 _nvme_connect_subsys()
Thread-Index: AQHX4D9ysLXPEYnhsky6aXc2hvhSZqwxJ3mA
Date: Mon, 13 Dec 2021 22:51:37 +0000
Message-ID: <0193029b-e602-45ac-cba9-18e35c171dab@nvidia.com>
References: <20211123074940.113390-1-hare@suse.de>
 <20211123074940.113390-6-hare@suse.de>
In-Reply-To: <20211123074940.113390-6-hare@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5c670401-3e01-4407-87ec-08d9be8b1efe
x-ms-traffictypediagnostic: MW2PR12MB4668:EE_
x-microsoft-antispam-prvs: <MW2PR12MB466879CC111ADB8A357A9815A3749@MW2PR12MB4668.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2958;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nq8FgTnWZJlx7isdpalk1Xf3NNeEm/I/sc5BihTJ6sPJvNQD3D4gBJ0qg4XOiGSvYkDsPmkh2L3+harUyK3rSmoDKHoKJNjUfaTvxm3deqBPHxHl9R3wfnaYWPYzTDEzK8BgUh+uxtXB5n1IzimvtjDBATerlOVn+OhZEBS1g3m8ETEOH0+GIIZgcqZQSD4DDBh7MGUE0UAs5SfUM5GS21WAwomHv3TB0gP0EXKkrZiYksxExAs4Qg72F8fFOuBJUITryf9GPNv0V7UxbiSuFmLlUQPDe2+I14KjScBNxaYEC5nGfHjZbe1nWDnmVTPcK7cTZtkIaj2vucIMMkIH49N3mHCMsekoe+5zCU5dyzy1v13/OmGyWX8IEoMoK2zzj3dZcnbrBLPFD4f4StQDfh97Lcx7X0zsNsatYCfRfnqyJed4YEUl0xJ5mAPhDvSj9h1qUEd3nV9BONnnGopMOc8sV1KH1NC/e/ZEwLDhQ6xqSES+zeUS7Tfejtxc7sfiD2eHVxl8L3hS6GUjk2NCmJD+pBO1NH5j4rn14oihnRE/s58Gd0BeFzrXNanPuiVvoN1smQUciN0MlhQKJDFESI6ZL0Dr2RyBVBCYhy0wbp0wZOny303ePT/qB+ubDz8kMp/1ncAthKsfd9pvp2aElhNA9JsTwhURlmx9c/bs1kYDksOMU8JGzNtzSkkIn6cigGYn8H7wWRPnVtT8pGZQ5HciFIFwdkKEjbcLD8QBYt7ca2cH2b+vgbPCYvcspWol2qOPrPY3ePb8dyhX69W2zg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW2PR12MB4667.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(86362001)(6486002)(53546011)(36756003)(316002)(122000001)(54906003)(8676002)(71200400001)(2616005)(110136005)(66946007)(6506007)(66556008)(4744005)(186003)(66476007)(64756008)(91956017)(38100700002)(76116006)(31686004)(6512007)(508600001)(5660300002)(38070700005)(66446008)(2906002)(8936002)(31696002)(4326008)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WnZhWDVuaHhuems0L085NnJlN0lyMTlLRGJoTzNNTTFyMEMzWkN3b1I5dkpD?=
 =?utf-8?B?N05GdDdjYlRuQVJqaGpnNmRXRHVQWGdaY3JMcmF5dE5sZllhNXlKWk12enAz?=
 =?utf-8?B?RlIxMFQ0WHlEUC9Cb3pPd0J1MHh4ZzJXYVhCclh2MkVFT3BrRzZSVmhKZm5Z?=
 =?utf-8?B?a1BaUUgza1hDb1BJYmV1ZnpGTE5KY2UveDNIYU1ScnFYWlFyckpIMlRQMnFV?=
 =?utf-8?B?V1daUDNwQllDQ1ZyNXVwRGdMVTlDY0tYb24yQVk4d2FMV2hMYnZIUHdETkFM?=
 =?utf-8?B?TzZxMU9rTTdmTFA1RklFU09yaU5BQkxIMzFoWHBRMWxDMVJMMlFaSVZEMXRk?=
 =?utf-8?B?S0JWckpwUTVqdVNJdi9nNm0rcjd3LytNYk00ZTdUY2hwcnpRdDZsVnppVzhM?=
 =?utf-8?B?THdIZGhmWldBZm5MTURzVDVuSklOVW5nZWg0T2FuV01BMGJtcVJPaGNHanpO?=
 =?utf-8?B?NytGNXhTNGpXZ1FHOFRPR3JGMldGVkZvSXN4U3FMZ0o4VVhHSk9pOFFFNHZB?=
 =?utf-8?B?YnZKYVJybVhUOHR5TGpPYUhyUCtXWXg0dmtkUkNWUTZZTHNGdnNzQU0vSW14?=
 =?utf-8?B?eHJGRGxGNW5YU0ZBeHh3Vys5VFIzbXovWnNoRUxPQkJxRXFSeW5ad2FEL2FM?=
 =?utf-8?B?MDhDY1k2RTJ6UStBZmI2NlJXTG9NbGhXVS8wTnFQZVlnRk9YOXhPdU5FaTZS?=
 =?utf-8?B?RmJXUVFkMmk5WnJ5NmdsOW5DTGZTSXgwVkNjN254bDVsWWZTdE50RVZLaTZW?=
 =?utf-8?B?dEovV1BadVZ2d1lrTk0rc0VuaHNMcGt5aHIzNjRGS2F1WDB6c3lLc0REL0Zp?=
 =?utf-8?B?ZitqUnpMMXJSZlZhN0FVKy9WS2JBYU50WmFBT2JjWWxaT0xBcDE5L3dEWEJ4?=
 =?utf-8?B?c09jckY2cEJXampsaExCbk02dTlyYzExRFRNczJlSVVXTEp6NklpWG92ckdU?=
 =?utf-8?B?SEdrRVZCRkwzdWdZOUNsQ0tKZVVaYXRJSTBPYVZuSlcyMnRndzZQNHBNWi83?=
 =?utf-8?B?RTN1Qno0UTlkUTJlZEN6eDFCcXRlN0JJZUV4SmVMcGtPZTJjV0FuMkVSSkd2?=
 =?utf-8?B?cFBnQzVQT2F4TThQcnd1Mys1WnlaV3JPOENSMEVyWUR4dUVnaTQ2UlRxRjdH?=
 =?utf-8?B?V3EzK240K1RpaUs3SDQzWXI1N1pSNWlkOExjdktRK1lIM2VJOVE4SDlGOHk1?=
 =?utf-8?B?cXBJSEd2L0JqbENPbENEaHF2dDdnbXVkMkVvejc4QTc3YUwvN3AxemxQNlhp?=
 =?utf-8?B?azQvMXVnL3FwUm9iRkt2S1M4cVJaMkpYclUwZitRd3NTZ1A3SHExeXE5NmZ2?=
 =?utf-8?B?QTRSSGlIZGxQYndoaTNUdDFxOWlKNmFWbXFOVncrZ1prOVB0eEI0SjBCZlhB?=
 =?utf-8?B?Mk9RZWFvV09IMkZ3b2VjZmJyZzFwSkdPZ0I1LzRoeWxHRzY3S29MMUtIaWt3?=
 =?utf-8?B?K3dFM1lFNFQyRmdvVXExcDhZekZLS1BSTXNlT0lZandPN3c3MG4rOHlLTlRI?=
 =?utf-8?B?SWpyQVMxU0czQXNEdlViTEdRTGpuc2xGQ3hYUEpQbjdKZzJLUml2emNXZWIz?=
 =?utf-8?B?ajU5TGRvOEFRaGV2ZGJ2T0hla2t1VXROS3ExWmJVUHJrQ1VKR0FOR2ViYllu?=
 =?utf-8?B?K2FsUkIrTDFnc0dVZ0xqc2dzTjRLVEdnNGF5MFB2eUNkZEdNMXJvMjVGeDJh?=
 =?utf-8?B?SGgzL1AzVmNIM0E2cy91enlvdC9XcEhrL3ZCS05TKzIzUkdBdVlUQ1Jud1FJ?=
 =?utf-8?B?SVZPMnZzM0R2VkFicWtTdUhvVkExT1dXSUM2Qkt5b2RNSDc4K3Z4OUQzeGJG?=
 =?utf-8?B?dk81aEFUaWZDd0RvU0o4ODlXck9US0s0Tm5tQVRVek44M081VDhpTXovNWhB?=
 =?utf-8?B?V2JIS2h4cWNhZlE0N1dtblA3WHZxNm5adkdpdzZTRjdRWlhLckIrMDJvK1Ex?=
 =?utf-8?B?ZXptY1VHdWt3NEk4bnFLSTFYWStXOUE1Slpwa2lYN3Z1ZE5ua041aUVLQW1s?=
 =?utf-8?B?Y3BENk5kSzJ0QkU2Y3U4eGV3RVNhSE4yT1NpaTcyNFZJU0RSaUdKeVBYaE1l?=
 =?utf-8?B?eDRUazBkb0VYQi9hZkZtTHcvL2JiMW03elBKOEJYaDNxRjl0ZzZieTFkWXkw?=
 =?utf-8?B?K2lvSHc4VjU1NFgvWE54enNrdkk3NkNaOVM0UDdjU2lQR3R3Q09ldFNwbDZh?=
 =?utf-8?Q?Gkz/589q7YDdD2gZQIMKZ2qz5FY3DjgcIRjh0AiWaxiz?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <00AE9197B28D8E4E87F3A88E0960C704@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c670401-3e01-4407-87ec-08d9be8b1efe
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Dec 2021 22:51:37.7675 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZADzrzA4WwaIliWUKrzQrDECogNtKA0sW9lyo2Vg68ydx/dr/G1WUptNw+HYk8omF4+3v/W3GUViamL7hxxkig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB4668
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211213_145143_091350_4DF33B42 
X-CRM114-Status: UNSURE (   9.56  )
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

T24gMTEvMjIvMjEgMTE6NDkgUE0sIEhhbm5lcyBSZWluZWNrZSB3cm90ZToNCj4gRnJvbTogSGFu
bmVzIFJlaW5lY2tlIDxoYXJlQHN1c2UuY29tPg0KPiANCj4gQWRkIG9wdGlvbmFsIGFyZ3VtZW50
cyBmb3Igc2V0dGluZyAnaG9zdG5xbicsICdob3N0aWQnLCAnaG9zdGtleScsDQo+IGFuZCAnY3Ry
bGtleScgdG8gX252bWVfY29ubmVjdF9zdWJzeXMoKSB0byBtYWtlIGl0IHVzYWJsZSBmb3INCj4g
dGVzdGluZyBudm1lIGluLWJhbmQgYXV0aGVudGljYXRpb24uDQo+IA0KPiBTaWduZWQtb2ZmLWJ5
OiBIYW5uZXMgUmVpbmVja2UgPGhhcmVAc3VzZS5kZT4NCj4gLS0tDQoNCkxvb2tzIGdvb2QuDQoN
ClJldmlld2VkLWJ5OiBDaGFpdGFueWEgS3Vsa2FybmkgPGtjaEBudmlkaWEuY29tPg0KDQoNCg==

