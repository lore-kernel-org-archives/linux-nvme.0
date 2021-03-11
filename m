Return-Path: <SRS0=tknV=IJ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67240C433E0
	for <linux-nvme@archiver.kernel.org>; Thu, 11 Mar 2021 05:15:12 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C7D3664FC9
	for <linux-nvme@archiver.kernel.org>; Thu, 11 Mar 2021 05:15:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7D3664FC9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:CC:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=L8OTfxgSVstG93Js1TapOK/XLsO2SDZ77pcC573PxYM=; b=QiRkJccA6MQM+ogTn/8prAjWO
	oDHjXEO8/2cxXhB3SCFS6rOu/pzVSSO0X6AH//imCvuF7d1DNSFauz7CAmPyNS/Emq49zepUrc3fJ
	gpjC0VypP8jmf+k3ZpUjyej5v1RvOlNr3sVmnGrj2zEzSLvfumkWAtF+xHVaRhAJ7hdfDVblkdcOX
	p8nut7bVgAOWYSgE1vUahz0SV59choJGkXgRQmF2kmWJvHBdHHevQqaL9Bw4gOlMuARWc7BVTuunx
	L9MWvACEppObvLCxgz77v9UpxcKx1xgnc5praAjuUemc/pjns1Q0teZjHMz4re0SlKjNAmw+zlhEa
	Cj4B7pOvw==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lKDf4-008OAh-PB; Thu, 11 Mar 2021 05:15:02 +0000
Received: from esa3.hgst.iphmx.com ([216.71.153.141])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lKDey-008O9u-FA
 for linux-nvme@lists.infradead.org; Thu, 11 Mar 2021 05:14:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1615439696; x=1646975696;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=FR6OSwZcs++TPYXiB6raToiyl3WmbMtAuDlpoUOLe/Y=;
 b=GHoTBaVrGwxRNw5wlm673zV2pvmgVtWkZ2JzK6b0ZrL5VvFS+22vchuq
 R0eIAcpg60r5F0IACUrI7YX6Hyl0Cf8YMYD1ZXFnSmF2W2hg14sM5+kQj
 tVw2Kyk4rK4QAeN5oHdaGe+P5MO7hyvqJceubEHVFSo2on8J16ypoGzeO
 OqE9SjoL9Jjt0AQ5X52gp+dckz14fBxDBSOUUJtLERbN6RoKuuyPKplf8
 0A8Cm5aAwvlJBgAqZdCu78qnpoZmpcMELrzlbsz5aCQyjlZRX4e4L/hA5
 lKYbRgx7wTlspSOxh/LyJpQvbeKJKpS2HV/e9Igq1PD7x1181N4sgvn7l Q==;
IronPort-SDR: uXjYB1U2I9ZkBV0qdL5mvv4wLHAlQLI7w9nvfECurNyVXMNWQzRapn6/h/APdk5JdX1SHsUbvW
 u57hmDrDe9IFb1BjSRT6Pq4r1WPcIvPEMbY8vLFulWXLOpEsjQq5wPrwdWHDkaV83USU/99EmP
 rkqEeuont9h6tk/JcIrpbWClZqkphzlpny6m30JAPm2304L8vRHDgTtIW1jWtUOfK/FT7o89z3
 QSw+DDF/uorWJtGkQ45LCJB5lOKRuFOZsqprz8imyswn9uk5bH4Ep7KnHe1nSmhGjasOlj5aMT
 b1o=
X-IronPort-AV: E=Sophos;i="5.81,239,1610380800"; d="scan'208";a="166381104"
Received: from mail-bn8nam11lp2175.outbound.protection.outlook.com (HELO
 NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.175])
 by ob1.hgst.iphmx.com with ESMTP; 11 Mar 2021 13:14:54 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QaorayAH8ZT7BdbDJREnTOmbj1rs6tiWl5kTah7tJ+KQ6pVbCVQvx9EW5g1cGg9lojIf8HDdhBmA2VqB+JksgHhryQ2fiRqzvhCq4PbYxLAuCheNSfH+HlH99TkFYV70FNy58h5LdNPv1q+Ydk9FrXyRXYhy8OUhWTSQD0gRojN+9m7FVr/p/PXttKEyboaMfO+GaTcx03gxx/NXh7hwgr6+qQKwebmrYrCutXzlRGY8mYsd2OfNbBtyOuH8YJtlFBdrm+Svpare6XaVbomPzcjbcjNtURkdPTaNxwNOHz4L1ZU2FjqSIXYiVPtxMRQ8xFth4rfM4uCiaJWTGrU9hA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aSZSW5rEsCZdX6H+EvwarNwltvJzwXT7Kk109H8xMBQ=;
 b=dLMVRPRAUlLBo6GXIBpquv2go4WZwt/U93vN+0jAwABFzITsJKF6HfV7Y9+6t8BTKhhJxAUF1VAVOn/fS21LDzQLdVkgIoJJ80OsVQpTTYD18eybLXUQQE7MGOI+TsdsaxO+aoY+MbTRMx+9AhG046nGsBGczEJBqDF8yEikMyzGTjoUJdJRYXIJ99VtJwcjtoX44YF9h6hm+WlyWGmM+9ZJuRFdoUyGyvvsWETb3+vJRnEx/W03SUJXjcTReC5swQTbhxGL8EgnxyS+jYgsqg5OSx2cz5eXjSsHgER9WtZx56vGVj1hZ9HL0ZmGfK5LFikHxRVc6W0t3kc0v1Hkwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aSZSW5rEsCZdX6H+EvwarNwltvJzwXT7Kk109H8xMBQ=;
 b=I/FvBHgIiAUpLpqLLX+E8ccBndLNjxshdS7mCpeRJcv38JUq8kdymoiEGedAD79I4x97MbFgZ1u0QItkrGTPN4+PoY5nRI+06GHuci5sgP05nKDuAfomiXtbW+wB36o8iGPBOu26uu0iYR/vuIr5wVMLbgj057odpObf5yfW3mA=
