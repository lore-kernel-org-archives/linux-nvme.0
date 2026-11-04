Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67A58606A31B
	for <linux-nvme@archiver.kernel.org>; Wed,  4 Nov 2026 23:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=uWF5WVS5;
	dkim=pass (2048-bit key, unprotected) header.d=wdc.com header.i=@wdc.com header.a=rsa-sha256 header.s=dkim.wdc.com header.b=E6oG3xCd;
	dkim=pass (1024-bit key, unprotected) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-sharedspace-onmicrosoft-com header.b=LLdqIvE6
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:
	Content-Type:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=w/Te71xIQ3nGWue2OwFckSRj8I6ITUqVKPNyy5bNXoQ=; b=uWF5WVS5oT1wtX1VdjnbANLTyY
	IMxhxZupVOVSNu8RisRu46FzXIFn8OYm+tt3JtKAa777NzYiDYNOq3HKsEbFY2S+3syM9IUDPrksP
	+VIvDBQ+J3Xks3Ewt4lX/zaNrADvIaQnqnzHGVVNxbkEQv30kSsRnpVbzBmk9QtX67aBJ94Y02R4i
	+yJw4QOaKtHxwb2AgOKEXr047ih7bCVN2GPUFbLq9oiuO9XhWQkkNqHrSuCyVAzol6VOub5Ysw6lg
	xe2j6lFfh6hE1sJcD5NsxlhP+edfwVOxyRjMZzrLEY7HfVqGQ/+rL8qMfJQ3ro5nTN8yi0zagBw4F
	ARp7VYng==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOkqn-00000007J7u-1rfB;
	Wed, 04 Nov 2026 23:57:05 +0000
Received: from esa3.hgst.iphmx.com ([216.71.153.141])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOkql-00000007J7G-2Jjm
	for linux-nvme@lists.infradead.org;
	Wed, 04 Nov 2026 23:57:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1793836623; x=1825372623;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=VMrCmXOhstrmd17PU6m2T+ATZszy2KX15xHhoWSEfyo=;
  b=E6oG3xCdmIK8uJF7+lrOQgqWwFPg84+R1PFAzvVyRylL02R0DM3v2G3v
   G7OQZ5zdjF83o2WuDUrMcwLWsbhYClJ+A6Yn19L+QQnj5KEOYjlg1s4TJ
   6l6Gi+SUwz60PNom14GG0vmMCVXFIoOMQhXlZj6z76Oqc7GCBTP0vLs/s
   1NNb21Bh6Lz0ELt/j2WubX1XznUQGv4PZ3i4+R0OCtjIMxRSCeTEf3KNW
   0QEbyGryF1J2B6aEaSv2BChw3sozlU1RcNm7xxUUF37KHit93+65JQkRp
   ShaYJ9WzsX6fVwDDwgAjyP76qEv6uTohsSJcZLCUWJ/IVrzMuer9TBvUR
   w==;
X-CSE-ConnectionGUID: /6K826PgSaaQBtx/dcrjEA==
X-CSE-MsgGUID: o+wrdyLaSMKKkncenE2CJw==
X-IronPort-AV: E=Sophos;i="6.27,196,1786982400"; 
   d="scan'208";a="159841753"
Received: from mail-centralusazon11011046.outbound.protection.outlook.com (HELO DM5PR21CU001.outbound.protection.outlook.com) ([52.101.62.46])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 05 Nov 2026 07:57:02 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=po1Z/li8LZ0ro/85dgRqEAF34U9pTYJE2lhvSoxo4PZmHNAYXqXyWSB/a+I9vRDgC1O13rdYhRFG7CzUKU6eIwlAQUaTecsi6S8SRGO6NFYDtrBlhjgRBoBfSaXKYpRbAyFSQDlWm9p9hha3OJgwgs99T9QtFEA4A4Yk09Lxf6q3XncVgQteTJhQdYR0sGBUxxzU/nS4pKtvgLoZ/rUi2GaI6k518gtqgWhKecbQ8RpI5dA/EW0HVZ2Ni4sQYNhK8cS9A5bHLKTznChfF6usTXB0VU8tRqSw9ks8xV9d2lHvJ3awDQmpOTT2EWRBifeb2hrUiOlclObVXvJXhUfj5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w/Te71xIQ3nGWue2OwFckSRj8I6ITUqVKPNyy5bNXoQ=;
 b=eL5kvumRWgpQWInxoHLe50B31BtGWYZAxuhg8cALLpsits1XAHpIzHfPYq/7OREbxYTD8luf2t59EuWIUgiDOMEqfE45I9DXXkZ80yQwqXAhWf8pGZCJLQXfG0XALACd7t2rqkqIrQiucBnsXeNFklE+DH4/tr0TyG8bcnQhkmLg6KStt5qOA+123VZ9rv9jIoayWizB3tRmVl532w3y49xvhYCl2xbNBisMRUbtW+SFZJ/5crteR8jrxEQEwqp0oKzOjspcRL6hfvZULBi4XytaliyN2H8ErzzQ0VUGM7UJ5zBxldTnDqBzddEfh5HXZQ43vuqLU0xe15HGXB0duA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w/Te71xIQ3nGWue2OwFckSRj8I6ITUqVKPNyy5bNXoQ=;
 b=LLdqIvE6QCciNR/E7vdSYq0pOmYeJVb42hyYd9qsEcwAi18vZ808up0Yd5fWL2SjH0uCjPKPR7X5lgBjTFs8Aj7Ymp4h2CZNzQnOtFKezy8VQnKOopc8pD1XFTJaVnc9c5HSyyJEZ5WSyaPWjwNgtIS5nVK/Qv64SnBTIGi98/k=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
