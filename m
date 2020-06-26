Return-Path: <SRS0=morU=AH=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B929DC433DF
	for <linux-nvme@archiver.kernel.org>; Fri, 26 Jun 2020 10:01:29 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6FAB6207E8
	for <linux-nvme@archiver.kernel.org>; Fri, 26 Jun 2020 10:01:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="XzbWbR51";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="N77K6yk1";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="yzEwry/U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6FAB6207E8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:To:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=h6zqvqPGPzw9bS+PqsPvMLbK2SVlaJRh2fdj58wXLkI=; b=XzbWbR51ijJwKgA8pxgA5+GjQ
	WDHL+gIbeH4EIM3Au0Yw5UkUSYj7gZz2mzzQ135IaBwsOMPock1ghWyN27RFnzKweBKK/aoJ3Bi6s
	P2LNR46Q2d2QIYzHKJRo0AUx7VBqRUNjnrDlXiGzZNp8tUselNNs28Jf1Pm6k+vi5xhlkLwpnQb6e
	3bzZ+081xZcQA5W4RYyxWz9KXsofniVyzaThDtsTY02qY6JuB2TV9L+00ylEfgnn3DDtq9+WZsKd8
	J7Wtv5885B00Dz7ghHgKnBFzu58zUmHJw3oc5/FEGnnVtwCcc9kOy0Z0plqYjjvJQK6GW1bFYMBqf
	P7C+mj4iA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jolAj-0007wF-9L; Fri, 26 Jun 2020 10:01:25 +0000
Received: from esa3.hgst.iphmx.com ([216.71.153.141])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jolAM-0007o2-Rf
 for linux-nvme@lists.infradead.org; Fri, 26 Jun 2020 10:01:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1593165664; x=1624701664;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=mbmHn/m3vkWEehlVDeY6vXEx0eS2qlPTUYVxozIg5Lo=;
 b=N77K6yk1Z5eR98brADLuxhhvmudms5w1Alr1xlLWmw77ml8m3MZ2JspZ
 ckFifiACbzBaBrCXIGJmM42I/QVy4ergRvSxucGNanXOeJcm6dhT/cVM9
 nRSCzuMhuVE9IHFPi8cWKYyOmqmAoer2pFCM5fV6Pby8Lo1hsbmi6Zch+
 P7cmygImTNfJ0Wm2IadftMKNbbHFwX+q5eRZRCoZBB6ToSRQ+7y1SMcqU
 uYuRyS+5xaycA72UFZ8bh5TfhAcwXiOayHhxOiLXG0BP1xJx1U7cE7VwQ
 rgZ+KHOx73sTcJoEqVTAe8TCZIKu9T8+tWqamiQ8DsQauWlGLdDW73aLH A==;
IronPort-SDR: ILwWOcl1ezDixi3m+FXWOZAyFlgXJ9fVt389kx9JSf15lpdDCaMg2jKh+f+TTVv9/K8gRNMSv3
 GMHG8aCGFOvob+rEEAdWP2mtc4q8P2xPMTzR82ciX8Tq3YZVOUC3ctXFucPYVGDHhLEiWqDtZf
 57Nj+5qi6/wsgttU5ZtxjKpJKo9sDAuQaWDU2BtvkbiRGhWbj6CtPAiHI5y7nrR5YzP7lD9VbZ
 +7SXeD8UbBbjPm+A6+L/O1Vxbmd5lXokWXgMD+Ngrlpc71IArQNQ74bTR6WHIPqcNkciD+jRyD
 27k=
