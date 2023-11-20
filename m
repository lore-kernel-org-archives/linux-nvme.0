Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A51AFC54FB9
	for <linux-nvme@archiver.kernel.org>; Mon, 20 Nov 2023 11:01:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=H58tYMBOZFQ6zc2Fwb4qbOqKKa
	5C3jIUNMWMNzfC0aNwkWdQZf0HbYoS4njYju/JUuIls7hmjREoUuUeTzj3LC/UugyEc/sAvhfrsRo
	V0hAJ3b9oansIfhzxJTc0K3/85n6IVDT4l49KVUXQD9di+J/6LBfAa8Vy/IhaGOAFj910m2QXHm2p
	W8QgRJOYeNmCw+LTcE32hcIgr/Nywefao0fXoZs98T6yyz/7AR6Kq4tNpabXwfE3RkhjfGIZ7Su3q
	X5gU+94oj4vSQW0cRKycpgCL6/CEmT7zaQ6+rUOw9tUg9bgwN70aEYH3GPSQlebt1xF1QCIL2gewi
	1E8fxYQA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r521d-00Bqig-2a;
	Mon, 20 Nov 2023 11:01:09 +0000
Received: from mail-wm1-f50.google.com ([209.85.128.50])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r521U-00Bqey-1I
	for linux-nvme@lists.infradead.org;
	Mon, 20 Nov 2023 11:01:09 +0000
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-40a279663a2so10859885e9.1
        for <linux-nvme@lists.infradead.org>; Mon, 20 Nov 2023 03:00:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700478058; x=1701082858;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=JbUibQ7W9ZJREvtblf+GmC0kuyVXda0ql7sCnvGVP0QYe8OZtrYpElMyRKl8zUT6rq
         g/pJni5nmYvj7TXVl2uHLPzW+SSy+LnPEpYKLr8Bv/qqJipHUKtl3JzLQzNwRU9wL+OO
         3+3GWh+VHE1UWcxAXOSCtRcUnChvlKkGj81hBwesSvQDsYvo7yHs6f7k9UU9aX6aLumq
         ObxZsBc0SM3ZE/JFruIVZJDz3B5uE9N5s8hSPdxh3E4sGakTkgkaKU6yHf0kFuH/NoF7
         XYgh/A+nm6HlMkCIjus+j/j2Lx2YC/7e17IjK5V7O+YwzfRAjQV0u43Og3w2fLtkxpGz
         jEQQ==
X-Gm-Message-State: AOJu0YwlpA6XR7oYiUS6cVmeoWyD64HMVAMnQAE69q7Ar1ORGqJfi56E
	X2u40bTn79gjN/W0d5AL7L4=
X-Google-Smtp-Source: AGHT+IHVR99i7EbRPsVjoH9MxHPDPPxBEwlF1A7Xh544f7NN8cZjI45w+Jq78sPjPFMrh6c7vFQgPQ==
X-Received: by 2002:a05:600c:4514:b0:408:3836:525f with SMTP id t20-20020a05600c451400b004083836525fmr6605378wmo.1.1700478058165;
        Mon, 20 Nov 2023 03:00:58 -0800 (PST)
Received: from [192.168.64.177] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id t13-20020a05600c450d00b004094e565e71sm13041848wmo.23.2023.11.20.03.00.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Nov 2023 03:00:57 -0800 (PST)
Message-ID: <bc8e8f13-b622-4a91-9440-8d9912a76612@grimberg.me>
Date: Mon, 20 Nov 2023 13:00:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2 RESEND] nvme-auth: unlock mutex in one place only
Content-Language: en-US
To: Mark O'Donovan <shiftee@posteo.net>, linux-kernel@vger.kernel.org
Cc: linux-nvme@lists.infradead.org, hch@lst.de, axboe@kernel.dk,
 kbusch@kernel.org, hare@suse.de
References: <20231011084512.1835614-1-shiftee@posteo.net>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20231011084512.1835614-1-shiftee@posteo.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231120_030100_547986_2FC34B57 
X-CRM114-Status: UNSURE (   4.66  )
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

