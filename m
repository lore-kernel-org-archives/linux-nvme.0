Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A9C3C433F5
	for <linux-nvme@archiver.kernel.org>; Mon, 18 Apr 2022 08:03:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=TEoABp+mkiRX8VP53cw250WbTRmv6IDPLLTwtBFB1ak=; b=rGUxLPnc8bTkdlec/fNfsIu8ER
	CkDNHSpNdvABf6C5dsfq0RKspjypIjoj6BQb66hirjHEKL1mncLbXvuWqwS2UAOZM6dVHmxwAxaMq
	dIsOwdxuFlr8w6RfufinS+NOQBI6xVWOiucLJy3hdz97SYp4DI+iYWEPN6ZYIxIfiuCAg8Bu0/0ns
	QMo1NYUGy+clXUPRfCCt86brPeyyohcydMhHuGc+x9q1uggM5SnVr7CbVsZ6qHgErkCcqNKGUhqkZ
	foZg5dNGzwypWP6VnCxU34elCkV3HKZ+BjUEEm0F7AXsWg6qCKUtES6T5/lQyYLCIWZBkZA0jhocC
	wju2Rs9g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ngMLV-00FvBe-KB; Mon, 18 Apr 2022 08:02:53 +0000
Received: from esa3.hgst.iphmx.com ([216.71.153.141])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1ngMLR-00Fv9Q-O9
 for linux-nvme@lists.infradead.org; Mon, 18 Apr 2022 08:02:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1650268968; x=1681804968;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=MERTNbn4AhK74X7Db7lDnICPdc+nuPVKeYAvKUf3y7M=;
 b=QqeZ1xDPOJJMKzkcSwYoWnSXGDmdvLMs8403uOH2HYqsRQbWg3jtxlhK
 yiwdkM/vhACGsRtAI5GL7ALySCVoFkN9vryi9XhHCZE1Tu418an8iM4i4
 ffP7rbOK5/gUOPgHqJJTDI+/wpAiCC9Wu1INtObuGx2btAOQK3YXEsVr4
 1L7nw71j9sB2xV5sKlgyX18lKWogIx9T18JxkySd77wL/alaPF9R09AQS
 y0JnX4A/GtZtSL+eoTQSq4vVxI08e76r+Wdv4CJyw9106ZFOlast1MIgt
 QqzN6jNCZCMHUuy5T8J0haWd1Y/IfHLTg3RqLn7w07E6x9zMWZAH1iZwk Q==;
X-IronPort-AV: E=Sophos;i="5.90,269,1643644800"; d="scan'208";a="203014558"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 18 Apr 2022 16:02:46 +0800
IronPort-SDR: 9CU6erlhmZUmTz0lWo/Ct5/7nmCIPhWQnC/52d09kRBya2fFtzeE+sobfN11RZ/O5TukrcrGBW
 c3of6WOo6WwH7+z7uIPXo0YWDCah2Qt9z4KdO4LCBLfUrF+PNMuOJbengWu1EQF7vGVPCF9dp6
 nWw3Y2j2QPiyoYSK9b+ReF4an1O6lZ258Gt3qe3mhM8K/ry3wfaE424IvB7IbSjfnTI0nCmuMs
 eFICZ3i1WXEbY1xVg2FLpVfaFLh1vN10m5Vx9tEvnUNMieCwN6L/FRSvHVrlcEzuxkqAOgJyBA
 Zs+Ov03HWgM7FYJM0MkdHdZh
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 18 Apr 2022 00:33:08 -0700
IronPort-SDR: YL9pDKGIaTLPPXYpBINMKkqdoOYsiPj92h+9jV+ROE3RUwbq3uN6vPkxRV9Ga7g1DBxzK/uZIK
 VF3rRh61tqkMgFzPgYZGshU25JhM+sijJOUTqEYdfxOA2s/QT0in70O4Rh4eNcR9R0GzuBskrR
 XDXhhCVBVaQDElXuEfro/avNxMPjGHNQLwxlY2dHrfOEdp/Vow5w+997nlNpximsrwl9z9HqgD
 nur78YomyOag78BrkjvB5L2FAmqGPCMisxusONzbSmrx/6/+JVUhFuOGdgfanM72t/jA454jlc
 kNA=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
 by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 18 Apr 2022 01:02:48 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
 by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4KhfYf6Wdcz1SVp0
 for <linux-nvme@lists.infradead.org>; Mon, 18 Apr 2022 01:02:46 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
 reason="pass (just generated, assumed good)"
 header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
 opensource.wdc.com; h=content-transfer-encoding:content-type
 :in-reply-to:organization:from:references:to:content-language
 :subject:user-agent:mime-version:date:message-id; s=dkim; t=
 1650268966; x=1652860967; bh=MERTNbn4AhK74X7Db7lDnICPdc+nuPVKeYA
 vKUf3y7M=; b=maQuzRZ/p1t712qIY+IhTpqcG/pQm05duyWvErv19vVeNzSmghD
 V4UuT2NV8F1UHjPSFwamLFQzH0XOoOisHdD5+ADyIjpRhXJPPl5hYhdFZR4R3yn2
 vTW1rZBntXlrodM4xw/I5C7zh7jqW/1gkWMPa3JzW2mwGm1TfLpwL9s7bmvPqTHL
 AfCw9bTeUQ4nuJGbirW25tkuQc/GVk+wNgRm9VpyFwcn0iHRVCCSn/lEXHWhxPHO
 KFbkC86QG+PviD2uM16wutWPiPD0SXUHyCsj7Zbgqnz3gff3TOmOT2Wu5Xp0PjTz
 AO6u+oKpxJEkPaiLyjsLleOyU/qelBVlYrg==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
 by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new,
 port 10026)
 with ESMTP id OBs-p-SYHiPk for <linux-nvme@lists.infradead.org>;
 Mon, 18 Apr 2022 01:02:46 -0700 (PDT)
Received: from [10.225.163.14] (unknown [10.225.163.14])
 by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4KhfYZ5jVFz1Rwrw;
 Mon, 18 Apr 2022 01:02:42 -0700 (PDT)
Message-ID: <1cef25df-b00d-4590-5598-555c5d97d1c1@opensource.wdc.com>
Date: Mon, 18 Apr 2022 17:02:41 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [dm-devel] [PATCH 10/11] rnbd-srv: use bdev_discard_alignment
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
 <20220418045314.360785-11-hch@lst.de>
From: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220418045314.360785-11-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220418_010249_835241_919181B7 
X-CRM114-Status: GOOD (  20.25  )
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
> Use bdev_discard_alignment to calculate the correct discard alignment
> offset even for partitions instead of just looking at the queue limit.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  drivers/block/rnbd/rnbd-srv-dev.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/block/rnbd/rnbd-srv-dev.h b/drivers/block/rnbd/rnbd-srv-dev.h
> index d080a0de59225..4309e52524691 100644
> --- a/drivers/block/rnbd/rnbd-srv-dev.h
> +++ b/drivers/block/rnbd/rnbd-srv-dev.h
> @@ -59,7 +59,7 @@ static inline int rnbd_dev_get_discard_granularity(const struct rnbd_dev *dev)
>  
>  static inline int rnbd_dev_get_discard_alignment(const struct rnbd_dev *dev)
>  {
> -	return bdev_get_queue(dev->bdev)->limits.discard_alignment;
> +	return bdev_discard_alignment(dev->bdev);
>  }
>  
>  #endif /* RNBD_SRV_DEV_H */

Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>

-- 
Damien Le Moal
Western Digital Research

