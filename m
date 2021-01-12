Return-Path: <SRS0=XnCc=GP=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9B44C433E0
	for <linux-nvme@archiver.kernel.org>; Tue, 12 Jan 2021 05:33:16 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3720022CBE
	for <linux-nvme@archiver.kernel.org>; Tue, 12 Jan 2021 05:33:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3720022CBE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:To:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=wB3Nm3Wi0MWfRTs9v3WfhpCSiMTlxEteZhMn4XmIAfQ=; b=sor+h66+Ro0XYg7tP6M6VAKSV
	OJp2jqZuJPd/My49PworB0ceY9//72zD/+lSwosoomzyDfBtzsspsy79aQA/zgZrS7lXgCu6e9LwW
	hZWPPNrK22OjEBZWngIHSR0vlCWjLK98JObEz+hMF9py/xs57J1uGKvDJfWq0ZRJVYkWsvowFB3v1
	PKcRpeOadEjezSiwWNRx7hSIxt2rraJRXNQPrQQZRGemvQxOKu8ER3exhlbjySF4Wq/lACNlib3aV
	Uj/7fXj7ACSBFvgb8di4mtw79V58eYjj4UQiH0rMoKewJ5nFRukPnny3M5IbjTs8/hsT5aKmzDzVB
	EczoeMlyQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kzCIe-0001DG-TR; Tue, 12 Jan 2021 05:33:00 +0000
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kzCIW-0001AO-VB
 for linux-nvme@lists.infradead.org; Tue, 12 Jan 2021 05:32:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1610429572; x=1641965572;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=2o5YBI2j8iufzUK6qAgr7Y0RLaaboU5cof8tQlEaGEE=;
 b=nzeu/IPd/xku85SQOhTFGDsg7WS3RYRpWXPssO57Veugf3qnHErfHitA
 RncP1Bkpyhri6od761lT+S7iK/k5ce+e12+Ujoem7J6svBV+ZjCKo2LAS
 hNx2VypzPD50j7JZzER+/xFiqvhcPnSHqfPZ9sqLQGPuHe1nEo8kyQFzY
 nMjE70PX3XLaeHKx5YVdGHHPz5Kedn+rC6ouFAWk0Nz01EGuMH6LUw1rG
 TGBDrCrMAVpuRV/dS8Q1o+e96Fwdue1Xg5HH/qzZLCRvQA0jhcm9QgwKe
 MEHTlYkvVle43sk6IWbHjPyOjxktojDVESW13w4+pE87BmX6sgJXysuwR A==;
IronPort-SDR: EteGVHsSFtNz2fOlzXpWEw1auE4PnagYZzATZiRBoWegTExh0Oc/NdWwpGuu8rdZSqor0Y+A5x
 Ga818RHXw+I3kYpVQwbgqG+hQctxr/cCh8N3iz8pd5YmFA7NQvgoSMgGDvbVg75oyOP+/NMNQW
 ORl5aHlcfQwJg3hDpnRS+DnasrVQLWPslceJoLx50CYzuMhG3ftbvrrUdVmc9gQeTBwVZYAsTR
 AxqaMcIKxZ/yFxAr4CI0Ekqhzec6lIHzyixQOcAUuwPOGC7WOPYYzIfctIDHBl8kVvQ86n/+to
 7zQ=
X-IronPort-AV: E=Sophos;i="5.79,340,1602518400"; d="scan'208";a="157213192"
Received: from mail-bn8nam11lp2176.outbound.protection.outlook.com (HELO
 NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.176])
 by ob1.hgst.iphmx.com with ESMTP; 12 Jan 2021 13:32:50 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ToT3YAzquCEH3YP+DiFexQF2qeUGGZbfetu9YXwBC9eKeAIG8+nY7W+pejidzDiMQ3sxcAJci0GMPuMmeDYMGJiDHaqQQrEYP3oSm3cbp5weZN/8hNYyk6FqSKOi7wT2xVDLwfyUsnTXWzu20ksl0hF14Jcz4yFK7P12O6uzRhL2vfuM4AZ+hbJllKchaF/QE6/7jkAdfz1oJIBv0bZ5n+v5f0VPDjXUHsTus/sSBXeFlo9neqO0xGgSkM32Ov42HpxWXFNw4wR0mb2zvl6VG8xczNZoxaIx7XLD7XEijx2KjoMI8ipuDVAHzaoqWS1BHHjrw3T9kqaXfV9jRjNSGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0Lu/XDeOh6oxHVLuLzTGdVzOBB/7hFjZCSdoaxVKFSw=;
 b=oftVZ9jCSIM7HbqIHuFvQVtp/fh63y0nXoqFRgb2xs8xtqSNmW1iOII62qwZVKrXdE3bKVSVkVE3x7pcvCqgZuEgJXBYfdKqsMBpDCPYN00sXSi3IAfds/6Mjp+AOJCqcwQHDKi+uePT9Bpq482fICOJeIhr6F9yKCZI1aym/vtldiprm36APUj4UfoSEVeEuHj7NE8DDs9W5MaBmoAwfMGjzC7ZQhu6kyH4BXh3fNskg5wqu3g3QBFSuFwFhIU+3H8pc6S9Y8mxjNg3z/tfbtsalur6kXITQvau2Xv3JRR2aNiXSYLq77izmob1gGPS05B3c3u8/1R5kFAwLR2MLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0Lu/XDeOh6oxHVLuLzTGdVzOBB/7hFjZCSdoaxVKFSw=;
 b=bBD6XTdzgTQXcTLdyGDQO0EzH+RfZOIT9wCvyBl0W48gEKTNq8qSRyWh02fudb2iwHUskzI1Io28LWQWhX39oaObsZc8XtMuLBBsLi/RNHSGthH1TPQSMuSho+TAj10ZIaOdqdzegqabuTV0DvFEaGTtQMaaH765FlBaKQLWt+s=
