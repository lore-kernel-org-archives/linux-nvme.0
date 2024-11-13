Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07279D462D3
	for <linux-nvme@archiver.kernel.org>; Wed, 13 Nov 2024 16:35:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=OrSN4+0worMwq3t5/+rcCyjGYjX8lYhumtEhkK/N2Lw=; b=HLRlIvxWSzCSOMO/F+ipr8fZED
	R5g3kpq9dkGsX5pR7GxxEHy7fXfVFOam69JycrqXdob65FvTbV7MY5/Dc1knhnYbOjSZ/XIrb/wO7
	6oYRQ9E898fykSyclf3fLxlsjhH+jAFIEamBzOqz08uHbeTPGIZ0DVc0jGLKavwLdOBnf1M1YoDmE
	X3s23nuM+/qAhMHue0PUQObA97Ct+F2G81lHIUhanpdR/p7CWYsAIspsbcRoR5pEZrreyjBUXyyuP
	CxlIZNqnCFvD2zmmDtLQmIa8Fw8n/bY2Olet6kyD5M+8wbKLTl4ou/PV2D/jmfsj9Zmex61UkUbDA
	DbjI+jeg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tBGLO-00000007TGa-0YRI;
	Wed, 13 Nov 2024 16:35:50 +0000
Received: from mail-dm6nam12on2061a.outbound.protection.outlook.com ([2a01:111:f403:2417::61a] helo=NAM12-DM6-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tBGLL-00000007TFl-0nMK
	for linux-nvme@lists.infradead.org;
	Wed, 13 Nov 2024 16:35:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wfGBYyYKsE02oegc1RpyUvuvnasfgribSkEDgog5F3Xixytx2oTioz8NJ+UOjp3/qT2l8tOp8acGeeJP6Hcdisc/raBgP+erC+99YiD5RLR+gqSzpyuZ0ZkdDqSl/8HtaHEDdt20BwEBtQycuFJiW1EK17AR8gD7Xft7F+3ZpfVewSN0ugqJ4/vIhkOrLngwWEXRXhhwRMKCuAFh6ABeWXC5uOd/IbfeIV9rthlnGSxQTvPKpcBF99lUEyeLw2WJ67ImUM3v+P9FkjPmr87Ip8/um3khd80O4B9UQnbzYS1lBYy33w6Lro8nrlQX/W0Tog96P/jI1XiAelxaSpWnCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OrSN4+0worMwq3t5/+rcCyjGYjX8lYhumtEhkK/N2Lw=;
 b=om8UVEOpFpP0rS+NSnF0QfiALW8nHXXwVuNxdUcYBlzDZ47qcxEguQQja23eYzQX0Zsk9fjP3sv0Vx/9FQh81tgwKDn2jcB8ciEQ4EA0Vxt+iMm6QEiWuzQDFVdkGsT48pUyz16UcwtypUJdCwf8Dimw4CpLfRJiHoEdHafHM1lEmdCKvOU1JKXISp/CkanaEGgCwBGNi0peirlbgmQoNfTr+/FT0Y9MyyftHN919RHugU3jNwu1uR+59/OmE1e2hmxyghTorBCNI1qTnls38asnbO5seB0wNAvV2gHV1ozpR0+AG0CjMFzOw844db3kHm+Eye5+Ashp9v8rPA3OyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OrSN4+0worMwq3t5/+rcCyjGYjX8lYhumtEhkK/N2Lw=;
 b=nEwWjkDsiHBGGjuS5C5RA73+uqPVOdm/+H9aZiCcgcaIFEsDjDGO9I4Og0BZfby+8VATiL0HFWx/tiPd2rLsUlV6WgFqurCNsdHtpn3ibq16dky1gMPK0Nxga1lGQe4MnC3YANnMR4ZdFn5CwLUX4li2HOwaJNG3HIrV4xFBUWZqI8+9xsTzzzLPas2oFEVpsAJzStzJg+HHzKp6n+a3xu+bMyj7wpGA+VSBt4+IWOaRrFqtNuNWJ05tDwezQXFoDvBbyCEEJtu7ZNGK+k/wFgCQ4a51rIXNM9bYqBr+ZMjBVBV57GPn9L/gfpfFKrcYEVurG8KRjayOpOqIjlODNQ==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by SN7PR12MB6909.namprd12.prod.outlook.com (2603:10b6:806:263::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.29; Wed, 13 Nov
 2024 16:35:41 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b%5]) with mapi id 15.20.8137.021; Wed, 13 Nov 2024
 16:35:40 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Guixin Liu <kanie@linux.alibaba.com>, Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, Sagi Grimberg
	<sagi@grimberg.me>, Chaitanya Kulkarni <chaitanyak@nvidia.com>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH v5] nvmet: report ns's vwc not present
