Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5071CC6FD1C
	for <linux-nvme@archiver.kernel.org>; Fri, 24 Mar 2023 21:38:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Cc:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zKmrUYVXwqdUglgXTCuNoxS2Iy8IqzslrW6cbD9h/94=; b=xpM2GiIw0JKOImVlj2MvOlmMjm
	VEuDJqCTpz9Ymu3A/23jVf2vzHDJX1gojXF19BrpPx0JaT+TkPs3X5CCcsqb1UR+ZcuDCEArmmjou
	NvlCJaD74jvBCvQsvUTDMt7JviS9wqbLGSCssxdKai+eRtDFFhY8KCeQcq7tDfI/LO3/tbNfKmyMS
	cmhlbRtBeTbgIAmw90mkOV8GXthmvbY58plncfFlN3A8OAm5pm4z/IfJCr1lUj7kluqqQGheYvY7a
	wuGxuMKR6Kq/+FrAS5ejWyJnIxPqNKyHfcNVs9QGgK6Ap8guoU4biZFX7f4nh+C/knI5pX9VgGOO8
	cWgt58IQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pfp7Y-005f29-0O;
	Fri, 24 Mar 2023 21:38:48 +0000
Received: from ironmtw4.johnshopkins.edu ([128.220.39.140])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pfp7V-005f1X-0W
	for linux-nvme@lists.infradead.org;
	Fri, 24 Mar 2023 21:38:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=jhu.edu; i=@jhu.edu; q=dns/txt; s=jhuiron;
  t=1679693925; x=1711229925;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=rNasbbORi2XZHZkC1ZTCGg93EA2cgGZicwdBSB1Xq3Q=;
  b=W7D7UnBYG+p+oatE/aVVxS1RhgmhAHr29Z00Gj/4s4w9OHNOgGUJh6hj
   VFwECH/OBQKiILHh9dqUtJiNk/7pG2a9Vcv4pdblUkS/o9NryBv1FJgwZ
   y6Q47n3tLLi0SQBPm0reSAgKuv5cR114ns33VgBo8CdwCWv6cCvC8QHtc
   M=;
IronPort-SDR: opZx9vgY4YQnrDG9/5ZEqCU5sRceu3xW+7Rf+ly6AqwYGO7TDY0snAT6++ZVDbVLOFdsHRYfEx
 foXINgAONdvuvn0HVsXnuvbWnhU8LKkKQ=
X-IPAS-Result: =?us-ascii?q?A2GxDwCVFx5k/9+ErQpaHQEBPAEFBQECAQkBgWQCgixzg?=
 =?us-ascii?q?VyEU49hAQEBAQEBBoEkHgOFZYVzkFCBLIElAxg+BgkBAQEBAQEBAQEIARQTH?=
 =?us-ascii?q?QQBAQMEhH4ChTsmNgcOAQIEAQEBAQMCAwEBAQEBAQMBAQEFAQEBAQEBBgMBA?=
 =?us-ascii?q?QECgSZkaoFPgX8LAzEBDII3In1NOwEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBAQEBAQEBAQUCgQhPAQEBAwQcBxkBATgPAgEIGC4QIiUCBIU6AzGyI?=
 =?us-ascii?q?giBAzOBAYIIAQEGBAScTRhGAQmBawkJAYEILwGDS4kiFYQyQn2BEIEVgnowP?=
 =?us-ascii?q?oQsGINWgmmZVoE0dYEgDoE9gQQCCQIRa4ESCGtcgR0EQQINZAsOb4FLAoJPN?=
 =?us-ascii?q?wNEHUADgQA+ATUUIQaBL0IkBQMLFSpHBAg5Bho0EQIIDxIPBiZDDkIhFjQTB?=
 =?us-ascii?q?nkNCw4RA1A0gRMEL4FcBkudVIExMIEtEcRGhASEW5xwg2qTUJFyl2ogog2FR?=
 =?us-ascii?q?AIEAgQFAhaBagKCDXITgyJPAQIBAQENAgEBAQMBAgEBAQkBAQEBjlSDO495d?=
 =?us-ascii?q?TsCBwsBAQMJi0MBAQ?=
