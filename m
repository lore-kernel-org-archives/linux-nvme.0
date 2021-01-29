Return-Path: <SRS0=47LT=HA=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0F55C433E0
	for <linux-nvme@archiver.kernel.org>; Fri, 29 Jan 2021 01:54:36 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 21F1464DD8
	for <linux-nvme@archiver.kernel.org>; Fri, 29 Jan 2021 01:54:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21F1464DD8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=ZtwEWUVnyI7+Q2BqtA4bBAsD0tTPkZp9JkSXkAKx8fU=; b=yFq6CWOFoISu2LOr2eg5Qbkxm
	f9eyPh3gJAba5r6cIiK83ODYe7GNT0nUNN13xyNuGJAgoWrYzQrRwmnVUA7lXNGmWzuGemegtELmm
	y1EYSY4sdoiWr4fieulHZG4xYI+SYHC6gq+gIPhF6Cn/Nz/uRaNJYCexpL3yiZg4MHIRnxkR0Y1dn
	C8XYG9jk/8HakZWiyYgVRm5CxKVqa0jfD1xcoD6aFzpajwCH6SUJST3pC4zdMsbO4t4vFufPyAMQF
	jf4Rl9CyTRbSWSWUJcuEqphC/J149SpKE5hnWWLo0DaDHYquIZMMdYskjj9U1JeSdDGZ+EaB8Mj5B
	zMUa6slBw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l5IzV-0002eW-Fy; Fri, 29 Jan 2021 01:54:29 +0000
Received: from mail-wr1-f42.google.com ([209.85.221.42])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l5IzT-0002dz-KF
 for linux-nvme@lists.infradead.org; Fri, 29 Jan 2021 01:54:28 +0000
Received: by mail-wr1-f42.google.com with SMTP id 6so7306810wri.3
 for <linux-nvme@lists.infradead.org>; Thu, 28 Jan 2021 17:54:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=OK2sd1ybpEqKKRRgh4GAmhB0qDghfrcwnIS+y4jFwSY=;
 b=Sy0LEymr0YexoEqqKlH0mCHCbwguLW/dwpbPSiRpCmdMrQiGfZfIbr6GOps2ZQYK/4
 eao5QziXhWI9jS594OH3MIaMjlnD00qMAG8CJXXd2ldrPu7zKPTX8JuwzUNDUf7WAb0i
 zfroyt2ld/HcJXjQbfLH5ktb8hoBWAtKoQV8h816QVKLQGNAEe3FHzhdWTiad+VV9HUe
 cBhhs5fDehgdGzq43qauoziD/PO8WKQ9WwzzgkSSpsLjxRUhT4j0853I4A+WDIEyXfft
 7L5jjEH3uNA7BpVke8HGVQaf9o+ezqJBSBU7iTidVBkh+UBykA0US79iWCXjPBrELkL+
 3PtA==
X-Gm-Message-State: AOAM5337e+YQtCykZz1uxtqaTtDA/lhnNY7AuP8U0RRi01pHw5KDFqEQ
 rtB/KjbFlUE6otC+f43ySBg=
X-Google-Smtp-Source: ABdhPJyWJGJMxRCBGmdKrHigaO0ow31V1AYTodhklBSdIFb+66TtV89PFpmayc/syRCDt7Xqdc052A==
X-Received: by 2002:a5d:5112:: with SMTP id s18mr1812257wrt.267.1611885266496; 
 Thu, 28 Jan 2021 17:54:26 -0800 (PST)
Received: from ?IPv6:2601:647:4802:9070:3d48:4849:d506:e578?
 ([2601:647:4802:9070:3d48:4849:d506:e578])
 by smtp.gmail.com with ESMTPSA id f17sm10086982wrv.0.2021.01.28.17.54.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 28 Jan 2021 17:54:26 -0800 (PST)
Subject: Re: [PATCH 16/35] monitor: reset children's signal disposition
To: mwilck@suse.com, Keith Busch <kbusch@kernel.org>,
 linux-nvme@lists.infradead.org
References: <20210126203324.23610-1-mwilck@suse.com>
 <20210126203324.23610-17-mwilck@suse.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <35ef1b10-1d24-f0f3-3af8-2d14d710533c@grimberg.me>
Date: Thu, 28 Jan 2021 17:54:22 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210126203324.23610-17-mwilck@suse.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210128_205427_713444_84F5077F 
X-CRM114-Status: GOOD (  20.86  )
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
Cc: Hannes Reinecke <hare@suse.de>,
 Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

No commit message?

> 
> Signed-off-by: Martin Wilck <mwilck@suse.com>
> ---
>   monitor.c | 30 ++++++++++++++++++++++++++++--
>   1 file changed, 28 insertions(+), 2 deletions(-)
> 
> diff --git a/monitor.c b/monitor.c
> index 69c8333..9375a14 100644
> --- a/monitor.c
> +++ b/monitor.c
> @@ -100,6 +100,8 @@ static void monitor_int_handler(int sig)
>   	must_exit = 1;
>   }
>   
> +static sigset_t orig_sigmask;
> +
>   static int monitor_init_signals(void)
>   {
>   	sigset_t mask;
> @@ -110,7 +112,7 @@ static int monitor_init_signals(void)
>   	 * for events.
>   	 */
>   	sigfillset(&mask);
> -	if (sigprocmask(SIG_BLOCK, &mask, NULL) == -1)
> +	if (sigprocmask(SIG_BLOCK, &mask, &orig_sigmask) == -1)
>   		return -errno;
>   	if (sigaction(SIGTERM, &sa, NULL) == -1)
>   		return -errno;
> @@ -119,6 +121,26 @@ static int monitor_init_signals(void)
>   	return 0;
>   }
>   
> +static int child_reset_signals(void)
> +{
> +	int err = 0;
> +	struct sigaction sa = { .sa_handler = SIG_DFL, };
> +
> +	if (sigaction(SIGTERM, &sa, NULL) == -1)
> +		err = errno;
> +	if (sigaction(SIGINT, &sa, NULL) == -1 && !err)
> +		err = errno;
> +	if (sigaction(SIGCHLD, &sa, NULL) == -1 && !err)
> +		err = errno;
> +
> +	if (sigprocmask(SIG_SETMASK, &orig_sigmask, NULL) == -1 && !err)
> +		err = errno;
> +
> +	if (err)
> +		log(LOG_ERR, "error resetting signal handlers and mask\n");
> +	return -err;
> +}
> +
>   static int monitor_get_fc_uev_props(struct udev_device *ud,
>   				    char *traddr, size_t tra_sz,
>   				    char *host_traddr, size_t htra_sz)
> @@ -176,8 +198,12 @@ static int monitor_discovery(char *transport, char *traddr, char *trsvcid,
>   	if (pid == -1) {
>   		log(LOG_ERR, "failed to fork discovery task: %m");
>   		return -errno;
> -	} else if (pid > 0)
> +	} else if (pid > 0) {
> +		log(LOG_DEBUG, "started discovery task %ld\n", (long)pid);
>   		return 0;
> +	}
> +
> +	child_reset_signals();
>   
>   	log(LOG_NOTICE, "starting %s discovery for %s==>%s(%s)\n",
>   	    transport, host_traddr, traddr, trsvcid ? trsvcid : "none");
> 

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
