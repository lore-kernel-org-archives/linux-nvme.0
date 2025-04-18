Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8063CC369AB
	for <linux-nvme@archiver.kernel.org>; Fri, 18 Apr 2025 18:57:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:References:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=An6xYSRfm+JDvuZkQuyTtOw8ylA+QJ9hrUt1wl0Jf3w=; b=u8wpz1EDucKBH90vmnCYzmIbaa
	vVW+iZcUVOUg8tjU5b4KUzkjyXdVa1sN6ArNPsOlxTVnQfy9boG/UeSZFQTCt8fH27CHHLD09uL3J
	KhCRV5iO/L2LP4jNpWI3ZUxwMfgm4IEsvBaEISEaVf7/wLiBl5TMVZgVRoWvl7+joygU2qfD3+ddW
	CGMyxNRXdy5OSJD8LzXrWnjvfOsszZHnDySIegqQkwaqB/aoDkI7KJiBTUWUaLNNHKguWAgkO8GXH
	6i8cw3rFR8BgYpIYmwqrW+fgnP5K0v5sy0t3eXRuA7TFjllWzM72Ysg6qQMVwg1LZIumhmKujDzkb
	dcj4dpXQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u5qtj-0000000HWuq-06FQ;
	Fri, 18 Apr 2025 18:57:11 +0000
Received: from esa6.hgst.iphmx.com ([216.71.154.45])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u5qsR-0000000HWjO-2hv1
	for linux-nvme@lists.infradead.org;
	Fri, 18 Apr 2025 18:55:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1745002551; x=1776538551;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=AoeuOYpJxBT8LH0Vwm0LPO2yyKsEUWUSjOMaXrbSjsE=;
  b=Qe94wQaKTy+IR0NLXhN2El+oFEBLGzcxg2R4I+rKU36ioKFW5wBDV8Ff
   q2Ak1X3AAGFYBCXn4vVniCOV8bfL2VuGGJwkVpVVIFhJQKTPzfT8Umx6r
   K4pcpiM0a/sCFW0ConFUoIzz0EA1c3kkIIAstvc7vlvGQIM/TLjvTzHLr
   I2g14Wgh6ctxklekUr4LyIirAxe4MuZqn848t1iUp/JeNMh6+9WBYsifH
   gnLr5xIHQwPIEaGgm2FbOf7oLtcXF21JzWUr5pN162CWhGIVilfHQrN6R
   AJA5yimyDupgdat9gS95WSr2aUDcUXQr/rb+D3B+RnAj9tLHqQkA2wkwx
   Q==;
X-CSE-ConnectionGUID: KExUTfS7RRW/Q1BAijQHnA==
X-CSE-MsgGUID: K6oGNhp7S6eMYLp23AOjvw==
X-IronPort-AV: E=Sophos;i="6.15,222,1739808000"; 
   d="scan'208";a="81727570"
Received: from mail-northcentralusazlp17012055.outbound.protection.outlook.com (HELO CH5PR02CU005.outbound.protection.outlook.com) ([40.93.20.55])
  by ob1.hgst.iphmx.com with ESMTP; 19 Apr 2025 02:55:47 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BFiwEvK4pDc+nTu95pMs23HLY4cK/IC529dzajc3wltwXXKNjtqR+YR+TIzmboJdUg8wrsLTanFGLJM9QkZDAXyU/ixeoWNNvSloDgCdDGBkpgvWhrLH+JDu0U9fGdEB6B/dnFn072bEoXk4y1+Rd8XDBUAqqM1xGoKbEvfqye633UyGF6WCj3binlfGjcBTikbR1NNLN44DNWem1CIIiH12oe87AI9PgAynzKvBIcXlVWGwRPLCubWY8l1q7t/d9O2WmP0FlhzNzzErEtsC1amCvjLOWbx60KQuoABVtZ7N5rt2ZXvVgqY7IxyX4kZabEepvoctVjDvmNOYWmjAIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=An6xYSRfm+JDvuZkQuyTtOw8ylA+QJ9hrUt1wl0Jf3w=;
 b=NmVWHlBmiihaC4g6CjQSVt8f0QaYhsT/7x5Jm7vjMp4jS+pqGkxC4vDPMzI1QuYd92cucEP9B6UTgrq6u+uz+1+lX60Q7j546bYP8cNJZX26c+MWw8/EbdWOKIHhNGFyK1154y4/48YxuxqmrJTthJYrWiRGwUrFdm5ueyg10GiXrqs1Wogql4lwZSEEAM/PmC+LOO6Mat/3Nx+mAOU7jBR4+Ed8VYByZJq09oRxme1ytaim1UJo67z+7dKKoVnXf9FxWqXuXwOPejEuA/m6aWtyQ2FpZ2bcoxOZboTY6m4vlq8LmHysktj13JtxSpQRMRUO2wpz+TJ1JEHKYknQbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=An6xYSRfm+JDvuZkQuyTtOw8ylA+QJ9hrUt1wl0Jf3w=;
 b=gWftyEJOFmMq9fssA2l/KstMuovrwkC1C/mDgvP+gq4h82tYFGgzCplqlxB//jY6FESj7P1zL6m7CeA16z3QmRKe5Eow4LJpTlGdZeouOQxY605byHQDHhxO+yv5ryVZuFLn+pXHyQzwVHnG5joqM9gE/ST5WuLx+dFvNY/rTRY=
