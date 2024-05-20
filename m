Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94071C25B77
	for <linux-nvme@archiver.kernel.org>; Mon, 20 May 2024 23:43:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=OyFlC0B3t3C3QPALfJEi8R8rd3f1cHbIyvzodAAs6QI=; b=sNySWU66bo0gt65A8pW9+r6pLV
	ZxIR9D+zJRMZd/9yEi15SXsKQacsTUHVt8YovsEx4FyqMbCZ2aCGdTmXzvTnAtI7734ehuQ7gHb8w
	C5lYQ1AAVUtbJBMZNH91q7yPHHyCXY+XHa/2YmyafJ4n2TRBMnZhX7g0zm4DaN+g4/unrdOgmbdt0
	adBhj3HSYhifHLucCofMLjjcUisWsvoJMqGRDljn9g/2OOjiM+MKB+y53hpbjRJEtZtzV/7nY8LZO
	CNWTC85fcVI7FNIWSAPnPVmCVbd0qfjEeNjdHPnKPOuGYrjk3XWET4lew9WSR9LcdoSOWULSqMARi
	NgDs95jg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s9Cez-0000000FqBR-3f3U;
	Mon, 20 May 2024 23:43:17 +0000
Received: from 009.lax.mailroute.net ([199.89.1.12])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s9Cew-0000000FqAi-1Zje
	for linux-nvme@lists.infradead.org;
	Mon, 20 May 2024 23:43:16 +0000
Received: from localhost (localhost [127.0.0.1])
	by 009.lax.mailroute.net (Postfix) with ESMTP id 4VjvJd4CZRzlgT1M;
	Mon, 20 May 2024 23:43:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1716248582; x=1718840583; bh=OyFlC0B3t3C3QPALfJEi8R8r
	d3f1cHbIyvzodAAs6QI=; b=kCzSBQhtvR/gwexX/OBMgW8+9uPM2XLI1Io3VPXA
	ExEWQOuBhyfGPlN9tKDNhM1K5E9x0eL/9Ri9AdYtHgjzysrJytIcu7gSGlYMqkC1
	Ca0Br0owVaLiVVu/FpxEEeojwBG57vo0FCdc3OsdSmOf3dbvEfYzJI+8HE3qe1mY
	vWMZfvF/OU5X5BG4RLWTW0ODrCRsLtIGJvzZdTxgA+cC1AMYouzEw6foDJqXDpTK
	uX+zra2D0UtQsL7OjinTTCVPnMzbGsRgtbIkhkpB3RbRPFifE6E+Yyl7LBzNEdmL
	zV5OOA6ldYfH80zPuAQxjF6hg/HtlnLKdM/Dhm7yFWNcsw==
X-Virus-Scanned: by MailRoute
Received: from 009.lax.mailroute.net ([127.0.0.1])
 by localhost (009.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id EgVMztfS5ec5; Mon, 20 May 2024 23:43:02 +0000 (UTC)
Received: from [100.96.154.26] (unknown [104.132.0.90])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 009.lax.mailroute.net (Postfix) with ESMTPSA id 4VjvJH2Hf4zlgT1K;
	Mon, 20 May 2024 23:42:54 +0000 (UTC)
Message-ID: <2433bc0d-3867-475d-b472-0f6725f9a296@acm.org>
Date: Mon, 20 May 2024 16:42:52 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v20 12/12] null_blk: add support for copy offload
To: Nitesh Shetty <nj.shetty@samsung.com>, Jens Axboe <axboe@kernel.dk>,
 Jonathan Corbet <corbet@lwn.net>, Alasdair Kergon <agk@redhat.com>,
 Mike Snitzer <snitzer@kernel.org>, Mikulas Patocka <mpatocka@redhat.com>,
 Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
Cc: martin.petersen@oracle.com, david@fromorbit.com, hare@suse.de,
 damien.lemoal@opensource.wdc.com, anuj20.g@samsung.com, joshi.k@samsung.com,
 nitheshshetty@gmail.com, gost.dev@samsung.com,
 Vincent Fu <vincent.fu@samsung.com>, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 dm-devel@lists.linux.dev, linux-nvme@lists.infradead.org,
 linux-fsdevel@vger.kernel.org
