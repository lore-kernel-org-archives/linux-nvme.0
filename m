Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E561C369B1
	for <linux-nvme@archiver.kernel.org>; Wed, 16 Apr 2025 06:31:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:Message-ID:Date:Subject:CC:
	To:From:Reply-To:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=3edwXMX5IeMWnQzDl51xOvvUp0T3Bwg89/yA8Gojcd8=; b=xcX3g0B05oAXNcOfVjuGf76R3C
	CWYyX7M+CGZtnAnd5Z4GZA/QcVjVi4QQk/04su8x9BlRqOxLPSrbgulPexMh9v1YQXKweb3XMAaqN
	8n+Dd0/w31FUqbZvFTOWy73DlSaLp0wFK9DlEA1meEluw8uFbetssrcEvaOr4Qrin3gkVMdKKn5O8
	mxHNv7XRGzosvLbz2vUwaS7ii5DDPHI6QhrxBSYldGt/u4gxy+pVNsa+VXilfTRaoCACgOTdtBOBB
	pv8VTCsDc6D3egPWxsOzt06bzh82EVjJOBSPL6CCWgWnPpJ9CCquyAzkXqk4EiVjXvhmBlVaOCjEi
	W+w0fkIQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u4wJK-00000008PzO-1n33;
	Wed, 16 Apr 2025 06:31:50 +0000
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u4wJH-00000008Pyp-1Tsy
	for linux-nvme@lists.infradead.org;
	Wed, 16 Apr 2025 06:31:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1744785107; x=1776321107;
  h=from:to:cc:subject:date:message-id:content-id:
   content-transfer-encoding:mime-version;
  bh=yHGYWdbvkP6Q458R+1eooKKOKfVfvwMfHm57ZugIevk=;
  b=C56KLb4MSPh+itHSi+nGrR767JswRVfXfDQ8mrdcU/lNeca4YMHw4kb6
   GvWCPvTGoxgW1pYodjZiraDHqwJma7V/JwAyiBi588Jz6ctYLhnNavROs
   I8hG6GHa8gbTKYmqO9uQNc1QuUE31BRcNgZ4xdNlxVgOggsOcTQkKo1Ml
   8a08I6EZJ9zSxN6ooxtMIREO5DjlXA8Udyrx35xqXUAZKMxQdhsXVFY0I
   EjPbFipZnApdZ2Hg3z9hzRvE8YrufTE4nkfqyJfrKcKNP2UfdlKE+ffzJ
   dJ2CdSkusf9DiV+Kj/1BMyGy74d1S+T/S3PiYBfeBAwbuLWhoojMuWVGW
   A==;
X-CSE-ConnectionGUID: O+p4dgbKTa61BnVOA7rinw==
X-CSE-MsgGUID: F25wftRsSzOs+mMSsJIVcA==
X-IronPort-AV: E=Sophos;i="6.15,215,1739808000"; 
   d="scan'208";a="78303651"
Received: from mail-dm6nam12lp2175.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.175])
  by ob1.hgst.iphmx.com with ESMTP; 16 Apr 2025 14:31:43 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aiL1PFeC5NLRS8mecoYkS6uCfxtR+V/d5QaHJqKPzoipzHRxQDVxxBeyguRfuynrFsoGTKLcTe3sixn36lENM5owb2UYcQkCKIAZROAgGSL0Vo4rwtIlwoR4Y2t9jpOtrLfe2QkFuai0FZ/DA9bMbxSGYIwwJ/VjMsj/DuYq4J+S3gM/z1hELDiW6oI524kIV9LbZVOo3kEUiQ1MPWPwHDeS4MOOG9ubkXSck0W7/gRcNL34j9uqpCgVRS7r40vF13ftWjr+/o1kYyFKVoBPM1tq64Xp65CMGBOl0wVYfgc92L12jSmCLVYPoysCEZgVg2gc5ohoAMQvLvmfd+50fQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3edwXMX5IeMWnQzDl51xOvvUp0T3Bwg89/yA8Gojcd8=;
 b=DbxXCff2kIgSvEnf4jImqfFlXtNKviHuGUoEH/QFyUUeOOQOEnMzsX8w+5PP6UmMTvOSRrHPJdXH6xWXYQ5cDkcdodfU4FHPGvxCzxoDLQQ4NCXsnNKPBXQ1q43BUHpd8UQMpOJms5OUMMI69I+0jXxOj99aQwwDF1e/t/7Dfy1Tgy1QItvdX5uFfM9ndobfqXp/tkt81PQ+CckwwnQgOuZ3ur08tPskxHAAdzdbTCm4ULgN39n0+YDJzKyQ1BWLwSYFRaGpJhN3KakMpRghxCZH4nxmIPSlHaxzy5u6y97BsrVdJzCMasH1vQ+iCKGyV1qXEDdOLJgDbu3ZSn/9hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3edwXMX5IeMWnQzDl51xOvvUp0T3Bwg89/yA8Gojcd8=;
 b=a9VHC5MDcM7q2liDV/bpMWrcthuwhiwfWYhWCNSaQdHPt+x5NgubUR058QQb7A3kp6cZtYBuaS/XJ7e/iVNmFEZACoxPGxbO5wcWyxP8p7M9g9OQs3/MV3op9m28Alrt86nazjDwILhQGLbrFPdBrJubjZrItB3xhXUesqpg/n4=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 CO6PR04MB7524.namprd04.prod.outlook.com (2603:10b6:303:b2::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8632.35; Wed, 16 Apr 2025 06:31:41 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b27f:cdfa:851:e89a]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b27f:cdfa:851:e89a%7]) with mapi id 15.20.8632.030; Wed, 16 Apr 2025
 06:31:41 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
