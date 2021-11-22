Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7D8BC433F5
	for <linux-nvme@archiver.kernel.org>; Mon, 22 Nov 2021 11:35:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
	Subject:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=fft2A7R7FYmR/9SglZY9OyiZvIBJ5N2EX3Ll9AEvGb8=; b=lXYeD7Yhi0zkB19AWHu9nj1Lti
	v2iBNE3f0Me8c9je9As7fx6ao+Bj6pwM1AWV4kuZdJVQA3z2dtn9SY5kUY9vIytVUuKdqrEsl3+fb
	MRsxHb2aWjLmR+R+BnvBEpQy4Kz0MUBULs2k7Q8fMmvm+/Ac/Fnbeh1n4ZTW0jytOp7kQYwYxFpHM
	P+LpwmTUCZZXsKv5b6CYPAg79C0KMwvn7KVNCWPY+8ieAoNvaSlmrU+rR8m8Nrv5/00DiJVTGB1Pn
	b/bU2j4XLgfCYek5y5ohsoKVKA+A6/6Ac5U7gMWqhPcDWmKeMdxWaH5OZmueBf1xWQQ+1dIvGPA7/
	E4ExPcqw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mp7bv-00G5DL-Qc; Mon, 22 Nov 2021 11:35:47 +0000
Received: from mail-wm1-f47.google.com ([209.85.128.47])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mp6SM-00Fp6j-NS
 for linux-nvme@lists.infradead.org; Mon, 22 Nov 2021 10:21:52 +0000
Received: by mail-wm1-f47.google.com with SMTP id
 ay10-20020a05600c1e0a00b0033aa12cdd33so2971446wmb.1
 for <linux-nvme@lists.infradead.org>; Mon, 22 Nov 2021 02:21:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=fft2A7R7FYmR/9SglZY9OyiZvIBJ5N2EX3Ll9AEvGb8=;
 b=QvzD+n8zxUOAGz9Wtu6TKJntcS8XZSiJumIDwqSZm8Qc45YWtvwwK6QXJix0u2s/xo
 Mq8/i6i9NlXd3+V3SnUOM76WP24u+nqup1yXizgqhZlxVqUzCrxVruroj21n9elrUa2H
 /cFOB/+/mzuHLSJKIYAI8YbTEvKnnSvrcCoxosPTsjTP/5Ixhx8NYvIOre1hW6Hk35/H
 AXb4cl57HyTi5GCGj+J+8oDmVO6fM4XwIOyL2LgE8fBRHWx+Xaim2JeZxcM659cJLw+8
 tNJE487vFE0CFiPOm8dFvsM5JD71va3q2cXevaxJWHwVGU/P1pCFP08dGl7FptosqCBO
 gkAg==
X-Gm-Message-State: AOAM531g2IrdjHiao3t74CK/EizaARkNSnLtdqlUeq9ChPUT52638Ucy
 TndO9OTqDKu4jH4sSvtPXak=
X-Google-Smtp-Source: ABdhPJzcgCuZPT6qO3lS4in8JWtumLKFmk0jjt/hAhxkoX6lTazmGOJAh0PHnSE5DR2yfj6GH3XG+w==
X-Received: by 2002:a05:600c:19cc:: with SMTP id
 u12mr28427134wmq.24.1637576508467; 
 Mon, 22 Nov 2021 02:21:48 -0800 (PST)
Received: from [192.168.64.123] (bzq-219-42-90.isdn.bezeqint.net.
 [62.219.42.90])
 by smtp.gmail.com with ESMTPSA id r17sm25653139wmq.5.2021.11.22.02.21.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 22 Nov 2021 02:21:47 -0800 (PST)
Subject: Re: [PATCH] nvmet: use IOCB_NOWAIT only if the filesystem supports it.
To: Maurizio Lombardi <mlombard@redhat.com>, kch@nvidia.com
Cc: linux-nvme@lists.infradead.org, hch@lst.de
References: <20211122100827.290117-1-mlombard@redhat.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <38d3f20d-36e3-c813-e00e-92e1bfb3e27c@grimberg.me>
Date: Mon, 22 Nov 2021 12:21:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211122100827.290117-1-mlombard@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211122_022150_822799_EBF4BF2B 
X-CRM114-Status: GOOD (  17.61  )
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



On 11/22/21 12:08 PM, Maurizio Lombardi wrote:
> Submit I/O requests with the IOCB_NOWAIT flag set only if
> the underlying filesystem supports it.
> 
> Fixes: 50a909db36f2 ("nvmet: use IOCB_NOWAIT for file-ns buffered I/O")
> 
> Signed-off-by: Maurizio Lombardi <mlombard@redhat.com>
> ---
>   drivers/nvme/target/io-cmd-file.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/nvme/target/io-cmd-file.c b/drivers/nvme/target/io-cmd-file.c
> index 6aa30f30b572..136b14853ed7 100644
> --- a/drivers/nvme/target/io-cmd-file.c
> +++ b/drivers/nvme/target/io-cmd-file.c
> @@ -8,6 +8,7 @@
>   #include <linux/uio.h>
>   #include <linux/falloc.h>
>   #include <linux/file.h>
> +#include <linux/fs.h>
>   #include "nvmet.h"
>   
>   #define NVMET_MAX_MPOOL_BVEC		16
> @@ -266,6 +267,7 @@ static void nvmet_file_execute_rw(struct nvmet_req *req)
>   
>   	if (req->ns->buffered_io) {
>   		if (likely(!req->f.mpool_alloc) &&
> +				req->ns->file->f_mode & FMODE_NOWAIT &&
>   				nvmet_file_execute_io(req, IOCB_NOWAIT))

I'd suggest to fix the alignment if we are touching this.
    		if (likely(!req->f.mpool_alloc) &&
		    req->ns->file->f_mode & FMODE_NOWAIT &&
  		    nvmet_file_execute_io(req, IOCB_NOWAIT))

>   			return;
>   		nvmet_file_submit_buffered_io(req);
> 

