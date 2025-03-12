Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E77E9C28B28
	for <linux-nvme@archiver.kernel.org>; Wed, 12 Mar 2025 17:43:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=gOb7ZTuxncvP/YxFEOcS8DmBG+JZAkZqpiJMUXTyXfw=; b=3c/n8aH30u5Bs/rh++lTInhul8
	3JladDIMGSxVoOjJfxAYcQe3DGFBHpjczy6mXWnLOf1kF5H92Hpn1t54C9j9MIqTGbhyu4ZBQy9+B
	Rw0K8OszFsItOQqn5qJhodAVne0XCF9dYEHeOhydggT3p5QGqLgnAkQAAr6ykruuzXOhXxdi3wmcC
	axjdS1zxBVWUu28FiXQ8dFPd164RkPbvuTdcYUtyzdAY0NB5FcmmExKBvYCIrzBmh1U4MAFK+2I6E
	ATyZxa0aWt9icw6KLYuNhCwSvha90Pt+piTEnmXT/nuMJOVvwXfisZWY6S+KyT2uPCz4WIgcCwY0N
	n3SePwbg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tsQ6z-00000009ADV-0ztB;
	Wed, 12 Mar 2025 17:43:21 +0000
Received: from mail-mw2nam10on2062e.outbound.protection.outlook.com ([2a01:111:f403:2412::62e] helo=NAM10-MW2-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tsQ6w-00000009ACN-1aC0
	for linux-nvme@lists.infradead.org;
	Wed, 12 Mar 2025 17:43:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JrjEeDwF87xWZKBSBu4eiauW5lbrWKB3qtMNWxhEURguPtRX6KeM/tU4rJKyWy6K/on+4EpHmxTQlHe/xTNF9daxHV5r6fTlk1rbutOjm3GJYMx+wyHNahGhWG8pJWUHAX8xAvbNPAjGvy4KNeRn0FMXSu5oZD1SrRjZgIuKmIWy+cA9MwWD08mVedE5FZYFnyMRI7ZYuvJ6eEA5VsZ+rbem6Q/nKKw3nKcxQ5QXXUUwudF02EtH+SiBQ7h9F8d6C9XTQ2A0Kdw/wk4SYm0uhCJ/BmajN3YLabQoHoHpUQGsVFjooBF2Ggg7v69V3iRGkM5qdaye5pLTtDfT916YYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gOb7ZTuxncvP/YxFEOcS8DmBG+JZAkZqpiJMUXTyXfw=;
 b=ai95qpE1LlpOCpw/BdJbBDkZ5JINlViYoQhUVr8m5Zdy2LOyUTJPn7qWroRICm3x5/ji06SpiIp26QvLMAMtyzIGLjOY7yQJYjgmG7Hiw4mN9HGp6cUUgOyCg5vyg4ou6Bt1xG23vmfeEaLaaXo8ywD21HwWuZUVbU7WcExNJ0jmQ3XN0TorUnW27FwD/Yo7PXn8ytFbwU+XsQtVm6zkUxL6xmuWY+62IGHhKfOzTb4l7IRuZXBIe707y1eUnLsPGyO7B1++aSN1K0DX4rVeL2IOP+jIH95lA/kmQcVTEOrXFVjaaDbm3H4R17ST3jiuuuqZkXT8I8lmeaSC/2ix1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gOb7ZTuxncvP/YxFEOcS8DmBG+JZAkZqpiJMUXTyXfw=;
 b=JIYuGyyc3gimBiAiaJJgm4dCuoZYPShroqQp4uAyPmDW6I8pyy8AaCoSL1eRf1jeHjWJZdBUXDMBaP6rP0Zy3fkOESJiq6baxysnS0kW118U/L2LsDo7nRKnQsLUwuA+LuBybWRP0MxVdRT6CXDIPmlhyW2TxQPT2XDR2fRL/PUf1zZsxZVnPs/p/DqzcfZBirphuRsQzNHYRM3cPWDy2ki3+OTSRyuk4XF/Q6w2aFBkTuxSPkml0F608w3Wpe5miZympr11QJMMSfGxd3Yg6XOFd5C/Oehg+ll5wJ9mLrOGLs3HTlbng//P7/+RyhfK1/Hw2ogO5tHaxkEFy4r01A==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by DS0PR12MB7828.namprd12.prod.outlook.com (2603:10b6:8:14b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Wed, 12 Mar
 2025 17:43:05 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b%5]) with mapi id 15.20.8511.026; Wed, 12 Mar 2025
 17:43:04 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: WangYuli <wangyuli@uniontech.com>, "james.smart@broadcom.com"
	<james.smart@broadcom.com>, "hch@lst.de" <hch@lst.de>, "sagi@grimberg.me"
	<sagi@grimberg.me>, Chaitanya Kulkarni <chaitanyak@nvidia.com>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"james_p_freyensee@linux.intel.com" <james_p_freyensee@linux.intel.com>,
	"jthumshirn@suse.de" <jthumshirn@suse.de>, "zhanjun@uniontech.com"
	<zhanjun@uniontech.com>, "niecheng1@uniontech.com" <niecheng1@uniontech.com>,
	"guanwentao@uniontech.com" <guanwentao@uniontech.com>,
	"chenlinxuan@uniontech.com" <chenlinxuan@uniontech.com>
