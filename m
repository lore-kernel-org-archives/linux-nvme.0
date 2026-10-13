Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82EA4CC6B12
	for <linux-nvme@archiver.kernel.org>; Tue, 13 Oct 2026 19:06:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:
	Content-Type:References:Message-ID:Subject:CC:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Jja6HWipXPBP0fhiYsOu2yvru9X1oRQqqueihYO+GBg=; b=BaC0n57KRghBvkeeik7WOSnQ+h
	0+LcOB1vV/mMIcSuK4ScoMr9YHB+oYkAnoFlOWj3dbw6NQZFYWw+N1h9OT8vITwoqFzfqpr7JvCZg
	+aLdArBRGjFY7P2quVA7XkQfZk8dcHo9YTOzI4wHh+nWtsrz7Ye/ASmbg3uT+mag3COPRrCNaBO30
	r/pFM+aLrJKL8d6PJBR5qYdN6VnVme7/lGHRFz9R6FFADPT+grsl6aCrSWR75CGr+yEw3e4AJWXJK
	nxN0LM+dwT+AwbrSB5CNR0DmV3uuGaSk/evWwLDYLeUnMVyyiS3r4JaJxR5BCXoRIcAD1nCp23Boj
	krenhV1Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xGhpg-0000000DtOI-3x7s;
	Tue, 13 Oct 2026 19:06:40 +0000
Received: from mgamail.intel.com ([192.198.163.13])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xGhpe-0000000DtNw-1wij
	for linux-nvme@lists.infradead.org;
	Tue, 13 Oct 2026 19:06:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791918399; x=1823454399;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=d4/1Lx1eGuGDZDXB0m5d/I+DU82MCpkQ/R0qhMBpkrU=;
  b=Nr0kwTIEZfHEt17FECxraSYSJoupOBG87vnrL9noGx1298EijeJp8WIf
   4HP4u48VGUtb9YCIyTn5sSAVA6LrxMubW3sQa+5llsffVYhz2w14vte+Y
   5zRLYVpXNbzVdnSV1cn/94pcHsJFlQKF1iQPo32Hpa6advjiTOLjNAMPC
   az6lHMvx9ThDlxbPxVtdaD/HKBthtSuc7VdwpfK7yEP9uZqkdit7dzVs9
   a6CU7TdA+X3qIp3rxJgagKjLQC34y9WvLzoUipJCKbw8mdDKGnJiD/6i2
   Oml02RXHsiaPyboX/+y8dox1yYsryJanHLXffeK+/coJ4f+1rzU9a7xms
   w==;
X-CSE-ConnectionGUID: WQg8h5LaRvCDaqmuQ5CPlA==
X-CSE-MsgGUID: STlX9EdYRYOYILmlFmBHZA==
X-IronPort-AV: E=McAfee;i="6800,10657,11934"; a="649341"
X-IronPort-AV: E=Sophos;i="6.27,156,1787036400"; 
   d="scan'208";a="649341"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2026 12:06:38 -0700
X-CSE-ConnectionGUID: 6yw13yvwSduh7szsN081Lw==
X-CSE-MsgGUID: kD9jp9eVSp2ZYMB52qLqJg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,156,1787036400"; 
   d="scan'208";a="1124972"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2026 12:06:37 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 13 Oct 2026 12:06:36 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Tue, 13 Oct 2026 12:06:36 -0700
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.13) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 13 Oct 2026 12:06:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rMCb3HIBWXR6m7SSMng8ErBRhkklGpG9VOR2koRTUIWi4grhbVmbWgOPJDon+HPj9PTWFebFAukQkpNms3OH2hpIxFX415U8pv5137T311J3o0f1xX53nFgQ307FcTqCCyTA3uPqQcs0dS8kQTKY9idNVg+FvOstBfYeKM39FD6cO9IRGyK2vTtqI8cGis7CBOFBOfrasGKcP10gDgPwqW0/m4MFBQm1BZCS2qOPys2M7LQpL3dQullR6S1maxRe/Cw7sVlrXBhtqwFn/4JO/0DcJWdrD/2Xgp5QYtp/piqUa9gTcXaBFhHdaLDPNW6SO1ktE5yrs4lUJclQwlSvlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jja6HWipXPBP0fhiYsOu2yvru9X1oRQqqueihYO+GBg=;
 b=bZVM6m4afGPpM7plj/8dg24kCPD58KUzpyq/WzPMQs4u0yc7sUlEy+HnltVpWCWjTaQpLwhcyBAdw0QupmEcb3JYshBg363WL1vD3AZm5FWL+qAqaT1mbNshbhWEmQYc7/0ouWjlJJdE0POihqDaujtmoCzATBjipAhoTKGAkdGWUOGYpCOC2DHif6k6e9ZLptYtuM97phjfR16ONTfNS0AZh+fN4WLR3ATM6N9bAqBPcVN28muLmNnZeMb+zJ7W9SM6BVUtu16UG7FhtcWJY9iuMtPC3xf7T7LD4GxFCxKhfpAG2qiHIthfEdpPAiLiTBG8p1j6ccjPpyrCs9TjfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4787.namprd11.prod.outlook.com (2603:10b6:303:95::23)
 by DSM1PF8C3EF9610.namprd11.prod.outlook.com (2603:10b6:f:fc02::149) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.23; Tue, 13 Oct
 2026 19:06:29 +0000
