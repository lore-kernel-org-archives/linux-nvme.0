Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4811C3600C
	for <linux-nvme@archiver.kernel.org>; Tue,  1 Apr 2025 02:20:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jR6pXKyVk5zMvOVOP2jdGq5wDfyB3PH7JAQW3MxyoCk=; b=0gVIDaA01tM/ZOY6ZQPO35FFgd
	lK+YZ0+Q7GPVwvnnkyUy1oog0yn+XEEzsYDYvsMHjS3epP84asvU6lpaCJFxWkWn1ltwP1mSr/8kT
	8YKzHbFxGuLVyPez8foquC2AMasiOSuSr2178tp0kE4OOlyi43/W+bzBWWUXv82jq3NdjjTHwk39Q
	93q6KCUp0im+g1K57dIAgVJeeAopYuwgJ9FQltiN+nMdX4mAURB5XK/JZIdNm2DSrHPwNZ1Y0YJ25
	t06guRwznIlLbekiaRXCkyu8PGJJoAFSrIntg9vLjoB4he8loH6fIDcUWsMOXNAbTqbhFDvBR63r8
	DCsQdHpw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.1 #2 (Red Hat Linux))
	id 1tzRF7-00000001mi9-3tat;
	Tue, 01 Apr 2025 02:20:45 +0000
Received: from mail-mw2nam10on20607.outbound.protection.outlook.com ([2a01:111:f403:2412::607] helo=NAM10-MW2-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.98.1 #2 (Red Hat Linux))
	id 1tzRF5-00000001mhg-1nMR
	for linux-nvme@lists.infradead.org;
	Tue, 01 Apr 2025 02:20:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Lxvw/TBb2f4bUC6BMrt5PvmuFk9/7vktTE2LFKmUo4P2BX8yURilZoL1sPzxNTR4sP8t/nmFfzw3A5zRQMPTa35xToDTgvuwGvDlzRVNhxrGYppsVgzBw0ejU1X9WgI3qbspUmhsVJSIUxoErNzF2VNMMeiHaMBfSdgXTDWCrtpuV9cCB5jwY3BpiqmR5hEdp7LRxH1cFm1JYqyiw9YsPOwoNYU6V5mCVSrWboutCAvoQTTyTFI04mnO91C6w0Ear7Ofmp0EnkdCYcfMkzyENDARRBV8qhPykW946SA/4Gjy+lq2N9m7aeUMvtYiEjG86gdOIlvQ+mBGibKoM7ZjZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jR6pXKyVk5zMvOVOP2jdGq5wDfyB3PH7JAQW3MxyoCk=;
 b=JuH4CLweimKyHnGofzXrtwpqa90Psxk3bh55a3Z0ANib11v2KqmKCNYonSUMmrFTYMH9MXuRrDof5i2vZpxH+BYpHsYsoroP1+FAbWi8gZO5afCwypBhdcndgn+5TOmPxgo0CMKijDocD3sCL/+8ZHq9TuuapSv1NfTruuAUnsJ+kWjrk/JUA42ehlGhHWXfmvonaOPuewoU3Z4QrbtWJ8et0/T/Tqo3daRJFl9lq04sBelhEkLjtwkJhPRQcsqfndD32F2W2XxvqReLj+0P4GhB9DNtRdmcBws2hKy7LziA1DSr4jlXSNXBfw+Ppfv5cBhIIS+1CglqUCvVYUVWXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jR6pXKyVk5zMvOVOP2jdGq5wDfyB3PH7JAQW3MxyoCk=;
 b=cwpR57VjzmqpDWjkGxotCpsSMMdqsbxiZ3fb/+UQEghB9JluxXekS4i7rtVnLp8g8p9Fi/6GYa1F1vagECzWUKZk5YyxreZsDznay2tiGHN/+tud1NaGouIfHcO9r4o0W10hbd79TBWpyqPlEoKzwEdX4qSUgChUnIFepunFjin8ofleA/Ag4gP7cN+Opbd2esItBxDAkCz8a93MWq/DKVLlLB7JdOu290XkCbxc1U4H3Jmp+MWW7lDTR9ejXctVs0OPfXw5PP0DB7i+L2JNTHNK7aMXDZaT3S+DzI891py2OjZZRp1izISBX8IxyXTatbhdJ6fVBJPW3LSHWSAtvw==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by IA0PR12MB8861.namprd12.prod.outlook.com (2603:10b6:208:487::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Tue, 1 Apr
 2025 02:20:38 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b%5]) with mapi id 15.20.8534.048; Tue, 1 Apr 2025
 02:20:38 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Keith Busch <kbusch@kernel.org>, Kamaljit Singh <kamaljit.singh1@wdc.com>