IronPort-PHdr: A9a23:IWlqdRyQsoRPDwDXCzKYzVBlVkEcU1XcAAcZ59Idhq5Udez7ptK+Z
 hGZv6kzxwaUBM3y0LFttan/i+jYQ2sO4JKM4jgpUadncFs7s/gQhBEqG8WfCEf2f7bAZi0+G
 9leBhc+pynoeUdaF9zjaFLMv3a88SAdGgnlNQpyO+/5BpPeg9642uys+5DfeRtEiTW8bL99M
 Rm7rRjdvdQKjIV/Lao81hTGrnxUdupM2GhmP0iTnxHy5sex+J5s7SFdsO8/+sBDTKv3Yb02Q
 aRXAzo6PW814tbrtQTYQguU+nQcSGQWnQFWDAXD8Rr3Q43+sir+tup6xSmaIcj7Rq06VDi+8
 6tmTgLjhSEaPDA77W7XkNR9gqJFrhy8uxxxzY3aYI+XO/Vica3ScsgXRXZYXstLSyBNHp+wY
 ooJAuEcPehYtY79p14WoBaiAQmjGuzuxSVOhnDrw6I6yfkqHxzG3Aw9GtIBqnfUrNLrNKcTT
 eC60KnIxijEYvNN2Tf99ZLIchEiofyXX7JwcdfRxVMxGAzYk1WdsIroNC6a2eoRqWaU9fZgV
 f6xhG49rQF8ujeiy8Mwh4THhY8Z1k3J+CR2zYooONC1RlB3bNqrHZZQsyyUN5V7T94iTW9op
 Co3xaEKtJC/cSQWyJkq2R7SZ+CBfoOV4RzjTP6cLSpkiH5/Zb6yhRi//VK9xuDySMW4ykhGo
 jRLn9XUqHwA1gDf58aCR/dg4kuuwjeC2gXJ5e1YL005kLfXJIQ6zbM1k5cfr0XOEynrk0vsl
 qCWbF8r+u2w5uTiZbXpu4GTOpdvigH7LqQugsu/AfkkMgQWX2iU5+C81Lr78EDlXrhEjPo4n
 LDEvZ7ZI8oVqbS1DQtX3Igk6BizFTio3toWknUfLVJFfgyIj5TxNl3TPPz0F+qzjlainTtx2
 vzLMKPtDo/TInTdnrrtZbN95FRdyAo3w9Bf/ZVUCrQZLfLoWk/xqcbYDh46MwGvwebnCMh92
 pkAVm2SH6+VKKXSvkSQ6eI1P+aMfJMVuCr6K/U9+vLilWU5lkMFfam1wZsXb2i1HvBnI0Wff
 Hrtjc4NEWEUvgo7UuPnk1mCUT9IZ3auRKIw/DA7CISoDYfZXI+inaKO0z2mEZFMYWBGEF+MQ
 j/UcNDOX/YKdTLXJNFknxQAVKO9UMkg0x+0vQP3wrYhKfDbsGVMsZPlycgw4fPWmDk29CdoF
 IKc1W+XRm15l29OQCU5ivNRu0t4n36H3LhxhfBVD5Ro5+5MWwQ9K5/AxOwyX8vyRxjAff+LS
 EvgT9m7V2JiBuktysMDNh4uU+6piQrOinLC6/c9m7+KAcky9aTRlzj0Kt1mwnnLnK8mkxE9Q
 8RJOGHn48w39wXaC4PT1UnMkaGsePcQ2SfX/zKFymyD9EhTTA93V/DDWnYSLkvbpNj0/AXMV
 birXLYnL01MxdPRQpY=
