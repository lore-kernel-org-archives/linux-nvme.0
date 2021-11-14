Return-Path: <SRS0=Lvqr=QB=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE0DAC433EF
	for <linux-nvme@archiver.kernel.org>; Sun, 14 Nov 2021 10:40:41 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6885D61056
	for <linux-nvme@archiver.kernel.org>; Sun, 14 Nov 2021 10:40:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 6885D61056
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
	Subject:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ijAtENWn1ygUhu59xmA540JQUcVLLz9Nox8HONApS5w=; b=AmTojwTbZkj30NiUADPnwGtrJH
	8PTrprLTkOr8VgYHZijdz4NsFB585wyIxNQ9hhuYIcy3WmUi4nYvAhZcFzswHQUuKJ/aGWn7JE/FT
	FwvFo0OgFlSh+WuBxInnMpZHlDKjLH5zVfWYBJmqyy0hHVhZ6Bv5/w8BIWwoYiD8JdYLpcHo8z9br
	cUckesU5rZOqg51F0GKhkHuwzW4e1E6tK8BbZez/oTs18QMNYmSQ7rQa1C2wNdFtu/HPq0Imvdpaw
	bVb0hA+MtBkQHYtJy9J3bechlE8+HHnLIPtgmKfyhy0cEOyCRphiVqmvrNMkTlIhBmknVE3Qr0rGo
	S6/eaj7Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mmCwB-00DXfK-4r; Sun, 14 Nov 2021 10:40:39 +0000
Received: from mail-wm1-f45.google.com ([209.85.128.45])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mmCw8-00DXeQ-5Z
 for linux-nvme@lists.infradead.org; Sun, 14 Nov 2021 10:40:37 +0000
Received: by mail-wm1-f45.google.com with SMTP id 133so11385895wme.0
 for <linux-nvme@lists.infradead.org>; Sun, 14 Nov 2021 02:40:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=ijAtENWn1ygUhu59xmA540JQUcVLLz9Nox8HONApS5w=;
 b=DMCKyO7hc0JRIPNfHCoeKne2LoKGxEivR9N8NhlZiB1vQcNVIe/L90lyJZElJpbssl
 eXRcq7gRGDMdv5t90upJLnw5HiP3jHcPVzhUbsKx6Dr4IqvWa8jJrjkNLatjJ6ItgMTk
 TizfuRI/6+nc6IfX47LcPfWBMW/RDqcTApBX8NNWKW3WLG9MX3iHZAdEd6dg5A3PqdIe
 YuAsGJL/YCEPvBBD3ZF9UyvdWBz7FPaofeMBb6l8gaRf0oi26Twkk3aoaCzmEXMiJcI/
 fhlXFZIm+zBVxb8OQTEbBtsXHsCByakYAS+WjCc+QMe8zxDZurjCqipxabxumujI8LlR
 MMiQ==
X-Gm-Message-State: AOAM532pqMQIYnL07xpa54jZZ7dfC2OTzBxbY87P5+YqwFU8d6wBIC7q
 JijF7FpRWkNOKWmdVEl7vk8vaj24Co8=
X-Google-Smtp-Source: ABdhPJzbCHf7KtlEb6QB1X2JJ414kye+aE2OlXNM87ZZRWWxsIXaAq84q0yH3B1wCJ+T6cb66HzsIQ==
X-Received: by 2002:a7b:ce01:: with SMTP id m1mr38231010wmc.187.1636886434640; 
 Sun, 14 Nov 2021 02:40:34 -0800 (PST)
Received: from [192.168.64.123] (bzq-219-42-90.isdn.bezeqint.net.
 [62.219.42.90])
 by smtp.gmail.com with ESMTPSA id f18sm10729240wre.7.2021.11.14.02.40.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 14 Nov 2021 02:40:34 -0800 (PST)
Subject: Re: [PATCHv5 00/12] nvme: In-band authentication support
To: Hannes Reinecke <hare@suse.de>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <keith.busch@wdc.com>,
 linux-nvme@lists.infradead.org, Herbert Xu <herbert@gondor.apana.org.au>,
 David Miller <davem@davemloft.net>, linux-crypto@vger.kernel.org
References: <20211112125928.97318-1-hare@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <74db7c77-7cbf-4bc9-1c80-e7c42acaea64@grimberg.me>
Date: Sun, 14 Nov 2021 12:40:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211112125928.97318-1-hare@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211114_024036_245410_D6138FF6 
X-CRM114-Status: GOOD (  24.37  )
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



On 11/12/21 2:59 PM, Hannes Reinecke wrote:
> Hi all,
> 
> recent updates to the NVMe spec have added definitions for in-band
> authentication, and seeing that it provides some real benefit
> especially for NVMe-TCP here's an attempt to implement it.
> 
> Tricky bit here is that the specification orients itself on TLS 1.3,
> but supports only the FFDHE groups. Which of course the kernel doesn't
> support. I've been able to come up with a patch for this, but as this
> is my first attempt to fix anything in the crypto area I would invite
> people more familiar with these matters to have a look.
> 
> Also note that this is just for in-band authentication. Secure
> concatenation (ie starting TLS with the negotiated parameters) is not
> implemented; one would need to update the kernel TLS implementation
> for this, which at this time is beyond scope.
> 
> As usual, comments and reviews are welcome.
> 
> Changes to v4:
> - Validate against blktest suite

Nice! thanks hannes, this is going to be very useful moving
forward.

> - Fixup base64 decoding

What was fixed up there?

> - Transform secret with correct hmac algorithm

Is that what I reported last time? Can you perhaps
point me to the exact patch that fixes this?

