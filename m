Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89D6EC369D7
	for <linux-nvme@archiver.kernel.org>; Tue, 22 Apr 2025 13:03:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=eYWC7PFJVwmvyvfscPYIqedOWf
	uUKAQPcHAzs+M9g9Du4Y0X5rOtXF6AI2aGRWrAzMqIchvX5Z/YkP4ox6svudmRsyw9zxjgZl9guzb
	9hVioC5VeRsbtZY+OEP6NJcMKFXMbNUAqMrQi178K7yY0r5di4I8jEDMNv1z0zqjnFWoPWbEif7G7
	a+CHadrRgjWT4i+PVFvoAwSh2/AknfDu++jHwYi0Uy1mfw0FszODZcmKfmQFWsJuS4v7NQ9feOwwZ
	GQ6JehmNHjt2bs/h5LH0qrV8XnDRB0lidvcip7+NgoTQHdMw/B1hksynS+vaEIVpwcC6syoweU284
	yhJn2TuA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u7DI1-00000007Dy1-0I2a;
	Tue, 22 Apr 2025 13:03:53 +0000
Received: from mail-wr1-f48.google.com ([209.85.221.48])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u7CBU-000000071LG-2r6A
	for linux-nvme@lists.infradead.org;
	Tue, 22 Apr 2025 11:53:05 +0000
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-39149bccb69so1890508f8f.2
        for <linux-nvme@lists.infradead.org>; Tue, 22 Apr 2025 04:53:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745322783; x=1745927583;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=kXy/bVmXIefSwCHaQNTZXNUfli/dWoj24julN3d9szuONTyZ4xMEmw9PYrBbrK3yx9
         qy2Nm18B+t5NPmRFfOOif/dKjXQ/EBu5cY3ncrL7wpkNtuN5tsLJp/N5ZtuVnRXvRtt5
         Usca4O3a5qIfIFNDCKHSrxzC8Dx8WcMwtKcShrbpP+Oo4kZn8YazdeJL8GXa157KmW69
         I8Ru7havFj6vK24r/ExpCYgee5j41wIIKNX5JaZRBKLfqswzOkjlSZ9j21+fyn8lbOnM
         yoKelEjCUT4wWmVVM2aWiS0u1eIIsW6sI2VyGOQK5jz3oAiAhckSaeASYQ0QuYrHgfWM
         XqXA==
X-Forwarded-Encrypted: i=1; AJvYcCVMrD0pQkM4YrwGs/f+LSLWX0Sz4H/WKEi45bb1yqN5GSQ4MFdajpcLtmSshE0vLLQAIZmrT+apTNMf@lists.infradead.org
X-Gm-Message-State: AOJu0Yx0g+6cPnb5AIdM0g2qx+f45ZgTSBGmrF2MUqwIbvf5VoUJDyCq
	WX5IEsDSV+aDtmacetAWcAml3aS9AajO8Vv3jr2/Y5Mv3IBgrP/f
X-Gm-Gg: ASbGncsOWiTlWv22BOWObzJS3+TcmPBNjWG8/7PZRhS2yiQOMdhVK1GB6pFlJ2Lidle
	6QNOP5Wg23wYKpvJPyCZSgnfKo8d6dZQ8+j1bKJxLakOLZTq8a2XWh2emKU4WRpX07yFx81okzV
	X5rvDGEusEt/Kzg+3HZgkmbQdXN9CPDK3pWHBmXcvFNPq5N0F1PePQBrunJLwRvDW3aCOByyrgy
	A/yj3ikYaKlaMREdXgcAxBA7ctI0Qhk44Wn6PuSwPdHd2KZyaNYng11oVA8Ejuo4rVHhRsyNR8c
	JA4Q1O8JZ9xhCmgfxc4ePuYmnjdj97YniHQeq5euFpl4LuH/NMhu3m2zXLkEie4EUbvE1PixH3a
	oFZQhfCpYl5v6nk0Q
X-Google-Smtp-Source: AGHT+IFrtJnjZDJ7isBhkp9DcoyBgsJIXmFMhtpUF+YYRWB4IDpWHsvwXVXP2FGKmyJ5lfjPFMu9XA==
X-Received: by 2002:a05:6000:2405:b0:38f:4d20:4a17 with SMTP id ffacd0b85a97d-39efba3c738mr12196054f8f.13.1745322782779;
        Tue, 22 Apr 2025 04:53:02 -0700 (PDT)
Received: from [10.50.5.11] (bzq-84-110-32-226.static-ip.bezeqint.net. [84.110.32.226])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39efa4206fasm14773220f8f.2.2025.04.22.04.53.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Apr 2025 04:53:02 -0700 (PDT)
Message-ID: <89e5451b-ed06-498c-a93d-c4e946451a81@grimberg.me>
Date: Tue, 22 Apr 2025 14:53:01 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] configfs: Add CONFIGFS_ATTR_PERM helper
To: Richard Weinberger <richard@nod.at>, linux-nvme@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, a.hindborg@kernel.org, leitao@debian.org,
 kch@nvidia.com, hch@lst.de, upstream+nvme@sigma-star.at
References: <20250420104726.2963750-1-richard@nod.at>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20250420104726.2963750-1-richard@nod.at>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250422_045304_716965_C3E6F29C 
X-CRM114-Status: UNSURE (   5.47  )
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

