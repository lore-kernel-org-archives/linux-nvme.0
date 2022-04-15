Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAF81C433EF
	for <linux-nvme@archiver.kernel.org>; Fri, 15 Apr 2022 05:28:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Cc:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=IUrxn+u2dxGnqiD7WHuIm4mOZuYoqNupZDiFZNpXVtc=; b=LQGt21Ax/TWr9h4eWsYBNfhwOp
	6qUbin4nK8Nb42t8S4QFyDygyfMsjKmjQj7OIg94oS+iYzhlWsK12JPw9I9Kkn2PZtokDoYW7A3HW
	jy7q0sJWNhXCMRpBDG4LWrT4h8xRLzcCL+Wu2WnGyTwOXI5BDD1Rh3Zywo+7z59gMD1x4cjv1snAa
	0XuFcocCXU+bxWHiPDmvky64wgulp7vOmNoYXg+8JPmcBuXy4flG/xbwgwY9cA/rh+SmJ8wFiA1T9
	Ov8FZlBnUHFTqN0pH6ucC7m9/Yx+8m6JZaYMK4PXXGp4bLFomOnlwzT7ut6Mh5j8bG5i3FCiSa5FT
	JalKpiIg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nfEVb-008foS-96; Fri, 15 Apr 2022 05:28:39 +0000
Received: from mail-dm6nam10on20601.outbound.protection.outlook.com
 ([2a01:111:f400:7e88::601]
 helo=NAM10-DM6-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nfEVX-008fnf-UE
 for linux-nvme@lists.infradead.org; Fri, 15 Apr 2022 05:28:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I/SF03SejyRQHP2U4FMbQykaZWNuCLnm6sqClDWV6Gv51U6DylxYFZE/KEU7xrIWKroTX3pqc3O0NTPM/gZRN6ESwDL23VvNm/X4bbcDmR902uHVX/mZ3xsKc+b1CFvg4UxdVwNbhaW7Lbmc2RHw04FDLsHdcc/T/kHEhBbIJ306k2hPN/VXGFNZTnGqCKXBq1I309/Qg770RkPSPK4OYVj+xiUY4Pj+jo4iLoBgtEknG3n0T0VJWgie8wnXFkMRrf9WknY/vzeTCzY2rrB4EboTsHnCwJOZaIGpG1KWYBRi+hLDG5xe9dA26+5mZ2kRShrOHnio4MAAWYkRlW/EYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IUrxn+u2dxGnqiD7WHuIm4mOZuYoqNupZDiFZNpXVtc=;
 b=STvLdHYRTQXowyBAKLpIhFrUZ0JZJ7rXPIvvjk3aT9h6tE+iev9g6JkFzhI2ln9NilOaRHha9Cx4vLojiVAYAsd3bAO9dqR75A6LNHMlXHBeznBmjvwE20YQ3cHtPaXsSgxC1SHQ0hJlP35mDHGxxsXuxRHpOjKC7kMbnKCpKXF8Hxqs3IG0h7xkvQdJqwCsdx5L1rGwSSYKYiOZJSgNXwoAGqzVsitOj46aFnsdy4ozO3DkxBKQaX7nDpzUojJBiHCymVB3w969wYbGdN37RbtOkOQ5g44H7lPbC2zj0Wfr69uI4qJlLG/uKSPY+mA5xzLriPqeg0NZW/DsMcJgKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IUrxn+u2dxGnqiD7WHuIm4mOZuYoqNupZDiFZNpXVtc=;
 b=c2A7Iqo7lbOnDRG+gneZeeOSq9b8RsaK9hAx/E/fOK6QwD0y55g3Qdhc3R8yFVT+4/RfGAbO1ey3rvjrq66PvGSU2ZpJY+1ANLXiAZZAx+wtV0AXCUFt2Z8dheeU5Xl3BfUkXRiSkzZTjSS8gTUtZbDygdc0C/jyCTOK+qUICL5BJk8meurNLKjBvY2j40brnrN2G8ApI5krOLh5KHRaU0p6zUSW58gYDVgwtF/8T7FX+FtyOyL6DDV/GfVULJejQcakPIk8p3SEd15yNyf79WzwIbnw505plgxvPlY+qCPwXSOAVW1W7LGlXxHeyMONBacoz9kqxbL3TKFwjYiD8A==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by MWHPR1201MB0093.namprd12.prod.outlook.com (2603:10b6:301:54::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29; Fri, 15 Apr
 2022 05:28:30 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::a90b:9df2:370c:e76b]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::a90b:9df2:370c:e76b%3]) with mapi id 15.20.5144.030; Fri, 15 Apr 2022
 05:28:30 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: New NVME errors in 5.18-rc2
