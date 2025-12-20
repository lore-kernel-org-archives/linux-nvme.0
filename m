Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E62E1D637B2
	for <linux-nvme@archiver.kernel.org>; Sat, 20 Dec 2025 05:15:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=XYaCqjZD5K+gUB2nKH7iBFQ3DZmC7gBlFWZL6mnwhz4=; b=LEaPtfS/1bHNchVzvrRS03nfjU
	bJwIvWEma0ZL/et3VzOrptBsBfR8ng29vzYkMQkEV154kE/Cj3BQ1/SK0s5RwpO/AkHAdlKfOK7Pa
	bdHvN7WGL6l8LzlcOpg4yz85NuCNOm/PmmU83g821j0oZPNIaR876BUEVkQemAnA6MoLt4mp0dLxO
	W9JDG6jsdPD5yF41EkKeOeuNt4APfgZtPZy6/w5+absVRuAItKH3vb4f14dmXmkCI/Pq6zYTM0WsA
	IY/cRLfwa4AHmi+jQTNHmIAuivbSuDK/zInFckk1uBdFsIuPKDzJQvEfOm9rqSkuEAe3JpfXo3BvF
	qEdEKSLg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vWpJ2-0000000BJb0-1ud0;
	Sat, 20 Dec 2025 05:15:04 +0000
Received: from esa6.hgst.iphmx.com ([216.71.154.45])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vWpIy-0000000BJaJ-2N1n
	for linux-nvme@lists.infradead.org;
	Sat, 20 Dec 2025 05:15:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1766207700; x=1797743700;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=XYaCqjZD5K+gUB2nKH7iBFQ3DZmC7gBlFWZL6mnwhz4=;
  b=X/9YD2YZ97Ol1y7azUNBzIrAqKap+XbaxJS02U78o8c13cNTYhS2abVy
   cn194pFN7/ZDeScTTRQ/5RXTBNFSqQTV0skKbEkCJXH/kHaITaV+NArFC
   SgZ5E3Vz59YkR6kpr4lsYRQMcRk1mh//JUrJpYus1TPXAYXCvU9QXXgN8
   3SgL200b389LPE1w1bdJ8tPxzT9M14nXg7vZuXBnwd8IQ9UB2pMWtDvb7
   EbFrfHcDG+4peJu6NwJOQa7ilD1xyu6N69vlW9BN2tB82KY4QG+bwj5a0
   BkrbkRo3rP3toHJ88y0KaVI7pT8y8M3kpM7a81XPXlnIE5DTZ0+a59jNC
   g==;
X-CSE-ConnectionGUID: 4r/e1temQrqDeGQBIZK1kg==
X-CSE-MsgGUID: fby4FrcVQ/uMlAtw82U/vw==
X-IronPort-AV: E=Sophos;i="6.21,162,1763395200"; 
   d="scan'208";a="136885587"
Received: from mail-westus2azon11010037.outbound.protection.outlook.com (HELO CO1PR03CU002.outbound.protection.outlook.com) ([52.101.46.37])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 20 Dec 2025 13:14:55 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G3tovtmOLDRwVxoT6/YL/hpQScbZssyCY6xwvA1ttEVWm4PJ49F/TFpDxlfihybojW43tZkqErU0r7l1F8fcwWH+eLe0oNy/Ocis3J71TD8p4TKPNFIvIT/qCDxvAXK7pwW1dhsG5EdIanimRfqvARGy30C0BE+mXW1mYc7nJ4sGigZJgKPfl7UCTxK/OkdNhxylh/Ki2nkLDxUwyiMUX2ACXQFWFCxHGIvRpy08sglc096YznFQSaCCbSBaNedUp3lDsoJ+JkOPp3/2sXwKb/kX57bRXgvcAfAjorkD/OzhpoUaPkMPpfkpXFwhiSR+Uz62az/VUdgxyksnMlXbwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XYaCqjZD5K+gUB2nKH7iBFQ3DZmC7gBlFWZL6mnwhz4=;
 b=j1+ZOPjbM+cERSeowZG2Pv0KlFsQuzisjcpRsvyiSJmpl33Zm2BJaYthC7XHoBo7TWc1c5CrWbn/tNCFsJ4fP/U5Y6TA37FOODX/zZh7dLuMvjbEyMtE9pGL4f2Q45lb5wWmM02la0AS1B8Q43AU2Li7o146e23srtnTYb0p78s8BjFMmzSrsqkA2uO6GUMBZWpbNv8Ied+40FbJ6i1E2Q00wDhwj54IjuViUr87e6Zzwymgw91TRCjFX6MUDAUJgQaBL1XSuoDC5yLQqBaqn98siYK9UmZYh6J+fm+vv7AFH+sjdv6JoFoN7GPYkSOCNnVa2doxEz/h9qZEZU0CLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XYaCqjZD5K+gUB2nKH7iBFQ3DZmC7gBlFWZL6mnwhz4=;
 b=EOlQUVtxq1X9wbHCfltO1jS1S3ZPaNbQU+GWJrvfuAJuOYZbNUKP6GGTdwkXHBLKt5W31g/cu+5UkmntlmcF2gEAZZ03QEMNN76LLg6mMTXc33koo31P2CHGFHwgJT0m5D4MPSQIT0ZruI8S/R8+5e61RxibiyvJZEWQRE7uBPI=
