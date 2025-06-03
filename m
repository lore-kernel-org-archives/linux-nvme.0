Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DA29C5B549
	for <linux-nvme@archiver.kernel.org>; Tue,  3 Jun 2025 00:32:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=MTT2KqM/Fuskhib9wvvc4JUzh8QdACANWwC4WfKLrYo=; b=H1QRfhCeRE6T2fwFwra67zEWXA
	pVSSihjXObPZPdqP1kqj5xfPFjtlTKqz0VQR+3NdsW8nRUcNZxYXu4Q28lbNV/YgGahe2YveOOzzU
	rcoRQ1gpyoXqrwLiUlfD2ZW2CT0H61va5kbJr3yANe6hCH7XAStHik9vWQ1bYA75ncAFzkhffjDDx
	7VZkTogCHGnZWJw9TjGNUPkPLrB43kr5zapHHN4W94YHQ5pzSSpBxbujT0u2dP/ySGG79gZnKdz1S
	xZAbv5cmoPL3CosLJ86BO6lacvvdySYolM/WkQDcDzuy9zsuGY9nrK8eb4spKHoe3NAPwCOjdtFgl
	qPSnEdxQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uMFZz-00000009QGw-1sF1;
	Tue, 03 Jun 2025 00:32:35 +0000
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uMFZw-00000009QGa-3A0l
	for linux-nvme@lists.infradead.org;
	Tue, 03 Jun 2025 00:32:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1748910752; x=1780446752;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=q4tRsljK3lKjkyUCPKQAuzMwJorUKbIhR/lsKNcg0+s=;
  b=E/ezEEWnLZGG+Ip64fEMd343B24jkgyKXZjgyS2pynPabqcsxcaNEJ/i
   AHfNzi6QrdDtxespt5zYEPheBQNCgcJMyUsDgKMY3ma7rO6ldL5UQjkmH
   b0IkmB7ipMcoxMrDs6haP9h0NMM2mrSE6jJ+5Z+x2mGGw8BhIAxb8Gjwz
   5rvLw1DFeXLZIg6r5ZIdVZSUur+kYYiIxg10t0RdRDN1TX2AwM6vBPW2F
   35WXEUmt6pglxi5Ts2A6+kJ481eNYvC2fwvlgwCVJIPYk7VPy7oegB1De
   vUBCDdH4AV5PKtlEwz4AgCwewtiu/i5KwUvDkaTgTkPbcdJ6lBrYeNcRk
   Q==;
X-CSE-ConnectionGUID: f2pmXfkjS/OoOgbuuA+gwg==
X-CSE-MsgGUID: HGNmm/DeRpyiDBMGKtNtDw==
X-IronPort-AV: E=Sophos;i="6.16,204,1744041600"; 
   d="scan'208";a="89851254"
Received: from mail-mw2nam12on2054.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([40.107.244.54])
  by ob1.hgst.iphmx.com with ESMTP; 03 Jun 2025 08:32:30 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ef6Jzc3uUm9lGFb5Bpw7F9HUVs4A0SnLj/pqpRRAt2fJNTCIP57s/M96JmrQvNDglX61BfSRbARK67ZmStfKdIQy/3J3atMoxsONC8b0x0VMenhcwJJO0qOPFipJBSVWztg+rko5aNBuirPCqG6gBcpBqqnkZDH4W0PurtwQQhzrjlMy4SMCJnzYfRJXjRON4dQOYR/4rXn/wa8IZhM7Kh8ezOqbWMv/QFvgyc0v5EQGHSzAkBQ2tGVoTgWRunz0pnKv4LTYNbehbG3bIvzik6vRrY4C7Dzs4oQArARUAPxlTelKUQozJaEY1BPLZw/v8NrNFQi1ZJfdhlD87YSFpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MTT2KqM/Fuskhib9wvvc4JUzh8QdACANWwC4WfKLrYo=;
 b=o7Zbc3igl5o2e/ag64n73fr3LnMUfFr7uhL3AovBuPoXNMecEmO9oBOUKSMfc8032rISF0tGEyNHSFcmfsx10ITAgVB4S4E8z5uCd1Xut4uTH9enuxSqDfhpjsdQMU6QMcBWpTnNo1vhQqkBxIT6aFOE8olccsT6ONAMERfHJfJ5+DXIYzsYdT4xf4DvI6W2HCNtGcNFshgncgX+od+Lf6IvQlZxdEPWq/5Yx4jUN3Eo9h58rFX2Cc5plafq1TwIwesh3ykofiuuRkofjIAYfz3juST+pJw+iqKVZQYD0GcYtLSWpImCqWZ9RpnLyCE7LhoU/mp3fVCtfaDf372WJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MTT2KqM/Fuskhib9wvvc4JUzh8QdACANWwC4WfKLrYo=;
 b=KzU1MbqLTigWLM1/ZuQPba2BNHRQjJk1KAorEDIDFWiIcf9jHFsrPDjrEwOAri0bLA3ko+IdZHM6PKITtRs8HEiAAwSMLRqDfoiNOMpQ50lEaAi6de0ML3uQCR8reIn3TzY+jqMQOe52/HocazQgWyzv6j5CfUWs+et2UsmM+ug=
