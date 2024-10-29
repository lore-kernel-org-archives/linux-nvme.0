Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F201ED5B87A
	for <linux-nvme@archiver.kernel.org>; Tue, 29 Oct 2024 05:04:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=P3IpVGbSBeFk4Duvc7w/HIwZXjwubn4OhK4lUbctxXI=; b=YHILenKBCQs++zNc39qElH5TpJ
	IqKYlTlmA9nSafhHXSbwWc0gPRP5mo4Hfh+JDNPqdF8+wRG5E3z6aUEvuAo2XrT8srS8Ud9Ay+Uq2
	r7ESbrmLfq5PSEBYuM/vurzKjpRpIitasZWR/j/qaojEqrGUyDf8/3g57eYqfd3mRRQ1lK9xPyrgt
	EHlsn2IyIDmWgPe+QTqZZDZs4uQhC2ljaDUXxyfMIGqmEdn69niFnHxlMg4cFpUqdKRWac5VUe4SY
	3Q10T7qnPYVXG44ATU26HvL0NOST9WY81sztuDnC2DV8LqGoBELWZwI8OV5AChoXe037GAMhvn1Vl
	T3D4Zblg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t5ePM-0000000DE1Q-0HuD;
	Tue, 29 Oct 2024 05:04:44 +0000
Received: from mail-mw2nam10on2060f.outbound.protection.outlook.com ([2a01:111:f403:2412::60f] helo=NAM10-MW2-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t5ePJ-0000000DE0u-0hIK
	for linux-nvme@lists.infradead.org;
	Tue, 29 Oct 2024 05:04:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Kkr5RWRHytTkc6chFLVx9IGAnXAGo5hkXStLiJVGVSr/Et3AtpZJYztHS8gVlqWdlW9GSyzSHZeKuTj6/pS2bQAP17GsgXr2NopBF5VqxURqHOdsvyclWd2tCZ3hn3i0ijnO/ywTLh8Gm9DrygieFy2H+O7BwhECV6OnIEPzJ0oXW5ffiP2EpD/ef+pAlJ/Qe57cJtwYCsGVra8kWXPzjTYfXQrvadidxVqyG3AvEUs5gPf+FetrwIf0obU7CETzStFTEPdmIKu1KMO7/EXPkHi5LkYP5AoUD9NHE/HivB3A1wbuyGS7q8EMy4pMfRkcE/e74tPzqJPfjrUJVKduJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P3IpVGbSBeFk4Duvc7w/HIwZXjwubn4OhK4lUbctxXI=;
 b=W0JcYSvDD46dRVy/xo1RJNzsC9Bm4T4YY/j4irGFJsAqvQPGtFzv0cVKlXoZIEM1EdpltpCtU912lrs4cYiZFx9tQ2r+2taiFgOK3Ezlh3RWcsNZ5WDi9qXnouR/hUW7u7nWbgqFIm0o3jT+3WG0PweFD3+PPLQn8QAX0DJjKi52BPn306s5qPUxvV3pqwtE6zNRQDWyPvnc4LWtjLDz9kkh5DV+lvV0jS8kD/Nv5/ABTrbZWAcCOCVrsdgUTK0iNX0/XT5MJn739ZDSk8QUn7w3005lQ30K7rVtbKU0Xzqh/hMoRQQyk+nhfXeLM8IRp1xmHDciAd9BTAiG6kgekQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P3IpVGbSBeFk4Duvc7w/HIwZXjwubn4OhK4lUbctxXI=;
 b=Kx+f0WcjxX2BdaPcIcNxJVuaQIspArdCBmp3r+mx3xL+RbaqI/b1Ee2Om+/irUG3ac/i945rMgZTsEDUFKdF+jisJxfWKsG2kXvV8KwMKQbIjvD106/QrpAe0Lyw1yvrjs1tyUgB0roEpeIYSHeQd1Soxp8tZOKSLNfwAM6yE0uq3Fh959DT3F2giEDiSRosJDkDvmtuzijH3npc5LQtE9fLMJHQnmzuLejPs0s+BcXOZhzAbIfU39nle2sziNm/FVNaSO/AMkYBBu/KelUaRdGweipCeOrMElVAP3KVbSjf7xFWuz+r0k6Nx2yycVb7gROazF05SIKvG1s57psMsQ==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by BL3PR12MB6449.namprd12.prod.outlook.com (2603:10b6:208:3b8::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.24; Tue, 29 Oct
 2024 05:04:35 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b%5]) with mapi id 15.20.8093.018; Tue, 29 Oct 2024
 05:04:33 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Guixin Liu <kanie@linux.alibaba.com>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"hch@lst.de" <hch@lst.de>, Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	"sagi@grimberg.me" <sagi@grimberg.me>
