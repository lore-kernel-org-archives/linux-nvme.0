Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 924FAC25B74
	for <linux-nvme@archiver.kernel.org>; Wed, 22 May 2024 01:26:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=tkKg20H3oYXu03U9MT4PQ0gYpINr/XOtYQ+nzL+DHeE=; b=lGiJak5NvyX1+660dPmtPFPqDQ
	VIBFkHOdXDdoCsCuFZpyCnaaAXicK/bpJKP2wiIpUl6Ml4mD/Ry5a3qPv3oJ+IIxWGQOFuu7abJ5g
	oULDRTprrxMDddq5G0UG2SmVR12rtEFiEIjacILOfDsRmCXQuhBokHUphAdcIsS4CKaxGGbElG2f1
	Z9r+z7bT6ex5ARLXYBfqkXgn8NP7tpryuG9dTVEKp5YwqrM4auXfhzvHvCnjyjz2eExenAfcUarUt
	CSgHEr+QIZQVXWcnDHpASQZGLgzwiwxL+GnYFVxOeyLTpHdji7oRosGYVypKPQFQAZUyIbyZESiDi
	xZJUbTcA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s9akX-00000001cU7-1c6g;
	Wed, 22 May 2024 01:26:37 +0000
Received: from mail-co1nam11on20600.outbound.protection.outlook.com ([2a01:111:f403:2416::600] helo=NAM11-CO1-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s9akT-00000001cRW-2OXh
	for linux-nvme@lists.infradead.org;
	Wed, 22 May 2024 01:26:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZZt/ZNLumOc3TaYeiKECxy6DBqDr85BqZdPo8jH82yccHMbwitPXedazvwG9zGj9tZqztdv3D3dX1BPC+l4lyDtHL+LxwxvD0c6ybGpgZiiadcTc781uVXrK5k6hMilQ4uem3CmCvV+X1XNHWelqjy4pcUgUj8ZGhvFPv10blXdaaSLUaANaZhhfovt/CL3qQWfS0gw7Xx4DBPq3S7TJ0gztk4Nqu7dMKhDcRs2jsE3kcfT+8CNpl1eSGgYvkGWgLnhpZSIpIZsZ9XD20nO6N99CfXgA6UN4SFuOujyFHBRbjfoqZzKB60xrOYjESdEyNbFCqGywDzL/HksDkTLonw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tkKg20H3oYXu03U9MT4PQ0gYpINr/XOtYQ+nzL+DHeE=;
 b=DMBmwCE3h62iyQb/xg+VOB1evgc2ROzN5g3+kbiSuWz79SyAVDVw37DDSzGUeo0gW7zhAQyO8jIz58jl3SxB6QUf396Edkn1EmClxzDz5hsgkgXKXU8GFQ2sSTJKQ4u/IO4nWnBaxzbbSRin1AYufeygruIHgN03vljz3IFCTO5/LnaK12x+w04cIM/QlF4J9g0GIiHc+LhY+UTbzMkmy39I6Yf4nTd+RWSf0GuyZnbaIR4o+0mzoyu5bfjQkSIKSdnLKoKzQg2O7aANzbub0HRs+T1NuvEyn9DFJ6YcvsdkIRTjo33YKjuyHdoE8A1P30d0pLm+B71wPSbBizf+RQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tkKg20H3oYXu03U9MT4PQ0gYpINr/XOtYQ+nzL+DHeE=;
 b=UCZl8xXOAUqXq+veOLseqxe+rwtj82pkX8WqiIDTfJ6SUr4WtYU2OQHbykvbP3/WPznrdqyoD1x10nnv/Z931QARyXrX5rndwy+inpsCp+cPI5KvDAyA4GXP3aFUPvv+CXG7hPxMNr1eQTh2pFWkqSoXEXZeoZYmS4PlbuWCzwinHo5wCp+Hi0Duzg/EPKgJnGC+2bMkFyT7RJ+ISxQBl7zz72xpIiNsuT/DG7onJed8y0foav7o11HqXyDb26Iteuw7Wi4Ege8q81WFTh4eTTM5+0QEiqWvriG6ViA+GnZpOw2UtpVxzyUzBF0SjGYWFySr+i6Ll/F6hy1ax5Sa7Q==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by SJ2PR12MB8806.namprd12.prod.outlook.com (2603:10b6:a03:4d0::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.36; Wed, 22 May
 2024 01:26:19 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b%4]) with mapi id 15.20.7587.030; Wed, 22 May 2024
 01:26:19 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Sagi Grimberg <sagi@grimberg.me>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>
