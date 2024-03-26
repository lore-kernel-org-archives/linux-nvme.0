Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AB6BC54E58
	for <linux-nvme@archiver.kernel.org>; Tue, 26 Mar 2024 08:39:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=U8AWcLObX2yQEvSW9Y7kkENwByGDl8QVof8XHCrAzxg=; b=heGSrYP4FjaM7sm+JYcuj9Z/Ct
	nRywn3pdMG9ArNhVZiFqp+qblj0PSeDeyhIlEcRcK/N1jxqDGCyEpr6JgiKII0ZUgEbl1sjFQm9vg
	Ydvbp5r/RrRZAaBwPI2zRn7APWVmIYhAUe3O5BjM190j/6FGHcpue3D8XJWMt4KKFfpAbzVj7Xu7Z
	OMvw2Y39jQgn7ExvmCHX53ekpZ1vO4Px+kgPkZ613J8e7V3E8UWil7uWYQJRn25zYCMFMsQQOFA/S
	6Nb8m2BBXVUH0L798VXaq5UJi0z1G7wsAyjMtNJ7DwdBqEUiqNbdpoC95ZThjBqQUIJGoXpNhg7wo
	aW+FRymQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rp2LC-00000003dxM-2BuJ;
	Tue, 26 Mar 2024 08:39:30 +0000
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rp2L8-00000003dwh-1KbS
	for linux-nvme@lists.infradead.org;
	Tue, 26 Mar 2024 08:39:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1711442365; x=1742978365;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=pZwgG1ahq2e9RhGO0ErREaKmc6OxUc43xwIV0A+caC0=;
  b=TANOap8N6lMl7xRTCQ3x/QxTdz/CoRBo0ZBgy9f2tnLgkfDiogncpYwt
   QS39w64QHiMWcAvNvFCSwZkJ60JzQr36FTQ3EJ4hKPlVbwNjq0FvKm2Ci
   46nmWFldXmjKOWXwj51TQgEiwfA++jWtoQp5OWJOp9zpur3PzO2Wee6/w
   N0RdOe9ISXog6U+hh/P0h5PSiukOlXwYzKLUgm1d6ABQh17R3MqAkES/T
   MnvXaOVqVjA0DgFxOy10vb5p9PRg/lxt/KRQWJKJ/u4i/gFqPOXFwWvIV
   RwAy4yPxiH3S4/jIY1dg7ey+dVoRI74RDKn+hUW/9QC5ZR3ppdS8T4xmf
   w==;
X-CSE-ConnectionGUID: qalnsrvbQ3S9x0HWTM8I2w==
X-CSE-MsgGUID: /DnBH0kuTaecuSk9il4R5g==
X-IronPort-AV: E=Sophos;i="6.07,155,1708358400"; 
   d="scan'208";a="12482575"
Received: from mail-eastus2azlp17013022.outbound.protection.outlook.com (HELO BN8PR05CU002.outbound.protection.outlook.com) ([40.93.12.22])
  by ob1.hgst.iphmx.com with ESMTP; 26 Mar 2024 16:39:22 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B3eMbRSTK9YiZPeWr6ggUczpw2C/trHfCw2ORFffZbn0F2C1fFeNmfEQcNfSWAcPUUeDF+rZuSiYnSlo2up2PS7HkjUXsCsEkR8K4My+tt5QL+iO+m69WSF9zKkF48Vr8UvPtqVcoDjZvQctAjgSji46wga2AbHjPs7DbSWgoiXXau9JIVwDgzcnpH1FVq+zLKFP/+7MhQcZOg+DsI6N+Lg8PhIX6tXCa5cJWVsBXwK6kEyE1jcAucpRu4Gj4ThoIyyXnOicrGoeBCqaKCOx+b1HhVd1Icc96UKzOCJnfHUMgX4CMD2UT6dBoLQqqpKE+z24HucyT3uNO8RaOO6hAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U8AWcLObX2yQEvSW9Y7kkENwByGDl8QVof8XHCrAzxg=;
 b=JWG8oP8TAR2aZNCDvmSNoOOCSPBb82QxUqYxeBK+8s31UdO8timB1g/AVRwnYBMySo7lIYApXArBbfyXd+jmkyWItjQuSIl25WwDqmux/zhvaBgQtzxBPT+WKj9ZeTgWqO0VtvQ+Dppexhwd3grp2BqUqjmUekYyR89dsqdS4krP/9GhqjJHlJgsxk4oKgvIsntiKwRLGRmrl5O7b9B0Ry5QKEG3JC0C/DRKNwdttHTe5IPE/+fX2Z/aQNrBPSLV1HhKq4dCExKmapDtONz4hMx9kqYAKVBC0pU3lswnPcQfXWH/Av0RHEHRB6JMt3Uytfpy+1H6m4kCvV07npXWkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U8AWcLObX2yQEvSW9Y7kkENwByGDl8QVof8XHCrAzxg=;
 b=NJXppX4HlnxR7HlG+ix62U0/7fIN9vEIGCPRiO4ZJ8Rq83AOJcRcTHrBQ+VOOIvDvXeGLQ1h82gC4JzvfS9a8pR7Mv6PCXIbb+0DjeRVTt066iolIN1LWb/VRewAy6hgH9yzijeSoVYcziwoyZu/9N9A7sW/YynvU1jCZ/BNtbs=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 CH2PR04MB7031.namprd04.prod.outlook.com (2603:10b6:610:94::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7409.32; Tue, 26 Mar 2024 08:39:18 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::c75d:c682:da15:14f]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::c75d:c682:da15:14f%2]) with mapi id 15.20.7409.031; Tue, 26 Mar 2024
 08:39:18 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Daniel Wagner <dwagner@suse.de>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, Chaitanya
 Kulkarni <chaitanyak@nvidia.com>, Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH blktests v2 02/18] nvme/rc: silence fcloop cleanup
 failures
