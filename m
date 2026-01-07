Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C45BCD5850
	for <linux-nvme@archiver.kernel.org>; Wed,  7 Jan 2026 10:33:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mvuNp/PFdNC+EYEr06QfioCI9uwHHMcfXvNdFKHhDBk=; b=qDNbCTJXNsLQHJJGjJlgg0GINx
	dwb18GOLOTZlcMnRy8hIB8gCz/1EAAnMMiBwgJtVT3oRRe58K2kpiDVWnqN3KmwqFc691VTgsBfnI
	sGwwhLfxCVmMDPOGIAz8+UWN6125GuSaU634XGE0JK5MVTRH5MCkV2XWCKCvwlyKPXDzs/JWmy0+9
	vW/YTupeVpbAbel2XxIOiAFSOIVm6MXbtYr5ZbuoHWVP/f32M+Fk06OEDqu9XBfJOKzC2Jx3pMavn
	j5pvWybtrjbZW3AVKYaXe80+wJJO0BNQ+mzt1Wccz12AZtV9CZ50BL0ctcEwj6i82cV4wYS7rdA9Q
	gV2qeVzg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vdQrL-0000000Eicf-166w;
	Wed, 07 Jan 2026 10:33:47 +0000
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vdQrI-0000000Eibr-2sq9
	for linux-nvme@lists.infradead.org;
	Wed, 07 Jan 2026 10:33:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1767782023; x=1799318023;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=mvuNp/PFdNC+EYEr06QfioCI9uwHHMcfXvNdFKHhDBk=;
  b=PnpUxNiKstdk9ZK8LFxYR5ij3nqGQhAXNl9P2WauNIAL+VtBGUrrSTgl
   mweToO5P8iXfWDViURb/IzXgvo3II/nHyuF2q+Qtzhz/e/hwLc9DL3Hqk
   hfv0w4WzjTV9o3VedbVpnHXvtylmfrikEqwD6xksMITOAMQEt+Q2TMJu7
   8wXL9PW9RoUumf7ugdEtQRUMJz57sLHp28o4FeyG0UyiBowofTDYdSd2+
   Z1SOV/O3LLoFP+dsJv8jQK3hT2ZvbFgNMWCQO7Nfi2VswphW1ZJOdbue4
   FVch+FmMKefeINjfbgtonoZLJJPKx1egsEyxYJ/KxtOXr7G8KOQCo285p
   g==;
X-CSE-ConnectionGUID: C5ZpRUmBR+Cm7c3K2A4wng==
X-CSE-MsgGUID: 8Csct34IQl+xmf5VtJGQbw==
X-IronPort-AV: E=Sophos;i="6.21,207,1763395200"; 
   d="scan'208";a="138125384"
Received: from mail-westus3azon11011065.outbound.protection.outlook.com (HELO PH0PR06CU001.outbound.protection.outlook.com) ([40.107.208.65])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 07 Jan 2026 18:33:39 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mFiEpx20QtpMq6P0WGBspj0JW2Xtqa9bBSnXmhULImSNTaWMcThNBuAJ8Q5jCmdU3KWYAjOCf3J5Trk+Cw9EggAiD8c3QjIBwI7METl6V3qe8D04HxKeQdgIFyJm5KWPkG8gpfPt/1RsqsauQUoEx9oskhK78INqt8sMQ0s8SDwFuxj1WzlzqJyDaJbhE+KX41BVGwSoBuNMUBN72CRTAxItv/yLNHM7Qq5Kc/XCDTSf8R6rKeqvDQC/RePb3ymdXlUpgXoNLsu9ybXTX7YLgm737r1A8MjV4LLyI3Sj5DAx/tUV1mtBEy6TN1MAqNnZMbYnZVvwNdjbe/+OH3qhyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mvuNp/PFdNC+EYEr06QfioCI9uwHHMcfXvNdFKHhDBk=;
 b=owD697Tg7yz6Bkn8qoGNXQIzjBi3+HLlw8asTrpTtA+UGpEyPeWfgFyQVTRFpfZfrjK09ManvMTEa3euY0IhY5/Rnr0Rq/+pedPDEDuVL5n7IDuvA1cxz1sGMdgxcOsxj3SVOe7876yP19fMM2lM0vI1/Vlt3xLCJ7JDpPHOPRqgUmGFciB/pIQjhdI5UGNRyNd2KvmoL9tbSHRuYTitW3kTlLUvTO3Q3JeZ/9naPAu5SLxjxq8bjB8SIb1PXenZmdIrkPUrBn2dcHXP9n5jQLAeuRdKXqI6bAJboSFUoeYabvdjhDZ4wphmeFrskNWqkR7DG/zhT3QbRj6inzTTkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mvuNp/PFdNC+EYEr06QfioCI9uwHHMcfXvNdFKHhDBk=;
 b=uRdMH9pyZiaAitW72Puia6IEdZIBDzfYYSTZJaG3fjWSnr9NhfabnEhJTGm6Yy4LYT8G30Ny225dVzcJmscD1GCRo9FmFRptwf5ez5QN5ZKyalFkqWbYfdMrzr80KXUXWYMGWuu8N2xwSrQTT1lZsxEaMbPLwDB3fG63amqvHlY=
