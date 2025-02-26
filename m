Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D328C021B8
	for <linux-nvme@archiver.kernel.org>; Wed, 26 Feb 2025 18:40:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=symdU9EMvj/OBJzqzheNQbsiM+qkoxN4bra1Wzcsq1I=; b=JFYBp4n4ojfaCue7GJdqREJPOJ
	puxs/ueAejQQPycKEz7c1NUWPXmU3q7AQvhN+HMf8YD28vKozlRbWqxTcjg/7HykrKc+4yx5MZi/z
	XFaE/LvEnJOW2aHro2QNCfQEFuozjWoIpphW1Fhs6BjZ38+a8Jgz3Gdn4nVHmSH4LhShly5geYNy5
	e9mcD4zlD0ULaE1awU1ocgVb74ALMX0g7J4V6syPTDN0pj7qn1dfc2ZP7YoLl74l+9Pkl69+RtAkm
	qZDg5D89g0mv5tJ93iK70xfmIBV5eZw2peJ1fCgTsyhY6bwVVzqgen9jEwCKRBwk6BMZ45ItOz3J0
	f5HYyemg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tnMKd-00000004zFt-1iCL;
	Wed, 26 Feb 2025 18:40:31 +0000
Received: from mail-io1-xd30.google.com ([2607:f8b0:4864:20::d30])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tnMKZ-00000004zF5-45TH
	for linux-nvme@lists.infradead.org;
	Wed, 26 Feb 2025 18:40:29 +0000
Received: by mail-io1-xd30.google.com with SMTP id ca18e2360f4ac-855b3e42c5bso3106739f.3
        for <linux-nvme@lists.infradead.org>; Wed, 26 Feb 2025 10:40:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1740595227; x=1741200027; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=symdU9EMvj/OBJzqzheNQbsiM+qkoxN4bra1Wzcsq1I=;
        b=M2wKGDCAb096e/evaMzDYuzS0Om1p9B6A4JcAKgZ/+LMrJnRM8g7yBmn/2UrX7O7dW
         bMTTBD94mUVgqmV4zmCqfvlyAwbPAlY1+sVL9gLxuXcVpH+JM5qgMaYXW4PbZ438dTAg
         /E51HSu+vR+651XN/Zaf/Rsbjboqsn4LyZGThBvp46TbkYjEbSFYUdRNnyM/0Gp57F6A
         ZhJyumYp9i01dwgxoIi/MXfvzvnlBLPJ1FPUp8QUPs1W3yW0hEQ/kUOG3u22nzzxVa0M
         n5auyIImHCtDwUVoRpGnKDc3IRHcAZqA60XxJBAGuhEEfi6bgqUM0WfMLjTyGBY2DX7P
         8eoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740595227; x=1741200027;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=symdU9EMvj/OBJzqzheNQbsiM+qkoxN4bra1Wzcsq1I=;
        b=UlLD4qL/D6qXIjsr4t4XiDOZVbrsDWbetLUHgj+lVo41SSBB7U/Jra9cEcPPbPZT6V
         tJATTNJzIwmI6T7CH3yP5fVicrcvlrKKVZFKiLEVxGx0RaH8PoCJQwY5VZH8SZqQ4C6k
         ElvhUL1OwNsKbKvSEGvmLJicYLr2juR1u6mBtXzvmJDjotTPsSyKOC5BRlGWiOqvt3vV
         T9Ys0EUUMl/yxYPAQczyBERS/l5OB9nSytRf6tSAH5kJ6gK7zUuLan5a/Lvst6CvH9YZ
         EMmjEfWETxv40Ci/6x08Rk83j+0UrOf0xzYV9gvN+t9Nm6zlJkUfIBCz5xJ8anJHMFYF
         qE4A==
X-Forwarded-Encrypted: i=1; AJvYcCV/HFxzwQ7e6sd+JJ1oDcqpoE+YVuG48fl8YgxiLeTDK4Oslo+CL4z64dg0jMqxllpjNHTE+b3QtBhk@lists.infradead.org
X-Gm-Message-State: AOJu0YwSTtudexr3LDTkSSu/+bTIJiWVZmOUaKAikvu5+2R/7M9CFXs7
	LE6HNGtKkuAdS8VIwZ5kT9XCkfMhIwb5NPkHYmwoPuMkolj1dan5WHo9fAFK7CY=
