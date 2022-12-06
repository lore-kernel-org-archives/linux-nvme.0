Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4025BC352A1
	for <linux-nvme@archiver.kernel.org>; Tue,  6 Dec 2022 12:15:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=d3rFNrhIZCrRpE7VYyMS7m8dL4
	q7WoQb7gn2YCbZpY+RXV6B+/lU0TyLb6WpszXv1BvQXhLqdy5aFxzWU58QFLw8w7BBJLWDxfgKCsW
	1m0O3RXxJgASlNOs02RN2izVGoUuoUFWwkmLFkkA5bxWNmAfgihUybB00ATh7XXkeS4U9I6S57xS4
	lffZ7sJtYcoxVz8vtk2K5DtTVqF1srZS+w+yjbA4WLpdoNMuNQG1TMHSxBT0NFFWo48c9DO63xbT+
	0rWcFxVHhlO348SJuviGE717rxczSMlReQ7juxz3TweyfEtzeMmkEViGVI4glOc5jU8EJ8TRjCvGg
	U+riXvzw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p2Wr1-0090Lg-9H; Tue, 06 Dec 2022 12:15:19 +0000
Received: from mail-wr1-f52.google.com ([209.85.221.52])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p2Wqx-0090JJ-7m
	for linux-nvme@lists.infradead.org; Tue, 06 Dec 2022 12:15:18 +0000
Received: by mail-wr1-f52.google.com with SMTP id bx10so23248170wrb.0
        for <linux-nvme@lists.infradead.org>; Tue, 06 Dec 2022 04:15:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=yUHyl3KpB7Y5cArniXG4cM7C3wzNTZzewUQW85eXWJYtKvcCnbAmXIijajiMf+A4D6
         Q/cBEVYLaFDohDGjXUyn7eYThhES2rMGbGBVFba1pG4U3upiZ0aKU9RQtnfALAdxM8Cn
         XRCcd86fUCPjgFmMUDbwp2yZKBwwLQDWzDltUC6npL0/DBv7KVwKdzSIaS3bSA/IhDsa
         6adjim2GvdrEJzNb1DVsIHXq8LfuIm71z9CP6yU/AESJPq6AMYTyThWQ1kNJKx3JggsF
         BNbaafY0wNLo9+7imQOGIEETjyC4+p8W46RYoTD1ownq4aiRAlCvPb6Ldwk7OaGLYxkj
         MIzg==
X-Gm-Message-State: ANoB5pnDix+3QdTOMxnCLF7txnniWOInVtkvSSJpVKBUneFD6guJPZeO
	0o+AxHMkfRsaCQ74BXR7bR4=
X-Google-Smtp-Source: AA0mqf5vnMke5iP0dUngAq2ItZpKcfdOhKPZ1a6dxhMgKyIK84HTvZS9FvB2xL8d8jmlABpJmIw/cw==
X-Received: by 2002:adf:ef06:0:b0:242:73cd:1107 with SMTP id e6-20020adfef06000000b0024273cd1107mr2301812wro.250.1670328913637;
        Tue, 06 Dec 2022 04:15:13 -0800 (PST)
Received: from [10.100.102.14] (46-116-236-159.bb.netvision.net.il. [46.116.236.159])
        by smtp.gmail.com with ESMTPSA id v7-20020adfe287000000b00241fea203b6sm16567634wri.87.2022.12.06.04.15.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Dec 2022 04:15:13 -0800 (PST)
Message-ID: <532fe3d8-391c-afee-13c0-b957eba409ab@grimberg.me>
Date: Tue, 6 Dec 2022 14:15:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 1/9] nvme-apple: fix controller shutdown in
 apple_nvme_disable
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>
Cc: James Smart <james.smart@broadcom.com>,
 Chaitanya Kulkarni <kch@nvidia.com>, Hector Martin <marcan@marcan.st>,
 Sven Peter <sven@svenpeter.dev>, asahi@lists.linux.dev,
 linux-nvme@lists.infradead.org
References: <20221129132208.4337-1-hch@lst.de>
 <20221129132208.4337-2-hch@lst.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20221129132208.4337-2-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221206_041515_285569_017E6552 
X-CRM114-Status: UNSURE (   7.20  )
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

