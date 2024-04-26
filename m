Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEFFCC4345F
	for <linux-nvme@archiver.kernel.org>; Fri, 26 Apr 2024 14:26:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=SYZdlhOSW2plAcrRNZa4kVgqNxzt+id2KNIRqIUgxH0=; b=2rvf5PPLuhopwdAPhy2Kaa47bh
	9h/a7lRG4WLubRDF87bVAeT67F+iVfy3kazIBG0D3daYTkdSNlCiYnp0UC8t5PubSVGz8F+DjhavQ
	uZj2kDGRr0nifxa3ory3Pq2BqsEJh9RsXhRPhfeg04Jfb2VG88ITi7/ucjY/KH1B56pqJQR0QI9gX
	9FTa1/BR+tC9S+w/Hm61aHthsSJ0wtO8xiKwXkZhwgY880+xY6VXbfx/eCXWsc8u/41EmujDr6EoH
	Gd4MtmSyS6+gEQriMjiRJzXczTOv8Ag4oA6zPKMGh4jaQRLPfkiyrf1+SNM90NCGmAERCEKfBh425
	rvL+rROQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s0MWY-0000000Cpib-1f0b;
	Fri, 26 Apr 2024 14:26:02 +0000
Received: from mail-io1-xd2c.google.com ([2607:f8b0:4864:20::d2c])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s0MWW-0000000Cpgz-07dE
	for linux-nvme@lists.infradead.org;
	Fri, 26 Apr 2024 14:26:01 +0000
Received: by mail-io1-xd2c.google.com with SMTP id ca18e2360f4ac-7da9f6c9c17so16940439f.2
        for <linux-nvme@lists.infradead.org>; Fri, 26 Apr 2024 07:25:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1714141558; x=1714746358; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SYZdlhOSW2plAcrRNZa4kVgqNxzt+id2KNIRqIUgxH0=;
        b=QA42jOjmpc4OrhNx+u6WddSvHbDmLIYxFoGKCmiekOs500iTrq4xZ6ri2SGHV+F8eb
         Oj9iqDUxiybgm4PbtU+RKJNbIGSCBUZwWjdNB2Bf9VpOIGCzZYRrHjXWK0SOKHBiu6zg
         lsVesfNVm/vhvGH+vRdpGrjv8Ru3SvaLsaP78oggT2GzcAijc+WE6TDmzD5qkpG70rnw
         IyOdkpf7FaXR7zhXkANHjuG0aBx0brgoH7KKpy50KbjZEjVgD5sXsbOAOC+DaipeZp+6
         jA8xsQP8chU2+ypdY7rVgYjGfIxKVafi2niSsbkkuShB3FnFJckZKZV01ZCXKI3hynfd
         Nwww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714141558; x=1714746358;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SYZdlhOSW2plAcrRNZa4kVgqNxzt+id2KNIRqIUgxH0=;
        b=UexGwxcF6vJeCKcXIDjQ/ZSgOWVoFvyBt7eiJflItOtEvJF6MW/NlBJo6Us7JjceXU
         BSfvovFUGvo9szg7H0FHnQCco8IT8ZMTsAd8Nf+hrENjtMEXTuH2jkYGCFudx3mADWtg
         mULEG8WMfQmQnkYhpfl//cayy6aLprjzr/sHCrvJKzKIodXlKfJYJslpfI21XrKf7MOw
         Vg22RfomKw1OzSdA4ohv57IUXSK/v6uI8jyZqcqDFmX9M6fiQ3e/B5S68WTzmLXTShUQ
         IUHKsJ7QXYjlOAyhiEEeYxhlF0OmKddunkRYyaN8PGegZSYgX7nxANY4TqHOOtk8E6LH
         hXng==
X-Forwarded-Encrypted: i=1; AJvYcCVqVMJMubww40KwlDBQSirwug6qTQnQuq8rIiBlOOB6QIKtPoXg5g/Vf8dTVSXj5rZnleRrzZFmDvX/UBY/vHT4ifhyp9i6Wq4a/O+a+MY=
X-Gm-Message-State: AOJu0YyXSCFKnOrF7OauPfS6WsbC3wNyYPfn8qxTIqTiH+iXhVn1uREk
	iu7J3wxujinkwxDpnEe+SrzYaF9PZnMLR7fHgAWFSl5V5MzXyf0iRCMbjSK4hWY=
