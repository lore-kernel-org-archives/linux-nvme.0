Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D36B606A326
	for <linux-nvme@archiver.kernel.org>; Wed, 21 Oct 2026 03:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=gTWlD5CC;
	dkim=pass (2048-bit key, unprotected) header.d=wdc.com header.i=@wdc.com header.a=rsa-sha256 header.s=dkim.wdc.com header.b=JXajQ3yK;
	dkim=pass (1024-bit key, unprotected) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-sharedspace-onmicrosoft-com header.b=uow7gfgb
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-Type:
	Message-ID:Subject:To:From:Date:Reply-To:Cc:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=2P0DjZE1i5oXj+qQlP+MZ7YBMdD6huSGy2NAbTAT6SI=; b=gTWlD5CCkVt9JawH+GfE5IAUMc
	ZsGpH+1iyPTt7PFuKU+iqq+3ird+9A+RYMoZO82I80vah1k1Kxizeg/yPOyOOcuJgZnlMtTp4UMO/
	VTZ3UfS86Xv+ItBnq1gOWOeCWiQDQeRVqC6LgDk1lzwvZc1zqKWBmLRKS0C6BaQDSYAD/LExWbDwj
	tTpH5KN1vy8wgG6fQbQCTtrVqcO/a+dgNSkz5xdXONupFwYfPv+G+CsRTWsdZ+3it66PNdadbJrmA
	X/Ck0xDpnfp9+SniV1ErGYBk1NWT+A+kKVKKq7ysqnrAbkozewF1CFFJn9c/kcpnSpL+r/SFyN0P7
	lzPgZQLw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xJN0X-0000000B06t-1VY2;
	Wed, 21 Oct 2026 03:28:53 +0000
Received: from esa3.hgst.iphmx.com ([216.71.153.141])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xJN0U-0000000B06T-475z
	for linux-nvme@lists.infradead.org;
	Wed, 21 Oct 2026 03:28:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1792553330; x=1824089330;
  h=date:from:to:subject:message-id:mime-version;
  bh=y3UcCPn+jF79Tc+DfppLLDzHbaz7lllaBGM7793mUe0=;
  b=JXajQ3yKUj8WDotygtwuN04Su/atQ/t1NC1QAw9UcMuPq65WBOyy42FP
   /0B9ONNg2EMbO1NfKMBvex5P7ZBtbE6bLgTexjijkVmiRsJoRJHzPEk+X
   BOBb2SGvB5O7Agv7vRLNAvxR8Xg0iLGz4kJoYjUEgdRfcv1/u7Tbe9j6K
   uIHLodYnOhLJA2JyEi4LkTkQBOYuI6Z2JH66RjbeSUbP4ddZKLlVHDDrn
   y6BmXIqdFcXNjocFnuRDwr037km3ijHp6anKTTK9TACqpVeSn9M4U4MQq
   B8m0bado35Cia9AV9vcY1Q2X8M7MFvmkc8hjUNO4zn7uStXREtv+VO1ls
   g==;
X-CSE-ConnectionGUID: ou74QQhFTjq+wtZ4mN5cAA==
X-CSE-MsgGUID: hgcLSeRIRvShZyj1vQvhew==
X-IronPort-AV: E=Sophos;i="6.27,169,1786982400"; 
   d="scan'208";a="158608891"
Received: from mail-southcentralusazon11012037.outbound.protection.outlook.com (HELO SN4PR2101CU001.outbound.protection.outlook.com) ([40.93.195.37])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 21 Oct 2026 11:28:49 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TF09Hu8orOdv4Bf8ulrfv4T+vsxaYovHUY1G2IWsH9GMkMD14fvvonGblXiijCEh9+jXxRrzp25nUidwbNiJJWhJS2MqwvCxTF8ExD8jSe4af81sJEFro35s1u7Fy//KnsS4ly01ebPTD6D+dRQ7UnuIhImXfI0zjMyND7+pUfoMkReaNetDY0uZo6W7IzU0Ve8kuvIO7UkdDAfTSeSmAl26hZq/j/4RuBF0LPJfeUF2pELatqEDqWx25l/0bjSNmSx3x2QSdebjO2P+sbd7qwjW4v5bM97lURlfv2r3QfjQII0SmlZSP5AKipPnZHJUEsKTjByDjH1PrKGCfMCdew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2P0DjZE1i5oXj+qQlP+MZ7YBMdD6huSGy2NAbTAT6SI=;
 b=CkfcIJsE3ifAnptiI+wcpDn0Bqph+UTF5NxgivLCH/paMeK6YmPMR9aGA2BBU4JLXLC/cj0w5f2D4IR6GjQVBWv/KzSnx1o3iRpY9mT7rmFfcS20oC9b1rOXi2A3im11sF4C/2LPU36o41xVqb2SRs2DLqxC9aAQP5g4tAVk9v3+dslAQFWQf1hPp6cO29JQYgoqR4mZTJ2Y8i0Rf8U60ELxF4XDhYpxlsLkBptFtYesOUVd826W0jqHgsbKMtexLOyKhwNEEbkBS6vyaPJa5j9uwNXLcS0yLdncCUnxQlXLujwthy+yRuVJm2UV6cIeHP1aiOy97apbgDTSwDZP9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2P0DjZE1i5oXj+qQlP+MZ7YBMdD6huSGy2NAbTAT6SI=;
 b=uow7gfgbwrlCCVxxtsDzM8a14WfcGg7iDMQXzthAQbdYAnHH4nl9NNYqvxIpp6Hfo56YQOHO+3pFB0fV9vUQpyFC2yy6nVGJOePdQ12m1gpqtNdzmrrqm/rPkiectMQ9hKM4oqCJ9PIgXTST3sywrM91XvxZNpOzdjK5x6YL2xk=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
