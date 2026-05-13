Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92841CD37B6
	for <linux-nvme@archiver.kernel.org>; Wed, 13 May 2026 08:37:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=UCSTAcYotCmBexv+RZlyzJ/eAz
	YJx/6SROKrrv2yH8fNKmhfQkEsAOaj8pMl3ZXDvlpabhUt5VHxwud0qH5O9/WULUGeqJ6TxUXqagO
	5kyPRkwRvLJO3cDHP1H+pGRDgaowVS0g6qL+lixs8DGkV3XvUpM/a+v7wmyftYPfkptczimLOOUNo
	OYD/T9bFw1U3Ru1GcD4ryMECpFRM4Yt9qIFA0Ogy191+q6EArlMBHi/AbZrdNRAcFZWgZ9YJMT7e9
	RF53HjPSQIYB3hW7QATQDJB0zVij82dto5Q6DsPuGe3i5frHsBtqdGpdGwJsBvdBihKTHdv/plzOx
	tHsoB5xg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wN55w-00000001lAQ-08pJ;
	Wed, 13 May 2026 08:37:32 +0000
Received: from mail-wr1-f44.google.com ([209.85.221.44])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wN55u-00000001l9z-1frx
	for linux-nvme@lists.infradead.org;
	Wed, 13 May 2026 08:37:31 +0000
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-441209fb77eso3921492f8f.1
        for <linux-nvme@lists.infradead.org>; Wed, 13 May 2026 01:37:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778661448; x=1779266248;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=QarIQsAGNoo9tXLBHceZUhbceoCNiFt00iqFhNruf/MceEaR/nbL7c6f1OWs3Rs6Al
         KNAFafHPMiAH0adoXgVga0V3egALj2hpzYqAtmO9kIbODBUOsIPfUi4DeYEAxtwd1WyZ
         DxU9B4v3Lgs8rgpmWvILF2+PfIKM0LTQ7F8t8Gwycl6q4VkM+bXfqk3UWJW9vnBlHheR
         XPTatzudG7EMxOQQboBJ5wrxyqy7sN+ks9K58RbNmClOtE/iJ3DmmWFaUoy0sDQ4rfeU
         V9L5lIsTkSurWtGr9fm0PhQvCO3WXZbcrgp+aPA1MA6z7RB8i1rDVzs25YC5Fi6MqtrG
         k0mw==
X-Gm-Message-State: AOJu0YyVzi4xT7V1mwiNreIWqlYPyXmAj/NmNRQCJwJs2/80aikMTey0
	c1hZ0VRO5an7YV0sgKNWWcMf3jgwtbjSh5r7yGXGq0/HpGd3rXUNG/2d
X-Gm-Gg: Acq92OFBYpFjUPBT/I92DV5gAVHSmHiL6yP6bypuqW11FaE+B0Kt31x1sxcrCHnLcbX
	8YbcpXA758c0MZX/2NhC8GL2dbKX5+gzUApL7Hxs66PgomwH8QsPngKjoX7Rr0OGKHC4+uCMBnD
	TrlGYYKozhRuQWq2KrPammF+bXczjKRqAomszxDNRKxppcGJNB48uV1R1wsJvEZP4rHQHUDj0a+
	SWN9usjhh9fT7d+nxZ1Sqc0ne1WhRFaf7WS2tD1ys5IQSfHwXrPqb0q/qu8AA/nnVAoxNGP7rxK
	e8ihoCVX7EZpm4ZezQYG3l3BhLTPI7BOpP1niwYTUh3a7/INZfLn5PWp7Y5aYedsyNlvN4VGtaw
	/s3WBRPva7gFlTYA5rT5bYzqGkozJz+EFhZ/Vz4EtqOZ7rbr12KqKdmbJLQZdjVC3zCX98oBYpq
	F0aE00HM5xksw8tZvPHXRwC7w+JTmtq56ifU61Hsn2ydZQQLvC15KkfCTDPeOHttSu7H/9+5MgQ
	IA=
X-Received: by 2002:a05:6000:1ace:b0:43e:aa88:f1a8 with SMTP id ffacd0b85a97d-45c440bc542mr3977327f8f.6.1778661448387;
        Wed, 13 May 2026 01:37:28 -0700 (PDT)
Received: from [10.50.4.153] (bzq-84-110-32-226.static-ip.bezeqint.net. [84.110.32.226])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45491304387sm37781644f8f.21.2026.05.13.01.37.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 May 2026 01:37:27 -0700 (PDT)
Message-ID: <d8cf39c2-ef76-4f9e-9134-f316d4acab26@grimberg.me>
Date: Wed, 13 May 2026 11:37:26 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] nvme/tcp: handle rejected keys for secure
 concatenation
To: Wilfred Mallawa <wilfred.opensource@gmail.com>,
 Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 Christoph Hellwig <hch@lst.de>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 alistair.francis@wdc.com, Wilfred Mallawa <wilfred.mallawa@wdc.com>
References: <20260511234551.2925326-3-wilfred.opensource@gmail.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20260511234551.2925326-3-wilfred.opensource@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260513_013730_434971_5522A398 
X-CRM114-Status: UNSURE (   6.20  )
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

