Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03C9C606A326
	for <linux-nvme@archiver.kernel.org>; Mon,  2 Nov 2026 10:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=cmopYrVK;
	dkim=pass (2048-bit key, unprotected) header.d=wdc.com header.i=@wdc.com header.a=rsa-sha256 header.s=dkim.wdc.com header.b=gttSC/iw;
	dkim=pass (1024-bit key, unprotected) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-sharedspace-onmicrosoft-com header.b=bXGQn0SI
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:
	Content-Type:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=XMEnP5ZkVqPIGCqlwerbKDGFnfwA35GaLSjrKdvOv+I=; b=cmopYrVKQKV3O2UHs3ZR9x7fcQ
	0zbt1jesw0sX1ri1guH4lGiZc3avf1MzjlknGqi4hAfCzGjKYxl50vRdNEMUn3XQAS7FJjc12kG7+
	Ir/ZdtRgZAg6ChnH0FBGK0c1ri2ROh5KTCzEaQkR1LSrOHGnVjDyNF/Zm4TQZbJOQn9ll9gzJI/yK
	o3HcwoRrmCp8zfrdqlP7wy0gqITEDN0CEAeXH6bOlLECs+baN+KpiO/OWhAV+0Z3dNEBHCtQhrmWV
	uFOs6oYrFxmq5kVX7N5OsdFUM9nwjBP90UDkMu0RB/Aort4Lpu21QeSj1wijokw4uzlMvu362sUZY
	UzBAA1Ig==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xNpc2-0000000GDap-10pL;
	Mon, 02 Nov 2026 10:50:02 +0000
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xNpbw-0000000GDZ6-4043
	for linux-nvme@lists.infradead.org;
	Mon, 02 Nov 2026 10:50:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1793616596; x=1825152596;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=2pkeh0JG9Yq4NZNruH61348xia/HX0KwMqghqum8ZtM=;
  b=gttSC/iwbz/o7CrG0D0FHXRUjBVh4oFmqJHOMjbaENcEFiq12vo8JeIG
   AYNW8f1zH6a07sF3b31gxz0IzwwrXPj7Bi2F/cvJhOZrjh1n6RXIJ6TGR
   wQ89O7S7u82Ccjz1t+UQGCdFGstyWYhReH+W3gU0e3T0r0wVhQBbfWqc/
   Y83MkOKn3TxTG9i9DTLglN41D+w+HOKVlHyxfGqYQPPJlNJYa8i3tvSCL
   UWpfb5simXNTRpmSNWSxldEQB9viWLFX4VAAsoDHVN95Hn09A5oDetQwQ
   DBXvfx424lnnMbdVjx00xIW1S29pOngPwu5h1jl8fjWgOu2Zxqq6mKr51
   w==;
X-CSE-ConnectionGUID: nSnLiXFwRvyh/yvCJDQd3w==
X-CSE-MsgGUID: 1bGVSsWoT1WLKKI1ot5THw==
X-IronPort-AV: E=Sophos;i="6.27,191,1786982400"; 
   d="scan'208";a="158643485"
Received: from mail-eastus2azon11010020.outbound.protection.outlook.com (HELO BN1PR04CU002.outbound.protection.outlook.com) ([52.101.56.20])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 02 Nov 2026 18:49:55 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rDuE+8Yz7yPoBucHe763Ql/tVN79sWbjbxiO57YqlJQRVWMs5as5rUI7GS8BIF5/s2tYA2pwFyWUynTeztQ/jlZrvrB8jUnH1SueZrAvJCifcsII4qKAJIcvhIwQI9v18wyv2VCTYokS0wOvdCz3cFn4RvuZ9ReLjCXBRmA//eG0qDX+RDgTxKQZZO/q73t9YtWVc2Ilu+CxnKCoSuOo/7hJUiDrZLORm700T+VpKy4VZSYWjPUR1ChU1ZpTRiK0LeuyI6u59ovMF2DWKTc6f6+Lvrax8tS7QXTE2KuDFhEBfovloeDVytwDSNadwrv6nQC2T9NfqRT4zsxciucgUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XMEnP5ZkVqPIGCqlwerbKDGFnfwA35GaLSjrKdvOv+I=;
 b=mssEZvJDqPF/lEwVvhO1cssCsJEWj7XxePHpyDzgrG10BOMIRILmRfTDAHFyo7qb80Qq2PbQOxaWZ4PSO+MVCKnPIdF+18gWWMfYqqFCh6iD97ZDtEwEwIniw2STyQVkLGDefEXl7mBKRLgPq/oq5d5ttJBdMVXEgUP/uI1hlewFabzAaznUx8uA+gvXGP1Vehwp5igmfE74UfR9q40IRoKxuZXR22XsV6nt37hLuJ11ePuYaR2TYq0QhxwAEXuKHT58K+mhSF+OMiivnVIIeV+S01I3SCat7DyBZjySN8Cl+8/dDhgccKq4eHE8R9TW5ej2CwPdW0f/xtgGJDVc2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XMEnP5ZkVqPIGCqlwerbKDGFnfwA35GaLSjrKdvOv+I=;
 b=bXGQn0SI/eFCGaZ4h3aa+HAzK9EtsbqjEY9CO8JrH8ufBrbP1+x+crp1EMXFox9fTw9xqpef2NOz+7TA8NRdk+Q/EkU21L1D8WbDq/Vlsqbu7Gr9m4c08u6oKb6MsEh6xDWPFTo/h2drApJmiWn1A4uzFMirjzSaJc+DGpAhyp0=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
Received: from SA1PR04MB10065.namprd04.prod.outlook.com
 (2603:10b6:806:4dd::14) by LV2PR04MB994160.namprd04.prod.outlook.com
 (2603:10b6:408:3b0::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Mon, 2 Nov
 2026 10:49:53 +0000
Received: from SA1PR04MB10065.namprd04.prod.outlook.com
 ([fe80::9b98:bf8a:b0b1:ef85]) by SA1PR04MB10065.namprd04.prod.outlook.com
 ([fe80::9b98:bf8a:b0b1:ef85%5]) with mapi id 15.21.0569.011; Mon, 2 Nov 2026
 10:49:52 +0000
Date: Mon, 2 Nov 2026 19:49:46 +0900
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: linux-nvme@lists.infradead.org, hch@lst.de, kbusch@kernel.org, 
	sagi@grimberg.me, gjoyce@linux.ibm.com, chaitanyak@nvidia.com
Subject: Re: [PATCH v2 2/2] nvmet: fix use-after-free in passthru I/O hotpath
Message-ID: <auhpmq499RVE9YpC@shinmob>
References: <20260929112751.2985483-1-nilay@linux.ibm.com>
 <20260929112751.2985483-3-nilay@linux.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260929112751.2985483-3-nilay@linux.ibm.com>
X-ClientProxiedBy: TYCP301CA0064.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:7d::16) To SA1PR04MB10065.namprd04.prod.outlook.com
 (2603:10b6:806:4dd::14)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR04MB10065:EE_|LV2PR04MB994160:EE_
