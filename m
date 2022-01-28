Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 080BFC433EF
	for <linux-nvme@archiver.kernel.org>; Fri, 28 Jan 2022 09:34:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=tZyDWOGLI0gDEbdbHmzWWaehfqhpMxxaA/iahc6a3WI=; b=CKLU705PXePjtdD8t9gJu+Dy2S
	k6j2uy2YRVFbb8TLe6xXTMaG22DolmFd/jBezlBus5KQz2l+QSj1pcJgbFotcpqq6QI4gK1aYbTf7
	YqMXIyNhQK4dTTnha+lrOJ7boy9xuCrY3K9MhAyTIn9tWCLUHJ/rLGqQY7x8VF6Szi4eVz/WCer9x
	AN1xbaEUURv5gAKWN76SePl7NCAOukRivGChS1LKkBGiTcZVEbSYkx5kd3/fRrfaaLvfzlAJj0d7h
	p07K91tUUWWkSxfzu01oKx51BR1odZ9kvXg11Ddmp9drhywdrJJyDJE1fQfN2O6SKzXvy9Rt70rXY
	zbHVmqyA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nDNdj-001GVG-M5; Fri, 28 Jan 2022 09:33:56 +0000
Received: from mail-dm6nam12on2062.outbound.protection.outlook.com
 ([40.107.243.62] helo=NAM12-DM6-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nDNTZ-001DmZ-Vu
 for linux-nvme@lists.infradead.org; Fri, 28 Jan 2022 09:23:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R71PjDYXNUa6+xufirwgFoYeCE3qUY2is7r14gtYURH6Q3U+6D3teqyuKI+mNxCGpmt2qXpzZkE6JTDu7BZnXe6TcDR3/6IFqqIZJXJpeC0fNQGxP04yvCPqCWq/JlyqNZsqcTQ8qQdneH2flJt1oy5M/UqLWXA0JmHoY7ggAGfo/JMfeBtMVvLAIAJYC8oUda8FHkHXhIvk44A1W9evJn8QPC2oXuLhrmWEpjV5QRG6UiQqJs8nHijPfDMbdTUd463EyPhd30oLABtE0Y+8IT+H2eZm/a6i9OjarQH8n3VQJ5CaLjBS35QsPGLFr7t/WpW6mt2qmAtOrJ72c4nXag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tZyDWOGLI0gDEbdbHmzWWaehfqhpMxxaA/iahc6a3WI=;
 b=Jgxn+JNktyobNnlraoFB0/RhR+EGYqy/uovMAm8hSUv/p9Io1eFmH4Hb+Ks5wUbK0zar6IeYdyu96UwGe/Cn62e+avY05Uuw+oznf2YjxNlIl82uZxmuwhFcGPXuk8n/UZkz0C6vUBIqP1V60tu6pZF7jiBFG07Qax6F2vGrB+nhWtdmri2Nle8yTS4jPCG7RWExk2PX5rOJJs6INuMVgaS5XBNzK89fuEe8AN+YnJPRLiOb2mXl0wx9FukbgCRYuBQw9Urme7WH8ZpJyiSLj2xUV09Dxo5afXyP5yiKCWnXO23yoErf8tjT06y8n3JAH+IuR45nkgGxMkC4wBXC5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tZyDWOGLI0gDEbdbHmzWWaehfqhpMxxaA/iahc6a3WI=;
 b=JKY4Tjknp7Fu3iaXYifGGMaHnkDq6sdvTFTgl7pRaNe8TJL28eLHQ5Sc2KR36d9hmP6IsxGXWI4MDGEZIprNl7g1GIFcUJknHL8TBOmUACjOGbWnHos/1PDMyoXShVLYloHMhwSlfVfE3OLgfQ1RDXfLPpt8mMLw62Ya8GtktzCSGUOYB+Bspml+t+oDjIqNfcQyvT/B4dmykXzqEeRdmlkUzJft9oDhZmO+x+aFOxJogpiDb/ATlYdt/DItqv75OIHxfPxYo5Qd0IQ5mdTQja83NMQ7kzuCZNNjNsEg+3j50HZdL/BrzYaL6FfVuO5Y7si7svOZ8VujLfi15iMmuQ==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by DM6PR12MB3658.namprd12.prod.outlook.com (2603:10b6:5:1c8::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.19; Fri, 28 Jan
 2022 09:23:24 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::846c:d3cd:5a30:c35]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::846c:d3cd:5a30:c35%4]) with mapi id 15.20.4930.018; Fri, 28 Jan 2022
 09:23:24 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