Received: from BL0PR04MB6514.namprd04.prod.outlook.com (2603:10b6:208:1ca::23)
 by MN2PR04MB7071.namprd04.prod.outlook.com (2603:10b6:208:1ec::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.9; Tue, 12 Jan
 2021 05:32:48 +0000
Received: from BL0PR04MB6514.namprd04.prod.outlook.com
 ([fe80::2dbb:7e01:f076:eca0]) by BL0PR04MB6514.namprd04.prod.outlook.com
 ([fe80::2dbb:7e01:f076:eca0%9]) with mapi id 15.20.3742.012; Tue, 12 Jan 2021
 05:32:48 +0000
From: Damien Le Moal <Damien.LeMoal@wdc.com>
To: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH V9 4/9] nvmet: add ZBD over ZNS backend support
Thread-Topic: [PATCH V9 4/9] nvmet: add ZBD over ZNS backend support
Thread-Index: AQHW6Jsz5Um6YbJoj0ev+CR8KYF1Aw==
Date: Tue, 12 Jan 2021 05:32:48 +0000
Message-ID: <BL0PR04MB6514A4C7F0F7A2627C4639B3E7AA0@BL0PR04MB6514.namprd04.prod.outlook.com>
References: <20210112042623.6316-1-chaitanya.kulkarni@wdc.com>
 <20210112042623.6316-5-chaitanya.kulkarni@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2400:2411:43c0:6000:5cb8:2b48:5f8c:2c03]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: f333d7d5-a3c5-464c-170c-08d8b6bb7f65
