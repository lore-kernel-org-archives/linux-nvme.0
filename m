Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F238C369C2
	for <linux-nvme@archiver.kernel.org>; Tue, 22 Apr 2025 06:32:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+brEPhjggVlHSw9iUUP6LwFaZyiblQpFO/8JC46MdIA=; b=xgdz3rcRFLcx0NAGfYKeRNcUct
	+WtGdIH6MeL1xXHuwNRf2gUoImrUSXUK5G2kf9/zPDgVCE7c7i5OXqoB7/mobcOx/0cqRUGYWPeVD
	gjI+rJfN63E5Begyjhg+/aoJuXyDXFxjRfhh7T7opPnQvpM0OsyQQ9cP2BQAIxyWvPFV5aUcnHjnT
	eJX5fypE0Wa3bDZdRjhHm4oOxuQo2mzB4ohq3sW+6mSd+wOFnwAaQqg3YfvQ4mgduiQXKxbJqmJL6
	WdnnN4E4lasYzQTyG/wa9Fulds3Ed8xvIP9y6r0KP6lqvFzKUMSanpqy4kOqCM4waEuhb4GQaNB/R
	1IBT4gGQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u77At-00000005yFw-3gin;
	Tue, 22 Apr 2025 06:32:07 +0000
Received: from mail-dm6nam11on20626.outbound.protection.outlook.com ([2a01:111:f403:2415::626] helo=NAM11-DM6-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u77Ar-00000005yEm-3giO
	for linux-nvme@lists.infradead.org;
	Tue, 22 Apr 2025 06:32:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vSaYCwhlzH1smayWoxqFeFFBUssPJ4ahZuQYOPqvSD2wvKmf5zP5q+ifkmM9E9xPadNt+2kxduJ4G07cHfvPAd1l2Ulr61rOHvcPjgTMgbWYXd3ZpJuQ9+OHROft04x6/vtcYSRrh5bePYpE9Vol5ipa2CLMQqlT4IUBJtyK9EuWbEYJAylxXNsl5ip2j6GLp59dPWJ76nE86rEJMYhXv+rMRGJj/MHol5RrYm5L7MSKHmd1n0OyHBi9sqw4P6Vlen3AI9/EQvrYraaOYoyir84KLP/uUHFphSwlSrTxDNnJ4X7iTGs0kqBiO+c48XCZH/4u2NP/Gr4ssXPbKJifVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+brEPhjggVlHSw9iUUP6LwFaZyiblQpFO/8JC46MdIA=;
 b=vB/uqQh7MfeQoiY3fbv0b3/tVp33GXYfGF9asPBqvbEBQ1JxcA0V9PteYHlLk3u/zSlUxV15RCmJEpCBmOn7/SnQF8alqoMbwGliHwo3HpjAjsNSlXbCgmg8dE9Q13/8lhaih3U4+Oa6HmDmKuhP29PSSWUzIAtcDz04NuaqpQdagZYZRRL72chpvU1Bzm1rbALd1sm6uq6/WoUOs2aPEH/gBXD2nN3k3XMJt1pwdcgyDu7ill5GMEOlfvFkUmzynb7MtsQicpWiX5P32DQnwcc1YvVfdXp9l2fCL4ih1N5AvYN35aNNHsbrRMYmk3Xwj2TXhaoHz4yfS1BID2qusQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+brEPhjggVlHSw9iUUP6LwFaZyiblQpFO/8JC46MdIA=;
 b=pS9gq6OmauM5advaImTgRvI8RlksNo5mM57FXx8T0yofzEbMsznZv6TT4r7PjZPcEsJVAayXYVi0d6DJnnyRvsdtpv8nDCzx27LvX02puSb4bgdIJFqQv6guSj4DqSf3xpjIWKbJh7Le+8gaZCcJ2XI4DlARfJgntA3tXT7Uo96c7PtwRc+8QR7+B62kUBGk1wFvW45fOTh9QTy+KUN+MGRZVBMUBwZLX8pbPllm+ePILnyXCOB8sd9jfWIVOM1ZVmZ+N3GzqzaoucY7uxhYl/CjbJdCD8729cICV77yY2hnpWQj4rv7/awUQYhmrbhwC478RpSxzJPAaoIHeeHCaw==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by BL3PR12MB6473.namprd12.prod.outlook.com (2603:10b6:208:3b9::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.36; Tue, 22 Apr
 2025 06:32:00 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b%5]) with mapi id 15.20.8632.025; Tue, 22 Apr 2025
 06:32:00 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Richard Weinberger <richard@nod.at>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"a.hindborg@kernel.org" <a.hindborg@kernel.org>, "leitao@debian.org"
	<leitao@debian.org>, Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	"sagi@grimberg.me" <sagi@grimberg.me>, "hch@lst.de" <hch@lst.de>,
	"upstream+nvme@sigma-star.at" <upstream+nvme@sigma-star.at>
