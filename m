Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6D0ACCFA03
	for <linux-nvme@archiver.kernel.org>; Mon,  3 Nov 2025 19:46:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Q9Rr1TrouViK6x5rHUCZJpLrf3KVfg8M2ozebSE21Pc=; b=U6QPgcovEr4QXT8HqTCXpDG20g
	ncSLlNGx4ljDwEGvoaa0mt3FtSlm3Quyh07gJJgjl+fYpPef2B7REoCyTxnnzu588tiWfHcA/SiRC
	s+XxbG95fZy+KIrwj0kqBdTYFSsglhbsLOVd/MoI1hkHVjRaub1Ye7qtpYDSfrpmhAVPPw9YwdRiU
	m/0ur1UFCLmaXVfXgF6DLAty9M3+Sss0iugeKNTOhvT1se/eKVAgYtX5E5idSTT1FHXyaeHgrSxg7
	4Wvc0NpXvVnJArN4flpcYrH4kpbz9fY/qc1DXPsybZUh2pWCL9v2gl7Hp17GdjM4TdTB03Q0dMEvG
	SUVJPVDA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vG0VL-0000000AYnt-41uH;
	Mon, 03 Nov 2025 19:46:15 +0000
Received: from mail-westusazon11010038.outbound.protection.outlook.com ([52.101.85.38] helo=BYAPR05CU005.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vG0VI-0000000AYn3-3l4W
	for linux-nvme@lists.infradead.org;
	Mon, 03 Nov 2025 19:46:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ufu6OmncUcviB8ixRMLZ4y9/qApvL9yCRS5g1Hhj2dVbdNkR0p5zlr7Ock/fpErukeTPPdbX2Z6nlXCHzMNAhhfQAqBgUZ++V502W3GfO+rIL3QyPdhWP85eOVXhNY5bzlOHYBbW0grthUQgZ738FovUQ1kY/n5lpJhrMD0yKiEOp7KduZ6KWIuky4rbf2wayrnjdxXSyu+Ibb7aMfcMj8JXSnVvZ1hiV2Tf9MNtDKGY5NYPST2eDUiHUm8XSMeY9Ir8tjXSvb/kXNbtwC6qGxOOo2Lmz8fdYOxDgSc8q2/mBocV2cnKw+2QmEN76gMHGGJSPzBLc094hgLrtkgNQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q9Rr1TrouViK6x5rHUCZJpLrf3KVfg8M2ozebSE21Pc=;
 b=GAXXVL4fQsw7ZUg4VTpJi9BKQ3LMgD+6T1DwEueNBu3BQr8+wcYfDpwdYF50OrE+v4WoWf/NtpmriuSg8ebdcHEj8rSJb+Zc4LjPMK1ceysPG48uOy/gSYqGB5WTeCoPvZuS4tVXZM1/qL1SBzJZaSOaEwd1MCHCIAC8gKNRippaMy7/EybjW8I9K16QwKzUyXHuVRTS1f43GyCJK5eTYZ3uzzVPdLKhbdjql8jD5wB3v/Goqre+JXk8Htox/87/S9mysIfqubzk8k2UWzc08Z7NfgmN1h3AB0t5xSTAwC9Dw5QsLbrgXW7rJzgujn38mGCh9IlPu+UTD0TM7802Tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q9Rr1TrouViK6x5rHUCZJpLrf3KVfg8M2ozebSE21Pc=;
 b=ch4bNOVsWdv82qHju7jQbtXn35qIdxxNZ2JKKWdfFcvzTSOUmVAV7gq9WD22fuCwZsiJMtvw6cJznx9D7n6gDgPjvg0IArgSR6wLztN3eOpCVDWtBJQuDvabJ/sM88uhxRAMqe0ZEPxVswOv+j6LnHi0i4spZ6QG2bV5zlwQG6v7ZgfBUfyMCQk4K0xnrsOdonl8zpw2vBGgG2Ci5KT7H0NstLSnBCKQGoN8yvFKa6ypi6aZkbNQLPwH3WZfW1k2LIZkrk28Il/fHDbPb6QTnTl+L7rzFWkf4yxIws1ymdA+wdBDuH9jWf42vrCirO6wJEzv+HyhBMoIv3kksORtzQ==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by CY8PR12MB7683.namprd12.prod.outlook.com (2603:10b6:930:86::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Mon, 3 Nov
 2025 19:46:07 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b%5]) with mapi id 15.20.9275.015; Mon, 3 Nov 2025
 19:46:07 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>
