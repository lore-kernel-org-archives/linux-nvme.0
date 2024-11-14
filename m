Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C42B1D65C79
	for <linux-nvme@archiver.kernel.org>; Thu, 14 Nov 2024 11:44:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=auF43iOWRBtFpfwWxWXQL5nDD5Ex1DXqkTCS986t/JA=; b=js5AWomfooaNLqLF/EPZro0uDR
	dW5BsSHnSjMAvoaSXlUWKNIYCMTW7pl9dzrgLW/uc3QVVnPUfBWgaqhkHPc6f8qS01+De4c0Zgyrr
	nIezI0nYpjz5ogBI+qTIMnSBYNr5B+hpWok/jLVMg8gFJcy5cRnIu/naZVJcs0XW8Y7DAPFaKVFLK
	H2bxTFyc2KV8pfqmNcY2DTbxuxpIr5CkQl570Gc8/GY8x52ToLtS9NyOp5bGAyYEVKKaxmVzg82IZ
	ltQ+8ZcOZMMvNTAFRqlkw9cgQtPqwOpXcxCmREsuZDea4ZFUazRfoRjQvmkomnG1RQqnElbBhTL6I
	Ym1CeUTg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tBYGd-00000009lr7-2T4i;
	Thu, 14 Nov 2024 11:44:07 +0000
Received: from mail-bn7nam10on20626.outbound.protection.outlook.com ([2a01:111:f403:2009::626] helo=NAM10-BN7-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tBXTJ-00000009cTM-1ALa
	for linux-nvme@lists.infradead.org;
	Thu, 14 Nov 2024 10:53:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pJn2qhxEstMQzty4D4oBn1kqnOnVC55f+CtKombu7tTk+jnsW60DvvveYfIdRT0FIT2a25CtdbLT+rMCaKsN4muCMGns5FR8skDNQCaXgbf5bNE3OxqG1xFvLLYkeexRtRvLW0ctBFfNx18YRKXgoP1J/wiWaiKiIjTUHxF4FCPd9ZnfEc3Cj8498t/14lFjMeFnJoqbaO9f2/AyrGxrm2x3zxZTDDUP+0OMEyjuqkQJvxLhS+54O4VYjEsuMkEb6DJsN6EL0Utx/fveY0fejrYUplG8sD1G0QRIrMJvtoL/+YInK8IepnwYsv3rMbNF8NJzeouiipnNUKvKYx66MA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=auF43iOWRBtFpfwWxWXQL5nDD5Ex1DXqkTCS986t/JA=;
 b=ZxVpYIUjPhKOH6FFG+5T2SX/k/oLDE9U7aM/v0p4Vio5H1S7KX9tIaG6Di/G8UDtLAVMgeKs7VEYWclxCvKXo2Yw4gsLtoZjrT2ngnjdIGLaOHbgYSA/D4chbOv08rvyiRuh1rh4KjfajSoVkzzBcI/Xw+EcHpXaeKch5W0do3RunFs6MpsIO52UicAhJp56xypg0jRu8m4W+onlzP05CvwCEHpOcYdPKyQqtArtP3hKr/t40MhVzbEsDHt0eTgRp1yymDvHbrVQ3Vu81ISaSAHXiFHDvwswzj5DYyC08tRYIdfc31RE5Ygn/QJ7TUn90bTeoBLSLVODU9PlQbxcuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=auF43iOWRBtFpfwWxWXQL5nDD5Ex1DXqkTCS986t/JA=;
 b=aJP6xxeFJux+t02+elGVvDJP5lLuQXYugBY8tzmk5vzommSTingbs8Ryz4wC9C5WbpLoPPpogR1TvM5c9XaTptAknfqUkRr99q8CsJt75mFkYPl7wHpWWpMUonrzzxVWXfA/NyK5BTO2nmrk8rMosnHZu6i9YU6zLC0wwF1pDcGZFcrt58c5eXHTduKHYnQBl2r6O+TZ6LPy5gXCtXZxV9uJSbFiQFEqc1o01JYWjE0aaBEnSNy3t4icgnLxwLM72dUoAScPPNRAoxx8Ryo94YnFnMPbpyZY2y+MCT1IZsMcNKuZlC0TeMyeKnSxXaE/AXAPK2XBZD/sBk6d9e33kg==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by CH3PR12MB9080.namprd12.prod.outlook.com (2603:10b6:610:1a7::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.18; Thu, 14 Nov
 2024 10:53:03 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b%5]) with mapi id 15.20.8137.021; Thu, 14 Nov 2024
 10:53:03 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Guixin Liu <kanie@linux.alibaba.com>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, Keith
 Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, Christoph Hellwig
	<hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH RESEND v3 1/2] nvme-multipath: introduce service-time
 iopolicy
