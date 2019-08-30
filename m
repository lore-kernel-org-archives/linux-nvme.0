Return-Path: <SRS0=Ir45=W2=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2549AC3A59B
	for <linux-nvme@archiver.kernel.org>; Fri, 30 Aug 2019 18:55:24 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D1D8E2073F
	for <linux-nvme@archiver.kernel.org>; Fri, 30 Aug 2019 18:55:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="F6tqHSuk";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="oXis0A0c";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="rKyAWSyT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1D8E2073F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date
	:Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=KtYrz8AMSY0XwY1D0T6JdXho5s3fMbuBLM3TXt+3Sxk=; b=F6tqHSukfBs8Wr
	5pZ1C7nD7KFysof2jjg/kYjrxN/zRrr7sgmU/tcILfQOeEIfyK4RO3qS5RVTjkhcxuM1ZjuvFnj2N
	8VGMx2S67edNetCjxlOu1/B6QEn3imI0JfPWcQOk7EsVi3fcUltKcn9RwTXNBt5YqxwH9z0R3jimT
	SR7OXkwVTD7qwt53vbitEusjalQqd1LfkUfAhxS6hPFNIoXy/yn8YCVy2mI3OtwJgvj7Oa+qqz86E
	q/KG9dPg83nQCBaCS0a8mSAA80k8v1rkZdaRAOcDvpqsMUYz4THksZin7yieIlayqhR30C3r2asXF
	5GyXZKirmRvWD+CXodXg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92 #3 (Red Hat Linux))
	id 1i3m3N-00025H-J2; Fri, 30 Aug 2019 18:55:21 +0000
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
 by bombadil.infradead.org with esmtps (Exim 4.92 #3 (Red Hat Linux))
 id 1i3m3K-00024t-Pi
 for linux-nvme@lists.infradead.org; Fri, 30 Aug 2019 18:55:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1567191442; x=1598727442;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=qzUPAeCoqK2vxAClHoR3Dgjpka4aN8w0N4d5fvoGjbo=;
 b=oXis0A0cnkHU8aGKQwifZgsx+WSk8pJNvgF7az9/DDAFg9ssCtKoPC0w
 JEuAryVDmiqI0CzcHWW75m08tD9hyEnnfYxIQIh0x9zbnhpCzwq///ddu
 jiAEnpB2LeUJ++OPcws/JqQ4v1INHO8wUH+BhjyF+66TpCATTPF9i7cKH
 2hhAyppjspYe5lyZ3s1z6Lffsfl40yniuKhTeg4jnK5AQueAkNB9XLMA7
 j3Kz7qV5s0CA2YZw4LSEBCU8bZCrIt9oNaUu+StGDN9XmQrobP+7QlvIs
 lO7IIqudJ/5PClO+Kl+JD+7ekynepT5BllGnDKsz2GKqFgT8oPrzjSxJ7 w==;
IronPort-SDR: dSdL0g4HU2o8zKU9qJ2scMqYwxaTo44ryp53wnFt4WhjNe3NmKY6rE6jE/6Sy5aOzg+dxtSXIA
 9VRSneQ2EHz1truOPlLsePboiwnZsGumIlSnG44x9+upz5SEkJQwo5tU19QUw0v0scUtEjcIYq
 fgDVsnGBUARz4FRxk4mzbT3Y4gYhy5gmAqcvfYO0hTW5M2l3yPvoqXtTIqlSBYZYbzbo/24hPF
 t0VcLXWGdJ2ALCFTu0XKZsGTc1cNdRRfx9ZX9YzzxFB9HxzoYwREDaeTJRNh0lBcefZ/4rHKYn
 DQU=
X-IronPort-AV: E=Sophos;i="5.64,447,1559491200"; d="scan'208";a="217595488"
Received: from mail-bn3nam04lp2054.outbound.protection.outlook.com (HELO
 NAM04-BN3-obe.outbound.protection.outlook.com) ([104.47.46.54])
 by ob1.hgst.iphmx.com with ESMTP; 31 Aug 2019 02:57:18 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H9n9uEmRr7Jhf/C5aoKbb1Py+YwkkqDocrdq7yn6ZBhekwSBN0SVfoNa0bBQxqIFI/04CSJF6vj9Co1NJe1yXpVNB/5jTPnE0KOMa1LTCJ4A05urLP4E55tjbqsANyaQ7ynlMK8XFzQkWJjbViIuRfe0Vv/dIiMhGI+OabkUC4zlQK9Fup1wEEQA1CiB5okj/TZ1XyAg3dw6airXDkk0Lq5GkUU4QTRlYA1w+JRJBBeGmn9QyF3VJF+qOUdwMwqvHdSIpZrpSupfSrfY5zZYXy2IWPqKqhr50ugsf7aYwwSWEA1WZLyXt1k4x7Tt54eXRdmSYa9ge46vEQwp+1KJzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1KTqKbs/nyxr7atAz3R5w2sNAO1leXWvlxOZxPrTdsY=;
 b=ONH9s3ylLcc/Hl+T8D4asUzXe5Ydied3HfSz0cJz6pdG+a09tYKKxatgzqgJNawXQwpHwZff24fBpVS9yx8pezycG81DjIDIjjeHLs3c87dr9UJsapt5RuXv9E3Pi4zVesvDQL4whFax8eHP/AxVvzcwNInOoOhZ0dB4GYBnEZFDVZPtpixgVq1rbqD4IjokqEeiBbnLvGuV6beObEhTuCLEhhnsnBahbBlohjNHzj01TfiWu6chxbpNkZdo5Xrh6oGq5pFw1VNtK5A7jqm+1cRbwTe/UnDaWxhNAQIiDd1cz73WwclAOV8orn1PC8Wf3k1OIqzkZKXbk99E0BxcVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1KTqKbs/nyxr7atAz3R5w2sNAO1leXWvlxOZxPrTdsY=;
 b=rKyAWSyT8KLJQwI+20jLg5LMeannRUHliCWhbiyL/i9j6QU/A1J9WlwQ8kpaOxqwrz+utDLo64UV6AJW3fo5lTf4NSyabN8CU2BdklajyUoIVN+6RlzOCXcdeFgbmkuulLKJrJOGSy03t1KoVM2w2zxXSy0aLmcFxjLkzVToqoM=
Received: from BYAPR04MB5749.namprd04.prod.outlook.com (20.179.58.26) by
 BYAPR04MB3957.namprd04.prod.outlook.com (52.135.215.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2220.18; Fri, 30 Aug 2019 18:55:13 +0000
Received: from BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::b066:cbf8:77ef:67d7]) by BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::b066:cbf8:77ef:67d7%5]) with mapi id 15.20.2199.021; Fri, 30 Aug 2019
 18:55:13 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Sagi Grimberg <sagi@grimberg.me>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH v9 6/9] block_dev: split disk size check out of
 revalidate_disk
