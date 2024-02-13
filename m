Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0436CC48260
	for <linux-nvme@archiver.kernel.org>; Tue, 13 Feb 2024 07:43:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=tdwJCiHTT4owCeKfiuzjbZkz1ieXvPexWlMX6pDPcEE=; b=MzidFYfNdFMpcmnxMBARxHXwvY
	IYKBsfkp5XHXR9J7UyFWeHARlV6Z225h43Dl6zld+95QyGiyCJn8KSx93SbI2UnfbF/ucuh72Bs8g
	rtkQiPks4xkov1se4KwsQZBkrjtS0N85vuOrcimHAvcK2m566kYFTIcB2oqJIWFR0XpoxNQapXGvl
	GW1PE4j4Qqv+7Ochi9LnqiAel2HBoqFZ4YVNzSYk6mHIRvu464w5ua2+RQZ3YtiOwrKXivTaf/jgo
	M+pictu1CU0aiNb6qAhTUz4STZB5l/2kfHv9LfIrhp+nGNuqykwiCThL6KGuun6byS54lFboG4nFF
	5KiIuLuQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rZnSF-00000008IFQ-3wAv;
	Tue, 13 Feb 2024 07:43:47 +0000
Received: from mail-bn8nam11on20601.outbound.protection.outlook.com ([2a01:111:f403:2414::601] helo=NAM11-BN8-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rZnSD-00000008IEv-0NKS
	for linux-nvme@lists.infradead.org;
	Tue, 13 Feb 2024 07:43:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BBBbIGiCgoyEUM0HAa7W+DFK1w8UOAOUL+RbVsAahtJuWxL98p2SXkLq8ak++7jDIA+t4IM4jhBjiu+nDYN4WhAyegZpUGCLETOIHmlWWSPv9QAmwNBtAWy4pMGTIr2YjMMTc2KP4iZ31ZOST2TGClSr6GpsXiS0J0vlXf7YPzQXhYjxcaQI4SUpuhVqLdXSoqH1s9NrVa7DMfcbn/xYHMbtQFlfFYCx2t+/JONfvd18lg3Tb5Um6Kx9ZZNNh2uILuLQs9WPIwgsSk03XecjDnpNl2Z2D9Cpo2yNlwFxvfDkbzO3lMgKihMWCnJWG9D1UPMSlFrY9iBEru7gxDj/uA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tdwJCiHTT4owCeKfiuzjbZkz1ieXvPexWlMX6pDPcEE=;
 b=MuVkgwxt8h3culwBkiCxPyUk/hrffOvwolP+/tjs+2WRFk1+nEAD+QFLm+kzT/YXPCGs49lFsONaSlgjcFh+JcxhKOW90aAfQpf4TBvdurHAvkqQbFSIFdj6sq4x2I+Tpn3EmlFA0nDNq/gl78pQbnmDaKouRbY5VYC3TmBb7VrhTZ1RWEVCFKTk8ZgbGKKTSBHRYT3P8EPu9Pz8lZRBdg1bMy/fJ/m8el9K7T19mzXmqZn6D2RKkXrbUFKJM1Qr5iNRWu4gMSyDTKVfZ5YutJNX72msilivM5xmRfZzUXjNqpQFu143PT4Y1AB+ijAP7huGAwbG3ZBC7n8Ds+vtvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tdwJCiHTT4owCeKfiuzjbZkz1ieXvPexWlMX6pDPcEE=;
 b=B9UNnaOnHtQL1mLjJAQlIs18cjoVUf5csH4ZkLRyBox623qBPIRDZhBKyDMX3gzSHGZk/+zUDVsqeTU0pUyHAFW347vfa7RCDFAbxk8bgDm7St/U6M7Q51sgtHtDdAJj1Z4dRtR8PSSHXhUv9ZFpZKKjVj8Wtl+Pks6ZMeZlQPYWMJ1dYUvk/C6fW47EPtsg5sfIXpO76OX07pyKszhvmS6nXVUDwv6mdrIiHLwvTLAhhc7PlKDjWWX28MRmvKLzAsiRQs5TtVthy6DpomXsKF+nB/a22+aFpTCkkSjhnfFcSq50wDXjgQHknNxEDvaLfvXTVrBv6KcxxyBXHQAAeQ==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by DM4PR12MB5985.namprd12.prod.outlook.com (2603:10b6:8:68::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.25; Tue, 13 Feb
 2024 07:43:38 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::ffce:bbde:c1ca:39ed]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::ffce:bbde:c1ca:39ed%4]) with mapi id 15.20.7292.022; Tue, 13 Feb 2024
 07:43:37 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Christoph Hellwig <hch@lst.de>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"kbusch@kernel.org" <kbusch@kernel.org>, "sagi@grimberg.me"
	<sagi@grimberg.me>, Chaitanya Kulkarni <chaitanyak@nvidia.com>
