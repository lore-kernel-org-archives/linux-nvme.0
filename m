Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECE2CD7497A
	for <linux-nvme@archiver.kernel.org>; Wed, 30 Oct 2024 06:36:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hkbIxpUhIRC39LnG+xQoBMV3pVLCmJoJjKSIWIEBfKI=; b=mtA1fsQg1iGJMwmeO+EfIvaeaO
	P9X7tUVgBTkcz7CYTlXS5zetzWeNF/RpFmu+CncTyNe+UJ6r9x70wiEUy72bS7pOj0wuZ33MZ0TDy
	cazzDcCfJ3B5Jfhyf0RfX7Pc4vc6ScYLeB/gD5we875xC0dVhUgxYNqZjrdvx7ztCNtVDZBVkdJR3
	nzsr0uV0b04F5IVAzkIO/IWSyCEiXEf9gO+bnxRUetmyCozxQQx/XW86fypxfp0M9Fcpz/kREPNiz
	WZS0P9GFv9OqxZ2WgQcPI7x/eu6Q2Y3IW2EFGD6wQR8k/AnngIuSQPz0aWALw7LlfvCN4wPYvKJg7
	1V8ANCPw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t62Jx-0000000Gyhg-1gas;
	Wed, 30 Oct 2024 06:36:45 +0000
Received: from mail-mw2nam10on20626.outbound.protection.outlook.com ([2a01:111:f403:2412::626] helo=NAM10-MW2-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t62HR-0000000Gy3a-38bq
	for linux-nvme@lists.infradead.org;
	Wed, 30 Oct 2024 06:34:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bTnhrQqcAwLBXFvm3X1Az11eqFvY+L5qUp3QWdYZ8V7ZDMoBPoZ6rvKEeyvxzCy856aJDe/uIDaaH51WHue3A4Agfgp4L3e32shbmsPyUZbVWOXtGdH7fOYjSKbXt0F5+a3SzRDwfqwzi8NvFizZixxnwPZ9eK2pW4oEWUSoCSMlC8Fn+BY27qz9z9+v+BDnJYyc2SwHIEK7DOkL16XtmSNSJp5yIl7Di7YbrNHWrnGj3h8rYJpmQjUcojBK3vR7kLxOlFRuN3IiQIzrntPLBxzRbQuuJSWrlOCM326XPN4cJB4Dieg1xF7HPLQrMLcU9Z2Ti9lGUzBCmhHY3QzSzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hkbIxpUhIRC39LnG+xQoBMV3pVLCmJoJjKSIWIEBfKI=;
 b=uYDDQ04Kz6TqIOQNJ4eIOuXpyHYaZZnyHb+z1U2MIEz6pbGhw0YkRAGZ3lqGkl+HyVTBizaFSeIWPJgYbWzCP9CFxaPJCNgRPBIBGQXmySya63STXpV8KqWhi1++IvihK5SjM42CtXObM2XWU7mw9QwemcoRtlgJXrNMBOFLle5mBqB3Mo7jyXdBrNZfpfEF9oNuo6KwoADtYYD0tHTm7ByBdNxdZgm14XAYMXKbRlFTS2tCkQB9cO/VieCELHz7ouryIpB8yt4ZwY9XCVd8v6RtqOeFcjufso3maLdH2Y47LRpbFdIwpJChHDwJ+qIQubXNnL3s6w0mmXWBh+yeoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hkbIxpUhIRC39LnG+xQoBMV3pVLCmJoJjKSIWIEBfKI=;
 b=PUHrgAwAP1dHKa+d+IJGFDea/1k0skzhSlLNeMiP0X4SXkWimAATaMUExgXwEIqYmI3F5tDkMcIwyBfzc5hrjuXq6h/LbAAF5XjTh/p+Q04gxNn8OQFaU6I5rZdDIYxSbG2wwH430yachIOYeYScafBSxvl69csRo5qwITgj5tgyUOZsPpGlRSIf2bPKs4wrKrEb9t6t/aiDBlr0niVEAYIhXE5TFze0GJ5euPhsIPn7o5hbx0TDW3LYCKa7ktQuF8Uln+PiMkD81XPe8Z8OPWhlj/1VHcUgZpgUvMAVdXcX+lGsQgvxvHScWROKBZzxfkuxA2QzLBPpfijVqADKuQ==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by SN7PR12MB7418.namprd12.prod.outlook.com (2603:10b6:806:2a5::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.25; Wed, 30 Oct
 2024 06:33:58 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b%5]) with mapi id 15.20.8093.027; Wed, 30 Oct 2024
 06:33:58 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Guixin Liu <kanie@linux.alibaba.com>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"hch@lst.de" <hch@lst.de>, "sagi@grimberg.me" <sagi@grimberg.me>
