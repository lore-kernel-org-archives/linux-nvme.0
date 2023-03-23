Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D8ADC7619A
	for <linux-nvme@archiver.kernel.org>; Thu, 23 Mar 2023 22:24:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mmBLlguNC//5s0XlYUTxa36JyO4cxIBt+QkZ9wWYtMI=; b=jCbU0VScsuhdT1xnZjVf0ruYl1
	mN14LVxXqBCUAAA+oY343mXx5/Qi4fCCzdKSbuRWXsxg3U0N/ys0pGUmHoR6slq6YMVpd9CxfIxBS
	iWFy6fNGB09bGT0UwqfeQQ/cpMSXJN+1hMy4vVXMuCtSHDYhYUscAKn9f3NLsJlOfxI3rLIiFjdNW
	lC7YpVitnFOv2LPXReUtTg3WHvzbB36QSG70zkkW2+d8zv3qbpp4eZisVo2vXskZDfb05qkrPT3oq
	6sE1cIt9AWZQlv43TYxyeOGWBOAwUCK+4t7HAH2USwr8Sil73SGOIOf1duJsyMh1Qg389mgWDlQa5
	NQcvrrqA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pfTM0-0034mP-0D;
	Thu, 23 Mar 2023 22:24:16 +0000
Received: from mail-bn8nam12on2061d.outbound.protection.outlook.com ([2a01:111:f400:fe5b::61d] helo=NAM12-BN8-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pfTLx-0034lj-1Y
	for linux-nvme@lists.infradead.org;
	Thu, 23 Mar 2023 22:24:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FBikOvDI5ftsQ+8AhHWwKGCstlbgQTk6yOyOzgxw6f2uPdeE3t35B/XkOzhE7u2d7SXUwUIjiJZdtsRNsm877B5fBOxPXc//MG6zhOx0MFgIJ+1ftmlf1BdXp3Tl1cJJcTP5Qwnn8QgQZ7iBZk9ZgFVChawag4quv2yXmNZOxWxxRftHlFtMzm+g0CVTcEq4TbviyRxZQj+wY5DZF/gYS0xork17Yz3E3WcOD5xAfyKtJBwXZYwDvwhKd33aaC/9bpmLGEXHGi5ogqC3VhB/AF/eI4MQumPAhLC1ZI/noqKWoDQEJ8bkL1vO/RHn9KR/e/qDkQgHLJJBrWgfwvQqxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mmBLlguNC//5s0XlYUTxa36JyO4cxIBt+QkZ9wWYtMI=;
 b=DCoDPID5fDWAHbwGXVZOhBIOYb+Sjcl5FMEacvLae5TuxGSoSyj2mjZ42rclltx4AJ6tNZ4swdokzzD0FNES842bkYGLpzZVpdRyYHOCe38IaQ+Wno4Z/LyTwjL2/7+OST+aJ/zkbXNINkFcXyxEdBQTuycQCE7F6EEPKrq0hoXOItIhTubkxaulU6yaLQ1UhYLZUd01MpYalnwm+ammMyBquEdCdKuhxgM1iwpwrMjHaCaElrOvu9my+sr879s/U5eyPZlc+GSYmODBRKKrhE6+Wlj78MQsCw25mbEE9I+HIjMgo5ubcrBi91VmULUSmdhcXuuaTrKRYOVsxr6pdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mmBLlguNC//5s0XlYUTxa36JyO4cxIBt+QkZ9wWYtMI=;
 b=aO5G1oHU4kdG2CBl9g3BVCNrvdEsyerRhLSgNd32WftDkIno5S5jWmuVdvZqYyvMN4KsDKv3M3C5u63MzTad5OsWNyt7HWylfxlzS6x1bJceV+fHWpu1KeyjBW2BtHPacKXLIcfQzJHgJkga03NWcPVEVB6R31/m7dhyClUqNoPB3FIGcF13W0n8mcJVCyDrF5nmAEyOYokbcjtYtYLNdUwauVhHuX6jdVUmf2MtO+RKdMO1Og3X1mCGQi5P8jGqeL2uBIfN3iImd1/yiEFjmkZs0PXne9Qbt5X7MHLEQrNrc214jWWVsDl/GelvkxIoIydMQ1JpTssHlUaOWz2H9Q==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by DM4PR12MB5231.namprd12.prod.outlook.com (2603:10b6:5:39b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.38; Thu, 23 Mar
 2023 22:24:09 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::9f90:cf3d:d640:a90b]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::9f90:cf3d:d640:a90b%4]) with mapi id 15.20.6178.037; Thu, 23 Mar 2023
 22:24:09 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni
	<chaitanyak@nvidia.com>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>
