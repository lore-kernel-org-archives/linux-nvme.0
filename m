Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52C79C54E41
	for <linux-nvme@archiver.kernel.org>; Wed,  6 Mar 2024 17:46:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=iB7KUZp9nqzMdkfvQYmrHfbOLHa/koHqmulW0yXihWQ=; b=wgBmIthuIeTQrcGgVJJOr4Or1i
	mQSKw/+RYYghGN/MgNr6Esq1sNam8LbZnZAx3MdC70A3ktEyIuWvTD4FE7wZqWcI4Sz3UdfImLmWa
	xfdnCDMdnTqyRgjfGSEshrxFg3Q36zC/iZCC3VwweIhcmVgixxUoIg7ksOWgCTnasEAb0LmvvUSMX
	DOTolJNAE8n/wjWIq57Y8T7SgruK8n6pWlKgCMLP3whvebs/GBClJF048SLQVQoHWiuWbckevNJ8i
	eQIMb2XToM4pMNgIPKqQ/wvEZgYTxSlLDT2dyFN/Ed2IlJnjNQ7vBo4G/Cek2bqvXcl/CC3uj+zKr
	t1JNH9ig==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rhvL9-00000001H7L-2rjH;
	Wed, 06 Mar 2024 17:46:03 +0000
Received: from mail-mw2nam10on20600.outbound.protection.outlook.com ([2a01:111:f403:2412::600] helo=NAM10-MW2-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rhvL6-00000001H5j-2Kxm
	for linux-nvme@lists.infradead.org;
	Wed, 06 Mar 2024 17:46:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KUmpUeXjY/2jVLyLM1LY22g613PXTcujmLagAtgISFR7Ltx2teQYhxWNYC/Ss0U1WGtHUmfnR9bO/Ij3b51jlt6HB4qGBYgbBmtttqzvhVYhrF5BiPswewfjexgqo9zbwskY0bU5ECkgjIwRgQkebv0fPPx5f1tfgnuB/Vvv9AxpNvBB8rHVh7N+/odsVcM3va99DAFBzq2thzZq7sbdJN1qGAW013v1QiTxm9I8YuHyvQxKmISrg1JxW4l7uIXFH2NPsfxn2nztWvbpptd8Mvs8BO33Sc3EXSKZXAVYM1ChXv4CNHf9dF4PLc3JZiPZypt3SptDKq22fJRten/KWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iB7KUZp9nqzMdkfvQYmrHfbOLHa/koHqmulW0yXihWQ=;
 b=DWt3DSSyIa3P/w+is7fpd4+DMlRf6cuQNBWZ17fk+BqlOizGkEonwU6WKp7E5Q1dbOrYKov8pu96hpFI+tWKz9pKRlgIYhMPYh7XjvPVkEh2zRtdBU9jU7Dw7h5AwDr95TX8BmlCHddlGY0s0AcJS5iuI+EAwTFTxcA1oXYCb1+40OjIeCl/4qqLrcaks+qAWfa6dqqgl+JdMtv97B9sq3+HbVS/StJK3PSABv6+YiRfOD+HKU/e1wdsSXVQim+Q0O33O7HKM4ZH+8KLtPOomlKyNAGgHAY1o7cq2XRL0/ANEDWYv85Eto1t2rG0JbymhblYx64UH60lNC9xBGx1Kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iB7KUZp9nqzMdkfvQYmrHfbOLHa/koHqmulW0yXihWQ=;
 b=jtaWXxvMqqlSPtPi/0MPWI/j6Pfm3fsmFZWOPuiG8bSn3hIRUomxwryeY3qz6QqfCDPuF9a5vDuChZohVtzpKCvARzLLiIMi2PdjE//eienOpRX5MB4Nunu+MCBTXA3sPb2dPjzyEvAtDn+OYg+GUXZ/mA7mofhTpdMaRHMonSJmSBn9OFaCXv2QSsmLncoioAj81UXTJXnLbwihS3dBFxrBThEb2B6iEoKqorZAphEDV6rx8ISS8UkUhemul74KPPfzRlpxhWh8a/otFe1WZoqwJlBftREDxODYZZlRFFhC6ROMhqUuRJl1ldRSHEgqiIkETAU0LwHswTYN24NhtQ==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by DS0PR12MB7608.namprd12.prod.outlook.com (2603:10b6:8:13b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.39; Wed, 6 Mar
 2024 17:45:47 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::a1:5ecd:3681:16f2]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::a1:5ecd:3681:16f2%7]) with mapi id 15.20.7339.035; Wed, 6 Mar 2024
 17:45:46 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Keith Busch <kbusch@meta.com>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>
CC: "hch@lst.de" <hch@lst.de>, "shinichiro.kawasaki@wdc.com"
	<shinichiro.kawasaki@wdc.com>, Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH] nvme: clear caller pointer on identify failure
