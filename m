Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D65A606A31C
	for <linux-nvme@archiver.kernel.org>; Fri, 27 Nov 2026 01:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=qq1Ei4Oc;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.a=rsa-sha256 header.s=dkim.wdc.com header.b=gKGSV1hb;
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-sharedspace-onmicrosoft-com header.b=GyP/A5D2
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:
	Content-Type:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=FSMnsAOpfOFradSsRBZnncEDqKigAN9sdnNLlNTbgHg=; b=qq1Ei4OcqJjYWZZj8IrAQy8VjW
	Ga9jVUvYB4A5E8h+0YzUyMfi+B0dxZmyJHrtb81u+ECfXUjIGx/bdTofIxLLLYoTZlQox2KzC4AGQ
	L9qTJHNI1DaxiwwIAJw0G8WshzOYBmGlEif0L0TbPtMGDhVI9FQr4CZBeo+FGVpsnMtwzAnO5iBdn
	5eTqVyJO3W1ezjqXQClJWzqDqgJqv3dUw//+ZM7AyMqdI2kFHUo/19Lxp+7H03VwLRmmCNrsbUE9t
	XmOqGZPE/9UlcaLhunfdB0hOCpvatBupB5fiRxtBFF0PTFEKctq6OMPIrvIWgQCEGxCuDfVFApalS
	p8M8fb1A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xWkLF-0000000EiGU-2GBj;
	Fri, 27 Nov 2026 01:01:33 +0000
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xWkLC-0000000EiG6-1V7K
	for linux-nvme@lists.infradead.org;
	Fri, 27 Nov 2026 01:01:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1795741298; x=1827277298;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=LNMTEulgZyz/7cJP4wfz+r+LNiWUDq7mv23/zvIZ4MQ=;
  b=gKGSV1hbLxxabXOThBUqz1vrjpxzSm8hINmHBhhV9r1GMTFi1C0UXIUs
   Y1OcStTJ/yofcU9qbWpIgmoR+gD4cys0GIezD2P8Pl/medfZJoP8anWI0
   1G54sU1tadpkf8qNrdGjzr4REUFNtG0nUW7M92JxrXCHsv229t9Bp3YME
   GY7ISmxwnc7xsT7+bmvjFAe7NRAjRe+oQt3xybtRGKYa1DIQNLqU+Pqza
   H38hfxQF7a7rwAMGbmbVXLL1AYZKnW95YeJ/iU6kVxKv9MHUygSYeRrQj
   HLfHntDb70gGY5C92i0a0HCTOE498aoRHmihu2Pzvyq/ZUjYZ/Ls5qYHk
   A==;
X-CSE-ConnectionGUID: mfdSlzRqQK646OsrGah7pw==
X-CSE-MsgGUID: Q2GlEl7aSVeXCCzmZescMw==
X-IronPort-AV: E=Sophos;i="6.27,235,1786982400"; 
   d="scan'208";a="157620811"
Received: from mail-eastus2azon11011062.outbound.protection.outlook.com (HELO BN8PR05CU002.outbound.protection.outlook.com) ([52.101.57.62])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 27 Nov 2026 09:01:32 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L3jyz+dWFkvnMwopKT4bTHBP56x+o+Klcl/pVF+rzC9H8BakaTvyQdaPgZ0a0hCoIIGHpHtle8uU3RNtD00oOnLI+hFicKwIqazq/g+WeobO6wfrSrTTa1uFPUlxfQqyWewE7QAsTzEgo1oLK9JB1s2I5+bNKd9WjrURSmJFA+IOqoXwmjnuHkhpMcL85bOZSi9mogzBxTzXbF5oZwaIfjluPI2kg+VhldthUFcAnWHgY3BfSYgd8DVbdIt5jrpA77exzwSWT4CNzCMdtrxE8XemIyggHhJkGVnhcpqyywLc1x6dgJHbQ4J2y/vLyAmFCERhQyzU8aO3ul6U8Efz/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FSMnsAOpfOFradSsRBZnncEDqKigAN9sdnNLlNTbgHg=;
 b=U1AIT6ekDd1ZeM4cs/PxF9/P8z+ldl1auTIHF805k225Mq+c3pzVaGFMNRcbRDtmoaY/0j9bCsMMCyfVtiNIRKoMXypS2hDPlpTExWF2KeYkrNGUQF0JIwnthHsIaCpbrX1s1M6NTIyuyW5tBvJVjqGoSbdKFQxIsFwbQ0KmpLzopzMc4jV6opGEcpwS6hkMnKk9XQL8YLk10FSGLYXP7nGjj/jtVzgRMWjilNq/73DaPItckGbzFDkM3yFo7P1JXP8h39gRJJyNDkwWtZ82MHivUgJBJRkEBQz0Lsz+d2WB+taJqvC63aaG0VgSfPaoU/I7ZI6Wfd7uAj6HByYucQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FSMnsAOpfOFradSsRBZnncEDqKigAN9sdnNLlNTbgHg=;
 b=GyP/A5D2I8008RtwFwI2Hc9TPfx0hxovjBQBAdCAyPYKMEdzcS9rrcwnn+69PQ1NSEjVqnqu+SbveEOgLsqQUAi7sVAMxSv1thJT/vwdJbGtZcPzPkkDS+cWYbbg5a6pUBG0gXtoRYR+lWIhg66cTE4B4abM3oGbkcb4fXkgiRA=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
