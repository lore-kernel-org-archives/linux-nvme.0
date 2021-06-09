Return-Path: <SRS0=Wy35=LD=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 677DBC47095
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Jun 2021 09:51:54 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F42C61042
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Jun 2021 09:51:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F42C61042
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=MYmg7Cni3oFh2ZJHXkZwiRRKq3bqa6xRdjPhv+NAf0Y=; b=UcyJxKRbrC3qnV
	xtlmgRZPqgA6ixCHrqfqb3hNJPHyncIsrLSziDTUiwqsRkFebULmq3vyxBOFaXDjer+KRn8cj3tp5
	esm2WKlq+benlawrlID+oy6xQ9EmIphnVO47cwmw3/wMR1mCeRGS87hTD2NSKiXUCWy7rbUhGRaxc
	fdLK91Kc0QAsV+LjZIAItRpw/doHpQZRQZMQQ9Q2fs22uaau2GqHBq+qJyXyLfGtGPo4cx65Pn2IU
	dBactfAKvSVjEtrlr3JMcQXrVwGcgpkemKOS7vdw6rci32ColOaXINMtHYEO9maWqFuWgRRExva+r
	lesv+wSj9NL5bF0bw0fg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lqus3-00CntN-6i; Wed, 09 Jun 2021 09:51:35 +0000
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lqul7-00ClkZ-8w
 for linux-nvme@lists.infradead.org; Wed, 09 Jun 2021 09:44:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1623231863; x=1654767863;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=OVSHawFCgo4i7FloPnMAPMxgO84A4uuu17+ot5AnsO0=;
 b=pYLHVaCTMXrY0mqP2ZOAlgIaUfsAtRMYujzGZ3EJdw9Jaxqjjc+5/yFR
 QdRt93a8fWMAfrVWjgs6KqsjVRg6hpyoTBSKhtIr59AukKpc1CGN7EF1c
 fDrcHDI6fERvbmat3w0GPOojbFYQ8Lzl7S6s9U9XBozUttuYKJZx17vcw
 NMFKt4YnKe3VQBkTStA4koIA7Eu7lJapAtyER5urcqbDwjkmMeglZ4SNa
 ghsqGvpVzcffANIbzZAWyi7rzR/kvauUikyrkqrysXQDiSJQ9pTrAT/6m
 BU/J3o2rCWQw7bHoArrggmnObXHyjaEcx9OReJcym8PS6ydVSLjcBBr5A w==;
IronPort-SDR: zaKEAffJyQ9dIeuYCCPp/1atbG6TCAtj2bLCFD/Fvj6EabHmRXL/JPbsLXmJLn/2DG3Hugx5WX
 MZ8Axwu5EFEJV8k8chDASRCNRL5G6NlkgBDsEkuu9r6gfV2fW2T04t0bKz44s56CKQFM1pKJRB
 S0/sitEa3RLVOmSzqy9pWMTiBuGs+zC+JfFU9Ew5GdLcIgOxhWhlsYK+nWBT438AGebRmcieRZ
 hM/1sll1q5J/7LpueohS/jIPiiOEYf80t87PundsyKF5Qbagb/RYE5anrbxOam36nkgQoraG9t
 goE=
X-IronPort-AV: E=Sophos;i="5.83,260,1616428800"; d="scan'208";a="171283882"
Received: from mail-dm6nam12lp2174.outbound.protection.outlook.com (HELO
 NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.174])
 by ob1.hgst.iphmx.com with ESMTP; 09 Jun 2021 17:44:23 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S3EDgXJOjg6sW2Ce9NkJ0+MLFBRzkBCcBkkUxVb+eBB7HNoHun+EE8NiRmazdGQuZckMqUaXLeSL/v4Fl/Nvwwlbq7cdKqb8iZqGp3tYMJViMq5UR+RtNJDJhuHnXxcqveeDDY309IRDSf70utVjqt0o3ldJt7tZHEFZCKVbBE1es697bH7OCFkiCRiuTrECGWKhxAV2ktnKrM7ZZU02wnt9jWUKbFvuJuLIYAUBpg68alDB1zSkRrMRi0xuzMJ76+aR8JpIvykijRKZusUEpvxQUSU6zG7pRJo+FJGLE/zCdH6NRDSVV/mXewBtMvqFVxdjJ1MIzyG34j1tI3/fCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oUafBtyONKNha2XY2dEhAZJawd/6t5dRjyfhvnoh5Lo=;
 b=bfTiLkksqHt+azJS2+pwnZSUCrw4koq35oGYaAogU3cePQLG+kYIi7Qki3YtcxbFRIdXL1V9CUqVPbIvd7s7Ey0e8mbwJr22cAVf4hUQUf/zpa8XtdObnh5+rdcO4XrRcnPxdStjuOWOweT6ZJwA05OT5k2a505caARgyhK+V+BLb1PvV2X8YmiaGitwPZldcoIF4ZjDj2O+PVU4zHXEB1a5HKt1gxz1Kdu/mh+upD+gaROcKR4dzmzb/EGJx6Hd5isqyYWOv8+q+tVDFDsMHVm3/h/UcCNxLzUWD8+qUltRnJhb2XjgqRlbcc5PhEqKMkl5RoN5Q1fcB5xGNxteAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oUafBtyONKNha2XY2dEhAZJawd/6t5dRjyfhvnoh5Lo=;
 b=ZIyHpbhIOZ3JRprrmesZ/aP5Q2kPC5sEPT1LnH0TUkESeMy9tcZunjSC8X0//WIW8VW48BTTfA7ao/07y08MnFkXVyMrrN02zvAVJ2DlC5tI1/nhIVl3icp0ZK4yRrJgX7HOuftGGhs8XI8epPeHqfMll2ihhJQuOtdOQ0xG59k=
