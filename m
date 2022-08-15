Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3765DC00140
	for <linux-nvme@archiver.kernel.org>; Mon, 15 Aug 2022 18:58:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=W/lFBjot7tryRzPm5syzaz23xxVaLd4UL4vG2N8Avh8=; b=ufVZdlxTYAwLhryVBLL7QwkFMR
	v40dvIX2mcNUJpnUEW3vzLQcwlVTv4anapsTm/Ga8MW0NgAHwfFcGtO9j5Oc6x6ogBqLXonBdIilg
	SctxJTQxxsYOZ0xmzETTq6T2gxg/bnAIvJZqSbxNhapbuswMi4K3LBjcj7w6sVt2XJQ+7gURgl0/9
	pXYqsR2VfW1EY21B1Zw87fZnI7Qq7MUrk5XEFS2izlqlMMutur37QRP2hNTmkn6iVh2219FxHYpPC
	26ve3vy66KuUDp0ogIZbRBwBh8hBpgERi0FtzoGPpJxfYBwPHnp0YjdHK65u9eEmXz3DRwMe6uQvU
	EwbH27gg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oNfIZ-003b7e-VZ; Mon, 15 Aug 2022 18:58:52 +0000
Received: from esa6.hgst.iphmx.com ([216.71.154.45])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oNfFy-003YNl-Gs
	for linux-nvme@lists.infradead.org; Mon, 15 Aug 2022 18:56:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1660589770; x=1692125770;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=V1iJTH7GEzKcPtxfy/9tnWQGVGcg7nbx15/9pWEV0IM=;
  b=ovCThcMSTbCkcHfJiXmDQdPP39PALL/cN0PQhl2U3yvWtZc0ARPND6xo
   arS+L73GqHyUify33MXAS9kwxTELQyOeaEx5bFNt+GYhyXYGoR47VdX2J
   ePt43dHHInnyO3iQQONaE3ryvkM6RrTpfSE2yOPjrjegHpYAmArhaIVhS
   eMsAWmhS7ubQDozJUAR+pE5Nr30sK7zgV5lU1qI0uaQbEh50QhYe4YE9t
   0F2X8XQn2Gb5F4Ey+azVT1xf36SuqvCijLN3xJkFk29MXGPY8WdOQ1dzv
   k0QN4hpN9iIT+KLFpZ4DDHAcLXL07exS8jkWDhSDsNZGLGcLVyx1wqfKQ
   w==;
X-IronPort-AV: E=Sophos;i="5.93,239,1654531200"; 
   d="scan'208";a="209294615"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 16 Aug 2022 02:56:04 +0800
IronPort-SDR: cGQ1Xl/LPBI8u09YFxRYEdCpMQvSgHiz6O834+LKmlBhHz3cQH31hjIqA74KyRHsd3uakgMfZV
 yiQ+RMYsw+N0S4gpSR6uaMdayF+8lNEwPWJQV2hWgPuZmTDmS1QYss77ZLsa/qUPxKvzGFgUiR
 +rKWd6Vjhqv8/VLnCmu/3Z6MhdZr/coQroH4yPPrPhpM3hlwYg/v2M7ZXcq58oqjeFQhIPg3R1
 bR+0L0YC3VkxTxnkyxMJ/fcsfzcUKhQmN0BBt782t1zA3vgYQ6rMH2WJg+a40051fjw4ZbRnVz
 v945xQfltxJMzay39L85GO6d
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 15 Aug 2022 11:16:54 -0700
IronPort-SDR: aMCYcoGRJhLXSl5+KhygIFIwayQNAUjGTBHVfyjQSO6NEoGxfE+dNTAElIn27xem6ecNbCtOBZ
 +jCQqfi+S6ITXzxuRVDPlDJDmwFJUGyjvQxyVnsXPIRMTHp6gy7UX6B+5a167ULr/Nthz81TnJ
 GbdMUN+/EDN43UEjXGIJC/cbkq5E/9Arn0HjRSRb0RCilvbNiMSWELVm+yYCiLviZ/JRTMtfAj
 NSXo/lTVfI84xNdNfnD7aWhLN/5jIkJyPhLfuTlG8thpOUrYqnSHsRiljkWfJHA+G6RHU8ZyZ6
 isE=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 15 Aug 2022 11:56:05 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
	by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4M63QX2Xnkz1Rws8
	for <linux-nvme@lists.infradead.org>; Mon, 15 Aug 2022 11:56:04 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
	reason="pass (just generated, assumed good)"
	header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
	opensource.wdc.com; h=content-transfer-encoding:content-type
	:in-reply-to:organization:from:references:to:content-language
	:subject:user-agent:mime-version:date:message-id; s=dkim; t=
	1660589763; x=1663181764; bh=V1iJTH7GEzKcPtxfy/9tnWQGVGcg7nbx15/
	9pWEV0IM=; b=cVDPi0Kzmzep2M8EqbqerFRmNFoCzwAWbOj49TmDAhX+LD4UCaY
	Cu/8kISW5TTQjQoXXq5GIOG6cDv01dng/UeI8zZzrI7QOlT+Bs+E/55TUL4BKYks
	TUVkhsU9i+QuCZCUKDcmfCnSl3gC4HeZNgOS0Ks4RuWeVYoZgZF46Gr5uJ/oElz0
	AT1tRvaEpFm3UCnJTto+JubxBpyWER7qwvosuu75e+ozyN8f8uUz7qqfGdvf3Xjp
	+UE2mjvKQtKTTuhao8LQoYETzhYUPGqQveWajxIvwokYLcuQxC4CcQAo1VLKbLwy
	X3ZpKiTUFbceakcDnLArV9shPg/mZTqGRBA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
	by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id JP8fTpWj-KiK for <linux-nvme@lists.infradead.org>;
	Mon, 15 Aug 2022 11:56:03 -0700 (PDT)