X-Google-Smtp-Source: AGHT+IHWycOosPVtgbMwTpV7/9CaNBl4iip2iOSTKzHCtn56tUpEKvqQDc9Ko3d1m//8UmZnV2Xyig==
X-Received: by 2002:a05:6e02:1a6d:b0:36b:3c29:8d19 with SMTP id w13-20020a056e021a6d00b0036b3c298d19mr3595304ilv.3.1714141557913;
        Fri, 26 Apr 2024 07:25:57 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id v8-20020a92c6c8000000b0036a1303cc0asm4007216ilm.0.2024.04.26.07.25.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Apr 2024 07:25:57 -0700 (PDT)
Message-ID: <f3489d0c-2d27-4e27-ae49-df2e9dad2e00@kernel.dk>
Date: Fri, 26 Apr 2024 08:25:56 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/10] io_uring/rw: add support to send meta along with
 read/write
Content-Language: en-US
To: Kanchan Joshi <joshi.k@samsung.com>, martin.petersen@oracle.com,
 kbusch@kernel.org, hch@lst.de, brauner@kernel.org
Cc: asml.silence@gmail.com, dw@davidwei.uk, io-uring@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
 gost.dev@samsung.com, Anuj Gupta <anuj20.g@samsung.com>,
 Nitesh Shetty <nj.shetty@samsung.com>
References: <20240425183943.6319-1-joshi.k@samsung.com>
 <CGME20240425184706epcas5p1d75c19d1d1458c52fc4009f150c7dc7d@epcas5p1.samsung.com>
 <20240425183943.6319-9-joshi.k@samsung.com>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20240425183943.6319-9-joshi.k@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240426_072600_110558_8E9A097E 
X-CRM114-Status: GOOD (  26.01  )
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

> diff --git a/io_uring/rw.c b/io_uring/rw.c
> index 3134a6ece1be..b2c9ac91d5e5 100644
> --- a/io_uring/rw.c
> +++ b/io_uring/rw.c
> @@ -587,6 +623,8 @@ static int kiocb_done(struct io_kiocb *req, ssize_t ret,
>  
>  		req->flags &= ~REQ_F_REISSUE;
>  		iov_iter_restore(&io->iter, &io->iter_state);
> +		if (unlikely(rw->kiocb.ki_flags & IOCB_USE_META))
> +			iov_iter_restore(&io->meta.iter, &io->iter_meta_state);
>  		return -EAGAIN;
>  	}
>  	return IOU_ISSUE_SKIP_COMPLETE;
This puzzles me a bit, why is the restore now dependent on
IOCB_USE_META?

> @@ -768,7 +806,7 @@ static int io_rw_init_file(struct io_kiocb *req, fmode_t mode)
>  	if (!(req->flags & REQ_F_FIXED_FILE))
>  		req->flags |= io_file_get_flags(file);
>  
> -	kiocb->ki_flags = file->f_iocb_flags;
> +	kiocb->ki_flags |= file->f_iocb_flags;
>  	ret = kiocb_set_rw_flags(kiocb, rw->flags);
>  	if (unlikely(ret))
>  		return ret;
> @@ -787,7 +825,8 @@ static int io_rw_init_file(struct io_kiocb *req, fmode_t mode)
>  		if (!(kiocb->ki_flags & IOCB_DIRECT) || !file->f_op->iopoll)
>  			return -EOPNOTSUPP;
>  
> -		kiocb->private = NULL;
> +		if (likely(!(kiocb->ki_flags & IOCB_USE_META)))
> +			kiocb->private = NULL;
>  		kiocb->ki_flags |= IOCB_HIPRI;
>  		kiocb->ki_complete = io_complete_rw_iopoll;
>  		req->iopoll_completed = 0;

