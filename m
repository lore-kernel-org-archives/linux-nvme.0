Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF11FC4345F
	for <linux-nvme@archiver.kernel.org>; Thu, 18 Apr 2024 11:01:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=jtWhC4bpAbVim+elFMsLDdu2Y7
	CqzqtjeK86iXAzOHV4e8eKIC1nicRSB86e4eMXJKv1r/Ct+ZW7n7vgpRgxCadhIty0hnCz4jGoatz
	r2x8wuHXwvlweOFMQ6ocZ7hLZA21+jHAjWQzTlGKX4gVHDq021v9P7DnRMvT7GwKT9AaSzGy3c/Tk
	z2DVEiBgHDidE0XprRop2gPcREh2+fDewYXVpZA+HjV5KA6O42Wh1eYUSLHsuDug1qisEyPCMsP7h
	CiTVoFMJ6hsDY05fp6skzgqD5Tgi8A8bt3ZMvZhZnFQ1yUgwCbYvOm5IFlnY/rq9fAyH/qsYoMKAv
	zk2WLtWQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rxPWM-00000001uu3-1nKm;
	Thu, 18 Apr 2024 11:01:38 +0000
Received: from mail-lf1-f53.google.com ([209.85.167.53])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rxPWC-00000001uqJ-0Kxl
	for linux-nvme@lists.infradead.org;
	Thu, 18 Apr 2024 11:01:37 +0000
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-51a70f6b3e3so16311e87.0
        for <linux-nvme@lists.infradead.org>; Thu, 18 Apr 2024 04:01:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713438083; x=1714042883;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=uzMH7KQ1QlRxGr4Emo5SsENTdK/ntEcevrAE6IwK6NVqkaYVWQgMbDVwBpwd3vYTNn
         CDEejSzwWreKvoYKq7L6cPpnuxnvhgMnD6THR+1RXeV5SF1ZWdxYwkvKo8KdHNeYosXo
         7tAvpkaxtMLbqDBq2iyteLvO50BCxALfpMO6xYvIjQQxy+WH3V8+pYoX7r0sIXx7mQzk
         KdAeogdGEeAeBfUDsspiIwxAAM7Fl1eCm4rsFi0fe9B8H6gQMNPlYkYandajIJO6ZpqI
         475Jkj3AE0/aHrDygzSPSOYNfx3brouxvsoazqxvyH1Nw3mw5a1kPRxP6bMOwVq1GCaE
         yGHg==
X-Forwarded-Encrypted: i=1; AJvYcCV0wv+M+2XQb6HIZHXluj4bkU9r5ThME+vua9IQ/kmddoV8pKr0p2dxmFxJQz2Kpfday4WY07zkQc1h383ZDPCa8q2nVJCqVveI208zNLA=
X-Gm-Message-State: AOJu0YzHvtQ7m6gZZdXa5sbOuo5x+Lby9QIydPW0mbjcy3frNJKcNDBf
	Wu91bWvS5gO6GU9iyDgf7L1gEv+NGG7jHyTL5kWfrXBMvCV7Kmny5cU7SQks
X-Google-Smtp-Source: AGHT+IG4+EhsffqixZ7jsHOy428oFWW5FXBqDzxj5OeNjZoYiwO54hU0v/3Tk71kSdV4onuVqwK48Q==
X-Received: by 2002:a2e:81cf:0:b0:2d4:25c5:df1e with SMTP id s15-20020a2e81cf000000b002d425c5df1emr1341783ljg.5.1713438082423;
        Thu, 18 Apr 2024 04:01:22 -0700 (PDT)
Received: from [10.100.102.74] (85.65.192.64.dynamic.barak-online.net. [85.65.192.64])
        by smtp.gmail.com with ESMTPSA id d9-20020adfe2c9000000b00349a5b8eba6sm1555243wrj.34.2024.04.18.04.01.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Apr 2024 04:01:21 -0700 (PDT)
Message-ID: <9fe57bd1-68f3-4023-b99c-8f8f05f60e30@grimberg.me>
Date: Thu, 18 Apr 2024 14:01:20 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv3] nvme-tcp: strict pdu pacing to avoid send stalls on TLS
To: Hannes Reinecke <hare@kernel.org>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
References: <20240418103945.140664-1-hare@kernel.org>
Content-Language: he-IL, en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240418103945.140664-1-hare@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240418_040128_123600_B8E862F6 
X-CRM114-Status: UNSURE (   4.56  )
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

