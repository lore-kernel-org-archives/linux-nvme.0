Return-Path: <SRS0=oXoK=KQ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45FD0C4707A
	for <linux-nvme@archiver.kernel.org>; Fri, 21 May 2021 20:19:57 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 115B1613EC
	for <linux-nvme@archiver.kernel.org>; Fri, 21 May 2021 20:19:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 115B1613EC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hMe06NOWdSPbhwV11NfsckvpXH/k0FdTasSaeMp9Qgw=; b=hATembeiRGCIVaiXpxm00b8fXh
	OmOOd1y7j+MMdt8xAi/f+6eXftjyAL3kV3xPOyJVUuGuBfEsb1Yf2Ro42g6kHWRS3XOeFNt0y6h0B
	IESFVk1ZbjkrI6rxZIXHzYRssXCtThpRJZfkMP2Eb+2zxazp0ApRULM4Y7HOtWupmNGrMLK2OzQ+s
	ANbrPaZDfxEN/fvErhUMs0o6vdc23w+kY4mkmmi7d0JV/SUlZzw78B7B4clgEveY6FVPhG0C4n2Xe
	fjKx7uCExWcwFN44UQcZhuKlQyyPZ93mG+Tt5CsNiT3KAyZq/ljHeZPyChdYv4bFEc+p1KEguIbUI
	x//xeCLQ==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lkBcS-0010k7-3w; Fri, 21 May 2021 20:19:40 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lkBcL-0010iM-V6
 for linux-nvme@desiato.infradead.org; Fri, 21 May 2021 20:19:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
 Subject:Sender:Reply-To:Content-ID:Content-Description;
 bh=MOQFZcI+55Epu5CwRZbaQFCfIMzQkAmI2YuOFxHRHWY=; b=xaNJQSj28ZWLouX2IqD47rKCNX
 WuCz8stSczQ6pjgiNqJciTvusLiCR73xRl/ocmOyMOFODLEsFzo6u0wHAu2MTY7x/STAisYlkAU5I
 11pgPhS5Hzr9fxClX38rTAz3HB4w/9J6juO8HsYFoKNLt/Dtq2yeKdzOvui+1d//o3NkiOOF+/GUG
 wkhm51sqnZX5BtsjnEuddMCWTPS6D7KrDA14EsmB7yu97Bn2p/gbPU/p/I2pLlNzj7qk90ytRUtj1
 3vVN8AMVMGqxi8/lXsgEJLFYlMWfYECUqu8H8nnFxCZqpz++dqWpQnaVGuuMqF5aOb4vQnBynb90J
 vjQToKaw==;
Received: from mail-wr1-f42.google.com ([209.85.221.42])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lkBcJ-00HP9l-GM
 for linux-nvme@lists.infradead.org; Fri, 21 May 2021 20:19:32 +0000
Received: by mail-wr1-f42.google.com with SMTP id x8so22179810wrq.9
 for <linux-nvme@lists.infradead.org>; Fri, 21 May 2021 13:19:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=MOQFZcI+55Epu5CwRZbaQFCfIMzQkAmI2YuOFxHRHWY=;
 b=XhxV4HAv1Yt16qcqdrqIA885PmqCjnuhaRROVY9MNmioejZPgqH1rsy8zatZ4ydAui
 iQ0UFu8n3lDvagn+X1QNhdgeVU7l5eHd6zV4v8hLUfQy5DVtYSGjWPIlcRY9DPE5iEkM
 snhlLPbQyaqV5EIhzqjdp8zOHP4cIO2xqBbZPrLQulonnzzyHofaRY+fqUtjrxCVNHsN
 kgtabl5x8+wY6FB8fiyWPrn8YzC0Q0KlXOGbL0/0SPihNDll7iDlg9dRxiO+PNUR14ra
 0FCOK4qp4Hbjf15iDoEdZpd+/+NqepBzWT+j9TjwDLYF8YLXv9TwBLSpiMxNe2mntGQG
 qWsA==
X-Gm-Message-State: AOAM532y0IMFBqAK3UnwWPXoqDHMD8d7vnd6dbGzeLyYqSavJr3upi9n
 7oF2ghqf4pjRY2ksJJYzCLqm3Wys2Sw=
X-Google-Smtp-Source: ABdhPJw3bqMk0JtrIdEyRpkFaLXGZ0x4srfJ3bzWVQ1HPHOK4rh2SFkXELrqJ5w5TSTAepr+oW5WvQ==
X-Received: by 2002:a5d:6445:: with SMTP id d5mr11548210wrw.235.1621628369631; 
 Fri, 21 May 2021 13:19:29 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:66b2:1988:438b:4253?
 ([2601:647:4802:9070:66b2:1988:438b:4253])
 by smtp.gmail.com with ESMTPSA id i11sm3221728wrq.26.2021.05.21.13.19.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 21 May 2021 13:19:29 -0700 (PDT)
Subject: Re: [PATCH] nvme: Use NN for max_namespaces if MNAN is zero
To: Keith Busch <kbusch@kernel.org>, Daniel Wagner <dwagner@suse.de>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>
References: <20210521144734.90044-1-dwagner@suse.de>
 <20210521145306.ld7jc6alchimyzny@beryllium.lan>
 <20210521152702.GB29013@redsun51.ssa.fujisawa.hgst.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <f89bf79e-937c-96ba-4622-4a29fce00b0e@grimberg.me>
Date: Fri, 21 May 2021 13:19:26 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210521152702.GB29013@redsun51.ssa.fujisawa.hgst.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210521_131931_569756_29175CCA 
X-CRM114-Status: GOOD (  12.93  )
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


>> Forgot to mention: During testing dynamically adding namespaces it was
>> possible to trigger the WARNINGs in the nvme_parse_ana_log(). Initially
>> the subsystem started with 8 namespaces and during runtime another 8
>> namespaces was added.
> 
> The controller is required to have a non-zero MNAN value if it supports
> ANA:
> 
>    If the controller supports Asymmetric Namespace Access Reporting, then
>    this field shall be set to a non-zero value that is less than or equal
>    to the NN value.

That was my thought exactly

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