Received: from BL0PR04MB6514.namprd04.prod.outlook.com (2603:10b6:208:1ca::23)
 by MN2PR04MB6349.namprd04.prod.outlook.com (2603:10b6:208:1ad::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17; Thu, 11 Mar
 2021 05:14:52 +0000
Received: from BL0PR04MB6514.namprd04.prod.outlook.com
 ([fe80::e9c5:588:89e:6887]) by BL0PR04MB6514.namprd04.prod.outlook.com
 ([fe80::e9c5:588:89e:6887%3]) with mapi id 15.20.3912.026; Thu, 11 Mar 2021
 05:14:52 +0000
From: Damien Le Moal <Damien.LeMoal@wdc.com>
To: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
CC: "hch@lst.de" <hch@lst.de>, "kbusch@kernel.org" <kbusch@kernel.org>,
 "sagi@grimberg.me" <sagi@grimberg.me>
Subject: Re: [PATCH V11 2/4] nvmet: add ZBD over ZNS backend support
Thread-Topic: [PATCH V11 2/4] nvmet: add ZBD over ZNS backend support
Thread-Index: AQHXFjCN2624kbFnR0OBSVFjgPrDaA==
Date: Thu, 11 Mar 2021 05:14:52 +0000
Message-ID: <BL0PR04MB6514B376CCD4EE404050E1D1E7909@BL0PR04MB6514.namprd04.prod.outlook.com>
References: <20210311043908.26146-1-chaitanya.kulkarni@wdc.com>
 <20210311043908.26146-3-chaitanya.kulkarni@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2400:2411:43c0:6000:c1a6:aaec:6201:ec23]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d0d206f9-3429-40a4-ce32-08d8e44c99d2
