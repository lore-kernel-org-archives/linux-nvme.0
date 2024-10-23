Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8188CFA464
	for <linux-nvme@archiver.kernel.org>; Wed, 23 Oct 2024 20:11:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ojGKlaMVgXZw8zn+bC2bPdRCgxHxFDNFp8nrfTyC8aI=; b=Qnym330QvuN+4PE2DQidXZDXHS
	j2tZWdtGgLSdKYtqbAcsB5DxqigeSW6wAdO2K8LMXtBXiLT49zTuKIY36+29udFXZ5c7XV/k63c6O
	DZRNxS5G1zJ0zVBd/KRyzRAqdM3D2jeNqIZ9dOfSR1xTVErwQA/zXgDbSRBOjjlKVHnbeJ8hP/LmE
	56i6RFCrL1zCoZWRFkdMs2VKZlsOWd7QurQjCdm6CUT6KVgt8uGp2x/vSsVFRJ/F0VG7JWlFNJOxO
	Sux1rJ3+fqJYO5vTv5vEgafuk/ovR/mKf6sdOAXguEztwzYlDNcr/pxQtImdRfI1JbJVRwCs+DoLW
	qQ7BbRyw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t3hhO-0000000Fmwp-2dwu;
	Wed, 23 Oct 2024 20:11:18 +0000
Received: from mail-bn1nam02on20621.outbound.protection.outlook.com ([2a01:111:f403:2407::621] helo=NAM02-BN1-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t3hYJ-0000000FlNa-3pEy
	for linux-nvme@lists.infradead.org;
	Wed, 23 Oct 2024 20:01:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FP/iHm3IONXdK05UJVWo6k1kg5CRxLfk0H+bcwcHFVAjhFt2h0Dm8XEZkLWKU1J1wiU7IkSet6W2vOX1+f0x38gFxeKBpDgcOCvhdnL5Kz5qqI3tY9Dvl3OrxJR1bwK0FDf+UwiO3oEhCAnlc7ciq/EE6EjqVIInEcBDC2r2isWO7Un+qLYEpAocavqvKyPF9i1C2LkvmtGa76/PxGwRbkMq48/oOtELa7Sipyo6wfze70JIG8sGhBUwDcIaoT7VDj2S4gxP/oD584NCKLXMvHN9Ib1/RjvupRASymZycHmBAw0alWYoe2ZIbFt/9AjQ4ZiXOp3VPOE09Cdh9ajRRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ojGKlaMVgXZw8zn+bC2bPdRCgxHxFDNFp8nrfTyC8aI=;
 b=BP1bIMI72MrTAHIYAjK3mVz5OVrhodnKL+1WUJQzOCfdjJNQggnBazhYg5ebYdtSffTn87EXC9uVQUC9nB8cDkBb+nfYk6qbgsYfn6E+zVElDQoOShaDBNfF6S9xtmQbv5khoGRarzXGmaizUr1ipNz3M5cIq1Yo6mi0TCyADD8xPkVYpjlSLrYvqm94QzHYrnEIEGO59CvqvM7jIbdx4su63WtZ3ng2Tbr+MOX9yfeN4EfK9JDaxkuTNKhiwr8y5Fo5cw+ik9MhLLISteDGpu+IANnYjEX/8f2YDDw1UsoelbN1UNfsDcZ3kJttWacAlHwI5BASljAvNZXplgYCLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ojGKlaMVgXZw8zn+bC2bPdRCgxHxFDNFp8nrfTyC8aI=;
 b=ollbdYlm40M4RNMNE/8nSX1dInIRta5dvBNfpvpMwsnyxfLe22uz22NJsCb5daLFsYakDuq6zY4YmCoUx38VvPjuVKjspLCIXpKt1fXJBIoKNDq05GWK9pcuv8Simw4T0b6SOPs3HHwDs1iUtZkv4Mn5nYrcoyjNyaFIt/1mQ2TadNvrnpZ9JKs6gDP09hHuf6sdULQaHndvkhJPgb5e1IVt136fzWW/GNKPPLx6jHvda91fJilleznU5Kb8HyBTFW/WMQZkEKdVGT6Prw0U8D8Y21eHttW9GZukzuRgscpnVI2rmC9LDB2HvH1fmXNwjgXwuOkhP50hA2qZI1luLw==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by DM6PR12MB4482.namprd12.prod.outlook.com (2603:10b6:5:2a8::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.17; Wed, 23 Oct
 2024 20:01:43 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b%5]) with mapi id 15.20.8069.027; Wed, 23 Oct 2024
 20:01:43 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Keith Busch <kbusch@meta.com>
