Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10FEACA0FF2
	for <linux-nvme@archiver.kernel.org>; Mon, 25 Aug 2025 19:08:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=e60RlVu6nkHckFJGoI/jn28N5MQZcAaC9Tl4fZtjJwI=; b=DDCeZfhwiCAZeQ5BAhxNaeoPCa
	P55YCTM6M2EIpMrTnEwCJASflDwqPOgQYoQsjXSiCgleyM2XsaVSBXKgUFPMgZWIYPJGvILXaMv+n
	VIcFEUMi/3LWv5hY7D85hohnpdf8UnP44CyusI5uaQIFucSzeYqlUFJmiqecNhtUVF4bOytQoXe5+
	sAhcEPTOK/aDRWihtpj3rwAN1cycxUxpZb7N1NTESeKp8ZiIT4PXE0R8s34MoJdp9ufJvHIXIxaPc
	TSXH9ZnpAFR/X94WAFDbdKo5Hbkr4EP7VvFocylzaL+0hHg+jN/12AmUNCu8u1i2/EB2JPgDtTvx1
	/IuEzHCA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uqcYM-00000009B2e-1h67;
	Mon, 25 Aug 2025 19:08:26 +0000
Received: from mail-bn8nam11on2061f.outbound.protection.outlook.com ([2a01:111:f403:2414::61f] helo=NAM11-BN8-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uqap8-00000008o2A-2xi5
	for linux-nvme@lists.infradead.org;
	Mon, 25 Aug 2025 17:17:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IOzfW2brSEaCcNDA9HWwh8b4jzG7FkX5hpGjD7wMm4LzN+xh2OP2eu8uTt8oAtWmD7tMFBqJNtmhJYaZKtGyWiQpTB3TXa/mNKh1pCG9tPQNMITDFtBHPMetdetHOAKxIMPUBZKNtEdZvBFTBBmKV1kpiGp5rBWU01LKOoGm1cM6Pu/LkJX3rsKIkhSi+kZ6JIHJ8WzIFWZKiHM4ZbXZ1kjpL8+EJoOkmvwxg/Rg6+vXxZJoyIicPe+GtdzCkYQ48f1BQY+y/xHQRf4kWhzsS+7DJR1HBJ/ufj14YP/LEHnuGOhzF07qRi2HfMfkBPumUvXQQiIB5j700/F4OcfnNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e60RlVu6nkHckFJGoI/jn28N5MQZcAaC9Tl4fZtjJwI=;
 b=T6rukHILlNkdIQhJeOJiyue9LWhI3nkGcEg789ziAnxjI5KuroNYha/hwhsim9xXbGDUTXZPjibTQwYa6rfZw/wyoWs0IXo4f2saAMBrKot0pRaBrXxEBU683kFMLjL0n412l2yxiD0UomQAsWEeQ0KzLtJH394aQ6miGryHKtoOFbrgxi+eqAxTM3IjOmUeGpEr8vHRtWdIKAJp7S04fLIVBkfOxVxvrdaWmOQki48l8DelackMYUIJMKop4zqLV+lNXuaqlY7O/a+ifu05BN6h+c2Th/JlnMUWw7geOWMTdu+lMRr3v/IHNuheckDV44DmeR7Cbe4nalbkos7Oeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e60RlVu6nkHckFJGoI/jn28N5MQZcAaC9Tl4fZtjJwI=;
 b=jx8Wq7T/S5C/1WQzzh64VxcGamXhm/q5Rhff4rGmEBgIPSmSPRoEtLwJTOoWYuXZQNl+wUxK0DTeySsQ1uldW/qAh6pVzGP4uQ842TQreUZITdR6XIn/R1E25du5jzbrzyTlr5HVvcAaCIOL/CW8kQBoaoaUcd8c/VR/8RWV7HGh/NkEX36ntbXfWeQhLi/Nl6rd7dwGTl8ZcbsFv3IWWqQNgq7Vsd83dcfvBbhcKHiosiP4Gz1tm3ta9+Y4cfw3faDaG9Hsj1hZrK9vUYvdVxAYqL6xKsV3a3LG/kPUS8CYt8GW80piimOyT1hGt+SRnLewT4bpJ+9qcw/zgG3veA==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by CY3PR12MB9677.namprd12.prod.outlook.com (2603:10b6:930:101::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.21; Mon, 25 Aug
 2025 17:17:35 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b%6]) with mapi id 15.20.9052.014; Mon, 25 Aug 2025
 17:17:34 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Yi Zhang <yi.zhang@redhat.com>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>
