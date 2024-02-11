Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACF0DC4829D
	for <linux-nvme@archiver.kernel.org>; Mon, 12 Feb 2024 02:30:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=cMOeEUKDYkLL09VH6N3hTS0sKUIJ+qca2AvAw95qRkE=; b=sdUWo2qQHYSd3tqS7AYYf+Gc/7
	eJNtxZ1ToLHF6XTg4OSGQsVM6ZKYZ4cZ7U+uYskGSlK0/5rfUU61XG+A3Ekvi4bU4CgPYehFsG5SV
	efLwDUwtmkaEgx7NawBvTun0CTNj3bz6tnmJEAC/m1J2PDBEF56dF552Q22vKt6HnJ1n1NMJGoTGX
	W4tocglMaLIip3Yp8hp4MEFkLcFy2Gq57bhrRcxCXvZMmHWT7OgRLeKcBBVNsc8Zui9ICUEmApeDv
	z2Dgzo9tRFuXsNGyEoXvXtPJyXyA5LMnxVeggL/SBdfw+QHSYjEruqpnYnRjiSFt+1/cf8+ubx97h
	fnuCJCZg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rZM5G-000000048vd-2a1o;
	Mon, 12 Feb 2024 02:30:14 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rZJkB-00000003bPT-1Asv
	for linux-nvme@bombadil.infradead.org;
	Mon, 12 Feb 2024 00:00:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=MIME-Version:Content-Transfer-Encoding
	:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To
	:From:Sender:Reply-To:Content-Description;
	bh=cMOeEUKDYkLL09VH6N3hTS0sKUIJ+qca2AvAw95qRkE=; b=ZvvoBLRQlf56mEpJh2hRAW4KGX
	3DODE7jt0qRrgl2zvjh2Bvx16+S/la804n0wngXxIED0wXNgfxejWUpII4c3O53/V80GaBXWc6p+R
	f4Diae3kMk/Y9OUnYT2i5AzADf9imyN0XtejhQ43x8GjKCHKqSlL4jJ+rJEawvyba/qjO+fh76wNt
	DMd9xK8epMBT0MxVJjdJ7NhXO5eBkZayubw7zkgFrwpCCdkA1Fmlr/VbpAX6qj3fKQxUYlmNBBA5N
	wvW6JB4h7rtPbgXmotl8FXk+uPyY3TPgysYKY9EQVa1F5FbaqDOZjTMT/F52/Plck0+ayyXSVRjpa
	iKgW/pqg==;
Received: from mail-dm6nam04on20600.outbound.protection.outlook.com ([2a01:111:f403:2409::600] helo=NAM04-DM6-obe.outbound.protection.outlook.com)
	by desiato.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rZJk6-0000000F1iR-3rw7
	for linux-nvme@lists.infradead.org;
	Mon, 12 Feb 2024 00:00:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YZ7E36o/iXfocs9u0Odwt0GdjucyLJVMyBdCUEcsTpezjaWGPnE1B3aJcQTa4WTjmxzWFO4hrMM7mxTyHhpWiiStRj6zR1UkD2cxjeNyPLEHYR5HNAff3q/dU/dVZ0iB4q03Yvv/LOqWpgvGds7FgXvR2E40gp8MtBpNiYvJ9Ha/c8yOHy+EmV5LFoa7NOddJXM5yj1Nw0o/ObUWXTvRUNGeupWlJpeRH6pWhFSElbzXAT2nZS2NlD2POqVFUJrnbqChy3b7A7NettfZqHu0RglpoNJgFepK0BWcg58aKUYVBjFuLEEJT+n54a2Ea+sNv+NnBeXxY7Iss5PSuUDOFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cMOeEUKDYkLL09VH6N3hTS0sKUIJ+qca2AvAw95qRkE=;
 b=EogeOvv/iWzK0k7ThZG4WwwX7VJaCtSPLdom2j3C5w8XxHwLCV8uE3AWTkz0gtfqYecRAEfS6j4NqgBJu64L4aoIrFWlPiC5dF8OSur2zHY3GHVVlL1/cW654LAwdPrxij8gNuFMu1H4eFN5f3Uf1KLkclO//Z8yAXl2P0v/zO2rNNwLYG2eUM81lDktOYfWvWC7a/dk+lzG0JIBlODlqDPlBvuFh9xep/PLGO6fJ4Xge4ZWJ01ooaY4tjUMNDEXIpb9JeAHpgvNdjBCXwf+Kp10Csx7R+yuth90WxUB4fZxuOD1g/thelFj8leoxpcyXwz602XlYl/pZ6bQBZ32Rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cMOeEUKDYkLL09VH6N3hTS0sKUIJ+qca2AvAw95qRkE=;
 b=nzyl0b4TFCqnLRem3LkNmku717nXfnoZ134XKfBlUD6A8UePNEGmhJZGF9wKLstUjiSZP71kynSctNe7RBgj3Zg4OlkT53A1KUKjIzzy5NCvayKAb7x0Ec8FhroBrB1rZzhhxpjvsN7jFXNRwH1GyHMKEkVCzk4HvlQS4G7PNFXQbQvfVBKdxuI2MInGUC7+FtnXVaRG46PzYrPx22eIsmtK4+KthcvapFXZZosyLh/abfpYyOZ5AdWp7vP14ABFkxalEqEp1azCUtX3TH6f9IGvSJUGeM5OAIjmI1kSdFJ7gCy7aeHqgE8YbEGoeRtFr7nevd7GWuJA33j5/Jz1/A==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by MW4PR12MB7334.namprd12.prod.outlook.com (2603:10b6:303:219::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.11; Sun, 11 Feb
 2024 23:45:19 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::ffce:bbde:c1ca:39ed]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::ffce:bbde:c1ca:39ed%4]) with mapi id 15.20.7292.017; Sun, 11 Feb 2024
 23:45:18 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Nir Rigai <nir.rigai@volumez.com>
