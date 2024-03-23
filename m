Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDE32C54E58
	for <linux-nvme@archiver.kernel.org>; Sat, 23 Mar 2024 20:27:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=Lv0Va2yUElVJLJyIJmS7IfjtFN
	Y0OO5a5Aq7WrC0m8AC3huMDBg3p3jYA1Rs1cQDYaQReIjRAMy4jncERcSx9fBtPUbb0CCm4avgE7/
	8Y63webFgZm6iwjxNqcT3iCr7FkGXO2kyPLnn6xIyb6nTYLrQ1EOTIUa0hY9sOpBOKBVxnBPWdIjf
	Hpoq9zxVFfBYWwPT37wz9amM8QuPUpA2DQrt+q6Jkz6Ntln9uZgBNXQejVyPwKK/GYGg+wbhdCvg+
	flMjzPxEqUYeUIx8wguPA0hoNL0JgkIIfXmdyvhVzRRAZ+Dg1O6AfKNlYmVsFcPxDfPJ+Roym+l8S
	9qAEfwGw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1ro7y4-0000000B6ur-0sd8;
	Sat, 23 Mar 2024 20:27:52 +0000
Received: from mail-wr1-f53.google.com ([209.85.221.53])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1ro7y0-0000000B6to-2imO
	for linux-nvme@lists.infradead.org;
	Sat, 23 Mar 2024 20:27:49 +0000
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-33ed7eb88d9so881403f8f.0
        for <linux-nvme@lists.infradead.org>; Sat, 23 Mar 2024 13:27:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711225666; x=1711830466;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=SWUxzdsC13/UEuJTVXvco8vA7zrwaJXjoPv8H5CSzm2BnxrpwTT8pg/rBcdofPDiDp
         JTmGP8bRg4uEg7iomB7oleSVqw6OH5ZrtFTQRyousw9EsPCFZpxmJzBAoFzPsrI/6Hah
         k6p5eTWiDjuQbYSJXHGJDokhgqM2qx1j3hjERpg6LH0V33CykOM3TgxXiCeeMXvxhvtl
         syVj4JJmOUoTDgckqHHXnHTrBGZ3F6oo9h0qEkbRD82VahSNJtXGD9mKjhv99A43JrVD
         aJaMwODxNE2LeQCWkm2XJik3Wr1Yj6yfEUKUeZlG01vMcYT9J8gZA0slCD/Zgu6nOwcF
         OXjA==
X-Forwarded-Encrypted: i=1; AJvYcCU2z3KtlOCMXo+ecrqVHl0mPTlw1bQqZ0QF6jDQmoRP+8L2z6VfFmoEpi/rC2sXk9EGP99nLnLFNTES5KfTIYiL732OmM8xrcgq6dKSYHI=
X-Gm-Message-State: AOJu0YwJAm9ByqR4zTE+6fyzc2yxPpI2LBWO1sDRtxRJZjG1z2/dQfds
	Nv3ntodcaQQ4H2XOpCrVC8uHaFp7VihzZEEZN0hyH30OT0dLv5NG
X-Google-Smtp-Source: AGHT+IEzcNdgIZ28THF7/o7NMnNIUtllbXVr/P+rZNYMqTpgJUINAbkBVFERr7r+F4Bm/gWHH/T2Zg==
X-Received: by 2002:a5d:6147:0:b0:33e:cf2f:b0 with SMTP id y7-20020a5d6147000000b0033ecf2f00b0mr1880854wrt.3.1711225666248;
        Sat, 23 Mar 2024 13:27:46 -0700 (PDT)
Received: from [10.100.102.74] (46-117-80-176.bb.netvision.net.il. [46.117.80.176])
        by smtp.gmail.com with ESMTPSA id ay34-20020a05600c1e2200b0041480c36bc6sm2714888wmb.27.2024.03.23.13.27.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 23 Mar 2024 13:27:46 -0700 (PDT)
Message-ID: <87cddb93-6a2b-4617-b7d5-8f6d59d45563@grimberg.me>
Date: Sat, 23 Mar 2024 22:27:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/8] nvmet-tcp: implement host_traddr()
Content-Language: he-IL, en-US
To: Hannes Reinecke <hare@kernel.org>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
References: <20240322070333.3820-1-hare@kernel.org>
 <20240322070333.3820-4-hare@kernel.org>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240322070333.3820-4-hare@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240323_132748_701299_06D8A1EF 
X-CRM114-Status: UNSURE (   5.12  )
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

