Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 232B1C4332F
	for <linux-nvme@archiver.kernel.org>; Mon, 18 Apr 2022 08:04:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=YBfzH21MuqUVICRz+C5X2gBl2f1DpzrRH5WHPJYj0C8=; b=jZY0pFxoGlL69/x4BNrEkc2fUk
	dp29qK1DscDmBf2MWPXNc/OReell84VwsIKc2hPVc3S/U7mySE77+itmInRP/Jk9Bwi6mbLSbgIw1
	RK9PLexcAOk2l3hmphTp3AYiz7GsIECw1cQmA9n6MpOk3KJp/gYNad0flRoajBm34m8HzJfFULe66
	ijYGkTOgk0HunTbTBaoAl7gvaahyO42da7tIDcBvpddw4SpDqX9dQ95spPucLF2cC4SSUrZWkTIPa
	8HlQN2vHDugfnfc7MqooJtIPU+XEIZNHdhQjvUop3K9aAGY2d6EMsOYne/wAxYkoIkW+AbBX46kQC
	MOLAF0vQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ngMMw-00Fvie-Bz; Mon, 18 Apr 2022 08:04:22 +0000
Received: from esa3.hgst.iphmx.com ([216.71.153.141])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1ngMMr-00FvgX-Rj
 for linux-nvme@lists.infradead.org; Mon, 18 Apr 2022 08:04:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1650269057; x=1681805057;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=rpofyDUALxK7dXMfprZ48DmzWqCt1/MYuoJj74ZUCIU=;
 b=ahcxuWVBNaWugD7cIQ3zZ5v9jz0ie2U8mzRIPPBi9lUyBDGFFW5i/+R6
 H9E/pCYf+u3wGm+9RLMTuYqv08lloCC2lsaMjRceDaVjlrvq26aC40qEI
 KEZAHf5qvS1Tm+cCJrlMD/x4TpGGzKbeAKOcdtXeDRT5hS6MYrZBTsAvX
 +iVlsrvpsnZyBZWQI2+kiyLHSLdJz/ZJYY03KIX+HDPIHdAo6rQPNvQok
 UHWZyUvnPwfjkKzuVuiC/0xe8HlaIpdH3ez5M7hVI5nYZZ1noLuQaFNYl
 baiRZ9lATYgZwoD5JdEhQcDqUPUGqgumP1pXlLf63uEHhBMhEl1Ngllgw Q==;
X-IronPort-AV: E=Sophos;i="5.90,269,1643644800"; d="scan'208";a="203014694"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 18 Apr 2022 16:04:17 +0800
IronPort-SDR: XK2BvbUuaRHqTSbUBIZL8ctpbdXQtSfOTu0Sc0vKnUbPi0ocdQ0gH9tC4IV0u9ABKcbBy4dMhd
 ZhrGBXodxy5RKwkS6/f4aAn5MSV9rKW6xWHL7aiLPYwiEONXg139xYOotL4Cda3/mXSzaz91V6
 MT4xbqwrIHFDvfEOwJPfZ7D0mfXffeQoBbq4ZX3xAbOXHvDZS+cDJejJ9J9GS3XYW2jXJSRh4Q
 g60BtgkoIlavafZ2kitJSuMEBEdvCqNBzjICrOACvP+saQzzZVw/jG2qsZdy88UY2OgmJEmuDW
 wsHT1OvS60DjbLEhuwSYhSSD
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 18 Apr 2022 00:35:24 -0700
IronPort-SDR: cFvRmXVkddHLpw5z1RK9gsef/L6Wuzkgh1Nt3i+dtgklP4X5EX2W6ADuXv1rHYV3F1sLaIBsv2
 Jp3rH5k21u/GPqR7ZQGaKaMN5fYW08OjhCwYkcAphQddyMYc/eEy9KE9bR8XR0DfrElMRSCWyg
 0em9rJknPiMcqTE9yTEgjgaOiqqIurD1Pomh4mEb5HZukwn/JbKHkYShxQ09PAs2Ipg8H/2A+x
 Bhv17OK+JGpKtDY0K4TTz+ICHlJpPkF/GQsRcF3u06YyypXXOY8L8AbyjUKVoS+9PGI/oKx0hQ
 Ho4=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
 by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 18 Apr 2022 01:04:18 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
 by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4KhfbP0smrz1Rvlx
 for <linux-nvme@lists.infradead.org>; Mon, 18 Apr 2022 01:04:17 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
 reason="pass (just generated, assumed good)"
 header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
 opensource.wdc.com; h=content-transfer-encoding:content-type
 :in-reply-to:organization:from:references:to:content-language
 :subject:user-agent:mime-version:date:message-id; s=dkim; t=
 1650269056; x=1652861057; bh=rpofyDUALxK7dXMfprZ48DmzWqCt1/MYuoJ
 j74ZUCIU=; b=Ipq2PwOMV6FMZnNHjzfOvCDO/eCvkHdBynAyRqHT0JYbL8aPJHg
 lk8/9NE8bxun2r7t0MS14013lawVGOzmf/X3f+8Ic4AvpnDkmhKMyefb2r7esi8c
 DPsaxfOdnQoK+7d4vOoATpt13x1/UJ8S/DPnmNBBwT32S9G+Wy2AQLrr3B49RYi+
 aLZinYUF9RJ+4lF/gqbzoQ5jz3HTqFiUmYZWkVzKfH36FzrmlF6gE6Ej5wqCOTd4
 pLzwGmboJ+p18OsmI93m/uKn1qd+a7S0N7bV75aqhYJOgfIIfT23fOLfPAhxUFLH
 ZzG5axr0DZzGRMD/V2vUJVApf7rh+IIODDg==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
 by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new,
 port 10026)
 with ESMTP id R2Tv4LCoM5Id for <linux-nvme@lists.infradead.org>;
 Mon, 18 Apr 2022 01:04:16 -0700 (PDT)
