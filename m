Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2F8EC7EE2A
	for <linux-nvme@archiver.kernel.org>; Mon,  5 Jun 2023 23:03:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=qZf+Sl/ujw8+aWibkR1S72LYg7
	Aq8s64KTTwf8wgDFzFkkK2YJxvCQ1wyEENRAvfCmUW7k4Y5Un/iuxHlqoc1qORgnwr3aY6nLbuVYK
	zeIuMDDJqF17hymjyWpjWauxH7zhNjegXakUKDDRvBA0OMTYiST7ncWGq5INL3n9Uzyqzp1qXbOl+
	3bTSGYXa82jyh91CHYEyTlkqyc/m5uJmqQ55HyBXASNbFV7DWfauvPLM1TmHMK3FT6Twll/N8G+7b
	LxP7y4BOdeI16wV6JhUWgc9Pvheisy0pDvcMePfFEqM1kyAF3PhIZa0M5ORCqgO1g3C1ZY7AFH5pD
	70h0a9sg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q6JEh-00H5dX-3A;
	Mon, 05 Jun 2023 23:03:40 +0000
Received: from mail-lf1-f46.google.com ([209.85.167.46])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q6JEg-00H5cH-0Q
	for linux-nvme@lists.infradead.org;
	Mon, 05 Jun 2023 23:03:39 +0000
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-4f4453b607eso804925e87.1
        for <linux-nvme@lists.infradead.org>; Mon, 05 Jun 2023 16:03:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686006214; x=1688598214;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=jJ8MJWDkhccniLcZAmvfwQF1+OeQ6lz3Ny1p8oc5qDUUTGKsOClTS3bmxXuQ6Wa7CP
         aZg/k+HXXSLSaS9A7swRk8fcAXMllknB3ANCus9nrfYXc+OhPYP4eoZ+dKnKkMDLUv6t
         RdPS9w0kzXfoASoIK4vKjDpLv1WB/hKZ0KaUiBtyWtTJ1GisoTkp9R9LlR4yDnsNljrP
         UBFXSov/EUdmL4zsNHhoMyY8MDvG75cfIQ/Dt0yRi1jOD5VQHbS1rcTJbVgnbEMEKNyp
         ik8jzoS7FAZXsks5snFsvYwn0NaW53QS5Hpzjfk6rZgA0rfpywessgAnytIqyxBadfYQ
         eiFw==
X-Gm-Message-State: AC+VfDxEjUQpKSJ9hMFmM3BGLLl+xmlHvGaHgbYpWmIhLGfPqDyzlnIR
	UjKvrE3mKlqi5nGvKfY9uY8=
X-Google-Smtp-Source: ACHHUZ5heC6RO5iwssXv/7QicJFpzgXr4CeRZuzfl4n1vcrP+cd/jbhE/6OmnSPD42SmqB7HS//AxQ==
X-Received: by 2002:a05:651c:381:b0:2b1:c077:8d9 with SMTP id e1-20020a05651c038100b002b1c07708d9mr227353ljp.4.1686006213574;
        Mon, 05 Jun 2023 16:03:33 -0700 (PDT)
Received: from [10.100.102.14] (46-117-190-200.bb.netvision.net.il. [46.117.190.200])
        by smtp.gmail.com with ESMTPSA id w13-20020a2e300d000000b002af25598f07sm1610684ljw.78.2023.06.05.16.03.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Jun 2023 16:03:33 -0700 (PDT)
Message-ID: <3c78324e-0c00-8fe9-9827-a278e7b1ecad@grimberg.me>
Date: Tue, 6 Jun 2023 02:03:31 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 1/2] block: add request polling helper
Content-Language: en-US
To: Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org,
 io-uring@vger.kernel.org, linux-nvme@lists.infradead.org, hch@lst.de,
 axboe@kernel.dk
Cc: joshi.k@samsung.com, Keith Busch <kbusch@kernel.org>
References: <20230530172343.3250958-1-kbusch@meta.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20230530172343.3250958-1-kbusch@meta.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230605_160338_166806_B4F6059A 
X-CRM114-Status: UNSURE (   6.54  )
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

