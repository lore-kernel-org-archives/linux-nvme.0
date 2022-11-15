Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97750C433FE
	for <linux-nvme@archiver.kernel.org>; Tue, 15 Nov 2022 03:52:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=UwZVO6Jy7autZquGwiPpHdEM0ZdWMbPRA0febvuKtL0=; b=eQ6MeWDgX900M30AOQBNPmPngg
	svioG7uTt5xaGkm7VEa8GO4u3Rhk+uYvSnHkJDG5X99oLwXUJ7FMiRs3u5OrEUHM3/n7DHT6YL+3c
	O9NDEYl18euB2hbJ092gaSh3vExxMM6Jyb8U0EfMoHkPVHajTJ6zQB2xMj8yrK80u1NM11FbnLHmf
	yuOwwe9Wrn3LEd0d+MMbGt+z5b/q1HE3MRKj4jBLs/xiXglmbaSQ0mbO8g6kOPQ+850wWWn0r56FX
	Q1seXpihOAFaXU0VPykI+wGjvTiTKjpYtbi6N9v2dNxQg8FL0eLQvCxFxE4xRY35VKK5hFqUiEpSM
	WzpPjNTA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oun0C-007J2W-7D; Tue, 15 Nov 2022 03:52:48 +0000
Received: from mail-bn7nam10on20625.outbound.protection.outlook.com ([2a01:111:f400:7e8a::625] helo=NAM10-BN7-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oun09-007J1j-IJ
	for linux-nvme@lists.infradead.org; Tue, 15 Nov 2022 03:52:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W9JvAPXabtHzEhEJvl7KU6fIS0iiL/ow31EfRP/26x2x4Lo1W4eP3YHgHp/L8KV5Eusc9PR2F8ybfzMQmoAxn0zGzHHp9Kcrt/XVMERZe480pjVp25f3gcEaw2EDhqPiw9urIY2nB1ytqV8V/bQ2qqT/Vjv4vDvd5eACJF/hHdk3IcAPy8XqROnwDi/C6uvUf3tJvooozSkXwo5//HdAnC0ikY1bX3/8EUAFXjhx3OPoV+KvkrPvrVQgoqxyEMqKP50jHtr7leptAbmrR/LGWwNO4JFVJMkWBXoeFTAA1sZJgmIT0DP1/s8khPO6GqEmbhJ3poJQXItaXhCVctaXTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UwZVO6Jy7autZquGwiPpHdEM0ZdWMbPRA0febvuKtL0=;
 b=K0C9AAjvT4qQacz+M0YC2k3v0M9CrZervazIw8p9IlRR8OJmfI29s8cRgfbKmoDrnJcklMeXxTTi0IUpeeiEorPUWz+Li7A8q/CGjZkjh2xHyUH6a2UFaVbnnnrOdEtHi9RZNQv8Pwc0n1Bng8kjJ4B4TJ8C+lN7WSuzOfYp6WA7k/QXRKjV1atNmJKqGSfKXT+hW/AhwcrZJz5F6N2funKYu/WmV8/ruxMp8Z95j6wcz5Ez+0lcrzll71DQ8gUUDTX7hofqoECX61jvGuJE+QPaII6dRtFA0n+j0ssjhScV2NwRiVmOAYeKgWA42BUYI5MJUEdnz7gcNPQSbGv0WQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UwZVO6Jy7autZquGwiPpHdEM0ZdWMbPRA0febvuKtL0=;
 b=ExeN2SIlTwvpvx3K3FeVNTctMyYCQWjkgLvtztZhfUpR6By4pv9+4fcnvNEAID+y6zLqIqc8t8c5o6Dku12e2g1nCWmq7zI5qlSq2JPLzkt8Nced92LicD0ZhHVDeDqca1qpkuhtSLGnFHYwhIICYENh/lktMAMBPjeLJr6d3Ks9U6uv2vNh+FWO4kCwlpL/roUUnixt6dJ/c/HDtQYnZB97++JsdzxHi089NiPUfhjepylJj0H0/DBvHouiSzJ4tWpNI5ExaDjj9z8Og0xzMmE3N/I14FW6tQtgzHDQThVPjuV37ckzv9JJRrJwtBZ4MuOz8vB25DqPEUMSnc+SaA==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by DS7PR12MB6144.namprd12.prod.outlook.com (2603:10b6:8:98::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5791.27; Tue, 15 Nov 2022 03:52:42 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::eaf1:9be8:d472:ea57]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::eaf1:9be8:d472:ea57%7]) with mapi id 15.20.5813.017; Tue, 15 Nov 2022
 03:52:42 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Sagi Grimberg <sagi@grimberg.me>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>
