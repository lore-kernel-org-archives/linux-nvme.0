Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A620DC0218A
	for <linux-nvme@archiver.kernel.org>; Tue, 28 Jan 2025 21:47:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2cEw7qLBAwYJWEKNeucPsUQQCwRlVkpvy2eNKKRxUUc=; b=ntHWMAghvJdjUR2hd2uO6E5h8S
	8pOCoxFxReL5I6aVWHxsvSQDOULm+lpvidXiWY+K0yDhUUUe8aKuv9JXJAlGkM9XMFmCcREk800g6
	nIgZw3ZzZjv6I7p1ule7x/CgFpRGxqg2cpZruQzuRKLd8chhiH0T+feamPzrMqhrKuJOLTofavUhz
	uqRplFsVAUW0kRbba1Zb/NgPIEtdq9ZPYtKWT2WYkVqQzvW+NUBEIOtZz8Lkx51PlzgX6Q5S6rJj7
	7l8hM89Gs1NH0QHATMHZaxpGMzejdH3+uqidjLNZMuZIB+LVug7lFhSWuDGNnuCru8ENmfuJR5aGb
	j0KvZNMQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tctQK-00000005rr7-3VBx;
	Tue, 28 Jan 2025 21:47:08 +0000
Received: from mail-mw2nam04on20624.outbound.protection.outlook.com ([2a01:111:f403:240a::624] helo=NAM04-MW2-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tctQI-00000005rqh-0CnP
	for linux-nvme@lists.infradead.org;
	Tue, 28 Jan 2025 21:47:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LzLKZyDsxuQzbmDklRRHBDDrP7SvNN3L0Ycr7mn7WR6qAoReSqEi5waNImQ2irJLs2hRKgOBCyIgTUHPKU9+vMkuZYVhChMZWHB//Ah8VzH1cofHy7pm1adhJzeEVsG19HPbdmYcCdq96ID9Ye7B3ZuDcH9Q64ViHfCxxMkPx++74kgj1Eo1kgEAjMCEzJS4VOHUdZUWyfBTs3RBvs8ZQbIC+MbFqZhMls4JZvJOFTmab9FP8VKJx66CJmzXEgRVGVaYHzvh4c21t2CQLT5bWPpcaqRJR+27eeifQtc/prEUDiY/iNJIgiNa3Zq/VNSMOZutiRtAaHgzm3ba1c3x9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2cEw7qLBAwYJWEKNeucPsUQQCwRlVkpvy2eNKKRxUUc=;
 b=iHKOVuNDtHLB25ZLXqQfnKfTKs8wjJgYADHer6wfZbfxS8qKscZaJbrSl0V4sWspitCo3cH0elSETrU14lsT4CayNnm867WY5IQrpR+WwhFYjJejhqukwP7i616GxdQsMx+YkU+fWA2FQRqHN/3/oE4oEoIjOcxgsywj3F2QxqSZhpfe65vtafUfTjqYW2n7fdO4Y19vRaiCLmXWij4UKVNIMsXbioq1ytvcDdvxrZdqIiKEYJO6+kgnfCpubB1SNv83PWFRPYx1Va664d6M2wkQ4sHT8GOV240TrejxdeZnjgHJ/pEyaaju2fylSxh/BafvsTgBVwSrVILNvA6MOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2cEw7qLBAwYJWEKNeucPsUQQCwRlVkpvy2eNKKRxUUc=;
 b=lUpku/oiAnbybvx5xkVZG/TgJv8rMR9e2KatmqaQx75ftH34hHpU89PnICmzNJ1tIkDa3R7bj3L4fAKNCApo/hZGDSFcgFaYHQoVi+F1OK46cq2z5dvyYzuq+itlD59bzc5zlzk4Vr02rJTra6x1RGH19HvoghTCns7Q5+nwRc5z9wwm9CFS5cIYq7qSC5VvYht2bNDmA7/0aKvaglrIumevXKUmSbPIpvALqZPHNE4+tM4QJDpzyO50RGfvJG7ylEAVZ4Dwg+OdQIMahW6y58gVtxSJrLqMWTXHIMek0Enz3QUTtL9HrxqgAUTJj0TZ/GzorLc5wvi27fxkJ6bhUw==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by PH7PR12MB6561.namprd12.prod.outlook.com (2603:10b6:510:213::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.23; Tue, 28 Jan
 2025 21:46:53 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b%6]) with mapi id 15.20.8377.021; Tue, 28 Jan 2025
 21:46:52 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Keith Busch <kbusch@meta.com>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>
