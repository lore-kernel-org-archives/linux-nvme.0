Return-Path: <SRS0=w6YM=OR=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B867FC433F5
	for <linux-nvme@archiver.kernel.org>; Mon, 27 Sep 2021 19:19:57 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7910D60EFD
	for <linux-nvme@archiver.kernel.org>; Mon, 27 Sep 2021 19:19:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 7910D60EFD
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:To:From:Reply-To:Cc:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=PKOPJvLZ7It4DV0BQdzniZJhhgtvqpSYdcllaQuEgxo=; b=DuWITG2e6odZtS
	HQCl/NDZjBRNRsFKx51WHbBUn2IkA6Jld5ReQocBW1FY+P2UciO1tw/xzlGH5CtPyyMMHRpq65hsg
	Ln17xPqMw1uoq3cmLJ/rUO/hV6dRApEF1YIKCHthnO8nQP1T5pDn1N4etjwUmKGIRWd2/gDdIWWgn
	/VNFDw6Q2JE97svXfXHxsSGy6+dlZsFiwK8uxzWN20v7+pz5eTvrlylSpPK+jgXLWEOm8quG05AxG
	aamyXLe02+Qg0gKb9TAOi8iX67DUiQWKPdX5Z7KnMq8ddWecbpqkQCyRoaPLGeB5DO/tk3/X4domP
	Ak0x4growYs1uO+YCjZw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mUw9c-003y7Z-Mc; Mon, 27 Sep 2021 19:19:08 +0000
Received: from mail-bn7nam10on2081.outbound.protection.outlook.com
 ([40.107.92.81] helo=NAM10-BN7-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mUw9Z-003y68-8n
 for linux-nvme@lists.infradead.org; Mon, 27 Sep 2021 19:19:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hKfmB6k6BhilyYyYsXTFNVwx48wsRRRZK/bTk3vfXQmf707ghoxU3Cv72B6GgzRPEiYmAKc7ervvBqNynFbF03ma0TNEhvHee1RNE0Omhm6BXRfnkevjxoGK+GeoI3vHP60j+D8bxFXXCGJKLCCi2/Zh9QDh2hR5pzmoUY4nFsQWok0hDeEcULu1WjGuk6zASexjN/XdFyKQWcQq6iLlVqvMsjKjN50pMPoRKZZDInIvxw8RdMmDHCrAcq7C1Z/oojUlEikC2bwyCYifPUpWSW9TU35Bp3Nwh149tIXD7sZcUSbiqzDqkHsEYaleJ23LM6/cc43S/DbZQRneAQmg2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=qdLB4mXAvv0ARt9lgm5cIp29k6DDtEf/3Z7vcBF7K9E=;
 b=ezIqEoJb3yqIftTh7SlZOQOD0p8Dnnxw0UnJq8S8igK1NMCxSCmlvGF3GnDOWG48lEflRnXk9BQ5RvPoW4PsqbH26ybb0hdAwJevysFF0uaYwyY1bGu8lTMOrd2d5eHboTRRaIDUzCWsIwbTAMSGYoj0E8ku/E/QvDzAkHOJcTOxHPEfpkjmpXxcJty1JcSUqsHidCSJgYmIWJW+ahJJ8sRFc1v5tc82bN6U747WJgHu96GQySjdjTQCiPmtiHYxlRhHkjm0IotsJzGtp1FdzVJ44q9YWXPz0g2KXRzMbDZ7BF1LWYfv6fxAl1dQ62zTQ5bn6vLhshIDgdAlIVJHrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qdLB4mXAvv0ARt9lgm5cIp29k6DDtEf/3Z7vcBF7K9E=;
 b=T1/++mRJVERqspxA3GcpADLxW4J2Qps8ZXxyqP+HTdwJlZmZRXwI32XxmaUnai/PZafzCJVkxixdvFOuJRvUYNKsFkxbeiYHzmT96Rsr76wEtIwAQxIiS0iE1nIdi98sptQlI7c6ap/Ktk5g5YK6Xs8PJjvzCDLEBXnWZSPDd43JFLxDKl7+PFaTEkmsLDja3IbFtei1SeL8XSRJUDXnaYxReEs/NgF+XlVDoXKwdIUTSaTJCSzYGugq7vsXx4O5HB8v2ZB/RHeACOrgEJ1h5TcP2L7aRS1gcsQcQHhSvPZSd2uS8kqF96N6vqgQDE2KK36X0CE1nRgPsV97qM+f2w==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by MW3PR12MB4539.namprd12.prod.outlook.com (2603:10b6:303:59::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.14; Mon, 27 Sep
 2021 19:19:01 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::498a:4620:df52:2e9f]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::498a:4620:df52:2e9f%5]) with mapi id 15.20.4544.021; Mon, 27 Sep 2021
 19:19:01 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Max Gurtovoy <mgurtovoy@nvidia.com>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>, "hch@lst.de" <hch@lst.de>,
 "kbusch@kernel.org" <kbusch@kernel.org>, "sagi@grimberg.me"
 <sagi@grimberg.me>
