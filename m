Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22A54CCA490
	for <linux-nvme@archiver.kernel.org>; Sun, 18 Oct 2026 22:06:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=OlFIPIWO5LZ2jnM7OrB0Ju5d/51OdDrnxk5mdcIulF8=; b=kJm+0avD9wGPXY1jLgDP95j9I1
	1yqcGzihvaKJMS2DK+7eqi3svC2XkFYZc3BZBoNa3O3F6z6y6j6/A2h3ZISjSDDGKCAdrB9mUhfCs
	08K/MxanWhdK5SNpigfPfMIjbqvOykLxJFWB7UwFyEKsaxuaMmS+jGCc7Ret6zMiTTZqTJDZmsJfe
	FA4IgO0uUja/UscMtqBVMlUpb+y7wuZv3gvEBGBQMavTYqX52jtHqbVAiwrl7rEuZHo8rAjZ73S3u
	UaeOcssq7uLZS46tNo3Ax4FWLZEObXc+qm8cKAt7qCNz+9fqzkYj5RQPVANtm25hYQuBhDUHYeu5N
	qaSFwMmQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xIZ1P-00000006GGu-0GYs;
	Sun, 18 Oct 2026 22:06:27 +0000
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xIZ1K-00000006GGZ-2f2Q
	for linux-nvme@lists.infradead.org;
	Sun, 18 Oct 2026 22:06:24 +0000
Received: by mail-wr1-x42f.google.com with SMTP id ffacd0b85a97d-48bbb06e746so628729f8f.3
        for <linux-nvme@lists.infradead.org>; Sun, 18 Oct 2026 15:06:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792361180; x=1792965980; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OlFIPIWO5LZ2jnM7OrB0Ju5d/51OdDrnxk5mdcIulF8=;
        b=UIq0O1G8ns0+NccQcHPt2TvY+YFgv0NTVfdeF7IUqhS2CyH0GcSMsDowm1rm2nI4uL
         UgG16lSI2V7uSZG9efPH+WSdEFFzCo+irirf1687RGhVwwcMkNOhz5xUDK08Skae6JCe
         Yf4YVoAF1e5/BwmVaG/c0E7qbubFzE2hIh4FgIEmS2+hmmAagDe2iMeIH8kwQfDJLAoi
         JwOmuRENojaPX2qJCILqWCPq2GxdqiEnwRRcFLb6j5hCAk88Ta967rtzrXQYgAzvktP5
         aoXZtpNwVlWmSAx/30OdwYuePdYa5cDEGLRJukId/kRJOTD8l220JFu28dok77tjuk3q
         Wkeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792361180; x=1792965980;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OlFIPIWO5LZ2jnM7OrB0Ju5d/51OdDrnxk5mdcIulF8=;
        b=w8kBjwhTFVTErZiNf19waBEj7QJRR/2Iu/qn2dRnZVN6MnO3fjLn1efQJ8oPWGWywt
         BsMASpi6r5oQ7KFT69XIYuxEOxJbIvq8V+WNSghqihxh4WFHXXq0gmiJRQBqWcyOleNw
         84PxidkSyb+j9r6mdpmzDqn2dvW+OsjD2gvi8XTpQgOWE1giuTEM71ZNLBPxk6NUYHFk
         evG/v5CRhwI4dB//0wgkjCBGHnU3jjEohnWFGRYEQ6mthlLrwUHkxQro8YMNp3Cn39Dt
         k1x4s6JXjd9XJhPFVPei2nukct6XnHnw5HCPjW6KVXqiQRCmqVTgFhf7pJNszXptwxsb
         qEBQ==
X-Forwarded-Encrypted: i=1; AKwUvBwmVgtr8SRhwIoBx7gvdsNtFf8QHKnZtiEyfyP91wulGe2KVRwfU8fl2rG/AZbY9O4UBjyGuPfQJqZi@lists.infradead.org
X-Gm-Message-State: AFq9FYLmeneS+Z1VxfhUw5BS6EMFcLdgo+f4IMcuSyS8aWQp48jZfKrX
	38S9imBLcG1h/YNDv7d1xYUFdxCmBglWIuQwXBSicFY7t98PAn2h1hjE
