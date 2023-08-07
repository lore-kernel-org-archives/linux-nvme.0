Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BEE0EB64DD
	for <linux-nvme@archiver.kernel.org>; Mon,  7 Aug 2023 08:25:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=AYlkT7BdsD9oGvUsO1qCG8qroz
	4SnqsxAaqKYuT+U1brZM+W/Gx/lz7L4dePFS+/yXRa5Pnkijs1yS+JNLUqEI/D5wPG1zV94nx9BRF
	b0Cxs9pFCD2FBejB+JDdiECRdHEDweQI6NdIgCNtGh/9Ot8+PUBfphCONJzfZkMs35J5wZQTzSJNt
	RXLvQOJtOqm3zy6xJkBn81E8D47ErOhmcCXIeHP8fsxUYIjU+6HMI7QRPixtEzzlrxvWFulxOjUTz
	PhueI2yJQczPOqvKgcoDoc1if6WHGKrNzrFcFeB29UPewVpfb2Ka0AF+2/bPXRvIT3rImWPZAXA/B
	3Z7ulXgw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qSvYR-00GRZm-1L;
	Mon, 07 Aug 2023 08:25:31 +0000
Received: from mail-ej1-f41.google.com ([209.85.218.41])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qSvYP-00GRYp-0l
	for linux-nvme@lists.infradead.org;
	Mon, 07 Aug 2023 08:25:30 +0000
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-99c3ca08c09so127251866b.1
        for <linux-nvme@lists.infradead.org>; Mon, 07 Aug 2023 01:25:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691396726; x=1692001526;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=DYKBFRchjcZqLw8IVr2pkjDimowVxNgq2G/9z5qEKiwAzeGwsb5oEHW8epbJNbgvmI
         MZH+fiUKEetV4urui/v5p/hdL+MQBZLXbx9ycTgycIjjRbDiSlLLnOvzMzdrHDd2nrrO
         MQkyUQ/VAQe4SGgsinpqhAOP0o3HRcx6Ej9DVGH2TTgQF6YySa/r7D/pysTHpmpEr+GE
         CLF5WHi5DmNxPf/G+VqnPZk+bmjphLTFqwlsXgFme+0w5WuJ68lR4cfxxa57VxbGmLkc
         tn4Vjd2sk8m/1PIg266pwA/eLtF04WTAplNjHPtckX3zdnhZX1PRr+M2Sfy0NvwUcd0F
         14Yg==
X-Gm-Message-State: ABy/qLYhV6uOAVeIAuyzNExpqWib8VkVf9v+LV0qH1J5HS+vg3X1nEfT
	ASAreKVVHa5izCn5xHesM/Mcrhge0R0=
X-Google-Smtp-Source: APBJJlEa7q2vxFLaNfAxjSXp6DKWWTKjLIVjwRUHFOGL6kHR1XqGKJFU6flzW38L0U8cCgJWKvmi/g==
X-Received: by 2002:a17:906:5358:b0:997:d069:a880 with SMTP id j24-20020a170906535800b00997d069a880mr21650120ejo.1.1691396726337;
        Mon, 07 Aug 2023 01:25:26 -0700 (PDT)
Received: from [192.168.64.157] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id rk22-20020a170907215600b00982a92a849asm4868965ejb.91.2023.08.07.01.25.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Aug 2023 01:25:25 -0700 (PDT)
Message-ID: <77b11978-cc80-1fbb-0ce9-f720a7f0e80f@grimberg.me>
Date: Mon, 7 Aug 2023 11:25:24 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 11/14] nvmet: make TCP sectype settable via configfs
Content-Language: en-US
To: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
References: <20230803105102.30949-1-hare@suse.de>
 <20230803105102.30949-12-hare@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20230803105102.30949-12-hare@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230807_012529_282935_8D4AC645 
X-CRM114-Status: UNSURE (   6.57  )
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