X-IronPort-AV: E=Sophos;i="5.75,281,1589212800"; d="scan'208";a="145289539"
Received: from mail-bn3nam04lp2054.outbound.protection.outlook.com (HELO
 NAM04-BN3-obe.outbound.protection.outlook.com) ([104.47.46.54])
 by ob1.hgst.iphmx.com with ESMTP; 26 Jun 2020 09:34:07 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yoy6ZVN7dvHfSg0yuu+TZSwGevnx0GI1oCK+Tko22Azx3o0WzhyN5v//jOT3B7w+BETT2wzw861SYbWmQqo3ZnZlzyUl+e97/JA0fzHw4EAomDbiFNokJpP4vPyU9mIAvWXv1SQlcusZeIIk633egwlvoBt4ryLTW0wjgMszI3KK09H/DXhxm9+rdMi0OqkMbT7FdNk587O4i3tWI/5bNr5OBpvqZ/sVvKNYHZVcEVYl6e7ATlKH2k4ceIX4o4Gq9LnW4+rfKMDkZ2mKxA4tzieSbI2nM2fM+jPH7jvZnFyeitjlPuWV6fD2ozvQ4vyOfkpzIbCqhtYp9O+H2oLjzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lr1eO3QDIVVZSHjixLaaOdJ6Z7ykXPQG6QVpjIXx820=;
 b=Z/eb0w77SRxnYo1nsVNAsLIBAUPPe2HHvo+yd4CA3O4IU8AXuKcV4C10CQYPhfncKQEe+l3OxrOyEAI8KcfFcqwvavY+dXNcAS3n99Y/v39LsyZPu90H2/zoDlh40/yB1jQdxeWVP6BvpvAOm3wY2PKuuUXMr5Q4ny07nY/WnBt29NnCaJ4PyoXZm65UmH+BMYxeFWf6EEhcsmgN90YhuA3vuqohq5I7OU1oBKaYsSaGnplek8qH/izvYeKauEQVODlCHOUuDxj8siAXWV/Nrc7EM4qjHGS3I7XSZhB5wKUUUhcXlmqp0iXw6zKRNoM8D1DB8CufP/y2YXxdU+AA8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lr1eO3QDIVVZSHjixLaaOdJ6Z7ykXPQG6QVpjIXx820=;
 b=yzEwry/UdzxwjL/XYd5bqexutd0X2HXP5AvHru3NXpExZU9JaOfhC7IS3alTyFTUImyp0Ni6NbKXQ1zLJxqjE0iOBHlZaCt4pxuSx3qzpW/quMN2bHWS1s3FPWKoH2hK/Yc9mmh4Oo8H1VZwOCcZbB6zCHH4gT03Z28OvNXzR0w=
Received: from CY4PR04MB3751.namprd04.prod.outlook.com (2603:10b6:903:ec::14)
 by CY4PR04MB1032.namprd04.prod.outlook.com (2603:10b6:910:50::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.23; Fri, 26 Jun
 2020 01:34:05 +0000
Received: from CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::c593:f271:eebe:ac7]) by CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::c593:f271:eebe:ac7%9]) with mapi id 15.20.3131.024; Fri, 26 Jun 2020
 01:34:05 +0000
From: Damien Le Moal <Damien.LeMoal@wdc.com>
To: =?iso-8859-1?Q?Javier_Gonz=E1lez?= <javier@javigon.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH 3/6] block: add support for zone offline transition
Thread-Topic: [PATCH 3/6] block: add support for zone offline transition
Thread-Index: AQHWSutT3xCQHGem9k+D54mKrpOEQg==
Date: Fri, 26 Jun 2020 01:34:04 +0000
Message-ID: <CY4PR04MB375111445246B570FAF4EE58E7930@CY4PR04MB3751.namprd04.prod.outlook.com>
References: <20200625122152.17359-1-javier@javigon.com>
 <20200625122152.17359-4-javier@javigon.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: javigon.com; dkim=none (message not signed)
 header.d=none;javigon.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.182.57]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 91701f0b-cb1c-45a8-8add-08d81971035d
