Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3754CA9ED2
	for <linux-nvme@archiver.kernel.org>; Mon, 12 Oct 2026 20:21:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7YdOwQKvIOtKNWjhAuzTAXTxb0yaTLWKFCpvhJolByA=; b=cW35T17tCnC+DfvgDQnB3mEKeb
	awB6SGPDUxg4jY+4biL2SdE/6YZcZskSygMW0mbnGg69fOrVr6UYZNcwW0+eaOL2lDxPfdRsWg45l
	PeMb+v2babOHgQyjOx8dLC67rMa6A4JpvAuHliBUbLgLKoIh5xIIRj7GMJMJqCrlCTb0HkcPwyTB5
	U/06ksTGM36i7YHf1uxA+ITV2WjtVLSgj1McTvQ8sAti0I0xpiHYYMAuB4204TNTkOye51CN2NUFY
	4+G0W5kieHdLbfQJ+6Ch7wHSRCfWN5xEKiqrqqc+5hhXn31Ac5Maf0xQpHSOF63n6ZAuThkJYeYYB
	B+k+i7Dg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xGMWK-0000000BSj9-3ZHz;
	Mon, 12 Oct 2026 20:21:16 +0000
Received: from mail-oo1-xc2a.google.com ([2607:f8b0:4864:20::c2a])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xGMWH-0000000BSii-0MLf
	for linux-nvme@lists.infradead.org;
	Mon, 12 Oct 2026 20:21:15 +0000
Received: by mail-oo1-xc2a.google.com with SMTP id 006d021491bc7-6de1ca1b05aso1475733eaf.0
        for <linux-nvme@lists.infradead.org>; Mon, 12 Oct 2026 13:21:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1791836472; x=1792441272; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7YdOwQKvIOtKNWjhAuzTAXTxb0yaTLWKFCpvhJolByA=;
        b=TWHScFZJo5lE5jk2ob5xBwic+jeWfAKPsYHwdqHtIgszRBkFiaXfigzx8Q4AOM4EYr
         lKkPMDNkfOcfNhis9rGz8IOhlAtHAtVhBRgmEY9A1ehTy0IyTNskBkWXzlOm5ohR6MGP
         oGp49De3i7wogw8ILeYvKIj6TQCjjijUCE7bmdshPo4FteNX8E9Ky7qK7UpVyz//ubYY
         qs3BIPv3zzDJeq1J1QlBRIzM8RwyqYmae70owz39IZzzHa1jk+XQwX1qyiIBasQs01lh
         tsphVSrQbFdNLSllfv1xRFuM5b2naIGqMDnb2uVI77v3BGKfODpQBHUa6ZBYvqCdQTGM
         JUkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791836472; x=1792441272;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7YdOwQKvIOtKNWjhAuzTAXTxb0yaTLWKFCpvhJolByA=;
        b=MCR8ZrKt7vOPUXkhPCnc8l0mjnE3dJuJVC2UrzHdB7+GaTGWogQJeutRzG5EQVuz7u
         9SjlR/pkFUGyjY/F68p3puycmJZxv555IdRYUDRhI1wcN/jHHu9w0+HqUPNCobeMUjGV
         lICJuvkCe+r4XOYA1508mty0lmPdqdq0bMae2A0/bIztx425JKEG9s29ZT14gLdYfUq1
         k2rf62HVO/I33/uVAyBumvFprUmsWEe5iRv08SzwlyRMFpnXI1VV0u9fXqUXVj16Y3Pa
         VIIk57kdxlSArtpqInmYEDN3DYXkl2/bdzSEjGaSgpWBv/nC6XswgxhBG1yYjusTccuB
         OkNw==
X-Forwarded-Encrypted: i=1; AKwUvBwu7UFSp8NVQKShJihEyOsd0nu/0QLjEkR03hsILBZL5V3GW0Xqbd4ixEaBFGlqZvoqwMkTZcg64wci@lists.infradead.org
X-Gm-Message-State: AFq9FYLaJy6BDcek7ud25NxN4nNYNJV13W+fKfXB9yWMljDXBBNU710a
	Ph8PgrR+BQRE0/cXPSmzwyIZiLdlIaYDbzSJax1N+Z8jb7b0eeRsghTWDNJpr159qJk=
