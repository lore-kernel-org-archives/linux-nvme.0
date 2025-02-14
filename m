Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E03E8C02198
	for <linux-nvme@archiver.kernel.org>; Fri, 14 Feb 2025 03:55:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=u/z+tnR795eaDp/suGZWpvXagQaKaS8Gp3kkG2HuUlE=; b=PEHqh/CfhJu5z/1C+EbOSdoU/p
	+PYjhMMVLUjhMem3WyMOIyWPsDMf7+uKifHk5TNcgYhrvtHRDwTzZim9uFV9MAXVi8GXn9fj7WSXh
	BB2/pfNEe90ASivImH7B5d4E9lF/4KXPxbHqDZzkh0BpHcn3tN1G5oGUWT/ZkOV//+kgFFapmwo+j
	8lyAF3/+4oAEqecYsWUKBYVGFuZL5iv8h40PuXyvGz2gSh9rvpQKAsHlHKkUC9r+Yvw9jvfE88aBF
	8BP+jKZcV72NB0S2rWLWTSWNDgpm/ZREV6trVVIaRvDg2P9eQMn9QVf4+m2zTSA5Bg9HP0MtVl4MS
	uEQWLS8A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1timn2-0000000DXqB-3AD1;
	Fri, 14 Feb 2025 03:54:56 +0000
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1timn0-0000000DXpP-1AcR
	for linux-nvme@lists.infradead.org;
	Fri, 14 Feb 2025 03:54:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1739505294; x=1771041294;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=u/z+tnR795eaDp/suGZWpvXagQaKaS8Gp3kkG2HuUlE=;
  b=I5aDtVmSIDK6+pEKuHaQlV9ar4LFsRJ5D8Q1pf3q7wG6j0d24bjuureZ
   0ObkTAkVFe3ttGWq3cxVvyTfgS7KXj7AXUfopuPTGBfBoHUWAy5O0mwQO
   HLMDBOMYOsmqtEnl58Ux58vE0lOiwRZHkOnqO3DuA6UeZPMZASNPTOOxx
   WPgSe1aY3kb9Pd398xHJjdbSIVc+B7E0KfJkiei7AoMg7eVBrqlDlgW1E
   sYqaNH8UcpSrSBK+q8OVYGTVbHEWc12tDSZrd6n8h6JhswK8ahodDh5OE
   19rl7GAV1/gIIpS7p7JwjdTHb9rPfGQvQOthlR+XFiPVYeXhKfmehFsNj
   g==;
X-CSE-ConnectionGUID: UXZmtVWARoi4Ol83oUs2FQ==
X-CSE-MsgGUID: aB0C3yNYTX6T5ERgt2gqoA==
X-IronPort-AV: E=Sophos;i="6.13,284,1732550400"; 
   d="scan'208";a="39452209"
Received: from mail-bn7nam10lp2040.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.40])
  by ob1.hgst.iphmx.com with ESMTP; 14 Feb 2025 11:54:50 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H7yE+DIQTtG3oE7PtxFTiQOEYa7PcYMYR3DYHDQeG7ORNkTZalhkT4mYsKnNhITIA+r1i8ZEEHJDFOJLk52oiAjQq+caWx5xRoOJu3estGj1bj1FhHzjHGGxd1S8iteHi+kTCxd14K71FtKu/rxL2QLctdATUjPH928Z6wHCYyzskm53msQC4jSAksFtG57OUlitqe7MildpLFXm84B+Dyh495QVEJEHoaMjUt423VJxrbKB841Slpqivb2trFJ+F8kM0BnJj1LOGS2AQ4tqfOC9KTmRbczR4uprRGkaxSmfQ6mZrcCtlqmP87ccYQYAF15rKC7uF5AksjAWpk//EA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u/z+tnR795eaDp/suGZWpvXagQaKaS8Gp3kkG2HuUlE=;
 b=CyPHJWR+wAjgL7dGgGPNhE9sLPLUi85aDp13WC/l+vWB2FUI4q0w8OmUehGlt0/eltPr1Rmhu6khwsssQtyX6KpHKD2AfL2i0Bve2r1fyfO42D3gjzPjzJ9hUoRWPT9Y8kWUQK98TbDEdDItYx5fqia3xxaDQQsOsYiYqOOw5Dmv4SBmOUvbtPyVKZhB/SZD5Bdo3hJ9H2f1IiIz1F2JU6x8UP8RrZKSxOHnsLK9Cg/fZgGRHItwgyh6tgckpq6UWLTXKWJ7lmkpR5uwyVNwp4uMnKkYS0ieHjpR1Mp6SAWtAVgCKHojFcf+vY4gTIetBg792m2z3knrI7/QKI5R3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u/z+tnR795eaDp/suGZWpvXagQaKaS8Gp3kkG2HuUlE=;
 b=ZfG/rJ/XriU1NIJ7dxWIDJiffOQeatH1LNV4WSxy/4nY3/lKjU691BKqUbK8w5JEJYlskIJXm99qBjYs6W5IdWAZF5cy4HypsgS6xO2yPsLi/CrQkXMdz3A4HahxzUBoCFiClUTofqRXyRixhb2cK4nsyuDtriuXDEBh2twYTHc=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 SA6PR04MB9098.namprd04.prod.outlook.com (2603:10b6:806:41f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.13; Fri, 14 Feb
 2025 03:54:47 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b27f:cdfa:851:e89a]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b27f:cdfa:851:e89a%7]) with mapi id 15.20.8445.016; Fri, 14 Feb 2025
 03:54:47 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Daniel Wagner <dwagner@suse.de>
