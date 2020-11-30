Return-Path: <SRS0=wRjJ=FE=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D3ECC64E8A
	for <linux-nvme@archiver.kernel.org>; Mon, 30 Nov 2020 11:58:10 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D836C20825
	for <linux-nvme@archiver.kernel.org>; Mon, 30 Nov 2020 11:58:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="cemx2Af2";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="V1AGId1X";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="aRxxwDL8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D836C20825
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:To:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=UTMAYAEtAGjgBDhhljTMK65td8vccFP5Ntr8+QgaiLg=; b=cemx2Af2gpdvTklAi1IxTgHAh
	yr2qB/jUxWCYwX+1NVmpjGpuSJMRczg0qrdic5ZIcwrU1tYYciJ2AOVqOqcvtHhJD4heISkeZHbnU
	qVlxrZDbvP916zMXseRwny8DjVfiIYIgBpyIeXZ2Pe8aciUkByl6R+3Dh1x2KC+rmLao3ETSauu/1
	267h5dT3RoJPX0cWNXfr3Zrzr0wQ1HIYq23Pe0M81De+Y77aEJ6sdGp4cYZSNBLADEtpDl+OU9ZyX
	kL59BwHbHNyRpzn0wD2GiM2jucRJtROiGqZ27rYPcdiD8dkkjdJzke9ml752tFPGgfj/efnCsUOds
	dX6Ula1EQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kjhof-0008IV-UB; Mon, 30 Nov 2020 11:58:01 +0000
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kjhob-0008Hn-Cb
 for linux-nvme@lists.infradead.org; Mon, 30 Nov 2020 11:58:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1606737477; x=1638273477;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=s1yrUB+pUYxIaOfKd7B5wGmGRLONR0do+2PsPQPX5vs=;
 b=V1AGId1XijZBxvGNOHo+UpMoULnPmmCw0D1sUNkGyBqflRs3nL4+ExR9
 8KvxRI5wHN5zzOzwPXuzjEw13Co601YZoyDkae8hIXLHv8QK0MyQs68q/
 AlS8lo8R6xEVEksSUPCIQayak8JVrh4zvPawGB9YgtCyGN1Msl3oj8btb
 /nwaJJd/vbk+0SeUvc3LoaQ70Aw/Lu3fEY3pwywcJ8cJY/M2OPIJ+rRoW
 hp4R0Qi4bdzAaVxuyMWuL0P5MkPTzipBCHhKSKzoaZ/HDYz1yirRcX11s
 3BIe3hwLdZDkbyRmVLFVfvkPpHiLsLsUkPztX6NfSGBwEg0GVmA1rhdKF w==;
IronPort-SDR: D/3Rk0dG+eT1D5GvgzHUMsJaotveR+pcumQEyb/lHugAx2+QhziLpUNY7PgAx0a8+Vg54xBlC5
 L4PGyVpKvmLaWlnF6IcA7ixHL7AKlBzUnyTePQwWYHiFozFpYmaO7cr64vQ0vUkXtmDUJsMkwe
 Won/Of2dZL6wsnv5pLIOZ/6gEqWNaBjhVL5qsxzR+IOjNSJNWfIuEos7x1lXJhk6IavJ6Xa5VK
 +1+UFNgwBFEryJnq+eOK52cPki/uByd2okFyYhiJ+zNeY7WtM4RHLq/lwKXkc9bGNxFmNIc+wa
 SHc=
X-IronPort-AV: E=Sophos;i="5.78,381,1599494400"; d="scan'208";a="153876966"
Received: from mail-mw2nam12lp2043.outbound.protection.outlook.com (HELO
 NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.43])
 by ob1.hgst.iphmx.com with ESMTP; 30 Nov 2020 19:57:55 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GKaWO5inx4N0MbFemTRJutyHEq/IBrFISoZGXEsbse8vs2tnxiTLaDy2d5XhJvXa2xit3gtTctvXaeOFMKhy+nBN5f162DKFiDXZ9PaqBYj7VvG5gh49K40NvpQupsOVH+QTkdR5hAD4MQRgWrJ9wwuQO20I+qORrKrYykSZC7clmgWc5WKC5oO2QCPvJBh4M/LRRGve3WsjQ5x4WCk5AajyDcgTvxoKlQ5yLdncXeSQXpdATaC3hNTrZVXIsJnYVzQu7u2d9Ll6SZ8Nb+AuoN8DSIIBHlPIOi9NbqzJdYrZgXbQhJGa9i86icgDNSZt09sufwXFGS2aAAoWBG0FSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N1//vJ6SyBdoEQ+AzSARB1/vgW5xn/qtxfuNjbSEDaY=;
 b=TxAURbglZZQdyWAzIvhXKKjAP4cC5kSX0CKRuc/iI60VsjdeYRWKpzWHVRo2DhT4FGGQIK+Xb1zQSX+vuPpOKPfb2mRhKvNHtC+pbvV8grbCMwGfiIbdAJlRh89Bx0B93EkMi+ipUhmW+7L3P9OMkAG0k84d8awyzYlX7DJxN/fAfWLO6EcweImNqPXlnsKwDIY2FFE9zPiIfI+76DJRhazxNsQx2dsKhxH2qP+qR30wXzviEMXsa6R2HU3b/CetCA3uLg0bzJLZI7+w2MPel60syD6OY5KhOvrzZIMzNb7tNyXtRbgbe2F95HuNyC68asswBYO0yS3HsrgtD+GaWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N1//vJ6SyBdoEQ+AzSARB1/vgW5xn/qtxfuNjbSEDaY=;
 b=aRxxwDL85HgXrjVLI3ByxdTJmLZRqVujBq0rjXkyvhZwybWNVv4O5zshwAPOia6S+4m5YOREKjg4MIcEDbtDocUWarX6olvE6Svjm3szCL2jjAPpZKaRjmyoseUsgel2rjqJylef6HGrJwmJgpiZMsJ5Fjtj98JqdbcHXr8e2F4=
