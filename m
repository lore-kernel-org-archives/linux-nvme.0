Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 620FBECAAA1
	for <linux-nvme@archiver.kernel.org>; Sun, 23 Oct 2022 08:07:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:References:Cc:To:From:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=f3KtC+vrc1booSbExQlYJWVWqmTt1e++PfYTufxefpw=; b=yL9srboK058xFRc7MD1vHj3PH9
	okARRbeel7rGmrXO38ef9dxKZ6Z0GSFcqqe7Rd6GuGiBgEVP1VA+31SuSleC8Y/f0He8SmaQon6pg
	50DfW2/I2XDZBBTZRFXAAmCfRdrpfB6Iiv/F9/QUPn3oxSXigQdhZdlyxhGviecZSwGJEnWJOnkKm
	AsDx+Hq3yzquzzzoEQEfH2wKGasfsTiIHgW5N2fhfPLg4AkfUTheKgtC7CtBz1FZuX0XjFciLUrbq
	2mrmX8aVcz0IIcst2dMJfR8sen7wPocZlxA45DZQKejvvIMnpJW5hHZ5D8yLCbAw3AVqjAyX/Ma5j
	8IDQzv7w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1omW0l-00Egdv-RA; Sun, 23 Oct 2022 08:07:11 +0000
Received: from mail-wr1-f52.google.com ([209.85.221.52])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1omW0j-00EgdM-2d
	for linux-nvme@lists.infradead.org; Sun, 23 Oct 2022 08:07:10 +0000
Received: by mail-wr1-f52.google.com with SMTP id a14so8220458wru.5
        for <linux-nvme@lists.infradead.org>; Sun, 23 Oct 2022 01:07:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=f3KtC+vrc1booSbExQlYJWVWqmTt1e++PfYTufxefpw=;
        b=UZGnXcAq6WkO1ynbzaurUGKCHohcA1+6R/yVVVgx5H3cG8ix0hlfY/UMC8ZpmtlgM+
         P0eGZcrw1OXnBdg7b1kyj6UP0U1NrTpvzAP29nFBW2pmP5Gr5yzrdiaVIm1dDUxElEKU
         bfHVYg8Z+24tAxraxQ7EaNarI62yohPv9VyHr3FemJmqiANbxQJat61rJJ/YGMjL2t1R
         JtqeuI+TGbP8FFn28nftMrLr+4R6vM3pbP56pUfUjCcfxD+KhyhKMuBTsy5UNyOYAn2g
         OO4B0WrDU032WCxcHekKuuXrSV3+GrUPkRjOlVGzAz1DkXHOPrTScZHsKKIw+kk3WGs9
         Wocw==
X-Gm-Message-State: ACrzQf3ECBHfLJlqvHvqN0t47LWyiQSoLeXQo3Jhw9D1Hs/CcEpzPLXI
	GR7hs/f1p1KA/A+k7Imwi7fr+cPQkrA=
X-Google-Smtp-Source: AMsMyM4MuF2KV26Wm0anXYODCFuTbtqtdLXfCmu8jx1U0FWBH8woflafBz7jEo2y34EnnKlP4nOoMQ==
X-Received: by 2002:a05:6000:1c18:b0:232:a0fb:efe1 with SMTP id ba24-20020a0560001c1800b00232a0fbefe1mr17519049wrb.459.1666512426310;
        Sun, 23 Oct 2022 01:07:06 -0700 (PDT)
Received: from [192.168.64.53] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id r9-20020a05600c35c900b003c5571c27a1sm10119426wmq.32.2022.10.23.01.07.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 23 Oct 2022 01:07:05 -0700 (PDT)
Message-ID: <3799c512-97b7-fee9-c4a6-da94ace6316e@grimberg.me>
Date: Sun, 23 Oct 2022 11:07:04 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH] nvme-tcp: Fix possible circular locking when deleting a
 controller under memory pressure
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-nvme@lists.infradead.org
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
 Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
 Daniel Wagner <dwagner@suse.de>
References: <20221023080443.592097-1-sagi@grimberg.me>
In-Reply-To: <20221023080443.592097-1-sagi@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221023_010709_138751_D543980A 
X-CRM114-Status: UNSURE (   7.16  )
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


> Reported-by: Daniel Wagner <dwagner@suse.de>

Need to add:
Fixes: 3f2304f8c6d6 ("nvme-tcp: add NVMe over TCP host driver")

> Signed-off-by: Sagi Grimberg <sagi@grimberg.me>