Thread-Topic: [PATCH blktests v2 02/18] nvme/rc: silence fcloop cleanup
 failures
Thread-Index: AQHafF/tt+LP9HpaAUC9qyOE4syFDLFIy1QAgADuGYA=
Date: Tue, 26 Mar 2024 08:39:18 +0000
Message-ID: <bl3civ2dzinzrmlb5mg4lpkutwfb7d6sx5a6qtiequj2x44vvm@d72cun3ezvkq>
References: <20240322135015.14712-1-dwagner@suse.de>
 <20240322135015.14712-3-dwagner@suse.de>
 <nc33lqabldktsxsdrmnjrpdagp2vnqid3vr5u4r2xwf6cuhjmv@cgvtqfzcrxds>
In-Reply-To: <nc33lqabldktsxsdrmnjrpdagp2vnqid3vr5u4r2xwf6cuhjmv@cgvtqfzcrxds>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|CH2PR04MB7031:EE_
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RXgcx2iycpPsv/VKcnZ9BM+APzbC+XDtnhdBSILVocM4Sm28HQvhlpCESz4fI4FRS67ZRU6KoSSNDAu/qZ35bUithSrkXK6jbB2rkZvj2wOaKah8rLrTt9uDgV6JiEhKgXmNpcvlLNG2H1PTD1ImEVTwrf1YQOWIBJ+kvr6vugzMR9joX697U1UJbwzSj71wuC/8DBvNW+sMx754IVqX13741zMj6tfik5U3Lzanq1RtfeE71v+45Od2ZDVnbwpvKis7JW0axZXd5R+tCdEgzLPXSLwbeFVFG4zGT+DO5ohVYyewIZXCu3gDyKirFe+6720zYic//MGdDNgKKnUpcD9ar6Jv2EDrYXTiupPOkW/CvqDaw+uqs8V1hyCofEhv0/aFhRRy2v68k4sCIRzoVRPOaGz3aVHh3sBu2LoRHD6HKWjraOX8PooxfxXmo7JHx5iY6mIZr5zBFZZGm/+wImlIdsej1gUbVbtJ3+3cwkxDPuXS/bnAXk8V5yw98PV3arZVg2I1F74pdweoux/z0sRFlytMBUGjRsAH+y+bKSn78DQlLe82jAauREJ9ORzd2+oi51QZlOjxABlNBipLOtlkilzepymuPCMzO/R4zAc8IcOMSJIorKjsCDsKHOql/MnFok7owLkfdP83ZNIyKmFVzICSFGu39lRouk0Tlfs=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?hlE6qqABZxLm5SSbW2tWP5jYlaQRu52qOxy5k1Q0Nul2AQYeyhvQ/pCmsj2O?=
 =?us-ascii?Q?P6WedBg7yiNILt5f4CoX9jwv7UesFw2Q85pvh1l+rEEIIw4nbgJFOiafZhtX?=
 =?us-ascii?Q?xmonY5wmlaMDHir2B52VCq61HBHJxju/d1zb6zecSf59yVM7K3KtXh8Lq7Cn?=
 =?us-ascii?Q?QwNBgDgafXE5alIQtCXP1U85U4bE6cEry/FjrWKHRU9/51LN60Fomk17cr1L?=
 =?us-ascii?Q?oXT3mp2eMtiNnhOdE7wE6BggrtRdbt9rDgPxnEj1LnlDuMnSaPACl/2Xl8Zv?=
 =?us-ascii?Q?0ekTsp1UX5+eDHSuj0S9tHw/YltJSBmIlki2kn9YYAshJ76z6C4tigRs3Q6j?=
 =?us-ascii?Q?oNxtJ6iY6z+rQ5BD/ncFK2UQvBaLaWs5XwDzZ4kWSLnyYLJlLbdu0O62Jj/M?=
 =?us-ascii?Q?WzJ2vEHdTb903jzuo1DQYpvPuNkbGJn1xkq2KfEIKFIrbnuxJNFQKElYd52v?=
 =?us-ascii?Q?3SuFZqHQP2VV19PmlZz26erB9b3t71ct+wzRUOr+GhtUzrRt5XfgULM8tbIR?=
 =?us-ascii?Q?KBQrPC/we6lYcmoYNiqcuTIlDX9BitK/1CUO55UIyyPZC23efm+kBdDyKkjv?=
 =?us-ascii?Q?E8V3QE86sQV86+cAIKR/77UKWk+9L0Z0H3+YXqvVzgUX2H6EJdulz1bZMLjL?=
 =?us-ascii?Q?V+ZMefMwz3ubu83GqJd2cZ56+mD5ly80SF5GOg7PBccJUrslL2r/Pwc/Tm0M?=
 =?us-ascii?Q?j1IPeaTQaOCJ7xsBAkFlOC//66tMfwPvQCc2IHkolFFfyurFPA/c5uhVOFcJ?=
 =?us-ascii?Q?+Tr4cfraHQTWfS7cklH/7qd7enX6OTpCABfH0PSJRR9h0YIzZO1RveHjnt/O?=
 =?us-ascii?Q?j0Z0Fc7hWxVxa0F6cAKtMldeFKYnjQow6/jS9bFIywdBAgovF3O64/QyTiCT?=
 =?us-ascii?Q?79ar5BP47f8g2uwXg5QLzmlU32EpCmXuMzmnsX9CDiYxARc4AgQ6fOP5vIpX?=
 =?us-ascii?Q?KewPIqiU285+Hrfa8VuDW1a5y+ITIlGvWy0WyQweitcOE5fCCu8FLvr96/ii?=
 =?us-ascii?Q?mADJNSCWZIvWjKM9sz3iLnsKMcXuN0+twVR8a4IZyVd26bCuIpvFX/NmmyM9?=
 =?us-ascii?Q?KWdO0k1CfT8TPl5SH62jGWkvwG2Rq5DbzXo+VUy6LRp7Dm4n5a0yh67RocMQ?=
 =?us-ascii?Q?KgH+sFO36RdDoWXz1v7isw4Pv5BPr4s9NiW1tRl86XRT7hhhERwRrqpmRJzJ?=
 =?us-ascii?Q?Q7s8obI6i53FaHo9plSB2QAgqik4DBOI5eB+Nvly6VKpE4zXoqcYmD7FtG1M?=
 =?us-ascii?Q?ShBnde0ejb4v7uuozSmvGVEsWi+D6Wa/GLia4QnJZF7SjlIL9xnPj+Udiz2a?=
 =?us-ascii?Q?WqpljM2RgOL3CKYb7DP2fKUZPBGmY213XnGan+7B61ZMDUBTs475Wngyxnpu?=
 =?us-ascii?Q?wGhHILJnLIJt7mItLy8CySXxsUorDwSR1FI5EvfAjbPbqn8wc0Z2RRtQteOu?=
 =?us-ascii?Q?CNg8rEwDNiWZPaQDPzgE6ZRMXxdpDY7fnZGzYCFP+7SuirW0mh5FGXCRHYC+?=
 =?us-ascii?Q?OGYJv9Kb8ugTj//kXg4BD43KEcIvr+0e6xcTDzomwWc+oegJ7JvpRPi3B/XT?=
 =?us-ascii?Q?1b8wGUQhtcBg1srbKgwe7oEyszSQZjl7EbrSa8kRJ6+sL74+UgB4D6WPgU0Y?=
 =?us-ascii?Q?2/xlAnWns5UxI+EdV9FP/FA=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <4141D6BD287CAE489D2237D62F0718CD@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: h42upAiTdt0mm9mAVaN3MCXAL+Bw/edn+rQV58N9Si/Yt3+0iFZ62f7dMzA5QkSDkWBKRRf2cRrZEACe3kZ4NFqRqZIVT9nMo/OuIcLaddIl6/cOw4RUP+Hh7oD+zYcg+iYXeA62+F8vyFE9rsnxo/oJegbgwFYTqE5PzvLYeZ4LLa7lhE4lg8F3ypJ7yG67qsJGzSjGJEUWt2ZJMDXwg6inXVEnpBo+NYal+oCx8hgS0QFk1QQXICW/ecZnOALvDTfUGgozGIpCPfJ50WKF1DJW54VB5BVIyjBGnu6q2sT9mCfCgXQt77d97HX9fs+SwDSz3g0Ua8TSd/KJHXH7Q4qdd+4NfurCdOGZXXDaAn/mYva5p+6vrS+AR/s3GhDdVGcdjg7XPEzHHHKrSQodUIpP1uxEDevUXo5wZoMxlcoJEvTvoCGtEM/kOJ44xYQ1WF/ywkEI3syenjW+RtZIqT7C5DZYOZ2KiqgrHrzBH3XSuLZ7RcITmnvN/sCJiG5DgOogCuFFf2y4D/xXD4/eeghD0lni5bLlUssXiqLTQZEbMk1YacYptyl0YMdSAr/JL+3TYf8jqS5IIMMJ0J4Ney6N5u/3uZbgdqy8J0TveNoqEfcQVGIE3xzIwovvqfc5
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22e20005-f849-48b1-2c31-08dc4d7039ef
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Mar 2024 08:39:18.3141
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KfwIT5jqX4xp642z0pd2l/Vye376OFHiWewQ0oLLhxMqbjuLXAuVqFUhbm09XAva/YBVAvnmaL2Ex/ZL/LmliuR7xLrM3/avdoEF3hStPwA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR04MB7031
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240326_013926_451981_091D87CA 
X-CRM114-Status: GOOD (  28.88  )
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

