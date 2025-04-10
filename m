Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D0E3C369A2
	for <linux-nvme@archiver.kernel.org>; Thu, 10 Apr 2025 01:35:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=707u1pupWJnf/cW5QXpODbBEbVxlivW1Sha8CVGP27o=; b=S5NPjZo2T9WXD4jWB0poIcRMe2
	O+4NWcLUNSh0JSzUwXMbKO2TcaZZG4C1tZ/V8EqPkosKC06NVLnfspHYDOuwB6KSnuPmIKgCIR4dh
	65SNdpYU/YCHC3ct4r7+l7WI1Lt+tlLedlqCqJN8DftHL9d9Z1xhbKHocwsg0y2EhwfWENRRMGTip
	dRXEQqwCjtGGnOR5jYWQHPKnhZo30mB5WZ/Yf3ynZ2YA11i9aOLd05eH7s7T6Mm4hvjibiZ0lE/v/
	WPihedpXHmPlHQp8d2ILiKtBtwVyHIQq6yrGpaZ24StNfVZyKqKoXTIHhVrIE34i3f6vQRZrZDzAF
	46ybDV9g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u2gpL-00000008wzO-2h6E;
	Thu, 10 Apr 2025 01:35:35 +0000
Received: from mail-mw2nam10on20613.outbound.protection.outlook.com ([2a01:111:f403:2412::613] helo=NAM10-MW2-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u2gna-00000008wdJ-04fL
	for linux-nvme@lists.infradead.org;
	Thu, 10 Apr 2025 01:33:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aXMtATqwSCvK8Eh+COw75Vw9VjsEcGv2W/UsJXfckEWVIS8t79UgVk5pg1zbnZ8tKJYpiMLzSPFzqGVH3T+vGPBC5q7zOP95dZT4wLihixi6xDewdqwn3ruivZTCb2mqchQogchCzmq5f5h586PkIv4mb3F8c4vbDwrVzCWflfhl1YdVTzk/DkqN1w7bnoQkpsCrmIedsiEjrhFao0qAtzVC+DtIpYSa39e0KOXMMrwaojuj8WJmtrmtM12PLDE9GjBmOj9NHTdyM0CHDOZIN6BrmvHD0z4ffIMJdhAhzHF+q+8sFCnTbkMya+deSPEDUMFXgFOgnJYwGMlRPK5GqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=707u1pupWJnf/cW5QXpODbBEbVxlivW1Sha8CVGP27o=;
 b=INpRwY4H8BeS31Wz5+nDnW0VBG+FCDHAQAVUuw3U2OIGblcSc0ZBStftXvTBhZAHbIKXCbYULv59M3f5Axpaiyy/ojKT+yfRhX7GHDd0YzdK+82zYJM24XPXY4IDS5+6yoDYqQMfdwv1lMHl2FGZ/l0Bvkbw4jYDc206rWeYu3Ada/cGOvqUju+V9vYD80zJDaaRI7147WjU3NGYYcC/8Y9ZGcC+bE/DmC9YK+kUKjO+sC04pybJetJAwgJ98HpYr555AIkrXhfFvH5fbVnpRTPZECdqXYXOuYdlpWRCXPfygn/vqTgdpzu4dOb/0/NiHlKQRY079s6JmPepOmT9Rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=707u1pupWJnf/cW5QXpODbBEbVxlivW1Sha8CVGP27o=;
 b=lj2VIaCYF+X5DrFzk43ioudoxE+YgOv2tcl1tpQiSdzdfkeINiBwFh2sLGspctDDY6++e1vIioJj1lKjb9jtEGBNGZnYvbgVE6t1U54Z+y+7z2JoIswRtZCB5JW9mk/SuyaGBTvSXTrwlYfx1Q910sS1Gm9w0o/3ac0DET4Xo9tgzux3JEXVhPPbkZnXjDghINvLh8kfPiYb0RB3n7FSXm8ZjfVpCECWcxx1UEIBsSEyBSgwvdoeUULJ1+iKwCBcx/8SL5ILvWmWtxDh7Q3OGHovX1QmA+Xe/Pvs0v0K5Xs0PM2EFnRTKxnBG31dBbay1+MK+LYkUJr6BCqSarVezw==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by CH3PR12MB9148.namprd12.prod.outlook.com (2603:10b6:610:19d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.31; Thu, 10 Apr
 2025 01:33:39 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b%5]) with mapi id 15.20.8632.021; Thu, 10 Apr 2025
 01:33:38 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Christoph Hellwig <hch@infradead.org>, "alan.adamson@oracle.com"
	<alan.adamson@oracle.com>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: Issue with AWUPF when using multiple controllers in a subsystem
