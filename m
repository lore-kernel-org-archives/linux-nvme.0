Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3751E606A31B
	for <linux-nvme@archiver.kernel.org>; Tue, 20 Oct 2026 10:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=ndCoKf6o;
	dkim=pass (2048-bit key, unprotected) header.d=wdc.com header.i=@wdc.com header.a=rsa-sha256 header.s=dkim.wdc.com header.b=laUnAwt1;
	dkim=pass (1024-bit key, unprotected) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-sharedspace-onmicrosoft-com header.b=e5cwiCRG
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:
	Content-Type:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Y+wwOF0TZCiCY+GDhQ0u7c9R8UM6sKr7EinCNaJIIn0=; b=ndCoKf6oerReE20Jw3MlhWO9MR
	vGf27GtiK9nngHUvhT6syKQoYIg3HHPHzPAC49whP7GuIY/NuHc2KyquXJRPP8hT68N6rcyYyxcH2
	bWc38AIlLaJxbEH61+cH9UY+pWZ8yQTO8S3tX/ZGSqT5Ag5dDa0jFtw22xS0k3Zh18kNdU0ZUfXPi
	PGaqvxF5iovnaIlQcSq4jooXOsrmBypIRWTFMO+A47Dd/NmTuJJvyAAVdlRmUO6nlo3LlWJmjgj9A
	pmxLh7swn8euOnc+bnePrGcbytoNNDQs+y8jdHfEPYO0BKjMhpO7M4/YNqsDZNqwONe0JakHpGFnU
	hAaPEf9g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xJ7GL-00000009SOr-1Iny;
	Tue, 20 Oct 2026 10:40:09 +0000
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xJ7GJ-00000009SOM-2aRv
	for linux-nvme@lists.infradead.org;
	Tue, 20 Oct 2026 10:40:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1792492807; x=1824028807;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=pcwAhETsClKpshqsr4iIu6t1W3RIChql3cCUmGC6zlE=;
  b=laUnAwt1BfzDab4TrnGeuXL0zRtGUpzQ4qIm2Td3afHll1QhqwY0itjw
   9aaNML1PI273eOWlleFNGYThTLm+bPurBW1M7t5h48x01Me7yYN+D6eEW
   AAmdW/7oMS9dONbhnep6HzyrCjo9OCYZc4gJQKb5o4Aa5Ha7Oppxaj63d
   ocHsS68nFTEMCxvupG1SSyYxyYdv9GJOZUjqhTCzD4ZW4gL/IKN3m8M1a
   o+KrYGzEM2Xh2vHQqV3WyHKcQaxJ7XXpJblxFwrUZeFEp6FZfrhhi7ZgW
   Y+iAodZoip2g/HhvlD+ZhlxBqcVETRUgV2tVpYcuS6GApQk68reQrqS85
   A==;
X-CSE-ConnectionGUID: L+nf/xiRS3qIkIy568WWDQ==
X-CSE-MsgGUID: IesGb1FsRsuUIPdRqj1d8w==
X-IronPort-AV: E=Sophos;i="6.27,168,1786982400"; 
   d="scan'208";a="157580611"
