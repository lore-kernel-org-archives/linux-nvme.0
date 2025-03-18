Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28E1AC28B30
	for <linux-nvme@archiver.kernel.org>; Tue, 18 Mar 2025 02:58:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+Zr6JAYz6cPONXdgkbikg2+C+EFi3FuXrC3xj88Avxw=; b=a7ZW600Vlj2OQXeqeA/VEQqMZJ
	Cp7/ZN4XGJXlNsd4fT8P/1kDJXIRRJ6viOMx2TMUHB2y999m1tDqjl8tbf+maQFBo/VOJFc2A4utX
	2NjPEouN+wNSRWGpYzSOu+f2sEzyF93s5cdwErFSBcXbMFvOW80Md387lSIZ2HPoKU9LCXtYnlqk2
	rNgjLXbfvabzGfcDFBUCUSrn7vqqlw3b0l90FKPGhqlgw+cjkj0xzU79mEx1SHXyZH4YG4PKsYsnB
	zyreJ1raiSI0c7fUksNJOW/LGyS5RFvggCDOnrsCHFD1+nUbt2Oo/uiUa5EJU3+SQ00ubsIaWbCWD
	E9zufUdw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tuN9f-00000004SV6-0lqB;
	Tue, 18 Mar 2025 02:58:11 +0000
Received: from mail-mw2nam04on20628.outbound.protection.outlook.com ([2a01:111:f403:240a::628] helo=NAM04-MW2-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tuN9c-00000004SUA-34GB
	for linux-nvme@lists.infradead.org;
	Tue, 18 Mar 2025 02:58:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T15qlK6odg6r7JFSPMYl4uoZ8RkrsjEh85uHvilauO+X2659Kq4bfQ2byOp6n3aJnbRecmNtxua1PhPiCLrJ/PxcgWu3xffyoQpiwAFUDrz8rjiLHGkWdpLKwyTuKN3xbvD6WuIrP32rFBoHPN48v6IiH8x8/dtX1ufIWHrt1Vid3KOuvOPeXfxDxfSUevF6WI5SJIxsb4BYMJFWOOqeZ0iuwHeFgofQqy2lSUo9U6nk4Q0WjmPjjv56vdoxY1XxbfeIaJoAdOrvdOt01TaaeocYe81wwbOVvdx0YVSlFbd+raSyzzTHOUabCDHH4sx2kljtD9LCsKupGm+U0AfYuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+Zr6JAYz6cPONXdgkbikg2+C+EFi3FuXrC3xj88Avxw=;
 b=ZFYTcHy5CeqTj2bimCYRNlpbzef6CdPKJcPZgNWiykCxxceX3g63eqRTOzG7UwxmzJoXXq54P2VeR+I9ujrfwHTA4Qyo3v+T05+ORBZL5O/GchXjFOzxnN2VOKJIvu23NVajNlO2lfX9axrkJPyIXxVeHG8CsMSi5XNwA3vPdp053ix+IudIsCQDysC8zZi32+6zM+V2MyGPKC7OMVSNZwLjPMAojcIVpj95cWVAAWNE+5SL1MVfKlFlSJF1/SLgLZj48dTmRZL3IKCYh0hTk8b1lHKX0wdiXQsdxwyy11r8IL00wVbc7TN5/0PxUcVTllnrO407iMjpmjUTZiOgvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+Zr6JAYz6cPONXdgkbikg2+C+EFi3FuXrC3xj88Avxw=;
 b=Bj2R56GTDLcqFdZHWeVkyB/uoivKVWxMIV5S+TbSdzdhC3Jlg2fHi31vbQKs3XDj5AGoRc9KhPK70aA4g+wUIezgpyHXsB8TBJGzdjicMbkAbsVdasaoQqh5R4JiNYOqcvzpY/QWN5rc9H1S5n0VuoQLG8q4LNWA2v8eSGdnX4iohNbrEofNXXZPT8UaBw4jYIpVQ8ukfFGnUlLSek0+DlB/6Y5b5dpp1Tmuh/ah+7VgM5yYq5feYRJze4VLigy5/qHbzr97pXur227EjqcdG77EzchDtyUTZPpgOBvz8xVFP1933AItX7lKoiuwtuUABDDIHRmFoRf892Hb5QyBNA==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by CH2PR12MB4182.namprd12.prod.outlook.com (2603:10b6:610:ae::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.22; Tue, 18 Mar
 2025 02:57:54 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b%5]) with mapi id 15.20.8534.031; Tue, 18 Mar 2025
 02:57:54 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: "shao.mingyin@zte.com.cn" <shao.mingyin@zte.com.cn>
