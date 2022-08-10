Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FFCCC19F2A
	for <linux-nvme@archiver.kernel.org>; Wed, 10 Aug 2022 17:12:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=un3hW8xPMCBEvyyGQmIo4SuxVRDdq0B1DzYi4GaOFYQ=; b=fr/tj4Q42H0aWCL55abu9RWv0Y
	4G51PU7YCrPtWgksbES4GKtyBK27C3GvEANfkA8wxwI3c0jAA7NH2qjNEtQuLBevnoY5xP0rye5a4
	hphqN++cN3pKqqYtWKts0cOarfcedogFzP58PXEilJzauSULCW+s9AfrsEcQrq6XSbwHlJZ2wLQut
	ogBLvJkb7vL/aN9RowDRnb16DEx9CUib1wPJ05C4ewO98ib1mnBhY7K8zcm/P2xs8sN7WiOR+Jzva
	lkxCLoaiTwU5mSpbCOkp56Cjt3Tc8JFP+oC7uWHdU/KJ3SCn9MZLf/L7N0F+9YABwlsu5SncJAouq
	AQRdc4GQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oLpFu-00DDlz-3e; Wed, 10 Aug 2022 17:12:30 +0000
Received: from esa6.hgst.iphmx.com ([216.71.154.45])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oLpFq-00DDj6-IT
	for linux-nvme@lists.infradead.org; Wed, 10 Aug 2022 17:12:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1660151546; x=1691687546;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=hlZ97m2efNWma/mlvKQ2Zr7hdfeg2GhMgsv7FANQHgc=;
  b=U77w2yYA8Il+yAz7ewMcAaksOdSicRCBpqrEka7N32icikxbDoQzYtox
   0jsWpgPkL+q14jZ1LcuFbCFz7lG8IzcH+vAZGe47kC8MBImSwF8LlaZO1
   hOSi9Sufcg8TxEV23rCcSA+goB6WEk9WM5oAUjiiFHvQL+0YFrzEFoPLi
   FlOomXwYb/qRIxikMqsezTzumw0PPqV8zavLmm0CkCyulPftm/jOLZjeV
   Vu69SwUC25IxNh5WrJm+5TGaZrIV7DIQOAAnXqi4OAXQOvQ684EAT42vN
   w1g//l99gp1FucpvKTFNSYyNFfETlJ700AyipeXDy79LFQQaLJYC96R7P
   Q==;
X-IronPort-AV: E=Sophos;i="5.93,227,1654531200"; 
   d="scan'208";a="208917764"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 11 Aug 2022 01:12:22 +0800
IronPort-SDR: TO7gZDc2FhZae+Fr9hPnfw7MucToQW0yJ1GJ1lroo3EnEBx4ar+U3hT2gzRfLsa7fVFZYb4zrC
 q0ravxu/K9QfTh6PzfUsjP/XgBEBGuEhXs5uY/IrDCq5Vv8dK8p1QZhLAbwm3lnpp3vc0yEW/e
 /tWatRqCO8ug9lS2uzu8pCbchMRE1xXVf6JNvyx0iaEYQ757okHGtaQf0RvXi8YdJ2tA8sQ03f
 qazjqESXfNIjoeA/aDUqyr5ZgBAwt4CxCOrMDSoPFojJSsn4gEdIWs/EV2W/S3yYjnuJimEx5G
 gScNVOjboqe70YoAfbDqlvoT
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 10 Aug 2022 09:33:16 -0700
IronPort-SDR: QPVaBkk5tEvialZ5rg4xjnfi2iaBvfWZWccVa9cWkL5XZxTPfm0ojV6tCHHEO8MOfGZj3UYe3u
 yCBoHA2xpmjiHdVZ+tnz8z072RyE+9GvDSH4qKdJ60ebRoxCDlSDL18v/oh8ZCo0psIe7CEr2U
 wYrrMbw05efYGzVEHuC/7LQ9DUQT5yucbKhTka04akLriN6nXfCnsm8yOZQn7CtIRp9XnQklhQ
 1ZKxZ2HmpC49NISzpE8tMNB+Ru9uRSIGBBL2VgKH0hnkxRSeDHX0ksq7K30k27Fi35jaaTv0qN
 KD8=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 10 Aug 2022 10:12:23 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
	by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4M2xM96DRbz1Rws0
	for <linux-nvme@lists.infradead.org>; Wed, 10 Aug 2022 10:12:21 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
	reason="pass (just generated, assumed good)"
	header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
	opensource.wdc.com; h=content-transfer-encoding:content-type
	:in-reply-to:organization:from:references:to:content-language
	:subject:user-agent:mime-version:date:message-id; s=dkim; t=
	1660151540; x=1662743541; bh=hlZ97m2efNWma/mlvKQ2Zr7hdfeg2GhMgsv
	7FANQHgc=; b=cKgvNAbZkPeUbd9WivRHefYc4O8AXg9KkT6hrG6tdWvCYYuJEPj
	XmLvMuUT6Drud/yLe+NUjCvYJT+qBsLHMqCQekj80wGa1chTTr0LiR93ZP/hjN7T
	avzYzRCZgOAl056SKSLbJg8pNAdfbLoAAw134AMDkwd0iUcxmEHkJmXpCawrfHVj
	qKYU/BTMSeu0mx/l3DWalmr7G/EvRNuNVeruWMttGSrOEpJUEDST/j44NpCTs2Fo
	SsQdj3DQIBTU5PaRpwT3xgzKy5rYg8npCViA9ZNr4cZOM+o4fVWzeCST8ZPGedNz
	sjM0oPKwLwUPAXGWGPQbGZsX0CpISDkVzKg==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
	by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id dW4jGfK2dCEG for <linux-nvme@lists.infradead.org>;
	Wed, 10 Aug 2022 10:12:20 -0700 (PDT)
