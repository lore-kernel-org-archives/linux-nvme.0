Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 512FDCA0EF8
	for <linux-nvme@archiver.kernel.org>; Wed, 20 Aug 2025 20:51:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2syP05+MEc93LbllRwuo7uFszE6kriGd0u2Bw/vhhnI=; b=ExtYLOB2B/puPkBe70DtvfnhoN
	TvpZW/F0+pAi5k1NZtPjcKzW4En6rpil9lfLZOseRNnT0BHbEm4JuQF48ZEZYs8HPvkanSGTeKOk/
	yTj1by36ucNvQcoVnRZjtayWNj3UtFPulTGPApyscG5DBRxdLHQIssbSvzL6Yca0ObrOKAhYtT4Iy
	+goD/0/beOJ1F2VBIiCITPIZU0VkMh8leDVyBT1GnqwKve50IqcO7hHg6QxetCe+mVSZySZLnU9NB
	1lxwAiE7oAg+RuXamL2dtbUIm3H/xR96Jh5oeaco7g1jWDUqzvohEKrgTwhUssOAgZLwoYiVzIUWM
	pAC601nA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uopmL-0000000EuSz-0QWn;
	Wed, 20 Aug 2025 20:51:29 +0000
Received: from mail-bn7nam10on2062c.outbound.protection.outlook.com ([2a01:111:f403:2009::62c] helo=NAM10-BN7-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uom51-0000000ESHs-0Tv7
	for linux-nvme@lists.infradead.org;
	Wed, 20 Aug 2025 16:54:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mmX9mwz0cm211iFPtroO86MV9KlWpsxJEDhZCHnTm/290GUnS8BnRXX5JXYNqxBRcTVt670Hz1QC/5SCMHGCzdyPZGvLRaMqdq51Ze7yZZMJL5+9rU+SYeWeWNxIJ+bz9JT6D6k5axEl/VZOnVOkfkzqKcurD/rzQpxNkLE+Ea+clx3wA3vojN2JKDKGA3wzbuTgaUuCgr0Lw/UGN8dvoPqPCr22OqnznWxmyDBmMpfgsxdExk5bH4w9cBFWvjwPolM1iVQut429/LtrkxzSIGm8KOKEooifwpufVUE570syQYrXLWRRH4rp0Iw0l6Ea4Xp2iz6fksRokv30R7nWYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2syP05+MEc93LbllRwuo7uFszE6kriGd0u2Bw/vhhnI=;
 b=y+zLDr89/V/MrEAI50JAciWqiTNPYsengeGaLLPzVwN/sgDW2OD4GiqVILd5tnnrq8owANY0MiaYQ0B6d+IkWNVYpDyziotFLCohndQ/r1MVRpMjkIrw2Md8mOx1XWHr2bDxLVDYVS7LhcwCPLzkLjoSm9re7SruArgCs5xcLuKG0yrD975Czd5bES7EPeKqfuBEwfNQWIv19Otpy/Qd55i6NQCAiLYpT37gWlPip7iAwf5736ZP90T6aD9QMmJ7Lw/IEqii1lvgcqCbyMsh6sdCQI3B3oljU71iOFfN1inEOvfOHkLaaNlklYQEEkUhijrSODG1MwuBtVo1kAgiPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2syP05+MEc93LbllRwuo7uFszE6kriGd0u2Bw/vhhnI=;
 b=jdkVFUYOLWOojGRjPVlZHkmwkLtyjV+Q/k8+xCzdn/Il1agu7fFd3lrZ68rI9WKAvWpgCzWLs77jjS7Buk8D3JaDVtmDPDgHgjw0J5eNieEi1P93Ocw1hezPuLPby2oNRPpnGLWq9lsVs+SXO9U+gD612KDpQPwWUQxojUW8zZGFS2NEefPx+tJJaE6fvR6CtbQc6sFwsKt8+p4dXn/dAoOwFiDsToyblMiQpdcSuDovFB3DVNXDsjJHsrXa6hKAEB+0T+d2lHvPKDKbTz8YFbL8o2yY4nMUVsMCHcX5/H95cxcy84N7uMMh63Wdpz3s/Ln5R+zjM1EMbZy5ZDnl6g==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by SJ0PR12MB6759.namprd12.prod.outlook.com (2603:10b6:a03:44b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Wed, 20 Aug
 2025 16:54:25 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b%6]) with mapi id 15.20.9052.013; Wed, 20 Aug 2025
 16:54:25 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
