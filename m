Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD902C5479D
	for <linux-nvme@archiver.kernel.org>; Fri,  6 Jan 2023 11:01:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=GhtfZCWtBMqpGbSWk/leOUAYCcm7XSE5xA6bG3z2JYQ=; b=Vmi7lsHqENcRb8ezljgOwZTBLM
	j9eK/40UH/rGWisnoEZAMWWsLUcEKPioJrmHQVbKY29L9UZlCY73EtyyOeoK97pejL08BbafyAsMX
	gvdbsnt8iv2TEK2FqXX9AEI4SuDi8/6ZnzW878DnKOHiM/5FOTl5Xjy6mJcmySbNEsCByK9+vCD0r
	phGmPendttvPHgTYHTJRIpoVj4cPnvg8xZ8apOWk1i+cYKnK3ht7YRIo5m2lBl6QYFATUx2o77G9z
	tsO8OfyO8d3cX/B+5z7ybgfCb5etc+ZVKQxjBHhAO1YXqsTbVEDsVikKY37YFsy//pJXTEzz21Yct
	Fxad2ixA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pDkTM-007cEe-Vg; Fri, 06 Jan 2023 11:01:17 +0000
Received: from esa6.hgst.iphmx.com ([216.71.154.45])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pDkTJ-007cCA-HR
	for linux-nvme@lists.infradead.org; Fri, 06 Jan 2023 11:01:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1673002873; x=1704538873;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ydpjo/PG9rszJfVuf0/cnxIuUewKQhm2ZsznqLALiPE=;
  b=gmA1zTvYyCfXacF54EJjqlFj3RBdcr+XF6HlgfNJxXXp/ckXmY4mE2rg
   rSnwB87/vA/u6SHK2uNsLfmLWlBIzWAkxAtKbUVoa645UEbK1tEoQ9cN0
   DI3kss5xUWAIhlIALDwRF60CwS7qWxJ5p8IcJXedeo3WJO8InRBljYFxd
   43EUloJfFVJvXqJXdK/TVUiuiSB3jjJfiS5boGNsplJwJtThoFlBPyTEw
   O2CCC+4l9VYhG0O2V/mROaNKzJ9K4g7SJAvo/h/bhfYbvKTRkRnEUfA5H
   CLJ7NPCCpnPb1hiozJ0/WkbDh9QwYAaHyehbyW+LTsHBj3J0mbyYTce0B
   g==;
X-IronPort-AV: E=Sophos;i="5.96,305,1665417600"; 
   d="scan'208";a="220280581"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 06 Jan 2023 19:01:10 +0800
IronPort-SDR: Lnu1A+MO463JX2z+Sn0R7Z5G+A8qWckKaQZYlQLaCLizG/yn6LreQSWbIfbQh/yhGCODXKCl2R
 Uc2GaovxhWAwhTucqqM6+YdZse/gU9SLWUJCJwtYHj8AiXsXSQeEZC+fMh6Wk10t4Ts7wBJmkw
 qsvzNdjXmh5IkAE14NslwRgavGpQxaI1M9ypl68cSUr1PykFB7hOUnpcRriM90jrnN8URV8/ce
 xWwV3BDkZ53ntUhpOp/ci5zeDtxhQHFg5rBI85BCRFLB7HtrChO9cWGgKmLZnNxCKDO9XFKv99
 Njo=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 06 Jan 2023 02:19:05 -0800
