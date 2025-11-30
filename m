Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E598CD111A8
	for <linux-nvme@archiver.kernel.org>; Sun, 30 Nov 2025 22:53:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=DMidbVV9sOSJqZcFrFSApTPc25
	fvcnp4OPkZCJQNXeZYJ8FeyGp65uryeo3MWdoBD0V/3IdFQRml2S/k92Wo1tXU0lYzxDEzcrfbFGc
	2bsI9M6BJMBASdMv8BDJDKgf/7VD4TQCtAd1FHrEH4FXavDfja3zwHvInrLn4mBwcuCJuR4jGsWCk
	6+v/wi832juLLH68Z2qnTLAGBErdYYKdJwJl1OQ06tG6TkapGYsghL1yMBwl292RbxnKodP41nYHW
	aa6G7Z6bYsKfjkUTPQ9eTADuG3K5HozYdd9gBqjGWrEfYPhyirkIVVGMPTw1gvVXlhTLnsN7tpbIz
	CcwAFz8A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vPqHx-00000002e0b-1XJw;
	Sun, 30 Nov 2025 22:53:05 +0000
Received: from mail-wr1-f48.google.com ([209.85.221.48])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vPqHv-00000002dzc-2w2s
	for linux-nvme@lists.infradead.org;
	Sun, 30 Nov 2025 22:53:04 +0000
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-42e2e628f8aso230797f8f.1
        for <linux-nvme@lists.infradead.org>; Sun, 30 Nov 2025 14:53:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764543182; x=1765147982;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=k/zLcjpfQXrLjwyxyjT2A23uutBZ/lentfJ4NMROAIg8k2CkC0yujvbjiw3FWsdgov
         xFA5KI1+fB3vJ/yOLPiirZy/utDJULPnAjT8cCvf2bT3bOFxk7Y+pfWmpDYzCId++K+/
         siubua5veOHo1+7mzE3K89EY9zS1BCDl/pT4kRgJgFoiYomo6/etnQdHMqXZsSXsbmwe
         JiMvfAwQbyyCPaICw16wsWNSgDo0zhvxYY8OyZxsszFksoH+CHumn9NFzQvRcFdNJ///
         M18H44Es/qldfrWvrpJ3m7Q6bW/q6lKYAm3JDXbYVvH1Urrdh5/lwF4dTJjSEoRdUiaG
         bIBw==
X-Forwarded-Encrypted: i=1; AJvYcCVOVXcVSnb4iLAoFOS7hSiP/7DS3gBejZceUzfNQh7CSTitewkqg5/Hghj6ytdCHSvIOGV5cMDAy45D@lists.infradead.org
X-Gm-Message-State: AOJu0YwfwyH+ZmjzLHAAnw13DIToCsdOT0UOCBFmgbfFThzrqzw22ckz
	w/oHdG6HLAJy94lOSh9WmT2KyjqgVqWF29im5C5M7yiFWgHyzzrjbqCt
X-Gm-Gg: ASbGncswzdZ2fCScrLtPmboeaE2n5LLMayZEd57Y+EhbMbCf/NDZw+lQMyC2X1/zJ/W
	ghTUiNw1XYJgk45qqwCBZq9ffZ98wK+c5+zXjIxM86BTm3XJIEYqTh0nyuCYmrCwlpXKRDc2hd/
	6AvRY7nq+LYNk5+eVPuodAdaH095zQ/PzHVpRqT1JlVImXZZ4Pgz14+i63R4Hn0lEWFhWrujilX
	mbETp1X9tsFuWhlwRoaSzrf4hKZgwAgqi28+msyrj9NFLIt9L/PlmPgO7fX3QVl0gNAOw7yqsHT
	Oj2YSfO6F95Q2n+5XbSinNSYnBYOm1XvcyQRaB1eaK5DYF8GJI52XAkmPmFz6umMKXAhJix8aoX
	yozJYIpookrdWpg2GO09Y4TQJ8+943LMulV5frDUglHhV6LT7ZA6AT/w+bEpLFvKOinr1BEqTwf
	8fEhGp0M+xsflHtj/nx6NKBUMltzZw6OwZx8jkQVNN
X-Google-Smtp-Source: AGHT+IG9yvdBUkbFqRMJn4198kSGQOOq7Az/0JCBbYcnU/fgF07hoy+1HMnRYuq3Qm7NXbGYI/5LZg==
X-Received: by 2002:a5d:5f90:0:b0:42b:2e65:655e with SMTP id ffacd0b85a97d-42e0f344690mr22625687f8f.27.1764543181757;
        Sun, 30 Nov 2025 14:53:01 -0800 (PST)
Received: from [10.100.102.74] (89-138-71-2.bb.netvision.net.il. [89.138.71.2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42e1c5c3041sm21625150f8f.6.2025.11.30.14.53.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 30 Nov 2025 14:53:01 -0800 (PST)
Message-ID: <34a7d281-2f66-4dd0-b3db-abbc1835285f@grimberg.me>
Date: Mon, 1 Dec 2025 00:53:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme-auth: Use kvfree() for memory allocated with
 kvcalloc()
To: Israel Rukshin <israelr@nvidia.com>,
 Linux-nvme <linux-nvme@lists.infradead.org>, Christoph Hellwig <hch@lst.de>,
 Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>
Cc: Nitzan Carmi <nitzanc@nvidia.com>, Max Gurtovoy <mgurtovoy@nvidia.com>
References: <1763909208-11611-1-git-send-email-israelr@nvidia.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <1763909208-11611-1-git-send-email-israelr@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251130_145303_733662_72E84CE9 
X-CRM114-Status: UNSURE (   5.23  )
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