Received: from CH2PR04MB6522.namprd04.prod.outlook.com (2603:10b6:610:34::19)
 by CH2PR04MB6869.namprd04.prod.outlook.com (2603:10b6:610:97::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.23; Mon, 30 Nov
 2020 11:57:54 +0000
Received: from CH2PR04MB6522.namprd04.prod.outlook.com
 ([fe80::897c:a04b:4eb0:640a]) by CH2PR04MB6522.namprd04.prod.outlook.com
 ([fe80::897c:a04b:4eb0:640a%7]) with mapi id 15.20.3589.022; Mon, 30 Nov 2020
 11:57:54 +0000
From: Damien Le Moal <Damien.LeMoal@wdc.com>
To: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH V2 2/9] nvmet: add ZNS support for bdev-ns
Thread-Topic: [PATCH V2 2/9] nvmet: add ZNS support for bdev-ns
Thread-Index: AQHWxskIQyfbJcgpJ0mkN6+CY3xyrg==
Date: Mon, 30 Nov 2020 11:57:54 +0000
Message-ID: <CH2PR04MB652237C06F44FF3C9B6DDD11E7F50@CH2PR04MB6522.namprd04.prod.outlook.com>
References: <20201130032909.40638-1-chaitanya.kulkarni@wdc.com>
 <20201130032909.40638-3-chaitanya.kulkarni@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2400:2411:43c0:6000:3811:272:f33b:9d56]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 158af774-7b99-45ef-4008-08d895272bd6
