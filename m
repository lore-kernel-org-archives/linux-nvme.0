Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F178CEFCE2
	for <linux-nvme@archiver.kernel.org>; Tue,  6 Jan 2026 18:28:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5b7Mh0ziB+NgvRW6SZbmi4NXtWqj2Zowtn/wfptrcMw=; b=SI+OYrD0Fzug3Xd7k+EWEAsEmw
	M3TCZqemg3UQ8/XlPq8m1T5brAP709nIw6PceZk9gKy+CfRWYkOATRvYTUMHU8MUJOI+VCJMGNXzJ
	fz58ieRyb8YecOMSZRRoAISZ600RzSQKBXhfep7qIka+ILKwbxMok6tZrtJaq7eNMwIidi2xpjlgh
	0YqRlYG+xFzc8p7VS6iKGYf+NRrwHhD7fsfnBY8/H8jTuCObePw55dZxkSUtnEyTkS/ibyD7k0r6a
	ob4C3wjq8YOHT2RSPw+ihVVkMIjYLR64plZ2PKdnMe8WSEdhxj3G8dSULXQrf0fbFyGkI0IKXfmNq
	02Sg+KnQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vdBn6-0000000DfyT-3Z7o;
	Tue, 06 Jan 2026 18:28:24 +0000
Received: from mail-eastus2azon11010014.outbound.protection.outlook.com ([52.101.56.14] helo=BN1PR04CU002.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vdBn3-0000000DfxK-2Z2l
	for linux-nvme@lists.infradead.org;
	Tue, 06 Jan 2026 18:28:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O0kLkMz0hHrV7fHMqw8F+tZ83L2yhHofOct//6hAu6Jxod8J24n4HmplS6V0t0Recx641la7ZGHmnyXgmdBhOPXWOPHLI0r3Jcx6ZIshWoGZhvMvmNNQUOnHMpznm4PWJGAQZpbnDs0oQUuoNvBByodsevPg+nhwIdfGtpPc2GFLZ+8Y2ljh/ICSdjqRJNP/25tZeBNCYmJ+CPAoD4h7UfIjPO/eVEPiItp+4G2rliF7NxRFu6l6hqBCTuIteVQd3+4CZDj1U4A+tWVxCsn2WFReAdZMcDdoumQuOrIF0ip2lJa35G1ADanXTJvPiNp3ppNrHT4ZgVJzjfKXrIfSlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5b7Mh0ziB+NgvRW6SZbmi4NXtWqj2Zowtn/wfptrcMw=;
 b=zLLgvbZ5i+FVc76CyugMFakHo9ecE4trQ7ppBZAWjCPgzt2qRGolkkwTKBuhKRiAK1j/p45QNQRhS20XwZhYu7oqbtl6L82KsGrlZ5FTg07iRdg6CyWbPcqCD6L0sPPn2iUCtle+0+XoeD6rLi8WMImd6J+elNkfEdh//MF61NfAGrkMvPUSSAHCOAkNX9mTfRsrqrx/fegxcmnuEccEHZJ3aUc/ce642CTq0yEEOVk1pxMEMfBFiQfrIZthlmDBmfC1Y0ihHU/ayQT/VPPOrqwdCh1hyTU+nsLGlZIzJlCazpNG5T5w9zvWHgXsQjh8ulhuseikFGmT3SLg+HakTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5b7Mh0ziB+NgvRW6SZbmi4NXtWqj2Zowtn/wfptrcMw=;
 b=ksuf/AkyJTEmNAOC5FYuzBL3judYmBOi7jCdTpb+9oHYhJvSJmk6dD1a/Ax+NtaJgVd3ZhLhVb3L91VgdkJSikMX8pwPDM57UQk+ZMEi03raIWxm/fJJv2JntGCACCZZiVFYY/EyaVNu54a0CyiyZAmedO6ZI8GS5YlDJp2zEv0ygHbjRCzE8Ukc5F7Jk4sCmazhmjPHUaU41Y7lVirhxQ5xXGa+LzxEZnbWw5yx9zQrKIDMwrOOnJk0OS54Hz4YFigyZXCY5LCR1uW0PveuCzm/MfpDIIw/btbv6R6ysrBXOgbA9+41ZQ2c3u7+SNRDPMbzn1ee9bxr2QH0q3jqHg==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by DM4PR12MB7696.namprd12.prod.outlook.com (2603:10b6:8:100::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Tue, 6 Jan
 2026 18:28:15 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b%5]) with mapi id 15.20.9478.004; Tue, 6 Jan 2026
 18:28:15 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Chaitanya Kulkarni <ckulkarnilinux@gmail.com>,
	"nareshgottumukkala83@gmail.com" <nareshgottumukkala83@gmail.com>,
	"justin.tee@broadcom.com" <justin.tee@broadcom.com>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"paul.ely@broadcom.com" <paul.ely@broadcom.com>
