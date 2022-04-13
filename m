Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CD46C433EF
	for <linux-nvme@archiver.kernel.org>; Wed, 13 Apr 2022 07:34:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=YNR9bvEmA/9SdtwLsIbb5ByJMtBh99GIH47NxmaLcXo=; b=ECcX7Qbp8doCHD0770sllWFR+w
	Yul/xUK+saQLYWXyPJ4IWksiSSRSYGWkO2mlZ51v+VwlT+GYdRhuw0A20CTF7Na8lP9gess0cbY2D
	QrQJ4+e+25FmsIAFc/ZWiFOmdQrH4ijYKucGKtV6wjE1Vt/zZgWLOgSN0Wl3R4wI/uJGr/aSCNGKk
	pQOURbffj0mN2c6NnNe1XD+powQrrkl0nkcGwAa+huj24msdFOLe/WvSpEv7O7BkqpY+Jk9D6bF7A
	AkLmSpOSD/TXjU54bOaKQfeLko/x1OWWBFJG512vl2RNeYwY3PnuMZTwJAB3S2mNyN0zPUj3Y9Yob
	r8wIo7eA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1neXWI-00HQ4M-7p; Wed, 13 Apr 2022 07:34:30 +0000
Received: from esa3.hgst.iphmx.com ([216.71.153.141])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1neXWE-00HQ3Y-UJ
 for linux-nvme@lists.infradead.org; Wed, 13 Apr 2022 07:34:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1649835266; x=1681371266;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=Q/PZ2/Ly/VIxGevIh9/mcM/dilOAg9A1JE0vNZQIZdk=;
 b=dOlm3o1phbnQD5wracH1Zd62iKS8vZKWGRe5kTvsP+DsFkFHVMM/Aiie
 z+G2kZMNb0uwnB7DiBrjVz+eLT6FUdl8q7yRe/PjIllyvBNjOED4OTqPb
 0C+SEBroZERgbiNMroqk7YUUI2pxc3OuTtucldyVtaqLPPlfy84Ymdb42
 DxGtGQaQ4/ZARP1kjqsiihoy/ZklYsrlXnLqb3h8WMtgoss8ml+OiW8+d
 ZxJuXx0nWs9DwPc8mGPizfsLY/M+JdJJ1EvDPMf3wZKHZ0KZy6qQ6lHzj
 lqkatWkLGpcjpbNU9U4V2PuHEMPDQv5bGtfN27SalV3dieDZawK7N1Xtt A==;
X-IronPort-AV: E=Sophos;i="5.90,256,1643644800"; d="scan'208";a="202659069"
Received: from mail-dm6nam10lp2107.outbound.protection.outlook.com (HELO
 NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.107])
 by ob1.hgst.iphmx.com with ESMTP; 13 Apr 2022 15:34:21 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eYo7Ejt2qPlGVMTKcHSo5218RKg+WpGT6nDHx1Cpb+aVI3CokZvLbDkb+F1nyA0gFpbl3/sfOeqKFZiD7WsVb5aRyYUANdM/Ci4zEjMyV2nxB+vNH91ezc6gPkMl0OYwqC6TuwjDjGGqhRYtR6VsKsKQquvwv00HUwEoJ1whroznnkr2RKzax/fhXloSmd1GkqL+U5kXG7BEsgEwLb6atjsba5TtVt7r1nmGfdNWsu6I4iuOGefenUHVQ26lJpRPYMkkVhO6eW/bbYabmP4zcb+vX36KG7/8gNI+iPvK7jBt2G2nuxRe382AxboEgBLSIbc1uIEixb+7ec8x1J3DpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YNR9bvEmA/9SdtwLsIbb5ByJMtBh99GIH47NxmaLcXo=;
 b=bo6tj0aHbY9ZMsFf6VGaYlcz43S3Wt7EkWwfiy8umoj7zq+WtxotAxWQ5SlI1JpI735pIV2uC1c076ycMBWLqF5zbuQA6pwap7tD7wyfb1c6D3pG9o8O+8tfdhkxQPqLYFc3G2wXhbNFDmXcYBSK4b/5JwWrMzzQuc675RFtoHXqtkdqMN6r2ZIElAaD96OTtFqTu5WpqJGN6VDMqnS8YnD3r2iwoh1J00qFxvAzrVqeZ6JSRV+7SbRrfctluTMeyOmM6LwQFM2RdXuXXMnWo//TpRF9akEnKRelgfzJgKp52c0ONLLVm9Wj4Wwqo81klxhgqroQGACYDG1K8xXsyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YNR9bvEmA/9SdtwLsIbb5ByJMtBh99GIH47NxmaLcXo=;
 b=dYFubp5L893/VsdVIPA7GJsev/V0EOcOXexemaJ+jiIX6QPlnU0XdHOvN4vSnrD4369vvCNlnaIEot/9O27x3J/i9hiP4gTf7jwV6mKfQ51DKPJrM8MjIZEIgUiNE/3apwWQOg2yuLpJaPBKE7Ata13Fce3+WPOtZ/tysSpVFSo=