On Mar 25, 2024 / 19:27, Daniel Wagner wrote:
> On Fri, Mar 22, 2024 at 02:49:59PM +0100, Daniel Wagner wrote:
> > When the ctl file is missing we are logging
> >=20
> >   tests/nvme/rc: line 265: /sys/class/fcloop/ctl/del_target_port: No su=
ch file or directory
> >   tests/nvme/rc: line 257: /sys/class/fcloop/ctl/del_local_port: No suc=
h file or directory
> >   tests/nvme/rc: line 249: /sys/class/fcloop/ctl/del_remote_port: No su=
ch file or directory
> >=20
> > because the first redirect operator fails. Also it's not possible to
> > redirect the 'echo' error to /dev/null, because it's a builtin command
> > which escapes the stderr redirect operator (why?).
> >=20
> > Anyway, the simplest way to catch this error is to first check if the
> > control file exists before attempting to write to it.
> >=20
> > Signed-off-by: Daniel Wagner <dwagner@suse.de>
> > ---
> >  tests/nvme/rc | 15 ++++++++++++---
> >  1 file changed, 12 insertions(+), 3 deletions(-)
> >=20
> > diff --git a/tests/nvme/rc b/tests/nvme/rc
> > index 78d84af72e73..865c8c351159 100644
> > --- a/tests/nvme/rc
> > +++ b/tests/nvme/rc
> > @@ -234,7 +234,10 @@ _nvme_fcloop_del_rport() {
> >  	local remote_wwpn=3D"$4"
> >  	local loopctl=3D/sys/class/fcloop/ctl
> > =20
> > -	echo "wwnn=3D${remote_wwnn},wwpn=3D${remote_wwpn}" > ${loopctl}/del_r=
emote_port 2> /dev/null
> > +	if [[ ! -f "${loopctl}/del_remote_port" ]]; then
> > +		return
> > +	fi
> > +	echo "wwnn=3D${remote_wwnn},wwpn=3D${remote_wwpn}" > "${loopctl}/del_=
remote_port"
>=20
> BTW, I was told why the redirect doesn't work. The reason is that the
> 'No such file or directly' is issued by the shell and not 'echo' because
> 'echo' is a builtin command. Thus the right way to catch is to do
>=20
>   (echo "foo" > file) 2>/dev/null
>   {echo "foo" > file} 2>/dev/null
>=20
> I suppose we want to keep it simple and just add the brackets around the =
echos.

Both has pros and cons: added brackets are simpler, while file existence ch=
eck
is more readable, IMO. I think either way is fine.=

