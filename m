Return-Path: <SRS0=VgBB=FA=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B889C56202
	for <linux-nvme@archiver.kernel.org>; Thu, 26 Nov 2020 09:06:41 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 65CF6208CA
	for <linux-nvme@archiver.kernel.org>; Thu, 26 Nov 2020 09:06:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="wMofj/sk";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="jcUiPbDJ";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="B7+MOzLb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65CF6208CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:To:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=tcr7o4OWJsZpzMwEGpIzPn0d5gcmxb3nA2HPWWGR4v8=; b=wMofj/skUdfNMh7j6dpZAe5yQ
	nM4HevEasz83j7+ZwYm8KPxKvFKryo3kDKTbAi8ys98ObmgAiChcU9y4G1XMu9ELB6rf+eg8tiCC0
	1t8YX50Pfs2WBg97mchSJqqty0X2ubWTNl/kQQLqACkCSxRS0v/QaeaLBKBuxEF+gDWA9HARryXmi
	FJN9hcLvkSVKanBndF7kzz8yjWBg8F19CjbtbYDjPaF102DEh3JPejK6dkpIZOtuG2YwH4gZZqHJh
	CPfDnASToGMnmR69TfFtOuzMK7bYR84O6MmtXYrW3STmigD63Orw2eVayvjGVkHK8KXNfr3PA2RXo
	ctwNXaicg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kiDEW-0005Lr-Il; Thu, 26 Nov 2020 09:06:32 +0000
Received: from esa1.hgst.iphmx.com ([68.232.141.245])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kiDER-0005Kd-Ae
 for linux-nvme@lists.infradead.org; Thu, 26 Nov 2020 09:06:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1606381587; x=1637917587;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=Qbu+ekNLIWMxXDZMV49jcS3gK5EL63lmabtnl/A7/uI=;
 b=jcUiPbDJncjdNnGMNZ4eXI4JNudqGK+I+jwqtKHu1FptqC5NiueZpLc8
 8xcTwxusfFXL9P856eMpYxbMExJ8pwTyQ8TWzhjoqlYhB1nUTye5eXNI1
 D4rYSAX6d+vMFr8tdYqhsJWUFbOpACxxKV224IVNTiwz7LG6RTbKOPUQe
 9LDpBdFlDtbx9czCyorA6U2KxKhKFqTX9PF+Mn8/HxxmMgz17TohAnc2v
 OmxKA4cKwgs4uR3gEtb5opEUReDb2ZUqi5s/SJpP52J1XlTy8P1LaHSMZ
 oVJ7WQEkrHeSEuSmiiJ6YNpwDnkxvd7fAwnqjmzb0ckEXgyW7Sn+mm+Nu g==;
IronPort-SDR: C+nl1rdCpohH87743YKXsN5Jc2h2J2MQ7E3e7ktOo8zCBx11mCxrgxft8JTh+oP1SKE2MVMrRX
 lm+3rSlp79Q2+wo6ueNwQ30h+Tqlv18lnYQiWE0P+GwHOLiL6IJAt8oEyyeHZnuN9ZDbTQEUE9
 g0lmNTndXp5twJxfFCXVODLbZb9FuXpivzcbcp0bU05GdBGXVOhHvWXnK1BpFWPYJirtDTocFA
 r3VChMh4KxmEUCKZwQPUiORYITb0zVjTgV9hx2/5tbpDmzb1Yvhvqgx0GegX977idkveTiOsHJ
 +SU=
