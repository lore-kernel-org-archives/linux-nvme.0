Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7310DD44153
	for <linux-nvme@archiver.kernel.org>; Tue, 19 Nov 2024 12:44:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0BD4kgu9QuE0+P9Xi/PcoWxtEL2AZaYbukxq2L2N1GQ=; b=4drEke5liRRsa2RcAn9LdRx96k
	GJ/9zrVG7rsinZe4Pxkdc7Jb3RP8eox7Pys8D0pZSIDwy97MkPgB8DiRAtzv1vqtn3q4t06Cm95gT
	D3d9rQwwg13yxAg0ZlwPphVGuf/zDPLmF+pO3mZbhcJJw7kr7rg3Le7HqAjzVoAgWtsg/HnZ+AMiy
	v1+CLF8kfdkZqa0OjDypQ7T5hOldlW/MHzZIjaJigpnTfFftQhndGt9LTUJDXk+jXzkC+fitpS4X7
	BCzVUTPznYgbJFertjGoVw+CbxSAthYLI4COy2ld+qMEuhc9lfsaDto4vPxP6gcT/GyV8GRhzGw2m
	4Ew7cvNA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tDNau-0000000CP0s-3NkC;
	Tue, 19 Nov 2024 12:44:36 +0000
Received: from esa3.hgst.iphmx.com ([216.71.153.141])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tDNat-0000000COzd-0HO1
	for linux-nvme@lists.infradead.org;
	Tue, 19 Nov 2024 12:44:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1732020275; x=1763556275;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=JMh4VAR67RLXPNDo0G162U9adA87wihaYmNpVi/kBoU=;
  b=O8xzLbnk3w2HNu1/AtIY7WL+sR+yhhT7sE9Xv3MlNMs3rq1Ymsd4oZSk
   czJmLcnTFPMW677koJjH3/lAjFnlWsrMQngoz2HlltDsVJIIjfQwd0oGH
   LjZ2RCdgP1kQg/VRdV2v1t9IisYkA0eMV0G66vnABluNMdRmYrHrIUlOh
   +IVWuVYPAPVXWudlsvIDksYSI/zqd0WuVcdUwpH8OKSyuSSY+hzzel1la
   m6by+/RR0U8B2kHaMC61NnSUm6Fy9QxGE2gSwrm5w+I4W4FQvMlFLhdDt
   /lPmA3LIQIc+Q+2ltEMWBL1E8HUEs6O8MwgXP5uwDWZT8FXy+eOc/wOcv
   A==;
X-CSE-ConnectionGUID: /PDR7sy4RcCP6CwIsSQOpg==
X-CSE-MsgGUID: rXoI/W79RxGHDRMkyF2LpQ==
X-IronPort-AV: E=Sophos;i="6.12,166,1728921600"; 
   d="scan'208";a="31912275"
Received: from mail-westcentralusazlp17010000.outbound.protection.outlook.com (HELO CY4PR05CU001.outbound.protection.outlook.com) ([40.93.6.0])
  by ob1.hgst.iphmx.com with ESMTP; 19 Nov 2024 20:44:34 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j2JDjIUTxVuH0ftQQQ06E/syIvUYr70hB0+HIZRLuJaHANeotzFGB6p+ddKR4bMMxzYkhPjISCzY7P7TgckYVKJAG34XsQrLsunyhK+2cNxV6q/K8FlIRPpjXHIoGcPHocjkcn8ZU8eTDa+fFHXiqVTrhtAnyvf0cxD+eDTZndMCre9B506BeCBWBui1n62+lTtTxg2IqnJ29S+TEP77Ct/hmXElG+GnDWj/2EDMxuTKLKHzuU9dWDptb9j4HJKp6TdP9oW35f9lC2ufNC2gyVQd8BFaS1xIA6e8T79ybn5MbxfxhzLk9tvlpEMudtxAX7WcjHVHXuwWyGisLv/kUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0BD4kgu9QuE0+P9Xi/PcoWxtEL2AZaYbukxq2L2N1GQ=;
 b=KmCLIt5QJkPHdWNZNv9/W2MMcTS7ExJCzrEZDBbhWkv1KoMqXsvog+sQ2dg/0riu0QDSxDv0BcA1UP5nXcOpnAortzp76St861T2bWTlcv+GNnQopGWcOHWiaG1WrdCbT7ZyCynowi1KsErk0NE15c+XGbDI29hT4LasjBVAgb5BEEaWHepgmBVSGNnsZTKArB1u7mLsUBTIWUsqruGV5/JZ7ZO/a8ZUxzKEVJ7kdT/O86wVBAN8VAp/ItKZqHJyaRzQvv2RwLCwwQTN0tjM+7Gakn8pc9sf2ndMcrRulAvYhYohGPIsFkQp/fqK7B1isNXEY5rYeog0/G78NL+BIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0BD4kgu9QuE0+P9Xi/PcoWxtEL2AZaYbukxq2L2N1GQ=;
 b=r8R6cBiYvivt8D8Aos85YY7oSktZH3a5GzItbfu096GxegrCQkehkZSyFL/gTfIR6drH7olDG614dYkfjwl9ty2XyvboQybOO7ewWtByc43JmZYq7YI4Wq1SMJySexFS9+bZIwyMX6KYB1G8LECo9QVKtI9DH3i9t/6+j3/Vb/4=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 LV8PR04MB9294.namprd04.prod.outlook.com (2603:10b6:408:259::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8158.24; Tue, 19 Nov 2024 12:44:31 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b27f:cdfa:851:e89a]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b27f:cdfa:851:e89a%4]) with mapi id 15.20.8182.014; Tue, 19 Nov 2024
 12:44:31 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
