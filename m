Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3C05C4332F
	for <linux-nvme@archiver.kernel.org>; Mon, 12 Dec 2022 10:17:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6pnIjC9qsdK0Le1mAgqedaHcbcDGAZ609PvndR9z3Og=; b=4nyrxrlmomKXrjUmeUCep+AVCL
	6Weqg3em+HNNxunyosdrR2miR7BvEUH/kJ0sCOK9huArGOAF0rt+xM5VyPdfBswRy1fKvkneoR3ak
	eaSJjcIuHD207Fz4UB25kZ6Sd1ATqpJCZf4oNlUbMDB4sez0tLThHuSW9QBDwxR/x8HPX6cGX2bak
	rRaxi686GoudOKjQnLXN/y5iVeT+g5Fy9Q6iHyNOsUZZcQm3Y06ak0hLbqZ9+Ml4FdduRnhkqW4Xs
	stO4TY6HpijgakK4rzYAnbLiLxMupiMfphUcWRykCROLQqKZb8eEn8vkMII4BzTovQ1jQPysaufXZ
	bEO+TWcg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p4fsK-00CV1m-1h; Mon, 12 Dec 2022 10:17:32 +0000
Received: from mail-wr1-f47.google.com ([209.85.221.47])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p4fsD-00CUPx-Jl
	for linux-nvme@lists.infradead.org; Mon, 12 Dec 2022 10:17:27 +0000
Received: by mail-wr1-f47.google.com with SMTP id y16so11547332wrm.2
        for <linux-nvme@lists.infradead.org>; Mon, 12 Dec 2022 02:17:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6pnIjC9qsdK0Le1mAgqedaHcbcDGAZ609PvndR9z3Og=;
        b=h0ozaQKifHvMdVI5tzcxRTHYY6Kj9qwj2BfpQhc914d1A9tvi9dRQKO8MLZ4Hc2PMC
         4OeKrO5TTuHr2bEkjSh3WW4qgOr+WbguvaWDO8eocK7pE5CMfSPxyWz8/yo+su8nMlv3
         hfRo0bhyjm8+GEbx5Q95iqOKYnkDE++NLtfJCDkTfikU56RIVvNjtNxhAM4p8eutkPwV
         b5S1GWHchOWR5vGcVm0hUpzJvwZu/JedzKFYsvR7ZPSt45uUM3Penuq9srTNzWaacwx5
         69tdUiyPsuk5rnKb/qpizzZLtbgkJSm5wPz+7SLJejnbEMbcxqD6hGQqVl0q4g8Plz4v
         k6oA==
X-Gm-Message-State: ANoB5pk6g0ao0erv+wsYBNzc0QrkxkX8tprqjJBNlB+rhTctCGV0Y+VP
	8mNH3lGbe8qPh2sbC9Hb6+N9DmpfBbY=
X-Google-Smtp-Source: AA0mqf4mYbZIv1LMLBszelsA1t7ZhNvujv5gn6imhsvu3g2vv0hxE7wdcXPuh4exMq0I4UZUY+O8/A==
X-Received: by 2002:adf:e708:0:b0:242:728a:fa7 with SMTP id c8-20020adfe708000000b00242728a0fa7mr10255498wrm.61.1670840239982;
        Mon, 12 Dec 2022 02:17:19 -0800 (PST)
Received: from [192.168.64.178] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id n11-20020adff08b000000b0023662d97130sm8563224wro.20.2022.12.12.02.17.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Dec 2022 02:17:19 -0800 (PST)
Message-ID: <62541ab8-d173-d658-9e1a-28c7ccf5104b@grimberg.me>
Date: Mon, 12 Dec 2022 12:17:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] nvme-tcp: add additional info for nvme_tcp_timeout log
To: amit.engel@dell.com, linux-nvme@lists.infradead.org
References: <1670410707-2278352-1-git-send-email-amit.engel@dell.com>
 <1670838149-3147431-1-git-send-email-amit.engel@dell.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <1670838149-3147431-1-git-send-email-amit.engel@dell.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221212_021725_685945_99487AD0 
X-CRM114-Status: UNSURE (   7.53  )
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


> From: Amit Engel <Amit.Engel@dell.com>
> 
> This provides additional details about the rq/cmd that is timed out

I think that you should separate the patches to add the fabrics opcode
string and then another patch to have nvme-tcp call it.

Also, please make sure that this is fine with/without
CONFIG_NVME_VERBOSE_ERRORS and provide example log message for
each variant in the commit-msg.

