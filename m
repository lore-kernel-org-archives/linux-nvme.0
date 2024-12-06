Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DB48E7716E
	for <linux-nvme@archiver.kernel.org>; Fri,  6 Dec 2024 01:49:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=KONjdZFhbry1nkrVFY9rc/LqcLsd0chQmydHBIhkMDc=; b=4rR3EO7eWApiaIzXUgnHRLJ6Yn
	1ty0mA1ulCuIaYi2cZxYbKAQvA20nUyHYbaw5JRai49Pa71k0dP+FDTDQCP+Iy85hCMwSTvdw+pf6
	1b19IzqmZCQXiwHovV2S2+XmHwBRd7xwF0iMoND4N2akfyaOEY1JdQskD7R8CKE6JH1a7GHtnlnET
	+qnoCaOZLT297V1J+t3w13GF+HGfbGh5995JLgNga1GW8KrlX+nUAOTsbOWUVJ7W2wcio/7YTWxkp
	lb+LqwP9OUHAyx6c9KsF80s6FZsRWFsVNWImVJX6NxQ0mdLwKKz0q2oeie/3EQlTd+wSXzXc7DGTM
	eUXY7v0Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tJNTA-00000000EXl-2PIp;
	Fri, 06 Dec 2024 01:49:24 +0000
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tJNT8-00000000EWp-1W3m
	for linux-nvme@lists.infradead.org;
	Fri, 06 Dec 2024 01:49:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1733449762; x=1764985762;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=KONjdZFhbry1nkrVFY9rc/LqcLsd0chQmydHBIhkMDc=;
  b=Nz/xck7mhJ7ibRbQkPZunsluBVZNWYtbrEhUNIy8ATy11rAddLjbIBl7
   CrC08vhizSXiFiTyYOhiibPQC3uBi8qxEyRSx+iWaXGyXy92iWu5DqpHQ
   tSmCGULs4qN76gGqWU+FGvR2utJ83ZtO7EP98ldA8P6V9Zi3NgE5vynzT
   lPv77L+mZtksTpNv19EKPfdS1y8iz643w4D7uNM3rzgvo4iqHHmAWMm52
   Mh7WtcAe920JTcUSKd5vK1jvTqJUQ9naCpxOCQEzXVAuP9eYH3ZrFwc05
   Z6hUNEokmSTVTWONMrwA6WkQy4oYtqIjAa5ipjMrkaYBFPMyfOFoWVrrU
   A==;
X-CSE-ConnectionGUID: XTJQFYAkTMChLDitqjotjw==
X-CSE-MsgGUID: pJhiktXaQlONtaZ2LaquvQ==
X-IronPort-AV: E=Sophos;i="6.12,212,1728921600"; 
   d="scan'208";a="33700108"
Received: from mail-centralusazlp17011029.outbound.protection.outlook.com (HELO DM5PR21CU001.outbound.protection.outlook.com) ([40.93.13.29])
  by ob1.hgst.iphmx.com with ESMTP; 06 Dec 2024 09:49:19 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qWHQDnbaW5nCGTkQhjRytQgqpwA3/X1nWUpGcZgDAy1yqVpw8t+LSk+TLq3Zua2ruXk+E9+GaVPHE8qF6pejrA0qxoYX3/+UcyqD2YDE4BymlOya4Rbiu3x/kDQ4XHyArVQ+BUG0v3e0nTGSlMOUCElVrQSBsOH3T/cJkqgAK5/llLbcp48b86viDNgTV7XGyb1PmARC4ZFaWiK20mzLYaKC/DsJVFM2eFvvwFLOcRY9kW0S0IqHPMY99rFEhnoxLVoHCz8dCot5rhKqSJpLPkQjJuca2rzR1Dlq+O8SlhX1Iz+Veo514OFoIU95fXh2+kwljh1izfak6h3bgCqCtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KONjdZFhbry1nkrVFY9rc/LqcLsd0chQmydHBIhkMDc=;
 b=KTkvX76bozMbmBb7NZSqtCeYrFXR5okDupgdyBNOXYsuGM6Dzo/VeO2DW/ca9NBBdmTDUT2ld+F/JjJat/uE59YUQzmyCpg6BBxxNj+Ofj5heY9W+WVhXT8hv6rTTYhBu/BdiIHg3YPYyDuHFfWuEwyz8ifhYiqp8k8FJf5c77AuZFeQzJVtqYq0EKFr2zOQb8MaaPdZtQxxwUU+Xxwoj0n8cdKHltSrA6YpguYfpS5nyrWWVlz71y9+2hlwJJMcTimp4CPF1AKcjY9rh6a48f7pg4jrBLMuAWlFAsJ1s02niLM7ZxYghrJ4FpFr3fvyyutnBYHTI0Wr93W1OwOemw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KONjdZFhbry1nkrVFY9rc/LqcLsd0chQmydHBIhkMDc=;
 b=eGXZM6NWepzziPklsnDr5sfPXjtuRB1fcohwwTUXTvfRe9WpLkGJfE8SeFNkxFVoLeu5E1xqifwG0zwpMqO3DSvmL1bWHIP+4Qi5jrMYlBEq/GqGvR/DxNC2ryr0E0wYDBVjjnoyfh4FT/0zDRTrRmK2OG1iiFLfAJzjbdnblOc=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 BL3PR04MB8042.namprd04.prod.outlook.com (2603:10b6:208:345::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.11; Fri, 6 Dec
 2024 01:49:17 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b27f:cdfa:851:e89a]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b27f:cdfa:851:e89a%4]) with mapi id 15.20.8207.017; Fri, 6 Dec 2024
 01:49:17 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Daniel Wagner <dwagner@suse.de>