Received: from PH0PR04MB7158.namprd04.prod.outlook.com (2603:10b6:510:8::18)
 by CY4PR0401MB3505.namprd04.prod.outlook.com (2603:10b6:910:8b::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29; Wed, 13 Apr
 2022 07:34:20 +0000
Received: from PH0PR04MB7158.namprd04.prod.outlook.com
 ([fe80::995b:363e:8d1c:49af]) by PH0PR04MB7158.namprd04.prod.outlook.com
 ([fe80::995b:363e:8d1c:49af%8]) with mapi id 15.20.5164.018; Wed, 13 Apr 2022
 07:34:19 +0000
From: Niklas Cassel <Niklas.Cassel@wdc.com>
To: Christoph Hellwig <hch@lst.de>
CC: Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>, Luis
 Chamberlain <mcgrof@kernel.org>, Klaus Jensen <its@irrelevant.dk>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH 3/3] nvme-pci: disable namespace identifiers for Qemu
 controllers
Thread-Topic: [PATCH 3/3] nvme-pci: disable namespace identifiers for Qemu
 controllers
Thread-Index: AQHYTwjjWSvWu+QEy0+RYoKZ1C/5qA==
Date: Wed, 13 Apr 2022 07:34:19 +0000
Message-ID: <YlZ8j70shRKv/tif@x1-carbon>
References: <20220413044905.376785-1-hch@lst.de>
 <20220413044905.376785-4-hch@lst.de>