Received: from SA1PR04MB10065.namprd04.prod.outlook.com
 (2603:10b6:806:4dd::14) by DS0PR04MB993676.namprd04.prod.outlook.com
 (2603:10b6:8:435::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.9; Fri, 27 Nov
 2026 01:01:21 +0000
Received: from SA1PR04MB10065.namprd04.prod.outlook.com
 ([fe80::9b98:bf8a:b0b1:ef85]) by SA1PR04MB10065.namprd04.prod.outlook.com
 ([fe80::9b98:bf8a:b0b1:ef85%5]) with mapi id 15.21.0662.004; Fri, 27 Nov 2026
 01:01:21 +0000
Date: Fri, 27 Nov 2026 10:01:15 +0900
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Ankit Gupta <ankit6791@gmail.com>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, 
	hch@lst.de
Subject: Re: [PATCH blktests] nvme/080: test write zeroes larger than 65536
 logical blocks
Message-ID: <awjWDMoB2FEYMV40@shinmob>
References: <20261117052741.25471-1-ankit6791@gmail.com>
 <awD6iLYWPuEgEi1C@shinmob>
 <CA+OH82huu6zL_ZpwZs1AO7Pvadig1kDeZzpLZ55woU+2YfD3MA@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+OH82huu6zL_ZpwZs1AO7Pvadig1kDeZzpLZ55woU+2YfD3MA@mail.gmail.com>
X-ClientProxiedBy: TYCP286CA0034.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:29d::11) To SA1PR04MB10065.namprd04.prod.outlook.com
 (2603:10b6:806:4dd::14)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR04MB10065:EE_|DS0PR04MB993676:EE_