CC: "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
	"joshi.k@samsung.com" <joshi.k@samsung.com>, Keith Busch <kbusch@kernel.org>,
	David Wei <dw@davidwei.uk>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>, "hch@lst.de" <hch@lst.de>
Subject: Re: [PATCH] nvme: module parameter to disable pi checks
Thread-Topic: [PATCH] nvme: module parameter to disable pi checks
Thread-Index: AQHbJWfH6A0IHQhsNUS405YTQbc2TrKUwfIA
Date: Wed, 23 Oct 2024 20:01:43 +0000
Message-ID: <cb19f610-b6b3-4dde-9d1a-88446dc0615f@nvidia.com>
References: <20241023155048.634988-1-kbusch@meta.com>
In-Reply-To: <20241023155048.634988-1-kbusch@meta.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|DM6PR12MB4482:EE_
x-ms-office365-filtering-correlation-id: 87644d81-54b2-4595-b761-08dcf39d840e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?WEZHRE5uTTFVajJqeUp5aWVHbHRia3JDcEdRMXBzVkhuRUtPZmNpODFKQko0?=
 =?utf-8?B?YnU2cXdCbFZpVFZXTDdKb2V5K2VqanM3VXpRanZoajc3SHNIWEg5S1RKT1Ro?=
 =?utf-8?B?Sng5QlpnY1lKOUFpZjNNVXhYTkE5eGdDUGUrM0JiUElsQnJSUnFNT2lXeStZ?=
 =?utf-8?B?MXROaVdWMlk0NEdyS1ZWUUxYSCtzWEIydHg5ZFNvNHhKM0ZPMUF1cjdaWDNq?=
 =?utf-8?B?cHkva1R0YVczeHVuc2pNR0RXSDhFMDJXc3pweFZVWEJ6NTNGS3dSVC9sais3?=
 =?utf-8?B?TWRScTgrS0ludXAwb1VOdEFNR280MUxwbFppdHZtWXlQUy9PK0FEUlRESW5I?=
 =?utf-8?B?Y1lBMUhlTFM2ZUk1TlFvaVBNbVRoZDdaR1VWRXowV2JFOWcxVTh2VlVaeW4r?=
 =?utf-8?B?VEpPMTRRREszQUFMcCs3ZTNRRFZvbEhxR21YT1JBRlVPdCtZWTFqU0wwMTVT?=
 =?utf-8?B?UytKYmtiQXV0d1crZXB3SzQwaEZFbGpaSUc1ckxBUW9oKy9BNFVqb1NCQjQx?=
 =?utf-8?B?NXpqZ2pxcVBPT1dSQStDQklFanJUNFRPRVREd1pNMDlzR0t1RE00cC9lVFRn?=
 =?utf-8?B?MXlZT2tBbXNla09sU1hFRzgxTWFzRm9IN3ljZTlTVGZpZGkvT1ozRHRkUFpr?=
 =?utf-8?B?ajlEOHRYRFI0SUNDY0ZBOVdwWTZMTE5uSkRNc0VOVExYSnJXa21leUMyZVdz?=
 =?utf-8?B?elBNekxpYTBuMFI3Z21HaSs1NlcwYWkxczVIZS9TWDBvZWhYb21CeUE3Nkpo?=
 =?utf-8?B?dzlJSW9wUTdWMGVtVldMVTFBdngvc0pna3FHOHlKbzJqYVNoMUFOSUVvczdV?=
 =?utf-8?B?OU5NNEpiOVVDRjZLVWpRTzB0ajR3ODZoUWNVTnIwcmNVWDFMck8zSzE2S2ds?=
 =?utf-8?B?djloYUx2YmF2YkkyRGxtczU2dDdsbUMvQzRLZTlmc25DeHhvZnc2Qm5abDRa?=
 =?utf-8?B?YmxZL3FzQ3JmWUI3UEprN3Z1OXpCY01qNWlvakNlTVd3TnpMWVdkWWpkQVY0?=
 =?utf-8?B?UzJPOUV4UjlZSkdOVFJpRWpsbXNveEF1RVJ1a3Y4SmZ1MG5EOVY1WE5GN09J?=
 =?utf-8?B?MFR4bmZUTy9yUGdhTndSTkFMTmV6N0l1Q2ZCT1VweVpoeWVRc0c3dStXajJZ?=
 =?utf-8?B?ek1CeWFJcWg1dDRMVVVxRVBrR1BlUU5KNytlYUQwelp5U09vcURCa0Q5ZmNH?=
 =?utf-8?B?R0h6UmY3OWpmYXBmN3FqYlpERWFJUy85OGl0R2xzWHFyOW0xeUMxU2Mzc2VN?=
 =?utf-8?B?MkVsY0VCZkpvZzFPZm1EK0R3ZW5GcnVLcXl0c0tRZDZ0YWRQdkpvb2JFSit2?=
 =?utf-8?B?WmE4VWU0d0FlSDRFUVRPdHNIMnI1YzBtVjkyb3FiL2ZybnV1T1A3dTRMVExn?=
 =?utf-8?B?SEVDSDYyUE5TWUtiME1ZQVhpTnRmRG9tQ2l2SkY1M1c1QWZxSGJqZjRIckRX?=
 =?utf-8?B?Y2JwNTMrbjlmYkF4TDdob3N5MUtsZHRJemdHWUJ1MWErY1ljcnQ5R2ZlUHNX?=
 =?utf-8?B?S2s0QnZ2L0lVdnRLQ2o5T0VFSG4xQk5odkQycjNYQVMxSnpnQ2JzM1B0T2Ja?=
 =?utf-8?B?V0RuQWdEUlMra1Q5MXA3TmhzV1FBUEd3TVhzd09GTUdPZ3FtcVNGT09ZZ2NJ?=
 =?utf-8?B?eTlBNkJRVWVrbGgvckoralh6WGxsSDNRZWtmL2p4MUk0TmNwUVVseXk2aENn?=
 =?utf-8?B?eWRXd3BRckN2YW9BU2dGTGNSN21LY2JPcmVjSy80enZneEtIQ0FnZFJ3dTJT?=
 =?utf-8?B?R1JicUdQd3BqSlg5eHFJcXoyVk1mYmJzK09MS3l5YUdMeGhrdHovL3lxUlBS?=
 =?utf-8?Q?pQYP1KL55ojgZKH1T8e6wBDnZwZysoXudsx3M=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cFVlT0JyV3RQQitEVjFNdDFHVGZCQ0cxMzZBN3RqODU1VEkxN2M5OHNyNXdG?=
 =?utf-8?B?MVpIVDdwcUZDYzZ6cHo5Wk1MZktxaFgzcGw1MHc1dEFmL2dBWlZJRWE3eHNC?=
 =?utf-8?B?eDNXMUdKWnRRM1kyc2xmM2FwTDhWUjZKeTdrbE0rY3JFQ3N6akEzNFAvaWxt?=
 =?utf-8?B?V3VacVEwYjV6YkduL1RtWFZGaC9ITTR2V0tnWnFLTGdvTHBabUx6TlE4d2F1?=
 =?utf-8?B?NThtOFRlbzJXVDJDMGg4MEVvMnlaV0gycVZXWjNEOC9IVCs2ajI0b1RPb0VG?=
 =?utf-8?B?a2hhUmFQeHBjVEhaaXBNWEEzNC9BaTJHTWIvT0VRaVgvcmlJY1FWQUNsVTI3?=
 =?utf-8?B?NTVONUlIWW12NUJYL015NDVlM0JMckd3aGhLdGQ1dERwR2l1WnhZTXZZcGha?=
 =?utf-8?B?TmRUcEIwZFhzclFxeWdxS3U0azJ1RklvRVBtYnJCOUdvTGRvekd2MDh3OENZ?=
 =?utf-8?B?M2Myc2R0WmdnTDU2eVBUVzJXSGRDcXlLeUVwUFR2VFdreEhhR2ZETkNYOWVK?=
 =?utf-8?B?R21ndEUyWmxxWjNWbWwwWG5BRi9NNFc0U3FxcWt1L0tSNGxUSzN5bTcvWGU0?=
 =?utf-8?B?akJRRDRNSnU5MzBkSGlGZ21JZXYwd1JWNUNLRzlhcmRLR216VUlMdkRiNkI3?=
 =?utf-8?B?b2c4RnIrbnlCMWxUOTg5ZzBSWkIxZG1jTXBCMFFIeWMxZStocmdkOUZDZlhW?=
 =?utf-8?B?NitYQ2lRbWo2ZE5Cdm8vcTE4eEYvTUJXZnNHRjJhVWNVQXFjNGJ1OHBZdWtY?=
 =?utf-8?B?MVBjLzNneUdmcEpuMTBTa0JYRjUweEdNK3NMcktXc3VENSt0bktzbXdueXJ4?=
 =?utf-8?B?b09WY0RRWGcwMHdueGh4Ui8wREFoT1VNdFJhelN5U2VLdDV2eWJTaHFqdHdk?=
 =?utf-8?B?QnY5MkhmQkNndUQxdG93TU1Wcnl0aUNvMUh2ZEZtOXk1OW9HdkgxQm5QWnk3?=
 =?utf-8?B?QWxoaUZjYmF4S3RNaGlTaG45NktDUHd2dTJJUnA1VStCclRaQzZKMTdnQ3Ns?=
 =?utf-8?B?QTZ6T05IUWZkRFBsNHE5NlRkdDdrQm83cTVsNk0wME5yem9mU1NUK2R1dXE1?=
 =?utf-8?B?bVhuSlh4YzM0VGV5YkxieFpxcVFrSE5jUUxlMEJWbXk2ZGl3VXBERDNFVG16?=
 =?utf-8?B?QTlXckZ3OGNpQnE3dTlsZXl4N1Btc05VNGgvNWpkRU01R2JIRkE0VUNWelNn?=
 =?utf-8?B?MjVtNzdReEhCWG81VDVCUkVsQWlsNHpVSGwrTTlsbFRVZjdrVWpselU4US9l?=
 =?utf-8?B?UVZRT05XWkFnc09jTUtzSG43eGl2SkZhWGVaV1VLYnVNQ0lqK0VyVUZUZFU5?=
 =?utf-8?B?WG93T3BvZWhNamVlSDgvTDNWdkdkbHhHV09vUkhsK1JzR1BRK3Q3ZVB4TWhS?=
 =?utf-8?B?aWhZSTN4VWJsQ2VicncxM1lBYUoyZGVYVDR2d2ZobUNEL25ZQVZ3ZXJ0VWV2?=
 =?utf-8?B?LzU2aUp0RHJQYW9TOStxcXYyS05yRjl4OXhHcGNuSFdBWHI5TmcrRTdtcStR?=
 =?utf-8?B?QUowS0xRQldueEttcUlYMUo4MGRVam5MSlQ3czdvbDRjdGRzOFFrN0RJeUlv?=
 =?utf-8?B?MjZ6ODVFSnp2ZUs2bStkaGx2QnlscnQySVNmL2M2S2NFSEFYbXBVNWZpNS94?=
 =?utf-8?B?VGxzMzU4bnh4NmYwM05mK1pCOEpxbHl4VWEzYU9GT29Md3AzUEhJTzFueWFT?=
 =?utf-8?B?cUlmbjJ4R0RmcURVUkRsVTVSYnRFdGVLaHVDNndGeWc3c3UwQk1rYXVqUFQr?=
 =?utf-8?B?dnJqZmNaMENCbmZpZ0tuTjVYMWpTb0kwNjJ2R3IxZ3FzQlBva0tsTHo5SGtJ?=
 =?utf-8?B?azErK3Y0SkZFTXVsSDZZRGZZSkd4UUt0eThZV20vTGdXZkFpY05BRW1PNllm?=
 =?utf-8?B?VGxKWkcxcVBLTWhEUjZrWWtreHdiUEFZdklCL2VQaFJidk9LZVhtOFlXaFhv?=
 =?utf-8?B?ekR0YWxTQS9oN3BaNXQybzA4azlPMHc4bEJ6Q3FGTjl3VDU5eCtaVk9JZ1Zh?=
 =?utf-8?B?bVZtaTgyM3NSeXBBbHBWb2dxTTd3OWVmTjBlcDlTNVU0MVExZlZINnJWUGFQ?=
 =?utf-8?B?RDB4TmlzQTUzaFZub0NJcjI1TGlsQTRRM1NCSE0zVnJDZVJQajU3bG0ybVBk?=
 =?utf-8?Q?iqj+7RZEBnYrTynew8idc3M/j?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D984C5AB0DC136428A5C3E9ECEA96480@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9404.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87644d81-54b2-4595-b761-08dcf39d840e
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Oct 2024 20:01:43.0203
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GulSelJP78pnu84iHyXqE8o0J7iGru6zhpzatVSKBGtYZ5BAdjRNFOXot/VzD5y8DMStyJq9NQLM0DzuwpJIsA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4482
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241023_130155_992967_F908D712 
X-CRM114-Status: GOOD (  13.83  )
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

