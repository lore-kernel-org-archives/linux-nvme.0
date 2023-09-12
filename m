Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3806CA0ECA
	for <linux-nvme@archiver.kernel.org>; Tue, 12 Sep 2023 11:55:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=FKm/PgookQlU1JSHoxtwapzICfJHosWjEiZqsDVd8S4=; b=Ad71GklJCuwpgjTacn5NxG0vv6
	tFJQBcak/2hn84yEAwMr69A3vkh7pY5waZJUadxuVeOoMnZmN3ukVOtYJRGPn6fGVTL9US6lksLzP
	MlsiFWLpZXcvOpA6FJmKtftobP+d3MXB6epjynwFIxSRT2odnT0hBHPcNwabRiPNpx4bFBvuoH3fv
	GWqZ42WedtqSgmsM6h3H8n3i7Vo/OVrNwi+PrVYZ5Qj05ZG4xpWK9vQVF93Om5AFOzLsl+GuBmfrZ
	TOsHx8qs6jSw099/0aTbF5r4FFTJBurIQZc65Y/0gHtbMhTY2wqrZHs20pOGI0NMkWAXkzs8CjvLG
	gI8lUITw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qg1yz-003Gda-39;
	Tue, 12 Sep 2023 11:55:06 +0000
Received: from mail-ed1-f44.google.com ([209.85.208.44])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qg1yu-003GcE-0p
	for linux-nvme@lists.infradead.org;
	Tue, 12 Sep 2023 11:55:01 +0000
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5221bd8f62eso1103237a12.1
        for <linux-nvme@lists.infradead.org>; Tue, 12 Sep 2023 04:55:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694519699; x=1695124499;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FKm/PgookQlU1JSHoxtwapzICfJHosWjEiZqsDVd8S4=;
        b=EBz5NF/plbdRTxNu8Ef8mZ6RRJ09uJlJZDv73HrniSO8l/TGNmPCBUGuJLqWczD1yj
         Y/VkV19+ZLzUL4W/2vgfrO/aAdGk+eXWRwv5HLG0YAe2tVdUswwAWjmX6dcu5VebKEau
         bDAHoGiQz1bPA5oh0zO4Hllj2Y8tF4Q17pA4A6vRGzmULZEyVPqTMrMCL/9fCsPxWLS9
         lkfPnYTZOxBzUJqPrnwWVRVFrrWfNt1/+Z56aD4+TXvlZOs430DtHBHS8Q4pc67/YZds
         gkCaychpUTfoATm2fbeSH1TBk1hubsuXFowGDxotv7IwLHJihRX/FyUQZHvg8Ef2paE5
         DRyg==
X-Gm-Message-State: AOJu0Yz+CQTY9Yw0IsB+KhkPhK3g1mPr1NP52TE6gEZvvjGlH/spV7QK
	DKS54zFy+2IL+vrmYHXndpw=
X-Google-Smtp-Source: AGHT+IEDk7Gv3OIkBwqlAKo29AIDbpQ81aQotuEdqAmZOAR9yG2q9c7N4Tq2QJkCUpFAPs6NZQXhHA==
X-Received: by 2002:a05:6402:35d5:b0:523:220e:a6ca with SMTP id z21-20020a05640235d500b00523220ea6camr10010972edc.3.1694519698785;
        Tue, 12 Sep 2023 04:54:58 -0700 (PDT)
Received: from [192.168.64.157] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id j8-20020aa7c0c8000000b00525503fac84sm5843295edp.25.2023.09.12.04.54.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Sep 2023 04:54:58 -0700 (PDT)
Message-ID: <b21a2472-2afb-5a38-1029-1db153102a0c@grimberg.me>
Date: Tue, 12 Sep 2023 14:54:56 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH 1/3] nvme-tcp: Do not terminate commands when in RESETTING
Content-Language: en-US
To: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
References: <20230908100049.80809-1-hare@suse.de>
 <20230908100049.80809-2-hare@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20230908100049.80809-2-hare@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230912_045500_290497_E380CCDC 
X-CRM114-Status: GOOD (  20.39  )
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


> When the error recovery started it will terminate all commands
> anyway, so we should just return BLK_EH_RESET_TIMER for a
> command timeout.

Does this fix a real issue? the timeout handler and the error
recovery should be mutually exclusive.

> Signed-off-by: Hannes Reinecke <hare@suse.de>
> ---
>   drivers/nvme/host/tcp.c | 8 ++++++++
>   1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> index 5b332d9f87fc..1faef1cf5c94 100644
> --- a/drivers/nvme/host/tcp.c
> +++ b/drivers/nvme/host/tcp.c
> @@ -2274,6 +2274,14 @@ static enum blk_eh_timer_return nvme_tcp_timeout(struct request *rq)
>   		nvme_tcp_queue_id(req->queue), nvme_cid(rq), pdu->hdr.type,
>   		opc, nvme_opcode_str(qid, opc, fctype));
>   
> +	/*
> +	 * If the error recovery is started all commands will be
> +	 * aborted anyway, and nothing is to be done here.
> +	 */
> +	if (ctrl->state == NVME_CTRL_RESETTING &&
> +	    work_pending(&to_tcp_ctrl(ctrl)->err_work))
> +		return BLK_EH_RESET_TIMER;

What does the work_pending() check give you here?

> +
>   	if (ctrl->state != NVME_CTRL_LIVE) {
>   		/*
>   		 * If we are resetting, connecting or deleting we should

