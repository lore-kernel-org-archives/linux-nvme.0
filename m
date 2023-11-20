Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02DFFC2BB3F
	for <linux-nvme@archiver.kernel.org>; Mon, 20 Nov 2023 14:40:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=jrOW+O0T1SMsLqm2qL68uzqCqs
	JhcBBVDOmElYblvl7XzLhmu2ZgrGfUBIRYdSQP+y3nHsELLxAJHyoutCExVYebKlJO7SIZGgdxBVb
	Um7BYibsXb+M6NLcQQm6nw6FyW0eG83n2/ZdO8R7tIYIzhc9TGa2yu2NScFh12zZLKQ172dhBQGtf
	b7Dr22dmvyBuibgls9IPCdC/2bAWN74FZ8Ohl/Iys3DCm4BohSnQDgpOrUWSXWz8j1lRhTUC/D2vL
	usdqKRMwgBwHJhJTXSnwIKZy5gx7d+jddjE+uiCjsejygiE6Z3KZ+sIDsq2CUIG3BwvuTjbCVVyYY
	OCxQR7+A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r55Ru-00CKMd-0R;
	Mon, 20 Nov 2023 14:40:30 +0000
Received: from mail-ed1-f41.google.com ([209.85.208.41])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r55Rn-00CKHv-1Q
	for linux-nvme@lists.infradead.org;
	Mon, 20 Nov 2023 14:40:27 +0000
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-548034455d9so1002831a12.1
        for <linux-nvme@lists.infradead.org>; Mon, 20 Nov 2023 06:40:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700491220; x=1701096020;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=XzC4pNVG8qVCmBPMQu059tdw/y/I8fgo8pf3MBGAN12bdJyUBNms996M0t0CyoreZ/
         n61P5ge+x/5n3w3D//46Cghzj6pDE0rkTaFDIKMc86Tm5lfcZHCWYHkNGfvCbhzeDuQk
         m84Clgx6NtEulaX3HyqVQNzvVd/ZeGk/47AhWh8T+4jfoFZE9+0rd6PBF4G+cLRTwmRK
         gaxKUgKQMc3zHxksKcriLtxNh8kSTvF/iH7+XyKVHLxV33Ry/AcmN8bXKKf1k5IWbnqN
         r9VhpO7VLwJ5HFOcDRb2KOHrl4U4DNwqI2VD6OU9yt01R/RsXV4OQBttem7970ReWWyT
         vxqQ==
X-Gm-Message-State: AOJu0YwgTYNnrHscboYVcgruEvYxVhFXvh9IKZe0W5cC2khsyexpl+Eu
	XuUUZ5WBJy4H+Auy0oXceM4=
X-Google-Smtp-Source: AGHT+IG7DBCw0s55HSfLvfLvyJtR5hNJGd0DukOimwysJpxdwjL2RRiQyZHm7ju0v3+DMXm1hx8tGw==
X-Received: by 2002:aa7:c390:0:b0:543:6222:e37c with SMTP id k16-20020aa7c390000000b005436222e37cmr5178096edq.0.1700491220570;
        Mon, 20 Nov 2023 06:40:20 -0800 (PST)
Received: from [192.168.64.177] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id w6-20020aa7d286000000b00548b96a52besm1158371edq.78.2023.11.20.06.40.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Nov 2023 06:40:20 -0800 (PST)
Message-ID: <7cf414f3-0e04-4031-a80b-194712c10008@grimberg.me>
Date: Mon, 20 Nov 2023 16:40:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme-keyring: add MODULE_LICENSE()
Content-Language: en-US
To: Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
 Christoph Hellwig <hch@lst.de>, Hannes Reinecke <hare@suse.de>,
 linux-nvme@lists.infradead.org
References: <20231023230052.31161-1-rdunlap@infradead.org>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20231023230052.31161-1-rdunlap@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231120_064023_651795_BD66041C 
X-CRM114-Status: UNSURE (   6.13  )
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