x-ms-traffictypediagnostic: MN2PR04MB6349:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR04MB6349A00016AD3C299AF9498EE7909@MN2PR04MB6349.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cDNvXO/aieWWUqRfMUipLVvN0+OTvIUpZrOo75snPrioHL9plAjCRXJzBUWRhJ3fXAoxdInK8YWoM9a3gjw8WKgOp6ckwofgKRodUM/aFdUQyzGxfN9Sqj5MkgYg7vigR9fT9aBmIWsjUSLDpN3lJAu3deGVGmg/HMS76w9XWBQNVlfqvnQf1LFpXUXnXnc59efFjcCaV8sJchY69LPqJymMi8va+Ni9wbAaSiMDa3jFCAs0sxzF7hdr9qUuHUOh6XYSWKiZF8mQQWGTANr8TetZrjN8WPvir6/vtSuTmad5JyLHPoD79WgABgUv1bHo/vldXOZvbskvjTSb0834YWwyR4JgOAUoUwVgBuFT6qRvzYNYuDn/zxrcLpcRXFHkRhQoF9lUgGBhKuuV82vnX2Hje/2gfRPMWauZ+uvo5V9laeSE4YGkptXG0n94N8t+7tZsG+2KQSuAsWebgyAYk0ij9iKK0w/OPYey9otJHwMXdC9w85WaQu/776lmZfyouq39cCHYdK+0A505RXYSEQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR04MB6514.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(346002)(39860400002)(136003)(396003)(376002)(8676002)(66446008)(33656002)(66556008)(66476007)(186003)(2906002)(64756008)(316002)(6506007)(53546011)(76116006)(5660300002)(66946007)(52536014)(110136005)(54906003)(86362001)(83380400001)(91956017)(30864003)(8936002)(55016002)(478600001)(9686003)(4326008)(7696005)(71200400001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: =?Windows-1252?Q?YQXNaJBdzZwKLYdL5YI+FnaqDcvDx+e+6TG6A0WQSdOSQ7CR/sjXUqEK?=
 =?Windows-1252?Q?xv9ZxBG2kq62+zdmd94ctiv5La759uTeX/95Mh9oAbCTArKE14Fj3TdF?=
 =?Windows-1252?Q?iBIsX3eckpUGKEOnhUQcRC/sZvfEKk62tMIVT9D5a2BumndfUetV5F5n?=
 =?Windows-1252?Q?SWZBjP4F+lcAhUVf9PoUOOy6Dez2Y0WOJn5l9BtAZorw1o/tZeI59MKB?=
 =?Windows-1252?Q?IkYW2tL3ZfYXwJ3H4gVdW2WQ1OwRGoAVxcEiE/eb5KVX1UvLpmHrPJcG?=
 =?Windows-1252?Q?L33PEq668tgQk5whmXQD21/sXMVUyV7bfZ0L/NSn15pEgiiNDXMli77f?=
 =?Windows-1252?Q?L7jrE/jGrjd6kR9/wCidT94dsCGzR1lY5SPxe1jJ36C2yZMefFLl7wr4?=
 =?Windows-1252?Q?G9OIYpzeEhTgid7S0deVljXmTaGCHpjSzqwydjxRRStZQt9fm+1ExRyp?=
 =?Windows-1252?Q?50VD1LYgkvtgudQNQXWJdwTELFXZlmy5R+yMHfLEl2H1LKHKUWMNnO1f?=
 =?Windows-1252?Q?u3lXxBU7FxynbIwHMSS5TywxGUt5czgWt3L70vwMuZiObGl0W8/qN4Wn?=
 =?Windows-1252?Q?IveEgNQO+2usjSMY1274wsbVyITHLSCYymzId92a75XmVwKgpEtKNTk9?=
 =?Windows-1252?Q?kxjoBH9nLPMl8Od0GDDHsZatXwdR7AhRyetQg6uba2FFUEvNYhM2Cq2d?=
 =?Windows-1252?Q?C7Nh5n/EOHS4OOM1NndLMqxTtNZ/H/57MggFA4nnOeXQMGDCKMW2+5SB?=
 =?Windows-1252?Q?xzIiWsJ9QMqes3OiZAJk3NJo+m4LCs9Hs5pKzz6XnysRNBL76Klri2Pc?=
 =?Windows-1252?Q?AG+ttYoxKUJSoHByWVlKMhmXbBUSyqjfDAhXBtThDlmrf17YLzgpiwKt?=
 =?Windows-1252?Q?bGM8GGUP1DnoL7VlB6hAD1CQi+Bwlkv2a8SfkLO9A+pVlPJcQz9vQ5EJ?=
 =?Windows-1252?Q?e8xxMU/TrfXbq7Qz0JFl6MH/VWYEOlsqXeXL6KSN26UBE739CMu5JVqF?=
 =?Windows-1252?Q?VspD9caNMBhoXgRgeLn8ekuv0wGJyhs4lM+kx2vMXdqZ82xzguG6bdqH?=
 =?Windows-1252?Q?jW3Rgyo4V/61u4eF3Wtjf2XGrvUgr/piQp0gbTamiEIj2DKg+1/ZS98Y?=
 =?Windows-1252?Q?sk8iKa4YE/J775sAKPtUShkRtQ579FS8wAXJSkkEiF6+CW5fQe2DViV5?=
 =?Windows-1252?Q?Wp+PS7jf1oEhLCFRmIRTACcAwy6qK5u9BPq9kBR7Srs3/blbMR0kaCUx?=
 =?Windows-1252?Q?0vag8WtJZJQArDonzS64tl2JWrV9y1EEaicoiRzMK1gOnbB/7aYs6hXP?=
 =?Windows-1252?Q?nDZh9OlHz0tncvg919vDeKjf9xLAmZxXqEHCs5Ec/0XY6QOzvVIQD3S0?=
 =?Windows-1252?Q?P6qTBtaVqXRusfNrlWIdIiMKi43JMA+lZqrXga0X90Qe8lo+aSvsWvRs?=
 =?Windows-1252?Q?6Ac6VuuNhoY/T5tPnG8ibSB0/H0Ak8Tb5RVi9USpiRHJXjtkdhprQe4k?=
 =?Windows-1252?Q?396Pa2HIxZK32/DR4dJ7KpCcfHjvCw=3D=3D?=
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR04MB6514.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0d206f9-3429-40a4-ce32-08d8e44c99d2
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2021 05:14:52.0967 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hv4OcqvkvnVZNunVPnqFMXQSS7vy92gE1cTRTrpkSXhyznU8JAM0rFN214T5qtfN1LM5ZUPtmvTlhecI3x6frA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB6349
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210311_051457_210230_A46B73CD 
X-CRM114-Status: GOOD (  22.24  )
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
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 2021/03/11 13:39, Chaitanya Kulkarni wrote:
> NVMe TP 4053 =96 Zoned Namespaces (ZNS) allows host software to
> communicate with a non-volatile memory subsystem using zones for =

> NVMe protocol-based controllers. NVMeOF already support the ZNS NVMe
> Protocol compliant devices on the target in the passthru mode. There
> are Generic zoned block devices like =A0Shingled Magnetic Recording (SMR)
> HDDs that are not based on the NVMe protocol.
> =

> This patch adds ZNS backend to support the ZBDs for NVMeOF target.
> =

> This support includes implementing the new command set NVME_CSI_ZNS,
> adding different command handlers for ZNS command set such as
> NVMe Identify Controller, NVMe Identify Namespace, NVMe Zone Append,
> NVMe Zone Management Send and NVMe Zone Management Receive.
> =

> With the new command set identifier, we also update the target command
> effects logs to reflect the ZNS compliant commands.
> =

> Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
> ---
>  drivers/nvme/target/Makefile      |   1 +
>  drivers/nvme/target/admin-cmd.c   |  27 +++
>  drivers/nvme/target/io-cmd-bdev.c |  34 +++-
>  drivers/nvme/target/nvmet.h       |  38 ++++
>  drivers/nvme/target/zns.c         | 327 ++++++++++++++++++++++++++++++
>  5 files changed, 419 insertions(+), 8 deletions(-)
>  create mode 100644 drivers/nvme/target/zns.c
> =

> diff --git a/drivers/nvme/target/Makefile b/drivers/nvme/target/Makefile
> index ebf91fc4c72e..9837e580fa7e 100644
> --- a/drivers/nvme/target/Makefile
> +++ b/drivers/nvme/target/Makefile
> @@ -12,6 +12,7 @@ obj-$(CONFIG_NVME_TARGET_TCP)		+=3D nvmet-tcp.o
>  nvmet-y		+=3D core.o configfs.o admin-cmd.o fabrics-cmd.o \
>  			discovery.o io-cmd-file.o io-cmd-bdev.o
>  nvmet-$(CONFIG_NVME_TARGET_PASSTHRU)	+=3D passthru.o
> +nvmet-$(CONFIG_BLK_DEV_ZONED)		+=3D zns.o
>  nvme-loop-y	+=3D loop.o
>  nvmet-rdma-y	+=3D rdma.o
>  nvmet-fc-y	+=3D fc.o
> diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-=
cmd.c
> index 176c8593d341..bf4876df624a 100644
> --- a/drivers/nvme/target/admin-cmd.c
> +++ b/drivers/nvme/target/admin-cmd.c
> @@ -179,6 +179,13 @@ static void nvmet_set_csi_nvm_effects(struct nvme_ef=
fects_log *log)
>  	log->iocs[nvme_cmd_write_zeroes]	=3D cpu_to_le32(1 << 0);
>  }
>  =