CC: Chaitanya Kulkarni <ckulkarnilinux@gmail.com>, "hare@suse.de"
	<hare@suse.de>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>
Subject: Re: [PATCH] nvme-auth: use IS_REACHABLE for nvme_auth_extract_key()
 declaration
Thread-Topic: [PATCH] nvme-auth: use IS_REACHABLE for nvme_auth_extract_key()
 declaration
Thread-Index: AQHcS6dOT3rhmsQbb0GfUm6eWoYK8LTg16OAgAA0sQCAAFFbgA==
Date: Mon, 3 Nov 2025 19:46:07 +0000
Message-ID: <3bfea609-ad1b-422a-b070-9e9604777a8b@nvidia.com>
References: <20251102031742.69984-1-ckulkarnilinux@gmail.com>
 <20251103114621.GB15280@lst.de> <aQjCQKiN5mzw2oY3@kbusch-mbp>
In-Reply-To: <aQjCQKiN5mzw2oY3@kbusch-mbp>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|CY8PR12MB7683:EE_
x-ms-office365-filtering-correlation-id: 5d329ea2-14cf-4741-d220-08de1b11a1b4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|10070799003|376014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?S01GdXhiT0J4Nkliek1UL3NXQmRrdzh3TSszZXAyb1d4TUxlVHFxSGRHZ3BD?=
 =?utf-8?B?Z0Fpczcxdlc1bDUrQ09tWUVPeHFjZEQvSXFyanNwRElleVdaSlJIN3M0emg3?=
 =?utf-8?B?YnFGVjh3L2Q1YjBEMlQrYklaQ21uYzZqU3BRM3lZY0hYMzd3VzlXRVlOTVNG?=
 =?utf-8?B?cHM5dlR1bW0wMlcwZU5QWVFaUjkrY1dNd1lMRkxLdzBHVWRJeGhKNTJXeEp6?=
 =?utf-8?B?NU9uVnptUXhwMlFJbTNyL1VpZzJ6SVpkeVZxcUZFUHBOYnYzZWFYNml1aVM0?=
 =?utf-8?B?V2dQbEw1czJGR3JUOXkwcWNlMU9hOFFHUGMwUUVCSzVhbVBOTCtsV1YxRjY0?=
 =?utf-8?B?blBKSmJyaWhudlcxSEQ5WXF1bEVPYWdHc3VMdmQvWUhoNVBCNFkyNnZXQmgz?=
 =?utf-8?B?Y0p5bThrbEdXMVJpdEQxbUphbzB0aE9uRWVLRHlLcjk2TzhCc3RZeUE2ZG4w?=
 =?utf-8?B?Nnh1YmxLUlcrT3pDZmM1ZEhQOGlXMExYOGl5WkNxN0xQN2pIR0hBS2g0WDRX?=
 =?utf-8?B?b1Ywbk1kMmI3QWpFbnV0NEd3K3ZxblRLbU9HWHR3L2xCTE50THoyanRLZWRC?=
 =?utf-8?B?L2U2NVpwWW95clFURHZTOGwrSjI1eGJLYnhmTXdRdWFXN0ROT2NOWjBuYVJG?=
 =?utf-8?B?djY5Z3FOdXk1cWpxM3NSWmhVaW1WNlkyd1lFY2FGNVMzSER0YlR1S0x1V0ZI?=
 =?utf-8?B?VDNMUFZ5ZGZ2YXQvelRPeTBoNVFhRStEMVRUU1VBSWxBR2lPMW9VWW52aENP?=
 =?utf-8?B?eUlFeU9rTU1ISks4Q2hxVkxuRVAxTTFGcEFEZzNVdUhlTGpvOCtvKytjUmpv?=
 =?utf-8?B?QjFNTmg2TldUbzU3aXpVQmoxSkZNVEhvRGpxa2RqcTBXSjRKbGdJRmFLcUVz?=
 =?utf-8?B?T3FmT2FYalE5cG1zVjF4QUdqSkhNY2YwMkkyM0NtbEwvOUpGWmhDQm05QlhV?=
 =?utf-8?B?Z09ENDhWUTFBZHRmUThtNDFmM2lhWWdzVVBxVENnWEJtMVlVSHZmMFpNMjZi?=
 =?utf-8?B?ZDVEVXp1RUJ0NXR5WnBKTTQyWUl6d2hVOTJ6MTNCamYzK09xVmRWejdjcFdW?=
 =?utf-8?B?Tks4c25XK3Z0N2tjSHV1aG5VRGtjUEV6aFFpODhlVWFYdjVYSGFuLzA2N3Nh?=
 =?utf-8?B?dXR6ZGZQZERCUnk5RXlRRGc2ZzFKeGp5OXh3Tk9hWkJQd0FsRW5LbkVobksx?=
 =?utf-8?B?N1dYcjNuNU1sRC92eG5pNHUwczZsVGdZQm5WSm42U29DZkNIdlJnVWJSZlZv?=
 =?utf-8?B?ZmUyMWpTdGEvK244YTFKV2E4K25pUVRLZk45Rno5eG41bFBCOFNiNExDaUNB?=
 =?utf-8?B?R1RTZDA2MitVSHh4QWZlTk5HcVQ3bno5d3dzTWs2MTlqaVJMZ25WTHJUZkRB?=
 =?utf-8?B?c29jWjFjamFPVy9RRmFJTHhPTVRza0pxOGhtWnpGZEIvdi9XZkVucm1RWktr?=
 =?utf-8?B?c1RkNzN6d1EwaWhNMVRieVVmQWxzcUg4SnVydk5ia0c1YjJhc0N4SVl4R0Iy?=
 =?utf-8?B?eGgwT2ZxNUdiN1g4UTdJZ2R3T1BjV3VKN081WnBhOUg1Z3ZDbVYwNnRuNjNR?=
 =?utf-8?B?ZVJsanBvbHR5RmMxaFFRWlp3dDQ3Yk5zNCttc0lwenlBdjlOWFFHcUlndXZq?=
 =?utf-8?B?VmluMkw3Tzh5dkUzKy8xdVFkUXo3amJTNFQrUW5PTjhEZ0dYRUhIaXBrRk8x?=
 =?utf-8?B?ekNGbitrMzZMNTNjUTRhTy80alViYWc2dGdmMk5HNDExWGFRVHAvOHJZa3Bt?=
 =?utf-8?B?d3UyVEwzZ1UzYWVQVlRVc05FQ0ZCYnNiZ21ONk95VCtBYWxiWUZId2V0V0cr?=
 =?utf-8?B?RmRtckwzT2g0bW9Ucm84L1NUQzVVU2lxM0M2ZjJJOU10dkFmeHNzcHphZlQv?=
 =?utf-8?B?NUc5QzFKc1l6YjRQbHIxU293ZUNOdDg1M0M0dDY2S3JSdERMVm9wSDdGZ3Ux?=
 =?utf-8?B?dGpLSzVpZmp0OWpPeVRKRHJnSklCc3hNM3l4SXBuZXFXNXNzUkdIK1RaTTJU?=
 =?utf-8?B?UTlhYkdPNnRhQ2pmdFJvbVE2alAxY1k3bXpRY05ZdnN1SG4zaW13MHBCaUJw?=
 =?utf-8?Q?UXBoWi?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(366016)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bDIrWkxHYjdtTGVDZ2RmRHRUWW5tblRlT3lkMjZSWlFaUUovZElXRFNtQ2Zy?=
 =?utf-8?B?QU5oNnJRTVdTdll3b3dqQU5ocXIzUnhXWGlKVTFrc2JzYzJ5dm5iRFdXZGJB?=
 =?utf-8?B?eGQzbXdNTW9mRXlHRWQveWRGSVJaTTVXREFPUUlsdDQrOE5ESnN5VS9JMHVL?=
 =?utf-8?B?NmNuOGV5THlxV3JQOGRLcWtTSEVJUWJiM1FyNmcxSmJHSzRjcEhtUktPYUlh?=
 =?utf-8?B?ZDJ0YXBFOUk0QWd6UkFCVnFIK0VPS1ZkMHFrRllWMTFpeXRSQ2tFVjNjb2xS?=
 =?utf-8?B?RERnM3g1ejFRc1lZRFpQeGwzWGdaLzBJTVdxQzMwZm5ocURxMHlEM2hyMXhy?=
 =?utf-8?B?bWZITFRlZGtjSmNEV1EzVTRFeVI1a3Z2SGlOdlNmK1dLSnd6TlNZV1d5YmJ2?=
 =?utf-8?B?bXh0NFlhZFNZY2tSNmo0amFxdTdhV0I5cDBGN3l6T3V4dGRDeFM1ckJPVjRL?=
 =?utf-8?B?eVRPajVVbkZoTXgxakxIL0FtOEMrN2h5VFlZaDgxTkt1Rk1mVk1JUE9HTXRp?=
 =?utf-8?B?NUtYanVoeURvNit2K3ZZVG4vRXdmVlhYSENrT2dPaXJzUzJJdkRVMU4rakNt?=
 =?utf-8?B?Z2d2cy9nc3VTeUFtUEMvcHNESCtvYytIVGw3bHFocFl5KzY4bDdPN2tnMTBH?=
 =?utf-8?B?dDdJQmFWWWJPWGdqSTB0RFZOWXl3Y2tPdlVFUENnVUFlV3V6VmJEUG9FTmo3?=
 =?utf-8?B?ZHE4dzJ4dExscEdjb01xYkxQR3BtZ0FRM2xZOFNKT01XNGxRSkJFZktud2JO?=
 =?utf-8?B?S3IwOWZwWWgwbXNMYVdvK2ZKMmQvRzRjcXhFM2xHd1NOYnhWbnlueVBMdEtQ?=
 =?utf-8?B?LzAyaW9MMEZYOS9IS1U0UFM5cWN1L0k5RjRyanVFSXNlQ0ovaXlEa0dqUDhi?=
 =?utf-8?B?QU1RajZNRUN0YjIyQkUzV2NYaTJySWRRdURrVXErMVI0K3FodlRwT2ZlQi9W?=
 =?utf-8?B?eWtISzQwYTl6RnRvUXlVclNTNWd0ZmRCZ28zMFhkTTV2N3pCWi94L3FGTU03?=
 =?utf-8?B?c1ErcE5GWXFqL1l1ZVFoY0NRK1ZUQ0s4UHVTejIwOWUxc2V0ZXNnUTRmUGFI?=
 =?utf-8?B?NWo5WDc4MVY0ekhtZUpMT3dvRGh1QXphdzg4RTYvUHVTNkMvanhodGVCM295?=
 =?utf-8?B?dVNwbnFuUUNia25iNTRicHlUMUVYWThCVWR4b1A3OFY3QjVIWlA3SkVKQlF6?=
 =?utf-8?B?bDgyKzBGRi9Wa1NBNmVucThhL3oyeW9FUHNJeUNHM2lXQlpvemlmbW1uUkpV?=
 =?utf-8?B?dzFNUmdGNkFBOHlQVDZERmZsSzUrOURuY1M1ZWptd1VsT1N2dTZ5TFJSZ0NM?=
 =?utf-8?B?TW9QVXloZ1hXVGxoUnMwRldrclkvd2Y1ZXVybW4vWXdNVmh6MjdmUVJESC96?=
 =?utf-8?B?ZEx5Uk5RalpabU1ucTF0dDYxNU1jcmFsSWtha1dkMjFSZ205anVjUGVoNEp5?=
 =?utf-8?B?dEkrQ3ZpZld1dVZEWksxRE8vQVZRaHJCQ0hKQXI4NmhKNWt6Y2J3UEUwN0lL?=
 =?utf-8?B?dWVVZWJQWjMyMkVkYnhzbWJWYTZ0M2YrckErZlRrOHYzWk45MmRTQkkzQ0Mx?=
 =?utf-8?B?NXVyZVVvelJyN0hnSlZieWo3VTAvYWFPVFl4QkVvWndyYkJ6U1hkaXdRbVdC?=
 =?utf-8?B?UE5peUhEcnRmVmlkSUFDSEhPNi96MEludzNQaVk2Yjg1UTZPT3pENHB2TWxq?=
 =?utf-8?B?QWpjeUcwdmx0dkgxY1JVcUF5ZUpQTkNuLyt3eWwvTFR5R2JMR2dCa1BxTGNu?=
 =?utf-8?B?cFJsSWlPQ04wT0QxY0JpYlk2czJkSS9PMzBnU2E3b0lLZ0VxNTEwK1k3N1Fw?=
 =?utf-8?B?M2hBelN6QlBRSXMrU2RwNDJSRzg2UWh2L2hFRWhLSVNNQ0RxRkVZWVJvTHlh?=
 =?utf-8?B?RHV2cFlIdE9iNWF4UlA1aERQVjVvclJ3ajd6UlFYVHhVek9USXVTSjdZSHQr?=
 =?utf-8?B?Q2M0bUNpQkRxZ2RMa2JETDIrQm4xMC9HVDFFQ1ZlRExUcXpOS0tkNkh0Qklu?=
 =?utf-8?B?VWtHUTlqSGFLdlFZSFhpcitSZEQxMTZKTDJpQ3lkbURLLy9EdVd5eHg5WU5P?=
 =?utf-8?B?clBwd1U5MDFITjBjY3BEeGxQTUprZEVOVm95dUxsd2pNMFBqaE1tSmhoVTUy?=
 =?utf-8?B?N3pUTHd2WEo4YTdrWHE2QjllSGxuRXpwL0MrY2FEUENkSUdNdzAwYW5EY240?=
 =?utf-8?Q?Ja9PaV4G1z2YxKdpFSl/lgcmfGcIuGU17nU8iw5Lt6V6?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <49BDBC976FF12743B6450715103985BF@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9404.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d329ea2-14cf-4741-d220-08de1b11a1b4
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Nov 2025 19:46:07.4543
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KNJMzvVAS9RS2yh9xxNesyM5VB/RA80Bb8ZY6EOlDf/9YvMEgufiRVOe65eCxeASry40xKiTSwqiNczzPpMa/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7683
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251103_114612_935738_5F861D73 
X-CRM114-Status: GOOD (  15.37  )
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

