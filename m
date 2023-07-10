Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D84BEB64DC
	for <linux-nvme@archiver.kernel.org>; Mon, 10 Jul 2023 09:32:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=Qnm1lAEANCY20WSAAUIQfTG8bC
	d9YRwewzwPEp2ZkOQn1hwejKm8UkaSLC05/6H4sHG8bXBYnEdbUmj191xjosgFD7CJhblhNZogVbO
	G77GvIFf9cR1Lsbr3yXFzTsyxUqD0b2A4dB9zaNvLs2XTRpr9agJyHlBO9VrKJ7hRh9i0oPNIoH0M
	yD1OIZPWt/KuRsg2IJULgdeMcivfHP2psjLNL4AM0OXKbAQpyJ172xPT2CZrYDGFNSaJQpiA0Jn8t
	9eM0pKI9i/j6u0RhOUwPDGVZ0RXuLRlGcdwZwv1bDA7u2uT2bTgIYIl6UW6Mr/+04hQjk/z1WT0gK
	qQKTmkJA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qInG5-00B1F3-1t;
	Mon, 10 Jul 2023 09:32:41 +0000
Received: from mail-wr1-f43.google.com ([209.85.221.43])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qInG3-00B1E0-02
	for linux-nvme@lists.infradead.org;
	Mon, 10 Jul 2023 09:32:40 +0000
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3159acfc48cso195774f8f.1
        for <linux-nvme@lists.infradead.org>; Mon, 10 Jul 2023 02:32:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688981557; x=1691573557;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=KG7QELWE9W2KBFv0m0akJCoMSQUS/XXu9qgXCij88y80EIq4Q5q1Ptg80qQe8K4dHj
         Z0Ic1w0A6B/NPbEdULtdCnlfiDx2SRxQDUq4D8azHxkRD+GYIG2AlYdsmof0xjzaB1dg
         ZKDBm0okGpo4jB9LagLBFvWw7SF79qwKm4V1k+Z8EBziLNcBx1i5cwdujo4QsmJZQq78
         4h3oI2++o/eZTELHaOeJ0keU1juF1wOCrYlUnH09IE1rpJ2TSaE7RBFRZFPeCffOJAoG
         IDIaKHYHaLpoBuM1hheV4/B4sFvPn7n4TSVU58slTVsHadrsRAKy9iR76k9e3hTOwSTZ
         PuBw==
X-Gm-Message-State: ABy/qLaWmLnKdR0qPCt0vMUYINAe+Cgyn7LVxfzDVf3gJpdp3y+P82LL
	/dWdKF4ONJdap0yXMIYeIyBw+MlsikM=
X-Google-Smtp-Source: APBJJlFGa3h1OxjP0fcWsDDpnrcXsCeNBmBLSQFnRSX/QfFKhlMPvuz20SkqEc5eAlm+BA+WYrGazg==
X-Received: by 2002:a5d:6748:0:b0:313:e9d9:3004 with SMTP id l8-20020a5d6748000000b00313e9d93004mr10433889wrw.0.1688981557217;
        Mon, 10 Jul 2023 02:32:37 -0700 (PDT)
Received: from [192.168.64.192] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id q3-20020adfea03000000b003143c6e09ccsm11207863wrm.16.2023.07.10.02.32.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Jul 2023 02:32:36 -0700 (PDT)
Message-ID: <427a5543-ce19-e974-2593-5e8ea96602f3@grimberg.me>
Date: Mon, 10 Jul 2023 12:32:35 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 4/4] nvme: simplify the max_discard_segments calculation
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
 Keith Busch <kbusch@kernel.org>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
References: <20230707094616.108430-1-hch@lst.de>
 <20230707094616.108430-5-hch@lst.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20230707094616.108430-5-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230710_023239_045147_F7764736 
X-CRM114-Status: UNSURE (   7.28  )
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

