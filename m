Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26A42C433EF
	for <linux-nvme@archiver.kernel.org>; Tue, 12 Jul 2022 00:33:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xzk8k2wO4EpnD36OKwR1no7NGS7L9rl92xU7huPkGos=; b=Z/fvWGsPDjyifFN4ywPNemdFms
	G2CmHNi2duruvirA7rgMk99DNUv7GM4mud/rYnq5PqPp/vceW9aWbfrVy05pkW3VfbbWMaPvHuLEM
	BcZjSgJSnpXH4F+XEY4MPeb50orz1n2uTNTfLJgWQez3DJs8ZV1U5PKhOvKwEZxQt0VylzHKPV6o/
	hW2lj9UMhL6A+PzD36JABXMuWHpA1TTBAYPLhsnpIC6UP3ii2pwD52BrJBmoCv7cgVMnVqlNxFEmz
	btzZ1snGdwO45mfnf0SHXvYcsd6G9HOWoZc+ltSbUitoFHSd7kNstQpMbuvRxiV48NEs3vRYLapeD
	g+Y+2/kw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oB3qI-0063gD-FX; Tue, 12 Jul 2022 00:33:34 +0000
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oB3qF-0063fC-F9
	for linux-nvme@lists.infradead.org; Tue, 12 Jul 2022 00:33:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1657586011; x=1689122011;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=FyjY5Wd4TOLKORFLunXbU5zpmgq6xpeDJSp2EgZkbHM=;
  b=Qwy2JkdQ8to/54PWespkazcBd7N+WekmHWntpJFmruMQqT+W8+VzFV8n
   eqPVejH82Jw+WzYvGfg1ghlh18N2A0faUic85nhkOgxdKGeuhR+uSS9Tt
   waQXiG0t+KT4p1i5EN2FSGqYugfBhJsWkr90Ex1E8ff5mkWXz2rpk7E4P
   ya4YCFX3vkLB3EmwITmtKuXc2SIDn6BU09+59SZTm1sMMA06ABP0Mq3S4
   VlsM9KSYjHgJpCDg6zJrVCkiG85c/YheWrWpNwzu4QxHtuJgkLYzX1UvP
   h0EdEyyHfDFodpK3uqxXXligVDaBgrrvEnTEywkokFtq99eKgJ4j11PWb
   w==;
X-IronPort-AV: E=Sophos;i="5.92,264,1650902400"; 
   d="scan'208";a="204076102"
Received: from mail-bn7nam10lp2102.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.102])
  by ob1.hgst.iphmx.com with ESMTP; 12 Jul 2022 08:33:25 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mpF7rSxn3dApshUNdd5TkzXj3YuFd3ov6OhcBMscQ4RjcYvpwI0SijmFMPnO9LycdvDKgXky2r6fJKuLvmjNA7ZDpSRO5Em8yetFSCJRGKtBKqKenuRck0dRfzn1S2Q5C7ihGZe81lN9DWQRuybF3ZnvsFTliUipL7Z+CBuck5eLpiRN+ltvmStp3LDZyJJNMiMu4fSzolMYz32Gl4Fw6taoe8apEMWXX8YMbqW5G/HOCJAedZTztnzSHuTzbjbWyozIzRNpdyc4I90dqk8jkNN8KhFATviqn7hEXyF7HS+4HqTbqV3lyTtIu+Z9Ai/VoSfeYCAHFCAlmouM/9EDGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xzk8k2wO4EpnD36OKwR1no7NGS7L9rl92xU7huPkGos=;
 b=aQrcFW4BddtDJDKz19gH4hkkgYJiEwIwJ55JTjaRxrl3EYNLYjkBfsZjHFwM7cXVWWOp8t4qHVvcq3u53M6tNLz8ij6do2YXHwfegg4sjcXu6ZcQOETYn9/1wzovyDJ9+rO784NDH5yI2drsqYKnyyDBlbJcLgEN6Uoj+gQyHvKcFq3GsM9Y+EiyxCdGndbvWh5J/oCvG+FgsFyoxrMGzTxxmVmf3mIpyVuhVdCurT4nLforAv8jeHktJojXHpan6Mmd7mX9yey+M+4mclJpOQ9nDMU4tQAIA695Xq+rwpdYVatK6SLK+e/ld/BUfJxYWdgRFI+8/rndO7P0gdAq3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xzk8k2wO4EpnD36OKwR1no7NGS7L9rl92xU7huPkGos=;
 b=hCQw6xSYenE/8mpGI4Vp4qcdXFZy8QFK2QC9yzUIUmAFjdX1QcZEgp4QCF+PmUPPVLy5ti8ViaqamRgj2/8akf5lcuPbQ48a8TWHnFlNpRsGuGt4emXa5aTt077wRNWWn70WGW24J3SYviuswsQ9NkkfuiLaoyh0DoGW+g9nNIU=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 DM8PR04MB7991.namprd04.prod.outlook.com (2603:10b6:5:314::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5417.20; Tue, 12 Jul 2022 00:33:24 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::3cc7:ac84:d443:5833]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::3cc7:ac84:d443:5833%8]) with mapi id 15.20.5417.026; Tue, 12 Jul 2022
 00:33:24 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Sagi Grimberg <sagi@grimberg.me>