Subject: Re: [PATCH] nvmet: make nvmet_wq visible in sysfs
Thread-Topic: [PATCH] nvmet: make nvmet_wq visible in sysfs
Thread-Index: AQHbKaTLTwHNqlYqyUSj9qyQvVBFD7KdLMyAgAAcXoCAANuwgIAAYlyAgABQ5gA=
Date: Wed, 30 Oct 2024 06:33:58 +0000
Message-ID: <e666ea1d-2b6b-45dd-8903-2269e2143c95@nvidia.com>
References: <20241029014915.16646-1-kanie@linux.alibaba.com>
 <8b4591d7-f0bd-4e4c-b1b3-1b375f25bda0@nvidia.com>
 <0e90730a-74c0-401a-82bd-92fdbcd2cbe0@linux.alibaba.com>
 <1c6e0bfe-f476-4c07-a67c-b526b325b405@nvidia.com>
 <a6718c68-6b0e-4a5e-af3a-c8ee98911ce3@linux.alibaba.com>
In-Reply-To: <a6718c68-6b0e-4a5e-af3a-c8ee98911ce3@linux.alibaba.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|SN7PR12MB7418:EE_
x-ms-office365-filtering-correlation-id: 577ee133-afe2-4017-e1f9-08dcf8acd5f7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?TXRTMG9LZ1JWT0c1NFFDLzNCRldFVHB2cWtqR2s5WHF5b2pqRE5hY1N6bm40?=
 =?utf-8?B?aUR5SlVpcXEzcU0xNUphTUVEWTRWK0toczdiZXZNOWFBVm1ERGZMOUFGSzhK?=
 =?utf-8?B?bzJDUFcwZFU0V2J2MTVwSmdsUGFQTytJM3RrY0F0T1EvbXZxb013ZnZvSW4y?=
 =?utf-8?B?ZUF3bitUcDUwRDFvdGNIbjdML0V5dTc0QzJ6SjIxRUNDNnpkdTRXVHoxY25m?=
 =?utf-8?B?UWE2bWM5VjBPNWRPb0diUThDQStyUVBxa3lPOEZmbGZ6QlVET3U5VUsvZ2Ni?=
 =?utf-8?B?VUZCZmZvSlF2RXdOYW9pdGtxR1I3SkJPeFZjQkt2Q3lvWXNpSUJRSiswOXVz?=
 =?utf-8?B?bVJ2WjI4ajdXcnVlQVJQMXJBS1A2dXppL0VXclZ4clA5S1VSV1hMQkU2TXEx?=
 =?utf-8?B?dStycm53UlBYSGFZRk1semU3dm5WazN6NmNQeSs3WXBoVXVqWnlLYVduRURn?=
 =?utf-8?B?SUtjcmI5WVRZcExERmsxbC9vOThGZjVhMS94OWN0dXEvcFZYeUk2Rms1U3NN?=
 =?utf-8?B?V01ONDUrcEVQTGlMTEE5bC9NZjBFSC9VR3J6VXJZMXRSWEFlRGxCc0t2UzV4?=
 =?utf-8?B?eVFDb2VHdEJmL01PZE9WOU9ya3d6Z0ZqUm1hTWVSUk11bGt1TTZ1NjJUQmw2?=
 =?utf-8?B?czd5RE94RzQ2Y2h3eGN4dHZJeFJHdW5ZZGlxWXNsTzFkRlVobklMOTNHSnVX?=
 =?utf-8?B?TnYxc1NCNStKU1gwdXlNOVhQem9XWTVFalFySUdmM28yNHpNZEhWUDI4cVY0?=
 =?utf-8?B?T25MVlNKZk01ZUlxQTJEQ0Zob1lOK3hsczRicklrUURSMlo0NkxjNVJIaFBM?=
 =?utf-8?B?d0dUYjd6RnVTZFVOWmRCMERzMUg3djhFZXRMUzZuZVhqNWRtb2hBVEVLUExL?=
 =?utf-8?B?UXlIZTFwYlFESFpOKzh0cVl5QW51WjRaUTVMU2R4bjNjNGxEbjY5RXBxNVl2?=
 =?utf-8?B?ZTFtOGtaaVNjRnJTUDFYRGRwY29wWEpiaXVvL2NPeW5xTFVCaWM1YTExSHZJ?=
 =?utf-8?B?QzdoNkR2aUY1bWliUVFmUW5WVzhyRC9malc1NWdGYlUzOFVHbGl3RU81MitX?=
 =?utf-8?B?azNwS3p6VGtQbkZ2d3ZOVmdIQ0tJTkZ3TWRyTXZGTStNU05sck92ZzdhcEU4?=
 =?utf-8?B?RXVrb0FxRnVha3ZVUFNiWG1XNkdId3B5aVB5VDE0NFdCelFWL3FjNktCSHFT?=
 =?utf-8?B?QTA0VlBwOXNWOGVQOGlGaVZ6MVBhT3RxVFVpTmRpdmZnVVF1dFZjZ285YVB4?=
 =?utf-8?B?RS9rMkxwMCtkVzA1V2FzbmtoNkdidldETXA2NE1SYWF6U1g3dDN5YUVOU2h3?=
 =?utf-8?B?RldWT0Y4QUg0eHV5YnB2QndmTFFRK245WXNwa25VQU1EblFOblNwc3o3OVAw?=
 =?utf-8?B?bkJTSURtdDVjQzFCYVBQMzFMREFNQ3NOSUF1VndJd3p3UGlEMFJXLzltN3VK?=
 =?utf-8?B?Yys0QTBlVUF4WkZaOG5sc3BrZ0pWSWw0d0EwQjdmRkpDcWpKQmhFV0s4YlJz?=
 =?utf-8?B?YVF0T2VLSEw3TnJPR1BicldxQ0V1OGdpem9RYnZZNEtqd0R5MjEzaWVwcWRW?=
 =?utf-8?B?aktQNmVUVVVHNU1zT1RSNkl0b0xRb09rQ3pIZEltTkFzK3R1Q2hUTW9TaFU0?=
 =?utf-8?B?eWpzMnVQaVFQdEZibGR6M3cyZU1TYUhWZmYxWk9RU2QySHYrYXRnWXg2SlNv?=
 =?utf-8?B?bW1WaWdjdnNRbUJqWnhvdjZmbGdkQS9XcWhhbVM1dnpQL0lSVHZhRFg2Mzh1?=
 =?utf-8?B?cmNKTVBuY0p2eDRFME1rMmVxSVNhZHVZVW9sR3YxNGFZSHZrcUswR2Q1QStT?=
 =?utf-8?Q?m24rVcH9aKWX02677sbwQS/4l965ZC014zVZU=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?K1lvRW5xam0zUkRkV3JqQzNpclNGNCtEN3daSDZNclZTN0F0TjhhMjRrOHdT?=
 =?utf-8?B?dTRsRnNjV2dQK2lwLzRSZjRDcUFWdHMrOER4Ny96Zkx1L0RZcGZKeVhiaFhv?=
 =?utf-8?B?enZvb3h6TkJEYTlUMGpLRThOSElEdExRbDk2V1RTZXpJbWhMQmY5YlJUQy9p?=
 =?utf-8?B?YWNqdm52TmtneXRLaG5JTTBwY3ZiV3B5eXN1Znc5UFBtZzNYdDM5MmJVN0dn?=
 =?utf-8?B?WnRsSHpFa3MwS3NINFZRSVp5M1FhUTkvOVZ0em5SbU9kZk5TcnliVENySGNr?=
 =?utf-8?B?TTZPWFZpcHc2Qm5xaUtqWlMza0gvTVhFRzdBSVM4M0Q4VjhodXNYakg2RjFj?=
 =?utf-8?B?WmtXcmtYdU1Ga0lJTE1vK01KL1pqdko3dndVby9DczhPSEhGY0s2R2NQaEMx?=
 =?utf-8?B?UEE0STNiR1RVRit4OEduRmp3dnIxN1grNjhRSkJWVnVTVXFNYUNiUHJOU2JP?=
 =?utf-8?B?dG9KQU5nVUVMa01mRHgvSFBvdGRjU0JLMlpCMTEwakxDRnFMQWJtWkc2SVNi?=
 =?utf-8?B?UzlDbFRQMW1yUWhuRmM0cFBFY0pCbmVtcmZIeTlRZHZEb3NDdHJrcFVEb0NP?=
 =?utf-8?B?d1R2b3RCVjNLZGxWWGM5WDlyZVdLR2xrU05vRlYzWDZnaldScEhZK0JVRUdt?=
 =?utf-8?B?SUVUSVQ5QTJYOFVLaXM1Nk44cmJQc0ZCNUZiM25EbEV5SEtFNitkV3Z0ajJ2?=
 =?utf-8?B?RFZLcm5wVjVBYmN3Y1dXR3RKWW12amk4Q2lWZlMvYTZDTURORnU0enJsaU1p?=
 =?utf-8?B?TFJGRjYyM0YyM25URTJrTjZpdHNncFZ0STV2RS9xdzlPQWw3cThObHY5K0VL?=
 =?utf-8?B?ZnNLL3RBeFArUE5EbzlqQUFiaWlKWlgzeDNwbmZDVW5LWGFZWWNpWS8xSlF1?=
 =?utf-8?B?bUdBNkkyT1hYNXkrSEpqKytyUlZDWXB6cmRoS0VzOG5YZHU2ZlIyZlFwekc4?=
 =?utf-8?B?ME9QeGMvcmpsUTh6NlFzaEltTVZDUEQvV2t5cG5NMXExbEd4TExUcisvd1Fz?=
 =?utf-8?B?MTBuclRRRU9RU3pUVmFxTkdEZ0FWU0xrZmpUclJJUkFiUS8zR1N5TWhEUW1Z?=
 =?utf-8?B?UVdrM3k3Sy9GNjRKbmwyM2hTY3orWVZjY21kekVyNkNZRVNqTldHR2hXeDlP?=
 =?utf-8?B?YnFuZmlUUCtnVG5VV2VxN1d2L2VGRGl0ZTVPUjlKajVGYmRuQlZaLzRMMG5I?=
 =?utf-8?B?Z0VPdFdBNGhZZ2lzdjh1bFFqTmtPSlZKMlZLcnA3Y0phTWxzcC9FVHFSTlFV?=
 =?utf-8?B?R3ZpckVFUkRCUTRjbjJ0d3JHRDFRYXBXRWFwcXhyRmMyRWx3VHo5Vm81eXRW?=
 =?utf-8?B?UU9KT2R4YjM1dEVDbzVvKy9ycGlMZUxtbk1WVGdKZ3FvVGFLdDhPMGpTcDdR?=
 =?utf-8?B?Q0dCRDIzaWVUNkFHT1EvUmVrbURGT05pbk5hNnlzN09EbGl5eXdGdjRzNk02?=
 =?utf-8?B?OFNBMFd6eVNQbmhUN2x5MjFoVCtpeG8xS2xaNzFDTjJaM2JtSEV0cHNFbVdk?=
 =?utf-8?B?Nng0c1VTdlEwMjd2aWNMN2VEYU5QM2VzMXpSY2VWVnJNVlAyT2NSSUloR0lE?=
 =?utf-8?B?QVdWSkpJODQrK3JEUXNVdU5acXRuRHBWcm5mV25lUXdhYVJyaGFibUxRcCtW?=
 =?utf-8?B?L1h0SklGM1lKTEJlR2hjbWd2TEJydTdTUVZyd1daVG44TXNGVm9GRllhWFlw?=
 =?utf-8?B?Mzg5Ky9mNjhoakRZUFJjSElQWnpjS2grS2dOdm5MUHBIeEZoc2dLM3U4dU5N?=
 =?utf-8?B?T2prdlZxODhOUm0raGJyRTBBazFQY0pJYVpOWkhtZVFxT0ZDdURwQ0hjTS9K?=
 =?utf-8?B?SVkxc2V6QlBkMTR5bU80ME5IMGF0d1BlRmVuR2xUS0FIa2lpV0JTRTRZbHNm?=
 =?utf-8?B?QXY1UEp4eTZOTW44VlFSdXZuejlvQjllT0h1aGFFQ3VzcENTK2RTSWpZc3Rz?=
 =?utf-8?B?bnMvb2s4UlJhbmxWWkdnWllUaXVzbVlEU200UzY4Ky9SQU1TOFRtcFBKK25B?=
 =?utf-8?B?UVJuRGx3TEZMVnZsdzFqZ3pIbHNpRzNUeW5INW5NdE5jNFQ3T292TEVkNFFu?=
 =?utf-8?B?MWorcnZlRVNKeFBsZXlmT00zcms3UlFObXdIT2N3QTc4N29KL1doeXUwUzJB?=
 =?utf-8?Q?O2eGbL1IzNyfE46441dwiVFTA?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <30C99B4C5DCAA740A3AC6D1BDFE6E818@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9404.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 577ee133-afe2-4017-e1f9-08dcf8acd5f7
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Oct 2024 06:33:58.7254
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ve6TkhIZ7CCcBjV7eUIkMx8NFsKj5uVoB3F9q6n+ookw2/Lwa5WSd63QnNN+P1Nk2z297eROWLIn8tAW/L26JQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7418
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241029_233409_817779_24ECB936 
X-CRM114-Status: GOOD (  19.83  )
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

