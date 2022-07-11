Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAD6FC433EF
	for <linux-nvme@archiver.kernel.org>; Mon, 11 Jul 2022 17:01:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=oRVmx9bOllxl3kVjulrN4qiEWyIXLjdDXqd2F2vjPHA=; b=sCBqB2E3u/sMN9mSELubywT+a9
	JJYBy2qnQTZVnW21gzzW3FMC3Po5r8TAWG1mN/HzkqnMc/t5sy5QAHBJd4DkytQhsRFMbNN5TZ/tt
	BJxgeNvbWunQs7OE+xT5Iec0YXjYj8R9Neitz+QSOn7lWV86g83hak2wnH6UNaxavf9Q0UTviaT8a
	fvRJTYuYdzfYlTqrtkTTwBGxyQxE9GO51xhpfSOD7AA6mUbEbuKFdwfLGGGRQlqN4VqBGA78Vk4C7
	cN1c4IPF4MW2yFOn+iksvY4O0UYFVq1FThyfEccouxH/LoVAtAwJSQTEwsIRV+YxEi8ijMSFtk0/l
	WwNnXG2g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oAwmL-003NNg-7g; Mon, 11 Jul 2022 17:01:01 +0000
Received: from mail-wm1-f46.google.com ([209.85.128.46])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oAwmI-003NLj-N9
	for linux-nvme@lists.infradead.org; Mon, 11 Jul 2022 17:00:59 +0000
Received: by mail-wm1-f46.google.com with SMTP id p4so3402864wms.0
        for <linux-nvme@lists.infradead.org>; Mon, 11 Jul 2022 10:00:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=oRVmx9bOllxl3kVjulrN4qiEWyIXLjdDXqd2F2vjPHA=;
        b=fjBcqJ/AI/pbKE+ihbDk56JyFxfIBxN1H6OQiaBmcHMbRz2CMDVU7oCi+HnGzeV1MW
         lAxMDRgunTy9240i5+amwFVdI1E4bJ8qA0olJ0Vl8eMNu3T/G9KQhm6KoD4aquCF6DjM
         hi/VggbECqrHxT2iiQ2AW2YFBveNeG6JsWVVnim+qbWP6cBQ5/oZK5r5Pnbdu9Cnx86i
         w/oGLjSa71XHINSPLKhUnFxVznhNeiGGMioM2fU5D0QiWIwtMNRetSO5ectaM7Uhaelf
         71TqqemTHN/LH85s/7VbnNhmnNbdhBFlgivRXyYDbRrr6rqPQ4x4lASOGeHnILEUIgd2
         Pe3A==
X-Gm-Message-State: AJIora+wuTLMUHWx/zqFC9kyLhUByiAdQO9IU+vlQMrkHxC0mAh/B0p/
	aHpcIldpspRMnxhyBOpClmg=
X-Google-Smtp-Source: AGRyM1vg+hOt68iw5r4yo5w1HrJm0Q9QpaeugSVcQ4WGNMMLtUlEwXoj/U8a580os9JSwUfwsq3fiw==
X-Received: by 2002:a05:600c:1548:b0:3a1:95fc:aa42 with SMTP id f8-20020a05600c154800b003a195fcaa42mr16914667wmg.189.1657558855078;
        Mon, 11 Jul 2022 10:00:55 -0700 (PDT)
Received: from [10.100.102.14] (46-117-125-14.bb.netvision.net.il. [46.117.125.14])
        by smtp.gmail.com with ESMTPSA id r3-20020adfe683000000b0021b81855c1csm7411785wrm.27.2022.07.11.10.00.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Jul 2022 10:00:54 -0700 (PDT)
Message-ID: <11db8ab2-b41a-967e-8653-7a84b8a984c0@grimberg.me>
Date: Mon, 11 Jul 2022 20:00:52 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH for-next 3/4] io_uring: grow a field in struct
 io_uring_cmd
Content-Language: en-US
To: Kanchan Joshi <joshi.k@samsung.com>, hch@lst.de, kbusch@kernel.org,
 axboe@kernel.dk
Cc: io-uring@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, asml.silence@gmail.com, joshiiitr@gmail.com,
 anuj20.g@samsung.com, gost.dev@samsung.com
References: <20220711110155.649153-1-joshi.k@samsung.com>
 <CGME20220711110824epcas5p22c8e945cb8c3c3ac46c8c2b5ab55db9b@epcas5p2.samsung.com>
 <20220711110155.649153-4-joshi.k@samsung.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20220711110155.649153-4-joshi.k@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220711_100058_792626_8AD7D2C3 
X-CRM114-Status: GOOD (  16.74  )
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


> Use the leftover space to carve 'next' field that enables linking of
> io_uring_cmd structs. Also introduce a list head and few helpers.
> 
> This is in preparation to support nvme-mulitpath, allowing multiple
> uring passthrough commands to be queued.
> 
> Signed-off-by: Kanchan Joshi <joshi.k@samsung.com>
> Signed-off-by: Anuj Gupta <anuj20.g@samsung.com>
> ---
>   include/linux/io_uring.h | 38 ++++++++++++++++++++++++++++++++++++--
>   1 file changed, 36 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/io_uring.h b/include/linux/io_uring.h
> index 54063d67506b..d734599cbcd7 100644
> --- a/include/linux/io_uring.h
> +++ b/include/linux/io_uring.h
> @@ -22,9 +22,14 @@ struct io_uring_cmd {
>   	const void	*cmd;
>   	/* callback to defer completions to task context */
>   	void (*task_work_cb)(struct io_uring_cmd *cmd);
> +	struct io_uring_cmd	*next;
>   	u32		cmd_op;
> -	u32		pad;
> -	u8		pdu[32]; /* available inline for free use */
> +	u8		pdu[28]; /* available inline for free use */
> +};

I think io_uring_cmd will at some point become two cachelines and may
not be worth the effort to limit a pdu to 28 bytes...

