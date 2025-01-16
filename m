Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 295DEC02180
	for <linux-nvme@archiver.kernel.org>; Thu, 16 Jan 2025 01:19:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=QOoQv9+mkBmsot9qZVHN7X/zcktPUDCzKBhve19i2ok=; b=kHbdnAU8uUHFt1t+W+tsk+xtn4
	Zvf7bOY/oRH43FroHt9RM1ili2bVpX64ZUzR06hVABmB97+iwq5HrSvqEmjJR9ahsNLQIBXgbP4wf
	ShvRztIK/53xUJ3wxOqWZoWOc2X8tTl5mVa7NGBliLI+DkOCC6jipz7SqVu4eUZ3+Yd0v7x0P8Tcs
	j8ho1kC8sgJ3ogwBknKj4nEw8ILs3Q3wgPacYe6nSh1baUxdM3Ycos80wb5mQWQgmULorCYj46YxS
	QgRrCwlwcoozH3nmOZ2w4fsFbXtvK05re3cjGR0c3Fipd7gZtNsOY8IbcUgapLpigK5IGz2AlBaLH
	v6ANJgyw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tYEXX-0000000DWiL-1xGZ;
	Thu, 16 Jan 2025 01:19:19 +0000
Received: from mail-dm6nam12on20605.outbound.protection.outlook.com ([2a01:111:f403:2417::605] helo=NAM12-DM6-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tYEV6-0000000DWKQ-3cDs
	for linux-nvme@lists.infradead.org;
	Thu, 16 Jan 2025 01:16:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F0WkssBs33vSSkHvudeKmhxkGTFWi7q7/HlnKSFz2HzpCnMhRZUi3Vz5S6cv1ixWY48zqGiV8uANAfui64558Nrh3nh9txZR8HLCn6QCtktixBZff0eP72/PkE9osl+1ts4zwmm6EArs0e8ejQCYZ4J9KWG39fq9R0UCriVTgpUyinkmryjKha/QKzR64s5L39xvvOJpIqkxUMFq0Cb7zHMJR2bb2bqWJ9f2wgI987IwzZM8iikGyByHcCmTtjHVXgbopnLT+GQOcKE/bLKjmGTSLeCW5WvhAu7gsEJxr+n08oc+rChhqoyTMhq9v8nsmlkLZR92220byAgwRHLTow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QOoQv9+mkBmsot9qZVHN7X/zcktPUDCzKBhve19i2ok=;
 b=s86K4H433Cs72O/okm9cf8G27WW86rGttFyWzawLYPNjQ5LbkJRUqCs+e8GPC2iS6WKeyUjSGx9YbSj5IhlFTBKEElMQ6qwQ2Hv+QWWEoVn3wNeaLjJytWyi8mrI3zEikIo7fuO9DuF2zB+UK2Yws0mRPdxibUGWsZH6H+eiFUzTl9LMajaxb0tywTpck6QqhvyNzL79CToeaIsVCGwUHnpYVUlH/f9in5wp037S7JBa/KbL3UVi0iMagA+OEUADN5Q0Bw7RMn9OPYBmK4IapQcr1TJu2iFnySoYgzCF9RkbNFPFsWEfcFeX01FJWnwO84WS58KzaNXTcKbvaWezMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QOoQv9+mkBmsot9qZVHN7X/zcktPUDCzKBhve19i2ok=;
 b=Dq/ilE88k9htWFddnBGC+54aEV03XVaC9IGy7HCf7fcnV2rNcBQfTnbQaoRDnQ7zoZLVjZ8pC0GYesq5hpaHISmo/CTkxpBlvjfvQQIK0/5ZRZGst3/GqNDhz5O/8oXEDKRCtDBCpHWb1uF0krAfM/5j7pbejRdk2Blah3dhVyFXseLFuThaSwQbumeHey7HqpR+Fos5LWjRjWRMfzCcjjaJbUVddlupyeBHLkbJodl7ziW90EmJ7IlWwN07qgHHj/0a+QZ4QJznad6fIOA6z3ZnsbC2sDuKUDtuSvJBwOm3X8d8s1klmDJSBeo7H+JpPl/8Z0u4TTtG2CVuDqAvnQ==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by MN2PR12MB4174.namprd12.prod.outlook.com (2603:10b6:208:15f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.13; Thu, 16 Jan
 2025 01:16:41 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b%6]) with mapi id 15.20.8356.010; Thu, 16 Jan 2025
 01:16:41 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>