X-MS-Office365-Filtering-Correlation-Id: fd5e207f-364e-4493-d702-08df38cf0608
WDCIPOUTBOUND: EOP-TRUE
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|23010399003|376014|19092799006|11063799006|4143699003|56012099006|261009223027099003|261028144727099003|261022115727099003|261021121427099003|261022075727099003|261026140227099003|261022105027099003|261026121527099003|10067099003|22082099003|18002099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info: MEqv3jjmfsxyznlVEa3BZsHgpdGVN0oqGdPA0/GHPXahzEhq0NSVMrjnnz459CVkz8VZtux6haxmeEt6rsMAu+e4B5b8UcAmdvYsw95EzDV0Wyxi0Yywf9OQ0/94YWAm+W5deOyS04f6In159yHfnDiryfDOPxQQLqlICHs/5y32d7Etq4dctdL/Wu+IKKKqEWMuHSrkrmvqxKRID619kGH75muFoOlwVkKEqXi8x7a6s/L6U76bTc2mikGhzOhKYZZ/NVAbPDukNUg8iqZiV8rKBfUbJk9k9A2ucR1sEPdd5EW96N7VztiuM5ARF2mRCRNmucZKeLz83ZEYm7zAOrrMEJPvzCiIjwIlSY+CRvSqZSQwjaH5ecWoTvi9wfTemoyWe83yWExpLCuczG994fsHcJSl/H9zOPWKpdggZty9a1LvES+9JQxNVLIyS/lsRpcCxa3CprGPAQUS+PLsqVXm9TV/jyuDInyj8ts6eOIADg/T0ygmNDdnglaiYQ4UZ838tjZgbSZUASrRrEoBE2QL0xqbE+ENFhmPiuZ+GX/AFh8kIS7sr5MkoWVfdiLk45nnxE4X3iJJ7QY699tFzg38oTZrAugJC2CYCFknocCnW2TIVIKtkiMXqOboNEqcJkYULKirvLXN7HVfkIOGZ7mERuyAbUd/99IiAvvg8Ns=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR04MB10065.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(19092799006)(11063799006)(4143699003)(56012099006)(261009223027099003)(261028144727099003)(261022115727099003)(261021121427099003)(261022075727099003)(261026140227099003)(261022105027099003)(261026121527099003)(10067099003)(22082099003)(18002099003)(6133799003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RYQ3d+a8KNXuk5GI1Rvn1/D27xhRW/qVEKCH/pngXU5zgjwp8q7mdZ+V5TwT?=
 =?us-ascii?Q?95FhuZXIe1MiGe3K2DB2nAFN4sqF3QYuWCwnrhiDJikXeQeunritBROlq+l2?=
 =?us-ascii?Q?BqgfEDDyoxZj+Urt38hwIzSjEu3otW+HkWzEHoyczlazASnGemrNnCVqWyYK?=
 =?us-ascii?Q?hq3gqqrc63+JMjsi2OCjhGT0ZM1Cm4f7ff3c1cU7iuiqdCHgRNNenY/E9Bhz?=
 =?us-ascii?Q?Kl2Kp0YgLQBgaQN+k/R9bdI+IDXndrdDwbGIBbmRKXH6YR4m3QGomI9SCvNJ?=
 =?us-ascii?Q?YfHirIiRxsy1VDqQo2f1BWRx0Ic+pD5fP4PR4z38cU3MPIuOYNkLqmXtdaOZ?=
 =?us-ascii?Q?OVQivp+1tI34bBHSnUwbHuubKO87P6f874cQul8RA8zwbCpbRk8sIrPU3urF?=
 =?us-ascii?Q?/QslxX/ufVGhpaIu2lFbhVogWI8gPaniMPrKcKZTEWqwLb/G5blA3EKk1iEI?=
 =?us-ascii?Q?tfVzd660auBhGpWfP1AiQvC5XPTh/aJV6B3MljoclDaVTK7v8zcREQUVAnYA?=
 =?us-ascii?Q?CEYUNx02ZFoZekkED57sRd1bQqjFUzdIn/6WweQbrE0WKypIoLUNOQHO8S9U?=
 =?us-ascii?Q?BRor8bRM4rGe0sje8NUNktHyuUwOUmzheVeDn2CZCnOoCtPcZtHwZsWSPYHb?=
 =?us-ascii?Q?QT4CEyj5zkpjVMgTKS+uXTsg6SSHnGXwqDp16aLC6uCkTe5w3N6eb9tg4T7S?=
 =?us-ascii?Q?bMgoizh5ituVShPjOYIN6tD0CxpqKPFnoY5a7UoXHFGOzY2dBx6wsbu+4UYy?=
 =?us-ascii?Q?/AbGd4oz/wwNgkSgiGeYCjrRO9a7J4ckiHpJbtGDmGYLFbIN+BKMdF5ATI5Z?=
 =?us-ascii?Q?1sk1iA6712iiH7AW+dK/+OqQGwcBYRZu0VTATOiQR9s+XnpTJ2Vf34BEpKyI?=
 =?us-ascii?Q?WkNGOwRdbYaXqn8Ql49jw6k1Kc/9/FMg37wZRUNMNO3lE8tSidWJNDqTBD4f?=
 =?us-ascii?Q?lL4pcpkOyXG8J+ynmlbl5i7esZdmEghPG8Z+1ujZPZAniXperKpib080YDX1?=
 =?us-ascii?Q?ptYPVMt4LHS5VTd9Ur51OG1TLD2qhsOqokq3PPbWt6nPh0/ZqnHUjjauRfC8?=
 =?us-ascii?Q?+0S5ZsqE1jAnc/4EQAvPEYF5HaAKnNxPT3GLNQBz0VpfcKbB+QxNXIyjgd4p?=
 =?us-ascii?Q?kCcuqyN52NWCkU60/g+CQmdGUSzEARhL5437LPCvWtoWxnT4BePrEUP1Q1Ln?=
 =?us-ascii?Q?yVn14Xr6TSF04BNIKnINddaU0MSIjRaiTAZRz/dRfvKKdsrD55hlMW5OpZhZ?=
 =?us-ascii?Q?BKaa4WadJrIc8AaOe7BqwrxUpmh53cOaJOQH2XIkL3Cl3mZaVKyMIMSRWq/N?=
 =?us-ascii?Q?reQN+Da/cN6sUIU7PpkXhjVSvrDCM1A34hSwLg0ZsXIA+mvW7mUwiyn3dk9C?=
 =?us-ascii?Q?sZycxzYQw0faEbOG76To03+f0z3OyPOvnuH714U5+4pgVpckPjyqJ8gGzwM9?=
 =?us-ascii?Q?onk43SQ5HKL/zRO9WmNbjHEgmGGRMJXATeanm5A55p2o3PZ33SvZrsHXgJrF?=
 =?us-ascii?Q?QcXCsKbsLYdZ2Cv6aSYTe5Eawgwj1UeBzYXwDufpGZ0KNb2c/OCLBF4Nv4hm?=
 =?us-ascii?Q?dr/xU+84ZQZWT+opeY3etarBbD7VL9r2XYoP74zWis7mKYIznRNExXhIUv7a?=
 =?us-ascii?Q?60ZYxHraprchhW/CUPWRPOZMHYYxz6sctLFTBIr0XcxjxtAB9Gi5ulNbQG7t?=
 =?us-ascii?Q?JR1pY7ahQkrbSK5Foe6RJVj4nwdOSv8ZMeBJ78/CJseTV4MlMz0VKvBcaLbJ?=
 =?us-ascii?Q?23Rx2Ef7s7D7rtGT00GrhKCVTYh0D+E=3D?=
X-Exchange-RoutingPolicyChecked: DWMieJn4Z5Q0sW5SjNZUA6vzDB/BnKX/NsyNQYtsRyqf0Ubzrng54nqgRWvXuWeE3FqOroVh6kzibFY5/dcQNpz4oHQQm352raCLvztNj0d3Yrp6Tzg587o5MO7uOy0b9Us4CP5B47NjMqZ0c2o45gaB1lzdQPA6z/kTwCI1O6TJx5mPNytP4QqMDYawv0JkVDdme4aRiEBQzlSy7pZe7ffzj8DF0KNNx7FrdK2AOO2gxTksgVnODd9IAHCk1L6XrAQw2FDJabHzJ28uyEJEUZfSXaLsGVIxeYyx9E3VpPz9tYWPnrHtl6SLFeDvTmYbQdMyZHiKqe1saoGc+s8YtA==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: CqV8LCHE5WTXJ5FG6PYtkZZ7pC/amtAN0JzDYO+llO7oQwT8NvNAAe7j/Ed/SJPdka+ZOL/ZExVFWkvAep8O6uFjOW1uNa/oPpu+1hp+rsjA6+OBJ3s5ZcgkzJXrHiv1fB/QVXXfpaODCAJY3W2k5hP0peqXhwhEawTvZ7eLtvO3zKRHUSjKde0E/QIjoMlWxueduTJB4JFU1+f+bypAofz6LoGbaeExFYGs+J0SNZPfMH6rBdcBT9yft8moHfgLrTQtdvNsJRAf3t9R4EUVWRwcSZTo/LL8E0y07H8Fdmb4By093Dd2AoPWDegu3WrXQ/2fX5BcK7OVLzR4uSEbedP4I3oumGlL2bwd1k5ADY1Vor47bCii4qGBPJnzyGFrYTtLxJgPIHzMp/V/PR6idR3q24FndmRYDn8y9v/RQdh1KFxxQ8Z065I/uGKty/TH++s++tuISlv1VOR6wzLiS4BC6/jQ9e3O5yWHQBXdrMwUj7bvAjJkIiRzxnqiIiMR18cUdWrvLKlmwM4pxDw6dQSOlCoRIeWcZqtT6ofdltYsjMfiAOdIDnRx40JcYFwH0zqp09BCQaTGSoLebFY3gtzQAkBMAt33e0hoOl+rYxZbHDQVQ54G6Xi0LS4dNZn8
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd5e207f-364e-4493-d702-08df38cf0608
X-MS-Exchange-CrossTenant-AuthSource: SA1PR04MB10065.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2026 10:49:52.3233
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cVj41dA7qOY3qGw3D3u8NBsuVDv3z7eQGc3eGu8UCQqfFzlGn4SjpnlnzAbvRsPKGL5QatxFcgpVSOBQmPNXcdGmw+rqL6l1/nDnf/Z0Ymc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR04MB994160
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261102_024957_197858_5D2DC2D5 
X-CRM114-Status: GOOD (  17.67  )
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Sep 29, 2026 / 16:56, Nilay Shroff wrote:
> Concurrently disabling a passthru controller while passthru I/Os are
> in flight can potentially result in a use-after-free. Introduce a
> percpu refcount, an atomic flag, and an nvmet request flag to protect
> the passthru controller lifetime.
> 
> When enabling the passthru controller, initialize the percpu refcount
> and set the enabled flag. Each passthru I/O acquires a reference before
> entering the passthru hotpath and sets an nvmet request flag to record
> that the reference is held. The reference is released when the I/O
> completes.
> 
> When disabling the passthru controller, clear the enabled flag, kill
> the percpu refcount, and wait for all in-flight I/Os to release their
> references before releasing the passthru controller.
> 
> Disable operations are serialized by subsys->lock. The enabled flag
> ensures that only the first disable operation proceeds and subsequent
> attempts observe the flag as cleared and return.
> 
> Once disabling starts, new I/Os either fail to be routed to the
> passthru path or fail to acquire a live reference, and therefore cannot
> dereference the passthru controller and thus avoid use-after-free.
> 
> Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>

Hi, Nilay

I ran blktests with the kernel v7.4-rc1, and found the test case nvme/037 hangs
when it runs for rdma transport and siw driver [1]. I bisected and found this
patch as the commit 5e12d81874a1 is the trigger. If this han is a new issue, fix
actions will be appreciated.


[1] dmesg at nvme/037 hang

[ 3800.092349] [  T66191] run blktests nvme/037 at 2026-11-02 13:46:33.187037133
[ 3800.407876] [  T66934] nvmet_rdma: enabling port 0 (10.0.2.15:4420)
[ 3800.579559] [  T62940] nvmet: Created nvm controller 1 for subsystem blktests-subsystem-0 for NQN nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349.
[ 3800.601419] [  T66942] nvme nvme5: creating 4 I/O queues.
[ 3800.603382] [  T66942] nvme nvme5: mapped 4/0/0 default/read/poll queues.
[ 3800.728997] [  T66942] nvme nvme5: new ctrl: NQhN "blktests-subsystem-0", addr 10.0.2.15:4420, hostnqn: nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349
[ 3801.087205] [  T66966] nvme nvme5: Removing ctrl: NQN "blktests-subsystem-0"
[ 3801.531391] [  T66991] nvmet_rdma: enabling port 0 (10.0.2.15:4420)
[ 3801.688110] [  T62940] nvmet: Created nvm controller 1 for subsystem blktests-subsystem-1 for NQN nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349.
[ 3801.704598] [  T66999] nvme nvme5: creating 4 I/O queues.
[ 3801.706191] [  T66999] nvme nvme5: mapped 4/0/0 default/read/poll queues.
[ 3801.824182] [  T66999] nvme nvme5: new ctrl: NQN "blktests-subsystem-1", addr 10.0.2.15:4420, hostnqn: nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349
[ 3802.184483] [  T67023] nvme nvme5: Removing ctrl: NQN "blktests-subsystem-1"
[ 3802.641645] [  T67048] nvmet_rdma: enabling port 0 (10.0.2.15:4420)
[ 3802.799232] [  T62940] nvmet: Created nvm controller 1 for subsystem blktests-subsystem-2 for NQN nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349.
[ 3802.815664] [  T67056] nvme nvme5: creating 4 I/O queues.
[ 3802.816931] [  T67056] nvme nvme5: mapped 4/0/0 default/read/poll queues.
[ 3802.935988] [  T67056] nvme nvme5: new ctrl: NQN "blktests-subsystem-2", addr 10.0.2.15:4420, hostnqn: nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349
[ 3803.290667] [  T67080] nvme nvme5: Removing ctrl: NQN "blktests-subsystem-2"
[ 3803.749797] [  T67105] nvmet_rdma: enabling port 0 (10.0.2.15:4420)
[ 3803.909791] [  T62940] nvmet: Created nvm controller 1 for subsystem blktests-subsystem-3 for NQN nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349.
[ 3803.932485] [  T67113] nvme nvme5: creating 4 I/O queues.
[ 3803.933765] [  T67113] nvme nvme5: mapped 4/0/0 default/read/poll queues.
[ 3804.054973] [  T67113] nvme nvme5: new ctrl: NQN "blktests-subsystem-3", addr 10.0.2.15:4420, hostnqn: nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349
[ 3804.413732] [  T67137] nvme nvme5: Removing ctrl: NQN "blktests-subsystem-3"
[ 3804.857065] [  T67162] nvmet_rdma: enabling port 0 (10.0.2.15:4420)
[ 3805.010639] [  T62940] nvmet: Created nvm controller 1 for subsystem blktests-subsystem-4 for NQN nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349.
[ 3805.028058] [  T67170] nvme nvme5: creating 4 I/O queues.
[ 3805.030124] [  T67170] nvme nvme5: mapped 4/0/0 default/read/poll queues.
[ 3805.155236] [  T67170] nvme nvme5: new ctrl: NQN "blktests-subsystem-4", addr 10.0.2.15:4420, hostnqn: nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349
[ 3805.527884] [  T67194] nvme nvme5: Removing ctrl: NQN "blktests-subsystem-4"
[ 3805.971809] [  T67219] nvmet_rdma: enabling port 0 (10.0.2.15:4420)
[ 3806.137857] [  T62940] nvmet: Created nvm controller 1 for subsystem blktests-subsystem-5 for NQN nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349.
[ 3806.155758] [  T67227] nvme nvme5: creating 4 I/O queues.
[ 3806.157395] [  T67227] nvme nvme5: mapped 4/0/0 default/read/poll queues.
[ 3806.277467] [  T67227] nvme nvme5: new ctrl: NQN "blktests-subsystem-5", addr 10.0.2.15:4420, hostnqn: nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349
[ 3806.641474] [  T67251] nvme nvme5: Removing ctrl: NQN "blktests-subsystem-5"
[ 3807.084278] [  T67276] nvmet_rdma: enabling port 0 (10.0.2.15:4420)
[ 3807.278228] [  T62940] nvmet: Created nvm controller 1 for subsystem blktests-subsystem-6 for NQN nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349.
[ 3807.308262] [  T67284] nvme nvme5: creating 4 I/O queues.
[ 3807.317068] [  T67284] nvme nvme5: mapped 4/0/0 default/read/poll queues.
[ 3807.469771] [  T67284] nvme nvme5: new ctrl: NQN "blktests-subsystem-6", addr 10.0.2.15:4420, hostnqn: nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349
[ 3807.937039] [  T67308] nvme nvme5: Removing ctrl: NQN "blktests-subsystem-6"
[ 3809.420886] [  T67333] nvmet_rdma: enabling port 0 (10.0.2.15:4420)
[ 3809.592288] [  T62940] nvmet: Created nvm controller 1 for subsystem blktests-subsystem-7 for NQN nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349.
[ 3809.628746] [  T67341] nvme nvme5: creating 4 I/O queues.
[ 3809.630196] [  T67341] nvme nvme5: mapped 4/0/0 default/read/poll queues.
[ 3809.768300] [  T67341] nvme nvme5: new ctrl: NQN "blktests-subsystem-7", addr 10.0.2.15:4420, hostnqn: nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349
[ 3810.178568] [  T67365] nvme nvme5: Removing ctrl: NQN "blktests-subsystem-7"
[ 3811.140562] [  T67390] nvmet_rdma: enabling port 0 (10.0.2.15:4420)
[ 3811.332824] [  T62940] nvmet: Created nvm controller 1 for subsystem blktests-subsystem-8 for NQN nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349.
[ 3811.351258] [  T67398] nvme nvme5: creating 4 I/O queues.
[ 3811.352718] [  T67398] nvme nvme5: mapped 4/0/0 default/read/poll queues.
[ 3811.491120] [  T67398] nvme nvme5: new ctrl: NQN "blktests-subsystem-8", addr 10.0.2.15:4420, hostnqn: nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349
[ 3812.000917] [  T67422] nvme nvme5: Removing ctrl: NQN "blktests-subsystem-8"
[ 3812.828312] [  T67447] nvmet_rdma: enabling port 0 (10.0.2.15:4420)
[ 3812.998293] [  T62940] nvmet: Created nvm controller 1 for subsystem blktests-subsystem-9 for NQN nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349.
[ 3813.017919] [  T67455] nvme nvme5: creating 4 I/O queues.
[ 3813.020332] [  T67455] nvme nvme5: mapped 4/0/0 default/read/poll queues.
[ 3813.161933] [  T67455] nvme nvme5: new ctrl: NQN "blktests-subsystem-9", addr 10.0.2.15:4420, hostnqn: nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349
[ 3813.539457] [  T67479] nvme nvme5: Removing ctrl: NQN "blktests-subsystem-9"
[ 4056.926027] [     T48] INFO: task check:66191 blocked for more than 122 seconds.
[ 4056.931295] [     T48]       Not tainted 7.4.0-rc1 #487
[ 4056.931983] [     T48] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[ 4056.932706] [     T48] task:check           state:D stack:0     pid:66191 tgid:66191 ppid:23692  task_flags:0x400140 flags:0x00080000
[ 4056.933524] [     T48] Call Trace:
[ 4056.934363] [     T48]  <TASK>
[ 4056.935110] [     T48]  __schedule+0x1d90/0x6ea0
[ 4056.935828] [     T48]  ? __pfx___schedule+0x10/0x10
[ 4056.936501] [     T48]  ? lock_acquire+0x1c1/0x340
[ 4056.937175] [     T48]  ? schedule+0x24a/0x2e0
[ 4056.937848] [     T48]  ? lock_release+0x1b5/0x340
[ 4056.939024] [     T48]  ? __pfx_nvmet_passthru_enable_store+0x10/0x10 [nvmet]
[ 4056.939719] [     T48]  schedule+0xe3/0x2e0
[ 4056.940371] [     T48]  schedule_timeout+0x1ac/0x290
[ 4056.940975] [     T48]  ? __pfx_schedule_timeout+0x10/0x10
[ 4056.941587] [     T48]  ? lockdep_hardirqs_on_prepare+0xd5/0x1b0
[ 4056.942166] [     T48]  ? trace_hardirqs_on+0x14/0x190
[ 4056.942796] [     T48]  wait_for_completion+0x17a/0x400
[ 4056.943440] [     T48]  ? __pfx_wait_for_completion+0x10/0x10
[ 4056.944065] [     T48]  ? _raw_spin_unlock_irqrestore+0x4c/0x60
[ 4056.944669] [     T48]  __nvmet_passthru_ctrl_disable+0xcf/0x320 [nvmet]
[ 4056.945333] [     T48]  ? __pfx_nvmet_passthru_enable_store+0x10/0x10 [nvmet]
[ 4056.945950] [     T48]  nvmet_passthru_ctrl_disable+0x24/0x40 [nvmet]
[ 4056.946530] [     T48]  ? __kasan_kmalloc+0x96/0xb0
[ 4056.947106] [     T48]  nvmet_passthru_enable_store+0xa0/0x100 [nvmet]
[ 4056.947713] [     T48]  ? __pfx_nvmet_passthru_enable_store+0x10/0x10 [nvmet]
[ 4056.948304] [     T48]  ? configfs_write_iter+0x240/0x4a0
[ 4056.948874] [     T48]  configfs_write_iter+0x2ad/0x4a0
[ 4056.949405] [     T48]  ? __pfx_configfs_write_iter+0x10/0x10
[ 4056.949949] [     T48]  vfs_write+0x4b3/0xf40
[ 4056.950465] [     T48]  ? __pfx_vfs_write+0x10/0x10
[ 4056.951003] [     T48]  ? __lock_acquire+0x54a/0x2490
[ 4056.951499] [     T48]  ? lock_acquire+0x1b1/0x340
[ 4056.952119] [     T48]  ksys_write+0x112/0x250
[ 4056.952640] [     T48]  ? __pfx_ksys_write+0x10/0x10
[ 4056.953138] [     T48]  ? rcu_is_watching+0x12/0xb0
[ 4056.953557] [     T48]  do_syscall_64+0xf2/0x690
[ 4056.954046] [     T48]  ? rcu_is_watching+0x12/0xb0
[ 4056.954486] [     T48]  ? do_syscall_64+0x2d/0x690
[ 4056.954952] [     T48]  ? trace_hardirqs_off_finish+0x139/0x180
[ 4056.955384] [     T48]  ? lockdep_hardirqs_off+0xaf/0xf0
[ 4056.955844] [     T48]  ? do_syscall_64+0x60/0x690
[ 4056.956254] [     T48]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[ 4056.956621] [     T48] RIP: 0033:0x7fb94423d54e
[ 4056.956995] [     T48] RSP: 002b:00007ffef5d375a0 EFLAGS: 00000202 ORIG_RAX: 0000000000000001
[ 4056.957416] [     T48] RAX: ffffffffffffffda RBX: 00007fb9443be580 RCX: 00007fb94423d54e
[ 4056.957852] [     T48] RDX: 0000000000000001 RSI: 000055c9e7267150 RDI: 0000000000000001
[ 4056.958265] [     T48] RBP: 00007ffef5d375b0 R08: 0000000000000000 R09: 0000000000000000
[ 4056.958585] [     T48] R10: 0000000000000000 R11: 0000000000000202 R12: 0000000000000001
[ 4056.958999] [     T48] R13: 0000000000000001 R14: 000055c9e7267150 R15: 0000000000000000
[ 4056.959369] [     T48]  </TASK>
[ 4056.959741] [     T48] 
                          Showing all locks held in the system:
[ 4056.960385] [     T48] locks held by pr/ttyS0/47: 2, last CPU#2:
[ 4056.960702] [     T48]  #0: ffffffff8b89ffd8 (console_srcu){....}-{0:0}, at: console_srcu_read_lock+0x45/0x60
[ 4056.961033] [     T48]  #1: ffffffffa2730278 (&port_lock_key){-.-.}-{3:3}, at: univ8250_console_device_lock+0x52/0xa0
[ 4056.961403] [     T48] locks held by khungtaskd/48: 1, last CPU#3:
[ 4056.961740] [     T48]  #0: ffffffff8b8b1e00 (rcu_read_lock){....}-{1:3}, at: debug_show_all_locks+0x39/0x180
[ 4056.962137] [     T48] locks held by kworker/3:11/65511: 4, on CPU#3:
[ 4056.962506] [     T48]  #0: ffff888100194148 ((wq_completion)events){+.+.}-{0:0}, at: process_one_work+0x1109/0x1760
[ 4056.962894] [     T48]  #1: ffff88814eeefd10 ((work_completion)(&helper->damage_work)){+.+.}-{0:0}, at: process_one_work+0x8c0/0x1760
[ 4056.963301] [     T48]  #2: ffff8881325dca70 (&helper->lock){+.+.}-{4:4}, at: drm_fb_helper_damage_work+0x175/0xac0 [drm_client_lib]
[ 4056.963690] [     T48]  #3: ffff8881333e0128 (&dev->master_mutex){+.+.}-{4:4}, at: drm_master_internal_acquire+0x1b/0x60 [drm]
[ 4056.964134] [     T48] locks held by check/66191: 3, on CPU#1:
[ 4056.964542] [     T48]  #0: ffff888142c0e478 (sb_writers#12){.+.+}-{0:0}, at: ksys_write+0x112/0x250
[ 4056.964950] [     T48]  #1: ffff888144737e80 (&buffer->mutex){+.+.}-{4:4}, at: configfs_write_iter+0x6d/0x4a0
[ 4056.965918] [     T48]  #2: ffff88813c09b070 (&p->frag_sem){++++}-{4:4}, at: configfs_write_iter+0x1db/0x4a0

[ 4056.966796] [     T48] =============================================

[ 4179.806492] [     T48] INFO: task check:66191 blocked for more than 245 seconds.
[ 4179.809371] [     T48]       Not tainted 7.4.0-rc1 #487
[ 4179.812094] [     T48] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[ 4179.812633] [     T48] task:check           state:D stack:0     pid:66191 tgid:66191 ppid:23692  task_flags:0x400140 flags:0x00080000
[ 4179.813102] [     T48] Call Trace:
[ 4179.813539] [     T48]  <TASK>
[ 4179.813987] [     T48]  __schedule+0x1d90/0x6ea0
[ 4179.814452] [     T48]  ? __pfx___schedule+0x10/0x10
[ 4179.814877] [     T48]  ? lock_acquire+0x1c1/0x340
[ 4179.815318] [     T48]  ? schedule+0x24a/0x2e0
[ 4179.816338] [     T48]  ? lock_release+0x1b5/0x340
[ 4179.816784] [     T48]  ? __pfx_nvmet_passthru_enable_store+0x10/0x10 [nvmet]
[ 4179.817265] [     T48]  schedule+0xe3/0x2e0
[ 4179.817700] [     T48]  schedule_timeout+0x1ac/0x290
[ 4179.818169] [     T48]  ? __pfx_schedule_timeout+0x10/0x10
[ 4179.818623] [     T48]  ? lockdep_hardirqs_on_prepare+0xd5/0x1b0
[ 4179.819043] [     T48]  ? trace_hardirqs_on+0x14/0x190
[ 4179.819481] [     T48]  wait_for_completion+0x17a/0x400
[ 4179.819934] [     T48]  ? __pfx_wait_for_completion+0x10/0x10
[ 4179.820418] [     T48]  ? _raw_spin_unlock_irqrestore+0x4c/0x60
[ 4179.820861] [     T48]  __nvmet_passthru_ctrl_disable+0xcf/0x320 [nvmet]
[ 4179.821371] [     T48]  ? __pfx_nvmet_passthru_enable_store+0x10/0x10 [nvmet]
[ 4179.821853] [     T48]  nvmet_passthru_ctrl_disable+0x24/0x40 [nvmet]
[ 4179.822361] [     T48]  ? __kasan_kmalloc+0x96/0xb0
[ 4179.822829] [     T48]  nvmet_passthru_enable_store+0xa0/0x100 [nvmet]
[ 4179.823275] [     T48]  ? __pfx_nvmet_passthru_enable_store+0x10/0x10 [nvmet]
[ 4179.823734] [     T48]  ? configfs_write_iter+0x240/0x4a0
[ 4179.824162] [     T48]  configfs_write_iter+0x2ad/0x4a0
[ 4179.824612] [     T48]  ? __pfx_configfs_write_iter+0x10/0x10
[ 4179.825044] [     T48]  vfs_write+0x4b3/0xf40
[ 4179.825477] [     T48]  ? __pfx_vfs_write+0x10/0x10
[ 4179.825922] [     T48]  ? __lock_acquire+0x54a/0x2490
[ 4179.826351] [     T48]  ? lock_acquire+0x1b1/0x340
[ 4179.826790] [     T48]  ksys_write+0x112/0x250
[ 4179.827204] [     T48]  ? __pfx_ksys_write+0x10/0x10
[ 4179.827627] [     T48]  ? rcu_is_watching+0x12/0xb0
[ 4179.828025] [     T48]  do_syscall_64+0xf2/0x690
[ 4179.828414] [     T48]  ? rcu_is_watching+0x12/0xb0
[ 4179.828816] [     T48]  ? do_syscall_64+0x2d/0x690
[ 4179.829322] [     T48]  ? trace_hardirqs_off_finish+0x139/0x180
[ 4179.829741] [     T48]  ? lockdep_hardirqs_off+0xaf/0xf0
[ 4179.830125] [     T48]  ? do_syscall_64+0x60/0x690
[ 4179.830485] [     T48]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[ 4179.830856] [     T48] RIP: 0033:0x7fb94423d54e
[ 4179.831216] [     T48] RSP: 002b:00007ffef5d375a0 EFLAGS: 00000202 ORIG_RAX: 0000000000000001
[ 4179.831583] [     T48] RAX: ffffffffffffffda RBX: 00007fb9443be580 RCX: 00007fb94423d54e
[ 4179.831941] [     T48] RDX: 0000000000000001 RSI: 000055c9e7267150 RDI: 0000000000000001
[ 4179.832296] [     T48] RBP: 00007ffef5d375b0 R08: 0000000000000000 R09: 0000000000000000
[ 4179.832665] [     T48] R10: 0000000000000000 R11: 0000000000000202 R12: 0000000000000001
[ 4179.833014] [     T48] R13: 0000000000000001 R14: 000055c9e7267150 R15: 0000000000000000
[ 4179.833390] [     T48]  </TASK>
[ 4179.833749] [     T48] 
                          Showing all locks held in the system:
[ 4179.834379] [     T48] locks held by pr/ttyS0/47: 2, last CPU#2:
[ 4179.834713] [     T48]  #0: ffffffff8b89ffd8 (console_srcu){....}-{0:0}, at: console_srcu_read_lock+0x45/0x60
[ 4179.835055] [     T48]  #1: ffffffffa2730278 (&port_lock_key){-.-.}-{3:3}, at: univ8250_console_device_lock+0x52/0xa0
[ 4179.835400] [     T48] locks held by khungtaskd/48: 1, last CPU#3:
[ 4179.835756] [     T48]  #0: ffffffff8b8b1e00 (rcu_read_lock){....}-{1:3}, at: debug_show_all_locks+0x39/0x180
[ 4179.836149] [     T48] locks held by kworker/3:11/65511: 4, on CPU#3:
[ 4179.836481] [     T48]  #0: ffff888100194148 ((wq_completion)events){+.+.}-{0:0}, at: process_one_work+0x1109/0x1760
[ 4179.836874] [     T48]  #1: ffff88814eeefd10 ((work_completion)(&helper->damage_work)){+.+.}-{0:0}, at: process_one_work+0x8c0/0x1760
[ 4179.837276] [     T48]  #2: ffff8881325dca70 (&helper->lock){+.+.}-{4:4}, at: drm_fb_helper_damage_work+0x175/0xac0 [drm_client_lib]
[ 4179.837701] [     T48]  #3: ffff8881333e0128 (&dev->master_mutex){+.+.}-{4:4}, at: drm_master_internal_acquire+0x1b/0x60 [drm]
[ 4179.838196] [     T48] locks held by check/66191: 3, on CPU#1:
[ 4179.838590] [     T48]  #0: ffff888142c0e478 (sb_writers#12){.+.+}-{0:0}, at: ksys_write+0x112/0x250
[ 4179.839010] [     T48]  #1: ffff888144737e80 (&buffer->mutex){+.+.}-{4:4}, at: configfs_write_iter+0x6d/0x4a0
[ 4179.839429] [     T48]  #2: ffff88813c09b070 (&p->frag_sem){++++}-{4:4}, at: configfs_write_iter+0x1db/0x4a0

[ 4179.840265] [     T48] =============================================

[ 4302.686843] [     T48] INFO: task check:66191 blocked for more than 368 seconds.
[ 4302.689729] [     T48]       Not tainted 7.4.0-rc1 #487
[ 4302.692595] [     T48] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[ 4302.695736] [     T48] task:check           state:D stack:0     pid:66191 tgid:66191 ppid:23692  task_flags:0x400140 flags:0x00080000
[ 4302.696226] [     T48] Call Trace:
[ 4302.696654] [     T48]  <TASK>
[ 4302.697069] [     T48]  __schedule+0x1d90/0x6ea0
[ 4302.697535] [     T48]  ? __pfx___schedule+0x10/0x10
[ 4302.697953] [     T48]  ? lock_acquire+0x1c1/0x340
[ 4302.698390] [     T48]  ? schedule+0x24a/0x2e0
[ 4302.698805] [     T48]  ? lock_release+0x1b5/0x340
[ 4302.699211] [     T48]  ? __pfx_nvmet_passthru_enable_store+0x10/0x10 [nvmet]
[ 4302.699676] [     T48]  schedule+0xe3/0x2e0
[ 4302.700092] [     T48]  schedule_timeout+0x1ac/0x290
[ 4302.700524] [     T48]  ? __pfx_schedule_timeout+0x10/0x10
[ 4302.700955] [     T48]  ? lockdep_hardirqs_on_prepare+0xd5/0x1b0
[ 4302.701394] [     T48]  ? trace_hardirqs_on+0x14/0x190
[ 4302.701815] [     T48]  wait_for_completion+0x17a/0x400
[ 4302.702239] [     T48]  ? __pfx_wait_for_completion+0x10/0x10
[ 4302.702677] [     T48]  ? _raw_spin_unlock_irqrestore+0x4c/0x60
[ 4302.703098] [     T48]  __nvmet_passthru_ctrl_disable+0xcf/0x320 [nvmet]
[ 4302.703557] [     T48]  ? __pfx_nvmet_passthru_enable_store+0x10/0x10 [nvmet]
[ 4302.704002] [     T48]  nvmet_passthru_ctrl_disable+0x24/0x40 [nvmet]
[ 4302.704463] [     T48]  ? __kasan_kmalloc+0x96/0xb0
[ 4302.704882] [     T48]  nvmet_passthru_enable_store+0xa0/0x100 [nvmet]
[ 4302.705349] [     T48]  ? __pfx_nvmet_passthru_enable_store+0x10/0x10 [nvmet]
[ 4302.705792] [     T48]  ? configfs_write_iter+0x240/0x4a0
[ 4302.706368] [     T48]  configfs_write_iter+0x2ad/0x4a0
[ 4302.706814] [     T48]  ? __pfx_configfs_write_iter+0x10/0x10
[ 4302.707242] [     T48]  vfs_write+0x4b3/0xf40
[ 4302.707672] [     T48]  ? __pfx_vfs_write+0x10/0x10
[ 4302.708103] [     T48]  ? __lock_acquire+0x54a/0x2490
[ 4302.708538] [     T48]  ? lock_acquire+0x1b1/0x340
[ 4302.708966] [     T48]  ksys_write+0x112/0x250
[ 4302.709386] [     T48]  ? __pfx_ksys_write+0x10/0x10
[ 4302.709781] [     T48]  ? rcu_is_watching+0x12/0xb0
[ 4302.710180] [     T48]  do_syscall_64+0xf2/0x690
[ 4302.710593] [     T48]  ? rcu_is_watching+0x12/0xb0
[ 4302.710979] [     T48]  ? do_syscall_64+0x2d/0x690
[ 4302.711369] [     T48]  ? trace_hardirqs_off_finish+0x139/0x180
[ 4302.711739] [     T48]  ? lockdep_hardirqs_off+0xaf/0xf0
[ 4302.712098] [     T48]  ? do_syscall_64+0x60/0x690
[ 4302.712470] [     T48]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[ 4302.712811] [     T48] RIP: 0033:0x7fb94423d54e
[ 4302.713160] [     T48] RSP: 002b:00007ffef5d375a0 EFLAGS: 00000202 ORIG_RAX: 0000000000000001
[ 4302.713523] [     T48] RAX: ffffffffffffffda RBX: 00007fb9443be580 RCX: 00007fb94423d54e
[ 4302.713861] [     T48] RDX: 0000000000000001 RSI: 000055c9e7267150 RDI: 0000000000000001
[ 4302.714208] [     T48] RBP: 00007ffef5d375b0 R08: 0000000000000000 R09: 0000000000000000
[ 4302.714561] [     T48] R10: 0000000000000000 R11: 0000000000000202 R12: 0000000000000001
[ 4302.714900] [     T48] R13: 0000000000000001 R14: 000055c9e7267150 R15: 0000000000000000
[ 4302.715244] [     T48]  </TASK>
[ 4302.715592] [     T48] 
                          Showing all locks held in the system:
[ 4302.716268] [     T48] locks held by pr/ttyS0/47: 2, last CPU#2:
[ 4302.716616] [     T48]  #0: ffffffff8b89ffd8 (console_srcu){....}-{0:0}, at: console_srcu_read_lock+0x45/0x60
[ 4302.716979] [     T48]  #1: ffffffffa2730278 (&port_lock_key){-.-.}-{3:3}, at: univ8250_console_device_lock+0x52/0xa0
[ 4302.717336] [     T48] locks held by khungtaskd/48: 1, last CPU#3:
[ 4302.717688] [     T48]  #0: ffffffff8b8b1e00 (rcu_read_lock){....}-{1:3}, at: debug_show_all_locks+0x39/0x180
[ 4302.718111] [     T48] locks held by kworker/3:11/65511: 4, on CPU#3:
[ 4302.718494] [     T48]  #0: ffff888100194148 ((wq_completion)events){+.+.}-{0:0}, at: process_one_work+0x1109/0x1760
[ 4302.718860] [     T48]  #1: ffff88814eeefd10 ((work_completion)(&helper->damage_work)){+.+.}-{0:0}, at: process_one_work+0x8c0/0x1760
[ 4302.719260] [     T48]  #2: ffff8881325dca70 (&helper->lock){+.+.}-{4:4}, at: drm_atomic_helper_dirtyfb+0xdf/0x770 [drm_kms_helper]
[ 4302.720166] [     T48]  #3: ffff88814eeefa58 (crtc_ww_class_mutex){+.+.}-{4:4}, at: drm_atomic_helper_dirtyfb+0xdf/0x770 [drm_kms_helper]
[ 4302.720646] [     T48] locks held by check/66191: 3, on CPU#1:
[ 4302.721038] [     T48]  #0: ffff888142c0e478 (sb_writers#12){.+.+}-{0:0}, at: ksys_write+0x112/0x250
[ 4302.721499] [     T48]  #1: ffff888144737e80 (&buffer->mutex){+.+.}-{4:4}, at: configfs_write_iter+0x6d/0x4a0
[ 4302.721908] [     T48]  #2: ffff88813c09b070 (&p->frag_sem){++++}-{4:4}, at: configfs_write_iter+0x1db/0x4a0

[ 4302.722791] [     T48] =============================================

[ 4425.567220] [     T48] INFO: task check:66191 blocked for more than 491 seconds.
[ 4425.570359] [     T48]       Not tainted 7.4.0-rc1 #487
[ 4425.573459] [     T48] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[ 4425.576758] [     T48] task:check           state:D stack:0     pid:66191 tgid:66191 ppid:23692  task_flags:0x400140 flags:0x00080000
[ 4425.578392] [     T48] Call Trace:
[ 4425.578891] [     T48]  <TASK>
[ 4425.579409] [     T48]  __schedule+0x1d90/0x6ea0
[ 4425.579937] [     T48]  ? __pfx___schedule+0x10/0x10
[ 4425.580417] [     T48]  ? lock_acquire+0x1c1/0x340
[ 4425.580885] [     T48]  ? schedule+0x24a/0x2e0
[ 4425.581345] [     T48]  ? lock_release+0x1b5/0x340
[ 4425.581812] [     T48]  ? __pfx_nvmet_passthru_enable_store+0x10/0x10 [nvmet]
[ 4425.582313] [     T48]  schedule+0xe3/0x2e0
[ 4425.582785] [     T48]  schedule_timeout+0x1ac/0x290
[ 4425.583734] [     T48]  ? __pfx_schedule_timeout+0x10/0x10
[ 4425.584167] [     T48]  ? lockdep_hardirqs_on_prepare+0xd5/0x1b0
[ 4425.584604] [     T48]  ? trace_hardirqs_on+0x14/0x190
[ 4425.585073] [     T48]  wait_for_completion+0x17a/0x400
[ 4425.585518] [     T48]  ? __pfx_wait_for_completion+0x10/0x10
[ 4425.585968] [     T48]  ? _raw_spin_unlock_irqrestore+0x4c/0x60
[ 4425.586398] [     T48]  __nvmet_passthru_ctrl_disable+0xcf/0x320 [nvmet]
[ 4425.586836] [     T48]  ? __pfx_nvmet_passthru_enable_store+0x10/0x10 [nvmet]
[ 4425.587329] [     T48]  nvmet_passthru_ctrl_disable+0x24/0x40 [nvmet]
[ 4425.587801] [     T48]  ? __kasan_kmalloc+0x96/0xb0
[ 4425.588279] [     T48]  nvmet_passthru_enable_store+0xa0/0x100 [nvmet]
[ 4425.588743] [     T48]  ? __pfx_nvmet_passthru_enable_store+0x10/0x10 [nvmet]
[ 4425.589183] [     T48]  ? configfs_write_iter+0x240/0x4a0
[ 4425.589597] [     T48]  configfs_write_iter+0x2ad/0x4a0
[ 4425.590021] [     T48]  ? __pfx_configfs_write_iter+0x10/0x10
[ 4425.590432] [     T48]  vfs_write+0x4b3/0xf40
[ 4425.590850] [     T48]  ? __pfx_vfs_write+0x10/0x10
[ 4425.591261] [     T48]  ? __lock_acquire+0x54a/0x2490
[ 4425.591682] [     T48]  ? lock_acquire+0x1b1/0x340
[ 4425.592085] [     T48]  ksys_write+0x112/0x250
[ 4425.592483] [     T48]  ? __pfx_ksys_write+0x10/0x10
[ 4425.592889] [     T48]  ? rcu_is_watching+0x12/0xb0
[ 4425.593292] [     T48]  do_syscall_64+0xf2/0x690
[ 4425.593660] [     T48]  ? rcu_is_watching+0x12/0xb0
[ 4425.594065] [     T48]  ? do_syscall_64+0x2d/0x690
[ 4425.594454] [     T48]  ? trace_hardirqs_off_finish+0x139/0x180
[ 4425.594819] [     T48]  ? lockdep_hardirqs_off+0xaf/0xf0
[ 4425.595186] [     T48]  ? do_syscall_64+0x60/0x690
[ 4425.595541] [     T48]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[ 4425.595925] [     T48] RIP: 0033:0x7fb94423d54e
[ 4425.596289] [     T48] RSP: 002b:00007ffef5d375a0 EFLAGS: 00000202 ORIG_RAX: 0000000000000001
[ 4425.596657] [     T48] RAX: ffffffffffffffda RBX: 00007fb9443be580 RCX: 00007fb94423d54e
[ 4425.597015] [     T48] RDX: 0000000000000001 RSI: 000055c9e7267150 RDI: 0000000000000001
[ 4425.597419] [     T48] RBP: 00007ffef5d375b0 R08: 0000000000000000 R09: 0000000000000000
[ 4425.597803] [     T48] R10: 0000000000000000 R11: 0000000000000202 R12: 0000000000000001
[ 4425.598146] [     T48] R13: 0000000000000001 R14: 000055c9e7267150 R15: 0000000000000000
[ 4425.598537] [     T48]  </TASK>
[ 4425.598950] [     T48] 
                          Showing all locks held in the system:
[ 4425.599590] [     T48] locks held by pr/ttyS0/47: 2, last CPU#2:
[ 4425.599932] [     T48]  #0: ffffffff8b89ffd8 (console_srcu){....}-{0:0}, at: console_srcu_read_lock+0x45/0x60
[ 4425.600277] [     T48]  #1: ffffffffa2730278 (&port_lock_key){-.-.}-{3:3}, at: univ8250_console_device_lock+0x52/0xa0
[ 4425.600605] [     T48] locks held by khungtaskd/48: 1, last CPU#1:
[ 4425.600981] [     T48]  #0: ffffffff8b8b1e00 (rcu_read_lock){....}-{1:3}, at: debug_show_all_locks+0x39/0x180
[ 4425.601405] [     T48] locks held by check/66191: 3, on CPU#1:
[ 4425.601792] [     T48]  #0: ffff888142c0e478 (sb_writers#12){.+.+}-{0:0}, at: ksys_write+0x112/0x250
[ 4425.602160] [     T48]  #1: ffff888144737e80 (&buffer->mutex){+.+.}-{4:4}, at: configfs_write_iter+0x6d/0x4a0
[ 4425.602548] [     T48]  #2: ffff88813c09b070 (&p->frag_sem){++++}-{4:4}, at: configfs_write_iter+0x1db/0x4a0
[ 4425.602948] [     T48] locks held by kworker/3:0/67500: 4, on CPU#3:
[ 4425.603342] [     T48]  #0: ffff888100194148 ((wq_completion)events){+.+.}-{0:0}, at: process_one_work+0x1109/0x1760
[ 4425.603756] [     T48]  #1: ffff88812b2e7d10 ((work_completion)(&helper->damage_work)){+.+.}-{0:0}, at: process_one_work+0x8c0/0x1760
[ 4425.604169] [     T48]  #2: ffff8881325dca70 (&helper->lock){+.+.}-{4:4}, at: drm_fb_helper_damage_work+0x175/0xac0 [drm_client_lib]
[ 4425.604591] [     T48]  #3: ffff8881333e0128 (&dev->master_mutex){+.+.}-{4:4}, at: drm_master_internal_acquire+0x1b/0x60 [drm]

[ 4425.605522] [     T48] =============================================

[ 4548.447529] [     T48] INFO: task check:66191 blocked for more than 614 seconds.
[ 4548.450305] [     T48]       Not tainted 7.4.0-rc1 #487
[ 4548.452756] [     T48] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[ 4548.453461] [     T48] task:check           state:D stack:0     pid:66191 tgid:66191 ppid:23692  task_flags:0x400140 flags:0x00080000
[ 4548.453922] [     T48] Call Trace:
[ 4548.454336] [     T48]  <TASK>
[ 4548.454739] [     T48]  __schedule+0x1d90/0x6ea0
[ 4548.455244] [     T48]  ? __pfx___schedule+0x10/0x10
[ 4548.455697] [     T48]  ? lock_acquire+0x1c1/0x340
[ 4548.456102] [     T48]  ? schedule+0x24a/0x2e0
[ 4548.456549] [     T48]  ? lock_release+0x1b5/0x340
[ 4548.457013] [     T48]  ? __pfx_nvmet_passthru_enable_store+0x10/0x10 [nvmet]
[ 4548.457478] [     T48]  schedule+0xe3/0x2e0
[ 4548.457900] [     T48]  schedule_timeout+0x1ac/0x290
[ 4548.458341] [     T48]  ? __pfx_schedule_timeout+0x10/0x10
[ 4548.458773] [     T48]  ? lockdep_hardirqs_on_prepare+0xd5/0x1b0
[ 4548.459211] [     T48]  ? trace_hardirqs_on+0x14/0x190
[ 4548.459639] [     T48]  wait_for_completion+0x17a/0x400
[ 4548.460103] [     T48]  ? __pfx_wait_for_completion+0x10/0x10
[ 4548.460531] [     T48]  ? _raw_spin_unlock_irqrestore+0x4c/0x60
[ 4548.460998] [     T48]  __nvmet_passthru_ctrl_disable+0xcf/0x320 [nvmet]
[ 4548.461471] [     T48]  ? __pfx_nvmet_passthru_enable_store+0x10/0x10 [nvmet]
[ 4548.461942] [     T48]  nvmet_passthru_ctrl_disable+0x24/0x40 [nvmet]
[ 4548.462383] [     T48]  ? __kasan_kmalloc+0x96/0xb0
[ 4548.462819] [     T48]  nvmet_passthru_enable_store+0xa0/0x100 [nvmet]
[ 4548.463313] [     T48]  ? __pfx_nvmet_passthru_enable_store+0x10/0x10 [nvmet]
[ 4548.463741] [     T48]  ? configfs_write_iter+0x240/0x4a0
[ 4548.464191] [     T48]  configfs_write_iter+0x2ad/0x4a0
[ 4548.464625] [     T48]  ? __pfx_configfs_write_iter+0x10/0x10
[ 4548.465107] [     T48]  vfs_write+0x4b3/0xf40
[ 4548.465531] [     T48]  ? __pfx_vfs_write+0x10/0x10
[ 4548.465965] [     T48]  ? __lock_acquire+0x54a/0x2490
[ 4548.466401] [     T48]  ? lock_acquire+0x1b1/0x340
[ 4548.466849] [     T48]  ksys_write+0x112/0x250
[ 4548.467295] [     T48]  ? __pfx_ksys_write+0x10/0x10
[ 4548.467687] [     T48]  ? rcu_is_watching+0x12/0xb0
[ 4548.468108] [     T48]  do_syscall_64+0xf2/0x690
[ 4548.468496] [     T48]  ? rcu_is_watching+0x12/0xb0
[ 4548.468893] [     T48]  ? do_syscall_64+0x2d/0x690
[ 4548.469260] [     T48]  ? trace_hardirqs_off_finish+0x139/0x180
[ 4548.469663] [     T48]  ? lockdep_hardirqs_off+0xaf/0xf0
[ 4548.470008] [     T48]  ? do_syscall_64+0x60/0x690
[ 4548.470386] [     T48]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[ 4548.470747] [     T48] RIP: 0033:0x7fb94423d54e
[ 4548.471149] [     T48] RSP: 002b:00007ffef5d375a0 EFLAGS: 00000202 ORIG_RAX: 0000000000000001
[ 4548.471506] [     T48] RAX: ffffffffffffffda RBX: 00007fb9443be580 RCX: 00007fb94423d54e
[ 4548.471869] [     T48] RDX: 0000000000000001 RSI: 000055c9e7267150 RDI: 0000000000000001
[ 4548.472223] [     T48] RBP: 00007ffef5d375b0 R08: 0000000000000000 R09: 0000000000000000
[ 4548.472553] [     T48] R10: 0000000000000000 R11: 0000000000000202 R12: 0000000000000001
[ 4548.472895] [     T48] R13: 0000000000000001 R14: 000055c9e7267150 R15: 0000000000000000
[ 4548.473260] [     T48]  </TASK>
[ 4548.473585] [     T48] 
                          Showing all locks held in the system:
[ 4548.474272] [     T48] locks held by pr/ttyS0/47: 2, last CPU#2:
[ 4548.474572] [     T48]  #0: ffffffff8b89ffd8 (console_srcu){....}-{0:0}, at: console_srcu_read_lock+0x45/0x60
[ 4548.474909] [     T48]  #1: ffffffffa2730278 (&port_lock_key){-.-.}-{3:3}, at: univ8250_console_device_lock+0x52/0xa0
[ 4548.475280] [     T48] locks held by khungtaskd/48: 1, last CPU#1:
[ 4548.475633] [     T48]  #0: ffffffff8b8b1e00 (rcu_read_lock){....}-{1:3}, at: debug_show_all_locks+0x39/0x180
[ 4548.476031] [     T48] locks held by check/66191: 3, on CPU#1:
[ 4548.476389] [     T48]  #0: ffff888142c0e478 (sb_writers#12){.+.+}-{0:0}, at: ksys_write+0x112/0x250
[ 4548.476787] [     T48]  #1: ffff888144737e80 (&buffer->mutex){+.+.}-{4:4}, at: configfs_write_iter+0x6d/0x4a0
[ 4548.477199] [     T48]  #2: ffff88813c09b070 (&p->frag_sem){++++}-{4:4}, at: configfs_write_iter+0x1db/0x4a0
[ 4548.477591] [     T48] locks held by kworker/2:1/67503: 4, last CPU#2:
[ 4548.477953] [     T48]  #0: ffff888100194148 ((wq_completion)events){+.+.}-{0:0}, at: process_one_work+0x1109/0x1760
[ 4548.478360] [     T48]  #1: ffff888149d8fd10 ((work_completion)(&helper->damage_work)){+.+.}-{0:0}, at: process_one_work+0x8c0/0x1760
[ 4548.478766] [     T48]  #2: ffff888149d8fa30 (crtc_ww_class_acquire){+.+.}-{0:0}, at: drm_atomic_helper_dirtyfb+0xdf/0x770 [drm_kms_helper]
[ 4548.479238] [     T48]  #3: ffff888149d8fa58 (crtc_ww_class_mutex){+.+.}-{4:4}, at: drm_atomic_helper_dirtyfb+0xdf/0x770 [drm_kms_helper]

[ 4548.480086] [     T48] =============================================

[ 4671.327902] [     T48] INFO: task check:66191 blocked for more than 737 seconds.
[ 4671.330876] [     T48]       Not tainted 7.4.0-rc1 #487
[ 4671.333073] [     T48] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[ 4671.333513] [     T48] task:check           state:D stack:0     pid:66191 tgid:66191 ppid:23692  task_flags:0x400140 flags:0x00080000
[ 4671.333952] [     T48] Call Trace:
[ 4671.334436] [     T48]  <TASK>
[ 4671.334920] [     T48]  __schedule+0x1d90/0x6ea0
[ 4671.335389] [     T48]  ? __pfx___schedule+0x10/0x10
[ 4671.335804] [     T48]  ? lock_acquire+0x1c1/0x340
[ 4671.336222] [     T48]  ? schedule+0x24a/0x2e0
[ 4671.336651] [     T48]  ? lock_release+0x1b5/0x340
[ 4671.337072] [     T48]  ? __pfx_nvmet_passthru_enable_store+0x10/0x10 [nvmet]
[ 4671.338063] [     T48]  schedule+0xe3/0x2e0
[ 4671.338510] [     T48]  schedule_timeout+0x1ac/0x290
[ 4671.338932] [     T48]  ? __pfx_schedule_timeout+0x10/0x10
[ 4671.339383] [     T48]  ? lockdep_hardirqs_on_prepare+0xd5/0x1b0
[ 4671.339819] [     T48]  ? trace_hardirqs_on+0x14/0x190
[ 4671.340272] [     T48]  wait_for_completion+0x17a/0x400
[ 4671.340721] [     T48]  ? __pfx_wait_for_completion+0x10/0x10
[ 4671.341222] [     T48]  ? _raw_spin_unlock_irqrestore+0x4c/0x60
[ 4671.341678] [     T48]  __nvmet_passthru_ctrl_disable+0xcf/0x320 [nvmet]
[ 4671.342148] [     T48]  ? __pfx_nvmet_passthru_enable_store+0x10/0x10 [nvmet]
[ 4671.342725] [     T48]  nvmet_passthru_ctrl_disable+0x24/0x40 [nvmet]
[ 4671.343169] [     T48]  ? __kasan_kmalloc+0x96/0xb0
[ 4671.343583] [     T48]  nvmet_passthru_enable_store+0xa0/0x100 [nvmet]
[ 4671.344083] [     T48]  ? __pfx_nvmet_passthru_enable_store+0x10/0x10 [nvmet]
[ 4671.344581] [     T48]  ? configfs_write_iter+0x240/0x4a0
[ 4671.345036] [     T48]  configfs_write_iter+0x2ad/0x4a0
[ 4671.345463] [     T48]  ? __pfx_configfs_write_iter+0x10/0x10
[ 4671.345869] [     T48]  vfs_write+0x4b3/0xf40
[ 4671.346274] [     T48]  ? __pfx_vfs_write+0x10/0x10
[ 4671.346694] [     T48]  ? __lock_acquire+0x54a/0x2490
[ 4671.347117] [     T48]  ? lock_acquire+0x1b1/0x340
[ 4671.347536] [     T48]  ksys_write+0x112/0x250
[ 4671.347930] [     T48]  ? __pfx_ksys_write+0x10/0x10
[ 4671.348322] [     T48]  ? rcu_is_watching+0x12/0xb0
[ 4671.348720] [     T48]  do_syscall_64+0xf2/0x690
[ 4671.349100] [     T48]  ? rcu_is_watching+0x12/0xb0
[ 4671.349485] [     T48]  ? do_syscall_64+0x2d/0x690
[ 4671.349846] [     T48]  ? trace_hardirqs_off_finish+0x139/0x180
[ 4671.350209] [     T48]  ? lockdep_hardirqs_off+0xaf/0xf0
[ 4671.350578] [     T48]  ? do_syscall_64+0x60/0x690
[ 4671.350927] [     T48]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[ 4671.351420] [     T48] RIP: 0033:0x7fb94423d54e
[ 4671.351784] [     T48] RSP: 002b:00007ffef5d375a0 EFLAGS: 00000202 ORIG_RAX: 0000000000000001
[ 4671.352135] [     T48] RAX: ffffffffffffffda RBX: 00007fb9443be580 RCX: 00007fb94423d54e
[ 4671.352490] [     T48] RDX: 0000000000000001 RSI: 000055c9e7267150 RDI: 0000000000000001
[ 4671.352822] [     T48] RBP: 00007ffef5d375b0 R08: 0000000000000000 R09: 0000000000000000
[ 4671.353155] [     T48] R10: 0000000000000000 R11: 0000000000000202 R12: 0000000000000001
[ 4671.353501] [     T48] R13: 0000000000000001 R14: 000055c9e7267150 R15: 0000000000000000
[ 4671.353837] [     T48]  </TASK>
[ 4671.354177] [     T48] 
                          Showing all locks held in the system:
[ 4671.354803] [     T48] locks held by pr/ttyS0/47: 2, last CPU#0:
[ 4671.355107] [     T48]  #0: ffffffff8b89ffd8 (console_srcu){....}-{0:0}, at: console_srcu_read_lock+0x45/0x60
[ 4671.355450] [     T48]  #1: ffffffffa2730278 (&port_lock_key){-.-.}-{3:3}, at: univ8250_console_device_lock+0x52/0xa0
[ 4671.355787] [     T48] locks held by khungtaskd/48: 1, last CPU#1:
[ 4671.356110] [     T48]  #0: ffffffff8b8b1e00 (rcu_read_lock){....}-{1:3}, at: debug_show_all_locks+0x39/0x180
[ 4671.356500] [     T48] locks held by check/66191: 3, on CPU#1:
[ 4671.356833] [     T48]  #0: ffff888142c0e478 (sb_writers#12){.+.+}-{0:0}, at: ksys_write+0x112/0x250
[ 4671.357193] [     T48]  #1: ffff888144737e80 (&buffer->mutex){+.+.}-{4:4}, at: configfs_write_iter+0x6d/0x4a0
[ 4671.357568] [     T48]  #2: ffff88813c09b070 (&p->frag_sem){++++}-{4:4}, at: configfs_write_iter+0x1db/0x4a0
[ 4671.357931] [     T48] locks held by kworker/1:0/67499: 4, on CPU#1:
[ 4671.358285] [     T48]  #0: ffff888100194148 ((wq_completion)events){+.+.}-{0:0}, at: process_one_work+0x1109/0x1760
[ 4671.358678] [     T48]  #1: ffff888132427d10 ((work_completion)(&helper->damage_work)){+.+.}-{0:0}, at: process_one_work+0x8c0/0x1760
[ 4671.359068] [     T48]  #2: ffff8881325dca70 (&helper->lock){+.+.}-{4:4}, at: drm_fb_helper_damage_work+0x175/0xac0 [drm_client_lib]
[ 4671.359479] [     T48]  #3: ffff8881333e0128 (&dev->master_mutex){+.+.}-{4:4}, at: drm_master_internal_acquire+0x1b/0x60 [drm]

[ 4671.360318] [     T48] =============================================

[ 4794.208100] [     T48] INFO: task check:66191 blocked for more than 860 seconds.
[ 4794.211144] [     T48]       Not tainted 7.4.0-rc1 #487
[ 4794.215677] [     T48] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[ 4794.224293] [     T48] task:check           state:D stack:0     pid:66191 tgid:66191 ppid:23692  task_flags:0x400140 flags:0x00080000
[ 4794.229298] [     T48] Call Trace:
[ 4794.234298] [     T48]  <TASK>
[ 4794.237617] [     T48]  __schedule+0x1d90/0x6ea0
[ 4794.239988] [     T48]  ? __pfx___schedule+0x10/0x10
[ 4794.242296] [     T48]  ? lock_acquire+0x1c1/0x340
[ 4794.244784] [     T48]  ? schedule+0x24a/0x2e0
[ 4794.245819] [     T48]  ? lock_release+0x1b5/0x340
[ 4794.246801] [     T48]  ? __pfx_nvmet_passthru_enable_store+0x10/0x10 [nvmet]
[ 4794.247868] [     T48]  schedule+0xe3/0x2e0
[ 4794.248685] [     T48]  schedule_timeout+0x1ac/0x290
[ 4794.249510] [     T48]  ? __pfx_schedule_timeout+0x10/0x10
[ 4794.250158] [     T48]  ? lockdep_hardirqs_on_prepare+0xd5/0x1b0
[ 4794.250623] [     T48]  ? trace_hardirqs_on+0x14/0x190
[ 4794.251035] [     T48]  wait_for_completion+0x17a/0x400
[ 4794.251440] [     T48]  ? __pfx_wait_for_completion+0x10/0x10
[ 4794.251893] [     T48]  ? _raw_spin_unlock_irqrestore+0x4c/0x60
[ 4794.252297] [     T48]  __nvmet_passthru_ctrl_disable+0xcf/0x320 [nvmet]
[ 4794.252766] [     T48]  ? __pfx_nvmet_passthru_enable_store+0x10/0x10 [nvmet]
[ 4794.253190] [     T48]  nvmet_passthru_ctrl_disable+0x24/0x40 [nvmet]
[ 4794.253640] [     T48]  ? __kasan_kmalloc+0x96/0xb0
[ 4794.254053] [     T48]  nvmet_passthru_enable_store+0xa0/0x100 [nvmet]
[ 4794.254476] [     T48]  ? __pfx_nvmet_passthru_enable_store+0x10/0x10 [nvmet]
[ 4794.254908] [     T48]  ? configfs_write_iter+0x240/0x4a0
[ 4794.255353] [     T48]  configfs_write_iter+0x2ad/0x4a0
[ 4794.255767] [     T48]  ? __pfx_configfs_write_iter+0x10/0x10
[ 4794.256195] [     T48]  vfs_write+0x4b3/0xf40
[ 4794.256592] [     T48]  ? __pfx_vfs_write+0x10/0x10
[ 4794.257031] [     T48]  ? __lock_acquire+0x54a/0x2490
[ 4794.257499] [     T48]  ? lock_acquire+0x1b1/0x340
[ 4794.257931] [     T48]  ksys_write+0x112/0x250
[ 4794.258364] [     T48]  ? __pfx_ksys_write+0x10/0x10
[ 4794.258795] [     T48]  ? rcu_is_watching+0x12/0xb0
[ 4794.259198] [     T48]  do_syscall_64+0xf2/0x690
[ 4794.259606] [     T48]  ? rcu_is_watching+0x12/0xb0
[ 4794.259980] [     T48]  ? do_syscall_64+0x2d/0x690
[ 4794.260367] [     T48]  ? trace_hardirqs_off_finish+0x139/0x180
[ 4794.260764] [     T48]  ? lockdep_hardirqs_off+0xaf/0xf0
[ 4794.261142] [     T48]  ? do_syscall_64+0x60/0x690
[ 4794.261487] [     T48]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[ 4794.261855] [     T48] RIP: 0033:0x7fb94423d54e
[ 4794.262230] [     T48] RSP: 002b:00007ffef5d375a0 EFLAGS: 00000202 ORIG_RAX: 0000000000000001
[ 4794.262573] [     T48] RAX: ffffffffffffffda RBX: 00007fb9443be580 RCX: 00007fb94423d54e
[ 4794.262918] [     T48] RDX: 0000000000000001 RSI: 000055c9e7267150 RDI: 0000000000000001
[ 4794.263315] [     T48] RBP: 00007ffef5d375b0 R08: 0000000000000000 R09: 0000000000000000
[ 4794.263639] [     T48] R10: 0000000000000000 R11: 0000000000000202 R12: 0000000000000001
[ 4794.263977] [     T48] R13: 0000000000000001 R14: 000055c9e7267150 R15: 0000000000000000
[ 4794.264341] [     T48]  </TASK>
[ 4794.264694] [     T48] 
                          Showing all locks held in the system:
[ 4794.265323] [     T48] locks held by pr/ttyS0/47: 2, last CPU#0:
[ 4794.265648] [     T48]  #0: ffffffff8b89ffd8 (console_srcu){....}-{0:0}, at: console_srcu_read_lock+0x45/0x60
[ 4794.266013] [     T48]  #1: ffffffffa2730278 (&port_lock_key){-.-.}-{3:3}, at: univ8250_console_device_lock+0x52/0xa0
[ 4794.266377] [     T48] locks held by khungtaskd/48: 1, last CPU#3:
[ 4794.266691] [     T48]  #0: ffffffff8b8b1e00 (rcu_read_lock){....}-{1:3}, at: debug_show_all_locks+0x39/0x180
[ 4794.267074] [     T48] locks held by check/66191: 3, on CPU#1:
[ 4794.267433] [     T48]  #0: ffff888142c0e478 (sb_writers#12){.+.+}-{0:0}, at: ksys_write+0x112/0x250
[ 4794.267836] [     T48]  #1: ffff888144737e80 (&buffer->mutex){+.+.}-{4:4}, at: configfs_write_iter+0x6d/0x4a0
[ 4794.268249] [     T48]  #2: ffff88813c09b070 (&p->frag_sem){++++}-{4:4}, at: configfs_write_iter+0x1db/0x4a0
[ 4794.268636] [     T48] locks held by kworker/1:0/67499: 5, last CPU#1:
[ 4794.268996] [     T48]  #0: ffff888100194148 ((wq_completion)events){+.+.}-{0:0}, at: process_one_work+0x1109/0x1760
[ 4794.269437] [     T48]  #1: ffff888132427d10 ((work_completion)(&helper->damage_work)){+.+.}-{0:0}, at: process_one_work+0x8c0/0x1760
[ 4794.269829] [     T48]  #2: ffff888132427a30 (crtc_ww_class_acquire){+.+.}-{0:0}, at: drm_atomic_helper_dirtyfb+0xdf/0x770 [drm_kms_helper]
[ 4794.270292] [     T48]  #3: ffff888132427a58 (crtc_ww_class_mutex){+.+.}-{4:4}, at: drm_atomic_helper_dirtyfb+0xdf/0x770 [drm_kms_helper]
[ 4794.270733] [     T48]  #4: ffff8883ac6c63e0 (&rq->__lock){-.-.}-{2:2}, at: raw_spin_rq_lock_nested+0x30/0x170

[ 4794.271606] [     T48] =============================================

[ 4917.088498] [     T48] INFO: task check:66191 blocked for more than 983 seconds.
[ 4917.091381] [     T48]       Not tainted 7.4.0-rc1 #487
[ 4917.094687] [     T48] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[ 4917.095130] [     T48] task:check           state:D stack:0     pid:66191 tgid:66191 ppid:23692  task_flags:0x400140 flags:0x00080000
[ 4917.095578] [     T48] Call Trace:
[ 4917.096050] [     T48]  <TASK>
[ 4917.096474] [     T48]  __schedule+0x1d90/0x6ea0
[ 4917.096919] [     T48]  ? __pfx___schedule+0x10/0x10
[ 4917.097339] [     T48]  ? lock_acquire+0x1c1/0x340
[ 4917.097747] [     T48]  ? schedule+0x24a/0x2e0
[ 4917.098169] [     T48]  ? lock_release+0x1b5/0x340
[ 4917.098574] [     T48]  ? __pfx_nvmet_passthru_enable_store+0x10/0x10 [nvmet]
[ 4917.099014] [     T48]  schedule+0xe3/0x2e0
[ 4917.099436] [     T48]  schedule_timeout+0x1ac/0x290
[ 4917.099848] [     T48]  ? __pfx_schedule_timeout+0x10/0x10
[ 4917.100378] [     T48]  ? lockdep_hardirqs_on_prepare+0xd5/0x1b0
[ 4917.100841] [     T48]  ? trace_hardirqs_on+0x14/0x190
[ 4917.101259] [     T48]  wait_for_completion+0x17a/0x400
[ 4917.101698] [     T48]  ? __pfx_wait_for_completion+0x10/0x10
[ 4917.102123] [     T48]  ? _raw_spin_unlock_irqrestore+0x4c/0x60
[ 4917.102563] [     T48]  __nvmet_passthru_ctrl_disable+0xcf/0x320 [nvmet]
[ 4917.103023] [     T48]  ? __pfx_nvmet_passthru_enable_store+0x10/0x10 [nvmet]
[ 4917.103465] [     T48]  nvmet_passthru_ctrl_disable+0x24/0x40 [nvmet]
[ 4917.103922] [     T48]  ? __kasan_kmalloc+0x96/0xb0
[ 4917.104337] [     T48]  nvmet_passthru_enable_store+0xa0/0x100 [nvmet]
[ 4917.104794] [     T48]  ? __pfx_nvmet_passthru_enable_store+0x10/0x10 [nvmet]
[ 4917.105350] [     T48]  ? configfs_write_iter+0x240/0x4a0
[ 4917.105815] [     T48]  configfs_write_iter+0x2ad/0x4a0
[ 4917.106244] [     T48]  ? __pfx_configfs_write_iter+0x10/0x10
[ 4917.106643] [     T48]  vfs_write+0x4b3/0xf40
[ 4917.107082] [     T48]  ? __pfx_vfs_write+0x10/0x10
[ 4917.107498] [     T48]  ? __lock_acquire+0x54a/0x2490
[ 4917.107935] [     T48]  ? lock_acquire+0x1b1/0x340
[ 4917.108345] [     T48]  ksys_write+0x112/0x250
[ 4917.108765] [     T48]  ? __pfx_ksys_write+0x10/0x10
[ 4917.109159] [     T48]  ? rcu_is_watching+0x12/0xb0
[ 4917.109533] [     T48]  do_syscall_64+0xf2/0x690
[ 4917.109934] [     T48]  ? rcu_is_watching+0x12/0xb0
[ 4917.110315] [     T48]  ? do_syscall_64+0x2d/0x690
[ 4917.110692] [     T48]  ? trace_hardirqs_off_finish+0x139/0x180
[ 4917.111058] [     T48]  ? lockdep_hardirqs_off+0xaf/0xf0
[ 4917.111418] [     T48]  ? do_syscall_64+0x60/0x690
[ 4917.111795] [     T48]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[ 4917.112146] [     T48] RIP: 0033:0x7fb94423d54e
[ 4917.112506] [     T48] RSP: 002b:00007ffef5d375a0 EFLAGS: 00000202 ORIG_RAX: 0000000000000001
[ 4917.112876] [     T48] RAX: ffffffffffffffda RBX: 00007fb9443be580 RCX: 00007fb94423d54e
[ 4917.113218] [     T48] RDX: 0000000000000001 RSI: 000055c9e7267150 RDI: 0000000000000001
[ 4917.113541] [     T48] RBP: 00007ffef5d375b0 R08: 0000000000000000 R09: 0000000000000000
[ 4917.113899] [     T48] R10: 0000000000000000 R11: 0000000000000202 R12: 0000000000000001
[ 4917.114242] [     T48] R13: 0000000000000001 R14: 000055c9e7267150 R15: 0000000000000000
[ 4917.114570] [     T48]  </TASK>
[ 4917.114927] [     T48] 
                          Showing all locks held in the system:
[ 4917.115548] [     T48] locks held by pr/ttyS0/47: 2, last CPU#0:
[ 4917.115876] [     T48]  #0: ffffffff8b89ffd8 (console_srcu){....}-{0:0}, at: console_srcu_read_lock+0x45/0x60
[ 4917.116211] [     T48]  #1: ffffffffa2730278 (&port_lock_key){-.-.}-{3:3}, at: univ8250_console_device_lock+0x52/0xa0
[ 4917.116539] [     T48] locks held by khungtaskd/48: 1, last CPU#3:
[ 4917.116908] [     T48]  #0: ffffffff8b8b1e00 (rcu_read_lock){....}-{1:3}, at: debug_show_all_locks+0x39/0x180
[ 4917.117360] [     T48] locks held by check/66191: 3, on CPU#1:
[ 4917.117779] [     T48]  #0: ffff888142c0e478 (sb_writers#12){.+.+}-{0:0}, at: ksys_write+0x112/0x250
[ 4917.118219] [     T48]  #1: ffff888144737e80 (&buffer->mutex){+.+.}-{4:4}, at: configfs_write_iter+0x6d/0x4a0
[ 4917.118640] [     T48]  #2: ffff88813c09b070 (&p->frag_sem){++++}-{4:4}, at: configfs_write_iter+0x1db/0x4a0
[ 4917.119634] [     T48] locks held by kworker/3:1/67508: 4, on CPU#3:
[ 4917.120083] [     T48]  #0: ffff888100194148 ((wq_completion)events){+.+.}-{0:0}, at: process_one_work+0x1109/0x1760
[ 4917.120552] [     T48]  #1: ffff8881f7c6fd10 ((work_completion)(&helper->damage_work)){+.+.}-{0:0}, at: process_one_work+0x8c0/0x1760
[ 4917.121046] [     T48]  #2: ffff8881f7c6fa30 (crtc_ww_class_acquire){+.+.}-{0:0}, at: drm_atomic_helper_dirtyfb+0xdf/0x770 [drm_kms_helper]
[ 4917.121530] [     T48]  #3: ffff8881f7c6fa58 (crtc_ww_class_mutex){+.+.}-{4:4}, at: drm_atomic_helper_dirtyfb+0xdf/0x770 [drm_kms_helper]

[ 4917.122488] [     T48] =============================================

[ 5039.968890] [     T48] INFO: task check:66191 blocked for more than 1105 seconds.
[ 5039.971621] [     T48]       Not tainted 7.4.0-rc1 #487
[ 5039.973962] [     T48] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[ 5039.974377] [     T48] task:check           state:D stack:0     pid:66191 tgid:66191 ppid:23692  task_flags:0x400140 flags:0x00080000
[ 5039.974837] [     T48] Call Trace:
[ 5039.975271] [     T48]  <TASK>
[ 5039.975690] [     T48]  __schedule+0x1d90/0x6ea0
[ 5039.976159] [     T48]  ? __pfx___schedule+0x10/0x10
[ 5039.976625] [     T48]  ? lock_acquire+0x1c1/0x340
[ 5039.977093] [     T48]  ? schedule+0x24a/0x2e0
[ 5039.977523] [     T48]  ? lock_release+0x1b5/0x340
[ 5039.977911] [     T48]  ? __pfx_nvmet_passthru_enable_store+0x10/0x10 [nvmet]
[ 5039.978365] [     T48]  schedule+0xe3/0x2e0
[ 5039.978805] [     T48]  schedule_timeout+0x1ac/0x290
[ 5039.979246] [     T48]  ? __pfx_schedule_timeout+0x10/0x10
[ 5039.979690] [     T48]  ? lockdep_hardirqs_on_prepare+0xd5/0x1b0
[ 5039.980120] [     T48]  ? trace_hardirqs_on+0x14/0x190
[ 5039.980560] [     T48]  wait_for_completion+0x17a/0x400
[ 5039.980980] [     T48]  ? __pfx_wait_for_completion+0x10/0x10
[ 5039.981390] [     T48]  ? _raw_spin_unlock_irqrestore+0x4c/0x60
[ 5039.981812] [     T48]  __nvmet_passthru_ctrl_disable+0xcf/0x320 [nvmet]
[ 5039.982303] [     T48]  ? __pfx_nvmet_passthru_enable_store+0x10/0x10 [nvmet]
[ 5039.982805] [     T48]  nvmet_passthru_ctrl_disable+0x24/0x40 [nvmet]
[ 5039.983253] [     T48]  ? __kasan_kmalloc+0x96/0xb0
[ 5039.983701] [     T48]  nvmet_passthru_enable_store+0xa0/0x100 [nvmet]
[ 5039.984148] [     T48]  ? __pfx_nvmet_passthru_enable_store+0x10/0x10 [nvmet]
[ 5039.984588] [     T48]  ? configfs_write_iter+0x240/0x4a0
[ 5039.985000] [     T48]  configfs_write_iter+0x2ad/0x4a0
[ 5039.985406] [     T48]  ? __pfx_configfs_write_iter+0x10/0x10
[ 5039.985826] [     T48]  vfs_write+0x4b3/0xf40
[ 5039.986231] [     T48]  ? __pfx_vfs_write+0x10/0x10
[ 5039.986650] [     T48]  ? __lock_acquire+0x54a/0x2490
[ 5039.987060] [     T48]  ? lock_acquire+0x1b1/0x340
[ 5039.987474] [     T48]  ksys_write+0x112/0x250
[ 5039.987867] [     T48]  ? __pfx_ksys_write+0x10/0x10
[ 5039.988258] [     T48]  ? rcu_is_watching+0x12/0xb0
[ 5039.988654] [     T48]  do_syscall_64+0xf2/0x690
[ 5039.989033] [     T48]  ? rcu_is_watching+0x12/0xb0
[ 5039.989405] [     T48]  ? do_syscall_64+0x2d/0x690
[ 5039.989820] [     T48]  ? trace_hardirqs_off_finish+0x139/0x180
[ 5039.990225] [     T48]  ? lockdep_hardirqs_off+0xaf/0xf0
[ 5039.990670] [     T48]  ? do_syscall_64+0x60/0x690
[ 5039.991070] [     T48]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[ 5039.991405] [     T48] RIP: 0033:0x7fb94423d54e
[ 5039.991801] [     T48] RSP: 002b:00007ffef5d375a0 EFLAGS: 00000202 ORIG_RAX: 0000000000000001
[ 5039.992163] [     T48] RAX: ffffffffffffffda RBX: 00007fb9443be580 RCX: 00007fb94423d54e
[ 5039.992547] [     T48] RDX: 0000000000000001 RSI: 000055c9e7267150 RDI: 0000000000000001
[ 5039.992919] [     T48] RBP: 00007ffef5d375b0 R08: 0000000000000000 R09: 0000000000000000
[ 5039.993270] [     T48] R10: 0000000000000000 R11: 0000000000000202 R12: 0000000000000001
[ 5039.993636] [     T48] R13: 0000000000000001 R14: 000055c9e7267150 R15: 0000000000000000
[ 5039.993986] [     T48]  </TASK>
[ 5039.994312] [     T48] 
                          Showing all locks held in the system:
[ 5039.994934] [     T48] locks held by pr/ttyS0/47: 2, last CPU#0:
[ 5039.995237] [     T48]  #0: ffffffff8b89ffd8 (console_srcu){....}-{0:0}, at: console_srcu_read_lock+0x45/0x60
[ 5039.995578] [     T48]  #1: ffffffffa2730278 (&port_lock_key){-.-.}-{3:3}, at: univ8250_console_device_lock+0x52/0xa0
[ 5039.995925] [     T48] locks held by khungtaskd/48: 1, last CPU#3:
[ 5039.996249] [     T48]  #0: ffffffff8b8b1e00 (rcu_read_lock){....}-{1:3}, at: debug_show_all_locks+0x39/0x180
[ 5039.996639] [     T48] locks held by check/66191: 3, on CPU#1:
[ 5039.996972] [     T48]  #0: ffff888142c0e478 (sb_writers#12){.+.+}-{0:0}, at: ksys_write+0x112/0x250
[ 5039.997331] [     T48]  #1: ffff888144737e80 (&buffer->mutex){+.+.}-{4:4}, at: configfs_write_iter+0x6d/0x4a0
[ 5039.997705] [     T48]  #2: ffff88813c09b070 (&p->frag_sem){++++}-{4:4}, at: configfs_write_iter+0x1db/0x4a0
[ 5039.998073] [     T48] locks held by kworker/1:1/67542: 4, on CPU#1:
[ 5039.998438] [     T48]  #0: ffff888100194148 ((wq_completion)events){+.+.}-{0:0}, at: process_one_work+0x1109/0x1760
[ 5039.998816] [     T48]  #1: ffff8881a7bbfd10 ((work_completion)(&helper->damage_work)){+.+.}-{0:0}, at: process_one_work+0x8c0/0x1760
[ 5039.999247] [     T48]  #2: ffff8881325dca70 (&helper->lock){+.+.}-{4:4}, at: drm_fb_helper_damage_work+0x175/0xac0 [drm_client_lib]
[ 5039.999695] [     T48]  #3: ffff8881333e0128 (&dev->master_mutex){+.+.}-{4:4}, at: drm_master_internal_acquire+0x1b/0x60 [drm]

[ 5040.000606] [     T48] =============================================


