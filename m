Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44C12C43458
	for <linux-nvme@archiver.kernel.org>; Sat, 11 Jul 2026 23:14:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:
	Content-Type:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Y59x6oQztGL5X5567pqo1NSbfcK/qFZ87+RWMPrbrXc=; b=ddfLcqHd+na1BAvJ+Nk38jAUpP
	RYfQ3MWsgn3fpqy04oXf4BpXyZmlVqGpepaS9UlVVkHY4cdaYQkXnKp4BKmyIZ/wq8rssQjPwCy+/
	WGGO0OGFbwQ9So7T23ybA7MQuHtCg7Fqo9yAYHb4oEYSBN2btkE/K4Er0U4PVIewzblwppg53N8eZ
	MnHzIzZIeP9ref70fkSv11t/krvaozFAs5nTIQQQcQdSgdc9dQc/UvHXxK6Yu2cG8/zUZW4/6wScz
	HDcMrBKyQrE1R0gKmreVMBMws/BFG/Dxk0uHuLQ9O6Komu6IOzvkHmYc4mE5DVO0gGFK5Td23RHw0
	8+1Rb3tw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wigtq-00000006wl9-1uW5;
	Sat, 11 Jul 2026 23:14:22 +0000
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wigtn-00000006wki-3Vau
	for linux-nvme@lists.infradead.org;
	Sat, 11 Jul 2026 23:14:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1783811659; x=1815347659;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=4Im2TY/aTD5du8UwfxwbPaimfKwp2LSIt2atM2vlhxc=;
  b=VrBfCvgO0j9d2rzaWbbBcWoGFQjU6NsYMlodEPCrK2HktEAU3ofk9hkW
   U5hK5DANuXFNTp3OT636epYmRG1XJYXOwUcJYmkc71XAXEGA7TnJ2pRWM
   pyIUcXMMqHcwy8J2OsUAQqx1WokQDeLEhxHHdd0ZGkZr8oHw1SIWMPu8Q
   bfEun+E91+fzeHqyvWl5e7MciKJAKnHcoqhwcWMu8x1T77MFiXP6xIZye
   Ff9mJJZyXrh3DPKC4KxEdpNwtCbqkcTaoY667TyPC+z0R7oOZWL3q/WSW
   PmB9p6aIfWlKpbYvvLpOifKJqxEc9qjlE264ATkhupS9U6NorENRDkhpr
   w==;
X-CSE-ConnectionGUID: kibOBvodTomOysCtU/j03g==
X-CSE-MsgGUID: uHMVeZ/BQ+e9Rs/HIMFt0A==
X-IronPort-AV: E=Sophos;i="6.25,154,1779120000"; 
   d="scan'208";a="146691865"
Received: from mail-southcentralusazon11011045.outbound.protection.outlook.com (HELO SN4PR0501CU005.outbound.protection.outlook.com) ([40.93.194.45])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 12 Jul 2026 07:14:15 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IB+SzkNug1HOobD6VOdDXQfy7kdXMFJLVsgwKX9YfvvtNQ98gdZdWQg1MkPhctH9o9yxsl/QxCDmdZysTo0X+3uK6Zkgjh+M57LdvmpiMJ8n72LsxzGax5ANiP2bthZTMM8NV8Pizl2QSK9t9hAEkfm/UhL8g2+GogXUpVD5P/84xKZWWPYsC9QKONYXkhrFXo7a9xa0PfxEyJeY1hibspfqtl19kbLM4b4gDXs+b7+bna5qesjSzUhfhBQSF5n4e7c3HB2wVmf0zFq495CRguYvMMkfxi+u9NelcneccWG250BPQKP6Y1yCPZ3TzhrP8EsrSl7rSJmlrn9thStLQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y59x6oQztGL5X5567pqo1NSbfcK/qFZ87+RWMPrbrXc=;
 b=P3F7axcH6p6aQJrASQRGZ+a+Dt9UA0+3oQytcn7u99ntEy54xPx1tk3B25sW3JUz5ayaqsECnH22xkX+MIigKhftYwLFNoA6Y7KoxwWhBAmeahO/nst53dv3ug7TwPrBGn36YT0pySUDFS9us7iFHig0vzJa4Zp5387B4lNd6dk+wG52A/WKBXW0GNv94hYxVhA1cbu38DTjIk43jPafMRX7IVkKfAcup1Uc73c4aKsa/2AjLoBTOwv3rxiSCxfa/5LNuPynLEaGxLV6w0hz0vqIQPOjB+o2wZ92R4zf5sIhITzE/CqVACSRrU6MvR51QftLYWB1tTSu99lqBJYRgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y59x6oQztGL5X5567pqo1NSbfcK/qFZ87+RWMPrbrXc=;
 b=dudkZsinWFZZGOKDxeXLtHBOw/OWs3KSM7MciMqZIRhpgpZbHuaP4A2IGtE00C5EgHOBgqJPcne7xRYE52XiLiLzLuiwPlDgGmEiLf9tRdzUOg967nIrwLdjdo/y1KkNLNpe9zHbWllVmbDGlhyK+Ok17Sw7qatXNcxIT1h7Mco=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
