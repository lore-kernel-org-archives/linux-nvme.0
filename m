Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 030FAC3DA7A
	for <linux-nvme@archiver.kernel.org>; Wed, 14 Oct 2026 16:43:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=MprqRVTku8rnnoqrNidogE79Hh/sbjcVtJHMk6QO0CA=; b=3otIKpRs6Wg+ewL6AELaf1daWu
	WeK9DFx+NM1grPcgN8HdZyUWil/TnD7Wo1Zjxl22eLzRi1IW+l5+U6By1+TFUfJklqLK79msCMvOH
	1WBbXsXhacQhWNqHGoCiJitEXPujN0t4KtkRa0cIdQdz2LI4ovFMrZ2249xlYz+xLQtJ/tONpsBTs
	imrwD7u/P/guIOblvaesIus5140JAt2repuS52x7KuYkSdUlSQE/ZKHiKbdC3UdxpuLDIDD6MhB8N
	yVdVymr7Pk02v+BUyvHk7J7knwfGMUFuif+CwycoxLKjn/4pmXMPmFCwJ0Gvln0tYiaHKtDTKICVc
	XymCSHyg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xH24h-0000000G1Im-0KrH;
	Wed, 14 Oct 2026 16:43:31 +0000
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xH24e-0000000G1I4-2yhx
	for linux-nvme@lists.infradead.org;
	Wed, 14 Oct 2026 16:43:29 +0000
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-4980fe6b3beso33440065e9.0
        for <linux-nvme@lists.infradead.org>; Wed, 14 Oct 2026 09:43:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791996207; x=1792601007; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MprqRVTku8rnnoqrNidogE79Hh/sbjcVtJHMk6QO0CA=;
        b=aZih4+b+VL/yZ6PLdrXdoYljR+4zZxASHsUXReGOkj89bzsVEFBBSBjUusG/00niBV
         4jt3OE5rOa6md0Pp2qGC0O9uoZj4fqXY+QTeaUBatHI1IlphMKydf7E1j2ARzfwdymcE
         NJ07p3kxBQlVvyGNsHlB7VZ/vyk09dyROS0dGpeP5geC5QUn0tP0tJcgGJuAvXp5t/CQ
         YRxypx7bd792thFwaY3vylZN+dnbjaWCKol+UzUFyUqOJXmI6agW+//uvAgcTMvjhBQ6
         vdBHM+M23JEYazRY60Do+AZnRonWgwvlxMWSZJ9Yl7v2yEbNp9k067n/Z4aXSUcqn8Nn
         M0eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791996207; x=1792601007;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MprqRVTku8rnnoqrNidogE79Hh/sbjcVtJHMk6QO0CA=;
        b=XPGR+rwUx1jYLYXDq6SImLr7bajItew+lT5GPzIo7YQjEhp+Rpv7ldbVcuxT+oP0ht
         URCpF3pis6/R2oqOiFV+1y3qo8tGyTTRI3yK3ZRsqZixpwVt6xDuET+ARSo8+abjwNx3
         rET6Ol//X9lpuysqvGHvswE/nwbaI3I+KmNLf2g1yv50mLeZ56vraPDugJBzcbxlWFDX
         fpiAJyPwwU60Olt7RqEnq/m0W23YauzSKmsm2LU0eEeYiYL6mzuIEFiDFIeK/Pl5pg5j
         W5kGftolQ2Huoa+nYkUc7BLtNY2w9eByUKKNyhOq7bOKWdSR23Y1Lb3ZQVAND7UnRN3U
         umDQ==
X-Forwarded-Encrypted: i=1; AKwUvByDoxo665HP0xDYsvDAdRauOKzeBR6ygKvf5FzQn1FGrSDLqpy7E9pJyEiYBjmP/eQ0N7BTBVlnZ1Oo@lists.infradead.org
X-Gm-Message-State: AFq9FYJgY4+aYiGnXCKu7KEQiie0OtHkVhXzdjUSdVcYNhSkxJI5GRoZ
	fNJjYBp3XitvyC9KpQHhXAkFtj92yc2rjvW4hyPMoO5uMN++CjetgTk1
