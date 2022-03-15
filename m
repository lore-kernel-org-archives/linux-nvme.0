Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E1DCC433EF
	for <linux-nvme@archiver.kernel.org>; Tue, 15 Mar 2022 07:41:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=dgoB8ViAZl1px39K6T4YMMxM2kAY7j8QqPPlL08OX1M=; b=G1BYwp6seVl2yldX5lv2yNiOcd
	DVPM+0TMesMNpDgZgCM3qcNj2BlUFSuhOE5/RWPAKDVx+XDqhgogYfeLsARPuJ1f9B5dQ7DtHs5J0
	OJtGNpex9hOBX0Jw+eCmyKM/g6FTvjmDxuqbzEmnIOWiOjcyv7wwigL22fpHalp1q/S2zQj40FZxE
	nYe45I0p56YbAd73pNxzx0czY4SBta1+vnYI15d+FNKjefMkNEBZZ+qkmSDUnUJBq5FheYFlhV0gu
	kyP/BCBUV0hN4h+eEDpu/OG3iYys6LGMqeEVYremzrSrNVPI+FpW8T4vv7SHsr0MdOYR1+H88K+ez
	WAdGMzPw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nU1ne-0089So-Iz; Tue, 15 Mar 2022 07:40:58 +0000
Received: from mail-dm6nam10on2060c.outbound.protection.outlook.com
 ([2a01:111:f400:7e88::60c]
 helo=NAM10-DM6-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nU1nb-0089Rf-FD
 for linux-nvme@lists.infradead.org; Tue, 15 Mar 2022 07:40:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pb6/IQzyqlm5Q/hMTLjdyTOnFY0Tm251HCq81iOhISBQX99lXeMnYoub9v+P1tYAaQnCGG1JkJW7MGYVsVfxrXdS0UHmjfXIa52Mvd5d04OZGrt4n+Nen7/uJnmLP8mZSLl90HzRBq2zk4vGOrCYLYzP7rXSiKXOqN+Q6/PWh0kmEB2TOLD/n4lKmXOYezrvaGReSSVuhfFC0VFXtqZeVwpQ0XPU5mAg0pQRbfNEIYXQ3XPEfNou26xyrg9Od8L4wlueafdsyddlGNs26DuFHRi3ySywzYkhsQgjgyJ5sCuE5TkB07Irn5CthFl/2JkrXOFLyy3/XFkSoM5xWGQbfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dgoB8ViAZl1px39K6T4YMMxM2kAY7j8QqPPlL08OX1M=;
 b=eh0C43uZwUorApBfGeMWQFa4g2wF0wO9fXuRqAWmW9dYV3c/B9Ngqy7FrYvLiqTsSpVQF4IgWLJpLYcsYHaZ2uH6J+vyT0H39vsZmJ6w+ib8zxXmdGl6HrPTBEzSm7OnVTWx9+Dora2ZU3U9JC4n6FX8BdzWRu/Kuk6frly+2sn72XO8i/hzPK6AVw3WcA2+4LhLGEZ1TANyop2ZsjdJiPhU1ynEbVRwCGwhAmJbyejjdDQqpo7iVh5tsFqX9gpQJ/D4d9Bi/3EMxlZb6Mnz00QojpoGIz3x9oheiwOYXTaz3gsEEN83tDM6yFDyEBCmH22biUgKq24gvaFZq0Hwvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dgoB8ViAZl1px39K6T4YMMxM2kAY7j8QqPPlL08OX1M=;
 b=G6GRzCIdcqDLAIT5v4bLefdLpXJsrgrbmaO2mPZHF1lkU1R+HSKtKWjoKjbkUXOndeoj8gmsl2CRtzPGF3eKFmEVrmP66tmMaMQJvg5bjYw97iht7CpJCsX/WRQlEsiOtAcOTTNFZQIE31MKXnIaLXJn6eXZA0btkj3MUp+pXJompp1BMZsB2ITUucGTbWsRhc6Tqxs/Uu9UZn16h+PxKQYKa2WZrwuyAfOwPlJyo7hHx5vbHtb5q9UH2kDjLICnmIZxABtfP06a+gDFDdWfOBnfHaC/TOD+wcxPRwyWSO+h/cFA0kyuIIX/7OhajKLR2vwSo4jAprL1UBTrgkxWJQ==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by CH0PR12MB5282.namprd12.prod.outlook.com (2603:10b6:610:d5::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.21; Tue, 15 Mar
 2022 07:25:18 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::204b:bbcb:d388:64a2]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::204b:bbcb:d388:64a2%4]) with mapi id 15.20.5061.026; Tue, 15 Mar 2022
 07:25:18 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Christoph Hellwig <hch@lst.de>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Chaitanya Kulkarni <chaitanyak@nvidia.com>, "sagi@grimberg.me"
 <sagi@grimberg.me>, Niels Dossche <dossche.niels@gmail.com>
