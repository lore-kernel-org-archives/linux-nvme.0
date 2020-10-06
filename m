Return-Path: <SRS0=LUST=DN=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84B1DC4363D
	for <linux-nvme@archiver.kernel.org>; Tue,  6 Oct 2020 23:50:47 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E24E22087E
	for <linux-nvme@archiver.kernel.org>; Tue,  6 Oct 2020 23:50:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="FMYByn3p";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="iqrvKSfK";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="ORr1KA5E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E24E22087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:To:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=Q4HePJEEXC64HLvWgW+4xG1EBuz1wB2Xfgk+1+Tu/8Q=; b=FMYByn3pZHmHzBuvbwQmbKUvU
	8LSaoeHkzW+yuDNyUNDO+t+EAvrYryTJjLDJmzw4Jv0Yvj1+mVSDZV2p8qK99BUzx4v0uBlf9UjN+
	GeewRu7+q9RUd/PSEt66Yey+RJZg9mGpITAYeWCv1PP66gMpql3Yjrg25ahpXxt1aOcoRvOBeA0jC
	t6sFuaDOCN8C4E07/2o6Yjlkv0/wARRuhXG9ZbMOmQm6nyrLQ4BcvufXr6qrX/W+/hpL1S5tD7yZ1
	8+eg6H5L/U62Y69gLERNALAEcgMoA+lRoH6Yx2Xj5xk0rJ6oYXbAAS9lnq1qUzb6yPb75h8asV7kp
	Fi+aPH/kA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kPwjD-0008Sw-0S; Tue, 06 Oct 2020 23:50:43 +0000
Received: from esa3.hgst.iphmx.com ([216.71.153.141])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kPwjA-0008ST-6S
 for linux-nvme@lists.infradead.org; Tue, 06 Oct 2020 23:50:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1602028240; x=1633564240;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=8sEBwX6l49+1SKDSR4Irg2b+TipAxCR1ScF0oeNZGBc=;
 b=iqrvKSfKDbFJMl+np4M3L5LaPfCeFS+3rl0oj45eA5iYVY7YPV7rf9JB
 TBog66zY5o4UtDzfsmoK0airgMrpKEhW0HpGR2floqRbqUJ983itXP3c9
 VefPd+npj69Mk2OVtRszKMzKYq7Wh886WZHb70H6sGVG1Pxiqo9jAIn/a
 9xhgGAciaQ9J9YUShfRulA6lX7OfUB2qsPB32oNpBtM2Vmwye23K6h76Q
 y+/HBZwft8WsGc8wuLd3fVtGVJyng6LRmttr93O/V310WMDzr5GsQIYRy
 ZLxWPg3ubhZP+ePdhMYhhmb7z7OGqPNbd3xIEu+MNdvc2gBjVKtfjpQ26 A==;
IronPort-SDR: 0yJV3eUJIP2OPn/k3noIcE05oaeZszklwdGgO0+mRKP/YJCalQj2lNArIRtZlTd3scl0xMShcW
 XbulUw3pA7KbrwQPMeotsF/QzHjCz4gooijnTbQr8g8pTPhpnk8MaAgKoxkmVQhZDpV0qCCWKQ
 mUozB9NP4VHje1mIsr+B1c0NPmRLYGG7IhZenMQOioFRnHCvKUm3dBRycewckZYQRJUoNtFrxk
 Yf0kWYI19M3QVQm2ylXdXzdFgp3ff8PXYqa0+Gv0+6OJZgkl6qBg+HCnFzUdAAHwXk5Wwiitr2
 RXI=
