Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A0DBC369C2
	for <linux-nvme@archiver.kernel.org>; Fri, 18 Apr 2025 01:21:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:
	Content-Type:References:Message-ID:Subject:CC:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=s9jZ07VZUyiZ3rJJa9JKByz/s/uY96ut/66vE6foSA8=; b=ZYTxhvPDLTS41g/c/IgAhtm+C6
	Pxf7feCtn7ZJCGQNVhFHF1HbdhvX0CXs0zC6ozGRhcs0GfT5UCsTEBJO+hYaOTuIZLcMTJfy1q4Ym
	XjVEgLSRu7UaGV9BFDF+mmgoAmQcjvx461BZJziMNl5GX7Ptt+te2ybqlZDVNrKE6tLw9FwJhrNK1
	hv3xN6fXLiSA56kbvYNQudIK9WO9a52qqUv49KMhH6gX4QCnfafCkyKGVAzrd5vm0UY6VMA5Xf3jr
	z2fF/KCfDeLB1zDaW+2u1KluFfbMSsk97w/2BrzDNBXtisERQpTiYzhEkGhhCYg99ZUoeULg8yRyp
	K78G5d/Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u5aPX-0000000EknX-420Q;
	Fri, 18 Apr 2025 01:20:55 +0000
Received: from mgamail.intel.com ([192.198.163.11])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u5aPU-0000000EklH-2rWI
	for linux-nvme@lists.infradead.org;
	Fri, 18 Apr 2025 01:20:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744939253; x=1776475253;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=dQKtTF45SfbP5UCGJzWO1eJJO8gO0TpUlEfDEH6k1rI=;
  b=clSRLLG18dIONikJ4QiT7DAjOkHwf8q5hfDjbYOKzr+g1KH2OOHeM1C+
   nM3iOiyb30kxOmgswwF8WmoorTw0ioVUaakDIp1kp7QepW5iyLqDReYLn
   juJ5vNtvpM/03w/n1w1vTl5gOZoKlpp9Oze1tyaPL0uMD/9/WAa7I9KEa
   TUY+WIh6AOHJY5REdrh+B/h9h2YnudumyqB4vwIXhBfHURMDZ3QNsRMWa
   oMqzRRCSaa5F9MP1PlBs2z+xo8LbJKmyt5EWlNKUTCbmLPrfkGixGzA8R
   EEeklZ4oHqThRsixno6brA3O5rJiYvRJkGGg8gmkO1yno5caD6j9Mc/ny
   Q==;
X-CSE-ConnectionGUID: xYiGV8hSR+euSclqJfGgbw==
X-CSE-MsgGUID: VS4w+JiFR86mQXgNuS9klQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11406"; a="57228885"
X-IronPort-AV: E=Sophos;i="6.15,220,1739865600"; 
   d="scan'208";a="57228885"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2025 18:20:44 -0700
X-CSE-ConnectionGUID: yKJn7UxmSjO8wYaAdjRrhw==
X-CSE-MsgGUID: QnGns7S+Q6WSLXy3CUiRUg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,220,1739865600"; 
   d="scan'208";a="131534518"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2025 18:20:43 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 17 Apr 2025 18:20:42 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 17 Apr 2025 18:20:42 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.48) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 17 Apr 2025 18:20:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kqpKrH28Qk6FOUHO6pb8JIj5+Zctgxt3UJ5cRq/VTSbDKu5LHuRtCQ5cC9N9z9GxlcLAcH5TYM8AAzhTQQy8gsSlTHmvdODQZLSaQN9m4j6rj5acSfw6oY8pahZ7J4PNi4PLoeCUwm8FqWFZ9maRN/LZcLboa/sAKVy5hqQfGWYFQB5cfS4joqoxJUUyBZZbCEv6ExbpjsYb9/okPFEJdkikzfaiC8UokWvt68XU3C7aSILY11lVqUyGlm3n5XodLB21t5lqTiOIPG5OEMaZmRw3SDLfiDzhOaAF4eumAIFF6v42hauSezdvWU4gE3GMklzlwHHb60M/g5UlT5OE4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s9jZ07VZUyiZ3rJJa9JKByz/s/uY96ut/66vE6foSA8=;
 b=LAFcX5d7cAYItdgLTXzwD38H4+IdylP+ZizzQqaE7/CQTUrc0AYdCs3iutYrybDvB49U+MErSAeKH25YhCkrTbOLzPt5Oxde73Uz9nE4goQcxez21WYbWUyKc1JorYee+c/n5mmbZo2W+/ItJ89wjho/tq7FVyPoI/y3ZP9w7Oo5zCeHRqMPVCOSI6hlcyDZrla761GP50vx1SphWpYp1f4JwSVioe+/ezGdKkb+c73X+4Vx1Cu0dTjEY2uvaWkBvT//bz3D97z6DLY6v18jsTCJ/U1Rwb9s9BCAW2Qb8k224EjPBfzLw5Uoo+Fpjpg4RWeKTSyphOnZQB9GsaU2QA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by MW3PR11MB4588.namprd11.prod.outlook.com (2603:10b6:303:54::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.26; Fri, 18 Apr
 2025 01:20:39 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%4]) with mapi id 15.20.8655.022; Fri, 18 Apr 2025
 01:20:39 +0000
