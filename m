Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87A0BC77B73
	for <linux-nvme@archiver.kernel.org>; Mon,  1 May 2023 13:14:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=c/0H8p2txJ7gbQLnT3Ewkr8QLt
	UoGnz/+m+i5wAMw2DWz3pqTEueo2uwDg6h6fhBElZ298Bo8AcfwpWDuYwJz+RkosoH5zvP3YV8V7Y
	6C3qMNsW76Sf5tOTrL1Agg0UX0OWsgJVTM7P8clfk8gK1wMA4fcD/fDfxZB3uo8A5xu5GYRXJeoAK
	pbmdijf3OMad54i5LsPcjtu8Cd9I9F+5wlF2c/o0BNzpyDa1USVzTesg1uYVOlWMaKmygz0a/6gYL
	wEWVlpYU5skTcB3RYGJh5Dg5HzvjaSoUOFKvyApDlVf/FtEhgwkAIDY5sdLoqqG9zr5Ls6l6O67nb
	yXiX1ybA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1ptTMX-00G3kz-0z;
	Mon, 01 May 2023 13:14:41 +0000
Received: from mail-wm1-f53.google.com ([209.85.128.53])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1ptTMU-00G3k4-2D
	for linux-nvme@lists.infradead.org;
	Mon, 01 May 2023 13:14:39 +0000
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-3f17b5552e9so6595755e9.1
        for <linux-nvme@lists.infradead.org>; Mon, 01 May 2023 06:14:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682946872; x=1685538872;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=SrlP/6Q9JB7VByoJOZNRHgRNdyOE8CsfBW96NP6nDMDqCH4hkjjqyTaaFKl184Q/+k
         ZpTFLPxHGHL9SQaKN+fJ0mS+v1DvHhfQlxHaBtGryRYQDK1uN/iKMU9nHr/16/MGCHNZ
         RIBhtDhNVMdd804VmwBlru4UWMO+p0FI7UQ8T5FAmL20wr7mBnkiPcBH5WhaNA6GJvfh
         QIwm+zNaOwr+I2Gdo/NBxN3hbucVvRymiImBUNijdxhtcC04TGS7b2516vtz91xaY266
         +65bd/cibyLdGKragHZ5WAF3FQ76n4uWkDo9X4obNLU9aa4lKiJlV9u8q5GYpUdseujC
         fPEQ==
X-Gm-Message-State: AC+VfDz8rxEvvxKThu03/UJdKtFhO2tdDGyNIDSMx19zcjJYiNFNs/Pe
	fUL7EDQlgKhA/pYDzGRkDKLUOeLwVPg=
X-Google-Smtp-Source: ACHHUZ4OwoCogl0kUT+AQdf2OrDi130S3kFb6VrDTG+kWbd05oJ14dHJ+W3JhryO51UA7d/YhrgwZw==
X-Received: by 2002:a05:600c:4f47:b0:3f1:7138:91ee with SMTP id m7-20020a05600c4f4700b003f1713891eemr10751301wmq.2.1682946872113;
        Mon, 01 May 2023 06:14:32 -0700 (PDT)
Received: from [192.168.64.192] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id ay37-20020a05600c1e2500b003f18b52c73asm32239070wmb.24.2023.05.01.06.14.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 May 2023 06:14:31 -0700 (PDT)
Message-ID: <dec2142c-4e9b-454d-f1d0-9c83ec87ec18@grimberg.me>
Date: Mon, 1 May 2023 16:14:30 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH V2 2/4] nvme-core: fix memory leak in dhchap_ctrl_secret
Content-Language: en-US
To: Chaitanya Kulkarni <kch@nvidia.com>, linux-nvme@lists.infradead.org
Cc: hare@suse.de, kbusch@kernel.org, hch@lst.de
References: <20230428073115.22987-1-kch@nvidia.com>
 <20230428073115.22987-3-kch@nvidia.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20230428073115.22987-3-kch@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230501_061438_936376_A589D5C5 
X-CRM114-Status: UNSURE (   6.54  )
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

