Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23546C369D1
	for <linux-nvme@archiver.kernel.org>; Fri, 25 Apr 2025 21:53:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=MVVbo4ROS446ViNmU/AD2hQGyqQ0dbBdWmkbwu91I+0=; b=joFzyp5kkI+ABoZYWSLcDm7MHA
	5HB8dCwZlGzYmecG43vWOmwBXw5ID7GYsOwEdVaI49G3jOgXyXyWPZk2h7O2Cra79Jjsrz0YgJg/H
	knvAXbWEX0wB7/U8+lnSOfxiW+EA4jZaL1HYqHNrQ/C7qME9jV5vZHR0vMTmIa/D5O8WkMMTZIZGj
	F/sMCJcDgoL7RXSYKh/pN765etYA8Rtf9Tp+zOogpNmArGL1eXbI9kekrByXBRdy/orqOMMI+eXxe
	gDlEg1GDPiRr7cUesAQocqov1EjvJqIPaW5zv3F/EeDo/7DxtLqmgXohMn7uXx/GFkQ5T6wwvtIuj
	7W1urPPw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u8QzN-00000000ybI-2Jkl;
	Fri, 25 Apr 2025 21:53:41 +0000
Received: from mail-wm1-f43.google.com ([209.85.128.43])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u8QzG-00000000yY1-0lYs
	for linux-nvme@lists.infradead.org;
	Fri, 25 Apr 2025 21:53:35 +0000
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-43d0782d787so17327265e9.0
        for <linux-nvme@lists.infradead.org>; Fri, 25 Apr 2025 14:53:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745618012; x=1746222812;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MVVbo4ROS446ViNmU/AD2hQGyqQ0dbBdWmkbwu91I+0=;
        b=UPuy7QwLasncfCJ/SK8lzuho9OQQagL9Podz7d70g/PrDcuQwLN7mZ0i8dDXixRIsV
         PgYpXeCIGBXOEBPZaFA72h3BtjB+PkGlKUfc3abjmy8/0zW1H/UFdcomhrNNYA1+9keT
         9gsJixkPPKFwHy90XAkZy3LqcKlDs+2WcLHp9OKHJ+Y40DtdS9xJbz4ubjHHjajfcOBj
         uAqxNw457VYiWJoWfSclZFMdT3v7h1CoK8I8DT+YZxai7tI4vW4XKURd4El3D2LThTUS
         QLvuiiFASEyI6Qd3QKYakhIuMkW2QlJ7a4CYV0jYx3Jov10iJ3sFzpMlR4vVgX4LR8CT
         KsYQ==
X-Forwarded-Encrypted: i=1; AJvYcCVX7OFMjdCDYoNCWlTKgbikDGH/Bd2oZjQ204Txz57DTPSXhtPov+XG2zWPK7eBuTMip339zwWMcgMr@lists.infradead.org
X-Gm-Message-State: AOJu0YzPSk6f/IW1Yc6hdLWjEW9eOgPrs7iB9VvwMtDeXNEOk+9EEH0Q
	+BB6IRyjsZ3a+w5cH+Bk3/b5o2zn9fkWyZukuyvm7UfBXtJewp0S
X-Gm-Gg: ASbGncvd75E+358ZVL30ykhjUJdQ0r9X7oOUW7T+EIOPD1MAyIIJ1/v9ruMCXEGDJ2G
	1WabM9nuqxo5BHHLwKIjYte3Sly3N9GNffloUahNLe5lnmhJsneIkaKtk+Z2dapNjHYt5Y+hRvw
	vvQ505xMinvImSV9oBmc+bG7ouhfeEaeiNwJnBqO/JSbjPT9sfDp3yv4BJJC63ajRIWY9pRuKCm
	qsbEf1+E8J+YXV3Db6ki943BE+JoFaGgHGQpDdcYCT8ikegE8aBN9iJ3A0CIc+5dL6YVwg1arBm
	6/DPaPHiuRYgQ6oYlJnn25vXc+eD/FETL21SlQRE
X-Google-Smtp-Source: AGHT+IGSD+ivcGxPzjE4UnDxqHkDSfK+l5KI6zUPiQ4sOkdq5u51vTEljeieRQYpKNmD6n+VeRTiMQ==
X-Received: by 2002:a05:600c:1e1c:b0:440:6a1a:d89f with SMTP id 5b1f17b1804b1-440a64c14bdmr35479365e9.4.1745618012216;
        Fri, 25 Apr 2025 14:53:32 -0700 (PDT)
Received: from [10.100.102.74] ([95.35.174.203])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4409d2ad112sm69015145e9.24.2025.04.25.14.53.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Apr 2025 14:53:31 -0700 (PDT)
Message-ID: <a306a2b0-bd7c-4376-8c26-738b5c7c9807@grimberg.me>
Date: Sat, 26 Apr 2025 00:53:30 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/1] nvme-tcp: wait socket wmem to drain in queue stop
To: Michael Liang <mliang@purestorage.com>, Keith Busch <kbusch@kernel.org>,
 Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>
Cc: Mohamed Khalfella <mkhalfella@purestorage.com>,
 Randy Jennings <randyj@purestorage.com>, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20250424161750.jwbdohybrqftuioe@purestorage.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20250424161750.jwbdohybrqftuioe@purestorage.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250425_145334_218105_B3E782CF 
X-CRM114-Status: GOOD (  18.07  )
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

Given that this is a fix - lets rename the patch title to say that.

nvme-tcp: fix possible data corruption caused by premature queue removal 
and I/O failover


On 24/04/2025 19:17, Michael Liang wrote:
> This patch addresses a data corruption issue observed in nvme-tcp during
> testing.
>
> Issue description:
> In an NVMe native multipath setup, when an I/O timeout occurs, all inflight
> I/Os are canceled almost immediately after the kernel socket is shut down.
> These canceled I/Os are reported as host path errors, triggering a failover
> that succeeds on a different path.
>
> However, at this point, the original I/O may still be outstanding in the
> host's network transmission path (e.g., the NIC’s TX queue). From the
> user-space app's perspective, the buffer associated with the I/O is considered
> completed since they're acked on the different path and may be reused for new
> I/O requests.
>
> Because nvme-tcp enables zero-copy by default in the transmission path,
> this can lead to corrupted data being sent to the original target, ultimately
> causing data corruption.
>
> We can reproduce this data corruption by injecting delay on one path and
> triggering i/o timeout.
>
> To prevent this issue, this change ensures that all inflight transmissions are
> fully completed from host's perspective before returning from queue
> stop. To handle concurrent I/O timeout from multiple namespaces under
> the same controller, always wait in queue stop regardless of queue's state.
>
> This aligns with the behavior of queue stopping in other NVMe fabric transports.

We need a "Fixes: " tag, even if it goes all the way to day-0...

>
> Reviewed-by: Mohamed Khalfella <mkhalfella@purestorage.com>
> Reviewed-by: Randy Jennings <randyj@purestorage.com>
> Signed-off-by: Michael Liang <mliang@purestorage.com>

Please resend, but you can add to your v4
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