IronPort-SDR: RhyQBnj6KEE/MHbSA4VTb1XXaAz+EunYTHR2+V/f72vHrqetrqxPwl39XifMBBMx481V1YXI49
 aDSB/YQxY2GH0I4NBVj3aPQYNwXBLYe7v9sgosfuoZMePNK9balBVdONt3fqyTeBmsdfq47Nht
 FSGE9im6puM/LJAYMThUjtnFIAIafUlS2+V3eIoqNDFjC1NhQ4jAfncuMP5x/ungVDxq8rW10Y
 t5sDS6kgeuMddKtxwTl/76L5gliwhm/FFmqAOzGi3SDBb0aCU76hTVbQW67c4zTdyiBfe60yRB
 kGY=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 06 Jan 2023 03:01:12 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
	by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4NpL4633Prz1RwvL
	for <linux-nvme@lists.infradead.org>; Fri,  6 Jan 2023 03:01:10 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
	reason="pass (just generated, assumed good)"
	header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
	opensource.wdc.com; h=content-transfer-encoding:content-type
	:in-reply-to:organization:from:references:to:content-language
	:subject:user-agent:mime-version:date:message-id; s=dkim; t=
	1673002869; x=1675594870; bh=ydpjo/PG9rszJfVuf0/cnxIuUewKQhm2Zsz
	nqLALiPE=; b=aE9aLrbAxdk6xM3YjipPdKlKR+YBrKVCr7tYG5UMv/LfblT78Jz
	zZHTm9i+K1jvg4YO+cnrNRbVEkzQE+S6XyHCkv/8P6gt4mxRqqOjFxqi4qVbpM2k
	Cm8m2wgwu2SWy+zEQiSotsjNMFsjRXmbWLiRxY8xtgN03ctFd81o7d0F/CEuwfJG
	80b/4o0zu30Ut0aQ0x+fqiwGii+AZi9H1iGjhraY9fedjAkzGoK/wfXhYOLeL2KT
	EheQMkJXTKvT0Y/xJsz4/T5jsgFhuc80MyVBvlugUgUFdyKOSR8UjewAplW3FZyJ
	53LzhVSbb7FzBzKDvirJAcdxtEV9WO/SRwg==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
	by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 0bcL3LQ5LUl8 for <linux-nvme@lists.infradead.org>;
	Fri,  6 Jan 2023 03:01:09 -0800 (PST)
Received: from [10.149.53.254] (washi.fujisawa.hgst.com [10.149.53.254])
	by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4NpL436MGRz1RvTp;
	Fri,  6 Jan 2023 03:01:07 -0800 (PST)
Message-ID: <22e12d95-d00d-270d-8119-8587672976a7@opensource.wdc.com>
Date: Fri, 6 Jan 2023 20:01:06 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH 1/7] block: remove superfluous check for request queue in
 bdev_is_zoned
Content-Language: en-US
To: Pankaj Raghav <p.raghav@samsung.com>, axboe@kernel.dk
Cc: kernel@pankajraghav.com, linux-kernel@vger.kernel.org, hare@suse.de,
 bvanassche@acm.org, snitzer@kernel.org, dm-devel@redhat.com,
 linux-nvme@lists.infradead.org, hch@lst.de, linux-block@vger.kernel.org,
 gost.dev@samsung.com
References: <20230106083317.93938-1-p.raghav@samsung.com>
 <CGME20230106083319eucas1p1e58f4ab0d3ff59a328a2da2922d76038@eucas1p1.samsung.com>
 <20230106083317.93938-2-p.raghav@samsung.com>
From: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20230106083317.93938-2-p.raghav@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230106_030113_646589_C8E737C7 
X-CRM114-Status: GOOD (  19.47  )
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

On 1/6/23 17:33, Pankaj Raghav wrote:
> Remove the superfluous request queue check in bdev_is_zoned() as the
> bdev_get_queue can never return NULL.
> 
> Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
> ---
>  include/linux/blkdev.h | 7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)
> 
> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> index 43d4e073b111..0e40b014c40b 100644
> --- a/include/linux/blkdev.h
> +++ b/include/linux/blkdev.h
> @@ -1283,12 +1283,7 @@ static inline enum blk_zoned_model bdev_zoned_model(struct block_device *bdev)
>  
>  static inline bool bdev_is_zoned(struct block_device *bdev)
>  {
> -	struct request_queue *q = bdev_get_queue(bdev);
> -
> -	if (q)
> -		return blk_queue_is_zoned(q);
> -
> -	return false;
> +	return blk_queue_is_zoned(bdev_get_queue(bdev));
>  }
>  
>  static inline bool bdev_op_is_zoned_write(struct block_device *bdev,

Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>

-- 
Damien Le Moal
Western Digital Research


