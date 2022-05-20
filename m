Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2478FC433FE
	for <linux-nvme@archiver.kernel.org>; Fri, 20 May 2022 09:19:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=LM6o3wsG5/9CYNV69QPTht2u3Gh7b6WGN8u/aPygK7Q=; b=JeGOcdtTwMR++YvkKBtR0D3GGi
	ExlhfTRbw8DcfPo+2HIWWaIMO3qvlXXTyP5lgPzMjLMmItlZ8n7OvME20jX4jP18FdRHy8QYE1ag2
	NJ9UHZNYW02kEIvkVNlvdqAtWG0VL/f2FITzThQBE0/oWtTqbO5mAwM/i+sdN59xevWuTzpqqDkNM
	JEZGWhW9v6hI2kfJWMea4/9HQAC4CKiAT7UF3WlNAQjWXoghlUPTM6Dk01VKGNmtzL3VPV4IhhbQh
	QJaCUG4BWY0/WKgmCOrNtN5jfoVt1Z/f9asPpWreYuRGBvFUomBVmJqb7lRH1ioT3fIJxcmC64ecA
	0ukO/YTw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nryn1-00BY8v-Fw; Fri, 20 May 2022 09:19:19 +0000
Received: from mail-wm1-f43.google.com ([209.85.128.43])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nrymv-00BY2f-H6
 for linux-nvme@lists.infradead.org; Fri, 20 May 2022 09:19:15 +0000
Received: by mail-wm1-f43.google.com with SMTP id
 c190-20020a1c35c7000000b0038e37907b5bso6468686wma.0
 for <linux-nvme@lists.infradead.org>; Fri, 20 May 2022 02:19:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=LM6o3wsG5/9CYNV69QPTht2u3Gh7b6WGN8u/aPygK7Q=;
 b=Dl3EX4lsp1RhjE+JR6xqbHyxcWxYlEYgLTgXXVz8jaY6vWCrKLPNyPGEGkNaL48Bku
 HmQhj5B2l+Wc4Vwa8s4y3SKneNHmgOcRd3qjuYwtL14Thi/qecj17wCdVUEoS3Oa+cPd
 BCtxXbAWPagZwoUF/O+p0nVwdVRCBFwCX+KaLEuPHjAGjNc1m1ybmRlDH1z1X/NOMq45
 /A1vL3VPzV8hTsL4Ferhx518Qdy8SP5TUFRQtebJR4W48NQ5hJsX/FKu1LSYxtjGpFt1
 r6iY0QCCsr9N7tCnTaycxJoN8G2WTqvgMcbGAO/xyPx+OQpPdNGe8lfuG9cPYSugZ0qm
 9Eyw==
X-Gm-Message-State: AOAM530FZj44Uyp2eJ/a6udUtOrAVsuOC1VlQnzNCDrayEudprNuoZYx
 1C5GierpOFgmQLOPL2+AHk/N41iGEcg=
X-Google-Smtp-Source: ABdhPJycy2jYZMHSmaCfHcN5ZuXZlUekjnrKHpMv+Jepe4YmTWtAh2fyM89H9jdlZxbcmIVrysA38w==
X-Received: by 2002:a05:600c:358d:b0:394:8343:a67a with SMTP id
 p13-20020a05600c358d00b003948343a67amr7918712wmq.189.1653038346306; 
 Fri, 20 May 2022 02:19:06 -0700 (PDT)
Received: from [10.100.102.14] (46-117-125-14.bb.netvision.net.il.
 [46.117.125.14]) by smtp.gmail.com with ESMTPSA id
 q2-20020adfb182000000b0020c5253d8d0sm1964774wra.28.2022.05.20.02.19.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 20 May 2022 02:19:06 -0700 (PDT)
Message-ID: <6c685c87-519e-68a1-bce8-8ac69929adb7@grimberg.me>
Date: Fri, 20 May 2022 12:19:03 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH 3/3] nvme-tcp: send quota for nvme_tcp_send_all()
Content-Language: en-US
To: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
 Daniel Wagner <dwagner@suse.de>
References: <20220519062617.39715-1-hare@suse.de>
 <20220519062617.39715-4-hare@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20220519062617.39715-4-hare@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220520_021913_658278_405D8D89 
X-CRM114-Status: GOOD (  17.12  )
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


> Add a send quota in nvme_tcp_send_all() to avoid stalls when sending
> large amounts of requests.
> 
> Signed-off-by: Daniel Wagner <dwagner@suse.de>
> Signed-off-by: Hannes Reinecke <hare@suse.de>
> ---
>   drivers/nvme/host/tcp.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> index 606565a4c708..87d760dfa3a9 100644
> --- a/drivers/nvme/host/tcp.c
> +++ b/drivers/nvme/host/tcp.c
> @@ -308,11 +308,12 @@ static inline void nvme_tcp_advance_req(struct nvme_tcp_request *req,
>   static inline void nvme_tcp_send_all(struct nvme_tcp_queue *queue)
>   {
>   	int ret;
> +	unsigned long deadline = jiffies + msecs_to_jiffies(1);
>   
>   	/* drain the send queue as much as we can... */
>   	do {
>   		ret = nvme_tcp_try_send(queue);
> -	} while (ret > 0);
> +	} while (ret > 0 || !time_after(jiffies, deadline));

Umm, this will stay here a deadline period even if we don't have
anything to send?