X-IronPort-AV: E=Sophos;i="5.78,371,1599494400"; d="scan'208";a="263623714"
Received: from mail-bn7nam10lp2102.outbound.protection.outlook.com (HELO
 NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.102])
 by ob1.hgst.iphmx.com with ESMTP; 26 Nov 2020 17:06:25 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qk7BjdnIMTxTsWY3AvRsff+i4IytE9yFFEmjJRuR12zY2QPpP0NAklx4Iek1/HuIFg99LzyoMLFPSsE3HzfdNreNwIV5PN/ahgGqf35mas3G4p2pVKUT5waq98Up0z+QPCylkbHMaXH7ciu2BA67wzfh7WLOQCQOHCAys3dyMcx8jenu4iGFKZAMBvHsoHHrCh7Brlb8s/dmJWmSPm1fO0O/N+tdQDJaWd51YmNaVIY9wKVDCRIELTFHmcjBcgde3Km0bVEXqVUgoenefGDJm9pjNdfnQIn1y4FMOo08eiOOO0KLr3m7ZCCZPNcnOJo/gJcVZKP/nPLlANIbEhov/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0mXCPHWvU9envDfr7wmbr5aqjpMYm0zMt9ZLPNPTqiA=;
 b=Bvz8cooTuAsQ1FGdIygm2c8TTvXeLmbKGLgA0lTT7EqJUgQ2DPg9t3JFRkkdxe7gUb6fCe5uy2alKLa+1zSb+xeyZp8Von/BALBsz0jqgHQSuFIVYb4Acy0pm/rt+tq1XcwzOaLEs+EnlI5NZ8hgmgzBmhzC10uo1m4fgB9l+wVjpqvgpmwrKP5Lnq1UyNpsXgsPCf9ug6SqsU/tXHF2JAb8rSu+thjzEp1JJ5zWVuMcrPVDLX56ruysOf8yM5Oo89uGTBNn34ncT3jN9u6tkuBj8LOIxdQ19fxfVbp0Pp5f1Q2hlJLVu9iBoGjeWiZPqhx1ySqSqS9RU2tGWOWiDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0mXCPHWvU9envDfr7wmbr5aqjpMYm0zMt9ZLPNPTqiA=;
 b=B7+MOzLbRq8aSDi9XChTYrxV9h6rtb05esVPEv66PvE2Lwlod+LpNcRxQ8KhqvGWOTKQL7OW+BXAMTQYQVV4wDUYZ+sfLlEGAIXhSgZxR5aaePyNrfunsPx+5YSidXXtOCEAsORaEAI+S2jsBzQRGb6xhd+OlW9EGvlf6Fkl2qc=
Received: from CH2PR04MB6522.namprd04.prod.outlook.com (2603:10b6:610:34::19)
 by CH2PR04MB6981.namprd04.prod.outlook.com (2603:10b6:610:a0::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.22; Thu, 26 Nov
 2020 09:06:23 +0000
Received: from CH2PR04MB6522.namprd04.prod.outlook.com
 ([fe80::897c:a04b:4eb0:640a]) by CH2PR04MB6522.namprd04.prod.outlook.com
 ([fe80::897c:a04b:4eb0:640a%7]) with mapi id 15.20.3589.022; Thu, 26 Nov 2020
 09:06:23 +0000
From: Damien Le Moal <Damien.LeMoal@wdc.com>
To: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH 2/9] nvmet: add ZNS support for bdev-ns
Thread-Topic: [PATCH 2/9] nvmet: add ZNS support for bdev-ns
Thread-Index: AQHWw53W//+mWSEaQk2ZMnl01vomXw==
Date: Thu, 26 Nov 2020 09:06:23 +0000
Message-ID: <CH2PR04MB652267A218F1EAD32E2DC8BAE7F90@CH2PR04MB6522.namprd04.prod.outlook.com>
References: <20201126024043.3392-1-chaitanya.kulkarni@wdc.com>
 <20201126024043.3392-3-chaitanya.kulkarni@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2400:2411:43c0:6000:7477:1782:371:aeb9]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 50a75801-066d-4296-c21d-08d891ea8c80