Subject: Re: [PATCH 2/2] nvmet: Restrict in-band config files to root
Thread-Topic: [PATCH 2/2] nvmet: Restrict in-band config files to root
Thread-Index: AQHbseGwX6lV7hRy6Uer+3Jf40d9JLOvPLyA
Date: Tue, 22 Apr 2025 06:32:00 +0000
Message-ID: <cb7dc726-f12b-4cd7-a121-aebc9c510771@nvidia.com>
References: <20250420104726.2963750-1-richard@nod.at>
 <20250420104726.2963750-2-richard@nod.at>
In-Reply-To: <20250420104726.2963750-2-richard@nod.at>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|BL3PR12MB6473:EE_
x-ms-office365-filtering-correlation-id: f7b1ee97-d5c5-4135-d6ff-08dd81676315
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|10070799003|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?VzJ4bStuczBUdGJnWnR2WU1ZQ1E0S2JEWVAvWkFpblpXeDZ2YVFuYnVYSXU2?=
 =?utf-8?B?NGh6ZjI4NUZkREhvVEFYQis1blhEY0dpcU9udHhrM3NQOCtNQTY2SmVCK0Rk?=
 =?utf-8?B?bzZOMTRXd3ZhOWlMbVc2L2d0S21nNnRKMFV2U3FxOXl1Q2VFY0gwZURHYTlw?=
 =?utf-8?B?MUFLcjcybWRmWk5uaSt4QnRtZjZ1azVYRFo1MXJVM09aWmxnOUZDN282clpJ?=
 =?utf-8?B?dG1XZ3gvVFpGblN2a1VnektxRHd0R2ZRNERiTUlIQXdqZ0RPQlJtMVJzNWtX?=
 =?utf-8?B?bjhrWjhtdmp5RUN4aDJzRU96d2dHeWFSRXN2RnNRdjJTRlZCRFYzQTZaNm8w?=
 =?utf-8?B?cUZyVGNsSWJiT29lVWJLeTJHYVFaeU1uRkgrQlpIQTlEOEMxY2tlOUF0NVRH?=
 =?utf-8?B?RTZHNWJ2MmxUNUlNUk90bnlINmcyTU1rOXRXYlcrc1hVcGVTbXI4a0V1cWpi?=
 =?utf-8?B?c1RvRjgzNjM1OTZJK0VuNFowWGFjV3d1RUxudEdpbnFaQUNmM2ZnQndPTk54?=
 =?utf-8?B?REx3UG9XWE4yMlAxdnRhWnh1UWdpZnRCVVhQTEhLRFppWm9uZCszZzVOdlpn?=
 =?utf-8?B?SE9jcjhxSnRtR1p0cnN5SytTTldYZXZ4U2Roc2p1TUx6L3FDSk1jQS9kd1Bm?=
 =?utf-8?B?K0VmVEZkTzdLRzEzNFg4eEdwQnhEZTFWS3NXVzNjMTBoUE0xYkxnTGdPTmts?=
 =?utf-8?B?RGVyL2lTVnNDUDF2UzZ3cS9tWVFtNUtuVEk2R2lvbTFjaTU3THFpTVk4SklL?=
 =?utf-8?B?eXMyME1qZTNBVTV6NlRyVldmNTRObjRZbEpIdWhKRDErUTFDRXBDSDJNLytZ?=
 =?utf-8?B?eXZsclp1bkluajFTOTlUa1R6dEJOdnVsTlYwUFV2RDVIUGF6RDd6dVpRVEZz?=
 =?utf-8?B?OUpVZkE2SVphak1salZ6WFpac1QxSU44NWRrbkdhb0dPSGJGRWVBNTJvTWRZ?=
 =?utf-8?B?SEJlZDFxbnU1VW9LckFKRXZHNDBVTWpCL2pXM1phRkoxYVN0VXoxRFd5K1Zm?=
 =?utf-8?B?SCtXUldXS2tuSng1MXhlZXRVb1p3N1QwRXo3TklIbnU0ZGY0bDdTVzFqOHhl?=
 =?utf-8?B?cmUva1ljZnNaOHkvWS9rMzRGK1Z3NkFwOGZLSlNsMGpZZjcyTmtrRDJ1cDFO?=
 =?utf-8?B?YlZWSzNWd1Jsemx1SE9rUmJzaVJZMUlJUkdhYzhRUktYTG03Q1NSUjVTcEFq?=
 =?utf-8?B?aHRmcWtoOHdrZGJTL1VTbWxLV0ZIUmJwek81bE1LRFhJMFBudUdWS3dYS3JT?=
 =?utf-8?B?d1crNE5tcGVZNElWVmVORW9pcHR6MU13K1RZNk9YdEEwdDgxamFMQVhHa0N3?=
 =?utf-8?B?K2JmbTFud1VYdE1ZMitmWFVJSHlRTVR1Ym5rWFJybG1GZW9xR3UxN1RTTmFs?=
 =?utf-8?B?OXhyajYvTzVtZUwxTldIdkdSdjBIT2tSWThib3RSL0NYRDByU1dZemI3c2tJ?=
 =?utf-8?B?US9lOE9jUk5EZlpXUDJRMUFHMEVNTU9BWExDUytMNWZ3VWNqQXpVazl5NkI3?=
 =?utf-8?B?QkdaRmFNM1ZPenpqdHNoV3pOUG5SN2VlcUN6Z2VYOExlZ0ZaWXNXYVgxQ0dG?=
 =?utf-8?B?bWxYMWdXQ2JrSXBybVFqQjIvUFhmUkF5bldVeEtVZU8zU3E5UjRrc0RpY2Nm?=
 =?utf-8?B?SHdFTmg5eG92bDdYc082Q01XdXRZS2dYQ1ZETEtPek9UTlZBLzgwcW1Malhl?=
 =?utf-8?B?Q3FUNmdMMy9paWVxaEZHWldhQThjTWNBc00zclRPQnc4VU52TVVnV3JDU0Ro?=
 =?utf-8?B?RFZQN21tMU9RV1JRSVVybXJZaFB6Slgvd1Bucyt2dlpLS3BRYk9FenFSVlNx?=
 =?utf-8?B?eTN5S1BDVFkrUW91aFN5ZDBPVzRVcEdzWUU2b2xGUXBvOGpLRkxkcVhBVEpC?=
 =?utf-8?B?RGIzRG82WjZqL3Q2Y08zWWVVc1RHLzVVczFULzZTWmoxa0dYT1owK3k4WVcy?=
 =?utf-8?B?SW40dUxSQmg2SzlaZnNGdjEyQ0lXZUVIS3RYKzNONit1QW1KVHZxWm9Memxh?=
 =?utf-8?B?YVhpcDJxQWtnPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(10070799003)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Um9MeWY0OG1rSGxEWktVY05yajhrNkFNdVdtTitxWm1RRW9kUUIwd2d6Nnpt?=
 =?utf-8?B?MlpxRDR3T25WN3h6TXI3VVo3NW1EMFRMMHNjY21EajgzWmlrSTdQQWVYc24w?=
 =?utf-8?B?aTA0cFdRL1J2VVdlaTBySEE2NXdhck9zS1lPYnlIRVNqVmQyZ0VlalBQa0tl?=
 =?utf-8?B?Q0pVUGs1RjJKZ1lUa3loR3lFOFlOYTlkYVZCUEY3Rkd2MVhjQkdZVXpldUhM?=
 =?utf-8?B?ZE50MndUUzdIblRmMzZkM3JNWURBUnM1THNsR245WXF6VHRxdGprVm5zVFR0?=
 =?utf-8?B?UExMRDloVkx0MTFvMVNYVTNZSmdTTERuWVJwZ2Ezc05ZSWVuTUo5ZnZzeVdK?=
 =?utf-8?B?cTE0b3hwWGNRdE4yRDhqNThTM1IrS1VvNm41OE9uR0tScEl3NjNyV29hU3gw?=
 =?utf-8?B?bjR2dklPcUNybGNoaGtVV3dsVi9MNTZjU0VYdDlTS1FPak5LYkU5cnhEN1E0?=
 =?utf-8?B?bjExRE1NSklrckg4VS9PbTlpU25UUmU5enAvSVRKR0VGYWNtTmZyYzluSzRZ?=
 =?utf-8?B?MlVjRXJxbjhkd1lZcUFSMnNjNzdJMStqdk5MOEsyTmNFV3lIREU1S3FWQklQ?=
 =?utf-8?B?ZElkUWhLZEVaUVg2Mm5CUCtXSFdVQ0xkem1Za2hKY1BVUG9USnc0cnQwNC9T?=
 =?utf-8?B?MWpSb2o4Z3hVVnlLZW42S1NqQzZiWFZpN2hxTi9PNnU2RklFb1BGemVHcEhr?=
 =?utf-8?B?b1NNQ2x1NmVYTnJOVnR0bkZoTkpidFhPN0g3dFBFV2R4cU5mYXpnbFkwU0F6?=
 =?utf-8?B?bW1RVCsxRTU3WHhkN0t1YXVUaFF1Wkd0N2R1cVhvbjh2NFg1TzFtWDloTHdj?=
 =?utf-8?B?L29xOXZCdXJaTFhpSDdpRlZOQ0psMkpMK2VPdThKVEZNSGtQdzlVMTQySTIx?=
 =?utf-8?B?Y0FRb3pyTWZFUmhzU3J2TXl2N0IybjBQaTFpbkFFdUtPdFJBNy91ZUIvdkY2?=
 =?utf-8?B?OEZzYXA3TUNzSnJ5dUh5a1BSdE5zTmlrcDRiZ1BXemZBVTNMbmM3WExtSm12?=
 =?utf-8?B?cnM5ZDQydk9TcWZKeE4yOHUyZ1QvNXppR21XYWpidVNLR0t3dWoyUXVIbnVR?=
 =?utf-8?B?MWg5djBKcXdUbi9XSUI5ZVhOeUtlbE12c0NTbkpJSUhza2gveE40Sm9PS3Rq?=
 =?utf-8?B?aVpybDQwMFh6YW9JNllFVWNMQTh6VGswbmY5cktHenlOR3RaOFhxTUlVa3ZE?=
 =?utf-8?B?YUQwK0Zzam1vUFoydlFBaHdDYzYyM215U2pYRTVXbHJ3Vm5KaEtidG1FSVdD?=
 =?utf-8?B?T2FTbHMwNnlFZmozQ3RTNEM2Rm85ZEFvWE0zajdtVjQ4czk3QlJEbVNjZkE5?=
 =?utf-8?B?L0NYNENTeVJCQVQzMW8vWW1HSnNiVkt3Q3NTdm9oM3ZtY2I3WTVDbVpaV0M1?=
 =?utf-8?B?S0x6dDlJNTR6VzEyTFE4bGw5dHJSVmVyOUt2bEVPVlBab3pJKzVzL01POVZM?=
 =?utf-8?B?enF4Q25FeDQ4dDljZnVHNlVOa2J3MVhpcGJFK3VhWFE5NTBxMkZqb0hHRkQ0?=
 =?utf-8?B?MmpYUjZlN3hWQ3pJOXZmUTVjejNtNlpGaE10YTdrVjJEeUlWOTB5VGlXM0x6?=
 =?utf-8?B?Z2p0b1dGcytNOThFdi9GQ1VXVEtac3FqMUZyaWM0TThHdFluTXBaZ05MK0N6?=
 =?utf-8?B?YjFCT2hCdUQ0WGtkL2JsdTZTOVg2anplNmpQY1I4UGRnT0tDZENUb010SDlU?=
 =?utf-8?B?b21nTGhYQk1SMU8vdGNzZjFJNWdXTXl4OWlFNStWNElaQ2daU2VGUElJazRn?=
 =?utf-8?B?Z2pQQlp5ZG1sWnJDenRlbWd6OUkyMVh5SlpTTTJqWlh2TlY0eERXY0pKZ0FX?=
 =?utf-8?B?MWlsYTRJOXNieG5ERXFTdldnV2tqQUhNSmFoM1BXemZLR1BzRzZGT00yUE5V?=
 =?utf-8?B?WGlXZmk4emhRSWxJYlNIaGlwSWsrdzVyLzhOL1F4aWlLUFY5aDl1WUFIdGNn?=
 =?utf-8?B?R1gxcWt1c1JrUWJ6b093alZHRlpDdlE5S1Q1TmFjNnlid2tCWVI2UlFBOVg3?=
 =?utf-8?B?V3BkZmtDc1ZRazdhclpRRWlXMExXY2ZBYWRBT3ZDeVl6SjRTNWJiM25qdUgv?=
 =?utf-8?B?cjZrYytWdGt5N05GOHlIT1VSQXIrT1NVMGpKNUVVQkZuZkJxbk9lOUpIcFdS?=
 =?utf-8?B?WmtlOFI0SndDemt6NFlzbHhtVXRISHovblNHTEh5ZVZLUC9kcUYwYjVSQnJK?=
 =?utf-8?Q?hyt65soWBvGXVgsI4GKlfZwWPVsALoCDQO2DpLSEuzDb?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <33439277B9AA9742B268997C51F71484@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9404.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7b1ee97-d5c5-4135-d6ff-08dd81676315
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Apr 2025 06:32:00.0244
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: m/REsFyrIKUA4nmU368+jScsGjiIe1KDmSPWhO9sztsIkiQlcopTyjCztYEfV7IbpXXOEfFuj3qd4E7Gbj9WlA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6473
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250421_233205_918861_3A252B31 
X-CRM114-Status: GOOD (  13.15  )
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

