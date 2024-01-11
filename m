Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9954EC4707B
	for <linux-nvme@archiver.kernel.org>; Thu, 11 Jan 2024 12:30:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=GJtAQcz5E+N8XX8rdYHK5f+cjc7gE+SF+gzEp3Oj61E=; b=0yR6UL1BVQMM5TEReoDKNJ1LQO
	o4Kx7SwnI7oUbENSm3jPj2A81XVah2RL6vPmgCR9OI1b6dgUEA3TohOb+tqgRgRo62A+1U91x7Jzd
	IvSN/xpHsRdVzYU9YdjGu7Ojj1o0C+r6BOZgI9CB+W28R9rwOEykG1GQ9NUXqv9w3pK47YNbkqHMn
	/0uHbH8oATwMg7CjTuNV6LooztfDSnyvifHv2cqKnsPM1n2w/sY4YvAWjgocbCpK+drAe7T9Jufn0
	wWKn167ofPAnsFuc/xT6CVA+dnWTqb0qn3MDcQaNpNH9EEAoRYrlLjNKkssx3qt4LKZHRbpAP1Bug
	mzYvtryQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rNuCr-0002Pf-1B;
	Thu, 11 Jan 2024 12:30:45 +0000
Received: from mail-lf1-f49.google.com ([209.85.167.49])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rNuCo-0002N3-24
	for linux-nvme@lists.infradead.org;
	Thu, 11 Jan 2024 12:30:44 +0000
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-50e4e36c09cso715156e87.1
        for <linux-nvme@lists.infradead.org>; Thu, 11 Jan 2024 04:30:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704976239; x=1705581039;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GJtAQcz5E+N8XX8rdYHK5f+cjc7gE+SF+gzEp3Oj61E=;
        b=naSf8CMan/rXd9zT95PEX+Rv5+qgrumhKZnGkGRx9xjh5Y7athJ3sVGhPY0lx2O8iq
         kCNfB6+6PbEdZIR6KAtoqUCi0furvvUivDTqEQaTLScMtxG4lIijLH8xtN1xEUYldbzq
         gwFHMao53X7GqJAJKE23JWJapOJoH14+/aMYMJ4ZtwHfymrCEzQWmRQdkY06FJmJMDh8
         UUFuQlhfmvDuv3Lz2Cn3ixj4NkZShPU44pjn3U8Li6kgOMB1QWoste6uGTOuCzshndTM
         N7BCgzjbd8pRIsEhQje1yQQOHF/urx4wiybqzF/jHfZyp6eBOKIqvLDUsHePKSVknucu
         3c6A==
X-Gm-Message-State: AOJu0YxNJRMZuKHVi30MyVxoGKhdvUd+Kda+ZyjMrAwUrne5eM5TC2qw
	DGNpYGk3zDH0KLR9suOvLbM=
X-Google-Smtp-Source: AGHT+IFGFuYuzpdwSwq8SdKCAK5bD9/uaO2zTWiTmXkLeB+Ka4pyZI2xzqkaLTx0mO4uL3frpq+1WQ==
X-Received: by 2002:a05:6512:3d05:b0:50e:7d4f:a32a with SMTP id d5-20020a0565123d0500b0050e7d4fa32amr1071001lfv.3.1704976238985;
        Thu, 11 Jan 2024 04:30:38 -0800 (PST)
Received: from [10.100.102.14] (46-117-114-124.bb.netvision.net.il. [46.117.114.124])
        by smtp.gmail.com with ESMTPSA id u17-20020a05600c19d100b0040e47dc2e8fsm1761920wmq.6.2024.01.11.04.30.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Jan 2024 04:30:38 -0800 (PST)
Message-ID: <8e29a135-2c3f-4b85-8d9e-bf375160d3bc@grimberg.me>
Date: Thu, 11 Jan 2024 14:30:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme-tcp: Do not terminate commands when in RESETTING
Content-Language: en-US
To: hare@kernel.org, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
 Hannes Reinecke <hare@suse.de>
References: <20240111072929.29381-1-hare@kernel.org>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240111072929.29381-1-hare@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240111_043042_678038_4CF9CD2B 
X-CRM114-Status: GOOD (  23.37  )
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


> From: Hannes Reinecke <hare@suse.de>
> 
> Terminating commands from the timeout handler might lead
> to a data corruption as the timeout might trigger before
> KATO expired.
> This is the case when several commands have been started
> before the keep-alive command and the command timeouts
> trigger just after the keep-alive command has been sent.
> Then the first command will trigger an error recovery,
> but all the other commands will be aborted directly
> and immediately retried.
> So return BLK_EH_RESET_TIMER for I/O commands when
> error recovery has been started to ensure that the
> commands will be retried only after the KATO interval.
> 
> Signed-off-by: Hannes Reinecke <hare@suse.de>
> ---
>   drivers/nvme/host/tcp.c | 12 ++++++++++++
>   1 file changed, 12 insertions(+)
> 
> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> index b234f0674aeb..b9ec121b3fc6 100644
> --- a/drivers/nvme/host/tcp.c
> +++ b/drivers/nvme/host/tcp.c
> @@ -2429,6 +2429,18 @@ static enum blk_eh_timer_return nvme_tcp_timeout(struct request *rq)
>   		 rq->tag, nvme_cid(rq), pdu->hdr.type, opc,
>   		 nvme_opcode_str(qid, opc, fctype), qid);
>   
> +	/*
> +	 * If the error recovery is started we should ignore all
> +	 * I/O commands as they'll be aborted once error recovery starts.
> +	 * Otherwise they'll be failed over immediately and might
> +	 * cause data corruption.

I think that we can settle with a simpler comment:
	/*
	 * If the controller is in state RESETTING, the error
	 * recovery handler will cancel all inflight commands soon
	 * which in turn may failover to a different path.
	 */

The error handler will start promptly anyways.

> +	 */
> +	if (ctrl->state == NVME_CTRL_RESETTING && qid > 0) {

What would be the issue doing this for admin commands as well?

> +		/* Avoid interfering with firmware download */
> +		if (!WARN_ON(work_pending(&ctrl->fw_act_work)))

Let's ignore the fw_act_work, it's not a thing in fabrics.

> +			return BLK_EH_RESET_TIMER;
> +	}
> +
>   	if (ctrl->state != NVME_CTRL_LIVE) {
>   		/*
>   		 * If we are resetting, connecting or deleting we should

I think that the comment here needs an update as well.

BTW, what happens when deleting a controller? Won't the state be
DELETING and the situation you are trying to prevent happen as well?

