Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2467C3DA6D
	for <linux-nvme@archiver.kernel.org>; Tue, 20 May 2025 19:35:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=b7WsdXD51rEbgPVVVzFusnt2jvQ8lxjJJ9pGsmzI7QA=; b=C7wQCO1Tv1t+4w5NHNeUK/b6/s
	heEdTu60Ql6L67/56/gt343CZwU3OEMngYmE393zzst5Ao4MsxKHb2CHiZWfYFKVDDVAS/1T5fBrU
	R7kzF69U1XmQ+2DxEvruUY5RMVMqrn1jjJnzD4B+dPFFVie2MHKXt4pr5mjl+RY+ohtFOBJp4PFIG
	uw9US3CyqRXhHjCmdZFf4EtPVTpxhaRFFWA1fCr0tPmJU2XDATwgfsDgYBzfZkRqu3iTGvq3D2xrx
	FAOsIlvj2BLSDPBZ+kaFBKFNHBzpB8Q8jq06bp5Wkrc1Wqewb5DyM9ib9x5o7Ysn/f2mU1WFb7GFK
	lpxYPjtQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uHSkB-0000000Dwit-06rj;
	Tue, 20 May 2025 19:35:19 +0000
Received: from mail-bn7nam10on2062a.outbound.protection.outlook.com ([2a01:111:f403:2009::62a] helo=NAM10-BN7-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uHSTe-0000000DuVp-2Be6
	for linux-nvme@lists.infradead.org;
	Tue, 20 May 2025 19:18:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PvEOSJ+kDxMlcGJt2341lKA2aPz0wUaLoPVIXRwYYZSvESAnHX1dKkUZxSCNwn1zUGYPh5V7oiTzw8zFWAdvDzrsPltm3uEFONgH8+GZXgEVQqSslFRB31RP1F91mgScTFrQZbLqdtgXhF7hsklrvnfdFwOuHpoVPt6iGrKkvjZcHMEoXP7b+BRg4VaEwAyMuvjOAgkk/yAh0rMIKFd0nvCbtfMOd6oRxBz0bXQAXGuOqoR2R2Kuh7RIh94LnZUjdBOhNS52ZXpoNBrGfg39CadMdwOqwdkTmZ7wdE2fUaKrLqld32wL15roE0MURG4lXgBNDol6CnCBT0h/02JLJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b7WsdXD51rEbgPVVVzFusnt2jvQ8lxjJJ9pGsmzI7QA=;
 b=KyJGCo/8FDGrpBUMZ8E0Pj0Aj/4fhnWxKxN+JX719ozJQPJNHahDwnLQMfgYM9poolaIXoQqIXvTOUNlv6t427rPmyx7gfaerNRqTkW4Fp+FMbvXIXSEyjWy9PdyOIX9y3n0Nh/9m+PoU5PP/GtDT3UqyPkoOUGe6HnpV8OJ0L4u33hJ1alfSppwC7zYWqWbAdwA40CdNNadm8qfXUas5NlA4iois1SwKAO6py947sFHfyFibPIk3tXXJMhgdpeC+7riEfJ8TX+0hUctkOIbkkhOc4Ycwxt5ZytN7IrcLCMH8Vogm80piTwyygn0u3w8GMoygOh6YDFRO40SeHnLxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b7WsdXD51rEbgPVVVzFusnt2jvQ8lxjJJ9pGsmzI7QA=;
 b=YJ58e4DohiRzZYCncw2SqhPnncDChLZhbG9ii08ix+HSdVk1rjbbf8SRb1cymixLYdXJbvYz+YbixWpIB9uTYw0H8dwnX1eQizdINCnHcvb4DNYMMiwth4FokEcK14VseUehqCl6Z59kebg1891fgaZjZtKJqek80TtErIgDpdii56Zlrxr1J/cuQ2xTJkdZ8zRjRjsYFhgrUGnwiPNpl1IdIa+tLKaV/Y4NeYHIhd7KiKHGSELGNbx2GsnfMBVFhp1FR+teJ7sgGingk8U8yI3cg74/CbXzmGR+nCItXZFYWGui3T9Xku6RnThtqQbGjhbUA/qvXDWeeEkl24DoHw==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by MN2PR12MB4342.namprd12.prod.outlook.com (2603:10b6:208:264::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.30; Tue, 20 May
 2025 19:18:08 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b%5]) with mapi id 15.20.8699.024; Tue, 20 May 2025
 19:18:08 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
