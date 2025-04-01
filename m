Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5440DC36010
	for <linux-nvme@archiver.kernel.org>; Tue,  1 Apr 2025 22:50:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:References:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=cHs5W9Agx7nnPQHFBLM0m8yp6t9xN8mS1lfVhguB2kw=; b=A+9aLCmiTfvOoO5G5SIeVHnF04
	fUeOpeabyCTVCc6eAqVVKCH7mcD/KijziHpXV3hxJa1DnVYnf+1ULn6yxun4IinWm5nsdZoxcE1X/
	Vk5ACCYeJBCUar/0/ZVk0l4MmmPJ6sFubWSXoPntLkhiPuV+XzXZlwl8/otj6KsqETSMLndK3HTY5
	wCTL68NgivgxwpQYyLyU6y8c1aFchmH+hDji69z3qb8yfGDHYDHqT0A7ik/x+VgT3Y3aLcEF/+JBl
	A2JF/E9bmKPRZunDhkNlGKHYGnCQa+k10qpWW1J3gimv6ayVOPDE99jpLn0S9rHtcwy3IqnIREtuB
	1NfgNvPg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.1 #2 (Red Hat Linux))
	id 1tzkRQ-00000004ZGv-3wiP;
	Tue, 01 Apr 2025 22:50:44 +0000