X-MS-Office365-Filtering-Correlation-Id: 89168160-b005-4cee-f5bd-08df4c21f393
WDCIPOUTBOUND: EOP-TRUE
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|23010399003|19092799006|10067099003|56012099006|11063799006|22082099003|18002099003|4143699003;
X-Microsoft-Antispam-Message-Info: M27ccIGWlLhXtlmFyDfpO68V3JIDEAuKFiXMqWFH4lu2jZmxXyBj6citvZOEaT/7bWZUKEhM2cN5914bilPSH+qO70BfHG50r9kNmjbs3udg39XQGtdz5YegRLqM9pahWqZrvsJi4xQueNkbZlk+Epitk2de55umEMS3SnrNYT6S33KKoL0ArFWZH535tFLXW1tItkLJlW0lZYJks+NYJXXQRkpFndxtzhHrq2HEU8UzoAoTsA1iADoRDXXhfzoTYqEUh5osdIiN3EbEIZurh2QYcRGMwx1AFUgyYnCpliMO8ZRYleUMXGKBvKv+zLxs73sjpL2K3YycstEN8xea31PDfLXg3eHz2TSL7W/uchr8twDdkNR6Hov3hrWlGM34e1X0GTcsFtA/akLNo2ZwzoYS58PXkTyz3FIJQsb+HXJRuzinYQIjlQwkeKwRmmkTRqbJ0S5jLIcSrakErauO1HXotjHuB1Gz+ZgmIpber5qvbZFlN/CyPxC1n7YDOQ/kEFzEnWRE1CPT77/ouXGUdtcp31xUJOaBrXTQCARqWLmTRhJ86Cmu6HoMGMdVG5OijFC/HcmEKEgNtxqJhj3otyxKGTuWhc+iATJB0NNieNcF5IIlDIl0TjgeWuayyqD/HyGwAwYyGohvCQZZBF+a6T/90M0t7allwnw1IH96LKc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR04MB10065.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(19092799006)(10067099003)(56012099006)(11063799006)(22082099003)(18002099003)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?EFjyCtVxJnljPqzucKKluWzuUhN5rnuTlYr64MaPWJKhEYe/lud+5INFaVbn?=
 =?us-ascii?Q?jJpdq9xhHOLHYRmQQhSXvORTugMG03We4B9U5+EB9HwvfbmTTuOcbiuwO07r?=
 =?us-ascii?Q?Lr9ec+uwNl/ExOZi82b7BXTO/HqC84407/A6U/04CiMFNqchcxfAbRlVpN4V?=
 =?us-ascii?Q?hgUY4ve14eFM/Gai15O7+rFxEKGX5bcPix91WvrBTLE+MD6wNdqT305K1+ac?=
 =?us-ascii?Q?KFrUFaLtgKyK0JcaN7o8+GktRfVxM7nyRkju64EG6ajhy3HzMQvrKdP/jB2U?=
 =?us-ascii?Q?LRL+OcAbiuHV2/s8yiWNTQAMKwxI2xPlKWYWxuH+xKk38D738O7GXpC5Lwec?=
 =?us-ascii?Q?+YU48w8Diu0s3s8QNX2V8uQzrfw5h4H+yvM1eTcVYzyJwXPoFP8MBV8m53Mv?=
 =?us-ascii?Q?p8pJmtwTHjkf5toD8abwx8KEdzaftzQeM144wSKqPhkYZA2fZpL5C4kIWczd?=
 =?us-ascii?Q?HuOURapFpI3ZmKsj24toX8dHJ9VShwwo7bZflmEy8bDC06Rj/Bvz9hsACu9h?=
 =?us-ascii?Q?GV2qGbvmHEeo0+Dh07hytwXx7ZYfded6Qr7jVAuczz2oYs/mKUCM4XwfKxaX?=
 =?us-ascii?Q?eZfI17d1SxfbeOx1V8aNqjZjPQHtDcttHBojyloORq+4SAJ/TY+owCDTdR/Y?=
 =?us-ascii?Q?9kC1fv5jgIsiIplvzxl01ljc0kJem+AQVVTMKFOqWl4TzlUkNAbgw/3IbKJS?=
 =?us-ascii?Q?nb4wWp+qhWcos6DL0fPAOZ5+txLnfcrKJdCX/elVmo5L0douQhiWOSVpy+py?=
 =?us-ascii?Q?Crzb5bdLbtKI1FpFBIGlkk8bVuZ1tHT6cLuhTE/yl+xu1uWJ09tHLlnchmta?=
 =?us-ascii?Q?cN/9NTm0kLrPI1y+ZWQ6/kzIZ/63e/bjo3bDdu/FbUbmbwVrTC0oAmKccOlt?=
 =?us-ascii?Q?DsyyA/thKuQHUni3dKdi/WYC7f00JdNe4gxECYpuuTd+XHmTs5GnglCmwnA5?=
 =?us-ascii?Q?n6Q9vwv1NjUexY/DnKHWS66IegugtxuIWP3jsjdBpDYP46jxvZU/JgK4pltk?=
 =?us-ascii?Q?c/NgUwF40g800wNWyYwrb1zjlSP6idODGXZweZohbulG0ektYBHbW1XMS/vT?=
 =?us-ascii?Q?zN/tsbj9OsELVeAAo4/15ASxEROPmY9LVFjionv24uEfHCEOm1h4JvwiI0zs?=
 =?us-ascii?Q?oA8tDbFlPrhqJ30mmvswokOGZhTjnUFcV5IN5dJ1DJJRv95pitF7NMGFP3x9?=
 =?us-ascii?Q?CoBkZPOKrGMMptgZbeSvf8s7URsZ1ubyirDckCUoEERRF4RQPFdArIWA3G9u?=
 =?us-ascii?Q?4G9B9h5G6U8dhhCA5u5a0EdlQ45ozFD50iutTC5eSXGEfGnZAp29JTjRSw40?=
 =?us-ascii?Q?bfE0QepU1Q/ycav/ZGZm/u96Z+xfRk/zn3cB4Gr36/FyKn/1ChgcPyFSvWp7?=
 =?us-ascii?Q?5BEAqHLt4Pu1bF3rjA4eLHyU7EQO6jnqjb4YyzSiPdjAeeaakOKQIWDPTjaH?=
 =?us-ascii?Q?axvf9SjEe3nZOHQj4iJ2L7Li8niCOkrmRNI2YtHa7OPU8ukY0DkOgLcyNmn8?=
 =?us-ascii?Q?kk2UynGVljNwxipHQzF3gyOKleKwuTDxQQeZ+KmUlikwWslFCzSthgdDCkEV?=
 =?us-ascii?Q?FpJUU9iF0a8rvRdjA55DNjQWVRv4/+cqIP21a3rY+pI2rZgUdYzW5wM55B+B?=
 =?us-ascii?Q?OUfAb0dOsxbKzzYANNXzU80ACZKzRS4rO/+0Cbd4OHxUchVODRcbeWOiebh/?=
 =?us-ascii?Q?EVaHV3pRu8DK3oCjNIq+pjuJurcro9BdPaT5WPrR6SV0WdXBw3vnGxAVREtI?=
 =?us-ascii?Q?gMwT3FMFpYSOP0ToZyXkUJJOq3qC4jo=3D?=