CC: "yi.zhang@redhat.com" <yi.zhang@redhat.com>
Subject: Re: blktests: _nvme_connect_subsys() improvement for RT kernel
Thread-Topic: blktests: _nvme_connect_subsys() improvement for RT kernel
Thread-Index: AQHcEZpOAzO+lJa4dU2O04pWSc4PbLRrwvaA
Date: Wed, 20 Aug 2025 16:54:25 +0000
Message-ID: <85ddc96b-c9ee-4dea-b10c-ca44984442f9@nvidia.com>
References: <la7o2yjqljxt67an6kyo4qj76mwedxt7f7az24s52cb63obgfk@xcxhybk46qud>
In-Reply-To: <la7o2yjqljxt67an6kyo4qj76mwedxt7f7az24s52cb63obgfk@xcxhybk46qud>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|SJ0PR12MB6759:EE_
x-ms-office365-filtering-correlation-id: e8b8fed6-a812-4000-37f0-08dde00a3853
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|10070799003|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?dHRtenViRnRGSnVMQWZoMU5HYnNJN1F5b3BNcGNndmZJMjZYNG1rV0RtVG5h?=
 =?utf-8?B?b0JyOUtqZkw1ekl6SUgxUGVJVHdSaEVvR2F3SDhac0I5SFlQb1FNNkxtWWRs?=
 =?utf-8?B?ZnhqcThUWE1mcDNrcVlpYUJKSlNCZ1FKbTR4RzlwMFgvZmRhOEM5VXpZRjIz?=
 =?utf-8?B?UTZjL2o1M2NIMTcxR3ZiVUFBOVJKRHl5ZTNQU1JFVGdxRUNaa0xhQjhRQnNL?=
 =?utf-8?B?aXJzNSs5NWJ4NWFXQWUyRGZNOGoxeU9HZElSVkY5Y2pxMEJxQ21xMFg3TnR2?=
 =?utf-8?B?QlNERk8waFY1S0tDQTFhQ0hZYTkzdWU5Vjl3LzVOUWJZYVU2dFBINWRKMDR1?=
 =?utf-8?B?Q1JXaUtkNE83NU1LU2xrQWtSWVVsSk1mRVBzZnpKaGZoaEMvMmJoZXFtL2Rm?=
 =?utf-8?B?WXo3MTVWMkJEdWhLUEhoNEZmS01uSXBqb1J4K3lDUk0wTWJ0UUFCNjJKMVhj?=
 =?utf-8?B?bjhlYXVyQU5icnJycnp2aUNGdDBnZEV3eE1XT3dXQzA3Z1piOSsrL0p1Z1hr?=
 =?utf-8?B?TjBSclpTMHNnREVtOVpNRjJrcEEvTDJNZlJNRDk3bGNEN1dNZkxWRGlJbE1T?=
 =?utf-8?B?UWZuU0U1RUY1SkVxNHhISnY4VzJHOWNZRnBZQU9iMkNIaU1xUVBwSHU0TUVT?=
 =?utf-8?B?ZGxSUUJZdGNUTVZNcmtncVRzbmNIV2NTRGdJazJERkVkdzRBMzNhb2wrU1ZD?=
 =?utf-8?B?SldvTnJXcjRaZ2VadVFyTWFmNTZDakdaSWVzdC92KzhJcThhTkdrUzEvVDkx?=
 =?utf-8?B?azVCY05qVXkvNHFrUjVuaDNxak15MXZoNllTcEE5TkFoR0xBWGZQbHo2dU9t?=
 =?utf-8?B?RE9rNUFIbG9HTk9CZVVBVHE0aldxV0VyMmJqdjZ2Yks4THM5TzBnSmpqa1Fq?=
 =?utf-8?B?ZlpHWmZtdkZqTjlvL0tYWCtLdnVMQ0ZpZWJ1WXhHQ1FNM2xWaU8xa0w4R1lG?=
 =?utf-8?B?VDc4VlBoQlhwZ2FYVjFIZk1PZUxoTDNKUlRHbEYzeFR0em1tVUh3VUtaYWhN?=
 =?utf-8?B?QzhOYWZVMFMvcmlQYXBMaUVsNkVQaDNIVFVaVHB0OGV6M0tGY1RRcC9qdU5j?=
 =?utf-8?B?UkE3bFlId0VzTnJobFhRNGdKY2tyamhsMWhMNFlUUWdlSnNhT3BoY096Lzhk?=
 =?utf-8?B?cXpWVzV1d3RPamxVTzZ2d3dnUVh2ZzhsejI0QVpWV1ZBNWFPU1Rsa0dGMitU?=
 =?utf-8?B?VnQrNldiOE9kR0NuN0QrazhqZ29weGd5aXZIRVF3U1N3eTFITEsxNmtDZFRR?=
 =?utf-8?B?Mis3bXpTeml5ZGJ0eUtMcE5Hakp6MnRpeVFxMEpJSTdlYmNFa0pUK3NOemNv?=
 =?utf-8?B?RVdzeGFaWnBwdWIwbWYxaGJ2R0lYakQwQnp0OTJid2NZOUVLT3N5ZG9BYTZP?=
 =?utf-8?B?Tm1SVnE0cjBLM0EyaTlRR1Q0bng5U0ViTWM5VGFJUm1GVXdFbFYxb2Q2ZUJ4?=
 =?utf-8?B?dmdTZWE0dVppbFNxbzRkNXdLZTFiSmVGNU9ieVUzd2l6Y1lsQkdpcGJ4aWYx?=
 =?utf-8?B?UXdsd3VKL2duc3AzY0VVZ0hlVXdJQksxK2dGT0xWeVRTM2w3bHoxY0huMmw2?=
 =?utf-8?B?STBGdWN1NGdad3dCZ1A5K054blRvMVBjalRINHd1UHpVSE9mdGhDVDZXV2hG?=
 =?utf-8?B?Mi9XeVY2dno5RWpYRXBnM1ZtOXpsNWJ6clZjeXhhWEhnaDJ4REhaMy85Njkr?=
 =?utf-8?B?ejdCeEJZb2RnbFlPR2tWdGFsWHhFNVQ2ZjZ2T0lzbUxCbXFVZllrWXdiclR4?=
 =?utf-8?B?UEhqTlVDUW4xWWhTWU1hOTFnUCs5eHdkOG9Rb1V0czBtTndkQ1hSZ29rcS9P?=
 =?utf-8?B?TE80cEM3SjNkYi9sSWdRZTllYXlMSEx3bHBkT3dxWkRJSVNLU2VBc1BhMGpp?=
 =?utf-8?B?L0dDblp4eCtzVEw5SXpsdnh6WHNEZ25Wa1FON01TQjltU2xvL2ozdGg0VCtr?=
 =?utf-8?B?Y2d4NXhUcFdjcnVsOFhTZUdaVk1OVFR4OGJENUk0RWllZ2pzRjUzaU1vT1l3?=
 =?utf-8?Q?CCkTsqYbetWBrhmjigvfLmkSU1XYfE=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(10070799003)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NllKYTN6eTJsMlBQS0Y0SFhZTEg4alE0VVFKZWdUWlB2WXJJZ25zWHZvNzMz?=
 =?utf-8?B?TVZDU0FHbnExc1I2d1NtNGgzN3V2SkYrK3NtMWZvZjY3WVpUWk1WNy9yYU1T?=
 =?utf-8?B?aENnbnZSN2c1UENpTFRJUEkwK1NZOVlMQ2JVaHR2cVJnaTZHaUNyMUVNS2ZP?=
 =?utf-8?B?UVFyNjNLL3BpR0xrRXhDWWYrVnFjRVJUNXB0RkI1MFBrVjdlRi9zWVNqWTNO?=
 =?utf-8?B?N3FidzQzNTJyNU5BT3BLNlVXR0k4S3NRWmcrUCtyaWUwVkxuVUsvVXF3QXBS?=
 =?utf-8?B?MEhneWYrVWYyV29GazY1R2lsK1Bnelp2SjkwSmIyYXVrVlBaRVU5NGJES1pt?=
 =?utf-8?B?VWpqaWl5N3R1OXF1M20zMkxrekcxSXNPbzdBczVrY2FaajgzSTIrL2JXcUNr?=
 =?utf-8?B?alg3ZWlxR2dadVRFeitNaFU3emJwQ3VKdlJDYlVmWjNIMnU0dUFNTHFrNVFH?=
 =?utf-8?B?UkNEbnZaRmlabjIwa1U1VW5yOVV5bU1Zd0dqdkxDRmZJWG1QNk43MCtKc0dK?=
 =?utf-8?B?VitTTTA5d3lvckFMUnJJT2ZLRU9aR2lML3F3NVREbGFmQzUrL1A2VkFqbkNR?=
 =?utf-8?B?cG9uM3lDNnlldHZWM0VBT0NwMFVxa2t4Y3RZcXJFUXpWT3JPWnJ6WUhsUUI5?=
 =?utf-8?B?R1FET2dDdG5ZZVFTTlVDeGs2dnlzQkFjS2J5SWpNdFZOV3RpL3dEK2F3UGU4?=
 =?utf-8?B?a2FuemFCZnhnUTMvN2NzZlVON01hYmdzbVNXQkszQjE0VGZ3Qm5rT3RQR0Fk?=
 =?utf-8?B?N2UxeVp4anAvRzM3TjlDTVdvOThPTzQ5N0VyYmFkU0lFdkp0NGI5REtPcnUx?=
 =?utf-8?B?by9laDkweXl4TERpcFBKNk9mc0lCR0ZML2ZwdGpmcXF6TU52ZTh3YndweFJY?=
 =?utf-8?B?bDIwRlA0VGp4Uit5bjJWaDFUVWtacC9JY2VuOVlHWjJUK2Q5WkJZbHZoYTY1?=
 =?utf-8?B?cHlRY1prV1BVUDVMRlNPVVFqK20zUm5nNFFuTHhPZXUwVXd0UGtrTkNGSXRW?=
 =?utf-8?B?bHVEbUtEM0dIcnRaMFRmTm1GMTRIS2FwQkpxNTB3U084TzRkR2lVQndvN2F0?=
 =?utf-8?B?c2kyV3hyT3lJa3BySmR2ejl1WllWaFg1TC9lU0VTWnNWYzNYTktIWTJMVGNx?=
 =?utf-8?B?c2VQVjF0Q0ZvTkNIWUZmMTJ0ZEozYlJ2cEdicmE4YkdPVU52MVBBUGR0OXVR?=
 =?utf-8?B?ajZ2SFZILzUwcW9JcVBJYVVPcEs0Q1A2elRRQXJMUFpzQUx1OHFzZmtEeTRV?=
 =?utf-8?B?RVVHbWNBdjNOMmZGd3UrYW5GVzM0OEZmR0plUEY4ZDRNOE9MMWYva0JTb0lE?=
 =?utf-8?B?RFJ3YTl4dG1qSzJwbHkxOTU0VnhWVGYyQjB6akZ4Z25EZUJ4Y2xtSFFiTnhT?=
 =?utf-8?B?eHJkWklwNEhMckYxUXowTEZ4QmxhNUpNVnN1aUpxNCtoTzM5WmlDNFZoaTlL?=
 =?utf-8?B?Qlc3QnAxRnZtZjBNSkhld0JCcWtpVFQ0MzFyeFVpNnRJWWpZcHBjeGM0VHVr?=
 =?utf-8?B?VzEwSGF5RDNDNnhaRGVCMi9neVAxR3pXWmF4MFoyRy9kYmhUSkdZVXIxWkdH?=
 =?utf-8?B?SUpnaTRWWlUrYXNHK0dKdVlFaTJ1WEtYWW5WcFBUVDJlNmNacmNVTWtFNE4y?=
 =?utf-8?B?bmdhZXZyZHE3Mm9qeUR0VENHMEtRSlVVb2hhbHIzTE52MkFIVnVRYnl4bFk4?=
 =?utf-8?B?QndsdDBBaWtmd2pLdW93Zk9iYldXTGNZM2xYMzVDT1k0TUJST3JnbkpnUHZZ?=
 =?utf-8?B?MmpUVEMySktueDBnTjhNV3pMWEd1SG91MXZvTWRVUVQvZ0xYVkhwekpQOWow?=
 =?utf-8?B?d0V0NzJKOEE4Y1RGYVB6MlRqbklyNkZ1c2hJZzdQTzVkQnZWUklNNFo1YlJO?=
 =?utf-8?B?TmM4L3RxY0xJTlk3dGxNRlRaZ253SzYzSTd0eGE1a3ErUjBMUXUwZDR1R3Rm?=
 =?utf-8?B?WVJLaE9CTkptaThKcCtBUzY5azhFL3RwMzhKNlg2aW03MHo3cmxteHVoUGJE?=
 =?utf-8?B?cm1WU1JKNHhocWIxUXZJQ3daWGE0NzFBYlh5ZzYwQk5ZTkdNYTRrMmZ3ZVpp?=
 =?utf-8?B?TDhnVG1nWUJEaGcrL21NOWJReHBNcUFXbUFtdlFnYWQ5UGJWU3pLUXh6UjQx?=
 =?utf-8?B?ZmtEbFlRaitpS3Q2ZERZcE9VNWhBekVaalBUUFpoNmQvSjNyRC9RNUFFL3d1?=
 =?utf-8?Q?Ho1jEyJfjdVUVvD0o7uDPA9PllQFQSZUtWxDhMXUayC/?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <913204B3C3A5644B815790E299FAE93C@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9404.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8b8fed6-a812-4000-37f0-08dde00a3853
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Aug 2025 16:54:25.5267
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZedaJY6mKVuahVW4bPteihlpszTooy4Bg9Qz+g8CypZ5+KN1eV6FeFLH2p/8oA7OEQNFHHgVEUX1gzrOlD88kg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6759
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250820_095431_352192_61FCE45F 
X-CRM114-Status: UNSURE (   8.69  )
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

