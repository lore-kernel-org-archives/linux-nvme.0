Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12B0AC5DF8C
	for <linux-nvme@archiver.kernel.org>; Sun, 23 Aug 2026 12:19:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-Type:
	Message-ID:Subject:CC:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=e1fDRQHo9mVzw2U+RJ957ttdnSlLetJ9PwKK+e8FW9I=; b=jPwT/FiaN59oVbDf1pIPiFfcz9
	aUG/SEG0SUTHo/B1BLtF9yVOQvAH8g+QPun3HQ+WbPBcj0KVmBvciAf5lPSDBcdUZJk3s65S01RaI
	lfy2ZfWPSlzm2ftchMa2XGMN6YEB9ZtUlpBgaUItktNVvEKXGUWKcaaZYKewpw+fnUGkGOSoCL6uZ
	njpuL2g2xuXOsdSh42Iir3JJvN+BqiFH7UlicbR98T7zBi1OmEnbwsFKa0MUjgl6CL9dBoDKhexHL
	+f+nhf4cwelSZbaRxZEiA+1NrB9Op5THdyo492XN0CFG7sZKuwJaZI8qUfWpMIWw5VWncw7uUc4zM
	B7avqhqw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wy7AP-0000000FKP3-3LaQ;
	Sun, 23 Aug 2026 12:19:13 +0000
Received: from mgamail.intel.com ([192.198.163.11])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wy7AH-0000000FKOW-07t6
	for linux-nvme@lists.infradead.org;
	Sun, 23 Aug 2026 12:19:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787487545; x=1819023545;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=VMsuVeVTnGIFakjooYNZ7JQhcIpq4EVGEjuwSocPMeI=;
  b=Q/y05HbMNvy9gI/N7ET/w9S0pj/hyuiewNGMKA7p+ciPgWbjm2X+m5XF
   MfXjEp5PGoHg4R2xaFA33JNiKxfjHVQBF5+UT+jmV1g9pA0Jq5q4YDy98
   I/mOZxNdSGtySEdF1IhzDAD8FSeAddFiMDTA3+XHlUFRgBUnUtG2f41QQ
   IXEVTQqCwk12sZHLey109/tW5Yo82Bc/VzhZBRxKrN5Z0gQy24YGTJYz6
   z3fjbYr+jMoZ2kouauFvSE8tRClFrnBC8iL6FvgriUs8OW2/F1evMFJKM
   Jxq3xpqoKKTpdfPm5KQTo3ACWA+gnz01tp53p7XWHuWdReL98yS0RQlp5
   Q==;
X-CSE-ConnectionGUID: O+iRskxjR0SWsLwZ+A/5pQ==
X-CSE-MsgGUID: obNiSSmQQiqZWBzl5PhA5g==
X-IronPort-AV: E=McAfee;i="6800,10657,11883"; a="98551937"
X-IronPort-AV: E=Sophos;i="6.25,238,1779174000"; 
   d="scan'208";a="98551937"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2026 05:19:03 -0700