X-IronPort-AV: E=Sophos;i="5.77,344,1596470400"; d="scan'208";a="153632716"
Received: from mail-dm6nam11lp2169.outbound.protection.outlook.com (HELO
 NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.169])
 by ob1.hgst.iphmx.com with ESMTP; 07 Oct 2020 07:50:39 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A1y0oflbB20UbcC1LwhLpxRGQ5FgVcp/4IP9+U4lEweErcuFRRUCXLeJiTWmFnNyYhFmHOo4/sSPfT8LUwSsPJGDcA8S5swY1nFHcJLUWvS6SiO/Pa3NrJzbSMpYtHS69nozhX8jBQjTXoWs0gVFIkAaSJGJBY8mjwZ/KAUb7OGlUeWWxnxsBHsHxhVtvDrS5FAaNTT50ORALtRFR3mmEldBm3nU69HGlQIRGiC4UQvpfS3GNgBg22l+JYnB6YLIBEVkLhsTISicGERSSpCpdq3lvGti3pkooeOlhMD+ukyQXd3WtxiwlNkHUt1fGY/JVOOkhe8PqgUO2e3QMOMheg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ss0DuDYJWa5e/qd8Wsnzj/zPpcLTqF/yY2NNWBWm8Yk=;
 b=TOY0rkPHCy7XjQ3J1dP+we76bjbN8KX4M3gpnqUFFhpgjQVjKWKDMsl1Ts0nOmWaQtYd97fPvJ88WpWv68851862pNxszNI6+cKDkhcwKUOHel/L8GSCn/x6NyYniiukiK0wUVJDacs69krw/Yp65ZB7vhvfgwZx/Zxao9aqSTsnCrnHnC6ZGG5nNbOtpohz2wsJKCFhGU2dHxdHNChgoj7fXIxkidm4Whn5AlBBinFxZzvvaI3Oy+laoor4qKoOAlYjcwE/QIosNeq1FmJimWh7ZgYdAXdry6ApM77S9HnnNJjkFsShYyP/b+vKkCLvQ/lNqswLQ43lXlLHfy4H4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ss0DuDYJWa5e/qd8Wsnzj/zPpcLTqF/yY2NNWBWm8Yk=;
 b=ORr1KA5EiiXm8U8HmxMT6OKBzK4bqmaCWbzGNe7ZcpZy09rroTIvrXDz1RYU0cWxtW92BaGnQEvZf3+sirfxLk+UcqtyMRjlXw1SOFvDYEncFveelNyfLIBSDVNbkg5JN0KFznps96Lb+4V9+ZlqJpc8dYNWUDBvK+g2PEFpvRw=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB4871.namprd04.prod.outlook.com (2603:10b6:a03:4e::32)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.21; Tue, 6 Oct
 2020 23:50:37 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::3974:3107:df66:7698]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::3974:3107:df66:7698%7]) with mapi id 15.20.3433.044; Tue, 6 Oct 2020
 23:50:37 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Logan Gunthorpe <logang@deltatee.com>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>, "linux-block@vger.kernel.org"
 <linux-block@vger.kernel.org>, Omar Sandoval <osandov@osandov.com>
Subject: Re: [PATCH blktests v2 03/11] common/xfs: Create common helper to
 verify block device with xfs
Thread-Topic: [PATCH blktests v2 03/11] common/xfs: Create common helper to
 verify block device with xfs
Thread-Index: AQHWl1stoRmb/0l14EOVdSF8HArmFA==
Date: Tue, 6 Oct 2020 23:50:37 +0000
Message-ID: <BYAPR04MB4965C2DDD4A5FBD86A128FE9860D0@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20200930185422.11494-1-logang@deltatee.com>
 <20200930185422.11494-4-logang@deltatee.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: deltatee.com; dkim=none (message not signed)
 header.d=none;deltatee.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: a4670a2a-39a5-4733-7e07-08d86a529fd0