Subject: Re: [PATCH] nvmet: move the call to nvmet_ns_changed out of
 nvmet_ns_revalidate
Thread-Topic: [PATCH] nvmet: move the call to nvmet_ns_changed out of
 nvmet_ns_revalidate
Thread-Index: AQHYOD0T1Tq18kG8sEGOWU8svrZXxKzACymA
Date: Tue, 15 Mar 2022 07:25:18 +0000
Message-ID: <88e94365-b3dd-4a0e-98ba-783d1be05c12@nvidia.com>
References: <20220315071951.1903382-1-hch@lst.de>
In-Reply-To: <20220315071951.1903382-1-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 865eec73-2e09-4a5e-f396-08da0654f4f9
x-ms-traffictypediagnostic: CH0PR12MB5282:EE_
x-microsoft-antispam-prvs: <CH0PR12MB5282E9349B0079E5950EB6DFA3109@CH0PR12MB5282.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: z0SeldKqvcrFXL9kRWM2ySSJRBT4c2KmzmD5posBc+C7Xh4DeOTByhy5PW592l7GiKlb2q3zRgDGxMXPkyANDJtr7MwW+TI6//6CzAHmderPajw6bm7EdBxCli1FwTdMnRrUZAmJ6G5NbmgrCEGBN6uMhfAxb42B/MmltZ4g9JVbQtIoMJ04vnO9EqV0Skz8Zurg44A7gi1o7+M8cyC55sHx6GkyFCucx323diemkzM1q2lJ+42lhMHaHnfOmxugLOW53voeHJ8m42c804rONkcH745BjAj+w95lZKyu2sgaCU0xT6b3wRV8Fz9Vw3rERN4XtNGtpVB5sZ7X93o17VPq3/fP0nWY0cwqW7UmiXlsZ80BVk1REywn/PtJP/nsD1QkAIoZtkBQqqA/JCjOjzQCdBwfsIqgNszZ2yG0maQIuRy0/9vfeRbC2l8PKhsyA2SY0cR2GEqX/ukzvy8q/3FV6pL6uVikL5PcSmnwVzNbAtyeAg8NDUxN1ybPK0g4Y1yVktY3IPfFvybsYyJ3JpMyDe/f93U4FqDz9aOJqVXD+rcUjYnrqqZagGh7O91kxDkd3pRbL5Nk1LJTU4mbFZxhF5TX+o4ltMhG6XR2l/RmeJ7IXz5Pp7Y2nLdRl/ubNtKdu+I6v6Efswu53hizxqYpIycHhbA47Pf1kY3wQYy8IUOH5Cx75Cw12GakRSNVmSQ9VKwHMnSHOjaRLhMkbeAdG98gIomvbjx+LEWc5gn3jdgevxPmq8HbhvURMGgZ9qO7xREnXQoaaew/kz3zwQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW2PR12MB4667.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(91956017)(64756008)(8676002)(4326008)(76116006)(66946007)(66556008)(66476007)(6916009)(66446008)(316002)(508600001)(6486002)(54906003)(38070700005)(38100700002)(122000001)(31696002)(86362001)(31686004)(36756003)(53546011)(2906002)(71200400001)(186003)(2616005)(6506007)(6512007)(5660300002)(8936002)(4744005)(83380400001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?S1drT1lEa0FiNFJ0cUhlNms1dDVJcnJLclNOWjZKR3hBZ1lXMWFNdCsvU3N0?=
 =?utf-8?B?RThwdEdtSWtqbXdGSVlxQWVoNjRVcC9PcW5CK2xVYkMvNzRJMkVPQm5NZ3NW?=
 =?utf-8?B?V1Z4blNwMVRPMWNhRzJzc2Zaa3dHQ0FBdWlVQzRIbW9iTHUzQXRjc2RKeFlj?=
 =?utf-8?B?UDVHWW15UXJnaXVZbENZai9UWDRGK1FhNkRDNDBKRVRlSEJ5RXppYkM5RjVi?=
 =?utf-8?B?bkdGa2c3Uk5HTFRnTDRqTjhqM1A5NnFJTEFibGpUa0VMaG4zRk55STVHclR4?=
 =?utf-8?B?UFVBempYMXJ3ODdPbXFlaWh4MTQwWjFwTWFMV3R2TzgvOU1iYjhBSkpjRGkw?=
 =?utf-8?B?ZTd1RHBMd3pOWWpSRERyd1Q5TU9EZldRUU5pUGxuSEtqUFpFUUFUbTdML3dR?=
 =?utf-8?B?SytzMkFyR0ZNckJWU0V0WG5KalRjK0VuV1hEZlpSRk1KWlRERkMybjdmUklK?=
 =?utf-8?B?RHUvZ2xrS29jdFNhTWloTXQ3ZHNQdE5SMENaOVhnbkQwNHJnQ28zakU0b1ZV?=
 =?utf-8?B?L3JmeHBIQTdFK1lsNXAxZTgvS0hSVEM2VkJNcjZGbmVYNVdtaWVaYUhIbDZI?=
 =?utf-8?B?d25mbGZiODJoMFhiSm9HZ1ZwalZBbklGRkh2cFFHUTB2ZjYzM0FkN0cyTlRQ?=
 =?utf-8?B?dkwxa1RIZE9uRzZYM0I3dXlCd2lqanhmMW5WaGZkYXI1b2ZYUzJRUVNIUWNw?=
 =?utf-8?B?VzhWc2g1ZHA4SHhkT09JRFJJM2tWSE0wY28vejlSQytvSzdlUTNHdTVGZ2NW?=
 =?utf-8?B?K3FhNnBKM29tblUwTkh3NHZVSGgwYWlMdmVRSHBnSXVtTTduWERtM3p3MXdD?=
 =?utf-8?B?Zm82RjB2cWJ5Mk5WdVBOUnNXbngwazdoR3RxQzFVMVFRZXJFa2U3djV4ZHpl?=
 =?utf-8?B?VytxRlQ4YzdEMkJwemY1dHRSRkU4VXZ4bEliK0xRbzJxTlJSQnZmeW81NzZk?=
 =?utf-8?B?MTU0SkM5NWFITVk2aEMyOU9rV1BjY2djT3FGRHlCempHL3VsNEtjOUFqSWFk?=
 =?utf-8?B?SmZQZzFuTzdLNXgvVVozeG9ZRmxKcnRnZ3g3cHJPcmV4ZFp6Y3ZWVVlIU2Qy?=
 =?utf-8?B?cml3NTlxcTZ4bDNDc1RRVHc3ZjV6bGNrd2hUNnI0WERkeGR2UnZMM2liWDRi?=
 =?utf-8?B?QUdPdGVFNHBzN0ErTmNzaVVUR0gwUUpWWjNrbWdVbVAyR0hkZGNnZXJVWWox?=
 =?utf-8?B?ODkySFRmdXBEWGxqdkp2RW1VTm9BLzRHR2RpajNMaTQ5dVV0N3JwdTdLM0pz?=
 =?utf-8?B?ZUV1ZjdmUjkyZmF2UWh6eWFGejNyRnBINWdTTFQ1eVZrekd2eFBTVCtwQVBC?=
 =?utf-8?B?RHFVUm1Da3drY2N1dU5EWGQ3cHkvcWIyM3U0YUcvVHNjLzVOVG5YaWNBeGI0?=
 =?utf-8?B?eDhXUHRmMmNXS1Q4R1ZLelU0Tm5YWmcvMEJ4ckZQUmJXWGwxUTRUb1NFeDNi?=
 =?utf-8?B?allRNW1raHJWbmNIUzJ2YkN1ZTh0SGNvQ2w5TGMvS3U0S2ZLWWhEbjJIaWF5?=
 =?utf-8?B?N2h3VURyZGcvT3Z4Y0p6WHBqM3ZucXluZE4xRFlOSXgrRzUwZVk1OE5hQmtj?=
 =?utf-8?B?QlVPN2VpT3JaSzVEUERUT29tenVHN2dWZy9WTW02VEhrbjB1aTRRMVVUOUtV?=
 =?utf-8?B?Ui96UzQ4N1V2WW9JeDhnS2tTc0NTSGRXZ3Z0dXM5Tk8vNUorUGFrNzkrd2lM?=
 =?utf-8?B?U3EzZmZ4RmliaEZ1ZGNuZ1g3eDI5Qy9PVGFoTUZZNEN3Qlp3T1RFV3orMlJ1?=
 =?utf-8?B?Wk1wcTY0eU5xS0hWemIwaG80eG85S2FIS3hBUjVVY2t5bnlGTFhiQUdIMkcr?=
 =?utf-8?B?L1BFZGVIcW5kbHRMb0dlWU54VGlmUzRvWHd3V3Z4U09aSzd3UDJiK3c3ZGpJ?=
 =?utf-8?B?ZEl5WTYyd2l3Y2c4aFVHdjMyaDRHckZnYnZKMWR5NC9pcmRiMlgzcGNFbGty?=
 =?utf-8?B?SjZTbHlIMVNaTk9lL3VRYXE3NFlHY0ppV0o2OVkvUCtvRE5YK0JUQ3FIemVB?=
 =?utf-8?B?OWZST1E4SVJiN0NSMlh1c0NHeHl6UVVBdFlob29Pbkt4c1ZxWDdFc1FjbVYv?=
 =?utf-8?Q?BoyopB?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CC11CA1AA5FA4142BFB711C020976E02@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 865eec73-2e09-4a5e-f396-08da0654f4f9
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Mar 2022 07:25:18.2762 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NGslwPwlwtPkqNodJ935jhY69bzQYV0eahFgUledLsOPwfYdSFjK3SSrjj6kpK/2RvOjj8GYifF+2aaXjo8rDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5282
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220315_004055_526571_CCF081C2 
X-CRM114-Status: GOOD (  12.77  )
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

