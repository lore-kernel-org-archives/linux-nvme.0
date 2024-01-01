Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B68ADC47074
	for <linux-nvme@archiver.kernel.org>; Mon,  1 Jan 2024 09:50:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=E1eNNplI7fWzE+cvwcQuWAja6p
	2wwurmhRZNU/h3RALesGSOIRieS7oqaTIOS//5P0STMxZLHeEj+BFRX+W26g2n1VzsgbNMyAR0ni+
	kIpQo4PkDrBYrHDuSKnimhtEyi1MTAnVFmkIH+MfcxJBOCs+1+HHzOEBAji8eUzEng8dFzslcquew
	rcTXszieDh717xV3Rkfpo5AmMMQAIrUxgQ66rUEWmK+Nn/4MN6XnnmD9aICBcG0hVB941tazafwaD
	SQWnO072SvPvyfzD6ZXyM7TqhgLCn2+n+WTW6gxN/Le6oqImSZbjhDmPPmPQ6mwxXKBugrnvuSLGl
	gXQdkidQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rKEw1-005r71-06;
	Mon, 01 Jan 2024 09:50:13 +0000
Received: from mail-wm1-f50.google.com ([209.85.128.50])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rKEvz-005r6S-0c
	for linux-nvme@lists.infradead.org;
	Mon, 01 Jan 2024 09:50:12 +0000
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-40d8902da3cso752545e9.0
        for <linux-nvme@lists.infradead.org>; Mon, 01 Jan 2024 01:50:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704102609; x=1704707409;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=MyFL6tJGZbq3kOtQAFbb+a0AhObvdHy4B2Xb1njT2fk9vg118JSJm6Ln4vTNk6gN4s
         GkVLGUNXniwz6PDejaBw5up701IWNaEE53fDmlYokzXDPIWgnYOg2l9nRoc/8yBx0m8G
         XzBPIRTPKbMp8AKkXQAMJyoO8ABrk8NbP/+s9Vjf2h1++g1sLz7dKr/ZKUY8Cg5ubD7H
         lVzam33wN0rshGam/QLcJG7ykjgoTlA6o+kqbL6BqvuEKJL6Y1BmRDi0HGIWMED1iSuh
         yR5lWB1qxrgfKXr1HdtCDbKDwvKYcSTbdAglTvikghFBcy7br97vGa/BjV22Ofpo8h60
         31Vw==
X-Gm-Message-State: AOJu0YzynWwjY1oAKxLmzkdl5gW/wr5F1+b3tEq7BvTTenhqjXyHerXu
	9xg2nQc3m+UWQLYdOdRuHDU=
X-Google-Smtp-Source: AGHT+IE+XvosiEv5ah7v3suM8a9u349061a6f2W1Y+bQanoRNZoeqyRTImwtC6KrDKHJcHVgKYqQnA==
X-Received: by 2002:adf:e382:0:b0:337:2a0b:a7f3 with SMTP id e2-20020adfe382000000b003372a0ba7f3mr4699261wrm.2.1704102609622;
        Mon, 01 Jan 2024 01:50:09 -0800 (PST)
Received: from [192.168.64.172] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id p9-20020adfcc89000000b003368100ff71sm25419409wrj.10.2024.01.01.01.50.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Jan 2024 01:50:09 -0800 (PST)
Message-ID: <bd594437-78de-4776-9001-047245c3bdc2@grimberg.me>
Date: Mon, 1 Jan 2024 11:50:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2] nvme: introduce nvme_disk_is_ns_head helper
Content-Language: en-US
To: Guixin Liu <kanie@linux.alibaba.com>, kbusch@kernel.org, axboe@kernel.dk,
 hch@lst.de
Cc: linux-nvme@lists.infradead.org
References: <20231227090525.26662-1-kanie@linux.alibaba.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20231227090525.26662-1-kanie@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240101_015011_231321_7ED3160D 
X-CRM114-Status: UNSURE (   5.03  )
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

