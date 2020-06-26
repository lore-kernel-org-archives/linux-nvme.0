Return-Path: <SRS0=morU=AH=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 072E8C433E0
	for <linux-nvme@archiver.kernel.org>; Fri, 26 Jun 2020 10:07:51 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B607F20EDD
	for <linux-nvme@archiver.kernel.org>; Fri, 26 Jun 2020 10:07:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="dNx5k51w";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="a3gjiUfj";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="eLeU0VJh";
	dkim=neutral (0-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="jzX0O7ke"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B607F20EDD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:To:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=ttRspVHgxKoYBpwe+OPSLLxoAgDyyGamt3vaRug/8XU=; b=dNx5k51w1X2qlzieg9Dzgnttc
	8jJb2Ws5VpvAFTGJcsl9/uioplL2UZlTsylMBxywM9nyrxChGida0EpHH6NJ22T59/7isO3f4Stf2
	dYkw5EhjzLiHrWObhLVlougz7powOpOGkgI1N1SUh1yR4lyxj2sMX9VGkcMwshwUsDZ2zGUSc4pvT
	vyAs4hBKF2TaNVGsZ27glA1jvyAgZ22mIvYtH2AQcbRCEX0tALGjDwDk+8OZKHOMZB2Si8V7ooTEA
	8gK3Xg3MkJa+3F9XVp1KJbgDT6l4ESe8m5s/wy7tdGWlUTS+dsvjWCJp8mf7A0YXSN24lGn32jEwy
	+KBH/EBZA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jolGt-0002F4-DE; Fri, 26 Jun 2020 10:07:47 +0000
Received: from casper.infradead.org ([90.155.50.34])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jolDZ-0000YK-1U
 for linux-nvme@merlin.infradead.org; Fri, 26 Jun 2020 10:04:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=MIME-Version:Content-Transfer-Encoding:
 Content-Type:References:Message-ID:Date:Subject:CC:To:From:Sender:Reply-To:
 Content-ID:Content-Description:In-Reply-To;
 bh=Vj7gS4hS0eiNiG/9xfiOiW8s/AQKHxVrlyQyH/lgNIY=; b=a3gjiUfjCLqqaO9jtDjVzgBRUO
 EPj4MNV9/ezJ7ehu9zclfF1/KzJOegDqA2r3fOf81zOgvhzTrFJJvtFoHxbLSU/FwcAbM+HCS3TbJ
 sOtfb2aw3B9ynTA/uIUadX+bGrcJIsxxXFs9gPwh+g4W+H/HkIBuNadxJpgkJcfV+gZUeaqntO18r
 pI+4h0IseTOVC3pZkDTO1Y60Mb5PMbeslwLs2rA8yvNIakFt81y+rlwE3muzaZ7MLMEH7AFAYBitp
 knHZcBCyUiVdgQ96F4Eao1/RF/vBp/1QcenV/nObOExjcp1sSoEiLbMK5jzE+/uIPPuEmWvgh8Vc0
 XCYe9N1A==;
Received: from esa3.hgst.iphmx.com ([216.71.153.141])
 by casper.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jolAi-0003er-Av
 for linux-nvme@lists.infradead.org; Fri, 26 Jun 2020 10:01:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1593165685; x=1624701685;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=as3440I8sQn7O0a3MUuRQmjClzRoGiojyqYdUuawvQw=;
 b=eLeU0VJhO3Ze2waNmjBYJZX1L2cDaPwg+yUaTXEAHH7gJd/X23UUPuxC
 eMiBCYBRFP0NdQo5DPuBBMRl7EqOmwR5DbVbXH84ATs6xi3syFgXWM15W
 H7bE0iOCjcDe6+utkMmFE1OF3ABf+WEsY4Jrtk20oHwLHkd3yrpJU3NAR
 RsP/Po1IyMui2VB423Y9TLVpeVszrzVbTqwHnd//nqtx1cuQr/cZOyrmM
 c82xcWMUjCayvAl/Zt6vrWt9YOwwOpoRgSnqIfNa28iplyFjQWovFcBSF
 gu70sp0pxSaVLX5g10iN/AI2RFt7pMUnX5lluwKjFxyBmIIA84zuvxetN Q==;
IronPort-SDR: UMEmyMTJZjc9Q3/qybNxD/bVMhAICiubZb+4HLOa4rRAE1LzS8KN3IxU5usk1OaASlvOpmfmID
 NYRyopBiGtL+8mgESrH2Bzd4ORGL51tJAkQZfkBlB6cREarG1Et3eq2Rgg4KgHAGhiR6iBSbMG
 E3m2NLFFDBTsahWfJezxKl59P7hGWWGwdO/3qkPF8AY5G/UNftM8f+NY55827lPZLvwI0hr6hp
 ZzhgvUnCB1idyS9lZiqeS2gWSqp/yks6DO4XWb1SukFAtVPde5f84tro+EqONPi7h4zok8iAYK
 jq8=
X-IronPort-AV: E=Sophos;i="5.75,282,1589212800"; d="scan'208";a="145304787"
Received: from mail-bn3nam04lp2053.outbound.protection.outlook.com (HELO
 NAM04-BN3-obe.outbound.protection.outlook.com) ([104.47.46.53])
 by ob1.hgst.iphmx.com with ESMTP; 26 Jun 2020 14:37:35 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dTAjvD3SMyA3eFVUTNe1zfs93HNhAHU8tiALhW+v87APVYG7JKdBWRA0hA4iyFZ8/X1TPxOKUK7BKjwhPXC7ZPqiDqc39pP2Wtr5i3D7M2YeKWIf3dX4YJMACT4hAgVwIC0KVqGZp4NlloBst7j3LMPEGLRw9UiNYybpVUyu9rmm4Vi6LxNs1O6XaHnxojYuHDad9CY6DbyP/ZxqxziNDRf1Fry2HQwIZ9cfQ1/j3SfmIHXa0gz0wpy0oZGzBIforFay786XI94RmdlHlOnwn5XgIFFejhPvHMXN7CgKwaFTeMUodltFCPGLJEv23jOG7LYfWjF0rpGEFkqhAz207Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vj7gS4hS0eiNiG/9xfiOiW8s/AQKHxVrlyQyH/lgNIY=;
 b=K9pUdxojhMk+5zbaFdkzYrm8KGXWtSo1Oby9kA/8ImjS/6ohS6we+axk6Ak2Cfi9b2FTMLWCQxr3X1zATk24ogh/iEHJXlZ4CcQz+6ydlzA5noo1m1cv9YI80ikcEioww0yFYc2eAy5S2dXkHvQqU+4Jra8twCZ2fwqBeThQTzlSqn6Xo/Ir1S1dA+YO4VsdOqQtnFHcibhDc2UrkYEehSYomwerrSY7iHffznTdBInzNl0TaONDCi9/7iF+AhFhvPb6gpyehBngoBenTSOD5O2xsBI8k7Jv1XXVCzvbJGdsCFESDJmG2xhOcDGlihcjfOms8Iy0Q+fidW6WJlL1/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vj7gS4hS0eiNiG/9xfiOiW8s/AQKHxVrlyQyH/lgNIY=;
 b=jzX0O7keze6bdUsTda9cwPlJKovO6qG63bH8t9/plGh0+36SueXfMLkjShgoyn1zLinQuPrz3mx4Hae7aFawTMe6sdAKZx2ysrouPN75Rk5uCL+3KynRzwE/HpQPj+TiBfO/GAbIjiA9WaJbIsmEuUtNssY0LDKhW0qeRntunPM=
Received: from CY4PR04MB3751.namprd04.prod.outlook.com (2603:10b6:903:ec::14)
 by CY1PR04MB2316.namprd04.prod.outlook.com (2a01:111:e400:c618::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.23; Fri, 26 Jun
 2020 06:37:33 +0000
Received: from CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::c593:f271:eebe:ac7]) by CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::c593:f271:eebe:ac7%9]) with mapi id 15.20.3131.024; Fri, 26 Jun 2020
 06:37:33 +0000