Date: Thu, 17 Apr 2025 18:20:35 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Jason Gunthorpe <jgg@ziepe.ca>, Marek Szyprowski
	<m.szyprowski@samsung.com>
CC: Leon Romanovsky <leon@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>, Joerg Roedel
	<joro@8bytes.org>, Will Deacon <will@kernel.org>, Sagi Grimberg
	<sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>, Bjorn Helgaas
	<bhelgaas@google.com>, Logan Gunthorpe <logang@deltatee.com>, Yishai Hadas
	<yishaih@nvidia.com>, Shameer Kolothum
	<shameerali.kolothum.thodi@huawei.com>, Kevin Tian <kevin.tian@intel.com>,
	Alex Williamson <alex.williamson@redhat.com>, "=?iso-8859-1?B?Suly9G1l?=
 Glisse" <jglisse@redhat.com>, Andrew Morton <akpm@linux-foundation.org>,
	Jonathan Corbet <corbet@lwn.net>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-block@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <iommu@lists.linux.dev>,
	<linux-nvme@lists.infradead.org>, <linux-pci@vger.kernel.org>,
	<kvm@vger.kernel.org>, <linux-mm@kvack.org>, Randy Dunlap
	<rdunlap@infradead.org>
Subject: Re: [PATCH v7 00/17] Provide a new two step DMA mapping API
Message-ID: <6801a8e3968da_71fe29411@dwillia2-xfh.jf.intel.com.notmuch>
References: <cover.1738765879.git.leonro@nvidia.com>
 <20250220124827.GR53094@unreal>
 <CGME20250228195423eucas1p221736d964e9aeb1b055d3ee93a4d2648@eucas1p2.samsung.com>
 <1166a5f5-23cc-4cce-ba40-5e10ad2606de@arm.com>
 <d408b1c7-eabf-4a1e-861c-b2ddf8bf9f0e@samsung.com>
 <20250312193249.GI1322339@unreal>
 <adb63b87-d8f2-4ae6-90c4-125bde41dc29@samsung.com>
 <20250319175840.GG10600@ziepe.ca>
 <1034b694-2b25-4649-a004-19e601061b90@samsung.com>
 <20250322004130.GS126678@ziepe.ca>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250322004130.GS126678@ziepe.ca>
