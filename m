Return-Path: <SRS0=dOZ+=AN=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 599AEC433E0
	for <linux-nvme@archiver.kernel.org>; Thu,  2 Jul 2020 08:27:47 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1DB4D206A1
	for <linux-nvme@archiver.kernel.org>; Thu,  2 Jul 2020 08:27:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="kxVTgl1g";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Hq6LBOd5";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="e0jiP7br"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DB4D206A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:To:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=TydNz/6NMYzsceIeK/mE4M3L4XCEwyjCY0tnseJFVUk=; b=kxVTgl1gFXDsecWNu8SId+yQq
	BleWMFj0JA69go7jrx0Xdnjmdu9FizUQ5vxSiTUqasy88qQJsgcZ+nvdbSQE8w+OkAhubseypmu72
	weIsvxxQN1IS/wMF8YNTWd1MAebwpYzJKH/JtEp613KMmwTqeyJH3I8PCTFNhlIZQToPqpKNBzHNJ
	nfbS4edsIFHIkwDKjW34t673H9Wb4xvxwW6wR66dL2WUFLiSU7ErNsZXH+tFV+KyeFx8L3tWD61hM
	obXBIPZvLJgSeIbdrP7vm8lt3cLOqHkJYlPV6PDPORAEMdwiABU3YcR23RkqkrJK2oUSPLewUIN9r
	37+1kNIQA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jquZI-0008PV-O0; Thu, 02 Jul 2020 08:27:40 +0000
Received: from esa3.hgst.iphmx.com ([216.71.153.141])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jquZG-0008Ot-89
 for linux-nvme@lists.infradead.org; Thu, 02 Jul 2020 08:27:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1593678458; x=1625214458;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=0mgAy5Fois3hphkaBHBjfl2G+1g9w2bLouVEiGb6SHI=;
 b=Hq6LBOd5XGPglb/wcm9Y2vLHJbEkXtlMd0j9+3jdiGg2wVoZ0UbuMy0/
 S8RRv3uHZSuA91Wne7oWDN3ghePKV/Sq96RF/yngdDxhoM254G5QifMV0
 5RWEUUwmTGeahRTZ6V/HRuq3+9nedouX5u+fU910+Z37omvBTX01YCyoP
 0jjKzFn9bl3eayZBo/hP5kKP7H/NKzH6hPqeTdhI3ky+RQJMvabujreua
 qXsOe6DPLGyQDWahJIvLxiq0+H1D5W4KVI2NASQYoRdQkWoFQlEA6hTEL
 HZrCav4xoucVcj4mJRHq7YO36pmQ0hIdP+nGFIpSLupZu7TuAgmR1wN08 g==;
IronPort-SDR: QkSMG5MyhhIcNwkVqLhg54tOX88lVrBr/pgcMonB6BIsP4uXVKchZl2CZI9yMX+vkfbmCJKJk1
 6wrxSO7GW5RanPK6vspGNeREjimjj/yuxsSVkUj8iIAg38EC7T0Ln9a/3qDhZNsd66hTfJSrpe
 8sthRIugzZav/nDjq9aiLuvewFNpDhDvbyBcvRtryWtRm4UIxFtHqLdBYrYuEeBDVctsOcgViQ
 A7ue2eMSkzjkLTSVSNVyrw+OjApGFNpqoqkX32AKmLvXwZv03ZyRY5SLaUyn+CMpUZW2vsKUyk
 c/M=
X-IronPort-AV: E=Sophos;i="5.75,303,1589212800"; d="scan'208";a="145792219"
Received: from mail-dm6nam11lp2171.outbound.protection.outlook.com (HELO
 NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.171])
 by ob1.hgst.iphmx.com with ESMTP; 02 Jul 2020 16:27:36 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lR/jq0kdS0vyQna8pUuMppHa+2dziCqDDEw8Ru0xBMyHD9stnNyl5E25QdmXrcSjc6zlNgTZR46rGj0Wj9zvfBA8dhK81A2auKYxzZTCiFPSqZatf05pKrRliEJU9RBLEWEByO1KkfJSlTxm1tTwtBoFOMUWy7mmPCk6dQbaanm+nVruw1Qoi/KQIgxYtCqrc3uNdXtGyLMTP30N5Ez5zsL7q5vuVkBHn38HMNnVieX2DC7ZJwhifLuLGLxbSRYnkCNLy4AxFdMGOCxdnjEWBGk5lSKEUynhZI9LY0rsi3ZMe9lo3Z64AEMkbVKoNcrgJd68NYdlhiatTomS33IcTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YgpdtUhpE7nz9aEW9WhriAiOZQC7omkCzd/R7Jux5R4=;
 b=ZPEP2aOLsbePh/0POscjBT51YGyFwNWVyiz67iHJAPX9VAsbjtsD5mSTh8nxTwM+Ho8uLCp/MKXL0oViK9r6p8Bxg1703Bxq6kdLBxxCOZlk/kwNo0xJbaDxzQtnyM38GhXNaqDVoJl4dqM7CgY6Zy4SyyHqg1EnQUE7r4AOjkgIK3tFntCySPWMeUjO3fTm0fTcCnHlOk856a1JoBAzRc7C2Auub40oUj+1eaFicTMdBdn0XSYkvWJshAtD+uzvMXchN7gNP+EzdV0eoTBjfmR0TBLAc99utxvNfF9H+/k1mgwVfD1pv7lYITh1fRClvlg52xSmJcjk8G55ZY1zkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YgpdtUhpE7nz9aEW9WhriAiOZQC7omkCzd/R7Jux5R4=;
 b=e0jiP7brOwxOtkZ1XfjDoDWP4JPA4IxBbXcXhmDMryYvEElrjfo0riAzOY84mH6x7lIann+ptWmGxwEIxpXcXZuB3ikgDtcT8/1BG+eCdwAfHGcN0c/RjNNqRnQDkZzUJ+9YK+fwb65VD/E89tzRVNlapkllosuaStEEuZxYx60=
