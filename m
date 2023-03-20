Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82F87C6FD1D
	for <linux-nvme@archiver.kernel.org>; Mon, 20 Mar 2023 19:00:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8YlfMACqhZY+YRomG4PdoSrNzR3WpyqjeQM5DwdiTkk=; b=YMnqIbQ4OCZ8gm3cyOD+sAj3MG
	UgAwaYTb9YyskIdx4kuxhcKEPFnZxw4HY6kES9u1yhiz+0Rj76wpyld+bJRrbJ12dZexUmh8OU0ie
	sxH70hUa0ac607wFW24iT7rk4PCUnE+g+09AwPGGHjXI/kZUZQxBjplkKmXau/YZ1IwU5rUozwOVE
	Py2kb4PeO2d5qXBYKca2YpXUooS2SVQdcQKn48IPq4VRR339Gq4cCtEOYgL1f19eDtlCQS3WUpY+6
	JbHMSNLg6YJeaIREXsZncKReCpGqU3r6i95CC0IARrgFqjhhQJoaoPhivgE4cuMGPBt8Y8NsW4eTT
	n4Xt/O5w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1peKjo-00ACz2-1m;
	Mon, 20 Mar 2023 19:00:08 +0000
Received: from mail-ed1-f48.google.com ([209.85.208.48])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1peKjj-00ACvD-2Q
	for linux-nvme@lists.infradead.org;
	Mon, 20 Mar 2023 19:00:05 +0000
Received: by mail-ed1-f48.google.com with SMTP id r11so50816258edd.5
        for <linux-nvme@lists.infradead.org>; Mon, 20 Mar 2023 12:00:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679338801; x=1681930801;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8YlfMACqhZY+YRomG4PdoSrNzR3WpyqjeQM5DwdiTkk=;
        b=c0o6S9hViXDZxII+vu+oay89xkvzosCI7sIaqD1R+0RQg4qTxiiOKJvSEcukU3ZDjg
         0MdkTNFSoptVv365l7igbX+D6plqVZekcNLG6kcFp7fAZ+Po+xoOesPdjAam0l+nWpXA
         4nTUVSj0HbI5UiGOOQdnvAc3+ab76Bt8BaR/zZ3lcRuyOH+Cy0foZhmlELDblYYoOTJl
         Us8boTTfQUUS8ZfNW2EPQJClHkSbTAsopOzHjSwHg+g3aUjKxOKqRWJlWoQjtgWQcKnP
         KJPSzGnfBxM2TDIDTf7QolzyCarDdYNvFzsXgyydCQUTwEbI9TKMF2v0F2DmW6X9ft9C
         hb/Q==
X-Gm-Message-State: AO0yUKXM33kWzSmyaTQJUS2eKvpyyhfILqkW60DDPEdslYoqlXtbsg0R
	ZFs2o9AH+gVuwQAKZflSMto=
X-Google-Smtp-Source: AK7set+NPiSXzfehtzkdVf58PBGF7iCyR1T7R3huqkZnQFlyAGakrHL1ORkdSn3uvm8uNHJHWDuajQ==
X-Received: by 2002:a17:906:dd:b0:92f:27c2:13a3 with SMTP id 29-20020a17090600dd00b0092f27c213a3mr105004eji.3.1679338800719;
        Mon, 20 Mar 2023 12:00:00 -0700 (PDT)
Received: from [10.100.102.14] (85.65.253.165.dynamic.barak-online.net. [85.65.253.165])
        by smtp.gmail.com with ESMTPSA id n15-20020a170906118f00b0092421bf4927sm4840150eja.95.2023.03.20.11.59.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Mar 2023 12:00:00 -0700 (PDT)
Message-ID: <725cc2a7-8a3d-6d23-c9b2-c841e9d14201@grimberg.me>
Date: Mon, 20 Mar 2023 20:59:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] nvme-tcp: fix nvme_tcp_term_pdu to match spec
Content-Language: en-US
To: Caleb Sander <csander@purestorage.com>, Keith Busch <kbusch@kernel.org>,
 Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-nvme@lists.infradead.org,
 linux-m68k@lists.linux-m68k.org, Geert Uytterhoeven <geert@linux-m68k.org>
References: <linux-m68k@lists.linux-m68k.org>
 <20230320155736.1492682-1-csander@purestorage.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20230320155736.1492682-1-csander@purestorage.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230320_120003_795722_7DE8C6B1 
X-CRM114-Status: UNSURE (   7.82  )
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

Thanks for fixing this,

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

