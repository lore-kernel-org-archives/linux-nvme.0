Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 954C5C28B28
	for <linux-nvme@archiver.kernel.org>; Wed, 12 Mar 2025 07:22:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=dp4MXnMa0lFocsBplRpVJD5EDymO2i8jmdmaQ7Y9pB0=; b=a6LUJvrX3OOiSwT1rER3Ins4J0
	vGtiJ+WNKtFD8vIuvZmmwrpXKfl3ShvuLgqNg2936dih9MDThVKIbvRLIXlhJqascbO1sJykDQXXS
	8bOPc3l7CrvtiP5SGMCuabENgnlnXhEipYc4YWDyJiJFgjm5JbpXCwtukPtvuaN4ddHruXYEbpZN3
	Q4cMtwwNP+LAcD4T/zcwH7bUE0rkfDq0uXGf2hE9Xc85m9do3frKlBnDV6v11MDk6UXgkWpkTfWV+
	JTs2S4ZIZsG8iKTgJCju/O7gPmByNwc0nX2hgljDKjogaEGK2MqfCr3YZ95F+17fpZuxpxgN6+SpU
	8GOfImDA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tsGPq-00000007gqn-1fxZ;
	Wed, 12 Mar 2025 07:22:10 +0000
Received: from esa1.hgst.iphmx.com ([68.232.141.245])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tsGO0-00000007gl3-19gZ;
	Wed, 12 Mar 2025 07:20:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1741764016; x=1773300016;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=+xTYwfSla3wA63Jz5OI1+WtqHBr8AhW+jFI5UvR4IKg=;
  b=isrCLGM7X4Kmm0mGHIjXgfQx8zmUSdKq4Gmehw9j0kEflKuChDqEjeeX
   qc9F0dHOPibyM/GwADn3QvO/vnAvNjSVuzLqpxRB8BCZ3fF8CgjKwVcz5
   hXYHuSZzC1TG1lRY4wWPEpr+aqJSDbLyDJP+x2YnoJG5uMDnwtC6+AV0m
   y7X6IdbFcrGuBlxSK7rKJ++UztRi3C5Tl/ejiNIBGj/CKSHRPK2pB1+0s
   ZSuabsSvQbr3PZFy+VeaHh9ARoL6b15hzFtZIK2sgJ73krqZMjiEgLXKV
   fj1v1bOV4sASpuXph7tJ7cm1pRPFkkAOIrXBW6O9KgY/Jtd227FBX6+jQ
   g==;
X-CSE-ConnectionGUID: 8VIgpt2LSTWLkOMe6jzyKw==
X-CSE-MsgGUID: 1J/qR1o9R8mqt8GyR2aG5g==
X-IronPort-AV: E=Sophos;i="6.14,241,1736784000"; 
   d="scan'208";a="47743585"
