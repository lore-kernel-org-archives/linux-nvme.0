Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C142CC43334
	for <linux-nvme@archiver.kernel.org>; Wed, 15 Jun 2022 12:01:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=IZYws1koH2uwF4vW5DB4Yo2fHzJZC9Kdm5iHxUlpGrw=; b=VdDzuaFh/5vt+Wh1Am76BtCidF
	mK4Puo1LA+SKe3/MxDxaEYskzztYSiXD/VZTc6APAy60skSgSTOI/eoCxifJVf0K92y1ZS7E3P1+x
	pEPonLWlmtxalU6izgLoMpHIb5/AsSG24EdWHgxQ2ooYDeMk/MAGfnCPtRD12/z2ouBbWv0uzVBF2
	dyvsrE4eXkVbuakCrobNLIBj9lpnmKH6HY58cklVwTLJQbWcrGfELn2S5HDgVomqCFDWUNykR82t5
	4UtekZqZsX+/My4PRYlaYIsn0ETSrknUKzGOnyJDtP7nSSp2AYxldTnSOKMSClBjh1a5/bY75v1ct
	3A7tyBPw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o1Rhf-00ELIs-JV; Wed, 15 Jun 2022 12:00:55 +0000
Received: from esa6.hgst.iphmx.com ([216.71.154.45])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o1RbC-00EIWR-N0
	for linux-nvme@lists.infradead.org; Wed, 15 Jun 2022 11:54:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1655294055; x=1686830055;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=80Rp0zRg6bQP1I0DMDJ0rUfrw5zWcwXRBqMQRPk4k64=;
  b=lqS1qy3bHoQ73lw1KMVgy7paNW96eGBDxN9Y8J/vba+NGE2dhHSvDK4n
   3ykSodVC8339T4E9dkV34pO/enkXpl1WWQ1cg8PMrbcqyu51dbmM+EzwS
   U0QiL8acKTEZ7oIDm3K8VEggJRbW9+Um78oDo1gBDcRp7mfuFywT/r9af
   rQObCdH+Cf6+u+VZaA119N4lIQe/EYvLbcVhCVa91prC0xu2g757nv1sP
   rzFrIJFvAm5aOqRp1hAfU1al95WRUv7SBaCuBmizTqGJLn+baJ42/fsVU
   a6zhQTYmkDdKtcbg/3IBU1eyLfcbdACFoa/hFzfz1UoNTRid/bqvNpvKF
   Q==;
X-IronPort-AV: E=Sophos;i="5.91,302,1647273600"; 
   d="scan'208";a="203985811"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 15 Jun 2022 19:54:04 +0800
IronPort-SDR: Wd6LvvmFQct4S5eBUsBzoiII1snRe2jX8LMDOkIyicmQIuwCvHMlYyNaLUgbMN/gV9EkCk3Dqh
 55LMPY0Pq3VLyDlwP9a8JqPUNH3osjbOZ7+z9ht32np4FkAtjLYdz26IqdajvyDlA0eVQVQkRd
 1p+oBYH+PVIs+N+WV9kwq5w8xyDw5JrJ+a+XIgm78Gzith9R/bwksL3GrZyx0k9MGHXIG0DO7h
 zAg+NrPoZNB1nybB4E/cABuX33yiiqanU1A2B8OaxfkUfrFR/FW2fda8b/v8JJSLd6bpUxTh5l
 Rd0q6M3flzO9Z4zkfWier2uY
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 15 Jun 2022 04:12:27 -0700
IronPort-SDR: AmQpPhsQjua4tO3/Pzy++Ydi7XHPPHbT8DebqLBrQw2s6yJUTr2lEnWjdBzZwu4eqQUUfvDt+x
 /EG+cnFqofdfoC1bxPp4roBSbDIupxV6Di6Iunx3Z3lVBh1k3NVNE8bTKjUHxKkZ/OSom0AUDB
 7wHcDqskqBr7otEV6bTh8gyWt90GCA4XwlA55nJAyfb+VDjDAvYlldDY05Q/VylG36RMgUBp5x
 OOAD1yF5/VaIag9Qfa9Djf7eGOxcDX/uPbyEVW3SsLVJsbBXuAKzVbLqI9fptjKN5jB5ng5LGV
 c38=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 15 Jun 2022 04:54:03 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
	by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4LNNxk3XQsz1SVp6
	for <linux-nvme@lists.infradead.org>; Wed, 15 Jun 2022 04:54:02 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
	reason="pass (just generated, assumed good)"
	header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
	opensource.wdc.com; h=content-transfer-encoding:content-type
	:in-reply-to:organization:from:references:to:content-language
	:subject:user-agent:mime-version:date:message-id; s=dkim; t=
	1655294041; x=1657886042; bh=80Rp0zRg6bQP1I0DMDJ0rUfrw5zWcwXRBqM
	QRPk4k64=; b=oRC+W6gVdo0i6iv8oDtPTvW66O4PvnMzjzNAeHtj9DV+xtMFNoO
	vHU/zlPNO5e9MVo3nxodUtKSsjxQrFlLw4eYnsoNrEJLrQmRN0ZS6+uGj2rPGOyL
	hHhfknJsZ4PikEmI8829Ximb9pWPUXUEwCr8VtC4OPwbwdxwdVIVtjbmdxwdZavS
	eZmCHAuWD5VJr+GCTOgJXFgd3mBmIU37vlgCbuCG6/rfE8w0mWIvPpj3DnkcP6/d
	2aCfwPBnPwK5b07kvsPT/G5xfoXDGtEDICLCwfmr2pWIoycruimfd1gTf3r8s0KO
	GQpzoCSzZyF8xxeJym+xp39/nTJGnAizNQQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
	by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id BTgbTvWs0hpl for <linux-nvme@lists.infradead.org>;
	Wed, 15 Jun 2022 04:54:01 -0700 (PDT)
