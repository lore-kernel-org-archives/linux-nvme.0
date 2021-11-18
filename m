Return-Path: <SRS0=aga3=QF=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EB64C433EF
	for <linux-nvme@archiver.kernel.org>; Thu, 18 Nov 2021 01:45:08 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D988161B04
	for <linux-nvme@archiver.kernel.org>; Thu, 18 Nov 2021 01:45:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org D988161B04
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6CfEq7R6M6VspUCNiYd8FHzmR2ZzruMLURNGjxKax60=; b=jTym831scvse9pt6+EiqHBzHqM
	SdErCPmP0CdPXK8/tK8vx70iJUwdP7w32gbFdeO5lgbgB/iHSBuTg7SNXp8IfhicA3Am+LSSXkJOR
	4MM4KCNQzltCX5EhvI/eWJf6S0PxbqGQwAX4Uc/tvmPpNRZe9gpqTq03MGCk2B9i0z6UgOLScSEaT
	RI9jubGjeEkz2AuPKmG5kpM7xKJZo8YlPRoh7IMLQ9FKAGNMkalSjE7xIALuYbh4Hk+r45rUPl/AT
	BzpMGurtMY9k4j3AqDHBKnGzSyu8aIzUyBG0hwii66Qh4lCBhiHJuBYsDUebmfsrL6AjpQa2R/rMu
	EiH7coxA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mnWU0-006h4O-TG; Thu, 18 Nov 2021 01:45:00 +0000
Received: from mail-bn7nam10on2062a.outbound.protection.outlook.com
 ([2a01:111:f400:7e8a::62a]
 helo=NAM10-BN7-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mnWTx-006h3l-Kp
 for linux-nvme@lists.infradead.org; Thu, 18 Nov 2021 01:44:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kzu7B8pAsFK7dKMJakmz6bxcKeaUgk8mgX0Iz9tXaPvmC+KvLd4uEeBz76gkDFSIu1srmsxU6QAuUrgyKSIlIjftaOfzdWPzTDOOpoYxDYVDekphBNdwiQMaH+6wO/LYZAuA02Znac0PqlElv+dfKlEXCpzd12kk2kHZOmIpxA7/YRsNPSD+JC7wrgJez3Px3wphtYeQaux/HNkVVNia/iTFHN/oHDhf7zmKSDFlZ+tJYmYcdn4lDpKGjdN9Bqdl0RBlA63lILdi0yQ+476HQSejkAWYcVuDmmx65jqTm5j2dAR84tjiZ+NxPzOh1/q9NFlXWWqC8H1mSE2bay5aOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6CfEq7R6M6VspUCNiYd8FHzmR2ZzruMLURNGjxKax60=;
 b=jGkzwbn9AY7v34bG2ukMslw+xQVxN+w/1s1iut6/F1hTh3kG5wkYzQUBoPn6cuRsTUmOYKQflvy1JVj0yiuhyaWNl9IvCUkT0csAW3O3cfEMx69a14qJX6WyyOX9xSu/Yw7GGbZLR19yltPNo1r5EHTAfwbS1+GwrzkzSQSzzytAnzLdbQdIPKqRtFYSxBM/7uMGRaK74RJvl6raU6CCkqGPSxpRGfJK4ctl42GK4MGkeoPSMVWxoPZ62hra+PwY2Y2Wg6hib2taHVGRkSxdyNdL+TaSqdisjxNHKevlWpRT0FkIAUKYw9ryrMs1EqfC0hOgId5ufm9ZAtSOPzwmLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6CfEq7R6M6VspUCNiYd8FHzmR2ZzruMLURNGjxKax60=;
 b=WFqRFRop4U17OhW4ukBq97ud94ARtzD56awraDxBMQ3eFzt792HERcdtYHoRvK+33dM5MN9Yhr+gMxOZ2bjRan4IZLDMOtj7e65IaVXV/DflTIaVpJ9J7FMY0bE3gf9eERtGwHND9l3iflJXquC3wurYWzs6baz9KNFBnIhVXf//NERbdwfGdT42g1N0oY58JMllNFN0JZTkQ5sN2k9KYj8pLs/vYcVHTVRxepIw20p+4SYv+/2wl/g7ksRvnJl3468u4jNn7KwsaqRrkf+6VbdToPIxIyyXrHKIBYlotM7PXOS2tcJ4jV1zSMIoBZWtepht/Qh/P2+jnVAIcgrK3A==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by MW3PR12MB4348.namprd12.prod.outlook.com (2603:10b6:303:5f::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.27; Thu, 18 Nov
 2021 01:44:54 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::c961:59f1:3120:1798]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::c961:59f1:3120:1798%4]) with mapi id 15.20.4690.027; Thu, 18 Nov 2021
 01:44:54 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Maurizio Lombardi <mlombard@redhat.com>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>