X-Gm-Gg: AYBFou1/B7RYL9UcIIDPgAkNZdSwuoHBgyf23zgGW6J5G5H9AIWcmMjWaosC8WKY2Kx
	f+wQdXdJZ7uKS/w01xpqlog4A42ExRpN/0dGVggQeabuCFtWvT80VySunwtUIytbP6D3wrMFQiL
	rVcLx5t/G8OphGDDCxbgreUggARes69LYP/rb3bWIecI4ccsYq+vmRKZn406cFW75ZxpaET3P4R
	ilUB5rLSLIFnq9eiuk0f106z9d0CPBDgcXyl4YsKKXyJ6bLP9BIU8PqkIrazlwipge+CaAj9046
	MhRvC29Nbc4ee0+j9OXddKfC7gU/bjQ+kTVdvhlvHO3KHts3MbaZoICzmZf+e3QfPDvswtf0EJ9
	dvZPthgb1p3+TMpF21oXn8PFQT9tVEExs4kld/8H6sodI38RQnazWXiRXuWzOudT/cxR3IAFN8b
	f71K49rjZXTkC6YTZvF67pQyYWgo1bWWxvHnr6oXnPDoeUmmHRYrEaCtWKkWYjnLW3J9xiBWb6+
	Jfid1C/t6JzvcTcvUmZuxrXktRAd9zmbic5wBdvWSAIFAWpEGpPKDDaiA==
X-Received: by 2002:a05:6820:162a:b0:6f7:75ab:f969 with SMTP id 006d021491bc7-6f775bb41f5mr1943854eaf.66.1791836471882;
        Mon, 12 Oct 2026 13:21:11 -0700 (PDT)
Received: from [192.168.1.106] ([198.8.77.135])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6ef02d91a5asm10237414eaf.14.2026.10.12.13.21.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Oct 2026 13:21:10 -0700 (PDT)
Message-ID: <07d36bc7-637f-4554-9d6f-039e88852dc6@kernel.dk>
Date: Mon, 12 Oct 2026 14:21:03 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 05/13] block: add dma-buf support for raw bdev
To: Anuj Gupta/Anuj Gupta <anuj20.g@samsung.com>,
 Pavel Begunkov <asml.silence@gmail.com>, linux-block@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
 linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org,
 io-uring@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 Andrew Morton <akpm@linux-foundation.org>,
 Nitesh Shetty <nj.shetty@samsung.com>, Kanchan Joshi <joshi.k@samsung.com>,
 Mike Snitzer <snitzer@kernel.org>, Mikulas Patocka <mpatocka@redhat.com>,
 Benjamin Marzinski <bmarzins@redhat.com>, dm-devel@lists.linux.dev
References: <cover.1791336930.git.asml.silence@gmail.com>
 <CGME20261007014324epcas5p2a7f3b03f118c9a1d1c633fe839ed1e46@epcas5p2.samsung.com>
 <af2b48a490186edf38f1d4a5dfd9513574f7a350.1791336930.git.asml.silence@gmail.com>
 <bbb87d6b-b7a3-487a-8be4-27f3f9ce4a1b@samsung.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <bbb87d6b-b7a3-487a-8be4-27f3f9ce4a1b@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261012_132114_333132_0415EC84 
X-CRM114-Status: GOOD (  17.91  )
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

On 10/8/26 6:27 AM, Anuj Gupta/Anuj Gupta wrote:
> On 10/7/2026 7:12 AM, Pavel Begunkov wrote:
>> +static int blkdev_init_dma_buf_io_ctx(struct file *file,
>> +				      struct dma_buf_io_ctx *ctx)
>> +{
>> +	struct block_device *bdev = file_bdev(file);
>> +	struct gendisk *disk = bdev->bd_disk;
>> +
>> +	if (!(file->f_flags & O_DIRECT))
>> +		return -EINVAL;
>> +	if (!disk->fops->init_dma_buf_io_ctx)
>> +		return -EOPNOTSUPP;
> 
> dma-buf doesn't work with PI: bi_dmabuf_map aliases bi_io_vec, and 
> blk_integrity_iterate() walks it as bvecs to generate/verify the 
> checksum. rw-dmabuf liburing test hangs on a PI enabled NVMe. Something 
> like below is needed:
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index e929f94b25c7..1b7f8cbbda8b 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -3150,6 +3150,12 @@ void blk_mq_submit_bio(struct bio *bio)
>                  goto queue_exit;
>          }
> 
> +       if (unlikely(op_is_dmabuf(bio->bi_opf) &&
> +               bdev_has_integrity_csum(bio->bi_bdev))) {
> +               bio_endio_status(bio, BLK_STS_NOTSUPP);
> +               goto queue_exit;
> +       }
> +
>          if ((bio->bi_opf & REQ_POLLED) && !blk_mq_can_poll(q)) {
>                  bio_endio_status(bio, BLK_STS_NOTSUPP);
>                  goto queue_exit;
> diff --git a/block/fops.c b/block/fops.c
> index e9da48ab73be..6c6700df943c 100644
> --- a/block/fops.c
> +++ b/block/fops.c
> @@ -976,6 +976,8 @@ static int blkdev_init_dma_buf_io_ctx(struct file *file,
>                  return -EINVAL;
>          if (!disk->fops->init_dma_buf_io_ctx)
>                  return -EOPNOTSUPP;
> +       if (bdev_has_integrity_csum(bdev))
> +               return -EOPNOTSUPP;
>          return disk->fops->init_dma_buf_io_ctx(bdev, ctx);
>   }

Can you send a separate patch? I've queued this series up for some
testing.

-- 
Jens Axboe

