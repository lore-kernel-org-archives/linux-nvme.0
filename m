Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6776EDF020
	for <linux-nvme@archiver.kernel.org>; Thu, 12 Feb 2026 02:40:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nUf66gLeeRgt9m2cS6ZL85/OpesQIEqTrYULyz4Y7+o=; b=dGKit0y0UIcwX/15LEONEIrzSh
	1njL53+ZwYqPeEcvZxZxLMVxwk22wp+60YkazSrCwjGtLZYeVjqPTlx2gC+KpkvpiR4TerUBWbsG9
	tfFxfkD2aGImWSL58CYqO5jFprC8XV3J35NoLG6PMDfVON6S2VDq6kIGcStVO5QEqPPgw+CB5CIRv
	um7EGYppD8MJqvfCJjE2uuzqdvLugKcLmu2YzQ2gKvDVeKnJMPGlnSzTt7hRubp9t4FvgYWYJGSds
	L4GSwiS9dmcSXZE+GjydX3qQ5+qrbsiIxoylUib2vHMp6nltCQyz1Kr/lKFstURz2LAxfNemB3fak
	cWljyyNg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vqMcz-00000001K99-10qL;
	Thu, 12 Feb 2026 02:40:25 +0000
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vqMcu-00000001K8A-0mHA
	for linux-nvme@lists.infradead.org;
	Thu, 12 Feb 2026 02:40:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1770864019; x=1802400019;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=nUf66gLeeRgt9m2cS6ZL85/OpesQIEqTrYULyz4Y7+o=;
  b=mAfZzk3RHfvdACwFu3zTSIBraH2OU2f+9p3Y03HDMl1AvbEAo5NiX5Sa
   1gENRymEOBFr5qIcfmieVDTE2s2i3SqbFtdJVWAYJ2JMzzopSuhFNQbFb
   y8hkTIquQf/s8sxcs4XBOgQYnjD/k+7eGCGLGnbAxckJ1q8lWNXmDzjzA
   BdwJ4sWAlM9styuC0JUF23vskzYZZqh/dJScCBHIckjCQrYfVTApdCrNP
   clcWZUWMJfvGGAlrZNLk3M+xzx5QJeD2xAI2zyem8fwg1u15VZ5RtRHdK
   jtycROpW6otwGqr6NUDT9PCG87iMADdL5lTiIAeTT2z6XQxOc5dIiXSHj
   w==;
X-CSE-ConnectionGUID: znfW5t/wR/CzuLXM6DKz9w==
X-CSE-MsgGUID: l7mrMSQqQZ+KTAkdOzxrgA==
X-IronPort-AV: E=Sophos;i="6.21,285,1763395200"; 
   d="scan'208";a="141730020"
Received: from mail-southcentralusazon11011040.outbound.protection.outlook.com (HELO SN4PR0501CU005.outbound.protection.outlook.com) ([40.93.194.40])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 12 Feb 2026 10:40:16 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=snDHkd9kSXNojHw5nG5n2qbW5KgTrHH36y+uHmhp8caSJBdizA62ud4IdA+kij3tcWryaM2mmgTo4ZvDZZMqYaWEV9B99fbapS6fHQnTSiIU5NbNHV1JIlPxObBo7oJ3cfbnKGW8UX/JHcbdZbSi5EoNZYRKcuH9nC32mtidSwaw08Zzry561pwyZnTkz7ND2sJWRCWaNHyS+sEygHCtHF95YWPUri7YGvP+39XY+LscJXYd1S8xYZ5/XyOAnp3zTm5qE40Lfa88ce+9WGopwnsGUqJEmrDV6BnRJNo1N0ipcMWvm+xLdkWnVczEXWqjc27Oi3f64DV0evyw27x+Vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nUf66gLeeRgt9m2cS6ZL85/OpesQIEqTrYULyz4Y7+o=;
 b=jPz0FDOSRWihI33ZUXM/7yCA7GgY8OwIAMc7Mdth0ZSnY5facTgzzZTNV+mrpiMKr1GYaI8HQLv10VQ6m2STRBVIl1xi0a4VG6pKRwoQ28I9qSGT9MiiayZAdyCE9g0w5KfErPUU37MYeVHlFPd+Bv82J7R/F9TFPjCf2u/srqm8Pc9iY4Lp4hwNNoCt+OHe8D6G5L/ycEwgskheWy29ul1mJ+ZMCPCBCLWSoX1ZhToV/HinDvucAwM7cAVAYkKRpD3V0gdwLxLIxuo+R7v1R1x8Nja0uZ7sOR8duv5+3HBriTm9W9TCPB/pllUs7DkRo9HjWKmOOWCvCK+T6CZOog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nUf66gLeeRgt9m2cS6ZL85/OpesQIEqTrYULyz4Y7+o=;
 b=Lhzg4CukDbdc6QEb5bgSqPx1Mu9q72VHJe3EcBbe+/E6m08l4t3X78HkOJUB4LITeV6UnCA6cVErKfOHzCr+86bqNes9H5bwzxEI9MNLk/rd6ci0guBh7kl74gVwQL8hGoTk79U/RVevpmfEV/u13fdsVct2ecHmxHj0ZFDImkM=