CC: Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH blktests 0/8] nvme: prepare for ANA support: cont.
Thread-Topic: [PATCH blktests 0/8] nvme: prepare for ANA support: cont.
Thread-Index: AQHbMQYkHRSYcGyE0U6xIyLKWNo83rK+n3+A
Date: Tue, 19 Nov 2024 12:44:31 +0000
Message-ID: <4eagwlqnmwzxa6s4qfgrwajitoux3hafkpd3aiy42oaq2ejohj@ywyzce2hpyqm>
References: <20241107111354.80606-1-shinichiro.kawasaki@wdc.com>
In-Reply-To: <20241107111354.80606-1-shinichiro.kawasaki@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|LV8PR04MB9294:EE_
x-ms-office365-filtering-correlation-id: ab642a09-02f4-4f89-c218-08dd0897e9de
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?cQ9zLa+3NpByNV0NMMZr1AGZkypDviVL9TNKzKjPcXs9w/CbIX8di2Aop2/C?=
 =?us-ascii?Q?8QzByg34lKJesDUP2f1bspFniPwdyS/iRg3TxaSH47/+Vrs0kmARA19WNyQR?=
 =?us-ascii?Q?ocXGpvNwl8GYZlirTMdFPPe5y3jJQnYzTKkeEoh8n4Xs51ACF7KN4HgdkRni?=
 =?us-ascii?Q?4goj7CvRFeum3T0UXI75iLA9rGaun8G0KtpypgTJmxA189LTXNkTXpkn0Qit?=
 =?us-ascii?Q?b4Dk9KecZoqRRM/m8qbjYbCBvthwqarU1ClbD2ax/1iVCMqFgG78TE89Na2l?=
 =?us-ascii?Q?hzdlV2+wxrL2hSolx3C+9dgLbtrUrdO+J8BUBwxTqeDvnYyww3tgmWWZ8/Dn?=
 =?us-ascii?Q?02vhKFpsP0NbrUdliDd78BSu6shQg8lNvsMw2cPUBH8SNOdvz2epsL1tlTXx?=
 =?us-ascii?Q?Ng++6xNYnKpOajtz1vnyqJe/gKq8e1k+YEI33+ZJWz1vp0EmYk+GvauoI05/?=
 =?us-ascii?Q?7oDpfaALlZpZJGC+J/ZToQS1zRJGNGzJfJbwmXQCoYKP9wFBtq1tiFR7CZMd?=
 =?us-ascii?Q?XcpxQQGcCjcQ2rUp8m+y8rRNfAVc/e9jfCjJzEK4ErRdmsEMXQWMQn4T/lx6?=
 =?us-ascii?Q?PAFZzrqzw2OiT68k1za2CJXLd10hV1faoAbz0WgAh9YOJLOzFMkME6wrZkwL?=
 =?us-ascii?Q?zTLA9AQK+iqgGeUoBsiTveeSAmJPxUMnhwm+yChHGPe+tOamAsnzFYc06lr+?=
 =?us-ascii?Q?vMcfhd4aq+RkDSEVQvFuO52bxqlo9urTFIxWJ0GzhQjrEWFqB0vgkssBw3Dx?=
 =?us-ascii?Q?mtEy4n7HIF1dp5f5IdvuhzJbBqVk+FQ/CVUFWVJ6a6H/6cSiaoXXr+WEKkYN?=
 =?us-ascii?Q?V+Rg9obi8b8k2HeEnXlsC9Orju6eI0tQmQWzfCfAiO8T1+HbNQ3PxSSXqN1p?=
 =?us-ascii?Q?MJ75itdapfKyKcv/LLdmX0lxxHTo0JaFovgBV8JFVK5OXSvE6oHrdRWOGn9k?=
 =?us-ascii?Q?LqqyUXHAy9DG4PLLiy/PyyKcoXGhZTOrS8koO2v9NpB1TFyCDjJ0+WZ/MzvI?=
 =?us-ascii?Q?Qi24h7/gGybiS2LJ3HhHCol5DkL0PD4vR46R9mxSKcOCufwYtk4bxwl6/9En?=
 =?us-ascii?Q?NSqvtX1u8O3ZmH6T+U4NAbLnIItXxntQXuGCKwVCT+nw5qogBAM58pj1pKzb?=
 =?us-ascii?Q?TmXq2goB0LV4rMMslC4eGQt00LbbzCNloKSp/Jwr6xKdeE0JHIts6Ye3wtLy?=
 =?us-ascii?Q?IBhNivgvsuM1Q6b5OQ2t4JMXO9kQU4By/SKhrGNAIm61xfK5aIueVeU+Dst5?=
 =?us-ascii?Q?iJazBrETKew68qiAdJTI7o9CoMRfqKbICL9i5r4DHFPtnRehnH6Q6BMISYQz?=
 =?us-ascii?Q?N+DGQWMk7LDfSm3sqe3yAsEEDTCfB665YKk/8D8OnYPUJ10TWjUyI/MACoEw?=
 =?us-ascii?Q?eS9fpVDFTBpLQ+Fktk35GxJCdw3i?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?XIfU05ALeVkcfmR+UcCxbJtKB9qoKuEunaYuOxFcal2gCaVMOEKzwxI41J5X?=
 =?us-ascii?Q?X9G2drHmpHVyoIM0qeZLr07zMTqS1T5wCTOByoiUb0cIjiNIMhUN4x8VO/Mn?=
 =?us-ascii?Q?ImCEMddR+mfvGNP+tA9qUlCp3KwMALw0OMwoCFKaH4pLE4xrWMvNNLkW+5fI?=
 =?us-ascii?Q?bfJN4x3J07Yf7yTo1JdIna+aCYwN2AGknrjCmJHswpUQb1RiFtFx0IqpaohZ?=
 =?us-ascii?Q?Jqqtw7T5jsCIdIREOyU2gVls4MkUhlRsjXnRZdPbp3zseEXZ6hr7ZGqoDYKH?=
 =?us-ascii?Q?N2DczL+zMq/IhmzsWImmiVozR0UKo9bBqOdxPdnoppWpQYTALAbZhw06RHMo?=
 =?us-ascii?Q?4RJmsLjVG8dALlHDYS0L0NUL2CVJUajVetPgQmdNixwIed+NN9bmVWXtheDW?=
 =?us-ascii?Q?tDlYmXLa0fwPSNCtvy/GIEyHGCI2snIS2OIo+w5BQa1MGWH6bKXUmCB6SIGO?=
 =?us-ascii?Q?6tw17GULamHmVftcSijuFWS9pnvGO617w1ZniprYtDcDHZcBMkjHMzuNnBnJ?=
 =?us-ascii?Q?44zTnfe0N6qOFYsYlnw/JvyI7Kir4BR1QFavKyTjl+HqA+HBUGKs8033M3lz?=
 =?us-ascii?Q?/T3XOI0YUCjLifzX4+Y9i/F53DLvZj4RV1pdx0zZtTonYPV9wvjP64ltecZM?=
 =?us-ascii?Q?a24cvlesOt3b1MS3FZYvdzy5zOQ/N5PQ5AOAmVSeBdbfUp8gD3RCQSPqcm/o?=
 =?us-ascii?Q?9Iozkv/979b/zQGsXIS4e0SwkTWdPMZujl6Kk2rLF5qPPZFLtG1ebO5qKa9F?=
 =?us-ascii?Q?lRv9qgm58+LXG1d3AGSntTcMnWu6jO+KNKKTSgPMUzvMTUL4djjt26MFG2JJ?=
 =?us-ascii?Q?G5YhcU1cmyYYq3V/KTerCn5IJkTjGp8Bv9p/qtyh8iokbg+ob0EuorHx9QW8?=
 =?us-ascii?Q?7UnPAYfXtUXWE8i1w4YqPRQmSdJjlNbOneDBfT98nUSIM07ZIhHohn1UGHLP?=
 =?us-ascii?Q?XXO7HRvYE1kjJpwqjNu60TD3u+xlFgBuNzXyN3UNrV0JEXdYQ9aMrCat3+Kl?=
 =?us-ascii?Q?BTsaS3DDl+YGPCsjV5csbFEURgdPqwONnLXL/mEEwCkhNavZ6WevY0HvmLSd?=
 =?us-ascii?Q?3XrmP50MRRjbfSBYWt5uns7xTUdNM6tEYlmJwWE+XkKkY7v8CcG5SZrEgjWu?=
 =?us-ascii?Q?MDvbftgdG0eBXXRzv3jPOW3pRtarGA4vozt+sD0U56YILp16gUd6o26AFhur?=
 =?us-ascii?Q?NTrQ1bqtiUhwMAGPRz60rIyIr5921TJNSCGq6yYRninMokhUUXAP2FA4PFaQ?=
 =?us-ascii?Q?n7AMhURLM7RI6Ql+YlQlUQaof7t1ULinnm4TK8pRHsB1WYFcx17lqJ1SMNiQ?=
 =?us-ascii?Q?8Pp1Z4qEcdmAO1d8CiHKsVnsg6fAI8ZH47nsNOxWDpmTPUjtvC+jmOWRQKLC?=
 =?us-ascii?Q?7eBbF6r3MHwTFB8pjIbE0FpwHEb48tdB7/UAN0uKtmaM3DmLG2T7aH6kQhvN?=
 =?us-ascii?Q?XCxGfwGlMRCabXmLbB0U84vVZ7qxrG7IsgXzfnVmNlQ6EuAatGsXLes9UYrT?=
 =?us-ascii?Q?JOKnjK4FPQWfAfdki6uQQaeIk6UPXHizwsg+BLMUM4YN2g2JDZIXi6mmlB5g?=
 =?us-ascii?Q?oTs81JRqZYQeSTpq4XS6rEuOf2+zMj5yGh46dSxuNsk3amuBEojFCV6/JZor?=
 =?us-ascii?Q?IC0OLCAduenzbreVGs0MWss=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2902D74A0B356C4D9A0BA55602923468@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: aYAVPTJYMHhKu+PW3ao9fvYGoGRMZlHSyzEk8U0EQOhfwRzROt8ZYBd/HrLna9WvC7HH1WKsKaCQU6nda0Aja3ek1v4B3AWhBN7CJMSc+qzeSLPeTBy0n+K4Nme6BrQaSi3X854upOKGII1ZgpEmEjT2UlLS0RCqXNspydLEZL7MDSeJR9AUTdEOdxaqs8EA1s6h3oC5V24HHcT8Cm4cQAl96jyl8b0euVK2myM+DXlF1HWItHdjgObKyHo7fkB94MMsjaElX0M/uJxJeVBFd5hZG6vgzlu9Rmxd/fiDnOcvmgaK/60T4Se+k51uiTp8T8GCGUAcdiMPhhyRHn8TSuLT6nrYdj7kmT4MZsMSWs2rA571wYIufQx9WL3DIF9jej1pZgIlNnWKp3ED51IXyM5GnzIouaFtt1YPf9kcdsGroRd9D6z49O7P6mJiCvNI+mT0w1oyrAY8tByKGUx/N0Tk1+sHEKyGITdIuo1O1AcjwySOaIT+rYABHNUKKo74vytRV5SuDexot/nHu7UeObrLVGgwlFy79KVtcLeFIRahiTUJmU3ea+SxSs2D9Dqh6vxpLe33X5GNsvM3cIFx6l5ZPWaxMj3DncqAttBB8lZisinlVR4kcHgBvaL9RZ0G
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab642a09-02f4-4f89-c218-08dd0897e9de
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Nov 2024 12:44:31.2887
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FguHLshbA5GZ76d+2XRpcMuS+B4mx1iUhta1ibnK6ElqOyu+R+AO01Ak6YQhm/CF7ZP6xxWXWhPtJ9O3889eMSODGweovf7kqIYFFqhuZ3M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR04MB9294
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241119_044435_133715_51CD54DD 
X-CRM114-Status: GOOD (  12.06  )
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

On Nov 07, 2024 / 20:13, Shin'ichiro Kawasaki wrote:
> Hannes reworked the nvme test group scripts to support ANA, or Asymmetric
> Namespace Access. This work is tracked with GitHub PR 146 [1]. The amount=
 of
> change is large, then I split them into a few series for easier review. T=
his is
> the second series, which follows the first series [2]. The all eight patc=
hes in
> this series are script clean-ups. Review comments will be appreciated as =
always.
>=20
>   [1] https://github.com/osandov/blktests/pull/146
>   [2] https://lore.kernel.org/linux-nvme/20241030065149.2297405-1-shinich=
iro.kawasaki@wdc.com/

Thanks for the reviews. I applied this series except the 6th patch titled
"nvme/031: open-code helper functions" which needs more discussions. I plan=
 to
post next series within a week or so.=

