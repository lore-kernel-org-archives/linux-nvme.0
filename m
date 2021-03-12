Return-Path: <SRS0=WLLZ=IK=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24DCEC433E0
	for <linux-nvme@archiver.kernel.org>; Fri, 12 Mar 2021 01:15:42 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 75B4E64F7E
	for <linux-nvme@archiver.kernel.org>; Fri, 12 Mar 2021 01:15:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75B4E64F7E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:CC:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=DIY4hdjG9LkzalizTG/L8+TBw5kvgpOIea+SwktSv0g=; b=TXmvlCmwNeztJqdV79j3nKYNO
	ueHHykZgrKLr1EKgqbLUuy4na1QgX6kvzua6olqOJMO80Svk0G1S9YSlX6TRP8x2dmW/FWTNPTAhx
	A+5nn56b4Qn1o05eVOTB2hGSkaswPPKiDFUPkK9paovCHbB9G9+71+aZ5kk5GlXkIjhyETXauoHMr
	2oy+Mnvah4AyMzZd5JIsE6D6RcRwWIO27m2vs2HrVFlHM8TIE9vseYMBJ8XHl8e4yZ/ag2JC3cO72
	ORpOuuhJEAj3XNJ0AuZH/05BxaHxUUhWJwMYF4tT2Vddflc78bx7ZIh3U9NZ+9xJIjvvixSEogX8t
	rXOYJfd7A==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lKWOp-00APRg-5v; Fri, 12 Mar 2021 01:15:31 +0000
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lKWOj-00APRF-St
 for linux-nvme@lists.infradead.org; Fri, 12 Mar 2021 01:15:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1615511725; x=1647047725;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=pDgex2/nlc+aMHqEKv/Bsoru732kWst1JdEVxr+d9+8=;
 b=cThmezohyano1zUZryntpqSL7AWC8vp2oBZ+NHcVdSD9Vk9dwq7gRHGz
 zbLACp1AlOnXApDzXQWzlgx+j2AZd7dMCd3+7HG0geepSWSxKaxhod8K/
 Ysd/Wg+XsczgnbN+j21F5adRmy4EmxSoMTlEN6ZEukIyJt6HRoefmL7p3
 rNPFt2djOUO32u8PTsC36gZ7VycpBrNAjI234W0bvRKkPEjErkbaRm75s
 5yjaZnAAYOAz/rObFaSmEuGbaeY4Q4ya2ubO2ZTftGIELGTUzZ68BG3Dh
 Ii11l+yaC87EEW3Wy50Sy3oFTwo4WJPvmS6S0RRKBM9IYCpNyR9PCvOma w==;
IronPort-SDR: 7nP5trJnlXCjKapUVByavDgfTGxxaIDaKTrP39kglzeGdVfwWDlgG9uArZYpQcNYR6zNKySKgA
 3GRr30UUf90lPglX+5ZyukoGbjuyDq9N/RuhcMJ7eiUnz+UXWKHaSEgtSnfeiODJSvoVWBaM4c
 540Cn+8FHddrDjaoKx6VTMtHoVegp2JpGzwMY+owODP3rMwZyAxgKyAgQnmq8i90XN0dGwZNYu
 fT+tt2KcRznMGN3ae+ZqqwCQ3MEldM0Jo9wicRp7qJQnjDgIFsTXg/VFajEskQp+aq5dLfGxXe
 wI0=