CC: "shinichiro.kawasaki@wdc.com" <shinichiro.kawasaki@wdc.com>,
	"dwagner@suse.de" <dwagner@suse.de>
Subject: Re: [PATCH blktests 2/2] nvme/{003,041,044,052,057,058,060,062}:
 update arg for _nvme_connect_subsys
Thread-Topic: [PATCH blktests 2/2] nvme/{003,041,044,052,057,058,060,062}:
 update arg for _nvme_connect_subsys
Thread-Index: AQHcE3sifkNh4kx2+Emt4GV/sHoE/LRzoVQA
Date: Mon, 25 Aug 2025 17:17:34 +0000
Message-ID: <5a8c5646-c4a4-4d9f-ad48-39e8c25f94b7@nvidia.com>
References: <20250822151159.3248900-1-yi.zhang@redhat.com>
In-Reply-To: <20250822151159.3248900-1-yi.zhang@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|CY3PR12MB9677:EE_
x-ms-office365-filtering-correlation-id: 19787d4e-7da9-4365-b7a9-08dde3fb484e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|10070799003|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?S1JNS1pSU0VUUGM4NUgyWEl6elRqZUFtNmdBYWsxSkN4dzlOUjdKZ08xdGVq?=
 =?utf-8?B?Um1FRi9ndGlvS2RLVmtRSGl5ZExzNlRVMjIyR2lvWVZxQ0F6em9DN05MV3kw?=
 =?utf-8?B?WG04eHZIMmlQdFdMa1Z4YXNXZmlWbm1EWjU5TDdEL0MvalIxRlBYOGdNaDZp?=
 =?utf-8?B?S0o4aXlwVGExTUJ4T2hoZmk2L1htM3hhMTlQU2NXb2JqY2VucE9mKzc3QTla?=
 =?utf-8?B?YmloL2lvaGtBR0dOK0lFQUN0WG5tOVdpeUJEZDNVb2Qxc1hlN0xoQXM0Sno1?=
 =?utf-8?B?K094VWQvc0cvTW5CV20xcjhHNWo1M3dZTXlUamE2aUxGRzkyOEM2MlBmbmpZ?=
 =?utf-8?B?OW5QVDlJd2pvbTNMZkJsMkF5R3FQZDMyU0ttNjkzNVBIdEJPbUNFOVNubDhO?=
 =?utf-8?B?VUxDbjV3MzBZM08ySm4vazFBK2k4cVRLLzk0VXpMYVQ3T1o4Tnhzc0pqdDdl?=
 =?utf-8?B?ajkzWnc2aEo4SUdhOE1hYUhFRU9BemRBZ3g5dXRQQjRSTmZqVERzTVRBUTdO?=
 =?utf-8?B?bmg3TUI0UWQ3Z2pLbzh1STJNSkcwRm50c2lCRUt0amdkNS8vWk9KaXhCNnVG?=
 =?utf-8?B?Wlp6Rk9OVHd3ZURoY1pIaWtWbGI5bkN6RjIzaGt4RSt4RUl3QkZJSlZXN216?=
 =?utf-8?B?eDloOU9UbWpZOG5yekZmdkYvU3oyZzBJZ1VvYzFjWTF2YXI2U3VzTCtLZUNB?=
 =?utf-8?B?SU1VZElRdTc4SVQrSVlaVTBBRUdjQmdHc3VOUGN1ZTlVQjk5TmJMSFJJTUNZ?=
 =?utf-8?B?cTdHUlZVeEp6UDlsQ24zbWo5b0xmMUs4SkphYnJ5VnRobDZSVzhYelJrcWVC?=
 =?utf-8?B?cGtza2tORGhUcDVDQ25jSHI5UmxuMU9DYmx6dGhETGFUbDU1VWJwRXFJUXZp?=
 =?utf-8?B?ckw0OHV0bmpUVDYvYVhJeEtkWEtQdEZPR0dWc3V1a0JGSHNtSXVDaTFGTlUv?=
 =?utf-8?B?dkNvWEI0QVVFeEowc2lSL3h1cHhiYWJ2MHZtTVBlMmtKbkxXWk5MNlZnNUFS?=
 =?utf-8?B?YVBRU0ZzTHNIYk9jSUVnZGNRTUgzdVlNWE9palY1b1FqbjNGTkdubU0yVkU3?=
 =?utf-8?B?RmpUbFhPTzN4MVRtL2JWZ3E4K3AxSXlmV0k5SXcwR0xVb2NzMlNCZXNWQ3lN?=
 =?utf-8?B?Y3pWdmdjMDB0NjYvQ2paWFZXQVIyZ2JodXVPNkpGSzFVMXoySDJGb0lrNnVD?=
 =?utf-8?B?RlA4WG13b1JBNEJDQ0R0K3FPWmZlWnZQYXd6TGo4RnR1NzlZNzR2a2ZRU2FE?=
 =?utf-8?B?WDJuZExBSW8vQnBwUFFReitPQnQvVVE0eGpkYWNTRFZ3S0dOa2JnZDV2OXhV?=
 =?utf-8?B?MUx6SUxPQSs0Um8vaEp1bzhNbGJRTlNjelZIR1BDbUczYkFYNFE1LzIwa1RI?=
 =?utf-8?B?V05qbWl6Nm4zdmNRZ2dVendWMkVDUGdXMDMvU1FhZDRUKzhoNmxEQjg5cGRu?=
 =?utf-8?B?b0dLYytNR29BeUU4RTF6SzV5UE1YRE9NVzRZREEweFMyaUFwbmlnUFFlbnow?=
 =?utf-8?B?czJ6SUtRQ2hFK1pCYUlVRi93eVpJOHFhdDBJay9aRE1zM0NtcDNoOGtxbHoy?=
 =?utf-8?B?Q3BmMkZ2VVMyUVhiQTlUekZFMFlTMkdqSUZLK1VmKytnY3Q2dllBdDlzT2JG?=
 =?utf-8?B?eXlPWVhrR0pieEZtZUdYUDduOE50WlVvSFJ5ZDgrZ1g0cjJqUkduNzA3OHBt?=
 =?utf-8?B?R2JpeEJzT3grUUxkTGxKVHpFeGlFdGxOTEZxL0w0UVNxS1lRd25ndmpIMVNi?=
 =?utf-8?B?S3Z5eFFwT1QrUE05dXBQZ3p0N2FVdllqdXVvL1BIOXBOWEljd09TOEU2RTNn?=
 =?utf-8?B?RlJpaXgzVU50Vy9DUUFPYUdMVEYrQjEyTHJaWlRoK0ViVFhjclZ2eWU0Wks3?=
 =?utf-8?B?akxjSVJJK2d2RC9GK1h1elI0b2pycXlrUmFBcm5DZHpoT2pnckVlREF0VlpM?=
 =?utf-8?B?bHUxZEFoSDRnRDFNNUgwMDJFdUhpcXhOZy9rc1B1R3B4S2Q5RVhGdEVoejhN?=
 =?utf-8?B?V05nTTZGRmJ3PT0=?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(10070799003)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?b0hGSDVLeEVubEd4SFhMUUdGeUh5UTRTVkU0cUFtUEF2aGZqZS9nUHh1cGo1?=
 =?utf-8?B?TmYvWWVWWDJsS1JmdmRBem5BL1BOUExZakpENkhIRk1SdUtCZkJ6QmNvdzdV?=
 =?utf-8?B?dXhGbHpiMllSbE9JSjkrdFZpaE5JbzN1Z3RseCtMTmFtZFB5MFF6bW1wdEh3?=
 =?utf-8?B?VkVRSFVzRlRmdHRFZmRqT2FLcDZuNnJlU051YnBYenkyUTU5c1BOaUZJZmZY?=
 =?utf-8?B?eDcxMlpTdkZ5cHY3TjMwcnVjTitLUW5nYUFTTFdGSUhXbzdWOEkzeTgwTVMx?=
 =?utf-8?B?ZzhEWW1KNWQ1dnRTUnlXS3ZzV2NxRDFBSzVtZ0kyUWtMNUxhTmQzVmRsRnps?=
 =?utf-8?B?WUNsWkNPWE1mL1lLUUpBSzhHSE1iWDZrNzhHZVp1SjArbGcrYXNFV2dGUXlk?=
 =?utf-8?B?bVh2RmJiQUJFWHhHRXFPTWlrRDVHYUttUEU4OWd3MnVzT0NVMjFaU0xpd0ht?=
 =?utf-8?B?QUl4VW9DSzhieTBVSXk3M1d4dldrZnFJRGFrRVFWaXpLZUliUWFlVFllOUpq?=
 =?utf-8?B?YVQ2eXRmWWZ0b3pSd3RKeUVWMm1zaUlNQS9ibUtwbVZHdFEvZHJ6S2sxZHZU?=
 =?utf-8?B?dnVHK2E0Y3hlekdrQVhuSFVUL3V6bTJQQ0NLNm5mRGU4QkFyWlBua2NEdG9E?=
 =?utf-8?B?Z1F4WHdJVXBheCs5RkNqWXg3OFFpM3FFZTg4dklHK0RpUmZndkVpWE5RczBx?=
 =?utf-8?B?Q0haR3ptVGo5a2NnWHBEZm14ZExzeFlqVkp1NXZqaHZjOUJhdnZJVjFpOUNr?=
 =?utf-8?B?OUFpRGhmejFlYUtVWm82SG84Ujgxa2h1OTRnaUJHYWNXd2xTT1Jvb2ZMeXgy?=
 =?utf-8?B?bUVZK0hjaHY3cFI1WkdWYzc0RUpIMUs3SDlCTlErYVVwWm1JTjYxb3JJS0Zu?=
 =?utf-8?B?enBkU2hqQUZBVEF6c2Fpd0Z4RW9MSGpSK2FieGpCOVJITWM4WmxaVVZhcnBj?=
 =?utf-8?B?aDRwVVJNbVROaXdtUC9PQnpnNmE5T2F0SXFtOGo0ajkxcFJEdnNETEdxZnBU?=
 =?utf-8?B?ZUVvTFM3S3hUT0VwcHd0N080TVI5ZHZlbjVDclhKRmtNb1o5MmxkelZKTk05?=
 =?utf-8?B?TGs2d05tVEdUdHNHV09rUXAxOGIvamFOcG5BTkhZekxtN1IyZVBuYXI1MHFS?=
 =?utf-8?B?eXpjOUlzMHl5L2hZSEVRbFZzQzJvNXhpdGpvZzFXN2N6MXRzNTVlNnExTUR4?=
 =?utf-8?B?SlltTVhqT0Foam1ELzF5bVo3RGhIdTE4bHJ5UmdFbk5MR1liNjBVQkRLcm1T?=
 =?utf-8?B?REFhN1BXcXR4Unc0eFRBTmhKWG03dVRMZjltbkl0ZzM0T3UwczdLMUZjNGlu?=
 =?utf-8?B?dlVKVHZqZk5pMk52eGFXTnQzZzV4UDZGdmtLLzVoUytvd1hqdm1XOEhTU3pj?=
 =?utf-8?B?LzhhWGgxbUNleTFBTDlMNDc5NXNORFc2Zm5kbWlxcnh6R0RTaHFna2d4cGZx?=
 =?utf-8?B?ejBoVnEyM1YxSGVWUzRkOEhMQjlnd2FNYTd2MjllMUFLdm9jS3hYRi9haWZE?=
 =?utf-8?B?ZFRLQVZUQm9GWEtuL0o5NmVoeFdZT0JaTXZ0V29GWG1ESTJncUdkQllHUkM1?=
 =?utf-8?B?c1ZoOWtPVXJOdzlmdSsrSnJaSllzRGMrOUJ0SkFVN21CZGcwKytGN2tXcDFG?=
 =?utf-8?B?eE4vRWhFTEVHNWRLcGtTTncvS0k4UnBRTDFNNVRiVEY0QlFSbW5kQ3ZMSXUx?=
 =?utf-8?B?OXc0a3dxN3krTWJQWTFScEZja1ZtZjlWV1Y5elRNS0ZsUEd1TEVWNUIya2dr?=
 =?utf-8?B?MDV0Q3h0ZnY1TlBYc3hsYmNBL1BJYUtJRVA4WVNEbGxmQndUMkNDN21PY0Ju?=
 =?utf-8?B?ZEt5RzFxbEJFQUh0SXhKY2p5N3QyRFZOellFSUFZSGV2b0JaQUNEQWtqQkF2?=
 =?utf-8?B?akVuYkVwZ2o0RVBMUEtjcVpTOE96VzU5YzhXbExOM1owNVI0cWoxS0VqR25R?=
 =?utf-8?B?T1RIRzBsaU12RWN2SDVCdjkxSmF0VU41WS93SXBRS1NaMW9FdEVHKzVmZlFC?=
 =?utf-8?B?ODRzVmEyR1RXMitENVNwWEo3RC9pSXY4OFE1aFFhaWZIN0ZQbjhtSjZ2RE5j?=
 =?utf-8?B?WklWZVUrMnhOYmpYa29kbjB2NnlERkNrdS9Ya3dTbjAwRVozc1ZDdHdqQllt?=
 =?utf-8?B?eG0xRXNRSmlqYUNiSW9ZU2RvcHBiTXNtSVdZSlhBWllwNjNrOTI2bG5ZcjFO?=
 =?utf-8?Q?HDpkFWe796d9yuOm6W2n+m7AOZkHmEwF9qWZI6FisVsm?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <104CDAD57ADB5041AEF584BECCEA0B6F@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9404.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19787d4e-7da9-4365-b7a9-08dde3fb484e
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Aug 2025 17:17:34.5740
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TnkoGi3QnMSnLWzW7i49Wck0sZ2fGMbpkdy5oMaNNlCE8LuCjDUcG9JzHX1WQAnBb0oB57zSEYtyOZO8G4YCBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY3PR12MB9677
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250825_101738_743182_CEA63B35 
X-CRM114-Status: UNSURE (   9.77  )
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