T24gMy8xNS8yMiAwMDoxOSwgQ2hyaXN0b3BoIEhlbGx3aWcgd3JvdGU6DQo+IG52bWV0X25zX2No
YW5nZWQgc3RhdGVzIHZpYSBsb2NrZGVwIHRoYXQgdGhlIG5zLT5zdWJzeXMtPmxvY2sgbXVzdCBi
ZQ0KPiBoZWxkLiBUaGUgb25seSBjYWxsZXIgb2YgbnZtZXRfbnNfY2hhbmdlZCB3aGljaCBkb2Vz
IG5vdCBhY3F1aXJlIHRoYXQNCj4gbG9jayBpcyBudm1ldF9uc19yZXZhbGlkYXRlLiBudm1ldF9u
c19yZXZhbGlkYXRlIGhhcyAzIGNhbGxlcnMsDQo+IG9mIHdoaWNoIDIgZG8gbm90IGFjcXVpcmUg
dGhhdCBsb2NrOiBudm1ldF9leGVjdXRlX2lkZW50aWZ5X2Nuc19jc19ucw0KPiBhbmQgbnZtZXRf
ZXhlY3V0ZV9pZGVudGlmeV9ucy4gVGhlIG90aGVyIGNhbGxlcg0KPiBudm1ldF9uc19yZXZhbGlk
YXRlX3NpemVfc3RvcmUgZG9lcyBhY3F1aXJlIHRoZSBsb2NrLg0KPiANCj4gTW92ZSB0aGUgY2Fs
bCB0byBudm1ldF9uc19jaGFuZ2VkIGZyb20gbnZtZXRfbnNfcmV2YWxpZGF0ZSB0byB0aGUgY2Fs
bGVycw0KPiBzbyB0aGF0IHRoZXkgY2FuIHBlcmZvcm0gdGhlIGNvcnJlY3QgbG9ja2luZyBhcyBu
ZWVkZWQuDQo+IA0KPiBUaGlzIGlzc3VlIHdhcyBmb3VuZCB1c2luZyBhIHN0YXRpYyB0eXBlLWJh
c2VkIGFuYWx5c2VyIGFuZCBtYW51YWxseQ0KPiB2ZXJpZmllZC4NCj4gDQo+IFJlcG9ydGVkLWJ5
OiBOaWVscyBEb3NzY2hlIDxkb3NzY2hlLm5pZWxzQGdtYWlsLmNvbT4NCj4gU2lnbmVkLW9mZi1i
eTogQ2hyaXN0b3BoIEhlbGx3aWcgPGhjaEBsc3QuZGU+DQo+IC0tLQ0KDQpMb29rcyBnb29kLg0K
DQpSZXZpZXdlZC1ieTogQ2hhaXRhbnlhIEt1bGthcm5pIDxrY2hAbnZpZGlhLmNvbT4NCg0KLWNr
DQoNCg0K