Received: from CO1PR11MB4787.namprd11.prod.outlook.com
 ([fe80::e7eb:a872:53d1:21fd]) by CO1PR11MB4787.namprd11.prod.outlook.com
 ([fe80::e7eb:a872:53d1:21fd%4]) with mapi id 15.21.0496.021; Tue, 13 Oct 2026
 19:06:29 +0000
Date: Tue, 13 Oct 2026 12:06:25 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: Christoph Hellwig <hch@lst.de>
CC: Jens Axboe <axboe@kernel.dk>, Pavel Begunkov <asml.silence@gmail.com>,
	<linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-media@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
	<linaro-mm-sig@lists.linaro.org>, <linux-nvme@lists.infradead.org>,
	<linux-fsdevel@vger.kernel.org>, <io-uring@vger.kernel.org>, Sumit Semwal
	<sumit.semwal@linaro.org>, Christian =?iso-8859-1?Q?K=F6nig?=
	<christian.koenig@amd.com>, Keith Busch <kbusch@kernel.org>, Sagi Grimberg
	<sagi@grimberg.me>, Alexander Viro <viro@zeniv.linux.org.uk>, "Christian
 Brauner" <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Andrew Morton
	<akpm@linux-foundation.org>, Nitesh Shetty <nj.shetty@samsung.com>, "Kanchan
 Joshi" <joshi.k@samsung.com>, Anuj Gupta <anuj20.g@samsung.com>, Tushar Gohad
	<tushar.gohad@intel.com>, William Power <william.power@intel.com>, "Alasdair
 Kergon" <agk@redhat.com>, Mike Snitzer <snitzer@kernel.org>, Mikulas Patocka
	<mpatocka@redhat.com>, Benjamin Marzinski <bmarzins@redhat.com>,
	<dm-devel@lists.linux.dev>
Subject: Re: [PATCH v9 00/13] Add dmabuf read/write via io_uring
Message-ID: <as6BMYAsWehHddlT@gsse-cloud1.jf.intel.com>
References: <cover.1791336930.git.asml.silence@gmail.com>
 <d00e43fa-8f5b-4a8b-8b83-421d637ba519@kernel.dk>
 <20261013141046.GA12680@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20261013141046.GA12680@lst.de>
