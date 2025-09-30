Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48CEBCAC5B0
	for <linux-nvme@archiver.kernel.org>; Tue, 30 Sep 2025 01:44:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=AdgHx2L4oSMX56OngKmDgQRv2OqUDb70xhqrJdWcCPU=; b=FrnAOxCSNkfBBFWmHDCOx4UgHM
	cD3d41zpk/3PRNAzTt8xlk0ZcwrBfmAP4hgnow8a0rM/Gd4HL/ssLIp/WpE1pkoN67j/vEhU2tE7w
	5dn5tm2ySx3LRvRmIhzUFiCH5ptP94Y/A6KuxsfCgCFiOKfleQeJ1/HNvwHkEQCShLdvam6cF/3JB
	1dt7op3P9oTME4iBEZl21/Spdda7wNcFMuX16WWxksGF3XnHWRxJWsMX4bF2mS3dK0so00BLn5Cam
	rLYdtgc4IZn9rK3prSoN8M2jm6eoaumI0UDLBMY5+BFKvgBhAup7ZfTEBe0MjQzN1v9utZcz1dSRf
	MOwAzxsA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v3PPO-00000003oER-02zw;
	Tue, 30 Sep 2025 01:44:02 +0000
Received: from mail-southcentralusazlp170110003.outbound.protection.outlook.com ([2a01:111:f403:c10d::3] helo=SN4PR0501CU005.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v3PPL-00000003oDT-42Ul
	for linux-nvme@lists.infradead.org;
	Tue, 30 Sep 2025 01:44:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X7URONl5XY/imuO8jYCN5MrdUkZFLBiIifAsXWHWigog0Bb5CSLfdCtqHrMAqsaFMR0/IbEse7O1qz+tf0SA2CI3+pJKDwlMSi3E9OIqyrepvxFa4LPbumlPlMqhNNYN91IsGI4LLm3Gjrz+edF9E22jm61w0yj5ezgRLXXDbxlptSx2ugKLXBWPNe8K2LcCo2L6xAP1/qyKgD4g/ObfaYz3SaOe8UvVCE+Lmv62WPs8nGlBe0ZznGiRWMnYnKp0c7vvL/x2K2mIYA7y46QPnjDLhKyflQZD3TojCQ5+PK9RfY9ShztILdE+Qss5elFEO2fVjCfW3mQ6ByiJ0GGLxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AdgHx2L4oSMX56OngKmDgQRv2OqUDb70xhqrJdWcCPU=;
 b=EdfLOX3GhIaP/+ohqm6FrxhHsURZeBJScCex27yGxb26MH59w/fB0pXBx4olqlIdS+PK7kEAPyK9geJGJKInVH0bbi0a1x21KtI0DMmHo+E4apX4AK13hpLGbwN78hho+i4cmpiOQmnoiES+VEgmLsVvSxgi3s6tgHrEiS1ZHtpDZ9ncsSbNpXKjrwFZY3zwym1U0u2DTLQC8sGWQVpKkrrpICwgt+PTATF1VoAan34AUVG4H50oheJK+hyZWJZlLv7Qg12vcQXPbadOxTJBFgbEx/HT3+HXQgCs3FHa8oYrmov3D9cZlRijgYblpbS9yjo5yVPdnq/PamITDw4dVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AdgHx2L4oSMX56OngKmDgQRv2OqUDb70xhqrJdWcCPU=;
 b=a3vixYunpDNIvvqYd68qmFwy+Ue3mGHWSgx2isWuhRzkm2ZahYZvi4M0xupjd8Kp/frhw5S1W4JQxpeqj20sYjHXPdcq7g6YtfbciMxbom7DE2qTFknQstG+Z6dfDFO7pTfirapCVRqFKLxcpl8tE/iei8G/rvMIBhFFYKYDVfVRsdt/XVr5SPsZl7tePEtjQeNZBC1gc1AIuCDmodZFB1YMtO2swyJTNo7CvmrVQl/INO3c57UV7+Pl9Vm7HTE/7/2Dyo51KDVCI0KovZgkdF+S5hg8CsNxH89vhcGKHCuu4VZhb3dT+h9p6ZpevXn0uqat4VFqhSEYHaDbP4C9ww==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by DS0PR12MB6437.namprd12.prod.outlook.com (2603:10b6:8:cb::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.16; Tue, 30 Sep
 2025 01:43:54 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b%5]) with mapi id 15.20.9160.015; Tue, 30 Sep 2025
 01:43:54 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Max Gurtovoy <mgurtovoy@nvidia.com>, "dwagner@suse.de" <dwagner@suse.de>,
	"johannes.thumshirn@wdc.com" <johannes.thumshirn@wdc.com>, Chaitanya Kulkarni
	<chaitanyak@nvidia.com>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>
