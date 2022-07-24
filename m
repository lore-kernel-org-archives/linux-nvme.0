Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B0F1C43334
	for <linux-nvme@archiver.kernel.org>; Sun, 24 Jul 2022 08:22:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=eWfBFqsocbmVgkvPYFh1MGWGS3IW5ihkzxalNO7J0gQ=; b=tckxx6s59cQxPDt1cpz9lm+t37
	h+7Fq5F7oK0RcAFPl5uHYfXomHPnd6rKnyv7VtBjvbIh40aHobU6T5+dfFLFB7fd1INK4a8B1iyGP
	a/VQwl+0qnftNVA77yBf8gf3s/Gn8+vGAwZ7gn6Akj4/zztZ/iS2c6Pa7JGnKGSU41vQc3ifLozyg
	eL+73gkQIk/uvyJRDUmSg+1LQzWU6YyVOe3OONtCa7fYV68wBmp0CKmLjZ1GYLT85CCJCG1/eaqVl
	nPCkW2jv5dT5A0xcCFTpHRN21PFOABMKBy00oVH9krTwTAj0zeFZ9B88xG09bD6F07EglXuWXGIDl
	eonR9oMA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oFWsh-000AO0-40; Sun, 24 Jul 2022 08:22:31 +0000
Received: from mail-wm1-f48.google.com ([209.85.128.48])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oFWsf-000AMS-EU
	for linux-nvme@lists.infradead.org; Sun, 24 Jul 2022 08:22:30 +0000
Received: by mail-wm1-f48.google.com with SMTP id b6so5051526wmq.5
        for <linux-nvme@lists.infradead.org>; Sun, 24 Jul 2022 01:22:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=eWfBFqsocbmVgkvPYFh1MGWGS3IW5ihkzxalNO7J0gQ=;
        b=B9Hqzf/HSsiiq43GqHw7WLoqgZ53YVnkaly2rsURgRmGqbvZHPu+S33ICGIB2znrPJ
         4r5deKQ7cJl36NNNKiRvnjPZuT26dQWAKXYNAVZ4jjmY0F7W7wpR9RfeyeceVHd1Egcp
         254DRZmk4Po6+kIBClqG7TZWRZzRBeZTG+XYM92mIL1ko85zg7HZRcfFJPwCRKfvVBlH
         9fySG9sMKe7hyvoOFK+KAkqdqPQOzUcXLc0IpokQPWdF0ysP7IGUVdfX+MvYN5LljoM9
         XDlugUQZwlQrQGH7fUU5JJGCt/942ns4rQ/k9LCuyXESsUYSlfLQqxPwndTmAb6fX1oZ
         K3mg==
X-Gm-Message-State: AJIora/eTpLYO8EXA340C81ONvxEFEGp/McZcZsqGKyZ9OIQB0+6CQqd
	eRfMkNOOom51AsOl+2EeeTY=
X-Google-Smtp-Source: AGRyM1s3686q4LxloY2UHYkFcgoldxKNz5AdRPVn8j4WpWDtbcRcKHrOjVhLgBQOBIS8F+9nciWouA==
X-Received: by 2002:a1c:4444:0:b0:3a2:fe56:e8ca with SMTP id r65-20020a1c4444000000b003a2fe56e8camr4710477wma.21.1658650946315;
        Sun, 24 Jul 2022 01:22:26 -0700 (PDT)
Received: from [192.168.64.180] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id d12-20020adf9c8c000000b0021e1a801e30sm8895631wre.22.2022.07.24.01.22.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 24 Jul 2022 01:22:26 -0700 (PDT)
Message-ID: <6a4abfcc-b014-0dc2-d9c2-8ddf26e11372@grimberg.me>
Date: Sun, 24 Jul 2022 11:22:24 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] nvme-pci: print the command name of aborted commands
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>
Cc: linux-nvme@lists.infradead.org, kbusch@kernel.org
References: <20220718051357.232697-1-hch@lst.de>
 <e448b5d1-d1d1-49a4-3972-cbe89353fbf7@grimberg.me>
 <20220722043707.GA30303@lst.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20220722043707.GA30303@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220724_012229_514068_2650E587 
X-CRM114-Status: UNSURE (   7.35  )
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


>> I want that for rdma/tcp/loop as well.
> 
> We don't ever send an abort from those currently.

I meant on timedout requests.

