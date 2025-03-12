Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38D7DC28B28
	for <linux-nvme@archiver.kernel.org>; Wed, 12 Mar 2025 17:44:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Cc:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hdP5G7fpbQ+sGVTP1ytyaABty/U1Rrrb2elyowqgbKI=; b=qRvtDgoAM8ufvBN4ugH9dTg1K6
	QJ27/7CgqdodgEOQnev2zhGlb9X8EPK6851HljgwRZ4QyQOIdYvXfz6GqD+fNeZHRpD5gtNaqRT/J
	0wIXGm82cBnNMQVurPT9sfwz/tg6iUiIqoyz+i6MzHxng0BYccDpK51uIgDdJnpCXjssFUyEF1A1b
	cjQIY58kK7UIbN4lOZTXNmYtyM9qPfvqI8fbgfDzYqXZZOOkuT5iISsAFEB9RRYT5wC5fI9unChM+
	PRxzcjxhXopllabcMgAXEXXdC7rpLWk7sCaqOPO9NpsvVtiZDrEQuE3MdTFcNh1SYX9AaJRk35hF0
	PV8gF7kA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tsQ7g-00000009AL2-2LBn;
	Wed, 12 Mar 2025 17:44:04 +0000
Received: from mail-mw2nam10on20617.outbound.protection.outlook.com ([2a01:111:f403:2412::617] helo=NAM10-MW2-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tsQ7e-00000009AKX-1Cpt
	for linux-nvme@lists.infradead.org;
	Wed, 12 Mar 2025 17:44:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IuNynv0WUQD7ar3M3IUPuz6yt7/ODbotbetwDEChRSMecD9vcgftKzCdgACOvGZoANL0EQFMLbskyXBlF6YD6qJShxyMzSFQ+Zn9trKAQfeTZe9k7VbAxaT5QZ7ouNTWw1CqCz/60r0vFtmXc7272oaXAJOx7NuwQ/0l/HxItHq5Ycvm9bJQayd/RT7mbCaZNKIPKTWiZqdajY2cRvUYLX1jnk2iSajOO8gXFPcS0GyD3g3FILSZzu2QqJU7G2BaJS0J+m5MrRNK/JnZAoGMJQeXHSVXLSkf/aL6XxJtRIKZKqT+Nbcn2AkKhoRENS3n2e5+C+aeiQFjQv4rLyZ0pA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hdP5G7fpbQ+sGVTP1ytyaABty/U1Rrrb2elyowqgbKI=;
 b=RaudIEU97lMCfHjzJLoMbhnk5oDyOpVMWdPSpR2laltvasLI5K7dYNDwNTpWlnkQd73vQqIzIoHysVRLE+s8wm9bPgrQLxFfNCm1GSz7wB+etUkejUHAOLQHimNDdP9keTaqw5+CBm4V7MVhP7VG3OBmQtbZ9oz+oeT7TxTraT++k5ACV+jS+m2jdXmKLGyhJGl7C23xuZxRJ8bA5VCwLfc6dGEPM6gu85iMMGSO+tfybV5d5fIdtMYFiypYN0f+UYX8QZxehFhMGv0T1LZjh8KdNth3v72XuN5kZEoTWvt4uoNcLfSq+rhCD5jTQwBEhDuA/he9aYsBwTs9yrkLjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hdP5G7fpbQ+sGVTP1ytyaABty/U1Rrrb2elyowqgbKI=;
 b=tR3txaAZToztzBayEv6+B6qSC4YEJ3P1nsNmvYrR1MzcyPSFiEP5nWkOC+U4hFs7pWSNYcha18bWrdhgmXrXciP57DtmmSnTJS5mZh3BZ0moMD2Dh02oSEynu7nb8necZlYbJO50broCs3XIXALGaT2dptOSZ3mglnJHdQ0vThodcjXhaPLvb8GKGqDUw5OT4RLl11iOPESipktJyBhNAGecAg9+QZAE/W/ZX7a7d/+REP/YPHghSo0jRWEADBfjpWH8PSdZgD0v2+2+hi/wBOshz/E6XVAzl4VVsiRlNe+ArJEFj/4I+uBKslTOcmGraPp+/1OsUnS2RtEiNnoJ+w==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by DS0PR12MB7828.namprd12.prod.outlook.com (2603:10b6:8:14b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Wed, 12 Mar
 2025 17:43:59 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b%5]) with mapi id 15.20.8511.026; Wed, 12 Mar 2025
 17:43:59 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Chen Ni <nichen@iscas.ac.cn>, "hch@lst.de" <hch@lst.de>,
	"sagi@grimberg.me" <sagi@grimberg.me>, Chaitanya Kulkarni
	<chaitanyak@nvidia.com>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] nvmet: pci-epf: Remove redundant 'flush_workqueue()'
 calls
