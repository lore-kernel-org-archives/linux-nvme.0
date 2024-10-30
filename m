Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83F28D5CCA1
	for <linux-nvme@archiver.kernel.org>; Wed, 30 Oct 2024 12:24:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=NbRqsCpJ9O9OPU8nsXO7mqUwQWku6Wi/kiA2yRfOnoc=; b=jxt+huDpXEgQPeQGK7sarblSjQ
	b+i/XWwHZ9d5orLlfv1Glte9Ja0DI3RemcCG6+sKkJDcEsx7QsuizAZD3DcOTI17tL51L/g0tPIhi
	MfkdaEOZn2RQj6gZ4cn/TwxI08bzd3PFpCH3UPC13xSnUe109TBT+VrRDAKbNbNR9ONC7/fgxbYFb
	s/z0QdHpywW8eG6Hfg4gghvPFWH0OtgvbguWLHJ4nFhpbREtjoNPxJClbOcMmQZVQjvyUFbD9m9Ra
	i24NtgKUZVbr3rY9ZPyZYDPRntNlpyigua8ChGKOaNRc7rm6YYH0GxCbahHOBPn3yy+YTGoIKTx2O
	IwBdegRQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t67kt-00000000Jj5-2p3d;
	Wed, 30 Oct 2024 12:24:55 +0000
Received: from esa3.hgst.iphmx.com ([216.71.153.141])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t67kr-00000000Jib-1FE8
	for linux-nvme@lists.infradead.org;
	Wed, 30 Oct 2024 12:24:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1730291093; x=1761827093;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=NbRqsCpJ9O9OPU8nsXO7mqUwQWku6Wi/kiA2yRfOnoc=;
  b=o2zA2/5OZebY6cUm6Z9wjKk9teEPMzYBjathoLCsYNm1qeLQ+DdoW7oS
   3WDQXRhDvT4FTtjgNhBNquFc1YvupWVo+m/KuNtA5WbxWXqWEfGGXUsS2
   SMtg1Pgm1puGDoFVofoSCnwHeJGoNXKnPRtP7OQ/jmEX4fICPNkogjSur
   drXRcrWEjKMURATZa1vpMKurNsa+sfbO3lXkmCex5kebctpQWTX2LvWVs
   cBHlTjO0t7CBL7gHa4oeB+eO2si2PX3Q0uCIgjIBYOQ86zIByPXuwtMvM
   Tdwl2/bxGFGYRDFeBgba79g5m43q3lxQDZA1fwOTx35cRHfrFPRoJn1le
   g==;
X-CSE-ConnectionGUID: tYO4ELPNRC+ISFvjje3k6Q==
X-CSE-MsgGUID: /mQFfpdHSC6wXV3gXB2nbw==
X-IronPort-AV: E=Sophos;i="6.11,245,1725292800"; 
   d="scan'208";a="30348262"
