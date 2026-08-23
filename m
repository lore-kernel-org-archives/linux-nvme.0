Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 868E3C5B572
	for <linux-nvme@archiver.kernel.org>; Sun, 23 Aug 2026 01:07:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=U3uSuBrqzdeMfLRpTq+rimJu98
	JdELG6K+4YIdVA7dJBpyAeYoPrstZ6punMjkjqjudm+2oyipIlH6yVljrb2YGyEOCoS+joj+KCbcR
	IDPVNgIrTiA0prktqcu0+UhJHSLOiyVPOftGJ7ioR2tn0m7tPl6HsnfSVp/pcXpB8cKz8ibBIbREJ
	oKDTlAqKm6T+lGCyo86QNGTJ5HTglstH5aLtE3Y+9mgYdolkL7+EUdvNOG2F14nZ9d2fWCt9QsP0X
	d+W/OoyMN/f5XT69i51jA6rYZDOb7nNAP4s/lh5IGJVVGNRLwroNagyE+/5EhlZe4qhmObzlDXOcC
	BMZ8+Lqw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wxwgU-0000000ExIN-2czg;
	Sun, 23 Aug 2026 01:07:38 +0000
Received: from mail-ed1-f47.google.com ([209.85.208.47])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wxwgS-0000000ExI3-14f3
	for linux-nvme@lists.infradead.org;
	Sun, 23 Aug 2026 01:07:37 +0000
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-6a36982a875so3473777a12.0
        for <linux-nvme@lists.infradead.org>; Sat, 22 Aug 2026 18:07:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787447254; x=1788052054;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=tUYEW+8mjXd2a/sfEI444aBN3sCRez9BczyjDy3rvgDuPAVhwlPmo6w8ZjCdeF2FOe
         F8/PLJrVkPdhI3m/QDBg58CqWo5apxWD10//EYB4fKSWylIw1HYrkEpfgIDaG0jw2x+w
         T06Jec7GsyPIdmCUjUJ327JwPZGHQ6Fb32aMYL60Zl3ThGTbOszRVKKTHQg3aIBzbula
         C1F4DVeiX2zxk+YIcMYlNSMEkhbRPXGawfnd1PAZgGuCYpRvsFLO4Pf6S6PQlvio0x8d
         felzGR54Qnx62zlZvqiW9cO6xlUnr4c592j6rBfjpJsvjt5HUoWnyrV/7daZmyGtNQxr
         MYCw==
X-Forwarded-Encrypted: i=1; AHgh+Rpz9TAQwIL4wSjFWofI6gtcW7R28HLjTolKv4/us1Vp5DgSHjQlyFcVtXpwG2f5GpVxAGQTSJno5n+y@lists.infradead.org
X-Gm-Message-State: AFuF++nEIEXOpTs0YSLYZ8udTuOZrKL0iFeRYLPlbQoSnjzoGUexvyVj
	z3JaG92kHUoRD5jDPVJWFl/DASXncyCWbCe8s+bZMRaRS5+nMk6eW1O/
X-Gm-Gg: AR+sD10dWDpz3byx9yxgzFmMNk5OQad95uplTpf5JnhnINe8xjif9LcXzPYyVALk056
	AeXc0zQY2wb8H14NhlNHacQaCnyNIxBRX+lRlvHBY3kvLrJUIMscan/hPwOW/Gzp27nwXvjLHr8
	DJwqd0Co6oGBA3DtAsWYTEl/D3Ah6VQAI57YpBznHo/k+E+mX+6FoiChYZEgklVgYZWmSgY3N9N
	SK87uCmvnM5fVeiCHDHRBb/++ZLYmPiguP894WRPblp1enRrGjfL6yjhC74X2bW/OzGQuZEdmjQ
	Ix9P+xOOmDf96svNbWJQ+lHHS/Q1qo5gd0agbOUbvDN54nWrfxPzDDtgJL54R4COX+5L0rGyJTC
	2M3bH34nenkmNqsRq3d8xnVqY2i+BG4gtzDzXtLqc8OOs6jdGTQ5AnGr3J2lrfGhf/Y3TPSw1wt
	IvOhdCGW28CG7uteF3LqSexZMQvtm1mnIfGRWBQe0DHaHvcH5D6R4K3yQMnjkeBxsLnroWd3aL6
	JcSz1uH/I4GtzOsc0617nI=
X-Received: by 2002:a17:906:5183:10b0:c16:84dc:9607 with SMTP id a640c23a62f3a-c246a704562mr1486609466b.19.1787447253990;
        Sat, 22 Aug 2026 18:07:33 -0700 (PDT)
Received: from [10.100.102.74] (89-138-65-240.bb.netvision.net.il. [89.138.65.240])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c24966f99basm521445866b.37.2026.08.22.18.07.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 22 Aug 2026 18:07:33 -0700 (PDT)
Message-ID: <a76d7c12-92c0-4765-80f5-8bec647215c2@grimberg.me>
Date: Sun, 23 Aug 2026 04:07:31 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 16/16] nvme: Add support for CQT to nvme host
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
 <20260712022437.3743117-17-mkhalfella@purestorage.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20260712022437.3743117-17-mkhalfella@purestorage.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260822_180736_312533_8CC52F0D 
X-CRM114-Status: UNSURE (   5.51  )
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

