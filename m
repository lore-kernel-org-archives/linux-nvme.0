Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E18FC3601E
	for <linux-nvme@archiver.kernel.org>; Sun, 13 Apr 2025 22:35:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=Rj0zL/mEAylkB+x+Inr0nJ6KQ9
	p6jrVyS14LViLZG1kroaJgaJYxGs3Y68nVpEUAsYw6hLDBaB3LH5l5gTHc2HRbwRmC+sVPnlRzzOo
	je6eawvUWBhRmSepE/jBaeFVJt1mVC2eamsKAy0vgIXNW5QN6luzlj/tiOWTBhXsK5KH5YqWxJs29
	4vh+uDvR8KVeKys8Zu+dKeeOVKJB/S86zzG2jPn95dw8/S2Tb23V7tXYKfiWsRWu6I00rEgxeyNVb
	jrK9YA4qzpyhh8l7KIqF8ST+Nf2AUjlawzuuiaJ3jI5wGyfrSMvjodwTHdTnGk5tGC4J5sd6siHR9
	2vb8iumg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u45vO-00000000Fxm-23Gt;
	Sun, 13 Apr 2025 22:35:38 +0000
Received: from mail-ej1-f50.google.com ([209.85.218.50])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u45vM-00000000Fwh-0mZ4
	for linux-nvme@lists.infradead.org;
	Sun, 13 Apr 2025 22:35:37 +0000
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-abbb12bea54so738899366b.0
        for <linux-nvme@lists.infradead.org>; Sun, 13 Apr 2025 15:35:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744583734; x=1745188534;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=JADAk+5QSoTandfai+gVrnsczD6axk7ObYSJXA2/sSP7pOzcRGa3VJmNndJC57TKL2
         mkanGAiCRtls1IJjm1tdFhRWUUJC798r9ZfKa8LEMo7iT7m+HPDbuQZT9luqVzkfw3Ua
         ZTDMBu7c4HTKsuK0F60Q1Z+/eYFhjtZt9ThCzEBE6PvdMWEcTBRgofft0OO0bfAzPlpv
         WDxVppxjkIGrT6WGV5L62nLX75JsdimDwssh/JbeUIrzKv0NT7Ph5c4cdMz8raMJRFHN
         i7IKa7NjM0zCvY0w65Wxa4WnIvU0t9ac9RFT0DsY4UrF9Lh5F0f5sJWzyL3vsv/6ozaF
         AAAA==
X-Gm-Message-State: AOJu0YxkIsg2tQzR5+0FzU97b9G5fiplt867XK8KSLPMIrgvvTHEEUSp
	RMeABx4aFa4d46SkysFjlvsRdCuZ1cYW0pEurPA2cI7+asf9wVj7
X-Gm-Gg: ASbGncsLFMOYct+Fn0O/rxASg0QK8UDLS5EAcOMqPKK6+H78V8J+LWOPeeiEOFvKlkc
	LrPG5SIhNjMKhaaDP1FevFqnmYO+xUJeSpHiWMEiG44VN592pc65x46T6KMkijueAKTOcPhP22U
	oMZ4UqUgyfkfLEhQ1ZNICrvsI/P2eUO3AZgzXTEV2ABEDltnmMoPR6m0mIbv/3B7B0nfOwOCAin
	LVDwQqaPPkRev3fXISxgqPyQsWzS6YNBRGunyQci1y7bYwXTTPDpPIVFWLGLVrAopb2bTmg7X84
	dkuQPB1GVxpJ2MQSZR9pAPPVTTZsdYBefCmvqP84MR5LI02TocEQz54uFeWviNYVdL9UCtK5
X-Google-Smtp-Source: AGHT+IGoVVpTI4/XlK1SFFy8xTEt/qKGCnntZqcX+NDUOQpOgvv7L/T65tp94jg9yFaZ1tfX/Ym1cw==
X-Received: by 2002:a17:907:3f19:b0:ac4:76e:cdc1 with SMTP id a640c23a62f3a-acad349eb53mr765160566b.21.1744583734452;
        Sun, 13 Apr 2025 15:35:34 -0700 (PDT)
Received: from [10.10.9.121] (u-1j-178-175-199.4bone.mynet.it. [178.175.199.47])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-acaa1be9c0dsm809066366b.61.2025.04.13.15.35.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 13 Apr 2025 15:35:34 -0700 (PDT)
Message-ID: <98d8909b-9890-4152-98a7-5ea553cb2bb4@grimberg.me>
Date: Mon, 14 Apr 2025 01:35:33 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme: multipath: fix return value of nvme_available_path
To: Uday Shankar <ushankar@purestorage.com>, Keith Busch <kbusch@kernel.org>,
 Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 Hannes Reinecke <hare@kernel.org>
References: <20250404-nvme_type-v1-1-920053372832@purestorage.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20250404-nvme_type-v1-1-920053372832@purestorage.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250413_153536_294242_FCB43AE5 
X-CRM114-Status: UNSURE (   5.79  )
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

