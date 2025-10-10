Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18EF2CCA476
	for <linux-nvme@archiver.kernel.org>; Fri, 10 Oct 2025 07:21:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ioXb8jpdaVW/CnR8UfoLAGf+6v7m2IxSuJtKz8DNr48=; b=PYnQ+RR3Bg8feG1cNaHaULK5aP
	LPkHWwz4OiufydNVPDAadIV3jsTd+uSmioF7jmTre/iVGExQWWHUahMJrVUJwRQaWkYubGeQ67nvG
	pSCaAjWl537yxQjezqosyqBNkCERZ/flzjw46BoITU0+CSnnfXjjg1WQTp1D5pvj+tEPqDvCjTK1x
	BtaGyseBvPAB/NgsAXq5ao4srNthy39vrafwSoOGcnRW2RXi1WCvvX1e+ki84vJhWgufsng8Q6VwA
	SC2KSdNiCzD6UR9R6CkliQWJsfMJ+SgfBI8pyT3ppgy0jggEWzm02+8+fNGkJD5592x8WeKgYo0zp
	+vbfFbPA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v77RQ-00000007qaG-10HV;
	Fri, 10 Oct 2025 07:21:28 +0000
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v77RM-00000007qYJ-2KaC
	for linux-nvme@lists.infradead.org;
	Fri, 10 Oct 2025 07:21:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1760080884; x=1791616884;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=ioXb8jpdaVW/CnR8UfoLAGf+6v7m2IxSuJtKz8DNr48=;
  b=T3HIqtPnpSekjiBcPofadXHxE6fAJQGhhvCcQg8VkZLOAbA+ZXC8eJO8
   5S+lDQlL+Rj22W86bZaTCM1AGUAB+4PkajKoHIeCAp5X0IDINf4i1rlSI
   EC7zltKfK/OE+vbe1FZg48sTbCPVJR43VazsW0z58qKqGgFSMulMKve2F
   MDG+AlHWJdNj1dvSmLv9vr2SMPAQkrbQG3KnHfGlQ0CdXETP66QtMAPNe
   OLb8QkyjXNrohYeKZWTUw2Ak7Hm8ARvSnZLq3Ta6t7K6W+uqVSgYpB/wf
   SqGM+rClfwWHeQza6p+iugPC2DV0z1dQQKUhbNb5Zi/iiq88YfEhixHbG
   g==;
X-CSE-ConnectionGUID: Mz4qNzDxSiO66OBKhu+LMQ==
X-CSE-MsgGUID: 8+kLKKp5SLqUEUQlhrtJtA==
X-IronPort-AV: E=Sophos;i="6.19,218,1754928000"; 
   d="scan'208";a="132976237"
Received: from mail-westusazon11012003.outbound.protection.outlook.com (HELO SJ2PR03CU001.outbound.protection.outlook.com) ([52.101.43.3])
  by ob1.hgst.iphmx.com with ESMTP; 10 Oct 2025 15:21:22 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N4epAiNtm/IZ4zKrVAI/F2ZPWDjcrQiA/bvIfFWtGq+rRPLTh5/bqFnPy4vGN8eCkUH1xYvXCoBKqI4E0f/R5l7wUCncw0O82FGcoDfzTgTlKjbKdkg2axZfr1Kt+1bW1crdFFJEZHsxy/eMZhYINI/69v97B/uPQgfcANrNHY/UPiNsZnceMNw2kIWLg4UB++/F1obhukPV5pk9BeepINfC5uzWQtmCVXuEA6XiPB3bX0tqKFGAzXzt5kSzWdb5XvtP5zKd/aEqC8VLR+2U25fKdbSiO1dse2ivZeiEL53K1pZ3FKt54g52GOLyISVJVhvXlNMDxV08WHXXGyZHmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ioXb8jpdaVW/CnR8UfoLAGf+6v7m2IxSuJtKz8DNr48=;
 b=DVxIdzrNrPKkKwImiByLAHkYbfCGMH/nV3lTBK5qDwH3CFDdyqMGMMktGrcxhDH69MfOn0bktK1/CRT4K1H18HnKBNdqdTEmHPhoTqKdfZaflcCH+ykWxinODBdErGbDS7U6/Ojd6zrFN96KYnr2dQIwr6ShajZiWMPHEpVhAYqoplPE4GYhTaYknspN27ihy+2RJTu3z+ht1iaP6WF8i3yG2+oHn7RCiX63UU0FqKiqFXPCcUSMKJuXLQDtMlRkEnUAM0KhuEmPzxdlqBANXaqEFHUlqMrf2iuJ17MnpspoGSWOGQjYLPY7YKmqMnU8vzWvYkWfo/B4gkCqjI238g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ioXb8jpdaVW/CnR8UfoLAGf+6v7m2IxSuJtKz8DNr48=;
 b=m5qCSWoisq6iOKEVUWEnagdwt+xjo7dP0lVsLtQeAo3omBTA72ZLXo1b0yIf7L8qg9ospwcxPakvlEFiiri5fCizWexsYOhv9cGjDgYdhMuXAlmC2hVrhA4cvH5vprE/T9q21gbYE3FN7qHC8GfSfD4E/3Wci68r1klgmCt9+W4=