Received: from [10.225.163.14] (unknown [10.225.163.14])
 by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4KhfbJ6g7Wz1Rwrw;
 Mon, 18 Apr 2022 01:04:12 -0700 (PDT)
Message-ID: <18032025-f1aa-2daa-d012-8996590ada6a@opensource.wdc.com>
Date: Mon, 18 Apr 2022 17:04:11 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [dm-devel] [PATCH 08/11] loop: remove a spurious clear of
 discard_alignment
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc: Jan Hoeppner <hoeppner@linux.ibm.com>, "Michael S. Tsirkin"
 <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 linux-nvme@lists.infradead.org, virtualization@lists.linux-foundation.org,
 Song Liu <song@kernel.org>, dm-devel@redhat.com,
 "Md. Haris Iqbal" <haris.iqbal@ionos.com>, Jack Wang <jinpu.wang@ionos.com>,
 linux-s390@vger.kernel.org, Richard Weinberger <richard@nod.at>,
 xen-devel@lists.xenproject.org, linux-um@lists.infradead.org,
 Mike Snitzer <snitzer@kernel.org>, Josef Bacik <josef@toxicpanda.com>,
 nbd@other.debian.org, linux-block@vger.kernel.org,
 Stefan Haberland <sth@linux.ibm.com>, linux-raid@vger.kernel.org,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Johannes Berg <johannes@sipsolutions.net>,
 =?UTF-8?Q?Roger_Pau_Monn=c3=a9?= <roger.pau@citrix.com>
References: <20220418045314.360785-1-hch@lst.de>
 <20220418045314.360785-9-hch@lst.de>
From: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220418045314.360785-9-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220418_010417_935514_754103F0 
X-CRM114-Status: GOOD (  20.26  )
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

On 4/18/22 13:53, Christoph Hellwig wrote:
> The loop driver never sets a discard_alignment, so it also doens't need
> to clear it to zero.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  drivers/block/loop.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/block/loop.c b/drivers/block/loop.c
> index 976cf987b3920..61b642b966a08 100644
> --- a/drivers/block/loop.c
> +++ b/drivers/block/loop.c
> @@ -789,7 +789,6 @@ static void loop_config_discard(struct loop_device *lo)
>  		blk_queue_max_discard_sectors(q, 0);
>  		blk_queue_max_write_zeroes_sectors(q, 0);
>  	}
> -	q->limits.discard_alignment = 0;
>  }
>  
>  struct loop_worker {

Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>

-- 
Damien Le Moal
Western Digital Research