IronPort-Data: A9a23:3KxH1636tcuHVDk/KPbD5RRxkn2cJEfYwER7XKvMYLTBsI5bpzEEz
 2ZMUGiOOPnfMzGgKdFwaoyz9UtQ75GDndNrSwBoqSg9HnlHgPSeCIXCJC8cHc8wwu7rFxs7s
 ppEOrEsCOhuExcwcz/0auCJQUGRUchkf5KkYAL+EnkZqTRMFWFw2XqPp8Zj2tQz2YPjX1vX0
 T/Pi5S31GGNim4c3l08tvrrRCNH5JwebxtB4zTSzdgS1LPvvyF94KA3fMldHFOhKmVgJdNWc
 s6YpF2P1jiAo0pyUIPNfoHTKSXmSpaKVeSHZ+E/t6KK2nCurQRquko32WZ1he66RFxlkvgoo
 Oihu6BcRi8YP4HworQQbiBYAitkGY9I+b7WDWGg5Jn7I03uKxMAwt1HJ2ETGqc53ssxI0Fr1
 Lo1BA1lghKr3rrwme3gDLA33IJ5dpKD0IA34xmMyRnCDes8QJPrQaXXo9JUwV/cg+gURKiGO
 JdDOVKDajz/Uh9gPk8HU6gQkfXxhkDdTW0HjQmK8P9fD2/7iVYZPKLWGN7UfMGaAMNLm0uwo
 mPd43+/AxcULtWTxDOJtHW2iYfycTjTVZkdEaGn++4z0RjJnSoMCRtQXFf9o/mkzEOyRrqzN
 nApx8bnloBqnGTDczU3d0bQTKesskFOVtxOPfc97Q3RmKPY7xzAWjofTiNbad8Ots8rAzEmy
 wbRzd/uADVutpyTSG6cr+nL8mrqYHlPdWJSNzUZSQYl4sX4pNBhhx3Ced9vDaqpg4CnAjr32
 T2L8nQziuxL384G3qm2537dhDeoqsSbRwI5/FyLDHml8xl4Z6anZ5Hu5FTGtK4SIIGcR1iHn
 X4Fh8nHsr9RVMnUxXbVTbxUTr+z5vuDPDnNunJVHsEsp2a35nquXYFM+zUvdk5mP/ENdSLtf
 EKO6xha44VePSX2YKJ6P9CxBsAtwfSyHNjpTKmEPPNlQr1WXi6j0WdMRWuxmU3BrRF0w604P
 J6ad+eqDGobUPo4k2PuHrZHibJ7lDojwW7zRIzgy0X12LWTU3eZVLMZPQbcdes+9q6F/lnY/
 ooNLceM0BkDAuTybjONodweNl8PMWc2Fcmn7pYMMPGCJExvFCcjC+KXzL88ItQ3k6NQn+bO3
 3e8Rk4BlgWg3CWeeF/SZyAxcq7rULZ+sWk/bH4lMluf0nQ+ZZqisfUEfJwtcLh5qOFuwJaYl
 RXelxls3xiXdgn6xg==
IronPort-HdrOrdr: A9a23:YIiFOqgtZLhZPeRnl5wN0WbmmHBQXzt13DAbv31ZSRFFG/FwyP
 rCoB1L73XJYWgqM03IwerwX5VoMkmsk6KdgLNhSYtKMzOW3VdAQLsN0WKA+UyWJ8SdzJ846U
 4IScEXZLLN5DNB7foSlTPIcerIt+P3k5xA692+815dCSVRL41w5QZwDQiWVmdsQhNdOJY/HJ
 2AouJaujuJYx0sH42GL0hAe9KGi8zAlZrgbxJDLQUg8hOygTSh76O/OwSE3y0ZTyhEzd4ZgC
 D4ek3Cl+6eWsOAu1LhPlzonthrcRzau5R+7fm3+4Iow/PX+0iVjcpaKvy/VXsO0ZiSAR4R4a
 HxSlEbTrJOAjrqDxqIiAqo1A/63Dk07Xj+jVeenHv4uMT8ACk3EsxbmOtiA2jkAmcbzaBBOZ
 hwrhKknosSCQmFkDX25tDOWR0vnk2ooWA6mepWi3BES4MRZLJYsIRapSpuYeI9NTO/7JpiHP
 hlDcna6voTeVSGb2rBtm0qxNC3RHw8EhqPX0BHsM2I1Dpdmmx/0iIjtb4it2ZF8Ih4R4hP5u
 zCPKgtnLZSTtUOZaY4H+sFSdvfMB2yffsNChPsHb3KLtB6B5uWke+M3Fwc3pDWRKA1
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.98,288,1673931600"; 
   d="scan'208";a="21607528"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-MessageIPDirection: Outgoing
Received: from esgmtwex19-23.win.ad.jhu.edu (HELO ACHMOBILE.JHMI.EDU) ([10.173.132.223])
  by IronMTW4.johnshopkins.edu with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2023 17:38:40 -0400