> +static void nvmet_set_csi_zns_effects(struct nvme_effects_log *log)
> +{
> +	log->iocs[nvme_cmd_zone_append]		=3D cpu_to_le32(1 << 0);
> +	log->iocs[nvme_cmd_zone_mgmt_send]	=3D cpu_to_le32(1 << 0);
> +	log->iocs[nvme_cmd_zone_mgmt_recv]	=3D cpu_to_le32(1 << 0);
> +}
> +
>  static void nvmet_execute_get_log_cmd_effects_ns(struct nvmet_req *req)
>  {
>  	struct nvme_effects_log *log;
> @@ -194,6 +201,15 @@ static void nvmet_execute_get_log_cmd_effects_ns(str=
uct nvmet_req *req)
>  	case NVME_CSI_NVM:
>  		nvmet_set_csi_nvm_effects(log);
>  		break;
> +	case NVME_CSI_ZNS:
> +		if (!IS_ENABLED(CONFIG_BLK_DEV_ZONED)) {
> +			status =3D NVME_SC_INVALID_IO_CMD_SET;
> +			goto free;
> +		}
> +
> +		nvmet_set_csi_nvm_effects(log);
> +		nvmet_set_csi_zns_effects(log);
> +		break;
>  	default:
>  		status =3D NVME_SC_INVALID_LOG_PAGE;
>  		goto free;
> @@ -630,6 +646,13 @@ static u16 nvmet_execute_identify_desclist_csi(struc=
t nvmet_req *req, off_t *o)
>  {
>  	switch (req->ns->csi) {
>  	case NVME_CSI_NVM:
> +		return nvmet_copy_ns_identifier(req, NVME_NIDT_CSI,
> +						NVME_NIDT_CSI_LEN,
> +						&req->ns->csi, o);
> +	case NVME_CSI_ZNS:
> +		if (!IS_ENABLED(CONFIG_BLK_DEV_ZONED))
> +			return NVME_SC_INVALID_IO_CMD_SET;
> +
>  		return nvmet_copy_ns_identifier(req, NVME_NIDT_CSI,
>  						NVME_NIDT_CSI_LEN,
>  						&req->ns->csi, o);
> @@ -682,8 +705,12 @@ static void nvmet_execute_identify(struct nvmet_req =
*req)
>  	switch (req->cmd->identify.cns) {
>  	case NVME_ID_CNS_NS:
>  		return nvmet_execute_identify_ns(req);
> +	case NVME_ID_CNS_CS_NS:
> +		return nvmet_execute_identify_cns_cs_ns(req);
>  	case NVME_ID_CNS_CTRL:
>  		return nvmet_execute_identify_ctrl(req);
> +	case NVME_ID_CNS_CS_CTRL:
> +		return nvmet_execute_identify_cns_cs_ctrl(req);
>  	case NVME_ID_CNS_NS_ACTIVE_LIST:
>  		return nvmet_execute_identify_nslist(req);
>  	case NVME_ID_CNS_NS_DESC_LIST:
> diff --git a/drivers/nvme/target/io-cmd-bdev.c b/drivers/nvme/target/io-c=
md-bdev.c
> index 9a8b3726a37c..ada0215f5e56 100644
> --- a/drivers/nvme/target/io-cmd-bdev.c
> +++ b/drivers/nvme/target/io-cmd-bdev.c
> @@ -63,6 +63,14 @@ static void nvmet_bdev_ns_enable_integrity(struct nvme=
t_ns *ns)
>  	}
>  }
>  =

> +void nvmet_bdev_ns_disable(struct nvmet_ns *ns)
> +{
> +	if (ns->bdev) {
> +		blkdev_put(ns->bdev, FMODE_WRITE | FMODE_READ);
> +		ns->bdev =3D NULL;
> +	}
> +}
> +
>  int nvmet_bdev_ns_enable(struct nvmet_ns *ns)
>  {
>  	int ret;
> @@ -86,15 +94,16 @@ int nvmet_bdev_ns_enable(struct nvmet_ns *ns)
>  	if (IS_ENABLED(CONFIG_BLK_DEV_INTEGRITY_T10))
>  		nvmet_bdev_ns_enable_integrity(ns);
>  =

> -	return 0;
> -}
> -
> -void nvmet_bdev_ns_disable(struct nvmet_ns *ns)
> -{
> -	if (ns->bdev) {
> -		blkdev_put(ns->bdev, FMODE_WRITE | FMODE_READ);
> -		ns->bdev =3D NULL;
> +	/* bdev_is_zoned() is stubbed out of CONFIG_BLK_DEV_ZONED */
> +	if (bdev_is_zoned(ns->bdev)) {
> +		if (!nvmet_bdev_zns_enable(ns)) {
> +			nvmet_bdev_ns_disable(ns);
> +			return -EINVAL;
> +		}
> +		ns->csi =3D NVME_CSI_ZNS;
>  	}
> +
> +	return 0;
>  }
>  =

>  void nvmet_bdev_ns_revalidate(struct nvmet_ns *ns)
> @@ -448,6 +457,15 @@ u16 nvmet_bdev_parse_io_cmd(struct nvmet_req *req)
>  	case nvme_cmd_write_zeroes:
>  		req->execute =3D nvmet_bdev_execute_write_zeroes;
>  		return 0;
> +	case nvme_cmd_zone_append:
> +		req->execute =3D nvmet_bdev_execute_zone_append;
> +		return 0;
> +	case nvme_cmd_zone_mgmt_recv:
> +		req->execute =3D nvmet_bdev_execute_zone_mgmt_recv;
> +		return 0;
> +	case nvme_cmd_zone_mgmt_send:
> +		req->execute =3D nvmet_bdev_execute_zone_mgmt_send;
> +		return 0;
>  	default:
>  		return nvmet_report_invalid_opcode(req);
>  	}
> diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
> index ee5999920155..f3fccc49de03 100644
> --- a/drivers/nvme/target/nvmet.h
> +++ b/drivers/nvme/target/nvmet.h
> @@ -247,6 +247,10 @@ struct nvmet_subsys {
>  	unsigned int		admin_timeout;
>  	unsigned int		io_timeout;
>  #endif /* CONFIG_NVME_TARGET_PASSTHRU */
> +
> +#ifdef CONFIG_BLK_DEV_ZONED
> +	u8			zasl;
> +#endif /* CONFIG_BLK_DEV_ZONED */
>  };
>  =

>  static inline struct nvmet_subsys *to_subsys(struct config_item *item)
> @@ -584,6 +588,40 @@ static inline struct nvme_ctrl *nvmet_passthru_ctrl(=
struct nvmet_subsys *subsys)
>  }
>  #endif /* CONFIG_NVME_TARGET_PASSTHRU */
>  =

> +#ifdef CONFIG_BLK_DEV_ZONED
> +bool nvmet_bdev_zns_enable(struct nvmet_ns *ns);
> +void nvmet_execute_identify_cns_cs_ctrl(struct nvmet_req *req);
> +void nvmet_execute_identify_cns_cs_ns(struct nvmet_req *req);
> +void nvmet_bdev_execute_zone_mgmt_recv(struct nvmet_req *req);
> +void nvmet_bdev_execute_zone_mgmt_send(struct nvmet_req *req);
> +void nvmet_bdev_execute_zone_append(struct nvmet_req *req);
> +#else  /* CONFIG_BLK_DEV_ZONED */
> +static inline bool nvmet_bdev_zns_enable(struct nvmet_ns *ns)
> +{
> +	return false;
> +}
> +static inline void
> +nvmet_execute_identify_cns_cs_ctrl(struct nvmet_req *req)
> +{
> +}
> +static inline void
> +nvmet_execute_identify_cns_cs_ns(struct nvmet_req *req)
> +{
> +}
> +static inline void
> +nvmet_bdev_execute_zone_mgmt_recv(struct nvmet_req *req)
> +{
> +}
> +static inline void
> +nvmet_bdev_execute_zone_mgmt_send(struct nvmet_req *req)
> +{
> +}
> +static inline void
> +nvmet_bdev_execute_zone_append(struct nvmet_req *req)
> +{
> +}
> +#endif /* CONFIG_BLK_DEV_ZONED */
> +
>  static inline struct nvme_ctrl *
>  nvmet_req_passthru_ctrl(struct nvmet_req *req)
>  {
> diff --git a/drivers/nvme/target/zns.c b/drivers/nvme/target/zns.c
> new file mode 100644
> index 000000000000..8121b29df766
> --- /dev/null
> +++ b/drivers/nvme/target/zns.c
> @@ -0,0 +1,327 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * NVMe ZNS-ZBD command implementation.
> + * Copyright (c) 2020-2021 HGST, a Western Digital Company.
> + */
> +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> +#include <linux/nvme.h>
> +#include <linux/blkdev.h>
> +#include "nvmet.h"
> +
> +/*
> + * We set the Memory Page Size Minimum (MPSMIN) for target controller to=
 0
> + * which gets added by 12 in the nvme_enable_ctrl() which results in 2^1=
2 =3D 4k
> + * as page_shift value. When calculating the ZASL use shift by 12.
> + */
> +#define NVMET_MPSMIN_SHIFT	12
> +
> +static u16 nvmet_bdev_zns_checks(struct nvmet_req *req)
> +{
> +	if (!bdev_is_zoned(req->ns->bdev))
> +		return NVME_SC_INVALID_NS | NVME_SC_DNR;
> +
> +	if (req->cmd->zmr.zra !=3D NVME_ZRA_ZONE_REPORT) {
> +		req->error_loc =3D offsetof(struct nvme_zone_mgmt_recv_cmd, zra);
> +		return NVME_SC_INVALID_FIELD | NVME_SC_DNR;
> +	}
> +
> +	if (req->cmd->zmr.zrasf !=3D NVME_ZRASF_ZONE_REPORT_ALL) {
> +		req->error_loc =3D
> +			offsetof(struct nvme_zone_mgmt_recv_cmd, zrasf);
> +		return NVME_SC_INVALID_FIELD | NVME_SC_DNR;
> +	}
> +
> +	if (req->cmd->zmr.pr !=3D NVME_REPORT_ZONE_PARTIAL) {
> +		req->error_loc =3D offsetof(struct nvme_zone_mgmt_recv_cmd, pr);
> +		return NVME_SC_INVALID_FIELD | NVME_SC_DNR;
> +	}
> +
> +	return NVME_SC_SUCCESS;
> +}
> +
> +static inline u8 nvmet_zasl(unsigned int zone_append_sects)
> +{
> +	/*
> +	 * Zone Append Size Limit is the value experessed in the units
> +	 * of minimum memory page size (i.e. 12) and is reported power of 2.
> +	 */
> +	return ilog2((zone_append_sects << 9) >> NVMET_MPSMIN_SHIFT);
> +}
> +
> +static inline bool nvmet_zns_update_zasl(struct nvmet_ns *ns)
> +{
> +	struct request_queue *q =3D ns->bdev->bd_disk->queue;
> +	u8 zasl =3D nvmet_zasl(queue_max_zone_append_sectors(q));
> +
> +	if (ns->subsys->zasl)
> +		return ns->subsys->zasl < zasl;
> +
> +	ns->subsys->zasl =3D zasl;
> +	return true;
> +}
> +
> +static int nvmet_bdev_validate_zns_zones_cb(struct blk_zone *z,
> +					    unsigned int i, void *data)
> +{
> +	if (z->type =3D=3D BLK_ZONE_TYPE_CONVENTIONAL)
> +		return -EOPNOTSUPP;
> +	return 0;
> +}
> +
> +static bool nvmet_bdev_has_conv_zones(struct block_device *bdev)
> +{
> +	int ret;
> +
> +	if (bdev->bd_disk->queue->conv_zones_bitmap)
> +		return true;
> +
> +	ret =3D blkdev_report_zones(bdev, 0, blkdev_nr_zones(bdev->bd_disk),
> +				  nvmet_bdev_validate_zns_zones_cb, NULL);
> +
> +	return ret <=3D 0 ? true : false;
> +}
> +
> +bool nvmet_bdev_zns_enable(struct nvmet_ns *ns)
> +{
> +	if (nvmet_bdev_has_conv_zones(ns->bdev))
> +		return false;
> +
> +	ns->blksize_shift =3D blksize_bits(bdev_physical_block_size(ns->bdev));

Shouldn't this be using logical block size ? Otherwise, zsze calculation in
nvmet_execute_identify_cns_cs_ns() could be wrong.

> +
> +	if (!nvmet_zns_update_zasl(ns))
> +		return false;
> +
> +	return !(get_capacity(ns->bdev->bd_disk) &
> +			(bdev_zone_sectors(ns->bdev) - 1));
> +}
> +
> +void nvmet_execute_identify_cns_cs_ctrl(struct nvmet_req *req)
> +{
> +	u8 zasl =3D req->sq->ctrl->subsys->zasl;
> +	struct nvmet_ctrl *ctrl =3D req->sq->ctrl;
> +	struct nvme_id_ctrl_zns *id;
> +	u16 status;
> +
> +	if (req->cmd->identify.csi !=3D NVME_CSI_ZNS) {
> +		req->error_loc =3D offsetof(struct nvme_common_command, opcode);
> +		status =3D NVME_SC_INVALID_OPCODE | NVME_SC_DNR;
> +		goto out;
> +	}
> +
> +	id =3D kzalloc(sizeof(*id), GFP_KERNEL);
> +	if (!id) {
> +		status =3D NVME_SC_INTERNAL;
> +		goto out;
> +	}
> +
> +	if (ctrl->ops->get_mdts)
> +		id->zasl =3D min_t(u8, ctrl->ops->get_mdts(ctrl), zasl);
> +	else
> +		id->zasl =3D zasl;
> +
> +	status =3D nvmet_copy_to_sgl(req, 0, id, sizeof(*id));
> +
> +	kfree(id);
> +out:
> +	nvmet_req_complete(req, status);
> +}
> +
> +void nvmet_execute_identify_cns_cs_ns(struct nvmet_req *req)
> +{
> +	struct nvme_id_ns_zns *id_zns;
> +	u64 zsze;
> +	u16 status;
> +
> +	if (req->cmd->identify.csi !=3D NVME_CSI_ZNS) {
> +		req->error_loc =3D offsetof(struct nvme_common_command, opcode);
> +		status =3D NVME_SC_INVALID_OPCODE | NVME_SC_DNR;
> +		goto out;
> +	}
> +
> +	if (le32_to_cpu(req->cmd->identify.nsid) =3D=3D NVME_NSID_ALL) {
> +		req->error_loc =3D offsetof(struct nvme_identify, nsid);
> +		status =3D NVME_SC_INVALID_NS | NVME_SC_DNR;
> +		goto out;
> +	}
> +
> +	id_zns =3D kzalloc(sizeof(*id_zns), GFP_KERNEL);
> +	if (!id_zns) {
> +		status =3D NVME_SC_INTERNAL;
> +		goto out;
> +	}
> +
> +	status =3D nvmet_req_find_ns(req);
> +	if (status) {
> +		status =3D NVME_SC_INTERNAL;
> +		goto done;
> +	}
> +
> +	if (!bdev_is_zoned(req->ns->bdev)) {
> +		req->error_loc =3D offsetof(struct nvme_identify, nsid);
> +		status =3D NVME_SC_INVALID_NS | NVME_SC_DNR;
> +		goto done;
> +	}
> +
> +	nvmet_ns_revalidate(req->ns);
> +	zsze =3D (bdev_zone_sectors(req->ns->bdev) << 9) >>
> +					req->ns->blksize_shift;
> +	id_zns->lbafe[0].zsze =3D cpu_to_le64(zsze);
> +	id_zns->mor =3D cpu_to_le32(bdev_max_open_zones(req->ns->bdev));
> +	id_zns->mar =3D cpu_to_le32(bdev_max_active_zones(req->ns->bdev));
> +
> +done:
> +	status =3D nvmet_copy_to_sgl(req, 0, id_zns, sizeof(*id_zns));
> +	kfree(id_zns);
> +out:
> +	nvmet_req_complete(req, status);
> +}
> +
> +struct nvmet_report_zone_data {
> +	struct nvmet_ns *ns;
> +	struct nvme_zone_report *rz;
> +};
> +
> +static int nvmet_bdev_report_zone_cb(struct blk_zone *z, unsigned i, voi=
d *d)
> +{
> +	struct nvmet_report_zone_data *report_zone_data =3D d;
> +	struct nvme_zone_descriptor *entries =3D report_zone_data->rz->entries;
> +	struct nvmet_ns *ns =3D report_zone_data->ns;
> +
> +	entries[i].zcap =3D nvmet_sect_to_lba(ns, z->capacity);
> +	entries[i].zslba =3D nvmet_sect_to_lba(ns, z->start);
> +	entries[i].wp =3D nvmet_sect_to_lba(ns, z->wp);
> +	entries[i].za =3D z->reset ? 1 << 2 : 0;
> +	entries[i].zt =3D z->type;
> +	entries[i].zs =3D z->cond << 4;
> +
> +	return 0;
> +}
> +
> +void nvmet_bdev_execute_zone_mgmt_recv(struct nvmet_req *req)
> +{
> +	sector_t sect =3D nvmet_lba_to_sect(req->ns, req->cmd->zmr.slba);
> +	u32 bufsize =3D (le32_to_cpu(req->cmd->zmr.numd) + 1) << 2;
> +	struct nvmet_report_zone_data data =3D { .ns =3D req->ns };
> +	unsigned int nr_zones;
> +	int reported_zones;
> +	u16 status;
> +
> +	status =3D nvmet_bdev_zns_checks(req);
> +	if (status)
> +		goto out;
> +
> +	data.rz =3D __vmalloc(bufsize, GFP_KERNEL | __GFP_NORETRY | __GFP_ZERO);
> +	if (!data.rz) {
> +		status =3D NVME_SC_INTERNAL;
> +		goto out;
> +	}
> +
> +	nr_zones =3D (bufsize - sizeof(struct nvme_zone_report)) /
> +			sizeof(struct nvme_zone_descriptor);

What if nr_zones is 0 ? This should be failed.

> +	reported_zones =3D blkdev_report_zones(req->ns->bdev, sect, nr_zones,
> +					     nvmet_bdev_report_zone_cb, &data);
> +	if (reported_zones < 0) {
> +		status =3D NVME_SC_INTERNAL;
> +		goto out_free_report_zones;
> +	}
> +
> +	data.rz->nr_zones =3D cpu_to_le64(reported_zones);
> +
> +	status =3D nvmet_copy_to_sgl(req, 0, data.rz, bufsize);
> +
> +out_free_report_zones:
> +	kvfree(data.rz);
> +out:
> +	nvmet_req_complete(req, status);
> +}
> +
> +void nvmet_bdev_execute_zone_mgmt_send(struct nvmet_req *req)
> +{
> +	sector_t sect =3D nvmet_lba_to_sect(req->ns, req->cmd->zms.slba);
> +	sector_t nr_sect =3D bdev_zone_sectors(req->ns->bdev);
> +	u16 status =3D NVME_SC_SUCCESS;
> +	u8 zsa =3D req->cmd->zms.zsa;
> +	enum req_opf op;
> +	int ret;
> +	const unsigned int zsa_to_op[] =3D {
> +		[NVME_ZONE_OPEN]	=3D REQ_OP_ZONE_OPEN,
> +		[NVME_ZONE_CLOSE]	=3D REQ_OP_ZONE_CLOSE,
> +		[NVME_ZONE_FINISH]	=3D REQ_OP_ZONE_FINISH,
> +		[NVME_ZONE_RESET]	=3D REQ_OP_ZONE_RESET,
> +	};
> +
> +	if (zsa > ARRAY_SIZE(zsa_to_op) || !zsa_to_op[zsa]) {
> +		status =3D NVME_SC_INVALID_FIELD;
> +		goto out;
> +	}
> +
> +	op =3D zsa_to_op[zsa];
> +
> +	if (req->cmd->zms.select_all)
> +		nr_sect =3D get_capacity(req->ns->bdev->bd_disk);
> +
> +	ret =3D blkdev_zone_mgmt(req->ns->bdev, op, sect, nr_sect, GFP_KERNEL);
> +	if (ret)
> +		status =3D NVME_SC_INTERNAL;
> +out:
> +	nvmet_req_complete(req, status);
> +}
> +
> +void nvmet_bdev_execute_zone_append(struct nvmet_req *req)
> +{
> +	sector_t sect =3D nvmet_lba_to_sect(req->ns, req->cmd->rw.slba);
> +	u16 status =3D NVME_SC_SUCCESS;
> +	unsigned int total_len =3D 0;
> +	struct scatterlist *sg;
> +	int ret =3D 0, sg_cnt;
> +	struct bio *bio;
> +
> +	if (!nvmet_check_transfer_len(req, nvmet_rw_data_len(req)))
> +		return;
> +
> +	if (!req->sg_cnt) {
> +		nvmet_req_complete(req, 0);
> +		return;
> +	}
> +
> +	if (req->transfer_len <=3D NVMET_MAX_INLINE_DATA_LEN) {
> +		bio =3D &req->b.inline_bio;
> +		bio_init(bio, req->inline_bvec, ARRAY_SIZE(req->inline_bvec));
> +	} else {
> +		bio =3D bio_alloc(GFP_KERNEL, req->sg_cnt);
> +	}
> +
> +	bio_set_dev(bio, req->ns->bdev);
> +	bio->bi_iter.bi_sector =3D sect;
> +	bio->bi_opf =3D REQ_OP_ZONE_APPEND | REQ_SYNC | REQ_IDLE;
> +	if (req->cmd->rw.control & cpu_to_le16(NVME_RW_FUA))
> +		bio->bi_opf |=3D REQ_FUA;
> +
> +	for_each_sg(req->sg, sg, req->sg_cnt, sg_cnt) {
> +		struct page *p =3D sg_page(sg);
> +		unsigned int l =3D sg->length;
> +		unsigned int o =3D sg->offset;
> +
> +		ret =3D bio_add_zone_append_page(bio, p, l, o);
> +		if (ret !=3D sg->length) {
> +			status =3D NVME_SC_INTERNAL;
> +			goto out_bio_put;
> +		}
> +
> +		total_len +=3D sg->length;
> +	}
> +
> +	if (total_len !=3D nvmet_rw_data_len(req)) {
> +		status =3D NVME_SC_INTERNAL | NVME_SC_DNR;
> +		goto out_bio_put;
> +	}
> +
> +	ret =3D submit_bio_wait(bio);
> +	req->cqe->result.u64 =3D nvmet_sect_to_lba(req->ns,
> +						 bio->bi_iter.bi_sector);
> +
> +out_bio_put:
> +	if (bio !=3D &req->b.inline_bio)
> +		bio_put(bio);
> +	nvmet_req_complete(req, ret < 0 ? NVME_SC_INTERNAL : status);
> +}
> =



-- =

Damien Le Moal
Western Digital Research

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
