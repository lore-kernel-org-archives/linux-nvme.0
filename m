Return-Path: <SRS0=WFi/=JF=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 948ECC433B4
	for <linux-nvme@archiver.kernel.org>; Thu,  8 Apr 2021 08:01:44 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0254D6115B
	for <linux-nvme@archiver.kernel.org>; Thu,  8 Apr 2021 08:01:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0254D6115B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:CC:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=AZ0OSbDN7WETexWca2/W3Ynfko+y2rL6bg3Ox2lO8zc=; b=kpHBvOSFMMzrQPi8KTGEWXoO0
	zbfctQ4L8ko5HesONRtR7wMtHoDPvtBRfKzb34qpm/c1hsChjgpfOx95l/UVNwMV3gSf8QFO7cVCX
	KaMOmLdmybrZJi7UYmh3kuEGCKmQVKSfDaNPsTBo3b6jRsJ56Dy/ino06FFQfXV18A2tc/2iR9pFj
	cdG27+EqxJGuOx5ZQcYLtiVddcgehLT1bc6jSXwj+NLcpzWbpTxTUH4rhrOTHcWnCF9EJNOcUfCrN
	KdRV4Wja+sZIl9DfPvTnb2/SKaJ1bOmVtlkFKZyKmhi3pfT37j+u6bRMaYqcj7oJjEsoVsM+WP8p+
	7sr9u913g==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lUPbb-007IOy-OY; Thu, 08 Apr 2021 08:01:35 +0000
Received: from esa1.hgst.iphmx.com ([68.232.141.245])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lUPbU-007IMf-Nt
 for linux-nvme@lists.infradead.org; Thu, 08 Apr 2021 08:01:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1617868888; x=1649404888;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=Ruh/X8iQEDVmqzgkSl2Z68In6UNbD2kjoOgb3rjmbuw=;
 b=HisOC3ZdouW1HC3Ej9bKTv7oCScRJexUeO6w8RRsKUhkWEp7ThIVKOao
 B8NsmyfmnGmi88HVpmU+rfq3qFnZbmZtiIcu+WEWRiNGp388qA7GoEshb
 FV2DG28p2RqRcY9ovbhDmMtg+ICiDnfoE2l/q79S/SF0n1mduhHll8B9P
 rZHJOFZyDmGl9bqnf/ivOf+Xn9HSvzg3JsxnnA7Nr5mEkLvsPddVQLhQR
 Oqkrg5IDDaPLSss3daU9dHW8Qv/hy42jEWofnxI0hN6y126azeWW+pmLr
 QjySYJ1fduiSPgW9ZIRpeTtwYPm5LYsfN4U193f9vZTT1E9ae89u9qvwu g==;
IronPort-SDR: 6PgPDEki3WiVHm7mijcGU/Z5TOCv9cZHriCqYuxIS8ZMulc3DFT8Q5BTTlHuEEj1q6Iq7I6RHD
 GvyIqJKlZbC9lA+sZwFM9uLmRSxUaRayz870sjaoR9T6oRQiVrP/M+tukkPhtSXOh8pQRvX/A8
 oRLTgn9MOj0my+ZrvDe42dYZ4bZJbDCoT4oNe3yzB05B2BBbdp4xBmj0WBR2QgGBj4Ww0hptZ5
 6q/jsze2CDxrxhI0OeYDlpNt6E/aG2orLgGmGIoQaeuRD6KO9klVtft6SlTDCKpxfigmkwfZAX
 KZk=