Thread-Topic: [PATCH RESEND v3 1/2] nvme-multipath: introduce service-time
 iopolicy
Thread-Index: AQHbNnJOaXLn10t4REOJ0m84I36KuLK2mdyA
Date: Thu, 14 Nov 2024 10:53:03 +0000
Message-ID: <b28f56ff-02ba-4fa0-9ee3-329fadac9997@nvidia.com>
References: <20241114084957.41787-1-kanie@linux.alibaba.com>
 <20241114084957.41787-2-kanie@linux.alibaba.com>
In-Reply-To: <20241114084957.41787-2-kanie@linux.alibaba.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|CH3PR12MB9080:EE_
x-ms-office365-filtering-correlation-id: 5bed485a-bd1f-447b-3b75-08dd049a838c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|10070799003|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?VTdrNWFHaXoxV09pbklZYk5HaktKaFpaTG5UY3Rhc3hvOEZlZEdJTXR2Nkph?=
 =?utf-8?B?cCt0eUJ4QWZEbjNMaEZ6Ynh4aUh1VjlUbFMvQWhPZFFJK2kyT3Rmaytab1N2?=
 =?utf-8?B?QUEycURUVEl6QndyRkZjdHpZMG5TYjMyTllaMm5FcG1CRFBOVVFIdHFvcEhM?=
 =?utf-8?B?ZER3d0tRaFRTMUZLV0FEWG8xRG5Tak92Zld6ZVlGSkpsMkliVVFRcXE5SEpQ?=
 =?utf-8?B?TllHNkkyVHZDSDN3Z2VBWHBycUR3ZG4wbHkyT0diVUU3Zi90Ti9IMkdzTmdM?=
 =?utf-8?B?NTJuSU1RVG5nM1QwUVRBdEo4cm12UmlScFBtdGhkZjVPM0FzQjZYL0cxQW9v?=
 =?utf-8?B?ZlJveUpOb003QnowbXF5T0JEUy9iWFBLOE9sZnJ5aklXa05VVzhJUm9ndDdN?=
 =?utf-8?B?L1pjcFBNUUNhV3VFL2JMcVAzdzU3ZjliTTlEQ0M0aHR3bGtKWTF4TDJJdlVz?=
 =?utf-8?B?NmFLeXlka3F6R1NzSzdhVTd4cGhsaWN1aDJtT20xTWNwRG5uckc1RTNTVDl6?=
 =?utf-8?B?dGpRMFFkRmxxTWYvendtdFhIR29FbHZNL1F4VGFKSExBQ0JnWWNlUVBKV2dH?=
 =?utf-8?B?RkVnL3Y1ZWoxYTI5c1FmbVRkcEtKM3VTZ1NQTmZ0dmhYc3BOdG51RnlqaWlS?=
 =?utf-8?B?SHFCV1V0RzJ4U2FCSUg1MGpRQlRWUEkwb21seS8wLzgrcE1KQWhhb3lzN2ww?=
 =?utf-8?B?SlVwVksvdi9zNVNCTS9pM01IYUFNUm9lZ3VFdUFKa3N3anc5V25aSndwd0NJ?=
 =?utf-8?B?QytlN0JzMTRnVkROemprMDhnQ21tR2MzL1oySjY4ZWpkdGhUL0VWT3pXY0ZO?=
 =?utf-8?B?a0UrMUVtOFV1UTVmcmR2dUpmQkM0L005c0xJbmYxN0NWN0JUUEFJUW1sMHlO?=
 =?utf-8?B?eXZKejVNMUIwb2laUTdIQXN5UWM2SDQ1eXdxY0xIb0puMHVkemlsTitxZ05F?=
 =?utf-8?B?SUpSRlpFc3NPTzFQUDduM1d4cU5JM1hwcGV1UzJBU2tWSHVRUENjM3lYOGVN?=
 =?utf-8?B?eXJtcUo0TzRNMmNQSE5LaVQwUFVMUlYyVWZjRlVESXN1N25seUNRdG5WSkZz?=
 =?utf-8?B?M1ltV21GeHRmWC9PV1lZQ1pDN3Bxb1pxOXZGSU05WjJ4ckdFeUJ6aDlQZEli?=
 =?utf-8?B?OFpzSlJBVENPejVrNzA2QTNQeEx3RGZkek4wNTlDRTQwTllwTzZySk52WU9t?=
 =?utf-8?B?aW55b05zNnd5T1FOYXcrOFFWdnRWakdNenJVYUlkRERydFNlcFNDTEwyK1JQ?=
 =?utf-8?B?RCswbE5wRnd3NktBeXJ3dGlJZjJhaDNZOFdnaUJpUXZUclE2azA2M24zRDF4?=
 =?utf-8?B?SnhHWkRYNlNwdFl1Umg1VnQvbnBzQ0FJZGVIQys2dEw0S3VweVZVMTc4Q1kx?=
 =?utf-8?B?Q3NjUFlVczVTdlRyZVBRYTMreTNlazJYUjExNGJCNmxyS0IxOTJWNGxKQ1d2?=
 =?utf-8?B?UlhvWS9QckRwUERBUURjQTEyaWR5QmNJRGxTdmo2TE9SelJ4SWdKTEwzWUZT?=
 =?utf-8?B?bnpwT3haUGE1NURLNVJtUlYrMnNWSWZvUUg2TEoxbkpsMU8vaDFlMWpsZkQ5?=
 =?utf-8?B?K1dGVWkrZFlMUzJ3dXRqT2t2Ym16alJZRjNrdlV3WFJxNXN4MWJMTGhSaUZN?=
 =?utf-8?B?V0dEK3BtTkdHSitGQUhoUVprOE5Bc29oa0R3dVdYOWdjZVpqbCswU1V0SFFa?=
 =?utf-8?B?MXZRQmxBek1wckxTNDc0L0hnRFhLRFF6TjVyaDEwVkFxUUVidkNxYUsyQmdp?=
 =?utf-8?B?V1ZlbHh2R20rS3V2M3dnS1drTGN2aFBJN2ErUXpoNGVLWDZET1V2OS84M0ND?=
 =?utf-8?Q?sQXNXShuJNFRIWgQCVEspWnrSaygGfCBNQb4E=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MEJ3M3daTExVQ3FsRStIYmxBeDB2MUdpMFZQVkhxYlpJMlZLSU9ycVhyZTRp?=
 =?utf-8?B?VXRsV0lPdmplTkMxdkJaR3FZNzlXTG92T3lEdVpjMjdYdlNWTzRWeVVKL2Jo?=
 =?utf-8?B?MUNMTWZDZTZucVczaHVhOW96YThFU2RkaVBlRXNSRHB0R253TmRPMSs5Szc1?=
 =?utf-8?B?NkkwTk5rWDJ1THNDdVk1VDM2ZEhyT1dFaVlOVjg1Y0N2QTVHTk5zMWFSang0?=
 =?utf-8?B?cXFGK3lCWEpjNndVZlBrRUl6M2JWVHhHQUpiUnlVdDROcFUrZWtFR0xsN2k1?=
 =?utf-8?B?OXJXTjZyR0U3VXJYQlVEM2dwUzRSTlloVXZGRGgrZE9xbW1wTG9sd04veEw4?=
 =?utf-8?B?WlJnZXdOVlBtWEZSMmQ5dXhTd3NKRkljdE85cHlReXo2bXRjd0ZuSjNsRTJV?=
 =?utf-8?B?djk4blJVaXk3amp0MG9wSUJOZUY2RFo2VkJZclJ4SllOc3M0MElOcVRzdWoy?=
 =?utf-8?B?MXVxbTJBTUJhOFFBS284NWRTem5aSkFkdS9zTmtLeURNR2ZKM21rQWo1T1Fp?=
 =?utf-8?B?c0pTR25nci9IZVNnbzBhcW4wR1Y3UE5OMmhQRTZBOUQxMnNZZHM5WTMzeG0y?=
 =?utf-8?B?b1FsYnB5ODdrS2I5aTcrRjQ1S21oYnhzeVlIV21FdHIvZnF0V1k4ek9HdWMz?=
 =?utf-8?B?OGxoL1RUbjdkeUF2RHB5cXBFaHFHKzMzUkxVcXhENkFJVjFhVGtJcE9CakJB?=
 =?utf-8?B?NWVrdnkyWU0zL0x3Wnpnc201b3Bub3N4VXhBR2Y2SkVFMGtrbzZMd3R5M3kv?=
 =?utf-8?B?WmNNQVVkZTdwbUR1VjEvN0JBMmpnYVJxdnRla2sxUWdBM2lvcTdFR0E3R3FL?=
 =?utf-8?B?cFdHQVBPV0NOQlRockhoMUZhbmlVbHFqQWFsekFieTdlWlRObjRCekNTM043?=
 =?utf-8?B?WGx0UjBYLzU3SGVkNXhSVkZZUnpiT3FUMGtFOUNGZmhJaVROTWFQM01PV0wv?=
 =?utf-8?B?OFIyTjlob2NsbVJPdGJuOWJKTlNrMnN0NkRkNmZKaWcwRDVDU05rcWZ0SXlD?=
 =?utf-8?B?bzlFNElJL2xkMkxraE8vYjc4YnpaeC9ZYWh2ajlqbXRRcnpPZnkrYjQzNnBT?=
 =?utf-8?B?ZnhkT0t3YklUcDQ0L09NTVE0T3JHeVhLT2NZQ0dSQitDd0MwdkVzRE9mQkZh?=
 =?utf-8?B?dTVWUlBQK1hyODBwTXYrOWRJV1R0ZllSamY3dCthRUNGNjkxSlRnMmp1anJX?=
 =?utf-8?B?dVptQ3lMeFF4dTJzV1IzcHNsd3FndEp2c2kvNy8zVlllKzM5b244OS8rY2xz?=
 =?utf-8?B?WlNFUFVNTkd1SkRkRkhlZnNsYWQ4TExlTTQvYTZJZW1Gdmd6Vm55eUJEUHFj?=
 =?utf-8?B?dHZidjN1SGdHSUlYdENuWHhGREFsSStraVdtR0ZUOFowY2xVcUNTRDRkSnB6?=
 =?utf-8?B?Vjh0Uk5jcWJwVXJSaWt5aW8rWGdNOWNWRTEzdnVMTldZZU1aT3hvZUxmMkFT?=
 =?utf-8?B?ejdyRXBlTTJMaE9OaUxtUXc1RXV6YlJLMHU2ZytoWklMY3NHOFV4ZW81SjdV?=
 =?utf-8?B?VXViUDJqUFhscXRQM0ZoVGZ5eVpjaGtPVEV3U0dEWnQ0WVVINHkwNks5dGpO?=
 =?utf-8?B?UFRZcTVMVHhaZFd6cXlaclJtT1hLb1VueFRrOFhMZG1KL05JSXNQWXV1VHRo?=
 =?utf-8?B?aHJEYXZMZFZQOUU2bEF1SGdQQjZVTzJJWE4wQWZGcEpaMENBTFd6RHZ5cFVt?=
 =?utf-8?B?cUw5eU9RTW9JUGVuSWVFcnBoMlhmZElFL3UyZDVFc2ZtMU1NK0l1TU14UHE1?=
 =?utf-8?B?dk15djJKL3hRU1NyV2VOOFJ6U0MrLzZkYVJtQ2JrQTZFdnl3bVRGZHNaWHFC?=
 =?utf-8?B?R01WTThkUlV0aVRqTE1aT041WVltcURPSmpUTGM5Wjc3SVVETW55eDVwN1Vv?=
 =?utf-8?B?QWp3OEprZHYrdTNlbGZaZkljb3FpTmFYNTNJNUl1Sk9lcjltbkwyRmZZTy9q?=
 =?utf-8?B?Ri90ZGEzd3A1UEVISlBENjE4TGRDQThpdnRGWmlkS1V2ZG93a1ZOWmlZTGI2?=
 =?utf-8?B?OHRxQ2NxV09DUE9RQS9KT1d5cmtQbFRZUGlGNWJjNDlVSVRRQWNqTTU1R0Zm?=
 =?utf-8?B?M1NwOTFJUHBxVWdnZFBXV2hwdGFsUUxrV1puNFFLSXNOQjlETSs5NzNCMEFZ?=
 =?utf-8?B?dDdDb3I5SGN5cFVCM1lXd0F3dEhnVFhnNUUwek16NWErYlUxeE84eXVVUysz?=
 =?utf-8?Q?2S5nQ6Qf8r/ytJONKPW+GpwBM0xIWPI8oRyuZIRveZGe?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DDB23A26221BBF4EB1B8562329AA26F4@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9404.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5bed485a-bd1f-447b-3b75-08dd049a838c
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Nov 2024 10:53:03.4475
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kg27bFi0V19ozKjbmwy1iry/hJW6PnaapInACh81s39bL96V/x0hBuD6OfcpMs2AAVCccIGRpQSyaBUXKxUXkw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9080
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241114_025309_354871_B0222646 
X-CRM114-Status: GOOD (  11.50  )
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

