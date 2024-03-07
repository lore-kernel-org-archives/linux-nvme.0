Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2F49C54E49
	for <linux-nvme@archiver.kernel.org>; Thu,  7 Mar 2024 11:03:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=o7A4QvOSNBM0InAcafkAPubTCPTrSgoh7jmIeUuQOwA=; b=ngwiRO2nSD8yYbLquhXUlPYiZ2
	0D7DjQqR+ydq4mTdGArmcpyR7yGfVegtwneBduddrJdvvNXt3/NLJDF78b9m5T6+Ck6IMary3ngs1
	QhAS9Wb9flQxPxYHI0tp189+yEfqFPyMU2Mhw132+jCOeSYL0MGf9qTaJpFncNNTMsf0zWjr9Ji78
	T/K7J3CFtBIoixesykoA0XCE5WxTYXdEAQ+AuJkms1fuGxBMShlYHwRdyvq8vEqE3w5CTnoClAE8G
	3aFD2HY4VIxY26ybH/kG2K+9ybNPoolRp9djVR4mD26tpQC1ZMbPwuJbKxs4vvaAyynZ8UUELuoA9
	kOzRA5lw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1riBWp-00000004CT7-1qwe;
	Thu, 07 Mar 2024 11:03:11 +0000
Received: from mail-wr1-f43.google.com ([209.85.221.43])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1riBWm-00000004CSZ-24Dj
	for linux-nvme@lists.infradead.org;
	Thu, 07 Mar 2024 11:03:09 +0000
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-33d855caf7dso184177f8f.0
        for <linux-nvme@lists.infradead.org>; Thu, 07 Mar 2024 03:03:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709809386; x=1710414186;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=o7A4QvOSNBM0InAcafkAPubTCPTrSgoh7jmIeUuQOwA=;
        b=M9SR27w+6+oeXawjDmFxqHojFVrF7xBYjYLa76+e5zJYg0TXjBtRYbq/ebo+x8YJ4V
         jVWSc37ZpKEpEidtpTkRtU9k1a6SUO+5jZHxy6YbQ6ctw85FPtv3c0173VLeE/+/7jxb
         7AT7mrBoZkkRJaIWBPoFWo1k5/GjY/S0mvUWpdK+1SMK1jvCGrDOvOHFXEGJ4zC19S9a
         xipsWaW8ohHb3E8f2bvJWmvU8YWoo//H1kHMwcuLpvijCnK+LToga46O9vS9Xatj88I0
         ku/bzFpYMLMk29Mb/M6sOZMSCwLjzw9yDl+wMv70J5oRNnh6M9902fMxwzugrm3ebIUO
         WIZA==
X-Forwarded-Encrypted: i=1; AJvYcCWMabXonSpBgljWdwogdgKUq2c2J9sTPkwD1QDwfDLAWMj9SS/KlMDpiYvmsAq+X3+LbfvuTzImuyzGm1dcXdCdoOb/dxZle4ACvgC6yuE=
X-Gm-Message-State: AOJu0YyYBDx/WNHGs4Rn9+s62iP9H+XCjL4cFbNhoP7gJkt6F4Baw9tz
	6qC0dLHw5NS3waCvPTZWQBJ0+JU+Qzo85la9ltmwPiVp17aqOGxF
X-Google-Smtp-Source: AGHT+IF29fxosvWorKlBZzDAEmvaC5zY/82HrtX47lJ4wr+HetqoRZwvlJ6PjBB5jmiD+RHy5aj0Kg==
X-Received: by 2002:a05:600c:3512:b0:412:ddee:e66f with SMTP id h18-20020a05600c351200b00412ddeee66fmr1195363wmq.2.1709809386487;
        Thu, 07 Mar 2024 03:03:06 -0800 (PST)
Received: from [10.100.102.74] (46-117-80-176.bb.netvision.net.il. [46.117.80.176])
        by smtp.gmail.com with ESMTPSA id he11-20020a05600c540b00b00412ea93220asm2239650wmb.12.2024.03.07.03.03.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Mar 2024 03:03:06 -0800 (PST)
Message-ID: <438bb4bc-1102-41db-9ecc-af8fb0e42d07@grimberg.me>
Date: Thu, 7 Mar 2024 13:03:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/13] nvme-tcp: sanitize TLS key handling
Content-Language: en-US
To: hare@kernel.org, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
 Hannes Reinecke <hare@suse.de>
References: <20240127093058.15699-1-hare@kernel.org>
 <20240127093058.15699-10-hare@kernel.org>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240127093058.15699-10-hare@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240307_030308_566416_643391BA 
X-CRM114-Status: UNSURE (   9.46  )
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



On 27/01/2024 11:30, hare@kernel.org wrote:
> From: Hannes Reinecke <hare@suse.de>
>
> There is a difference between TLS configured (ie the user has
> provisioned/requested a key) and TLS enabled (ie the connection
> is encrypted with TLS).

When would the latter happen without the former?

> So to differentiate between those two states store the provisioned
> key in opts->tls_key (as we're using the same TLS key for all queues)
> and the key serial of the key negotiated by the TLS handshake
> in queue->tls_key.

Does nvmet generate a different key for each queue?