CC: Israel Rukshin <israelr@nvidia.com>, "shinichiro.kawasaki@wdc.com"
	<shinichiro.kawasaki@wdc.com>, "hch@lst.de" <hch@lst.de>, "kbusch@kernel.org"
	<kbusch@kernel.org>, "sagi@grimberg.me" <sagi@grimberg.me>
Subject: Re: [PATCH 3/4] nvme/002: extend test to support TCP and RDMA
 transports
Thread-Topic: [PATCH 3/4] nvme/002: extend test to support TCP and RDMA
 transports
Thread-Index: AQHcMG5DvoyWdBZ8v0Gyd796+634w7Sq9n2A
Date: Tue, 30 Sep 2025 01:43:54 +0000
Message-ID: <94377f1b-4ade-4256-9446-609e6f6b73a5@nvidia.com>
References: <20250928115125.38383-1-mgurtovoy@nvidia.com>
 <20250928115125.38383-4-mgurtovoy@nvidia.com>
In-Reply-To: <20250928115125.38383-4-mgurtovoy@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|DS0PR12MB6437:EE_
x-ms-office365-filtering-correlation-id: d631d594-2853-4a6c-28e8-08ddffc2d069
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|10070799003|1800799024|376014|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?S2RhcVp2ejg1d1REandscFNWb2p6U0kyOFY3Z2N0bnFDK1JaUmFtYjRlQTZW?=
 =?utf-8?B?QW4zM1ZnZDRiTUlIV1VqTFRscEhHanBQY0lZSVVLSHlYSk0rU2FoN3NPZzhu?=
 =?utf-8?B?S2xaOFFnZWhyVjNXYVo1ZzZBbW5oNEJLc3NpbEZuVlJKaGw4ejFxOWlJREV0?=
 =?utf-8?B?RzJKTk1RM0tVcm1GbmZJem5YYW0yWUxzaWlXTTJUNjB4U3VpY1JjbjMwaFZH?=
 =?utf-8?B?M1hZcjBuL2pRVU1ZOHdpT09YTDZ0M3hPM3dJTGYxNnNIMmdaT0NSanFXWmdG?=
 =?utf-8?B?c0hIOElpdHFFUU1PRlBnd1FhZHM5eG5rcU9RbS9vYnUvdVZrOXlxMnF1ZElQ?=
 =?utf-8?B?T2E1Z2RmZnNLVGZSSFRMbDhNVGV5UERwaEdZdld5LzZNVGpibit6NThoOE1x?=
 =?utf-8?B?SVJxcWhsVFhzV25tU09heU1nTC81eGNlckpndkEyUXhsemxmWXZHNVAwWVhm?=
 =?utf-8?B?V284QTgyZm1uckJSbnNrRVk3bGFoRWNyRzhWL2Frc0tZYkEvY3I0a09yWC9D?=
 =?utf-8?B?cXlhUW4xd1VaK3A1SHhZUzg2TUNxdnAzU0N5WTBTVUd2N2h5QllUSDVEeUZj?=
 =?utf-8?B?RWJadkE2OTNTVkR0N2paSmludS8vN1lDY2s2eXhsalBhem5mT2J2WUI4NEwv?=
 =?utf-8?B?ZXd3RUZUOVNodzF0Y25LajNOMXNHVDBjK0hvRlF1Rm9rVE5lbnIyWm50enNM?=
 =?utf-8?B?NXdDaVY2cDhCbHR0QXVvKzF1Q3pBelRUcHQzM3JycVIzT2pDeUVtY00zWStu?=
 =?utf-8?B?QlV1UFg2RWs1aVZWaUhBZTV1THRsaFRBRWVxVGpRWDNhRFZ1ZnF2YlVaRS9o?=
 =?utf-8?B?MWtpNUdaQVlsS1ptcDJkWWhnOXZBeUE3dUtCaWdRdFE0dTRGaFhFMHJodGk0?=
 =?utf-8?B?T0c0SHVRc2lEcGUzUWdsQS9lSVpBUkg1clFPbWtsSFVPZFA3UUxudXNDaExS?=
 =?utf-8?B?Y3V2Q1VnSWVHRmd1cFBROWJQWHNZUnc0aGpqR2lhVjlzMHpuNjZRTnEzdTcz?=
 =?utf-8?B?N015UWc4alNXQkJyTU5wSkwrK3M5SG5GdVB6MTlUdkxZKzAyek5OUWRTa2JK?=
 =?utf-8?B?WGJ6QUZSTnBQY0x3WkNnV21Gcmp1QmRJeWZNK0tDbzNiNDZpVmU5T1Vhb1Fs?=
 =?utf-8?B?bWVXa1lGVUdzckYxczRpSGNYUWF0VnJOZC83RFBiemtlSmdzUlE0RkRTbGln?=
 =?utf-8?B?YU9UdVNSSmNtVk5nZHA5QUxLRXY5aVlQbXU5SlJGRGtva3pBTDJXNERDZ0s0?=
 =?utf-8?B?dTBkSGIxY2NkTFNGQVhzODlqU2tyZkRXOXd2OHhFd09OdWdxdFVwdTc1Y2pM?=
 =?utf-8?B?dW02Yk1JTXpoQ1NycGMwWHFJalJleStzZG16bmF1eFpwS1AwMlNQNGo0eFpP?=
 =?utf-8?B?anRuWjRtYjVYcHNPZlFqbjdqMUJyOWhoZDY3Q3hzSnJFUE1ma1NmOTdrOW45?=
 =?utf-8?B?akgzQ1lOTXlMWEhveExjeFZFM3hPdHNlMm1Gd2FBT0QyYmJBaVJqOU1vOUt3?=
 =?utf-8?B?SWRLakdmS3BYNDJoMXpaNy9DN0tFRzdweU41QlcwRTNoZWNzdzQwK2tMZm1q?=
 =?utf-8?B?UnVqNDlPL2prYWpaTW0vTEd1Wk1sT2VFR2JNT2VKYWw4cGo0d2FFZ3luUjY1?=
 =?utf-8?B?c3dtbzBVbUJCZjYwWm1zalE1V0NpQkVrbGVTTzVaRUZaSW4wUlIrMHhrY3Mv?=
 =?utf-8?B?anQzMnplRlJHNXRDMVo1dWcxWTdWVVptek8rNE4wLzl2amhvQ3VDUWxLV2pR?=
 =?utf-8?B?Q2JieE5oZWdmM1htNWRkUFJ3QldtcVZwTXdJQ1BBeXV4d1BJMWZWTlZzRW1q?=
 =?utf-8?B?NGFWYk8zUHFZS1g2VmZQM2ZoOTMvdXJ3cUhzc0Yvak16VVZDZ2FzMlk2MlRW?=
 =?utf-8?B?TUREcS8xb3lvcnRuWXo0TGN2WUNzcFhEOVYxNGVnUzVBRjEzZHVDZzN1bGNw?=
 =?utf-8?B?TFNpQzdxNTlWZnl2YTdZeGdVdUNiREVObG9acmlzRFJXWkQ1ejBBNk90Vkk0?=
 =?utf-8?B?VmlWUHlzbTFHdVFHZk82OGJXUlBidlQzY255MDdUWmd6a3ZsTkJLMnIyRlNP?=
 =?utf-8?Q?S05PLC?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(1800799024)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Unc1TFNLVGJCR0l1bWsvcGMrLy9GMk9BcldBZ09QQTN0dXpFckcwZllNWVhs?=
 =?utf-8?B?YzgrUU1GZlJhWWFaVXE5dzlGNG5Sd2xOd05yRGRlUXo5VnVrQ3dFcXM5ZjdS?=
 =?utf-8?B?WGJNaUxiMG41Tm5ubWJySEV4K2x5NTBxR0FjN0RFNWIrZVRMajNGdkl3ck14?=
 =?utf-8?B?aGVCcExZN0s2YmlnRTdOSTRoYmMxK1BRY3A3Ri9yMlJiejRXK0FUQllmRXUy?=
 =?utf-8?B?emloN1hQTGsxNkh1cDdaeHNRVFh0OTBKU3hQbUZXNjltN2tnaVRoeW9vcVhh?=
 =?utf-8?B?NzF1bTZnMTlMd3orcHQ5dk9JTXNPclhjQjRpYU9Td0U1UVp5cm5FOHdRMjlr?=
 =?utf-8?B?SlgzbFNTdldWMmg2NlJBdk9WTjlkVGVpN2VJdUtkWFpaRmVSYnBrRmI4QUcz?=
 =?utf-8?B?Unl2SGx2RW1RTEhyaS9ITVhxNC9PRVAvMUFRSEEralVYaXE4Y0wvcVU2Y2hl?=
 =?utf-8?B?QUFFbG1Na2s2RlpQNUs5SGpYdVhJZFovb284b0tITW10RjVrb25HamJNZ2kv?=
 =?utf-8?B?VVlxUkt6d0pPRVlCVGFYenlHRjZEVnhLRFRQZUE2eno3em9EQVdaOXdoRE81?=
 =?utf-8?B?TnRKWElCWXFVRWlhN2hJeWU2ay9tczBMNnY2SWZObjlpaUo5SUtFNmlkaHZu?=
 =?utf-8?B?THFpMWM0VU56NWhTNXp1aW0xeStheWR0ejd1aHcxSlUvRVBwU0RLbEFCdit0?=
 =?utf-8?B?dkpNQlJWMGZwd2VpWmhmbmxWYURYdllpUUFiTDZtSWdReGF3Yy93b2grcG9J?=
 =?utf-8?B?Nmkra205UXp0UGEwaERKaUlHblE3cytxMm4vNE5ua0NqcG1mQW1RSW9qUWNK?=
 =?utf-8?B?QmZ0YjZkcWpnNkZsKzJySTVlNTJuUmI3NUxLckkyOTE1VlA5bGpURHY4cTg5?=
 =?utf-8?B?Qkg3VjZ0OEwyMWdZV0Y1NE1WVG13dDhmeEYyMC91cXNaQitRWjhNT1JzUFVK?=
 =?utf-8?B?WUY2WXphcUhJbjY2TzdacGV0VFFZVDJuT2tmWmRQdTQ4N1l5UWQ2MS9WNWxp?=
 =?utf-8?B?Zys4YU9nREZGWStMU2dPdk5Yd1VVWFNFeFpKZXJrSm5mTVBhcW9JR1Z0djUx?=
 =?utf-8?B?Yi92Qm9HTkhNRDJKMmk5d0JRU0JPaU5zZGhUQndiUkVoRyswdm1hRE0vYkNX?=
 =?utf-8?B?aURFcGQ4VWE1Qk81RElOSXpnQjVrN3lIRU9BSHRQZER5Q1NjektTNE5TejQv?=
 =?utf-8?B?d1cvbWYxbGlQbHFLOFVJcEsvRHRub3M0L0s0TFVGZkZKcUg0ajF6QzA3aThu?=
 =?utf-8?B?emJwbk44M0hrV3J6TnVCL0Q3UU1tN3daOHFSTXFXQzZQTStDclU1bWJpRWU5?=
 =?utf-8?B?YW5kMjdNVmR2M1JWakhFSFhUc05zT3E0VFdzdGhwY2NkVVl4ZUxDU2Mrb2Yz?=
 =?utf-8?B?VjVIdFFJTktId2xMNkdUVnBPMEVJN3ZkYUpuVzJ6RHlzRTc0K2hRT3QyMU41?=
 =?utf-8?B?UEtmWFpocTNwZjh0NHY4a09GbG5DMHFIcEFONWNPbWpLUGtPUG1vK2g2QzN6?=
 =?utf-8?B?NTdHK0dreUxsQ2JsSUQ1MGJDek5XSDhqYms3U29nT2xOeG5QdDFaaHNMdm1u?=
 =?utf-8?B?bkFBbXpmMkR1ZWh6VFRVZTZwaW8yb1ZTWHRHOWlQM1NtZHJpb0NhcDRGYnpi?=
 =?utf-8?B?bDI2cVhuMGV0SlR3bVdoY08yY09iaXV5RmI5SXRYRnBMSUdDWkwxb3NXamcr?=
 =?utf-8?B?MHlvcmJKNVhsQUc3OGhEcmQzL05qMGpDcDVHYUp6MkhPMCsrazhhdys0b1c2?=
 =?utf-8?B?U1JHNmFCd0paR2cyblh5WjliQUh6RDF2NHRzR3BCeHg3K3BuTzZ1YUlHZC9I?=
 =?utf-8?B?Wjl5TTJSaFY5ZlBJamxXa2ovT3U0anQ0WTB6OFBnOUhuWXRnZG1na1JLQUpt?=
 =?utf-8?B?amdjLzMzNVpmTFM0c25KOFBMMVpmWGJLVmFOVlp2TElhbXNBMG0yM0x4WWha?=
 =?utf-8?B?Tk92bUU5QTFOWTVwRFlqZWsycDJPamJJQjROaTBQMWRVRUdWWmZocTY5MzdK?=
 =?utf-8?B?UHh4ejZnU3hWNnJZeGYxQmJiWTh6U0FGMUFKNDlVaDNmM09mNGNUV0g2ejc3?=
 =?utf-8?B?d3NUVUFzdk9Sb3drQVJnOUcxUlo5WFhzaEFkeDB0cDRmZzV0ZVdDNTk2d01M?=
 =?utf-8?B?dTJ0WmpjdjZ6T1Y3WkY2WElBMzFTTEZZKzNIRlNvbklnbXgwcTdrczV6MGll?=
 =?utf-8?Q?pZNCM/9s78G53ZSChCNCvop8DOnCv959ilfT48UM/uMz?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0E6315F9993DB8439FA9216FF9E42961@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9404.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d631d594-2853-4a6c-28e8-08ddffc2d069
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Sep 2025 01:43:54.1221
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oKi5/UFkpjAueVir7tl7FR/MWi2VA531br4zgc3v2eirXzNfXFd8pQ4A1GyaT4fDgjQivVSNN6PzWqdap6E1mA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6437
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250929_184400_006522_854FE618 
X-CRM114-Status: UNSURE (   7.43  )
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

T24gOS8yOC8yNSAwNDo1MSwgTWF4IEd1cnRvdm95IHdyb3RlOg0KPiBFeHBhbmQgdGhlIHRyYW5z
cG9ydCBzdXBwb3J0IGZvciB0aGUgZGlzY292ZXJ5IHRlc3QgZnJvbSBsb29wLW9ubHkNCj4gdG8g
aW5jbHVkZSBUQ1AgYW5kIFJETUEgdHJhbnNwb3J0cy4gVGhpcyBhbGxvd3MgdGVzdGluZyBOVk1l
LW9GDQo+IGRpc2NvdmVyeSBmdW5jdGlvbmFsaXR5IGFjcm9zcyBkaWZmZXJlbnQgdHJhbnNwb3J0
IHByb3RvY29scy4NCj4NCj4gU2lnbmVkLW9mZi1ieTogTWF4IEd1cnRvdm95PG1ndXJ0b3ZveUBu
dmlkaWEuY29tPg0KDQpMb29rcyBnb29kLg0KDQpSZXZpZXdlZC1ieTogQ2hhaXRhbnlhIEt1bGth
cm5pIDxrY2hAbnZpZGlhLmNvbT4NCg0KLWNrDQoNCg0K