X-Gm-Gg: ASbGnctN9QPaQMCNYv8NecD//Y0gTIDgI9dU3xVF8au/mQteP5HeqqJEUjaS6Tet5C+
	KI+XEVPgO20UtqkSOlt6NyDNLGG6DNUjd9pbQ4FySYNWKWoOendl2geaVIoZsHFXNHJ1k7H0rwB
	f20MQIjySnieDIwJv1Ic/cDRizyefJ4eKcdKwgd7GLSOVokWOD3KQI6hKSbLXKARhRb25XpgL6d
	XyyKefjptF26QKJlAGA6k/8uyyyC9GhDSpqRkbhQgxFHT8pulf1lVdHil2QVxo7sOyNO3NHOTK2
	svD9tj6k679e3q/RJJF5aA==
X-Google-Smtp-Source: AGHT+IEcVGZxj+MZL024go/7Ek44HCywTu0ZTaoD2vxe2DtY/vJ/oJ+MqLDaGS+x97+xAMqCCyDQ4g==
X-Received: by 2002:a05:6e02:339f:b0:3d3:d23b:21f7 with SMTP id e9e14a558f8ab-3d3d23b23a8mr56142825ab.18.1740595226635;
        Wed, 26 Feb 2025 10:40:26 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f047530650sm1033139173.117.2025.02.26.10.40.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Feb 2025 10:40:26 -0800 (PST)
Message-ID: <f987f9da-4aa0-47d0-b906-8790afe6be60@kernel.dk>
Date: Wed, 26 Feb 2025 11:40:25 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv7 4/6] ublk: zc register/unregister bvec
To: Keith Busch <kbusch@meta.com>, ming.lei@redhat.com,
 asml.silence@gmail.com, linux-block@vger.kernel.org, io-uring@vger.kernel.org
Cc: bernd@bsbernd.com, csander@purestorage.com,
 linux-nvme@lists.infradead.org, Keith Busch <kbusch@kernel.org>
References: <20250226182102.2631321-1-kbusch@meta.com>
 <20250226182102.2631321-5-kbusch@meta.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20250226182102.2631321-5-kbusch@meta.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250226_104028_274228_1A4DA201 
X-CRM114-Status: GOOD (  16.98  )
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

On 2/26/25 11:20 AM, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> Provide new operations for the user to request mapping an active request
> to an io uring instance's buf_table. The user has to provide the index
> it wants to install the buffer.
> 
> A reference count is taken on the request to ensure it can't be
> completed while it is active in a ring's buf_table.

Looks pretty sane to me, just a few minor nits below where only one of
them actually is required to change.

> +static int ublk_unregister_io_buf(struct io_uring_cmd *cmd,
> +				  const struct ublksrv_io_cmd *ub_cmd,
> +				  unsigned int issue_flags)
> +{
> +	int index = (int)ub_cmd->addr;
> +
> +	io_buffer_unregister_bvec(cmd, index, issue_flags);
> +	return 0;
> +}
> +

Minor nit here too, I'd drop 'index' and just cast it in the argument.

> -static inline struct request *__ublk_check_and_get_req(struct ublk_device *ub,
> -		struct ublk_queue *ubq, int tag, size_t offset)
> -{
> -	struct request *req;
> -
> -	if (!ublk_need_req_ref(ubq))
> -		return NULL;
> -
> -	req = blk_mq_tag_to_rq(ub->tag_set.tags[ubq->q_id], tag);
> -	if (!req)
> -		return NULL;
> -
> -	if (!ublk_get_req_ref(ubq, req))
> -		return NULL;
> -
> -	if (unlikely(!blk_mq_request_started(req) || req->tag != tag))
> -		goto fail_put;
> -
> -	if (!ublk_rq_has_data(req))
> -		goto fail_put;
> -
> -	if (offset > blk_rq_bytes(req))
> -		goto fail_put;
> -
> -	return req;
> -fail_put:
> -	ublk_put_req_ref(ubq, req);
> -	return NULL;
> -}
> -

This could be a prep patch to cut down on unrelated changes, but not
really important.

> @@ -2459,7 +2507,7 @@ static int ublk_ctrl_add_dev(struct io_uring_cmd *cmd)
>  		 * buffer by pwrite() to ublk char device, which can't be
>  		 * used for unprivileged device
>  		 */
> -		if (info.flags & UBLK_F_USER_COPY)
> +		if (info.flags & UBLK_F_USER_COPY | UBLK_F_SUPPORT_ZERO_COPY)
>  			return -EINVAL;
>  	}

Missing parens here around mask.

-- 
Jens Axboe