Received: from mail-northcentralusazlp17010003.outbound.protection.outlook.com (HELO CH1PR05CU001.outbound.protection.outlook.com) ([40.93.20.3])
  by ob1.hgst.iphmx.com with ESMTP; 12 Mar 2025 15:20:11 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r31y0pz330QsybrQjmeCzSOcwciC/1PGvX6b2dS0LpNUFs7QkM6GE5II1B/spXqc7mHfGQcqeHO5dNyTL4WyGjo3nsvAFROKfU/3nZuEwMnclp9ZCMm5u9niI/bJEYLfpV/UrbnlDC1jTu/lo2tZ/101pALWh0Xk9tT6Gj2+8mJga83BVawF924tNnM7jCS3kUnyMcKewDx2rcdbR5Mke1ytJtxU0eJ/fZyh/Dohkp/eqChnAYlVQgN6hG2ibCjbNpbCjMXHOglpTDPAKyyOoKnDNiHzNGQ061HNVJUjCJ4Kn3/ei5pfQe+LlVLS5AX/p9fzQEYx+jh/xbdRI5K54w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dp4MXnMa0lFocsBplRpVJD5EDymO2i8jmdmaQ7Y9pB0=;
 b=QgT973xXz8Hl1qyNEMVMWmMxHe1ve/sjgCOxirLEqDN2lOKi+qTgzC2m47OASeFkR3Cpub9u9gdRY8bNYHruCD4XCvfq15SqaJAj3Ot2K+NXh1/i3ljjwtW3uOagqBkdb4SbBLUsm1E25hM0T5QVeNJYnwO6ymtOk9DuSSolgoO5RCMYaiuFZgRred+HiWwktK2PowJOO6/A5+1VzxYYc7qNNUBECZ1fTqREYlMCsP5UAjlvgmZQvMF8G51jS3uBGcHq27eBQ+WvitR6kDfUpW74myqh8oyLBDR7LnbXZlcTfMVCGE66II5Z+NxaOMQI0wJEf1oQB1FZE651mCOpDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dp4MXnMa0lFocsBplRpVJD5EDymO2i8jmdmaQ7Y9pB0=;
 b=SrlPDqUMoyde0YhPbv76GGlpW58CUwSXiTxFjPfmZ2PRn4TAQQ5XCtvNQzSIEffkX41Q8Wc6aLoKIa9U9dG6izWYr+ssFacILwz0vxnuW4BNnIWeLmM7xJXTgNW22hFMxZyh6ohM2KiOxIfNrHSlzwBoUBJewDhR7gjdwKbIlvc=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 DM8PR04MB7799.namprd04.prod.outlook.com (2603:10b6:8:3b::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8511.27; Wed, 12 Mar 2025 07:20:10 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b27f:cdfa:851:e89a]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b27f:cdfa:851:e89a%7]) with mapi id 15.20.8511.026; Wed, 12 Mar 2025
 07:20:09 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: "hch@infradead.org" <hch@infradead.org>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, Jens Axboe
	<axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>, Sagi Grimberg
	<sagi@grimberg.me>, Alan Adamson <alan.adamson@oracle.com>,
	"virtualization@lists.linux.dev" <virtualization@lists.linux.dev>,
	"asahi@lists.linux.dev" <asahi@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, Hannes Reinecke <hare@suse.de>,
	"Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?iso-8859-1?Q?Eugenio_P=E9rez?=
	<eperezma@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi
	<stefanha@redhat.com>, Sven Peter <sven@svenpeter.dev>, Janne Grunau
	<j@jannau.net>, Alyssa Rosenzweig <alyssa@rosenzweig.io>
Subject: Re: [PATCH v2 2/2] block: change blk_mq_add_to_batch() third argument
 type to bool
Thread-Topic: [PATCH v2 2/2] block: change blk_mq_add_to_batch() third
 argument type to bool
Thread-Index: AQHbknKIemWPhy1uyU+vqjKmNfyw4bNvAw4AgAAWbIA=
Date: Wed, 12 Mar 2025 07:20:09 +0000
Message-ID: <slsdaxocaojcfxsq3akvwp4kjzhddx4agcqori3jpnljkfwyji@qlmpctcyejfu>
References: <20250311104359.1767728-1-shinichiro.kawasaki@wdc.com>
 <20250311104359.1767728-3-shinichiro.kawasaki@wdc.com>
 <Z9Ei2t7z_7QbEWXW@infradead.org>