CC: "sagi@grimberg.me" <sagi@grimberg.me>, "hch@lst.de" <hch@lst.de>,
 "kbusch@kernel.org" <kbusch@kernel.org>
Subject: Re: [PATCH] nvme-host: prevent nvme-cli from setting invalid
 fast_io_fail_tmo values
Thread-Topic: [PATCH] nvme-host: prevent nvme-cli from setting invalid
 fast_io_fail_tmo values
Thread-Index: AQHX19Ad3wtKYqzOXUuFbv090OI9IKwIjCOA
Date: Thu, 18 Nov 2021 01:44:54 +0000
Message-ID: <5bd81612-98f2-247a-1fb3-1222f76bdbf2@nvidia.com>
References: <20211112141612.201297-1-mlombard@redhat.com>
In-Reply-To: <20211112141612.201297-1-mlombard@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1318cb3d-bf98-4f75-e4f1-08d9aa35050b
x-ms-traffictypediagnostic: MW3PR12MB4348:
x-microsoft-antispam-prvs: <MW3PR12MB43481F2D66076ABC65177782A39B9@MW3PR12MB4348.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:308;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YTh+N/y5+t7HWSpsqXyYlVoBZnbPs/XvsBrttBuhePPH8k2XuoM7NdM7BAeKhu/PYd9BW4ttoz2iXZmKsB3CaO56NzGOzat5YZYuMnaG3HMaYzlEF5LYbLCCQmUhf5YCkyYSUynIVgf9Q741QjkwSWNzxFRL3d1loFmrk7I55nNxFf1B9nfKfGbTpUrUy9aMPf+K9VG668NFsrML2d4st1pBwtPBJMTAK+sA2GlM6XmHB8feK/2RqBd7B2LeliUGiw79ZBMj2fHYDSqoqvHw1pCdUWV8MMuRCgzk/SDemDpD+YHFwK8hv15RFNLr49nBLtuXpLgc5b3VsTEKwpRWcm6Cz/RKYSTQGSsZwBkwhgXvCna1pWNmh2QApCMbVANwZTjMgkB9dd76qr9TRuZmMa7qSigtm7OBjWUMItV3JoGqfQ40o0enjQaM9/YQLpoog9qzlyAR4wInzX8R5iJNtJrGjH7CH4bCwPXW/9ZNhfXPka/hl0fI6f8ibYq/iX1TIoJgO34UcwQWJEFFo2e5XpA48uaJy3FNFKmYtJUd5GDacPALmlB9h9q3PUHNgF4FusvG00KpZrYLnaKp82jGiIrQKCsXAm9Po+RHNnSIQXNKd+RylaLxxlIWV0DUFWtTfcqTqxolEWjBfdfULvP5O+U/Khur2eaRVHhdfQ9jL19SFUM9M8lTntxLbrz+Zkoc+wFo03ga3PE7PPTQAA3ZfPg8OaINVNxKpc84xO/HUOrnjJ7XhTG5XK+CVg2HIcyGFZlMEOcBswKV9KBOyyTXPA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW2PR12MB4667.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(508600001)(76116006)(31696002)(91956017)(66556008)(66946007)(26005)(2906002)(6486002)(8936002)(6506007)(122000001)(53546011)(4326008)(186003)(316002)(110136005)(64756008)(66476007)(66446008)(38070700005)(54906003)(86362001)(71200400001)(2616005)(558084003)(8676002)(31686004)(6512007)(5660300002)(83380400001)(36756003)(38100700002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cGZCTHJDMXBwbzFzTjAxZEJZV3ZrU1N0YmZOUEF6MEVvYkhhdGZ5S0xFQjVs?=
 =?utf-8?B?anY1TnNpcmZTSWRaVVMrbWhMbHVIdGdpUkI5SG1WWkZCWGtwQy9QbCtkSnFR?=
 =?utf-8?B?SDA0VWR1cTdVUGFiOU5aVyt1QVhoQndBV1JzaVl0N05tSGpEL2NnQjBEQTRW?=
 =?utf-8?B?L2pMOGVJWVkxYk5sVHIyWnI4K3hNRVBKSkxFTVpkcFlaNEtCWURJYWx4cUdz?=
 =?utf-8?B?L0pGOHl2MUVjK3RjMUx4cW1rakFndDZTd0hYK2J6TkVXcVdhSE5IT2szN0Zp?=
 =?utf-8?B?Y3U5NlZiS2k3T1BUbzg2ZWFCRDdHQkVXM3RuKy8rUzcyUFhnYUh5UWVoYnhW?=
 =?utf-8?B?QXhSQzEyU1M1OElwK3lCbE5sNHNYZDhpRlNIaS8wNUVXODVLS3ZSSGp2c3A3?=
 =?utf-8?B?eUlVRnpDTHY4dEc1TFZ1cy8ySVlieUw3U3pMWEVwbGhFNDh4WGlKL0V0QVds?=
 =?utf-8?B?cThGNE5GNVhSUEcrQkpzNk0zK25FSUhsTjFjR0pFRkhOY0RMeWJOZGltalRT?=
 =?utf-8?B?YXZUcmlXOUdORkUyTlFjSHpYZmxYYjJldGt6RXJxZ000SlFxbCtlbmlpVWti?=
 =?utf-8?B?VzNHYVJpblJCVzEyNm15REU2Y2w5K0JzWDgxRC9wT1psci9KaG5VU21zV1dp?=
 =?utf-8?B?WCtCeXJjR2hrcm13WlZwWDJwQjdQNGdoWmZ1U2V6eWd2VmY3b0xkYjJPYkVx?=
 =?utf-8?B?ZWpab3l0RTZNZ3c0QVNITlUzWTduZnFoQTZWT2hjL2hLS3NvTytybHYzUStP?=
 =?utf-8?B?TkxONzBsSVhUcldtM3FEN3lGazBFUTIzTkNpY1JtbHJleHRHUFRMTTk4VGpQ?=
 =?utf-8?B?VDdrUEFNWWVYVGMvWi9jK2UzM1ZuNUxpZWoyNDh3MURiWlBaQkhoY0lXT3Vj?=
 =?utf-8?B?ZVJWSUduZkd3cmZBbDBoY1N3SkhjakRLWEpPR2VKQUNhSUlxV3RpT1lvckxm?=
 =?utf-8?B?Mjd1bTRIbDk2cFdSTEN1emRSeEFFdHgzZ2dkcGZWV1lqMXNyZmdkcmVWWldx?=
 =?utf-8?B?YzhGdVRmU3B2QTJQTDVUV3N5VWlsVUF5cDVUOG9OVHNQN2doeG1ZSGQ3QmV2?=
 =?utf-8?B?OGtCSlNJelhEdXA4N0pIbDg1UzdtL0o4aW83MC9LdXFOTnhxeVZuWWZkRXly?=
 =?utf-8?B?QlMwVFcvWHM0cHBmYXdIVnNKaXYvUE51cFh0dkdsNnlUT21tWW5NRlVWTmtI?=
 =?utf-8?B?NXVTMyttUXUwN2E2RXlUcnRPdlFIZ3dxSjhhY1RUR0FPOTJTVk5xQlBaRGlj?=
 =?utf-8?B?MUNZQ1JPNi9xTFNBTnMzUDVxY1pEeENIYWJQbzg5WUNpVHBCYTA3Zm00V0FF?=
 =?utf-8?B?TWZ6N1BpMWp1Q0JpTWlSMDM3dVhRa3RsaVhnZVE2OTZrVzU3T2c1cHZydmwv?=
 =?utf-8?B?dGNVY3RUL1JYZVlpbmdIaFQxNDFTTmRCaWhUa1FGMXBveGJ1cktpYVpuWkM5?=
 =?utf-8?B?YkRFSWtxcEwrUzlWdTBvS2RpcG9WOTJkTElQRWxFWnZnNEsxbk9IWGJjODds?=
 =?utf-8?B?RmZGUnVtVU1jWTBoL0xDaGNiK1k4KzluU25VNnF3Snl4V1dtdU9JYW55QTBy?=
 =?utf-8?B?WUtoSUdNUmRkK2U2QncxZHJsQ2JUejcwSWhBUk5XWVc4SnFIQnhLTVdGMUVu?=
 =?utf-8?B?V2R4QytxbDcxTlBPYjJ1UlczSnkrT1liM09KdHVLRGF1Z2lSUEdDaElXUmc5?=
 =?utf-8?B?Z1BHbFNEYWNrZTdFOVAwK2ZrRTVuTEp3MU5OU3NMUWxZUS9PV0RzeTVHalBw?=
 =?utf-8?B?RDFZR25HSjJWUXRLbC9EYmgvTmMzZlRoM0lqYWVtbUdONitOKzR5Tzc0RTUr?=
 =?utf-8?B?bXNHcVNhcjB2aXZWbjhLU29LNUlCNWlFMWo4SW5mSVpLMmRQVlE3cjJsdkNO?=
 =?utf-8?B?NG5KVHh3eDNmTS9NMldxeExEZVpwM1NnUXFFeW12QTJlOHRkVXdybUZxU29X?=
 =?utf-8?B?aktDUmVRK3d6NkYxb2lqT0JDOWNzNnk2aXRDK0hrVjlDcG5ybWFyanVQZmZq?=
 =?utf-8?B?b1pWTXlwRVZkSmRDVGp0TlR4YlJsRHBEOVV5MzRRYzFpWXp2a1EzazYvVm10?=
 =?utf-8?B?elkrZkpSZWxNRGcyQjBkNFMwajdZbkhPU3NHbVNXTUVsTi8wY0NOUU8wRmtT?=
 =?utf-8?B?UTZCLzBINzdEMStERUZwTFZmOU03YnNHaDhSVzVlamhJMDhaZWdRKzRVeGhE?=
 =?utf-8?B?WFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B81D56E823D07D458B8CCB6298083197@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1318cb3d-bf98-4f75-e4f1-08d9aa35050b
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Nov 2021 01:44:54.3140 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CoRHwGYUb1n14bmx2+gqrxF3NcyLeCz03k/aRLmfUwh3hbLrk57gMjM7GxhiP/ICztHV+fZJ5S56m87fHo6wLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4348
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211117_174457_728990_860A3D14 
X-CRM114-Status: UNSURE (   7.18  )
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

T24gMTEvMTIvMjEgMDY6MTYsIE1hdXJpemlvIExvbWJhcmRpIHdyb3RlOg0KPiBWYWxpZCBmYXN0
X2lvX2ZhaWxfdG1vIHZhbHVlcyBhcmUgaW50ZWdlcnMgPj0gMCBvciAtMSAoZGlzYWJsZWQpLg0K
PiBQcmV2ZW50IHVzZXJzcGFjZSBmcm9tIHNldHRpbmcgYXJiaXRyYXJ5IG5lZ2F0aXZlIHZhbHVl
cy4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IE1hdXJpemlvIExvbWJhcmRpIDxtbG9tYmFyZEByZWRo
YXQuY29tPg0KDQpMb29rcyBnb29kLg0KDQpSZXZpZXdlZC1ieTogQ2hhaXRhbnlhIEt1bGthcm5p
IDxrY2hAbnZpZGlhLmNvbT4NCg0KDQo=