Received: from DM6PR04MB7081.namprd04.prod.outlook.com (2603:10b6:5:244::21)
 by DM6PR04MB4924.namprd04.prod.outlook.com (2603:10b6:5:f9::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.27; Wed, 9 Jun
 2021 09:44:21 +0000
Received: from DM6PR04MB7081.namprd04.prod.outlook.com
 ([fe80::64f9:51d2:1e04:f806]) by DM6PR04MB7081.namprd04.prod.outlook.com
 ([fe80::64f9:51d2:1e04:f806%9]) with mapi id 15.20.4195.030; Wed, 9 Jun 2021
 09:44:21 +0000
From: Damien Le Moal <Damien.LeMoal@wdc.com>
To: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
CC: "hch@lst.de" <hch@lst.de>
Subject: Re: [PATCH 5/5] nvmet: add ZBD over ZNS backend support
Thread-Topic: [PATCH 5/5] nvmet: add ZBD over ZNS backend support
Thread-Index: AQHXXCnCMCFVcQvks0C8t/tDqJ7YjA==
Date: Wed, 9 Jun 2021 09:44:21 +0000
Message-ID: <DM6PR04MB7081372FC5AB2D825F3372DAE7369@DM6PR04MB7081.namprd04.prod.outlook.com>
References: <20210608054635.5661-1-chaitanya.kulkarni@wdc.com>
 <20210608054635.5661-6-chaitanya.kulkarni@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2400:2411:43c0:6000:513e:a3fe:98aa:a7ae]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fac2d82b-4d73-4844-3aa3-08d92b2b28c2
x-ms-traffictypediagnostic: DM6PR04MB4924:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR04MB4924634368FD16FA7D494C82E7369@DM6PR04MB4924.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: odFJkS5nhWpzOnqHzGTbgNnDfk/KwQlJhYXOItNvSETfdsLe4gCWdLy8EZXCfjYZho9DuIl3uvcfwt1Ypo7i2wapOVgZ9giRpEAKYsBVQwAcxjOfIw3HpLT85MbFpwkA1ULFqZjasjhcxz8XEczXVoQgmU50/7/pR31L+D247rp/BNr/MPZcRjqHlZKSpETU2vM4JqIKHK8xJr32As7qeDMQob6lbkjEWaMrY65rj3sOkhzz35Y+0nfslfQvyjrJD3FjgVXgtN7uCxU6Fq9dn3u3tDFljX4JBy6wKNl3gGWe/v6j11DVXdJFunIHa1+Zyqd++Uq1XCo8HoykoS2lpA3B9EG6AycTwacbi3KRWmxrRchxF5ub5Vo2sq81Oil+Hv89MFoO/nCaigtfUVif49AUPnnUe+5jLhTRCtRlvGe7ARxFVLldsbZ9PMLBMJmwEVYGSqeCs7OPMXfyRcWYBlhdDVex6lPHePMz48L5/nRIE40giAk85am2ItD3gaEtq1iMraRvTEJ7if82B/3C1kpU0HAFNdgEQcSk8ShybbhS5CfJ8lxZglpRGYM8A3oRAJBugvGwUIeXdfGiJL/5aZ7IO8sHAxwJ2zFEqqKF+rQ=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR04MB7081.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(366004)(136003)(376002)(346002)(396003)(86362001)(122000001)(7696005)(83380400001)(66556008)(38100700002)(6506007)(53546011)(186003)(66476007)(76116006)(64756008)(66946007)(91956017)(9686003)(33656002)(478600001)(4326008)(5660300002)(55016002)(71200400001)(52536014)(66446008)(110136005)(8676002)(2906002)(8936002)(30864003)(316002)(579004)(559001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?Windows-1252?Q?Cq6tZ80JWgGrSKah99eyWt7i0lwZnQfqacqbwfZGLlB1LyDNiFZHDIn0?=
 =?Windows-1252?Q?PLWh00cdstiYSbtRoZOa4BIfNG72oriLrQmFyP641iVQWkrhCbGXw6Us?=
 =?Windows-1252?Q?abHhQF8ts0EY5MOMmD4LrStroNIbl2aSCVBZOeF7FGWrLoNqB86X7zr9?=
 =?Windows-1252?Q?LusM0puLrWkWnpEypfH0eo75/j7+AA5Z/IjJ2s7dX4d5KmHikG3Oh+bK?=
 =?Windows-1252?Q?e5H/hboIxU7jsukf2XTzNJk+tUFwe6QVUrI9oUfRgCKelc+RqYS3Lyq4?=
 =?Windows-1252?Q?wyBvuHFLRXKEAEdL+/2b/HWzSpBvnat3aIdymd6MsIgU2jklH2ptAbMj?=
 =?Windows-1252?Q?aT8JV6YP/9iP6auO1iXtzVk6P2VQPnuqmR3ejYCZ2JqimtdCLratPODR?=
 =?Windows-1252?Q?sGJXgTlbu23btsEs7iXl6vxnmNb90G7I2Hv8r1lAc38aiXbna0Z2fWjK?=
 =?Windows-1252?Q?XQGJRkz31SF5I54T5rmnQCI1gLmO1RN/lzS8jJEGw9GG+uByS2fwk4xv?=
 =?Windows-1252?Q?+nJKA6RBVhZnKtFezfHDvBirEGBdgAxEJnVKogLOjsy/8+s2sm2A/kze?=
 =?Windows-1252?Q?m0XgeeczoNgHKKD+FZuM+G1431/HcDXI8V65JkSzfmhqGwo6JOxQ0/XI?=
 =?Windows-1252?Q?W4eK5hdfiKenigNH/em4ZqKH6yNgRE0vCQ2wIck9Ns79ODEMfd3mBjtV?=
 =?Windows-1252?Q?yhUWqSrFf6beULuyN0ohCPb67FO9v+qnqnnniM7+61bY9EZjfDwGUiy5?=
 =?Windows-1252?Q?kfZaBkNFaKzXOppRBkZgx+jhMZ5koXUo5mqdstcj14MCOcabL4je+S1a?=
 =?Windows-1252?Q?cu4yHihi9SWchfHcgAyM44BjT4nYzDMJ9Po/3CK7OTVN2eFCWxGS3Ig8?=
 =?Windows-1252?Q?BhUNRoNBLIT/E8p3dLgqPdXeybfCbEGB3DavwymKY33/eAyUq4utp1a0?=
 =?Windows-1252?Q?+A2uTCq5NYa+Mu0Y2TTUrBtQmNKtczXG5uxqIZUNVQ1F4BCSB4GDuDwx?=
 =?Windows-1252?Q?LBfYNxPKIGieoPmA84tBc15iUOOBy6xaXHlzwVmODcF3UHDAfUBVI0da?=
 =?Windows-1252?Q?3oSXlLmH+fjCC1SXeSpN//28cZkOpkr7JFFjNbfM0fX9IMyuYGCR3IHu?=
 =?Windows-1252?Q?rP8UZJnYE4dPO1bCNvO/NM3OOoCruk4NVSOqWcdJXFI7M4sjPbdV1I07?=
 =?Windows-1252?Q?Gjg8movnNdtTgf/zspuewSgvoKpYxHgoJEJbvJWEy6sU3xdRu8RO5tEX?=
 =?Windows-1252?Q?Xcw3bvhjNb3MIMplYjkNGSbPkaTHrgS2208mBluvp1Tbj0utSULjHsaQ?=
 =?Windows-1252?Q?+wCZFTDZxR5lHbAVZpUeerWpMoUIkpta98p9vQ6Ulx3tn7QQk+jHn5/C?=
 =?Windows-1252?Q?w+yiOKettYEAFCbq/fdHRFumMXFHNn0U8x+xKVWFup5atqy4DKgfRojg?=
 =?Windows-1252?Q?lhVjHYLaegbIn9B4pNkfF+ySHCfLdzt1uofiO9CTd6Pa+hhvBJDkbmFf?=
 =?Windows-1252?Q?djI6yBAAu8/JWJ8E+zglN//geb9E6w=3D=3D?=
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB7081.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fac2d82b-4d73-4844-3aa3-08d92b2b28c2
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jun 2021 09:44:21.5906 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lrn7m3VOSbl66hzUlITksY/igUEd//x8z23jbkuNXEtZeFrY3AfcAqG1tyKOJMpTCyDtGuNrMrl4WL3LjgF1FQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB4924
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210609_024425_442015_D306175D 
X-CRM114-Status: GOOD (  22.32  )
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

On 2021/06/08 14:47, Chaitanya Kulkarni wrote:
> NVMe TP 4053 =96 Zoned Namespaces (ZNS) allows host software to
> communicate with a non-volatile memory subsystem using zones for NVMe
> protocol-based controllers. NVMeOF already support the ZNS NVMe
> Protocol compliant devices on the target in the passthru mode. There
> are generic zoned block devices like  Shingled Magnetic Recording (SMR)
> HDDs that are not based on the NVMe protocol.
> =

> This patch adds ZNS backend support for non-ZNS zoned block devices as
> NVMeOF targets.
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
>  drivers/nvme/target/admin-cmd.c   |  41 ++
>  drivers/nvme/target/core.c        |  15 +-
>  drivers/nvme/target/io-cmd-bdev.c |  26 +-
>  drivers/nvme/target/nvmet.h       |  20 +
>  drivers/nvme/target/zns.c         | 622 ++++++++++++++++++++++++++++++
>  include/linux/nvme.h              |   7 +
>  7 files changed, 721 insertions(+), 11 deletions(-)
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
> index 118b81a34bbb..72470e815146 100644
> --- a/drivers/nvme/target/admin-cmd.c
> +++ b/drivers/nvme/target/admin-cmd.c
> @@ -179,6 +179,13 @@ static void nvmet_get_cmd_effects_nvm(struct nvme_ef=
fects_log *log)
>  	log->iocs[nvme_cmd_write_zeroes]	=3D cpu_to_le32(1 << 0);
>  }
>  =