Subject: Re: [PATCH] nvmet: nvmet.h configfs helper cleanup
Thread-Topic: [PATCH] nvmet: nvmet.h configfs helper cleanup
Thread-Index: AQHaXUOrvn4oChs7NUuIYb5N6RZRCrEGR3iAgAGetYA=
Date: Tue, 13 Feb 2024 07:43:37 +0000
Message-ID: <655bf625-c998-4bac-a126-7d25b61f454a@nvidia.com>
References: <20240211233949.18219-1-kch@nvidia.com>
 <20240212065919.GB17561@lst.de>
In-Reply-To: <20240212065919.GB17561@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|DM4PR12MB5985:EE_
x-ms-office365-filtering-correlation-id: 79762a7f-a39b-417b-7cc6-08dc2c677d8c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Cc8SVkNvnWa0nQbv2ewBXJf7CpeCs+2BYf7fbz1xQTma7GAiagV4yN5fMfDEgcHPjFiXEPUFoeKCEXnl+TOj6f04s98ZoJsYmr4BvEUa5Gq8sQbxmieO2eI/Q72/KpYLqLcFqUKa/Rso5tLybQKkCfA+1YSVUccU5vOfTpbaVqUnrFZ5DcartKQq0jj6633Jf+adZxbgjEr7Devf+uFfLyKo15kIuyOSNkQtZr/DX+9cwPeYyEFYM78AYLtsHgZl5X+MYmXh53dj532OMpIpG0gqq4D6Zke5Hse8i/WsSH47d50O6lsmG3VzqtXkffKCvTu4GIwaJJYChpRcHNuqLSa7EXn/570Ns2MD5lEU5WriYf0rSvUL7D6QWl3t4coo+aI7vuZ+EmXvNsyK/iRYVgcHh6TmN+ptsQUR3DLlIAIFcUZ6GE0PuuqfCZh8Rq8aHoRvYWAP3LT5O5ChFpHmCrPEhcyvnVczgizfKkHKzWOQaxKwP2wOtvjCuPWj6o/D4FcFcwC9WSR5woR3q7LAESfuNlI1lLUyhmXULGxS+mI9hXbev+Y1yMsNSFAZk2YmwMS8F8aZmScCeTs7aLd3m1AAzP0eBoMvkbVZNksK+KErTdVSmDjoyrBAiedXnotA
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(346002)(136003)(366004)(39860400002)(230922051799003)(186009)(451199024)(64100799003)(1800799012)(31686004)(54906003)(71200400001)(316002)(5660300002)(4744005)(2906002)(66476007)(91956017)(66946007)(66556008)(64756008)(66446008)(76116006)(86362001)(31696002)(6486002)(4326008)(6916009)(8676002)(8936002)(53546011)(6512007)(478600001)(38070700009)(107886003)(41300700001)(36756003)(2616005)(6506007)(122000001)(38100700002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZXA3WC9iZUpKb2lyQUdvOTU2WEQ3R2RoT0lQTnI2dCtIRElTWU1lNXRkTDRE?=
 =?utf-8?B?YjBmdFgyaHBNL3BrYkhzS1BHT1d5aWN4U3cxNVhPNDdZRVZlNitnblYrTTlz?=
 =?utf-8?B?U2JXLzd4eGFhTkZIRXJGcjUwd2NLRTI5MWp4MXN1WTJ5NXdoWUFIeTFYbDRv?=
 =?utf-8?B?VWM5c3BwTTcvU1Y3ZTlub1ZiREthSDNObkRIRDhxUml2a0o3d2ZnbUJQYU9N?=
 =?utf-8?B?Zm9PUE16enNoT0ZOcG5mRGxTU0J6ait4UTdqdmttNGJXL2s4SVlDbGFwNWU3?=
 =?utf-8?B?VnJBZ2NRNjN1bUZISmptSEV2ZFpjUnhsaHBqVFFrdndjQjBpam9RU0RMSUVq?=
 =?utf-8?B?ZGE5TmNUUUJrYmZUcmkxMjg3QkMvblp2RElRN0pYWENqUmZsU3d4NitqbFlo?=
 =?utf-8?B?VlpoTEZWSnowV2pwSUI1RjA2R0xQeUVad2NGczZ1dFlKWFcrNmNWMDFLUGtq?=
 =?utf-8?B?dXRFMjB0RVFzRnJWT0xDZEl1aFZaRHdxTXh5amwwU3hTZ3phQlBOSEVFa1l6?=
 =?utf-8?B?NW1lT0hiWXE5MHNrSGFoa0lzWG9NVjZGU01LeFJjN0xPVUVDNUlqYWF2SVRy?=
 =?utf-8?B?b3puRXd4eXV1R3ZuSE92Q1ZzVHovdEM2ODFhb1J5ek8xU1l0cXZrVnFuNzBq?=
 =?utf-8?B?ekgvSitmakhsdEZmL3dOc09mODdJTmtiR3E4Y1kvMjI1eDZuc3ROL01OZkR6?=
 =?utf-8?B?N29aWW00eEZHbElsVTUyK1JRTm0rZUVTNEVINzNBOWZEbkRsQUNTWEVlSm96?=
 =?utf-8?B?ZFlXOXk2dDdlWUVxMytZbnRxRE1WeG16SkYrR2V0U0lsSjFVN1E1SmFvSXZp?=
 =?utf-8?B?NFJKbzlQaTdaY01tNERKL2VSRjMwMXZtRzBYODliQmorNXFFcVl5TDgreWFV?=
 =?utf-8?B?NS8wa2liYVF6cWhCbkg4RUdyOFJmTlFBK29LTEtTMmR2NlVrWjYxdUpDcFk0?=
 =?utf-8?B?NnBnVmxYdURFblppRkVRNUlVVGo5ZGJwbzZNWXJObnRlb3VTVzZhR0tKU0lp?=
 =?utf-8?B?UlF4cDRmUVNldnFrS0hvWTBZMnhTdnB4dUJmeWhHM1pMemxabUZ6K25RWnht?=
 =?utf-8?B?NWpDMzF5YkFEajNFUG94KzNzcEhBZXoxVVBrcllMNnN3ZnZwMTZFRG1LQXlv?=
 =?utf-8?B?eEkyVENYNUZYUXVuNGlIbDhPNTZCRlhWUFNwSTlTdVIvTGtBQnBQa09jUVFL?=
 =?utf-8?B?QVNWeFpSb0JBVHlFbE9JOFU5NVRDaTZ4U0hjeDZjTEFZOExwM2lkdUU0VVFW?=
 =?utf-8?B?dkhVcDNiQkF5QlBrcW5JQncyaEttSmZ6S1VRSDRNajJzTGtSd2lmTGZQR1Z1?=
 =?utf-8?B?YWVadlBqS0l5c3diK05uTFhIYnZhYzY0VVlOcVhmVDE5akNpVEkwbFVOcDRM?=
 =?utf-8?B?cHpSWkRQTE5LL0N0VlphYlJwY2FtNCtHV29XUlJQaFFxSDA3NEdMbnkwdncw?=
 =?utf-8?B?OWpQdmpaa0pjc1dIalFJUW1RdDNFL2dpc1Raa0I0SlU4dnVoVW1QSVMwTWVJ?=
 =?utf-8?B?VVZOc0xhZHJsS3pMSG1mVzhpblNnSjhPVGlicWdsWHRZTzdXV2hKeTN4Wmdj?=
 =?utf-8?B?MW1iR1pWOWhXaTJrZ2p4VFVNLzQvWlBaM01sS2lQdUZhaGlpWmZhOXQxOTRQ?=
 =?utf-8?B?N2k4Y2dMRll0WUs5a1NCai9haXM3cmJ2Qy9mM2JFcVd3dHJaN1U4UTBmazB5?=
 =?utf-8?B?a3J4d1ArWFNFeW52SEo3ZndqalAzVU84QWFsK2YwdjhVQStCa0NLdFVOOW5D?=
 =?utf-8?B?UGpOZFRqSnFrSnE3eDJrMGNrcjFFNzdHTUswWjZVVEdkVWpaS1FHZGV6emZB?=
 =?utf-8?B?STcydGFaUDJVUk9QZStmalpHU2Z3OTV2Nm5LWW9lTnVsUTZiZFAzQmd4VmFR?=
 =?utf-8?B?OUFEQk1wajBGMzRrU0NtN0lDZzI0OGRqNU5zQkZsU0IrNkFISHh6Y3pndHd6?=
 =?utf-8?B?a1N1MkdvMEM1WTR0dXlOak01VXdQd21sS2FTcW9DZmtYWGZvd2tmTFVSbUV2?=
 =?utf-8?B?bGk0SkxKQzBuTlBmMktUTkRST29Ca3hSL1hTcSsyUmM0SzY4aXZZQjY5REJH?=
 =?utf-8?B?cGl3VFBxTm0zekZqV3hkMUpmWE9sTHNLYlE4d0t3bGVwSjgvUnhFU2taTEtG?=
 =?utf-8?B?OXppTGh5eDNUZ0ZRNThGTVpUNzFQVWRYZzJHdlVRbDlhTUNnTXI2eWdpWURW?=
 =?utf-8?Q?cO7grTaOqbHWnRNIqRXuF7y4r+v4/7bFwO1+LuMR/Pl8?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3311891995C287448D2499A6BF6A783C@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9404.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79762a7f-a39b-417b-7cc6-08dc2c677d8c
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Feb 2024 07:43:37.8755
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yMsnXkCT8EyZwTLnnCjW2E4bFFL+zZjH3JatlG6RVF76XAjMF0dVat8FtFzpe3WsVwsVwSqO7xFjiAHHzu+yvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5985
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240212_234345_156407_0DF752C7 
X-CRM114-Status: GOOD (  11.88  )
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

T24gMi8xMS8yNCAyMjo1OSwgQ2hyaXN0b3BoIEhlbGx3aWcgd3JvdGU6DQo+IE9uIFN1biwgRmVi
IDExLCAyMDI0IGF0IDAzOjM5OjQ5UE0gLTA4MDAsIENoYWl0YW55YSBLdWxrYXJuaSB3cm90ZToN
Cj4+IEZ1bmN0aW9ucyB0b19udm1ldF9ucygpLCB0b19hbmFfZ3JvdXAoKSwgdG9fc3Vic3lzKCks
IHRvX2hvc3QoKSBhbmQNCj4+IG5hbWVzcGFjZXNfdG9fc3Vic3lzKCkgYXJlIG9ubHkgdXNlZCBp
biB0YXJnZXQvY29uZmlnZnMuYywgbW92ZSBpdA0KPj4gdG8gdGhlIGFwcHJvcHJpYXRlIGZpbGUg
aW5zdGVhZCBvZiBibG9hdGluZyBjb21tb24gaGVhZGVyLg0KPiBEb2VzIGl0IG1hdHRlcj8gIEkg
ZmluZCBoYXZpbmcgdGhlIGhlbHBlcnMgdG8gZG8gYSBjb250YWluZXJfb2YgcmlnaHQNCj4gbmV4
dCB0byB0aGUgc3RydWN0dXJlcyB0aGV5IGFyZSB1c2VkIG9uIHByZXR0eSBoZWxwZnVsLg0KPg0K
DQpobW1tLCBmcm9tIHdoYXQgSSBrbm93IGl0IGlzIGEgYmFkIHByYWN0aWNlIHRvIGNhcnJ5IHBy
aXZhdGUgaW50ZXJmYWNlDQppbiBoZWFkZXIgZmlsZSB2cyBwcmlvcml0aXppbmcgdGhlIHJlYWRh
YmlsaXR5LCBwbGVhc2UgZGlzcmVnYXJkIHRoaXMNCnBhdGNoIGlmIGl0IGlzIGdvaW5nIHRvIGNy
ZWF0ZSBhbnkgaW5jb252ZW5pZW5jZS4NCg0KLWNrDQoNCg0K

