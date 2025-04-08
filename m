Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CAD2C36010
	for <linux-nvme@archiver.kernel.org>; Tue,  8 Apr 2025 21:10:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Cc:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=XqoNabV2rpY0mROU0Cxdz1yQ5GXyJWXAscGZoS1mk+s=; b=pXtfl87eFny+iht08JxkM17wNj
	iCXpk7w3CeoQu7omkTm6uiYiJPAdzyAf95NpfYpn0c7q3jznzC9m3u2iqceNEGip/ECqbbwybCTE3
	p+unia+HpfSE4yUw4mU57tvNmYrmRmSxOGemDr+Vw6YcQ/fpn4YJTx7f47ALAg0ugLEeAwYyczP7P
	8F2qkfrK3pqGfE1EdB/IO6xUoYNPbKDMaLljcgjNzeMLyzIfQMAPbdJL4L1i5svYT0Wm+ECxgBh8I
	ksSGILsGMQW2zRm/nnMKPsYjyMgyjlVhwnct0ZmHmQ6HdoT5fgTFk5jUpWnE0Aw1tJLV/PtGp4Qvt
	hbXje9cA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u2GCy-00000005PgF-0yce;
	Tue, 08 Apr 2025 21:10:12 +0000
Received: from mail-sn1nam02on20617.outbound.protection.outlook.com ([2a01:111:f403:2406::617] helo=NAM02-SN1-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u2GBF-00000005PS7-1VjR
	for linux-nvme@lists.infradead.org;
	Tue, 08 Apr 2025 21:08:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Lc4czZLBRtbAp2U0Y/VH+aOzy6woIRMz0nXEDR/vQzE8dDnCL5Fj6p3XJMQWbOwamgq6MiGKu5F2cMAl12NsXTwV10KbXe9QXQuEBV4CwmMIUMOpBnNPbwHsOCGZL9OL3bRCfY/kCDqB2EEnbS1UWXsjXd/qfKfGIMjgenvIyPdjTBRMxj9KxQVTFi54B8ETeCodXmQno8KKcd1nSUHl+Dy/74s2Yo4dV88cPiZFYsuQNefGw+c2Ji/zq67BK5+dSpXVWM3iLaly+KCQuKB65AMG0oaUSnKbqFYiUpblEftTWyuBHuZL+nTTxv/Juuu0Oqj4m1Zu/QLU1VgC9mhgeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XqoNabV2rpY0mROU0Cxdz1yQ5GXyJWXAscGZoS1mk+s=;
 b=FrplyZDZeXYwhIenfruwCUDPcZ87rJUGPwdGDwv2wl0QxoRNCAGr8wUmEkGjsV3w6sF+pl65zGILadjXaQMylbTSSyjj0bBivqLO19C8+oiuOm1ev+5epLzilcQM1fhCp9x9K780nGWJupdE0s1bRwWH1ToOD6ep2nJoekjjxuliLFfU0oMO6LVO9Sg3rA9bYWEfrI1wmW7/XDloqUQ2wFE039u3i/qxGJK8GoRB/3Bud7LzIdKPGKyM7BIFMQwQcqHovV3QTCYTn+x4kDTWPy6Ibx5mnbWMhEmt7GKXG4L4p64WfK7bm2v9zLYbG4JGdILPm66j8+ooe+Xs+mc9TA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XqoNabV2rpY0mROU0Cxdz1yQ5GXyJWXAscGZoS1mk+s=;
 b=bW9B63MDssRmKmGW7IwQehn5zLGDrGtIMD/hkOh0IqTRBDK3vt2rf6d1gEjYjtz+g+tDvAXrduUIizfhkGatPYmVoYfuLYC7RNWh5O++0pQIl+EnxZp+PcUpNcHEdQiDQ0j4CT9fyABkn4PgRDdj/8DrCnHYoVAXHWAFjmTl1MUIzLJ3bOI7dFx2LRCu6ML3UtovsQ1KvLFWKWATzIheHGW1w8iNUAVPcu2lkSSZZl5cFXhebEAmGR6DtN71R4dBSFGc+5hFQK1io9dOK7w2Hcg+LA7Lv75dVs1377iZnJb/i8NLph2YEIgNJnaa22Qsymc4CB5GaydVc1H3OZIC5g==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by MW4PR12MB7144.namprd12.prod.outlook.com (2603:10b6:303:21b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.31; Tue, 8 Apr
 2025 21:08:18 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b%5]) with mapi id 15.20.8606.033; Tue, 8 Apr 2025
 21:08:18 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: "alan.adamson@oracle.com" <alan.adamson@oracle.com>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: Issue with AWUPF when using multiple controllers in a subsystem