> +static void nvmet_get_cmd_effects_zns(struct nvme_effects_log *log)
> +{
> +	log->iocs[nvme_cmd_zone_append]		=3D cpu_to_le32(1 << 0);
> +	log->iocs[nvme_cmd_zone_mgmt_send]	=3D cpu_to_le32(1 << 0);
> +	log->iocs[nvme_cmd_zone_mgmt_recv]	=3D cpu_to_le32(1 << 0);
> +}
> +
>  static void nvmet_execute_get_log_cmd_effects_ns(struct nvmet_req *req)
>  {
>  	struct nvme_effects_log *log;
> @@ -194,6 +201,14 @@ static void nvmet_execute_get_log_cmd_effects_ns(str=
uct nvmet_req *req)
>  	case NVME_CSI_NVM:
>  		nvmet_get_cmd_effects_nvm(log);
>  		break;
> +	case NVME_CSI_ZNS:
> +		if (!IS_ENABLED(CONFIG_BLK_DEV_ZONED)) {
> +			status =3D NVME_SC_INVALID_IO_CMD_SET;
> +			goto free;
> +		}
> +		nvmet_get_cmd_effects_nvm(log);
> +		nvmet_get_cmd_effects_zns(log);
> +		break;
>  	default:
>  		status =3D NVME_SC_INVALID_LOG_PAGE;
>  		goto free;
> @@ -669,6 +684,12 @@ static bool nvmet_handle_identify_desclist(struct nv=
met_req *req)
>  	case NVME_CSI_NVM:
>  		nvmet_execute_identify_desclist(req);
>  		return true;
> +	case NVME_CSI_ZNS:
> +		if (IS_ENABLED(CONFIG_BLK_DEV_ZONED)) {
> +			nvmet_execute_identify_desclist(req);
> +			return true;
> +		}
> +		return false;
>  	default:
>  		return false;
>  	}
> @@ -688,12 +709,32 @@ static void nvmet_execute_identify(struct nvmet_req=
 *req)