CC: "kbusch@kernel.org" <kbusch@kernel.org>, "hch@lst.de" <hch@lst.de>,
	"hare@suse.de" <hare@suse.de>
Subject: Re: [PATCH 4/9] nvme-core: code cleanup for __nvme_check_ready()
Thread-Topic: [PATCH 4/9] nvme-core: code cleanup for __nvme_check_ready()
Thread-Index: AQHZXTjUBTxwmbq9mESKB9MoODpRb68IAUiAgADwpYA=
Date: Thu, 23 Mar 2023 22:24:09 +0000
Message-ID: <cba20f5f-b6bd-1f85-1bcc-1a60ab33a4b2@nvidia.com>
References: <20230323033636.812758-1-kch@nvidia.com>
 <20230323033636.812758-5-kch@nvidia.com>
 <2ab1614a-4fc7-f496-5d72-378c78a9da7a@grimberg.me>
In-Reply-To: <2ab1614a-4fc7-f496-5d72-378c78a9da7a@grimberg.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|DM4PR12MB5231:EE_
x-ms-office365-filtering-correlation-id: ac5ef3ef-dc2d-4242-e509-08db2bed52b4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  0XrUKFePbRCICU19ociGb3/u84s6zrafY7i43JqCdOBaz++Y0Wtoahtk9u5zoJ65WSBuZrhAJB3hQ/hG+R+oKgvTOZeJwkpU40Kxj9rnqFS4ulPaRpx6BO1p4B9hSvkQeL5Px8zSurDBsCbP6adPkhebMlHFVywIaVAA66HkmRLdwFfmDJCXlB2wowfGZPmrSATbVh61VtAIP/pnAM4KqD+Nt9AteD8TdeDxoUtG3BUvP9rOGbr7dhxY/sNYXuRN/IYWABuJuWEMyVavLX1rxtqeiWwVwXDvefbVLHbfNqbuIkiJkAV2ZvjNESAdPq53V0AuERFHgwOt5DOFxB0nVi1rPvJOgVqyjvyzijXWxHySzMG3Z5ALvr4hC3gxx3FitxZKTVRsf+wnW5FFDl7nLFatxOFMQ3kvjCh3Jz09PBM/n/323STyGDlSjJsuanI5BiECvfTtUA8f/GKqBSTWKH4Pl/5OVUgL2t0/jZ97NO3JgI0PVYpbjTHvLPeDOyrUK8QIfUg+4TFO3i96HPlFLIF3Wlpzm4wceIV0+h/FjrstkrySZu2GPCPZarQQdSeiITy0AR+NaTXsvrDmznP+VbYnK2MhafqRLocCxO9cM9q65mcu0j5w3g0Lgn75hXWSxRKKS3yE6E/wSlr71fsWTn+1y9XgZruRZzMS7Fp/d8FKOmLNKzAnuR36MUDKjADG7a61cGMl0lALh72q7tMEPWi0zcwmANoEKm5fiagycEzVXiBpAxdp6PVm9ZeoUYcyjdNKrIHbI+JDLX4wIlxEgw==
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(39860400002)(366004)(376002)(396003)(136003)(451199018)(86362001)(31696002)(36756003)(66446008)(38070700005)(66556008)(122000001)(64756008)(38100700002)(41300700001)(2906002)(4744005)(66476007)(5660300002)(8676002)(4326008)(8936002)(66946007)(2616005)(186003)(6506007)(83380400001)(6512007)(54906003)(91956017)(110136005)(478600001)(76116006)(316002)(6486002)(26005)(71200400001)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:  =?utf-8?B?ekV6YjV5bUdPTk5VbVlTbVBTMjl6NllhV213WHFZL0RrcHRWTUo5eTRaKzJ2?=
 =?utf-8?B?dWEySVVZWi9nVlVGMFZQSEVrRTlkWWE1UExJbHFHWFYvTjAyQnNDYWZIWFJZ?=
 =?utf-8?B?SENReWtCeWtXODZmMW40MmFWaERMV2JBcHQ1MUlOZ20xNTRENTFoOGx2WWJM?=
 =?utf-8?B?TWZQM3Nia0g3TzhjWWw5bFhjQW55ekM1elMzd1M3eGlDSS9qODBJOEsyZkNy?=
 =?utf-8?B?R3ZjVlNrQmQwMEFWT0xMQm5VZFd0Tmg3dTY1b09Jb0RHeEoxSDFqQStNU0JH?=
 =?utf-8?B?UDg2MHpWUlBNdHlBdERacEg1bnNtcDUrZWczWlFKOUtseDBxSG9DQVR6aFdX?=
 =?utf-8?B?QzUzeXdMdHpYRkoveGhvQ0ZvMXAxLy9CbUxoM0tKNk14VVljNHF5WWRmUVJB?=
 =?utf-8?B?L05DYmNUWVJ3NHdWVGd1MGNTTU5wSkZxZ1NJdnlhTlYydEhEQVZLVXFIazZH?=
 =?utf-8?B?YVNOT3Fza051SUdzSDJzZ3BmUzVaWTFHTC9VK2VQM1QvajBsRUV5R0Y5aWJv?=
 =?utf-8?B?T09lcFN1QmhJSDhHNmQrNHQ0ZnkvckZxNDNxSnd5N1NuSTNDM1Fka3lyTHk5?=
 =?utf-8?B?QVRyb1ZTNkh6T0RhRnhMcGFPTUZreVhrU1Q1dkZzcE1XYVRmNVZ6MlVMQmlp?=
 =?utf-8?B?QkxWWUJVMEdUcC8xSEtvVXIvS000R2p4bm41MEYvUGRRRHVRSTF5ZjVOcGlx?=
 =?utf-8?B?Tzh3Wjc0UzluU1g5UTBLZlNVSkRDS1lwRnU1UnRvNUY2TFo0UEhRclVQV0VM?=
 =?utf-8?B?RFhHQU4zVGp5cHR1dDZHQnRiTVA2ajVPWEFkUnQ3U1d5di84ZkVWUW9hc2t3?=
 =?utf-8?B?aXpjaWgyN2o5Q09paUl4T1QxNis3d0s2SGtPQUVKUXQ4R2wvVWN2WCtIWlFT?=
 =?utf-8?B?SDZZbUl6a0JiWmhFWTRnS3dYeHdqK0JBVjh2T1duaHNQWVlpV2dSeTJlRWNK?=
 =?utf-8?B?SENvYXI2RTZYTEJtaDJGL2dyaCt3UWxPVFkxSkcrRng2S0ZLbUZIRWZqY1Rz?=
 =?utf-8?B?cjMyNmlBQXlvWnpWbEtkV0RXVE5WWk11S2hVbXJsclFnNllwNW83Z1oyQldo?=
 =?utf-8?B?K3dxTTRVd0xqaU16SitteTZSM1NvTVZ1eTl4UkRmOHRwR3l5czB6RkFyR2dn?=
 =?utf-8?B?UWZ1alFyS2xCUHhyN0dsV2pSTE9kZmZiL3hSbjFUVnRoOEFTeE9INHlWNmF1?=
 =?utf-8?B?Nm9hZXkzdUN4ZWt2N2I0SW9YMG5PbHllMUxQODU5bFVtMUU1bXZRa2kxdE5Y?=
 =?utf-8?B?d3M5cDVyWEduWGRpQ3lIU1R4d3JEaGNQQWJ0RjJ1RE5Ub1FhU0Vvc2hkWWNu?=
 =?utf-8?B?bW05OVh0UVVUa0d1STdaUmNQUzcyZkQwaEp2S05IM3ZsZHZLKzR2bVlDUVJt?=
 =?utf-8?B?dWlLd0VKWStEU2tzeHo3NEtBSDZZMml5TUFKbEpXSy9NZDRYYW5rQ1FONU5q?=
 =?utf-8?B?ODE4elorZmsyUEZxSC9lWjVnYzhnV3B0eGx6dEdUMUJubW9ac0F1NGhMV3N6?=
 =?utf-8?B?dUJwd0JrUGNlOEFoVTlDTTkyME1VZ0MyNWc3bEtreUdaV3RKUG1hTjhZQUhE?=
 =?utf-8?B?WUJwTEJRVUwzQjdtMmN1dTUrTyt1ejNHL00ya2N2azBrMThhaE9wQTUvUDJC?=
 =?utf-8?B?RWpZUTcwMTBPbmpFUXpJSkxVMXM4M0djSm5GekdLcDhqWk1XUTJpRkU1bTZ3?=
 =?utf-8?B?b2sxSmNEcURVUWEzeHFhZnhOVjhBRFVBQ0hQK1FaYXYraTNPRit0MEJOUHVJ?=
 =?utf-8?B?WElHc1lBNVZGWnpaYXJpYWRmTnpRK0dhYmNobzZLSlMvVWV4ZGFxMjYvVDdC?=
 =?utf-8?B?Mm9pSVhWUThnWUpNNnNnU1NTdWpiYmQ2TDVDVVN4YStoTlhsVEVUeEwwOFNj?=
 =?utf-8?B?aGJsaDVJVmcrcGJIM1JmUXByUFNKejh6a2pyT0YyUkVraWdCTjJCejRyNlZO?=
 =?utf-8?B?K09mN3VrNElPLzJKSk1rcUoyZUdNZ3lCNUdwSGcvVjZXSFZBd3ZCWmxMUlRH?=
 =?utf-8?B?QUtoWlBCMDBKdlBBQ0s4SUpBek13VGUvNjRvclBMQ3hpMDArcTAyZlY0V2pa?=
 =?utf-8?B?RVloakVwSW5INE1rQWp3M3BmS3dVK21LSlhOQjFGeGtxbisrREsxUUdCY0th?=
 =?utf-8?Q?SKDBO7SbbEO7a8c4QCJJZg7qZ?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A289DB8CA92B574ABAE15523D7D8D27A@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac5ef3ef-dc2d-4242-e509-08db2bed52b4
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Mar 2023 22:24:09.7418
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EBRAFD1B6cq3/QdWUmLYdBEC2GY0sT0PFw1CD5ddk0cuLu8+97+eWwb6WB2Rl1h1m/7BHlnICznFjddfSgXxIw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5231
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230323_152413_521160_9E4837FF 
X-CRM114-Status: GOOD (  13.67  )
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