T24gMTAvMjMvMjQgMDg6NTAsIEtlaXRoIEJ1c2NoIHdyb3RlOg0KPiAgIA0KPiArc3RhdGljIGJv
b2wgZGlzYWJsZV9waSA9IGZhbHNlOw0KPiArbW9kdWxlX3BhcmFtKGRpc2FibGVfcGksIGJvb2ws
IDA0NDQpOw0KPiArTU9EVUxFX1BBUk1fREVTQyhkaXNhYmxlX3BpLCAiZGlzYWJsZSBwcm90ZWN0
aW9uLWluZm9ybWF0aW9uIGlmIHVzZWQiKTsNCj4gKw0KPiAgIC8qDQo+ICAgICogbnZtZV93cSAt
IGhvc3RzIG52bWUgcmVsYXRlZCB3b3JrcyB0aGF0IGFyZSBub3QgcmVzZXQgb3IgZGVsZXRlDQo+
ICAgICogbnZtZV9yZXNldF93cSAtIGhvc3RzIG52bWUgcmVzZXQgd29ya3MNCj4gQEAgLTE3NjMs
NiArMTc2Nyw3IEBAIHN0YXRpYyBib29sIG52bWVfaW5pdF9pbnRlZ3JpdHkoc3RydWN0IG52bWVf
bnNfaGVhZCAqaGVhZCwNCj4gICAJCXN0cnVjdCBxdWV1ZV9saW1pdHMgKmxpbSwgc3RydWN0IG52
bWVfbnNfaW5mbyAqaW5mbykNCj4gICB7DQo+ICAgCXN0cnVjdCBibGtfaW50ZWdyaXR5ICpiaSA9
ICZsaW0tPmludGVncml0eTsNCj4gKwlpbnQgcGlfdHlwZSA9IGhlYWQtPnBpX3R5cGU7DQo+ICAg
DQo+ICAgCW1lbXNldChiaSwgMCwgc2l6ZW9mKCpiaSkpOw0KPiAgIA0KPiBAQCAtMTc3Nyw3ICsx
NzgyLDEwIEBAIHN0YXRpYyBib29sIG52bWVfaW5pdF9pbnRlZ3JpdHkoc3RydWN0IG52bWVfbnNf
aGVhZCAqaGVhZCwNCj4gICAJICAgICEoaGVhZC0+ZmVhdHVyZXMgJiBOVk1FX05TX01FVEFEQVRB
X1NVUFBPUlRFRCkpDQo+ICAgCQlyZXR1cm4gbnZtZV9uc19oYXNfcGkoaGVhZCk7DQo+ICAgDQo+
IC0Jc3dpdGNoIChoZWFkLT5waV90eXBlKSB7DQo+ICsJaWYgKGRpc2FibGVfcGkpDQo+ICsJCXBp
X3R5cGUgPSAwOw0KPiArDQo+ICsJc3dpdGNoIChwaV90eXBlKSB7DQo+ICAgCWNhc2UgTlZNRV9O
U19EUFNfUElfVFlQRTM6DQo+ICAgCQlzd2l0Y2ggKGhlYWQtPmd1YXJkX3R5cGUpIHsNCj4gICAJ
CWNhc2UgTlZNRV9OVk1fTlNfMTZCX0dVQVJEOg0KDQptYXkgYmUgd2UgY2FuIGdldCByaWQgb2Yg
dGhlIGxvY2FsIHZhciBwaV90eXBlID8gdG90YWxseSB1bnRlc3RlZCBbMV0uDQoNCklycmVzcGVj
dGl2ZSBvZiB0aGF0IDotDQoNClJldmlld2VkLWJ5OiBDaGFpdGFueWEgS3Vsa2FybmkgPGtjaEBu
dmlkaWEuY29tPg0KDQotY2sNCg0KWzFdDQoNCmRpZmYgLS1naXQgYS9kcml2ZXJzL252bWUvaG9z
dC9jb3JlLmMgYi9kcml2ZXJzL252bWUvaG9zdC9jb3JlLmMNCmluZGV4IDJmM2IzOTExYmNlNC4u
ZDU4N2Y1NDE5MzdlIDEwMDY0NA0KLS0tIGEvZHJpdmVycy9udm1lL2hvc3QvY29yZS5jDQorKysg
Yi9kcml2ZXJzL252bWUvaG9zdC9jb3JlLmMNCkBAIC0xNzU4LDcgKzE3NTgsNiBAQCBzdGF0aWMg
Ym9vbCBudm1lX2luaXRfaW50ZWdyaXR5KHN0cnVjdCANCm52bWVfbnNfaGVhZCAqaGVhZCwNCiDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgc3RydWN0IHF1ZXVlX2xpbWl0cyAqbGltLCBz
dHJ1Y3QgbnZtZV9uc19pbmZvICppbmZvKQ0KIMKgew0KIMKgwqDCoMKgwqDCoMKgIHN0cnVjdCBi
bGtfaW50ZWdyaXR5ICpiaSA9ICZsaW0tPmludGVncml0eTsNCi3CoMKgwqDCoMKgwqAgaW50IHBp
X3R5cGUgPSBoZWFkLT5waV90eXBlOw0KDQogwqDCoMKgwqDCoMKgwqAgbWVtc2V0KGJpLCAwLCBz
aXplb2YoKmJpKSk7DQoNCkBAIC0xNzc0LDkgKzE3NzMsOSBAQCBzdGF0aWMgYm9vbCBudm1lX2lu
aXRfaW50ZWdyaXR5KHN0cnVjdCANCm52bWVfbnNfaGVhZCAqaGVhZCwNCiDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgcmV0dXJuIG52bWVfbnNfaGFzX3BpKGhlYWQpOw0KDQogwqDCoMKg
wqDCoMKgwqAgaWYgKGRpc2FibGVfcGkpDQotwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBw
aV90eXBlID0gMDsNCivCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGdvdG8gb3V0Ow0KDQot
wqDCoMKgwqDCoMKgIHN3aXRjaCAocGlfdHlwZSkgew0KK8KgwqDCoMKgwqDCoCBzd2l0Y2ggKGhl
YWQtPnBpX3R5cGUpIHsNCiDCoMKgwqDCoMKgwqDCoCBjYXNlIE5WTUVfTlNfRFBTX1BJX1RZUEUz
Og0KIMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBzd2l0Y2ggKGhlYWQtPmd1YXJkX3R5
cGUpIHsNCiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgY2FzZSBOVk1FX05WTV9OU18x
NkJfR1VBUkQ6DQpAQCAtMTgxNiw2ICsxODE1LDcgQEAgc3RhdGljIGJvb2wgbnZtZV9pbml0X2lu
dGVncml0eShzdHJ1Y3QgDQpudm1lX25zX2hlYWQgKmhlYWQsDQogwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIGJyZWFrOw0KIMKgwqDCoMKgwqDCoMKgIH0NCg0KK291dDoNCiDCoMKgwqDC
oMKgwqDCoCBiaS0+dHVwbGVfc2l6ZSA9IGhlYWQtPm1zOw0KIMKgwqDCoMKgwqDCoMKgIGJpLT5w
aV9vZmZzZXQgPSBpbmZvLT5waV9vZmZzZXQ7DQogwqDCoMKgwqDCoMKgwqAgcmV0dXJuIHRydWU7
DQoNCg0K