x-ms-traffictypediagnostic: CH2PR04MB6981:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CH2PR04MB698134AB0C700DB0C4764917E7F90@CH2PR04MB6981.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fVm70d1VVdgDzyg11tsbiE/lFqZP2ihqoO5Fmuyeen6HnSbblknzsaytprPsQyxg6nWm6ZamWxUl/JLDuQolJTy4f374bHzo3OQTfbL/SSyr1Tq6ll6t3RoF02Wlp6d+bZMseBE1QpubDsopN0qE6jlC7y3F2rGvwgJY++E30bluAfEat2dj5nJ6EEAH+mEvY/QBH8CK2IIShghwh4AeSXQQcUmU85OEa3SQnxNqPDYUiXY6P3a7qnnaPOLp+fxcZN/hlzWyCsxWy+jDa/szYj3hCtbNyIcLba3Ar20RsAAAEI1TgAnd4F9FSgj6cPtQKWs+7CvDnMQ3z3CPar8KTg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR04MB6522.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(376002)(346002)(396003)(39860400002)(136003)(64756008)(66446008)(186003)(4326008)(66946007)(54906003)(9686003)(110136005)(6506007)(2906002)(53546011)(7696005)(55016002)(478600001)(316002)(33656002)(76116006)(66556008)(66476007)(91956017)(8936002)(5660300002)(86362001)(8676002)(30864003)(71200400001)(52536014)(83380400001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?4c11Dj49id59VmNJrJWlqcg/3cungRFssP9ZfhHAWfNE69gPNlM7O7ce0jax?=
 =?us-ascii?Q?KsBCdu5+x6UoAqG7pLTVO9F0scgs/+t37PUVUuytyhSLsA0nfhqGGSdzJleH?=
 =?us-ascii?Q?ejQE4mnYvce/ofJ+CHJqs6SXTFueUOqRiEPWP3m+wlg2/esVstlSnBnF5QBV?=
 =?us-ascii?Q?UdIjcQHebG+/ChKun7rGXmHzhvcUzKK5NABKkqKEB1x7V56Shs0WLihGGfxe?=
 =?us-ascii?Q?eLIz9X0Wmj89VlORtsQdrKkP6qixrqVT40a450J4EHzQxOvpPnU/c2IgmJzO?=
 =?us-ascii?Q?2Ju1+djDWOYjEvmjrD7gTfdPPkBmGBZ935+JMGcrLS15/33eep1edAUEz33V?=
 =?us-ascii?Q?YO0PMB8MHAjZ2qo5PpHt05IETObxLTTmh6roxkKg/uN6h978CBka2rXZxoU3?=
 =?us-ascii?Q?ofWC8de/kbtdzBAni5P/BudbX3MPphqxF43T3lhFS5GWN7rUu0E2RA5Fzo/Q?=
 =?us-ascii?Q?zB5DHx35MgpshIJfFoLF3CIzWECa62AKwn+flcqyACQDt7dL2jeWy8f5eMIN?=
 =?us-ascii?Q?RyDmbVSapJ+8N3XoRCG8t0n/qWBqQsz2hYd+q1qxmSSljvUNofkGBLoUYY7V?=
 =?us-ascii?Q?gKMuEEdvqi0xqK2SsumvnXLEXX8H9+BqMCfkUr0tZ2JcCb2SMIToz8p59QaO?=
 =?us-ascii?Q?1kq0sOVsHXTCmI1g9BlsjPutH0eIFht9TcAlp0ifQIlLsdOXD/QRSV/P5Wmu?=
 =?us-ascii?Q?ZC6zykpZ2YUDtfFPrJGmK/31Z424LH4GzuULHH8GKzQ617n61jOHgF5aaQuS?=
 =?us-ascii?Q?ZBKeKQiMR0DMc/qCt5WZ+uJ7hxpfzhWo7d2ruj2X+aRfIFSqs+FoPUvnKVxy?=
 =?us-ascii?Q?C5ctyH7jruAAMlEhbcciNMJdxN9ciDruqIsbdsz0poTBw3C+KTQkrOnojNS8?=
 =?us-ascii?Q?Nhc/xFWhmiECizR56lv+MX5Rkqkmdc2pXPtzOj6V/44Z45cvL/QlyvUtue8+?=
 =?us-ascii?Q?eGaH3XYUV/jQBf5AFNOYgK0VnSb+jPpB35/L6wFhlzxHUJRFuXUHKxbPLBAx?=
 =?us-ascii?Q?cI6IohSmvlcTDbVy28r1s1prZBhImD90agrGmMoNByd680/l46xcaFYjkajV?=
 =?us-ascii?Q?jFnNpHht?=
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR04MB6522.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50a75801-066d-4296-c21d-08d891ea8c80
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Nov 2020 09:06:23.7552 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AIA9eg1VwxozgsLjEPMBxS46LmTLbBneNHKyXYgdXWJ603yykw9RJgiJXgkz83U4u3YVH4tgBPRcRNc9G4tV8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR04MB6981
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201126_040627_696553_9BAD48C1 
X-CRM114-Status: GOOD (  20.92  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 2020/11/26 11:42, Chaitanya Kulkarni wrote:
> Add zns-bdev-config, id-ctrl, id-ns, zns-cmd-effects, zone-mgmt-send,
> zone-mgmt-recv and zone-append handlers for NVMeOF target to enable ZNS
> support for bdev.
> 
> Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
> ---
>  drivers/nvme/target/Makefile      |   2 +
>  drivers/nvme/target/admin-cmd.c   |   4 +-
>  drivers/nvme/target/io-cmd-file.c |   2 +-
>  drivers/nvme/target/nvmet.h       |  18 ++
>  drivers/nvme/target/zns.c         | 390 ++++++++++++++++++++++++++++++
>  5 files changed, 413 insertions(+), 3 deletions(-)
>  create mode 100644 drivers/nvme/target/zns.c
> 
> diff --git a/drivers/nvme/target/Makefile b/drivers/nvme/target/Makefile
> index ebf91fc4c72e..bc147ff2df5d 100644
> --- a/drivers/nvme/target/Makefile
> +++ b/drivers/nvme/target/Makefile
> @@ -12,6 +12,8 @@ obj-$(CONFIG_NVME_TARGET_TCP)		+= nvmet-tcp.o
>  nvmet-y		+= core.o configfs.o admin-cmd.o fabrics-cmd.o \
>  			discovery.o io-cmd-file.o io-cmd-bdev.o
>  nvmet-$(CONFIG_NVME_TARGET_PASSTHRU)	+= passthru.o
> +nvmet-$(CONFIG_BLK_DEV_ZONED)		+= zns.o
> +
>  nvme-loop-y	+= loop.o
>  nvmet-rdma-y	+= rdma.o
>  nvmet-fc-y	+= fc.o
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
> index 592763732065..0542ba672a31 100644
> --- a/drivers/nvme/target/nvmet.h
> +++ b/drivers/nvme/target/nvmet.h
> @@ -81,6 +81,9 @@ struct nvmet_ns {
>  	struct pci_dev		*p2p_dev;
>  	int			pi_type;
>  	int			metadata_size;
> +#ifdef CONFIG_BLK_DEV_ZONED
> +	struct nvme_id_ns_zns	id_zns;
> +#endif
>  };
>  
>  static inline struct nvmet_ns *to_nvmet_ns(struct config_item *item)
> @@ -251,6 +254,10 @@ struct nvmet_subsys {
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
> @@ -603,4 +610,15 @@ static inline bool nvmet_ns_has_pi(struct nvmet_ns *ns)
>  	return ns->pi_type && ns->metadata_size == sizeof(struct t10_pi_tuple);
>  }
>  
> +void nvmet_execute_identify_cns_cs_ctrl(struct nvmet_req *req);
> +void nvmet_execute_identify_cns_cs_ns(struct nvmet_req *req);
> +u16 nvmet_process_zns_cis(struct nvmet_req *req, off_t *off);
> +bool nvmet_bdev_zns_config(struct nvmet_ns *ns);
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
> index 000000000000..8ea6641a55e3
> --- /dev/null
> +++ b/drivers/nvme/target/zns.c
> @@ -0,0 +1,390 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * NVMe ZNS-ZBD command implementation.
> + * Copyright (c) 2020-2021 HGST, a Western Digital Company.
> + */
> +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> +#include <linux/uio.h>
> +#include <linux/nvme.h>
> +#include <linux/blkdev.h>
> +#include <linux/module.h>
> +#include "nvmet.h"
> +
> +#ifdef CONFIG_BLK_DEV_ZONED
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
> +static struct block_device *nvmet_bdev(struct nvmet_req *req)
> +{
> +	return req->ns->bdev;
> +}
> +
> +static u64 nvmet_zones_to_descsize(unsigned int nr_zones)
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
> + *  ZNS related command implementation and helprs.
> + */
> +
> +u16 nvmet_process_zns_cis(struct nvmet_req *req, off_t *off)
> +{
> +	u16 nvme_cis_zns = NVME_CSI_ZNS;
> +
> +	if (bdev_is_zoned(nvmet_bdev(req))) {
> +		return nvmet_copy_ns_identifier(req, NVME_NIDT_CSI,
> +						 NVME_NIDT_CSI_LEN,
> +						 &nvme_cis_zns, off);
> +	}
> +
> +	return NVME_SC_SUCCESS;
> +}
> +
> +void nvmet_zns_add_cmd_effects(struct nvme_effects_log *log)
> +{
> +	log->iocs[nvme_cmd_zone_append]		= cpu_to_le32(1 << 0);
> +	log->iocs[nvme_cmd_zone_mgmt_send]	= cpu_to_le32(1 << 0);
> +	log->iocs[nvme_cmd_zone_mgmt_recv]	= cpu_to_le32(1 << 0);
> +}
> +
> +bool nvmet_bdev_zns_config(struct nvmet_ns *ns)
> +{
> +	if (ns->bdev->bd_disk->queue->conv_zones_bitmap) {
> +		pr_err("block device with conventional zones not supported.");
> +		return false;
> +	}
> +	/*
> +	 * SMR drives will results in error if writes are not aligned to the
> +	 * physical block size just override.
> +	 */
> +	ns->blksize_shift = blksize_bits(bdev_physical_block_size(ns->bdev));
> +	return true;
> +}
> +
> +static int nvmet_bdev_report_zone_cb(struct blk_zone *zone, unsigned int idx,
> +				     void *data)
> +{
> +	struct blk_zone *zones = data;
> +
> +	memcpy(&zones[idx], zone, sizeof(struct blk_zone));
> +
> +	return 0;
> +}
> +
> +static void nvmet_get_zone_desc(struct nvmet_ns *ns, struct blk_zone *z,
> +				struct nvme_zone_descriptor *rz)
> +{
> +	rz->zcap = cpu_to_le64(nvmet_sect_to_lba(ns, z->capacity));
> +	rz->zslba = cpu_to_le64(nvmet_sect_to_lba(ns, z->start));
> +	rz->wp = cpu_to_le64(nvmet_sect_to_lba(ns, z->wp));
> +	rz->za = z->reset ? 1 << 2 : 0;
> +	rz->zt = z->type;
> +	rz->zs = z->cond << 4;
> +}
> +
> +/*
> + * ZNS related Admin and I/O command handlers.
> + */
> +void nvmet_execute_identify_cns_cs_ctrl(struct nvmet_req *req)
> +{
> +	struct nvme_id_ctrl_zns *id;
> +	u16 status = 0;
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
> +	id->zasl = 0;
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
> +void nvmet_bdev_execute_zone_mgmt_recv(struct nvmet_req *req)
> +{
> +	struct request_queue *q = nvmet_bdev(req)->bd_disk->queue;
> +	struct nvme_zone_mgmt_recv_cmd *zmr = &req->cmd->zmr;
> +	unsigned int nz = blk_queue_nr_zones(q);
> +	u64 bufsize = (zmr->numd << 2) + 1;
> +	struct nvme_zone_report *rz;
> +	struct blk_zone *zones;
> +	int reported_zones;
> +	sector_t sect;
> +	u64 desc_size;
> +	u16 status;
> +	int i;
> +
> +	desc_size = nvmet_zones_to_descsize(blk_queue_nr_zones(q));
> +	status = nvmet_bdev_zns_checks(req);
> +	if (status)
> +		goto out;
> +
> +	zones = kvcalloc(blkdev_nr_zones(nvmet_bdev(req)->bd_disk),
> +			      sizeof(struct blk_zone), GFP_KERNEL);
> +	if (!zones) {
> +		status = NVME_SC_INTERNAL;
> +		goto out;
> +	}
> +
> +	rz = __vmalloc(bufsize, GFP_KERNEL | __GFP_NORETRY);
> +	if (!rz) {
> +		status = NVME_SC_INTERNAL;
> +		goto out_free_zones;
> +	}
> +
> +	sect = nvmet_lba_to_sect(req->ns, le64_to_cpu(req->cmd->zmr.slba));
> +
> +	for (nz = blk_queue_nr_zones(q); desc_size >= bufsize; nz--)
> +		desc_size = nvmet_zones_to_descsize(nz);

desc_size is actually not used anywhere to do something. So what is the purpose
of this ? If only to determine nz, the number of zones that can be reported,
surely you can calculate it instead of using this loop.

> +
> +	reported_zones = blkdev_report_zones(nvmet_bdev(req), sect, nz,
> +					     nvmet_bdev_report_zone_cb,
> +					     zones);
> +	if (reported_zones < 0) {
> +		status = NVME_SC_INTERNAL;
> +		goto out_free_report_zones;
> +	}
> +
> +	rz->nr_zones = cpu_to_le64(reported_zones);
> +	for (i = 0; i < reported_zones; i++)
> +		nvmet_get_zone_desc(req->ns, &zones[i], &rz->entries[i]);
> +
> +	status = nvmet_copy_to_sgl(req, 0, rz, bufsize);
> +
> +out_free_report_zones:
> +	kvfree(rz);
> +out_free_zones:
> +	kvfree(zones);
> +out:
> +	nvmet_req_complete(req, status);
> +}
> +
> +void nvmet_bdev_execute_zone_mgmt_send(struct nvmet_req *req)
> +{
> +	sector_t nr_sect = bdev_zone_sectors(nvmet_bdev(req));
> +	struct nvme_zone_mgmt_send_cmd *c = &req->cmd->zms;
> +	u16 status = NVME_SC_SUCCESS;
> +	enum req_opf op;
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
> +		break;
> +	}
> +
> +	ret = blkdev_zone_mgmt(nvmet_bdev(req), op, sect, nr_sect, GFP_KERNEL);
> +	if (ret)
> +		status = NVME_SC_INTERNAL;
> +
> +	nvmet_req_complete(req, status);
> +}
> +
> +void nvmet_bdev_execute_zone_append(struct nvmet_req *req)
> +{
> +	unsigned long bv_cnt = min(req->sg_cnt, BIO_MAX_PAGES);
> +	int op = REQ_OP_ZONE_APPEND | REQ_SYNC | REQ_IDLE;
> +	u64 slba = le64_to_cpu(req->cmd->rw.slba);
> +	sector_t sect = nvmet_lba_to_sect(req->ns, slba);
> +	u16 status = NVME_SC_SUCCESS;
> +	int sg_cnt = req->sg_cnt;
> +	struct scatterlist *sg;
> +	size_t mapped_data_len;
> +	struct iov_iter from;
> +	struct bio_vec *bvec;
> +	size_t mapped_cnt;
> +	size_t io_len = 0;
> +	struct bio *bio;
> +	int ret;
> +
> +	if (!nvmet_check_transfer_len(req, nvmet_rw_data_len(req)))
> +		return;
> +
> +	if (!req->sg_cnt) {
> +		nvmet_req_complete(req, 0);
> +		return;
> +	}
> +
> +	bvec = kmalloc_array(bv_cnt, sizeof(*bvec), GFP_KERNEL);
> +	if (!bvec) {
> +		status = NVME_SC_INTERNAL;
> +		goto out;
> +	}
> +
> +	while (sg_cnt) {
> +		mapped_data_len = 0;
> +		for_each_sg(req->sg, sg, req->sg_cnt, mapped_cnt) {
> +			nvmet_file_init_bvec(bvec, sg);
> +			mapped_data_len += bvec[mapped_cnt].bv_len;
> +			sg_cnt--;
> +			if (mapped_cnt == bv_cnt)
> +				break;
> +		}
> +		iov_iter_bvec(&from, WRITE, bvec, mapped_cnt, mapped_data_len);
> +
> +		bio = bio_alloc(GFP_KERNEL, bv_cnt);
> +		bio_set_dev(bio, nvmet_bdev(req));
> +		bio->bi_iter.bi_sector = sect;
> +		bio->bi_opf = op;
> +
> +		ret =  __bio_iov_append_get_pages(bio, &from);
> +		if (unlikely(ret)) {
> +			status = NVME_SC_INTERNAL;
> +			bio_io_error(bio);
> +			kfree(bvec);
> +			goto out;
> +		}
> +
> +		ret = submit_bio_wait(bio);
> +		bio_put(bio);
> +		if (ret < 0) {
> +			status = NVME_SC_INTERNAL;
> +			break;
> +		}
> +
> +		io_len += mapped_data_len;
> +	}
> +
> +	sect += (io_len >> 9);
> +	req->cqe->result.u64 = le64_to_cpu(nvmet_sect_to_lba(req->ns, sect));
> +	kfree(bvec);
> +
> +out:
> +	nvmet_req_complete(req, status);
> +}
> +
> +#else  /* CONFIG_BLK_DEV_ZONED */
> +static void nvmet_execute_identify_cns_cs_ctrl(struct nvmet_req *req)
> +{
> +}
> +static void nvmet_execute_identify_cns_cs_ns(struct nvmet_req *req)
> +{
> +}
> +u16 nvmet_process_zns_cis(struct nvmet_req *req, off_t *off)
> +{
> +	return 0;
> +}
> +static bool nvmet_bdev_zns_config(struct nvmet_ns *ns)
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
