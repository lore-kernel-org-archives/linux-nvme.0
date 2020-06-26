Return-Path: <SRS0=morU=AH=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4163C433E0
	for <linux-nvme@archiver.kernel.org>; Fri, 26 Jun 2020 11:37:17 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 91D9620781
	for <linux-nvme@archiver.kernel.org>; Fri, 26 Jun 2020 11:37:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="1J1ey1t8";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="az44FGmK";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="ToD9s76p";
	dkim=neutral (0-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="npn3+0ww"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91D9620781
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:To:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=Ej8ww4ZFhSeEKL9P78uFdJJek2OfE7kJa4jJfhdqesQ=; b=1J1ey1t8qDU283D1GIADS4G15
	v7jb3eoi8an9eZ+UkFlsw1CSE+tLr1DrdLW76qPeaSAY2l97pqOVCoQ42dTpRh0HrCE8Fh4I87Voy
	kS0wDd+YZH3xZJEHJESxbZzD2Xd091p8T5QhBK3VVzI5PhyRaMDPt7iM2OStniY8pqNOKsPeG52oq
	9QdPNNCDWhrWHlakEux1c3hDa3K1seP2PeVYA4rnxN6t94zNd4w+c90JkQAJLrCEwWiSE4x2Er5to
	52zMCWJCdW53TmS5iaF2x6u2sb0rgpgOw2LcroFFdJJsCOl0hbi/UjZXST0CPhu672wxz3m1LfcRl
	lQxGPXX2Q==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jomfF-0007DO-8v; Fri, 26 Jun 2020 11:37:01 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jolKV-0001IL-2d
 for linux-nvme@merlin.infradead.org; Fri, 26 Jun 2020 10:11:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=MIME-Version:Content-Transfer-Encoding:
 Content-Type:References:Message-ID:Date:Subject:CC:To:From:Sender:Reply-To:
 Content-ID:Content-Description:In-Reply-To;
 bh=rkStGiqiuhg9Ea+lmXdyQwNA1TwYFIAL5r8wm6OXiSc=; b=az44FGmKJo7YmHfb51FQBJXijZ
 6RsudqyFYSApPaAsY8sL3C7RBZfVKS2ngsqROXh6GBYSNQHtDS8WOYQs/U5POK4b91VMN+wD0nZ+e
 vh9qKSV3KuJHOCSDcR/QRDefljUNwOq0Fyi5ZWu7IyTqsEdi0UOcMNOw3rdci6b3e2WXmDWzcjqZd
 mhrXZ8TU43k+zDteJLaaUQLu5iNN25mZHDkBHfqg+93mCIaqOpOBRRrJRgS1Paw10zZ3TRl1RrANk
 qSmnPGJJitvW9GlpKQ+9SoR9Gw9pukt2N0RFIxVCwHpqE7zgeE4PNafjy5w+u150bUZbOHN4+bDjE
 eAy0KyZQ==;
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
 by casper.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jojeZ-0002jL-Bn
 for linux-nvme@lists.infradead.org; Fri, 26 Jun 2020 08:25:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1593159847; x=1624695847;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=bJXHvcdUoSzIk7IWH5s7MMz8eci84GOPeS1uz71LpGA=;
 b=ToD9s76pXq13oTIX2Y918z49Qu2FboOPGsg0sZ240fE27xFcIvgitQWM
 W0RWPp2rODRE3E8FjCg9zdexWU0lQHSvr8GVIuY1gZB+Ka/1z8/iPlpMF
 WIXxwObQz2lVfOBzTJ+WxEKYHDALEg5QFB/KHFlCYTKqvh7fp+hsP+7Hs
 W4xttnUm/+1zZmdHLnFcANETdT2buEABkRf1F9IAyvD4lZJBf5O7SGgHY
 5/Rb/6wrkfbWFMQ4y8rp1DSTUS7WrHxAB7nH86ILrQxAaxb0GtzTuHUFL
 Di4vh1hT+stU/086m2Q3fzFj73In8IbaQfF/37FrhnC56g8TOotWvO9l2 A==;
IronPort-SDR: ymNwLH7rrpXBeXwV7yFbP6EMteWuO4KNXNiquAmnFxLOrDNGvRjBx20vozUxA1f0Lf1C4rDp7E
 XXnWzIWA5JbhGxuNs/sGwwrYV6V6CH/ueWbvrg2eDx+8/+VGJO5tOke0GyJiO2ZoOIFpEnLgFt
 RSiVdSzUM0XSk8OgyvWFKP9Fme6jIL8ANGNjHoyZ5sHCJ9TEKfJJ8yP2Qaokt8DXJmTdmQ8DIl
 8iDoVRIWdEKE3U+zCkFZCTS9iFWEWMb1vHqOCShhcefxTMz3lpPQqjcfmGrdtMIPugJppGAYYS
 rNw=
X-IronPort-AV: E=Sophos;i="5.75,281,1589212800"; d="scan'208";a="140960922"
Received: from mail-dm6nam11lp2171.outbound.protection.outlook.com (HELO
 NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.171])
 by ob1.hgst.iphmx.com with ESMTP; 26 Jun 2020 09:17:12 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SvjPpNPukvZgjeneHgJqLPPPNwA4PDRkKCgKnrFLHttmjCLGpEHdFLSPokx0RY+5jMhrQLFW93YAY7P1eeKhLyUHpRt8/DpaUsHpZZ4CN9w+2JBJceynk30LL6YyWvrfG4SqFfXxJ9HRyi2VTj/D2Qxt+xhtOK/Ks7xaUMS4FFaqMl9pNjkqBGpsHS/985Av984R5JY+viFJbRDiWL/3MD+T7AM1uqu6JpBONAK+65/TPjYFlpzItqF+DfH0VMMnHLWhrrRGsJHdIl7zdwLzDuGWNWOSfT8NpAeAHNObLKPfuG5HJkVnhgolYx0BYB/yJoeqFxO842N5Q593Wp0x4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rkStGiqiuhg9Ea+lmXdyQwNA1TwYFIAL5r8wm6OXiSc=;
 b=E2Zbh/tQdgTTefnAJO3Vx+62eUd7DQ5yl6lGWRIiZdsjmsCtiSOOnZ47hLVITvNa5+xTEXm5xe1dftIGLX8tq3N0zge9VGUyLcVhxlhh5l2o4xS1uMXuIgM3wJ7JF3QPCxLLb8T8lyoukilJOYDXRCzD78HY0nDY7iglkS10VS4oLOcTZEFBY14ZF89QSkWDVDaUjyVm58X5onVUXznW1P7Ih+R8OfRDDOJRiBC/53bOmo85d3GuKbbXXhDp7JiOF4tv6Bo/ufMxq5XKyLtOlWMnM014TM1WHekczt63pPjE8Z1vDguzYw8q6ku3EQYTwhviXszkWfO/Mvq27pKbIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rkStGiqiuhg9Ea+lmXdyQwNA1TwYFIAL5r8wm6OXiSc=;
 b=npn3+0ww23pz3Wn8gkNWD1J6nwYGk5qGodTRbjMKTTwyhZymkKy08QGUZD840TcxoNB7+y80l32OXxsfLA/WNaivXx6ubfTMSJPI96+wKLNeiJu24+/L0U+vtAI1u65alwojOjH1XEPV2mWkwrtk3EvmdWF9m14qTYtJDt1VtKM=
