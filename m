Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EE30C433F5
	for <linux-nvme@archiver.kernel.org>; Wed, 25 May 2022 23:14:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=DXGNV5WrPP+NpjyuNzZgbt4oMn3bem4m88JTE32cFsQ=; b=U7rT+AIQqWzuyj+yJzXrks+BX9
	z4ix16OIXjgceA8UBCV2nSxoGCQoAq3BbgCxGbiQOBD3OR4BB97HgGT9CdXftzyasIQ4tDHT5ygF8
	oHpdzBJA7vr4VoRhgV5PVHieFHatsmkl4DBTfEw8zHtCHZ5fPndyxscjdJoJwvOojYIIjJdnGUpv+
	8kEnJ7PUmXxdepEvo1IMXBCST8B8dy1kgfNrXu1LFN41gmgWf1l17BpuYBWUyrcJJPWGF8d391NKF
	sC1fwvqwldZsemugLJorhGknQ7S8jQ2GBjpeU12gThVO9PmKXWrVadv3tY7QhWOpEptLHRLAPhpCG
	LFA8mKWw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nu0CW-00Cwe6-60; Wed, 25 May 2022 23:14:00 +0000
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nu0CT-00CwdM-1b
	for linux-nvme@lists.infradead.org; Wed, 25 May 2022 23:13:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1653520436; x=1685056436;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=eam838EaJRwK9zb6IDgNxPhRl2ur9Z3r3Bih8oVIUd8=;
  b=MKQQQjmuQ1YxonhcBUl9EYDnwYP7cMttqdhbo5IugjCUwU1pTQKw5W0L
   fjdzKplRJnWP6mrcRkGiyR8jK7+un9OU7427t2Xt4OC+g/NhpjaAlk0rN
   tWwGy4wYR4VHUu1gBcGattDcOwkZMyjutQ2K7Uhj2C4W3IT/7rZne6rWR
   lzfuhCE5pdoz0/OGVvJUAqj7ocq6O5FL3NTLgfCI5Lt6j02/wXpvLCbN3
   D0Y0ouDUgw3Jglo+bFGaVnivYgk8NR2GqtTJWJaykY7+rXlVYDKZg8iJN
   Vq+PR9VoFcRQh3x2jNwX6pbZGZpxojsnXZnODgT7NsqthGQRFizvAjQCb
   Q==;
X-IronPort-AV: E=Sophos;i="5.91,252,1647273600"; 
   d="scan'208";a="305680426"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 26 May 2022 07:13:54 +0800
IronPort-SDR: a8ORhyGK43ATrRmOAPEc3qX5chkzF7Vhg24KkE9G+zJXe9tR+/Z9qmAmv4B28HbKu9GymkR5pb
 PA99bvvgK0F2Zm0CM+a3Cxig/qYDFjs1sPp5KWK8hyxKqNJr+OfWgTJPVRjNzEsxzC1Upeqrmw
 YkhUwRFqvj1stkWP7YGrfVY/Yongr7SkJy5FChw/wS4TTJU6mrRo2mLE82KuKxySnD6ImwUqL7
 2xwqISyZVngCyAFPVwtPG7OoiquJ1ZxCSElWwjqSB9JHHqsfXptTSInj8amQxqLbq2S9EljKcP
 EOGrdUaQ1HIu99kX9HsdF2HO
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 25 May 2022 15:37:49 -0700
IronPort-SDR: /ccSZouWCr5/jKT1J1v1739mHp44L49Hh3Cq4YMfl0ECwA8S99MAs4daVmhr2t2fQAMDYPousQ
 IIt3QmkNyu0sK5g8JE6pZjC/MrftxtVR+J2U1tPMi/rVL1hOXmpyNJp3eLpNaAKvB65s5mqGrp
 v+PeRUeq78A4ymA+vzk9ow0KTsFwgwbui5+soqABhHwtWYp/oapIbJvsQ6ggWHmD9Dv64okcvx
 9glHtqhgYHCszS0wB+K433Eg7lO2R116BFhnUf9eEU3xepx22PvnmG4GfLoRGL5xM7XsHiyU5a
 OsA=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 25 May 2022 16:13:55 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
	by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4L7n1t1mFDz1SVp7
	for <linux-nvme@lists.infradead.org>; Wed, 25 May 2022 16:13:54 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
	reason="pass (just generated, assumed good)"
	header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
	opensource.wdc.com; h=content-transfer-encoding:content-type
	:in-reply-to:organization:from:references:to:content-language
	:subject:user-agent:mime-version:date:message-id; s=dkim; t=
	1653520433; x=1656112434; bh=eam838EaJRwK9zb6IDgNxPhRl2ur9Z3r3Bi
	h8oVIUd8=; b=MH3qrczSSEt7xHyvThV5z8FeiBgRXDKry4Drw1TqJl3BSqFG+Zx
	P3ngOqNGwroS4Du2LnDA4L8o4amixasMJVutO8QpAUjXIM/4x9Ocltnh/9EmK7Fb
	8/0eeirBarsL7a7fDgu/SnOk2YgG57P3/7jKxAghclbupCMh6CXjGa8w8T3qtnLQ
	L5rSs0pkk4yLIH/N/O4nv9Ornln0aQeISTYiFTDyocO5u6+MVk2poxtSiyMNMlov
	n9ZXVtGjtIMkAAy7ybgnGLHnWLT2k6oJT8wqlY68XA6O18AnDV4UBuQSwR1TPCCP
	f794kjEXcUXAuoSWcPqm41miavrLzgB1XdA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
	by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 1OaBXuynt9pz for <linux-nvme@lists.infradead.org>;
	Wed, 25 May 2022 16:13:53 -0700 (PDT)
