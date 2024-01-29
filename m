Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C429C47422
	for <linux-nvme@archiver.kernel.org>; Mon, 29 Jan 2024 10:52:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9O2YG/Xx77QAXmL80OfHYPA+opOBg8v6oyq1D9GCGek=; b=pX2Qcakz6cR9+PdttAuuCLGjTx
	rbRRM2DtCoe9u1ml+h7dPfdarNdTvri5jMO1TncLNywbu5aHG9vFDPGW75d1Ua9lq6Iq8JLg2pvwY
	kW0FbwkueZHUow/CAKeGKWJuqV97eAq1oX7/JaW59ByzkWe1u/VTHwsh8Rej3U89lDvjnq8mM4EKW
	upD1UM1ReugwRBrzA3JPk6aLTpE5a1CTZ8m2SnMLpSNbj9QOeEOhTcLSURTZ++lZB7WBMOUtFSnRX
	FaNRN4h4G82XD6IGRryQt+LHw9y2TsQnl3H7KqYnU2jECEStv9lQMmDhRrwBD3FVXU6Vxu/F3zfgJ
	p3Oqkiyg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rUPFV-0000000CIvl-3DVR;
	Mon, 29 Jan 2024 10:52:21 +0000
Received: from mail-dm3nam02on20600.outbound.protection.outlook.com ([2a01:111:f403:2405::600] helo=NAM02-DM3-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rUPFT-0000000CIvM-1QHU
	for linux-nvme@lists.infradead.org;
	Mon, 29 Jan 2024 10:52:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fqhJSGf3qv9M5h5sO4O5pwu+JWnmBShlvZWZy+fRJWCERtZXvlQlMRJxE5/5FvAsXkcXpTCNTUL30oK01xTSD0Sd4X/O45eyDqeVHECYPc1++iPBT7MPUnTrRAJEzH+msHS2OlZhZ0GcAKWcsX6D23vxtpb1UVfrUuzM3EwzWPixqLpZEDFhgvH2fmVkA6nwpN9AEYo/Kb40baNZ6WAL9K7KXTuiloeVFn/Rmt67ovtp8tOul/9IBi491FHOolb9FMdBri0gn+MuJx/ui9TlGCNJh+TtgCoNNK/ltmQrPwFt8uA5+d/TL8gF7W+HbMQ8BSuK9jC02h5J/6sTXy9zyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9O2YG/Xx77QAXmL80OfHYPA+opOBg8v6oyq1D9GCGek=;
 b=iyIbky2LSDIQyE2GKg2rgG9nFCtViii3Z5Q5aaR8TNgWJx75el7h4+FPB1UmlB+w15RZjTqFpI2/Qdm2So3IRSdoS2DM5ROrQjvwP2geK3jrcRyB0iX7msWp9M1EBszShgzFH/NIibV8vUuJSUTIuW2R0afq3KE0Zbqyt4387DILVUp4i67xvb3AksokiE1Qfmd3AM4nVA/ivWRqK5Gt/5iM0Amn/DBPhioivcEQAJSclBs2F8t7oc14dpIoUJn0N1FXF+y8lcn8OoRf4S4Y8Lfzrb8wioq2keZjdLCvNWdkFdHLhI/j01g6R3sZgRvlM5E3r8nw6WAQyTkWZUNwRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9O2YG/Xx77QAXmL80OfHYPA+opOBg8v6oyq1D9GCGek=;
 b=rXnXbD6Trpo1WOY6IJqV9yfhTx7Mtrs2eBUPMr4R/h8dbOnC2ew74uQijfpYISrlkblu4j6xj6cul42ztGUoX2875uyO1J6Wy85yYiqB4iy0vP6RcAAbKeOTiX31YbG1eGyLj0dEH4ygthCptjKWzQRFtRzdvInSYwU0GkpRHJ6HEWrAZXHaOIayeupUwR3eYg47m/9HLGkJpxd4h6PbQ9XYMjK0gF8345O1a6usHh5ywxIci/77UnYEZoWwVa8Ou2NVM241idroQ3SIY7/4lSX3XciJgRZIrljaiAFaUxvTQYF9NdPeowz87QYabYJDzz3SuzdYkhE1QupsY7mBaA==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by DS7PR12MB6359.namprd12.prod.outlook.com (2603:10b6:8:94::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.32; Mon, 29 Jan
 2024 10:52:13 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::ffce:bbde:c1ca:39ed]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::ffce:bbde:c1ca:39ed%4]) with mapi id 15.20.7228.029; Mon, 29 Jan 2024
 10:52:13 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Keith Busch <kbusch@meta.com>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>, "hch@lst.de" <hch@lst.de>,
	"sagi@grimberg.me" <sagi@grimberg.me>
