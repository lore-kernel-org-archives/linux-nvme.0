Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C420C433EF
	for <linux-nvme@archiver.kernel.org>; Wed, 11 May 2022 00:34:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=L/TvXIXlIOXLNYfYDcae/3WvTmufUajdPjaMByBboUY=; b=0Pc9rNaRzGvulNflizVUki8fqp
	shU/Si15Y0X9sT6bebyCeDAEOq25j/web945W4EoON+RvUhVUTW8Rqcksz13oFyCTwILDyiakvQyp
	l8uv3N42yGynX7XPz67lTrUcsKGd59c2HpV1ZZKzOQcE08YVaXrbusr7upu+zX+Z3MLUhzyPbWJTB
	ehtUCO1VsWyswiCRlKgQgpTSxh0ZTMS1DsnSu2PojESFkuSad/mYgEeUG/xf4ALwGI9NEy+ea3DRk
	XrAGYoD0umONVQeCqkoqcT+koumY1WEqcWuZ+tML0AXTbcM3pYC5K4iUzfm5wV/rtZmAesWVlTGVQ
	oNdiqUYw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1noaJB-004X9s-Hp; Wed, 11 May 2022 00:34:29 +0000
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1noaJ6-004X6g-Dg
 for linux-nvme@lists.infradead.org; Wed, 11 May 2022 00:34:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1652229263; x=1683765263;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=UnIeOp37C4t+GovNW1bP0t6SbYzBRnZ2uolBVpfB0Lo=;
 b=VwVoAd5nFoFGK3RNzcQnw7NgTG42n3omdn16uQou3+5H6TafJTIIitJr
 Vfxmtx2caSswlfjYUqsYFKxETQsl/uAPBGnhLLk0oy84Se6B8HCIRwchH
 KeJwfG6eB33YNF7/9NIstrJfX99UeUfSBLMrxxq/mrLnsr9NslB8TlEWw
 sWTFGuJIl1G6WwGvxQaM8TSwoOVRRdSEEBt1FI05u5tjMTWq9tuQOiXbh
 dIKK4dtUaL9RZWzgJtIFtJeUiOpHcXhP5cXklHdwRs3KIiE4yjvJ9lse6
 6SxNnO+RMJD2zlF49hjobc2bZsOqx2bL0YFraxmxsuoTtoNjjT/fHfQSt g==;
X-IronPort-AV: E=Sophos;i="5.91,215,1647273600"; d="scan'208";a="200012068"
Received: from mail-bn7nam10lp2107.outbound.protection.outlook.com (HELO
 NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.107])
 by ob1.hgst.iphmx.com with ESMTP; 11 May 2022 08:34:16 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z/TQl6Gwh9KxNHOB7FNYLfmH0Zu1cI0fnNrKJDC3fPfDEWLLVAfZdhd9nRWhtfqyWrNQzfFzJtsNrus5o+fSzzskYICI/gADmH7i++Ha8SoiQ8SLY+kDLqix0wTcDX+WXbil1mv+KE1r3v6ZSx8FO4mz3xAkss/U4BB/7IiGV4U3a/ZZZje9jUC45kJuK3lv4bCIiXQ29/h0PbaISflgKJrF29uiE51FBLnIKBJT62SfEjdFMwX+flEszHv057Nj5cvIgpXiRGJdINYK3MnZj1LKbEuLEDfI36nQpx9k6LvR/+WItiiyJbiLoWfF/GudtCdGcERTbOOBq82Pb1RKoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L/TvXIXlIOXLNYfYDcae/3WvTmufUajdPjaMByBboUY=;
 b=AHPolyZgvDSiWg2P3ch2zath0x9LrzuQdUjTrYPYskzr4lbMErmtlZ5vHzg6dzqZd1tyhhcOpP6XqP80eqXZhsjWudhPUG/ruQWfH41GJ66L/iSXIvIdPIAu7vlrlqlURPbs4qTDACptTQIDSLx4cVoxFgrFGH2aMwQmjeHxDr4drtYfhuZ53/4MheSnJ/kKMaoWrjhkgz5QQIB9FtSRBJIbIBozesLL+4HIX9EXvjuxcrcaH3Q6r0QSQ3VrfZfD0XXGyXYkHYuU21IgFltZrEkXzqQTv2AF6sLUU5cifMrpK4CzLF+ViSs8v4JYn/bHKs3DCmfcoFLs2vt63lBq0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L/TvXIXlIOXLNYfYDcae/3WvTmufUajdPjaMByBboUY=;
 b=Zim8fyGLdK2e15cId8rzvBByaZl2xYpUGG5hhsSvWfi4IdGNQgihnWjs6OvAFnye+84M4EMFmTI/UKLNbbio5OAYAq8fU3hzJhvBJ7ZRv2gMFR6VY2i/CMgnTAWSQOUpCVFzGvHrzIGSeBNMbt/fS+9lSKrd3C/sDB2+3pVph38=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 DM6PR04MB5849.namprd04.prod.outlook.com (2603:10b6:5:168::27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5227.23; Wed, 11 May 2022 00:34:15 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::2839:2ab4:7871:416e]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::2839:2ab4:7871:416e%7]) with mapi id 15.20.5227.023; Wed, 11 May 2022
 00:34:15 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Sagi Grimberg <sagi@grimberg.me>