Received: from mail-eastus2azlp17010020.outbound.protection.outlook.com (HELO BN1PR04CU002.outbound.protection.outlook.com) ([40.93.12.20])
  by ob1.hgst.iphmx.com with ESMTP; 30 Oct 2024 20:24:52 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qw5plGm2SFZd8gbiqlwQBHyXPl4Mg5+yPUTS0+9WpEK6/B3U4gbipvFSIuSmOy8S3ndkWq7VlvctgV8a5QxyCt0SNFdqdtxUrX4kEPq073J9BiqmrFicmcVf5BFBepnlhKlOKC9r3SGjrZLDgWq2lyfjYzgHIy6GSgcF+v6hpIv7MRwAeaBKE/Q62dMaBU02WFXDBpv0BPBuPQRAiQoqOcr3Gvsbx5uibB8PUjDNkHLe6y4GX2o/Ez+fVraykcjhEWI10942nVBFeHHmUwyrjnkoM0/n8OvHdU7BJBPLnHKpHhaYJdsSfvf7aF6WRFCnl7ubu0y7jCA1uIO/+2ealg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NbRqsCpJ9O9OPU8nsXO7mqUwQWku6Wi/kiA2yRfOnoc=;
 b=B+9iV8GimqwVNlx/LRZOBerep7Vovrk/MV6Qdd3xGDPcUhYK/06mFbFYRuN5+wSQKXOcw0QnJsrK9PR5rlnBHDem3R+j1MkQN+VVTNSq8sU0y9aCR21O37PgvKtAS8QmXYvwJVxztPE4zqq7bAsupYOrlwsaUrxLR0NhhemvAdUhRSp2JBjJqDzCgahZba6/lsBHXzBFPNn2EuSeuSeFbrw4ScyuEuo1lCqG2px3bcEXxU3NuQeHE4YE8Ct1WTRyveJpaYmcW7aOXLurYo5TfAubq0978KL4CL1f7iFzYvVTzg78n6/uVNXNkRKKyplWKivW/YqvJnkrQkKzrz/Ruw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NbRqsCpJ9O9OPU8nsXO7mqUwQWku6Wi/kiA2yRfOnoc=;
 b=o00RcGNYhhzm/VC09C9vP/Yc53PjY31Iv+NbU8b37enqg17r7jxyMnsAQR0i8ytbUoSmJOBOQ8f+o1aROaWi31apy0WdEC+V8EQJTDXfb9GzVj2cLfnwnkFGSpdNntIc+zOH8+7zg4wn+PNztFRkkNIJrx6pC6ewU26X0KJ+OCs=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 BY5PR04MB6833.namprd04.prod.outlook.com (2603:10b6:a03:224::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.25; Wed, 30 Oct
 2024 12:24:48 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b27f:cdfa:851:e89a]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b27f:cdfa:851:e89a%4]) with mapi id 15.20.8114.015; Wed, 30 Oct 2024
 12:24:48 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Guixin Liu <kanie@linux.alibaba.com>
CC: "dwagner@suse.de" <dwagner@suse.de>, "chaitanyak@nvidia.com"
	<chaitanyak@nvidia.com>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>
Subject: Re: [PATCH] nvme/{common/nvme, 051, 052}: introduce def_nsid
Thread-Topic: [PATCH] nvme/{common/nvme, 051, 052}: introduce def_nsid
Thread-Index: AQHbKbFofh4etkxEjEuSAVUpfIuqMLKe6AgAgAAlNACAACzMAA==
Date: Wed, 30 Oct 2024 12:24:48 +0000
Message-ID: <hce3uo2wbe2dmj3shbophxbbxhjkns6oopf4sfstk2xu54v27c@ylyikkaawsvb>
References: <20241029031931.118305-1-kanie@linux.alibaba.com>
 <33susvhlxjt2uf3gqldcb2n43pgrvt5m2wj6b27nbgeoxamfkn@az45ko2fsydt>
 <9f17db9e-da89-47ba-9825-7f713d413daf@linux.alibaba.com>
