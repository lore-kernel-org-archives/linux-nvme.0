Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2762C25B75
	for <linux-nvme@archiver.kernel.org>; Wed, 29 May 2024 19:18:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=FwawB4DTK5CR9dDXHWUrwqJFxlnui0xJ0je3nN7MYcs=; b=W99p9Kqe3Ra5XtKikuZ0sXCaBW
	baICZHmXHWuM/tQImx1VDQrRRr2eY37DOmvaJRgGTWqBy6yxiE3ug8vuarGxj5Etox7YWIBwpIv6q
	X5U/4IE/ZKQok2cNwj0D+J5loT8tBfMPgkkXxQOwkVAqyUB9WrEqHEfnRPBjbj4iIV0uRIO+LGK6K
	oPdR3hvX7s0bt1m7GgobqaRYua22nRKeSaphmqyOeKgMT5x5jbrOtVV7L0dapSy8+Dc4OAKa/U1Xy
	2179DW7nbsxFPDDByBZyFtp7fnjSFY1agOA6Ye2jOt0Me5/xiTNMLk9M7EBB35fPwcgR/Qlf1fh74
	x1YuvwkQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sCOoy-00000005KGK-1f8E;
	Wed, 29 May 2024 19:18:48 +0000
Received: from mail-dm6nam12on20600.outbound.protection.outlook.com ([2a01:111:f403:2417::600] helo=NAM12-DM6-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sCOot-00000005KFp-3VwK
	for linux-nvme@lists.infradead.org;
	Wed, 29 May 2024 19:18:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XSTmedaWjZx/5k9cmdL5004UykvIcd2gAV6+liuqyt8YmVJPw8XEYw6uXUTXb0/TIpVAnMcnUF8fVjPXd26RWgbJZZpP4OjifIB++VMwQNu9iiFpPsPeuIRg2CudEl5TTHqUY9doZFBwkuQi2DQlbVEOXbCXtRvUh++84/tS/2OhMo5uEb8Wv7mvUPpQ+SnuV8K8/p3oS2c74GWJR9YFTvwv1oA0MN6pqwBGrN/KaBheXJrvQ9KJ4rMcMsoFXnFu/XuN/vHeXYu8BJo5EdDYlQaeWqoiYi1uuPyIGsnRV63ky60Pl8KtfYlwdbNzIgciN9V2PbN+Wj0P5dmOIQg2aA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FwawB4DTK5CR9dDXHWUrwqJFxlnui0xJ0je3nN7MYcs=;
 b=hRvdpNYGJoSvL/bmk4UZKJMf/LCkc5+swcB3Q06ESwgW9MyoborUcW2PAEb0x44v1CgT3b1qtZ8T23voKX5zBm8Ej/zPM9HQxWSg+TmKoZRgJCGtYpa3sZLH73bGJo2kVK1TC8pyE5o0zzNX1xU/UJ6WUrkLNrePtDNY/VWIrPP2FMVP3HBDUTTIO0hE7ZbUaOlFifRgi30lrIXk4nZ1uU0Qlv1PMX6JdBZYucznVUDZGROAamVQyvkpgsz/RYgcVThT7Og+BhPvsYU7D2lp+YOiiFNpyP5OUrHjya5F1AALyouIi0ESz48ACd0SBZwJYZI2MX1k5QElaR1YcqbX6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FwawB4DTK5CR9dDXHWUrwqJFxlnui0xJ0je3nN7MYcs=;
 b=hnGaBOBf63x+PQLcIc2cuP7zkLNwlNR3ZvCcBrJL/bb8hnKsItYJJJaHbqr7oVchO9Ctsw0X5ZKQ2HfN6J5u6tGwyq87Bifv2LDzuwkZ7qNB+4i1meSMoejFFqawgcBm0KxebkECtobStdzoynofvEsOt1sAOndkZQ60nxDNiSjT3nBgofnWrtosnUuflRXr2TzGTU7XuLm8oq+4xIuitamuzwgw3UFBuTT2hCB//gWdkoZgL0Zqg3qeJfOMB2xQ84SS65M8c1SsTuc9JgId2jTukYPOv2OCP3RRTjymFUPAF523MiZkms/bkN3CJjzJ5RsfarZA1xCy+ew57juGcg==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by SA1PR12MB7343.namprd12.prod.outlook.com (2603:10b6:806:2b5::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.30; Wed, 29 May
 2024 19:18:37 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b%4]) with mapi id 15.20.7611.016; Wed, 29 May 2024
 19:18:36 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Weiwen Hu <huweiwen@linux.alibaba.com>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>
