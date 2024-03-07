Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BF8DC48BF6
	for <linux-nvme@archiver.kernel.org>; Thu,  7 Mar 2024 10:52:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ai4DJ6AGndcnwlIW8wS1nLN1aBbFXPEUpWC1dOIpAL8=; b=qmLuzSiD9+wRB7E+wLB1d5hKBT
	G4svJS08watX7kvAsZdLFN596YulfmZuCEbhvRTco04VmGhMuvQTk0YfpMxub+z/YYus8i3zVf3ME
	Zec/wrw0xkufmzU0Cv/8kvUl5ODWS5Olh/t+yTWMOhccwexBj4ImV0E/c77QQqJHZ6Cr+acQSzXg4
	u1XR8dzPDlGsTtolOl1Lo9uzShv0DEXK+McAlXfHJ3TOfKzUt7w0Rfmi5552/6aWkXB2rnp9eYLjH
	cIYVmiAgcXqz9nx9Qo4k3tDvzCQRhm677JJl2PcNsT/J4LdOLh/EGduavjMlAGFkQepfGKnIgGCV/
	E+B+NlOQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1riBMH-00000004ASF-3TFr;
	Thu, 07 Mar 2024 10:52:17 +0000
Received: from mail-lf1-f47.google.com ([209.85.167.47])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1riBMF-00000004ARi-0IQr
	for linux-nvme@lists.infradead.org;
	Thu, 07 Mar 2024 10:52:16 +0000
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-513056fe2b0so248622e87.0
        for <linux-nvme@lists.infradead.org>; Thu, 07 Mar 2024 02:52:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709808731; x=1710413531;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ai4DJ6AGndcnwlIW8wS1nLN1aBbFXPEUpWC1dOIpAL8=;
        b=FfP9fkQdIpNnPDObos2vXqj2KoHndrsbQLt4kNUYCtwfCowZXv/SmilHwRz/gQKv5s
         p9pwRtLAw69ygnschJdi/gulCYhVYDDqY1/S1cCjBcILyL/oSuKqVDLxjw3IQYWPlvbb
         YHFixBL8HMOaz3KxIfcrKBRIHiOgXk6yDuQfNKs5EA9rcDqIHJrHyOrgL+VZWPIKcRWm
         wwOYeH2JzsmM42NfRljFKS1k/V2YorxUsjpZAmY4+jGIJrtiRdcZlMXRRBtxk+TKNw9w
         nvrBdikLCO8bACA9y8pYNj79Olgu2mTxydV8iA0Z5QjUA5gE0+bNmFoMpCVlJMPUttEk
         R1jQ==
X-Forwarded-Encrypted: i=1; AJvYcCXiZlCtFEZ3DFZJ1P2mlOZn+5/529lKusxsNdDu5J5lkEF24gHfRPsiA4/AnYC2ol6II/29BfITmzogwk+5ROLqXTLAKUzlMzGtBSbVwN8=
X-Gm-Message-State: AOJu0YyquTvJjVqMB4dv0hwSn+c94XPZVqGgJkPRGK4DDz8CLnXf2RXe
	xRQTfoThfwd5huicRrNi0vD0+1P8yGc+QCuxW0dNi6bF2TYGPOoX
X-Google-Smtp-Source: AGHT+IFiYiwuCGpePQNtgqFKvioYjagQoMhtdyZBlDdJ5eKFV6fMjALIt8gJKn6yYy+nA9TkDXLM2A==
X-Received: by 2002:ac2:491c:0:b0:513:5877:f209 with SMTP id n28-20020ac2491c000000b005135877f209mr3401145lfi.2.1709808731146;
        Thu, 07 Mar 2024 02:52:11 -0800 (PST)
Received: from [10.100.102.74] (46-117-80-176.bb.netvision.net.il. [46.117.80.176])
        by smtp.gmail.com with ESMTPSA id fa18-20020a05600c519200b004130c1dc29csm2246778wmb.22.2024.03.07.02.52.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Mar 2024 02:52:10 -0800 (PST)
Message-ID: <8655ae60-d0b7-4516-9006-b9a017760135@grimberg.me>
Date: Thu, 7 Mar 2024 12:52:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/13] nvme-fabrics: authentication errors are not
 retryable
Content-Language: en-US
To: hare@kernel.org, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
 Hannes Reinecke <hare@suse.de>
References: <20240127093058.15699-1-hare@kernel.org>
 <20240127093058.15699-9-hare@kernel.org>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240127093058.15699-9-hare@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240307_025215_142620_133E5BD3 
X-CRM114-Status: UNSURE (   7.64  )
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



On 27/01/2024 11:30, hare@kernel.org wrote:
> From: Hannes Reinecke <hare@suse.de>
>
> Whenever authentication failed the error is non-retryable as the
> authentication solely depends on the passed parameters, which do
> not change during retry.

Does this directly relate to secure concatenation? because if it isn't 
we should
drop it from here.