X-IronPort-AV: E=Sophos;i="5.82,205,1613404800"; d="scan'208";a="275029477"
Received: from mail-bn8nam11lp2174.outbound.protection.outlook.com (HELO
 NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.174])
 by ob1.hgst.iphmx.com with ESMTP; 08 Apr 2021 16:01:22 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OKEHzrf1vB2D9pxZRZdytUOPmrxHq445bC1RMiQzgf1I5KFQKk8YlsCyMVwGhNxvb5mD3Ix41xjsVpuyoK6XUJFrK37aF+2J+sdZ09f41OoQp9e3NHzGecW2BHf3T39YDjQzDMerQ82kcrUdKNdooimAFNlGvDAx/NO9imIAvmGs/SzwgGSk92tTnS7tRAtL64Hb5rkftuB49MghUbYiYVAYdHo6uU/XwChIJCYi0kKrqUhTTM9+sUo8tzoR3Wa+vuFPTg1lLnz2GCzgj/jtKICwjTtKWEVRgBcXARAHjeLSrJnP4/sK7sNxZgtUJBUZ2FgX775H8Sf7DtNHFkZ0CQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M2LM89tpfBVrrLAvNCas2azKkJjEZHNRAHtenya6J7U=;
 b=GvSe5BIZUMRSr4z6+VkCBcp9nVdS9LlBgIwkR+fZEaB70MjAs+B/xnc2zenEpr8w1mL2APCOW8FPsxaZXaFAxsa6e0VFxog3bBTreo7dnZOJt/388DcpmTBxs7D32+kS+nuiplK192bwRq30do1F7Q58H2F4p1zRI3XTDq05bhrNrWiTXQo9KoaMafuERcne77odhisJ/yrZZW2Nm7qwFc+YloOIAd1SyCk6XxLf/VeT+i88Ibyl9LZ0aaw1Gxw26AamOOgCNHJHhQYvrqbfxEdPd5+8SnfvMk4vp5LyWBWtKGcrc1uyxZpmS/jqJBZNB1mI4fFPHYEtn6nQnvtQ+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M2LM89tpfBVrrLAvNCas2azKkJjEZHNRAHtenya6J7U=;
 b=SBj9MVO/JVdHtCcmUCUROuhd1HAl807YQ7bZ1YZp5QHMQMXQ90J54bEA98YP3UU6oJBCIcqSZ55zZJn6FmQIOZHkM9i6xft/WT9dwYUM501MkdMpUByBD1UZ6fTEwqqi5ZO/qNq4tER9i9nT8OmVbZgSDxBCYQbeqgmi5A2RXjs=
Received: from BL0PR04MB6514.namprd04.prod.outlook.com (2603:10b6:208:1ca::23)
 by BL0PR04MB5060.namprd04.prod.outlook.com (2603:10b6:208:5a::28)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.17; Thu, 8 Apr
 2021 08:01:20 +0000
Received: from BL0PR04MB6514.namprd04.prod.outlook.com
 ([fe80::e9c5:588:89e:6887]) by BL0PR04MB6514.namprd04.prod.outlook.com
 ([fe80::e9c5:588:89e:6887%3]) with mapi id 15.20.3999.032; Thu, 8 Apr 2021
 08:01:20 +0000
From: Damien Le Moal <Damien.LeMoal@wdc.com>
To: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
CC: "hch@lst.de" <hch@lst.de>
Subject: Re: [PATCH V13 2/4] nvmet: add ZBD over ZNS backend support
Thread-Topic: [PATCH V13 2/4] nvmet: add ZBD over ZNS backend support
Thread-Index: AQHXLAw0YQqn+n3DOkSGqRqPJyQbqA==
Date: Thu, 8 Apr 2021 08:01:20 +0000
Message-ID: <BL0PR04MB6514CAFA7FDA65E10B1DCE11E7749@BL0PR04MB6514.namprd04.prod.outlook.com>
References: <20210408001427.20501-1-chaitanya.kulkarni@wdc.com>
 <20210408001427.20501-3-chaitanya.kulkarni@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2400:2411:43c0:6000:5eb:da03:d474:9abc]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bc680472-5597-4402-010d-08d8fa647f1a
