Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A89CC5479D
	for <linux-nvme@archiver.kernel.org>; Mon,  9 Jan 2023 07:09:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jsT23FV4u1poMdOY4U2CNfxsvEa482Oa6zZ2QzsCHgs=; b=06Mp6mg/MwOegO+0O+k9yLis77
	xBv/INsZ3JbXLqirCkHQ8Ol9XQgOUv6720OjOn89qUa28qHdLl3cnG1EJh5Z/sUH/RhjZbiHrTMNW
	CpK5KU9pVyJbILEDxHnoF/+kvmdpNpyVk8sLKlGePZQMHXfFsNFW7uHpMGF9wSkXiCjTrXr+nrkbn
	Gw9pitnaoKlcAZJrQR3wFQ1Hog07ow+ntdR6t4jb68Gz9B/F73HE3E6WKqmTlayQmx3TWRsHhYVZQ
	R5WGqdDBd3FM/MyrdqvLIlXK4b50NiSnEunfC4Q4PO7Ahqz2aR0a+wAQT5eLVjxysn5aNI4QK9ZUe
	UidU5wLQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pEmHV-0007Ul-4l; Mon, 09 Jan 2023 07:09:17 +0000
Received: from mail-mw2nam04on2075.outbound.protection.outlook.com ([40.107.101.75] helo=NAM04-MW2-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pEmHP-0007SY-5g
	for linux-nvme@lists.infradead.org; Mon, 09 Jan 2023 07:09:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xea2EYlje6qRsGa+REskl+Fjni4N4fuGG4do8bPeic8sX4StW55UxADnfZNhbJBN4r5KMEXXGCh5oBfkNITRRkoSY2dVm0SJS1rq3prZTcjPqJhVt+30HM27/6cM/g8HRtUj0YiSwVuS3zJqkLdkh9veJOj/81P4O3U5YweAE9i6df2mElbqU9a2DVdKYTZH0FNJg/pnxa/vL4kRT9WHwsekJe1q+RvHi/7Lp3leD8AZj2eDoaNGiB64kYLnGdVGCX9e21Q4M4rREXLvFHH+R5srlVoUplwohQfBGP9R5YSFcMWD6IQwtDqSh5J9rH+p2yqFJLCUYJP87tKkRLGcCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jsT23FV4u1poMdOY4U2CNfxsvEa482Oa6zZ2QzsCHgs=;
 b=h/mu1wSIMDC4GyC/mNQdM7K9EBxeaKieHswyd4IkA6WxQb0JeHcWhu3Kg2ZP2taPmY0hPgb7jbPth+g9tmOrqZNGu2mm6AQIcxnl4rXPrcJ7dWztBKQzcng0YICMTHoLGH7EfZC1Ucu+nuGsAY+XVGl7OzeCiAwKSm8hDZtV3CbzyhjGC5HGQIK1pd9c+fUJOfUcyAZ67hSDnuyuC7B0ThV2Dgdh5ua0AduIZ0INGweRPuXnoJkd1DOkG0o4f3Q1DwMwD1ieWHv8tY/hUQVC3VvsElnJxwYqGll2dJoimFx2sRXAsOCndYEkR+lmDn/Wo7At6M8jWH+S6P4RYKDwVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jsT23FV4u1poMdOY4U2CNfxsvEa482Oa6zZ2QzsCHgs=;
 b=jYRm/gQtstXRnpxP/xHnSRUKMO4JGsm5gM/7EzS5IYPv7YcnTrlvkLOdOtqlxOIt40wr0oOML4YP2zw71tpud0Sl/9i6eek24CfIpzlHCIBpt0/phAa/ahOaTRIU98ISd/xdo0FWxc7yCKa8g2r1R2srJQXUn09RcGIApqnaFrwpQ6qy6wnBQM4Tpig7AEsxrJKoTghzE+ez+4K0CQ9fbEOTdm8ILrvYlOzm1mQSmGGJxAUK7NL4zvJmuHitwsa0rnEhyHrB22AqqoM563PuUtiqk6bE7jCGYjxkpBqe4mO6YMOOzu6cxstNzqg89vn78G5gVai4XfqAyOFWATbjXw==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by MW4PR12MB7216.namprd12.prod.outlook.com (2603:10b6:303:226::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Mon, 9 Jan
 2023 07:09:09 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::b84c:b6e:dc0:8d7]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::b84c:b6e:dc0:8d7%2]) with mapi id 15.20.5986.018; Mon, 9 Jan 2023
 07:09:09 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Keith Busch <kbusch@meta.com>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>, "hch@lst.de" <hch@lst.de>,
	"sagi@grimberg.me" <sagi@grimberg.me>