CC: "hch@lst.de" <hch@lst.de>, "hare@suse.com" <hare@suse.com>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: Re: TLS over TCP connection failure
Thread-Topic: TLS over TCP connection failure
Thread-Index: AQHaXPu9NkmdQAIoeUevwng0N1SpTbEFzsQA
Date: Sun, 11 Feb 2024 23:45:18 +0000
Message-ID: <a69a47dd-bb86-47be-ae74-1d26c64bd409@nvidia.com>
References: <587CD834-9978-4D44-BA69-4AADE3DE2E06@volumez.com>
In-Reply-To: <587CD834-9978-4D44-BA69-4AADE3DE2E06@volumez.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|MW4PR12MB7334:EE_
x-ms-office365-filtering-correlation-id: 1d25d304-5400-4d35-0f84-08dc2b5b812c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KWh7VS8b1QI7DvJnTe59KePluloQzmHjy3govmWUjgy1khIyz/yGd8JZpOE769h4u5ofVWbmYNogS8xCxbx6/ewjVRRhqEeyL2TIom+4fwwG1++OqIyVSa9/tppjNuLlhQf7omNl8fiL7JYcaYuijXBhV206BlH++5e5Jl4nQYlkxsAgVtC6TRGjVmL7fGpcP7B1oHm6XTE3wqHETcU/ZIpyXOf1cIB2gzkPqrYkXozcwtlSZrRd92+fjpogPKDCY3ESACnWV4ObJK+bTP4R8Z6fvGA95pStNdLX/HYKbjJ3aVjd8kwrFmv/VfHbECXX8JNUcHRpdGA7OdvOjXW9wfwbz+PeWXOZhz7wYCBu2IYcmyFk1J5kTuahWxGSyM/f8IdecEJ/w6pF8c87igQ9797wqes7Cvb44kQCxlAR+dU0e748j5I9JsK+aMGNMGOgKs/d9z4rRLFBliyVkgvRfO24hyrZoRVq60sK3Ktu3LYFn230+ErhuTlynL758S/DRGA4VVR/5n8WYzX52kJi0uo7woSdshn2eiyl62sBgYwmV6pKG0PciK4hSEN5rkOeiaCPIo3vZcWFNh//+/hQ9CjPXhbUP4p+nGmM1BfnlgfXV00XeJssHi4yYn/ApB9gnxmhRC7KbK642I9oOfhs2MS/1u4n06AMQMUnxfG2rHY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(376002)(346002)(396003)(366004)(230922051799003)(186009)(1800799012)(64100799003)(451199024)(31686004)(316002)(2906002)(5660300002)(66556008)(6916009)(66476007)(66946007)(4326008)(38100700002)(8676002)(66446008)(122000001)(71200400001)(91956017)(54906003)(8936002)(76116006)(6486002)(53546011)(64756008)(966005)(6506007)(6512007)(478600001)(38070700009)(36756003)(2616005)(41300700001)(86362001)(31696002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZTdLM3dmSXQzVlNmNTN2emNtYUZTbFpIUXFDZWJWYmkybnc4Y0lhT24rYUxW?=
 =?utf-8?B?ay9uU0JNcFk3UFZ5NnRiZWIzMXF2RGsxbzFmVjRvQUpQRmhUb3NGYlVGMGVI?=
 =?utf-8?B?dGhhemZwa3E1SlBhdjlLUWNEYjI3QysvQW9FcUphdHMreWw2OStWSW9JSlZ3?=
 =?utf-8?B?SC9IK2M4dnVyMkFOZXN0NE42TFRWemg4ZUZMTWNMMkFZWVVQdTFjUXRFV3ZK?=
 =?utf-8?B?ZXBoMXB0VHZPWlZRM1VVQ0FoY2hnZ1pXWnY4dFNTdTY3aU01S0p4Z1Y0a2xC?=
 =?utf-8?B?WjROMGFmRTdaWExPWnVZM1E2aW8ySklLM2Y0OGplSXZlUWZHZ0NGQ3A1UGN6?=
 =?utf-8?B?TXBDcjg2Rk8wK1pSN1hmcUtidEwzN0VHQnhkQmRab1FiSk9xOFRyN2szN3BS?=
 =?utf-8?B?ZVFKZlVtMklyS0M3N3VyTGI4SUJNdUNFYzllQzBESitrWVg2VS9KcnBCSnFL?=
 =?utf-8?B?YVZYZnl3c3VxQjdVV2F1Y0pxZU83RzF5RnNBbjJ1OWxicUJ1RThmRE9DTXJJ?=
 =?utf-8?B?T0RuWVlYMDVPajh1S1VKZ2thSEwvZ25UOEtwakpsTDNXcE5KNzJPdXhJTFZP?=
 =?utf-8?B?TitjN3lyWGROMlVKMWRIVldnS1FZbXJJQzFaV09RUHF0TXZ1YU1VSjBWMkVa?=
 =?utf-8?B?TGxtWDhkbEkveEtIS3VxSjN4ZzV2SWUyajhwTzRPblA0QWdBanJDOEhKOGxC?=
 =?utf-8?B?c1lqandwOFMzeTI3OU5XQ0lDRUxKUm5XUmlmMDRITGhuTlZGeE5LbnhkWm53?=
 =?utf-8?B?T2VHQVRkYWZaZ09Qc3liQXRzZVdadHN4UWs4QnVzajJQQXdZb1RteDFJL09M?=
 =?utf-8?B?TXozMjkzVzdQT0NqdkdXR2ZZVjBxak9kbk4yeE13ZTlhVm1TMmt1eXdkWGly?=
 =?utf-8?B?LzVRaWpabjVhQUZjd3lpOThWQ3V5ZllZcmtaRWNVNVZYeStDelJJV0F4UkVk?=
 =?utf-8?B?V1ZadHdlL05lS0t3L1NUbEZCdjNaYm5YRmlXcmtoUHh0cS9uYWl6b1ZPTkVB?=
 =?utf-8?B?NG9DWEVxMFQzVEZFSCtEUmhlek9vM2RWOVVrQ3RNV0RmaklTMUFtMHUrY1ZB?=
 =?utf-8?B?U1p3V1FSeWdjNjVwcThtVndjNVN1aGxJOEVtaStpeEwwNFNTbU42cjk1V1RZ?=
 =?utf-8?B?TDltYS9sZXQ2UVRtNGxRdDloVVB5cVE5eTA4OERvaUl0bmdyeFRhcTRtUjI3?=
 =?utf-8?B?RkJ4OVhMTWMxN21ISGVLa01paEVScEZ6cFAxTUNrbFNGbGtVVTZ1bEhmQUYv?=
 =?utf-8?B?T0grUkowbkRub1gzMDQ3WHcxZ09rSDZxd3JDMFduMjZVUUMzbkp0QUI1NVRV?=
 =?utf-8?B?bXduZ2tGWHVSQUdlVWExQTR1TWlsNVFCVGwra3JjSWk4VjY4bkZLaGFLdzgy?=
 =?utf-8?B?a1hSUitnaENNNWlad25PcDgzS2NSQThvUXg0QzM2ajBTVFJjUHQvZUszYWo4?=
 =?utf-8?B?Y1RSWWNVQy9RVVVySXBwc2xyN0kyRHNNb1pydk01TUxQQ2o3c3E4TXgydnhJ?=
 =?utf-8?B?Q2pDNTNvK1FxRC9zVTVpbURtaXFaMGs4RTNaZ0M1MXh5Skhsb2Z4MUJuTjdZ?=
 =?utf-8?B?dE4yeU5HeXhxcFVTVTdUdVBwejNaMjFqZVlydmlTZ0FlRnRQc2FTenRHa2dV?=
 =?utf-8?B?VXUrbjh6MTZjR1NyaEdFUEl4N1R4RFM0dlhtS1d2L0xreWNLZEpEeWFqbWFI?=
 =?utf-8?B?VXI0NTQ2QXhKeUFwTEFUaVZ6ZlJBTVBSYzdBNmxzTWtHUmJnZW1aOXR4RDVJ?=
 =?utf-8?B?dGdUSkR4K08yaXYvbVgzb3lOQ20xamdMVzZUYklLT2tKOTROaW1QbnQ3ZEpS?=
 =?utf-8?B?U1BWUHduVGtBZkROcHFRUnlpbXFPL0o4NHVBMWRUaVBtTklVMnRpU0dCc0Jt?=
 =?utf-8?B?eElMcEdUNStIMGhaenlGd2ROMUNKb3dBWlltS04zREQ2dzdoTHE5NEdMWkpy?=
 =?utf-8?B?UWJNRmJXa3Q2SlRWWERuMEp6SkFJY09RN1NHQTJYeFI0TzVsTEk0SEdUZmdG?=
 =?utf-8?B?WXFZTXdXK1RqVTBuWktSQUhPK2xVNkhhaGpRSEIxZ0JqUmJrWHhrUy9tUWdv?=
 =?utf-8?B?alh3QUh1ajlOSmxHSHVmaFo0aG5uYjZUQmN2QUtOaUtoRDY2eXN5bDhySk9N?=
 =?utf-8?B?UW9FMUh2R25DSHF6cXZsNGN0bE95d0tqakhGbnNOZUsxSnlqdnV4VGp4VjNk?=
 =?utf-8?Q?cCa3ENCCP+vBvoCf4cnSDXhpJKqXqVHkV9ZEn4pe8dOl?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D8FDD7CDCE1A224BBC90E9FFBDFC51CC@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9404.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d25d304-5400-4d35-0f84-08dc2b5b812c
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Feb 2024 23:45:18.8391
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Zy1Oe+2q/OyNTtu5vagQfKTzPNK9e0knERs0rV26CVZt9sxsBOr7+FqfvJpxHBaNV7V1y+ZiQJ1Ssv5DYu6akg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7334
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240212_000015_222441_10D8CCCE 
X-CRM114-Status: GOOD (  10.28  )
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