X-ClientProxiedBy: BY3PR03CA0010.namprd03.prod.outlook.com
 (2603:10b6:a03:39a::15) To CO1PR11MB4787.namprd11.prod.outlook.com
 (2603:10b6:303:95::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4787:EE_|DSM1PF8C3EF9610:EE_
X-MS-Office365-Filtering-Correlation-Id: 56647bd8-061a-490c-7ea2-08df295d163b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|366016|7416014|1800799024|376014|22082099003|18002099003|10067099003|11063799006|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info: qqwDZgeIiVc9g9SsP43hyIzhr1kSRLE2mNymrSgxhdXx5p1yl3o5Ymwofd0w5fa0SSGW9wxr0LC7gB1315qmmKOViB+c3+lN/JsOTACLg70jGAx5cFZDGE1100SbSaQMWUAyHCwwXYz5njora4EVVCHEKuX8nn8qpe6hW/lXdhJhqbqZaB6vDfUAuV9PrEZaRXA0enVE2hnyZyZL/CY/SeMfnibYG7axYIBd4aJEDaJB/cnBTObMpik+oY2Zr1lXUkL2G6UN3a3ZPBf0fnNk48z6mPxoWnYYF77CgWWkWvFOXeJBHoPXSUFa9Zidtt9zQgse2L8kbUi22JCp4GMKAS14aK50gE/B7mIJtplljoC76X7ggT0ABd2oho+FnG/9bRH6OsoTLCyiLWcOUC4FC//pluXpgwmehE5GOj1dDE6zt7BjdMYpyCYQc+cjXvrWmpgd2aN7bdjGDOZR+tmq320IU7+ISKZ5R3V42bVFDF4FdP1DS5PSfFixUTzcx4kQP9+kanVzIKay7gseyeiVv4LUw8k0ksiNBxjZ2aVzVMmwWbt2R97ibjSwCY3Rm5RknuKMMrTqpydYP9KgYqO0Vym8Bq43NfCoX9OQKH7Xzg41Hwo9HRBTtlLpJ+92LiWWB8M3ntGzbtHnEMBhihSfkYgzaRwSXgPLkW03yZbLuOA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4787.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(7416014)(1800799024)(376014)(22082099003)(18002099003)(10067099003)(11063799006)(4143699003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?S2dKF0bnec4RZYO47h+M6LGfniXTVV19ARnScAPXLB/a+3GMMTy92iKO/vdm?=
 =?us-ascii?Q?adyjoxeVHHHJJpQp9FKx8/mHM8TCxJgOzhwl3uPwsJuNkb78ZMxwsIW3K20h?=
 =?us-ascii?Q?LFAHk8rc7zs0/6imPad5ohwH1Ckr+Ir3LjUO10qHbsVeHtHlm/QzB4ePmjcY?=
 =?us-ascii?Q?sFZctWEKGJUOs2sPTEgAIBwLYzd2QI2kGp97oJbbTtTwOVHA2R6JAukPBbNQ?=
 =?us-ascii?Q?oSJ+Vy0DgKdV8C5pob9fBtmNDQfueXrSOPxitfGXYwI0hV+bdTgk+Cwi+SaS?=
 =?us-ascii?Q?RatLr1+qIBFGOKDdwhwN5QD7GVvno0RsFbx1VYFh0tTqGRcJDFYoPtvEEyhj?=
 =?us-ascii?Q?9BE/Mx9nya0Z0H+bblcRO5Hc4PednhD+8hv2S2wrir0iEuPCxyBrrsYvtXRJ?=
 =?us-ascii?Q?KdTbdpEo50sVcw+CLo5vi4kNJ4iBE/3aAhQGaxcpIG0sdFVnSwr+Zu94gNwD?=
 =?us-ascii?Q?p5A7+RrSBQrgRmD66kuDY2Q8acpk/MlHz1eankNAElcel0MJPFbDatB8ZTjt?=
 =?us-ascii?Q?D0p67IqAjN0L0GWG7Ajrd2k+npDHIMwT5MnTxuRpWoqBHw6GYZw7yqBHRvXH?=
 =?us-ascii?Q?UKTc85sW4i5tgPBdn7vWuZAzxICeWughKXSoRowI7gBcKSx3+XWazIEGlgWc?=
 =?us-ascii?Q?slGzWmQH/srGaBk+00QIfOsjxmuYUaiSUmUeNLSdeUtvsRmhpnc5UlxjA9GW?=
 =?us-ascii?Q?7lLVeX9Ef+sdhHbwSFYE4dJx9yEpxqqDARkX2BL54favfo39IDxlGc9DqkLb?=
 =?us-ascii?Q?YnADhThVXScc378YHPnBWw1a28LL1h+E1+We2nCFZjXGDTiJkUJTrnq9qS6Q?=
 =?us-ascii?Q?r968R3mjpaUIiK9wh/q/zrt8HebRmfmHHKm6WyMUc7ofCpJTE2yI1l06AWrU?=
 =?us-ascii?Q?VyyVRmk6WC33gIqpG1eUzb/kC2IjDJx3QuwjdzYjGH9lTA0p7IOBTtf6ZcJB?=
 =?us-ascii?Q?7YItXwKq9PR0Ez1rJq0Kbs2EDFVZxJvwrC4i4Rvk93wKrnM5BfSdmDtMo2rS?=
 =?us-ascii?Q?Nv1h85EsRO/8fPAJ//nG3n4V16YIY4ymzbKcTM84lkl5HOdEKpVkpRpepRVG?=
 =?us-ascii?Q?oKEBbk65PtThHEr7gIsSitk6L+WMoTLhWMz3AEsEyOf7piXNzEl57wY68IGl?=
 =?us-ascii?Q?wdZIN3j//UKFe4IXpzcumlY9yeFdQeYRScoUo0gJ7uDvnD8BY9pn15+pEU5i?=
 =?us-ascii?Q?6YKVGJWxwni9HdrC2kaSPJtSKJpC7kzjubK63cVDNawJZUfP4KO8f+TDLIe4?=
 =?us-ascii?Q?Ie5Mz/Bek8vwodDHERO7MjQiaHDZMC+V5IsMuJ5lz1hiecJxlsIJDXlyGEjT?=
 =?us-ascii?Q?2T5r4wH1E0rqFUsRQM9G5lhb54WAZ5NJG/3PCoQiUiEk4gtV7W+4iCWVTdrT?=
 =?us-ascii?Q?1kSJOB3aIAhpzZx7L3WuTQeuFwjPvYLBlPISwj6GHUCMHdTMYZWMwqRp7HPx?=
 =?us-ascii?Q?AaAipiM9W/f7Ym9BhflyTfcnde3O2MxSLgQk4ox4CJkuGnuhF/5DInPJxU3B?=
 =?us-ascii?Q?wCK+2WjxB8ADs+4DOZwAzjetF7cLN1iCwnKML876vcg3XrdV83LK3UuFi1ve?=
 =?us-ascii?Q?co5q+gIFgtM3uICT6rRh306g2Z9YKMoZIteVmYniNRJbcHArtugdXzI7n+88?=
 =?us-ascii?Q?RUAV6b0d40W6hlK7fPcovoDXxPvm5BzeWaEfuO4Lklt5TX4rga0rGUT3Bafl?=
 =?us-ascii?Q?cAaH9b6svyp7n2X+Sm/rOu9kyFbHMxuEED0ZUyHNWk4AgHzKt0J1eN80C9BA?=
 =?us-ascii?Q?34sH5NCNlwAKvWwQKyTVtCLAO0IsFSw=3D?=
X-Exchange-RoutingPolicyChecked: Ya9Firv3YwGFwSeAEodzRpxhpJgJeSiprl1YhS3YPUebryalyecHujibxgr61x1FI4IHekbMDjWsF+CmSKPP92zBCuJOXU/vpcMM4L5kbL/mO8kBgUQoIi52O0GbxtHKAkdrdXFe5BKrkpxmAtG1H4tGmXf7HUdkuY8AomgqfKjdfVGIF+ugygr8qvNzYLjtRV1a2J1J78+5nXVyzgisxQNlVwzbOcOOpDlIfDbTDok8nL0bsuVCvEava9iDLcuq5U5f0ZbvoSZgsTpzbGDZbt/AvL6T4GH0D2cD6G2Z4gEc9YHwwvtv7djnBpdHKGrH4SLTTwBvMy3HN4rPZxzBqQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 56647bd8-061a-490c-7ea2-08df295d163b
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4787.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2026 19:06:29.3613
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: izwiXrI+wBgmIsoVCk35cC30f2+GIIvXvZ6TK2Ah7/BTpyV8PdzXm0shd/Y21Wyc6j9Duu1LuYPZWelt9Gm8MA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSM1PF8C3EF9610
X-OriginatorOrg: intel.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261013_120638_525179_1C022531 
X-CRM114-Status: GOOD (  17.87  )
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

On Tue, Oct 13, 2026 at 04:10:47PM +0200, Christoph Hellwig wrote:
> On Mon, Oct 12, 2026 at 02:21:41PM -0600, Jens Axboe wrote:
> > I've queued this series up for some testing, in a separate branch. JFYI.
> 
> More testing it obviously good.  I've been waiting for addressing
> of the Sashiko comments on the nvme patches before doing more ACKs,
> and while I can't really judge the code those in the dma-buf code
> also look somewhat serious.  So it would be useful to get them addressed
> and the series reposted.  Same for folding in the PI vs dmabuf fix
> from Anuj, although making the combination work would of course be
> even better.
>

Oops, I forgot to look at Sashiko's feedback when I acked the dma-buf
patch. I think the two cleanup issues are valid, but the reclaim-related
ones are not. I'm not sure why Sashiko is confused here.

I wonder if there are some shrinkers in the tree that incorrectly take
dma-resv locks in a blocking manner. They should only use trylocks in
shrinkers and direct reclaim paths.

Matt

