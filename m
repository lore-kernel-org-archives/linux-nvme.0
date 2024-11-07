Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE419D29FBC
	for <linux-nvme@archiver.kernel.org>; Thu,  7 Nov 2024 02:16:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=M5VEXH/UjVZxKSBS42OsN1z+40kpn9n52otycPhBNjg=; b=u+7I4g8KUQexzrs4Z0rNKrhSOH
	lNGK8SDcNRiBGkv+4aCDUDbU/uaTt3MyNF8sB7wHWYZEutO65Xs1z/a30X4x/8djV7G2B6BIUmKov
	8p7FscW/ONFNGOiHpntUsEpsDYmGifhcK8+LW4TAiEsiXWM0Ba5ti6ENHj0dEajQXnK4UD4Bh36Ls
	jIBl+QVhgHOR6d2m390TxE4rWjeLiSGJWyrqIhbZi4MD664go5I39pduCE8Hp3EqY/56DDcNZnrm2
	RH0aj6X7S+kldx/PfDYnx3kKRWKhUeSI8dKICSmA2u8OLdkmAWBC3gltp5dfLKDImortqnxYHtASM
	D8stTckg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t8s4o-00000005R33-0S2G;
	Thu, 07 Nov 2024 02:16:50 +0000
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t8ry9-00000005Ppq-0h1P
	for linux-nvme@lists.infradead.org;
	Thu, 07 Nov 2024 02:10:00 +0000
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-71e953f4e7cso297190b3a.3
        for <linux-nvme@lists.infradead.org>; Wed, 06 Nov 2024 18:09:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1730945395; x=1731550195; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=M5VEXH/UjVZxKSBS42OsN1z+40kpn9n52otycPhBNjg=;
        b=up2l//WEhkPIX+wWZedW2YYMUzSCvjMFO1MKqN4HHsRSvvE+ept081MSPd9h+U+GM0
         vO785WhbgpkAVRHSAMkTceVb1y5OBsJEqmudsEzyusgl1o9R98H6byGvZuxS5MDLLrn5
         Jckri1acNKOT5g+3TolNlNV1nBKfhx1ZCfw/qSd7SWgbdK2mst3P4BrbXMai3rLtqGHL
         AOYT6ma98pSRFdqrPIlBE/PfPVulIkJHNp93N1FqovrSjUtPCc0diETWtcgPGBMatHOs
         gPRP//SpVikoqspj5rhbU2xCrunh9Re9z9sT8UH6o+hMjLs6NaN+OFUTUmAXQJb3YdEw
         EFJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730945395; x=1731550195;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=M5VEXH/UjVZxKSBS42OsN1z+40kpn9n52otycPhBNjg=;
        b=btRLg3sLdJ4aDxvrkN7n9fpbeJgijLbhp+pLmNmSFeBMSLsHH7q/M1ffm2NqJK2JkM
         /AbnJrWmCF0b73WcLWFeKhh3mbl1eEgbyLmdOBlvaX2AaYv/9fxTYw20WICTDiBA9U7R
         5ePyQfSodRlWw4Qijkw8+IBDeR0a6yy895Vj0GVN9Pz/JcDs31xyffMi2Jbq95btG3w8
         0u6WOP+NjeRWe3XMIRLBPovrDGavKwb0XPQcjFm+IawLe6miTfurPT5HkCon72oyrA4u
         v66FOiGRw9GMHo/PCX00IujE2wnGM6F0uNqluVoX9Tm2pVzjeO9Y/yhPlnC//dAxS36D
         BpLQ==
X-Forwarded-Encrypted: i=1; AJvYcCUWn2Bg54VgP3ODUdvkSM/Vs4IIqYvOMbogO0HiN7yFnLzHTVFTGjGA5tbE/B57bta4Tc8NSItXmJv4@lists.infradead.org
X-Gm-Message-State: AOJu0YxKZ8L28sPB05sMYVe4pQyC+8aWYth9j5jM++GS0KnvWwSplSeS
	AVredS+OPhEaZGD2dqT6JCzQROdpy1hsT5lvAtQnjXhkEdibsqLf9M8W3PTznCnLvWpHSLv4kJi
	i3QI=
X-Google-Smtp-Source: AGHT+IE4FdVcCFM7JfMcQ3SKmd1UC6mzCGq6q6jfwTYIDNNfVDV6mTuEsMVwx/N+IlnX034mAbpOSg==
X-Received: by 2002:a05:6a00:170d:b0:71e:1314:899a with SMTP id d2e1a72fcca58-720c998d8b9mr30360940b3a.20.1730945395467;
        Wed, 06 Nov 2024 18:09:55 -0800 (PST)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72407a50512sm256626b3a.173.2024.11.06.18.09.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Nov 2024 18:09:54 -0800 (PST)
Message-ID: <e757bfa0-0c21-41d6-a072-ce85f4ea8a04@kernel.dk>
Date: Wed, 6 Nov 2024 19:09:53 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv10 6/9] io_uring: enable per-io hinting capability
To: Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org,
 io-uring@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org, hch@lst.de, joshi.k@samsung.com,
 javier.gonz@samsung.com, bvanassche@acm.org,
 Nitesh Shetty <nj.shetty@samsung.com>, Keith Busch <kbusch@kernel.org>
References: <20241029151922.459139-1-kbusch@meta.com>
 <20241029151922.459139-7-kbusch@meta.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20241029151922.459139-7-kbusch@meta.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241106_180957_534380_8C8531D6 
X-CRM114-Status: GOOD (  13.07  )
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

On 10/29/24 9:19 AM, Keith Busch wrote:
> diff --git a/include/uapi/linux/io_uring.h b/include/uapi/linux/io_uring.h
> index 0247452837830..6e1985d3b306c 100644
> --- a/include/uapi/linux/io_uring.h
> +++ b/include/uapi/linux/io_uring.h
> @@ -92,6 +92,10 @@ struct io_uring_sqe {
>  			__u16	addr_len;
>  			__u16	__pad3[1];
>  		};
> +		struct {
> +			__u16	write_hint;
> +			__u16	__pad4[1];
> +		};

Might make more sense to have this overlap further down, with the
passthrough command. That'd put it solidly out of anything that isn't
passthrough or needs addr3.

> diff --git a/io_uring/rw.c b/io_uring/rw.c
> index 7ce1cbc048faf..b5dea58356d93 100644
> --- a/io_uring/rw.c
> +++ b/io_uring/rw.c
> @@ -279,7 +279,8 @@ static int io_prep_rw(struct io_kiocb *req, const struct io_uring_sqe *sqe,
>  		rw->kiocb.ki_ioprio = get_current_ioprio();
>  	}
>  	rw->kiocb.dio_complete = NULL;
> -
> +	if (ddir == ITER_SOURCE)
> +		rw->kiocb.ki_write_hint = READ_ONCE(sqe->write_hint);
>  	rw->addr = READ_ONCE(sqe->addr);
>  	rw->len = READ_ONCE(sqe->len);
>  	rw->flags = READ_ONCE(sqe->rw_flags);

Can't we just read it unconditionally? I know it's a write hint, hence
why checking for ITER_SOURCE, but if we can just set it regardless, then
we don't need to branch around that.

-- 
Jens Axboe