Thread-Topic: [PATCH v5] nvmet: report ns's vwc not present
Thread-Index: AQHbNbVvq+imEbiQuEybFNmt+W2NVbK1aLsA
Date: Wed, 13 Nov 2024 16:35:40 +0000
Message-ID: <417394fd-0afd-4571-86b4-ab255ef9ed1a@nvidia.com>
References: <20241113101839.101320-1-kanie@linux.alibaba.com>
In-Reply-To: <20241113101839.101320-1-kanie@linux.alibaba.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|SN7PR12MB6909:EE_
x-ms-office365-filtering-correlation-id: 5670be68-5bd0-4f11-b0f6-08dd0401364b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|10070799003|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?QXVhUElIRWVHdDc2czlqVDVYVS9tbGlDbmRZWVBXbXdXcUsxWk1KWXFZRlNt?=
 =?utf-8?B?R2NUNllxeGo0aUN1TTdETWdmV3VnN0RiU3RxNUtXSkF1eHBsUDF5RUo1Rmdo?=
 =?utf-8?B?Wis1MzY2N0pIRGhHbFFiVTArM1RjWTB3cEpPTGFGeVVsaENvZnI1MGkzdklV?=
 =?utf-8?B?YkFZY3BPK21yYzVvamhWTXN3YnlOdjJSK0tqQVBHT2E3U3NoOVhucW1VMC9j?=
 =?utf-8?B?Ryt3eTA2OHRTR2sxYUpZRlFjNG9rSzJ6cjBjSk9yWWV0RUZmQkY3SktPRFFT?=
 =?utf-8?B?dG80YzFCQjRFaGVDUkdQTElvSkhQcUEwN3UvRGw4VGVpYjRjaUJsaXJZdkhT?=
 =?utf-8?B?SkJpcHFETGEwZmlWUG1VWHZpVTVUM0twMG1FRVlseVdMaWZBMVcxemNqb2dq?=
 =?utf-8?B?Q3RXTWpEYk9RVmc5VXdubmpJMUR4SjlnNkh3S3czYUpSRW5vc1doOHlGdEFs?=
 =?utf-8?B?TGVyZHhURXBPWUYwSzNubWJMNUlLbzM2WmJnVWVWYzAwM3NOdGM5SldXenRa?=
 =?utf-8?B?eFRkYVRSdTdjVVQwb25JcTZPdlhybWxrc050dGVzcTArQldhV2FuZDJMejhl?=
 =?utf-8?B?M2JKSXh6UzZ5bjRqUGRHWklzVWVjSmhrejNVK0VCTkN4dVZVbUF6S0tXYndB?=
 =?utf-8?B?R2xQSlZCc1VKRVh3UzJmOEE2a2NIbG8zcThXMlZRdXErei9aL1hoaE5FY2Ra?=
 =?utf-8?B?UWlOOUQyZWkxcXNROGJ5ZUFEMEdvNXhDNzdlcE5DejlIYy9vcVg1UGFwVE00?=
 =?utf-8?B?MlJMRXgzZWRsY3YwaHQxcG1PWitzcGgrMnlONStyenNSV1d1V1oyUnVZVWF3?=
 =?utf-8?B?NUFmOUhhUUFqYjJXUzRuS21BZjlWeVZEaW1jNlk4RW1kSXFYYVdwUVBScTNE?=
 =?utf-8?B?TFZyWkpSWFgwSkNvY2R2Zm5nNWpreUgwSTByeVo2emhrckY3dThJMkJzMTlL?=
 =?utf-8?B?aFdZWWk2V2hEYVBMZkZ2bS9uYnBEOTdNZjRRa2hxWTVTYjdKcExmUUlwNTFl?=
 =?utf-8?B?N0NkWWdYZzhEYnljV2VGZzdZcHQ0NElkeWRHdG9JYzZDODRVc3I5bVdxZlVk?=
 =?utf-8?B?US9KTTRUVG1YWEZBK2Q5TXVjUlJTdmpxamFHR0VKSnZGSGVwQkdrSXNkeitE?=
 =?utf-8?B?UTVvaUdjMUZKK3Y2NEdybFh6b0IzZUM4ZnQzdGNnMHZXd1RhUFB6QnZnZTJP?=
 =?utf-8?B?R1VLbVFkRHgrWm5aV2hscG84ckJUQ0t5Ukl6RXhBZ0Q5VDFZbE9kSFhSNXBK?=
 =?utf-8?B?SXVEaDJ6RHpRY1pBL0pBWnliWitDY1NIVStyOHhLVWpoUVJsOVZHQkp6OTdB?=
 =?utf-8?B?WEdJSjdUdDJMMVBCOHRTSmlCR0dSa2pKUDVmUkM4Y2dBZEkwc24rMWJFd2R0?=
 =?utf-8?B?d256NndaR1ViZ3M0MThWOVFWbmxSU3FNUVZLRDZudmpEQ09vSjR6QXQrQlAv?=
 =?utf-8?B?cmFwQjBMYThLaktKRWVVSnFBMHJvVWk0cWVEd1lkOEJYRGsxU1B2VThteFR2?=
 =?utf-8?B?RXpGd1V5NlEzbnF0VGhEOVdDRlJYalpyZlA2UXZleDJDdzVrSzVkcDVCSDBj?=
 =?utf-8?B?bWRzYnRwR1RBSlUwaHBDTlFrM1RCUlZ6WXZIRXJidVo1TTM1OTNjNlZnODR5?=
 =?utf-8?B?M1h1RWhWa1hNUUVKOXc3QTVkaS80cFlQMEJzNHc2bk5Hb3hWRDhXcDQzdm5Q?=
 =?utf-8?B?MG02US9UVjJXclhZbnVqZUFPZ3VSWmNic3pseHptUU9FRDI2emNURW4ydDFa?=
 =?utf-8?B?bktZeThpeHptSVlHV29QbzQyVUR3R2QwWnB0RmlBVVYyT3crT3ExLzhhVE9m?=
 =?utf-8?Q?HDaboeF/wJQ2z4PHPCmnomTlY0SWAQfS3/ihE=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QXB6Y2kzN29zSkRqZzlRYW9kOGlUVldTY3Y2QnJLOWR5NHk2YUdpckxZV3BF?=
 =?utf-8?B?SjcxcnBWZjhXWWExT012RDF6bVVhMndTaFdoTFNONXdkdU81Z1pWUHRtY1dS?=
 =?utf-8?B?R05teDZaL2RKYWpIN2VmSWxISjE4VG9XUk5IQUI4dUFwdVVoelM4K2ZRT0tW?=
 =?utf-8?B?NTcyaHhEdTdYNnVPendIeExKWFlYR0ZOSG1vb25uV2JCVktsR0NqZktpdCt0?=
 =?utf-8?B?L1VEZXZDVVZpWVljVm0vdC84QW9GR3dGMW8zRG9HL3N4VE9RamhGaUV1MnhH?=
 =?utf-8?B?MWhCUDE1dXlYU09oWHdYc2p4RHNVUXJQbExvb3lRaGRuMFAyWmQ0V05sSlZ4?=
 =?utf-8?B?UEZDMHNJYlhBdU5PK21XcmxXMEJQK1FrRFZkTG9FVldrNnlyUkFqbVkzajI0?=
 =?utf-8?B?YytvRXRITS9IaFlIeGprbTg3YXk5dUtUQ3RTdFV2NjBMVm5TTUFsd2ZnVEdB?=
 =?utf-8?B?Zkl2alluUzkyNkg0SkcyeGFwM21qVHBJa043VTRRZFI0SC9uVkhCNm8xYlM3?=
 =?utf-8?B?YThrNlBzYUVHQ21DWWo0NVBJMnpkKzh5U3JyNjM0a0NYS0JkTVJVQVRXcDRv?=
 =?utf-8?B?NUxjUllBNUpzdEpxN3MrMWcvWExqd1hsbHNUMFdvTU9IRkNsSW03SnNvTXNm?=
 =?utf-8?B?dWIrYUZ3Y2RndUJpRksrWnY2Y0I0UWZibktQNUltVWVZZkNzYjV0Sk82RXRR?=
 =?utf-8?B?Qy9HcmVkZEY3cHFuWkY3Q2d0bGdXSWJMeWdMc25HYmZWdjlTYTRUR3RkR0wz?=
 =?utf-8?B?L3Ixdk1ib0RTTVFtZTdYQnlSNFkrVklIK0s5eE9zV2pvWVVjSjc2ZmdtSGNz?=
 =?utf-8?B?Uy9YUDYreVVxUnh4YmRRaEdNQzI0QkZXWWhxb0RaeEU1RExBVVBWRHhVWDBC?=
 =?utf-8?B?VDVVd2RZc0psS3h1SG9KaURSNVFhQTFUb1ovR3RoblpjKzhka3pBWXZ1QXRG?=
 =?utf-8?B?VkMzRmxSajlIcHVUamlCYThmdGRISU41dUpOcW1FclcyL09qeU03N0Q2K21h?=
 =?utf-8?B?enNlM21FMXRIT0o4OE55UFRFdXNLaFdJSDZuVG9sbE5XY2tvenpTYVUxR1hR?=
 =?utf-8?B?V1RMNFNOSG1iSDFXdW04UW91blBuTmlRL0FHVUxUOXpNNTZ4Y1phLzJBR2x3?=
 =?utf-8?B?dmpUby9DOG8vcVptNGVxZEZYb1QwSkg2VUhCdkJRVlRFMXFNYk9nWENEMUxV?=
 =?utf-8?B?aGpnTzVXOUM5VnBhZGVRcjdtQmFYdFROOGxGOFBhU3lwb0JqRUtSdUpqMVA0?=
 =?utf-8?B?bmk2TkVhMFJDNi9pN2FmOTZlblAvQWNvU2RJcFRPeHBiVTB2RlIvcW9xNW1E?=
 =?utf-8?B?QmxzckRLWUtIOGJTMlFtU3ZoUHkzTWlydStpN04yc01ha3h3ZmRMNGtmeXNC?=
 =?utf-8?B?R1h2eGpjcmhiL2tFNEFjMUNmcmkxYmVFUmJDelpsVll0UW9iZ1lNVkNDMG5C?=
 =?utf-8?B?K0o0SjQ2aThYWUY3OGErQnRUYUl6NWxiUTBkT3dGNGdtNTVaOUIyWHFveEhP?=
 =?utf-8?B?R2tVNTdySzU2Nm9MNjd3SHptMnZuTHdYZXNiNFhlQkdXRCtJVm1wd2Jkbm1y?=
 =?utf-8?B?STB4enNEWVBaK0hNSTh4T0dOMUIvK0pxa2R0a0dHRzdqaWplUEhvSno3eUVZ?=
 =?utf-8?B?ZERaRHBYeld3alM0Z203THowV0l6SEV2T2tDeDlwSXoxK2Z5RE9WOWpkZnhZ?=
 =?utf-8?B?QnF3bkZ4MUsvTTllYmhNaTE1b3JPK0hGVGRhWGVFYmpnRVdjVm1jTGR2U1lQ?=
 =?utf-8?B?c1RRaFFENHdwZ0R6Zkt0bURyN0poeEx0dS9qTHo5S1RhTWJnWGxOMmNYS1FG?=
 =?utf-8?B?aHhjdm5zQUpUaGN5SWtGeHZJY2NHNUYyNjdZR0FFZjhBWGZRZEZlclNQbitx?=
 =?utf-8?B?MU5EYVlCZTNQejB4SXBMQVNWQW1YK1UxeGZxcExVdU8vVWdNdE9DSmE4TS9p?=
 =?utf-8?B?dDYydDc5OUt5dTN3b3pTaEJqbUdtVi9WZHlWbG5qZy9JSlpJV24vVC9lcEVK?=
 =?utf-8?B?QzBpaHd0NEtSKzFlMkEra093ZVRBblNSd1NnN0Ewdkc4dDNzQVZDTEtwQ0U2?=
 =?utf-8?B?clFUdnNLK05HVld6aXVPWGV1ZDJFc0hRRURUa0djT2hhZk5Kak5SUndiL3Qy?=
 =?utf-8?B?TnhJZ2pwa20xdC9Mb3Y5cWdZUitVZCtoYjJGVk1FekxoWG01Z1U4N3RCQWVV?=
 =?utf-8?Q?pNNx2WBBYM7HmctxVBdG9Er6tECoA3ji/i7W3Ou9a7Xa?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1A628FB299C95343B2A39687D1C99E1E@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9404.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5670be68-5bd0-4f11-b0f6-08dd0401364b
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Nov 2024 16:35:40.8846
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UfWSLk1xekqchaHW8bpKY0+TCy61V2ASW2S4kgDhlvYOgfNdLkWtJOmR/GYg9X13Ff4AbZbTS+kAgsCVHY7HnA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6909
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241113_083547_252668_43C4FEF9 
X-CRM114-Status: GOOD (  10.73  )
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