Received: from mail-westcentralusazon11010071.outbound.protection.outlook.com (HELO CY7PR03CU001.outbound.protection.outlook.com) ([40.93.198.71])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 20 Oct 2026 18:40:06 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vqmUE0UaZVnurl5iFiISn9roYByK2+nc6Kb6DTon+MSPvK++DvOP/K5FY6RkEYIVnumidB7WG10q/mg5M8raiWrreyqmGp4nbG+byXIxYyb8BpazMaP788EfWeGVVzmzgOPlpe2gepbtvsWqhvl8iqUiZYSrrF/uQECJ7y7CgjCBiHBxlEarv0Aj5OzYRtFRfSZklpqoejOUcmR0LCLD2pAkFEROZk3pA/7PU9Q1bJU92a1+JjfK7u/rLH0ocM04Mn11NusGXKYQClCZ5C8G8CXHP7v2GEH4SUP5cN8X8qiwtZSL6l1/WUnCqhO+1wLGEaqroGddJ+UopZoZgbs5aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y+wwOF0TZCiCY+GDhQ0u7c9R8UM6sKr7EinCNaJIIn0=;
 b=uFFx0u8QjSXy4kKdulehB9M1pMx2PpAMAE2tmsGQsP8jJP639Tfrl3SZArwyB5yOtAmzBdy+1UZkkYnfQphiqcFZTSE+bUPSd4jSvhyTCIizJyU3YBVnpwjEVsb86VsmZyiD8kx80JBnA6Og39U9yqNWprdHHfTgIjtGgGnvh7WGw4Ss8RusXpelAts7lVXo8H2AM/Scq3ElRaF/mhJqLggdXuRYcnNOVl/sfSol6J54JNYzFYAfVoFFRztYhhUtktCh15eqXnv3rlGP0vjKIq4rfysw/AZ/Y5K6tM465RhXvy8HE1kv3+WFm8d5N0ZR21ykKR9rZw7GtNKoHUiweA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y+wwOF0TZCiCY+GDhQ0u7c9R8UM6sKr7EinCNaJIIn0=;
 b=e5cwiCRGPD+hvx0sDuuapH6FxtPdWvTzVdOa6oJ6W324GEbFIOvbbhgAu+32L/VtG/G4bSRWuXKHmeBdhc5rIyFVd/kjFehutz6rGMcU51Xg1H2YM7SnM5Mm/J4Ocb5yHsDpZQMNF5w+pkPReESXsZ47T/GHuxMxMb5pwopwYyI=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
Received: from SA1PR04MB10065.namprd04.prod.outlook.com
 (2603:10b6:806:4dd::14) by SA2PR04MB7513.namprd04.prod.outlook.com
 (2603:10b6:806:147::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Tue, 20 Oct
 2026 10:38:16 +0000
Received: from SA1PR04MB10065.namprd04.prod.outlook.com
 ([fe80::9b98:bf8a:b0b1:ef85]) by SA1PR04MB10065.namprd04.prod.outlook.com
 ([fe80::9b98:bf8a:b0b1:ef85%5]) with mapi id 15.21.0522.017; Tue, 20 Oct 2026
 10:38:16 +0000
Date: Tue, 20 Oct 2026 19:38:10 +0900
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Andrea Parri <parri.andrea@gmail.com>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>, 
	Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>, 
	Chaitanya Kulkarni <kch@nvidia.com>, Daniel Wagner <dwagner@suse.de>, linux-nvme@lists.infradead.org
Subject: Re: [PATCH blktests 3/4] nvme/072: test nvmet zone report
 initialization and length
Message-ID: <atdEJT_j9ciVuAiY@shinmob>
References: <20261014170046.2516-1-parri.andrea@gmail.com>
 <20261014170046.2516-4-parri.andrea@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261014170046.2516-4-parri.andrea@gmail.com>
X-ClientProxiedBy: TYCP286CA0321.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3b7::14) To SA1PR04MB10065.namprd04.prod.outlook.com
 (2603:10b6:806:4dd::14)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR04MB10065:EE_|SA2PR04MB7513:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c42f00b-112d-4fed-2653-08df2e964007