CC: Daniel Wagner <wagi@kernel.org>, James Smart <james.smart@broadcom.com>,
	Keith Busch <kbusch@kernel.org>, hch <hch@lst.de>, Sagi Grimberg
	<sagi@grimberg.me>, Hannes Reinecke <hare@suse.de>, Paul Ely
	<paul.ely@broadcom.com>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 3/3] nvme-fc: do not ignore connectivity loss during
 connecting
Thread-Topic: [PATCH v4 3/3] nvme-fc: do not ignore connectivity loss during
 connecting
Thread-Index: AQHbfec0nbYVZITau0iKmO3vJ10nULNE86QAgABWG4CAAOLSAA==
Date: Fri, 14 Feb 2025 03:54:47 +0000
Message-ID: <akxwnhjya5pgnujvfcvb5r2nj2qo65lji5euriy3ghuvt22klt@vitzpdphcufg>
References: <20250109-nvme-fc-handle-com-lost-v4-0-fe5cae17b492@kernel.org>
 <20250109-nvme-fc-handle-com-lost-v4-3-fe5cae17b492@kernel.org>
 <denqwui6sl5erqmz2gvrwueyxakl5txzbbiu3fgebryzrfxunm@iwxuthct377m>
 <6b6fea1e-671c-4a6a-98ba-a27bb2a4a95a@flourine.local>
 <cb11609e-9657-4f41-ba27-567d5fe1b1e3@flourine.local>
