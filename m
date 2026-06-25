Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 466F9CDE008
	for <linux-nvme@archiver.kernel.org>; Thu, 25 Jun 2026 10:37:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:
	Content-Type:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mweaXYTaUpUtLcRap6mbx8tBPQoseZ8q5FdNCzCE7bY=; b=ssYCXY9cbKTbQoODqtQRJCtWrM
	FKJyMsNklN3/hWyXjCZ+kuC/ndguEk+nJSAYzn6DFN1oM6WAAL3/fcMAqN6CIAPJPAQsR5CIz//p3
	tznH/41D3jAXl4UkTZj54lR2dMQ7hFt1wsbDrNYSL/Bi4MplvT9Q6dUek7R3u3KP7BFc0+j93nmOo
	MOrLNk64gkD64YAwr4gNYrp3vrhYG6bHdnOHJ3orwuHKd7mOcXUtRMp7i4d5C+I4b67JzvE0TR15j
	m9I7VS79FvezqejhX7sutzzw/OtPMkrP+ow5VxykbsO+k9aHI9w+S8bTsrongU+/irGQgDnEJldKi
	EXW+kDYQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wchSw-00000008zxe-3Wel;
	Thu, 25 Jun 2026 10:37:50 +0000
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wchSu-00000008zxF-0zgv
	for linux-nvme@lists.infradead.org;
	Thu, 25 Jun 2026 10:37:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1782383868; x=1813919868;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=mweaXYTaUpUtLcRap6mbx8tBPQoseZ8q5FdNCzCE7bY=;
  b=JSH70QY3pCr6Ig144QTro/qbRyDYzxk0KP2qaaJyFdwAg72Dhl61nsJA
   l5VuB0FPL0wG8oFNHtoTHLGpHsREHDtsl4gcZC9ZeTcJmIklCrgbyo2ke
   iaz1xeke5lQMTFES0ZlDdhGU4m6PEI9rCWZEOLofN79eOgJz5PkpDE68n
   DGM8Da/e3uxCzW60tZHsP7spESN5Bo74EEkbXmp62x1wjua3CXEVdGBIt
   Zj/x/GtIeatri+Rw82D43ki19jYd+P54u3wOe/d+6oRbGqIMca/dMw4zC
   OrV8cyukEkDpYOTXyuHYknuyyq43V7ZV7lLH3FoDhWYkpMGw90z3nK6CS
   w==;
X-CSE-ConnectionGUID: f23TQ+7YTAGoUNFmUgJSDw==
X-CSE-MsgGUID: S7RJ9xZxS/+I+jbaO883KQ==
X-IronPort-AV: E=Sophos;i="6.24,224,1774281600"; 
   d="scan'208";a="150706259"
Received: from mail-westusazon11010047.outbound.protection.outlook.com (HELO BYAPR05CU005.outbound.protection.outlook.com) ([52.101.85.47])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 25 Jun 2026 18:37:46 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vpzAB9+GTiq6XPsM/c+wKwdXR88ahqdShLkiaPJ4SkjR+8/YBZkHKl2aUqQPAhIX59ReddvTLHCw53Iv2KO3roznh2ivHuw2Twc2X6mK4DZeMgJkUnk83oVaPl0h2Mjnyxh1mFrA2yC0w18h8S7OWYvoWi7zSbSf8T0OhANGI+oGFk9fSP2PKg4cZ0sPXhbBqZ3MMec+eGd381+jgKCs8YBAqhOHk/UjneeR6kNmTthuIwUjbh2Grz7yziMW+0rXkqq6VnIeiRZuoL1Gx918OLBBEwEhNCB5Psd02b4bFji63Zgjt007ElPywHMAhEf+tFpm3KWPfEthOz5UNwAy4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mweaXYTaUpUtLcRap6mbx8tBPQoseZ8q5FdNCzCE7bY=;
 b=Hsq1VHAIOa4KkH5XoM0fRxrxuwcY9cuhYjuJRVVdC6ROdqxdlf0fFZnKT3d6tKZTkiGYHKBqEqJVBY1RYO7wybEwi9UMcCAnjGzUDUR3rVDQk7t4pM78AarzYYgHvz1ULwZENpwWNQHjsOSmkv+KkndgEAuMYeuNtHpEL1XzdKwLMtvz7+OJkCMIpW3kmWx9dlaPpDq3WCHJuGdMErwMcCdwVmR5DOKnLnCnNAXQYqGEcJND2t0kJWSX4Dw3Rew0rTagWtDZ6BpXam/ZguVHmdFJwsG8GpfnNhZ5bmO+LEj6kzXEZlPbk+/Y73d6vLg+ypKa7BgVy/w74XCf1/WaYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mweaXYTaUpUtLcRap6mbx8tBPQoseZ8q5FdNCzCE7bY=;
 b=po5SA8o6lmvSbuu2xYnL2dHKHHABf6Ugwj9shDXMmf/nfeDgodnAR03jpHmypoMygrqIXs3V3d5aR25M/g9NIRS5lXjUKIRAdnBbkCFPGjNiAaFVtQcFgSOp91tXfbVhUbrEkk4JjD5nCeInBOYhrzLkIi+Ejo2rBohKDAORoz4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
