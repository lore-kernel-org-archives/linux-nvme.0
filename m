Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EAE7C3ABC3
	for <linux-nvme@archiver.kernel.org>; Mon, 12 May 2025 06:01:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ppLuiIqcNviAhjJtSQG7oGIFkoaVVq079zIOQ8Jzx10=; b=J0gnIOLhJHkJugVOgbkAmPrTXG
	C9FfPCJfKK8AFgoP700x95TtgF0wUkftOsWnsSiIIA7qfq6MEY7YnAhxmLfokC2CLj7gAEzAgyaGy
	Hg0g/pByfeKq5+ZOEUqOFprnNWHhiInlUkXhfRqIYJ9Ttw9WC1+7b9+rYWLMjPUOn0wMQTtas9avh
	0nQvZwoQS+OvxNkGi3Zg/IKkOjzqS5VxYBajZNZTDW1/o38J8qbryB8/G12l1uv3wcowheZfV9REm
	6f1RLPsZkhA1GWiJy9dG+Kb8SvbyzIqmth0nw76Z8wuHlp8FRLAglkoiSW3tJkvF9vE9bZi89ZLK6
	GOHxNF6g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uEMER-00000008Sq4-15AN;
	Mon, 12 May 2025 06:01:43 +0000
Received: from esa6.hgst.iphmx.com ([216.71.154.45])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uEMEO-00000008SpX-17LY
	for linux-nvme@lists.infradead.org;
	Mon, 12 May 2025 06:01:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1747029700; x=1778565700;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=ppLuiIqcNviAhjJtSQG7oGIFkoaVVq079zIOQ8Jzx10=;
  b=Cm2IKHc0Byo1NG8Pvl6mcWurwU0kOFPnhUkB2rPOsC8y6NAjlyANfcbc
   4JDxoNjsUG5eB1ObmBCGNGvec8cUEi9sLyJrLiD5LKBsJF+aga6n8W7qn
   DPk5gPaZyuODL/U3qkzas+uy78h6IFU9CQF/uL32VFIr5+iUZmj3P7SH4
   1DokmRUZmJyxQMVPwidfQpIsb1mDX1drtU3+fXBCPdNOUC8/FwfMlYHjB
   X4mzabl7YZaKy8ZYr+B1bRdf1nyT1J/ELxREc23WmdZu73kw0591wgRfR
   EjGL4O1hvWO96gX2PyfDIawmWiR++gABQvILPCEecyS1c7d+9xq1k2Cp6
   g==;
X-CSE-ConnectionGUID: eOWS0IcWQy6q7BMujuhuAg==
X-CSE-MsgGUID: RJ74h6PgSkqLtfdRJF/WOQ==
X-IronPort-AV: E=Sophos;i="6.15,281,1739808000"; 
   d="scan'208";a="84966317"
Received: from mail-westcentralusazlp17013078.outbound.protection.outlook.com (HELO CY3PR05CU001.outbound.protection.outlook.com) ([40.93.6.78])
  by ob1.hgst.iphmx.com with ESMTP; 12 May 2025 14:01:37 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QannB25WC97GP9p9dnrntR5cU99mZcmLFclpvDZyFjTJ7zxpyr2Cify2ZL6XSplqDUypeBvrLWC01Xw+wOpWIpuofxm+14SA106vrhJEKlwLbtsH2hwW3qMU1nQUOQWv0E1JGB08DFvKDsRvHzksMsMaaqGsVnlQ2tf5je2aK2PkodHmAv6UNbmh669w1tJnkyre3ZkdLOBjlkllJRHwK3OgO2MjWUbIjFd/UalGTPuTQ5lAHObHUDb879XYxKTEoidxvTWiznNz0n2Q+suLl7sAiggeL6WkHsx6S8aVaIv7O1C2MjOKiw8xKvNtaiTNTBEMmPHc5Ew8V65u0UPZDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ppLuiIqcNviAhjJtSQG7oGIFkoaVVq079zIOQ8Jzx10=;
 b=yNTig1K0taRS+7yWXFVm18vTZYlmsxHonfqs2KbLiZjhN7WtC4+o+zM9jf8ajM8oWk85X8PzowtC7A4vh3NxdagODawKgTwlH3EQT//W6RbvEXPstY7Q1UJL1sUMudkQIpMtz6dQfJctQsUWFs1n+fZqknN52+iGYTqzM35aTOiC2IFAzcCQQJ0wlnniRGYa5xhtw/JB4WBdlBMbp0nXrI2ITSd+UewzMI88csDafas1RX/+J4O+nHVnpR02gW2YyTgRseu2bEenrBOtDiCLcVDZbNkx5FVHgwb7sNfW/vBzjm9hpq6FuKAroxXNlEJLjQAU52BzoFXgWOYHNMCI0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ppLuiIqcNviAhjJtSQG7oGIFkoaVVq079zIOQ8Jzx10=;
 b=ra2LAJDHKURnyshfRhOgMM1OPOJ0t7Um+dDYoxqijHkTW85Px/7tedUfvo8WVfw/sA8D3mj4rZp0u8+L3z7hsWEP/WYSJiSYdgw3JqIR5O/QNarSlsRHZmvlunhni9lfK0ClEbGMbizQbTJNxU+L8kMPaiGZgfTISlueMsXF9KI=
