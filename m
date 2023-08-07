Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82AE9EB64DD
	for <linux-nvme@archiver.kernel.org>; Mon,  7 Aug 2023 07:13:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=IGlfIu9Njn78vr0iQK/Ag1C1ZsI6lIDNFPGyBTeubEk=; b=Pal6+5au7/a7VeVf0yM+oT9QQI
	3TCjpaMk2okMzPpTeIL59XL0MDDbZ/CmAvCZA+/7WtgtJyFxGNKWWoQokC8/dJ1OEBMfbmnugLlKu
	6XYfoXHBW2IUa+DhbYbm3JmGlFuZ5oO3pwgOpi37BEmBJUrJAhB69eJZztISM9qVWacTtc1XvXJGd
	BRiPyBeOWeYSxHUftninMUTc3Y8mX1CKulC/ssQefEgQdYZW3yrvEten1jlRHqzT9XaQTwd14olo7
	wew4OgTch88qKJI598W9WRvlLLTwsCxhGWusZZqVAAF9EBXp+gkRrvfau3l5TVZTiU2is7zX/QELU
	d2gSQKuw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qSuQu-00GL1V-28;
	Mon, 07 Aug 2023 07:13:40 +0000
Received: from mail-ej1-f47.google.com ([209.85.218.47])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qSuQs-00GL0x-0E
	for linux-nvme@lists.infradead.org;
	Mon, 07 Aug 2023 07:13:39 +0000
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-99c4e426714so128592766b.1
        for <linux-nvme@lists.infradead.org>; Mon, 07 Aug 2023 00:13:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691392415; x=1691997215;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IGlfIu9Njn78vr0iQK/Ag1C1ZsI6lIDNFPGyBTeubEk=;
        b=If6rouQx8XSwLU8/cunyLraUPESoVftZAIKglMFiMgkxhoTxtnWcEOnRm0EDrqg/ig
         EbHVWKG6EsquOyACUlIi1hsk5SN2xGCwzq6KOHnnTCU/geAvPIxYL6BlSVSQLXqDRIHV
         kIxvWC7e4ArYMxfAqcjyQ/7irJ9EC6K1dEVuO9oNqQauKwTs4PC2FFgNaCLyQN/C42gu
         jazZMoWS/+PBvM2mI//PvalNe81TO3RNxsVM9ky2g0y/X4UcKq/95xxgl4bKjho3sDPU
         gN/NANkPumEUZK81nx+QVcRxwfPO2gMCTwkLAeMzKSknmHu9UzXq6HRSa6yDrK0ztDPq
         ut3A==
X-Gm-Message-State: ABy/qLaLlG3SeBi5Ciwu3LC6D5ea6r3nYAIkzrYnqT7Jc08/o4SO/2Vf
	LBcFNtjMyvT31S3SYqZAPOg=
X-Google-Smtp-Source: APBJJlEpfLo0J6qQOoCSn4epKEfAFO5t9zQiuH9PIBID3n01YPrs8C6WU1tA7T5tez6LTce/+0Efow==
X-Received: by 2002:a17:906:5349:b0:99b:d03e:76e8 with SMTP id j9-20020a170906534900b0099bd03e76e8mr19281162ejo.5.1691392415286;
        Mon, 07 Aug 2023 00:13:35 -0700 (PDT)
Received: from [192.168.64.157] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id mf10-20020a170906cb8a00b0096f6a131b9fsm4793990ejb.23.2023.08.07.00.13.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Aug 2023 00:13:34 -0700 (PDT)
Message-ID: <a10dbbf5-cbd6-b9ee-b58c-e6892e83301b@grimberg.me>
Date: Mon, 7 Aug 2023 10:13:33 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 05/14] nvme-keyring: implement nvme_tls_psk_default()
Content-Language: en-US
To: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
References: <20230803105102.30949-1-hare@suse.de>
 <20230803105102.30949-6-hare@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20230803105102.30949-6-hare@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230807_001338_104539_B9A81EEA 
X-CRM114-Status: UNSURE (   8.14  )
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


> Implement a function to select the preferred PSK for TLS.

I think we should state both in the log message (in addition
to a comment) what is the selection criteria.

Other than that,
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

