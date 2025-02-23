Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A4B2C021B2
	for <linux-nvme@archiver.kernel.org>; Sun, 23 Feb 2025 12:21:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=4j95YXQJw8nvIQqAPts3LGcXFL
	//FUtqjmKWz7ZOfPaFn5419b62nRZ4lj7FhuA7yC26LM+hSBT76xuSEMKEDVP3lhXq52gDoUt1uL8
	gvBUe/i/XU6MuT4NkGy2Ezy6CBxjrGCdHt8f/5wkDgmj0Fa8v4JWegxL7K+guAaAcdXtIpbHMA633
	8yfEsVUE+fJH+2mg7rImKK71hvbaShCs8KB6Vs/fD/zveRT+PoKW2YBHkLQq4vTO1+NIPKdmBxZAT
	5dDt7H1scF/Zhp+BqhmYFPtjRvFK15/IJySwchycAEFXQYhxpVgfbD4ytmj0tqkqJs1iEQhfnczFQ
	6iiurrPg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tmAzG-0000000B4j7-2BbW;
	Sun, 23 Feb 2025 12:21:34 +0000
Received: from mail-wm1-f51.google.com ([209.85.128.51])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tmAzE-0000000B4im-1vhG
	for linux-nvme@lists.infradead.org;
	Sun, 23 Feb 2025 12:21:33 +0000
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4393dc02b78so23615385e9.3
        for <linux-nvme@lists.infradead.org>; Sun, 23 Feb 2025 04:21:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740313290; x=1740918090;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=V1JpG+SwYUR1CsJx/XfH28+mglqmzTpjhJvF0k9AOkdeec2oQfAkPohfSBl8cG5dz2
         H7bK2vTyPpbYJNP78CO3SsQ3tqGkFPkE/eXL67pDeDwkqDUzajIRplgWFCsHAA+irGvM
         V7bRVvMyZTzZBeY9+3I5asSXRYO4fu7iL25sgUqdC7sHl6NRW3Djd4jXPX0LNzjDPzAv
         JxzSIJUHo1dlU+HDAFBmvwNb6+wb+ELEpays46M7xu/RUnvf6uthWlT5R3zhR3mRLC4M
         3yRYc/WnVcdiGnyYBmU852Ge9lDqs0q+lWF93fQ33E6b/b0lkivzdqBRQhlI118Md8fF
         h4Jw==
X-Gm-Message-State: AOJu0Yz20aZMVcDo7+rkAl+if/HHhOS//opOyZl1oAnfnNE++2hdsSpc
	/Eg+7NuAl63K4/LC5OHHfUc0BEQydSwNIuEgaFSEsXyGWMtlWvFn
X-Gm-Gg: ASbGnctkQ8xW60pcCxPTxWCyA5ZYArtw2DbdxzFlWcqleR/73Ep0G4lPI8rhVedGM6t
	r4qWPwvgyn3egLee9aAjv1tS9+C2BZknUVA7Z/zwy7nMQ0xtZhufUgoE5yP5gVCW10eAPA8zJ7Z
	b01EG8pokfeFi2bEKIYDYr9SJPwyFJKD2X3kPRPPp8MIaXDufrdqehZNxuEaUhjMm/h4m8tCnr2
	BD5c5z2OuL5kT3sGK6pkJs6XiRWiwDhffTxf1vVivOvgA6/ZO0VfeFjSQ7tMVCUp4oD8LVui2Te
	TICUT/YKMMTAkejFznyQj2/zivIuHh9qBa0Bv0xbUHjub8vIPF/xidh6r6vmW3efiRNy
X-Google-Smtp-Source: AGHT+IECmwTHv3swB/Z8XXyD3H1xBZyNqSl6wr0pTsH6RfJjRamMOP0DGVCua8WZip0lTCInZxU5Cg==
X-Received: by 2002:a05:600c:4ed1:b0:439:a155:549d with SMTP id 5b1f17b1804b1-439ae1eacfdmr83096305e9.12.1740313289908;
        Sun, 23 Feb 2025 04:21:29 -0800 (PST)
Received: from [10.50.4.206] (bzq-84-110-32-226.static-ip.bezeqint.net. [84.110.32.226])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-439b030be6fsm76296705e9.31.2025.02.23.04.21.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 23 Feb 2025 04:21:28 -0800 (PST)
Message-ID: <fdfd2f96-624a-4d4c-b3a4-89f2fd04bc2f@grimberg.me>
Date: Sun, 23 Feb 2025 14:21:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] nvmet-tcp: Fix a possible sporadic response drops in
 weakly ordered arch
To: Meir Elisha <meir.elisha@volumez.com>, Christoph Hellwig <hch@lst.de>,
 Chaitanya Kulkarni <kch@nvidia.com>
Cc: linux-nvme@lists.infradead.org
References: <20250223072845.3470297-1-meir.elisha@volumez.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20250223072845.3470297-1-meir.elisha@volumez.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250223_042132_499275_A2891968 
X-CRM114-Status: UNSURE (   4.52  )
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

