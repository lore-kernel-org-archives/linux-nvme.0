Return-Path: <SRS0=/gup=YB=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54472C47404
	for <linux-nvme@archiver.kernel.org>; Tue,  8 Oct 2019 02:30:21 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1578B206BB
	for <linux-nvme@archiver.kernel.org>; Tue,  8 Oct 2019 02:30:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="KHGD6IF0";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="d51Ijly3";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="gMmCg0Dg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1578B206BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date
	:Subject:To:From:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=rXxA5wv41wUv0UMLvtiQfJXhI9BaZfcxoDL0scfo61M=; b=KHGD6IF0926GTl
	j0+a+f7vSd7LY8WT90hQl8LjWXpCKNjG6vxAkh1wUNL4Xq3ZcJSMwFyrH0nLlOiorqMF481JwGNhS
	y28FdBDdmWvwJTEEcVQZnWS9l0YexEg/MPPCiZCHF5pKDtuhGaTRhGereK79p1lMT/cQ9Xz4XMniI
	B4gE8c4exFQVoWV2INSEePdvTDvCl3MJhXo1N9yvu5/z4/dLsyPFBtutxY296kndktjUMp7isxWQU
	70NfqigCCsRCYuvhBIZZxsvPBZAjZIHr8a3cvlyr6f4DP8u9Zom23CcTzw5SpKC7U4BDkGVaCdx3d
	+Chr2GxOCYRMxG1LORgw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.2 #3 (Red Hat Linux))
	id 1iHfGS-0005m3-Aw; Tue, 08 Oct 2019 02:30:16 +0000
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
 by bombadil.infradead.org with esmtps (Exim 4.92.2 #3 (Red Hat Linux))
 id 1iHfGP-0005YM-33
 for linux-nvme@lists.infradead.org; Tue, 08 Oct 2019 02:30:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1570501812; x=1602037812;
 h=from:to:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=86gyY0fCCivtMTpreGrtNad3V9ZLhlPL0cJbwW41akg=;
 b=d51Ijly3/1XT0zNvBUbCilLcTAxJhZCz2baYHNKjn5UWsnWHtO4AFoYt
 u6l5HVFVDM/Ox/5abVwZmi9OiHFebWoNVnFrc5LkNMztRrqnnPIoIUo48
 xznY7gR8Sgv5+gb0ekrz0gNo3WuJV3t0+JD0S1GmDXKpXDtynPUlyZRB1
 jAqYJP5gPlFh1Rz5MUIU7WKuH4+cksjADM5bwZFYICCf1W7+RFpLnCwPD
 JVQFr1SSn6bkYZb5AQQz/yVOC64ht4bMi5btsSsX59wpq/OGMtC+VVRRu
 KgFkJLqJcjZq39JwAyIGtDUdKXeAKL2sIR7d0WAwe3GrSyGICXhwUe/vb g==;
IronPort-SDR: yjW59mlAzBnhe6bIYNdeg6HfvJfpBCVMGCizPnIg+/9ewYRvLScodVIVMwq0GVlS2T1yGmSG82
 uWi4h8QHm+zB/mEm9gRw0xxn8av0ez3f7iZToQHXS5ADbfSxObWwrUcDsklFI781lLZyh8/d3+
 bzhZ415VTtI7FGab6o1B559PNPylg0KtWTufJ4YZbP2rhTkJAMMSKrE+k7Hdamz/x5EI3oUBfp
 mf4rK2Q1XzGexTRbZQoy7Q+qlw1rlpRBYnz1HbtNyNtaPu+3NT2fBcfoxgGp/okaHXasSHxRcB
 5EY=
X-IronPort-AV: E=Sophos;i="5.67,269,1566835200"; d="scan'208";a="119990203"
Received: from mail-by2nam05lp2059.outbound.protection.outlook.com (HELO
 NAM05-BY2-obe.outbound.protection.outlook.com) ([104.47.50.59])
 by ob1.hgst.iphmx.com with ESMTP; 08 Oct 2019 10:30:07 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XNGH2YQgLASYbz82PXnThb/EX74/4jLkLJo2E7faBeLKLb50w21oHWwoQI6NNO56GdPVKvrDfuNqdgwGl1AhY4zRQ8iW6h/4YIDU3MhidSH7xo1dAhGjYiM3ZGY8apTdixzLAiJulRgw0zbOmOJwoDTotVIB+bKwb5SW8kBzH0WaFXGZo1qwD3tRqispjeDa1A+rQRpEz4RsCwZqRdTKOStT4G0WTVU13zIlbTob7DixnMp5yXHQ7JZR2f53bPZRxAbJqDsEHYqQe+G1w2DbzEZj9aZOW5g3fX0i0jx9e5Vq+bar/qSvVWyJVqgXvRzDP2Zg2RbSUIghqj7YXAqBHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uH0TCBQ4zS7D1d1unfDD8jWbTsBqFtoJdGC8xdd5cJQ=;
 b=LadskgPWaco4Kuhrk+WPCODk4YzeKdHoN8Xs0E5QfY3HSfO7IBJvy5aFjxihZVDPpsETQKDDv1UFc5bO+DqTaqf+HSzLd7t4OWSjqats/Svrfbhat0BN9eSTRU66bUddptnx5GJUXwlwdqoTooxgur3FmqB55+0zT1O69ilGAnOSsCJsv42BX7IuH91zCC5IMJxehwRMM67Oo0p9pPm8TorG9jDFWhI+vtxB14YWpEt5K2cttWrpH+0Ys33hThVPLT3EsuHrtFpe+5RaCFbWVvBfOSkk0QhCdcZN6XGsj01S/VfrOP9d2QnCfUpuRmJqznKbilvSkI+QbgJIwmMh7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uH0TCBQ4zS7D1d1unfDD8jWbTsBqFtoJdGC8xdd5cJQ=;
 b=gMmCg0DgL8Iuh8ncFzxkos3JFe+pibCyBL903LeUbg6YFWroEnNvF6ii0iASNjQNr/cILwlf9j0DspC+Ne9xC2asU4YGZmw97Aty23QMfLzc2LEUWl3+PWQHcfi3+KmsxvJSvemhapHn3fVA7gektsu+K3ovT97Kzpc+8QbxbFY=
Received: from DM6PR04MB5754.namprd04.prod.outlook.com (20.179.52.22) by
 DM6PR04MB4940.namprd04.prod.outlook.com (20.176.109.89) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2327.24; Tue, 8 Oct 2019 02:30:06 +0000
Received: from DM6PR04MB5754.namprd04.prod.outlook.com
 ([fe80::9894:e31d:c666:a0dc]) by DM6PR04MB5754.namprd04.prod.outlook.com
 ([fe80::9894:e31d:c666:a0dc%7]) with mapi id 15.20.2327.023; Tue, 8 Oct 2019
 02:30:06 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: "m.malygin@yadro.com" <m.malygin@yadro.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH v4] nvmet: add revalidate ns sysfs attribute to handle
 device resize
