Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87D4EC55182
	for <linux-nvme@archiver.kernel.org>; Wed,  5 Aug 2026 07:53:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:References:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8sE/BCp6j7qwvHPdxCcnuJd95+vNjrbdAjOs+re5CzE=; b=y7BbOZG3haQ+Q5V1wLq4Qn9qV9
	atHuhDt+ZDlkKSllUFDSQw0OKGZiBaWDm4J5lcyy+Msca4q65j1gphsBoaQlUuo6oKYRDl6l2yvdk
	g/iP/iH8WUfm0fu3mlgNlgPsO3r+IIm2mHLbzYikTrHfD0/TJLm12RiPYKLnRBycU/ZCqbHXIGtaB
	21/V5ZPqt/46hi0b54KGVpyfqMlNm4XJVmkz3AdyYfoDVBlzDe2jTCuJs5one9WguF+xreCCg7W67
	lpodptDK63opKgW5P4kkX4P+Ch9+L2COvvTsZptV4Q2zoq+5/LA9Lu8wbpP2cr2Yb15tWXOIZdX8v
	qITndT9w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wrWRQ-00000003QuM-1wK2;
	Wed, 05 Aug 2026 07:53:32 +0000
Received: from mgamail.intel.com ([198.175.65.11])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wrWRO-00000003Qtj-0XFi
	for linux-nvme@lists.infradead.org;
	Wed, 05 Aug 2026 07:53:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785916410; x=1817452410;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=8sE/BCp6j7qwvHPdxCcnuJd95+vNjrbdAjOs+re5CzE=;
  b=PbTJALpa+vI8TK2c4f2PjCYAAerJDQlvpPCnNZcRHTKLgC8A/ikBFeF0
   OXl9bb197oZ9Ix+Oha2WGPkcMDiN+xYb2mea7l+ijCTeSONPeF9HMlnkX
   Y1wACtIkBDdrKZ2ZCwgNqjaQ4nsmnJBDDAGGEKdLQuZMT4jPdW2lAxaoz
   bwXBu2u2rAjCGJZNH8wLSn0f9gHP6F/jsuCwHnNGjXwfxOd73eyjkVVUW
   3Kg6kKyXuEnnp1it02W0HaaeczN3UrghM1smsFhmACFSzSm+YMl0tWE5A
   eawQsHS9sPqizoHfAKH6Q4I8mw7EZmJIDsrPyaTbK3bVX9qavu1z+Avy6
   w==;
X-CSE-ConnectionGUID: W7KEyzlMSmSdw5WHLLdFpA==
X-CSE-MsgGUID: LkN/LmX8SxWOw9sU5DLhGw==
X-IronPort-AV: E=McAfee;i="6800,10657,11865"; a="96837290"
X-IronPort-AV: E=Sophos;i="6.25,206,1779174000"; 
   d="scan'208";a="96837290"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2026 00:53:21 -0700
