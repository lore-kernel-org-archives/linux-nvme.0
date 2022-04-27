Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B558EC433FE
	for <linux-nvme@archiver.kernel.org>; Wed, 27 Apr 2022 23:39:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1AB1XQxDQK3ZvB6f0g1bRoPnbSC4y/Y6L7PxXS2Kx3I=; b=syOcLfyYTVu2PoSGsLef3uVvBn
	yQy4a3IwA0VMZE+D2+VXPXR3MbQbyaWhsHflVZA1ECDcwQGGs24AOVdhV0G+GwpKbSa+frZLt85Vc
	j7n3rE+qq3DtGWaAKvBDnWhR7LQrFthMQXlm8/KoKjV0mxYy+Gv8HyOVJsMe/JMpSwIz8puQ9ZPag
	tkr+XH0CCMKhMzTVl3Uy9H9SdvFB949rzgI8XYMmhvmJH3fA36EHmuSc5DViojhoV+m0RmADTJqWs
	73oCb6T72DUmkAI7BMqHFJPZDzL2Z6Rg+arXiokxaSJuz/wjRQAem/V+XtX+NwbXiquhIRQnOVYSo
	dFnsMVUA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1njrFy-003xrx-Tx; Wed, 27 Apr 2022 23:39:38 +0000
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1njrFv-003xq1-Fs
 for linux-nvme@lists.infradead.org; Wed, 27 Apr 2022 23:39:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1651102775; x=1682638775;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=MKuYv4XGK8HdnYkTj9llLnq6WFfSVxaVrJlMmCv+wiQ=;
 b=CTuUkQPqWF1SwXjcvk/8fJWMxJW2+NqL6kXoBMqGCa55EVTzcO1jtvKZ
 xjOsGKhGHXmyzRMgHE9lu4jDk6sndYVcA9WL1ReH8HazNmqjpZPi4fBIM
 Wtn9WzBaKbanppT9bLtD2z1vx9xs3o24mZKB0fNkkX7dY/7cBJrnz1IEy
 SPF+CIp1r/qW5jaERM+JBIRq7yWMG82QWBUwWhgVt9Tj/UU708A0RHlCC
 l/uGtcoqnIpywH/e3bnVlddjCbrRxUUMolQxPkz1hy0pZT9/Ykj3BOkSy
 JIZSQPm+tLSQJuJmiYae0guMqjcjvyT9Q8XxzbQ2iFkSY7y80DlqrTT4E A==;
X-IronPort-AV: E=Sophos;i="5.90,294,1643644800"; d="scan'208";a="303212734"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 28 Apr 2022 07:39:32 +0800
IronPort-SDR: /YKlnjEKQMY/OKCnsI9U+aDcviho0gjtcX1IpWXp4WdknIsnORIE3Kv25vRpT33rwd+veqeSzy
 vLHHEX95dTsC2fowpR+gfB4orH0zqfb7MZL72W+FhkgKE5Zzhne7YwzLuwpuG+JLrWdspJTgY9
 Y4LH3fd1i4fBKJeURaUMS/UrNsk5mzWcuAseIGNFO6MApvd5/jJ6S3/MjAx5zDaV2qSy07puyd
 d0uue2pWWzdRn3/IuniFMMerd55ZDRlKrvueFvVt6/pqSQb66rnsTglKhXfb9o+2nQj3pCofBZ
 pgeN/TfoKf5GkXyMSuu7m6qn
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 27 Apr 2022 16:10:25 -0700
IronPort-SDR: Kfk5KBq6YOhhKrLKI6ogpCySiWt4VCOABw5CF5j0pEdPbHaN185fz56Dd7OaPScpQ0dhU80gSI
 jNZ9j4YhyDzv+tnLKU6Lku3y72wED6088ws924dxi8BEWhY/dMRKI2zH7jMtFUk+fPeg2DsIRd
 5Ie2MnB/J7zUp+7RHVHJmi3NDGt4ky+olLkeLzxSg56CbuCAyPruOqPbMD/Xj4QTjaLBunu/pQ
 TSAdmk1LZyGmgsycmbiQ/olmvuT7oc4QB5l4HJuIFf6nwT3tE5J8ympsM+nOxnc637usRfG4ia
 DsU=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
 by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 27 Apr 2022 16:39:33 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
 by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4KpZwN0Wxlz1SVp3
 for <linux-nvme@lists.infradead.org>; Wed, 27 Apr 2022 16:39:32 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
 reason="pass (just generated, assumed good)"
 header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
 opensource.wdc.com; h=content-transfer-encoding:content-type
 :in-reply-to:organization:from:references:to:content-language
 :subject:user-agent:mime-version:date:message-id; s=dkim; t=
 1651102770; x=1653694771; bh=MKuYv4XGK8HdnYkTj9llLnq6WFfSVxaVrJl
 MmCv+wiQ=; b=F5aK313D/33i58L2HhyWZlmIYLxYFRau6pifLJL1hYJrhXiCZ8a
 QUlDThdd2S3jmMYxAnQGrk3uOInkmqWWXkmRW3ymLN1LfKOS5+bY79RzMlQL1w3p
 byr+W7KlfQmvdAdTOFjqy4Bvd6pxExnVEQWWyxoWm8P74hjVHX/Vm9LlwbazeVIZ
 wJ7tVTr0brCKfrteamJp89kRredPxEKv83eWrlHtbe+v5l92MU36wBYsIEFDv/Kv
 dXViO7aRNsJw2ghY9ipJqj+m8Fo9xYv4zTR8q40gyecTBz59xhum1EvNku7fAoNM
 dMuWLLgJcGyyRSZREN2s2w7PK2MFxbc5f1g==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
 by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new,
 port 10026)
 with ESMTP id A1vZTe5nZbLH for <linux-nvme@lists.infradead.org>;
 Wed, 27 Apr 2022 16:39:30 -0700 (PDT)