In-Reply-To: <Z9Ei2t7z_7QbEWXW@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|DM8PR04MB7799:EE_
x-ms-office365-filtering-correlation-id: f19e29d0-3f1b-4fda-02a6-08dd61365291
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016|38070700018|27256017;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?7Y/NRXtqZE6Fb5S5f8MGHEiQPVp2C7bAdZLDVTIH2CRZr9pY+FWFHIUatk?=
 =?iso-8859-1?Q?w6KazI8JQgcwVvfuVVnB3HMsd3GCB8SF2WQcfJ57JMV+UrhDDXB5TY0MLO?=
 =?iso-8859-1?Q?nc2+WOwvOmJS1Dk/Pfym502Sdtb3rCntItDpqMv6Ww2U9FIpaSpJ289I+3?=
 =?iso-8859-1?Q?i5g2TD4fFkZUtFSEJeJE2GP61/xUUAXefyKHgvok8CcS0yU1mvzUbAaJAz?=
 =?iso-8859-1?Q?R7tUXOHPcY65DEDlp8/45qyYFasFuO+5cs9kPr/NsoXjOo6PmJCJMXDeCP?=
 =?iso-8859-1?Q?YMW/KXtRNtPTPxAvLhQqpiJ23aLs5reKmCVQrMUoSkjEuauo7KWxLN1rmK?=
 =?iso-8859-1?Q?2fHKx2QQYCzGNHgBhCrz28F/3cLjXRBMdRUpMgkKijNq1s9jaN9LrgUqse?=
 =?iso-8859-1?Q?G6hTojZvQ6LQF8AggjnYHvnHtEeSTvoK/YG7HDK2vNiqaVSBER6ZhD5rRX?=
 =?iso-8859-1?Q?/37lkLg3nFXWoGJ9GJLOFgXFkRQwnWElNhhD1yYVDi+1HeSU4N/PEjCp3V?=
 =?iso-8859-1?Q?jX5ZRot8CjaIN5t53pLAvWDXc/MVYxLqjw6erkPtp58L2IpoDyFPh4rlz0?=
 =?iso-8859-1?Q?Y3tXVJ5iVKYazoojQTFaSsyd5D/35u64XY+x5kMEzzv+YC3ywA2WJAS8qE?=
 =?iso-8859-1?Q?5K6TObIgSiASnZEDoYTreRA+IA609VfZ9fYvC9BXXF12NAFsWYTlHq9b2g?=
 =?iso-8859-1?Q?WAGt8ZARVrt4Pj07+4vEN8AvoyNmnvBc3EBUfrHa12bx+cuKUuab7JaxKd?=
 =?iso-8859-1?Q?E+BXL/0BAfAeOOAy41xXFFtK7UynABCpNKKsDGKm6hZr3D9344SqHOo9q3?=
 =?iso-8859-1?Q?aFb7GKwKxyRO/gmwq9nzKElnBJC4l625gC+ra8xzgYKx+Hk+SSCWdIha7u?=
 =?iso-8859-1?Q?7mXn73F4eZueee9Cn//FeOpPZGXvlufkucC3ehIeoiebm7XV1RPfavcHDr?=
 =?iso-8859-1?Q?5XA/aJCoaiiX0SgLQewTUsQZi9063SO6niXQfXxth2Xtq8cv3k0QhtayKQ?=
 =?iso-8859-1?Q?hQvnRIB2MTYEWSVKyVcu/KvtIFEXnBLilGOrsKQdr6hGZ/AEJw2OJ5zr7t?=
 =?iso-8859-1?Q?rPEwkOP6GhzQroCkWe44XCOWtBcyRADM756SvejLadnAn3gKFMOhj0jjZU?=
 =?iso-8859-1?Q?1RdRHUAxyDF3iqr0/HKvA/oerM/41+XLSWWXtKq3QhFy1kTM/Kw41dRnYo?=
 =?iso-8859-1?Q?K2vMJ0iqPctu/7eTK6VgdD99ZWzBrvornLzLi4cGTlX7bEP92ydfX22Tkz?=
 =?iso-8859-1?Q?NbbxjiVck0MLYtSvrCqadk9RWA6q84u1VN+W8NcvAprih5SyXUfRfpJJQi?=
 =?iso-8859-1?Q?59BCuinFdhts9O9dDIHCkm7U4paAmtYwU+NeJnK7FB6Nie1Gh5F9vlB+wT?=
 =?iso-8859-1?Q?wT58S+TyQRzWMM2vbT4v9zTx/xWyXIq51vjZZuRaJjRj+BLHnxTq13IevD?=
 =?iso-8859-1?Q?2fhFxAQystaXeZuLBW4JhPPfFGEbYdoB4zj3DR2Wcjkmpip1YUSLBRbKQb?=
 =?iso-8859-1?Q?FPhWvm29AhXfOxlAZwh0LtnZzeEfhcrApDyTIPj5yguQ=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700018)(27256017);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?u4zvlSOZYnEEe2LH3llNxAWsomk+abKWq2b72ZsnN/v4AKFNm8Sjj+3nmd?=
 =?iso-8859-1?Q?7nH80gju7EZ2OHt5b/oDY+2cCfu63JvZq0S61Ih5vlaAeBtfPedCGhiSIE?=
 =?iso-8859-1?Q?mf0hekB4x7FxIye4t5zIrih4WgXoU+9e39ONwDj4f80LzkXBCoclvjwOiu?=
 =?iso-8859-1?Q?5+MqvFS9+B6ZM9J1VG2X8+UfPhw9kgHKJg0OR5D6bEsQQ5qylEEi37f0Hm?=
 =?iso-8859-1?Q?8PGRrBD605MdoXVz+1ge6euUvXCbcacarTKb1mG9t8qFFvxvKMbFzfH9ds?=
 =?iso-8859-1?Q?JA960YOOoGM7t/qD4/o9xRRXFpozsOTXzu4zYvwuSYxY6HtgZJkosJt9+A?=
 =?iso-8859-1?Q?v/r4KL5569ntpdnMBodCLaBxytz8MDQc08th7+xpUdyNPaE509kOfdDvoT?=
 =?iso-8859-1?Q?BRhI0D9sfpTtTP4YVHqfLPlN+0UYZ9/siue51CFZuSdVK1nrprlW76qLZy?=
 =?iso-8859-1?Q?xXDOy9aLngbhLmPdABZPoGgNtKLwMrJ+lr09qS8cyPUh/Qrd4ITLLMVzBV?=
 =?iso-8859-1?Q?Cch3vYjQABE1HSgLrjuoQPkOjbDrx+s6jQW9PnGgQQAD7n6TMqWcut38Uc?=
 =?iso-8859-1?Q?y76bSYQYLU0qXzSSZq1lcIEJx5Tu4NyfRPpbhCsQBEl8jQU92XJtp0514A?=
 =?iso-8859-1?Q?cqqJQs6llKJKVNf7o+1ReyKkesGOc74jZ0Nn+9V8awlSAJTgdq/gexqM+f?=
 =?iso-8859-1?Q?yE9Ntvy/UzxuP9b1HQp0bQdtxqOE2uVkUU6yaIWClfT3Dcjp5IzeT/XoOu?=
 =?iso-8859-1?Q?NJortnNM0hIho/OQeqJyel4EzVdf6AyvN+cU5GU9UIoEk2IreeC51nxnsv?=
 =?iso-8859-1?Q?QT8ZHW9QRzwBgsKXqfWgvaR9K/2F11TnjVYRMyS9ht7PlDG3a/YE9l8toC?=
 =?iso-8859-1?Q?0rHnhyCVSLkZxYQIFqh9z8pSyqDmRNptP8GMRv42LLiCS0cDBkSkpKFkjs?=
 =?iso-8859-1?Q?4mjUqBK6kjM7M+wNVHiI5X40L8pyZaNXj8zTKU+woBWhd2UoRlwVEKV6pK?=
 =?iso-8859-1?Q?xrix5UA+5HYiC2UkENoFNhWnGimLf5Vw2h7a0h0x9yqzopianjttxSyBoY?=
 =?iso-8859-1?Q?c4ildAliEjTj9fCGS06hB22/5npXHfLQVLuzKaz3PNy5HwL83EsYfUsyc2?=
 =?iso-8859-1?Q?j4s1Y5XxnR+4qtmQLjT4vjWDAl9/8e+lkNQ+eiHEeLUSSy3ApHH5uJKccq?=
 =?iso-8859-1?Q?xE0pAA4gZ7/bEhiB4Na9IxXyTCG6hg3rA7YEohTUVJORx7on57Zr0c6/Pm?=
 =?iso-8859-1?Q?rVL7loR8W0DD4ilOyycuTRrrP/PK1RSiMt6HsdrJMYp1naYi23w/+pjabb?=
 =?iso-8859-1?Q?ySBD3geQQ8cps5EGAROL4LkjNw/S1gka9QbgULVfl8NatyrplYMBIJPdJ+?=
 =?iso-8859-1?Q?hUFwREcHXsZjV2lsBqYpzt8pwnU4ZB+jlhUnub+AjgJhoH800e+jaWP0wh?=
 =?iso-8859-1?Q?4C9FgucYipHWTCV0oPdCJwoS8rvhXslAc1l8xYOIy15XKvfVEKqt5DtAh2?=
 =?iso-8859-1?Q?qbXyhkOlxK8APZzL/fUFNaJ3deoilBmKMdggr5Khvg8v9sM/lHuLAmYBOi?=
 =?iso-8859-1?Q?zddeKBCG8WdkPxENCED/coIv+ugDCFCB4WmCsst7ABqWJ0cYw7fo8hQbLg?=
 =?iso-8859-1?Q?jp1hTBRCgxNnYgxnnqOMbJMcbPj6gsFB+JGdyx0inFOP96vBbumdYHDNj4?=
 =?iso-8859-1?Q?BxTtcwKhbd9FlNZT2k0=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <4291040D9160AB4DBABCBF3CB571A284@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: s3TuZcJLBCkbAptrXYClJjSFZQe/XG+7+yq6gYXvkxgRM6A91OkYZkBQiwXi5bjybvPXvnlveIYBKpYUvhHTM33MBJtQoAYozF5/nl6h2RSGOnRlRsBo23JzPfjpO99mcmh0ngZRhfwdBWlGpYgvwO+HoI/GTjFpzyuQfKkw16D9pqE8LhBUAOrlU5aplGQms1tEsHtL4r5smI/+aj9rcnDOUZ+f5nYKy4cY4iaX9Oc9rPDdRZPhoolKL6d4jy12h1OsZe7vv8w0S84yB3bGpn+XtvSEdZZlnlXt2FejuPxpchEEArLVUvOAVsgbqwKvki6SLYrf8Luj9+QR49F+kojQWmNDrpjY4Eg7TvpkzITrucwYBEudJTiSRqVU/mqHq+Qi+j/RvBgpyXPW9GQP+ytEtf/JCsu6FesNtvz2w0+HPEZEtU7cn1Xdn2J1oXDiHvNiMF2t/Mgf6juNeWr3A0MFsRId4YQo86vDv//3acTmPTu6M65so5aGhpNsJyXgNztQTC4ClYq5O2yvmSySmKnX0PfcpMRg05pi3i7123XtwCPl9lp6w4UOQPF5rLhe89vBB6wYfiK7bdU+LMlbeDRxc7KxEsBZiWGX/8k1H7oI4P8gUvd3Ifh/YWIR48s1
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f19e29d0-3f1b-4fda-02a6-08dd61365291
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Mar 2025 07:20:09.7242
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OqLkZ6SPDl+AUDQAnMVCBXbJvGEPBjfk+TK8WG9KJPoCjPVec1SpYolCGB/yOrMJIud2wStXySkU7rJhDj3mMJg16dcEimmsOqwcBSJUsvI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR04MB7799
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250312_002016_313591_7B67C260 
X-CRM114-Status: GOOD (  17.22  )
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

On Mar 11, 2025 / 22:59, Christoph Hellwig wrote:
> On Tue, Mar 11, 2025 at 07:43:59PM +0900, Shin'ichiro Kawasaki wrote:
> >  /*
> >   * Batched completions only work when there is no I/O error and no spe=
cial
> >   * ->end_io handler.
> > + *
> > + * @req: The request to add to batch
> > + * @iob: The batch to add the request
> > + * @is_error: Specify true if the request failed with an error
> > + * @io_comp_batch: The completaion handler for the request
> >   */
>=20
> This needs more work to be a proper kerneldoc comment, i.e. start with
> "/*8", mention the function name, etc.

Ah, thanks. I should have checked the kerneldoc format. Jens already queued=
 up
this patch (thanks!), so I will send out a separate, follow-up patch to fix=
 the
kerneldoc comment. The follow-up patch will be posted to linux-block list, =
with
reduced To/Cc members.=

