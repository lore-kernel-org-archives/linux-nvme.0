Return-Path: <SRS0=PNO/=FP=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F98DC4361B
	for <linux-nvme@archiver.kernel.org>; Fri, 11 Dec 2020 01:18:58 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 821C023A33
	for <linux-nvme@archiver.kernel.org>; Fri, 11 Dec 2020 01:18:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 821C023A33
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:To:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=BqBcUEtUDJ5K2mLfq8d1YJkTvfbzinI+2PkIZg6Slu0=; b=pBMPeKNZXywK82FjC9LBwF5yg
	GKhgzc/KPa8ac2kPjogquzHN3OjJ4csuopGzBKLNDpaUrPNubv8gKriVYBgRnBKplWKL8gBjr57ow
	oodHw7HPjlRaGC2b4/B0LBE8yQB/iGCDzziYL792V7bMCtbuO87gRTGHE7yv9Bu+iq+F2EUiyT+hf
	vxI7tpt/IfTCGhkTIDE42hde0zqoOfEnZBc9g+Q6Q5h3tkuFX/HOtZWJlTVNqJ3hu1uRBR+3Gw1Cx
	pEATeKFtXmvxKw5FE3msKLRSor8OB4bC5RvqnQwNWA5hsPEkW6nxe7xocPnXPEPfT6kkFxKWUJEU+
	zj2hcDGmA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1knX58-00054R-PD; Fri, 11 Dec 2020 01:18:50 +0000
Received: from esa1.hgst.iphmx.com ([68.232.141.245])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1knX54-00053x-W3
 for linux-nvme@lists.infradead.org; Fri, 11 Dec 2020 01:18:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1607649526; x=1639185526;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=/96ml6YGQXQcYPEquZQ+urBZ0kildGvlitiA8YbzSsw=;
 b=ecW8Iophzwzo6siKDpaqpyO516TGmKLhfWOKMzWBxL+mvycTUGDaxPFB
 W2c0lcFeHxFx8WqDoUDrSENRD9uVkA0oebmdJ5IYlEdYmuqbXm/vu3qjY
 2JNxdUnxpxER6c1FO/Q+aHRJI+goSc1F816Njl/MBU+UUWXBj9zl7Sdj/
 mM7wtgdUp7KyUff8xK+wjuFHjLsf8Gi4ClTiHWAAlGfus4v9hDZKmdnfY
 KUkVP7JpvL5g13oAfSvhATYX7RouTE7rCCI46C6aAjuwaSFQSN5Zj9004
 1EiIpOrzcn9/m9wPUp/AOyelTj36pW0SaXTwKAZVbmS9TczvdhRk2Garp g==;
IronPort-SDR: 59hvkegVpSFRQLoKtUW5xxwraLVvSbt5JS3NtY2y5R+0ibr9J1NBDTl850L1DmhfhPeyr1bKZq
 diRYoO2Hf9YIYgMEaLzBen1CqrmHJsz6l0fMbnSMErTz/7FDXSpxcB3HHMEWAqO0dDP3fZlHbp
 oW9zvmpvBlx5N+1Kp6bap4W1dy2aKg5lMGXfUmGtFmBDNqhbx1243XXMsTJGhTEJxHUYT6Q5oD
 auVZxtWIWFAoEU97ENAUbqjtmmgJV0GE5yKAvFFduzXZLA8b+7B+SaWwbF5Nz18h0v7At1flNg
 Vfk=