Received: from ESGMTWEX16-23.win.ad.jhu.edu (10.173.132.123) by
 ESGMTWEX19-23.win.ad.jhu.edu (10.173.132.223) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1118.26; Fri, 24 Mar 2023 17:38:40 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (128.220.36.245)
 by ESGMTWEX16-23.win.ad.jhu.edu (10.173.132.123) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Fri, 24 Mar 2023 17:38:40 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PjzWxXIExjBi59sKS+EZLHoMdJVo5uJG4dL9Ikf+bsmExvlf2VWbsNN7PMLOqhlhG5LYKQ+BRdc94gX9YyJesu/Sar5yfQUUQfs58a6dgQ1Ao1RLwlKcg49dfuEgC2qCuxT2fDjbwBX4dbWkMRoTtfOX9P8Lejv9aGtMSl30R9Ap2rtJ2TFG/HqnNtF8FFYjIQJPmeAz83npOOe2Dz1g3WyQDQ1Vshx1f2Ug0EkwnbC1irq6i3uemVJZ3Hsa9bGvHe/2/brwJG+bB6cO/LDafSpmfm9eAChj9kLl/6vMrISOrGnJeaNjzRNytvgAWO9FEdouqYSJFOq+NioNJ8ZTMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zKmrUYVXwqdUglgXTCuNoxS2Iy8IqzslrW6cbD9h/94=;
 b=glKIQFyrZc+/0AQC9Nq41o3RpRXwN7pg9TpaUHnznHbSvoX98jTmJFMPqkoaaLISdleKdmigaVMJWJTtCD1hcu7FqZXeDLPuF/gMNK5GdErC0220sEuojdTatUhQ5FVVnahDwFC5ASE3u04jZ1S1dlz6rq6Qmvs+gyazHAYsy0O7egvGH6bv/mkLEYuHeJsbTJHzwXwfct1d5E+Kx9Am/YDbWdUQ0lnaolewqQmmnccU/Hxl/eo9UrY6jj9HPxIXGDdcPEL2RQiEA+Mh5937sGG0M6pLI/MRuHK2VUB83B5q6g10UOvR6vTYH6f0FA52wFtUk/U3sqjii8PeaRlDeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=jhu.edu; dmarc=pass action=none header.from=jhu.edu; dkim=pass
 header.d=jhu.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=livejohnshopkins.onmicrosoft.com;
 s=selector2-livejohnshopkins-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zKmrUYVXwqdUglgXTCuNoxS2Iy8IqzslrW6cbD9h/94=;
 b=S4/9dmhEU5nAOgtlKzL5zufqB0NZgbPYiWLRuiT1+qtB3UHxuoiIU/7sHladCJKZpsP+7hnKk7Nj1Wo7C5cRlfstxGaopwkrCdJiKSityb3y1bKnmtpwwCyw+V2EBaFWX1JDZg7cHzlNLpp/Axedj3DXFy3bUt9yfBTGRNIbXh8=
