Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C055C433F5
	for <linux-nvme@archiver.kernel.org>; Mon, 20 Dec 2021 10:42:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
	Subject:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jhsyoByAVA9jgjM1ODX5pbzUwqdsbWrw0+nap4LJv2g=; b=oCYm6oUMw/CIhdkQL8omnYPETS
	BrwKOvoyRrJvkgFjJbutIM719vxVX6aCXiWIjnW4UeZZk7HiUNPTSbcF3YjsVzHNTymUh8lDfMfkE
	p7O/tUSEno0vyBdcZe3GRLfuRUs5p9JG9VqHZNX6XQ8B83i3H+0p5aPRpfhgwGFhITTkTSFzbVw21
	B9LbGygp9gsKR48Er6McoiZAsvBKlJHCPio4iPXr1VixBCbqXqzyurnZdDgh5Cn88kNs5wvxgw15t
	ZRrHY1oY353DbGU1cM8kQaDhAg0k0bcpIcJccgMA21I7Ko42jr99n3e/feri9jTJoiiuQyrSae/tn
	8WFWoQqg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mzG7n-001heD-Ae; Mon, 20 Dec 2021 10:42:35 +0000
Received: from mail-wr1-f51.google.com ([209.85.221.51])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mzG7l-001hdc-2b
 for linux-nvme@lists.infradead.org; Mon, 20 Dec 2021 10:42:34 +0000
Received: by mail-wr1-f51.google.com with SMTP id r17so18788255wrc.3
 for <linux-nvme@lists.infradead.org>; Mon, 20 Dec 2021 02:42:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=jhsyoByAVA9jgjM1ODX5pbzUwqdsbWrw0+nap4LJv2g=;
 b=4jSTjKOfTdVN7UraJkMnnrZWcvIuLW27/ydMPSEubKgDIN11nTQd3RIhXMq7AgJVj5
 mp7HKbCRFtVlW/irVOhanOvcAq1+n5duyQApyTIaa99SdTMKe6zWHL2Rguxk7NWkirsd
 AOT58QZRxzflVlmKv55LCTQVzgQJpuLJZlgXYLXQxYdbRXCnd/JHDooR6fg9zyL1ZB9t
 nTlHNkWil9HHLwbv8Yctm3xCZO8OtKeJzuQ3P3XUGPywM6Dh2U1h5ZNHUyUzVsQqj4/z
 4RQwHNcRYCJGljbnnku3xAtyWDBtvjvZX7FECH8Ndgsp6Y1KnI3Hp7OYGg0G0rwcLI9J
 PnWA==
X-Gm-Message-State: AOAM531CuVyc+JpUfh08GqCGB7P8OO/TPZ0giqUkKykVE/v/ze54uQIa
 wSV/KC9i8GfrplC7Lx4mAv5hqu7qHTk=
X-Google-Smtp-Source: ABdhPJyiJeWyVHjDzln8vUs0x5ki40tnAbhPQK4wBJNY2dE6lk78VHm6r6w+oNFQEA2qzMdOmTL4BQ==
X-Received: by 2002:a5d:60ce:: with SMTP id x14mr12168559wrt.149.1639996950623; 
 Mon, 20 Dec 2021 02:42:30 -0800 (PST)
Received: from [192.168.64.123] (bzq-219-42-90.isdn.bezeqint.net.
 [62.219.42.90])
 by smtp.gmail.com with ESMTPSA id p13sm3451763wms.41.2021.12.20.02.42.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 20 Dec 2021 02:42:30 -0800 (PST)
Subject: Re: [PATCH] nvme-tcp: memset scatterlist before sg_init_marker it
To: Jackie Liu <liu.yun@linux.dev>, hch@lst.de
Cc: axboe@fb.com, linux-nvme@lists.infradead.org
References: <20211220025439.3995260-1-liu.yun@linux.dev>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <6db03c18-c40e-cf2d-aad4-464f9928bc42@grimberg.me>
Date: Mon, 20 Dec 2021 12:42:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211220025439.3995260-1-liu.yun@linux.dev>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211220_024233_148758_E61FE685 
X-CRM114-Status: GOOD (  19.75  )
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


On 12/20/21 4:54 AM, Jackie Liu wrote:
> From: Jackie Liu <liuyun01@kylinos.cn>
> 
> sg_init_marker's sg need initialized, otherwise report:
> 
> [...]
> In file included from ../include/linux/dma-mapping.h:10,
>                   from ../include/linux/skbuff.h:31,
>                   from ../include/net/net_namespace.h:39,
>                   from ../include/linux/netdevice.h:37,
>                   from ../include/net/sock.h:46,
>                   from ../drivers/nvme/host/tcp.c:12:
> ../drivers/nvme/host/tcp.c: In function ‘nvme_tcp_ddgst_update’:
> ../include/linux/scatterlist.h:214:16: error: ‘sg.page_link’ is used uninitialized in this function [-Werror=uninitialized]
>    214 |  sg->page_link |= SG_END;
>        |                ^~
> cc1: all warnings being treated as errors
> make[4]: *** [../scripts/Makefile.build:287: drivers/nvme/host/tcp.o] Error 1
> make[3]: *** [../scripts/Makefile.build:549: drivers/nvme/host] Error 2
> make[2]: *** [../scripts/Makefile.build:549: drivers/nvme] Error 2
> make[2]: *** Waiting for unfinished jobs....
> [...]

This needs:
Fixes: 3f2304f8c6d6 ("nvme-tcp: add NVMe over TCP host driver")

> 
> Reported-by: k2ci <kernel-bot@kylinos.cn>
> Signed-off-by: Jackie Liu <liuyun01@kylinos.cn>
> ---
>   drivers/nvme/host/tcp.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> index 4ceb28675fdf..8fd8cbe23683 100644
> --- a/drivers/nvme/host/tcp.c
> +++ b/drivers/nvme/host/tcp.c
> @@ -348,7 +348,7 @@ static inline void nvme_tcp_ddgst_update(struct ahash_request *hash,
>   {
>   	struct scatterlist sg;
>   
> -	sg_init_marker(&sg, 1);
> +	sg_init_table(&sg, 1);
>   	sg_set_page(&sg, page, len, off);
>   	ahash_request_set_crypt(hash, &sg, NULL, len);
>   	crypto_ahash_update(hash);
> 

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

