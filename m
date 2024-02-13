Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D238DC48260
	for <linux-nvme@archiver.kernel.org>; Tue, 13 Feb 2024 04:34:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Subject:Cc:To:
	From:Message-Id:Date:Reply-To:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
	List-Owner; bh=vh4C2jib+iFDULM0386egKcjhLxfCpsjoM1ZbGOsfWA=; b=e5ZsbRV96/2cHl
	4nlG8MMU3UZc6qNKvGs2+pZbVoxg0lcAHlIJRVrNPRQa4JevOwgogEQjO/GLolcB+qLRs5ei+fpmw
	M3oKPDG7vlX1CAH3Jgf/xcUFoBEws03mkq6SRvnHcPd2G2K2Je4svVFet+DlmOKuGZDYnwsDNdWCA
	7W1MRvJCLtW17Q1pMzvs9KJu0+ZqwqiTx0R3qAjP4cIGU+OkRwIsdrZ/zjcla0iI6P1thewDd1Yut
	lPPlF5O7ehIoXdFwOZJY1/jxl7/+uTJXjqnoSkHc/wakC+75WJ/LWB3NBvO8zM6nn08Q/FLJs0gH3
	2YS82wkxiBroBkIMW3Bg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rZkUx-00000007wWg-3fcQ;
	Tue, 13 Feb 2024 04:34:23 +0000
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rZkUv-00000007wRy-1J37
	for linux-nvme@lists.infradead.org;
	Tue, 13 Feb 2024 04:34:22 +0000
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-6de3141f041so414438b3a.0
        for <linux-nvme@lists.infradead.org>; Mon, 12 Feb 2024 20:34:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707798851; x=1708403651; darn=lists.infradead.org;
        h=in-reply-to:subject:cc:to:from:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=vh4C2jib+iFDULM0386egKcjhLxfCpsjoM1ZbGOsfWA=;
        b=kUvaAOcwkHGsNWacwJIozPXGf7ZHcmPEFYbMSZpG3se1kQnNMlCMxdHyoAwNmndmP5
         ovUtPoVkUurWF36BHIKM9pWkJ+4C56MhckvqYKu4E6dmDf4TGwBfXiKTltl22BeNzN5M
         opsTYo02Hep5XZCJ4QOPVAGFT8ktadT1ArqHPSOMJX+aVPTdAG/HlsuG8ZgwNBT/VGtm
         QV/Qk4r8Do9988e9i+IM8Fi/VTpWIBgUY9ISboevhy5nNaciUXmjm0OaBdvwCNdvjk7D
         BHXI4vEt2j4qWm8JopRZFv64ll1xGVhFSjM7A6Vyl+xdpyUQhdzcHl9WVMCC06SlUn/z
         GOaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707798851; x=1708403651;
        h=in-reply-to:subject:cc:to:from:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vh4C2jib+iFDULM0386egKcjhLxfCpsjoM1ZbGOsfWA=;
        b=JO2Bq+mXuRC4dWJdPOrw/Y/blvXfOEMDW7d0uEYubwKChqS12Avfqm+Lgbh6Nyzwaz
         eh1Vpl3WXqIqRAxCgf/HnXarc2EjTOAFxkCRfA3jj5yqM1doATzKXhXMKwFgsNL3oXAj
         yWchaKq0pE41bZ4jYCS7sGH4ZOwu+fUAOFhAvHkjk1/w+IHH/yEznTs+ZK8XAxb89Zcr
         cdiz8LnAobYEjKUIlLhOps1K77h7yqoWYpoGOh+bVfrX6q4UdaagDDqnL1qdQcdK0MrQ
         2Jj6+B1+n1xiqEWWqfKvD4bgl0BcgZdI0TiL/Vb6BLGzIwEX3JUwcNWXbxK+4C4O+F/I
         zf3A==
X-Gm-Message-State: AOJu0YzC3EE3/8qyeBa/2fMfgxbbs61qILwO4LfbXJ8yyfE8xb/8AUoH
	T5JaKDqxXSEBfNUEHJHtfY+afbITA86weiJi9Sk2biTrPqVp3P+S
X-Google-Smtp-Source: AGHT+IEadwOvNzG1cYp2wrNwMifgYz/Nkf//UbAYKYK0dIw3gZ4koF9PqsM8/TaMWNQgSlkRINCZ5Q==
X-Received: by 2002:a62:cd89:0:b0:6e0:9e90:c952 with SMTP id o131-20020a62cd89000000b006e09e90c952mr7886741pfg.15.1707798851203;
        Mon, 12 Feb 2024 20:34:11 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUU0RRdBzarrpVcyDWdb8qRYiHJCCqDXh7A8EViKwnWbqKgn+cBFmAQ4jjKcD0C28Sum5Pyuou3F5mqUG+7Qq4/RYaZn+oZSZua89jrFTzI5/T0etWXq1UpNMje6CuIZpqf1Mw+guISstQ1gwZtrvK/HmrCYTnhTVUX4XZCdNvByS5VDb+JVZ+oQxRYP1muyGziTpF+SGVhnleo01PiJ8JMIAYm3oM0mzPLN7t1cpS47Pd7bi1LwAsP2Tyw+6xk9EfHo3AsfkpFjmmIzXp2kEJHuMASP0J7sh0gvlkFXxYqD72Z5ilbkNVc6RReAhLondBt7JaD/PHpDqKLFP/zWYjk/NJK4+ICX1pxJZLVw85gIo74OjUr54nWasmb7lUh5xRM/NOEFUNqKPX5DjvJBzKc3rvhtUPHnqVFLQlOPAkdl2PXMp5lpUK50d8y/NQ+XWHhIqJLOH77s3jlswpsTaPK7tZ6X3cCk9cvtwFLxQT7sV9mvf8Bl7G3U2pJnwOVW6tUmYs/CXoCGk/XPk/G/DO6kQx4Pot8TWso71UrckumNkRwjZRxonNl8EFQy9dg+rGOltEj7tTV417ThWduaqjOwooBCyH7crro+AoUuSvSLfnxl229YnqoYF0nmlV5xlnD+eQXx7QC48wS9P+ccOaecRsP6vvd/xvfaA==