x-ms-traffictypediagnostic: BL0PR04MB5060:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BL0PR04MB50609218CC78C8FD0A504460E7749@BL0PR04MB5060.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5phH3bweOWjSGFN24M/74tLce44Tux+8DJHjs/wvS6MMheBkmM8jFfWfH1yIlYug8p/yNlMJxgV9LP03stvPhCdgj4O3HYgIt9yfaf7V0raDh1CPSZ0SzmlBUe1k9v2kvi5zfx4NXdbykflynNzdsfc+jPNfVuohtL1GCr4lPc7t9gBRIvmVVCzmSELTBlvOKx1YBpR1aHnWmQfON00s/DOsCyIXnYeAKkoFNqc5zI+oRDUCKO5RgBQZRK+mfSvaK6ckhqUvophmmVof3dXcOch//wf+86YOJApdEosQhaLMeSM6kzE7yZMoPcJgE/Vyo02Ztnj+A1gdl5RijSdoD+Ecvqc2/9+fqnGhFfW5TX8n6Zc9nc461hZL5vc615mf1Bhc8zK7t8WVTNUGokWl6p6Ghq6PL28M9W/kzr1z7bQcM1PGolkp244zcz9HKIFBfFW0gY9FBBc5Uu7onBRb8STpx2yBIH+9Kh87TiIasV2klV/fUMrlDC5ZnHFt8iMu7OcuAOTq9MNZFwz6rTFMXSMmq+Mr86b8idgceIBcCwH/8Y1dY146K+PNF2RcRovSxZtE6D1pRPTIJH30Lo0fu4oP5Ve9DcSh3RM/MRwb+jRTog63oUU71wj6pqUOAisw6Bv2J3+ADSMBCwOIn6Ti0xTYjsJX6B9IH0cJxyYqz6k=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR04MB6514.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(366004)(39860400002)(346002)(376002)(396003)(66446008)(186003)(66556008)(5660300002)(64756008)(66476007)(66946007)(30864003)(52536014)(76116006)(91956017)(110136005)(7696005)(53546011)(6506007)(316002)(33656002)(4326008)(83380400001)(8936002)(478600001)(8676002)(38100700001)(55016002)(9686003)(86362001)(2906002)(71200400001)(579004);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: =?Windows-1252?Q?Ex1KjIJsLNbCfQvIHNDJSx6ot4j3WjPA6JrJoXR+4s66IHKlP/Fg2+mu?=
 =?Windows-1252?Q?dcvv+fTISQDJI13Nj4Gdev7bMfJbmq/SWC7IU/FC50w8kFWIhS6vTEJP?=
 =?Windows-1252?Q?6uss6eu6Jd7hLPg4Sz2ALw3L7m4ZZneiMg9lPWtpacXpW1HPunJ/UWnM?=
 =?Windows-1252?Q?otikOnklH72kBo8I7xBXsPFrMzueDn8xAJeNLZp0jlny/xJ8SdIBQahU?=
 =?Windows-1252?Q?5Wx599rEhVa98gbd3QbPZws+hLw/tGb3MDo5tRHfs9QM3L1gEmA6gHOW?=
 =?Windows-1252?Q?d6dYOiU+J8K8ZXRgS1l+aLB0AxJ13+5HllxYxlqnfxBBt4+9XVZny5d8?=
 =?Windows-1252?Q?DzZjuunZWZatlAYap12YeVOnl3zgIMzoY+RqllZgFKmpKTCPe6SfZ8Wg?=
 =?Windows-1252?Q?kGJ2n8SSx63NT90dUT80l2xVfgptjGW1v95Mqmtce+hoj2h4sY/8XGdC?=
 =?Windows-1252?Q?R2hiGKTSC6kh2JY00j1suVEyUVMQJP9Q1VQ6PcZrSeBjtjCmS59VpC4L?=
 =?Windows-1252?Q?WjADLYGmEBgixJYIGX555aH9EaY06o3tLyRJxroQ1NFR9uAW6ebFvKi5?=
 =?Windows-1252?Q?bCMxQnIrk4OcQLLZW/KBE5BvXHP9epdTSncjbO/pC4m5qj+Dhet+gr83?=
 =?Windows-1252?Q?rjVy95Yk0o16lQ2nFzgHH54Uulo5MVv58q6pdbM7gYmUf1yayTjqTfId?=
 =?Windows-1252?Q?ElFt1xydaSF5PbcT0TcN8a3J7JTB0z8/KDwZ6nv58iLGNEzHjkqPgT+i?=
 =?Windows-1252?Q?4of0H9W7uQHypJh/NO55F8DMDIlByMvinAlIny7G/nxrkiYbN4GtuLwL?=
 =?Windows-1252?Q?243lqIXkGftc32ZKxn+Wcbs/AXwfwErbo3TV0F+V4tB/lktxuNoRFIwU?=
 =?Windows-1252?Q?d0os6N4zpAHrP/t+nueLLx11mCOBRCv65bLZVRD5DndozvNcV7jupTmo?=
 =?Windows-1252?Q?Mxb20OiCXip4aDWrUcFpMn7icky1xT3HZWPhgJKii9ASMuvWpZllXah9?=
 =?Windows-1252?Q?xODx1SaG3kjKMMDXI+XrheBQIZ7uIfX55sXp90/4AFT3Up9G1KUgDrNr?=
 =?Windows-1252?Q?EyVwlQ0gCdeXtu8pM/tv6PRfFHir5k5fKesbQDLiz01sMpL8aoVJefLS?=
 =?Windows-1252?Q?F0AUG3eaRrBjoyF5fWQrNkRtiejYbenSJZzVdxu/2q8Ac7MP17QnrcPQ?=
 =?Windows-1252?Q?cL3Pt8lCuueaOSJDjxnzyFGE30wnauxO/kA8/p8vzBqoXydDkylDWv7+?=
 =?Windows-1252?Q?WHw22fsxA7l6yCztoik9RVrt4BVCQ2F5N93NRTIGz2zz++Vw945fdio+?=
 =?Windows-1252?Q?rz+X2DZQNh8F7IAL4zemOlPaHsmB4IxUwa80kjKkn4fNpn0GPk2iWSWR?=
 =?Windows-1252?Q?vVu7w8UCd2PNZRnnEr8fWHgx6AFn73F8Rf/An2B5EdZzNYtKnzmaVHYj?=
 =?Windows-1252?Q?G8aRrjEH0AkHZDrdXprDRbDqgnmOf43ZstLIKR6otxyBV46Bvh5jA/HT?=
 =?Windows-1252?Q?gjOhWrQDU+pFuco8qWEKC0uvhvyK1g=3D=3D?=
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR04MB6514.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc680472-5597-4402-010d-08d8fa647f1a
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Apr 2021 08:01:20.7725 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KtpE0A2t/xk53HfatcMt8wjF/C5MxkKPURX19ifNGfCKz63PSz4iHQkDy2n1hejtZ/kQY1kfx5XcAJ+QegHQNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR04MB5060
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210408_090129_525679_AFFD068D 
X-CRM114-Status: GOOD (  20.74  )
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

