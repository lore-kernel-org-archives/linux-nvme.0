Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31222C021B3
	for <linux-nvme@archiver.kernel.org>; Fri, 21 Feb 2025 00:55:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=r2QATB96FgepA0rjENrkG3iJn8Amj5leXDUOJcZKkX4=; b=UYWhWABDXBi77D3DMlIRRZ0iEw
	bGwGj0nqdiNP0m62j+q+3EXdO5KZV9xl0h7E3m7nq6CScusvOLpEgJX7yI7YJ2Qz6dK7JNOj1jy04
	LhM2F2SUuJARHk46RpsW1xYZ+XUIRnU0ZpDBirbRM3xEWDUTyx64/Cp3xScr+lhvRptDIBZOwwJQz
	Aaz+xj8oCSFquu7fLasmQYT6peggpIbgmBMv9NlEMw6J3ghEtL+XMsHYSOdd8FPMIJaMmxlQ20Hnp
	JrZs+eQqIsd6rqgzvpmQY1k5BSTXwIXXtQIDA5F6F8AFFXw6YorlXnX7KmbhADC+NKabSkZ67AQ8o
	qYphcWkw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tlHJs-00000003ZaK-1vg4;
	Fri, 21 Feb 2025 00:55:08 +0000
Received: from mail-io1-xd33.google.com ([2607:f8b0:4864:20::d33])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tlHJp-00000003ZYs-2t1g
	for linux-nvme@lists.infradead.org;
	Fri, 21 Feb 2025 00:55:07 +0000
Received: by mail-io1-xd33.google.com with SMTP id ca18e2360f4ac-855a7e3be0eso41327539f.1
        for <linux-nvme@lists.infradead.org>; Thu, 20 Feb 2025 16:55:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1740099304; x=1740704104; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=r2QATB96FgepA0rjENrkG3iJn8Amj5leXDUOJcZKkX4=;
        b=2iHlHeh0lBmSCTs+U7HM4fdT9dziLo/TK1vTs00fokX2Ui+cURhf/gqYKDVL2gW0pg
         9LsKBp8DCOx97OfongBPOmdht6VyhcwdPL6vsrkDzwGoh1Kul3pNsc8vxYCSkxQEnBhw
         UvhdmkYJodJh8ASXO2HUfZGfPxsx4+90wNhnJcnIa6xyX/nXG70OlaBVL+D9e5Oz+40Z
         MY266FL6sP0p/oS5ZvCe+IevWyaZKORh5kK0sttqkZfMYGNGcPCqD+No9F1akUXfk71D
         PjEUD2Pr9Mc6MU/0xs+RRVEowIFzCJhxT/clEvK1ygz+PkRZ/ckA7x0Nqtm5qbvH33zL
         xw1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740099304; x=1740704104;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=r2QATB96FgepA0rjENrkG3iJn8Amj5leXDUOJcZKkX4=;
        b=ta2NHpm7EtWrPonB1DQqoPubWpvoq87ysEysiG6bQL28OwhYJRGjq0HCuJif3ouiKc
         xmudslHHS5ExN2WbnONvdMkdDtdi7vfZy7yfv72RmigwIvoLH6b+5ahVmrycDoNpJLOc
         5krBFO33FfLMlWcsU5J0nBSpX9Ztl5+E3Z3qHtNzJ9x7n/mImix8lymOe/ZAH7kKdsqt
         8gZrSwGELHZUY9jREhVRgerAY0IF89UJImeIpE4OGyXmDN5XXewEAmb4ukfw9l3llvQT
         C4bV9Wj9mNQjUZGMWs7NKodTiJpLBDc509ciTKlBDu5TyBdDtSzL45mDtN5mBZrZVkFn
         XfnQ==
