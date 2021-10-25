Return-Path: <SRS0=jIqL=PN=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03B31C433EF
	for <linux-nvme@archiver.kernel.org>; Mon, 25 Oct 2021 07:23:05 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C783760F9C
	for <linux-nvme@archiver.kernel.org>; Mon, 25 Oct 2021 07:23:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org C783760F9C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
	Subject:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=d/d3uzH5gyR2Ud1GuxuJeiS7jp
	zxs27EtsOyMbRY7UabUQja0mQhdRJtL365KzWUMJ6jTWfxmOCjnCAtEWtW8NblXM3gcme7IeJGbMO
	AIwCErGBtBHgAR/chGaDZ+W0XKFJasygQv8zSioeK74WBQ7BFYL00dLtU8Up8p0VSvt/c5Jda5Kbf
	7hNxgCdCGPjt05ZxgqzvpsIFHpfY6zPfP6j+jkzj/IWA8HDMRwJEqDvaHNUCHH/gBWlu9qFrGTVdP
	KaQdPy2L32oIxYqHRnsO36m7VUkgU0kTlCD8V8IthO5S/hIGzves//k2khdt2RtrXzmQDeXZ8apj3
	1vdfua9g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1meuJw-00FavW-Na; Mon, 25 Oct 2021 07:23:01 +0000
Received: from mail-wr1-f46.google.com ([209.85.221.46])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1meuG5-00FZYZ-OR
 for linux-nvme@lists.infradead.org; Mon, 25 Oct 2021 07:19:03 +0000
Received: by mail-wr1-f46.google.com with SMTP id u18so7580156wrg.5
 for <linux-nvme@lists.infradead.org>; Mon, 25 Oct 2021 00:19:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
 b=NoP9wRRKfxJe1b3TJzshQJeDqv+Mh12ufD2qRmuvHTLAS1fpfLwNwZtSdosK+AkwKx
 vCtXKhMZ/T5q5IsjeM79IuZpFbOj1Ir4aqfADSzDGzFFGt5jopQ3BnGqdCO9KZMyMREn
 Yc1OPrI4EpyRmXSCTwT0xst0T66M1Qd0zzMjl806n2s40p/VfsUxe/hcHk2lNLE3MceM
 mrr+Tg0Qq/m4D1qSGv5pRk6b/h+aoJ+u+mOluapCZu2ekL877Jil5ix2gs36i9zetyjO
 +3SbJcN5oHAb/Y12WnimjgpkevndItcIGZad0xpXxLz3Nc6MR6v+UtLXK7EmJXoT8Vof
 oC2A==
X-Gm-Message-State: AOAM5326nqMjInlhcb8arxxisGO9hAZXSsVVThtAL/foodA1rsuaURVk
 FQg66UWqp8OapauIe/PUbSc=
X-Google-Smtp-Source: ABdhPJzjP670GgIe7+Bqx6nvJCFvZ3NrT2F+UvQIQBsO/uRySjF8DzeuZ1Ud/jOZTyzaM2ya21t60A==
X-Received: by 2002:a5d:6d51:: with SMTP id k17mr20926449wri.233.1635146340045; 
 Mon, 25 Oct 2021 00:19:00 -0700 (PDT)
Received: from [192.168.64.123] (bzq-219-42-90.isdn.bezeqint.net.
 [62.219.42.90])
 by smtp.gmail.com with ESMTPSA id c7sm12387886wrp.51.2021.10.25.00.18.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 25 Oct 2021 00:18:59 -0700 (PDT)
Subject: Re: [PATCH] nvmet: prefer flex_array_size and struct_size over open
 coded arithmetic
To: Len Baker <len.baker@gmx.com>, Keith Busch <kbusch@kernel.org>,
 Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
 Chaitanya Kulkarni <kch@nvidia.com>
Cc: Kees Cook <keescook@chromium.org>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 linux-hardening@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20211024172921.4110-1-len.baker@gmx.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <c56b8f55-3fa8-0201-28ae-10a275319fef@grimberg.me>
Date: Mon, 25 Oct 2021 10:18:57 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211024172921.4110-1-len.baker@gmx.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211025_001901_854279_05C67F9C 
X-CRM114-Status: UNSURE (   9.34  )
X-CRM114-Notice: Please train this message.
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

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