Received: from CY4PR04MB3751.namprd04.prod.outlook.com (2603:10b6:903:ec::14)
 by CY4PR04MB0726.namprd04.prod.outlook.com (2603:10b6:903:e3::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.23; Fri, 26 Jun
 2020 01:17:11 +0000
Received: from CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::c593:f271:eebe:ac7]) by CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::c593:f271:eebe:ac7%9]) with mapi id 15.20.3131.024; Fri, 26 Jun 2020
 01:17:11 +0000
From: Damien Le Moal <Damien.LeMoal@wdc.com>
To: =?iso-8859-1?Q?Javier_Gonz=E1lez?= <javier@javigon.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH 1/6] block: introduce IOCTL for zone mgmt
Thread-Topic: [PATCH 1/6] block: introduce IOCTL for zone mgmt
Thread-Index: AQHWSutOpOYox0Fba0KpyHzgytYs/A==
Date: Fri, 26 Jun 2020 01:17:11 +0000
Message-ID: <CY4PR04MB3751608EA9351354A614A0BFE7930@CY4PR04MB3751.namprd04.prod.outlook.com>
References: <20200625122152.17359-1-javier@javigon.com>
 <20200625122152.17359-2-javier@javigon.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: javigon.com; dkim=none (message not signed)
 header.d=none;javigon.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.182.57]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: bb2419e3-3039-4faf-b243-08d8196ea76a