X-Forwarded-Encrypted: i=1; AJvYcCWuAoLOny/4Zak5w8YVAKZoFY4n883sr4CkFyCzOQERETIilBc6o9NLzg2F2UI+vddIm855V6KQiAYJ@lists.infradead.org
X-Gm-Message-State: AOJu0Yx5RceM8y9vHNdlXGFYT5fueTwJoIH55tQwABqLCT0kUwmqCv1Y
	7JKSYnJ4vsCDO4H4DTqUHZ/+m0ALC+Rrei95XKWEKlW7JmkYtHPNSvSoTvMXHQ4=
X-Gm-Gg: ASbGnctKtZFuUAW7Qs7w+hojRSBgc5B9m+siSxYmojyVpx5BvtvPneiuuBxoJR/BUFV
	VBdzTf/kF6+lh8U0fPIoZ/RzgF00w8jtoe13nlBTu5rSspGjrRKJxCROIZ4k8QX+w7VX738cSaJ
	p/QHzR10/EJ8qfgVi7DfIjtHtZqbVnWx+p3+sl1oTHmeeHOtrMVbgx0ZqBMf0OHOKofj8EKa6+J
	OMrtAgeUbxrDYi5sFnnyeT8/QS8p/3tRxZ2FprmFTAJBq743B8oVaEk8lZ+8o6gIBx55Wo5ZV3P
	tu8xmhkSyETE
X-Google-Smtp-Source: AGHT+IEhwogP4yqzKlQCfCn6+V0oLpiZEIwarJ9K61JUTvJMx8CWnF/dcOiMl/AbHQVu7yQM6cO39Q==
X-Received: by 2002:a05:6e02:2413:b0:3d0:ca2:156d with SMTP id e9e14a558f8ab-3d2caf04813mr12139375ab.14.1740099304667;
        Thu, 20 Feb 2025 16:55:04 -0800 (PST)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3d2a9fc622esm16071025ab.67.2025.02.20.16.55.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Feb 2025 16:55:02 -0800 (PST)
Message-ID: <0a11a42f-3476-46bd-b87a-a72d68344802@kernel.dk>
Date: Thu, 20 Feb 2025 17:55:01 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme: map uring_cmd data even if address is 0
To: Xinyu Zhang <xizhang@purestorage.com>, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org
Cc: Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>,
 Caleb Sander Mateos <csander@purestorage.com>
References: <20250220235101.119852-1-xizhang@purestorage.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20250220235101.119852-1-xizhang@purestorage.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250220_165505_729732_49C14F14 
X-CRM114-Status: GOOD (  19.84  )
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

On 2/20/25 4:51 PM, Xinyu Zhang wrote:
> When using kernel registered bvec fixed buffers, the "address" is
> actually the offset into the bvec rather than userspace address.
> Therefore it can be 0.
> We can skip checking whether the address is NULL before mapping
> uring_cmd data. Bad userspace address will be handled properly later when
> the user buffer is imported.
> With this patch, we will be able to use the kernel registered bvec fixed
> buffers in io_uring NVMe passthru with ublk zero-copy support in
> https://lore.kernel.org/io-uring/20250218224229.837848-1-kbusch@meta.com/T/#u.
> 
> Signed-off-by: Xinyu Zhang <xizhang@purestorage.com>
> Reviewed-by: Caleb Sander Mateos <csander@purestorage.com>
> ---
>  drivers/nvme/host/ioctl.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/host/ioctl.c b/drivers/nvme/host/ioctl.c
> index 60383da86feda..724ab542b4c33 100644
> --- a/drivers/nvme/host/ioctl.c
> +++ b/drivers/nvme/host/ioctl.c
> @@ -500,7 +500,7 @@ static int nvme_uring_cmd_io(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
>  		return PTR_ERR(req);
>  	req->timeout = d.timeout_ms ? msecs_to_jiffies(d.timeout_ms) : 0;
>  
> -	if (d.addr && d.data_len) {
> +	if (d.data_len) {
>  		ret = nvme_map_user_request(req, d.addr,
>  			d.data_len, nvme_to_user_ptr(d.metadata),
>  			d.metadata_len, 0, ioucmd, vec);

Looks good to me:

Reviewed-by: Jens Axboe <axboe@kernel.dk>

-- 
Jens Axboe