>  			break;
>  		}
>  		break;
> +	case NVME_ID_CNS_CS_NS:
> +		if (IS_ENABLED(CONFIG_BLK_DEV_ZONED)) {
> +			switch (req->cmd->identify.csi) {
> +			case NVME_CSI_ZNS:
> +				return nvmet_execute_identify_cns_cs_ns(req);
> +			default:
> +				break;
> +			}
> +		}
> +		break;
>  	case NVME_ID_CNS_CTRL:
>  		switch (req->cmd->identify.csi) {
>  		case NVME_CSI_NVM:
>  			return nvmet_execute_identify_ctrl(req);
>  		}
>  		break;
> +	case NVME_ID_CNS_CS_CTRL:
> +		if (IS_ENABLED(CONFIG_BLK_DEV_ZONED)) {
> +			switch (req->cmd->identify.csi) {
> +			case NVME_CSI_ZNS:
> +				return nvmet_execute_identify_cns_cs_ctrl(req);
> +			default:
> +				break;
> +			}
> +		}
> +		break;
>  	case NVME_ID_CNS_NS_ACTIVE_LIST:
>  		switch (req->cmd->identify.csi) {
>  		case NVME_CSI_NVM:
> diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
> index 7ee9418cd9b6..3ca85e948fc4 100644
> --- a/drivers/nvme/target/core.c
> +++ b/drivers/nvme/target/core.c
> @@ -16,6 +16,7 @@
>  #include "nvmet.h"
>  =

>  struct workqueue_struct *buffered_io_wq;
> +struct workqueue_struct *zbd_wq;
>  static const struct nvmet_fabrics_ops *nvmet_transports[NVMF_TRTYPE_MAX];
>  static DEFINE_IDA(cntlid_ida);
>  =

> @@ -893,6 +894,10 @@ static u16 nvmet_parse_io_cmd(struct nvmet_req *req)
>  		if (req->ns->file)
>  			return nvmet_file_parse_io_cmd(req);
>  		return nvmet_bdev_parse_io_cmd(req);
> +	case NVME_CSI_ZNS:
> +		if (IS_ENABLED(CONFIG_BLK_DEV_ZONED))
> +			return nvmet_bdev_zns_parse_io_cmd(req);
> +		return NVME_SC_INVALID_IO_CMD_SET;
>  	default:
>  		return NVME_SC_INVALID_IO_CMD_SET;
>  	}
> @@ -1587,11 +1592,15 @@ static int __init nvmet_init(void)
>  =

>  	nvmet_ana_group_enabled[NVMET_DEFAULT_ANA_GRPID] =3D 1;
>  =

> +	zbd_wq =3D alloc_workqueue("nvmet-zbd-wq", WQ_MEM_RECLAIM, 0);
> +	if (!zbd_wq)
> +		return -ENOMEM;
> +
>  	buffered_io_wq =3D alloc_workqueue("nvmet-buffered-io-wq",
>  			WQ_MEM_RECLAIM, 0);
>  	if (!buffered_io_wq) {
>  		error =3D -ENOMEM;
> -		goto out;
> +		goto out_free_zbd_work_queue;
>  	}
>  =

>  	error =3D nvmet_init_discovery();
> @@ -1607,7 +1616,8 @@ static int __init nvmet_init(void)
>  	nvmet_exit_discovery();
>  out_free_work_queue:
>  	destroy_workqueue(buffered_io_wq);
> -out:
> +out_free_zbd_work_queue:
> +	destroy_workqueue(zbd_wq);
>  	return error;
>  }
>  =

> @@ -1617,6 +1627,7 @@ static void __exit nvmet_exit(void)
>  	nvmet_exit_discovery();
>  	ida_destroy(&cntlid_ida);
>  	destroy_workqueue(buffered_io_wq);
> +	destroy_workqueue(zbd_wq);
>  =

>  	BUILD_BUG_ON(sizeof(struct nvmf_disc_rsp_page_entry) !=3D 1024);
>  	BUILD_BUG_ON(sizeof(struct nvmf_disc_rsp_page_hdr) !=3D 1024);
> diff --git a/drivers/nvme/target/io-cmd-bdev.c b/drivers/nvme/target/io-c=
md-bdev.c
> index 40534d9a86d1..57f619aa7cba 100644
> --- a/drivers/nvme/target/io-cmd-bdev.c
> +++ b/drivers/nvme/target/io-cmd-bdev.c
> @@ -47,6 +47,14 @@ void nvmet_bdev_set_limits(struct block_device *bdev, =
struct nvme_id_ns *id)
>  	id->nows =3D to0based(ql->io_opt / ql->logical_block_size);
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
>  static void nvmet_bdev_ns_enable_integrity(struct nvmet_ns *ns)
>  {
>  	struct blk_integrity *bi =3D bdev_get_integrity(ns->bdev);
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

> diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
> index f709238014f5..a105982e8f8a 100644
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
> @@ -333,6 +337,12 @@ struct nvmet_req {
>  			struct work_struct      work;
>  			bool			use_workqueue;
>  		} p;
> +#ifdef CONFIG_BLK_DEV_ZONED
> +		struct {
> +			struct bio		inline_bio;
> +			struct work_struct	zmgmt_work;
> +		} z;
> +#endif /* CONFIG_BLK_DEV_ZONED */
>  	};
>  	int			sg_cnt;
>  	int			metadata_sg_cnt;
> @@ -352,6 +362,7 @@ struct nvmet_req {
>  };
>  =

>  extern struct workqueue_struct *buffered_io_wq;
> +extern struct workqueue_struct *zbd_wq;
>  =

