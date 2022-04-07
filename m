Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09A73C433EF
	for <linux-nvme@archiver.kernel.org>; Thu,  7 Apr 2022 12:08:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=fjjvaQHXZ2qGxX+uZPijNZOwoEuDrPdKSbqVpcbdTFc=; b=uXM21mqRVnHLlhbcfLmTDcvA0p
	AFrrkagJiDjAMSYAQbxp2uLYFTwKvWDRvG4oFB9V+dpE+ZeGjPtdntgDjPkKNUP9wrgQehakt4P04
	9rRNZgV5o05NkseibJ9X6gjSxSsYObIunEf6poWg3hTpifypm7Al+k40t+bjX7G+M+bDyLHyR97g8
	9mfa58+gDMyncqwbRg0YIxkntyIua55qG2VVG5KiVNL7/d3dpfHm22Jpkrpmj9Yjq8ZySewIqNJ96
	BYUbt68LkRVmFI7TmD48ahBuCoyosy1KC9mmcDlj93UcDrWXOn7ZvhqpgKtO1maAEf85FroXVqXSB
	ni0AnmFg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ncQvn-00BkMO-2D; Thu, 07 Apr 2022 12:08:07 +0000
Received: from mail-wr1-f52.google.com ([209.85.221.52])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1ncQsa-00Bif1-5s
 for linux-nvme@lists.infradead.org; Thu, 07 Apr 2022 12:04:49 +0000
Received: by mail-wr1-f52.google.com with SMTP id d29so7498781wra.10
 for <linux-nvme@lists.infradead.org>; Thu, 07 Apr 2022 05:04:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:references:from:in-reply-to
 :content-transfer-encoding;
 bh=fjjvaQHXZ2qGxX+uZPijNZOwoEuDrPdKSbqVpcbdTFc=;
 b=FXCwd5m/u59o2k4SoCcLPwTlFbIk1dnYKrLSGEafftdGlKly8H855BMr4KzNOn9KgR
 XrxJPEep8TRPTqtTjsC3OJMjCpoAeS4kdUL1dHOierOBVIRf4g6yNIDxkE/shXy/E0n4
 qHGpIkygha2cXzIYF463sxsUvvznKYgqbE6DNRsaeHwo/Bn+3vGk+/KGC3WB/Sg7mHhg
 h1+UEz1qOdAVWISTpThypEAUo1wD4H3rScQU9HiV5K53opL7C7GO2uOnX9+MdTKnCI/O
 XvtWYfu9j50vt8RYT1SOrGfyg74hHQh6r3JqARmgYIZ1xh+4E24gnh6OwJ7AEf4KYuRs
 n6mA==
X-Gm-Message-State: AOAM530CjIQy1GlBpJrl0cL7jfgQV0dNCAIIeURvVUhG+cHYt5Jv/O50
 BvcQzuxwCHdIPyLy78qHwh/M6qowLPk=
X-Google-Smtp-Source: ABdhPJwAwvSV7+3FlM05l69UiN+g4YhhnElgOJbvw7Zwy9IZQ6JNPGg5P9ZAvU2eBPqwt4ROB3+Nog==
X-Received: by 2002:adf:e38c:0:b0:206:15ae:5038 with SMTP id
 e12-20020adfe38c000000b0020615ae5038mr10537387wrm.632.1649333084088; 
 Thu, 07 Apr 2022 05:04:44 -0700 (PDT)
Received: from [192.168.64.180] (bzq-219-42-90.isdn.bezeqint.net.
 [62.219.42.90]) by smtp.gmail.com with ESMTPSA id
 o4-20020a5d6484000000b002057ad822d4sm17791400wri.48.2022.04.07.05.04.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 07 Apr 2022 05:04:43 -0700 (PDT)
Message-ID: <eef5eda6-f00f-b879-858f-80f7ce44a362@grimberg.me>
Date: Thu, 7 Apr 2022 15:04:42 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] nvme-tcp: handle failing req immediately for
 REQ_FAILFAST_DRIVER
Content-Language: en-US
To: Daniel Wagner <dwagner@suse.de>, linux-nvme@lists.infradead.org
References: <20220407092540.66227-1-dwagner@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20220407092540.66227-1-dwagner@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220407_050448_301178_6B9F5AEB 
X-CRM114-Status: GOOD (  23.36  )
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


> When nvme_tcp_try_send fails to send a request is usually defers the
> error handling to upper layers but it ignores the REQ_FAILFAST_DRIVER
> flag.
> 
> This can lead to very long shutdown delays when the users issues a
> 'nvme disconnect-all':
> 
>   [44888.710527] nvme nvme0: Removing ctrl: NQN "xxx"
>   [44898.981684] nvme nvme0: failed to send request -32
>   [44960.982977] nvme nvme0: queue 0: timeout request 0x18 type 4
>   [44960.983099] nvme nvme0: Property Set error: 881, offset 0x14
> 
> At timestamp [44898.981684] nvme_tcp_try_send fails to send but we have
> to wait for the timeout handler to expires at [44960.982977] before we
> make any progress.
> 
> With honoring the REQ_FAILFAST_DRIVER flag the log looks like this:
> 
>   [ 8999.227495] nvme nvme1: Removing ctrl: NQN "xxx"
>   [ 9016.680447] nvme nvme1: failed to send request -32
>   [ 9016.680477] nvme nvme1: Property Set error: 880, offset 0x14
> 
> Signed-off-by: Daniel Wagner <dwagner@suse.de>
> ---
>   drivers/nvme/host/tcp.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> index 10fc45d95b86..f714d7ad38c0 100644
> --- a/drivers/nvme/host/tcp.c
> +++ b/drivers/nvme/host/tcp.c
> @@ -1145,9 +1145,11 @@ static int nvme_tcp_try_send(struct nvme_tcp_queue *queue)
>   	if (ret == -EAGAIN) {
>   		ret = 0;
>   	} else if (ret < 0) {
> +		struct request *rq = blk_mq_rq_from_pdu(queue->request);
>   		dev_err(queue->ctrl->ctrl.device,
>   			"failed to send request %d\n", ret);
> -		if (ret != -EPIPE && ret != -ECONNRESET)
> +		if ((ret != -EPIPE && ret != -ECONNRESET) ||
> +		    rq->cmd_flags & REQ_FAILFAST_DRIVER)

I'm wandering if this will race with nvme_cancel_admin_tagset which
can also complete the command... The whole assumption is that the
cancel iterator will be running as the socket is shutdown by the peer
and error_recovery was triggered.

I think these shouldn't race because we shutdown the queue (and flush
the io_work) and only then cancel. But I've seen races of that
sort in the past...