X-Exchange-RoutingPolicyChecked: ePtiMo12JeSgXMMGP+D2fIIl6CglqK/YbSm4fo+10gi9vtXRjxbBo0C2Xcn9+qGClrzMD1vXY57Qcy+/ZrC8vOS8o7rQ8iaYMrqgFCv/eMvmXbrjpvGAoqDa86mbn3AG/V1A2lPBfvoKaJOmgmZ2oqb8T3k7fQhl299xX4s0Nhx7RW5V7zNbCE88qDfcqis1S6emtgJyYqcX8jeOlvO2VPvx8Vq0P8yewgio+AUJQSNgWsazmdkheIizMlb7SEEjDBXQiL5ux31ra2x8icFuhGPjFnQLPptZj3o4Ykiuc6I/e3GJAMBlpfCbLt6Qwy8eHxYiTDEO9CDFxcv+sd7fGg==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: tAnIOVpSXk+i9MPe9SvAmMyZGCfJsxFLIRrh6zuS6eVBxfYC3YvcT/SuK8TcVdkALVkvK0d13NezaucPmfa0a0YabSzS2tJCn4SPJk8wKYl6nvafQMhui1Fy82P+DvWh46nYKjJLkg3csKDwnR+ut+pELJmfc4qFtW0UORH+MSyBUKQ/sL4jo3tSF07e2DriESfvXADCOPIoS10Wp0lX4zWcpBumI1sHwaM2l7iE/KJ4psIFjgGsjXmeSX7ZHKbejhqWakN0+CQha9LuSitmUBsZfqZFJxWl8QT6k0BKcbv8DzwEogF6eHGlHCre5pFCyS1iMxSQn/23z216TM+liFqr9WdwDfDT1eJCbge6yizg9gndQVujJFgyAO3jpK2AftmoC+CEWsOKvAbtXILq8are0RAwfV64pzzwyPfQInqQlL2lmBJBAWJNgbvj9YsP/kDLHx33NxmDmXgvLcbXQR1cP8KoVHRBxoCA64e4+rhKxMFgcpMwEoeWEUEt25fvjhUO7CY9vCm1k25+i5qJf2+4qiTfuUo6pUxd/+6mJX9B7mNglRPFumPGj6iFizdJDJ4SAV5MVgUQCvzLaGZWUH45UmX8KCK5AH4g0/lHqzfu6unbiMCFTIoB/kHoPbPF
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89168160-b005-4cee-f5bd-08df4c21f393
X-MS-Exchange-CrossTenant-AuthSource: SA1PR04MB10065.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2026 01:01:21.5219
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 41ZPWxOrCr6Dilgzm1TyWUqAdCptAlVjUm9pn3zQTbN1pGw46WwtLB7RXsOnwA9w2u7qZhpySQuxJNV1UwtVDjc1J0nPzTpLWDDRR80OqqU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR04MB993676
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261126_170130_490025_97D8ACE0 
X-CRM114-Status: GOOD (  14.32  )
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

On Nov 20, 2026 / 22:34, Ankit Gupta wrote:
> On Nov 21, 2026 / 02:05, Shin'ichiro Kawasaki wrote:
> > I made minor nit comments in line below. They are not critical. If you are okay
> > with it, I can make the changes when I apply this patch. Or feel free to respin
> > the patch. Please let me know your preference.
> 
> Hi Shin'ichiro,
> 
> Thank you for the review and for the trial run. I agree with all four
> comments. Please go ahead and make the changes when you apply the patch.

I applied the patch with the changes. Please note that the test case was
renumbered to nvme/082. Thanks!

