Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E335ECAAD3
	for <linux-nvme@archiver.kernel.org>; Mon,  5 Sep 2022 19:11:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=PNaCX0S9iGhKAlyPWJAoKRpsa01FH9FlALaZF1PJLS0=; b=3HzJoxWS0dOi5zKnD88lINc3yl
	77ZpWl8DIc5u46EHbECu9wCz7EtVajp1fMnsxiwH44gECEBkrW90yBsftXDPpbITvrupmtw38uDq2
	Y5p19k1bDpGNOY/iqgKtaUby0UyFooojT6qURbVkwcpNbKNZ6ysCB6bNlF3mQN+ApEkWBCMrYf64t
	X06xSahTCFBIAtx7YJGO70ghGENVLdTFFkLoMqrhclTWamieu2oeodh7kTBDiLEtoAUhqBaX8XIQt
	j7P1CR+ssPkg3edRKBJeLZq3zDmCyzmz8FlRw4oN+aqqQOZyVBx/neQEgIuGgM/bGGp/jOL8hhrCM
	JL4dHh8g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oVHVj-0091Nv-Uv; Mon, 05 Sep 2022 19:11:56 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oVGNj-00813d-Bp
	for linux-nvme@bombadil.infradead.org; Mon, 05 Sep 2022 17:59:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
	:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=PNaCX0S9iGhKAlyPWJAoKRpsa01FH9FlALaZF1PJLS0=; b=jqHLNiuQk2WDost1NZCsPiOfhv
	CmVJ1EM3FcuBcHRBFfESluDGWtCrRYVGw51J0wzVbru4Wsbw4pTmgskIDaY9xAZxe2cxV8kPpq29g
	9v0Gqg2DZb4/DBUA32MKIibdPKbwIeiptzUb7lUDJM2UJElbR1PbWPJdGtKUy1gQE5ARyyBCASSPo
	OzAIByaeEGnte2ZbeTB2/dzwbM2n1MQvvI2aZUwCHPoCCb+ct0lWU0k8FE8HeZTsSGvtWXC3P4zve
	CZy0OP+FNIGZ5QcFurEf2ZM6hiwz0ddaZyffsnNhay8EeSr/ZwOlVI0nPQJo3xSC88iHdB75ded0Z
	uhE4ed3A==;
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032])
	by desiato.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oVGEt-009sq0-Ka
	for linux-nvme@lists.infradead.org; Mon, 05 Sep 2022 17:50:29 +0000
Received: by mail-pj1-x1032.google.com with SMTP id m10-20020a17090a730a00b001fa986fd8eeso12799701pjk.0
        for <linux-nvme@lists.infradead.org>; Mon, 05 Sep 2022 10:50:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=PNaCX0S9iGhKAlyPWJAoKRpsa01FH9FlALaZF1PJLS0=;
        b=lMnZ13siCUzc0zOynH5OarlVG770rcTKcozKwKhb4GoNXLZfY5qo+9mE7Rm0XEkk4a
         7+b9inDvYw4dIC8yt82RCx0511+bCZvHLylAQVe083yQrOokin8d4Bu3HfKuV8CbVJRA
         EhJOGja7bkAuGXfJEMJrqCAC+0bBEoAJ8NzdfFy3Ye4uHrtYsANZomFnRc7ReT3dtOxA
         Tny4ZaZ8Z7mRAtzJcKiOSUfRnpFgEMc+IAx5tVYfGT+f3C2vL9f9efDWiKMUbsqQhCUS
         /7uLU76kveNyfhJz3meNYUioN4Kodaak/BlvSmO+zX+o1pSAJQ+cXnLiZyy8e4MSnhwd
         5kKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=PNaCX0S9iGhKAlyPWJAoKRpsa01FH9FlALaZF1PJLS0=;
        b=L0wUYdJMCtg2e3XwNZh1maiGRIXp3VhrFMNVAl17wJgWKdPZrsimpfjC7nlDFaczxt
         8VtslSR1rr+3eG8u56mXftrzKwLKU2pShSGCiNufM1WAqd7Rt9GSCRh5+kz7pQ9E4Bqq
         emRjahZSKuDVaCfGTiiS+zU5ryGQW5aUSy/Yl/1aE0t9GPEsMbZH1R12i4oauRTroFzi
         F4amdoQj7sMyGkD9qwiHRf78JL+dYYQdDNiEys0IVZNxUIe+sgXC6O475My3UV3ZcTH4
         LtEKHp5A/lYKxSBHwLwn/OMmTPtl4KywctJKtiidMxqbup8gTfBI69Vy5Cn2ohWuBbQd
         rOhg==