CC: Alan Adamson <alan.adamson@oracle.com>, "linux-block@vger.kernel.org"
 <linux-block@vger.kernel.org>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>, "osandov@fb.com" <osandov@fb.com>
Subject: Re: [PATCH v2 blktests] tests/nvme: add tests for error logging
Thread-Topic: [PATCH v2 blktests] tests/nvme: add tests for error logging
Thread-Index: AQHYZMXGygGC9N91ikS3jQdoRqSzkK0Yx1qAgAAMyYA=
Date: Wed, 11 May 2022 00:34:15 +0000
Message-ID: <20220511003415.d5s5jjpw47kejcb2@shindev>
References: <20220510164304.86178-1-alan.adamson@oracle.com>
 <20220510164304.86178-2-alan.adamson@oracle.com>
 <da090342-f3c5-b3fa-d062-553a4f8a522c@grimberg.me>
 <20220510232919.xoxet3k7cxboixmt@shindev>
 <6eab7100-168f-e371-dbc4-a8946925099f@grimberg.me>
In-Reply-To: <6eab7100-168f-e371-dbc4-a8946925099f@grimberg.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d6ee1e6e-b036-425c-3b48-08da32e5fa7b
x-ms-traffictypediagnostic: DM6PR04MB5849:EE_
x-microsoft-antispam-prvs: <DM6PR04MB58490546A4469FE4A72FC31FEDC89@DM6PR04MB5849.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BmiYrejvdeb0fhLUdpe8b+n0IogpPqH7qeFK7TWhiPR07onvAlKtwjVV712p1l6UUAUcap4xODYA0WexqmsesQ953k66w8d6eXJrMLpUE73wHJHe6/HhEQ75iOQ+OHbE12AyxBobb3wlMzzJivUHKxTXlFdv3Xpn5msJ2cLZsvQqdcrHdVhPi8McbFYfOUQNWQSBJ97oa2pCZitJzDnV5uG3of/e6TSlm5XiM+UJJ9xhfD6g0gkSGZafh2zCJFmKbduTTiEV75sJf/n0kX9EqLJb/p6pVIRdgLwXpfizOfVXNwl+7h2Y+PynyvwgPMVK8/oyx2EzTufDpvDcWmQhsJmXwDluYN1t6SwIttidJLtiqBv6uR+uKB7spGodQogYR824di3Oei0/5Trwa0TRKAJEGkL59aUG13w53fOtUJw3QVPZcPPuEVOeip4pwAs+RiERCeaDoZ8LvzNJZayPVxVSLqp4cRfoC/FIIMkHEJNVLYB6RCCusd3B7XV1gdqnn6BMEcelihSGXOqgcjh+KDhvi8USGAOwrha1WnWnzfcSIqNRXrYiotKDTjdQeB7zhbWs62jURGZ2KaP+b7mA2GHXc0/CD2jcRyGabC4VT6g0i92V++CCxW8YpeoPJqL5L/LeNnLzhFUI6uzvle79dzfQ7OB7wHM7wC200/ymB63aUOQbxrJV7ylHmS/xrEMvKiqFoGfxu6ztZ4ChvZBHuA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM8PR04MB8037.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(7916004)(366004)(71200400001)(86362001)(6506007)(6486002)(2906002)(53546011)(8936002)(5660300002)(508600001)(44832011)(83380400001)(9686003)(33716001)(6512007)(38070700005)(82960400001)(26005)(38100700002)(122000001)(186003)(1076003)(66476007)(54906003)(66946007)(76116006)(316002)(91956017)(66556008)(66446008)(6916009)(64756008)(8676002)(4326008);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?uVm9EmG7Aun5M62HNTtuWyIHNfxyNqiVs4HFgtExVWeRxoSgxHu3IjZ8mY2T?=
 =?us-ascii?Q?lxS8yIsYCSL9kxaxWhz5QXwNKr5cgVxEIELAsiJXQUKLAZRG/0YfKa/Rdlsh?=
 =?us-ascii?Q?OgUdtPWfvKJPKrnwvrWqVktjlGVqi6mXUVxBaVmy98VaVdI/mz7MdvmHAKK4?=
 =?us-ascii?Q?QNUavbPO93+9LUzZF2G6B5e47WwM1gPUn8Oq7afXy0CCAF80XvgzKl5aWE+V?=
 =?us-ascii?Q?X3ZU0UrpMitV18XUnOua9W7/976SPH9r8QiCcOtLYx6NE/daExwNpSsR7Vfw?=
 =?us-ascii?Q?JqiQ+VoiSqZNy8wf/wJKE3fjjFqAgytMx0qlEn0nYSv+aH2NWr1FAhVaCnq7?=
 =?us-ascii?Q?k2UOEsvco81jKDFeyOVTHxiMARMU0tJz7aufrMIMBcaf+5l1bytx0jaOLXyB?=
 =?us-ascii?Q?GwpxT3rZSXWMHa3qKryYYbm20dvhUrw9hdOcIMcnNFHvcpO55MNphq+rAPTB?=
 =?us-ascii?Q?SofG5mr22hUCKYLc1Xol31aBHulkruh4/Q/5XTI7bnScwdJzEIUvnc0WDs2q?=
 =?us-ascii?Q?CrEadzm6oxS8ceJoaF0RJifkiCnbBo6dKY6mkKY44nISl06PyV1+mPxBd5N/?=
 =?us-ascii?Q?0Xk9L+PnU+888t3U2OE8OBIR1S8Talc7EBGRYsCDBetcz+wGJsHeW/R8KzeL?=
 =?us-ascii?Q?ob264B1TEdmnrp8JKFbi6yN39nNv0Hzq4ahQ6zNvsNwgbUxrQzUl3k2W7Nq9?=
 =?us-ascii?Q?YpXkkgsRVA7umK/WjmuWf4FyBl3om738I3SDtPDQsqy/xyUfnLgjnFJctoM+?=
 =?us-ascii?Q?yrzVQNYipM0zrtCXGEFWWOjC4vSRpl9cPyxVnxp16tOmXDp5Uf9lKuoIxUhp?=
 =?us-ascii?Q?RAw7Oo4BgymbP8muWquEMKleNfMEYHSdKgGE1HCGTj1YQGcQjDVGnOnXmkp2?=
 =?us-ascii?Q?aR2ndIkOJ4Sz1UsPw14M1Lu0xq93/FyZp/8cGQ395FT759+bCs5lkvDxcuFg?=
 =?us-ascii?Q?06n1Qpz3bOFJabVeDd80hTXxzJxcbGFryzNyokpgFkz5PzQTcBjYnI8C/DAh?=
 =?us-ascii?Q?dLWGhTBEnfz/N3EATYDFU4hPFX3gxSs40/5laBzaGG7Rr3G8Gmgm4v3QDqf1?=
 =?us-ascii?Q?+pxI6pAS+LewCpv/aLym+1uIvlk65QjOSxZKB8tpixg24i7COchMo8Ysixs+?=
 =?us-ascii?Q?4ewO3VG6hF5l0aL2EprIb1RpZMjB6Viw/f+nrEnkWSr3uFyStV85ufAb6k+t?=
 =?us-ascii?Q?PkFd8GhvSk5vhBKEoKgjpdhoRDSIkqDeyHj1Eks/DVSrj1MpOJqvnqkv1P5z?=
 =?us-ascii?Q?bJwHWfsD2hHuTOzekKyaAJrn4pzHrJsqiR7x5R72fFJyVSRORoNaxkjIlSN4?=
 =?us-ascii?Q?8Uuv9fyvUWKEc7qA2aGzSDccVsl5CM+zJj+r81Xk9yQv8peK608ZMN4dVB07?=
 =?us-ascii?Q?D3Xs4EIvvsTzcSn23p6+TcD3khvlB/B9e5DpEEOlfe2PHgPy+vQjVBGTQ5e8?=
 =?us-ascii?Q?g3FuUrB0xUIuSBcB7ZUMNQ+V0B7CRwSgBFAbvD1mC/TIjVS7gKMQslJz6fPJ?=
 =?us-ascii?Q?zBTeeB9eyoIXJEGIejPTzy1hAS28Jc3KDRqgI7CU3gxIZtqJIP47pucjv/ej?=
 =?us-ascii?Q?OAHCvKamIGXaNwLAvyX8kICkhs/H2nJip4hmb30/LXsb7+jjWYuCdvLJXJWH?=
 =?us-ascii?Q?CQWgA/3paFVTZTmosSIHd0CHPHr4kk7B29rbB1N6xEQFmCCqi6NIu7fHUNQY?=
 =?us-ascii?Q?bFq5WN7XDQ9PLLTZ/K8O2iWIMoXe19z3/X0KZ880J6PSZFZadQpDpDHnayRf?=
 =?us-ascii?Q?AUkiYcca6RVYu9ei/tRNDjgTBn0c9SaTBPdgas4l8/lekXYGCCo2?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1CEDD4440C7CBA47B580B68C886BA1C4@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6ee1e6e-b036-425c-3b48-08da32e5fa7b
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 May 2022 00:34:15.7158 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bvizqesekIibGIY35TipZo0mXFWBxJWBn7gtrQujHhOYixojGgDkFlPAmqZiwDXxLo9vLxeaLtGzcah1m+S097WkAK/P/1ZkUatGvj5lptQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB5849
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220510_173426_348222_0DFB6FDE 
X-CRM114-Status: GOOD (  28.13  )
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

