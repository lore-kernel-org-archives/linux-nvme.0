Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C90BC25B0E
	for <linux-nvme@archiver.kernel.org>; Tue, 16 Aug 2022 16:02:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=GJzzvoyxKNUjxB38+K6jdm+Reg27FUY7XXdxLs8eB0k=; b=vSz5anVarSEelPsXjoPFjRkl1U
	3O9icfVzfDxExeC+YiGusByn9imf9ce2O85FM6H1h2krpdgzyv6BrY7vyue0SEmUbJLli4Feks6VL
	jdPJo/zGaajVLWJokofPR4EnkMAgAVwZ0M9dWY4TLC+4vs+k/npoV4Rma50vRHaxtMHuH2ILF7HG8
	2YkqTjszUbGEHzB1KVwgmkRWxb2AWDzmIe4GGqu4PEQVMze0EjCtDDrBQFUAlpN0iVxYd5QDkD2Ii
	SfER5wWrLgiZojduAZ/ViECJ27KM8o7P8ICW/i72b62jj845MxKwW7HQgDRbz6TyMym12+IwddyN0
	voVmZDpg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oNz0y-004G0u-SC; Tue, 16 Aug 2022 16:02:00 +0000
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oNz0q-004FzB-Uh
	for linux-nvme@lists.infradead.org; Tue, 16 Aug 2022 16:01:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1660665711; x=1692201711;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=gWta6mCRYZPmokqNjTVpFMpU8jnQuQs/z6XjFskr4pM=;
  b=FLuWN3v+blQxPsj5XbVMorE8wx3iVaLbeDIfwRZ9lWlXNv788W8U/N6B
   q/B0e2crnTDCcDLGj43J7JJx3O8a3hZg31em58GuKcOtME7E2ogIZ5vI1
   PmbOqQuL9FThneiY0PVALvR61bCsddOmCTjS5mziN38dKI9wWK3BQ1YSY
   xhPGfZFwVDcHb7l1ccBTZSNMmbOufgq/q5OQTMQUt8t9raWWp9accpADX
   lKDQoBhexyQA9sLLiAKb4A/jyn91GEv3vL9o0dNfLIHjF3W11/guZ8gUV
   sO/+sX8GsQzaS7eucryZvpeApPD3/BoiWuwQxzIIas3vCNFs58Gdzt2s7
   A==;
X-IronPort-AV: E=Sophos;i="5.93,241,1654531200"; 
   d="scan'208";a="208848146"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 17 Aug 2022 00:01:47 +0800
IronPort-SDR: 7+xUYZUB2q8tHk2GM8QoCi36oHqKBMuDXBG3XkdJLyL9cS3NrY5LbXLXNQBPWQJauy0unK41y2
 AyBVaLHTDRsZVr66GV6hp19bJS1PFnWj8u3aFMNfNJkpW12pI17uDkiBvy1fABeRZXh+oFOap2
 Q0xw3n4ePuvFruIk5zJOdIoH/+VaSHhSU6/ikF7zFugu+jP3UXyS2G+kKLeNYMwTCYEb0B+jRf
 RZSjo3iyg6TUG2FeSC38AZbBvTSIELUy88sIC4FKFeRoSyxMTsHCp58oS5czPpzQZcBpxJTpse
 qgnhEFVT7SLZYIQEVT4P+IZ6
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 16 Aug 2022 08:22:36 -0700
IronPort-SDR: ogcUu5eoo+hk7T9qcXtofxnB2irnnsDDcfNOw4/GnhDSQaF7egOCs5YPwW8e/Xwm2ZIeqFy6uS
 Wh6lUMnj30JYq4Akrhtii+U1MdmLnftu5oVEQp9WXczBXK83jZNW7n03VI+38SQRPU7RM1aD51
 Ioj9jg0wfX5vyADbr3qLrA0b5Va6B90DCoembeyShVqn6McyuXLH0apO2qxLPzIPLGiVom9HrU
 /4U6jieC6MAl2xyQ0TCY3o6zo6MLCnRBNDZtuZ2iuXeyxTRlHnv/5OfL8CdbhPOr7JvQXOWg8S
 yPQ=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 16 Aug 2022 09:01:49 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
	by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4M6bVz6vsnz1Rwry
	for <linux-nvme@lists.infradead.org>; Tue, 16 Aug 2022 09:01:47 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
	reason="pass (just generated, assumed good)"
	header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
	opensource.wdc.com; h=content-transfer-encoding:content-type
	:in-reply-to:organization:from:references:to:content-language
	:subject:user-agent:mime-version:date:message-id; s=dkim; t=
	1660665704; x=1663257705; bh=gWta6mCRYZPmokqNjTVpFMpU8jnQuQs/z6X
	jFskr4pM=; b=ixDLglPzO87092GcrTZlHm/qHK0AcS1FQnjCi9nfsQlOSbxxCKS
	6lYVeoCh+7BHix29xOljYxAEMgwzqEoszYJ8lV3jD5mP90/hxTuDSHwuULjANQop
	nIAqUY1VJrS+hjsJsb54WzCrxg9qxjqT4/VBAqAe9G9YvI3m79r/Ab+1i+02n6LJ
	X52pvXOVSi3Dc+V08PBrOJZ0ql/DzBc6E1phvyMs7F04B+WMrQygMzyt7rOtKY6l
	Lo1XuD3knNUS8nAeg5sUrwlDs9L7Z8o/k6vtM1Gb+R1iMUaXa5/KxyJ5w9AgpZHX
	7nGdX1JMxrYsrv/cVj8puXTGtczL6PUzkeQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
	by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id tF1MQ4sIurrr for <linux-nvme@lists.infradead.org>;
	Tue, 16 Aug 2022 09:01:44 -0700 (PDT)
