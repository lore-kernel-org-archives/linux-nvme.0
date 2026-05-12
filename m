Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3C91CD343F
	for <linux-nvme@archiver.kernel.org>; Tue, 12 May 2026 23:36:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=x5g9oACRStYFOs/PrYE6WnCJNab/4MAZWIpE7fL9zpo=; b=D18UdM6C+LVp1g0TDNL2qMc2ho
	hmmFDm6NOiGbjWHuGf9JjLN8rSGsJPZqgWnlyl4SsyB9llxBkDKDyRppAP9honPjLVsO+BpYYg8V2
	koS9IVvAWY33Yq8szZ4L5sJOSrSe64a9tv4y2iraIw3uF8etyBHLFoPG+MlDMcs5t2ebn/MN2LahY
	ToFCpAuGpnrmtH+Uo1jDuy/cYgJdpKzGRlzl9LlNjbJpg/Z3ryqyxNjH7W6fpy6Nqvd+Rg84EF+AV
	/EiM0/k96xazOpaTyoATcMnlWbHrvi7tplfQwxgnm7afq9S27Xqw7cAVUNUXz8qX266YxKil2PCbK
	I5YBKrbQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wMweZ-00000000hyN-1epY;
	Tue, 12 May 2026 23:36:43 +0000
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wMweS-00000000hxh-1si7
	for linux-nvme@lists.infradead.org;
	Tue, 12 May 2026 23:36:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1778628996; x=1810164996;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=x5g9oACRStYFOs/PrYE6WnCJNab/4MAZWIpE7fL9zpo=;
  b=bTgCi3+oAVn1IH/wipthaRvYpu+it6VB0pM8fiqfMyXKokZMzIf+5ojD
   8cFKoReFo8C5D1LL1q0H0v+10CqHCz8YhzTwY8hlNn1EhZEztBkMb0pZR
   ah9k+ZtfiYSiYHgI0EwuHtoGqqV40fesW/7m4SxYJgcS2jLo9MO//39ap
   tgIpfneoSXhRzE0IDwIz1yvmHZwwJk4ecYPtGsRHLx3xQ2ykwvEl3wDFt
   YQjUe5c+zlYiAuZ3zAMN/SgoLAeR91VMLM0cLzlQxD9kD4YKOIZV9oGH2
   PnJPwyfNneKNe9v0e4C59TNBqPusJLGdQOlelIcsKyUD+59OaP60MkO3z
   w==;
X-CSE-ConnectionGUID: fyFECjFLT1W+AUJpZs7xdw==
X-CSE-MsgGUID: vqv8RK9cSDqTF9QwZtlh/w==
X-IronPort-AV: E=Sophos;i="6.23,231,1770566400"; 
   d="scan'208";a="145882498"