Received: from PH0PR04MB8549.namprd04.prod.outlook.com (2603:10b6:510:294::20)
 by CO6PR04MB7537.namprd04.prod.outlook.com (2603:10b6:303:a1::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.9; Fri, 10 Oct
 2025 07:21:20 +0000
Received: from PH0PR04MB8549.namprd04.prod.outlook.com
 ([fe80::5b38:4ce0:937:6d5e]) by PH0PR04MB8549.namprd04.prod.outlook.com
 ([fe80::5b38:4ce0:937:6d5e%4]) with mapi id 15.20.9203.007; Fri, 10 Oct 2025
 07:21:20 +0000
From: Wilfred Mallawa <wilfred.mallawa@wdc.com>
To: "dlemoal@kernel.org" <dlemoal@kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: "kbusch@kernel.org" <kbusch@kernel.org>, hch <hch@lst.de>,
	"axboe@kernel.dk" <axboe@kernel.dk>, "sagi@grimberg.me" <sagi@grimberg.me>,
	"hare@suse.de" <hare@suse.de>
Subject: Re: [PATCH v2] nvme/tcp: handle tls partially sent records in
 write_space()
Thread-Topic: [PATCH v2] nvme/tcp: handle tls partially sent records in
 write_space()
Thread-Index: AQHcOZ4AMPzyq3WBO0+T9/nrDDcuMLS62WEAgAAgVIA=
Date: Fri, 10 Oct 2025 07:21:20 +0000
Message-ID: <48e20a5d57715e9aa39bb13bd1304f059a94a676.camel@wdc.com>
References: <20251010042514.704249-2-wilfred.opensource@gmail.com>
	 <c39248ad-9adf-471f-a344-762920743d83@kernel.org>
In-Reply-To: <c39248ad-9adf-471f-a344-762920743d83@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB8549:EE_|CO6PR04MB7537:EE_
x-ms-office365-filtering-correlation-id: 5b49eea3-a131-45c8-07ca-08de07cd9c50
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|19092799006|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?TEhkVHJaWTFhbzMvRHZuN3loRmxEV21ENHJ3NlZaL0R3RGp2KzFjdllMZ3VU?=
 =?utf-8?B?Y0U0ejNBVmw4RGhPTjA0ZlpObmlSQ21YdkFrL3h4cDFFdTNxZDlhZjZKZGJJ?=
 =?utf-8?B?eFdTRC9YaU9GLzJoMzg5NGNnb0QreDdrblplK3RhR1Y4UTZDQmg3NDFJSXJE?=
 =?utf-8?B?RlFPak9QaWxxQVlENUFKYVByYmVaNzl0OEowNXVHTjhBVzVFK1FxRjV3S3Rw?=
 =?utf-8?B?QnpaRHlxeE4rVXYxZFBicExtVy9vOEdUR0UwOXpaWjZRRVBhb3BFbi9EdmFm?=
 =?utf-8?B?VlF3RjJIT0dkci9HNThlY1N2UHg0R09BUGFvNnRjc1FvWmdhUjdJQWludm9E?=
 =?utf-8?B?NUJ4aVFGY3A5cEZnR0NmUFVHclpmQUVkSWpRS2ZwdW0waXlqL2ZXYzN4OHVa?=
 =?utf-8?B?OVJtOURMMGVOWlhxKzFtcTlMZUM0VHp0UVVGZDBxMHE5OFZGejgramtEWW5N?=
 =?utf-8?B?UTJpVWpWMFdQZG9VYWhJdFloSGlJa0VFUW9Hd3VHV29HNGE2UXljRi9IbGN6?=
 =?utf-8?B?amk1QlVrMzVsUFNna0NNcktuUno4WnB3bHZrcEpPWnIrSkRKQzhkUHFBcmdG?=
 =?utf-8?B?UzlVT1JjZkJYRGdFSklxRXJvT0t3SDhpeDFZb1ZQcjJWcFd0YWhyZnAwUnFW?=
 =?utf-8?B?L0VNRkc5VGNmaEY1QnoxMVdUbHRmaXZPbklGcWVNbmI2bi9RMU1VZVZ5VGdn?=
 =?utf-8?B?djlxeThHbUVYMnNKT3Uvb1pBRnRtUVZiV2Myc2hReURjVi9QT3Z3QiswRHdU?=
 =?utf-8?B?Zm5GTmNZSmZXZDc5dFkrK3hxajdNYm9MeE5kMTlnZDV3c1I2M3RGczdvQTJZ?=
 =?utf-8?B?cW1XNUR1UmI2WG1rTjJ6NUtjRno3Mk1WVzJiL1ZaWThreDFNa2dmQ05EMXZ2?=
 =?utf-8?B?U3Rab1YwNG1SU2R2dU53TDJ6dFdxTWc1QmxCOFNZdi9nZ3lzbkdtVm5CZkJj?=
 =?utf-8?B?Y0ZtQ3FWcFRYV0tSVGtLdGxXTE81MC9jdWQ4cmlYblFodzVNckU1UTFqWERz?=
 =?utf-8?B?VzIxbDk4TkloR0E5cms5Ny81VndXWlcxK2d6L2xmbzVZaXlXM2p3QmF0OENw?=
 =?utf-8?B?ZDArbzJzUndGM0FLY2E3dmZWUzlQTGdUSndPZkRLWFYyakpWQ0cwMFRrV09h?=
 =?utf-8?B?aFV6L1FvRVJZTENidkZRVEpQcmk0RHJ3eWdwV1A0MVRCNUtRdXVQMlVlalRR?=
 =?utf-8?B?UWJNK1ZxRWJCS2llWTJqdTU0Y3JwWXVHY0ozcFR6NFBJV1ZwVTZvSkVSTW03?=
 =?utf-8?B?T1hpbG5xLzIrb21iL01JMVZnQm5NWDlqL2MvMmNkYUxvV2NUb0ZjM3ZFREoy?=
 =?utf-8?B?TXp5T29sQmdWeWVLTnExS0NjUkpRREVuMTdxZHp6Q0FoZk53R0NxZkJ6OEZk?=
 =?utf-8?B?UDBqdGtUSEEwZWgzMnpDNW4raEo0eGRuOHdFM3ZRMmx0ZWJFQ1ZjT0xKRWsw?=
 =?utf-8?B?RGZreW1IN3RPTGR6NHJXUTNIdHNQZUl0SHdjZDV1bHB4eGVJa3pFM0pzSE91?=
 =?utf-8?B?ZURUL2tWdjJlMmJZMTJ3NVZxRVpOcmw0SUZkR0k0SHBmeUIvZFBKYXI4aThy?=
 =?utf-8?B?aFprMmlCRXJlMTZpVlJLWXd5V0o0QVo2WTV3KzREU3hNT2Y3Lzc0ZDhEck84?=
 =?utf-8?B?WG40SGZRQnhiYllyWG4rTjd5VFlvN2Jwb0J3NloyRnRiMzM3ajRxekdVMzZl?=
 =?utf-8?B?VHdhVWMvaStkdjUxbU8xYit2N0Njb1R3Q2pzWXpJdkRCK2s4SFE4MDB4V2pK?=
 =?utf-8?B?ZWJRdEpYMm9XOCtsTXdVMVdkQ0U0T0xKQjl2eUF4Y2VkY1BzaFpjTnlZYlVn?=
 =?utf-8?B?T1VFRUpKYVgxd3RVM1IwZUNWdjNrNHFBb2k1NnVyVnozWDdtK0kwUEd0NFh5?=
 =?utf-8?B?cFFZblF3ZkVNaW9oOVI1L0NJUjZ6b0FXUHRtV3FueTJGQjVYK2szeE8vdmdh?=
 =?utf-8?B?ZFlPWHh2WC9PRmIzbDJuaGRTV0NJUGlPcW1BS3VJdXlMQ3FLL0liK3Y1SGNX?=
 =?utf-8?B?YnNQYkFETFpmWk4xYlRDcFd1bWRGaWFpVUwvM2QycCtScFNENTEvVnFiejhT?=
 =?utf-8?Q?YnSfsa?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB8549.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(376014)(1800799024)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NWNRYWdnZFMwdVpUZlV4RXpiYUNRb1FTNlA3dW9NTkN0RUtwYWJGQmRvZlhJ?=
 =?utf-8?B?bFVHSXY5ZXB0Ym1MUFZjOHJadWpjckt0cnltMFNGaWxlSkZoYkJ0QzF1Q2NZ?=
 =?utf-8?B?VDM1RmJsSTlQVGEyVFpwOGFvcFMyVlNtcG5BcjViY1lxbFE5bnZvT2NrZlgx?=
 =?utf-8?B?RllqbVZiNHRVYjlFSzlaU0FLa3htTW01OFZEaXpOMHNqSE9kQXNKcDA3VkNn?=
 =?utf-8?B?TW9VY0xqQXRweE9hSlRMdk1TWUtvR25ZNW1pNUhMNjU4TFRVOHBtQkd6RnBu?=
 =?utf-8?B?VGNjS0Z5b3BaZzljUjkxRXM2ZlRqMmxXNSs5OHhOSmJWeDRSbVlnKzQ5d0VC?=
 =?utf-8?B?WE9CZ0REQ1lidTUrZlh0cGREcTZFVTkzaWYyZFV2N3piNWVkY0hTeXZ0eFRr?=
 =?utf-8?B?OFV6WE1QdkY1c2ZGMWNyZEFUTGJBNDJEc1A4L2RRdW9xRUdIclpBY3dyenI3?=
 =?utf-8?B?TTk0REc5eXZRMWJKdHBaajBmTWRDMnRBQVRZTWo0RkVkdGJjcitzVURaekww?=
 =?utf-8?B?YUpqK0lTVGMxeHhyNTU4ZWVrck11ZzdOSVV4dno1RTJlQ2t0ZkovVFVYb1ZT?=
 =?utf-8?B?NlpDSHJ5ZjlZWE9xSE45aVhTNnRMallrMlQrVytKaHdWZ0Y3WC9QVWwxSXdS?=
 =?utf-8?B?UlhKZXI2aWNzNnlZbWxSM3ZsY1k4eU9Sc0lNK01wQllHOEMzRjdaS0FYYlpn?=
 =?utf-8?B?MGowTXBxWGZ0NVVqY25PQVZ5c2crRzJTSnpKNml5YUdHdEx1NFNOOExlNGN4?=
 =?utf-8?B?ZjdNaXh6Y2RYREJjU0Y3VEZyTEs2aWRXRUNZRjZzdnpudytBOE90WFNuQkkv?=
 =?utf-8?B?WmhjZlJRd0lnVm5UTFA0cmV1ME8vRW9UaGtlQ1l4WmdxMUNWM3JWU3Fnd20v?=
 =?utf-8?B?YU8wbENhRTlSbEtScXViZktpQnBMckZmbjBBOEhVRjNDNnVoL3U0RDBEdmJG?=
 =?utf-8?B?b2J2NjRIby95Q1U4K0xyK1NUZWF0eWR0eUpacGdEbnlHZ20wNWxITllEZUV0?=
 =?utf-8?B?R2p4elcvcCs0TWxwUVBvRjdvZ1VaQXlaUHIzdXBoTmVIYTc0azRNeDU1K0p5?=
 =?utf-8?B?TEVGQWpKZVNHUUd1U1N5YUNTOW1LTW1aci9YL0JVZk00RW9CU3JKaHp5akc2?=
 =?utf-8?B?MERqSVF5Y01KV0Zlb2o0NlJlQ0xIRlpvTVgrV2VGVlFoNzY1YUxuWEQ1dnNI?=
 =?utf-8?B?cFA0UGZNTzRlOGV5TUM2b0VHK0tSQTlMdWpWVXlDMFNjb1cyQTBzd25URjJp?=
 =?utf-8?B?cExTU1JqUHFpdTk1RVc4Mi9jRGl4T1JsSkdod3dnMTc2ZkZ3UHVmdG9BOUFz?=
 =?utf-8?B?YmV3VnkxeVRaN28wWjB4MWVMdHp5MGJEcHdKbVhDSmM5OURGcVQxZFVOMG5s?=
 =?utf-8?B?Z01JMTlibWc1d0VoQ1U0a1hOYnMwRXhERkRTUStBaEdjWUk5TmkySCsxbEFG?=
 =?utf-8?B?VXI1M0RsRTNMVm5MZVNGMDZWeE84eEUyWE0rZjJyRGEvQTJLSjVMT1BlQklG?=
 =?utf-8?B?amVtSDZWSXZIQ3VXaXRDRklwUGpLOVlPRHdBTmRzci9CQllYVlgvWFJJYURH?=
 =?utf-8?B?TGVnMlFSaUlkeWVYMWlsWDBkVzVWUlJDWGtpaDJRSlNxR09kckRwN2pUcHF1?=
 =?utf-8?B?VzRSZVJYVVpLT3NmdDJsaDBMZFJIU2F4UFN2eXF4b1lMVG16VEdOMlB5SGF0?=
 =?utf-8?B?Z0dhWXdISGhQSHpyWjBqTEwxOEEvK3JnbWZhdTlyTy9ESUVFbVBVaFBnc0FM?=
 =?utf-8?B?aVNvcDZMa2VseUVXS1l6WWQzQ2YvOHQ3Y2pFUzhwbk9acVhod1VDdGkvRWtR?=
 =?utf-8?B?Nzd4VXlZdnRSVEpVdWs1Y1VVT0RieXo4RlNVOWhXR2liR3N1SVdXbzZldzI0?=
 =?utf-8?B?ODRhbGNuUk1ENmRyZjlyTWxYUzY1UWF4VWVmRlgxb2xOckcyYW03aGFWLzNn?=
 =?utf-8?B?OW5BcVRDYmluMkhUUVp5VHNMRjQrOTdpQjFKM1FLU0oyYlZ1YmsxWFlDYTFn?=
 =?utf-8?B?KzJVdk5yUFAvek1jcTA5NVJHdU52TWtaZ3k1a2ppYTdmeDBwc2pqOWdSdDE3?=
 =?utf-8?B?L3hSQ29PWUdraGVUVEMxekwwWm1oUWt5Slc5ZEt6amYzbSs2Q0d2V0xRMkl2?=
 =?utf-8?B?SWxKWXBXdlI4SHVuM2FMODhONTBsSXBWYlpMWmFkalg1VzdpZzBYc3RaME1h?=
 =?utf-8?B?Qnc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B5C8E4E7D9961747B7137809ADA9212A@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 9TvKYvHG39SlmvqH2iL5l71lZ5pRApZAYhasX/sxyuqlHyTyfR/T/L19+sC1kmoG2Gk9ru+IvBFxriYG2T9g9vZFm8PVBrIptX+vLBcMoPBIlUAhey5uRz/Ciwv9D8Rcc5HaS9AIZavlJtCTUbsRQGQsjrLbl+YrV9nw5q1cFV2gdUG4piwFmdpquJTEGAIRGW62Hut6aoCZih3w6MBpoDcsxHCsG+90MchNgxkKApqaV38pXW/bNbFL0TWUVO0yc0rmm2cbYNXQmwmq8ZXA9uFsSE6mpikSiYK41KpeOAXENc2p8lYUZqrZmeUvh5e7Wvs8sc0xBkMLKPxBqTNfxyka29X4oVLcedrAhV06viGy0d46sJPioweUbpQQmlhV55dYnlOGTQ9wp0V//kykQxQ9kAvJHe9xAt2j07cYPjkA8506x/uHpvoe0eruIE7FkEGVDRtS0hsOLb/VDudvAaUaFRlYQkLyDV9dfEZv9yd7WVpG5n1f/aljZITSVzdeIKoGCVYWy3wS/z0SkM0/h7nSeBELI8psl7ZUj4/JYEg2D8ylmeDC9ppnDVYnaWkg/+8VmAgPUX7W6Y/nKYDtTcZFP4YpI1bKnk/0m39MRvDcoYnrfIo1g9YP+h/zmnFx
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB8549.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b49eea3-a131-45c8-07ca-08de07cd9c50
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Oct 2025 07:21:20.5195
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uHnRlZZX7syW8QCzzbEqdf+aQ+vOWINa+MoTO+y5rTMAQInoSVb3cSSgrJKT0MvxbxeBtZAb26HE7FVVhKORTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR04MB7537
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251010_002124_612046_D249B9B4 
X-CRM114-Status: GOOD (  26.39  )
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

T24gRnJpLCAyMDI1LTEwLTEwIGF0IDE0OjI1ICswOTAwLCBEYW1pZW4gTGUgTW9hbCB3cm90ZToN
Cj4gT24gMjAyNS8xMC8xMCAxMzoyNSwgV2lsZnJlZCBNYWxsYXdhIHdyb3RlOg0KPiA+IEZyb206
IFdpbGZyZWQgTWFsbGF3YSA8d2lsZnJlZC5tYWxsYXdhQHdkYy5jb20+DQo+ID4gDQo+ID4gV2l0
aCBUTFMgZW5hYmxlZCwgcmVjb3JkcyB0aGF0IGFyZSBlbmNyeXB0ZWQgYW5kIGFwcGVuZGVkIHRv
IFRMUyBUWA0KPiA+IGxpc3QgY2FuIGZhaWwgdG8gc2VlIGEgcmV0cnkgaWYgdGhlIHVuZGVybHlp
bmcgVENQIHNvY2tldCBpcyBidXN5LA0KPiA+IGZvcg0KPiA+IGV4YW1wbGUsIGhpdHRpbmcgYW4g
RUFHQUlOIGZyb20gdGNwX3NlbmRtc2dfbG9ja2VkKCkuIFRoaXMgaXMgbm90DQo+ID4ga25vd24N
Cj4gPiB0byB0aGUgTlZNZSBUQ1AgZHJpdmVyLCBhcyB0aGUgVExTIGxheWVyIHN1Y2Nlc3NmdWxs
eSBnZW5lcmF0ZWQgYQ0KPiA+IHJlY29yZC4NCj4gPiANCj4gPiBUeXBpY2FsbHksIHRoZSBUTFMg
d3JpdGVfc3BhY2UoKSBjYWxsYmFjayB3b3VsZCBlbnN1cmUgc3VjaCByZWNvcmRzDQo+ID4gYXJl
DQo+ID4gcmV0cmllZCwgYnV0IGluIHRoZSBOVk1lIFRDUCBIb3N0IGRyaXZlciwgd3JpdGVfc3Bh
Y2UoKSBpbnZva2VzDQo+ID4gbnZtZV90Y3Bfd3JpdGVfc3BhY2UoKS4gVGhpcyBjYXVzZXMgYSBw
YXJ0aWFsbHkgc2VudCByZWNvcmQgaW4gdGhlDQo+ID4gVExTIFRYDQo+ID4gbGlzdCB0byB0aW1l
b3V0IGFmdGVyIG5vdCBiZWluZyByZXRyaWVkLg0KPiA+IA0KPiA+IFRoaXMgcGF0Y2ggZml4ZXMg
dGhlIGFib3ZlIGJ5IGNhbGxpbmcgcXVldWUtPndyaXRlX3NwYWNlKCksIHdoaWNoDQo+ID4gY2Fs
bHMNCj4gPiBpbnRvIHRoZSBUTFMgbGF5ZXIgdG8gcmV0cnkgYW55IHBlbmRpbmcgcmVjb3Jkcy4N
Cj4gPiANCj4gPiBGaXhlczogYmU4ZTgyY2FhNjg1ICgibnZtZS10Y3A6IGVuYWJsZSBUTFMgaGFu
ZHNoYWtlIHVwY2FsbCIpDQo+ID4gU2lnbmVkLW9mZi1ieTogV2lsZnJlZCBNYWxsYXdhIDx3aWxm
cmVkLm1hbGxhd2FAd2RjLmNvbT4NCj4gPiAtLS0NCj4gPiBWMjoNCj4gPiDCoMKgwqAgLSBVbmNv
bmRpdGlvbmFsbHkgaW52b2tlIFRMUyB3cml0ZV9zcGFjZSgpLiBUaGlzIG1lYW5zIHdlIGRvbid0
DQo+ID4gbmVlZA0KPiA+IMKgwqDCoMKgwqAgdG8gZXhwb3J0IHRsc19pc19wYXJ0aWFsbHlfc2Vu
dF9yZWNvcmQoKQ0KPiA+IC0tLQ0KPiA+IGRyaXZlcnMvbnZtZS9ob3N0L3RjcC5jIHwgNSArKysr
Kw0KPiA+IMKgMSBmaWxlIGNoYW5nZWQsIDUgaW5zZXJ0aW9ucygrKQ0KPiA+IA0KPiA+IGRpZmYg
LS1naXQgYS9kcml2ZXJzL252bWUvaG9zdC90Y3AuYyBiL2RyaXZlcnMvbnZtZS9ob3N0L3RjcC5j
DQo+ID4gaW5kZXggMTQxMzc4OGNhN2Q1Li42MDE2NTEwNTc3YmQgMTAwNjQ0DQo+ID4gLS0tIGEv
ZHJpdmVycy9udm1lL2hvc3QvdGNwLmMNCj4gPiArKysgYi9kcml2ZXJzL252bWUvaG9zdC90Y3Au
Yw0KPiA+IEBAIC0xMDc5LDggKzEwNzksMTMgQEAgc3RhdGljIHZvaWQgbnZtZV90Y3Bfd3JpdGVf
c3BhY2Uoc3RydWN0IHNvY2sNCj4gPiAqc2spDQo+ID4gwqANCj4gPiDCoAlyZWFkX2xvY2tfYmgo
JnNrLT5za19jYWxsYmFja19sb2NrKTsNCj4gPiDCoAlxdWV1ZSA9IHNrLT5za191c2VyX2RhdGE7
DQo+ID4gKw0KPiANCj4gV2hpdGUgc3BhY2UgY2hhbmdlLi4uIFJlbW92ZSBwbGVhc2UuDQo+IA0K
PiA+IMKgCWlmIChsaWtlbHkocXVldWUgJiYgc2tfc3RyZWFtX2lzX3dyaXRlYWJsZShzaykpKSB7
DQo+ID4gwqAJCWNsZWFyX2JpdChTT0NLX05PU1BBQ0UsICZzay0+c2tfc29ja2V0LT5mbGFncyk7
DQo+ID4gKwkJLyogRW5zdXJlIHBlbmRpbmcgVExTIHBhcnRpYWwgcmVjb3JkcyBhcmUgcmV0cmll
ZA0KPiA+ICovDQo+ID4gKwkJaWYgKG52bWVfdGNwX3F1ZXVlX3RscyhxdWV1ZSkpDQo+ID4gKwkJ
CXF1ZXVlLT53cml0ZV9zcGFjZShzayk7DQo+ID4gKw0KPiANCj4gTWF5YmUgcmVtb3ZlIHRoaXMg
ZW1wdHkgbGluZSB0b28uDQpPa2F5LCBGaXhlZCBpbiBWMy4gVGhhbmtzIQ0KDQpXaWxmcmVkDQo+
IA0KPiA+IMKgCQlxdWV1ZV93b3JrX29uKHF1ZXVlLT5pb19jcHUsIG52bWVfdGNwX3dxLCAmcXVl
dWUtDQo+ID4gPmlvX3dvcmspOw0KPiA+IMKgCX0NCj4gPiDCoAlyZWFkX3VubG9ja19iaCgmc2st
PnNrX2NhbGxiYWNrX2xvY2spOw0KPiANCg==

