Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8116BC7619A
	for <linux-nvme@archiver.kernel.org>; Fri, 31 Mar 2023 02:32:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=di4Cni9iKCCygUGV4qYxmLwUuS4+Q5tvltUYhH0tBcM=; b=RDWyDI0oWiD6aPM/aX+J4/hNdh
	WsSVAfBMM2lmoEK8nmYJbUBLfgy4aBfdnSwtswlo82WtMFmnSJJdRm6V/xnvFRJzyz79TeMG4m0Hs
	lzN3daUeH+bZdnWE+vo9I7jp9eTutltvFHmpDXzLI9zJsYRLx/fAwhaoNnEqp2Q2qVzGHtz/3PLpH
	zeX9U3d84GYXfPDd6QdEZQl1FiCdF0w6qoi4PHNdrJ+ohU3tK/Kos5tN77fvDwieNheVNJyOLsFtD
	avbHYGZaJAC686nFaTKEu2Klb0KTJo+qaJmx3THZmrnFctpGdtZZ31ykSFKOK3kYDaasBt8DpaMi0
	wJIqSQkQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pi4Yp-005dEY-0I;
	Fri, 31 Mar 2023 02:32:15 +0000
Received: from esa3.hgst.iphmx.com ([216.71.153.141])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pi4Ym-005dDe-1g
	for linux-nvme@lists.infradead.org;
	Fri, 31 Mar 2023 02:32:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1680229932; x=1711765932;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=di4Cni9iKCCygUGV4qYxmLwUuS4+Q5tvltUYhH0tBcM=;
  b=V4LvLn7ywSzsIUa+0xtOwKq6KQGi97/skbFQD4+yHYYRHfz/Ti6DUh7C
   KD0aNR1PyReDXJA9iF0SGpVkCNAOKYpBtAcsRPiXrF0Tb9G6feO2dhBJW
   xyzabpUmm4VG9IaoCT9FUgjlFMLwxIpgK/Eft5/dZ+BYOJjcIeBOyFVqO
   vlmHJLg+dAY+R/9KtHg+GpXAj5tsGikd+CD/7oJskn1UKDBq6+gbeNv5E
   FDSzqoLik1wx1QMoNUW2xTRfwNcg4waZz9kHQH5D7BG7ahG4KqRM6ZonN
   UyNhpTzNOX+Yi7v1wIOPwQ5Ka1l8O0LbRoKlkLk0HzaOyCDVIMepY8zfc
   A==;
X-IronPort-AV: E=Sophos;i="5.98,306,1673884800"; 
   d="scan'208";a="231920936"
Received: from mail-mw2nam10lp2104.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.104])
  by ob1.hgst.iphmx.com with ESMTP; 31 Mar 2023 10:32:05 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XSYPu0tl/Rgt+pRXS9mQYcd85yn7SMP+W5/dJddoS9pB9vcNxzAw23TFx+A9oXbfzKzSepMMVN6p4l1zEHsQXQ1lHBbdvmng07jCiFPK4yVqwxnHq06mgDaQ8QmXUEJi3G1ploLFqp+stLAhGR5sPj8GCNBp0nkG4ZBeEuMGJ3C/27mFxWJXGz5ps74so+YfGKKEPbIcOwff2Iu9FLSjhIRQ4ZDEKht5a9n/7HvbuJPQdlZdGt7olpvQyuX7+GQ/WRdZ0mLg5qjF6yC4pbjOZaPc+QWlnCGnAZtPMC2h2VIey31cvuagVvNCYuCEKEjTOWYV553sqMT3GYgxnl8qjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=di4Cni9iKCCygUGV4qYxmLwUuS4+Q5tvltUYhH0tBcM=;
 b=CGYJ9/CLUHe37I1K5yz39cJqF38NVG82j0ou8H8iM6kPChDO71R11g8M5y4SC5K0HTUO7qoMBcqtZJBUyMDtnhM6hmgeMXlQzclHHjdty/e78441azbzfiTS9egdRyByBDArNoKB1T+CJuWrdoBWsWS/E3JjYaIgeGJnwAs8/xhMa/Gp/vnV1uVYlohD0+suq43/ZSR9JwONE8H16XL0bt6dGVqWBwQ2e73WhBr2A/mMSGp5xYTYyoupuWgyIwLM664SIgjDl/UBM9vLpgkflL+DGFu9Pw6XjF4r3BmvmlA5io3r2P59/UXWvrX3C628GY43iHzNx9WxfWSv8PxNTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=di4Cni9iKCCygUGV4qYxmLwUuS4+Q5tvltUYhH0tBcM=;
 b=MRsBMhB63SL/rx+3dqPunhzyioqpa3Ss6eQ9EVJtRLJhnLDhMaisvERVr9tosgSoAqgn2RpgttuVWQ4JrNXBZV5zBVblUF+7x7yDf+/UVZ9lw+6oOxa4cWzbZ2Yquk1tJiPxhNfoN9YP2jFhqRBX49t6i1O3z4xI/Pb5ODzpups=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 PH0PR04MB7655.namprd04.prod.outlook.com (2603:10b6:510:51::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6222.35; Fri, 31 Mar 2023 02:32:03 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::1b90:14dd:1cae:8529]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::1b90:14dd:1cae:8529%8]) with mapi id 15.20.6254.021; Fri, 31 Mar 2023
 02:32:03 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Daniel Wagner <dwagner@suse.de>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, Chaitanya
 Kulkarni <chaitanyak@nvidia.com>, Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH blktests v3 0/4] Test different queue types
