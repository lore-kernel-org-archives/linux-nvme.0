Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35AA0CE7AB8
	for <linux-nvme@archiver.kernel.org>; Fri,  6 Sep 2024 07:43:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+OfzGbV63/15CfSmtxZAIZAR5N5JQQmdunDLTxvYWVs=; b=3D3HFrvkuGNk6CltSJUBrvKcq+
	YVoztnGYa53s3ONxt1Ka8JSnLt0GkjqUfaZeKadvF4xB6ix24mASZ4S0QHhnIz0GbTj/Ld1rjGG7e
	e+Tz/txWYYejCiXcypT+qikZHAfrAneQ4CZfHTuHoKYCvrxVtZIy5AW+govNtY+jxgwGniZs1mJDy
	kohjci+KYzRhDZVbm4t2zFjgd9WqaHmeGZ0aRB2VO7iufRRWeinxcSQmbYfVYE+e+99aGXtOFjW0Q
	NKdt8EomNAmilAp+1gnUIchgcV6BhAL+oThmo8LPIwOh5dG023aH4YgwRV+fHiuHbnXgWWZOihR/r
	ZeQP4iBA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1smTd7-0000000B8yo-3Rgn;
	Fri, 06 Sep 2024 07:43:41 +0000
Received: from mail-wm1-f44.google.com ([209.85.128.44])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1smTTj-0000000B7AF-0eWd
	for linux-nvme@lists.infradead.org;
	Fri, 06 Sep 2024 07:34:00 +0000
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-42bb7298bdeso17277155e9.1
        for <linux-nvme@lists.infradead.org>; Fri, 06 Sep 2024 00:33:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725608037; x=1726212837;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+OfzGbV63/15CfSmtxZAIZAR5N5JQQmdunDLTxvYWVs=;
        b=bT7kRELr9ApTc6yWuCj3J963WRSfC4d78DYm7cVKxfg6PZ9O/D8PgfldFVD2G3OvB0
         qUYmyQohnziHO2TLVdk2Sz54gl75VO+2Qxf3UmiPjJbjDZ8nMxhQhzDSjrIzuEbEI1WK
         lIn1MmpCPqoel5vuvZk2v9NN7PF+xlxFAUHqTd4P2b/VylHTQw92WrOopwf060sdOvTW
         0yz/d9tiFWC0TtTEbp9yrk7NJc0S0jzxvue9FD6iK7NJKZs55VAEcTYnZBQv+HAHq5BZ
         bq/Jq9ZsUHCpAV3JNjYVAF5R7QPlFsH5ADl7JCbW6kTzrYk7lwLsQvMjHC5/sgOOZDW7
         k4Zw==
X-Forwarded-Encrypted: i=1; AJvYcCWIimzLlskQfiuwqV5FpyglxRnbFBI5xk3R58l97ye9iCmO2E8JDNGPogo3POwv0QxMTdX0TbguIFWD@lists.infradead.org
X-Gm-Message-State: AOJu0YwksvbkdMzKg5tmiyUsWpUJWo/cPiuBTw7SV/EckON6OAqwzZw2
	YIaTqqxwgGYGx52irzhD3sb1JdGGCWxXG8wUoKBlycDMa0+w88+jA11rCA==
X-Google-Smtp-Source: AGHT+IHqYrq2TDYg2WcoU7VvQjanusIxmjOMoFknsG0+BXDau2+8Ao/BysaZF/WYcmN2auxDDDEDJg==
X-Received: by 2002:a05:600c:510e:b0:426:545b:ec00 with SMTP id 5b1f17b1804b1-42c9f98b589mr13350295e9.19.1725608037310;
        Fri, 06 Sep 2024 00:33:57 -0700 (PDT)
Received: from [10.100.102.74] (89-138-71-253.bb.netvision.net.il. [89.138.71.253])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42ca05ca4f6sm11125555e9.17.2024.09.06.00.33.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Sep 2024 00:33:57 -0700 (PDT)
Message-ID: <57c500ae-4ef2-42b5-b14b-028dc77db6d6@grimberg.me>
Date: Fri, 6 Sep 2024 10:33:55 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] nvme-multipath: always requeue I/O when updating the
 ANA state
To: Hannes Reinecke <hare@kernel.org>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
References: <20240906071828.125614-1-hare@kernel.org>
 <20240906071828.125614-4-hare@kernel.org>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240906071828.125614-4-hare@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240906_003359_224432_A0096F51 
X-CRM114-Status: UNSURE (   8.09  )
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




On 06/09/2024 10:18, Hannes Reinecke wrote:
> When we've changed the ANA state we always need to kiek the requeue
> list to ensure any pending I/O is retried with the latest changes.

And again, you don't describe what you are fixing.

Let's avoid sending patches that are in the form of:

---
nvme: do xxx

do xxx with slightly more details.
---

Can you explain clearly what it is you are fixing, and why, and only then
how.

