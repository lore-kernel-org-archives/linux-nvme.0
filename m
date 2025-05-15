Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6541DC2D0CD
	for <linux-nvme@archiver.kernel.org>; Thu, 15 May 2025 14:09:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:References:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=E2LuNiw5VVbrbUE3noU8Qlop2um7a2h/4VtH+fxn7vU=; b=iWe/u6yn2aXEyagC0VigaEDslb
	kQnA68J5Yh22b0mh9TlZ5U3JpbtxZn36H8lKzqAW4XD+uVk8T3SlR0GQOlTcc4kJ86dIxhwx6Xm10
	Q+j74B6UD8qBbR+r/YY1mqEnTFihurSaRijeFIhphqcWSJ8Itu2hh+hjXsd7RuiWTeDYJH6DwxTDp
	5GwRrmYwNO0i32CDwe7yUD1oJ3S95kV6GzAs0+Jry4Pwvuux610cDXPp8fOiG/5yY6zJYKGtZ56Gb
	UFWSo7YAVExVPl3Wh3KKsvBWUlhXYrdyldo5I7g5NeHDnVtquxBAYFsuMRqN4oR8/Zxpuk8UB6VdN
	F8tUr/OQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uFZHB-00000000qGd-1UCy;
	Thu, 15 May 2025 14:09:33 +0000
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uFZ9p-00000000pM6-3ApQ
	for linux-nvme@lists.infradead.org;
	Thu, 15 May 2025 14:01:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=sandisk.com; i=@sandisk.com; q=dns/txt;
  s=dkim.sandisk.com; t=1747317717; x=1778853717;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=W308OINfqtTSAxCZVQk1xXIfAuuJKK7ApzOVCUsFBnw=;
  b=itIVBK9wfQEiA5CyXwyHYrJ4XitgLFPUOLsf/IKj+R6n/beKtz/JU1rf
   CUXAmrJd1xqp2v7UcUqQtpCSoUmQKOS4tMDqGZQM00x3L7zdoROJVCX0L
   g5dlM/7UsQv0+J/7AA8QylB4Ijh95GEsQiyg8dD+siT702yP4FIRmnf7i
   OyIm/3u9wC/cYKgN5ZOW0vIrM8yH9dOT9rnLkkd1fH3barQJdb/ZjTMJ/
   giblEH9aQruI72H+cgeS4Z9ZS684/zUMjEpgS9iZHegoFr2v7NomIyn6D
   BfPT+s2h9UtlSS50fdrz/WdjO7c9cw5eT9zASjldy/oOaKSQqFUOFdswP
   g==;
X-CSE-ConnectionGUID: nyANSSviRea98O38j6wPow==
X-CSE-MsgGUID: pAB+bOwnRQODlhI0e/AA0w==
X-IronPort-AV: E=Sophos;i="6.15,291,1739808000"; 
   d="scan'208";a="83390008"
Received: from mail-dm6nam11lp2170.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.170])
  by ob1.hgst.iphmx.com with ESMTP; 15 May 2025 22:01:54 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dPKkhW6WshV1ECswAA9gqLLuXa08auhp49I7SHXkcG2OLWhPnivN8my1uC1iT+oJHsEumfBV243hT80//yoA0Fh0idm7jtJhOIVc47IOkoRTbbv1JQ2vpYSz2V7fnOtUFkM7++2rluQkXzqQX23mpyRUg2Qtk73Vs1wZS0zzUqqJWk2pjfgb5CAtnwVamwA9CKtV9btiMZCmg5w6U+RbgkIOeUl5lUOhql7I45t/lEQ2AS4eZ0BeArofps/XNoj/ii4YUWyUviSAZGuiMjlAM+XIcx9GvIHTPfU1ECIDSeMVVjjLmM7ZkT7OYXaFxusSSoi2hYVll7gnuc1BuxnwkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E2LuNiw5VVbrbUE3noU8Qlop2um7a2h/4VtH+fxn7vU=;
 b=HRflzI8+Ijr8UweS/+3ieCPFj00hUkyvZ/uYxF/KGRgStlMtwpukxf9l7T0ZuvtuPSASfp3RWl+4QEpjVnEXh5WN9ERLr6EXyBCK9VYOLzCFMorVybBug2AsuRxhA1pM4Sno0NvT4eZMAMSr2qBveqasOQX7yNE5eYYjRXVm8mN9U8wdQMVNpdbSITEOhpTGic4j9EywD1VarV0HlYF6OSWx6ujgA1YcbtxWNzlFLlDCtGsFMyoA/W0kUh5L34hx1Xaov42mIXCr9YAAsioWTwzd9Da81vuSPuTTY0bIpaONAWLIsyLzBgfjDVq0IJ75iSzoEFYD7DzR1qfwTNumRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sandisk.com; dmarc=pass action=none header.from=sandisk.com;
 dkim=pass header.d=sandisk.com; arc=none