x-ms-traffictypediagnostic: BYAPR04MB4871:
x-microsoft-antispam-prvs: <BYAPR04MB4871B9BAF68C925DD8335AB2860D0@BYAPR04MB4871.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:3044;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HW/6urBAr81+Bdb/kZbdLgW+kZP60VBUHA13ZWB16S+1y/meLat/T7GO5O1GGchzsuVmEH9wuDsnBYvcrKvGAWnYHntsTzBfjLhATTwRkrYYZzhIjtDxJ6pdAMkTNBA5/AamdW7796quWi7vEvEosU8ZRc5c5tA+5XIcvJzvhV49m0E8UQ4vkQ2yG9OdsvdgYsosYn5x1rlDk7eEYCgGZBGGNKQuyNNvjNx0A0kThaJA4+irpWbPDuDWdEVzjliov8/wadZZfczaYjMTW3rq3bl+lwEFM8pf668jycZMHXBZCuqHjF7FPJ2vwrmIyqas9ToxDSiQ0lRPle74s6imWA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(64756008)(66556008)(66476007)(66446008)(76116006)(66946007)(55016002)(33656002)(110136005)(71200400001)(6506007)(7696005)(54906003)(26005)(52536014)(5660300002)(186003)(53546011)(86362001)(9686003)(83380400001)(8676002)(4326008)(498600001)(2906002)(15650500001)(8936002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: /aq85Ie/jVS45gZklCrrPoj06LrIDackl86WQApFH43KorlcTqRswx+VtP1AFxpWVl4yPUnCr+pZdEtuT3uBYAyMN9vnoO6JDfskFClXiolACFezYfW3O9pQkmt1o4lBuVKqiZSStWrCx4WDHtN8oG1gZDyimdFn7xR3cF1D11z/8UtkWx+IM43EahUIL5gWNDeZ8pdhwnuN24MC71+YsEai104kPQ3ycxMTYt0OrbXuIX8BnQScOfnEMLkZP1311HMqouxWTNBxGDjkr5yaJw5euoSfVMkYLRZkA3hmPNMH7mUkS28ZgxTuOsQS/CxDKW4yS/o6rwCFZqbxeaQ2Xk2uHuBD+AbNb4LPZIAzoCjwNBCBP2+6LaVDjJ+chOCZu3G/KWyH4JhUwaXCQU2HgocsQYMXXs9BZ0dLltcop9pu5vMJq56w40bucdQ6GNkPsNz+TOVAOhP30zPLqymN1GKCt/n4IvsrYdGStr6hIsd5qwvVq80tNpwu+JPqVKf91adNiyJoTFPy2tBXgTiAbbl08ei7FZbsURWzuMiUpahlUJ0/Xd3OkHc+j8pARY/PaV5VZEBdJz49tltnfmhm/6YSLSgSknzh9B7bApfxpQvQlS2O8im9w24xy7lUQk6I2JVnY4Ih9HudEAHkNPd6GA==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4670a2a-39a5-4733-7e07-08d86a529fd0
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Oct 2020 23:50:37.2879 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oiEZao0T3FZvxOCSy/8ZMvTyNsJ1sOn3Oh554OSJRa+ekn+QW2/Nr4d8tSiaDhgc159HOuw3pBmYOtC8RK+GLfsfNrU28+JMLweffRYDdAY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4871
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201006_195040_468826_A084CBD3 
X-CRM114-Status: GOOD (  16.92  )
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
Cc: Sagi Grimberg <sagi@grimberg.me>, Stephen Bates <sbates@raithlin.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 9/30/20 11:54, Logan Gunthorpe wrote:
> Make a common helper from the code in tests nvme/012 and nvme/013
> to run an fio verify on a XFS file system backed by the
> specified block device.
>
> While we are at it, all the output is redirected to $FULL instead of
> /dev/null.
>
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
> ---
>  common/xfs     | 22 ++++++++++++++++++++++
>  tests/nvme/012 | 14 +-------------
>  tests/nvme/013 | 14 +-------------
>  3 files changed, 24 insertions(+), 26 deletions(-)

The common namespace is getting cluttered. Can you please create

a subdirectory common/fs/xfs ?

>
> diff --git a/common/xfs b/common/xfs
> index d1a603b8c7b5..210c924cdd41 100644
> --- a/common/xfs
> +++ b/common/xfs
> @@ -9,3 +9,25 @@
>  _have_xfs() {
>  	_have_fs xfs && _have_program mkfs.xfs
>  }
> +
> +_xfs_mkfs_and_mount() {
> +	local bdev=$1
> +	local mount_dir=$2
> +
> +	mkdir -p "${mount_dir}"
> +	umount "${mount_dir}"
> +	mkfs.xfs -l size=32m -f "${bdev}"
> +	mount "${bdev}" "${mount_dir}"
> +}
> +
> +_xfs_run_fio_verify_io() {
> +	local mount_dir="/mnt/blktests"

The mount dir should be a parameter and not the hardcode value

to make it reusable.

> +	local bdev=$1
> +
> +	_xfs_mkfs_and_mount "${bdev}" "${mount_dir}" >> "${FULL}" 2>&1
> +
> +	_run_fio_verify_io --size=950m --directory="${mount_dir}/"
> +
> +	umount "${mount_dir}" >> "${FULL}" 2>&1
> +	rm -fr "${mount_dir}"
> +}
> diff --git a/tests/nvme/012 b/tests/nvme/012
> index 1d8d8e3cc271..a13cd08ce6bf 100755
> --- a/tests/nvme/012
> +++ b/tests/nvme/012
> @@ -26,12 +26,9 @@ test() {
>  	local port
>  	local nvmedev
>  	local loop_dev
> -	local mount_dir="/mnt/blktests"
>  	local file_path="${TMPDIR}/img"
>  	local subsys_name="blktests-subsystem-1"
>  
> -	mkdir -p "${mount_dir}" > /dev/null 2>&1
> -
>  	truncate -s 1G "${file_path}"
>  
>  	loop_dev="$(losetup -f --show "${file_path}")"
> @@ -47,15 +44,7 @@ test() {
>  	cat "/sys/block/${nvmedev}n1/uuid"
>  	cat "/sys/block/${nvmedev}n1/wwid"
>  
> -	umount ${mount_dir} > /dev/null 2>&1
> -
> -	mkfs.xfs -l size=32m -f /dev/"${nvmedev}n1" > /dev/null 2>&1
> -
> -	mount /dev/"${nvmedev}n1" "${mount_dir}"
> -
> -	_run_fio_verify_io --size=950m --directory="${mount_dir}/"
> -
> -	umount "${mount_dir}" > /dev/null 2>&1
> +	_xfs_run_fio_verify_io "/dev/${nvmedev}n1"
>  
>  	_nvme_disconnect_subsys "${subsys_name}"
>  
> @@ -66,7 +55,6 @@ test() {
>  	losetup -d "${loop_dev}"
>  
>  	rm "${file_path}"
> -	rm -fr "${mount_dir}"
>  
>  	echo "Test complete"
>  }
> diff --git a/tests/nvme/013 b/tests/nvme/013
> index 3819a2730d9b..1ac725ea83f2 100755
> --- a/tests/nvme/013
> +++ b/tests/nvme/013
> @@ -24,13 +24,10 @@ test() {
>  
>  	local port
>  	local nvmedev
> -	local mount_dir="/mnt/blktests/"
>  	local file_path="${TMPDIR}/img"
>  
>  	local subsys_name="blktests-subsystem-1"
>  
> -	mkdir -p "${mount_dir}" > /dev/null 2>&1
> -
>  	truncate -s 1G "${file_path}"
>  
>  	_create_nvmet_subsystem "${subsys_name}" "${file_path}" \
> @@ -44,15 +41,7 @@ test() {
>  	cat "/sys/block/${nvmedev}n1/uuid"
>  	cat "/sys/block/${nvmedev}n1/wwid"
>  
> -	umount ${mount_dir} > /dev/null 2>&1
> -
> -	mkfs.xfs -l size=32m -f /dev/"${nvmedev}n1" > /dev/null 2>&1
> -
> -	mount /dev/"${nvmedev}n1" "${mount_dir}"
> -
> -	_run_fio_verify_io --size=800m --directory="${mount_dir}/"
> -
> -	umount "${mount_dir}" > /dev/null 2>&1
> +	_xfs_run_fio_verify_io "/dev/${nvmedev}n1"
>  
>  	_nvme_disconnect_subsys "${subsys_name}"
>  
> @@ -61,7 +50,6 @@ test() {
>  	_remove_nvmet_port "${port}"
>  
>  	rm "${file_path}"
> -	rm -fr "${mount_dir}"
>  
>  	echo "Test complete"
>  }

rest looks good


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
