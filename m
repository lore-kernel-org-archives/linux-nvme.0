Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBA1CC43458
	for <linux-nvme@archiver.kernel.org>; Mon,  6 Jul 2026 12:57:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:References:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=EkCpSQbj/vKj7iODI0w3SE65J8NxcMgr1lvuYSYhSnc=; b=xSmQfRILcLzW201qYXRBYXi4zO
	IRlmjimuPrtD3BydKdKPMo1kSZbGgIjzH7OWmikdPKcjFz6J371faO9Cbzngaw31fPBOBs5yMhJoI
	xllMnDlZEpfb7wN+30ZERB5ls0nkD+eqPfFFOzh8dtvQHXp3Ai7pLrvTTdu3KPdyVbqCFENCWG6l9
	gtB8MxJHuOeo+hazv7LH3TfoWC36wwy7VKLLIXEorwTxo7n9iVaL8wzMBfYyja0sQj6H/GkB6osZJ
	bZcyA42bJkwLyS3meaMhQcjUhEwuoaT/nTSFgqjb/HUSPMvGH/vyJ4h4Jz9ciwBQl8QsTnJJxgL89
	bKxl8blw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wgisw-0000000CVyz-0WPD;
	Mon, 06 Jul 2026 12:57:18 +0000
Received: from esa6.hgst.iphmx.com ([216.71.154.45])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wgist-0000000CVyd-3Bjk
	for linux-nvme@lists.infradead.org;
	Mon, 06 Jul 2026 12:57:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1783342635; x=1814878635;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=MwAB1D85ST8QXdQ4kMc/274u/u5AgHXew5j/7UA79Ic=;
  b=kXtcW+jXZtpkNM4l1BjL0Xcn9q2ZRLjYzb7Z+UgBPBieD7kTJvEY6j5M
   59Ijgg6NM3MPIU49jJcSb/EwQmTzMpkERm4fuad5DNlYvH5sd6tH+CgR0
   Ai9Xi+49YwBjr+rqWOO8ucAt11F+Sfffh+a/U1FUcDbekN6VzbCvi8v9m
   jl62e2HSUeS9jZZrY5bRtDRbOXyBB9ZN+SYJscv6y5rTYz95qdCx2f1GE
   9DBgX3cX/vKPMw+Ni1k2xfa4/FExXTrWO9NlhMckJea5tS2Li3tVVQLGj
   0JRdu+c9t7Llp2P0JWJbkFrqV7MSZ6auX7gq3CSxXhdmHaK7QDnK3BDIc
   Q==;
X-CSE-ConnectionGUID: Ql+Sx8GGSz+XZ+t/YKIUFQ==
X-CSE-MsgGUID: BOq20736R4aO2CykLPF3ag==
X-IronPort-AV: E=Sophos;i="6.25,149,1779120000"; 
   d="scan'208";a="148937906"
Received: from mail-eastusazon11012050.outbound.protection.outlook.com (HELO BL0PR03CU003.outbound.protection.outlook.com) ([52.101.53.50])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 06 Jul 2026 20:57:13 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WvDqICuuDpyOs/g8Pse9cual3suki1rfU7oP1ACLLDhv+lAsb6mnf6OebEuLLFA8cZ08Lzestmmo2hLLWW5tL6psr9sNXA3m/SafatPBcLMJHLNgEQNLW4jAxejDcWSh0kzZHUSOnyMOV/HgiQdJhX3ZefiRREQlnBwE1QBnrCTaSep6RIw/9Rh9kR2wR8UAy1D8iMyVjyp/h5U0cW7k3IEYHEPRKPLKSUZ5iaxBUKXLLZSqR77833IsaavKJXIypfvVN8z/Kn2CFtSlKeBtg6i09xPN05/FCgzR/r+hGIZuinGRMSmp13UMHNuAP8KKMkQooDI8MDj5y8a+97n/nA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EkCpSQbj/vKj7iODI0w3SE65J8NxcMgr1lvuYSYhSnc=;
 b=UVrI5fFg8wU4UhokKojSFqqtbIYnaoAVzrIfH1jAoANUW8jGonfaE9DzQz5Ol+q+IGs8PS6FIGKlyvWqXZE+aLC3PIUUKMKmXS4jC12H6oGX0zXdWrU/uY0C24ZFXMJbUeWu5UQ2omgs/Z6rpm7NFfsluzpe86A49QsGJLEYs7NSpOqDNjQJ27kUha67YpUzgT6VnxcMe5c+e9ntmlvplcZj8cWZ+JWlN3OzUMYCCdfFMBvfA1kDnChMvyjrSg8g2yyADgBtxHOrsKYm1CTrqNmQP2yT1pSn/qFa2SJyrXcfqbrYsglXYOL2/qCcqF3YlquY2iur751WbEY4RIzcGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EkCpSQbj/vKj7iODI0w3SE65J8NxcMgr1lvuYSYhSnc=;
 b=OR7MCxBqG2sWwRxgjYYvhDiUrfU2a/uvRkRYAbzpkdtaFolE9djQDBCc6n6zsMscyX2ZbKWSmZK6mlf6xcSuPDPIw+qMs3LERDYVtu10u21YB14mm4aM8qVENpUHITnoYL2mW43ckEiFdOSP2Nkd/XthyIIDqZB7tkNVxCWvueg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
