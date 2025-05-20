Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEDF1C54E90
	for <linux-nvme@archiver.kernel.org>; Tue, 20 May 2025 19:33:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+MpmVAsp4N+GUSztwZ2dZHpNj2du/DubeT5P897XYsI=; b=Q4H/4Z4qTA+FpI4F/PCLeL8OYZ
	IIdVpp4cY9b1aMYOXIz3GLAAnHgjE3Lp5cGHpTOBiI2OoW6Ih2JgI5epNPfRfyz7nkxhqO9u1u5Ql
	uyC3OGqHSnaTJA1A+00YwoqeTMjBMtU3HofrA5L3JUtEfqrPK51WqFI2xrHvDcgBPbCgwIgt06Pgz
	X+QDnvfp57Pgylg9gYlM8MpFxZVEGtMwcgvDKglysaOsIafnRvOXXdGJRbWqGfFrcqJFrPpFS1T9P
	x/j/VJoOGaaM9u8G/QLnsPBh9u3KbEcewfh3ds7u42vc2VyKpuCnyx+0DBdTmzApvxLtjSmrZfV58
	Q/mnGP1g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uHSi3-0000000DwM3-2fml;
	Tue, 20 May 2025 19:33:07 +0000
Received: from mail-bn7nam10on20613.outbound.protection.outlook.com ([2a01:111:f403:2009::613] helo=NAM10-BN7-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uHSSb-0000000DuMc-18WY
	for linux-nvme@lists.infradead.org;
	Tue, 20 May 2025 19:17:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xK6KbdLZ74TEOxma/sNTs2QOfydw7/7ayjUz2E5P1hG/XP8rynPZjxNvGHtPFamGPRP0ye5b4uB3KXUEzTga1ZM/SgCdLwzw2USGzAecRX3o5XjDXRJAHnFhb4yNFWYEwJeJsQMt1GI9riHzIPAo8PAeP8AQcfqc3dllAsaR1767ceYToWBcSNJ0YTfBmpoWUtpzPDEaNoOetiXemLEV6L+8jGsG+kqhMB0vGDellSccotXYnsQuzP8j8ObwmIbwg33btynh32pyAHh4BOr0SSlcKkpz8DFOmYgq48nxGQHuB51/JQVqmt9mxG0IV6mXqgzQVW6Av5qtQqFWyRBa1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+MpmVAsp4N+GUSztwZ2dZHpNj2du/DubeT5P897XYsI=;
 b=eTOiab3rhEARCc1ug8DIvce12f390vnAcRcUFP8ggXmhhU3pQrPRea2E7QBvZPVfDp9fXd17KnLLpBZyngi5DuAi+Ud4M7GVMjYrAdkqFJOO/8QQcVIC6sR/agNLCsJ9vOfqkLlM4LxhVLATdu6bywmV+4w3ZPyF5dsx9B5tH4AQRgkNG2oPss66FY+ZOfaOgsH/PLLMfidkiyfScS8OEHi2kQDVwLr9wegFvYppU3BznsHyyQRjDkMJqn0agjvQxQRMyp/Tt51vDftbsVVJt2I3EUI4rNJlO+tpkysBBAIZxfeUXuFao6XfXXeNQp7e1+D5jh7Ez+Wx/hFFTzyN0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+MpmVAsp4N+GUSztwZ2dZHpNj2du/DubeT5P897XYsI=;
 b=BHqCbIUrOwm9xxd30EfkhMWu5sdLWCoh0qrpCbnSFYDsMTWolsmyk3HSP8R9E574fbeTgLXnPVnVVyWlp3NTT0LVzbzKbpxKHYK1For4NzeqKOu86BqN4wQIo+xCWYdocCMHsCSXwc9NrrwxIt5PK5lPYNOikWOvJznFP74TwD5AMwi0GbttRW6NpiR0d6lAuhzW+8ryYzcXzFUXAKlM2L+/3DRdplV2CQsp7oPJvQs4A3bd9Une2rax42vM5mcO5c20ChTSv0rk7GqxzdKiiYYAQa64mjfg9A1m3GL9PqXIOuZGQTGEhE33oR7KnqrrJ0AC4E8/TXuSBh/qZqBlJQ==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by MN2PR12MB4342.namprd12.prod.outlook.com (2603:10b6:208:264::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.30; Tue, 20 May
 2025 19:17:03 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b%5]) with mapi id 15.20.8699.024; Tue, 20 May 2025
 19:17:02 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Pavel Begunkov <asml.silence@gmail.com>, Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, Jens
 Axboe <axboe@kernel.dk>
