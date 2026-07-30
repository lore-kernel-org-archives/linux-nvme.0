Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2205AC55162
	for <linux-nvme@archiver.kernel.org>; Thu, 30 Jul 2026 09:41:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	Content-Transfer-Encoding:In-Reply-To:From:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zJOE8fDTbP+2NUDk5mtlRQDxjdn6gYpUkpkplVDl+3Y=; b=0thfJAB5YdNOYCpO5DrrNlyZpF
	2+UZQhMqcQYI9yP9+wDQk7yX3sTn10PGcVKYKF2oBaXJDXs4JDGHq4PCLuDlEIQs+E46OIHDS9zm5
	+xIK/uN7FmVgWo7Lodaq5MaGqtxVCGGXmb3NCTZVKmG3ImKAVbzxASiYk8wVDKbXGarkhDjrWjQpJ
	Gpjn6BRhVVS3FOQPGyJJIYiQGGiVHiEbWewnEc0Zh41FzL7Rt1oU1WoAGr64givhZw9IEqf8flqeC
	HzJobMALvmFnExYgZErLznUeXFuoq1WHEt3S0UeQn65AjtupX4qwm7KpTuhs/jP1KhQH6xIQpZxSr
	HwFncDig==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wpNGN-0000000A2Xf-0lza;
	Thu, 30 Jul 2026 09:41:15 +0000
Received: from mailout3.samsung.com ([203.254.224.33])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wpNGI-0000000A2V5-49vq
	for linux-nvme@lists.infradead.org;
	Thu, 30 Jul 2026 09:41:14 +0000
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20260730094104epoutp03cd0bc4806d2c269d095648340519a2b5~HB_aYV0xZ2272722727epoutp03X
	for <linux-nvme@lists.infradead.org>; Thu, 30 Jul 2026 09:41:04 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20260730094104epoutp03cd0bc4806d2c269d095648340519a2b5~HB_aYV0xZ2272722727epoutp03X
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1785404464;
	bh=zJOE8fDTbP+2NUDk5mtlRQDxjdn6gYpUkpkplVDl+3Y=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=QGxWzKfNh+qBDb9EIKitqXBSYBv/bKdAGgAVTC6jTl/8cFk60CHc2uw95AfTdDkdT
	 YCtV7tlCIxkCvjqfU+PtjBqiqTrNco7HNIu5JgfSM3CHae4t2XuxqKtOoBc/5g+CBR
	 mkpDKl+9wncG9W1p0ZhojeRkXAxLOnOYbpNSdw8E=
Received: from epsnrtp01.localdomain (unknown [182.195.42.153]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPS id
	20260730094103epcas5p29e1eb1e8426101f502af58c066d5fee5~HB_aCQPMN1388613886epcas5p2d;
	Thu, 30 Jul 2026 09:41:03 +0000 (GMT)
Received: from epcas5p2.samsung.com (unknown [182.195.38.87]) by
	epsnrtp01.localdomain (Postfix) with ESMTP id 4h9kjC12ngz6B9m4; Thu, 30 Jul
	2026 09:41:03 +0000 (GMT)
Received: from epsmtip1.samsung.com (unknown [182.195.34.30]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
	20260730094102epcas5p3626314f8dc7d200ae631017ae98c0920~HB_Y9qT8g2434024340epcas5p3n;
	Thu, 30 Jul 2026 09:41:02 +0000 (GMT)
Received: from [107.122.11.51] (unknown [107.122.11.51]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20260730094101epsmtip1514629a32f333b26ec19f812adc034ba~HB_XtcL6Z0654606546epsmtip1b;
	Thu, 30 Jul 2026 09:41:01 +0000 (GMT)
Message-ID: <749b4476-6d8c-4573-b51b-662b0ff57db3@samsung.com>
Date: Thu, 30 Jul 2026 15:10:59 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] nvme: clamp FDP placement handle count to the
 buffer size
To: Guixin Liu <kanie@linux.alibaba.com>, Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, Sagi Grimberg
	<sagi@grimberg.me>, Hannes Reinecke <hare@suse.de>, Nilay Shroff
	<nilay@linux.ibm.com>, Chaitanya Kulkarni <kch@nvidia.com>
Cc: linux-nvme@lists.infradead.org
Content-Language: en-US
From: Kanchan Joshi <joshi.k@samsung.com>
In-Reply-To: <20260730043105.3071328-5-kanie@linux.alibaba.com>
Content-Transfer-Encoding: 7bit
X-CMS-MailID: 20260730094102epcas5p3626314f8dc7d200ae631017ae98c0920
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20260730051151epcas5p1c47d82291b2bd4437fcf14e7816c4c8e
References: <20260730043105.3071328-1-kanie@linux.alibaba.com>
	<CGME20260730051151epcas5p1c47d82291b2bd4437fcf14e7816c4c8e@epcas5p1.samsung.com>
	<20260730043105.3071328-5-kanie@linux.alibaba.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260730_024111_673999_75E95612 
X-CRM114-Status: GOOD (  20.31  )
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

On 7/30/2026 10:01 AM, Guixin Liu wrote:
> nvme_query_fdp_info() allocates the RUH status buffer for at most
> S8_MAX - 1 descriptors and caps the io-mgmt-receive transfer to that
> size. head->nr_plids, however, is taken verbatim from the device-supplied
> nruhsd field, which can be up to 65535. If a non-conformant or malicious
> device reports more descriptors than the buffer holds, the copy loop
> reads past the end of the ruhs buffer (heap out-of-bounds read).
> 
> Clamp nr_plids to the number of descriptors the buffer can actually hold.
> 
> Fixes: 30b5f20bb2dd ("nvme: register fdp parameters with the block layer")
> Signed-off-by: Guixin Liu<kanie@linux.alibaba.com>
> ---
>   drivers/nvme/host/core.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 453c1f0b2dd0..b1f444cd3daf 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -2358,6 +2358,7 @@ static int nvme_query_fdp_info(struct nvme_ns *ns, struct nvme_ns_info *info)
>   	}
>   
>   	head->nr_plids = le16_to_cpu(ruhs->nruhsd);
> +	head->nr_plids = min_t(u16, head->nr_plids, S8_MAX - 1);

Given what we have at this point, the fix is fine.

Reviewed-by: Kanchan Joshi <joshi.k@samsung.com>

But I feel the need to improve (what we have) with a follow-up patch:
1. Revise the cap, from S8_MAX - 1 to U8_MAX; since bio->bi_write_hint 
is u8.
2. And a dev_warn() to know if head->nr_plids go above the 
kernel-defined cap. It's possible/fine for device to have more placement 
ids, and if that happens, this can tell.

Keith, Christoph - thoughts?

