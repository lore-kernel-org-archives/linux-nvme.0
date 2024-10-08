Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EDA6CED26C
	for <linux-nvme@archiver.kernel.org>; Tue,  8 Oct 2024 05:31:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-Type:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=eygYAndBuftMvjTK134QBQeCN6NDoy438QtPP+Is5OQ=; b=Me5jwLVZ0vlWKFbh9EK2DXObIS
	lygUxzpSf+RXFrtM0/jEwAx0nWya4yl0s1Jtc7U57IZwqB+UMx8KH1Fm1FKImoBWB4vLtoTimYp82
	mMwzucI16C54TMVteTiAa4Azvc85xA5EwkG6XpQHUjzGLHf9e5clT1HxiWrJZ82FFLOs3EaQ6rreY
	TljiIuJDABmLgPfj+Vc6daU2dUoyItHeVNmoY7zzgxnW5SsdA+k+otch/VAPpd/EID40dSJSzZ8Wu
	ZuiO4RBXpxHkbC9O05LEi7uzyWrvpLpXVdANNF5/3Q6x9sDHeq64woQhVrqN3whIN5VTem0G5amKA
	cG2VbxnQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1sy2of-00000004Ybw-39we;
	Tue, 08 Oct 2024 05:31:25 +0000
Received: from mgamail.intel.com ([192.198.163.16])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1sy2oc-00000004YaK-3yhN
	for linux-nvme@lists.infradead.org;
	Tue, 08 Oct 2024 05:31:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728365483; x=1759901483;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=32Ym+7vFOD+YjnBIWkYau/OFoAV53GFM0tOkWvI63nc=;
  b=FpowyrTsFl5hFnZuZGweG4/CHLEDyeL66TyRtd+sVqk+1l/t0teEHRhs
   phkY+1VJb8dr/1KNVuxNK3YnYM52hZUngzt0ozaF2j0MeDf1lOCbpXNYD
   YVuGG65gAJP6DFPxCC5qPxqjsBLicci/Wp9Xtgg23tdbAB5JnQg5VuvWe
   WWSiSnd5/6JZ1+zJ78irbPzpXu3CDw+Z6C9sF6oHoSNZiVmv0PJISv604
   wD3ZgYBtjICZfBR9uTRNwG5q7ubJgtnJPhzmG2SD7MuRK2/Q/p1CUKraY
   xhBn1SATlP+nvE3guRzxzfOdpTCfOlOxNXbGgLzHjVxRaHc/WAup8Pxqp
   Q==;
X-CSE-ConnectionGUID: kgS/Wy7FT9y9GL1iwAJCVg==
X-CSE-MsgGUID: jJUuXxVRTgm3XlW1fOemmQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11218"; a="15156964"
X-IronPort-AV: E=Sophos;i="6.11,186,1725346800"; 
   d="scan'208,223";a="15156964"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2024 22:31:22 -0700
