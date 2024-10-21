Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBA7CD3C927
	for <linux-nvme@archiver.kernel.org>; Mon, 21 Oct 2024 00:17:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=pLbyzUZWZvrnaD/BDQqruEu5f1JViojJsMEKDQQMPMM=; b=kImAnRlELkmkxy1h6UYSjdS9LO
	kcFdPh0x07FDN0wbSY3d50k3juf0RTTN/lUdON/t9pEnfopTWaBFbO24Kzy0nB1jIyqVfQ8IDaE/u
	iH8d+PaZnzfpyE9wJSPX0xGAcU95ApO0tNItIx8vN392Oi545Lch4Jz1/beO/lcfowjJY5PWxEaXJ
	aCVBjNLcVl4zNxhR27J7Ys5K0BdSAfBs0AyfmFPTnUKn+Pg5qJmzDJF58n8COgi0+q43HsCfs0UYJ
	bMI9tuEdscInDf4Xa5XwrYKzPeHJ3rZRiD7trjxGqQSzg/jqkxZZHK65pV4x8pD0L/nQui3R3isYl
	R2WsgVDA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t2g7L-00000005glv-4Bhv;
	Mon, 21 Oct 2024 00:17:52 +0000
Received: from mail-wm1-f42.google.com ([209.85.128.42])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t2g7I-00000005glN-2mPL
	for linux-nvme@lists.infradead.org;
	Mon, 21 Oct 2024 00:17:49 +0000
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-43155abaf0bso38050085e9.0
        for <linux-nvme@lists.infradead.org>; Sun, 20 Oct 2024 17:17:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729469866; x=1730074666;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pLbyzUZWZvrnaD/BDQqruEu5f1JViojJsMEKDQQMPMM=;
        b=L1cqzdITkQ0p742zIMJrUI3zAKJObpiBsvRD7d2kdO3t9BWBXlbWh5UAnW8i+M2NNO
         4aGRz9pAjO0yhn4zeLwUVqmKIMF8ox408YFIzu10Tq7U71gsXIDvHZPXCxKh6sOK3yaA
         ynicO8rfnfbZl5fnV8F7sAsPHH7CDPrUxGj3zuSF5G8EJ5M28URvqWtSDVdwV5MiDjIP
         wXW3h9sn0KzrOIvSkcto/4PaHvrnPwDaHNS0qAQ8K2GjudBsgi5TpwbZ94EZqHB3KGrl
         EiAd3wlzxFaWkorYK96fY4UgEV0Lmzql5l6ZyWaeKAALf7rfDRMLB02WoA0j3v2OWmQa
         RaGg==
X-Forwarded-Encrypted: i=1; AJvYcCWUA/uMPsSkG/rAn9+AItBjRoLQZz1cEEl1guwr7I2B8D+pO/uyFFfAUPoJbFzF/muUK2b1m40ZpDXA@lists.infradead.org
X-Gm-Message-State: AOJu0YxKNDNIo65uP40YCRQq3eKMYJJOxyT3Dq4a1tQuejCKgP9kE2gb
	8zpKTNinOgtPUfKKZJWmQWH29y8mkEit+aEN/b2VTd0llrsgzSCFQ0zQ/w==
X-Google-Smtp-Source: AGHT+IFDjZnM/GDxmZjKV9INdbm6hvaKul5zrKVdepPuGxVbHhD/0IC65Wzqx00XeGE4Hp0ATyNLqA==
X-Received: by 2002:a05:600c:3592:b0:431:586e:7e7 with SMTP id 5b1f17b1804b1-43161634f28mr74804455e9.1.1729469866327;
        Sun, 20 Oct 2024 17:17:46 -0700 (PDT)
Received: from [10.100.102.74] (89-138-78-158.bb.netvision.net.il. [89.138.78.158])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37ee0b9442bsm2852189f8f.78.2024.10.20.17.17.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 20 Oct 2024 17:17:45 -0700 (PDT)
Message-ID: <3eccf1b3-3671-4f40-a268-40efbb9e0fda@grimberg.me>
Date: Mon, 21 Oct 2024 03:17:45 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme: use braces for list_for_each_entry() loops
To: Tokunori Ikegami <ikegami.t@gmail.com>, linux-nvme@lists.infradead.org
References: <20241020161423.225237-1-ikegami.t@gmail.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20241020161423.225237-1-ikegami.t@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241020_171748_736066_F0373C8D 
X-CRM114-Status: UNSURE (   3.99  )
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

ok

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