Subject: Re: [PATCH 2/2] nvmet: use macro definitions for setting cmic value
Thread-Topic: [PATCH 2/2] nvmet: use macro definitions for setting cmic value
Thread-Index: AQHXsGRFz0+97tHOfU+EfUYbUNHLmqux3ckAgAAoygCABkGygA==
Date: Mon, 27 Sep 2021 19:19:01 +0000
Message-ID: <171cb5cc-cdf6-ef3c-536c-969d510a1013@nvidia.com>
References: <20210923101744.4204-1-mgurtovoy@nvidia.com>
 <20210923101744.4204-2-mgurtovoy@nvidia.com>
 <a6381c90-4eef-a9e1-2156-9f7539f169ea@nvidia.com>
 <3475a373-0cb4-b9b7-2da1-580505dee29a@nvidia.com>
In-Reply-To: <3475a373-0cb4-b9b7-2da1-580505dee29a@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
authentication-results: nvidia.com; dkim=none (message not signed)
 header.d=none;nvidia.com; dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a2d73d86-5cd2-4f24-7ca3-08d981eba9f6
x-ms-traffictypediagnostic: MW3PR12MB4539:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MW3PR12MB4539935BE780CAF0BD4B2803A3A79@MW3PR12MB4539.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: d/HIpbA9gjwZZuleLS1lIYzZoakWhiI46vhT+bRqtfXF+W8PoyTIVwQ7EIdLXrmr8pnhMnV7fBGsWmIIgex5YGZrmuOZMlJyu7Ae6nR0g4WFFZ2UeHYfwPaPOBnS6o78cyY9OGHPdi+8KCB/LlHRiZzGVtcDeGKMDv0+rbaGUywcMwlAjGBoyFPyrALxt/0dsSQijaY6KRCY5xPiA2bjNHk5HfHYNj1Wp3j9bcnIhdhB0IeJktd1ufhqFd8+ja8woRFrjbPSWAG/pvFrlnr+4bg5uCnbIBUZVBdn3WZiL0M5RvEA1/az4KSHWA5f/xck6hssMB3ccSTIk5hxGzh516Vx5ZvaGt2Qx5Vmj21CtpHpnubVkZ1jBJAzurZD9lFgjhn0xyE3fnqeR5XhV9Myti99ZV5XsVKuuCqczNquucnVaGkbTwRwR7/fT7O/lcRC+GZmjldBgcBmzWCT8B0qtGt+Q33Mz/u0cyDkhs8tXFZe+W6MwEddiy34IiltcVl6B0TYbp2v/ktwaxOxLhBCp4RXgzkKlW+5i02gmw6LluYb9G1a8A2wOOLDLW4VjiW/afe4/1Sc7e2kFti/bgWSLGD61maTxfdDIhuL/kG5FP83WyFiC1b+vKJlG71AC4UKBFmcM5fS+zJM8n9a9MPo4NF6WMPjY2nqAxO7UWg+AMb4XNvaMTItUtQ1cbY2fKD1XJDF+crf45shkI8dLhuC9vTbmvpWxpTdkM5Qdb2Be+FO+5+F22heF8Tp+fQ7NFTP/7pBfdxzh1kWe7Rc7ZsctQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW2PR12MB4667.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(316002)(8676002)(76116006)(31696002)(6512007)(91956017)(36756003)(6506007)(122000001)(6486002)(110136005)(186003)(38100700002)(31686004)(2616005)(5660300002)(83380400001)(66476007)(66556008)(38070700005)(8936002)(71200400001)(2906002)(64756008)(66446008)(26005)(86362001)(508600001)(66946007)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RjJIYWgrSkk0WDhUNGgwSHRsQlM2MitOYVFyMkNYTDZ6czZXUkhBV0NtMHdh?=
 =?utf-8?B?ajdnSjdhWlRaNWdLamVPK0J6aVU4U0tLTUk5TGdueXdVNytad0ovYStJaE5X?=
 =?utf-8?B?TnVRNHM4b1RxYVRhM3paaHVadTFFc3YzWlZpYmtUdXpkV3I5MlB3L25VaC9r?=
 =?utf-8?B?WGVtYlcyc1BtYnhOYlB3L00xcDFjYS9Nc0E2bDlKRTM0NWxwQ1JDNWRyZHBK?=
 =?utf-8?B?cjJPeFZOd0s5ajVweWFGUm55S1FoR0VhWUpMM3lRMU92OFBtMTZXMEsvR1ky?=
 =?utf-8?B?K25Dd0EyTiswWEhsMmVJOFcrN3Vhc2RKMUwvaVcwSU5vT2FKUVRDK0Y3Rzh5?=
 =?utf-8?B?RWUwUkZ1cWMvRVRhcEI5RTRjSWliN1lwR1pQc3dId0hIeVRKdzRZSE5LdXpI?=
 =?utf-8?B?RHlhZG1LbTRJYTh6UExXaVVTRkhCZERYaHo0SjNrTVh1TWM0OU1GMFZXUVQ2?=
 =?utf-8?B?aHQwRGlMZDZoSlE0MGFYRE5RYUZUT1l3ZnBTZHIrOVpQekdYQWpHcldUNm5r?=
 =?utf-8?B?eWNTWHprWHV5OWxHZkcyeXVVUUo2Y3pBKzhjcGVhc3RsclVFdC9YLzRsbUdz?=
 =?utf-8?B?cmgvYmRnL0wzOGRDeG1QOWdBckVuY01yTFZIMEJvNHQ1cG85bzMrOWM1RGVm?=
 =?utf-8?B?YVo4cFlBZWo4ZTRDbWZUeWRYMU5LNWtaVUtrMHNzZVlEY2hVQmw4UGY5T2VX?=
 =?utf-8?B?VEpqcWVSemJDeHkvdVVUbG1iTHYyb3lpUm90YWt4dTNTT0lUbnBXdnVqK3hj?=
 =?utf-8?B?UWRzWmpqZm5JQ1JLK3llNWo3ZjE2S09scEFnYXo5SEhtenJEejc0ZFo2eVZU?=
 =?utf-8?B?S214bFFISzRYWXBhbEhTdW4rY2hRQTdZQ1dtU0Q1N0pyS3crazFiWlMyWDFX?=
 =?utf-8?B?OVhyWTJxcGhPWUJsWnVrSkdPdG9paWRnMW5EWVEvRU1aajBrV2F1NUxSZWRw?=
 =?utf-8?B?Y001SnZFelYwWGh2YW13T0c5SlFnU3NQaEtGR1hyY3NoYXZiV20ybTBuVENx?=
 =?utf-8?B?QVo0K2M5anEwZmRZTUt4N1NkY0cyRzhhdU5WdkJXSGw0cGQ2eEVGTFFJZHR5?=
 =?utf-8?B?SXpXYnRLcHNpTGsyY2JvZEM4QnhVMm16VVFwR1BSZVliaWo4NkM0WVJQQzZJ?=
 =?utf-8?B?V09KVWFYeGYvYjRGVEtKS2xENVJqMnRDVUVKWlExN0xJTy9FdnpHNGYwYjRX?=
 =?utf-8?B?Q1VIbkhnM2Z2bE8wVDFwK1BvM3BVVlFRdzErZEVVVVJBUkpTY04xWWZDajgx?=
 =?utf-8?B?akhlS0xUNUFyL2JuM1JiZXRQT0ZMM3RXbjQ5TlA1aWhRYVZRY25Id1ZNV0ZE?=
 =?utf-8?B?Sk9ZbHMrK0RKQlYvQ1FqYmdRTVFiaENyeU9CNzEwQUQvekNrUVR0R1VsWEE5?=
 =?utf-8?B?RzJOTFY0eHZETk9ObUFqdW04QlVmNEhTN2crWlFqNExsYTIyZHJjdDJuS3o2?=
 =?utf-8?B?MHZBTGhrQ0g4NUxIVnhuNWVtVTVyejVmbjFNaUJkRXdUT3NVZjg3L0E1Z2ZJ?=
 =?utf-8?B?d2JrU2tNalExWEV0cndFOHFOb0NwaVhyNFByT1BGQTJVNHZxejBscFVTa3d4?=
 =?utf-8?B?RlpyaHd0V3g4MnpmUHdQdDJnMDN1d2F5SVVobWFpSkF5SFNKa0lON1dkR3dK?=
 =?utf-8?B?WGxCNDVDczFIdFdnYklTYjNwZXZlK0ZRSEJCUFpqUFJUL3JkdUtHdjl0UDNn?=
 =?utf-8?B?dVB0cG81bXJhb1dHekRHVGhnSHhQYStWNm9KcUxESTRZcjllV3FaUExlWWtY?=
 =?utf-8?Q?Cyy13acelGgZR28GouP/SP8brUndstWWQ8K657p?=