CC: "sagi@grimberg.me" <sagi@grimberg.me>, Chaitanya Kulkarni
	<chaitanyak@nvidia.com>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "yang.tao172@zte.com.cn"
	<yang.tao172@zte.com.cn>, "yang.yang29@zte.com.cn" <yang.yang29@zte.com.cn>,
	"hch@lst.de" <hch@lst.de>, "xu.xin16@zte.com.cn" <xu.xin16@zte.com.cn>
Subject: Re: [PATCH] nvme: replace max(a, min(b, c)) by clamp(b, a, c)
Thread-Topic: [PATCH] nvme: replace max(a, min(b, c)) by clamp(b, a, c)
Thread-Index: AQHblw+2lCHLSNBAzkKyrBWYpSn6qrN4NPcA
Date: Tue, 18 Mar 2025 02:57:54 +0000
Message-ID: <6e303964-e34f-4ee7-82c3-5c45e7472e72@nvidia.com>
References: <20250317153909901uOL4saBkASEN9kOmQXDoP@zte.com.cn>
In-Reply-To: <20250317153909901uOL4saBkASEN9kOmQXDoP@zte.com.cn>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|CH2PR12MB4182:EE_
x-ms-office365-filtering-correlation-id: 745ce913-c14e-421a-9fe6-08dd65c8ae37
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018|7053199007;
x-microsoft-antispam-message-info: =?utf-8?B?U1oyQUhCTDY3REUzdHNrSzUyRWlWUTdmaEpvMWdjWHZ4UWNsblArclRMbWRB?=
 =?utf-8?B?bVlveCthZnBCT3pKS0pYREw4S0w1WFpUMFBwQTdtNlhqaTF0U1RVcGJlNFVH?=
 =?utf-8?B?ZUJpWEdWMzZ2dXhBenc4ck1CejU0TmhQb2tHTGdxNGYrdi9udm80SXI0R212?=
 =?utf-8?B?VkFNd2dueEtzR2FGU1l3NmNieTkyZ0lOZkFQV2I5WDVPRWt3T2tqc3FvVUpK?=
 =?utf-8?B?UHFyMmd5RmN0YXFXU2VESlh3a01oVW5BQnpGbWRva3RFYko5ekh5UThYRVgr?=
 =?utf-8?B?K1pIa2xHc2poSk9wMVVkSHd4Umd1OXVTQkZlN0JQM3VIQlVqNkNseEtKQk1O?=
 =?utf-8?B?MzVEdG5ReS8zZFF1Z2VwaHRpdVhVb1lUay9SajFHdDVpdWtteGlqSzI3dEx4?=
 =?utf-8?B?WXFuMFBDYlVrNCtobmZpUktEVUdHbmowdGhucElBdVMvODd0YkwyVTBMT0NC?=
 =?utf-8?B?SzEvVkhQbWtkZmNoSVYwVWlrS3hSS3BjVEVES040V2pxWXdBUy9uNUdEVk9p?=
 =?utf-8?B?VnJ3ZWpPai9XWjdIajAyUGVEVmNudU5BUXloemJwaFVSNC81MXRTN3Ywblpx?=
 =?utf-8?B?MEZhZzgzUU1BWlpLMnBPV1BIN1dFNXlkekhCUU43L2VMaklyYTlOdXZpSE1M?=
 =?utf-8?B?T1htWWwzTXNOTmJpRkVEMGpJYVB5TlhVdGFrclJQTFM3TzJ4bmZmTmN5VHc3?=
 =?utf-8?B?ZjRuRHhmVnBTV0FKeDNDeklWYzQweVhla05sSG1GZ3JwbnNSV1hnUGpKc0c0?=
 =?utf-8?B?THBXK3NYbkZqZFB5c2w2SjJwWmVnNnZ1ZnhTSUZqeXJwaExGWlRCSnJjL2M1?=
 =?utf-8?B?VjN3TUR0ZkU5Y2xQeUFMeDRTMUpKcG5PaHVWTTR0UEU3SEVFUW9PZ1BwZW5Q?=
 =?utf-8?B?d08zSUZSaEVGcmJnUmhUeG9uS3NOcnBUMEdsOVdJSjlqWGlkcTcxbjBoNzJp?=
 =?utf-8?B?NUs1RGZBOU1xeml3R3h4VGpMQVFWVjA5a3dRdFdIQzV1VU1hZXJ4dENyZjVY?=
 =?utf-8?B?ZXpXNFdHRDZOWlNmRk1KYWVVayt1ek12N05aNEsxUkdmNndEcXd1TTYybVl6?=
 =?utf-8?B?bHRRS1lZM3o3TzMxNmphT1FZUHFOVWxza2dyNHBheVVKVktOenFHb1ZTNTBj?=
 =?utf-8?B?VGVwYXhjeVIrRXY4Ris5M29qZTk3TFVRZ3FzT3dBZ2JrenBFOXVwTE5CeXVn?=
 =?utf-8?B?cDRKR2Yvcm1TckVUbTYyTGxNSTdEYWZ3SFRZNkY4Z0FueDJpd1MrTEFIQ0wv?=
 =?utf-8?B?ZGR2TEZ5WHhwM2dsYXozdHZYMGhhbHVyMmRJWWZnMWN3aTJoakwyOWZiQ0F6?=
 =?utf-8?B?UjNla0VUY3Nzd3NMV3Y3UE9tR1JBclJyajNOTlpIb3RJTy9IRFdOSnFkTjJ6?=
 =?utf-8?B?ZGJ5enExQ0pTZG01YUx1MHNYYUNST2tRaEU3U0VEZ2R5NlRnOVZQZkgrMGQ0?=
 =?utf-8?B?WVRHbS9pWFl1MVA0aWxQWXNJVC9abTRBb3hacXp1TG1Ed2VZM1BIeEZEWWNr?=
 =?utf-8?B?YXNNaWxmbkNIaG9ZclNUUWZGbjlHbXhBUEdvODhTdVZMSk1MMUMrakdkcUd4?=
 =?utf-8?B?SUQrR1JlcXJPVjI2K2NTZllqS2U0UVp1d2JrQ3R5TWdieTVsWjFKazZLR043?=
 =?utf-8?B?RXY2TUViQytvb0hWUXNzN3grQ1ppWjdJcDJwOFhvRHNWTHJyNjJENEU2Skp4?=
 =?utf-8?B?Q1o2Z3M0T2R4cTFUOW04bVdPRzBsNnlSTFlENmh6YUdJcmV3UXYzcEZ1YXRa?=
 =?utf-8?B?dENIQjlHRTBtcFlndStvVnZJMEdUZ2ZQLzVMeUk2WXUwNFBkcW1tOEVMck5p?=
 =?utf-8?B?U1pGTjd6RmMzL09vVzhic0tHQThqRVNKMlpVc015Ymx5UitVcUNMSUlSdkM5?=
 =?utf-8?B?dURJenJKWkI2Rk8xRzY4MzkvSUlESXlSUEdlVEIxYjlCdytwbUhwVjN3M1RR?=
 =?utf-8?Q?Xx6efBtGrzCqXv2uzorVv//EqWSTpT3C?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018)(7053199007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RkhPQnJiM2tmZE1HOTRsaXcvQUxBcldqcUJHQjByWVNnUWkrWG5ROUlCZjg2?=
 =?utf-8?B?OFVJWUpJSDA5QTFMOHg4T3dTYi9DdG9oSFVXaDBEYkNNNkUrQ2Z5UDVwQ2Jq?=
 =?utf-8?B?aEp5Yy82bmhIRTFqdHJJbFNzK1c5elFyZ3RoU3dBWGx4YXRTK3FrVktGazlY?=
 =?utf-8?B?ei8wMVFWZFpoZWlOVUZteU0xRDVDMkp4WVZPODlQTS9DYS85cWMySUY1UUVt?=
 =?utf-8?B?VFpHYUJLMURUcUlWY1dsc056Smp1NW8wQlNhWlpaYUZHUmwrTVhkMDFlckZ6?=
 =?utf-8?B?NGNZMHJUdGZsVEp1eFBkSjZ1VUx1YmtreS9PeDlCSDRCbUJIUWxiKytwRTlO?=
 =?utf-8?B?bWE4d1VOOHp4MmE1MjFEVExiRVZURG5GZlpuL2lPWkFBQWsrZmFXOVVqdmFu?=
 =?utf-8?B?NzV6dWk2ZElpV1BvN0FqM2xFZ3dhc2pvWnRzU1lHUWNST0ZUL0VOazRoMXcr?=
 =?utf-8?B?QzdzeHpBcWtEcVV6MGhDNmRBZWtRNTZQV3plUFNwandoSGRWQXhvem8yV3V1?=
 =?utf-8?B?bFMyNDIrc1hlbitUZ2RLNUlIaWF6WVRZUnJBQmdrN24xeE5QbmphVjczRlFy?=
 =?utf-8?B?L2dLMmpaNUpiYWhMcTBDM3RhbjFTS1UvZ1p2ZGRnNFo5MGQwcllmYytEVEZS?=
 =?utf-8?B?UXowS0kraXp4eXljcFNwSTRxUkdaMjgrVUI5Rm5ualhGbEsyeUZ6aE1HUHYx?=
 =?utf-8?B?OVprMFZ0TnZ1allqVnY0Y3I2N2ptOVR5YzhOczh6Vm1HMjNBajhaYW50QWxx?=
 =?utf-8?B?YzBPelkrejc4bE14YTg2aVdYNXpBbEN3QStOR3A0djNFZW1rSHJuWVlaZy9N?=
 =?utf-8?B?U2wwRVdkcnFVbWJDUDRBTDVoczQrc3luMEN3cjJzNzlCWUlaTWdneGdzYWhL?=
 =?utf-8?B?cG15OXlQOElsNEt6Sko3NzNiNVd3K0NyQWYzN0NpMFBhNDN2ZG0vRGJLd2V4?=
 =?utf-8?B?ckJkRWp1bUM1Y3UrNnlmRVJzR2IxUUNDWDdkTFpRcHc3WGE3K3N0MTFWM21P?=
 =?utf-8?B?LzVmdmV4L2EwMWZuTXBiVGFzemxJOFNvTXZySWxjWDkrMFo3RExIYWVNYlJY?=
 =?utf-8?B?VDgxZ0hpRHZBd0NHMVRvaGJQRk1HNGFiYUxPbmNTZlVDWWFUNlFMNFVRL09O?=
 =?utf-8?B?TUlYcnR0bTJzMS80MFJDYndZY1dlTGl6c3E0cURXTVJyMURldWlrOHROTXpn?=
 =?utf-8?B?M0daS0pkY0ZYaWtaQkRYOE5IWHNFVUVmQkppNlkxcnFZOG1yVzJMMUplajZ1?=
 =?utf-8?B?STdTZndSbnJobXJGQjcxVEROS0wwVml1RmxXWVpTb1krOUQ4QXc1ajdhQW9J?=
 =?utf-8?B?RWxuQmpLTXpkdHNxTm52K05RL0dXWE1GMDhhclc2V0lJVElEVzYxeUdkUGtW?=
 =?utf-8?B?OWJCOWJHMWxXMG9CNXU0VExmVFBKVVpSaVJ4UEsvRk5DQ05BWnVUOFRHZ0Vn?=
 =?utf-8?B?SmIzWWFOait2TzVVcnFleS9HNTVYVVN4TUpONnBnVDRURHF2azZWL0JIOWd1?=
 =?utf-8?B?bkhuMmdTOEVUSGFRYVdrS1JpQUJKd1RLQWFqU0JoTmVZelRsckg5WHF3R1Ni?=
 =?utf-8?B?MVBzaWsvN2VUOVM2OVlaL3NMQ1hxd0V4YjFKMnRDaDJnT3V2b3dhTG5wSHh2?=
 =?utf-8?B?aWVzbDBzQUVBbEV3NjNhU2VZdUtCeDhnVVR5QWFpVmovTDc5WWM3ZlFMMmUv?=
 =?utf-8?B?Ylg2bEZzam1qOXJmRjJGNS9EbGxFcHJLYVk1SGk4R0ptajZldmtHWWJldk5i?=
 =?utf-8?B?THgwUFEzNjRuN1JjRWFzMkxoOXFFM2JjcjZZVnk3OVFBbnAySTRMRXhVM3Fp?=
 =?utf-8?B?bTZpUFpzK29ua2pWN0xDd2NHeVhsSWxJeGtQbmYxVUZmRVpkVlpXaXRocTl0?=
 =?utf-8?B?aC81V1BMNGRTeHFSQUxBZk5vM1FMckhHRk9KYnFoVExSa2tkcm5JUGFidEZ6?=
 =?utf-8?B?Vzl3UGdBTFhwZmpPNmVsSklJWEs2dFM0OXB2bXpxQ1NzeDJUV1VqcHlRMTlH?=
 =?utf-8?B?STUwK0gvaXRMSHpGYTBNdmNhM0NKYkJTWmo2ZFJMWFRRR2FpSmYybWJSUlc0?=
 =?utf-8?B?eGtpV3JMTm5ZTGxaTTR0WGM3VklKTXgvMWtwQXdwV0FLSnFhNVVFRmZoSDlp?=
 =?utf-8?Q?KorAUJdhCgvAABPwohspZ8FMq?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <77E29B3EEF56984C81E729CAFB7DA347@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9404.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 745ce913-c14e-421a-9fe6-08dd65c8ae37
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2025 02:57:54.3807
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ze11Aq4vV2HBMic6NCLbF56s4gEZjxdErsu9FIeEXr015iYKMBYLDSbSTo3r8XKO4axodubhLfiyslYiFGE2yA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4182
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250317_195808_791252_456116EA 
X-CRM114-Status: GOOD (  15.34  )
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