CC: Hannes Reinecke <hare@suse.de>, Alistair Francis
	<Alistair.Francis@wdc.com>
Subject: [bug report] blktests nvme/062 hang
Thread-Topic: [bug report] blktests nvme/062 hang
Thread-Index: AQHbrpk38HSk6tMn+0WV2Vt54Qr0dw==
Date: Wed, 16 Apr 2025 06:31:41 +0000
Message-ID: <5hdonndzoqa265oq3bj6iarwtfk5dewxxjtbjvn5uqnwclpwt6@a2n6w3taxxex>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|CO6PR04MB7524:EE_
x-ms-office365-filtering-correlation-id: 2abf25e4-6371-40be-1f2a-08dd7cb05988
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?yfDRHTmsnmmJXCO1aDVaGoptJM474+O0qRoc6X7+NU8nKeAVJQBBN4Tftb83?=
 =?us-ascii?Q?8xLtN02HhjRNrWtRi9jbm04xb0O9hlbb9rfd1RuDxMOAy0D9JIbbuxt/AdKg?=
 =?us-ascii?Q?k6Ru2sG8BSO5bDTGjGu5kXsxEEgiyv2LbeQokalbegdxWJ0mKCUby+SjSTyy?=
 =?us-ascii?Q?JYrqHztPOoB+3niktAPwkX2bxwcbV4V36jCUEq4A7ZC0WI/5ks7CwCp4qBBb?=
 =?us-ascii?Q?PLT+N/JcryB6llQ8QbXNTgHLwc2l+kL+UgPmNXcceCGwsNcNoMnm/zDK/MqC?=
 =?us-ascii?Q?MDegFxbUPtfuyRBE9huMrMbTN30A/dMpucoySn2y/WC9vSzJDCAISCCQ0jju?=
 =?us-ascii?Q?9/uHWQkmAWxQEdwNtb+uCRR5v2rF4a8rKw76KR51Zss9fQ8GSLZnrNCeHxBn?=
 =?us-ascii?Q?TimoMCI03fTZQo9TEgO5uU/y61g4DY7MZya/fe3q19iARsXVOyMYb6uKkDLm?=
 =?us-ascii?Q?ux44MPR9w5Ps6s5WHT0kH+xfBTAD1arbpCSgC0PM40IdOhALMfzS7xFlNjED?=
 =?us-ascii?Q?OpnLCWwXBck3cqr2pAb7LmujEjs/g/nICZ8ySd0VO6LSGCvGOaX6KvBiLPLB?=
 =?us-ascii?Q?9nzofyFUJpjjQc+X6Os4Z2OPRtKX9WaOgIBxVw8hEF774EEjFj2YWjRRknkm?=
 =?us-ascii?Q?VNWtky6rJOBFb0uVX0dxuMmX/ZbDE6Ljg/AMosj9eZGTeWMFM9dLjBLdtNlN?=
 =?us-ascii?Q?9/j7PLFNFbHN8qsCrYxJN+Wbxj8uBSl9v/x4V8d0JxRevK5DrW/YtPlv297V?=
 =?us-ascii?Q?QQvt53brzeq8sna/yaLKw5uyx950mHjPC0hWI4WIIVTXalm6U0t4nBmCQPjl?=
 =?us-ascii?Q?orPdTPCp97pkj971RhfBsQF2dl6JfcaZx8fYf8I17rQuQa44Bl1O62X36OM5?=
 =?us-ascii?Q?IsWM2QBAAki+K1kWqRyTeP6a8uoSwxp8xJHwrfFsWkCPx/petVsBwPceWg6i?=
 =?us-ascii?Q?QrUHktIpuL59sSWHp1peSLy1G/kcH71keXcPSNDjC2RQgH1dIH3f8/Y1VUTb?=
 =?us-ascii?Q?xQEhmSDY2pMUF+JD1nnXteht6RHADI2DH9I87ZcNX4v469zIxOaj/lqz6zfU?=
 =?us-ascii?Q?Ozbvt9B2M6fSPdNpDbe4jkCccVJLtT2CEA6jgzC2I0Pqjcr02agS1CzhF3/S?=
 =?us-ascii?Q?3Pm/W2MCewlih0fJpN/wASlU5PxHYYgWfPj9MMBX+pQHGjFzq7yDHFQqe0l6?=
 =?us-ascii?Q?oM5g07vls3dhZ3IHtx5JzNkAirLxiiunVJtlTNXXfdCcgO+CdKb1PMWMgf6t?=
 =?us-ascii?Q?zofgiMbGX3GQ5ipOseb7Hsw5lp4kCVFFiyldVGORRW6NL0w9G2O/LGDaO2ay?=
 =?us-ascii?Q?h5IGy3QO7TWfc3DNayCY2N8Bg8O/Sc6lXzdZpuUY8virz1EwvImVCnnt454i?=
 =?us-ascii?Q?ccPTdBSIr2SaZDGV48uECrSDevKWtgtissYAFO/haYMyNr/ii/JHg2YBw0+e?=
 =?us-ascii?Q?e1gFldzMAOc2YkY9EGkMu9lc5aEezddEcvZ6i0L5K5FWrtYHXq+fAQ=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?y6NenRTycaB9iYtR/e9Xb7bLOSTC6V8MDV7RQdnimw0/Qpv88ova+omyYZJP?=
 =?us-ascii?Q?8Ba8uZli03fDIfaQExDFEMAITtVPZwmhrqDSnFaN8nWiMGXCePc77lu44S0a?=
 =?us-ascii?Q?JCsvGtbLTX0hfzWKhIOSZo1u5VIi4y0RzcMgwkiy9ub8VcdK+yIlfKbova0Z?=
 =?us-ascii?Q?Ipo58rAI67HwzNx660Ws91uiRJzcDExQqzjyO8FKPoIcrKt+fJf5brmB6Gmw?=
 =?us-ascii?Q?GiUdH3CRuZkVV4cA3sTxAoutdPfyJcEl8A4wFF9NZ36DlqgdvJj5wGc1mgxd?=
 =?us-ascii?Q?T7W1XgsFLUFHNizKaMAt1WSLbenn1iC96M8f1QdPM0sy8Otn2WAS8Lp4zfSu?=
 =?us-ascii?Q?XdJv1WY/h+lcXpWKJCwajdw2M8o6GUHrfcVDxK6KQHdHSKOU3aHq23Ly/NrE?=
 =?us-ascii?Q?5iDrFRcCiGO40s9WO3hwk6XuS6XBcMkVbHyfLgsX7U43nSKJDGrh2GeENwDr?=
 =?us-ascii?Q?rGIu3OQUjlOlu8LVoru0XN8luFieGjM/z1HLXZikUOKYevooReWP89bGtAMs?=
 =?us-ascii?Q?2wlXH/KXfLSwRSs4+0jVtlXRQFNefmbMAXTiQiHIvN7u31tLlMAX0cnkAiOk?=
 =?us-ascii?Q?NQDUwREFbsjJMr6i8nSLIGEIBkanQUa/6QB75OAmm/w0hjEKhFMGm8SqSl/C?=
 =?us-ascii?Q?eKeXycDlyOLGHa2jiEwtD2I7lNi6E95e7dMDXtUL+K+7Cm8U9u4ig6g+P8L1?=
 =?us-ascii?Q?eWpEvRUUcONbTyNbYPjqaheVlPfzhiM3Mj4OWTmBXhptwJaPOb1E5sHBtKUg?=
 =?us-ascii?Q?vYB0HLvTd6jYAXYomx0l/7ky7tYCxMLmo+OXH2fkEp5g0DW8wAQxbKLGtbbG?=
 =?us-ascii?Q?wwTeTtVR56l9jMrX4iH35WlA4I+zsEL9m6n8NSnvNzIh78DQgUfQxey04cKu?=
 =?us-ascii?Q?IousdVGPHn518vK8RnNe4rWeNS4fqf8bmBY4f6qUyqywxlIcAHSRSgP2DLvE?=
 =?us-ascii?Q?U7nIPmhIW/MGauvEG8+B/KSSNOysTGEPuG2nnBphbtZ84JWfddM6SnU/rojK?=
 =?us-ascii?Q?i6OVKZQN9wZlWCexyxrDPz5vRq4ta9KRXZr9XdeGmJR+vVp3wUQjuOLZnJMD?=
 =?us-ascii?Q?yHtqX0FXeEShBaDEI3vtaXYB5zzFjAjcJExkIA29VFto5Xl/2sgaZuBkU5t/?=
 =?us-ascii?Q?MLVvJgOJYSMPuOnYWTaOVUl6M2i8fESO0wixHhg31NjO5D06I4ihqQpfsiI9?=
 =?us-ascii?Q?BUECTOLhrXfZS/Gbc0YXYa0ZoaFkBchzulttYUl4/h15ro/LFw2lvuotfM5y?=
 =?us-ascii?Q?+YQpz4m/RgVyJNGcy3iI8mkMwTBqCjOM1/4FIzFInFT8CU5EzY0prmboyEm+?=
 =?us-ascii?Q?cldqvTS0U4mKhg18XyQA3TRuG6uBiOyrjUx2NA7QN0wu5hzmxBLppc86Anhv?=
 =?us-ascii?Q?fsKdbv+zgEZMshKDQhFT8+/76lNLU75Zg3MtnrnIs2o0D0AVK8B+aMMzLDDb?=
 =?us-ascii?Q?jGyfSSIJoTXW7DUC6ZytDzvyE0ggpxJ0ELKyo+glP0x2rwogc3bbZm2nWbX2?=
 =?us-ascii?Q?0ISNGkHknxmZSsmy8Syv8vDUqsxTmkE3rUf6SA8H87IuwOfpSBWXNUDIa6vC?=
 =?us-ascii?Q?/lrolR9KMdf+gvQypqyy5chfNZKtGIOSMnOwN657QF0bx6jOE5eQXfEhOOq0?=
 =?us-ascii?Q?l6+mkbqjV9FM9AutoWZJc/Y=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <5ED44633E1BFA841811F9ED4CA858330@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: EMH0mIjhzqXP9qOPUWtnLz85wYgD/2NEG6V7T/7dyc09viJ73fzzzPUrv7gtSRTc72VdTSPGLQVAZix7/aCSl4WLriy257IslNXg74+XmzFV6nX7uD78fFLBvUDC0BtxptA4B2uXeMvLPZ/t0ezT3WLDreKGoYmtbrY+bYvyrvVqBxIwFsa+BXPoqxGPOMSq5ypm5hmXyWZYrxHqughY91NuelzhrN3ulVC1TuvFIcc3NAYIlfCRp+QXQYxi5GFdk3Q401Rl9ep5DCICzMSc5VIIm8i21CnWWFiniT70/GhzRhZ+GTpdRYAn7fmr0+k9JGwzrauooAIC4E17HQVs/V2OmHshA3ELxtcyvXZXRsIF4Oj0mVejIV2ouDR36ed4jfMJ7JZmoDcuY1NHa3DllewMfzhr5ziWwyjt0SPcBtNCEb2koeZsdQrqhZQBb5cf1Fb0Hai/cyr23aRqCtX/f7fKq8ZKjOkCt6aihMPWbDyKhkIn4dD8bCPZmvD238qdZ5skyM4uiaGXxesfM3UWUGaJ3Alf1Uu5Sy79wfnGWC0MpH5DnHcV7oLVHOac0omvYhZdIl8v87cXyV9muQ0H5HavWo2hYnKUg0ZhV5g8U/weBu8Bk2E8kA1ClFPhulDu
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2abf25e4-6371-40be-1f2a-08dd7cb05988
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Apr 2025 06:31:41.4076
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bgA2Zskc8r1gf32fr5OkOMkCrWa1DDGcEXRaSHgTK67JrevbE5oknF68F5KpGubkJlHlr/FuldsIxzu9TQ2rSeJnG9lXc7AW1LASczTk4fg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR04MB7524
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250415_233147_508773_4491CC7A 
X-CRM114-Status: GOOD (  12.45  )
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