T24gOC8xOS8yNSAyMzoxOCwgU2hpbmljaGlybyBLYXdhc2FraSB3cm90ZToNCj4gRllJLCBZaSBa
aGFuZyByYW4gYmxrdGVzdHMgb24gUlQga2VybmVsIGFuZCBvYnNlcnZlZCB0aGF0IHNldmVyYWwg
dGVzdCBjYXNlcyBpbg0KPiBudm1lIGdyb3VwIGZhaWxlZC4gVG8gYXZvaWQgdGhlIGZhaWx1cmVz
LCBZaSB3b3JrZWQgb24gdGhlIGJsa3Rlc3RzIHNjcmlwdA0KPiBpbXByb3ZlbWVudCB3aGljaCBt
b2RpZmllZCBfbnZtZV9jb25uZWN0X3N1YnN5cygpIGFuZCBzb21lIG9mIG52bWUgdGVzdCBjYXNl
cy4NCj4gSW4gY2FzZSB5b3UgYXJlIGludGVyZXN0ZWQgaW4gdGhlIHdvcmssIHBsZWFzZSB0YWtl
IGEgbG9vayBpbiB0aGUgR2l0SHViIFBSIFsxXS4NCj4NCj4gWzFdIGh0dHBzOi8vZ2l0aHViLmNv
bS9saW51eC1ibGt0ZXN0cy9ibGt0ZXN0cy9wdWxsLzE5NA0KDQp3b3csIFlpIGNhbiB5b3UgcGxl
YXNlIHBvc3QgdGhlIHBhdGNoZXMgaGVyZSBzbyBldmVyeW9uZSBjYW4gdGFrZSBhIGxvb2sgPw0K
DQotY2sNCg0KDQo=