CC: "kbusch@kernel.org" <kbusch@kernel.org>, "axboe@kernel.dk"
	<axboe@kernel.dk>, "hch@lst.de" <hch@lst.de>, "sagi@grimberg.me"
	<sagi@grimberg.me>, "yi.zhang@redhat.com" <yi.zhang@redhat.com>
Subject: Re: [BUG FIX PATCH COMPILE TESTED ONLY] nvme-fc: release admin tagset
 if init fails
Thread-Topic: [BUG FIX PATCH COMPILE TESTED ONLY] nvme-fc: release admin
 tagset if init fails
Thread-Index: AQHccUZLpkx5lBpkQkGyCBztz3Rx8bVFkeMA
Date: Tue, 6 Jan 2026 18:28:15 +0000
Message-ID: <ccf8741c-35f0-49bc-90dd-314085f1dbb0@nvidia.com>
References: <20251220001842.6027-1-ckulkarnilinux@gmail.com>
In-Reply-To: <20251220001842.6027-1-ckulkarnilinux@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|DM4PR12MB7696:EE_
x-ms-office365-filtering-correlation-id: b4b62138-db28-43ec-4219-08de4d515b61
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|376014|10070799003|1800799024|366016|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?bXZCT1ZuYUx5YzlFS0s5bFRJbzhrbU9MQW9RdjRHSGx4eGNDVTIrZEZIWUZZ?=
 =?utf-8?B?empPeDY0dk1UZk9SQWNWcnJ2ZmFDdXRZNjBPUVdscTBDM2JySmxQSE9rb25H?=
 =?utf-8?B?eWdXT01XZ2wvdjlxUlAwL283bVpRVHByYWJSZWluS21Za2NubXpVQnRTVU1M?=
 =?utf-8?B?aUg3cnpYNmUvVGNTNnBITDNIbVpEZUN6RkZnczdNdkt6aElZTVJaeFp0UjRU?=
 =?utf-8?B?TGJaNlhzT3ozanpxdmYyRXYxSmxKUjM4azl4T1JWU09oc1J2dk42bUE4anN6?=
 =?utf-8?B?MVpMVGNlN3JWWVBucDZselgzdVI2ZWRJL0VWUEw3blVBOUp1NmRxeFRuT0wy?=
 =?utf-8?B?ZEJ1VDJUQnlCUVpDNUFpaHBEaGlLN0h0YjQ3VFltK1lhOHhiekk5U3FNL0ty?=
 =?utf-8?B?Q3dValh4SC91bmx1M3hzN2NSdEx4N1ZIOXB4SlRlM0Y2MmJxUzUxbHNzMnB2?=
 =?utf-8?B?MUUweWJzUnNTNXBaRUN4M3F0cndOOVlRQW5LUS9LODNpdTBXTitBRWlCZVNm?=
 =?utf-8?B?aTVRVUdrRFdlNDBXV0xnVWFPTXpRblZtMTVEb29uMjd4ZThkazNnSlVsY2RY?=
 =?utf-8?B?REgzTWFQUGYzcVZqaHpxbzlIRzN0djBnajBYNm1Va0ZVTEMxSGtLQjZJUE0w?=
 =?utf-8?B?MCtrMkVnUDJUZHJMR29DeTA0dVRTdmdIYTkxMjVpdE9PelgrSGdvb0lIa2hK?=
 =?utf-8?B?VDFTNFByWE5JWktjTFQ0bVZoQlBERHkwcnlWLzNwQnFRN0tjMktLR3BCQU5H?=
 =?utf-8?B?QndHY243NnFaeGlPYk9RUmUybHBwcDFvclB3Y3RodWtXMG1uaGF1L2VXTXpT?=
 =?utf-8?B?bmQydUlXMlVXN1VzelR1RTlTNzY3ZDhvc0ZxelVIMkFhKytyZG1FZExINnFI?=
 =?utf-8?B?cXB5ZDQ0YjlWNTVZOC9mUzVKTW9hVkZJVzQxS0tUcXdTMjNPc0lSaDBUUWQ5?=
 =?utf-8?B?dnBnd2dmYjJDU05vbjRmQm1veEJZM0tkRVlTQ0h3TXVHSW1nc2xmTDd5L0Rq?=
 =?utf-8?B?Vkx1aExYME9VMEVsbUZycStsWmYxQ3BtTFRtYStxZmpwdUt0MlFLblp1ZDBz?=
 =?utf-8?B?TUdNZnVadW5ZdHA1UWdQY0xaODI1QnBLY3UrTGFBaGtncWprUVJxVGJnenlI?=
 =?utf-8?B?bC9yQ0VpR2l0TXRpQndFVEwwMzk3dUwzU3RMQjdQYmtmVkN1WmlXYjhMQy9w?=
 =?utf-8?B?dGFSL1plZlhWaXFySHBUdGY2OWVYWUQ0V2lXTGU4YTVtbHZjS2lGRXJxc01p?=
 =?utf-8?B?MC91LzUwQTZielFlRU9xY25oOHJ1SDJQeGE0dzVOOUQxekxnTlVqZ2txcGxn?=
 =?utf-8?B?enkzY1lIWXltMXRPcUxQMVl2VDRLNVAvdFZEUjFGcEgzVERvZmthU0pMRkFH?=
 =?utf-8?B?ckxOR3pmWE42M1FwWFEycG82aXZIL0hmY2lmbVRqVEdxTVBReEV6Y3Qyc0ZF?=
 =?utf-8?B?UEtaN2QxcnRaazVzajRqbWZESzNMZU9zZmF6NE5jZzhlZXNJRC9wVXkwTWJH?=
 =?utf-8?B?ZHljeDF0bGc4M0M2M3lycFdqOEY5eGFnL0tLRGtEd2NOVlR2N3VKTjR4M0Vv?=
 =?utf-8?B?TDR4WHBtUlBIanhnQm1BazRFNndtRGFlS1ZlN1hTbnNFRGJCU3pMbjZkRGcz?=
 =?utf-8?B?VEVHVU9oNHVGMGp4akZEOUxMK281Y05tV3AvTFQ3QlJGamFaUzlqS1l4TDlC?=
 =?utf-8?B?Y3hMQVNlN0RYeEFrbHcvd2lEK2daL01QVHNVNkZSWkNITmRnb2pycWZScDB4?=
 =?utf-8?B?VmpJTlZQYWxkcDZhRi9GU25UL0ZnYmtSelhNdTlqdWxEa0d3azJ3Zm1ITmxY?=
 =?utf-8?B?UkgrR3N5NG1HZFBhZjlYcDZxaWV0NkFQODkzNVdxN2IyWGVrQ0U5QXdvbkpZ?=
 =?utf-8?B?N0ZGazVvMzROckg1YjB4TzQ2LzQ4QWRrTllUN09JWjhkV3BwUG9XTFNhLzd5?=
 =?utf-8?B?TUJvN2hBSHliNWc2U1NFajNCOXkwY2hxRXY1ZDJGSW1YYjg4MjlZV0xvWENL?=
 =?utf-8?B?aHh5cStwQkxQRUhndHZDOFRIdGNHMWJrK0o4RlVQVisxNktJVm95MTlwQXcx?=
 =?utf-8?Q?vEL+QY?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(10070799003)(1800799024)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RnUxTHJQTUNXMzIxRDlLOUNLWUNaMEVQalRlMHlKYlJsMWd2QkpYM2ZqRWRJ?=
 =?utf-8?B?MTZ0YUNhMmVoVG0xaEdxT1ZsNzV5QVMvcWFvRjI5ZWhaczRBTHQrRkZuRDVo?=
 =?utf-8?B?eFhTWXV0Tlk3WlF0VzJJMlhzandiRzY0bTc3enJlL1h5VGxCR0ZuTng0VEVN?=
 =?utf-8?B?TEMvRTJDYjJ1S0VMR3o2UkdGYzBYRGwxR1RZbGNCdldkalFJQXlJeFlaZ2p5?=
 =?utf-8?B?V205RVEyTjlvRXJIejMrMjJRN2hTaVZacnp5d2hNRjN3aUxXcks5RHlpd09I?=
 =?utf-8?B?ZVZDYlM1M3VFdlJ0SlhSTGJrQlFnUkFjYWh4SndUdGE4VWR6bWYweXlMY3NF?=
 =?utf-8?B?UjNUemNrYjZ3UjM0RGovSFRLd1ZXdE42NlU2Ykh2WjlnaTNCL1dFTWhBZHA1?=
 =?utf-8?B?bWlFMExxMGxQVlh5OXk0dEFBKzFsdlRydmdJdjdoVWlwcExxaXIrWU1WaC9k?=
 =?utf-8?B?QVNnSkhSblFLUlUvRDN6WlY3MmlJMGo2UkRycUhSUjBCMFYrWFlSK0Y0WU0w?=
 =?utf-8?B?enVhRUxldjlaVGdCVTd3SnlNYWVCQUMzY1hmc1g0andJandkVWF5U0REejFJ?=
 =?utf-8?B?eWdUSTVrRS91cHRGM2IzYk0rY2N5Q212Qy9rWjZiWFVEUlZHcm53U01UNEd1?=
 =?utf-8?B?UFF0ZXVQM0c3bDg5dXE4WEFlZE9hRXZpSW9hazBqbzlkVTZRajNvbHJxekk4?=
 =?utf-8?B?MnJhTGl0OHlEMmFNRm83K1FXV21RVGk5ZHRrQkdNeVVSMFpWVzgwTFlUc3Vu?=
 =?utf-8?B?KzJTalMvOVB3UnpIZVEwVFJlUmJjelQvdk1ZOUxnRWoxcEc5VUtHazl1cjFk?=
 =?utf-8?B?OUIrRUJVU0xJaENkV3lNc3AvbnBMUFdSUldXTjExVnk4aUZXeHJYYStZcmpz?=
 =?utf-8?B?VWlMcU5BRDMzLzM4K3hwWXMydHZHREtmdVA5MXZ0N1ByTmZ3N3hLdmhVQUc5?=
 =?utf-8?B?THB4cFluUnVPKzYvMFBEUmprdzNUT2ljYUxhdHRwd0lSMlFmZjBnT1JuaGhW?=
 =?utf-8?B?NklpWmFSOEVIRDRqMEV6WHgwY3U1K2g2TlpndGo0NlBmMldIQUZhQUxjaGNn?=
 =?utf-8?B?b1BqUHppWWVyV282NVp2YklTZVRpR0VGWGQ2K3V5NVVBS0lWdDRBUk9QTnhv?=
 =?utf-8?B?c1lOTFg3RjUyZDhXdS95aXlVRG1XRUYydC9LVEd0N2tVdCs4NlRuaFZLQnZM?=
 =?utf-8?B?WkJTR01UYkpwOGNhMVJocWJzSmpyd0syLzNxMGgxQmtGc05reGtCMXcwZVNR?=
 =?utf-8?B?Y3ZVWGR2UDdKNmFDd2I3UE9nMkVGWVRYbklQK0lyREJTc0xmOXkyM21xT0xL?=
 =?utf-8?B?UzE0WUVXcWx0a2hoTVdLZ1FGUy9EU0xoVmEyTlVmaUdjMUNYMGtrNTNIWkgz?=
 =?utf-8?B?ZUI0OURtQ01LV012VGZSQUJmeG93WFgyd2xDSU9SVEY0ODZweWNYNXc2Skxj?=
 =?utf-8?B?SS91RkIvdVJYcDBFaDNNMTNBZEJ2bnhCak1zZzRXbTlFUHppU1dUN2YzMHo3?=
 =?utf-8?B?TVdMYnRoMVl2S3RJM2M1Y2lublRqcVpPYk5kRGM2N29xWG1sNFpuYmxCVjJY?=
 =?utf-8?B?aW1kWFpJbjNuOWVySmdGRmhJc2tOQmpBQUNicitpRTJVbTM4Qm9JYmFRczhu?=
 =?utf-8?B?bnIraGczQzhIM3JhS3hYeHE4WjRITTFJWDdqdS9mSHRHVmpubG9Kd2dxZlgy?=
 =?utf-8?B?VHRobjVQM1dvMnFFTkZMdXFGMXVQY2M2V2p1N1hvVlRPNlJ0eS8yU3BXWFRM?=
 =?utf-8?B?OXZ2cS9zcDJzZy9oRUMwYVR3d1VGS0t5QVgvSFRXVnJGUDgwK1E2aWg5Wk45?=
 =?utf-8?B?VWtqc3lZSXhlMjZ2VmptU1A3Y0l6eStzMXhzZXhJLyt0cGdJZHRCLzc2WGY2?=
 =?utf-8?B?bjhTbWQ0UFJqOXRzSmR5OTRyamdkNmhTazRGc2l6TEhER1JvTjVOMC9mcHdk?=
 =?utf-8?B?ZXZmNFF6MW5TT3M2N0NmMFEyWVRTSmdUR0NTOTFwN0JOWDQvRUJuQmlpNFUx?=
 =?utf-8?B?N3VYTlZpd1RFOUVjQWRkM0pnWjMwc1JHd0tMc2dHZnRTcHlTMlZJcWhod09C?=
 =?utf-8?B?MTY0S2lWOWNNb1VVdjlDcHZBUGVjRklIdjJESTQwc2NzREpyUkdvaitnNllv?=
 =?utf-8?B?RmZKazJRRXpiZ3p6NWJEeTREVXRhWjg4a1hEakQ5UkRzeW9iYnBHbWJxd1RH?=
 =?utf-8?B?R3Z6ZUNrVWM3YjM5dUsralRJY2ttOXIxNUtSOUpyRm1rbWRuUWl0MEM1bFlC?=
 =?utf-8?B?d1IvZEIwa1RsZW1Cdlp5eWtVeENFNXJhZkFBd3RFb1JXRHZIZUpjbnAwZHZy?=
 =?utf-8?B?R05DRWVrRUs4Zkg1bmI0K3Z1RUUrR0M1MmtHSlFqWUh2UmJQNDFNd2VUd0RO?=
 =?utf-8?Q?24Hx+4V3Ni5IDbvlfulpJq9lknRS21xM2PUy+JqgwDPS8?=