CC: Chaitanya Kulkarni <chaitanyak@nvidia.com>, Hannes Reinecke
	<hare@suse.de>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>, Christoph Hellwig <hch@lst.de>, Chaitanya
 Kulkarni <Chaitanya.Kulkarni@wdc.com>, Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH blktests v2] nvme: add nvmf reset/disconnect during
 traffic test
Thread-Topic: [PATCH blktests v2] nvme: add nvmf reset/disconnect during
 traffic test
Thread-Index: AQHYjJhcmIi7Uhy2h0O/p2K8uynWvK1pRLoAgA8f+gCAAIDRgIABD0aA
Date: Tue, 12 Jul 2022 00:33:23 +0000
Message-ID: <20220712003323.zcndbxwmp2a4pcb6@shindev>
References: <20220630154444.475600-1-sagi@grimberg.me>
 <dbb827f5-6202-eb09-dc32-d49d00d59cd1@nvidia.com>
 <20220711004124.ujr2r23zef7gp2ic@shindev>
 <7f9de1b6-f3bb-1c94-7a57-65e77254db0c@grimberg.me>
In-Reply-To: <7f9de1b6-f3bb-1c94-7a57-65e77254db0c@grimberg.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 09478a62-b552-48c6-d05b-08da639e214b
x-ms-traffictypediagnostic: DM8PR04MB7991:EE_
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  oM2M3xj7gnfbOOFEUm7PVvz94AUfieL0OUWsl6UneoN9/gEXAuDnucTCl+jZbkx0ieADdkak6d5eLdX1o4DQM0B1XdyihUTRzpju7fQ4YV1FX+PuNsOoZBFhgDnw1AyMZW3K4HXUU8iDkJe7akEro8tnG/ctTxWRR6cWBpGBj2EAQfB1KLt2sn298Iv0jl+upleEsUSeijG+QzZ1YhbvGMya1ldNXVSTO45DnDPIbczpIB3JPHlLF7Z0I2MsN+/r3nojzD5QMHYrhNUv4tsOeCDkVgbu7h6lVOF+rQxwlde6zmSilMSPZ1NPpm3IDtOLPU+WKcLtMVBU7ehEFGr0OBCjPTRTfHEx8udfSdHb847Q5biCeC9k+ETsUUG2KSsdNaNwfEuDo3l6Mmw9jFVtSEotdRJJu4tFQ3/2aDm8AbM+d7CcEqQn7dfpwk2q61U7AkHVyLU+1LR8bbunPjFMi7YOVj4JfWIzYc0OX7sOYOIXmZcbyr/BB0rnjsGhKVen1r3BrG1TgqINElcgZKT1nHgCRq8CPm8EUqcgvO6mizMKkaLZUDv4f/zA/tr0NP39iNllkALQUrNSHRE1+7708WwPFvJkvaV7L6YsIjo7Rqgg59l/rnPzRc+Ji4wr8wg1tmYH5ayQVLaceCWp3y/PuEeCPl8mgsBsiYv3OIrkLjUsgG7acluAjSB7hGiucgVKPep0LzE3ytzQUUIUoWPmvOTOZx9BHBRbQRNek89Yg9lS2eGu5a3OO5sF82WP0BLBuk6UNVUW6Ykhxr7J96O7RRdyZHftjRou8CdSCFoxDPTebtesi03X2gMgKclW7Dxm
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(4636009)(346002)(376002)(39860400002)(396003)(366004)(136003)(83380400001)(316002)(8676002)(91956017)(6916009)(54906003)(33716001)(66476007)(64756008)(66446008)(9686003)(186003)(26005)(66556008)(4326008)(66946007)(6506007)(76116006)(6512007)(71200400001)(86362001)(5660300002)(6486002)(41300700001)(38100700002)(38070700005)(2906002)(82960400001)(478600001)(44832011)(122000001)(1076003)(8936002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:  =?us-ascii?Q?dcwzUQyCUbbp49QFuyLe1Pysj9TmwYO/CJxEzRqRPb9i2lUpdQhsJZ8PwYRl?=
 =?us-ascii?Q?fcetnshJnzT6dCIfcL/08qDaQDPt4wlgY9KGOW+zXX+Wig1RZ5I0a7lC3Xxx?=
 =?us-ascii?Q?oFSJvz/tF6DMYnaWt9EvEqOscnaS+mvwJ0vVPUpodtbkQUofo/mo9dlmha6J?=
 =?us-ascii?Q?RsIhpp5xvNslSuIwN+6KliKgYfrzgW4v0Se+iF0j0bXTt3KbXqjc+9wtr1OC?=
 =?us-ascii?Q?TvP3UTwbWUqAaZ/T2jwYdHbgroC0NVqUgpfN9LeET3OGMo9OWwrpSqocqo6T?=
 =?us-ascii?Q?q0IViAlXeOe+rAl01iKkK+/zXbEKKjH0+QFKbMaaPECVIHcz+iVZEYQ+fQJZ?=
 =?us-ascii?Q?YSUnz1Ck5nNLxdiNZDYOpIP+ZuxfcnhgAVLayAzXjP2MqT9bxpzuzHEdSZWk?=
 =?us-ascii?Q?1TtS1iXFfi4I2BIeHxqAFYK6A7/DHUyDrh1Q2BTa5xSIichFWudqdIMER7ve?=
 =?us-ascii?Q?ju/PLoEREba/gyRRpSAKCRI9zQi1eh+0eZmKF3Y1lCR9MHuFoexd03CAjeT5?=
 =?us-ascii?Q?KzvZAPR9HIfVBkancQFy0QDPd32s1Y8k0/GPJmIWzrm6VFsysVcv5Xj//leF?=
 =?us-ascii?Q?0805dWkhCbXdP2r0gAJ8L1Q7yYGfxXj8mEuFdHxVHrA8c6sfrRjlwSwRX5ym?=
 =?us-ascii?Q?JIMIKjrY8fBc6ljIHvFEmhRv76kQMmQ15oMBJ7uXmlm0YwXhoCBXc5ioEm4C?=
 =?us-ascii?Q?l+Slck8BbXupQ8lNNDz9TFttiToICHO3jVUlmPQDxzYs+inVufn3ni0poPxY?=
 =?us-ascii?Q?kqp9+qrhnMI7RTLxBGzAFLcYT5CkWPEAztN5ar5Z+AjkBhlLKI9PF+xuLEwD?=
 =?us-ascii?Q?oALCSjdmsM3VqUlvtN1oBDEEZfMtQ6b7WWV2JkTiKsZtmmyRzq5XV1Op76xL?=
 =?us-ascii?Q?ub6F3ifue+8Sn2EqyISup5bx/ZkbgVKFsbysS6YDqq91mXPsNJ1JpNutqh1R?=
 =?us-ascii?Q?dowFkfTLUjMVm+8T3VxozVPOlA83gEblgUiPl8raYrnScobdjPKwj4RGW6wF?=
 =?us-ascii?Q?qPS4DReNke0fnYUyFzrMGPR1yRyeQWCseEVgxRebupFckBjoT1ZhHpCBaxGo?=
 =?us-ascii?Q?4j4hozzKCErDg94SEsgcrV8wrgDvTcjgfOqYeuhth5V/EKHR5wpJPn6Wi71Y?=
 =?us-ascii?Q?NMUVsv3nTMIe7Qt+lHTydEo8t+IuaM3dy9U0neZxOYmPTC0MrjPEVSVP+KZz?=
 =?us-ascii?Q?NPD5W0pzACmxO+oBB6kjeMzp1SmwNoZ76BzmyfGYvtjh/fsQcVGVdk4m8GPI?=
 =?us-ascii?Q?oeV2Jg5zSfYGTgMxzSMoAOudlcLpP/6GvzaY8Ou3sgBbBFn86IBOiPQVk5gi?=
 =?us-ascii?Q?9dTY5nvIilMXt9CG1nVN7qNmQVCdJ3ojp6Ai60ydjjYFQJDomHxJAavRZQ7p?=
 =?us-ascii?Q?lwBhix9ZWhLOFXRKnoHmiZTZeB0xfkWBBiC85mcpY9944UUU65XryIMizLv/?=
 =?us-ascii?Q?gJrZ1pWWzhyXraADv+KLTiGuHbHffpoEOpLTg2279Up3RELoNcbRyTcXIVGf?=
 =?us-ascii?Q?LJi5dk4Onh5bTetIRftCEzZaD2uUb5Xogtrnjmh9b+QjQW3U99pYVjQfcXC0?=
 =?us-ascii?Q?hO32tEoh1JWlALT2wxWfjZWbZLtsDdZqCQX302ODLgfyWkr5XO0GyltywVdm?=
 =?us-ascii?Q?9YrVHwiJioDhpsTwwIQhHkM=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <97A7743A985F694E8666BBF09CE445AD@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09478a62-b552-48c6-d05b-08da639e214b
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jul 2022 00:33:24.0477
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LP7WGI/jwsce/vShpZxHxAe8J/xxyikhg0hvJy18slyR79frniNzhOxFrVan8h5iI/ViVYfVUoHjepDpBTPuo9PvYe264BzC1Lx2ggfMpW0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR04MB7991
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220711_173331_822238_92F1F9EC 
X-CRM114-Status: GOOD (  23.79  )
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

On Jul 11, 2022 / 11:22, Sagi Grimberg wrote:
>=20
> > > O
> > > > +
> > > > +	# do reset/remove operation
> > > > +	echo "resetting controller"
> > > > +	_nvme_reset_ctrl ${nvmedev}
> > > > +	sleep 1
> > > > +	echo "deleting controller"
> > > > +	_nvme_delete_ctrl ${nvmedev}
> > > > +
> > > > +	echo "stopping background fio"
> > > > +	{ kill $!; wait; } &> /dev/null
> > >=20
> > > do we really need to kill the fio process explicitly ?
> > > I think graceful termination of the traffic application should be
> > > a part of this test without explicitly killing the process.
> > >=20
> > > I ran the test with commenting above line it runs fine :-
> > >=20
> > > blktests (master) # git diff
> > > diff --git a/tests/nvme/040 b/tests/nvme/040
> > > index d259784..0dce128 100755
> > > --- a/tests/nvme/040
> > > +++ b/tests/nvme/040
> > > @@ -49,7 +49,7 @@ test() {
> > >           _nvme_delete_ctrl ${nvmedev}
> > >=20
> > >           echo "stopping background fio"
> > > -       { kill $!; wait; } &> /dev/null
> > > +#{ kill $!; wait; } &> /dev/null
> > >=20
> > >           _remove_nvmet_subsystem_from_port "${port}" "${subsys}"
> > >           _remove_nvmet_subsystem "${subsys}"
> > > blktests (master) # ./check nvme/040
> > > nvme/040 (test nvme fabrics controller reset/disconnect operation dur=
ing
> > > I/O) [passed]
> > >       runtime  8.119s  ...  8.084s
> > > blktests (master) #
> > >=20
> > > -ck
> >=20
> > Sagi, what do you think on this comment?
> >=20
> > To keep this test case consistent with nvme/032, it would be the better=
 to keep
> > the kill and wait. But we may not need to stick to it if it does better=
 testing
> > without the kill and wait.
>=20
> I don't particularly care. Can you remove it when applying?

Sure, I've applied with the edit.

--=20
Shin'ichiro Kawasaki=