Thread-Topic: Issue with AWUPF when using multiple controllers in a subsystem
Thread-Index: AQHbpbL7Y6xDvP39E0WZWwk4rCeLz7OaSUyA
Date: Tue, 8 Apr 2025 21:08:18 +0000
Message-ID: <90792c66-d0ca-401d-b171-57faea2c2cab@nvidia.com>
References: <4a2e4561-9311-40c9-aa65-87e7a2e5b041@oracle.com>
In-Reply-To: <4a2e4561-9311-40c9-aa65-87e7a2e5b041@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|MW4PR12MB7144:EE_
x-ms-office365-filtering-correlation-id: e95a9968-5291-4eda-8a4c-08dd76e17c66
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|10070799003|366016|7053199007|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?Y0dobjNtNVB3V2o1VVVvSXBsNWkvVmg1aXoxYnBEN1JsbnAyR1JCMDlIVXJj?=
 =?utf-8?B?bU1WZU16cU1VSDdhQzdmek5SbUM4UC9wZVl3NTBhNWhPQWJPSCtwN05laTBB?=
 =?utf-8?B?UUdrdjBWSHJTb0lWV3E0Y1plRWZ0UnZOcUoxKzVLYmhvTHd1N0NyOXZmbStS?=
 =?utf-8?B?V1ZHZFhtUWZYY2VCT3RDblg1YjhkOU5SeFgxNmNpZzNLZHJHR0VkQkJOUU9t?=
 =?utf-8?B?QzNvQ0xjK1ZXZ1NtQ09JUFJwbzlTR3pjdkw4U1FWcU9TcGtnUmUyajh5RGN6?=
 =?utf-8?B?MDZZeW8ya3JZNmhxVnBHYndKZ0FPbVhnY0pjTURaOGt5SzBIcUpKZ1ZVSUlV?=
 =?utf-8?B?WXNMN3NKRWNGN3hacHJUZ3hINmNVMTBZdjhBVndCSXU1NDRzSFNTOHM5R1VO?=
 =?utf-8?B?SER5SW9nUFJjZGE4MlRyTTh6R2lldDhZUm93NForeWJ1ZEZkSDFKenV4alJ1?=
 =?utf-8?B?cUg4di93SWhoTm9URjQ1Z1RZMXNaRktTckQ1c2hvNEtLYVhxOGlYcGZ2djM1?=
 =?utf-8?B?bnBFUDVIMWxKWllyNHhncGVHN1JCZnR6ME51NDl6d3ZHMnoybXFld0V5Ykoy?=
 =?utf-8?B?d3daSndEcGVCemswb0tudnAwcGFiWThYN25uNitmSzdmVlFjNTNxTlNMQlBk?=
 =?utf-8?B?S3V5czN3TjZvRVNyenY5a05pN1hUWldtelkxUHA3cnpPL1ZPbDN4dHdNWGVH?=
 =?utf-8?B?aEQ1VlExUjZoNis4aEUwVm44cnNFa0gzcFBHNUQwVGNpUWtCTGVycUJwQjhq?=
 =?utf-8?B?MmFHM25SdG91ai9zZ2pmT0hKTXcvUTBLbzRieG1PRlQyUk1aTXRydWlEM0Yx?=
 =?utf-8?B?VklwWVJEMCtPV0hTcVJkcUQ3L0V5dWtJUVR5dk00aWowUTMrY2FNR2dOUVhF?=
 =?utf-8?B?S1BSTjNtSnBuME8yUHB1VDAyaVZTOFdpQXlJUHVvQWdNb25WK1o2bm1uR2Fw?=
 =?utf-8?B?aWUvaVBYZk1iVWVVSHZ1cFROY1JrVWV2cm0rU1ZqTGc3c1JQU1Q5ck8zdDlT?=
 =?utf-8?B?dkZMMnMzak1iSmxzZmpvbWp3SE9SMVUza0VBdXJDMll4Q0JZY2VvUWdHVjVx?=
 =?utf-8?B?ME5RVEQ0eDFFVXNDbmphbm9aZEI2aUV3ZHhlZ0Ixd3VyYWdhWWkwc2lCcmpm?=
 =?utf-8?B?VlJLTzZueXlVM0FDcFBMaDh4NHJFNXZCYklnbDF5SVB2QjVDU2t1aUlLYkM3?=
 =?utf-8?B?OTBKSTdLL0t5aUcwcGpEbzY3SkovdC9TSy9yZlUwWWltY3htTlVwOVNYMWJj?=
 =?utf-8?B?ZUlaS0RXdlFoNENVT244NlIyMkFaQklOd2RuNmJaZWh5cW5qWHZMTEtGWkpn?=
 =?utf-8?B?Z1dnMDBOdzZpaytnbmFoYzd3aU9lY3hoeW5KNmU5YnBQUy9NdjkveG93b0xj?=
 =?utf-8?B?ZVR4S2NFc3hjYythSUdMbHVxa0hIZUNPTXJybVZMb0t2TmF3UkR1QU54Rnl4?=
 =?utf-8?B?VWhIVE91d0h6YWMxQTYwbENlWjE5anBCUkVJMmZmTE9MelZ3WTNndEZlcGtj?=
 =?utf-8?B?OFMvVWZHcHZKeExKRm0reGM3UWh6b08ybk5aUUpIV25wUWlWeURIdHNsSFVt?=
 =?utf-8?B?dlZmcVU4MG91K2NyYTF6NTFHVmU2Q1I4S0M2cmJ3UU9nTkYyYUlKVGpPRGxi?=
 =?utf-8?B?QnN3VUJyU0tnNERGQkY2by9CcmZaMzlKbEFLZ08zZGRpU0lKdmxReVA0RGll?=
 =?utf-8?B?K0xrd09hMFU2aVhGUzRaU2lzb1hJRzcrb05haW5RZUptY2FVZEVrZFZmZTQw?=
 =?utf-8?B?bXN3UjRJeWxSL3BPRFBnVGswcHZ5V2c0aU9SeUlsQk4xd1VQZFFmMk8wM09u?=
 =?utf-8?B?cHBmcVZuRC9QVW9ndTdaZVUxM0ROd3RmNTRnYUFyTHJNbWMvWmppdHVIQm9s?=
 =?utf-8?B?MWtJcjNHWFllUlBPQU1aTFAvei9WTGdXbHA0U0E5Ris5TE4wVUxnZjdURUZu?=
 =?utf-8?Q?aRwkHIQqpvR3MXO4q0NdS9FXoIaQuVjV?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(10070799003)(366016)(7053199007)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aE1KWXh3Mzg5QW5qZTdTTDhVeFRSMUkrbncrdHBWb3Z0K2YydnhQOTFrRUdo?=
 =?utf-8?B?end2dWZUbUZvU2FXQzVPa3Y0NEdBYWtwNlNLVTBqVW5neEl1TkFMaFdJaW5L?=
 =?utf-8?B?QUVmWlBvR1N3Vi9jSUtyc1BWMFJIOTV6Q0NYbms1eE1ydlhuQkpVbWVQenNN?=
 =?utf-8?B?ZFpJaXd2R0xaYUgyZHFFQ2ZRSTFjZlZRZEdlaG92bVp4MUp5dEhaZ2xxVHJu?=
 =?utf-8?B?MlRQVWpFM04rRFF6WjRvRE9Qa1ZIUUd5bVh6dUJQd01MSDkrYmlHK2hoR2h2?=
 =?utf-8?B?d3RBR1p4Z2VOLy9Rcjk2S2tEWXhrdDRiTXNzcjRwR1pjWXVJS0planJWc1NB?=
 =?utf-8?B?Z1dxbzlDSHowZ1pUZVEyWFlmZjk0bXV6THZwTkRhQ2toWkJWWDMzZUUyemgx?=
 =?utf-8?B?Z2I0YmxDWG51alZVTlF1anVDN3hHTmJiWVhWWUw3UitQejdOd09TTE95RnRr?=
 =?utf-8?B?d1R5VHk2NHBHa2ZPdUIydVNtcmNjWURGRnZ2S2d4VmMvR3N0akpraVZ4N0FR?=
 =?utf-8?B?QXZ5enVqVUhQczlFV0Rmd1BKZjVQOGhFdzZJdnpIUk85SFNpYUE4aGJXRlA3?=
 =?utf-8?B?cWJvbG9kckpUV1MxOFd0KzBwQlBzenlodWNOOEp3TURPS2NEeEk2cG1BRlBJ?=
 =?utf-8?B?NEtEaEdUQ0U2NHllSGxMbHNiTHp4NThKNlZIMVQzNFBtM2VUSnRpZnpiUjVQ?=
 =?utf-8?B?dTVyMmxCWlVmVkkzVDVGYjZ1ZUZvZEpoWFNjdTEwV2g3aThweURzMStWUTF6?=
 =?utf-8?B?OU4vM1AvcWFDOFVTOHRuZzJ5UngyVHJtbU5oS3FLUTVpNHF0Q1hOSGp5bUpw?=
 =?utf-8?B?cHB6MTVaZFRueTFoUW82OWJqcVVZYmV5c0dqYzhzMTUrMDhNL0FUeExvdVR5?=
 =?utf-8?B?TFJ6djNZak5ROWlteUh5MnJGRjAwTCtyYlU5L1dDdmVHOHJZR0c0N1pabFAw?=
 =?utf-8?B?SXZ0T0svU1JyZENIM0UwTVFMSDdVOUV1OEczWjVrbHF2eVh0dmFLM2tUNjZF?=
 =?utf-8?B?SWNtNkVzaE9iZ2VSVzdzNk5sdFFRaVBiYjc2QTNxSkdFUGtqWllyV2NwdVIv?=
 =?utf-8?B?dzJMVlJPdHg4VDZ5OHhIMm96aER3L0JzZHpYOFBTeG5KL3pBdE0xZGlzMGRW?=
 =?utf-8?B?Ynk3SlVPT0VGRHVzUE9EN2hWZTdoZXRmTjd3eEorVXFEZzlQUjd3L3FOWnV6?=
 =?utf-8?B?dG9UVmhXSThERjd0Z2pLUUs1bFdUK0pWYmVtOWNZWk9XTEpTTlNHMnFJSWtT?=
 =?utf-8?B?akI3RW9hT1hrLzIvRndSNWMwSWZqTVFiNmR3bEFFQS9nVGc1VVRpbVhwSzZx?=
 =?utf-8?B?YlVRQVVSbmVEWW0zNk44bUs3bEIvajJvdUJnU1VHeG9VRzN1R3FPeEdlcXRn?=
 =?utf-8?B?MFhTcHNQczBrMmJPSDhZU0w5dHVCS04vRDIrbXlJSUNYS1NuamJLVEpoTHdS?=
 =?utf-8?B?ZThvSWplYVFjT2hLdlhvNi9MV1lIb2xuUG5adjNmdlpZaVFNa1BVTnpOd2p3?=
 =?utf-8?B?UTBQRnVJT084b0txSk5vdDVWc1RRUmxtcDhoalM3U3F4TVNHY1Jqd1ArcENZ?=
 =?utf-8?B?OExteUU2Z0oxTFcvY3owcEVuU1RCWGtWdFgybXM1NVlybkYrQVdhdmZBUHlj?=
 =?utf-8?B?S3kvN1M1czYvNEZ5ekFQOWdncldSUWZOMDdBb09ra25KUXMveURPMVV3Q3J5?=
 =?utf-8?B?U01UQzhLZlJUKzJ0bWF3Y1pCNjRwaGFJMWJPRzEwOUhnb0YwYmpJWGMweUZG?=
 =?utf-8?B?M2JVcnh0RFlTbTh2K2xqL0wzNzZZcTBjOU1wVlVEelROSGppdWh3eGlwM1Vn?=
 =?utf-8?B?V1ozYm50ODc5Z2FaN2Zwdm9heGdRanlRb25kMFpKenVIVm5pL3YvKzh2d0pv?=
 =?utf-8?B?MTZJeDFZWmFJQ1lYaXR5VFh6c0psOWJJdm15L0gvUHNjVmE4SzEzQVEvd0U2?=
 =?utf-8?B?MHZ3U01qWEF0bTBXTXgydFU2L3I3a1Vmb0RGd1Zub2kxN2FveFZzYzJzMVpR?=
 =?utf-8?B?OG80S0pMS2xyLzhaRkhuc1hrRWlBQnVtc1pNb1Y5UUpTcGgxZk0xeHUxWFli?=
 =?utf-8?B?NmFFaEo3TUxidFY0c3V1MDJRZzVhbnpMR2ZkRkNiWTZjNU1sNldMdW9GdHY2?=
 =?utf-8?B?UEkxTHJWVFFTSy9KRkJpQVZjT1hRSGo5VW0xUzBMdWtlM0NhS3MrMmdGbUts?=
 =?utf-8?Q?STQ2R4iJ7AOHaOT862hXo1WAyeIxVS/gslXXPVy7KA0b?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A5188A9AEFABFD4AB8906178C23D0D4D@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9404.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e95a9968-5291-4eda-8a4c-08dd76e17c66
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Apr 2025 21:08:18.2890
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LYzlld3vR1iXaJMt6dUdkiv4B0lPRprTBYxToecG8zWsrsAh6qWK6WCoWfKC96whLSmPZq0G+jfEALNs1y6bMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7144
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250408_140825_398046_3D9BD63B 
X-CRM114-Status: GOOD (  11.32  )
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

