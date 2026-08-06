Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3286CC55ABF
	for <linux-nvme@archiver.kernel.org>; Thu,  6 Aug 2026 11:31:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:References:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=BsfA2Y06hVQuTMO9CsDsah5zYFYphdza/aLwv2Swef8=; b=e3NKuOX9NE0h7edaF6FmZxebsQ
	OP5RfwW9+0Ucrk/+JGc8H9QawtXom1PihtvO3cFVhcNgYFCplYNypDmnfAst7KdptjX2bxvmKpBU+
	R7CC+sD4UU7EcMLGUGKSvlCoNBw5cVw3OSw8DTRFcvPp1Cl6RV1wAUikKsb8+t3OxPu7edJ3ZIgwS
	h6uTXxlUVyfjaMnJh2XS3+7lUvcMIcwKacUQE1hZnFiu93eQPpRWBh1CGAdYnKP4ZZQwhGzoTzRvC
	VCgiOCUHpIRzpUMEMpAMNwBcq4Hx1xzqSB5VQ9BA524OUidGjVjJwa+JLVUcqC7cUjKEwq3fkescT
	jdcAJtJA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wrwJT-00000005eok-49jJ;
	Thu, 06 Aug 2026 11:31:03 +0000
Received: from esa1.hgst.iphmx.com ([68.232.141.245])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wrwJP-00000005eo2-2Ihp
	for linux-nvme@lists.infradead.org;
	Thu, 06 Aug 2026 11:31:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1786015859; x=1817551859;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=rGfaHesboS08w5p18xm5kJ6OtJJ3UFWB+qTk65Wspx8=;
  b=fTGuz8vQPWoowcxv6DZtfZhhMFOSTCtO+tg1pTlCz7hJve/UumqB5IOC
   xru4i9Tk3SAg8CqhfbzPG0wbFB5Cvzn8F+z95pS0IZAA2xslJWcpVW7Pi
   +/B7tW/J3ges3joUzPhU6qINGCO7zK86K4sPIP7Swv53inq0iTpoaX4/T
   JguZ9ThL09XYJTgtXet4FyXefnJyE/R6K5wuEt0Z+b3nId0c2+i/V4GIT
   6tyGHmp/urtQ4Hv3CFadFKS9kwmTFY4lrrfYi88zoJ2eZriA9nAojU5kZ
   HjE1HIjA9XCCyGUQLxoWSRQdUgkK7oD3tsE0b5Z16u+JDFlevLTQY20PS
   A==;
X-CSE-ConnectionGUID: kyMgswNPT/OstHlqMUU2Ag==
X-CSE-MsgGUID: jIHDHANnSVSrsjYwu9fSIQ==
X-IronPort-AV: E=Sophos;i="6.25,208,1779120000"; 
   d="scan'208";a="152328563"
Received: from mail-westusazon11012012.outbound.protection.outlook.com (HELO SJ2PR03CU001.outbound.protection.outlook.com) ([52.101.43.12])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 06 Aug 2026 19:30:58 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YblPETnxaBlce+UvoxA2ec/dlNH7wxbguBrOl3l5ZT4L96xJRLjSDiTi4otqNKEPWa0HDKwfnLoAmdjOh9UD5MFspArwDFbiWgN3/E5jX6McxmfYMoXmgYot1yCScz+oiVJBslgKYooXHKeI2PHzCuKvGJHPZV5vuYspbvF6LPc5VgqbXM1OtbGm4be0Qs6TX7G8Bqd0zCTwaUx0+vzTZ6dBeaLIAFx4RHG6IfawHMmU1eTf/9LjZBWFJY2oqB+4r0qYBuxowlXR7GhpUDJDVG8Q6/5APcb8tw1Kl9A0vBjXYCg3g7UFjLu94NNyNDLeii5PX7VWy/I/HQAzvZ+c6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BsfA2Y06hVQuTMO9CsDsah5zYFYphdza/aLwv2Swef8=;
 b=CdzrFWsKvdglHhGhkABfSpj1C/Aujnqxn+GFeBl2PktGgc/34gsY/Dbt7lLUAnY2z7ROj0wi3Yl+vZjzDUjwNGaGTtie5IHWGgmz3MjsWMwqF2chIfh+ePi1T8zE8JaXEzMZa0NmYjbxpNmwv6hY7q3Z1WtWZgFrz7W9ao6W8AhAb1tYYmGzFTaHfbn5r3LBAZI7RuKdgYww/n1PB5PbaM0ib6qxE3t19xluFoHAZfSDalfweQ6ftTc/+q+BI9u5RWUjjjJjpwkflQj9NvhhOVnVYF6Rjixx4Bne7fUKbT/zbVcgOxU49qBNhBK3oApDoAsAVyi7R4oVsdnEfiD0Xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BsfA2Y06hVQuTMO9CsDsah5zYFYphdza/aLwv2Swef8=;
 b=S0dhOLVWca3DoSe337hv2mi1XtNBGbIkAVhJVYKNsWdLjut/GFORumpoDHZCvXKjSXbh17OjIqentU5yycKsr4ECfroljg7eAMQyUSlvy7z3Ct0Z3AI/cOIkzc849pZnDev1439VsZeu/kciIKYO1jdJvFvta63a3OrgJRMZ73w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
