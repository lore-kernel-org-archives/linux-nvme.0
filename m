Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 463EBC4345F
	for <linux-nvme@archiver.kernel.org>; Sun, 28 Apr 2024 08:17:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=UtGQ/fny8vUX8pLQDy/v3gLdE/
	lIa4wNcSkpWdW4gRfwbPveU3db748/3mzzfNtLdT6ChZ3YzVXLafs0WXiaAbqlbz5Id6DXJwb9ikc
	nCq5dbTSWAdm7dHjIxIVlpzfKQZMqAWtZzvJUwoF60NSpEj5Dyvz8teTukMm0h+jsRk7RBd3b8Q1c
	0lOKwmUze56cu+avMQOeH59mf8dg6KWbSbii6jxPZAOeUFdqI3EfsYlVuNoglpytj/m8cXrmuCEIx
	rWQ5Ef18UDup00m2Wnp3giOGucgnsS/4aK8Y0MGsL/are5GjZy9URXkvTbMrOo27Cv6eOCDMOh86A
	aDlxV9Wg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s0zik-0000000H8rz-0f90;
	Sun, 28 Apr 2024 08:17:14 +0000
Received: from mail-wr1-f49.google.com ([209.85.221.49])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s0zig-0000000H8qG-2WoZ
	for linux-nvme@lists.infradead.org;
	Sun, 28 Apr 2024 08:17:11 +0000
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-34a42d6e216so726925f8f.1
        for <linux-nvme@lists.infradead.org>; Sun, 28 Apr 2024 01:17:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714292225; x=1714897025;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=btfSSknIbyigSK1MWZ/IL7rpLd4UcbIOxmM5+1X9he4K3Jw1AaOpD6cg6sJPvYS46e
         URjCn0vXuMgjbn248B8swhPFXrlLMin0bB0bZr0Wz/7FgLpdHRCjDaUJltr9JDKtwh1a
         /KvFy0s5tlVPzXKkG3Jbb7+FZqukJeqrvmy729+5rlMvpvNum8HdZPZdqrhi+Kl6WI75
         F+Q95BxwQjhYpevTjZ8NDkytK07TNi8L3BhqPuB3deGEK7CK0OyuiuCClIgG6VCiu0/J
         mvqayrOsjA9bzRbDH5TSJo1QUDaYwVKqRK+Z5T12Lm3RrPwxnJ64GVOrztn4R7jhzktt
         x68g==
X-Gm-Message-State: AOJu0YxediaYDTt0WPxfvv21k+Fc/1Ui4zmf0CrR8PnuOKEIWN2K06iN
	ZX9VmgS1NWAzvSkuajB1buOT0mT8ZHltR0hLHnkdWfhSNmRZTZxZ
X-Google-Smtp-Source: AGHT+IF3Q02+T+M2vcXIafy7I5liqKR+VaCbyqKr01RliBlAnzKAZn46ZIqT8Dy1lCUoAyesviZhVw==
X-Received: by 2002:a05:600c:3c82:b0:41a:bc88:b84 with SMTP id bg2-20020a05600c3c8200b0041abc880b84mr5529525wmb.1.1714292224783;
        Sun, 28 Apr 2024 01:17:04 -0700 (PDT)
Received: from [10.100.102.74] (85.65.192.64.dynamic.barak-online.net. [85.65.192.64])
        by smtp.gmail.com with ESMTPSA id h9-20020a05600c350900b0041c120dd345sm1680858wmq.21.2024.04.28.01.17.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 28 Apr 2024 01:17:04 -0700 (PDT)
Message-ID: <9d655cfd-4b9e-4580-9f32-dc5a8274924b@grimberg.me>
Date: Sun, 28 Apr 2024 11:17:03 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme: cancel pending I/O if nvme controller is in
 terminal state
To: Nilay Shroff <nilay@linux.ibm.com>, kbusch@kernel.org
Cc: linux-nvme@lists.infradead.org, hch@lst.de, gjoyce@linux.ibm.com,
 axboe@fb.com, Srimannarayana Murthy Maram <msmurthy@imap.linux.ibm.com>
References: <20240425140303.1599437-1-nilay@linux.ibm.com>
Content-Language: he-IL, en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240425140303.1599437-1-nilay@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240428_011710_677598_19A09D0B 
X-CRM114-Status: UNSURE (   3.93  )
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