CC: "axboe@kernel.dk" <axboe@kernel.dk>, "hch@lst.de" <hch@lst.de>,
	"sagi@grimberg.me" <sagi@grimberg.me>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "niklas.cassel@wdc.com"
	<niklas.cassel@wdc.com>, "damien.lemoal@wdc.com" <damien.lemoal@wdc.com>
Subject: Re: [PATCH v1 1/1] nvme: add admin controller support. prohibit ioq
 creation for admin & disco ctrlrs
Thread-Topic: [PATCH v1 1/1] nvme: add admin controller support. prohibit ioq
 creation for admin & disco ctrlrs
Thread-Index: AQHboDJ3YWk2xKd5J0i+Jnp2GNV6CbONW6SAgAC9RoA=
Date: Tue, 1 Apr 2025 02:20:38 +0000
Message-ID: <a54fab93-d48e-4095-89dc-97060652799a@nvidia.com>
References: <20250328213640.798910-1-kamaljit.singh1@wdc.com>
 <20250328213640.798910-2-kamaljit.singh1@wdc.com>
 <Z-qur5YnK2ZtiRR3@kbusch-mbp.dhcp.thefacebook.com>
In-Reply-To: <Z-qur5YnK2ZtiRR3@kbusch-mbp.dhcp.thefacebook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|IA0PR12MB8861:EE_
x-ms-office365-filtering-correlation-id: 39694128-efc2-4e18-3c37-08dd70c3cb01
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|10070799003|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?d0FQKzJBcU5Va0pZeGx4d2dETkc5QTNBZ0tiSVNtbVp4bEhKK0NXb0s0bFdN?=
 =?utf-8?B?bXBSOEtQc3duV2RQdzcreWsvMHJhUU5uVEJ2Nld6OUNWTjBIRklWK2pxYnlj?=
 =?utf-8?B?NW1yTERxaHhRYlgvUmR6SnM2SXZmWk1WV2hOVjk4djBzTnkzSU9rQUZyRGYv?=
 =?utf-8?B?L1EwTG9lY2Y3VlVVa2wydmx3S1d6SUQ3NU90TlJDa1FDSnU3Rnp1cFowUjBp?=
 =?utf-8?B?dVlTWW11ZFZuTXdXWEZSQ0dtM05Qbjg5WjlTVGlLaitWbm12bzJEL1poajZW?=
 =?utf-8?B?UW5nc09oLzZFbFBZZ2ZaZUJ6aUExZFRsMkliMDJJUWNHcG9aRHJFVnplUUJD?=
 =?utf-8?B?WFVBdzNIRnFvS2IxQkFMNWFWaU0rU3RwY20veHJHQTZIWHFHT05BbU5uVTlj?=
 =?utf-8?B?Tmg2MzdDazVmRDU4dlZRbnNuODZpY0NXOVkzdVkwb09sUlNvS2tXc0x2Nnhi?=
 =?utf-8?B?NVQ1eG95ZXd3N0RyOWlJMTVyenprd0F1UW5oQjUyZG5UK1RZMGlQWWRXVkoy?=
 =?utf-8?B?ZmpkYXgzYUdDaE41Um8xYTVraGdXNXNpQW51M1NvNUJlYm5wUE1ERWxiSFhH?=
 =?utf-8?B?YkltZFpRZjJzWGVQLzg2NWRmdnFYUDJOdldxbjFyYUwxVGt4eVhvUXVkOFVC?=
 =?utf-8?B?NjVQL210bHFSODZjUU05dmwzMnBzVWQ4anZLdnY1YVVOSm1FVDFKOVlINzAy?=
 =?utf-8?B?QnU0NVBxVGwzbUQ0eG5rc3VrQytobnBma3FjN1AzVmJ6a2Y4MVpvNkxURzB0?=
 =?utf-8?B?MnhmZHZ1OTFjRjB0QmxwaURCb0hiY3BGL29iRk1iNTlva1M0WVJZYStpNHJY?=
 =?utf-8?B?ZFcvbFFTVWkyYzREdWRDaEVLUjM4dkhObzJSU24zc213TkVkK0Nla2FMbUUv?=
 =?utf-8?B?SWMzMzdZZkRuMkdDRnNFa05VWjhvU1M4VHhpQnVINFliRW5kazdBYkh1QVA1?=
 =?utf-8?B?NnlSUHJpZjl4VGdPR2tTaG1vQ3ZlZFBtTXNLR04xNWVKMUVFcEJidExvYml6?=
 =?utf-8?B?LzlJc2x3QkYvNnMyTDJKUGVzL2N4MTZrRDNxb3YxTFNVVVJhcCt1OUYvTjlz?=
 =?utf-8?B?WFlxUWovbzlsWmtyRk8xeGs3V1pncVhUSXhac0syMFhSSGVHdkt3cWJUc3pD?=
 =?utf-8?B?d3ZWSS95L0lqajFGUlV6cUd0VSs5U3VmR2VUVzRxVDdUV2hpaEdEb0kySjFz?=
 =?utf-8?B?Y0UrMzBnUVA2VWh1WVdwN2hEbTJCRU1GT2wxSHZwdmdtaHFJbUFEc1N4OXVr?=
 =?utf-8?B?eURxYS9VY1pIb2tjMlAxRHJCTUNKbHVabmJTeis5NWhnNlI3bzBBbUUzbmNC?=
 =?utf-8?B?eElRVDVxWHZ5Z2x0RUZyN3U0TTJrbUkzVk1qdWV2MzhkSCtyTzZrRGVORDMz?=
 =?utf-8?B?ZnhWQktIazFRQ2pGQzZTcGw5SDZwbnN3V2R5SFZhSHExaEhWT2l0QkdFMm5O?=
 =?utf-8?B?bjgraXdTeTBtamtlYWhyaHl1bGZMbEcvVnhOeDZkWTV1YTU1cjZSbTJHVXhu?=
 =?utf-8?B?NVZXWkludW5YQ1d0dkdzYWtqSjUrMzJ3UUN1QStNRE9KNHZsVldTajk3czB0?=
 =?utf-8?B?bGxyZ2d1VzQvQWRQeVFhYy95bFNpSjFuRFY3NUk5aytmZFIva2REd3dSOVIv?=
 =?utf-8?B?RkxxKzVxeGt1RndLUGNVRUtSOEVkMEZaUUtSOHF3UTZMRDhYVVppZDJqaXhs?=
 =?utf-8?B?ZkZSbmw1eVFhWDBZN2Qwa1dWN3cxVnhVSytIckE1R1h4clI5bjZEdXVkRFVa?=
 =?utf-8?B?bmF4clVtYTIxenBvU3RKd3FHeVB1VHkxYytHTXkvUmR2Zm5VdVl5U29mQnRs?=
 =?utf-8?B?OWpGOXJobk14SXlVS0VacEd6ZlFPNUppU21ycFNnOCtQZWViQmFjVGpwckt1?=
 =?utf-8?B?UkFKZ29CSGZwcWw4MTNvRC9sQWk4RmU4cXVPTG9nNDFvN0I1TFc0MDRoY1dB?=
 =?utf-8?Q?3cdwjPNP4Nfc/sLy92BPeDGUWhrcbwVj?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OGIyTmx0ak9lbERQS3ZFQmpHRlRGbVJhNnd5R0gvTFcvRWJpbFJhQzVhT3lV?=
 =?utf-8?B?cFdwV25WWXJMVWJCZTFnNUlQUnhTMEQwb0tQRXdEeXZDZFN2U01EWDRSNGZy?=
 =?utf-8?B?VkRtVGNRd0pUV2t6a2VjUEpFMjdNdDQ1SnEvdE9YRG9oaDVzdHB3Y1VmV1Y5?=
 =?utf-8?B?U0dxMS9zMlkzR2IzYzNmZEJsSmFRUitmd1o1SDRqQ2YwODZycXdGMFBrMDVD?=
 =?utf-8?B?OFNKWlNXbm9UOXFreHp4dk96eVY2dkY3dUEwNGcvd0FHM2ZPYjFmT3VzaFU4?=
 =?utf-8?B?OU1CZUJEblZZQWJMODR4cW5XOVFCMjJ1anAzRWRiTnJ1WElVVWpLVmVLSkJr?=
 =?utf-8?B?c1dHb1RMUHBzMzY3dk9MV2JiLzV4SENOSDNvQUQwZW94LzZPeit5bkFQUE1E?=
 =?utf-8?B?WStZU1NMbE9wNzZ0dk5HbEU1RjV1UHBpQjlBUEVwN2V3bUpIdWsvRUJ0R0F0?=
 =?utf-8?B?ck56VG9mWUF5dnlZTXdQcG5FRmxseGR4YkFzMnlEVjF5VnFaYklSejdGTlQ3?=
 =?utf-8?B?cXpDb0IxVzN6NVh0MlRQUFVDenRIYWxPZU9NN29ONTE3Umt6eUgwMXE5eHcy?=
 =?utf-8?B?aUxUcmlJN1ZwcnhhZlNzTVhXaXB1VEM1YUIwSUtRM1F0N3oyUHJaM3hxN3Ex?=
 =?utf-8?B?a0gvTlNXc2RBS1J4QWRmT0s4MWoyTStlMVliTHRWZS9UaEFBTENBcGtZTWow?=
 =?utf-8?B?WnJoRU1LQzZyeWFPbzloY1Q0Y0EzTXI2b09FeWRXdjhTZ1NFbThQd2d4anpy?=
 =?utf-8?B?ZUVWbHlEallEU0RXdXZPWFNGM09Nb1R5MlBDTXI3aDVKOFpPZHRFSVZyTjR5?=
 =?utf-8?B?eEZiU2tockVTcVBMODJzYWdKWmQyZ04xaDhGRXozKzNZd3JoQ1M3cHdYN1U3?=
 =?utf-8?B?K2tZZXpxRkpMM2xDOTZKU09MWm5iRTdISUJZMzczUmhPMXhmYm50a0M3SDJL?=
 =?utf-8?B?Vm8zVnE4QXNNN1kwcjlRdTFSNlRXU3lRNFRMQTJ2Y3NCK0Jvb2ZnNnJ3UHhM?=
 =?utf-8?B?OTdlamw1eXcwVzlTSGVNWFVRMCtZQ0phVy9NQ2VZcCtJM3lZTXpjUW9uNktD?=
 =?utf-8?B?UVZKRDQwU0NyZ0pFOVNHK00xSTV5VEFZb3NNWmQwYm9iVlJVUUdOcE9ETDh1?=
 =?utf-8?B?cTBqeWlEMnR3b3Fxcnp4bVZ5M0w3T3VSK04wNERiQ2J6S21qTnpWTHp0ZHVa?=
 =?utf-8?B?NDRWdVB0QWRsQzdPSUpJQXZrOFpxYXZOSmlrU3U0THEzbUxVNDd4N2RZSzkr?=
 =?utf-8?B?aTZoN1I3VFl4L2ZDTnM5dVoyRjJSdGdpUzgvRGJCQzh6RlV1eWZzbzNSQjd0?=
 =?utf-8?B?Z1hXSHFvMXJObHNoMmZaVTFpUzNhNFdjQjhEdmVFbWF0T214N3M1dVYzTnRF?=
 =?utf-8?B?MXB4RE5KTVNXR0IxcUcxMm40MU9EMjV6ZW1Gd0t0aEdjV1JmcFREcy9oblNP?=
 =?utf-8?B?N0FFb0pFR3VVWjN2OXpSeE5OZnV0OTZkZDBESnoxYmVYRFJ5dy9RUzhCRHRC?=
 =?utf-8?B?eTJWN0h2YkUvQXVTMzVvOVA0Mk81ZmcrbUtRL0NNU3VTenhva1lyTXZ0ZnhQ?=
 =?utf-8?B?WTR2amRrMi9vTTRYZmR1d3FjWmVvcmZSc2FWLzVVOUppcTVkVjk0dUJNaEs1?=
 =?utf-8?B?eXlSc0RHSzdJeGNOME8zbk5wRzNqdnhKL1JpQ3p0WFM3SjI0Wlk4SkE0cnVU?=
 =?utf-8?B?NEEyNkhDOG1jWngwQ1hPMm00V25vaDNQdzkxcXZ6cU5yVUZyOHl6THpLdEJM?=
 =?utf-8?B?L3IrdWVaakR0bk5wNU1XOUxXUk9NTVhFbjNubTI2bzdzZ0czdWRZWjhweitD?=
 =?utf-8?B?NTBuU0JacTVEdnhaK3J4OVl6VnJKd01iUnhtKzRLOHlyNkhoV1lSTnE3Mll0?=
 =?utf-8?B?aXhJampUMjhKZUZvTzBRQmkyZXg3WWJDZE43dkRvZFpxcms0UlBndzJOcHNu?=
 =?utf-8?B?bEZSMGluWjJ4ZGtWYzlGRGx5Qm1pWHNuWUptSHhsKzVyWmRQZEpZc1hvbk5T?=
 =?utf-8?B?YzVHTGJOa0Q1M1ZFcUl1aTBBTldYM1VjUmdsb0ZNRzNHN0hhSnk5elkybTcx?=
 =?utf-8?B?dS9WbU9jMHo3MzRIeWxab2Z2cXVKQjdUL3JjUkVHeHFKZ0trUUxPR0NNa0xT?=
 =?utf-8?B?eHJiYmtuSG83ems0K3BuTllmV1FacGlaR2pkdDRqeU5YcnBSVnBQcXBPeWVV?=
 =?utf-8?Q?SmKIV7o22Ff5ktS4D8Vg1LBUY2PK8nowx8sqPCZgiyJI?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1113A700E713504CB2FFB1469D409E48@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9404.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39694128-efc2-4e18-3c37-08dd70c3cb01
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Apr 2025 02:20:38.2652
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gG5PhokwilqfFIpiqyapN94bU8uVcVcauB+i3u4FjHm1j1Enyu83MFiYhK1Gt4so76Ql1BW7LarUqLhK9lJVsA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8861
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250331_192043_485513_59648115 
X-CRM114-Status: UNSURE (   9.92  )
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