Received: from DS3PR04MB10053.namprd04.prod.outlook.com (2603:10b6:8:38f::5)
 by MN2PR04MB6944.namprd04.prod.outlook.com (2603:10b6:208:1ed::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.21; Thu, 6 Aug
 2026 11:30:56 +0000
Received: from DS3PR04MB10053.namprd04.prod.outlook.com
 ([fe80::faeb:7524:f842:9f3a]) by DS3PR04MB10053.namprd04.prod.outlook.com
 ([fe80::faeb:7524:f842:9f3a%6]) with mapi id 15.21.0292.019; Thu, 6 Aug 2026
 11:30:55 +0000
Date: Thu, 6 Aug 2026 20:30:50 +0900
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: John Garry <john.g.garry@oracle.com>
Cc: linux-nvme@lists.infradead.org
Subject: Re: [PATCH blktests v2] nvme/068: check module reference count with
 patience
Message-ID: <anRtGO3CBTh8Sjxj@shinmob>
References: <20260806033146.2067433-1-shinichiro.kawasaki@wdc.com>
 <57644cf9-ecce-4829-b7eb-82375960946e@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <57644cf9-ecce-4829-b7eb-82375960946e@oracle.com>
X-ClientProxiedBy: TYCP301CA0059.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:400:384::19) To DS3PR04MB10053.namprd04.prod.outlook.com
 (2603:10b6:8:38f::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PR04MB10053:EE_|MN2PR04MB6944:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d27a23d-2581-4bf9-79f9-08def3ae2e07
WDCIPOUTBOUND: EOP-TRUE
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|23010399003|19092799006|376014|5023799004|11063799006|56012099006|4143699003|10067099003|6133799003|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info: d/gKIr38QKnVjnmp7A/5kPD6a0s/uSUIwJRvJZCAGvUUBxXaZG8fGk7BeDAUnA+fQrsf0vT+pM66imWNK2nU+6bB3PcsZMniOsSrwRcpFnp498vDpY0Brem7AyfCk4UcklAhGxeetJUOeIleEFKgbrjSAzKLhcbbvlcBGtAwO3c3FE73UwwxwZLeh+vHDzVsL42xzFm3qCuiFp91oJtY60/IayYLuC2Ni86Z4adImBYt8dWFPZgxQ56f7tn1g31YnGsjksImRT83AiybUh1iTi0nyPr34IIJdaFV2X0sa9BmcZoOOZrN5wMfBtmjvsSSu/BSgGQHLw3pHZUmosNmDVW6UVJx9Eou6YJeYJKLBPPsSoDP8rbfE5D4NcJmXEPLqJVJRivpaYHty3/ycMp6c06pQjJlbC+6Le8vK08dvbKC1j+dKcGArkictcOgMaaEpPGSrlCH00O7o9TVmv31Es5EToeieKY3tbSeBrBFMW+D5MpevpZXM33YPrzYZCguD4juuxlWLh5saIkwTn8QB+LX5uM5PQTy1eWI4NX8nYdSegfPbeQz+rZn/dhW7L0qgX4vlEI+M2CfSRT6tPcUn3SlSDQ8PnS5G2t+uxZHvglMjwICyjInc6QagWP2E26zlAW3jARHLY1m/DUhHCD0G1xRU9202a66lWgqreASrrk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS3PR04MB10053.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(19092799006)(376014)(5023799004)(11063799006)(56012099006)(4143699003)(10067099003)(6133799003)(18002099003)(22082099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L0Z6bitNcjJqL0hXdzdHanF1OXdFZzlDZldTT0kvRTdNYzR0U0hScUVLQ0Vo?=
 =?utf-8?B?Y0dRNXViVGkwcktMeStESkhRT2daSTdVdFN3WWg3djBENnVsZ1FrbS9Rbk9h?=
 =?utf-8?B?N0xOcC8vdzRtL1dKZHBzdTZYbm1tS0NhZjBxOVZPL1RvTnN3RjhSMUFCK01x?=
 =?utf-8?B?bzhhWVR5Zkx4cHFadkRKbHFGTmtJQitaOWhuK0ZFcGFacWtlWGhQRXBiOVpj?=
 =?utf-8?B?ZThMQko0Z1QxbEw5dzM4NytXaGJhbmdRSmZoWkx4ZW9vSTlrR0ZCNHpHNno4?=
 =?utf-8?B?MUdESmErVjRsNlFhK28rV28yNnV1OU1RR1VDL1ByODBkRGRZVnRmeTBHbnhv?=
 =?utf-8?B?alZCd1VFTnNSRjErRGNxV1lUOGFPTEpVSlRFRTRNamlIOHVXZjNLNEphM1Vt?=
 =?utf-8?B?L0s3Qk5CbmRJMUJCTXhKemFlQ1pNQVY0WlNnS1U3N0FyVnJMWmRBdEdnV09k?=
 =?utf-8?B?OVpJWDlITE1icVBvb3JEUUNSdW1kR2hmNTdSc2h0NHZVMVdNRGRxRC9BZ3ZO?=
 =?utf-8?B?MWw1STR0QnE4NFVQNWo2dVpZb05JRUgwbHJNb01ucHA4d0ZGTXZOay9KRHhU?=
 =?utf-8?B?Z2d6cXhMM2kyNDJnbGl2K3k0NW5YakNjdzF4bHZHZGM0L3BHdzBWa3ZOejlM?=
 =?utf-8?B?emtuUWtwRE4yWnNucmxqTmlQNjd4dy9iQk9HOHBkYXFUd2ZrYnNXYmQrSVJL?=
 =?utf-8?B?cC9GbDlCNTl1NXBKcldNckEvU3NBcU1md1VGYkdIZTNtZkFycXZEdExOcnE5?=
 =?utf-8?B?OXduRWR6amE5VENKdTE4b2cyZFBQTUZzN1NjaEVkcU9GaUdCSmpFZGt2eEdI?=
 =?utf-8?B?REhScDVFTktMZEZSWS9HcnAzYWpNUHdaVjMxVWh4em9tNC9hSEw2cGE4VmFt?=
 =?utf-8?B?MkZydzdZbTc2VmN4azl6cHM1U25VM2hmR08wNlBpcWJHdjRsaWVyTzhSWnFF?=
 =?utf-8?B?RWJoZDl4Z0VIdS9PRkFFNzNHQnFYMTFzVGJ6aVpqT2VnL2laZ3hRc0gvNFNn?=
 =?utf-8?B?dllUTDVMUW1obTltcThLcDE5U21rSWozMHQ1OGhWZXJRaGo3dFdnMzRaWXpa?=
 =?utf-8?B?ZnZOYmZyM0h2MUdSR3J2bkgzY0R2ZHMwQnF6Z0R6RDNBQVAwNlpBTjlWSnJz?=
 =?utf-8?B?UzRvKzVqazRxM3E0ajMyY3B5Yks5bGdMMitGUzhuMUl4bDhTb1FNcmgyN1Zh?=
 =?utf-8?B?cThWbWExYXF3K3VlMmltSVZPVGpMcHVYSFBIUEE1Q1FxMFNCM0JkMHNnVXFp?=
 =?utf-8?B?aENHSHFoYm1lQ1pLU3YwZDJsQnQ5cHppeFFFUDlJdklvOFloMVFnbnFSeVA3?=
 =?utf-8?B?aHpwSGtWcVMxRkhXdncyNWh4eXlhSnpkVDV5cFdjeng0bFJ2aWVmci9xeUU1?=
 =?utf-8?B?dHA2V0NETDJEakxndGd0OGd3dHVtd2l5cWg0bVBCV2tGZFNnS3dtbDM2OU1B?=
 =?utf-8?B?NUN0cmErcWJ0bFJNb2pheExzb1dkK1E3b3BGbFZVZVBwQTNMZytRODVMb0Nw?=
 =?utf-8?B?U2psUU5zRWpubCtkQ2RaaHhtSjFXY3VUaFVXSVNZd2pMcm9oSitrNXBwMExW?=
 =?utf-8?B?WnVjNFdlYlc2UE12RmtkSlUyY2pYUWdoSXRlai91Y1JtTXZGUGxxL2FkdEtx?=
 =?utf-8?B?RWtPZDJKckRodlFMdHJpVlBUSzBhUTJSbmhhU2tQbHVnaHFjbnd0RThySjht?=
 =?utf-8?B?aFZqVGJhU0J2ZHR1U1VWcms4dTJkaFFQRmRCcnFaNHphdzRzc29jdVRYUDNS?=
 =?utf-8?B?V01WSm9VMTNDTWlNbm5mNnBrS2pSV2VDNFZlY3lXdnovSmJobVZVOFEvVlpv?=
 =?utf-8?B?NTZ0dTBVK0Z1WElqdUJKRHc2cHEzVDQ0ejNDNFJWQmZVNy9SSWE1QStKa3E2?=
 =?utf-8?B?RGlIbEZPYU4xamZlb0NZMytEKzI4MWdiMmRicGV0TVdjTjNyYjJlQVlrSWda?=
 =?utf-8?B?MVBNVk5oQmxPRXJzZjNrL1g4aUxmcFJHV2JadXlLTFlibUlOWkI3SG02bFhJ?=
 =?utf-8?B?cFd5RXZDYXFsamxmalZFZkJ1N3Q5cDBDVEVVSjJXT3pTb3FYdkJQODlCOHE3?=
 =?utf-8?B?Uk1pVk80cFhCUmpPZVlwbzFycytwSERhUy9veS9TV2pLV04zOStmWGlkYmxY?=
 =?utf-8?B?WmprekRBSjlPK0ZyR204SHh4dFNWWXQ5ZlZHekZ2RngwYkRTa0FGT21BS2hV?=
 =?utf-8?B?M25aeG1yNmRUak5hY3p2ZG1LMmFOOTA3QTU0WUpWcW9aaE4wQjNac3hsdXds?=
 =?utf-8?B?WjFpQmpReWd5Vm5nYThMT3ZQSUpiZlpzZlhadzVMK2VDcHc3MmhQWEdTOHdm?=
 =?utf-8?B?T3VPdnpYQjA0aHhQM3Iwd0o4eFlYMVlveExjOUtKV0RuVlFuRFRodUphV1Vn?=
 =?utf-8?Q?fzeukmyBAcPubv+8=3D?=
X-Exchange-RoutingPolicyChecked: FywiZZ7VC8xQctjlNLJlx5SPN6eP0mDOYL9+DVefW5EHgnRt41bMvLzPaZFRvGuSoP/1liGZOvgsSodQxFkHIrSxJmZTwIOY+PDTJjz4A2zeDOKNTpvievhw7A2mfKx8l/28IxT2ST2YQT34nU1BXn03aJsfFMvIiGalCnOym1o4BurYl7HVhFj9ishFB8cpYDPU+1e/oa7PTLONcvq+50ZrcaLuaOZL+W4XYi7e9LAumB6/49Dz+Z3wfgP5HK8srwsYUNKdu5ocFL7WlT1v3fq4BDoi+gXo8jIxaR89IpwRSSlOWHMdLPtyAeH8nBs2TbS5OM7EFQo+nDzaOmMrMw==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: WebpqNkJB2egiiA99yHcy4GYYb2U7NcRrfhTr+/L5SMi26FfdD+ofF5GlnZ9MRgduwUELRQPaQK8Vu9KFa4UgGk34xmnLxShNZlIQ5slS0u21CELdEuuNWSQROVsu6GfdxJkuNM+1dORFPWVqlPWxD21iLMZz+8hgA2kqUpp2gBauUCuEuFSBwqlii1lscQPICOT1telNGVvdRVNs7Ri7kQzaFVqE70H06Zo+ZF95gQjpoSy9s5ajKjDiIVjSucOjol/aLVi6n2nMw2wzBU++NPttPmbngiBQLcHYrXIjRSPvD8c90LeMU4T2DS+GuqNPlm0TT3CBTN/2J2BtjwkkRvwoXfkDdWWuLZbzJwEnF00n2NvgEJQlpc6JJ10+pmbey6y04b9YbBvd/o40A6asuoh/suxrZzpup3YhZLJ1O+6bNXyhaSuki9d+edOXfqdTsL47IFYslZY48YrEwRrQjNYEQIVX+b8NskzP/hi32d+jOfEgi61Uolc3z4vHT0Q/74yqhHP53YGwNUeYFt8hQBworBMbqkdM/Q6XCe+cEVKNKAuEYnqpS5MbgAatktXJ/atJiVru5aHELgqNAi1at10dLa8wpTA18+Cx17TUKWcap+g92sySU7fKpdksLIv
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d27a23d-2581-4bf9-79f9-08def3ae2e07
X-MS-Exchange-CrossTenant-AuthSource: DS3PR04MB10053.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2026 11:30:55.7621
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UNJ6DWbRD4l6r5FT9Zb86paPNkAWVpuWBg1Ss98tmEB5blc7q/fHiWm9fCdL8JPTT62AKg1K1qnz8PsrMvorR91tz7A45qc4EVzRLZJQn10=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB6944
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260806_043059_637615_32B1481B 
X-CRM114-Status: GOOD (  33.88  )
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

On Aug 06, 2026 / 08:24, John Garry wrote:
> On 06/08/2026 04:31, Shin'ichiro Kawasaki wrote:
> > The test case nvme/068 fails depending on the system it runs on with the failure
> > message below: nvme/068 (tr=rdma) (NVMe multipath delayed removal test) [failed]
> > runtime .. . 11. 357s --- tests/nvme/068. out 2026-08-03 17: 24: 32. 394566266 +0000
> > 
> > 
> > The test case nvme/068 fails depending on the system it runs on with
> > the failure message below:
> > 
> >      nvme/068 (tr=rdma) (NVMe multipath delayed removal test)     [failed]
> >          runtime    ...  11.357s
> >          --- tests/nvme/068.out    2026-08-03 17:24:32.394566266 +0000
> >          +++ /home/runner/blktests/results/nodev_tr_rdma/nvme/068.out.bad  2026-08-03 18:15:17.461243816 +0000
> >          @@ -1,3 +1,4 @@
> >           Running nvme/068
> >           pwrite: Input/output error
> >          +module refcount not as original
> >           Test complete
> > 
> > The test case checks the reference count of the nvme_core module. If the
> > count is not the expected value, it fails with the error message.
> > However, when the test system is slow, it takes some time until the
> > reference count gets updated. When the check is too early, the count
> > mismatch happens. To avoid the unexpected failure, repeat the reference
> > count check.
> > 
> > Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> 
> Reviewed-by: John Garry <john.g.garry@oracle.com>

Thanks!

> 
> Just one comment/query below...
> 
> > ---
> > I ran the test case nvme/068 with the patch using the kernel that does
> > not include the commit below:
> > 
> >     3f150f0f010f ("nvme-multipath: put module reference when delayed removal work is canceled")
> > 
> > And I observed the test case failed. When the kernel includes the commit,
> > the test case passes. This indicates the patch does not break the
> > reference count sanity check capability of the test case.
> > 
> > Changes from v1:
> > - Per review comments, handled empty "$refcnt" case and explicit 0 return
> > 
> >    tests/nvme/068 | 16 ++++++++++++++--
> >    1 file changed, 14 insertions(+), 2 deletions(-)
> > 
> > diff --git a/tests/nvme/068 b/tests/nvme/068
> > index 4aee95b..cab57cd 100755
> > --- a/tests/nvme/068
> > +++ b/tests/nvme/068
> > @@ -27,6 +27,19 @@ _delayed_nvme_reconnect_ctrl() {
> >    	_nvme_connect_subsys
> >    }
> > +_check_nvme_core_ref_count() {
> > +	local refcnt i
> > +
> > +	for ((i = 0; i < 10; i++)); do
> > +		refcnt=$(_module_use_count nvme_core)
> > +		if [ "$refcnt" == "" ] || [ "$refcnt" -eq "$refcnt_orig" ]; then
> 
> I thought that refcnt_orig was local to test(), so I am unsure how it is
> accessible in this function...but it seems to work.

This is a bash uniqueness. Here I quote a relevant paragraph from the Bash
manual [*]. Some paragraphs follow and explain how bash handles local variable
scope.

  Variables local to the function are declared with the local builtin (local
  variables). Ordinarily, variables and their values are shared between a
  function and its caller. These variables are visible only to the function and
  the commands it invokes. This is particularly important when a shell function
  calls other functions.

refcnt_orig was declared as a local variable by the caller of
_check_nvme_core_ref_count(), then it is visible in _check_nvme_core_ref_count()
also. I used this feature intentionally, but I understand it looks weird. If you
like, I will update the patch to pass refcnt_orig as a function argument
instead.

[*] https://www.gnu.org/software/bash/manual/bash.html#Shell-Functions