References: <20240520102033.9361-1-nj.shetty@samsung.com>
 <CGME20240520103039epcas5p4373f7234162a32222ac225b976ae30ce@epcas5p4.samsung.com>
 <20240520102033.9361-13-nj.shetty@samsung.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20240520102033.9361-13-nj.shetty@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240520_164314_510760_27A1B36E 
X-CRM114-Status: GOOD (  15.57  )
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

On 5/20/24 03:20, Nitesh Shetty wrote:
> +	if (blk_rq_nr_phys_segments(req) != BLK_COPY_MAX_SEGMENTS)
> +		return status;

Why is this check necessary?

> +	/*
> +	 * First bio contains information about destination and last bio
> +	 * contains information about source.
> +	 */

Please check this at runtime (WARN_ON_ONCE()?).

> +	__rq_for_each_bio(bio, req) {
> +		if (seg == blk_rq_nr_phys_segments(req)) {
> +			sector_in = bio->bi_iter.bi_sector;
> +			if (rem != bio->bi_iter.bi_size)
> +				return status;
> +		} else {
> +			sector_out = bio->bi_iter.bi_sector;
> +			rem = bio->bi_iter.bi_size;
> +		}
> +		seg++;
> +	}

_rq_for_each_bio() iterates over the bios in a request. Does a copy
offload request always have two bios - one copy destination bio and
one copy source bio? If so, is 'seg' a bio counter? Why is that bio
counter compared with the number of physical segments in the request?

> +	trace_nullb_copy_op(req, sector_out << SECTOR_SHIFT,
> +			    sector_in << SECTOR_SHIFT, rem);
> +
> +	spin_lock_irq(&nullb->lock);
> +	while (rem > 0) {
> +		chunk = min_t(size_t, nullb->dev->blocksize, rem);
> +		offset_in = (sector_in & SECTOR_MASK) << SECTOR_SHIFT;
> +		offset_out = (sector_out & SECTOR_MASK) << SECTOR_SHIFT;
> +
> +		if (null_cache_active(nullb) && !is_fua)
> +			null_make_cache_space(nullb, PAGE_SIZE);
> +
> +		t_page_in = null_lookup_page(nullb, sector_in, false,
> +					     !null_cache_active(nullb));
> +		if (!t_page_in)
> +			goto err;
> +		t_page_out = null_insert_page(nullb, sector_out,
> +					      !null_cache_active(nullb) ||
> +					      is_fua);
> +		if (!t_page_out)
> +			goto err;
> +
> +		in = kmap_local_page(t_page_in->page);
> +		out = kmap_local_page(t_page_out->page);
> +
> +		memcpy(out + offset_out, in + offset_in, chunk);
> +		kunmap_local(out);
> +		kunmap_local(in);
> +		__set_bit(sector_out & SECTOR_MASK, t_page_out->bitmap);
> +
> +		if (is_fua)
> +			null_free_sector(nullb, sector_out, true);
> +
> +		rem -= chunk;
> +		sector_in += chunk >> SECTOR_SHIFT;
> +		sector_out += chunk >> SECTOR_SHIFT;
> +	}
> +
> +	status = 0;
> +err:
> +	spin_unlock_irq(&nullb->lock);

In the worst case, how long does this loop disable interrupts?

> +TRACE_EVENT(nullb_copy_op,
> +		TP_PROTO(struct request *req,
> +			 sector_t dst, sector_t src, size_t len),
> +		TP_ARGS(req, dst, src, len),
> +		TP_STRUCT__entry(
> +				 __array(char, disk, DISK_NAME_LEN)
> +				 __field(enum req_op, op)
> +				 __field(sector_t, dst)
> +				 __field(sector_t, src)
> +				 __field(size_t, len)
> +		),

Isn't __string() preferred over __array() since the former occupies less space
in the trace buffer?

Thanks,

Bart.

