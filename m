Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23E07C7EE32
	for <linux-nvme@archiver.kernel.org>; Thu, 29 Aug 2024 07:41:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8IRWDbMi7zb1tWQAaXRPDNRzgZL5ybi0Il1IdXY2FK0=; b=qqgyabbkmL8yhK7Qx1CvntNoH4
	52OQsXMelwoNGg48DrPqmTYbfeWirjCxhJtgGmt78V0wBG4weZIQAhAN3MoqUv5Pkn8anIRvq13yH
	3eBZZnbQUgGOL/LaxH3H9qWzKQ1nw7D8zo1o0vN9epJu0f8u6kXiRon5XOdd5xK+nObcXjHMNp2JY
	BNWOwG/Yqbtrc6qDrD9tfWp10VISIlwZ46c0FwKtvH+rFdwu+fNxlTijCqb/hhtqmvNwFAwlZHpiG
	JClVMLM95MMT0GdE4vKD0SDs4lLaiYDwbBuoBpE3q4YQhKSXS+2pLeMXnGHtCiPUV732VE7+lXmvI
	SXH1fxeA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sjZmB-00000000zsq-1RaR;
	Thu, 29 Aug 2024 07:41:03 +0000
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sjZm9-00000000zsJ-0I4R
	for linux-nvme@lists.infradead.org;
	Thu, 29 Aug 2024 07:41:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1724917261; x=1756453261;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=SMivo5I4YWSAiRSDnKRD3sapeB2f6JBazvClN7LgS+c=;
  b=YW3ieh3OvmkQhoDReXezKLn5azDni7or5jWCsEbHkQVDD/k5CXHq5dxP
   hR5hEu6aQ8KfZX4MW9fn/rw90Evxrvm+reVqsAVWo+PI2Kxg+nl/FcyQJ
   JeBjiTSx6skWoDc/ZpSp1qg2Aese8ppzoDXSXoyY7SeVHpOgXTuMUdlLN
   AAPxO9LATIUUnuUxl7pwKZ0DThZBjyMEuwiLLD3pLuNO8eezbVrLRKh32
   r6N6gCHg5HNPLHchNUuI+YddEZ9DmA6xV3eFY6IjGcD1j8041PwdrfHtq
   UH4HfXslJmSsYu3nLabV/WZh+RVW2z4QEujTouQzFDdVamLG1FG6F4v/2
   A==;
X-CSE-ConnectionGUID: y/9NLD96TEi0N/6kvTKf5Q==
X-CSE-MsgGUID: odzIac1MSC6rLz/dnR3xOA==
X-IronPort-AV: E=Sophos;i="6.10,185,1719849600"; 
   d="scan'208";a="24849605"
Received: from mail-southcentralusazlp17012048.outbound.protection.outlook.com (HELO SN4PR2101CU001.outbound.protection.outlook.com) ([40.93.14.48])
  by ob1.hgst.iphmx.com with ESMTP; 29 Aug 2024 15:40:58 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=siXYnzLy72mUX49l2apKy0UPCSrRSj8cHZSCSw2w5MxsNTF8ZnBOLYxyYutpxBw6jD2vqenYLiMp1CyVcnvoLZhBKjkzqCT4RYdQxRN0GxgRlqW0+pV2Djhz17HZmLGPpfxUItCDtv35weCL8BNrEOh//FNglfOuqbABqzH+TYprQ8XHS/fchiD9+a6JcsHTuXnODoBcmp5eh6jk6z24m7xCy7TnQpWJz9d2x6ahMbXh0icaDWp2wNZB0SrunOyvgPWTmoye6iQV8F/33nf/9w78ZRR+HdVUmEXBYPtErAL7ZMU31UPNeMyUF19qVUx1B3lvxyQ9tJBeoG63pbEWBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8IRWDbMi7zb1tWQAaXRPDNRzgZL5ybi0Il1IdXY2FK0=;
 b=CWnxtnVmS0BZM0dJCxsEBFx5zjlWHPhqVjyQXz7SF7kc+ylLueMRA7exRkq1HjDTgCmP9H3UJgd289vwWaO1g4fj0l4wcMs8bBkhB6nqhRLla2EIWoJVvRVbA1Qr94vvcpPU9FkAEDtMnI6nu6TfTDtH3kDfyurjBIysq/9Tu8FIr5k4T59J09oZSBHtWV5KW9ufW4uxtoyNR95BBKptm4qfLtz1cma/KLPKvqpFoWdHBcBHFqi69BeaSzkNjOYEbuOTbYr5f4j9zxN237ExOaOokRuheMYrSYGrABWP5vw4GWCX1n+JmX4Uk57dQeQwd7M8ubNQ3p0DOnVHpS5Agw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8IRWDbMi7zb1tWQAaXRPDNRzgZL5ybi0Il1IdXY2FK0=;
 b=KuOX9QaAB7kT0Cznu56uXkN8ndyn2x7p5/rolBhM0YHwDzIdz2nYxZd5XFpTRUIHe2bNSmKp71qyJPfRA2o2j5R6mTkTygk+MJSSe0oVIcx+tGrkEySbU79tYbclNUcjtLypA5D1ob6qMt3QD8aBQFbXCww8PAYfFHTdR5gtpuI=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 SA2PR04MB7500.namprd04.prod.outlook.com (2603:10b6:806:14d::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.20; Thu, 29 Aug
 2024 07:40:57 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b27f:cdfa:851:e89a]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b27f:cdfa:851:e89a%4]) with mapi id 15.20.7897.021; Thu, 29 Aug 2024
 07:40:57 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Martin Wilck <martin.wilck@suse.com>