Received: from [10.225.163.27] (unknown [10.225.163.27])
 by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4KpZwF5hMDz1Rvlc;
 Wed, 27 Apr 2022 16:39:25 -0700 (PDT)
Message-ID: <bfc1ddc3-5db3-6879-b6ab-210a00b82c6b@opensource.wdc.com>
Date: Thu, 28 Apr 2022 08:39:24 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH 12/16] zonefs: allow non power of 2 zoned devices
Content-Language: en-US
To: Pankaj Raghav <p.raghav@samsung.com>, jaegeuk@kernel.org,
 axboe@kernel.dk, snitzer@kernel.org, hch@lst.de, mcgrof@kernel.org,
 naohiro.aota@wdc.com, sagi@grimberg.me, dsterba@suse.com,
 johannes.thumshirn@wdc.com
Cc: linux-kernel@vger.kernel.org, linux-btrfs@vger.kernel.org, clm@fb.com,
 gost.dev@samsung.com, chao@kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, josef@toxicpanda.com,
 jonathan.derrick@linux.dev, agk@redhat.com, kbusch@kernel.org,
 kch@nvidia.com, linux-nvme@lists.infradead.org, dm-devel@redhat.com,
 bvanassche@acm.org, jiangbo.365@bytedance.com,
 linux-fsdevel@vger.kernel.org, matias.bjorling@wdc.com,
 linux-block@vger.kernel.org
References: <20220427160255.300418-1-p.raghav@samsung.com>
 <CGME20220427160309eucas1p2f677c8db581616f994473f17c4a5bd44@eucas1p2.samsung.com>
 <20220427160255.300418-13-p.raghav@samsung.com>
From: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220427160255.300418-13-p.raghav@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220427_163935_644126_CAC57D84 
X-CRM114-Status: GOOD (  22.29  )
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

On 4/28/22 01:02, Pankaj Raghav wrote:
> The zone size shift variable is useful only if the zone sizes are known
> to be power of 2. Remove that variable and use generic helpers from
> block layer to calculate zone index in zonefs

Period missing at the end of the sentence.

What about zonefs-tools and its test suite ? Is everything still OK on
that front ? I suspect not...

> 
> Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>
> Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
> ---
>  fs/zonefs/super.c  | 6 ++----
>  fs/zonefs/zonefs.h | 1 -
>  2 files changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/zonefs/super.c b/fs/zonefs/super.c
> index 3614c7834007..5422be2ca570 100644
> --- a/fs/zonefs/super.c
> +++ b/fs/zonefs/super.c
> @@ -401,10 +401,9 @@ static void __zonefs_io_error(struct inode *inode, bool write)
>  {
>  	struct zonefs_inode_info *zi = ZONEFS_I(inode);
>  	struct super_block *sb = inode->i_sb;
> -	struct zonefs_sb_info *sbi = ZONEFS_SB(sb);
>  	unsigned int noio_flag;
>  	unsigned int nr_zones =
> -		zi->i_zone_size >> (sbi->s_zone_sectors_shift + SECTOR_SHIFT);
> +		bdev_zone_no(sb->s_bdev, zi->i_zone_size >> SECTOR_SHIFT);
>  	struct zonefs_ioerr_data err = {
>  		.inode = inode,
>  		.write = write,
> @@ -1300,7 +1299,7 @@ static void zonefs_init_file_inode(struct inode *inode, struct blk_zone *zone,
>  	struct zonefs_sb_info *sbi = ZONEFS_SB(sb);
>  	struct zonefs_inode_info *zi = ZONEFS_I(inode);
>  
> -	inode->i_ino = zone->start >> sbi->s_zone_sectors_shift;
> +	inode->i_ino = bdev_zone_no(sb->s_bdev, zone->start);
>  	inode->i_mode = S_IFREG | sbi->s_perm;
>  
>  	zi->i_ztype = type;
> @@ -1647,7 +1646,6 @@ static int zonefs_fill_super(struct super_block *sb, void *data, int silent)
>  	 * interface constraints.
>  	 */
>  	sb_set_blocksize(sb, bdev_zone_write_granularity(sb->s_bdev));
> -	sbi->s_zone_sectors_shift = ilog2(bdev_zone_sectors(sb->s_bdev));
>  	sbi->s_uid = GLOBAL_ROOT_UID;
>  	sbi->s_gid = GLOBAL_ROOT_GID;
>  	sbi->s_perm = 0640;
> diff --git a/fs/zonefs/zonefs.h b/fs/zonefs/zonefs.h
> index 7b147907c328..2d5ea3be3a8e 100644
> --- a/fs/zonefs/zonefs.h
> +++ b/fs/zonefs/zonefs.h
> @@ -175,7 +175,6 @@ struct zonefs_sb_info {
>  	kgid_t			s_gid;
>  	umode_t			s_perm;
>  	uuid_t			s_uuid;
> -	unsigned int		s_zone_sectors_shift;
>  
>  	unsigned int		s_nr_files[ZONEFS_ZTYPE_MAX];
>  


-- 
Damien Le Moal
Western Digital Research