Received: from CY4PR04MB3751.namprd04.prod.outlook.com (2603:10b6:903:ec::14)
 by CY4PR04MB1174.namprd04.prod.outlook.com (2603:10b6:903:bb::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.21; Thu, 2 Jul
 2020 08:27:34 +0000
Received: from CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::c593:f271:eebe:ac7]) by CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::c593:f271:eebe:ac7%9]) with mapi id 15.20.3153.022; Thu, 2 Jul 2020
 08:27:33 +0000
From: Damien Le Moal <Damien.LeMoal@wdc.com>
To: =?iso-8859-1?Q?Javier_Gonz=E1lez?= <javier@javigon.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH 4/4] block: add attributes to zone report
Thread-Topic: [PATCH 4/4] block: add attributes to zone report
Thread-Index: AQHWUD27Re9bHnrRbkeGkwke4pL5/w==
Date: Thu, 2 Jul 2020 08:27:33 +0000
Message-ID: <CY4PR04MB3751C79E9AE4F5B77F41FCF7E76D0@CY4PR04MB3751.namprd04.prod.outlook.com>
References: <20200702065438.46350-1-javier@javigon.com>
 <20200702065438.46350-5-javier@javigon.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: javigon.com; dkim=none (message not signed)
 header.d=none;javigon.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.182.57]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 2beab482-509c-4384-8515-08d81e61c511
