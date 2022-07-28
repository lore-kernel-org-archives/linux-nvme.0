Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5FB7C04A68
	for <linux-nvme@archiver.kernel.org>; Thu, 28 Jul 2022 03:26:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Y/0IMmmduFxsnmkxcVxmadtlFmfqo1HACwZC12E+dsg=; b=hKrGqtR8QapWZNU66K5VBkyHf1
	INlpfzRUs6JK0+ZMxMoBo6S1c5E9jpmkmHsnCC6RvLKUZFPSh9/CIuYUoarqhE+MAap2lxGkB7Fcu
	tX71SOFPpk9D/S5m3nRNHc9imOUWaPjaBMEHfDxcw3bJH6l0YQTjrDWltKGA/eeya73d44lbN2Fmd
	6OSN7jB5Nh136ga7ShE5jbLD7WAlVPA7s87vA4pkry+QvnIq/GKhDFsSWu6PF86xsY8aWnXfI5upQ
	zWZrXvmEfsbbrhcxRTXZgfbqGLt/Yz/7PRssG59WzBUf6HExSuQGct9zeGh03BAuF4g1Nu945usBh
	1ekHUREg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oGuA0-003W30-2T; Thu, 28 Jul 2022 03:26:04 +0000
Received: from esa3.hgst.iphmx.com ([216.71.153.141])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oGu9w-003W1B-Nz
	for linux-nvme@lists.infradead.org; Thu, 28 Jul 2022 03:26:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1658978759; x=1690514759;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=6B0J7rPhKOuMBD6783EPbpQrY4+wGpoPU7fiO6rW+lQ=;
  b=iwm9vXEty+DlDY6Cd3gnRjOKxGGk6T8DpO4TAaORwNwkGoD/ob+NxreA
   bElPfnygxwoPt7gKQMShEJNfGdHlUCsJtqolrOjTJNqkr8tlARPkXOXkc
   OSc2pBeODF+J0X56eMCLnhnb5waVNMtVaWuOKBLlamv88re97ZgCo9xsu
   MVlqccAHdqWN5Yk81hNHbwdwROXPu8fyxy9R+rrrloSrYvgEPHN24dgZa
   iMDv6tv1KT0qvkosvDmyRWfL+RuIYd2Sq/ScB3Etx7ebdfjksc0FJ5LfH
   jLKGFJkM5WYTtYV9Ouoo1HJSvC0bEGtXHKkn9ctWEk/zCnhc94NKkihTC
   w==;
X-IronPort-AV: E=Sophos;i="5.93,196,1654531200"; 
   d="scan'208";a="212067810"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 28 Jul 2022 11:25:59 +0800
IronPort-SDR: mhIgoXPSL0DMHY32za3ynLsy7yuVWaaoEQ+KgI7wBh+6HaSKdLm3zxWVMbRpZM0q20OeGLviaQ
 WcB3Zjvh4Egni+f6eN4QtoEuzS4QneeHYOXs9HHHCt362D/1dLouezaGEPqblC73At3sYVJ333
 WREV74rvXsThcHQ7jTjKkPvqwEuVM9jPt5ro/P24wF50bGIIGwdhlPXQ6F989slLP6sT2s6Egr
 xw98ZY64jqKDAbPCtrWEzem1VV4fSKB00D1Pn/U2A1Wa+82Oo3QBrH9jvY34PaePsyUEo2dE+Y
 UXc4++DSNSyi9G6D1q8S6L5e
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 27 Jul 2022 19:42:08 -0700
IronPort-SDR: 7LQzyl9QFoealV0uQabYwwpaoRLZPvc4q15XI6vdkQfElsVNv2q+Tj5e0vOF4tWRRghZz7j8bH
 cZUSv3CnZGObLUV4ll2gU55MCvAfDCXsprTaskfnAnBcmUUOeW2nrP7tl6XNqfa9SBzoXAxphU
 D4DvaOmcExEbnv+1yv/wwIHm3G/kisulXSHYone4M7GeIaVamxVhv47xzgy0/ZFF21+YzGLKam
 rARUfMSOF5P85qEwEuPGASmV+RrdeODjdu1HCrPyDl6GKl48XeMeuCWyU+IQ+bP8OA/DyXnbqH
 4DQ=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 27 Jul 2022 20:26:00 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
	by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4Ltbdg44Gsz1Rws4
	for <linux-nvme@lists.infradead.org>; Wed, 27 Jul 2022 20:25:59 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
	reason="pass (just generated, assumed good)"
	header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
	opensource.wdc.com; h=content-transfer-encoding:content-type
	:in-reply-to:organization:from:references:to:content-language
	:subject:user-agent:mime-version:date:message-id; s=dkim; t=
	1658978758; x=1661570759; bh=6B0J7rPhKOuMBD6783EPbpQrY4+wGpoPU7f
	iO6rW+lQ=; b=O3F0JLsKAAFttSPzysRoIMXHUwn4u4OZgC+3BCxcyjZy8KRr6Gs
	fzxhp1XdB7+DpH1UFGhLmGs6miIzdVpywmElhdqBXKj31nE4EarZP8ZlftO63wdj
	fX5a/agnYxZiIlDR7MjDXuFDzaug3gFboPTwmlhxpRHy2dzwmdcGXteq0k2N7rCS
	IFNacezDDvtj68K74FF3v7otR6Na1BHvS7bgT54vhsEq45VFfQ6L4KIMfUU0TVj3
	Jp1W6APGE2mtLiEChk/IkxjFExuRVdbV2CjHzDogUr9iD4GZvzQIRi5dN+G5Ht2w
	H6SoWH/DjZuP6ZbzQX2rnw6VRgEBE4bNgwg==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
	by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id DQTW4OHCFnIR for <linux-nvme@lists.infradead.org>;
	Wed, 27 Jul 2022 20:25:58 -0700 (PDT)