T24gMy8xNy8yNSAwMDozOSwgc2hhby5taW5neWluQHp0ZS5jb20uY24gd3JvdGU6DQo+IEZyb206
IExpSGFvcmFuIDxsaS5oYW9yYW43QHp0ZS5jb20uY24+DQo+DQo+IFRoaXMgcGF0Y2ggcmVwbGFj
ZXMgbWF4KGEsIG1pbihiLCBjKSkgYnkgY2xhbXAoYiwgYSwgYykgaW4gdGhlIG52bWUNCj4gZHJp
dmVyLiBUaGlzIGltcHJvdmVzIHRoZSByZWFkYWJpbGl0eS4NCj4NCj4gU2lnbmVkLW9mZi1ieTog
TGlIYW9yYW4gPGxpLmhhb3JhbjdAenRlLmNvbS5jbj4NCj4gQ2M6IFNoYW9NaW5neWluIDxzaGFv
Lm1pbmd5aW5AenRlLmNvbS5jbj4NCj4gLS0tDQo+ICAgZHJpdmVycy9udm1lL3RhcmdldC9udm1l
dC5oIHwgMiArLQ0KPiAgIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlv
bigtKQ0KPg0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9udm1lL3RhcmdldC9udm1ldC5oIGIvZHJp
dmVycy9udm1lL3RhcmdldC9udm1ldC5oDQo+IGluZGV4IGZjZjRmNDYwZGM5YS4uMzA4MDRiMGNh
NjZlIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL252bWUvdGFyZ2V0L252bWV0LmgNCj4gKysrIGIv
ZHJpdmVycy9udm1lL3RhcmdldC9udm1ldC5oDQo+IEBAIC04MTksNyArODE5LDcgQEAgc3RhdGlj
IGlubGluZSB1OCBudm1ldF9jY19pb2NxZXModTMyIGNjKQ0KPiAgIC8qIENvbnZlcnQgYSAzMi1i
aXQgbnVtYmVyIHRvIGEgMTYtYml0IDAncyBiYXNlZCBudW1iZXIgKi8NCj4gICBzdGF0aWMgaW5s
aW5lIF9fbGUxNiB0bzBiYXNlZCh1MzIgYSkNCj4gICB7DQo+IC0JcmV0dXJuIGNwdV90b19sZTE2
KG1heCgxVSwgbWluKDFVIDw8IDE2LCBhKSkgLSAxKTsNCj4gKwlyZXR1cm4gY3B1X3RvX2xlMTYo
Y2xhbXAoMVUgPDwgMTYsIDFVLCBhKSAtIDEpOw0KDQpJJ3ZlIGdvdHRlbiB1c2VkIHRvIHRoZSBt
aW4vbWF4IG9yIG1heC9taW4gY29tYmluYXRpb24sDQpidXQgaWYgb3RoZXJzIHByZWZlciBzb21l
dGhpbmcgZWxzZSwgc3VyZSBnbyBmb3IgaXQuDQoNCi1jaw0KDQoNCg==

