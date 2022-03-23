Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63FB2C433F5
	for <linux-nvme@archiver.kernel.org>; Wed, 23 Mar 2022 22:26:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Cc:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=90UlzvY7Y12U9C1b3SkTCi441DVNr5cg6uHrh+Gjo3k=; b=Q87AttEyvES7eizI0cbKGyL5E9
	OEHlGSX4ktyPU43TLYaXv2V76eaXfpr7XHUwGDG0rOIz+rWAlUvg1zgbw8UvmN5V87V6YUXaI6h58
	kjU0/DEh674pLOoyy478NgmpnTjJeC2P1iw0JRoLQR4Z2PmhWFarOirRQQ6LPlOF7lKEII5G/OIIH
	DOaJeKZD+2YqUeS4fsF5gu+pul5hSnpzf+oC35KV4979fTYvawv9d/4Tmd2nJPWMzt+J+V+ie2H0j
	Jo2ygLMoFXM6jacqUYwvAUuPicIYk9V2dqAkg4lhTvFeOixWRG/74BoUWteHsa4YnW4DWvs5S1WoR
	oFcBy7LA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nX9RB-00Ex03-Sk; Wed, 23 Mar 2022 22:26:41 +0000
Received: from mail-mw2nam12on2061a.outbound.protection.outlook.com
 ([2a01:111:f400:fe5a::61a]
 helo=NAM12-MW2-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nX9R9-00Ewz0-65
 for linux-nvme@lists.infradead.org; Wed, 23 Mar 2022 22:26:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nQO9PdO3nWSziUpARE+dsCkuLEbN+Ezrx3ZOVNEUWRlXvmHH1Nztl1jR4LjBLYiafia/n6AWQde7GYv2axzyqzMtHoDjAS0e0aFkx5JOqRdWeX/MJe0WsMIR4w122/xTNOTVrjUGvhz+QaBkbT0jDF5pPIxnMJbTsC8H7whc/mNn1JfemS606SRNTykTZtBNuhxb9KUqkGDEmFm5Ki78eqqlRdYL1mRKoThREeJpSx/hxKBpa2ALlkTsP6iDuT2NF0ycpRTyF5hvYOYCvELgk3J2N4rxQt7HV+jCceTPiPLzeJWWDreQebU9wvZlfU4rnVByVarSMrGov+NVTq3TXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=90UlzvY7Y12U9C1b3SkTCi441DVNr5cg6uHrh+Gjo3k=;
 b=jNDnX0SNwCCmu9UlwCXGfOhVcz4sDY+8gpbUj4Pop+AH9G4v5688Fv+fYs4OBeJmLEx7rV1lnH+GmHRPmXxUUlAZN2JKJwTqoYleyoqnPw4M39dWPdxXexgG08RQWeWXhyVkzy34FzH2RWVhUt7qWahivp4m2krXTmLdaJCcM3nhrPysIw6XnI+6S7FDNFu8sIT8qwoicMcC8p0wVDNk5Pgp8m+kkj+oS3HdZYdsy5iIPfV2wMYjF/FqGItuxy97CbmL6zEoFuTBeeOHi2Hu5Vuoi2B71uEkTdSaQ992vAd4M5P0t9CiKltcq7uxXUTcrJpMadB6HBdzPVtcW2t+EQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=90UlzvY7Y12U9C1b3SkTCi441DVNr5cg6uHrh+Gjo3k=;
 b=JRsppiYYBKiIiConIKcLwRThA1yCgaIg/FtwwcJ8bNoFmET7AANFcPejvCxxNzWSws9cO/X+/XP2OV32hCFaZQCe9IYaHepkqAXqgAxIK7nt0VOz5nzrHDTB3hLwWGL5S9Lew/UHIe9ONwk947vyaIpyPcMIbCGVYLKOKu7LbdawVMpCUpbJy9YVMpYd1laBjnH7dS0iSUglW30ocgZwj8i+hEOZpda2vmeV3u1D5sKpZayNZebtix8Pdb6/h3ZOtu7cTw7XdgTLXqaGdgWu56BXGH7iyMGq8If0LSSwpLhuInDYa4lU8jeiZjKfeAZFmdw/Qq3VAP/lOxotKGTZog==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by BL0PR12MB4867.namprd12.prod.outlook.com (2603:10b6:208:17e::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.16; Wed, 23 Mar
 2022 22:26:31 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::204b:bbcb:d388:64a2]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::204b:bbcb:d388:64a2%4]) with mapi id 15.20.5081.023; Wed, 23 Mar 2022
 22:26:31 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: Unable to build branch nvme-5.18