Received: from SJ2PR04MB8536.namprd04.prod.outlook.com (2603:10b6:a03:4f9::11)
 by IA3PR04MB9353.namprd04.prod.outlook.com (2603:10b6:208:508::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.27; Tue, 3 Jun
 2025 00:32:27 +0000
Received: from SJ2PR04MB8536.namprd04.prod.outlook.com
 ([fe80::8820:e830:536b:b29a]) by SJ2PR04MB8536.namprd04.prod.outlook.com
 ([fe80::8820:e830:536b:b29a%6]) with mapi id 15.20.8769.035; Tue, 3 Jun 2025
 00:32:26 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Hannes Reinecke <hare@kernel.org>
CC: hch <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, Keith Busch
	<kbusch@kernel.org>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>
Subject: Re: [PATCH 2/9] nvme-keyring: add 'dhchap' key type
Thread-Topic: [PATCH 2/9] nvme-keyring: add 'dhchap' key type
Thread-Index: AQHb1B77KzH4/LNdwkuGh5NugnLRiA==
Date: Tue, 3 Jun 2025 00:32:26 +0000
Message-ID: <2hmqk26l6nsbgpwjgumec7burdg6vmujq2tbo45d3zcdehhowh@fpni4uyjrnzl>
References: <20250528140517.3284-1-hare@kernel.org>
 <20250528140517.3284-3-hare@kernel.org>
In-Reply-To: <20250528140517.3284-3-hare@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ2PR04MB8536:EE_|IA3PR04MB9353:EE_
x-ms-office365-filtering-correlation-id: 7d49776b-a2b8-40e7-005e-08dda2361ddd
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?royfTjZP86TnWV42+8Uj/Qq2Bwrh71hM9EWRPisM1+pFzLWDi6wpGNp1b1Yr?=
 =?us-ascii?Q?/jXgydLFdKw8cveKQhx5TvRPydjkbqu1mtCmmpAIQ6WQOFdi2oyLV5nz8ZhZ?=
 =?us-ascii?Q?kDr2+AQZV7WHOB0Dq+gVZgpRCcu/WiGvZVz7vIRA6WF7FqCdp+zwSYG46bO2?=
 =?us-ascii?Q?7+J8LnlljmBFHjshX1wM9MfZeJhqwjNtqFeIub6D5WJCsqzocNsuxQxsdruG?=
 =?us-ascii?Q?XNzAScy92KmUHPFgdeKnMNGkuetp/+6ZdkdFCT8gJOU9koatNr+cEcKD4Qm2?=
 =?us-ascii?Q?pttqiKSscGoaF6k2QEMUYWDOw89zN/jwvuzi6s+SSNeSQ0gRn1frmhiAWW3g?=
 =?us-ascii?Q?1ujfB4UaThXjTmB2OpnwMnU/ozfYWlHKadfyKdcySn8yzRJNMoDZa51Zh2Nz?=
 =?us-ascii?Q?DgQlBxKMDoVqWqr5DHEJcyxIwS+uozg/DdlSyeHJtGJmjNkqhAumeszxyZqq?=
 =?us-ascii?Q?tjyCvvqueeM25AlWuAkCFLb6NmU3UngMg/fzzXY9dac6gyRFVIwRx7XqIe3q?=
 =?us-ascii?Q?5IFuu4z0ttwXvnUloeDVqPyHbk2fP+oz8J+37YFZUG9MZ8I7048PYc7Ym9Lr?=
 =?us-ascii?Q?bNM9wNEWQYNMYzCYOx4tG7mPETr2PYOd9qgcJQSUDwPo0gYd9af1Xrb3Rzch?=
 =?us-ascii?Q?0rwKlgq99+9C+l4juFaXO+o6USZyLzRon19ysx0Fshk6zSUjrORC6EvbbVb+?=
 =?us-ascii?Q?1PUUiGUdAFEp+3NBrXMAja4Kgu77W6R0bIvq2+8EWU7FzvzMkm32r3iOSMiU?=
 =?us-ascii?Q?sarSkKLR9XpnrlivmxWO2f5BIagZ1Du6zl1aAiOlsAIPX06h8zK7CszcPQqP?=
 =?us-ascii?Q?zFtcXpDJbh6IuPhAcTX9nJ4iXvYHNshv51WUj4981laEiWy/V1dPzrOSdSdI?=
 =?us-ascii?Q?N/JsZgW2vT5y2GvNahWoLmTvDNuyxcvSliiN9WyveVPDkFIhNByY5lNfTOzk?=
 =?us-ascii?Q?7VOnUSHf+OpuUYvQjC+IH3eYjQfxJDIAyjilrMTROYAV0srvHw1KMC4FcyUD?=
 =?us-ascii?Q?/6mvGFeryMK9m+I5uJsG8zDLAk1b8ZgoJoT3TPmPNtp72F1CDvy10MiZ2wVm?=
 =?us-ascii?Q?tUFzy4B196zwaSOfk7WlhB058fxEjv4venspSsHEVHyNboaSiA0JZX3nkHDV?=
 =?us-ascii?Q?B3qPZSYwGG7f+0/miNoksnuDDRBQnmfE6wlX3xaO4WyT10/TwawYT0ODxhNa?=
 =?us-ascii?Q?Zot8eWwB7jriYBb1ZDzddDG3D8E0aqBoZgmlhNI5BuhcYiqUSxzRYlkR+e4T?=
 =?us-ascii?Q?03v+np703v1pAkT9a2YZr3sQldjRFSpAC/tA5fTNDmqeElNhK8Fi5UY0BDw/?=
 =?us-ascii?Q?O3pXhFQvuYZ74KSyW7Xg96G29qGpt4sBgygY1MtqTtO9CmIRJSYjYylf+PQJ?=
 =?us-ascii?Q?fkVJGSNAcymSnVSOrtWVyUILX9aVp+a2Wx1FtRLsIKstmpZgp2e38da/d/jk?=
 =?us-ascii?Q?72s5aP/1hxP1msP2w2/ztWFeDWMPo817A4om1iqgqnZNO8gRJ0STulXO0jPZ?=
 =?us-ascii?Q?JiUN6VR8hAGf29s=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR04MB8536.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?WAqosdeS8IwZtLdJ64gv2cDWavRRItO/JqKmzt50w0idG6sKa1WBcFRcS+lj?=
 =?us-ascii?Q?2Nf+yYHcXKBcvwyy9jUlL9KEdUU4nIHWiy0DDgn2BqeZtHKGPvi1w6B3cKk4?=
 =?us-ascii?Q?JxgZ8kzGqYIJqQEW2UKQfh7IRr/BselQWRBGIfhsDL2U9rwkkl1q/gJAmzG7?=
 =?us-ascii?Q?w3qObzEO0IkSc2/ZO0WAoC/7g85wJU2mNDNuUuw3cjB7oMwJwCpRA7oXUcaV?=
 =?us-ascii?Q?Os3XqWnpvjBGQeWMO/uGswQC+InJ8yYyDgbhiHWuIeOkmWMP360LgE3dWh1M?=
 =?us-ascii?Q?ZuYkPzVCB9HuQj7rdTId2i8Ux0OZz5JmHVshcUUHwqySti0vJ06/1TgHAbkx?=
 =?us-ascii?Q?cbyCgg+tsvw1PXCbTcpaN4lXxSbk8X0pLdjiN5qHS8SErBaqHTnZ0uQSYbjM?=
 =?us-ascii?Q?1iPMF1+oj55SJGtiXzRAvtSh5yR9ED3rBKN4zsHlWgYrEaA2gJTn4k1xzpfH?=
 =?us-ascii?Q?SuprNXFZ68PV5LpLw1tFP9la8oAePlg1IDY330GZIFyXmyFhTBa81YZFVsGz?=
 =?us-ascii?Q?IF9jpYciAKpEYQgLHwYosJgKsccVcWlPw60d1ZnnU8Ylgi7BFIFtZ+cf/Iou?=
 =?us-ascii?Q?cciQg2D9P19dODlxcqqHgWTn2z9JkheZYZ+PBo5St/oLVnI5z5INjUqXyBxs?=
 =?us-ascii?Q?KBGGKwwcAx31PRATh6eocvRujRbgN5rSoX25g/JgDTLsdStyzdJsXZR8IDHn?=
 =?us-ascii?Q?M3WyjSJhZ3Slm773UeiYcuPXg9K5C+9dk47DlMfU5XPpF6yzm0ssffitFggL?=
 =?us-ascii?Q?o7pbPhE1oNBpB5PJZcOpsvpjPalrxa3nRdNmxI50n1zfNjt3VIF5pXMSZ3CB?=
 =?us-ascii?Q?uAwvlM2vWCuRsyjnIcfpwN2lUswsyCiWxkyQSZIEtH/IT2NR4kvS+JjlSH3a?=
 =?us-ascii?Q?oOIXNwEndfCmAbKLU0ORv4p7Q6qB4sF/H4VtNTQkZ/++iIKIVMK27uwxmpjH?=
 =?us-ascii?Q?sR2Kgv+hKVf7+ANyKQWfTbRQZxi/HJZT/6jmx5NLZl+CMP4VLDpqZPk5N2UG?=
 =?us-ascii?Q?zeYmsUbei83GBr4O7WMBqulLO0Hh4eWSRuCGh1lIqKhp/s9UfX3o4iYY8EoD?=
 =?us-ascii?Q?QVSr3jAf794LlMfJfxqJhUBnKRH+iy6s7dmnh/t0615QWjgDbmKqPxO/lH3a?=
 =?us-ascii?Q?yBxt6+mkUNRi/zxCJHHE/1pCb06s8DAKJ0lkI8aK2f/Jkp5IduFy8FncA8hY?=
 =?us-ascii?Q?oLoy9RH71q3drRLxAzTUzxdyWlr0xlyYynIxvAnwn5PFFJL2wV3qfYqYZ7fV?=
 =?us-ascii?Q?KsTTG40EAo04m89jp2mS2OJsYz2pmfC2RleT7RvhSV7tnFhUookSL2t/yE6j?=
 =?us-ascii?Q?EfKYd/2sDkor2oh4Vld14eBm9/Ny5mFr04JwnKLY2VMfmPUAsHOBAF+4z14L?=
 =?us-ascii?Q?ig7zanvEoBJlIfh9bZbXe56kAb+HLfNv+cGuanDSmVL/O2x+AA9hk+JjluV1?=
 =?us-ascii?Q?11iErPXd9YOg29ot4sW21ab430AgDXG63iEI8F3VyXneQGXaKWaYkntKNhpt?=
 =?us-ascii?Q?rcD4HTrqcKwQloMUNj3QvGnSHfx6PSXD2Ha8CV98af6iSQh24pKyab8iHm+7?=
 =?us-ascii?Q?rI0IabZgvLEOcFb5gdhD39J0gzPU4eWM3kFW5cVuNeypcuHgOQTtnMA30PL8?=
 =?us-ascii?Q?5TMdCH/qKHUCUOY0yZdwqFc=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <D8173E67F1FC514393E7A0FE7B8300CF@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: RSUi0BnSxxnKGQShI9TKxwQ8VNjsGoAULK58gGxbGvo2RcNw6zFU656TLK+AKzKTr3umwlXMXynn1kFBJycIlr05CLJVGNHSfB0+BPv3z790TMzgDWYoUmpA74Y3nfPnWMmpg9ZWljZMpCfCF4bNKg3bAoFdWk5KjdHw2KyrMvlvGLhEYyIqWk/G5RlkCdzZPPDyPs2xfLvfGPO4huvL8XXQHZKe2gmq8Jw44UJe4nrXOAh3kKBG1n6Qr0evRtKICfZPqjvBxR3C7y1CNT6jfSlO/7vA0qQydborsqAfXDf0AyIoaDabFz6q/uZEmxog6Qzix6rjaGq9viySAA/t2PChSRyhnvotJqEHBQkyqaW1jc4I7jhzTcfimovkZ+rmTwQ0onjYkvqRGHBshwW/Qp23PwRJCv9M/Oj8xRnEvgTy7bbMiSSY5bYBAX2JZbB8CaufwaCtywflmGIEGMNZRyBTcRotVU+oQaIS6OKdghB1KRqeOkpFZTdD97Rr9HShM0xnAPVKkgL/GxRawjhVFTZ0kvpO6mKPOJGqn4tIhpgEJn+Qv9iCbFFbtVeJS6tFPn/7PsU+gFc7RkaOJDzExDvktH7ln2XzucvuQSpkdO8hV/6R7ZK/4gOLT+s45nkS
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR04MB8536.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d49776b-a2b8-40e7-005e-08dda2361ddd
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jun 2025 00:32:26.8847
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: t7q0z3sJHBlkvqG8+kSTAvgtT9Y1FNNNtYkEYhbQaW2tjVCyZsgM6IiVvkrs7MMPQOUwnONeC/TUzotYhR8yNRmCjSdM928P3zrvRCilnIo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR04MB9353
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250602_173232_953092_E03DA5AD 
X-CRM114-Status: GOOD (  20.69  )
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

On May 28, 2025 / 16:05, Hannes Reinecke wrote:
> Add a 'dhchap' keytype to store DH-HMAC-CHAP secret keys.
> Keys are stored with a 'user-type' compatible payload, such
> that one can use 'user_read()' to access the raw contents
> and the 'read()' callback to get the base64-encoded key
> data in the DH-HMAC-CHAP secret representation.
>=20
> Signed-off-by: Hannes Reinecke <hare@kernel.org>
> ---
>  drivers/nvme/common/keyring.c | 266 ++++++++++++++++++++++++++++++++++
>  include/linux/nvme-keyring.h  |  22 ++-
>  2 files changed, 287 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/nvme/common/keyring.c b/drivers/nvme/common/keyring.=
c
> index 32d16c53133b..a58c93c6d495 100644
> --- a/drivers/nvme/common/keyring.c
> +++ b/drivers/nvme/common/keyring.c
[...]
> +static int nvme_dhchap_psk_preparse(struct key_preparsed_payload *prep)
> +{
> +	struct user_key_payload *upayload;
> +	size_t datalen =3D prep->datalen, keylen;
> +	int ret;
> +	u32 crc;
> +	u8 version, hmac;
> +
> +	if (!prep->data) {
> +		pr_debug("%s: Empty data", __func__);
> +		prep->payload.data[0] =3D NULL;
> +		prep->quotalen =3D 0;
> +		return -EINVAL;
> +	}
> +
> +	if (sscanf(prep->data, "DHHC-%01hhu:%02hhu:%*s", &version, &hmac) !=3D =
2) {

I built the kernel at nvme-6.16 branch at git hash bf4d87cba2d7 applying
this series. Then I ran the blktests test case corresponding to this series=
,
and observed the BUG KASAN slab-out-of-bounds below [1].

The sscanf() above has three "%"s in the conversion format string, while it=
 has
two following pointer arguments. I think this gap between the numbers of "%=
"s
and the pointer arguments causes the BUG. I removed "%*s" from the format
string, then the BUG looks disappearing.

[1]

Jun 03 08:48:30 testnode2 unknown: run blktests nvme/064 at 2025-06-03 08:4=
8:30
Jun 03 08:48:30 testnode2 kernel: =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
Jun 03 08:48:30 testnode2 kernel: BUG: KASAN: slab-out-of-bounds in vsscanf=
+0xd55/0x2d20
Jun 03 08:48:30 testnode2 kernel: Read of size 1 at addr ffff888100a5303b b=
y task keyctl/1116
Jun 03 08:48:30 testnode2 kernel:=20
Jun 03 08:48:30 testnode2 kernel: CPU: 1 UID: 0 PID: 1116 Comm: keyctl Not =
tainted 6.15.0-rc3+ #43 PREEMPT(voluntary)=20
Jun 03 08:48:30 testnode2 kernel: Hardware name: QEMU Standard PC (i440FX +=
 PIIX, 1996), BIOS 1.16.3-3.fc41 04/01/2014
Jun 03 08:48:30 testnode2 kernel: Call Trace:
Jun 03 08:48:30 testnode2 kernel:  <TASK>
Jun 03 08:48:30 testnode2 kernel:  dump_stack_lvl+0x6a/0x90
Jun 03 08:48:30 testnode2 kernel:  print_report+0x174/0x554
Jun 03 08:48:30 testnode2 kernel:  ? __virt_addr_valid+0x208/0x430
Jun 03 08:48:30 testnode2 kernel:  ? vsscanf+0xd55/0x2d20
Jun 03 08:48:30 testnode2 kernel:  kasan_report+0xae/0x170
Jun 03 08:48:30 testnode2 kernel:  ? vsscanf+0xd55/0x2d20
Jun 03 08:48:30 testnode2 kernel:  vsscanf+0xd55/0x2d20
Jun 03 08:48:30 testnode2 kernel:  ? __pfx_vsscanf+0x10/0x10
Jun 03 08:48:30 testnode2 kernel:  sscanf+0xac/0xe0
Jun 03 08:48:30 testnode2 kernel:  ? __pfx_sscanf+0x10/0x10
Jun 03 08:48:30 testnode2 kernel:  ? lock_acquire+0x180/0x310
Jun 03 08:48:30 testnode2 kernel:  ? __pfx___might_resched+0x10/0x10
Jun 03 08:48:30 testnode2 kernel:  nvme_dhchap_psk_preparse+0xde/0x5a0 [nvm=
e_keyring]
Jun 03 08:48:30 testnode2 kernel:  ? __pfx_nvme_dhchap_psk_preparse+0x10/0x=
10 [nvme_keyring]
Jun 03 08:48:30 testnode2 kernel:  ? __pfx_down_read+0x1/0x10
Jun 03 08:48:30 testnode2 kernel:  ? avc_has_perm+0xa6/0x160
Jun 03 08:48:30 testnode2 kernel:  ? lock_is_held_type+0x41/0x130
Jun 03 08:48:30 testnode2 kernel:  ? __pfx_avc_has_perm+0x10/0x10
Jun 03 08:48:30 testnode2 kernel:  __key_create_or_update+0x3f1/0xc60
Jun 03 08:48:30 testnode2 kernel:  ? __pfx___key_create_or_update+0x10/0x10
Jun 03 08:48:30 testnode2 kernel:  ? __pfx_lookup_user_key+0x10/0x10
Jun 03 08:48:30 testnode2 kernel:  ? lock_release+0x17d/0x2c0
Jun 03 08:48:30 testnode2 kernel:  key_create_or_update+0x10/0x20
Jun 03 08:48:30 testnode2 kernel:  __do_sys_add_key+0x1e5/0x300
Jun 03 08:48:30 testnode2 kernel:  ? __pfx___do_sys_add_key+0x10/0x10
Jun 03 08:48:30 testnode2 kernel:  ? fput_close_sync+0x100/0x170
Jun 03 08:48:30 testnode2 kernel:  do_syscall_64+0x93/0x190
Jun 03 08:48:30 testnode2 kernel:  ? do_syscall_64+0x9f/0x190
Jun 03 08:48:30 testnode2 kernel:  ? lockdep_hardirqs_on+0x78/0x100
Jun 03 08:48:30 testnode2 kernel:  ? do_syscall_64+0x9f/0x190
Jun 03 08:48:30 testnode2 kernel:  ? kasan_save_track+0x10/0x30
Jun 03 08:48:30 testnode2 kernel:  ? kasan_save_free_info+0x37/0x60
Jun 03 08:48:30 testnode2 kernel:  ? __kasan_slab_free+0x4b/0x70
Jun 03 08:48:30 testnode2 kernel:  ? kfree+0x13a/0x4b0
Jun 03 08:48:30 testnode2 kernel:  ? keyctl_describe_key+0x29c/0x420
Jun 03 08:48:30 testnode2 kernel:  ? do_syscall_64+0x93/0x190
Jun 03 08:48:30 testnode2 kernel:  ? entry_SYSCALL_64_after_hwframe+0x76/0x=
7e
Jun 03 08:48:30 testnode2 kernel:  ? kasan_quarantine_put+0xd8/0x1e0
Jun 03 08:48:30 testnode2 kernel:  ? kasan_quarantine_put+0xd8/0x1e0
Jun 03 08:48:30 testnode2 kernel:  ? lockdep_hardirqs_on+0x78/0x100
Jun 03 08:48:30 testnode2 kernel:  ? kasan_quarantine_put+0xd8/0x1e0
Jun 03 08:48:30 testnode2 kernel:  ? kfree+0x13a/0x4b0
Jun 03 08:48:30 testnode2 kernel:  ? lock_release+0x17d/0x2c0
Jun 03 08:48:30 testnode2 kernel:  ? keyctl_describe_key+0x29c/0x420
Jun 03 08:48:30 testnode2 kernel:  ? key_put+0x25/0x280
Jun 03 08:48:30 testnode2 kernel:  ? syscall_exit_to_user_mode+0x8e/0x280
Jun 03 08:48:30 testnode2 kernel:  ? rcu_is_watching+0x11/0xb0
Jun 03 08:48:30 testnode2 kernel:  ? do_syscall_64+0x9f/0x190
Jun 03 08:48:30 testnode2 kernel:  ? lockdep_hardirqs_on+0x78/0x100
Jun 03 08:48:30 testnode2 kernel:  ? do_syscall_64+0x9f/0x190
Jun 03 08:48:30 testnode2 kernel:  ? lock_release+0x17d/0x2c0
Jun 03 08:48:30 testnode2 kernel:  ? do_user_addr_fault+0x4a2/0xa00
Jun 03 08:48:30 testnode2 kernel:  ? irqentry_exit_to_user_mode+0x84/0x270
Jun 03 08:48:30 testnode2 kernel:  ? rcu_is_watching+0x11/0xb0
Jun 03 08:48:30 testnode2 kernel:  entry_SYSCALL_64_after_hwframe+0x76/0x7e
Jun 03 08:48:30 testnode2 kernel: RIP: 0033:0x7f256cc0b95d
Jun 03 08:48:30 testnode2 kernel: Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00=
 90 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b=
 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 83 64 0f 00 f7 d8 64 =
89 01 48
Jun 03 08:48:30 testnode2 kernel: RSP: 002b:00007ffd307fd8e8 EFLAGS: 000002=
46 ORIG_RAX: 00000000000000f8
Jun 03 08:48:30 testnode2 kernel: RAX: ffffffffffffffda RBX: 00007ffd307fda=
e0 RCX: 00007f256cc0b95d
Jun 03 08:48:30 testnode2 kernel: RDX: 00007ffd307fe63d RSI: 00007ffd307fe6=
18 RDI: 00007ffd307fe611
Jun 03 08:48:30 testnode2 kernel: RBP: 00007ffd307fd8f0 R08: 000000000ae4be=
97 R09: 00007ffd307fd940
Jun 03 08:48:30 testnode2 kernel: R10: 000000000000003b R11: 00000000000002=
46 R12: 00007ffd307fe63d
Jun 03 08:48:30 testnode2 kernel: R13: 000000000000003b R14: 000055e2e6923c=
db R15: 000055e2e69264b8
Jun 03 08:48:30 testnode2 kernel:  </TASK>
Jun 03 08:48:30 testnode2 kernel:=20
Jun 03 08:48:30 testnode2 kernel: Allocated by task 1116:
Jun 03 08:48:30 testnode2 kernel:  kasan_save_stack+0x2c/0x50
Jun 03 08:48:30 testnode2 kernel:  kasan_save_track+0x10/0x30
Jun 03 08:48:30 testnode2 kernel:  __kasan_kmalloc+0xa6/0xb0
Jun 03 08:48:30 testnode2 kernel:  __kvmalloc_node_noprof+0x1c7/0x660
Jun 03 08:48:30 testnode2 kernel:  __do_sys_add_key+0x16d/0x300
Jun 03 08:48:30 testnode2 kernel:  do_syscall_64+0x93/0x190
Jun 03 08:48:30 testnode2 kernel:  entry_SYSCALL_64_after_hwframe+0x76/0x7e
Jun 03 08:48:30 testnode2 kernel:=20
Jun 03 08:48:30 testnode2 kernel: The buggy address belongs to the object a=
t ffff888100a53000
                                   which belongs to the cache kmalloc-64 of=
 size 64
Jun 03 08:48:30 testnode2 kernel: The buggy address is located 0 bytes to t=
he right of
                                   allocated 59-byte region [ffff888100a530=
00, ffff888100a5303b)
Jun 03 08:48:30 testnode2 kernel:=20
Jun 03 08:48:30 testnode2 kernel: The buggy address belongs to the physical=
 page:
Jun 03 08:48:30 testnode2 kernel: page: refcount:0 mapcount:0 mapping:00000=
00000000000 index:0x0 pfn:0x100a53
Jun 03 08:48:30 testnode2 kernel: ksm flags: 0x17ffffc0000000(node=3D0|zone=
=3D2|lastcpupid=3D0x1fffff)
Jun 03 08:48:30 testnode2 kernel: page_type: f5(slab)
Jun 03 08:48:30 testnode2 kernel: raw: 0017ffffc0000000 ffff8881000428c0 ff=
ffea000445e340 dead000000000003
Jun 03 08:48:30 testnode2 kernel: raw: 0000000000000000 0000000080200020 00=
000000f5000000 0000000000000000
Jun 03 08:48:30 testnode2 kernel: page dumped because: kasan: bad access de=
tected
Jun 03 08:48:30 testnode2 kernel:=20
Jun 03 08:48:30 testnode2 kernel: Memory state around the buggy address:
Jun 03 08:48:30 testnode2 kernel:  ffff888100a52f00: 00 fc fc fc 00 fc fc f=
c 00 fc fc fc 00 fc fc fc
Jun 03 08:48:30 testnode2 kernel:  ffff888100a52f80: 00 fc fc fc 00 fc fc f=
c 00 fc fc fc 00 fc fc fc
Jun 03 08:48:30 testnode2 kernel: >ffff888100a53000: 00 00 00 00 00 00 00 0=
3 fc fc fc fc fc fc fc fc
Jun 03 08:48:30 testnode2 kernel:                                         ^
Jun 03 08:48:30 testnode2 kernel:  ffff888100a53080: fa fb fb fb fb fb fb f=
b fc fc fc fc fc fc fc fc
Jun 03 08:48:30 testnode2 kernel:  ffff888100a53100: fa fb fb fb fb fb fb f=
b fc fc fc fc fc fc fc fc
Jun 03 08:48:30 testnode2 kernel: =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
Jun 03 08:48:30 testnode2 kernel: Disabling lock debugging due to kernel ta=
int=

