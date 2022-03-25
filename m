Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45304C433F5
	for <linux-nvme@archiver.kernel.org>; Fri, 25 Mar 2022 13:44:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=kl2Li9Z++CqTUC0lFLJ2VWDkw/259+VgBxfob6qn0zM=; b=o658dSF8U6y5mKYThJ9qUPFzqi
	/zZ1fwuQTUDWXOC39wxbTTJm5o30oEHmh6BEMKbC5dnt0sZhaq4EN0nYu2Q5NojVv0GTqgePX3JU8
	VOgaPvoDFGtAu0jx/6Yew2XrS3nrkaTBHvVx6DWOpyfOa9T/ztft7Yi1wf0O92i7BkDqATViuQXuQ
	E5ajONCV1m5dvRe+kK2ZS1G8kJSaqJ76sscY4XBiV7+fwi+LoI3IK2v7KRpTcnGgZq6wtSEFlnW2Z
	VP1PXtmCJNPsUm3UHO5ofCMVUwsAlYhUyP16vlsPdIfQXkNJGrgCtu9M4TDP7cUkqE+Rxfimlpst7
	pdZcd6dg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nXkFD-002CJT-8i; Fri, 25 Mar 2022 13:44:47 +0000
Received: from mail-wr1-f53.google.com ([209.85.221.53])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nXkF9-002CHd-LI
 for linux-nvme@lists.infradead.org; Fri, 25 Mar 2022 13:44:45 +0000
Received: by mail-wr1-f53.google.com with SMTP id t11so10946949wrm.5
 for <linux-nvme@lists.infradead.org>; Fri, 25 Mar 2022 06:44:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=kl2Li9Z++CqTUC0lFLJ2VWDkw/259+VgBxfob6qn0zM=;
 b=wNcc5WRrDu1tCh7GkSiAlTPaJ7YBtosWvLr0vv+EwqEmSot+1/6gnU1P7vRg9OgOnX
 9ZUnZ5zAIYGaf2Vw6STolqGqxllbzons7/1GkoYJPx9wAumFdgxjh8j4sYkNAlnqT0k9
 0qUmtlDJZ8w8l0ztOVuoMErpd4l/hOqpeeQYm44Ztdzti7ebnC+hqsaaxgeYpIwJsy7Z
 eYcweSFtAN71tstlbgMIGFE6Tv1EXYrAEyy89ytS0q09ybmFdIWemFi6UlRZHhsEUmYi
 SgvHSC2NbnEkqE4vzF6j9+VIG4vnSMVPkgBPG1lTJU3JAuKtKz5Hnrcm60a1jqUiweP8
 ozRQ==
X-Gm-Message-State: AOAM531WAIoQND2fncCG3wjzZa8F+sCvyuaDyMZms0K9s72A0bMbAmOC
 DvjYnD4hhJwpjpbwUA8XolI=
X-Google-Smtp-Source: ABdhPJyY3wUgcYloufU4hlto44Bj2E0GeWFQeH2zowBSPUGINM50QEh6VWnApasWISFuX5BW6KsdRA==
X-Received: by 2002:adf:eb89:0:b0:1e4:b8f4:da74 with SMTP id
 t9-20020adfeb89000000b001e4b8f4da74mr9603386wrn.408.1648215882150; 
 Fri, 25 Mar 2022 06:44:42 -0700 (PDT)
Received: from [10.100.102.14] (85.65.206.129.dynamic.barak-online.net.
 [85.65.206.129]) by smtp.gmail.com with ESMTPSA id
 e8-20020a056000178800b00203da3bb4d2sm5945955wrg.41.2022.03.25.06.44.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 25 Mar 2022 06:44:40 -0700 (PDT)
Message-ID: <b7b5106a-9c0d-db49-00ab-234756955de8@grimberg.me>
Date: Fri, 25 Mar 2022 16:44:37 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2 2/3] nvme-tcp: support specifying the congestion-control
Content-Language: en-US
To: Mingbao Sun <sunmingbao@tom.com>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
 Christoph Hellwig <hch@lst.de>, Chaitanya Kulkarni <kch@nvidia.com>,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 Eric Dumazet <edumazet@google.com>, "David S . Miller"
 <davem@davemloft.net>, Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
 David Ahern <dsahern@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 netdev@vger.kernel.org, tyler.sun@dell.com, ping.gan@dell.com,
 yanxiu.cai@dell.com, libin.zhang@dell.com, ao.sun@dell.com
References: <20220311103414.8255-1-sunmingbao@tom.com>
 <20220311103414.8255-2-sunmingbao@tom.com>
 <7121e4be-0e25-dd5f-9d29-0fb02cdbe8de@grimberg.me>
 <20220325201123.00002f28@tom.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20220325201123.00002f28@tom.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220325_064443_796379_C41F9A17 
X-CRM114-Status: GOOD (  16.79  )
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



On 3/25/22 15:11, Mingbao Sun wrote:
>> 1. Can you please provide your measurements that support your claims?
> 
> Yes. I would provide a series of the testing result.
> In the bottom of this mail, I would provide the first one.
> 
>>
>> 2. Can you please provide a real, existing use-case where this provides
>> true, measureable value? And more specifically, please clarify how the
>> use-case needs a local tuning for nvme-tcp that would not hold for
>> other tcp streams that are running on the host (and vice-versa).
>>
> 
> As for the use-case.
> I think multiple NVMe/TCP hosts simultaneously write data to a single target
> is a much common use-case.
> And this patchset just addresses the performance issue of this use-case.

Thanks Mingbao,

Long email, haven't read it all yet.

But this doesn't answer my specific question. I was asking why should
the tcp congestion be controlled locally to nvme. You could just as
easily change these knobs via sysctl and achieve the expected result
that dctcp handles congestion better than cubic (which was not even
testing nvme btw).

As I said, TCP can be tuned in various ways, congestion being just one
of them. I'm sure you can find a workload where rmem/wmem will make
a difference.

In addition, based on my knowledge, application specific TCP level
tuning (like congestion) is not really a common thing to do. So why in
nvme-tcp?

So to me at least, it is not clear why we should add it to the driver.