T24gMTAvMjkvMjQgMTg6NDQsIEd1aXhpbiBMaXUgd3JvdGU6DQo+DQo+IOWcqCAyMDI0LzEwLzMw
IDAzOjUyLCBDaGFpdGFueWEgS3Vsa2Fybmkg5YaZ6YGTOg0KPj4gT24gMTAvMjgvMjQgMjM6NDYs
IEd1aXhpbiBMaXUgd3JvdGU6DQo+Pj4g5ZyoIDIwMjQvMTAvMjkgMTM6MDQsIENoYWl0YW55YSBL
dWxrYXJuaSDlhpnpgZM6DQo+Pj4+IE9uIDEwLzI4LzI0IDE4OjQ5LCBHdWl4aW4gTGl1IHdyb3Rl
Og0KPj4+Pj4gTWFrZSBudm1ldF93cSB2aXNpYmxlIGluIHN5c2ZzLCBhbGxvd2luZyBmb3IgdHVu
aW5nIHRoZSBpdCdzIGF0dHINCj4+Pj4+IHRocm91Z2ggc3lzZnMuDQo+Pj4+Pg0KPj4+Pj4gU2ln
bmVkLW9mZi1ieTogR3VpeGluIExpdTxrYW5pZUBsaW51eC5hbGliYWJhLmNvbT4NCj4+Pj4+IC0t
LQ0KPj4+PiBkbyB5b3UgaGFwcGVuZWQgaGF2ZSBhIHVzZWNhc2UgZm9yIHRoaXM/DQo+Pj4+DQo+
Pj4+IC1jaw0KPj4+IFNvbWV0aW1lcywgaW4gb3JkZXIgdG8gcmVzcG9uZCBwcm9tcHRseSB0byBj
ZXJ0YWluIGV2ZW50cyBvcg0KPj4+DQo+Pj4gbWFuYWdlIGNvbW1hbmRzLCB3ZSBuZWVkIHRvIHJl
c2VydmUgcmVzb3VyY2VzIGFuZCBwYXJ0aXRpb24NCj4+Pg0KPj4+IHRoZSBDUFUgY29yZXMuIEZv
ciBleGFtcGxlLCBpZiB0aGVyZSBhcmUgNCBjb3JlcyBhdmFpbGFibGUsDQo+Pj4NCj4+PiB3ZSBj
YW4gaW5pdGlhbGx5IGFsbG9jYXRlIHRoZW0gYnkgZGVkaWNhdGluZyBvbmUgY29yZSBmb3INCj4+
Pg0KPj4+IG1hbmFnZW1lbnQgd2hpbGUgdGhlIHJlbWFpbmluZyAzIGNvcmVzIGFyZSBzcGVjaWZp
Y2FsbHkgZm9yIGhhbmRsaW5nIA0KPj4+IElPLg0KPj4+DQo+Pj4gQmVzdCBSZWdhcmRzLA0KPj4+
DQo+Pj4gR3VpeGluIExpdQ0KPj4+DQo+PiBJJ20gYXdhcmUgb2YgZXhwb3NpbmcgdHVuYWJsZXMg
dGhyb3VnaCBzeXNmcyBhbmQgaXQncyBiZW5lZml0cywgbXkgDQo+PiBxdWVzdGlvbg0KPj4gd2Fz
IGRvIHlvdSBoYXZlIGEgc2V0dXAgd2hlcmUgdGhpcyBzZXR0aW5nIGlzIG5lZWRlZCBjdXJyZW50
bHkgPw0KPj4NCj4+IEkndmUgYWx3YXlzIGJlZW4gYXNrZWQgdG8gZm9yIHRoZSB1c2VjYXNlIG9u
IGEgcGF0Y2ggd2hlbiB3ZSBleHBvc2UNCj4+IHNvbWV0aGluZw0KPj4gb3V0IG9mIGtlcm5lbCB0
aGF0IGlzIHNvbHZpbmcgdGhlIHByb2JsZW0gaW4gdGhlIGRlcGxveW1lbnQgLi4uDQo+Pg0KPj4g
LWNrDQo+DQo+IEkgbmVlZCBzZXJ2ZXJ2ZSBzb21lIGNwdSBjb3JlIHRvIGRvIG90aGVyIHRoaW5n
cywgc3VjaCBhcyBoYW5kbGUgZXZlbnRzDQo+DQo+IGFuZCBtYW5hZ2VtZW50cywgc28gdGhhdCB0
aGUgbnZtZXRfd3EgY2FuJ3QgcnVubmluZyBvbiBhbGwgY3B1IGNvcmVzLA0KPg0KPiBjdXJyZW50
bHksIEkgcmVzdHJpY3QgaXQgYnkgc2V0dGluZyB0aGUgY3B1bWFzayBvZiBudm1ldF93ce+8iHRo
YXQncyB3aHkNCj4NCj4gSSBleHBvc2UgbnZtZXRfd3EgdG8gc3lzZnPvvIkuDQo+DQo+IEJlc3Qg
UmVnYXJkcywNCj4NCj4gR3VpeGluIExpdQ0KPg0KPj4NCg0KQ2FuIHlvdSBwbGVhc2UgZXhwbGFp
biB5b3VyIHNldHVwID8gZS5nLiB0cmFuc3BvcnQgdGNwL3JkbWEvZmMsIGRldmljZQ0KYmFja2Vu
ZCBmaWxlL2Jsb2NrIGV0YyA/DQoNCnNvIG52bWV0X3dxJ3MgQ1BVIGNvbnN1bXB0aW9uIGlzIHNv
IGhpZ2gsIHRoYXQgaXQgZG9lc24ndCBoYXZlIGJhbmR3aWR0aA0KdG8gaGFuZGxlIGV2ZW50cyBh
bmQgbWFuYWdlbWVudHMgPw0KDQpDYW4geW91IHBsZWFzZSBleHBsYWluIHRoZSB3b3JrbG9hZCBh
bmQgd2hhdCBraW5kIG9mIGV2ZW50cyBhbmQgbWFuYWdlbWVudHMNCmhhbmRsaW5nIGlzIG5lZWRl
ZCB3aGVyZSB5b3UgbmVlZCB0byByZXN0cmljdCB0aGUgbnZtZXRfd3Egd2l0aCBDUFVNQVNLID8N
Cg0KVGhlIG9ubHkgcmVhc29uIEknbSBhc2tpbmcgdGhhdCBJJ3ZlIG5vdCBzZWVuIHRoaXMgc2Nl
bmFyaW8gc28gZmFyIGluIA0KdGhlIG1hbnkNCm1hbnkgZGVwbG95bWVudHMgc2luY2Ugd2UndmUg
YWRkZWQgdGhlIG52bWV0X3dxIGFuZCBJJ2QgcmVhbGx5IGxpa2UgdG8gbGVhcm4NCmFib3V0IHNj
ZW5hcmlvLg0KDQotY2sNCg0KDQo=

