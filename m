Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78BB8EE0AE0
	for <linux-nvme@archiver.kernel.org>; Sat,  7 Feb 2026 14:12:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=04G7xnh7cZLBrOkHFT5OTX3jZO
	VEuBrlQAtm7q1RFRDmoMLnRRDjrSM09CdmOfF20MwhjHaRGohdTcL2BZcMIUT8rgcQguKA9TPSBKv
	0/CFZQzC4uK+rV3dQSh3YR3z2Ly6vw4bVarmpi1ICUCDnEbma/FUbfVaYdIPjjLvP8MtL0HskUOIO
	1PtkIdo/8qNCQQI06aSCHoVuKmhxmytqI0S6IGYPE564jWT+gMBdLxtJdSt982MxkxJtM/xGWU1IF
	3ER+I4FXQRP9QId7Yb9KKIPXfaW+iLfOEH/FbhidCOpDe3YMuiCCkzcYfzMLliDurXEEZQ4piBTyO
	43pVrVIw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1voj3G-0000000CWTm-1Kj6;
	Sat, 07 Feb 2026 14:12:46 +0000
Received: from mail-wm1-f45.google.com ([209.85.128.45])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1voj3E-0000000CWSu-2y5R
	for linux-nvme@lists.infradead.org;
	Sat, 07 Feb 2026 14:12:45 +0000
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4806e0f6b69so23382205e9.3
        for <linux-nvme@lists.infradead.org>; Sat, 07 Feb 2026 06:12:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770473563; x=1771078363;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=vqHZEMRYMYT4o1PpRpsUOYjjUHChMKqJ7ZazUDZ5MG/3ANQOe/6uvcg3+nvKAqsFiF
         0DzM0AQ1dWWlWA+fnEyyETlvn028Ibna/eWOIlmO5O0rNLIBnSW6xnCyqJCVCme1yF+r
         A2BXIDu5Fgl1+UIy5tZEurzt+2vXlG7D/GMBOLyIIt7I02NN3VZMSQEFGx14Hd2EHvEN
         uLAepmJnY0cYj8pyuzqjbNtYbDLM89zGaZJtgWFLVM5kK/nZoX7dYmT+wTJG0OYC9C+W
         zdcilPWcRr0z89NjnQi3QnEXrddPFZEcU2Q3poBFwSlH4tEJg+3hHDZ6sfLLb85kJmzk
         /5oA==
X-Forwarded-Encrypted: i=1; AJvYcCWOlhs8dJoHoEoU6DrvMNqdutLESNuOxKe90RXJv1XkHlYcKOZHXGlBvHtv9Jy/xY44jIzwlW5Km8rC@lists.infradead.org
X-Gm-Message-State: AOJu0YzgePwwAAodBulWjPCOLBeupxqycoXTCJ7B7z+Ahi85zFvC5Yp7
	RquXqCFTKT+VQZ7bSm2+ns+aA1GWtsi2pkzPHhXOdWdRFwF8McsyAG66
X-Gm-Gg: AZuq6aJFx7zCuSKXxrMnz1ZbfzcFKL3dws6oD/MlX4XRMfSJpxC2v5Y1zxjb5Sc9bAs
	0xVlACBjYsaSIvDbOr0Lb13IZ82isLeqHSB9+5R3NQYz5NMM87D84eBtx6hvaSsB4ps4CE9ajts
	Z/Ef2D6NFhKIFojbDARp2tpiHMY9hUIoVAfkFhv7v2nyuxoInjMXPqsWAZR1c4Hj+O7cU1mQUT/
	TVzNHefFCLho3ktvdPSvlbcrHK5OGZqU45XJB/iu8npe+tBRSnDYMIHc8DhhLWiQ3rp2OE4zMUp
	Dp1Sx1q0En8gBVIB1woPkzxLN4SZ66Fdk9v0LHlxcpl+jyUsfsvPf32UmYiISb817vilo26Iw9K
	1She94anktx/8TexJ6rbJBrUeG5lfvPHic8I7rwj0MPy7VwSvFZkWOK/3dnU+7OdttL0jtyndV7
	R/RpLNtVVCTk8AEKWsg525yuTMOhWKKjRbKvV/AfXhNlA=
X-Received: by 2002:a05:600c:c16b:b0:480:2521:4d92 with SMTP id 5b1f17b1804b1-48320214793mr87434085e9.24.1770473562604;
        Sat, 07 Feb 2026 06:12:42 -0800 (PST)
Received: from [10.100.102.74] (89-138-75-89.bb.netvision.net.il. [89.138.75.89])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-436296b2d43sm13097369f8f.8.2026.02.07.06.12.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 07 Feb 2026 06:12:42 -0800 (PST)
Message-ID: <644c49fd-f67d-4b9f-a78a-ed0b32a13ec5@grimberg.me>
Date: Sat, 7 Feb 2026 16:12:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 05/14] nvmet: Send an AEN on CCR completion
To: Mohamed Khalfella <mkhalfella@purestorage.com>,
 Justin Tee <justin.tee@broadcom.com>,
 Naresh Gottumukkala <nareshgottumukkala83@gmail.com>,
 Paul Ely <paul.ely@broadcom.com>, Chaitanya Kulkarni <kch@nvidia.com>,
 Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
 Keith Busch <kbusch@kernel.org>
Cc: Aaron Dailey <adailey@purestorage.com>,
 Randy Jennings <randyj@purestorage.com>,
 Dhaval Giani <dgiani@purestorage.com>, Hannes Reinecke <hare@suse.de>,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20260130223531.2478849-1-mkhalfella@purestorage.com>
 <20260130223531.2478849-6-mkhalfella@purestorage.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20260130223531.2478849-6-mkhalfella@purestorage.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260207_061244_741305_B610ACC4 
X-CRM114-Status: UNSURE (   4.85  )
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

