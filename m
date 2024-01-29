Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A57EC47DB3
	for <linux-nvme@archiver.kernel.org>; Mon, 29 Jan 2024 20:02:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=wJSbz2KfAWCs3YTqZt7tTRCl2I
	oxUPZeuTOuHm3h8lN96bV4SZ8mgLlrS5NTciEOtJ7km43JA4AqdznK7zHOfkD9ahPB56CYzIVTJZS
	w/5D6pLKf3s6lh7nApbxabk5ANUOLgYiIIp0438W+UK8CPA5QulRhNxVQzPR3abRY8CFGuUWlYY7u
	wd+3vlw/TCWMxY8VBeZt3qesjwNYnqnb8tJiPpIgcgG/HcF3d5qolRvOeDI3ezWyej0R812HZSHWH
	HnIAnhV5Nsjov0/kKdGHV627OM//Al1gcLaEvVjeQ1kKdE4N6dFUqKIdkixsXGG5jZXu/DtdLnH9v
	sZwXXl/A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rUXpR-0000000EBsQ-3hti;
	Mon, 29 Jan 2024 20:02:01 +0000
Received: from mail-wr1-f53.google.com ([209.85.221.53])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rUXpP-0000000EBq3-0q5S
	for linux-nvme@lists.infradead.org;
	Mon, 29 Jan 2024 20:02:00 +0000
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-338700e53d0so193128f8f.1
        for <linux-nvme@lists.infradead.org>; Mon, 29 Jan 2024 12:01:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706558515; x=1707163315;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=eoA9A//Gh9cpWiCm5s5j4ViLagmyKAj4JcwzhOcCQI1J9u+ndG6wq0rsE73nO518Fr
         dOHKwOpvc7okDxVbovgATVZE6JPDBUAU05KMrRovXeWCnqwRIIVAkyL531755eLgGFHM
         RYP8IQTEumIUnFyPOyIesgNSCZbVsfblHAMwkje2SNo7IchncKoQD7YOZIQuPXVMa8QT
         BGuHe1s677SOORlVdFOlq9gGkq1QqJKWA/0XBlA+m18gQ7gd3kbuUamal8Jfrkgue+Ea
         lzGdjWUEAAqShY6JD1ClCVBC/Iw3tZaARLNq3SFI+KVRDT+zu0qBbD+PgIBql+6GrLIv
         l0dA==
X-Gm-Message-State: AOJu0Yz+zkFvl0iYeCxzA01QgMxJVDP2xT4GjOpSJCCpZTRt3xX7ipbk
	1YiA4i9T7kWvx5Ar/vVrfheo1aNROuMGRLJM0i2dVMz4DDe/WXdk
X-Google-Smtp-Source: AGHT+IHYn+UELPtiuI8NV8Sea3QKJCu3HEA1ARE5w1xAN7suekNzvydN9sW6OaNSEuKWqSGFc0K0TQ==
X-Received: by 2002:adf:a19b:0:b0:33a:e4ff:57dc with SMTP id u27-20020adfa19b000000b0033ae4ff57dcmr5393039wru.4.1706558515495;
        Mon, 29 Jan 2024 12:01:55 -0800 (PST)
Received: from [10.100.102.67] (46-117-114-124.bb.netvision.net.il. [46.117.114.124])
        by smtp.gmail.com with ESMTPSA id eo6-20020a056000428600b0033af5086c2dsm1401965wrb.58.2024.01.29.12.01.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Jan 2024 12:01:55 -0800 (PST)
Message-ID: <4501e00a-f0b1-426c-a38f-202139ed7228@grimberg.me>
Date: Mon, 29 Jan 2024 22:01:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] nvme: enable retries for authentication commands
Content-Language: en-US
To: hare@kernel.org, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
 Hannes Reinecke <hare@suse.de>, Martin George <marting@netapp.com>
References: <20240129063948.3105-1-hare@kernel.org>
 <20240129063948.3105-5-hare@kernel.org>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240129063948.3105-5-hare@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240129_120159_256111_9C583B47 
X-CRM114-Status: UNSURE (   5.31  )
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