From: Damien Le Moal <Damien.LeMoal@wdc.com>
To: =?iso-8859-1?Q?Javier_Gonz=E1lez?= <javier@javigon.com>
Subject: Re: [PATCH 1/6] block: introduce IOCTL for zone mgmt
Thread-Topic: [PATCH 1/6] block: introduce IOCTL for zone mgmt
Thread-Index: AQHWSutOpOYox0Fba0KpyHzgytYs/A==
Date: Fri, 26 Jun 2020 06:37:33 +0000
Message-ID: <CY4PR04MB37514A1058726B8681AE2501E7930@CY4PR04MB3751.namprd04.prod.outlook.com>
References: <20200625122152.17359-1-javier@javigon.com>
 <20200625122152.17359-2-javier@javigon.com>
 <CY4PR04MB3751608EA9351354A614A0BFE7930@CY4PR04MB3751.namprd04.prod.outlook.com>
 <20200626060150.42yfebbyhh6ojf5u@mpHalley.localdomain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: javigon.com; dkim=none (message not signed)
 header.d=none;javigon.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.182.57]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 252aa010-14c9-4dfe-a493-08d8199b684e
x-ms-traffictypediagnostic: CY1PR04MB2316:
x-microsoft-antispam-prvs: <CY1PR04MB2316C4A2A304D51091F01599E7930@CY1PR04MB2316.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0446F0FCE1
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TyFd2izqft+zLaabiFZ4kgEC/St3DYdKbGK7+y5FB6eq0QHGONJ8WUGK+RS94hMpT24sZQYcLu6KxoIrtb/hpe4RhM5Cukn5TOejb06es1BhpW7/DY/g2fzhJxWJwuYzkZ+aRijAsQk4C+tBuEh8T01UxC7nvxtKp4rwru8bXfmUJzu+6LL7NPZlPyQbjrmYCewnSizV5Tsdom0uNCy5jreiApDR6MUv4S2tfVTdh2sUrWiIpkGBTDfDC6qETkSFviufRB8GHnnMBiWlvinOaXXUubLQhtqxUhOKjCHkQgGtOMqUzgxZ7VWVPA0i8RiAfuz6SU9p88YVhvHeKwld5w==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR04MB3751.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(346002)(136003)(366004)(376002)(39860400002)(6916009)(53546011)(8676002)(86362001)(66556008)(71200400001)(66446008)(316002)(64756008)(66946007)(66476007)(66574015)(4326008)(6506007)(2906002)(83380400001)(7696005)(26005)(8936002)(186003)(33656002)(7416002)(54906003)(478600001)(9686003)(76116006)(5660300002)(55016002)(91956017)(52536014);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: Esgazi9NDde4y9+EHp0R7rqEsqOxTlQLjFg707B3Afzxz3od6tt3fNcpTuJ6uq9vnNOOXnUpCI0+vAkoAfNUq00tClUP8+fvWxjO7VvOJtm2LGuFlUlQUn/g/4x6m+iBfZkQmTOIfZjo0N8Mg0Z7hUD5Wd8UDzJbgRxgJP6yWzS55QjEIGNiWBE9H872m0CV68iDHFVNW7iVxUiSEf6nelrCHmmiTI87lk/h4KyndSwVSCg1Z0hF1vhQmUdIGIOBqY/00e30r7G74W10Jn4snVquBd6l1H6psZysJylp8jQm3nymbWbvyscrIjK3YfsKXJzg0ElqvlIVhfEuLRQC9t5+15XN97EGJsB8G8oWo+SblvxTAD+Pskbft/mT9WZVf0F7wEz60NzySzaw3B1VWDqOkOxny/9hFoZvNEYMhrZqcJSZn0DpFUOi4FB+dB1YziWCVbunGeyS6Nz+GUiPrN9rGgwnMwyaaVnlIeyHxIj9suu7+9w5OQ6lM2fg7n10
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR04MB3751.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 252aa010-14c9-4dfe-a493-08d8199b684e
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jun 2020 06:37:33.2605 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RlzXGXUaUDVOlXbe9gksVRoz0vIzWTIHH5PKQ5CYjcQ9Gp0PKwnfh0RZw8UYE0ywpxGvUjR4UNOFZ07+PZ8BCg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR04MB2316
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200626_110125_540494_A1D646D4 
X-CRM114-Status: GOOD (  18.27  )
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
 Kanchan Joshi <joshi.k@samsung.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Nitesh Shetty <nj.shetty@samsung.com>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "kbusch@kernel.org" <kbusch@kernel.org>, "hch@lst.de" <hch@lst.de>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 2020/06/26 15:01, Javier Gonz=E1lez wrote:
