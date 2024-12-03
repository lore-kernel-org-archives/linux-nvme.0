Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2CD8E6C5FF
	for <linux-nvme@archiver.kernel.org>; Tue,  3 Dec 2024 04:59:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jgBVwjdYt9UhKe4ufXYvmUEn+sKqOTCNaO+0iXZaokA=; b=pAANxYRZOpZwtdVQnSXGqczNWc
	drQEjr08d+I9zYS2CF+EwXbTX0luUCQq2l4FBxz6BqNySpAf1RuFY+OL6NRatsoQyNqoeVqIIfR+i
	4fmx8UsbE4AowtDOPmE8KFcDZnFH3ASyRrAz6AJGZuXlC2gsS6yDMDqpgUdNDA8nKqj0d2Hwa9A0P
	+1y9Ym5wIOY4Qrke8UvPD5tntoxqB0zhn4Wgv7HT8/JO2LjDxe2lgjJUlzs7d0kXHL+kypwjA+rsX
	wJ5ErsY/UlPWp3PuyekAu0mnMOAHBjOFbTL9bVc72/zbX+3PQVhDIvkl5VxlKD5IqSyhXWJ4ACx60
	JXL8CyMw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tIL0c-00000008GXH-04hl;
	Tue, 03 Dec 2024 04:59:38 +0000
Received: from mail-dm6nam12on20611.outbound.protection.outlook.com ([2a01:111:f403:2417::611] helo=NAM12-DM6-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tIL0Z-00000008GWd-2sC4
	for linux-nvme@lists.infradead.org;
	Tue, 03 Dec 2024 04:59:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dyK5JU5kNDKv6zmi/eSagbXNWmtaTWosmgnWUWhNX+HA/4m1h/QiWHtoVkhjGaqAssIpxTuvQtWmEYUq8QyE4mONB0OOS6Dcl9EfL7Ie/js46H6o1BLkw6urBBHXezIzLVLYQ5YUp/WYVfoA6EtblsRCghhNtO/f4HTkzww7KpCpunMAEpqa3xcLblyhFKgIBAQoJlhiVsJaJTLAa6SZtuXNXS9DCLd96yBg0d8H4nmyHy8bu3rqkTfVXg+UPRGfZnHG7KI92WnBHHcfyfEUWOSmS62ccGNg8o1uCb8Cfk+rgQgo2omGP4n8zFat5FzdjVxI9kCqW7iEnktUf9mOmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jgBVwjdYt9UhKe4ufXYvmUEn+sKqOTCNaO+0iXZaokA=;
 b=wBX14L8TO/RXCXCGI4Y2liqRvejnYjorSkvILTHVfA4BcfJGFs/1Ykq5+H0yscDdjdy9f0sKOt/43Y0gTivRDYXoo6RtNQ9kUqii7z7Rs9U2RaeEDo3BWyOdpBEG5XS/VjapjT7lIToA+rBau/RQXhi9HhP6BEgV9r1xEyCiXgwRLF8ka/Xs7Fu17CepJ5IhyAHcgzg3dwW9SeZeZGYmCzFqKY00ZhOKK+wkHwLdLoNyADLaflKAFyWwTJ8Z+Ldw8loES64LhwxNy7dzZHCrTwJyjFjWW3wjuP697CN5dIXW6Pe0XufSSoz8JqtgDixJGgAFyQnxWWVBCGkxF/uHUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jgBVwjdYt9UhKe4ufXYvmUEn+sKqOTCNaO+0iXZaokA=;
 b=Rkb87Kfx1l04MEKkWmcIZrQxW8ojvPvDZAbKvfJ9uMJB4UfI27cwDqaieQVMu/SU3k7gCrQlvym9vZ75EDmVMjjBkwWMDialr55qbbpdf/CNcIq7otACWf0/WMzOSTOs1sUzYzZQXIpjAvGd1Hb+OvpX2JHt08nX1SBKaus6OwLe/QcmCNZPV1Hrh8fSVFd0abxzq6TyKK2bNwPbYVQA9EfLMPN55E0QT1EaSUxPMesgKRu4xc3ZBDd+xfqmr2nOpbVy5OattebB0rA/gb1FPhKELdT70nh2qpeHkz1TRroO9+rRLgR0m8+kOtEL1QQ0oDTdKq4CJp14/FDTpGawrg==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by IA1PR12MB8553.namprd12.prod.outlook.com (2603:10b6:208:44e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.18; Tue, 3 Dec
 2024 04:59:30 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b%5]) with mapi id 15.20.8207.017; Tue, 3 Dec 2024
 04:59:30 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