Subject: Re: [PATCH 1/1] nvme: fix implicit bool to flags conversion
Thread-Topic: [PATCH 1/1] nvme: fix implicit bool to flags conversion
Thread-Index: AQHbyZuqqmNwOedKv02hR/ztjCCrIbPb5FAA
Date: Tue, 20 May 2025 19:17:02 +0000
Message-ID: <1e79656e-1e38-47a6-8217-307a8f39a3ba@nvidia.com>
References: <d8ed3f9ae153dfc3e8a2a63ed5abbc5e1f0589fb.1747753887.git.asml.silence@gmail.com>
In-Reply-To: <d8ed3f9ae153dfc3e8a2a63ed5abbc5e1f0589fb.1747753887.git.asml.silence@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|MN2PR12MB4342:EE_
x-ms-office365-filtering-correlation-id: 3720a2f3-a74d-4bfc-3e06-08dd97d2e6d6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|10070799003|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?ZFdvcUhQRTFyNzdYQzFTTnoyVkx6YzlmMzZBUHlhMktoeDg4bnVBbkdSQzVU?=
 =?utf-8?B?R01sbDJFT3RvY01jVTVmS2pwU09VWFhzQzZtQUxjSmp0WFMxQ0VQeVAzVk4r?=
 =?utf-8?B?MUVnTFJEdm9RWWh3MFU0d0pVbHJhWG5MTGs2ZDZWQmV6ejZTVHBjMG1uMERN?=
 =?utf-8?B?UEdzRHA1cXVOZXhVYUU4bXMrK1BwRVRUT2V4Q2RlRzd6dXBwK1VwU3B3SnRE?=
 =?utf-8?B?WHJDNURQUVdjaVdtTVhyZ2hVNXcrMWZDelM1VHp5ZFB3U3FTb2d6SnIyaElY?=
 =?utf-8?B?TENzY3RUV2QyNUVxZjdYM1RaMmRsQzhzYk5lMXc2NHV0TnlHRkx2YkZZQ2dG?=
 =?utf-8?B?emJrT2F0L2wwbytTblVjcURpZzFpZjZDNXJRMEdldVNGWUt2YzkvYUJ5bkZi?=
 =?utf-8?B?bGs1Z0Z0SWR6bGtKM3ZGU3oxNUpXN3owMGZWMXowZDlJNk81aU9pYjRCazdG?=
 =?utf-8?B?U0RZVXc3SHpRZXl4MzlSOFU1UDMyazY0NllkSndjemJCcjViWEhJSndRV0FI?=
 =?utf-8?B?V1NVSUk4MXJTSTQzMzg4ZUVmL0tvKzE0M2xJZk9KR1psalNiQWdTNGZkbjhJ?=
 =?utf-8?B?cVYvZjlzdDNjVWVHM3RlWHpCSnVQcUY1SzZ3RlpKOEtjbmxHYStHYU9Nbko0?=
 =?utf-8?B?aHI2cG9qMjFrcEM0VlA3YTBhNm9XaGVXakIvbXVQWGF0MU5GUm5MTnR2U0tn?=
 =?utf-8?B?Q0p0V0pUVEQ1aWRJakJjWFpnL3JFRVg1WWFhZVlIWTY1YXRlUXZpOUlaWTVl?=
 =?utf-8?B?d3h3d29xTFZMOSt0MUg0c0oxZFJLb2o0SWpxalJmTk5IZEVJMGc2WXZ5dW9Y?=
 =?utf-8?B?Wlhjb2x5d0hockdwWVJWQTdmVzJ5U0Jrd2UrVWlDSGpBc0huOUFIUHBLTlF1?=
 =?utf-8?B?c2NHaHlmRStpR3pTWlF3UzZ6S0ZiZkNvTkZYVWhEQWlKY3V4U2FUdmVYelF2?=
 =?utf-8?B?V20yQVRkLysyTm8vQzU2MFpjbFp0aWhlMzNLK0tpTWVkeFNkQjZYOVc0dHgx?=
 =?utf-8?B?NzNyRVdFM0c1OWlyMGVLODFJdktCODVVeHd6MExhWnN1Y0RzSkZpVmlqbEd0?=
 =?utf-8?B?OXFaOFp5cXlMU20rUWFQbFBydVFXNzh0cTdsQUZvaFUzTjI4K0tZS1lKNXdp?=
 =?utf-8?B?TmlaVWRBVHM3cVJUakJTT3NIQzNWSm5YazY4WXR0dFdLTmdSSm1CZWxuS1gx?=
 =?utf-8?B?ME8rOEM1SmVzVmF6WjVLVTB2bEY3TU9VREdmUXUzbC9wS2RZbFhTd05RMDlW?=
 =?utf-8?B?V0RXUnovcTZPNVVRQ0pjVmEralJySlhOUWtxbnQ2UkYvYVIyMzBmU3J0dktt?=
 =?utf-8?B?N3pSeFNZaUwzenlWNnlyYVg1cXBXcVJEaFV2VlpvRnlGWUo0ZGtPNmQyNXNX?=
 =?utf-8?B?b1dLMUlBYWRQZFlQYkdBbFhpcFA0a0lrL1ppTEU3M3B1VnQrOUt1cmp1djRY?=
 =?utf-8?B?UUVQK2tnZEhrdmdVQmJpQnE1YnRKZEZBS2hlTHlNMHJvTG9MblVVMkg1M09F?=
 =?utf-8?B?MUljVU1WWnFkSHF4L3BMK0xyOFBodjlyTjBtM21WU1VtYnd1K29HMXdJcFRm?=
 =?utf-8?B?SGoydTFHUkhDdytIL0p2STFUb0dLR2J5UHMwOWtMdGV5MDZFMTBXZXcyUDFz?=
 =?utf-8?B?eW1CN3BTMGpxdTh5NWlJNXRsTEY4WjErN1ByVnVtQ05Ja3ZRYnFHcTM0WUpw?=
 =?utf-8?B?ZHc1WG9VNC9JV2FxQVVObXFWQ3k3ODF0azl3SDR2Z1RIOE1kNFJZYnBYdkda?=
 =?utf-8?B?S0RvVEZuNUJzcTBVMzRrUmxaTHNpeHZOMjRKb3lVOVFKWmE5RDJBRW1vOW9S?=
 =?utf-8?B?Z1pWYzUxdHJ0Rk5hNHBnVjJzem9ZaWVYSXNLdWlhTFNyWjVvTlEvWXI1Rzh4?=
 =?utf-8?B?dDZSOUpuWWcxaSsyR3c0WlR4UXhobkFvL2V1dVp0NGJxNEptVlA2Q28vcFpR?=
 =?utf-8?B?eUxKbGdYS20yYm01aHE1ZkwwSkFnVlN6Y0o2MyttdHZCUGVkMXFBL002ankv?=
 =?utf-8?B?YVJBOEhxamJnPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cTVQYVBaeHZWcEFDMjd5cmZ0WUNaUnBETUNGeWwxVUd6Mk5zRnpYejZQb1NX?=
 =?utf-8?B?ZXlCaTVQZlp6a05Ieml1WUtxYytvcDFyeWZZZzlEMVB4TnZwTUlVeC9ManNz?=
 =?utf-8?B?OXhQSis1bVplTXJ0cXIvL3hWNTVNbjE2eTV0NFU2SjZ1SnkrYUNXMk9tckRl?=
 =?utf-8?B?Qm13RFZFeG9YZlZkNzE2aVJuNC9IeEhJQXk2ZXZtTllobjhzK3FyTTFRbi91?=
 =?utf-8?B?bERzNUduSVdGMTlxclBmWEJGUVQ1YkVhMnMwWVQvZTJmNTkvODBtSXJMUHN4?=
 =?utf-8?B?MHM3MUU5OVV3SW9aLzYvMDVxdWFBaXBFQlJmY3ZxcUFybzVxbEFBU3VWNVoy?=
 =?utf-8?B?cDA1T0trY2YvRTNzZEdLYjJxSkVxTjlBUElaTC9CTCtqVm5NWEpYMUJaRTJy?=
 =?utf-8?B?MGI5amVxOVF2T3crYWRzV1R4YktpQVZrVFg1Z01YRUYrd0ZHNFl0Vm5OMEU2?=
 =?utf-8?B?WFhFMDRJMnhSK1ZjTXZZK05sNVlHcHB4TmNnUHhLc0NZYnF0NVo1VThEcFA3?=
 =?utf-8?B?OCsxWGduTHBKU1VIVFB6WXNPUzAwTlRqc3B5cGN6Z0Z1bmV6TjdEQ095SWN6?=
 =?utf-8?B?czBLWUExcFN6eXVCYnlxejRQSUpHY3hVb1ExRnh3QkJXamw4SitVbTFmdXY2?=
 =?utf-8?B?N3ZuNVNKcDF6U2lJRmk5UmVJUjNVQXZOeWdqTzVFbHdaOW1KMkpiV1NkSnlF?=
 =?utf-8?B?UzJlNHpqWmp4Sko4QzlraFRsZWNpMTgwSUNlemNMRTdFM3BjVnY3djdBaGRH?=
 =?utf-8?B?UjZLMnozMjI1WEkzTG9ieHhWd0pHZWx3Y3RpZnJvT2d0VTF6aXBVQ2JYWDhn?=
 =?utf-8?B?c3IyaFhONkpnZ3hxZFlvTi9NaG5XSDRCdmxvYSsvNVcwU1N1b05jK1dERHp4?=
 =?utf-8?B?NEp4STdaY1FrKzZZclAzcjA5dWtwbnl5OFR5MGZmOHM3RXVjWUMzQy9zd2dN?=
 =?utf-8?B?enlKdkFERUFMNU5FTmhhV3RVU2IwMFp5NDl6NWRORHF1Tm04S0JKQitBdEN2?=
 =?utf-8?B?WEx5NzlJZ0h3WDBzNFMweW4rcWlBWUVacG9wb3JWTG92ZjlkZy9QWlVXNUlG?=
 =?utf-8?B?eS9XMTcrKzVld3RBK3NzSy84N2huRjJtY1pmamcvR2FIVmNiK2NNQUtBV3By?=
 =?utf-8?B?aEZUNVk4NG93c3AwM3BMTjlkZkxvcklKOGxWejhRemk1VUVad21JWEt5cHBk?=
 =?utf-8?B?cktQWEhxbjhtbVNmdUZkUDZsTUpzSjZNc3U3YXQwU0ZPS1kxVGFZdXNZeUlx?=
 =?utf-8?B?SGliNDRnMmo2cWY0c3c3bUNmaDJLbnU1V2U3NzJZcXVsV0dZWmpab0ZIcmlx?=
 =?utf-8?B?cDdqaFF2SXBIN1JQNklrUDVhWVU5SkVPNTNpeVdYT01mWk5xM0I3Ni9mSVg4?=
 =?utf-8?B?ZGRzQVhQdmFrYVAycWJFai9rV0JvTmRWVXRuQ2hyd1JPWjh0NlVPUm5NN1Jq?=
 =?utf-8?B?NWpoWmpodzJyWFEwQ3BSemhwN3pqK29EZHlSNitQZVRleEgzL1p1Wmo1YjFW?=
 =?utf-8?B?RmtnMTdQampxbGk5UGFFT2lCRVc5aHo2dGwrbEthUFJWM0VhN1J4WmZFWGNn?=
 =?utf-8?B?RngzVnJ2VVRaaVZrRHB6clJxSUJpakNaNlVpZHRsUHllRmUxQTljTnBjbHpZ?=
 =?utf-8?B?WHFRKzk0ZmE4YnFIV09Jd2VNZEVtMU1sOEhFNGFkeWdzL3JkN0hCcStmcDZw?=
 =?utf-8?B?dE45R05UUEpQbmhmTVRDT1BGbEFyM2J6YmY3blBVeWR0RGVkZldPempoUjVC?=
 =?utf-8?B?alh0NDZOTVBZUy8rVzhjbS9vYlVkeVgzdmgzK2t3UlRCTGFDWXI5V2hTUEd6?=
 =?utf-8?B?UnRudHF4VnJCbjB6UklEQkVJRWIvWHN2cjQxanF6ckI5MWVwZ2EzN1NSNVNB?=
 =?utf-8?B?ZFRCRWtzUkxWWXVTNUcrenI5NG9Ha3lnL3hqbmNLWTZmbDFNVTYwWmJNK3Zt?=
 =?utf-8?B?bmc5SEdQZzJzZ1JKYUIwbkJGdXpyR01RcG0zR3l2WVRnSUtkaGJUeFlwY3BR?=
 =?utf-8?B?cHhGZGJLdjQ5RlM1QW9oQWFlL1diMEFMNk5QclYyQkduOHJ3VWJYQmpLNmNU?=
 =?utf-8?B?eHY3azhaVkJWZW5QdmJJcUkvVm9XdUUxVC90ZGRVN3lSSFRlVjBEVGJzR2k3?=
 =?utf-8?B?eGJpRmEvN0kvUWs5TkFVZ2FzOGZZSE5jdGZpcC9HUEd6WENYc0hlV0FKZnRU?=
 =?utf-8?Q?xuWBmUMt6It1E/zkFEIsjUkVEkaIDv11FvwimSh9DIYV?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <16BD0CF5332A5240BF3A3E58F3961AA6@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9404.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3720a2f3-a74d-4bfc-3e06-08dd97d2e6d6
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 May 2025 19:17:02.7821
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: P0lcMfD5Txl+zlLAJm0+lEKp336su6gO80onMq/eGKgCJGAKRdUOv3mgq5JXjFgjRF/qtaHpsnevvG9mRMdZ2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4342
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250520_121709_325940_3CA02E12 
X-CRM114-Status: UNSURE (   9.87  )
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

