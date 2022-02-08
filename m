Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48CB2C433EF
	for <linux-nvme@archiver.kernel.org>; Tue,  8 Feb 2022 23:21:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=SkU1p6ndnxGs7dOMsnC1cXsYh/EKBSDrNUkiH3mkcdg=; b=Sr+APxxJsVrBWtu7rs1efvY1sS
	O8v53x1tIWU/qbbgfDxgqln463IrieYmPFases7ywrev7G/hmQHkeXZyHMU/N7atPwqzUGB1MjD8W
	HfH3+qSREOeSOHiD/rh3kZpATiaJneiTy2GepJuvHThk12YZnZf8Du+bGbLC8fqgqLWYvrF2PjvVo
	TIAq6m+fs6/9KTt7oF23hENjA5GiwzkNrfo3AdZfcJKAAnepTP1sSN4LjfqfkwKfr60QeQH2THTye
	NoQPlVcVtMYPBGmoZnqjtt0syyYr+tscwCcAyVCLu9c7R91uWzpCsNjK2Nxn/e9KrxFXIJnQXcTMo
	+AARBanA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nHZnb-00FnEu-7z; Tue, 08 Feb 2022 23:21:27 +0000
Received: from mail-mw2nam12on2055.outbound.protection.outlook.com
 ([40.107.244.55] helo=NAM12-MW2-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nHZnY-00FnED-Sd
 for linux-nvme@lists.infradead.org; Tue, 08 Feb 2022 23:21:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nuFt3HkseOKFiC4nAjXrUcmy22LOnlsurNq4E2LDuBFvjLIUcZXZOdxT+VAquUEnt0+3ZA5JXMybDfRwqO+I0JyceebA5bLSn9cpFIDacoQcnwBkThJUEHHh6EgsdRwG11daJ/GQFNWYk1y7mqw3zrGx2qSZJa8awu9Z5o6lL3w5JouH0NYCxq10BHMMI4LdYTxdz0MgPloWNTwy7jzWy8lcmrQDTweRTMsqXEuhSUD3k7I40RGVbWMYYRBXqcLD+PxOXSFL7hK1jcL1pvHiaOxxqBsU5sGDmjZoOSIgV5Kvn9ZpjLExAdxXcOcqiBzLtf1bb1h+QewWg9uke92qFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SkU1p6ndnxGs7dOMsnC1cXsYh/EKBSDrNUkiH3mkcdg=;
 b=grvX7GiN3VrU8OmRsGuzkYHoX6jv7GpY0YhUSlM8pNLhsbvy7crF9+L7ZNLRR3EXTCsGDMoI0m/mRhVEDY6bhYafr2evbD1S8yIG+gCookoMZ4AHxUfa85jFhDLDKhkZp+ZqHsat6f6NO+kayJSqDIZ3H/uXSDIOWZ5NP+iHNW5rH5sPV/6cYUeurGwMGIZ6ue8W+Ad1NJ+0vC1p6Qt9/7pKcAH1gn+Xi+2exiQk4SUz/QXA8519EYXgaVBs2VMxsY2EE0TObkHyE76riRtxh9q7RgtHwvtrmdOvL/HOFhypG9NByjw7P9APGHU55faXGoINeKaJeaivLAu4We7eXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SkU1p6ndnxGs7dOMsnC1cXsYh/EKBSDrNUkiH3mkcdg=;
 b=e6OWdIAR5gCgK04lPIPADTmMRYfsiDTdAXaV4C+1EepO8RoVhg1iFhIHBQpbhIQumzJYthSbWKiK37HgcdVZGETbJkv5q7xQ3OxjmeLxr1DODuGzcEwFeP9mLA3N8Soa3m4n8Uprk1dqMeYLYe+Jlg/oasMY4YH+a6tWXHLtlUz1rP8NSBHw6XaG+f6ACNTa8f3EKVNoswzRZQRDLs2TaN+XDzz2ke7sXIs4szws2AQ340mBqf1sIAxKfHGZJD1We3uHcCflxGm8hESDZ0I5lJI6zlvk4/kBEO3bQAQ8SnNKwv7Xivvqo6JUnFIYlVvR46jVPNVyAKUDuMPoKCsSxg==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by BY5PR12MB4033.namprd12.prod.outlook.com (2603:10b6:a03:213::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Tue, 8 Feb
 2022 23:21:22 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::846c:d3cd:5a30:c35]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::846c:d3cd:5a30:c35%5]) with mapi id 15.20.4951.019; Tue, 8 Feb 2022
 23:21:22 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Martin Belanger <nitram_67@hotmail.com>