Received: from SA1PR04MB8303.namprd04.prod.outlook.com (2603:10b6:806:1e4::17)
 by SA3PR04MB8669.namprd04.prod.outlook.com (2603:10b6:806:2fd::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.2; Wed, 7 Jan
 2026 10:33:38 +0000
Received: from SA1PR04MB8303.namprd04.prod.outlook.com
 ([fe80::8719:e407:70e:f9e1]) by SA1PR04MB8303.namprd04.prod.outlook.com
 ([fe80::8719:e407:70e:f9e1%5]) with mapi id 15.20.9478.004; Wed, 7 Jan 2026
 10:33:38 +0000
From: Wilfred Mallawa <wilfred.mallawa@wdc.com>
To: hch <hch@lst.de>
CC: "kbusch@kernel.org" <kbusch@kernel.org>, "dlemoal@kernel.org"
	<dlemoal@kernel.org>, "axboe@kernel.dk" <axboe@kernel.dk>, "sagi@grimberg.me"
	<sagi@grimberg.me>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] nvme/host: fixup some typos
Thread-Topic: [PATCH v2] nvme/host: fixup some typos
Thread-Index: AQHcffkVzSJWAc40hUe0hEKD9dpRJ7VGf24AgAAGyYA=
Date: Wed, 7 Jan 2026 10:33:37 +0000
Message-ID: <7db5ef3b6980270c948f6bd5dd9685e15493302c.camel@wdc.com>
References: <20260105040829.732046-2-wilfred.opensource@gmail.com>
	 <20260107100920.GA26943@lst.de>
