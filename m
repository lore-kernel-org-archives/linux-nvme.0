Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25267E6C619
	for <linux-nvme@archiver.kernel.org>; Tue,  3 Dec 2024 08:26:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=D51MMqBTzDCIaTAKgPg/DnTFQO+7CltT655bsJJE+BU=; b=NiqvZ69CyQpG0wR4AF8Ep4sPV6
	3AF/223lXLzzMERFIV88EZVOTLVN5G/UwLAFPabRuB7RPn92SqmN+UP2sC72M/k1BU566Cffclsc/
	wGfMVAaxJdUYLIE58ZqM70xyBR2ByCenz2Yl1KeSeKZOz1fgwf+/mGRAnm5cuu4iCyy2corK/vz1S
	2oG6w+pstkAGwVhPb2Dljdn31FADH5A1Mbv3ec0ubnCVmUEIUzyydMDVRJPLagtXcNMXS7bI6efJn
	xs9ynevC/2PXYEMK4N3ooFKzl77YQPUm0wRo4a6flccoaCybFt5+7PUllCCFZo1GZvVfHGiXtunWm
	MaCpcc8Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tIOFD-00000008gkr-1SQV;
	Tue, 03 Dec 2024 08:26:55 +0000
Received: from mail-bn8nam11on2061c.outbound.protection.outlook.com ([2a01:111:f403:2414::61c] helo=NAM11-BN8-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tIOFB-00000008gjL-0RUo
	for linux-nvme@lists.infradead.org;
	Tue, 03 Dec 2024 08:26:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k0mRzeHw8lsIwV6PJDNLnzMZQopQPe944P8sVVhxFyHY46ceFioN15x1vE09XyRwuZu6Zz/li7ZplQVvULtSMiRyrl3mUfMUgOFsRtT6t5ky9aBdBu1w6Xgd6TIv8eCZUMGU2tzHrRgtwDMr0SpWXGaeMDEETin8sAocvkHG6gB3QvWEOUxpvSGCZJ62nIj1m0RMHo2mqT+eCcT5qlE7KAhT+MD+4Cn9diQnlKMaUPLY+BEmbxQdityPNhwzkuvUJ9pvgB6gkUbX0OQmGN1AAf1zdzIeOPl+cpuTH0vaC8adG7irpkst8edUOMA/CAGF2O6f2+xAhy/A9A3Jq0z2iQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D51MMqBTzDCIaTAKgPg/DnTFQO+7CltT655bsJJE+BU=;
 b=jc8dTlQjsBJnpwd7nYOGSFkopifO+C0rie2tnAjNBg0Hge4IhzYox2ZvuViTYBwJHVSW+GaG+2C5hjm7dy0IAtf/DUUf8f6xit6ki35+LHt8Wk+JPTj70B7vGYAupivhe2QN21JGaypOgbwE6DL44U80q1CsbNlKBhQfkGOm7tdCWWr464eCw1kzPftPrg3YHtrS6+oryMunrmtSb77mfTs8nC1AdPTy63MfT0YIOPp/Kw8DsfgjjUIv3+gQPvNSyh7F2T6zJnTSgVknppvBPyOglmdRWNFJWqwziDN5vDmHfAdK3Znw4quiwS7sNhwU4Rb6rSd5pzCjHQ39495JVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D51MMqBTzDCIaTAKgPg/DnTFQO+7CltT655bsJJE+BU=;
 b=gxZb29V2OpfCpWWdP2Q3R5pjWZDiVAlexQm+rjacWsyZn/lYvKAR5ZrM9ffPMdcmpEY7bDPWRIcJNhQySMNzHbGQ1i2zhMCOe/0BHuT+Fhkxh3amf3pDOYs76thvoYo1XIJghGQLFcwa162ICRG5ls+blrXX7EOwfAhZkFjofU4VSXYtPybOwcCR+GKK99T2kFBoUoYm3ZxmhuTJ3moOrisnd6xwNKc2c+NbmGrB06I6eJrTVRP5VIqBcKl3Nf/CGfaLtB5K1egG58UolJo0IBBzJpNIZi4iCySOQO6OO3TKR5WRg4I1FocHu4r+NX9IoE58QJ38jC7Jw6VD0T9vrQ==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by PH8PR12MB8431.namprd12.prod.outlook.com (2603:10b6:510:25a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.17; Tue, 3 Dec
 2024 08:26:47 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b%5]) with mapi id 15.20.8207.017; Tue, 3 Dec 2024
 08:26:47 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Nilay Shroff <nilay@linux.ibm.com>, Shinichiro Kawasaki
	<shinichiro.kawasaki@wdc.com>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, hch
	<hch@lst.de>, "kbusch@kernel.org" <kbusch@kernel.org>, "sagi@grimberg.me"
	<sagi@grimberg.me>, "axboe@kernel.dk" <axboe@kernel.dk>,
	"gjoyce@linux.ibm.com" <gjoyce@linux.ibm.com>