Hello all,

Recently the new test case nvme/062 was added, which tests
"TLS-encrypted connections". I ran it with the kernel v6.15-rc2, and observ=
ed
"BUG: kernel NULL pointer dereference" followed by system hang [1].

  When I had run the test case with v6.14 kernel, I had not observed the
  failure. However, I noticed that when I repeat the test case several time=
s on
  the v6.14 kernel, the same failure happens. It looks that the problem has=
 been
  existing for a while, and kernel changes between v6.14 and v6.15-rc2 incr=
eased
  the failure ratio.

Actions for fix will be appreciated. I can run tests with debug patches or =
fix
candidate patches.

[1]

[  285.443497][ T1440] run blktests nvme/062 at 2025-04-16 14:41:30
[  285.586272][ T1531] nvmet: adding nsid 1 to subsystem blktests-subsystem=
-1
[  285.596633][ T1532] nvmet: Allow non-TLS connections while TLS1.3 is ena=
bled
[  285.601564][ T1535] nvmet_tcp: enabling port 0 (127.0.0.1:4420)
[  285.646164][ T1542] nvme nvme1: failed to connect socket: -512
[  285.651941][   T48] nvmet_tcp: failed to allocate queue, error -107
[  285.654954][   T65] nvmet: Created nvm controller 1 for subsystem blktes=
ts-subsystem-1 for NQN nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b=
0b3-51e60b8de349.
[  285.658205][ T1542] nvme nvme1: Please enable CONFIG_NVME_MULTIPATH for =
full support of multi-port devices.
[  285.659759][ T1542] nvme nvme1: creating 4 I/O queues.
[  285.662596][ T1542] nvme nvme1: mapped 4/0/0 default/read/poll queues.
[  285.665446][ T1542] nvme nvme1: new ctrl: NQN "blktests-subsystem-1", ad=
dr 127.0.0.1:4420, hostnqn: nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4=
856-b0b3-51e60b8de349
[  285.763327][ T1560] nvme nvme1: Removing ctrl: NQN "blktests-subsystem-1=
"
[  285.923585][ T1567] nvme nvme1: failed to connect socket: -512
[  285.932856][  T120] nvmet_tcp: failed to allocate queue, error -107
[  286.035851][   T98] nvmet: Created nvm controller 1 for subsystem blktes=
ts-subsystem-1 for NQN nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b=
0b3-51e60b8de349, TLS.
[  286.038496][ T1567] nvme nvme1: Please enable CONFIG_NVME_MULTIPATH for =
full support of multi-port devices.
[  286.040096][ T1567] nvme nvme1: creating 4 I/O queues.
[  286.070856][ T1567] nvme nvme1: mapped 4/0/0 default/read/poll queues.
[  286.074999][ T1567] nvme nvme1: new ctrl: NQN "blktests-subsystem-1", ad=
dr 127.0.0.1:4420, hostnqn: nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4=
856-b0b3-51e60b8de349
[  286.200199][ T1604] nvme nvme1: Removing ctrl: NQN "blktests-subsystem-1=
"
[  286.388688][ T1617] nvmet: adding nsid 1 to subsystem blktests-subsystem=
-1
[  286.406950][ T1621] nvmet_tcp: enabling port 0 (127.0.0.1:4420)
[  286.460711][ T1628] nvme_tcp: queue 0: failed to receive icresp, error -=
4
[  286.462026][    C0] BUG: kernel NULL pointer dereference, address: 00000=
00000000000
[  286.462814][    C0] #PF: supervisor instruction fetch in kernel mode
[  286.463796][    C0] #PF: error_code(0x0010) - not-present page
[  286.464392][    C0] PGD 8000000140620067 P4D 8000000140620067 PUD 114201=
067 PMD 0
[  286.465086][    C0] Oops: Oops: 0010 [#1] SMP KASAN PTI
[  286.465559][    C0] CPU: 0 UID: 0 PID: 1628 Comm: nvme Not tainted 6.15.=
0-rc2+ #11 PREEMPT(voluntary)
[  286.466393][    C0] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996=
), BIOS 1.16.3-3.fc41 04/01/2014
[  286.467147][    C0] RIP: 0010:0x0
[  286.467420][    C0] Code: Unable to access opcode bytes at 0xfffffffffff=
fffd6.
[  286.467977][    C0] RSP: 0018:ffff8883ae008580 EFLAGS: 00010246
[  286.468425][    C0] RAX: 0000000000000000 RBX: ffff88813fd34100 RCX: fff=
fffffa386cc43
[  286.469019][    C0] RDX: 1ffff11027fa68b6 RSI: 0000000000000008 RDI: fff=
f88813fd34100
[  286.469545][    C0] RBP: ffff88813fd34160 R08: 0000000000000000 R09: fff=
fed1027fa682c
[  286.470072][    C0] R10: ffff88813fd34167 R11: 0000000000000000 R12: fff=
f88813fd344c3
[  286.470585][    C0] R13: ffff88813fd34112 R14: ffff88813fd34aec R15: fff=
f888132cdd268
[  286.471070][    C0] FS:  00007fe3c04c7d80(0000) GS:ffff88840743f000(0000=
) knlGS:0000000000000000
[  286.471644][    C0] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  286.472543][    C0] CR2: ffffffffffffffd6 CR3: 000000012daca000 CR4: 000=
00000000006f0
[  286.473500][    C0] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 000=
0000000000000
[  286.474467][    C0] DR3: 0000000000000000 DR6: 00000000ffff07f0 DR7: 000=
0000000000400
[  286.475453][    C0] Call Trace:
[  286.476102][    C0]  <IRQ>
[  286.476719][    C0]  tcp_fin+0x2bb/0x440
[  286.477429][    C0]  tcp_data_queue+0x190f/0x4e60
[  286.478174][    C0]  ? __build_skb_around+0x234/0x330
[  286.478940][    C0]  ? rcu_is_watching+0x11/0xb0
[  286.479659][    C0]  ? __pfx_tcp_data_queue+0x10/0x10
[  286.480431][    C0]  ? tcp_try_undo_loss+0x640/0x6c0
[  286.481196][    C0]  ? seqcount_lockdep_reader_access.constprop.0+0x82/0=
x90
[  286.482046][    C0]  ? kvm_clock_get_cycles+0x14/0x30
[  286.482769][    C0]  ? ktime_get+0x66/0x150
[  286.483433][    C0]  ? rcu_is_watching+0x11/0xb0
[  286.484146][    C0]  tcp_rcv_established+0x6e4/0x2050
[  286.484857][    C0]  ? rcu_is_watching+0x11/0xb0
[  286.485523][    C0]  ? ipv4_dst_check+0x160/0x2b0
[  286.486203][    C0]  ? __pfx_tcp_rcv_established+0x10/0x10
[  286.486917][    C0]  ? lock_release+0x217/0x2c0
[  286.487595][    C0]  tcp_v4_do_rcv+0x4d6/0x9b0
[  286.488279][    C0]  tcp_v4_rcv+0x2af8/0x3e30
[  286.488904][    C0]  ? raw_local_deliver+0x51b/0xad0
[  286.489551][    C0]  ? rcu_is_watching+0x11/0xb0
[  286.490198][    C0]  ? __pfx_tcp_v4_rcv+0x10/0x10
[  286.490813][    C0]  ? __pfx_raw_local_deliver+0x10/0x10
[  286.491487][    C0]  ? __pfx_nf_confirm+0x10/0x10 [nf_conntrack]
[  286.492275][    C0]  ? rcu_is_watching+0x11/0xb0
[  286.492900][    C0]  ip_protocol_deliver_rcu+0x8f/0x370
[  286.493579][    C0]  ip_local_deliver_finish+0x297/0x420
[  286.494268][    C0]  ip_local_deliver+0x168/0x430
[  286.494867][    C0]  ? __pfx_ip_local_deliver+0x10/0x10
[  286.495498][    C0]  ? __pfx_ip_local_deliver_finish+0x10/0x10
[  286.496204][    C0]  ? ip_rcv_finish_core+0x19a/0x1f20
[  286.496806][    C0]  ? lock_release+0x217/0x2c0
[  286.497414][    C0]  ip_rcv+0x455/0x6e0
[  286.497945][    C0]  ? __pfx_ip_rcv+0x10/0x10
[  286.498550][    C0]  ? rcu_is_watching+0x11/0xb0
[  286.499137][    C0]  ? __pfx_ip_rcv_finish+0x10/0x10
[  286.499763][    C0]  ? lock_release+0x217/0x2c0
[  286.500327][    C0]  ? dl_scaled_delta_exec+0xd1/0x2c0
[  286.500922][    C0]  ? __pfx_ip_rcv+0x10/0x10
[  286.501480][    C0]  __netif_receive_skb_one_core+0x166/0x1b0
[  286.502173][    C0]  ? __pfx___netif_receive_skb_one_core+0x10/0x10
[  286.502903][    C0]  ? lock_acquire+0x2b2/0x310
[  286.503487][    C0]  ? process_backlog+0x372/0x1350
[  286.504087][    C0]  ? lock_release+0x217/0x2c0
[  286.504642][    C0]  process_backlog+0x3b9/0x1350
[  286.505214][    C0]  ? process_backlog+0x372/0x1350
[  286.505779][    C0]  __napi_poll.constprop.0+0xa6/0x490
[  286.506363][    C0]  net_rx_action+0x92e/0xe10
[  286.506889][    C0]  ? __pfx_net_rx_action+0x10/0x10
[  286.507437][    C0]  ? timerqueue_add+0x1f0/0x320
[  286.507977][    C0]  ? sched_clock_cpu+0x68/0x540
[  286.508492][    C0]  ? lock_acquire+0x2b2/0x310
[  286.509043][    C0]  ? kvm_sched_clock_read+0xd/0x20
[  286.509607][    C0]  ? handle_softirqs+0x1aa/0x7d0
[  286.510187][    C0]  handle_softirqs+0x1f2/0x7d0
[  286.510754][    C0]  ? __pfx_handle_softirqs+0x10/0x10
[  286.511348][    C0]  ? irqtime_account_irq+0x181/0x290
[  286.511937][    C0]  ? __dev_queue_xmit+0x85d/0x3450
[  286.512510][    C0]  do_softirq.part.0+0x89/0xc0
[  286.513100][    C0]  </IRQ>
[  286.513548][    C0]  <TASK>
[  286.513953][    C0]  __local_bh_enable_ip+0x112/0x140
[  286.514522][    C0]  ? __dev_queue_xmit+0x85d/0x3450
[  286.515072][    C0]  __dev_queue_xmit+0x872/0x3450
[  286.515619][    C0]  ? nft_do_chain+0xe16/0x15b0 [nf_tables]
[  286.516252][    C0]  ? __pfx___dev_queue_xmit+0x10/0x10
[  286.516817][    C0]  ? selinux_ip_postroute+0x43c/0xc50
[  286.517433][    C0]  ? __pfx_selinux_ip_postroute+0x10/0x10
[  286.518061][    C0]  ? rcu_is_watching+0x11/0xb0
[  286.518606][    C0]  ? ip_output+0x164/0x4a0
[  286.519149][    C0]  ? rcu_is_watching+0x11/0xb0
[  286.519671][    C0]  ? ip_finish_output2+0x17d5/0x1fb0
[  286.520258][    C0]  ip_finish_output2+0xb4b/0x1fb0
[  286.520787][    C0]  ? __pfx_ip_finish_output2+0x10/0x10
[  286.521355][    C0]  ? __ip_finish_output+0x15d/0x750
[  286.521890][    C0]  ip_output+0x164/0x4a0
[  286.522372][    C0]  ? __pfx_ip_output+0x10/0x10
[  286.522872][    C0]  ? rcu_is_watching+0x11/0xb0
[  286.523402][    C0]  ? _raw_spin_unlock_irqrestore+0x4c/0x60
[  286.524031][    C0]  ? __pfx_ip_finish_output+0x10/0x10
[  286.524605][    C0]  ? __ip_queue_xmit+0x999/0x2260
[  286.525200][    C0]  ? rcu_is_watching+0x11/0xb0
[  286.525744][    C0]  ? ipv4_dst_check+0x16a/0x2b0
[  286.526279][    C0]  ? lock_release+0x217/0x2c0
[  286.526793][    C0]  __ip_queue_xmit+0x1883/0x2260
[  286.527324][    C0]  ? __skb_clone+0x54c/0x730
[  286.527827][    C0]  __tcp_transmit_skb+0x209b/0x37a0
[  286.528374][    C0]  ? __pfx___tcp_transmit_skb+0x10/0x10
[  286.528952][    C0]  ? rcu_is_watching+0x11/0xb0
[  286.529472][    C0]  ? seqcount_lockdep_reader_access.constprop.0+0x82/0=
x90
[  286.530152][    C0]  ? trace_hardirqs_on+0x12/0x120
[  286.530691][    C0]  tcp_write_xmit+0xb81/0x88b0
[  286.531224][    C0]  ? mod_memcg_state+0x4d/0x60
[  286.531736][    C0]  ? rcu_is_watching+0x11/0xb0
[  286.532253][    C0]  __tcp_push_pending_frames+0x90/0x320
[  286.532826][    C0]  tcp_send_fin+0x141/0xb50
[  286.533352][    C0]  ? __pfx_tcp_send_fin+0x10/0x10
[  286.533908][    C0]  ? __local_bh_enable_ip+0xab/0x140
[  286.534495][    C0]  inet_shutdown+0x243/0x320
[  286.535077][    C0]  nvme_tcp_alloc_queue+0xb3b/0x2590 [nvme_tcp]
[  286.535709][    C0]  ? do_raw_spin_lock+0x129/0x260
[  286.536314][    C0]  ? __pfx_nvme_tcp_alloc_queue+0x10/0x10 [nvme_tcp]
[  286.536996][    C0]  ? do_raw_spin_unlock+0x54/0x1e0
[  286.537550][    C0]  ? _raw_spin_unlock+0x29/0x50
[  286.538127][    C0]  ? do_raw_spin_lock+0x129/0x260
[  286.538664][    C0]  ? __pfx_do_raw_spin_lock+0x10/0x10
[  286.539249][    C0]  ? nvme_tcp_alloc_admin_queue+0xd5/0x340 [nvme_tcp]
[  286.539892][    C0]  ? __wake_up+0x40/0x60
[  286.540392][    C0]  nvme_tcp_alloc_admin_queue+0xd5/0x340 [nvme_tcp]
[  286.541047][    C0]  ? rcu_is_watching+0x11/0xb0
[  286.541589][    C0]  nvme_tcp_setup_ctrl+0x8b/0x7a0 [nvme_tcp]
[  286.542254][    C0]  ? _raw_spin_unlock_irqrestore+0x4c/0x60
[  286.542887][    C0]  ? __pfx_nvme_tcp_setup_ctrl+0x10/0x10 [nvme_tcp]
[  286.543568][    C0]  ? trace_hardirqs_on+0x12/0x120
[  286.544166][    C0]  ? _raw_spin_unlock_irqrestore+0x35/0x60
[  286.544792][    C0]  ? nvme_change_ctrl_state+0x196/0x2e0 [nvme_core]
[  286.545477][    C0]  nvme_tcp_create_ctrl+0x839/0xb90 [nvme_tcp]
[  286.546126][    C0]  nvmf_dev_write+0x3db/0x7e0 [nvme_fabrics]
[  286.546775][    C0]  ? rw_verify_area+0x69/0x520
[  286.547334][    C0]  vfs_write+0x218/0xe90
[  286.547854][    C0]  ? do_syscall_64+0x9f/0x190
[  286.548408][    C0]  ? trace_hardirqs_on_prepare+0xdb/0x120
[  286.549037][    C0]  ? syscall_exit_to_user_mode+0x93/0x280
[  286.549659][    C0]  ? __pfx_vfs_write+0x10/0x10
[  286.550259][    C0]  ? do_syscall_64+0x9f/0x190
[  286.550840][    C0]  ? syscall_exit_to_user_mode+0x8e/0x280
[  286.551516][    C0]  ? trace_hardirqs_on_prepare+0xdb/0x120
[  286.552180][    C0]  ? syscall_exit_to_user_mode+0x93/0x280
[  286.552834][    C0]  ? ksys_read+0xf5/0x1c0
[  286.553386][    C0]  ? __pfx_ksys_read+0x10/0x10
[  286.553964][    C0]  ksys_write+0xf5/0x1c0
[  286.554499][    C0]  ? __pfx_ksys_write+0x10/0x10
[  286.555072][    C0]  ? trace_hardirqs_on_prepare+0xdb/0x120
[  286.555698][    C0]  ? syscall_exit_to_user_mode+0x93/0x280
[  286.556319][    C0]  ? do_syscall_64+0x54/0x190
[  286.556866][    C0]  do_syscall_64+0x93/0x190
[  286.557420][    C0]  ? rcu_read_unlock+0x17/0x60
[  286.557986][    C0]  ? rcu_is_watching+0x11/0xb0
[  286.558526][    C0]  ? lock_release+0x217/0x2c0
[  286.559087][    C0]  ? rcu_is_watching+0x11/0xb0
[  286.559659][    C0]  ? count_memcg_events.constprop.0+0x4a/0x60
[  286.560476][    C0]  ? exc_page_fault+0x7a/0x110
[  286.561064][    C0]  ? rcu_is_watching+0x11/0xb0
[  286.561647][    C0]  ? lock_release+0x217/0x2c0
[  286.562257][    C0]  ? do_user_addr_fault+0x171/0xa00
[  286.562839][    C0]  ? do_user_addr_fault+0x4a2/0xa00
[  286.563453][    C0]  ? irqentry_exit_to_user_mode+0x84/0x270
[  286.564112][    C0]  ? rcu_is_watching+0x11/0xb0
[  286.564677][    C0]  ? irqentry_exit_to_user_mode+0x84/0x270
[  286.565317][    C0]  ? trace_hardirqs_on_prepare+0xdb/0x120
[  286.565922][    C0]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[  286.566542][    C0] RIP: 0033:0x7fe3c05e6504
[  286.567102][    C0] Code: c7 00 16 00 00 00 b8 ff ff ff ff c3 66 2e 0f 1=
f 84 00 00 00 00 00 f3 0f 1e fa 80 3d c5 8b 10 00 00 74 13 b8 01 00 00 00 0=
f 05 <48> 3d 00 f0 ff ff 77 54 c3 0f 1f 00 55 48 89 e5 48 83 ec 20 48 89
[  286.568931][    C0] RSP: 002b:00007fff76444f58 EFLAGS: 00000202 ORIG_RAX=
: 0000000000000001
[  286.569807][    C0] RAX: ffffffffffffffda RBX: 000000003b40d930 RCX: 000=
07fe3c05e6504
[  286.570621][    C0] RDX: 00000000000000cf RSI: 000000003b40d930 RDI: 000=
0000000000003
[  286.571443][    C0] RBP: 0000000000000003 R08: 00000000000000cf R09: 000=
000003b40d930
[  286.572246][    C0] R10: 0000000000000000 R11: 0000000000000202 R12: 000=
000003b40cd60
[  286.573069][    C0] R13: 00000000000000cf R14: 00007fe3c07417f8 R15: 000=
07fe3c073502e
[  286.573886][    C0]  </TASK>
[  286.574374][    C0] Modules linked in: tls nvmet_tcp nvmet nvme_tcp nvme=
_fabrics nft_fib_inet nft_fib_ipv4 nft_fib_ipv6 nft_fib nft_reject_inet nf_=
reject_ipv4 nf_reject_ipv6 nft_reject nft_ct nft_chain_nat nf_nat nf_conntr=
ack nf_defrag_ipv6 nf_defrag_ipv4 ip_set nf_tables qrtr sunrpc 9pnet_virtio=
 ppdev 9pnet netfs e1000 parport_pc i2c_piix4 parport pcspkr i2c_smbus loop=
 fuse dm_multipath nfnetlink vsock_loopback vmw_vsock_virtio_transport_comm=
