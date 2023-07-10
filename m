Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D32EEB64DA
	for <linux-nvme@archiver.kernel.org>; Mon, 10 Jul 2023 09:30:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=xxdjUqswuGMDSTUXXmVbqbj5wF
	kDJr9lOuZ6sDqi0wD+LLMPbFMU+/2W5kcF18hM3qUVQNZtVWQjEibFLz8/luJuw9g2ttBYpQbICP9
	5C/zJolZLFSF+b0SLd0u638mbBjn3Oj6A488NvnLBfd/US1922czijPjhbm2x9ViW6AxGanTHcv0J
	k8TN4JUqujytPcFtbQ3PlZWyhnwzbh08d+Eio28dEYeAaeNY4dvKdb5sqonI0qU4uW4NiHmenslZk
	eSDxx8bIt2I6rqKYH9exGllKbI9sLNuNxS8x4xWRIKe8eT5pw+F7sPkILVG/qb0qYh63GeNzAvVjK
	ze31MsJA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qInDY-00B0dl-18;
	Mon, 10 Jul 2023 09:30:04 +0000
Received: from mail-wm1-f52.google.com ([209.85.128.52])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qInDW-00B0c1-1s
	for linux-nvme@lists.infradead.org;
	Mon, 10 Jul 2023 09:30:03 +0000
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-3fa86b08efcso7741315e9.1
        for <linux-nvme@lists.infradead.org>; Mon, 10 Jul 2023 02:30:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688981400; x=1691573400;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=O3tL0eNnrQ559TX3B8uhMTPLTdtZICGvvkdCUXwjraH0y8LHlcjRr95/dMWllb3xfB
         /PI57IVOI4Y0H4opmVc5D46J3pdkkFoBYWtUBqWbvEM833jqo19IFwMBjn9ZXGrCMQNe
         QWadoezTQIv35KsnatLAXKhnSj+cHOl5s2/rxrz6V2206UyvxNrVZzIb9on5ktMbXhYd
         dlXZVMF7UVGsIubspzvP5FCHOw86SELQEeOjUhI8jT1A5GGnRY30vYDVZrs5VkVO6B3M
         Xi2+6qNysVySLjRiIv5nFjzukhj+6iM7SF6/FrdKgmpfnvgGf4djuj8d/TumcxCXBiWO
         3sXw==
X-Gm-Message-State: ABy/qLbInU+Kdkaek8oWh8kgZsCpEzT4XXeHD8ak2lyEMiNapoRlTj/7
	KCjm1QsUkzCx53s+PhDm3dc=
X-Google-Smtp-Source: APBJJlGG9cfGQMVw05py4Ra8WWVn7tTX5dl2w1GUvYJfa6uz8tKqdRZZS/ToqZODl11afxdYIfVjaw==
X-Received: by 2002:a05:600c:3b1b:b0:3f9:bf0e:a312 with SMTP id m27-20020a05600c3b1b00b003f9bf0ea312mr14323974wms.1.1688981399717;
        Mon, 10 Jul 2023 02:29:59 -0700 (PDT)
Received: from [192.168.64.192] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id v24-20020a05600c215800b003fa95f328afsm9752007wml.29.2023.07.10.02.29.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Jul 2023 02:29:59 -0700 (PDT)
Message-ID: <d4982c2e-b993-b6c6-417d-db0238de47e9@grimberg.me>
Date: Mon, 10 Jul 2023 12:29:58 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 2/4] nvme: update discard limits in nvme_config_discard
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
 Keith Busch <kbusch@kernel.org>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
References: <20230707094616.108430-1-hch@lst.de>
 <20230707094616.108430-3-hch@lst.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20230707094616.108430-3-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230710_023002_623958_D9B61AD2 
X-CRM114-Status: UNSURE (   7.26  )
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

