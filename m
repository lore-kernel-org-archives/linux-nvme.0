Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CBC2C44512
	for <linux-nvme@archiver.kernel.org>; Fri, 17 Jul 2026 01:10:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:References:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1HbQbIQXujxUwx8YxU5X6w78vgMsUF9kI5DAVSzartY=; b=yn1QmYCKAdvrl0Sdl2NTd2kGND
	ak7pAwnlTv99gNx4YznyPL1fVMjKa+JcjGYKHHdTE3k4FEaWy7at0cLtNgqjIaL7IPL42EXLaPHYI
	hOjUELP0CzBQWM13Dl9djvCUEzx9miBXjUXHESK+E+bTZwigI9H8FWUpDbqVXJptOpATMnPG58GiR
	bXp8C7jrazOMD3T6lrlPNTRvHODaojsYvvdasyPCf8XPOy9R8Kqicxc89KfKVLaWEgi13/+RuWWK3
	VRk+jH2zxcqbpu+FksKEr/uCuz0YkpxA4bmeeLMFqmtk6T+Z6QI76AZBrnwUQVLeBV2zM2o/YC2oA
	HLtWP+kQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wkX5m-00000000snD-1sEn;
	Fri, 17 Jul 2026 01:10:18 +0000
Received: from mgamail.intel.com ([192.198.163.13])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wkX5j-00000000smh-3xUc
	for linux-nvme@lists.infradead.org;
	Fri, 17 Jul 2026 01:10:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784250616; x=1815786616;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Gt4LVuhKXoYhrl2xPHFRzBu9RtkgMATSZxWW7D7ei8k=;
  b=fIdj+tCPub+ycyc/GHZMHKjLSFLgJ7B7KKtZyPsgsTKGmEvsM9uwNybe
   uakJDOfP36U4MmXRB6ubQnhOICqmYZOWuxxWbslIc8FjJeRoWy9R12waE
   iDuutfXnkgjtq0MXaH6WEPYZ83LZhacTClLUl3MK1aHjDFE1OQ9xvx3eE
   JzfrFss2Fb7+dB6zThUDzeC4ix2AjVt/pei5PADpbAjyBAPAk5TrErabZ
   G5MvUSo1QbO0GoFLG7oTBAQSuVYn9R31P62521f62BMhw5mvgjWT0QTZ3
   9+HGu3HqvvuYJMcmMayzgpGK9m6yOeTo/XeMICy/m7ulmYuSfpwI3UbF1
   A==;
X-CSE-ConnectionGUID: n47Uetr1T0y4jW4sydWHuQ==
X-CSE-MsgGUID: fybTFAAuSkyxDdD20pFdcA==
X-IronPort-AV: E=McAfee;i="6800,10657,11848"; a="87469782"
X-IronPort-AV: E=Sophos;i="6.25,168,1779174000"; 
   d="scan'208";a="87469782"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2026 18:10:13 -0700
