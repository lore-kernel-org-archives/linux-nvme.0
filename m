Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44005C47DB3
	for <linux-nvme@archiver.kernel.org>; Mon, 29 Jan 2024 20:05:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=y2U6Zonf0A5kzI8Ab+oUWMG2Kh
	7sUSwR3nFjrG1ujqaFUAjY5oHoOnd9cps+U7foNwmqk1Rg0l3xGgR3C73GzK2SdP2nNe/ltM7o3eU
	rPTP3wtZPZ/ggzXOfVBfokkhgwyxQs+C0Q1OkRn6Hht8jfFshuEdovlWLZKRDeKXPTqKIxqJFyXr7
	xSdku0lKQ9YkvJgRftUKuVIJT9NNnuW3JycZ/470xjM6mZ5DhR6kYtmIUYNU+G78FFW8NW4qrjp/1
	tjTECbHS5A5ufNqSPc/eqrDWAR8mZYMyVIQ6qkzqjmZIlxz19g2KVz6zOgGcssD7/+1wTD36n6M9l
	24Gibamg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rUXtE-0000000ECSc-0rMF;
	Mon, 29 Jan 2024 20:05:56 +0000
Received: from mail-wm1-f47.google.com ([209.85.128.47])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rUXtB-0000000ECRX-3cdq
	for linux-nvme@lists.infradead.org;
	Mon, 29 Jan 2024 20:05:54 +0000
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-40e5980e1b8so6491535e9.0
        for <linux-nvme@lists.infradead.org>; Mon, 29 Jan 2024 12:05:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706558752; x=1707163552;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=ueXZQXYMWcC35XQPL31RfR8vRSESwlmqM8CdCG77UGoA+X0mFv/GjhPy6f2Zg4n+IZ
         plMucgrEV4Iq5HM3AWNBiby4AnNKd399tIIyw5eenYXSR27nhnalqolrRfYJOfzYNy2m
         ls6mJQiILW2DoAS9BKYBbuYV4ijGQH5NPVtXeH+HK2bpRa9wze4Vko5RQhktLiVKS8sA
         EUDemmxg1UIYrYTfU3ojnWd7pPp42YWRFwfOlmR5+syA5OXZTImLvvuzwB2TOhkQ7gGx
         7qeazZUnBC46F+jmhC+yUQM/CdAIi1VsFzellZyu8QEQh+egsQ2FGHNenaOpuIrrMQ2V
         1Ntg==
X-Forwarded-Encrypted: i=0; AJvYcCVX9CXMW1eU7ihKcsP+Covnif0ZdArbmfKkXBEDHZLdUdvGIjZOBy216y6cl5WRwGnyhrkJzIuaw7MazLurLWD7WjvwKAtri6NWDD4iBpQ=
X-Gm-Message-State: AOJu0YwZo1f3i04hOlZMfwhzMLu9XxVuYXavO9XwZqhg7vY6RQWkro/L
	Xi6eIz1Uz2ZD/0fSD3XJuZkrBQEGz85beu8CfISPGA83f4wSK3uw
X-Google-Smtp-Source: AGHT+IEHRxz66iiC0ZDIn7V0RlczFptD7W/MtlHifBgv70sZ7iJlTx/sDcz0tD3VLids7H24T8IJIw==
X-Received: by 2002:a05:600c:5011:b0:40e:f5be:2fd2 with SMTP id n17-20020a05600c501100b0040ef5be2fd2mr3881442wmr.4.1706558751753;
        Mon, 29 Jan 2024 12:05:51 -0800 (PST)
Received: from [10.100.102.67] (46-117-114-124.bb.netvision.net.il. [46.117.114.124])
        by smtp.gmail.com with ESMTPSA id p22-20020a05600c359600b0040eb0fd9295sm14916833wmq.44.2024.01.29.12.05.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Jan 2024 12:05:51 -0800 (PST)
Message-ID: <c0326cb2-37bf-43dd-be9e-77249b422d0c@grimberg.me>
Date: Mon, 29 Jan 2024 22:05:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv2 2/3] nvme-rdma: show hostnqn when connecting to rdma
 target
Content-Language: en-US
To: "Nitin U. Yewale" <nyewale@redhat.com>, chaitanyak@nvidia.com,
 linux-nvme@lists.infradead.org
Cc: kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, jmeneghi@redhat.com,
 loberman@redhat.com
References: <20240129110639.45542-1-nyewale@redhat.com>
 <20240129110639.45542-2-nyewale@redhat.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240129110639.45542-2-nyewale@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240129_120553_911669_184CF55A 
X-CRM114-Status: UNSURE (   4.01  )
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