Received: from BY5PR04MB6849.namprd04.prod.outlook.com (2603:10b6:a03:228::17)
 by SN7PR04MB8570.namprd04.prod.outlook.com (2603:10b6:806:32c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.33; Fri, 18 Apr
 2025 18:55:43 +0000
Received: from BY5PR04MB6849.namprd04.prod.outlook.com
 ([fe80::b2a6:2bbf:ed0a:7320]) by BY5PR04MB6849.namprd04.prod.outlook.com
 ([fe80::b2a6:2bbf:ed0a:7320%6]) with mapi id 15.20.8655.029; Fri, 18 Apr 2025
 18:55:43 +0000
From: Kamaljit Singh <Kamaljit.Singh1@wdc.com>
To: Sagi Grimberg <sagi@grimberg.me>, Hannes Reinecke <hare@suse.de>, Hannes
 Reinecke <hare@kernel.org>, hch <hch@lst.de>
CC: Keith Busch <kbusch@kernel.org>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>, Chris Leech <cleech@redhat.com>
Subject: Re: [PATCH 3/3] nvme-tcp: fix I/O stalls on congested sockets
Thread-Topic: [PATCH 3/3] nvme-tcp: fix I/O stalls on congested sockets
Thread-Index: AQHbpGZdo3Xoo5WOcUmvA6U4U0rVxbOkYTuAgADyiwCAAK1uAIAA7l0AgAGfxuqAAMd3AIAAeGp0
Date: Fri, 18 Apr 2025 18:55:43 +0000
Message-ID: <BY5PR04MB6849262F5822EC7132BE7414BCBF2@BY5PR04MB6849.namprd04.prod.outlook.com>
References: <20250403065522.90807-1-hare@kernel.org>
 <20250403065522.90807-4-hare@kernel.org>
 <1edc23f5-eb48-4006-a2f4-d303b05bd3e0@suse.de>
 <e7371b8a-e0b3-4387-a941-292e1f46b2aa@grimberg.me>
 <5446ef17-d922-4467-9a3c-5001713cc260@suse.de>
 <dac1d594-cf64-41ce-8a23-4b246db75b83@grimberg.me>
 <BY5PR04MB684996C1DB38F3BC4386B55EBCBC2@BY5PR04MB6849.namprd04.prod.outlook.com>
 <ee011198-9a15-44e5-a18e-02d3844ee48b@grimberg.me>
In-Reply-To: <ee011198-9a15-44e5-a18e-02d3844ee48b@grimberg.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY5PR04MB6849:EE_|SN7PR04MB8570:EE_
x-ms-office365-filtering-correlation-id: b7e95780-e0f1-436c-41d3-08dd7eaa9f0f
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?jywRQgydICNl1YvcFuWR75VbAN08w2DF0hOCV0anXgdas/OxF5+OAUuU9d?=
 =?iso-8859-1?Q?bBha5HFkNDQzzN5+7AOW4GHPXEIFTr3hzT42AsTaathWgqmekWr6+y/zIH?=
 =?iso-8859-1?Q?xIgBicyioIF14BqY6/rxFb0ZRV0S1SVwmic6L5zaumzZScOS2t3vdSdMy4?=
 =?iso-8859-1?Q?K4SEMSRUR8h8rHG1vS10OWodJXr/gPOMkBT5wuR1URwJrdqH1sG7T8k+0H?=
 =?iso-8859-1?Q?79EaOTY4eBOD9KWM9vDMT/ZLgBI4dFYeuWGjLdXYVlAPsyxGyvb1RQcbqa?=
 =?iso-8859-1?Q?yjpT/Kz0kjfoDvZjSE/p0y5pFlMNvV8m9TQV0aOJ/RK+mJjfs8xQhn/+2f?=
 =?iso-8859-1?Q?l0FZ57N4QCCcfOZOv4W+uVzm9EJDQPRQBlSVm3VBK0SPWuh82lynRAYiYD?=
 =?iso-8859-1?Q?Il4R6UQLDmEmHsHbqBS5S2eaIscfMJPEoBYMR2rctSYGZUZpkq9KfwfwXA?=
 =?iso-8859-1?Q?KDdNKZ0qyTIeVTqvUklNoqMxidWJPwkURb97LuXeBsDW6eFBzc9Jn5VUtU?=
 =?iso-8859-1?Q?yZUtWstm+RBN3H8Ot/bQVUgNQlV26NNVhuhdfcKDBi1BUYFlZN6chMkjOT?=
 =?iso-8859-1?Q?KtimH3rrEGxF/plQT/9GBSfXQ9xR8lf/rqZw8A5qkM9KNT0b6otncSf3YT?=
 =?iso-8859-1?Q?mBZ5bVqjwiop+Rqj5LsAwEDLPYNfhAumPzPKgvwP8ZpVlqTi9YxqQVdPej?=
 =?iso-8859-1?Q?d3JPpbI4QoABUZtHWbLMflrsPVrHjwvuTzEYHunTAL+o5U+PM5fXQSfhv5?=
 =?iso-8859-1?Q?3tSdV4xiq8Glm9QcKCerfm4kLrUP6n/2cfvn8Z/eINYWbFas1XbH+Eau2J?=
 =?iso-8859-1?Q?hjNdoTadot/dSOhjmx2CuNVydhbBpUZGqsYNcUqm7hfR+fhIn36uqlObxk?=
 =?iso-8859-1?Q?ipOeTuSjT9OMGIxkMl4gC1n7TV1gozfknW7KGaQbXmQk7dZliB+kpFPK/F?=
 =?iso-8859-1?Q?L/95SdknPdbNIBsuBwp1aUgLrxIqvs3WPtrwWip09GJT4D98l4yS3YyrY3?=
 =?iso-8859-1?Q?RgAgTMzKBRIWB+kt/cic9FsmF4/HHnqS/RJCXdNhl2iqrAqkPK7O8AHOqc?=
 =?iso-8859-1?Q?ci1sbss6I4sw3bGfrX8dk18KdGTZHFxwaKB+1LGDoxCac36NYRwNjaokqc?=
 =?iso-8859-1?Q?KVEeZ+h55rS2WOPpsxNoJ5+qAm10PPLHSfYJXVJkPnCRjcnhtH+n1UzsUO?=
 =?iso-8859-1?Q?lawDkngrDNQ5jCR0zPASKFKp6NdOwGdszGUkemlHxS0uzpi9ggOhaaRcVc?=
 =?iso-8859-1?Q?ADl51FuL0YYWMyoNL1uH6CD8apwmPr9QRDWy1Odngcg3TLgR9MZtk6Y7Np?=
 =?iso-8859-1?Q?TygC4AhaNuYxaujKyOL0oPQ7j/HvXCsR92Z1nDICnR7XAbKGQY4yLfIb5q?=
 =?iso-8859-1?Q?YNNwaIPBt0BpgdJjLMkiooJyR/S+bEFQ0qZa7SNJZXtZRWkdlv/DyVW/fE?=
 =?iso-8859-1?Q?iizxo/2TfJoW3Rh3Daem+7TIauMUdLwquhbUxlBcuDeKzg0m9dlulLochC?=
 =?iso-8859-1?Q?BtwNLYJROPOKp03NCuVo4Ju24LKEcVG8h7dAiYn2qqhcbpFFeX0xNQozyF?=
 =?iso-8859-1?Q?ykaxelQ=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR04MB6849.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?H1a6xCG/qYZgLU5GCg1YVuBq1pxMOHOsdkHwv4CyJI96Y3vMWduPpsDatt?=
 =?iso-8859-1?Q?xvXuURmnJjK0kNnPFa+FQWOZmDOVYZPdOnDGG2nv+BDnRLmQ0ja1+vlkaf?=
 =?iso-8859-1?Q?M5cCdZq5Gog/4pi8VifwSAXwwilmwBCtLiABHYocycQCeWiVxqrRusR6Vq?=
 =?iso-8859-1?Q?9dNy+TkHR1kioAyVqfS5drhm4MAZnje7gtdnavxWpWCzlW0TPSdsKcswAS?=
 =?iso-8859-1?Q?T3XmjQkXqNzudE9XTmh1ND/jPJg/p/tM+rbpcmF2spCPlFQHpJ0NIeRtDO?=
 =?iso-8859-1?Q?AJDd4TOqF0pn+Y4H6qKbZasHa/0ElNB1JEzxINX7AIBafUaUobIfw4h8cc?=
 =?iso-8859-1?Q?wipTO+n+ipbX/vGlJ7aFC1+b4HrwR3ohF3/SiCcmzgwkojm0SGR6Z6eJjL?=
 =?iso-8859-1?Q?8ADMmm1WP1KfpKyg5DebLoE4xFrqgQbOdeGv0WMkH85fq+hknlvyKducw9?=
 =?iso-8859-1?Q?QqTNLK9hfO9rt18ndajzxT6P0Jz/aSVJifB4wnOihhd2sm2rxNA80mQlJC?=
 =?iso-8859-1?Q?BISeeJPU+/iEDZ+V3F8JbJlnl1Ycq1wrM5rB2D25BCqco2xA52QXGCWrEu?=
 =?iso-8859-1?Q?IcXR76j3kJeU7E+Z+yuC6c+Ff2FsxI3wPedaq4rJuVm6oJK0yG/2dt+5Fr?=
 =?iso-8859-1?Q?h1LDzezC5UN6nBv9EzBVXKg92aAK/EyU01wsGeveKDiZccB+VuuiQKRDik?=
 =?iso-8859-1?Q?C9v6+BpA/GDjuKqdZpz754EmKyY+TXznLast9DLC/yXMiSPhgokPXr8FVx?=
 =?iso-8859-1?Q?CWOYELNOCM7D4M99vhgLXQ+OG6Vt9ggpl81GvvisDTZwJet4k/Exs89lIK?=
 =?iso-8859-1?Q?HPmeL5XyiU5h2KS7YOX1hV4nDOeBWqiiFI9ZhXWmjQ7a3erKvNAL9HLoI+?=
 =?iso-8859-1?Q?HTpvC0oQWHkYhtyC168ltk7/QVvZTsQYnEuf+3b+EWmHnzIvT7rX2YeU0+?=
 =?iso-8859-1?Q?9UzYh0n35hDWzfhhVaOZDy5UhiAsE9xFYcm50hQqun+s/+BDdAsUpS+Bik?=
 =?iso-8859-1?Q?6ZvkeIvWsoY3eOwwEK82RxtyTXimxFKLeXDFW76hy7s5pKlkLmQAoWGZSB?=
 =?iso-8859-1?Q?/OCZsOTYkwSqg60PYTvkowXrgwu3RdDqg1RHSHMs95MyhczTeh9tD4NKz1?=
 =?iso-8859-1?Q?gcD5DSkVj4s8Bgre0AAbN0ReZGi8zHv7aGTvpqgAMRdh3l2jqE7ijp1poE?=
 =?iso-8859-1?Q?KeZhNg/JXhrTwQ13MIznKpUL5j8fDwhhMLNKAKLcF+EQTaiYMGKCJONkm+?=
 =?iso-8859-1?Q?9JBS6eX6yhPN9/QKEGsyN9/QEtII0/sSyBOGhCfNjKRoIZJKTGSgLL9zgm?=
 =?iso-8859-1?Q?zbWf6zzPqOPYkCQWqRJLDLHGtG2pBoRK+MqAruVRJ5WeYb3ztg8UznNhr4?=
 =?iso-8859-1?Q?zEF7OcReDpMad4kdP86T7N6k4dunQgZg5uDZTdbUNVmjB+c86ljpB/VuA0?=
 =?iso-8859-1?Q?vfCl86e9B63dOXxyysqU30ZRP945N/PNupB6gvfeeEssq11AaS3OwpXjEJ?=
 =?iso-8859-1?Q?4yPACv+s1NgXtdLMcukRKA2FO1gmS1sPhvycjzn1//vTwmY9ITlMxF1hGL?=
 =?iso-8859-1?Q?zuHWKTUOcz4T8IJbGeXTugTapzejKyNiLs9lKzdPk8mYaJkXGfwfBE5YSL?=
 =?iso-8859-1?Q?Px+wk7pFxXmZfGjJp7D0kTcM3U1wwJv9sh?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 3rfEO34bbyoGwj89FzYE+j/j2slJF2E+3Z2o8CodUgjiAWZtS4zstlQXnEWx8GKKwePUnmLwESIdqn4f95Yqe40Zm2C7rjkEPEM+6g7Mzog6okSaxzpX9YdXgjjLkDMnW9A+94XrqnZBsOV47sh96a7MXbpMnUU0FnXlOT30fkt27F9NYekHlmnrUrtdOnHqmxzZK3XaTRdnB/jwPJ2lCd1iExhDMaRsiPbTrpobqZHLJVQ6WX4OVrivnpnvst+Ai0wYZ+/DEJpAnTAMwi83k6AaAuuRYqnuPRc0UxkOPvqATRcKzjpBIIZQzkWa3WOjoYMYGR3fewRSPyhHN+wjRJbNIiOWc+73Qb7uVA2n+Qr9oQucVIOg9zCW06xxsQpmX+RpBg0cO4jInP84kS95ZYk9M+OsAN95rZDf7LyZdkSe45Ofbp1tB3hu/CLYzuzT+zM/Peh5QMNE5eRkKgSfqIirhnCF/wzRo91v6Fajd1xdvebtK12vUhKXRo1VHAgglgHffdCgDGD6wIhWquALOqTKmLfMIT7oEO2qi9tixJpDMvOVPy1StYVHgyJHLKFzc34QiBWZrgXWNzolUK0RSheuMNfr+81fR8c6JDe6yGB3DR/MkiUO0CbpCv9K6ZEe
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR04MB6849.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7e95780-e0f1-436c-41d3-08dd7eaa9f0f
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Apr 2025 18:55:43.4209
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EchQLkTwZ5wW3SVn6mWHzABwRgv1zlVzCtjawIzibpQ5IeDZaQH2m2xZiYEROubMtR4auU1/8KsiVUgVZ55PlQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR04MB8570
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250418_115551_841975_8D4024F6 
X-CRM114-Status: GOOD (  19.05  )
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

Sagi,=0A=
=0A=
From: Sagi Grimberg <sagi@grimberg.me>=0A=
Date: Friday, April 18, 2025 at 03:51=0A=
>> Sagi,=0A=
>> I tried both of these patches but looks like #1 causes an infinite loop.=
 dmesg was full of panics.=0A=
>> I had tried just #1 and later with #1+#2. Both failed the same way.=0A=
=0A=
>That's no good :)=0A=
=0A=
>Can you share the panics? This version should be identical to what=0A=
>Hannes introduced in:=0A=
Sorry, I'm posting ~200 lines at the bottom, starting from the beginning of=
 the panic until the next "---cut here---". I can send the whole dmesg as a=
ttachment as well. Please let me know.=0A=
=0A=
The patches I applied are these:=0A=
1: nvme-tcp: partial write tcp-q-wake-sender untested by Sagi=0A=
2: nvme-tcp: recv-side EAGAIN untested fix by Sagi=0A=
3: nvme-tcp: fix I/O stalls on congested sockets=0A=
4: nvme-tcp: sanitize request list handling=0A=
5: nvme-tcp: avoid inline sending when handling R2T PDUs=0A=
6: tls: use independent record sz for data sends  <--- this is my internal/=
temp fix for a TLS send issue we found =0A=
You can probably ignore #6.=0A=
=0A=
=0A=
=0A=
=0A=
[1] nvme-tcp: partial write tcp-q-wake-sender untested by Sagi=0A=
diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c=0A=
index 1839d2110c0d..12a790b534aa 100644=0A=
--- a/drivers/nvme/host/tcp.c=0A=
+++ b/drivers/nvme/host/tcp.c=0A=
@@ -129,6 +129,7 @@ enum nvme_tcp_queue_flags {=0A=
        NVME_TCP_Q_LIVE         =3D 1,=0A=
        NVME_TCP_Q_POLLING      =3D 2,=0A=
        NVME_TCP_Q_IO_CPU_SET   =3D 3,=0A=
+       NVME_TCP_Q_WAKE_SENDER  =3D 4,=0A=
 };=0A=
=0A=
 enum nvme_tcp_recv_state {=0A=
@@ -1074,6 +1075,7 @@ static void nvme_tcp_write_space(struct sock *sk)=0A=
        queue =3D sk->sk_user_data;=0A=
        if (likely(queue && sk_stream_is_writeable(sk))) {=0A=
                clear_bit(SOCK_NOSPACE, &sk->sk_socket->flags);=0A=
+               set_bit(NVME_TCP_Q_WAKE_SENDER, &queue->flags);=0A=
                queue_work_on(queue->io_cpu, nvme_tcp_wq, &queue->io_work);=
=0A=
        }=0A=
        read_unlock_bh(&sk->sk_callback_lock);=0A=
@@ -1368,6 +1370,7 @@ static void nvme_tcp_io_work(struct work_struct *w)=
=0A=
                container_of(w, struct nvme_tcp_queue, io_work);=0A=
        unsigned long deadline =3D jiffies + msecs_to_jiffies(1);=0A=
=0A=
+       clear_bit(NVME_TCP_Q_WAKE_SENDER, &queue->flags);=0A=
        do {=0A=
                bool pending =3D false;=0A=
                int result;=0A=
@@ -1387,10 +1390,15 @@ static void nvme_tcp_io_work(struct work_struct *w)=
=0A=
                else if (unlikely(result < 0) && result !=3D -EAGAIN)=0A=
                        return;=0A=
=0A=
-               if (nvme_tcp_queue_has_pending(queue))=0A=
+               /* did we get some space after spending time in recv ? */=
=0A=
+               if (nvme_tcp_queue_has_pending(queue) &&=0A=
+                       sk_stream_is_writeable(queue->sock->sk))=0A=
                        pending =3D true;=0A=
=0A=
-               if (!pending || !queue->rd_enabled)=0A=
+               if (!queue->rd_enabled)=0A=
+                       return;=0A=
+=0A=
+               if (!pending && !test_bit(NVME_TCP_Q_WAKE_SENDER, &queue->f=
lags))=0A=
                        return;=0A=
=0A=
        } while (!time_after(jiffies, deadline)); /* quota is exhausted */=
=0A=
=0A=
[2]     nvme-tcp: recv-side EAGAIN untested fix by Sagi=0A=
diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c=0A=
index d3f12b17e68e..1839d2110c0d 100644=0A=
--- a/drivers/nvme/host/tcp.c=0A=
+++ b/drivers/nvme/host/tcp.c=0A=
@@ -1359,7 +1359,7 @@ static int nvme_tcp_try_recv(struct nvme_tcp_queue *q=
ueue)=0A=
        queue->nr_cqe =3D 0;=0A=
        consumed =3D sock->ops->read_sock(sk, &rd_desc, nvme_tcp_recv_skb);=
=0A=
        release_sock(sk);=0A=
-       return consumed;=0A=
+       return consumed =3D=3D -EAGAIN ? 0 : consumed;=0A=
 }=0A=
=0A=
 static void nvme_tcp_io_work(struct work_struct *w)=0A=
=0A=
=0A=
[3]     nvme-tcp: fix I/O stalls on congested sockets (by Hannes R.)=0A=
=0A=
    When the socket is busy processing nvme_tcp_try_recv() might=0A=
    return -EAGAIN, but this doesn't automatically imply that=0A=
    the sending side is blocked, too.=0A=
    So check if there are pending requests once nvme_tcp_try_recv()=0A=
    returns -EAGAIN and continue with the sending loop to avoid=0A=
    I/O stalls.=0A=
=0A=
diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c=0A=
index 4647d5d547f8..d3f12b17e68e 100644=0A=
--- a/drivers/nvme/host/tcp.c=0A=
+++ b/drivers/nvme/host/tcp.c=0A=
@@ -1384,9 +1384,12 @@ static void nvme_tcp_io_work(struct work_struct *w)=
=0A=
                result =3D nvme_tcp_try_recv(queue);=0A=
                if (result > 0)=0A=
                        pending =3D true;=0A=
-               else if (unlikely(result < 0))=0A=
+               else if (unlikely(result < 0) && result !=3D -EAGAIN)=0A=
                        return;=0A=
=0A=
+               if (nvme_tcp_queue_has_pending(queue))=0A=
+                       pending =3D true;=0A=
+=0A=
                if (!pending || !queue->rd_enabled)=0A=
                        return;=0A=
=0A=
=0A=
[4]         nvme-tcp: sanitize request list handling=0A=
=0A=
    Validate the request in nvme_tcp_handle_r2t() to ensure it's not=0A=
    part of any list, otherwise a malicious R2T PDU might inject a=0A=
    loop in request list processing.=0A=
=0A=
diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c=0A=
index 40dce5dc3ff5..4647d5d547f8 100644=0A=
--- a/drivers/nvme/host/tcp.c=0A=
+++ b/drivers/nvme/host/tcp.c=0A=
@@ -455,6 +455,7 @@ nvme_tcp_fetch_request(struct nvme_tcp_queue *queue)=0A=
        }=0A=