WDCIPOUTBOUND: EOP-TRUE
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|19092799006|23010399003|1800799024|261009223027099003|10067099003|56012099006|6133799003|22082099003|18002099003|4143699003|11063799006;
X-Microsoft-Antispam-Message-Info: lGTTGvNaokzubZKraue8VUuUB2bv4/LRGcLv8KYfiFIYFAIlexT2xzOnIMXTn7FyASWINUNIhC5WX1eKQ3DcNaQ0wytPZblxVnTkf0t7ric0HpD1+F52s4AWi9sCFPVV9ToLi3voE0PN4o5dWlRT07UZ7YxwlaoyY5ZoKvissEbZ9wKNtsclMJtGeGkrrEFcvEYbAbGhJPckbTfm0+IOngzajGC/ooAa7PdW0OF282XMrncPMBU7tMRh1jX7LiWgltAIbq4phbwf59ZpzOwR96KY3urfNMAU2/UVCrwAiOxWAHa3jJZZ2HTJp5POfciuE7drCgHC0bU5y+D2Cu2PrGdXi6LJP52JtaxdLaY9vQWe48M6AWZTzsTdvUXRiJ049RwvX+q68qncbZY5sOZAP0f1aKG5+tXry4JGgWAV7Ag6le1n2Rvz2bxeDDNNK8nsprn9BGgVAJZxnjZw7lPO+R9g4McO81nwhbTD9ht/Z5EMA4KG0k2fxscUvGhhGYzBvPaWpGozZ3XV4HzETYhHV8/dp0/OlJLElaIg5AbkSOA5nHtWU7poUXMKW7aNZ6gGbt+v/RrUzEmMWF0NjxYrUg9hl5S7GJTm7MiZAd4ijCbhn3w4HcgfmtBfx6Nr1E7Aq5CV+J5xTSQ9WM9QYidVmcRDs72nw1yXvgLzl4UiNYw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR04MB10065.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(19092799006)(23010399003)(1800799024)(261009223027099003)(10067099003)(56012099006)(6133799003)(22082099003)(18002099003)(4143699003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?i1Aei+WNliVUpKPqpo4MWIuE1rb8ZHDpSgKalhhoujd0j1PfBp4dD7IzU7ru?=
 =?us-ascii?Q?LD2OUpt9hO8vlwpcF9BlNiCHbEVisVlvHmiDQU4HA1W2AIAt/ghZ2d7shWqq?=
 =?us-ascii?Q?DIjkJEeg1oFPyfiLOeqfmR42QPisd7vU1sbo1VAMjx6JKM8G977ANGmTe6T1?=
 =?us-ascii?Q?9q1H+83c8hQSvNYfZjCwIyr3EP4ATB/ktiY6KKqDzJ9MXM+90dCtOhajkPoU?=
 =?us-ascii?Q?9IV5P3osA7lD7CPg1QWwavkd6EaVsz9fbEdgVNwYWJ38k2DTQc2iV9hQgra2?=
 =?us-ascii?Q?aHnwqwudSSYJqI2Mk4n8A2qY5TvZLascz1LGBVGLh+sZ6EbmGYbRvOKxC6Su?=
 =?us-ascii?Q?7p8OThjCR+dGw31H//oEQ0lL5sxTWfXSBeVJ4Cuq7kcd5yMd1gTfWQ+ZHOkp?=
 =?us-ascii?Q?BvSzFyis2DVzunfQ5yshceLAgm1h+vsD0AbOLhfWjSpr60WQO3lWXYdQ7Bm6?=
 =?us-ascii?Q?dA8ho/IPmSReMYqmCpxGJskAkwPmkYFZ+kmah4YSXazOqvcGGMikEeZUhcko?=
 =?us-ascii?Q?jHPftM8FBF7CXaUsj4V04EGESc8LtKUHlNeA+ob4oc2LKyrjehN4QAIC++pr?=
 =?us-ascii?Q?Ix32MCgN4xBnz6PPfGwxyjfAdswPk7D8KVubodYxIpKoAOeQyRpKnuXEkh48?=
 =?us-ascii?Q?THmJOmPm2kALwFZExvva0pjrI4X8Oa1r9MYEvxiOiG4ud3Mm4N5DcG4rPb8a?=
 =?us-ascii?Q?0dXVVYTBqvNOwG4YlVa+izpiG19i+opY5+cSnO4Z5GqFW0V4e9OCSeuLQh5c?=
 =?us-ascii?Q?gHZ7asFeW0kwLf9mjf86KykEsTZvwe6cyOvOvDdqTEk5E1G+Fng9ZB8fLY3a?=
 =?us-ascii?Q?r+CdiiuQHmiZGTrNbfcxPtLTlCKNTNUs5j7I9bVFKI9xxdqy4vUgshYFCOxm?=
 =?us-ascii?Q?v9O6mwPhSyfRaiWz6Vh6qd91XrFOzveOrDflqLpYwN05Ahm3Mb2S352+lbni?=
 =?us-ascii?Q?7P3EJSKjq1v1FxA4X5nc8mbG2BXUej3B1rLSdTLj2WkM7RYYIFmjng3uELbk?=
 =?us-ascii?Q?1MuRnyJOoc3F3ucdc/Go1JBVc059a1hn34/or7NJ/X+oXI1EpvhWKLRRAMCV?=
 =?us-ascii?Q?NA4NP0jsHxi6WGXtFMldn6L/u7tUKBo5OQylDBt061Kpcsg6WMnv+3wOfOdC?=
 =?us-ascii?Q?WXt/FOexFuqV+D5WqaVO9HM+QTaVmgYC1tzcmrRu0BRlVN3uq3Ku/W2GSi9H?=
 =?us-ascii?Q?2UfSEcZck6G4/mQwFDZ2p35TkeVJKZNkS2/7zX8tn+J4XYb3H2y41gtXmKNY?=
 =?us-ascii?Q?EYWd/rqoAB+gGbv19cBmuyHj9+oli7pjZUt8+5pMyv7qAymsF7ThBneheKZt?=
 =?us-ascii?Q?q+2LQy4ttRN7Je/7wOOyJnemhFokrT7FFhCoxd7CjbPhrGlsttA5zFJAWT/M?=
 =?us-ascii?Q?XLJ2bZmprfiZPAEE0CqKsugIy6NDPdOG771htq/eS0cOK4MkRSL4oHZpQfeE?=
 =?us-ascii?Q?Fd730KrO5b60jM7UbqOu8GimZ+ZqA0ysBjfou4nnaWuTWP+qixir5yrrE+g6?=
 =?us-ascii?Q?dkf1D0pAz21f2jTIAEmE4bfegjuaAFgnnQ8jPsSt9a4ltkvzmPQtE1VXUAaO?=
 =?us-ascii?Q?FX6OOrjhg/ymJLuO2KKlExRtaWohhirzgm9EatCZDG3ijt6sd8eVik4haqzh?=
 =?us-ascii?Q?HYg7Z5BdZNG8fDrLJQj0i7FL7b0N6n3CmbhifQLhwOaENXv35Q6uzYheO3Rx?=
 =?us-ascii?Q?mdgpmiN1OjNJBwTAwGfVdX8fYFkAXRgJSv9WSyKH07caK/EnRbixipZDe8pi?=
 =?us-ascii?Q?xbMN9CDbbJry14J6TmRW0uVfQqtMmOk=3D?=
X-Exchange-RoutingPolicyChecked: CudEaU0nnI/lzIhETV1a+HM2wXhoaNDr/u+Wqp2Dm+UMto7Ct0WBjhfQbeFOKvSQAjfxkbP/De+n7TlvCxfErdBBGAyD7RoG8U+raA6pU75O4Y+VhROZkSrqsckw6sHe7MLznyoRFFl2fhZtx8xKtHghhrPvRjeh13I/FKXVUJgm4KE5WfVqAE03CLbcVlUrT/BdcaPcv9FNGDAnyNWOr1TcE2T2r2WBXakAevZ1W35+ulAk5WB5E2vkQZo2tWN+iG3qBa4gsWrwjJRC51UQs0YnKqQeBHsuOHGNo86sLyLzbgT1CF1CBkhK52j9ohn4aA2xPSnv1lwzc2UiPKESjA==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: vi9FNAySwy4rJBZppwPoToMufn3kkJPjgD/htHYYgovPDV6/VOKqdn6GbhGRrYv9xXt/McFxRu0QtW7NY5/eWOaavb5Y4YyM0qKIVKzuWrMSaBD6QioG4YtnAsHo+4QA0Rlnumwp6TPKBFKKsyy8VUWhAqYozr4bdsl/1t0LftK7Ku5IOwkrDQin07xNRWjPjYrwvg3O8BXoY9koWcMyln/o4WspKEunQpLxtQD11G0q9Mem+uHjQM6GsytYkURWK3hwZctHZ0knuswFUyS8QEbleOMZCeXGCAzt5VoRmOU2JLrnDQeHyEA0SIjF6ahjqT0IjbCETbcbx9M7tm2lELy3mgaALtblNRQtBubYGGZ+hA3Qp6t+CwaGLwHCD7LqPjxigZhhvu3IrTAgXhcHaqkDNfxES5PPRdhEl6WNVgQlH3NhLxxw2YE36gMTnWo8Ti3IErYhK9BkzN+ZQemWuUF9H6ESdWpZFdPiL8aZoCvAQBrSaeseT3EtzUthGNUE0mKiJ3wqOrezLYc0j0Sj8RRUEisS5+ZwfxYJILUqP+iF3v8CMupuffXFmHGTruhzfdaC27OG35NJGpEHSr01Ynmz12G4TNZ1RWSMdHKMGCDiE6Uky/8eavwFFy2MZeEt
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c42f00b-112d-4fed-2653-08df2e964007
X-MS-Exchange-CrossTenant-AuthSource: SA1PR04MB10065.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2026 10:38:16.5988
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mBrB3/8AwkydYo7x443fIQTLoL2TMMY5Xrglt+p+bJU8P6g9d0f9OFdXAMjzB/q95VF65PfSjFAJmiBLEQI/HaeBZ1dCIJI62cKrp20eSoA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR04MB7513
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261020_034007_672336_AF9B6DDF 
X-CRM114-Status: GOOD (  21.52  )
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Oct 14, 2026 / 19:00, Andrea Parri wrote:
> Export a zoned null_blk device through the NVMe target and verify that
> Zone Management Receive zeroes reserved and unused report bytes and
> rejects a transfer length inconsistent with NUMD. The test runs on every
> configured transport, with RDMA restricted to 4 KiB page kernels so that
> the preparatory write exceeds the default inline-data limit. Add a small
> passthrough helper because nvme-cli does not expose the reserved report
> bytes.
> 
> The test fails on the unpatched kernel and passes with the fix applied.
> 
> Assisted-by: LLM
> Signed-off-by: Andrea Parri <parri.andrea@gmail.com>

[...]

> diff --git a/tests/nvme/072 b/tests/nvme/072
> new file mode 100755
> index 0000000000000..c7bcf93ab4d20
> --- /dev/null
> +++ b/tests/nvme/072
> @@ -0,0 +1,68 @@
> +#!/bin/bash
> +# SPDX-License-Identifier: GPL-3.0+
> +# Copyright (C) 2026 Andrea Parri
> +#
> +# Check that NVMe target zone reports are fully initialized and that their
> +# transfer length matches NUMD.
> +#
> +# Regression test for patch "nvmet: zns: don't leak stale memory in zone
> +# management receive".
> +
> +. tests/nvme/rc
> +. common/null_blk
> +
> +DESCRIPTION="check NVMe target zone report initialization and length"
> +QUICK=1
> +
> +requires() {
> +	_nvme_requires
> +	_have_loop
> +	_require_kernel_nvme_target
> +	_have_module null_blk

I suggest to call _have_null_blk instead of the line above. It will allow
built-in null_blk module.

> +	_have_kernel_options BLK_DEV_ZONED
> +	_have_src_program nvme-zone-report
> +
> +	# RDMA defaults to PAGE_SIZE bytes of inline data. The helper's
> +	# 8 KiB preparatory write must exceed that limit.
> +	if [[ "$nvme_trtype" == "rdma" ]]; then
> +		_page_size_equals 4096
> +	fi
> +}
> +
> +set_conditions() {
> +	_set_nvme_trtype "$@"
> +}
> +
> +test() {
> +	echo "Running ${TEST_NAME}"
> +
> +	local block_size dev last_sector ret sectors slba zone_sectors
> +
> +	_setup_nvmet
> +	_register_test_cleanup _cleanup_nvmet_zoned_target
> +	if ! _nvmet_zoned_target_setup; then
> +		return 1
> +	fi
> +	dev="/dev/$(_find_nvme_ns "$def_subsys_uuid")"
> +
> +	sectors=$(cat /sys/block/nullb0/size)
> +	zone_sectors=$(cat /sys/block/nullb0/queue/chunk_sectors)
> +	block_size=$(cat /sys/block/nullb0/queue/logical_block_size)

Again, I suggest s/nullb0/nullb1/

> +	last_sector=$(((sectors - 1) / zone_sectors * zone_sectors))
> +	slba=$((last_sector * 512 / block_size))
> +
> +	src/nvme-zone-report "$dev" "$slba" >>"$FULL" 2>&1
> +	ret=$?
> +	case $ret in
> +	0) ;;
> +	1) echo "zone report contained stale data" ;;
> +	*) echo "zone report checker failed" ;;
> +	esac
> +
> +	_check_zone_report "$dev" 4096 1023 0
> +	_check_zone_report "$dev" 8192 1023 15
> +
> +	_nvmet_zoned_target_cleanup
> +
> +	echo "Test complete"
> +}

