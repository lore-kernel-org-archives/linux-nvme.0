Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 365D8D1813C
	for <linux-nvme@archiver.kernel.org>; Mon, 14 Oct 2024 18:29:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/9WNl1mAePH6lJoSIdd26MpXjw2fMPH262VyLQWb10Q=; b=dailu4UBxDgBSAXwjCfg21rn6C
	Ju+DISivdV7Q7nFmHzgVxbLzndvVhXP2W1fWqQ3zQzmmSt43LsLGOSNdrS05ynAIP4dgXAQfA65lQ
	T79MekhmspiCVaA5QrauANYEYIl5C0kbmLa2+WvogQeJx57z7F8QsRM/QyzUD/wGl0WL3FilNZza+
	0kjNN/R91QTGJHKQj4M4CY9Iv4I1q3MSQmQ/G5UMpKHyfFwWzrmXDIe6HynaFSXBL5Ii4JjdTIhz+
	Ib4mVqdvLIbh6OZxPT5ubN0m1DFrxCm9YCEHLKP1a0FIRCdevFSqPRvVgZ5QMMD/vEXvJPmTBCFds
	4KgYXp5Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t0Pof-00000006Aoa-1agE;
	Mon, 14 Oct 2024 18:29:13 +0000
Received: from mail-dm6nam10on20615.outbound.protection.outlook.com ([2a01:111:f403:2413::615] helo=NAM10-DM6-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t0PmG-00000006Abd-3mUe
	for linux-nvme@lists.infradead.org;
	Mon, 14 Oct 2024 18:26:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iGLCNEaPcwJpoNeekEy/6r5EDBzGecnQ+16HS0Eyuiy+Svjdaq3TZYo6Fy4gbSEx1aSUAAyhGrAQlkkdgvrYDX0p1XqetjErBiaYDUPs5b4xyba0PNGOvBJvTqknrqZvBMz7/1Gcn0eh5iioOd2feTZ4j/r8nuQOXIqNqDzO3OaRpqqY2pptO2fYOw01S98/b3CPuH0w/SJgcAhY34SSJuBoXfUHVDF9l9Z0xCvMhaMx1OnflfcNE1SaW7LG02MPc/vp3s8vTfCrajOWbtlPD8N+/Zd0P1TLm9tzGzelyck/yzEE+QxgS8H24M3zY+ItuImq+BGpssjK3WCaFioHyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/9WNl1mAePH6lJoSIdd26MpXjw2fMPH262VyLQWb10Q=;
 b=VrbP91tZM3tcnNL7gDUg+M5AJdcLFkBkBNljGY3EIVoyWQDs6lbYgbWOn2CZrelem8JGvDzmcMw19nQ20wGGsvK7IIOokB3ACwBtJpjqSqsIX7LRsUkQlROMgRXMpNUFIY+9X8deTwNvxnechn3LGOG5tpMQK/lFZPvZQs1g4E0hDmD7FkoVpg8O1HRu4Ca9azWM4MNDHJYqmJEi4rSpwrBqmdAgsrKeady0xVA2qcExniGxdndJy7zY4wsm4iQIorklDMv/OfzTloazDUlWpXxQvMA5heRQJsVS6IYbxulgJhOqjXcY2Ge8kmmeL/Dx3/OTOrX6UsULPzM6MZajWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/9WNl1mAePH6lJoSIdd26MpXjw2fMPH262VyLQWb10Q=;
 b=fLpYrZTBdXcYAAO1/II1ZaZaGfLKv+4GGL2TL63J9j4BZb0b72Bc4Rf5nYEt/XE5KA1PhdgbNKulnt4cX+2HUgMdPiUQ5/4OlJaoHidGMWt+LrwhIrjYK4yrmjQZQCJU8hP7mCFTMlhC7xyHbbT8wjnetAnvJuQqpVaC1jq1lMetx1ZDJ6EWRTesqbwkZNnMIv0P69727nvyeq3VlV4o7NaBjS8JJybNLy0H9b6wHJE/qv7WbNhmokkr4t7xSoso4ZBpYH6oxX5V5de+L+HhIVJW+RjJzsR3YWlv1hs+YrAZd8OzydqZh1p/L5A+zAL+UbJJif5LObOsLv9fQ4c/sQ==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by MW4PR12MB6922.namprd12.prod.outlook.com (2603:10b6:303:207::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.26; Mon, 14 Oct
 2024 18:26:22 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b%5]) with mapi id 15.20.8048.020; Mon, 14 Oct 2024
 18:26:22 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Guixin Liu <kanie@linux.alibaba.com>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"hch@lst.de" <hch@lst.de>, Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	"sagi@grimberg.me" <sagi@grimberg.me>, "kbusch@kernel.org"
	<kbusch@kernel.org>, "axboe@kernel.dk" <axboe@kernel.dk>