Subject: Re: [PATCH] nvmet-fc: Remove unused functions
Thread-Topic: [PATCH] nvmet-fc: Remove unused functions
Thread-Index: AQHbkwzVcnEdmECP2EOgjPfDW0F2wLNvxlAA
Date: Wed, 12 Mar 2025 17:43:04 +0000
Message-ID: <38766aaa-2080-4774-b215-f21d6fab35d5@nvidia.com>
References: <E2A54BF9E5C050B5+20250312050650.1793024-1-wangyuli@uniontech.com>
In-Reply-To: <E2A54BF9E5C050B5+20250312050650.1793024-1-wangyuli@uniontech.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|DS0PR12MB7828:EE_
x-ms-office365-filtering-correlation-id: 615ac88e-cd08-4ed4-7cc3-08dd618d57ba
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|10070799003|7416014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?aGRjdkhuU2RCZ0Y2MzJyYzR5VW82QnIvRnR4QUxtSFIvVTcvQ0NjOGRTUnYw?=
 =?utf-8?B?UktXa0VYbjlITmVyL3YvbDY2VEpkTkJweW9BLzBWV3RZUG5nU3pJbVRzaU1Q?=
 =?utf-8?B?TmFUYU9ESGhJRlFpL0VWTGZvQVlmVXVodXZSbytnTkhLWlVUTm41TXBYSWEy?=
 =?utf-8?B?Z1UxL3MrK2xHMHduSTZ5a1RUR1FEU2VXV3RyK0dSclRka2tIWlE1YkFwOTh5?=
 =?utf-8?B?Vi9IRHVYa3hkTnIvOU9rZ0lKemRLN2xFWFNkREtGUE9HRndYV0ZrY1ZsYmtu?=
 =?utf-8?B?VGhBbGltL1JoNWM3WlhDSG1ramZqY0dZeTcvQU5wZjdOWStzR0Z2NnBtMjgz?=
 =?utf-8?B?NWRzY2liZFU3QXl1TGRNSS9ZY3cwQndya2NlYUlkL0JqNGVRMklnaFkwUjND?=
 =?utf-8?B?Z0JZZUI3a2pMVFJpeWY5ZXl4dXIvQnhvTEFLQVpEUW1lWmZZa1pmN1ljQmNQ?=
 =?utf-8?B?SnRBZ0RLcW5hUkpQSzZZQm5EcEhQY1NacGk1RHl4U2dOaTN4NmNsdlcxQXZs?=
 =?utf-8?B?aG51a1c5Y3BRVXpUZGhyZTJ0blNXTkFtSmF4bUJSdHh2NEcxVTNkQ2FmUHkz?=
 =?utf-8?B?bmRUQ0FFM1B6UzNhcjdLbnNwdmw5NGMyNGpCYVUvQjBtTCtuY1lyKzNReDM0?=
 =?utf-8?B?NTRTMEs1Q1Exb3RTcFVwMHVsN2R1RFJ3aU54azMveHk1ZllHVFQxN1htUEFx?=
 =?utf-8?B?RGt4MmFRd05NekFkK0xLZnowOXlVMTExWk13RSsxYnJkcW9ZTTBNSmpVVCti?=
 =?utf-8?B?WmloRmk3TnlLZ3lmQTFvMmJlbTdCdTVyUHppNGlWVGE3ZlBFR1l0bVQ5WGE2?=
 =?utf-8?B?ekc5TTdCY3R2ZWdUais5Z01OUS91NWhSR0kweGJreVlUZ2N2N0MxVG5GaVM3?=
 =?utf-8?B?aStVdkU0Uk9idzlNOVlUNTVacEpMejIrUHgvZENySkt6dzZ5YUt3WnpFZXhh?=
 =?utf-8?B?eTlKM043b2FuREhaV3Rjb2U1QktCMkdjZXVvdnlmUUhpN3J2NXBNaFI3SDVG?=
 =?utf-8?B?UUl2dFc4UXEycDAvdEw4Lytwb2p4MXZTTzRJbXQ1ZDNBWnhTL29aWi96Mkl5?=
 =?utf-8?B?ZmtnQXFjVXBWSVN4ZUJxUkVmd1Z3Z0NSYitLazNienZoYk1lOFhUYWlqZlVO?=
 =?utf-8?B?UTY3bUdaVTBVc09nU0V1clBZSFViU2ZBV1h4NFAvellPOEFkVnJJUkNNMTBv?=
 =?utf-8?B?UFlDUnJNNktRTGQzaHZDdURzTk9RSHhCb3dIT2VncWRRcUtpNDZnOEVXamwy?=
 =?utf-8?B?dm5QSDVUb2l2SDJDNUwwbmVsNFY5bFhpQ3V2Ymd5b3pqUHJEbmp4Y1kzNzJT?=
 =?utf-8?B?WUV6TjN3TW1OcWgrYkJONk5Pd1hIbjg2Sm53d2RYWWtjMTYxeTBPdzhaQmFu?=
 =?utf-8?B?MnY2VWZGSE55bjhBSFZCM1BVaEdYa3RvUytRWHdTTnFYS1VIelFsaDgzZ2xX?=
 =?utf-8?B?U0RMN0Z1WHNINU1NUDQ0OVhXaWtZSnVsUFN0RmcvVHJra0VPUXVnc2UvNmE0?=
 =?utf-8?B?ditkeDlSMFBJMDBzZmtOSUpOZ1JhRVEwWkxMWGsrckx3K2lSb3VxeDJSQ1Vz?=
 =?utf-8?B?a2dHeFZHMXMvODRTTnJjN0dRenkrdmIrOG5oUFlUOGRKTmhhQ1owVjR3Q211?=
 =?utf-8?B?NFl4SWtyU3RPSDhObkY4dVp1M3pqaktuRTJ6TnQ2THR5Y2cyTThiUk4vcDVz?=
 =?utf-8?B?WU9kek1mT0FZYytib0N1SXVrZkVrM2tJZ21uMlZiRHZaamtINVNLTlR0Q21k?=
 =?utf-8?B?d3VMaS9vcjRyckQ1M3VhVTRuYXdBQiswRWdhOUtsbWlOWkN1YUE5eXF1U1U2?=
 =?utf-8?B?NlpLVXppUExUcnRyTTBUWE9VcDlJR29wdVd0SWFMb0I0T1czZkZxY1QyTGp5?=
 =?utf-8?B?cThKWnlVeXVQT1p5Q090RWRYbENXMDZ1eVV1T1RLL1FyUnBvaUMxSDlZUER3?=
 =?utf-8?Q?3fmex28Vl38=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(10070799003)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?M3daSTdwTU1kSUdDc2gvcXlvcldpT2VwRU9yYkR5eEF1UEc5Zk5WT0E3K3Qx?=
 =?utf-8?B?aDhxdHFoR200R0czQnd4SW5NNTlPbzZ0ZFk1aVErUVJteWhORFNHM1BwKzhX?=
 =?utf-8?B?ZWh1L2xCUWFXL0t0b3RsakpIbHlRdkRaeUpJNkVYeXJGV2RDVHgvQ0pZU1J1?=
 =?utf-8?B?S3NCZjFlK3JLdTlVYWNVYkxvSHl5dzRoZUg1ZUh0cFZjTlIwaXgrak9RdzFa?=
 =?utf-8?B?dnNIQUdNRHBhOHZVTFJFejVrYnhCUW5jRHBpMUdselBsYzBTQ1h5VENkcUNi?=
 =?utf-8?B?TUJ1YnY1VmVnUEVCUHlqUlFuSXZsaS9Lb0ZabmcwN2pmU1p1RnhCVDMvZjNZ?=
 =?utf-8?B?cUhlT3BwVmdnalVQNVBVaEY4MzJuTmdTcFBNZE51ZDE4WUdkYlNwd3dkNnpG?=
 =?utf-8?B?NVpkakNzekNLN1Nzb1ZJQW5yYVE0SzErN3BKWERzUjVjT3A3YmtmVVRwK0R6?=
 =?utf-8?B?bENWcUNyZm9aejFWNytrN2plcmxKVllzeUlHZlg1N05IOEJvMFdLeHdZUFlF?=
 =?utf-8?B?VUY4SzF4TkJ3b0ovUWpkdWVld0x1L2xaeU9haHZIT04wMTdLeW1DMzFCS3VN?=
 =?utf-8?B?UkRBcTFWQ3ROYWZ6Y05yQmlEZjB5RmQ2MlR5ZTZxTzhDNnVLWURMZW9WaTFO?=
 =?utf-8?B?VnNnbFd3eVlvR1IvQ0pwNHoxRlpxSWkzRnEwTlZOeW1UR1htMWxnU3VZbTFt?=
 =?utf-8?B?SEdqVDlZYU0yajAyL05DdFdncXN0TkJkaXRMMGdTcEtEb3E1TmpNSUhxVzVL?=
 =?utf-8?B?VEdYV2NiL2QwNGVIMmFmdUEwWEN3MVZhSWk1clJXYnRpbXE2Y1A2andxcGpI?=
 =?utf-8?B?UGw0b2tNaklDUkkwNVdrYUhmcUNGUGJFb3FrVFBQdGpPWVhmMFl1a2FnOVFm?=
 =?utf-8?B?V3BjbU9pNitHN1RneGdURmVUU0pIYTdYVjZpVmk1OXg4b2tyaFcveVBBcFpt?=
 =?utf-8?B?QkgzaUlLSGl6Y3lKalByc0ZlOCtxR3FsWitjckpjVDhKSW5Ha1Q4UHhkSmpU?=
 =?utf-8?B?K052RmlVTFFUQ2NlbGIrdURDU0crenpPN0M0ajZ4b1Z0dG44WG9LZjk1aUJG?=
 =?utf-8?B?cmcvcmsxUUViZGdnWlVDdDFqQ09ITk1KbFR1NVBid3ZsNGw4a0NDN3JNTmw0?=
 =?utf-8?B?V242NVpMUUxWK29BRHdLczE5QjYwdmJlVUx4UC95cGpRQWVGMjk2czRSYmRB?=
 =?utf-8?B?VHc2Zi9WK1k5WkpabEZnTU5TdUNMeWpFWVUzWnZjZmYzU0x2dVorUEdUd2Jp?=
 =?utf-8?B?R0MyV21lN1RnT20yZWh1UHd0S0NFaHNNamNPbEl1cXBhc0hDOXFBaGFsSlFL?=
 =?utf-8?B?MDNmcDdkMzJ0ditWQUE1QWFzNTFWZUsvSC9kUGNWc3JrRHdQMmFRS2IrekN6?=
 =?utf-8?B?eHByN3VUYzlBSjZuMDNoT3MxZlVEajFUL1A0VzA5UUpTb0FBZmdRYmN4ckxs?=
 =?utf-8?B?Q3BTUFYwQk05TUxzRElJaHcwam04bEcvYlFtTWJHUEo2RWdXV3IrbXU2Q2o2?=
 =?utf-8?B?eWVLNFNBSUR3cEdlM3J6eGZvQmE1cnhYT2d0a1BWUmNSQ09vVUpmb3d3aHUx?=
 =?utf-8?B?dEtNa0N4cGQvUmZ4b2tVYnU5NDRIVU1MSG9sSlJSQ1FjRUJBaUh5VTVYcS9C?=
 =?utf-8?B?cTM2M1RmbS9COEhtb24xbXcvU2FnNFlJZFczN3J6LzRGSU9sRzE0MVFZM243?=
 =?utf-8?B?REtpeVFGTUZRZWkrZGF5TG9IWVlKL09CaHozbUJNV0lpTHNPdVhUTzViL1FB?=
 =?utf-8?B?K3RJM1AybkhKUW5yb090cHRPcUlxaDBKOHFwVEJxeHFmV2Z6OUFpS1p5ZGZ3?=
 =?utf-8?B?YUhqVlNFMVlmT2ZjWlowV2NvUS9QR0JBazV1YW9FZFNlUko5TEM0NEJXcVR5?=
 =?utf-8?B?V3JHSmZqNWRwd3U0eEFvK2dKU1ByYTRiV2dhY3FsRnBEQjIxb2p5SmJGZ0c0?=
 =?utf-8?B?TURxT3BxZnBvdFhiQTFEMHMwMm9DT3MvSGRSN2ViOHFBUFZncFgzK0dSZ3Ew?=
 =?utf-8?B?SnV1NVY5RkJsVmZhTlFlMXU5S0ROUEpMSjZuRkJKcTUwbDZ3bDVHb3F4MnBY?=
 =?utf-8?B?WHkrYk5HQVZZY1g0MEc0R0N2MlU2UjRXU3g1NUxnY0VKbFdZNkRaTklZVEhB?=
 =?utf-8?B?b1JxR3ZWcExLYmJMbi9tSm5KWXRYUHVUck9IdEdYK3o0a0xxZWVlVk1WMXZr?=
 =?utf-8?Q?8y9K4wPfYSEP2lI2glAh4yDdgCLtj72vNpThScCI40hF?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9BA01AE66E97F148975AA5BC416B11A8@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9404.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 615ac88e-cd08-4ed4-7cc3-08dd618d57ba
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Mar 2025 17:43:04.6528
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: W9sKppG91qMj7oSDPQAdbFZnPqXJjape/DeTfjUQOn2mFCsqluvGDLfNstQMLVfkcGZv7FINkRKvExFwGzQOhg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7828
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250312_104318_430898_BC575315 
X-CRM114-Status: GOOD (  10.66  )
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