Received: from [10.225.163.82] (unknown [10.225.163.82])
	by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4LNNxf0Tpcz1Rvlc;
	Wed, 15 Jun 2022 04:53:57 -0700 (PDT)
Message-ID: <064551fa-4575-87cb-d9da-90a34309f634@opensource.wdc.com>
Date: Wed, 15 Jun 2022 20:53:56 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v7 10/13] dm-table: use bdev_is_zone_start helper in
 device_area_is_invalid()
Content-Language: en-US
To: Pankaj Raghav <p.raghav@samsung.com>, hch@lst.de, snitzer@redhat.com,
 axboe@kernel.dk
Cc: bvanassche@acm.org, linux-kernel@vger.kernel.org,
 jiangbo.365@bytedance.com, hare@suse.de, pankydev8@gmail.com,
 dm-devel@redhat.com, jonathan.derrick@linux.dev, gost.dev@samsung.com,
 dsterba@suse.com, jaegeuk@kernel.org, linux-nvme@lists.infradead.org,
 Johannes.Thumshirn@wdc.com, linux-block@vger.kernel.org,
 Luis Chamberlain <mcgrof@kernel.org>
References: <20220615101920.329421-1-p.raghav@samsung.com>
 <CGME20220615102000eucas1p27720aaa3c309327b2b9a33c5f840f498@eucas1p2.samsung.com>
 <20220615101920.329421-11-p.raghav@samsung.com>
From: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220615101920.329421-11-p.raghav@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220615_045414_860022_3FD01B83 
X-CRM114-Status: GOOD (  21.84  )
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
> Use bdev_is_zone_start() helper that uses generic calculation to check
> for zone alignment instead of using po2 based alignment check.
> 
> Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
> Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>
> ---
>  drivers/md/dm-table.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/md/dm-table.c b/drivers/md/dm-table.c
> index bd539afbf..b553cdb6d 100644
> --- a/drivers/md/dm-table.c
> +++ b/drivers/md/dm-table.c
> @@ -251,7 +251,7 @@ static int device_area_is_invalid(struct dm_target *ti, struct dm_dev *dev,
>  	if (bdev_is_zoned(bdev)) {
>  		unsigned int zone_sectors = bdev_zone_sectors(bdev);
>  
> -		if (start & (zone_sectors - 1)) {
> +		if (blk_queue_is_zone_start(bdev_get_queue(bdev), start)) {

This is wrong. And you are changing this to the correct test in the next
patch.

>  			DMWARN("%s: start=%llu not aligned to h/w zone size %u of %pg",
>  			       dm_device_name(ti->table->md),
>  			       (unsigned long long)start,
> @@ -268,7 +268,7 @@ static int device_area_is_invalid(struct dm_target *ti, struct dm_dev *dev,
>  		 * devices do not end up with a smaller zone in the middle of
>  		 * the sector range.
>  		 */
> -		if (len & (zone_sectors - 1)) {
> +		if (blk_queue_is_zone_start(bdev_get_queue(bdev), len)) {
>  			DMWARN("%s: len=%llu not aligned to h/w zone size %u of %pg",
>  			       dm_device_name(ti->table->md),
>  			       (unsigned long long)len,


-- 
Damien Le Moal
Western Digital Research

