Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 145BFC4332F
	for <linux-nvme@archiver.kernel.org>; Wed,  2 Nov 2022 10:46:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5/pUsykx1OWM3rpdIrZtAh17PKa6Yup//n5SQ5HKWHc=; b=QebcQ41NnqNc3fjpQwdBwxLdae
	DjV6LJP0QlFEieOCA/9EICt6WN8j5fiY6bQhidd/YbFFR24BwY0C1TpDA4Ogeaj3CmYhNNz+XG0IJ
	9znqjOK703TUIPZWhSfQQRKMASk/F0KFIzVz4tEMkgb0/93Key0zeVy0R/1D7n+k1lgGIsvbT/Qdb
	zVGSFq/NZ+DjcljsI7XEez5xP7Zl2ZI64oeRfg2KdSk5hmJZuny+CKPYvO+v/ylG6nop6hGaz/KW+
	ozXtFGSLwPtJX/IrXzD/Lo7k990mNSynAy8KyAKwfu7KDqG25m4xCAT+AEZlU/sBnq5CDT5XP3oEY
	2GygdFLQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oqBGV-00AZuF-Vn; Wed, 02 Nov 2022 10:46:36 +0000
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oqBGS-00AZsY-Lu
	for linux-nvme@lists.infradead.org; Wed, 02 Nov 2022 10:46:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1667385992; x=1698921992;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=oQHjM2fvdrh/vZZatzZXPv/owSPoSlRsOvbShK1Ztjs=;
  b=es+7OfC3/06BW+Qi6pgu6MriiukkuuBHNskcDZ6PkqyOHH5RGSdwDjBu
   QeyiPo93h60BH1qjRLOGjr/gF/tpYrRwNngB7oQftZt74xweik03i+/tc
   9SspthAZg+ypTzRvsb8ZvUfi1CulPztN6fXTSxRwz0ijxyYMLop3JSi/L
   5MNmLGr1BlYhITM7dMaiVvUmn9CUiWX687dW9pI9TUi2AnBK//ijJl1Qh
   gotgj69bNgMuf/CMDcQSe6lhcmq+cM6j2FpoXaOZT2xKcmV3imxVBDuJP
   N99JacAjENYBOXySJ//yUbmFJmJogCVgGMal8JfqILcoGjWtbEfQvRpUI
   Q==;
X-IronPort-AV: E=Sophos;i="5.95,232,1661788800"; 
   d="scan'208";a="215306037"
Received: from mail-co1nam11lp2171.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.171])
  by ob1.hgst.iphmx.com with ESMTP; 02 Nov 2022 18:46:27 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PlQG2lHSPywyQfvRotRgQNKhGvfxOeln2VTO8JgOFFdAF2PqTZivf/yCUeIUtDgNvM1om9veHwTxdIBS/OYu/zzpRDzL2H7ES0cUZpN4C1PTsmOlfQx7k1XnWfrzLz4+rHbNWVdlR8JcoGzJyCFbVG2Yk74BmO+hbwhNT5ewRMzv/i0mpxgPlfxGhg1Nmzpg1A7bDuHrm4xIUtt/hmF2TDQS9L4YI5Zb5f92KmrdQKQMesp333e6pE9ytjtNterbd4faXhCO90TaQgWPS/loOScDU66s7e8Uu+KoGbvI6NhFluGQ0T2eSnUrOjXm722ByCUQe2UpPBs9DkDF/BUwFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5/pUsykx1OWM3rpdIrZtAh17PKa6Yup//n5SQ5HKWHc=;
 b=Xw2N7S8c1vdNstAmtBlWk7hVzxU7KgXJddPKyx6Z1E9cU4NCZLerNxuOuwYAZOmv83o7UOyI3OgapQbQCP8W7rfKrUhgZ8tClez7eEMqYyz4UDWR7DoovUEa27rmfsq6UQGXmnDtpxgBvuMj9BW9/wGZOOGpAaGEbBm8FF5x26tRfYZf50s67wDnSUaZA7UQbBxos4H8wfz76LriY+8LvSlBXN3rREtugIIsq9PXAX0Rn8lkR6MsnlI3osRNy4kyKC7QiAUfXa0P/XW7FGijJ6qpKPoqErA0JWx3mnFhjOwPwdDSP/t8Kj5Sypp1AMTTNSkmoNEeK+ZiUnnwfQWFkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5/pUsykx1OWM3rpdIrZtAh17PKa6Yup//n5SQ5HKWHc=;
 b=UEu618U7H1+02pD/NSUM/ZTb2DqU00kmfuS73Hpcm7ysSMo26QWrdOL1x/Fa2FWN7dCOqxj/TI99ZqiHErjPsW8BcRvVupx+xvw9mtuJ+ea5GZCduQViVCUtJZi4Ds5ABHOlszQ+4xEdwuRbNh+N7QnloJmyfaiENCFbmF+FvgY=