X-Gm-Message-State: ACgBeo1DEcZzyCIGDDPgFdgudGINzx/0YnL3EpawYD7nUKndPqkgPSsf
	4KF6YFOwGjVQivfl4dRS0r7Cpw==
X-Google-Smtp-Source: AA6agR5R9puDZtsQGlvBHmoPXUZgxeA3Szf5wt3UY93HyWP9kB/FpM7r9D8ZOEgLdp4cZ5V/aaVWYw==
X-Received: by 2002:a17:90b:4b81:b0:1fd:d736:9d04 with SMTP id lr1-20020a17090b4b8100b001fdd7369d04mr20794110pjb.121.1662400222422;
        Mon, 05 Sep 2022 10:50:22 -0700 (PDT)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id x12-20020a170902ec8c00b0017543086eb3sm7914486plg.274.2022.09.05.10.50.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Sep 2022 10:50:21 -0700 (PDT)
Message-ID: <8a6f1186-e202-7d0c-6e4a-6a456cf7f4f7@kernel.dk>
Date: Mon, 5 Sep 2022 11:50:20 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH for-next v4 1/4] io_uring: introduce
 io_uring_cmd_import_fixed
Content-Language: en-US
To: Kanchan Joshi <joshi.k@samsung.com>, hch@lst.de, kbusch@kernel.org,
 asml.silence@gmail.com
Cc: io-uring@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, gost.dev@samsung.com,
 Anuj Gupta <anuj20.g@samsung.com>
References: <20220905134833.6387-1-joshi.k@samsung.com>
 <CGME20220905135846epcas5p4fde0fc96442adc3cf11319375ba2596b@epcas5p4.samsung.com>
 <20220905134833.6387-2-joshi.k@samsung.com>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20220905134833.6387-2-joshi.k@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220905_185027_882255_60425159 
X-CRM114-Status: GOOD (  18.12  )
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

On 9/5/22 7:48 AM, Kanchan Joshi wrote:
> From: Anuj Gupta <anuj20.g@samsung.com>
> 
> This is a new helper that callers can use to obtain a bvec iterator for
> the previously mapped buffer. This is preparatory work to enable
> fixed-buffer support for io_uring_cmd.
> 
> Signed-off-by: Anuj Gupta <anuj20.g@samsung.com>
> Signed-off-by: Kanchan Joshi <joshi.k@samsung.com>
> ---
>  include/linux/io_uring.h |  8 ++++++++
>  io_uring/uring_cmd.c     | 11 +++++++++++
>  2 files changed, 19 insertions(+)
> 
> diff --git a/include/linux/io_uring.h b/include/linux/io_uring.h
> index 58676c0a398f..dba6fb47aa6c 100644
> --- a/include/linux/io_uring.h
> +++ b/include/linux/io_uring.h
> @@ -4,6 +4,7 @@
>  
>  #include <linux/sched.h>
>  #include <linux/xarray.h>
> +#include <uapi/linux/io_uring.h>
>  
>  enum io_uring_cmd_flags {
>  	IO_URING_F_COMPLETE_DEFER	= 1,
> @@ -32,6 +33,8 @@ struct io_uring_cmd {
>  };
>  
>  #if defined(CONFIG_IO_URING)
> +int io_uring_cmd_import_fixed(u64 ubuf, unsigned long len, int rw,
> +		struct iov_iter *iter, void *ioucmd);
>  void io_uring_cmd_done(struct io_uring_cmd *cmd, ssize_t ret, ssize_t res2);
>  void io_uring_cmd_complete_in_task(struct io_uring_cmd *ioucmd,
>  			void (*task_work_cb)(struct io_uring_cmd *));
> @@ -59,6 +62,11 @@ static inline void io_uring_free(struct task_struct *tsk)
>  		__io_uring_free(tsk);
>  }
>  #else
> +int io_uring_cmd_import_fixed(u64 ubuf, unsigned long len, int rw,
> +		struct iov_iter *iter, void *ioucmd)
> +{
> +	return -1;
> +}

Is this right? Shouldn't it return -EOPNOTSUPP or another suitable actual
error value?

Apart from that, I think the patchset looks fine now.

-- 
Jens Axboe