Received: from mail-southcentralusazon11013050.outbound.protection.outlook.com (HELO SA9PR02CU001.outbound.protection.outlook.com) ([40.93.196.50])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 13 May 2026 07:36:32 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uTjkJyytG6sEPO5vyQuyv8Q6pZCDjqkCOGx0KBqi6aIKfBjQ1dQFf02zTRLDAxoNIauQ4nxwFCTq3/g7JKJxCwxMdv88lUs+1ZukzK4umniHWSSF6xc/G63FcuiHW7lROEju6M894yhebgywFsdMeI5ZVwtYleV605mngk5dC8vgWycZwIxk8FvUJuY9HJbuq2Z3fifn3lIJdf0NbzM3xdzpUKSDQOCb6nvzzaDaxA2274qwN3kIiVemnnj9D/3nq1ghwXVypirNUvV+ks/MDVi0SrNytwCVWx6vNX8Xk+QASz/+9aAfrxE8Vt46mt8fHnoz8a+1W14zdfrRuY4nuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x5g9oACRStYFOs/PrYE6WnCJNab/4MAZWIpE7fL9zpo=;
 b=WbIe89ZTAUlYdmoAKB3sVD8Q6hqSnCnLlN2PyT7fIblMycbuljmXrjGCtz9MkDIUMlR53t0ClB0GvAWk7J5M6baIJi/gTowXvGaRsU3xbF+sx2nLSjTt8JHySpsONCWOGVeX9dTaB3lRJeb7OGkt9J4jf4g3qOPt5anmC5bJzgOUU9T4SBpSiAAJ2h73lXzqUUyTror4U852awcS/KnwCRCystIKP92O5psZmLNk808+EsdjHDBAq9a+rHinsimSEb8ImQOyd8hDKF2rfiL00vbd9jCcRGn89w47h+B73Lu+H+jqMEipLpUL/3a/U2CW5ArF3bY6j6/N/jVpHF2PsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x5g9oACRStYFOs/PrYE6WnCJNab/4MAZWIpE7fL9zpo=;
 b=RkCxca0EBmlL1VHMC3z15nRstvR5tC0YAAnrhas8NTZG2lIBT/J3QwbhztTPIXHZZTlBZfSNRHsyqMbVvqvjSoZe0OveDoFhXJKm2WMqd7XHPUYn/s4B3bWxteydJ1UYwx5d3grhR7Wmhc0GCubJ2izx/bLslz5pXIajVOD8MU8=