=0A=
        list_del(&req->entry);=0A=
+       init_llist_node(&req->lentry);=0A=
        return req;=0A=
 }=0A=
=0A=
@@ -562,6 +563,8 @@ static int nvme_tcp_init_request(struct blk_mq_tag_set =
*set,=0A=
        req->queue =3D queue;=0A=
        nvme_req(rq)->ctrl =3D &ctrl->ctrl;=0A=
        nvme_req(rq)->cmd =3D &pdu->cmd;=0A=
+       init_llist_node(&req->lentry);=0A=
+       INIT_LIST_HEAD(&req->entry);=0A=
=0A=
        return 0;=0A=
 }=0A=
@@ -773,8 +776,12 @@ static int nvme_tcp_handle_r2t(struct nvme_tcp_queue *=
queue,=0A=
=0A=
        nvme_tcp_setup_h2c_data_pdu(req);=0A=
=0A=
+       WARN_ON(queue->request =3D=3D req);=0A=
+       WARN_ON(llist_on_list(&req->lentry));=0A=
+       WARN_ON(!list_empty(&req->entry));=0A=
        llist_add(&req->lentry, &queue->req_list);=0A=
-       queue_work_on(queue->io_cpu, nvme_tcp_wq, &queue->io_work);=0A=
+       if (list_empty(&queue->send_list))=0A=
+               queue_work_on(queue->io_cpu, nvme_tcp_wq, &queue->io_work);=
=0A=
=0A=
        return 0;=0A=
 }=0A=