On 2021/04/08 9:14, Chaitanya Kulkarni wrote:
> NVMe TP 4053 =96 Zoned Namespaces (ZNS) allows host software to
> communicate with a non-volatile memory subsystem using zones for NVMe
> protocol-based controllers. NVMeOF already support the ZNS NVMe
> Protocol compliant devices on the target in the passthru mode. There
> are Generic zoned block devices like  Shingled Magnetic Recording (SMR)
> HDDs that are not based on the NVMe protocol.
> =

> This patch adds ZNS backend to support the ZBDs for NVMeOF target.
> =

> This support includes implementing the new command set NVME_CSI_ZNS,
> adding different command handlers for ZNS command set such as NVMe
> Identify Controller, NVMe Identify Namespace, NVMe Zone Append,
> NVMe Zone Management Send and NVMe Zone Management Receive.
> =

> With the new command set identifier, we also update the target command
> effects logs to reflect the ZNS compliant commands.
> =

> Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
> ---
>  drivers/nvme/target/Makefile      |   1 +
>  drivers/nvme/target/admin-cmd.c   |  27 ++
>  drivers/nvme/target/io-cmd-bdev.c |  35 ++-
>  drivers/nvme/target/nvmet.h       |  47 +++
>  drivers/nvme/target/zns.c         | 477 ++++++++++++++++++++++++++++++
>  include/linux/nvme.h              |   7 +
>  6 files changed, 585 insertions(+), 9 deletions(-)
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
> index 9a8b3726a37c..1e54e7478735 100644
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
> @@ -86,15 +94,15 @@ int nvmet_bdev_ns_enable(struct nvmet_ns *ns)
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
> @@ -102,7 +110,7 @@ void nvmet_bdev_ns_revalidate(struct nvmet_ns *ns)
>  	ns->size =3D i_size_read(ns->bdev->bd_inode);
>  }
>  =

