Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29765C001DF
	for <linux-nvme@archiver.kernel.org>; Mon, 31 Jul 2023 09:13:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Fxox2iIr8W3B8NaS617q4mdFVPlB6jFH6tIOi773Mls=; b=q7ieCuomRXqXaaoNuicZ+BPdyW
	TFeecxDQ0vtSMYdtl8lFvqjusIN/LHEoLtnPOK0jrowQyNBepYBQW1ScYs6S/9Y5r3AfUE8s+uvu/
	7i5Unx5epPzBBFhC7m8oOZ0JNUhUS0ZmrHIUO0AoJg5E558eZJ5vlhDLoHlJM3T2PNNgyUafWaP89
	IVZ+EKoHGOJGwIOKc9K2ZwQGTtgW1PfFasdqhvEzd/TBTsR/oNMEaFsc4fB9U4z5Kzo7joFRF6cEv
	JvlFsCDx7QBHIKopQxz/VuFuNU7PVT78Em/q9apaIk0yUJiJ3ib5VKGA8GCwUqsxXZ79mBB8nLaVU
	bXFrP4eg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qQOy5-00Ejoz-21;
	Mon, 31 Jul 2023 09:13:33 +0000
Received: from mail-ej1-f49.google.com ([209.85.218.49])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qQOy2-00Ejo6-25
	for linux-nvme@lists.infradead.org;
	Mon, 31 Jul 2023 09:13:32 +0000
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-99b4865ad55so123169766b.0
        for <linux-nvme@lists.infradead.org>; Mon, 31 Jul 2023 02:13:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690794802; x=1691399602;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Fxox2iIr8W3B8NaS617q4mdFVPlB6jFH6tIOi773Mls=;
        b=VpitcjhN4Tv5DJpw2A611+UNsv/Z5kWklCK/XjwrEiOCcJNkN6w2ukSqZuKXL0ERhT
         FvVFkIt9jUVqUUUJOY89L7PGzhNAKIYUlOnDTU4KeGV5+iZnp7HhcSwe32YDu6Ughs1C
         I8dvC26k9sAz/y8bQeBOhIrl07QrVcHRUWauRq6A/ru8p6dMDf1E6m5xW+O8I0KzD/Vx
         Vg4vmOFuvDWK+LJc+XKjk9rFX6YmNgh148TL8m0h6szTrE6TSUVXthD6G+pnwsjkTo+d
         PRnOM6yKcqgjqlaCEiIr28ZqdaRb0F8nvmT+hbowHygIoRPpPbU0CcQ4tjso7M4fzVqE
         xNZA==
X-Gm-Message-State: ABy/qLYeNpH9WbqiPhgvf3Z9Q16Deh0dF3Y1It9csWGsNgx6Re/3aqHu
	1W/cE5sh4BD62DA/m1dBREZN8I9i6ys=
X-Google-Smtp-Source: APBJJlHZpTBt8a6PZbTj5zJSTqpjR5eYv3NP2NZsQWyVZufcYTBjP2MT4JiOY1lLpTm+87xOfF8IPw==
X-Received: by 2002:a17:906:196:b0:993:d0e1:f308 with SMTP id 22-20020a170906019600b00993d0e1f308mr5394267ejb.2.1690794801443;
        Mon, 31 Jul 2023 02:13:21 -0700 (PDT)
Received: from [192.168.64.192] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id r15-20020a1709067fcf00b009937dbabbdasm5840367ejs.217.2023.07.31.02.13.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Jul 2023 02:13:19 -0700 (PDT)
Message-ID: <3a5b5be2-8a8f-dc9a-be54-7845174487c8@grimberg.me>
Date: Mon, 31 Jul 2023 12:13:17 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] nvmet-tcp: pass iov_len instead of sg->length to
 bvec_set_page()
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, Varun Prakash <varun@chelsio.com>
Cc: linux-nvme@lists.infradead.org, Rakshana Sridhar <rakshanas@chelsio.com>
References: <20230727150550.5851-1-varun@chelsio.com>
 <20230731055918.GC30150@lst.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20230731055918.GC30150@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230731_021330_702226_9125F359 
X-CRM114-Status: UNSURE (   7.34  )
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

I don't see the original patch(es), Varun can you please resend and CC
me?