@@ -2632,6 +2639,8 @@ static void nvme_tcp_submit_async_event(struct nvme_c=
trl *arg)=0A=
        ctrl->async_req.offset =3D 0;=0A=
        ctrl->async_req.curr_bio =3D NULL;=0A=
        ctrl->async_req.data_len =3D 0;=0A=
+       init_llist_node(&ctrl->async_req.lentry);=0A=
+       INIT_LIST_HEAD(&ctrl->async_req.entry);=0A=
=0A=
        nvme_tcp_queue_request(&ctrl->async_req, true);=0A=
 }=0A=
=0A=
=0A=
[5]     nvme-tcp: avoid inline sending when handling R2T PDUs  (by Hannes R=
.)=0A=
=0A=
    When handling an R2T PDU we should not attempt to send consecutive=0A=
    PDUs as we are running from an softirq context, and sending PDUs=0A=
    from the receive context will mess up latencies.=0A=
    So just queue it and let the io_work workqueue function do the work.=0A=
=0A=
diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c=0A=
index 14047b23a559..40dce5dc3ff5 100644=0A=
--- a/drivers/nvme/host/tcp.c=0A=
+++ b/drivers/nvme/host/tcp.c=0A=
@@ -405,7 +405,7 @@ static inline bool nvme_tcp_queue_more(struct nvme_tcp_=
queue *queue)=0A=
 }=0A=