Received: from esa6.hgst.iphmx.com ([216.71.154.45])
	by bombadil.infradead.org with esmtps (Exim 4.98.1 #2 (Red Hat Linux))
	id 1tzkOL-00000004Yy6-1BBy
	for linux-nvme@lists.infradead.org;
	Tue, 01 Apr 2025 22:47:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1743547653; x=1775083653;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=4Wd4T3nw/dYnS1ErC9vXJdoMnro1bemZtWkZ470emnU=;
  b=WI9zDoh8eJKEbrQWQXRAadEdrzVFKzVuAddz3X9ZZZJpD7XLOIbJffDS
   TC3Z6CS3GIDU8yvQSSLpfL1JpkWmTSdismSOY0mUYaXfo6yKRXFxYbGMH
   hWroXkiYap+5K2KbHxU3DZucIaRrvmpXoV9Te++ZcI3L7+xEjRQuUa1U+
   aTPVjXb1qXZJkuDfqT0p6w02VsFE+9wN4OsqrAP3cc6YdIhltzTKuPCZE
   IUAaWaN1PJHmhhOOWwrK5shCD6Cq+6hZd352C4eSIOoaZgnAexWebHm2D
   pwhXp5KaD29O+tlFnIJ9mH9ehlUk22uodf3TuPJMHuB7lbDhLkaOU5+To
   w==;
X-CSE-ConnectionGUID: uXmKIBJgRgmH8xLEJlLTjQ==
X-CSE-MsgGUID: lNmiz+iFQ9ajIMmd7qgw2Q==
X-IronPort-AV: E=Sophos;i="6.14,294,1736784000"; 
   d="scan'208";a="70962284"
Received: from mail-mw2nam04lp2171.outbound.protection.outlook.com (HELO NAM04-MW2-obe.outbound.protection.outlook.com) ([104.47.73.171])
  by ob1.hgst.iphmx.com with ESMTP; 02 Apr 2025 06:47:31 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mweFsznCJs4/dp4pyvIgOh7d8kpxyUkcFUWK2SM9rSk3hKjN8CyKhYY0Mi1ahY/B7Ib/Ms2/zl4FMB5qZhSfgh9DWHeHs7eMBBaYz+q/AvKTAe8rD+kgfVz9XO2PqEEDHva90s2qCqj37rq3HIw6L2uFrUNVxlZ6MTRYzP14ycf1EBtjntG6xH4Jc7DMonuYSQQJzWr79i5onOzwYRaiqkv1ytKMeXDZX4qRrTUOv2bYaTk/3Q/m1WUvL+CL5sfRk2kxkUffMWYD+tSAenpr0ke7gU4dmi26VqFtdnM3laY9zV/QthgO4dr8um6TLOWU5/LqPohQpC17RprrSipdDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cHs5W9Agx7nnPQHFBLM0m8yp6t9xN8mS1lfVhguB2kw=;
 b=HAyV1fIA13ZeJYPZZatyKK+UHgcK0IiNoKh+QuR34xUl9AEJ6Krr9icy/1SVKUbTog5SlxkOpqjnubjKD+oYpzlqwaLj8lGfJqf6rEvyBYNd631U+J6lgb2VxDHOBRzGJqbpixk2qkqVgle6RVvWXEQf4xgJiAObs9pvlw15O6hxCVQyqHoGX3bZWptBqHV4DjvLCmEClp7tGw7jG/m6yqwlghToHIFJplSY4DMSri+MfbW9r8ss1Twp0JtQvXeBHp+QJcam5r9J+EiMI8nx2FhDOWzLdIt4J/q/uXGnnmpuCPvHfoE4xlYyPRdiw+XfOqohpItdLQyB5afimW5fbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cHs5W9Agx7nnPQHFBLM0m8yp6t9xN8mS1lfVhguB2kw=;
 b=gV5J08qbqlXiDbIlcz9vxQpSegSj8qyVUP/+JGc+uaMUqsqOzROZcYsFYWlXCkQC7REVNBMo4pSInU+fByt86QEy8zals/dyuUWcY9Sw7pIGZa6Rm0D7HkLUQ+oUWIuHegvP99mHVwls+e+nfKa2+qqWm/Pa0wTHplJg9Il2dhc=
Received: from MN2PR04MB6862.namprd04.prod.outlook.com (2603:10b6:208:1ed::18)
 by SA0PR04MB7404.namprd04.prod.outlook.com (2603:10b6:806:e9::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Tue, 1 Apr
 2025 22:47:29 +0000
Received: from MN2PR04MB6862.namprd04.prod.outlook.com
 ([fe80::67d7:8033:78e7:9eb8]) by MN2PR04MB6862.namprd04.prod.outlook.com
 ([fe80::67d7:8033:78e7:9eb8%4]) with mapi id 15.20.8534.043; Tue, 1 Apr 2025
 22:47:29 +0000
From: Kamaljit Singh <Kamaljit.Singh1@wdc.com>
To: Damien Le Moal <dlemoal@kernel.org>, "kbusch@kernel.org"
	<kbusch@kernel.org>, "axboe@kernel.dk" <axboe@kernel.dk>, hch <hch@lst.de>,
	"sagi@grimberg.me" <sagi@grimberg.me>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
CC: Niklas Cassel <cassel@kernel.org>
Subject: Re: [PATCH v1 1/1] nvme: add admin controller support. prohibit ioq
 creation for admin & disco ctrlrs
Thread-Topic: [PATCH v1 1/1] nvme: add admin controller support. prohibit ioq
 creation for admin & disco ctrlrs
Thread-Index: AQHboCmElT3ixkj0uEiWsWJv1g7nM7OJG8CAgARc5iCAAfUvCw==
Date: Tue, 1 Apr 2025 22:47:29 +0000
Message-ID: <MN2PR04MB68620030DBBDB25900DE3E82BCAC2@MN2PR04MB6862.namprd04.prod.outlook.com>
References: <20250328213640.798910-1-kamaljit.singh1@wdc.com>
 <20250328213640.798910-2-kamaljit.singh1@wdc.com>
 <ca53c3a8-8af2-4e34-b0e6-3571cbec4bee@kernel.org>
 <BY5PR04MB6849189D63EBB6EF4B66AD42BCAD2@BY5PR04MB6849.namprd04.prod.outlook.com>
In-Reply-To: <BY5PR04MB6849189D63EBB6EF4B66AD42BCAD2@BY5PR04MB6849.namprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR04MB6862:EE_|SA0PR04MB7404:EE_
x-ms-office365-filtering-correlation-id: 10a80a03-82f7-4c54-eb89-08dd716f2e91
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?Windows-1252?Q?AOUJyAnuHSpWCyquKH2ssZ+Q2rPaGekoGkh03PLWmWwfhE/hAZMsV08B?=
 =?Windows-1252?Q?9ir1GNw4hJe1DLUEcW4796TeTNn8C2oEeOcnmoZlROINAaV3R0PlIrko?=
 =?Windows-1252?Q?BgpgosNHm6rMNneWLB47lxldHoZSdmwlbf+q3Yo5ZVJW9PluosUVIYN0?=
 =?Windows-1252?Q?qYcT+a/LwtFgPrXtV8lFMlDphhUV/M6f7NRzDLIAAzLsuzU1v3wNgIrn?=
 =?Windows-1252?Q?woFAhR/qVCEN6wb0VPSuzukjjl922uUvPHcf8Cp+zMtqNKHkPSSyP91Z?=
 =?Windows-1252?Q?61jK/h/06hjx2qzqE74OgxEYbbPDv3cBeALMNAVYocGf8uGI0JEQH/GY?=
 =?Windows-1252?Q?iqdamMNEUwP1LhaNythWsmfB7TH3J1nRL1OxiHfgoeZk+ui0qPJZoIVQ?=
 =?Windows-1252?Q?5vxiKwyVFmjkl1IdzeMjUFVtjIBW1OxktxLEnYTsmyX+H0uxtGj28F/Q?=
 =?Windows-1252?Q?wA02G8rbbShZ4UYWdiU79Lux+/OFA9hiAH5WVrLwSka+C8dH2bRj9hSj?=
 =?Windows-1252?Q?WnRBWK7vNXYbAfpmSKng7XsGpXyKD9Y8QC/ZfHZo9dsHgMSeOzKVI7vV?=
 =?Windows-1252?Q?718mLlaDkEnWtvFinFRWmnMVmDbGS0w9Q7V40YWEhc9sndZl28Bn6FDD?=
 =?Windows-1252?Q?6qYP2XzNi0rRm4OXaJjsefTfniDcVa3Q09LIRXCTQSUjaX2T/fvPgJhI?=
 =?Windows-1252?Q?lkqq6tEe+JgW9dLQTHgLrdUclpXiAZ+l1qj1/sAbkGPcyR9ZH4dWf2En?=
 =?Windows-1252?Q?LG2vUNSWtn+VzW3ZRv7F4UR18c6pXaBmX2X8q4SS3o/ZM+81zoXbUQdH?=
 =?Windows-1252?Q?+ONbtaqd6BKIe2cgV7fPG/C4OEiC9KGbFCaP1qM+JBiiqH3G+BdtlYRS?=
 =?Windows-1252?Q?fO63iZO7DPdF0ct8TTlNGKRmBTrQNHktZ9uXnnj2AaErtFKf9WtSQLEX?=
 =?Windows-1252?Q?RN2UxRHtvRzmLJO/Ox0rjbZrbaGb879Z8xU8XEjiboJ8Nt3xKfvqTdq6?=
 =?Windows-1252?Q?s0TetRSHi8VkKyDKy86To2ZjxXyzgvKxaa0QL1UbtAm2T42Fh9Eyu6XT?=
 =?Windows-1252?Q?T4e3/4NwxKu2msRzR8KnCt7odiPr5ggU0QDzJY7JvC0WoOrAGM4Gahcx?=
 =?Windows-1252?Q?oIddjj+5TPE/4t3BUmE2KUXY0DRC19rV0FN9c2N+zZFcz4Vj7lHZFJ64?=
 =?Windows-1252?Q?i+RXr/x16mn4scKhNmbxHYU0T4tDgTjBj/KblNJfEhFigc/rbysG1hwV?=
 =?Windows-1252?Q?TZkhcec6CSizGp6xKJCywvCUSp1T0PohlPrkQ5yNHA7gJ8E4T+82s35D?=
 =?Windows-1252?Q?U0A/7pLLtqbfar39Wkfhp9AKlqI86rYCKt6FkBVZOYSBe7mHo/yx5yVm?=
 =?Windows-1252?Q?Y+mpUY0QpspWRFk4K8IYDe3FEKjx1OCn9ish6iXHTqvndUQutDaP2UUy?=
 =?Windows-1252?Q?Xzes6fGYR3x+AOwtvsg8jrL8eEXJzpJbgOvhKPtAOIb20NFpqCKjIcmR?=
 =?Windows-1252?Q?/AJKMvIRRAm2DeW//mqWNcBWdbtU4qYZUzog5OfhLenpfnfYXrEpLnCY?=
 =?Windows-1252?Q?EmHbrXYeQgbz/ra7?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR04MB6862.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?Windows-1252?Q?ZCwmkY/hFHFTOaN14MDnELrF3Ff7kRh/m8cMteC8sAQYX86y7Exm2vhz?=
 =?Windows-1252?Q?WzS6zr0vwCqXJEoXQA0GqPQKUMA2zDy3qL5PY/83RbkCCKXfPQYihgFE?=
 =?Windows-1252?Q?oazy6EPwRRKgCfBdlhFdaq+zF8mbXRLs4676qa7tYKhA+cNFv+tjntRj?=
 =?Windows-1252?Q?P6VmJ10PhZm7OJhW0OgWqGad5HErctHK/HzmqJyZBCNF24hdpFzMI67f?=
 =?Windows-1252?Q?B2kphtE2IDHMp/V6z19OlAdARRYi6PU5hFStydHSzwWF2yDXdF8eCRxe?=
 =?Windows-1252?Q?K15PJJbN6i5049+Z3afPzyR0EqhIEz5AektPI5cayXFBckzkU8BHpPk8?=
 =?Windows-1252?Q?nbcXfRU1XgCWvYTfg0ufAoYcP2ZhBpZFKtkPnvnT4smhWaBQ/TmLfTJm?=
 =?Windows-1252?Q?0C6+YGSzU6As2+oH2zEHmUlAeBhnXIUVzFRMWkUvueQeeO21v1lYUeZ5?=
 =?Windows-1252?Q?fxhbzhX47Nif+FbH7yAiFb8qgKmCtRJs7EE2T769GtCb1EIxs6tY98kS?=
 =?Windows-1252?Q?w1CaWLCi7qiVQGjaNQymrKykrokTZuon3+nAhRsu5qgMsJyaRFK8Yn6X?=
 =?Windows-1252?Q?Dr/dsXsbM0QWT8KTxuJXqEtiT311yZY1bPIomjY7iG5YHRXnDBaV6wDK?=
 =?Windows-1252?Q?yHGpDY8XYN5wP2LCOUJdoiscgd8DRA90oxiif5xVvt+MrJlhv0vgat+c?=
 =?Windows-1252?Q?r41AtOs32xC7UtPAdiLF/D8xsnsNQq/If/aSc/da5x4HyU3AowNWLRlP?=
 =?Windows-1252?Q?iDaVudhumZYYp6LPyVEu+R6I/x2JNnlxBuBDZh9DviLFgXjwdDpxQWME?=
 =?Windows-1252?Q?P2w+mxdt9Bv6nzzCjU67xRE99LdaNxalRUq4qSG2DlkuX1G0F9GfEbp5?=
 =?Windows-1252?Q?49nP7bvmilISlLn/b8+PH9PF+4olpV1bnMouHpFRRPpH0WzVzxZXoXZg?=
 =?Windows-1252?Q?SdWAtZ9bZLbAqTBAaG5yUjt7jn/OTDmCxkGoqad2u+T3kri1UWrYctcL?=
 =?Windows-1252?Q?LpdzEpzp/BcpiyO8OoPlhBCTDl80p904q4fXSZ2FAi0eUHwVnoffWT/N?=
 =?Windows-1252?Q?aAb88gMLPDwaz4zXTkWFJUmD+qx07jGm58G6k5yhpm4xuqGtZ1qxqLVf?=
 =?Windows-1252?Q?ZP9vkgDz0Y6QTqNIC9tnR2oFlaCPrAeTZiMUNrr6spePQbnua+NWUtXv?=
 =?Windows-1252?Q?idOl8EC9+g0k0+Fnlh1imRc3dejmL1qG2LniZEYdxeCRmIk5cNlzwcEx?=
 =?Windows-1252?Q?HESPV0px9Q/hnEM/8lLrcJwTO8y70V66Kav/5BxdULQJHSAA1hrP3/XB?=
 =?Windows-1252?Q?DrL7755toGyItGNFgTv6UsLhwZINwjD0SquhEC/4TiBm15GAHVgYUHgK?=
 =?Windows-1252?Q?Tq765CzKmRhqoY8vUhqXRCttVyV/RMIcxQ+ULScg5ncZcz3MMZShOb1t?=
 =?Windows-1252?Q?wyLPIlds1pW6h4F+ahW4rHCKqqO+q2ojMXv4eprdBSVnfuLr+xSaPMxD?=
 =?Windows-1252?Q?gJpkJY0+q2i39GOA90vFogMCVBCorb9jI+4PijZoznUJRcbRNwyATgOH?=
 =?Windows-1252?Q?GYRSQLFS2Li278B78+GXDiajq/KYdHi4/Wrldj2YyOkbunIDTsbFMgWw?=
 =?Windows-1252?Q?nWedYlNTrRUZHuu9oArmMO7hFGM2+TxmJ2GfHSL8QBT3cfogMHeWZHcQ?=
 =?Windows-1252?Q?zvZIooRCDfi2/LTyZNvpeaJo00z2LU0s?=
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: +WQOpQUXJcXVdhHrI1byhlD/idbcleB7PxLk/v60RRLDQX2VsxsKPLO6ydNTRl9rcEtv07kphCDCsAJr2KnbOWfwMWTtcktLOokm+WqcmxDT03clHuwnkFBWpbWYKYEDRvZ8dDqhnnUqjBXYAQiSRPqaf7zY574/TQ3MK3IWwiNkVrovAGnILnL8TErR2OgfAjZfxBjG9baQt2MINLKhlYzGPFNkzz+fugsTDHvOnQpiKg92f7ucTCaY0VdcDGCcd+7mTRL8fYNkVU4zQR6m+eHYOKQPAOlyFWapff4Oxd0T1Yk4ecWDldXypa2zcw9FspV8cmeCrwYFFUJSuS3CupD2cuXiZS5IAUPX9fwv1ZPRmFOeRlm0o1OhpWNZNrGeq/jksBqjqvNJYK7gAwdxD4C0iKKz4iaH6eqrKU+DplOfCf89ieySWTSTg/PUXBfLVFU+qtSObHwmVz6/5gIZkAtrmTRHM2GYVF6B7tUkB7jvFpK40QZTJvpfjt8q20gSAG/yF1s3j2TFp7f3ja4CLP/hJ9w2yrVUsHzevXPRG0JiAXxL9JpQnHCb8wtm8IcrSL9S65DW43IPYLbkNFuPjR0w5k1smJbwq7eeXq5w6NMY4OHwGN9r+4GE1JYIrIot
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR04MB6862.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10a80a03-82f7-4c54-eb89-08dd716f2e91
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Apr 2025 22:47:29.2770
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4g+jR5//apAwIBNMebrMRk6PG/LTLecDg/YmNBLOXdPJ4NPFO0b6RFDvfOnMwzw9UCX3cC+KoIi8/9K817QLQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR04MB7404
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250401_154733_422541_9CA36A6A 
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

Hi Damien,=0A=
 =0A=
On 2025/03/28 15:09, Damien Le Moal wrote:=0A=
>> Added capability to connect to an administrative controller by=0A=
> =0A=
>s/Added/Add=0A=
Done=0A=
 =0A=
>> preventing ioq creation for admin-controllers. Also prevent ioq creation=
=0A=
>> for discovery-controllers as the spec prohibits them.=0A=
 =0A=
>This second part should be a different (preparatory) patch.=0A=
I've separated it as its own patch. Sorry took a while to procure the setup=
=0A=
But I=92ve tested it now. Will share updated patch-set.=0A=
 =0A=
You were right, it is a pain using Outlook for kernel work :(=0A=
Vim to the rescue for now.=0A=
 =0A=
>> =0A=
>> * Added nvme_admin_ctrl() to check for an administrative controller=0A=
 =0A=
>s/Added/Add=0A=
>And this should be a different preparatory patch.=0A=
Sounds good.=0A=
 =0A=
>> =0A=
>> * Renamed nvme_discovery_ctrl() to nvmf_discovery_ctrl() as discovery is=
=0A=
>>   more relevant to fabrics=0A=
 =0A=
>I do not think that is necessary since this is testing the controller type=
,=0A=
>which may be limited to fabrics or not.=0A=
I undid that rename and moved the function as Niklas suggested, to core.c.=
=0A=
I tried moving nvme_discovery_ctrl(), nvme_admin_ctrl &=0A=
nvme_update_ctrl_queue_count() to host/nvme.h but couldn't since target/=0A=
passthru.c includes that host header & fails compilation.=0A=
 =0A=
To make it work that way we would have to include host/fabrics.h in target/=
=0A=
passthru.c but that's causing a lot of unresolved symbols and requires a=0A=
different/larger commit. Also, it may not even be desirable as it will furt=
her=0A=
pollute the target code with host specific header.  Please comment.=0A=
 =0A=
 =0A=
>> @@ -2863,13 +2858,19 @@ static int nvme_init_subsystem(struct nvme_ctrl =
*ctrl, struct nvme_id_ctrl *id)=0A=
>>       else=0A=
>>               subsys->subtype =3D NVME_NQN_NVME;=0A=
>> =0A=
>> -     if (nvme_discovery_ctrl(ctrl) && subsys->subtype !=3D NVME_NQN_DIS=
C) {=0A=
>> +     if (nvmf_discovery_ctrl(ctrl) && subsys->subtype !=3D NVME_NQN_DIS=
C) {=0A=
>>               dev_err(ctrl->device,=0A=
>>                       "Subsystem %s is not a discovery controller",=0A=
>>                       subsys->subnqn);=0A=
>>               kfree(subsys);=0A=
>>               return -EINVAL;=0A=
>>       }=0A=
>> +     if (nvme_admin_ctrl(ctrl)) {=0A=
>> +             dev_info(ctrl->device,=0A=
>> +                     "Subsystem %s is an administrative controller",=0A=
>> +                     subsys->subnqn);=0A=
>> +     }=0A=
 =0A=
>Is this really necessary ? In any case, please remove the curly brackets.=
=0A=
I've removed it. I had started off by adding a dev_err check similar to=0A=
the one for discovery ctrl above it but since there is no unique identifier=
=0A=
(like the SUBNQN or unique port) for an admin controller, I turned it into=
=0A=
a dev_info to at least announce the presence of an admin controller. Any=0A=
suggestions for error validation at init time?=0A=
 =0A=
 =0A=
>> diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c=0A=
>> index 299e3c19df9d..0f3150411bd5 100644=0A=
>> --- a/drivers/nvme/host/rdma.c=0A=
>> +++ b/drivers/nvme/host/rdma.c=0A=
>> @@ -1030,6 +1030,17 @@ static int nvme_rdma_setup_ctrl(struct nvme_rdma_=
ctrl *ctrl, bool new)=0A=
>>               goto destroy_admin;=0A=
>>       }=0A=
>> =0A=
>> +     /* An admin or discovery controller has one admin queue, but no I/=
O queues */=0A=
>> +     if (nvme_admin_ctrl(&ctrl->ctrl) || nvmf_discovery_ctrl(&ctrl->ctr=
l)) {=0A=
>> +             ctrl->ctrl.queue_count =3D 1;=0A=
>> +     } else if (ctrl->ctrl.queue_count < 2) {=0A=
>> +             /* I/O controller with no I/O queues is not allowed */=0A=
>> +             ret =3D -EOPNOTSUPP;=0A=
>> +             dev_err(ctrl->ctrl.device,=0A=
>> +                     "I/O controller doesn't allow zero I/O queues!\n")=
;=0A=
>> +             goto destroy_admin;=0A=
>> +     }=0A=
 =0A=
>This is identical to the change for tcp, so maybe make this a helper funct=
ion ?=0A=
I've converted it into nvme_update_ctrl_queue_count() and added it to host/=
nvme.h.=0A=
Will be in the next patch-set.=0A=
 =