>  static inline void nvmet_set_result(struct nvmet_req *req, u32 result)
>  {
> @@ -401,6 +412,7 @@ u16 nvmet_parse_connect_cmd(struct nvmet_req *req);
>  void nvmet_bdev_set_limits(struct block_device *bdev, struct nvme_id_ns =
*id);
>  u16 nvmet_bdev_parse_io_cmd(struct nvmet_req *req);
>  u16 nvmet_file_parse_io_cmd(struct nvmet_req *req);
> +u16 nvmet_bdev_zns_parse_io_cmd(struct nvmet_req *req);
>  u16 nvmet_parse_admin_cmd(struct nvmet_req *req);
>  u16 nvmet_parse_discovery_cmd(struct nvmet_req *req);
>  u16 nvmet_parse_fabrics_cmd(struct nvmet_req *req);
> @@ -528,6 +540,14 @@ void nvmet_ns_changed(struct nvmet_subsys *subsys, u=
32 nsid);
>  void nvmet_bdev_ns_revalidate(struct nvmet_ns *ns);
>  int nvmet_file_ns_revalidate(struct nvmet_ns *ns);
>  void nvmet_ns_revalidate(struct nvmet_ns *ns);
> +u16 blk_to_nvme_status(struct nvmet_req *req, blk_status_t blk_sts);
> +
> +bool nvmet_bdev_zns_enable(struct nvmet_ns *ns);
> +void nvmet_execute_identify_cns_cs_ctrl(struct nvmet_req *req);
> +void nvmet_execute_identify_cns_cs_ns(struct nvmet_req *req);
> +void nvmet_bdev_execute_zone_mgmt_recv(struct nvmet_req *req);
> +void nvmet_bdev_execute_zone_mgmt_send(struct nvmet_req *req);
> +void nvmet_bdev_execute_zone_append(struct nvmet_req *req);
>  =

>  static inline u32 nvmet_rw_data_len(struct nvmet_req *req)
>  {
> diff --git a/drivers/nvme/target/zns.c b/drivers/nvme/target/zns.c
> new file mode 100644
> index 000000000000..34135cbdd7e5
> --- /dev/null
> +++ b/drivers/nvme/target/zns.c
> @@ -0,0 +1,622 @@
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
> +static inline u8 nvmet_zasl(unsigned int zone_append_sects)
> +{
> +	/*
> +	 * Zone Append Size Limit (zasl) is expressed as a power of 2 value
> +	 * with the minimum memory page size (i.e. 12) as unit.
> +	 */
> +	return ilog2(zone_append_sects >> (NVMET_MPSMIN_SHIFT - 9));
> +}
> +
> +static int validate_conv_zones_cb(struct blk_zone *z,
> +				  unsigned int i, void *data)
> +{
> +	if (z->type =3D=3D BLK_ZONE_TYPE_CONVENTIONAL)
> +		return -EOPNOTSUPP;
> +	return 0;
> +}
> +
> +bool nvmet_bdev_zns_enable(struct nvmet_ns *ns)
> +{
> +	struct request_queue *q =3D ns->bdev->bd_disk->queue;
> +	u8 zasl =3D nvmet_zasl(queue_max_zone_append_sectors(q));
> +	struct gendisk *bd_disk =3D ns->bdev->bd_disk;
> +	int ret;
> +
> +	if (ns->subsys->zasl) {
> +		if (ns->subsys->zasl > zasl)
> +			return false;
> +	}
> +	ns->subsys->zasl =3D zasl;
> +
> +	/*
> +	 * Generic zoned block devices may have a smaller last zone which is
> +	 * not supported by ZNS. Exclude zoned drives that have such smaller
> +	 * last zone.
> +	 */
> +	if (get_capacity(bd_disk) & (bdev_zone_sectors(ns->bdev) - 1))
> +		return false;
> +	/*
> +	 * ZNS does not define a conventional zone type. If the underlying
> +	 * device has a bitmap set indicating the existence of conventional
> +	 * zones, reject the device. Otherwise, use report zones to detect if
> +	 * the device has conventional zones.
> +	 */
> +	if (ns->bdev->bd_disk->queue->conv_zones_bitmap)
> +		return false;
> +
> +	ret =3D blkdev_report_zones(ns->bdev, 0, blkdev_nr_zones(bd_disk),
> +				  validate_conv_zones_cb, NULL);
> +	if (ret < 0)
> +		return false;
> +
> +	ns->blksize_shift =3D blksize_bits(bdev_logical_block_size(ns->bdev));
> +
> +	return true;
> +}
> +
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
> +	u64 zsze;
> +	u16 status;
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
> +static u16 nvmet_bdev_validate_zone_mgmt_recv(struct nvmet_req *req)
> +{
> +	sector_t sect =3D nvmet_lba_to_sect(req->ns, req->cmd->zmr.slba);
> +	u32 out_bufsize =3D (le32_to_cpu(req->cmd->zmr.numd) + 1) << 2;
> +
> +	if (sect >=3D get_capacity(req->ns->bdev->bd_disk)) {
> +		req->error_loc =3D offsetof(struct nvme_zone_mgmt_recv_cmd, slba);
> +		return NVME_SC_LBA_RANGE | NVME_SC_DNR;
> +	}
> +
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
> +struct nvmet_report_zone_data {
> +	struct nvmet_req *req;
> +	u64 out_buf_offset;
> +	u64 out_nr_zones;
> +	u64 nr_zones;
> +	u8 zrasf;
> +};
> +
> +static int nvmet_bdev_report_zone_cb(struct blk_zone *z, unsigned i, voi=
d *d)
> +{
> +	static const unsigned int nvme_zrasf_to_blk_zcond[] =3D {
> +		[NVME_ZRASF_ZONE_STATE_EMPTY]	 =3D BLK_ZONE_COND_EMPTY,
> +		[NVME_ZRASF_ZONE_STATE_IMP_OPEN] =3D BLK_ZONE_COND_IMP_OPEN,
> +		[NVME_ZRASF_ZONE_STATE_EXP_OPEN] =3D BLK_ZONE_COND_EXP_OPEN,
> +		[NVME_ZRASF_ZONE_STATE_CLOSED]	 =3D BLK_ZONE_COND_CLOSED,
> +		[NVME_ZRASF_ZONE_STATE_READONLY] =3D BLK_ZONE_COND_READONLY,
> +		[NVME_ZRASF_ZONE_STATE_FULL]	 =3D BLK_ZONE_COND_FULL,
> +		[NVME_ZRASF_ZONE_STATE_OFFLINE]	 =3D BLK_ZONE_COND_OFFLINE,
> +	};
> +	struct nvmet_report_zone_data *rz =3D d;
> +
> +	if (rz->zrasf !=3D NVME_ZRASF_ZONE_REPORT_ALL &&
> +	    z->cond !=3D nvme_zrasf_to_blk_zcond[rz->zrasf])
> +		return 0;
> +
> +	if (rz->nr_zones < rz->out_nr_zones) {
> +		struct nvme_zone_descriptor zdesc =3D { };
> +		u16 status;
> +
> +		zdesc.zcap =3D nvmet_sect_to_lba(rz->req->ns, z->capacity);
> +		zdesc.zslba =3D nvmet_sect_to_lba(rz->req->ns, z->start);
> +		zdesc.wp =3D nvmet_sect_to_lba(rz->req->ns, z->wp);
> +		zdesc.za =3D z->reset ? 1 << 2 : 0;
> +		zdesc.zs =3D z->cond << 4;
> +		zdesc.zt =3D z->type;
> +
> +		status =3D nvmet_copy_to_sgl(rz->req, rz->out_buf_offset, &zdesc,
> +					   sizeof(zdesc));
> +		if (status)
> +			return -EINVAL;
> +
> +		rz->out_buf_offset +=3D sizeof(zdesc);
> +	}
> +
> +	rz->nr_zones++;
> +
> +	return 0;
> +}
> +
> +static unsigned long nvmet_req_nr_zones_from_slba(struct nvmet_req *req)
> +{
> +	unsigned int sect =3D nvmet_lba_to_sect(req->ns, req->cmd->zmr.slba);
> +
> +	return blkdev_nr_zones(req->ns->bdev->bd_disk) -
> +		(sect >> ilog2(bdev_zone_sectors(req->ns->bdev)));
> +}
> +
> +static unsigned long get_nr_zones_from_buf(struct nvmet_req *req, u32 bu=
fsize)
> +{
> +	if (bufsize <=3D sizeof(struct nvme_zone_report))
> +		return 0;
> +
> +	return (bufsize - sizeof(struct nvme_zone_report)) /
> +		sizeof(struct nvme_zone_descriptor);
> +}
> +
> +void nvmet_bdev_zone_zmgmt_recv_work(struct work_struct *w)
> +{
> +	struct nvmet_req *req =3D container_of(w, struct nvmet_req, z.zmgmt_wor=
k);
> +	sector_t start_sect =3D nvmet_lba_to_sect(req->ns, req->cmd->zmr.slba);
> +	unsigned long req_slba_nr_zones =3D nvmet_req_nr_zones_from_slba(req);
> +	u32 out_bufsize =3D (le32_to_cpu(req->cmd->zmr.numd) + 1) << 2;
> +	__le64 nr_zones;
> +	u16 status;
> +	int ret;
> +	struct nvmet_report_zone_data rz_data =3D {
> +		.out_nr_zones =3D get_nr_zones_from_buf(req, out_bufsize),
> +		/* leave the place for report zone header */
> +		.out_buf_offset =3D sizeof(struct nvme_zone_report),
> +		.zrasf =3D req->cmd->zmr.zrasf,
> +		.nr_zones =3D 0,
> +		.req =3D req,
> +	};
> +
> +	status =3D nvmet_bdev_validate_zone_mgmt_recv(req);
> +	if (status)
> +		goto out;
> +
> +	if (!req_slba_nr_zones) {
> +		status =3D NVME_SC_SUCCESS;
> +		goto out;
> +	}
> +
> +	ret =3D blkdev_report_zones(req->ns->bdev, start_sect, req_slba_nr_zone=
s,
> +				 nvmet_bdev_report_zone_cb, &rz_data);
> +	if (ret < 0) {
> +		status =3D NVME_SC_INTERNAL;
> +		goto out;
> +	}
> +
> +	/*
> +	 * When partial bit is set nr_zones must indicate the number of zone
> +	 * descriptors actually transferred.
> +	 */
> +	if (req->cmd->zmr.pr)
> +		rz_data.nr_zones =3D min(rz_data.nr_zones, rz_data.out_nr_zones);
> +
> +	nr_zones =3D cpu_to_le64(rz_data.nr_zones);
> +	status =3D nvmet_copy_to_sgl(req, 0, &nr_zones, sizeof(nr_zones));
> +
> +out:
> +	nvmet_req_complete(req, status);
> +}
> +
> +void nvmet_bdev_execute_zone_mgmt_recv(struct nvmet_req *req)
> +{
> +	INIT_WORK(&req->z.zmgmt_work, nvmet_bdev_zone_zmgmt_recv_work);
> +	queue_work(zbd_wq, &req->z.zmgmt_work);
> +}
> +
> +static inline enum req_opf zsa_req_op(u8 zsa)
> +{
> +	switch (zsa) {
> +	case NVME_ZONE_OPEN:
> +		return REQ_OP_ZONE_OPEN;
> +	case NVME_ZONE_CLOSE:
> +		return REQ_OP_ZONE_CLOSE;
> +	case NVME_ZONE_FINISH:
> +		return REQ_OP_ZONE_FINISH;
> +	case NVME_ZONE_RESET:
> +		return REQ_OP_ZONE_RESET;
> +	default:
> +		return REQ_OP_LAST;
> +	}
> +}
> +
> +static u16 blkdev_zone_mgmt_errno_to_nvme_status(int ret)
> +{
> +	switch (ret) {
> +	case 0:
> +		return NVME_SC_SUCCESS;
> +	case -EINVAL:
> +	case -EIO:
> +		return NVME_SC_ZONE_INVALID_TRANSITION | NVME_SC_DNR;
> +	default:
> +		return NVME_SC_INTERNAL;
> +	}
> +}
> +
> +struct nvmet_zone_mgmt_send_all_data {
> +	unsigned long *zbitmap;
> +	struct nvmet_req *req;
> +};
> +
> +static int zmgmt_send_scan_cb(struct blk_zone *z, unsigned i, void *d)
> +{
> +	struct nvmet_zone_mgmt_send_all_data *data =3D d;
> +
> +	switch (zsa_req_op(data->req->cmd->zms.zsa)) {
> +	case REQ_OP_ZONE_OPEN:
> +		switch (z->cond) {
> +		case BLK_ZONE_COND_CLOSED:
> +			break;
> +		default:
> +			return 0;
> +		}
> +		break;
> +	case REQ_OP_ZONE_CLOSE:
> +		switch (z->cond) {
> +		case BLK_ZONE_COND_IMP_OPEN:
> +		case BLK_ZONE_COND_EXP_OPEN:
> +			break;
> +		default:
> +			return 0;
> +		}
> +		break;
> +	case REQ_OP_ZONE_FINISH:
> +		switch (z->cond) {
> +		case BLK_ZONE_COND_IMP_OPEN:
> +		case BLK_ZONE_COND_EXP_OPEN:
> +		case BLK_ZONE_COND_CLOSED:
> +			break;
> +		default:
> +			return 0;
> +		}
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	set_bit(i, (unsigned long *)(data->zbitmap));

You do not need the cast here. data->zbitmap is an unsigned long *.

> +
> +	return 0;
> +}
> +
> +static u16 nvmet_bdev_zone_mgmt_emulate_all(struct nvmet_req *req)
> +{
> +	struct block_device *bdev =3D req->ns->bdev;
> +	unsigned int nr_zones =3D blkdev_nr_zones(bdev->bd_disk);
> +	struct request_queue *q =3D bdev_get_queue(bdev);
> +	struct bio *bio =3D NULL;
> +	sector_t sector =3D 0;
> +	int ret;
> +	struct nvmet_zone_mgmt_send_all_data d =3D {
> +		.req =3D req,
> +	};
> +
> +	d.zbitmap =3D kcalloc_node(BITS_TO_LONGS(nr_zones), sizeof(*(d.zbitmap)=
),
> +				 GFP_NOIO, q->node);
> +	if (!d.zbitmap) {
> +		ret =3D -ENOMEM;
> +		goto out;
> +	}
> +
> +	/* Scan and build bitmap of the eligible zones */
> +	ret =3D blkdev_report_zones(bdev, 0, nr_zones, zmgmt_send_scan_cb, &d);
> +	if (ret !=3D nr_zones) {
> +		if (ret > 0)
> +			ret =3D -EIO;
> +		goto out;
> +	} else {
> +		/* We scanned all the zones */
> +		ret =3D 0;
> +	}
> +
> +	while (sector < get_capacity(bdev->bd_disk)) {
> +		if (test_bit(blk_queue_zone_no(q, sector), d.zbitmap)) {
> +			bio =3D blk_next_bio(bio, 0, GFP_KERNEL);
> +			bio->bi_opf =3D zsa_req_op(req->cmd->zms.zsa) | REQ_SYNC;
> +			bio->bi_iter.bi_sector =3D sector;
> +			bio_set_dev(bio, bdev);
> +			/* This may take a while, so be nice to others */
> +			cond_resched();
> +		}
> +		sector +=3D blk_queue_zone_sectors(q);
> +	}
> +
> +	if (bio) {
> +		ret =3D submit_bio_wait(bio);
> +		bio_put(bio);
> +	}
> +
> +out:
> +	kfree(d.zbitmap);
> +
> +	return blkdev_zone_mgmt_errno_to_nvme_status(ret);
> +}
> +
> +static u16 nvmet_bdev_execute_zmgmt_send_all(struct nvmet_req *req)
> +{
> +	int ret;
> +
> +	switch (zsa_req_op(req->cmd->zms.zsa)) {
> +	case REQ_OP_ZONE_RESET:
> +		ret =3D blkdev_zone_mgmt(req->ns->bdev, REQ_OP_ZONE_RESET, 0,
> +				       get_capacity(req->ns->bdev->bd_disk),
> +				       GFP_KERNEL);
> +		if (ret < 0)
> +			return blkdev_zone_mgmt_errno_to_nvme_status(ret);
> +		break;
> +	case REQ_OP_ZONE_OPEN:
> +	case REQ_OP_ZONE_CLOSE:
> +	case REQ_OP_ZONE_FINISH:
> +		return nvmet_bdev_zone_mgmt_emulate_all(req);
> +	default:
> +		/* this is needed to quiet compiler warning */
> +		req->error_loc =3D offsetof(struct nvme_zone_mgmt_send_cmd, zsa);
> +		return NVME_SC_INVALID_FIELD | NVME_SC_DNR;
> +	}
> +
> +	return NVME_SC_SUCCESS;
> +}
> +
> +static void nvmet_bdev_zmgmt_send_work(struct work_struct *w)
> +{
> +	struct nvmet_req *req =3D container_of(w, struct nvmet_req, z.zmgmt_wor=
k);
> +	sector_t sect =3D nvmet_lba_to_sect(req->ns, req->cmd->zms.slba);
> +	enum req_opf op =3D zsa_req_op(req->cmd->zms.zsa);
> +	struct block_device *bdev =3D req->ns->bdev;
> +	sector_t zone_sectors =3D bdev_zone_sectors(bdev);
> +	u16 status =3D NVME_SC_SUCCESS;
> +	int ret;
> +
> +	if (op =3D=3D REQ_OP_LAST) {
> +		req->error_loc =3D offsetof(struct nvme_zone_mgmt_send_cmd, zsa);
> +		status =3D NVME_SC_ZONE_INVALID_TRANSITION | NVME_SC_DNR;
> +		goto out;
> +	}
> +
> +	/* when select all bit is set slba field is ignored */
> +	if (req->cmd->zms.select_all) {
> +		status =3D nvmet_bdev_execute_zmgmt_send_all(req);
> +		goto out;
> +	}
> +
> +	if (sect >=3D get_capacity(bdev->bd_disk)) {
> +		req->error_loc =3D offsetof(struct nvme_zone_mgmt_send_cmd, slba);
> +		status =3D NVME_SC_LBA_RANGE | NVME_SC_DNR;
> +		goto out;
> +	}
> +
> +	if (sect & (zone_sectors - 1)) {
> +		req->error_loc =3D offsetof(struct nvme_zone_mgmt_send_cmd, slba);
> +		status =3D NVME_SC_INVALID_FIELD | NVME_SC_DNR;
> +		goto out;
> +	}
> +
> +	ret =3D blkdev_zone_mgmt(bdev, op, sect, zone_sectors, GFP_KERNEL);
> +	if (ret < 0)
> +		status =3D blkdev_zone_mgmt_errno_to_nvme_status(ret);
> +
> +out:
> +	nvmet_req_complete(req, status);
> +}
> +
> +void nvmet_bdev_execute_zone_mgmt_send(struct nvmet_req *req)
> +{
> +	INIT_WORK(&req->z.zmgmt_work, nvmet_bdev_zmgmt_send_work);
> +	queue_work(zbd_wq, &req->z.zmgmt_work);
> +}
> +
> +static void nvmet_bdev_zone_append_bio_done(struct bio *bio)
> +{
> +	struct nvmet_req *req =3D bio->bi_private;
> +
> +	if (bio->bi_status =3D=3D BLK_STS_OK) {
> +		req->cqe->result.u64 =3D
> +			nvmet_sect_to_lba(req->ns, bio->bi_iter.bi_sector);
> +	}
> +
> +	nvmet_req_complete(req, blk_to_nvme_status(req, bio->bi_status));
> +	nvmet_req_bio_put(req, bio);
> +}
> +
> +void nvmet_bdev_execute_zone_append(struct nvmet_req *req)
> +{
> +	sector_t sect =3D nvmet_lba_to_sect(req->ns, req->cmd->rw.slba);
> +	u16 nr_sect =3D nvmet_lba_to_sect(req->ns, req->cmd->rw.length);
> +	u16 status =3D NVME_SC_SUCCESS;
> +	unsigned int total_len =3D 0;
> +	struct scatterlist *sg;
> +	struct bio *bio;
> +	int sg_cnt;
> +
> +	/* Request is completed on len mismatch in nvmet_check_transter_len() */
> +	if (!nvmet_check_transfer_len(req, nvmet_rw_data_len(req)))
> +		return;
> +
> +	if (!req->sg_cnt) {
> +		nvmet_req_complete(req, 0);
> +		return;
> +	}
> +
> +	if (sect >=3D get_capacity(req->ns->bdev->bd_disk)) {
> +		req->error_loc =3D offsetof(struct nvme_rw_command, slba);
> +		status =3D NVME_SC_LBA_RANGE | NVME_SC_DNR;
> +		goto out;
> +	}
> +
> +	if ((sect + nr_sect > get_capacity(req->ns->bdev->bd_disk))) {
> +		req->error_loc =3D offsetof(struct nvme_rw_command, length);
> +		status =3D NVME_SC_LBA_RANGE | NVME_SC_DNR;
> +		goto out;
> +	}
> +
> +	if (sect & (bdev_zone_sectors(req->ns->bdev) - 1)) {
> +		req->error_loc =3D offsetof(struct nvme_rw_command, slba);
> +		status =3D NVME_SC_INVALID_FIELD | NVME_SC_DNR;
> +		goto out;
> +	}
> +
> +	if (nvmet_use_inline_bvec(req)) {
> +		bio =3D &req->z.inline_bio;
> +		bio_init(bio, req->inline_bvec, ARRAY_SIZE(req->inline_bvec));
> +	} else {
> +		bio =3D bio_alloc(GFP_KERNEL, req->sg_cnt);
> +	}
> +
> +	bio->bi_opf =3D REQ_OP_ZONE_APPEND | REQ_SYNC | REQ_IDLE;
> +	bio->bi_end_io =3D nvmet_bdev_zone_append_bio_done;
> +	bio_set_dev(bio, req->ns->bdev);
> +	bio->bi_iter.bi_sector =3D sect;
> +	bio->bi_private =3D req;
> +	if (req->cmd->rw.control & cpu_to_le16(NVME_RW_FUA))
> +		bio->bi_opf |=3D REQ_FUA;
> +
> +	for_each_sg(req->sg, sg, req->sg_cnt, sg_cnt) {
> +		struct page *p =3D sg_page(sg);
> +		unsigned int l =3D sg->length;
> +		unsigned int o =3D sg->offset;
> +		unsigned int ret;
> +
> +		ret =3D bio_add_zone_append_page(bio, p, l, o);
> +		if (ret !=3D sg->length) {
> +			status =3D NVME_SC_INTERNAL;
> +			goto out_put_bio;
> +		}
> +		total_len +=3D sg->length;
> +	}
> +
> +	if (total_len !=3D nvmet_rw_data_len(req)) {
> +		status =3D NVME_SC_INTERNAL | NVME_SC_DNR;
> +		goto out_put_bio;
> +	}
> +
> +	submit_bio(bio);
> +	return;
> +
> +out_put_bio:
> +	nvmet_req_bio_put(req, bio);
> +out:
> +	nvmet_req_complete(req, status);
> +}
> +
> +u16 nvmet_bdev_zns_parse_io_cmd(struct nvmet_req *req)
> +{
> +	struct nvme_command *cmd =3D req->cmd;
> +
> +	switch (cmd->common.opcode) {
> +	case nvme_cmd_zone_append:
> +		req->execute =3D nvmet_bdev_execute_zone_append;
> +		return 0;
> +	case nvme_cmd_zone_mgmt_recv:
> +		req->execute =3D nvmet_bdev_execute_zone_mgmt_recv;
> +		return 0;
> +	case nvme_cmd_zone_mgmt_send:
> +		req->execute =3D nvmet_bdev_execute_zone_mgmt_send;
> +		return 0;
> +	default:
> +		return nvmet_bdev_parse_io_cmd(req);
> +	}
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


With the nit above fixed, feel free to add

Reviewed-by: Damien Le Moal <damien.lemoal@wdc.com>


-- =

Damien Le Moal
Western Digital Research

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
