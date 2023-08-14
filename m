Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91472C001DB
	for <linux-nvme@archiver.kernel.org>; Mon, 14 Aug 2023 12:12:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=pWITk8Z4B3S93bToKNNnplWpD5UoUBOkLNngl+3yGN0=; b=jADHaTPJRBw41GlQrddRkOXQRv
	M2P+ZZ9J9mCbc1hYvDo0t/E3pMt0on89cwn19xbdUAOxhFTsohACrkVMfgUtjRIAHwCtWlkQ1i0RX
	5aeAP5G0HlVvGfC3KPeP0I/D189m+onSskc520ti67p2xDRnnuOJ+i93/kRx6u2JVBoHHoZD3VNpM
	i1jii+NHqgan2dYEyMuNEc6w8xWxKn2XQCbSNLIolt7XaaUIzo0C5iktje2zX5fw8WDvwtrPk5x1i
	OtjwYCaq4ZAvsw/G6ZweJGQfpV1Ldpxki86ZRlsad7s6GicXuPRSF1o/2y1b5zo1wvLzesDTINJqr
	dN2UikNg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qVWQW-00H1hY-1O;
	Mon, 14 Aug 2023 12:12:04 +0000
Received: from mail-ej1-f48.google.com ([209.85.218.48])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qVWQT-00H1ff-22
	for linux-nvme@lists.infradead.org;
	Mon, 14 Aug 2023 12:12:03 +0000
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-99bcf3c8524so95441666b.0
        for <linux-nvme@lists.infradead.org>; Mon, 14 Aug 2023 05:12:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692015119; x=1692619919;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pWITk8Z4B3S93bToKNNnplWpD5UoUBOkLNngl+3yGN0=;
        b=LlH3aILR8lW6/Sge5r5ou8X5cbP6ZvAC+LktRsZPk0QCJ946RoTN21UW1uZ9K0LpPK
         AhHe2XK/ZV90Iw9JGj4V2BVa8J2aitplHLvBQLsTwkQYoo0uycN5LkLN01a1ow/DZI8x
         XroR0OQr2LnDA55gVZaAcSN6EhaZRNf6BhaVp/pANtd9CnLcReQiljsKtDGP3pBYWxt7
         pcHcpHVor6+g0ilumkqbzTJPzW/DPGyJpka3FyihWjUFjO1FswtLW85UB8jzhF+AsylC
         oP3t+dS30UT9URCxGrAV7W49A4xGV9/gb6g4y5Ctcz8/Vg/eJEHH2lpQOvVXG0HAD9RV
         h4Bg==
X-Gm-Message-State: AOJu0YwEqgX5xN4l1Xg0EOTOQLOC7X9lnT55Xxtyd7kdByCMgqamZ/Ih
	m0rFRQm8X0SSOrzEHP37qRdrLh61u9M=
X-Google-Smtp-Source: AGHT+IGSXFdwPPy7nFsH9UFmPaGv+ntJuqlBYquqXA4Cmx/Q5yiz0Et8j6euQgn14JCp1XXdjC9R0w==
X-Received: by 2002:a17:906:51cb:b0:99b:d03e:76e8 with SMTP id v11-20020a17090651cb00b0099bd03e76e8mr6386560ejk.5.1692015118554;
        Mon, 14 Aug 2023 05:11:58 -0700 (PDT)
Received: from [192.168.64.157] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id kd28-20020a17090798dc00b009937e7c4e54sm5646877ejc.39.2023.08.14.05.11.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Aug 2023 05:11:58 -0700 (PDT)
Message-ID: <304bc2f7-5f77-6e08-bcdb-f382233f611b@grimberg.me>
Date: Mon, 14 Aug 2023 15:11:56 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 17/17] nvmet-tcp: peek icreq before starting TLS
Content-Language: en-US
To: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
 Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
References: <20230814111943.68325-1-hare@suse.de>
 <20230814111943.68325-18-hare@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20230814111943.68325-18-hare@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230814_051201_667683_6EF12825 
X-CRM114-Status: UNSURE (   9.73  )
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


> Incoming connection might be either 'normal' NVMe-TCP connections
> starting with icreq or TLS handshakes. To ensure that 'normal'
> connections can still be handled we need to peek the first packet
> and only start TLS handshake if it's not an icreq.

That depends if we want to do that.
Why should we let so called normal connections if tls1.3 is
enabled?

