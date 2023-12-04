Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2A0EC4167B
	for <linux-nvme@archiver.kernel.org>; Mon,  4 Dec 2023 08:17:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=k2LYBONattN6F46c/F3gQNkP8M
	Xtigvzm+see/5QtDMcC5j2KeyR8TClFqxLocWyPbYOrYS9yseCqgDc/ZxyAST9on8NQ7i+mbOgeoN
	4zhr3lW7x05xaLnnaieTPwxtu2eeTiXjSXjJfw3neeQ9DX/mJxZTIxjzYyqb8YRsSTuE/M+W0UjDl
	av70D4fA4vBYzYoLCdFr0tCsrxjimJ7Osv0pV2n70MYpdrLBvjkY0cNZiTwiS3oaLF+EFwnLF8Z4+
	Y4Y1pD5iEiv1Cb9TDAnzUQoZ0Pu2rVozgKDYO96NP2fx+bYC5gZCtk+a7YXHiTIdUuQQ5QxopN0tY
	9coFfZYw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rA49B-003FEe-0z;
	Mon, 04 Dec 2023 08:17:46 +0000
Received: from mail-lf1-f47.google.com ([209.85.167.47])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rA495-003FDA-16
	for linux-nvme@lists.infradead.org;
	Mon, 04 Dec 2023 08:17:40 +0000
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-50bfb930dbbso23572e87.0
        for <linux-nvme@lists.infradead.org>; Mon, 04 Dec 2023 00:17:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701677856; x=1702282656;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=eINByepdXj8SZub7twmLrRabsYCpDUY0z0VrHa2uLrrb2KxlBRtWzKWjWVkwc8hExr
         F4QX9BV/KPmMR8WoptTywuAk4Aw207l705kNRKU4WqtE2EZsaL+m1ofoupA/xnetr9If
         oDwJkFA7CaTJ0Z+N2U8SyfUG6Ah+suXWZq3Jrp8byLW5cs2QUqZd4xJnkzUf0fuBioJv
         LSL36+v5PgMGlzBAVmCEcOOnUAgsRJgQQQzfKS12kftfy7iEQY80eD5dGM5wQGqY682d
         qtdR+fewgbHs+tNBs7gMNa7Nyhejh5uKsIhXnAxTPnslvSt7bAZNEjM33P9saBVhth7H
         3Y9A==
X-Gm-Message-State: AOJu0YxhQB194ND9i+uV7M7XT72r2veBQUHqOBWWOmSw/jDZ2o+ewrQ6
	gUA8uDZSl2yUvcQmE1HbrDw=
X-Google-Smtp-Source: AGHT+IF26EVjKVsgfRqAruiAlgtinYwNak652Rpf578MiaLFt9W6sc7xniym9YVMTVQQCOuaS6KmNA==
X-Received: by 2002:ac2:4a9c:0:b0:50b:c9b2:63bf with SMTP id l28-20020ac24a9c000000b0050bc9b263bfmr6206168lfp.5.1701677856057;
        Mon, 04 Dec 2023 00:17:36 -0800 (PST)
Received: from [192.168.64.177] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id t20-20020a05600c199400b0040b36ad5413sm14033579wmq.46.2023.12.04.00.17.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Dec 2023 00:17:35 -0800 (PST)
Message-ID: <f5aa6f1f-934f-4f45-aaed-af3a992cc3f9@grimberg.me>
Date: Mon, 4 Dec 2023 10:17:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme-ioctl: move capable() admin check to the end
Content-Language: en-US
To: Keith Busch <kbusch@meta.com>, linux-nvme@lists.infradead.org, hch@lst.de
Cc: axboe@kernel.dk, Keith Busch <kbusch@kernel.org>
References: <20231130201919.2486553-1-kbusch@meta.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20231130201919.2486553-1-kbusch@meta.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231204_001739_422994_6800FBCB 
X-CRM114-Status: UNSURE (   4.82  )
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