Subject: Re: [PATCH] nvmet: make nvmet_wq visible in sysfs
Thread-Topic: [PATCH] nvmet: make nvmet_wq visible in sysfs
Thread-Index: AQHbKaTLTwHNqlYqyUSj9qyQvVBFD7KdLMyA
Date: Tue, 29 Oct 2024 05:04:33 +0000
Message-ID: <8b4591d7-f0bd-4e4c-b1b3-1b375f25bda0@nvidia.com>
References: <20241029014915.16646-1-kanie@linux.alibaba.com>
In-Reply-To: <20241029014915.16646-1-kanie@linux.alibaba.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|BL3PR12MB6449:EE_
x-ms-office365-filtering-correlation-id: 566cb8ed-ea9d-4192-9088-08dcf7d72dc6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?SmZuNzVtank0NzdWM0FHdS82Q0prM2JLT3B2LzZkWk1JV2NEcHB6ajhZRThY?=
 =?utf-8?B?SWEydjl3eWtMeGFsZm9Ic3VpU3RhWnhvS3NUTis1eVBQWFgrb3Z6dVJ6WEgy?=
 =?utf-8?B?bVVKRFhkVG16ZUdUSVR0dGdGSUF2ejFkbXc3WUEvK0l6REhmWk51akdEbXBP?=
 =?utf-8?B?K2VFdlkrMm54cUFOWmhieFh2dk9rOWt6YkxGM28zUjNJQlBwaWgvZ2FtQ29O?=
 =?utf-8?B?d2JiQzd6aEJMd1p3OWxvTEc0V090WjdodVBJdDl6T1lIY21TcGNiVWQ1QjlV?=
 =?utf-8?B?Snh2VzUvc1QrYS9IS2pSZ2kxYk1veGFTakkvaStuSTNrTUZ1eE1DSWhEMWUw?=
 =?utf-8?B?TGs2b1FuK3VzMnRmQmY0SitabkNzWTF3OUpid0d4TzJ0bU9veTJNTzE1dUt2?=
 =?utf-8?B?WW9ITzl2ejJuMHVuM2ZKQ2xkOGQrMTVKQU16aEhKSStWWmVpcjBINlhQQUp3?=
 =?utf-8?B?U0xQTityM1dFVm5pNUZVL2VWSmJxOHUyV0FwTFJ3ajlWbmFVY3o2SjRnbjlX?=
 =?utf-8?B?ektZbUMvVW91TnozWG9xVzdJVU9yVU5EdnJIQklqbGk3b1czSGlRZXQrRmw1?=
 =?utf-8?B?NHI1a25zS0ZtZ0FKOTFLMzZqdzlOeDlIV1pVWXRQR01RcHRnU3c5YzNDaFd4?=
 =?utf-8?B?aHNhbkZ1N0h5d0ZnQkd2QUxnRVFhYjB4TWRCL3lHdE1aNkZLVE1uK1h5cURG?=
 =?utf-8?B?QXVkRkVZdkNRMjVITzRleUt5QzZrUUp5cmdLYSs0andOVDJoQnkyd3hpZzRq?=
 =?utf-8?B?SEtLdm9VNW0xbmx5MWgyc0ZnZlFnRFRldDBQN0J1dVV3cXJYb3d1QmVvL3RJ?=
 =?utf-8?B?NVhtKzJVRk13RmZXWmkwbTZHdXpqY3BSQUgyeTRVRW1XZnNJYWxtVDA5RS9H?=
 =?utf-8?B?VEh2TFpzQkxPSzR4dlJ4WmF6a0gwODVtN2N5TUFzc01veGhNUTJWbkhkdWFa?=
 =?utf-8?B?M1phTlBaelBNQ1ZlKzJ4bFFjT2NyK1hWUElodWJzSURWNW9uNmhIOUlxaWEz?=
 =?utf-8?B?TjAzMmpQMFF2M05BdkYwWkEvbWE2bmxQL2xPaW1DSEVKMjVabEYwbUh1Rk40?=
 =?utf-8?B?YTVwUU1la1JwbjZyeUdKNmRLbzAyL3BlUldsaUJaNEF5cTBEcUtsWnVaUm5Y?=
 =?utf-8?B?NVJ5NCszQU5ya2VBOHhjcDlUUlV5MVVxL24ycmVTVGNrOFkvY3F1SE4vTGJB?=
 =?utf-8?B?OGdYMDJmUC9hOEJZQTBvYklWOC9uNDU2Y1BNWFNoY0hzbDNHOXFTa0xhSU8y?=
 =?utf-8?B?bmhlbEdWNWlLSmlURHpieGVka05sV21yNVNxQWllS01uTkFNRU5YZUQ2YXZI?=
 =?utf-8?B?TUhBazVnQjBDTk8zSWx0SGFQQ1c5SGJsZnJoYk9FcWhpeFJTTDh4R2E1RVlN?=
 =?utf-8?B?MlczaGlsWmd3azdvOVJnZmpBc0Q5U3VyTFpNMUxGdkY0Mmgrd3E3RWszUUUy?=
 =?utf-8?B?cmJvaHhaOTFuUTdSczFGcWZvN0pqTnVvYW1ZNElzNndkODN6azFKbDg0WDdk?=
 =?utf-8?B?UCtwRUdSQWxSVC83ZVdRbVhuOTlSb0YzRTBIZmV3a3Zzb1VnaU9lZDZ0cHB1?=
 =?utf-8?B?b1hMeklRcVBtUVNMeVhhUVlwRU42TUNoLzR5cFJxcVUzZ1JrWGZsT0xlbFhC?=
 =?utf-8?B?WUw2b2hQem82bTd2TUxvMUoxMlNzWWpjVWFreExyLzhFZUg2aExyVWNPM3ZQ?=
 =?utf-8?B?NVVoL3A2UkI2eFBvMU1LMnE0WGswL0VXMTdtNVpxYTZXTzkvMFZvbzBlMVVS?=
 =?utf-8?B?YWczd3F0SWhlNWVGUEdzOXlKa3RHVHdQWWFmOGtaZmowejZ4b0FoWndPMEh6?=
 =?utf-8?Q?vAR0vyNK4h01/vnUFz7C8UmLXPsIkpJt4tumk=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WTdMNkM0Yk1wRDFTNnlFWTFrbVRMemNKYXdWZTA5MU1QKzl3RmdpeVBYZlVQ?=
 =?utf-8?B?NUdLd0FSaXVXYWpSanB6bVZTRDVEYzQxMG5wY0xqc1kvN1dqZG5xS1hJbjJl?=
 =?utf-8?B?MDdxM3dxNGtrcTU4VGtra2lUNm1OWXVIUHdxMnZ5Z3lKUlNlRndTOG4yNkhR?=
 =?utf-8?B?L2d0bElHNys2NHR4WHdRN1poSU9ma21PR2ZmY0VYemFvcjl6NjJDckNSQity?=
 =?utf-8?B?Q2VwRVRqSTVzRTg1QWpRVlplQWs1MGpoTlVKcGI0Q2M5bEtQMytvUU1pNHhq?=
 =?utf-8?B?L3NmRHVhck5ma1ZOaDlCbDh6YVMvOVdtQU9wMEJhaG13NFFkeHNRMGtJbUVs?=
 =?utf-8?B?TTdxMWlLODRhbVNwTVdocitlTHg0cG1HWlZNaG9RMko4MHF0QVVrQy9ONVVa?=
 =?utf-8?B?eC8xdUhnQ25zUGpIWWdUTWJPaVN2azFCK3RiSHdRWWpuVmNDNzFvaHd6YmQz?=
 =?utf-8?B?SGJjZGs1NVg0VG0zS3JBc083Q0JKMnRsbTR5SGNvMjhqTmV6OFkzUk1keG9r?=
 =?utf-8?B?anFhdHRicER1ekJNL0dxL2xvZEV1Sm53TG9KTGpTUkdkbndhT1JoM1k3a2l0?=
 =?utf-8?B?b3JDNk1KRTVPQ2NQME1vK1BLdUdYK3UxNG1JMm5CYVQ3Y3NJM3gwUWNkS2Yr?=
 =?utf-8?B?ZzBpTnRmcWZmUG96emNIY2VpTWRBdjI4KzdUVkhnVDdBcDVkV0F1T2hsYU1X?=
 =?utf-8?B?aWJLdE4vK1dNSG9TSmdrbVpBMHlQaEVCM040OFM3SGVHZmhSU1drTmZWVjgy?=
 =?utf-8?B?UWt5Qld3QjVXZDU1RG0yUzFzMksvY3k1ei8xMCtZYlF2eCtPQmpIZ2wxQml0?=
 =?utf-8?B?QjJDcFl2ODVPbmZ5eXNOM0tqR2ptcFRINEhiNzd6WHU3U3g0UENnZyt4TzhF?=
 =?utf-8?B?UXp1bFhnc2VCb3l0bHYyMGI0bXk4dUJJa1E4NThPWldycmxiOHJPTlNnWHNq?=
 =?utf-8?B?MEtzQUpuMXBiNm9KMzdzUGVqUnBnNzF3UnJiU1YwNmV6eWovbUNDL0FJR29V?=
 =?utf-8?B?Y0JSQ01QeFBPb0ppbmV1eVdlT05DZzY1MlFGVW1oMkIzSUlaTnAvT04xNHpP?=
 =?utf-8?B?YkxxNmJXakVaa3dkL1VqZUFlK00xY2FVZ3JWeFZYMXUrdzBaTUtZZE5BcVFy?=
 =?utf-8?B?OHR1dFFOdjJNT3JBUlk3dCt4dUJhWlVOaUJPc3J4QUtxbmFkVVVpUkp0Lzdy?=
 =?utf-8?B?eGtQaUZzR1F2OFRISVBsdEJjSEZuNDBLWjYyZUF1U3ZqUTVtOVFTcU9aL2dZ?=
 =?utf-8?B?SEJWYmpSRVRxTGdtTjRxdFpkcE5SUlk1M2s3cytvN2JMQ3NxN2RYTVhySWUw?=
 =?utf-8?B?b0RrWTd1eExMd0dpeEQ3THUwRWJCOHFZdldaRnhkbVdxTEc5ZU1pSS9Ua280?=
 =?utf-8?B?ZTI1c2RjTm5iUDNhbXpNbnNDWURrSmdTTEJ5UU5ocTRSRk1sc1JQYjU0Qm1N?=
 =?utf-8?B?T3EvR0Q1Ym5JWXRwYW1BSStpSTB1MVluaGJialZsb3dSdWptUlN1ck55bmg4?=
 =?utf-8?B?THl5UG9SbXZiNEdnS1lER2phQ2ZWS2lMdXIrNGxVdjJobjlDekdqUE54QW9H?=
 =?utf-8?B?WlZSVis1a0xreDB0T05ZYjRsdGVOR3dkQTVBeEZpOHg3d0o1eEJyVVRhV09p?=
 =?utf-8?B?dXpIVmZlUHh2QWFxcW1PWEM3R2hldVV0QXRickUyTUh5Z1JMNHBFRVJhRzE2?=
 =?utf-8?B?Q1Rxd1lOOTJNSEdOSjZ1U2I0dHh4dGJadk1vb0t2VlZXdnB3N1J6MEJ2WFVJ?=
 =?utf-8?B?bGY5dDJIZFZOVnRCN2xwaEEzejdmcnhjKzRpbWQwbjhYYlY5ZXRKdGlxVDk2?=
 =?utf-8?B?ZkJZeXpUTXdyYTh4Ni9CZFgzQ3FnbEJ5RjVQditIV3FPbnBhYjl5RlhBSHZk?=
 =?utf-8?B?YW9YY09LWVBONmNBL3FPbEJ6MlhPVlMxdUk5R0RRd1diaHpwNXFlOEI4eFY1?=
 =?utf-8?B?emd5WVdSQlJqVksyOWFSK1RXVkRtMzZBMC8weFBSV0RJR2FPb2VNOGJnN05o?=
 =?utf-8?B?RXFlZzNqMG1DdktNdjcyWkhQREtpNjNaSEhWTGtuYmJEb3BQcWNOT1hqNFgr?=
 =?utf-8?B?NW5CSVJWbllLTnpxd0Fsc3RGV3RtbG9uQU5kUlZmM05PU0xJMkVYVXBiVlpX?=
 =?utf-8?Q?3XKhwI8jFJH6SvBPmVy17gsjp?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C5BA72A1D9E9A94A82416A1C12E43808@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9404.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 566cb8ed-ea9d-4192-9088-08dcf7d72dc6
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Oct 2024 05:04:33.7392
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uPsCjhUWRbZ+WbMFBc0xZuWPT2bR+WklyaRUBkgYy2FoEAOwVsILy7eWyRCLE9W6Rbi+ZoU8XbkdwMV7PEDA0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6449
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241028_220441_227581_68267AF1 
X-CRM114-Status: UNSURE (   7.22  )
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

T24gMTAvMjgvMjQgMTg6NDksIEd1aXhpbiBMaXUgd3JvdGU6DQo+IE1ha2UgbnZtZXRfd3Egdmlz
aWJsZSBpbiBzeXNmcywgYWxsb3dpbmcgZm9yIHR1bmluZyB0aGUgaXQncyBhdHRyDQo+IHRocm91
Z2ggc3lzZnMuDQo+DQo+IFNpZ25lZC1vZmYtYnk6IEd1aXhpbiBMaXU8a2FuaWVAbGludXguYWxp
YmFiYS5jb20+DQo+IC0tLQ0KDQpkbyB5b3UgaGFwcGVuZWQgaGF2ZSBhIHVzZWNhc2UgZm9yIHRo
aXM/DQoNCi1jaw0KDQoNCg==