Thread-Topic: Issue with AWUPF when using multiple controllers in a subsystem
Thread-Index: AQHbpbL7Y6xDvP39E0WZWwk4rCeLz7ObEZ4AgAEUJgA=
Date: Thu, 10 Apr 2025 01:33:38 +0000
Message-ID: <23d2c5c3-0832-4b62-a151-74a021c63201@nvidia.com>
References: <4a2e4561-9311-40c9-aa65-87e7a2e5b041@oracle.com>
 <Z_Y4TFTqriOTxXsO@infradead.org>
In-Reply-To: <Z_Y4TFTqriOTxXsO@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|CH3PR12MB9148:EE_
x-ms-office365-filtering-correlation-id: 34f51226-dfad-423e-726a-08dd77cfb820
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|10070799003|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?M01ySUIxZWJwaG50NUZiZlBZeGdpKzBMN2Q0TUsrN1ZQUTBxckE2T3JYSGFE?=
 =?utf-8?B?NUpXNDhaMEEya05hMXV4V1VZb1FWWE5SdmpnVmkrejRCWTBNcEg4VnVvRU84?=
 =?utf-8?B?c1FGUWRoNmdZTmZoRU1PZHNaMXlxVjhCQ3hYN2NWeTJQcnkrV2VQUHBCdlRn?=
 =?utf-8?B?ZUI5ZnZKU2VJWG5MWSs5TFBIYmRLaDhTekNud0ZFazFDdzVYR3VjN3phUmhP?=
 =?utf-8?B?amxoWWluT1ZxQkFqZmFNMlQvbTE3N3hvQXZDT09KYnJpMnBwdlhEMzgrNXB0?=
 =?utf-8?B?ck44T1lJak9CT2hMS2xGS1BPbHBjYnpHUFRFM3RBb0V2NGgraDY3TnViczJ1?=
 =?utf-8?B?azhDbHNRNzArQVhCTVlhY1JGK3llZGxEY3R1OW9tS25WNm1yOWZCZSszN0RG?=
 =?utf-8?B?NEJycmt6UGtWcms1NG1uYzE5MDcxVmN0SHZKZnFYRGpidG9ZVXRZR1REQnBv?=
 =?utf-8?B?bGRPMVlQcWcxTWhUQnVCT1A1czN3WmEzUE9LZlBVdXJXUGwzY0xlRjVxc0F2?=
 =?utf-8?B?OG5qVS9KblhYeXlneW5tQ05lZFg2cVAxTllQOFUxNzNnUjRqUzgxT1E1ZUd2?=
 =?utf-8?B?Qmd1N1c4OHY3QVdYNXUzWHN3RkN5eWZNTU1TeW11Y2k1RlhEVVllV3V2VkF5?=
 =?utf-8?B?SVZHclBvVTRUbFhlc2JiZUE1M0pXQkEyN2Myd0VHeVYwQklKclVrNjU0cUZ2?=
 =?utf-8?B?akxjR3VkV3NRaURLamUzd3ZsbXQ0U0lxRlAxaUtNNm9wWk9NeXIrUHUyajhs?=
 =?utf-8?B?b2YyVnBiVE9xb2JKUFhrdVl3NVlhcE9LTWFCM1E3c3JpSFNISyt6M25tZEZy?=
 =?utf-8?B?S3puOXNRSTRIaW05L1lxV3BuRHA0bGpQbU52cTZvZVRUdFAxQVR0WGRjakto?=
 =?utf-8?B?SzN1RDFPK2Z5MkNPRVpQQUcwQVBObWEvWU01c0ZRZENKb3ZZTVllcTBCckVZ?=
 =?utf-8?B?Q0ptdm9STjAxNGlxTFZJK3FCNGVwNUp3ck0xTGtiM3BGZWpjbW1OanBTR3ln?=
 =?utf-8?B?MUFBVWlwUlZJbkZIWFkrSVhLUFA2QW1icC9zdm5tRXVQWDB6S3o5SHpzWmg5?=
 =?utf-8?B?aHBsdTUrM2NVWEgxYmZ4MGFIa0lEcDF4Zks3K201QldWQ2ZTNFRFZ2FkNFpI?=
 =?utf-8?B?bm5oQ3pzV3dOc21YOHBaRUZpMjNaR3Z0OEpTZmVuMUZZOTNoRFM1MjlId1cz?=
 =?utf-8?B?N3N0QjFJNC9kc1lXcE1nSE0wZFIrMllwNnFvaXpIMlUybDFXZkFqZjRxbXpy?=
 =?utf-8?B?am9UdHJNNDF6TENJeHE2SThVTnZMenhJVFQxU3RaaEtMNUNSNWJWb3NMVXNm?=
 =?utf-8?B?R3ZBcEt3dDlXWDM2c1JmNGhNR01rVjZtbEJ2TmNKRVJjZGRrWHZkVGYxSndY?=
 =?utf-8?B?Y05tNGtkMDQ0cERydmovNDVyZHExOUhKTWtOdGJnR2JJejVoZUNXU0ZaM3Iw?=
 =?utf-8?B?RkJLWlRKZkdwakdWT3ZiL2M3N0dacXNVREtCcUpEMnNTMUxwbnBZQ0g1SS94?=
 =?utf-8?B?VURrb0JicVNGMDVVeHBMK0VzSjJsSHZNSzlsdUMzeEJ3Q2NOVUk5bzZ2b01i?=
 =?utf-8?B?RlR3VFJ1V3pjL1Y4bWJpNytzVEdUV1M0c3E5OTBzNm82RmpKYjJ2aTNKNzc2?=
 =?utf-8?B?NmRWU0NFSHJLVTJRejZBQUJ0Uy9WNEdFSzhGQWJyVFBIVE93b2JPcHJqbE45?=
 =?utf-8?B?bFJRUDZ4U0QvQ3EzeHptU1JIN3EvcU1ya1B5alArZmZFdktXd3FzSmNyS1BD?=
 =?utf-8?B?ZkFKZnRmSUhKVmNKUlZjMStpbzlyck4wYjRkcnVtWmc3a29sTEkvQzZXeVRa?=
 =?utf-8?B?WExiRjJtMkY4SnpJYWlFODJ3WmlVSm11cXBpL2wvaXZUeGhhZmlnanRqcmg2?=
 =?utf-8?B?RHhvRDdQOExYM1dXcHdyeWVFYXVrbjFibWRQNzZoOEdHdjc2SVI2R3NCRW1y?=
 =?utf-8?Q?JurV/LompjpaaxGwkVW1RlRWaTunI1br?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?a1RRR3BHalNJcklPYVZxRmRVQ1VUR1ZhdjREVzQxTWhDWTgvbXVpRHdXN0g1?=
 =?utf-8?B?Qkp2cjlrWTNSRlhtOTJLMXg0WEtnVk04anIxQW5VTkNLd25YN3I0N3NDU0hx?=
 =?utf-8?B?VmNvSkhEWW0za25tcGxnRW1vZDRIaml0ZUZWRHdVK2dtVXJsNmxOcjJTT3py?=
 =?utf-8?B?V3prajN4a3VmUlVlL09CblE5VVcyWkhoYWdkREZBUjZXNnU5UTdRcDZRSWtj?=
 =?utf-8?B?a0o4Y0RyVDQ0WTY3UGFrRVhiZHN1THE0RjlNSE9GemlGRG9oQUxWV1NZU2xs?=
 =?utf-8?B?cWdadWxjR3JjeXNuY092alB1enBZQUtpcGUyRjJzUTNjT2JYdTdrZ09PL3I3?=
 =?utf-8?B?Q3g4bGJKNFlHWENYVFNBa0xMd1JHVWs1dWQ4Q3o4U2VCYm95bUZTS3c3YXdY?=
 =?utf-8?B?cS9vL01hZTNWa0pnQU9HMzRlQmNSV1Zrcm55OTNaNHMyR25zZldNMFpQdDVo?=
 =?utf-8?B?L2hqRklqK3VyTEU0T2Z2WXpITjI5b2ZOTVZZenBFK2ZHbFlYUnJBd0ZjclBW?=
 =?utf-8?B?VFVXVG84YXNrdHIzVVVYRmc1WnlVSHNmODJ1ZkNDYmFCc1l3L3RBcnp1NUlE?=
 =?utf-8?B?QWVhWnZwNml2TjNTeTZHTTF2UkZsRGg0aU9sc2t6MThWSSt3WWkrTGdKYUQ2?=
 =?utf-8?B?Y3J6NU9zY0hTdGFQM1BTODU1VTBXUjV1R3orY1VCMkNKdkhzM2tZeVpjVmx0?=
 =?utf-8?B?TjlZcjhVWEZIRVlsbHcyY1dlZlR5bzJnbUpPRFZWeWFraWo3MTFIVDEzTXgz?=
 =?utf-8?B?Y0UxY1RybHhLZnpVVlRYK21OeGdUWEpHY3hKMlkzd28wbVNoalBEWVBERlYz?=
 =?utf-8?B?T3pmRFI3QVNMTGEza0pZM0pEdUxIeTJydTZQemdDUVBScWNYSWVqU2txWUt0?=
 =?utf-8?B?eDRHZGhBbEI1NnhPOWNVWHh6eHlVWGpOOHBwVWJWRnVMSE5KK2IvcENGczFs?=
 =?utf-8?B?azJmQ2FaSHBPaTZaK1hSL1czUzlabVRoaVUvNWNxeEdra0FpdlNwM05hK0hy?=
 =?utf-8?B?ZU1BSHdtWmlGVjZyN3cwM25VUzNwTkUwNXZJMllTUHhUSEV6RmVPMUlVQVRq?=
 =?utf-8?B?R3J3czFOMk5OS2x4K2pvdGxsY2RmWDZRSUoxRDllLzFMK1NxUFBRdjJrQ1l4?=
 =?utf-8?B?MnJDTTJEVlJLNnhrSjhVSG1mbktMa2F0UkxKU0kybVh1M045T0ExdFdkMmVz?=
 =?utf-8?B?LzF1UThsNEFaTFhyZlBiRkxoOWdERGhudko5bDl5M2lBK2YrZ05vRUQ3YS8r?=
 =?utf-8?B?MjFUZ2ZlcmhRSE5SV0k0VzdDQVZkazNzSWRkT2U4ZWNNYTd4ZEEyWkM2Zy9P?=
 =?utf-8?B?QmdGcTlRN1VUc2pwbjNyWkN5T01wUFUzRGtSOW9IczdUMkVyTWlVcHVIUUdE?=
 =?utf-8?B?T2cyWHdFWTZiNSthU1RHcDM3NFpBQWh1bFNIUTRqUmU3Zi9PUVdHVXRvc2hn?=
 =?utf-8?B?TUFNZmFES09Vbmk1aGJ4a3pqT2I3akI4Y0VaaDRMVE5Cc2gwS2V4cEVhQ0g5?=
 =?utf-8?B?N0lsaTl0K2FzTnpqb042OFY5WGJYRm1QbHV1WWdQNEY1c0hIbG5JY2h4aEIw?=
 =?utf-8?B?THdyK0RDNmxQam9SNzlSTmJuN2JoS2NuUHpTeFUxaGVRWlVqcUUzL2dObS84?=
 =?utf-8?B?NUF4U3FNcVd3ZVJLNTAyeTZFQ2Jad3l2S3dBb1ZJUkNKbFlzb2IxRFdBQnFh?=
 =?utf-8?B?eTRoWkpBY3ZWZXJTQW9KV0tzN1hvSnhZREVGYkoyZ2E2eWhUbDFGMGlleGpK?=
 =?utf-8?B?UUdlRVFhZHR0dm9qeUZsOEdPZUdkVU9odXQzOU9OQThSb2ZSc1BEQno3UWVr?=
 =?utf-8?B?bXo4RzdOUitaTFp0UDVUL2tjMW11K3ppTDRKbEd2Q29XRFlmY2NKWStReXZM?=
 =?utf-8?B?KzVUNU1keFZPVkRhaERESlJreDJkdDU0bzAwTXNPeU1wakZId2RueS9na21K?=
 =?utf-8?B?WVIyejZNR3MvWFU2Q0w2VWtJZVlpNkhZR0FPbTU2ZTUyaFcxQVZzaXd3YkVI?=
 =?utf-8?B?bkU3eGZQUUErVVFnZUEwaFIxMUE1TWNxL25MR0FtRXFqaWxZcTJpR3dsVXFE?=
 =?utf-8?B?bjN3Y2FoZUs1T1pjNis1TERvVjJvcVd1SUJTa2xDRGM1Y0J5TGR1LzVzaURr?=
 =?utf-8?B?NlJteHpPb21nVy9JSi9lQ21PMnloWHJ5TlZzNDZTNnpxT0hORTFiVzg5T0lx?=
 =?utf-8?Q?tbTulHhaULeIFdKTk6UUJXr+ehD3x2w7xK+QLGi2jdM9?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <886BD5EB1895444FB781B6E44326E85F@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9404.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34f51226-dfad-423e-726a-08dd77cfb820
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Apr 2025 01:33:38.7028
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IIUCwHX+ubA05XnE40YDZ/9InfAA++s0OXwMck7VuDQs1HZbmJxi2PMUj7UieLPT9dOySrazyS+kLAU/Am695A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9148
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250409_183346_058110_980DB9F0 
X-CRM114-Status: GOOD (  23.75  )
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

