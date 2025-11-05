Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92FF1CCFA04
	for <linux-nvme@archiver.kernel.org>; Wed,  5 Nov 2025 00:09:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Lkj15xvUGgH0rrcqJqx6WgC0pcVu0RxdUFTFVzgstJU=; b=NocgKGBf9NtfRzuAyISkfEdUIk
	le6OhqLqI+Xa4pq4NNPI6VKWSrox5ans2BvnGHWR90qll4GfJs/YwnRZgMTC/+as89iLx+oM9xS5i
	BW2dYLNaLJAMUWuMqIyFZY6haDN9RjHjcO8VPHxng9v5mB2pzrCzS/ovdM22OYM+AZIoop/TtbW2J
	icU8Mb/c9qJ0Fiud7+qHWZU+Ogx8vskI/3MyB+kcEieZGJ6g70mZEAjHBZK6Cg9n6CUxfNCTw6Z0C
	djfyPa2FazD81lWLdBWzuQJlGXxY5cYNlTf3sV8nMKZDcfWnumQC28dydqLdMmjK9Jl3IZFyqdEtU
	ZBYC2mYg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vGR5x-0000000Cma5-0J3U;
	Wed, 05 Nov 2025 00:09:49 +0000
Received: from mail-westcentralusazlp170130007.outbound.protection.outlook.com ([2a01:111:f403:c112::7] helo=CY3PR05CU001.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vGR5u-0000000CmZc-3VVn
	for linux-nvme@lists.infradead.org;
	Wed, 05 Nov 2025 00:09:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WnuO+Lc90v6C25yCAnj+U0Xtobq9mpLO7398SVXGU/l41UwNX5fGUwmMYFiPk2K8xsbvawaazgIXySCAtlSxMJUP2lH4/624a99+69LcpRwReWkMT+1g6m/kmuoP089mfVDPFZNOYOiDp2XePZjvA62uvqjf9Z+grD93pNplidrh92sBsLuPfWDCO1aXnB9SlE0a/Z1Rro7/29susb5qQye9VX3cNW5CZXYz45Ja2VPjZcXR+zluQ8jcniilAtUqu3C1dnAppEJsVpfS9nINUD33gbv4E5TKnipmZrAApNOx07AqyAwfbmRoADcrlQRASIADiyG/e4PdVdfNW8OT2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lkj15xvUGgH0rrcqJqx6WgC0pcVu0RxdUFTFVzgstJU=;
 b=kyjjizKJyT4F6F9uWwOCGkcnMjH9iNw1/78n1rBxEQCg+GRtPWeC+8+PJmoemIJOC/pKSQvhkZh5l2WJsHyYuLTUAz4i7OwR+dwxrDPtj80C/iWk4iar7OI2Okq5N3iztodkvCBEtoUuauUghF4vwILj1wSpndw6xbqdf5MVX9C+8wtXJSFOtoRw+D5JDJhb4svU4AS566WKc7M13A9X4S6DLQa57VP9W342p/d8IT2B0xpsx93gS0UWkV0lfTIhxJEYDMD1MXBASpcrZTTcRFRPP5JTqNeV0QjofZy2sVFFBseqcnhqv7TpHSHGzSdz4pQ7Nw4qzbXainQoBT3Awg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lkj15xvUGgH0rrcqJqx6WgC0pcVu0RxdUFTFVzgstJU=;
 b=WVjn+WhdTeizC/nu7/mNJMkULclgGT6rJHBuSmqx1vGJ2b6Wmo7oh4PEGNBQLotNWDsA8hhfV8c7mYtiWGW5RkLceFXcb2OvJte+lq/oSK1udPuNlvS4Lwa9ln9NeRZ0bKBPpJfs+aWd2DiZWSraQSTAJnKM6TkKNl+fSmqDkohChUeasKaMmpFfjfWnMLkBQMv3ZpC43XT7LgNqPYwgObU/xFGFidMq6IgBGGHy8qZkP27aCyoWB8kycVYvM8bvoYVtZ6eT1v2k674PWLpWbEr4vrrz1vY7St3MmsZUSMncm03JDxnQ8JI4g+xwQjDkEz+Oj4sAxa8Beiqgc5bKKg==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by CH2PR12MB9544.namprd12.prod.outlook.com (2603:10b6:610:280::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.7; Wed, 5 Nov
 2025 00:09:39 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b%5]) with mapi id 15.20.9275.015; Wed, 5 Nov 2025
 00:09:39 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Hannes Reinecke <hare@suse.de>, Chaitanya Kulkarni
	<ckulkarnilinux@gmail.com>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>