Received: from SA1PR04MB10065.namprd04.prod.outlook.com
 (2603:10b6:806:4dd::14) by SJ0PR04MB7503.namprd04.prod.outlook.com
 (2603:10b6:a03:323::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.22; Sat, 11 Jul
 2026 23:14:13 +0000
Received: from SA1PR04MB10065.namprd04.prod.outlook.com
 ([fe80::9b98:bf8a:b0b1:ef85]) by SA1PR04MB10065.namprd04.prod.outlook.com
 ([fe80::9b98:bf8a:b0b1:ef85%6]) with mapi id 15.21.0181.019; Sat, 11 Jul 2026
 23:14:13 +0000
Date: Sun, 12 Jul 2026 08:14:08 +0900
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-nvme@lists.infradead.org
Cc: Logan Gunthorpe <logang@deltatee.com>, Chao Shi <coshi036@gmail.com>
Subject: Re: [PATCH blktests] nvme/{033,036,037}: skip when the test target
 namespace has metadata
Message-ID: <alLOKw5RMsFd2tsK@shinmob>
References: <20260630113714.848831-1-shinichiro.kawasaki@wdc.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260630113714.848831-1-shinichiro.kawasaki@wdc.com>
X-ClientProxiedBy: TYCP286CA0091.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:2b4::13) To SA1PR04MB10065.namprd04.prod.outlook.com
 (2603:10b6:806:4dd::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR04MB10065:EE_|SJ0PR04MB7503:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a3210da-c79f-4bb5-5dc8-08dedfa21f33
WDCIPOUTBOUND: EOP-TRUE
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|366016|1800799024|19092799006|376014|18002099003|22082099003|56012099006|6133799003|11063799006|3023799007;
X-Microsoft-Antispam-Message-Info: zD7Rc5PYu8R8WsKe6X1O/PRHzGq9ziTVE3KKbnaeGAos7xVsIL+GhB+yUwp5hfrBOnBkO76rLIv2au0BNBwVJjBioXoLLGTeVGnG6Bx0Vi+OXAaU90QnAJvqoVh5u4LBI0xkRA5G312ZZ2pDu+WfjeUB6DNg59AWyM8mqihsx9nWf8fOkMqIy9NdqQ45oKFS049Ni8oq/nczqwMzduETtScxLMFYNnKrkkhzUA7HaFQnXK+zrBGkickEZase815XLY5vDxLRpavkFnfPbrnrG/Z51VlgJQ80ALYkjxHEZeKMYXUIhG1bS76YCHu+x4wJafLVszMYb8i88kn0GMAq5CxbkncRhp0aHaqprevzfukACuRrTNazYomfAAocOqQAs7Cvt6ioPFO5Pf3kdDjuyvd8/G2sJdVR/Vbjhr3EBQKyis9xsCRaPdVUDi+qS5izBTV/P2+h4arF5ly8OtuhlFRONBiXVGSU8rua1QQLhJYeP6/6sRaPMMx5Nz3rfhYniePctY5v79m88HNxI+dk3RM5pbuEhmM+sUvNvREVoXHWN19dvGnSpklj8073aq0IbBuK6H5O9BdC7fDflBID+65at4k2PCgs05Dc2s6+NPC/YHPS8W2dUf/HoEZchMQTZW89OmyvxxZyzzyoPJoMx6enFWNyhDDlvuJfhwCPPxQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR04MB10065.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(19092799006)(376014)(18002099003)(22082099003)(56012099006)(6133799003)(11063799006)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2STQmoHiUzW+tYaJYph4y3SD9ft+XkSyFlXikyNq0pAUA9vUFfAHITh6LAM0?=
 =?us-ascii?Q?+PYVOmhVTMxhGj6jic2yUwAF/6Dl3B84LvZqKV3cVPUdIs7NM/2A3pKLRjrd?=
 =?us-ascii?Q?tRmoRy4Z1RpTA/IDLfDgd64rujr++UGwcABT1HYyVtRjFSNtrbeStBXbtyG4?=
 =?us-ascii?Q?vpI0yU0d1j2ve1TKag0JJ8u24hFwaaUhUvFK3t/pvd5xYvEH1uW3M6ccj6b1?=
 =?us-ascii?Q?kWxh/hZtya8FDOlwOfnBMHZ1knDuc14931yRH3lB5HQAZKlkkkliA/cXfPdr?=
 =?us-ascii?Q?AzgTzy9apxHnkqTtlRIs++ke29Ss8JfJheJcR7GsDiYnnB3uVhzwPkfMYWf0?=
 =?us-ascii?Q?gK57XgjvGEDq6PgkeCk1Id4qw7X6Djogc46Aiyx7iVJ7wwv6I5raCgh2FthG?=
 =?us-ascii?Q?HmjYgeDan8P5/vDT4n2QiVq0pYmhdnUmO5sDOOWDhw2vj4eBZgaTR+Y6kYPZ?=
 =?us-ascii?Q?eeapNn7P1w4ny0iAzD1ojytr3ORlaDDgjbd9Q25UDu5GZAkSaU62GTj00fFg?=
 =?us-ascii?Q?7K8DdSXTBedO4MApSMZPZJimWwMOhXU+iCDtVxiW4B1a2M8z6uCQTd9BcUr9?=
 =?us-ascii?Q?Or2oWYiGfKj7IXpWLCcaxbDDmOpvXik4QoyX1Kj1bEGQOMCFFTEdCN6uuMbv?=
 =?us-ascii?Q?KcMpnGaOEyYZyMleS40nO57+zt/8LxKEdNUi+ewmmozbnN5064f6zMcd1xH1?=
 =?us-ascii?Q?TXmL3rzMCKpMWD3HVdwRZpEDcnOc7UMaVmxMsB4dryd1Q6a2/27Pqea2SgLj?=
 =?us-ascii?Q?WWLWnTrEbrF4hki65/KEUCwX7+Z1NS5qCg3vGK6Tj966GS0m+wwERxtNjBAE?=
 =?us-ascii?Q?BTfLz1461GtiUbHnhlOuO/feyyZ0/Jd9q/DzrMzYEqC1ytl+h1wWXXKC2QWu?=
 =?us-ascii?Q?vxCq6pEaKp3G0vrrMm5IHBSg37k/p2tX/jlddEcgEuDjArILhZLzS8EXDApi?=
 =?us-ascii?Q?+lp9tZo1MoMm3/cBa40gJzv29OKrxrhMqPPYID5LiW4Mcl7aZN+D7s0PMLV8?=
 =?us-ascii?Q?FqTRdknLpbdosEnmNBeG5eExxv7wj6HKQs5FDyeRW0SszY6ygN4txcdoqY9e?=
 =?us-ascii?Q?Ao8Mnc1XfcLFP08kvoHoRkl+bvyYADUzpzgiJkLt9VfFV9gD8iCwDeJQTdJ2?=
 =?us-ascii?Q?whiLLIuAWFGLfT3CdvsVvAq9p0/Hul8JaWsZyVCvA34WGytl8QMwGD2YDpw2?=
 =?us-ascii?Q?kc5c0nPSDvCm6RJpz9HZ1xMOWzx+LXssymgavLOvxVhllECMMLTPD8wV4nit?=
 =?us-ascii?Q?kPdEEcFLlF809Cfl1EZeNHO4oN//2D2+UQFb4oDUDUq1i2n2tVxHUHM/qz6M?=
 =?us-ascii?Q?yc/n3SzAar6BCxqbqPO9CD36YzNPhEiIWOHsqbrZiHhSr53c0tjR9iY/neJ4?=
 =?us-ascii?Q?X2RX8OOndWSX41KdJnG2hufGA3Vr4nwN5QnUS9r/AEYpCtXDHaTIMWbqLF1y?=
 =?us-ascii?Q?odCBkEEvMSKWDKCYbkXcUgJM0kouioeCb+rOHzHjQZPE7LRJAiMHoVyv/2RC?=
 =?us-ascii?Q?vFbshQTGubXReQ3l24zGYoKexoJ3fMgBc7zUvkuQn6cW6IFgw9ORKkS2/4rM?=
 =?us-ascii?Q?pECKdPCwnibjIxnnQbAOr3eXc9hYq6v2GYitDVU/TrCec0eElOvyqZJ0x8yR?=
 =?us-ascii?Q?8nHaWOhV3YK2voVT6UxufmY6M6ePPCpWBfuHHTalnXP//p7hf5MuTD6zV25q?=
 =?us-ascii?Q?2WIX2IQDRLLNrdrplLEbhMe3HIj9L3Fvy9xivNJUCmC6NVpMd6K8f+nYLsfK?=
 =?us-ascii?Q?y0i0nGqX9VmPVwfiH41gtThs1AITVSQ=3D?=
X-Exchange-RoutingPolicyChecked: b35G+C5IRcPytpXkS7O8yiw9IV+q6LAsNKkV9KIqqhUZvJl50luvQ8f/8VCx+4jaHMMLr9hY1vDPQ3Q5GP+3mcVDIdxORH+bKwehAT6ZVY5UnfmPY8SpSRXnQTSyHQvGNtQoZgZxQHpYzCOnBm+evrW7hC+vJ1h5Xt90LwbXZJ3qFG75Vy3MrO4b2IjiZAmD/qR0QTAenSr1Xd+2Ur3oXClCAUpYoboJfkq1L1jfRHeYjL17DRXfvPqp2lVrX47IUzhM1iNULMStX5PmVS+/d8a0RJ/gO3jEZ1l+kHMJJRieFgT7droppTud4kCBceU46vnnqX1KmZrJHXLqvPrB6A==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Vsnd7ihxV7CrQApmWwDgtrhih9ZOvqKbFS3IIv4DeEZDyqjowAyqskFh0IWEdgfuzowPLQOKEmuY5w/lgbnlBwoXorf3niI40QjXuLr3vmNGzRXQ4MZc+ze2sSNV3biGqrcbPBNj+89iSkzpZluB0+GRthVPdGjUehMBASZYqXyf5MUHDoeJJAbZ7mz7NPBbOVAWF/uR3OMi/fbkpUKNi4ecBRXUqyEYeb71hf8kUrJ1wkVSkxpu+2373P4ert5E/m5BG45vE1u4jaPp0IAdswGvyV/FTAM8bsDRQHyOzcRVpEg0DrghhUFCmFe4ZXt0Knz0iW8S8OfE5Ft1HorubXUrdKklF1fpzDkaQC3jM5p9Xlbk6mWdxzIdnBNKXHgpI57N7QKsGr3eCRYclCiJ+yl0Y6+qPfuj+xr4iRPeCkRWi6pnS8gN5xLkq9uJIKACYyEoGiiagSZJNVOhl22u65dFkWcsBOUX1JZYCs14IqvsEGlxsKeWA6hRaNVr4uUeIAbfHX4rYQOckzkvX2fO6uq8N+wX5gSkISxxveka0lFytPVzuhFaQL1TaDJB2LivoiqmKQt+QXC0JZdNh5WcTuGj5tF4VxrgERYifbltJCkll35n8gy4R3mzPvaQC32z
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a3210da-c79f-4bb5-5dc8-08dedfa21f33
X-MS-Exchange-CrossTenant-AuthSource: SA1PR04MB10065.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2026 23:14:13.5195
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HKSQZi7jag1JNjhcrWWywsjMyHCc1Pa67tCvV8P7a24xTHpTlV13ZNpBrIxJdMFXW+b02OCgxeDbota6d7LYBWWPa0TnRf5GsOhQUwLdGnY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB7503
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260711_161419_976556_CD474760 
X-CRM114-Status: GOOD (  15.67  )
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

On Jun 30, 2026 / 20:37, Shin'ichiro Kawasaki wrote:
> The kernel commit c8cdecdb47d3 ("nvme: core: reject invalid LBA data
> size from Identify Namespace") in the v7.2-rc1 tag triggered failures of
> blktests test cases nvme/033, 036 and 037. The failures are observed
> when TEST_DEV specifies a NVMe device with metadata. The commit
> introduced a new check in nvme_update_ns_info_block() to reject invalid
> LBA data size. After this commit, namespaces with zero LBA data size are
> rejected.
> 
> According to the comment in nvmet_passthru_override_id_ns() in the
> kernel code drivers/nvme/target/passthru.c, "Presently the NVMEoF target
> code does not support sending metadata, so we must disable it here". For
> that purpose, the function sets the LBA data size to zero for all LBA
> format (lbaf) entries with metadata. After the trigger commit, these
> entries become invalid for NVMEoF target passthru, then namespaces with
> metadata are not visible as block devices through the target setup.
> 
> These test cases set up NVMEoF target passthru assuming the namespace
> devices are visible, so they cannot find the namespaces and fail.
> 
> To avoid the failures, skip the test cases when TEST_DEV has metadata.

FYI, I applied this patch.