CC: "kbusch@kernel.org" <kbusch@kernel.org>, "hare@suse.de" <hare@suse.de>,
 "axboe@fb.com" <axboe@fb.com>, "hch@lst.de" <hch@lst.de>, "sagi@grimberg.me"
 <sagi@grimberg.me>, "stuart_hayes@dell.com" <stuart_hayes@dell.com>,
 "charles_rose@dell.com" <charles_rose@dell.com>, Martin Belanger
 <martin.belanger@dell.com>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>
Subject: Re: [PATCHv3 2/2] nvme: Expose cntrltype and dctype through sysfs
Thread-Topic: [PATCHv3 2/2] nvme: Expose cntrltype and dctype through sysfs
Thread-Index: AQHYHSM49++cF75LEUW3CdjmyS9B4ayKSuQA
Date: Tue, 8 Feb 2022 23:21:22 +0000
Message-ID: <890f6817-7880-79cd-3651-2f91e4454e28@nvidia.com>
References: <20220208193346.22580-1-nitram_67@hotmail.com>
 <BL0PR13MB4291B3A6C98BA5EB5ACD8A129C2D9@BL0PR13MB4291.namprd13.prod.outlook.com>
In-Reply-To: <BL0PR13MB4291B3A6C98BA5EB5ACD8A129C2D9@BL0PR13MB4291.namprd13.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a90f7bb0-9b05-4312-f474-08d9eb59b867
x-ms-traffictypediagnostic: BY5PR12MB4033:EE_
x-microsoft-antispam-prvs: <BY5PR12MB403311C363776CE987A6C234A32D9@BY5PR12MB4033.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2201;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: McBETHfEMy5VXW5n3pi4JJBmBsbv1Vl1hht6IT/qyCHv90WX6QbZGTPb2sm53Jr+Av1aFZepXwD7zRyhBWw/9omHSWvRJomcJamSYetdFBa/yVmK2d3C9/60N2uVN/GKn5qb13HSMtcK5EnEB77IsBFwCVGQW2J8nZ2Hkov+9HSVfLDDOtuPMUpoblFlKFEGevgdzd8Y690NI6kMg0AJRZQsRezlkn/4WYRLup2UkFSYtCk4KTByATtBZXK6jYmKkmFlLFWV5Awj+ojhgzUjwkt4Cy603jEHe0rAbl6mvDjHueZinU5q2hqjdgZJz1P6KAkYegVOWSkAxjMckXu8gRQA5HEtdTiktR6bP2ddlh1XqlT42aocRgRBGzQFo1WkcSMF/SCp47njADpTnI4nkXPSxyShU2C4RY6m46MDEKjXnaMKDCRM8dBamfoIWZExqkVUyr76v7eYVkSEQnB75erZGaJuj+XQKnKKPXkRWZPtXF5+Ds0a2ZcKsttwbXRPjxt8TvRPLSGlgcQXhxJ5atwL8WsZjRJBT5N4lGFVQ1xLAMQ8mKfRryOfFhcf4XfsOfV4HM93qlqZLua2nOvjukBsVdld0FIm+aHQBD+nmJqJoybYAHCjWRtQ1YN8u7QBsp5oLCa0UIs3dgEedKTuN2JgZ8WVR+hCWqgB6VKeyPINgKJBNDgsCu+e1DzunCBaahtVMgsOqNQpxZgQgtIkVGTwGY9Ikn0My7VHHChM8gJdU5tD/+LXd1gGBk4Pxtq5l9crTQwZSJggsyakr7bmtQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW2PR12MB4667.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(8936002)(38100700002)(66476007)(66556008)(76116006)(4326008)(8676002)(64756008)(83380400001)(36756003)(54906003)(6486002)(5660300002)(91956017)(7416002)(66946007)(31686004)(508600001)(6512007)(6506007)(316002)(2906002)(6916009)(122000001)(2616005)(31696002)(86362001)(66446008)(38070700005)(186003)(71200400001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SXA0cWk4L2hnRlRnbzhCRnFyWVZaekZtcUZPNkZtblNlclE3STNBN3FYMk9l?=
 =?utf-8?B?eUFsUy84WUF3TjBlNXprZmltalpjTVFnSXgxODVmLzZsK1QzZjNVLzBoNHh5?=
 =?utf-8?B?bmVEY0UrMlYvRmtrWjNxaHlpTFU3dHcxbFhUbVZTMWJxbUkwMDNCS0J3Z2Vo?=
 =?utf-8?B?TVc4aWZ6WTREeXZocDNjOWFUb0IvNDZ6Mkx3YmF1aHlJaXptLzltWWtRNlNI?=
 =?utf-8?B?aGJ5VkdFNGRaVDE0V2xSUEdKeXd3SnNzM2xtdFUzQXVPd01oZW9uWEdMWUVD?=
 =?utf-8?B?REFhdWZCSEc1b2RETnRnRnArUVdiSitMV3JCRWFkZitqYVFIeVZKNkRPQTRx?=
 =?utf-8?B?eVFMU2JnaUFaTEt4UUxMcmJ3QUM1azFmVzhoRGozV2RVZTRWNkhCNVlJdUNu?=
 =?utf-8?B?cUJKN3NlQjdpVytJRHJFZ2V6UzkyYmVxL0hzeWdrUTBGbUFJUm1iOFlDSUtB?=
 =?utf-8?B?WFFacXFnM251WGZNenlQdzNFN3ZkV21FSU1oN1BWZFNYdGlSYzBYZG9qM0ly?=
 =?utf-8?B?SGRTejNnR2kxZ1Y5SjdpSDYxQ0dDeGZueS9ENTZvV3BOcFpVUzA1YlRuU0Mx?=
 =?utf-8?B?VmQzWlN2VWZPTExSd0FKUmU1NkROdU82dDVmSVNDMXNFeXhtTzNickh6bWww?=
 =?utf-8?B?SXJLZVUyMTZvdGYrRWo5eTRNa3JqY2ZQaXRGV05maExBWmpEWHdrTU1jcDMw?=
 =?utf-8?B?WWVOODFTU1lwN0k0TzJNcXArbnUzMTdvRkpJQUUvS1l1ZzVJcW5ZdWVNRXhD?=
 =?utf-8?B?NWllQkpsbEJOWmpRRVVaQWxwYnFTYmgyV2JxVU84YVU0NElZbTBlSm02UFFr?=
 =?utf-8?B?WUZvYlZNdGI3cktsUGxodG9mRGJjYWFieEVFRWsvVDRzTk1BMEhsYXIrUURM?=
 =?utf-8?B?RDJnYmd1YUhhVGpnbnVmLzV4VkdnZWpKV2V3cENYZ2YrNmtEOVYrZ2ZXdVht?=
 =?utf-8?B?SkhleEVqb2lzNjlLTC9rSnBBUERJOFpUY0hGVTR6QTZ1QXFCRUkzS2FFc1BX?=
 =?utf-8?B?bktNVngxRzhxKzdSVlJKZ1lCbGlUWTk2UjNtYmI2cWZMbk4zTExCR0IrR21N?=
 =?utf-8?B?akxDWDZWa3ZuQm5tL2FMUk1Gc0EzelhDeGtJUWJFd0Y3R2VGaFd4cHA5TEZn?=
 =?utf-8?B?ei9ZNExhaHBFaUZKMVdWbGFha3VObjlyRW1saVhXQVdaTmQ0TVBQOGpDZ2tP?=
 =?utf-8?B?bEhWWTFVeWdrM0NMN3hqdFh2cVBBUkNSc0lzY1ZTSWdXMGJKeTVpRW9uOXh4?=
 =?utf-8?B?TzBObzdYWnpXZXlzeVlBRkRaZTJndHBNeU5LYUFJN0RTVzl4emd4Q3FRNzcx?=
 =?utf-8?B?WVFFaGhueTFTVEYrOWZRNzZlQk9kL3o2WWtLV3ZrcENVek1IeWFBMUY5MFpF?=
 =?utf-8?B?V3ZkVUpkK09KbEV2Tit6NUMrdW5nY2FlSlZ1cWx0YlBEVHU2aFpTaFBBMGY3?=
 =?utf-8?B?dVdVTUNiY0JHYkVlTzh5TktSaHZTd2xKSjk3NWJCa0V0bkYwSU94blBscEJl?=
 =?utf-8?B?RkhUazFlK0dHb1JlUnRCa2p2cFNZUWJsU3pqS3VjUE84ajFneDBBVGdRZksr?=
 =?utf-8?B?eE5NN05WTnNGbXNibWVWVWJEbm55VlRoOUhxMksxRjFuc0dsc3RQS1lNd25D?=
 =?utf-8?B?ZWFzZDVJd2NzZHNTT29VRnVYRTVXWWVza0Ntc21xSitMcmhFZUZhcnJaTWc4?=
 =?utf-8?B?NkcycmxTL0F1Y1NYelVyREoyZlc1dzcrOFNRbmdBS0pUandKMGJGU0dFSVZj?=
 =?utf-8?B?dVQvaFJvQnI3S3JnZUk1OFJNSWN4SzYydWIvb1R4RXNZNkVJaEg3TlQreHY0?=
 =?utf-8?B?bG90dmRtd2dsWnhsUTZyS3FuQnlJRWVHK3VGYzVMWXBPc25mRlY4NTBheTlT?=
 =?utf-8?B?MFlUVmpaRjJIbmtFMWRpY1dGYlRxVGN5Y0dEOVpiK0NhU1hnQ3FDcWNXNmVJ?=
 =?utf-8?B?dHV6R0tkTmlGbkpaZG1JWEkrVkpCdmhOR09pVHJiOEE5Y3JTN0NxRk9jaGo2?=
 =?utf-8?B?V0VpalNNNEc4ZTZxd1U2NzdrVzdDRmFzUTZWZUJnN0RjdzBLMVJyZEkzM2ZI?=
 =?utf-8?B?QzBkOVNXTTBadHcxdGdySUVYcTNwcUtQOUdPQzlGVzFaUlB1RytOVE1kTXJC?=
 =?utf-8?B?WnJXV2ZhTC9ENXArVUl5Vm9ZZmRHQkRMdEV5WDRNLzg2blpISC9zbk9FcUZt?=
 =?utf-8?Q?bJiBBfbLTjaGvmmdihwm22GHcIlOTYngF9cDqTWVV3NL?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BAEDDF15AE292445AD78CE2C63434AE7@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a90f7bb0-9b05-4312-f474-08d9eb59b867
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Feb 2022 23:21:22.6823 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: d3hvkZ0f+yRq3NAy24s+iqGqxop1i13jnb5XQJkl7eidAjhWMSKaRh9tcU+1vU0wT2Okh9/dEN8iVURYu/MPfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4033
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220208_152124_956063_3188E7F1 
X-CRM114-Status: GOOD (  15.48  )
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

DQo+ICtzdGF0aWMgc3NpemVfdCBjbnRybHR5cGVfc2hvdyhzdHJ1Y3QgZGV2aWNlICpkZXYsDQo+
ICsJCQkgICAgICBzdHJ1Y3QgZGV2aWNlX2F0dHJpYnV0ZSAqYXR0ciwgY2hhciAqYnVmKQ0KPiAr
ew0KPiArCXN0YXRpYyBjb25zdCBjaGFyICogY29uc3QgdHlwZVtdID0gew0KDQpuaXQ6LSBzdGF0
aWMgY29zdCBjaGFyICpjb25zdCB0eXBlW10gLi4uDQoNCj4gKwkJW05WTUVfQ1RSTF9JT10gPSAi
aW9cbiIsDQo+ICsJCVtOVk1FX0NUUkxfRElTQ10gPSAiZGlzY292ZXJ5XG4iLA0KPiArCQlbTlZN
RV9DVFJMX0FETUlOXSA9ICJhZG1pblxuIiwNCj4gKwl9Ow0KPiArCXN0cnVjdCBudm1lX2N0cmwg
KmN0cmwgPSBkZXZfZ2V0X2RydmRhdGEoZGV2KTsNCj4gKw0KPiArCWlmIChjdHJsLT5jbnRybHR5
cGUgPiBOVk1FX0NUUkxfQURNSU4gfHwgIXR5cGVbY3RybC0+Y250cmx0eXBlXSkNCj4gKwkJcmV0
dXJuIHN5c2ZzX2VtaXQoYnVmLCAicmVzZXJ2ZWRcbiIpOw0KPiArDQo+ICsJcmV0dXJuIHN5c2Zz
X2VtaXQoYnVmLCB0eXBlW2N0cmwtPmNudHJsdHlwZV0pOw0KPiArfQ0KPiArc3RhdGljIERFVklD
RV9BVFRSX1JPKGNudHJsdHlwZSk7DQo+ICsNCj4gK3N0YXRpYyBzc2l6ZV90IGRjdHlwZV9zaG93
KHN0cnVjdCBkZXZpY2UgKmRldiwNCj4gKwkJCSAgIHN0cnVjdCBkZXZpY2VfYXR0cmlidXRlICph
dHRyLCBjaGFyICpidWYpDQo+ICt7DQo+ICsJc3RhdGljIGNvbnN0IGNoYXIgKiBjb25zdCB0eXBl
W10gPSB7DQoNCm5pdDotIHN0YXRpYyBjb3N0IGNoYXIgKmNvbnN0IHR5cGVwW10gLi4uDQoNCj4g
KwkJW05WTUVfRENUWVBFX05PVF9SRVBPUlRFRF0gPSAibm9uZVxuIiwNCj4gKwkJW05WTUVfRENU
WVBFX0REQ10gPSAiZGRjXG4iLA0KPiArCQlbTlZNRV9EQ1RZUEVfQ0RDXSA9ICJjZGNcbiIsDQo+
ICsJfTsNCj4gKwlzdHJ1Y3QgbnZtZV9jdHJsICpjdHJsID0gZGV2X2dldF9kcnZkYXRhKGRldik7
DQo+ICsNCj4gKwlpZiAoY3RybC0+ZGN0eXBlID4gTlZNRV9EQ1RZUEVfQ0RDIHx8ICF0eXBlW2N0
cmwtPmRjdHlwZV0pDQo+ICsJCXJldHVybiBzeXNmc19lbWl0KGJ1ZiwgInJlc2VydmVkXG4iKTsN
Cj4gKw0KPiArCXJldHVybiBzeXNmc19lbWl0KGJ1ZiwgdHlwZVtjdHJsLT5kY3R5cGVdKTsNCj4g
K30NCj4gK3N0YXRpYyBERVZJQ0VfQVRUUl9STyhkY3R5cGUpOw0KPiArDQo+ICAgc3RhdGljIHN0
cnVjdCBhdHRyaWJ1dGUgKm52bWVfZGV2X2F0dHJzW10gPSB7DQo+ICAgCSZkZXZfYXR0cl9yZXNl
dF9jb250cm9sbGVyLmF0dHIsDQo+ICAgCSZkZXZfYXR0cl9yZXNjYW5fY29udHJvbGxlci5hdHRy
LA0KPiBAQCAtMzU0NCw2ICszNTgxLDggQEAgc3RhdGljIHN0cnVjdCBhdHRyaWJ1dGUgKm52bWVf
ZGV2X2F0dHJzW10gPSB7DQo+ICAgCSZkZXZfYXR0cl9yZWNvbm5lY3RfZGVsYXkuYXR0ciwNCj4g
ICAJJmRldl9hdHRyX2Zhc3RfaW9fZmFpbF90bW8uYXR0ciwNCj4gICAJJmRldl9hdHRyX2thdG8u
YXR0ciwNCj4gKwkmZGV2X2F0dHJfY250cmx0eXBlLmF0dHIsDQo+ICsJJmRldl9hdHRyX2RjdHlw
ZS5hdHRyLA0KPiAgIAlOVUxMDQo+ICAgfTsNCj4gICANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMv
bnZtZS9ob3N0L252bWUuaCBiL2RyaXZlcnMvbnZtZS9ob3N0L252bWUuaA0KPiBpbmRleCBhMTYy
ZjZjNmRhNmUuLmUzMDYyNmMwMDc5MSAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9udm1lL2hvc3Qv
bnZtZS5oDQo+ICsrKyBiL2RyaXZlcnMvbnZtZS9ob3N0L252bWUuaA0KPiBAQCAtMzQ5LDYgKzM0
OSw5IEBAIHN0cnVjdCBudm1lX2N0cmwgew0KPiAgIAl1bnNpZ25lZCBsb25nIGRpc2NhcmRfcGFn
ZV9idXN5Ow0KPiAgIA0KPiAgIAlzdHJ1Y3QgbnZtZV9mYXVsdF9pbmplY3QgZmF1bHRfaW5qZWN0
Ow0KPiArDQo+ICsJZW51bSBudm1lX2N0cmxfdHlwZSBjbnRybHR5cGU7DQo+ICsJZW51bSBudm1l
X2RjdHlwZSBkY3R5cGU7DQo+ICAgfTsNCj4gICANCj4gICBlbnVtIG52bWVfaW9wb2xpY3kgew0K
PiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC9udm1lLmggYi9pbmNsdWRlL2xpbnV4L252bWUu
aA0KPiBpbmRleCA4NTVkZDliM2U4NGIuLjIxZTkyZTk3Y2E4OCAxMDA2NDQNCj4gLS0tIGEvaW5j
bHVkZS9saW51eC9udm1lLmgNCj4gKysrIGIvaW5jbHVkZS9saW51eC9udm1lLmgNCj4gQEAgLTQz
LDYgKzQzLDEyIEBAIGVudW0gbnZtZV9jdHJsX3R5cGUgew0KPiAgIAlOVk1FX0NUUkxfQURNSU4J
PSAzLAkJLyogQWRtaW5pc3RyYXRpdmUgY29udHJvbGxlciAqLw0KPiAgIH07DQo+ICAgDQo+ICtl
bnVtIG52bWVfZGN0eXBlIHsNCj4gKwlOVk1FX0RDVFlQRV9OT1RfUkVQT1JURUQJPSAwLA0KPiAr
CU5WTUVfRENUWVBFX0REQwkJCT0gMSwgLyogRGlyZWN0IERpc2NvdmVyeSBDb250cm9sbGVyICov
DQo+ICsJTlZNRV9EQ1RZUEVfQ0RDCQkJPSAyLCAvKiBDZW50cmFsIERpc2NvdmVyeSBDb250cm9s
bGVyICovDQo+ICt9Ow0KPiArDQo+ICAgLyogQWRkcmVzcyBGYW1pbHkgY29kZXMgZm9yIERpc2Nv
dmVyeSBMb2cgUGFnZSBlbnRyeSBBRFJGQU0gZmllbGQgKi8NCj4gICBlbnVtIHsNCj4gICAJTlZN
Rl9BRERSX0ZBTUlMWV9QQ0kJPSAwLAkvKiBQQ0llICovDQo+IEBAIC0zMjAsNyArMzI2LDkgQEAg
c3RydWN0IG52bWVfaWRfY3RybCB7DQo+ICAgCV9fbGUxNgkJCWljZG9mZjsNCj4gICAJX191OAkJ
CWN0cmF0dHI7DQo+ICAgCV9fdTgJCQltc2RiZDsNCj4gLQlfX3U4CQkJcnN2ZDE4MDRbMjQ0XTsN
Cj4gKwlfX3U4CQkJcnN2ZDE4MDRbMl07DQo+ICsJX191OAkJCWRjdHlwZTsNCj4gKwlfX3U4CQkJ
cnN2ZDE4MDdbMjQxXTsNCj4gICAJc3RydWN0IG52bWVfaWRfcG93ZXJfc3RhdGUJcHNkWzMyXTsN
Cj4gICAJX191OAkJCXZzWzEwMjRdOw0KPiAgIH07DQo+IA0KDQo=