Thread-Topic: [PATCH blktests v3 0/4] Test different queue types
Thread-Index: AQHZYh0mv9wK+EcAU0SezqvUsMjNsq8ULbkA
Date: Fri, 31 Mar 2023 02:32:03 +0000
Message-ID: <20230331002100.e7xmotjoprimxs5u@shindev>
References: <20230329090202.8351-1-dwagner@suse.de>
In-Reply-To: <20230329090202.8351-1-dwagner@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|PH0PR04MB7655:EE_
x-ms-office365-filtering-correlation-id: 5f23f4b1-ab48-4211-c30f-08db31901d31
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  rXzabQX9s/lWcDwXOR8lCizxko2vGqaiEoP0+IZSp7QXOUasrrOJ80cDDcKj49jIvzaHNrnNV+A4UK7GbvJlsyNbGIDAylH5E1VnUvkUrZoB7YP0tJJf9D0jHdGPSpZzdBd4fZG0hjGmFeWfuW2gFK3uMgVEYpR5PBzpx479gtATr2kgI9/mLTgGKQBvRX3haMGLijf/TB+o/UZY9sEX5MsG4m4AbfawDc12rUe3RgmPJ5RDlyQ0v4ost+Irgo0Ve/Y6D+fU9uqK4FZgfeYtwmY1oRXzoWAMD8uqOYKdgQUaDBEerI/mvx652PcGvnJs3vstNaI5Y/n5i025n8Kr+IgYWYX1W4lHzJmxpps+0Khl3YEBR0z0HHql0PTzIxNdxHLVAaes2SDYas4qdkIoCprbb+Wca7SMPpOkwd8V/oK7tpriNT5mQ0ofjatubLcg+QTYIwD9VJwhylhrZtiKMY7i+634h5RgGTp9JMLxtfVDgyY39za5G2hamZafheezma1gZIfJ5iDOhE9NW7d8STFuVVbr+jOn/7KF7NSLFrutqXNPZNYAXnIYCXuThzt/FovXXwo5gxsoDWuec930SpjxIaFfY6FOHvj2GDtZYvU=
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(4636009)(136003)(366004)(396003)(346002)(376002)(39860400002)(451199021)(2906002)(8936002)(122000001)(41300700001)(38100700002)(82960400001)(44832011)(4744005)(33716001)(86362001)(5660300002)(38070700005)(186003)(478600001)(54906003)(26005)(1076003)(6506007)(9686003)(6512007)(83380400001)(966005)(66556008)(8676002)(91956017)(66446008)(71200400001)(66476007)(66946007)(6486002)(4326008)(64756008)(6916009)(316002)(76116006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:  =?us-ascii?Q?KGWesKaVy6wLxZyVplOb4/yAt1C9dy8y/QgCvHf00FJKZx4++GQBlXXyqUHq?=
 =?us-ascii?Q?fzCsaG/tpKLEnqIzYB9mJOmHRn+JFT1uHOMNWF5/YHwBRSq7gaX6GDcqebei?=
 =?us-ascii?Q?qOhAMxyZvIJwVrvJoOmM6/ei+ipt7Xmgnsb9zRU2xHJWloef+QPpyZVG5mj5?=
 =?us-ascii?Q?quH14PtXJL8SK8KOOWfJ5UAQLHeQtLDwnFtu90sj/v7V7WEuGC/G0sFLXVLF?=
 =?us-ascii?Q?HcG/qzwez2nkPEw/23WvCbTaPT580c6B2zHZPMgmhdZr8/56iz8Ee0vW0NFG?=
 =?us-ascii?Q?3dk62SvL4GlRgtYnTmu7XaZi8WE0aOYvW7eOT8PsRLeyXNwtGg/wnZDYNlIi?=
 =?us-ascii?Q?cJG4iFytI8IjH5d69nJJ3F5Ym0bRjscXt6wcOH9PQ2pd145E6gIadthOWDZE?=
 =?us-ascii?Q?1u5mel+QV1yOWnGG8F49IQjRYh1kXUsYECI0SbpzUcIUbjuWGROPppMmKW7D?=
 =?us-ascii?Q?F9usWs2bfWBAkN0zRW3kNTQ6+QcCtoM5lnBk7Dcj/41FkCe/WN36sFid4JhI?=
 =?us-ascii?Q?29mLUbi7QgXMTJTsXmfLCmH/iJWQvsDlosN+6t8C06Y3Hjgqev5q+GncRdqT?=
 =?us-ascii?Q?5jl9J50Pe9oiB7AnAtwpNRRh4zEkW4x6XPlb9ZsWbkRI5trEewCUHMA5iOfG?=
 =?us-ascii?Q?2hJcz6xmQ4i4KoIcyweMfTaRtUp+W0ipkdt34MEQIgsoIQ0FVSFERuBB52yg?=
 =?us-ascii?Q?bAhl+cFXx3XCj/sbQ0692Wdno6JvzJxMagfDkZgPjVs5uRKHU+kz5mgpa3aK?=
 =?us-ascii?Q?qPij/MW8c7SV9BB2QpjFkacgj3zPkg/5Zh+FlOPzHlUmjy6GHYSDWhWNOUhC?=
 =?us-ascii?Q?TdQQQtQmExKWGLi8z4rGuavOCR9NBORGXsLupGiOYZx5SaFfZc4ZOat1i7Bv?=
 =?us-ascii?Q?7fGLe5LYRuHaYa0r0uuIdyvA0iVCw2FGo9CzQ91SJliMPPX/MM1lEHwd3BiZ?=
 =?us-ascii?Q?Cmz27n33LyK/grPqmb4k2WTwyklzLyk3Pn7svIimr1T6TGpW8O3PNUXGwlES?=
 =?us-ascii?Q?rjhoH+Ho0ni0Rjrw5TuhuXBg9p8ngHMbkLsHEScpYA9mUYkKdr4Za0nwyC94?=
 =?us-ascii?Q?ScEFY0jTFRcOEJSlfDKWV8m753/PYXKfWUTRgdN89HBgn245ogjo+2+qmQ7G?=
 =?us-ascii?Q?iwxpNx6LLhWtNi1YPjDKQ4ZTuVgQc2ti0FH+jQLUBUvDKFEesjslxR/UKilZ?=
 =?us-ascii?Q?qzDOedZUSNF3tO3VmHn6+oEjvBkB2OvfX0/hq8WDUo6lhWEMoWngSI1ggbew?=
 =?us-ascii?Q?FS+QlEJ/IYHaBIJePNpF60j6xz57Fzc4oFxI+HUEGcfzRE0UoDXx1Kqd+Azr?=
 =?us-ascii?Q?PugFZcvUJlGEyGFBHeO+E/Ime2zeMTCBLmbLfyVk5pTr5/0B0wkHiBL6ljwB?=
 =?us-ascii?Q?9bAbkd6UX++bDykT15fZGonzujE+r4eSqQwHYmcfvZ5h417oJTf1omoWw6NQ?=
 =?us-ascii?Q?xPeHQlwdJZGidfJojG+miawOKGbsHfKPCgTCtdGQIS0aTNpcdxZhxvpy5jAa?=
 =?us-ascii?Q?w1vKFuXAfkpeCiuESbHeU73fUr7Nrey+wx8DsuQRDKgZTwGgsGnp5BEl5MbA?=
 =?us-ascii?Q?/cWcPjdQX5M9JYHzhvavHtwB4X5dQbCB1/Dw7AajkJ2yJNIyz3tvgUVF+20z?=
 =?us-ascii?Q?tmtfBIyyrKk7pEs5ZDnD/rg=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <E39713A19BBFB94292B57F33766E7A63@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 	rR8NSty2dAbi2JbF+yFIDuTEvTzXfWkU1vl6GfC/InBulg9OsBlcxTCtkQSaHI5PvP0LBGQ3fb8eZvJAMYAfmT9FPoRzb1PpWE+e/3gTQit5GIbGm9/rSW9Sy3W+o+qJT1dQp5wkIwRtGeJjrtTq1Vv7z+/oXMfNL3CuuwQxEOwnK+foL06KQ00ycYVjple1xGN1Vnpi4UTYjHazNFjPwDWlJN44n9X2pQnp8ECd/7w8wUMhNpFzgy3I7fSLuDCPWj1PbBTLh5sfn3pmuprInvdIQQHVJCj0EA/S2xeR4fvbhezE43giGGtrJqHNgLiOAgyGgEY5AWjux5eyM70psV73ilm1w7HtRa18SgIhtyjljtp+TQnCblJn+J2kqCL43GKEz1x4jbKiaKSiLOmV5d6CpmRf3AG3zV6IdLnYzTX6Qqkkn04uKP6Vvim8KGukYLYyDzRd+XqXYp9XCN7+lMVsRkFXQIp45In6aJ+28/1lG33llG245uC6Iw7JZtE+wLm/fEWlrRcJsoqs6CejPtvfnYMBrZezETFd5aq+O7Ps9gKxCSUzjdIbmMuXdeaHetW+DQK2d6TuXISh37sfS/kpiDXmBSO/pzCc4mknpbjCUJ70mGltlE65Za39XegCRpu7BtGCoVcYCzraS9aKYseNqm30sn7nfvfk4TQaLO7PSyfiaXON3+Pj30dAfG0Q7O2+kbTkEhUuMIsSShQer0dVZqXOrUvYsrtrdMDzRynstjeOCO/Vh9HpHw+TINWsLrFgn7eVZAMrz3G7eMLiICd8KXd64NKwOmJdzoux3whxOAEbfkRR3Fo4Xay29zZkT0UyN1fuw+ti/TvL7NXXE0uQtI/9cxXlR+sKzHXF0a4huP2Vm2NdLngjyItXLsdwFOH/L4x4+61dUXQ75K31Tv20zNqHpRnorWecP45evRE=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f23f4b1-ab48-4211-c30f-08db31901d31
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Mar 2023 02:32:03.7768
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: R7bpyCRUgd41RhFMoaMWtpoP1c0nZTlzDOyw7z3Txf/AczDMufpr1uGB/WlY0fElZtFwVMsMXim/w+JdhgZDkJtJw07i+cAKWQsn4zgSvxo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7655
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230330_193212_575260_2B123748 
X-CRM114-Status: GOOD (  11.09  )
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

On Mar 29, 2023 / 11:01, Daniel Wagner wrote:
> Setup different queues, e.g. read and poll queues.
>=20
> As discussed I introduced a _require_nvme_trtype() function to limit the =
test to
> tcp and rdma. I've upated the existing _require_nvme_type_is_*() checks t=
o
> explicit transport checks.
>=20
> Test run against current nvme-6.4 but it still needs patch #3 from [1] to
> survive.
>=20
> [1] https://lore.kernel.org/linux-nvme/20230322002350.4038048-1-kbusch@me=
ta.com/

All patches look good to me. I reconfirmed that my test system hangs withou=
t the
kernel fix patch above [1]. I'll wait for the kernel fix patch lands on Lin=
us
tree, then apply your patches to blktests master.

--=20
Shin'ichiro Kawasaki=