In-Reply-To: <cb11609e-9657-4f41-ba27-567d5fe1b1e3@flourine.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|SA6PR04MB9098:EE_
x-ms-office365-filtering-correlation-id: cdda7ada-b59a-408a-8c8e-08dd4cab5320
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|366016|376014|1800799024|38070700018|27256017;
x-microsoft-antispam-message-info: =?utf-8?B?VTh5MlQwSnZMRzhoWUhMeGU3VFBxckNVTmdQRUpFKzlSamZ6WjU3a3JpK3o2?=
 =?utf-8?B?OUNPNUx0bzEvaE1YcnJQVlJwaHZhb29ObHY2d3Q1SStWYVdKK1NDMGtoU1pw?=
 =?utf-8?B?YS9Ba05FOGk3VHc3NTZrUVlpWDRpOUFHcUIycWk2VEc1WVk2Vkc1MXNxSFVx?=
 =?utf-8?B?Y0wyUDhqSzFEdzRjR1dCWCtqQjRIMklDS2FSRnF4L1QzT1YxSEcxOWM3VDZm?=
 =?utf-8?B?dTlzM2JvNzZKMTJSZnNOeWZ2V1VIVjkrQ0pxVk1GTGl3azB6alJrMlJYZ0JR?=
 =?utf-8?B?M2FxM1FvSFMva1orVmt5Q3FYS0VmOGFuSERzZzVHdlpqUWNVdkM5WXc0bDRG?=
 =?utf-8?B?bUZsamZadXhJeWtJOUtBMjBnTWlscHJzbHpuY2NRTnhBeElmMzUzME0rRkpX?=
 =?utf-8?B?Kzk0S1FBeWNCVnlpUUc2THd5R3ppWjBXbnhwL0RuWVNXK1E3a3RONHhXbjB4?=
 =?utf-8?B?eUlCVE4vaWcydnRIYUtUS05XdlZVNnNzaXZycVFYM3FWbjdpbWsxc1BxaVdR?=
 =?utf-8?B?NkMxa1BVcjF0T3hnVEI0VTJ5Y0lUaWVJbVhWOGJJN1dMeEU5UVFlNzlna1RP?=
 =?utf-8?B?R2MwdjVnZTFyUFY4RjBUNE85R3NvUHhPMCtuT3hMTVk5N1lqamhkWUVzUVZr?=
 =?utf-8?B?ZkhtVG0xOXRTc1RGQnMxT3FvTE4vM0p4OVl2MjY4Zlk5NTJackFrK0loUzdM?=
 =?utf-8?B?VlVmTTdsN0JxYWVZcTdiSUFDa0JFQVF5RVFkdDBTU3dpSTFJeUhETndieENU?=
 =?utf-8?B?b25wRmRWT3IxMzl1QXhEUXlSdlFaaC9EN080ODgxb0s2RWRxVmhNTHQrRFNQ?=
 =?utf-8?B?aWZ5VGZHQ1NTcE93bG5zTERndk40MXNwdzhoUmJBUENVMXhuOEVCK1ZRTmF2?=
 =?utf-8?B?WDBqVi9jdHRiOVdvNnEwTlcxUk5uV3RMdUVjTmgxQTh1YmdYU1kvSmdIcVJ0?=
 =?utf-8?B?WVFhaHhSSmIrY3BqaEtiOE1iQ0FwRjdTRDdCRlZyV3VJMUcyZVVnMGVOeDVT?=
 =?utf-8?B?dTkxL2piZUJBR1lYM2MyYVF6U3NUVXBsWGZPYWZPeGhLd1RjdlVuZTc0L1c2?=
 =?utf-8?B?YVg2eXhScXJMYUx5Q3F3SDlraEcwNitMK0NNOXowbkNXUHVTVFVBbUNtWXFP?=
 =?utf-8?B?MHZTSTZWU2lVaThURjVXVzZJbmlMVmlhQnpLQU5HeUxtQ0w3K0ZsY251d1NT?=
 =?utf-8?B?T200WWJpZnVXYm1idmFFZldIbGRuNVpJWUUyZncyeUtScklMV1d5Nkl6aFlP?=
 =?utf-8?B?S3VDTGRkZjFnVDk0ZHVEbW1nNFRtMUduR29Xd3VWM2pPRnZWRmtVSzd6MEN0?=
 =?utf-8?B?Z01tUEdGa1hhZDdzT0ZuSXlhSGRCU0VBWmdPb3FVY2hUbFNGWStZNDZGekVW?=
 =?utf-8?B?TFEwZDhYaWt3NXlGNE9CK1VDeGdTK3k1Wm05NHVvNmFlR2NyQlpHa3RiVGd6?=
 =?utf-8?B?YXdhTmozaUtwRDVEa003enM4dVZ3Vy9FRUQ2SVk5Qk1mL0R1K094V2cxZVZl?=
 =?utf-8?B?bW0yZ09IK0pVSFpuRUhTSVlGTmRsRms1aWRCbFJzUVp3RitIalQ2L3NaaDV1?=
 =?utf-8?B?OVJxK3pQQWlOaE9oYUVCbjVvcDlidS9mOWNrYndPL21ralFDQ2RWQk1ONytZ?=
 =?utf-8?B?dEF6TnhNbkFXMG53Q1lqSTNRNE96YWR3enF0UkVvZ01FdXhkd1loclpQbWt4?=
 =?utf-8?B?WDJ5M0grU2d0dGhHN2c5eG1HcDE0MlVyeC9VN2Z6Y3NTTFhjaWF4Z0xaSjBz?=
 =?utf-8?B?RWJLbXplSnZwM3JYcVhQV0ZHNHVqa2Fjd1NZZG1sSzI5aG5ZSDNjQ0lRcjIy?=
 =?utf-8?B?M2xKOGFNUVNncWNvQWxXMitxZHVPVFBMMGZJdUllUWk3SzVXNnhXQlZVTkJU?=
 =?utf-8?B?TUEzOGZGZUNRakJac2I4NHpmQ3pPZzM5TTFVdlJsNjgrc3E1akNGMDRIRi8z?=
 =?utf-8?B?RzlKdFBiNzJsSDZneENoT3R2b3hsYzhlRVlkZUljdGxSb3k2K3lELzJqSXhQ?=
 =?utf-8?B?YWNTMlQ5M2x3PT0=?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024)(38070700018)(27256017);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?amhnZ0g3ZHowUlc4T29kcEJlS3dYelhDemtIVHBlN1BxL0hJVVRoN0pQd281?=
 =?utf-8?B?WER3V3Y5TTZXVGpBenJEbld1L0hldHp4NklEOEVHRkN0cGpDYmtVdEg2MVJj?=
 =?utf-8?B?M2xrV0JMci84c2Z2c3FVYmJHUkhPUS95ODB2d1hwVFFrdjVwM3VuNW9vekY0?=
 =?utf-8?B?TEZjVjhxbDNPRmkxTlovUXQzQVErU1Z0cElFVjBGWWxhS3BPRlQ2QnFWUFBD?=
 =?utf-8?B?a3BUanVndWpya2o3dHE1OC9lY3RHNDg1eWgzOU9hZXNydUk3Smo3UENPMFEv?=
 =?utf-8?B?b1NTZndCUHN6b1hseFhac2RnMmlFYXJVczBUd2RNZThpN1B2MTFkc0p3Ui9O?=
 =?utf-8?B?dklGeWI5clJVRTlZMU4xODdQL0ZIbmNWcWg0b2p1b01jWWlFdDRJVVVwcm9U?=
 =?utf-8?B?OXdFUGxMTUFFVWM3dklyOThERHVnbEpBQUxRcUpOWFY0Q1FiQmxKaGU2RnZE?=
 =?utf-8?B?K3V2R0p1UjNTNVc5UlFieUg5YzNzOFdJazhvRWplZDVVS1hyUHRMNGM3ZXhC?=
 =?utf-8?B?ek4yNEJXUVI3VWFnbWZjZjFjSXVpdTFKaERhSmZKZlk1NGN3czFBVGdVcWFw?=
 =?utf-8?B?UEU1R2lYcHc0UWxnVzA0ZTlvVzl5TjNBV2NORS9RR0w2VDdRcUxnemRIeDlt?=
 =?utf-8?B?bG1BbkJxK2xFVDNjcUlLRjZtZnBLblhvTXNrQmVXclc2Q09FdlAxU2c4a2VO?=
 =?utf-8?B?T1JQQlc4Sm0wOE1rTlRsbURhTFovTEJlUkFIK2w0WjN2Rk9vWk5LRlMybEpJ?=
 =?utf-8?B?eWxyOUhPNlNTVWgrYnhlcGxHdHBvd1NlVGQyLytza1FDNThRdnpBbmdCcDFU?=
 =?utf-8?B?U2lIa1VSTE5oVm9PbXV4MVBQd1Q1Z0RNbTZVcndnMjhaYlRTOHVwWXY2clpG?=
 =?utf-8?B?SXA5aEZwa0tLaDhNT0JSVzVRd21FQlR6dmNQS3ZNa1VlaEFaaDJKSEdLNnFi?=
 =?utf-8?B?RG8wSWxsSUxreTYxbng5b3RyTEFEaFMwRWtaRkpjMmdZQmY4aGd4czVOdm05?=
 =?utf-8?B?T0VWZU1pcTJHbTE5Z25vZVV0VjgxTnB1VUIrT0UrY3dCam91VDFTOWczbmg5?=
 =?utf-8?B?dW84cDdEekhZb0xab3RYRGxVN3NDL0dnbVczT0FJV0w4S25pSGZyOTRuMFZz?=
 =?utf-8?B?WTNYWVUrdXRnTEJrQ1pkQUh6UzU3d3Q1NlZEYWVndDRGWlhoU0FTc25hV01G?=
 =?utf-8?B?Y2NUMU5ZLzFEY3pFbldrUzdYMERsb1JCaUwwcXM3QUdGY0lkVDZJVVRiWklu?=
 =?utf-8?B?NlNmd2xRNmNlcHhIanF2a1EwcTExdituUDVtZUpmMWdEQjcrNEgvS0tERlZG?=
 =?utf-8?B?NTk4Z1dHTEFYZ3VJbmc1dnc3cFgyY0dyNVdmajhaRG5nT1Nva09SVE5Ubk9B?=
 =?utf-8?B?eHJ4S2RtRTJOc3lTd2ZxcjB1emdSV2NOc0lhYjZGY0poU0Vic1lDNDZxOE5T?=
 =?utf-8?B?WmQ2MXFqNFgrVCs3WUhsTEhkc0xUbld1a0hyUE5pQzRHU28zYllrakViMXNW?=
 =?utf-8?B?eDhncElsbVZSejFJa3kxRE53RHlJZCtLdnpFa0ZUbC9xVXN4ejMra1YxQytJ?=
 =?utf-8?B?MXBpM1JqNm51c1RBY095bEZhOHFPRVREMFpmWE9pSkluNnc2R09McC9JdVdV?=
 =?utf-8?B?MnpVb0paMkxYMlpnOGNreXI3VmRrcEFjam9pYjkvL28vSzFKeW14QUVVTENX?=
 =?utf-8?B?M0RWL0tXS1k0czNIQmVJZlQzSTdxcktobkVmdithS0RmTmRsb0JueCtWNTJT?=
 =?utf-8?B?cmpuOWZKSncwczRTL25DY3lzc3ZrVkxReXBvc290V3g5Q3FVeWRQampNUVJn?=
 =?utf-8?B?UGlGd0dhd0QwQ0ZndTdZOG9ZSC9SVXIwd3V1cmRaYXoxK1g1RWdUMGxBZUY5?=
 =?utf-8?B?N3hoeTEvSTdvRG1XREtzQy9mZTk0UG44aDBqenRZU09helBKK2VYL3hzeFFt?=
 =?utf-8?B?NW95Rlo4eUxVYkN2V2NWbVNIUllYSU0rdFN5bFlFc0NsQ242VGc5NGQ5UkFH?=
 =?utf-8?B?alFlLzZ3YVVBTWVTa3dKaEJJTlNwQkhRVzU4SlFzU1NYRFAwL21wcE8yOTIz?=
 =?utf-8?B?K1NmRVpQQ1haWTZzaCtaZDJXdVNrTGtncVJCTXdSaEljdGRiNUdsSWFHM3Ni?=
 =?utf-8?B?dHhQWFU2eXdMUFZDcit4U1V3K0xZY2VkZitzdmUyc3E1YkdsRC8xU2luL0tR?=
 =?utf-8?Q?T+Z2NF3TdLxshN1/ThSFlwk=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <027950E0AB7B5247BB4A3AE7D99FCE5F@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: ayAXdkqo4tf5n6zahaP36vjC4cIVwbpDm/Qvlea9cY+zOq/VmJM0Hm+7LJmTLoIs2GOjkWnGsFePjmu0nVqQB5Ay+dl+YP4JGHeWBjpb1AjW17HzZWd8UesUCfOZ/+gN3psgrB1n+EQ+Ywz+wOiKiz9wsi/dGl9YlSdkEdWOicZ8InQYFx9YeG24kue3k1G/PwmNxh93VkkxhG3k88PCiKZpKjTN+sKpzt+LAC5iNxEpi8Y5hYRVmLTTtkbu4jSxKQE/r5gukuGGHMpbH9gAnngAJmhVpKpKb3dtnWG9MTVCJPhIOUfRCnFuXzN+xs5rvAUdRGkT6elDFPDvMAqAYLAPT+n3FO5uAZ9rVXoBd0sTzxTwYEAn9zsFW2P0Lbxf7nDMXrX/cdZtlLhcujwKEV7yuNMHlTudw4Ryz3u6u29av7iz8xF+Gsm1iqRNp18ZPHQLyjx3G39qfpaijGRqubb6vrPgz4KLWhYd5hWFMs570PYpTzP96OZqCudmrB7oVdXkyvyPTei/BAF3fhgSUpsp3OqdvApK/Tfj8xZ38gfbhe33D87KWdd9rOcb2e5HXZJxsJoOePwJDb/Tj9HF/FVwzPKTkI0J/BVq0nAZDdXq/BWDrtyt630LLDTOpy5U
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cdda7ada-b59a-408a-8c8e-08dd4cab5320
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Feb 2025 03:54:47.4069
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nhhGa5yvNSa4Qc4v2RkD25nw74fvXw282VFlNFC2zcfMP6xgef71XzcVf434m87mgEXBCr7jgwa9DPozFa6fiftiofrXyPwf/KlXtkc741s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR04MB9098
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250213_195454_389038_6038D569 
X-CRM114-Status: GOOD (  27.49  )
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

