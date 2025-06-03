Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1FBBC5AD49
	for <linux-nvme@archiver.kernel.org>; Tue,  3 Jun 2025 00:48:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=AF6T2JmGZRXFnGx8TqS/QacDNIDvnq0EAP5zDz+qHo0=; b=IF0uQuYq84b1qz5VwIzOZYkqiU
	pbLKsT21S15lKZGfqTjWWQewSyW8nNlFiSV/AV15QnET6flzYlxiLG2bMMx3VWggwhY+vit+Sbffn
	PVORDQVt0hZqibzAo9GDDNiGJ+DlSVJz8mZqYC2oNtTX8QhCMCiau/Lndti++gmACuEocJDGL4frg
	z1DdM6APB2gzHyGDJ0jMxotN7VfSYKJNMTOq35pAB79R9EEmqIjSC7iY6OCxiJQhphfO8BgMEP4yb
	6ckJeIgaHvIJvPfBxcNYlU3upBs597YnVi6DpEwRsrMw9lKqnqfmGh8zIVuxz1h9A9wNX4fFuQj2h
	epwcyj5Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uMFpI-00000009R7e-0FDT;
	Tue, 03 Jun 2025 00:48:24 +0000
Received: from mail-mw2nam12on20613.outbound.protection.outlook.com ([2a01:111:f403:200a::613] helo=NAM12-MW2-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uMFpF-00000009R6l-2Jjs
	for linux-nvme@lists.infradead.org;
	Tue, 03 Jun 2025 00:48:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JLHAPh2jP2B4CrCushaM5WvaHXhEjXLWuM98XT8HCu+0G9LZBpjQZc60Jyph6X7i6a4f6NydKClBgdtrjDtysaeWCXTTCuMs1jiJMdCbIZ9ugxwtdd6jfEAFyLQMOppWtuzhRJtTyYw2YES+ax1GvjxtKYuR6mxfG6GPj8zxhM2Glixscws5y9f4HzlEPOWT4ect4IcPOsNL28u+LOERllVf3yyvfr4GRtzV6RTiMjBxEzo3VKRY7NSF0SD4anlT/R/gkH5nqsQzhQ76Yyo5KuDT2AdJXaciEa87SjtOrJ5iL2Cm1ai/f3cKww9e8aVptbs/MQsNyheG4QYbfGyk3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AF6T2JmGZRXFnGx8TqS/QacDNIDvnq0EAP5zDz+qHo0=;
 b=fOUlHvjl7C22W4bh2i9o8fiZN7NolDzvNOzLJwFB/vbLtrDOkN+4ZuXUsnMcWW0IavmUjdRDqVZ6leIdUpcsLIVD9eYYwIv7Q3hNoQdOu5DlgCgg5vaJVQxg/oa7AGbdlSBJsYhvdfi4ji9ZSSPNwvX9L1JbITc8QqI/6uiy+P+JgWbhhjtUKx3Jd+RM9BhD6FxfAC2ZKi9UQLDST94QSVuoBAZYVRsqfkTQrSFoTq6SWH/vVv/oRW80ZTi6tGSPcRiiCqIp48uBUZ83lHGbdp7IXSJHJF4P12m5ZdIDXeeewqMae2Xc9MEkeeKctp8qgTHl2mDng5dVeT8swpyIfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AF6T2JmGZRXFnGx8TqS/QacDNIDvnq0EAP5zDz+qHo0=;
 b=TdIT4+6fJvKoOSu7k8NHP3bFyP6/4ti+4s9nvNoZpQAU4mtIGK22Mpivbh7i3mlS2fhcwmxIiDELkDypW2btFl0Min/n7RMQrDqx5mfHvAC7VXfTj8XH2i2c6K0IMqgEg7/gqMPx8gtKIGWZTDxajwugvM/Eak/qIZgszp6fSnAXUTO1+iau46fcSYiHAaGWlbMUDd1X8XMrv4Adgq4JDvvEEKQzxRldABqEKgzoIz2dApR/Sv+Y1/zKiP4Lzs+11B9I7CrT7Urs2fegg15KtCxZANSOoTM+Y66iGh/HmwW+0ZyV/vnbcGNXbRsRBv/xmxcBMVpLJ2Dg+f+kyOc4SA==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by DM4PR12MB5769.namprd12.prod.outlook.com (2603:10b6:8:60::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8722.33; Tue, 3 Jun 2025 00:48:15 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b%5]) with mapi id 15.20.8769.037; Tue, 3 Jun 2025
 00:48:15 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
