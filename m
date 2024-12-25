Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EE70E7718B
	for <linux-nvme@archiver.kernel.org>; Wed, 25 Dec 2024 09:58:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=gLyfXISq47mr+9ed4bGmoLJti8hAJUBD0oH6Z/Mak5M=; b=YIRTRTlN/ENP0FUV7TUOoSvgqB
	huptthXyKZL/J08XI8vjxq0brwP98WhBYPBJhDpYl5mPTfuItnUiDjPPAi3lLcfOIdBj74zB+8Va8
	YFQv2vRhJZTO90wB5Os4mbJOuV4AxvqMhPAtjIildSS+YaQ+3QQxo0KsUleJiWtAUl+llGzdne406
	6aRcl22n+vru7kR1F8lk2LUWHf3KlhsfStEmbJF/WQJDp1t/ltDzu9AeDyGgethcDxJ6tmOshK7As
	skjwqTJAUgkq03nMIGJWWA3LkmMG/WQi1uGYQ0Z9MrnSkPe0pgXthbXyyzCh4cMT5elVmlVZdsDq9
	00Tunttg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tQO9b-0000000DaWX-1DGj;
	Wed, 25 Dec 2024 09:58:11 +0000
Received: from mail-wr1-f46.google.com ([209.85.221.46])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tQO9Y-0000000DaVz-1JZp
	for linux-nvme@lists.infradead.org;
	Wed, 25 Dec 2024 09:58:09 +0000
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-385e87b25f0so4348443f8f.0
        for <linux-nvme@lists.infradead.org>; Wed, 25 Dec 2024 01:58:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735120686; x=1735725486;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gLyfXISq47mr+9ed4bGmoLJti8hAJUBD0oH6Z/Mak5M=;
        b=HYVD6arGkhVqaeorhTaS07zyA0AtOGZbePXQBSwyJZqQ6rOWk8bckbBM+bxY5L5vyI
         oh/qSgKAAQ1co2ihQ3gyK+wGOtah4+i/R2z6BURFIj+b/GqeqxN7Agmk3D5FMXNEuCgf
         CPnvr/TuMQNOjPRbUnMMIPaYNQ/CGAKGsYCjrnMUYAmRFvU2aFD7D1J9DT84KHqwAiTb
         l+CymiYURfI1iCb2pdKMLs6L3J0t9BKGfNqhsadGVn+Kpo6PRZRqMGtL9MHgWnkYH3MD
         jDWFPaO6t1R8XOYn91hB/CJQy9tgHGZpeZi7Eb4PCk7vUQLmwNjjambqE3g/8AfDsEkl
         N/5Q==
X-Forwarded-Encrypted: i=1; AJvYcCV5BNJJDsaLhUCRs5W7rHyydJvIRXRTrTpJpSwADUzPQsbmTp0TOF/ihPzhx9GCYLQAwkzIKwmCcT63@lists.infradead.org
X-Gm-Message-State: AOJu0YwYIZ+MD5NoB+kINMM/0sNXBkFcN21gr81k/NJgStxGCSxUQ51k
	KHCJzNDheTDUsTuYPXLlt0cVYkE+vsoL7YEJ7Y4vhfQr5eoR77AQ6AlIUA==
X-Gm-Gg: ASbGncvfhFyjr+Ante6beskqo5DEs80kK21SYWo5a/mf1RRRGgQs4V5ocm4H6K0eSJe
	2G8OpClwGlzAVTnlijIqLQtZHGA09epAk8FpKjbnOC06qf3nOb3p9zKd57524FsK1FA6SWEZkeq
	MQbyJwGX0l7bvWSJIXrv+G9ebNb/SKnMzI3U1BTFao7YXaA5H5mBJrylL7mJrshVqYyfmTg81gQ
	rxQFmKFp8pMswM/MHNwpDuC20XPoYNI37mhUQE1oBZjDl3fNJO5BX8mYFmB8farEJiy0vIbWb+W
	XuzRfPr04j8h4bSeABPypME=
X-Google-Smtp-Source: AGHT+IFl9FRr5+ZtBNnpDXdt7yG/V46H0NJIigXGTPNzLSFiw/uqhuhAV0a6ZpTW6eMGVcdGjgBvnQ==
X-Received: by 2002:a05:6000:4a0d:b0:386:2ea9:800 with SMTP id ffacd0b85a97d-38a1a264146mr17745130f8f.18.1735120686203;
        Wed, 25 Dec 2024 01:58:06 -0800 (PST)
Received: from [10.50.4.206] (bzq-84-110-32-226.static-ip.bezeqint.net. [84.110.32.226])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43656b417afsm231452375e9.36.2024.12.25.01.58.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Dec 2024 01:58:05 -0800 (PST)
Message-ID: <f6229339-5b1f-47d5-8eb1-d11ed2fc2281@grimberg.me>
Date: Wed, 25 Dec 2024 11:58:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme: Remove namespace when nvme_identify_ns_descs()
 failed
To: Hannes Reinecke <hare@kernel.org>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
References: <20241129140608.115282-1-hare@kernel.org>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20241129140608.115282-1-hare@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241225_015808_363611_60E7E046 
X-CRM114-Status: GOOD (  12.38  )
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




On 29/11/2024 16:06, Hannes Reinecke wrote:
> When a namespace gets unmapped on the target during scanning
> nvme_identify_ns_descs() returns with a non-retryable error.
> With the currrent code we will ignore that error on the grounds
> that we failed to get information, and hence cannot make any
> decisions whether to keep or remove that namespace.
> But a non-retryable error implies that the namespace is _not_
> present as we cannot retry that command and will never get
> information about that namespace.
> And we need to remove the namespace during scanning, as otherwise
> the AEN informing us about a namespace change will find the NSID
> present, but nvme_validate_ns() will fail, and the namespace
> will never be updated with the correct information.

Isn't that a bit harsh?
I would expect to see a specific status line NVME_SC_INVALID_NS or 
equivalent
for a full removal of the namespace?