CC: Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH blktests 6/7] test/nvme: add test for basic ANA support
Thread-Topic: [PATCH blktests 6/7] test/nvme: add test for basic ANA support
Thread-Index: AQHbQmJYDMIkzhIH/02gd3dfBmrS/bLT+3+A
Date: Tue, 3 Dec 2024 04:59:30 +0000
Message-ID: <10e05841-f88b-4b35-a545-e7f2104fd2a9@nvidia.com>
References: <20241129132617.400429-1-shinichiro.kawasaki@wdc.com>
 <20241129132617.400429-7-shinichiro.kawasaki@wdc.com>
In-Reply-To: <20241129132617.400429-7-shinichiro.kawasaki@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|IA1PR12MB8553:EE_
x-ms-office365-filtering-correlation-id: efce1bc6-e32d-45de-dd8b-08dd13574545
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|10070799003|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?ZmhMUThDbXRsMnQrL2JnTjdnMGpRRHhOalhsZytJd3ZtdkZJcG9KdFhnWmVJ?=
 =?utf-8?B?Y1lEMXJiQWZsczJhM1h6RjZwVkM0RHFrSWNDMnIwcVRhRjdiMG5QRitVQmU0?=
 =?utf-8?B?ckp1ejlYcDhYUmpHT3Y0Nlh6czFvSHVkV3k5ZWlKb0ZySUxYRjF0QUJrTjhy?=
 =?utf-8?B?VzEzN2ExTERqaHdPWUROQVFzbDdqWUJUTDJRT2tIaXpSZUNkZ0JVWEpDNDNo?=
 =?utf-8?B?TnlYeUgvMVF4KzJZbkU5Y3JsWUd1WWdGOHd3V1Fnd0pONXpBdVR4dHp0a0hU?=
 =?utf-8?B?bXhDcW42QkV2dGhJM0VQbzFQSmJSTWtudDd0QmpKVnBpUDF0NjVTNy8zVW1n?=
 =?utf-8?B?d3JXbnM3RVFTa2FzaE90WkdUKzZpS3V1ekJrZjAzbXBLazZKdGZ0d2VNSlpq?=
 =?utf-8?B?TDJlcHdDdk1kVkN3eXZBbk5TZ2J1WVNyNUw5cjNTQ3JaVWtWVjB1MjhoTm05?=
 =?utf-8?B?WGRzbnZzbTZEYWxZUzBrVHE0dUJrUVA3OHdGNS9zRi9aYUdtT20vSFpzUUFp?=
 =?utf-8?B?SWJ2eXNETnhEZEZubE54SkdRRFg3MGREWGh0UkNpRkc5RHhMQjN1VXNjUnNS?=
 =?utf-8?B?ZnF0Nkw5a01Md2gvSU9zdWNzelZEdnE5TzU0MzRiT21vY3hmSDdnYjRXbVBI?=
 =?utf-8?B?QnlCVjJacUhMaUU4TzFpdVdQa2UyNjBUWnhsbGw4elFIWTEwc2kxMFBVR3pN?=
 =?utf-8?B?RC9MNVA5WjVIUjBQWHZqdWhnQ3g0WGI4WWRhTnc5UGQyeHNMdXk4czc2ckZG?=
 =?utf-8?B?RTJ4RlpJL3ByVWFha1B4cFVUMzdqQXZXNGdpbm1lc25XRnBpbkIyQTMzZVZt?=
 =?utf-8?B?L21qdWJNaVNtOTkzSEVFeEpxalJQNHUzRmtGcWRTUGp0ajlQYkc5cGJ2ZjBo?=
 =?utf-8?B?cUxyZjJacXVVYTRtUUppOFk0RDVUZDZoZVB1cGpNOVF2dVdFcW9yYW5CZWNF?=
 =?utf-8?B?Tm5ocVdkMWdSSk9UbjcxS0VtQXFyWE5QNXNsbDdjSDZKWmo0eXNaWk42T0hN?=
 =?utf-8?B?RmhUSGJONVBnN1RpMlJaVVBxMlBWSzZCWVZNT2hJV2xaTVlNUFJ3cGJ3VHY4?=
 =?utf-8?B?U21GT3VtTVNhMlN2OG9RNUxUR3NDZ0VnWmMwNldlMEhrRFpoM2NoOTlEaDFJ?=
 =?utf-8?B?RXdYMGRodkVHb0RlZFdTdDQyQ3ljUkp0VFVUL2s5TkNNV2hOUS8ra1ZickRG?=
 =?utf-8?B?NlQycVVrMERma3NCOU9CNFFVTDQxS0tuSzI1R3dORXhaNjBLVFdYc2xyZUdm?=
 =?utf-8?B?TEZaUEMzQVZaOUhwZ0VEams4ODVZQk41YnhmUTdmNkNLdVNDYzFTZHhrQ3pI?=
 =?utf-8?B?azJTL0hUV2VyOHIvRzluMkROdFMrOGpWTlpGNjFPUkh3VjNXd3FvUWcyQVhZ?=
 =?utf-8?B?Zktuemk4QllzYzQ3NkNpbCswTElDUEd4UGxYeTlxcE4yUUt4TzhXY05BUlZD?=
 =?utf-8?B?MFF5L2g5aGRFc05Idmg1Vy9nYU91L3ZNNGtUZURSeXg0YW9YZ24xaDRRenRu?=
 =?utf-8?B?b2NNLzJaRzY2ZEpEaVhIakFjNVIwNXFmUmVWbEJrRk5KRXVZemlHK3FqdWVn?=
 =?utf-8?B?czBjbmc5eXNaeExaY0hBWjd3T1FLRGdsZTY0ZEJXNE9lVEpSczZFYWkxZFZ3?=
 =?utf-8?B?WGlVWFA5eUNDVmxTeGlwTDR1aXY0SnpiUVF0aHM2MVN6Vk5KemdFbW9KeXR0?=
 =?utf-8?B?U2dnb01HRGx0aEFtREM4RlZwSUhSazJRTzRwMjI3bjQ4MWZwcmwxRDZycGt6?=
 =?utf-8?B?ZHhZa3MrSGNBMkdhNENWcU4wMklHUEhpMEJMS0M4NCtLcnJqT3dCR3B0bGR2?=
 =?utf-8?B?L2FzbS9nZGZ0ZEhGWVo2Nm5DeS8rSWNPWkxtTkozTk8xUzFKbk5pdXRCTExU?=
 =?utf-8?B?YWUrWHdCb0JCWjdnb2NLMFhKb0JObWFpNG5VWGV3blVwamc9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(10070799003)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QUtkMGFmdHBUS25ST2ZUTTZHclRRSDNYY2V6L1FZWjZwa2hPYnZNWG80bmNC?=
 =?utf-8?B?cDVxRW54bk9lRW53WHU4MjFuZVUrTFlqTENPNE1YTm1SOFVWS3FEcndpZlJJ?=
 =?utf-8?B?MDY3Q2htK2lwMXNSbklYMDRkYXJ4WHVDSXNkV1Avd213RktXOUF5bENNODFQ?=
 =?utf-8?B?Ti9mV1l0aUFzaUhiUy9MTDFUZng3QkpDOEw5S2xmdE5tamM2dWVPaWtuV0Rt?=
 =?utf-8?B?SDUyMlpvV3B3ekxNRUlTblVtLzV5TWdDcXQ0cFpsazQwS29rdEJIeEtoTDVI?=
 =?utf-8?B?ek1HM0IvQnJTbzR5MktNblJoVG1XMEpIREtSWWJSc0xqekY3OVRISmlodXpx?=
 =?utf-8?B?dm1jejhHTG90T1ZCUDlzOWY3UkRqd3FOaVA0SVEwZ21LaHR4N2pncEI1RWJq?=
 =?utf-8?B?TVFRNHJMclh4bzA1bHJmZDRJZ1Urb0VsdTJIOXBHUWI3TlJHaGxLVldVVG92?=
 =?utf-8?B?S0haTFpTS1UveTc0Q3EwbTArR1JuaU5mQUJNTDRObmQ0S3BjTy9rZ0ZNWGQv?=
 =?utf-8?B?T1NnbFZYM2JFbTdGdzRSbGhaZldhbE9Rd1diaGxHRXRkdHZBdnRWYXpEM0x4?=
 =?utf-8?B?TFhhRmtZd21DcDRyb0RsOG1BS1ZSWU9XZ0xXOXdpZ0hqUEhUZXJIZjU3OW90?=
 =?utf-8?B?YUd3QUNFd0RPOXArRWpadVhTajdPWER0eVY3SnZ0cDEySnpHcnpXVGs5NTRn?=
 =?utf-8?B?Q2k2Um9KMjUyRnExaThTdmhsWm1RVXRtMTkxektuWnVtdHJRWjNNL3FhdElE?=
 =?utf-8?B?QUdTK3A1OFRlK0tXZ2puY3BGT1RFbTh2VVJEQ1p0NVBoQ3hWeEczYXprVFEv?=
 =?utf-8?B?NWFpdmVrdHFrWndYVzhPcVVoQjNNbkE2c1JPSHhNMkVjTXpiQnQvYlFkemtx?=
 =?utf-8?B?K3ZsRXhwdGZ2VHV1VjQyaUNTUnlKYU1zc1F6MDZrSEhZNjJoaXBsb3RPYWs5?=
 =?utf-8?B?WWhJalJFalcvR3NuQk42NGordkdtaktjeHROY0txb2p0K3R0bWd4NnJuUktB?=
 =?utf-8?B?RVJLYkJrS0JJY1Z2aE5oT3psejZud29seGp1OEdxNnpQeG5KaXVVekVuNEtu?=
 =?utf-8?B?TzBmdHZGSFlYamdqQ2VUV0FucWFCUVFHYkF5M3BWTXJvWE9hcDVkSStmWkI2?=
 =?utf-8?B?STQ0Y0JSeUtXQXhpYkV3cFpVUzc4OFhPbEozTlVSM3pOamlsWm5qZ3pMLzVv?=
 =?utf-8?B?UHVFZkFLVFJ1bUNUaVVuRWo1Y1RwbWFaa3RpWGtzNkJuWC9WS1FHSTNEaHBu?=
 =?utf-8?B?aEszK1JKMW0zSmg2N1NmNC9LY3NiSUhjRkE5eXIwYUVLTzNsVEU4NzJJVHJu?=
 =?utf-8?B?UENRY29YanRkUnV2dUFyc08xQU5PSGxSVVNWZmpaRjZOa3dFcTBna3RnKzMw?=
 =?utf-8?B?NG01ejl2UHRnd1FycnZvcU5ZdTVFRzVLRmtBdEFjVTBUektjUUwrTktBcDRn?=
 =?utf-8?B?VXdyYzdaZE8vNU5xZTNJRWRWNkpGcmFiS3picW1aaG5EVEoxejF0aEFiUjlQ?=
 =?utf-8?B?dVMxZnJHQ2hubndoTy9NKzlac3hGTHY5RVdzZTR0WURjOEdyenBOd0JOVjRz?=
 =?utf-8?B?bkdFaWN2SlZVZ2pVbzZtbEFvSWV1eitFQ1lVblY5R2JrSjZWWVhTQUJQTW15?=
 =?utf-8?B?NTh6MEhLWHI3ZG5icThMdnlxeGo2SStiQkJObjBUdGxyRXlGcFhsNHg2ZFgz?=
 =?utf-8?B?UmJHYloyL0FWckJpa0k4eEs2Y3pLZGtxK0NCYTdLRzRuVHpDaGZyUlA4eGRo?=
 =?utf-8?B?SytvOFNZQ25Gd0hKUmNkNWx2TlBoa2VyYSt6VS8rYTY3OVlmSXhSOUJOOFdT?=
 =?utf-8?B?Slp0Q0lWTGdYZnRveXVyUkxvMHA0ZFdFdVZ5VDB0WUhWUjhFajhnaGh2V1Jt?=
 =?utf-8?B?WkcyYld0S3IxQW1nL1dBTkxVTUF4b0JpK1NxN250bkl5MkdvbHIwSVdMalFy?=
 =?utf-8?B?Vm5VVWRGY3RCTUp5NHk3SFpjUkkrTGRpNGZ0SVVQYldMNE14RDdEYUhmY2p1?=
 =?utf-8?B?cW9HUkFYZU9XZUlzVFBMTjc0YVNWWGlPTC82NXgwUHM5TmRkUjNlVUtDYXFn?=
 =?utf-8?B?bXRoM3JiTEZoVkgxS0VoaGxaUE5uMTljSUZjL09pdzhBamFFY3kycVhmL2VO?=
 =?utf-8?B?Q3kzSVNGTEF5dmd0M3UzYTFXUmhLN3BhbFg0Nk93TFZEY1VCUHlXMEVaaVVB?=
 =?utf-8?Q?XZhTQLB30qyAUET4vwyivWKp9VUuhOJpNO7IBm4uZC7d?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2B5F7079B8C24043B83FB89E80C2BA8E@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9404.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: efce1bc6-e32d-45de-dd8b-08dd13574545
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Dec 2024 04:59:30.1459
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BOC3yJC9+ARGdPUuaa/CBcX+/s0nN73BFnSdg92v3woWThJdwvqDiW9pIHRyHusJgBKfQelTUNUsmoj9Enq00A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8553
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241202_205935_723893_145FD0AC 
X-CRM114-Status: UNSURE (   8.61  )
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