x-ms-traffictypediagnostic: CY4PR04MB1174:
x-microsoft-antispam-prvs: <CY4PR04MB1174334D639A02BA2D8B34F6E76D0@CY4PR04MB1174.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0452022BE1
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rgiKKkzZwkO0wd9jyJHZuPe/HbcP8llxtgoL2Advcyczi5dbQn+220tNK/13T9PPI/tg4Dl2mjysYdgYPO9rRnqMRFPmtUPS95NEBE+rwkx9+b3D0Uk95cT8Co7chc+3Envdif7ic5NiNfSMS05UgACNUG4HF8S1NI8GTyo7or37orl4ksRtfx4m3QAcCVCwuNBoBXAWRnUnDUcS1MbmLyceDysQHqw7jVR4BxI1sjwupNbfcVLfEPnn/7cMKOYwMAckUWhl5VBi7rKIJ3q4Lf/KpoJ2ZTF3UkoP6sdbN+9bnKNsQojf/AUOGfJHafl/ZFb1VXho2su4CcERZYa+pA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR04MB3751.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(346002)(366004)(136003)(39860400002)(396003)(376002)(66946007)(316002)(66574015)(8676002)(54906003)(478600001)(6506007)(33656002)(71200400001)(110136005)(83380400001)(91956017)(53546011)(55016002)(76116006)(9686003)(64756008)(66476007)(66556008)(66446008)(186003)(52536014)(86362001)(26005)(4326008)(2906002)(7416002)(7696005)(5660300002)(8936002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: kTaqe83/mwjpD3RavfLIr98j+qt1aJfXZ7PtKNGHUpXniFdDIWskHIXhGTPM+kg5WBy8pB6GRovp9Aj42ct2n6lllM4bVLO0gN7a6JT5Dz0Ht75NmjHiIW69CLr5MKU6YYPp6ol/GzLwc2+xHKu9mgwQJSlFdCfTpxNiGfvxZHr0SpL0a4+QQskQd9cD0Yd8G3EMopJlqjK2AVCXSf63ZUpMkSfa8cM1qEUC7ExGjR2weiscYvLJMsuAs12oXm2eraR/+cqdcaemq3f7j4uWL2VVmasb2PfEpR2n4MHGy6Ya9Qw3sJ2WMrEZxT8a1N+ngNRbv31Xwk9sXZND2ERfyNxSniMPHFihJu3qJp3sFFvZVXhi+BqsDhWkf6zQDHagUkZOVZLZ7+VfpjtdsZdu6NBeK99ceV9SjzjRssLhYInANXZNAjRsRSjfyXl6rowTVY0VHrV7auJ5HAOqv7Je7NUNaj4jX+hcWv3gRV2H7mIQPQaGkuoern2hdkBYNYaL
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR04MB3751.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2beab482-509c-4384-8515-08d81e61c511
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jul 2020 08:27:33.8256 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Gmvt0dMX71UpYYMxlBLNOFu/V9+ccZ+yv8l+rtc2gNhXAHM4dsCrVME9+qtcWVN09xM1L/qc5kSeZ2D0q/WSaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR04MB1174
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200702_042738_488216_A450AEB7 
X-CRM114-Status: GOOD (  19.02  )
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
Cc: "axboe@kernel.dk" <axboe@kernel.dk>,
 SelvaKumar S <selvakuma.s1@samsung.com>, "sagi@grimberg.me" <sagi@grimberg.me>,
 Kanchan Joshi <joshi.k@samsung.com>, Nitesh Shetty <nj.shetty@samsung.com>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "kbusch@kernel.org" <kbusch@kernel.org>,
 =?iso-8859-1?Q?Javier_Gonz=E1lez?= <javier.gonz@samsung.com>,
 "mb@lightnvm.io" <mb@lightnvm.io>, "hch@lst.de" <hch@lst.de>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 2020/07/02 15:55, Javier Gonz=E1lez wrote:
> From: Javier Gonz=E1lez <javier.gonz@samsung.com>
> =

> Add zone attributes field to the blk_zone structure. Use ZNS attributes
> as base for zoned block devices and add the current atributes in
> ZAC/ZBC.
> =

> Signed-off-by: Javier Gonz=E1lez <javier.gonz@samsung.com>
> Signed-off-by: SelvaKumar S <selvakuma.s1@samsung.com>
> Signed-off-by: Kanchan Joshi <joshi.k@samsung.com>
> Signed-off-by: Nitesh Shetty <nj.shetty@samsung.com>
> ---
>  drivers/nvme/host/zns.c       |  3 ++-
>  drivers/scsi/sd.c             |  2 +-
>  drivers/scsi/sd_zbc.c         |  8 ++++++--
>  include/uapi/linux/blkzoned.h | 26 +++++++++++++++++++++++++-
>  4 files changed, 34 insertions(+), 5 deletions(-)
> =

> diff --git a/drivers/nvme/host/zns.c b/drivers/nvme/host/zns.c
> index d785d179a343..749382a14968 100644
> --- a/drivers/nvme/host/zns.c
> +++ b/drivers/nvme/host/zns.c
> @@ -118,7 +118,7 @@ int nvme_update_zone_info(struct gendisk *disk, struc=
t nvme_ns *ns,
>  	}
>  =

>  	q->limits.zoned =3D BLK_ZONED_HM;
> -	q->zone_flags =3D BLK_ZONE_REP_CAPACITY | BLK_ZONE_REP_OFFLINE;
> +	q->zone_flags =3D BLK_ZONE_REP_CAPACITY | BLK_ZONE_REP_CAPACITY | BLK_Z=
ONE_REP_OFFLINE;

Adding BLK_ZONE_REP_CAPACITY a second time ? You meant adding BLK_ZONE_REP_=
ATTR,
no ?

>  	blk_queue_flag_set(QUEUE_FLAG_ZONE_RESETALL, q);
>  free_data:
>  	kfree(id);
> @@ -197,6 +197,7 @@ static int nvme_zone_parse_entry(struct nvme_ns *ns,
>  	zone.capacity =3D nvme_lba_to_sect(ns, le64_to_cpu(entry->zcap));
>  	zone.start =3D nvme_lba_to_sect(ns, le64_to_cpu(entry->zslba));
>  	zone.wp =3D nvme_lba_to_sect(ns, le64_to_cpu(entry->wp));
> +	zone.attr =3D entry->za;

It may be a good idea to limit this to the user level defined attributes.

>  =

>  	return cb(&zone, idx, data);
>  }
> diff --git a/drivers/scsi/sd.c b/drivers/scsi/sd.c
> index b9c920bace28..63270598aa76 100644
> --- a/drivers/scsi/sd.c
> +++ b/drivers/scsi/sd.c
> @@ -2967,7 +2967,7 @@ static void sd_read_block_characteristics(struct sc=
si_disk *sdkp)
>  	if (sdkp->device->type =3D=3D TYPE_ZBC) {
>  		/* Host-managed */
>  		q->limits.zoned =3D BLK_ZONED_HM;
> -		q->zone_flags =3D BLK_ZONE_REP_CAPACITY;
> +		q->zone_flags =3D BLK_ZONE_REP_CAPACITY | BLK_ZONE_REP_ATTR;
>  	} else {
>  		sdkp->zoned =3D (buffer[8] >> 4) & 3;
>  		if (sdkp->zoned =3D=3D 1 && !disk_has_partitions(sdkp->disk)) {
> diff --git a/drivers/scsi/sd_zbc.c b/drivers/scsi/sd_zbc.c
> index 183a20720da9..51c7f82b59c5 100644
> --- a/drivers/scsi/sd_zbc.c
> +++ b/drivers/scsi/sd_zbc.c
> @@ -53,10 +53,14 @@ static int sd_zbc_parse_report(struct scsi_disk *sdkp=
, u8 *buf,
>  =

>  	zone.type =3D buf[0] & 0x0f;
>  	zone.cond =3D (buf[1] >> 4) & 0xf;
> -	if (buf[1] & 0x01)
> +	if (buf[1] & 0x01) {
> +		zone.attr |=3D BLK_ZONE_ATTR_NRW;
>  		zone.reset =3D 1;
> -	if (buf[1] & 0x02)
> +	}
> +	if (buf[1] & 0x02) {
> +		zone.attr |=3D BLK_ZONE_ATTR_NSQ;
>  		zone.non_seq =3D 1;
> +	}
>  =

>  	zone.len =3D logical_to_sectors(sdp, get_unaligned_be64(&buf[8]));
>  	zone.capacity =3D zone.len;
> diff --git a/include/uapi/linux/blkzoned.h b/include/uapi/linux/blkzoned.h
> index e5adf4a9f4b0..315617827acd 100644
> --- a/include/uapi/linux/blkzoned.h
> +++ b/include/uapi/linux/blkzoned.h
> @@ -78,10 +78,33 @@ enum blk_zone_cond {
>   *
>   * @BLK_ZONE_REP_CAPACITY: Zone descriptor has capacity field.
>   * @BLK_ZONE_REP_OFFLINE : Zone device supports offline transition.
> + * @BLK_ZONE_REP_ATTR: Zone attributes reported.
>   */
>  enum blk_zone_report_flags {
>  	BLK_ZONE_REP_CAPACITY	=3D (1 << 0),
>  	BLK_ZONE_REP_OFFLINE	=3D (1 << 1),
> +	BLK_ZONE_REP_ATTR	=3D (1 << 2),
> +};
> +
> +/**
> + * enum blk_zone_attr - Zone Attributes
> + *
> + * Attributes of the zone. Reported in struct blk_zone -> attr
> + *
> + * @BLK_ZONE_ATTR_ZFC: Zone Finished by Controller due to a zone active =
excursion

ZNS drives that have zone active excursion are not supported for now, so th=
is
attribute can never be returned.

> + * @BLK_ZONE_ATTR_FZR: Finish Zone Recommended required by controller

"Recommended required" is a rather odd wording. If it is required then it i=
s not
recommended, it is mandatory. I would simplify this to

Finish zone recommended

> + * @BLK_ZONE_ATTR_RZR: Reset Zone Recommended required by controller

Same comment as above.

> + * @BLK_ZONE_ATTR_NSQ: Non Sequential zone

This is the same as the non_seq field, so please keep the same definition:

Non-sequential write resources active

> + * @BLK_ZONE_ATTR_NRW: Need Reset Write Pointer required by controller

This is the same as the reset field, so please keep the same definition:

"Reset write pointer recommended"

> + * @BLK_ZONE_ATTR_ZDEV: Zone Descriptor Extension Valid in zone report
> + */
> +enum blk_zone_attr {
> +	BLK_ZONE_ATTR_ZFC	=3D 1 << 0,
> +	BLK_ZONE_ATTR_FZR	=3D 1 << 1,
> +	BLK_ZONE_ATTR_RZR	=3D 1 << 2,
> +	BLK_ZONE_ATTR_NSQ	=3D 1 << 3,
> +	BLK_ZONE_ATTR_NRW	=3D 1 << 4,
> +	BLK_ZONE_ATTR_ZDEV	=3D 1 << 7,

What is the purpose of BLK_ZONE_ATTR_ZDEV ?

>  };
>  =

>  /**
> @@ -110,7 +133,8 @@ struct blk_zone {
>  	__u8	cond;		/* Zone condition */
>  	__u8	non_seq;	/* Non-sequential write resources active */
>  	__u8	reset;		/* Reset write pointer recommended */
> -	__u8	resv[4];
> +	__u8	attr;		/* Zone attributes */
> +	__u8	resv[3];
>  	__u64	capacity;	/* Zone capacity in number of sectors */
>  	__u8	reserved[24];
>  };
> =



-- =

Damien Le Moal
Western Digital Research

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
