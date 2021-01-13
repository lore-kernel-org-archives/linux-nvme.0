Return-Path: <SRS0=mLmp=GQ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68BD3C433DB
	for <linux-nvme@archiver.kernel.org>; Wed, 13 Jan 2021 22:47:37 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EDCCA23370
	for <linux-nvme@archiver.kernel.org>; Wed, 13 Jan 2021 22:47:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EDCCA23370
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=BCxQ8De1onMBeg32z3QoDDP7GLzGr/Yfv/oEsPOpzVY=; b=Q9GODeMt+GWHK0IJ16sb5i7n3
	rbTH+ghbfSrslShP5zgZj6b3RJ5GbMmqwk77ZgB6tbq3XnbtVhgc9Bcl2UrIcGEbMPOin8TxwkfEm
	CYfA24DZPA8PEFcW+KmSWDdLwtnJCJVh8NIcyXTar0PzMRh9KqouUzhUSeyumiqYtPVPLBh3gPu3j
	kvLjU6BCKQ9DNUVDqQOrAuMBXKmFJTwKE8q4hGpvzS2cP2NuHTKJ2QCftpubv3bKEWd9IRPmbvtZs
	tdhjCYwRt7chN4TdTzqpPTbG+W+cLjYmCrNz9yyJOyKqxQmeqt4Xf6mm+eUL9AfZjk/7sk2l5XkwX
	zY6J9Z2Gg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kzovG-0004Kf-L5; Wed, 13 Jan 2021 22:47:26 +0000
Received: from mail-wm1-f47.google.com ([209.85.128.47])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kzovE-0004IF-0a
 for linux-nvme@lists.infradead.org; Wed, 13 Jan 2021 22:47:25 +0000
Received: by mail-wm1-f47.google.com with SMTP id g25so4448340wmh.1
 for <linux-nvme@lists.infradead.org>; Wed, 13 Jan 2021 14:47:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=a02I8P5pUXgdpoNWGL6fPa+DSdcjzR38oGNGlYrSX7s=;
 b=DuzMSJaQ5xIkpE1SyAQZtauvC0g25mGhJKXuH9hmzWbcm2HcWMdSdVFvsdIjzs3EJb
 RvGyYfo6tdNGiNo2ocySPpJlCRMJ88B2yjPgQZtYzMOuqv+T8cMgL5c6xgaL6KZeQShI
 MJ4zIO/O1CfnwtdqEChyOKAwICyWzHl8rGvQGugblzA8ILk+gmGMgyA/4ov2ots8cyaL
 kIy+6lNJMM8hZwc5DQsNZNmDd/c5pFnJ8PLPfVqsWxwjpEHgyxJUUIHTm1VFd4ANDqUB
 Z0oHFHw/e0LCyqays+YL+PGe+Wx3cTlN3/5ZQy0M+qo8JACdR7ExYB5/VkQ+Q1t46krk
 8+aw==
X-Gm-Message-State: AOAM533de1KQduIy6pToJZmM7vfvXgzlQaleiAP3QIJIKD33QxoFTtGx
 jtYSfxP3HQVXlD/2seIv2v59P77WrSo=
X-Google-Smtp-Source: ABdhPJyNXLetA8AF6W2K5OEZPpZmi8FMX+YhdlQJupQ0quMLuAqf5O/BlA2NQemXHDMzspI+FLQkKw==
X-Received: by 2002:a1c:a9cf:: with SMTP id s198mr1205431wme.65.1610578041470; 
 Wed, 13 Jan 2021 14:47:21 -0800 (PST)
Received: from ?IPv6:2601:647:4802:9070:e70c:620a:4d8a:b988?
 ([2601:647:4802:9070:e70c:620a:4d8a:b988])
 by smtp.gmail.com with ESMTPSA id v14sm5337379wru.8.2021.01.13.14.47.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 13 Jan 2021 14:47:21 -0800 (PST)
Subject: Re: [PATCH] nvme-tcp: fix a segmentation fault during io parsing error
To: elad.grupi@dell.com, linux-nvme@lists.infradead.org
References: <20210113115152.69692-1-elad.grupi@dell.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <ad9f038b-9920-21da-755c-85f4e2228a22@grimberg.me>
Date: Wed, 13 Jan 2021 14:47:18 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210113115152.69692-1-elad.grupi@dell.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210113_174724_205684_62167E38 
X-CRM114-Status: GOOD (  21.87  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
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

Hey Elad,

> From: Elad Grupi <elad.grupi@dell.com>
> 
>      In case there is an io that contains inline data and it goes to
>      parsing error flow, command response will free command and iov
>      before clearing the data on the socket buffer.
>      This will delay the command response until receive flow is completed.
> 
> Signed-off-by: Elad Grupi <elad.grupi@dell.com>
> ---
>   drivers/nvme/target/tcp.c | 7 ++++++-
>   1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
> index d535080b781f..dea94da4c9ba 100644
> --- a/drivers/nvme/target/tcp.c
> +++ b/drivers/nvme/target/tcp.c
> @@ -146,6 +146,7 @@ static struct workqueue_struct *nvmet_tcp_wq;
>   static struct nvmet_fabrics_ops nvmet_tcp_ops;
>   static void nvmet_tcp_free_cmd(struct nvmet_tcp_cmd *c);
>   static void nvmet_tcp_finish_cmd(struct nvmet_tcp_cmd *cmd);
> +static void nvmet_tcp_queue_response(struct nvmet_req *req);
>   
>   static inline u16 nvmet_tcp_cmd_tag(struct nvmet_tcp_queue *queue,
>   		struct nvmet_tcp_cmd *cmd)
> @@ -476,7 +477,11 @@ static struct nvmet_tcp_cmd *nvmet_tcp_fetch_cmd(struct nvmet_tcp_queue *queue)
>   		nvmet_setup_c2h_data_pdu(queue->snd_cmd);
>   	else if (nvmet_tcp_need_data_in(queue->snd_cmd))
>   		nvmet_setup_r2t_pdu(queue->snd_cmd);
> -	else
> +	else if (nvmet_tcp_has_data_in(queue->snd_cmd) &&
> +			nvmet_tcp_has_inline_data(queue->snd_cmd)) {

This deserves a comment I think.

Did you get a chance to look into what I sent you guys?

> +		nvmet_tcp_queue_response(&queue->snd_cmd->req);
> +		queue->snd_cmd = NULL;
> +	} else
>   		nvmet_setup_response_pdu(queue->snd_cmd);
>   
>   	return queue->snd_cmd;
> 

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