T24gMTEvMTQvMjQgMDA6NDksIEd1aXhpbiBMaXUgd3JvdGU6DQo+ICAgDQo+ICtzdGF0aWMgc3Ry
dWN0IG52bWVfbnMgKm52bWVfc2VydmljZV90aW1lX3BhdGgoc3RydWN0IG52bWVfbnNfaGVhZCAq
aGVhZCkNCj4gK3sNCj4gKwlzdHJ1Y3QgbnZtZV9ucyAqb3B0ID0gTlVMTCwgKm5vbm9wdCA9IE5V
TEwsICpuczsNCj4gKwl1bnNpZ25lZCBpbnQgbWluX2luZmxpZ2h0X25vbm9wdCA9IFVJTlRfTUFY
Ow0KPiArCXVuc2lnbmVkIGludCBtaW5faW5mbGlnaHRfb3B0ID0gVUlOVF9NQVg7DQo+ICsJdW5z
aWduZWQgaW50IGluZmxpZ2h0Ow0KPiArDQo+ICsJbGlzdF9mb3JfZWFjaF9lbnRyeV9yY3UobnMs
ICZoZWFkLT5saXN0LCBzaWJsaW5ncykgew0KPiArCQlpZiAobnZtZV9wYXRoX2lzX2Rpc2FibGVk
KG5zKSkNCj4gKwkJCWNvbnRpbnVlOw0KPiArDQo+ICsJCWluZmxpZ2h0ID0gYXRvbWljNjRfcmVh
ZCgmbnMtPmN0cmwtPmluZmxpZ2h0X3NpemUpOw0KDQphdG9taWM2NF9yZWFkIGhhcyByZXR1cm4g
dHlwZSBzNjQsIGlzIHRoZXJlIGFueSBwYXJ0aWN1bGFyIHJlYXNvbiBub3QgdG8gdXNlDQpzNjQg
PyBPUg0KDQpldmVuIHU2NCBhcyBpdCBpcyB1c2VkIGluIG1hbnkgcGxhY2VzIGluIGtlcm5lbCA/
IE9SDQoNCmNvbnZlcnNpb24gZnJvbSBzNjQgdG8gdW5zaWduZWQgaW50IGlzIGRvbmUgaW50ZW50
aW9uYWxseSA/DQoNCi1jaw0KDQoNCg==