CC: "hch@lst.de" <hch@lst.de>, "kbusch@kernel.org" <kbusch@kernel.org>,
 "sagi@grimberg.me" <sagi@grimberg.me>, Chaitanya Kulkarni
 <chaitanyak@nvidia.com>, "james.smart@broadcom.com"
 <james.smart@broadcom.com>
Subject: Re: [PATCH 1/9] nvme-fc: add a helper to initialize connect_q
Thread-Topic: [PATCH 1/9] nvme-fc: add a helper to initialize connect_q
Thread-Index: AQHYFChbwxdcb4Tqo02UymL0Ete+yqx4KROA
Date: Fri, 28 Jan 2022 09:23:23 +0000
Message-ID: <c2426fb4-5a80-801b-1442-fff95281bdf3@nvidia.com>
References: <20220128092015.19289-1-chaitanyak@nvidia.com>
 <20220128092015.19289-2-chaitanyak@nvidia.com>
In-Reply-To: <20220128092015.19289-2-chaitanyak@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5a770d3b-bbb7-41a6-24f0-08d9e23fd562
x-ms-traffictypediagnostic: DM6PR12MB3658:EE_
x-microsoft-antispam-prvs: <DM6PR12MB365817380332C7C179CBB767A3229@DM6PR12MB3658.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4303;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: I3Mn6to44kTepyYUe8WkJSfy/6808goYIlOsTfyFxYJCj0MvVzQMwpcmA3b6WEuxz9UIj6y1M69TwPlUWKV+wp6eZWZnbBIMokz3MrSe2FiwOQV5HIi/V8Uw16g2DVS2gTMSZ6nhoOqhpq3ra31t15LsGSVz/4Gd50iE3/Z3/bESE07vF0wj5MG0h/Gb2wuMeUqGiwV23ILji/i4/F/lwozV+YxM6HYHcQ3XsQyJMfkW4B8aXO4yI40Gn/PCImmzdkNzAJu+1BPUOcrnMSxdOAfFzGbLovmj5w229Gaud8hTR12OjG/IYK8wgCKFwU6AB4wg7qGK+ZUQMFgcgjdm1zlzTX5vi0LIBfpIlveORFH6Uqablui7rmboG5cO1rjDhm+5kzcSth36HTY9skjNanEGZ6wAsOMxSpOFbaeEomSGFvjdHdm8qxtqdJqa/Mr9DQYmJqi6YUXUBAF202YO4dHf4oI/8RM5djCyn3TGev4P1IsM8nwr/l56YXamYWK6aUKG+sBupT+lFfINUU8Epiug+7YpIgc8yYv2tHgJBrsihsi2Vll7pfYGdF/VXt88vVcV9fbZs0ev/omCr8l/fDVeeezhKOVklYNnvYLzmCW5cTDOEk09wu0JWuTcF02bIem/oQXdQ/YkoNKxtKpeCXGIRc2eYWnkZyvEGwjYCHWo1UquaWYqFmlBS1bjs24XReHIrutAg+29UoX00i/Ha4eirGdPtcos6+PL7+eNfkqzeVHsL9jzp2hMxIhMiOxUgGXZTwbTnblwGkUNhi6gEQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW2PR12MB4667.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(38100700002)(38070700005)(31696002)(86362001)(122000001)(66476007)(66556008)(91956017)(76116006)(2906002)(66946007)(4326008)(316002)(54906003)(66446008)(6916009)(8676002)(64756008)(8936002)(83380400001)(5660300002)(186003)(71200400001)(6486002)(2616005)(26005)(508600001)(31686004)(6512007)(53546011)(6506007)(36756003)(45980500001)(43740500002)(20210929001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?b3lIUkRZSFdqWC9WWWgwUStZZTRENVc5cVZudEZoVjJPd2N1dG4xS3F5K0hU?=
 =?utf-8?B?Rm9MZ3REdDUvRUdKcVFUSlE1K2ovSmpveGVkbFJ1VW1YRUtjdDJ0TXk2WklB?=
 =?utf-8?B?NFU2THBrSHkrREJya2p4NFUySGlLYXAyTDh0N1E4ZzdKeUV2WWdMSm5YNTlj?=
 =?utf-8?B?TnY3ZGNnSnU0NzFKM3ZSZWJpd2FuZzJOMUhFRk41WFdGRm5SNjVjU3M3alFY?=
 =?utf-8?B?YkJpa0VQVm04Z1diZ2o4ckpSWWNLYTQ3RlFibmFGNnFDTHR4MEg2S0k5YjR3?=
 =?utf-8?B?a0pLZUk5cmNPQXpNMjN0VUczcUdjUXc1RFlSMkVPWWJVVkVDT2kyOHZpL0Iz?=
 =?utf-8?B?MmE5Wm8xUEJjRThzME9XT1lxcmFibzVPVWZzYlU5R0xzNlc5bDZRNVNmZWlk?=
 =?utf-8?B?WDZWVnI5dFcwSUQ3clhVTUlKeVhHOFlZbVZlWm00K2xLeDZiWWV5OHVwanRH?=
 =?utf-8?B?cGJyOGY3OEEvUkpqdU9WV1R6MnVieEFlQ1ZFWUlza0JIaDRJUGFCZGZFRTZG?=
 =?utf-8?B?clJOMXA1bjdlM29nSnM0djd3Rk5CY3pDYS9ZVlhNL2wwYXVRT1pNTU1qV0RB?=
 =?utf-8?B?d0FVd0lQVHNqVnlWWTJ6TDl3L0VWOW1lRE9CdTYwaTNyWlhLMit2eTl5UkdS?=
 =?utf-8?B?eXJDbGM0aEl4R2tLbGNqMmlEMTRUUm56Vlp1VHpLanRSc0luZVRmWE9PVDFi?=
 =?utf-8?B?K3JSNmxOWVFicXFkZUh0T3hCVW4xQ1oyZkhQVGhlOFpUdnJiSDFSYjl3MlR1?=
 =?utf-8?B?UWxaUWQ2bWlLMTVjQVBNYzgvVVgxd3o2NDBKRjYxcTVSVkRBazBDaDNkbEVC?=
 =?utf-8?B?MUxZbXB4UHFENXpOVUNwbVFueHFQbEE3dFFJb0J6dCtlUVlOeWE1eVV6SFkz?=
 =?utf-8?B?Q2VJUG5QY1I4Z3FDMU40WElzc2VZK3ZGVmN6RUQwdXdGc0YrWHk4RGN0enJD?=
 =?utf-8?B?NU5NdUg5cTZXR2FZYk1DTnRYK1Q3cGJldjM4WFJsZVhnRzBOaituVVo1QWFH?=
 =?utf-8?B?Wkx5WHp3bHlwdEZ0YVdzMXF1NXF6RWxxeEVja0NwYVdlYVdXdUhiMXBwdks5?=
 =?utf-8?B?U3Q3NllQeVI5WUljSDJwbktQeEdTU05kZlduV3JDWHB2UjdjbWJJVGk3Kyth?=
 =?utf-8?B?M21mSklBb3kzMWRRZlNwRFRqdVFWUE5qOVVtbndudlY4WmM2cUdnaFNtVk5D?=
 =?utf-8?B?SHV4cHczYTB2VXRkaFQ0em1CZjBoTDl1ZnZnd05YRU1zWTBIWFlyVUJ4dmho?=
 =?utf-8?B?bkhueEtXa3J0QUlIeWh3V3NaSUFnZlhGaVdiOUtqUVhnMExJejFzOUltRTNN?=
 =?utf-8?B?aGN5eHA5WE1icm9UTE0zem5HYzlWeUI4QjhZU3hpUStVMy9CRjVMcFNaUC91?=
 =?utf-8?B?MGRQVzczZ2x1bVNyNGViRS9CMFNrdXpOQlM2OXQwOHYwc3FsS1ZHMjY2Wjg0?=
 =?utf-8?B?RzdlNzIrTXEzVTlHNU1WVjRZZ0Y4blF1LzlBWkVWUXpLU0I0MWdnbFM0L1JU?=
 =?utf-8?B?Q2FwcEdpVXAxRmdJSnVISUV5enU0Z2R4ejRHNE9aTXNEN1QxN1dIOE95R2Fi?=
 =?utf-8?B?bWxBWEpmMnJna2VONHVuaG5EV1ZOR09yMHJvVkk4NzY2czJxZ1pBRGFieHpr?=
 =?utf-8?B?NDFHVnNMdWRONlYva09jWjVuUTZiZzlZVmNKSWpUT2VsQm0xb1d2YVZPWEk1?=
 =?utf-8?B?RDhiR25DT2ZiWUQ4dmZocVF5WCtldHh3b2lIWkdSRHduMzI2OThzVk9ha0lS?=
 =?utf-8?B?TUdKKzc5Q0E2TTFjT0ZFbGp4SzM5aDgwZ1lmekRDQjU5YmttSXlNTE9BRGoy?=
 =?utf-8?B?citxQTQzTWx2QTNLMTIvQi9VNkpQYjdKSktIWG1MektoZG1DMjZJU1lqOFdF?=
 =?utf-8?B?UEFibWFPNGxCTHhEQmZDeXRCQlZrRjhNRXJhamlQN0RMeEZPYUpGeHpzSjdZ?=
 =?utf-8?B?LzhYUkdIdXdkeXZjaEZ4SzU2US85TjZtayt6clpkR01mcXd3TG51MEtmcEpQ?=
 =?utf-8?B?RzM5c1M4OFIvMSt3YVluOEJmMHNlOTNZUUlxMW52czkrWTJHbUMvV0h4ZEVN?=
 =?utf-8?B?WmphZk05QW1EZEFFVktOdHNQb3A5SE03cDlqNHpWZm9JMXpLTnY3MzdwaW5n?=
 =?utf-8?B?SDZrSVZlckw0SlhmRUJXYnI0TGxiWG5XRU5DWEQvQmlwL3l2T0IxZUJpdldI?=
 =?utf-8?B?N3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3E2735ECF153DF418C0DDF743170D06B@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a770d3b-bbb7-41a6-24f0-08d9e23fd562
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jan 2022 09:23:23.9494 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3O5K2pVR5OgIzquwM+OlED7JdfX848SsOSLmYBCWzvvjH8ONFCzsv3BXvArYikiw/RIzHuVPHG8+N5lTYpGtig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3658
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220128_012326_070159_220085BB 
X-CRM114-Status: GOOD (  19.16  )
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

KCtDQyBKYW1lcyBqYW1lcy5zbWFydEBicm9hZGNvbS5jb20pDQoNCk9uIDEvMjgvMjIgMToyMCBB
TSwgQ2hhaXRhbnlhIEt1bGthcm5pIHdyb3RlOg0KPiBGcm9tOiBDaGFpdGFueWEgS3Vsa2Fybmkg
PGtjaEBudmlkaWEuY29tPg0KPiANCj4gQWRkIGFuZCB1c2UgaGVscGVyIHRvIHJlbW92ZSBkdXBs
aWNhdGUgY29kZSBmb3IgZmFicmljcyBjb25uZWN0X3ENCj4gaW5pdGlhbGl6YXRpb24gZnJvbSBh
bGwgdGhlIHRyYW5zcG9ydHMuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBDaGFpdGFueWEgS3Vsa2Fy
bmkgPGtjaEBudmlkaWEuY29tPg0KPiAtLS0NCj4gICBkcml2ZXJzL252bWUvaG9zdC9mYy5jICAg
fCA2ICsrLS0tLQ0KPiAgIGRyaXZlcnMvbnZtZS9ob3N0L252bWUuaCB8IDggKysrKysrKysNCj4g
ICAyIGZpbGVzIGNoYW5nZWQsIDEwIGluc2VydGlvbnMoKyksIDQgZGVsZXRpb25zKC0pDQo+IA0K
PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9udm1lL2hvc3QvZmMuYyBiL2RyaXZlcnMvbnZtZS9ob3N0
L2ZjLmMNCj4gaW5kZXggNzFiMzEwOGMyMmYwLi4yM2M4OTZhMTM4YTMgMTAwNjQ0DQo+IC0tLSBh
L2RyaXZlcnMvbnZtZS9ob3N0L2ZjLmMNCj4gKysrIGIvZHJpdmVycy9udm1lL2hvc3QvZmMuYw0K
PiBAQCAtMjkxNiwxMSArMjkxNiw5IEBAIG52bWVfZmNfY3JlYXRlX2lvX3F1ZXVlcyhzdHJ1Y3Qg
bnZtZV9mY19jdHJsICpjdHJsKQ0KPiAgIA0KPiAgIAljdHJsLT5jdHJsLnRhZ3NldCA9ICZjdHJs
LT50YWdfc2V0Ow0KPiAgIA0KPiAtCWN0cmwtPmN0cmwuY29ubmVjdF9xID0gYmxrX21xX2luaXRf
cXVldWUoJmN0cmwtPnRhZ19zZXQpOw0KPiAtCWlmIChJU19FUlIoY3RybC0+Y3RybC5jb25uZWN0
X3EpKSB7DQo+IC0JCXJldCA9IFBUUl9FUlIoY3RybC0+Y3RybC5jb25uZWN0X3EpOw0KPiArCXJl
dCA9IG52bWVfY3RybF9pbml0X2Nvbm5lY3RfcSgmKGN0cmwtPmN0cmwpKTsNCj4gKwlpZiAocmV0
KQ0KPiAgIAkJZ290byBvdXRfZnJlZV90YWdfc2V0Ow0KPiAtCX0NCj4gICANCj4gICAJcmV0ID0g
bnZtZV9mY19jcmVhdGVfaHdfaW9fcXVldWVzKGN0cmwsIGN0cmwtPmN0cmwuc3FzaXplICsgMSk7
DQo+ICAgCWlmIChyZXQpDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL252bWUvaG9zdC9udm1lLmgg
Yi9kcml2ZXJzL252bWUvaG9zdC9udm1lLmgNCj4gaW5kZXggYTE2MmY2YzZkYTZlLi5mODY1OGY5
ODRkNjQgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvbnZtZS9ob3N0L252bWUuaA0KPiArKysgYi9k
cml2ZXJzL252bWUvaG9zdC9udm1lLmgNCj4gQEAgLTg5NCw2ICs4OTQsMTQgQEAgc3RhdGljIGlu
bGluZSBpbnQgbnZtZV91cGRhdGVfem9uZV9pbmZvKHN0cnVjdCBudm1lX25zICpucywgdW5zaWdu
ZWQgbGJhZikNCj4gICB9DQo+ICAgI2VuZGlmDQo+ICAgDQo+ICtzdGF0aWMgaW5saW5lIGludCBu
dm1lX2N0cmxfaW5pdF9jb25uZWN0X3Eoc3RydWN0IG52bWVfY3RybCAqY3RybCkNCj4gK3sNCj4g
KwljdHJsLT5jb25uZWN0X3EgPSBibGtfbXFfaW5pdF9xdWV1ZShjdHJsLT50YWdzZXQpOw0KPiAr
CWlmIChJU19FUlIoY3RybC0+Y29ubmVjdF9xKSkNCj4gKwkJcmV0dXJuIFBUUl9FUlIoY3RybC0+
Y29ubmVjdF9xKTsNCj4gKwlyZXR1cm4gMDsNCj4gK30NCj4gKw0KPiAgIHN0YXRpYyBpbmxpbmUg
c3RydWN0IG52bWVfbnMgKm52bWVfZ2V0X25zX2Zyb21fZGV2KHN0cnVjdCBkZXZpY2UgKmRldikN
Cj4gICB7DQo+ICAgCXJldHVybiBkZXZfdG9fZGlzayhkZXYpLT5wcml2YXRlX2RhdGE7DQo+IA0K
DQo=