Subject: Re: [PATCH blktests 0/2] add nvme test for creating sleep while
 atomic kernel BUG
Thread-Topic: [PATCH blktests 0/2] add nvme test for creating sleep while
 atomic kernel BUG
Thread-Index: AQHbQji3EVk3HAUJ80KUvF6hxUTdIbLPiuoAgAR7zwCAAC8FgA==
Date: Tue, 3 Dec 2024 08:26:47 +0000
Message-ID: <77fc8b7a-4d90-4496-bce6-94f3af5c70df@nvidia.com>
References: <20241129080231.2994578-1-nilay@linux.ibm.com>
 <kuvftnq5cjwtzh557umohu7afvndg3tl4lx6qfjjuwd675phk3@y5iaypkzdsz6>
 <9d6b3b9c-c9df-4fcd-bf2e-6a5635171bcd@linux.ibm.com>
In-Reply-To: <9d6b3b9c-c9df-4fcd-bf2e-6a5635171bcd@linux.ibm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|PH8PR12MB8431:EE_
x-ms-office365-filtering-correlation-id: 46cc7eac-7855-4c69-0c46-08dd13743aa0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?RTBNN3BzVWZrM0ZGek1JWDNZblpVaTF1ZVg3U3F5cjBscyt5VlBCTHZoV1pX?=
 =?utf-8?B?K3ZXc1N1QmhiY0pXTzZSaklxWWlxbmRhaWs2ZmNtcm5zVTdIWWlwa2xPMk9F?=
 =?utf-8?B?ZmVlS29QaS9qUnBVOElkN0MrYkE0MnRjSURudDlGeDdOQmFPS3U2RVpROVpr?=
 =?utf-8?B?a1RGdXVuTDdid3UzWmhKVndTUTdOSXg3TkNWRllGNGlFQzZuNnRaZU5TZUov?=
 =?utf-8?B?YVZ6cHFqV1VOTDZOYTcvYTB1TEtBK0lReVZRZWJDcmtwMDM4WWw2ZWxLdnFs?=
 =?utf-8?B?Vmc4cUtkQStIQzAwYTltbUhjbUtOQkdJQXNxQlFzbmVqc21acGVFdDdLQlhI?=
 =?utf-8?B?ajF6ZmRPMzBVK1hNWnVIdzBWaGdyeGF6MUhGcUFNaU0vaSt6bGErOHMzdG0w?=
 =?utf-8?B?aDNNUzI5bVErL1FOUkRCbkVsalNXSElXT0IwU0MydmFodkVNSkFJcXNlbTZv?=
 =?utf-8?B?N29ZOGJJZHFaY05pSGhncWNaYzFnZ01wcUV4SzdDL0NIMk5peTR6eFV6bk9D?=
 =?utf-8?B?bFF1L3g1MHA2OXhzcVdmSTdkREJ3NjFXcUZsRFJpK3FYZGtlYkVwWnpkVlcx?=
 =?utf-8?B?Und2a3hrT3lJcE9YTENBdHdnOW1rZVhvcE9BWWlPV2hpck9zcTJiSnR5dUFI?=
 =?utf-8?B?cC9VU3RLQXdVMmJ4Z2RqWkFGOXd3N2tKQmhoeTVHU2grVDErSkRXcytzaU43?=
 =?utf-8?B?VDlocTVuMVV1aEFONDAxamx1bDFVNVJYM2xzT3FHcndTaWFNTlFBL3BHSU8w?=
 =?utf-8?B?Q1hsZlBqRFpVUjhCMEtpamphc2hlV1hCcXVVaUtva3NJRzJrL1J5ZVMxYUNy?=
 =?utf-8?B?NDBDOXZiSXdFcFBxbkxaMUZkY2wyelpiTEl6aVNvUnZVQzFOTUxUSjZwejE5?=
 =?utf-8?B?SXRqUmtxb1N3M3pIeVdzWEpjcHNhLzZkd0h3c1ZtME1iYnlVUVlyU29sZEpy?=
 =?utf-8?B?Y2ZvR1BhVlkrR1lKV20zNEVPWHByOXJaVEM4TWZZVktVZTVKWC8rTVRSQXBz?=
 =?utf-8?B?elNnMkZNakFtakowdUNyNHU4aVEwL2Rsd0N3WGZrL01DcnBFZTQwNFg4WTFh?=
 =?utf-8?B?WWJFRHFTb09pNUNrMFlFRFd2M2wwTVYvcWw2bkVGamFhazJ2L05idUg2akNs?=
 =?utf-8?B?RnRzMHQ5M0JtZWdUUHpWRTdQQnhQdTNNL01BbGZUYmRpQmN5V0JTWEJTTEZ3?=
 =?utf-8?B?YlkwV05iQkNuQUgrNy9Rbmc3WFpTN1ZPbHMyOXp4R0h6QlBXQXdhZzRucjk5?=
 =?utf-8?B?eGRiUmlibVptMXF0TFBQTFp3N0FHK21UQys2bnJERkZYdThXa3NEeUhvU2Ji?=
 =?utf-8?B?YW85UWZuajNwd3pOVGFMVlVrRFpEdk5DQW5HOWhFbGphQUV4Z1o0aFh0WmtT?=
 =?utf-8?B?ZGdqQXJsZ0draTJYcEx0RmE2QjB2bEx5L2RVR2lKdW5UUWFBTm9uQ2xLRzNJ?=
 =?utf-8?B?c2NPSUs4dTFhWVEvYUZDaEgxdlNFYyt2OThSdFZXRVcwb0RiNUFRQTIwUFUx?=
 =?utf-8?B?NUpzRnJyMm94czVZN3hYa3pVdnBEM0pRdWkwZVFxL1dpZnFlTlluT2tBcThX?=
 =?utf-8?B?ZWsyb21Gb2NtZ2xNN3lnVWJhTHVBeVl2dzZXYmJwMk5qQ2cxQlVzOFB5OVUx?=
 =?utf-8?B?ditqTG5CSTJaR0ZGYTQxdFZzaXZwcnZIQmMvcDJtNzRaS3ZNRWJFRUttay9W?=
 =?utf-8?B?NzJzRkV3ai9hTVJDRnF2QXcxSEJqUmF4SGloRE5DZTZ3UmZnUGhlMmpUYnJu?=
 =?utf-8?B?WFkwcmJSaWtKSWNnSkI4b3N5eG02SHNUZzBVL0lNTE96VWhsNUY1Q2dhM2Nx?=
 =?utf-8?B?WXMwRDlNMVdYVGd2TjZpWEllNE1QcWlxZTJCZW90aGx2dU54T1ZHbVlVVjNX?=
 =?utf-8?B?UytLL3lzL1lBV1E2YWxJRlpXZUN3US94WVRQbm5tbEdSY3c9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cHEzQzJoTmFFSWJlTmJsNGk5VytqQVo0ei9IbWZESEhWazFKMEoxSWtmV0ly?=
 =?utf-8?B?OW52akl5M3h0b2tUNWlUbnE5MVQ3dFZ6ZmJDeTRUZUowWHB3L0UrR0VseDRV?=
 =?utf-8?B?QnAvd0FoUmkweVlzWXJzcjRMdjc4LzdkelY1Sk1aMGRnbjE5ejNTMHpXakpF?=
 =?utf-8?B?WlUrcXROSFYvZlB1RzN6U3YwN0p0eDRzREdPSzJIYnhaWlFjZFBtUzVod3dH?=
 =?utf-8?B?bzBYeTN2WE1GY2JBKyt5QktNY1RDSG8zNDZOZ09ma2pEV04xQS9EZkhQYnRB?=
 =?utf-8?B?LzlWY1FkU1dtRHpIMXBVc1hFdUorT1ZTbklPcmxOTzQyM2RkMEFYSXc2eHFv?=
 =?utf-8?B?aFYvaUptTms1NUkydXY0a0FOaFFXcHpHelhrb3pnNGFtaFY0dkRjOWd2Rml5?=
 =?utf-8?B?ejBmejViNDhrY0x6Yks3WDVRZXVsb0lOOUxta1ZOdm9UdlgyVWhqZm15Rm95?=
 =?utf-8?B?MktwTmdTSVplUGJEOXhreDJFSklQbm5YU29Nc3BpNThMQ3k1bUNLUkF5S0pG?=
 =?utf-8?B?cUZNTnhLSzhxMmlZZVFRMlhmQkJaRHhSNWxaSlYwOXFkYzdQcFpyb1ZBSXc0?=
 =?utf-8?B?enRoaDRmWjMyamdWSVpxU3h4R1A1VCs5emE5SmkxTXFZeC9ROVhpRGNQN1ZV?=
 =?utf-8?B?cjlvQ2s1N0FkOUdvL3NCQmxMaVdyNGZpUmFGNmxPdy9IWXNlZTNUSGZZWUZR?=
 =?utf-8?B?b01mUTdWMjY5cGRHMjdqb3gxTGdSdlYwMkxzWVhGYkNON2w3blNXQkZIaktY?=
 =?utf-8?B?dGlpTTFPRHNCWHEzVzlVUkhaVE5sMERlazlFMEErWldXYXl6aXQxOXNTRldM?=
 =?utf-8?B?K2x2VEhPK0w3YnhMWVRpY3hkK3R4VGNoREQ5RHptSTFxZW9Rc2tqKzJGQnJu?=
 =?utf-8?B?akhWWVNiWWhXRlJ6QTVWaEI1OEh2VEZoWkM4dThDdEJ5U25zWWpHeFJBVlRw?=
 =?utf-8?B?MC9pY1dhamNwUFdMTjg0YjB5N0ZKTDZQQXJYUGp0bmcrNko3cjA0K1hEV0Y0?=
 =?utf-8?B?alUyYk5OY0Nvc0ZjMi9FaDFEK3kxQnl2VzBGNzliT3VTbDE5QXJGQTU1dkc4?=
 =?utf-8?B?K0kvbkJGc1J6ZTc0SUIvaWdPb2tkQ0xoSTdzY0IyeHhEMjJVcWFKV0lxbVdS?=
 =?utf-8?B?SkF3WDJRc243eGd2a1kvaDZSNytZcXlLcm1XTmFQT0ZQL0UwN2hxKzlySlBZ?=
 =?utf-8?B?bXRiTnJZRWV0NTdOcXE0MHhSOVU3THFlNmtXS05JRnJURG9rcEVNYUlnYkZ3?=
 =?utf-8?B?elVPekRXMWx2a2FjT3VIUFMvUnRnQnBOODdLLzBheG10VWZMdWRFSnhGeHRW?=
 =?utf-8?B?MG0rN0ZodlIzZTRZSXFFRHoydlpjMkJwZUxYeGI1OXBPb051NUgxUTZ1U3Ry?=
 =?utf-8?B?cHlFN2Z1TGtzck1TS3lxQ25QUG16MHRta3dOSGhHVEZwNTZrekJrOERQMUxV?=
 =?utf-8?B?RGl2SXo1NUI3KytFTjN6N0FwbDA5blduSzcraSs4WnJuY1FnY1ZmMFlQbzZ0?=
 =?utf-8?B?eVJwZ29LNnk1c09OK3BoTnJBdk5zMENDVWhlYnd4VmhMYUR6ZmlXelFJUHpn?=
 =?utf-8?B?bk1tZjJTVFZURWNNYkhQRWVKZmFKYXpqMGY1VFFzSExPR3B6YmlmMFk4a1J6?=
 =?utf-8?B?SVZzQ1BNNVR1aGFZdTdXc3lJVmRCcGlQUURCQnFFZ24xM2lCeHVTcytiNm1I?=
 =?utf-8?B?anAzQTJ4dFZvb1hYS0YzOXlIZUpiVVhxc2d3c0p3N1pCTEdBWThHY3QwRDR0?=
 =?utf-8?B?N3JZVENQRWJSOTFFcDgvN2xkMG5XOTRaMFpzN2hGUTRzYkhESTA4YjY0ODdV?=
 =?utf-8?B?NlR2cVVQT2lLbE9ISWVtcytJeFJmaG93a2RvVTRzRmV5UXVRakFtRTYwVWhB?=
 =?utf-8?B?RU80aERkOWZZZXpPaUt3a2lGNTZ2MEo1T1dETTVsNFErMGZxNGtwemhYeWpw?=
 =?utf-8?B?TWtvNmg1TlNYcHBURzQ1WTRSMjhIaEUwWmlKVHNqQ2V6d2NvbC9nSmRFTnpt?=
 =?utf-8?B?MkRob1lEem9aSmY0NFZXczVLbzR3MHhmL3BMRVllY254NVhJd3hpcnB0Nzgr?=
 =?utf-8?B?YWZlb2s0YkFiQzJsaFFGMFUzQVFlZi8vaXV2SG5zSHZWNDh0T3ZEMXAxMisy?=
 =?utf-8?Q?Ka8feefIuUBwCkgC3NoPfbUxC?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <53736F06DB1C2543A47B4E7D4FD968DF@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9404.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46cc7eac-7855-4c69-0c46-08dd13743aa0
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Dec 2024 08:26:47.7099
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: euoXCClT9uPwnenTrbaQhowmBcjyJp84ly7QFJFwKqTh4GyYIU7Ksqpf4SIpQcqfougW5iwd3msr3oDOO4sD3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB8431
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241203_002653_143100_0D13763D 
X-CRM114-Status: GOOD (  16.07  )
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

