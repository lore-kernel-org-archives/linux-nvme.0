Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE8C7C25B06
	for <linux-nvme@archiver.kernel.org>; Sun, 14 Aug 2022 11:46:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=Dq/YjkZdHBrk+zZbPrZiu6ho0g
	L7q7Vt+PiRjDpsgI7MI2OalbIKuRZOQ7PPG3rWaTtcr9o1vaoCSCWjYvRpk0UO+yolF7XO5V7jfOb
	oj2L+lxA59W2TVTR4YoGmXJhsERUoQP5JGgebfLfxFSjLuvJC5gUMJnis9Cr1YSzuTzsuDB2ixu9u
	QCiUeBQkuOXlywVqgVHTH99gWhHqyPXCcF43g2XOth44JCbfVmTYmFAIBu+ihZvIBVDA4qdaXxiwS
	HnLhikxhwdmqBkZy2PZqFS7acAXglpowVqDQf0+fJb+cpdr8ZtMVbPOMzduLyAOQT+Pk9VKIx4iXp
	bri6/uDg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oNC46-006GqE-BR; Sun, 14 Aug 2022 11:45:58 +0000
Received: from mail-wr1-f54.google.com ([209.85.221.54])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oNC44-006Goh-7W
	for linux-nvme@lists.infradead.org; Sun, 14 Aug 2022 11:45:57 +0000
Received: by mail-wr1-f54.google.com with SMTP id j7so6111582wrh.3
        for <linux-nvme@lists.infradead.org>; Sun, 14 Aug 2022 04:45:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=XyvvpZ15dPxcXbUBRSJHdtkmIDJVlwvkXC7WQGw4EqPpNHL8vMJkUiavfyA1LAo6pQ
         YrsrUV8OSm67Pm0E9ZxfQErUsueePB5L9gQzU0cHOKbOBFldbsLebBvdjzUuuDHU20ER
         6PJthaLD1QTkrExz5Oc5XXKxUl/prQqVwbH1VjQZSkZ64beHl2bJDSK+7NsXsYdshIYv
         csEaaWBdI3XwI3350ujCy9b0LxmzKLZvvpPmizHj0h1o6zDZc+1WAVETJ/jOY6bTLG/M
         p8BXzO2KiH2emps8UrsuaEi+zZWaUIgc8E+246BIW3zn3yNIEiGao7L4o1M5IhRNPZuC
         rTQA==
X-Gm-Message-State: ACgBeo1rBN9NRAziwPjAqaGArVjRmevwEOqGiHZ+TTwGjR8OmzxKSA6h
	JMOwNeL7caKFztdY0xQlZls=
X-Google-Smtp-Source: AA6agR57t+z0NrVVf706nrGoQwZspNiDzPC23IfS/dNBcpzyfeH+piS/RU0NnbS480L3/NkyCAQZXQ==
X-Received: by 2002:adf:f6cb:0:b0:220:7859:7bf with SMTP id y11-20020adff6cb000000b00220785907bfmr5841614wrp.683.1660477554457;
        Sun, 14 Aug 2022 04:45:54 -0700 (PDT)
Received: from [10.100.102.14] (85.65.248.193.dynamic.barak-online.net. [85.65.248.193])
        by smtp.gmail.com with ESMTPSA id b10-20020a05600c06ca00b003a54f49c1c8sm5807959wmn.12.2022.08.14.04.45.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 14 Aug 2022 04:45:54 -0700 (PDT)
Message-ID: <12dde734-5c03-28f6-2552-6f48c1d1efb6@grimberg.me>
Date: Sun, 14 Aug 2022 14:45:53 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 2/2] nvme-auth: remove the redundant req->cqe->result.u16
 assignment operation
Content-Language: en-US
To: Jackie Liu <liu.yun@linux.dev>
Cc: hch@lst.de, hare@suse.de, linux-nvme@lists.infradead.org, kch@nvidia.com
References: <20220812031231.3386953-1-liu.yun@linux.dev>
 <20220812031231.3386953-2-liu.yun@linux.dev>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20220812031231.3386953-2-liu.yun@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220814_044556_276097_07D99A5C 
X-CRM114-Status: UNSURE (   5.85  )
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