CC: Christoph Hellwig <hch@lst.de>, Daniel Wagner <wagi@kernel.org>, Hannes
 Reinecke <hare@suse.de>
Subject: Re: [PATCH blktests 1/2] common/nvme: introduce
 _have_nvme_cli_with_json_support()
Thread-Topic: [PATCH blktests 1/2] common/nvme: introduce
 _have_nvme_cli_with_json_support()
Thread-Index: AQHbyU8QnPOfFG2AuUyDaVCFHPnmvbPb5TgA
Date: Tue, 20 May 2025 19:18:08 +0000
Message-ID: <97f436a0-f6aa-4093-85ee-79adef0311c2@nvidia.com>
References: <20250520061819.1148033-1-shinichiro.kawasaki@wdc.com>
 <20250520061819.1148033-2-shinichiro.kawasaki@wdc.com>
In-Reply-To: <20250520061819.1148033-2-shinichiro.kawasaki@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|MN2PR12MB4342:EE_
x-ms-office365-filtering-correlation-id: 86d2bd65-3cb7-42aa-33f3-08dd97d30ded
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|10070799003|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?ckNGNnRHRWVWaFdEcVBuenFoMmkxN1Z3VHJkRjVjMG9KUVBVcHJyb2drSFNu?=
 =?utf-8?B?TWsyOGl0Rm5MQzgyRGFyZEYrQ0RKaVhqelF0eVJ5VWI1SUJLTDJuR3c3MFJK?=
 =?utf-8?B?ZzZyZXVaOEZMZUFiMDdFWnhJSTc0a1IyampKcldPYWpGZlprM0EzYXFIUmtt?=
 =?utf-8?B?OUJXVk5MVFpRNG9selFMZHo3d09KOERPVjF6ZWFOOHJUVlhqTzFHSW1vdHdv?=
 =?utf-8?B?M05OSXYzZHhnbDdLTVpoTUZFUk0xMENnOCtRQW9Dd252dGdrcHNNM25IZFI0?=
 =?utf-8?B?MFpPTHRidG8rbE4weDE0Ly9vbTBiYU9UUzhhcUZHZHBxSzNrRk1CZHdOOEw3?=
 =?utf-8?B?YWtOSDZxekdLaEU1TDd4bUdLRDVCd0o1NlpxTU9iK0RxdHV1UDJQR0VKVU5r?=
 =?utf-8?B?OXpVdEs2OXBIekM4aGJYSzhNbDh1c2tpR2xKYlg2MHZKeEJnMCtOSlkzbVhp?=
 =?utf-8?B?RHVSVStLeGdFVStvaXhVRzdPUVlhZVVndHovM3dpcXFMZWVxNm96RE5mUkFQ?=
 =?utf-8?B?Y0NRb1VjbTZ6a1NKV0F3WjY5SEdhY0QyOW1wZzNiMjZETllVRGxVTEpNbEda?=
 =?utf-8?B?V3lGRXlsWFlzOFJDZHA3V1lKVmdKTFlwMzcycGZJK3F2L2pQd2tlbjBxUkFy?=
 =?utf-8?B?Z3prZkRraVZOeWxDaGVsbTFldnM2ZFRmZXMyckEya1JzNGZrK0laalVGc2J5?=
 =?utf-8?B?K2ZuTlBSaXFYVXd3bmhWMmpxaHZVS0hVckswL241S0FkaUoxVDRkTTlITzRw?=
 =?utf-8?B?V3d2WlRlcFlTcXZjN0w1SFo3Z1Y4UWxVbmR4RytCRkhRZ3Z3NXBGSzBYYm5X?=
 =?utf-8?B?M1NaUUhCMklCY3kwS2FMZloxWnMxaFFSbGdSeUlKbDlGU0FKZUhzT2FEMzdt?=
 =?utf-8?B?d2txTExQejNOZm1SM1RMOU45bU1tMDVhTERGZzlMRE5RWXVzRndzTFRRaEY3?=
 =?utf-8?B?am5UZ0ZwTnMvYTVTRFVkL2VDbkV5eHJlTVZQVlc4RVJnY2trOHAxaVUwRlRV?=
 =?utf-8?B?b3dVMklsTGZveFVsNXRMa3IrMHJ1K1QwQ2EybXp2WEp6ZFMrWjRFZklhS3dy?=
 =?utf-8?B?QlBjeFA0Y0s1eHNlVEVxdm5hOStWU0RWZENuS0Y3MVpuVThkN29VUjYzWisw?=
 =?utf-8?B?cFY2UW55ckxTQ3QyQ09LMVY2aEdPY2hvbGxHWjlNakdhcE1TRmIyZS9sNkQv?=
 =?utf-8?B?T1RzUmg4V0VYMnlITGF6ZXU1N1VMaHhJWmF1ckFRZy9BVks4TTM1Y3Ava1VL?=
 =?utf-8?B?YXVubGZTT2tmRGZOSXVZc3BrcHJpZHpvM29CNmpCQVc1VmZJdmhnY3ZRbWZC?=
 =?utf-8?B?Mjh5MTNBVTU0NjNQMEM3WWZ1a1d2VTE1emhmdjBBdXhwcFZzNTZPZXliTTRh?=
 =?utf-8?B?RTl2WUtYVm4xbWNQY3lmc1RKZUMvSlU0dkdneEZ3dHd0T0dabGNBcndMby9M?=
 =?utf-8?B?Mmk3dzhuR2RtdTIydzZtVFpTTVZpVGEvc0tSazJQK3hhSVFPenJxVWRsNnM4?=
 =?utf-8?B?S1pRUzhld3RRZCt6MEVxaVkzcUNucUorNTBDY0U5cWNQQjRBMlVIdGNTMk9r?=
 =?utf-8?B?d1p2UUZxNithcUNVTzcyT29KVU5qQ3I2eU1uREl2eWtyOTdjc0tPN1lrVnZD?=
 =?utf-8?B?NS8zbHkvUWhwYS96bkg2emxFZ2xKSkJybmdYaUkrL2lOTmpUckdRazd4N05i?=
 =?utf-8?B?RUlhQXQvbm04L0tRTmFOMjQvRE1kN1VCWXdmVVJiSVFRREFvQmQ2OEZ3SWE5?=
 =?utf-8?B?K1NiV1dyQ0VhaEJGUkIrdWZQUFJQOVREK0JDWmw3bGk0Y3ZqRnRFTEhwWU93?=
 =?utf-8?B?OHRyS3RZejgrWjc3U1pKN2hOSk1Lbk0ydzBaMkplcmFXR0NaOTFIUGNkS1Yr?=
 =?utf-8?B?QWk1ZHpJaE13K21aL21QK01OWTFlMUE5RFBrdy9IOTVlbFNDZTNESTE2M2JL?=
 =?utf-8?B?cVFScEtBaDhJd1EvRkgyNlFYRHRmRDBvMVBDeUtKMnE1S3UwdzRJNGtCRWdE?=
 =?utf-8?B?WVd4QzJ2SEF3PT0=?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cHFwK2VpenJFU1ZPY01VeUlnRWx6bGMvMWpRd0FxM1VpTnV0ZE8wcDh3dDJN?=
 =?utf-8?B?N3YvTXFzblJXbkdUaFJEZ3ErODYwRTRSY0RxNnQwSlVyZlFDUDJsSy80K29u?=
 =?utf-8?B?Ni9sRUprc29mdDE5aUJWbmNFUkVpVHRMazhRSGRJbzBCKzBKcUdJaHVUMGF1?=
 =?utf-8?B?czRTSVVpZ1RyNno3d0UzQkp4RWdsUXFVMWttM2pzd05ObzUra1VCWmY3bTVI?=
 =?utf-8?B?bFhtOVZ2S0h2UWJsb1YyQjNrcXpocXN6RXUzd1hUT1RKNEs4R0ZCTFZjQ20r?=
 =?utf-8?B?cEx4dXpYbXZoK1RkbjVDeHNBN2plMzNFeE56RjdtTXZJVlRBTXZnUmExVFVz?=
 =?utf-8?B?aHpoT1cvT2xKZ2JCVDlHL2J0a0hhOWpaTi9udzNPaXRRemVFVHY3MkxHTjBp?=
 =?utf-8?B?aHVKcGZTTjVER1lSTTJ6YmdTbDlzZE15bFR4U01QbGU0MGZDSmQxTjFnQUdD?=
 =?utf-8?B?YThCM3h3TmI5UUhwblZqbDlJNml5ay9USWFmSFNiTFlGNVRzQXZwVWttTU8w?=
 =?utf-8?B?djlDeEt4d2ZjWWhoMUVVVWNUTUdzU2phLzV1TEJXN0MzRENVODk5K2ZLc3Bl?=
 =?utf-8?B?Rmdkb3Q4bVYrTGJ1Q0NoVFFLYll2SWIxbnhKMmVuOSt2bE1XMkduWW43VDB6?=
 =?utf-8?B?QjhmcnQ1RGRLdWV6S01PSFU3cUJqdmJRakxpTEVlaVFDdER3YnRBNVNVL2VD?=
 =?utf-8?B?R3FKc0tRUXMvbzhhUnJnRVQrUUNORG5jeVB4a3FvY08yNUtiY3BFWmNTQjhF?=
 =?utf-8?B?eXd0WWgxZkY3dUcwaHB1TmdIS3VzUFZlVmlZQThCNG9UN3cvUEZ2bk00ZCtn?=
 =?utf-8?B?RThpTm92bkVNd2wvQUxJK1VUNUR1NGdkbW04R2dpNThGdWxoUzkwUEwwTjdj?=
 =?utf-8?B?ZTA5Vm9YMENZZGdCWkg2TzU2NkozR1J6NUZmNlNMQzB3U1MrelI1a2NiVkgv?=
 =?utf-8?B?K3M0a3J1Mjc0YmlhY0hOMnc3NlQwTE5ETFVhR0s1SVRDNzMrNE81L2pBSGwr?=
 =?utf-8?B?OTdxWm5WTzJFTlo4OTF1cnU2QURlVHZZYzkycnFNYWM0NDBjTnRRenA3Zjlj?=
 =?utf-8?B?V2dWdjNiV3FHbmZTTHlLUGhLc1YrRlR1Y0NuR1VheC8yUUdkNTViQWdmbnNR?=
 =?utf-8?B?Q0haZG0zM0htZ3o3c1JtUWQ0eHR2K1NEYzRSN0VSV1M4OVFjRHNDeEVFVjlR?=
 =?utf-8?B?UjlqQkppb21sd0tlaVExVGk4aVZEVXo0SWF0OU1CWWF4Mzg3UUJhT05GS0tt?=
 =?utf-8?B?Um1TVnQ1Z0tHWGZwK3pLNzNxcCtFekRTYzFuNmloK05FRm1iZjlGK3Nxdit4?=
 =?utf-8?B?ZXhLMGQ5cjdVdXJ1TzBScWVtOXZLSG4xM2dUZXZnTEFVaHl4TzJSMUNhTnVk?=
 =?utf-8?B?WUMybTdnWkpjbnhGM3VDNEx2ZUppeHpQcDIrdTBxVUxibHJ4dVBtMUZjdGNm?=
 =?utf-8?B?Y3B5Y21BZkJtNXNPRzVvZEJPUERqNFJteDRwS3MwSUtnd3I0S3JwL2FIbWVl?=
 =?utf-8?B?RmY5QkFNY05CZXF5T1ZuWlZJeTZZc3FoK1JxRkxzTzZRaE5SODVqeFNoWVNF?=
 =?utf-8?B?RUdjNy9taElpaGhpOVM1L29qSG5LTVhjWDZydUZtSWxrcGJZWlN3U1ByMkVL?=
 =?utf-8?B?T0lEL2JsQ2kvOVF1VGcycFp3ekxmQmdxemgyS0VYOXYrSnVodktyWXN6U2FD?=
 =?utf-8?B?Z0xqUXJJRDQwbG5MR2h5WmxXdXdpVWFuQUVBUFpvZ2t3ME1UNHRlZWg3bU14?=
 =?utf-8?B?cHdmeCtmUm40Nm9jbnVWSjVJTzlNN2hhaFFNU1pkRnYvb3hoa21MUGQ1aDFL?=
 =?utf-8?B?Z2wyamUxdWFUNmNkR1FWYzhyMjk1ckFUZlNuS3NlaHBWbUJQTy9GWThLVnpS?=
 =?utf-8?B?YmVhNjhqc3V0Y3hDTUJEbUVCaHBGWnVXeVZuVkgrME9ldnNYZmYrYjZZS09k?=
 =?utf-8?B?aE9nc2FiY2QwUU5KVUVSaUtuTUUvSFROanRjQVpxQXEzSzUzQzAvT0t1clB0?=
 =?utf-8?B?b20zZTdOR2ZSbWkvdWRNVzVDVFZZcG5XY1dBOTBON282ZTc5dW5WRndQZG9L?=
 =?utf-8?B?Z0pBMGlyTll2aXZ4L3JnejY3OXN1dE9qVmF5RmZlWC9mZ2NDSUlzTlFIbXQx?=
 =?utf-8?B?bFlsN1JYOTB0VDBJQ2JUSjdzVFg1TzFFZ1Q3YXN1dVFNZFpIWTNtSWFONFh3?=
 =?utf-8?Q?K0Fu55Tb9BWcjxwrOB5GWQSTabcxtVPQEKjLZbgbO/6o?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2A3F60C1009AAD4EAEC334FD5EC9B876@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9404.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86d2bd65-3cb7-42aa-33f3-08dd97d30ded
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 May 2025 19:18:08.3854
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Xl4bCykQibbDJArbZLt+EJ0yHAvo1N88jW0RTNBQx0FCvZfW0hmEc+iP9m15d8EUcXc0Q0LHwFIyNEPJQxXdKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4342
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250520_121814_560788_F1FEC1FB 
X-CRM114-Status: UNSURE (   8.88  )
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