T24gNC8yMC8yNSAwMzo0NywgUmljaGFyZCBXZWluYmVyZ2VyIHdyb3RlOg0KDQpUaGVyZSBpcyBu
byBuZWVkIHRvIGhhdmUga2V5IG1hdGVyaWFsIHdvcmxkIHJlYWRhYmxlLg0KDQpTaWduZWQtb2Zm
LWJ5OiBSaWNoYXJkIFdlaW5iZXJnZXIgPHJpY2hhcmRAbm9kLmF0Pg0KLS0tDQogIGRyaXZlcnMv
bnZtZS90YXJnZXQvY29uZmlnZnMuYyB8IDggKysrKy0tLS0NCiAgMSBmaWxlIGNoYW5nZWQsIDQg
aW5zZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMoLSkNCg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvbnZt
ZS90YXJnZXQvY29uZmlnZnMuYyBiL2RyaXZlcnMvbnZtZS90YXJnZXQvY29uZmlnZnMuYw0KaW5k
ZXggZTQ0ZWY2OWRmZmMyLi43MzI3NTQzZjE2MWQgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL252bWUv
dGFyZ2V0L2NvbmZpZ2ZzLmMNCisrKyBiL2RyaXZlcnMvbnZtZS90YXJnZXQvY29uZmlnZnMuYw0K
QEAgLTIxMjgsNyArMjEyOCw3IEBAIHN0YXRpYyBzc2l6ZV90IG52bWV0X2hvc3RfZGhjaGFwX2tl
eV9zdG9yZShzdHJ1Y3QgY29uZmlnX2l0ZW0gKml0ZW0sDQogIAlyZXR1cm4gcmV0IDwgMCA/IHJl
dCA6IGNvdW50Ow0KICB9DQogIA0KLUNPTkZJR0ZTX0FUVFIobnZtZXRfaG9zdF8sIGRoY2hhcF9r
ZXkpOw0KK0NPTkZJR0ZTX0FUVFJfUEVSTShudm1ldF9ob3N0XywgZGhjaGFwX2tleSwgU19JUlVT
UiB8IFNfSVdVU1IpOw0KICANCg0KUGF0Y2ggbG9va3MgZ29vZCB0byBtZSwgY2FuIHdlIGRvIHNv
bWV0aGluZyBsaWtlIHRoaXMgYW5kDQp1c2UgaW4gdGhlIHJlc3Qgb2YgdGhlIHBhdGNoID8NCg0K
I2RlZmluZSBOVk1FVF9DRkdGU19BVFRSX0RFRl9QRVJNIChTX0lSVVNSIHwgU19JV1VTUikNCg0K
b3INCg0KQ3JlYXRlIGEgaGVscGVyIG9uIHRoZSB0b3Agb2YgQ09ORklHRlNfQVRUUl9QRVJNIHRv
IHdyYXANCnBlcm1pc3Npb24gaW50byB0aGF0IGZvciBhbGwgdGhlIENPTkZJR0ZTX0FUVFJfUEVS
TSgpDQoNCmNhbGxzID8NCg0KLWNrDQoNCg0K