Received: from [10.111.68.99] (c02drav6md6t.sdcorp.global.sandisk.com [10.111.68.99])
	by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4M2xM81DwYz1RtVk;
	Wed, 10 Aug 2022 10:12:20 -0700 (PDT)
Message-ID: <40e8f0b2-0bf1-3859-cb97-4da2d34eeab2@opensource.wdc.com>
Date: Wed, 10 Aug 2022 10:12:19 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.12.0
Subject: Re: [PATCH v9 10/13] dm-table: allow zoned devices with non
 power-of-2 zone sizes
Content-Language: en-US
To: Pankaj Raghav <p.raghav@samsung.com>, Johannes.Thumshirn@wdc.com,
 snitzer@kernel.org, axboe@kernel.dk, agk@redhat.com, hch@lst.de
Cc: dm-devel@redhat.com, matias.bjorling@wdc.com, gost.dev@samsung.com,
 linux-kernel@vger.kernel.org, pankydev8@gmail.com, jaegeuk@kernel.org,
 hare@suse.de, linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
 bvanassche@acm.org
References: <20220803094801.177490-1-p.raghav@samsung.com>
 <CGME20220803094813eucas1p2eab78901e97417ad52be1f8023db3d82@eucas1p2.samsung.com>
 <20220803094801.177490-11-p.raghav@samsung.com>
From: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220803094801.177490-11-p.raghav@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220810_101226_793688_85759F7D 
X-CRM114-Status: GOOD (  21.48  )
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

On 2022/08/03 2:47, Pankaj Raghav wrote:
> Allow dm to support zoned devices with non power-of-2(po2) zone sizes as
> the block layer now supports it.
> 
> Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>

Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>

> ---
>  drivers/md/dm-table.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/md/dm-table.c b/drivers/md/dm-table.c
> index 332f96b58252..31eb1d29d136 100644
> --- a/drivers/md/dm-table.c
> +++ b/drivers/md/dm-table.c
> @@ -250,7 +250,7 @@ static int device_area_is_invalid(struct dm_target *ti, struct dm_dev *dev,
>  	if (bdev_is_zoned(bdev)) {
>  		unsigned int zone_sectors = bdev_zone_sectors(bdev);
>  
> -		if (start & (zone_sectors - 1)) {
> +		if (!bdev_is_zone_start(bdev, start)) {
>  			DMWARN("%s: start=%llu not aligned to h/w zone size %u of %pg",
>  			       dm_device_name(ti->table->md),
>  			       (unsigned long long)start,
> @@ -267,7 +267,7 @@ static int device_area_is_invalid(struct dm_target *ti, struct dm_dev *dev,
>  		 * devices do not end up with a smaller zone in the middle of
>  		 * the sector range.
>  		 */
> -		if (len & (zone_sectors - 1)) {
> +		if (!bdev_is_zone_start(bdev, len)) {
>  			DMWARN("%s: len=%llu not aligned to h/w zone size %u of %pg",
>  			       dm_device_name(ti->table->md),
>  			       (unsigned long long)len,
> @@ -1642,8 +1642,7 @@ static int validate_hardware_zoned_model(struct dm_table *t,
>  		return -EINVAL;
>  	}
>  
> -	/* Check zone size validity and compatibility */
> -	if (!zone_sectors || !is_power_of_2(zone_sectors))
> +	if (!zone_sectors)
>  		return -EINVAL;
>  
>  	if (dm_table_any_dev_attr(t, device_not_matches_zone_sectors, &zone_sectors)) {


-- 
Damien Le Moal
Western Digital Research