Subject: Re: [PATCH 1/2] nvme: parse reservation commands's action and rtype
 to string
Thread-Topic: [PATCH 1/2] nvme: parse reservation commands's action and rtype
 to string
Thread-Index: AQHbHiH2l5Gd7KWIC0STmw2KagmQS7KGkN8A
Date: Mon, 14 Oct 2024 18:26:22 +0000
Message-ID: <1d548c2b-29be-4c6f-8fd4-f0c19542fde4@nvidia.com>
References: <20241014101458.80491-1-kanie@linux.alibaba.com>
 <20241014101458.80491-2-kanie@linux.alibaba.com>
In-Reply-To: <20241014101458.80491-2-kanie@linux.alibaba.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|MW4PR12MB6922:EE_
x-ms-office365-filtering-correlation-id: 7ff5dd27-eddd-46c2-7aba-08dcec7db4da
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|10070799003|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?NCtsNmRNNEM2S0w1UUlsQWovcHZrTTNETUNwb2N5UmNUY291S055bFU2Nisy?=
 =?utf-8?B?RGpZYk9UeVY1NXpmaExjUGRFZkFpdDJmeUV0eENYMHh0S3Ard21SNmdjZXRW?=
 =?utf-8?B?UVhDMGkzYitBZmFJWWF1bUJsRzduZ1diWThESWx5MnNYZXFpS2JrUENWcndI?=
 =?utf-8?B?eVJPRmVOVG50LzdEcnIyNSsyZmM3RGZTWXhLUTU2SjlVQmpVc09kV0xoaU5u?=
 =?utf-8?B?ekNHQkVlOVdwRkhUUGc3VDhjUnNaWWpQdE9qOEQ4QytTVnd0M2hvVm41OU1r?=
 =?utf-8?B?SzVNZmFzTmFEV00rMDJLWXVOdUpmVnpqQ3psSTljSjlqQ3o2YWpGWFdlb1lI?=
 =?utf-8?B?VGYxSTliNGNwbTVLRmdPVDdnUjl5bUNBSno2aTRWU2JuMlFiWGRIU1pOUWQv?=
 =?utf-8?B?TVlqSkoyYS9LekdNcGNFTE55UHpVa0liQzdrSVp5S29CL2lQMHN3ZGRvM3NL?=
 =?utf-8?B?cjRoLzZ1cWVSZzY1NVRGL3BZQ00xaGtVaHNCWWdYTVBwcW1JcmNuU0hmQ1VE?=
 =?utf-8?B?RDl4ZW1naVZHZzI1TXl3THBDUzZDSXZVaHhQdFBCSnFmWUFlTmVOek41b0dF?=
 =?utf-8?B?ejJnUGpPK0QrRU5pdGRnTVNqTitwWW5nR284VkQzRGdoem9xWGRNaVpxbytU?=
 =?utf-8?B?UDBPQyt0QWxYSlArVDdkWlMrQ2x0ai9WeDg0L3RUSENJZmdOZVdHbi81ZzIx?=
 =?utf-8?B?em40U0pNZUFGbTB0L1NRNWJSd01MR1Y3UFVqcHhwNmxWMHhwSk90cktrTm0z?=
 =?utf-8?B?RUgyQnJxN2o4cWxHT1A0VkR6Qmtudk9tamlwVmJrVUd0Rzc3dHF5d05UL0xW?=
 =?utf-8?B?OTFGZ1huRkNleFdmTWd3TW05K3NnOUZMNHBEQWZMNXd2aEJhMWRjMVRtbGJR?=
 =?utf-8?B?TE5NM0hKZnNWRWpCMElGMk9QeVE2cE5WOTdJenFuZXlpRitXbXNOOFNkTzU0?=
 =?utf-8?B?UVVvWjRmYjBoSlhZVlhpMXVMc3RYQ0pDLy9VZU9pcUsxdkJicjJ0cUZwSTA5?=
 =?utf-8?B?aWtUSk0zZlhMdThuZmtwU3VJbTdxYWc2QUhNNkZ0TkgzYWNoNnJRR0NIRjBl?=
 =?utf-8?B?V3A5Z0RvVlBWZ3JULzdsTmdMeWJ4WkZkVHhhNjJHVURueVN0Mmo0UDBoUnVj?=
 =?utf-8?B?NVNzanR0UE1HNmVsNU5EdkloSzZxQThXaEhJaWhOQkM1enViblNIS21xc01j?=
 =?utf-8?B?UVNPVHo1a1J0allNSWdYMlhmQXRNRWVKVXpzZkJtVUhkNHhXYXJJZllFN21D?=
 =?utf-8?B?T01TMGs2K3FTRGUrNTZHL0VrV0swcURVdy9FaWUzUUJmZDBwOU5obWVTSkN4?=
 =?utf-8?B?OXliN3NvQS9pMi9sRHd3djRkNGN5YU1VRGxVSUlZRmV3d1M1TU92TFZDYnhV?=
 =?utf-8?B?dW5vR3FrZzI4TVBnbk9ObjhLUVpyV09jcU5BaXBzL2g5NWJ2TkVWKzg4c0ZS?=
 =?utf-8?B?eDN6UytwOStUYXA4MDRPdy9Sb2ZTdjRvNERvM29lZEtKaTh3TlBPd3psR3Fu?=
 =?utf-8?B?dFFYTnA4cGFPcUpvWnlSMjZOMGMxZFhuZTN5bmtqQWYvaWxmTVBnYTI4YjlX?=
 =?utf-8?B?dDh3R2JqVForTktpbnVHZVlIeWI3TTc1cUdqZFZobUd3Yy9JM25NanNTREV5?=
 =?utf-8?B?M1VFVVlJaU1sMGRuOVdjSnE0M0hIcDBvbWtFeG9WVzluNDFxbVl5ZWNtT3BZ?=
 =?utf-8?B?ZFAzWkVxSFNPMTRiMnM1NHZzSXJ6NmR5U0JsbUlVSjI4cWJzOWk5TG1ZR2Za?=
 =?utf-8?B?OGtKK1Y1bWhzeDFtT2wyVEJjTUlqRmQycjdkSDRNaXF0Y1dsS1Z2SXNlYmlt?=
 =?utf-8?B?bWI1bUpodE13ZVZucFAvZz09?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MFgyQllyL3VPcUE2ekRRaDdIZStkSU5zZGNnbStKWFJVMWZkOGp4cU96cFkz?=
 =?utf-8?B?ZG5Bb1Z5Z1FJRGpPYVZqYjVGbStaa3J6bExQaFdhbDhNb2EreG5HbU9VTEFa?=
 =?utf-8?B?T3RWWXhpYlBONFlNNjJjcU12YmgvdXFROVg1RG1pbnArdGROaCtiYTFCSk9Z?=
 =?utf-8?B?WG0reEJscFNiMmZYbEh1d2paMFliam90SlI3WUxNbjBGVDRmTUs5TGpqSVpq?=
 =?utf-8?B?bXJOVk5YbzBrdmh1SGxrVkIxaFRpc3p6dmJsbUN4dDBJcGo2MHI1bW12QVJ4?=
 =?utf-8?B?d2hhTE1IbDY1ODFESGpzTHlVbjJWV01FdkYrV1RDMm1lL3Vmb3VuM2s4aE5L?=
 =?utf-8?B?dGNheXpEVzdWdzdqYmp2eWR6bEwxMHloNHlTcEh6WWc1bDFRMWNoSUJDODdC?=
 =?utf-8?B?dlo4MS9HQ0VWcUNMR1dpeGkxUEFJYXR0elpUZFR6VTZYdmNyczdwN1lIRWh5?=
 =?utf-8?B?d2FaeDc3TTM1aE13TFJDbzIra3lud3VWWlVGcjNPYW9qeFBtOTlsbjlmU2hx?=
 =?utf-8?B?WW9DMCthNG15N3dhb1lJalNIdDcvQ0dhMWx6QUQ5RFozK0RqdFNjN2JPcFF1?=
 =?utf-8?B?ZkIrRzcxT2xXSW1pT1VIVFJISmFvRUhFbWJoNWVnWFFHa1hxSmliSktuVUNp?=
 =?utf-8?B?QW9zVmlaY3Y1Q1dKRlhEM3dmQ1RWT0hNaXpud3QrOVowMVh6MWljU3NWNWhG?=
 =?utf-8?B?SUM4cFlmSXhIYURiS0hjZkZTcTkya0gwUzBHd1FzWWRETUdxMFd1VEZvT2VG?=
 =?utf-8?B?U0hjdFpNakliV2dHMTMyT2ZSZ3MyRmc5WkZBalpmWEtBWmxxSmhxQW1yOUpY?=
 =?utf-8?B?SXhoRXkvQk5xK3JTUjhvb2R4VXVtSlZjVTI5bmZGTTdyb1hFczRDM3dnRktD?=
 =?utf-8?B?enMxYXdPWFZuTHlHK0d4aFBpSW9QdTY3NGRuN0QyMTR4QzRZcDhnTTNSa1Jp?=
 =?utf-8?B?NEpWODd4dTdDR0R4aWZaWHdZVEdXVjk3WmxjdzhNT3ZaNzN3dUE4MFNZSTdK?=
 =?utf-8?B?Zm40YmpOeEFoZ1RBVU5ubEtGYTFPZUJWMld6TEY1aTZuRXZGVGJSRUlDZVVR?=
 =?utf-8?B?VDVESmg0cmw1ZHpjY2w1QU4vQkUzQVJMQ1VHQTBkMjNEYStjV1UzQWx0MUM5?=
 =?utf-8?B?ZWZqM2FjUWo1SzNxK3RUc3p3NzhVWGNOR3NRb2E2WmQ1TXZBc1IrRU5JeVZx?=
 =?utf-8?B?elRmeEljZmVXZlRPbFBReDcvR3RVVTgyQmkybFQzcFVQc21yMXk1d0RlWlAw?=
 =?utf-8?B?TFV4R1dXaGgxc3JIakY2RWFMZ3AzUGdqcXRVZFpac29DSmhWWU9YV1NsK3ho?=
 =?utf-8?B?RDlWbWQ1Rkp6b2ZJdHhzTExuM2FONklINzJDaVl6YmFtdUFUL0IzQ1EzamJw?=
 =?utf-8?B?MjkwMkhTWkh0TUg3K3RhMU1sZU8wWWF3UGFXeW9KeUJ1aHFhelVZZzgzS2d2?=
 =?utf-8?B?bVdzL001dk1uVkxqUnlDNWdYUnZ3aEVNNnIxWmFPVjV3VDFWNVQ1VmFSdlk1?=
 =?utf-8?B?Y2svMmdoL3N1dy9oL0VuRHc5a1BrQm91Smp0UW5aV3NxU1hLODl6ellTd3BU?=
 =?utf-8?B?RXZUb3NWWFNpVW9nNlNTdzVaUkYrN2s4aTdLVStMazdGZzV2Z3IwamxYbHdZ?=
 =?utf-8?B?NjBXcEk2OCtzNnlhdmRpTXNVd2EyellLTWJwczZ0ZmFCRExkTHFyaysyL2pZ?=
 =?utf-8?B?VHpGRzJDOHRXN29Ua3laK0c2Z2VIMUNXMXYrbytObXRoaVlVclY2NHR6aHFa?=
 =?utf-8?B?M0VBMFFueHFtOG83Q2VIV3R5QkNPbGtETlNNZkxOc3o0TFN1TDV2WGdaNnJj?=
 =?utf-8?B?WUNLbW1CaTlraWJxaFVldldKRnhVdDVTRUFYVFcxOEk4R3FNd1JBVXk2TFpQ?=
 =?utf-8?B?Y09PVHNWSGUyaFFxbzZMbHVxbzNnQU1pT2lGUitTdk9ISDJESDdLWGJIWlFs?=
 =?utf-8?B?OS8wY241WktxajBhUkZra1NuMzI5TWk5TUkzeldhbWZneGxwWU5hVTFlNVpt?=
 =?utf-8?B?SC9EWnlRQUNzTnRMa1FLaGxDRFNsY0hUNWxVMEQ2a2IzZkF0ZWtrUTRRSGpT?=
 =?utf-8?B?VGpjNm1wSWIrclJEZDMzWkp3WWdRa0JPRHlEVlJQM2x1aHA3NWE0TXZUS2F5?=
 =?utf-8?B?Y25UNFpJTFFUQW1lVWhFREtWSFMzRWRRVWhTSFUxckF6N1E0aHhFK1NyTjRK?=
 =?utf-8?Q?ECY1M0k8KlDjIAJIw0gMKGhF/VW1NKCtCZvcNOphwphE?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8D4C2D22D919DC4B8E4E5F0B3BA9B78D@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9404.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ff5dd27-eddd-46c2-7aba-08dcec7db4da
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Oct 2024 18:26:22.8936
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RD3h/8OBEO/Bgr5e3ASR96vw0Vukv2fH/9+5h6nj7lONrDe3TLXiIpYr5bZK+Alc3D+SpirWBo/BlorDHj4mXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6922
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241014_112644_994468_4ECA8845 
X-CRM114-Status: UNSURE (   7.06  )
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

T24gMTAvMTQvMjQgMDM6MTQsIEd1aXhpbiBMaXUgd3JvdGU6DQo+IFBhcnNlIHJlc2VydmF0aW9u
IGNvbW1hbmRzJ3MgYWN0aW9uKGluY2x1ZGluZyBycmVnYSwgcmFjcWEgYW5kIHJyZWxhKQ0KPiBh
bmQgcnR5cGUgdG8gc3RyaW5nIHRvIG1ha2UgdGhlIHRyYWNlIGxvZyBtb3JlIGh1bWFuLXJlYWRh
YmxlLg0KPg0KPiBTaWduZWQtb2ZmLWJ5OiBHdWl4aW4gTGl1PGthbmllQGxpbnV4LmFsaWJhYmEu
Y29tPg0KDQpMb29rcyBnb29kLg0KDQpSZXZpZXdlZC1ieTogQ2hhaXRhbnlhIEt1bGthcm5pIDxr
Y2hAbnZpZGlhLmNvbT4NCg0KLWNrDQoNCg0K