T24gMTEvMy8yNSA2OjU0IEFNLCBLZWl0aCBCdXNjaCB3cm90ZToNCj4gT24gTW9uLCBOb3YgMDMs
IDIwMjUgYXQgMTI6NDY6MjFQTSArMDEwMCwgQ2hyaXN0b3BoIEhlbGx3aWcgd3JvdGU6DQo+PiBT
byB3aXRoIEtlaXRoJyBsYXRlc3QgZml4ZXMgdGhlIGF1dGggY29kZSBzaG91bGQgYWx3YXlzIGJl
IGJ1aWx0DQo+PiBpbiBpZiBlaXRoZXIgdGhlIGhvc3Qgb3IgdGFyZ2V0IGNvZGUgaXMgYnVpbHQg
aW4uICBEaWQgdGhpcyBub3QNCj4+IHdvcmssIG9yIGlzIHRoaXMgZm9yIGFuIG9sZGVyIGJyYW5j
aD8NCj4gSXQgc2hvdWxkIGJlIGZpbmUgaWYgZWl0aGVyIG9yIGJvdGggYXJlIGJ1aWx0IGluLiBU
aGUgcHJvYmxlbSBpcyBpZiBib3RoDQo+IGFyZSBtb2R1bGVzLiBGb3IgdGhhdCBjb25maWcsIHRo
aXMgc2hvdWxkIGhhdmUgdXNlZDoNCj4NCj4gI2lmZGVmIENPTkZJR19OVk1FX0FVVEhfU1RBVEUN
Cj4NCj4gT3IgSVNfUkVBQ0hBQkxFIGFsc28gd29ya3MuDQo+DQoNCnVubGVzcyB0aGVyZSBpcyBh
IHNwZWNpZmljIG5lZWQgdG8gcmVwbGFjZSBJU19SRUFDSEFCTEUoKSBieQ0KQ09ORklHX05WTUVf
QVVUSF9TVEFURSwgY2FuIEkgcGxlYXNlIGdldCBSZXZpZXdlZC1ieSBvbiB0aGlzIHBhdGNoID8N
Cg0KLWNrDQoNCg==