Received: from BY1PR04MB9561.namprd04.prod.outlook.com (2603:10b6:a03:5b6::11)
 by CO6PR04MB7858.namprd04.prod.outlook.com (2603:10b6:5:357::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Tue, 12 May
 2026 23:36:30 +0000
Received: from BY1PR04MB9561.namprd04.prod.outlook.com
 ([fe80::3869:e494:2fa8:9888]) by BY1PR04MB9561.namprd04.prod.outlook.com
 ([fe80::3869:e494:2fa8:9888%4]) with mapi id 15.20.9913.009; Tue, 12 May 2026
 23:36:30 +0000
From: Alistair Francis <Alistair.Francis@wdc.com>
To: "kbusch@kernel.org" <kbusch@kernel.org>, "hch@lst.de" <hch@lst.de>,
	"wilfred.opensource@gmail.com" <wilfred.opensource@gmail.com>,
	"axboe@kernel.dk" <axboe@kernel.dk>, "sagi@grimberg.me" <sagi@grimberg.me>
CC: Wilfred Mallawa <wilfred.mallawa@wdc.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>
Subject: Re: [PATCH v2] nvme/tcp: handle rejected keys for secure
 concatenation
Thread-Topic: [PATCH v2] nvme/tcp: handle rejected keys for secure
 concatenation
Thread-Index: AQHc4aCzCPIyd0ssuUicfsGSo4uGHrYLDQ6A
Date: Tue, 12 May 2026 23:36:30 +0000
Message-ID: <8c0fe38f094613d243810e95406631373f506642.camel@wdc.com>
References: <20260511234551.2925326-3-wilfred.opensource@gmail.com>
In-Reply-To: <20260511234551.2925326-3-wilfred.opensource@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.60.1 (by Flathub.org) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY1PR04MB9561:EE_|CO6PR04MB7858:EE_
x-ms-office365-filtering-correlation-id: 39cc8e73-9e74-47ca-5f54-08deb07f4b3a
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|10070799003|376014|19092799006|38070700021|11063799003|56012099003|22082099003|18002099003;
x-microsoft-antispam-message-info: YLX+ZoVc1Q77HYkO+UDao2Vb7J4aP+zTTc5dlg8wUZ2WKDLdYQf6X9oK6cdewhf9q0+ufMYqz22/uSyjf3k4SZxTe9efDNj4Y0MeYy+wMi8SXg/ukNYvNhieHM/cFwiaaLhqd3/c7kVH4zn23R8ULH6N5PrSGEP1qraSv++ohPn3tJis/KWgaQT9Jev40fhu4WJtapB9HokcMsn7/OTVCPeEijcidVVME3bT8RJiVk6Odw3XjpyihW9UnFSzwXJyHdv7g/5iTq38EeA/UAeG8Kets7jSeHaiPklZXhEYLjifRQQ+f15mXMylYw2FxDaFkOzuOsAwsUZIFhA89O94r21p9GGXlWJPCuILmSUrmMOvGlDJdfDKzg4SOYdn5OQRB6O4TbsMMwthRaNYl0MqQa+sQt0jS9mRPKxVlY62bKgk0gUv9YinkrR1ey6W+V2XIBd1z5kP2yt3wmwOcUZhlcXb25FdZXP+AjAnRsto9rpv+xUXYyAhxOFDy1frRuTGAaovSMnA8ps3nELeN/9oyfJRD5bGjLQrDfHYFGfb3CGDqu9X4ynC/KNeasOmDd/TAnADhhefGVmDyIH0ardWY0ByfcSGbsHEhnrkU0XTN9MIgrtGMV7FVe1nOjW5Epc3mObhFSeZwLKviSvNVi0+GUSK5/CnJsJv3bC+GvL6LXwVL7qF9/60Dzx0vcvmCzyXZEMyb/K/EpBS7QYeZObvmw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY1PR04MB9561.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(10070799003)(376014)(19092799006)(38070700021)(11063799003)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bDRnS0hkM2JSSGFwa3B4a3ZvV3lnSEU4SWNaZW5lNzNBYVVCaGJsdm54dnds?=
 =?utf-8?B?L3NFaWdmbGRMTUpwYlZPQVpONk5CclpMa2Rha0tXWElrWUxNc2JFQyt3c0Jm?=
 =?utf-8?B?SWJvTHg3YUVMTUJtTUN0RlpjOTB2bGR6NVptZXNZVUhDMjRndHVGaGE0RGp0?=
 =?utf-8?B?MHA5UEkxWWY0ZHdQSnhKS2JmQ1UvQzZEQWNXamVsYnk4ODZROHp5dkVwWGxL?=
 =?utf-8?B?V2JQejJwZUxnVGZpZ1RhZ0h6K1BxV0R0ODE2ekVDNVM3emZHbTA3M29Kbm1j?=
 =?utf-8?B?dG1Tc2VWWjkrWlRWdEZ6Q1Q2N0JOMUFtVnRSaDVQS2FTaWhLZ0l4NkU4cTZz?=
 =?utf-8?B?WWRMSkVXM2RmUExJL2VBUWc4MzcrZEN6NXV1bHpiNDhtZ3VveDdCNEFKMnMw?=
 =?utf-8?B?a0tQRXFwK0FPYmVYUFpLZG1JcnRWWldGT21ML1MxMFNKMldIMXNGbjJWbHJn?=
 =?utf-8?B?aXNrZERqWTdWdERNaUVBc1ExWXRHbkllZHVUd3N1clZ2eDRCeWxGem1aclho?=
 =?utf-8?B?bndxUzQ5NHB3TUFZS0lVN2U2SmQrbTNGQ0diYjZBYlUvWDAvbUNKNjdjOGdH?=
 =?utf-8?B?dWVHY2RQaG1OS3NIVGJtc0ljNlJBY2NsZ3dWMkZpY3pJeC9RdjRBVnNrVUIx?=
 =?utf-8?B?czZwRkVVMEVjK3JLQ3greXNWWUR0ZXZwSnBqcHJjNkhlZTZQR2lLc1Y3dDhV?=
 =?utf-8?B?Q2ZjWWNjZEZ5V0FWVm9MTEd4TFVDQnpjQ1RCSVRYbWhKb0pvQmRRNDFNaWJu?=
 =?utf-8?B?R0l0VGdNR3VPL3pKckN3VnkyZmtQTGVMSzJpYWkyam9TZytYMnU3c1BrZFhG?=
 =?utf-8?B?aU0wVGZHOGlnTS91Y0RKWWlPbkM5WXpxNHhOUUZwTEk4T2RlcVd4SGIwQnV6?=
 =?utf-8?B?czBIb3NQeTQ5ZXNUTHo0YXlaSityS3lSTGwvUlVrcm9waHRQY3FDMW1FcTNT?=
 =?utf-8?B?V2hWVXVQcTViZlVhWWliU1ZOZmVOZUl1RjJaaXYzc0wzQ0FsUXoxaGFKTnBr?=
 =?utf-8?B?QlhjQm9lekRmQmVLR2hrM2FwTUV6MnZSQ1psS0pDdEIvS2NvVFBmc2I4bWVG?=
 =?utf-8?B?cVN0ckJuWGZyb1FXWkJKc2pZTUZaVE93dEFRZitvR0V0QlJyT1hvVVoyV0lR?=
 =?utf-8?B?MTJtK25TYTIrS0hDUTRGZkR4Ty82TzdsYXZ5OWtDZ2x5cUZRRDF5d0pIL3Rk?=
 =?utf-8?B?QVozeUJxaXIwWFl6SHV0c3hlaGxyREpYSVIyUmVubWdRVDRZZlh5WU1PNGFq?=
 =?utf-8?B?M2Q5T0poVkk4KzBORnEzNXFVUG9GMVEyRjJHK2hKaGEzd3lZQkFyVUROaFYy?=
 =?utf-8?B?SlNrSklrT1Q5TnJjYjI4eEM5NldqdjF0clg5Qm9GWXErSmRFY2Q2RENyMUZU?=
 =?utf-8?B?Mlc3WFZidEdOTEdGcUJUQ0JhNEE1c3NaM21TSVZjOHAzalVsaDhLLzhuMXJX?=
 =?utf-8?B?U0NwaGs0UldHWDRkQmZZVVYwQTdTUU1NNk5kb0pOZlRDSStsMFNEMkNaaVhk?=
 =?utf-8?B?U3ZuYzZ6Z09Fb1R1UVI5bGdtT3JpZ3VlSXdpblVBMFU3bHVNZFdoMlh2NHdC?=
 =?utf-8?B?WVJTWm9xNFVmakVzNXQrWnJ0eFlIbWJwNi9nV3k4RDFndVZmb01uVGVRK2kv?=
 =?utf-8?B?dkl6SUVGaitFeTJkbmdVNXRLSDgyY0VaSnU1UkFuTExVdXlWRmI3YU5IWFNY?=
 =?utf-8?B?RXJWRStqem9iY1NiSjVFMnR0MFlZdm5mRWp0SmVwNEcxcEdVai9vV2FJckRI?=
 =?utf-8?B?WTR3K3NQNGlKQXRWVDlFZXZEM0IvUWpKdExGby9ETEY3aGhOS0llQWZySzE5?=
 =?utf-8?B?Q0pvVEZoU21WaDFXdFBscURwU0VnTDJJaFBNMWtiTTNGYzYvSEt3K24xbkJo?=
 =?utf-8?B?S2dDT2pPbU9vYzBLTUk2S1NtMUhZWnZGbGpFSzNEVEdINnBKOW44cE5SeW8w?=
 =?utf-8?B?OURIQTlBV1NTNWtQMGhhckJiNTQyQ2ZtZHc2N1VNcUhVRDlCMGFvdjlsNXgx?=
 =?utf-8?B?eml3bFBpbHM2ZUNWTTFWcmdxcG5tNTZiWGxWdzBoTDQwS0NxOSt0OHgyMFpK?=
 =?utf-8?B?V3R1cnJIbHVqWFhNWWlRMnYxR0Q4ZFBvcFIxaGt2QUFKRHNvQ29wOEpHTzNN?=
 =?utf-8?B?dUJ2c2xzRXZzOVBLbHZZMjREdCt3N1lDMEtHcnloMkpxMzRvK0I0VDM0RFBL?=
 =?utf-8?B?RERxZHRkZDlUeG94REdJR0JjYmEvQ0tvenlUMUNtVlpRbHJEcmN1YnVlUUdH?=
 =?utf-8?B?Yk56Y0VTajdCQnRLWld2bFJ2SVpLME1Ob2M3Z1ZiSUg0em4yNlRIdC9VR2FI?=
 =?utf-8?B?bm1SWVpkVnRYWjBJUFBtMVFTd251YkNoUTlFdmNreWI4Mm14Ym9GWm9zRE9F?=
 =?utf-8?Q?V4uqKeS63pj1n1O9vp5Kn68ubdYAGfOMWKmk73RhkKuUB?=
x-ms-exchange-antispam-messagedata-1: 9CckAgFvCSRRBnkcP5is1fOWofRs+7kk7no=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1155F26DEB943948A8E1377B43E68D14@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: ZkF6Wzafe3iuC5+Ahp4PQcIw3Swmg6CCptVKZmOjvzO+bGx8C9oAVmn7kdS/6BCD/izp2V0gITXiNoq5LYhHal/f3D27TcQXhYQ3W1prZJfOIeQZatckBtzgnlcYDZ+2Qx734hl6qTo6GcF2SxPihzPf/LjFEfbzO8wzo6Py+7Lfv766BRgKwwlvmrvKw9ycTMYmw6WKq7Ppif9nJduuzob2Gc3wTwX24gmV9hRO09XwxE6hDDq40RI01zUkgKbZgQEEb+Ht6HQ1kY9TDs7k03CGEGN1+QUygz6S7xkOnz6htGg9xUhHHi82bekg5t1bEO3zrS+Xle/phKHrzfvMMg==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: sBRac5UcERyhfuRYJtuJnXXFxMQ5jxWNwlLhSih1kYTDXMB/LD2LowO7BHTWPPM161xEUp3dr9plzPX35PNJllKp4NzBZAretNbiK8nIMd005DG589pQX5DrYxCqoVitRGma8kOqKKD6LenbnL7lTPZ2w0XqN0M7mKh5SYEzVGIN3CTIBlIrkI9McjYsSseW9cmOC6xCA23Epat0ji7HgBH63ig++/REQ+LBWPuOVz6XnIZAU8spfsCoT4iLqubz4oomUFS4tk3yu7GsqPqt1P5cuDBTRacoYeH/n1vcHNnNGPfkN6uaajl2ZPYUKLLsU62xV7EfYLbTtB93De5da5WsqPjNOyEzV5rb+HMvopsQ3nEaMDMez2x57BUiomgB1hOcIuzxvdb2ftwbGSCffCX3WRdbkHs70rbCSaviKbZf7Wh1NjOXqpAb/gPOWk8f/6qlBJT4FtuZAg0J0iPyxUjGG3Zb5kxfIKn1TNOfEvPBZ10BmKl62v8WLpPYbRJ47TeEiP4tlog7fEtUtTOBzqBiVB1jrc10NVQf3Y11d5Tf+XR6uPJpO6jtwluK18KoI8Y66ObW+OsRIk+h6hOc57LcZaarpg0Gc7rwLIEAsAbUT4vmXvFHMst4yxwuxTPt
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY1PR04MB9561.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39cc8e73-9e74-47ca-5f54-08deb07f4b3a
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 May 2026 23:36:30.2144
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZgK8XwGgGdNH3+AscwWZb/RkUf9xYk2C/TYZ2b6qVu+cCtM6tP7yHXR1uiWQUN8110/SU47BfD2HuovzpetMHD9qGYNhIaWD8SK20avRJFg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR04MB7858
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260512_163636_507666_4D00EFBA 
X-CRM114-Status: GOOD (  30.50  )
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

T24gVHVlLCAyMDI2LTA1LTEyIGF0IDA5OjQ1ICsxMDAwLCBXaWxmcmVkIE1hbGxhd2Egd3JvdGU6
DQo+IEZyb206IFdpbGZyZWQgTWFsbGF3YSA8d2lsZnJlZC5tYWxsYXdhQHdkYy5jb20+DQo+IA0K
PiBUaGUgTlZNZS1UQ1Agc3BlY2lmaWNhdGlvbiBbMV0gc3RhdGVzIHRoYXQgaWYgdGhlIFBTSyBy
ZXRhaW5lZCBvcg0KPiBnZW5lcmF0ZWQgaXMgbm90IGF2YWlsYWJsZSBvbiB0aGUgc3Vic3lzdGVt
LCB0aGUgVExTIDEuMyBoYW5kc2hha2UNCj4gc2hhbGwNCj4gYmUgYWJvcnRlZCB3aXRoIGFuIHVu
a25vd25fcHNrX2lkZW50aXR5IGFsZXJ0IGFuZCB0aGUgY29ubmVjdGlvbiBiZQ0KPiBjbG9zZWQu
DQo+IA0KPiBDdXJyZW50bHksIHdoZW4gYW4gdW5rbm93bl9wc2tfaWRlbnRpdHkgYWxlcnQgaXMg
c2VudCBmcm9tIGFuDQo+IGVuZHBvaW50LA0KPiB0bHNoZCByZXR1cm5zIEVBQ0NFUyBhcyB0aGUg
VExTIGVycm9yLiBPbiBzdWJzZXF1ZW50IHJlY29ubmVjdGlvbg0KPiBhdHRlbXB0cywgd2UgZmFp
bCB3aXRoIHRoZSBzYW1lIGVycm9yIGJlY2F1c2Ugd2Uga2VlcCBhdHRlbXB0aW5nIHRvDQo+IGNv
bm5lY3Qgd2l0aCBhIHN0YWxlIGtleS4gVGhpcyBtYXkgb2NjdXIgaWYgdGhlIGVuZHBvaW50IGV4
cGVyaWVuY2VkDQo+IGENCj4gZnVsbCByZXNldCBhbmQgbG9zdCBpdHMgUFNLLg0KPiANCj4gV2l0
aCBzdXBwb3J0IGluIHRsc2hkIHRvIHJldHVybiAtRUtFWVJFSkVDVEVEIHdoZW4gYW4NCj4gdW5r
bm93bl9wc2tfaWRlbnRpdHkNCj4gYWxlcnQgaXMgcmVjZWl2ZWQgWzJdLCB0aGUga2VybmVsIGNh
biBub3cgZGV0ZWN0IHRoaXMgY29uZGl0aW9uIGFuZA0KPiByZXZva2UNCj4gdGhlIGN1cnJlbnQg
dGxzX2tleS4gVGhpcyBhbGxvd3MgdGhlIHN1YnNlcXVlbnQgcmVjb25uZWN0IHRvIHBlcmZvcm0N
Cj4gcmUtYXV0aGVudGljYXRpb24gdmlhIERIQ0hBUCB0byBnZW5lcmF0ZSBhIGZyZXNoIFBTSy4N
Cj4gDQo+IFsxXQ0KPiBodHRwczovL252bWV4cHJlc3Mub3JnL3dwLWNvbnRlbnQvdXBsb2Fkcy9O
Vk0tRXhwcmVzcy1UQ1AtVHJhbnNwb3J0LVNwZWNpZmljYXRpb24tUmV2aXNpb24tMS4xLTIwMjQu
MDguMDUtUmF0aWZpZWQucGRmDQo+IFsyXSBodHRwczovL2dpdGh1Yi5jb20vb3JhY2xlL2t0bHMt
dXRpbHMvcHVsbC8xNDkNCj4gDQo+IFNpZ25lZC1vZmYtYnk6IFdpbGZyZWQgTWFsbGF3YSA8d2ls
ZnJlZC5tYWxsYXdhQHdkYy5jb20+DQoNClJldmlld2VkLWJ5OiBBbGlzdGFpciBGcmFuY2lzIDxh
bGlzdGFpci5mcmFuY2lzQHdkYy5jb20+DQoNCkFsaXN0YWlyDQoNCj4gLS0tDQo+IFYxIC0+IFYy
Og0KPiAJLSBUeXBvIGluIGNvbW1pdCBtZXNzYWdlDQo+IAktIFJlLXdvcmRlZCB0aGUgY29tbWVu
dCBpbiBjb2RlDQo+IAktIEFkZGVkIHJlZmVyZW5jZSB0byBrdGxzLXV0aWxzIFBSIChtZXJnZWQp
IGZvciB1c2Vyc3BhY2UNCj4gY2hhbmdlcw0KPiAtLS0NCj4gwqBkcml2ZXJzL252bWUvaG9zdC90
Y3AuYyB8IDExICsrKysrKysrKysrDQo+IMKgMSBmaWxlIGNoYW5nZWQsIDExIGluc2VydGlvbnMo
KykNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL252bWUvaG9zdC90Y3AuYyBiL2RyaXZlcnMv
bnZtZS9ob3N0L3RjcC5jDQo+IGluZGV4IDE1ZDM2ZDZhNzI4ZS4uOGU1NDIxZDJlOGI5IDEwMDY0
NA0KPiAtLS0gYS9kcml2ZXJzL252bWUvaG9zdC90Y3AuYw0KPiArKysgYi9kcml2ZXJzL252bWUv
aG9zdC90Y3AuYw0KPiBAQCAtMTc2Nyw2ICsxNzY3LDE3IEBAIHN0YXRpYyBpbnQgbnZtZV90Y3Bf
c3RhcnRfdGxzKHN0cnVjdCBudm1lX2N0cmwNCj4gKm5jdHJsLA0KPiDCoAkJCWRldl9lcnIobmN0
cmwtPmRldmljZSwNCj4gwqAJCQkJInF1ZXVlICVkOiBUTFMgaGFuZHNoYWtlIGNvbXBsZXRlLA0K
PiBlcnJvciAlZFxuIiwNCj4gwqAJCQkJcWlkLCBxdWV1ZS0+dGxzX2Vycik7DQo+ICsNCj4gKwkJ
CS8qDQo+ICsJCQkgKiBJZiB0aGUga2V5IGlzIHN0YWxlLCByZXZva2UgaXQgc3VjaCB0aGF0DQo+
IG9uIGENCj4gKwkJCSAqIHN1YnNlcXVlbnQgcmVjb25uZWN0LCB3ZSB3aWxsIGdlbmVyYXRlIGEN
Cj4gbmV3IFBTSy4NCj4gKwkJCSAqLw0KPiArCQkJaWYgKHF1ZXVlLT50bHNfZXJyID09IEVLRVlS
RUpFQ1RFRCAmJiBxaWQgPT0NCj4gMCAmJg0KPiArCQkJwqDCoMKgIG5jdHJsLT5vcHRzLT5jb25j
YXQgJiYgbmN0cmwtPm9wdHMtDQo+ID50bHNfa2V5KSB7DQo+ICsJCQkJbnZtZV9hdXRoX3Jldm9r
ZV90bHNfa2V5KG5jdHJsKTsNCj4gKwkJCQlkZXZfd2FybihuY3RybC0+ZGV2aWNlLA0KPiArCQkJ
CQkgInFpZCAwOiByZXZva2luZyBzdGFsZQ0KPiBrZXlcbiIpOw0KPiArCQkJfQ0KPiDCoAkJfSBl
bHNlIHsNCj4gwqAJCQlkZXZfZGJnKG5jdHJsLT5kZXZpY2UsDQo+IMKgCQkJCSJxdWV1ZSAlZDog
VExTIGhhbmRzaGFrZQ0KPiBjb21wbGV0ZVxuIiwgcWlkKTsNCg==