Received: from MW3PR16MB3897.namprd16.prod.outlook.com (2603:10b6:303:4b::14)
 by DM6PR16MB3848.namprd16.prod.outlook.com (2603:10b6:5:2b6::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.31; Thu, 15 May
 2025 14:01:51 +0000
Received: from MW3PR16MB3897.namprd16.prod.outlook.com
 ([fe80::6136:ad4a:206:ef35]) by MW3PR16MB3897.namprd16.prod.outlook.com
 ([fe80::6136:ad4a:206:ef35%6]) with mapi id 15.20.8722.031; Thu, 15 May 2025
 14:01:51 +0000
From: Jeffrey Lien <Jeff.Lien@sandisk.com>
To: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
CC: Avinash M N <Avinash.M.N@sandisk.com>
Subject: NVMe CLI Invalid PRP Entry Status Failures
Thread-Topic: NVMe CLI Invalid PRP Entry Status Failures
Thread-Index: AdvE7w6q52drpo4qQN+ACRAqTC1lTwAstiFQ
Date: Thu, 15 May 2025 14:01:50 +0000
Message-ID: <MW3PR16MB38975C2057D1EF440FBD60B0F390A@MW3PR16MB3897.namprd16.prod.outlook.com>
References: <MW3PR16MB3897F0E659B34877C4D5197CF391A@MW3PR16MB3897.namprd16.prod.outlook.com>
In-Reply-To: <MW3PR16MB3897F0E659B34877C4D5197CF391A@MW3PR16MB3897.namprd16.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sandisk.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW3PR16MB3897:EE_|DM6PR16MB3848:EE_
x-ms-office365-filtering-correlation-id: ad099600-10ec-4013-fa8c-08dd93b90a77
x-ms-exchange-atpmessageproperties: SA
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?39c92rpqhv7m9oajZTZQ/Cx9107ZyQnZTGW711c9ZwGpxmf7bGcUNYmWWN?=
 =?iso-8859-1?Q?u0lKLvq2WW95y8LIYgmmNDG2zG3JsByCxMx3OTFwaO4TjOZDO3vkKgE2dZ?=
 =?iso-8859-1?Q?9FTDnTOLkZRXfRKk7cyt1LzE3uKSt4u/8FzrKba/o4xXNc2YmUgcaA/6xi?=
 =?iso-8859-1?Q?o/8yBFiygeYS7eNBy9t7VCb+yrE5KHw76BEMCELnsFVu0O6fVX0PXZRfcl?=
 =?iso-8859-1?Q?pJsKK/Q6ZTIvihCai3PggIgHMV5KA/9QcnjudCL6hSeHPBOOuHf8/ae1f7?=
 =?iso-8859-1?Q?FJw+dkjwLkO3nKMXWJ4tLv75ZneF5ED8zv0tM5vRdkH7l3TA9TpnN7nsmx?=
 =?iso-8859-1?Q?/6zDRux3VPJwtmDJss62av8ds4ewCqF5eE/AbDS9C1h87TFTwBjvm05k3W?=
 =?iso-8859-1?Q?ZfhN52GoWR/UCK6PQNrFFDRYQD6a3vjIo6ht0ijE20DFPHnPsIdGgs4bKf?=
 =?iso-8859-1?Q?ymboPfLL+2YZ2ceNrZnL057N6okFP6+oUvbKHFYr2aI3tq+618gSgzS3Gk?=
 =?iso-8859-1?Q?SlVLYAxoBL+3QeXTkmB7ksPUInSDBkroeTzvNZ396EhoW2JvWih1GIPAMh?=
 =?iso-8859-1?Q?KZW5mXD5eukkvxK208A3BHikZbdrVV+2/qzx9ETH8LJR/IVz1erk/WjsHB?=
 =?iso-8859-1?Q?kgKaKbWURQCteYWP5j4ccMmftzWXRk6YMauNBTGIuKbe0PmWQ9VP8UbpIa?=
 =?iso-8859-1?Q?+C2Kw0zmtsl8Yc7ylr/gJFba02unIMPqiu11BKOC2vXDH6orpt3qB2ArDz?=
 =?iso-8859-1?Q?qp7ZygpRRUcNwa8467R9r+e1pv7vQj3QykF29mtpyugzGonznNLQAXTFPm?=
 =?iso-8859-1?Q?/LZf/C+0MyfpG7U5ztXtx8rGa0XkOq7blJly4G2JEQlzAJDg6kKOlZz0c/?=
 =?iso-8859-1?Q?Qh18zUokzCRj2ma0HYhrBK2yqZwJms2CP6MzMQrRjAT2VR4yP22hhXrrbQ?=
 =?iso-8859-1?Q?iI9BzbHVRLARr2i/GmvO2ZBTGNiKr46IE3ERFQ//n6uUMJPbdLiS/L4Zec?=
 =?iso-8859-1?Q?sREMVIKIFvZ+DKaP16GsnFZTEz/8c62H8CnrRVbXst+p8YqrDnBXhsd7Go?=
 =?iso-8859-1?Q?Mp/F3bUPx3Gic6/lLEnX9lHjPDrxg5Aff/as3qaz/6xvdjbQphA+2lvYSD?=
 =?iso-8859-1?Q?pTI0s/j21S6zuGa4Zua2LZhvirVKqoLNcqJ6Zk5Lh/XLcuIjT1BHv49U8l?=
 =?iso-8859-1?Q?v/ST9bMVNZfHJsLIYhLXi45IMzY3vyc6WSbkOeRUiu4z+ih6qM9hpj16iN?=
 =?iso-8859-1?Q?X5bylPisaedu/PJ/AJwvJkO35A4OBnREmt7czLD024ZT0RKMuLHNTrI2eX?=
 =?iso-8859-1?Q?Ukw4rLIlivSnD7a03wAv/XD9und3eI8b0FVSBmuK4Kbhdg4qC05ZLjeFia?=
 =?iso-8859-1?Q?jfraaPjuY9Ky9jZerirvzkeE+apeinmda0iXCIfye32gg78S6/08dgI5AS?=
 =?iso-8859-1?Q?wBs8uRTSGazNfw5NDoVnmFRJ5ZQaGBI64WMjN06Thg9lyqugCOg6nujvpm?=
 =?iso-8859-1?Q?9oiR6ZMQFpzUMR3QwDN/PlHarAA45dYPSnFOHBZhpm6QIxug+iIeBvMmJz?=
 =?iso-8859-1?Q?6rK0nQQ=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR16MB3897.namprd16.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?wW7JLnJxBxDak7tfpFgZw+v35Z7T91lOb43+bD29bFg69BpACXrptB7gOR?=
 =?iso-8859-1?Q?os1f9ATBeIDrH8H8lospfxgLG9Nzrqr66K9+NOuUs2p8EGZo0bDXrfzoTb?=
 =?iso-8859-1?Q?SrSRRJ22hgIazVSXqGOrUefYi9D3wdgVz7t0GeGR97JGMja6mVQJH/Iftz?=
 =?iso-8859-1?Q?hhA9rfIaWUdOfDs/i7pcCbfhrP2J8tIvHW3NA3wn5I2a8lcMYLnDL2PwmO?=
 =?iso-8859-1?Q?hkF3o5RiAeyr9iJzFIJlTbYBBc5wdZXO5giluOmoI64W8p60Behb7HzJX6?=
 =?iso-8859-1?Q?GVVba/vv4qsKZzEs3yTPQYM1Ok6UL9vAPqVvJR+ANm/tMhUIZY6qpE7wVB?=
 =?iso-8859-1?Q?rhE1vuCM2+AAXfAhW1+0BPSLQpoqIhNEfEXFQ7HFFgITNWBw54kuM5Hl2Z?=
 =?iso-8859-1?Q?5MMuV+rRYqzVo+NwRqay4EDd7yOjciyeTWWx4QKzsUot48u1/b9g7T2Dx2?=
 =?iso-8859-1?Q?+yadXeJunhQEGvkyeOQLC+Fxc8fOaPFRXe81yXpWwE7nPs4dHjQbFezkJB?=
 =?iso-8859-1?Q?Wjmh71C3/pZeS7Q8YFFPay7YcRjsTjLADcbF7ECeBEmJUnu6YKdkVaX1zj?=
 =?iso-8859-1?Q?uqZgiSti2F6PLCtr3q2snbDA9NMyCcMhaGiLVS8XEQ13HAFsSbZdsA93aj?=
 =?iso-8859-1?Q?BR6VdifWywqKmhkci6TLjAx6mQTFKZDwl90qv5t26AsoFh2CUNb4+wwd6V?=
 =?iso-8859-1?Q?glLRpJ/QovqgPw12PdP13raReFB2v7JIYSL0Eeon9YmVRtRvcxznAOrRDS?=
 =?iso-8859-1?Q?45tAJmlF5x1JjocEGXheQ1IWPcCTnRVIz0vhPyKHsDwjUEEYC93HKWxgxA?=
 =?iso-8859-1?Q?qh8VrcdBsI/1ul/l3ua65NpLqvWJ0PXP+jwWs10+uW50L0oD82BnWcmvMy?=
 =?iso-8859-1?Q?KM8XLcpBGO89eNAl351NSZrDUdnwXuHRaYFDRXrUfPvLDARopRYCH+SkV8?=
 =?iso-8859-1?Q?5p0GqaDs0gG7lKhBVbSMqE08CX3FPyW4D80jMY4OlmPpnfkLt6TFa0hCKq?=
 =?iso-8859-1?Q?5WY5UWFYewPVlRvhHJDAh8QoKTvQmlvdci9VKSmWfTgw7DaWT3+W4Ecqmz?=
 =?iso-8859-1?Q?mPFodOXsQbZFR3M2YH/otVdtsrDJz2ffVifpLXPyoKCioY09UrLAqhFw3V?=
 =?iso-8859-1?Q?VPuyr0AK+vKprxDvG4DGo7BEE0nx/2SPJAztmzClPuTtUFvB3tkci/MX7P?=
 =?iso-8859-1?Q?WwTImYSxT33FPDUbeq1XRQyyrvOb1684yqlhg5xas00MVczG0az2gYGBvs?=
 =?iso-8859-1?Q?0tlyafPyUdpeWvi8SARbMIbkZ6Gz0sSRPTlDxMotzIw/hdft/zeWcQZNPN?=
 =?iso-8859-1?Q?6Uu25NEfLVeqDP4o9vnuyZn0/NrFONVHMSCtKrL1LMMAo2GOmExolg4Rh6?=
 =?iso-8859-1?Q?fRvJEHok0gfxRdG6ZjyCFkssdiWpQkIxn8JSpGOm+wEj8jZ483pOIS/ftt?=
 =?iso-8859-1?Q?D0Ch5fSDIiKJMZ1ZU/G4hud73owMXGXnDx++3mkviTZ/UzZvO+Ko6Q+2Kt?=
 =?iso-8859-1?Q?vTxN9zPsB1tbHTna+46xp0yVf2OiqGOQMWIfftAxfaLbr7yoiIOJSgNkxe?=
 =?iso-8859-1?Q?EkhFv+datOAK8jGpgX8UzoFp17a4kqMhsUmx8rLyIc8RsPH/DXKKNR3Y87?=
 =?iso-8859-1?Q?TW1HnR2OV9wyV7NXlrrnnXfpZRbYRmNJ6L?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: BW2jU3gzCAlRCGlIFaWy8hiPFGRfIKcZkf/PGyokw02dhJqHM/hHcyX+lU1oz/WBOx/y8gDQ1Mg7X7ECOFkk6tqFSyKvEsCwB6xJLi1OfLchvunNus6qKmrvsu5LoYFCCGbtcwPC0fAm0eOY5l9cKYxWEGWUMVcQDaKJn8eEankQiJg8bndprR43ZLtECkxWHmSSjQH300rW1fCRCX7lKlWGKzm7U1cyASDHT3hKqYGgw0qJcdxjHc6W0aEiQ2QZzUrsXmoFgP27Sq9pk3uZDEossFuUysRrxs4qWArbAz8R4x6cu7X20sfJyTVZk5Y8YpuzGeW/NXMyZAbV24k+OeBzHp2lui21Nx1cP3wcSfM1wVoX9+B925sqDjp6bT+0WyUvCZjlAfApJ8gK+UxEns1GjraCef6lPO71gAGLoA4tuWK3/HD23ZPe6j2Gk1jqBfFYZBtHSXqpmQStALDEwVRQqmk/4xv668Loe6GfXW3xH9hXXOmsV7FkcCm+6yU7YYZx6/cv4HRoym2y85raVb2ZVawqNi3Nk5vHNoXvYsGVO4ntc5MptEqUsp42jye7c5CeTN51k3hbYch7ShlwDlc5wUsSuXTTRcIAhtZu/PVdpTr5Ke7FaAT1ATVL58mic43KxjoRYtLEhb4uMlnXew==
X-OriginatorOrg: sandisk.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW3PR16MB3897.namprd16.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad099600-10ec-4013-fa8c-08dd93b90a77
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 May 2025 14:01:50.9819
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7ffe0ff2-35d0-407e-a107-79fc32e84ec4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ChDTQ9PlYbPzgz4UVumlX5EXO43PhzXcyk73xdjM4fNOEexObl/YeIKG+SL+8EXvUsGUsoj5I81xg5BXzXv2Mw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR16MB3848
X-Bad-Reply: References and In-Reply-To but no 'Re:' in Subject.
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250515_070157_869718_AA3A474A 
X-CRM114-Status: UNSURE (   8.39  )
X-CRM114-Notice: Please train this message.
X-Mailman-Approved-At: Thu, 15 May 2025 07:09:32 -0700
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


We are seeing invalid PRP entry status failures with transfer lengths > 0x2=
000 on nvme cli admin-passthru commands.  This started happening on the 6.1=
0 linux kernel version and the commands were working on kernels <=3D to the=
 5.15 version.   See example commands below.   I didn't find any obvious co=
mmits in that time frame that might be causing these failures.  Does anyone=
 have any insight to any of the changes that might be causing these errors?

Example command: sudo nvme admin-passthru /dev/nvme0 --opcode=3D0xD2 --cdw1=
0=3D0x12600 --cdw12=3D0x00010132 -l 0x2000 -r -b
=20
.	Initially any transfer length > 0x2000 fails in invalid PRP entry status
$ sudo nvme admin-passthru /dev/nvme0 --opcode=3D0xD2 --cdw10=3D0x12600 --c=
dw12=3D0x00010132 -l 0x2000 -r -b Admin Command Vendor Specific is Success =
and result: 0x00000000
=20
$ sudo nvme admin-passthru /dev/nvme0 --opcode=3D0xD2 --cdw10=3D0x12600 --c=
dw12=3D0x00010132 -l 0x2001 -r -b NVMe status: PRP Offset Invalid: The Offs=
et field for a PRP entry is invalid(0x13)
=20
.	After few retries, even lower transfer lengths start failing with same in=
valid PRP entry
$ sudo nvme admin-passthru /dev/nvme0 --opcode=3D0xD2 --cdw10=3D0x12600 --c=
dw12=3D0x00010132 -l 0x1000 -r -b NVMe status: PRP Offset Invalid: The Offs=
et field for a PRP entry is invalid(0x13)
=20
$ sudo nvme admin-passthru /dev/nvme0 --opcode=3D0xD2 --cdw10=3D0x12600 --c=
dw12=3D0x00010132 -l 128 -r -b NVMe status: PRP Offset Invalid: The Offset =
field for a PRP entry is invalid(0x13)


Jeff Lien
SW Tools Development
=A0

=A0
2900 37th St NW Building 108 Rochester, MN 55901
Email:=A0 Email:=A0jeff.lien@sandisk.com
Phone:=A0507.322.2416
Mobile: 507.273-9124


