Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA35CC433EF
	for <linux-nvme@archiver.kernel.org>; Thu,  7 Apr 2022 13:43:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=PkHNed3a1WHntT1KGtUv9DmTCyCs1xLs9qNE/Bzpp78=; b=jYrJEFpIa+l9r4xuwFtOELJL7d
	h+rO34MgYhu39lTN4N6bi3ABg2o23Hf/0qg90tt4EXZ+63LfFxkkim1ujxd/sZ+hDPiFrgARbjan/
	7EIk4ZVf7iapRhjTjdS39pyUdBVNtFuUbpsK/lzfC/gNXcAiUE4XY23oU3xS6OBjyyTYQQh920Ja2
	AbT8V3xYNOXA3YBkdgiftU9vVaf1dftVP4KmRCYw181oHo7PI2M9vhZjqdVdf1KOzWSNUbOdDVk4Y
	Q0wJfLabUCvfMjTe2gDYFhmWGyntXRKlPwqUKQ4EV9ALuA1AEp0fL872amTQ+dN4ggtIvMw/I+1WN
	jESGvIPA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ncSPe-00CCjz-Fu; Thu, 07 Apr 2022 13:43:02 +0000
Received: from mail-wm1-f53.google.com ([209.85.128.53])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1ncSPb-00CCjI-9Q
 for linux-nvme@lists.infradead.org; Thu, 07 Apr 2022 13:43:00 +0000
Received: by mail-wm1-f53.google.com with SMTP id
 m67-20020a1ca346000000b0038e6a1b218aso3705421wme.2
 for <linux-nvme@lists.infradead.org>; Thu, 07 Apr 2022 06:42:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=PkHNed3a1WHntT1KGtUv9DmTCyCs1xLs9qNE/Bzpp78=;
 b=HPoX52kM96mXeRniN2LC3+fVpQCYRJaLR+IkfBgN7PV4sDP0W71fD0Vyb0z370dVnK
 u/qU78u8DL+HdhHbMhgYqm8sAYk1bhsXhKQbBOErPTM+UGsifJmZ+RpJ8/msbnExvSj4
 qySR5TYc4KDxmuFg+WyIb+8Dvu7qqdJeXSKQeOd1K+GTOBpf/t6m8jLc2QJ+WEQMr4va
 NgJoM3xusqmMHFt+cAQTV6iHpbyyVX8NzLkLMAEOK7AR8m42ryVotnDJv9DO/76F9OCP
 YXEFZX2kde4f9LhYutaY4sLf6yn2D3bdw6HMqFn/8qol3o9mMxDN1X2+pYxPoVmsrIsT
 Vzfw==
X-Gm-Message-State: AOAM532ULhgkMMzWo5qYH/r/u5FZ+o3FNNb+ub/4EIp3NQzC9mlQ/EQ6
 tboDujNHHP37S/yaijFPaCE=
X-Google-Smtp-Source: ABdhPJxTOu1skiup6A2q7dlp+ZdpPQIPkwHcTyIM94WIbwFA/skP7rUDPrUxEYuLOn7lk9cQhXyrMA==
X-Received: by 2002:a1c:e908:0:b0:38c:782c:2a62 with SMTP id
 q8-20020a1ce908000000b0038c782c2a62mr12502140wmc.135.1649338976491; 
 Thu, 07 Apr 2022 06:42:56 -0700 (PDT)
Received: from [192.168.64.180] (bzq-219-42-90.isdn.bezeqint.net.
 [62.219.42.90]) by smtp.gmail.com with ESMTPSA id
 61-20020adf8043000000b00205e1d92a41sm17780268wrk.74.2022.04.07.06.42.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 07 Apr 2022 06:42:55 -0700 (PDT)
Message-ID: <48363e60-d506-b1bf-cb3a-db781290f285@grimberg.me>
Date: Thu, 7 Apr 2022 16:42:55 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] nvme-tcp: handle failing req immediately for
 REQ_FAILFAST_DRIVER
Content-Language: en-US
To: Daniel Wagner <dwagner@suse.de>
Cc: linux-nvme@lists.infradead.org, Martin.Belanger@dell.com
References: <20220407092540.66227-1-dwagner@suse.de>
 <eef5eda6-f00f-b879-858f-80f7ce44a362@grimberg.me>
 <20220407122054.reywmgnysnhryvg2@carbon.lan>
 <129b9f99-fd4d-1920-dee8-652e774a3b57@grimberg.me>
 <20220407133806.xawe6y5v5uec4vzi@carbon.lan>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20220407133806.xawe6y5v5uec4vzi@carbon.lan>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220407_064259_378543_4C87E255 
X-CRM114-Status: GOOD (  12.61  )
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


>>>> I'm wandering if this will race with nvme_cancel_admin_tagset which
>>>> can also complete the command... The whole assumption is that the
>>>> cancel iterator will be running as the socket is shutdown by the peer
>>>> and error_recovery was triggered.
>>>>
>>>> I think these shouldn't race because we shutdown the queue (and flush
>>>> the io_work) and only then cancel. But I've seen races of that
>>>> sort in the past...
>>>
>>> This particular request is issued by nvme_shutdown_ctrl() so we know
>>> exactly where we are. But this might not be the case for any other
>>> REQ_FAILFAST_DRIVER flagged request. So this might introduce the race
>>> you are pointing out.
>>>
>>> The option is see is what Margin suggested in
>>>
>>> http://lists.infradead.org/pipermail/linux-nvme/2021-September/027867.html
>>
>> Don't know if I like the state check. Why this does not apply in a ctrl
>> reset?
> 
> Understood. Would something like this work
> 
>        struct request *rq = blk_mq_rq_from_pdu(queue->request);
>        bool queue_ready = test_bit(NVME_TCP_Q_LIVE, &queue->flags);
> 
>        dev_err(queue->ctrl->ctrl.device,
>                "failed to send request %d\n", ret);
>        if ((ret != -EPIPE && ret != -ECONNRESET) ||
>            (!queue_ready && rq->cmd_flags & REQ_FAILFAST_DRIVER))
>                nvme_tcp_fail_request(queue->request);
> 
> ?

But in your case the queue is live...

I'm thinking that we maybe need a register access timeout value for
fabrics...

