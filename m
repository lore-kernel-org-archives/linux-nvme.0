Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6B5CC25B75
	for <linux-nvme@archiver.kernel.org>; Thu, 23 May 2024 16:18:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=elT8IKqD4GN0XukJ9QrqETQxe3+frogvmcBckZVbQB8=; b=vuRWOzUiuc3yBndJFfcQC1KJ4O
	nD/RklKFb3AU4d5GaIJmkNucuFZYliFP8+NhinDhBOeeqTSYp+/5Z8CLdkr5cgBI5Xuk4X2Kynfm+
	k04qqpTRdryMZKQQh5FP5+oiHL1VQhMcpsN4GW0DQf7Al0uUfviIqWAFgn51rBvd0EpH9MN1WVGpJ
	XX6ESdJaRxpHKgAP1NEJQsJO4CtK/SxtY8k0PVZiIbNpNf0FLjqZ7QnFjF6HJGGictAlrGDISETvY
	t0btNJpZN7sf3aEAWps0ThdzY/dhMqGK2EkUxYoxJN3eh6UV5evT+eXnpF/erdwxQ7AHQe+m1TWUo
	5glIDGeQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sAB9R-00000006lnW-1O0H;
	Thu, 23 May 2024 16:18:45 +0000
Received: from mail-il1-x12c.google.com ([2607:f8b0:4864:20::12c])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sAB9O-00000006lmz-0N63
	for linux-nvme@lists.infradead.org;
	Thu, 23 May 2024 16:18:43 +0000
Received: by mail-il1-x12c.google.com with SMTP id e9e14a558f8ab-37037d8047bso1696695ab.3
        for <linux-nvme@lists.infradead.org>; Thu, 23 May 2024 09:18:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1716481118; x=1717085918; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=elT8IKqD4GN0XukJ9QrqETQxe3+frogvmcBckZVbQB8=;
        b=qwa1et7HHcysqENwAQhnDdPLeD8RRRBQ+UpJVl8m52kJCrhXFnxev0520q1prJPv04
         zrbkMku2zMAKoCxC0yy30fKWVq2jwMfkqt1LBseM08OjH9WLC+Jr1wnrqLrnKCMrYMCR
         RaZXVRe/Ne5T3RAuGFnEMQZnQ+2pQJXiD1jW7bYe/3VuLJbZHGQc4WlSbx/eFWE1bqZ0
         PLeV277sqiRBNWdqe7b18T0JHj8SiasGBxF+Ynj9yK/r+ZFiWIh3V3p24ubDau8GIX/h
         ayxevq15IpQuVnLs+t5Xdeo58aseTnqwTkcB4F+3u1kq6Xcw5pyPD3vehVKTC+4FRTXP
         CjMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716481118; x=1717085918;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=elT8IKqD4GN0XukJ9QrqETQxe3+frogvmcBckZVbQB8=;
        b=F1HOESVRWUUmwwYAFhsAt22wNxMIlHdfprTS4ddgtFk139i68B5vVMDaloukvfsdNe
         hjJ1M2fU7+cNniscEeBTE0PqNFVcoSZ/+qXym+JVcOqCoU/ddrtugLn5KO/FJ6JFSW3G
         8BFLjdIe1g8yA4GX5fL5EoFiQleg0bmZspCLZbi8mir8VIA5qQjKyDamkQ7HTuBQaQag
         DS7UHNnGOqDXl3zVThXN0i53n9DqQfDh0m2Zh1JAIFmeUFCKzmJjWkQUyRb3R5f/kVoG
         C1XSIDn7UbH83B+bPZezwBoXJtCt/GPlcBKORp6I2636lDcVf5IWYuXMf00ToT3VDbcU
         w5cg==
X-Forwarded-Encrypted: i=1; AJvYcCXv8EDelCmnkGBqqfcZ9sbo8qYvvXPKca7bxHCzYdhbSaJULF0egSbp8TZwwoqFuBNP/2ns7Fj0J/IiPXB76TiW+L6QecOsSFjfVuInd1M=
X-Gm-Message-State: AOJu0Yy9WrSYq5WOG+9cDvRHLFS8A+e1nmk1koUtx6UavfJ5obZthnGM
	tRQ/u5Y3bS4VgmSSLXKknQzRpACAaxNrHYTLHaU81j4qiBBLxKn3PSYczIIRRF0=
X-Google-Smtp-Source: AGHT+IFwrptZ3UQ5L4364IPcpgCRs8fQyXYW2l1rX2FQJ0mmgIfa+n9SYKqYI28jpBYjCDwXT2idAQ==
X-Received: by 2002:a05:6602:3058:b0:7de:e04b:42c3 with SMTP id ca18e2360f4ac-7e34f8016bdmr537644939f.0.1716481118659;
        Thu, 23 May 2024 09:18:38 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-489376de185sm7984446173.150.2024.05.23.09.18.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 May 2024 09:18:38 -0700 (PDT)
Message-ID: <b2840f20-5cdf-4e24-94a8-4898753067e1@kernel.dk>
Date: Thu, 23 May 2024 10:18:36 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme: use srcu for namespace list reading
To: Keith Busch <kbusch@meta.com>, linux-nvme@lists.infradead.org,
 shinichiro.kawasaki@wdc.com, hch@lst.de, sagi@grimberg.me
Cc: Keith Busch <kbusch@kernel.org>
References: <20240523155107.3612088-1-kbusch@meta.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20240523155107.3612088-1-kbusch@meta.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240523_091842_163493_52A5402F 
X-CRM114-Status: UNSURE (   7.38  )
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

On 5/23/24 9:51 AM, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> Iterate the namespace lists without taking a lock fixes potential
> pcircular lockdep complaints.

Change itself looks fine to me from a quick glance, however this commit
message is lacking (quite a bit). Please include a link and some more
detail on this, and why the SRCU approach will fix it.

-- 
Jens Axboe