In-Reply-To: <9f17db9e-da89-47ba-9825-7f713d413daf@linux.alibaba.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|BY5PR04MB6833:EE_
x-ms-office365-filtering-correlation-id: a8148f89-d024-400c-565e-08dcf8ddd8ac
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018|27256017;
x-microsoft-antispam-message-info: =?utf-8?B?ZGY3cEZKSUZpZ2JkVlJPdlpLa2ZxN1U3TjJPa1EwdVJGR1V1d1RpQ2xXZW0z?=
 =?utf-8?B?VHpYQmwrYjRCVVh1dEFyRXV1RmdUVFZ4YnJxMjBQZ3EwTzhOZXRtdmI3NWNG?=
 =?utf-8?B?ZzhWVTk3dUpiQVd2WUdDOE10TXh2Q1pxUi9IUCtrWkJFaGFFczFaeENLZU5v?=
 =?utf-8?B?UVZ2eUlvV0dHYlltQ1RGVUlxN0lEajJPVDd6WHFCUnhJTGxQQkZocVp4VFMx?=
 =?utf-8?B?L2NTb3Z1V1hoSHhJdjEzTElIWGNSU0dkczdoNFJGZmRQVUVROXRldS93RXBy?=
 =?utf-8?B?RG5hVjZQUkd1T0xtTU85TGQzNEIvKzZKS2Zuc0xoRE00VXdWaFR5Y295ZTEx?=
 =?utf-8?B?elV6WkJKSnB1b0RPV2Z4Z1RLVE96Tks0bExvaWdEbUVoYm9MRTRqOEZWdVFE?=
 =?utf-8?B?SkN5L25peHBNckQ4S01Uenp1akZKN1F2TTBkdzAzUVlEZ0F2TmE5enBIN0pE?=
 =?utf-8?B?ZmxnWlZSVmtTdVhjcHhBQUVTbzlvcElsa0ZPdDBnUWhKNGhyVlQxUVF3M3NM?=
 =?utf-8?B?SFhVNndmNmx3ZzY4Kzd4SmcyN1RkY0VlQ04vMFFQbGZqOUgxdzIrYkJwd09q?=
 =?utf-8?B?Z0J2QkVtZlA5ZXBmREpwSkNITnM4N1pZRWhNOGNRNW9rZzhWWjJwVnFJOVRV?=
 =?utf-8?B?NkF4R0RaWTZrTTF1ZktERkdsMHJYQWs4R1YyVTlhMURvQnNpR1Nld0ZvSnNV?=
 =?utf-8?B?Mkc4VDUzakZDUU1OMXRWOXJFeGlkR0Nzc3k3Z1FpWGZyOUNVMFFpM3NLZEVH?=
 =?utf-8?B?L1BvTUxVRUxXZGo2NENOTFhLS0wxRzlLQUJ5aDdjLzlQZ3ArcUgza0ttU00x?=
 =?utf-8?B?cE5SYy9JOEFraDBHYUI0aUJNZnlXOStWQnV6ODkzZFdkc3F0bEJ0U1pWdzBZ?=
 =?utf-8?B?cGhQVG4vZGpIcW1KUWpQKzcrcHkwTnFwaThPRGlCR0tUTnVhL0t5VExvdlMv?=
 =?utf-8?B?Q1hsbWhDZHZscU0wUklucitLbjd4NlJuYmdibFA1NVdXSEdKTjV4RXZOWEo0?=
 =?utf-8?B?R2xVcmRjbVI3WjJEeVA2TU1PK1A2bmtaNGo0LysrNnFFZDJsbWpQQkVFNmJM?=
 =?utf-8?B?dlpFblBZNHV5WmF0VU4wOVpKTWk5S2tWZ2lrWVB4dmhDb3RBV3ZTQWoxd1I0?=
 =?utf-8?B?TW1DN0JsRUZkdEtLU2g5NWVEbzhDbUFDRjBtNHlGT2NlSzhhNzJSRDRQSnRL?=
 =?utf-8?B?MUhDSFZ3ajUvSmlwcFVLZ0tLZ0ltN0JEYWVra2t2N2Q5U3Q1QkF6TkFaSmJO?=
 =?utf-8?B?dnVaNUpzb0ozaWJDRy9OU3lvVHl6ckI1V3d1c2dvK0czWmV6ZDBoVXc1Y3hu?=
 =?utf-8?B?bkZqWnRqek9yWkVFK01pQ1lROGFBRVFzb01ucDQ3REJ5QWROS1dxMURNcVRs?=
 =?utf-8?B?UjAxVU1tVzdHT2hSNnpWdkJoamNaeStpa01KNEllVGxLYnNzSTdDOEtWVmd1?=
 =?utf-8?B?d0w1YzRnUzRGZlRBVkttOTkxWm1PbFhBRVlwRlVoZDJkWHZ6NTV0UEo5R1do?=
 =?utf-8?B?RU1rQnNieHZHRzZDMlpsbnRQbWNtcE5MWVF1c1Nhc3VaQTV5MlNpajhSZVpM?=
 =?utf-8?B?OTUvWWU3bjZRL2pickFZTlN6VUtIQzVYLzFpTFZrUTVKZUpwbGtSZER1dHBo?=
 =?utf-8?B?TGFWUXZqb2VMOUc5RWNGZkx3ZHdtOG0zMDlCTkRBNFFjdXhqYVVaV1ZKR2h2?=
 =?utf-8?B?dzZXRTJkc3FnaXZsUDcyNGNkU0ZyYTRNc29mUVVNaFVRN2ppdGJwV2x6V20r?=
 =?utf-8?B?VFlzd0Z3ZWNyY3FPYzJsMUpRZkM0Q0JTTDBScG5TenlkNlpsZ2NkRERId0lv?=
 =?utf-8?B?V24zRjdna1pSL3FXWGswektVaUdxWEU3Si8rNVlTSkRnRDM4T3BNZVlnNnZw?=
 =?utf-8?B?Z0tqdVRLMzlkRXBnZm1UZk10OFh3cEZOb2pSU2RRRzBzR0E9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018)(27256017);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?T21JZFRxdUtUU2s0N2dzcWVYbFZlUG9PUXYwaDZ4ZDFYWVlFNlVaUFFHYVNU?=
 =?utf-8?B?UXF6bzBSOVBCMFk4ZDJrcFVCckMzRDNnMGQvYkpjKyt4VFZhdWFnZDRMWEZ3?=
 =?utf-8?B?VlNGdklYck1qY3FaNWlPNW93QkE4UlJUU2p3VjlsNWVtV3RvUElNSTNwYUpx?=
 =?utf-8?B?ci80OFY2WGw0cWJQN0YybHJJc0FUVlgzRUhndnZNbzBMaVVTWnErbzcyZ3kr?=
 =?utf-8?B?eEx2WTNtUGFWUnl5MHZFb3pVNEVGNGgrUUkyWFBITnljUnpYL3N5b1ZNc0FN?=
 =?utf-8?B?WitXZ3hIMXVESWlVMXpHNzcyUGJDQWJHOW9xVktKaXI2eGZqMC9mTldjTmc5?=
 =?utf-8?B?Q25lbkd5RUNLN0lEMlBCb0lwQ0FIeS9HcWhYZDdwQWp4YTBpazlZK3YwRS9x?=
 =?utf-8?B?ZXZlY0s2YW1kcnNMb2RaNnR6YmpWSHp4K29KdXU0bUErdy9qcGhORks5K0lJ?=
 =?utf-8?B?dWFaZkhWR3BqckswUUdKMURJc0RiWi9PMFFYUVBJL3Zpem51bGpNOW1icW1D?=
 =?utf-8?B?U20vTUQ4NENmV3lFbnN0UVpjR01TalM3ZE9OaXg0T1BLUUJML0dpVUphMVFi?=
 =?utf-8?B?ZEdtZThLVlVXT1ZnS0k0VGNNd1RiaVJia251MHBxSkdTRFpVL0dFdXNxeExQ?=
 =?utf-8?B?eUJHd3RwdldYcENNQmZjQkJnejBiWmxHeW5hcExZaUR1Y21KS3hvUWZqRVh2?=
 =?utf-8?B?ZlEyTytMTnAyMFE2cDlHVmg2enNYY05wb01UbzlydDdYeTRienlja1h6eity?=
 =?utf-8?B?VEtaT2NRT2ZyOHR5QnhwbGtZbGxoR0VkVDZhMllDR3AwS2JTRkVJVnkrK29J?=
 =?utf-8?B?N201Tnh3cjJtcUZqM2Nja1F0WHRLalBxbXlNdVZ2RzJVZVJ3MkV4RWdvUWRB?=
 =?utf-8?B?amE5TDVKUWQramNhOXRoSDE2ZTFhTGJ1S0UzaFB4Q3hNZ2dIMjVFdDh0cm1r?=
 =?utf-8?B?cjZJK3FNVnhiWmJWNkZNOXdCcHl6azA5V1oyRnZGODFSL2NZeHFYOTJlbnYr?=
 =?utf-8?B?d0tiOTBQbW9GTUpSeUZuN2lxV0JBY0pUZ0tEZWRnWjNybVhTUjNwMlo2VnZW?=
 =?utf-8?B?bmliWDBRQWVwcGhHZkR6ZFArbTgzakJEdlV4Umc5RGt5MG5CRGllZ1RYb21v?=
 =?utf-8?B?ajVkL3RLUjlVMWlIT3RIV3AxTzNLdkNYeTlCV0V6emJRQkVueHhYSGxKZUo5?=
 =?utf-8?B?dEVMMHJNcXNRVUY4OGY3S3NyT1QvajNzRVFibGRXSWw4UFEwdmRrb2d2dzdQ?=
 =?utf-8?B?TmhsSkp5K281OEhPbS9HaEc2TEdaTW44K0VTTi8ydktMdkxrcjdWM1dCbkEy?=
 =?utf-8?B?WnBkcEx1QnVzMDhMeVVQbmp4M3FyaHZrQ3FBcjdTS0hybEZhbnlIc0JHTlhE?=
 =?utf-8?B?Yjgwb1RtbzdjMHdZK0tsQjllMjZ2MWIxZWxQaE1DRHAxVnFnalhjYmhZWG13?=
 =?utf-8?B?aGZTS3BaNzZDMFFZd3BSU0MwWGc1SzZWSXFzUVg3SnhXNW5qSlJiQ2RjSGt3?=
 =?utf-8?B?THd1amFoRXlyMkZqUTZMdkJxQlJUWmdkUzh0SDBDU29lMWVaeG9xcWNFK3RR?=
 =?utf-8?B?aUJrRGk5WVh5VnVjODFST1dORUYycjdwYTc2UUhDbUcwMEp2c1JHUVBYdXNW?=
 =?utf-8?B?aU9uTEtaZG9sTExJdDFEWlpMc1VuQ1BmR2hIczMyVWdYSTNmSE9HbUtlMTZF?=
 =?utf-8?B?MTdSU1JETTd5ZWVKMEUxczl5MDBpSzhOWW52TXhYamFtUjFYbmJCSW42c3Rw?=
 =?utf-8?B?V1VTRVFjeEJPKzV6ZzhBVklnZ0ZDaXdCbklUaFlhSk45RTVpWDFDdmQ3WFZk?=
 =?utf-8?B?QUJrbUg4MllITHV2RWdIQUlPRzA2WHp0U1BCdUxLZUlsV1FxTHN5eTdQM3ZZ?=
 =?utf-8?B?TmNSUTBjdW1PaVFiVkhQRm1CQzhEQWxDU3o0QzA0VDNybloyUThxU05vQU5l?=
 =?utf-8?B?RDVsOVI4WEdhTkFWUUxMQWVkZkt1ZnlmL3FQZWVqWlMzWWJHbGJJVWxRVU9u?=
 =?utf-8?B?b0s2SnVhUWlZa21aRkVVOEhFWHF0TEJ3NkJTZ2xPaUlzREs1U2cvMGxlRmhB?=
 =?utf-8?B?NCt0YUlDaytaUUppUENUOExKTi82WTRYRmoxY3hqcGZLUTdic2pRU1VodnZ3?=
 =?utf-8?B?bjdUa2ZOUEl5cE9qdmMrTyt6WkZFYjk1Ni9QTGRvWG9MQU4yOGVuWFlXU1Q5?=
 =?utf-8?Q?KzUGbtfDNZf0N+xS4URpn8o=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7433D6678C765545ADF97ED936755742@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 4f5OljLJFKiYfCvgj5fi/AWm3aixCotrVgWHx4dxXP77nD/bu1Qak7fmnfWwCeGrrGenLwMYzCE8K8FCFmnoC0kpOvAIMr6OkyXTMOsu5yq4lXAZdaDSQtF9hzpLl+Wc8mkX6IR7ZDDlzkQ9FtpkxZBD6pF77qESyJz7uh4LfeTUMD3JpxfRNz5Gsr3h0YVRxSVeYeDiGBcR06cerC8fDiuKcuOYIC6oOm+/SUK+6XPMWG9MzLkNgkiNQ2uL+ZubcKh8TMMg37/RkenVLZnqbQBnXdNwWuKclJoUOqp/lzqXrZDDlzeZGnXld81NJdez/QuU9zUyu2+sGl+bbTh+/CC5S4NsW2TTy2bW4v7DsnFfCP2r/ppF53R/eEK74CkN6QUuXX6Ux1Jr4rQDQYuG+brFEncJ6ztsokncXW3IC4nJiBowNYL3NzE5X1s1NS0lXSM1mDxDTovHhpPk/8/LsU4iOUZ3Wd3+3Sy5fYMVVl2wxkM089EiwnhBfI5Wks4uzYVRgH192ewtPi2Zd9DksRaTefZDHgKV2uV8/DoVewr2RTU11aHxTYIlPQuNUsAvXu3v/2TOLdLHepHdJqbSe6OIp427BlUQHihOEGBPgyQvKzuTYHgpG9tdGRAm9PHe
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8148f89-d024-400c-565e-08dcf8ddd8ac
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Oct 2024 12:24:48.6256
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: s6B7oXndjI29q/kcF5GjWjns58vf3kG4nUUDFqQkHxJ5avCZR+uRHkjHGOZKOOO/t8VXZmnpoLam/GtwptsyEASE0rTI9zj06u5jRE2iJIY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB6833
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241030_052453_371151_945B85FA 
X-CRM114-Status: GOOD (  17.00  )
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

