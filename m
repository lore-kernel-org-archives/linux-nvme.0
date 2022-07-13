Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C144C433EF
	for <linux-nvme@archiver.kernel.org>; Wed, 13 Jul 2022 07:32:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=QFSSLFE5IUnoar8RlEEiQCqOqzu5aJCTeKAQNEHSEes=; b=xS/IWxHmjs5IuoN8VhFrCOrrwz
	vePMaZUEbR1TTeq3za70VQKgcJPa+5FUAxvyv8muZ+KxeXsvLH+GXNacQ6sNKKNz/07LWnQY/ZFTT
	2ZJXrB4pEr4/juYnVhP//4eUmszc15eTOoy/0nMvQnyVb0azP5YmqPeF+YjU45ai7BWED33nNYwmc
	IcrImZ35Wz5KAmXGwRe4NcrIDkhxxqqmjYdtk/N6+3cm9PERCq1Vfl3dL58k7WvlxGaVoJ9r6Nln5
	NNK8YOMB3c+0v9R4r5ZlxguehBTvsDDe6K4TO0lxMf+AK+97FN+O5itxa5AO4xt5aPoVWfi80FNn3
	cSYo3Rkw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oBWqz-001GaN-Ew; Wed, 13 Jul 2022 07:32:13 +0000
Received: from mail-dm6nam10on2076.outbound.protection.outlook.com ([40.107.93.76] helo=NAM10-DM6-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oBWqx-001GZh-Dx
	for linux-nvme@lists.infradead.org; Wed, 13 Jul 2022 07:32:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AfwLxmovJ93ZNKfr1Ykp6Kq9VpGeso3MQAU887bEXuYUHEAStIIALQGoe92djMl6IbR7dJu0LaNmYmBXmVEOSm0JQVSIR/4UZ5WNrDSIinC7vwDw8KYQQSLMGq8zYI+J5+d5m+JCtCFGNlFl5RHg7tOFqLGOVdxVKbiBAjJH9fT1UIhmxsgy0sLIMIpsr45L0Lf4khz3sp34HAX1wge/SNJZ+DWn1v0K2DldGws053FnnIhBkMOaSaA1jVCAu3DG8puAcDa3L7/7zPyHPSfFsMTRlpQszU3S2val1ZDQI8oTyhrIWDaifqoI1Q3ch94WpHrl8Ke5vfWtoUj6lNqOVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QFSSLFE5IUnoar8RlEEiQCqOqzu5aJCTeKAQNEHSEes=;
 b=daiSTFM8DSAlqxvuG1WbmKmrOZX3MKNHF0M+FLb578vzQkvVGUgTTA134ytumXV+2P3c+IuRjNvyI3JT2ezc89KTGiA69eNUvNV5F5a2CL3ghuPnaJoSCsUI37qq3WkeJJkW5iwzlT2CSHILQTKTMn2C9kOIe2eqOVxQbSigJTDQQiAKFS/nfG3jI+oE/T0Y1PyMOhomIZB+G3PUiQFEFnsTq+aBs4kRf0hIDAcKteRgralSXtr5cddEV+9UAl0/ZVhS982kwAO7GFPjS7WWnJN28mLZHbMx9fjxh6f8H8w6obm/uTXcku61c8B67lwwaJ5ZHz54zVd8e8g5OmHN/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QFSSLFE5IUnoar8RlEEiQCqOqzu5aJCTeKAQNEHSEes=;
 b=uXmcdUpXt0qs0tC/m0MBiejLBCf4LS0V5fFjJFb+E419lxP5QnyvTbHj6BBmKoQt/FXV9sMXIIEO1JDvkeaSRvry6ShLdpHyyDYTImsFJ15qlUytInk4jqMy8bO000Y3IOYvj5NPTk9iR9XSa9s1ydM+UjGcSHtLbthelkUVdK+1ar00OXYmixRrG50ovxvSvUulNFQKeLI1MMSKbFf9d4cWOjGMJUxjdmec384AndJ/rc0DeaOuTQPDNxocoIs+c8738K4n3AIBM8DHdvY+iGCpLmCjbSsbjib+Bp6r6eT6bojLwf644UN4LOo3kcHFiN1Cgh4wxzgQBSe6kidcRA==
Received: from BL0PR12MB4659.namprd12.prod.outlook.com (2603:10b6:207:1d::33)
 by BL1PR12MB5350.namprd12.prod.outlook.com (2603:10b6:208:31d::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.20; Wed, 13 Jul
 2022 07:32:07 +0000
Received: from BL0PR12MB4659.namprd12.prod.outlook.com
 ([fe80::3cc0:2098:d2fe:5f56]) by BL0PR12MB4659.namprd12.prod.outlook.com
 ([fe80::3cc0:2098:d2fe:5f56%7]) with mapi id 15.20.5417.026; Wed, 13 Jul 2022
 07:32:07 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Christoph Hellwig <hch@lst.de>
CC: "joshi.k@samsung.com" <joshi.k@samsung.com>, "kbusch@kernel.org"
	<kbusch@kernel.org>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>, "sagi@grimberg.me" <sagi@grimberg.me>, Joel
 Granados <j.granados@samsung.com>, "gost.dev@samsung.com"
	<gost.dev@samsung.com>, "k.jensen@samsung.com" <k.jensen@samsung.com>
Subject: Re: [PATCH 2/5] nvme: generalize the nvme_multi_css check in
 nvme_scan_ns
Thread-Topic: [PATCH 2/5] nvme: generalize the nvme_multi_css check in
 nvme_scan_ns
Thread-Index: AQHYlnxkn3Dmv+QWakGyZK/51OeAd6176FUA
Date: Wed, 13 Jul 2022 07:32:07 +0000
Message-ID: <1a96c320-f9ea-cbc1-e61c-fdeb9244e5c7@nvidia.com>
References: <20220713054914.1888305-1-hch@lst.de>
 <20220713054914.1888305-3-hch@lst.de>
In-Reply-To: <20220713054914.1888305-3-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f696f866-3c3b-49d9-7b4b-08da64a1ca42
x-ms-traffictypediagnostic: BL1PR12MB5350:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  h0L8dRzPQafOs7g5ywNhFZp5iqGL/l38SB8w0kVqTFhwgZG4w7//g+YUlgMjDRoyqZ8kwE6I5Rik90BAXBz0ifoqx3v2DdQ2fvUJjgvI63h45xtVspELeDImqaXyM8lSRQ/IsT3InPH/xer6ryB6thuDyuyVIkt82uQMb1T0PoTjzqAw2y/3ta6ZULI1JuXVoI1/bLXsGxpKlfL0Ig4Pyi8OFBfo3o62fjoeZTYISTHjM8slzc1tCbeg5GYJT8piNBGpbdxumb6K/zaV1rd3D4TAoaTbgdNOs7N6FhkQ+LpH6JkllrQVKMbIAt9P3vqgh2EY1iJxRdR8xxCEMhKLoc/yuPEOlnlyf3Cka1CQ8tjg5GFQIG8jGvzDxdwOVEo+QlfLO9ioI0rfCzg3VIa4cCXNoVGHueivolQBPJazr729QGqycW2hOra5jFvngxoqP0i7tY4+gFOIwPBxNU3ZPWnaJZswutW5fsxFKT4o9UTEiHqB0zm7xkQnrII5wfzVhQZ4F3kGScc87HSvAlcFIsilMiaEGFgZBrbxS63ymi2RneME+0ipamNFz0VYwBmVS8qwzuRij5ZZv7M6A0elZfChrddpTYRkHmLraU0XMeIIMfCfrzBWdua03HdZ8yGxHjdKAnwT+FNCbIlU1casqtcXvR4uNrJRI6fTkw/EsUoPuFQQ9nmgxP3xyPGlubzeQhX0hn4DMOCUTQtKV6uJBIwHtE/Wfup3fSM/PXQ2hcmSYTtMKtXxK/VyhbdxvsYH806o/vxjvo7ZRKZX73DKbpu/qwZ1QF5HTM+XQao94w3lDDzAdUeosNC2Us/Bm8Hb05PtZd+vACeh9is9D7ulJzidrzthR0TUJyOuvMbHaHJu0cjVOAq/bwo3e+SvfqGn
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB4659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(346002)(376002)(396003)(136003)(366004)(186003)(122000001)(91956017)(38100700002)(5660300002)(54906003)(76116006)(4326008)(71200400001)(31686004)(6916009)(64756008)(316002)(66946007)(36756003)(6486002)(66446008)(41300700001)(53546011)(6512007)(2906002)(8676002)(86362001)(8936002)(6506007)(478600001)(66476007)(2616005)(38070700005)(31696002)(4744005)(66556008)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:  =?utf-8?B?ZE9zSERLeXhINVRWZ0tQMEtvM1lSTnd0b25MRW5wRHVVUWZUVXVHdnBzZmxr?=
 =?utf-8?B?MGNScFNWcDZQNlRhSmQybUpxSWJ3N1k4Wk5oeHg5WE5FZHVMR0c5dFBiLzgz?=
 =?utf-8?B?MmdLeVZUOEd4cDZnMHVsU2NoRGRhMFhsMTFJNithTVFvYVBNbE5zVVltaVoz?=
 =?utf-8?B?TkdldFNOcHNxOHZERytJSjN5YytnazRsUGo1NkgxRnAyNlRqWk4rc3NpU2hB?=
 =?utf-8?B?LzVlTUd0Q0dxMXZaR3VyYmZtQ1Vpa0V4UmxMRkJ6M2dqVnI4U3VvL3FtVDIw?=
 =?utf-8?B?UXBWOTQyc2VrQkRhZ0Z1V0tLdDZiSEMxSWdvUzgxODI5K2pLUENGdjJjN0dz?=
 =?utf-8?B?UVh4c1BGVU9PN1RycGVNOGFhR1VFNVRCY0N1WG5Gc0FjQ0tibkNYTGw4MHBj?=
 =?utf-8?B?andzd3BQaGFmUVVVcFB4OGhQYWRBWEZKcUtnamIzTVp0aS85NVFpMGR4NlZm?=
 =?utf-8?B?a3pCNWlpT2R4bURWUUpKVGs0cldqMk5uYWh5Y1JoTHR1UUtlNzBKdk5qTGtS?=
 =?utf-8?B?R2V1MTJveGxtNjdUZWNCVDBxUkN3aE52SytjY0wvekVVZ3I2Z09vZFQ0Vis5?=
 =?utf-8?B?SHovYWIrTlpSUEQ2WUFIVnQ4N1FGaUtWalhtSmpGRXB5ZVpIUjVkd1lCaGE2?=
 =?utf-8?B?MU1Pdm1TWXFJMGIxMitRaFpJVkxnMDRFdmEzZnl4ODdLazRXRzZWSGEydm5E?=
 =?utf-8?B?Ryt1d2FjeFRKbmR3azlzYUVOQVo5TFFIdFp2RklJdFZKMDRRV3lHNHNMWjQ2?=
 =?utf-8?B?eXFoQW11b2RmbVYrYmI2aXJQTmU0UjJlcFNuZlhGTnczdWJsU1M2MTg2a3RV?=
 =?utf-8?B?M2JXM2p5T01TOFYwZllTVUM1czgxVndBbmx3b01HNFFPWDdUdWEzc2VOWk1J?=
 =?utf-8?B?d3BmMWxqakJHNTR4Y0FjbkdRTHhtMmxKWWxpVHpNRGtSWjMxTXdEcDJGODR3?=
 =?utf-8?B?WUtydWhGL1pNSVhWSnRrVmtzMWtpbnl2TVU5eGkvMGRQRXN5ZFhQNkJXZ3Y0?=
 =?utf-8?B?OVVSdlBpNkxHUGNGSGRQNlp3VGxudE50bFBiVXJ3N1dYVVFPTFBVMi9FZDg4?=
 =?utf-8?B?dUltZTFxSXNCY2JDSGllMG5pNUg0RVQ0RmQybmpYbVRoczA5aG5pTlBUZ1px?=
 =?utf-8?B?eCswQWNTb1NOc0xmcnRvaElXcC96SFV6ZUxsMU5ISzhGZ1FtT2dsVmZBVjJM?=
 =?utf-8?B?RE1QY1Q5NG5JNDh3ZXNSWmFIeXcwUE1ReXBRZGcwL2k5UEtHZkJMdE1KMlBh?=
 =?utf-8?B?Z0JFUXdLbjIreGU5eHoxUmVCRjU3QTd6TVlJRVVrZXVmbGdkaG5YQUZlOElJ?=
 =?utf-8?B?Tk5aWmNlNHBwQy9aTkV5YlBXSGZNa0RQU0M2UURnQkw0YmpscFJTVzNqaS9y?=
 =?utf-8?B?TTBRV3A4M1lMQ3RqakU3VHV1OHhoclQ1YjdqUnhsNU1aQ09VOFkvZG5MWDQr?=
 =?utf-8?B?SWkxMUVyS0dQdXU4MGMzTXd3dFpIMUFwZ0tDNi9VNWtOZnQ3WG5vbVVJVjFJ?=
 =?utf-8?B?dC9lQUlhYU9PY2xnb1dFZ0JYWDIzK2dyWko4S0ZOUytueG5DeTdDQTlrb2tI?=
 =?utf-8?B?RzNkdG9qaFZEdVBYYmtYZm5pY3pKY0xIMjVMU2ZFRUVTbnF3SGltMVQ2T0sx?=
 =?utf-8?B?QjZwZFltZDJ4YkZmOERHeTF4aUNSVlYvelh3NGxnWG1XMkpGVGpxVTRjYVND?=
 =?utf-8?B?aWtjRUtVTmpWMDQwOXVpUTBsWENIeThHMHlOWU92RS92LzBENE94MFBiUDVm?=
 =?utf-8?B?NDBKTC9GSHhoM0hZL1BHRmw0WUxJVWNkNmdIRng3bmw5OEZ2Z1VzRWMrWkd3?=
 =?utf-8?B?dFJZTDZISkJwYmthcnUzUG5QSFdnWWlrRFZXZlpQaXp1UFc3SEh2UXZ2T1V2?=
 =?utf-8?B?NytYalZRMnZMVGhncjYyYklBNDhvVlg2MzZHL1ByS3JUQWZTVTFmZzgzQi9p?=
 =?utf-8?B?N3NaSG55WFhRdXV1N3E2dXd4ZG9Tcnd4aHF5Qjc4T3VNUEgzNjNQWFhhaGRh?=
 =?utf-8?B?TG8rL2orbXFkeldkU0NPNmUxaU5hdmlXdTViTXdhUXNnQlBFTGxFL3dYa1I2?=
 =?utf-8?B?SXJUVDBxcmt4SlcwaFE3STlRSm9RT0g0Sml1SmJLT0lwSVJJYkRPaHNNNDdJ?=
 =?utf-8?B?RVVHOXRIL2tFa2JtTkYyR0IvL2pGSTJET0VOQXZrRDBtcnJOdnViczN2U1BB?=
 =?utf-8?Q?Cu5iuZDaIYFFZ2mvhbAoFWHzabKGRhRkYoilj6u+/tZ6?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F4A5F6421BF10843907F6C5A7272CB43@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB4659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f696f866-3c3b-49d9-7b4b-08da64a1ca42
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jul 2022 07:32:07.1900
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rvoSOe/zSEX+zQf7FiCTCPOFTZf6Og/EjNXE6y8H459pPX9mDbRBuMaiANDz+Lh0Ifb4FsM1Ug/Z59mGXGZm9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5350
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220713_003211_492771_7F67B21C 
X-CRM114-Status: GOOD (  10.61  )
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

T24gNy8xMi8yMiAyMjo0OSwgQ2hyaXN0b3BoIEhlbGx3aWcgd3JvdGU6DQo+IENoZWNrIGZvciBt
dWx0aXBsZSBjb21tYW5kIHNldCBzdXBwb3J0IGVhcmx5IG9uIGFuIGVycm9yIG91dCBpZiBpcw0K
PiBub3Qgc3VwcG9ydGVkIHdoZW4gYSAhTlZNIGNvbW1hbmQgc2V0IG5hbWVzcGFjZSBpcyBmb3Vu
ZC4gIFRoaXMNCj4gcHJlcGFyZXMgZm9yIGFkZGluZyBjb21tYW5kIHNldCBpbmRlcGVuZGVudCBw
YXNzdGhyb3VnaCBzdXBwb3J0Lg0KPiANCj4gU2lnbmVkLW9mZi1ieTogQ2hyaXN0b3BoIEhlbGx3
aWcgPGhjaEBsc3QuZGU+DQo+IC0tLQ0KDQpMb29rcyBnb29kLg0KDQpSZXZpZXdlZC1ieTogQ2hh
aXRhbnlhIEt1bGthcm5pIDxrY2hAbnZpZGlhLmNvbT4NCg0KLWNrDQoNCg0K