Received: from SA1PR04MB8303.namprd04.prod.outlook.com (2603:10b6:806:1e4::17)
 by BL3PR04MB7930.namprd04.prod.outlook.com (2603:10b6:208:339::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.10; Thu, 12 Feb
 2026 02:40:14 +0000
Received: from SA1PR04MB8303.namprd04.prod.outlook.com
 ([fe80::8719:e407:70e:f9e1]) by SA1PR04MB8303.namprd04.prod.outlook.com
 ([fe80::8719:e407:70e:f9e1%5]) with mapi id 15.20.9611.008; Thu, 12 Feb 2026
 02:40:14 +0000
From: Wilfred Mallawa <wilfred.mallawa@wdc.com>
To: "kbusch@kernel.org" <kbusch@kernel.org>
CC: hch <hch@lst.de>, "dlemoal@kernel.org" <dlemoal@kernel.org>,
	"axboe@kernel.dk" <axboe@kernel.dk>, "sagi@grimberg.me" <sagi@grimberg.me>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4] nvme/host: fixup some typos
Thread-Topic: [PATCH v4] nvme/host: fixup some typos
Thread-Index: AQHchSCaO0WHVdEc/0adeepua77uNbV9E5gAgAFyLwCAAAHLgA==
Date: Thu, 12 Feb 2026 02:40:14 +0000
Message-ID: <44b34304874e6463436955a3e3710fa6a856b143.camel@wdc.com>
References: <20260114063722.68846-3-wilfred.opensource@gmail.com>
	 <18e09860f731dd83c206e286f570ac77a5186ce9.camel@wdc.com>
	 <aY08DMHh8G0wqPit@kbusch-mbp>