CC: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>, Chaitanya
 Kulkarni <Chaitanya.Kulkarni@wdc.com>
Subject: Re: [PATCH v2] nvmet: fix ns enable/disable possible hang
Thread-Topic: [PATCH v2] nvmet: fix ns enable/disable possible hang
Thread-Index: AQHaq7xl1CLV0bbqc06z3d0fP2plI7Gidp+A
Date: Wed, 22 May 2024 01:26:19 +0000
Message-ID: <0061d1c9-7ecb-4440-acb0-17cb5c303170@nvidia.com>
References: <20240521202028.356777-1-sagi@grimberg.me>
In-Reply-To: <20240521202028.356777-1-sagi@grimberg.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|SJ2PR12MB8806:EE_
x-ms-office365-filtering-correlation-id: 0b798a12-eab0-4a63-f535-08dc79fe2ec8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|376005|1800799015|366007|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?cUViYUZOUzhZUEhPV1lGWXJudzhhZjE3dm5ZdWw3WkVXV2pFWlRuaHRqWnR4?=
 =?utf-8?B?bDFMalV0cGt0Vis1b2VlSzhGVEhPSGxLSXFLcHc2VkhCQU1DT2NqaEt4blll?=
 =?utf-8?B?b2N1eERjb0dFTVNrdHFETGwybnpvYk14UFhnbFhRK2UzN1FSMjhHc2R5MGxF?=
 =?utf-8?B?V2Iwa0hHMkpweEJoTUdSTTIrd3dEYTNQVzlkNVRmbnBqY1BGUzFmdzQwSU1l?=
 =?utf-8?B?T1J3VmljWCsxUDRTc3Zyd0MwdFpDejc3Tm02M3dablEvY3JBSS8vT09EV2Jt?=
 =?utf-8?B?RnNHSVlMVEF6R3ZJS1p1MHA3anhrYktiTjc0TVhlSitHaVRmaURMeDBtQzBD?=
 =?utf-8?B?REFYeEZHcmlMSVI2TDNLdzBjOHNpaDZ6SXR1cldGMEl2bGlVTkxVR0FHTS9J?=
 =?utf-8?B?Tm85VTR4bFVHVjY0WUdWb0MvKzVYeWZHNXIzNkpFS1lwRFZ3dC9MVnkwK0Zo?=
 =?utf-8?B?ckVNR3V4U0pHdmpBTXRLSy8zUlN2K2ZySUc4Mm91QWNnRDJXZzlYcEZNVWdJ?=
 =?utf-8?B?VHcyMCsvVDJlK1NMd1pJUSs2Y21hUVY3NkVNbXMrZGN1ZVcxalVTOEJMbHZF?=
 =?utf-8?B?SnJCYnRUWENieFJWRHVhV05mY2F4LzNKVzh1cXZ6bVZRaVgwRFloeGhKTzBR?=
 =?utf-8?B?bzE1NjRoSkdldVNObEFQTHF0WHUxVWV0OGdVeWpWdC9TSkFXZHQ2S25hNDhs?=
 =?utf-8?B?amFkRXkyV2lBLzlxdURnYjRJMWNVbThnZnl2VkQwNjRUUi9MenI1MUhJMkNi?=
 =?utf-8?B?NndDa3lLOTV2UTRFK3pHNlFSK0NiblpONGVuTnR4aTVwSmlQYk9Nd3hzdW1t?=
 =?utf-8?B?ck8rRTlZdzdYVlIvREIzNlE5WG1weWdsNnBpYi9sbnhLcU0xc09iRFZoYytE?=
 =?utf-8?B?ZEltTENDSGtJM1BzaGdOUEVlbFhCRjA2blJyUkxrby9saW0wMGIzVll2TCtV?=
 =?utf-8?B?VkRDRXJjQS9zZFAxWUIwQWFnRVBvWFZ3cDRiMURWclJlNXUweU11aTRPY0xY?=
 =?utf-8?B?ZUIxS1h4d3ZGNVF6eG45V1U4WVNuZzdDcFcxU2lQaWZFNWtzc2RkcWJiTklG?=
 =?utf-8?B?VXBiZ3dsNEV5Rk1hL2ZpbC9NY08rLzZwYWd2dTVjbDV4YnJCdVJLWkV6ZTFw?=
 =?utf-8?B?elBBK3NYNytEMmVLdk9Gb0NOYTNCZ3JrdXJOSUdTYkY2WVMzeFlVckxMQXh0?=
 =?utf-8?B?N0U1Nm1ialJzR2JPQ3g0UjJvcUFHOXFucnFrSTZwQ1lrMFQ4WGtEclovT2tV?=
 =?utf-8?B?VjEyRWxSNlNZOGJ4d3YwMW1NZ3JweS9SZUZlb1BZTDhTRmFTWGlTMWlQcWUv?=
 =?utf-8?B?NFZGdjZKeFdOa3ErOUtIYjlKV1Q0Y2JnUGZZNUFxbzMzMU4vK0NhWnVrVXUr?=
 =?utf-8?B?NjBCSVNTeVR5WXlUNythU044RG9aL2xiQTF0ZnZKU0MvWHE4N0F2dzBQRjBj?=
 =?utf-8?B?Q2VoaGJFQTdJQVh1cHlFZERQWUJTOGlNdVA2Z2lmYXIyVWt1dThNUXN0b2hI?=
 =?utf-8?B?NENXRWZma3NPZ3hpamNjUnFaY1RXL2FGcnNmcWZmN2VxNmUwOGMvUUlNMUhm?=
 =?utf-8?B?VFRCTTh5amE1VmRENnZhVVVKa3FUck1mNXpEcHk3Mkl3TFVKbTV0ZGVBamRT?=
 =?utf-8?B?UUN4bmpRVnRielVzUzdrTzFOaE1nckt2bGdIcndpR3NwOFJRaDl0cmVzY2NG?=
 =?utf-8?B?Y0FaUlJoRnVIWDVPcUtIWXh6K0srcGQ2eFJmdzFlNXc3RC9oYStpYTFPYVBI?=
 =?utf-8?B?Ty9yRjRBakxTdk5takw5empYWEo2dXRDZXBoaGlLQklWcy9mQWJLUjl2bVd6?=
 =?utf-8?B?VnJCSTFjckRIR1hvK05pQT09?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?b0hvclhyZnhhUFpHVUJGWktYd0RIRFdoRnEyaGNmK2VJSU16bE9lOCtuWUV0?=
 =?utf-8?B?Zkp0YUYxYVMyY0M1bnladXpBNEErRVdNTVFxNGhHTTJma0lCQW85T0VuNjM1?=
 =?utf-8?B?cGhyWitsY2RwQXJwemxaSnRpNTRqV0NjU3VOV3doNll6WW5PSyt1d0ZseWpH?=
 =?utf-8?B?VXRnQjM4MjR5RkEra0FsUXFBRld6K244MkN1MlQrSnFnc0RRak9oY1pJWjJM?=
 =?utf-8?B?eUM2T05RRDl1cTVjOUo1MXFWSFNaeG9JVlZTakUzSEZWSkFyYTVIQm0vSmp3?=
 =?utf-8?B?V2pPdm1LL3ZFMTJ1Q3lTM3VsbWhSaFZZL2FvWnZPYUpsSnRsMHBZVU9vSkx6?=
 =?utf-8?B?Z2FyOEFDVXVGelQ1ZzlmNVgrVGhKMHpQUmIzazFQdm1YbitrOVJtSVduSmIy?=
 =?utf-8?B?NTJvbEVZUlp3eGR3YmFDT1hwOFFCWWRHbXMycE9WTmhLbVpCNUxSMTAyQ09s?=
 =?utf-8?B?bDdmOXBXODh0WnpOazFjVzQ2THdjcWdsOEhmMTl1cExpWlc5eXFRbEd2Qm9G?=
 =?utf-8?B?SnhyV0hLaXlYOENmVUMrVC80RDdCaG9UanhPVGZpenBUSE1kZllvWjJIaHZB?=
 =?utf-8?B?ZGVYRmNlVjcxaHpwOFB2U0kvQ0htSmsxMUpkUnZGRWw2Y001TnNueGhBbG5E?=
 =?utf-8?B?Q1llcVZmWHhTTnZGa3ZHdWxBMXdHRHZFYkRMbEZERjNEVzh0NDBGa2tyaDJK?=
 =?utf-8?B?MkJzUWMzLzYyYXhTZ1VxUkM3Z0JCQTVteWdUcWx0WVNrL3NRbWV6ZmxjUERE?=
 =?utf-8?B?VVdzZXFUazlGWE9qSzNnblB3QWJYaFBGOTVZRldHeTVmMDV0cDlYUXZ6NzNY?=
 =?utf-8?B?aWNHZGpsTTZqa1JSMkhPMTBhMWlMZGRKRHROcXZ5Wlp5MzluQU9mYzFKa3VE?=
 =?utf-8?B?RStYWXljS0Fnb1dlWG0wUXFSQXNmSWFzRE40MVE4bTRuK2grK3Qvd05JblE3?=
 =?utf-8?B?VlJzMU1RcHI4bFZCbmQ5c0N5M09rVFZNRHA0K1hKWUxuaTlNaURWMGw0RHR1?=
 =?utf-8?B?NlVkVEx3SU1Nc3hiV3BmTmYwZ1FQSUh4RGlRQ0o1Nm5zYXF6VERVbXJiSWhZ?=
 =?utf-8?B?Nmt0ancwSHN2eGloOFc4TkljcFJsK0VyTGhtUzZiZVhscktzV0FudkdUU3M2?=
 =?utf-8?B?dXQyTG5FUnQwTFlpbmhjV0VtRlZrQ0RwNjFwOFFIdVYrZU56MWxCQk9QYmJ3?=
 =?utf-8?B?eHRnK2JxOVhySGwvVFlHbklvcEJPR2xaTDF2UDhITlBOYTR2Mi92elc1NzFE?=
 =?utf-8?B?UUlaaWRsS3RKWXpqTENzeC9rZHJIVnl1dXJFR2h3K0dnOUFOUzVXTXFHY1JT?=
 =?utf-8?B?aWV4d0ZLZEs2SnB2ZTA2S3QzVnErWnpaNUM0cEdGcWd0TVdDZnR4ME5KS0hy?=
 =?utf-8?B?Mk53cjdCbkdKZ08yWDJxZTVoWGp1ZytNcWFvMjZJK0FBUjhTNnJDQ3g4SVFZ?=
 =?utf-8?B?Q1A5U0lwQTJxdnc4UjV6K0duVEM5dzhPSndnckhCU3owRmJabStJQWh6UTUv?=
 =?utf-8?B?dFFZbjRjRUFKcStVeEJobmFzaUtRZHdpZU1FTFhBcHBLczhYSDBvUUdnUEd0?=
 =?utf-8?B?SlpCTjZ2c2ZTNlR5WUFBS2VMaGVtb2ZhUlBiR05SWkhzWnEvY05Pd3JMcUNz?=
 =?utf-8?B?ZTg4QnlEM3JVLzJSUG41dkxnendCVmd3WVhzNHBzUjBpRWtlSXJuT3oyWUhQ?=
 =?utf-8?B?ZzRZeGR1Y2llSy9BN3Z0QmFRY1BRWjNLZTBtUUp5WEt5cmgyV3RUdUxPWFRx?=
 =?utf-8?B?Zks0S1JudGJmMXpXREx4MmhDQ2hBWjJ2TGJJRnl1WUJDa1VIVSthczBXU2Z4?=
 =?utf-8?B?ZTA4eE5PSlRseGQ0MndYaWxnQ0J2cGZ6VzJESE1CR1pPRVFQcjliVXdmc1Bm?=
 =?utf-8?B?eW1ENERObTliZE9FTXZrL21BRHYvdGN4OFV2TWZYaHZmVkZxUXJETHB2blRL?=
 =?utf-8?B?SHFyTU5lT3M1eW1WSFRFaWtZVXNZOTlaZWxGTjZJL1JUR2dnb0pDOEM2RG44?=
 =?utf-8?B?Qks2SFNNbTRTU1A4Q0tWYVVnVE9udnZoOFdyZXR4OHVFZkhBdmd1T2Y1WW90?=
 =?utf-8?B?VnFRQStWWk9yM3ZnT0tYTHp4NS9mTjZqR1E1b0FXa0F1czhHMGFlZHlidTlp?=
 =?utf-8?B?NkJ4a3h1aHZ1OEl6aEdjYURISUdzL1ZtQUE3eC9Ea0tUeVYwUlQ5RDUrR3Vv?=
 =?utf-8?Q?kJp0iwXJxPKIVhnbULjTDfxngzREaXK3N2em4jqDTI+Q?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7234E13D3A8FB948936A4228B017B8CB@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9404.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b798a12-eab0-4a63-f535-08dc79fe2ec8
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 May 2024 01:26:19.2851
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bMtg4uCYPD/gQSdwPIkHP9atOR3WvZHgjB3WrLi5UNl3MU26ZwhFLyew9eDi1w1y+GMP7pkYqzx6ol3Zk2IjfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8806
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240521_182633_736988_9F3E8512 
X-CRM114-Status: GOOD (  12.12  )
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

