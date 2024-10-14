Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A77C9CF2590
	for <linux-nvme@archiver.kernel.org>; Mon, 14 Oct 2024 05:43:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=HGpB4oclOnC66mOK33ujiB9HvKLmW6KmNQRq5Y0rVW8=; b=Dcyv/JVU6nlobdcZBQojEf3gzH
	GqItW8ctxo8k9L/irzs0Ad1HFuEB3xL3gyLxb4G1hZCSqdRwDUiNPHTJLFT2mE9udCODpzQlfXePW
	096nDD4VZq18GtOoB6XUkF/X9pqinkhEBcXkfsymaWA1t3AFMhuh8fd8tGdemkDSGg6/cgpvL8w5p
	L9fOZ7H6Oxikrj6Msr4upOOyaRw7L+kArwRAbKQ3TuQpUS0VLK9Oa11icYsaU7TJ6qLV7OLUVjZDL
	R1QXTUDRhIOzdUdMnBmgcGNCIy3u5+MkuFSn4RQZ0KOSEjWGpztqV9ao1IjuQrtIOpPUoT/aA8sDY
	sJ4VtRkg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t0Drz-00000003n39-0fSp;
	Mon, 14 Oct 2024 05:43:51 +0000
Received: from mail-mw2nam10on20626.outbound.protection.outlook.com ([2a01:111:f403:2412::626] helo=NAM10-MW2-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t0Drw-00000003n2j-1TUK
	for linux-nvme@lists.infradead.org;
	Mon, 14 Oct 2024 05:43:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oZ1o+ACnQ+vE5aBXBsgAANs3JBxBp2/aCLbOD7mfRUfvZuDzZvTzWpF3CeGEcCbZsdvt1YOF+H/BEkGd9iWQQjT3+F0dPBVcvUEWcEzpQAZtlQhH3dexSvHGN4DrV254hysrHJ0mWAm5sEJcCf7ppHWX9V9uYUwR9C8t0VYjbAW6uQmi/TotuyKCOAj6SNa/lT9BpZTs/J5YIy8GoNUAsrtkL2bPez4s5IA2zWgPFqxFpUyj0jgGOIRpjnkJyt6cUuKlc1/6vyN519W1oX8ghhQBhpM2v4ekkmXUl/K+ChpEaOSvPzGC/F9RRrFUPqUGZNIXvTfkrbrUCMpXgOQw+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HGpB4oclOnC66mOK33ujiB9HvKLmW6KmNQRq5Y0rVW8=;
 b=k3194VY8nlnikC0EivU0fMOV5rKsJ2ilvV8Hq6agwsko95AlE3ZK6MsPTGp63ExolBBblD3RkjS5nxunDv2ZQo3tdOyz+Tnb3DZN/7JYqJBoUdlEABP6svlInXIJNxyB+VKv7SfgBBPCqw1+xXrvw36VgOoEmMDGoeitAAlGu0mdO98jtanolFLCd2Wl3CnyNE/ioaTE7B611Sjtta4epTqEXy+wBHNrclCUSmLrWC8wpBPFcAD9RfHz76z4nLFYw1RwElXYNIfNomLTZIjKpvhkjukcn5RvWZOpMWFr1PwS1THvzOZJYCP4Pi9rHDaADNzXx3U6XmEogWNFVoEEMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HGpB4oclOnC66mOK33ujiB9HvKLmW6KmNQRq5Y0rVW8=;
 b=nsrHkds29z74ccujQCAuvL8GUy7/lT12oezi43RzoPEmW1gLPjSxvs23nn+1axJ/AeQTa7mpx46nu2KqDAulbQLUJHlzj7+45Y+8wQUPGZtVjs37yju+B8eEitjZ12E+J088Dj57l6hde2r7Owy9ymqOBvSjmz71nTYeRCDPC/3kAQNbOK4QgaFAVgUpucsQfO5wVLWDIDwi72Qs8Wv951nd2MyUKps2g4hPhn33pIwmOGAKVgPaBaOGtaycBHgrY5jWqWrFJCh1cWwX3EjLBxku37aTXDZPK+R+pMavx9Sd/J0ujzGp6Ps9V0zb8YL81fnxJ6iUPNnpi0rJE79xrA==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by CH3PR12MB7499.namprd12.prod.outlook.com (2603:10b6:610:142::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.25; Mon, 14 Oct
 2024 05:43:43 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b%5]) with mapi id 15.20.8048.020; Mon, 14 Oct 2024
 05:43:42 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Guixin Liu <kanie@linux.alibaba.com>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	Chaitanya Kulkarni <chaitanyak@nvidia.com>, "sagi@grimberg.me"
	<sagi@grimberg.me>, "hch@lst.de" <hch@lst.de>