T24gMy8xMS8yNSAyMjowNiwgV2FuZ1l1bGkgd3JvdGU6DQo+IFRoZSBmdW5jdGlvbnMgbnZtZXRf
ZmNfaW9kbnVtKCkgYW5kIG52bWV0X2ZjX2ZvZG51bSgpIGFyZSBjdXJyZW50bHkNCj4gdW51dGls
aXplZC4NCj4NCj4gRm9sbG93aW5nIGNvbW1pdCBjNTM0MzIwMzBkODYgKCJudm1lLWZhYnJpY3M6
IEFkZCB0YXJnZXQgc3VwcG9ydCBmb3IgRkMNCj4gdHJhbnNwb3J0IiksIHdoaWNoIGludHJvZHVj
ZWQgdGhlc2UgdHdvIGZ1bmN0aW9ucywgdGhleSBoYXZlIG5vdCBiZWVuDQo+IHVzZWQgYXQgYWxs
IGluIHByYWN0aWNlLg0KPg0KPiBSZW1vdmUgdGhlbSB0byByZXNvbHZlIHRoZSBjb21waWxlciB3
YXJuaW5ncy4NCj4NCj4gRml4IGZvbGxvdyBlcnJvcnMgd2l0aCBjbGFuZy0xOSB3aGVuIFc9MWU6
DQo+ICAgIGRyaXZlcnMvbnZtZS90YXJnZXQvZmMuYzoxNzc6MTogZXJyb3I6IHVudXNlZCBmdW5j
dGlvbiAnbnZtZXRfZmNfaW9kbnVtJyBbLVdlcnJvciwtV3VudXNlZC1mdW5jdGlvbl0NCj4gICAg
ICAxNzcgfCBudm1ldF9mY19pb2RudW0oc3RydWN0IG52bWV0X2ZjX2xzX2lvZCAqaW9kcHRyKQ0K
PiAgICAgICAgICB8IF5+fn5+fn5+fn5+fn5+fg0KPiAgICBkcml2ZXJzL252bWUvdGFyZ2V0L2Zj
LmM6MTgzOjE6IGVycm9yOiB1bnVzZWQgZnVuY3Rpb24gJ252bWV0X2ZjX2ZvZG51bScgWy1XZXJy
b3IsLVd1bnVzZWQtZnVuY3Rpb25dDQo+ICAgICAgMTgzIHwgbnZtZXRfZmNfZm9kbnVtKHN0cnVj
dCBudm1ldF9mY19mY3BfaW9kICpmb2RwdHIpDQo+ICAgICAgICAgIHwgXn5+fn5+fn5+fn5+fn5+
DQo+ICAgIDIgZXJyb3JzIGdlbmVyYXRlZC4NCj4gICAgbWFrZVs4XTogKioqIFtzY3JpcHRzL01h
a2VmaWxlLmJ1aWxkOjIwNzogZHJpdmVycy9udm1lL3RhcmdldC9mYy5vXSBFcnJvciAxDQo+ICAg
IG1ha2VbN106ICoqKiBbc2NyaXB0cy9NYWtlZmlsZS5idWlsZDo0NjU6IGRyaXZlcnMvbnZtZS90
YXJnZXRdIEVycm9yIDINCj4gICAgbWFrZVs2XTogKioqIFtzY3JpcHRzL01ha2VmaWxlLmJ1aWxk
OjQ2NTogZHJpdmVycy9udm1lXSBFcnJvciAyDQo+ICAgIG1ha2VbNl06ICoqKiBXYWl0aW5nIGZv
ciB1bmZpbmlzaGVkIGpvYnMuLi4uDQo+DQo+IEZpeGVzOiBjNTM0MzIwMzBkODYgKCJudm1lLWZh
YnJpY3M6IEFkZCB0YXJnZXQgc3VwcG9ydCBmb3IgRkMgdHJhbnNwb3J0IikNCj4gU2lnbmVkLW9m
Zi1ieTogV2FuZ1l1bGk8d2FuZ3l1bGlAdW5pb250ZWNoLmNvbT4NCg0KDQpMb29rcyBnb29kLg0K
DQpSZXZpZXdlZC1ieTogQ2hhaXRhbnlhIEt1bGthcm5pIDxrY2hAbnZpZGlhLmNvbT4NCg0KLWNr
DQoNCg0K

