Return-Path: <SRS0=jxE6=IY=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23291C433DB
	for <linux-nvme@archiver.kernel.org>; Fri, 26 Mar 2021 21:04:08 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB2ED61937
	for <linux-nvme@archiver.kernel.org>; Fri, 26 Mar 2021 21:04:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB2ED61937
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=9+QoEzpA4jJQX8rnHxhjzZFGp8B6+EGNsw8LAZZ+vwU=; b=jQEAfrrl8cC2iXp8CTCpBrfti
	aBoZcMsqPaL/PiCRqUGXNt8cl05CVsDwg2wJDT/b4hyWEZvYJk3G+OeGQ3ri/GYC2MOP1T3Pt7bNb
	dt1dkBsZOiReaPMiSqZevdWPGNMhfZbWshnAk055CVnSFQMp1Az+aufg1H4gdrCuhHuiVfuNlwLN8
	SGDDabS/DgSp55i7fIrs6BwNWgXNNJPxD9CwpAzdH8hYs+lwzlMMHpTgOpcFcqxyPGNeUaoCCvSmE
	tIiWIMpuiIY31+mVCd5A5h9xjlTjNlLHyYKMgdcW4TCKuoqZUOQyEsRVGNQYlBXhVxNZoTbVkjmvL
	HQ32ooHcQ==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lPtbr-004LX4-4O; Fri, 26 Mar 2021 21:03:11 +0000
Received: from mail-pg1-f171.google.com ([209.85.215.171])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lPtbd-004LVe-RV
 for linux-nvme@lists.infradead.org; Fri, 26 Mar 2021 21:03:00 +0000
Received: by mail-pg1-f171.google.com with SMTP id e33so5411454pgm.13
 for <linux-nvme@lists.infradead.org>; Fri, 26 Mar 2021 14:02:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=2/Smtn7ScxWRu2pb7OJ1Bu//xCdoW6oh0yby3GKKoTI=;
 b=Rm+g37OUyBJsXov/tY7ZkAasWsw6AzjnSKn4bls4hjSn5cdoXLPywm73GJgHLh5MM+
 Qp6PknardUuxZGrRNw/wqOogN/0BL9ntDQ0KGdmAFMu2pgqyqrM6miXpEruacO2Hq6U1
 LdcO4XI/cKTe740//zMqri9JWU+lWFg3UvWGpKrKLK1Of2i/G8taG0Fe2dsExbBUg7OY
 3HkLzQm5r4bxLreEHqrNUUiOQfxpfwdmmWRcTD9kBgpRVWMJyaG2+YqoyHyd+/RobWCv
 eTIS3yTSKi+ogxXtGHdXYi5NzW/SE9EQs1VeIK7tRpXKxoGnsgiade/RbPQoQL58VgXN
 +l8g==
X-Gm-Message-State: AOAM531W79xUEnrcCjy7Yi0lzmLieu4Zajs3/DtUF39adA8t24a5TE8u
 DQS/RVYVimds7ObGypbi4X13+FIGVI0=
X-Google-Smtp-Source: ABdhPJxTvanDfi5bkq75gNtufCkYMJDE4k+AIWFRvrz9yKNZ/jp9T0penvUkP0YDBph18UNJRKw5iQ==
X-Received: by 2002:a62:7c0b:0:b029:1fb:6b7e:8bc6 with SMTP id
 x11-20020a627c0b0000b02901fb6b7e8bc6mr14327821pfc.0.1616792576016; 
 Fri, 26 Mar 2021 14:02:56 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:5512:a799:a5d1:66a3?
 ([2601:647:4802:9070:5512:a799:a5d1:66a3])
 by smtp.gmail.com with ESMTPSA id u2sm9195743pgf.93.2021.03.26.14.02.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 26 Mar 2021 14:02:55 -0700 (PDT)
Subject: Re: [PATCH v2] nvmet-tcp: fix a segmentation fault during io parsing
 error
To: elad.grupi@dell.com, linux-nvme@lists.infradead.org
References: <20210326175941.22734-1-elad.grupi@dell.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <19a3554b-1247-ffdf-4729-0841945b76ba@grimberg.me>
Date: Fri, 26 Mar 2021 14:02:54 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210326175941.22734-1-elad.grupi@dell.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210326_210258_162697_A627460F 
X-CRM114-Status: GOOD (  23.46  )
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org



On 3/26/21 10:59 AM, elad.grupi@dell.com wrote:
> From: Elad Grupi <elad.grupi@dell.com>
> 
> In case there is an io that contains inline data and it goes to
> parsing error flow, command response will free command and iov
> before clearing the data on the socket buffer.
> This will delay the command response until receive flow is completed.
> 
> Fixes: 872d26a391da ("nvmet-tcp: add NVMe over TCP target driver")
> Signed-off-by: Elad Grupi <elad.grupi@dell.com>
> ---
>   drivers/nvme/target/tcp.c | 29 +++++++++++++++++++++++------
>   1 file changed, 23 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
> index 70cc507d1565..3bc0caa47873 100644
> --- a/drivers/nvme/target/tcp.c
> +++ b/drivers/nvme/target/tcp.c
> @@ -702,6 +702,17 @@ static int nvmet_tcp_try_send_one(struct nvmet_tcp_queue *queue,
>   			return 0;
>   	}
>   
> +	if (unlikely((cmd->flags & NVMET_TCP_F_INIT_FAILED) &&
> +			nvmet_tcp_has_data_in(cmd) &&
> +			nvmet_tcp_has_inline_data(cmd))) {
> +		/*
> +		 * wait for inline data before processing the response
> +		 * so the iov will not be freed
> +		 */
> +		queue->snd_cmd = NULL;
> +		goto done_send;
> +	}
> +
>   	if (cmd->state == NVMET_TCP_SEND_DATA_PDU) {
>   		ret = nvmet_try_send_data_pdu(cmd);
>   		if (ret <= 0)
> @@ -1103,9 +1114,11 @@ static int nvmet_tcp_try_recv_data(struct nvmet_tcp_queue *queue)
>   		return 0;
>   	}
>   
> -	if (!(cmd->flags & NVMET_TCP_F_INIT_FAILED) &&
> -	    cmd->rbytes_done == cmd->req.transfer_len) {
> -		cmd->req.execute(&cmd->req);
> +	if (cmd->rbytes_done == cmd->req.transfer_len) {
> +		if (unlikely(cmd->flags & NVMET_TCP_F_INIT_FAILED))
> +			nvmet_tcp_queue_response(&cmd->req);
> +		else
> +			cmd->req.execute(&cmd->req);

Given that this is called twice, care to move it to
a new helper nvme_tcp_execute_request?

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
