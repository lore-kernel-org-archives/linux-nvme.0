Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C6FBC3ABA9
	for <linux-nvme@archiver.kernel.org>; Tue, 29 Apr 2025 09:12:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=oNhUqy9pUFUz0We+VB/+QQeNNc
	6QpCyKaiHClkz0yFLn+qmYi1vuXyjjJWrb4X9NAO32ydLQnNMF43DZXdRCxfoCG5irTzetLZCQNN3
	TLZ5tjI/xIk0NTLok29XZ1ngARLitkEgH8LTq6AIGhFKNSzHPwPNhAZqbVKxu911tctVwJjp/O2w9
	DB2InQFCeKPcCSFBR3HgUPxQByH6QDU9JljkVjEoUpwSndnMcn97AMPLyTT+2BaEILT2/6IMCUFne
	qBBO+px77Id0vDeFbPSeEaCCMFy4aYif6EJvzgfuagTo+T2mHVo20A1b1SLUdf8JBRecFofxctCgM
	5qB22rkA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u9h15-000000094rj-3F7t;
	Tue, 29 Apr 2025 09:12:39 +0000
Received: from mail-wm1-f50.google.com ([209.85.128.50])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u9h12-000000094rF-49W2
	for linux-nvme@lists.infradead.org;
	Tue, 29 Apr 2025 09:12:38 +0000
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-43edecbfb46so36231445e9.0
        for <linux-nvme@lists.infradead.org>; Tue, 29 Apr 2025 02:12:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745917955; x=1746522755;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=hYVtbC/muP9LBRls9yFZipDGvtEjM9chnWwdK5PNda0cHn3/qqUiok3JTeCd5OzMvB
         avVHnMH6IinaZf3H1bFurkwaMQUqchcvxS9fKLKZ9B509TcX1SF34RmDu7oQeHGPiU4a
         6JgbSznD8vbmthhOP4W6plIVDlr4tB8cz+DCXqOGnQD1HsPO4oNAeTwQ29WKcXY92kIm
         x1Trjqkq3t6BiqxExCtBF5UTmDunveMOehubfWcm517gW1FdIB4eJaIx59/6cHGJ3dRx
         JEL+NURqyktESuq+34BA4K9gvNR4G4bEllFgpZVK5py2TveovsG1RJ21p4pEIhdUoBbx
         GAQA==
X-Forwarded-Encrypted: i=1; AJvYcCXubUaAUxa1XWO7wk5KE2vZoln38v2CNoh3SqRTU3vqqGuvHOp5Ws0T/6eT9emvh6WORv4cQ/dNTx9p@lists.infradead.org
X-Gm-Message-State: AOJu0Yz6Sh+U6wJ+iaImcHIurQGUseoQsImrVojH9T1O8392CaShRNkH
	Tk6VRUJ3KsAaYLg/+LLrAmETFvlWS+zPTsNulJAmz72kZ2Ix1rC0aIMTww==
X-Gm-Gg: ASbGnctSi8irjAq/PfwIdzxTPuiBX9AHddWWnGCB/7tdovlqds4B/vMCUXDbFyvtcNR
	XhfTT0Bgqqc5LuQllIX4/L/37kB2e7RxaEfY2qa7LjEnw+yskgtxfB4RGr207im+nQN/6XgasI9
	RgT2TwDHOJ093Lf7bhbyNY3QA7RGDcF5QDGPL4gbK/QJowkqcUbL8hwbxrpvqO5o7KzMt3SWqhP
	DC9W6Sf2GSfwVW9Ws6dxIZa5FNMrPNE1mJU8dGtkdwMTbKXjMiiFhYxPP8zIOMf1F7v+hNzWzJM
	ceGdBs3t2pcYpHAtmAATmT02GCMZrL0E0N4/MJnS9Rp3YcSa0WCLVqqwflyO5GoFeNdtK9DtZcQ
	YqCvqbQ==
X-Google-Smtp-Source: AGHT+IHTkTKNNCs9aU28dgrCFeEpc0vAzD+qWO4te90pzrnLPd1oxmTiVjEiCXQTRR8do1MDVrUKXQ==
X-Received: by 2002:a05:600c:1d8c:b0:43c:f629:66f4 with SMTP id 5b1f17b1804b1-440ab65d133mr114225955e9.0.1745917955138;
        Tue, 29 Apr 2025 02:12:35 -0700 (PDT)
Received: from [10.50.5.11] (bzq-84-110-32-226.static-ip.bezeqint.net. [84.110.32.226])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a073ca511asm13079086f8f.26.2025.04.29.02.12.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Apr 2025 02:12:34 -0700 (PDT)
Message-ID: <a745fbe7-c562-4c95-bdbf-3d7e7fb2fad2@grimberg.me>
Date: Tue, 29 Apr 2025 12:12:33 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] nvme-tcp: sanitize request list handling
To: Hannes Reinecke <hare@kernel.org>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
References: <20250429081739.44820-1-hare@kernel.org>
 <20250429081739.44820-2-hare@kernel.org>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20250429081739.44820-2-hare@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250429_021237_030924_EF22A160 
X-CRM114-Status: UNSURE (   5.60  )
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