Thread-Topic: Unable to build branch nvme-5.18
Thread-Index: Adg+7HTIT/YM6CW5T0in+DU2ox7COQAGJbaA
Date: Wed, 23 Mar 2022 22:26:31 +0000
Message-ID: <ddf69f88-480e-a05f-da06-ed106926769c@nvidia.com>
References: <SJ0PR19MB45446560EB7A86ABFFA6BA9FF2189@SJ0PR19MB4544.namprd19.prod.outlook.com>
In-Reply-To: <SJ0PR19MB45446560EB7A86ABFFA6BA9FF2189@SJ0PR19MB4544.namprd19.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d87fb6f8-7149-4ae6-3340-08da0d1c2e8c
x-ms-traffictypediagnostic: BL0PR12MB4867:EE_
x-microsoft-antispam-prvs: <BL0PR12MB48675281919A8F411C275D26A3189@BL0PR12MB4867.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: AauzixCgzy6Se4Dyv0Yn12grp7SLPWSw7+AF0kHL4k+bl8GiTOhXYkaR/gbp45JyrkSrv+PKKwy+J7DIzApS+prjdp390mTl0xWTGa+hQA4QjR9RSDH2txRb5g2M1mwa3BcZStx5N0ciVnf6Ya5qftDzf6edVCZCYrSPmLjOLn+gTHedv0/nZ2FD4iDrM2RQNRrPFLnGJNN15ZNl2A+YCojY2EtLNKSnD/eEvUvVjgvlz8ZCNBZZc4VObKaxzQjzIT71l9EhueDvp2C76HvHcxSUKIjuFoVBmveO6OYzx1DRMldgFE3iVN9Ujj9Iu10WvzH5C2eSxh5XEVZQbghRalAVfZ+drdzQLtMKKtt1N5fj5JyDrRkwVywTCpKBc16Q9mgPRCzPUJDQT30hRTpWGjwioESQPiSGvkiPucCZitWlYyPYGUCFam5F1fyfVzrWJbnem8CgUxDnEFhsW3a/UF+ZPrZ6vp2FP1GL7iT4vUlEFL0SwC/iy8M34WgSIkzkgw8VhYG71Qb82+9cP6TDwgOhrqSvi0XjgfQ7cXXPGoWUhqPNyXQTGTCNHXG6SxJTrYqJJTzjMWu94bhsfKlJyQZfEv0A8lTOIIPpKaHilPKxqFSnzcYk6wjfBK85u0zRwm2rTNgT++GmCRa2SdsR+OPdUHEGR7uJSFkghPKfPAuglqoUWDP9vYdRFuN6Rx1RU48XG+UUp3MuDaknl4MV1cfLlNW0bIasEwtKqUUakvNLDV+WfMgbILyQMRcm4qAPMP0leRabxpZiwG/FVxvutA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW2PR12MB4667.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(36756003)(91956017)(86362001)(31696002)(508600001)(38070700005)(2616005)(53546011)(6916009)(186003)(316002)(5660300002)(31686004)(6512007)(6506007)(71200400001)(8936002)(122000001)(76116006)(66946007)(66556008)(8676002)(66446008)(66476007)(64756008)(6486002)(38100700002)(2906002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bGhWaDR5em1nYW5rQnh4dGNqcjBmTk1KMUhRUmptbk44b0JUL3NJNXVMRDR6?=
 =?utf-8?B?SWVBSFgwZFloNG9jL2krZEFDSlVwd3J5TVBHTTFVSmZZNytPRGlWSlhVTjhh?=
 =?utf-8?B?c3RybXNvZkxvcFR0NHdSdThia21SKyttMFlNYnpuT1VtQ3orSDM1Skl3Y3h3?=
 =?utf-8?B?a25zWW1xYlRpQ0p5UU1HRzV0eUxPdXlJOHF5NFgyYWxxNkpzQ3BhNndSR2I4?=
 =?utf-8?B?N2o5VjVQU3lvSWFvY2xoelJ3eXhVRWJrT2F2Uk0ra1ZkWGF4N09PL3ozN1NQ?=
 =?utf-8?B?Z1gvcDZ3VDJmZG96WnY5WUcxZWpFNTYxZit6Uk5tQk83aE1oUG5nUmVyazVq?=
 =?utf-8?B?Q2lJS2NnWmdORFUyUVdOakRPNjJPTlZwdlQ0V3hWS2ZpejBoSFR6OG16UDN5?=
 =?utf-8?B?a2thSTR5a01kdFpta2JZalozODZBeUkyeWZiUHk0ZGZYam1LZUlFRXRZYXJk?=
 =?utf-8?B?WkdEVk8vNkN0NWlpUmlBMEpzTzJmN1g5RTJ0RWIrR0R0a1ZyZTFJVTI5SU9w?=
 =?utf-8?B?Qm4wZ3ZpT3NMSk5acWRJWFFnSDNXVS82dDZ3TzA3Ymx0WUNSNUpQZDVoM0hs?=
 =?utf-8?B?dWdvcmwxR3Q5ZmxKRjE1eXRYUkFpalNWYzMyNldTU1didEE4cXJWd3dtSEpj?=
 =?utf-8?B?a0UyTDZ3Z2RudXJNY3ZtOElEaGpLeXA2QUtwYlZPWC9QOFMzYnhCZTFqRlpw?=
 =?utf-8?B?aVpJSW1MdnZoOUdaNUR0TTZWQzJRak5sR2lpQ0RmZVIyQ0tXNmtEeUNWMlQz?=
 =?utf-8?B?c2lmSmlXWnVIUXgwRVVrYk9mNTZXRGtzSlZmYVl1QThxaVlRT2hpa3FjK2hL?=
 =?utf-8?B?ZWF5QUd4alNyVHNtMXZ3a3BEUWVOWWVFM0JhYVhDR1FoYzdlWUlPNm9GK0NU?=
 =?utf-8?B?c0tmSWdrVk9oMnREWS85aFV4YWF3alZxenBra0pnV1c4ZlBRMWxta0xoY3Bx?=
 =?utf-8?B?ZUI4cTNKbllyQmNVbThVVHJDRGtuRnRMbFRHd2FLb0dTZXRDQ0JvcDIxdkgw?=
 =?utf-8?B?c01nRjR3dUJaYjAwVllDWHlSdFg1dmU4VXJoUUZXT0VOelZoR1JTOVZwWnhO?=
 =?utf-8?B?azFYaEVQWXM3Q3dNZUd6NXdUVWVBUU10blJQcTBZQmhHUmQzSXQ0aTlEOWV5?=
 =?utf-8?B?eVR1ZVVXMGtsVUFXVTBkSWVWUUNaTTVOYXpLRWttY2tXb0phRnBQYkxZdEhu?=
 =?utf-8?B?dXNmdFRXb0FvYXU3dWZ1N0R3ek4vUTV0NG1HWUhtYmRHZUh4aDFJQlpYaHVj?=
 =?utf-8?B?L3ZOaHhKcVBQY2MzbUlaaWFFK2M2K0NyWkZWOHY5RG9OcXNlSDVsaXV1Q00w?=
 =?utf-8?B?UWN5T2crWWJXaDRyL3pWMS9TM0pBK1BJVUEvR1BBY25KYlJLQmdDdzBocjRW?=
 =?utf-8?B?T05INWJyMXljZ0tuMUJVdHA5UFZOZzlWVzYrNng2Qk1paWlLaEZBa01pQXJ4?=
 =?utf-8?B?MC93dndYTUJBdytLNlVqQ0trLy9qQnRyQk12OUlDRExzQTFuU1hVSEw2ZkZF?=
 =?utf-8?B?QlNibFoza1FvT2VoVEM1bVllN3M4QWNHU1FCWkZEQ2liZHRjMGJnekRicmEy?=
 =?utf-8?B?cng5c3NqOFNiRkxIUDZXbVc5TDlCYjJvWExJUGtMNG13SFVuR25NeEVMRHNj?=
 =?utf-8?B?QnQ2b0VNR1hwdW1CYkdIcnBveGtHSFdha01Oc3RnWERHbEV0bGZWejh3RTVh?=
 =?utf-8?B?UDRPcjVHY3UwOUNNTTVLdTV4L3lLUGRhQ29zL1c5biswTG5HREQzWXJjOGxL?=
 =?utf-8?B?T3dJYVFWTHc3MGR5M05GaGh3YTRpVDNOQlp4cGEzU0x1T21qTGRzZGFxNXpF?=
 =?utf-8?B?YWkyd2RHRHFYTktrM0krUlBpV25DUGtQd0R3MkI1dUY5d0w3Vm1xbFJYQkdh?=
 =?utf-8?B?bmdEa3VVaVNVYUxPZTZJSzlmTFN0R2RYZEZrbzdpd2dlYVZPdStycXFDaHMv?=
 =?utf-8?B?N3AwTmZFOXk0c1ViQ2dQV1huM1ByeWs1aTdmK3o2cjJMVlZsNUNsUWlwWFMx?=
 =?utf-8?B?bjhDdno3OERRPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <55AA1DE39573594182A4F7EE14C9D8C9@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d87fb6f8-7149-4ae6-3340-08da0d1c2e8c
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Mar 2022 22:26:31.6438 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Dq7R6r9szxbrHmBDSeCw0NRFcBlvbUXpr7eWOdS4BzmJfQmA0zt9ChyBuHyUbQw76eV+PvUw4Hri1h/oyycwZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4867
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220323_152639_279891_DE31116B 
X-CRM114-Status: GOOD (  12.70  )
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

T24gMy8yMy8yMiAxMjozMiwgQmVsYW5nZXIsIE1hcnRpbiB3cm90ZToNCj4gSSB0cmllZCB0byBi
dWlsZCBicmFuY2ggbnZtZS01LjE4IG9uIEZlZG9yYSAzNSwgYnV0IEkgZ2V0IHRoaXMgZXJyb3I6
DQo+IA0KPiAgICBMRFMgICAgIHNjcmlwdHMvbW9kdWxlLmxkcw0KPiAgICBNT0RQT1NUIG1vZHVs
ZXMtb25seS5zeW12ZXJzDQo+IEVSUk9SOiBtb2Rwb3N0OiAibnZtZXRfd3EiIFtkcml2ZXJzL252
bWUvdGFyZ2V0L252bWV0LXRjcC5rb10gdW5kZWZpbmVkIQ0KPiBFUlJPUjogbW9kcG9zdDogIm52
bWV0X3dxIiBbZHJpdmVycy9udm1lL3RhcmdldC9udm1lLWZjbG9vcC5rb10gdW5kZWZpbmVkIQ0K
PiBFUlJPUjogbW9kcG9zdDogIm52bWV0X3dxIiBbZHJpdmVycy9udm1lL3RhcmdldC9udm1ldC1m
Yy5rb10gdW5kZWZpbmVkIQ0KPiBFUlJPUjogbW9kcG9zdDogIm52bWV0X3dxIiBbZHJpdmVycy9u
dm1lL3RhcmdldC9udm1ldC1yZG1hLmtvXSB1bmRlZmluZWQhDQo+IEVSUk9SOiBtb2Rwb3N0OiAi
bnZtZXRfd3EiIFtkcml2ZXJzL252bWUvdGFyZ2V0L252bWUtbG9vcC5rb10gdW5kZWZpbmVkIQ0K
PiBtYWtlWzFdOiAqKiogW3NjcmlwdHMvTWFrZWZpbGUubW9kcG9zdDoxMzQ6IG1vZHVsZXMtb25s
eS5zeW12ZXJzXSBFcnJvciAxDQo+IG1ha2VbMV06ICoqKiBEZWxldGluZyBmaWxlICdtb2R1bGVz
LW9ubHkuc3ltdmVycycNCj4gbWFrZTogKioqIFtNYWtlZmlsZToxNzQ2OiBtb2R1bGVzXSBFcnJv
ciAyDQo+IA0KPiBBbnkgdGhvdWdodHM/DQo+IA0KDQp0aGlzIHNob3VsZCB3b3JrIDotDQoNCmRp
ZmYgLS1naXQgYS9kcml2ZXJzL252bWUvdGFyZ2V0L2NvcmUuYyBiL2RyaXZlcnMvbnZtZS90YXJn
ZXQvY29yZS5jDQppbmRleCA4ZjM3NjJmNDQ1MGYuLjdjMTdhOWQ3OWRhMSAxMDA2NDQNCi0tLSBh
L2RyaXZlcnMvbnZtZS90YXJnZXQvY29yZS5jDQorKysgYi9kcml2ZXJzL252bWUvdGFyZ2V0L2Nv
cmUuYw0KQEAgLTE4LDYgKzE4LDcgQEANCiAgc3RydWN0IHdvcmtxdWV1ZV9zdHJ1Y3QgKmJ1ZmZl
cmVkX2lvX3dxOw0KICBzdHJ1Y3Qgd29ya3F1ZXVlX3N0cnVjdCAqemJkX3dxOw0KICBzdHJ1Y3Qg
d29ya3F1ZXVlX3N0cnVjdCAqbnZtZXRfd3E7DQorRVhQT1JUX1NZTUJPTF9HUEwobnZtZXRfd3Ep
Ow0KICBzdGF0aWMgY29uc3Qgc3RydWN0IG52bWV0X2ZhYnJpY3Nfb3BzICpudm1ldF90cmFuc3Bv
cnRzW05WTUZfVFJUWVBFX01BWF07DQogIHN0YXRpYyBERUZJTkVfSURBKGNudGxpZF9pZGEpOw0K
DQoNCg0KPiBUaGFua3MsDQo+IE1hcnRpbg0KPiANCg0K