CC: Hannes Reinecke <hare@kernel.org>, Sagi Grimberg <sagi@grimberg.me>, Keith
 Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, Christoph Hellwig
	<hch@infradead.org>
Subject: Re: [PATCH 1/2] nvme-tcp: avoid race between nvme scan and reset
Thread-Topic: [PATCH 1/2] nvme-tcp: avoid race between nvme scan and reset
Thread-Index: AQHb03fUxsOFitEzQEad6K9GAezrbrPwm3AA
Date: Tue, 3 Jun 2025 00:48:15 +0000
Message-ID: <0e93f35e-eb9b-4936-b50e-36110c01ecd2@nvidia.com>
References: <20250602043522.55787-1-shinichiro.kawasaki@wdc.com>
 <20250602043522.55787-2-shinichiro.kawasaki@wdc.com>
In-Reply-To: <20250602043522.55787-2-shinichiro.kawasaki@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|DM4PR12MB5769:EE_
x-ms-office365-filtering-correlation-id: 3c1a8419-ab02-4d38-5011-08dda238531d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|10070799003|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?MXdUQ01SaVZYWHo1dVFuM2NXR214SFRxcmUvM2d6bFdpb3VTWjJqd01jWjVk?=
 =?utf-8?B?YU5nZFJLZTlXS2M1amFOYnRaRkpoWnNXTVlXRlJHQjZkTzh1b0NQNUpseXBq?=
 =?utf-8?B?QWdhcDRVNE1FQ3c3NkIzaVkvMzQ2UDh3VWNTVkFnTVhXZElxTnlTS1VrdUhX?=
 =?utf-8?B?ZVBSNDMweU1pMllGQVM3M0V0aXJiejQvZXNmUCtXWEh0ZXJrV3lwcWFZTEs0?=
 =?utf-8?B?MjNVUnZldm8xS0FLMytYQUNXN2lIdUI1Zmk1U3RqMDlzdENBMWR0eG1sdmg1?=
 =?utf-8?B?VUZxb2d6UG9HRUVydkgzRTUyQTEvY2FvODFLNHFCSzNrMWpLNEJVRVk3TWtt?=
 =?utf-8?B?VmJXV3VkR2ZyeVZ2dnEzWmJXY0lCWkh1NkNDTU92OG1DRjQ4cmt5dkE3UTcw?=
 =?utf-8?B?N1RqWUJYNEpYbStNMVRnczRiTVI4Q3JFUzJYeWJ6eHJrd2NjRmp1OUYvc0dq?=
 =?utf-8?B?WWsrYjR4ODVXbmVWVHhOWDBLbEIvL2YrdFVHM2lUalU3anVQQzd2S2JQY2c0?=
 =?utf-8?B?TGMzUWlwbnQxbU53Ui9aVUkvRy95dndpTUxkV3RpUWRTRnNIcEZ2cUJFOW5G?=
 =?utf-8?B?aXNJUkNoeU1rTExDN2tHbnM5bHBlREMxMjl0NEhzODMwUmd3enlaQ0J4N0Jr?=
 =?utf-8?B?M09WQ0gzU1dDWXoyU011bEl1M0ZTTDFlOGdMcjZOdmVNMXdRWEt1Vk90NThn?=
 =?utf-8?B?L2RCSlZnSVVGdDlwdUZjaXN4T21XZE1WUHUwVlhXaVlHVUY2K2VBTnpkQi9s?=
 =?utf-8?B?dDFZRGpVNFI1WDE3eVd5ckd3MVhrUVlycHMwOVUzZDVKZzYwWFFOb2dhUHpa?=
 =?utf-8?B?QWRjbzBsR0RqVGxzb25vejcyNjN2KzZhMUltbzhUbFhaK2ZYN2xGelB6TlJC?=
 =?utf-8?B?ZkxqRklzVWdNVm5sclFyOFBPVFllQTUrL3V6OGNZdlBmY1hqVFVHK3BuTUpL?=
 =?utf-8?B?bSt5Q25VYlVhNUt5RlpOYTBSS1lXQkdYTU44TG5LZ0tWRHFUK0RhTkM2UGJa?=
 =?utf-8?B?b1hJNDh2WHp3NDVuNzkyeXYvMVc0SlZyVFF0aE1GZXZZUXg2VUFHVWJMWnpw?=
 =?utf-8?B?VmtFZTN1QkU1TWt3UHVtblpKUjZTMkgzTzVkZmp2UkpuV2dDcEo5SnU2aFBU?=
 =?utf-8?B?ektEY29hQnAyQThDVXlIcEFlL3llSTJDREZ1bHBnWHM4UUdrZzJnNW1nTjNV?=
 =?utf-8?B?U1Yrc2w2OXp1cHd5dSt4OHpsYnZMaVE0WXhGU3FkZUZMb1dQYndwL1Q1cmU0?=
 =?utf-8?B?Wk1taThrNkNVRTIwVXlQRUppRTd5T2dTQm5veERkVUp6bEpaQnpJb05lc0hq?=
 =?utf-8?B?TFJqREFYUG4vMzBNWmYzSVVLaGw4ODFzVm9SeWVVbkN0bTNvNzdkVFIwSmxX?=
 =?utf-8?B?YXJCd0RZUDU1Y3ZHK3k1RWlnRHhHdm5DalpTdFVJZHowdEMyZG9tanhzdUpV?=
 =?utf-8?B?OWZvZllIekJmckJOOWQxUUdxQ25wZ0hCNHdRdU9UVVpuRlY4eGxmRlRHS2h6?=
 =?utf-8?B?ZlJ3VHluMXpoR1QvcVpmOFpNcnYvMUlpcERZTEQ5RWEzSmdZU1N1SUN1WXFL?=
 =?utf-8?B?TVQwUEpjT0pWZ21HNnlvSS9GVkdSNlFKc2pZaVhpVW9LNEk0ZHBwaHNPbmF1?=
 =?utf-8?B?dDJtT0hHUHYrdDVtMVB5UkNUN2RLOVNyYmEzaC9HeitYRTlYdWFvWDFSbk41?=
 =?utf-8?B?eTE0MTJONElpZ0o2U0paTFZqRHlDMGkzZHI1WGpGc0JnYTlzWnBrVW16K1lr?=
 =?utf-8?B?MStUVnhFQlBacm11dGJaVVE5dkNmY0Q2Z0dhYWJ0NEVZQTRVa2hyNHFKOXE5?=
 =?utf-8?B?ZFRZaHVldTJwdWp0d3B5TW1Cd1QrNkNIS1lmSmpUVHJJdmwzK01BbVp2Q1Uw?=
 =?utf-8?B?WjF0dzRKRW1oSVJjek52UC93YkRtaUdzYnRCSWNocFBGV2wzbDNUSENUSExB?=
 =?utf-8?B?L0t0NWFJeDBJYXhwM0VkWFJ0dFhCVHNwbGIyekh0aWNiSEJncnFXTEhqOEVL?=
 =?utf-8?Q?zcYu15vjGBZNUVeUjCv0VEmb+1FXIc=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?b0RsQTh4cVNhUkcwNUdJV3gxWjNaR2VXbzNZMnFBbHNzV2NyTFdrcWxzRzlQ?=
 =?utf-8?B?c2JMbktvTjNnZXdVSTBDc2VQMFhSUTdYcFZaMzcxckN0WWIrMEY3M3ZGOTlP?=
 =?utf-8?B?MTEzQzdBcTZVdk4xb2dLWkI0Y3BaY29tMkQ4OCsrdnB0RWtZb0VpRWRaZGNl?=
 =?utf-8?B?ZUpQelk3N3hmRzBSenJ6dDlyTTBoa0h6dlZkb3h4b2NDdTJRNUZRTU9zU09n?=
 =?utf-8?B?U2c1aHFLa3FVVGRlekx0UW85SEJ6WlVISmVCS3VSWS9FSHNnK3grci9FQXls?=
 =?utf-8?B?UFNZQWxCWTBNK1d5TnpiaHFqYlp5NXowWFIzZVFhOVlFbEI2c0E2eUhXYUg5?=
 =?utf-8?B?eFZCdXF1QWhta1U0VGUxbUlpTVhkYzk4aE1QNDhHYXBLNTF4R3lYaFJQZXhq?=
 =?utf-8?B?MGk2YXg2QnFmUHNrQnpWQU1PeDdxZmYyWmQrSDlLdG1JVEE3bk51cjJDZjlm?=
 =?utf-8?B?QXlnb1VsOHJIWTM4OU9LdU5oWjUycEpPb2pIcXlzQmQ1a0ZEdng1Ti9yUnFt?=
 =?utf-8?B?VHV4cjdpTFBXUmRmQy9nNURaczRYQk1VclVVMXI4L3pQVWg4cFRYU05UWnls?=
 =?utf-8?B?aDdoNjZqUVJidXNwdHlEcnNYMG9iVEdRWm9udnZCaXduVjY4UFU0TFpnTEpj?=
 =?utf-8?B?MWRkbEVpazN6WVBtSWlKZi9FNXQ0Z2FqWFNSckhYSkpMMWtKZ1pCaWg1SXpS?=
 =?utf-8?B?Znd5QWNINEtXbEJxVXFVTmdTSUw4SXdIWDN6bWpWMjZZR0RKVk11TW5XSHM5?=
 =?utf-8?B?NEtkYTBiU3VJR1IxczA1MmJmVVM5aC9xTE11U1d2S0pSWWk3TDhCYmZ6Rkxq?=
 =?utf-8?B?NWxGMUo5QVl2K21sdFEvQzFERktCcW1Ud3F3b1FSUW01dDNLNTY0RUdldUxQ?=
 =?utf-8?B?WHQxRXBaSUR5NnZTU2lhZWV4cEtRWlg4cWc1SWJNbXk1WDRYK0I5dndWSmhs?=
 =?utf-8?B?MHNyWkM3V25YT3BWZkh5c3NJQjRHZXNlNFR6TmJnendlN2tsN1RiRkdiWkxj?=
 =?utf-8?B?a3Y2VVl0VGNDWjBGS0VsZzhVV3JLNE9FaE90S3hxbVRkMEUwK25HZzBmNW5h?=
 =?utf-8?B?ZGRoZlFBd3RwOFBRZlAxYWFVMmJaMTRIQzFYRzFaMVNmZ3dtN0xOZVFROGsr?=
 =?utf-8?B?QWFxcTlYQVljbFRkVmFDeWRpQWcwSjJDa1NzaG1nb2V4UmRtQVgwb2VYNEkr?=
 =?utf-8?B?c0xLb2l4OG1ab2VvVHM3Nk1JTWwzUmFaSjdoR3ozQXVVRlliYTA3ajBHV29N?=
 =?utf-8?B?N1VreU9wbzhvUFp1bGxrMEVycnNobFdhTVl4aEFUc0JDbmFlNFFjY2Z6c1Rn?=
 =?utf-8?B?NEJsVXVYRlF1MU92WVRibTBqVitQcElVWXRwb21qQ3ZJK2NuV1BpTE5FWEVp?=
 =?utf-8?B?bDdWVTJmN2lpY2lEeTE2YU5oL0ZZZlNWSlY0RGhBNE5SWG10bXZMZFF4Tlhk?=
 =?utf-8?B?NFcxeW9oNlJhYnhjU0xONmIzME1wVVkyZWRSbCtaRHVsQmZEUHdnSVFCbFlm?=
 =?utf-8?B?VHVpc1RQdGV6ZFVQK0RWVkhVOE5mT2hHSW9ienZPQjh0ZnBSZlcvS3ZBeklN?=
 =?utf-8?B?Z2NXRVdoMUQ3dVVMUGlBSFBjakxOVXdUNEtQc0VXbzIvUjBYdWZlUXBDSlpj?=
 =?utf-8?B?WlhuL2dPL1VZdklPb3hGalpCeEFUeHJyS2lnUE5NRDVYb3ZUY1ZQMGxSMU1L?=
 =?utf-8?B?U2c3dmdiTm9BRUJKNXd6UUxLa2h1NUZRRW1HZVhRc01KRms2eU9EZHpMNGhN?=
 =?utf-8?B?VkVCOW5hM3hQd2psdFlnNVpzcmRQZCtnWGo1cWFXemlPQ0cwdFl5bDFhRW5y?=
 =?utf-8?B?RzV1bXkyWGgxRkIraU5jcEYwOHhpZFJMWXBOc1hTMHFBaXJwVE9LQlllUU81?=
 =?utf-8?B?NGNJbW9CT0ZyYmRTUnd4WlhYQUNsMm1tdTZDUFNNSlNlb0xhMnlDOGplZ0dJ?=
 =?utf-8?B?QkxmYllLNzlUS3BaNGxOSi9TbkErT21iMmc5R1BlMThGQjU2TlNnVUh6c1lo?=
 =?utf-8?B?cHc3eG1yR2Q1RzkzT1JGY0NoM2pOTXN4YWIxQVlXM3Y4T08vTnprY0FWbnhs?=
 =?utf-8?B?NmNCMVFabCtHdy8vRE5HT2JDaERDeUI3N0JWaTlkWTJKRFExbDRPQW1YTzNC?=
 =?utf-8?B?Y1hSbFdtYmx6UTFVS21LZXhBZXI3YzJhVjZOeVlrRTk3L1pCcmQ5dmltNXRq?=
 =?utf-8?Q?Q8fowWfR/5u7bXNTw6SKb84ROsnOGjlGI623K6BlFp0O?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <76E91CA6A4D0264FB7D04E992BDCC65C@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9404.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c1a8419-ab02-4d38-5011-08dda238531d
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jun 2025 00:48:15.2257
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xW/ZbTwMBncZb+w6UIiYEg4tgXTJd4nIRvUIeTPWIZYwKSiyGW7VqFRJLyFj0SGdTb+eZupQ+QpSXp/YnEDhIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5769
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250602_174821_785933_71C0AC83 
X-CRM114-Status: GOOD (  14.43  )
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