Received: from [10.111.64.29] (c02drav6md6t.sdcorp.global.sandisk.com [10.111.64.29])
	by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4M6bVt6B61z1RtVk;
	Tue, 16 Aug 2022 09:01:42 -0700 (PDT)
Message-ID: <30790cae-5440-2447-a8b8-52a57fa16fa5@opensource.wdc.com>
Date: Tue, 16 Aug 2022 09:01:42 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.12.0
Subject: Re: [PATCH v11 13/13] dm: add power-of-2 target for zoned devices
 with non power-of-2 zone sizes
Content-Language: en-US
To: Pankaj Raghav <p.raghav@samsung.com>, axboe@kernel.dk,
 snitzer@kernel.org, hch@lst.de, agk@redhat.com
Cc: pankydev8@gmail.com, gost.dev@samsung.com, matias.bjorling@wdc.com,
 hare@suse.de, bvanassche@acm.org, linux-kernel@vger.kernel.org,
 dm-devel@redhat.com, linux-nvme@lists.infradead.org, jaegeuk@kernel.org,
 Johannes.Thumshirn@wdc.com, linux-block@vger.kernel.org,
 Damien Le Moal <damien.lemoal@wdc.com>
References: <20220816131536.189406-1-p.raghav@samsung.com>
 <CGME20220816131551eucas1p218faf35348e78a73aaa87d5477ecdb2e@eucas1p2.samsung.com>
 <20220816131536.189406-14-p.raghav@samsung.com>