Received: from SN7PR04MB8532.namprd04.prod.outlook.com (2603:10b6:806:350::6)
 by MN2PR04MB6782.namprd04.prod.outlook.com (2603:10b6:208:1e6::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.9; Sat, 20 Dec
 2025 05:14:53 +0000
Received: from SN7PR04MB8532.namprd04.prod.outlook.com
 ([fe80::4e14:94e7:a9b3:a4d4]) by SN7PR04MB8532.namprd04.prod.outlook.com
 ([fe80::4e14:94e7:a9b3:a4d4%7]) with mapi id 15.20.9434.009; Sat, 20 Dec 2025
 05:14:53 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Justin Tee <justintee8345@gmail.com>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
	"nbd@other.debian.org" <nbd@other.debian.org>, "linux-rdma@vger.kernel.org"
	<linux-rdma@vger.kernel.org>
Subject: Re: blktests failures with v6.18 kernel
Thread-Topic: blktests failures with v6.18 kernel
Thread-Index: AQHccA1icz2NaPxW5kOnCnvXxnDCZbUnqRiAgAJV8oA=
Date: Sat, 20 Dec 2025 05:14:53 +0000
Message-ID: <811c51a1-8e10-45d1-b03d-21c5ff59cb8f@wdc.com>
References: <5b023828-b03d-4351-b6f0-e13d0df8c446@wdc.com>
 <CABPRKS-2zsAEjhsJX8aPjzud9LeOTCsF8WN=amSKpBzxxzJ-iQ@mail.gmail.com>
In-Reply-To: <CABPRKS-2zsAEjhsJX8aPjzud9LeOTCsF8WN=amSKpBzxxzJ-iQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR04MB8532:EE_|MN2PR04MB6782:EE_
x-ms-office365-filtering-correlation-id: 3920886b-4f74-417c-09ed-08de3f86b572
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|19092799006|1800799024|366016|38070700021|7053199007;
x-microsoft-antispam-message-info: =?utf-8?B?UkhXdzFsQUN1ODVWVHRCZVVLTit3d25Pa015ZXVZOHB3bjZMTnRmN1VXN25C?=
 =?utf-8?B?bkMxSDE5c0E5Z2p4WTB6SG1OWVBRMWRVUmtLczdUZVVqQ2VYcWR3RG1CQS9m?=
 =?utf-8?B?cDVicm5ZQlI5cVQ2QVZtelNyUklIdmVlWWlUQjdaWU1aZ2J5V3VOTDI4NVlC?=
 =?utf-8?B?bmJrd3RSaVArUE9TOVZUWU8zKzBselpzVUxISUZCSmI4YUZXd3FmQkluTEVL?=
 =?utf-8?B?WlNnVWVJZHByR1RURUhYZmZPeWgzSGJTOWpVVVVjK0liUDAreWxoQ3ZWTGJQ?=
 =?utf-8?B?SmV6NVBhTDh2VkNJRlVQM2xQYnhZNTZaOU1HcWcrZUEvN0dINHFuVXB5bHlo?=
 =?utf-8?B?M3o3MEE3d0t6WlVvTTE2MnV1cC9DcmJJL1kva3IxcDdreU9BMEswenpNakN6?=
 =?utf-8?B?WTFZb2UyOFZJTEVHVUxYcTJsSHhwbWV3UHMxQTRKQXhsOFBQck9xbDNhOTM0?=
 =?utf-8?B?NithWjh6ZWZNV3kwRGZMak8yTEhQYVA4SEo2aUlFUXpaYW51ZGdDRkRVd25h?=
 =?utf-8?B?dHRqZFhNYXJRWUVEWGZlNnJPVTU5Z3Nxa2hSV01QNDFIcC9CRm1kQUxnQjZM?=
 =?utf-8?B?Z3R1ZE90aElDT3ltRjNLM2o2eWMzQmJOZ29pdzU2U0ZZVThZdEowYVRZQ0xz?=
 =?utf-8?B?S1ljZk9SaU9MZVg1dWtBcSthanBxSWdOQURuZFBpT3lhelc2dVZxUm51cUE1?=
 =?utf-8?B?YkZvaTZ2ZjBpM0k3d2dyK1lrVDcybkM5emhsSzArTHJtMWpJcnUxanB1V2Rw?=
 =?utf-8?B?OWZNN1JmLzFSYmRrUUdsRm1nWWxFUGtZVGh4ZlozWCtKeUN6dDNUQVBaU01X?=
 =?utf-8?B?b1A3SGtDcDNHWS9pUjljSDJUZUI5ODJmVGxZQXRlQW5VaFRaNVlaL0tVNUNS?=
 =?utf-8?B?OFlkMEYzQVRMUUFoZmplOWs4UzF0cWNKSzErZEJLZURFM0FNRnN1WmNvaWlr?=
 =?utf-8?B?eE1ycG1vSlhkajRjYU5MWGdlT05nQ3FycGtiY21XcXdIdmNwVkdNQ2w4VEhN?=
 =?utf-8?B?U25reTA0RldoVUNWZlB5dE1ySVZDQWNwVTlzd1ZyM2JkcFpzR2tBNXVmWURO?=
 =?utf-8?B?ekQxeTVMemVpcVpyUW01SFBQSzVGSXp0TU9EakQ3WVpxYjhQSzd4N0lwUXJv?=
 =?utf-8?B?NHpjTW5GVWNsN0w4d3lkaC9wWEp1S094Mkw5djhaM2hUdnEwUHhraENYWSta?=
 =?utf-8?B?L2wzeVlCWW9ZQ1duWHFkN0NVVnFQaEJ6aGVpcFIzNE0vUmRkdUhqWWkyQ1k3?=
 =?utf-8?B?VXlnS3ZuYlFqOEtSUnJGUEU1Q24yR1M5MXJySU1YYUNCQmZwZFN2UHdDemUw?=
 =?utf-8?B?blgxcldEN0szZTY2dHA4SUxGZE5OMzNmSzNwSmNqdlJST3gzSjV0ZmY5MDFS?=
 =?utf-8?B?S3hPelljTGF1Y1UvRTNQRVZtUVJycUdnMDZuYTRHZGV5V0Y4WFJBQkpEeEJz?=
 =?utf-8?B?V0ZnVFZVRVdBMWlZVEV3VEZ4Yllva09RbTRBdVpadkdJdFNobWxTeXdaU0tL?=
 =?utf-8?B?cTdyTnBOQ3B5R3gwV05HVEpkdXR2L2lqREp4SzdmRnp5WklqSkRRT2Ntbjd4?=
 =?utf-8?B?eDNSQkEwWHpya2FoaVZUejZHQlRZNVVQUDdOQkFwaVduMTNtZUxkM3ZOdTEx?=
 =?utf-8?B?SFJGN1MzMUVubDVOOXBaa3lKQ1I2eDJUVmVkMmRQMUNEQ3Y2WDNsTTVESGhy?=
 =?utf-8?B?b3oxbjZGKzBudmJ1VjhPOHBXUmtLRHlJbHRZd0crRDhvMkRNbUpnOG5pQUNr?=
 =?utf-8?B?bmxVeFFvdXJ6UlA4b21ZTVVyZFVRa24wU0ZjZHFFRVBLQkhzdUdzajVHSFVG?=
 =?utf-8?B?QzVndGNOVy9VVTR5eG0xUUxPaWE4M1ozNDcxbmhzQ1RYOHZtV29kbCtlWVRO?=
 =?utf-8?B?TDlsNVJ6ejRoL2o5bUdPb2NsUlVYM1hHWC9ySVliQjV6dFlCc2ZrYXEweEZG?=
 =?utf-8?B?KzlocW5CM29WRkh1YXVZWUNmUEVacDNpQ3Uvcm1aU3dGc28yMDNlejFPb1Ri?=
 =?utf-8?B?djlnYUY5S1pyTTg2UVQ4R2ZvZEZUbXgxQUdtUks3Q21qMmdkbEplTDkzbGx3?=
 =?utf-8?B?NUVocDlCakFUY0E2U0h4ZWttakkxS0JjMmFQZz09?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR04MB8532.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(19092799006)(1800799024)(366016)(38070700021)(7053199007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cU52blAvUjdWL1MvWGcrOEdZVTdQUkZDTG1DdUpkZXJQY2JXdXR4cEZpRmJa?=
 =?utf-8?B?UVowakVqclFxU1BqWkNkZ3pnREN5elZlVWxTR0NLUUQ1V1RzMzhDbHVVSU14?=
 =?utf-8?B?WlhJc3ZCUGxkWFlRTkM4djVTQkNDWjJMVVIrYmtrenZWdHErRVFQam1qVXB5?=
 =?utf-8?B?cElBV2JrYVpkWTFSOUZlN2FJU0ZGcTlMbDVkTlJvSXp1WnRWYnYyYlViQkc4?=
 =?utf-8?B?TTlDMnlnaUJia2NlTUtBZWhuNWJqWjc3N0Z0cWRiVmdXMU1QTDNiSFA1Tisz?=
 =?utf-8?B?UG5JTmF2OTdkU0VmYTJiWnZMeHNFOUc4bmlzZHoyTFUwYTErTFA3V1RKRUtT?=
 =?utf-8?B?eXRCMGJuN3RXS292MTVoV3FyV045VVhUK1MyZXNobGQ3OFFyR0laNTVwQ2dZ?=
 =?utf-8?B?aUtSWWlwNWc5a0EzaDk3NU9MdzNUY2RYK3dsYm15QkwzVTRjZVJOTGNUL2Ez?=
 =?utf-8?B?MWh0MVBsSkhidlFCR0dYVzVZK1VpWU9OdzdqU29yNFF3cklwbFplbWg5Wk1N?=
 =?utf-8?B?bTZRdzVMQnJ4UGFjdnJUY0VnYVFOclJZNFIvRlJVL2xLN3k2blZCNCtVTWlU?=
 =?utf-8?B?M0FhQnhJYVZUM0NvUTVtQ1FOSFJvR2tjeVNqdVJxYllTRkpBRXh2UlZkZHI1?=
 =?utf-8?B?Rjl1WERwaG0zSGpCQmlsVVBHZnZxMzFRYmNZNGZ2Sm5ISExFeTdKWXBkK2kz?=
 =?utf-8?B?YW1KbTE2RHpkWllSejd1ZU5seTZZUzdla2lsd0YwRW5QQWZUaDNYZHl0d3NK?=
 =?utf-8?B?cHFpejQzQklXa0gwemFTdHA3R0dWSHRueTZMTzVSK0l0dXVKRHZBa0Y1LzJt?=
 =?utf-8?B?ZnVSbS9aZTkwUDdmMzlwZ3lPbkRNWXlHT05qQjFiV3JHeU1TdDUyN2lZanJH?=
 =?utf-8?B?VGZZOEZJTkJpdEtMcDRndHFHdHhxZmwwcWVCcFlDTmhnMy91RkJGb3pIWGIx?=
 =?utf-8?B?T2JqZVRvZ0JGeDRJZzhmb21ZYmpzU1FYdTRENUdzTXo3cStFejJaTmFZb3M0?=
 =?utf-8?B?U1Y3c3VUYkRVSzNxMzg3Z3E2dFoyYTdhekxZZDljdXl6MW0yTUlndFR6blFH?=
 =?utf-8?B?YlZhbHRGckZiVGFReEJOTUJ1NWhvRGhGSVpFYzM5Qyt5bCttRlQvZUIwQ0V0?=
 =?utf-8?B?Z2pLZi8vdlRORzI0aHFyVTA5NTRaYVU5aTRVZkwvV3I4WEdNNEtLb3ZSS1Ex?=
 =?utf-8?B?VEFMVGdXVzJvT3cyVm1RUVd3MTl4clYyWXNTc0E2N1NtWFluRDZvTUw2aXdR?=
 =?utf-8?B?ZEpwWFQ1bGRVaUpqNGd3TEN6TktWdFlSU2hqK3Qxb2NxVFgyNTI2d3Y2K3ZG?=
 =?utf-8?B?OVl6NjlYSVVzTDYza3RLOGdXUlFyWTlhR0dmRStxeEl5RXcxQzdWNnRKSi94?=
 =?utf-8?B?VXdBM2dTdG1jekpaM1hDbnJDU0lRMCtreDFGUXBSSHV2N0pvdzBOWXBlMFVI?=
 =?utf-8?B?V2JwektpSWdtdExDcFU5L1hxMWpaU0hTYWwxSE9hb2NPem5pWE1WcDhmQWU5?=
 =?utf-8?B?TVZEN3Q5ZklUUkRGOFhpM3ZJU0ZKd0pwZ29FYkRFWVh4ZDJUYjBzV3diMkZG?=
 =?utf-8?B?Q3NaWjF2VW91ZndwK01DL0hLOTZTSUdNdlhrUFhoQUdhVTFZN2lSbGRHSXMz?=
 =?utf-8?B?bHgzQ3lYZ1lQSXJIeTRERFNBaGMxU2l1Z0x3UTQvTmdjTHBNdmlienBCek1D?=
 =?utf-8?B?QkE1ZzNBMTdWaitYU0p3K3VzZHhXNVdZNmJFOWt0cUJ3bFo0cG05Z2twN3Q1?=
 =?utf-8?B?VGhkaEN1czVGK3BGME9mSXdEK0cxZWFZQVRBL05IUXRrL1V2cVpBVGl6V2hH?=
 =?utf-8?B?eEJDNVcyd3RhZHkyVVBGcXVWeEZiaUg5YmhOaWtrY3Y3Ti9wUE1vZE1QRkY4?=
 =?utf-8?B?aWFrZUFwaWhBbU1zUWlBblpiRXY4ejBueTBTbkE5a1I1T0daci8zNk5pSkZO?=
 =?utf-8?B?bDFlelU5NjdWL0FRY3MxRW83TGo1cElZN2hGL0dGYi94YUx6T0xDckYwRk52?=
 =?utf-8?B?MTAzeS9vcVpuMlRMRmlJcmVHNTdhQkpNT2NhQjNZd29TNVAxMnJqRTB6bnVZ?=
 =?utf-8?B?WmttaThjSWhZdGhXakc0WDdRa2tNU2lZaVo0NW9scktJOU5vNEFoMC9UU044?=
 =?utf-8?B?RXVCTk9XY1VnYzM4aEExNXBldzJwQ3dOcVNOclNDaE1vRFZCZDg4cTMrOGVW?=
 =?utf-8?B?cnA4ZFRBc2M3dU4xN2x3OVFhUUtIaHhSRHJPaEtTZ0xXNWZVSHFWRmFURUg1?=
 =?utf-8?B?UGNicWlaY2VXd1RlcUdCOHYzWjB5Rnh0RUhoVTRmYXd4Vkpxa0hjRjY4RGFv?=
 =?utf-8?B?eDRsV3QwL3pXVlBpYndodlpGelhDMWd2Rm5pY1BDU0s4WXJGekFlZVh0YUpI?=
 =?utf-8?Q?6FfrfAoQrpG5i0ZE=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D6B649A43D92F54B835474D51ED53502@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 6t7f2H7Viy9WTXpITwu3MrQycVpGpB5cOXvWHkpOcKVWH5V353KOdqmBmrUbu8LCdEnWBjbYkHCB/zH9MHbrkiDUf0LVevGOqJXScUAgohBVXU9zDlYS75NCzpSULWgPDjeSGYWLokLK9hux5Z4c9y/wR94pymVYEYqVchYGBk/kOzh8cICDzVQPWVjDtBzeZtd1HSByu0MeKKQJ2lxjihg3Jo365a1Eo5ZXv8HBdG5kCn+tb5SNR8jZukWfj4T/s+fLMeDzUcTNtT+HypLxRGZbaTwKlsQ83n1YqnzDWRSFuGH5dn7P8ekg00A00edC/RVxx6u4LDdLe08dj6Ydq2w9/A9C2wYhgcIihibuF4q5U8Pcc4XNVqjviqWBTOLcqllu1MYYCh8ZbWRx0+Rd0UolzFCNDTxB+C8mkonRr191282z++6I2fgFvh1aJqU63r8fZoVqshpYg8iI2n49L/mHMZ/R9hU+sLFWNx78kMfTUS+3bEM8+ALlLze/nDu3hD0jULerdTW31bbWWYths0jO/dxbyoUZMDs7vk+XoIFrMaNeGvRDxXhnxM19ZAfJFqkxnYwPWPPDzfsOHXexLXMuPy7ldxUC87lwqleNWfQITuly19ZCsETMAxG+SlJy
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR04MB8532.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3920886b-4f74-417c-09ed-08de3f86b572
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Dec 2025 05:14:53.5283
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cQW+pHTjcG7P0IEoqlEk0gsCz+k8JYLqyTz/iS6fzJ2fnRAB73ZEoI/6lfYuNabBIsH9DJ9VStqCyZblqWA8sKXt4OCKFqN5y7QNjJQbpb4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB6782
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251219_211500_674288_09A93CA0 
X-CRM114-Status: GOOD (  14.11  )
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

T24gMTIvMTkvMjUgMjozNiBBTSwgSnVzdGluIFRlZSB3cm90ZToNCj4gSGkgU2hpbmljaGlybywN
Cj4gDQo+PiBMaXN0IG9mIGZhaWx1cmVzDQo+PiA9PT09PT09PT09PT09PT09DQo+PiAjMjogbnZt
ZS8wNDEgKGZjIHRyYW5zcG9ydCkNCj4+DQo+PiAgICAgICBUaGUgdGVzdCBjYXNlIG52bWUvMDQx
IGZhaWxzIGZvciBmYyB0cmFuc3BvcnQuIFJlZmVyIHRvIHRoZSByZXBvcnQgZm9yIHRoZQ0KPj4g
ICAgICAgdjYuMTIga2VybmVsIFszXS4gRGFuaWVsIHBvc3RlZCB0aGUgZml4IHBhdGNoIHNlcmll
cyBbNF0uDQo+Pg0KPj4gICAgICAgWzNdIGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xpbnV4LW52
bWUvNmNyeWRrb2Rzeng1dnE0aWVveDNqanB3a3h0dTdtaGJvaHlweTI0YXdsbzV3N2Y0azZAdG8z
ZGNuZzI0cmQ0Lw0KPj4gICAgICAgWzRdIGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xpbnV4LW52
bWUvMjAyNTA4MjktbnZtZS1mYy1zeW5jLXYzLTAtZDY5Yzg3ZTYzYWVlQGtlcm5lbC5vcmcvDQo+
IA0KPiBUaGlzIGhhcyBiZWVuIGZpeGVkIGluIDYuMTkNCj4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5v
cmcvbGludXgtbnZtZS8yMDI1MTExNzE4NDM0My45NzYwNS0xLWp1c3RpbnRlZTgzNDVAZ21haWwu
Y29tLw0KPiANCj4gY29tbWl0IDEzOTg5MjA3ZWUyOSAodGFnOiBudm1lLTYuMTktMjAyNS0xMi0w
NCkgbnZtZS1mYWJyaWNzOiBhZGQNCj4gRU5PS0VZIHRvIG5vIHJldHJ5IGNyaXRlcmlhIGZvciBh
dXRoZW50aWNhdGlvbiBmYWlsdXJlcw0KDQpIaSBKdXN0aW4sIHRoYW5rIHlvdSB2ZXJ5IG11Y2gg
Zm9yIHRoZSBjbGFyaWZpY2F0aW9uIGFuZCB0aGUgZml4ISBJIGNvbmZpcm1lZA0KdGhhdCB0aGUg
ZmFpbHVyZSBnb2VzIGF3YXkgd2l0aCB2Ni4xOS1yYzEga2VybmVsLg0KDQo=