In-Reply-To: <20220413044905.376785-4-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b2cc11cc-3470-4dc5-15c3-08da1d2005c3
x-ms-traffictypediagnostic: CY4PR0401MB3505:EE_
x-microsoft-antispam-prvs: <CY4PR0401MB3505E4A95F77507C25F19974F2EC9@CY4PR0401MB3505.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PHCYBqW4ayYMFvAizzL2cOjFyL9XrH5IIO31IMstHfwGdUxVxa9TDd9b3oacs1fkujZLYYH7OmrMIX+GpL3xhwGsYfjd8BxAp8Hz7KguobpX5xRo4kJbnqa/2fIVAeO8gx762AF/wADn6UfIKuaPeNDsPyVSUPkdQ6R6rxuan9MVVfOY1MpUrPnvUvPo0KWHtP82bCqxtGGe3KF/7WjdaOaIxsZlyT7TR9dAj8cT6oq4NNQ7P3ElZg7qqvFW09m7TlrC87tryl/LBfrlglntRPqUgjUhJi+jvo198ybIIiGS40nVJLWK2pImvoX+5thfvstZVXQOiSmVdfQQgJuqqk8QwTwwEH62pn2RbnhbslwJsnVow04C0UhgWVy4EPCb3+3I5jPrr/Qhhs41FVcjk3yiNWkae5cfQX+3Uy7m7ec3QzX01lFRM6y3W5vdXGJuVWZb6fXcwWlkVpjZXiy67Zw+l4sfsjRkhfdevZNWW8CeuV1Wx0ZFpYmspwguFVnpldMKM7Ecq6mms8yXDTs0n4TJGvCIl7UmgRRJWNbCEyf0+wd9OKMmqDUolKFffKvkRvo16XhRFAYh+wtQU01eKTJH34X/6i/ZoFcdMIpebUHkvLUQoX6xcmX2XCMTgF/9xfbsw88RgeaMgY54YHXa9R5VzHPrl0YOrYpKQ6bGDK08zN28qQJiuqo/YVcG0qSXkBFBJbZGb7pTPXE9eTqK9HjvgMnOVgTdqvxx14AgkG9KfKX5qmpOrgpVNmCtxMdyt9qWbhEgbnrI92+u8f7bTR1PkLCOmpNidRs8D2g8icY=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR04MB7158.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(7916004)(366004)(26005)(76116006)(64756008)(66556008)(66476007)(66946007)(8676002)(91956017)(33716001)(186003)(8936002)(38070700005)(5660300002)(82960400001)(122000001)(2906002)(9686003)(6512007)(6506007)(66446008)(4326008)(86362001)(38100700002)(316002)(966005)(6486002)(6916009)(54906003)(71200400001)(508600001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?llJCsA0GNbQlPWuiRr7uebJ7aSTu/P9uc2tv6uIdrUa5zOr0KDDIVLyUdYJ0?=
 =?us-ascii?Q?ZCP5eFSJP5CHTxsNwGxzy587fLbpCXu2V4MUoCloUyrQ+CtYLkvKeUTnvGe5?=
 =?us-ascii?Q?L7UpxkYiqVxdhFA8v0G0YKdqR+X2jw5UarL7j3a52kaMAKwqFOD6+XGcUxwF?=
 =?us-ascii?Q?z0p8ZCoypqksLkC+faYhXX5XQiIsleEv8LYRLzDPBYz/ZHqNocqx/pk6gsXA?=
 =?us-ascii?Q?URvR336016b91l8uCosMTAffPM9uMQ8r42/QtIaBqgednZqeBisEF/xkjEOM?=
 =?us-ascii?Q?QR4g1Hfd9/RUDFt2j9NcqUbvD17GGdk40lQ2qCgDAjtSJ3xIAdyG+1XC6ce8?=
 =?us-ascii?Q?2j04+wXeVKCTgYitQp1RHmePh/akXwvEJFvXu/3STEX+jnEoH3oxd+2OTHL0?=
 =?us-ascii?Q?RFqC+CDXZ+rrhDLnuvDPPqShl404Kzyf7vMarrERqdrl5Un+NvQO6rYyElB3?=
 =?us-ascii?Q?SBs/Xncf27d1MLUAF/WEpPUmOvcTjmlFdt0e3rXNQCa6Nf0RD7bePX5lQEAo?=
 =?us-ascii?Q?79XOiuCHJj5rii0nrzzm5GFq/Z6m+F3Aw+3w9G94RM6OPD82NV5G/OxyPbT4?=
 =?us-ascii?Q?nuSh5FAuqXA7rpq2p+VCHJp1Ad+cuEBt06/EPNP0Stqy/XDZZnmsj+X7nfgW?=
 =?us-ascii?Q?IjYeYyVll4CnrNY/sdi+60ZLdVIVpHgrUzuD9zRWWiS72gsDSkJapz3XjQuZ?=
 =?us-ascii?Q?FZmtG5dw+77wHyzB8FnOpUEE/esloo+R1u3W9SkV9xQbCQ2s2zjQ7rQvT46p?=
 =?us-ascii?Q?P6o0N2YVbXwkSAtOPge2cOH4j+DyMqFO1Dm0S14Wt3Bw/bHpt9g2Bg4jHud9?=
 =?us-ascii?Q?YUynSxAeev895QlZdk2Mp2k4BJ+qSzUQ4o5PnxyanbbOZa1gmUzUkFeR9qIY?=
 =?us-ascii?Q?i1ePEuIhGSP1KO2J7YWFYVOgGhLpD1vQfP05Qpz/gVs1q89zlxBApavETIM/?=
 =?us-ascii?Q?E2ADkmeIxbVVm4PuAR9+KbBwrBGewshQ1fy1FYVODmcSE2rRbrCG54JNijMJ?=
 =?us-ascii?Q?x2+ArRfyb4EioNitUJwNvvs2Qa9OVFUgIHGZ3mnqYnyHISd/B5tpnIFndu4t?=
 =?us-ascii?Q?cxvsyZOLOKFu5SRm4UsBPU4nv73X1g3TiRURees/pCQ58+RVI6+DdvckIAMl?=
 =?us-ascii?Q?x0z5x2f9CrC33pzYOGBoDmzCuPd5vYCc4CtkPX/mMDkTDGuXxf6UCWolWbRE?=
 =?us-ascii?Q?fGqVGl24q6NdjtzfkhLCdtOQxKbWrqURIFcFcbd2jSTrRNtowKnP7Ds4yQD1?=
 =?us-ascii?Q?zfqPValbEzlKQPhprJGmu4k83FGMkJ4WxD7abc54f0/21J73iUIUoBjaiZ0K?=
 =?us-ascii?Q?+xEIrhBfLlmIZcAk+O/9g81Qxj7EHNtPXvhX6nRzRsr89dgIZmv0eqp0FUER?=
 =?us-ascii?Q?mTzNx8MyVQS6hRPV1NMV+shpy7KQWbrV8Kv4uR9KBvJToJZLHUZCavOlfkVR?=
 =?us-ascii?Q?hiVkUFje+HqaG7UmP21s7MjW4hmTo0zWV3QU2x/kQ7O5KtUhlyHjA5v4xxZq?=
 =?us-ascii?Q?s6frfQ10ZCqcl2N2H/3fdtwwKpTbkZFDrB4jE7v8lMD/sQV5pbxbzYdogDxH?=
 =?us-ascii?Q?mQLTogYYuiJ1hhnREsv9AvDm+vuaVOE+UFkTG/y/kLACFCGwxKpXXVowcMEd?=
 =?us-ascii?Q?xcr/z+JIp7K/hL4EV92qv0h2Vmwc7SmNgXGap7iG4JH8V8w5FsnOgqtYce7b?=
 =?us-ascii?Q?HEn77B7EP+eG9gB+QqBE/sUmMRwdi0g5tPMPKr8ugcUr8nni/EvwoRRm7KmS?=
 =?us-ascii?Q?dW7gC8KICqlY61MX5d66TbzpKRwHaMU=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2DA6042B8DF84F4EAB556C1F1BF44478@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7158.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2cc11cc-3470-4dc5-15c3-08da1d2005c3
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Apr 2022 07:34:19.7771 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HysoUM31akVAJXdMnOKQ4TzzaUXmW8r3w9oLQupcSJXGQXd97n2ziR37bHEKtDf9c1a/XcOgD7mFr/E3ao+nHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR0401MB3505
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220413_003427_280343_2B37EC3D 
X-CRM114-Status: GOOD (  24.23  )
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

On Wed, Apr 13, 2022 at 06:49:05AM +0200, Christoph Hellwig wrote:
> Qemu unconditionally reports a UUID, which depending on the qemu version

Since it appears that both older and current QEMU versions are not
implementing this properly, perhaps you should also consider adding
the pci vendor and device id used by older QEMU versions?

QEMU nvme pci vendor and device id was changed in commit:
https://github.com/qemu/qemu/commit/6eb7a071292a2f11065127ac152fa2424880602=
1

Which was first included in QEMU v5.2.0.


Kind regards,
Niklas

> is either all-null (which is incorrect but harmless) or contains a single
> bit set for all controllers.  In addition it can also optionally report
> a eui64 which needs to be manually set.  Disable namespace identifiers
> for Qemu controlles entirely even if in some cases they could be set
> correctly through manual intervention.
>=20
> Reported-by: Luis Chamberlain <mcgrof@kernel.org>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
> ---
>  drivers/nvme/host/pci.c | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index c45dbe8a7dcd7..9b75abdd4478a 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -3410,6 +3410,8 @@ static const struct pci_device_id nvme_id_table[] =
=3D {
>  	{ PCI_VDEVICE(INTEL, 0x5845),	/* Qemu emulated controller */
>  		.driver_data =3D NVME_QUIRK_IDENTIFY_CNS |
>  				NVME_QUIRK_DISABLE_WRITE_ZEROES, },
> +	{ PCI_VDEVICE(REDHAT, 0x0010),	/* Qemu emulated controller */
> +		.driver_data =3D NVME_QUIRK_BOGUS_NID, },
>  	{ PCI_DEVICE(0x126f, 0x2263),	/* Silicon Motion unidentified */
>  		.driver_data =3D NVME_QUIRK_NO_NS_DESC_LIST, },
>  	{ PCI_DEVICE(0x1bb1, 0x0100),   /* Seagate Nytro Flash Storage */
> --=20
> 2.30.2
>=20
> =

