Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63CD0C6FD1D
	for <linux-nvme@archiver.kernel.org>; Tue, 21 Mar 2023 08:30:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=H7+cr8qri5V33ka1M1IsPhvO+MgN525igHzsX8h2uUM=; b=TYh96qJ/A/C96v90v7+j+vYvAQ
	djgr+Wdu4HpOaKO30TDsF6C8OfpNVnvwMy/XNiZu42aeBMenkEYYfN7IWXkuCTYNNZBipMDJXm2CG
	FQpU2WVqM3XIpAtLhjsGUoWvb23h6e2HDg1emT6gtkGcqmhiu23XBKs4yJHaG7Ml1RK08wOiiD+kM
	8UbNKC16mHwhwna0GGLO5I7one8k0CoYNhTxI1TgpqA5yCq70nyvQFGoLrfrRJ5EIz8OHaid75wkE
	VLMnByr+LCtMW6M4zHCOZABjGNNy/9iViybUzkvAKEfZL4OD5mEqL1AwTkjSk3rlTqO/99a0tcqj3
	35LNOMyA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1peXO5-00Bgbv-0R;
	Tue, 21 Mar 2023 08:30:33 +0000
Received: from mail-ed1-f45.google.com ([209.85.208.45])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1peXO1-00Bgak-2w
	for linux-nvme@lists.infradead.org;
	Tue, 21 Mar 2023 08:30:31 +0000
Received: by mail-ed1-f45.google.com with SMTP id h8so56477880ede.8
        for <linux-nvme@lists.infradead.org>; Tue, 21 Mar 2023 01:30:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679387426;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=H7+cr8qri5V33ka1M1IsPhvO+MgN525igHzsX8h2uUM=;
        b=MuF4zIBqmg56RD9PRUV/ERO90KQS4io9dmFwHWr5k9Vt8kSyBCYPYDAGbXK6zGAUcl
         XdEDbObZe8bEEbAJ2btDIFBcT21jS7MIeL1+xFZWs5VW9h4BDR1l4t5n9K0d8rHXVz6Q
         gYmm9mp1WREkxKmS163PwQGM40pb6jFddoo49u/PtrLBycJLh87N/oLs3ZqyeARb/SQZ
         8KiG/soi58eivuJw/sI/rnhS5xM5Y+5KPUddnOZBSqm2l7+qfQZT6J3fR194OcGn3o/b
         6tY7q7lXrAX/tKE60q5EAPLrGcMiGbxTbVCRt0vXRicZsp04QtXhp+rInqXkqsruGoy2
         xn6A==
X-Gm-Message-State: AO0yUKXYBSLyDk+c3hIPjYKTs808/4aHIlUT99DS4xI8TF+YkeI28Hya
	w3Zhi3lT63bHohBP891up0zsiySFVCI=
X-Google-Smtp-Source: AK7set/P8FfYBJUsg5Z4a7xCJU9GYeF5H/M5SxsXh8eZt2qlouH5dypkKuA0H6bjGNajsDHVQcBzkw==
X-Received: by 2002:a17:906:2081:b0:8d2:78c5:1d4e with SMTP id 1-20020a170906208100b008d278c51d4emr1883010ejq.5.1679387426031;
        Tue, 21 Mar 2023 01:30:26 -0700 (PDT)
Received: from [10.100.102.14] (85.65.253.165.dynamic.barak-online.net. [85.65.253.165])
        by smtp.gmail.com with ESMTPSA id g4-20020a170906520400b0093a35f65a30sm319291ejm.41.2023.03.21.01.30.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Mar 2023 01:30:25 -0700 (PDT)
Message-ID: <f3b47746-624c-2b8f-2d26-1f6d15ef90f4@grimberg.me>
Date: Tue, 21 Mar 2023 10:30:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 1/1] nvme-tcp: fence TCP socket on transport error
Content-Language: en-US
To: Chris Leech <cleech@redhat.com>, linux-nvme@lists.infradead.org
Cc: John Meneghini <jmeneghi@redhat.com>
References: <20230320220947.3244247-1-cleech@redhat.com>
 <20230320220947.3244247-2-cleech@redhat.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20230320220947.3244247-2-cleech@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230321_013029_951299_277E2F27 
X-CRM114-Status: GOOD (  19.51  )
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

Hey Chris,

> Ensure that no further socket reads occur after a receive processing
> error, either from io_work being re-scheduled or nvme_tcp_poll.
> 
> Failing to do so can result in unrecognised PDU payloads or TCP stream
> garbage being processed as a C2H data PDU, and potentially start copying
> the payload to an invalid destination after looking up a request using a
> bogus command id.

I agree with your analysis.

> 
> Signed-off-by: Chris Leech <cleech@redhat.com>
> ---
>   drivers/nvme/host/tcp.c | 7 +++++++
>   1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> index 42c0598c31f2..49e8eb576527 100644
> --- a/drivers/nvme/host/tcp.c
> +++ b/drivers/nvme/host/tcp.c
> @@ -888,6 +888,13 @@ static int nvme_tcp_recv_skb(read_descriptor_t *desc, struct sk_buff *skb,
>   	size_t consumed = len;
>   	int result;
>   
> +	if (!queue->rd_enabled) {
> +		/* io_work or polling happening after receive error
> +		 * waiting on error recovery
> +		 */
> +		return -EFAULT;
> +	}

I think we can drop the comment, the code is somewhat self-explanatory,
if read is not enabled, we shouldn't try and read from the socket.

	if (!queue->rd_enabled)
		return -EFAULT;

