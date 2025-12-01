Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 476AFD116F1
	for <linux-nvme@archiver.kernel.org>; Mon,  1 Dec 2025 17:46:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nVy6+2fcYjl62Zf/QXT/bBRIToNVOlZXNZF2mAJHtew=; b=FyP81IwgqBzhkcUlgT8hvddq4/
	+yRXYqOcQOW6bjxTf7PLu9uJe37+2JcKU10IVt5V7b/y9PGA7S1HCXhcaqcuwut0uY4WpVEEoRqO1
	pI3LHdC6lokKDxAQpHA/dfGWhqvpTqURgFIw2bAOYm4pD4eq+7si98o3MLDj1ev+UHaqDA58BqL4O
	+lwlGJ8DSFr66JhQfpyOwn7W7JCPnzN/cvUr9nHJvbJH5TTDyvtAvCVjN91eGURCIVvK/mMghXOOF
	gwpDjlGCWaxBkGxS0beSoH0zpH3GP4Qs2BWA170EyCwEDIxHit+YZRaLVLc2+iwX8TCOrMvWPPKGb
	pqekXC9Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vQ7yO-00000004NNP-0IYP;
	Mon, 01 Dec 2025 17:46:04 +0000
Received: from mail-wr1-f43.google.com ([209.85.221.43])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vQ7yL-00000004NN3-16c0
	for linux-nvme@lists.infradead.org;
	Mon, 01 Dec 2025 17:46:02 +0000
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-42b3669ca3dso1977708f8f.0
        for <linux-nvme@lists.infradead.org>; Mon, 01 Dec 2025 09:46:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764611159; x=1765215959;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nVy6+2fcYjl62Zf/QXT/bBRIToNVOlZXNZF2mAJHtew=;
        b=ZbWmg4YJphslBd9xCXx2qdPnshlpBZDlMXZmFU+LyWUURwh5l0H0wk5AtwAV/D7Mid
         04H/UXlCkSKj7eJ12+hu8JwMlQ1/2aCjwjUhKPt/fkoOaCbAySDJlnACZDESlWiuTw5o
         QdX5GXJ7BkTMmYa2kpvWrlLp3aiMkS6r6X5WJC6lFbzf4pbxikk0Qu5g4bDGPtF8Nmqj
         Ee24An8r20Kr+S7izT2fBVATG+rRj003BSerePJV31jEQYdq6b4DzwTkzuCwxMGLY+AZ
         nOUUKYDhdf/0X3roq+nQNovqaI6ZsdKaEnqR3fvwu7j6BQ20mZz58aVMc4kCa+QVpqwp
         bmIQ==
X-Forwarded-Encrypted: i=1; AJvYcCUk/s44ynm8LdraOcoroNGo7mAERcO77m6hg7jB/nvWc7oyO4IaVi0vQN922R5XTuf0hFnfLxPcfmha@lists.infradead.org
X-Gm-Message-State: AOJu0Yw4dJtP0Y/cUzH9PUPfkHjA3FoUu195NnX7w/3XCd7ZPQDH52gW
	g4ovfVjS9SIbvxVtYMFBQ7OCOkvTt0L4zBSzW6MVQWV5+6kbETOFVx7+
X-Gm-Gg: ASbGncsurmT9FahKZPUkPDJWG8jNwwzDDmMAFBxJQMvfDa458ACkxM6s+rSFHB1AVdJ
	DKkzmlG6UEeBz0jiuqfRZxjQzKnWkCFEZ2mG7pDewbxB3RCb6MjI9ijdlAVeQnW7+CYrebdB39l
	Dof9AHgvvLwJWl7ER+GyTFhHtKOaxTbVxwkyoGUYCT0NnoTlqRkRMV3IYHouaG2U6/HJ8Fk32if
	sBgVY/HUmwVKg0jbuHS1+8M0d0ldJ1ijKNAcDbioPQU2ub0HPT5naT+0cuv29GYWz8hBmZ0X8Q4
	PZu09zFEfcPid/QRZuXYtu5EXb1nNkUC6NxxaxA+pi2QrvS2PU8BycrCnBFD6CEoZbwMcjtAePM
	wVVSTbIkbQNn8Wyxdi53WCcUCBZ5y15tuA+kOxH8C830n3VpCv+TritrwO4quHSYmC0nfPUbvkI
	pkJdD0qH6j2auQRtLPD+v/uUsKUYuWQKmQPVlDu4VZC+jZSRxStlqp
X-Google-Smtp-Source: AGHT+IH26hFbl1UAmhmIwpIMigqZ4PfQbfJvKlx4RoDF+TEiTfBkYbQFSRKZAhEdwv1WJCOyBbk3fw==
X-Received: by 2002:a05:6000:2506:b0:42b:3455:e490 with SMTP id ffacd0b85a97d-42cc1cbd05cmr39492669f8f.14.1764611159218;
        Mon, 01 Dec 2025 09:45:59 -0800 (PST)
Received: from [10.50.4.190] (bzq-84-110-32-226.static-ip.bezeqint.net. [84.110.32.226])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42e1ca1a3f1sm27919679f8f.28.2025.12.01.09.45.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Dec 2025 09:45:58 -0800 (PST)
Message-ID: <d6f68341-a5c9-46ef-b295-a8b72ac69089@grimberg.me>
Date: Mon, 1 Dec 2025 19:45:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv2] nvme-tcp: Implement recvmsg() receive flow
To: Hannes Reinecke <hare@suse.de>, Hannes Reinecke <hare@kernel.org>,
 Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
References: <20251020085815.20657-1-hare@kernel.org>
 <42d6103c-3cbe-49e9-a8c3-6a6c652a60e7@grimberg.me>
 <809dc274-939a-436d-8293-37c6246ec3bf@suse.de>
 <aebb3431-2216-4ccf-88e8-ba499417892c@grimberg.me>
 <00a6f9f6-7850-4f85-a67f-09192484a381@suse.de>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <00a6f9f6-7850-4f85-a67f-09192484a381@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251201_094601_336444_4B527D37 
X-CRM114-Status: UNSURE (   8.56  )
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


>> I did not expect anyone to fiddle with RFS for softirq context. The main
>> benefit of softirq context RX (outside of latency reduction) is that it
>> makes io_work handle ONLY TX, which is probably somewhat more efficient.
>
> But we still could do that, right?
> We can easily split the current io_work() into two parts, the TX part 
> driven from queue_rq(), and the RX part driven from the data_ready()
> callback, no?

We could, but then we create yet another kthread context. The main thing 
that makes this appealing is running RX from soft-irq.