T24gMTEvMTMvMjQgMDI6MTgsIEd1aXhpbiBMaXUgd3JvdGU6DQo+IEN1cnJlbnRseSwgd2UgcmVw
b3J0IHRoYXQgY29udHJvbGxlciBoYXMgdndjIGV2ZW4gdGhvdWdoIHRoZSBucyBtYXkNCj4gbm90
IGhhdmUgdndjLiBSZXBvcnQgbnMncyB2d2Mgbm90IHByZXNlbnQgd2hlbiBub3QgYnVmZmVyZWRf
aW8gb3INCj4gYmFja2RldiBkb2Vzbid0IGhhdmUgdndjLg0KPg0KPiBTaWduZWQtb2ZmLWJ5OiBH
dWl4aW4gTGl1PGthbmllQGxpbnV4LmFsaWJhYmEuY29tPg0KPiBTaWduZWQtb2ZmLWJ5OiBLZWl0
aCBCdXNjaDxrYnVzY2hAa2VybmVsLm9yZz4NCj4gLS0tDQoNCkxvb2tzIGdvb2QuDQoNClJldmll
d2VkLWJ5OiBDaGFpdGFueWEgS3Vsa2FybmkgPGtjaEBudmlkaWEuY29tPg0KDQotY2sNCg0KDQo=

