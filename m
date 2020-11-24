Return-Path: <SRS0=KsQz=E6=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74FC5C63697
	for <linux-nvme@archiver.kernel.org>; Tue, 24 Nov 2020 03:24:09 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E2BE22085B
	for <linux-nvme@archiver.kernel.org>; Tue, 24 Nov 2020 03:24:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="vYv36PEN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2BE22085B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=1LmPS8RaAiHcZkYWRAEmBn0Cf53Oi1ZtVBirTIB5P6I=; b=vYv36PENmiSS4DEITzGjFfqH1
	iupCLlF8c6ZOtkqMwcGuU/BNRM8spCAFUYOUXfKmnhAG56am/5szfFcUo0OPLxxqU5BHvxwnSUUaG
	eFFT9h1pWM4eZ7u0wRjxql2JT2VB/6nfDlhq70JZU8mV2G//pGMDA+M4SoHMPvtQ1wtWvyYUkNcKe
	PnrANIs5PftchhzVIAI9BjgZjoVqQoeRUdKLX+TONMaZU/rEpiYZF4FYV7fBpTZH7XcwUHBU7o04d
	9Fmg7ycluujcdWzyCVQ8/IfNud8wLFZc1kBn4xADbycQgosrfyw+QJOQqQgTFj+skPjvbHKnR4+kR
	dKoPeyEng==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1khOvx-0000Ad-E8; Tue, 24 Nov 2020 03:24:01 +0000
Received: from mail-pf1-f176.google.com ([209.85.210.176])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1khOvt-00009x-Dx
 for linux-nvme@lists.infradead.org; Tue, 24 Nov 2020 03:23:58 +0000
Received: by mail-pf1-f176.google.com with SMTP id y7so17052935pfq.11
 for <linux-nvme@lists.infradead.org>; Mon, 23 Nov 2020 19:23:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=zXkjvDpid20zr1AMjWrezgoJu7BUsnH8wicWuxP+PC0=;
 b=hLOZo9VIy8+g+lw4OfYdeJ3jUG+aSelgUMreH9GMmXcMTg0FUyb8ruzZyLA6ltWtFq
 dbAyewlwlpVhCIPwBBAO4TXVmfluxPoH5IZe+1t0xk9WUs1vzaK7lZsjsOwX6bDSKskM
 tFtBfW3IR1Tqtgr04uXGxjlH2VujRSg4YIOKaZXuIYTYuyyReQToLFqgb23W6b2hyPVR
 aC9JtQSqi1sVYcZ5MIw2O7qrl5rQtn0XZbyXbKnHYHaXZiDmWYYCKJHfcitB8T0bsYXy
 BXMjkqJuzQHOT/kJPu528h69OSQUIPpAU9QWMyiB+uJSDgbUvw5vspVAI7l0Lu34NC1x
 Z0uQ==
X-Gm-Message-State: AOAM532DDa1n9PODhyMkB5oDFYCo6y8QuK7SjLQ18Q4pBrgUY9IrOQyW
 +n8z9NFu9GC+HPBkdbwRK2cdX4fbTbU=
X-Google-Smtp-Source: ABdhPJxzf0jknZnzjNudUmEEQiSvjT+xGaYIFP0Nmrj75T6klNXYVWji/TSaYPIgQmjKcgNuyv2TNg==
X-Received: by 2002:a63:4623:: with SMTP id t35mr2075311pga.270.1606188234495; 
 Mon, 23 Nov 2020 19:23:54 -0800 (PST)
Received: from [192.168.3.218] (c-73-241-217-19.hsd1.ca.comcast.net.
 [73.241.217.19])
 by smtp.gmail.com with ESMTPSA id h7sm13290845pgi.90.2020.11.23.19.23.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 23 Nov 2020 19:23:53 -0800 (PST)
Subject: Re: [PATCH blktests 1/5] tests/srp/rc: update the ib_srpt module name
To: Yi Zhang <yi.zhang@redhat.com>, osandov@osandov.com
References: <20201124010427.18595-1-yi.zhang@redhat.com>
 <20201124010427.18595-2-yi.zhang@redhat.com>
From: Bart Van Assche <bvanassche@acm.org>
Message-ID: <7b6d00d7-2cf8-5a4b-f861-a7efe152843f@acm.org>
Date: Mon, 23 Nov 2020 19:23:51 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.3
MIME-Version: 1.0
In-Reply-To: <20201124010427.18595-2-yi.zhang@redhat.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201123_222357_485909_5DE69338 
X-CRM114-Status: GOOD (  10.52  )
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
Cc: linux-block@vger.kernel.org, sagi@grimberg.me,
 linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 11/23/20 5:04 PM, Yi Zhang wrote:
> -	insmod "/lib/modules/$(uname -r)/kernel/drivers/infiniband/ulp/srpt/ib_srpt.ko" "${opts[@]}" || return $?
> +	insmod "$(ls /lib/modules/"$(uname -r)"/kernel/drivers/infiniband/ulp/srpt/ib_srpt.*)" "${opts[@]}" || return $?

Is 'ls' needed here or is 'echo' sufficient?

Thanks,

Bart.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
