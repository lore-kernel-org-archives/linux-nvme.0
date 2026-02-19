Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E275BE9A054
	for <linux-nvme@archiver.kernel.org>; Thu, 19 Feb 2026 19:26:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=W204OBQn6k9AQF5TFNOUYqgJcsQvOjjy3MrLUjNU2Go=; b=IelrnUHCN1IXaCIIEtOjVaXjhl
	jwTP4d+eU+rs6SuTn7ArxpaLZonljxLBC0VUosP7BoyWU5XEhqRXwsfib670BEut66Ioh0nirTT+G
	OCEPFN4inKzhW0c5hg5gkxdr8K9BE04cCaEL8TXrhMRwZqroWf4Im/uXTqTJSRO9Jk35MDqaV/vQN
	Ap56CiM3C5rT1IuDM25sEslocTRHzvW6FepHF3mbTJvyjAShuvZViqws02/2tbN8bbKHCUZ33jh2C
	5x4qKAls9qwbFiJzN9ZxPkbveF/cYxtbmPZ463LPySgQzuKn3zR3rvfsdVzNJyzr3Ov/Qgm7J0hrN
	Bm2n+vPg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vt9fl-0000000BqHe-0sCM;
	Thu, 19 Feb 2026 19:26:49 +0000
Received: from mail-northcentralusazon11013028.outbound.protection.outlook.com ([40.107.201.28] helo=CH4PR04CU002.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vt9fe-0000000BqH5-2zj6
	for linux-nvme@lists.infradead.org;
	Thu, 19 Feb 2026 19:26:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ekWvh57PTPRjX/EZOiAJhU/VnViiE1fJAuAXrLzDFMRC20DjvMztLGdNwmSlBBgbP7NOGS5+xbq1k9NrdNOneiQ5paT8H5tAGrqRuANNstMTOHK9KsxPqDcnHkd0NKwdZFFS+hr+v9dkObyF+vjrmmYWJhNjsS4jATRbK5PB4QCyZfK3AGe4ZH0qglHVCUAIN9CFj7i1L9WBL7I2v+S7j6nHlMeIKBp+BwHlYJ2BH2UO/3NT5Ip0eOgeMpd8xWL30DhKq12jVDwpKsUGhgMjwEeWCZiG6/gKcdZeFCffe5sqAouYgaYvwwuiEK8wMqSxI4t+TANfkmbJ583c3R5Eng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W204OBQn6k9AQF5TFNOUYqgJcsQvOjjy3MrLUjNU2Go=;
 b=Os646gW+++jLz13ffsPXBWGkm+Nx20rXHbFNZTbDZh+hyBNC1skQJ4/AgxMz3h4Vy4H5IxRMw7SHu9JoQGjJZ7NfOJJiRpyil8h56y6atI+UhH0BxXNXSBu1KnabpaaQE1Dh2gbyH6KJKV6zEKc6LwN73ZhNpSLJutTLA9FQAp9f6WXOedctvbI3e0HTf5g4DRybTsxiE+uXpnWVMUPJiHekKKM6pbEupJEfthBCqVuxFCa54SDHeDW5+YA5lYY+BWtFUmCOTTwwaW4q/ZdJwAInij222ocxZQaEE9zUvX9DCbrXTdSZB9sFzvcvP+bpSe5rt24S+P8GzFPpW75KnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W204OBQn6k9AQF5TFNOUYqgJcsQvOjjy3MrLUjNU2Go=;
 b=GoueqF59h1kG30qmCGLcRDFIAGh1x+fzMqxHKJ4iSM2KL1XsOAr/Xv2t0+3nt8BUTIDykEdjrs0vCR50I98GL+CFP6CtXoFMNbjCYr00LvulkW3gTadPZxdIRlmgwiHe/eUqKoXbyli4GTtOSk8mP8+XmHvkUhAN7+ALOyyN5g69Jy4Nx18ef0RIkF2/6WTkviK/chGlwCGcCZBJt7gbI56FprpQvj7lvQ4/9zYsibs0oTDCSAW8nXzxprh+FW5hCGdxDRI7WzLCYjZAICZIHr/TV00N2Vf88Nr4QqMKCM+Rd2bvl5REXeA+AR6i0983POMinnSTKhaZVdSI7muz7A==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by PH0PR12MB7931.namprd12.prod.outlook.com (2603:10b6:510:289::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.15; Thu, 19 Feb
 2026 19:26:35 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::2109:679c:3b3e:b008]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::2109:679c:3b3e:b008%6]) with mapi id 15.20.9611.013; Thu, 19 Feb 2026
 19:26:35 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Joel Granados <joel.granados@kernel.org>,
	"lsf-pc@lists.linux-foundation.org" <lsf-pc@lists.linux-foundation.org>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [LSF/MM/BPF TOPIC] NVMe Controller Data Queue (CDQ)