CC: "hch@lst.de" <hch@lst.de>, "sagi@grimberg.me" <sagi@grimberg.me>,
	Chaitanya Kulkarni <chaitanyak@nvidia.com>
Subject: Re: [PATCH 0/1] nvmet: add basic in-memory backend support
Thread-Topic: [PATCH 0/1] nvmet: add basic in-memory backend support
Thread-Index: AQHcTWHrDheTX3CfYEy0GSlVBKKEm7TiUwYAgADjKoA=
Date: Wed, 5 Nov 2025 00:09:39 +0000
Message-ID: <0c299f77-e93d-4c96-af71-9e1ea387c9d9@nvidia.com>
References: <20251104080610.183707-1-ckulkarnilinux@gmail.com>
 <c705eebf-bb76-4bcb-8630-99907b1b6ac6@suse.de>
In-Reply-To: <c705eebf-bb76-4bcb-8630-99907b1b6ac6@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|CH2PR12MB9544:EE_
x-ms-office365-filtering-correlation-id: f6335510-16c7-4797-d951-08de1bff9cc2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|10070799003|366016|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?YTBIajlmUk5PbGRmTElLZHg4NTRYaFp2NWhtS1FpSWR1a3BabVBYalFIRnZH?=
 =?utf-8?B?dHlnNEc3QlJ0ZU4rNWl0UnNnb3hlUHNhZngyMkZ5cUwvczEvNk9ySkxoQ016?=
 =?utf-8?B?bk51TjFESjZ1Mzhlcm1IWVpRRnJhbjArQzRMSlMxeGlXZzlmYktRTWdJMk5P?=
 =?utf-8?B?Wmd4UWVmbFRnT3BiYXZVaEt2UGRnVEpnMkVJYzM2T0ZhYU9DTkNMY0ZQenZ6?=
 =?utf-8?B?OVY1c0pFWkpaenVhVjBHT2QxaFlSK21ZWTl2cmIyd1JZbTNobHhaN1FOQjQ4?=
 =?utf-8?B?b0F6TUhLc3pCZExOalF0YUw4VTRkL212NjJiTWhDRXRBUXBMckgyckI1UmlL?=
 =?utf-8?B?R3RzNTNqcXJCcW5xaGJWelBWMDREY1NUdXNhRmJhL0MzejQ0TXkrdDByTmpN?=
 =?utf-8?B?VWRpcEQ0OWFkUUVlR285a3JuUmF5OG1JY3lGSk9PdFY1Sk90Tk9UdmI2b2hy?=
 =?utf-8?B?ZHVKMVJ1US9JcktPSUUxSjgvYUZKQS9HQkY0Z0VYczlrTHNNNlpjQmFIeDBx?=
 =?utf-8?B?Q2lCRmoxdWJBM29UdFBCQVhDTFlNZ3NLZjNaV001U0JBREJwdlJCUTJXaGND?=
 =?utf-8?B?Z0hxMDJyVUZ3ZHNHSUpiTXpDZDBFMThJZzd5ZlhkMXE4L3UvYXVjSnIvcDRx?=
 =?utf-8?B?VFNtdnJscStLUy92cWpYWWVxSlZydEZwQm5XeHY5SDJxMGh5MFFHMGcyczdZ?=
 =?utf-8?B?RjhtRzJsNlVST3hwVUVCTEh5TjF3WXJkWXpaRnM2Qjlsb2czVk51QlNpTWNI?=
 =?utf-8?B?VktGSUNKaDVBS2RLaS8zanRleStJSnJkbUROaklmUGxEYWFiK0NsNmhOTmE3?=
 =?utf-8?B?Wm9FM0hnbDJ1VEQ4a1lLbTB2Y1JEUVk3WE10UDdIanEzMnJ5cXF3RU12OVdI?=
 =?utf-8?B?RnErc21aRGIzMSt0Q3h4UnpsdGlTdk9yeXpvNnVaM0Q0M2l4aDU2LzVYMkZi?=
 =?utf-8?B?Tlk2NnVHUXVzcnZYQ25lZUlMdW45QzZmWVpZZ1JPRlRDSTE4czBUZllTbklz?=
 =?utf-8?B?TXN6bmt1VWVDYi9Ub216YlE4MGlMN2I5WG0vbXZaeG5zTVJ3VUFiTTc5d1Nr?=
 =?utf-8?B?Ly9nUG5DcWZKbm1EVVlXUjV5dm9UNTdaUzF5cGVNVGtDWCtleFF3R0dZN0NI?=
 =?utf-8?B?WHF6T3Q0dDdFV2liM0U5WTlYUWtBSUxSRDRPMHh4ekdORzhta3d2Q29Zdlo3?=
 =?utf-8?B?aXY5amxDQ2N2d3RGbGRqOGtIMHhzRUxEd0VxQjJhZ0srSDFrZ3JLbDIvODNV?=
 =?utf-8?B?WjdUMC9lOG9QblA5ZEwvcEFjekdrd3ZPci8xZzVESU0rb25HNGRTZkNYSk1P?=
 =?utf-8?B?cjJubHlwL3M3YXBCOHAwRyt4aUFRMEVBQ1ZzZWlSQkpjTlM1L2o4NVVKWSt5?=
 =?utf-8?B?aTgxY0xmcVFxMUc2Sk9HQ0w2ZlJrRmEvK3J4UDkzeU45dTN1eVI2cnJjYkxr?=
 =?utf-8?B?RVFWbzdnN0J6ZG95bUVta1g1eFA4d3U2TjBCVEdNK09rU2JDbmRxUU11R2x6?=
 =?utf-8?B?WEVHYmYyTHlBWVptb0FBYjAyTzd6UEZQRnBqaVRNYnpqMHh5YnBtdzV1cUJK?=
 =?utf-8?B?aElDNW9TaitzQytLTW1UQ1R0NE8rb1NlR1BIZnRTOFloUkE5SWVHbXFTRVRF?=
 =?utf-8?B?Nk1SYzhoS1lJWkdUNWlVR1RkbFhhTG00VFdmREhDRUN1SHNrQ3dtOE9kSS9w?=
 =?utf-8?B?UHFxbm9SOXI1Z3FiaUJFSlhscnY1NUx2d1N6aDZCNnN4aU8rekJ6KzhVMmov?=
 =?utf-8?B?cHVPTWlXaHBVcnRzNGUwTTlZNFc1K0ROVFkxZlJ2Nkc1WDU4cDJqK0s0VlRm?=
 =?utf-8?B?eFRlVURxWkp1N0k3TjlUelg0Nzk1MDBOaWptMnNVT2R6N3VNdGNuM1pyczlp?=
 =?utf-8?B?MEg4bFU4VFBvc25WZWRNdktvZW9DZ0drdFhlMTRVZzI4WHpnN3BtekZ5bGF5?=
 =?utf-8?B?aE1vS3NNTy9CY2pBNVV2NjFqa0diQkxsT2N5RDVnS0xZaW9nYXlQQU5IVmZy?=
 =?utf-8?B?T0dCalAwbG0rR2VHTFlYaHJ6Skh3ZXJqL3VTa3RrUWRZUTh6bStuNVJFT0lt?=
 =?utf-8?Q?GSu0Ue?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(10070799003)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?STdGOUpTR3dObnF0aTBsYWdmdi8waXFKZXJIRkE5SWUydGtydkFIVnRndzNT?=
 =?utf-8?B?R0tzMi9sN0VwMktxZW14WHFpb2JTR0ppeHFUNmhkYmxnTWQ4VHhqekh4NThG?=
 =?utf-8?B?V29wTU9pd0o2VkFIR1lLWFlJeHZONWx6YldqWkt6MXArdVRlbHdNK01ONGtX?=
 =?utf-8?B?Wk02ODhLb1J3Nk5IbFlaYnM2c2FkSy8wRTE4RWt3NWdJbTRka3E1UG5sK2NI?=
 =?utf-8?B?aXJzVmkyM1hhT0VDNVYrRzJPSkJqQWtyV1EySDlFVitQQllLNTlnWmtaQVRx?=
 =?utf-8?B?c2JkOUw0eERna1l3cWNqMWI4VEMyeGxlT0k3ZDhva0xrbDk5L2ROS1BLRWZt?=
 =?utf-8?B?b0N2eVJOT1Y2elQrNFpDNHdKRks1OXk2Ymk2Z3g0bEJmRDVFTnFiZ1l5bFA0?=
 =?utf-8?B?b3UwZWkyL1NRbmFXN3M1SEdXQVVEUmFaVGdXdG9OZDJMSEt2VTlvRW1tTXlE?=
 =?utf-8?B?QXN2Y2lpSllLdkVhdU1qbWpUbURvaEpLclVFU3g1MlJMZ1RVL3JSZXVldVp4?=
 =?utf-8?B?N0R2dVpvVDdsSXorNFZQaWdoa2xYZ284bkJLRC9INVdpUWpSM0UxUzU2M0Vu?=
 =?utf-8?B?UkZidXNwZUhEbE0wM1pVWjhvTi95SUZwMElvUmNxRmdXcFFFNGh3Sy9MUG9V?=
 =?utf-8?B?WHlNZ1IxcTBYS0FwU3VUMEFhUFRCSmt0MHB5M0JoRWduV1hiZEYydi9pWUpO?=
 =?utf-8?B?UXRJZHp5VklxV3VJMnY4QUplRUlBZzlETXA1cXl2MklldVRKb0ozZkRqdyts?=
 =?utf-8?B?N2gxZHhhNVQ4T2FCanpRTWV2b2YxVXdRQ3dYRm0wNzA5V3g0eWNPTW1nMVJR?=
 =?utf-8?B?R0t6UEhUd2FKYnRYMnVHMCsza2ZhMHlJK2V4TkxxdmtBTnBDMlEwZU8yeVJh?=
 =?utf-8?B?d3Znazdxd3lUeityR1krNHcxeW9iYVNZM1hFWmxKajBROG9BUG51OHB2cjlx?=
 =?utf-8?B?dzlsQ1ZCUTlsdm1NeTQwVXZUOW92eXdyK2FDOXNGcW93L0JkS3J5OWI1RmFO?=
 =?utf-8?B?VE1lSmFQZE56UDRLZnNSL0RYMDhxbzF6UnYraGwyL25qZ2JDZGg1SW9aOGxa?=
 =?utf-8?B?U3luNUkxTDkyWjlEcUZGdU1qUjZTWnkrcm1qNmV3K1o2R3VzeDNBN2MybGMy?=
 =?utf-8?B?dGNod2JUS2FWUEJjTVF3ZjdhWkx3Y1lmT3czVDZ4RTBlZ2pQaVl6YVBoSnlB?=
 =?utf-8?B?TGp0YjZKTjFvbFpOMUlROUtCMkRuMjJqQTVGYjRvY2ZuYzVlZmRGRU9XN0o2?=
 =?utf-8?B?aVdJT2dVWGFQOTBsaG9yNi9HeXdTWXJ3ajI4REc4Nmp6eTdNV0U5SCtTK3Rv?=
 =?utf-8?B?Y1lZRDdrUlQybnE0aU5KdmY5OHY2Z0VjMHlBTGppQ1AxQTBpUlF6THZXTnJw?=
 =?utf-8?B?WVA0QkY4SDY0VTFyS1ArbFE1cjg3V2llcEYwVHJ6SHFiR1B2c3VORE43eGN1?=
 =?utf-8?B?WWFEWmdjZU5ieU9vVlRncFViVHE1SmVKQmpSbjFPL0g3N3lBUWthUVJFV1pB?=
 =?utf-8?B?NU9VcEZTbmpkcXB0dFBDZjVjYnZBM0pQNERyZk9SbHluMTY1SGtETTRNSFRv?=
 =?utf-8?B?VVhJSExCbXVsL0VKRFJUdG5WaHNNTHNkaWxHd0c2Z2t5ZzllTmRZL2JVSkg0?=
 =?utf-8?B?T0FyT2t3RDJjUXZ3L1dnMS9hTi9aUHJ0RGJDNzNacWZSRGJ4aklCN3FnclVv?=
 =?utf-8?B?ODM1Z3ZnTmgrMUNQb1lVRW1XYkRNa1BCbnhsaWJoNWt5eFRxRU5wZ2V6UGlH?=
 =?utf-8?B?cDVPTXcybWdlaVFMeDI2cEI4SE8xN1ptKzlRQ2hhYmh6RmtxRE12NUZzWkN2?=
 =?utf-8?B?eWpQMGlKSGJsYWdZY1JEcHNqcE5rNmVLdkJYbnNKa2xydUNnZ3hFY3hya2Mz?=
 =?utf-8?B?SVhEb1UrUENUK0tjWkZVNHlYUVBwWjczTEdSN082MnRJSUcxeG5PbTg5a29U?=
 =?utf-8?B?WTZHVDBiTWhoVXJ5UVR3elZ3Uk5XcjRla2ZoSlZzdmtrSkJDbVZtV3NIK1RK?=
 =?utf-8?B?cEdBRVhneHY0WlByUTdjNGtkeUVJdU9pWWxQK0paeG5YczVncFpKYXluSW5V?=
 =?utf-8?B?THJ0VDZUODdXMDI2Sk4ydHhSanhSQ0tNdEMrYlRzeitTcFZoNEx3NFhCdEVT?=
 =?utf-8?B?VXY4N0QrUHlxNEN2czJjNWpXcDFqOU1VTi9yOTh0bjZnSXBaclNCUzRZUERk?=
 =?utf-8?Q?gvBVCkqi2ZyL1UbttJn2YNuQFAY7zzwI6OXu7trKFR7q?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E5207B3EF8B98C4DBF6ABF7A3A3F60FA@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9404.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6335510-16c7-4797-d951-08de1bff9cc2
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Nov 2025 00:09:39.3688
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YqEmCTV60DKJT0bntejmz9csJvOZrur0ReiQNPsWSP9+KwS91GR+mxpFDtQzsxB3sRaDk6w8XhOSx6Qo3owGYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB9544
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251104_160946_911252_01A99652 
X-CRM114-Status: GOOD (  14.67  )
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