Received: from SA1PR04MB10065.namprd04.prod.outlook.com
 (2603:10b6:806:4dd::14) by DS3PR04MB9990.namprd04.prod.outlook.com
 (2603:10b6:8:39b::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.14; Wed, 21 Oct
 2026 03:28:48 +0000
Received: from SA1PR04MB10065.namprd04.prod.outlook.com
 ([fe80::9b98:bf8a:b0b1:ef85]) by SA1PR04MB10065.namprd04.prod.outlook.com
 ([fe80::9b98:bf8a:b0b1:ef85%5]) with mapi id 15.21.0546.012; Wed, 21 Oct 2026
 03:28:48 +0000
Date: Wed, 21 Oct 2026 12:28:42 +0900
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, 
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>, 
	nbd@other.debian.org, linux-rdma@vger.kernel.org
Subject: blktests failures with v7.3 kernel
Message-ID: <atgwg4i6C1zGi1HU@shinmob>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-ClientProxiedBy: TY4P301CA0021.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:2b1::8) To SA1PR04MB10065.namprd04.prod.outlook.com
 (2603:10b6:806:4dd::14)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR04MB10065:EE_|DS3PR04MB9990:EE_
X-MS-Office365-Filtering-Correlation-Id: db1c8a59-0b3a-4c86-cc09-08df2f236b55
WDCIPOUTBOUND: EOP-TRUE
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|19092799006|1800799024|376014|366016|6133799003|10067099003|18002099003|3023799007|11063799006|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info: ECsnwstDZqEJsBFe21feAWx4aRjyRwYb7TSp1QN2AwUIX4YD9Ovkm5pobXumelLRZ7F10GpRAyR9ZqLvdb7XM3pFwGNSYYiAg913BS9xccKb7utfwtTrJZVgVViOBF0JGxCAqZW1ebg972l4Fj2qcKRP2btx08Ra5wZ0qfYizCHUVW2+eFWp9Rh1NkNZxawQZPvYImI3T9iIGCohASPsTsd3ozBEMW2ntBwZ8czoHq7O07GW6+8TOjln/NWhw9if51nuHBOV5lnTtDfiuXSc+VNiwrfl2qmBDx355KllseSldiClf38uMjWk5+l8+HKVNgxzfIBVBmJmObt08WklXiuKS49oWcs4URWrcFeC0Ac0a8lmgCDlSKNNfHbjPSM5tiU1p42HkZ5xpUd7eqKx35kSDLBa667SM8xMI12Ifc/GZQ8Ax81pBeeQamADdyFiMVf2Xr5rsd7FfCgeY9E3EfPbS4ibprv6NRLn0dRvb3iuRRqsn601PRKSXmcAD9Zq0cU/P9CQQwAqqfTcJRtvWpDh40x/zJe5KFIp7gB9TMd/35mh0woK7y4GU/kSvarFuMdtpgg21Pl/72k7cJBnmbPAfyi0QL2PJ4cW3ILQSNs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR04MB10065.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(19092799006)(1800799024)(376014)(366016)(6133799003)(10067099003)(18002099003)(3023799007)(11063799006)(261009223027099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?goRutKOHjhy69rYBjtA9W8RMw8YMqrpNzL0jhjOndLs2oRkRJ2pAieTCMPz5?=
 =?us-ascii?Q?ATEA/SABvxr/eTgZgUvSsmSrWoxyZnLMh5Bx81IrYuTZ/1A5GjyM3zIkwnq/?=
 =?us-ascii?Q?t0Ucr77S7Fo/XTy+1SiRdeLh9Eme1ZFnSgU8dIhMvfrXz7PgHpZ7BYMAmxGX?=
 =?us-ascii?Q?dQSODfBYJ/ncB808+t6uRrhBSFpbG3yOrQK3R4kejulZcT8wfoj094CsH63D?=
 =?us-ascii?Q?fyIh+MzUVYXmhHDKLKg9i5zUsR8ak0OfGC42V9cAR8gOl8CHx7oBEcxr4lNN?=
 =?us-ascii?Q?sQnP4QbWZvKZGvvYUVA4a7p8ACYgqBUqg3rEsHdh1pPzlldFn7DfaSiYp4xx?=
 =?us-ascii?Q?g9+skyv+2hwcfpBfI1NFOcmI8p+yBFiaQXs3xY3RaD12tBNQSvgYMhSPO6rp?=
 =?us-ascii?Q?JaibJTRZ65bZzBb1wBdsSEdyQLMbFFVWJ1xq+TE/gBMueCOopAry4bJ6FXtW?=
 =?us-ascii?Q?QRk4pp2HvDE5xVVljcyBHvgTlXTeuf0M+93l3W5MRJ5sAm6WGReYzN5oYLBT?=
 =?us-ascii?Q?3XLW1FiSrBcpbal6oGTS+iQxfcNCEhKgdZA6tVWUzBS7O6Q50MGsVTkv5f5+?=
 =?us-ascii?Q?eeb3siQ/fUWOXMl40Rq706OvXb+FTnGAmLJT27SL3NtI7ygpG4o+m0LOCfhF?=
 =?us-ascii?Q?CvLCGiNDY1ZZHwUxyKXHhYFizLSwsbny/dH55j7Bg63gY/PQdLKNputNMtzr?=
 =?us-ascii?Q?lnfPdd/+Zcj61/VsT285Wla7hn5Wo1kk/MDeJ7JR0rrmRXgKFlbYFCRzVyn5?=
 =?us-ascii?Q?pN1PKNrVQuFaw+6ng1L0Zbv5nkM/UJ2kNTW5GmrjXyJYO12hoKL23btiY+Le?=
 =?us-ascii?Q?UMybibySuIRL+QgOiMJITgasjzXcfSaLc303bCrG8Umum9Ihex2IMwnmSVV7?=
 =?us-ascii?Q?7z4LUC1JVSiWmV17Ol4qzxJVQjeNjW3WhMgslPB7O+68g5kOC4r6ybkBEn9+?=
 =?us-ascii?Q?pypsFSICALJG4nPVOnJhEWcb/S7PbniFuo2Ni0ie5qfg4VxSqxEN6Tvv3iTw?=
 =?us-ascii?Q?SnRb78rj0CLgn6EWAQvBB6pWjdO+SaUwojPvCi5rb9C3R9TAgEIshlCcweva?=
 =?us-ascii?Q?BE+G9q0TDq/ygfem0l90d/ELPlNpoK6dMO3Wj3rOkH2//d13/WZha3OQ7h2M?=
 =?us-ascii?Q?BHbfCww756bqM4K/u7MKFy4fJBBgMrb7eXMkrTlLxTziQMZ0GbJ4PcAzV2KG?=
 =?us-ascii?Q?EANQMBQsQmaHEqprm8HmO+Hhd56rU9IXiUkf5A69r8g3RTTO6JRZG/vrFjXL?=
 =?us-ascii?Q?NBtjKBbae1TJLkuHWMRGTxSGNFrawJozOCAkKR5U4lw8JBaWmJGVSc3D/hnQ?=
 =?us-ascii?Q?DcCsJLor4EcllIz8a3NLehwRyOJzhck3rVmPrmGmtCIasMBvnrEegiVCCV5q?=
 =?us-ascii?Q?/2Yi/6OMwGUDrqQzLIGndnRx+ZlSj2Hx6FaR9nAyyR8rYQ3Ky70ffdQojtL5?=
 =?us-ascii?Q?iMbLwQLqsEMTaR7Mrs+5WIV/Lh5jsUZHrNn37mSnUYAf6uQje4nGKS8aiPMb?=
 =?us-ascii?Q?kPm26kKre2KQPgBvKH0NF6S16uMinCn5ihhZPy8lP8fdaD2WOpDA93k89MKE?=
 =?us-ascii?Q?gh/t4wdGD97qELsK5JHPG/e9cZSyVnq393zC4bL5DRA22DVZG9qjwbMzxK5+?=
 =?us-ascii?Q?D7ypOJ8k9kXQGgi/cUn5FQJDvzsQeemLiCdm2Z8P3WfK1Qe5rPd99/69M0FK?=
 =?us-ascii?Q?DdgYf8vqebR/etTypHbcmxIMPbyg+wZJGnKuwjNrT0oPUw6dxO0FUtf3cyj9?=
 =?us-ascii?Q?nIfAysBWlHza1bB+D5jpUaS8Jph+J2c=3D?=
X-Exchange-RoutingPolicyChecked: 0JKrO69bhIRdQjD79BnII1ooMzw+XNTYOYo6MUzA9aaRlsdLKkhdOS2bLkXYxxUVxMKp/9EUpX2LGBsFqoWnVL4HS40Uf64yQkxEfeeJsNysKrL+9/VSJd20eFEyhh1KZ3J8GD3Wi86mi0rwUn7FtOae+n+regzpz8TRdcrUqxpvl0jq+Ex9JnEq1G4nmdP9X+GtFc14FUzqe55rMBs0DfuUpGQyRUHIbCXeQnl+2e6tTYRaPSv4NhEtmj4WXF5mtHNoGYLa3RkfMmgi9rd3MBkTYN8M3mFrH953FHMtLDYZM6KHwBcQVQWvE9A8+pFBeVXPreQbm+GSxhQMSbmaNg==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 3EdTMKQHbFfgJoTH/ShfiRSEZ50p68dMQbEGVl6nyTijmGnlXfcl+WUUreMN3Bl41IhUNxxU5dUDR2BbrUqYcZYyl0E4rMA/pLWECNbhFSRZP+I/UhLWI/gg1AQsdkxHk/AP2Z7dj+U2xPPzt04nqWJUnJWa3KGZCe5TIjFCWHYIplPfVwLDQxVNqz2Vck9+NDWUwIyJVmjH1hwUgV3Bqk2CTrRGFID8Rjyqj7ef2VUA0sg4XseGo/azgpnHJ+FliKPrkeniQm/JoMWOpyXzxkvHfgBIO6IfoEGCySemlHQy1SYB3N8sFuJY6Bfwwy0hNxPE+XoGMy+abWSqUbiIh979nsH1qfua2HM+1ETAlpaxYB6D/AoaISY+k0JEOo/hn8d29MTlQrUj2QAkpskxapyEUdStk4hsIpvwfDB6pBZk8O5WgnLrIN7R3Bffg44cuMgV4MVeg/fi6jHtxqLrkFgfYQmyGrIqFaB0L6e6fR0bEL1b9zivZ1TI0yV9YNHDlqTctYPE6Pwtz/YS8pEc1p8kXIbYJ3hdp5V1FkSBsyz+c0HpArrZ37+v/fRJzBB6kwPMac0tj0a6Ikb6cZnNeGfqwxEhT2UWIwuwvr45Oa6UqMq3E/r+Tz27RyTcL7mv
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db1c8a59-0b3a-4c86-cc09-08df2f236b55
X-MS-Exchange-CrossTenant-AuthSource: SA1PR04MB10065.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2026 03:28:48.2036
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZK2wYNrHgN58nmsmk8aqNjQ/m38QBEUuycArMIX9fhWm+9DGYnVWgaLzcJ2fxSzo4rBV++6gjZAmfZe+FAuSiuDuaVrs18i4OsoI8T0iC0U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS3PR04MB9990
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261020_202851_052304_52264D8E 
X-CRM114-Status: UNSURE (   9.75  )
X-CRM114-Notice: Please train this message.
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
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi all,

I ran the latest blktests (git hash: 9ad5a10fa8ed) with the v7.3 kernel. I
observed 2 new failures listed below, which were triggered by kernel changes in
v7.3-rcX. The failures reported for v7.3-rc1 kernel [1] were no longer observed.

[1] https://lore.kernel.org/linux-block/apkYN8Os5A6VXqS6@shinhome/

List of failures
================
#1: nvme/004,031 (rdma transport)
#2: nvme/052

Failure description
===================

#1: nvme/004,031 (rdma transport)

    The test cases nvme/004 and nvme/031 fail occasionally for rdma transport
    due to the lockdep WARN related to the two locks nvmet_config_sem and
    &id_priv->handler_mutex. It is easier to recreate with rxe driver. It is
    rather rare, but the failure is observed with siw driver also.

    The trigger commit was

     2a8513091d2f ("nvme-rdma: parallelize I/O queue allocation and startup")

    in v7.3-rc1. I poseted a fix patch candidate [2].

    [2] https://lore.kernel.org/linux-nvme/20260922124447.588057-1-shinichiro.kawasaki@opensource.wdc.com/

#2: nvme/052

    When it is repeated several times, the test case nvme/052 fails [3]. The
    trigger commit was

     42b0f5196dc2 ("nvmet: defer setting ns->enabled to false in nvmet_ns_disable()")

    in v7.3-rc6. Nilay kindly provided a fix patch [4].

    [3] https://lore.kernel.org/all/ar30Q5H1fuyFtDwM@shinmob/
    [4] https://lore.kernel.org/linux-nvme/20261002070249.338225-1-nilay@linux.ibm.com/