X-Gm-Gg: AYBFou0yyQimhR1adLNSTXR4PCEmuhH+vxgRaCJhAUGorG+VLum+naSRj03MBw9HGsT
	1teTMva9BqQd3pwatEAg8wpZGH9BsA7Sjp4SWi7K6yIkP6DwEjb4a1DFc5jDeSVNMWN9g1UnWoe
	4fJShj/tfoUzj7sdSh9uxarQfFdW1PkUUfm0bhYN2KR1ubRpD55ANKJ/3giOXOh0/9YcZLe/rdI
	FgE/LsJrDZIYTbkTscIo2an7rzysyPIVIjrBVGrJ7DrqwQ3wyggWzWoQ9HXKajPjMcQ/Y2rqg5t
	SMTndlobkHhDuipSIBC+tQgjPHhWl+fjXWQ3qxFPQItWXkdQpve9sG+aGKY7p156HonzuxAJYoV
	V9WFzIRLf6tXqR1YKiEVKhOTgGK1zG1HASzu4wRxGut6koUNsM92mmRBR8EpwNhag+4fZGEGF9i
	xaeK+0Gf9+TaueL/eF2lxLRNmYQLa4A6ZxCv3JktgaNy3FTfFnHgaXfyR5IvRX0sMB+1aTD3eZC
	homfVKw7q0vqVH/ldWGa0p2jQfnClbUTf384XTSmA2dlpRCGGJj0Dn1uz9INAwlyCuW9PKIl7Lw
	rT1mLHgUCOlckgOAPEQAC5Daq08jcbL7Iab6JQ5ZuR1N/DqP
X-Received: by 2002:a05:600c:3b23:b0:4a1:cd83:b240 with SMTP id 5b1f17b1804b1-4a1d75ab20bmr158328355e9.1.1792361180038;
        Sun, 18 Oct 2026 15:06:20 -0700 (PDT)
Received: from ?IPV6:2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c? ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1cf05009csm199694925e9.10.2026.10.18.15.06.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 18 Oct 2026 15:06:19 -0700 (PDT)
Message-ID: <79627452-98d3-4e8d-9c37-ceda0796d59c@gmail.com>
Date: Sun, 18 Oct 2026 23:06:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme/io_uring: enable dma-buf backed passthrough I/O
To: Anuj Gupta <anuj1072538@gmail.com>, kbusch@kernel.org, hch@lst.de,
 sagi@grimberg.me, axboe@kernel.dk
Cc: joshi.k@samsung.com, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, io-uring@vger.kernel.org,
 Anuj Gupta <anuj20.g@samsung.com>
References: <20261016103453.1129150-1-anuj1072538@gmail.com>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <20261016103453.1129150-1-anuj1072538@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261018_150622_696324_C8A9218C 
X-CRM114-Status: GOOD (  14.87  )
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

On 10/16/26 11:34, Anuj Gupta wrote:
> From: Anuj Gupta <anuj20.g@samsung.com>
...>   static void nvme_add_ns_cdev(struct nvme_ns *ns)
> diff --git a/drivers/nvme/host/ioctl.c b/drivers/nvme/host/ioctl.c
> index 3aa5d2f2dfbb..6343da1f6c05 100644
> --- a/drivers/nvme/host/ioctl.c
> +++ b/drivers/nvme/host/ioctl.c
> @@ -458,6 +458,7 @@ static enum rq_end_io_ret nvme_uring_cmd_end_io(struct request *req,
>   			status = blk_status_to_errno(err);
>   	}
>   	io_uring_cmd_set_res32(ioucmd, status, result);
> +	io_uring_cmd_detach_dmabuf(ioucmd);

It's not great spilling the responsibility for [de,a]ttaching
between nvme and uring_cmd code. Is there a way to stash it
all under io_uring?

...> @@ -275,11 +284,16 @@ int io_uring_cmd_import_fixed(u64 ubuf, unsigned long len, int rw,
>   			      unsigned int issue_flags)
>   {
>   	struct io_kiocb *req = cmd_to_io_kiocb(ioucmd);
> +	int ret;
>   
>   	if (WARN_ON_ONCE(!(ioucmd->flags & IORING_URING_CMD_FIXED)))
>   		return -EINVAL;
>   
> -	return io_import_reg_buf(req, iter, ubuf, len, rw, issue_flags);
> +	ret = __io_import_reg_buf(req, iter, ubuf, len, rw, issue_flags,
> +				  IO_REGBUF_IMPORT_ALLOW_DMABUF);
> +	if (ret)
> +		return ret;

Let's explicitly pass a flag allowing to import dma-buf from
nvme / other commands. It'd be feeble otherwise. We can create
a dma-buf for a block file now, imagine someone adds a command
for those that also uses registered buffers but doesn't expect
dma-buf.

> +	return io_attach_dmabuf_map(req, iter, issue_flags);
>   }
>   EXPORT_SYMBOL_GPL(io_uring_cmd_import_fixed);
>   

-- 
Pavel Begunkov