CC: Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCHv3] nvme: use ctrl state accessor
Thread-Topic: [PATCHv3] nvme: use ctrl state accessor
Thread-Index: AQHaUHtnulHsOIefKUaiSQzk1HmN2bDwoXeA
Date: Mon, 29 Jan 2024 10:52:13 +0000
Message-ID: <01e7ee00-44c4-433f-8504-0698ec9fdad8@nvidia.com>
References: <20240126171608.2136149-1-kbusch@meta.com>
In-Reply-To: <20240126171608.2136149-1-kbusch@meta.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|DS7PR12MB6359:EE_
x-ms-office365-filtering-correlation-id: 6b146ec6-b321-4b6b-580c-08dc20b85a0b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FVuZP+h80MfEVvT+Af3u9ZknFuCDc+r3KKkj/2iy1i6qhk2FjU98MtK5bUK5qm9U6A99Dv21O3+QKZ44Lc8LYV4lvtmizIERTlNynfs8eRUq0CD9eaY4LbGzZq0Z/Us1HzArbbaNh26rFesL8RlSIOAhzbuPQ6++IaSZwNmpxNsln3+9t1sGimmLkdTpoCK96KKL+zlVS2doSoGgkSIsKheuWmY7Q+IukrKiWKGgEhe9fL7sivvgWRATaDrqAikir8nCgjbOYtyIYJj23mWxR1geSs7M7qBXD6eyrWDpqwF4jZdbMd8Zj6YAf4mM3mTMf/J0ubo9UURHgEHPlVqU4EMCBlK61Vy9OhLWKd6xIfg4TuGCL4w3nndCp3lViBYm2jOr64ScaBcnKJJ2CJFISxIxtrIh2/v3E5zo1GqUJH341vME3cEmj9Fx6wvcGWQXfjhQCjxWVDgLQRIJ85gYmacz91SRj9NZILptmlEc1auVu7drdtJ/4MDUTNaIBRosSXsXUIddOpSaMW0QQq4Q2x7HEPMWRH8Wmee/TEAcaC4zjMZazxSbf49rvp3rAfm7ceKD02MvoTgf8i4jgbyjpoXDR8hw7Pqn4c+4Xb7BOimUurZ/QBt4Cbbhz/ZrQKoFwlJk8W7e6XTiW2qVUMWQoWRbChiO9jfuQE6zCfa+/PG8T7QV0WxvgKQm52didlZ3
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(376002)(396003)(346002)(366004)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(38070700009)(41300700001)(2906002)(5660300002)(36756003)(31696002)(66946007)(66556008)(66446008)(64756008)(66476007)(316002)(76116006)(91956017)(110136005)(86362001)(6512007)(83380400001)(2616005)(6506007)(478600001)(6486002)(71200400001)(53546011)(4326008)(8936002)(8676002)(122000001)(38100700002)(31686004)(558084003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZzhOS0kyYVJlczVTdUFqQkZNYktDZmx4RDJtdEZaaFVoK0praUdwWU95MVVn?=
 =?utf-8?B?OVhva3FVYkFjU0RxbEVDaWdsMDJSMVZoREpVREhQU2EyaS9pTlM0VThXalR6?=
 =?utf-8?B?THlHRHVoNXMvOG5VN2ZER1JVa0pOVFlaTmdjdlZhMjNRaU9TRHZTd3kvZkpS?=
 =?utf-8?B?OE9GMmZCZDNjSGZoc1NYREp6dTUvMmJwS3NWK2xRNjQ2UTlCTHpOQU91Mkth?=
 =?utf-8?B?emQ2dlhlTXpxbXZZcmxKUFg2OGJyZy9SL2U4b0x6dERGUVlhRkJITE5LTU9Z?=
 =?utf-8?B?QlpycVlZcTRKc2Q1a3ZKVmgybmc3TXlxeGRURmxTMEZ3SjBNU2p4UjIrd2Ry?=
 =?utf-8?B?cEs1WFM0cjhqcEJuaGxkS1FkRjFxMFRNSmdhcGdLSzhFczRUSzRxZDdJdjJ6?=
 =?utf-8?B?OTlWc1N6MWkzeGwxZllJaWtrdGxpMndJNlpYRkFUWlJSTnFmdmw1cUQ0NFRu?=
 =?utf-8?B?T3B3d2Qyd2RPbzNmaGZRVkRvcTI5dmxERTZoUmlsb2FuVnlacGhoUmNOU3lv?=
 =?utf-8?B?eFkxSkxGa05KR3VVSzFCL05jUExkRHVNcEJmRkxiV3VXUTZNVWpPNUh6Z05N?=
 =?utf-8?B?VnRVRi9yVC94L1o1VEd4Tm13U29kd3IrTXc0aHNrYUZFTllYdEVaVHdtRys2?=
 =?utf-8?B?RlNORGIzNlViMGdvSFJTeTNhN25QcTZkc3Vuek5kKzFKcDI2WGtvUzV3ZFds?=
 =?utf-8?B?Y3lVM1RyaVI1L1BRWDFpSGNFZEZzRyt3L3hnQXU2MW12eUo0dkNuZTJBVlVX?=
 =?utf-8?B?S2s1QyttZk93L0lnTGlRUm1Mek1oSnRod21OVVkyeTRUQXBiTFYzdHdPSW0y?=
 =?utf-8?B?Q3d4bGJ5NFY4Yy9mVWdjNXgzT0hxR2swUlZFMWU5NE5ScHZNZ0pWejh4bzBK?=
 =?utf-8?B?Mk1DcjQvT25XQWJvMjB1cXZVNFdsRm1GRXVvUUN0bllIYkszMmJHcHVENmRU?=
 =?utf-8?B?UlR5Qmt4aUt4M1hIdi83SERqQkdQL01YT1hQWFF5OXd2RG9VVXpPRERoQjZI?=
 =?utf-8?B?ZUgrQkdlS0wvUVhYbDloYnZROC96NDVlUHdDVXJ2Rmt3V3NWNFBFVDJuZjBD?=
 =?utf-8?B?cDQyd2ltc3lWS2trRzJ3NUlTQzZCZnJITm1aZmtHOHl0eGJ1c3g3djgvRUJv?=
 =?utf-8?B?OTYyVEJxNG5rRXRvVHJpV2V2UXhQM1N5bGkzZWZJRUJIVGNLeWlsdm1mcGE1?=
 =?utf-8?B?U2RXdGtRWUxmeHZtSXk3VlNHWjdMQ3ErM1lCTUN5WC9wSitUK3c3Z3BWSkNQ?=
 =?utf-8?B?bmpUZlVrYVNWbGRTdFlIZTNDNUh4Ly9kOTg2QnZJZ3ZPOFFISElzem5qaWt6?=
 =?utf-8?B?M2NVbUs0RmFkbnA2akl4SGJhM3VRVWdhVVNYdE9NRHpvdSswKzZKWTRWc2Vk?=
 =?utf-8?B?N3FSSlVnbS9CYlZDWXNRelRkZUE3Rmtia1o2SmVFVmtJMUJPNy9HdG1aMUh5?=
 =?utf-8?B?RDZxdWNod2pKQVNiZ3hIenFaOGpzVVUyUFlteGxPWjhCaUppMlNFWTdGME93?=
 =?utf-8?B?ZmVBbEV3OTUyTFhoZ2JUZGtGUjBDMEhZN2JCZEpmZzA0OEtnZ2MxTGpwcTlM?=
 =?utf-8?B?NzV3QTN2TTN0YWlXSWlXSEVrT1BsMDJDVko1Y1cyVUxUVmUwVG41S0lYMTRS?=
 =?utf-8?B?dDlzd2pwY1RGdERKVStFR0tzQ1V4bHRoMkRDK0wyYjFGUXVkUm9RUkxoTm1l?=
 =?utf-8?B?TWRMUENxQ0xmNk04SHl5WWgzcVhqaWNtU2h5Z2I4cy9aVzhDOGxXVHRpSnJE?=
 =?utf-8?B?TW81MjNDTzRJanYyaU1CNmlMVFhwUHV4VFc2ekY1SXpHTGFNMmNhRjZjUG9Q?=
 =?utf-8?B?VmpaMEpmYmZ2RTFkbWU3OXBiQ0k3YUxUYittRkF4dlVyVERsMjgrYk5oaEFQ?=
 =?utf-8?B?cm5ueHhXNUt3eDNEd09CSk9BbjNWcEpsZ0NiQmJHYUxCZmhPUjlzTnNPVkx3?=
 =?utf-8?B?ZW5EaThBL2hYeThSVk4xUTRPV3hSR0FrRjdrUWlWRCsvWU1NWVpVRVRoaHht?=
 =?utf-8?B?YWxBTXhLZjdLLzQ4aXNPblI3ajI5K282c0FUaWU5MTRkc2pQRExEMS9Xb2pF?=
 =?utf-8?B?VEwxS2lnaTM3UzRZOXZTb0J5RHpuTmJjelQ2cExxSXdhZjNvVDlnaXoxbmpt?=
 =?utf-8?B?ZkZyRU1UYjlwUFp0RExqQXJ6U3RkRnhhZTFmQndtTkp2N1E2NnFkMlRQMzRz?=
 =?utf-8?Q?H+u4G7bsa7ZSFgRZIXxTXTI0qZF+DOh5M8+TFLYfkSa8?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9388F262705B1A47AD04213CFC430B16@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9404.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b146ec6-b321-4b6b-580c-08dc20b85a0b
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jan 2024 10:52:13.6119
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zXjWR0i7IMJz7+H9Lo5iLbd/16O57+p5GNQpfhIJ5cLljZmrzAb7PVs9JPmW24ry8J2AxGEheDF289vk01Aw6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6359
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240129_025219_436207_B0682201 
X-CRM114-Status: UNSURE (   7.81  )
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

T24gMS8yNi8yNCAwOToxNiwgS2VpdGggQnVzY2ggd3JvdGU6DQo+IEZyb206IEtlaXRoIEJ1c2No
IDxrYnVzY2hAa2VybmVsLm9yZz4NCj4NCj4gVGhlIGN0cmwtPnN0YXRlIHZhbHVlIGlzIHVwZGF0
ZWQgaW4gYW5vdGhlciB0aHJlYWQgdXNpbmcgV1JJVEVfT05DRSwgc28NCj4gZW5zdXJlIGFsbCB0
aGUgcmVhZGVycyB1c2UgdGhlIGFwcHJvcHJpYXRlIGFjY2Vzc29yLg0KPg0KPiBTaWduZWQtb2Zm
LWJ5OiBLZWl0aCBCdXNjaCA8a2J1c2NoQGtlcm5lbC5vcmc+DQo+IC0tLQ0KPiB2Mi0+djM6DQo+
DQoNCkxvb2tzIGdvb2QuDQoNClJldmlld2VkLWJ5OiBDaGFpdGFueWEgS3Vsa2FybmkgPGtjaEBu
dmlkaWEuY29tPg0KDQotY2sNCg0KDQo=