Why don't we just set ->private generically earlier, eg like we do for
the ki_flags, rather than have it be a branch in here?

> @@ -853,7 +892,8 @@ static int __io_read(struct io_kiocb *req, unsigned int issue_flags)
>  	} else if (ret == -EIOCBQUEUED) {
>  		return IOU_ISSUE_SKIP_COMPLETE;
>  	} else if (ret == req->cqe.res || ret <= 0 || !force_nonblock ||
> -		   (req->flags & REQ_F_NOWAIT) || !need_complete_io(req)) {
> +		   (req->flags & REQ_F_NOWAIT) || !need_complete_io(req) ||
> +		   (kiocb->ki_flags & IOCB_USE_META)) {
>  		/* read all, failed, already did sync or don't want to retry */
>  		goto done;
>  	}

Would it be cleaner to stuff that IOCB_USE_META check in
need_complete_io(), as that would closer seem to describe why that check
is there in the first place? With a comment.

> @@ -864,6 +904,12 @@ static int __io_read(struct io_kiocb *req, unsigned int issue_flags)
>  	 * manually if we need to.
>  	 */
>  	iov_iter_restore(&io->iter, &io->iter_state);
> +	if (unlikely(kiocb->ki_flags & IOCB_USE_META)) {
> +		/* don't handle partial completion for read + meta */
> +		if (ret > 0)
> +			goto done;
> +		iov_iter_restore(&io->meta.iter, &io->iter_meta_state);
> +	}

Also seems a bit odd why we need this check here, surely if this is
needed other "don't do retry IOs" conditions would be the same?

> @@ -1053,7 +1099,8 @@ int io_write(struct io_kiocb *req, unsigned int issue_flags)
>  		if (ret2 == -EAGAIN && (req->ctx->flags & IORING_SETUP_IOPOLL))
>  			goto ret_eagain;
>  
> -		if (ret2 != req->cqe.res && ret2 >= 0 && need_complete_io(req)) {
> +		if (ret2 != req->cqe.res && ret2 >= 0 && need_complete_io(req)
> +				&& !(kiocb->ki_flags & IOCB_USE_META)) {
>  			trace_io_uring_short_write(req->ctx, kiocb->ki_pos - ret2,
>  						req->cqe.res, ret2);

Same here. Would be nice to integrate this a bit nicer rather than have
a bunch of "oh we also need this extra check here" conditions.

> @@ -1074,12 +1121,33 @@ int io_write(struct io_kiocb *req, unsigned int issue_flags)
>  	} else {
>  ret_eagain:
>  		iov_iter_restore(&io->iter, &io->iter_state);
> +		if (unlikely(kiocb->ki_flags & IOCB_USE_META))
> +			iov_iter_restore(&io->meta.iter, &io->iter_meta_state);
>  		if (kiocb->ki_flags & IOCB_WRITE)
>  			io_req_end_write(req);
>  		return -EAGAIN;
>  	}
>  }

Same question here on the (now) conditional restore.

> +int io_rw_meta(struct io_kiocb *req, unsigned int issue_flags)
> +{
> +	struct io_rw *rw = io_kiocb_to_cmd(req, struct io_rw);
> +	struct io_async_rw *io = req->async_data;
> +	struct kiocb *kiocb = &rw->kiocb;
> +	int ret;
> +
> +	if (!(req->file->f_flags & O_DIRECT))
> +		return -EOPNOTSUPP;

Why isn't this just caught at init time when IOCB_DIRECT is checked?

> +	kiocb->private = &io->meta;
> +	if (req->opcode == IORING_OP_READ_META)
> +		ret = io_read(req, issue_flags);
> +	else
> +		ret = io_write(req, issue_flags);
> +
> +	return ret;
> +}

kiocb->private is a bit of an odd beast, and ownership isn't clear at
all. It would make the most sense if the owner of the kiocb (eg io_uring
in this case) owned it, but take a look at eg ocfs2 and see what they do
with it... I think this would blow up as a result.

Outside of that, and with the O_DIRECT thing check fixed, this should
just be two separate functions, one for read and one for write.

-- 
Jens Axboe



