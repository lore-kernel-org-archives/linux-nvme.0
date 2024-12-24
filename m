Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21C0EE77188
	for <linux-nvme@archiver.kernel.org>; Tue, 24 Dec 2024 11:45:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=MpkjjpubUTNXKlsNoMTtMyrLqb
	bpynnD/ZrgCmf7/jB8Df2FA4DtNwxvcfGpsDqfB2uz8ma00OxGqoGUy9DzYu6Lw9oqYSPvVYP34Uo
	n/6/FKIzxVfno/vZS7172Sbipfce7sxJEmGIRWXEH00UEqHaU+5qy176NzfvdC5YDKz/VzMD92wV3
	yFEQINqSmyWLoshJufvKRGqFmkaLBKPxxjWf0EMcNYbya0BcueBS/Nod0XcFXGyMbY9YmYnJPq3r3
	ACXWoO48pppVoBV1tIlyec1YKByvvD8a/oAyc3dnZ8OOv62JvkjM8rwftvD2T96+uNNFwXzgVn3nl
	7/xLGdag==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tQ3Lu-0000000BtHJ-2T11;
	Tue, 24 Dec 2024 11:45:30 +0000
Received: from mail-wm1-f53.google.com ([209.85.128.53])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tQ3Lr-0000000BtGW-1X6F
	for linux-nvme@lists.infradead.org;
	Tue, 24 Dec 2024 11:45:28 +0000
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4361815b96cso33201655e9.1
        for <linux-nvme@lists.infradead.org>; Tue, 24 Dec 2024 03:45:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735040726; x=1735645526;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=q4vmTmn+eFEtvUxnxO4pwi/5/YfiaeWZpZWpC8QTwV3L5XHvEIw1DiegjqIUa6n60Z
         y1iBdVJbc+ZpZuVNG+RTEjZ+NSavOWXDHYaiZqhtmDqwPWV/qoD24+bSxDmvZ+v9gxJG
         3yhCBBkgTN+cfofObBXw9QTsFqAcu92QbuV2wVvCyxxTN+LiZ6K0fpjeOmK9VwsgkKZM
         /fPhIX4ji4Evel+O1rrfdpaUYVfPPwATuhCOTV4jYsBRg0G/jeWHpU7DEvlNVcTe8h+b
         cLMb8gHCa4a0gB8wFyrQAAP5/ax8mleMJ4L9nT7Qm61vfc1ReaBcCJtYy6eADgpun0Ob
         YUOA==
X-Forwarded-Encrypted: i=1; AJvYcCXp9hDXCUkYH7AsjJJBOA2YyYVg3ctDLj2e0sGMqCzKUPmn+D0awj2i5kob8u9S8l0HEK4DC8iBMhN5@lists.infradead.org
X-Gm-Message-State: AOJu0YxaInFzN0fT0tywDSxlmSV3XjHsjEyajg1xOA6+GpTY1PTf3p6p
	m3h45KAGuXFu71VR8wabJy8s8wANU69FxkQTwMEj+qoiMUB1LnfnYzOkSw==
X-Gm-Gg: ASbGncsJ6MPJb+Hw1qGhf7ZUB0ZDHrldwPbNtX1qhc/MJLRBvLMZHTzE/VzP1gLdC+F
	wLFKEZ8hHIePvMcycLgGmyRbvYsixNk3+zSaoWAsk/WoxL7+EqV+ajdJ1+aGvBx6Fhj4exrVON/
	jlMIWkVpLgsZ/2HFfj/5S3byKsUWo7+AqdfQNf0J722Eft79vmuv4zQy7m4Jmioq1TaD4RDvpgF
	PXfOrR1VlUEteMIfFsCh6Tg0XKSRTHcRq7ZGQG9xEF5C0dYFeLzUydy7REIv4vk4Gz+h0DIg9Zq
	xn9FIgtuU9nISnabLys9aVk=
X-Google-Smtp-Source: AGHT+IGjTXQdPg0fSv0+ap6PO/q4p+AqDO6lV20nFhqhSwkDoRnneYsYeuNvKM8j47Y+SVeRnp0Ydw==
X-Received: by 2002:a05:600c:1c0b:b0:436:1ac2:1ad2 with SMTP id 5b1f17b1804b1-436686469d0mr139293505e9.19.1735040725769;
        Tue, 24 Dec 2024 03:45:25 -0800 (PST)
Received: from [10.50.4.206] (bzq-84-110-32-226.static-ip.bezeqint.net. [84.110.32.226])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a1c8472b3sm13924121f8f.58.2024.12.24.03.45.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Dec 2024 03:45:25 -0800 (PST)
Message-ID: <fce9c164-ae98-415c-ac1a-4ac9d7b9cd18@grimberg.me>
Date: Tue, 24 Dec 2024 13:45:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/10] nvme-tcp: request secure channel concatenation
To: Hannes Reinecke <hare@kernel.org>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
 Eric Biggers <ebiggers@kernel.org>, linux-crypto@vger.kernel.org
References: <20241203110238.128630-1-hare@kernel.org>
 <20241203110238.128630-9-hare@kernel.org>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20241203110238.128630-9-hare@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241224_034527_402335_DD7F3862 
X-CRM114-Status: UNSURE (   4.69  )
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