CC: Mike Christie <michael.christie@oracle.com>, Christoph Hellwig
	<hch@lst.de>
Subject: Re: [PATCH 1/3] nvme: fix nvme_pr_* status code parsing
Thread-Topic: [PATCH 1/3] nvme: fix nvme_pr_* status code parsing
Thread-Index: AQHascMsgMyV03Sfy0qcY6Ias6u6/rGulnsA
Date: Wed, 29 May 2024 19:18:36 +0000
Message-ID: <d5cdd059-cf7a-4465-8712-7814fe41f9b8@nvidia.com>
References: <20240529122300.92377-1-huweiwen@linux.alibaba.com>
 <20240529122300.92377-2-huweiwen@linux.alibaba.com>
In-Reply-To: <20240529122300.92377-2-huweiwen@linux.alibaba.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|SA1PR12MB7343:EE_
x-ms-office365-filtering-correlation-id: 1df6f33f-c9c7-41ff-219c-08dc801423d9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|376005|366007|1800799015|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?NUhnWm9mbWRjZVhzRHhyQmFONzNMU3lCSXhydmJMb3QvQlN6OXQwS1MvSU1B?=
 =?utf-8?B?M21ydzVaK3JCTEFuM0taVzFPZGZNSTJNZlBmZFcyWlVKaVpIZ2JCQjh4TFdN?=
 =?utf-8?B?enFvUXRic0RZN0xJVFlqckRpR041dDBQSzZYcE41RytaT3pjbVhBSGtFQlRF?=
 =?utf-8?B?ZzVlVUt6YjUrdFRiM2RwTm1JcVpzaFQ0UFpjY1hWSTBBS3ZVaVhaMnpkZFpZ?=
 =?utf-8?B?anlRcWF5TlhOVkU4SjczWHNveWZacE5iTktqKytjamdhWmN0QXh1dlVSVkNx?=
 =?utf-8?B?V01ZREcySi81ZHp5YWJrK2tHTFJVcXJ2ZE1BeTBWVHRQM0VCVDNiVHl4MHV0?=
 =?utf-8?B?WUNJdGtsS2s1NitqK2ZWL0cwY290Wnc4cy9KVldGSUgvT0g0UXVkZXAxSmQy?=
 =?utf-8?B?U0hJcG5DcXgyZmhET3ZMVXYrNVhDbXhOeGZSdlMrbldBVVNPMVBrRDJKK2NN?=
 =?utf-8?B?Q1c2ZkVMb2IraWpzaU40MzhuMnVkWHVlYlJTcy9VZG5ZMk1xaW9lbENKMGs4?=
 =?utf-8?B?Q1h2S2hJSlZQdTlLWEMySlZRUWhzelFONnZZK0NaTGx4dW9FaERWYzE5VE9X?=
 =?utf-8?B?dzZrOUt2dG92MW5zWUhib1lQSS9TSGI5N0xIVTBkc0o2djRjei9ESVRxVEpp?=
 =?utf-8?B?ajdvcy8ydHVVbEFDajlhMHRVVk5jSUdZa2VSV3AzRENydTBVQm9DRklldFBY?=
 =?utf-8?B?QWd2Mk1vNDM3RG50d25jVmdiLzdRUzFxNEhLemhzYlVkcDZBQ2xEK3RBanBK?=
 =?utf-8?B?WnV4UzFrUGt6NHJHbGZsVVlvdnlwcTRubGRseU12UldTMEhvSkNvd3p1eEVM?=
 =?utf-8?B?Mm9jUUdGUU9VcUI5bTB3TjJiUG9HWklBYnZNYU94YW1UdVQyU2pzdjRiZ0pt?=
 =?utf-8?B?OW9YclYzTEFYNm50b0pBMXVyNnBkVTY4Z29VZkxRaFZ6QXdBQ0VVaFpNRWdM?=
 =?utf-8?B?WXJoYy9wNVM4SFcycXJNcnlnMjUzS1dqS21yZ2NKcVlVVlNNSDQzaTZrQnFI?=
 =?utf-8?B?QllaS0xzT0FwTmJVK1BmamJmZlNxZzNPNWhtd2lLSVBadW1pZXBCT1EvWWg4?=
 =?utf-8?B?SnM3bXYza25vQWRVZkk4c1M3cXNlaSs3Rm8zYlNXUm1oRWdRL1BQUTlRMDZJ?=
 =?utf-8?B?VlYzRmw2Q2hlRHJzbUsrVVNKejlGa29PWUwyNHdiNUR2NGRUL1N6Uk45K0dN?=
 =?utf-8?B?REtQOGl0MVlFQ0xod1pWL3NOelpFc2FDd2JuUDRxM1pDbVVHTFZyRk02eGsy?=
 =?utf-8?B?bHVFZ2grUi82WjB4UWhUTnJvUHFPQXdaTUk2KzRXL2Y2MFhlWUw5cW1ic3Vr?=
 =?utf-8?B?Z2JFLzhSM2NNR0d2R1NDMTRZbklKTmpRWEZQZjFBUWNuMWpSenJTRTZSSmJ1?=
 =?utf-8?B?SmkrK0NUVVFVNzFqU0M0YVJEWFFqUHlSZ3hCS016cFVwd21pQWtNcVNGdUln?=
 =?utf-8?B?anF1S2t3U1lCcHgvVnRyREZCYW9UcmhybWlzaUNlcjBURUlxVjJpVnd1WC94?=
 =?utf-8?B?dVpLeGhFSE5kclR4ZEhpVDhXbFJTM1g1QnRybWFNN3NSSThSWlhoSEpFREVy?=
 =?utf-8?B?UzJEekJycFFYby8zRGFtUXJhb0R6TlhFWmFFNTlYUlpXWGhGcy9Td0IxZEpx?=
 =?utf-8?B?cTBOc2FhMy9YWDVDaytYTzl3UXhaeTF3VG8yS0k4cVNGNDZIT1ZnVUo2cnpI?=
 =?utf-8?B?ai9xVHhnNDdUUDFqUTFiSU5zWC9GL1NkMTllNEY2SUNkaWNIK2hiZTdyN2Uy?=
 =?utf-8?B?TDVZblROZSswbXNBZzdlS0lzU3UzeHlla3pBK0ZDZDhzUEdNb1NLNGE2c3pt?=
 =?utf-8?B?dllZRWU3WWMyYlNSdTRKZz09?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?U21zbzVrbkp1bU1hZ0Z0Y0hUR2t6TGNWbUxZM1ROSUtIUVMrUkR6R0dzNjli?=
 =?utf-8?B?R0VRL1BXSWxUZEk3RnZTZTBXVUpSUlNhZDNoYk03by9lRTJYdk9qLzBVSGpy?=
 =?utf-8?B?dFZJeEJlYXAxaUNxSkh1bWxabmw5VDY1ZVE4dDM0aWllZDMxOWxXaG5pMURy?=
 =?utf-8?B?RHJjWlRsWm8yWUNwVTkwVEdNaVVnZG16Z2JLTmFVc1JjdXBOa0djVGpqeHZS?=
 =?utf-8?B?N0wzcFo3RkZraTJGZHBocjk5Qmd2NnpSV3I5K3dteVFwaTRFSkNlZGtQcDRw?=
 =?utf-8?B?WTdmNVh0SFViTEt1Nko1VVN0NUtYYWduR05EdEprQnYvNDJ1ZnNwNWllWmp1?=
 =?utf-8?B?QmZjdW5UL3ZMY2dwbmZoTTR2elJUR0M1cllTbDRlclpBT0V1U3RwSm1vSTh3?=
 =?utf-8?B?ZytSV2FFbkdOWFJmWk1XMVZpVWIwQlg1L2NrcDNMT09RWjdkMzRSSC9Cdkhm?=
 =?utf-8?B?R3J2RU5iV1lORkRUSlA5bEYra3lNb2xvTm5LdlJSVHB6V2FkV0RUbWcvV0lV?=
 =?utf-8?B?dVF6SHNTUlhQNGQrdU5XdkFncEtnekQrZUFaSlpsU1pWcU5RSmMyOEk4aVFO?=
 =?utf-8?B?YWIyZUZNWFlVWnFxM1M2WUo4UVVGRXZ2a1FYaTUwUmJhU1RlYW80K0pyUzkx?=
 =?utf-8?B?R1VFeTdaSmVESVV6QTJ4RFBFREwvei9wWWVEaWVRSGl4K09tUURMWC9IUVIz?=
 =?utf-8?B?T01BRm9ySGcrb2orZkIrYlcybVlldXFNVktvdjRvb0piaktGcHk2TldNMTBZ?=
 =?utf-8?B?S0NSd0tuclNURS9RdlkyYldrQ2xQRjVMZkorSEVyR3hJZDdmNXppZzJzUUp0?=
 =?utf-8?B?VExmV2lEUXpnbWNqbjBLRG16TlNzRlpWSXdVVFEwMXFYY3U2Q3ErZVNGUkcr?=
 =?utf-8?B?Y2JxdkJsK1h3aDR3bTE4T2taNkxOYU1GZnExaHVQK2p2Wm10Q3dkZm9KOWRR?=
 =?utf-8?B?ZXAxUzlnNVpPZFVrRmZWSE1NamFocms5eHFTcWJKNkJPTk1lSDhXeURCekRu?=
 =?utf-8?B?YXJkeHUrc1BVanVsVWpYM3dSb2FYeU1EUUZWTWdwYURjTzBiV0MvUnloZ3hV?=
 =?utf-8?B?K2tkcDc3cjF5c0NENU96Ujc5dkR1dUtXd01qQTExSVVzcE9FQ05qaGRRZnFi?=
 =?utf-8?B?MzVqMlY0RmdYb0lVRVY4cDRJSHphVjFhKzNvZlpxVGNUakpCK1lLRlJRem1B?=
 =?utf-8?B?alZXSFRsNjJaSGJsbDR3ejBETzR5OW9uK2wwSGJUR0dRZkFIMDRTc3FGMHBH?=
 =?utf-8?B?TXhWLzJ3d2tncUpRSmVzV2RrcFFWSks5WnBZd1o2VmJub3V1VGc2UmNYVHYr?=
 =?utf-8?B?RGhFbHVFcHlONkNNb1JHSmIyWU9nNlR0S25wTVBuUXFkZG9DRDVZeGIxdGFq?=
 =?utf-8?B?cThLTXRKYWJ1alNzTThwZlZOdnBsRk1uQzdpa1dDNjdTZHRkR1EzbWpEK25l?=
 =?utf-8?B?VzI3Vk5OSHRvcTUvRXRJWlNQbklNZXBub1VwdVd4VUdnMms4SFQ0TEM4KzUx?=
 =?utf-8?B?UDMrUFVHK1FYd1FERWMvTGw1UnQyK0RIRkpyTnd4UGdQeDZxZFRVczB0cWY4?=
 =?utf-8?B?SjExaWc4L1BZalNSUEJjUzJFVkptSFJuT05MVElTNWtFUDQzL3JLVmRoTEpW?=
 =?utf-8?B?N3p6MkNnWDFCRkd1NGlCS3NoWUdBUmtHWmJ6Vjh5UERWbmFzYTBBNVVpN1du?=
 =?utf-8?B?eHA1SDRjdzFYNHpnUVcwVUZyUkFDME5EV3JDZ3BRVUQyV0x5em5taGtvTFRv?=
 =?utf-8?B?TnFxZzZmZjIxSS9McmVtYmZPRExNOStDMDFibFVxd2t4UkgwK1JxOXdpY0t1?=
 =?utf-8?B?dWljTmxOemU1SExKVjVPYW9lWGRaVFJrczc1WmN0RURiT3FVcmQ5dWR0RUNN?=
 =?utf-8?B?UitPbXJQVmg1S0x1UHBaZnVnejA2cFZYaXFMK2EvbTNFMHRKR3h6R3EvM0t6?=
 =?utf-8?B?TUVCTEFUbEdnUG10c01aRk9GUXV3Rk5IUFJTeDA4MkwvOEZnU3FOYTMveTlp?=
 =?utf-8?B?VGN3bTFWV1plU1RiTEdTb1ZLMVk2RTFiV1BSbGZaSnRNaFpxMWppMmdLSUEw?=
 =?utf-8?B?VWtiTlIyejI3bVZuV29jeEZEaHpYZ2srSTExdmE4REd1TDU0d0xkeWxpSS8x?=
 =?utf-8?B?emZyYVVoUEZLVzQyNzQrdzFYL09yenlRaTBCb0pqUEJkbXhDWnkyS3NTL0py?=
 =?utf-8?Q?X6/RRW1zfUyceYxndcMp1fIt8ZeLhy5zYjcBWbb+4zeD?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5523D1436A467846ABDBBB17E8B5A250@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9404.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1df6f33f-c9c7-41ff-219c-08dc801423d9
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 May 2024 19:18:36.8466
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qAsX8GuwbwRkFlSzW4O2Vrtl/Gk7JiTnwW4l5HmDW6Uea8LJinfc3CCwEkFu4ONS0fZGR35CdSINPTgu3uI17Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7343
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240529_121843_952099_8E69067D 
X-CRM114-Status: GOOD (  17.84  )
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

