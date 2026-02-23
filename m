Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D781E98DF3
	for <linux-nvme@archiver.kernel.org>; Mon, 23 Feb 2026 07:44:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=K5DCogS1lApyTs0OAVSSYi583GLrFGgQl+sQseL/mwY=; b=JWhEGJZ4vpUWKeRD3y0GoaH+mu
	OmJ7EcQxKimbCZW0qAPiQBV38/6fgLa/mmrgUbJAo9K9Y2Mn2oi7hwVAUTScjepPpuzurzkVNM+K8
	YmWnuvbjCZMfSz6bXI936I+iTTIxxKCHZXwHdPhDoxNId40VCkjJbdrkV7LtBNla212uoQtwakSiO
	blgNsW+2DQq4WMDUU/Lzd1/nW9gXS5eb356FCNvQasjvowZ65R0c5JcjXBNSleSxhdQs8T8j/U0kw
	tbrNewspnlqlPy/yn/Rl+t2zuEwH8cTeTHT19sLenE+4psZQj/7dO2pqAUyQDabWMi+0ApjoaJWHY
	A2mADgjg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vuQc5-0000000HOro-1Zjq;
	Mon, 23 Feb 2026 07:44:17 +0000
Received: from esa6.hgst.iphmx.com ([216.71.154.45])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vuQc3-0000000HOrP-0AVO
	for linux-nvme@lists.infradead.org;
	Mon, 23 Feb 2026 07:44:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1771832653; x=1803368653;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=K5DCogS1lApyTs0OAVSSYi583GLrFGgQl+sQseL/mwY=;
  b=BDey/WUkYY67JEQ/ZPQ5as9r44fVH2CoW4ombXPmwf3G3YvBRK1EtAYw
   +ylzbrtVJEIpfhyV2vcjsH8Sn+vHsoBSO49rrDkT457qKJMWVpFYPD4Ib
   qT2ao9vnkSZ7/44T17a3TRr42I6qmEScn9Ownjb9O1VLtbT+uTM8EBBgp
   Y+It4Ls8io+ePt2KpZWhrzMtpZbYAWKdK8NEAl7WdOqQ4FMcqVtDKWXlg
   /e2ZTrEpPwSe98Rtb2ZjJSwIwJ2zRuFcdYbcGVY8anLwvENmSHsee+p6/
   8xhRtcTuDDi7/Tv4vF06Ouhe2PQqKNE9d94ucJhvPfQ7CHdpsjUcC8oUX
   A==;
X-CSE-ConnectionGUID: mPULZTaHQD2HmNVR7mDtCg==
X-CSE-MsgGUID: d+x8igcGTYiR+rW6ZKMPfw==
X-IronPort-AV: E=Sophos;i="6.21,306,1763395200"; 
   d="scan'208";a="140297847"
Received: from mail-northcentralusazon11010011.outbound.protection.outlook.com (HELO CH1PR05CU001.outbound.protection.outlook.com) ([52.101.193.11])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 23 Feb 2026 15:44:07 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QU80EO1xtQWXv+5VqujwdijO7ixPVcpJzYFNI7kC+RvRnCimlvJpFxPG8y8RJ7a3sN4kRIx3g9Gy8S9r1itHTwc8iZ9x+xmucKfl2ByU2q8slQ9ZJ6dTnTFtZKEGI/PtWnIt/CuvzHa5nl7ZI1xp6HzqEEWZLiO9Uw37gZzmKK6iJ8cdt3mseCJApSTaUinE/TDQuXEDU9+y5I8fRLjmoiCHujvDPkdjQqLdpIjg1N03cMjTtRLigdJCeanhnkKczCoVViGo1u42r9WVka4edbH2Q0wCEMe04NYrorrMCYUcm04yxWNaYa14cflUBpxga2uOTjTHDksxZXJ6qHu9bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K5DCogS1lApyTs0OAVSSYi583GLrFGgQl+sQseL/mwY=;
 b=tpvAdsxWxw02YsGnrjsfsXILqrd+gJHhJE9tD1DnADZFD0j/S4dRn7wSrjg32jCLHEMn0/XsgteSo72ERmpkMw/bh+7Rt0STSGG1MiSBwmcZ3hSgxvqATIgplCcl9NKcvCT7xyY0xJ8jkqZgaVbAeI4UjP7/HW+E9LP3mgXatV2IjG4wcF7qIzb8llE8ljuotCbdok+1RzImOWp4Ka9PUdr6g6HmN/VuXXTC909VgngvV513YleEV2LUHEu4MqlOxyopMBM9pLyNCdSzIAaARCnaSAE9dUCBwDkSAa7i8GiJYjC8A126LN8fK+jIHYT4mjYlH8J6cRXa6AVSmYrF3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K5DCogS1lApyTs0OAVSSYi583GLrFGgQl+sQseL/mwY=;
 b=TvjWOfbwhXtM+0QmIclh3eCksKIis373qrM46NqqcaGB6KsjLPwnbSDV3qQtqU53qmWtk8R3VzBxGiZtcypnw8fO/MhAtdO9P2sD4J5IpH4eFgGbb4+/aTdBZR8tvZzGEcQEpE+Pb0lC9/LOQyvBJ7lT8Irm/DMi0hJI2o1Oqeo=
