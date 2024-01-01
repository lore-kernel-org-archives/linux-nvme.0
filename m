Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3F3FC4706F
	for <linux-nvme@archiver.kernel.org>; Mon,  1 Jan 2024 09:28:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8D3wc3Jf1Bei+nJwA+L6STnZTqPtpK21K7JZ2SE3Uak=; b=WEsJspi+VPiFXiq+Ud3rTAUviR
	d/2vP8RKXukz17AXsWc4E9Gvvsa03d9X5wex/bh6OwWdx+FIvsF82bvG+fgbJN8TVQAWIGWl2/kyJ
	/Iv2NafuCWa0btJaDDcLvPjMv0Vo20BRFem9V7aM+OGTesQbF/7yc5RHvjIfvxST68xuR5QPeQ/GX
	aw5bxHjwGatJ7zGUayB5dzVT4ZnrrTrZT5z5O2bH0KV8VtRQVMnXbp3CiOA+mKnmYk8gqGc+uJ7T+
	mxGccjOMp6qICqB2PYBhsymAymngF2d2LpXUD4iwl3+gQl+MITEaskgJGpSARjG6Q9cw4SoJtpCJ3
	c2hbYKRA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rKEaa-005pJ6-1Q;
	Mon, 01 Jan 2024 09:28:04 +0000
Received: from mail-wm1-f52.google.com ([209.85.128.52])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rKEaY-005pIV-36
	for linux-nvme@lists.infradead.org;
	Mon, 01 Jan 2024 09:28:03 +0000
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-40d5d9adf6eso8993545e9.0
        for <linux-nvme@lists.infradead.org>; Mon, 01 Jan 2024 01:28:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704101281; x=1704706081;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8D3wc3Jf1Bei+nJwA+L6STnZTqPtpK21K7JZ2SE3Uak=;
        b=litppSmwXTaFKNKacS+RZ/ezz/Luju2K34855xH2amJDQJ5tO5rqNlsNozJZQI6CAE
         yRloTTgCq0YctvOQnV21XV4MTQWiQQX6awfEDEV8sflDJ+mfO7PijRzXgAe8k3cR7+1G
         MPteQs7Rpft1HRwMBygDcN/SLjUbCbRsB4LuPvC0HCBnMzdkqYza7RBVHCUNQqkD08Du
         /9JmSdiNVEdWQj+CiMF+QnHOYscNx2TzdBBqLJeNRIDSXLmlZC5ARDkzPcG48UE0ZajF
         OqrWbfZKx91VaArV4puiVmaiq0gA1JiAISyFkz1EoE9YwQmQkC4FlMVgA8q3jfVKmlPR
         DCfA==
X-Gm-Message-State: AOJu0Yx7xjISTg+84WZHc6XAm/vE4thNBSfQod3f2Da/29dspjjqaYJ3
	RNjVwzXvSgped5QXoVm+1jw+Po2jA+E=
X-Google-Smtp-Source: AGHT+IFrxaubpuvjwU5BwdQZJ2jiD9ebLOS8qcQ1nAAo2C/D4Cgvm9oE2ZTnOQ5T+IBk88j1HWbbzQ==
X-Received: by 2002:a5d:43ca:0:b0:336:7290:3cb6 with SMTP id v10-20020a5d43ca000000b0033672903cb6mr16954145wrr.6.1704101281025;
        Mon, 01 Jan 2024 01:28:01 -0800 (PST)
Received: from [192.168.64.172] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id m17-20020adffe51000000b003364a0e6983sm25316648wrs.62.2024.01.01.01.27.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Jan 2024 01:28:00 -0800 (PST)
Message-ID: <c1f4a478-384a-4715-a7d4-0ac2c822e26c@grimberg.me>
Date: Mon, 1 Jan 2024 11:28:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/10] nvmet: remove NVMET_QUEUE_SIZE definition
Content-Language: en-US
To: Max Gurtovoy <mgurtovoy@nvidia.com>, kbusch@kernel.org, hch@lst.de,
 linux-nvme@lists.infradead.org
Cc: kanie@linux.alibaba.com, oren@nvidia.com, israelr@nvidia.com,
 kch@nvidia.com
References: <20231231005249.18294-1-mgurtovoy@nvidia.com>
 <20231231005249.18294-5-mgurtovoy@nvidia.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20231231005249.18294-5-mgurtovoy@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240101_012802_994885_4CEA6590 
X-CRM114-Status: UNSURE (   5.28  )
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


> Use the common NVMF_MAX_QUEUE_SIZE definition instead.

Why?