CC: Nilay Shroff <nilay@linux.ibm.com>, Daniel Wagner <dwagner@suse.de>,
	Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>, Hannes Reinecke
	<hare@suse.de>, "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, Martin
 Wilck <mwilck@suse.com>
Subject: Re: [PATCH v2 1/3] blktests: nvme: skip passthru tests on multipath
 devices
Thread-Topic: [PATCH v2 1/3] blktests: nvme: skip passthru tests on multipath
 devices
Thread-Index: AQHa9ZhP3Xm8Oc+ntkWNKWXCxyKHMrI94mAA
Date: Thu, 29 Aug 2024 07:40:57 +0000
Message-ID: <t3vxsmummo4wbq4dsepaici7geowdgjan5bz5re7vtbb3am72j@bnh55wlqopye>
References: <20240823200822.129867-1-mwilck@suse.com>
In-Reply-To: <20240823200822.129867-1-mwilck@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|SA2PR04MB7500:EE_
x-ms-office365-filtering-correlation-id: d60d9e99-fa34-418e-6b21-08dcc7fdeb9c
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?1pXO9EeL2+275/Yfa3bZrYwNj6Kb64oNo2rPe3NJilqaGdvbuez6NoEnE+6O?=
 =?us-ascii?Q?c6nNOopPsqqdjR09dJq88fq+V9nD+WpZIk93v3+/AQOkGpQMI663TqHM1AJ4?=
 =?us-ascii?Q?3JMc3c0eg6cKRTGICBStSAl4im6X7Xexovncy4ZOeir54Da+ltT34sCaOnhh?=
 =?us-ascii?Q?ynCdx0BgzcXQEMIBzvQx88mn9T0efClVJ8b5LHEtnZsbpsNcKJM8bV2sYYOk?=
 =?us-ascii?Q?Qrj2gFYSWGUFBherLeyaRrZcaP2UbUQD4/j2GTCSgd4XTsKPGGTop0cajro+?=
 =?us-ascii?Q?/E56SAHh8i6z1f/6DanMkSzTbz+C9yhpGCpMoe+7nl1o3HF3oIOAn8JEzIw8?=
 =?us-ascii?Q?ritd7dG26qaP9aCTIdaWfyANBqJrESS9KsghDyf7vI327xUng6d27/iMBM2m?=
 =?us-ascii?Q?SJeryrbgWrDfCpVVQAzyshrvDJ6kHDonahQJ9FMg75SSc1KDdYXAzSo9PYGE?=
 =?us-ascii?Q?wqee31qiYL+lHJmVwP/j90Yyrz9xL/FauvBWL5Br29ZFjXEB5eYge46dWBn3?=
 =?us-ascii?Q?hvzLJ9wmcyWR3pOlAdBvlg8B8Una7SBBv+naCn7o0meUKZIQRlMONtst8pG0?=
 =?us-ascii?Q?BaM5MI+WUd7LjxjOdFZYBE0rquUZXsDKIF9FHyaOHoqtRuBNIy/qsNAv3B4P?=
 =?us-ascii?Q?Q5zOxIuu5yMCYAL8FkWpFjuRJQswvWfDs3km6oYVFx0Dta4x39udtMOzPuK4?=
 =?us-ascii?Q?tjqfLQqu9kTOmmOpxywzOdGolkN7Pi5LkRmh9uD4tunWwIr9AYemd6l3WqGJ?=
 =?us-ascii?Q?KUvk8b+MUTJeMpDE0H7Cra0G3bXlzescABQDRtK0JtgMm14cgz5Ax/rd8G4r?=
 =?us-ascii?Q?YwTeGl6q0SCZtoqwftInVaJyymnobVGkNqpeBQ/VP+pqutBLw+Kdq7sozga9?=
 =?us-ascii?Q?7ZhgDtDjiXP3/lCTdyZheemX7XMJv3F3n4OmLMi1y8Omv1GP06WEHcOvmY9M?=
 =?us-ascii?Q?m8u3bj7quTsEsjaDjAtnAN52f8RF2f0qOf4Zp3sAgvfdf4syLPThEwkPWvln?=
 =?us-ascii?Q?WwiH01viWVZ88ZbEpuXthWZIcIh07gMfQSu00Dc24UhPRR0s2/l2L3jvlfpV?=
 =?us-ascii?Q?cVZ0CZajcY4pD7/FzF1o+OPt3aG1lRxdnqeEay9UAhAecgvERiu5rxFwsJBi?=
 =?us-ascii?Q?JPD4nTXc+R2/PSRQN7ZoyxphilbgQ8AWGLstG0TQbYklXcAZTm24n+uDcILM?=
 =?us-ascii?Q?ZXFudc7rTVjWwH3/iYy3Z+g5HsYzBmLC4evzPRSr8MnS8YE8pPHYrtFcH/5L?=
 =?us-ascii?Q?/XQ/OOdmoouEbeDvYgPiXikkpgzpgFCnCr+TWRewKLPkFD4WLIf3G53pFYgo?=
 =?us-ascii?Q?wDseEN/n4mZFNVCl5bonWrf5BG43MtPXiLssdzkeDNTK7EUkyt+IJ7aqfdX+?=
 =?us-ascii?Q?DTZYjyYkU3sCZ7cPpIT62rcWYC8uflnKVU7xn5rCGJiEEvUxeg=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?naoGULeGyMl1H0eV58AoT1hpvM1iZjpsrU/Een3XoA4Cy1TTQUmUTf4nACMo?=
 =?us-ascii?Q?uSF1xrzuTW1dj3sDyTVKAnHEnBLhY1eSS5FHd4R8V42VQ9ANBwYipefBBLMF?=
 =?us-ascii?Q?ZhjosDqsB58vkV0TsSAweER6pi0kwEqhVGDYuAx/z+Y+peurI3m+h9ws89mI?=
 =?us-ascii?Q?/Y9WgN1grP4+035VLHP1h9I0C6TsGmSTMsUbXqd2SAw98aob/9ztTsU1iQ1X?=
 =?us-ascii?Q?VyCi45vy/lHlmbJBjKSZytTqWxOaXNY+jVs9/N4oFKfdW6PZ3amLMr3rZqzc?=
 =?us-ascii?Q?48XlejKZxvU/tqzMkWwQNCG/UirDszB+6hWB6drH8NbJLVB5+WUY3KSWRAbx?=
 =?us-ascii?Q?vqhV3+gSp3I0n5sTTcYZ0q9aMIW97nkIvpojWIsUUFk8p0JrsjKwdeY97zAm?=
 =?us-ascii?Q?D1utGes7XWlseGUGmkkqBcF1FuTwWPn5NrLv31dpeOfukyRy2Z4wEI6eDpGQ?=
 =?us-ascii?Q?USrwhPP5G+Q9cdeXIGDc7K5OQVB1BHWILQISpa7WkynMak+cuObU0whp0qxu?=
 =?us-ascii?Q?vyVpmwwKxI2Wy2E6pytloj4nRcAGTiSWx25kM0XM6reSZCAY4QD8Y2feORKe?=
 =?us-ascii?Q?5bMYpS3GVmjTlZiArpd38xXkV9v6H/rMgtRfd/x6KiF8uF2KnAvLMjHluSAM?=
 =?us-ascii?Q?7MmHcAeShcWMPaCqz7xzDiMNrH1yubrRCb3BeFITn7WJMyzRhDPm1ZZm6fkb?=
 =?us-ascii?Q?uTZSG/aDgOjBeAWmPOFgwaNGmUoWzVLOLgxM7fPvOpKXLrqGUgNiViyldEWM?=
 =?us-ascii?Q?1huYWObKdC82hVGZpf35PQF7IKeUeBzTNODZY2qqJxwKWUO0llyUKF9X9hSR?=
 =?us-ascii?Q?Av60kKREDyEa3pjQIs5MSE8maTxRmSG8dt0HLUBCR8GX+v8W+okuNnFApTYz?=
 =?us-ascii?Q?jHPhdCB7tiluvWnWvUVvbUs3xIghjr6oOagUcz/hlXFGmmk5OaiiAYGJJvFz?=
 =?us-ascii?Q?GxJmnKAkIQxbsUKGdC1UwE0Vzskrb8TsImVUHue9jNA7czi6FiLDS/1RXN/A?=
 =?us-ascii?Q?xstQpcdUbHtNDczHr/4HOsmfkApAPaKg0qEbUTrgyGIPv1z9iOzQGWiuG9uR?=
 =?us-ascii?Q?sPTc0M8wtxqmH1f41w7lsj5ceji75qwIf79T0P/ZGQFsyBgSPQEqTVaYwrBP?=
 =?us-ascii?Q?8UB6jfR/jP6vbY1NUos3pJsL5UIasqgGJlMOOvRxYMxT36GTKP/APRPtryeI?=
 =?us-ascii?Q?LurTzQC4OJUHcpkvwhxPG4C5qJjgwubXl7S2NSIBSkiZ92MA3QO4n/0d8MRf?=
 =?us-ascii?Q?P/IvAGDWrOg+bFTU+G5be6tB9A/JR+7gnrt/yqUPGr8mVzk5XO3VGZhGJEOp?=
 =?us-ascii?Q?ItNIMLrETkSb3pCyela4uHRNr8BnS8KF6yflgbvY1S4uyPRThYnEhfZ83MNM?=
 =?us-ascii?Q?zWEKgH37rqCm7GDfeR1rsh/9NSCrT+s2aqQ95ouKKYwVfu/MoNw5RQMydndi?=
 =?us-ascii?Q?JwvSicPh7ZXa2ZtkyYl2Jh4WcsHR+TUK9z1KmUU2GO8rT9XgFm3dA1jCBPfC?=
 =?us-ascii?Q?fYU9V8vgN49bDx77L3lPkYhvrZU/mCskDyTmiAA5aw5Cun8IaWIKXr5jXxSO?=
 =?us-ascii?Q?YAKEcN6lAUajtTJ2aEFRNLGi2paV0/4h002QiD+QMrPmJxbSRZg91QWvBJrJ?=
 =?us-ascii?Q?PMt1XtR4IRPLL+ad910rTks=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <5070FD60B9D35C47A3A179AB24271697@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: bMAKu4u7xGxctgBH959YIps2oFYu/rE702zAHLTKDv9NeDdAfIl7xSsdc9W7pSVdafVt3rJWueLmByTQqOJMapy1F+IKDIGT3KyXNiMpqgMk/v00Bf8le+3txEXtS4dQvyHJaOQe00b6XgVznL/2kRmfspO5DImM6qSUrOMlc2kSti2DpgUy9h9PaKD34L7wiLFCsjO+f89bXbCb+HUg124AXGgXljLaTYPap7vISFm6lPhFI2OGNPu4XOlOik5yqD8yl+MLAUYMGlDsfNpLnFwuTHbGP/LsqgL7YY3I6seiFAKt6d3hpT5g881jylSskPuxGQnA0Fw0vhwxdbDQe1GsGqyFF+RCUAeTW8aQHnbRJjypIAfUKOddWqLIWvF6WWKAzL/6RJl6dwUJEu9qcSBVGb1xRMdlrK3mrHhvR8flPE4/sLvL4kxnaSftmgE0/hF64/B3K9MCpkiHPi3QfMDQe09AycXAWkUHm6+zPaK98oKCxY8tavToY2DlXKbMILVL3tYXnpIG4pJxHNw8qrJ0pxUfDsQDXbF87bnjsTIWxL5uO///Rb6wDj5pRMiqYi4g8N1gaU5ujIxpJuEb2KKTZT5ye/vjOrWb8FKsz8jRat6iriuugeviISXqPw+R
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d60d9e99-fa34-418e-6b21-08dcc7fdeb9c
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Aug 2024 07:40:57.2911
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: u/TwgCfUKy5SS95ayspoEi4Z7YcWEUrtgNEdU8+yvZh/uo9i9POOfgO553Kr4nNmQvFXSA8SYsbp7lzMgiZG9Rj0RFoGbpJZPfGfZDyR6B4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR04MB7500
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240829_004101_211148_FF307FE7 
X-CRM114-Status: GOOD (  10.73  )
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

A nit comment: "blktests:" prefix in the commit title is not so meaningful =
(Same
comment for the 2nd patch). Also, it's the better to note the affected test
case. How about this?

    nvme/{033-037,039}: skip passthru tests on multipath devices

Other than that, the 1st and 2nd patches look good to me.=

