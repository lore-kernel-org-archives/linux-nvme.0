Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2971FC54E58
	for <linux-nvme@archiver.kernel.org>; Fri,  8 Mar 2024 17:37:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=eVfdzVKpWpFj9kbUNOF1nqFeLYyQI1R525d/19YRQ4U=; b=aZv/Fc3P9yTG37bFghM7Heee4c
	BKZIhnaCEJZiTrr3DCoAdVK9pU4JNPIKoL+Wlbpp24EfL+uiE/o8RWeb6kvsjui23FLIxYfUwEOEb
	jihS4sLNTFbO35M7lEExUmAsvrSfXKYu7nTqgfgBC3KOz2kcHlR6YgUzPzTRAEBxAh2s4dL+NuE67
	DISSpFD7glr9GxTBxAbWv0qP1A/O0hKo1RhSj0GJs7U1zb1uSXYZDGjzFEiScpZOw4iMQb8IrfM6+
	b5hqPje/A9rW98JrBEXTf22l0E9SXibReimy6RI75fxhPM28gI5ZP2NMlNgYNsjooBgFU96WzQ5gn
	QlThsTOg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rie9Q-0000000AYRH-0cb6;
	Fri, 08 Mar 2024 17:36:56 +0000
Received: from mail-io1-xd2e.google.com ([2607:f8b0:4864:20::d2e])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1ridB4-0000000ADSi-0qHV
	for linux-nvme@lists.infradead.org;
	Fri, 08 Mar 2024 16:34:35 +0000
Received: by mail-io1-xd2e.google.com with SMTP id ca18e2360f4ac-7c7ee5e2f59so13491039f.1
        for <linux-nvme@lists.infradead.org>; Fri, 08 Mar 2024 08:34:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1709915670; x=1710520470; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eVfdzVKpWpFj9kbUNOF1nqFeLYyQI1R525d/19YRQ4U=;
        b=XG3zxIusl9oeaCwhagRzlCop9lwIraeztdJiFSPNq4u3JWSIOI4IrjC/LUJmH1D9Nb
         Tkzhi3fhRbaWkPAqkcUNyvb5jQOQ3HZSiu+7uGlAJaaDj+jhfL4f/0RdfvEsD4R/vHQ7
         dEO4UmiozUs9aR+AIfbdRupMcXRU19EdSGbNVJmmr3sq9O1f6qTPZSQaeglH1Pi4Tu91
         Rxe9XP7gxvmbfMaTFJD29YKHM4p2cSdFzrf47HaGKNRaQifVsCeKtFWjBg8/nXhsar7/
         MnuJEmcq8cCFiQPUqVv3KLdzVWQksef/MjeTh6ebAbyRqibAbM6RXNywsIUVPiECJA/S
         QBsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709915670; x=1710520470;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eVfdzVKpWpFj9kbUNOF1nqFeLYyQI1R525d/19YRQ4U=;
        b=nRMdfhLvwvTDPT0cfrmSxEI5vEYV4bAArBQntInLUgNnv8NPqDz59T1w94cwVnnxRS
         DBrUWWPISHhesEKFdifCKr53/HqFtWjDqdCYWF7r/6XVQVa4bKGcmzQB62almFFW4L/U
         es2G1iTPWxt6h8AD9Vf/UdXwjvbStK1SQqUkBlYr93rsRD13moKZbbpt9IDgnl4bnO5J
         ChxMnP60uyOAk3JNZu5v4tvDGv7W8Rh9yCh+SBzPcjQQ9gK1DQCSWGPuvUw7qFFK7z1+
         cGJMbIHBf1cPumi+lkF6XzbWqMtsaRtcK26G4KcP5EG9pJI1N33Zt+dy/48mo7pgmUdd
         LOcA==
