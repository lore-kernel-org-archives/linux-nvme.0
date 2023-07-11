Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04B22C0015E
	for <linux-nvme@archiver.kernel.org>; Tue, 11 Jul 2023 19:48:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=oUzMx8qZuiBmW+xBwTCjnRcQLk96NDgTlsZEGeKbvi0=; b=NUpkqZGZ+TFnizswR4vmk/RHSU
	LUogrUiQ2YfO6lnW/AyaRrHUA6kFVCuPbPAqLtNEhWf9VFPkyNKcytjunqtfewKvZxwHRHpt9Dag2
	r7Ir65ZtDgmErEE03UuzLb9bt5RbPC0j+hbAYB8PS46bHQXmxyjN1xiiCrqYdIFCxGy2ZBukEUvMQ
	lUvOFQh1jSPFDDt7Nz99UYZJcErY2HRpyUGPQJUAWmYaRpvd/6/2RK2cLoqnxFWHWXrnQUQAP9kAN
	Qdps/iFL70xMWlMvJSQLL/9HlAKJiUsQv+zFBwYiU3Z7n/M6ugqg7PJ0hkQEWFMLWnskr+kY7LSxr
	QrtvqRNw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qJJLN-00Flwq-0o;
	Tue, 11 Jul 2023 19:48:17 +0000
Received: from mail-qv1-xf33.google.com ([2607:f8b0:4864:20::f33])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qJJLK-00FlwH-1V
	for linux-nvme@lists.infradead.org;
	Tue, 11 Jul 2023 19:48:15 +0000
Received: by mail-qv1-xf33.google.com with SMTP id 6a1803df08f44-635e5b06aaeso35448996d6.0
        for <linux-nvme@lists.infradead.org>; Tue, 11 Jul 2023 12:48:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689104892; x=1691696892;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oUzMx8qZuiBmW+xBwTCjnRcQLk96NDgTlsZEGeKbvi0=;
        b=kkhmdFxO9iI1/bAqtlgs9AEA1VOmh6KqPS/N5MKjbqk27OjWLOla3jw5KFw77g16cK
         sOakSYlY+Wom2NlqZ9KeLTSCj/cujPdLhymOy98KUhcC42vVsisBrquwqotjS5ouy6pM
         ZjsQPWut9l4/ZEoeQzM+RzfqArNqJyGdDDXEzEq9/s87VsyHsh3ZH+5ReaBJf8SJ3b+P
         XN4fDqNCHy/4EwG72frPJX57NAzj8GhBIk0UP2VpyMLRuuB7M5c1HD4mHuPRPy13VS3z
         PlZyVHCwc03uhZdYMwBB3sZ9io1Muzq0mV3SKTWH6dsZEVxfesMJiUSzgUrOQUTRSg3p
         3KnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689104892; x=1691696892;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oUzMx8qZuiBmW+xBwTCjnRcQLk96NDgTlsZEGeKbvi0=;
        b=bLCadfzbt2TElyXu4ISWzTroNi4BuLJK0O8phDfg5XzjpSaXoYSgsQqA/sU/ii6xt9
         TVWYdse4wIMUVoI66CvXrhq3xPY+SMFQ/dM3HCxr+wFGnb/HBzxjl44Lgm3ifKdLhMOv
         6ZDcZOFOoFRmE6kH7UATyICRFblcgX9Ti9QHe+GJcW34oOS/6vJR38lHrFfsSxjxRaTK
         yffo6v3+Bi5FGiPFj1aQyM8UXspeURoNvHYVNBR+r85uqBCM/Gy4BnIBRMzv5JiSkgq1
         cO6+yg0AJ5BGaKAz0oRYrYsYjuyeDV0V08olIXHQhSlnlUrpuYq+OiSsrJqOECK8vXVK
         aiFA==
X-Gm-Message-State: ABy/qLa1D+KK8YSovVXR+1beqvaKpZg6LnnXfv9/YlyJwUX1Fz5/k/Py
	5/QYnkslKpYKXt60zVBexPo=
X-Google-Smtp-Source: APBJJlGCGFAJmbFlc08Hva6wnCWkZSBhFpP9qYjI2DukIRxQ7eZ7w6ZVmmFFAzARzPPL8fpKevqZHg==
X-Received: by 2002:a0c:a711:0:b0:62d:f096:be06 with SMTP id u17-20020a0ca711000000b0062df096be06mr14190108qva.22.1689104892301;
        Tue, 11 Jul 2023 12:48:12 -0700 (PDT)
Received: from [10.69.46.142] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id n6-20020a0ce546000000b00626161ea7a3sm1465006qvm.2.2023.07.11.12.48.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Jul 2023 12:48:12 -0700 (PDT)
Message-ID: <5900463c-5983-d70a-a707-656363e588ea@gmail.com>
Date: Tue, 11 Jul 2023 12:48:10 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH 1/2] nvme-fc: return non-zero status code when fails to
 create association
Content-Language: en-US
To: Michael Liang <mliang@purestorage.com>, linux-nvme@lists.infradead.org
Cc: randyj@purestorage.com, csander@purestorage.com,
 ushankar@purestorage.com, psajeepa@purestorage.com
References: <20230707212157.1158725-1-mliang@purestorage.com>
 <20230707212157.1158725-2-mliang@purestorage.com>
From: James Smart <jsmart2021@gmail.com>
In-Reply-To: <20230707212157.1158725-2-mliang@purestorage.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230711_124814_502128_19746BBD 
X-CRM114-Status: UNSURE (   8.99  )
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

On 7/7/2023 2:21 PM, Michael Liang wrote:
> Return non-zero status code(-EIO) when needed, so re-connecting or
> deleting controller will be triggered properly.
> 
> Signed-off-by: Michael Liang <mliang@purestorage.com>
> Reviewed-by: Caleb Sander <csander@purestorage.com>
> ---
>   drivers/nvme/host/fc.c | 18 +++++++++++++++---
>   1 file changed, 15 insertions(+), 3 deletions(-)
> 

This patch looks good.  Thanks

Reviewed-by: James Smart <jsmart2021@gmail.com>

-- james