Thread-Topic: [PATCH] nvme: clear caller pointer on identify failure
Thread-Index: AQHab9I5ZVBbATBRf0G7zYmeMP/ZL7Eq/JoA
Date: Wed, 6 Mar 2024 17:45:46 +0000
Message-ID: <90fcd241-8ee3-4ff5-8aea-67fef220bb41@nvidia.com>
References: <20240306142519.1213814-1-kbusch@meta.com>
In-Reply-To: <20240306142519.1213814-1-kbusch@meta.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|DS0PR12MB7608:EE_
x-ms-office365-filtering-correlation-id: 2bdc1ea3-2fe8-4bfe-1b95-08dc3e054104
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: m7+FL72WJN83/AjlgzkAPBRr3/KJsprwOr/IRASMLg8TY+eVjyUWyauJLceW9mYWK5cWxINTXKIU0sHUvbDCogL+Dw+hskdm0SRODT6UcW5VL1TA3IHtowNt1V1zgzMok0INzAE4N9o4tXLMWQ5dSM3nUuVmeq3KvRCPfVOyoCoMY0eNYDGUaUis2rX693Zb1R3Nq2AxPUMBNLU/05FjU6zStZVb/tVV5KIJQNSgn73M4qucUTVWICed8PrqvlSfQfNWnDbMBIIusc3ZJYOngfpk8zo/KI0yWEIyyeKMnRLvgr2sqUAP9uKCIbmSnSYvWgvyfcJsFNROMS+V6Rt3G8I/a3Gbt7hvkwDGAoW1ca5zukPJB/y/IWtmMdsyYW0mYWhu8b/kJScLqjCDv+7DxEGn+1tBiLdUiRqIlEyjSRVq8o1EaPEvwHG4r1nobpG/zPrBn9ftOA4k97LwT+5bLx2EwgtyI05sbj0eDZsbapZ1sM/Gaxa4QrbPunWV7c90f8++c8ZhypaU9d5NwIYwVyyX6V/yNKyikEafwz6eLxPQaXiqlCLh+8aTOn6zSfMmyPpxkbdQ6Ru1GSDTinpCySR10ww7aQ1OcUznX3xrqFY27xsf0yRjjShh6FHzOYm5qCZGj2aiUhh0WHAN45F6IbSamBiN5kDXFzjybr3A5ld0vGMPtQ6lBHvxzQwmMtBJ+nSEmaI8fUVGRepMdQ2BhfPzbVs4ubYww7FOK85taA8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?S2RsWXJLT3VDSWk3cUg0S1RwVktlajZlSTFJSVpUelRIZ2ZONmpOekJLTG1P?=
 =?utf-8?B?T2plWXppZEVQaGdWV2d4N3JweWhvbUNadlRCYVoxdWNJajlIQ2Vua21SeEV6?=
 =?utf-8?B?ZDNkb2pZZmdidnQwUVhidzZtNGRjYnZjR2FQblA5akYyRSsxWnB4WmJPTy94?=
 =?utf-8?B?M2VkRHNHRTdBN2FkZE81SGxJMEZGd0Q5Qk1Sbyt2TXc0dVpuakpvWTBnQ3ph?=
 =?utf-8?B?VngxUkVnZkozSTRjRjBzZGFQbXhxdEZOL0FxT0tZMU9jVGxSQm5sdm9yeERo?=
 =?utf-8?B?YkpYN2h0dG9RNHpyUm11ZVV4ZVlabEV1OVkvaHBPcGE5dDZGYlUycFRJckxv?=
 =?utf-8?B?Vk5HYSsrOXlxQXFDaTRZckZHc1k0ejBaY2xOV2V3Q25vTGlOb2gyWWNQbU9w?=
 =?utf-8?B?ak1saTdHdy9tRFlnU3Eza250QldhTm5jbFFPUXRmMGRYejlvaEhhRlFPclNS?=
 =?utf-8?B?NldHT0JMWVBGeVFLcWJ4cHIyWEF4Nnp2NGNmUkNHZXNwVDBBOTlJUCtVY1p4?=
 =?utf-8?B?cXV1NFZHOVhRUnNUcHlpL003c2ZVei8rWEoxVnh3MUNXR0JqbWUzNjZ2V2NY?=
 =?utf-8?B?eHVMUi9IRnEvalV2TTNqWTRmcFVBbEJ1Sk5JSVRVSmJvNjBLTmxWQ0Y5K1p1?=
 =?utf-8?B?YWhtOTNpMFpua2xWLzZkSDhybG03Mi9EWEw5YUQvUTlLclZLVFZSaHNMNlVs?=
 =?utf-8?B?bnhmaXN1L3JhRUFVbkk0UW83VGF6YnMrQkc5UlpiMkZTbmdnaWdqQ2F6QzV5?=
 =?utf-8?B?eG92R2YxcmREM00zTVZ2UWRUQWx6Sm1Td2ZkZ0tuT0FvZ3F1UFJhY21xa0li?=
 =?utf-8?B?bU9sWEZwT2EzZzJVTDNUL1g0OFBBUEpnaUJYTERtc3VsZjFHSzZXeGVJbkZZ?=
 =?utf-8?B?OTBVZUFFMzk5WHhHQ3VzZlJuRmhYMnJVbWo3VVAramlsS2JsYWFjZGNZam5Q?=
 =?utf-8?B?WU9vbGZSYlpjWlduZE9HbDlxZ0lzUTdQRlVOQ1NoNjh1OWxNTCt4dkovNkI4?=
 =?utf-8?B?cWdiNUZ6bnFDblgwa0VjdVNrdHJ5UXhmQXFhY1QreDl1bjlhNnYzTyszenZB?=
 =?utf-8?B?cjZIWk9iUDV0WHhta0l5R3BRc1JBc241NHJMM1hodHk1NE1GaWlhVTJkOTRn?=
 =?utf-8?B?TUdtT0RTU01TR25vWnNVbGtnT0dGL2xUbm12U0toaDNiZVhKMGswS3lYdG5y?=
 =?utf-8?B?UGZaMmZnRDlNMjc2ZDZHS0Q1MG1uV3J1WFdjWVBoQUdnS0xmbWc4ZERSenQ2?=
 =?utf-8?B?bWVIVGlyTnQwRTNJY2ROQ3ByTVJjRnNyWWZTZFArNTJIR0tLMnB6SmZLSjBU?=
 =?utf-8?B?VDhmVGZZTUw2d2hxMzE0ZVAwL2w4enErL0NtUW12bHdLNThqdGJBRHJVZzVs?=
 =?utf-8?B?K2pya0d6TDY1azRGdFk4UzJkK1JmR2hsVm5rbVoxbm5LREVKdlBrMStXcnAr?=
 =?utf-8?B?QVI4WWpyZkpjNmhUTFhzaGFxNk42aXBrTG02TTlBLzRWMy82cHFpdW4wZy9I?=
 =?utf-8?B?R1Y4QmJGZFNZVWM1bmlBS3FySXExd2JpNER0b2FsNzNYa1N4RXJ5aTZNZUNq?=
 =?utf-8?B?OWlzMEhua29vN2FReDZqeE5LajA2VHpPM0dmVHJHbnU0eGtsK00rUnpSbmxq?=
 =?utf-8?B?YU9PMVJRUlFmTjF1SWlad0dsYXlvZnRSYnYvOXVEWjJML0NaMFpRdGR4ME1o?=
 =?utf-8?B?aFZGYUhyUjlvbFpVZktpa2NreEc2bUxyQVYxTVVudnB3eStta3A1d2RQZUpq?=
 =?utf-8?B?bVE5akRmd25nZkczTVZPZHBNK1cvaFRPMU9kMGQya28vVmZvVnZ3ZU9URWVO?=
 =?utf-8?B?L1ltYjJtTlBPTkIyeVdGak02YXZGZC82d29uVmpLbCt6U1JGc3V5QVZua0No?=
 =?utf-8?B?aFVCNzg0REhHNDMyTFM4MVFkQnlLaU8xRmg2OUVFZnkxUjdpcHI2bVBvZFlH?=
 =?utf-8?B?VTYvRXJaVzBhV3hYS21nUzBxYnV2TU9FZjNUZW41djRlbXVpZkRmTE9GV0hs?=
 =?utf-8?B?NmQxenR2Q1U4Q2poQTR0MWNGSjRJK3h4cnpCRTRZK01oR1lVUTBQbGh3RGd4?=
 =?utf-8?B?STZvdVQrVlJTbnJZMnY5YTQycGhzeG5zM2YwbmcwZjBoNnlIM0tCUlhxNGc2?=
 =?utf-8?Q?LDnoJZLMTloLAM6IOCh1FZu5M?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0E14F4F1CBB49F4182DD706DE944F637@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9404.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bdc1ea3-2fe8-4bfe-1b95-08dc3e054104
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Mar 2024 17:45:46.6260
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DFvsklEmZH5r8W2WsRM+LOosjXICE5odfhk6aIxxQ5UKEOgzNKUkuXAQYzJmc4t0ZrJRbQ2fbanbEJ2w9P3IOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7608
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240306_094600_785458_5BA8AAB8 
X-CRM114-Status: UNSURE (   8.60  )
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

T24gMy82LzIwMjQgNjoyNSBBTSwgS2VpdGggQnVzY2ggd3JvdGU6DQo+IEZyb206IEtlaXRoIEJ1
c2NoIDxrYnVzY2hAa2VybmVsLm9yZz4NCj4gDQo+IFRoZSBtZW1vcnkgYWxsb2NhdGVkIGZvciB0
aGUgaWRlbnRpZmlmaWNhdGlvbiBpcyBmcmVlZCBvbiBmYWlsdXJlLiBTZXQNCj4gaXQgdG8gTlVM
TCBzbyB0aGUgY2FsbGVyIGRvZXNuJ3QgaGF2ZSBhIHBvaW50ZXIgdG8gdGhhdCBmcmVlZCBhZGRy
ZXNzLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogS2VpdGggQnVzY2ggPGtidXNjaEBrZXJuZWwub3Jn
Pg0KPiAtLS0NCg0KTEdUTS4NCg0KUmV2aWV3ZWQtYnk6IENoYWl0YW55YSBLdWxrYXJuaSA8a2No
QG52aWRpYS5jb20+DQoNCi1jaw0KDQoNCg==

