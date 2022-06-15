Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30861C433EF
	for <linux-nvme@archiver.kernel.org>; Wed, 15 Jun 2022 11:08:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8klfzzx15WktP7HA4FXgWN1D9+yAaOYQiUymj1ZMH3k=; b=0nmArSSIFxfzpmvr31tQMvVhTh
	NUk1umttqjDW1jRYilJPVtlU21RpDRlZqKOQmSgG6eKdzxFeKzBoQ5oXev5Ky+fqL7cRoJ45BhoiJ
	JB/giBM91RiilFj7s9wfN9b0zbeJcM4z9jW4vdxYaymyXHw/S1Yt8THQwtH2dXMH4tAYCrtruxLdy
	TQTY0q7TftUsqzyj6Qt1A2krEGNk1yzDOPfo30Ax3nogtXksS4Tcllz2HPR4Y/QT8z7Z36tTMFMFa
	YZiHDGTOFvoKJyXKVxP0BPDcjP361Vnt9VBszH5LCkZzW9QjM7uOxRUZhWnjSwZImdSyDe0sJeqd/
	YqaVOUvg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o1Qsk-00E57k-Co; Wed, 15 Jun 2022 11:08:18 +0000
Received: from esa3.hgst.iphmx.com ([216.71.153.141])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o1QmP-00E2iG-HB
	for linux-nvme@lists.infradead.org; Wed, 15 Jun 2022 11:01:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1655290905; x=1686826905;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=NX4SXzXOcEm6Wa/wGxya5bBYUkYI+YwahbjUCLImppA=;
  b=bAO6LfT10sATRYKQq3QR5iD1m3bAIX6ZQe1IqjZd2+a66zKK7bylyiSm
   Zy+vN+UEJIz9JGC438PF1aCl/WQNNb8CsFonz+syZwv8DNVAFXsCOjTNB
   cLsYsPSLYx2HwcigYi64qI7QicNGXyjlsVFfjzrQfMzZ0X7qjlOWcD5B5
   C5787qK8C3ymrMn33eQIZ7AvjgFBgVnTTsehZtjU7+NGJT+4vUw1U+Pvz
   A4e5v+RPTvkBY//loeT0Q/wXZQYDHt+4nltWibPVpiC7DIqth64543wSm
   eOxi0+BK/t/uqTLIoy8Ajw68olCDONrTSHJCRP/VpocgdRpEvk6X2UGA8
   w==;
X-IronPort-AV: E=Sophos;i="5.91,302,1647273600"; 
   d="scan'208";a="208069843"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 15 Jun 2022 19:01:42 +0800
IronPort-SDR: VbomT2ybkIU7guObMu3kkgKGu33O7qEb4d6H1v9fUY/IcFaBdK8VLJ3HFLQeI30dfMF8pKdrpV
 +r/O4iCSWqM9QubAygbL3GA2zLJOAyg8tAFF3R+w3o5GbYX4pHGPnBPhiHu61v4TXQnq4N3jNW
 m/wj+lFQttKLyv4Km8hJL0lcPlwda68MgmfiU4ZIkbWYhR7ZApdLDEBJR7WQpWUi9U6KxYu1ha
 6lyecPmYgZY2qlDxDVyeaIlhTQtcJQRPLXXQwN4r4KL6EEu372983tGxYKEQtmpVshmNIOJiME
 LX1CBzQCExyymQ5I8mcZFAHY
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 15 Jun 2022 03:24:33 -0700
IronPort-SDR: eergXgaEO/Eb2vTgjbkGpM5UB8PimHrlr/lT2O3C3ljlksjFopoPyOBTLzCr5un7ZWqRrWxwf+
 T6mrg/RQaOMGAr1IGBCb3sGlCbhsF2geSUeAF6pQqfVxskxA8gx7kADlpZPW6w2weZy41BRUSE
 FuWEVLmYpObUFWamKzcvfIXfJwGNmJODvDJDB358g9frkidwDn5YScc4hxEmLqbvU42kVvjAwD
 HNmnY4X6tyb8qOh6JA0MdeqL41JryhzVSLhkxIPRykHffELNhceneEZ+4MUyvJP2OVLwebY96H
 9p4=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 15 Jun 2022 04:01:42 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
	by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4LNMnK6vkCz1SVnx
	for <linux-nvme@lists.infradead.org>; Wed, 15 Jun 2022 04:01:41 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
	reason="pass (just generated, assumed good)"
	header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
	opensource.wdc.com; h=content-transfer-encoding:content-type
	:in-reply-to:organization:from:references:to:content-language
	:subject:user-agent:mime-version:date:message-id; s=dkim; t=
	1655290901; x=1657882902; bh=NX4SXzXOcEm6Wa/wGxya5bBYUkYI+Ywahbj
	UCLImppA=; b=T6O853cQSCc1Q4cmoll53tWhQlua3CRnPGD/JHULr+pEpWjg8h7
	0Xgdl1p1eKFllYxujnUn3MuRx05W5yg4eH94W33801uIFWBS8B9RszzJp2zORP9p
	HVZSGFXj5JVVwR10o2jqDeBJ5IvVQgbePcZUasIHK8IWm6QmBkd4ZdVkji1cMrkl
	ydZnuHIvZc3PW48cZj3PH/YYcej3sIF68hcr6jxIE1o8HHqMzHXNmreRtF4+ubtW
	VpLV2MkpVYtuubSm3kEQhuLMCm+BwvB4svyqyRNH9MUWiG5kh8MJfbVqki9g9R0O
	4fondWDP/36O5pyKLGIwjOL7J83eecHT3LA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
	by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id Z56d7-WQKMui for <linux-nvme@lists.infradead.org>;
	Wed, 15 Jun 2022 04:01:41 -0700 (PDT)