T24gMTEvMjkvMjQgMDU6MjYsIFNoaW4naWNoaXJvIEthd2FzYWtpIHdyb3RlOg0KPiBGcm9tOiBI
YW5uZXMgUmVpbmVja2U8aGFyZUBzdXNlLmRlPg0KPg0KPiBBZGQgYSB0ZXN0IGZvciBiYXNpYyBB
TkEgc3VwcG9ydCBieSBjcmVhdGluZyA0IHBhdGhzLCBydW4gYSBmaW8NCj4gcHJvY2VzcyB0byBn
ZW5lcmF0ZSBsb2FkLCBhbmQgdGhlbiBzd2l0Y2ggcG9ydCBzdGF0ZXMgdG8gY2hlY2sNCj4gaWYg
SS9PIGNvbnRpbnVlcyB1bmludGVycnVwdGVkLg0KPg0KPiBTaWduZWQtb2ZmLWJ5OiBIYW5uZXMg
UmVpbmVja2U8aGFyZUBzdXNlLmRlPg0KPiBbU2hpbidpY2hpcm86IHJlbnVtYmVyZWQgdGhlIHRl
c3QgY2FzZSBmcm9tIDA1NCB0byAwNTVdDQo+IFtTaGluJ2ljaGlybzogZml4ZWQgYSBmaW8gb3B0
aW9uIHR5cG9dDQo+IFNpZ25lZC1vZmYtYnk6IFNoaW4naWNoaXJvIEthd2FzYWtpPHNoaW5pY2hp
cm8ua2F3YXNha2lAd2RjLmNvbT4NCg0KTG9va3MgZ29vZC4NCg0KUmV2aWV3ZWQtYnk6IENoYWl0
YW55YSBLdWxrYXJuaSA8a2NoQG52aWRpYS5jb20+DQoNCi1jaw0KDQoNCg==