T24gNi8xLzI1IDIxOjM1LCBTaGluJ2ljaGlybyBLYXdhc2FraSB3cm90ZToNCj4gV2hlbiB0aGUg
bnZtZSBzY2FuIHdvcmsgYW5kIHRoZSBudm1lIGNvbnRyb2xsZXIgcmVzZXQgd29yayByYWNlLCB0
aGUNCj4gV0FSTiBiZWxvdyBoYXBwZW5zOg0KPg0KPiAgICBXQVJOSU5HOiBDUFU6IDEgUElEOiA2
OSBhdCBibG9jay9ibGstbXEuYzozMzAgYmxrX21xX3VucXVpZXNjZV9xdWV1ZSsweDhmLzB4YjAN
Cj4NCj4gVGhlIFdBUk4gY2FuIGJlIHJlY3JlYXRlZCBieSByZXBlYXRpbmcgdGhlIGJsa3Rlc3Rz
IHRlc3QgY2FzZSBudm1lLzA2MyBhDQo+IGZldyB0aW1lcyBbMV0uIEl0cyBjYXVzZSBpcyB0aGUg
bmV3IHF1ZXVlIGFsbG9jYXRpb24gZm9yIHRoZSB0YWcgc2V0DQo+IGJ5IHRoZSBzY2FuIHdvcmsg
YmV0d2VlbiBibGtfbXFfcXVpZXNjZV90YWdzZXQoKSBhbmQNCj4gYmxrX21xX3VucXVpZXNjZV90
YWdzZXQoKSBjYWxscyBieSB0aGUgcmVzZXQgd29yay4NCj4NCj4gUmVzZXQgd29yayAgICAgICAg
ICAgICAgICAgICAgIFNjYW4gd29yaw0KPiAtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCj4gbnZtZV9yZXNldF9j
dHJsX3dvcmsoKQ0KPiAgIG52bWVfdGNwX3RlYXJkb3duX2N0cmwoKQ0KPiAgICBudm1lX3RjcF90
ZWFyZG93bl9pb19xdWV1ZXMoKQ0KPiAgICAgbnZtZV9xdWllc2NlX2lvX3F1ZXVlcygpDQo+ICAg
ICAgYmxrX21xX3F1aWVzY2VfdGFnc2V0KCkNCj4gICAgICAgbGlzdF9mb3JfZWFjaF9lbnRyeSgp
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgLi4gTiBxdWV1ZXMNCj4gICAgICAgIGJs
a19tcV9xdWllc2NlX3F1ZXVlKCkNCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBu
dm1lX3NjYW5fd29yaygpDQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIG52bWVf
c2Nhbl9uc18qKCkNCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIG52bWVfc2Nh
bl9ucygpDQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgbnZtZV9hbGxvY19u
cygpDQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGJsa19tcV9hbGxvY19k
aXNrKCkNCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIF9fYmxrX21xX2Fs
bG9jX2Rpc2soKQ0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGJsa19t
cV9hbGxvY19xdWV1ZSgpDQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IGJsa19tcV9pbml0X2FsbG9jYXRlX3F1ZXVlKCkNCj4gICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIGJsa19tcV9hZGRfcXVldWVfdGFnX3NldCgpDQo+ICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgbGlzdF9hZGRfdGFpbCgpICAgIC4uIE4rMSBx
dWV1ZXMNCj4gICBudm1lX3RjcF9zZXR1cF9jdHJsKCkNCj4gICAgbnZtZV9zdGFydF9jdHJsKCkN
Cj4gICAgIG52bWVfdW5xdWllc2NlX2lvX3F1ZXVlcygpDQo+ICAgICAgYmxrX21xX3VucXVpZXNj
ZV90YWdzZXQoKQ0KPiAgICAgICBsaXN0X2Zvcl9lYWNoX2VudHJ5KCkgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAuLiBOKzEgcXVldWVzDQo+ICAgICAgICBibGtfbXFfdW5xdWllc2Nl
X3F1ZXVlKCkNCj4gICAgICAgICBXQVJOX09OX09OQ0UocS0+cXVpZXNjZV9kZXB0aCA8PSAwKQ0K
Pg0KPiBibGtfbXFfcXVpZXNjZV9xdWV1ZSgpIGlzIG5vdCBjYWxsZWQgZm9yIHRoZSBuZXcgcXVl
dWUgYWRkZWQgYnkgdGhlIHNjYW4NCj4gd29yaywgd2hpbGUgYmxrX21xX3VucXVpZXNjZV9xdWV1
ZSgpIGlzIGNhbGxlZCBmb3IgaXQuIEhlbmNlIHRoZSBXQVJOLg0KPg0KPiBUbyBzdXBwcmVzcyB0
aGUgV0FSTiwgYXZvaWQgdGhlIHJhY2UgYmV0d2VlbiB0aGUgcmVzZXQgd29yayBhbmQgdGhlIHNj
YW4NCj4gd29yayBieSBmbHVzaGluZyB0aGUgc2NhbiB3b3JrIGF0IHRoZSBiZWdpbm5pbmcgb2Yg
dGhlIHJlc2V0IHdvcmsuDQo+DQo+IExpbms6aHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGludXgt
bnZtZS82bWh4c2tkbGJvNmZrNmhvdHNmZnZ3cmlhdXVycWt5MzNkZmIzczQ0bXF0cjVkc3htZkBn
eXd3bW55aDN0d20vIFsxXQ0KPiBTaWduZWQtb2ZmLWJ5OiBTaGluJ2ljaGlybyBLYXdhc2FraTxz
aGluaWNoaXJvLmthd2FzYWtpQHdkYy5jb20+DQoNCkxvb2tzIGdvb2QuDQoNClJldmlld2VkLWJ5
OiBDaGFpdGFueWEgS3Vsa2FybmkgPGtjaEBudmlkaWEuY29tPg0KDQotY2sNCg0KDQo=