=0A=
 static inline void nvme_tcp_queue_request(struct nvme_tcp_request *req,=0A=
-               bool sync, bool last)=0A=
+               bool last)=0A=
 {=0A=
        struct nvme_tcp_queue *queue =3D req->queue;=0A=
        bool empty;=0A=
@@ -419,7 +419,7 @@ static inline void nvme_tcp_queue_request(struct nvme_t=
cp_request *req,=0A=
         * are on the same cpu, so we don't introduce contention.=0A=
         */=0A=
        if (queue->io_cpu =3D=3D raw_smp_processor_id() &&=0A=
-           sync && empty && mutex_trylock(&queue->send_mutex)) {=0A=
+           empty && mutex_trylock(&queue->send_mutex)) {=0A=
                nvme_tcp_send_all(queue);=0A=
                mutex_unlock(&queue->send_mutex);=0A=
        }=0A=
@@ -772,7 +772,9 @@ static int nvme_tcp_handle_r2t(struct nvme_tcp_queue *q=
ueue,=0A=
        req->ttag =3D pdu->ttag;=0A=
=0A=
        nvme_tcp_setup_h2c_data_pdu(req);=0A=
-       nvme_tcp_queue_request(req, false, true);=0A=
+=0A=
+       llist_add(&req->lentry, &queue->req_list);=0A=
+       queue_work_on(queue->io_cpu, nvme_tcp_wq, &queue->io_work);=0A=
=0A=
        return 0;=0A=
 }=0A=
@@ -2631,7 +2633,7 @@ static void nvme_tcp_submit_async_event(struct nvme_c=
trl *arg)=0A=
        ctrl->async_req.curr_bio =3D NULL;=0A=
        ctrl->async_req.data_len =3D 0;=0A=
=0A=
-       nvme_tcp_queue_request(&ctrl->async_req, true, true);=0A=
+       nvme_tcp_queue_request(&ctrl->async_req, true);=0A=
 }=0A=
=0A=
 static void nvme_tcp_complete_timed_out(struct request *rq)=0A=
@@ -2783,7 +2785,7 @@ static blk_status_t nvme_tcp_queue_rq(struct blk_mq_h=
w_ctx *hctx,=0A=
=0A=
        nvme_start_request(rq);=0A=
=0A=
-       nvme_tcp_queue_request(req, true, bd->last);=0A=
+       nvme_tcp_queue_request(req, bd->last);=0A=
=0A=
        return BLK_STS_OK;=0A=
 }=0A=
=0A=
=0A=
[6] tls: use independent record sz for data sends (by Kamaljit)=0A=
=0A=
Author: Kamaljit Singh <kamaljit.singh1@wdc.com>=0A=
Date:   Wed Apr 9 15:11:54 2025 -0700=0A=
=0A=
    tls: use independent record sz for data sends=0A=
=0A=
    [Hack] send data to use a smaller default value of 4096 instead of the=
=0A=
    common macro TLS_MAX_PAYLOAD_SIZE, which applies to both directions.=0A=
=0A=
    Add a new user configurable parameter max_send_record_bytes to allow=0A=
    testing with different values other than 4096 bytes.=0A=
=0A=
diff --git a/net/tls/tls_device.c b/net/tls/tls_device.c=0A=
index f672a62a9a52..968dde6848ad 100644=0A=
--- a/net/tls/tls_device.c=0A=
+++ b/net/tls/tls_device.c=0A=
@@ -55,6 +55,8 @@ static DEFINE_SPINLOCK(tls_device_lock);=0A=
=0A=
 static struct page *dummy_page;=0A=
=0A=
+extern unsigned int max_send_record_bytes;=0A=
+=0A=
 static void tls_device_free_ctx(struct tls_context *ctx)=0A=
 {=0A=
        if (ctx->tx_conf =3D=3D TLS_HW)=0A=
@@ -459,7 +461,7 @@ static int tls_push_data(struct sock *sk,=0A=
        /* TLS_HEADER_SIZE is not counted as part of the TLS record, and=0A=
         * we need to leave room for an authentication tag.=0A=
         */=0A=
-       max_open_record_len =3D TLS_MAX_PAYLOAD_SIZE +=0A=
+       max_open_record_len =3D max_send_record_bytes +=0A=
                              prot->prepend_size;=0A=
        do {=0A=
                rc =3D tls_do_allocation(sk, ctx, pfrag, prot->prepend_size=
);=0A=
diff --git a/net/tls/tls_main.c b/net/tls/tls_main.c=0A=
index cb86b0bf9a53..6f2c42e5b603 100644=0A=
--- a/net/tls/tls_main.c=0A=
+++ b/net/tls/tls_main.c=0A=
@@ -52,6 +52,11 @@ MODULE_DESCRIPTION("Transport Layer Security Support");=
=0A=
 MODULE_LICENSE("Dual BSD/GPL");=0A=
 MODULE_ALIAS_TCP_ULP("tls");=0A=
=0A=
+unsigned int max_send_record_bytes =3D 4096;=0A=
+module_param(max_send_record_bytes, uint, 0644);=0A=
+MODULE_PARM_DESC(max_send_record_bytes , " max send record size in bytes (=
default 4096)");=0A=
+EXPORT_SYMBOL_GPL(max_send_record_bytes);=0A=
+=0A=
 enum {=0A=
        TLSV4,                                                             =
                   =0A=
        TLSV6,=0A=
diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c=0A=
index 914d4e1516a3..45486773ad07 100644=0A=
--- a/net/tls/tls_sw.c=0A=
+++ b/net/tls/tls_sw.c=0A=
@@ -48,6 +48,8 @@=0A=
 #include "tls.h"=0A=
=0A=
+extern unsigned int max_send_record_bytes;=0A=
+=0A=
 struct tls_decrypt_arg {                                                  =
                   struct_group(inargs,=0A=
        bool zc;=0A=
@@ -1059,7 +1061,7 @@ static int tls_sw_sendmsg_locked(struct sock *sk, str=
uct msghdr *msg,=0A=
                orig_size =3D msg_pl->sg.size;=0A=
                full_record =3D false;                                     =
                             try_to_copy =3D msg_data_left(msg);=0A=
-               record_room =3D TLS_MAX_PAYLOAD_SIZE - msg_pl->sg.size;=0A=
+               record_room =3D max_send_record_bytes  - msg_pl->sg.size;=
=0A=
                if (try_to_copy >=3D record_room) {=0A=
                        try_to_copy =3D record_room;=0A=
                        full_record =3D true;=0A=
=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=0A=
Snapshot of panic messages:=0A=
=0A=
...=0A=
[2025-04-16 22:55:32.992] [Wed Apr 16 22:55:34 2025] nvme nvme0: QID 0x0: t=
raddr=3D10.10.10.223,trsvcid=3D4420,sport=3D0x8ac6,dport=3D0x1144=0A=
[2025-04-16 22:55:33.445] [Wed Apr 16 22:55:34 2025] nvme nvme0: D3 entry l=
atency set to 16 seconds=0A=
[2025-04-16 22:55:33.898] [Wed Apr 16 22:55:35 2025] nvme nvme0: queue_size=
 128 > ctrl sqsize 17, clamping down=0A=
[2025-04-16 22:55:33.929] [Wed Apr 16 22:55:35 2025] nvme nvme0: creating 3=
 I/O queues.=0A=
[2025-04-16 22:55:35.398] [Wed Apr 16 22:55:36 2025] nvme nvme0: mapped 3/0=
/0 default/read/poll queues.=0A=
[2025-04-16 22:55:35.445] [Wed Apr 16 22:55:36 2025] nvme nvme0: QID 0x1: t=
raddr=3D10.10.10.223,trsvcid=3D4420,sport=3D0x8ac8,dport=3D0x1144=0A=
[2025-04-16 22:55:35.508] [Wed Apr 16 22:55:36 2025] nvme nvme0: QID 0x2: t=
raddr=3D10.10.10.223,trsvcid=3D4420,sport=3D0x8ad4,dport=3D0x1144=0A=
[2025-04-16 22:55:35.554] [Wed Apr 16 22:55:36 2025] nvme nvme0: QID 0x3: t=
raddr=3D10.10.10.223,trsvcid=3D4420,sport=3D0x8ad8,dport=3D0x1144=0A=
[2025-04-16 22:55:35.632] [Wed Apr 16 22:55:37 2025] nvme nvme0: new ctrl: =
NQN "nqn.2015-09.com.wdc:nvme.1", addr 10.10.10.223:4420, hostnqn: nqn.2014=
-08.org.nvmexpress:host.0=0A=
[2025-04-16 22:55:36.195] [Wed Apr 16 22:55:37 2025] nvme nvme0: Failed to =
get ANA log: 16386=0A=
[2025-04-16 22:55:43.023]=0A=
[2025-04-16 22:55:43.492]=0A=
[2025-04-16 22:56:24.758] [Wed Apr 16 22:56:26 2025] ------------[ cut here=
 ]------------=0A=
[2025-04-16 22:56:24.758] [Wed Apr 16 22:56:26 2025] WARNING: CPU: 22 PID: =
134878 at tcp.c:782 nvme_tcp_recv_skb+0x115e/0x11c0 [nvme_tcp]=0A=
[2025-04-16 22:56:24.758] [Wed Apr 16 22:56:26 2025] Modules linked in: nvm=
e_tcp(OE) nvme_rdma(E) nvme_fabrics(E) nvme(E) nvme_core(E) nvme_keyring(E)=
 nvme_auth(E) xt_tcpudp(E) nft_compat(E) rpcsec_gss_krb5(E) auth_rpcgss(E) =
nfsv4(E) cmac(E) nls_utf8(E) nfs(E) cifs(E) lockd(E) cifs_arc4(E) nls_ucs2_=
utils(E) grace(E) cifs_md4(E) nf_tables(E) netfs(E) cfg80211(E) ipmi_ssif(E=
) amd_atl(E) intel_rapl_msr(E) intel_rapl_common(E) rpcrdma(E) amd64_edac(E=
) rdma_ucm(E) edac_mce_amd(E) scsi_transport_iscsi(E) rdma_cm(E) ib_umad(E)=
 ib_ipoib(E) iw_cm(E) kvm_amd(E) ib_cm(E) kvm(E) ftdi_sio(E) ast(E)=0A=
[2025-04-16 22:56:24.758] [Wed Apr 16 22:56:26 2025] ------------[ cut here=
 ]------------=0A=
[2025-04-16 22:56:24.758] [Wed Apr 16 22:56:26 2025]  usbserial(E)=0A=
[2025-04-16 22:56:24.758] [Wed Apr 16 22:56:26 2025]  rapl(E) i2c_algo_bit(=
E) acpi_ipmi(E) ccp(E) ipmi_si(E) i2c_piix4(E) ipmi_devintf(E) k10temp(E) p=
tdma(E)=0A=
[2025-04-16 22:56:24.773] [Wed Apr 16 22:56:26 2025] WARNING: CPU: 44 PID: =
1609 at tcp.c:782 nvme_tcp_recv_skb+0x115e/0x11c0 [nvme_tcp]=0A=
[2025-04-16 22:56:24.773] [Wed Apr 16 22:56:26 2025]  i2c_smbus(E) joydev(E=
) input_leds(E)=0A=
[2025-04-16 22:56:24.773] [Wed Apr 16 22:56:26 2025] Modules linked in:=0A=
[2025-04-16 22:56:24.773] [Wed Apr 16 22:56:26 2025]  ipmi_msghandler(E)=0A=
[2025-04-16 22:56:24.773] [Wed Apr 16 22:56:26 2025]  nvme_tcp(OE) nvme_rdm=
a(E)=0A=
[2025-04-16 22:56:24.773] [Wed Apr 16 22:56:26 2025]  mac_hid(E) bnxt_re(E)=
=0A=
[2025-04-16 22:56:24.773] [Wed Apr 16 22:56:26 2025]  nvme_fabrics(E) nvme(=
E)=0A=
[2025-04-16 22:56:24.773] [Wed Apr 16 22:56:26 2025]  sunrpc(E) binfmt_misc=
(E)=0A=
[2025-04-16 22:56:24.773] [Wed Apr 16 22:56:26 2025]  nvme_core(E) nvme_key=
ring(E)=0A=
[2025-04-16 22:56:24.773] [Wed Apr 16 22:56:26 2025]  sch_fq_codel(E) efi_p=
store(E)=0A=
[2025-04-16 22:56:24.773] [Wed Apr 16 22:56:26 2025]  nvme_auth(E) xt_tcpud=
p(E)=0A=
[2025-04-16 22:56:24.773] [Wed Apr 16 22:56:26 2025]  nfnetlink(E) dmi_sysf=
s(E)=0A=
[2025-04-16 22:56:24.773] [Wed Apr 16 22:56:26 2025]  nft_compat(E) rpcsec_=
gss_krb5(E)=0A=
[2025-04-16 22:56:24.773] [Wed Apr 16 22:56:26 2025]  ip_tables(E) x_tables=
(E)=0A=
[2025-04-16 22:56:24.773] [Wed Apr 16 22:56:26 2025]  auth_rpcgss(E)=0A=
[2025-04-16 22:56:24.773] [Wed Apr 16 22:56:26 2025]  autofs4(E)=0A=
[2025-04-16 22:56:24.773] [Wed Apr 16 22:56:26 2025]  nfsv4(E) cmac(E)=0A=
[2025-04-16 22:56:24.773] [Wed Apr 16 22:56:26 2025]  btrfs(E) blake2b_gene=
ric(E)=0A=
[2025-04-16 22:56:24.773] [Wed Apr 16 22:56:26 2025]  nls_utf8(E)=0A=
[2025-04-16 22:56:24.773] [Wed Apr 16 22:56:26 2025]  zstd_compress(E) raid=
10(E)=0A=
[2025-04-16 22:56:24.773] [Wed Apr 16 22:56:26 2025]  nfs(E) cifs(E)=0A=
[2025-04-16 22:56:24.773] [Wed Apr 16 22:56:26 2025]  raid456(E) async_raid=
6_recov(E)=0A=
[2025-04-16 22:56:24.773] [Wed Apr 16 22:56:26 2025]  lockd(E) cifs_arc4(E)=
=0A=
[2025-04-16 22:56:24.773] [Wed Apr 16 22:56:26 2025]  async_memcpy(E) async=
_pq(E)=0A=
[2025-04-16 22:56:24.773] [Wed Apr 16 22:56:26 2025]  nls_ucs2_utils(E)=0A=
[2025-04-16 22:56:24.773] [Wed Apr 16 22:56:26 2025]  async_xor(E)=0A=
[2025-04-16 22:56:24.773] [Wed Apr 16 22:56:26 2025]  grace(E) cifs_md4(E)=
=0A=
[2025-04-16 22:56:24.773] [Wed Apr 16 22:56:26 2025]  async_tx(E) xor(E)=0A=
[2025-04-16 22:56:24.773] [Wed Apr 16 22:56:26 2025]  nf_tables(E) netfs(E)=
=0A=
[2025-04-16 22:56:24.773] [Wed Apr 16 22:56:26 2025]  raid6_pq(E) raid1(E)=
=0A=
[2025-04-16 22:56:24.773] [Wed Apr 16 22:56:26 2025]  cfg80211(E) ipmi_ssif=
(E)=0A=
[2025-04-16 22:56:24.773] [Wed Apr 16 22:56:26 2025]  raid0(E) mlx5_ib(E)=
=0A=
[2025-04-16 22:56:24.773] [Wed Apr 16 22:56:26 2025]  amd_atl(E)=0A=
[2025-04-16 22:56:24.773] [Wed Apr 16 22:56:26 2025]  ib_uverbs(E)=0A=
[2025-04-16 22:56:24.773] [Wed Apr 16 22:56:26 2025]  intel_rapl_msr(E)=0A=
[2025-04-16 22:56:24.773] [Wed Apr 16 22:56:26 2025]  macsec(E)=0A=
[2025-04-16 22:56:24.773] [Wed Apr 16 22:56:26 2025]  intel_rapl_common(E) =
rpcrdma(E)=0A=
[2025-04-16 22:56:24.773] [Wed Apr 16 22:56:26 2025]  ib_core(E) mlx5_core(=
E)=0A=
[2025-04-16 22:56:24.773] [Wed Apr 16 22:56:26 2025]  amd64_edac(E)=0A=
[2025-04-16 22:56:24.773] [Wed Apr 16 22:56:26 2025] ------------[ cut here=
 ]------------=0A=
[2025-04-16 22:56:24.773] [Wed Apr 16 22:56:26 2025]  mlxfw(E) psample(E)=
=0A=
[2025-04-16 22:56:24.773] [Wed Apr 16 22:56:26 2025]  rdma_ucm(E) edac_mce_=
amd(E)=0A=
[2025-04-16 22:56:24.773] [Wed Apr 16 22:56:26 2025]  polyval_clmulni(E) po=
lyval_generic(E)=0A=
[2025-04-16 22:56:24.773] [Wed Apr 16 22:56:26 2025]  scsi_transport_iscsi(=
E)=0A=
[2025-04-16 22:56:24.773] [Wed Apr 16 22:56:26 2025]  ghash_clmulni_intel(E=
)=0A=
[2025-04-16 22:56:24.773] [Wed Apr 16 22:56:26 2025] WARNING: CPU: 0 PID: 8=
32 at tcp.c:782 nvme_tcp_recv_skb+0x115e/0x11c0 [nvme_tcp]=0A=
[2025-04-16 22:56:24.773] [Wed Apr 16 22:56:26 2025]  sha256_ssse3(E)=0A=
[2025-04-16 22:56:24.773] [Wed Apr 16 22:56:26 2025]  rdma_cm(E)=0A=
[2025-04-16 22:56:24.773] [Wed Apr 16 22:56:26 2025] Modules linked in:=0A=
[2025-04-16 22:56:24.773] [Wed Apr 16 22:56:26 2025]  ib_umad(E)=0A=
[2025-04-16 22:56:24.773] [Wed Apr 16 22:56:26 2025]  sha1_ssse3(E)=0A=
[2025-04-16 22:56:24.773] [Wed Apr 16 22:56:26 2025]  nvme_tcp(OE)=0A=
[2025-04-16 22:56:24.773] [Wed Apr 16 22:56:26 2025]  ahci(E)=0A=
[2025-04-16 22:56:24.773] [Wed Apr 16 22:56:26 2025]  nvme_rdma(E)=0A=
[2025-04-16 22:56:24.773] [Wed Apr 16 22:56:26 2025]  ib_ipoib(E)=0A=
[2025-04-16 22:56:24.773] [Wed Apr 16 22:56:26 2025]  bnxt_en(E)=0A=
[2025-04-16 22:56:24.773] [Wed Apr 16 22:56:26 2025]  nvme_fabrics(E)=0A=
[2025-04-16 22:56:24.773] [Wed Apr 16 22:56:26 2025]  iw_cm(E)=0A=
[2025-04-16 22:56:24.773] [Wed Apr 16 22:56:26 2025]  nvme(E)=0A=
[2025-04-16 22:56:24.805] [Wed Apr 16 22:56:26 2025]  tls(E) pci_hyperv_int=
f(E)=0A=
[2025-04-16 22:56:24.805] [Wed Apr 16 22:56:26 2025]  nvme_core(E)=0A=
[2025-04-16 22:56:24.805] [Wed Apr 16 22:56:26 2025]  kvm_amd(E)=0A=
[2025-04-16 22:56:24.805] [Wed Apr 16 22:56:26 2025]  ib_cm(E)=0A=
[2025-04-16 22:56:24.805] [Wed Apr 16 22:56:26 2025]  nvme_keyring(E) nvme_=
auth(E)=0A=
[2025-04-16 22:56:24.805] [Wed Apr 16 22:56:26 2025]  kvm(E)=0A=
[2025-04-16 22:56:24.805] [Wed Apr 16 22:56:26 2025]  libahci(E) hid_generi=
c(E)=0A=
[2025-04-16 22:56:24.805] [Wed Apr 16 22:56:26 2025]  ftdi_sio(E)=0A=
[2025-04-16 22:56:24.805] [Wed Apr 16 22:56:26 2025]  xt_tcpudp(E) nft_comp=
at(E)=0A=
[2025-04-16 22:56:24.805] [Wed Apr 16 22:56:26 2025]  ast(E)=0A=
[2025-04-16 22:56:24.805] [Wed Apr 16 22:56:26 2025]  usbhid(E) hid(E)=0A=
[2025-04-16 22:56:24.805] [Wed Apr 16 22:56:26 2025]  usbserial(E)=0A=
[2025-04-16 22:56:24.805] [Wed Apr 16 22:56:26 2025]  rpcsec_gss_krb5(E)=0A=
[2025-04-16 22:56:24.805] [Wed Apr 16 22:56:26 2025]  rapl(E)=0A=
[2025-04-16 22:56:24.805] [Wed Apr 16 22:56:26 2025]  aesni_intel(E)=0A=
[2025-04-16 22:56:24.805] [Wed Apr 16 22:56:26 2025]  auth_rpcgss(E) nfsv4(=
E)=0A=
[2025-04-16 22:56:24.820] [Wed Apr 16 22:56:26 2025]  crypto_simd(E)=0A=
[2025-04-16 22:56:24.820] [Wed Apr 16 22:56:26 2025]  cmac(E)=0A=
[2025-04-16 22:56:24.820] [Wed Apr 16 22:56:26 2025]  i2c_algo_bit(E)=0A=
[2025-04-16 22:56:24.820] [Wed Apr 16 22:56:26 2025]  acpi_ipmi(E)=0A=
[2025-04-16 22:56:24.820] [Wed Apr 16 22:56:26 2025]  nls_utf8(E) nfs(E)=0A=
[2025-04-16 22:56:24.820] [Wed Apr 16 22:56:26 2025]  cryptd(E)=0A=
[2025-04-16 22:56:24.820] [Wed Apr 16 22:56:26 2025]  cifs(E)=0A=
[2025-04-16 22:56:24.820] [Wed Apr 16 22:56:26 2025]  [last unloaded: nvme_=
tcp(E)]=0A=
[2025-04-16 22:56:24.820] [Wed Apr 16 22:56:26 2025]  ccp(E) ipmi_si(E)=0A=
[2025-04-16 22:56:24.820]=0A=
[2025-04-16 22:56:24.820] [Wed Apr 16 22:56:26 2025]  i2c_piix4(E)=0A=
[2025-04-16 22:56:24.820] [Wed Apr 16 22:56:26 2025]  lockd(E)=0A=
[2025-04-16 22:56:24.820] [Wed Apr 16 22:56:26 2025]  ipmi_devintf(E)=0A=
[2025-04-16 22:56:24.820] [Wed Apr 16 22:56:26 2025]  cifs_arc4(E) nls_ucs2=
_utils(E)=0A=
[2025-04-16 22:56:24.820] [Wed Apr 16 22:56:26 2025] CPU: 22 UID: 0 PID: 13=
4878 Comm: kworker/22:0H Tainted: G           OE       6.14.0-qp-sdprt-adc-=
49-50-51-52-ktls+ #1 PREEMPT(voluntary)=0A=
[2025-04-16 22:56:24.820] [Wed Apr 16 22:56:26 2025]  k10temp(E) ptdma(E)=
=0A=
[2025-04-16 22:56:24.835] [Wed Apr 16 22:56:26 2025]  grace(E)=0A=
[2025-04-16 22:56:24.835] [Wed Apr 16 22:56:26 2025]  i2c_smbus(E)=0A=
[2025-04-16 22:56:24.835] [Wed Apr 16 22:56:26 2025] Tainted: [O]=3DOOT_MOD=
ULE, [E]=3DUNSIGNED_MODULE=0A=
[2025-04-16 22:56:24.835] [Wed Apr 16 22:56:26 2025]  cifs_md4(E)=0A=
[2025-04-16 22:56:24.835] [Wed Apr 16 22:56:26 2025] Hardware name: Supermi=
cro AS -1114S-WTRT/H12SSW-NT, BIOS 1.0b 11/15/2019=0A=
[2025-04-16 22:56:24.835] [Wed Apr 16 22:56:26 2025]  joydev(E)=0A=
[2025-04-16 22:56:24.835] [Wed Apr 16 22:56:26 2025]  nf_tables(E)=0A=
[2025-04-16 22:56:24.835] [Wed Apr 16 22:56:26 2025]  input_leds(E)=0A=
[2025-04-16 22:56:24.835] [Wed Apr 16 22:56:26 2025]  ipmi_msghandler(E)=0A=
[2025-04-16 22:56:24.835] [Wed Apr 16 22:56:26 2025] Workqueue: nvme_tcp_wq=
 nvme_tcp_io_work [nvme_tcp]=0A=
[2025-04-16 22:56:24.835] [Wed Apr 16 22:56:26 2025]  netfs(E) cfg80211(E)=
=0A=
[2025-04-16 22:56:24.835]=0A=
[2025-04-16 22:56:24.835] [Wed Apr 16 22:56:26 2025]  mac_hid(E) bnxt_re(E)=
=0A=
[2025-04-16 22:56:24.835] [Wed Apr 16 22:56:26 2025]  ipmi_ssif(E)=0A=
[2025-04-16 22:56:24.835] [Wed Apr 16 22:56:26 2025] RIP: 0010:nvme_tcp_rec=
v_skb+0x115e/0x11c0 [nvme_tcp]=0A=
[2025-04-16 22:56:24.851] [Wed Apr 16 22:56:26 2025]  amd_atl(E)=0A=
[2025-04-16 22:56:24.851] [Wed Apr 16 22:56:26 2025]  sunrpc(E)=0A=
[2025-04-16 22:56:24.851] [Wed Apr 16 22:56:26 2025] Code: 00 41 8b 57 20 4=
4 89 d1 4d 89 c8 48 c7 c6 88 d1 7a c1 e8 a5 b6 2f c9 e9 cc fb ff ff 0f 0b e=
9 28 fb ff ff 0f 0b e9 35 fb ff ff <0f> 0b e9 45 fb ff ff 49 8b 87 28 01 00=
 00 89 d1 89 f2 48 c7 c6 10=0A=
[2025-04-16 22:56:24.851] [Wed Apr 16 22:56:26 2025]  binfmt_misc(E) sch_fq=
_codel(E)=0A=
[2025-04-16 22:56:24.851] [Wed Apr 16 22:56:26 2025]  intel_rapl_msr(E)=0A=
[2025-04-16 22:56:24.851] [Wed Apr 16 22:56:26 2025] RSP: 0018:ffffcdccf87a=
fc80 EFLAGS: 00010293=0A=
[2025-04-16 22:56:24.851] [Wed Apr 16 22:56:26 2025]  intel_rapl_common(E)=
=0A=
[2025-04-16 22:56:24.851]=0A=
[2025-04-16 22:56:24.851] [Wed Apr 16 22:56:26 2025]  efi_pstore(E) nfnetli=
nk(E)=0A=
[2025-04-16 22:56:24.851] [Wed Apr 16 22:56:26 2025]  rpcrdma(E)=0A=
[2025-04-16 22:56:24.851] [Wed Apr 16 22:56:26 2025] RAX: dead000000000100 =
RBX: ffff8dbda9193680 RCX: 0000000000000000=0A=
[2025-04-16 22:56:24.851] [Wed Apr 16 22:56:26 2025]  amd64_edac(E)=0A=
[2025-04-16 22:56:24.851] [Wed Apr 16 22:56:26 2025] RDX: 0000000000000000 =
RSI: 0000000000000000 RDI: ffff8dbd986b14a8=0A=
[2025-04-16 22:56:24.851] [Wed Apr 16 22:56:26 2025]  dmi_sysfs(E)=0A=
[2025-04-16 22:56:24.851] [Wed Apr 16 22:56:26 2025]  rdma_ucm(E)=0A=
[2025-04-16 22:56:24.851] [Wed Apr 16 22:56:26 2025]  ip_tables(E) x_tables=
(E)=0A=
[2025-04-16 22:56:24.851] [Wed Apr 16 22:56:26 2025]  edac_mce_amd(E)=0A=
[2025-04-16 22:56:24.851] [Wed Apr 16 22:56:26 2025] RBP: ffffcdccf87afd08 =
R08: 0000000000008000 R09: 0000000000000000=0A=
[2025-04-16 22:56:24.851] [Wed Apr 16 22:56:26 2025]  scsi_transport_iscsi(=
E)=0A=
[2025-04-16 22:56:24.851] [Wed Apr 16 22:56:26 2025] R10: 0000000000000000 =
R11: 000000000000001c R12: ffff8dbe027c8290=0A=
[2025-04-16 22:56:24.851] [Wed Apr 16 22:56:26 2025]  autofs4(E) btrfs(E)=
=0A=
[2025-04-16 22:56:24.851] [Wed Apr 16 22:56:26 2025] R13: 0000000000000005 =
R14: 000000000000001c R15: ffff8dbd986b1498=0A=
[2025-04-16 22:56:24.851] [Wed Apr 16 22:56:26 2025]  rdma_cm(E) ib_umad(E)=
=0A=
[2025-04-16 22:56:24.851] [Wed Apr 16 22:56:26 2025] FS:  0000000000000000(=
0000) GS:ffff8e3b3f1b4000(0000) knlGS:0000000000000000=0A=
[2025-04-16 22:56:24.867] [Wed Apr 16 22:56:26 2025]  blake2b_generic(E)=0A=
[2025-04-16 22:56:24.867] [Wed Apr 16 22:56:26 2025]  ib_ipoib(E)=0A=
[2025-04-16 22:56:24.867] [Wed Apr 16 22:56:26 2025]  zstd_compress(E)=0A=
[2025-04-16 22:56:24.867] [Wed Apr 16 22:56:26 2025]  raid10(E)=0A=
[2025-04-16 22:56:24.867] [Wed Apr 16 22:56:26 2025]  iw_cm(E)=0A=
[2025-04-16 22:56:24.867] [Wed Apr 16 22:56:26 2025] CS:  0010 DS: 0000 ES:=
 0000 CR0: 0000000080050033=0A=
[2025-04-16 22:56:24.867] [Wed Apr 16 22:56:26 2025]  kvm_amd(E)=0A=
[2025-04-16 22:56:24.867] [Wed Apr 16 22:56:26 2025] CR2: 00005e9c7424be98 =
CR3: 00000002357ec000 CR4: 0000000000350ef0=0A=
[2025-04-16 22:56:24.867] [Wed Apr 16 22:56:26 2025]  raid456(E) async_raid=
6_recov(E)=0A=
[2025-04-16 22:56:24.867] [Wed Apr 16 22:56:26 2025] Call Trace:=0A=
[2025-04-16 22:56:24.867] [Wed Apr 16 22:56:26 2025]  ib_cm(E)=0A=
[2025-04-16 22:56:24.867] [Wed Apr 16 22:56:26 2025]  async_memcpy(E)=0A=
[2025-04-16 22:56:24.867] [Wed Apr 16 22:56:26 2025]  <TASK>=0A=
[2025-04-16 22:56:24.867] [Wed Apr 16 22:56:26 2025]  async_pq(E)=0A=
[2025-04-16 22:56:24.882] [Wed Apr 16 22:56:26 2025]  kvm(E) ftdi_sio(E) as=
t(E)=0A=
[2025-04-16 22:56:24.882] [Wed Apr 16 22:56:26 2025]  async_xor(E) async_tx=
(E)=0A=
[2025-04-16 22:56:24.882] [Wed Apr 16 22:56:26 2025]  usbserial(E)=0A=
[2025-04-16 22:56:24.882] [Wed Apr 16 22:56:26 2025]  xor(E)=0A=
[2025-04-16 22:56:24.882] [Wed Apr 16 22:56:26 2025]  tls_sw_read_sock+0x12=
c/0x4a0 [tls]=0A=
[2025-04-16 22:56:24.882] [Wed Apr 16 22:56:26 2025]  rapl(E) i2c_algo_bit(=
E)=0A=
[2025-04-16 22:56:24.882] [Wed Apr 16 22:56:26 2025]  raid6_pq(E) raid1(E)=
=0A=
[2025-04-16 22:56:24.882] [Wed Apr 16 22:56:26 2025]  acpi_ipmi(E)=0A=
[2025-04-16 22:56:24.882] [Wed Apr 16 22:56:26 2025]  ? __pfx_nvme_tcp_recv=
_skb+0x10/0x10 [nvme_tcp]=0A=
[2025-04-16 22:56:24.882] [Wed Apr 16 22:56:26 2025]  ccp(E)=0A=
[2025-04-16 22:56:24.882] [Wed Apr 16 22:56:26 2025]  raid0(E) mlx5_ib(E) i=
b_uverbs(E)=0A=
[2025-04-16 22:56:24.882] [Wed Apr 16 22:56:26 2025]  ipmi_si(E)=0A=
[2025-04-16 22:56:24.882] [Wed Apr 16 22:56:26 2025]  nvme_tcp_try_recv+0x7=
8/0xc0 [nvme_tcp]=0A=
[2025-04-16 22:56:24.882] [Wed Apr 16 22:56:26 2025]  i2c_piix4(E)=0A=
[2025-04-16 22:56:24.882] [Wed Apr 16 22:56:26 2025]  macsec(E) ib_core(E)=
=0A=
[2025-04-16 22:56:24.898] [Wed Apr 16 22:56:26 2025]  ipmi_devintf(E)=0A=
[2025-04-16 22:56:24.898] [Wed Apr 16 22:56:26 2025]  nvme_tcp_io_work+0xc1=
/0x1e0 [nvme_tcp]=0A=
[2025-04-16 22:56:24.898] [Wed Apr 16 22:56:26 2025]  k10temp(E)=0A=
[2025-04-16 22:56:24.898] [Wed Apr 16 22:56:26 2025]  mlx5_core(E) mlxfw(E)=
=0A=
[2025-04-16 22:56:24.898] [Wed Apr 16 22:56:26 2025]  ptdma(E)=0A=
[2025-04-16 22:56:24.898] [Wed Apr 16 22:56:26 2025]  process_one_work+0x19=
1/0x3e0=0A=
[2025-04-16 22:56:24.898] [Wed Apr 16 22:56:26 2025]  i2c_smbus(E)=0A=
[2025-04-16 22:56:24.898] [Wed Apr 16 22:56:26 2025]  psample(E) polyval_cl=
mulni(E)=0A=
[2025-04-16 22:56:24.898] [Wed Apr 16 22:56:26 2025]  joydev(E)=0A=
[2025-04-16 22:56:24.898] [Wed Apr 16 22:56:26 2025]  worker_thread+0x2e3/0=
x420=0A=
[2025-04-16 22:56:24.898] [Wed Apr 16 22:56:26 2025]  polyval_generic(E) gh=
ash_clmulni_intel(E)=0A=
[2025-04-16 22:56:24.898] [Wed Apr 16 22:56:26 2025]  input_leds(E)=0A=
[2025-04-16 22:56:24.898] [Wed Apr 16 22:56:26 2025]  sha256_ssse3(E)=0A=
[2025-04-16 22:56:24.898] [Wed Apr 16 22:56:26 2025]  ? srso_return_thunk+0=
x5/0x5f=0A=
[2025-04-16 22:56:24.898] [Wed Apr 16 22:56:26 2025]  sha1_ssse3(E)=0A=
[2025-04-16 22:56:24.898] [Wed Apr 16 22:56:26 2025]  ipmi_msghandler(E)=0A=
[2025-04-16 22:56:24.914] [Wed Apr 16 22:56:26 2025]  ? __pfx_worker_thread=
+0x10/0x10=0A=
[2025-04-16 22:56:24.914] [Wed Apr 16 22:56:26 2025]  mac_hid(E)=0A=
[2025-04-16 22:56:24.914] [Wed Apr 16 22:56:26 2025]  ahci(E)=0A=
[2025-04-16 22:56:24.914] [Wed Apr 16 22:56:26 2025]  kthread+0x10d/0x230=
=0A=
[2025-04-16 22:56:24.914] [Wed Apr 16 22:56:26 2025]  bnxt_re(E) sunrpc(E)=
=0A=
[2025-04-16 22:56:24.914] [Wed Apr 16 22:56:26 2025]  bnxt_en(E)=0A=
[2025-04-16 22:56:24.914] [Wed Apr 16 22:56:26 2025]  ? __pfx_kthread+0x10/=
0x10=0A=
[2025-04-16 22:56:24.914] [Wed Apr 16 22:56:26 2025]  tls(E)=0A=
[2025-04-16 22:56:24.914] [Wed Apr 16 22:56:26 2025]  binfmt_misc(E)=0A=
[2025-04-16 22:56:24.914] [Wed Apr 16 22:56:26 2025]  pci_hyperv_intf(E)=0A=
[2025-04-16 22:56:24.914] [Wed Apr 16 22:56:26 2025]  ret_from_fork+0x47/0x=
70=0A=
[2025-04-16 22:56:24.914] [Wed Apr 16 22:56:26 2025]  sch_fq_codel(E) efi_p=
store(E)=0A=
[2025-04-16 22:56:24.914] [Wed Apr 16 22:56:26 2025]  libahci(E)=0A=
[2025-04-16 22:56:24.914] [Wed Apr 16 22:56:26 2025]  ? __pfx_kthread+0x10/=
0x10=0A=
[2025-04-16 22:56:24.914] [Wed Apr 16 22:56:26 2025]  hid_generic(E)=0A=
[2025-04-16 22:56:24.929] [Wed Apr 16 22:56:26 2025]  nfnetlink(E)=0A=
[2025-04-16 22:56:24.929] [Wed Apr 16 22:56:26 2025]  ret_from_fork_asm+0x1=
a/0x30=0A=
[2025-04-16 22:56:24.929] [Wed Apr 16 22:56:26 2025]  usbhid(E)=0A=
[2025-04-16 22:56:24.929] [Wed Apr 16 22:56:26 2025]  dmi_sysfs(E) ip_table=
s(E)=0A=
[2025-04-16 22:56:24.929] [Wed Apr 16 22:56:26 2025]  hid(E)=0A=
[2025-04-16 22:56:24.929] [Wed Apr 16 22:56:26 2025]  </TASK>=0A=
[2025-04-16 22:56:24.929] [Wed Apr 16 22:56:26 2025]  aesni_intel(E)=0A=
[2025-04-16 22:56:24.929] [Wed Apr 16 22:56:26 2025]  x_tables(E) autofs4(E=
)=0A=
[2025-04-16 22:56:24.929] [Wed Apr 16 22:56:26 2025]  crypto_simd(E)=0A=
[2025-04-16 22:56:24.929] [Wed Apr 16 22:56:26 2025]  btrfs(E)=0A=
[2025-04-16 22:56:24.929] [Wed Apr 16 22:56:26 2025]  blake2b_generic(E)=0A=
[2025-04-16 22:56:24.929] [Wed Apr 16 22:56:26 2025]  cryptd(E)=0A=
[2025-04-16 22:56:24.929] [Wed Apr 16 22:56:26 2025] ---[ end trace 0000000=
000000000 ]---=0A=
[2025-04-16 22:56:24.929] [Wed Apr 16 22:56:26 2025]  [last unloaded: nvme_=
tcp(E)]=0A=
[2025-04-16 22:56:24.929] [Wed Apr 16 22:56:26 2025]  zstd_compress(E)=0A=
[2025-04-16 22:56:24.929]=0A=
[2025-04-16 22:56:24.929] [Wed Apr 16 22:56:26 2025]  raid10(E) raid456(E) =
async_raid6_recov(E) async_memcpy(E)=0A=
[2025-04-16 22:56:24.929] [Wed Apr 16 22:56:26 2025] CPU: 44 UID: 0 PID: 16=
09 Comm: kworker/44:1H Tainted: G        W  OE       6.14.0-qp-sdprt-adc-49=
-50-51-52-ktls+ #1 PREEMPT(voluntary)=0A=
[2025-04-16 22:56:24.929] [Wed Apr 16 22:56:26 2025]  async_pq(E) async_xor=
(E)=0A=
[2025-04-16 22:56:24.929] [Wed Apr 16 22:56:26 2025] ------------[ cut here=
 ]------------=0A=
...=0A=
...=0A=
=0A=
=0A=
=0A=

