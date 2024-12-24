Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAA4EE77188
	for <linux-nvme@archiver.kernel.org>; Tue, 24 Dec 2024 11:29:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=3jKSvtpPTheoHSpw3/XCvFbJ/3
	GTiYQ6RQ5JJJ1kux5ic7ZIJDpUx5erUzHz2RsRXQhPIHzXYuieqKn2CGdX78qSMF6/wjt5sYLxG8m
	7bBOvVlItIaFRIqBsgZcYzXZ4S69BD/3K5PjVCQ7OsyuJ80/hp83r2l9BMlVFm59xU1lE3ceq2SXx
	33InlkoC+8CAQd8jBUFZGpKs2hJuhhJF40glcVhfJT4CmfCStFlJRU2Xoz1waC5WmW1XEloUDbbPv
	cBG2A/5mVgPUHBO9SKszlk/lESZ9aID1kRBnQtD/WSeH1X5ieNZ3Ctn3YiiuDnYvQHs1tgvZieyWo
	q3xQLrYw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tQ36m-0000000BrKU-1Ckh;
	Tue, 24 Dec 2024 11:29:52 +0000
Received: from mail-wr1-f41.google.com ([209.85.221.41])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tQ36k-0000000BrJd-2LxE
	for linux-nvme@lists.infradead.org;
	Tue, 24 Dec 2024 11:29:51 +0000
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-385d7b4da2bso4336094f8f.1
        for <linux-nvme@lists.infradead.org>; Tue, 24 Dec 2024 03:29:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735039789; x=1735644589;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=tTy+PuNXJm/oQWoM3yDSLOhX/+vH/ZwlidqgAi6a2cUqvmmnk0+F8OWXUQ4tUhOsoM
         bIwccwtPN2mg1ucGdMERkXpxOMrnaPDvH4TOinuOA82qXdkjXDzhmh6/TJ59VzvGtqxz
         n7oHUxzz1PISiJRYsbhj6FDu5KrkJUgvgamKN2kcbjV0k8HNq5XSz2D4ZvBFKdfIdU+0
         Lc2GTrC3Ox8G1OtZtChimdQggq9QBZudvDiFsAOPs1tfxVQlyqiGg0o01s4Q9Plgs+MA
         Z6sE5iQ+ODcySPHSFL0D65WAefKQ1qgWQ+iGRANttR6034nlL4EKs2ooMdKZv+0z4G0A
         2byg==
X-Forwarded-Encrypted: i=1; AJvYcCVxRBteylhdbbPNKuS37wYU/jwQxOUD0a/7y9+Rt/0rxVPMVpZiI/J3GC4xdSai8rXyGRxPzv1W5Ode@lists.infradead.org
X-Gm-Message-State: AOJu0Yx1dK2QUvrTP5TaAi8SVArv3njbWfVeFCgvfVmLHOds70ejHUnj
	cCSiGZ/uD4TnRM0IXzef/ZlrwAN2JjkCmDyfcKCuhzkVPA2F2eq7
X-Gm-Gg: ASbGnct/UvqEGZuar2Nh47vHuRe2cGMSkUT/eKVv8hPI9qSurx+dNsE2qKlB1tbW+jG
	sCOa7S4OOOv0Up6+gyzm+BZV9SSxGIOB4bxOQOUJEVN9eMIgh4Bsyt0JcBjbIG5LcrHoNHN+eZ9
	0hvhDd7UGTpa3UBOeNepn7F+8YsoJMwl+IAmEfKVXNsoslinM0CTV681wfcCsjIndBgi6A9pCYB
	SBnqI7rlsEa6yQq3wX9mvHZFFIyIf7d+NZdcwo+QH4NUqqdKvtSISfDt8fUyMLw+BN2PckN8LxM
	E/M/vK213eKFpfQN1spV6LI=
X-Google-Smtp-Source: AGHT+IF9QPJP6oHXfhrBvtublLiK4sG/hQYn/FJqNM1u6INBTZ7x0yf58J3qdkL+6Po2KmuHTiFOAQ==
X-Received: by 2002:a5d:5986:0:b0:385:d143:138b with SMTP id ffacd0b85a97d-38a223ff407mr12949588f8f.51.1735039787477;
        Tue, 24 Dec 2024 03:29:47 -0800 (PST)
Received: from [10.50.4.206] (bzq-84-110-32-226.static-ip.bezeqint.net. [84.110.32.226])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a1c829297sm14331836f8f.4.2024.12.24.03.29.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Dec 2024 03:29:47 -0800 (PST)
Message-ID: <f6697284-50d8-436e-b20c-5b917cafc3fd@grimberg.me>
Date: Tue, 24 Dec 2024 13:29:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv3 2/2] nvme: add test for writing to file-ns just after
 disabling it
To: Nilay Shroff <nilay@linux.ibm.com>, linux-nvme@lists.infradead.org
Cc: shinichiro.kawasaki@wdc.com, chaitanyak@nvidia.com, dwagner@suse.de,
 hch@lst.de, kbusch@kernel.org, axboe@kernel.dk, gjoyce@linux.ibm.com
References: <20241206111812.489140-1-nilay@linux.ibm.com>
 <20241206111812.489140-3-nilay@linux.ibm.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20241206111812.489140-3-nilay@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241224_032950_595585_C7C6C748 
X-CRM114-Status: UNSURE (   4.27  )
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