X-IronPort-AV: E=Sophos;i="5.78,409,1599494400"; d="scan'208";a="265065358"
Received: from mail-bn8nam12lp2175.outbound.protection.outlook.com (HELO
 NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.175])
 by ob1.hgst.iphmx.com with ESMTP; 11 Dec 2020 09:18:44 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EMhnFNnVtBqRt8tUsphFFsxfFThMc9mATB3iIJhnUZylUPtEDMkZ5aPa758LirdsdZw5eLQZEa9hwPF8fOrBpI3JPn9llVjY5bn3EbqB37puWNJ94OuUlDhMTOWh8iyQnvxphgZ/9oiCOf2ZWweI3hXlKOxgTP6Si8WDBBeT9NlHp6p5LZabq/OQUz8uESO0C7GO/LXez1YWoufuIzW7nHGKK0T/C5XQZEKZ36Vrqss9LDzJlrWtgo0jNT710aXzBDEeOXzMhRSJh6L2Oq8+tL9555vSqEjhGd3ArmYSnidIaXEcsMq1mzsHDCoNaEEKI+5h1Pta2OOea1ZueXu8kQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=14GeeTJJHRocztNVgAe7FDlsYd38XEAXCR+H9CXFRng=;
 b=UijADisgSgSMU0/kIPuMcIfzOv4/5IHDlTarVCAig2kS/50ROmm8QgTD8LVWAWEGO/Zhqrf8QMR+gRaFVsNZAv/mWLx5XyDFwMs6J9jAkLXQPdXZYMyvhyJYJI+57k1Og4K57H5RrvdT6SI2g0GhQwZR0loa9+Y859pjRecNtpmV2jf/I9xEY3MnP5F+FBeIWetpbYeigyJ3BRw7GbT7NUNqGTa12xb8KH1l3i/Om0iKAeJ4ljpON+SpYMAOMqteBwVjeEcsnL71g9Py9TCgyD82ZBUBAcxEiKsmfew/eMOLPP5wWFZCH3yFUPUMGJaTrdbh1J8wV2XMzvpVAGfaKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=14GeeTJJHRocztNVgAe7FDlsYd38XEAXCR+H9CXFRng=;
 b=fF9PY26KrM61SX8LJblgK/24lacOynFNvSySHW8D9z/EzYNP1cLaMgYKDLJSSHjzZEsQ8SlpercdDogksPNZC8lCO3hbr/Ywe40+7cjz5EyYTgTohEATq/9trNlcVBPdEQEz3Lp7ePNft2eublBn8eGpK9xcvdTzlqh7s9wBQBk=
Received: from CH2PR04MB6522.namprd04.prod.outlook.com (2603:10b6:610:34::19)
 by CH2PR04MB6588.namprd04.prod.outlook.com (2603:10b6:610:6c::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.21; Fri, 11 Dec
 2020 01:18:43 +0000
Received: from CH2PR04MB6522.namprd04.prod.outlook.com
 ([fe80::897c:a04b:4eb0:640a]) by CH2PR04MB6522.namprd04.prod.outlook.com
 ([fe80::897c:a04b:4eb0:640a%7]) with mapi id 15.20.3632.023; Fri, 11 Dec 2020
 01:18:43 +0000
From: Damien Le Moal <Damien.LeMoal@wdc.com>
To: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH V5 4/6] nvmet: add ZBD over ZNS backend support
Thread-Topic: [PATCH V5 4/6] nvmet: add ZBD over ZNS backend support
Thread-Index: AQHWzr2FP/i+FdqWaEeC/fieodd2UA==
Date: Fri, 11 Dec 2020 01:18:43 +0000
Message-ID: <CH2PR04MB652299EA78B1304157CC8234E7CA0@CH2PR04MB6522.namprd04.prod.outlook.com>
References: <20201210062622.62053-1-chaitanya.kulkarni@wdc.com>
 <20201210062622.62053-5-chaitanya.kulkarni@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2400:2411:43c0:6000:5911:8225:c337:ee37]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 01a90302-859c-4010-7aa0-08d89d72b354
