Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A02B4606A325
	for <linux-nvme@archiver.kernel.org>; Wed, 18 Nov 2026 11:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=AGdfbd9q;
	dkim=pass (2048-bit key, unprotected) header.d=wdc.com header.i=@wdc.com header.a=rsa-sha256 header.s=dkim.wdc.com header.b=eoZyviyJ;
	dkim=pass (1024-bit key, unprotected) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-sharedspace-onmicrosoft-com header.b=wIMBOAnF
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:
	Content-Type:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=BohHhXvZbrZy0ztxuhYuHZxLoMO5OrBjQwu+LIwOp38=; b=AGdfbd9qZlJGhfNJkjzmVcZmjZ
	bWVYV7zBLrLwdJAwR5Si5EUEVT9xBkXLGFtTspiR20x5QhDpkNhnw+3KoU58AX+Zo/aF74WIMQjdb
	3lR6d2Rprj76mk7qGUMWs3CVQQLgdbftgW8Lu8L2F2p30PwWUs7BuwF/m7tOq89Onnz56ey7Cw40H
	nsHnn8guESov4H5EPHKwmwdnGXhTnUPIjOxNVn+FW/ZM+OHmCqUYgmkWH6ezjLiubY1CAPT87riAY
	yNh59SYCyws8xEHzHQu8zMMhh2MTrzyva7FAASOsJz9UEpOuXe9xYLx5qQNIYzPZXLM4RLhHWM0z5
	8wDVuDVQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xTeEH-00000008lPQ-08Ty;
	Wed, 18 Nov 2026 11:53:33 +0000
Received: from esa3.hgst.iphmx.com ([216.71.153.141])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xTeEE-00000008lOg-2jGT
	for linux-nvme@lists.infradead.org;
	Wed, 18 Nov 2026 11:53:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1795002810; x=1826538810;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=05CRe0E4J//N/LFToZTBKY7xe6ukmOY8NuwuhbvuIfY=;
  b=eoZyviyJCONIINglIsNaWOO76Cpqsk9H8B3CHUrhNlwS97fwGkwGL9YJ
   x/TlEnVAEL/lmWZIZ/yCcW/1JNIvPO2nrVD2Inu9mFcSfzoDSlLUUocmL
   ITWpIET4YyghK3UL7NYyyc8laykRxRsKK8Ue1jAIc+NdcENJkvAXHQAsx
   EiOW9bPHcKdaMrwUK08oQKpwI8Eap3g/eJ2ApKSx0ENUP3KBeqcho6Zf4
   qLycxJqIKofoJg+zwFhmf0//gjzeKI7aYcSmR8JYtj98+xvb2ZRUPeBSA
   yVvOd+XroGciEFo96eMAbVPlCXYbOy6/qJbkoLI2nmGY8WuxKMKeM58ST
   g==;
X-CSE-ConnectionGUID: D0HF3AjAR8KGAkazUyBw3g==
X-CSE-MsgGUID: r59GAkkCSMi7birh9SgP9g==
X-IronPort-AV: E=Sophos;i="6.27,219,1786982400"; 
   d="scan'208";a="161190229"
Received: from mail-westus3azon11010054.outbound.protection.outlook.com (HELO PH7PR06CU001.outbound.protection.outlook.com) ([52.101.201.54])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 18 Nov 2026 19:53:30 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IfaXFPjyS7I9d/+gY4tAdMG7UjxGyZDYRJKEykenhoswgnRj7ftRoMJH17KwFPkF4iuaz9k8dU2NFI3GtXllWKRD5+qu07ZnyV6wg3pHlC3WzHc7jzdsUThcN4NwsvglOVWgpH8orHZtcAsi3vK4GZpxJLb9Zer17QOXxqkXbnqk9GIgcB8mGRonx1ny1q/7zdqd3YUfWTYZkt0W72dRvab1z+IH6Opr/QcKlxBqv2JfMhStk6gLi+TgRPyeTyMEltqEvl0Hh9PEZFx5LPHJKWlfSBQzIVXfzaP1WgRAR+ZXRIJjSn23zqM8FvPbALAA/c605dv3iw+CvpzGfwGyrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BohHhXvZbrZy0ztxuhYuHZxLoMO5OrBjQwu+LIwOp38=;
 b=PDshf6QP2imsE4q3KqtrbIjw+lf2DDQPHNcLD8nAWpP0k/8kRTDCgFQn8ewJif9dasPQZqbtz9l6fDGK/3WWxe7O7Ad44PeW7ng/YEJ1nrqfrlGXqglP4O613glepKvNEJ2cff++7a8MlRWBDGeI//u8uY3D5MJ4tmLgG8bO9NS3v7b/WAO0KO+0Hr6HiYXMUHnn/aK5MejP9t33luupUJoewjv61dngbZxxbTymVWheYpk1AixK2ANVJzQUgjdGsgoluyJsXCPFKJD8tmQM7hT9roK/ns6/lCA2stYBtl+is8bmE8kUExn87K3D8vRNTczeNVnrTEDKsaTXlvtEVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BohHhXvZbrZy0ztxuhYuHZxLoMO5OrBjQwu+LIwOp38=;
 b=wIMBOAnFhJm9TtlkqDRTFFoyeijR0mT/jCEEaOfcnyRpnSftTe/QERcQLXhs2XY3gg2kuztzyzmey+w8K5/qGsj3TLNRR1cLlzTwTccGCvMZ5+gMEQl68HtH5qPPxX4NZ2eWm4ynlzGmB5fszWMF9AfuS6zL3vkJPYRH9Vj2Yhg=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