CC: Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH 2/4] nvme-pci: use mapped entries for sgl decision
Thread-Topic: [PATCH 2/4] nvme-pci: use mapped entries for sgl decision
Thread-Index: AQHZIVy27v1bTbA2+E6Vyr7s0bUMgq6Vr84A
Date: Mon, 9 Jan 2023 07:09:09 +0000
Message-ID: <f892925a-8394-681f-bc05-8bb698916c8a@nvidia.com>
References: <20230105202833.3225645-1-kbusch@meta.com>
 <20230105202833.3225645-3-kbusch@meta.com>
In-Reply-To: <20230105202833.3225645-3-kbusch@meta.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|MW4PR12MB7216:EE_
x-ms-office365-filtering-correlation-id: f1ea2f6e-c974-4027-5399-08daf210673d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  wLrMm2oIN2y/iTBYRFfLs9SOwt8d/En60cXYXgAtghz7OeqNuJlWW1yvDNqFokfEGCxUgFXGZ+qGJXDtN+MDNIWVfOD0wmvXvPMtuvy9sAhNQdOXYUS4HpouHlnlhFQ9VvCD9PP8ZORGhiYp0My2M0Uzza6S0WTJon0s45GT06UkO/vwGLS3dv/CWiqhzVE1P4ADnCZ3ZRLq5ed3hJaCUy/nqXv+VDE8nK7ZNlvJDJnljl+jBpp55bH77yQV6SCkI8qxF6sFpki6BNLU4Oy7tjnTgH9xnjiArFRKvSBlUKARmLNtQJ7JJSKxujdF3akM1Svr2A2L+Xju10tmaSsroT9cGEPYM6WWumBTQkX+Bya9rJ6y7fxm+WdVJwO7KQBZnLEcdGNdEhVzEnRxNhnboWx4PPx7EdaCeS48Avw274UyblI1ImcBA6FvbnmPIRWYBaGwKOTGPt32qLUHWPeeWyv1vdTb0OYEWEYDSHyPYHXvp8dKoSSYwITXm2RpU6dQXaIdyKgaXcCACdFg4LnsYzNQFoC3o1oqjEE4rRFWhPNhV/w0GJJWIX1akjz5i1rS3mGxV1vxy+9gpnKdgBC01AVB1MYUZjNMJfIwob76CLjTcBCpsybg5T1pZaRzTiokmW43md9WbSkCPQpCB6Srz+KDj2zUOvJDnyWRLLbPDj4b9Fnc46trWcSvUS8jbE77BZBVDGA0ODMuQEDQtVpTBbNbtCLGv1mdjKpl24FbIcpciUbFAAJhsvt07lbnTBUouXGUKb2JbAQbcGpFU92mrg==
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(39860400002)(396003)(346002)(136003)(376002)(451199015)(53546011)(2906002)(71200400001)(6506007)(6486002)(478600001)(186003)(6512007)(31686004)(110136005)(316002)(2616005)(36756003)(66446008)(76116006)(66476007)(66556008)(8676002)(66946007)(64756008)(4326008)(41300700001)(5660300002)(4744005)(122000001)(38100700002)(8936002)(38070700005)(91956017)(86362001)(31696002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:  =?utf-8?B?LzlXVlFwOVlXcmpqTjdITG9WanhXR0xLTmE5UTNvd3RkckYyMy9CQTVrQWdu?=
 =?utf-8?B?UFpVVm9mOHQ1SGlET25jTm5PSnRzd3lLYnFIR0w0bnhMWVgvMEh2NDI1S2ds?=
 =?utf-8?B?bjhzWVg4OUtSeDJjWkU4VE5pUFFpVHA2OU5BQStnYTJTYWhWSVhsRksvTXA5?=
 =?utf-8?B?RHpFdnlodzVJa25MTGYyZm1OYUlFZVptUEJ2Z0kzWnd6L2dKSytmZWwwaHAw?=
 =?utf-8?B?UUhEUExTa3U1Z1FGb1FTNDNzTm5leE80cVBUL3d5Mlh6RVBtQ0xLOVRHc1Ju?=
 =?utf-8?B?WTV2c2ZCa1cxQUM2YlFyVy90QUl0b1pBTlltQ1lyMWxRL1gvSFhZeVliZHEz?=
 =?utf-8?B?a3NvbE9VQUwrQ3BjRDJqS1FqY2VyNVdQd2U2Ty9hbUdBVHRZdnNxZHVIblFi?=
 =?utf-8?B?UGpQWUl3ZTVydDk0enFLQ1I5bHlsOXNvMDl0dHE2emErQ0J3amFKMHl5bVQw?=
 =?utf-8?B?dmJZTUZoQkQ2b1dkdndLOTAzTXZ6bkhCbFR6R2kxUlVPRDN0UFNnYlpqbHpl?=
 =?utf-8?B?NTRyZ3A4ZEU5Y0VKWUZubUt2T3A2WGVhako0SUFQOTNvYzl6MDQxMWd5bnRD?=
 =?utf-8?B?ZUtLa24zMWI2S3JMNXFhQnB2ZGdPdk9PWFU5eU1lMUNpa3RmUnY1MEJab2FQ?=
 =?utf-8?B?TUFKNjlEQlREQkY2ektWR281NFlPVmRsQUxqY0V1Q093L2dDVU1MdFZJTkYx?=
 =?utf-8?B?bHY4K0IzU0EwNHdDY0Yzc0szV0RIckRucFhtRnBSd2w5L01ZNkZ2a1JOVktL?=
 =?utf-8?B?dkM4a1ZrWlJTZmZEdGVXaFZPSHNFQTBXRTdZYjF4OVo4UWpKUUxHMGRBWVI4?=
 =?utf-8?B?WUJid1U4OUpDRDkyRy92REthQVRLQklSUXRIVWhOdGo3UjFoVmtTTWNWUDhE?=
 =?utf-8?B?dW5hY09ldXlyU0U3ejA3NWdCR1VOb243VVRDTFpLcGV0dUJqbHlzSlY2czdO?=
 =?utf-8?B?MVpHMENud0IvV3dtWCtpUFNjU1JoMDdwT3ExMFB3czlzMGplK3duVUk1SjF6?=
 =?utf-8?B?cStrRndkR05ZTG5jMUNxZ0NQSDFPVXZrMGQzZStaVzhmWEMzWkVMcU1nS3A5?=
 =?utf-8?B?ZmorWDBPdWhLZkNTSU9lL0M4WjkwanQ2YkFCZGNwR29SRzEwR0E5N3p5R2Zy?=
 =?utf-8?B?U0swVGt2aXlhaStXQnJxaHU3cUtMVmJtMUNNSDFxMGhIZGlnSnFHdnlZQXdt?=
 =?utf-8?B?NVYzTlpyUnpkN1ZlOUl1MXl3enI5S1gzNWxHaFJLMzYzUFFYdG1pWVdkRkdU?=
 =?utf-8?B?REdya0M0TWZ3UFhYSUtBRnEwRk02bDhsZkRMbDVIN1B2Mm0rT3BzOUl6cG1V?=
 =?utf-8?B?ejNzTEVoYis5UENiUG9VREJXWk00MlVsM2xJTGdOaFFNUCs3T21XQUlsNEtW?=
 =?utf-8?B?ZHgrVExVdkUwb2tMZkY3MFRMaytoSnVYVEpyNnprTFkyNUxHRC9IZ2pVSTR5?=
 =?utf-8?B?MlduR2MwSHQ2QWp5Vm1qOG1QRWd6R21BOE05Yjk2b2sydE9JUzlTOXVyTk1I?=
 =?utf-8?B?YWZRQ2gzMnNQSzJIdmMrUTdGMnNoWEVaSGhTeUw5Nzd6a2hadHUzSWpxOGww?=
 =?utf-8?B?VDI2TERGMk1hNSttSDE4T2NTUTcwaWYvOUhpOW1NeEpQVEExQjRUZlJvbWVQ?=
 =?utf-8?B?Y21qQUk5T0IwdVYrSFpsMUR0TkgvcVVxcjRmWTFGYVgrZW9QZnhYVkJiTm4z?=
 =?utf-8?B?RUhxOUhIVGlHK2d0Nkc4TlVoR0VkMG1iRG9IK0d5SFJqTGJEMmNncHBENEZs?=
 =?utf-8?B?MVdSaEtUM3dnajBBS01wSitjaEtBTjQ5VUxjZzR3WjJXZWVCbDZBOVptUkhM?=
 =?utf-8?B?dlI1c2FzNWc2M0V6Q0lUdWlTbHkwbG00OWl0blVPMyt3RjhMZzRPc2hCWlpl?=
 =?utf-8?B?bXd1Wndrbkp2dlNFdUduNEJGVHRSZ1BpTUpNSjgrcFVKRWpwOEQ3RTFOYmVa?=
 =?utf-8?B?SHFVQlhldks4d1F5MWhqSFpML3pvYk1QVVZva0pKcVNUT0pzMmw5bFpjQU5w?=
 =?utf-8?B?aUZEcWU2UkppMlA3VEVXUFNpcUxPV1hxUlV6d2VOVjlIWllLWDdhc0l6c1ZY?=
 =?utf-8?B?WUxBYm9GQm9oUGhBVWYybW5ZTGRCM1pTV21vQm02ZjcyVEcwNlJKL2ZZY3VU?=
 =?utf-8?B?My9VbUNoWW9TdmpkUmtJell2bGQxVk9XZS9kRWFNeDlGYS9LTjI0Qzlad1B4?=
 =?utf-8?B?bFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F834185EDB9F2548B8531D2A6E8B6FD0@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1ea2f6e-c974-4027-5399-08daf210673d
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jan 2023 07:09:09.1348
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: F/J1hSxAsD/6mdTM438kBj4z8AkX2UObHtiPaFQBs6qDcWGBdglwIrF52Za/cA/WRbKVGm3AYFmzBhHxjZ/thA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7216
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230108_230911_822378_BD2B17AF 
X-CRM114-Status: GOOD (  11.09  )
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

T24gMS81LzIzIDEyOjI4LCBLZWl0aCBCdXNjaCB3cm90ZToNCj4gRnJvbTogS2VpdGggQnVzY2gg
PGtidXNjaEBrZXJuZWwub3JnPg0KPiANCj4gVGhlIGRyaXZlciB1c2VzIHRoZSBkbWEgZW50cmll
cyBmb3Igc2V0dGluZyB1cCBpdHMgY29tbWFuZCdzIFNHTC9QUlANCj4gbGlzdHMuIFRoZSBkbWEg
bWFwcGluZyBtaWdodCBoYXZlIGZld2VyIGVudHJpZXMgdGhhbiB0aGUgcGh5c2ljYWwNCj4gc2Vn
bWVudHMsIHNvIGNoZWNrIHRoZSBkbWEgbWFwcGVkIGNvdW50IHRvIGRldGVybWluZSB3aGljaCBu
dm1lIGRhdGENCj4gbGF5b3V0IG1ldGhvZCBpcyBtb3JlIG9wdGltYWwuDQo+IA0KPiBTaWduZWQt
b2ZmLWJ5OiBLZWl0aCBCdXNjaCA8a2J1c2NoQGtlcm5lbC5vcmc+DQo+IFJldmlld2VkLWJ5OiBT
YWdpIEdyaW1iZXJnIDxzYWdpQGdyaW1iZXJnLm1lPg0KPiAtLS0NCg0KSSB2YWd1ZWx5IHJlbWVt
YmVyIGEgc2ltaWxhciBidWcgaW4gdGhpcyBhcmVhIHdoZXJlIHRoaXMgYWN0dWFsbHkgaGFwcGVu
ZWQNCg0KUmV2aWV3ZWQtYnk6IENoYWl0YW55YSBLdWxrYXJuaSA8a2NoQG52aWRpYS5jb20+DQoN
Ci1jaw0KDQo=