X-IronPort-AV: E=Sophos;i="5.81,241,1610380800"; d="scan'208";a="161954842"
Received: from mail-co1nam11lp2177.outbound.protection.outlook.com (HELO
 NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.177])
 by ob1.hgst.iphmx.com with ESMTP; 12 Mar 2021 09:15:22 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kt/KKkuT++3eM/TqU1t5OarFhYnFRxm6OKBdt2uHe34QB5uOaaWmJPX5R7dI7oi9L04g62bj55o9Ow4qy0fO6LsWE1PEK9zE3gySEjFIM+y2zVKegPFOwzSCGOPYP817bTwFSvbrVw5Y6VTvT1nQTDpYXCxRHxHi7phRTkn8c23nCkGwMdApct+ZEpNn0XPbYQ3PDNMVbxN6xhE6aJvQD5lesfGET6CXe1nzhGLC1hG41/CPENVIpN4UKzVvm+XFVjalkE9IQd119gv+XIEfsLv1OgrqHo+xTpWTXj1waUS1wnb9yflZShgTF8BqOazqjXrtIGoPXyxVd4UxTdvuBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MpZAisasczyv+uMID3fSOA+QVIs2nmA87xkf1ulZM6M=;
 b=Ci8eujPjAIXczjQHEjZqMy99DCJZDAoA84kLq1HB8jz2ovtrzgnfi2+42w4Z2XlQyEyRe+sYVXZFYwuV/GC6KosgX2uS7yOq4blkPqC8EAhnpVMCEFgMc0aKJoCzrpiYKnJfFI5O86J/b8yPr4udYuG7Q3TftCh5ZwRshR6LMk5MjCEthC+YU589VLn7RbI6daTabahGjTlzub6iiG4DL6QVX32zO5FtWkBH5YHyiZLq7fjqdJLDS2qLaoixvYtcnzBmuZYAzHkwLYBU5HEfG0zYoaW4iIl2O5+8c9NuTxIwulO2FNJ//ZnriMmXE7FEHjEdggqv0q+ebuRfcLNzIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MpZAisasczyv+uMID3fSOA+QVIs2nmA87xkf1ulZM6M=;
 b=GPKeIhJ+oQ0goWcWR1NYSIMLzaYgGSyfsAS1J3d6AE6EBCaYhT/3CuTgMjbmcc9NTisrGoGkAmxqSRA57MmvjhqP/6jRBjv/qGJ5pFrxQ4wEheEiVxid3KFhj/tqEGWEI64S5DNZwMGSVCltxKeH/lJVMtr78OWysBiqF9wREYY=
Received: from BL0PR04MB6514.namprd04.prod.outlook.com (2603:10b6:208:1ca::23)
 by MN2PR04MB6446.namprd04.prod.outlook.com (2603:10b6:208:1aa::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17; Fri, 12 Mar
 2021 01:15:21 +0000
Received: from BL0PR04MB6514.namprd04.prod.outlook.com
 ([fe80::e9c5:588:89e:6887]) by BL0PR04MB6514.namprd04.prod.outlook.com
 ([fe80::e9c5:588:89e:6887%3]) with mapi id 15.20.3912.026; Fri, 12 Mar 2021
 01:15:20 +0000
From: Damien Le Moal <Damien.LeMoal@wdc.com>
To: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
CC: "hch@lst.de" <hch@lst.de>, "kbusch@kernel.org" <kbusch@kernel.org>,
 "sagi@grimberg.me" <sagi@grimberg.me>
Subject: Re: [PATCH V12 2/3] nvmet: add ZBD over ZNS backend support
Thread-Topic: [PATCH V12 2/3] nvmet: add ZBD over ZNS backend support
Thread-Index: AQHXFkZtVLB3m5Kiw0yrvZIx/W7awA==
Date: Fri, 12 Mar 2021 01:15:20 +0000
Message-ID: <BL0PR04MB6514B749F68EB412FEC032DDE76F9@BL0PR04MB6514.namprd04.prod.outlook.com>
References: <20210311071530.18680-1-chaitanya.kulkarni@wdc.com>
 <20210311071530.18680-3-chaitanya.kulkarni@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2400:2411:43c0:6000:c1a6:aaec:6201:ec23]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: c6e204ed-ce46-42ce-5229-08d8e4f44e4f