CC: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>, Hannes
 Reinecke <hare@suse.de>, Chaitanya Kulkarni <chaitanyak@nvidia.com>
Subject: Re: [PATCH v2 03/20] nvme-auth: remove symbol export from
 nvme_auth_reset
Thread-Topic: [PATCH v2 03/20] nvme-auth: remove symbol export from
 nvme_auth_reset
Thread-Index: AQHY91Kkf0brl1lV6kepTEc2DGi71K4/XMaA
Date: Tue, 15 Nov 2022 03:52:42 +0000
Message-ID: <c8c58f26-99b6-cfcd-412e-4b34d67ae8b7@nvidia.com>
References: <20221113112424.1049834-1-sagi@grimberg.me>
 <20221113112424.1049834-4-sagi@grimberg.me>
In-Reply-To: <20221113112424.1049834-4-sagi@grimberg.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|DS7PR12MB6144:EE_
x-ms-office365-filtering-correlation-id: a50208fd-9a3b-4d56-6186-08dac6bcd8ed
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  gAE0QRPqwOtTaLVGVdA+Vegngzvr1oIPNBA+vRRoyNjzCON6eyIMTcidrIIJ2dM1PEAHsQH6b25Ig8GdKP1CX4ec6GGloe0oXA2i//ezLqXihR6g+Ove/zt4VRJViUKhJ/6jh1MhMAdvZWHxL+/WvZHJaAYVwCSVYtLFaEIRlaHPvwt30Di8QG81REzzVN/9A0JUsWCo7FTkMHd60a3z57gZUl3kuS/b8UXIoa1OYE9UrWSZw5Im6mVR+yDapuwqPSGMUJpFlaFgs7IIdSnlkHG58r4VljKCFvMoL9l9+usMK4Y2dNj3Rrgs/C/C9WLNixxJP2dkcp8GlFLGvWnL2puoU6zxH/mV916fLzstr56hfvQYSJXyxGY/RefJ5nR0hRnJytCTM7Oby6aiHSSDYFSqwvZt6AhZtF6tGfv+xncdTT7Jfy2h5iHosqr18FZgICNGXxRh5F4qVYVgu+6V2xLPQXyVX2rHgkede/WxGrK62vm7dHaUfK+JMJSeh73K7/f2oRF/cdQJRDq8Ti0FP3lvlZhrSExV5hYwbqDyoKTm5/aG+TBkFZEJvMb7cMC17nQSbwVQcZWgKqmsl7RqMf9gfxOXn5hseU7iMfLb3V41faz+m0DMn6rNcU3zofPNFsvRZ6oS+VOYzg13C8SyQPpZMu4hOuTKsN30iBwEwIcdLYtdFiMKF9HMfVH5P+3Kq5icMxNqPdHb1gduD2NmPmfTJU/9dCQiKk3j+JQvllD0OhXv1eX2PlVZWuBMwzPV29HS61YpfrU1nUDj82fFJhX1ynCB2C8fr5WEQKln26Lab5Oge0RXiKDYwhS4NdmBP1WNPKqkjTIKSbTvpMy1YQ==
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(396003)(366004)(136003)(39860400002)(376002)(451199015)(186003)(2906002)(2616005)(5660300002)(41300700001)(86362001)(38070700005)(31696002)(558084003)(8936002)(38100700002)(122000001)(36756003)(71200400001)(316002)(110136005)(6486002)(76116006)(4326008)(54906003)(66556008)(66946007)(107886003)(91956017)(31686004)(66446008)(6512007)(478600001)(66476007)(6506007)(64756008)(8676002)(53546011)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:  =?utf-8?B?ejBLdDF1dDJlNkt4Y0t1a0Q3ZXE2VEY2YjZTOWdpVXozSGt5UWNhRmFzeWor?=
 =?utf-8?B?b0grOGNpOEF2Ullya3p4SGI2M3d2SGVFUElZcDNpQ1BpdXRnL3hSZTZ4NUVs?=
 =?utf-8?B?TkoydXhBWjdzUGFHZUZRaDFRaWpYL2k2Vy9FWGRNQnpaMzNnUnNSRHZaRGl6?=
 =?utf-8?B?bTVWWXdLb2ZDSS84c3ZyTzE2WmtyRmlTVERBNENoY2NFS01sSnhqRlBkTXpm?=
 =?utf-8?B?LzBYVlBWWGtJWGd3MlNMMEtJa3VHRVVGeG1aOU93NXduaTJ2WEdobCtMaUdW?=
 =?utf-8?B?aUdGUmZ4SFB3MERXMkFGSnh2Y0RySEJxa0xKcHluTW9iZ2JDTUJJSC84Nitu?=
 =?utf-8?B?dUp3Z2RNaVBJS3RscGNUVytLQlhDQ3QvVTFtTkdIS0k0eHRqRmpqczh4ck1m?=
 =?utf-8?B?ZWdGSmZpRzRlTDRLMEFFMTFlZ1dNbTg1ZWFWTElmb2IrQkllSG1oL3ZpQXRh?=
 =?utf-8?B?S1Y4ZDFJa05oV2R6eEVRd29ad2t6SlpVN2owWHVUaFhUbTJXLzNXdFp6RVNU?=
 =?utf-8?B?dTZUMHIvSTVkQVlzT0FvaTdhYzdKWkZpT2FYTEpuOWp5UUUyYzBnTUMwOE9U?=
 =?utf-8?B?cVlOVzJuMjA0bjNjRnZQRWRDM0k0aHJJVFB1WGE3amF2NXlHekFWWDlic0g2?=
 =?utf-8?B?TjdNWnM5K0t0ZEpPWXlPc1hKaEVweFZHS1J3bm8xa0FCakZ2bVJZUmJEVTRL?=
 =?utf-8?B?SEhpWFBhL0JXVUYvemVkYTZod3VIM1Vka3pPRytxeDNGQ25OcHorMnhWVGFu?=
 =?utf-8?B?eWovemhpTk5sVEVXTDJORHB2NzVESXJ5NTdRM1FXVGVET2k3c2pMMDdSMkpT?=
 =?utf-8?B?dHpraG5GS2I5b1d1R2cydHVxRlJLMEJaYkUzdUFoaW50bWxOYVhCZm15aklm?=
 =?utf-8?B?bmF4WTg1V0laaHRrdkFPT1IvMnZtemZ5N3J1dTVLY2ZWNWpGWGJlYkxFb2hx?=
 =?utf-8?B?bDVoaXprSTRCdDFTc2dFWExXNmRFM25GOGxuQ09jM0FCWnlrWjhmamhtSHNj?=
 =?utf-8?B?VVB0Y3gwM2VHMXFWbkcrQTJ1WDd0eUVaOFZKSENIVUlTekdhRFBTWkEzMVRw?=
 =?utf-8?B?YVh4blpkZ29zQTRySHliUWNzMzhTQWpaSCtPd24wdWNaQmFFbW01SGJDc3E2?=
 =?utf-8?B?dHprNDlwakw2Ri8zUEt2cEpLd1JSVk54aGVMYnBTbWRzdWxWUERvRmNqblp1?=
 =?utf-8?B?SzhKSzB5dGM2SmxUZnhtVVQ4NGw0dml3KzNRcG9hTDd5aHFveFI5UFF0UnpU?=
 =?utf-8?B?ODFxNk82Rkd2eG9vZmJCMnl4a04zUGEwTzl0NmhUWURUZkZGdDJqSXZ2VHJX?=
 =?utf-8?B?YmZhQ29md2ExQllkTE9mYzFZSWsvaHVqQkJxbzVtSFAxQ1Z5M29LSFVId0s3?=
 =?utf-8?B?a0h0R3pTZWkyay9VUW5jaEwySmovUUJ0cktBY0dZVlhLSmcvRGNXb3VrWG53?=
 =?utf-8?B?WWFDMmgwb1FDOW9yTk5vdVJmd1R1M0RaT05ZVWxWYkJjc3BPRTlLVlFBWExn?=
 =?utf-8?B?UTBSZzYrWFZBb1I3aHNGOGQ2amZWYnlZa0VEZHFLbW5IeWVWcFYyS1dYY1BJ?=
 =?utf-8?B?SXpzb3BieXJidVZlNnFjL0FxYU5OZTIwYmRidzJWaE10aVh5d3dlWFVFVXJ4?=
 =?utf-8?B?UVVGb1hVL2V6MmkwZVBVWDdPN05lYzZhbnVINnkyNG1UN3dGbWJDM29tNW82?=
 =?utf-8?B?L2dXT0luODlib291N2N0VEhFUTlUcW9yMEF6N3BOUWx4alVlcDJwNTAzLzZa?=
 =?utf-8?B?OEhuRmFZVHd3cUowNTBkVnUzRFIyd21FQmZ2TFlScFovMHJUVWgwTTJpczA1?=
 =?utf-8?B?RW4rbzJ4RE45bDVYUDRnVGJjdW92QlhrNmJxUXpwMmZPbWdWM053bE9wUWdQ?=
 =?utf-8?B?VG44b2M4Q1Q3OVFxdjlra1FRMjFQLzhndi9FS3gvUXZiekxDTGYzR2lCeDVx?=
 =?utf-8?B?b0pYQWlQU2UvcGZWakI5NHJwb1FGUk9PaHdOOTlaSjFVVS8rSzB3dHFnTWE0?=
 =?utf-8?B?YjdQbTQxWTZvSU5Qb0lMOWJjYWF3VFo0ZUU3STBmOU9XU2s5MlJMU0hONi9z?=
 =?utf-8?B?NElQajBsMEN0L3pGNTNpbnpkNDU4enN3RTZwZzk4ODk1bGo2L1VOZ1E4RWJG?=
 =?utf-8?B?YXlRc1NQOFMzaFZ2bi8ySFBaQ3FtL3ZzWFF3cXNTK1RjcXpDb0NnZ3Z6UmhC?=
 =?utf-8?Q?nVxn/Cr7c9a5k4+QXBkmL2u0qO1Ya74xYHYiz+DOboFf?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1B2BA7622197184FA082EF9AF766917B@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a50208fd-9a3b-4d56-6186-08dac6bcd8ed
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Nov 2022 03:52:42.1308
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wYFGh/WLVug9EIhX2ELfWFWCZhvIOhjowJcgpvxVz2yHZ8Xv48mBsbcUJDcHN8rlmqqc6R5GIkVczP/3u9Jdtw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6144
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221114_195245_626261_B90D176B 
X-CRM114-Status: UNSURE (   9.66  )
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

T24gMTEvMTMvMjIgMDM6MjQsIFNhZ2kgR3JpbWJlcmcgd3JvdGU6DQo+IE9ubHkgdGhlIG52bWUg
bW9kdWxlIGNhbGxzIGl0Lg0KPiANCj4gUmV2aWV3ZWQtYnk6IEhhbm5lcyBSZWluZWNrZSA8aGFy
ZUBzdXNlLmRlPg0KPiBTaWduZWQtb2ZmLWJ5OiBTYWdpIEdyaW1iZXJnIDxzYWdpQGdyaW1iZXJn
Lm1lPg0KPiAtLS0NCg0KTG9va3MgZ29vZC4NCg0KUmV2aWV3ZWQtYnk6IENoYWl0YW55YSBLdWxr
YXJuaSA8a2NoQG52aWRpYS5jb20+DQoNCi1jaw0KDQo=

