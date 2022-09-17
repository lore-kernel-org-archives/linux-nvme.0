Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92737ECAAA1
	for <linux-nvme@archiver.kernel.org>; Sat, 17 Sep 2022 16:50:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=OD9XT4CR5VyRMAIbcP4aYEY263YSrvWXbcu+RkRlk4I=; b=VUfdOY/Aw85h4L8UcuIs7q74fy
	/tlkTJYEKW3EQZfL2EpkdKqV9OGubH+gmD/mdD89/zqbRSxH9+7IC7dgDvRpT83tA+g6cfLie/NBt
	fxFPjfUCid45tguTJdminD/SKS7OhL76M1H526xo8PmpT/MC9BDdA2lR/+9MHd+i3yNYypUNtF8Eh
	d2XopbjrMFDlQur1hDnQHmQLhe/2Euq9/9OQD5HFvLk8TRPXalEW5NGjlVXovnrA3H+sHBHGyTTAh
	xKE9dyuwFy/fo3EHna1rxPXedFu7VnfadE4A6mb7tmbSxFPYur6TNQ2AxpXMFTAxFRyIckwbXjDz0
	oP0v/7vA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oZb1U-007Kpd-7g; Sat, 17 Sep 2022 16:50:32 +0000
Received: from mail-io1-xd2d.google.com ([2607:f8b0:4864:20::d2d])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oZb1R-007KoP-UG
	for linux-nvme@lists.infradead.org; Sat, 17 Sep 2022 16:50:31 +0000
Received: by mail-io1-xd2d.google.com with SMTP id z191so19830301iof.10
        for <linux-nvme@lists.infradead.org>; Sat, 17 Sep 2022 09:50:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=OD9XT4CR5VyRMAIbcP4aYEY263YSrvWXbcu+RkRlk4I=;
        b=aRVZwMRSorHTW051GLhPP5Qn0nfy4sTH/jVXgVHI2zdJhX3AmR/VWE9Iuzm5lWp2gq
         +valD+bvQ2wXpLZb6szOuIDOjN2wXk1hczGfCJdwLafcqN3YXhvgXEFNZjhtvqC/AW/4
         EP8w8J1PrOytikqdxGIjKCk1/pKpII+4tJBeOVFTyKFHoOvkv0yl/ovrwZlAht2xgnFb
         gpSTV4+AYsHqTqXbGIkbzsKqnobAfG38uw6Bm17b+52rpKqe67akJpGHCmKzvCBf78oH
         l1/kdR3eaVApM2K0W4aIaQPchZYlnFHrfsRLPfBRtIhsN088GAVllZdte1QuA5U5ZQwK
         FQTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=OD9XT4CR5VyRMAIbcP4aYEY263YSrvWXbcu+RkRlk4I=;
        b=qSdH/0/WjslV0VZ+rUUVgZiYt9pQWkRwyM5q+FZfuXDurAsEkExz+2YUYA0YpZoAhq
         G98QLrUCL+EYgbxYx10WC9k4gwSy71rzJIXYzYoFtDHs4S/8a8B+mNgL8ui0rU4YE9v1
         VxgJrrH1steMESKJIdrUB1Q5A/T6lzlrPfOgjwGuqp1d5xUa26cKbZmDLZut9h38oNyS
         wHFT6ZRegl8UXJ3L7N8B1sV0eptmXeC5+n1gcmcgFnLROE5JBntlD9uuBL8Rxih4M+Ml
         zRuoIMbEm7m9lzT9pN0PzN+iQUMPWCPtCBlNQmhKBPEdaDnVFD1eb3wTTCsNiLNMNrR+
         5SDg==
X-Gm-Message-State: ACrzQf35aTTA+Gk9z0Gn+PigpZkIYFCT3YNNA4PJo/AxwGRHIRqyyQTT
	Yy4rgqEEwoP1vbVyrPadoO1oLA==
X-Google-Smtp-Source: AMsMyM5nlAPcgFEuypzcXVI6oequYsaj02FmYE5rWtc2/Q4m94D0ndSgXO8fPwVmq/KM98zJpYMKFw==
X-Received: by 2002:a05:6602:15ca:b0:66d:9f5:4535 with SMTP id f10-20020a05660215ca00b0066d09f54535mr3999054iow.66.1663433428208;
        Sat, 17 Sep 2022 09:50:28 -0700 (PDT)
Received: from [192.168.1.94] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id t14-20020a92c90e000000b002f5024d8543sm1580861ilp.38.2022.09.17.09.50.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 17 Sep 2022 09:50:27 -0700 (PDT)
Message-ID: <d8e43495-0959-2b47-b0af-be46d7ad57ea@kernel.dk>
Date: Sat, 17 Sep 2022 10:50:26 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [RFC PATCH] nvme: request remote is usually not involved for nvme
 devices
Content-Language: en-US
To: Liu Song <liusong@linux.alibaba.com>, kbusch@kernel.org, axboe@fb.com,
 hch@lst.de, sagi@grimberg.me
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
References: <1663432858-99743-1-git-send-email-liusong@linux.alibaba.com>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <1663432858-99743-1-git-send-email-liusong@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220917_095030_219144_9D1D5C1C 
X-CRM114-Status: GOOD (  10.15  )
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

On 9/17/22 10:40 AM, Liu Song wrote:
> From: Liu Song <liusong@linux.alibaba.com>
> 
> NVMe devices usually have a 1:1 mapping between "ctx" and "hctx",
> so when "nr_ctx" is equal to 1, there is no possibility of remote
> request, so the corresponding process can be simplified.

If the worry is the call overhead of blk_mq_complete_request_remote(),
why don't we just make that available as an inline instead? That seems
vastly superior to providing a random shortcut in a driver to avoid
calling it.

-- 
Jens Axboe