T24gOC8yMi8yNSAwODoxMSwgWWkgWmhhbmcgd3JvdGU6DQo+IFRoZSBwcmV2aW91cyBwYXRjaCBj
aGFuZ2VkIHRoZSBkZWZhdWx0IGJlaGF2aW9yIG9mIF9udm1lX2Nvbm5lY3Rfc3Vic3lzDQo+IHRv
IHdhaXQgZm9yIHRoZSBuYW1lc3BhY2UgcmVhZHksIGJ1dCB3ZSBoYXZlIHNvbWUgY2FzZXMgdGhh
dCBkb24ndCBuZWVkDQo+IHRvIHdhaXQgZm9yIHRoZSBjb250cm9sbGVyIG9yIG5hbWVzcGFjZSBy
ZWFkeSwgc28gYWRkDQo+IC0tbm8td2FpdC1ucy8tLW5vLXdhaXQgZm9yIHRoZXNlIGNhc2VzDQo+
DQo+IFNpZ25lZC1vZmYtYnk6IFlpIFpoYW5nPHlpLnpoYW5nQHJlZGhhdC5jb20+DQoNCg0KTG9v
a3MgZ29vZC4NCg0KUmV2aWV3ZWQtYnk6IENoYWl0YW55YSBLdWxrYXJuaSA8a2NoQG52aWRpYS5j
b20+DQoNCi1jaw0KDQoNCg==