In-Reply-To: <20260107100920.GA26943@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR04MB8303:EE_|SA3PR04MB8669:EE_
x-ms-office365-filtering-correlation-id: f85ba0a5-ea36-451c-49d1-08de4dd837f5
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|19092799006|1800799024|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?RkpqSUtlaGJnblphUmxFendSejkwWXA1NmlITFdLMHNGdjkxSGViSHNCRkVk?=
 =?utf-8?B?bUR3TkxPdnR2TDgwRkRrMkVzZ0JEOUpXdm1lOGZTZ056dk1NakRJQWNkVHUy?=
 =?utf-8?B?UW4yTmlFY3ZFcXJEUTBBdzhvTzNTckRGUDVPS20vY2JZZGlnSDcvZjJzK01P?=
 =?utf-8?B?akd1NXhEMkdhNW0xWXZPd09TKzdhaFJTdjcydnQ4YU9VT3NKZ09TQndNRWFS?=
 =?utf-8?B?NVNWSlI3ZXd3cjJLek56SkxQUVVUQldqNDZXMUJCS3lKamFIVzE1UVpLYWhD?=
 =?utf-8?B?VWtpcW1JWmpkam5ocWNyN2EyVUNVcWh2RGJyWXNuaHM0SGVkbjhrTlpCYUFY?=
 =?utf-8?B?c1dlRER2QlZ6cDNRTjFzZnRKeEFuSUlYUkt3cTRBUytFcEh1S1hBaGRBOS8x?=
 =?utf-8?B?RVdFK0dvRzVwUmJoSW50YmZNZ0pNSVhLWnVmWDJKeGJldm9FazBEMVdmSFlK?=
 =?utf-8?B?WHFMTEpKMkptalRRZVFKRTZ6cGFEL0xxcUM0M3BHbk9LN25Ubm1aWDIvbFZi?=
 =?utf-8?B?ZlpKL0dxT3htSkNCVVA3eXNZUm9EbUFwcWVNcUc3Rk5DWjZsUmhWMU9TT002?=
 =?utf-8?B?RnNva3ZJeEtlakVTSUEvWGdRdVFXR2lLMldxbEhqNHZzaEpFRmJrN0hzUm1I?=
 =?utf-8?B?NGpOVEhTS2xLRDVTbU85UFBwZmFpeGIwTGoyN0FuVnJKb0VyTHBUZkZZSTNN?=
 =?utf-8?B?SXJFV1NpNkpKVjlIMW9tank3UHIrZmdoZXgzeVUyYXBGWU80S1gwZU1yZWNq?=
 =?utf-8?B?SlhTMklhd2pSVWpmYUJlYi9UVGVyZGxZSGVqQTJPOTVtK2g4c0dzaXB0dGpD?=
 =?utf-8?B?eVhsN1RGeGgrUjNMSlovTEFBQWJPaXZwUUd0Tnd4Z1pjWVl2d2lMZlZrRmxp?=
 =?utf-8?B?OHlOOHB3Mnk2dGNTRTR0YUpQcGYwMlhoc24yUElEREJvRXRMNkpJOWhIM0Vx?=
 =?utf-8?B?RFBOQlJDQkRZMjB4U3lBUEJqS0dDb05VQUFJeUhUSWJIQ21VcjJqUUI4UlA0?=
 =?utf-8?B?REZlQ0pCN0g4YlhvKzIxZUpwMDltZUpQYmswOER6ZVk1MzJmK0k0c016R29r?=
 =?utf-8?B?aWJQeUczcDNaOEt4MHJPUzBmWDV5MzUvL3FFenJEaW12cm9RTU1CQVVSYktL?=
 =?utf-8?B?MkpJcGM5TWtMek5ZcFBOODYyVklJS2x3b2VGeEJFZVdsSmRrSkR6dUdabjJy?=
 =?utf-8?B?MGRXTHJ6QXNsdG5ILyt1OHNLYzR3OE5jLzAvbmdGSXhZcHg1TDdqMGl6TytZ?=
 =?utf-8?B?WC8xMTByN01ORDZzQlZpMmkxNFErd0F2UENuTDgyUmJSd1I5Ymg3bmplZldE?=
 =?utf-8?B?eE1QN3Y1OFZJQUxyOXlPRnJLQlJPdy9jalNNQUNiRSttTk44azRyNFIzVTJu?=
 =?utf-8?B?U2ptTlJVRlg5b3A3RkZodUhJWnFIMzVuSzRRUFZMMFVnT1R2OVkzNWdzWkZH?=
 =?utf-8?B?eXFDRnZkMmNRd3Z4NDZUa1pSL2cvd0dGTE1pZ0RIQUxzQWdqK3doZXlPOUJt?=
 =?utf-8?B?ZTZxcHF5WGg3SEx2ampGNDUreGRPTlV5T1NEMDVWTXhCbGhmUzlZNndUQi96?=
 =?utf-8?B?QzRrRmdubjRidkI2eGtqZEVQQlJnRHVrSDFXNTZRME9VUDA0cHA4Z1FWenJD?=
 =?utf-8?B?WGFEbHRqSCtpdWh6NXpNVUVkYVVtZ0xaUWlENFN1cmh4M016WUd3MWxjWnph?=
 =?utf-8?B?SVFqR0FiamUydmhTVnBaMFVBTFpIRTQrUTZPYUlNcHI3MUZrNzNRalBVMExt?=
 =?utf-8?B?RG93T28xN2hXS2tvVUlmNEtSRG5wcnhxY1lld3pOa1M3QXozcmZMdFl2V3h1?=
 =?utf-8?B?by90WS8yVW1jOUVvdERvZ082ckNheGVjeTZSaksrZGNYeVNXeGtMcGtJN0Fz?=
 =?utf-8?B?bTNBVXUwZDVyUzZiVGFIczd0RW52by9ac2tnL2NtNG9MN2JQOHVxNk54SThN?=
 =?utf-8?B?Zk1Bd1MzNXpFZFoyYjIvVktMSnBETHNXQ1M3MlcyNXNOYk9JQjFNRTFaZ3Nu?=
 =?utf-8?B?YVRtclhGZmdBVDZHZ05wRUp5MmlYMHhObit3UzBwcitVdTZJVmVOd3ordGpu?=
 =?utf-8?Q?5IZFqZ?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR04MB8303.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(19092799006)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aTVKMzhTSjBzRG5LbFRwMDZQK2JCZ3lwWmh2QXRJb3lVaEtVUmhpMEZBVVJx?=
 =?utf-8?B?MU5BcjV2amptdVRQMzlmV28xcmdBWVBvZjVSVGpPU0k4SW5nRGxhYng0Wm5T?=
 =?utf-8?B?clNia2ZkcFJtODZqK3MwS0c3ZEU3OUVrSmsxNjJQcjg3QW53b3VmbEJ1aHFv?=
 =?utf-8?B?WTBvOWRFOStsdjJOSlE3QzdENERVQWdNMitZZVk1VG1hazJoMUZGVk1rVkxv?=
 =?utf-8?B?ZEtHeXU5bnpJUXFsY3owTzRKU1h4c3RhRnh5RGtiRHpZZklldnhCNkdBQUdx?=
 =?utf-8?B?ZTNvSXVLc3N2OEd0LzNoMi9rQUFzMk45YzlYK1lEUEozVnovb0JOa1FOSTg4?=
 =?utf-8?B?eFhYQktCL0lNa3dTRTdqOVBWM1MyK0sxTTBTRWhycUl1ZkNlU3dXdHE1bWtW?=
 =?utf-8?B?MEhyaDJuaGM1R25GNDQ5STRRa2E5MU90UjVsNWFhcVFjb1NUOFl4ZGozTGtE?=
 =?utf-8?B?d0F6cXB4Sm0xRnhwRXZUZTVlcVQyajdUYjBySFpGRFVla24rc0NBUEpmVC9V?=
 =?utf-8?B?UkdXMDN3UFhnZ0tXRXNkQjc4ZnZ6bEZ1MkVySTBDcW5hY2IxSDU1ZEpKSzYw?=
 =?utf-8?B?TktMWTlod3JZaUlHcUs2K3ZaR1lYRE1TaW9MUHVvNTVyZzJrN2F2YjRXUUFk?=
 =?utf-8?B?bTF1VHVSMGlGM0JRTkZ4VHJKM1JndDBicUZzZmVXZk55S05Ma3hzcm9FcFhV?=
 =?utf-8?B?azRuYm9POWtBZjRCcHV0NXRjcER6TVJMQUdJM1c3YWdMQ1pOeVlNNHYydzhV?=
 =?utf-8?B?cCtXaEV0SnF6MVFTbjg1RUtYOGpjNUxVQTV2dHJva3VnQjUyNUlQWUR5R01Y?=
 =?utf-8?B?Zis4aDN6dFp6NExjOFIvN2h1c0tyb2FkbGtWYmUxNHZqdi9XYjlDL2lWK05I?=
 =?utf-8?B?ME1jUnYyT1ljVHhFaFNCVTZxMWZSRHZ0dnFuWWJvOFk3MkdCUXBQZStMaHNR?=
 =?utf-8?B?Z3R3QjhFL2VsN2s0VlEyWmZOUGE2aUQ0RUJVYW1SdXExQ3UwSEdiMVdzQUdV?=
 =?utf-8?B?N3hKKzV4V29Mc0thYXlKNldJWGp2M0hQeTRXOFh6cHg3ckhPNDl4N1FrQXhi?=
 =?utf-8?B?eVhmZkZ5MGNVVXZEQTVLUnRYQ3JkSnRyYyszUU9OVGgxVHpCRExNRysxdXNQ?=
 =?utf-8?B?OEt3OWM3WHpaUzZyQTlabEl2TzRQOUhDdGRFQVVNVDVmZElhV3NMNklTT2pn?=
 =?utf-8?B?TzZGZ282eDRPcUIxVmZsVVJicnRwTXRuM1duMkhQY3BreEp3bi9BOFhURGRJ?=
 =?utf-8?B?Qzg4TnRmNWRGUEJaWVZDNWxQays4NGloQ2c1VVcrNTNYT2hXN3h6anNRZUVp?=
 =?utf-8?B?anUyNEFqbXY3NnR3SVhaSlZmb0hmWFl6R0hrTEkvTlJZamxQdit2SjIvaExq?=
 =?utf-8?B?dE9ibkd6d2I5WGxjY0JIeEpXclVtcExwMUFGeVMyVmlWV1R0TVRIdHhzaTgw?=
 =?utf-8?B?NGRaMHV3bHJtRXdBOEU4N1FIR1NSQU5aV09MMDdGOXlNNGtaYUlwZjVlRUtj?=
 =?utf-8?B?amsrK0VKb1ZkeG1QZDR0SjRkbFJKWWZ1b0JmSVpaR3MwM1FCdFZTdW9Meitz?=
 =?utf-8?B?VG5seWh3QjhMOU1ESjRDd040R3dtYmhuemp4c0RWUXNCNXJFZkFIL3pLN0NQ?=
 =?utf-8?B?TEJrdVV5RXYvQzlReUdVVERub25pcEU2d295S2VRM0dZU2hLSEdVZnYvK2ZU?=
 =?utf-8?B?UHF0Z1kvTVE5TmdheGh4djVHRDJ5cWFsWDNYNWwwTFZTWnVFSVdDWThHQTNl?=
 =?utf-8?B?Z1dUSCtVRzN0dGpxN25TY3BTMElRZC9FT0VNejVOR3NDdjlvTUIra2VJWUdF?=
 =?utf-8?B?VXg5WXFtaW13WnZxZGFEUDhTYmJ2Zmg3RlplZGhuZ05CTXF2bk0zTHo4bVNS?=
 =?utf-8?B?RGkxNUJqRXAxbDBFdS8xb2M5UGRPa0tUenRYb3BFdHpTbUdzeG5MNTJPOTAz?=
 =?utf-8?B?OUc5Nzl3a2RmVVpjOVdJWDRvc25tUzY0dXpjUVQ2eVdvTlZoZVVlcDNMdEt3?=
 =?utf-8?B?WnRzcUp0OTVnNTRSWStJeEJja2JqcHJUYldROEhJRXVqbnpWVHNlZEd1OW5W?=
 =?utf-8?B?dVBwL3JaSk5wL1puRTltazhjbnplQ0oxTEYrVGhxVkFkTmdReDZxOGhoNEpU?=
 =?utf-8?B?RE8ycTI1U1czQW1nRlJydmNnWlRuT000WkRJblNCVGhGTG9GWGtEblNZend1?=
 =?utf-8?B?Y1dYTU4yTXpQdjE2R2tqNm94TU8wS3lWUjVVTjlxWkh1L0JDbTJQTHNsWEZm?=
 =?utf-8?B?cXFwek5ZMDlseXZDVDBmSjZTcWpUYUVJN3U0ZW1XZXJoN1NWV0JyZGhvYks1?=
 =?utf-8?B?QkFCUkZ2SHRMeEU1Z1dUQ1lZL3VuN0g4NndVN01KR1hJT2xwVFhYMjhQMEc5?=
 =?utf-8?Q?6Rug4jI5IMDY/sQo=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <13BAF98444FBC2408DC3C3E88CAEF23D@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: rbBwQbTsuL9slmb2DpxAdDRuX5JY7FSKgdVyOmE/3Ijc9McWOZSvYkhXwzKxubV7w5rfis0duPVYrBJfchEMt1Y1/nzloUYCR0up/kUiRZ9OptGTiCKYDSDPIcnzg3oiZa/8hOH122LhpxisETXeutv+rPnXs14VMguvttAAiqcON5utryNsfiy/RLiacJiLTwJfqwcD98/3Vcn8jADN4TDd35gI4X+7wWSPB9ZuFgMmk25tpljmLswJT24WZP0X0fNq+v+qNZK2dHD4sFU/I1icBNykxTgS1vpW/uUJYeTVdJmVrmgIQmO0rSNo0TRdSWxmaJXg9uY8ydAlEYUhyoPOBLr1ZpYvVbH/D+xRSvLa4hzvvuCKtv5ZtavWbXU4GJ5PqJjGngw2qQNZbWJEwymiQMl5X1uZuj4T43iQ0QFO3xV7b8Ru+GX+YAyCjrvoKGudpqJ5fvvKCGFXmlFqGPVgBWTTZDQitC36W0E/n8YU0m4AcaOq3UkC4q1h80luOfk0VHNYUlmAAgzTy4y4v9anGONamUuFYn+RwX8KWo3sqT4j65Nuu4sN9qprg4E9lFKdY8x57W9EZm4P0PiuGxXgfdAURe/EBhPB+SZRsbY+QM00AASxNAI+WHQQZBnN
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR04MB8303.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f85ba0a5-ea36-451c-49d1-08de4dd837f5
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jan 2026 10:33:38.0031
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Y9JBSfVrwcPAD8RIinauC51P5a2qqUxyjB/TrophCiisjB5B40ktxvU5lrbajQD9HyAPuZnnJlz4jNmm/48QQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR04MB8669
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260107_023344_757640_EFFB6CA9 
X-CRM114-Status: GOOD (  19.24  )
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