X-CSE-ConnectionGUID: FXKam0A0R7q3Pco+3RBkdQ==
X-CSE-MsgGUID: wujIMjv2R4m+aoxH/VoA1Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,168,1779174000"; 
   d="scan'208";a="260230281"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2026 18:10:13 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Thu, 16 Jul 2026 18:10:12 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Thu, 16 Jul 2026 18:10:12 -0700
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.13) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Thu, 16 Jul 2026 18:10:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wxgfkd29e092RKvfP4gLr9yiY16TwChRjPn/V91W+ybtufo2Ya8xp1rExPkm4POwxpctmgbLrDPfKUh4F/yaTB+5AE3Fdrowzz0u0AFE02nutrxWWaiYbTBf5+WDLmj9ub1VzxD2y+JRRKb03Lg1FWQQy/OGQ943K9EzmQpOE+MKF/1KIVbEmi/UOAO/slTbrWTaENKhqFDT7eSjNtXJo13KMLexRdUITuNalRfsekdw+8lVIO29sWUzcAM9FySfa5X6I/R//AARpwjl0p5qrl+rmAArcAtO2leJvn5JVHwAGgTOH4gwDYxU12X9xwc3tKCZZuJAmlpg29nXgGZY9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1HbQbIQXujxUwx8YxU5X6w78vgMsUF9kI5DAVSzartY=;
 b=lyWnwuz7wK1u/uSnh17OFKut2qxpP53awbx8JnkSbhLfvrQJsM9GzDK7oanXKzE7o+sDkYVT2ICAtm6rkgCi8amFHg+4I+qMFFq6xbtTcd6LRYYOUNo5BSldIBw43+p9hArQjPp0IY/G8YojIqxv1wjAohXd1YRvupBYDwMvUwqp1EIm31ZB+oogix6hhkbxFlcXYSRKv+yY0TCV0BywVUcHebQ2ed3JazuoO1zWBVU9nKqnN8cNL/Qb8P2+4qJ4/iBLJCqoTRjFVZCtNQFRLy4s49fxOOEbhgLrd6F6SJZZxA1u2Sx8onCvWRyTGdL9ORSnz1CrKLZc3pvU+4EiLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM4PR11MB5375.namprd11.prod.outlook.com (2603:10b6:5:396::18)
 by LV3PR11MB8505.namprd11.prod.outlook.com (2603:10b6:408:1b7::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.10; Fri, 17 Jul
 2026 01:10:08 +0000
Received: from DM4PR11MB5375.namprd11.prod.outlook.com
 ([fe80::27b:9264:912a:a3b7]) by DM4PR11MB5375.namprd11.prod.outlook.com
 ([fe80::27b:9264:912a:a3b7%4]) with mapi id 15.21.0223.011; Fri, 17 Jul 2026
 01:10:08 +0000
From: "Zeng, Jun1" <jun1.zeng@intel.com>
To: Keith Busch <kbusch@kernel.org>
CC: "axboe@kernel.dk" <axboe@kernel.dk>, "hch@lst.de" <hch@lst.de>,
	"sagi@grimberg.me" <sagi@grimberg.me>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "Shevchenko, Andriy"
	<andriy.shevchenko@intel.com>, "Cao, Gang" <gang.cao@intel.com>, "Jin, Jun I"
	<jun.i.jin@intel.com>, "Hu, Yong" <yong.hu@intel.com>, "Fang, Liang A"
	<liang.a.fang@intel.com>
Subject: RE: [PATCH v1 1/1] nvme-pci: adaptive interrupt coalescing
Thread-Topic: [PATCH v1 1/1] nvme-pci: adaptive interrupt coalescing
Thread-Index: AQHdFDEgJsR36D3j+Uyv1+uGZclW97ZwobOAgABD2rA=
Date: Fri, 17 Jul 2026 01:10:08 +0000
Message-ID: <DM4PR11MB5375D7EECD0C888146CA2BFEB7C62@DM4PR11MB5375.namprd11.prod.outlook.com>
References: <20260715075703.15578-1-jun1.zeng@intel.com>
 <20260715075703.15578-2-jun1.zeng@intel.com> <allEmTmXCFosxIOr@kbusch-mbp>
In-Reply-To: <allEmTmXCFosxIOr@kbusch-mbp>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR11MB5375:EE_|LV3PR11MB8505:EE_
x-ms-office365-filtering-correlation-id: 60ab16a0-0670-461a-98e7-08dee3a024ff
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|23010399003|366016|1800799024|38070700021|10067099003|6133799003|18002099003|4143699003|11063799006|56012099006|22082099003;
x-microsoft-antispam-message-info: /o1RgtRT81khExAJX4Ok6hnXsJlFwoODLSpRQBPO9m+314imSdoGi9u8tESV7+qzsmwIj6/NPHQ2eOtntKnE2+CGVt3BnPmTvzAd/SvmJDdKGlJ2VEqD553078n6d4B6H9YU2OV5/YKCmo4nQ6S+ueC/Uc3hbymJ0KbRmdpb5qPaFHorm0JkJVz3I9wbGnsQvlosrHVd5TVBqro+F38ydEBb+/6hQ5P3FciZ+fgVo5i+mMOtJKx4UVSiSjJx5Eq7MKp7bWO0KydUygF/yWqe6/G0j5uZSZ222XaPJ45bV2oaLF4840Cos/MKN4F/lpJNik2y2iI85ZZ5K2j4l8Jm+L4H8NS0ncI/aJg5WOsN07dGmZ9TL9sHJjSgSQ3U+d5FfxD76UPpn6uaPR+gVbGcxa5a9MhqAQHE6aiOREYyF170lqD7q4mLPo8dTSH7qGAQLEbBuBeqSmAUZQqnIibPPrZ0+JavhLAj6MSk0aW4KUtX3XA+Bb0+T05PHoDGuAoYOaLZLkvEFTKCM/fpPJ3+k0AGhkbeRs1DLLlCJLbTBBcbLx61SbNzfcwF/+50EAIJZ3ORb+5+9j6sfG+1xqUmTBR4YiwsDoDUzTUgAXOYS92l5EA1PfoaLgyVACJZRB0xNOTKySfCiQx2zcC4eIwWOhU9OkFZHcIbnnVS+d72cvUg44XcUwuN8cep+mMOvAFono8T/T4xXli+DCJXjOqoJQ4meMlfclaROOiYU4Xz45o=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB5375.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(38070700021)(10067099003)(6133799003)(18002099003)(4143699003)(11063799006)(56012099006)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?R+tpcNcwH8pDe5aXVljUv71nPXFkcWqyc2acM3M8cvKF/gbItZJFO6OR2h9L?=
 =?us-ascii?Q?r6fT8cuq47xsTJ9+Tv4RBxH8YOExmi8u9Z2PPy5TiRgOZmTFr57O4LIfbEbc?=
 =?us-ascii?Q?N0QESqPEvw7cqbHTLmO1Zyetl81mhGEHnULm76vCPjgJPM6Q48gPZ32U7HsN?=
 =?us-ascii?Q?+JxE2esVWqcFMSggByw7WUMUMq0QVnMz7mN8HVXY7cDURqJgIZ8zyQLUn/1b?=
 =?us-ascii?Q?fW1Yg4QHldPHHOe1uXRyYKXi5QHVvHDA/+NHHMR9ey7SShxHStR7G0/PWp7d?=
 =?us-ascii?Q?3Do+1PsJC4d55E7Ip3KEVPfDsZBSxxyhh8uBVfdVTY3AHIPdPuqbY2nGIhL3?=
 =?us-ascii?Q?oV6d2sra9dwdcn4qRLcTSRlcLZxCO9YasxJOdcPMvUxjeOXMrbtJDQ6Zw+jo?=
 =?us-ascii?Q?YjN3PZ5waQvrBtf+TuypokiJ3exxk73vkZ4kxjvc2zerfNmXZfJq4sVIYC3z?=
 =?us-ascii?Q?b00Xiy/kp2A3WHs7H5ODR4y7f6QvK6bH73qats4/mUcG60/Tb+EiJrF0XqCL?=
 =?us-ascii?Q?FO1djbMNOBhE9jia4SL5wTv7w/JnK/ewNzl3RSYBmbYQQST/eFIhPR3/obOX?=
 =?us-ascii?Q?CXRuqkDzpPxlEupX5q9MWAmp/vjr4qd9PcV8TcSIGVLD5/xJUiOzl0F0D2iV?=
 =?us-ascii?Q?1xKzdqL57e65UaUwmj3wYM4S4Cmdz33vhjBtR6x71Vk6QhV+TQROi0E9Yan7?=
 =?us-ascii?Q?EAvJqzbJm+KUaXGui4tyOdz3ESRcPl9KPc7FHs7BUvMNnO99QcGPAxYFbizy?=
 =?us-ascii?Q?JfulIA1VPM0UY91JsdOszRpp5g7WsVeNiXUGYBl9fYlwTeNdKouLvaWG9OTK?=
 =?us-ascii?Q?yM+n+3x/HvGvYjolAOO0/OuUaVt9JnF0MzuOxmfnW98PLmW1HvvK8hbDAg7c?=
 =?us-ascii?Q?xumOC7SimqfidTs2ZdiYNcEptuGTKTI718UKAwF4Tf8uAo2l6G4MV5ZWA1rV?=
 =?us-ascii?Q?YLpwoRh9zGncsXaM1j9mXVBHpsVkoNVJNpeh5a9txmc5sOvg+PUVusik3cOo?=
 =?us-ascii?Q?9bG6TfqVMUJHoaytqOARSL9w0e8kyd21IDeinPmVJoQU/42uAzSMjmH4I7ZZ?=
 =?us-ascii?Q?+fNdy/6UfX5T5rUswdA5SbrmSLNbTq9C04DEJW4SZvkGrwqF9JiRcDd2Jhwr?=
 =?us-ascii?Q?RcNyvMP8iCI3G/LBdTn5hVGGy9Ho5mOZpRGPnxihi9yKspBzYMVqnzUD7KDh?=
 =?us-ascii?Q?da3m7SIRcmeKtlDwLIut6LQU6RWhSixQ1JY/FTmsr0y1cuaomKXm955Ta+o4?=
 =?us-ascii?Q?AqRPv0n1omhP32naoPmxEVh6REYsI/RvX/EpSYCb2l8kiKbfbqfyGyla/qV6?=
 =?us-ascii?Q?awD1vHNScrqCJVPSSKD1wQ2r7K+Jh3lC0J8WdeqehN/AKp2nwQ6XKiix+jRV?=
 =?us-ascii?Q?1fChJLZ+V7vb1d8FQJkG/bzQ7XMaAzrCvRR6BTPuTuVg8Vnz7zwIIaE/XUU5?=
 =?us-ascii?Q?4i3tBVhF2ovzwR467ZZIpgd3+HARbWtvth02V+ZHGbM2LkRcuKzNkGsQAk2z?=
 =?us-ascii?Q?yCw2K0bYtliz39pfmgbJpCeE8p8KH5+kY5GYuhSP7EMmpYbG4OA49wJ/G7fb?=
 =?us-ascii?Q?rdTSVkWHsRk5ImScA3EAzP8b5i5omsZLULfeEH+rbWZwtOd2x9hAV1gLcLpG?=
 =?us-ascii?Q?SdziPvCTGI1tr6tZRfh4yOArbOPTFmSqGHXLrUlTZP/ZaasDRA+3J0mfaJGs?=
 =?us-ascii?Q?WFYyG4s1lsq0n7GNAu2BXEJMLvN5ihoWya9YQ54WT9D/9Bwb?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: lth7hl9gbRp4kj4WFm3xeqWhr/qaTR4cRsBodCCAsw7lxwa1HhChCGxgghnmabqUXCjeKaND8OTH32TGVS/sJZz/SVK/o+Vneah0lVZSAki2U1DtmtUXbNFFbQvUqbLWOTEWn7cTSfRiWz9RXMHpHnqytQlm8+Eflgh7o11ALPb1FrhBkFYxHBxWjza6o2YRj5gYVIubfc9UVg+ZK/AZ/RscvLk1zGKiEv6KIOO5ksQtTaSMxKBe840v8tfvUowCXbeqQy5beRoCTNy96mWAJo910T9mp+3HBowPzfihNW0wWyEbn6aYa2KdbG/l4FedbJQ7J49NpMmpPDvMBEU0hw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB5375.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60ab16a0-0670-461a-98e7-08dee3a024ff
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jul 2026 01:10:08.7830
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wACuuaWGYsaTBkPA17ZR2KEsAQ/HtSjNeiGvUttJCaymRFWPATpAL015cUdDLpe8Vfd9bTQ+lRboWPnD0p085Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR11MB8505
X-OriginatorOrg: intel.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260716_181016_025462_789AD1FA 
X-CRM114-Status: GOOD (  11.06  )
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

Hi Busch,=20
        Thanks for your reply. The main reason for implementing this in ker=
nel space is the lack of a unified, deployable component in user space to s=
upport this feature. You see that there are sheer number of OS distribution=
s. This will require separate adaptations for each, usability might be comp=
romised, and-most importantly-ongoing maintenance and updates would be diff=
icult. Meanwhile, nvme driver in kernel space is providing these unified ca=
pabilities for different kinds of usage.
        For the point of using atomic_long_inc in cqe polling we can discus=
s to do it in a proper way.

-----Original Message-----
From: Keith Busch <kbusch@kernel.org>=20
Sent: Friday, July 17, 2026 4:53 AM
To: Zeng, Jun1 <jun1.zeng@intel.com>
Cc: axboe@kernel.dk; hch@lst.de; sagi@grimberg.me; linux-nvme@lists.infrade=
ad.org; linux-kernel@vger.kernel.org; Shevchenko, Andriy <andriy.shevchenko=
@intel.com>; Cao, Gang <gang.cao@intel.com>; Jin, Jun I <jun.i.jin@intel.co=
m>; Hu, Yong <yong.hu@intel.com>; Fang, Liang A <liang.a.fang@intel.com>
Subject: Re: [PATCH v1 1/1] nvme-pci: adaptive interrupt coalescing

On Wed, Jul 15, 2026 at 03:57:03PM +0800, Jun Zeng wrote:
> Add adaptive interrupt coalescing to improve IOPS for high-throughput=20
> workloads. Monitor IO pressure periodically and enable/disable=20
> coalescing automatically based on IOPS, queue depth, and inflight IO thre=
sholds.
> This feature is enabled by default, can be controlled through debugfs=20
> variable during runtime.

Can't you do all this from user space? You'd maybe need the blk-mq debugfs =
to get access to the individual hctx dispatch numbers, but maybe that's oka=
y?

The atomic_long_inc where you placed it is especially harmful to polled que=
ues.

