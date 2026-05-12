Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD910CD343F
	for <linux-nvme@archiver.kernel.org>; Tue, 12 May 2026 22:03:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=owZE+iUALNPGmlDDV9aYR6BRVGBe2soTj+869nQgP3k=; b=uFoHwxE+1n177WlpZEMExiCa2i
	npaltTOvkmhHcXRnvaNGlaunEpMKmp/P/FG3agbMjTVB2REZQ/K4+RxlD1S5xiWufMq+GnEZOthaU
	AzG+EIyyplElLmSb3qaaFJrUCVLjbFDflzZk/jH7KplA5PazhJ8/EZwVcx+lBaPl8iWar11aLKZK0
	gYwLqfgt/XIV1g6FKZ5MbEZUSZFvVp1NkePu62XaZNYOXr1G6Xlk3IE2+dTkvwT3th7t85wVd/PtX
	l8ZhRkkXzn7Y8ycuHN1FF0BrUXe7gHTgENxe/RWNNFHcvx3v+pr3U39/Oi93U/14dRcKxeg3A9Re4
	TaOo/o1g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wMvBv-00000000XpW-2aiE;
	Tue, 12 May 2026 22:03:03 +0000
Received: from mail-wr1-f44.google.com ([209.85.221.44])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wMvBs-00000000Xor-46Kg
	for linux-nvme@lists.infradead.org;
	Tue, 12 May 2026 22:03:02 +0000
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-4585a116a4aso2154107f8f.3
        for <linux-nvme@lists.infradead.org>; Tue, 12 May 2026 15:03:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778623379; x=1779228179;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=owZE+iUALNPGmlDDV9aYR6BRVGBe2soTj+869nQgP3k=;
        b=XKuVefX4/jgtrqHIq2/cY+dZ0F2Hvdf6tIL5jyPDaFmxpPgSrSLzpOdSSevre1qGre
         6HD8bHeJ33wPno7ILUVhqhM7chIJj9TYNn9qRqQVAM3IaqRSFjB+5cCyxEEXeFk39F74
         uLvARAGJ7iJUh+rBwgL4fIcYMc7u0VnRaFh2kvN9GtN9emazOH2Vzo4Khsqugr0BnRm3
         RjHyHNjXjqa7YJpRKLURadNMpSDeR/KXRnM+nUWgqllAwYpIOV5FSnZCskz73d4WhNnV
         7QjU9pQj46HCdmFjgG2Bg/MwnQ3RZQVvgypL5DkKPIH9cft1omNDaX4tL5lUJw+loXwQ
         IZgQ==
X-Forwarded-Encrypted: i=1; AFNElJ9FovGpVZKRPcUeANSD32TDep6WJsplTXf7b+JFHkZllZb7dxRc3Fi5C6i9V9PxGuvBIZiJzVhQpyyk@lists.infradead.org
X-Gm-Message-State: AOJu0YzvbbijVy+H2qeYdYtS1lrzcomhl/SCpsRvXqAE6l5wGf0G6IWq
	eBDqZcCcCfzFlI6o6cMlXeEJLJdJS4Nj+ZJaoRXOKKjSZmo64bE6j9CR
X-Gm-Gg: Acq92OFS50pPDPUXiexJbTZ7SDUWkVkWup8XiXGeUYwV+yBENfwRCBfpPJY2gJIMZhD
	+MJ+6IVlYHQiZC0qo19GFGbnxrBOZxeCdgB9+NCxdExd1dYGX75GaonyYFYJohSBfN5C5gJFXsd
	tOwpKg1QqEqjd6A+JHTAhwuhzNOoqBJIiJVKGAbW9ECExBz8PIi+IQczLVpHehFzTBWXw5JzNxe
	UmPoYVLlR7nRC0njJuJlnutuFL500fnET3T/ft1YI3TR6bTMcDlb5IwB+4tg41by/EbH+3ByZxh
	bzf+GKaCYCbhiVGWmMeVJ2KMLjYyX+M6dWvKRG5PgixVilCKs2ZxpUHWAlt3yp87YGHifvQJ7dL
	oNkot7QLMitu9dLqrUWNY7rVox2H5xaef3lfoqXWs6g2iyhVoyhy4Pcs0QaqtPZ9uiPeBxMJ4g4
	jIT/vXnha4pIbEhSY4gUA=
X-Received: by 2002:a05:6000:220b:b0:43f:e272:edff with SMTP id ffacd0b85a97d-45c790b2be5mr232539f8f.4.1778623378327;
        Tue, 12 May 2026 15:02:58 -0700 (PDT)
Received: from [10.100.102.74] ([89.138.75.0])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45491da03a7sm35816557f8f.33.2026.05.12.15.02.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 May 2026 15:02:57 -0700 (PDT)
Message-ID: <29366d4b-2c59-42d8-8494-b80e27ccbb2d@grimberg.me>
Date: Wed, 13 May 2026 01:02:55 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 00/15] TP8028 Rapid Path Failure Recovery
To: Mohamed Khalfella <mkhalfella@purestorage.com>,
 Justin Tee <justin.tee@broadcom.com>,
 Naresh Gottumukkala <nareshgottumukkala83@gmail.com>,
 Paul Ely <paul.ely@broadcom.com>, Chaitanya Kulkarni <kch@nvidia.com>,
 Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
 James Smart <jsmart833426@gmail.com>, Hannes Reinecke <hare@suse.de>
Cc: Aaron Dailey <adailey@purestorage.com>,
 Randy Jennings <randyj@purestorage.com>,
 Dhaval Giani <dgiani@purestorage.com>, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20260328004518.1729186-1-mkhalfella@purestorage.com>
 <20260512214040.GI10532-mkhalfella@purestorage.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20260512214040.GI10532-mkhalfella@purestorage.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260512_150301_027469_35CB7A06 
X-CRM114-Status: UNSURE (   8.38  )
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

> v4 dropped CQT patches in order to focus on CCR. However, I came to the
> understanding that we need to bring CQT patches back. The plan for v5 is
> to be similar to v3 plus minor fixes came in v4.
>
> Sagi - Does this sound good to you?

Yes

