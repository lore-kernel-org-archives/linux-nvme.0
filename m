Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8D19C43334
	for <linux-nvme@archiver.kernel.org>; Tue, 28 Jun 2022 08:54:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8X3lkb7Yk4DF+vQaeMwF3GKM3wMHnn/ZLBbrw1H0NtY=; b=p9EGyIYnNDDjINhVWteA0RWf2j
	Fg0W43oyCLGK4XKtbPkDeBpmFhX/jRQSx8MlodehYSEy2HUAC3QiZxVkyFaBO2piaQ5buDL6AAKAK
	+77TWoVH/SRkRTqo2L/+kOhxeGJ5KAQPBQGPekjhzMvlu4TBcfPHatcjEo70wUKyQBPnK4HOGSufb
	sMNTT3lI9rsOvb+Dfb38COtq8Hd/jGxfVhRIkd/voLpsIk99HLerRNiN79j2Hy4dPKVwBdsZBeASX
	mbe7nQ0E3covIozwkz0DoViv1dTBxzskUKlUnYSfor51f/OZHKK+DC2CGS7UymIlvSqEzhCUb8JXI
	+l3+FfUw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o66zT-005Nvc-I3; Tue, 28 Jun 2022 08:54:35 +0000
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o66zQ-005Nt2-Nt
	for linux-nvme@lists.infradead.org; Tue, 28 Jun 2022 08:54:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1656406472; x=1687942472;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=8X3lkb7Yk4DF+vQaeMwF3GKM3wMHnn/ZLBbrw1H0NtY=;
  b=rsjf0StigCaRdYvFIpYXty089Za0rQqHapFTVGOTJbNF/NzU4V/w8ds6
   pF3DF1Xh/VQDvKUlQaz3ODTHfpjyRaPYRJIzP0+QGSofqXGjZZodh4wM8
   kbZgjhb4ft3EEHudhdT+NhqbYeRyITX2hG+Np3ZKwgYiZ5itOiuLSQzEQ
   m9crtKgl+FTJGY3eSGjcubr+eMIrklrZMKLmrTOzvdkit20+nLTqelCEB
   DVBGLecoYeAaV+T39NVF5aX3kgUWwmT4IeIiBqYoBGW86WwfgktFstUY4
   aJHhK246ZsdLjpLIpZxIV8SCQHqrASqd4LHvLb2qWFUq3AW1dayVryOI2
   A==;
X-IronPort-AV: E=Sophos;i="5.92,227,1650902400"; 
   d="scan'208";a="204274858"
Received: from mail-bn7nam10lp2102.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.102])
  by ob1.hgst.iphmx.com with ESMTP; 28 Jun 2022 16:54:23 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bTWeiU3Yr3NHsZPmoblTh8VRrpRsTriDt9L4tGtrla5L9PxbPMWqCfDX2xF2xQn3ezQQTrePaPktF6vqAB2A2f1olEYhKy+Fjc+ACsVffrT+7BEyZjQh44+UA2+Nz9F6WkQtD0yOQJwDY+TAy/ZiFPxjlapq7+p6Fjh3N4JbVrkLJXurwfESzTQx7cWz5T9d6TN8JoKFfcMiIHPypS/YhTuLs7XDk6eI0GTvcMBLcRoLL0RliAWgoEbMHe70EjhFwLF+ugE7EyTDhRMW+qUYqhkPbjgKhedQfDGNll/moSTVYz+8RogK3wLgeT00ujrhSg0IlSdACxRX1o0IwuHceQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8X3lkb7Yk4DF+vQaeMwF3GKM3wMHnn/ZLBbrw1H0NtY=;
 b=SugVbFDALyEHBqrh8uVMPYt3ffb7IdZJZy2oVCE5Hu2FTOtsP2+qKhtXTbJOICU8pj3QuA2nQQ74y7S+42Cb7EU48Vwcb3lVTBSVF1pJLuM7hGS4IB6wwgbPoeFTyLfBU4C6pE23GLlKk6K4TzjIRyzy4eGDmjC1uzhaPmQUbyOwbFCadxycOPlWIdHxcRhi8x63kirJISaQWnorGv8i0ITSnXSQqcRMrz6bG2nbBMWs+36noiq0OhMbIY8upfcz1H/xI5f05j79VSl8LjUE6JTEtaRw7UitQjYVa9zIfaU4xZnsNfWmbHIQWVuOr4NYp/v0k1MJpp9KGgGMD1J/0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8X3lkb7Yk4DF+vQaeMwF3GKM3wMHnn/ZLBbrw1H0NtY=;
 b=bYUJMX4VgFxyfDbZXRV1K3sPXIubEV/WhkHjDuzy6s+sYt8ApTDYMF+qqffXjLEQTgHTdSrpp4/2ApbLT6+sQnjNtI7ibhK6hu3qIMqwo3TlpiHc+Csrjq/BBiEqdjGu9vKWBk/entdEnvCy4sCv5IGVTxU7nRrzJZv/F2rgoX8=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 SJ0PR04MB7278.namprd04.prod.outlook.com (2603:10b6:a03:299::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.15; Tue, 28 Jun
 2022 08:54:24 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::39dc:d3d:686a:9e7]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::39dc:d3d:686a:9e7%3]) with mapi id 15.20.5373.018; Tue, 28 Jun 2022
 08:54:24 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Sagi Grimberg <sagi@grimberg.me>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>, Hannes Reinecke
	<hare@suse.de>, Christoph Hellwig <hch@lst.de>, Keith Busch
	<kbusch@kernel.org>