T24gNS8yOS8yNCAwNToyMiwgV2Vpd2VuIEh1IHdyb3RlOg0KPiBGaXggdGhlIHBhcnNpbmcgaWYg
ZXh0cmEgc3RhdHVzIGJpdHMgKGUuZy4gTU9SRSkgaXMgcHJlc2VudC4NCj4NCj4gUmVuYW1lZCBu
dm1lX3NjX3RvX3ByX2VyciB0byBudm1lX3N0YXR1c190b19wcl9lcnIgdG8gYmV0dGVyIG1hdGNo
IGl0cw0KPiBzZW1hbnRpYy4NCj4NCj4gRml4ZXM6IDdmYjQyNzgwZDA2YyAoIm52bWU6IENvbnZl
cnQgTlZNZSBlcnJvcnMgdG8gUFIgZXJyb3JzIikNCj4gU2lnbmVkLW9mZi1ieTogV2Vpd2VuIEh1
IDxodXdlaXdlbkBsaW51eC5hbGliYWJhLmNvbT4NCj4gLS0tDQo+ICAgZHJpdmVycy9udm1lL2hv
c3QvcHIuYyB8IDEwICsrKysrLS0tLS0NCj4gICAxIGZpbGUgY2hhbmdlZCwgNSBpbnNlcnRpb25z
KCspLCA1IGRlbGV0aW9ucygtKQ0KPg0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9udm1lL2hvc3Qv
cHIuYyBiL2RyaXZlcnMvbnZtZS9ob3N0L3ByLmMNCj4gaW5kZXggZTA1NTcxYjJhMWIwLi4yNWUy
M2NkYmExNTEgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvbnZtZS9ob3N0L3ByLmMNCj4gKysrIGIv
ZHJpdmVycy9udm1lL2hvc3QvcHIuYw0KPiBAQCAtNzIsMTIgKzcyLDEyIEBAIHN0YXRpYyBpbnQg
bnZtZV9zZW5kX25zX3ByX2NvbW1hbmQoc3RydWN0IG52bWVfbnMgKm5zLCBzdHJ1Y3QgbnZtZV9j
b21tYW5kICpjLA0KPiAgIAlyZXR1cm4gbnZtZV9zdWJtaXRfc3luY19jbWQobnMtPnF1ZXVlLCBj
LCBkYXRhLCBkYXRhX2xlbik7DQo+ICAgfQ0KPiAgIA0KPiAtc3RhdGljIGludCBudm1lX3NjX3Rv
X3ByX2VycihpbnQgbnZtZV9zYykNCj4gK3N0YXRpYyBpbnQgbnZtZV9zdGF0dXNfdG9fcHJfZXJy
KGludCBudm1lX3N0YXR1cykNCg0KZG8geW91IHJlYWxseSBoYXZlIHRvIG1ha2UgdGhpcyBoZWxw
ZXIgbmFtZSBsb25nZXIgPw0KbnZtZV9zYyBtYXRjaGVzIHRoZSBOVk1FX1NDIGFuZCBtYWtlcyBp
dCBlYXN5IHRvIGdyZXAgd2hlbg0KbG9va2luZyBmb3Igc3ltYm9scyBhbmQgZXJyb3IgY29kZXMs
IGJ1dCBpZiBldmVyeW9uZSBpcyBva2F5IHdpdGgNCnRoaXMgdGhlbiBzdXJlIGdvIGFoZWFkIC4u
Lg0KPiAgIHsNCj4gLQlpZiAobnZtZV9pc19wYXRoX2Vycm9yKG52bWVfc2MpKQ0KPiArCWlmIChu
dm1lX2lzX3BhdGhfZXJyb3IobnZtZV9zdGF0dXMpKQ0KPiAgIAkJcmV0dXJuIFBSX1NUU19QQVRI
X0ZBSUxFRDsNCj4gICANCj4gLQlzd2l0Y2ggKG52bWVfc2MpIHsNCj4gKwlzd2l0Y2ggKG52bWVf
c3RhdHVzICYgMHg3ZmYpIHsNCj4gICAJY2FzZSBOVk1FX1NDX1NVQ0NFU1M6DQo+ICAgCQlyZXR1
cm4gUFJfU1RTX1NVQ0NFU1M7DQo+ICAgCWNhc2UgTlZNRV9TQ19SRVNFUlZBVElPTl9DT05GTElD
VDoNCj4NCg0KLWNrDQoNCg0K