T24gNC80LzI1IDE1OjQyLCBhbGFuLmFkYW1zb25Ab3JhY2xlLmNvbSB3cm90ZToNCj4gV2hpbGUg
dGVzdGluZyBhdG9taWMgd3JpdGUgcGFyYW1ldGVycyB3aXRoIG11bHRpcGxlIGNvbnRyb2xsZXJz
IHdpdGhpbiANCj4gYSBzdWJzeXN0ZW0sIEkgZm91bmQgYW4gaXNzdWU6DQo+DQo+IFFFTVUtTlZN
RSBDb25maWd1YXJ0aW9uDQo+ID09PT09PT09PT09PT09PT09DQo+IC1kZXZpY2UgbnZtZS1zdWJz
eXMsaWQ9c3Vic3lzMCBcDQo+IC1kZXZpY2UgDQo+IG52bWUsc2VyaWFsPWRlYWRiZWVmLGlkPW52
bWUwLHN1YnN5cz1zdWJzeXMwLGF0b21pYy5kbj1vZmYsYXRvbWljLmF3dW49MzEsYXRvbWljLmF3
dXBmPTE1IA0KPiBcDQo+IC1kZXZpY2UgDQo+IG52bWUsc2VyaWFsPWRlYWRiZWVmLGlkPW52bWUx
LHN1YnN5cz1zdWJzeXMwLGF0b21pYy5kbj1vZmYsYXRvbWljLmF3dW49MTI3LGF0b21pYy5hd3Vw
Zj02MyANCj4gXA0KPiAtZHJpdmUgaWQ9bnMxLGZpbGU9L2Rldi9udWxsYjMsaWY9bm9uZSBcDQo+
IC1kcml2ZSBpZD1uczIsZmlsZT0vZGV2L251bGxiMixpZj1ub25lIFwNCj4gLWRldmljZSBudm1l
LW5zLGRyaXZlPW5zMSxidXM9bnZtZTAsbnNpZD0xLHNoYXJlZD1mYWxzZSBcDQo+IC1kZXZpY2Ug
bnZtZS1ucyxkcml2ZT1uczIsYnVzPW52bWUxLG5zaWQ9MixzaGFyZWQ9ZmFsc2UgXA0KPg0KPiBb
cm9vdEBsb2NhbGhvc3Qgfl0jIG52bWUgaWQtY3RybCAvZGV2L252bWUxbjIgfCBncmVwIGF3dXBm
DQo+IGF3dXBmwqDCoMKgwqAgOiA2Mw0KPiBbcm9vdEBsb2NhbGhvc3Qgfl0jIGNhdCAvc3lzL2Js
b2NrL252bWUxbjIvcXVldWUvYXRvbWljX3dyaXRlX21heF9ieXRlcw0KPiAzMjc2OA0KPiBbcm9v
dEBsb2NhbGhvc3Qgfl0jIG52bWUgaWQtY3RybCAvZGV2L252bWUxbjEgfCBncmVwIGF3dXBmDQo+
IGF3dXBmwqDCoMKgwqAgOiAxNQ0KPiBbcm9vdEBsb2NhbGhvc3Qgfl0jIGNhdCAvc3lzL2Jsb2Nr
L252bWUxbjEvcXVldWUvYXRvbWljX3dyaXRlX21heF9ieXRlcw0KPiAzMjc2OA0KPiBbcm9vdEBs
b2NhbGhvc3Qgfl0jDQo+DQo+IFdoZW4gZHVtcGluZyB0aGUgYXd1cGYgdmFsdWUgd2l0aCBudm1l
LWNsaSwgdGhlIHZhbHVlcyBtYXRjaCB3aGF0IHdhcyANCj4gc2V0dXAgaW4gcWVtdSwgYnV0IHdo
ZW4gZWFjaCBkZXZpY2VzIGF0b21pYyBxdWV1ZSBsaW1pdHMgd2FzIA0KPiBkaXNwbGF5ZWQsIGl0
IGRpZG4ndCBtYXRjaCBpdHMgYXd1cGYuIEN1cnJlbnRseSB0aGUgYXd1cGYgaXMgc2F2ZWQgaW4g
DQo+IHRoZSBudm1lX3N1YnN5c3RlbSwgYnV0IHRoZSBhd3VwZiBpcyBzcGVjaWZpYyB0byB0aGUg
Y29udHJvbGxlciwgbm90IA0KPiB0aGUgc3Vic3lzdGVtLiBUd28gY29udHJvbGxlcnMgaW4gYSBz
dWJzeXN0ZW0gY2FuIGhhdmUgZGlmZmVyZW50IA0KPiBhdG9taWMgcGFyYW1ldGVycy4NCj4NCj4g
VGhlIGNvbW1pdCA4MWFkYjg2MzM0OTEgKCJudm1lOiBzZXQgcGh5c2ljYWwgYmxvY2sgc2l6ZSBh
bmQgb3B0aW1hbCANCj4gSS9PIHNpemUiKSBhZGRlZCBzdWJzeXMtPmF3dXBmLg0KPg0KPiBJIHRo
aW5rIHRoZSBhd3VwZiBiZWxvbmdzIGluIHRoZSBudm1lX2N0cmwgc3RydWN0dXJlLiANCg0KQVdV
UEYgaXMgYSBwYXJ0IG9mIElkZW50aWZ5IGNvbnRyb2xsZXIgZGF0YSBzdHJ1Y3R1cmUgc28gSWRl
YWxseQ0KaXQgc2hvdWxkIGJlIHBhcnQgb2YgdGhlIGNvbnRyb2xsZXIgYXR0cmlidXRlLg0KDQog
RnJvbSBOVk0gRXhwcmVzc8KuIEJhc2UgU3BlY2lmaWNhdGlvbiwgUmV2aXNpb24gMi4yLCBNYXJj
aCAxMXRoLA0KMjAyNSBQYWdlwqAzMTkgOi0NCg0KRmlndXJlIDMxMzogSWRlbnRpZnkg4oCTIElk
ZW50aWZ5IENvbnRyb2xsZXIgRGF0YSBTdHJ1Y3R1cmUsDQpJL08gQ29tbWFuZCBTZXQgSW5kZXBl
bmRlbnQNCg0KNTI5OjUyOA0KDQpBdG9taWMgV3JpdGUgVW5pdCBQb3dlciBGYWlsIChBV1VQRik6
IFRoaXMgZmllbGQgaXMgc3BlY2lmaWMNCnRvIG5hbWVzcGFjZXMgdGhhdCBhcmUgYXNzb2NpYXRl
ZCB3aXRoIGNvbW1hbmQgc2V0cyB0aGF0DQpzcGVjaWZ5IGxvZ2ljYWwgYmxvY2tzIChpLmUuLCBD
b21tYW5kIFNldCBJZGVudGlmaWVyIDBoIG9yIDJoKSwNCmFuZCBzaGFsbCBiZSBjbGVhcmVkIHRv
IDBoIGZvciBuYW1lc3BhY2VzIHRoYXQgYXJlIG5vdCBhc3NvY2lhdGVkDQp3aXRoIGNvbW1hbmQg
c2V0cyB0aGF0IHNwZWNpZnkgbG9naWNhbCBibG9ja3MuIFJlZmVyIHRvIHRoZQ0KYXBwbGljYWJs
ZSBJL08gQ29tbWFuZCBTZXQgc3BlY2lmaWNhdGlvbiAoZS5nLiwgdGhlIEF0b21pYyBPcGVyYXRp
b24NCnNlY3Rpb24gb2YgdGhlIE5WTSBDb21tYW5kIFNldCBTcGVjaWZpY2F0aW9uKS4NCg0KLWNr
DQoNCg0K