T24gNS8yMS8yNCAxMzoyMCwgU2FnaSBHcmltYmVyZyB3cm90ZToNCj4gV2hlbiBkaXNhYmxpbmcg
YW4gbnZtZXQgbmFtZXNwYWNlLCB0aGVyZSBpcyBhIHBlcmlvZCB3aGVyZSB0aGUNCj4gc3Vic3lz
LT5sb2NrIGlzIHJlbGVhc2VkLCBhcyB0aGUgbnMgZGlzYWJsZSB3YWl0cyBmb3IgYmFja2VuZCBJ
TyB0bw0KPiBjb21wbGV0ZSwgYW5kIHRoZSBucyBwZXJjcHUgcmVmIHRvIGJlIHByb3Blcmx5IGtp
bGxlZC4gVGhlIG9yaWdpbmFsDQo+IGludGVudCB3YXMgdG8gYXZvaWQgdGFraW5nIHRoZSBzdWJz
eXN0ZW0gbG9jayBmb3IgYSBwcm9sb25nIHBlcmlvZCBhcw0KPiBvdGhlciBwcm9jZXNzZXMgbWF5
IG5lZWQgdG8gYWNxdWlyZSBpdCAoZm9yIGV4YW1wbGUgbmV3IGluY29taW5nDQo+IGNvbm5lY3Rp
b25zKS4NCj4NCj4gSG93ZXZlciwgaXQgb3BlbnMgdXAgYSB3aW5kb3cgd2hlcmUgYW5vdGhlciBw
cm9jZXNzIG1heSBjb21lIGluIGFuZA0KPiBlbmFibGUgdGhlIG5zLCAocmUpaW50aWFpbGl6aW5n
IHRoZSBucyBwZXJjcHVfcmVmLCBjYXVzaW5nIHRoZSBkaXNhYmxlDQo+IHNlcXVlbmNlIHRvIGhh
bmcuDQo+DQo+IFNvbHZlIHRoaXMgYnkgdGFraW5nIHRoZSBnbG9iYWwgbnZtZXRfY29uZmlnX3Nl
bSBvdmVyIHRoZSBlbnRpcmUgY29uZmlnZnMNCj4gZW5hYmxlL2Rpc2FibGUgc2VxdWVuY2UuDQo+
DQo+IEZpeGVzOiBhMDdiNDk3MGY0NjQgKCJudm1ldDogYWRkIGEgZ2VuZXJpYyBOVk1lIHRhcmdl
dCIpDQo+IFNpZ25lZC1vZmYtYnk6IFNhZ2kgR3JpbWJlcmc8c2FnaUBncmltYmVyZy5tZT4NClJl
dmlld2VkLWJ5OiBDaGFpdGFueWEgS3Vsa2FybmkgPGtjaEBudmlkaWEuY29tPg0KDQotY2sNCg0K
DQo=

