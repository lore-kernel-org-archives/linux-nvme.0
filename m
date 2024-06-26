Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAA3DC27C4F
	for <linux-nvme@archiver.kernel.org>; Wed, 26 Jun 2024 13:44:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=dIUve6uB1xB6+cpuKtjHYOmaEbJizh3rR27h60/IZ6E=; b=tKKXm6gfzAixw6+9xg5RPDAley
	UEcI2JQTgsNuU28GlvOjQXqLipjnf4Xno4KJfW03eahoKx8vTzp684tjq9VLeTU4OdVA5PO+fSCMh
	NqbiAN7BuH/RrlUz6G+dUYIN5XWcoWom8EG/M6rdr0y+xBf6d9cv0kVvoKDQJJEk7Qx1pLbGNYYxx
	lkItVSeAmsFWbCjB5QBypqjWsl3ydX8coW9y6Y3CebEXzR+HSa3N2mcuQPipNRaNBX6ayIjoov0+H
	aOVXk2wBlvCj0syDOfpnjmOyu7O4NLNf8GsMzSmz8uEmCKq4oK+z5URDrM1SKL7FlrEKB0FD1Ddwz
	z9za2gaQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sMSwu-000000071ie-12RG;
	Wed, 26 Jun 2024 13:44:36 +0000
Received: from mail-wm1-f54.google.com ([209.85.128.54])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sMSws-000000071hd-0qQ4
	for linux-nvme@lists.infradead.org;
	Wed, 26 Jun 2024 13:44:35 +0000
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-424a4bc95f3so1863245e9.0
        for <linux-nvme@lists.infradead.org>; Wed, 26 Jun 2024 06:44:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719409472; x=1720014272;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dIUve6uB1xB6+cpuKtjHYOmaEbJizh3rR27h60/IZ6E=;
        b=AjjNWHsMZ4d/NXtp9xftOpavoKDJDNsrf26di+N1Pvwj/CI1R4ezUmwRUjpmTLctqR
         Scky2aGRg5/7fgmqQQG8RI9HC9h42Qvf7jWOjEjigKXUgp5/oOTfFtLPWnlUyXLLMRrE
         kZ+YBw0a0UE4TSRy5/nPDPvwQ5iNQ1RwPhj1sWnUfrU3Dl3t04/UgaEzdO8wUnZWlEv0
         bMvN48UCGh8fb4ik1DzlR0dOk6OKHA1fIczxDw3DRCdd9/qDsx3tKAp79QKwkjeiax/v
         nGzIMGjCzA3+Mkz0JOUHDHh1Wk83f+co/T8R7ZiDYUYMYr5ZVD+WD8ZqAGgD5QZW9L5r
         KYOQ==
X-Forwarded-Encrypted: i=1; AJvYcCWspuuEAhxvMv40XAYV9jld2osq0//a2QVCfLfwhb2Fsssk2/TjQPhmEmYOg+9SGJ2bvrJTGa3PjGIihwlafhuQr8e3saqWCBjAOeTdvxI=
X-Gm-Message-State: AOJu0YzX8SlPNgvDTQhKmlBDlfEPwTfxVsB0sbaUJpTMKaR5ETjOKU8F
	RtBPKjZ7lmriIfy+kvW3gvRjXXjQ1g2HhC38LWn2Lm+9LHgG2eIU
X-Google-Smtp-Source: AGHT+IGDoPKuUowm6jEgWmIpYUdGeiYgzl3RmQ70ULdi3JuoFkChB/0jdLEqMRRs+xirn0u9By3/Kg==
X-Received: by 2002:a05:600c:1c0f:b0:424:a74b:32d4 with SMTP id 5b1f17b1804b1-424a74b3445mr27424865e9.0.1719409472033;
        Wed, 26 Jun 2024 06:44:32 -0700 (PDT)
Received: from [10.50.4.180] (bzq-84-110-32-226.static-ip.bezeqint.net. [84.110.32.226])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-424c84245fbsm26276935e9.38.2024.06.26.06.44.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Jun 2024 06:44:31 -0700 (PDT)
Message-ID: <410be91c-7243-4c1d-985d-2a6b84fc7321@grimberg.me>
Date: Wed, 26 Jun 2024 16:44:30 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/7] nvmet-tcp: add wq_unbound module parameter
To: Hannes Reinecke <hare@kernel.org>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
References: <20240626121347.1116-1-hare@kernel.org>
 <20240626121347.1116-6-hare@kernel.org>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240626121347.1116-6-hare@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240626_064434_275932_A2685896 
X-CRM114-Status: GOOD (  10.19  )
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

Please leave this outside of the series.

On 26/06/2024 15:13, Hannes Reinecke wrote:
> For high loads the default scheme of queueing work on the receiving
> cpu might lead to cpu starvation and 'CPU hogged' messages.

In which workloads have you seen this print?
Can you place the print in the commit msg?

> This patch provides an 'wq_unbound' module parameter to let the
> workqueue mechanism do scheduling decisions.

It was intentional that we maintain locality of the nic to the backend 
drive.

I'm not saying that we may not want to do this, but we need a justification
as to why. Was this reported by users? or observed by you?

What about rdma btw? That also runs in a workqueue context. Plus with 
rxe/siw
it is also writing to normal udp/tcp sockets.