Received: from MN2PR04MB6272.namprd04.prod.outlook.com (2603:10b6:208:e0::27)
 by CY4PR04MB1016.namprd04.prod.outlook.com (2603:10b6:910:55::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.33; Wed, 2 Nov
 2022 10:46:24 +0000
Received: from MN2PR04MB6272.namprd04.prod.outlook.com
 ([fe80::cb5e:7ea3:2482:80f8]) by MN2PR04MB6272.namprd04.prod.outlook.com
 ([fe80::cb5e:7ea3:2482:80f8%7]) with mapi id 15.20.5746.028; Wed, 2 Nov 2022
 10:46:24 +0000
From: Niklas Cassel <Niklas.Cassel@wdc.com>
To: Christoph Hellwig <hch@lst.de>
CC: "kbusch@kernel.org" <kbusch@kernel.org>, "sagi@grimberg.me"
	<sagi@grimberg.me>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>
Subject: Re: [PATCH] nvme: implement the DEAC bit for the Write Zeroes command
Thread-Topic: [PATCH] nvme: implement the DEAC bit for the Write Zeroes
 command
Thread-Index: AQHY7qhaXUijfZw49Eic84P/skFhHg==
Date: Wed, 2 Nov 2022 10:46:24 +0000
Message-ID: <Y2JKQEgtOYk2die6@x1-carbon>
References: <20221030162906.3390-1-hch@lst.de>
In-Reply-To: <20221030162906.3390-1-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR04MB6272:EE_|CY4PR04MB1016:EE_
x-ms-office365-filtering-correlation-id: bf9d1c03-3647-4cba-7b65-08dabcbf7cbf
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  n3ZDxuNs6FskVofy8E+I5cXLLTNH1liK/8FkjGfq/x4sNeVSdqhluHnWki2pLVIxKWRejVtZWnBmy7TtX1Q7HsQSCHhkRifk75nUntfysMpDwVlJBOxiNBbIjB9jFgqyjiwSUsYv/+HuJSfhgOTa3hl4psSdA60bK7OisVsfIzQqJzUFd7ioW05Dk8yxChXdClAh7/o9PRTgMHX6yci2tProFaZq+pA8HxEnLXIwwbFldSeb4d8CPw/HOaJyLiS6Op7mAtjnYWVL1NUAzckNAf1dTMrKeuTT1gBoUyhEKijaIFlDqAK+IN7tY3fm3PMK7jRhm2cr7+rS5FLEPFcBvAu7RfFxKPfoNPx75osw1vUZol1ha/RvXWrtziGG/LyINtqPL2NXDnr57sOT7VQQQsT5mvljAZsuKd8ZF0otinBREXTd/vVjq5q0oht+//2MmTLFCK4Lf2R0kDBzrCHiOWGQEiwDbvzJkYykX3vfnuac+UqIoK4v6QvWCez0ZTBfThJ7+VXWD5v0M4HuldheuTi6KG+mM2qkSxF+/GywvaHuahgTK+jFVh7uccMIZ/iuvyg57Zl9EfLIcEv/aCSFNCeJB0kj5mk8LXovTI+AJ0uXSAAu1ZpaQq+Hm23VjHnPocPgqRivFYP5W7bRI7n+np18ZDVUBmwsgHsCSQhJRLp4rhovZj2lfc6uh0iLE0e/5yhplA/8lGHH6/v/Rrj8Ehnq0OyLvg+5D1U8vaoJaILWvvpOPD0CHZycJZf9xjkyJzan8B/bvPY2Li3lwpbm+w==
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR04MB6272.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(7916004)(366004)(396003)(39860400002)(346002)(136003)(376002)(451199015)(186003)(38070700005)(86362001)(38100700002)(122000001)(82960400001)(6916009)(4744005)(41300700001)(2906002)(33716001)(478600001)(5660300002)(66946007)(6512007)(9686003)(6486002)(6506007)(26005)(66476007)(8676002)(91956017)(66446008)(66556008)(64756008)(4326008)(76116006)(316002)(8936002)(71200400001)(54906003)(66899015);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:  =?us-ascii?Q?KbCGVKPwc6TiQZHEiCwNjuTxXkdp0hrfqH1feIuSCbh0D0UEgMFU6jcKd8L0?=
 =?us-ascii?Q?04c969w7VyENRzNz4Xe6y8vHIxftAVTeei426GLM7C1Wycx/R1G8rXMIZS+R?=
 =?us-ascii?Q?qD0Rmora+KQdUDALnV5Jjlts8nADknxGdHR/f8W2HcflmC80vyvQtQk+qn+N?=
 =?us-ascii?Q?0xmUA1oQzq6jtPZHyidiylA18q0bkaNQk2dkNymdo5wryrs8orx3AUIviNle?=
 =?us-ascii?Q?+syBGwJcS0wp7VcNqP6/F2UA9aXaTd61t+MUmUbkC399ngGVvC6dtWuo0laK?=
 =?us-ascii?Q?3C3Lhxepjqh9wZO3eAsVH7AUjy/GTWUkjz7vCI1nQ7l3eUUBnAJx5SeBc4Tk?=
 =?us-ascii?Q?c3alp5gzqXGbod0MNpSSA2oDk7/b0G+QIWnYTNkN5Z3Z3SnMK969OtX0ECsp?=
 =?us-ascii?Q?r/ZlIbJEV3aKbk2uYfexd1NXlJGo3u6O2d/uiNZCTJDQRpbsxm0mSLfXQoaT?=
 =?us-ascii?Q?7AipYl/XGnE0bcOgdlDaxFblgRd2B75wQ8x1FanU5GFpabsl6sVBwWIGhR1w?=
 =?us-ascii?Q?7OPRHvV6Sd9jSL7jiQD7+7mD07OS+4z8mo6zj/+Oexqpf2n/M5J1ET85STlb?=
 =?us-ascii?Q?kMF5TusvY8suO4lIuL2j7IXgWf5/OuQeMOTTBulKeHcDLVtq5Xko/r17H48b?=
 =?us-ascii?Q?Qzlu060liVlQyNCZUyIVXlYZKcagDdK+JMNswnwLyeVqfsPZ9joZyOHi0UaF?=
 =?us-ascii?Q?i4tVbK4kjb7ERoWOPBqyhX4ZkFx2QPwPfauKXhq0e4pENPfS8cnOCS/2kZBt?=
 =?us-ascii?Q?BEBReAH5aFXC8BjCeTsxrZDTguYoo0bL25OCjyhFcUIhmCvpl0szomcGuGEo?=
 =?us-ascii?Q?KLFONP+YJomEpc8S5g7yrOLwMe3KMxpcCrHlI2L9fpbFrb5Txp/7ZppG3u/C?=
 =?us-ascii?Q?wJhFxZX6rK9eq1fpu7g0laPNf1Fuqk7+g+lW7dTI/0cK/QVc55KQA5jiB9lN?=
 =?us-ascii?Q?3F/+PJ4MVcC5BwXJ0kAZFCSX6srLBRElIm8NFkBWh1uP7dDwDLqVPUNGIxAp?=
 =?us-ascii?Q?W8sIbF/SHC8OPMYW4flHhw1qaCx2C5dTcdpDqIAhUc6jl0ViNmqaQuIFB1mG?=
 =?us-ascii?Q?ydm1cL5wq54g01wwlRACrcoDYTM1ACvlmuEmGM+/toJpCRtDmybyBoD63eKS?=
 =?us-ascii?Q?VapnUlpUuONgisV7vh7X5N58W+ZVQJ0cYPRv3h732/snMmvYvgUWiagdg0n1?=
 =?us-ascii?Q?Glld726z8fqZcBfpwawElhmokZxut4rVzs2PXyl0nHhR1mor5bUqPki8WLX8?=
 =?us-ascii?Q?y/24YzFK2xeV5HzRX8ahOUrDlJLD81QzePKWnAaZLGJd2u78mAjGMHsMFW1O?=
 =?us-ascii?Q?QTWentKFLdMEfEN3vAOXaw7V5/6ktSw48eSlPE9WBmCA/7Zz3c8FEs+hac38?=
 =?us-ascii?Q?LrVZpCX9wL7/H6tFlDiHiOnTUmlATkfldw6yfI1adnD4CwC+6M4EuAeXVh+w?=
 =?us-ascii?Q?3wydE9AcLMGF1uq5x+nc8A/wC5oev9sHYU8gbRCuWMFIlrjpV3AqDlPbxubs?=
 =?us-ascii?Q?wlUlq/p3X1j1nKqPrMU77XtQY6HBpE+DMMgv3nQATNUo9sililyEhr6+/43X?=
 =?us-ascii?Q?MuT7Ap0sITrwhHCLxcpCcZ4AcjAhzatSzMyZpB38fGV/dVZHf9fjvQ7MraBA?=
 =?us-ascii?Q?Kw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <97B0E7C957DA0944B9B2D0BFAE59F2E7@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR04MB6272.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf9d1c03-3647-4cba-7b65-08dabcbf7cbf
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Nov 2022 10:46:24.3733
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +mqXhSn6UHr3LEkZHeUmbRISvt0x19DW36c7Rp+YV5YTPNVd7nheJY5K4RWjs+Zr5al5WW5TbNOkWvB/gy9APw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR04MB1016
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221102_034632_799186_28ECF683 
X-CRM114-Status: GOOD (  15.06  )
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

On Sun, Oct 30, 2022 at 05:29:06PM +0100, Christoph Hellwig wrote:
> While the specification allows devices to either deallocate data
> or to actually write zeroes on any Write Zeroes command, many SSDs
> only do the sensible thing and deallocate data when the DEAC bit
> is specific.  Set it when it is suppored and the caller doesn't

Nit: supported

> explicitly opt out of deallocation.
>=20
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---

Reviewed-by: Niklas Cassel <niklas.cassel@wdc.com>=

