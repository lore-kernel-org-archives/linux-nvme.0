Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 721B9C433EF
	for <linux-nvme@archiver.kernel.org>; Tue, 12 Apr 2022 06:57:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=SWeuGrAxs0jHgZ15kpQDLTXCm5jgrGaXiF0etL/kj2w=; b=uvQNiI4QdTW0MdTFSWlVk9o3Ip
	sGGDhHN7N0Hw+z9zz/cNzEdJvKzuSJBeNoPgVvb7IoilwQujkD7H+dnlqBfuqPF2TADPYVIHrzMpt
	zlek+eLhQ/0maSWjGRIetRRHEOuqf2MH7E/YZnPED4GrauNf0X7aX1QEAujyL1P7/htPhUkYgJwQj
	oF77lTs4026AIPUtZZVJBREnpRj4GMc9DhLjZcShg0zgnrMT4LDnetSiGSWua6S889DmpP5SHxe0e
	8ldHsboQ4PXeP0QkAQaZEjCrWwHhn4lAusEPiEj41yOInKvMQMBdB8OlQlOpn9p/i1q4XMuV9yrRB
	uXwFkHmA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1neATG-00C1Ch-Km; Tue, 12 Apr 2022 06:57:50 +0000
Received: from mail-bn8nam11on2061e.outbound.protection.outlook.com
 ([2a01:111:f400:7eae::61e]
 helo=NAM11-BN8-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1neATD-00C19c-Le
 for linux-nvme@lists.infradead.org; Tue, 12 Apr 2022 06:57:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VB7VfOCiZqbugWcj7wAPwimbn242MscncJNB6CeSgUuk5RsnSLsw0D0up10d4JmGoI3yi75NXDlAITGLrYgq40ARp2mPncoPLPIak3AOdftYIGjzQ2Lc7NudTEWeSOklV5uM4EkeIhGWDcN5eyHeRRndXhIZS3LBZBFTglyJwRidn+vROYOKJoOPJvm5UqwZuu9yHinsvWJZ6DzOYB61yZ5D/vXq/kiaimvSBcFLoP/pT/PcGCO0Xq5bk0d/b+av/EHPoR9wJ4vCWAzzEBz5Mkh8elNW4usC4r4dagckixatmuafvJKW6D/fsigBCEdSpIW/WssfGqW5X6vI+Z373g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SWeuGrAxs0jHgZ15kpQDLTXCm5jgrGaXiF0etL/kj2w=;
 b=V4KYjBHYWc+gdwC1VPYukPM7k2psrqURzIBBG1HSZ1vunrU0C6fYdMWCTEbRy61vkyXFr/d6C5UcB8Y3zTZbIkVwJeIKXdwXUO40yCtlozTLjeHq0HoRq8jjxX7Jdw2G80KuuJ/gJm3yFEKC9YBI9/IcuKGzKwjL+JGA4GTWsktDBRc616smfV0ZLIL/CN+L3fJ524atMHaRvupH9encHms4/HR24jHOMxGFn3S5Qksy3m7STDjSmzjqQWCGK8xSiy0cDvFdNXp7EPYeDFvqFbbPcQnKH3Enj4FBKeDACoikshry8smNCknxBC4gwdG9yXj9mdR8XJXjGtVjQ4fcXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SWeuGrAxs0jHgZ15kpQDLTXCm5jgrGaXiF0etL/kj2w=;
 b=O/ngAwLkzoJQP2mAYwz4CQJMvke+hfYTUJkztQetO2jws/7opKamJQS+iDF5ATXFCQvUYywP+r5Au8SA/j4f/ejkGy8ZAfn2Rw2FDWFRFIFmdC273i7gjBOjcYWtKnCMn21Kqa0eLVsnMdfAzfIVlrqscOdNfhL/HIwvMMyOzUhHu6Llk3Dcdl9B+VdPrmJK+VtcG/lCxy6txg4nVZ7Z16EszrOkKI51PINwx41y73Y/aipoRg9MlOxdwaxG8Ce1NLXyioCpw9aiVdTFiSIn/Ge9aQDI8u09yoAGyI5FMUuSuzFrazF6Cdpj3r1tEnfMeSHxqthI08Z2YtWxqGwZ8g==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by LV2PR12MB5773.namprd12.prod.outlook.com (2603:10b6:408:17b::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29; Tue, 12 Apr
 2022 06:57:44 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::a90b:9df2:370c:e76b]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::a90b:9df2:370c:e76b%3]) with mapi id 15.20.5144.029; Tue, 12 Apr 2022
 06:57:43 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>, Sagi
 Grimberg <sagi@grimberg.me>
