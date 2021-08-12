Return-Path: <SRS0=ZjMq=ND=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A1D9C4338F
	for <linux-nvme@archiver.kernel.org>; Thu, 12 Aug 2021 16:31:01 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B2A0603E7
	for <linux-nvme@archiver.kernel.org>; Thu, 12 Aug 2021 16:31:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 2B2A0603E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:Cc:To:Subject:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=C3npMcYmM5RgvMtFoS7wNeY/QjIdr/KlVSrhiyh/32c=; b=GowuBzDBwpqczVp0hSP7jQ8eJ/
	9xViyZhVVI2X3V7HO6zStRAimoXdhKEU+Gic4/Fjd7gRw3lZR1EOUkXzei7W8YKaQNlp9HAe9bED0
	tp4MNgXskqJvB3v205WYi+/euEIRl8Y6wKI+Nn2iceaW5pG17PnC8s/ZR8k5Jl/QuzRxEfb4FFay0
	akJdoe2rLKbDHB7xN10BkkzF+z67T5+TzBDMD1L1ZAOkzv+iDhV0j9kC31/AgvpVemhCu9ks0XL4F
	6Lry/2RCO2ZuFG5IBA9jrbdicPvcEZHqkK9oB9x7frKL2G9lhdKz+SdBGAAbb7Dj2IEikYiLt45We
	8fNS+vVg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mEDbF-00Aede-E6; Thu, 12 Aug 2021 16:30:33 +0000
Received: from mail-oi1-x236.google.com ([2607:f8b0:4864:20::236])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mEDbC-00AecJ-PM
 for linux-nvme@lists.infradead.org; Thu, 12 Aug 2021 16:30:32 +0000
Received: by mail-oi1-x236.google.com with SMTP id bj40so11235112oib.6
 for <linux-nvme@lists.infradead.org>; Thu, 12 Aug 2021 09:30:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel-dk.20150623.gappssmtp.com; s=20150623;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=x4cHlQi/obhutO8LyeLFAXruEbBUWhCtJGxWE1s0N8U=;
 b=1rQ0mvustmtHXZ9U4L7gESxZbbqf2omo6y+0DkbXfIM5f7jDR1C54mTtLi+VBRe8Ri
 eKlcSaEDchw6I1SlloYW3zJh04HuTIYO+Q882Jty+7he4kk9+5qPwRsQsLOZVeMjMIsc
 oi3ti9jbeFQ7J/hgVkb0EM50yCmk+wxySBnupMJHBjAM0Bx5zUYk34ix6PG4vi9yZ7oa
 d48PgHNqKN03IFkifLYQ62bUSU7YhdJZ0I9vvA5ZLVJIw2JCm7DusCjxWeO87jlAh9zg
 oSC9fDh0NRkzMVe+Tlv05IDtO33QLAZpSejO9BUjaeTjO8bYFsIpetOwwMJGZLXPeFsA
 N4Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=x4cHlQi/obhutO8LyeLFAXruEbBUWhCtJGxWE1s0N8U=;
 b=EocDfYG+SWMxfBf2Y0YsjkQUghPTSLkqEadhJnZp9Ut8NRd4CrDNRr/4dB7EKKCZMj
 r3jlFg+eTXBDxUA1LUwQ7xnytDP1EclUDzVq2RVRteSygOpjtNt+PiXhexBZ+SLxh2p8
 MhqQ9mn9O48zAo6J6J/EQ0adpnTLYjGZFpihk0tdVxaQoksTMfh5AZIRryHsYGcfwbMk
 Fcovj+Zfq3JOo+dbch9DTvdVT+l4phkoqgegPAytZ5QalacwX/x98h/MkriewVOlUZdl
 pm0OxXdrz9me6vtUdyqssY17sfnrtJR/JC0CoNpcbAbGPu5lM4zPCEa3zo9o/nxvVGwE
 N/hw==
X-Gm-Message-State: AOAM533Fb9XDzCxQdIMS2A4mVDBU1NyCRRN0FwUoyUjcwKAJmR+EWU5M
 /sCL4xV/E818bO5Tn3JjCLy/g53wHbslWA3j
X-Google-Smtp-Source: ABdhPJy2dkFA+KnUiS1sS6pKuw2wcOYGZn612cKtDfh2S9ahMGuS9i7oBMQNyXf3JaG+igFZLuxRCw==
X-Received: by 2002:aca:1c0a:: with SMTP id c10mr4010067oic.87.1628785827272; 
 Thu, 12 Aug 2021 09:30:27 -0700 (PDT)
Received: from [192.168.1.30] ([207.135.234.126])
 by smtp.gmail.com with ESMTPSA id m9sm637634ooe.32.2021.08.12.09.30.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 12 Aug 2021 09:30:26 -0700 (PDT)
Subject: Re: remove GENHD_FL_UP
To: Christoph Hellwig <hch@lst.de>
Cc: Coly Li <colyli@suse.de>, Song Liu <song@kernel.org>,
 Ulf Hansson <ulf.hansson@linaro.org>, Luis Chamberlain <mcgrof@kernel.org>,
 linux-block@vger.kernel.org, linux-bcache@vger.kernel.org,
 linux-raid@vger.kernel.org, linux-mmc@vger.kernel.org,
 linux-nvme@lists.infradead.org
References: <20210809064028.1198327-1-hch@lst.de>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <477bcf09-1711-b643-85b2-e8f0809b6dda@kernel.dk>
Date: Thu, 12 Aug 2021 10:30:25 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210809064028.1198327-1-hch@lst.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210812_093030_874642_08BDAFAF 
X-CRM114-Status: GOOD (  13.12  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 8/9/21 12:40 AM, Christoph Hellwig wrote:
> Hi Jens,
> 
> this series first cleans up various drivers to not rely on the
> internal GENHD_FL_UP to decided if they need to call del_gendisk
> and then removes the flag entirely.

Applied, thanks.

-- 
Jens Axboe


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