Received: from SA1PR04MB10065.namprd04.prod.outlook.com
 (2603:10b6:806:4dd::14) by MW4PR04MB7395.namprd04.prod.outlook.com
 (2603:10b6:303:77::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.16; Thu, 25 Jun
 2026 10:37:44 +0000
Received: from SA1PR04MB10065.namprd04.prod.outlook.com
 ([fe80::9b98:bf8a:b0b1:ef85]) by SA1PR04MB10065.namprd04.prod.outlook.com
 ([fe80::9b98:bf8a:b0b1:ef85%6]) with mapi id 15.21.0159.007; Thu, 25 Jun 2026
 10:37:44 +0000
Date: Thu, 25 Jun 2026 19:37:39 +0900
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-nvme@lists.infradead.org
Cc: Daniel Wagner <wagi@kernel.org>
Subject: Re: [PATCH blktests 0/2] nvme/060: avoid false-positive failures
Message-ID: <aj0E3r23A-oUn7nt@shinmob>
References: <20260619013329.558580-1-shinichiro.kawasaki@wdc.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260619013329.558580-1-shinichiro.kawasaki@wdc.com>
X-ClientProxiedBy: TY4P301CA0054.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:36b::14) To SA1PR04MB10065.namprd04.prod.outlook.com
 (2603:10b6:806:4dd::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR04MB10065:EE_|MW4PR04MB7395:EE_
X-MS-Office365-Filtering-Correlation-Id: cfc95129-527d-4feb-563f-08ded2a5ca72
WDCIPOUTBOUND: EOP-TRUE
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|23010399003|19092799006|1800799024|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: rjWCxXsDFsany2ec+Z65m1hwC6LWzTjvA6dZy8RyE0fHjD8mcFfooTejFVxkUJvRoA7YEBZCde3gprspDXl3GoUH5e3MBOcS3EqZPMeV2NJXDSPQNDFz/Z25HiNsF9olUCriO5D5coEMzEFWrAFSUx92JMyo/tZmtwEdwYTO9SeQJzJn7IKEGlNVh7NcN7E4rMrG9xiTZTkQPspfQc18GHtYfQg8Hb7rJAK4NmgxNw9vnTUM54b0WiT1cx/1bPP9mAfpcQNq22ytj5bNnp3Mh8/Z3Q6v9d5PSgZG3dctwg2Y6mOjwEatAZaiTA41M8HUE0Sj4T+c+bKFyqhICr2mWliV+95Zrx2C/hFMgtG1eTKX6z/1+hOHJvloUEG1lU+9enRQ6QbniMzIZlvibHUq6Y1a5CYtlSeTL3NjLQIfXaIqxHufZvRaOYHivc0Pn/iE4kRG6pHCxHVZELfTrm34ERFQwbeNc2Eg3C0YvtSjmhik2opoqxhPfVuP6HkQEuwf0fS0kqfezhqNN0QBafaRjRb4OII3J2QHkFvToWJB0XJE/SFbz2GoSfGS0jkUe2zjkUPG7sSCKJt8pEvkkkw8wgEyJZRZZ74LLwmsU1+K8oVDnPY/2AnH72x204bT8lyPXEUmilHQrxV+54OA19eaF//QBWKBsdg1K8Oh5XCDXz4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR04MB10065.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(23010399003)(19092799006)(1800799024)(56012099006)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?k/J6mNW8uQHFxXX+uyzgDi79rFAzgk+JKO0zjck11eI941BsSi2E6mmxZICe?=
 =?us-ascii?Q?SeVIIKuvKcDXctYY6hak9+RnlwzxezKVg4XWn0l+x34XvamwXvyKP5i/IDbz?=
 =?us-ascii?Q?TGqil6BowDrQ1WHgwNVV+yUbaubT7okWBJ79ob/xZPoRGTGuNhLe7el4/Pfe?=
 =?us-ascii?Q?s3+IPlcRLiWZc2+jupZw/WyzStsJ7t5A3VGQQyU8Jvb7m9hQsFpgJGao0EbN?=
 =?us-ascii?Q?lMyVHi9TwdVrjVV/HQ+TV2MCUcMMHDyb0+BcWUnEE7HOoJX9XGRrYZ5v7Urk?=
 =?us-ascii?Q?JyEkH6uyi5M2QX2iYuX4tAMhMiAlvMwZhPu6SI2LkXDDZtv+ibmBOjvAGlfa?=
 =?us-ascii?Q?6k5SWqOLxCdUOtUJQ+VThUPKTW7wP4HNyssWjsAjDgw6HrMdahs/tAzMbI1T?=
 =?us-ascii?Q?vtt+eiywpMhCFGM+Fcxn86MTqZq+S925I82MnwdoVnpPS1yL/gQ1cf6t2+Iy?=
 =?us-ascii?Q?aiovRRN8bpwJ9Qxnmg+TARCVanJ7uTvn0PQEQ0xF4rZWQgDabV3Ym1abhE8K?=
 =?us-ascii?Q?88BwFh/1pK9S7tZK4F5DVYnc6Qs/V1PD2e/8DWc2OBRTdXMwkiGuEuKA1vsv?=
 =?us-ascii?Q?U1y1WhGjLIIUICN7KP3oDq+kWsOL4/sGn9Ywl1bl/MxtDoGgci1FohfVidHV?=
 =?us-ascii?Q?V8enqfOzey3nBxDLJl5uGgFVe6phCVqqZNAHP7lB+NOJ0faIGyN47Zzyc13m?=
 =?us-ascii?Q?odbzGmyzk1EM68wN5F5qTXiSWnxxrIE1XJxlKOD9ETum8rJ2Xh4StCfq5DRI?=
 =?us-ascii?Q?gZLyUKmkGWMFHnxjTQeI1MTMw+d1iklP0uhsdZVOSxmrMFVIdx/oJojSDavy?=
 =?us-ascii?Q?hJdKb/CoyKhK1Px5PtNaZSsN1uqYSmT8fTgybyLGP+jc1/gv3OP8jIm9SBxr?=
 =?us-ascii?Q?Oyus71VSM82glsktwpE5y0wI1yYqlJoowc9VLUYsnlYMd8mZVg1FjwA50WuT?=
 =?us-ascii?Q?QtMyOjBDab3q6MQH0F0VTlZ7xVba3i2KwwmUxZrNY+4MDlPZAnzCpdrE1R9c?=
 =?us-ascii?Q?JjXYPA3xt51MJzmWE8tQCRDdhggm3JFFu2hUKDUB4x3/zWSKgUEO4aGL+2Cv?=
 =?us-ascii?Q?tra2q8ZqdYMoacz4Hevwqg6xHbSluUxBdnFmwNHhwynlrk496YSmRR4mYwdz?=
 =?us-ascii?Q?tTlqLGRkqBPflabeUZSoFUHoRo6EE+kLROoUfW66/YvwdLsdOf8BnMfM8ZfT?=
 =?us-ascii?Q?40Zcdcs8JLGNyOXCNIWIJuc/oSf/7AggbIwOcxiNSN40/WjSLsKi/BKc67a/?=
 =?us-ascii?Q?9b7uBYRuwopzUA+sO54YD1RG3ZjzzLz8N0NhVh3oubE/08fesoA7sHocUSSo?=
 =?us-ascii?Q?jXYYI9GJK9MXx/fAHKj+DS10vzEKtiRnMErR/ekJNUbqkrKX2WuApIsXdoUO?=
 =?us-ascii?Q?jNN4ewXY7O7iO8jtHvXxFrqGi9n9Kb82lQnNYy355EAcNTgqiSXXCFt6AiZL?=
 =?us-ascii?Q?1LKXQPGeQqVHHw0G1fLfQToBRvhTRqijnpF31sGeaOC7YRFBy/4a5sck6Nnu?=
 =?us-ascii?Q?pYmGbxvYGphMXfyuwB1afdFcI2UN2eZrQktlSzoZybyZdeV3glbUz0kXeswP?=
 =?us-ascii?Q?73dNzRM4bcCCAoGBZrDDYddD8cnDQSjR+5aBF0LedQXb+SAmK3IcnTHisDaG?=
 =?us-ascii?Q?eFaUbLLVqC7fINlPcALWQBZ84VRLYYS/anD0Za39IY855pf+9m6+7GdlYwzK?=
 =?us-ascii?Q?jUmaZZXET4SUtE+l53XLNmtjH7ZsqO6xWeBJT2sEGZmzBlkmofLd+CbLE8zE?=
 =?us-ascii?Q?XppVmNw74YIsrAnXBswiBJm6avnmuxI=3D?=
X-Exchange-RoutingPolicyChecked: VhR4zsSsxyqoKwLLWo3pz8s1OKByIouvfrb0+15Y98HCm2GEIro4zxngQos94g1KbDSzSCwNjSHHhWCinKOAsCQsSh1TIWUAk4m5DUXcfDFguY4IuJokvMFeyHv7kR2uCoAZOYzyJuY5o9cEmwcpTe8ALcP8T2gYmTgV2nJ6IygX/JwQG6LnBqeswzmBAlYp53Hzewxxj6vhm2MRXijQNawq8kNZj61uGm19SlJJwzS8FVHqQtEHDszU9+PYWUdaIfKk/UCBe91CmVwg1iAg6u3iGziFNoZKE4Knoo8BweHM2s5srUsSTq99nlte7yG8TOcjAiKxLMtn4aIvpAFb/g==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: qoqEtpU4pKOkRGkxIhlAl5DIhdkNJmTDoSVOVBglBykj/PhoyHx15jDmArSG0zX+BEbtX1G8lcAjGtFncYb37FF9e6S3eCko50arVLtTwVEuCiO4NUb49QlqHfYA27MpuvZT7RCJcSPvFEyYwEWgul0IDBt09pqbVV73CuwgChSNkdRbwUG/OSQEy9HSAKNxqgLc52+ERLhSU4N7AQAiX1Djq2pwNsPawHa/wJxjxSIChgrHkZvQylnPwFdnDV2IMQAWXseHWozYoYC7SAq0Py89wWRBrHwJy25+uv1KyJYwGWxQ3pd7DVlYR2A+XjIVV+BpxGyJiz84zev273QnAt7gFq5k+QxzLO36kfHXXzUVLFqL+sRSW0sX9G4XRbRNlF6xMuAyi1D0mhocSkHzD0MM1u/wV4XmIylCMaKHxisv9WCZEkgejV1HwrVLAZSeOVt3Rn3TBBYuUV13n0gpC3AxmkuWzFlANj8lNugHw6ynHnLK+hDhi1XIPNplPgyXuYqNyEWJaLXMkwADEPJvAMCHIHute4ocou1eJF+HV5bMnfXoWjpUq9K4xVJfQJYoEJRjE8SHmruKggQq8iNcm05JkHTGxQJ4wkJd3xicy4ZzAD4J3t14+C2pdad7ozJh
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cfc95129-527d-4feb-563f-08ded2a5ca72
X-MS-Exchange-CrossTenant-AuthSource: SA1PR04MB10065.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2026 10:37:44.1854
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5fHc5zmi/9sVR0BrwfwXz+JnUc/i0GG3Kh+QwQNeh2G/kjquLvS1Rwqn+q3+s9dwowIqg3YZVwFkGE/1/ixrQBdRER3fCfJmTfygcxX239Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR04MB7395
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260625_033748_360417_9023CAB7 
X-CRM114-Status: UNSURE (   9.83  )
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

On Jun 19, 2026 / 10:33, Shin'ichiro Kawasaki wrote:
> The test case nvme/060 fails often due to a couple of expected errors.
> One of them is observed for all transports, and the other is unique to
> the rdma transport. The two patches in this series suppress these two
> expected errors respectively.

FYI, I applied the patches.