CC: Nilay Shroff <nilay@linux.ibm.com>, Chaitanya Kulkarni
	<chaitanyak@nvidia.com>, hch <hch@lst.de>, "kbusch@kernel.org"
	<kbusch@kernel.org>, "sagi@grimberg.me" <sagi@grimberg.me>, "axboe@kernel.dk"
	<axboe@kernel.dk>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>, "gjoyce@linux.ibm.com"
	<gjoyce@linux.ibm.com>
Subject: Re: [PATCHv2 blktests 2/2] nvme: add test for writing to file-ns just
 after disabling it
Thread-Topic: [PATCHv2 blktests 2/2] nvme: add test for writing to file-ns
 just after disabling it
Thread-Index: AQHbRkJsYHodhWgyBk+G3JRa83MQDLLXQ0eAgAAjnYCAABLCgIAABUkAgAAD+gCAAPKvAA==
Date: Fri, 6 Dec 2024 01:49:17 +0000
Message-ID: <xl4mhtb5bn35q4pmvopcvyrbrr2jlyukbjcfotmpp6tjg7wq6u@kmaizfj644k7>
References: <20241204114755.190660-1-nilay@linux.ibm.com>
 <20241204114755.190660-3-nilay@linux.ibm.com>
 <5178056a-4297-43ca-b15b-dfb8d9b21857@nvidia.com>
 <62addb0a-d115-4b2d-af3c-cedc41991f7c@linux.ibm.com>
 <adbeb95d-40aa-44c3-bb63-01c0a49f5182@flourine.local>
 <fb1058c3-ca47-4a54-8c1b-7eb9fa449fa0@linux.ibm.com>
 <7775ee47-980f-4f2f-8642-cfbeb984df30@flourine.local>