X-Forwarded-Encrypted: i=1; AJvYcCVVBFlndGv7lo7zcCFvbptTQzSuPehIHT2+Sw4Ob56AQ06T3UMidnlDSHTJHePvIpX+OevJqpbBIHsvW+7Ez2ZDMZ7otA2b8aG424MAi4M=
X-Gm-Message-State: AOJu0Yw8UmsS3fCozkXaa5PXn1wSnzDNzWI1wG+atC5AUmkFxxsXhva/
	XA159TLU6nPZdBtTTloaUNTUzdHXn1A1GvdgrkaKQcQcmpH6JHPUon0RhW9iAwg=
X-Google-Smtp-Source: AGHT+IGHrfD8uH6blQDQ3mMFkxIIRnaWM2NuWN/1meHvgLTE8CRbEPUrNlq2AATapXrEb2fcNbN9CA==
X-Received: by 2002:a6b:ee16:0:b0:7c8:718b:cff5 with SMTP id i22-20020a6bee16000000b007c8718bcff5mr2506789ioh.2.1709915670463;
        Fri, 08 Mar 2024 08:34:30 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id b5-20020a029a05000000b00474dad114a6sm3654084jal.80.2024.03.08.08.34.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Mar 2024 08:34:29 -0800 (PST)
Message-ID: <1f68ab8c-e8c2-4669-a59a-65a645e568a3@kernel.dk>
Date: Fri, 8 Mar 2024 09:34:28 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 03/10] fs: Initial atomic write support
Content-Language: en-US
To: John Garry <john.g.garry@oracle.com>, kbusch@kernel.org, hch@lst.de,
 sagi@grimberg.me, jejb@linux.ibm.com, martin.petersen@oracle.com,
 djwong@kernel.org, viro@zeniv.linux.org.uk, brauner@kernel.org,
 dchinner@redhat.com, jack@suse.cz
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org,
 tytso@mit.edu, jbongio@google.com, linux-scsi@vger.kernel.org,
 ojaswin@linux.ibm.com, linux-aio@kvack.org, linux-btrfs@vger.kernel.org,
 io-uring@vger.kernel.org, nilay@linux.ibm.com, ritesh.list@gmail.com,
 Prasad Singamsetty <prasad.singamsetty@oracle.com>
References: <20240226173612.1478858-1-john.g.garry@oracle.com>
 <20240226173612.1478858-4-john.g.garry@oracle.com>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20240226173612.1478858-4-john.g.garry@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240308_083434_323650_762ADE35 
X-CRM114-Status: GOOD (  11.16  )
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

On 2/26/24 10:36 AM, John Garry wrote:
> diff --git a/io_uring/rw.c b/io_uring/rw.c
> index d5e79d9bdc71..099dda3ff151 100644
> --- a/io_uring/rw.c
> +++ b/io_uring/rw.c
> @@ -719,7 +719,7 @@ static int io_rw_init_file(struct io_kiocb *req, fmode_t mode)
>  	struct kiocb *kiocb = &rw->kiocb;
>  	struct io_ring_ctx *ctx = req->ctx;
>  	struct file *file = req->file;
> -	int ret;
> +	int ret, rw_type = (mode == FMODE_WRITE) ? WRITE : READ;
>  
>  	if (unlikely(!file || !(file->f_mode & mode)))
>  		return -EBADF;
> @@ -728,7 +728,7 @@ static int io_rw_init_file(struct io_kiocb *req, fmode_t mode)
>  		req->flags |= io_file_get_flags(file);
>  
>  	kiocb->ki_flags = file->f_iocb_flags;
> -	ret = kiocb_set_rw_flags(kiocb, rw->flags);
> +	ret = kiocb_set_rw_flags(kiocb, rw->flags, rw_type);
>  	if (unlikely(ret))
>  		return ret;
>  	kiocb->ki_flags |= IOCB_ALLOC_CACHE;

Not sure why you took the lazy way out here rather than just pass it in,
now there's another branhc in the hot path. NAK.

-- 
Jens Axboe