T24gNC85LzI1IDAyOjA1LCBDaHJpc3RvcGggSGVsbHdpZyB3cm90ZToNCj4gT24gRnJpLCBBcHIg
MDQsIDIwMjUgYXQgMDM6NDI6NTBQTSAtMDcwMCwgYWxhbi5hZGFtc29uQG9yYWNsZS5jb20gd3Jv
dGU6DQo+PiBXaGVuIGR1bXBpbmcgdGhlIGF3dXBmIHZhbHVlIHdpdGggbnZtZS1jbGksIHRoZSB2
YWx1ZXMgbWF0Y2ggd2hhdCB3YXMgc2V0dXANCj4+IGluIHFlbXUsIGJ1dCB3aGVuIGVhY2ggZGV2
aWNlcyBhdG9taWMgcXVldWUgbGltaXRzIHdhcyBkaXNwbGF5ZWQsIGl0IGRpZG4ndA0KPj4gbWF0
Y2ggaXRzIGF3dXBmLiBDdXJyZW50bHkgdGhlIGF3dXBmIGlzIHNhdmVkIGluIHRoZSBudm1lX3N1
YnN5c3RlbSwgYnV0IHRoZQ0KPj4gYXd1cGYgaXMgc3BlY2lmaWMgdG8gdGhlIGNvbnRyb2xsZXIs
IG5vdCB0aGUgc3Vic3lzdGVtLiBUd28gY29udHJvbGxlcnMgaW4gYQ0KPj4gc3Vic3lzdGVtIGNh
biBoYXZlIGRpZmZlcmVudCBhdG9taWMgcGFyYW1ldGVycy4NCj4+DQo+PiBUaGUgY29tbWl0IDgx
YWRiODYzMzQ5MSAoIm52bWU6IHNldCBwaHlzaWNhbCBibG9jayBzaXplIGFuZCBvcHRpbWFsIEkv
Tw0KPj4gc2l6ZSIpIGFkZGVkIHN1YnN5cy0+YXd1cGYuDQo+Pg0KPj4gSSB0aGluayB0aGUgYXd1
cGYgYmVsb25ncyBpbiB0aGUgbnZtZV9jdHJsIHN0cnVjdHVyZS4NCj4gTm8sIHRoYXQgd291bGQg
YmUgZXh0cmVtZWx5IGRhbmdlcm91cy4gIEJ1dCBhcyBOVk1lIGhhcyBub3QgZXhwbGljaXQNCj4g
bGFuZ3VhZ2UgdG8gZm9yYmlkIGRpZmZlcmVudCB2YWx1ZXMgZm9yIGRpZmZlcmVudCBjb250cm9s
bGVycyAoZXZlbg0KPiBpZiB0aGF0IGlzIHJlYWxseSBzdHVwaWQpIHdlJ2xsIG5lZWQgdG8gcmVq
ZWN0IGFkZGluZyBjb250cm9sbGVycw0KPiB0aGF0IGhhdmUgbG93ZXIgdGhhbiB0aGUgaW5pdGlh
bCB2YWx1ZSB0byBub3QgYnJlYWsgc2V0dXBzLg0KPg0KPiBTaWdoLi4gIEknbGwgYWxzbyByZWFj
aCBvdXQgdG8gTlZNZSB0byBzZWUgaWYgd2UgY2FuIEVDTiB0aGlzLCBidXQNCj4gd2UnbGwgc3Rp
bGwgbmVlZCB0byB3b3JrIGFyb3VuZCB0aGlzLg0KDQpJIHdvbmRlciBob3cgbWFueSBvZiB0aGVz
ZSBmaWVsZHMgc3VmZmVyaW5nIGZyb20gc2ltaWxhciBzY29wZSBpc3N1ZSwNCmhvcGUgd2UgY291
bGQgZml4IHRoYXQgaW4gb25lIEVDTiBpZiB0aGVyZSBvdGhlciBmaWVsZHMgc3VmZmVyaW5nIGZy
b20NCnRoaXMgaXNzdWVzLg0KDQo+IEFsdGVybmF0aXZlbHkgd2UgY291bGQgc3RvcCBzdXBwb3J0
aW5nIEFXVVBGIGVudGlyZWx5IGFuZCByZXF1aXJlDQo+IE5BV1VQRiB3aGljaCBtdXN0IGJlIHRo
ZSBzYW1lIGZvciBhbGwgYXR0YWNobWVudHMgb2YgdGhlIGNvbnRyb2xsZXIuDQo+DQo+DQoNCmlm
IHdlIHN0b3Agc3VwcG9ydGluZyBBV1VQRiBhbmQgbW92ZSB0byBOQVdVUEYgdGhlbiB3aWxsIGl0
IGJyZWFrIHdoZXJlDQpleGl0aW5nIGNvbnRyb2xsZXIncyB0aGF0IGRvZXNuJ3Qgc3VwcG9ydCBO
QVdVUEYgYnV0IG9ubHkgc3VwcG9ydHMNCmNvbnRyb2xsZXIgd2lkZSBBV1VQRiwgSU9XIE5TRkVB
VCBiaXQgMSA9PSAwIG1lYW5pbmcgcGVyLW5hbWVzcGFjZQ0KYXRvbWljIGluZm8gaXMgbm90IHZh
bGlkID8gWzFdDQoNCkxvb2tpbmcgYXQgdGhlIHNwZWMgTkFXVVBGIHZhbHVlcyBjYW4gZGlmZmVy
IGZvciBuYW1lc3BhY2VzIGF0dGFjaGVkDQp0byB0aGUgc2FtZSBjb250cm9sbGVyIGFuZCB0aG9z
ZSB2YWx1ZXMgY2FuIGFsc28gZGlmZmVyIGZyb20NCkFXVVBGID8gWzJdDQoNCkkgY291bGRuJ3Qg
ZmluZCBhbnl0aGluZyB3aGVyZSBpdCBzdGF0ZXMgdGhlc2UgdmFsdWVzIG11c3QgYmUgdGhlIHNh
bWUuDQoNClBlcmhhcHMgdXNpbmcgdGhlIG1pbmltdW0gb2YgYWxsIEFXVVBGIGFuZCByZWplY3Rp
bmcgYW55IGN0cmwgd2hpY2ggYXJlDQpsb3dlciB0aGFuIHRoZSBpbml0aWFsIHZhbHVlIGlzIHJp
Z2h0IGZpeCA/DQoNCi1jaw0KDQpbMV0NCg0KbnZtZV91cGRhdGVfZGlza19pbmZvKCkNCg0KLi4u
DQoNCjIwNTbCoMKgwqDCoMKgwqDCoMKgIC8qDQoyMDU3wqDCoMKgwqDCoMKgwqDCoMKgICogQml0
IDEgaW5kaWNhdGVzIHdoZXRoZXIgTkFXVVBGIGlzIGRlZmluZWQgZm9yIHRoaXMgbmFtZXNwYWNl
DQoyMDU4wqDCoMKgwqDCoMKgwqDCoMKgICogYW5kIHdoZXRoZXIgaXQgc2hvdWxkIGJlIHVzZWQg
aW5zdGVhZCBvZiBBV1VQRi4gSWYgTkFXVVBGID09DQoyMDU5wqDCoMKgwqDCoMKgwqDCoMKgICog
MCB0aGVuIEFXVVBGIG11c3QgYmUgdXNlZCBpbnN0ZWFkLg0KMjA2MMKgwqDCoMKgwqDCoMKgwqDC
oCAqLw0KMjA2McKgwqDCoMKgwqDCoMKgwqAgaWYgKGlkLT5uc2ZlYXQgJiBOVk1FX05TX0ZFQVRf
QVRPTUlDUyAmJiBpZC0+bmF3dXBmKQ0KMjA2MsKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIGF0b21pY19icyA9ICgxICsgbGUxNl90b19jcHUoaWQtPm5hd3VwZikpICogYnM7DQoyMDYz
wqDCoMKgwqDCoMKgwqDCoCBlbHNlDQoyMDY0wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgYXRvbWljX2JzID0gKDEgKyBucy0+Y3RybC0+c3Vic3lzLT5hd3VwZikgKiBiczsNCjIwNjUN
Cg0KLi4uDQoNClsyXQ0KDQpOVk0gRXhwcmVzcyBOVk0gQ29tbWFuZCBTZXQgU3BlY2lmaWNhdGlv
biwgUmV2aXNpb24gMS4xICgyMDI0LjA4LjA1KQ0KU2VjdGlvbjogfDIuMS40LjMgQVdVUEYvTkFX
VVBGKjotDQoqDQp8QW4gTlZNIHN1YnN5c3RlbSBtYXkgcmVwb3J0IHBlciBuYW1lc3BhY2UgdmFs
dWVzIGZvcg0KdGhlc2UgYXRvbWljaXR5IHBhcmFtZXRlcnMgdGhhdCBhcmUgc3BlY2lmaWMgdG8g
dGhlIG5hbWVzcGFjZSBhbmQNCmFyZSBpbmRpY2F0ZWQgaW4gdGhlIElkZW50aWZ5IE5hbWVzcGFj
ZSBkYXRhIHN0cnVjdHVyZS4uLiINCg0KIi4uLiBJZiBhbiBOVk0gc3Vic3lzdGVtIHJlcG9ydHMg
YSBwZXIgbmFtZXNwYWNlIHZhbHVlLCB0aGVuIHRoYXQNCnZhbHVlIHNoYWxsIGJlICpncmVhdGVy
IHRoYW4gb3IgZXF1YWwgdG8gdGhlIGNvcnJlc3BvbmRpbmcgYmFzZWxpbmUNCnZhbHVlKiBpbmRp
Y2F0ZWQgaW4gdGhlIElkZW50aWZ5IENvbnRyb2xsZXIgZGF0YSBzdHJ1Y3R1cmUNCmRhdGEgc3Ry
dWN0dXJlIChyZWZlciB0byBGaWd1cmUgMTE3KSIvDQoNCi9NeSBpbnRlcnByZXRhdGlvbiA6LQ0K
DQpUaGUgc3BlYyAqYWxsb3dzIGRpZmZlcmVudCB2YWx1ZXMqIGZvcjoNCnxBV1VQRnwgKGNvbnRy
b2xsZXItbGV2ZWwgYmFzZWxpbmUpDQp8TkFXVVBGfCAobmFtZXNwYWNlLXNwZWNpZmljIG92ZXJy
aWRlKQ0KVGhlIG9ubHkgcmVxdWlyZW1lbnQgaXM6DQp8fHxOQVdVUEYg4omlIEFXVVBGDQp8VGhl
cmUgaXMgKm5vIG1hbmRhdGUqIHRoYXQgfE5BV1VQRiA9PSBBV1VQRg0KDQoNCnwNCg==