X-Gm-Gg: AYBFou0cUveUe2kLY4kwWPGiz8VHxpKQg4i/dEvg360/KuI4ZjkGreDkIYtxZEoDB8C
	X8LGfAqY2dvcZm1WTlGaptiPpUkxr67pt7QGvGBXoDOQdwCcoZ01+1/SHXVnzOfhTJQKsSZNpOX
	nezSU5PNBdV6tfpfbG98cWwkLKouUTWOAxnA6tvyYSCGrM4xG7JEGKibcwPfM6hx0j9Ie/orwrN
	3RL2erSzPMkV3TP/N+LhdXiLdHkSZK21S/mLEL12JcV7WjgMFAjJcBmwAIABP5acVbAgpwnpWwf
	fpI9HZlBfp8gUeIrMOQJ7O4NvVKVuoKBYZIY0eFhDo8cMw5T96E20TtBCHWNdVNWk7CZyf6QFo/
	vnXVf44E+AMfEcG1JQTiT3xewA9zlq3rQ3tQ5chhXXEOEFxT4Z5FlczlHbMRSCRMSdfkGwHpKO+
	Om3Y75OfdCUynGalj/DvYPxno+3UD4xH6KcQeK1wCCTBHVVXSHZ20Z7jmqIEAeNoyRJvXTy/2gT
	McBwz7yGWW+3oBURQ6+imOVydvnydbGeSqtqBuI/Hy7zlyxST6bgq602QMT4i0dsse98GjO52J9
	WQNTSnKBcOjYn7fa0KXb7vSE+X8915B3A9FOLoNwggJ36Vsf
X-Received: by 2002:a05:600c:83cf:b0:4a1:ac66:604b with SMTP id 5b1f17b1804b1-4a1ac666a65mr120408565e9.1.1791996206748;
        Wed, 14 Oct 2026 09:43:26 -0700 (PDT)
Received: from ?IPV6:2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c? ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1bd640be0sm4751135e9.1.2026.10.14.09.43.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Oct 2026 09:43:24 -0700 (PDT)
Message-ID: <7d3c3cc3-5c7b-4d28-82d8-2cdb5e010c29@gmail.com>
Date: Wed, 14 Oct 2026 17:43:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 04/13] block: introduce dma map backed bio type
To: Christoph Hellwig <hch@lst.de>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org, linux-nvme@lists.infradead.org,
 linux-fsdevel@vger.kernel.org, io-uring@vger.kernel.org,
 Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 Andrew Morton <akpm@linux-foundation.org>, Jens Axboe <axboe@kernel.dk>,
 Nitesh Shetty <nj.shetty@samsung.com>, Kanchan Joshi <joshi.k@samsung.com>,
 Anuj Gupta <anuj20.g@samsung.com>, Tushar Gohad <tushar.gohad@intel.com>,
 William Power <william.power@intel.com>,
 Matthew Brost <matthew.brost@intel.com>, Alasdair Kergon <agk@redhat.com>,
 Mike Snitzer <snitzer@kernel.org>, Mikulas Patocka <mpatocka@redhat.com>,
 Benjamin Marzinski <bmarzins@redhat.com>, dm-devel@lists.linux.dev
References: <cover.1791975048.git.asml.silence@gmail.com>
 <39b964cf7510f42755188563da63d3d5acaf2aa9.1791975048.git.asml.silence@gmail.com>
 <20261014131554.GA16467@lst.de>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <20261014131554.GA16467@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261014_094328_770284_22DE14BE 
X-CRM114-Status: GOOD (  16.70  )
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

On 10/14/26 14:15, Christoph Hellwig wrote:
> On Wed, Oct 14, 2026 at 12:02:02PM +0100, Pavel Begunkov wrote:
...>>   	case REQ_OP_DISCARD:
>> diff --git a/block/blk-mq.c b/block/blk-mq.c
>> index e929f94b25c7..1b7f8cbbda8b 100644
>> --- a/block/blk-mq.c
>> +++ b/block/blk-mq.c
>> @@ -3150,6 +3150,12 @@ void blk_mq_submit_bio(struct bio *bio)
>>   		goto queue_exit;
>>   	}
>>   
>> +	if (unlikely(op_is_dmabuf(bio->bi_opf) &&
>> +		bdev_has_integrity_csum(bio->bi_bdev))) {
>> +		bio_endio_status(bio, BLK_STS_NOTSUPP);
> 
> Wrong indentation, conditions are never indented the same level as
> the following code block, even with the weirdest preferences.
> 
> /me note the patch from Anuj on the list actually got this right..

I had to split Anuj's patch in two, should've butchered it
while hand applying. I'll follow up on that unless Jens
already applied the change.

> Otherwise looks good:
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>

-- 
Pavel Begunkov


