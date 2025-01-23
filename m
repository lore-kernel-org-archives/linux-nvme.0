Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5E82C02182
	for <linux-nvme@archiver.kernel.org>; Thu, 23 Jan 2025 22:33:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=wVKZSTnXW3KgVb2LB1GN9WSv2f9Q//cO5qz3+83tIyU=; b=s3XYYHXCDfMXghfNIMGgw8U5vK
	AKiVBGpZ8AEbL/JHIA/H6TxCEmKWF0x/d96ujiMLkawOYeF3ZIPVwXLbtWyGddXE1xA2hJd8IxlY8
	pkcvK3XyKVFkOye+C0pxfJnfMggMTV/CZHoY6WiHpuL2sVQp6Ru4Zqo98YSLuRP3b8XN9zIOKJT5n
	vUUqprLQLsxR4fH/IWi+Lwxo0sxJBzL6e1o59OCh3VdF/e/jBxzVV/3oUaYvKxOxOSpjqJoYuMnwj
	ikOClKgSKBEAj4LtGKMsTQWrvacrk3aobYSOTSAiDLNeYWFmXeQzEujlObN6ef/IOm9r+YQ2PJ1Y4
	lTUkmKmQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tb5lP-0000000DPyp-3q0J;
	Thu, 23 Jan 2025 22:33:27 +0000
Received: from mail-wm1-f45.google.com ([209.85.128.45])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tb5lE-0000000DPxu-1iqI
	for linux-nvme@lists.infradead.org;
	Thu, 23 Jan 2025 22:33:17 +0000
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-43622267b2eso15121595e9.0
        for <linux-nvme@lists.infradead.org>; Thu, 23 Jan 2025 14:33:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737671595; x=1738276395;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wVKZSTnXW3KgVb2LB1GN9WSv2f9Q//cO5qz3+83tIyU=;
        b=nLA4FseBSj4N8Y9wKo3nVLwalIZcZ7QMsatn1tKrMAhHW7OMvJX5js0vEtkc8NcSfw
         zHjCIZCcE2g6kaTsQ5Kb7rsB0DJa2Fa0i7jiVP47LZOdoYJ5fp5LBZQuBRjfm4D8fcRJ
         KmtpkbjSRagSmAUxwbmHxxi688zzjf3mjEYDGz7XKtBRF9yIXyaWBWb1h4qftV6GGtyq
         8jVATrmjrMoxzS8LDcn+sEt+5II8GTv5Ruh/hTWsHb+877HF0UGq3IK7xdcAvo5eSOHC
         w2n26KsyIvUPvl4wZaWyk+Edh2CqYhhNN7GnU+JbHo83xOrj6IwnD/u8HQEOHpA5dHCZ
         VEdQ==
X-Forwarded-Encrypted: i=1; AJvYcCVt3RRx++UXQDrp79IIuOdcqVdMu9p7YaAV2z1TfWbB/qM+xpPusjeL8FVQGZvKA/M5se/avQFC7hpj@lists.infradead.org
X-Gm-Message-State: AOJu0Yy3bi/iXRvARh/SzocNxRcxx47qoLU1N/aHI5Ygvro/2AS8DiqA
	3AkI+nVJCvtbW+fLeFUiX8Td/Khn8X+xZGv5k33BQG84cHNSvGNs+bwa4w==
X-Gm-Gg: ASbGnctxdrAvl6F2UlSm/0Qg0nXmjduGc9sVt2r9aoC5lk1D7Nla5GJ8MfRIWyLPkHA
	Q1mM+1GKc7EJKbk+0IgXkica7K2R5Gd9KoDTHwXkcb7rUhfQ+zbrOdVVTNZHLHYB+Cn6FPYGRIQ
	yhgYSbebBXaVtqwypuQAoMCY7rhbMz7BjxsiZQn+J5ySj3YuIT228Y30zNoceyh2o5Ko+BPX6ap
	vnTo6lLb4oZ87ABwOgaDiygJSG+PKtgOTLK0C+wZibnDEr6X3XvtNG58wmcIHz+Ubyq/XXVxmtw
	8eS6O5at/DzHVc57n9G9idgpG0JmlUoL6HNIvNNZ
X-Google-Smtp-Source: AGHT+IFzEefjdAheqV/LUjC27kTd/KJAYp1OHaORV9NLJhsFMYWPff90V5o+G6s+WLA4DlwJsTJiXQ==
X-Received: by 2002:a05:600c:3114:b0:434:a386:6cf with SMTP id 5b1f17b1804b1-438913bff57mr262164305e9.2.1737671594423;
        Thu, 23 Jan 2025 14:33:14 -0800 (PST)
Received: from [10.100.102.74] (89-138-75-149.bb.netvision.net.il. [89.138.75.149])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-438bd54c04bsm5015695e9.27.2025.01.23.14.33.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Jan 2025 14:33:14 -0800 (PST)
Message-ID: <1a6d4180-8f47-4dab-a31b-32cb2808ba07@grimberg.me>
Date: Fri, 24 Jan 2025 00:33:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme-tcp: Prevent infinite loop if socket closes during
 CONNECTING state
To: Maurizio Lombardi <mlombard@redhat.com>, kbusch@kernel.org
Cc: hch@lst.de, linux-nvme@lists.infradead.org, hare@suse.de
References: <20250121134540.1280828-1-mlombard@redhat.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20250121134540.1280828-1-mlombard@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250123_143316_452316_BB15A73C 
X-CRM114-Status: GOOD (  17.23  )
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




On 21/01/2025 15:45, Maurizio Lombardi wrote:
> There is a potential race condition that can occur if
> the target closes the socket while the host is in the CONNECTING state.
>
> If the socket's state changes to TCP_CLOSE, the nvme_tcp_state_change()
> function is invoked. However, nvme_tcp_error_recovery() is unable
> to transition the controller state to NVME_CTRL_RESETTING because
> the controller is still in the CONNECTING state. As a result, error
> recovery is bypassed, and the controller incorrectly transitions
> to the LIVE state with closed sockets.
>
> Subsequent attempts by the host to communicate with the target
> will result in an infinite loop.
>
> Fix the bug by checking for the -EPIPE error code, which indicates
> that the connection was closed by the target. If this condition
> is detected, ensure the error recovery process is initiated to correctly
> handle the disconnection.
>
> Signed-off-by: Maurizio Lombardi <mlombard@redhat.com>
> ---
>   drivers/nvme/host/tcp.c | 2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> index 841238f38fdd..d0bb225dca23 100644
> --- a/drivers/nvme/host/tcp.c
> +++ b/drivers/nvme/host/tcp.c
> @@ -1261,6 +1261,8 @@ static int nvme_tcp_try_send(struct nvme_tcp_queue *queue)
>   			"failed to send request %d\n", ret);
>   		nvme_tcp_fail_request(queue->request);
>   		nvme_tcp_done_send_req(queue);
> +		if (ret == -EPIPE)
> +			nvme_tcp_error_recovery(&queue->ctrl->ctrl);

Won't nvme_tcp_error_recover() fail to transition the state and exit 
before doing anything?