In-Reply-To: <7775ee47-980f-4f2f-8642-cfbeb984df30@flourine.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|BL3PR04MB8042:EE_
x-ms-office365-filtering-correlation-id: 61bbfd5a-48e2-448b-e0f6-08dd159831fd
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?YTNDaFIxTElhdVYyVWc1WCtPK1NvaC8rb2I1WDJPQkMvcXJ1aFk4eUZ2dE1I?=
 =?utf-8?B?cDZKR216SVFZblNKRmxCQXBXQVdmNzdiR1k1eCt1TEV3dk5oTFdSMTNwR25n?=
 =?utf-8?B?SENZRE1wdUtFN0NlL0VGOEo4dFgxcTNsS1NIRzBiQUc4NWFTUE5CT3FncDBV?=
 =?utf-8?B?L3V0c0d3WXQxdE5oRkFMeVRJYU1ibisrU3J3eXhXb3BDekhMSmxBcERQeFlp?=
 =?utf-8?B?cUZXbGpoMmRMZ0t0N2lTbTBQOEM0d016djRlZGZvNEpYU2VLaGdhaGtIZWc2?=
 =?utf-8?B?b0R0Ulp2UmVlaVZTd2hMMkpQREZneXhPNEtLSTM1amtQcnVVTGVVa1FoWFJU?=
 =?utf-8?B?TFVtUmpUTmxqQjFJRTV2WkZLK2d1Tlp1bXIrdTloSkk3NXF5V0lWamlBVVN0?=
 =?utf-8?B?M1FTWVUwR1FLVFJjcDZGSlN3YjhSd0RNbW9XV1NhQVBzd3hJOXJyOUhIb2Fk?=
 =?utf-8?B?clJQUGliUUhCQkF1TjdPYmM0QWdRcXBXa0h1eFJzak5yVGNhZm9mYkwvbE9o?=
 =?utf-8?B?R0dsYW9LLzVucGcwZnZQNUNnK3I1VWh2c0RCWDY2K042MDZKL3dnR0JkdlEx?=
 =?utf-8?B?QlVmQk8xQVFwMHJZaVhqbTB2QmdtWEkxdlEvTFBVMzl1K3cwbzI4THJPSXRL?=
 =?utf-8?B?czR3MVlFNHJZUEE3S3VYQVcyUkMvUUhuUXNiVGFMMmt5YllRQWpOUUtIWnov?=
 =?utf-8?B?aGlBMTA5cWNyTE9BcGgrMjZ2emVTS2duSVlBaWN3K1YxTExUSGxudlhjSUtw?=
 =?utf-8?B?SFRpemZ4bzJCQlVNYy84YmdPYnJsQ0pCUXBFMjBETG5lUlBhTkQ4M2NybWI5?=
 =?utf-8?B?aG1NQmpKK1pJZjlKTFVrc1JIdGd4RGRnRjdkbG9leWhybXRKTFh6R2xLQ1RF?=
 =?utf-8?B?UjRHUk9FM3NKcko2YW03U1ZYS0JQbDlJZ0NQa0h1VlNRWXI2NkZXY05OU2pr?=
 =?utf-8?B?NHBnSlBadjN5czVjT1hDeUh1Nms3M212Qmh4M3VGSXlsNkk1NzBiSHNqRHdH?=
 =?utf-8?B?TXQyMksyWUlubXN3dE1uYWlYbnhIR1ZybjA2Q0dGMG56eXV3MkpNaUxtOGlp?=
 =?utf-8?B?cHlpNnJHQUUvK25KTjM1dU9ETUVYM01GSFNMdlZVMW5XZmhUQUFqM0hFOEJB?=
 =?utf-8?B?NEZqR2lTWXVMQkdzSmNWcThJdXNFeVZCcUJkSEh3R1plZHZsWC9oekJ4V0Jl?=
 =?utf-8?B?bDQxdUMvcERxRnlwY2FLSldWcncyMHEzS01FcE02VGx0RkRwZVE5c1lhZ25S?=
 =?utf-8?B?dGpzeDEwSEdJeDF3aWFNdWVONmFXdFhrYkhxOU03MTlIazV0YWJ6Qi9sK0Nl?=
 =?utf-8?B?UG0wYm9mbEIrODBlMTBsdE02d28rb29tVFdPeVBtRVZIT3MzaWpMMXNEcnpi?=
 =?utf-8?B?am45Q1RHUzd1bUFJTk1ja2kybW53N1VNa0NJelBpelFRNFFQSndtdzFaVjlX?=
 =?utf-8?B?NkwzRncvQ3FseGJ0bmdLbjBnOGp0SWZZL3RVZy9BRUVCcmwwS2laRWVmbjgw?=
 =?utf-8?B?L2Zma1lGUnlGL0sxQUVueDJ5WmJ2N0tvMkxSOVdxT0ZhN0NLNloyZ0VMY0Jn?=
 =?utf-8?B?eERzMUFRdFRTK29mYjcvVnNuWnVCWnJCMWx6bGorc1JYTkIvNjI0WVBYY054?=
 =?utf-8?B?TXFHYkFxVHVsenprNzAyaFY2QWJLUnJzNEJxWDgxUlZzRHU0emNHS2s1NytD?=
 =?utf-8?B?QS82VTFHZW9SelZ5NHZLQmo4eTJsdlBmRStWa3A3UU9pOC8yRDUwcXZxMUoy?=
 =?utf-8?B?aXhOaW9yNHU1cCt2bXFrdHIvbmlkd0RuZDBrSTdzM1hGLzJoM0h1NitBUmlJ?=
 =?utf-8?B?LzE0SGh5NURuekN6R1BtaDJvcXUvd3hhZ2dIaElsUVNOZzBDeWlEU3hHVXVi?=
 =?utf-8?B?MjJBb3ZrU2Z4YWJ0NldUTkdtZWR0c04wRGJEeDZDbnFESHc9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Q0IwWFBDOGFsdUxPZFducnIya2laTkJwSHJGL3k1bU5FbVJoTkZCUUN5WDdU?=
 =?utf-8?B?bnFOM05pR2FaNGY3NE1STllJM2x6QkR2TFppMWU4Q1k3cGF2eTlENDJ5VCtZ?=
 =?utf-8?B?Qkh2VVo3eE9vcFE0a0xWNGpqT01GTER0eGZBYWdtT0QvMEZhSm1zM09uSVpn?=
 =?utf-8?B?bnoyZWhOc09aQWdSZ3Eva0dxdVZUbCtKSTJSWnlBMG1iV2JsUkVya3Bya0V1?=
 =?utf-8?B?Q09RWW1qWW1yckd1VHo2UzM5TnVHTTdtaVYyQlo0NGYzTWNySDYvTzB0SWNM?=
 =?utf-8?B?M1BKR0tWMjNHanpQRTd4b3hhS09sRVhSeEV5SU9MdTRlTktZN0lyQi9IMjdn?=
 =?utf-8?B?TldSQnlnekUxNzNxSHpFd2g0Z1dkWjF1eWdpSjlVQlpkWk4wNHM5emFyQURE?=
 =?utf-8?B?RGl1dTE1MDBMekFhUTUvMWVtWWg5NThaVUs0cXBOWm5hc0c3d05rMXhIWHVl?=
 =?utf-8?B?T0o2eTZRSUZYbjFoNTFETkg1djE4N0YvNU1FOENlZnZmSElvNWtwU0o5Q1Vj?=
 =?utf-8?B?bnlOV093VTJyY1VpY2t5NkhQakF2Wm93SHBLMnRGNFA2TXdkWk40U3FxT2l1?=
 =?utf-8?B?b1BHRkdyNzB2bElMWkQ4cmpxbGRHYUs2aTdvVUVDT0lkcFJVUitoYTFFRGlQ?=
 =?utf-8?B?dVlCTFFrc1VsalEzS0lkVDVYclFDMjNqRldYd3RFbnVLd3g3M0hKc05OUjJB?=
 =?utf-8?B?QXhLWXNaU0tJaktuR0FtakZSNEFnWHpuT3NGNEVmRFhZbVBhdE42cXNNYnBj?=
 =?utf-8?B?VmdjOXZScnRIR1RMTzhLbWxmZXVlK1NDWDcrSkltVkZ1UzJsYWFRbmo4T1p0?=
 =?utf-8?B?N0VNem1NQXhsUWVrSGVDRTIyZ0paQ3g3SkhZOVZIbkU3Vk5tM0MzMG5hcWhX?=
 =?utf-8?B?aWZQRk9HL0RjMW1NMmlxL0k2VlBlakd0VWtjMHNwTVFydy9rYjF3Q2JreVdV?=
 =?utf-8?B?eml0SExvV21jb3Q1ZzJ6a3IzS1hYRng0NnR0TmdsMW5GazN5RkFOcjUxME9y?=
 =?utf-8?B?YW5aVy9vdGMrb256MC9yTmZKZmJDRTJsVUx2Q25pZU5rN2Frd0NlTDJSc2NC?=
 =?utf-8?B?YWFNY3hzUkZzUlNJN1pjRHBMak1PQVBrcDhIYXR5b2NrWXdsNHZMOTlrUy9M?=
 =?utf-8?B?MFhPL1Q1QytNdU1NUGJZaVVSYkNodEhTZHptdG1aU00vTS9tSUN1N1owcWNE?=
 =?utf-8?B?QmIzMUVvQkw0NnRBWkcweEc4UW15OTJadkVGcDBPQ0xhV3VUQUs3ZmYvV2pv?=
 =?utf-8?B?aDB0SS9RUWJIS0RZdm9JbjRFUE5sakdRWkVCNVJQWDhoSmVqc1pubHI0Yktn?=
 =?utf-8?B?MWExeUtMdXQ2ZWkranhEQXdLb0tlYmF5WldCMmdPMlA2cWJDWG0rYlh6c1Vu?=
 =?utf-8?B?dmpTN1lMRmFnMmJwb1FrL09BOURFd2VxcDJoa1lqZm5ISlZtT2pEOWg0WnZl?=
 =?utf-8?B?WWxZMjE0YzFLejdrOWRCbThxNHhLWkdjMkRlOWhlZ3RYdUV3VXFLN0pjWXY0?=
 =?utf-8?B?OUQxRFI0QjYzMWtMNTY0dFJ6eG5qNWUyeG50N1ZCNFFzdVlHRk4yZ1diWFYw?=
 =?utf-8?B?bWpReWZqY0hEVHpjSEhkQUJHcVRET0U4VUU4Y1lJNzFaN25kM3MvWlZEeWtm?=
 =?utf-8?B?eFdvQ2hBd0duZ0xLVU8zSWsrSmNndnNXSmJlc1hTTlVVZFpwTmhIMTdRUEpT?=
 =?utf-8?B?OG9DcUthUFEybWpmRDk1R2FlTzl2N0pOU2V6UVNvNGlzT1EwMnlLVFZUVVI2?=
 =?utf-8?B?OU1mdCtLWVN3ZUdjZnRKZmNkeW9pc0M0NlEza0dyaHdobVRIZU1pSCtuMnEr?=
 =?utf-8?B?VHFaTzF1cDVqQ21VSXByKy9XcXVCYUN1MUZuT3ZBVytubWNweDFmelNRVHNU?=
 =?utf-8?B?ZjN6QTZib2daeldxK3BKa1lLR3pnZnhCMllCS2dEaStzT2NMN3grUWVqZHFn?=
 =?utf-8?B?QUhleTN6ZnY3UTBPaVdSRXBFU3VyY0sxSzd6VkhGSGhFK2EvcW5ZS3o4MXBr?=
 =?utf-8?B?dkFVNnN2OE5YN1FzSW5kSmMyY3pNOGlUN0Nvbm8vWkhKajBFb0ErZ2VhNmNM?=
 =?utf-8?B?ZmhxUVIxZG11N1pWOG8vNTlBRm1oMDR3QmVhNFRTQVU4bDU2MmFmb0huMDRH?=
 =?utf-8?B?QmtaOVpxNS9uUGRYRmhFRjNJeGNHQVBTL3ZndVhDanVvU2tZbGd0QVhITHNZ?=
 =?utf-8?B?Nmc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <061BE72321A38844912AA0B1765202B4@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: LXMZFvFwa44GmnDBsan6gs7fFcqlCAKc1ER36mUKijTfwEWlV0DN/gE67lv217xy2xd/VVZW6HQa7b7W0YZpZrW1m7sC2m8K5xzOKFsVMvZ3UG7EK7qPcj8dsMzbjo8hzKGVmgcn8KsBn5n1m36KacZ6adSGp+7gVKmz3wgP2SxZphSJzKrUAEPAaNiQ5Husz5EJDaGFKszb/1viVaZajovBCgN9wT5Lp/Z1TknzJJpwlyEe6Mgs4lS1oEI3qjVzvxrKdwiKUkhpcZg4TpfhxIGRZhlW6fyKpnnTe0gGUtfbWWBqGFzvRob8902VQ2vRVHT6w/Mm5lPLCnr6cSPJadXZajhMRSMgUxtpB4lciGwVzUg/xrNHCDwa+lMqccDnuMVcIGNXSmJJLK+2pNkdTA4YmgeW4tCAHrI66N+DLES3bZ5RbBZzfCS0+byfcn9vcBxsZGiyXHTYIykTtAhL8a2ajc7uj3ADv//7VmqUIt1A345n90o+OsPpuME1fReKV2Ue08jfgXxjMziF+YRaeNfnavoQb00ItXKaYXgxb8D2PIFTdDqTVs8jzC0vwBItOVhZCuXPizqBugjApPcB0PIVyyDFVjWDvyaFtEJYO9/pEIUR0uviW30Uu2EI8kGs
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61bbfd5a-48e2-448b-e0f6-08dd159831fd
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Dec 2024 01:49:17.4323
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ym+gqWFTtu9yLA28C9NY9Kklxa5Bu2DTOTm8kORkldtaD9osPu0b02KYRqLGZ9hzXO1t55DXLKDttTc3uO1dfdtWiXbZE3zx80sqe1e9yuo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR04MB8042
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241205_174922_479851_7FD3CDB2 
X-CRM114-Status: GOOD (  15.95  )
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

