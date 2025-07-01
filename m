Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35E7CC7EE30
	for <linux-nvme@archiver.kernel.org>; Tue,  1 Jul 2025 07:55:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Cc:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=EJkQgEX3b2/HXCrpHjYR7PZgHAJmMdc8v9q9axY1C0g=; b=rtWYa9rfFoSHRAy2/bTWzecse5
	jBpUd0NG4iB6I4tbNQh6WH8NCkZ0vk8kWyVLfV6mY6rOLKTfMONw1VVNTP+6V7A0oB0TWZ559DBDV
	N9f3LT/IM1mRT6sN8GG0bmAkLqn4T1jjPHps6KHNYhPSiVDpFZl3DnBtt+oy3zw3MRRcu/v1UIRa6
	7j9OsA2czptJ/R9ybQ04Qf/9f7Cdib8Gt4r5iKCVMXed8Anb4AYqRGvFJaUV/nBF8iKSZmGI4rS9I
	cwNCbIEbemEXN5lb76Ujqw00W7UornPqQ9ZCIBPzTG/0JRKISIYVzD1bOCOsUlY/E5GTZJFn1PzBf
	zPDz/AWg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uWVpl-00000004LB4-1ypf;
	Tue, 01 Jul 2025 07:55:17 +0000
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uWVbI-00000004I8b-1U59
	for linux-nvme@lists.infradead.org;
	Tue, 01 Jul 2025 07:40:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1751355620; x=1782891620;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=EJkQgEX3b2/HXCrpHjYR7PZgHAJmMdc8v9q9axY1C0g=;
  b=mquJAiPIRVgVX7gz4gR0XM7evY4FcRdhdtNYKPPTP/ha6aRK6kCLGP4g
   alaLO+6So0L7OTzLYvc/wY7CU4WmkNCbbfpIF6rAgL8q5wSgcxnaj1RRD
   E+eKyVvkSevvaigAImc09OA+WkvfJ7tZl/kwj8ctX0M4CtMB0u0l+lQtN
   b7Dxgi6rAawXtC1/UxuzE6kUA/AGOMyPR7WZc/RsR8Yp/KXgtBDb1ldtU
   pZfS0TISL39/kr1TfpymJyJ9OXQMhdLOfrgOWwqcYOwQKO8i/49eYFjiV
   bI3Bij2XiVlnr6iECh4wfdQCIC93LC8Ovtgs3eXMK2PVAhCIpT26Nzwcv
   g==;
X-CSE-ConnectionGUID: 1iwNpe8ERD26y68Y4XRg8A==
X-CSE-MsgGUID: zijQ572fSAe8nlY6hHcPUg==
X-IronPort-AV: E=Sophos;i="6.16,279,1744041600"; 
   d="scan'208";a="85553351"
Received: from mail-mw2nam10on2061.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([40.107.94.61])
  by ob1.hgst.iphmx.com with ESMTP; 01 Jul 2025 15:40:18 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Pk4qXMJXcLKkaD9onpwOVfbzmg99o8ySGYxhHhwnk2iyNPtv9/0RsGFSbq7Fr74+dvOMkxHCaVcAEOg1BJfuzzaWhne70ZjYw4LgotdA4JMt/b6xqY4dAoCQkV7//qN2CD3oQElbFJAoi8b/10gDUuQB2+FzW498mnQQdK0A+KWEyQ5opTobuuc6mB/+OZO2/UxiQEQ9Fo8RIswrt0nO0rIBKgG3SUU25OHEK/BtuqcBmkABlR0IsPiJ9AEMWfwsoq40xnkfgn/sgfJI4L+XfeBeDnGIwTkg33S8dTTg7FDz/uiNZNdcJNEAFyVHAyD769IysunVXdlJjwxUAaoQ/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EJkQgEX3b2/HXCrpHjYR7PZgHAJmMdc8v9q9axY1C0g=;
 b=NaiLNilJawW5l4G1xjBkLxmipBBpqLNmQBOoiTgSOSzmDuXEIq7nzzhk+YQmW6onYJ27Fmd2aBhY/Q1FQLm4a/IVTShDDQ42v/Pyg2u0mxzXnrUXLu5VbJLT+uxqOzR+eiMyh+Zxvo4qhfr9BEpnbqdG+mls6ZVG8ehcQ7zCOiPi2jQJM+3r66lSCT2qHtZjrfD8j1V6/+DT0ZNtJEnKdedz44DNfoxjuo63x4Lg9DgOgLLpkGB5KxSiXIc5RbKniWhczaLgHMcZAe3WriEEdlrYklRcw/vavqZ0fxYzVcBACdL/gqhjVgAYyVzYAflYUKF1pfpjm/NxM+87WuTaMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EJkQgEX3b2/HXCrpHjYR7PZgHAJmMdc8v9q9axY1C0g=;
 b=nFu6s3ttv1hROwDjBAxpPYNZEy4nN3O1zwFY72MZMRBt26KVTPKfRrUOtrYeBlxxjrlgWICuMoyQMbi0dv9oStD3JFA+jsiGLyzsOojZHyuLT0CIOADtvw6LFH/Vw7bBbNIPHC4GxMH2/xqA0FLkrkMPjweGQSyOd+Y+iKJJRW0=