Thread-Topic: New NVME errors in 5.18-rc2
Thread-Index: AdhPr+oKchgQzq9oToOhaf9oWWv/bAA2bn4A
Date: Fri, 15 Apr 2022 05:28:30 +0000
Message-ID: <c7873b21-26cf-ace3-cfa5-f6e3fe15e444@nvidia.com>
References: <BL1PR12MB5157B98D6A245A76ECA5F17EE2EF9@BL1PR12MB5157.namprd12.prod.outlook.com>
In-Reply-To: <BL1PR12MB5157B98D6A245A76ECA5F17EE2EF9@BL1PR12MB5157.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b8d4070d-eccf-48ba-64ef-08da1ea0c6ed
x-ms-traffictypediagnostic: MWHPR1201MB0093:EE_
x-microsoft-antispam-prvs: <MWHPR1201MB00936DF9AC18AE3788151FECA3EE9@MWHPR1201MB0093.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: o3KEQll/p88wsITBH3t8mn1JFm0l2+eNe00T4aIk4PwBfdQJCMnvQI0TmIqjQQ3SOQ9vwoZWY6k+boVDnjL5YhUb4uT6VsPE9A1FzOe6GCiYUxU8uBxDuu60AGi1pKvFpUICNiCYZAYzhsFyQ0LT3cnWqiTqy+48ZhlIy6G+Kpych4h4bT112HAbW+Poj2bLDCTPri5I1q13jpM5CED2jYjMII7MXAwViuCh22znrW6JqJOPtPcLRUvIliXP3wUEfZSHhC8f64YQ7Dsn9U6XV6lrzwSq09LhFe/fcS1LJYTXR15k2kuv4YsZKyxtDM0wOMqgahjHTT/NE22VV9QzZqUqaL+GoJC7ydOK8cEtI7D+F9ev8p5u1X51vlQECbuzrK+HB0w46VQJKj603TMHVCXcJoy8T4fpvIILGIUx3Pu7SJ0sGfnvzijijc5Axi29PXkFPvNFDLLGpVymq4NSChsZ8/36D6eMSfX8+2X0NnhH2VvGCl7dmVW2C05sFvG/SiC6ST21SHqYbEfzHfSf8YYI14UZmUSgsPeK3PQkDhLRfYWAFtsD8HOfJGMQGwPoMiKfWhvjuoRnpkHcK/NJqaEpVJTAXZaYSxr55zvuiVFf71cwhlue+gWr6QgR3ClswZWA82jWuQSZqTLpE4Sphvecz8gF1MLBirCd+QbnjZTb+cM8iKhIQEWNpdiX5SawVRicVrIsGW0Ed32SalkaKWm87Mp/kPaXYj6LhMDJBMFlO7PPOi+YMY3JQivF85DW832Mr3JaQykpNGveZGRGQ3Brqx0xIpu7sLOLh1MjKVlygry8AtAIIz491GVKQcViravaOcJTvwFpoi6mEsT13rhitDgYFD7Hba2SYIylmkE=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW2PR12MB4667.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(83380400001)(6486002)(966005)(186003)(71200400001)(38070700005)(31696002)(86362001)(316002)(66556008)(64756008)(66446008)(66476007)(8676002)(6916009)(76116006)(66946007)(8936002)(122000001)(38100700002)(508600001)(6512007)(2906002)(91956017)(2616005)(4744005)(36756003)(5660300002)(53546011)(6506007)(31686004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Um01RXFjeFg0ZitxdzYzZk1jYlppV01SaWRselRsa3h0U3UweXlWMnp1K1dv?=
 =?utf-8?B?dGZCcjl1TzY1UVRHVFM4UnZNUzlXQlVkZ01hRUFCeXI3cnNidmZmRkdKTlpM?=
 =?utf-8?B?UU9rNG5JZno0YVdlRW9BVzFYVm82NmlDV2tUeE9BOUdobmJkQ25tOStJV1Vk?=
 =?utf-8?B?Wk1nc20wL1dGMTdXTE54K3lDR0ovSkdRT0ZOb1M5L0cwMVUwRTBRWkRVVU5p?=
 =?utf-8?B?WURYUlVaUjhSTlJVSXdtQ3habis1V0IvNk41ZUp2MWtVdEZobGJWV294Wld4?=
 =?utf-8?B?M0J1TVRTUVVaeDE5TFlOTi93QlNNcXNjL1k2OEZyZC9FbDFNWjJMMTdNQnVO?=
 =?utf-8?B?a3ZQcDBRcEpPd1lJMDdjQTJqMHFXRnhES3dIZnZONjIvWmwyRlZsWTVVSjVZ?=
 =?utf-8?B?cjJ2cXZRUitOV21uc1BmUzlRNjhQeXJJWE5RNWYxYnQramNDK0d2cCtjRFhn?=
 =?utf-8?B?OXhjdFp5d1pmeDhHRXp1SnEvZlZHaGNUdnJSdk4vS2pLTFgxMHFhaThRVXNM?=
 =?utf-8?B?QnZqM084MnNjbEZDaXgvYlZway92cXhmZU9SUWRack85M2tOc0QyUHJpREow?=
 =?utf-8?B?K0xWcFFScU03Mm0wUEx1REEvNGVlSlFRL2RUSmE4MGhWcmVTRlR1b0NjRFNQ?=
 =?utf-8?B?bExycEF5bEpqQTJocXc1TzJ4YjhrUVhmenczOVdDY3hkcWhxTWdqaDZYVGhP?=
 =?utf-8?B?eExiam5JRGNTRmlqdzczOHZQOXlEL21LZkFPeEFVditqVStBYzdIZDFmMzBt?=
 =?utf-8?B?dVJTb0pRNElTSnl2VEhTR253ZWFjREN2R25rNW9YWGl3VkxZUHBhdnV3Q0p4?=
 =?utf-8?B?ZlBCRjJOUUJKMDJRNmxmdERnaUplOFJKMUZJSkdOTHl0VXJXZHN5MmNEeWdu?=
 =?utf-8?B?ZzhIQXpja08xUUhpTkh1WFV5SllZZmFmanZmYTdGS0o0UGs3YnQwVW1CaWdL?=
 =?utf-8?B?UWRUcjNVM2h1UUQrT2VYYWNNdlI2N1FqWjlxRXllMU5VYWJHdnptczZwaHlJ?=
 =?utf-8?B?cjg5VW1DSlMvOWxETnpZZDN3MVNoUlJ5SGxMVUllUmpacWk4c3ZzV0lyeHFJ?=
 =?utf-8?B?SDQySWNESU5hZm9mYVFhbTBhVzFmUDB2NjlCMzdER2xHUUYrTDhtaWVyMkdY?=
 =?utf-8?B?Zno0b0h0K01qVnJMZThQMEtwYlNHZVJQRDgvWGpnc0pEQThjbTVLT21CcHZk?=
 =?utf-8?B?ZFdzWHZWUFNLaFhPaVJjNFI4OTRjdFNqdDFZQ3c3U2VxTVo4bjJNSHNnUVpy?=
 =?utf-8?B?RlJBS1R2SmlzNUdNbFZPUi9RN2N4QUswZExqYUJYL2lJY2JKeDNqSXpCTXF3?=
 =?utf-8?B?MDVnZTFUUis1Z2Q1Ukh4OVVaVHQxY1hBejhwRy9kMTkyeXhKQ1R0WFJnUzhP?=
 =?utf-8?B?U3NueVZXMVZaU1RpSUprbWlZTmNMaVpjWDdSVEtUOWtzYVVtMFh0ZGJYUnRO?=
 =?utf-8?B?cWYrS2l4TDRzWWtrMkFhOUlyZUM2VUQyQVhRM0pvMm02V2kxWFNsa2hqNTJB?=
 =?utf-8?B?em5CYkZvWFY3bTkzMC9QTnorYU1xTnBwRElYLzRnRExJOEIwbjFPQy9mV1VF?=
 =?utf-8?B?alJuaWlRYlQ4Vm9CTTBuVGprVUJJcXZZdEtKdmZZbjhhZk1paGhrT2llc1ow?=
 =?utf-8?B?OEJjSCtza3VQMnNVQWN3dlppZk9takNMc3RGWHp4YXBENE56T3VtNDdRaENN?=
 =?utf-8?B?QWkvdXdiQ1dHMUs4dTJUQzMySEFnWnhrNE11ek1SQkNzMzM0ZndJTDhOTEVG?=
 =?utf-8?B?TG1sZ1ZER3ZjR2I1Sit5bmdRc29zeG1hN2RIOFk1S3p5eXhDUTI3bm1IS3VB?=
 =?utf-8?B?SzRQOXcxck1TRUs4cjlucXAyVWM5MmJZa0ZkQk5heVh4ZjV6cDlZV2k3b0lK?=
 =?utf-8?B?dW9wNVVQZ0lqZUkyRHd2VEpsZURCb2N2REk2bEdZbUV3blkwYnR0MXYrYjBH?=
 =?utf-8?B?NytRbC9IWi8yWEU3U2xrRUtEejNWcHJTN3VyOFU5d0JGUmJXWGdSYjA5d0RJ?=
 =?utf-8?B?dktzNU5sQlE1V2hXTVdaUGRHdmN6bEJzQmlHekxZdEFESDdyMnU4Y1pZb2Zr?=
 =?utf-8?B?ZXk1NlVjYmY4MDVYZkliN08vTDZVNko1NkJwcTl0VDBCb1Z5QXRoc3BMS0R6?=
 =?utf-8?B?SllwcjJVdHVBOEsyYnlFbW5FSG1qNm5FU2dnYkdTMVNkYmZ3c2RhSXhxZXZS?=
 =?utf-8?B?RmFjVGNicGY2OFJQRE1GRVpQMDAyK0prVnpIdHc3YzgxNXRpY01leFpDMFlE?=
 =?utf-8?B?Q0xFRnE4L0pSSHZPT3Z6VHRsckVOcXpjVjU4WjNibHVJT2lUQkZmeTRkZTdC?=
 =?utf-8?B?SHdtQUVwTlR1R1RMcUtPZytRNmFXUW5tOEZBRkRFZDROZWlSYzNyakxBV3Bo?=
 =?utf-8?Q?S+EAfonk8VXAvXZU=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <102D590D30DC3C4181F597A275A63B95@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8d4070d-eccf-48ba-64ef-08da1ea0c6ed
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Apr 2022 05:28:30.6768 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kwyG0NgHWjUyD/ONCefXXY5PgKHeuRYv+h3XS3yrfHkl1PdCsQrQoooirBicWWlwiMk2iknwJor2ORBkvDtTxQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB0093
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220414_222836_014334_4D3565AF 
X-CRM114-Status: GOOD (  12.78  )
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

T24gNC8xMy8yMiAyMDozNSwgTGltb25jaWVsbG8sIE1hcmlvIHdyb3RlOg0KPiBbUHVibGljXQ0K
PiANCj4gSGksDQo+IA0KPiA1LjE4IGFwcGVhcnMgdG8gaGF2ZSBpbnRyb2R1Y2VkIHNvbWUgZXh0
cmEgbG9nZ2luZyBmcm9tIGNvbW1pdCBiZDgzZmU2ZjJjZDIxMzNiZWFhYzdjNDIzZmQzNmMzNTE1
MDQ4ZmM4Lg0KPiANCj4gV2l0aG91dCBDT05GSUdfTlZNRV9WRVJCT1NFX0VSUk9SUyBJIG5vdGlj
ZWQgdGhhdCBJIHdhcyBzZWVpbmcgdGhpcyBtZXNzYWdlIG9uIGV2ZXJ5IGJvb3QgdXAgYXQgbGV2
ZWwgZXJyOg0KPiBudm1lMDogQWRtaW4gQ21kKDB4NiksIEkvTyBFcnJvciAoc2N0IDB4MCAvIHNj
IDB4MikgTU9SRQ0KPiANCj4gU28gSSByZWNvbXBpbGVkIHdpdGggQ09ORklHX05WTUVfVkVSQk9T
RV9FUlJPUlMgYW5kIGl0J3Mgc3BlY2lmaWNhbGx5IG9uIGV2ZXJ5IGJvb3R1cDoNCj4gbnZtZTA6
IElkZW50aWZ5KDB4NiksIEludmFsaWQgRmllbGQgaW4gQ29tbWFuZCAoc2N0IDB4MCAvIHNjIDB4
MikgTU9SRQ0KPiANCj4gSXMgdGhpcyB0byBiZSBleHBlY3RlZD8NCj4gDQoNCkkgdGhpbmsgdGhp
cyBpcyB0aGUgc2FtZSBlcnJvciB0aGF0IHdlIGp1c3Qgc2VudCB0aGUNCnB1bGwgcmVxdWVzdCBm
b3IuDQoNCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL3BpcGVybWFpbC9saW51eC1udm1lLzIw
MjItQXByaWwvMDMxNDgyLmh0bWwNCg0KLWNrDQoNCg0K