T24gV2VkLCAyMDI2LTAxLTA3IGF0IDExOjA5ICswMTAwLCBDaHJpc3RvcGggSGVsbHdpZyB3cm90
ZToNCj4gQml0OiB0aGUgc3ViamVjdCBwcmVmaXggaXMgd2UgdXN1YWxseSB1c2UgaXMganVzdCAi
bnZtZTogIi4NCj4gDQo+ID4gwqAJLyoNCj4gPiDCoAkgKiBIYW5kbGUgaW9jdGxzIHRoYXQgYXBw
bHkgdG8gdGhlIGNvbnRyb2xsZXIgaW5zdGVhZCBvZg0KPiA+IHRoZSBuYW1lc3BhY2UNCj4gPiAt
CSAqIHNlcGFyYXRlbHkgYW5kIGRyb3AgdGhlIG5zIFNSQ1UgcmVmZXJlbmNlIGVhcmx5LsKgIFRo
aXMNCj4gPiBhdm9pZHMgYQ0KPiA+ICsJICogc2VwYXJhdGVseSBhbmQgZHJvcCB0aGUgbnMgU1JD
VSByZWZlcmVuY2UgZWFybHkuIFRoaXMNCj4gPiBhdm9pZHMgYQ0KPiANCj4gSSBkb24ndCBzZWUg
YSB0eXBvIGhlcmUsIGp1c3QgYSByZWZvcm1hdHRpbmcgdG8gYSBkaWZmZXJlbnQgY29tbWVudA0K
PiBzdHlsZSBub3QgdmVyeSBjb21tb25seSB1c2VkIGluIHRoZSBudm1lIGNvZGUuDQoNCkl0J3Mg
anVzdCB0aGUgZXh0cmEgd2hpdGUgc3BhY2UgYmVmb3JlIHRoZSAiVGhpcyBhdm9pZHMiLiBJcyB0
aGF0IG5vdCBhDQp0eXBvPw0KDQo+IA0KPiA+IC0vKiBEZWZpbmUgdGhlIHNvY2tldCBwcmlvcml0
eSB0byB1c2UgZm9yIGNvbm5lY3Rpb25zIHdlcmUgaXQgaXMNCj4gPiBkZXNpcmFibGUNCj4gPiAr
LyogRGVmaW5lIHRoZSBzb2NrZXQgcHJpb3JpdHkgdG8gdXNlIGZvciBjb25uZWN0aW9ucyB3aGVy
ZSBpdCBpcw0KPiA+IGRlc2lyYWJsZQ0KPiANCj4gVGhlIGNoYW5nZSBsb29rcyBnb29kLCBidXQg
aWYgeW91IHRvdWNoIHRoaXMsIHlvdSBtaWdodCBhcyB3ZWxsIGZpeA0KPiB1cA0KPiB0aGUgY29t
bWVudCBzdHlsZSB0byBtYXRjaCB0aGUgbm9ybWFsIGtlcm5lbCBzdHlsZToNCj4gDQo+IC8qDQo+
IMKgKiBEZWZpbmUgdGhlIHNvY2tldCBwcmlvcml0eSB0byB1c2UgZm9yIGNvbm5lY3Rpb25zIHdo
ZXJlIGl0IGlzDQo+IGRlc2lyYWJsZQ0KDQpBaCBubyB3b3JyaWVzLCB3aWxsIGZpeHVwIQ0KDQpX
aWxmcmVkDQo=