x-ms-traffictypediagnostic: MN2PR04MB7071:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR04MB7071CB9E971E31DBEF3A217AE7AA0@MN2PR04MB7071.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: m/qzVhJLxDOVl3h8riFJG5PPhG7UlwIbNk84EkJW7vOazJZ9cp8HIweXH4Ifve4UsUyLAi1jeJmHeHseGnzY++PkNtE+hgrTVuQE+Vh2YyB/oCxwnjHhrf6FsrqK21EuVT3aYZk1d3EqglmhrOKiUlyxOTgLf9ECBtYt7ctWO12xqhzrKdI5sP6MitCiEsupZg+EDquSg3cy63o2FzLC73Yx1vHVfVobxyVoQ4HFtIai3Fir5DhZ1z6lTrh53TbpyJ5TgfuNqchhHC+QklwR8njxJm8MIMGFYKqJ6bR3dL8CVzpvF94NMwaR5LmRYgkrwBQq/c3LKlsoa3AZW37HwIEK0dvlKi3eQgs3gM1N3wMdueUdKXq6Pup3BGnirSCGIDZ62d+ao6cy2mWu9pnNag==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR04MB6514.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(366004)(396003)(346002)(136003)(376002)(110136005)(64756008)(66556008)(76116006)(54906003)(186003)(9686003)(66446008)(91956017)(66946007)(8676002)(316002)(66476007)(4326008)(71200400001)(53546011)(55016002)(7696005)(33656002)(52536014)(86362001)(5660300002)(6506007)(478600001)(83380400001)(8936002)(30864003)(2906002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: =?Windows-1252?Q?SuM4MGVmtD3ZqYaAgWX9P0F8lrDG8EyDDUCKS6OQlhC8lXL4VP2dFqz/?=
 =?Windows-1252?Q?PlF889EIjr7uQq0jKMmmyM7Z6oUn1JqHiwBwK2VmRJWLkIg6ZxdF1smN?=
 =?Windows-1252?Q?9eDkzD+rtnDg/oTa6pOOQW3RtkUNbLZrA+wifAK6NA0Fc5ZmsrFC1gs/?=
 =?Windows-1252?Q?F+LwN20SZKUMVgdrTwrLNVrVrPRXtIaiT+tOp2wl3ZJ3P2JAFZSpK97L?=
 =?Windows-1252?Q?GxpFGdPil4D8kTGAc2Tidv42TeOA1eTYX2RjBHIoN0udeHCD3wd84NZT?=
 =?Windows-1252?Q?I4IorPkVkIYFv2mtim//tvbS+tBprsPEMfp+wOHqfsstTCqyTNmhsfzZ?=
 =?Windows-1252?Q?OT0Idyir5z1RSwgEGL2IS3vOrRz6NeTocGMibVWBuTCxCItPNzrYAVZ1?=
 =?Windows-1252?Q?I5X9jyiVHFehcbevaTNsofwh6hOPY5ULXutlcPdrk3hCvej3h/4L5Gv7?=
 =?Windows-1252?Q?tKl6hPUwFbuquZllz6p2FUTSezjd8QuPoCs8vdwljSNHOKALBDNmh5LL?=
 =?Windows-1252?Q?ZnHWz+iqS0TPRbVEChgEQngUiVfiazJeLe0/Z3HEFK0PRkywhwjXgcRP?=
 =?Windows-1252?Q?f/hMncnljCIa+LdK/R9F08YnCTMQIUSqw74DB8dstDu8FSKtI5uaC8Tm?=
 =?Windows-1252?Q?xZ5ZvPD6X7yPFRF7kh/sBjAcK6p2H28niZDtDjtxjY7CAbBVJJq/+ghi?=
 =?Windows-1252?Q?ilk0cmUzE30CXqrXRnGXLVLavhtt3hDUf1zakYhPGdfcUB1PYUTFsQAe?=
 =?Windows-1252?Q?kifVSENFIkipMRCl/IDg9g4EVtdUC7Cvd/0WgzaHJIdlbbaj0yXr1kUu?=
 =?Windows-1252?Q?fRxBrNhlnJlKx47+gOss7AF6dsLF3QswQ/COgyms0hNZxUgJClePXXBG?=
 =?Windows-1252?Q?cOzIgQvIbPNZhjUCRjEbTl0eCxviiq2zEqg8UkLrRzlhsyfLP5wRxyzq?=
 =?Windows-1252?Q?lawv0edeVo8S3C8gSQSJHllCe638dRkIP5BZu7/hiFa6jmxGL13LSAzi?=
 =?Windows-1252?Q?XNd/FqHsZuBxWlcfyq74JzI7E3zsFlfydD3bIYGUDAsBhhwIt8Y8GXaA?=
 =?Windows-1252?Q?5mfeAuLbTJOOwgt/KWOISfl6PDS2d/B4OWig171ymb1A3L/cLKz8d1qu?=
 =?Windows-1252?Q?EF/1qeftc26oKMoHDIeIwRLf?=
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR04MB6514.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f333d7d5-a3c5-464c-170c-08d8b6bb7f65
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jan 2021 05:32:48.4619 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: f6thXTrTgx3EaiIKNilmWEhAmQB1iGcL38K6chYkb9F2tDqmm74eTsekHPEB7GnGg+YcSYjy68PD/EJSO1UoGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB7071
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210112_003253_347992_532A1EA0 
X-CRM114-Status: GOOD (  22.25  )
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
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 2021/01/12 13:27, Chaitanya Kulkarni wrote:
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

> With new command set identifier we also update the target command effects
> logs to reflect the ZNS compliant commands.
> =

> Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
> ---
>  drivers/nvme/target/Makefile      |   1 +
>  drivers/nvme/target/admin-cmd.c   |  28 +++
>  drivers/nvme/target/core.c        |   3 +
>  drivers/nvme/target/io-cmd-bdev.c |  33 ++-
>  drivers/nvme/target/nvmet.h       |  38 ++++
>  drivers/nvme/target/zns.c         | 342 ++++++++++++++++++++++++++++++
>  6 files changed, 437 insertions(+), 8 deletions(-)
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
> index a50b7bcac67a..bdf09d8faa48 100644
> --- a/drivers/nvme/target/admin-cmd.c
> +++ b/drivers/nvme/target/admin-cmd.c
> @@ -191,6 +191,15 @@ static void nvmet_execute_get_log_cmd_effects_ns(str=
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

Is it OK to not return an error here if CONFIG_BLK_DEV_ZONED is not enabled=
 ?
I have not checked the entire code of this function nor how it is called, s=
o I
may be wrong.

> +		break;
>  	default:
>  		status =3D NVME_SC_INVALID_LOG_PAGE;
>  		break;
> @@ -644,6 +653,17 @@ static void nvmet_execute_identify_desclist(struct n=
vmet_req *req)
>  	if (status)
>  		goto out;
>  =

> +	if (IS_ENABLED(CONFIG_BLK_DEV_ZONED)) {
> +		u16 nvme_cis_zns =3D NVME_CSI_ZNS;
> +
> +		if (req->ns->csi =3D=3D NVME_CSI_ZNS)
> +			status =3D nvmet_copy_ns_identifier(req, NVME_NIDT_CSI,
> +							  NVME_NIDT_CSI_LEN,
> +							  &nvme_cis_zns, &off);
> +		if (status)
> +			goto out;
> +	}

Same comment here.

> +
>  	if (sg_zero_buffer(req->sg, req->sg_cnt, NVME_IDENTIFY_DATA_SIZE - off,
>  			off) !=3D NVME_IDENTIFY_DATA_SIZE - off)
>  		status =3D NVME_SC_INTERNAL | NVME_SC_DNR;
> @@ -660,8 +680,16 @@ static void nvmet_execute_identify(struct nvmet_req =
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
> index 672e4009f8d6..17d5da062a5a 100644
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
> @@ -1173,6 +1174,8 @@ static void nvmet_init_cap(struct nvmet_ctrl *ctrl)
>  {
>  	/* command sets supported: NVMe command set: */
>  	ctrl->cap =3D (1ULL << 37);
> +	if (IS_ENABLED(CONFIG_BLK_DEV_ZONED))
> +		ctrl->cap |=3D (1ULL << 43);
>  	/* CC.EN timeout in 500msec units: */
>  	ctrl->cap |=3D (15ULL << 24);
>  	/* maximum queue entries supported: */
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
> index 476b3cd91c65..7361665585a2 100644
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
> index 000000000000..2a71f56e568d
> --- /dev/null
> +++ b/drivers/nvme/target/zns.c
> @@ -0,0 +1,342 @@
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
> +	u16 status =3D NVME_SC_SUCCESS;
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

You really want to keep this (useless) label ? Without it, the status varia=
ble
can be dropped and the code overall becomes so much easier to read... Not to
mention that life will be easier to the compiler for optimizing this.

> +	return status;
> +}
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
> +
> +static int nvmet_bdev_validate_zns_zones_cb(struct blk_zone *z,
> +					    unsigned int idx, void *data)
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
> +	return ret < 0 ? true : false;

return ret <=3D 0;

would be simpler.

Note that "<=3D" includes the error case of the device not reporting any zo=
ne
(device dead) as we should fail that case I think.

> +}
> +
> +bool nvmet_bdev_zns_enable(struct nvmet_ns *ns)
> +{
> +	if (nvmet_bdev_has_conv_zones(ns->bdev))
> +		return false;
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
> +	u16 status =3D NVME_SC_SUCCESS;
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
> +	entries[idx].zcap =3D nvmet_sect_to_lba(ns, z->capacity);
> +	entries[idx].zslba =3D nvmet_sect_to_lba(ns, z->start);
> +	entries[idx].wp =3D nvmet_sect_to_lba(ns, z->wp);
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
> +	u32 bufsize =3D (le32_to_cpu(req->cmd->zmr.numd) + 1) << 2;
> +	struct nvmet_report_zone_data data =3D { .ns =3D req->ns };
> +	unsigned int nr_zones;
> +	int reported_zones;
> +	u16 status;
> +
> +	nr_zones =3D (bufsize - sizeof(struct nvme_zone_report)) /
> +			sizeof(struct nvme_zone_descriptor);

I really would prefer this code to be moved down, before the call to
blkdev_report_zones().

You can also optimize this value a little with a min() of the value above a=
nd of
DIV_ROUND_UP(dev_capacity - sect, zone size). But not a big deal I think.

> +
> +	status =3D nvmet_bdev_zns_checks(req);
> +	if (status)
> +		goto out;
> +
> +	data.rz =3D __vmalloc(bufsize, GFP_KERNEL | __GFP_NORETRY | __GFP_ZERO);

Shouldn't this be GFP_NOIO ? Also, is the NORETRY critical ?
blkdev_report_zones() will do mem allocation too and at leadt scsi does ret=
ry.

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
> +	enum req_opf op;
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

GFP_NOIO ?

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