x-ms-traffictypediagnostic: CY4PR04MB1032:
x-microsoft-antispam-prvs: <CY4PR04MB1032E314B8E9720A9CA1780EE7930@CY4PR04MB1032.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0446F0FCE1
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Tulzoemxkje2Tf1Ekq+04lyLE84rDOVU7JW/owrEIl+jMbC9IA9jd/b446NzFB6RN5JoLmE+mmRFfMGZ/0JPgvQ319S56MgnPaYoXjsNTvva06GDgrNNyk6bdVPvm8fhjMgNbpYNELUxnjwZgtzgwta8QGdFkGydm5MW7l9ZmEfr5VXVvRSlcNxrsJZPhGBO43CStO9cXta0d9ODappXL2QPbetJeQSf9e/CHhGlRQlZVzu5PqzgUv3HMw2XchZpwhGZl4AE/bbMzWCBr+TzOVuYLC4JxwxKSaMgqCCH7kK60J1uSDUxcfJXItyVtZzl
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR04MB3751.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(376002)(39860400002)(136003)(346002)(396003)(91956017)(7416002)(86362001)(55016002)(66446008)(2906002)(83380400001)(66946007)(71200400001)(66476007)(64756008)(478600001)(66556008)(5660300002)(186003)(76116006)(9686003)(26005)(8936002)(33656002)(53546011)(316002)(6506007)(66574015)(4326008)(8676002)(54906003)(52536014)(110136005)(7696005);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: PLKOjJooXdpoNOF2fF0gbTx7VRDCd1EBPTn4i620QjvVU8KTotl4fUAUz6VY6FG7goVKBmfOnNkQpe9Ok4E0VyYprAHFkiW7dCv9g9IQH1SpSM5v5pccldq76VNbhR7RrbIgxxTPQsqTahhjP/Nfi2n2qDdPbmf+A5ncbFpQkv+r/eVHdhCJYtGx1Y2inuXbt+H7BaK9TdKVVz+0A2ufheD2X3WXNcmszko2v2IW8vZZtfnACTrOtpP5xQ8WSvQSahTau5lLZ2gg7Wi3cdz33cf0+0smBLv29WhQ7r1SmAwvZkuW5II8+Wa/RQcFO7PCe9W+SfZ7fXBfoOK6goiWNLcvfU8myRDmwhOem7L9yMPZ4TmtKowhKuEjrBZLOzLvgqd5o2KGe0ev6gj7bNOkUs+OBcVscjUknL+8TLf2zx4WNEsCmIWBjjCR+0lTquGTbdEs3fNIogRe5GRG4xMeW6OOgSdT+EK/sbs2ZFS9ag+Q2IS5wvahSsmFsyfnmjCJ
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR04MB3751.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91701f0b-cb1c-45a8-8add-08d81971035d
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jun 2020 01:34:04.9656 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: i6lm/3OGlAJWhNzVnY9+abSJTqKcYss8A3U2IUsTIOpckCs95/JXUWwyPJZf2aUoPjqsSu32c3yzlz5kXkdggw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR04MB1032
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
 "hch@lst.de" <hch@lst.de>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 2020/06/25 21:22, Javier Gonz=E1lez wrote:
> From: Javier Gonz=E1lez <javier.gonz@samsung.com>
> =

> Add support for offline transition on the zoned block device using the
> new zone management IOCTL
> =

> Signed-off-by: Javier Gonz=E1lez <javier.gonz@samsung.com>
> Signed-off-by: SelvaKumar S <selvakuma.s1@samsung.com>
> Signed-off-by: Kanchan Joshi <joshi.k@samsung.com>
> Signed-off-by: Nitesh Shetty <nj.shetty@samsung.com>
> ---
>  block/blk-core.c              | 2 ++
>  block/blk-zoned.c             | 3 +++
>  drivers/nvme/host/core.c      | 3 +++
>  include/linux/blk_types.h     | 3 +++
>  include/linux/blkdev.h        | 1 -
>  include/uapi/linux/blkzoned.h | 1 +
>  6 files changed, 12 insertions(+), 1 deletion(-)
> =

