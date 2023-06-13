Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6D0BC7EE29
	for <linux-nvme@archiver.kernel.org>; Tue, 13 Jun 2023 07:56:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=p2TaxpKZ7umvOrpIZ73itBMnZe
	JYJD5u8i+so+DOcIQON4wizMQRH1J5HuYWkisa7Y2/uYq4nVBqUESMPcZe/5zUSsskzAZ/IB2pvej
	aGIxy62AZQRJHhUPvTXSnn4fg/xvyNgPNhVuTUCHXPkq6Rq8AQaVP7NTSfGsfxXMCDG5SqWEFe//5
	ULuFMydmp10CEImMKXoB+6jbC4a8XLopZon4kc3PLw8YaUa6kqW3FATgKZlt0rsPMjX4BHE4PRkAN
	w4QNGCL53d7CRQCZ07jxHBsQVa2RIEvLjsZlA168qGPQrh8ijeLdpZh9HUr7hkcB06JhljO1QAwEP
	gGRCx+TQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q8yt7-007IF2-2R;
	Tue, 13 Jun 2023 07:56:25 +0000
Received: from mail-wr1-f42.google.com ([209.85.221.42])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q8yt5-007IDR-21
	for linux-nvme@lists.infradead.org;
	Tue, 13 Jun 2023 07:56:24 +0000
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-30fc2097239so286083f8f.1
        for <linux-nvme@lists.infradead.org>; Tue, 13 Jun 2023 00:56:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686642980; x=1689234980;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=Om/5mio6d5kzj9UXjGOunoMzdu4TC54NNlyctLMvzCDzbZvwrGaDgxqd/pfY1cuysi
         P0v/znsWFPvzz2QHR74QSLdT5tQh/3enZadlsD0O17KCKnpOHBDwBcFclBb0QI7XenRh
         sobBwRxADlpXCRfADBsnc0Z/jM340Pqbe2rMWEkzBMjaa9Lvq+1U/dqDDOJm7ziik0/2
         KIp5peNw8/bBp2Mcsn3nJZrECMWTGWFzGL2GoxcBeDX6Ke3KMess1PoooeCFc0hSAI27
         YSeM0I19AcKbsvCagixnQ8OtyGdbF9pzixNhlwt82HfH7USJE4m2+1g4vl1xGv3bKB1n
         G2yg==
X-Gm-Message-State: AC+VfDzjJFOwsYdRKRHUKLBm/3aszPf1E16Iczrz+vTvvoDU7rLFZOlX
	1zDuOD8EI5GTYulGqzvsUOw=
X-Google-Smtp-Source: ACHHUZ7O9dcmYzFJL3OuiYarf6djDzTzW8OdZYzqPwx3UJ2mF5Okj1XrEoMhVXJPVtA2/JXM4gYRdw==
X-Received: by 2002:a05:600c:444e:b0:3f6:a6b9:bc87 with SMTP id v14-20020a05600c444e00b003f6a6b9bc87mr9523858wmn.3.1686642979578;
        Tue, 13 Jun 2023 00:56:19 -0700 (PDT)
Received: from [192.168.64.192] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id l8-20020a1c7908000000b003f7f4dc6d14sm13400774wme.14.2023.06.13.00.56.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Jun 2023 00:56:19 -0700 (PDT)
Message-ID: <23f1e9ab-d705-7152-2486-ced4cd34275f@grimberg.me>
Date: Tue, 13 Jun 2023 10:56:17 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCHv3 2/2] nvme: improved uring polling
Content-Language: en-US
To: Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org,
 io-uring@vger.kernel.org, linux-nvme@lists.infradead.org, hch@lst.de,
 axboe@kernel.dk
Cc: joshi.k@samsung.com, Keith Busch <kbusch@kernel.org>
References: <20230612190343.2087040-1-kbusch@meta.com>
 <20230612190343.2087040-3-kbusch@meta.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20230612190343.2087040-3-kbusch@meta.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230613_005623_663844_094D5969 
X-CRM114-Status: UNSURE (   5.56  )
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