x-ms-traffictypediagnostic: MN2PR04MB6446:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR04MB64461A6DA162C42100F3DF06E76F9@MN2PR04MB6446.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:2582;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jNuLrvF7jvzFI4J/vsc8hLQ8LHcl0rFflCqVw72D9jR/Dom6xSk1ZdD85yz4gleIp6Ym55s0/Y+JROIkW0/z6SF+MbrCV967AWlcqSfU1V2F1LaCGVAxvNYQjzFOtUphRy2Gd2BNagt4VNC7XqComNdLcvBQwz8XOilds5hfxMnBWgIGjTno0PnPr3eaPgSlWS+OWJi2riFx6fBxoSom+zE09MznxtDWT/hYrc94o1VD/umlg82+elc5MyfJEMQJXkOi3rK3enJsukyfI33o0cYjoArO23ZE26saE0BdvOb8qYOv2gxWWUKFcdsv70HArN+fpqOM9BVCwithzM9rsd2bqBFoAbw3I+//YUcgfIxj6/9Ubq3yXLmNXjl07OYnIM6LeIJvR/hCcIJcujcRQHgcJmxaGAZaRRW5pJe7RnK7F+aa6+kZGl3JIrU19Gg6MjXE4Y2Ag6XlzNrYiHMkindmGke/c/ui2wr4qX35UXunhPQoqUzYduUnR5wjMXJnCn88GqQ2V5ngAC/sm+ZpmDIREXNEXoMjExKKWW/7iJGz6LZpRxhCmiw8UmZLIAjT
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR04MB6514.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(39860400002)(366004)(346002)(376002)(136003)(86362001)(2906002)(186003)(54906003)(71200400001)(4326008)(52536014)(66446008)(8936002)(110136005)(64756008)(5660300002)(55016002)(9686003)(316002)(66946007)(53546011)(6506007)(66476007)(83380400001)(66556008)(8676002)(33656002)(76116006)(91956017)(7696005)(30864003)(478600001)(21314003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: =?Windows-1252?Q?aJiCglmrBFSLA6qUQVQOSFl5J8sx5In9Efm5DTIgmiQbaRBiWLA3m+4K?=
 =?Windows-1252?Q?TDSH10qchqO8WX5m9qQ1wQivCzYtmyGoMpPFA4w59IjKMGl0f2CvjV1Z?=
 =?Windows-1252?Q?UKRvxUhFRSiyb1pDs6vBNcpge0xAVOxeFUoez7rz1Q1EDBjIfwiQOWz5?=
 =?Windows-1252?Q?V1luVZR7tbY5QRWZbB6MWEPE11ps+LgjApIZEIpXo5C3MqG5DFKNE3y/?=
 =?Windows-1252?Q?FjkysMnL7V4F8xNsdooFVhe5/dqHXvTuV8CMXsEPra1WQEALemhMjIDm?=
 =?Windows-1252?Q?o0G4LSiRC5BQMEfCdQSUfKS5zUzZ7CKA9e4iSp33VT5liHI5gYw54jiW?=
 =?Windows-1252?Q?/ARX9R6r5n18z2Gvv3MbjJcHbl93tYyEdynja5lm9doo/66NTUveVwSV?=
 =?Windows-1252?Q?JRIhIBXjgf69NiAl+h8luIylkTFVbijXIPZJEZQWgoru4apsmZz7eyG0?=
 =?Windows-1252?Q?hgeBRKqfGuPpHhhIgUeMdM1Pl3dAAHiNL3vVeSMJNvzRwefGyNOvXCtv?=
 =?Windows-1252?Q?+CTpOFfbnKFZ7CEIj7SFtDR/Qk1OFDzZat+nUsQWTZcJLqDpYtGfPEqI?=
 =?Windows-1252?Q?y7TsoZEc671p2WSCGf4TVgxA9t3waMgpVqG/LgCH0H40nle81Nk8MNRK?=
 =?Windows-1252?Q?F2WH6r61qm1opi9giZM76HU8rxdJWLit0Tf/D+oBS9QxJ29WwmuEROUA?=
 =?Windows-1252?Q?JcfZC8YiWd8A+XFo4YJ9B5Dv5HDYiAEhG4+Ck1Aq3SXnhBM/ezi7wTRn?=
 =?Windows-1252?Q?PLAoHeVcjEyFuXyopU4v2LfqfqfFKPIPtA8Imx8NZv1cc8Za0zUXdaFI?=
 =?Windows-1252?Q?YVQz0kHUyI1JFkXY9pASbYfpthO3r4Ab7vSrm1jrORp94++62O/rCkWw?=
 =?Windows-1252?Q?aKB7NZ3M6CqM76fvoJ7Yp+FCRS0HpcfZDgTyDrzR2b4nkPEvayLo5A+I?=
 =?Windows-1252?Q?m/1noMyqtcVaMYI9Z2FnOvNcIpBSKmVCosZeVgUgw+RNdv8ZzngRB70+?=
 =?Windows-1252?Q?SOT3VFWHww1aJTI7pEN38CTPQaOoIGwI2s9GMVPt4w3xcrsrETknmeSN?=
 =?Windows-1252?Q?TQcr2yuu4Zm6p20Gwyc2+BQxhXScdQsxB9n9OxIsZ4G/tyfXxgtmMaK7?=
 =?Windows-1252?Q?meweOxDTD8VOdmD5TGz3ue6AdbDyitWUoGJxJArYH8nTvX9f2NOMG0oB?=
 =?Windows-1252?Q?z4PKhpDAiQmJyFn0xhGHYM3lqey+cJboytXB9satducFkt0yyuKsgkY4?=
 =?Windows-1252?Q?N63GThPh1pko4ukkqd/NBXO5/Z3VqhszRFt5wHcRdd87LwQpbMliK0YH?=
 =?Windows-1252?Q?HTPineqpuBBnAw6z53pbRDmNk3UlH0JrJogsK43nm1xmTmonodzs7oxJ?=
 =?Windows-1252?Q?kyaiczezj8XWx76RFEuHzJ1IONSBZPAlAd6F6bmo8iq99C7ebkCn1dMn?=
 =?Windows-1252?Q?tGj1v8wUnJZZMADdMSaBD4k7Ncn8DhPohBb1LNnv8sE4u2+0zeFgWmE0?=
 =?Windows-1252?Q?I9I382uuwHYYlpIy7zBVmJiMCjRghw=3D=3D?=
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR04MB6514.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6e204ed-ce46-42ce-5229-08d8e4f44e4f
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Mar 2021 01:15:20.8973 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +NY5x8K4k8xJ3ARcjSb1Y0Nhkw3hLkOcfmS1mSCh1qnv/3IU25ujIkr2N/GUOs+yulwUQPor/UVMOaKx49ZCTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB6446
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210312_011526_748227_D3B5BCD2 
X-CRM114-Status: GOOD (  22.00  )
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

On 2021/03/11 16:16, Chaitanya Kulkarni wrote:
> NVMe TP 4053 =96 Zoned Namespaces (ZNS) allows host software to
> communicate with a non-volatile memory subsystem using zones for
> NVMe protocol based controllers. NVMeOF already support the ZNS NVMe
> Protocol compliant devices on the target in the passthru mode. There
> are Generic zoned block devices like  Shingled Magnetic Recording (SMR)
> HDDs that are not based on the NVMe protocol.
> =

> This patch adds ZNS backend to support the ZBDs for NVMeOF target.
> =

> This support includes implementing the new command set NVME_CSI_ZNS,
> adding different command handlers for ZNS command set such as
> NVMe Identify Controller, NVMe Identify Namespace, NVMe Zone Append,
> NVMe Zone Management Send and NVMe Zone Management Receive.
> =

> With new command set identifier we also update the target command
> effects logs to reflect the ZNS compliant commands.
> =

> Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
> ---
>  drivers/nvme/target/Makefile      |   1 +
>  drivers/nvme/target/admin-cmd.c   |  27 +++
>  drivers/nvme/target/io-cmd-bdev.c |  34 ++-
>  drivers/nvme/target/nvmet.h       |  38 ++++
>  drivers/nvme/target/zns.c         | 332 ++++++++++++++++++++++++++++++
>  5 files changed, 424 insertions(+), 8 deletions(-)
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

I do not really understand this comment and I do not think it is useful.
bdev_is_zoned() is always defined, regardless of CONFIG_BLK_DEV_ZONED. If
CONFIG_BLK_DEV_ZONED is not set, you will always get false.

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
> index 000000000000..e12629b02320
> --- /dev/null
> +++ b/drivers/nvme/target/zns.c
> @@ -0,0 +1,332 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * NVMe ZNS-ZBD command implementation.

s/ZBD/zoned block device

"ZBD" is not necessarilly an obvious acronym to everybody.

> + * Copyright (c) 2020-2021 HGST, a Western Digital Company.

This should be:

* Copyright (C) 2021 Western Digital Corporation or its affiliates.

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

s/9/SECTOR_SHIFT

And you could rewrite this as:

return ilog2(zone_append_sects >> (NVMET_MPSMIN_SHIFT - SECTOR_SHIFT));

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
> +	ns->blksize_shift =3D blksize_bits(bdev_logical_block_size(ns->bdev));
> +
> +	if (!nvmet_zns_update_zasl(ns))
> +		return false;
> +
> +	return !(get_capacity(ns->bdev->bd_disk) &
> +			(bdev_zone_sectors(ns->bdev) - 1));

It may be good to add a comment above this one as it is not necessarilly
obvious. Something like:

/*
 * Generic zoned block devices may have a smaller last zone which is
 * not supported by ZNS. Excludes zoned drives that have such smaller
 * last zone.
 */

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

s/9/SECTOR_SHIFT

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
> +	if (!nr_zones) {
> +		status =3D NVME_SC_INVALID_FIELD | NVME_SC_DNR;
> +		goto out_free_report_zones;
> +	}
> +
> +	reported_zones =3D blkdev_report_zones(req->ns->bdev, sect, nr_zones,
> +					     nvmet_bdev_report_zone_cb, &data);
> +	if (reported_zones < 0) {
> +		status =3D NVME_SC_INTERNAL;
> +		goto out_free_report_zones;
> +	}

There is a problem here: the code as is ignores the request reporting option
field which can lead to an invalid zone report being returned. I think you =
need
to modify nvmet_bdev_report_zone_cb() to look at the reporting option field
passed by the initiator and filter the zone report since blkdev_report_zone=
s()
does not handle that argument.

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

What is the point of the "!zsa_to_op[zsa]" here ? All the REQ_OP_ZONE_XXX a=
re
non 0, always...

> +		status =3D NVME_SC_INVALID_FIELD;
> +		goto out;
> +	}
> +
> +	op =3D zsa_to_op[zsa];
> +
> +	if (req->cmd->zms.select_all)
> +		nr_sect =3D get_capacity(req->ns->bdev->bd_disk);
If select_all is set, sect must be ignored, so you need to have something l=
ike this:

	if (req->cmd->zms.select_all) {
		sect =3D 0;
		nr_sect =3D get_capacity(req->ns->bdev->bd_disk);
	} else {
		sect =3D nvmet_lba_to_sect(req->ns, req->cmd->zms.slba);
		nr_sect =3D bdev_zone_sectors(req->ns->bdev);
	}

Easier to read. Also may be rename nr_sect to nr_sects (plural).

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

No nvmet_req_complete() call ? Is that done in nvmet_check_transfer_len() ?

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

submit_bio_wait() ? Why blocking here ? That would be bad for performance. =
Is it
mandatory to block here ? The result handling could be done in the bio_end
callback no ?

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