> -static u16 blk_to_nvme_status(struct nvmet_req *req, blk_status_t blk_st=
s)
> +u16 blk_to_nvme_status(struct nvmet_req *req, blk_status_t blk_sts)
>  {
>  	u16 status =3D NVME_SC_SUCCESS;
>  =

> @@ -448,6 +456,15 @@ u16 nvmet_bdev_parse_io_cmd(struct nvmet_req *req)
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
> index ab878fb96fbd..5e6514565f8c 100644
> --- a/drivers/nvme/target/nvmet.h
> +++ b/drivers/nvme/target/nvmet.h
> @@ -248,6 +248,10 @@ struct nvmet_subsys {
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
> @@ -528,6 +532,7 @@ void nvmet_ns_changed(struct nvmet_subsys *subsys, u3=
2 nsid);
>  void nvmet_bdev_ns_revalidate(struct nvmet_ns *ns);
>  int nvmet_file_ns_revalidate(struct nvmet_ns *ns);
>  void nvmet_ns_revalidate(struct nvmet_ns *ns);
> +u16 blk_to_nvme_status(struct nvmet_req *req, blk_status_t blk_sts);
>  =

>  static inline u32 nvmet_rw_data_len(struct nvmet_req *req)
>  {
> @@ -585,6 +590,48 @@ static inline struct nvme_ctrl *nvmet_passthru_ctrl(=
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
> +	pr_err("unhandled identify cns %d on qid %d\n",
> +	       req->cmd->identify.cns, req->sq->qid);
> +	req->error_loc =3D offsetof(struct nvme_identify, cns);
> +	nvmet_req_complete(req, NVME_SC_INVALID_FIELD | NVME_SC_DNR);
> +}
> +static inline void
> +nvmet_execute_identify_cns_cs_ns(struct nvmet_req *req)
> +{
> +	pr_err("unhandled identify cns %d on qid %d\n",
> +	       req->cmd->identify.cns, req->sq->qid);
> +	req->error_loc =3D offsetof(struct nvme_identify, cns);
> +	nvmet_req_complete(req, NVME_SC_INVALID_FIELD | NVME_SC_DNR);
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
> index 000000000000..308198dd580b
> --- /dev/null
> +++ b/drivers/nvme/target/zns.c
> @@ -0,0 +1,477 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * NVMe ZNS-ZBD command implementation.
> + * Copyright (C) 2021 Western Digital Corporation or its affiliates.
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
> +static u16 nvmet_bdev_validate_zone_mgmt_recv(struct nvmet_req *req)
> +{
> +	sector_t sect =3D nvmet_lba_to_sect(req->ns, req->cmd->zmr.slba);
> +	u32 out_bufsize =3D (le32_to_cpu(req->cmd->zmr.numd) + 1) << 2;
> +
> +	if (!bdev_is_zoned(req->ns->bdev))
> +		return NVME_SC_INVALID_NS | NVME_SC_DNR;
> +
> +	if (sect > get_capacity(req->ns->bdev->bd_disk)) {
> +		req->error_loc =3D offsetof(struct nvme_zone_mgmt_recv_cmd, slba);
> +		return NVME_SC_INVALID_FIELD | NVME_SC_DNR;
> +	}
> +
> +	/*
> +	 * Make sure out buffer size at least matches nvme report zone header.
> +	 * Reporting partial 64 bit nr_zones value can lead to unwanted side
> +	 * effects.
> +	 */
> +	if (out_bufsize < sizeof(struct nvme_zone_report)) {
> +		req->error_loc =3D offsetof(struct nvme_zone_mgmt_recv_cmd, numd);
> +		return NVME_SC_INVALID_FIELD | NVME_SC_DNR;
> +	}
> +
> +	if (req->cmd->zmr.zra !=3D NVME_ZRA_ZONE_REPORT) {
> +		req->error_loc =3D offsetof(struct nvme_zone_mgmt_recv_cmd, zra);
> +		return NVME_SC_INVALID_FIELD | NVME_SC_DNR;
> +	}
> +
> +	switch (req->cmd->zmr.pr) {
> +	case 0:
> +	case 1:
> +		break;
> +	default:
> +		req->error_loc =3D offsetof(struct nvme_zone_mgmt_recv_cmd, pr);
> +		return NVME_SC_INVALID_FIELD | NVME_SC_DNR;
> +	}
> +
> +	switch (req->cmd->zmr.zrasf) {
> +	case NVME_ZRASF_ZONE_REPORT_ALL:
> +	case NVME_ZRASF_ZONE_STATE_EMPTY:
> +	case NVME_ZRASF_ZONE_STATE_IMP_OPEN:
> +	case NVME_ZRASF_ZONE_STATE_EXP_OPEN:
> +	case NVME_ZRASF_ZONE_STATE_CLOSED:
> +	case NVME_ZRASF_ZONE_STATE_FULL:
> +	case NVME_ZRASF_ZONE_STATE_READONLY:
> +	case NVME_ZRASF_ZONE_STATE_OFFLINE:
> +		break;
> +	default:
> +		req->error_loc =3D
> +			offsetof(struct nvme_zone_mgmt_recv_cmd, zrasf);
> +		return NVME_SC_INVALID_FIELD | NVME_SC_DNR;
> +	}
> +
> +	return NVME_SC_SUCCESS;
> +}
> +
> +static inline u8 nvmet_zasl(unsigned int zone_append_sects)
> +{
> +	/*
> +	 * Zone Append Size Limit is the value expressed in the units of minimum
> +	 * memory page size (i.e. 12) and is reported power of 2.
> +	 */
> +	return ilog2(zone_append_sects >> (NVMET_MPSMIN_SHIFT - 9));
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
> +	return ret <=3D 0;
> +}
> +
> +bool nvmet_bdev_zns_enable(struct nvmet_ns *ns)
> +{
> +	if (nvmet_bdev_has_conv_zones(ns->bdev))
> +		return false;
> +
> +	ns->blksize_shift =3D blksize_bits(bdev_logical_block_size(ns->bdev));
> +
> +	if (!nvmet_zns_update_zasl(ns))
> +		return false;
> +	/*
> +	 * Generic zoned block devices may have a smaller last zone which is
> +	 * not supported by ZNS. Excludes zoned drives that have such smaller
> +	 * last zone.
> +	 */
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
> +	struct nvme_zone_report *rz;
> +	struct nvmet_ns *ns;
> +	u64 nr_zones;
> +	u8 zrasf;
> +};
> +
> +static int nvmet_bdev_report_zone_cb(struct blk_zone *z, unsigned i, voi=
d *d)
> +{
> +	struct nvmet_report_zone_data *rz =3D d;
> +	struct nvme_zone_descriptor *entries =3D rz->rz->entries;
> +	struct nvmet_ns *ns =3D rz->ns;
> +	static const unsigned int blk_zcond_to_nvme_zstate[] =3D {
> +		[BLK_ZONE_COND_EMPTY]	 =3D NVME_ZRASF_ZONE_STATE_EMPTY,
> +		[BLK_ZONE_COND_IMP_OPEN] =3D NVME_ZRASF_ZONE_STATE_IMP_OPEN,
> +		[BLK_ZONE_COND_EXP_OPEN] =3D NVME_ZRASF_ZONE_STATE_EXP_OPEN,
> +		[BLK_ZONE_COND_CLOSED]	 =3D NVME_ZRASF_ZONE_STATE_CLOSED,
> +		[BLK_ZONE_COND_READONLY] =3D NVME_ZRASF_ZONE_STATE_READONLY,
> +		[BLK_ZONE_COND_FULL]	 =3D NVME_ZRASF_ZONE_STATE_FULL,
> +		[BLK_ZONE_COND_OFFLINE]	 =3D NVME_ZRASF_ZONE_STATE_OFFLINE,
> +	};

This creates a sparse array bigger than it needs to be. If you reverse here=
 and
use the ZRASF values as indexes (blk_zrasf_to_zcond[]), the array will shri=
nk
and not be sparse, then... See below...

> +
> +	if (rz->zrasf =3D=3D NVME_ZRASF_ZONE_REPORT_ALL)
> +		goto record_zone;
> +
> +	/*
> +	 * Make sure this zone condition's value is mapped to NVMe ZNS zone
> +	 * condition value.
> +	 */
> +	if (z->cond > ARRAY_SIZE(blk_zcond_to_nvme_zstate) ||
> +	    !blk_zcond_to_nvme_zstate[z->cond])
> +		return -EINVAL;
> +
> +	/* filter zone by condition */
> +	if (blk_zcond_to_nvme_zstate[z->cond] !=3D rz->zrasf)
> +		return 0;

...since zrasf is already validated, all of the above becomes:

	/* filter zones by condition */
	if (rz->zrasf !=3D NVME_ZRASF_ZONE_REPORT_ALL &&
	    z->cond !=3D blk_zrasf_to_zcond[rz->zrasf])
		return 0;

> +
> +record_zone:

This label can go away too.

> +
> +	entries[rz->nr_zones].zcap =3D nvmet_sect_to_lba(ns, z->capacity);
> +	entries[rz->nr_zones].zslba =3D nvmet_sect_to_lba(ns, z->start);
> +	entries[rz->nr_zones].wp =3D nvmet_sect_to_lba(ns, z->wp);
> +	entries[rz->nr_zones].za =3D z->reset ? 1 << 2 : 0;
> +	entries[rz->nr_zones].zs =3D z->cond << 4;
> +	entries[rz->nr_zones].zt =3D z->type;
> +
> +	rz->nr_zones++;
> +
> +	return 0;
> +}
> +
> +unsigned long nvmet_req_nr_zones_from_slba(struct nvmet_req *req)
> +{
> +	sector_t total_sect_from_slba;
> +
> +	total_sect_from_slba =3D get_capacity(req->ns->bdev->bd_disk) -
> +				nvmet_lba_to_sect(req->ns, req->cmd->zmr.slba);
> +
> +	return total_sect_from_slba / bdev_zone_sectors(req->ns->bdev);
> +}
> +
> +unsigned long get_nr_zones_from_buf(struct nvmet_req *req, u32 out_bufsi=
ze)
> +{
> +	if (out_bufsize < sizeof(struct nvme_zone_report))
> +		return 0;
> +
> +	return (out_bufsize - sizeof(struct nvme_zone_report)) /
> +		sizeof(struct nvme_zone_descriptor);
> +}
> +
> +unsigned long bufsize_from_zones(unsigned long nr_zones)
> +{
> +	return sizeof(struct nvme_zone_report) +
> +		(sizeof(struct nvme_zone_descriptor) * nr_zones);
> +}
> +
> +void nvmet_bdev_execute_zone_mgmt_recv(struct nvmet_req *req)
> +{
> +	unsigned long req_slba_nr_zones =3D nvmet_req_nr_zones_from_slba(req);
> +	sector_t sect =3D nvmet_lba_to_sect(req->ns, req->cmd->zmr.slba);
> +	u32 out_bufsize =3D (le32_to_cpu(req->cmd->zmr.numd) + 1) << 2;
> +	unsigned long out_nr_zones =3D get_nr_zones_from_buf(req, out_bufsize);
> +	int reported_zones;
> +	u32 bufsize;
> +	u16 status;
> +	struct nvmet_report_zone_data data =3D {
> +		.ns =3D req->ns,
> +		.zrasf =3D req->cmd->zmr.zrasf
> +	};
> +
> +	status =3D nvmet_bdev_validate_zone_mgmt_recv(req);
> +	if (status)
> +		goto out;
> +
> +	/* nothing to report */
> +	if (!req_slba_nr_zones) {
> +		status =3D NVME_SC_SUCCESS;
> +		goto out;
> +	}
> +
> +	/*
> +	 * Allocate Zone descriptors based on the number of zones that fit from
> +	 * zmr.slba to disk capacity.
> +	 */
> +	bufsize =3D bufsize_from_zones(req_slba_nr_zones);
> +
> +	data.rz =3D __vmalloc(bufsize, GFP_KERNEL | __GFP_NORETRY | __GFP_ZERO);
> +	if (!data.rz) {
> +		status =3D NVME_SC_INTERNAL;
> +		goto out;
> +	}
> +
> +	reported_zones =3D blkdev_report_zones(req->ns->bdev, sect,
> +					     req_slba_nr_zones,
> +					     nvmet_bdev_report_zone_cb, &data);
> +	if (reported_zones < 0) {
> +		status =3D NVME_SC_INTERNAL;
> +		goto out_free_report_zones;
> +	}
> +
> +	if (req->cmd->zmr.pr) {
> +		/*
> +		 * When partial bit is set nr_zones =3D=3D zone desc transferred. So
> +		 * if captured zones are less than the nr zones that can fit in
> +		 * out buf, then trim the out_bufsize to avoid extra copy also
> +		 * update the number of zones that we can transfer in out buf.
> +		 */
> +		if (data.nr_zones < out_nr_zones) {
> +			out_bufsize =3D bufsize_from_zones(data.nr_zones);
> +			out_nr_zones =3D data.nr_zones;
> +		}
> +	} else {
> +		/*
> +		 * When partial bit is not set nr_zone =3D=3D zones for which ZSLBA
> +		 * value is greater than or equal to the ZSLBA value of the zone
> +		 * specified by the SLBA value in the command and match the
> +		 * criteria in the Zone Receive Action Specific field ZRASF.
> +		 */
> +		out_nr_zones =3D data.nr_zones;
> +
> +		/* trim out_bufsize to avoid extra copy */
> +		if (data.nr_zones < out_nr_zones)
> +			out_bufsize =3D bufsize_from_zones(data.nr_zones);
> +	}
> +
> +	data.rz->nr_zones =3D cpu_to_le64(out_nr_zones);
> +
> +	status =3D nvmet_copy_to_sgl(req, 0, data.rz, out_bufsize);
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
> +	u16 status =3D NVME_SC_SUCCESS;
> +	u8 zsa =3D req->cmd->zms.zsa;
> +	sector_t nr_sects;
> +	enum req_opf op;
> +	int ret;
> +	const unsigned int zsa_to_op[] =3D {
> +		[NVME_ZONE_OPEN]	=3D REQ_OP_ZONE_OPEN,
> +		[NVME_ZONE_CLOSE]	=3D REQ_OP_ZONE_CLOSE,
> +		[NVME_ZONE_FINISH]	=3D REQ_OP_ZONE_FINISH,
> +		[NVME_ZONE_RESET]	=3D REQ_OP_ZONE_RESET,
> +	};
> +
> +	if (zsa > ARRAY_SIZE(zsa_to_op)) {
> +		status =3D NVME_SC_INVALID_FIELD;
> +		goto out;
> +	}
> +
> +	op =3D zsa_to_op[zsa];
> +
> +	if (req->cmd->zms.select_all) {
> +		sect =3D 0;
> +		nr_sects =3D get_capacity(req->ns->bdev->bd_disk);
> +	} else {
> +		sect =3D nvmet_lba_to_sect(req->ns, req->cmd->zms.slba);
> +		nr_sects =3D bdev_zone_sectors(req->ns->bdev);
> +	}
> +
> +	ret =3D blkdev_zone_mgmt(req->ns->bdev, op, sect, nr_sects, GFP_KERNEL);
> +	if (ret)
> +		status =3D NVME_SC_INTERNAL;

This one is a little odd with regard to the ALL bit. In the block layer, on=
ly
zone reset all is supported, which mean that the above will not do
open/close/finish all. Only reset all will work. Open/close/finish all need=
 to
be emulated here: do a full report zone and based on the zone condition and=
 op,
call blkdev_zone_mgmt() for each zone that need a operation. Ideally,
blkdev_zone_mgmt() should be called in the report cb, but I am not sure if =
that
cannot create some context problems...

> +out:
> +	nvmet_req_complete(req, status);
> +}
> +
> +static void nvmet_bdev_zone_append_bio_done(struct bio *bio)
> +{
> +	struct nvmet_req *req =3D bio->bi_private;
> +
> +	req->cqe->result.u64 =3D nvmet_sect_to_lba(req->ns,
> +						 bio->bi_iter.bi_sector);

You should do this only if status is success, no ?

> +	nvmet_req_complete(req, blk_to_nvme_status(req, bio->bi_status));
> +	if (bio !=3D &req->b.inline_bio)
> +		bio_put(bio);
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
> +	/* Request is completed on len mismatch in nvmet_check_transter_len() */
> +	if (!nvmet_check_transfer_len(req, nvmet_rw_data_len(req)))
> +		return;
> +
> +	if (!req->sg_cnt) {
> +		nvmet_req_complete(req, 0);

isn't this an error ? (not entirely sure)

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
> +	bio->bi_private =3D req;
> +	bio->bi_end_io =3D nvmet_bdev_zone_append_bio_done;
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
> +	submit_bio(bio);
> +	return;
> +
> +out_bio_put:
> +	if (bio !=3D &req->b.inline_bio)
> +		bio_put(bio);
> +	nvmet_req_complete(req, ret < 0 ? NVME_SC_INTERNAL : status);
> +}
> diff --git a/include/linux/nvme.h b/include/linux/nvme.h
> index c7ba83144d52..cb1197f1cfed 100644
> --- a/include/linux/nvme.h
> +++ b/include/linux/nvme.h
> @@ -944,6 +944,13 @@ struct nvme_zone_mgmt_recv_cmd {
>  enum {
>  	NVME_ZRA_ZONE_REPORT		=3D 0,
>  	NVME_ZRASF_ZONE_REPORT_ALL	=3D 0,
> +	NVME_ZRASF_ZONE_STATE_EMPTY	=3D 0x01,
> +	NVME_ZRASF_ZONE_STATE_IMP_OPEN	=3D 0x02,
> +	NVME_ZRASF_ZONE_STATE_EXP_OPEN	=3D 0x03,
> +	NVME_ZRASF_ZONE_STATE_CLOSED	=3D 0x04,
> +	NVME_ZRASF_ZONE_STATE_READONLY	=3D 0x05,
> +	NVME_ZRASF_ZONE_STATE_FULL	=3D 0x06,
> +	NVME_ZRASF_ZONE_STATE_OFFLINE	=3D 0x07,
>  	NVME_REPORT_ZONE_PARTIAL	=3D 1,
>  };
>  =

> =



-- =

Damien Le Moal
Western Digital Research

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