CC: Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"hch@lst.de" <hch@lst.de>, "sagi@grimberg.me" <sagi@grimberg.me>,
	"dlemoal@kernel.org" <dlemoal@kernel.org>, "bvanassche@acm.org"
	<bvanassche@acm.org>
Subject: Re: [PATCH V2] nvmet: fix compilation errors
Thread-Topic: [PATCH V2] nvmet: fix compilation errors
Thread-Index: AQHbZ5tFZCK5jI2oYU2r9rFiPViU5LMYaJmAgAADSoCAAC19AA==
Date: Thu, 16 Jan 2025 01:16:41 +0000
Message-ID: <5d1afcbe-95d6-4599-b9e9-5c97915446fb@nvidia.com>
References: <20250115221703.62861-1-kch@nvidia.com>
 <6ca7f59b-f232-4bf0-984e-a4439e22b9ba@kernel.dk>
 <Z4g3z8GWgoCQd8Kh@kbusch-mbp>
In-Reply-To: <Z4g3z8GWgoCQd8Kh@kbusch-mbp>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|MN2PR12MB4174:EE_
x-ms-office365-filtering-correlation-id: cda34bc6-a867-4927-1a62-08dd35cb6edc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|10070799003|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?Unl0ck4zMjdudjYxZ2RiMWtSTFVVL0h5Y2JLU1FaM2NqVXplRnhyMG8xK1JO?=
 =?utf-8?B?Z2RLWFRqTmpKZ0c3RnU5VWhMcmE5NDNCTUJBMU1YSmg0ZURZYk5HSkVBc1g3?=
 =?utf-8?B?UVgramdkdm9qSFRzcy9sMjFUdXUwcUlCeUIxcWhJbUgrMVhoZzRzOHVKYXE1?=
 =?utf-8?B?TExtU3BxaThzZmpRTVU3SFhTb1lNdVFySmxuSzdrWUhGM2R0bUUrL2tzYUcv?=
 =?utf-8?B?cWw5TUFRT0FDNFhrL1lyelUyU0dsbE9ielBuMmhWNGEzQVozK3ZoQjVEZEcr?=
 =?utf-8?B?bW02Z09ydzNyZlBGaHdhTlo3VmZTVFMvQ1hEWmcvdlVWRmpGVlUxNEJKN3BI?=
 =?utf-8?B?ZXJSdUVNTlg5a1QxQ1BvOUxxYzdZYUdOSE1EU3BJL2dpVm53dGdONFQzTHls?=
 =?utf-8?B?WS9RbmpUckltYmU5ZHhwMkM2MjBCS0JQQS9ya1c4U1ZBaVhUVWxjY0tLKy9R?=
 =?utf-8?B?OHFPOG5DMGRJSDdpOWVPYWNMb2hQRy92ZCtyekF4RlYrUWZtTkFNR1htN1g5?=
 =?utf-8?B?WmtRU1FXUkZnZVVqdlhubVR0NXpsb3k0cko4V09xc2Vrc3lYbEVRbWdHc0d3?=
 =?utf-8?B?ZFhqLzNVU00yM1JXWmpwdXN3MlVSa3Q0V3lqSTlqQm8vZklpMkhQS25TUDlw?=
 =?utf-8?B?VXEySXIwVHg5UU1QMCs2TXNJYzNHbyt6OU5lVS9YbjBOTmVqRFdWa01wVUow?=
 =?utf-8?B?cWFTNHpWTnFZSWRBcGorcmw0Tm1IMlp0UjdhYS9oL2hNb3NaT21tMXhRdGd6?=
 =?utf-8?B?dGJaalhKWWdKQUpmRHpuR2s4WUJncU1IYkRIOUdxQzhaR3BPK3lUVnozZW52?=
 =?utf-8?B?M2xnYW1ZdkdvSG13RHZEM2ZnVmV6ZjUvck1scmNQTXBqbDBmMHo2R1VLZWxr?=
 =?utf-8?B?UHlpVlhnamUrRWhWUnJMV3oxb21rNTBWTGZEYnZPU2hTWGFSWWx6WUZMd0M5?=
 =?utf-8?B?aUFxdUE2ZC9FNXp3U0FZR3VsNzBiNDhRQllYSE1LR2FXSzAzRE9kcVRGbVU0?=
 =?utf-8?B?MWdOSmcxcTlzQU9SeWZiU2pwd2k5RWJhWXEvdU13aUJPcU9hZldYVVN2QnV0?=
 =?utf-8?B?LzZSNGk2TWRRQlNhYkZVdXU5S1QyblFjbElTNUxEREk4OEFGMUVhNFpIcUpI?=
 =?utf-8?B?SGZFZkFWS09CbXl0eWdMT1lWS3d4d2ZCdWp3RjJDd29NbEY1aEZGV25yWUlp?=
 =?utf-8?B?ZE14TGxmV2tmRkZYU1JxWFNNb2d3Q0YyajNlM04xeDg2QlJmc1dBRGpvb2s2?=
 =?utf-8?B?Y1YrYzM5anhYUWdqNVFOWHhDWGZOcDNsenIxRUtmZHNPWXhHU0ZrL25SaXVR?=
 =?utf-8?B?Uy9OZi9CbUh4NjJCbWlkQ3dZc2JaVzhwV2xEVkZLZnl0RkpJQWsrMHkrWEY5?=
 =?utf-8?B?UkRLMEM1eU5ZSWtaL3ZvT29TYWh0R0lackFqY1dSdnQyQkpjWDhTODh0R1ZI?=
 =?utf-8?B?Qy9Hd3NPUmNJOW92cUo4b291L2s4azNjZVdFVzJHaUIreWlLREwrejN2eGYr?=
 =?utf-8?B?SWsrcW0vd2F5bWU3UkJBb3NmVkp5YzdKdmVqUnZnRnhGaGc3ZXMwUzd1QW0v?=
 =?utf-8?B?aTVaemZ3RnZldnh0NzRzbjd0a09mcWpNMVh5VXBBWi9wUWlSdXZqQlMrdUts?=
 =?utf-8?B?RU1KZU0vc0xHMkhac1B4N3lHeU4zcThMSWduZ1pGWjMyWEhyTDFmVFVNMCs2?=
 =?utf-8?B?Z05LNURrQTJLdGxwRWhpRWhybTAxU2syMXgrUHdKUm82cWN6UnRiV0lQMmpz?=
 =?utf-8?B?RjM2QWxCZGRrRzc2dnUyZGNvM1ROWG8vVFJmekg2YmhnekNzSHd5WHU0RFZi?=
 =?utf-8?B?SXgzSzJQVzY3MUZiWXIxQldrYlh5d0NYLytRVjVDR3EwK3dQM0pUZEpaaDMr?=
 =?utf-8?B?WHlKTjBpTGFoUUszY3lZODgrbTNrS2sxOUVtK2FKZHhodzZnL0cxeisrR0Nk?=
 =?utf-8?Q?jzWU89ZnLsaoHQGUe5ZDElc8CKqy5VH6?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RTg5NnVsYlFuWENwVjYvQUlZMnc5c2dqK1A0bjhiZmxXYzJKNGlybzNubnNr?=
 =?utf-8?B?Znc3aGw3NHFHZzg5b2lFSW91V2ZROEpNQWVyRFpveTNtVjlFcGhZRXk4NFZm?=
 =?utf-8?B?VWdzcUMyNHlQdUxESFhpaFF6RkxLckFiTjRzMWRTMzExV2VrT0hJb1RzVWQ2?=
 =?utf-8?B?WnpyaXRPUVBRZklqbjU0bEx5ZHl5R080YnJUQllMb2Y5WXUybTlqalUzeW8r?=
 =?utf-8?B?UkQwSFRxZXNhOU5lM2UvNTgvUSs3c3RLaW1nRmU4aE5tQ2pDV0NwZkpScEFt?=
 =?utf-8?B?VlVwUTZycCtma1ZLblVENEZyVGdjd1NjSVkxelJYSEwvckI3alJoTkMwZnh6?=
 =?utf-8?B?eEtOM3Jrd3pQaDNYWG1JdTduVXRYcmJkMzBXTzA3eGtFYWFaRzZ3Szl0TnZS?=
 =?utf-8?B?Q3gybW93M2IzSTJiU0NYaGtNd0F1S3V5MnMrU2NhUkFDR1BWNkdQT0wzTGZh?=
 =?utf-8?B?OGNhYzFNWWt4VVcrekRZMkpaNlBRaHpQa3BQMlVCY3NNSk5WYTRnKzZ1R2ta?=
 =?utf-8?B?WFBjOEdvdXk1MWdtekxEQUVDL0VWcVkwNElrcG9xZzZZczZhMzlXUmdnN3lJ?=
 =?utf-8?B?UldkaktsMVU4SGlVS3NuMXNrYnYyM21abmxkSnArUGVNczZ3NDdkTWVJSzFr?=
 =?utf-8?B?QlhaT3FHckNmZUFneVk2UDRLNnBndXVoRkVTNU4va2ZzY3pwVnlBdEZKcjZO?=
 =?utf-8?B?dWdRaUdjZU14aUcwQ0dhOW9QSytBbE8wZjhWZXRsZHFjY1lKZm5BY3BLaTNs?=
 =?utf-8?B?Tm5qeFpzWStybUxEYVh2NHNHQnRZc3dJcDZ3MUZ0dDZDVWEzMSs4VmNPWHBC?=
 =?utf-8?B?emhLSzBHakYyTk1FNWNocktkQW1pNGhBTGNCR212aHVZbG9UNmxBRW5jR0NR?=
 =?utf-8?B?VG9xRVFxR2N3dzVCdDNycit4SzkrS3BhWTROUVV2Q0d5SDVQVERUTUt3d25W?=
 =?utf-8?B?MVBwbXlDVFQ1bFk0a0xBR2g5eFBkdVQ5dGU2NjQ3cy9sOWV2NW1EbkZoT0ti?=
 =?utf-8?B?VXNGZE42R1RVelpOblorUWpybTlJb0k1T1dwQ0w1bUdzUlFZb0k2TnRLbXAy?=
 =?utf-8?B?aGVwdTBEWXBETTlyUmhuMVJQY0NtaWRaYjJmRkVISnQ2RGhwZkJzK3JKV2pH?=
 =?utf-8?B?bi8ycTFwRE80TUlSSncveHVUZzhJN3F6OVorcjdPalIxR24ydVZCL0dhZDVx?=
 =?utf-8?B?RUo0aVd2QWV0MHhTVXNGL3BKc0xXUzUwODcwdTNFVnVybTZCaHJ1Zzk1SmtB?=
 =?utf-8?B?VDdtSDh0cHdrUTd3eDRla3BjaFZHbnVPK0xTM2hQa1pSZU5YOC9YaDNPbDFZ?=
 =?utf-8?B?bUhGWkxySVc0SXJWQVpkVitzcGNaNmNlVU1vRm92cnBTZlE5UmNaK3BTeGl5?=
 =?utf-8?B?MytLNVlRcGVVbWZ4V2lFaVlhRzYrclNrdVo5SDl4RnNueDBqVnJLYnZyS0xO?=
 =?utf-8?B?UTQrUnlrZDhqRU5ZTG93RkkvSWN3bEl3K05iRVV6SFRpTXNkOG1qZktnaGZW?=
 =?utf-8?B?NlJVSEorcmFibm8yNXlMbUJqNDM2TmE4QWpKclRzZ0hoYStXUE4rT1V5Nno4?=
 =?utf-8?B?RWhaZGx2cmZMeGh2ZTNvVklxYTRtS3dmYUh6K2xBM205S3dvUHF6ZWlPWktC?=
 =?utf-8?B?cklLK3ZZamFieWo2TWJhVFNmK2puUzBlUEptRUM3OU02d2J0TFhXemtGQzhj?=
 =?utf-8?B?TE82OFpuSEZSREFySTdyS1dSU3o3UWQzU3d1K2VqSHg0UjVXbGpMclI4aHlV?=
 =?utf-8?B?b0VQUGkxQ25WMkxkR1pUVm9ZdEt4Mzg2VkVKbC9lNHdjRjQ0VVpYY3ZUeTE3?=
 =?utf-8?B?U3huUnVDdWtTNGNPak4xK3VBY2xKZUlqajJMQTVielcvQnRZL2dkSmo5cUlI?=
 =?utf-8?B?cGt2eEJObWxSQU5UMXpudVRkRWF1REVCZC9YUkdwcDZ2SVhySjQyNTdMZnk0?=
 =?utf-8?B?VlBLUkRwUFhKdm5vckE2ZUE1bTVTMWFkbWF5YjVUNldGWWs3ZUo2RXZSRXV1?=
 =?utf-8?B?N2VUMkczd25zWFRKMTZpbVJPVm1pSExMeWFKNm1nOE4yL1d3Kzl3cytONjh1?=
 =?utf-8?B?R3MwZGF4bzNVem1ZK2lSVjNPb3FJdnhuRDdIV2lqWWlRVUNlY0M5WXBJbkxN?=
 =?utf-8?B?T3VjQ1VaZ1VpYmVDQko3RVhGeURFT0xPWmtkMmtQS1IzVjBoRGxrSFRKU3gv?=
 =?utf-8?Q?nFKqOR0TCkkIYMLPvUKBRaDH5Pjg57pGgqIN4A+XTPgX?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <60CC223F0BA321428C9F0F8875AD1EEF@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9404.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cda34bc6-a867-4927-1a62-08dd35cb6edc
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jan 2025 01:16:41.0636
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wYVqjh/zZpeC4hgEiKdht+yIv991ZKRWxvwUAi4s7p9Af2LlURLNKF3RRwMYBxu1M8fyHTSbU/wnc/iilLoJIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4174
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250115_171648_901336_84203BCE 
X-CRM114-Status: GOOD (  10.82  )
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