In-Reply-To: <aY08DMHh8G0wqPit@kbusch-mbp>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR04MB8303:EE_|BL3PR04MB7930:EE_
x-ms-office365-filtering-correlation-id: 1b17c9cd-194c-45e5-b8df-08de69e00d20
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|19092799006|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?U3JXaGU3RHRzeUJSSVRyd2xhbENYaUl3NnlvV3drbnYxdERkcEI0c1RQOUFC?=
 =?utf-8?B?bnhPVkdSTk1WbmN6dDY2Y1VKaGNSMVc5aHJtQVFxMXZ6Tm5vdCtVeVowVXpt?=
 =?utf-8?B?KzdBbHVCcDNicVFFVGVJOEdSdFNpcEdUQlBjRGpxckZkMFhSa2lFdy9Zbk10?=
 =?utf-8?B?L1FnTllESVhtZmdjeE8wNVpSWlFBc1JIaS9SSTRIZ1R6ekZpOENoNkdyVkJP?=
 =?utf-8?B?ZVZ1elR2Z3hpaVFKVS8zNnFpVE9JbzVMdU5JZGRmQVF1V2RweXBTSW5VZ21o?=
 =?utf-8?B?c1dtc1pNWTIwbzA0L2c4SXJxVjR3RVlxY3cyTk16cmN6YjZDNzFSbW9mdmJj?=
 =?utf-8?B?U1Q0d3J0dW1rNkhLMk95SHdJLyt5MS9hR3ZZNDhva1Buc0NzM1FFQVlEQjEv?=
 =?utf-8?B?eHlpS2tpVklYWkJlcGtrcW9Pb1EvMjJMcTNNRVlRT2djQ0lDMnQ1cjZJRVE1?=
 =?utf-8?B?ZmJ5elRib0Q5N3ZoSGVWbHdJYVVDOVlGR3hmdFZQUzRhajl6UnpZcWJyWEtl?=
 =?utf-8?B?L3gzcU4vZnJ5MlZuS3BEdDd3dG9pdlRya1krZi8rbjFIZXlYTFFEZzlZaW9p?=
 =?utf-8?B?NXdlVmt2VHJsSEdRUnlHYSs4TXZiemdRK2d6bmxqRFFyeEFKMHlJYldtUXpu?=
 =?utf-8?B?ZEhGbzlXYkFCUnZXS3Q4SHBjV1lxZFFwRFlrVWZ4QU5aSXVmdVRLYmx3aDBP?=
 =?utf-8?B?SlRYZTV0S3BwV0lyY2xFeTBDb1VLM1NOODRCYWUvVEdITERwRXA2K0EycEN4?=
 =?utf-8?B?QjVjSVc2VVlqVEtYVitVcUptbDhSTHdNUVl0MGdySDZCWVFGaFlHUUZIdDYr?=
 =?utf-8?B?NENMU0hLSnl4Tm5mWEFrVTJYL0VaVDZOcG1oTTZqVVBaNnY4c2FjOFhyRml4?=
 =?utf-8?B?S0pvZlJsMUI4a0RnN1ZOOE5RWHdJQXZlOEVka2tBdUNlR3FSN1VtOVEyY3dN?=
 =?utf-8?B?T3RhNkVyN0VpUTF1Rmc3VU1iNW9sZXVObk0ycWkwZUJqM3pzY21xQmxWakh2?=
 =?utf-8?B?NXBkTnpzS2FHaHd1TE04UEdGTHNocTlQM0F6eVdTRXBSQWZtVndhS3FqR2ta?=
 =?utf-8?B?ajNJNWNZd3RHMndlK0s1eWxNM1BUajVvUEY5WDd1QVJOQTNwQ3p5Q3kvSldy?=
 =?utf-8?B?d0grQmNNRmlURE5jZjlqRkFiUHZnandaQytGVUhtdi8rUmk0eWFpRUMrRDlN?=
 =?utf-8?B?UkxrNHNBL3Z5Ti80Sk9Pd3htTGIwRnBHUDQ0cUNLYWh5S0RFeHFHR0ovTnNV?=
 =?utf-8?B?eEVKR1ZEMm4zMkFJdnFnVlhFMFBFRTdjWVFaem1SRFpSQk0vTWFXdHVGZS82?=
 =?utf-8?B?dlkrSmVQVXlhOGlMSU16TkZBbERLNUlyVFN2ZWphUnVzUXNZaWw3bDZXUVhF?=
 =?utf-8?B?KzJValpydHFxSGlvQkkzcHJwUWMwSHFQSzFGeElKeVJtQmxyUDlGRTFBUFUy?=
 =?utf-8?B?N1lINnBHck9nT0ZnQVVVUUEwY29OenpBVVdKU3B6N0NoQ2JqYkZEMU4weU54?=
 =?utf-8?B?VUM0K2FTRVRaWk4yM1d5QVhMNjltaDFWRDQ1ZGRnWXJBMDh2TlcvdERycUNG?=
 =?utf-8?B?a3pTUnNWczUvS2lMd202THNnb0l6V1gwODBSUEJpM2V4ZGdvc0diVEI5RnUy?=
 =?utf-8?B?SHkvVTZLZkRQSmhyTHNCRGhmM3c2VVE5UVdZUW5scDZ3dG1Qc29CRzU2TVdE?=
 =?utf-8?B?eHB2V2t3RzJackdvN3FjK3hxZVlpa2M0UThEbC9xdEY1MXRnZXFhZkFTQzdY?=
 =?utf-8?B?Q1hXb0R0bFI2bjBCdy9tak1MNEQrVll2ODNmTkFlVWZRcFVwZkhrUWhvdUdT?=
 =?utf-8?B?RmswdVJLQlhQVzBOenVtVXZ5VkhWOGFCRmJFdEZPK2d0VDltWDJBK0psRUVK?=
 =?utf-8?B?SkFIbEpDc3l4bjRWaCtmeXppaXN5RVIwV3RDd3hiKzV1b3VvRWthRDhzNkVp?=
 =?utf-8?B?cjR0RDJtMkRMOU1uMmgySkl3N2NYQSs3SkdSYVRpVnBKY0EyWTYwQkl1V0Vo?=
 =?utf-8?B?NHZTVW5LVjN2VlJUVitDMkQzVm1mN1hxSlg3dDlPdUF2bzk1M2hqNFFCeG1P?=
 =?utf-8?B?WTRzWCtwMlE2NzZ5akZ2M0Y4OSsyQ0NJWjBROWpwa2JWbExReENPNHhtVTVz?=
 =?utf-8?Q?dKAM=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR04MB8303.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(19092799006)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Y09VRndyRUc2aW9DWGJvbGJQdUcyQTdhU3VBQ3I0Q1AreTQ3T2pBNGplV1Mx?=
 =?utf-8?B?Z3hOMlE2UExHVXlTRzBEV0NyTElqODYyclNtSW0rcmtBSTZqZ2dQOHhucW5B?=
 =?utf-8?B?T20wV0pYYUdjZ3hWUUE3N3NJM3pKNXVLVnNZTUNIUUhYTmJzVHU1QytGSzl0?=
 =?utf-8?B?OXNHcFUrUE1ITzEyeVRVT1VvRWNISkMxS2dXOTBwWHd2VEROMXFBOGJyeWx6?=
 =?utf-8?B?d25ZQlNJRkRTVmtDV1E1YU5oNVkzdTlmK3dXNi9DMTBMYVBwMGxqMkxUTjZV?=
 =?utf-8?B?VlB2clUxdHE3cTZlZ2c0SmRuTG0xY2F1MzhsVFBYSWZOU0tVZmkvdHIrQjIw?=
 =?utf-8?B?TlBNa3ZRanNxZG1uUnA3WGJvOFdvdHB6NmFEVVYweGw2UWt0b1ZKOEtPanJj?=
 =?utf-8?B?VXV6bFlnN1VNOElPazVBV2JwcTBJTEJTbVlva25jbnRZS0ZXbUNrVnZ4NTNM?=
 =?utf-8?B?Q3A5S0hCRDBMQ0R4bWJoOUFYeHNXL0ZrYUhWdTdLOFkwdVNmdnduY3BsQ1ZZ?=
 =?utf-8?B?eE5hQ0dFZGhZUFlPUXowY3dGaGwxOExOSzZtSUkwdWZYTGJBREVnVlpYQUxR?=
 =?utf-8?B?WTRGRm5qT05CUEEwZlZIN0Y3V3I5YThpZytPNHJwcUdqV2VPeUZyb2dIcE1Y?=
 =?utf-8?B?bjJ2d2tyT0VhdTk5TTFSSnNnV0kyZndXWkRPN1BoTDlhVGlES2MxdEN4cHBH?=
 =?utf-8?B?TDZTaFY4ZEgzOVlDWG85R1VCajJiWjBTczBYMlJCUVk0QkVFV2pBQ1p1SXcz?=
 =?utf-8?B?QzdQWGFEL05ueERsY1U5VHJZcVFSZVhaVXVCbzY4L1BMeDQyYlh6SE94b1U2?=
 =?utf-8?B?Qkp1YzZuR0Y2RmhGRTR2V29NZjZ4THZOUFhWVnU5YmwvRG9Tb2dXK2RuREsz?=
 =?utf-8?B?ZDRiSE40WVlUOUlkZFl3NnI2QlV1bDdGbUtObjlVVUVqeXdKbWc5SW5zNExu?=
 =?utf-8?B?WlJSR1NiWVQzcWdpMDNVVldQRVc4U1dkWkdJKzNZeVRNZWpZdldETFpkTEIy?=
 =?utf-8?B?UGdSYkpxOE1PMFJTdkNHUUV2Zzkza2t0NFJpbkxVWkVYNW5JNXlWa2orSWps?=
 =?utf-8?B?RDFTRktHRGNnMlNFR2FqajNDa0tFRnBxVk0yd3hzTkR5VVc3ZytHN1l6TFZl?=
 =?utf-8?B?c2xucGduWmxkNmYvVHFUZTRGYnZIcUJReVZCKzBkd1BCdjY3dHl3N1JiaS9J?=
 =?utf-8?B?UUFvbHpDOVVZUTZ4V2l3cUFzUEFPZXZBdW8ybjdJT3JDSGJkODZmd00xQkln?=
 =?utf-8?B?bTdtYlVYQ1MydVczMmhrR2xKUHlWam1jdWg0QnkxWVpmd1BGeXU3SUtETW5D?=
 =?utf-8?B?c1hzV0JVU3pVUmVGVXMxNFpZQmxMaENTMnRYLy9admdaT0p3MmZWSWJFVkta?=
 =?utf-8?B?V1BNSnE0OWd5TnM2SkFrSTJqbGh5cmliTGxZTEVrcVhhNEJGMVY1RVNJcW9k?=
 =?utf-8?B?MUZ5UHRPNW5SdWxBVFFZQ1pqc0tMVis5U2E1cWU0My8rbkkyL3lQUWtJVW5w?=
 =?utf-8?B?VjZzZTgxUUdTMkhibWo4SXhZVlJnS0VhSkMwMG5wb0UxakJmTzYyMkRvMllt?=
 =?utf-8?B?ZFYyNlhJSytxSUpOUFR2WXB0U0g0K3Q3cno2RW5jaUx2QlplVE01ZmRHaXN4?=
 =?utf-8?B?bWYwbHBMT29kUDVjM1pkT0ViR2w4MzQyOW1JU1dNWkp2cngxUHBjZTEvRHBk?=
 =?utf-8?B?NytxTDEyenpNbTIraEc3cGU4VTlMSGpvc2ROanVmN2twYlEyOFlMRThjSE95?=
 =?utf-8?B?L1pvQnlhUWdINmZQM1R2VW5jY2xrNU9NVGlrMlZjcFB5M0ZGZWVKR0ttck9G?=
 =?utf-8?B?aTBaZG5STERDUmJ6M3RXczl5eXhiWmpJS2xhQVo4Q0kvOGdybEVFbW9FQlRT?=
 =?utf-8?B?VDFibkpUbGV2alF6TEN4NXBXMnp1K3ZpbUp2cUVsMGlLVnBoWDVSb0NRMjJq?=
 =?utf-8?B?RVFPR3d5d2tpQzU1cGJ4dDNnV1llRk1Wdit2blhIcGxGUmxRSFVXSmh0ekdi?=
 =?utf-8?B?Y2JFSzFhOEtnL28xR2ZndE9adU1ka3dVV3ozVEFVSlpsVWEvZU0yY1pYU1pv?=
 =?utf-8?B?a0pzUWF4TE4zbytKSlliNk5JNU81ekVycEMzYWNuc29Yc1JvU05acm9vOWFH?=
 =?utf-8?B?b3RDbDI3eE9Xb28wcTVWVjJPNVhGS1VqRUtOYXNmeWV1WFJad0IyWVZ0M3Fa?=
 =?utf-8?B?T09jYjVPL2lLY2VpTGlMZ0xNdUtTTXBmUE00azZDdHcyeDJyV0JrcGhKQ1Fi?=
 =?utf-8?B?c3BDSFJOY1JRdGg5U1ExSWg4N3NCeGZPR1VYR1dFY3M0MlRxcHpQTk5SQ0FG?=
 =?utf-8?B?c25QS1hlV1Y0SzRBQ3RDUyt2M0hSTjBKa2o2RndibWJLeDNxRzlPOGdRdnN2?=
 =?utf-8?Q?7IT6KGNFLziE32QQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <608FFC3449F42146B581544C953F4EA1@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: snkNKAAoZQ06utYAU2i1DmMBXU4yRg85R/wBDSLsh7BmJwxPHx+/oEFsTUKSzjSsV/kIz/YT/6Qx8F2v1ZkIFq5N1pMksIKZHNbSih87ik3mgeNzL1UEXQEXZ3hhLtmSNT1Ae7IoA8RWOXsBxINqM2kGXOteN8l5dV00GquqJlubgZbW1hmeuuTRD0XdyRgpxcyJtZaMBoc4xKEkH0SV7NY3EjhdHx/kxWPSita0Uy5ZyN4kW9Jjn/zC2jmT4rXJVQo4C7GN4h8XZKBk4C3u/2KCgMqO8o5pS0dKQEgCqMQNQs4OSWdO4jhfawRYqcElrH9leVTa2qHBn3MbSS/8VL7VF4nWobFqaw1cVezU0T82JKR3ZgmqpmtMoz+UkSJ9Bh05QjxMLojXuVXloKPD3nAdOH0fgS12VBioTcG0+Ke2ZOUHrbzVbpNPvUsF5sIZryJ1eZo2V2fMcGYBb20tOkI8OUeAVWlzsGq+wcn0M45ByGK+i1PI5kcX47HdqHWVzitNcJb1FAT/Ug2x0nzKwuxkqYQqwkUFnteBWL2yTrOvzaJ4mUjgmyZ4UzIs3uiB6VEVLdXJYH/WVV+BW9TWOGcDbh8Xlup9ANieejz30ezD2HIFeTtQvKRpb2PezgWN
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR04MB8303.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b17c9cd-194c-45e5-b8df-08de69e00d20
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Feb 2026 02:40:14.5937
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WU3Bhcc/5HyrqyYHKlT+8Ob4cyg8ImdEGj75adYSxfRu/dIb7a/AXR2i7fME3YKd7+Uxslwjn0hlla+547pa1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR04MB7930
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260211_184022_725548_2BB02887 
X-CRM114-Status: GOOD (  13.39  )
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

