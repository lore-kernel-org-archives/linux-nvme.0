Return-Path: <SRS0=yBWI=D6=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D84DDC56201
	for <linux-nvme@archiver.kernel.org>; Fri, 23 Oct 2020 21:16:11 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3BAF722273
	for <linux-nvme@archiver.kernel.org>; Fri, 23 Oct 2020 21:16:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="pg1eQgdf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BAF722273
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=BbC7UQm7MDViSKE3rBqJu5EdvzRiQoOqsHkV6Fjecdk=; b=pg1eQgdf8TS0N2JmvucLznEjb
	bBEmx94g4b4g/FTNlbLdpggG8e0Ibl2cGkio+BPCN3lYA693GpwHlLkZgU20wdPqJog1BADjuYkax
	soG3wmd02NwePlkYtA0VfqhQRXEu9qJNAYYTd7ANws7jMRj+TaUlaf+DR59g1VHeueblqvnCSg5Ak
	EKStXXR6FDB92i8TKa8LMZlY8RvPy65RrHTw93QudhTUI8yokt6jMSDVRcr7ieeIPfqEK15nPIvOz
	xKXvtrgaeZZoOWhf7h6EMtp2l8TX75kMz1pW0jA2FKtgrh+m/qtwJH8/LLco/Q0Tfy3ZhOYHwdHu1
	+AbaK+s4g==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kW4Pw-00029F-48; Fri, 23 Oct 2020 21:16:08 +0000
Received: from mail-wr1-f65.google.com ([209.85.221.65])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kW4Pu-00028k-0R
 for linux-nvme@lists.infradead.org; Fri, 23 Oct 2020 21:16:06 +0000
Received: by mail-wr1-f65.google.com with SMTP id e17so3839928wru.12
 for <linux-nvme@lists.infradead.org>; Fri, 23 Oct 2020 14:16:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=0BRJ/wsUZdP4reNUddupVhn2B5Gn1LTCWpYvUZWLvXU=;
 b=bx/kJO3raxRPyc5mGOJ0nNxTXBYDOPt/KbvZniCoUxans8ZIV8M8qj5nDEYzEcXjcW
 IHRDDYqGV1X7myun/cavDwNUv6eAIxybbRt5XHWvRADsEPJLwYJ7m4GaHVtJASWh2wPB
 VrvR0tPJv0LTWDPClverbJtRB+le6aSV71c9RH5fF17YygSgMTM4OP54bu/3GEwPreb9
 bloFWtaYoXM61Qlib356L0gdvJAqLQBOLPZUOKPja9Y+agjCjTuvd4yKPAwKR/EisIDp
 JrwQJQW6YPcAonW0fDK96/DS08FjnsEFR8yVk9oi+rSdPiLa1S7skc6LtUJoaL0zfGJf
 DlQA==
X-Gm-Message-State: AOAM533TSsesIo6CsDz/ZGKWifU1Lup8F5MNt9KaNx+aDjdIkB8Ieyo3
 eCDgWJG8+3zC7Cyvg4wl3U7O38sXuqA=
X-Google-Smtp-Source: ABdhPJz0jF7ichO6KLZ+TaL5BVKcv8eawJPbRSgghKCChKHhDRd1Q//WiU2OlS8WOYKAqLUlq9KK/w==
X-Received: by 2002:a5d:508f:: with SMTP id a15mr4454488wrt.417.1603487764068; 
 Fri, 23 Oct 2020 14:16:04 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:f912:ab69:c0c3:c2f7?
 ([2601:647:4802:9070:f912:ab69:c0c3:c2f7])
 by smtp.gmail.com with ESMTPSA id y185sm5249414wmb.29.2020.10.23.14.16.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 23 Oct 2020 14:16:03 -0700 (PDT)
Subject: Re: [PATCH] nvme-cli: remove default ctrl_loss_tmo for connect
To: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
 linux-nvme@lists.infradead.org
References: <20201023202521.9610-1-chaitanya.kulkarni@wdc.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <5c212507-d518-5343-3836-93107cfea53f@grimberg.me>
Date: Fri, 23 Oct 2020 14:16:01 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201023202521.9610-1-chaitanya.kulkarni@wdc.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201023_171606_087394_31475DE2 
X-CRM114-Status: GOOD (  14.03  )
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
Cc: kbusch@kernel.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


> diff --git a/fabrics.c b/fabrics.c
> index f8a055b..9c33c02 100644
> --- a/fabrics.c
> +++ b/fabrics.c
> @@ -896,8 +896,6 @@ static int build_options(char *argstr, int max_len, bool discover)
>   				cfg.keep_alive_tmo, false)) ||
>   	    add_int_argument(&argstr, &max_len, "reconnect_delay",
>   				cfg.reconnect_delay, false) ||
> -	    add_int_argument(&argstr, &max_len, "ctrl_loss_tmo",
> -				cfg.ctrl_loss_tmo, true) ||

You just removed the entire option altogether? the user can no longer
pass ctrl_loss_tmo now. You should instead disallow zero back (i.e.
revert the offending patch that made it as such) and figure out
a proper way to allow ctrl_loss_tmo=0 functionality.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