T24gMS8xNS8yNSAxNDozMywgS2VpdGggQnVzY2ggd3JvdGU6DQo+IE9uIFdlZCwgSmFuIDE1LCAy
MDI1IGF0IDAzOjIyOjA1UE0gLTA3MDAsIEplbnMgQXhib2Ugd3JvdGU6DQo+PiBXaGF0IGlzIHRo
aXMgYWdhaW5zdD8gVGhlcmUncyBiZWVuIG5vIGNoYW5nZXMgaW4gdGhlIG52bWUgdHJlZSBzaW5j
ZSBJDQo+PiBwdWxsZWQgaXQsIGFuZCBpdCBkb2Vzbid0IGFwcGx5IGhlcmUgYXQgYWxsIHRvIG15
IGZvci02LjE0L2Jsb2NrIGJyYW5jaC4NCj4gSXQgbG9va3MgbGlrZSBpdHMgYWdhaW5zdCB0aGUg
bWVyZ2UgcmVzdWx0IG9mIHRoZSBzZWN1cmUgY29uY2F0ZW5hdGlvbg0KPiBzZXJpZXMsIHdoaWNo
IGFzIHlvdSBrbm93IGhhcyBiZWVuIHdpdGhkcmF3bi4gU28gdGhpcyBwYXRjaCBpc24ndA0KPiBu
ZWNlc3NhcnkuDQoNCm52bWUgdHJlZSBicmFuY2ggbnZtZS02LjE0IHdpdGggSEVBRCA6LQ0KDQpj
b21taXQgNGEzMjQ5NzBmYWJhZDUwMzI2MDk3M2NkNTg4NjA5ZjNhMjZiYWFiOSAodGFnOiANCm52
bWUtNi4xNC0yMDI1LTAxLTEyLCBvcmlnaW4vbnZtZS02LjE0KQ0KQXV0aG9yOiBGcmFuY2lzIFBy
YXZpbiA8ZnJhbmNpcy5wQHNhbXN1bmcuY29tPg0KRGF0ZTrCoMKgIEZyaSBKYW4gMTAgMDU6MjE6
MzcgMjAyNSArMDUzMA0KDQogwqDCoMKgIG52bWUtcGNpOiB1c2UgY29ycmVjdCBzaXplIHRvIGZy
ZWUgdGhlIGhtYiBidWZmZXINCg0KaXMgcmVzdWx0aW5nIGluIHRoZSBjb21waWxhdGlvbiBlcnJv
ciwgaGVuY2UgSSBzZW5kIHRoYXQgcGF0Y2guDQoNCi1jaw0KDQoNCg==

