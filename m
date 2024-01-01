Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10FADC47073
	for <linux-nvme@archiver.kernel.org>; Mon,  1 Jan 2024 11:18:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=nfJU76OBu48kgtfoZAb65OrrI1
	0jLkeyDZFkget91bri/9H133mRhxsfGNEHQfS0XUUB5LTEAW6prWURUqXbP/OFbk7nY6CAnnYjv+E
	h5oWVW/19hhohRYMtBLW6VX2SM33ryxmBNN7k1dLNv0aIWajoyTDXvCT1HFkVtgjYVrOhM/QplrUh
	5SyvzIXUan8H70ITLO9hbcfiS1mUuELxFChQcEuB37/DTDtGMqfLZ8STnICnYjYWCnuk4rtITkN6L
	04SNmqplzzT48vUMQKWBwAzwd6vkY51h7j7u3V17nJOt1FQbOut5aAfD4ZadQ8SnvE2u4uGwVD09B
	/QgJCmCA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rKGIv-005vmu-2E;
	Mon, 01 Jan 2024 11:17:57 +0000
Received: from mail-wm1-f43.google.com ([209.85.128.43])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rKGIs-005vmV-2p
	for linux-nvme@lists.infradead.org;
	Mon, 01 Jan 2024 11:17:56 +0000
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-40d2df9cc39so25502045e9.0
        for <linux-nvme@lists.infradead.org>; Mon, 01 Jan 2024 03:17:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704107870; x=1704712670;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=OdCJPtYOYsKYThoKucS7h70R4GYFpEB08eVKAJnpQ68BIR5wTIhBs4p2rDkxc5faeg
         dP7y/FtvXNxJubX5QyTN8NH4PkeiR40CAK/xRgOkK/F0rWDvPkZomPGyCrqTx94ndy5g
         wsMKLquCefbgSrabkY6/toDrydpRD5mzYgpbQwErBbdQrz+e9/uZZO6mIdLYKlXhklui
         kHY3fSfualQg1jcxYKqUoAnf44jXq7/NUVIMxyHiSLrnB66K6IZpY9ciEA1E/sLoBD5B
         LBTPfKsB+UdD0dHOW+B2r2X9okTDstEb9HNR5ne8M3YlrL4TViiRsp8DrdbuIE0ukPoW
         FruQ==
X-Gm-Message-State: AOJu0YwIl1XyAPgAqL5xqrvQMUH/9JSSO5eZ1Fm1QzmiGvtwystK52Q/
	DmY52dKI7eT4JnEwzqwNHptDPzLWJzQ=
X-Google-Smtp-Source: AGHT+IFFh+iLdgi9ii4BF/0FvnYI/ezwC3Crca9GFyucTIXsW73GzwUm7QQuLticwCSC1CXPnMdYgg==
X-Received: by 2002:a05:600c:3581:b0:40d:5a39:b6de with SMTP id p1-20020a05600c358100b0040d5a39b6demr11588071wmq.1.1704107870218;
        Mon, 01 Jan 2024 03:17:50 -0800 (PST)
Received: from [192.168.64.172] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id m2-20020a05600c4f4200b0040d5c58c41dsm20296850wmq.24.2024.01.01.03.17.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Jan 2024 03:17:49 -0800 (PST)
Message-ID: <32918354-8837-453b-a677-f89b10f9e53e@grimberg.me>
Date: Mon, 1 Jan 2024 13:17:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] nvme: remove unused definition
Content-Language: en-US
To: Max Gurtovoy <mgurtovoy@nvidia.com>, kbusch@kernel.org, hch@lst.de,
 linux-nvme@lists.infradead.org
Cc: israelr@nvidia.com, kch@nvidia.com, hare@suse.de
References: <20240101103527.8034-1-mgurtovoy@nvidia.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240101103527.8034-1-mgurtovoy@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240101_031754_914448_661E1965 
X-CRM114-Status: UNSURE (   5.56  )
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