X-CSE-ConnectionGUID: BzK83tx3Q46gWlIbs42NTg==
X-CSE-MsgGUID: BPQ9Wq4FSKO7DD2948Azjw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,186,1725346800"; 
   d="scan'208,223";a="75683818"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 07 Oct 2024 22:31:22 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 7 Oct 2024 22:31:21 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 7 Oct 2024 22:31:21 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.46) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 7 Oct 2024 22:31:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l+SjJ+fFPeMUPu9X+eoZjRceNKXuJJpfYaX9t2AlU/j6UZHAoJrDCIszFoZnTpfAFFPNA93zzgGxOmAAghO0X5nflSGZDcjXCyYNFYfQoad4Fy3twAWs69ez/RaqT/teLDEySU/35n228YRtBwH1m/5VqPh9K/rqrdOFpYp0gFUqi0MpAkxxsf89LE/yvtmZZCV9rvu+Y0GhGLNP/TWjVeAk5uChao3iWQt2DljcGhse1FheDNwp/7aQ9M/cUXhuYw+YmFe6XjUzJwRMBM69jwTpixfDWMKgtJmP1rMScKcgZM4mv0sE7Da4VshxW8f0qOCn+It7EGh+o62Q40Nc7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eygYAndBuftMvjTK134QBQeCN6NDoy438QtPP+Is5OQ=;
 b=E6cFN319aagjP6lzzvDF7233BrEtCGxLmtJ9jfdQrdWlFyTq3Bo1n+zZVgSrulFvrzQCPtPXkX7XUpVNjOnk1mWjwlEgwfJGlGQM9MeyNUaN9bTjY+qXb/0Ilrl17hL5cjbw9wF3DCDFpMlr1MeyWcte6B3g01cewjHwEwi7JNqQdAhOdvJKwRl0Tjyba41LIx3qpP6EnRY6BivQNRRc/+BEdKVqBC6Cacl1Fok61Ij6oh7H1Ly1WUz3i5kglGVg8Y9iY9G7IATbnn6hKyZQfaJy8HXiNQptnQk+MeSQMByWN97w2dj6a92TwKKBlDH1SxCrpqtazeGPkCZOsf95lA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA1PR11MB6345.namprd11.prod.outlook.com (2603:10b6:208:38b::14)
 by PH0PR11MB7635.namprd11.prod.outlook.com (2603:10b6:510:28e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.23; Tue, 8 Oct
 2024 05:31:18 +0000
Received: from IA1PR11MB6345.namprd11.prod.outlook.com
 ([fe80::1cfc:5950:df8a:4f9]) by IA1PR11MB6345.namprd11.prod.outlook.com
 ([fe80::1cfc:5950:df8a:4f9%7]) with mapi id 15.20.8026.020; Tue, 8 Oct 2024
 05:31:18 +0000
From: "Ma, Jianpeng" <jianpeng.ma@intel.com>
To: "kbusch@kernel.org" <kbusch@kernel.org>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: [PATCH] nvme: remove duplicated judgement
Thread-Topic: [PATCH] nvme: remove duplicated judgement
Thread-Index: AdsZQwweA53hczCsRf+TiuohRXEqGA==
Date: Tue, 8 Oct 2024 05:31:18 +0000
Message-ID: <IA1PR11MB6345D8E26700693B1238C092FD7E2@IA1PR11MB6345.namprd11.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR11MB6345:EE_|PH0PR11MB7635:EE_
x-ms-office365-filtering-correlation-id: 1b88915a-841a-4560-8781-08dce75a6f74
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?39dRwFWn41MtZ9RnP63sEnQ5sL9Zjh2BKb9KBskBun3T5GFRGNbr3RqpxIce?=
 =?us-ascii?Q?iwB+Oc+llBLF5TJCOKcCESwthtWuVM5SncavA8txALpud/rbdWRerLTWeXaX?=
 =?us-ascii?Q?CYznPrsV29CQRlYNqHglXsTBQ/aVOjQCH7pm1TC++t7zmxANPkTGDEX90/6M?=
 =?us-ascii?Q?H5rivr0Vc9qTpw4ECSDTubpz1v853Sm2YqzLHj9L265p/vzEw7gZRV9qqcIO?=
 =?us-ascii?Q?XQ8bQn9mvhTsn8tqgy2m82IgrWW8JOGiZMJMbo3SMs5xEFQHiCW8n5t7ot3s?=
 =?us-ascii?Q?2h0eX+kNlJiGw4ivVW6GWHEaI8NigWRJDnmYi4gtUdqdKkuTbefWI4QgHrv1?=
 =?us-ascii?Q?cPUemzMYOoPywnYLC3t9EOEwe6CZl6S+nI87JlK1ENjCoGi1Xuy+KrJUmT8g?=
 =?us-ascii?Q?zyogWrQBf0tDTbAIGZ8e2r6QIvHjfJQAMcsSvIOSGrvfIMRypxGEOp3EvI1x?=
 =?us-ascii?Q?ZtiggTwNrnCT+jALaxCEuzMgUbUY6G69kVo7ljFVcxCggA9ZBdaH/zCU4ICa?=
 =?us-ascii?Q?16YnDAsnwwGP/AHhhyAzuFRWhYuAKvw0FMcEasYF+brbjIQNPrQRt+zKecm/?=
 =?us-ascii?Q?Z6sKQ9+ZHZeB9/ybTkZkIaKEnHmOBZvSMz8vS6tJO1mmvxmqq5PWzywqwmy1?=
 =?us-ascii?Q?pNkYAW1OTeDqSySo5yvKch+wrP3Oc1uWrKbN170AAmh6VdV7L1HjXW88wCfk?=
 =?us-ascii?Q?rF4Autfsq2gG6RGMU6fhRZFGOG2t4N2Ya8DEJ0SPAmfGcrCEG5dfAaqHmVjz?=
 =?us-ascii?Q?a2uhjsiOyV4yAc5sPBv7pOBVSA97yll/L6j5ytceQs0pm3lj2em2NdWCLalf?=
 =?us-ascii?Q?fwxCqAiRp/ilFutrsGnmniMGNgsyN2A/niZSXYmpgUBDr3xipYFEhgNti7N1?=
 =?us-ascii?Q?Y8PmmbZeM5480auXQcQeiXuIP2stSAVWrSxxTnBpamTA8XhySb2nrgrqXDGc?=
 =?us-ascii?Q?ywSe7weJwK//qs/eK6qjok1abTlAAPzl/90Lrj+5edC3pNb3WlWFv/vJUgjm?=
 =?us-ascii?Q?XUhpEUoVt1EbWnsyQGvB7Q2PwTaGUJF4vx6CfeFinro3ShSBuyf8P0E2eA7q?=
 =?us-ascii?Q?snPm6vJjajQ7ciiyqApFsqbrnvwPB8pLu6/OTBvO/QizJe6JnkNaFuwgk8J7?=
 =?us-ascii?Q?p9zp5K+RNbcYsnwqHcNnkSqitOkpvT+DIRG7lcJk/xHooLHdhz2d8OfrXR8K?=
 =?us-ascii?Q?ixpmLmdayYLHwI/2IYU8tflQX/k3qM7XLGNvWTxiuIHD1/9j53+k7TwEFvCw?=
 =?us-ascii?Q?ab5Bzbk23kSP+Q8dm5VprizFHrvewgoCWYx+5oYlVpOzuypO/XhpT72DXTh4?=
 =?us-ascii?Q?qu73bSYBdgW5bUkohqhIYdDbJNGk/ioQSovUawMajw5Ydg=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6345.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ym6462iDfjV7KovT+ySwquKDnceBlEd+idN3Q38vZejUZXdx4VZPSj038qis?=
 =?us-ascii?Q?gQd4F5VveWV+7gf9gguXe2jPAyTsrMj+E2d/s+ggDfPQQ4YKsxXC3yC3lIHh?=
 =?us-ascii?Q?Z3kiV7SLAH1nRBI9nDdgMjE5a5/ayyVKzEALGQYcsMCs+F3muHkbIGV/Ashs?=
 =?us-ascii?Q?PtxqGLmzgRRX75RscUtoySbf1oosnPeKF0Ijj44q+9SiJDy/XReaQccBa3Ou?=
 =?us-ascii?Q?HVwTPpvGgrtBPOCGN8vN4Y7i6DnSlbdrDJuQprYWzTNvh0zKBfKvimTp/nI3?=
 =?us-ascii?Q?8plnRutRhyAhn452+HSrQetmJa/LRA40ha01G1jF7yGOV0DTvveoew02AF+r?=
 =?us-ascii?Q?a7F8+UyiI0mjZcaB9nZgU3Ft5Iz6VfUqJsQ4+5Tvj3oFh/yGHcAkn23bYLib?=
 =?us-ascii?Q?ZTB2lzBoSgId1gg/bXc9u4oQalhB8hn+49CcyJCwrC6TuE0WfgzV3OxR79Bk?=
 =?us-ascii?Q?QDTgTsM2+0OW3RrxY6btqTsXbQP9giTVXqQoWm1THHkAKYyQcsSmoRZkku6I?=
 =?us-ascii?Q?2DVW7fCZSZfNrIjDPd6l1wEzc8Bl6cXKQQoynEprQzz4rcEAgF79KTiY3kzr?=
 =?us-ascii?Q?NWWjqs79vkij4F+XY0fBFXPqEOkbccE1/B3pft/k7vK60QLjirhkERkLOenw?=
 =?us-ascii?Q?CVPl19ZTZoZ8B2gMzZpiyIqoSlehlR4KZCge13jzEdiwiu4UnjL1I6a0MVaI?=
 =?us-ascii?Q?MX8heYojjE2tA4YYlT/PCGEQPy4FS6eBu9AgorThZD8eVHnLrfiMWyldcACr?=
 =?us-ascii?Q?jVfISf5Q6iEAk7dHrE+XsX5jSAHx5GU+o4t+XBBAHvqK1IaCNPsPlBhQUze1?=
 =?us-ascii?Q?zsxhvjFjI7iMwfjEZSqZH2w+OTq11eNss/VQefMqPR3NMdKOXdeMLrnPOhm1?=
 =?us-ascii?Q?iYnVFKsPymf4FoQ2LpGJAao8VU42+jaGYMgyVJiY+deGbnXkQPKC8y379e/n?=
 =?us-ascii?Q?vO2FfHRAyklwk3XGgGXC76mSIMFCLtMTGbri2u3WE4a2jIMKvZ+Litvrjz0g?=
 =?us-ascii?Q?PU9QL9pto2HQxL4QmdKi+lPeNJY8K5eUQ6J/yBM2691Dd7eY8/yYGL/m7k+P?=
 =?us-ascii?Q?PMiP62YZ9GM9SQvw5Wn2DO81nKTUV8baZLcjsaAj2jtpRuroxd/7bzKnMfeA?=
 =?us-ascii?Q?Wmfj7rfCDMkPF+xnFU3kxF/DazAm++D34nJmALDe1kimLsXAfnBQaDR+zZGt?=
 =?us-ascii?Q?QNVbC4cHZ+QOj7J5wthx/6oxKLFtWW3DAWSuOR9OrE9zsZxk7xkc/k+CPBoq?=
 =?us-ascii?Q?NWDKoL1fhlDDbljI7FGDQXmHQv60ic9in7BDiRShypkboRLnqH+w/6PqXN9r?=
 =?us-ascii?Q?qyrCvlIFqslvAqUcNqCKKzF49Rye54hnLyBjPGW9KMxARuLbbv6zHRH+RINX?=
 =?us-ascii?Q?IVGFEl9quB0iweuVioe31VjbYYkz4qDFYqdn5jRED038XYXaYA2wmnzVFPvm?=
 =?us-ascii?Q?cf9F8mf8Q352wUSv5cTlL5LAilG+3y3nscUaHcr9F8xjGrg0Fx9X54zcbUds?=
 =?us-ascii?Q?3Etgm+XEQOHbhwyfGV9NHFOqYL5WpxiX7RvS+uquHamazSXykCQGBOL7Da3d?=
 =?us-ascii?Q?aN6v9m98pR+e5xY0bb2DMQLJB4DTEPdnNqe5ugp/?=
Content-Type: multipart/mixed;
	boundary="_002_IA1PR11MB6345D8E26700693B1238C092FD7E2IA1PR11MB6345namp_"
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6345.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b88915a-841a-4560-8781-08dce75a6f74
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Oct 2024 05:31:18.2557
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /embN8smx+4xbLYSe49Ug0BP75q8ZuEKWXRIoma6y23240NGzz4/kMpTmBprNOx/e8WdK8hUc/8UwB1YMz98nw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7635
X-OriginatorOrg: intel.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241007_223123_085226_A91FD160 
X-CRM114-Status: GOOD (  12.49  )
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

--_002_IA1PR11MB6345D8E26700693B1238C092FD7E2IA1PR11MB6345namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Function blk_rq_is_poll is also called in blk_rq_poll function, so
remove from func nvme_ns_char_uring_cmd_iopoll.

Signed-off-by: Jianpeng Ma <jianpeng.ma@intel.com>
---
 drivers/nvme/host/ioctl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/ioctl.c b/drivers/nvme/host/ioctl.c
index b9b79ccfabf8..75f3a34e15a3 100644
--- a/drivers/nvme/host/ioctl.c
+++ b/drivers/nvme/host/ioctl.c
@@ -667,7 +667,7 @@ int nvme_ns_chr_uring_cmd_iopoll(struct io_uring_cmd *i=
oucmd,
        struct nvme_uring_cmd_pdu *pdu =3D nvme_uring_cmd_pdu(ioucmd);
        struct request *req =3D pdu->req;

-       if (req && blk_rq_is_poll(req))
+       if (req)
                return blk_rq_poll(req, iob, poll_flags);
        return 0;
 }
--
2.43.0

--_002_IA1PR11MB6345D8E26700693B1238C092FD7E2IA1PR11MB6345namp_
Content-Type: application/octet-stream;
	name="0001-nvme-remove-duplicated-judgement.patch"
Content-Description: 0001-nvme-remove-duplicated-judgement.patch
Content-Disposition: attachment;
	filename="0001-nvme-remove-duplicated-judgement.patch"; size=925;
	creation-date="Tue, 08 Oct 2024 05:17:35 GMT";
	modification-date="Tue, 08 Oct 2024 05:31:17 GMT"
Content-Transfer-Encoding: base64

RnJvbSA5NzE4OWViZDg3YjIxZjc0ZjYwODYyYmFkNDhjM2YwMzY2NjZhYWQ0IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBKaWFucGVuZyBNYSA8amlhbnBlbmcubWFAaW50ZWwuY29tPgpE
YXRlOiBUdWUsIDggT2N0IDIwMjQgMTE6MTM6MTIgKzA4MDAKU3ViamVjdDogW1BBVENIXSBudm1l
OiByZW1vdmUgZHVwbGljYXRlZCBqdWRnZW1lbnQuCgpGdW5jdGlvbiBibGtfcnFfaXNfcG9sbCBp
cyBhbHNvIGNhbGxlZCBpbiBibGtfcnFfcG9sbCBmdW5jdGlvbiwgc28KcmVtb3ZlIGZyb20gZnVu
YyBudm1lX25zX2NoYXJfdXJpbmdfY21kX2lvcG9sbC4KClNpZ25lZC1vZmYtYnk6IEppYW5wZW5n
IE1hIDxqaWFucGVuZy5tYUBpbnRlbC5jb20+Ci0tLQogZHJpdmVycy9udm1lL2hvc3QvaW9jdGwu
YyB8IDIgKy0KIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQoK
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvbnZtZS9ob3N0L2lvY3RsLmMgYi9kcml2ZXJzL252bWUvaG9z
dC9pb2N0bC5jCmluZGV4IGI5Yjc5Y2NmYWJmOC4uNzVmM2EzNGUxNWEzIDEwMDY0NAotLS0gYS9k
cml2ZXJzL252bWUvaG9zdC9pb2N0bC5jCisrKyBiL2RyaXZlcnMvbnZtZS9ob3N0L2lvY3RsLmMK
QEAgLTY2Nyw3ICs2NjcsNyBAQCBpbnQgbnZtZV9uc19jaHJfdXJpbmdfY21kX2lvcG9sbChzdHJ1
Y3QgaW9fdXJpbmdfY21kICppb3VjbWQsCiAJc3RydWN0IG52bWVfdXJpbmdfY21kX3BkdSAqcGR1
ID0gbnZtZV91cmluZ19jbWRfcGR1KGlvdWNtZCk7CiAJc3RydWN0IHJlcXVlc3QgKnJlcSA9IHBk
dS0+cmVxOwogCi0JaWYgKHJlcSAmJiBibGtfcnFfaXNfcG9sbChyZXEpKQorCWlmIChyZXEpCiAJ
CXJldHVybiBibGtfcnFfcG9sbChyZXEsIGlvYiwgcG9sbF9mbGFncyk7CiAJcmV0dXJuIDA7CiB9
Ci0tIAoyLjQzLjAKCg==

--_002_IA1PR11MB6345D8E26700693B1238C092FD7E2IA1PR11MB6345namp_--