Subject: Re: [PATCH v14 1/2] nvme: add reservation command's defines
Thread-Topic: [PATCH v14 1/2] nvme: add reservation command's defines
Thread-Index: AQHbG4T71h4DedJRFkaumZ+Juv0xzbKFwQMA
Date: Mon, 14 Oct 2024 05:43:42 +0000
Message-ID: <519ebe04-a2b1-4e9a-a67f-7bfb810a7d88@nvidia.com>
References: <20241011022612.50303-1-kanie@linux.alibaba.com>
 <20241011022612.50303-2-kanie@linux.alibaba.com>
In-Reply-To: <20241011022612.50303-2-kanie@linux.alibaba.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|CH3PR12MB7499:EE_
x-ms-office365-filtering-correlation-id: 3260420d-3e25-43c3-f7cc-08dcec1329c9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|10070799003|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?TUNNZDd3amVpakF5Rnh3cjhFZ01kSUpQc1NRV2t4aDNTWDA5SFZPcTV6QkZJ?=
 =?utf-8?B?TzMzK09vNm1BZ05PbHNmdDNSWVR5WnBFSnltRUl0SHVPTUpqSjBCMm8vR2NG?=
 =?utf-8?B?Myt5SUI4SEJBY3RwZFNVSG5YV0N1UkhueUlOSVM4d1piYi9RWkN0R2UvK2JW?=
 =?utf-8?B?ZWUzMWY0NFhXUTdsVFVXaC9xTmN5S0JQZmQyMU9FV0RvN215VHlQN29VMHhq?=
 =?utf-8?B?bWFwUkY2K2c2c0dDcU04VWg4ZTVTYm5ucG5hRjl4WC9NcFVKV1hrYTk2ckJQ?=
 =?utf-8?B?endYT1plYnVjL2N2cVQ0TW1kd0YrVEJqaTJRVExSSzRiUFBDem9nMjNLYVFK?=
 =?utf-8?B?eWpIUkxlUVAxYTVDMHlpY3kzczRWcFdIc2hHME92WXZQT0x6di9ncHRld1Nz?=
 =?utf-8?B?SmFrc0tYZmFVdlE3OVhPeXh4aDBuZjN0SDFaWTNvZExMQktrZXA4N28vNTE2?=
 =?utf-8?B?WWpHSHB1RXJnVngyc3lZQnpEa2ZUeWJpUGJ6RGhOQ1U2dnY0QktYbmU3MVZT?=
 =?utf-8?B?TmVIemxSVTFpa0p6b2hMLzM3Z0ZiVzNaSXNXaTBkMldXUTRQaVJUbnpYUXVL?=
 =?utf-8?B?MUpITmlycnljenJsMlJYOVBaRkhPNCt5QjhubmtHOXA3Qk1UZWthQTBRdjlS?=
 =?utf-8?B?cmVMUjEvUnFoR2g4VGtBK1BuNGJBUzRHN2lnUEdPSGkvdXBjVzZYajlHZWJY?=
 =?utf-8?B?akVJTnVBM2VpSmpZWWd5ZHVycEwweFo2Mi9yRWdQWEp2ZVdCcEdweE5KQTgr?=
 =?utf-8?B?NlV6ZS9NbEJBVGgxbUtxQzVrWEg2Z0Rnbll4aXBaY09iVU9peG1VQUJxTzI2?=
 =?utf-8?B?ZlJpbEE4ZWYvazZYN0o0aDRCejFmNU4vdW5VU1Axek93NStPVWNSV0hXS25j?=
 =?utf-8?B?T25ROG9sRnpxbUFUOUdmWDNXa2UwTEpYMnY2U2R4NUNPajE4S1Z3YTlJaVNK?=
 =?utf-8?B?L2tzRExISWtBbHhlWDl3a08vdS80SHJWdjRtSFNDSFVVaTVibTc5WkYvNHJW?=
 =?utf-8?B?bTgvUVpXRTM2SVZBOVBZOFR0WFZwR295TklLbEprRDYweWF3THM4WFZjZElq?=
 =?utf-8?B?QzhKRWVDd3NOL0x0RGtiK25kWEhCWnB5ZjNmUitQN0hRcGJkR3kyRWY3QlBs?=
 =?utf-8?B?bDRPTU1vUVpsTzRXRGpPbkZUZjRiN0VVaURlYVVyalA1UjNDWVV6cGZBOG9J?=
 =?utf-8?B?aDVoMlNmZHpkdUVlSUJNZ1VQYit4eVRBTWtNeDhwTVd5NVdJMUJreFRqMkpz?=
 =?utf-8?B?L1hKYjdDdE4rMjdYK2RPQzEwQlJlSVRoR0pZSHZGVFFXTXRIb1NtZlJhVVY0?=
 =?utf-8?B?RmVaVGs0ZjF3Q3phcTRBMXBNUGVvQjdFWGpqdmd1emFpRDIvbkJSRlhGTUNX?=
 =?utf-8?B?TDlNbkRNaWJvV1pXRG5xSUc5OHRNSk5Mc0tjeUZQakhZRmhPZWZEZGFTRkdR?=
 =?utf-8?B?d1k5bExhaVIzYW1lNk5lNWZTR2VoWnpSSGJJb3FQcTM1UmYvbDAvVDUwMEFl?=
 =?utf-8?B?dUtBN3MrRW00UWV4V0tmbEpkOEtvQWZmTVVDNFRTSW10RHZDSVlZZWNudUty?=
 =?utf-8?B?RFhIOTNpVm1sR0dDUzBIbFY1VlBWdXZwVTFnMnUwamh2WFlnSWRqRlpTRGdM?=
 =?utf-8?B?bVB6aE5Cc3ExaGJaZ3FsaUI3TVhmNVFaV3ZsdnNhb2plVmhremF2RnpRVlVT?=
 =?utf-8?B?OUZaYnFNajZRM3NZaysrWGFvemMvRmRkcmI5MU55UjRqSGtaRWpreFE5NVhr?=
 =?utf-8?B?Q3hwU2pTNm1BY1BSYTdWZGVBZnRHV3FDL0FPUUV6SGtNNll4eVZDRk9ZRWJr?=
 =?utf-8?B?RUMzc1dNN3BuQmU5N012QT09?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(10070799003)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?M0ZXZ2M1Qi9ZcE1CQkFJTVZJWmorb3hpMDYrN2VCRUtjRVdWd2Z4eEV3SXlV?=
 =?utf-8?B?UmRMVUtjb1VObVRiRnVDa09uVWpCQmdPNkg5Qk9aWDJnN0VzZ09QZzI3bVpz?=
 =?utf-8?B?YkFhaDNSRUNPNm1QbjI1aWdPcWN1aUNIZEJLV2pEQ1ZLZDNKcklPZmlDUWRo?=
 =?utf-8?B?RWFVS2RGYnkwVGZiN1R1TkxjWjhjK3hJSkcrSmcyTTlCZEJLNHl4dEVud0lV?=
 =?utf-8?B?dVVoVUZVTTBROVNHTWlqQTNYSHpQNFBlQ3NMakhJS2Zwd1FnY1ZJN2Y2dDYv?=
 =?utf-8?B?cXB1QVpjbTNhU3RxZ0FrVGJWbDFnSjFOSnNKeU9pSGFLMHc1eUdIOGMyMjRD?=
 =?utf-8?B?dFh0K3ZKMVJyRzBjSXBwYjdWZmVrWE5BdWFXcEM2RWxwNGxsdC80RXFkK09W?=
 =?utf-8?B?WFAzbDZoU0tVQ2dNYVlkSUM1aGJBN3JPL293MS8xRUZ0a1UxTTBWQjUrUjIr?=
 =?utf-8?B?aUowbTFYaW14Wm4yZWw5NHVkankva3dON3BWVzdBYzQ4WVl4YlBPOE9qOWtm?=
 =?utf-8?B?Z0tJV1BRb1F6V0g5clE0T0t6WHZxVnBmaWYvZG0xT1pKNW4vMVYrczFKa1oz?=
 =?utf-8?B?b3FEajNJMlg1cXhDcE4zdXlvcG1ROXY1SXUvUnp5R0NQdGpKdUdFbEZNMFB0?=
 =?utf-8?B?ekZ0V1k5QVVGcCtkZzJJSWFDQnNDWWR0NVpWazdFZTZybkl4TnVYQlpPR2JH?=
 =?utf-8?B?MUdSZEdnU0FuSE5meERDNGdIcCtmU1pOTDhlV1FKTEFNa29wNGxDakYvZGRQ?=
 =?utf-8?B?RlpBb0NEdFhvTnc1SitFWWN6YUY4eTJtaUVVa3Y3Ukc1ZjdvSjZVSi9JWDk3?=
 =?utf-8?B?cTUxV3RGREdlUlFPMUxVbFE3Q2x4ZVVFazcra1lqN1pzeUM1Y1U1d0lkYmMx?=
 =?utf-8?B?bGU2NitKMDhWTHZ0UXRrUUdNMnNYZisydnNvYTZMNFphOWJJWWcrd2JkOTY3?=
 =?utf-8?B?a0xvM2VMamR6dXF0eFgwQ3k0Q21NQ0RUdk5USVhheUUyQnllY0tNcC9LcFoz?=
 =?utf-8?B?Qm1abW1YaHNHWWIvOE9wTjE5RHFaVXVtaGpBUC9RQmh0RG5zNndRVndIc2dE?=
 =?utf-8?B?a1VGWU5ZeGl6R0lLNGN1ZWJmUldQWWsrTHlmVFlqR2s3enRIaGhNanZROTh1?=
 =?utf-8?B?Vk9SenVxQjRrNGZtdnJkVVA5Y0RxYWdiTHhXeUFRLzhLSnNHeXloVFRlNEtk?=
 =?utf-8?B?dzJ1a0I1TFd4RURCZ3dYZk5nbDRJenhDOVZyblZ2ZEJETnU0bkl6QWtoTXNM?=
 =?utf-8?B?QU11RWZTcEhKOTdGUjMwTHhCM2kzMHdQUm5US2ZuOWtVZDhwbU11eVNGd1lY?=
 =?utf-8?B?c3ptS1ZFNk11SzVramVTcWZXNU14WnFyd2p3SVA3QUhyWHhVQ3EyQU5kTTk5?=
 =?utf-8?B?ZFprZXdWYW1xbjJMeFNsVngrK0pJVzc2VmlqVDNFY1hYbGpram11U0VQakJo?=
 =?utf-8?B?aDlFR1Y5a1phN1d4a3paRGIzaSsrNThhdkpwL2VXbldpSnIzbGlmTFdraVBJ?=
 =?utf-8?B?ZWxaUkREQUtFQjkyWWhQR3RhNkRaU0dVRzFNOGo5Y3Fmc3hjTHRaNU16YVlU?=
 =?utf-8?B?NE5ib0g1dWYzR1JDQnl1SHF3Vkx3ZWt5VFFNTnJ1YXNVUXhtaW5URHh1ekhs?=
 =?utf-8?B?YVExNHh3TDlPNWliMTQwNHR5VEZuOTRLWWFlUEVUcFEvMG1aSVRBWHRlYmoy?=
 =?utf-8?B?bUcyZ1pKMzNUZ2xUbnJvTDBRejhQb1R5WXM4dFM0YmJaTHd1RjJxd1AycURU?=
 =?utf-8?B?OE1oRm42dHhmNk5VL2lpb3poRFZDYTJnc2hva2hxeWttVUFwSGR2c3JPTjZ6?=
 =?utf-8?B?alpUeEFhSGNKeVppZEljdTJCa0hOWU5aaWdJeEMrekZhWnVxaXRPc2M1WnBi?=
 =?utf-8?B?aGZhTmpBZ1AwRldXamYydEdNTnRsYWt5Y1paVndDVDZhM3dUQytPOWxtK0hq?=
 =?utf-8?B?SXhLTEMzOHVsMHNPQURhWTF5L0c2VTRYUzc0RDhwVGtOUWFlNnJnWUcycHZw?=
 =?utf-8?B?bk8xN2NVMzVxU0ZSWjJkU2N4bjBDaHJrOGlKN25iU3AwS0tzSmRuQWU2T2t2?=
 =?utf-8?B?czJSUWFWUENxYk5TVklLTDNzajdadXNUcG4waTlDeHI3SC9OQlNpYmU4Yzkx?=
 =?utf-8?B?TGFFSUI2VHFQc1B5akpVM3M2d3pXOG10UUxramFsRk5acyt6WjhXTW1zKzZk?=
 =?utf-8?Q?VYt77qwvwH9UpwAkPKdB3vxjitoHyei5kqUzHPc28SCS?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <26C1A747B112AE468D4F0E11F2A870F0@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9404.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3260420d-3e25-43c3-f7cc-08dcec1329c9
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Oct 2024 05:43:42.8842
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wvmopZdRdz4nGrKEPuqKU1BBla4EswiwBSv49Nb3H2bonIxw3TxsE+DVXmJXBvn5B9ER6xIplVc8KYSGwgUwgw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7499
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241013_224348_436568_C4007496 
X-CRM114-Status: UNSURE (   8.92  )
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