Received: from dw-tp ([49.205.218.89])
        by smtp.gmail.com with ESMTPSA id s23-20020a632c17000000b005dc816b2369sm605121pgs.28.2024.02.12.20.34.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Feb 2024 20:34:10 -0800 (PST)
Date: Tue, 13 Feb 2024 10:03:58 +0530
Message-Id: <87h6idugnd.fsf@doe.com>
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: John Garry <john.g.garry@oracle.com>, axboe@kernel.dk, kbusch@kernel.org, hch@lst.de, sagi@grimberg.me, jejb@linux.ibm.com, martin.petersen@oracle.com, djwong@kernel.org, viro@zeniv.linux.org.uk, brauner@kernel.org, dchinner@redhat.com, jack@suse.cz
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org, linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, tytso@mit.edu, jbongio@google.com, linux-scsi@vger.kernel.org, ming.lei@redhat.com, ojaswin@linux.ibm.com, bvanassche@acm.org, John Garry <john.g.garry@oracle.com>
Subject: Re: [PATCH v3 02/15] block: Limit atomic writes according to bio and queue limits
In-Reply-To: <20240124113841.31824-3-john.g.garry@oracle.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240212_203421_394766_7C583B40 
X-CRM114-Status: GOOD (  25.03  )
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

John Garry <john.g.garry@oracle.com> writes:

> We rely the block layer always being able to send a bio of size
> atomic_write_unit_max without being required to split it due to request
> queue or other bio limits.
>
> A bio may contain min(BIO_MAX_VECS, limits->max_segments) vectors on the
> relevant submission paths for atomic writes and each vector contains at
> least a PAGE_SIZE, apart from the first and last vectors.
>
> Signed-off-by: John Garry <john.g.garry@oracle.com>
> ---
>  block/blk-settings.c | 28 ++++++++++++++++++++++++++--
>  1 file changed, 26 insertions(+), 2 deletions(-)
>
> diff --git a/block/blk-settings.c b/block/blk-settings.c
> index 11c0361c2313..176f26374abc 100644
> --- a/block/blk-settings.c
> +++ b/block/blk-settings.c
> @@ -108,18 +108,42 @@ void blk_queue_bounce_limit(struct request_queue *q, enum blk_bounce bounce)
>  }
>  EXPORT_SYMBOL(blk_queue_bounce_limit);
>  
> +
> +/*
> + * Returns max guaranteed sectors which we can fit in a bio. For convenience of
> + * users, rounddown_pow_of_two() the return value.
> + *
> + * We always assume that we can fit in at least PAGE_SIZE in a segment, apart
> + * from first and last segments.
> + */

It took sometime to really understand what is special about the first
and the last vector. Looks like what we are discussing here is the
I/O covering a partial page, i.e. the starting offset and the end
boundary might not cover the whole page. 

It still isn't very clear that why do we need to consider
queue_logical_block_size(q) and not the PAGE_SIZE for those 2 vectors
(1. given atomic writes starting offset and length has alignment
restrictions? 
2. So maybe there are devices with starting offset alignment
to be as low as sector size?)

But either ways, my point is it would be good to have a comment above
this function to help understand what is going on here. 


> +static unsigned int blk_queue_max_guaranteed_bio_sectors(
> +					struct queue_limits *limits,
> +					struct request_queue *q)
> +{
> +	unsigned int max_segments = min(BIO_MAX_VECS, limits->max_segments);
> +	unsigned int length;
> +
> +	length = min(max_segments, 2) * queue_logical_block_size(q);
> +	if (max_segments > 2)
> +		length += (max_segments - 2) * PAGE_SIZE;
> +
> +	return rounddown_pow_of_two(length >> SECTOR_SHIFT);
> +}
> +
>  static void blk_atomic_writes_update_limits(struct request_queue *q)
>  {
>  	struct queue_limits *limits = &q->limits;
>  	unsigned int max_hw_sectors =
>  		rounddown_pow_of_two(limits->max_hw_sectors);
> +	unsigned int unit_limit = min(max_hw_sectors,
> +		blk_queue_max_guaranteed_bio_sectors(limits, q));
>  
>  	limits->atomic_write_max_sectors =
>  		min(limits->atomic_write_hw_max_sectors, max_hw_sectors);
>  	limits->atomic_write_unit_min_sectors =
> -		min(limits->atomic_write_hw_unit_min_sectors, max_hw_sectors);
> +		min(limits->atomic_write_hw_unit_min_sectors, unit_limit);
>  	limits->atomic_write_unit_max_sectors =
> -		min(limits->atomic_write_hw_unit_max_sectors, max_hw_sectors);
> +		min(limits->atomic_write_hw_unit_max_sectors, unit_limit);
>  }
>  
>  /**
> -- 
> 2.31.1