Received: from SA1PR04MB10065.namprd04.prod.outlook.com
 (2603:10b6:806:4dd::14) by CO6PR04MB8380.namprd04.prod.outlook.com
 (2603:10b6:303:143::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Wed, 4 Nov
 2026 23:56:41 +0000
Received: from SA1PR04MB10065.namprd04.prod.outlook.com
 ([fe80::9b98:bf8a:b0b1:ef85]) by SA1PR04MB10065.namprd04.prod.outlook.com
 ([fe80::9b98:bf8a:b0b1:ef85%5]) with mapi id 15.21.0569.011; Wed, 4 Nov 2026
 23:56:41 +0000
Date: Thu, 5 Nov 2026 08:56:36 +0900
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: linux-nvme@lists.infradead.org, hch@lst.de, kbusch@kernel.org, 
	sagi@grimberg.me, gjoyce@linux.ibm.com, chaitanyak@nvidia.com
Subject: Re: [PATCH v2 2/2] nvmet: fix use-after-free in passthru I/O hotpath
Message-ID: <auvFmbUwmva581_7@shinmob>
References: <20260929112751.2985483-1-nilay@linux.ibm.com>
 <20260929112751.2985483-3-nilay@linux.ibm.com>
 <auhpmq499RVE9YpC@shinmob>
 <98022e84-32f6-430e-899b-1f5cd9777183@linux.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <98022e84-32f6-430e-899b-1f5cd9777183@linux.ibm.com>
X-ClientProxiedBy: TYCP286CA0164.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:383::16) To SA1PR04MB10065.namprd04.prod.outlook.com
 (2603:10b6:806:4dd::14)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR04MB10065:EE_|CO6PR04MB8380:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e5879b6-dd6f-48f0-d44a-08df3acf45e4
