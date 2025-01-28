Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 005DBC02190
	for <linux-nvme@archiver.kernel.org>; Tue, 28 Jan 2025 08:03:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=T3hVRO64AqzcmJVKPrza3YuSmD
	XMd+yWyhsryuaFTqQrbsGD1baGecR9bHD2Earmxo+ECJAhV0rkf7Eej3oIY0ItgSxLsnNyTyLf463
	v4i0a/zYaq52MG2uRWYa/gnND0TdzN8NShNdPBQGn8snKTPQO45nIrmSVF/ERqYVzqP1sWtmbltxU
	Md8rUhmcqPzmJWW6w8miFE4jNWs41rBaY54+AVHRS7e/StQINSXoRLzvyhDX6ad3MrdEEEjKxbm0B
	95NCqazRB3SvTf/uKlOVL2JOp/g4lD7RRQMEUF2z8Mje716nHcVkmlBcs/qC7/ltdYAt8+ybDOeOQ
	ICLuV4EA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tcgYr-00000004K8e-2rH8;
	Tue, 28 Jan 2025 08:03:05 +0000
Received: from mail-wr1-f51.google.com ([209.85.221.51])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tcgYp-00000004K84-1Cru
	for linux-nvme@lists.infradead.org;
	Tue, 28 Jan 2025 08:03:04 +0000
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-385d7f19f20so2687613f8f.1
        for <linux-nvme@lists.infradead.org>; Tue, 28 Jan 2025 00:03:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738051380; x=1738656180;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=Okb8+g5HOnMcOzgk9wWHC9Hsy156FcRYyzub0o0k/6MenX4ghX6jhqltMeO0No6L6W
         XsXeEXSYB89eD5swyL/P8YSNdgKAcF/4yKS5drpnLlZ1EU5nx5fFaZITSRi7XRuff2pV
         +SqDX4kyN2u1DlKT6wPptcMpv5t0vZFmKFktwodLOBUGDq1iFD7H7pU1hUnp5dFq8CXL
         GVKKbrlg+inmrF4y9KvPsmolW0do4vwA2JF9xArHzQ4mU7X3/5NgGCfaXvBXWEIEWX5O
         vUAxPIK+HqPduop0eTMHghgeLdlLuCpBO+U0DO4XMjbI/g4BaFxBjKHC88mJ59CqFhnr
         9Qew==
X-Forwarded-Encrypted: i=1; AJvYcCUP9DSCXekOrFQJe0hiffrVALkmGEXzweHOeiizxkKlZn8EYS5mRWOeDyS1jnctzFJAYI0FZ70PmdeE@lists.infradead.org
X-Gm-Message-State: AOJu0Yw1lXUCeQlERhhWttO/Bb0gOrXo9PNTRqrNQOxBRYyiFpaqhRZ1
	ULNZSJFiazdaWKbF9UTDM3gIn5Qk2GYgB7vawMsyRNdpfIaJOVMgmYmKeQ==
X-Gm-Gg: ASbGncvqvD7ife+6jkmfGRFTDVWc/GYTNj2muUeSxCDJRKNXgNn9EI20/fh0MfRAYsg
	fyFvy+tKMgxWLqaVQn2yz+YeE7XegP1+UKdENlQirXf8IodAfZfGP/4TQebVYzsAHB1DAYoUqYe
	kdwAboxgurmhJBJ9/p6Udk28JYbd19dsn9qZeo1aZo/RZHfvcnX0Lx8DBS6LXEbea3qRDOMxeXM
	9mHJ4Xib9lzupZ9Q5+mJk3hz7NJZc6hw4Xsw/e72I5KY1YA5+G9Ne09BTpS4vbo9IGDKR/VLx0b
	KjNAmRh+RvTD02PDy+W8kkbFxL4L6PeqR4dCfAGFzdqe+JDrcCwz6xWaNw==
X-Google-Smtp-Source: AGHT+IHyy/ZuoOswK9vOeS5xAqSoMVwf9faq8ZkRvq4+zKpcP+csJtqzrSPgQ0wFoALq8ISsGDfbGQ==
X-Received: by 2002:a05:6000:2a9:b0:38a:2798:c3e0 with SMTP id ffacd0b85a97d-38bf57c9b83mr45297071f8f.54.1738051379760;
        Tue, 28 Jan 2025 00:02:59 -0800 (PST)
Received: from [10.50.4.206] (bzq-84-110-32-226.static-ip.bezeqint.net. [84.110.32.226])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38c2a1766d8sm13765126f8f.14.2025.01.28.00.02.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Jan 2025 00:02:59 -0800 (PST)
Message-ID: <32e92e79-1b77-42c9-afa0-2af0449916e6@grimberg.me>
Date: Tue, 28 Jan 2025 10:02:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] nvmet: the result field in nvmet_alloc_ctrl_args is
 little endian
To: Christoph Hellwig <hch@lst.de>, Chaitanya Kulkarni <kch@nvidia.com>,
 Keith Busch <kbusch@kernel.org>
Cc: Damien Le Moal <dlemoal@kernel.org>, linux-nvme@lists.infradead.org
References: <20250128075539.693870-1-hch@lst.de>
 <20250128075539.693870-2-hch@lst.de>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20250128075539.693870-2-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250128_000303_319365_D13F0632 
X-CRM114-Status: UNSURE (   5.37  )
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