x-ms-traffictypediagnostic: CY4PR04MB0726:
x-microsoft-antispam-prvs: <CY4PR04MB07260AAEF11D610AD0CECF5BE7930@CY4PR04MB0726.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0446F0FCE1
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2Zik7oGIYXstq9DDV2/HrtM5foi1GA1jM5SIze2aMjzbkpO2iz1UhjJF7Tyj7uw/RcVwzv838rTpCaiMq2jpsENeDFjdodZGT1XeorfTTd/tmHf6Z4bcQuV+Df/RpzpXchtLij5M7aBRv7VGdyT78rdcKi3l0MCdSGZ31g2VRCxjydEUreKUHlrZGgjHqaJJpkMkdgPmtTOP5kYGQD37/XJWwKu0v4x3b2sfiFXJHTbS8lBfbrLyMM8hYBsYa36VTumwl6ttaSjVmbfZmVkwXOtwFpbEQ2ThPC/3TTE8IrEvcfGYwmOm4D2Au1yGuOI3G9dcDNlMUFgqPfxcLw/B9Q==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR04MB3751.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(366004)(376002)(136003)(346002)(39860400002)(53546011)(52536014)(33656002)(83380400001)(54906003)(110136005)(71200400001)(316002)(478600001)(66446008)(8936002)(66946007)(26005)(86362001)(64756008)(7416002)(66556008)(9686003)(6506007)(5660300002)(8676002)(186003)(66476007)(91956017)(7696005)(66574015)(76116006)(4326008)(2906002)(55016002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: CLQn5dmiul5Yg20uim/cyIylMld0RByBrWTkGHfBWs50zfBNhpZ9ZBONMvFC9BDMrH/KEOoJvwbmoynhZPYM245vwLa9csoyq5PNHAMqCJ20yMcEhtVJNbfOnm662Ssc/n7oKqB2cimuBon/n2ftKtqRMWcLpZfdZ8shzUou1K5oKrfqViUtwQKDZXzUmH8nExmmvaJlMcaD40uU/bh0Sx8CSRneHl3vsVyLHnHt0aaF8NWLCglas0IzIsMxQC1R8apWNHb5af1lxVjZFSlFEud/Dme6OkQGTbqvw9+jOqzCaxHlYcAQ+OiJRyF0lZ7yxsGgkgxAIz9tl5wX7M/7OTn7wlaPamG0Lw6oht3m3uGttx5InADodJ/7ElCCD6F+xKFi7lowJxvO0Cl1Parj1TLGcs2N4sv8lBs3QIHzhpoJBnK00pUxtGC7g78Z9G+53YZLiSz8dyg0aT3jWqM4PuQfJU58YrKEZwYOLGf7qUTZGs7HCulwSY+i+9rapqgU
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb2419e3-3039-4faf-b243-08d8196ea76a
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jun 2020 01:17:11.7080 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RHXNM04DEQ9XNOcZAl+s8jybye3JMhtApokQGo37TKaxbfqtyai2w4ba/WaWZA2vHFJPx0xs0NBgAF5jGRUiJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR04MB0726
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200626_092408_811036_7CE4ADB5 
X-CRM114-Status: GOOD (  21.17  )
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

> The current IOCTL interface for zone management is limited by struct
> blk_zone_range, which is unfortunately not extensible. Specially, the
> lack of flags is problematic for ZNS zoned devices.
> =

> This new IOCTL is designed to be a superset of the current one, with
> support for flags and bits for extensibility.
> =

> Signed-off-by: Javier Gonz=E1lez <javier.gonz@samsung.com>
> Signed-off-by: SelvaKumar S <selvakuma.s1@samsung.com>
> Signed-off-by: Kanchan Joshi <joshi.k@samsung.com>
> Signed-off-by: Nitesh Shetty <nj.shetty@samsung.com>
> ---
>  block/blk-zoned.c             | 56 ++++++++++++++++++++++++++++++++++-
>  block/ioctl.c                 |  2 ++
>  include/linux/blkdev.h        |  9 ++++++
>  include/uapi/linux/blkzoned.h | 33 +++++++++++++++++++++
>  4 files changed, 99 insertions(+), 1 deletion(-)
> =

> diff --git a/block/blk-zoned.c b/block/blk-zoned.c
> index 81152a260354..e87c60004dc5 100644
> --- a/block/blk-zoned.c
> +++ b/block/blk-zoned.c
> @@ -322,7 +322,7 @@ int blkdev_report_zones_ioctl(struct block_device *bd=
ev, fmode_t mode,
>   * BLKRESETZONE, BLKOPENZONE, BLKCLOSEZONE and BLKFINISHZONE ioctl proce=
ssing.
>   * Called from blkdev_ioctl.
>   */
> -int blkdev_zone_mgmt_ioctl(struct block_device *bdev, fmode_t mode,
> +int blkdev_zone_ops_ioctl(struct block_device *bdev, fmode_t mode,
>  			   unsigned int cmd, unsigned long arg)
>  {
>  	void __user *argp =3D (void __user *)arg;
> @@ -370,6 +370,60 @@ int blkdev_zone_mgmt_ioctl(struct block_device *bdev=
, fmode_t mode,
>  				GFP_KERNEL);
>  }
>  =

> +/*
> + * Zone management ioctl processing. Extension of blkdev_zone_ops_ioctl(=
), with
> + * blk_zone_mgmt structure.
> + *
> + * Called from blkdev_ioctl.
> + */
> +int blkdev_zone_mgmt_ioctl(struct block_device *bdev, fmode_t mode,
> +			   unsigned int cmd, unsigned long arg)
> +{
> +	void __user *argp =3D (void __user *)arg;
> +	struct request_queue *q;
> +	struct blk_zone_mgmt zmgmt;
> +	enum req_opf op;
> +
> +	if (!argp)
> +		return -EINVAL;
> +
> +	q =3D bdev_get_queue(bdev);
> +	if (!q)
> +		return -ENXIO;
> +
> +	if (!blk_queue_is_zoned(q))
> +		return -ENOTTY;
> +
> +	if (!capable(CAP_SYS_ADMIN))
> +		return -EACCES;
> +
> +	if (!(mode & FMODE_WRITE))
> +		return -EBADF;
> +
> +	if (copy_from_user(&zmgmt, argp, sizeof(struct blk_zone_mgmt)))
> +		return -EFAULT;
> +
> +	switch (zmgmt.action) {
> +	case BLK_ZONE_MGMT_CLOSE:
> +		op =3D REQ_OP_ZONE_CLOSE;
> +		break;
> +	case BLK_ZONE_MGMT_FINISH:
> +		op =3D REQ_OP_ZONE_FINISH;
> +		break;
> +	case BLK_ZONE_MGMT_OPEN:
> +		op =3D REQ_OP_ZONE_OPEN;
> +		break;
> +	case BLK_ZONE_MGMT_RESET:
> +		op =3D REQ_OP_ZONE_RESET;
> +		break;
> +	default:
> +		return -ENOTTY;
> +	}
> +
> +	return blkdev_zone_mgmt(bdev, op, zmgmt.sector, zmgmt.nr_sectors,
> +				GFP_KERNEL);
> +}
> +
>  static inline unsigned long *blk_alloc_zone_bitmap(int node,
>  						   unsigned int nr_zones)
>  {
> diff --git a/block/ioctl.c b/block/ioctl.c
> index bdb3bbb253d9..0ea29754e7dd 100644
> --- a/block/ioctl.c
> +++ b/block/ioctl.c
> @@ -514,6 +514,8 @@ static int blkdev_common_ioctl(struct block_device *b=
dev, fmode_t mode,
>  	case BLKOPENZONE:
>  	case BLKCLOSEZONE:
>  	case BLKFINISHZONE:
> +		return blkdev_zone_ops_ioctl(bdev, mode, cmd, arg);
> +	case BLKMGMTZONE:
>  		return blkdev_zone_mgmt_ioctl(bdev, mode, cmd, arg);
>  	case BLKGETZONESZ:
>  		return put_uint(argp, bdev_zone_sectors(bdev));
> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> index 8fd900998b4e..bd8521f94dc4 100644
> --- a/include/linux/blkdev.h
> +++ b/include/linux/blkdev.h
> @@ -368,6 +368,8 @@ int blk_revalidate_disk_zones(struct gendisk *disk,
>  =

>  extern int blkdev_report_zones_ioctl(struct block_device *bdev, fmode_t =
mode,
>  				     unsigned int cmd, unsigned long arg);
> +extern int blkdev_zone_ops_ioctl(struct block_device *bdev, fmode_t mode,
> +				  unsigned int cmd, unsigned long arg);
>  extern int blkdev_zone_mgmt_ioctl(struct block_device *bdev, fmode_t mod=
e,
>  				  unsigned int cmd, unsigned long arg);
>  =

> @@ -385,6 +387,13 @@ static inline int blkdev_report_zones_ioctl(struct b=
lock_device *bdev,
>  	return -ENOTTY;
>  }
>  =

> +
> +static inline int blkdev_zone_ops_ioctl(struct block_device *bdev, fmode=
_t mode,
> +					unsigned int cmd, unsigned long arg)
> +{
> +	return -ENOTTY;
> +}
> +
>  static inline int blkdev_zone_mgmt_ioctl(struct block_device *bdev,
>  					 fmode_t mode, unsigned int cmd,
>  					 unsigned long arg)
> diff --git a/include/uapi/linux/blkzoned.h b/include/uapi/linux/blkzoned.h
> index 42c3366cc25f..07b5fde21d9f 100644
> --- a/include/uapi/linux/blkzoned.h
> +++ b/include/uapi/linux/blkzoned.h
> @@ -142,6 +142,38 @@ struct blk_zone_range {
>  	__u64		nr_sectors;
>  };
>  =

> +/**
> + * enum blk_zone_action - Zone state transitions managed from user-space
> + *
> + * @BLK_ZONE_MGMT_CLOSE: Transition to Closed state
> + * @BLK_ZONE_MGMT_FINISH: Transition to Finish state
> + * @BLK_ZONE_MGMT_OPEN: Transition to Open state
> + * @BLK_ZONE_MGMT_RESET: Transition to Reset state
> + */
> +enum blk_zone_action {
> +	BLK_ZONE_MGMT_CLOSE	=3D 0x1,
> +	BLK_ZONE_MGMT_FINISH	=3D 0x2,
> +	BLK_ZONE_MGMT_OPEN	=3D 0x3,
> +	BLK_ZONE_MGMT_RESET	=3D 0x4,
> +};
> +
> +/**
> + * struct blk_zone_mgmt - Extended zoned management
> + *
> + * @action: Zone action as in described in enum blk_zone_action
> + * @flags: Flags for the action
> + * @sector: Starting sector of the first zone to operate on
> + * @nr_sectors: Total number of sectors of all zones to operate on
> + */
> +struct blk_zone_mgmt {
> +	__u8		action;
> +	__u8		resv3[3];
> +	__u32		flags;
> +	__u64		sector;
> +	__u64		nr_sectors;
> +	__u64		resv31;
> +};
> +
>  /**
>   * Zoned block device ioctl's:
>   *
> @@ -166,5 +198,6 @@ struct blk_zone_range {
>  #define BLKOPENZONE	_IOW(0x12, 134, struct blk_zone_range)
>  #define BLKCLOSEZONE	_IOW(0x12, 135, struct blk_zone_range)
>  #define BLKFINISHZONE	_IOW(0x12, 136, struct blk_zone_range)
> +#define BLKMGMTZONE	_IOR(0x12, 137, struct blk_zone_mgmt)
>  =

>  #endif /* _UAPI_BLKZONED_H */
> =


Without defining what the flags can be, it is hard to judge what will change
from the current distinct ioctls.


-- =

Damien Le Moal
Western Digital Research

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
