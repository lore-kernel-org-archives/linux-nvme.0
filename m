Return-Path: <SRS0=jy92=BI=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78801C433E0
	for <linux-nvme@archiver.kernel.org>; Wed, 29 Jul 2020 04:35:46 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 40EEE2070B
	for <linux-nvme@archiver.kernel.org>; Wed, 29 Jul 2020 04:35:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="OZD4HkWN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40EEE2070B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=vvX4YyoSMB1+/sZzcauonrfCsToCEnjtNGann3OWM9A=; b=OZD4HkWN/ctYABq0zZfzCpH9D
	teMOkVxGI8N2cbcYpEOyFcnBILMsLuJAEHm/8Cg2tiOpNZDNON94r7Kb/UTG3N2+I7CCAUPqDu/RE
	0t/xZEq2JmwePq49Bp1LE0NNkXUAe+5aqkYL5vTi4RQNjrYma1tdB+5tp4OyxkeVHn/tLX096gZmH
	oY9OIChnNlcLEp4kyq8A5+U5OhPd7YiJchfOh3xCD7mq/3tJ1NV4CZwpyYFhrxiXQMrrCF+yy/Y2X
	+fcQRQDcJaKC8b+KgG70CAkN8FNnXOwcR3Z+buFb/HoCN6T1iJmgYzNdf4af7hEQa8Ws44jb3jeZf
	X0YSpmGkQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k0dob-0008KC-KX; Wed, 29 Jul 2020 04:35:41 +0000
Received: from mail-pj1-f65.google.com ([209.85.216.65])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k0doZ-0008Jo-7y
 for linux-nvme@lists.infradead.org; Wed, 29 Jul 2020 04:35:40 +0000
Received: by mail-pj1-f65.google.com with SMTP id c6so1290900pje.1
 for <linux-nvme@lists.infradead.org>; Tue, 28 Jul 2020 21:35:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=H1N6MYkV3QYH2b4Eayu5uhLDIzqScSmdjewq6O7FWck=;
 b=Ru7cITIeEWTnh077lSWCZkfhQ3ISy0RPpT/pVFXB1M1dp8HPdr83OgRL0DzN7BB9G0
 re8IB7ns9auJaf7cMEbIMtnZLLu9csIeo4eaSQpKzfWE1EaJdtIBzqZDkcEZ3tDxHMrE
 JSh7oxyglZA2edlVL7i1uVYHdMnPGk4vEl4tmbL+HGIvSfwpk/3r4nmMe8CP85Wv+NkR
 y4q+/zrOAFzY/kryzJSmAdVJV1RP+ZD653YFrNA30Mf7zPUi0EnQx+stQWLaHvFyAF14
 ZmBjVSp5biLY5JCZNy0TKlqdJ9vUuBQcmr7UcSqbzyeDbvEUXidmfYf0LuK/2b/fFDPo
 xy7Q==
X-Gm-Message-State: AOAM531NJEFA2mhJg42HW8Qy4j0LKnq/uiKEKo5rOlpVT1Ref3E+cqjF
 ppTIFcXbFqnqVJxr95hDrQ8=
X-Google-Smtp-Source: ABdhPJxX0k+gkAQ/VekWE2Uqs41WPBvjsKQwqgY2wsQWxPj/kuWZ3+KIIAz5ywyZUsCy8ZaeTAiEXg==
X-Received: by 2002:a17:90a:7184:: with SMTP id
 i4mr7786823pjk.75.1595997336193; 
 Tue, 28 Jul 2020 21:35:36 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:fcc5:69d8:6e20:4fd1?
 ([2601:647:4802:9070:fcc5:69d8:6e20:4fd1])
 by smtp.gmail.com with ESMTPSA id t29sm623471pfq.50.2020.07.28.21.35.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 Jul 2020 21:35:35 -0700 (PDT)
Subject: Re: [PATCH 1/2] nvme-loop: set ctrl state connecting after init
To: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
 linux-nvme@lists.infradead.org
References: <20200729023648.38677-1-chaitanya.kulkarni@wdc.com>
 <20200729023648.38677-2-chaitanya.kulkarni@wdc.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <fdc2ae4c-1505-4157-46ea-179d44ac332f@grimberg.me>
Date: Tue, 28 Jul 2020 21:35:34 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200729023648.38677-2-chaitanya.kulkarni@wdc.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200729_003539_310691_0DF86C8E 
X-CRM114-Status: GOOD (  13.99  )
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
Cc: hch@lst.de
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org



On 7/28/20 7:36 PM, Chaitanya Kulkarni wrote:
> When creating a loop controller (ctrl) in nvme_loop_create_ctrl() ->
> nvme_init_ctrl() we set the ctrl state to NVME_CTRL_NEW.
> 
> Prior to [1] NVME_CTRL_NEW state was allowed in nvmf_check_ready() for
> fabrics command type connect. Now, this fails in the following code path
> for fabrics connect command when creating admin queue :-
> 
> nvme_loop_create_ctrl()
>   nvme_loo_configure_admin_queue()
>    nvmf_connect_admin_queue()
>     __nvme_submit_sync_cmd()
>      blk_execute_rq()
>        nvme_loop_queue_rq()
> 	nvmf_check_ready()
> 
> # echo  "transport=loop,nqn=fs" > /dev/nvme-fabrics
> [ 6047.741327] nvmet: adding nsid 1 to subsystem fs
> [ 6048.756430] nvme nvme1: Connect command failed, error wo/DNR bit: 880

I have exactly the same patch to send tonight :)

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Tested-by: Sagi Grimberg <sagi@grimberg.me>

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