Received: from SA1PR04MB10065.namprd04.prod.outlook.com
 (2603:10b6:806:4dd::14) by CO6PR04MB8330.namprd04.prod.outlook.com
 (2603:10b6:303:135::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.11; Mon, 6 Jul
 2026 12:57:08 +0000
Received: from SA1PR04MB10065.namprd04.prod.outlook.com
 ([fe80::9b98:bf8a:b0b1:ef85]) by SA1PR04MB10065.namprd04.prod.outlook.com
 ([fe80::9b98:bf8a:b0b1:ef85%6]) with mapi id 15.21.0181.009; Mon, 6 Jul 2026
 12:57:08 +0000
Date: Mon, 6 Jul 2026 21:57:02 +0900
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Guixin Liu <kanie@linux.alibaba.com>
Cc: Daniel Wagner <dwagner@suse.de>, Christoph Hellwig <hch@lst.de>, 
	Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>, 
	Hannes Reinecke <hare@suse.com>, linux-nvme@lists.infradead.org
Subject: Re: [PATCH 0/2] nvmet: add namespace-level debugfs for reservation
 state
Message-ID: <akuji5egnkVWM5u2@shinmob>
References: <20260622104418.2070277-1-kanie@linux.alibaba.com>
 <5b2a11e8-bb66-4111-9090-bcdbb0458fcf@flourine.local>
 <f0c00d47-0f33-4c9a-84ea-2fb82cd4d102@linux.alibaba.com>
 <1b56186c-9e5b-4e9a-813e-74e4d1511738@linux.alibaba.com>
 <78c97eb1-a69e-4f14-977d-f3950db1a0e2@flourine.local>
 <551ef1f7-ceec-4e4d-9555-0661ecbcc845@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <551ef1f7-ceec-4e4d-9555-0661ecbcc845@linux.alibaba.com>
X-ClientProxiedBy: TYWP286CA0007.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:178::15) To SA1PR04MB10065.namprd04.prod.outlook.com
 (2603:10b6:806:4dd::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR04MB10065:EE_|CO6PR04MB8330:EE_
X-MS-Office365-Filtering-Correlation-Id: c20df119-7d1e-4907-f8c9-08dedb5e1692
WDCIPOUTBOUND: EOP-TRUE
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|19092799006|1800799024|23010399003|376014|4143699003|11063799006|3023799007|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: CkHrOZsafd5PviHXrLvciySmJHcO+SOgccTgI51IFcM/P9fL8/FRXhrRJZJLPwF/LYMk+yg6ch6uC8ue0StL+8Pvjy52I4ZD8Ac/NxqYDgqqVYHASAs6/NW7KvvxU+0fdCp+i9NC2Ob54rcZGmH6CSgpCfRVB26/93MDq/T/Jfge16K5jk22MOxtmgN8rQzUK3z5qBOZt+8bcvjpCfoacI52VamIdQYp5CqMNwPi01sgo6+vD9WhW5SmHbS+m3/quQYmtVjh07d1He3QADWwEm/XGedIFRy/6rsofBHFM9yhRWa6qwtzjcioS0tuQp78i0uP9D5wxYPRZY5lOKDSR4j0ESNcFaR4Wo3O+jfDO6NuTpGtHzajZp5nZGaPtNhB/Ot2ze9es1amGaG1AzCrZk02EzSPWpwxP22xOPhuVSmtvgJGxO36kJKacc6L9g42knPs7NqCCfxddY2Kgt+pCS7MNB0Oe0xqWPUjJciZljYHLrrFSSpQBe+IAvMAFP/mH92kscw+1D+gtQdwW0VbbwTDnAEgFmqNdFZNVWEshZ1u1TvOQ2YOogp8lxYIWNUerQ8KTlcBAkrZl4tH/n6i9dlTBOHB8xbfNqXQ0hkArMD0QcYmXN/xTjAkmBa+G1esMRWdxElHruq5M64ZFSofPxP5DyRNOfxTysRO85sPRNw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR04MB10065.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(1800799024)(23010399003)(376014)(4143699003)(11063799006)(3023799007)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?enUrQnVvTzhkVG9PdWwvRFhzVm15c1RGTVY3NWhreGd3WFJqSmVpQ1UrbXBH?=
 =?utf-8?B?TEtVaDFIZlVnOS81c3pKV1o5K3NJZ0VJOUhQaVkwVGNHeDdGRW5YcVBKME9N?=
 =?utf-8?B?a2pTcUp2VUtIVjBiVmE2T0UrbTlBOVdka2pVL3V1SnlGZGxQOERXeWlnakpq?=
 =?utf-8?B?UlVDeEhtNDBDK1RhaVdKNjlYb3pXbk1adi82ZnA3c1kydVZnbTNsT1p6c0t5?=
 =?utf-8?B?MTQwN1loRCtTUXlIekpGVG1vaXRqUnNhVXlkVnZXOE93Zm1HRVNEVTFiTlZP?=
 =?utf-8?B?THR2MXRnM3ZnVjQzL0JPbnRLREthUW4xbWFRSURBVUxyRzNuSWhuUDRERk5K?=
 =?utf-8?B?SVNLaityWmZSbDZaaU42NHQ4KzRFcm0wNnkzbFNrUjQ2cHFGRkYzbFVLTnZo?=
 =?utf-8?B?YldsR2lkdmtPYXZjODBwelRHeStWNlNhYm4rTmZPUVI5aHFPV0VoaTdndmwy?=
 =?utf-8?B?R2ZDZjExQ2szaklVQ1FoejgzWmJya0JtcFJLT3V5YmdYeVNoTnB3S3F6SUNu?=
 =?utf-8?B?enVYWUh6V2RkYzdtMTJFN1N3b1ZlblBKbWNRekxsY1JCK21HdUhocXJ5QzVI?=
 =?utf-8?B?enFTNWxSdGlBUkpMdGtSVmZqVzJKOThoVzY0N0ErbmZLWVI0Sk93OWdEbFhH?=
 =?utf-8?B?M1RjNnBMcnNTbWtQM1hPSkM3clBPY3hKdnlTN0ZGd2p5a3k5dGhZYlFlWWl4?=
 =?utf-8?B?WEJldkJLOFR1d3d6NmhMcFRhUHprUXhTRUUycUxyOXo3bUV3SkpkMWl3SStB?=
 =?utf-8?B?S29UNmFBalZVZkgxRGEvWXNSUmJ3d1ZmMERDOTVZUnRFMjBWMXU0RXNzUUEr?=
 =?utf-8?B?K2l1ejE0dDM0K0x0Vm1KZGtMNVRrSytvbkhSRnllRnp0TXdnVklhVUlFM3Zk?=
 =?utf-8?B?Z0l1WFZEWmt1V0NmU2orcG9FUUZ4dFl1WXMvK3VQWS9qNklaN3VVMnJmbWFy?=
 =?utf-8?B?QldCS0xrL1JOOWZWWDNHeFpES3hWZmRtNmxCNjJOMHVCR0hHSzM5cFYzMDFT?=
 =?utf-8?B?dzRRazZZbFo4OC9LTlNueEt0Ylcza0tKSjJLNGtITHRPdFVHQTlyYnYzUUdD?=
 =?utf-8?B?RmZQNDN3aVYxc3l2NTJuNVFCWVZsR0dpV0s3bXV0SjExcG5CN1NEQktjWC9N?=
 =?utf-8?B?Q3VsdHAyK3Nxd3dROFo4a1N2NlIrQ0NtNlo4Uis3R2VBM1FoV3hJRnRjRGFX?=
 =?utf-8?B?UzAzMVZEVjV1WG1wVzVsWlBxSFkzMzl6WnpLajBpd3IwTi9odkErSiszSVV1?=
 =?utf-8?B?ekpHV3BIVGd5NFZhelVhd3NOTHJDOHJYVWxIRncwOWZZSkhra0RjVkZURTQr?=
 =?utf-8?B?dS9uTWx3cUo4WHRBbTNYNFdFRzhLVnNVWkFBOEVCWHd5U2ZtcVp1Z3dXMFd0?=
 =?utf-8?B?M2JEOXltL3NUU2t6cGR5bHlsT2FWcnZOeG5oU01ZT0hxY3hldUM5ZWM4R20v?=
 =?utf-8?B?VXB2MURSMSt6dnZFS1p2aWlQeUQxOWhLVXRKQlRndUR5UTlJblNOR0tma1FN?=
 =?utf-8?B?c0M2Q2daYTIxVXZKWHZGbDlnd2NZOWQyWXNLMURHRmZOZW5oc3N3Q1dKbHZ1?=
 =?utf-8?B?K0RPQTVocE9UWHlFVzVENndEZ04yanQxRDJOeTVyZFpHMkJndW05b1RkZnBP?=
 =?utf-8?B?dGdSTjlET1dFRHZ2a3ltd3ZuNUhyZ2JVaDJsUHVrSlVVWDRPWVBXb3RkWlgr?=
 =?utf-8?B?UWNWalp3WTB0azRXUlJtQVFvakl4cU5uMk9GVTV1NFhTWHZjSWFya1E1MDI4?=
 =?utf-8?B?QnMraVZLdHdLTFZXOGhzOEo2NGhXbHU4WDB4dVNQc1dpaWRxYzVEaXRHREcz?=
 =?utf-8?B?U1pzVkc5WVNtQ1B1ZGNyUXcvc3dmb0FaQlZQTHhGVU1nN1J6aUVsWkk5Z0Fq?=
 =?utf-8?B?cjBUbDZXMDFHWXdPK2VnUUhhenlTSmVUTFJYbXhjMmY3eFc3dDBRVFRwS1RN?=
 =?utf-8?B?cHltYS9EbTdEYW5ESzlzc09tbmp2djB1MlFMQ2hZT0xxUlZCbmFqTGt3SXFk?=
 =?utf-8?B?YkhrMXA4SUJzK0U2czBSYmI4VjcwaU1Ub3dVOXVrYUdsUnRLWjhWYTZES2x0?=
 =?utf-8?B?bXlXdXhEaDBYVWRuajdIY2ZJM1l4SGp3Z0p4WkFCKzdnbHI5cGgwR0JrWmZX?=
 =?utf-8?B?dnM3bnVkNXpwL1JuOVAyOE1pdjdwK3Nwb0NGWHFWeFEyU0g2RVNnTzlaUTVK?=
 =?utf-8?B?QnpPdVBrVzBQclhNb01xekY2a0RBSFhRdyt0MzVXa3ltOEV0dXFaTndCUEpQ?=
 =?utf-8?B?UVFvdXkraG1pU29nMWQ5YUZIYlU4Z1RyZEV5Q1dhN3UrZW9vM0hsZTNSQjV4?=
 =?utf-8?B?YnlkUnd3VWh6djVjbER2YWVVUTIyRmpuWDlVY0FWWXBlNnA5aWl5MkZLNTU1?=
 =?utf-8?Q?15eh97PDks/AK09U=3D?=
X-Exchange-RoutingPolicyChecked: FEZHMmZ0ANosQjyDwwV0k6d+NyxmuEtKy74qQniTv0SO+0uOU1rKhUNwYqA6SRaj265z97v2nyBjlNxeyDwMofGpqsardHTPzcG9LpBsBuTyAaLANcFcxWwe85hqkEFyv4Nu+IvDq14pJ7yOMLTgAobybwiAJZQQpja5VPB7K8+N6ZRrbwOi7AYTp5ZfPR4nOmpNhVdnLQBcDkRjZWtmNFJ9OtVVE37eh6oJUo8ITROXrbMreUZHU+Hnyn/B/NWsog1EuRD28CuKEw8rrpvk/JkZH84mxnoJO82olgcnbwRxIYlRsGTtqkMlyvq5VU5leWmg0d+ccoX86tyio5GVOw==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: yENNVAO4ZuSe2A+udE1K115etd3A3Ji3ooTiycse47IciLf1q351jK2qEDb1S5ruIW69DbKUUZg2cDEuUPuxS/yO8X479xwB94yGXaq7mL43OYmc9fwdyVDSSg5K09fKNn4x1A5ZdNKS25b3VVxowKr1SXeTRLmfpFw62lz5ONrJamfyuX/EQJmfI/Z6CVUe4sCQRjJ5fVpDOpmP5y7OB4e6TjO6GrDmLp5aHoA9MsdzLQuCTRMVRN0a3OB4i41cK9oXPvaFIG+0Ekx3cbn9w5x458IXaGrv+DupRQ0WdHjtsc9k1clY2sWtRLg0NhM7C8IUxdAGRCpXaYjYFGh/jKf+qb72YdYR+h4xMdg4xqRuFMNmBf0AxqJEeU/GFDc5KxJu/qCqVUEZsWjMfUnGI1fNbLHlCpdICpI/sqPywCb/J5VBSU+q2qIpT3D+cydDYEiKARLQmELGYA6RHbYhKs6fA1IrT4XiEcgBYHjMWQ7GAM+W4qiUmDgInpjUZr3Tyr4PqdlDLFpQbPa4EwDH9mmr9oY+c034e+0WT5gKNF/Kwbtb+ieFEq+I0IYxVTqXJIjI5KbCtiBBYu70o48m7U7d/TzsO4Rz4UM98kCCdjuCD1+83Dtp+j3B8/hnXBd6
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c20df119-7d1e-4907-f8c9-08dedb5e1692
X-MS-Exchange-CrossTenant-AuthSource: SA1PR04MB10065.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2026 12:57:08.6140
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sPRrznYSG6i1Rqdk4i9OFg/n0X05vToB8L9YARqTUD/X9ADfhWeBXoArjM7Po+3+EWnUNnRyluCpuVghG8llABqGcIPjXz+8tGz+5Nm85Dk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR04MB8330
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260706_055715_888236_5C370ECB 
X-CRM114-Status: GOOD (  21.46  )
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

On Jul 06, 2026 / 18:28, Guixin Liu wrote:
> 
> 
> 在 2026/7/6 15:59, Daniel Wagner 写道:
> > On Mon, Jul 06, 2026 at 11:10:41AM +0800, Guixin Liu wrote:
> > > > > > Example output with two registered hosts and an active holder:
> > > > > > 
> > > > > >     $ cat /sys/kernel/debug/nvmet/testnqn/ns1/reservation
> > > > > >     enable : 1
> > > > > >     generation : 2
> > > > > >     notify_mask : 0x0
> > > > > >     rtype : write_exclusive
> > > > > >     holder : hostid=11111111-1111-1111-1111-111111111111, rkey=0x1111
> > > > > >     registrants:
> > > > > >       hostid=11111111-1111-1111-1111-111111111111, rkey=0x1111
> > > > > >       hostid=22222222-2222-2222-2222-222222222222, rkey=0x2222
> > > > > I expect blktests will make use of this interface eventually. The parser
> > > > > for this wont be dead simple, sure doable but not simple. If you see a
> > > > > way to make a bit simpler I wouldn't mind.
> > > > How about this:
> > > > 
> > > > 1. One holer, multi registrants:
> > > >    enable=1
> > > >    generation=2
> > > >    notify_mask=0x0
> > > >    rtype=write_exclusive
> > > >    holder=11111111-1111-1111-1111-111111111111,0x1111
> > > >    reg=11111111-1111-1111-1111-111111111111,0x1111
> > > >    reg=22222222-2222-2222-2222-222222222222,0x2222
> > > > 
> > > > 2. No holder, multi registrants:
> > > >    enable=1
> > > >    generation=1
> > > >    notify_mask=0x0
> > > >    rtype=none
> > > >    holder=none
> > > >    reg=11111111-1111-1111-1111-111111111111,0x1111
> > > >    reg=22222222-2222-2222-2222-222222222222,0x2222
> > > > 
> > > > 3. No registrant:
> > > >    enable=1
> > > >    generation=0
> > > >    notify_mask=0x0
> > > >    rtype=none
> > > >    holder=none
> > > > 
> > > > 4. Reservation not enabled:
> > > >    enable=0
...
> Hi Shin'ichiro:
>     Does this work for you?

Hi Guixin, yes, I think it is good enough. If this is sysfs, "one value
per file" and "array by files in a directory" would be guided, but this is
debugfs readonly data. So, it sounds reasonable to put some data structure into
a single debufs attribute file. Uevent like key=value format sounds good. It is
a bit wacky to use comma to hold both host id and key for a holder and a
registrant, but I cannot think of better solution.