T24gMTIvMi8yNCAyMTozOCwgTmlsYXkgU2hyb2ZmIHdyb3RlOg0KPiBIaXR0aW5nIHRoZSBrZXJu
ZWwgQlVHIGRlcGVuZHMgb24gdGhlIHJhY2UuIEluIHRoZSB0ZXN0IGNhc2UsIHdlIGRpc2FibGUg
dGhlIHRhcmdldCBucw0KPiBhbmQgdGhlbiB3cml0ZSB0byBpdCBhbmQgdGhlcmUncyBhIHRpbWUg
d2luZG93IGJldHdlZW4gImRpc2FibGluZyBucyBhbmQgd3JpdGluZyB0byBpdCIuDQo+IER1cmlu
ZyB0aGlzIHRpbWUgd2luZG93LCBhZnRlciBkaXNhYmxpbmcgbnMgYnV0IGJlZm9yZSB3ZSBhY3R1
YWxseSBiZWdpbiB3cml0aW5nIHRvIGl0LA0KPiBpZiB0aGUgdGFyZ2V0IGNvdWxkIGNsZWFuIHVw
IG5zIGFuZCByZW1vdmUgaXQgZnJvbSBzdWJzeXN0ZW0gWGFycmF5IHRoZW4gd2UgbWF5IG5vdCBo
aXQNCj4gdGhpcyBCVUcuIFNvIEkgcnVuIHRoZSB0ZXN0IGNhc2UgaW4gYSBsb29wIGZvciAxMCB0
aW1lcyBob3BpbmcgdGhhdCB3ZSdkIGhpdCBpdCBhdC1sZWFzdA0KPiBvbmNlLiBIb3dldmVyLCBv
biBteSB0ZXN0IHN5c3RlbSwgSSBjb3VsZCBoaXQgaXQgMi0zIHRpbWVzIGZvciBlYWNoIHJ1biBv
ZiB0aGUgdGVzdC4NCg0KVGhhbmtzIGZvciB0aGUgZXhwbGFuYXRpb24sIGhvd2V2ZXIgd2UgbmVl
ZCBhIHRlc3QgdGhhdCB3aWxsIGhpdCB0aGUgYnVnIA0KMTAwJSBvZiB0aGUNCnRpbWUgYW5kIHdp
bGwgYXZvaWQgZGlmZmVyZW50IGJlaGF2aW9yIHdoZW4gdXNlcnMgcnVuIGl0IG11bHRpcGxlIHRp
bWVzLg0KDQpMdWlzIGhhcyBzaGFyZWQgaGlzIGdlbmVyYWwgZXhwZXJpZW5jZSBydW5uaW5nIGJs
b2NrIHRlc3QgYW5kIGNvbmNsdXNpb24gDQp3YXMgd2UgbmVlZCB0bw0KaGF2ZSB0ZXN0cyB0aGF0
IGFyZSBjb25zaXN0ZW50IGFuZCBub3QgaGF2ZSBkaWZmZXJlbnQgcmVzdWx0cyB3aGVuIA0KZXhl
Y3V0ZWQgbXVsdGlwbGUNCnRpbWVzLiBGcm9tIHRoZSBmZWVkYmFjayB3ZSBnb3Qgd2UgY2FuJ3Qg
cmVhbGx5IGd1YXJhbnRlZSB0aGF0IGV2ZXJ5IA0KdXNlciB3aWxsIGtub3cNCnRoaXMgYW5kIG9y
IGFkanVzdCB0aGUgdGVzdGNhc2UgcnVubmluZyBsb29wIHRvIGhpdCB0aGUgYnVnIGFuZCBydW4g
aXQgDQpmb3IgbXVsdGlwbGUNCnRpbWVzLCB0aGF0IGJyaW5ncyBkb3duIGVmZmVjdGl2ZW5lc3Mg
b2YgdGhlIHRlc3QuIE5vdCBvbmx5IHRoYXQgaXQgYWxzbyANCmJlY29tZXMgcmVhbA0KcHJvYmxl
bSB3aGVuIHRvIGJ1aWxkIGEgQ0kgb24gdGhlIHRvcCBvZiBibGt0ZXN0Lg0KDQpIb3cgYWJvdXQg
d2UgYWRkIGFuIGVycm9yIGluamVjdGlvbiBjb2RlIHNvIGl0IHdpbGwgcHJvbG9uZyB0aGUgcmFj
ZSANCndpbmRvdyBpbiBzdWNoDQphIHdheSBpdCB3aWxsIHN0b3AgdGhlIHRhcmdldCBmcm9tIGNs
ZWFuaW5nIHVwIHRoZSBuYW1lc3BhY2UgYW5kIA0KcmVtb3ZpbmcgaXQgZnJvbQ0KeGFycmF5IHdo
ZW4gZGlzYWJsZSBucyBjb21tYW5kIGlzIGV4ZWN1dGVkIGFuZCB0aGVuIHdyaXRpbmcgdG8gaXQg
PyANCm9mLWNvdXJzZQ0KYmVmb3JlIGRpc2FibGluZyB0aGUgbnMgd2Ugd2lsbCBoYXZlIHRvIGVu
YWJsZSB0aGUgY29ycmVzcG9uZGluZyBlcnJvciANCmluamVjdGlvbiBjb2RlDQpwb3RlbnRpYWxs
eSBzbGVlcC4NCg0KVGhpcyBpcyBndWFyYW50ZWUgdGhhdCB3ZSB3aWxsIGhpcyB0aGUgcmFjZSB3
aW5kb3cgYW5kIG1ha2UgdGhlIHRlc3QgDQplZmZlY3RpdmUgMTAwJQ0Kb2YgdGhlIHRpbWUuDQoN
Ck9yIHRoZXJlIGFueSBvdGhlciBzaW1wbGUgc29sdXRpb24gd2UgY2FuIHRoaW5rIG9mID8NCg0K
LWNrDQoNCg0K

