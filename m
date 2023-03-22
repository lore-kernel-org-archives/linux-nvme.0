Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F1C9C6FD1C
	for <linux-nvme@archiver.kernel.org>; Wed, 22 Mar 2023 08:18:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=lZY7NcxZkVbXeL/rmFVEhBYegKsBGBfLtTnIxhyw9VU=; b=3Wa1s1MwcL8ilEFq0r9evtZ48x
	sY8tVL6F0gMrvaee+PqHR6ODfZXpSNpm9fs4mDcXvAgjLSOAsijPdjbsxEdp+wm8PkCMsjdXrCwwW
	OZsY3p1fkyVih1ndijIyFxmYNCPmxaAfwA0Tc8NiJz/viJCc8ERGwWvAH+MqMp+T+jpjkY+q0I8so
	CWDHI6ipnwH603vdkB0k35p10vtuo+iu67IdNbZpAr247n7ymdcfpvP6NLXncmq/6S5eCFSwPpf1w
	Lq+6XjDms/9VVCOzIRg3K6SkMrM7zCwqhcSbVu3EqVZToSplYZv9anoJiLWoC012sCsa5WU3Dbrue
	aDZuYjLg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1petfv-00F8sW-1s;
	Wed, 22 Mar 2023 08:18:27 +0000
Received: from mail-wr1-f42.google.com ([209.85.221.42])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1petfs-00F8rP-2Y
	for linux-nvme@lists.infradead.org;
	Wed, 22 Mar 2023 08:18:25 +0000
Received: by mail-wr1-f42.google.com with SMTP id y14so16083508wrq.4
        for <linux-nvme@lists.infradead.org>; Wed, 22 Mar 2023 01:18:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679473102;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lZY7NcxZkVbXeL/rmFVEhBYegKsBGBfLtTnIxhyw9VU=;
        b=F4wKk+GsZnET6pOux7LT9+uyahIf1g7rJnA9bCtT4iTEuv0p651XsuAs/oILtdk74Y
         vs7iztLvTlfGPiO6Ezq1rJu+nXRg831kM4J+DqcUMvX+FAyam2GqHwtBWrfHEA16B/2b
         e9kKRGaSt6SQVmI+Q3wbNuqXQCZM+mvqPabUlSIzApCQkqoF63xBisHZdY0xmVJDG6el
         YJjv92BFJVN6aJVmbUT3OCkW0mG2LluLoTPXNytekXnvCAieBBbLK7Ia+8S2iRN3+eZR
         0KvF1OxWtGHy33UsU3KUHTQXUg28y+zndL4s+z/BERYKBtLYDQLew0VYJ1NTgFq1VXlA
         WwKA==
X-Gm-Message-State: AO0yUKVDsBjNg4tYiPLU/MQU5WJgUC9sm0Tug59t3YdsymM6IxHD8znc
	f3zQlLMOYoR/ceAmRwO7THE=
X-Google-Smtp-Source: AK7set/Cj1fZ/dxkmP/Amezv8/KpNWlUmWQ2AkaoLpRRDE7VbiJjhwvFHkyaV2Ifj8AVAWJJNNHcBw==
X-Received: by 2002:a5d:4985:0:b0:2c9:8b81:bd04 with SMTP id r5-20020a5d4985000000b002c98b81bd04mr3388139wrq.0.1679473101984;
        Wed, 22 Mar 2023 01:18:21 -0700 (PDT)
Received: from [192.168.64.192] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id s15-20020a5d6a8f000000b002d743eeab39sm6504440wru.58.2023.03.22.01.18.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Mar 2023 01:18:21 -0700 (PDT)
Message-ID: <0f1e3763-6445-6b3b-d876-f5fe934f35e0@grimberg.me>
Date: Wed, 22 Mar 2023 10:18:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v3] nvme-tcp: fix a possible UAF when failing to allocate
 an io queue
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Keith Busch <kbusch@kernel.org>,
 Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
 Hannes Reinecke <hare@suse.de>, Yanjun Zhang <zhangyanjun@cestc.cn>
References: <20230320133334.57325-1-sagi@grimberg.me>
 <915f65a2-226c-ae20-0575-e20120e72a72@nvidia.com>
 <20230322081539.GA22139@lst.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20230322081539.GA22139@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230322_011824_831026_02C61D36 
X-CRM114-Status: GOOD (  10.29  )
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

>>> +#ifdef CONFIG_NET_RX_BUSY_POLL
>>> +	queue->sock->sk->sk_ll_usec = 1;
>>> +#endif
>>> +	write_unlock_bh(&queue->sock->sk->sk_callback_lock);
>>> +}
>>> +
>>
>> since its is not in the fast path, is there a particular reason not
>> to use following ?
>>
>> if (IS_ENABLED(CONFIG_NET_RX_BUSY_POLL)
>> 	queue->sock->sk->sk_ll_usec = 1;
> 
> That won't compile, as the sk_ll_usec is not defined without
> CONFIG_NET_RX_BUSY_POLL.

I didn't check with CONFIG_NET_RX_BUSY_POLL=n, so you can
disregard v4 if that's the case.