From: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220816131536.189406-14-p.raghav@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220816_090153_125763_816C846D 
X-CRM114-Status: GOOD (  48.45  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 2022/08/16 6:15, Pankaj Raghav wrote:
> Only zoned devices with power-of-2(po2) number of sectors per zone(zone
> size) were supported in linux but now non power-of-2(npo2) zone sizes
> support has been added to the block layer.
> 
> Filesystems such as F2FS and btrfs have support for zoned devices with
> po2 zone size assumption. Before adding native support for npo2 zone
> sizes, it was suggested to create a dm target for npo2 zone size device to
> appear as a po2 zone size target so that file systems can initially
> work without any explicit changes by using this target.
> 
> The design of this target is very simple: remap the device zone size to
> the zone capacity and change the zone size to be the nearest power of 2
> value.
> 
> For e.g., a device with a zone size/capacity of 3M will have an equivalent
> target layout as follows:
> 
> Device layout :-
> zone capacity = 3M
> zone size = 3M
> 
> |--------------|-------------|
> 0             3M            6M
> 
> Target layout :-
> zone capacity=3M
> zone size = 4M
> 
> |--------------|---|--------------|---|
> 0             3M  4M             7M  8M
> 
> The area between target's zone capacity and zone size will be emulated
> in the target.
> The read IOs that fall in the emulated gap area will return 0 filled
> bio and all the other IOs in that area will result in an error.
> If a read IO span across the emulated area boundary, then the IOs are
> split across them. All other IO operations that span across the emulated
> area boundary will result in an error.
> 
> The target can be easily created as follows:
> dmsetup create <label> --table '0 <size_sects> po2zone /dev/nvme<id>'
> 
> Note that the target does not support partial mapping of the underlying
> device.
> 
> Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
> Suggested-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> Suggested-by: Damien Le Moal <damien.lemoal@wdc.com>
> Suggested-by: Hannes Reinecke <hare@suse.de>
> ---
>  .../admin-guide/device-mapper/dm-po2zone.rst  |  71 +++++
>  .../admin-guide/device-mapper/index.rst       |   1 +
>  drivers/md/Kconfig                            |  10 +
>  drivers/md/Makefile                           |   2 +
>  drivers/md/dm-po2zone-target.c                | 260 ++++++++++++++++++
>  5 files changed, 344 insertions(+)
>  create mode 100644 Documentation/admin-guide/device-mapper/dm-po2zone.rst
>  create mode 100644 drivers/md/dm-po2zone-target.c
> 
> diff --git a/Documentation/admin-guide/device-mapper/dm-po2zone.rst b/Documentation/admin-guide/device-mapper/dm-po2zone.rst
> new file mode 100644
> index 000000000000..19dc215fbcca
> --- /dev/null
> +++ b/Documentation/admin-guide/device-mapper/dm-po2zone.rst
> @@ -0,0 +1,71 @@
> +==========
> +dm-po2zone
> +==========
> +The dm-po2zone device mapper target exposes a zoned block device with a
> +non-power-of-2(npo2) number of sectors per zone as a power-of-2(po2)
> +number of sectors per zone(zone size).
> +The filesystems that support zoned block devices such as F2FS and BTRFS
> +assume po2 zone size as the kernel has traditionally only supported
> +those devices. However, as the kernel now supports zoned block devices with
> +npo2 zone sizes, the filesystems can run on top of the dm-po2zone target before
> +adding native support.
> +
> +Partial mapping of the underlying device is not supported by this target.
> +
> +Algorithm
> +=========
> +The device mapper target maps the underlying device's zone size to the
> +zone capacity and changes the zone size to the nearest po2 zone size.
> +The gap between the zone capacity and the zone size is emulated in the target.
> +E.g., a zoned block device with a zone size (and capacity) of 3M will have an
> +equivalent target layout with mapping as follows:
> +
> +::
> +
> +  0M           3M  4M        6M 8M
> +  |             |  |          |  |
> +  +x------------+--+x---------+--+x-------  Target
> +  |x            |  |x         |  |x
> +   x               x             x
> +   x               x             x
> +   x              x             x
> +   x             x             x
> +  |x            |x            |x
> +  +x------------+x------------+x----------  Device
> +  |             |             |
> +  0M           3M            6M
> +
> +A simple remap is performed for all the BIOs that do not cross the
> +emulation gap area, i.e., the area between the zone capacity and size.
> +
> +If a BIO crosses the emulation gap area, the following operations are performed:
> +
> +	Read:
> +		- If the BIO lies entirely in the emulation gap area, then zero out the BIO and complete it.
> +		- If the BIO spans the emulation gap area, split the BIO across the zone capacity boundary
> +                  and remap only the BIO within the zone capacity boundary. The other part of the split BIO
> +                  will be zeroed out.
> +
> +	Other operations:
> +                - Return an error
> +
> +Table parameters
> +================
> +
> +::
> +
> +  <dev path>
> +
> +Mandatory parameters:
> +
> +    <dev path>:
> +        Full pathname to the underlying block-device, or a
> +        "major:minor" device-number.
> +
> +Examples
> +========
> +
> +::
> +
> +  #!/bin/sh
> +  echo "0 `blockdev --getsz $1` po2zone $1" | dmsetup create po2z
> diff --git a/Documentation/admin-guide/device-mapper/index.rst b/Documentation/admin-guide/device-mapper/index.rst
> index cde52cc09645..1fd04b5b0565 100644
> --- a/Documentation/admin-guide/device-mapper/index.rst
> +++ b/Documentation/admin-guide/device-mapper/index.rst
> @@ -23,6 +23,7 @@ Device Mapper
>      dm-service-time
>      dm-uevent
>      dm-zoned
> +    dm-po2zone
>      era
>      kcopyd
>      linear
> diff --git a/drivers/md/Kconfig b/drivers/md/Kconfig
> index 998a5cfdbc4e..638801b2449a 100644
> --- a/drivers/md/Kconfig
> +++ b/drivers/md/Kconfig
> @@ -518,6 +518,16 @@ config DM_FLAKEY
>  	help
>  	 A target that intermittently fails I/O for debugging purposes.
>  
> +config DM_PO2ZONE
> +	tristate "Zoned block devices target emulating a power-of-2 number of sectors per zone"
> +	depends on BLK_DEV_DM
> +	depends on BLK_DEV_ZONED
> +	help
> +	  A target that converts a zoned block device with non-power-of-2(npo2)
> +	  number of sectors per zone to be power-of-2(po2). Use this target for
> +	  zoned block devices with npo2 number of sectors per zone until native
> +	  support is added to the filesystems and applications.
> +
>  config DM_VERITY
>  	tristate "Verity target support"
>  	depends on BLK_DEV_DM
> diff --git a/drivers/md/Makefile b/drivers/md/Makefile
> index 84291e38dca8..c23f81cc8789 100644
> --- a/drivers/md/Makefile
> +++ b/drivers/md/Makefile
> @@ -26,6 +26,7 @@ dm-era-y	+= dm-era-target.o
>  dm-clone-y	+= dm-clone-target.o dm-clone-metadata.o
>  dm-verity-y	+= dm-verity-target.o
>  dm-zoned-y	+= dm-zoned-target.o dm-zoned-metadata.o dm-zoned-reclaim.o
> +dm-po2zone-y	+= dm-po2zone-target.o
>  
>  md-mod-y	+= md.o md-bitmap.o
>  raid456-y	+= raid5.o raid5-cache.o raid5-ppl.o
> @@ -60,6 +61,7 @@ obj-$(CONFIG_DM_CRYPT)		+= dm-crypt.o
>  obj-$(CONFIG_DM_DELAY)		+= dm-delay.o
>  obj-$(CONFIG_DM_DUST)		+= dm-dust.o
>  obj-$(CONFIG_DM_FLAKEY)		+= dm-flakey.o
> +obj-$(CONFIG_DM_PO2ZONE)	+= dm-po2zone.o
>  obj-$(CONFIG_DM_MULTIPATH)	+= dm-multipath.o dm-round-robin.o
>  obj-$(CONFIG_DM_MULTIPATH_QL)	+= dm-queue-length.o
>  obj-$(CONFIG_DM_MULTIPATH_ST)	+= dm-service-time.o
> diff --git a/drivers/md/dm-po2zone-target.c b/drivers/md/dm-po2zone-target.c
> new file mode 100644
> index 000000000000..15dee7e218f1
> --- /dev/null
> +++ b/drivers/md/dm-po2zone-target.c
> @@ -0,0 +1,260 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2022 Samsung Electronics Co., Ltd.
> + */
> +
> +#include <linux/device-mapper.h>
> +
> +#define DM_MSG_PREFIX "po2zone"
> +
> +struct dm_po2z_target {
> +	struct dm_dev *dev;
> +	sector_t zone_size; /* Actual zone size of the underlying dev*/
> +	sector_t zone_size_po2; /* zone_size rounded to the nearest po2 value */
> +	unsigned int zone_size_po2_shift;
> +	sector_t zone_size_diff; /* diff between zone_size_po2 and zone_size */
> +	unsigned int nr_zones;
> +};
> +
> +static inline unsigned int npo2_zone_no(struct dm_po2z_target *dmh,
> +					sector_t sect)
> +{
> +	return div64_u64(sect, dmh->zone_size);
> +}
> +
> +static inline unsigned int po2_zone_no(struct dm_po2z_target *dmh,
> +				       sector_t sect)
> +{
> +	return sect >> dmh->zone_size_po2_shift;
> +}
> +
> +static inline sector_t target_to_device_sect(struct dm_po2z_target *dmh,
> +					     sector_t sect)
> +{
> +	return sect - (po2_zone_no(dmh, sect) * dmh->zone_size_diff);
> +}
> +
> +static inline sector_t device_to_target_sect(struct dm_po2z_target *dmh,
> +					     sector_t sect)
> +{
> +	return sect + (npo2_zone_no(dmh, sect) * dmh->zone_size_diff);
> +}
> +
> +/*
> + * This target works on the complete zoned device. Partial mapping is not
> + * supported.
> + * Construct a zoned po2 logical device: <dev-path>
> + */
> +static int dm_po2z_ctr(struct dm_target *ti, unsigned int argc, char **argv)
> +{
> +	struct dm_po2z_target *dmh = NULL;
> +	int ret;
> +	sector_t zone_size;
> +	sector_t dev_capacity;
> +
> +	if (argc != 1)
> +		return -EINVAL;
> +
> +	dmh = kmalloc(sizeof(*dmh), GFP_KERNEL);
> +	if (!dmh)
> +		return -ENOMEM;
> +
> +	ret = dm_get_device(ti, argv[0], dm_table_get_mode(ti->table),
> +			    &dmh->dev);
> +	if (ret) {
> +		ti->error = "Device lookup failed";
> +		kfree(dmh);
> +		return ret;
> +	}
> +
> +	if (!bdev_is_zoned(dmh->dev->bdev)) {
> +		DMERR("%pg is not a zoned device", dmh->dev->bdev);
> +		kfree(dmh);
> +		return -EINVAL;
> +	}
> +
> +	zone_size = bdev_zone_sectors(dmh->dev->bdev);
> +	dev_capacity = get_capacity(dmh->dev->bdev->bd_disk);
> +	if (ti->len != dev_capacity || ti->begin) {
> +		DMERR("%pg Partial mapping of the target not supported",
> +		      dmh->dev->bdev);
> +		kfree(dmh);
> +		return -EINVAL;
> +	}
> +
> +	if (is_power_of_2(zone_size))
> +		DMWARN("%pg: underlying device has a power-of-2 number of sectors per zone",
> +		       dmh->dev->bdev);
> +
> +	dmh->zone_size = zone_size;
> +	dmh->zone_size_po2 = 1 << get_count_order_long(zone_size);
> +	dmh->zone_size_po2_shift = ilog2(dmh->zone_size_po2);
> +	dmh->zone_size_diff = dmh->zone_size_po2 - dmh->zone_size;
> +	ti->private = dmh;
> +	ti->max_io_len = dmh->zone_size_po2;
> +	dmh->nr_zones = npo2_zone_no(dmh, ti->len);
> +	ti->len = dmh->zone_size_po2 * dmh->nr_zones;
> +
> +	return 0;
> +}
> +
> +static int dm_po2z_report_zones_cb(struct blk_zone *zone, unsigned int idx,
> +				   void *data)
> +{
> +	struct dm_report_zones_args *args = data;
> +	struct dm_po2z_target *dmh = args->tgt->private;
> +
> +	zone->start = device_to_target_sect(dmh, zone->start);
> +	zone->wp = device_to_target_sect(dmh, zone->wp);
> +	zone->len = dmh->zone_size_po2;
> +	args->next_sector = zone->start + zone->len;
> +
> +	return args->orig_cb(zone, args->zone_idx++, args->orig_data);
> +}
> +
> +static int dm_po2z_report_zones(struct dm_target *ti,
> +				struct dm_report_zones_args *args,
> +				unsigned int nr_zones)
> +{
> +	struct dm_po2z_target *dmh = ti->private;
> +	sector_t sect = po2_zone_no(dmh, args->next_sector) * dmh->zone_size;
> +
> +	return blkdev_report_zones(dmh->dev->bdev, sect, nr_zones,
> +				   dm_po2z_report_zones_cb, args);
> +}
> +
> +static int dm_po2z_end_io(struct dm_target *ti, struct bio *bio,
> +			  blk_status_t *error)
> +{
> +	struct dm_po2z_target *dmh = ti->private;
> +
> +	if (bio->bi_status == BLK_STS_OK && bio_op(bio) == REQ_OP_ZONE_APPEND)
> +		bio->bi_iter.bi_sector =
> +			device_to_target_sect(dmh, bio->bi_iter.bi_sector);
> +
> +	return DM_ENDIO_DONE;
> +}
> +
> +static void dm_po2z_io_hints(struct dm_target *ti, struct queue_limits *limits)
> +{
> +	struct dm_po2z_target *dmh = ti->private;
> +
> +	limits->chunk_sectors = dmh->zone_size_po2;
> +}
> +
> +/**
> + * bio_in_emulated_zone_area - check if bio is in the emulated zone area
> + * @dmh:	pozone target data
> + * @bio:	bio
> + * @offset:	bio offset to emulated zone boundary
> + *
> + * Check if a @bio is partly or completely in the emulated zone area. If the
> + * @bio is partly in the emulated zone area, @offset can be used to split
> + * the @bio across the emulated zone boundary. @offset
> + * will be negative if the @bio completely lies in the emulated area.
> + *
> + */
> +static bool bio_in_emulated_zone_area(struct dm_po2z_target *dmh,
> +				      struct bio *bio, int *offset)

This function name reads like it is a block layer helper. It mat be less
confucing to keep using the dm_po2z_ prefix for it.

> +{
> +	unsigned int zone_idx = po2_zone_no(dmh, bio->bi_iter.bi_sector);
> +	sector_t nr_sectors = bio->bi_iter.bi_size >> SECTOR_SHIFT;
> +	sector_t sector_offset =
> +		bio->bi_iter.bi_sector - (zone_idx << dmh->zone_size_po2_shift);
> +
> +	*offset = dmh->zone_size - sector_offset;
> +
> +	return sector_offset + nr_sectors > dmh->zone_size;
> +}
> +
> +static inline int dm_po2z_read_zeroes(struct bio *bio)
> +{
> +	zero_fill_bio(bio);
> +	bio_endio(bio);
> +	return DM_MAPIO_SUBMITTED;
> +}
> +
> +static inline int dm_po2z_remap_sector(struct dm_po2z_target *dmh,
> +				       struct bio *bio)
> +{
> +	bio->bi_iter.bi_sector =
> +		target_to_device_sect(dmh, bio->bi_iter.bi_sector);
> +	return DM_MAPIO_REMAPPED;
> +}
> +
> +static int dm_po2z_map(struct dm_target *ti, struct bio *bio)
> +{
> +	struct dm_po2z_target *dmh = ti->private;
> +	int split_io_pos;
> +
> +	bio_set_dev(bio, dmh->dev->bdev);
> +
> +	if (op_is_zone_mgmt(bio_op(bio)))
> +		return dm_po2z_remap_sector(dmh, bio);
> +
> +	if (!bio_sectors(bio))
> +		return DM_MAPIO_REMAPPED;
> +
> +	/*
> +	 * Read operation on the emulated zone area (between zone capacity
> +	 * and zone size) will fill the bio with zeroes. Any other operation
> +	 * in the emulated area should return an error.
> +	 */
> +	if (!bio_in_emulated_zone_area(dmh, bio, &split_io_pos))
> +		return dm_po2z_remap_sector(dmh, bio);
> +
> +	if (bio_op(bio) == REQ_OP_READ) {
> +	/*
> +	 * If the bio is across emulated zone boundary, split the bio at
> +	 * the boundary.
> +	 */

Weird indentation of the comments.

> +		if (split_io_pos > 0) {> +			dm_accept_partial_bio(bio, split_io_pos);
> +			return dm_po2z_remap_sector(dmh, bio);
> +		}
> +		return dm_po2z_read_zeroes(bio);
> +	}
> +
> +	return DM_MAPIO_KILL;
> +}
> +
> +static int dm_po2z_iterate_devices(struct dm_target *ti,
> +				   iterate_devices_callout_fn fn, void *data)
> +{
> +	struct dm_po2z_target *dmh = ti->private;
> +	sector_t len = dmh->nr_zones * dmh->zone_size;
> +
> +	return fn(ti, dmh->dev, 0, len, data);
> +}
> +
> +static struct target_type dm_po2z_target = {
> +	.name = "po2zone",
> +	.version = { 1, 0, 0 },
> +	.features = DM_TARGET_ZONED_HM | DM_TARGET_EMULATED_ZONES,
> +	.map = dm_po2z_map,
> +	.end_io = dm_po2z_end_io,
> +	.report_zones = dm_po2z_report_zones,
> +	.iterate_devices = dm_po2z_iterate_devices,
> +	.module = THIS_MODULE,
> +	.io_hints = dm_po2z_io_hints,
> +	.ctr = dm_po2z_ctr,
> +};
> +
> +static int __init dm_po2z_init(void)
> +{
> +	return dm_register_target(&dm_po2z_target);
> +}
> +
> +static void __exit dm_po2z_exit(void)
> +{
> +	dm_unregister_target(&dm_po2z_target);
> +}
> +
> +/* Module hooks */
> +module_init(dm_po2z_init);
> +module_exit(dm_po2z_exit);
> +
> +MODULE_DESCRIPTION(DM_NAME "power-of-2 zoned target");
> +MODULE_AUTHOR("Pankaj Raghav <p.raghav@samsung.com>");
> +MODULE_LICENSE("GPL");
> +


-- 
Damien Le Moal
Western Digital Research