Received: from [10.225.163.14] (unknown [10.225.163.14])
	by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4Ltbdb6fMYz1RtVk;
	Wed, 27 Jul 2022 20:25:55 -0700 (PDT)
Message-ID: <2b1ab4ac-a355-dfb4-6ca4-82fe36a38433@opensource.wdc.com>
Date: Thu, 28 Jul 2022 12:25:54 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v8 10/11] dm: call dm_zone_endio after the target endio
 callback for zoned devices
Content-Language: en-US
To: Pankaj Raghav <p.raghav@samsung.com>, hch@lst.de, axboe@kernel.dk,
 snitzer@kernel.org, Johannes.Thumshirn@wdc.com
Cc: matias.bjorling@wdc.com, gost.dev@samsung.com,
 linux-kernel@vger.kernel.org, hare@suse.de, linux-block@vger.kernel.org,
 pankydev8@gmail.com, bvanassche@acm.org, jaegeuk@kernel.org,
 dm-devel@redhat.com, linux-nvme@lists.infradead.org
References: <20220727162245.209794-1-p.raghav@samsung.com>
 <CGME20220727162256eucas1p284a15532173cce3eca46eee0cee3acdd@eucas1p2.samsung.com>
 <20220727162245.209794-11-p.raghav@samsung.com>
From: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220727162245.209794-11-p.raghav@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220727_202600_850497_E91FBF58 
X-CRM114-Status: GOOD (  23.16  )
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

On 7/28/22 01:22, Pankaj Raghav wrote:
> dm_zone_endio() updates the bi_sector of orig bio for zoned devices that
> uses either native append or append emulation and it is called before the
> endio of the target. But target endio can still update the clone bio
> after dm_zone_endio is called, thereby, the orig bio does not contain
> the updated information anymore. Call dm_zone_endio for zoned devices
> after calling the target's endio function
> 
> Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
> ---
>  drivers/md/dm.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/md/dm.c b/drivers/md/dm.c
> index 03ac6143b8aa..bc410ee04004 100644
> --- a/drivers/md/dm.c
> +++ b/drivers/md/dm.c
> @@ -1123,10 +1123,6 @@ static void clone_endio(struct bio *bio)
>  			disable_write_zeroes(md);
>  	}
>  
> -	if (static_branch_unlikely(&zoned_enabled) &&
> -	    unlikely(bdev_is_zoned(bio->bi_bdev)))
> -		dm_zone_endio(io, bio);
> -
>  	if (endio) {
>  		int r = endio(ti, bio, &error);
>  		switch (r) {
> @@ -1155,6 +1151,10 @@ static void clone_endio(struct bio *bio)
>  		}
>  	}
>  
> +	if (static_branch_unlikely(&zoned_enabled) &&
> +	    unlikely(bdev_is_zoned(bio->bi_bdev)))
> +		dm_zone_endio(io, bio);
> +
>  	if (static_branch_unlikely(&swap_bios_enabled) &&
>  	    unlikely(swap_bios_limit(ti, bio)))
>  		up(&md->swap_bios_semaphore);

This patch seems completely unrelated to the series topic. Is that a bug
fix ? How do you trigger it ? Our tests do not show any issues here...
If this triggers only with non power of 2 zone size devices, then this
should be squashed in patch 8. And patch 9 could also be squashed with
patch 8 too.

-- 
Damien Le Moal
Western Digital Research