Received: from [10.11.46.122] (c02drav6md6t.sdcorp.global.sandisk.com [10.11.46.122])
	by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4M63QT4j3Gz1RtVk;
	Mon, 15 Aug 2022 11:56:01 -0700 (PDT)
Message-ID: <d4735d9e-31b6-0872-82a7-acbbd0cb5af5@opensource.wdc.com>
Date: Mon, 15 Aug 2022 11:56:01 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.12.0
Subject: Re: [PATCH v10 13/13] dm: add power-of-2 target for zoned devices
 with non power-of-2 zone sizes
Content-Language: en-US
To: Pankaj Raghav <p.raghav@samsung.com>, snitzer@kernel.org,
 axboe@kernel.dk, hch@lst.de, agk@redhat.com
Cc: linux-block@vger.kernel.org, Johannes.Thumshirn@wdc.com,
 bvanassche@acm.org, matias.bjorling@wdc.com, hare@suse.de,
 gost.dev@samsung.com, linux-nvme@lists.infradead.org, jaegeuk@kernel.org,
 pankydev8@gmail.com, linux-kernel@vger.kernel.org, dm-devel@redhat.com,
 Damien Le Moal <damien.lemoal@wdc.com>,
 Joel Granados <j.granados@samsung.com>
References: <20220811143043.126029-1-p.raghav@samsung.com>
 <CGME20220811143058eucas1p247291685ffff7a75186947fd30b5c13f@eucas1p2.samsung.com>
 <20220811143043.126029-14-p.raghav@samsung.com>
 <bb4ab1f2-7e16-15a7-58b1-d37f6f3822fd@opensource.wdc.com>
 <b98ab80d-1bc0-a378-d438-09ef8b375836@samsung.com>
From: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <b98ab80d-1bc0-a378-d438-09ef8b375836@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220815_115610_895275_EC1BC5AD 
X-CRM114-Status: GOOD (  30.78  )
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