X-ClientProxiedBy: MW4P220CA0003.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:303:115::8) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|MW3PR11MB4588:EE_
X-MS-Office365-Filtering-Correlation-Id: 5003390b-5f13-47a2-c44d-08dd7e173ad7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?B4pWIZ+5hJd2d9Z/0nSDy8ZhCmGR4rFTDJ5oM/gqr4mnFn/7EZhGUidPtOzH?=
 =?us-ascii?Q?VpIVgwz/jYS688V/rLkHZNB/IXUoGuhWCNL8cY4TnZhbUDMSmGknaMTDSkKa?=
 =?us-ascii?Q?IDwWVqbKEsgxQSX+s28k2CHf4te4ReRwt7liCs7YDW4eotbRpuJi9VWG6Pp6?=
 =?us-ascii?Q?8MnIi9KLOc7EmaFof2dav4lGws2IeHoH/9E1HtTlLOQX4ppQZpa6Q/X8piua?=
 =?us-ascii?Q?+BT+BgPbSLgnFF5++zftB433uYhszQN43iLsM5KAacMixllQf1G8lxr7cyeA?=
 =?us-ascii?Q?RUjIzwkT4ScNIdxmfJehXx7qZvvojISqY8f+Ti+J7UMd+M91foXR/xH7/yND?=
 =?us-ascii?Q?wdqunc9yK6qAS/mXBLFhfSNZMP/8Yj7oNili90i4yuLSzGB2fFZJNsMj6fqp?=
 =?us-ascii?Q?DHOR/NB3j8nNyU60PVIzLDhW3cMo+Ba3gCIT/tEPAME9HkRU6NXhRpoV94Bl?=
 =?us-ascii?Q?pF+idnCi0F5P3gZbsj0chIkoF1t2qhTj73ORhJsDOd1Zbs1Qe4FzN5/NpiSA?=
 =?us-ascii?Q?zvoU70cxr5ksi0F5p52xku+cIT1VYoy7G/3A13gk4WmZXSszx9O8xac/OMF0?=
 =?us-ascii?Q?sXa/uj//64rvvIPNKNTrxbDZfxC4kdZw4IuxKONWhs+qx37aVAOIKOmC+Ri0?=
 =?us-ascii?Q?QGqbfpoTI+7p91wFt+bMjSQ//x67mWwHP6pJHRO4sYP4M2o/YbZNmvKzWNdB?=
 =?us-ascii?Q?Ac/2a2ElkOpF6DvV2VA84/fyKWtwJTnxU/PpOWpW/ku9Ddb6DvUVDEtwn+Gh?=
 =?us-ascii?Q?w6esjx/XL+T9rL4Ku2IWCxyjSEuAT+c+6iWqgkjD35NHmnoqznXz0vjkdR8D?=
 =?us-ascii?Q?9O6AmBIqyWPH8o//2FofY21DwZveB9sPb4lkAxa45EWWL5t6wONpd7V/tFnN?=
 =?us-ascii?Q?O6BOgKIpC1EBvx9Z10ixHhpS56Y6qSaeiSQ2Pg9U5hTtRdGp8qgteZuLgbc+?=
 =?us-ascii?Q?J6C+sERmLmUH9ilWoK2DoZgJ7xi4hAvJaU4QgwTy6fyA+thUyrRm4nczcRfj?=
 =?us-ascii?Q?0pTheuznQIlKQayfKzCu9tJFzQzJfPTwbUwMi4P4xFqQFwCiH++a3uImtt65?=
 =?us-ascii?Q?Y7FZTUFhdsKQ/9+tPl6upV5OMxhQFKsnRlDfn/vyPwUGTRwJF7IRzs+kMuD4?=
 =?us-ascii?Q?INqvpLL1siVjmaLCh8oasz12YlIiQ6JCVOvA6JS8RaYa8W59INmqf/QJ0FYq?=
 =?us-ascii?Q?FiQ8F+6nLjPdLaHQhWd3guSBaF4kpQYni0Bt1asalWkom3F6R5qWAfoOfpeb?=
 =?us-ascii?Q?KoKQqhcyKgeBVWm0f3cQzSX2KbMNnJ8LgW54BahFVcm4of6YszjF5lv6SToX?=
 =?us-ascii?Q?N2ETANkr8eg8T+wqsRcqxxSmMjmBovqWc6hs+urGohElN/u1RrtKHNH+mkCk?=
 =?us-ascii?Q?/vOe/xz3d+F+nWgu0nCqc9ePDkVk?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?B9pmLmv9kFiXLFo39DFgQO52cR315cVMjFdI3VOdNAWW/gcSFg7sd4KbvXUv?=
 =?us-ascii?Q?WhnbJEPf0xxK8YGbCe5MfSO9+qC5NXIUPLk30UKMOa5Ego9+10K7cVW8E696?=
 =?us-ascii?Q?7xxs6myrkklEj9J9onDs9IlQNuVT6Qh7nfc+S+/jdTkarWGTVW4irOmanGSx?=
 =?us-ascii?Q?UunzwCAysvs3vEGlkP2ujFHXA12bLzreTlz5uZq/RoGGw0C9Qr1p+5R8c0/b?=
 =?us-ascii?Q?gnoIwsPe/ObqOAaQRuO3Op0sLr2Utsl3Z15ahbnFgMq7NT5dcuEVfVkY5JlV?=
 =?us-ascii?Q?m1p4nMMVZEMTcTGGsW2hcG/BOD17qRq3s9qPdoCXEDgnwsG9M3PkvXQTMHGw?=
 =?us-ascii?Q?u9cDwLPDSrWrKRAvG5/tSz0/XaAjtZMeJxNG3dmMwHmjljemMnlQoxZ3caI4?=
 =?us-ascii?Q?N/96L47b1m57ff09t2Q24dEPoBNRKZdxO0ABvvpQKCjlbBzo/Au3sRYex6eu?=
 =?us-ascii?Q?odm5dT7ubVpPRALdkhc/esAhnjjb0LRrbvpuHAc1c5InKzNZ76iwnVRI82AK?=
 =?us-ascii?Q?Hca8IBpvOByiiD1at4ggyp8y9pFZ5UonAyOQdztZOLbXSHsMeOS88dXQ/3eg?=
 =?us-ascii?Q?zNhc1Oe+LAsWD8LICfR9qI8N9Hx13k76S/XAxtxSIMNG77xt2k6ZpDO80nJh?=
 =?us-ascii?Q?eR0sqqyNMbzuzlcLjXyjlAF2fvch4S37RUHHEMILtFBqNzXImexOYVzhsCeI?=
 =?us-ascii?Q?0jHcYT2O6y0WPsURSnP0KoGX2oSsom1eGS2dyTGLRF4R2gqo8jYU446rRHOP?=
 =?us-ascii?Q?rNicvQ4LRcBaKc8NpnQH9agtP1FVdFaT37QYJmjmowtenn8Eh9QAnGITDWXa?=
 =?us-ascii?Q?pJfQ3sXYR871GvQFFJVTkRutqGnCzXKkTBAX2YTEZb7XHvMXwHSk08/sVrkm?=
 =?us-ascii?Q?Tx5rWxeVjvkCWlwvaDq1GiWipSopxDYhkgla5Qr+4+NSu7tBOWHamBrxtkYO?=
 =?us-ascii?Q?lQJscBjaEc8Jj8x2l/9jGRhy1bFm+oKRYxAUnRwwneLG4udJ9HfePViDJL1W?=
 =?us-ascii?Q?YWnKBhHJ8IyNFDv8RMPmo9KNeCv+kf+Kc3ZrmHuqP88jJ9zC4IKn68+o5J+9?=
 =?us-ascii?Q?i4y9hQ2JS9gUC+0CTk7KG0jKIK8cwt3WjVS+qCe2sP4rbbUP34GcLBUzbLvk?=
 =?us-ascii?Q?3LahotAANsdFcswBT/FuwEmoKp5WoRZ6p94cQ6iZ/LjGa+I2WxpcKzib4YOG?=
 =?us-ascii?Q?LYRPMEdbJnSYee3+DGrzd8AZ8rt4cFbYNXLFIxFBVQRY76Nx2+vo5XaMAu/w?=
 =?us-ascii?Q?zkzUsiEUjZbhDlOv17gvOwAJu2CuoKSR/1rac6yCGbNVX6gvSrexs9XsAJ0b?=
 =?us-ascii?Q?/C06xmtetp1sr5GRmDDw0l8wmd2uSrhlkgkkMt+KLUQTm2hLuxAThYUJl/r3?=
 =?us-ascii?Q?H5ueMdoQKFCVMZYz7sd6ZMvCplEgzCZAOlPTpTiDvTSX5oThzemX5MwfG9N9?=
 =?us-ascii?Q?Vh33xmU2FoLeAsZcuIJ6BL+Id9nun+EuBFnVlu6akUNVTJb66hqDGGieocr2?=
 =?us-ascii?Q?EgmGd+P7mOgyor3yMoOkpjdFD1Edv8n7wd5ySU0exddz0Vr8oos4TSoL7jyP?=
 =?us-ascii?Q?ylMDufkTom96slL0+OyGSvH6zG/B0K37Zz8TEVKJnGn5QY4dvaGFCa3FrgAN?=
 =?us-ascii?Q?HQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5003390b-5f13-47a2-c44d-08dd7e173ad7
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2025 01:20:39.4865
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SKNzGFSFOpw14PQOCwBhQNNJFb/sGsLfnKM9+5sU+eZtqjey5BdlLXPw5vp+/Q+c8nxUtfJ1d4o/7tMA7wiTAu+7QS6vF0V+rOcOchP4xY0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4588
X-OriginatorOrg: intel.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250417_182052_758171_AC73ED65 
X-CRM114-Status: GOOD (  28.38  )
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