Thread-Topic: [PATCH] nvmet: pci-epf: Remove redundant 'flush_workqueue()'
 calls
Thread-Index: AQHbkyzNxtnpvY+cAEGtIF6f5oxOrrNvxlAA
Date: Wed, 12 Mar 2025 17:43:59 +0000
Message-ID: <57568d96-74d4-4e48-93f8-4439ba18649e@nvidia.com>
References: <20250312085625.1624394-1-nichen@iscas.ac.cn>
In-Reply-To: <20250312085625.1624394-1-nichen@iscas.ac.cn>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|DS0PR12MB7828:EE_
x-ms-office365-filtering-correlation-id: 974894ed-0d2b-443f-cda7-08dd618d783b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|10070799003|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?Tm55S0NXM3VnVFhOSnNFRWFqRGNDM3gzSWtadHNlcDhlU1hGWWY2V2lZVytm?=
 =?utf-8?B?UWsxREJ2NTZHR2puWnBoYzlKSmNUZVVhc3FnVGw4V0lJQzRVRWFqNC9SY1Uy?=
 =?utf-8?B?UFFWQkRTeDZUSk8wOC9HZjV4ZFQ3MndOcDh5Rnl3VHhFNlBWUFRET2lsUUFG?=
 =?utf-8?B?UUVsRFRzYUs3UEt1ak1jQ2prTS9iUjJESzRuUXNodHpackxYZkxndnFTUE9M?=
 =?utf-8?B?cGxMR0tFc1RYUVlPY1BDYUM4R3c4T2ZnL3NIYUxyZFQ2Ti9TRFNRUjJobWtr?=
 =?utf-8?B?RmFxUVB6TXVocEJRTEFSQ0Z2alN3cmlIYWlCcUVaWGYvbWRqc0hRZFlaR0ZL?=
 =?utf-8?B?UDV3UWZ2NHJ0eGI2RHBxK2hraDRJeC81bEd4RWNTRWhFV2daVUNnYVZSTi94?=
 =?utf-8?B?eXZNOWQzWjdFTGh3QnBSd2xUYXh1ek9TcFRESWE2L1JuMHROTjF2RWhHUjgy?=
 =?utf-8?B?bnc0RGF4RzhUSmVmaXdJTCtsKzdCOWthQ2cxVjF5WWNRMlNLMWczM0JaK2hm?=
 =?utf-8?B?OHdHWlV1eHpaa3dWNFlDZktBR25XNGFhZGZYSThyWE1iTDZpOTZZM1NadEsv?=
 =?utf-8?B?NklMbGhXdkZPano1ZFR5TmZleHR5UU84bEhlUitRdFVSVWViU2JjNk1jSnk3?=
 =?utf-8?B?MVNDd3hiNXRnVTNXZFFWQi91QWRCaVJBczh4ODVFUUtQWW43YXN4U203eFFx?=
 =?utf-8?B?TzF0TVA2dVA5ZFJWZnpSSlRmN0xOSjlJVjVQQzgwWjd2cm10Z29uQUpqM1Jy?=
 =?utf-8?B?Y01kR0UrNlJUL3diZXlFbWtyNUZWeDFQL0VhQjNmMExaMjN3UFJzcVdQdlVS?=
 =?utf-8?B?R0ptTlM0UmZSSVlWb2NrSnBtUGNWZ1FYcnhzdTlFc09WUWtYQUQ5SzE1dXNF?=
 =?utf-8?B?Q2xGdndJM0paeko1ZmhrSDdoUnhjZUNoMlZPdFN4aloycHRUMHcwOHg4OGgy?=
 =?utf-8?B?WWUveWdnbmwvWC9sUWtIL2cwZ0ZZcDIvN01oUzUwNVlhOXdyUk5ZVVozVnkw?=
 =?utf-8?B?eVlabjU0elNOY0h4V21LVlJvM0JLYytodmhEcVQvdUJOR1RNMzk3OU1DNEhj?=
 =?utf-8?B?OUNEZVUzY1J1ZE9FbjhzMFRCTXpZMXBlYXlmQmhRakpoaFVJeEE0cDg3V0M4?=
 =?utf-8?B?SUM3Q1U2cVRLY1p6T3h3aWpKczkvUWxOMTdHd0F4MGYxcjR5L2tMR084YWph?=
 =?utf-8?B?VE9jdE56SkdncEVnZCs3NDB0V01xaXF2RFFHMnY0Q1FRQjVCNVVKL3YvZWFm?=
 =?utf-8?B?Y0tQL3RSZ1ZlN3l2eWZ0VmxPNG1ER2Z1SG5CMUs0Lzh4emtWWVdXeWl5NkMv?=
 =?utf-8?B?RDVYUG9hOFhUM3VRdFlTWmE4OXMwdHdMdXltUzFxYkxJcDM4MzJRK0l2Mnl4?=
 =?utf-8?B?dG9UK0QrRlBSd0x4Skg3R2JCdG0xZU1lb01MR1A3b3NHWlY5dFRKZm9uRllq?=
 =?utf-8?B?aHcvd05yODd1QkhKcnY5aUFvQk9QejIxeFNKRjFkYmwvM3A4QjliY0hnUTFM?=
 =?utf-8?B?MUQvWnVQTHpKNmJqd3pNa1pNN2ptcjVPM0o3MCtpNHlES1ppRm5LcjN1aHlT?=
 =?utf-8?B?eUkrZkdxM3dtVFVyUHE3SXlISk0veU85NjluWnNFUVB0Z0Q1bTFtdkRhSTc1?=
 =?utf-8?B?cFVaazBmcmZXUm9OYUw0S3JtY0I4Y29BYmJWZUs0VGVWS0FxMGtmRWo2WXFR?=
 =?utf-8?B?eFI0dCtlbEk0aUJDYW5BNjllNmxDRHdlSzF2NWpCaTJKYW03NGp2Q0toclRs?=
 =?utf-8?B?SFMyQ1NRSm9Hb1ZER0FLZmVVZkpMcExnSXNWaHZINjU4U2Q4dW1DWGFmVU02?=
 =?utf-8?B?QzA1cHFvZVVOY294aXRCT0JhYnFDbE16N01ONFpUU2hRNHBvZ1cwVkhNdkNl?=
 =?utf-8?B?M2ZQSzBNRHRvQjF3N2c5SjBmWHROd1JySElOQmtjYVhNajJDQVBnVDVlWWRk?=
 =?utf-8?Q?ZV/4RcnLfofWaN4EqQcHx5a/rCcCPm+h?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(10070799003)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Mk9zY2RjZmk3bFBtTEpKaDBlQ1hielk2dGZyVWxqUFZaeWlYb0xiQ25NbVJ6?=
 =?utf-8?B?MTdYS3BEbU1oc0txRC9KWUlXWkluTjJWUVRZT0s3cHhzaGRtTmRxMnVoKytW?=
 =?utf-8?B?ZE92UlRYNTB2cXJjOGpsdlE0ZVYzYUx5RTB0dVBiRUlNbUk5Z0lrd0wzRUlZ?=
 =?utf-8?B?c3VIcEp2OEVET2ZZWmZ0clg2TDQ0SVhRQVYxOUpnNUtLcFJNLzQ1YWZ3NXgy?=
 =?utf-8?B?MG54UGtRNzRuMDg4cy9WUXc4OTAreHdaN092aWhaaHgzOXFJa1lPMW9maE5Z?=
 =?utf-8?B?TUZtTDlKSTZCbnYxYnNQQXVhUm5rOVI4b244WE5PS2kyaXNobUlPTHBUL1Mx?=
 =?utf-8?B?QldaMVc5TXZMc3VjaDlDbHV6MlV1MmFFVkxSRk5XOWZ0YXZiS0ZWa1FObExX?=
 =?utf-8?B?dXd0bC8zY3VieTYra0dOTEVkdWtDejQwekErU0xubUV4cEhUdFdBSHhWdmYx?=
 =?utf-8?B?dU1TMHpReU9telZUT1NTaVdlV0pKRGpQS1JzTWhIa3dlRG5ORUxNSGM2MCtq?=
 =?utf-8?B?VVcrNEI3OXgxZDBGNHhuT2RPNnU4czhkWGwzMVhYRnBYbExVY1oyUzZGYkRw?=
 =?utf-8?B?YzJhdXhhM01jMUF1UzAzTDBPRGxaS0hJTVYwdUxKV3c5TVZHSi9sT1hZTHda?=
 =?utf-8?B?MWpxdnUwcWFhRWZ2Y3hTREVoR2lFY3NjcVdHait6QkJ2NFNzTytReTR3UWJr?=
 =?utf-8?B?dlh1NTZGRXJZTmtBSDY2dkZiUVJQdWdJK0E4cmcvUzdQKytyK3VIZGFEU2s4?=
 =?utf-8?B?S3YrazZGZGhNUTdiZ2dIYzBrRkJLSmVzZFYzOEphbmN1MjM3Ungxc1ZlTkZJ?=
 =?utf-8?B?VjB3V3VTT2xITFNVYURIemNoSDNYVEhyazR4cDVpMy9CZXlzTmJRRW9JcDNY?=
 =?utf-8?B?cVFqTmlaWDJTTytWK2RjaVdhbzB1RmlvTHpQTWFmMGxWVUV0NkZGeXU1Qkp1?=
 =?utf-8?B?RzMvVmI1WW54NkVqSU4zUjNOai9Hak9yOU5VTmo5TzdnbXQzU2tSaStabGhp?=
 =?utf-8?B?MkxRdXg0RFFzTDhydy80SHE3eEhSNi9Yb0ZCYmZFUUdzbmtYN1BCWXJQSHRX?=
 =?utf-8?B?UXpRNE9RaUlnNTJ2TUx1dXBPWHFRbnhLT01xVGxqcEtoUTdpdFRQd3gvZDlY?=
 =?utf-8?B?RXFmMlFzYUNNV0Y4VDVpZUU1eDBXUklESDFTeW5QYlNMcXdpVFJNS1ZrRzY5?=
 =?utf-8?B?R1JSMkxLRy9BMEluWk1qS3lYVXdBTFF2M3MwY3VzNTJwdWJ0bFJkdFpQZzdt?=
 =?utf-8?B?VFFPVjBBbUZRazJoenNGYzdpRXVJOVRxaEY3MXV0OHYwSUFRTE40Z04vL2JF?=
 =?utf-8?B?VTJ2OUYwTHhSSk1DNE9PM0FYNGhUeFVyaEhSQ0hXMmFwNURzMk05ZXpvN0xk?=
 =?utf-8?B?ZnM5Mm0xQzN0bWpGS1NHc2xwUHRBZ1g0bkdOcy9IU01BeUczdkxBQUppT2tJ?=
 =?utf-8?B?MTd3TUhYYnRnK3ZSMTZLOFZBQ1J1WXFtVnhiMkFjeUFEZFZpY3Y2MDhad280?=
 =?utf-8?B?NW5xMjVXTzZhcFNmOFBiNzZQWnhoNHdiWUM5K3ZTa3lrMk84WEtFdFRyTVdk?=
 =?utf-8?B?Q3ova0x2OW5SZzR3MXBCK21XNVVueTJhYnVyUEd2aUVHOVMvbXpPQzF5bU5q?=
 =?utf-8?B?d2wzUGlPOUp0a1IzZEQvaGRMcTIzTFRIS1ZYbTJiMk9RaHV4K244WXA1K0Ro?=
 =?utf-8?B?TXlZZGZGWFZ2ZEpyNllqckdCNm9oMStlTDkxa1BvQ2pkbUVyUEF5L2NjNXht?=
 =?utf-8?B?THVhNVA3U3FxMDNlNFNsNVFubVFsL1ZpNzNwV3FKeXhISENRUGdyOERPbVBH?=
 =?utf-8?B?S0ZjYnEyc3ljVGpyeUZ0SnErSG0zQjUrYk1ENDNzVlMwMVRCSi9GcUY5ZEpJ?=
 =?utf-8?B?V1ptSXEvQzdYcXpJTWlyTGQ1VXd0c2ZNQVJOWi9LMHVNNlRxUHdXM0Rtb3ll?=
 =?utf-8?B?TEt2VE9sQ3RtTThxeVUwMVpqVDdUOEp2TklVUXRuQ3djVmlNZkY5dkptUC9q?=
 =?utf-8?B?c256ZzJIYmNBdTVCQ0JaeVdHT1RFbFRUVmw2S2d5UG1qOXdmQ1VacEVqSHB4?=
 =?utf-8?B?YndSUkl5YjNFR1FuZVduRUt1dXlna0toTlJGcXptSmU0RWZlM1JmVTczaDNv?=
 =?utf-8?B?YmNVclV1TDN1bm9nN0V6MU1NQzJRd01IWjVwNC83ZlJPWHVnMUtrTWxHa3BN?=
 =?utf-8?Q?k1Bg6S7BMWMjfjIMDvmqKpvG2yIkJuwGg9cXOXrC+NnE?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <AE6465AF8A96E0439F40E346928068DD@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9404.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 974894ed-0d2b-443f-cda7-08dd618d783b
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Mar 2025 17:43:59.1635
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: r+Qklyhunk66ov0IBAt3DaQchYN/2PbtBFMG/m+JK914R9hWN0q42byTIbyun/0GOb945amGH0F6VzLSJUmw9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7828
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250312_104402_325412_6CA6C8EF 
X-CRM114-Status: UNSURE (   9.84  )
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