Pj4NCj4+IEkvTyBwcm9jZXNzaW5nIHVzZXMgc2NhdHRlci1nYXRoZXIgaXRlcmF0aW9uIHNpbWls
YXIgdG8gZXhpc3RpbmcgDQo+PiBiYWNrZW5kcywNCj4+IHdpdGggcGVyLXBhZ2Ugb3BlcmF0aW9u
cyB0aGF0IGhhbmRsZSBhbGlnbm1lbnQgYW5kIGJvdW5kYXJ5IGNhc2VzLg0KPj4NCj4gUXVlc3Rp
b24gcmVtYWluczogd2h5Pw0KPiBXZSBhbHJlYWR5IGhhdmUgYXQgbGVhc3QgdHdvIG90aGVyIG1l
bW9yeS1iYWNrZWQgZGV2aWNlcyAoYnJkLCBudWxsX2JsaykNCj4gd2hpY2ggc2hvdWxkIGRvIHRo
ZSBqb2IganVzdCBuaWNlbHkuDQo+IFdoeSBkbyB3ZSBuZWVkIHRvIGFkZCBhbm90aGVyIG9uZT8N
Cj4NCj4gQ2hlZXJzLA0KPg0KPiBIYW5uZXMNCg0KDQpUaGFua3MgZm9yIGxvb2tpbmcgaW50byB0
aGlzLg0KDQpicmQgYW5kIG51bGxfYmxrIHJlcXVpcmUgZ29pbmcgdGhyb3VnaCBibG9jayBsYXll
cg0KKGJpby9yZXF1ZXN0IGFsbG9jYXRpb24pIHdoaWNoIGFkZHMgdW5uZWNlc3Nhcnkgb3Zlcmhl
YWQgZm9yIGVhY2ggSS9PIGFuZA0KZnVuZGFtZW50YWxseSBmb3JjZXMgYmxvY2sgbGF5ZXIgaW5m
cmEgdG8gYWNjZXNzIHBhZ2VzLiBUaGlzIGJsb2NrIGxheWVyDQppbmZyYSBpcyBhbHJlYWR5IHBy
b2Nlc3NlZCBJL09zIG9uIHRoZSBob3N0IHNpZGUgdGhhdCBhbHJlYWR5IHByb3ZpZGVzDQpibG9j
ayBkZXZpY2UgaW5mcmEgYW5kIGJsb2NrIGRldmljZSB2aWV3IHdpdGggbnZtZXQtbWVtLWJhY2tl
bmQuDQoNCjEuIEZ1bmRhbWVudGFsbHkgd3JvbmcgYWJzdHJhY3Rpb24gd2hlbiBhY2Nlc3Npbmcg
dGhlIG1lbW9yeSAocGFnZXMpIDotDQoqIE5WTWUgSG9zdCAtPiBGYWJyaWMgLT4gbnZtZXQgLT4g
YmxvY2sgbGF5ZXIgLT4gYnJkL251bGxfYmxrIC0+IG1lbW9yeQ0KICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgXg0KICAgICAgICAgICAgICAgICBVbm5lY2Vzc2FyeSBpbmZyYXN0
cnVjdHVyZSB0byBhY2Nlc3MgbWVtb3J5Lg0KKiBOVk1lIEhvc3QgLT4gRmFicmljIC0+IG52bWV0
IC0+IG1lbW9yeQ0KDQptYXkgSSBwbGVhc2Uga25vdyB3aGF0IGlzIHRoZSBhZHZhbnRhZ2UgdGhp
cyBpbnRlcm1lZGlhcnkgbGV2ZWwgd2hlcmUNCmFjY2Vzc2luZyB0aGUgcGFnZXMgaGFzIG5vIGNv
bmNlcHR1YWwgb2JsaWdhdGlvbiB0byBnbyB0aHJvdWdoIGJsb2NrIGxheWVyDQppbmZyYSwgdGhh
dCBpcyBmb3JjZWQgYnkgbnVsbF9ibGsgYW5kIGJyZCB1bmxpa2UgbnZtZXQtbWVtLWJhY2tlbmQg
Pw0KDQoyLiBVbm5lY2Vzc2FyeSBQcm9jZXNzaW5nIG92ZXJoZWFkOg0KDQotIGJpb19hbGxvYygp
ICsgbWVtcG9vbF9hbGxvYygpDQotIGJpb19hZGRfcGFnZSgpIGZvciBlYWNoIHBhZ2UNCi0gc3Vi
bWl0X2JpbygpIC0+IHN1Ym1pdF9iaW9fbm9hY2N0KCkNCi0gYmxrX21xX3N1Ym1pdF9iaW8oKQ0K
LSBSZXF1ZXN0IGFsbG9jYXRpb24gYW5kIFJlcXVlc3QgcXVldWUgcHJvY2Vzc2luZw0KLSBUYWcg
YWxsb2NhdGlvbg0KLSBQbHVnL3VucGx1ZyBoYW5kbGluZw0KLSBRdWV1ZSBsb2NrIGNvbnRlbnRp
b24NCi0gSS9PIHNjaGVkdWxlciBpbnZvY2F0aW9uIChub29wIHByb2Nlc3NpbmcpDQotIGJpb19m
b3JfZWFjaF9zZWdtZW50KCkgaXRlcmF0aW9uDQotIGJpb19lbmRpbygpICsgbWVtcG9vbF9mcmVl
KCkNCg0KIyBDb2RlIHBhdGg6IH4yNS0zMCBmdW5jdGlvbiBjYWxscw0KDQpFdmVuIGZvciBicmQg
YWx0aG91Z2ggaXQgZG9lc24ndCByZXF1aXJlIHJlcXVlc3QgYWxsb2NhdGlvbiB5b3Ugc3RpbGwg
bmVlZA0KdG8NCi0gYWxsb2NhdGUgdGhlIGJpbw0KLSBjb252ZXJ0IHRoZSBudm1ldC0+cmVxLT4g
c2dfbGlzdCBwYWdlcyB0byBiaW8gYnZlYw0KLSBhZ2FpbiBjb252ZXJ0IGl0IGJhY2sgdG8gYnJk
IHhhcnJheSBmcm9tIGJpby1idmVjDQotIHZpY2UgdmVyc2EgZm9yIGV2ZXJ5IHNpbmdsZSBJL08u
DQoNCm1heSBJIHBsZWFzZSBrbm93IHdoYXQgaXMgdGhlIGFkdmFudGFnZSBvZiB0aGlzIHVubmVj
ZXNzYXJ5IGNvbnZlcnNpb24gd2hlbg0KYWNjZXNzaW5nIHBhZ2VzIGNhbiBiZSBkb25lIGVmZmlj
aWVudGx5IHdpdGggbnZtZXQtbWVtLWJhY2tlbmQgPw0KDQpudm1ldC1tZW0gZGlyZWN0IHBhdGg6
DQogICAtIHN0cnVjdCBzZ19tYXBwaW5nX2l0ZXIgOiB+MTAwIGJ5dGVzIChzdGFjaywgcmV1c2Vk
IC0gemVybyBoZWFwKQ0KICAgLSBzZ19taXRlcl9zdGFydCgpIG9uIG52bWV0IHJlcXVlc3Qgc2ds
DQogICAtIGttYXBfbG9jYWxfcGFnZSgpIC0+IG1lbWNweSgpIC0+IGt1bm1hcF9sb2NhbCgpDQoN
CiMgQ29kZSBwYXRoOiB+OC0xMCBmdW5jdGlvbiBjYWxscw0KDQozLiBCbG9jayBsYXllciB1c2Fn
ZSBtb2RlbA0KDQpUaGUgYmxvY2sgbGF5ZXIgcHJvdmlkZXMgY3JpdGljYWwgZnVuY3Rpb25hbGl0
eSBmb3IgX3JlYWwgYmxvY2sgZGV2aWNlXzoNCi0gSS9PIHNjaGVkdWxpbmcgKGRlYWRsaW5lLCBt
cS1kZWFkbGluZSwgZXRjLikNCi0gUmVxdWVzdCBtZXJnaW5nDQotIFBhcnRpdGlvbmluZw0KLSBE
ZXZpY2UgcXVldWUgbGltaXRzDQotIFBsdWcvdW5wbHVnIGJhdGNoaW5nDQotIE11bHRpLXF1ZXVl
IGluZnJhc3RydWN0dXJlDQotIERldmljZSBhYnN0cmFjdGlvbg0KDQpGb3IgbWVtb3J5LWJhY2tl
ZCBudm1ldCBuYW1lc3BhY2VzLCBfbm9uZV8gb2YgdGhlc2UgYXBwbHk6DQotIE5vIHNjaGVkdWxp
bmcgbmVlZGVkIC0gbWVtb3J5IGhhcyBubyBzZWVrIHRpbWUgdG8gb3B0aW1pemUNCi0gTm8gbWVy
Z2luZyBuZWVkZWQgLSBubyBkZXZpY2UgdG8gYmF0Y2ggcmVxdWVzdHMgdG8NCi0gTm8gcGFydGl0
aW9ucyAtIG52bWV0IGV4cG9zZXMgbmFtZXNwYWNlcywgbm90IGJsb2NrIGRldmljZXMNCi0gTm8g
cXVldWUgbGltaXRzIC0gbWVtb3J5IGhhcyBubyBkZXZpY2Utc3BlY2lmaWMgY29uc3RyYWludHMN
Ci0gTm8gYmF0Y2hpbmcgbmVlZGVkIC0gY29tcGxldGlvbiBpcyBzeW5jaHJvbm91cw0KLSBObyBt
dWx0aS1xdWV1ZSBuZWVkZWQgLSBubyBoYXJkd2FyZSBxdWV1ZXMgdG8gZGlzdHJpYnV0ZSB0bw0K
LSBObyBhYnN0cmFjdGlvbiBuZWVkZWQgLSB3ZSBBUkUgdGhlIHN0b3JhZ2UgYmFjay1lbmQNCg0K
YW5kIHNvIGRvZXMgbGlzdCBvZiB0aGUgY2FsbHMgbWVudGlvbmVkIGluICMyIG5lZWRzIHRvIGdv
IGF3YXkuDQpFdmVyeSBiaW8vcmVxdWVzdCBhbGxvY2F0aW9uIGlzIHB1cmUgd2FzdGUgZm9yIHRo
aXMgdXNlIGNhc2UuDQoNCi1jaw0KDQoNCg==