T24gMy8zMS8yNSAwODowMywgS2VpdGggQnVzY2ggd3JvdGU6DQo+IE9uIEZyaSwgTWFyIDI4LCAy
MDI1IGF0IDAyOjM2OjQwUE0gLTA3MDAsIEthbWFsaml0IFNpbmdoIHdyb3RlOg0KPj4gLXN0YXRp
YyBpbmxpbmUgYm9vbCBudm1lX2Rpc2NvdmVyeV9jdHJsKHN0cnVjdCBudm1lX2N0cmwgKmN0cmwp
DQo+PiAtew0KPj4gLQlyZXR1cm4gY3RybC0+b3B0cyAmJiBjdHJsLT5vcHRzLT5kaXNjb3Zlcnlf
bnFuOw0KPj4gLX0NCj4+IC0NCj4gSSBzdXBwb3NlIGl0J3MgZmluZSB0byByZW5hbWUgdGhpcyBm
dW5jdGlvbiB3aXRoIGFuIG52bWZfIHByZWZpeCwgYnV0DQo+IGl0J3Mgbm90IHJlYWxseSByZWxh
dGVkIHRvIHRoZSByZXN0IG9mIHRoZSBwYXRjaCBhbmQgbWFrZXMgdGhlIGRpZmYNCj4gbGFyZ2Vy
IHRoYW4gbmVjZXNzYXJ5Lg0KDQpwZXJoYXBzIGNvbnNpZGVyIG1ha2luZyBhIHNlcGFyYXRlIHBh
dGNoIC4uLg0KDQotY2sNCg0KDQo=