X-CSE-ConnectionGUID: 7bFhj3XdTGCmIW/4T2hKVQ==
X-CSE-MsgGUID: Y0xFKmuNTxiRv8jUb16oJw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,206,1779174000"; 
   d="scan'208";a="257432359"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2026 00:50:22 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Wed, 5 Aug 2026 00:50:21 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Wed, 5 Aug 2026 00:50:21 -0700
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.1) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Wed, 5 Aug 2026 00:50:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O8J1YjVE1ToSTH6XnDXwNwuhwBKBkRJ1HbUJjEaPwtisDmVUEb4iB7IJB5/mpOGPt+6Sj1RbUxbvTRY3OEkzQg2/OYsrub+rt+FAvle5x82PzxZdTv1tiFNX/MkaE9KgLcjhh6v7of6ykzdcoI8guJ/DyqSDbD96Rckcmaq9cWfXm3wQnGeMc69MkMb8rZ8Sg/nG5XXN2VsOzoNF0MFt84YrCflM93s2QWwCtBQVnvtr7CxN7I8+UyFgaSAJr0zGN9RbKu3hzLMYCldxf7Ml7mvWh6CW5xKKmWsXCur+DIjs87pJ7fdabwEpasHsdWC1iK3wRqkl3mnuNsAOEeNM4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8sE/BCp6j7qwvHPdxCcnuJd95+vNjrbdAjOs+re5CzE=;
 b=qNxMl93bYj9TSK9F+ulnK8H2GbZPc5isNTM50Hbh1kjYA+R+2qhhOAwIPyWAoGGhZHuZ4spUoXCJnpfmNR3KFoT0zDTYDHkxehodF+6cGY4ic+O/1FUfxfDTf14pU1vwLH+nxEEH06tkfL1UEuV/i2HOrmLFGiXZupA2s/1D+rKSOL9/c4UEyEseBN0jDHI6Wul1b5+MOUd1ibOLkjWHBAFesNyZygewjoIGd7tpPZOXnd2+oXMAjngfLs2j/VpfCTP4J4mYJAK+tcFTGJdSgBdxzMUGItigHozwfBfx6yj6t56hei1zMNNVYskYDXFoUNzdT2AFfWvHxpa5x6zQzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS0PR11MB8018.namprd11.prod.outlook.com (2603:10b6:8:116::12)
 by SA3PR11MB9510.namprd11.prod.outlook.com (2603:10b6:806:47e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.15; Wed, 5 Aug
 2026 07:50:14 +0000
Received: from DS0PR11MB8018.namprd11.prod.outlook.com
 ([fe80::47ca:c2e1:9362:422c]) by DS0PR11MB8018.namprd11.prod.outlook.com
 ([fe80::47ca:c2e1:9362:422c%3]) with mapi id 15.21.0292.013; Wed, 5 Aug 2026
 07:50:13 +0000
From: "Guo, Wangyang" <wangyang.guo@intel.com>
To: Nitesh Shetty <nj.shetty@samsung.com>
CC: Alok Rathore <alok.rathore@samsung.com>, "akpm@linux-foundation.org"
	<akpm@linux-foundation.org>, "axboe@fb.com" <axboe@fb.com>, "Liang, Dan"
	<dan.liang@intel.com>, "hch@lst.de" <hch@lst.de>, "kbusch@kernel.org"
	<kbusch@kernel.org>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>, "ming.lei@redhat.com"
	<ming.lei@redhat.com>, "rrendec@redhat.com" <rrendec@redhat.com>,
	"sagi@grimberg.me" <sagi@grimberg.me>, "tglx@linutronix.de"
	<tglx@linutronix.de>, "Li, Tianyou" <tianyou.li@intel.com>,
	"tim.c.chen@linux.intel.com" <tim.c.chen@linux.intel.com>,
	"virtualization@lists.linux-foundation.org"
	<virtualization@lists.linux-foundation.org>, "asml.silence@gmail.com"
	<asml.silence@gmail.com>, "cpgs@samsung.com" <cpgs@samsung.com>,
	"gost.dev@samsung.com" <gost.dev@samsung.com>, "alokrathore20@gmail.com"
	<alokrathore20@gmail.com>, "nitheshshetty@gmail.com"
	<nitheshshetty@gmail.com>
Subject: RE: lib/group_cpus: make group CPU cluster aware
Thread-Topic: lib/group_cpus: make group CPU cluster aware
Thread-Index: AQHdJBJVEdPsyEea+0e7uZZLngfJW7aPEnnw
Date: Wed, 5 Aug 2026 07:50:13 +0000
Message-ID: <DS0PR11MB8018C3A66F07DDD46691DB5492D32@DS0PR11MB8018.namprd11.prod.outlook.com>
References: <20260113022958.3379650-1-wangyang.guo@intel.com>
	<CGME20260728145333epcas5p427c6b6d72bff02de3f29e6a6a2108958@epcas5p4.samsung.com>
	<561480862.11785314102640.JavaMail.epsvc@epcpadp1new>
	<DS0PR11MB801889FC50AAB91FCCAF8D3A92C92@DS0PR11MB8018.namprd11.prod.outlook.com>
 <270056930.01785848882032.JavaMail.epsvc@epcpadp2new>
In-Reply-To: <270056930.01785848882032.JavaMail.epsvc@epcpadp2new>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR11MB8018:EE_|SA3PR11MB9510:EE_
x-ms-office365-filtering-correlation-id: 3568c062-5626-4e5b-4a1d-08def2c62f01
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|23010399003|366016|376014|1800799024|38070700021|56012099006|11063799006|10067099003|4143699003|18002099003|22082099003;
x-microsoft-antispam-message-info: 2YKFbS95P4PKwZRdwmIaWIOlN/GZJW+B/72IgWC0SWVZBXLA5l/UDe2GE1fAzQ1i8HzY+JzSTqrHjyisGEra/frnLdriAd0OsijKvilG1xBJS14JRkP5lDxC3EEsM63tL08GU+llpf6JM4NPv/oZdLbdpW4jxEENWjWBYZJLkgwkwBagxkGhe2UBh3Fm+/pEoXUjRgzAdGfizmnKctdwng/OZEIfXRvdce/LcJRh7bD2j273iO4TjrkHKqPJhJNMbMAVV2AwiWLcmHfQL3uVzDdFyE89bYXtzq3z28rBvE3h3j++4yAV1p8ut3HexLi13Ax3CCpwLg2BkZ3ESyVxLzLjdU1pyU82Y0J2eOeYnHYME9++uShcxDkq03IXki64cHS/LCJ8J0EzQugXuP3NWwsHYMxf99PVdVho/g8LgDm24rzuw1lbihYEDLWK0KHEXC9xhYQv9hD9po/D1SPUiJQmjja6eJdRuf3brSFoBPfaua1qwbclelin7HpdfrX7uiBXZX+lwI68LgV1PYFU1Gs2HT2e9RHiNC/71ICYvHJWSr1oQBIjCpNgvBUJBRsq4uu0rMTJIEwSxiC1rjIOUQzTpsUrgvx/61Q93OgxtnGIhspBYafCQbw6/TRTw3ufTVk7juGYlpyPTbgS+nlp5A7d2FCN7giCfpnGTatZzllvV3luBHoNcBZ46w//TcWgQb9VpCUqHvN62iFA7Qdp83AZi/iZM1UspPeSOmkpJwc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8018.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(23010399003)(366016)(376014)(1800799024)(38070700021)(56012099006)(11063799006)(10067099003)(4143699003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MFZBbWRxWm9waHJNNFl2Y0ZNeEpURDNxRDBQK0tFNHRBeGhzRjI1NnAyUWFt?=
 =?utf-8?B?bk1UY1czT3VVamU4WUlYalZRWWU4a0NXLzVvRDFOU0VDSEtGOXJZdEhnQVhs?=
 =?utf-8?B?dFREVW1yQ2s2YUd2djJHOFZGY1V0YTlCUHp3a2FyM0FhWjR2OHZtRE8wRG5y?=
 =?utf-8?B?TGdkTm1FSDVBL2JQOXZLc2lma0JKZW5yRXpFVUhEemZrZXlJdHZLYTlBSXcz?=
 =?utf-8?B?SE43eDFhYjVhUzhIOTYrM0xKR0ZKcUJZZjRNallxZUpPUG0ySi9wSTVsUGtN?=
 =?utf-8?B?ckpJTzIxeFpqSFdHVjg0dG5KaXBvZlF2akdMU1JGRlpQL0RBNU5TaFBBRzl4?=
 =?utf-8?B?Nk5mTm84K1BiNFFvNWhLUGc5c0hwbGcvNGxqTi92WFNYNWxiK0FJSENTa3U3?=
 =?utf-8?B?WmVJZGRNenhxSzJwTWQwblFuNkRNS1oySVBGRm5YTUVLelV4RWMwekUySmt0?=
 =?utf-8?B?NUJ5NUI0Vm9RQlhFeTFWdGxDeUZGQ2ZYeUl0WFhDMHFuNlNYZExUTjJ5WGx1?=
 =?utf-8?B?aTgzYmtPczRIdmZod2tKdDlCYVFaenMzUGsxaE0rSEtHbXFWL2Q5czFRUHdD?=
 =?utf-8?B?cXpOWnJBRUYrY1JjeVZ6V1lJK0dSQ09ncTU0TXdZNWtvUklRQmRGV0pYQUV4?=
 =?utf-8?B?VzJ1ZlNPUXRjSmg4OUFPdG1pOStiTzBnVCtjMEw2TlJicVhrMUg2REtYTEFs?=
 =?utf-8?B?MnRxcXRpdXlWSmtBVGU1TkdORFVCc3JqVnJYQVoyMlQ0S0dxU0I1OVorelZ2?=
 =?utf-8?B?UXNKcWx1cEFlKzVuSitBVzhkNnp2QjJVVE9HbTVrMFBiSWZQWnVpaVVBL3lm?=
 =?utf-8?B?Tm8yQlYrcWJpQjhzNUNlK0JiMlI3YjdkM1prRHNSVGJHNjV6bGt5OEs1UFIx?=
 =?utf-8?B?U1JJeDQzRWtReU1FZVhWRXhINkNYUWUyMElzcVVzRWNQa1pUOXp2SittM1FZ?=
 =?utf-8?B?MGt2bmhMN296RndCZ1RKVHRMZTVIQm42SzZHRFJFbmRGODFTVGM0Q3RPenc5?=
 =?utf-8?B?RUtpQlVEZjhLbTR4Y3pjMmlhZVFsSFZvVU5Vdnl1Uy8zWjVvODZEbWxGd1Rj?=
 =?utf-8?B?UlRBVG9PQThSQUZzdENFYy9tckd6d2czaFZzMGhMSXpWOUpDM1c2TlZObXV4?=
 =?utf-8?B?Z3JiQnR0bGFoZEkrZzJjM0ZLZlJua3Zueit2RWlCZkswTzBXME5JV2E2SU5D?=
 =?utf-8?B?OXFIYnVvMWczdUFXS2Y4SzVWbXowUnFrUFVhU0hacWpzMGRIZXc1SmV4S2hh?=
 =?utf-8?B?ZC9tTDNMOGxtZzFJYmtOTUprZ2pPd0I1c2l0VW9BRG5uNEV0bnc4NlpOVUVk?=
 =?utf-8?B?NVVhRDRSbWxUdmJWT01BcWpkb3dhbHRCTmlzekVKUlFLbEExOFd0a0VZejNl?=
 =?utf-8?B?NlAzL3NrbFRweHE4WUFlMFRUd2VibStidUczZUg2ZUFCVCtMQWpuSW1sU0NK?=
 =?utf-8?B?NVJTYTBnb0ZaQ25PY1k2NmRjSmgxVHAvR3I1WE9LOXVyT3pva0FtWnpnOGFz?=
 =?utf-8?B?dkpCUVFPbkVNbmFqQjJJRm1BZXRZSHltR0lENC81U1h0bHNqc2hRVUxGd3dT?=
 =?utf-8?B?VDFlbXlnakRWS20xSG5nK0xFZStMcm9CMHZkdnNMcFRFd0wyNXBWWlVRS1Fk?=
 =?utf-8?B?LzQxTzN2K1lwSDJxZXdmamNPUnZNaHBSbnd3bFVxeElkYU1kcjNNNERRN1Nv?=
 =?utf-8?B?WUgyMS9xbXo3bzRNSDhIMllMeDZxRmpXOEd5Vk0yT0FUNWVnalEyU3pYbFFV?=
 =?utf-8?B?cGNJbkZKY1dyNjdPM2JDRWQyV00ybk9IVTNTK3lwdk0yNTd2TWhJQTI2K0lv?=
 =?utf-8?B?N1I4Zndnc3V1bDFmNXNtcEljdXRUK29Vb2VMSUF6bFlxSWkrYkVuakFiZGtT?=
 =?utf-8?B?dXVHR0Y4cW51eWtqbkcwS0lXeVJZMyt0TE9IdU9JWU9hbG1TektUMklmSklG?=
 =?utf-8?B?QVJDWHhtTWFQSlNMU0IwYWVpOHhoaStYa0xBZ1dFTFhiaU90RVZsMVRodjRy?=
 =?utf-8?B?QVpqZW9xQkFsc3FDQzNXczNsdFRxaExBZHo4YnNzYTE1YUpERW13ZStsWUZC?=
 =?utf-8?B?UXhzN0ZoOFlqSitJUjN2WnZMc0JCcDF5L2dmWWFNTjRhMjZRU1Vka2VjbnNi?=
 =?utf-8?B?MlJSakd5NlJmbnA1Tk9XWjc4cEtpcmJJZnlMM3NhNks2Mi9VNWxtTjhWWW5s?=
 =?utf-8?B?MzNGN2MwTTluZ1VQa2lLeitxY2dXV2RMMDN3d3RpbTlFNTUySmc5OG9ySS9V?=
 =?utf-8?B?OEEwc2RLQ2Z5dFFjVUNFa3JhR2pvZnZtcWpwdENHY3NlUytocHZyQ2E0MVlr?=
 =?utf-8?B?NTJETm1leExVMGh6S0ViVEIyWGRYQmN2V1ZwMjQ3UmJzWWk2azZGdz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: FUr/inUfZ8hOmc7H6nR21ylVUKBd/k5z2UoV4bvwnGW5nl2XDsetQyb5NBwJKZSYb0dNUEOwNr/+A+AgAYORWrUdkGu4yLd/rNsQ1Kx/kbsU4YlVQur+0sdMxXqmKFLjZYYAVoKPVkKuEtzv/1QG//ec1roBbxTAXCa3BpSv8AqQly4VeUvvoEt8B8iC/2GdMdhq2Y1AqWVSTJq0v5H/7KaRLOUjFojxj8D7Fvz41h1XdS1GaINkh/SPhW89Oc8NNkdzHrY1qzTri76eYyV9UOtfVNU/Z6bxk4aUB5WyJFAdOpbxIcmvu0bQmi/XIzXOL8Kg94MEeAP574jfJKYlKA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8018.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3568c062-5626-4e5b-4a1d-08def2c62f01
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Aug 2026 07:50:13.8936
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jx/0NzeRbySAwbPAIBZOrC/0Y5jaFuR8gKS6SG1Wkavol5Of4088QSnZEbkPFiw1IGBBA9dI7p1jeaaJaYqSPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB9510
X-OriginatorOrg: intel.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260805_005330_294328_FEBF8F39 
X-CRM114-Status: GOOD (  10.59  )
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

PiBXZSBzZWUgaXRzIG5vdCB0aGUgY2FzZSwgYmVmb3JlIHRoaXMgcGF0Y2gsIGlycXMgc21wX2Fs
bG93ZWRfbGlzdCB3YXMgc2VxdWVudGlhbCwgYnV0IGFmdGVyIHRoZSBwYXRjaCB0aGlzIGNoYW5n
ZXMuDQo+IEkgdGhpbmsgdGhpcyBoYXMgdG8gZG8gd2l0aCBjYWNoZSBsb2NhbGl0eSBlZmZlY3Rz
LCB3aGVuIHRhc2tzIHJ1biBvbiAid3JvbmciIENQVXMuIElmIHlvdSB3YW50IHVzIHRvIGNoZWNr
IHBlcmYgZGF0YSwgd2UgY2FuIHJ1biB0aGF0Lg0KDQpOaWNlIGNhdGNoLiBIb3dldmVyLCBpZiB0
aGlzIGlzIGluZGVlZCBhIGNhY2hlIGxvY2FsaXR5IGlzc3VlLCBJIHdvdWxkIGV4cGVjdCB0aGUg
cGVyZm9ybWFuY2UgaW1wYWN0IHRvIGJlIG1vcmUgY29uc2lzdGVudC4gDQpUaGUgcmVzdWx0cyBz
aG93IGEgNCUgcGVyZm9ybWFuY2UgaW1wcm92ZW1lbnQgYXQgam9icz0zMiwgd2hpY2ggc2VlbXMg
dG8gY29udHJhZGljdCB0aGF0IGV4cGxhbmF0aW9uLg0KDQo+IEJlbG93IHBhdGNoWzFdIGZpeGVz
IHRoZSBpc3N1ZSBmb3IgdXMuIEJhc2ljYWxseSBrZWVwIHRoZSBjcHUgb3JkZXIgaWYgcmVzb3Vy
Y2VzIGFyZSBlcXVhbCwgbWVhbndoaWxlIGtlZXBpbmcgdGhlIGJlbmVmaXQgb2YgeW91ciBwYXRj
aGVzIGZvciBjbHVzdGVyaW5nLg0KDQpZZXMsIHRoaXMgaXMgcmVsYXRlZCB0byBzdGFibGUgc29y
dGluZywgc3VjaCBjaGFuZ2UgY2FuIHByZXNlcnZlIHRoZSBvcmRlci4NCg==