x-ms-exchange-antispam-messagedata-1: T6RFYs2Imm/l4A==
Content-Type: text/plain; charset="utf-8"
Content-ID: <F6F0D6B259DB3046A3EC1B9AE168FAC5@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9404.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4b62138-db28-43ec-4219-08de4d515b61
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jan 2026 18:28:15.3492
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Y3xes11YHhk8psVOYXa2cvjUx72NtcMERjy8PMBcoH3GYaUwq9K4As0F2iElPAA47QNicwyAcCjHMwf7+p6z2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7696
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260106_102821_662072_26CACB53 
X-CRM114-Status: UNSURE (   9.65  )
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

T24gMTIvMTkvMjUgMTY6MTgsIENoYWl0YW55YSBLdWxrYXJuaSB3cm90ZToNCj4gbnZtZV9mYWJy
aWNzIGNyZWF0ZXMgYW4gTlZNZS9GQyBjb250cm9sbGVyIGluIGZvbGxvd2luZyBwYXRoOg0KPg0K
PiAgICAgIG52bWZfZGV2X3dyaXRlKCkNCj4gICAgICAgIC0+IG52bWZfY3JlYXRlX2N0cmwoKQ0K
PiAgICAgICAgICAtPiBudm1lX2ZjX2NyZWF0ZV9jdHJsKCkNCj4gICAgICAgICAgICAtPiBudm1l
X2ZjX2luaXRfY3RybCgpDQo+DQo+IG52bWVfZmNfaW5pdF9jdHJsKCkgYWxsb2NhdGVzIHRoZSBh
ZG1pbiBibGstbXEgcmVzb3VyY2VzIHJpZ2h0IGFmdGVyDQo+IG52bWVfYWRkX2N0cmwoKSBzdWNj
ZWVkcy4gIElmIGFueSBvZiB0aGUgc3Vic2VxdWVudCBzdGVwcyBmYWlsIChjaGFuZ2luZw0KPiB0
aGUgY29udHJvbGxlciBzdGF0ZSwgc2NoZWR1bGluZyBjb25uZWN0IHdvcmssIGV0Yy4pLCB3ZSBq
dW1wIHRvIHRoZQ0KPiBmYWlsX2N0cmwgcGF0aCwgd2hpY2ggdGVhcnMgZG93biB0aGUgY29udHJv
bGxlciByZWZlcmVuY2VzIGJ1dCBuZXZlcg0KPiBmcmVlcyB0aGUgYWRtaW4gcXVldWUvdGFnIHNl
dC4gIFRoZSBsZWFrZWQgYmxrLW1xIGFsbG9jYXRpb25zIG1hdGNoIHRoZQ0KPiBrbWVtbGVhayBy
ZXBvcnQgc2VlbiBkdXJpbmcgYmxrdGVzdHMgbnZtZS9mYy4NCj4NCj4gQ2hlY2sgY3RybC0+Y3Ry
bC5hZG1pbl90YWdzZXQgaW4gdGhlIGZhaWxfY3RybCBwYXRoIGFuZCBjYWxsDQo+IG52bWVfcmVt
b3ZlX2FkbWluX3RhZ19zZXQoKSB3aGVuIGl0IGlzIHNldCBzbyB0aGF0IGFsbCBhZG1pbiBxdWV1
ZQ0KPiBhbGxvY2F0aW9ucyBhcmUgcmVjbGFpbWVkIHdoZW5ldmVyIGNvbnRyb2xsZXIgc2V0dXAg
YWJvcnRzLg0KPg0KPiBSZXBvcnRlZC1ieTogWWkgWmhhbmcgPHlpLnpoYW5nQHJlZGhhdC5jb20+
DQo+IFNpZ25lZC1vZmYtYnk6IENoYWl0YW55YSBLdWxrYXJuaSA8Y2t1bGthcm5pbGludXhAZ21h
aWwuY29tPg0KPiAtLS0NCg0KR2VudGxlIHBpbmcgb24gdGhpcyBiZWZvcmUgaXQgZ2V0cyBsb3N0
IC4uLg0KDQotY2sNCg0KDQo=