X-CSE-ConnectionGUID: I8gwBEeYT02P37qOo1U7pg==
X-CSE-MsgGUID: wyWgLqddQCKECVMqgQAf5g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,238,1779174000"; 
   d="scan'208";a="263059333"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2026 05:19:03 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Sun, 23 Aug 2026 05:19:03 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Sun, 23 Aug 2026 05:19:03 -0700
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.41) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Sun, 23 Aug 2026 05:19:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cm06VUN2r3B4kGldLCGeE2J8ljO9017+nSakpSa6YJP4a4NnH+YCtpbx6YI58VjHzaKqOz4WaFCC7EYCPGR/yNZostAEI0IEPdBt/ox1UT9eMnHaqmZ0ojiyXlZJHhyAkqZemRvacpW8JYMPv0RBnMjoIn9/v5W4b2nlMi7pt3IeL6pwQe2avH+kvKq5qKWdkD9VcXcHUNYqSHmIskqnsGllMrrGBJoZ1Ypzs/iSNOagUnTXkMxJ/GVaKgaalyg3hAT2pYpas4th3MQmZsuwl3+cfAjRnyjqh6X/NgjJyAGez3sP4a1Y1AeN2QhFT2XxMEP0A9NXUGpVF+OqDJMGPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e1fDRQHo9mVzw2U+RJ957ttdnSlLetJ9PwKK+e8FW9I=;
 b=aNYr5cK6Vjq/2G/GrpWkrwWBeg1Ip/dOGUfB5XyG69yqVleOMuochJ0u590oMNpJAUml118LifaJ+DmAmIqoQtO/taSGI83sr7H5X8OkleZnhxbm7n3doPax40r/EZLvkK6OpjZrGdGhDmUanMaFBgBXbfCwaimY2I7JthQzUBJiTttN37Y+VEOyiuaGnf2xndbuWooef4qgq2sLQUfZW+w2LiZqJGvvePHA8pf2KBc6Q1Im4ORlXTXf4hwj3RNSU1tY6cdJtrUBuq/WfGa8HfMeVBf2VFDDXQF7HrGTLZB84MfLkoKJLn+VmabUGnpFSn7MIbuCQxO+6PFray99Sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ0PR11MB5214.namprd11.prod.outlook.com (2603:10b6:a03:2df::22)
 by MW4PR11MB7053.namprd11.prod.outlook.com (2603:10b6:303:221::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Sun, 23 Aug
 2026 12:18:56 +0000
Received: from SJ0PR11MB5214.namprd11.prod.outlook.com
 ([fe80::5926:3836:4212:8640]) by SJ0PR11MB5214.namprd11.prod.outlook.com
 ([fe80::5926:3836:4212:8640%4]) with mapi id 15.21.0339.012; Sun, 23 Aug 2026
 12:18:56 +0000
Date: Sun, 23 Aug 2026 20:18:50 +0800
From: kernel test robot <lkp@intel.com>
To: Keith Busch <kbusch@kernel.org>
CC: <linux-nvme@lists.infradead.org>
Subject: [linux-nvme:nvme-7.3] BUILD SUCCESS WITH UNVERIFIED WARNING
 ff7ef8d4a18ff7e94e07dc02dff38dfebf029948
Message-ID: <202608230429.WUSKEi1v-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: TP0P295CA0054.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:910:3::18) To SJ0PR11MB5214.namprd11.prod.outlook.com
 (2603:10b6:a03:2df::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR11MB5214:EE_|MW4PR11MB7053:EE_
X-MS-Office365-Filtering-Correlation-Id: c74d6ba0-75de-44b6-77bf-08df0110b44e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|10067099003|56012099006|6133799003|18002099003|11063799006;
X-Microsoft-Antispam-Message-Info: 6eYc7Lu+Ox49vD4zYq7hvLNkvNUNePhYxtibreB6afkIPxXFinnl+pB7XD76b6uiY402mA+pdldtoQgsBbCgkJ1gNUhBGd91xJ4Y4zFyidS3VFwpDb/GSEnomYrxggjMseidVYw5aoIjIJbfhGhys78fbpHLKFj2NSgIjedkL8bRsUzTdr1rKb7vHWyB4Rkm242MDH/mwOLt3cr9zXuwEU5XL5p/0dOYhB4E+UGRveKpfGKdCW25EwYbLKfMicTkR/8+wyN+h3bpGk3xoKzFLh/1dfPIO9LCLGJBwEXhOn6Ibqwl4JpSxx04fS/vX5c2tYwjmSiGRtY2VNnvkgxddUjJB1pDZUHfxM3+8RzRgOdj0HNuewMoEjl4ElPb+sjrSmFD2/jaEoAObbwQCc8G8s2gH0vcA+Z088DMPZAbWO6rTA/NOLAbByHTSC/l61eriNXsqa8Rj09OaTETfrIV01y0XmB8SE+AZIyuOBxfJnwtkxmRC7Ly1d+n7erxphTg9TbXNt3tKUJgGKC2eydv0sU9mTouKD3YY7tPDLFYlR6SnZp6Mun/8qNihleEgbk+QwbDnMMhyqr3usF/sZlvd2sMi69Q93P++TTXxRHkYKfeKsB6A8qLL7q9q/uwbaf/fCo2yNBQud2Acx4mXWVtG348G8Ho4tsSL5I/Ty9QKbM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5214.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(10067099003)(56012099006)(6133799003)(18002099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?s08/ZhVY9taN4hjFP11T1qUe2bfsIkIU3JLsdiVOcC4JKWetbojy9r2SEhb3?=
 =?us-ascii?Q?FhMdSdYncHHUJL0bc+s/ynbjFwm35Zw6wvf18sbZsVOBhJucVdbhRBcn7fXi?=
 =?us-ascii?Q?Bdx/hcWMsYzDnAmpnfAZoyInzgIx3sziJugDQcMPTygQkvyO+7kSsB9Flmju?=
 =?us-ascii?Q?HRjypZD1vfcIbrfVRbtMBgqTvHPXYvv3LlIH1wIb7T3tMhWYCDjwEJ07z7ny?=
 =?us-ascii?Q?0omfgwqtBz2OQgH67aSBHe/a9BWMxrJsX+KwF7eZlT0gbc2UHvtXQnfJPCA1?=
 =?us-ascii?Q?PZKTtyJAnUOeGf/qEKHwpoEEsZATr3BjjMCYYK08jjGj8MENqEWryEAcasid?=
 =?us-ascii?Q?OFEdr+QaUUqrE5DLs3zUTstLEM8CuoSkmMUtR+mAMhRq2rHEqBq80baFhtWP?=
 =?us-ascii?Q?meG5YzwnSNVlMcosWCSiPpZ1dpwQQgqSeLmL0M4AOfDCg4fX+JIkcaOgVaWa?=
 =?us-ascii?Q?dyXI8TalT9E9wPh49wDX3wQG+1g0Nlfu7A+gdsCSrBq1NjK2R0xhG8Kze36t?=
 =?us-ascii?Q?JWmXxql+e/qi5ZMQIuHa89Ai90NvxHIfTFoVAfu74atEGvgOHVuwXqW3QD/4?=
 =?us-ascii?Q?lLGKZHR1L4/WueRPR7EDuZ6nol3JSTSZGSAQh8pJeJxPZcsQG6Z1qqe8BMpQ?=
 =?us-ascii?Q?G0Uf72uTVSXOpScCqaxyRWBwS0MHlpu5q2zRzuMzn+Hd9LWLL3yDD1Duvf1z?=
 =?us-ascii?Q?8FfRoJnS1aUBSxL/nepKOxMckEIlAbu0WgGafJW0pyYCBnrChFqJIY8B98W2?=
 =?us-ascii?Q?ER+yvEnHamnWDTm8xYGGFdR9rPwPdsYBpnxw0WoEtZs4dft5Rhjvvy27v81C?=
 =?us-ascii?Q?xdnyZmTT7782v6B9J+wTueYL4FAbclLla8GsYyQmT2ZvvgULNUO/m6xwyMLO?=
 =?us-ascii?Q?vof30JyJzD3Ry/xRSCuUk5ZZ3/9bi504t/t3W6lDJeLBu5fyQqdAdtmeZSNq?=
 =?us-ascii?Q?GHZU3ZkZcT9dUVVSx8V5ydxArrbba4KLyBgjmOrVLGfcfzM949xO6T3wp+7R?=
 =?us-ascii?Q?Xheho7tlGbIvKUxAIq8AR4GRvJXz7ucMiusmiGQFTsnHSwlWZRqGHaLWSkUX?=
 =?us-ascii?Q?T57NM8Tck702pFs34Zn+XhdtjJfNUnVHJ+Hq6CBXwB9MfCX5zqwWJ6Aq/uhF?=
 =?us-ascii?Q?KaOH1oZ6LrbUy2mCFqfN/VBtlorEg4jrPBsRwdUx2JY9UgkoRcQw6N8uD48W?=
 =?us-ascii?Q?2r//7QPJ3VQJMO/f6h4SsDJ6zYFymMemmpkKJMkPPTXXko/K8nRq44+1liZk?=
 =?us-ascii?Q?V2e1MudhRTLJaiTc3TaPk9Ovq121p2IvB/DlIhkAwJ/ntjMT9smzF79VpGa+?=
 =?us-ascii?Q?1AFx7teFoYNtK11qQ9hmoTL3vcncMwVVu+UVo4CK6TcAUCiZU77GyO0z5i/G?=
 =?us-ascii?Q?X4SMGEmre4iEXHjvFNhdxd1JGFGPz/QFJwNQYpxw659OgBnjJ7epSW0dU32E?=
 =?us-ascii?Q?5wmaKRayve4XTZxB5WKaxUGHiLZbYXelibULBzojQFnLJHXiv+ssYwjdD3tB?=
 =?us-ascii?Q?PH4WriRAaxePGxgNOFaHbV3qex4P1qeppcH8K26CeaUpnTd1T8jDAXSWd9dI?=
 =?us-ascii?Q?JggypU0+ARaVvmKZOk6bGzrx+ISSicKaIuHQE+1xFPl8PT8es1/rUNQBUEyj?=
 =?us-ascii?Q?e907rX8FJj6ExGiPMpIwLRerguOavfPs6lgIPa3U8jn4o3L5ZSoOLkAjyW3z?=
 =?us-ascii?Q?Ud6nRSkZSrlQ9IdfoDVJE9n0v/obwL+9LFp5hg4a8wig0XU7/o02F1cP662H?=
 =?us-ascii?Q?pfjrTPC0EQ=3D=3D?=
X-Exchange-RoutingPolicyChecked: FG1dg7cKUuNvupzCBG+lHHaoCaLszHUX9SBbHGJF26OCCxeR9ZQH9oZKL41v7dsyQBDhtmVDONZV7zaQU73wlC4Yy92GhO4c4TGTJbxA6iaicuP5fTOJtLDknOnMTnfn6KmVlzbeTNkzkM6QWsHLhxxqxzhMIx4feGXvvBd2bkLslv/eByb7rAC6XLgHeHi9RDWI40gXYn7dRVzYCRMF5gmM+HNvVLGZAy//nPe3crUg/ZE7qS6slsJjYWMULxEPpUrdDkDgPBDvE1FLjZKjrKWU2AKXDjJZLS/+/tftGTrNbM+Lgh4t11C+XvwGxMHLX2bI0AjBE9B4g6MmUDB6gQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: c74d6ba0-75de-44b6-77bf-08df0110b44e
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5214.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2026 12:18:56.7183
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7HpqtSZfBGaGU2p6A5sfWS7VEO1gXczDShtwdxQRSYztcNilenxF+1q6Jcu9W/h0xxl5LCu1R+6+NBoXQbo38A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB7053
X-OriginatorOrg: intel.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260823_051905_117703_C18AC318 
X-CRM114-Status: UNSURE (   3.72  )
X-CRM114-Notice: Please train this message.
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

tree/branch: git://git.infradead.org/nvme.git nvme-7.3
branch HEAD: ff7ef8d4a18ff7e94e07dc02dff38dfebf029948  nvme-fabrics: fix DHCHAP secret leak on parse failure

Unverified Warning (likely false positive, kindly check if interested):

    https://lore.kernel.org/oe-kbuild/202607291634.E5clnaLh-lkp@intel.com

    drivers/nvme/host/multipath.c:249:38: warning: reading variable 'current_path' requires holding __ctx_lock_RCU 'RCU' [-Wthread-safety-analysis]

Warning ids grouped by kconfigs:

recent_errors
|-- arm64-randconfig-003-20260822
|   `-- drivers-nvme-host-multipath.c:warning:reading-variable-current_path-requires-holding-__ctx_lock_RCU-RCU
`-- loongarch-defconfig
    `-- drivers-nvme-host-multipath.c:warning:reading-variable-current_path-requires-holding-__ctx_lock_RCU-RCU

elapsed time: 2082m

configs tested: 141
configs skipped: 6

tested configs:
alpha                            allnoconfig    gcc-16.1.0
alpha                           allyesconfig    gcc-16.1.0
alpha                              defconfig    gcc-16.1.0
arc                             allmodconfig    gcc-16.1.0
arc                             allyesconfig    gcc-16.1.0
arc                nsimosci_hs_smp_defconfig    gcc-16.1.0
arc                  randconfig-001-20260822    gcc-10.5.0
arc                  randconfig-002-20260822    gcc-10.5.0
arm                  randconfig-001-20260822    gcc-10.5.0
arm                  randconfig-002-20260822    gcc-10.5.0
arm                  randconfig-003-20260822    gcc-10.5.0
arm                  randconfig-004-20260822    gcc-10.5.0
arm                        vf610m4_defconfig    gcc-16.1.0
arm64                         randconfig-001    gcc-14.3.0
arm64                randconfig-001-20260822    clang-24
arm64                randconfig-001-20260822    gcc-10.5.0
arm64                randconfig-001-20260822    gcc-14.3.0
arm64                randconfig-002-20260822    clang-24
arm64                randconfig-002-20260822    gcc-12.5.0
arm64                randconfig-002-20260822    gcc-14.3.0
arm64                randconfig-003-20260822    clang-24
arm64                randconfig-003-20260822    gcc-14.3.0
arm64                randconfig-004-20260822    clang-24
arm64                randconfig-004-20260822    gcc-12.5.0
arm64                randconfig-004-20260822    gcc-14.3.0
csky                            allmodconfig    gcc-16.1.0
csky                 randconfig-001-20260822    clang-24
csky                 randconfig-001-20260822    gcc-12.5.0
csky                 randconfig-001-20260822    gcc-14.3.0
csky                 randconfig-002-20260822    clang-24
csky                 randconfig-002-20260822    gcc-14.3.0
hexagon              randconfig-001-20260822    gcc-16.1.0
hexagon              randconfig-002-20260822    gcc-16.1.0
i386                            allmodconfig    gcc-14
i386                buildonly-randconfig-001    clang-22
i386       buildonly-randconfig-001-20260822    clang-22
i386       buildonly-randconfig-002-20260822    clang-22
i386       buildonly-randconfig-003-20260822    clang-22
i386       buildonly-randconfig-004-20260822    clang-22
i386       buildonly-randconfig-005-20260822    clang-22
i386       buildonly-randconfig-006-20260822    clang-22
i386                          randconfig-001    clang-22
i386                 randconfig-001-20260822    clang-22
i386                 randconfig-002-20260822    clang-22
i386                 randconfig-003-20260822    clang-22
i386                 randconfig-004-20260822    clang-22
i386                 randconfig-005-20260822    clang-22
i386                 randconfig-006-20260822    clang-22
i386                 randconfig-007-20260822    clang-22
i386                          randconfig-011    gcc-14
i386                 randconfig-011-20260822    gcc-14
i386                 randconfig-012-20260822    gcc-14
i386                 randconfig-013-20260822    gcc-14
i386                 randconfig-014-20260822    gcc-14
i386                 randconfig-015-20260822    gcc-14
i386                 randconfig-016-20260822    gcc-14
i386                 randconfig-017-20260822    gcc-14
loongarch                          defconfig    clang-24
loongarch            randconfig-001-20260822    gcc-16.1.0
loongarch            randconfig-002-20260822    gcc-16.1.0
mips                         eyeq5_defconfig    gcc-16.1.0
nios2                           allmodconfig    gcc-11.5.0
nios2                            allnoconfig    gcc-11.5.0
nios2                randconfig-001-20260822    gcc-16.1.0
nios2                randconfig-002-20260822    gcc-16.1.0
parisc                          allmodconfig    gcc-16.1.0
parisc                          allyesconfig    gcc-16.1.0
parisc                             defconfig    gcc-16.1.0
parisc                        randconfig-001    gcc-15.2.0
parisc               randconfig-001-20260822    gcc-15.2.0
parisc               randconfig-002-20260822    gcc-15.2.0
powerpc                      ebony_defconfig    clang-24
powerpc                mpc832x_rdb_defconfig    gcc-16.1.0
powerpc              randconfig-001-20260822    gcc-15.2.0
powerpc              randconfig-002-20260822    gcc-15.2.0
powerpc                    tqm8560_defconfig    gcc-16.1.0
powerpc64            randconfig-001-20260822    gcc-15.2.0
powerpc64            randconfig-002-20260822    gcc-15.2.0
riscv                         randconfig-001    clang-17
riscv                randconfig-001-20260822    clang-17
riscv                randconfig-002-20260822    clang-17
riscv                randconfig-002-20260822    gcc-12.5.0
s390                 randconfig-001-20260822    clang-17
s390                 randconfig-001-20260822    clang-24
s390                 randconfig-002-20260822    clang-17
sh                                 defconfig    gcc-16.1.0
sh                   randconfig-001-20260822    clang-17
sh                   randconfig-001-20260822    gcc-16.1.0
sh                   randconfig-002-20260822    clang-17
sh                   randconfig-002-20260822    gcc-14.3.0
sparc                         randconfig-001    gcc-8.5.0
sparc                randconfig-001-20260822    gcc-8.5.0
sparc                randconfig-002-20260822    gcc-8.5.0
sparc64              randconfig-001-20260822    gcc-8.5.0
sparc64              randconfig-002-20260822    gcc-8.5.0
um                   randconfig-001-20260822    gcc-8.5.0
um                   randconfig-002-20260822    gcc-8.5.0
x86_64              buildonly-randconfig-001    clang-22
x86_64     buildonly-randconfig-001-20260822    clang-22
x86_64     buildonly-randconfig-002-20260822    clang-22
x86_64     buildonly-randconfig-003-20260822    clang-22
x86_64     buildonly-randconfig-004-20260822    clang-22
x86_64     buildonly-randconfig-005-20260822    clang-22
x86_64     buildonly-randconfig-006-20260822    clang-22
x86_64                                 kexec    clang-22
x86_64                        randconfig-001    gcc-14
x86_64               randconfig-001-20260822    gcc-12
x86_64               randconfig-001-20260822    gcc-14
x86_64               randconfig-002-20260822    gcc-12
x86_64               randconfig-002-20260822    gcc-14
x86_64               randconfig-003-20260822    gcc-12
x86_64               randconfig-003-20260822    gcc-14
x86_64               randconfig-004-20260822    gcc-12
x86_64               randconfig-004-20260822    gcc-14
x86_64               randconfig-005-20260822    gcc-12
x86_64               randconfig-005-20260822    gcc-14
x86_64               randconfig-006-20260822    gcc-12
x86_64               randconfig-006-20260822    gcc-14
x86_64                        randconfig-011    clang-22
x86_64               randconfig-011-20260822    clang-22
x86_64               randconfig-012-20260822    clang-22
x86_64               randconfig-013-20260822    clang-22
x86_64               randconfig-014-20260822    clang-22
x86_64               randconfig-015-20260822    clang-22
x86_64               randconfig-016-20260822    clang-22
x86_64                        randconfig-071    gcc-14
x86_64               randconfig-071-20260822    clang-22
x86_64               randconfig-071-20260822    gcc-14
x86_64               randconfig-072-20260822    clang-22
x86_64               randconfig-072-20260822    gcc-14
x86_64               randconfig-073-20260822    clang-22
x86_64               randconfig-073-20260822    gcc-14
x86_64               randconfig-074-20260822    clang-22
x86_64               randconfig-074-20260822    gcc-14
x86_64               randconfig-075-20260822    clang-22
x86_64               randconfig-075-20260822    gcc-14
x86_64               randconfig-076-20260822    clang-22
x86_64               randconfig-076-20260822    gcc-14
x86_64                          rhel-9.4-bpf    gcc-14
xtensa               randconfig-001-20260822    gcc-8.5.0
xtensa               randconfig-002-20260822    gcc-8.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