Received: from SA1PR04MB10065.namprd04.prod.outlook.com
 (2603:10b6:806:4dd::14) by SA0PR04MB7193.namprd04.prod.outlook.com
 (2603:10b6:806:e0::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Wed, 18 Nov
 2026 11:53:28 +0000
Received: from SA1PR04MB10065.namprd04.prod.outlook.com
 ([fe80::9b98:bf8a:b0b1:ef85]) by SA1PR04MB10065.namprd04.prod.outlook.com
 ([fe80::9b98:bf8a:b0b1:ef85%5]) with mapi id 15.21.0615.013; Wed, 18 Nov 2026
 11:53:28 +0000
Date: Wed, 18 Nov 2026 20:53:21 +0900
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: sashiko-reviews@lists.linux.dev
Cc: linux-rdma@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: [PATCH v2] RDMA/cma: Use a separate lockdep class for the
 listening cm_id
Message-ID: <av2QarZ0_u32MHzM@shinmob>
References: <20261117113129.746490-1-shinichiro.kawasaki@wdc.com>
 <sashiko-outbox-218731@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <sashiko-outbox-218731@kernel.org>
X-ClientProxiedBy: TYCPR01CA0167.jpnprd01.prod.outlook.com
 (2603:1096:400:2b2::7) To SA1PR04MB10065.namprd04.prod.outlook.com
 (2603:10b6:806:4dd::14)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR04MB10065:EE_|SA0PR04MB7193:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ec865ac-48cd-4151-f5dc-08df456a8f0f
WDCIPOUTBOUND: EOP-TRUE
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|19092799006|23010399003|376014|366016|18002099003|22082099003|11063799006|4143699003|56012099006|261026121527099003|261028144727099003|261026140227099003|261022105027099003|10067099003;
X-Microsoft-Antispam-Message-Info: rVIKR81ALfXgB8zYyJQ260IoqBMvwBI9Vcrm9OqeSj0ooWMdTIgNTY572Olzj3qTtatPR5RpXh0aMIgdpI6rW7g8QXPe8tP28y7WETOUVHScddCLQf7t7KZuZPo89qpAFI8m9aDUh8SUOyRLogwuaX5NKqZk24uU2frpDHmH3298p0/ucWlmWnHKhKi4rnk7wSme+Lc7AK8HkMv9fCh9qfoE8P3beZPX2lnpm7b0Xv+hHRetnAnICuOqp5JY8WzexZ+6OzuuQJAHNpgnbMDOd2dh4poVasLQI+3ZLP0C+qFYyNnuFl2yUs7ThIvgHXV2URYa1+T6j4XIiR5u3DOMQkDFjG1ICCFZNisCkiWhmjPrLBUWye4H3nVD44HK+o5gQJJuEs8sbxgCZz+BxRRokzCx8LdQunrNuR0jIGBaQCmsgMySPKUoxqNaKMytUcOL+qyc0LZHp8tWiGXp2C1wQ09HVkU8Km5h7exldvYOycpJdbZcrAF+TEG/kW3Vq3fLE7mmTK2cF/8WU2bUSQpTYdAq07cXjtZt0SSE8HM0xBr3WajuQT8QzjuEuxJamvVd8IaPTKMf6NfSoHCWRolWBYEOOqA6U6dkbh3mwVgPnkbGby9cJVeKCAPg82mr7TcAPipa1akXDVBWupLI4+rTADPmSLTdOxFQunsFtMp4lBo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR04MB10065.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(19092799006)(23010399003)(376014)(366016)(18002099003)(22082099003)(11063799006)(4143699003)(56012099006)(261026121527099003)(261028144727099003)(261026140227099003)(261022105027099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?XdAlWUsvYROXmPX+bUIzuj0ZT+fBdNrN39Po5z5kuHTqS1KPrCTPt1Nwrajn?=
 =?us-ascii?Q?EzLWNQOgOySMyRH730dnPxZ2FeWNMUsCOp3gAa9IcsD5SX2h92oBG0rbnMys?=
 =?us-ascii?Q?prNcHLvbwYVgmjyy6mAnUf3brECC7TzpLcV2bNXAa2D4k6c6tRNhP50lMtDJ?=
 =?us-ascii?Q?qkXDG40MwpuFxeIwQVTbFUyRCX4RPizwoz8JDcClkG3Z4Hv6AvHDemWLUksi?=
 =?us-ascii?Q?65wywdMqDl80lcKhycuBk6wED0R/UCyT9Rn3H6cywUrc9TLwNIVzEzJE/97P?=
 =?us-ascii?Q?dc3UCyPZDuNXBpYsZ8S5tJXI2PkiX6ntGLmuLM7iuJRFJbQmeuTyIc61LKaJ?=
 =?us-ascii?Q?mL4h2ptc6uRcmOgC6+tl9Tjwwxe4IeSNn4ij7jlFW06L+f0bN386aFWxWKnp?=
 =?us-ascii?Q?fnWvNyYl/U4gbyspyJvwf0Ch8/IgxAm6ca2SPkhquiJFQvipmoA36WT2WFGE?=
 =?us-ascii?Q?OjOPfiWJ5yLuQcVmdSB5blxizhDW4flCB9fIH3m/M/UKkoCaCnBCARUmwq1p?=
 =?us-ascii?Q?N39gur2Bgq36kv0rKyXZ/ovPpaqet+DHQvQWyLp3iycepbhjMCjgJhVEPzTe?=
 =?us-ascii?Q?L2/XVeS9gLZpnrVjqFzlpQQBP+fFdJjwmNNgYTdikst50aOQ5Mv0so9uA8o+?=
 =?us-ascii?Q?7XEw1S/me4NWCp05wU1/em8zueJdphWr0TtgQYPf5yDaFj65SLY8Lq2Uxr+w?=
 =?us-ascii?Q?NT2AtdqocgzQGIPoP04PaSiStBmdmhmX8ITKvyhI0OQfDblTGYlJ8HaT5IWC?=
 =?us-ascii?Q?5Ntz9XkWtPpsOXHWZNtOqWrhZ428XHgHzRq/3Xlw7tt7q/F6VpF7bOaKRptj?=
 =?us-ascii?Q?KGJUS+hvAyzbbQurndVv/sLXdKhaPeZc/pII8yFJpodYGRpxJiTrA1zILbqG?=
 =?us-ascii?Q?CbhEK3tz87hym9MDcBQrGfdmDuSKAFtX7qIu32uq8o/giF33GmTFMI0AbV7e?=
 =?us-ascii?Q?BJlmxdFjjNy4Zlb7l9TJVYF5xu21DnI9+i+KlgC3gKHL+yk/611taTyRRs8C?=
 =?us-ascii?Q?ohPx2J+5RweP/Cl0OiutKdnwTnEP6KECB+EDX0oXfP7pMdRAx/9Cm+a1NTnV?=
 =?us-ascii?Q?vScvqN6FS9T9Rq8S8Dsi5MgW96VWJIM1r2e6e7iNq2kq5N5UxtDXlH5WPlxI?=
 =?us-ascii?Q?Jo79VvXItfHR24yr4ZTBfykNHZEDJoNtLat/CXeqU3vzCspFx4hl9nxIC5sl?=
 =?us-ascii?Q?a/LoiEEpc+EWVVURYO91SniwSdXAtTfpYNqVF/3HRWtPGW04rRnDl8NgnpqB?=
 =?us-ascii?Q?KvFBBRGIgJoPxmGga3JcrWBkc5UOd6IS7OjKH909jmNNhr9KMXm8LA0Q1gI3?=
 =?us-ascii?Q?3iWdtwXK+mk3ZYR5WvrMVtktGp6JcGGCl06umGuZd8iP2qeQK4WZy+P6GBJs?=
 =?us-ascii?Q?L7kz4z6RADtF5aC3ST7ICVmySSIxnX2x4yK5JkkUctwa2jivvxFCDvtW1egG?=
 =?us-ascii?Q?l1/+Zm9wwoQGmbvmurWSHiFuHXzgu592X7ll7TEH/T3QmW2sZmpnNpAjaBtU?=
 =?us-ascii?Q?8jlG+if1uwPGobpPeK6oq2lqqmdFhGLjbQrWHDrgAu1HMRteZy+N3KuF0+Px?=
 =?us-ascii?Q?JKfRONcUkBJBNgFWQv5FwBM62qPKQH/A8mGzD/sMmHT4ZGqy9Rr4XpfOT3fI?=
 =?us-ascii?Q?hxh4YuXmad+0gEvjt07zpUQiFIkcGC8yeKvXZonC2rcBNJSQVA0GwTnsQvFc?=
 =?us-ascii?Q?sQhkqQ0hxxbzp8p4vffbXWl8aroQJyLHXzkPApWROA91aaPjL/RdRivXT0lF?=
 =?us-ascii?Q?f8QHG+wZamCDK4BTUwQiVM9prJVCeeA=3D?=
X-Exchange-RoutingPolicyChecked: d4ekeOxGxcluKZV9u5g2ce0c/pjVm8ngDH3/7iLj7h5HKfp29sunBzrF7ercF+cDIj11l2fJF85hhNOhqspZsP/tFBaeSRASEpTaGV3aGo3oje6Mw8zxLl0bJ+KDIl132l4ETcUx0gGaFsi+erikLjNW4halMKPyi5qQqhuitNQrMvx1IS5AKqfFjXTQwAamms2vXZnSqHS9OM3tvu0I2usMdS0gi9uaWzpuAUzvP5NZpnDRkJdhDLXKDkqVbclsoWH4f1KLqqHUyx/lKEmkICDm2S3lSfV0mK0GqiJGxlmwvRlht+Mp32L1YPoPJ2bIoCZFSD4zrBydx40+95efIg==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: QOHyn7HUj6caKLkfZ+WVeyFohGHp5AlfbKxPnpUQd5qhSC9+zFA8CjkdwlE612tyeqxFW5DYMbXyuNPi6BXC7UyA/tXuKy4DBuMLaji3WpVcHyHUkRakZw+x5BZEkp4pG5iJcfhTjlDVRMzasZwJCtQwsbWzwKbtv+9VGII+Txds7CeZlvaaSVtvubdoqhGPJqTwgMwvB91dhS0vbtyriOnbE9n4SOlXAb/zwxK8r53CPxz5chQtDylemu/neo0QZi/8C+vPGvT7cDXbPXNt40J2M0lSIOd5vjhJIJYj7I7mn43K9E6j2+rAL5Xu+dNv8wxeTgkktIlzvzh430Lw13Si685RDqQgd6vGlN4ttfTfoW5OLceoiMl7kYVPIq8Em45cGIBE+x0MzmbubdebyRuKdKPzdr+VnsdUAAE5JSiS22sNE14r+XWmPewe6UxHGjDLfPaEARU/GWsj3SZs+b/uZgERyxcFrkB1wx4RjOi8lzKFRFL8LbH+p4sWqpZC9pU8plY4qVi2aA/xi8pHejlty6JmRHgKEXJJDtfOCMXsb4qUWBY4bRUwVuPkOQHNmRdYBQzmtPgj6VLtT1PXV9Yy+GsQgFYCEfFjkVI8BfGz/fQq1Ol7CTHCH6albQ8V
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ec865ac-48cd-4151-f5dc-08df456a8f0f
X-MS-Exchange-CrossTenant-AuthSource: SA1PR04MB10065.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2026 11:53:28.0156
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OJeynG3NqGDp06AS4aQsuGn3myCfB2HcVOis9GkttJtbqm/eENzpO2+jULSS4iOrYKRaYU694+UpWSP+4M3LNLksZ2M4mEHT7ciapvQEaxQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR04MB7193
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261118_035330_722364_60A31F34 
X-CRM114-Status: GOOD (  13.00  )
X-Spam-Score: -4.4 (----)
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Nov 17, 2026 / 11:48, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential
> issues to consider:
> - [Medium] RDMA/cma: unsafe lockdep_set_class() placement in
>   rdma_listen()
> - [Low] RDMA/cma: unreclassified handler_mutex on
>   nvmet_rdma_enable_port() error

I think the two issues are valid. The first one means that the approach
to reclassify ids in rdma_listen() does not work well. I will think about other
solutions. One idea is to go back to the solutions to add a new function to
create rdma id. The other idea is to reclassify the rdma ids not for
listening. I will try if these approach can address the sashiko issues.