Jason Gunthorpe wrote:
> On Fri, Mar 21, 2025 at 12:52:30AM +0100, Marek Szyprowski wrote:
> > > Christoph's vision was to make a performance DMA API path that could
> > > be used to implement any scatterlist-like data structure very
> > > efficiently without having to teach the DMA API about all sorts of
> > > scatterlist-like things.
> > 
> > Thanks for explaining one more motivation behind this patchset!
> 
> Sure, no problem.
> 
> To close the loop on the bigger picture here..
> 
> When you put the parts together:
> 
>  1) dma_map_sg is the only API that is both performant and fully
>     functional
> 
>  2) scatterlist is a horrible leaky design and badly misued all over
>     the place. When Logan added SG_DMA_BUS_ADDRESS it became quite
>     clear that any significant changes to scatterlist are infeasible,
>     or at least we'd break a huge number of untestable legacy drivers
>     in the process.
> 
>  3) We really want to do full featured performance DMA *without* a
>     struct page. This requires changing scatterlist, inventing a new
>     scatterlist v2 and DMA map for it, or this idea here of a flexible
>     lower level DMA API entry point.
> 
>     Matthew has been talking about struct-pageless for a long time now
>     from the block/mm direction using folio & memdesc and this is
>     meeting his work from the other end of the stack by starting to
>     build a way to do DMA on future struct pageless things. This is 
>     going to be huge multi-year project but small parts like this need
>     to be solved and agreed to make progress.
> 
>  4) In the immediate moment we still have problems in VFIO, RDMA, and
>     DRM managing P2P transfers because dma_map_resource/page() don't
>     properly work, and we don't have struct pages to use
>     dma_map_sg(). Hacks around the DMA API have been in the kernel for
>     a long time now, we want to see a properly architected solution.

So I am late to this party, but after watching a "modest" proposal of a
DMABUF pfn exporter bounce off the DRM community due to long standing
pain points with scatterlist abuse [1], it is clear to me that a new DMA
mapping API is in the critical path for PCI Device Security
(Confidential Computing: TEE I/O).

Specifically, the confidential computing problem of how to coordinate
the conversion of assigned devices from shared-world to private-world
(including private device MMIO and DMA), needs a "non-scatterlist"
"struct-page-less" mapping contract to describe those resources.

I concede the point that there are gaps missing between this proposal
and the end state needed for PCI Device Security. However, it seems to
be a case of "violent agreement" that some of the benefits of this
proposal only arrive with future work. So this is a necessary first
step.

For my part, I plan to pull this series into a cross-vendor staging tree
for device-security topics [2] so that the PCI Device Security community
can get started on everything that needs to build on top of this.

[1]: http://lore.kernel.org/20250107142719.179636-1-yilun.xu@linux.intel.com
[2]: https://web.git.kernel.org/pub/scm/linux/kernel/git/devsec/tsm.git/

