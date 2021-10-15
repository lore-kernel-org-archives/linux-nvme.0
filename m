Return-Path: <SRS0=TQUi=PD=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3355BC433F5
	for <linux-nvme@archiver.kernel.org>; Fri, 15 Oct 2021 21:33:21 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD97060FE3
	for <linux-nvme@archiver.kernel.org>; Fri, 15 Oct 2021 21:33:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org DD97060FE3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
	Subject:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=lm/YJnCl8ZclqlzycPnxio9dnKdTzp1epuDoG4xiZFo=; b=Fk8xzHFAv0kg1sdT0yNGqJtw7C
	9zUmzEqcKCVNlAlvoUGNukU1/k7mJKsg3cnYWl4m3t7frLgSd6NX9nn5MUg5j+pm1Jw4Lx7HTwpl6
	ataWtDtoSRRa/hZAIKu1byW5C1+4v4d5AhrNxWb9um6Z9HI3k/A3f5WEaGKBn5nEXx9DPe3OqRuBW
	OLymsTESv17b5PrK8QH//RGKD6Mv0ADbsSOdZQSJFDBthGxf8Vn9StusmZEqMr8kbWiHezUxCswEm
	9g/25PkcSawI76EdMR0jBRIPrDEmm1mMZlTFvc9koH8i4HfBODATtmhS+kadIm/jaiOwGG+Y1BRqG
	nHNmIUiA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mbUpG-008pKG-Tq; Fri, 15 Oct 2021 21:33:14 +0000
Received: from mail-ed1-f54.google.com ([209.85.208.54])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mbUpD-008pJ2-0q
 for linux-nvme@lists.infradead.org; Fri, 15 Oct 2021 21:33:13 +0000
Received: by mail-ed1-f54.google.com with SMTP id a25so43098268edx.8
 for <linux-nvme@lists.infradead.org>; Fri, 15 Oct 2021 14:33:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=lm/YJnCl8ZclqlzycPnxio9dnKdTzp1epuDoG4xiZFo=;
 b=CSRLTS9Sb6q4KsdBnuqsmehVkv2zI6d5idQfplpBG40d5Ew+qQlIM5d5y7CIrjC30/
 l9JfM59YFKvgjU9KMj735I+zNngcl58QQEfghcI5GR5Z6cHNSDnCiJKDPCcTsJr4qut9
 ybxn9SJI2XQl8L8uD0qxJgYgTrfFJks6hWMIfgHB+BKwYNQQBXCjqFIgnyKMMGuvBOYP
 pdIfrCUpMUv25O8h3tEs/jAcanrvEpO3laFSjWKkhbrLV1Fufp1LLT4xVTGX2WPSfVk4
 Z8FTgYskYplDcGvX+RNWBuvZTw2wqFesa70pH1PXKMO80hC8ZnDAJ25KXEcFZqKY6iC+
 BypQ==
X-Gm-Message-State: AOAM532NGnxIXuPH+kFqzZyXR91UM1mCmeGJFWXc1HEIdz6fvbiyyC+Q
 3fzqozDYvn35ecjsBIcaAvY=
X-Google-Smtp-Source: ABdhPJzh25BMd+ll1D7j1PNC6OqhMkYniJ6UZlDpg+2qeEhJasetp6DpQy7nCcJDXJVj48771GaLHA==
X-Received: by 2002:a17:906:ce45:: with SMTP id
 se5mr9921828ejb.386.1634333587802; 
 Fri, 15 Oct 2021 14:33:07 -0700 (PDT)
Received: from [10.100.102.14] (109-186-227-7.bb.netvision.net.il.
 [109.186.227.7])
 by smtp.gmail.com with ESMTPSA id h9sm4871746ejy.108.2021.10.15.14.33.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 15 Oct 2021 14:33:07 -0700 (PDT)
Subject: Re: [PATCH] nvmet-tcp: fix a memory leak when releasing a queue
To: Maurizio Lombardi <mlombard@redhat.com>, linux-nvme@lists.infradead.org
Cc: hch@lst.de, hare@suse.de, chaitanya.kulkarni@wdc.com, jmeneghi@redhat.com
References: <20211015082634.555494-1-mlombard@redhat.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <6f157ac8-620b-c423-4b3e-08efaa1c7192@grimberg.me>
Date: Sat, 16 Oct 2021 00:33:05 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211015082634.555494-1-mlombard@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211015_143311_100115_A89BC5EC 
X-CRM114-Status: GOOD (  12.45  )
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

> page_frag_free() won't completely release the memory
> allocated for the commands, the cache page must be explicitly
> freed by calling __page_frag_cache_drain().
> 
> This bug can be easily reproduced by repeatedly
> executing the following command on the initiator:
> 
> $echo 1 > /sys/devices/virtual/nvme-fabrics/ctl/nvme0/reset_controller
> 
> Signed-off-by: Maurizio Lombardi <mlombard@redhat.com>
> Reviewed-by: John Meneghini <jmeneghi@redhat.com>

This came a long a number of times before, thanks for
fixing this.

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