On May 10, 2022 / 16:48, Sagi Grimberg wrote:
>=20
> > > On 5/10/22 19:43, Alan Adamson wrote:
> > > > Test nvme error logging by injecting errors. Kernel must have FAULT=
_INJECTION
> > > > and FAULT_INJECTION_DEBUG_FS configured to use error injector. Test=
s can be
> > > > run with or without NVME_VERBOSE_ERRORS configured.
> > > >=20
> > > > These test verify the functionality delivered by the follow:
> > > > 	commit bd83fe6f2cd2 ("nvme: add verbose error logging")
> > > >=20
> > > > Signed-off-by: Alan Adamson <alan.adamson@oracle.com>
> > > > Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
> > > > ---
> > > >    tests/nvme/039     | 185 +++++++++++++++++++++++++++++++++++++++=
++++++
> > > >    tests/nvme/039.out |   7 ++
> > > >    2 files changed, 192 insertions(+)
> > > >    create mode 100755 tests/nvme/039
> > > >    create mode 100644 tests/nvme/039.out
> > > >=20
> > > > diff --git a/tests/nvme/039 b/tests/nvme/039
> > > > new file mode 100755
> > > > index 000000000000..e6d45a6e3fe5
> > > > --- /dev/null
> > > > +++ b/tests/nvme/039
> > > > @@ -0,0 +1,185 @@
> > > > +#!/bin/bash
> > > > +# SPDX-License-Identifier: GPL-3.0+
> > > > +# Copyright (C) 2022 Oracle and/or its affiliates
> > > > +#
> > > > +# Test nvme error logging by injecting errors. Kernel must have FA=
ULT_INJECTION
> > > > +# and FAULT_INJECTION_DEBUG_FS configured to use error injector. T=
ests can be
> > > > +# run with or without NVME_VERBOSE_ERRORS configured.
> > > > +#
> > > > +# Test for commit bd83fe6f2cd2 ("nvme: add verbose error logging")=
.
> > > > +
> > > > +. tests/nvme/rc
> > > > +DESCRIPTION=3D"test error logging"
> > > > +QUICK=3D1
> > > > +
> > > > +requires() {
> > > > +	_nvme_requires
> > > > +	_have_kernel_option FAULT_INJECTION && \
> > > > +	    _have_kernel_option FAULT_INJECTION_DEBUG_FS
> > > > +}
> > > > +
> > > > +declare -A NS_DEV_FAULT_INJECT_SAVE
> > > > +declare -A CTRL_DEV_FAULT_INJECT_SAVE
> > > > +
> > > > +save_err_inject_attr()
> > > > +{
> > > > +	local a
> > > > +
> > > > +	for a in /sys/kernel/debug/"${ns_dev}"/fault_inject/*; do
> > > > +		NS_DEV_FAULT_INJECT_SAVE[${a}]=3D$(<"${a}")
> > > > +	done
> > > > +	for a in /sys/kernel/debug/"${ctrl_dev}"/fault_inject/*; do
> > > > +		CTRL_DEV_FAULT_INJECT_SAVE[${a}]=3D$(<"${a}")
> > > > +	done
> > > > +}
> > > > +
> > > > +restore_err_inject_attr()
> > > > +{
> > > > +	local a
> > > > +
> > > > +	for a in /sys/kernel/debug/"${ns_dev}"/fault_inject/*; do
> > > > +		echo "${NS_DEV_FAULT_INJECT_SAVE[${a}]}" > "${a}"
> > > > +	done
> > > > +	for a in /sys/kernel/debug/"${ctrl_dev}"/fault_inject/*; do
> > > > +		echo "${CTRL_DEV_FAULT_INJECT_SAVE[${a}]}" > "${a}"
> > > > +	done
> > > > +}
> > > > +
> > > > +set_verbose_prob_retry()
> > > > +{
> > > > +	echo 0 > /sys/kernel/debug/"$1"/fault_inject/verbose
> > > > +	echo 100 > /sys/kernel/debug/"$1"/fault_inject/probability
> > > > +	echo 1 > /sys/kernel/debug/"$1"/fault_inject/dont_retry
> > > > +}
> > > > +
> > > > +set_status_time()
> > > > +{
> > > > +	echo "$1" > /sys/kernel/debug/"$3"/fault_inject/status
> > > > +	echo "$2" > /sys/kernel/debug/"$3"/fault_inject/times
> > > > +}
> > > > +
> > > > +inject_unrec_read_err()
> > > > +{
> > > > +	# Inject a 'Unrecovered Read Error' error on a READ
> > > > +	set_status_time 0x281 1 "$1"
> > > > +
> > > > +	dd if=3D/dev/"$1" of=3D/dev/null bs=3D512 count=3D1 iflag=3Ddirec=
t \
> > > > +	    2> /dev/null 1>&2
> > > > +
> > > > +	if ${nvme_verbose_errors}; then
> > > > +		dmesg -t | tail -2 | grep "Unrecovered Read Error (" | \
> > > > +		    sed 's/nvme.*://g'
> > > > +	else
> > > > +		dmesg -t | tail -2 | grep "Cmd(" | sed 's/I\/O Cmd/Read/g' | \
> > > > +		    sed 's/I\/O Error/Unrecovered Read Error/g' | \
> > > > +		    sed 's/nvme.*://g'
> > > > +	fi
> > > > +}
> > > > +
> > > > +inject_invalid_read_err()
> > > > +{
> > > > +	# Inject a valid invalid error status (0x375) on a READ
> > > > +	set_status_time 0x375 1 "$1"
> > > > +
> > > > +	dd if=3D/dev/"$1" of=3D/dev/null bs=3D512 count=3D1 iflag=3Ddirec=
t \
> > > > +	    2> /dev/null 1>&2
> > > > +
> > > > +	if ${nvme_verbose_errors}; then
> > > > +		dmesg -t | tail -2 | grep "Unknown (" | \
> > > > +		    sed 's/nvme.*://g'
> > > > +	else
> > > > +		dmesg -t | tail -2 | grep "Cmd(" | sed 's/I\/O Cmd/Read/g' | \
> > > > +		    sed 's/I\/O Error/Unknown/g' | \
> > > > +		    sed 's/nvme.*://g'
> > > > +	fi
> > > > +}
> > > > +
> > > > +inject_write_fault()
> > > > +{
> > > > +	# Inject a 'Write Fault' error on a WRITE
> > > > +	set_status_time 0x280 1 "$1"
> > > > +
> > > > +	dd if=3D/dev/zero of=3D/dev/"$1" bs=3D512 count=3D1 oflag=3Ddirec=
t \
> > > > +	    2> /dev/null 1>&2
> > > > +
> > > > +	if ${nvme_verbose_errors}; then
> > > > +		dmesg -t | tail -2 | grep "Write Fault (" | \
> > > > +		    sed 's/nvme.*://g'
> > > > +	else
> > > > +		dmesg -t | tail -2 | grep "Cmd(" | sed 's/I\/O Cmd/Write/g' | \
> > > > +		    sed 's/I\/O Error/Write Fault/g' | \
> > > > +		    sed 's/nvme.*://g'
> > > > +	fi
> > > > +}
> > > > +
> > > > +inject_id_admin()
> > > > +{
> > > > +	# Inject a valid (Identify) Admin command
> > > > +	set_status_time 0x286 1000 "$1"
> > > > +
> > > > +	nvme admin-passthru /dev/"$1" --opcode=3D0x06 --data-len=3D4096 \
> > > > +	    --cdw10=3D1 -r 2> /dev/null 1>&2
> > > > +
> > > > +	if ${nvme_verbose_errors}; then
> > > > +		dmesg -t | tail -1 | grep "Access Denied (" | \
> > > > +		    sed 's/nvme.*://g'
> > > > +	else
> > > > +		dmesg -t | tail -1 | grep "Admin Cmd(" | \
> > > > +		    sed 's/Admin Cmd/Identify/g' | \
> > > > +		    sed 's/I\/O Error/Access Denied/g' | \
> > > > +		    sed 's/nvme.*://g'
> > > > +	fi
> > > > +}
> > > > +
> > > > +inject_invalid_cmd()
> > > > +{
> > > > +	# Inject an invalid command (0x96)
> > > > +	set_status_time 0x1 1 "$1"
> > > > +
> > > > +	nvme admin-passthru /dev/"$1" --opcode=3D0x96 --data-len=3D4096 \
> > > > +	    --cdw10=3D1 -r 2> /dev/null 1>&2
> > > > +	if ${nvme_verbose_errors}; then
> > > > +		dmesg -t | tail -1 | grep "Invalid Command Opcode (" | \
> > > > +		    sed 's/nvme.*://g'
> > > > +	else
> > > > +		dmesg -t | tail -1 | grep "Admin Cmd(" | \
> > > > +		    sed 's/Admin Cmd/Unknown/g' | \
> > > > +		    sed 's/I\/O Error/Invalid Command Opcode/g' | \
> > > > +		    sed 's/nvme.*://g'
> > > > +	fi
> > > > +}
> > > > +
> > >=20
> > > All of the above seems like they belong in common code...
> >=20
> > So far, this nvme/039 is the only one user of the helper functions abov=
e. Do you
> > foresee that future new test cases in nvmeof-mp or srp group will use t=
hem?
> >=20
>=20
> I can absolutely see other tests inject errors. I meant that this code
> should live in nvme/rc

Thanks for clarification. So we expect two patches: one to add the helper
functions to nvme/rc, and the other to add this test case.

The inject_*() functions refer nvme_verbose_errors for dmesg filter, which =
is
defined in test_device(). That part needs a bit of rework to move to nvme/r=
c.

--=20
Best Regards,
Shin'ichiro Kawasaki=