Content-ID: <E69214C41D3D4B4C936B96B80D40662C@namprd12.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2d73d86-5cd2-4f24-7ca3-08d981eba9f6
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Sep 2021 19:19:01.7457 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6U34aiB5ByuxQ8u45wZ/Boo7VifTGtC32+EAHescuox/iFaPjzL/U9aWkTSTAqGtyNucq+2iImhTcJWsabnelw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4539
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210927_121905_354549_7E98C852 
X-CRM114-Status: GOOD (  16.84  )
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Pj4+IFRoaXMgbWFrZXMgdGhlIGNvZGUgbW9yZSByZWFkYWJsZS4NCj4+Pg0KPj4+IFNpZ25lZC1v
ZmYtYnk6IE1heCBHdXJ0b3ZveSA8bWd1cnRvdm95QG52aWRpYS5jb20+DQo+Pj4gLS0tDQo+Pj4g
wqDCoCBkcml2ZXJzL252bWUvdGFyZ2V0L2FkbWluLWNtZC5jIHwgMyArKy0NCj4+PiDCoMKgIGlu
Y2x1ZGUvbGludXgvbnZtZS5owqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8IDEgKw0KPj4+IMKgwqAg
MiBmaWxlcyBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4+Pg0KPj4+
IGRpZmYgLS1naXQgYS9kcml2ZXJzL252bWUvdGFyZ2V0L2FkbWluLWNtZC5jIA0KPj4+IGIvZHJp
dmVycy9udm1lL3RhcmdldC9hZG1pbi1jbWQuYw0KPj4+IGluZGV4IDRlZTlmZTEzNDY5Ny4uOTJk
ODFkYzU5MDZiIDEwMDY0NA0KPj4+IC0tLSBhL2RyaXZlcnMvbnZtZS90YXJnZXQvYWRtaW4tY21k
LmMNCj4+PiArKysgYi9kcml2ZXJzL252bWUvdGFyZ2V0L2FkbWluLWNtZC5jDQo+Pj4gQEAgLTM4
MCw3ICszODAsOCBAQCBzdGF0aWMgdm9pZCBudm1ldF9leGVjdXRlX2lkZW50aWZ5X2N0cmwoc3Ry
dWN0IA0KPj4+IG52bWV0X3JlcSAqcmVxKQ0KPj4+IMKgwqDCoMKgwqDCoMKgICovDQo+Pj4gwqDC
oMKgwqDCoMKgIC8qIHdlIHN1cHBvcnQgbXVsdGlwbGUgcG9ydHMsIG11bHRpcGxlcyBob3N0cyBh
bmQgQU5BOiAqLw0KPj4+IC3CoMKgwqAgaWQtPmNtaWMgPSAoMSA8PCAwKSB8ICgxIDw8IDEpIHwg
KDEgPDwgMyk7DQo+Pj4gK8KgwqDCoCBpZC0+Y21pYyA9IE5WTUVfQ1RSTF9DTUlDX01VTFRJX1BP
UlQgfCBOVk1FX0NUUkxfQ01JQ19NVUxUSV9DVFJMIHwNCj4+PiArwqDCoMKgwqDCoMKgwqAgTlZN
RV9DVFJMX0NNSUNfQU5BOw0KPj4+DQo+PiBTbyB3ZSBhY3R1YWxseSBoYWQgdGhpcyBkaXNjdXNz
aW9uIGJlZm9yZSB0byBrZWVwIGl0IG9wZW4gY29kZWQuDQo+Pg0KPj4gSWYgSSByZW1lbWJlciBL
ZWl0aCBoYWQgYWxyZWFkeSBzZW50IG91dCBwYXRjaCBmb3IgdGhpcyBvbmUuLi4NCj4gDQo+IEkg
ZG9uJ3QgdW5kZXJzdGFuZCB3aHkgb3VyIGNvZGUgc2hvdWxkIGluY2x1ZGUgY29uc3RhbnRzIGFu
ZCBub3QgbWFjcm9zLg0KPiANCj4gQW5kIGlmIHNvLCBsZXQncyBkbyBpdCBmb3IgYWxsIG1hY3Jv
cyB3ZSBoYXZlIGZvciB0aGUgc3BlYy4gV2UgbmVlZCBvbmUgDQo+IHBvbGljeS4NCj4gDQoNCkFn
cmVlLCBsb29rcyBnb29kLg0KDQpSZXZpZXdlZC1ieTogQ2hhaXRhbnlhIEt1bGthcm5pIDxrY2hA
bnZpZGlhLmNvbT4NCg0KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX18KTGludXgtbnZtZSBtYWlsaW5nIGxpc3QKTGludXgtbnZtZUBsaXN0cy5pbmZyYWRlYWQu
b3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtbnZt
ZQo=