Thread-Topic: [LSF/MM/BPF TOPIC] NVMe Controller Data Queue (CDQ)
Thread-Index: AQHcoM7TjmhrI/vlUE6DMJ/C63H6drWKabMA
Date: Thu, 19 Feb 2026 19:26:35 +0000
Message-ID: <27b4c014-adb1-439e-b3f6-bc2030b6009d@nvidia.com>
References: <jrhwaqetlzkyo4gvjql2of2gohxlbrzezkyccqliyh2rybtpqb@kykxmeta5gx6>
In-Reply-To: <jrhwaqetlzkyo4gvjql2of2gohxlbrzezkyccqliyh2rybtpqb@kykxmeta5gx6>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|PH0PR12MB7931:EE_
x-ms-office365-filtering-correlation-id: caace770-6643-4a36-9f9a-08de6feccb9d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|10070799003|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?OFZoeWtYMEVHeDBOV1VkamFDdnVuVGxwWk5lYzRjTUF5M0MwNTBnUmJ0MGxk?=
 =?utf-8?B?RmRSTmlhUHZSOGZLZjVZQjh2TWQyRDVTUUFoclM3NzFkc3JFVjdUWDlENDQr?=
 =?utf-8?B?TVQ3aVZrS05Ec1NycytFUDBGWHNjWUJQVHZZdHd2b2RsdWtHV2UydHhpRVRj?=
 =?utf-8?B?aUtHSDIzL3IvTzlRb1EwbHJFaUlHWmJiclJlc2JCZUFRR3A5TldJbWtHbjFo?=
 =?utf-8?B?R0l2T3g2N0g0NGQ4U1FaNVdqa1FTQjMxS2t2VXBEd1RXVHpjdDEybzNWMVAv?=
 =?utf-8?B?cDBKdUx2SVY5NlBRS1plNmFlOHh6MklYZXlRR0pVZENiNlZ2TG9BaFEwZ21p?=
 =?utf-8?B?TldLMG9McWdKNGFyUCt2TS9zSXc4aXptRXpXZ3JienY3NGFNVmpPSnlzMGtl?=
 =?utf-8?B?dWQ4azBCWkVLenVQK1Q4VEdRMldkeG5oOWptMHRsZ0xXNHdvcjh4aWY1ZXMz?=
 =?utf-8?B?U0FCVldmc3B3aHJTSEZyYUcybGRMSE14QUgrNDcraUxhVjNwN0lXSGpRWXpa?=
 =?utf-8?B?c2dLTWFjSWIwRHNsUCt2MndQTXVXQjJJUUhBem9SUnlnclhZdzFiSnkzNk9W?=
 =?utf-8?B?cUtBT3ZGRHdxQjBDQnlwWVhtUktmZFlyM0QyTXBIRk1Sa3VqQnptZm5Tb2Fl?=
 =?utf-8?B?MldUSUNnbHVBWlFnTTVCZzJoYjJiVDRscWV3K2RWWnQ2dXB5YjNyQVAxRTVa?=
 =?utf-8?B?Uk9KZ05UQkRRVTdDMG9MN010cFBSWjlsbWVhMWIzR3k5SHkxZGV3RXRNY2gr?=
 =?utf-8?B?NnFnZXIyNUpJSi85dUUxcEVHNG1FVDdoSFh2Z3Z0Mi95clZRNFhuT1pzTTR0?=
 =?utf-8?B?NVRCRzk4eXJBTUp4OWpyZkdSYm9uV0dwWEQrQTg5WGtzeU1sZVBSTTRnZTJv?=
 =?utf-8?B?Y1FqREhUVXlYS1ZKQnJ6T3F0alZCOXNXc01uWU5PM3NEV0RlcWszWDE0c0FL?=
 =?utf-8?B?MkZBdllkQk80Q2pSc0pKd1BwR0dOQlNrbWFwUjBtTEhvK1hOSUlZSXRIMHJ5?=
 =?utf-8?B?TlFhWE0wZ1krMzRlM0xKTkRhSUZucUFBQWN3WWVJS3kxcEZRZFE3RFNIaytn?=
 =?utf-8?B?VnJENENqRzFYWDViRVpDZE45MjdEc1RiL3FMTVAzY2NkTzVZd2lEZEJMSith?=
 =?utf-8?B?ZUZxRUI5RkFyM2dXeHpYVUI4WFp0WGdZd3dBOXA5NlNSOWtDYmpJcUo0VVJs?=
 =?utf-8?B?aWRLRGRIUWhDc0d4ME5HSE1iQ25tdHYrelUrTE5qb0Jjb0Q5YnorZCt4WXZU?=
 =?utf-8?B?U2R4V0JDbmtTd3dxZTc1cmpHQUNScVVsYi9waTR2SlhOaEsxSzVUUlVkTjBS?=
 =?utf-8?B?djhOZktFc3FBQng1YSt5TUJydzFHOTRoa3lCaDd6Q2lVYVR4eUVqT1N1Rmlm?=
 =?utf-8?B?SURMUThHMGpOR2F4T3N0OC9sdG1ISTZmZ2d4WjJLWE9vR281SkQ1bU8yZFFj?=
 =?utf-8?B?VjdNM0l3cUFoRlF6aHhIeE1xK1JtUWlDcy8rM1VJekZ2ZzA2dmVBd1FQcE04?=
 =?utf-8?B?VE9sMDI3cFl3Z2FHWWRGbFZ5QWR4S25TcUFXV1IwQkFGTENVZG9RN1VGY2lj?=
 =?utf-8?B?SW1lbkRUQmI4cWJTU09MWXdSZFA0MDNOdk16TVY5WFVVK0ZtRUk5MkNGWXo5?=
 =?utf-8?B?K3VEZUgwVGdCMWpOcVJUZFFudTdYQytGUW9qcE1lUDlMeFhjeXpKTU1Mc2VP?=
 =?utf-8?B?THpPVzRyQWZiMDZqOXZGeXNpY2xERzZoWjVKM1ZOa2pLbGlVa21GZFRsdkg2?=
 =?utf-8?B?QUl2TkRUV21sQ0pCK0JVeW9zR0U5S2JVRDRHNnY2QlQvbmFyd2FBYzRvRHBF?=
 =?utf-8?B?YThWZ09UYks3N1Q1b0dPa1dlMVFMTzhweWFybEJBVm9xY3g5cVJ0L0g0Qitr?=
 =?utf-8?B?L09aY0g2aWpPSjM5SHM3RndPRzFVZ1B5aENHdTIwb2ZLWi9rQS9GZTg5c3Fo?=
 =?utf-8?B?Y2U5N1VNZXRkNDJhUWtNQjFmNk5LZC9QMnJNMXptdG5UZyttQ3JjVHNqUlFL?=
 =?utf-8?B?YVpHMUdjL3VzZ3N1STd5Z2VudXRvVTJwQ1RydEVTUG9ZY3FwbDFteHptSkNS?=
 =?utf-8?B?N3FFVHFUMGFZZkFCUGVJT1drM1Jja0JzODhWTStNWjJZcnlTRnFMTWFlZkQy?=
 =?utf-8?B?c2J5OGRZdkQ0aUFmQjdiMXh4My9rUGppWjJCb0JEVTJ3WTVkdjhhYy91R1N2?=
 =?utf-8?Q?yiYFEaSc2bEvNEBSwpDgpyc=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(10070799003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?V3VnUGhraUpKc2lYdHgwM3NnTHo3YkdnTWdHMm84TVpZSEpqdzNIL2F6QXdQ?=
 =?utf-8?B?VzNHMXZ4eFlKblFIQS9JY3ZxVnZDYzFRdDhsWVBFOERMK2NneitjZFlNNUw5?=
 =?utf-8?B?ZUcxR0xkejAwa0lhQnpMcVVVQTJ3SWZiK2syM2syRmpXL1V0UFk3ZUlxcjVy?=
 =?utf-8?B?TTZybnlTUXhJei84M0w1TjVmY0pLT2Y1ZkZVWGczVVZJL2w3N3BoalNOK3Ns?=
 =?utf-8?B?dkN4b2FMYlU2Ly9TMVh5VU5LOHBTMGc2eWZDYjRxd1U1bzBCU0cybHRrZUht?=
 =?utf-8?B?c0MyWm1rMXNvSzJ2bkVsT2g3VFcvZlVicDdrM0QxMDVYcmdGalE3L24zRjNn?=
 =?utf-8?B?cHgvMjFXc1pLenZNc1ZJdzBGOWhJN2pJWDBGbmtQVXV6WGtLeU5SQTgvS2li?=
 =?utf-8?B?WmhzQzc2aTlGWlBRWDh1UVJjR0R2dTRxZGlBRm5TSG56eUdMWG1CMDZ3TllE?=
 =?utf-8?B?SEZWVWpTUXRJWDZEenFhbThDOW1LbmVzaElQZTZrMjh1NW43Y2Mrakw3QlA0?=
 =?utf-8?B?MkdQWEp5WURCQTNWVkNETFlFa0QxaU5nR1J1MjRWdDBBeWt1WmZsWjVOMkli?=
 =?utf-8?B?WmdsaG5hZzhPZ1FyM2s4L042UVFZVEV3cEpHa2FPenFEUXdxa0hBbVBCOU9G?=
 =?utf-8?B?VnhGenVYUmNEWlc4c1lTUXlsWHJ2Qm93eUpncTlERmwvaWtDdzJwSi83Ujd3?=
 =?utf-8?B?cU5GclN4SHIzd0lwRjBpN0ljUWsyUmdyMTZaT3dsWFNRa3FVd1lOQUhEeTVT?=
 =?utf-8?B?UVhjYlhzZ1dPRXVuVEZoV3ZrK2c3L0hpMGN0VVhsWk51Y0NLZ2Q4L24wdVFV?=
 =?utf-8?B?V1N3S1ZnRiszNkwzTHBmNUlnZmlqYlFIVTJWRkpqVC9vbTR6OEkyY013L3VL?=
 =?utf-8?B?UWF6RTZYV2hIcmo0am9iK2ZsRDZtMkw3dHIwZUpNMGZlcFFFQU9yZ2lnbnJ1?=
 =?utf-8?B?U0hqN08yZ2Z0dmlHd2pMbno5S05VdTdhTldWQ3BUYjdvNXR4RVZpdTRJSEhR?=
 =?utf-8?B?cHF0QnROSkVmNWdyZ0hGRGZNMUlKZXFyK1d2eDIwRjZZeVE0VE04RXZqNDdp?=
 =?utf-8?B?Z1UycXhhcE04eFRuUkFhTmo0YnpnTGp2MUkyTzRkZE90b2duakVOdWlodlBF?=
 =?utf-8?B?cGI5d241cGdtV0RBNVdZVXozR2FLbjN6b0dqVjl3YXU4QWkyUFlxSVRYOFQx?=
 =?utf-8?B?V2ZKQkx5N0ZxK2NJUUlndnZmOHpDMytHbmU0emlVeEloVGRKR3BjRStWMUpJ?=
 =?utf-8?B?VWJ2VjdNWG9WN05MNTMvbnBPRyt2T1MyZEIyZkRzNU94d3BTeVFkZ2szZ2tB?=
 =?utf-8?B?UkZ5eDFraGZSQ0dnRU8vZkhQV3VTQVJCOEFTdUdsNitIaFNiTjhtaUQwMG95?=
 =?utf-8?B?UEM4RkU1bmcvRG5TRUlyNEd2c005SzF3TDZuZ0F1N3hZalhNYkRaOGVZaElS?=
 =?utf-8?B?U3hES1pVMDhCRXNtRElWWThEQTdoM0lNY3I5Wk5Cd1I4c1Nha1BTU0VMU1dU?=
 =?utf-8?B?c05uVW1YT1NYQ2JlSHZIUXc0aXVYSFdyc0hQZW5sbnpLUnFxVlFsSGJ1RENZ?=
 =?utf-8?B?cHBEenhBMHhpOThBcVkrWCtPdGt4N3N6VDNZdWtLRUdsa24vVzBpZ0k3MzhD?=
 =?utf-8?B?ZFFVL2JHTFlIWkZGc1l5ajdFb2ZZa3JHMGlpUDdCRGRSVCtwOHhHYytvbm1p?=
 =?utf-8?B?WnpMbXRLdFR3R0VQbWF5NjJyc0dFWDVldTI4RmxtLzFGRGx4bGVIWVp3d1pN?=
 =?utf-8?B?ZzY3Vm4vVTd6ODFrNHZQZ0VsT1dtakpiMUc5UHBQZXpDQTJnL0lTUk5UVDgw?=
 =?utf-8?B?Q0J2TGE1RURzc011NVorelJnQWpDN2YxN2FwRCt5QnVPbW8xYVFEc1ZmYlFy?=
 =?utf-8?B?ejBVSUg0QVEyQjhYOW50bVpKQVk5ZXQwYWpkcHdsREVHV2g1S2k2TExBamtB?=
 =?utf-8?B?bThyWWF6UnVmaStrR1NMTFlRcVpRc1EvcWh3cEpBcWxQZ01JbGVMU3dyd3VQ?=
 =?utf-8?B?eGJuVk5sV0ZVWXg5YXlDSFVmbkhnTXBoRnNuSTdteDdYZTIxV3c1aDcwZ2xL?=
 =?utf-8?B?TnhCVFJvRG0xU3MzcGpyS1p5bFJsWFhWZWg5Y3BSRHlIZnV2Y0hFRFcxSDd0?=
 =?utf-8?B?dytvTHJsRkQvUkJSekNIT09JSklNZ2Myc3FjVFdWelptMWEzQmNzMnF5emNv?=
 =?utf-8?B?UTdVMDRFa2JsRHhMUlVuKzFuUzN0TWQvRUNnOU1NaWFrUW9vZTRIVEU1eWpG?=
 =?utf-8?B?N2h2RVBhbjM2dGIvV1BBdWl1alc5N2tWTlV3NlY1VmcvUmpERGdremFJWjUw?=
 =?utf-8?B?QXd4YzM2TkxIbHhyME9pVzdJd3djSjZHUjI4MHZwY0xTcEVjT05XRnVhenhB?=
 =?utf-8?Q?aeTvcfBy/RgSXX5/9KSAxdirvHMirEWMuHg1r67BentzI?=
x-ms-exchange-antispam-messagedata-1: fHAQnuS4k2AX7g==
Content-Type: text/plain; charset="utf-8"
Content-ID: <7962830F83658D44814926DA933F6858@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9404.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: caace770-6643-4a36-9f9a-08de6feccb9d
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Feb 2026 19:26:35.1935
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Gzj1g+rrz5JEMz23jadb4tlFxQWADcSMSIDJEwaJ+98h7ZGnMSSYnVoLZQ6wcJ/N2RYSf55M9fVBq763VGSZMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7931
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260219_112642_765396_0F2FD0C0 
X-CRM114-Status: GOOD (  23.90  )
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

T24gMi8xOC8yNiAwNDowNCwgSm9lbCBHcmFuYWRvcyB3cm90ZToNCj4gSGVsbG8gYWxsLg0KPg0K
PiBJIHdvdWxkIGxpa2UgdG8gcHJvcG9zZSBDb250cm9sbGVyIERhdGEgUXVldWUgYW5kIGhvdyBp
dCBmaXRzIGludG8gdGhlIE5WTWUNCj4gZHJpdmVyLg0KPg0KPiBJIHNlbnQgb3V0IGFuIFJGQyBi
YWNrIGluIEp1bHkgWzFdIGRlc2NyaWJpbmcgdGhlIGZpcnN0IHZlcnNpb24gb2YgYSBDb250cm9s
bGVyDQo+IERhdGEgUXVldWUgaW1wbGVtZW50YXRpb24gaW4gdGhlIGtlcm5lbC4gVGVjaG5pY2Fs
IGZlZWRiYWNrIGF0IHRoYXQgcG9pbnQNCj4gaW5jbHVkZWQ6DQo+ICAgIDEuIENEUXMgYXJlIHVz
ZWZ1bCAqKm9ubHkqKiBmb3IgdHJhY2tpbmcgTEJBcyBkdXJpbmcgbGl2ZSBtaWdyYXRpb24gKExN
KQ0KPiAgICAyLiBMTSBuZWVkZWQgdG8gYmUgaW4gYSAicHJvcGVyIiBzdGF0ZSBmb3IgQ0RRcyB0
byBiZSB1c2VmdWwgaW4gdGhlIGxpbnV4DQo+ICAgICAgIGtlcm5lbA0KPiAgICAzLiBDRFFzIHNo
b3VsZCBiZSBtYW5hZ2VkIGxpa2UgYW55IG90aGVyIHF1ZXVlIGFuZCBub3QgdGhyb3VnaCBhbiBp
b2N0bA0KPg0KPiBTaW5jZSB0aGVuLCB0aGVyZSBoYXZlIGJlZW4gc2l4IGFkZGl0aW9uYWwgdmVy
c2lvbnMgWzJdIHRoYXQgaW5jbHVkZWQgdGhpbmdzDQo+IGxpa2UgZXhwbG9yaW5nIGRpZmZlcmVu
dCB3YXlzIG9mIGFsbG9jYXRpbmcgbWVtb3J5LCBpbnRlcmFjdGlvbnMgd2l0aCBJT01NVSwgdXNl
DQo+IG9mIHRoZSB0YWlsIHBvaW50ZXIgdHJpZ2dlciBhbmQgaG93IHRvIGludm9sdmUgKG9yIG5v
dCkgdXNlciBzcGFjZS4gSSBoYXZlIGJlZW4NCj4gcmVsdWN0YW50IHRvIHNlbmQgb3V0IGEgc2Vj
b25kIFJGQyBhcyB0aGUgaW1wbGVtZW50YXRpb25zIGFyZSBzdGlsbCBoZWF2eSBvbiB0aGUNCj4g
dXNlciBzcGFjZSBzaWRlLg0KPg0KPiAjIERpc2N1c3Npb24NCj4NCj4gSGVyZSBhcmUgc29tZSBw
b2ludHMgdGhhdCBJIHRoaW5rIHdvdWxkIGJlIGludGVyZXN0aW5nOg0KPiAxLiBTaG91bGQgdGhl
cmUgYmUgc3BlY2lhbCBjb25zaWRlcmF0aW9ucyBmb3IgdGhlIGZhY3QgdGhhdCBDRFFzIGRvbid0
IHJlYWxseQ0KPiAgICAgaGF2ZSBhIHN1Ym1pc3Npb24gcXVldWU/IFNwZWNpZmljYWxseTogSG93
IGRvZXMgdGhlIGN1cnJlbnQgTlZNZSBxdWV1ZQ0KPiAgICAgaW1wbGVtZW50YXRpb24gbmVlZCB0
byBjaGFuZ2UgaW4gb3JkZXIgdG8gaW5jbHVkZSB0aGUgZmFjdCB0aGF0IHRoZXJlIGFyZSBubw0K
PiAgICAgc3VibWlzc2lvbnMgZm9yIENEUXM/IERvIHRoZXkgbmVlZCB0byBjaGFuZ2UgYXQgYWxs
Pw0KPg0KPiAyLiBTaG91bGQgdGhlIG1lbW9yeSBiYWNraW5nIHVwIHRoZSBDRFEgYmUgc2VncmVn
YXRlZCBmcm9tIHRoZSBvbmUgdXNlZCBmb3INCj4gICAgICJyZWd1bGFyIiBxdWV1ZXM/IFRoaXMg
aXMgcmVsZXZhbnQgYXMgQ0RRcyBtaWdodCBsaXZlIGxvbmdlciBhbmQgYmUgbGFyZ2VyDQo+ICAg
ICAocHJvcG9ydGlvbmFsIHRvIHRoZSBkZXZpY2UgYmVpbmcgTE0nZWQpIHRoYW4gInJlZ3VsYXIi
IHF1ZXVlcy4NCj4NCj4gMy4gTGl2ZSBNaWdyYXRpb24gaXMgdGhlIGVuY29tcGFzc2luZyBzdWJq
ZWN0IGFuZCBpdCB3b3VsZCBiZSBpbnRlcmVzdGluZyB0bw0KPiAgICAgbm90ZSBpZiB3ZSBjYW4g
YWxyZWFkeSBkZWZpbmUgcmVxdWlyZW1lbnRzIGZvciB0aGUgQ0RRIGJhc2VkIG9uIGV4aXN0aW5n
IExNDQo+ICAgICBQT0NzIChpZiB0aGV5IGV4aXN0KSBvciBMTSBpbXBsZW1lbnRhdGlvbiBpZGVh
cy4NCj4NCj4gVGhpcyBwcm9wb3NhbCBjYW1lIG91dCBzaG9ydGVyIHRoYW4gSSBleHBlY3RlZCwg
YnV0IEkgYmVsaWV2ZSBpdHMgYSBnb29kDQo+IG9wcG9ydHVuaXR5IHRvIGFkZHJlc3MgdGhlIHF1
ZXN0aW9uIG9mIGhvdyBMTS9DRFEgd2lsbCBsb29rIGxpa2UgaW4gdGhlDQo+IExpbnV4IEtlcm5l
bC4NCj4NCj4gQmVzdCBSZWdhcmRzDQo+DQo+IEpvZWwNCj4NCj4gWzFdIGh0dHBzOi8vbG9yZS5r
ZXJuZS5vcmcvMjAyNTA3MTQtamFnLWNkcS12MS0wLTAxZTAyN2QyNTZkNUBrZXJuZWwub3JnDQo+
IFsyXSBodHRwczovL2dpdGh1Yi5jb20vU2Ftc3VuZ0RTL2xpbnV4L3RyZWUvc2FtLWNkcS12ezIs
Myw0LDUsNiw3fQ0KPg0KDQpXaGF0IGlzIHlvdXIgdXNlY2FzZSBmb3IgdGhpc8KgPw0KDQotY2sN
Cg0K