x-ms-traffictypediagnostic: CH2PR04MB6588:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CH2PR04MB658847B6BFD693A982DA1983E7CA0@CH2PR04MB6588.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OYwgFlbxEYc3mJgkDMIdd7pMTFVPHYMMAtdGxr617HQRaD2wM8vyMADkyy6m/oOIVWddG7Dlam2uuZNCoPIGb9XEp8FvMQpGdLIbvV/Fyq4FTvxWfOEPZS4EUvU9VUDMpgFoCXmuLDqx6JNt9VSwg7E49xyMZiSaPvl63EiI3yyFJedoYEn3cQXjGG4DquUun6ir/Ar3/fIEf+9Xbw2KBXX7UcSYmX7jdjAGEFUtPPquBNjDpAqVsFpkllMIWbCk7CGHGIqE4O1KW7GU2eje2vBcU/N9GN5WZADucDLbXgD6kSh0UjgkbDAQuf47oy8F
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR04MB6522.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(346002)(136003)(376002)(91956017)(55016002)(9686003)(6506007)(66476007)(83380400001)(5660300002)(30864003)(64756008)(508600001)(66946007)(8676002)(7696005)(186003)(54906003)(52536014)(76116006)(53546011)(66556008)(110136005)(86362001)(33656002)(66446008)(8936002)(4326008)(2906002)(71200400001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: =?Windows-1252?Q?M3y2+u/yQkUamieQp3ujeDMYdyTR1JZ6e04PJFuQ/cSLA7kAFujXH8Uy?=
 =?Windows-1252?Q?JmNIeSkA63lCFBRwfiVP+VpFsYdzObxKy3txJfjkRcQhACZ8BfdoNk8d?=
 =?Windows-1252?Q?tzR4Ix08Q+Hw0czAddTweU8Cj1nMPL3oLTjwRJ2i43OdPGujBdvx4obo?=
 =?Windows-1252?Q?xAoIiYuXASw3tmltZjrJCvGPuYFGLJWjLGMeQ3MfKiHgYRqd3hlyAj5Q?=
 =?Windows-1252?Q?oIB/zT3N+F1NBOxcfKnUXHl1oVvmD31SerK3PnJVbncCsczvYocwAhzP?=
 =?Windows-1252?Q?ctLEOTmDgVVa7z2TtA2Sea6XUV9uArwSFlVXW7vsQ16auPiECu0xwuNF?=
 =?Windows-1252?Q?J+wfclIcEK6A+a3HoC5jLXptoDo7aEvttKnvsY+0xV7ktpqSU6EK6hGa?=
 =?Windows-1252?Q?QF4shF75sxGp577MOaUh14D07quykAjoMQGcfu6OnthX0kWZCENLZDaO?=
 =?Windows-1252?Q?5WoN/Pz262CtWHXK3QAdCHlEseEKc3xbudnOZ3UjBZ4oA5k9RGRKqKsc?=
 =?Windows-1252?Q?ehivSrCcjxy7HTD6UtJuc8w1CRgk/3zey7+K6ZqC5tAqlAPJDB3u9GVe?=
 =?Windows-1252?Q?chiy+wBXCyya6QxeuY+JpscsKL98b8ISQtajUZIpIFMJPV/SmRx5naoZ?=
 =?Windows-1252?Q?1d5rnQHOLKaJtkm/fBDc1uar634WMbbKmJeGvr2A7NWbOr7qVEaHDMzr?=
 =?Windows-1252?Q?Ec8fvbNvUfunJGiIa+TDlZxCZE2np+WYKO+BbZfjGs7dWzPvL0NgCda7?=
 =?Windows-1252?Q?8JEPCcqI163RiqHdGw1uAy2S5t5aR1LLYGvPv4dziUXdv2a85P/2utYX?=
 =?Windows-1252?Q?/PuB7ez7emQ/KMMeVKh8w0Hv0yDVH/uW+mo6EkPkcDY4sVvmPZFgH1dI?=
 =?Windows-1252?Q?kanoPKhYBa05QBFp6d+ypEZKv5MlXrLKPxuVBHn9AdCG34lGzi6kRHjq?=
 =?Windows-1252?Q?N5mlf7WqtH9rwkBe16IpAgSjouSlthe+peHou5ekn4Weru3k+dVR67lC?=
 =?Windows-1252?Q?RbyEgECvUbiODKFA827PNA1jVqjDBd8iP7ILmfQm1MBD1FVIrBQJ4QxF?=
 =?Windows-1252?Q?6tFtPSf5W9hsWtXkU717X8JiaoDbuiMmtPJsl50H2K4Hil3SutZyq2nX?=
 =?Windows-1252?Q?AmWwcLj5fCxsA0meojD0jC0p?=
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR04MB6522.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01a90302-859c-4010-7aa0-08d89d72b354
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Dec 2020 01:18:43.2440 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TZo9Eyn2YXnBVOEPaBjKHTxzfRaIAy7KSlPgeqBZWXPYufT07lcDURRiopiTZ2pHPCMC9cNB+QB68D7dGWaPjA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR04MB6588
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201210_201847_632687_A2B475E2 
X-CRM114-Status: GOOD (  20.94  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: "sagi@grimberg.me" <sagi@grimberg.me>, "hch@lst.de" <hch@lst.de>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 2020/12/10 15:27, Chaitanya Kulkarni wrote:
> NVMe TP 4053 =96 Zoned Namespaces (ZNS) allows host software to
> communicate with a non-volatile memory subsystem using zones for
> NVMe protocol based controllers. NVMeOF already support the ZNS NVMe
> Protocol compliant devices on the target in the passthru mode. There
> are Generic Zoned Block Devices like  Shingled Magnetic Recording (SMR)

Please remove "Generic" from this sentence. It is confusing. Also, I do not
think you need to capitalize ZOned Block Devices. That is something Linux
defines. It is not defined by any standard.

> HDD which are not based on the NVMe protocol.
> =

> This patch adds ZNS backend to support the ZBDs for NVMeOF target.
> =

> This support inculdes implementing the new command set NVME_CSI_ZNS,

s/inculdes/includes

> adding different command handlers for ZNS command set such as
> NVMe Identify Controller, NVMe Identify Namespace, NVMe Zone Append,
> NVMe Zone Management Send and NVMe Zone Management Receive.
> =

> With new command set identifier we also update the target command effects
> logs to reflect the ZNS compliant commands.
> =

> Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
> ---
>  drivers/nvme/target/Makefile      |   1 +
>  drivers/nvme/target/admin-cmd.c   |  26 +++
>  drivers/nvme/target/core.c        |   1 +
>  drivers/nvme/target/io-cmd-bdev.c |  33 ++-
>  drivers/nvme/target/nvmet.h       |  38 ++++
>  drivers/nvme/target/zns.c         | 327 ++++++++++++++++++++++++++++++
>  6 files changed, 418 insertions(+), 8 deletions(-)
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
> index f4c0f3aca485..6f5279b15aa6 100644
> --- a/drivers/nvme/target/admin-cmd.c
> +++ b/drivers/nvme/target/admin-cmd.c
> @@ -192,6 +192,15 @@ static void nvmet_execute_get_log_cmd_effects_ns(str=
uct nvmet_req *req)
>  		log->iocs[nvme_cmd_dsm]			=3D cpu_to_le32(1 << 0);
>  		log->iocs[nvme_cmd_write_zeroes]	=3D cpu_to_le32(1 << 0);
>  		break;
> +	case NVME_CSI_ZNS:
> +		if (IS_ENABLED(CONFIG_BLK_DEV_ZONED)) {
> +			u32 *iocs =3D log->iocs;
> +
> +			iocs[nvme_cmd_zone_append]	=3D cpu_to_le32(1 << 0);
> +			iocs[nvme_cmd_zone_mgmt_send]	=3D cpu_to_le32(1 << 0);
> +			iocs[nvme_cmd_zone_mgmt_recv]	=3D cpu_to_le32(1 << 0);
> +		}
> +		break;
>  	default:
>  		status =3D NVME_SC_INVALID_LOG_PAGE;
>  		break;
> @@ -614,6 +623,7 @@ static u16 nvmet_copy_ns_identifier(struct nvmet_req =
*req, u8 type, u8 len,
>  =

>  static void nvmet_execute_identify_desclist(struct nvmet_req *req)
>  {
> +	u16 nvme_cis_zns =3D NVME_CSI_ZNS;
>  	u16 status =3D 0;
>  	off_t off =3D 0;
>  =

> @@ -638,6 +648,14 @@ static void nvmet_execute_identify_desclist(struct n=
vmet_req *req)
>  		if (status)
>  			goto out;
>  	}
> +	if (IS_ENABLED(CONFIG_BLK_DEV_ZONED)) {
> +		if (req->ns->csi =3D=3D NVME_CSI_ZNS)
> +			status =3D nvmet_copy_ns_identifier(req, NVME_NIDT_CSI,
> +							  NVME_NIDT_CSI_LEN,
> +							  &nvme_cis_zns, &off);
> +		if (status)
> +			goto out;
> +	}
>  =

>  	if (sg_zero_buffer(req->sg, req->sg_cnt, NVME_IDENTIFY_DATA_SIZE - off,
>  			off) !=3D NVME_IDENTIFY_DATA_SIZE - off)
> @@ -655,8 +673,16 @@ static void nvmet_execute_identify(struct nvmet_req =
*req)
>  	switch (req->cmd->identify.cns) {
>  	case NVME_ID_CNS_NS:
>  		return nvmet_execute_identify_ns(req);
> +	case NVME_ID_CNS_CS_NS:
> +		if (req->cmd->identify.csi =3D=3D NVME_CSI_ZNS)
> +			return nvmet_execute_identify_cns_cs_ns(req);
> +		break;
>  	case NVME_ID_CNS_CTRL:
>  		return nvmet_execute_identify_ctrl(req);
> +	case NVME_ID_CNS_CS_CTRL:
> +		if (req->cmd->identify.csi =3D=3D NVME_CSI_ZNS)
> +			return nvmet_execute_identify_cns_cs_ctrl(req);
> +		break;
>  	case NVME_ID_CNS_NS_ACTIVE_LIST:
>  		return nvmet_execute_identify_nslist(req);
>  	case NVME_ID_CNS_NS_DESC_LIST:
> diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
> index 672e4009f8d6..17a99c7134dc 100644
> --- a/drivers/nvme/target/core.c
> +++ b/drivers/nvme/target/core.c
> @@ -1107,6 +1107,7 @@ static inline u8 nvmet_cc_iocqes(u32 cc)
>  static inline bool nvmet_cc_css_check(u8 cc_css)
>  {
>  	switch (cc_css <<=3D NVME_CC_CSS_SHIFT) {
> +	case NVME_CC_CSS_CSI:
>  	case NVME_CC_CSS_NVM:
>  		return true;
>  	default:
> diff --git a/drivers/nvme/target/io-cmd-bdev.c b/drivers/nvme/target/io-c=
md-bdev.c
> index 23095bdfce06..6178ef643962 100644
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
> +	if (IS_ENABLED(CONFIG_BLK_DEV_ZONED) && bdev_is_zoned(ns->bdev)) {
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
>  		pr_err("unhandled cmd %d on qid %d\n", cmd->common.opcode,
>  		       req->sq->qid);
> diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
> index 0360594abd93..dae6ecba6780 100644
> --- a/drivers/nvme/target/nvmet.h
> +++ b/drivers/nvme/target/nvmet.h
> @@ -252,6 +252,10 @@ struct nvmet_subsys {
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
> @@ -614,4 +618,38 @@ static inline sector_t nvmet_lba_to_sect(struct nvme=
t_ns *ns, __le64 lba)
>  	return le64_to_cpu(lba) << (ns->blksize_shift - SECTOR_SHIFT);
>  }
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
>  #endif /* _NVMET_H */
> diff --git a/drivers/nvme/target/zns.c b/drivers/nvme/target/zns.c
> new file mode 100644
> index 000000000000..ae51bae996f9
> --- /dev/null
> +++ b/drivers/nvme/target/zns.c
> @@ -0,0 +1,327 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * NVMe ZNS-ZBD command implementation.
> + * Copyright (c) 2020-2021 HGST, a Western Digital Company.
> + */
> +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> +#include <linux/uio.h>
> +#include <linux/nvme.h>
> +#include <linux/xarray.h>
> +#include <linux/blkdev.h>
> +#include <linux/module.h>
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
> +	u16 status =3D 0;
> +
> +	if (!bdev_is_zoned(req->ns->bdev)) {
> +		status =3D NVME_SC_INVALID_NS | NVME_SC_DNR;
> +		goto out;
> +	}
> +
> +	if (req->cmd->zmr.zra !=3D NVME_ZRA_ZONE_REPORT) {
> +		status =3D NVME_SC_INVALID_FIELD;
> +		goto out;
> +	}
> +
> +	if (req->cmd->zmr.zrasf !=3D NVME_ZRASF_ZONE_REPORT_ALL) {
> +		status =3D NVME_SC_INVALID_FIELD;
> +		goto out;
> +	}
> +
> +	if (req->cmd->zmr.pr !=3D NVME_REPORT_ZONE_PARTIAL)
> +		status =3D NVME_SC_INVALID_FIELD;
> +
> +out:
> +	return status;
> +}

I really fail to see how the gotos here help with the code "being better".
Are you absolutely sure you want to keep this super convoluted style for a
function that is that simple ?

> +
> +/*
> + *  ZNS related command implementation and helpers.
> + */
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
> +		return ns->subsys->zasl < zasl ? false : true;
> +
> +	ns->subsys->zasl =3D zasl;
> +	return true;
> +}
> +
> +bool nvmet_bdev_zns_enable(struct nvmet_ns *ns)
> +{
> +	if (ns->bdev->bd_disk->queue->conv_zones_bitmap) {

Hmm... BIO based DM devices do not have this bitmap set since they do not h=
ave a
scheduler. So if one setup a dm-linear device on top of an SMR disk and exp=
ort
the DM device through fabric, then this check will fail to verify if
conventional zones are present. There may be no other option than to do a f=
ull
report zones here if queue->seq_zones_wlock is NULL (meaning the queue is f=
or a
stacked device).

> +		pr_err("block devices with conventional zones are not supported.");
> +		return false;
> +	}
> +
> +	/*
> +	 * For ZBC and ZAC devices, writes into sequential zones must be aligned
> +	 * to the device physical block size. So use this value as the logical
> +	 * block size to avoid errors.
> +	 */
> +	ns->blksize_shift =3D blksize_bits(bdev_physical_block_size(ns->bdev));
> +
> +	if (!nvmet_zns_update_zasl(ns))
> +		return false;
> +
> +	return !(get_capacity(ns->bdev->bd_disk) &
> +			(bdev_zone_sectors(ns->bdev) - 1));
> +}
> +
> +/*
> + * ZNS related Admin and I/O command handlers.
> + */
> +void nvmet_execute_identify_cns_cs_ctrl(struct nvmet_req *req)
> +{
> +	u8 zasl =3D req->sq->ctrl->subsys->zasl;
> +	struct nvmet_ctrl *ctrl =3D req->sq->ctrl;
> +	struct nvme_id_ctrl_zns *id;
> +	u16 status;
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
> +	u16 status =3D 0;
> +	u64 zsze;
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
> +	req->ns =3D nvmet_find_namespace(req->sq->ctrl, req->cmd->identify.nsid=
);
> +	if (!req->ns) {
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
> +static int nvmet_bdev_report_zone_cb(struct blk_zone *z, unsigned int id=
x,
> +				     void *data)
> +{
> +	struct nvmet_report_zone_data *report_zone_data =3D data;
> +	struct nvme_zone_descriptor *entries =3D report_zone_data->rz->entries;
> +	struct nvmet_ns *ns =3D report_zone_data->ns;
> +
> +	entries[idx].zcap =3D cpu_to_le64(nvmet_sect_to_lba(ns, z->capacity));
> +	entries[idx].zslba =3D cpu_to_le64(nvmet_sect_to_lba(ns, z->start));
> +	entries[idx].wp =3D cpu_to_le64(nvmet_sect_to_lba(ns, z->wp));
> +	entries[idx].za =3D z->reset ? 1 << 2 : 0;
> +	entries[idx].zt =3D z->type;
> +	entries[idx].zs =3D z->cond << 4;
> +
> +	return 0;
> +}
> +
> +void nvmet_bdev_execute_zone_mgmt_recv(struct nvmet_req *req)
> +{
> +	sector_t sect =3D nvmet_lba_to_sect(req->ns, req->cmd->zmr.slba);
> +	u64 bufsize =3D (le32_to_cpu(req->cmd->zmr.numd) + 1) << 2;
> +	struct nvmet_report_zone_data data =3D { .ns =3D req->ns };
> +	unsigned int nr_zones;
> +	int reported_zones;
> +	u16 status;
> +
> +	nr_zones =3D (bufsize - sizeof(struct nvme_zone_report)) /
> +			sizeof(struct nvme_zone_descriptor);

This is a 64 bits division. This will not compile on 32-bits arch, no ? I.e=
.,
you must use do_div64() here I think. Or just a bit shift since struct
nvme_zone_descriptor is exactly 64B. Or have bufsize be a 32 bits. There is=
 no
need for that variable to be 64 bits.

> +
> +	status =3D nvmet_bdev_zns_checks(req);
> +	if (status)
> +		goto out;
> +
> +	data.rz =3D __vmalloc(bufsize, GFP_KERNEL | __GFP_NORETRY);
> +	if (!data.rz) {
> +		status =3D NVME_SC_INTERNAL;
> +		goto out;
> +	}
> +
> +	reported_zones =3D blkdev_report_zones(req->ns->bdev, sect, nr_zones,
> +					     nvmet_bdev_report_zone_cb,
> +					     &data);
> +	if (reported_zones < 0) {
> +		status =3D NVME_SC_INTERNAL;
> +		goto out_free_report_zones;
> +	}
> +
> +	data.rz->nr_zones =3D cpu_to_le64(reported_zones);
> +
> +	status =3D nvmet_copy_to_sgl(req, 0, data.rz, bufsize);

reported_zoned may be far less than the request nr_zones. So you may want to
recalculate bufsize before doing this to not copy garbage data into the rep=
ly
buffer. Another thing that needs verification is: don't you need to zero-op=
ut
the data.rz buffer with GFP_ZERO, for security ?

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
> +	enum req_opf op =3D REQ_OP_LAST;
> +	u16 status =3D NVME_SC_SUCCESS;
> +	int ret;
> +
> +	if (req->cmd->zms.select_all)
> +		nr_sect =3D get_capacity(req->ns->bdev->bd_disk);
> +
> +	switch (req->cmd->zms.zsa) {
> +	case NVME_ZONE_OPEN:
> +		op =3D REQ_OP_ZONE_OPEN;
> +		break;
> +	case NVME_ZONE_CLOSE:
> +		op =3D REQ_OP_ZONE_CLOSE;
> +		break;
> +	case NVME_ZONE_FINISH:
> +		op =3D REQ_OP_ZONE_FINISH;
> +		break;
> +	case NVME_ZONE_RESET:
> +		op =3D REQ_OP_ZONE_RESET;
> +		break;
> +	default:
> +		status =3D NVME_SC_INVALID_FIELD;
> +		goto out;
> +	}
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
> +	struct request_queue *q =3D req->ns->bdev->bd_disk->queue;
> +	unsigned int max_sects =3D queue_max_zone_append_sectors(q);
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
> +		bool same_page =3D false;
> +
> +		ret =3D bio_add_hw_page(q, bio, p, l, o, max_sects, &same_page);
> +		if (ret !=3D sg->length) {
> +			status =3D NVME_SC_INTERNAL;
> +			goto out_bio_put;
> +		}
> +		if (same_page)
> +			put_page(p);
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
> +	status =3D ret < 0 ? NVME_SC_INTERNAL : status;
> +
> +	sect +=3D (total_len >> 9);

This is incorrect: sect is the start sector of the append operation target =
zone.
Adding to it the request size does not give the actual sector written on the
backend. You need to get that from the completed BIO. And do not add the re=
quest
size. The result is the first written sector, not the sector following the =
last
one written.

> +	req->cqe->result.u64 =3D cpu_to_le64(nvmet_sect_to_lba(req->ns, sect));
> +
> +out_bio_put:
> +	if (bio !=3D &req->b.inline_bio)
> +		bio_put(bio);
> +	nvmet_req_complete(req, status);
> +}
> =



-- =

Damien Le Moal
Western Digital Research

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