on vmw_vsock_vmci_transport vsock vmw_vmci zram bochs drm_client_lib drm_sh=
mem_helper drm_kms_helper xfs nvme nvme_core drm sym53c8xx nvme_keyring scs=
i_transport_spi nvme_auth floppy serio_raw ata_generic pata_acpi qemu_fw_cf=
g [last unloaded: nvmet]
[  286.579925][    C0] CR2: 0000000000000000
[  286.580535][    C0] ---[ end trace 0000000000000000 ]---
[  286.581263][    C0] RIP: 0010:0x0
[  286.581844][    C0] Code: Unable to access opcode bytes at 0xfffffffffff=
fffd6.
[  286.582684][    C0] RSP: 0018:ffff8883ae008580 EFLAGS: 00010246
[  286.583467][    C0] RAX: 0000000000000000 RBX: ffff88813fd34100 RCX: fff=
fffffa386cc43
[  286.584416][    C0] RDX: 1ffff11027fa68b6 RSI: 0000000000000008 RDI: fff=
f88813fd34100
[  286.585365][    C0] RBP: ffff88813fd34160 R08: 0000000000000000 R09: fff=
fed1027fa682c
[  286.586255][    C0] R10: ffff88813fd34167 R11: 0000000000000000 R12: fff=
f88813fd344c3
[  286.587123][    C0] R13: ffff88813fd34112 R14: ffff88813fd34aec R15: fff=
f888132cdd268
[  286.587940][    C0] FS:  00007fe3c04c7d80(0000) GS:ffff88840743f000(0000=
) knlGS:0000000000000000
[  286.588843][    C0] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  286.589649][    C0] CR2: ffffffffffffffd6 CR3: 000000012daca000 CR4: 000=
00000000006f0
[  286.590547][    C0] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 000=
0000000000000
[  286.591462][    C0] DR3: 0000000000000000 DR6: 00000000ffff07f0 DR7: 000=
0000000000400
[  286.592361][    C0] Kernel panic - not syncing: Fatal exception in inter=
rupt
[  286.594493][    C0] Kernel Offset: 0x20000000 from 0xffffffff81000000 (r=
elocation range: 0xffffffff80000000-0xffffffffbfffffff)
[  286.595673][    C0] ---[ end Kernel panic - not syncing: Fatal exception=
 in interrupt ]---=