T24gRmViIDEzLCAyMDI1IC8gMTU6MjIsIERhbmllbCBXYWduZXIgd3JvdGU6DQo+IE9uIFRodSwg
RmViIDEzLCAyMDI1IGF0IDEwOjE0OjQ2QU0gKzAxMDAsIERhbmllbCBXYWduZXIgd3JvdGU6DQo+
ID4gVGhhdCBtZWFucyB0aGUgaWRlYSB0byBzeW5jaHJvbml6ZSB0aGUgc3RhdGUgY2hhbmdlIHdp
dGggdGhlDQo+ID4gQVNTT0NfRkFJTEVEIGJpdCB1bmRlciB0aGUgbG9jayBpcyBub3QgZ29pbmcg
dG8gd29yay4gSSBhbSB0cnlpbmcgdG8NCj4gPiBmaWd1cmUgb3V0IGEgc29sdXRpb24uDQo+IA0K
PiBJIGZvdW5kIGEgcG9zc2libGUgc29sdXRpb24uIFRoZSBvbmx5ICdjYXRjaCcgaXMgdG8gbWFr
ZSB0aGUgc3RhdGUNCj4gbWFjaGluZSBhIGJpdCBtb3JlIHJlc3RyaWN0aXZlLiBUaGUgb25seSB2
YWxpZCB0cmFuc2l0aW9uIHRvIExJVkUgd291bGQNCj4gYmUgZnJvbSBDT05ORUNUSU5HLiBXZSBj
YW4gZG8gdGhpcyBiZWNhdXNlIGV2ZW4gdGhlIFBDSSBkcml2ZXIgaXMgZG9pbmcNCj4gYWxsIHRo
ZSBzdGF0ZSB0cmFuc2l0aW9ucyBORVcgLT4gQ09OTkVDVElORyAtPiBMSVZFLiBJdCdzIGltcG9y
dGFudCB0aGF0DQo+IHdlIGNhbid0IGVudGVyIExJVkUgZnJvbSBSRVNFVFRJTkcgdG8gZ2V0IHRo
ZSBwYXRjaCBiZWxvdyB3b3JraW5nLg0KPiANCj4gV2UgZG9uJ3QgaGF2ZSB0byByZWx5IG9uIGFu
b3RoZXIgdmFyaWFibGUgdG8gZmlndXJlIGluIHdoaWNoIHN0YXRlIHRoZQ0KPiBjdHJsIGlzLiBU
aGUgbnZtZV9mY19jdHJsX2Nvbm5lY3Rpdml0eV9sb3NzIGNhbGxiYWNrIG5lZWRzIGFsd2F5cyB0
bw0KPiB0cmlnZ2VyIGEgcmVzZXQuIElmIHRoZSBjdHJsIGlzIG5vdCBpbiBMSVZFIGl0IGlzIGEg
bm8tb3AuIFRoaXMgbWFrZXMgaXQNCj4gcG9zc2libGUgdG8gcmVtb3ZlIHRoZSBsb2NrIGFyb3Vu
ZCB0aGUgQVNTT0NfRkFJTEVEIGFuZCB0aGUgc3RhdGUgcmVhZA0KPiBvcGVyYXRpb24uDQo+IA0K
PiBJbiBudm1lX2ZjX2NyZWF0ZV9hc3NvY2lhdGlvbiB3ZSBvbmx5IGhhdmUgdG8gY2hlY2sgaWYg
d2UgY2FuIGVudGVyIHRoZQ0KPiBMSVZFIHN0YXRlICh0aHVzIHdlIHdlcmUgaW4gQ09OTkVDVElO
RykgYW5kIGlmIHRoaXMgZmFpbHMgd2UgZW50ZXJlZCB0aGUNCj4gUkVTRVRUSU5HIHN0YXRlIGFu
ZCBzaG91bGQgcmV0dXJuIGFuIGVycm9yLg0KPiANCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJz
L252bWUvaG9zdC9jb3JlLmMgYi9kcml2ZXJzL252bWUvaG9zdC9jb3JlLmMNCj4gaW5kZXggODE4
ZDRlNDlhYWI1Li5mMDI4OTEzZTJlNjIgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvbnZtZS9ob3N0
L2NvcmUuYw0KPiArKysgYi9kcml2ZXJzL252bWUvaG9zdC9jb3JlLmMNCj4gQEAgLTU2NCw4ICs1
NjQsNiBAQCBib29sIG52bWVfY2hhbmdlX2N0cmxfc3RhdGUoc3RydWN0IG52bWVfY3RybCAqY3Ry
bCwNCj4gIAlzd2l0Y2ggKG5ld19zdGF0ZSkgew0KPiAgCWNhc2UgTlZNRV9DVFJMX0xJVkU6DQo+
ICAJCXN3aXRjaCAob2xkX3N0YXRlKSB7DQo+IC0JCWNhc2UgTlZNRV9DVFJMX05FVzoNCj4gLQkJ
Y2FzZSBOVk1FX0NUUkxfUkVTRVRUSU5HOg0KPiAgCQljYXNlIE5WTUVfQ1RSTF9DT05ORUNUSU5H
Og0KPiAgCQkJY2hhbmdlZCA9IHRydWU7DQo+ICAJCQlmYWxsdGhyb3VnaDsNCj4gZGlmZiAtLWdp
dCBhL2RyaXZlcnMvbnZtZS9ob3N0L2ZjLmMgYi9kcml2ZXJzL252bWUvaG9zdC9mYy5jDQo+IGlu
ZGV4IGY0ZjE4NjZmYmQ1Yi4uZTc0MDgxNGZkMWVhIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL252
bWUvaG9zdC9mYy5jDQo+ICsrKyBiL2RyaXZlcnMvbnZtZS9ob3N0L2ZjLmMNCj4gQEAgLTc4MSw2
MSArNzgxLDEyIEBAIG52bWVfZmNfYWJvcnRfbHNvcHMoc3RydWN0IG52bWVfZmNfcnBvcnQgKnJw
b3J0KQ0KPiAgc3RhdGljIHZvaWQNCj4gIG52bWVfZmNfY3RybF9jb25uZWN0aXZpdHlfbG9zcyhz
dHJ1Y3QgbnZtZV9mY19jdHJsICpjdHJsKQ0KPiAgew0KPiAtCWVudW0gbnZtZV9jdHJsX3N0YXRl
IHN0YXRlOw0KPiAtCXVuc2lnbmVkIGxvbmcgZmxhZ3M7DQo+IC0NCj4gIAlkZXZfaW5mbyhjdHJs
LT5jdHJsLmRldmljZSwNCj4gIAkJIk5WTUUtRkN7JWR9OiBjb250cm9sbGVyIGNvbm5lY3Rpdml0
eSBsb3N0LiBBd2FpdGluZyAiDQo+ICAJCSJSZWNvbm5lY3QiLCBjdHJsLT5jbnVtKTsNCj4gDQo+
IC0Jc3Bpbl9sb2NrX2lycXNhdmUoJmN0cmwtPmxvY2ssIGZsYWdzKTsNCj4gIAlzZXRfYml0KEFT
U09DX0ZBSUxFRCwgJmN0cmwtPmZsYWdzKTsNCj4gLQlzdGF0ZSA9IG52bWVfY3RybF9zdGF0ZSgm
Y3RybC0+Y3RybCk7DQo+IC0Jc3Bpbl91bmxvY2tfaXJxcmVzdG9yZSgmY3RybC0+bG9jaywgZmxh
Z3MpOw0KPiAtDQo+IC0Jc3dpdGNoIChzdGF0ZSkgew0KPiAtCWNhc2UgTlZNRV9DVFJMX05FVzoN
Cj4gLQljYXNlIE5WTUVfQ1RSTF9MSVZFOg0KPiAtCQkvKg0KPiAtCQkgKiBTY2hlZHVsZSBhIGNv
bnRyb2xsZXIgcmVzZXQuIFRoZSByZXNldCB3aWxsIHRlcm1pbmF0ZSB0aGUNCj4gLQkJICogYXNz
b2NpYXRpb24gYW5kIHNjaGVkdWxlIHRoZSByZWNvbm5lY3QgdGltZXIuICBSZWNvbm5lY3RzDQo+
IC0JCSAqIHdpbGwgYmUgYXR0ZW1wdGVkIHVudGlsIGVpdGhlciB0aGUgY3Rscl9sb3NzX3Rtbw0K
PiAtCQkgKiAobWF4X3JldHJpZXMgKiBjb25uZWN0X2RlbGF5KSBleHBpcmVzIG9yIHRoZSByZW1v
dGVwb3J0J3MNCj4gLQkJICogZGV2X2xvc3NfdG1vIGV4cGlyZXMuDQo+IC0JCSAqLw0KPiAtCQlp
ZiAobnZtZV9yZXNldF9jdHJsKCZjdHJsLT5jdHJsKSkgew0KPiAtCQkJZGV2X3dhcm4oY3RybC0+
Y3RybC5kZXZpY2UsDQo+IC0JCQkJIk5WTUUtRkN7JWR9OiBDb3VsZG4ndCBzY2hlZHVsZSByZXNl
dC5cbiIsDQo+IC0JCQkJY3RybC0+Y251bSk7DQo+IC0JCQludm1lX2RlbGV0ZV9jdHJsKCZjdHJs
LT5jdHJsKTsNCj4gLQkJfQ0KPiAtCQlicmVhazsNCj4gLQ0KPiAtCWNhc2UgTlZNRV9DVFJMX0NP
Tk5FQ1RJTkc6DQo+IC0JCS8qDQo+IC0JCSAqIFRoZSBhc3NvY2lhdGlvbiBoYXMgYWxyZWFkeSBi
ZWVuIHRlcm1pbmF0ZWQgYW5kIHRoZQ0KPiAtCQkgKiBjb250cm9sbGVyIGlzIGF0dGVtcHRpbmcg
cmVjb25uZWN0cy4gIE5vIG5lZWQgdG8gZG8gYW55dGhpbmcNCj4gLQkJICogZnV0aGVyLiAgUmVj
b25uZWN0cyB3aWxsIGJlIGF0dGVtcHRlZCB1bnRpbCBlaXRoZXIgdGhlDQo+IC0JCSAqIGN0bHJf
bG9zc190bW8gKG1heF9yZXRyaWVzICogY29ubmVjdF9kZWxheSkgZXhwaXJlcyBvciB0aGUNCj4g
LQkJICogcmVtb3RlcG9ydCdzIGRldl9sb3NzX3RtbyBleHBpcmVzLg0KPiAtCQkgKi8NCj4gLQkJ
YnJlYWs7DQo+IC0NCj4gLQljYXNlIE5WTUVfQ1RSTF9SRVNFVFRJTkc6DQo+IC0JCS8qDQo+IC0J
CSAqIENvbnRyb2xsZXIgaXMgYWxyZWFkeSBpbiB0aGUgcHJvY2VzcyBvZiB0ZXJtaW5hdGluZyB0
aGUNCj4gLQkJICogYXNzb2NpYXRpb24uICBObyBuZWVkIHRvIGRvIGFueXRoaW5nIGZ1cnRoZXIu
IFRoZSByZWNvbm5lY3QNCj4gLQkJICogc3RlcCB3aWxsIGtpY2sgaW4gbmF0dXJhbGx5IGFmdGVy
IHRoZSBhc3NvY2lhdGlvbiBpcw0KPiAtCQkgKiB0ZXJtaW5hdGVkLg0KPiAtCQkgKi8NCj4gLQkJ
YnJlYWs7DQo+IC0NCj4gLQljYXNlIE5WTUVfQ1RSTF9ERUxFVElORzoNCj4gLQljYXNlIE5WTUVf
Q1RSTF9ERUxFVElOR19OT0lPOg0KPiAtCWRlZmF1bHQ6DQo+IC0JCS8qIG5vIGFjdGlvbiB0byB0
YWtlIC0gbGV0IGl0IGRlbGV0ZSAqLw0KPiAtCQlicmVhazsNCj4gLQl9DQo+ICsJbnZtZV9yZXNl
dF9jdHJsKCZjdHJsLT5jdHJsKTsNCj4gIH0NCj4gDQo+ICAvKioNCj4gQEAgLTMxNzcsMjMgKzMx
MjgsMTggQEAgbnZtZV9mY19jcmVhdGVfYXNzb2NpYXRpb24oc3RydWN0IG52bWVfZmNfY3RybCAq
Y3RybCkNCj4gIAkJZWxzZQ0KPiAgCQkJcmV0ID0gbnZtZV9mY19yZWNyZWF0ZV9pb19xdWV1ZXMo
Y3RybCk7DQo+ICAJfQ0KPiArCWlmICghcmV0ICYmIHRlc3RfYml0KEFTU09DX0ZBSUxFRCwgJmN0
cmwtPmZsYWdzKSkNCj4gKwkJcmV0ID0gLUVJTzsNCj4gIAlpZiAocmV0KQ0KPiAgCQlnb3RvIG91
dF90ZXJtX2Flbl9vcHM7DQo+IA0KPiAtCXNwaW5fbG9ja19pcnFzYXZlKCZjdHJsLT5sb2NrLCBm
bGFncyk7DQo+IC0JaWYgKCF0ZXN0X2JpdChBU1NPQ19GQUlMRUQsICZjdHJsLT5mbGFncykpDQo+
IC0JCWNoYW5nZWQgPSBudm1lX2NoYW5nZV9jdHJsX3N0YXRlKCZjdHJsLT5jdHJsLCBOVk1FX0NU
UkxfTElWRSk7DQo+IC0JZWxzZQ0KPiArCWlmICghbnZtZV9jaGFuZ2VfY3RybF9zdGF0ZSgmY3Ry
bC0+Y3RybCwgTlZNRV9DVFJMX0xJVkUpKSB7DQo+ICAJCXJldCA9IC1FSU87DQo+IC0Jc3Bpbl91
bmxvY2tfaXJxcmVzdG9yZSgmY3RybC0+bG9jaywgZmxhZ3MpOw0KPiAtDQo+IC0JaWYgKHJldCkN
Cj4gIAkJZ290byBvdXRfdGVybV9hZW5fb3BzOw0KPiArCX0NCj4gDQo+ICAJY3RybC0+Y3RybC5u
cl9yZWNvbm5lY3RzID0gMDsNCj4gLQ0KPiAtCWlmIChjaGFuZ2VkKQ0KPiAtCQludm1lX3N0YXJ0
X2N0cmwoJmN0cmwtPmN0cmwpOw0KPiArCW52bWVfc3RhcnRfY3RybCgmY3RybC0+Y3RybCk7DQo+
IA0KPiAgCXJldHVybiAwOwkvKiBTdWNjZXNzICovDQoNClRoYW5rcyBEYW5pZWwuIEkgYXBwbGll
ZCB0aGUgcGF0Y2ggb24gdG9wIG9mIHY2LjE0LXJjMiwgYW5kIGl0IGF2b2lkZWQgdGhlDQpibGt0
ZXN0cyBmYWlsdXJlcy4gSSByYW4gdGhlIG52bWUgdGVzdCBncm91cCB3aXRoIG90aGVyIHRyYW5z
cG9ydHMgKGxvb3AsIHJkbWENCmFuZCB0Y3ApLCBhbmQgb2JzZXJ2ZWQgbm8gcmVncmVzc2lvbi4g
SXQgbG9va3MgZ29vZCBmcm9tIHRlc3QgcnVuIHBvaW50IG9mIHZpZXcuDQoNCk9mIG5vdGUgaXMg
dGhhdCBJIG9ic2VydmVkIGEgY29tcGlsZXIgd2FybmluZyBhdCBrZW5lcmwgYnVpbGQ6DQoNCmRy
aXZlcnMvbnZtZS9ob3N0L2ZjLmM6IEluIGZ1bmN0aW9uIOKAmG52bWVfZmNfY3JlYXRlX2Fzc29j
aWF0aW9u4oCZOg0KZHJpdmVycy9udm1lL2hvc3QvZmMuYzozMDI1OjE0OiB3YXJuaW5nOiB1bnVz
ZWQgdmFyaWFibGUg4oCYY2hhbmdlZOKAmSBbLVd1bnVzZWQtdmFyaWFibGVdDQogMzAyNSB8ICAg
ICAgICAgYm9vbCBjaGFuZ2VkOw0KICAgICAgfCAgICAgICAgICAgICAgXn5+fn5+fg==