Received: from LV8PR04MB8984.namprd04.prod.outlook.com (2603:10b6:408:18b::13)
 by CH4PR04MB9458.namprd04.prod.outlook.com (2603:10b6:610:245::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.21; Mon, 23 Feb
 2026 07:44:06 +0000
Received: from LV8PR04MB8984.namprd04.prod.outlook.com
 ([fe80::14a1:5b7a:6cf4:31a3]) by LV8PR04MB8984.namprd04.prod.outlook.com
 ([fe80::14a1:5b7a:6cf4:31a3%3]) with mapi id 15.20.9654.007; Mon, 23 Feb 2026
 07:44:06 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Haris Iqbal <haris.iqbal@ionos.com>, Shinichiro Kawasaki
	<shinichiro.kawasaki@wdc.com>
CC: Daniel Wagner <dwagner@suse.de>, Chaitanya Kulkarni
	<chaitanyak@nvidia.com>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, "linux-scsi@vger.kernel.org"
	<linux-scsi@vger.kernel.org>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>, "lsf-pc@lists.linux-foundation.org"
	<lsf-pc@lists.linux-foundation.org>, Bart Van Assche <bvanassche@acm.org>,
	Hannes Reinecke <hare@suse.de>, hch <hch@lst.de>, Jens Axboe
	<axboe@kernel.dk>, "sagi@grimberg.me" <sagi@grimberg.me>, "tytso@mit.edu"
	<tytso@mit.edu>, Christian Brauner <brauner@kernel.org>, "Martin K. Petersen"
	<martin.petersen@oracle.com>, "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>, =?utf-8?B?SmF2aWVyIEdvbnrDoWxleg==?=
	<javier@javigon.com>, "willy@infradead.org" <willy@infradead.org>, Jan Kara
	<jack@suse.cz>, "amir73il@gmail.com" <amir73il@gmail.com>, "vbabka@suse.cz"
	<vbabka@suse.cz>, Damien Le Moal <dlemoal@kernel.org>
Subject: Re: [LSF/MM/BPF ATTEND][LSF/MM/BPF TOPIC] : blktests: status,
 expansion plan for the storage stack test framework
Thread-Topic: [LSF/MM/BPF ATTEND][LSF/MM/BPF TOPIC] : blktests: status,
 expansion plan for the storage stack test framework
Thread-Index: AQHcm5X2GyQlbhzV6UGhlrLvCD3GoLV+sd+AgAHNZ4CAA8rPAIALrx2A
Date: Mon, 23 Feb 2026 07:44:06 +0000
Message-ID: <ae47ef06-3f66-4aab-b4ab-f3ae2b634f87@wdc.com>
References: <31a2a4c2-8c33-429a-a2b1-e1f3a0e90d72@nvidia.com>
 <459953fa-5330-4eb1-a1b4-7683b04e3d45@flourine.local>
 <aY77ogf5nATlJUg_@shinmob>
 <CAJpMwyis1iZB2dQMC4VC8stVhRhOg0mfauCWQd_Nv8Ojb+X-Yw@mail.gmail.com>
In-Reply-To: <CAJpMwyis1iZB2dQMC4VC8stVhRhOg0mfauCWQd_Nv8Ojb+X-Yw@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV8PR04MB8984:EE_|CH4PR04MB9458:EE_
x-ms-office365-filtering-correlation-id: 8cee217b-c557-4053-0caa-08de72af5279
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014|19092799006|10070799003|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?dlpWamVVTkoyM1UwR2lFeEJ3SVBiTzFZTWJHYjI5SE1ValRkQ3pYSHlqWE1Y?=
 =?utf-8?B?QStUZS9lVlF6Q3NwQUF5VkFjOTM5amd4Q2R0ZW5zTWllMU5JL3pscTMva1Y1?=
 =?utf-8?B?Q25vM1NFKzBwdk0zZ05rcm1md1B6UzlYaSs3ZXAzM2l6WUcweCsydzZMZE1q?=
 =?utf-8?B?MzhyT1M2UXU3dElvUDJ3cnRIK05NOXVRdGV4Q0dMbXdtbnU4SnBFbnJtUDdM?=
 =?utf-8?B?ZzRXcXdKamVnTC9ocC8zU3hxNldFVlZKYnBpa3JucEFQQmlUUlppdDFDbHc3?=
 =?utf-8?B?TVNHQ0dSMjB0MWRaTDIxUlJDY1ZDckoxdURENGdzL3pFUWxJeDUrcXd5SURL?=
 =?utf-8?B?WTArV1JrdHMxcXczVXNWUUg2Q0RRMy9KTFdVbEd2Yi9KMjQydkpERWdraEZJ?=
 =?utf-8?B?cndiOXpOTU9yUHgyS0hNL1hpYW8xRFRudmI1YXYwZW1xRFlhQmJlakNtcjR5?=
 =?utf-8?B?eUwwV1RJSkg5aytIVUhBZDI2ZGhHemVKVWVXVG12eUNyd1UxQWJjQzVQSGdw?=
 =?utf-8?B?SFRJNGZWM28wazVMVlBWMmNkcVRob3g4VUxIRGFsMW5vRXJFbTBFZHhnazlV?=
 =?utf-8?B?bmhxRVNxQXprVnhFd2kxMkl6c01EZzNlSElubkJvOHZmeDIxRnY1dk4wdThD?=
 =?utf-8?B?cWFDaWQxZWgzWlA1ZnpjdWhZU05VbUgwZWgrREhHdUsrM3NhNVNSK0RLQmU0?=
 =?utf-8?B?REo2TXNGT0wrcWd0RDVkQ0E1VWM2c1c2QVVsYzVMd3hoRUhuSU9aWVM2RThp?=
 =?utf-8?B?MjNtTFplYytGa0s4bkorQnNDNXhzeXFJaTYvQVVPUzBQcEQzZ1NVWUdBejRG?=
 =?utf-8?B?aDEyNlNiR1dOZjJVR2EwRUhjYTJVTnBBYWY3NmhvckxaSUFXUVNuTVFwOVM1?=
 =?utf-8?B?OSt4dk1TUUNsK3BQai9TWlh5SGNnV1VrU1Jvb3pRRzl0bS9tcG9rYjJvNmJv?=
 =?utf-8?B?QVc1aG44Z3NLYzRNWm5QZ05Fdy9uWG1iWWxkcEJHVmhCcHdXMnVKamN3Nk1V?=
 =?utf-8?B?YlB1TEI0cUY5UGlscUFCM1NPVGtIZEQvS2h2NU9GVnlLQzhuclVMeEJYbWJx?=
 =?utf-8?B?OThiU2xqbjgrb2U5d3BCYWpDSUxDSUxWR3haMFY5R1FuV2UxWjJ1b0hhM0N2?=
 =?utf-8?B?TnRXc2ZPbTd6Q3Z4SkdoNWlyaGVUai9Wd0lvQ1c0dnRlazA1d2NmaWJVNGQ4?=
 =?utf-8?B?MU5Rd0RlcEJNOFlSZ2N4QnpQNUhaS0JFaFh2UmRoeDArcXROdytsN2Fyc0Vi?=
 =?utf-8?B?UWMzQ0RaNUZHR2xscy9qL1pERGhsT2JIdkJVcUhncDJDVnNoNHQ0YmdhbUdk?=
 =?utf-8?B?cW1EVDI0V1p6eWwyeG9DcWM0YzdwZi9ob09GMGxON01wbkVEN2IxeGM4RDJy?=
 =?utf-8?B?YTVyZkVoclF2NkxHQlA5SGNWVnkvMjdzWDJLMFR5ZGZxZHVMOGdLMFVGbW92?=
 =?utf-8?B?ZjUxcjVpVndOcDRHZ2d1YzJNNG9LZWYzUUFRa0M3bjR3KzJGVkUwbFI3TFVr?=
 =?utf-8?B?RHV4OVdMakJZanhkWWxrUGh4eUsxalo2Z1VwOEZJaHBpL3FWYTBQelNNNnZa?=
 =?utf-8?B?R2FZT1YrejVsZlgyeHZFNXRSTHdXd0tjL2R2S0lYUnh4SXFUME13bHMwcE5Z?=
 =?utf-8?B?bVR2Zi9UekJhYmhhTG1iZ0Rid1cyYW44U0xSNkp0QWk2aEhJY2RtSEthTWwz?=
 =?utf-8?B?bDNKMHM0d3pNekR6S1RKQjdDQzZKZDdidGRZSUQwUkJYbUEzOXVhcDBJenpV?=
 =?utf-8?B?c1dJSXBFZFZ5MGtUS3dQOWNCbTdtSEtiZU1veXBYOWZXbjlHYnNSa2hVeUVO?=
 =?utf-8?B?eGxaRERKR1Y1dWp6d0VqWGh5WDBPSEdmdGdYbUoxb2grbzdFM3VwTDErV2tE?=
 =?utf-8?B?UkZtRHpZYWlqRmRlM250Rm82cW1mYWxVN1Z5QVk0eDE5V0RWcm1haGJEOEU4?=
 =?utf-8?B?Q0RIUjZ5OTc1TjBYRkxOWVg2Q0p5RTdteVRrL1JDS3lYRkVaTWNxUWxqbGhu?=
 =?utf-8?B?STlpZ3RqM2dqNzZnUlJqZlJqUXUyNUhlbDNBay9BVHBVTU9wc3c0eHp5YTQ2?=
 =?utf-8?B?djZGZjg1alhYUjR4WUFWTDVnaDc4MHlDcDdFK0hMSmcxZm1zRVkzWFp0SWFm?=
 =?utf-8?B?ZHRFY0RRcGNvZU9aVm9DOFV3bkZVamNyTmJzNUNBQnBrbXhzNk5wYS9MbEpT?=
 =?utf-8?Q?Hx7wYvDeGNJ2asii4cmK9lA=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR04MB8984.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(19092799006)(10070799003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VFVpclBUMWtvMy90STJvWUFQQ1VDelhYK3NZT1dodFRBdVNKaHIrbVQ1TENt?=
 =?utf-8?B?d3FBWmpuK3dwVXFUOHJBU090WHhTcmJuRnhLWS9xc1BsZGVXZHpzdEdmZHF2?=
 =?utf-8?B?VCtpUDFDVExFa2tyazVsZmZDSjhGc2ZBdDl4MjdKK3VpUEpGa01lVi96WWlU?=
 =?utf-8?B?UkxxOWY2dGpsZS9Kb1JDT3RaYUY5L0MvTGtTRldzY1dCbk4wVDRsV3pQL0k0?=
 =?utf-8?B?THp4VEZLcTliWWl0NjJiOENmekhzRnhFY0pKQTJyYjNMTjBzVUtBZnk3Ui9m?=
 =?utf-8?B?bzR1aWpSL2EyT1F5SDhEKzIvZFBRUUVNS3pQalRMejZWYWhlZS9UeDZDQlBR?=
 =?utf-8?B?N29JL3hxN2pOQWVKOWtWRkhGdlR4eXBDVEFtMVh5bUU4OUhIU3dFWjlzNHRt?=
 =?utf-8?B?UUZuZnVjUTBDM1VqaVVlc0cybkNvT0duMDlDWndlQnR0QjFjT21rQWxCbHho?=
 =?utf-8?B?dU9HWElJM2xOOHpqN3JnRWNIN1NGTUo1ZVl2VEZTZSt5Y3dHV3ZsL0ErRWpi?=
 =?utf-8?B?TXlDQzh6QVJQbUlKaXpIVkVQa01QOGpUMms0cnZYbFZVUlFXU285WHd2ajBL?=
 =?utf-8?B?WTFtVXJsNlhJSytHeXRiZlFEelZ5aUFsaUpqWXBwbEdUYmJxTmpZUXZkbW84?=
 =?utf-8?B?akxLTjNQVEVyK3ZTU09JYi82U0U4OW1uSnZKd0ZkLzlyWkR0czlkdmZGVmtO?=
 =?utf-8?B?OHpVQXYwNktmREVUeGdrSk1OWnB5OWhlZ3k4UUgyd29mYmQyempCdks1UW5x?=
 =?utf-8?B?N3ZTWEpObWNldVZVc3NOVDVhL0JqcGYzdTgvekRqNlpyVVhhSFRWalFDSzVn?=
 =?utf-8?B?TUpja3ZDUjNCZEhmSTI3bnRySGM2bzNmbFV2ZStQZHdFMzNuUllQUEVXRlpx?=
 =?utf-8?B?V3ZXM0FpRFU5NUhqN2ZPRWM5NmRSTFpOejlNUXhzYUtvbFk4L0xzdU1SdUtp?=
 =?utf-8?B?VU1DN0tYb1QxdXNnQ1Y4a1JIVStkSjNMbFpSbnR0K2UrL1ljRjl6M1JtQjFY?=
 =?utf-8?B?R0dpRmVUTUZRZEhLWUdmaUc1L2RFZGJFZlJ2UFdnczVMWTBOWlpHYlBvMldF?=
 =?utf-8?B?RUZKMG9ZdmFRci90Wk51RFJka1E0MHAyWTZmdlVYT29LejhaWUIvaFpOcDBt?=
 =?utf-8?B?MldkM1JxSGJROXFzN2lJcE1NYW5HVERZaTh0SWhrMjlQZXVGU0xtYW9icVRE?=
 =?utf-8?B?dWdva1hHem5GVG5DUU02ektRekF3TUYwRHg0TG55V2JJK0lMbC9LMGNKaUV1?=
 =?utf-8?B?LzNDSFRjNFE0em1kQ2EzVEN1N2dubnlISVdqb3R3d0xTVlhtbkRyS3FmazFX?=
 =?utf-8?B?VGRNbHVrYWdRb29yd3RDaTdXWEpGMTNqTGY0ZUFqR3kvVEsvQnZGdTRyRVE4?=
 =?utf-8?B?eGlpK1k2M3R5bjkrMHR5UEhvdFlrMVUzUXp1cCthU0dVY1I5OE9mNFh1QzdN?=
 =?utf-8?B?bWduc05nVXJUVStyQUlFNGdibVlFNndGVjQxZmRXbmNsOGQyVU1XaEVQL0NI?=
 =?utf-8?B?SFdYakF3MHVUbG5xVHVkUVdjUUVXRFVpczluR0VSNFFnck9ZSkVscVQrU1Iv?=
 =?utf-8?B?S1Y0ejh4K29yRW5zTUlDUnVWdFoweHF2RWRBdS9nN21mdGtOWGtKNkNJclFD?=
 =?utf-8?B?SURYM3RqN1VpTnFiWGhicnBHbHpHKzZHcytkS0NjNXhHaHFXRHFxWEU4cEMv?=
 =?utf-8?B?VFJ5TlNKZzZyRFdSVEM0cmh6ZVRCUnp0d2Y4d3VHNEdTTmgyL0IxaWllYWs3?=
 =?utf-8?B?ZHBmeWFRYnh4Y2hiOE1vV3FyWkI0eU9wbnplbnQzSHBrKy84cU9xaEZSeFN6?=
 =?utf-8?B?dUV2bUp1NmJjOGZDMnFGY3A4VGZzdzNHc2p6K1NjWmFkeG1mb1l0ZWYrQXlC?=
 =?utf-8?B?UFJUYmYwVVYzRWFleDcvVHlDdXBKdlhyRTVPTElBRzk5U1N1UThOTXpaTG1X?=
 =?utf-8?B?Q01yTVBuNkxHOG10UXBmK1lyMUg0YW9YbmtXK1gzZDRyOHh1T3Vhdk1WT3FS?=
 =?utf-8?B?ZzZicFhja2MvYjJkamRhQzNyODBnMFdIdE9SRUNseUdJV3YwdmQ2WTB3VVd6?=
 =?utf-8?B?V0pHbWpkV1lGaHV2TjFFdXBWcjVhRHF0WG14WC8wd3RWTk5ycTNycnYvM01N?=
 =?utf-8?B?N0EydUJBZUdiOTFrSWlLWnFuejlxRHBKUkJVQ3Q0ckVZdlFPOExDQVY4dWdS?=
 =?utf-8?B?S0wxaDltcTdUcW4rUGhzbTBqeXRXR1lhT283M2I1VXMrc1pFK01DQzh0dmxL?=
 =?utf-8?B?ZWZlSmJwQjMwVXpiMkl3NXlzZ2VjOGR2U2hrMGhiWjdtOW9HM2FKM0lxcDF0?=
 =?utf-8?B?Nm4vU3lpd29pRmhBenRTQi9ZcnRXM2NpMUNSTzVQOGJIak52RzlkczUvOE94?=
 =?utf-8?Q?Kx1NZEDFud1F0wm57MfiHGTj+Mtw5FaFu9PyY4zi+jd2Y?=
x-ms-exchange-antispam-messagedata-1: 1ajKDosL9Ymrg3ElNkOE6rp8fs+MEKleTf4=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C7CF4C4D2AAAA54D88A6A2D5B17E1193@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Nmo+9Tvp1Px7rBnHE2IxSedRzSkIUPk/slZE8zQWc09oMOIXj7abWa3Al0Jxviqed7lfJhGJeVk/GND77yKVJfoMD1aiFfOpNpD930Eq92ja0uLUOPsW/1bxAAhO9RC+12WO/T0Mgx94xRYVPEeYaXl51QIk4/mEyqx3ab8fq4bPXQCxOlkvkvu1QMLSY4GUaDpVitwhcLpfUJ0rrCOfVRvFpIabAwlEWs2u+izsB7O9+28We4qPygzv+IFRHL5P6SyYIu1ojlIjrd1g9tDdikgh6B8T+glGvop+R0ZGif2w/b1FGV2HcZh9wOi/XC937XuCSPTZjP5aqBTN7mFuUEvnhzbMQD9z18kpIdTaviZZftaKZ96JJL1FiWh7/J/f2JaZ66somyCxAqDJY/JpRk9UTh7A+Q9o9a/vuVFMZbzxAvXyXOycHwWYVU8TlnRRjurJSH4pQbzyPr8WrpKsMckYqGNA1qDQe/EL9e0tBbfinno7qdmrf8Tx0e/zOppnSwdS2PciilFY9QNqtTSJz0svIwxwihzfFSekDljAv1wtHhrkU32kfqgZmhs/wLGnTTjvGM+slu97OwWawE6DrhfKx+j2dKaMNVXBmI/qagJkQBHkgL7AwR/hsWWqgNOO
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV8PR04MB8984.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8cee217b-c557-4053-0caa-08de72af5279
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Feb 2026 07:44:06.1318
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: M14HxWRAvp7j2hk2R6oGlW2YFnYtD4GcxFiQ/T43hNtlrqjbSYYLVbaojC1E7QSTv+pBEHbrhwvsjxdeX2LjtEq1gMH5v/Mj6g5BqrWhYm4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH4PR04MB9458
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260222_234415_240041_C6CDEC3E 
X-CRM114-Status: GOOD (  14.82  )
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

T24gMi8xNS8yNiAxMDoxOCBQTSwgSGFyaXMgSXFiYWwgd3JvdGU6DQo+PiAgRnJvbSBteSB2aWV3
LCBibGt0ZXN0cyBrZWVwIG9uIGZpbmRpbmcga2VybmVsIGJ1Z3MuIEkgdGhpbmsgaXQgZGVtb25z
dHJhdGVzIHRoZQ0KPj4gdmFsdWUgb2YgdGhpcyBjb21tdW5pdHkgZWZmb3J0LCBhbmQgSSdtIGhh
cHB5IGFib3V0IGl0LiBTYWlkIHRoYXQsIEkgZmluZCB3aGF0DQo+PiBibGt0ZXN0cyBjYW4gaW1w
cm92ZSBtb3JlLCBvZiBjb3Vyc2UuIEhlcmUgSSBzaGFyZSB0aGUgbGlzdCBvZiBpbXByb3ZlbWVu
dA0KPj4gb3Bwb3J0dW5pdGllcyBmcm9tIG15IHZpZXcgcG9pbnQgKEkgYWxyZWFkeSBtZW50aW9u
ZWQgdGhlIGZpcnN0IHRocmVlIGl0ZW1zKS4NCj4gQSBwb3NzaWJsZSBmZWF0dXJlIGZvciBibGt0
ZXN0IGNvdWxkIGJlIGludGVncmF0aW9uIHdpdGggc29tZXRoaW5nDQo+IGxpa2UgdmlydG1lLW5n
Lg0KPiBSdW5uaW5nIG9uIFZNIGNhbiBiZSB2ZXJzYXRpbGUgYW5kIGZhc3QuIFRoZSBydW4gY2Fu
IGJlIG1hZGUgcGFyYWxsZWwNCj4gdG9vLCBieSBzcGF3bmluZyBtdWx0aXBsZSBWTXMgc2ltdWx0
YW5lb3VzbHkuDQoNClRoaXMgaXMgYWN0dWFsbHkgcmF0aGVyIHRyaXZpYWwgdG8gc29sdmUgSSBo
YXZlIHNvbWUgcHJlLW1hZGUgdGhpbmdzIGZvciANCmZzdGVzdHMgYW5kIHRoYXQgY2FuIGJlIGFk
b3B0ZWQgZm9yIGJsa3Rlc3RzIGFzIHdlbGw6DQoNCnZuZyBcDQogwqAgwqAgLS11c2VyPXJvb3Qg
LXYgLS1uYW1lIHZuZy10Y211LXJ1bm5lciBcDQogwqAgwqAgLWEgbG9nbGV2ZWw9MyBcDQogwqAg
wqAgLS1ydW4gJEtESVIgXA0KIMKgIMKgIC0tY3B1cz04IC0tbWVtb3J5PThHIFwNCiDCoCDCoCAt
LWV4ZWMgIn5qb2hhbm5lcy9zcmMvY2kvcnVuLWZzdGVzdHMuc2giIFwNCiDCoCDCoCAtLXFlbXUt
b3B0cz0iLWRldmljZSB2aXJ0aW8tc2NzaSxpZD1zY3NpMCAtZHJpdmUgDQpmaWxlPS9kZXYvc2Rh
LGZvcm1hdD1yYXcsaWY9bm9uZSxpZD16YmMwIC1kZXZpY2UgDQpzY3NpLWJsb2NrLGJ1cz1zY3Np
MC4wLGRyaXZlPXpiYzAiIFwNCiDCoCDCoCAtLXFlbXUtb3B0cz0iLWRldmljZSB2aXJ0aW8tc2Nz
aSxpZD1zY3NpMSAtZHJpdmUgDQpmaWxlPS9kZXYvc2RiLGZvcm1hdD1yYXcsaWY9bm9uZSxpZD16
YmMxIC1kZXZpY2UgDQpzY3NpLWJsb2NrLGJ1cz1zY3NpMS4wLGRyaXZlPXpiYzEiDQoNCmFuZCBy
dW4tZnN0ZXN0cy5zaCBpczoNCg0KIyEvYmluL3NoDQojIFNQRFgtTGljZW5zZS1JZGVudGlmaWVy
OiBHUEwtMi4wDQoNCkRJUj0iL3RtcC8iDQpNS0ZTPSJta2ZzLmJ0cmZzIC1mIg0KRlNURVNUU19E
SVI9Ii9ob21lL2pvaGFubmVzL3NyYy9mc3Rlc3RzIg0KSE9TVENPTkY9IiRGU1RFU1RTX0RJUi9j
b25maWdzLyQoaG9zdG5hbWUgLXMpIg0KVEVTVERFVj0iJChncmVwIFRFU1RfREVWICRIT1NUQ09O
RiB8IGN1dCAtZCAnPScgLWYgMikiDQoNCm1rZGlyIC1wICRESVIve3Rlc3Qsc2NyYXRjaCxyZXN1
bHRzfQ0KJE1LRlMgJFRFU1RERVYNCg0KY2QgJEZTVEVTVFNfRElSDQouL2NoZWNrIC14IHJhaWQN
Cg0KSSdtIG5vdCBzdXJlIGl0J2xsIG1ha2Ugc2Vuc2UgdG8gaW5jbHVkZSB0aGlzIGludG8gYmxr
dGVzdHMgb3RoZXIgdGhhbiANCm1heWJlIHByb3ZpZGluZyBhbiBleGFtcGxlIGluIHRoZSBSRUFE
TUUuDQoNCg0KQnl0ZSwNCg0KIMKgIMKgIEpvaGFubmVzDQoNCg==