T24gMTAvMTAvMjQgMTk6MjYsIEd1aXhpbiBMaXUgd3JvdGU6DQo+IFRoaXMgaXMgYSBwcmVwYXRo
IG9mIHJlc2VydmF0aW9uIGltcGxlbWVudGF0aW9uIHBhdGNoLg0KDQppZiBpdCBtYWtlcyBzZW5z
ZSBwbGVhc2UgY29uc2lkZXIgc29tZXRoaW5nIGxpa2UgOi0NCg0KVGhpcyBpcyBhIHByZXBhcmF0
aW9uIHBhdGNoIGZvciBOVk1lT0YgdGFyZ2V0IHJlc2VydmF0aW9uDQpjb21tYW5kcyBpbXBsYW50
YXRpb24uDQoNCj4gQWRkIHRoZSBkZWZpbmVzIG9mIHJlc2VydmF0aW9uIGNvbW1hbmQsIHN1Y2gg
YXMgcmVzZXJ2YXRpb24gbG9nDQo+IGFuZCBzdWIgb3BlcmF0aW9ucy4NCj4NCj4gU2lnbmVkLW9m
Zi1ieTogR3VpeGluIExpdSA8a2FuaWVAbGludXguYWxpYmFiYS5jb20+DQo+IC0tLQ0KPg0KDQpM
b29rcyBnb29kLg0KDQpUZXN0ZWQtYnk6IENoYWl0YW55YSBLdWxrYXJuaSA8a2NoQG52aWRpYS5j
b20+DQpSZXZpZXdlZC1ieTogQ2hhaXRhbnlhIEt1bGthcm5pIDxrY2hAbnZpZGlhLmNvbT4NCg0K
LWNrDQoNCg0K