T24gV2VkLCAyMDI2LTAyLTExIGF0IDE5OjMzIC0wNzAwLCBLZWl0aCBCdXNjaCB3cm90ZToNCj4g
T24gV2VkLCBGZWIgMTEsIDIwMjYgYXQgMDQ6Mjg6NTNBTSArMDAwMCwgV2lsZnJlZCBNYWxsYXdh
IHdyb3RlOg0KPiA+IE9uIFdlZCwgMjAyNi0wMS0xNCBhdCAxNjozNyArMTAwMCwgV2lsZnJlZCBN
YWxsYXdhIHdyb3RlOg0KPiA+IA0KPiA+IEdlbnRsZSBwaW5nLCBpbi1jYXNlIHRoaXMgZ290IGxv
c3QgaW4gdGhlIHRocmVhZHMgOikNCj4gDQo+IFRoZSBwcmV2aW91cyB2ZXJzaW9uIHdhcyBhbHJl
YWR5IGFwcGxpZWQ6DQoNCkFoIG1pc3NlZCB0aGF0LCBzb3JyeSBmb3IgdGhlIG5vaXNlIQ0KDQpX
aWxmcmVkDQoNCj4gDQo+IMKgDQo+IGh0dHBzOi8vZ2l0LmluZnJhZGVhZC5vcmcvP3A9bnZtZS5n
aXQ7YT1jb21taXRkaWZmO2g9Zjk0N2Q5ZTc3YjI2MjM4YjgyMWI1MjI3YWZiNGZlZThjN2VhMGQ1
YQ0K