Thread-Topic: [PATCH v4] nvmet: add revalidate ns sysfs attribute to handle
 device resize
Thread-Index: AQHVfUl5xqyTn+kW4ka8T4nspUS+yA==
Date: Tue, 8 Oct 2019 02:30:06 +0000
Message-ID: <DM6PR04MB57544FD6592EAD5A6E4B037B869A0@DM6PR04MB5754.namprd04.prod.outlook.com>
References: <20190926231940.7494-1-m.malygin@yadro.com>
 <20191007195709.6227-1-m.malygin@yadro.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chaitanya.Kulkarni@wdc.com; 
x-originating-ip: [2605:e000:3e45:f500:99c1:d13f:2483:e251]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c0f78703-d26b-455c-30b2-08d74b976e83
x-ms-office365-filtering-ht: Tenant
x-ms-traffictypediagnostic: DM6PR04MB4940:
x-microsoft-antispam-prvs: <DM6PR04MB49402C54E9191F807A8FFB39869A0@DM6PR04MB4940.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 01842C458A
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(4636009)(396003)(136003)(346002)(39860400002)(366004)(376002)(189003)(199004)(64756008)(110136005)(99286004)(74316002)(66446008)(91956017)(446003)(66476007)(7696005)(6506007)(53546011)(5660300002)(55016002)(76116006)(102836004)(66946007)(46003)(476003)(186003)(66556008)(76176011)(486006)(52536014)(2501003)(33656002)(81156014)(81166006)(256004)(6116002)(14444005)(14454004)(6246003)(8936002)(25786009)(305945005)(7736002)(478600001)(8676002)(229853002)(86362001)(6436002)(71190400001)(316002)(71200400001)(2906002)(9686003);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DM6PR04MB4940;
 H:DM6PR04MB5754.namprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GkHuzKWuuErojqSAdwibSgOWD+ZmTD+/EcgkgAdCatp6OvVqz1yvQN0+zlaWq94/mW58G8gZRBHgV40womsSMh0AweM0xsylN8+yBNIs4+NjSU+qOGugRuqXcnWwH1fKs/KF9df3hlylR3UXHPmvm59C5qc7AkU/kebrOpmBPkZtomaoA0CJ61FT6N7yKB4dzStJYOxKf8SbnuKRqavEG2yYT1eJYsLuEAO6S4L7bwFQsoXqh4HDzEpom1cy1e9rfmviHJhYnmC/dB3mTjcr8w3APSJ2tZ667OncJFAr3nF3h1BkB0kpna30/IUCKtrPr2MYo8v2RwuCpl958Io0Uz04LMANWNeJaZ48wXYQSR+HQkk88x89ZP4eOf+DcUpPW5FZa7/K94yJaIaIx7f7RQQvrSEvrvl11sUbC+o4e/Q=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0f78703-d26b-455c-30b2-08d74b976e83
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Oct 2019 02:30:06.0971 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gJAPjD+otOcm+JvU4BKwIA75v5s4y02UuZAUbIyqlh8FEgi6Xp6XrtaS1z+1/emEI7Lwv6QgLeG2Fw/GlBUBGuVNr8XiRllFJLjEdv/MrkY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB4940
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191007_193013_359243_D0425EC2 
X-CRM114-Status: GOOD (  16.73  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Hi Mikhail,

Please some inline nit comments.

On 10/7/19 12:57 PM, m.malygin@yadro.com wrote:
> From: Mikhail Malygin <m.malygin@yadro.com>
> nit :-
> Currently device size is cached in ns->size field on namespace enable, so
> any device size change after that can't bee seen by initiator.
nit :- any device size change after that can't bee seen by the
initiator.
> This patch adds revalidate namespace attribute. Once it is written,
> target refreshes ns->size property and calls nvmet_ns_changed
> so initator may perform namespace rescan

nit :- so initiator may perform namespace rescan.

> 
> Signed-off-by: Mikhail Malygin <m.malygin@yadro.com>
> ---
>   drivers/nvme/target/configfs.c    | 16 +++++++++++++++
>   drivers/nvme/target/core.c        | 27 ++++++++++++++++++++++++
>   drivers/nvme/target/io-cmd-bdev.c | 10 +++++++--
>   drivers/nvme/target/io-cmd-file.c | 34 +++++++++++++++++++++----------
>   drivers/nvme/target/nvmet.h       |  3 +++
>   5 files changed, 77 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
> index 98613a45bd3b..337e967190c5 100644
> --- a/drivers/nvme/target/configfs.c
> +++ b/drivers/nvme/target/configfs.c
> @@ -545,6 +545,21 @@ static ssize_t nvmet_ns_buffered_io_store(struct config_item *item,
>   
>   CONFIGFS_ATTR(nvmet_ns_, buffered_io);
>   
> +static ssize_t nvmet_ns_revalidate_store(struct config_item *item,
> +		const char *page, size_t count)
> +{
> +	struct nvmet_ns *ns = to_nvmet_ns(item);
> +	int ret;
> +
> +	ret = nvmet_ns_revalidate(ns);
> +	if (ret)
> +		return ret;
> +
> +	return count;
> +}
> +
> +CONFIGFS_ATTR_WO(nvmet_ns_, revalidate);
> +
>   static struct configfs_attribute *nvmet_ns_attrs[] = {
>   	&nvmet_ns_attr_device_path,
>   	&nvmet_ns_attr_device_nguid,
> @@ -552,6 +567,7 @@ static struct configfs_attribute *nvmet_ns_attrs[] = {
>   	&nvmet_ns_attr_ana_grpid,
>   	&nvmet_ns_attr_enable,
>   	&nvmet_ns_attr_buffered_io,
> +	&nvmet_ns_attr_revalidate,
>   #ifdef CONFIG_PCI_P2PDMA
>   	&nvmet_ns_attr_p2pmem,
>   #endif
> diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
> index 3a67e244e568..122bcbdb5c05 100644
> --- a/drivers/nvme/target/core.c
> +++ b/drivers/nvme/target/core.c
> @@ -620,6 +620,33 @@ void nvmet_ns_disable(struct nvmet_ns *ns)
>   	mutex_unlock(&subsys->lock);
>   }
>   
> +int nvmet_ns_revalidate(struct nvmet_ns *ns)
> +{
> +	struct nvmet_subsys *subsys = ns->subsys;
> +	loff_t ns_size = ns->size;
> +	u32 ns_blksize_shift = ns->blksize_shift;
> +	int ret = 0;
nit:- Please consider :-
	struct nvmet_subsys *subsys = ns->subsys;
	u32 ns_blksize_shift = ns->blksize_shift;
	loff_t ns_size = ns->size;
	int ret = 0;
> +
> +	mutex_lock(&subsys->lock);
> +	if (!ns->enabled)
> +		goto out_unlock;
> +
> +	if (ns->bdev)
> +		nvmet_bdev_ns_read_size(ns);
> +	else if (ns->file)
> +		ret = nvmet_file_ns_read_size(ns);
> +
> +	if (ret)
> +		goto out_unlock;

Nit:- since ret gets initialized as a part of the ns->file == true
why not ?
	if (ns->bdev)
		nvmet_bdev_ns_read_size(ns);
	else if (ns->file) {
		ret = nvmet_file_ns_read_size(ns);
		if (ret)
			goto out_unlock
	}
> +
> +	if (ns->size != ns_size || ns->blksize_shift != ns_blksize_shift)
> +		nvmet_ns_changed(subsys, ns->nsid);
> +
> +out_unlock:
> +	mutex_unlock(&subsys->lock);
> +	return ret;
> +}
> +
>   void nvmet_ns_free(struct nvmet_ns *ns)
>   {
>   	nvmet_ns_disable(ns);
> diff --git a/drivers/nvme/target/io-cmd-bdev.c b/drivers/nvme/target/io-cmd-bdev.c
> index de0bff70ebb6..ac8229deeccc 100644
> --- a/drivers/nvme/target/io-cmd-bdev.c
> +++ b/drivers/nvme/target/io-cmd-bdev.c
> @@ -47,6 +47,12 @@ void nvmet_bdev_set_limits(struct block_device *bdev, struct nvme_id_ns *id)
>   	id->nows = to0based(ql->io_opt / ql->logical_block_size);
>   }
>   
> +void nvmet_bdev_ns_read_size(struct nvmet_ns *ns)
> +{
> +	ns->size = i_size_read(ns->bdev->bd_inode);
> +	ns->blksize_shift = blksize_bits(bdev_logical_block_size(ns->bdev));
> +}
> +
>   int nvmet_bdev_ns_enable(struct nvmet_ns *ns)
>   {
>   	int ret;
> @@ -62,8 +68,8 @@ int nvmet_bdev_ns_enable(struct nvmet_ns *ns)
>   		ns->bdev = NULL;
>   		return ret;
>   	}
> -	ns->size = i_size_read(ns->bdev->bd_inode);
> -	ns->blksize_shift = blksize_bits(bdev_logical_block_size(ns->bdev));
> +
> +	nvmet_bdev_ns_read_size(ns);
>   	return 0;
>   }
>   
> diff --git a/drivers/nvme/target/io-cmd-file.c b/drivers/nvme/target/io-cmd-file.c
> index 05453f5d1448..cff39fea6d85 100644
> --- a/drivers/nvme/target/io-cmd-file.c
> +++ b/drivers/nvme/target/io-cmd-file.c
> @@ -27,10 +27,30 @@ void nvmet_file_ns_disable(struct nvmet_ns *ns)
>   	}
>   }
>   
> +int nvmet_file_ns_read_size(struct nvmet_ns *ns)
> +{
> +	int ret;
> +	struct kstat stat;
nit again :-
	struct kstat stat;
	int ret;
> +
> +	ret = vfs_getattr(&ns->file->f_path, &stat, STATX_SIZE,
> +				AT_STATX_FORCE_SYNC);
> +	if (ret)
> +		return ret;
> +
> +	ns->size = stat.size;
> +	/*
> +	 * i_blkbits can be greater than the universally accepted upper bound,
> +	 * so make sure we export a sane namespace lba_shift.
> +	 */
> +	ns->blksize_shift = min_t(u8,
> +			file_inode(ns->file)->i_blkbits, 12);
> +
> +	return 0;
> +}
> +
>   int nvmet_file_ns_enable(struct nvmet_ns *ns)
>   {
>   	int flags = O_RDWR | O_LARGEFILE;
> -	struct kstat stat;
>   	int ret;
>   
>   	if (!ns->buffered_io)
> @@ -43,19 +63,11 @@ int nvmet_file_ns_enable(struct nvmet_ns *ns)
>   		return PTR_ERR(ns->file);
>   	}
>   
> -	ret = vfs_getattr(&ns->file->f_path,
> -			&stat, STATX_SIZE, AT_STATX_FORCE_SYNC);
> +	ret = nvmet_file_ns_read_size(ns);
nit:- no need for following new line.
> +
>   	if (ret)
>   		goto err;
>   
> -	ns->size = stat.size;
> -	/*
> -	 * i_blkbits can be greater than the universally accepted upper bound,
> -	 * so make sure we export a sane namespace lba_shift.
> -	 */
> -	ns->blksize_shift = min_t(u8,
> -			file_inode(ns->file)->i_blkbits, 12);
> -
>   	ns->bvec_cache = kmem_cache_create("nvmet-bvec",
>   			NVMET_MAX_MPOOL_BVEC * sizeof(struct bio_vec),
>   			0, SLAB_HWCACHE_ALIGN, NULL);
> diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
> index c51f8dd01dc4..ccdfdcfce65b 100644
> --- a/drivers/nvme/target/nvmet.h
> +++ b/drivers/nvme/target/nvmet.h
> @@ -408,6 +408,7 @@ struct nvmet_ns *nvmet_find_namespace(struct nvmet_ctrl *ctrl, __le32 nsid);
>   void nvmet_put_namespace(struct nvmet_ns *ns);
>   int nvmet_ns_enable(struct nvmet_ns *ns);
>   void nvmet_ns_disable(struct nvmet_ns *ns);
> +int nvmet_ns_revalidate(struct nvmet_ns *ns);
>   struct nvmet_ns *nvmet_ns_alloc(struct nvmet_subsys *subsys, u32 nsid);
>   void nvmet_ns_free(struct nvmet_ns *ns);
>   
> @@ -485,6 +486,8 @@ int nvmet_bdev_ns_enable(struct nvmet_ns *ns);
>   int nvmet_file_ns_enable(struct nvmet_ns *ns);
>   void nvmet_bdev_ns_disable(struct nvmet_ns *ns);
>   void nvmet_file_ns_disable(struct nvmet_ns *ns);
> +void nvmet_bdev_ns_read_size(struct nvmet_ns *ns);
> +int nvmet_file_ns_read_size(struct nvmet_ns *ns);
>   u16 nvmet_bdev_flush(struct nvmet_req *req);
>   u16 nvmet_file_flush(struct nvmet_req *req);
>   void nvmet_ns_changed(struct nvmet_subsys *subsys, u32 nsid);
> 


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