T24gRGVjIDA1LCAyMDI0IC8gMTI6MjAsIERhbmllbCBXYWduZXIgd3JvdGU6DQo+IE9uIFRodSwg
RGVjIDA1LCAyMDI0IGF0IDA0OjM2OjI2UE0gKzA1MzAsIE5pbGF5IFNocm9mZiB3cm90ZToNCj4g
PiBTdXJlLCB5b3UgbWF5IHJlZmVyICI1LjI3LjEuOCBBc3luY2hyb25vdXMgRXZlbnQgQ29uZmln
dXJhdGlvbiAoRmVhdHVyZSBJZGVudGlmaWVyIDBCaCkiDQo+ID4gaW4gTlZNZSBiYXNlIHNwZWMg
Mi4wLiBBbmQgdGhlbiByZWZlciBGaWd1cmUgMjM2LCBOYW1lc3BhY2UgQXR0cmlidXRlDQo+ID4g
Tm90aWNlczoNCj4gDQo+ICAgQXR0YWNoZWQgTmFtZXNwYWNlIEF0dHJpYnV0ZSBOb3RpY2VzIChO
QU4pOiBUaGlzIGJpdCBkZXRlcm1pbmVzDQo+ICAgd2hldGhlciBhbiBhc3luY2hyb25vdXMgZXZl
bnQgbm90aWZpY2F0aW9uIGlzIHNlbnQgdG8gdGhlIGhvc3QgZm9yIGFuDQo+ICAgQXR0YWNoZWQg
TmFtZXNwYWNlIEF0dHJpYnV0ZSBDaGFuZ2VkIGFzeW5jaHJvbm91cyBldmVudCAocmVmZXIgdG8N
Cj4gICBGaWd1cmUgMTUxKS4gSWYgdGhpcyBiaXQgaXMgc2V0IHRvIOKAmDHigJksIHRoZW4gdGhl
IEF0dGFjaGVkIE5hbWVzcGFjZQ0KPiAgIEF0dHJpYnV0ZSBDaGFuZ2VkIGFzeW5jaHJvbm91cyBl
dmVudCBpcyBzZW50IHRvIHRoZSBob3N0IHdoZW4gdGhpcw0KPiAgIGNvbmRpdGlvbiBvY2N1cnMu
IElmIHRoaXMgYml0IGlzIGNsZWFyZWQgdG8g4oCYMOKAmSwgdGhlbiB0aGUgY29udHJvbGxlcg0K
PiAgIHNoYWxsIG5vdCBzZW5kIHRoZSBBdHRhY2hlZCBOYW1lc3BhY2UgQXR0cmlidXRlIENoYW5n
ZWQgYXN5bmNocm9ub3VzDQo+ICAgZXZlbnQgdG8gdGhlIGhvc3QuDQo+IA0KPiBJIGFncmVlLCBk
b2Vzbid0IHNheSB0aGF0IHRoZSBjb250cm9sbGVyIGFsd2F5cyBoYXMgdG8gc2VuZCBhIE5BTiBB
RU4uDQoNClRoYW5rcyBmb3IgdGhlIGRpc2N1c3Npb24uIElJVUMsIHRoZSB1c2VycyBtYXkgaGF2
ZSB0aGUgTlZNRSBjb250cm9sIHdoaWNoDQpkb2VzIG5vdCBzZW5kIGEgTkFOIEFFTi4gSW4gdGhh
dCBjYXNlLCB0aGUgZW52aXJvbm1lbnQgaGFzIHNhbWUgc2V0IHVwIGFzDQp0aGlzIHRlc3QgY2Fz
ZSBwcmVwYXJlcy4gU28gdGhpcyB0ZXN0IGRvZXMgbm90IGxvb2sgc28gd2VpcmQgZm9yIG1lLg0K