> On 26.06.2020 01:17, Damien Le Moal wrote:
>> On 2020/06/25 21:22, Javier Gonz=E1lez wrote:
>>> From: Javier Gonz=E1lez <javier.gonz@samsung.com>
>>>
>>> The current IOCTL interface for zone management is limited by struct
>>> blk_zone_range, which is unfortunately not extensible. Specially, the
>>> lack of flags is problematic for ZNS zoned devices.
>>>
>>> This new IOCTL is designed to be a superset of the current one, with
>>> support for flags and bits for extensibility.
>>>
>>> Signed-off-by: Javier Gonz=E1lez <javier.gonz@samsung.com>
>>> Signed-off-by: SelvaKumar S <selvakuma.s1@samsung.com>
>>> Signed-off-by: Kanchan Joshi <joshi.k@samsung.com>
>>> Signed-off-by: Nitesh Shetty <nj.shetty@samsung.com>
>>> ---
>>>  block/blk-zoned.c             | 56 ++++++++++++++++++++++++++++++++++-
>>>  block/ioctl.c                 |  2 ++
>>>  include/linux/blkdev.h        |  9 ++++++
>>>  include/uapi/linux/blkzoned.h | 33 +++++++++++++++++++++
>>>  4 files changed, 99 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/block/blk-zoned.c b/block/blk-zoned.c
>>> index 81152a260354..e87c60004dc5 100644
>>> --- a/block/blk-zoned.c
>>> +++ b/block/blk-zoned.c
>>> @@ -322,7 +322,7 @@ int blkdev_report_zones_ioctl(struct block_device *=
bdev, fmode_t mode,
>>>   * BLKRESETZONE, BLKOPENZONE, BLKCLOSEZONE and BLKFINISHZONE ioctl pro=
cessing.
>>>   * Called from blkdev_ioctl.
>>>   */
>>> -int blkdev_zone_mgmt_ioctl(struct block_device *bdev, fmode_t mode,
>>> +int blkdev_zone_ops_ioctl(struct block_device *bdev, fmode_t mode,
>>>  			   unsigned int cmd, unsigned long arg)
>>>  {
>>>  	void __user *argp =3D (void __user *)arg;
>>> @@ -370,6 +370,60 @@ int blkdev_zone_mgmt_ioctl(struct block_device *bd=
ev, fmode_t mode,
>>>  				GFP_KERNEL);
>>>  }
>>>
>>> +/*
>>> + * Zone management ioctl processing. Extension of blkdev_zone_ops_ioct=
l(), with
>>> + * blk_zone_mgmt structure.
>>> + *
>>> + * Called from blkdev_ioctl.
>>> + */
>>> +int blkdev_zone_mgmt_ioctl(struct block_device *bdev, fmode_t mode,
>>> +			   unsigned int cmd, unsigned long arg)
>>> +{
>>> +	void __user *argp =3D (void __user *)arg;
>>> +	struct request_queue *q;
>>> +	struct blk_zone_mgmt zmgmt;
>>> +	enum req_opf op;
>>> +
>>> +	if (!argp)
>>> +		return -EINVAL;
>>> +
>>> +	q =3D bdev_get_queue(bdev);
>>> +	if (!q)
>>> +		return -ENXIO;
>>> +
>>> +	if (!blk_queue_is_zoned(q))
>>> +		return -ENOTTY;
>>> +
>>> +	if (!capable(CAP_SYS_ADMIN))
>>> +		return -EACCES;
>>> +
>>> +	if (!(mode & FMODE_WRITE))
>>> +		return -EBADF;
>>> +
>>> +	if (copy_from_user(&zmgmt, argp, sizeof(struct blk_zone_mgmt)))
>>> +		return -EFAULT;
>>> +
>>> +	switch (zmgmt.action) {
>>> +	case BLK_ZONE_MGMT_CLOSE:
>>> +		op =3D REQ_OP_ZONE_CLOSE;
>>> +		break;
>>> +	case BLK_ZONE_MGMT_FINISH:
>>> +		op =3D REQ_OP_ZONE_FINISH;
>>> +		break;
>>> +	case BLK_ZONE_MGMT_OPEN:
>>> +		op =3D REQ_OP_ZONE_OPEN;
>>> +		break;
>>> +	case BLK_ZONE_MGMT_RESET:
>>> +		op =3D REQ_OP_ZONE_RESET;
>>> +		break;
>>> +	default:
>>> +		return -ENOTTY;
>>> +	}
>>> +
>>> +	return blkdev_zone_mgmt(bdev, op, zmgmt.sector, zmgmt.nr_sectors,
>>> +				GFP_KERNEL);
>>> +}
>>> +
>>>  static inline unsigned long *blk_alloc_zone_bitmap(int node,
>>>  						   unsigned int nr_zones)
>>>  {
>>> diff --git a/block/ioctl.c b/block/ioctl.c
>>> index bdb3bbb253d9..0ea29754e7dd 100644
>>> --- a/block/ioctl.c
>>> +++ b/block/ioctl.c
>>> @@ -514,6 +514,8 @@ static int blkdev_common_ioctl(struct block_device =
*bdev, fmode_t mode,
>>>  	case BLKOPENZONE:
>>>  	case BLKCLOSEZONE:
>>>  	case BLKFINISHZONE:
>>> +		return blkdev_zone_ops_ioctl(bdev, mode, cmd, arg);
>>> +	case BLKMGMTZONE:
>>>  		return blkdev_zone_mgmt_ioctl(bdev, mode, cmd, arg);
>>>  	case BLKGETZONESZ:
>>>  		return put_uint(argp, bdev_zone_sectors(bdev));
>>> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
>>> index 8fd900998b4e..bd8521f94dc4 100644
>>> --- a/include/linux/blkdev.h
>>> +++ b/include/linux/blkdev.h
>>> @@ -368,6 +368,8 @@ int blk_revalidate_disk_zones(struct gendisk *disk,
>>>
>>>  extern int blkdev_report_zones_ioctl(struct block_device *bdev, fmode_=
t mode,
>>>  				     unsigned int cmd, unsigned long arg);
>>> +extern int blkdev_zone_ops_ioctl(struct block_device *bdev, fmode_t mo=
de,
>>> +				  unsigned int cmd, unsigned long arg);
>>>  extern int blkdev_zone_mgmt_ioctl(struct block_device *bdev, fmode_t m=
ode,
>>>  				  unsigned int cmd, unsigned long arg);
>>>
>>> @@ -385,6 +387,13 @@ static inline int blkdev_report_zones_ioctl(struct=
 block_device *bdev,
>>>  	return -ENOTTY;
>>>  }
>>>
>>> +
>>> +static inline int blkdev_zone_ops_ioctl(struct block_device *bdev, fmo=
de_t mode,
>>> +					unsigned int cmd, unsigned long arg)
>>> +{
>>> +	return -ENOTTY;
>>> +}
>>> +
>>>  static inline int blkdev_zone_mgmt_ioctl(struct block_device *bdev,
>>>  					 fmode_t mode, unsigned int cmd,
>>>  					 unsigned long arg)
>>> diff --git a/include/uapi/linux/blkzoned.h b/include/uapi/linux/blkzone=
d.h
>>> index 42c3366cc25f..07b5fde21d9f 100644
>>> --- a/include/uapi/linux/blkzoned.h
>>> +++ b/include/uapi/linux/blkzoned.h
>>> @@ -142,6 +142,38 @@ struct blk_zone_range {
>>>  	__u64		nr_sectors;
>>>  };
>>>
>>> +/**
>>> + * enum blk_zone_action - Zone state transitions managed from user-spa=
ce
>>> + *
>>> + * @BLK_ZONE_MGMT_CLOSE: Transition to Closed state
>>> + * @BLK_ZONE_MGMT_FINISH: Transition to Finish state
>>> + * @BLK_ZONE_MGMT_OPEN: Transition to Open state
>>> + * @BLK_ZONE_MGMT_RESET: Transition to Reset state
>>> + */
>>> +enum blk_zone_action {
>>> +	BLK_ZONE_MGMT_CLOSE	=3D 0x1,
>>> +	BLK_ZONE_MGMT_FINISH	=3D 0x2,
>>> +	BLK_ZONE_MGMT_OPEN	=3D 0x3,
>>> +	BLK_ZONE_MGMT_RESET	=3D 0x4,
>>> +};
>>> +
>>> +/**
>>> + * struct blk_zone_mgmt - Extended zoned management
>>> + *
>>> + * @action: Zone action as in described in enum blk_zone_action
>>> + * @flags: Flags for the action
>>> + * @sector: Starting sector of the first zone to operate on
>>> + * @nr_sectors: Total number of sectors of all zones to operate on
>>> + */
>>> +struct blk_zone_mgmt {
>>> +	__u8		action;
>>> +	__u8		resv3[3];
>>> +	__u32		flags;
>>> +	__u64		sector;
>>> +	__u64		nr_sectors;
>>> +	__u64		resv31;
>>> +};
>>> +
>>>  /**
>>>   * Zoned block device ioctl's:
>>>   *
>>> @@ -166,5 +198,6 @@ struct blk_zone_range {
>>>  #define BLKOPENZONE	_IOW(0x12, 134, struct blk_zone_range)
>>>  #define BLKCLOSEZONE	_IOW(0x12, 135, struct blk_zone_range)
>>>  #define BLKFINISHZONE	_IOW(0x12, 136, struct blk_zone_range)
>>> +#define BLKMGMTZONE	_IOR(0x12, 137, struct blk_zone_mgmt)
>>>
>>>  #endif /* _UAPI_BLKZONED_H */
>>>
>>
>> Without defining what the flags can be, it is hard to judge what will ch=
ange
>>from the current distinct ioctls.
>>
> =

> The first flag is the one to select all. Down the line we have other
> modifiers that make sense, but it is true that it is public yet.

You mean *not* public ?

> =

> Would you like to wait until then or is it an option to revise the IOCTL
> now?

Yes. Wait until it is actually needed. Adding code that has no users makes =
it
impossible to test so not acceptable. As for the "all zones" flag, I already
commented about it.

> =

> Javier
> =



-- =

Damien Le Moal
Western Digital Research

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