Received: from [10.225.163.54] (unknown [10.225.163.54])
	by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4L7n1p4sHZz1Rvlc;
	Wed, 25 May 2022 16:13:50 -0700 (PDT)
Message-ID: <9703ca4c-33cf-cb3a-b46b-6b0e5537cfd6@opensource.wdc.com>
Date: Thu, 26 May 2022 08:13:49 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v6 8/8] dm: ensure only power of 2 zone sizes are allowed
Content-Language: en-US
To: Pankaj Raghav <p.raghav@samsung.com>, axboe@kernel.dk,
 snitzer@redhat.com, Johannes.Thumshirn@wdc.com, hch@lst.de, hare@suse.de
Cc: dsterba@suse.com, dm-devel@redhat.com, jiangbo.365@bytedance.com,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, jaegeuk@kernel.org, gost.dev@samsung.com
References: <20220525154957.393656-1-p.raghav@samsung.com>
 <CGME20220525155008eucas1p2c843cc9098f2920e961f80ffaf535789@eucas1p2.samsung.com>
 <20220525154957.393656-9-p.raghav@samsung.com>
From: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220525154957.393656-9-p.raghav@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220525_161357_228938_D5382923 
X-CRM114-Status: GOOD (  23.70  )
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

On 5/26/22 00:49, Pankaj Raghav wrote:
> Ensure that only power of 2 zoned devices are enabled for dm targets that
> supports zoned devices. This constraint can be relaxed once non power of
> 2 zone size support is added to the DM layer.
> 
> Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
> ---
>  drivers/md/dm-table.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/md/dm-table.c b/drivers/md/dm-table.c
> index 03541cfc2317..2a8af70d1d4a 100644
> --- a/drivers/md/dm-table.c
> +++ b/drivers/md/dm-table.c
> @@ -251,6 +251,12 @@ static int device_area_is_invalid(struct dm_target *ti, struct dm_dev *dev,
>  	if (bdev_is_zoned(bdev)) {
>  		unsigned int zone_sectors = bdev_zone_sectors(bdev);
>  
> +		if (!is_power_of_2(zone_sectors)) {
> +			DMWARN("%s: %pg only power of two zone size supported",
> +			       dm_device_name(ti->table->md), bdev);
> +			return 1;
> +		}
> +
>  		if (start & (zone_sectors - 1)) {
>  			DMWARN("%s: start=%llu not aligned to h/w zone size %u of %pg",
>  			       dm_device_name(ti->table->md),

I thought the agreed upon idea is be to add a dm-linear like target to
emulate power of 2 zone size so that we can keep btrfs and f2fs running on
this new class of device. So why this patch ?

The entire series as is will fragment zoned block device support, which is
not a good thing at all. Without the new dm target, none of the current
kernel supported zone stuff will work.

The zonefs patch is also gone from the series. Why ? As is, zonefs will
break if it is passed a non power of 2 zone size drive.

-- 
Damien Le Moal
Western Digital Research

