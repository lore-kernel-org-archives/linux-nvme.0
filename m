Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7745C4167B
	for <linux-nvme@archiver.kernel.org>; Mon,  4 Dec 2023 08:24:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=t2X6KQhfwdeu2hTLW8xb0/fAWb
	9eFpmFL+yWASuqoGOhb9CF3L2PnZOiKBiWxXXW0u7M4BMC0md7p2Ge8q0mb2qHK8BU5kin07p3nw0
	qjx4R5l5OR4Y6k26APJCiABOMM0VU6u4FqkDGnj4MoSpiBhwT6hLgWej6zomDrMqCQxd/luzivpi/
	bYOrnRjaeaIj9UDPBISOkModzx33JIr92D+YgNRWyTqLLYV1eau6P1S4Q5ZcomzS0xmu3lCB5kijL
	0TaUZ/AhGcYXkgN2FJGkOxl97KoFaN6aNyo9hJJBU9Nmag+o2wXuHRn/Icoj+FZ6IQGL0/IyxoVlT
	aZI3AArA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rA4Fm-003G9n-0B;
	Mon, 04 Dec 2023 08:24:34 +0000
Received: from mail-wr1-f48.google.com ([209.85.221.48])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rA4Fj-003G8N-28
	for linux-nvme@lists.infradead.org;
	Mon, 04 Dec 2023 08:24:32 +0000
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3332e285ebcso762346f8f.1
        for <linux-nvme@lists.infradead.org>; Mon, 04 Dec 2023 00:24:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701678270; x=1702283070;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=tLaijJvKZ3F8BXS3PqDSZZuV7V9BgewcqYDssEN5ggAitr4FZjGbUqjoaYle49MxVY
         FRnmMGTEwLOdcuI2/yBT4hOHPJzJdMdLBlrhOx/HlROynYv/ZGMSbRAdSChNDUaUuJ8P
         2Kk1STpKdkYRcBLa39LdngrmBzyQvPQPH1AioZ9FuR7yBpcCfP8/PDaaFVNnUXmx8pu5
         NQua20rHT0oHscfkc6XY9mhB6lofJCPf8ypuL+9ReeaI37JCbonBd2p2kSbnfcZVVv2D
         /p0AxJJmq8U3XzqAiOUo8V9tbAi02/u/qqqJmlK+4HYRy3NxCnKSOY+o978pJlr9GuDz
         oRVA==
X-Gm-Message-State: AOJu0Yy5c74RvlSIsYe40oLZ6ksQCgp30wiAdXPdJvuLR+RwSvXP2LTz
	LmN3qXn0LRtb3ljmG6+efkc=
X-Google-Smtp-Source: AGHT+IFPoap0FiqL77fdMQ+O4HNnQ3ztzw/OXEzUwLPLWtEDkhKxNwOVAI/+Lf2UJS1p8fRlS92/HA==
X-Received: by 2002:a5d:6d8c:0:b0:333:4ba7:bcca with SMTP id l12-20020a5d6d8c000000b003334ba7bccamr915823wrs.5.1701678269542;
        Mon, 04 Dec 2023 00:24:29 -0800 (PST)
Received: from [192.168.64.177] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id a4-20020a056000050400b003334675634bsm3060326wrf.29.2023.12.04.00.24.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Dec 2023 00:24:28 -0800 (PST)
Message-ID: <dcf08a56-3df4-4f9c-85b3-6f1328293180@grimberg.me>
Date: Mon, 4 Dec 2023 10:24:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v2 1/3] nvme: lookup ctrl from request instead from
 namespace
Content-Language: en-US
To: Daniel Wagner <dwagner@suse.de>, linux-nvme@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, Keith Busch <kbusch@kernel.org>,
 Christoph Hellwig <hch@lst.de>, Hannes Reinecke <hare@suse.de>
References: <20231201092735.28592-1-dwagner@suse.de>
 <20231201092735.28592-2-dwagner@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20231201092735.28592-2-dwagner@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231204_002431_699534_F22971C1 
X-CRM114-Status: UNSURE (   5.73  )
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

