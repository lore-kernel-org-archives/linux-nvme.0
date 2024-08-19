Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D948C3DA4A
	for <linux-nvme@archiver.kernel.org>; Mon, 19 Aug 2024 13:17:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=AGE4KZAD8J2N8wbyvXyRLhyDbhOrS9gAgRMWg1yAFt8=; b=es8our5RtVfaVcfhNXJasMhqn7
	dZn9hjaKX7kwuzXKwLFpbnbva7uUEwDC/w/PAYg8175+2kLtsFfqDPZTez8LlOYLtB7TxQY3VUHyX
	6V4teUCQunX/lWrIPKyawTytEZBJOyP4yKQEWJ6Ai03MPQi6guuSHVpZkK9YqKgt6v2VcCCWHcPYH
	3T57okKTouhbAMjIM3dJ1fMyBndXnyA76XuQUmkw72KyS4A/XnLyo3q7QvWEJFrrMg4YSgzNEdtno
	HRFvFTfvhvSZ4pNYNBSBBgT89SSLzoorHApNSKPfwUDNjr7sNVv+MEBCnxcZX39BRVShTAQ6/nbUH
	tSDAq/VQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sg2G1-00000001YK4-39HG;
	Mon, 19 Aug 2024 13:17:13 +0000
Received: from mail-wr1-f43.google.com ([209.85.221.43])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sg2Fz-00000001YIX-0qoL
	for linux-nvme@lists.infradead.org;
	Mon, 19 Aug 2024 13:17:12 +0000
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-371a939dab9so272613f8f.2
        for <linux-nvme@lists.infradead.org>; Mon, 19 Aug 2024 06:17:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724073429; x=1724678229;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AGE4KZAD8J2N8wbyvXyRLhyDbhOrS9gAgRMWg1yAFt8=;
        b=RR27WBlW9VbM4j0jdrZPafr1kgjzLmEk6ibWdOBOUqFMU13DSCeRC/Txz3cZuWh6Kv
         3PnvRWXnYrggZBF1TWxTNy3kQNNtI48UpKnsY+X6sNdNZj6WgHtDTESRsdkoSeqVdu3p
         acEvkhC7VZgm5/EnYdt5qt1zzsChemiv5Gq9vJr8lesuDZLoWvnIry3j/x1KlH6BvcIp
         6I03c0G1JYJWtCc4ywvaiW2zOwHaec/3sE9wd46Q3gEZxB7IX7h0UdIWtskqzL70r4uL
         1ksykblu4hIBovw7yZ3DSNSnDvTqXjDITQZH7Y0P5YDxQpS134INwWJ9Sej39BFtANBT
         NJ8g==
X-Forwarded-Encrypted: i=1; AJvYcCUbT4WjnWNYfsaCj0H3YYHgKdL7VaR+YXIs6yL/vh2kqI9OOMZOrBnwX+hLRSErWBUqAfba/lNUQeN6@lists.infradead.org
X-Gm-Message-State: AOJu0YzGnlQTzXBt51QSCk7eGTaFpepTYdtHGHIvbJxLWAQrFx0Mc8Aj
	UqhTExmeoPrTB19eR/CVyDgmHecF62j4d3qsKx7FGvGNddw3G0Jw
X-Google-Smtp-Source: AGHT+IFMcY27ZsYb4ZpWfJf9TVMW66evKntBFVRPpVgsrwJ+xdNtBPa0nldbL3t5FqY/7MNWf5j5mw==
X-Received: by 2002:a5d:47c9:0:b0:364:8215:7142 with SMTP id ffacd0b85a97d-37194315698mr4302067f8f.1.1724073428233;
        Mon, 19 Aug 2024 06:17:08 -0700 (PDT)
Received: from [10.50.4.202] (bzq-84-110-32-226.static-ip.bezeqint.net. [84.110.32.226])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37195650163sm8488145f8f.98.2024.08.19.06.17.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Aug 2024 06:17:07 -0700 (PDT)
Message-ID: <dc3d279d-58a9-412b-9cb3-cc51297f65ba@grimberg.me>
Date: Mon, 19 Aug 2024 16:17:06 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvmet: return 'namespace not ready' for disabled
 namespaces
To: Hannes Reinecke <hare@kernel.org>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
References: <20240819122917.65313-1-hare@kernel.org>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240819122917.65313-1-hare@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240819_061711_274762_4CB22C4E 
X-CRM114-Status: GOOD (  12.03  )
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




On 19/08/2024 15:29, Hannes Reinecke wrote:
> When a namespace is disabled from configfs returning 'path error'
> is quite an odd choice; the actual description for that error is:
> 'The command was not completed as a result of a controller internal
> error that is specific to the controller processing the command.'
> Which is not the case here; once disabled the namespace is disabled
> for the entire subsystem, not just the controller.
> So return 'namespace not ready' here to clarify the problem.

Hannes, can you explain what this patch is solving?

The reason why this error was selected is because this is a path
error, which will trigger a host IO failover.

