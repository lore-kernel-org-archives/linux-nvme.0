Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA6DAC433EF
	for <linux-nvme@archiver.kernel.org>; Fri, 22 Jul 2022 22:06:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qXu4wByl3BNt6KU2i2QS6R/HX8NK9Bf8G0fHZSeWoO0=; b=v9cDaauZOIvmPNiBUGgI9gkIF+
	i29luHGsu7E+1Yo36394Go4joYqp7woT4sEXh2TJ6fBKhXNrC5S8v3Uho9Uy9EfzPlp9b68eFi7kO
	S83WGV/jRkTO0Lx825+PGLJbyCzjbKJtBP4UsgUDSZYgCkWjgEbDsFxTV1Oti5myQu90VbJ6QM9H+
	7G9wwqmGokDTbgxfSuuDxNgPsFlnFrmy8V1pa6jSDt2zo/lyaqEUuUMENXLpar69WZFtukrbf6Pgg
	4kSia/hBIq/2yK3bTZ9W7IHfBrGc3726rjjXf8WlPrqX3nS8uQogxrHW6FatXwhkAEGeQdS5THlwn
	S710uptg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oF0mw-00BpIu-9B; Fri, 22 Jul 2022 22:06:26 +0000
Received: from mail-pf1-f182.google.com ([209.85.210.182])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oF0eQ-00Bj4M-9p
	for linux-nvme@lists.infradead.org; Fri, 22 Jul 2022 21:57:41 +0000
Received: by mail-pf1-f182.google.com with SMTP id y141so5488685pfb.7
        for <linux-nvme@lists.infradead.org>; Fri, 22 Jul 2022 14:57:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=qXu4wByl3BNt6KU2i2QS6R/HX8NK9Bf8G0fHZSeWoO0=;
        b=t0T1nNqFuHCJNPwuWKJfboLot91NPYqwoDwuSBKcHMnkgGxTxYpJGWgIjnM8jFIfgR
         o8WmcoTgeigxw4Bu4pDE53iWQ9oiaMo1LY9D/r2L7+BIs/MaoPYZPN6bbDhugdgjLirE
         WU3kCWaE6hJWjyP7wS4hy2AR/feMCNUNw34W5/Wi/JdvrlX9DhH0HChZcY6SlX1caLyb
         7BoWe0DJyiA2hnPiqiPrVHxzzLBq1ZA0W2jY6K4k/DDMi+9Ir8dcxxdMtiHcGQjS0sPf
         rUWmNMgUKEVBJ+FsbAv10dNCrU6QiFKTlO/u4kokjHw2NiAJfhhR/q0Cm0l0tSsgHJq+
         EF9Q==
X-Gm-Message-State: AJIora+TGWQIXuSvwWsAuBof2yGLRLepObVZCc4aYB4oNQaz2Ni1L8tM
	dKmw4VsO5fHlVtuntu1vQdQ=
X-Google-Smtp-Source: AGRyM1ukyOum94MdofNYY6U4MtoZeA7vHPBGYc6T0YvwjrcvsfjN3FvwwgI+gwOhsG6F1VtI15Nquw==
X-Received: by 2002:aa7:8c55:0:b0:52b:7233:f7b1 with SMTP id e21-20020aa78c55000000b0052b7233f7b1mr1813672pfd.33.1658527056052;
        Fri, 22 Jul 2022 14:57:36 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:805b:3c64:6a1f:424c? ([2620:15c:211:201:805b:3c64:6a1f:424c])
        by smtp.gmail.com with ESMTPSA id 6-20020a620606000000b005255489187fsm4431978pfg.135.2022.07.22.14.57.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Jul 2022 14:57:35 -0700 (PDT)
Message-ID: <ed4e63b3-3fd3-ba78-ebd0-69034f703032@acm.org>
Date: Fri, 22 Jul 2022 14:57:33 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCHv6 06/11] block/merge: count bytes instead of sectors
Content-Language: en-US
To: Keith Busch <kbusch@fb.com>, linux-fsdevel@vger.kernel.org,
 linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Cc: axboe@kernel.dk, Kernel Team <Kernel-team@fb.com>, hch@lst.de,
 damien.lemoal@opensource.wdc.com, ebiggers@kernel.org, pankydev8@gmail.com,
 Keith Busch <kbusch@kernel.org>,
 Johannes Thumshirn <johannes.thumshirn@wdc.com>
References: <20220610195830.3574005-1-kbusch@fb.com>
 <20220610195830.3574005-7-kbusch@fb.com>
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20220610195830.3574005-7-kbusch@fb.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220722_145738_422586_61E4FD52 
X-CRM114-Status: UNSURE (   8.86  )
X-CRM114-Notice: Please train this message.
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

On 6/10/22 12:58, Keith Busch wrote:
> @@ -269,8 +269,8 @@ static struct bio *blk_bio_segment_split(struct request_queue *q,
>   {
>   	struct bio_vec bv, bvprv, *bvprvp = NULL;
>   	struct bvec_iter iter;
> -	unsigned nsegs = 0, sectors = 0;
> -	const unsigned max_sectors = get_max_io_size(q, bio);
> +	unsigned nsegs = 0, bytes = 0;
> +	const unsigned max_bytes = get_max_io_size(q, bio) << 9;

How about using SECTOR_SHIFT instead of 9?

Thanks,

Bart.