T24gMi8xMS8yNCAwNzowNSwgTmlyIFJpZ2FpIHdyb3RlOg0KPiBIaSBhbGwsDQo+DQo+IFdlIGZh
aWxlZCB0byBlbmFibGUgVExTIG92ZXIgVENQIHdpdGggdGhlIGxhdGVzdCA2LjgtcmMzIGZyb20g
dXBzdHJlYW0uDQo+IFdlIGhhdmUgZm9sbG93ZWQgdGhlIGd1aWRlbGluZXMgb3V0bGluZWQgaW4g
aHR0cHM6Ly9sd24ubmV0L0FydGljbGVzLzk0MTEzOS8uDQo+IFRoZSBOVk1lIGNvbm5lY3Rpb24g
ZmFpbGVkIHBvc3QtYXV0aGVudGljYXRpb24NCj4NCj4gVGhlIHN0ZXBzIGFuZCB0aGUgb3V0cHV0
cyBmcm9tIHRoZSBwcm9jZXNzOg0KPiAjIFRhcmdldCBjcmVhdGlvbg0KPiBtb2Rwcm9iZSBudm1l
dC10Y3ANCj4gbWtkaXIgL3N5cy9rZXJuZWwvY29uZmlnL252bWV0L3BvcnRzLzEwDQo+IGVjaG8g
LW4gIjEyNy4wLjAuMSIgPiAvc3lzL2tlcm5lbC9jb25maWcvbnZtZXQvcG9ydHMvMTAvYWRkcl90
cmFkZHINCj4gZWNobyAtbiBpcHY0ID4gL3N5cy9rZXJuZWwvY29uZmlnL252bWV0L3BvcnRzLzEw
L2FkZHJfYWRyZmFtDQo+IGVjaG8gLW4gdGNwID4gL3N5cy9rZXJuZWwvY29uZmlnL252bWV0L3Bv
cnRzLzEwL2FkZHJfdHJ0eXBlDQo+IGVjaG8gLW4gNDQyMCA+IC9zeXMva2VybmVsL2NvbmZpZy9u
dm1ldC9wb3J0cy8xMC9hZGRyX3Ryc3ZjaWQNCj4gZWNobyB0bHMxLjMgPiAvc3lzL2tlcm5lbC9j
b25maWcvbnZtZXQvcG9ydHMvMTAvYWRkcl90c2FzDQo+IG1rZGlyIC9zeXMva2VybmVsL2NvbmZp
Zy9udm1ldC9zdWJzeXN0ZW1zL25xbi50ZXN0DQo+IGVjaG8gMSA+IC9zeXMva2VybmVsL2NvbmZp
Zy9udm1ldC9zdWJzeXN0ZW1zL25xbi50ZXN0L2F0dHJfYWxsb3dfYW55X2hvc3QNCj4gbWtkaXIg
L3N5cy9rZXJuZWwvY29uZmlnL252bWV0L3N1YnN5c3RlbXMvbnFuLnRlc3QvbmFtZXNwYWNlcy8x
DQo+IGVjaG8gIi9kZXYvbnZtZTFuMSIgPiAvc3lzL2tlcm5lbC9jb25maWcvbnZtZXQvc3Vic3lz
dGVtcy9ucW4udGVzdC9uYW1lc3BhY2VzLzEvZGV2aWNlX3BhdGgNCj4gZWNobyAxID4gL3N5cy9r
ZXJuZWwvY29uZmlnL252bWV0L3N1YnN5c3RlbXMvbnFuLnRlc3QvbmFtZXNwYWNlcy8xL2VuYWJs
ZQ0KPiBsbiAtcyAvc3lzL2tlcm5lbC9jb25maWcvbnZtZXQvc3Vic3lzdGVtcy9ucW4udGVzdCAv
c3lzL2tlcm5lbC9jb25maWcvbnZtZXQvcG9ydHMvMTAvc3Vic3lzdGVtcy8NCj4gICAgIyBDcmVh
dGUga2V5cyBhbmQgc3RhcnQgdGhlIHRsc2hkIHNlcnZpY2U6DQo+IG1vZHByb2JlIG52bWUtdGNw
DQo+IG52bWUgZ2VuLXRscy1rZXkgLS1zdWJzeXNucW49bnFuLnRlc3QgLWkNCj4gbnZtZSBnZW4t
dGxzLWtleSAtLXN1YnN5c25xbj1ucW4uMjAxNC0wOC5vcmcubnZtZXhwcmVzcy5kaXNjb3Zlcnkg
LWkNCj4gI3Rsc2hkIC1jIC9ldGMvdGxzaGQuY29uZg0KPiBzeXN0ZW1jdGwgc3RhcnQgdGxzaGQu
c2VydmljZQ0KPiBudm1lIGNvbm5lY3QgLXQgdGNwIC1hIDEyNy4wLjAuMSAtcyA0NDIwIC1uIG5x
bi50ZXN0IC0tdGxzDQo+DQoNCmNhbiB5b3UgcGxlYXNlIHN1Ym1pdCB0aGUgYmxrdGVzdHMgZm9y
IHRoaXMgaWYgaXQgaXMgbm90IHRoZXJlIGluIG52bWUgDQpjYXRlZ29yeSA/DQppdCB3aWxsIGhl
bHAgdGhpcyB0byBnZXQgcmVndWxhcmx5IHRlc3RlZCBhbmQgZXN0YWJsaXNoIHN0YWJpbGl0eSAu
Li4NCg0KcGxlYXNlIENDIFNoaW5pY2hpcm8gKENDJ2QgaGVyZSkgYW5kIG1lIG9uIHRoYXQNCg0K
aHR0cHM6Ly9naXRodWIuY29tL29zYW5kb3YvYmxrdGVzdHMNCg0KLWNrDQoNCg0K

