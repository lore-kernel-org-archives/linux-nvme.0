Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87445E6FE49
	for <linux-nvme@archiver.kernel.org>; Sun,  8 Sep 2024 07:08:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=CLsuNqWw+Tx5z9u1ptZPasCAGn
	/mxCxCQnWd3VhICA2PfjnAT1uBzaP1PQe/v6P40LThG0z7R+Kl9D4+JginVyx5uUf5rXL6INpzb+n
	drOCX/K2lhc6KkPjcPVleqf8ZqDJkfli0IJQZ4HqDgs9J73M+rqbZBCU8J5cYR3MIMt4+rI0f0Bka
	qc90m6lSoswqQTGKpIwlHzH1TCqRNaqkYa9TP6tdlhu19XZkPszuG6BkYg2M7tH/3KyjJ2sAPw9qd
	xpbztzbF7MKar14E09hoQmFxPckxB6TNfiHrLzHWb6eYGQqu2F9CWi2JKz28xo2VCeoDqhP9fsT1j
	kgDZQH3w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1snC2H-0000000GHeh-3vtc;
	Sun, 08 Sep 2024 07:08:37 +0000
Received: from mail-wm1-f48.google.com ([209.85.128.48])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1snC2D-0000000GHeC-3eXQ
	for linux-nvme@lists.infradead.org;
	Sun, 08 Sep 2024 07:08:36 +0000
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4280ca0791bso28812385e9.1
        for <linux-nvme@lists.infradead.org>; Sun, 08 Sep 2024 00:08:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725779312; x=1726384112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=luBWs/Fxkdfqh2Bps/I4oIMYA0CrknGyeBgl4HjntvF+T4QK0GoSbsdMrgZdBSlq/+
         X2Ql/BMa2D7aHzxBukrOG/bJZD/lGP4DCggKOi11Wzg/seXcS+mJg7K9mCnscNmrRkdr
         OjmcTvEqfR7oxkk2tevrKItu2YxqnvzUXSCBWZx+jPDOy5eaPUdJUksmUxCD0npQgA/4
         IcbMN8cOiHZq8chBtAazxmbL7m2wZPHuXC6QLgsY7ZLe6yVllw03iF7FmDwwc/nWiy7Q
         CSvQ4uWkT1IOW2HEnsHTuFtMKJOWPGf0G7npMi39jHIEMzszf1NLPirzqWV2VMtFEyse
         Ib0Q==
X-Forwarded-Encrypted: i=1; AJvYcCUe+3B8lqZ91nhoQjdgM3cdfuYmqJCCKartqZs3rfmDrCbsZOojb/h83MrfF9G1OUcp2dFvX2kFs/BI@lists.infradead.org
X-Gm-Message-State: AOJu0YwjGoANUYoWYTwoWtx0VoWZdafs+SkdzEMm6R+8FdoK1PlCmZoq
	IMUcT+EaNTX6p6g4gqkQWEplrkXyv8KjiKHsy1QWLY4qL4ehLKZo
X-Google-Smtp-Source: AGHT+IGRU3YluIGV+wqwGWofwG6fGXEO8dP99eASrFCBw5UHI0k+N8kIG9Uwb9gX7/ovQb8XPICwgA==
X-Received: by 2002:a05:600c:3b25:b0:427:ff7a:79e with SMTP id 5b1f17b1804b1-42c9f985149mr57840325e9.16.1725779311685;
        Sun, 08 Sep 2024 00:08:31 -0700 (PDT)
Received: from [10.50.4.202] (bzq-84-110-32-226.static-ip.bezeqint.net. [84.110.32.226])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42cae117aeesm39115585e9.6.2024.09.08.00.08.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 08 Sep 2024 00:08:31 -0700 (PDT)
Message-ID: <aa936a10-5331-42f9-8673-cd4a9cb9bba0@grimberg.me>
Date: Sun, 8 Sep 2024 10:08:29 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] nvme-multipath: avoid hang on inaccessible namespaces
To: Hannes Reinecke <hare@kernel.org>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
References: <20240906101640.44417-1-hare@kernel.org>
 <20240906101640.44417-3-hare@kernel.org>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240906101640.44417-3-hare@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240908_000833_930640_1E79DA4E 
X-CRM114-Status: UNSURE (   5.39  )
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

