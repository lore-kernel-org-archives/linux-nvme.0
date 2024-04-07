Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C287CD1292
	for <linux-nvme@archiver.kernel.org>; Sun,  7 Apr 2024 19:57:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=012vVmX4y1dlDEqcvBzbB7jIyB
	6WM+ajrtnVIAUoI4j6mxABAdvYo5umUi9Mz1IlQXnhkXhiifF6XkiomE+gE3uPruriptcfR/cTr25
	OiI8vKO6fAOQfsPQ8P+qmrXGGjKvCUTtdY7/8NgqT/k23xQ1Cp0cwVssFANSr7X2pkWTDhkwXLLYb
	IFanu4dhMGZElz7P2IhsKro341x0/EN9kR/jYed7De1RO0p2421RAOEz3meZ0o7ljKneSV89ImfLY
	9Tt3Sv1ltxA+xKwFdOiM3TkcqFBkofdmYi1P1w+5JEP9NUfX396peVLNXk2Fp7tednFsVC+RX5FDl
	DYGRujhg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rtYeM-0000000DPXu-3xuN;
	Sun, 07 Apr 2024 19:57:58 +0000
Received: from mail-wr1-f50.google.com ([209.85.221.50])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rtYeJ-0000000DPX4-0ufc
	for linux-nvme@lists.infradead.org;
	Sun, 07 Apr 2024 19:57:57 +0000
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-34560201517so179238f8f.1
        for <linux-nvme@lists.infradead.org>; Sun, 07 Apr 2024 12:57:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712519874; x=1713124674;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=h1Xu0SfXUA7AHbn/u6aTEvyx/q0RpKnzW0L8srP+55kvk/yGoMZcO94slMzQtTogxi
         0Mkec1bwdt2+eAetjcyhMba/MeNt97PFqCnejt6W5rYBgQXTFTWiEc8H64yj6K5UfSfw
         XDFAJp1T/I+5VOC6N0Opyr2/PiIqBqBRXLXAIrz2lI0UKFR8W41W4IPf0FYwYGlct0iw
         w6kcgpLfJnkn4b6JTJVyGWwpYn0Ttyhh4lSeTFjNJ+HxIPqXNkkpYxYm51VgtCiCeDFu
         EGnPWTqOZwPTc8xDH+fzMTiSz3W6e2JRip3PF+j3Oseigw0wI4jplW7VGTaK2G9Yu6Wh
         hwqg==
X-Forwarded-Encrypted: i=1; AJvYcCXjqe30Kp1kucP73AnwDMS7OW9jrwaVpaqXevBWaGEwR0SsjHHEj+05aX/Atnqr4/5v/zYcZ777O3ru9mVu5W2AvAoDZzQNn/j+NEChnDs=
X-Gm-Message-State: AOJu0Yxap8FfTrGSfkZGmy7d34O9E/mTxFvbbW9pZZ9Ms4lrSB4kufS6
	xVh3zEN9NqlX17CYm89KOY2AiuOJ8MvlrmFe1DphrM963FiL1gZYcNpQ8gvY
X-Google-Smtp-Source: AGHT+IESHxPk2UJq0T53XKjcYwGVNzzDJK7gSMYR6Z4Aih6bZC0t9RC3M0sctkPo1YM/YktI4pScRg==
X-Received: by 2002:adf:e610:0:b0:343:be9e:67c4 with SMTP id p16-20020adfe610000000b00343be9e67c4mr4611708wrm.5.1712519873667;
        Sun, 07 Apr 2024 12:57:53 -0700 (PDT)
Received: from [10.100.102.74] (85.65.192.64.dynamic.barak-online.net. [85.65.192.64])
        by smtp.gmail.com with ESMTPSA id d2-20020adff842000000b00343c06d75bfsm7278585wrq.61.2024.04.07.12.57.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 07 Apr 2024 12:57:53 -0700 (PDT)
Message-ID: <f31d8929-b545-4661-b7c9-4e06ed17c17f@grimberg.me>
Date: Sun, 7 Apr 2024 22:57:52 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvmetcli: Support unique discovery NQN
To: Hannes Reinecke <hare@kernel.org>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, Chaitanya Kulkarni <kch@nvidia.com>,
 linux-nvme@lists.infradead.org
References: <20240403115156.22244-1-hare@kernel.org>
Content-Language: he-IL, en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240403115156.22244-1-hare@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240407_125756_236630_5C527CD6 
X-CRM114-Status: UNSURE (   4.48  )
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