Received: from SN7PR04MB8532.namprd04.prod.outlook.com (2603:10b6:806:350::6)
 by SA3PR04MB8748.namprd04.prod.outlook.com (2603:10b6:806:2f4::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.25; Tue, 1 Jul
 2025 07:40:17 +0000
Received: from SN7PR04MB8532.namprd04.prod.outlook.com
 ([fe80::4e14:94e7:a9b3:a4d4]) by SN7PR04MB8532.namprd04.prod.outlook.com
 ([fe80::4e14:94e7:a9b3:a4d4%5]) with mapi id 15.20.8880.021; Tue, 1 Jul 2025
 07:40:17 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH blktests 0/2] nvme: avoid failures of TEST_DEV with
 metadata
Thread-Topic: [PATCH blktests 0/2] nvme: avoid failures of TEST_DEV with
 metadata
Thread-Index: AQHb5cac4NAnmqFLcESIh1Wubf+4GLQc6zgA
Date: Tue, 1 Jul 2025 07:40:16 +0000
Message-ID: <352ep4nwdg4bhkidlh3vvvgata7vclo5sptowk5r6nr5onhjls@qmyonut7ukro>
References: <20250625114505.532610-1-shinichiro.kawasaki@wdc.com>
In-Reply-To: <20250625114505.532610-1-shinichiro.kawasaki@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR04MB8532:EE_|SA3PR04MB8748:EE_
x-ms-office365-filtering-correlation-id: ff7eac9f-90d2-4a53-328b-08ddb87285fc
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|19092799006|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?Lb8G2HrBaLvN7adK9EcZ1JRNM+EzfjQpxmQm25nmcE2L3VNdV16Cop08Tb4o?=
 =?us-ascii?Q?ZjV/g3/vLRtBQXuhHMSW9SnwfDB8xJa/UbSnONtUqs9nB3W0Ozosn3i0R8zd?=
 =?us-ascii?Q?byh7uw3SrYdeUow6ZzRbFdiIrp1vruULeg2WhXLVX8dlOWHi+x2kHpOjrDvw?=
 =?us-ascii?Q?QEZQJtwSLeXn49Bk71MGZPAvZm51nb/3OljQ4Y7jv6kCascfSD8A1irSStPK?=
 =?us-ascii?Q?whr+OPg1AwTzCSXZYrL+IxXn2V0gZDgidCiDPa0yLRit5ODHpmLGxOPYCiLD?=
 =?us-ascii?Q?H2sqK7xtwL0lZtTT/yRuSIWYLB8xY5Fa8zXmcWRuCVRytW+B4mVdkFcpaZb/?=
 =?us-ascii?Q?p0+M7HbzKvycSQ1lesD8pJ5RehOcFVCiPYcdSsQ9dbsPJB25HaO8Y8SaOzzQ?=
 =?us-ascii?Q?3pKK+GmR8mfXJKc7Rj864Js6Hs6S4JTVHDMnS12e8W572SBERo2FygDc9LY2?=
 =?us-ascii?Q?gL3/khgWA9Qyr4d9KRFpdA1fIjkb8HNFuumByrXfc5JRPdyKexEc4DH8vma7?=
 =?us-ascii?Q?KrVE2o3eHhy2V9sn1//lde8cdI5NEhbt6yK0Pt2DYM+oL50/+pc93jpWPH3i?=
 =?us-ascii?Q?ruh4vTvADETtgyjL6C8mKHdYGl/NvmnWSXe7MJ/oxUGLlg3mwCVKscYghtdE?=
 =?us-ascii?Q?7IQKg8q2XliFzr0Fs0DrK8dvmT/qG5F6cuufm1fpJVr1Sg+T2QLZJElNs5NX?=
 =?us-ascii?Q?3puW2e9Xmu29JNw4FnyhrhS8r15bYnqE4qu/24kRi0N8FH2G62LfzJ8uUG/t?=
 =?us-ascii?Q?ofhWG+OUgQbNpmnI5JP52rITwdUhnsNGCUYY3tuY1MPnid7DzMRsgCWqFrNc?=
 =?us-ascii?Q?bPAqb2XjK0G4eAQqExBNwnL2OVTS8IiZ/qprcbxzgyjDc2fa/hwrj+sGP2bd?=
 =?us-ascii?Q?n4C9K8wjWBrnmYmk8RkuRxdruHP4XWVBhhnuJiz53Fn1W1sJ4YPJkG0G13VU?=
 =?us-ascii?Q?ZSAsk+fsgz/E8XAfeaNdqJxkF0cntNFof0OQNeEh1ntXlGgYTgBl6kXN3Lsv?=
 =?us-ascii?Q?BztdcpDqPIapAN7xg59vr4o98NoVtfIDsR1Yzz/alqZ6yMYGNUPX7XBGgZFD?=
 =?us-ascii?Q?8DfRpG3zVREFNFU/dZgMOBiwQcq4POrvHvPO3HiXwOoxcQIP5i1d+lUBxHaN?=
 =?us-ascii?Q?bel+yalwyRnjcevqzhyFuE1Kvh3T5d98FklSGiCJFbotA1ap45cbouLobhhn?=
 =?us-ascii?Q?cRLRqTRQaQU2kTt74mCgeCRBMpevjQ1TrQjUUGv26UHmViWNAo2B/mUKUrb2?=
 =?us-ascii?Q?it1NJn0sfU0VX5C2ehxs+aw6vjmqoipIsR5rMc1c/KzyrxOjPDXCZW77DINM?=
 =?us-ascii?Q?iXF2SrnG9oJpK3Xy/Tw8dlWY06OxAkzrLqdoeF+HxDs/o9gr/84HMJWsoOrW?=
 =?us-ascii?Q?f7twH1yOf3Xu4bCqAEeTvydLNdmdzsbdVHeYWn1QDhyvakdjX5VvRDXOhcdV?=
 =?us-ascii?Q?lf8MUJ21pKHxcj5TVGaNWcM6pyxX6QHyKEN2j22gW9xUUZhCHFzOO/qHq/O6?=
 =?us-ascii?Q?JzZrPomtTqTbdF4=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR04MB8532.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(19092799006)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?f8nZDHLgGcaorPqyxea78OB8L8hU++Yawl0X6OC876b9rJ7E45FAufZHbciM?=
 =?us-ascii?Q?o3cwAApWSFhzJw8Fh03pmL6shGwvjKqNtS2SCpUW7vAYXjtsNKaPc7X2XAnw?=
 =?us-ascii?Q?m2FHCmCuTpaUWqyN3KOjMuR7Oo9n5potka5vqa5nALXMk2rBHXWohLmZkpha?=
 =?us-ascii?Q?niTVq2ALVJouB+03GzY2/ggslULc9SX44B8NuV4aCblB1EJ2uTCx6UcdT/1W?=
 =?us-ascii?Q?ZEbmR1EEjME7RqeJlQBgEq3tJntjA7KAgC4RkerMn+AShnQawqZUvVtQeo3d?=
 =?us-ascii?Q?7vxXW/HKlHVeAVV33f+dVdrmcuQWRcMlWvmhldHgtCE6KuU6WrVO1CgyL23x?=
 =?us-ascii?Q?5MoKTG29WqquFB4VVwGobiENDssnZlhWxAWEJsxRCLKznV4W1Pkcw3TOBNzp?=
 =?us-ascii?Q?ecUqutRV9/qsBE7WiZMLH9k+lS+02YBMZ+5VKqQsLevwsM7/iO40VKuuv0Ok?=
 =?us-ascii?Q?VQVDeCdxltZApnhrdxbIdyMwMKiBNh3EIvoR+/yudnW6hiVDuc+tspGbjpcr?=
 =?us-ascii?Q?5O1gTvKTeouq4bRCncruEkyZ/Kh5mwzmJxQinKiQOzLmNyOANYJ8oS/LQ/dQ?=
 =?us-ascii?Q?Ns+h60VXnguqTDyLPMpZ08J96SQmU0EO3WXUV6vv5rieyM/WkPjoWlVr4z5V?=
 =?us-ascii?Q?GtLv6j+PFvrrBU2vQO68PEjUEZDLX1WOWkEge5dtznTteqNAWFSvlcvTGRq3?=
 =?us-ascii?Q?TAHsKcoHVnvmQcBfQWUIRt+i+zjW5yUm8qWDsDeE40jKzpLOH903fdJvb2MV?=
 =?us-ascii?Q?x2jGJN8Cjl9gZ0TslLaxS7MpELl2b3kspIcR7GxxLApLw/ss9Ttll1hmm6hq?=
 =?us-ascii?Q?IKk+7JCum68iUqXG1naH1naY90AE3txSuQ+gtiJP2mxJde/rZgrlegVP6S7x?=
 =?us-ascii?Q?lLwIBmwhJe+cZXNlkk8EQ7JbUvqM3hsK2QoaQy4Pei0cpI9qVz5APgMQEafq?=
 =?us-ascii?Q?Ant+1pWbUo08MfUKDDOADlP1jKqfMyIFgyPCGoOnSltyC0PuS+EA/RahWXMI?=
 =?us-ascii?Q?Xw+CLPZNGhgZm4TSPTxNnXTi0lyFXZm6MiPeDWON72FVwC7/ePBk+eLH+C2q?=
 =?us-ascii?Q?Vn7soLPwLMO78jDXJNh61cHhJXsmQ0c4s2Q/LBZbtfuwNw53HYzxGbNp34Sm?=
 =?us-ascii?Q?VeiFEOAkybOQBF+XNCGyntRkzjmnrRRSFySyxRwNm2YjbjS7lYzXeRUZfDJY?=
 =?us-ascii?Q?z73djZelli1nlRrcIcIBbtiKhTnZmDRtSJfKiaVDcFExoPBEWQoX+W57Ulno?=
 =?us-ascii?Q?3bs3W0tgfpNKtM7eyqSuC4i+It6HMJY4OXos84aQIkNekyOAk1PXK6g6kJTg?=
 =?us-ascii?Q?w5iWN0vEIXMSwOAVVv+7MhHSYF5M7SO58vVi3jkJzBMTn0C6MBkeEkUq/tVg?=
 =?us-ascii?Q?RdqiVaBzXOu9QUU5VMla4WRnHVEjYwB5qejfh5mitWDg4UnKhEpVskymllGI?=
 =?us-ascii?Q?qqeGsmi/6fIz67aStdWkmp7lpy+nhL5XUzApg4GD5xDnQGKbg0iM6dTbnmhE?=
 =?us-ascii?Q?ENmLB3rnlEiQLBowFknkbCw7W78bdyno9nVHfn4/eU0Yl3du5Dmm22PmX6rW?=
 =?us-ascii?Q?agUAsE3rTeXoZF4FOLsZFDZ6hdjy1Xn6IglRu4IpoUaZH7fPO8FWhgAgqCqH?=
 =?us-ascii?Q?Gg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <8668FECF0026D24499FAB032373BFF44@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: eJeeW3lCPYUeWcUrEMJpFqvnCORj3Un848EHeFfbbJIxV+8Xfg9WS09f8R2JwDM5pJ8O18uKAywb8QjP76brb/wGcEW7ucF2mxTM6hggU37fdFde8mx1ppmbH0NJFJ4o5Vpa9zgitL5rRnMSON4ePPmE578vObhJcKAaXl2ZLbM903DrfVGckLHjgvojct0ozWi8IFPC96Q8D2eyrC1A3LD/5diMT/ziP8QCa7DDlnj3yOycE70wKs6dXBB2t+dGwOXMy9frRgBhfhOkxMEXox9deQpVFbnA5bwWIKC0ll2OEmPz5XOb3hkj88DGR2ZXGk6GfOq3G880MG2tZxpKbH25sG89Sku+Kxo34MVATcWFER5uWqPxVnfxAKPObF+kUababw3FqEGIufEsAAXMU0uODLIn9y9HBau89NShCT0u0P5vkPEJLaqlV+R5ZKVxQfabnSbOmGra7VoQzMTEoJh4eQr4JxfXQ1XIqSjAZGrC6xGFNImuceEMma9DQXys/I8lIEoyN8UKETQQ8J+3UJ3HZf9qaEogSPsjSSfhQ0CnJo4wEWbzkxeTcLYfpdyQX7978jrKtoe8jbH+lDeRutz8N3v7TJM+wqlYJL3cr1Ymk1n5gxwaK0zwl3MTXwni
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR04MB8532.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff7eac9f-90d2-4a53-328b-08ddb87285fc
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jul 2025 07:40:16.9602
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZDlaHLigWInKjV6IOnI4JwWno3Q3HzpA/r6Z9CpOzYShYGpvMAVY/Z+nJ0eMJR+NTHPojiHIh6xJemRmogNMz4k7I5bxWr5DOIcCBEJhgU0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR04MB8748
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250701_004020_449636_DFEE22C7 
X-CRM114-Status: GOOD (  14.56  )
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

On Jun 25, 2025 / 20:45, Shin'ichiro Kawasaki wrote:
> Recently, the new test case nvme/064 was introduced to cover namespaces
> formatted with metadata [1]. To run the test case, it is required to
> specify namespaces with metadata as TEST_DEV. When this TEST_DEV is used
> for other test cases, a few other test cases fail. This series addresses
> the failures. The first patch allows skipping nvme/034 and nvme/035 when
> TEST_DEV has metadata. The second patch adds an option to the fio
> command in nvme/049 that is required for TEST_DEV with metadata.
>=20
> [1] https://lore.kernel.org/linux-nvme/20250616020716.2789576-1-shinichir=
o.kawasaki@wdc.com/

FYI, I have applied the patches with a minor fix in the first patch to chec=
k
the existence of the metadata_size sysfs attribute.=