Received: from BY5PR01MB6100.prod.exchangelabs.com (2603:10b6:a03:1ab::26) by
 DM6PR01MB4747.prod.exchangelabs.com (2603:10b6:5:6c::23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6178.37; Fri, 24 Mar 2023 21:38:38 +0000
Received: from BY5PR01MB6100.prod.exchangelabs.com
 ([fe80::b47d:4bdd:536:2dd1]) by BY5PR01MB6100.prod.exchangelabs.com
 ([fe80::b47d:4bdd:536:2dd1%4]) with mapi id 15.20.6222.008; Fri, 24 Mar 2023
 21:38:38 +0000
From: Alexander Shumakovitch <shurik@jhu.edu>
To: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: Read speed for a PCIe NVMe SSD is ridiculously slow on a
 multi-socket machine.
Thread-Topic: Read speed for a PCIe NVMe SSD is ridiculously slow on a
 multi-socket machine.
Thread-Index: AQHZXh2z2NkXUzjTO0KKexGZO2Rp268KUyuAgAAikwA=
Date: Fri, 24 Mar 2023 21:38:38 +0000
Message-ID: <ZB4YXKctoJ2DYfd7@hornet>
References: <ZB1JgJ2DxyTMVUHB@hornet>
 <ZB37W2dfqR4sgQWt@kbusch-mbp.dhcp.thefacebook.com>
In-Reply-To: <ZB37W2dfqR4sgQWt@kbusch-mbp.dhcp.thefacebook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=jhu.edu;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY5PR01MB6100:EE_|DM6PR01MB4747:EE_
x-ms-office365-filtering-correlation-id: c19bb60b-837b-496d-ce08-08db2cb020e4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UjLANzED7R9OzUkpfyp6lGjmvVimndV6WSaSFS9XN0ha1527561aF822Cxjo5oFxP7n8psu96ClJmKpQSMqUdT0p5OFTWWYxLthIk3cIhBoNi8vPqAgfhKP+dXp4ZQcVgU0f5w6jhv0ldMH+FrTCbxPirlD9je/oBYa7iS3Y9JPolRRn2f2eqPRnPzcq1jW730Y+UpVONoiopjcjpxL19F6LTeS4hMS/8qdR7Ad/6yMVivUskML62uj+yxPF+kN837RoZ0CmY3XdjKExmhcxqI8FG9oLBVi7B7OoFXJUTBv3YVKAGPlEvzLPI6lOqEg+HNWivtInizMFGy2JqyaZXhovOxyLKnScVAAapPNfbChnD98OiLvneyULFiIdd54fUE1btmvty7Zf4Pr2kdLu04Qg6JnHr9jbU8vxglwF6l7B1Mh6v6ccpICXkSKLMxQj2uWdjDPTqh1KEWhMC/IE8IuFsKpfr31bI1J3LJGeOxc1tg20KkycXaEoW2vDqc35mHdKu/rnV2SPrWkWWvHfC/xCISOLrC69TbTRhVGkuqO9utcakJ95H3FNQMiBsMFkVuoaeKP4a3DlXiHDX2gJEsyX/rIXFfzf3F8okD+VaqeHDB9GM0cfuYHJP/2/9XK8Yr40S2YCo/S8CjR/q/khsxTbWoCCJPMOCw49Rk+OHpuH5fZ8h/4TeT0ZipHXxIDcz4sZMriB7JyJuiGwu6rzng==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR01MB6100.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(7916004)(396003)(376002)(346002)(136003)(39860400002)(366004)(451199021)(2906002)(478600001)(41300700001)(316002)(122000001)(38100700002)(38070700005)(86362001)(71200400001)(33716001)(83380400001)(66446008)(75432002)(76116006)(66946007)(66556008)(186003)(786003)(26005)(6486002)(4744005)(6512007)(41320700001)(8936002)(5660300002)(91956017)(6506007)(6916009)(9686003)(8676002)(66476007)(64756008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?koi8-r?Q?bqUkNlEPX8E7uoxdDsN66FQIgWsezEwbVzQs/SwwtO2WO1+my/GJKOKNtl+M4x?=
 =?koi8-r?Q?TGRp+uC8Dsw886Cdl8W0Ll8MQsfvfDdHIC7lwwsggOhT4M9Dr0//6bRU8pbkd0?=
 =?koi8-r?Q?6lQj0DOKlqdFc72KcT/mlcJsasqtjzPIW+IoKPayM9pY/0ADuyL8wRMJ8EdpIT?=
 =?koi8-r?Q?TwaQgqDCkWq996nboQarahrk8Odfz9XMc8NFtua5n/xpHRHsr/vS45Yxe2JXt2?=
 =?koi8-r?Q?IRcd4u/T449h372a1FnmVCH9Hk+ZWTEwfVDtFrCyrV+VY1pi2/JnIyOqU9E2Yd?=
 =?koi8-r?Q?BwKA98F9ULahL1oCA1kFaF5m/EVpyPWmmIw/CnPIUackMNuBsSRpoPX6MB/tov?=
 =?koi8-r?Q?Z2zd6dJqNBAk+MzjKW2vekTC2fyQPM1KfIDuYCZvg5fGiQQrJurwz5slSuYzap?=
 =?koi8-r?Q?ellvEjqGrEEZdpUuvtODtMG8uJt4LOe2E6WFSjJp6dDeGSIWx9K8kKK5JYZBg1?=
 =?koi8-r?Q?5uXU5yOyj5PPBC+ku0Kqa3U5r2YW5aDzD9qJeAB44QlAkbw9XUEWxINGmyN5NI?=
 =?koi8-r?Q?2iNuCN2NpUUM1UshGb8Lg+lb3JjoXTnbL9wz4nOdF3ToDB5ovviIzEfXUsm/ry?=
 =?koi8-r?Q?zgDMZD6xHsSG6MIDK4d6X5aoT33AD7nosFaMn5zdZqhnCE5o57EPKsVGBiaNYK?=
 =?koi8-r?Q?g3FgPnl5CaQz++M1Whg15VZyK+nAZjLE5jkfRiz3qki6MJaVxwFE7c6JtahjAo?=
 =?koi8-r?Q?k5xWsHTMG+XzWPkisNql+kDws5vw5uQMWBIwjzsnFw7OCRCH5YQdGOuuQs36b2?=
 =?koi8-r?Q?H2eM/ksVhj2bfr0QvKMP/+6tQZtCjy9v0is1nWmc1wXwoW0eKv1Z0QD7JlrufO?=
 =?koi8-r?Q?yhUZUHvt9OresBkpBzq248Odqu2UDdrzzDtCTqoIgpraHKTBC1RerYmWevKIYq?=
 =?koi8-r?Q?QUFNsvNvntnyYFIkp3/aG7Re/V1/8ZlKbyZZDuOtkYN1egQxPOGjx543ZEcRly?=
 =?koi8-r?Q?4ncm7VIW3/1Y5oMvR9NbuWOeNeCmvfD5eAD0O/PfZrmhmeWCZaePzeTRe7yCfG?=
 =?koi8-r?Q?AyT0LKTodAE5nWDth6D9Ep7HUVYdXB4qrve8Affksssu3DxaKX2mmW2Zitocsx?=
 =?koi8-r?Q?FK4RxUJvud0tL7S+VGAIMgvgt3oA6L+Ic0no9E7qnFQ/l6zYGMs2y9+oDfbkCm?=
 =?koi8-r?Q?QNpxxoXB+JCC9/j8txiWRTHCT5G/anSgU2lDTjl5MRIlcxqa+J439C9ojS6X8d?=
 =?koi8-r?Q?R5+WI7flNpMpPK9a64F3sExFqW98Qk/68jjouBduRRoDpKK04uCahN85lrpu0u?=
 =?koi8-r?Q?+ew/S0N5T/+Uc0VYp3PgRbsfcb4DcMe60rliUqJrLgz7Ly7qjTlhCSYki3xzP2?=
 =?koi8-r?Q?DJFUFiIVPsdaoKPPkAngthPgWsF6pTVE6Q12birqSL5KvZXK03MK6/4zlMiWj+?=
 =?koi8-r?Q?/yHixws0o/yTS/Rh0LWrtkPCdt24CxlACslBCFEuNpYLFYE3vSXi48JRUAF4PP?=
 =?koi8-r?Q?BDxBI7WsvhI76QC3bIiC0e+KrWD3+qD4WXQE4fE8SC6WT31UyjqTjteKygaCNC?=
 =?koi8-r?Q?/RaYqujUBMkQ49G1dqmgsO0rCVLaQrP8SrN1nc3UEyxRGYyCUN?=
Content-Type: text/plain; charset="koi8-r"
Content-ID: <1FDB93C57699F3489ACAD595653137CA@prod.exchangelabs.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR01MB6100.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c19bb60b-837b-496d-ce08-08db2cb020e4
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Mar 2023 21:38:38.0613
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9fa4f438-b1e6-473b-803f-86f8aedf0dec
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GjYMcmcVhRyHbSINFCVHuIn64lviat/BTob14YMEOECOrIGEBBvfCdXOa87QwjKR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR01MB4747
X-OriginatorOrg: jhu.edu
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230324_143845_449317_7D7E3C1C 
X-CRM114-Status: GOOD (  14.86  )
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

Thank you, Keith. As I have just written to Damien, I've started testing
this hardware from a live USB stick distro, which included 'taskset', but
not 'numactl'. But given the large amount of RAM on the server in question,
the kernel should have taken care of the memory pinning anyway.

In any case, it looks like the main issue is indeed with access to the read
cache, so now I have to figure out what to do about it.

Thanks,

  --- Alex.

On Fri, Mar 24, 2023 at 01:34:51PM -0600, Keith Busch wrote:
> When writing host->dev, there is no cache coherency to consider so it'll
> always be faster in NUMA situations. Reading dev->host does, and can have
> considerable overhead, though 10x seems a bit high.
>=20
> Retrying with Damien's O_DIRECT suggestion is a good idea.
>=20
> Also, 'taskset' only pins the CPUs the process schedules on, but not the
> memory node it allocates from. Try 'numactl' instead for local node
> allocations.=