T24gMy8xMi8yNSAwMTo1NiwgQ2hlbiBOaSB3cm90ZToNCj4gJ2Rlc3Ryb3lfd29ya3F1ZXVlKCkn
IGFscmVhZHkgZHJhaW5zIHRoZSBxdWV1ZSBiZWZvcmUgZGVzdHJveWluZyBpdCwgc28NCj4gdGhl
cmUgaXMgbm8gbmVlZCB0byBmbHVzaCBpdCBleHBsaWNpdGx5Lg0KPg0KPiBSZW1vdmUgdGhlIHJl
ZHVuZGFudCAnZmx1c2hfd29ya3F1ZXVlKCknIGNhbGxzLg0KPg0KPiBUaGlzIHdhcyBnZW5lcmF0
ZWQgd2l0aCBjb2NjaW5lbGxlOg0KPg0KPiBAQA0KPiBleHByZXNzaW9uIEU7DQo+IEBADQo+IC0g
Zmx1c2hfd29ya3F1ZXVlKEUpOw0KPiAgICBkZXN0cm95X3dvcmtxdWV1ZShFKTsNCj4NCj4gU2ln
bmVkLW9mZi1ieTogQ2hlbiBOaTxuaWNoZW5AaXNjYXMuYWMuY24+DQoNCkxvb2tzIGdvb2QuDQoN
ClJldmlld2VkLWJ5OiBDaGFpdGFueWEgS3Vsa2FybmkgPGtjaEBudmlkaWEuY29tPg0KDQotY2sN
Cg0KDQo=