T24gNS8yMC8yNSAwODoxNCwgUGF2ZWwgQmVndW5rb3Ygd3JvdGU6DQo+IG52bWVfbWFwX3VzZXJf
cmVxdWVzdCgpIHRha2VzIGZsYWdzIGFzIHRoZSBsYXN0IGFyZ3VtZW50LCBidXQNCj4gbnZtZV91
cmluZ19jbWRfaW8oKSBzaG92ZXMgYSBib29sICJ2ZWMiIGludG8gaXQuIEl0IGJlaGF2ZXMgYXMN
Cj4gZXhwZWN0ZWQgYmVjYXVzZSBib29sIGlzIGNvbnZlcnRlZCB0byAwLzEgYW5kIE5WTUVfSU9D
VExfVkVDIGlzDQo+IGRlZmluZWQgYXMgMSwgYnV0IGl0J3MgYmV0dGVyIHRvIHBhc3MgZmxhZ3Mg
ZXhwbGljaXRseS4NCj4NCj4gRml4ZXM6IDdiN2ZkYjhlMmRiYzEgKCJudm1lOiByZXBsYWNlIHRo
ZSAiYm9vbCB2ZWMiIGFyZ3VtZW50cyB3aXRoIGZsYWdzIGluIHRoZSBpb2N0bCBwYXRoIikNCj4g
U2lnbmVkLW9mZi1ieTogUGF2ZWwgQmVndW5rb3Y8YXNtbC5zaWxlbmNlQGdtYWlsLmNvbT4NCg0K
TG9va3MgZ29vZC4NCg0KUmV2aWV3ZWQtYnk6IENoYWl0YW55YSBLdWxrYXJuaSA8a2NoQG52aWRp
YS5jb20+DQoNCi1jaw0KDQoNCg==