WDCIPOUTBOUND: EOP-TRUE
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|19092799006|23010399003|366016|1800799024|22082099003|10067099003|18002099003|56012099006|11063799006|4143699003|261021135927099003;
X-Microsoft-Antispam-Message-Info: s0FSzEH413FNYz7Q30fFSonvrPSWjbtkO1DVTxmhEtdKcM9D7izCXxWbTXBdzWAZ6DReaOEMz2evyUtviImAGXmQmhaHMjtQ2ZgLpi3xjpyOI3quSPyS/YmxYVvql404yayF/Wg5WqipWDqgJbKk9QIbW8BakN9oLIvZ6V9YrDFh7JLpjNvkv9QAd07cKUFWj4CSoUu6PgkOVmqeBTPU7qyZp51qqzy90J6i1KG6JWLQGZ+WKRRYS1IvnsmRcGq4kZVb/hRUX44taGiVq8DXjNNP8l96pXy3Edo2uR7qcZcxk0Z8lCCpmiLMH/wGcyb+JUkN11LhGX+T0o/iTFe+jNVr1x4nqw030GycB27/qgSwkkDzcOft0UvlsYV5WkyjrrATSSV/XcBQ86VeAcMvhI8rrh5YfDjr6TLa7eLUQv4YFvVgQH062EB8OCm2oucseVziftNrWq9RSJzS8iVy78tbrH/D34mZ9fPjHCNnUm329eTs2S11bizWpFITLI8BaFbUsvmrfAPUreFhdgBP4ICdZgGcaTdNxyKfpSeGRufmgX8yMF/7zfTNOKxKWMp1egKWQBdWh21sp03vZzBv1oAmL645EbVDrNCtuxwRz7lpb5gjwckraY4tdm90ccUwLMnYfcyJKyLC/lQMF0sYgW1+VnNVa8e96rhgCuDG3Qg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR04MB10065.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(19092799006)(23010399003)(366016)(1800799024)(22082099003)(10067099003)(18002099003)(56012099006)(11063799006)(4143699003)(261021135927099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?k5uB+2MQsmJipFaNEUhOxomOwylvRJaEf3OEAid8X+ix4SlaDgFwRMuhuKD/?=
 =?us-ascii?Q?2BB0Qh1q9GKt/L3MW8i5brRHB7jbu5EZBZC0qhMXLtWbbSjs4WNYUBBABQUN?=
 =?us-ascii?Q?UoKc+6n70C6dP57aw7EO+f/E//+XD1gfoNhTNZuBpEq75m+HWxSnOh+lY+cj?=
 =?us-ascii?Q?oSO5U9L0HN7szLEJWim0IMAOq3HrAoDbLzcTzqkIg9jfa8bRqcwu/yT8324a?=
 =?us-ascii?Q?Ig4fnWiZ2dLAQf8ezn1Bw16qdcjoF+ns0lzYgrhxVfAJzCtnTe73RUONBW5y?=
 =?us-ascii?Q?cGq0nwAoTPA7BZijCIgKqAGnOjMCgg0sb7KBeXNrI3BRBjdDRPu4oN7RS7XE?=
 =?us-ascii?Q?hIMIm++THWYzwsI6EXmnQ1IDuXpdiKON8ig3ueYQj2y7eqXX9dw6Xo43AO6s?=
 =?us-ascii?Q?ccqW7r4OV9exrkTs8XFioyhpLd8bu3r/ToJ4ML97kRQzb40NPt7xLjrPZoBj?=
 =?us-ascii?Q?h5azVO1e8wvZZcmeaNJPqNXxOXECV9VlfUzTlPvvxoV+/5fKtL3dPxulYxuC?=
 =?us-ascii?Q?s1KDqWprfrRt0F4a4dDXbZJGDuEb3DMr3BIQ2VVynhtZbkxcXNCUCxfKF+Pn?=
 =?us-ascii?Q?h64medc9Nnrwxh8dlY2nGIoeOyWr1IPtD6njrGSQgURfiDkq1037Swi0Ax1u?=
 =?us-ascii?Q?CnBB80ZN/Wdwnd94mC+r5R+5a3lo7W1qSJhUsDnhPbR3DVgLe3jHG1FsCJen?=
 =?us-ascii?Q?gt2OM5jo2Em6u68e60XuJVtkIa9Ze5QH4F1KM6eL4MdmLfEZjAhx0pG5/JEY?=
 =?us-ascii?Q?9uWlwR007CiGQiUc+RURe8CBswRuql+jaYwNXxCYDH6SPg6izD+DiQsBOn2S?=
 =?us-ascii?Q?KBeuoG3iv3vHLIOJLmT2Y8VBkAXDiQ/9/ApgNDF/btLCSD9xeTVbZCsFqyNg?=
 =?us-ascii?Q?wj2gE3BUT6qK4TP8dd/dyhcwgG7t3NdGVNDf/M2UTibsdlOoMCeLx33843m2?=
 =?us-ascii?Q?Uqqlvsznq9V2HvTtaDSUPEmqnmmT/60oi9PMErGHA/eOoMTHH0nYlEQo9beV?=
 =?us-ascii?Q?I3IyH7+U/HEpZEjlExlWexUmZ6aVFkA6QVV0iK7+vwEycEgsIEp+ujhXHKT+?=
 =?us-ascii?Q?3QiwLMeIaj6uSrG1womuJz+29Uzn5RXt/Pk/HjH1nBQgP8UpR3Gi0RVTTHFK?=
 =?us-ascii?Q?12ik65E3md49vk4pCVRbV7cH8aCZychF/YkQ95b+FChXNmTQuOmf0odk2Hv3?=
 =?us-ascii?Q?GTmD8YjlXKAIgH7sBkP5tkVqaALLEM3YIQq/h7MDt9h66u55jXKaxUOESE9D?=
 =?us-ascii?Q?DoNoCsEBa4KvtpG/pBwTEbnxgDr/AH9BH5m3v7zBhUuMAoixO3H+xmaEtKUq?=
 =?us-ascii?Q?86oFQoOefVvZalL1k8SATe8+hbTXFmtJOtEFJVAQP9Z6oZhMIO0JbnvIzvRi?=
 =?us-ascii?Q?oJ38eHGJ0sJI/xUJ9yT1GqktxbKgRbU4Fh5cOQ3GAymTVcdVfOlE0jx0q5yW?=
 =?us-ascii?Q?djaGl1EDHCkKy82Mb8N+fJs5oStjHG2jY6AkBI9M8CckQPOL1HWEFi2ln3GE?=
 =?us-ascii?Q?YZKPtv+mBSFE/1VXlJyeJV08RSMTm7waHf+8z78okoR8MdVecyFKXIRpv4nL?=
 =?us-ascii?Q?A1smH8t9cIQu2pO6p42eJaL6gassAstBwVfDzwLyuEjwpsRNGiJqQZbQUMzr?=
 =?us-ascii?Q?3pTF5CbO+nfBOwVhZLsiHfqNshBIJfb6lV5egxgw81gpFr56NGL17K45+toA?=
 =?us-ascii?Q?RH6B1/TtKUKmPfjezf5KxWwZKkgXntJItke94KrT4pml3dZnudshwrOBQ3Nw?=
 =?us-ascii?Q?YoMT82RtUpxggHDFZdQ/SZHdbSIHjcw=3D?=
X-Exchange-RoutingPolicyChecked: rFFaNMtho8Adi5tgBCGaIW9vILpQWeB7OmtBpD5DY72iTESeywMbZfRoPvDUPRONpj5Pk30d535ZRVhL9SDrJsu/VTK/gueyxuiJ7m+kEwfUmtfOSX6HD/oTy+POPvq2nUD9DGpC2aFOsNga6zgdtHb3rmXvHqk4xQl/VkjdwHFXKAL6XahjZjfvXTF1sYlsF8XqOuuTrjFGxPfqtTCy5i5y9pIl6oqg9FgTh2cVYBGOCF9+Eh9rh0Q1bwj6RoCgD0eMIDbfDoOb9/rNvCqPw/hu+LM6Eq2w9RzcLIvPglBbmJ4bxg312rlab+jBODuAO5Y3htDoi0SzbeL5n6c4QQ==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: H3TCjy5Eb3UbgSKmaUNiqUEMLpdSOINOrXIn0UtdorJzuvRnGMYkJpZsVnEc1XLuQJg0a+FOIFnEiQi7rHjQ/82LKK2hISsjQbqvdMLwQ0Z+84jPpZ3ZX9CZpNesVYRz4iH5XA55KigW0G4vK7eWzOJNGc17j10XXu2TzFKTkOr2eV5qSHq+0aKcKxuMw8+9v9gdCGonBVni6ZWBegygRvV96952zoOnIfdr4Jm+IhwAMnZvokSzpPSP6ghpY066fHNYUvhIwK7/aI32k5XCum/y3DfYIGEJfyjjE4iL71NharKKv06pUUpN0L+4lE6YY8izeMjuQ2DuPbrFdRJkFTdyVzOv/e1XcY47CPJTA6KNeO6tadUwaeoL0VM5+K+A0wLAaGsTx6Tx0oHJLq1OgPV4fJHPaGfUNLGfZgvaHdHKmDzsVjdbsCXbUPiT7KOzCFibivCr9uhdVrJXrMS3iwPTJ1CeCvaQk/LZx8Ir/FQvgLvqL1Y6ipsKEgpXWO2MhqDx5mn5RHvU8+qjeLNbW1Yk6mqwOYfkC7IPFBrWl1e1f1nx52PQ7vc4HvKD01Zwjd4iqg7DtUUQ21whsgOMBAhilxcbJl7oEpGGC+alGO+E/+BgYF9Z8EeJi6/DCmje
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e5879b6-dd6f-48f0-d44a-08df3acf45e4
X-MS-Exchange-CrossTenant-AuthSource: SA1PR04MB10065.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2026 23:56:41.6116
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CUjpMLRfmKDKdrvcGU2Fr9mV0kgVM5YfoqG/qskfyrEFDIus2sLOwQHeryhL8teGD9AtpHkOVYF6+Nv/IzD0s+ZMmHgaXWC/uCQzMYfzVTE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR04MB8380
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261104_155703_626498_F5813B43 
X-CRM114-Status: GOOD (  11.19  )
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
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Nov 03, 2026 / 06:49, Nilay Shroff wrote:
[...]
> Based on the above, I prepared a patch[1] to fix this issue. May I ask you to
> validate this patch on your system? If this works for you then I'll send out a
> formal patch.
> 
> [1]

(snip)

Nilay, thank you for the action. I validated your patch, and confirmed it works!
The patch avoided the hang. I also run whole blktests in my environment and
observed no regression. When you post the patch, feel free to add,

Tested-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>