Subject: Re: [PATCH v2] nvme: add optional ipv6 test flavor
Thread-Topic: [PATCH v2] nvme: add optional ipv6 test flavor
Thread-Index: AQHYihmIyLzVwvI5xUSBB96x+l0PU61khSCA
Date: Tue, 28 Jun 2022 08:54:24 +0000
Message-ID: <20220628085423.nr6gevmajoll3u4s@shindev>
References: <20220627113200.121100-1-sagi@grimberg.me>
In-Reply-To: <20220627113200.121100-1-sagi@grimberg.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5f03c30c-cbde-4b86-1b6e-08da58e3ccc2
x-ms-traffictypediagnostic: SJ0PR04MB7278:EE_
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  ve89CQyOVabR4kFIvDOTx8VJYn9rcSRczYKNCRqvX/EMiagJKng3FGE6gpmlZZmwgbxyohIsUHJ3JlhsA3EIyDTC73Ro7TYxyOOLQieW8li1agkjxDLK5RS6x370rVTEPbE2qksXtnzgMKgKuFgPyXI/kHQkZQBsuQ16DE8Ys4oOF8dKKVNCeqIsUJtoWNCnTDFA0bm1M2Nqev1VLekmkH29Pu/4/vNXo1Swv8wE/2ox/casm0dXf/1CSIdc28Afpa5BZ/xDfPYTQOUIv1quxZv+koC2eEcEBCKYuVQrrho53PNOKqb9vR5C1aFU+ajfRIY9UxjvU03eGniuMpYIdYN5wLNRibmEkTibdcbVtuBksg6FdhmUx8q6gDMaNyiGYNmPrjyBs02v8E1Uc8T9jylD56COmIiNvYEq/N83+dwXm5vM2vqq2B2Xw0IvP85cSlPgDnigxdE/awg/AaMgeQVkTsmfAap/gf3sskDa47Kf27Da0tho+22vcQfRQn+ZiYj4IR2I7ovyTNIy2I4xmnIVtVGTxyd/P3Ru1tomlaRd/fN52GkIDga4Ade5eNc7MfgipW4pQ2LZQac26Tq0S1RkhczFF2P5fhiUqu889/bxuIkCqqck8wLNjQW1oiUzFFCNdGTSMOxJDdsf8e4Ihv1rjY0evKsrvHF6Vp6nxZIZ5pZBpmisb/0Y8ijU4BZYq5VHm2//hPv2wRBj+lYYNJoRcyDU7v/WJvBNHU6gBmbBIdWVnWHDFYsp0l3k11KbLIntx+Fm6Euv7NHR2TjeQdUD6tMhh4iZkKR96to2WjA=
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(4636009)(39860400002)(136003)(346002)(366004)(376002)(396003)(558084003)(41300700001)(122000001)(64756008)(26005)(66556008)(5660300002)(478600001)(71200400001)(66446008)(38070700005)(91956017)(76116006)(9686003)(44832011)(6506007)(6512007)(66476007)(2906002)(82960400001)(83380400001)(8936002)(1076003)(33716001)(86362001)(186003)(38100700002)(4326008)(316002)(54906003)(8676002)(6486002)(66946007)(6916009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:  =?us-ascii?Q?n1x2aVRRDewAPAf12c2xqeXNP2mOlaFY/zI+lufDkp4hNuRByKswrGJX4sH5?=
 =?us-ascii?Q?CWECEmo8fg8L9mpCYQ3WbEK7vu6njZNL9sitKnWgnzsGP1jm7NKyMyxeRKw2?=
 =?us-ascii?Q?wIFOft1ncpkHYxc/KajfeBDd9QGnZlG9ePdL0w1vBLY4IRYS3992Ac18DmbN?=
 =?us-ascii?Q?2F6m3yzRyTv8qLEqeWockw/Ztmkd2W5v544SXFNxdiNE4RUqDNLfI9whryz8?=
 =?us-ascii?Q?bsXwefQj1iz+zEQoWkMmlA3CtE5y8Sig8UQZKnAmvTRP6aEaeEHu96ZHRFrD?=
 =?us-ascii?Q?MMTyvI7BuRxs/Q+fANeygv/jK44hqwHYQ9H04h72+MVoxokk04bKQlxbnoA1?=
 =?us-ascii?Q?MOK0X2ogSxoIvKoJGJm4DQ7L01Y1gm3h7OXpT+Gw5QNtfuZ8Ral8jm/Da7Pw?=
 =?us-ascii?Q?cTnLOWvErDFDQistUAOZzTlnxI2Pxk5dFmovTiYpHjGQbCQjhxEei2Q26cLp?=
 =?us-ascii?Q?0jzt5ZPqfJ3Xj0TnfvGighBO9J6FSsL0QBOO/TdycyVSexLigJw2WpnL5YIP?=
 =?us-ascii?Q?sFA2xEPAzxqqrzLRTFRTxEc+F0Uc3+0gb0Mo5cKLwUqfF1k5moZdUCNsoVIh?=
 =?us-ascii?Q?YQ8yvcbNKAHm/FYRZVlNVnjO7cXKtYhv7Qnwe5+A3qdkUdxQN6Kl73bR4s+D?=
 =?us-ascii?Q?ZPE54fvfGFB0P+FcK6Xz6uq49qef0gkm5I3fKHvDLWMraeOEeTXgYWcYTQyF?=
 =?us-ascii?Q?ws57sttVNdykml//cDM82DfpA04nPSvxyZdkMI13oHWoCbCfxu/ctEu9xwGs?=
 =?us-ascii?Q?49SRV8S8AZn9gxN0rZ9ann7FF1OOKX2/RD0gMOOaYfPP+3u3OfnBqoD2RpMI?=
 =?us-ascii?Q?4wfJlSC7fW/T9ifFT34EukWjH+6w3xPdsENZxAB/EzEeACyfFFFrIhmUTD43?=
 =?us-ascii?Q?SmT/h1hN1Z/rqYqkGIWa+f2bXyPu6XAOJZF710G2oRkfJgu3dkYFjm7tZx+N?=
 =?us-ascii?Q?tn33TF5eVZHeMalD5dm6YMmXCaelsWMdLy0Kdboe5TnY8EVdoNcAHjsKL+UB?=
 =?us-ascii?Q?darXmHWCI1o6dtT7IKp70qaOJeG+AOSB54W38aAgGTsiBOVmmnPz9In11GQ8?=
 =?us-ascii?Q?oVjx/4+FMZi9WtlCcC2W85VPXtjH1iTVO2NEmBt6OQkCTquEH8hI74U586Bm?=
 =?us-ascii?Q?pe1UJIUzopnchbE+ctEZsAea0/NME6ZFBS0E7My5uGnXw+bt8FJiQ72T3saR?=
 =?us-ascii?Q?oOv5AFT+rRC2fFNj9DLppvfrcsMV3z+usSKQeMSl4iuYqy9osZhBNVxbVSs3?=
 =?us-ascii?Q?ptkb6GYOz/D+RmJ7Vgb1AoSJA1QxA2xCQPV2PBfgC0ybFOjWmTtChDukP+/5?=
 =?us-ascii?Q?1KzALBUFw/UYX0Ln6WpikEX8JsFuksmzxvSO690cij0C2qMEnedwSpH0Xrfe?=
 =?us-ascii?Q?QVR/EDKMS4LB9od5WosKIH+QOMNiEaGnEyx59Ohi9/HtRfrjVa9JcWfyLHJG?=
 =?us-ascii?Q?xk0r/oEUOknYvUULKpfr8UL94ulRlO9TEjy9Aw2JOpmJ7rr+Vt5T1d5iu+kd?=
 =?us-ascii?Q?LXuwmmdrddBGICPlvWLhZ8Ka0qJTMzy+ckqSJI8FB9gkVUbP23QIanWM1a+1?=
 =?us-ascii?Q?HPSrqUszbnpr5I+xhdZ+m/87P/VFiF1wp7brTHwNYx1So2sLPCeapJpBt1br?=
 =?us-ascii?Q?xS3uKQDviLw0ZrGS9Hov9do=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <B8CCE01067112947BE4D3C225DF3CDDF@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f03c30c-cbde-4b86-1b6e-08da58e3ccc2
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jun 2022 08:54:24.1971
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ek7Ap/VdXpw8gW9jsRIFSdb2ASEAwf3GJnfngXT/WAiZpFcnMfS5zcopMzBW40orwnRVDC+gORv80mFXhtHqOlzOzhsiF709lnCOlp5WJeI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB7278
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220628_015432_842524_5E4C7012 
X-CRM114-Status: GOOD (  11.55  )
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

On Jun 27, 2022 / 14:32, Sagi Grimberg wrote:
> Allow Setting nvme_adrfam=3D[ipv4|ipv6] and running tests on either
> address family. Ignored for non IP transports.
>=20
> Signed-off-by: Sagi Grimberg <sagi@grimberg.me>

Thanks for the v2 update. Applied.

--=20
Shin'ichiro Kawasaki=