CC: Luis Chamberlain <mcgrof@kernel.org>, Klaus Jensen <its@irrelevant.dk>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 =?utf-8?B?6YeR6Z+s?= <me@kingtous.cn>
Subject: Re: [PATCH 2/3] nvme-pci: disable namespace identifiers for the MAXIO
 MAP1202
Thread-Topic: [PATCH 2/3] nvme-pci: disable namespace identifiers for the
 MAXIO MAP1202
Thread-Index: AQHYTjRSEoDbM3xXr0C4sVKlC00J36zr2M6A
Date: Tue, 12 Apr 2022 06:57:43 +0000
Message-ID: <2531ef4b-4b81-38a5-549c-b088a8e3ae21@nvidia.com>
References: <20220412061126.244414-1-hch@lst.de>
 <20220412061126.244414-3-hch@lst.de>
In-Reply-To: <20220412061126.244414-3-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ac026884-b88b-4165-cd0a-08da1c51be73
x-ms-traffictypediagnostic: LV2PR12MB5773:EE_
x-microsoft-antispam-prvs: <LV2PR12MB57730E9CDDB1FF20BEED3562A3ED9@LV2PR12MB5773.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tSExu3SHgPWnfcobpYdMomikaUZGncZMDjKb+ddfruOVdz+7TJsvLRUzul2v9gC5HX0QB9lf7eBD9DwWm9G8g49UIncFQvR+GdP2/NpCEQM5tVud+fyhyhIkn+pGtDAd3eIOFdlU6uapWqP2aBCdb0MLndSBqHEYHHR9lqX7vUSlFmWIJIYnZ97YeABCArKf7haejVsoKAMCkGU9SpXxE5moyuKPVYigg7K+yVvnUrvHflvEIdootUqrpZM/vlQRh+TrYN8G0S/pfDtOXoj6UprqJ25fe/ini8CWjWJQRlXV0YkSwjSyhLc27A+llTvojHc587Ym3kwnis/ri/rCgliChUCH1oEHFIt9qzcDEXJinv0i61vi2Cs7+ZflIiimv+VdNBwm2Fz7F+3+fyYWRx9hA9MGvr9+r72SsR5/5H/fkiwkvGbDw9F1Pliz7vZe77T4HToD5I7jJYISgxY3nHdNT972nMWIcS39MgPoNI7Y6jI8J9ox0kxtaeKBih5BLaP4LPKWGNADaNY6cyj2NMU716nVLD9alTdGwNJ7CTcSiSdwfqCfRLRJaKA6CLVEd1I9IEg627Eeu0btpeB2CPGnAoKEFwuioaPmTM8lvflWCh3AMfvK7PE6AMTWnUDt7nip9bbgVKBO3xukibEQ7dq6tEEPHSjugNynoSi9OWW3AcPBjYaTof9cwOz/Qs0b8XC+p90WDsRvZW202y+NeiZUAKY0O0ZUJHodKvua1SOH6rjkM0xPImFPXUbR2itcZquk6Dmix73cplH2EA76Bg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW2PR12MB4667.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(6486002)(38100700002)(2616005)(4744005)(122000001)(54906003)(110136005)(2906002)(6512007)(508600001)(53546011)(316002)(5660300002)(36756003)(31696002)(38070700005)(186003)(91956017)(6506007)(64756008)(71200400001)(66556008)(66446008)(4326008)(66476007)(8676002)(66946007)(8936002)(83380400001)(86362001)(76116006)(31686004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YkxQaXpXKzhGcXNGUjB1d2doVlozaXN5V0Zta2I0QzRrVHZ0MVhnTUsydnBk?=
 =?utf-8?B?YlJtTERGRCthL21vbVRHMTMyK0lMeHM5L0tSLy9aSnROUHRrWHJDdS9zaW0x?=
 =?utf-8?B?cDgrNE5UVzQ1TEN1b2hveWhrRGE3N0FuS0dhT0crSlViRWVvQ2pTWVAvWVpF?=
 =?utf-8?B?cEdrNGRqblNoQWE4ZXVIQUZ3S3UrTUM5QjFlblJ2bWNId0szaWM5WmxaN1Bi?=
 =?utf-8?B?ZVBUMWVLNmtyN3JLenhwQmxTaHJTY2RDM3V6VUJKbVBrRmNPdnh3MDBWV0U1?=
 =?utf-8?B?QjcwMnlkU0tBaUlFNmVNQ1ZqSTJsQ0dPMmdJdnpINmpJenRuUUhaWktURFJ0?=
 =?utf-8?B?RWdSMVBmQmtDTTFMT3ZqNjdDWXhsL1AvMWdVQ1gxaVVvaWRydTJWc01VZ0Nn?=
 =?utf-8?B?UXFLWkRXTGtZOUtnQXNGMTFuaHBBVmc5a0tXbi9vYWZpS3cwTGFyNFQ4b0s1?=
 =?utf-8?B?RmtEZ3FOODIyN1lSRWxxcEVzd3hveDQ3QVpQazk2S0NqcXZKUVhOdWdOMkRi?=
 =?utf-8?B?NXVnNHgwNnVVZFVDUUp2dzBBS0RSUjZPOUlUM2FzRHlGalkzMFV1dERDY29s?=
 =?utf-8?B?dXMrN1YrMVhoSllNdE0wMmV3NHBMNzRxU05PVFduQXNCTVhWWVRtKzdGK2g4?=
 =?utf-8?B?VGJQUEVqR05YMjJUVjU2V1dycU1VTG8yQUtYSzlIc0wrUXptUGpvUmFBWXJP?=
 =?utf-8?B?eTBzbFllTnZldWlUd0gzWEkxa01kelJlWEtORm5ZUzdQL2JCZ3FRTGtLOW1R?=
 =?utf-8?B?ZUpId1p0UTJScjM1azFqRGVRUVpaNGZxOXVxaWV4SUhqck0vdlNRT1ovb2Za?=
 =?utf-8?B?cHgwZVEvWjR2UXNiMlJXVWQ3ZXQ3VENoeng2SUdMdFVKTjlTTm9GUjNtZU9S?=
 =?utf-8?B?c2ZuR3cxUlVKK0UxZXA4bFVHa3hPc2E2cHMxVEpiaUZFNFozbHYxZGcrZWJP?=
 =?utf-8?B?YVREbVpHdmlRVUFmWVF4a1R5cGd3cmdhTTRJUm4xYitmSytxSUhrNENCYkJ6?=
 =?utf-8?B?TXB1WE1BOFVIS0pnbkRGZy92N1pCaGZ5M3hydnZZK3B2U3NDVVd4N0FGUk5B?=
 =?utf-8?B?cXVObzd6SG5yL25NNmcwYkZnV3RVMi9ZcDYwNmkvdlBGWjJHNXdreFdZWnJu?=
 =?utf-8?B?SlFydG9Xc1MvaWxTMVBXTTdkemxiQTVqQkhFeUxLTzJObzBHTkR2OHptQkV5?=
 =?utf-8?B?YWpDV1NGcjJlT1RNWXI0ZGZzcVBnVTg1SzlIZktOUEM1UlhuWkJKd1JNVmFO?=
 =?utf-8?B?ZHV0ZGVOTHR4RC9mK085Mk1HNTRnVDd3U1VhN3ZvMFA4WlBVb3lPaHZvR1RE?=
 =?utf-8?B?Wis3eVB0WURTUFJNUzhiOEJicTBGc3NBVk5jUS9qU2ZNUzZyNHl1ejNSMGJ2?=
 =?utf-8?B?cjZNVGdjTjVyRWQ5NmduS1pyTlFSaWg1NzdzMUtaQkc2REZ2NitIVm5DUmNQ?=
 =?utf-8?B?R0hNN04yb0s1V3lFU2JITVNZQzNlbHZCSjN0SzYwKyswb05QYzN0N3k1djdJ?=
 =?utf-8?B?U0NGblJFVTBPMk51S0Y3cnNBYXJJbHdlQms3R2Qrb1hBbGdqOHRiRnk3cW1X?=
 =?utf-8?B?dFd5bWt1UHV2RVFZSjJKSDJvQStKYjBXaHh0UldmZlR1ZHdKam90S1V6bFlx?=
 =?utf-8?B?S29GYjFEQ1NRS2oyYnJlR3gxdjBpenpLOTA5ZjBFcG5yRjdmWjN3ZWNuUWxU?=
 =?utf-8?B?YmdrWE5icjQ0Njc0NnFjNkVwa25DVFp0bmZCazJrTnNPcE45VzMzcHR4dmNw?=
 =?utf-8?B?VTRvaitsbU9CVFNzRWwxRS9ISkVNNUhUOHppRGg4OW8xbVI3WWNvVmpvN3Rq?=
 =?utf-8?B?WVVqOXhTbDROTDd6L1lzRlh3YlpqempSVmswNTBQYlNaVHd2c25XeHdLUHdt?=
 =?utf-8?B?d3dEazNob20xWFhhbWMwd0h1U2V6YWJNTEpoRy9UMy9YaG4rK01iWVB2WXN2?=
 =?utf-8?B?OEp1cVRDdUp0eXloM0FDYWcvTU55OWJyRVdqbzY3Zys2ODNxaW5pRDlwOTVQ?=
 =?utf-8?B?UHNvRlRqNnNnMFg4Z1NvSXJLY1FkNnFKd01iMUhqdzFaelFPRkdYOEtFTmZ4?=
 =?utf-8?B?aWFFY0ozcEhWQWRiMjlNUTlYL2J6dkpzaW1uYUlkRHMrc1dmQU52bW5jL2tU?=
 =?utf-8?B?ODJxSUpNUWxMYTloVmU1em5FN2k1MWJ0Tys3YjBENTJRZngwWlhadXdXMkwz?=
 =?utf-8?B?dWFTOEwxMUswaGZiQnhEQUoxVjNCZHVNSzNEbDgrUDgrZkFVaUJpSXo5eFRz?=
 =?utf-8?B?SEZ5VEhZR1c5UDNiSTJxUXNnVVQ2Q0RLY3N4b3lFeU40aWJDN1NTWXdvZi81?=
 =?utf-8?B?dEdaNVozWGw3ZHA1MWVYNDdEMTA2M3k0U25mWmUxWU85SjlYYjJqeDBMdE10?=
 =?utf-8?Q?dFtyR4YAqv867sOOkMLBzXlR/k+Oj58coOLmeQOGMzM2H?=
x-ms-exchange-antispam-messagedata-1: 9mYxfJRhX3bRwQ==
Content-Type: text/plain; charset="utf-8"
Content-ID: <A304E8BB7EF434498D82B89960655ED8@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac026884-b88b-4165-cd0a-08da1c51be73
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Apr 2022 06:57:43.8129 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: z9jjFeS4RrRLhJqPjMGUGU+pQYHOdJaD3HaTzU4wF/horX42rL0XzMvNl1F5EyUSTcVNitSeKg5qV5ZCyB4dRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5773
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220411_235747_728321_B5B45D5B 
X-CRM114-Status: GOOD (  10.45  )
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

T24gNC8xMS8yMiAyMzoxMSwgQ2hyaXN0b3BoIEhlbGx3aWcgd3JvdGU6DQo+IFRoZSBNQVhJTyBN
QVAxMjAyIGNvbnRyb2xsZXJzIHJlcG9ydHMgY29tcGxldGVseSBib2d1cyBOYW1lc3BhY2UNCj4g
aWRlbnRpZmllcnMgdGhhdCBldmVuIGNoYW5nZSBhZnRlciBzdXNwZW5kIGN5Y2xlcy4gIERpc2Fi
bGUgdXNpbmcNCj4gdGhlIElkZW50aWZpZXJzIGVudGlyZWx5Lg0KPiANCj4gUmVwb3J0ZWQtYnk6
IOmHkemfrCA8bWVAa2luZ3RvdXMuY24+DQo+IFNpZ25lZC1vZmYtYnk6IENocmlzdG9waCBIZWxs
d2lnIDxoY2hAbHN0LmRlPg0KPiBUZXN0ZWQtYnk6IOmHkemfrCA8bWVAa2luZ3RvdXMuY24+DQoN
Ckxvb2tzIGdvb2QuDQoNClJldmlld2VkLWJ5OiBDaGFpdGFueWEgS3Vsa2FybmkgPGtjaEBudmlk
aWEuY29tPg0KDQotY2sNCg0KDQo=