Thread-Topic: [PATCH v9 6/9] block_dev: split disk size check out of
 revalidate_disk
Thread-Index: AQHVXrY2ngZl784gtEWyadbCn/+u2w==
Date: Fri, 30 Aug 2019 18:55:13 +0000
Message-ID: <BYAPR04MB57492AB0F679C2E18ED5AFE886BD0@BYAPR04MB5749.namprd04.prod.outlook.com>
References: <20190829220645.5480-1-sagi@grimberg.me>
 <20190829220645.5480-7-sagi@grimberg.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chaitanya.Kulkarni@wdc.com; 
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0f45f997-0740-434d-8f11-08d72d7b973f
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);
 SRVR:BYAPR04MB3957; 
x-ms-traffictypediagnostic: BYAPR04MB3957:
x-microsoft-antispam-prvs: <BYAPR04MB395713F2EF84F9A682B6217A86BD0@BYAPR04MB3957.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-forefront-prvs: 0145758B1D
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(4636009)(39860400002)(396003)(136003)(366004)(346002)(376002)(189003)(199004)(66946007)(33656002)(6116002)(6436002)(66476007)(55016002)(76176011)(64756008)(6506007)(76116006)(2906002)(4326008)(8676002)(81156014)(8936002)(53936002)(7696005)(6246003)(86362001)(9686003)(54906003)(110136005)(99286004)(25786009)(478600001)(316002)(53546011)(81166006)(66556008)(14454004)(2501003)(66066001)(52536014)(446003)(5660300002)(66446008)(7736002)(305945005)(74316002)(71200400001)(71190400001)(186003)(3846002)(476003)(102836004)(26005)(256004)(14444005)(486006)(229853002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:BYAPR04MB3957;
 H:BYAPR04MB5749.namprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: pCdwZYNAWr5O8RgajCO0z1hWmC8WBisD43oDkpFZw0FPXe2jvmPiMVRp5uKdvciTZiIXw2j7hdO+b/JZWyOhIaAYwpJcokPD4hGv9qitRje9z0AImY1MsH8qa1HZ90PDfroyUs7P7V67w9Hs916vIZRT/VEQVDj9Z2SjtDJDeerVkagO8d6/rUSzdjm6QIWEqgGoLaKpAM2r3yCuADBdwZQj2J9d87TBNTpAvZx/UFFK0EFKfJXj/aoZL4IIRCOygGGYy186grC2CSqUtVUl0GKzTMP3xxbCjjoea3m/IU4tvruGQ94aBpE1YDC26iyruDujXSCrYDlXpN7n1uYM1lCb6gSP8Z/7q7CvQGWUeiLC2MvR81vVSQAs991EloIA0Br5dGcHMUr3ycAh/X6bnK7nK/3KrtcN6dZGeW6l/yo=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f45f997-0740-434d-8f11-08d72d7b973f
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Aug 2019 18:55:13.7657 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hreCPdU/jPIO0sAJpNTzm+TLkAWElS4uC2y9efiQ/y+MgDrjgUh6IffTV695cq75FYrZZGia0NgqxtOsWUtI+I/INnbZcz2GZJwO9ysUD6k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB3957
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190830_115519_102050_48FA4F48 
X-CRM114-Status: GOOD (  16.02  )
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
Cc: Keith Busch <keith.busch@intel.com>, James Smart <james.smart@broadcom.com>,
 Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 08/29/2019 03:07 PM, Sagi Grimberg wrote:
> Allow callers to call separately the ->revalidate_disk()
> callout and the disk size change check separately. This
> will help the caller to take action based on the return
> status of ->revalidate_disk() and run the disk size check
> afterwards.

Commit message looks odd as compare to other commits, please have
a look at following message which uses limit of 72 car per line  :-

Allow callers to call separately the ->revalidate_disk() callout and
the disk size change check separately. This will help the caller to
take action based on the return status of ->revalidate_disk() and
run the disk size check afterwards.

>
> Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
> ---
>   fs/block_dev.c     | 29 +++++++++++++++++------------
>   include/linux/fs.h |  1 +
>   2 files changed, 18 insertions(+), 12 deletions(-)
>
> diff --git a/fs/block_dev.c b/fs/block_dev.c
> index a6f7c892cb4a..4939a093e2f8 100644
> --- a/fs/block_dev.c
> +++ b/fs/block_dev.c
> @@ -1482,6 +1482,21 @@ void check_disk_size_change(struct gendisk *disk, struct block_device *bdev,
>   	}
>   }
>
> +void check_disk_size(struct gendisk *disk, bool verbose)
> +{
> +	struct block_device *bdev = bdget_disk(disk, 0);
> +
> +	if (!bdev)
> +		return;
> +
> +	mutex_lock(&bdev->bd_mutex);
> +	check_disk_size_change(disk, bdev, verbose);
> +	bdev->bd_invalidated = 0;
> +	mutex_unlock(&bdev->bd_mutex);
> +	bdput(bdev);
> +}
> +EXPORT_SYMBOL_GPL(check_disk_size);
> +
>   /**
>    * revalidate_disk - wrapper for lower-level driver's revalidate_disk call-back
>    * @disk: struct gendisk to be revalidated
> @@ -1501,18 +1516,8 @@ int revalidate_disk(struct gendisk *disk)
>   	 * Hidden disks don't have associated bdev so there's no point in
>   	 * revalidating it.
>   	 */
> -	if (!(disk->flags & GENHD_FL_HIDDEN)) {
> -		struct block_device *bdev = bdget_disk(disk, 0);
> -
> -		if (!bdev)
> -			return ret;
> -
> -		mutex_lock(&bdev->bd_mutex);
> -		check_disk_size_change(disk, bdev, ret == 0);
> -		bdev->bd_invalidated = 0;
> -		mutex_unlock(&bdev->bd_mutex);
> -		bdput(bdev);
> -	}
> +	if (!(disk->flags & GENHD_FL_HIDDEN))
> +		check_disk_size(disk, ret == 0);
>   	return ret;
>   }
>   EXPORT_SYMBOL(revalidate_disk);
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index 997a530ff4e9..6649ad157317 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -2679,6 +2679,7 @@ extern bool is_bad_inode(struct inode *);
>   extern void check_disk_size_change(struct gendisk *disk,
>   		struct block_device *bdev, bool verbose);
>   extern int revalidate_disk(struct gendisk *);
> +extern void check_disk_size(struct gendisk *disk, bool verbose);
>   extern int check_disk_change(struct block_device *);
>   extern int __invalidate_device(struct block_device *, bool);
>   extern int invalidate_partition(struct gendisk *, int);
>


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