CC: "hch@lst.de" <hch@lst.de>, "sagi@grimberg.me" <sagi@grimberg.me>,
	"hare@suse.de" <hare@suse.de>, Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH] nvme: make nvme_tls_attrs_group static
Thread-Topic: [PATCH] nvme: make nvme_tls_attrs_group static
Thread-Index: AQHbcZjx4HribXiMwUGdv1VEL2HfqLMsuRWA
Date: Tue, 28 Jan 2025 21:46:52 +0000
Message-ID: <98bfd313-3eb7-4690-b9de-fe327d59e997@nvidia.com>
References: <20250128152512.771115-1-kbusch@meta.com>
In-Reply-To: <20250128152512.771115-1-kbusch@meta.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|PH7PR12MB6561:EE_
x-ms-office365-filtering-correlation-id: 992795ef-b18c-473a-7b5c-08dd3fe546c5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|10070799003|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?aFhxUUlTYk5OWXJiWUtSdGlmbjBKVndXQ25NUWxMemNJb1Erc2NWd25aTHhP?=
 =?utf-8?B?OUJLMTJZTUg1eW5lcVJiTmV3YUowMTRJTENBbTZSamtHZDM2UzFYc1MyRW13?=
 =?utf-8?B?bFB4dTN6QVY0cmxIckk2MnZ5VWhsRWF3WUVSbnhuY1hwL1VkLzVFSFpFdkxs?=
 =?utf-8?B?Q2hYUDBTU1IvLzBGS243ZmhmUUhVRHNHUDBCNWx3NFBIUlpodm8rZHdLZGFj?=
 =?utf-8?B?L015L0ZYN3ptTys3cHQxRzcyaVUxK0Z1YVMyeEY1YTBPRWEwaUVoSXRzSHRt?=
 =?utf-8?B?cmdLWGV2VlZ0OHQ0S3hlK1F6d1lXYlVHQXR3ZWFSOWFYUnNLNUhQdUYzWHZm?=
 =?utf-8?B?bG5ZNmtTd1lPbWpTYmg3WVkvRENWWGhLMjZ6R3AzYXFJdlVQTUhVejNERkhW?=
 =?utf-8?B?eGhLdEl2QVB4V0VqcTlkQ2RKUDhHV2htbU1NVi9mUkNWSXMxVENEMFpyeFlW?=
 =?utf-8?B?Qzl6enNiZDNLdkR4RWgwcWVpNVlCZHNIakxrSlFnQmJmTmFwVlprR0VPMGVB?=
 =?utf-8?B?bEdOZ3F2L05IdGxwcngzWWZBaElnTWpGSDVjSkVPbzJ5M2ZzNnJHR0l4Yzgr?=
 =?utf-8?B?MmM5cmtiODUzQVdMV29zQ0VaNXBNQUl4YmpFOHVZdllpa244VGlQdFM4NVJt?=
 =?utf-8?B?OStuSzRCekJ3MHdjaDR2NFlubEdKSGIwU1lTWVJ3OXZlYVhCdUpNVU9qRm9l?=
 =?utf-8?B?L05hSm9vam9nMDZTdUZrWG01RE8zV3FqMXdZeHJFM1F4N0JiR2dDSTdtNEZ4?=
 =?utf-8?B?U0VSOFMxOXU1R3JXWWlYTmRqYThPckVkTE1tcjdMV0UzR0tBMDNGWlc2eVc2?=
 =?utf-8?B?YUcyTmZzUFpkSmJLaWFERkl2NmhxajZaQ005NFY0WGo1SHNmUU1NQnhjTHU0?=
 =?utf-8?B?RDhTd091QkNHUElrRytyK1h4dUgvazJESXg4S0haM0cxNUdJTFphbGg0Wk9B?=
 =?utf-8?B?TExuQXp5SkZKR2JRb2Z6cEFFMEpzNXBsMHpmNjhRYTN4aTMyN3ZEbTZZVmds?=
 =?utf-8?B?eDRDVVJQaDlrdUNGZFFsUC95NU12SHhLWlFmeXg4TjNWWmhJNHVQU3R5SEV3?=
 =?utf-8?B?andTSE5ya3RDR25wU2kvRUNwUkR1VzJrN3A2VUV2TU4xWnlPZlFCb0ZXMUJi?=
 =?utf-8?B?cXpRMTlEY25walVkdW41b21kemRzcHlRUTJQblVsYVB2cUFOWjlXcEtqMDdi?=
 =?utf-8?B?UW41N0I4ZlRaWHdGUzFTL2F6K1R1Zk9JNHlBUHZJYS80S0ZnZ0RtZHl0U1o1?=
 =?utf-8?B?M0FJT1lvV3I2RVdLNEhjWFp5Q3hqVGNUVDAvZlJMcDJMUGNBdDdDWHpKYUts?=
 =?utf-8?B?RmQzbzRvTGp5NXFxWEUzR2RocUkxVFNwTjlRZTNZemg3VW1tMC85WkFWNm8w?=
 =?utf-8?B?NjdhZHZlNlFDZDVDSnNReUFhWm9UbGpvQk5ZUW4yemx1cDF5dkhIeHVWekl1?=
 =?utf-8?B?OWpveFVtelFxZ01BRGFISVhqSUlPTVJxTDhpbmRmQ0hHQ2FDdFVDaVJSNHVJ?=
 =?utf-8?B?aklxMjJzM0VsQ3JOK05SMVdhYkVXb3BzZ051UnVLVzBHc0o4U1RKb0hBU3Rs?=
 =?utf-8?B?amw3bEpqT1hGT0t4b29qNHM2R0NpcG16RUdQS2hyVUFCaGJpSThWVG92UkRH?=
 =?utf-8?B?MklzQkJSUDFoelFHQmkyeWVjTFVtQTBXMnVmaC9paU5vUVJFdjYycU8zK2pa?=
 =?utf-8?B?Y0pKVU5TZzV2YmlLMWJ1cXZIOUI4S25KK3FpMkxqanczYVh4U053KzZYNCtS?=
 =?utf-8?B?TzZZa1N2MmR3UEk4eEdtTUxCckxHMmUvb3pXSDJCTlB2OVZCWXNEV3B0MFVx?=
 =?utf-8?B?eGRIYm1KVTNRWkVUTGZnMHNqd3V5TkpldG4xZVFNbm9qVVhidTRUbDB2bytD?=
 =?utf-8?B?UXM1cUtmeDZnU1lwUlpXcWkxT2NLTkpHREx5eXhCNjYwK1B4OUNnZEdSemFy?=
 =?utf-8?Q?WuBG7GoYY3JSmTXWJ5t0iHpY5Nglg7DD?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cXQrbHcvNS9VWEZYbVIyQ0YzcnJJM255V0FtRFBmVWNrVE0vTUYzOWh2R2JN?=
 =?utf-8?B?S1pXRytrK3RnVW9aWnlkSk1HUGx1WnJlVklBNWVhU0tSRlFycEF4SDNzY214?=
 =?utf-8?B?Wi9hUkdNcFJPcVBQVmt2c3l5am8zZDJIYUk3RHl4ajZjS3Z4UXRsYS80SjFI?=
 =?utf-8?B?eFZFTjlRR0hSYWlNbG5keFZwMHI2VjRUNS80UEQ3Z24wN2lmYXFRN2xRUStu?=
 =?utf-8?B?b1g1YVVzWVJ1SjZNd2hZNkVMOFI2Zmk2cW1ENUN3WWZIb2hrK29WVGU1SnNz?=
 =?utf-8?B?QmVHRTl0cHdWb2VsQ2hud0VSeER1akZ3S1A1NHNZLzg5Tjk2OUZlNnBkTW9B?=
 =?utf-8?B?NjhNWjVZRHJndGZma0V1N2p5Q2RFeG5ramd2NVI3NU14a1ZKdW15dkZoMGtI?=
 =?utf-8?B?Skx6aHBKQW1TYnNUTEF3QnZJNnBqb0NwZWNEcnRlZHpHR0JqWDAyUDd3YllN?=
 =?utf-8?B?dnZvTmRhNHJlNkZ1MmxUK2hId0VsK2dvTnhTbTJCL2VGRUwraWhvbGlVR0t4?=
 =?utf-8?B?V0FmRzVXd1NlREJMMG01Y1Nka0QxSy94WklZbFZmeDhCNlg2Z1pqdWU4RGw5?=
 =?utf-8?B?d2RtU2lOWmpnUGh2VTVsWDVTUjRwdXlaN3NVZTVESlY4aVpmV3Erb1ZCYTJ1?=
 =?utf-8?B?WHlHeDFNWTl4QU9rVk1lZlh4RGxleTAyWTV5MnRzSUs5U0c0bFV5eFhlUnlK?=
 =?utf-8?B?dlNjTUNLb1lBQnowc2d4NUhnUG5VM0lJOFAvVGJJR09sSTZreFBpUWQrSVNy?=
 =?utf-8?B?WU44YU1sb1FGWTNUeGpwNXBKUjBZUmY4K0ZtQ0JCQVlQcUV5aU5ROTNCWHJo?=
 =?utf-8?B?OFZwZlUwYVhSTVBsUmQ2WFVkcCtPWW9TMWxqeXFPcmxsVm9mZVhSSE9zTVVa?=
 =?utf-8?B?bUpGNVIyMGs3OHlxeStYdDdVNS9nQ2kySi9FVCtnSDduRkxZWTl3M3pnQnJH?=
 =?utf-8?B?SW91M1lEN2NPQnc2Q2NVVzV0WEpSRFErN1hXOFZSNU1kLzA2YSs4dGtHTFA3?=
 =?utf-8?B?SnFqNzAyU2FuWkRMNFBrSXVEZXVhK1dLMncwWWx6NzN6SWVwbW1kdDhlWVJV?=
 =?utf-8?B?S29udlZ4MVYzeEd3ZzFjc3RFS3FlM2lXZ1cxMVhVN3MrdkUzb0JuV0E1cFNZ?=
 =?utf-8?B?NFpieGtreVhydzdMa1lTdUFMajcvRXRvb1M4RVBLaUJJOXQ1YWdiMzhUSDZ5?=
 =?utf-8?B?YXN2TDlTVVF3c1piNjdXUUlQdnV4eDdDeUxVSGgwQzcwU3oxWVdKTFdZYkU4?=
 =?utf-8?B?cFF1TlVKN1VvSDFjRkludWRqZzJWWGgwR2s3VHVoTmpkQ0RuYWpqNFo2YU5S?=
 =?utf-8?B?c01UWnBidTI5RFYvb3NjaEl4STZySmY0Q3BNUnBiZXY4dWdnb2VkcjlYUFla?=
 =?utf-8?B?emxYYUx2T3RyUUdYZGpqRXROZ0l1eXN1TTQyYU5Cb1lDT0dITThOeXdiZURN?=
 =?utf-8?B?bFpCZXFEUUkvZzBXTUdsNHhJb2NSL0xxaUgyekRlTE5tVERpcCtVU2ZocHhv?=
 =?utf-8?B?R0tMWUM2TFcrTHQzRnA1VzRUV2pxVSsrVGNNN1RmRENLclU5YytMa1JyRENS?=
 =?utf-8?B?K29pbHZ1TnR0aDM1TThOWmN0MkpaTVJTa2UrZU9IalVSOWhTd242L3J2NDI0?=
 =?utf-8?B?UjdydUlON2NyUWZRWXIzNXlPRDB5MnR5emhReDNaZW5SeVRFTTliaEtoekdx?=
 =?utf-8?B?ellkNDFSSFo5dE5kbVd5RW1LTWNBNlU2RXgwSXhjSHMydUFDczN5SkxRTDd3?=
 =?utf-8?B?WG83QytoK0dCQUNVTDNGaHBiVEowbTJQYzFzKzgvR0M1aFhRdzd5TG1IZHZR?=
 =?utf-8?B?ZnlZaU44V1dHOHhkK1VvWGkyWjd0N0ZZZFh1WmZiUWVOa2p3OTZJcTR3MWlE?=
 =?utf-8?B?MkVQTnFCdXcra08vSUVNNWovcTdHQzFXMm16ai82anBMTUUySXNnN1dLbE9O?=
 =?utf-8?B?a3J1NkR6aUhHa1NGd2tkSS96STE0R0dzbEs0Um4weUdKRHIyclB2L01nak5C?=
 =?utf-8?B?NTRFZEdjeml5dk5tOXNnM0NoMDNweEpWN0V0MlJ6eld4NWZ2MWhvWG9LNmVx?=
 =?utf-8?B?WW9oUU04TjVhZG1MVlJaYXQ1WCtPcllQdmF5cjFqM1RaMEYyS3pYTWVzREx6?=
 =?utf-8?B?YXhTS0RmdWpnTEZRQ1JaVHBQbjJMNmNMOVMxY2F2RVArQzg3UnpzODVzRm8y?=
 =?utf-8?Q?RRH3f8BiAtqXZcsy8eWSCkpK7PTycjQvL4ftfByP5mGV?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <862C356F46B5D24386AD464E104E2F05@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9404.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 992795ef-b18c-473a-7b5c-08dd3fe546c5
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jan 2025 21:46:52.3458
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Zc2cCabXJcrli1Rh7f5RwR8IeqgSxS8I/dv62vOHzJ2s5mrvr+1prqNjOkLH+dYkHmRlhYmSdDi4ExzGfMRkPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6561
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250128_134706_091297_F84D0242 
X-CRM114-Status: UNSURE (   7.99  )
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

T24gMS8yOC8yNSAwNzoyNSwgS2VpdGggQnVzY2ggd3JvdGU6DQo+IEZyb206IEtlaXRoIEJ1c2No
PGtidXNjaEBrZXJuZWwub3JnPg0KPg0KPiBUbyBzdXBwcmVzcyB0aGUgY29tcGlsZXIgIndhcm5p
bmc6IHN5bWJvbCAnbnZtZV90bHNfYXR0cnNfZ3JvdXAnIHdhcyBub3QNCj4gZGVjbGFyZWQuIFNo
b3VsZCBpdCBiZSBzdGF0aWM/Ig0KPg0KPiBGaXhlczoNCj4gU2lnbmVkLW9mZi1ieTogS2VpdGgg
QnVzY2g8a2J1c2NoQGtlcm5lbC5vcmc+DQo+IC0tLQ0KDQpFbXB0eSBmaXhlcyB0YWcsIGFwYXJ0
IGZyb20gdGhhdCBsb29rcyBnb29kLg0KDQpSZXZpZXdlZC1ieTogQ2hhaXRhbnlhIEt1bGthcm5p
IDxrY2hAbnZpZGlhLmNvbT4NCg0KLWNrDQoNCg0K