T24gT2N0IDMwLCAyMDI0IC8gMTc6NDQsIEd1aXhpbiBMaXUgd3JvdGU6DQo+IA0KPiDlnKggMjAy
NC8xMC8zMCAxNTozMSwgU2hpbmljaGlybyBLYXdhc2FraSDlhpnpgZM6DQo+ID4gT24gT2N0IDI5
LCAyMDI0IC8gMTE6MTksIEd1aXhpbiBMaXUgd3JvdGU6DQo+ID4gPiBVc2UgZGVmX25zaWQgaW5z
dGVhZCBvZiBoYXJkIGNvZGUsIHRoZSBkZWZhdWx0IG9mIGRlZl9uc2lkIGlzIDEuDQo+ID4gSGkg
R3VpeGluLCB0aG5ha3MgZm9yIHRoZSBwYXRjaC4NCj4gPiANCj4gPiBNYXkgSSBrbm93IHRoZSBt
b3RpdmF0aW9uIHRvIGludHJvZHVjZSBkZWZfbnNpZD8gRG9lcyBpdCBhaW0gdG8gaW1wcm92ZSBj
b2RlDQo+ID4gcmVhZGFiaWxpdHk/IE9yIGRvZXMgaXQgYWltIHRvIGFsbG93IHRlc3RpbmcgdmFy
aW91cyBkZWZfbnNpZCB2YWx1ZXM/DQo+IA0KPiBKdXN0IGxpa2UgZGVmX3N1YnN5c25xbiBhbmQg
ZGVmX3N1YnN5c191dWlkLCBhdm9pZCBoYXJkIGNvZGUgaW4gdGVzdGNhc2VzLA0KPiANCj4gYW5k
IGxldCB1cyB0byBrbm93IHRoZSBuc19pZCBjcmVhdGVkIGJ5IGRlZmF1bHQuDQoNClRoYW5rIHlv
dSwgSSBzZWUgaXQuIEkgdGhpbmsgQ2hhaXRhbnlhIGZpbmRzIHRoZSBzYW1lIHZhbHVlLg0KDQpJ
IGZvcmdvdCB0byBtZW50aW9uIHRoYXQgeW91ciB2MSBwYXRjaCBoYXMgdGhpcyBzaGVsbGNoZWNr
IHdhbmluZzoNCg0KICB0ZXN0cy9udm1lLzA1Mjo2MzoxNTogbm90ZTogJC8ke30gaXMgdW5uZWNl
c3Nhcnkgb24gYXJpdGhtZXRpYyB2YXJpYWJsZXMuIFtTQzIwMDRdDQoNCkl0IHdpbGwgYmUgYXBw
cmVjaWF0ZWQgdG8gYWRkcmVzcyBpdCwgYW5kIHJ1biAibWFrZSBjaGVjayIgZm9yIGNvbmZpcm1h
dGlvbi4=