On 2022/08/15 6:38, Pankaj Raghav wrote:
> Hi Damien,
> 
>>> +static int dm_po2z_map_read_emulated_area(struct dm_po2z_target *dmh,
>>> +					  struct bio *bio)
>>
>> This really should be called dm_po2z_handle_read() since it handles both cases
>> of read commands, with and without the accept partial. Note that this is
>> retesting the need for a split after that was already tested in dm_po2z_map()
>> with bio_across_emulated_zone_area(). So the code should be better organized to
>> avoid that repetition.
>>
>> You can simplify the code by having bio_across_emulated_zone_area() return 0 for
>> a bio that does not cross the zone capacity and return the number of sectors up
>> to the zone capacity from the bio start if there is a cross. That value can then
> The offset will also be zero if the BIO starts at the zone capacity and
> dm_po2z_map will assume that the bio did not cross the emulated zone boundary.
> 
>> be used to call dm_accept_partial_bio() directly in dm_po2z_map() for read
>> commands. That will make this function much simpler and essentially turn it into
>> dm_po2z_read_zeroes().
>>
>>> +{
> 
> What about something like this? We have one function:
> bio_in_emulated_zone_area() that checks if a BIO is partly or completely in the
> emulated zone area and also returns the offset from bio to the emulated zone
> boundary (zone capacity of the device).
> 
> /**
>  * bio_in_emulated_zone_area - check if bio is in the emulated zone area
>  * @dmh:	pozone target data
>  * @bio:	bio
>  * @offset:	bio offset to emulated zone boundary
>  *
>  * Check if a @bio is partly or completely in the emulated zone area. If the
>  * @bio is partly in the emulated zone area, @offset
>  * can be used to split the @bio across the emulated zone boundary. @offset
>  * will be negative if the @bio completely lies in the emulated area.
>  *  */
> static bool bio_in_emulated_zone_area(struct dm_po2z_target *dmh,
> 					  struct bio *bio, int *offset)
> {
> 	unsigned int zone_idx = po2_zone_no(dmh, bio->bi_iter.bi_sector);
> 	sector_t nr_sectors = bio->bi_iter.bi_size >> SECTOR_SHIFT;
> 	sector_t relative_sect_in_zone =

Nit: Could simply call this sector_offset.

> 		bio->bi_iter.bi_sector - (zone_idx << dmh->zone_size_po2_shift);
> 
> 	*offset = dmh->zone_size - relative_sect_in_zone;
> 
> 	return (relative_sect_in_zone + nr_sectors) > dmh->zone_size;

No need for the parenthesis.

> }
> 
> static int dm_po2z_read_zeroes(struct bio *bio)

Make that an inline.

> {
> 	zero_fill_bio(bio);
> 	bio_endio(bio);
> 	return DM_MAPIO_SUBMITTED;
> }
> 
> static int dm_po2z_remap_sector(struct dm_po2z_target *dmh, struct bio *bio)

Inline this one too.

> {
> 	bio->bi_iter.bi_sector =
> 		target_to_device_sect(dmh, bio->bi_iter.bi_sector);
> 	return DM_MAPIO_REMAPPED;
> }
> 
> static int dm_po2z_map(struct dm_target *ti, struct bio *bio)
> {
> 	struct dm_po2z_target *dmh = ti->private;
> 
> 	bio_set_dev(bio, dmh->dev->bdev);
> 	if (bio_sectors(bio) || op_is_zone_mgmt(bio_op(bio))) {
> 		int split_io_pos;

Blank line needed here.

> 		if (!bio_in_emulated_zone_area(dmh, bio, &split_io_pos)) {
> 			return dm_po2z_remap_sector(dmh, bio);
> 		}

No need for the curly brackets.

> 		/*
> 		 * Read operation on the emulated zone area (between zone capacity
> 		 * and zone size) will fill the bio with zeroes. Any other operation
> 		 * in the emulated area should return an error.
> 		 */
> 		if (bio_op(bio) == REQ_OP_READ) {
> 			if (split_io_pos > 0) {
> 				dm_accept_partial_bio(bio, split_io_pos);
> 				return dm_po2z_remap_sector(dmh, bio);
> 			}
> 			return dm_po2z_read_zeroes(bio);
> 		}
> 		return DM_MAPIO_KILL;
> 	}
> 	return DM_MAPIO_REMAPPED;
> }
> 
> Let me know what you think.

I think this is way better. But I would still reorganize this like this:

static int dm_po2z_map(struct dm_target *ti, struct bio *bio)
{
        struct dm_po2z_target *dmh = ti->private;
        int split_io_pos;

        bio_set_dev(bio, dmh->dev->bdev);

        if (op_is_zone_mgmt(bio_op(bio)))
                return dm_po2z_remap_sector(dmh, bio);

        if (!bio_sectors(bio))
                return DM_MAPIO_REMAPPED;

        /*
         * Read operation on the emulated zone area (between zone capacity
         * and zone size) will fill the bio with zeroes. Any other operation
         * in the emulated area should return an error.
         */
        if (!bio_in_emulated_zone_area(dmh, bio, &split_io_pos))
                return dm_po2z_remap_sector(dmh, bio);

        if (bio_op(bio) == REQ_OP_READ) {
                if (split_io_pos > 0) {
                        dm_accept_partial_bio(bio, split_io_pos);
                        return dm_po2z_remap_sector(dmh, bio);
                }
                return dm_po2z_read_zeroes(bio);
        }

        return DM_MAPIO_KILL;
}

I find the code easier to follow this way.



-- 
Damien Le Moal
Western Digital Research