x-ms-traffictypediagnostic: CH2PR04MB6869:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CH2PR04MB68694CF7A122F08ADAF1948BE7F50@CH2PR04MB6869.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GH5Nj4LJYqYw0f1M6CbgcINzrbgTw6HhTmW5vDmgwHSEqUnvl+SSrAe3uh8Fztlp7lPTJebtLlSqyeP1vokD9FBxJMQMUa/GC1eO8KiiFrzczvzNKca5aW2wt6AmUkIZDCUASMrjk9W71bR7aCW21yT/DYJXiMIWG0oZj3NSZ9wR4HAQcJHeOzVbOKpCAau3bv3Gf4y5X7iFEf2BaRcCk6VOeo0AdUnswhz0U60fgDuz+wqDzbsbTUOM12wpgkCTZ3l3OOg8/F+MAOC9YDYxaornCYeq7PgjBr33cpwqxXRdXsDUGFtz5NQS7q4eO7MgzlWy2wCvG43GHccnsieReA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR04MB6522.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(376002)(396003)(39860400002)(346002)(136003)(316002)(53546011)(52536014)(186003)(110136005)(33656002)(4326008)(55016002)(54906003)(83380400001)(86362001)(76116006)(8676002)(478600001)(66446008)(8936002)(91956017)(66946007)(9686003)(66556008)(64756008)(66476007)(71200400001)(2906002)(30864003)(7696005)(5660300002)(6506007);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?b8wNJMvg8kCjnhc2kYGzPaUA4g//u0g3K7PCBDBOweV5L/QsVqnCE4SywlHj?=
 =?us-ascii?Q?YavFPZA6OklHH1x9taDZTaxn2Dwr/yC+vFU5cas1IbjoyZyL6IahP848kCUh?=
 =?us-ascii?Q?IDEBeqj6pEgsG2saOuslyPZiZndPMN3cZ3hXJ/oZKkGWOYOW9WxiFADS2LD7?=
 =?us-ascii?Q?r0UshVUJ0RVjugElPz2ju4ZMtGRbOiTd+uJPrGXEvF/4FO3OathrWUNkPYa6?=
 =?us-ascii?Q?6U+jlTTjgj/r1ijQHzlyw7QSgCy12POjtYQkzfB1I61Wryf+NhyfPfW4MHT0?=
 =?us-ascii?Q?Y74+zkaxBIa06wXAW5atIbMaPjCmCj72f+dpbJIwMWNtzMG0kxMeF17tmfvl?=
 =?us-ascii?Q?4rc2wnxnZmpJ6rqN2A0YXU3Ky4SYRuEF09y73poqd/bQxkxJWgax+lPLvx1V?=
 =?us-ascii?Q?PqU2fFesiAFMIMgEpfkgeSP8u/vph8eqFZ/I1r1mpjWlD0fcu3CM+Ece4a34?=
 =?us-ascii?Q?0O4JhGnm1fO+q0C3PgTKVne4t6u+6PQy2LPFUz4RwDV84RiIJaJT3vXqzOqU?=
 =?us-ascii?Q?cnSu3Kg6XWKGIDrdKCjkIpYXPIiM785ZRSdXsUycHqai4h276drBpz8QTHQR?=
 =?us-ascii?Q?qhGX1YIcP0SfN/cXXe9ya2/mbAsDkPowNoRb5K3t9mWeuYPkqBflBTOtkIZW?=
 =?us-ascii?Q?AfUmoynbLnH1WagSiON/v9kYCaFizU2gszU81pEW63bo60/YgaSynyYcTSB7?=
 =?us-ascii?Q?M1Ke5Ww/2jaBYGvCu2oYr4BfRNcFM/yM5vMzKeqyQdOTmdZwSC2wElmIjKoE?=
 =?us-ascii?Q?MrBvkzIR5K+pXORfzpvfP7TfrXDQXPNGGagmYOrpSgmKDUnzjg3SfNsWbQeM?=
 =?us-ascii?Q?IytGWUvWlvIRaLjWPjvgLGF7tVC1He5Ldg+xRVtET6PDzLNQHmeDviIb82kh?=
 =?us-ascii?Q?ADEhCakaM5WlvZylEHI0wd8mDDEZtRvrWdnbxX6btI+mNyZfDbD4ANhc3Q4R?=
 =?us-ascii?Q?ErNDOGQ8T8t435GjPGgwg7Pam30veIYGbx8XkS5T87w2wnsEi1PWt/KryvaT?=
 =?us-ascii?Q?J91G4xGqg5bmSiaOUZDo6UVU8eSiqoEu2kkj6vFdpyhxjjefzovhcWwYzdF8?=
 =?us-ascii?Q?D4NSxZIb?=
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR04MB6522.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 158af774-7b99-45ef-4008-08d895272bd6
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Nov 2020 11:57:54.3982 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yCeJ/OjM5BagR5/x80ln5lvHxyleQETyj9LiNVWvKpGOhWHs6jTHC4/UdpM668aAIYfJrQnW9/5mj5VFJdx7FQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR04MB6869
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201130_065757_762330_FE84AB78 
X-CRM114-Status: GOOD (  20.77  )
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
Cc: "hch@lst.de" <hch@lst.de>, "sagi@grimberg.me" <sagi@grimberg.me>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 2020/11/30 12:29, Chaitanya Kulkarni wrote:
> Add zns-bdev-config, id-ctrl, id-ns, zns-cmd-effects, zone-mgmt-send,
> zone-mgmt-recv and zone-append handlers for NVMeOF target to enable ZNS
> support for bdev.
> 
> Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
> ---
>  drivers/nvme/target/Makefile      |   2 +-
>  drivers/nvme/target/admin-cmd.c   |   4 +-
>  drivers/nvme/target/io-cmd-file.c |   2 +-
>  drivers/nvme/target/nvmet.h       |  19 ++
>  drivers/nvme/target/zns.c         | 463 ++++++++++++++++++++++++++++++
>  5 files changed, 486 insertions(+), 4 deletions(-)
>  create mode 100644 drivers/nvme/target/zns.c
> 
> diff --git a/drivers/nvme/target/Makefile b/drivers/nvme/target/Makefile
> index ebf91fc4c72e..d050f829b43a 100644
> --- a/drivers/nvme/target/Makefile
> +++ b/drivers/nvme/target/Makefile
> @@ -10,7 +10,7 @@ obj-$(CONFIG_NVME_TARGET_FCLOOP)	+= nvme-fcloop.o
>  obj-$(CONFIG_NVME_TARGET_TCP)		+= nvmet-tcp.o
>  
>  nvmet-y		+= core.o configfs.o admin-cmd.o fabrics-cmd.o \
> -			discovery.o io-cmd-file.o io-cmd-bdev.o
> +		   zns.o discovery.o io-cmd-file.o io-cmd-bdev.o
>  nvmet-$(CONFIG_NVME_TARGET_PASSTHRU)	+= passthru.o
>  nvme-loop-y	+= loop.o
>  nvmet-rdma-y	+= rdma.o
> diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
> index dca34489a1dc..509fd8dcca0c 100644
> --- a/drivers/nvme/target/admin-cmd.c
> +++ b/drivers/nvme/target/admin-cmd.c
> @@ -579,8 +579,8 @@ static void nvmet_execute_identify_nslist(struct nvmet_req *req)
>  	nvmet_req_complete(req, status);
>  }
>  
> -static u16 nvmet_copy_ns_identifier(struct nvmet_req *req, u8 type, u8 len,
> -				    void *id, off_t *off)
> +u16 nvmet_copy_ns_identifier(struct nvmet_req *req, u8 type, u8 len,
> +			     void *id, off_t *off)
>  {
>  	struct nvme_ns_id_desc desc = {
>  		.nidt = type,
> diff --git a/drivers/nvme/target/io-cmd-file.c b/drivers/nvme/target/io-cmd-file.c
> index 0abbefd9925e..2bd10960fa50 100644
> --- a/drivers/nvme/target/io-cmd-file.c
> +++ b/drivers/nvme/target/io-cmd-file.c
> @@ -89,7 +89,7 @@ int nvmet_file_ns_enable(struct nvmet_ns *ns)
>  	return ret;
>  }
>  
> -static void nvmet_file_init_bvec(struct bio_vec *bv, struct scatterlist *sg)
> +void nvmet_file_init_bvec(struct bio_vec *bv, struct scatterlist *sg)
>  {
>  	bv->bv_page = sg_page(sg);
>  	bv->bv_offset = sg->offset;
> diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
> index 592763732065..eee7866ae512 100644
> --- a/drivers/nvme/target/nvmet.h
> +++ b/drivers/nvme/target/nvmet.h
> @@ -81,6 +81,10 @@ struct nvmet_ns {
>  	struct pci_dev		*p2p_dev;
>  	int			pi_type;
>  	int			metadata_size;
> +#ifdef CONFIG_BLK_DEV_ZONED
> +	struct nvme_id_ns_zns	id_zns;
> +	unsigned int		zasl;
> +#endif
>  };
>  
>  static inline struct nvmet_ns *to_nvmet_ns(struct config_item *item)
> @@ -251,6 +255,10 @@ struct nvmet_subsys {
>  	unsigned int		admin_timeout;
>  	unsigned int		io_timeout;
>  #endif /* CONFIG_NVME_TARGET_PASSTHRU */
> +
> +#ifdef CONFIG_BLK_DEV_ZONED
> +	struct nvme_id_ctrl_zns	id_ctrl_zns;
> +#endif
>  };
>  
>  static inline struct nvmet_subsys *to_subsys(struct config_item *item)
> @@ -603,4 +611,15 @@ static inline bool nvmet_ns_has_pi(struct nvmet_ns *ns)
>  	return ns->pi_type && ns->metadata_size == sizeof(struct t10_pi_tuple);
>  }
>  
> +void nvmet_execute_identify_cns_cs_ctrl(struct nvmet_req *req);
> +void nvmet_execute_identify_cns_cs_ns(struct nvmet_req *req);
> +u16 nvmet_process_zns_cis(struct nvmet_req *req, off_t *off);
> +bool nvmet_bdev_zns_enable(struct nvmet_ns *ns);
> +void nvmet_bdev_execute_zone_mgmt_recv(struct nvmet_req *req);
> +void nvmet_bdev_execute_zone_mgmt_send(struct nvmet_req *req);
> +void nvmet_bdev_execute_zone_append(struct nvmet_req *req);
> +void nvmet_zns_add_cmd_effects(struct nvme_effects_log *log);
> +u16 nvmet_copy_ns_identifier(struct nvmet_req *req, u8 type, u8 len,
> +			     void *id, off_t *off);
> +void nvmet_file_init_bvec(struct bio_vec *bv, struct scatterlist *sg);
>  #endif /* _NVMET_H */
> diff --git a/drivers/nvme/target/zns.c b/drivers/nvme/target/zns.c
> new file mode 100644
> index 000000000000..40dedfd51fd6
> --- /dev/null
> +++ b/drivers/nvme/target/zns.c
> @@ -0,0 +1,463 @@
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
> +#ifdef CONFIG_BLK_DEV_ZONED
> +#define NVMET_MPSMIN_SHIFT	12
> +
> +static u16 nvmet_bdev_zns_checks(struct nvmet_req *req)
> +{
> +	u16 status = 0;
> +
> +	if (!bdev_is_zoned(req->ns->bdev)) {
> +		status = NVME_SC_INVALID_NS | NVME_SC_DNR;
> +		goto out;
> +	}
> +
> +	if (req->cmd->zmr.zra != NVME_ZRA_ZONE_REPORT) {
> +		status = NVME_SC_INVALID_FIELD;
> +		goto out;
> +	}
> +
> +	if (req->cmd->zmr.zrasf != NVME_ZRASF_ZONE_REPORT_ALL) {
> +		status = NVME_SC_INVALID_FIELD;
> +		goto out;
> +	}
> +
> +	if (req->cmd->zmr.pr != NVME_REPORT_ZONE_PARTIAL)
> +		status = NVME_SC_INVALID_FIELD;
> +out:
> +	return status;
> +}
> +
> +static inline struct block_device *nvmet_bdev(struct nvmet_req *req)
> +{
> +	return req->ns->bdev;
> +}
> +
> +static inline  u64 nvmet_zones_to_desc_size(unsigned int nr_zones)
> +{
> +	return sizeof(struct nvme_zone_report) +
> +		(sizeof(struct nvme_zone_descriptor) * nr_zones);
> +}
> +
> +static inline u64 nvmet_sect_to_lba(struct nvmet_ns *ns, sector_t sect)
> +{
> +	return sect >> (ns->blksize_shift - SECTOR_SHIFT);
> +}
> +
> +static inline sector_t nvmet_lba_to_sect(struct nvmet_ns *ns, __le64 lba)
> +{
> +	return le64_to_cpu(lba) << (ns->blksize_shift - SECTOR_SHIFT);
> +}
> +
> +/*
> + *  ZNS related command implementation and helpers.
> + */
> +
> +u16 nvmet_process_zns_cis(struct nvmet_req *req, off_t *off)
> +{
> +	u16 nvme_cis_zns = NVME_CSI_ZNS;
> +
> +	if (!bdev_is_zoned(nvmet_bdev(req)))
> +		return NVME_SC_SUCCESS;
> +
> +	return nvmet_copy_ns_identifier(req, NVME_NIDT_CSI, NVME_NIDT_CSI_LEN,
> +					&nvme_cis_zns, off);
> +}
> +
> +void nvmet_zns_add_cmd_effects(struct nvme_effects_log *log)
> +{
> +	log->iocs[nvme_cmd_zone_append]		= cpu_to_le32(1 << 0);
> +	log->iocs[nvme_cmd_zone_mgmt_send]	= cpu_to_le32(1 << 0);
> +	log->iocs[nvme_cmd_zone_mgmt_recv]	= cpu_to_le32(1 << 0);
> +}
> +
> +static int nvmet_bdev_validate_zns_zones_cb(struct blk_zone *z,
> +					    unsigned int idx, void *data)
> +{
> +	struct blk_zone *zone = data;
> +
> +	memcpy(zone, z, sizeof(struct blk_zone));
> +
> +	return 0;
> +}
> +
> +static inline bool nvmet_bdev_validate_zns_zones(struct nvmet_ns *ns)
> +{
> +	sector_t last_sect = get_capacity(ns->bdev->bd_disk) - 1;
> +	struct blk_zone last_zone, first_zone;
> +	int reported_zones;
> +
> +	reported_zones = blkdev_report_zones(ns->bdev, 0, 1,
> +					     nvmet_bdev_validate_zns_zones_cb,
> +					     &first_zone);
> +	if (reported_zones != 1)
> +		return false;
> +
> +	reported_zones = blkdev_report_zones(ns->bdev, last_sect, 1,
> +					     nvmet_bdev_validate_zns_zones_cb,
> +					     &last_zone);
> +	if (reported_zones != 1)
> +		return false;
> +
> +	return first_zone.capacity == last_zone.capacity ? true : false;
> +}

That is really heavy handed... Why not just simply:

return !(get_capacity(ns->bdev->bd_disk) & (bdev_zone_sectors(ns->bdev) - 1));

That does the same: true if capacity is a multiple of the zone size (no runt
zone), false otherwise.

> +
> +static inline u8 nvmet_zasl(unsigned int zone_append_sects)
> +{
> +	unsigned int npages = (zone_append_sects << 9) >> NVMET_MPSMIN_SHIFT;
> +	u8 zasl = ilog2(npages);
> +
> +	/*
> +	 * Zone Append Size Limit is the value experessed in the units
> +	 * of minimum memory page size (i.e. 12) and is reported power of 2.
> +	 */
> +	return zasl;

Why not just:

	return ilog2((zone_append_sects << 9) >> NVMET_MPSMIN_SHIFT);

And are you sure that there is no possibility that the u8 type overflows here ?

> +}
> +
> +static inline void nvmet_zns_update_zasl(struct nvmet_ns *ns)
> +{
> +	u8 bio_max_zasl = nvmet_zasl((BIO_MAX_PAGES * PAGE_SIZE) >> 9);
> +	struct request_queue *q = ns->bdev->bd_disk->queue;
> +	struct nvmet_ns *ins;
> +	unsigned long idx;
> +	u8 min_zasl;
> +
> +	/*
> +	 * Calculate new ctrl->zasl value when enabling the new ns. This value
> +	 * has to be the minimum of the max_zone appned values from available

s/appned/append

> +	 * namespaces.
> +	 */
> +	min_zasl = ns->zasl = nvmet_zasl(queue_max_zone_append_sectors(q));
> +
> +	xa_for_each(&(ns->subsys->namespaces), idx, ins) {
> +		struct request_queue *iq = ins->bdev->bd_disk->queue;
> +		unsigned int imax_za_sects = queue_max_zone_append_sectors(iq);
> +		u8 izasl = nvmet_zasl(imax_za_sects);
> +
> +		if (!bdev_is_zoned(ins->bdev))
> +			continue;
> +
> +		min_zasl = min_zasl > izasl ? izasl : min_zasl;
> +	}
> +
> +	ns->subsys->id_ctrl_zns.zasl = min_t(u8, min_zasl, bio_max_zasl);

I do not understand what bio_max_zasl is used for here, as it does not represent
anything related to the zoned namespaces backends.

> +}> +
> +bool nvmet_bdev_zns_enable(struct nvmet_ns *ns)
> +{
> +	if (ns->bdev->bd_disk->queue->conv_zones_bitmap) {
> +		pr_err("block devices with conventional zones are not supported.");
> +		return false;
> +	}

It may be better to move this test in nvmet_bdev_validate_zns_zones(), so that
all backend zone configuration checks are together.

> +
> +	if (!nvmet_bdev_validate_zns_zones(ns))
> +		return false;
> +
> +	/*
> +	 * For ZBC and ZAC devices, writes into sequential zones must be aligned
> +	 * to the device physical block size. So use this value as the logical
> +	 * block size to avoid errors.
> +	 */
> +	ns->blksize_shift = blksize_bits(bdev_physical_block_size(ns->bdev));
> +
> +	nvmet_zns_update_zasl(ns);
> +
> +	return true;
> +}
> +
> +/*
> + * ZNS related Admin and I/O command handlers.
> + */
> +void nvmet_execute_identify_cns_cs_ctrl(struct nvmet_req *req)
> +{
> +	struct nvmet_ctrl *ctrl = req->sq->ctrl;
> +	struct nvme_id_ctrl_zns *id;
> +	u16 status = 0;
> +	u8 mdts;
> +
> +	id = kzalloc(sizeof(*id), GFP_KERNEL);
> +	if (!id) {
> +		status = NVME_SC_INTERNAL;
> +		goto out;
> +	}
> +
> +	/*
> +	 * Even though this function sets Zone Append Size Limit to 0,
> +	 * the 0 value here indicates that the maximum data transfer size for
> +	 * the Zone Append command is indicated by the ctrl
> +	 * Maximum Data Transfer Size (MDTS).
> +	 */

I do not understand this comment. It does not really exactly match what the code
below is doing.

> +
> +	mdts = ctrl->ops->get_mdts ? ctrl->ops->get_mdts(ctrl) : 0;
> +
> +	id->zasl = min_t(u8, mdts, req->sq->ctrl->subsys->id_ctrl_zns.zasl);
> +
> +	status = nvmet_copy_to_sgl(req, 0, id, sizeof(*id));
> +
> +	kfree(id);
> +out:
> +	nvmet_req_complete(req, status);
> +}
> +
> +void nvmet_execute_identify_cns_cs_ns(struct nvmet_req *req)
> +{
> +	struct nvme_id_ns_zns *id_zns;
> +	u16 status = 0;
> +	u64 zsze;
> +
> +	if (le32_to_cpu(req->cmd->identify.nsid) == NVME_NSID_ALL) {
> +		req->error_loc = offsetof(struct nvme_identify, nsid);
> +		status = NVME_SC_INVALID_NS | NVME_SC_DNR;
> +		goto out;
> +	}
> +
> +	id_zns = kzalloc(sizeof(*id_zns), GFP_KERNEL);
> +	if (!id_zns) {
> +		status = NVME_SC_INTERNAL;
> +		goto out;
> +	}
> +
> +	req->ns = nvmet_find_namespace(req->sq->ctrl, req->cmd->identify.nsid);
> +	if (!req->ns) {
> +		status = NVME_SC_INTERNAL;
> +		goto done;
> +	}
> +
> +	if (!bdev_is_zoned(nvmet_bdev(req))) {
> +		req->error_loc = offsetof(struct nvme_identify, nsid);
> +		status = NVME_SC_INVALID_NS | NVME_SC_DNR;
> +		goto done;
> +	}
> +
> +	nvmet_ns_revalidate(req->ns);
> +	zsze = (bdev_zone_sectors(nvmet_bdev(req)) << 9) >>
> +					req->ns->blksize_shift;
> +	id_zns->lbafe[0].zsze = cpu_to_le64(zsze);
> +	id_zns->mor = cpu_to_le32(bdev_max_open_zones(nvmet_bdev(req)));
> +	id_zns->mar = cpu_to_le32(bdev_max_active_zones(nvmet_bdev(req)));
> +
> +done:
> +	status = nvmet_copy_to_sgl(req, 0, id_zns, sizeof(*id_zns));
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
> +static int nvmet_bdev_report_zone_cb(struct blk_zone *z, unsigned int idx,
> +				     void *data)
> +{
> +	struct nvmet_report_zone_data *report_zone_data = data;
> +	struct nvme_zone_descriptor *entries = report_zone_data->rz->entries;
> +	struct nvmet_ns *ns = report_zone_data->ns;
> +
> +	entries[idx].zcap = cpu_to_le64(nvmet_sect_to_lba(ns, z->capacity));
> +	entries[idx].zslba = cpu_to_le64(nvmet_sect_to_lba(ns, z->start));
> +	entries[idx].wp = cpu_to_le64(nvmet_sect_to_lba(ns, z->wp));
> +	entries[idx].za = z->reset ? 1 << 2 : 0;
> +	entries[idx].zt = z->type;
> +	entries[idx].zs = z->cond << 4;
> +
> +	return 0;
> +}
> +
> +void nvmet_bdev_execute_zone_mgmt_recv(struct nvmet_req *req)
> +{
> +	u32 bufsize = (le32_to_cpu(req->cmd->zmr.numd) + 1) << 2;

size_t ?

> +	struct nvmet_report_zone_data data = { .ns = req->ns };
> +	struct nvme_zone_mgmt_recv_cmd *zmr = &req->cmd->zmr;
> +	sector_t sect = nvmet_lba_to_sect(req->ns, le64_to_cpu(zmr->slba));
> +	unsigned int nr_zones = bufsize / nvmet_zones_to_desc_size(1);

I think this is wrong since nvmet_zones_to_desc_size includes sizeof(struct
nvme_zone_report). I think what you want here is:

nr_zones = (bufsize - sizeof(struct nvme_zone_report)) /
	sizeof(struct nvme_zone_descriptor);

And then you can get rid of nvmet_zones_to_desc_size();

> +	int reported_zones;
> +	u16 status;
> +
> +	status = nvmet_bdev_zns_checks(req);
> +	if (status)
> +		goto out;
> +
> +	data.rz = __vmalloc(bufsize, GFP_KERNEL | __GFP_NORETRY);
> +	if (!data.rz) {
> +		status = NVME_SC_INTERNAL;
> +		goto out;
> +	}
> +
> +	reported_zones = blkdev_report_zones(nvmet_bdev(req), sect, nr_zones,
> +					     nvmet_bdev_report_zone_cb,
> +					     &data);
> +	if (reported_zones < 0) {
> +		status = NVME_SC_INTERNAL;
> +		goto out_free_report_zones;
> +	}
> +
> +	data.rz->nr_zones = cpu_to_le64(reported_zones);
> +
> +	status = nvmet_copy_to_sgl(req, 0, data.rz, bufsize);
> +
> +out_free_report_zones:
> +	kvfree(data.rz);
> +out:
> +	nvmet_req_complete(req, status);
> +}
> +
> +void nvmet_bdev_execute_zone_mgmt_send(struct nvmet_req *req)
> +{
> +	sector_t nr_sect = bdev_zone_sectors(nvmet_bdev(req));
> +	struct nvme_zone_mgmt_send_cmd *c = &req->cmd->zms;
> +	enum req_opf op = REQ_OP_LAST;
> +	u16 status = NVME_SC_SUCCESS;
> +	sector_t sect;
> +	int ret;
> +
> +	sect = nvmet_lba_to_sect(req->ns, le64_to_cpu(req->cmd->zms.slba));
> +
> +	switch (c->zsa) {
> +	case NVME_ZONE_OPEN:
> +		op = REQ_OP_ZONE_OPEN;
> +		break;
> +	case NVME_ZONE_CLOSE:
> +		op = REQ_OP_ZONE_CLOSE;
> +		break;
> +	case NVME_ZONE_FINISH:
> +		op = REQ_OP_ZONE_FINISH;
> +		break;
> +	case NVME_ZONE_RESET:
> +		if (c->select_all)
> +			nr_sect = get_capacity(nvmet_bdev(req)->bd_disk);
> +		op = REQ_OP_ZONE_RESET;
> +		break;
> +	default:
> +		status = NVME_SC_INVALID_FIELD;
> +		goto out;
> +	}
> +
> +	ret = blkdev_zone_mgmt(nvmet_bdev(req), op, sect, nr_sect, GFP_KERNEL);
> +	if (ret)
> +		status = NVME_SC_INTERNAL;
> +
> +out:
> +	nvmet_req_complete(req, status);
> +}
> +
> +void nvmet_bdev_execute_zone_append(struct nvmet_req *req)
> +{
> +	unsigned long bv_cnt = req->sg_cnt;
> +	int op = REQ_OP_ZONE_APPEND | REQ_SYNC | REQ_IDLE;
> +	u64 slba = le64_to_cpu(req->cmd->rw.slba);
> +	sector_t sect = nvmet_lba_to_sect(req->ns, slba);
> +	u16 status = NVME_SC_SUCCESS;
> +	size_t mapped_data_len = 0;
> +	int sg_cnt = req->sg_cnt;
> +	struct scatterlist *sg;
> +	struct iov_iter from;
> +	struct bio_vec *bvec;
> +	size_t mapped_cnt;
> +	struct bio *bio;
> +	int ret;
> +
> +	if (!nvmet_check_transfer_len(req, nvmet_rw_data_len(req)))
> +		return;
> +
> +	/*
> +	 * When setting the ctrl->zasl we consider the BIO_MAX_PAGES so that we
> +	 * don't have to split the bio, i.e. we shouldn't get
> +	 * sg_cnt > BIO_MAX_PAGES since zasl on the host will limit the I/Os
> +	 * with the size that considers the BIO_MAX_PAGES.
> +	 */

What ? Unclear... You advertize max zone append as ctrl->zasl = min(all ns max
zone append sectors). What does BIO_MAX_PAGES has to do with anything ?

> +	if (!req->sg_cnt)
> +		goto out;
> +
> +	if (WARN_ON(req->sg_cnt > BIO_MAX_PAGES)) {
> +		status = NVME_SC_INTERNAL | NVME_SC_DNR;
> +		goto out;
> +	}
> +
> +	bvec = kmalloc_array(bv_cnt, sizeof(*bvec), GFP_KERNEL);
> +	if (!bvec) {
> +		status = NVME_SC_INTERNAL | NVME_SC_DNR;
> +		goto out;
> +	}
> +
> +	for_each_sg(req->sg, sg, req->sg_cnt, mapped_cnt) {
> +		nvmet_file_init_bvec(bvec, sg);
> +		mapped_data_len += bvec[mapped_cnt].bv_len;
> +		sg_cnt--;
> +		if (mapped_cnt == bv_cnt)
> +			break;
> +	}
> +
> +	if (WARN_ON(sg_cnt)) {
> +		status = NVME_SC_INTERNAL | NVME_SC_DNR;
> +		goto out;
> +	}
> +
> +	iov_iter_bvec(&from, WRITE, bvec, mapped_cnt, mapped_data_len);
> +
> +	bio = bio_alloc(GFP_KERNEL, bv_cnt);
> +	bio_set_dev(bio, nvmet_bdev(req));
> +	bio->bi_iter.bi_sector = sect;
> +	bio->bi_opf = op;

The op variable is used only here. It is not necessary.

> +
> +	ret =  __bio_iov_append_get_pages(bio, &from);

I still do not see why bio_iov_iter_get_pages() does not work here. Would you
care to explain please ?

> +	if (unlikely(ret)) {
> +		status = NVME_SC_INTERNAL | NVME_SC_DNR;
> +		bio_io_error(bio);
> +		goto bvec_free;
> +	}
> +
> +	ret = submit_bio_wait(bio);
> +	status = ret < 0 ? NVME_SC_INTERNAL : status;
> +	bio_put(bio);
> +
> +	sect += (mapped_data_len >> 9);
> +	req->cqe->result.u64 = le64_to_cpu(nvmet_sect_to_lba(req->ns, sect));
> +
> +bvec_free:
> +	kfree(bvec);
> +
> +out:
> +	nvmet_req_complete(req, status);
> +}
> +
> +#else  /* CONFIG_BLK_DEV_ZONED */
> +void nvmet_execute_identify_cns_cs_ctrl(struct nvmet_req *req)
> +{
> +}
> +void nvmet_execute_identify_cns_cs_ns(struct nvmet_req *req)
> +{
> +}
> +u16 nvmet_process_zns_cis(struct nvmet_req *req, off_t *off)
> +{
> +	return 0;
> +}
> +bool nvmet_bdev_zns_config(struct nvmet_ns *ns)
> +{
> +	return false;
> +}
> +void nvmet_bdev_execute_zone_mgmt_recv(struct nvmet_req *req)
> +{
> +}
> +void nvmet_bdev_execute_zone_mgmt_send(struct nvmet_req *req)
> +{
> +}
> +void nvmet_bdev_execute_zone_append(struct nvmet_req *req)
> +{
> +}
> +void nvmet_zns_add_cmd_effects(struct nvme_effects_log *log)
> +{
> +}
> +#endif /* CONFIG_BLK_DEV_ZONED */
> 


-- 
Damien Le Moal
Western Digital Research

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