> diff --git a/block/blk-core.c b/block/blk-core.c
> index 03252af8c82c..589cbdacc5ec 100644
> --- a/block/blk-core.c
> +++ b/block/blk-core.c
> @@ -140,6 +140,7 @@ static const char *const blk_op_name[] =3D {
>  	REQ_OP_NAME(ZONE_CLOSE),
>  	REQ_OP_NAME(ZONE_FINISH),
>  	REQ_OP_NAME(ZONE_APPEND),
> +	REQ_OP_NAME(ZONE_OFFLINE),
>  	REQ_OP_NAME(WRITE_SAME),
>  	REQ_OP_NAME(WRITE_ZEROES),
>  	REQ_OP_NAME(SCSI_IN),
> @@ -1030,6 +1031,7 @@ generic_make_request_checks(struct bio *bio)
>  	case REQ_OP_ZONE_OPEN:
>  	case REQ_OP_ZONE_CLOSE:
>  	case REQ_OP_ZONE_FINISH:
> +	case REQ_OP_ZONE_OFFLINE:
>  		if (!blk_queue_is_zoned(q))
>  			goto not_supported;
>  		break;
> diff --git a/block/blk-zoned.c b/block/blk-zoned.c
> index 29194388a1bb..704fc15813d1 100644
> --- a/block/blk-zoned.c
> +++ b/block/blk-zoned.c
> @@ -416,6 +416,9 @@ int blkdev_zone_mgmt_ioctl(struct block_device *bdev,=
 fmode_t mode,
>  	case BLK_ZONE_MGMT_RESET:
>  		op =3D REQ_OP_ZONE_RESET;
>  		break;
> +	case BLK_ZONE_MGMT_OFFLINE:
> +		op =3D REQ_OP_ZONE_OFFLINE;
> +		break;
>  	default:
>  		return -ENOTTY;
>  	}
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index f1215523792b..5b95c81d2a2d 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -776,6 +776,9 @@ blk_status_t nvme_setup_cmd(struct nvme_ns *ns, struc=
t request *req,
>  	case REQ_OP_ZONE_FINISH:
>  		ret =3D nvme_setup_zone_mgmt_send(ns, req, cmd, NVME_ZONE_FINISH);
>  		break;
> +	case REQ_OP_ZONE_OFFLINE:
> +		ret =3D nvme_setup_zone_mgmt_send(ns, req, cmd, NVME_ZONE_OFFLINE);
> +		break;
>  	case REQ_OP_WRITE_ZEROES:
>  		ret =3D nvme_setup_write_zeroes(ns, req, cmd);
>  		break;
> diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
> index 16b57fb2b99c..b3921263c3dd 100644
> --- a/include/linux/blk_types.h
> +++ b/include/linux/blk_types.h
> @@ -316,6 +316,8 @@ enum req_opf {
>  	REQ_OP_ZONE_FINISH	=3D 12,
>  	/* write data at the current zone write pointer */
>  	REQ_OP_ZONE_APPEND	=3D 13,
> +	/* Transition a zone to offline */
> +	REQ_OP_ZONE_OFFLINE	=3D 14,
>  =

>  	/* SCSI passthrough using struct scsi_request */
>  	REQ_OP_SCSI_IN		=3D 32,
> @@ -456,6 +458,7 @@ static inline bool op_is_zone_mgmt(enum req_opf op)
>  	case REQ_OP_ZONE_OPEN:
>  	case REQ_OP_ZONE_CLOSE:
>  	case REQ_OP_ZONE_FINISH:
> +	case REQ_OP_ZONE_OFFLINE:
>  		return true;
>  	default:
>  		return false;
> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> index bd8521f94dc4..8308d8a3720b 100644
> --- a/include/linux/blkdev.h
> +++ b/include/linux/blkdev.h
> @@ -372,7 +372,6 @@ extern int blkdev_zone_ops_ioctl(struct block_device =
*bdev, fmode_t mode,
>  				  unsigned int cmd, unsigned long arg);
>  extern int blkdev_zone_mgmt_ioctl(struct block_device *bdev, fmode_t mod=
e,
>  				  unsigned int cmd, unsigned long arg);
> -
>  #else /* CONFIG_BLK_DEV_ZONED */
>  =

>  static inline unsigned int blkdev_nr_zones(struct gendisk *disk)
> diff --git a/include/uapi/linux/blkzoned.h b/include/uapi/linux/blkzoned.h
> index a8c89fe58f97..d0978ee10fc7 100644
> --- a/include/uapi/linux/blkzoned.h
> +++ b/include/uapi/linux/blkzoned.h
> @@ -155,6 +155,7 @@ enum blk_zone_action {
>  	BLK_ZONE_MGMT_FINISH	=3D 0x2,
>  	BLK_ZONE_MGMT_OPEN	=3D 0x3,
>  	BLK_ZONE_MGMT_RESET	=3D 0x4,
> +	BLK_ZONE_MGMT_OFFLINE	=3D 0x5,
>  };
>  =

>  /**
> =


As mentioned in previous email, the usefulness of this is dubious. Please
elaborate in the commit message. Sure NVMe ZNS defines this and we can supp=
ort
it. But without a good use case, what is the point ?

scsi SD driver will return BLK_STS_NOTSUPP if this offlining is sent to a
ZBC/ZAC drive. Not nice. Having a sysfs attribute "max_offline_zone_sectors=
" or
the like to indicate support by the device or not would be nicer.

Does offling ALL zones make any sense ? Because this patch does not prevent=
 the
use of the REQ_ZONE_ALL flags introduced in patch 2. Probably not a good id=
ea to
allow offlining all zones, no ?

-- =

Damien Le Moal
Western Digital Research

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