Received: from [10.225.163.82] (unknown [10.225.163.82])
	by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4LNMnG1fD0z1Rvlc;
	Wed, 15 Jun 2022 04:01:38 -0700 (PDT)
Message-ID: <f7b586a3-5370-f3b9-72dc-f9bea0b63f1f@opensource.wdc.com>
Date: Wed, 15 Jun 2022 20:01:36 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [dm-devel] [PATCH v7 12/13] dm: call dm_zone_endio after the
 target endio callback for zoned devices
Content-Language: en-US
To: Pankaj Raghav <p.raghav@samsung.com>, hch@lst.de, snitzer@redhat.com,
 axboe@kernel.dk
Cc: bvanassche@acm.org, pankydev8@gmail.com, gost.dev@samsung.com,
 jiangbo.365@bytedance.com, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
 dm-devel@redhat.com, jonathan.derrick@linux.dev, Johannes.Thumshirn@wdc.com,
 dsterba@suse.com, jaegeuk@kernel.org
References: <20220615101920.329421-1-p.raghav@samsung.com>
 <CGME20220615102007eucas1p1106f9520e2a86beb3792107dffd8071b@eucas1p1.samsung.com>
 <20220615101920.329421-13-p.raghav@samsung.com>
From: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220615101920.329421-13-p.raghav@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220615_040145_679628_B3EBBB4F 
X-CRM114-Status: GOOD (  25.01  )
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

On 6/15/22 19:19, Pankaj Raghav wrote:
> dm_zone_endio() updates the bi_sector of orig bio for zoned devices that
> uses either native append or append emulation and it is called before the
> endio of the target. But target endio can still update the clone bio
> after dm_zone_endio is called, thereby, the orig bio does not contain
> the updated information anymore. Call dm_zone_endio for zoned devices
> after calling the target's endio function
> 
> Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
> ---
> @Damien and @Hannes: I couldn't come up with a testcase that uses endio callback and
> zone append or append emulation for zoned devices to test for
> regression in this change. It would be great if you can suggest
> something. This change is required for the npo2 target as we update the
> clone bio sector in the endio callback function and the orig bio should
> be updated only after the endio callback for zone appends.

Running zonefs tests on top of dm-crypt will exercise DM zone append
emulation.

> 
>  drivers/md/dm.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/md/dm.c b/drivers/md/dm.c
> index 3f17fe1de..3a74e1038 100644
> --- a/drivers/md/dm.c
> +++ b/drivers/md/dm.c
> @@ -1025,10 +1025,6 @@ static void clone_endio(struct bio *bio)
>  			disable_write_zeroes(md);
>  	}
>  
> -	if (static_branch_unlikely(&zoned_enabled) &&
> -	    unlikely(blk_queue_is_zoned(bdev_get_queue(bio->bi_bdev))))
> -		dm_zone_endio(io, bio);
> -
>  	if (endio) {
>  		int r = endio(ti, bio, &error);
>  		switch (r) {
> @@ -1057,6 +1053,10 @@ static void clone_endio(struct bio *bio)
>  		}
>  	}
>  
> +	if (static_branch_unlikely(&zoned_enabled) &&
> +	    unlikely(blk_queue_is_zoned(bdev_get_queue(bio->bi_bdev))))

blk_queue_is_zoned(bdev_get_queue(bio->bi_bdev))) ->
bdev_is_zoned(bio->bi_bdev)

> +		dm_zone_endio(io, bio);
> +
>  	if (static_branch_unlikely(&swap_bios_enabled) &&
>  	    unlikely(swap_bios_limit(ti, bio)))
>  		up(&md->swap_bios_semaphore);


-- 
Damien Le Moal
Western Digital Research

