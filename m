Return-Path: <SRS0=3Qb0=PQ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB963C433EF
	for <linux-nvme@archiver.kernel.org>; Thu, 28 Oct 2021 14:07:55 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B58061056
	for <linux-nvme@archiver.kernel.org>; Thu, 28 Oct 2021 14:07:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 6B58061056
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
	Subject:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=n8C34WYR8E67yy7Izjl69o5e6TXOfoqIVyhyV0pkNzc=; b=s5WIv7pT8h6Yesx1vAyoNSpPAn
	CjQp3OCgrHN6MxqfwIAfy+dbJcaTzH2QUC7KyY8kjq8gYcq9UcaZpG/S2Yd6jTFzOQ4iVk1sjatEo
	+oIbiZ83D+uLVufqptfuKT5m1eD/m52i/9Gpufz3IXjihKaaiQX1dcSN2bHt1GHVBG+gUAAgS6reA
	6VEH7f6STjeM5ySTtae5T6IKEkodBhwEKW0xAa0Ca+krhniC7ML3Snl658MDHxV3Amw2nGpLETcv+
	YAHuZym532k2wfeH2EO0yfy5x0C4KIhYRbAVdjz9j/euFb8PqLW7QGNJM4RYS9lHR8U4wl352vnoE
	XbaHfhmA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mg64L-0084P4-FF; Thu, 28 Oct 2021 14:07:49 +0000
Received: from mail-wm1-f49.google.com ([209.85.128.49])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mg64H-0084NC-Mr
 for linux-nvme@lists.infradead.org; Thu, 28 Oct 2021 14:07:47 +0000
Received: by mail-wm1-f49.google.com with SMTP id 71so3661905wma.4
 for <linux-nvme@lists.infradead.org>; Thu, 28 Oct 2021 07:07:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=n8C34WYR8E67yy7Izjl69o5e6TXOfoqIVyhyV0pkNzc=;
 b=iG4V9gj+yRT6mML7eSofTrA373ybe2Y931ylL72fTieMLGKEhYPEdCIVL9eb6Bn0VA
 VlNB0yyeO/dfgv/V83LX4RePyRV86A8+Iy9wbOI4YKGGaAIEykDPZj6xEIeXvATsKJ0v
 N4rsELzWIX52Cjxv2L9ExlZ24i/S1lx8va0rJUpMCXsM0+U56qdiLjFkc0/FUQxF+rbb
 2Rad6Ph9ni6x00qkHqlUGdyT6Sah+o1XV/PSOhYf8IeZ5vT9DZ9BMNZLnASbH5c4us9B
 dVYR6cbehwaXu5aiBJkrICgaJ1EViwxSKvJBTJu98c9Sau6E0pIBxwp9nCs+3OQEA+Mi
 GMkw==
X-Gm-Message-State: AOAM532w4HAU6aOeVsMmKcZ4mTkuASFSN/bxGoUi2rvDHe8VfbGdgmwq
 +bSyHA6Dx/sHTrcMae4jjr9JRIxakgQ=
X-Google-Smtp-Source: ABdhPJxK0sA2Wu0HE3FohuVa3C4UDI7V4vgZAQRLC8HBVvpqG9hDHI2yxqpAw8INOJdk40zsTbb/qw==
X-Received: by 2002:a05:600c:3b83:: with SMTP id
 n3mr4683309wms.110.1635430063907; 
 Thu, 28 Oct 2021 07:07:43 -0700 (PDT)
Received: from [192.168.64.123] (bzq-219-42-90.isdn.bezeqint.net.
 [62.219.42.90])
 by smtp.gmail.com with ESMTPSA id o20sm2784351wmq.47.2021.10.28.07.07.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 28 Oct 2021 07:07:43 -0700 (PDT)
Subject: Re: [PATCH] nvmet-tcp: fix data digest pointer calculation
To: Christoph Hellwig <hch@lst.de>, Varun Prakash <varun@chelsio.com>
Cc: linux-nvme@lists.infradead.org
References: <1635182214-3958-1-git-send-email-varun@chelsio.com>
 <20211027055725.GA9635@lst.de>
 <26648af7-f459-5d43-bc2a-ef2c63715418@grimberg.me>
 <20211027071316.GA11266@lst.de>
 <252308fb-d557-34ce-5c7f-a6307f92b111@grimberg.me>
 <20211027144914.GA1851@chelsio.com>
 <9dc338a1-d047-0d48-15cd-317b637d5491@grimberg.me>
 <20211028104947.GA1690@chelsio.com> <20211028140059.GA3550@lst.de>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <d533385f-fbe5-5ace-fdf3-317472efa5f1@grimberg.me>
Date: Thu, 28 Oct 2021 17:07:42 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211028140059.GA3550@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211028_070745_810230_0F14D6DA 
X-CRM114-Status: GOOD (  12.49  )
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


>> Both the patches are already applied to nvme-5.15, should I send v2 or
>> create a new patch for u8 * -> void * change?
> 
> I'm about to send the pull request with them to Jens.  It is too late
> in the cycle now to respin again.

We can take care of that later...