DQo+PiArwqDCoMKgwqAgKiBPbmx5IGFsbG93IGNvbW1hbmRzIG9uIGEgbGl2ZSBxdWV1ZSwgZXhj
ZXB0IGZvciANCj4+IGNvbm5lY3QvYXV0aF9zZW5kLw0KPj4gK8KgwqDCoMKgICogYXV0aF9yZWN2
IGNvbW1hbmRzIHdoaWNoIGFyZSByZXF1aXJlIHRvIHNldCB0aGUgcXVldWUgbGl2ZSBpbiANCj4+
IHRoZQ0KPj4gK8KgwqDCoMKgICogYXBwcm9wcmlhdGUgc3RhdGVzLg0KPj4gK8KgwqDCoMKgICov
DQo+PiArwqDCoMKgIHN3aXRjaCAoY3RybC0+c3RhdGUpIHsNCj4+ICvCoMKgwqAgY2FzZSBOVk1F
X0NUUkxfQ09OTkVDVElORzoNCj4+ICvCoMKgwqDCoMKgwqDCoCBpZiAoYmxrX3JxX2lzX3Bhc3N0
aHJvdWdoKHJxKSAmJg0KPj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgbnZtZV9pc19mYWJyaWNz
KHJlcS0+Y21kKSkgew0KPj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgc3dpdGNoIChyZXEtPmNt
ZC0+ZmFicmljcy5mY3R5cGUpIHsNCj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGNhc2UgbnZt
ZV9mYWJyaWNzX3R5cGVfY29ubmVjdDoNCj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGNhc2Ug
bnZtZV9mYWJyaWNzX3R5cGVfYXV0aF9zZW5kOg0KPj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
Y2FzZSBudm1lX2ZhYnJpY3NfdHlwZV9hdXRoX3JlY2VpdmU6DQo+PiDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIHJldHVybiB0cnVlOw0KPj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgYnJlYWs7DQo+PiAtwqDCoMKgwqDCoMKgwqAgZGVmYXVsdDoNCj4+IC3CoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIGJyZWFrOw0KPj4gLcKgwqDCoMKgwqDCoMKgIGNhc2UgTlZNRV9DVFJMX0RFQUQ6
DQo+PiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCByZXR1cm4gZmFsc2U7DQo+PiArwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCBkZWZhdWx0Og0KPj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCBicmVhazsNCj4NCj4gSSB0aGluayB3ZSBjYW4gc2FmZWx5IHJlbW92ZSB0aGUgZGVmYXVsdCBj
YXNlIGhlcmUuDQo+DQo+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB9DQo+PiDCoMKgwqDCoMKg
wqDCoMKgwqAgfQ0KPj4gK8KgwqDCoMKgwqDCoMKgIGJyZWFrOw0KPj4gK8KgwqDCoCBkZWZhdWx0
Og0KPj4gK8KgwqDCoMKgwqDCoMKgIGJyZWFrOw0KPg0KPiBXaGlsZSB3ZSdyZSBhdCBpdCwgc2Ft
ZSBoZXJlLg0KPg0KPj4gK8KgwqDCoCBjYXNlIE5WTUVfQ1RSTF9ERUFEOg0KPj4gK8KgwqDCoMKg
wqDCoMKgIHJldHVybiBmYWxzZTsNCj4NCg0Kb25seSBjb25jZXJuIGlzIGlmIHdlIHNob3VsZCBr
ZWVwIHRvIGF2b2lkIGFueSBzdHVwaWQgd2FybmluZ3MNCmZyb20gc29tZSBzdGF0aWMgY29kZSBh
bmFseXplcnMgdGhhdCBJIGRvbid0IGhhdmUgLi4uDQoNCi1jaw0KDQoNCg==