T24gNS8xOS8yNSAyMzoxOCwgU2hpbidpY2hpcm8gS2F3YXNha2kgd3JvdGU6DQo+IFRvIGNoZWNr
IGlmIHRoZSBudm1lIGNvbW1hbmQgc3VwcG9ydHMganNvbiBvdXRwdXQgZm9ybWF0LCBpbnRyb2R1
Y2UgdGhlDQo+IGhlbHBlciBmdW5jdGlvbiBfaGF2ZV9udm1lX2NsaV93aXRoX2pzb25fc3VwcG9y
dCgpLCB3aGljaCB2ZXJpZmllcyB0aGUNCj4gb3B0aW9uICItLW91dHB1dC1mb3JtYXQ9IiB3b3Jr
cy4gV2hpbGUgYXQgaXQsIHJlcGxhY2UgdGhlIHNob3J0IG9wdGlvbg0KPiAiLW8iIGluIF9udm1l
X2Nvbm5lY3Rfc3Vic3lzKCkgd2l0aCB0aGUgbG9uZyBvcHRpb24gIi0tb3V0cHV0LWZvcm1hdD0i
Lg0KPg0KPiBTaWduZWQtb2ZmLWJ5OiBTaGluJ2ljaGlybyBLYXdhc2FraSA8c2hpbmljaGlyby5r
YXdhc2FraUB3ZGMuY29tPg0KPiAtLS0NCj4NCg0KTG9va3MgZ29vZC4NCg0KUmV2aWV3ZWQtYnk6
IENoYWl0YW55YSBLdWxrYXJuaSA8a2NoQG52aWRpYS5jb20+DQoNCi1jaw0KDQoNCg==

