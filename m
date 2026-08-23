Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AE5FC5DF8C
	for <linux-nvme@archiver.kernel.org>; Sun, 23 Aug 2026 00:55:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=lsVrs3PivcW8PZeboATVQHQplr
	wouG80wJgtehqCcujBZJvzI6qpPfxmy8uU5LgEa/9/I51WOjbJ6pSwJ/iXffH8tvjax5/WLG3wTGB
	9eQ2PiYtZ28+rkoqEGG7uWoYH1OYXaTd5ovEu1WArCrpKrddHXMLZ4LlvWMut2PSbyAuUR6OrqaRS
	Uh5wKK+sFSP97Fv9bxQaDSz/Pw6qlIkPoN0PJ/YXIU8hO/ppQC8RdQY2rcd5LE32+Nr2SlaU8J+i9
	nQz/r9oQiRQYky2/f8Vah1fii2zEavZWgdJEEz8mfa6mnIoSjCi1/toWil1g8p10fwEubSwnUqGsd
	QOSwgoWw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wxwUy-0000000Ewjk-2auM;
	Sun, 23 Aug 2026 00:55:44 +0000
Received: from mail-ed1-f51.google.com ([209.85.208.51])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wxwUx-0000000Ewix-1T0s
	for linux-nvme@lists.infradead.org;
	Sun, 23 Aug 2026 00:55:44 +0000
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-6a15d54ac95so3983863a12.0
        for <linux-nvme@lists.infradead.org>; Sat, 22 Aug 2026 17:55:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787446542; x=1788051342;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=jFLDRZgLXwOfCKn7LQbqgfJF4qV97n9IZqYPJOOm3/mHrZXOjucH+TmRIA6lzzLxHL
         DjS/PsdPD1Yxy+QSluiGkSnkgzGBq8aVZmBha8ygVDM2BN4EVeQEuMLcIOGIbwSCPtHe
         8I7rmq05A5lwGBnWPNYpzc5F8ieojB7lb8koprSyQoVWaXn0dvv6Gb//8DOgQKAzeHQT
         2bXQlUZDDztGdZNy9Asjng0f68wPLiTcvi6XM8CzWHyBeeLKynywHcqJ+lJwz0+rcwcf
         ZdslCUTqezhbxIXJoRAS1Tn6lQC3nZbibv8heSJUv3+OfYRaa1/ZKHWg6ONH+DNLhUxx
         6Ccg==
X-Forwarded-Encrypted: i=1; AHgh+Ro/mctb5WCLzQsCN0cZtJ7StvAfQ+xMnuQDj3XfVSgxECJB9scwUYQTgmUlHuKO0rRydaMyYkd0f92U@lists.infradead.org
X-Gm-Message-State: AFuF++mpyNMMOwJZW/V82L4xZop2JvOzooJqnCfZ4B6v0YcbTHqAagkg
	RL2d8C2qE1WKPXr9SJVBCJaJKl0mbIWfKG27cD3PdbWIo5tBOfCTX055
X-Gm-Gg: AR+sD12+PKWg+kQmw9KOWQv5kF7NFJRpfvYE7iNLkgQoLVUMGjD4M3PFF9Mq5/tTb8o
	aoG29c1sA6GCWeLCHcBfVOHuwM9JoifKNdGufh/ykMa27cTVsyoVT/hP/Byqom5bkPpKDHA7548
	mvLqdEjNRtPYbgT5DQaVu3UTq8vKSTHhSrpdP5Neo5pGWwHUIoU+znN2uFdnykpSu8GGZm87xIR
	T+JOzqJw7kx04kn24+otPDdgW7PxPzdJqSKnSchAn3XYGhyPwWYcNMOqVLBb8DQUfwhVO03MbAF
	XIJgKnZrJrTJqOd/5Ceo6RUfLZsonmCa5H0UuYLa2+lZmEftBXdHC3oWpCSmHhq5kdyni+q9FKX
	3wXcK8hyJDoI7I/7fAkME2zd1zYCMqgO6l5sdY4bFtfF5Y9njFhVCgfDirTE886Li8bL1a1FQoh
	0dhdTCbQX/U/y5OVjRc5ovWHOVAzkMqaBywThJXjKDX8J9RI+v5hozF0C1JQ2OBsVzeQUO7031A
	ryW0DXt9YvZb3lz/X8qXyU=
X-Received: by 2002:a05:6402:1ecc:b0:6a3:74c2:3cf3 with SMTP id 4fb4d7f45d1cf-6a582b0c826mr10001765a12.6.1787446541575;
        Sat, 22 Aug 2026 17:55:41 -0700 (PDT)
Received: from [10.100.102.74] (89-138-65-240.bb.netvision.net.il. [89.138.65.240])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a59e1ae4efsm476903a12.21.2026.08.22.17.55.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 22 Aug 2026 17:55:40 -0700 (PDT)
Message-ID: <62efd10f-16a9-4f48-8b0c-b896094404aa@grimberg.me>
Date: Sun, 23 Aug 2026 03:55:39 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 07/16] nvme: Introduce FENCING and FENCED controller
 states
To: Mohamed Khalfella <mkhalfella@purestorage.com>,
 Justin Tee <justin.tee@broadcom.com>,
 Naresh Gottumukkala <nareshgottumukkala83@gmail.com>,
 Paul Ely <paul.ely@broadcom.com>, Chaitanya Kulkarni <kch@nvidia.com>,
 Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
 Keith Busch <kbusch@kernel.org>, James Smart <jsmart833426@gmail.com>,
 Hannes Reinecke <hare@suse.de>, Randy Jennings <randyj@purestorage.com>,
 Dhaval Giani <dgiani@purestorage.com>
Cc: Aaron Dailey <adailey@purestorage.com>, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20260712022437.3743117-1-mkhalfella@purestorage.com>
 <20260712022437.3743117-8-mkhalfella@purestorage.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20260712022437.3743117-8-mkhalfella@purestorage.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260822_175543_390647_0E36CCA3 
X-CRM114-Status: UNSURE (   4.71  )
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