Received: from PH0PR04MB8549.namprd04.prod.outlook.com (2603:10b6:510:294::20)
 by CH2PR04MB6920.namprd04.prod.outlook.com (2603:10b6:610:91::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.29; Mon, 12 May
 2025 06:01:34 +0000
Received: from PH0PR04MB8549.namprd04.prod.outlook.com
 ([fe80::5b38:4ce0:937:6d5e]) by PH0PR04MB8549.namprd04.prod.outlook.com
 ([fe80::5b38:4ce0:937:6d5e%4]) with mapi id 15.20.8722.027; Mon, 12 May 2025
 06:01:34 +0000
From: Wilfred Mallawa <wilfred.mallawa@wdc.com>
To: hch <hch@lst.de>
CC: "lkp@intel.com" <lkp@intel.com>, Alistair Francis
	<Alistair.Francis@wdc.com>, "sagi@grimberg.me" <sagi@grimberg.me>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"kch@nvidia.com" <kch@nvidia.com>, "dlemoal@kernel.org" <dlemoal@kernel.org>
Subject: Re: [PATCH] nvmet: nvmet_sq_init(): fix use of uninitialized variable
Thread-Topic: [PATCH] nvmet: nvmet_sq_init(): fix use of uninitialized
 variable
Thread-Index: AQHbwT6WN9zROj7YhEyZcf8SYHEhq7POediAgAAKSoA=
Date: Mon, 12 May 2025 06:01:34 +0000
Message-ID: <bcb4f910f8ebfd43e055513666e7e2082bc986ad.camel@wdc.com>
References: <20250509235904.915626-2-wilfred.opensource@gmail.com>
	 <20250512052443.GA1869@lst.de>
In-Reply-To: <20250512052443.GA1869@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB8549:EE_|CH2PR04MB6920:EE_
x-ms-office365-filtering-correlation-id: b0c8d64e-e82d-41ce-5408-08dd911a7341
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?NzZHZHpBSlY4S1UwN25hRGlKaUtiVWxUaDJlZU0zaGNnYTFpMGxjaEdhZkht?=
 =?utf-8?B?WHBYREVpZ0dJK2NhMFBFVjN6MDNaakxvTEl4RUhGa1RpTXNEakxYc2hhRFVM?=
 =?utf-8?B?UWpXTnB5bVV1UnROcHZuUUcxdElEcWxZd2drNlZock5iMUtEOFcrSmIrSFpM?=
 =?utf-8?B?emFPUXBteEVFaVh2Y3RueFFHZVBsVHJLeVp3VUNQeHUxZmNGd1MydmxrUGtN?=
 =?utf-8?B?OEhuc1ZlelVJcWpoWExCNjZIMTRzMldHb1ljSlVmaXRtTWhCZVpRNjEyVzQ4?=
 =?utf-8?B?bm1yOE9idEhUdnV1QzBPQ2RIY2xPazltNXpuOEQ2cUdCQlQ4Q2s0RDVVbyto?=
 =?utf-8?B?eUE2elV4Z2RyM0NVdmRNYXk5VEQrTSsva3NHVS9nL1NxU05PaGxRODU2Uit2?=
 =?utf-8?B?eG1Pcy8vMWVPNUNtWTdFQ1VkZ0RCRWw2amRZS1ZwcUF6cVN0VjBES08wY1B6?=
 =?utf-8?B?VkFZNGdybVp5SHp2OTg2bUR0UkVqaEdUV1dpV3VLdFBhdW5tbHk5WkZoa2ND?=
 =?utf-8?B?alNsUk93S001UzQ2UG4xanRCeUpTVWZsU25ESTZIM3U4YzZib0Ftc2U4WWw2?=
 =?utf-8?B?WmlDdGNpOERUOExUN3NvbWJvOHRMekhNeFZNdVVtRmw1ajFVS2R5bDV2Tkg0?=
 =?utf-8?B?L3J4ekZHdkt4UXRDajFDc0RTVVppczdMcytNUUc3ZEpzNHhIbW5KRDh0WjRH?=
 =?utf-8?B?QmxMNGxhMlFselNzejVFV2d4M1lNaXkrWXBpZEM3cjh6VGFseE1tWmRGMGNG?=
 =?utf-8?B?RDIvL290NUNBaDkvWk92cGtHcW9KaHRIVVlKaXE3ZVo3VFhxcVY1ZHp5RS8r?=
 =?utf-8?B?VWZBYUVoN2V1MjZMbm43RjVWMXZWUDM5TXVGQlFXVENXa0YxUnpLc0xHMkF5?=
 =?utf-8?B?VG1iQS9Wc21LNUJrRnpZZ09LdjFhYkpyTnZEdGYzTWVhY1kxUmtNbjV5MHVv?=
 =?utf-8?B?bzI1am5iUU1vS2dhKytFUVZxV1Iza1ZHRmZoTy95OTZtM0Jrc3JxQzN1T0Vr?=
 =?utf-8?B?NE42TU5QMlFPUXoxZFVrUUVrTXZUTEZjYU5PUHdzQmdKdVpwV1NIY2dwN3BB?=
 =?utf-8?B?amJjU0t2cFBjR2tKWStXaXU3RHhQZGh4MWg2Mjhzd3dtdmR4cXEwbDlyWWdr?=
 =?utf-8?B?bXp2eEh6Mkg5dXpEWjFSZUVGWVg2NUt2cysvOVA2QlJvM1lOQXBSaGswVHJP?=
 =?utf-8?B?dTQ4dzkxSExSdWlxYVJFMFEwazdhSmV4OUFueVNERFE0cmgwaHBGeThvNHZE?=
 =?utf-8?B?L24rNnhmQUNFempZRkltYW5nT0R1VGdVd0c5UVNMOVltdS9sbklPRmdIeDBr?=
 =?utf-8?B?VUcvWGNsM2VWZXNXR1BHYmxqbnEzQXRDTVVSN0JxdkFodjBJNFV3NngwZmd0?=
 =?utf-8?B?Z1dnRk5jMWc0b2tQdTY3VVpCYU42U0NmVitNR3lITmdGbnl2NWk5MFI4MUF5?=
 =?utf-8?B?eTYycDJkYitpRzFtelJVUm9GbEJrTTdUd051Vk0rNlZ6dkhyN05qcWgvLys0?=
 =?utf-8?B?cTAxdklLaSs3R29Hd0ZmSDZLV3pKcDcrUHZ4bGxjRnFtNExtaENBcXhhSEFX?=
 =?utf-8?B?WnZrMCtEbGwwUndSRzhTSGJDR0hDOFowYzFCbUpvS0FMNGZJWWRWd0ZlMHRR?=
 =?utf-8?B?Z21hNytkdGFqNjE5V2pTWDhaQVROWk14VXFsSVVpRWRzV2h4MUlVMDJBU1Nv?=
 =?utf-8?B?cW5yTnN5WjdYZWFjNnpOcGNXVzhzUFJNeVFTYXZocTdibnZ3VXc3SFVMdlFj?=
 =?utf-8?B?aldxU2hLRkc1c2dZNUQvSDdHbU4yejBTTW12MWZFYkp1aFpkZkZjZjJCYVBa?=
 =?utf-8?B?NnBveFpnbUpwN0hhTjg3QU9DRnBGbm9HRnhLeW9QWnBWS1BMbWNGWTNwSVVH?=
 =?utf-8?B?cVBkaUhVa2VRMFVaS1FxaHdpbnVDbGZmdjk1bVBRRW00bXRSeWl0VGE0R25z?=
 =?utf-8?B?ZFYxVk5ZUWlxWC9EZXJjV0NOVGFvd3lDM3hlbjlWVHJJM0lZbXNJS25vZkpS?=
 =?utf-8?Q?2pm+7dg78WL8Wdxs3iAG49OSmKIM6Q=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB8549.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WkhpV0FuZDdPcEpJYlFCWDJmSXVqMjMvd0Jqa0F6SVgvb21wdVM2WVVlZWlC?=
 =?utf-8?B?WHFKc1ZSR0d4N2JGY0hJYU50TzNiV0FlU1pFNHZuM1BqelNhRDRGV1ZEdU9u?=
 =?utf-8?B?Q0F4K0NKVkNGaE9Yb1JTUEpZT0xmUCtNMTc1U2NHZTJKZU5RTXAxdjRyY09m?=
 =?utf-8?B?YmxtQ0V1UzU3UGFkRW1rSndPQzlUejJVeFlXTkhvZVQ0M3VSdjc4emozMXhU?=
 =?utf-8?B?VkYzVFBKeERrT05pTjhHanZ3WEFscWJEQkpYQlhUU1R1clNMS2Z0bUtnMVFO?=
 =?utf-8?B?VU0raUR6cDR0Y09sZDZSTHRkYWd3NnBMbzFwZDBETkxMQ05wZzkwb1VhSHdh?=
 =?utf-8?B?Zzg3VFRRRWhVam9zbXBCRkNqVVE5LzBKelo2MHVsb0RqdTE1NFhaVnBYZERK?=
 =?utf-8?B?VHBmWXlDNWZ1cmxpK0kvOFhXVUJtN25IdzM0VXZqT0J0dFVDQkdsaGtHZlI1?=
 =?utf-8?B?azRhYzNpak95ck1iUHpja1M5eHkzOXVzeXFaQmJDWVdhY3lsb0IyYjhUZjVk?=
 =?utf-8?B?VVJuc2pXS01oQ0RFbGRGSk42RVkxT2wxR210RHozY1JUelNDK3dybCtMNitE?=
 =?utf-8?B?aXhlTk1HWTVQNDU0eEsxWlYwWXViejdMZmpTVWNsWFhoWEF0dXhQZjlTU1Bq?=
 =?utf-8?B?dFdIdlEzMVZMVlpJTHd4T2U4U1BOTUJXOE02RE5EQVd5ZC9Xb05NbXpiejFz?=
 =?utf-8?B?RFg0QTBXa1FDZ3Q1V2xWeGV3SllJODNrNEhzc0ZFK0RCaytBSGNDeEpEK2o4?=
 =?utf-8?B?VTMyK3JjNE9WY1ZHcE9tckc0MTg4UHI5QkhPeDduYWZySnZiR0t3TlVta2c0?=
 =?utf-8?B?akh5QUNlZURvQ3RZWHNxa1ZiUTUvNk5OclRRWFE3T2RzeVUzUXZJbEVrV01p?=
 =?utf-8?B?d2tmOVpnNGpreWNIZG54N2Q0VHZKVjl2MzBFb0Z3cVVFNEtSS3F1cUdra0ty?=
 =?utf-8?B?YWFiRWlFcjhJbGZVdjNoY2kxR0lYb216RzlYSmZtOWJWd2d1c0plb3NQRTZ4?=
 =?utf-8?B?dkFlSC9IZ0Jza3RRVHdqWG84NkRoWmVScmZDanZkRG9HMDdKNWV2ZWd5bVhi?=
 =?utf-8?B?QmtnMnpUT2tkSjFJK1lwdDkyaGJzMGJJUi9kTEMycEhuOEN2ZERRaUVTWGUx?=
 =?utf-8?B?YldmVmV4ZXNjN01xQXltRHk5dXFlYjczSUwzVUNISWxoUXZPVWhHUmdpMTJu?=
 =?utf-8?B?b3BmNTJNZllKUzB3WGZTQlNiYmh5R3V0UXVPRzByYXdjNTM4VC9yU1VOMHRO?=
 =?utf-8?B?WkwxazFXd29rcFBudmtnRUNpMnZoLzlvckpIWGtEWHNONTMwN1BmYS9WQk92?=
 =?utf-8?B?cHRVR0RBTHBMc3NNTG9BRk9lQklJNVZxZGZsZmV5QmlsV1NqbFNoS3F4V1Rq?=
 =?utf-8?B?Yjl3MHdIWHkycGVIMnE1bldLemU0RzU4Yy84Nk9iTkpxNDFqWVBOWmdnRTUz?=
 =?utf-8?B?cTlJcFhwVklBRi9FZkQrUEM0U29XR2V4d3dkS0JyaTliM2J3Yk1wNWxYbkRj?=
 =?utf-8?B?NE1zSTdPYy9CMHIzbFl4bnlhb3NNRDhLR0Y5a3FyMjJaVlJQSGxlVzdFQkt1?=
 =?utf-8?B?Ni9NdGdvU2J5L2VxNTczNVdxbkk3VXdJb2VTYjkvK09GdGpPQXpNUnBXUFpt?=
 =?utf-8?B?UThaWHdQUVRRano4aXZudFNLOGlJeGQ0Vm4rc1N5dDh4bm9jaVdwREpJUXd5?=
 =?utf-8?B?UURVVUVRTHZJMDlBdVU5eEk5WWMzbFh2ME5qekcwR2tORVFsdjM2dytnUHR5?=
 =?utf-8?B?QzNjT0NpVXJueVd4UCsrOWFZQStHOHlWbldocTA4Q1o1MitZdE9lVklmMFBa?=
 =?utf-8?B?VTh2eFNUbkl5K3RZU2FPekJKMUMzT29VbVIzVnNiWUE4dE96YWVpQms4MWJx?=
 =?utf-8?B?UktERG1iQnJkSVRZVE40eFFrRy9STXl3RTdPcGJ1TWJnUFo2QWFxclIyWjlt?=
 =?utf-8?B?aWRVd1hCWGdCQjdsbEZ5alg0amZldkJ5aWMwWC9aczNscWczQ0dEZGNCWGZo?=
 =?utf-8?B?YklPWU5BWkE3R0RiREdxRkxvZ21xSWV4UUdxd3dTa2hBNWpnU25YQlgzcy8w?=
 =?utf-8?B?UUdUUmQ5MU91MTREOHAzMzA3THJJa3g4bDVVbG13Y2Vta0ZqUkkxaHErd0Np?=
 =?utf-8?B?b3VqQmFPa3lBTjkvVGtOcjU4V3d4V295aFpQSDRtcjlrNzJhWmUwaWR4WVdo?=
 =?utf-8?B?UVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7A38D333046FFB4B88A0E6F2ED205EBB@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: pUrALXyAg5Fs4tsQl+gfwtZoXU25qhZOZ0QA75XqKBGtzdIQeWXdEJW4jFd+dLINAgMCqDEYtMkSwd8UlReI0qfKY7K+ySciRICkIGqQxuF7vVUnjSRLeU87SHOYYX/tfYcRdj7DfCx5IVS9FlC3VIbs8g8WTLJUEbWh3A3JnL5kmEfk2UmiIUh0d5LwoWs3CrpzAv+R7ZwgLtnO/qt0II8UZWVh3rLsDCfOqpgdRdBd44GreGWEGjZUeKSr987LLywxi5YOo+tcrNaErdoJCiIBBbpJLvqA+bRjh6eN7crBGdCQItLKzA6OVCthuDJ+NFS5mj5egjrikGk0vtVj+8NJ/amQpjtuzKWNEQoSuHrMpPXGaSTvfkofU6wt68u2Y+M+yMnkDWravFawg1Q5HveEku7ST824/a7Lf/m6nOaG3dnHktgUvStNEATxO58NuCqJQiTkGpGEKwXTD0s9gDJJBkQWug32pl+XWs+NDlYV1/HSjDr8v1h3kotIR1vVnITMvyBlEF5IVKuDqHNhFUGsR1eyM7/n8TMdq4odZKY0IZB9QYXQj6lt6hLZ5OqDSUBEW+S3u+zo4b1syT1EuKGgh2+DScxsDhtDWS3XQEh/luZ600ZMKs+CfBaholcu
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB8549.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0c8d64e-e82d-41ce-5408-08dd911a7341
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 May 2025 06:01:34.4924
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gEMsgjBKXIR62uUavDJHeqAj6L5bfIg1Xo/MXc2nuFRV4ytK//UbodZStBSiI32F+DBE2Xz43Sfzf4JG6GQfIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR04MB6920
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250511_230140_417003_09D7AC99 
X-CRM114-Status: GOOD (  12.01  )
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

R3JlYXQhIFRoYW5rcyBDaHJpc3RvcGghDQoNCldpbGZyZWQNCk9uIE1vbiwgMjAyNS0wNS0xMiBh
dCAwNzoyNCArMDIwMCwgQ2hyaXN0b3BoIEhlbGx3aWcgd3JvdGU6DQo+IFRoYW5rcywNCj4gDQo+
IEkndmUgZm9sZGVkIHRoaXMgaW50byB0aGUgb3JpZ2luYWwgY29tbWl0Lg0K

