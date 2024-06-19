Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16369C2BA15
	for <linux-nvme@archiver.kernel.org>; Wed, 19 Jun 2024 09:15:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3XkPhKL+v59TVHhZ9Rit+LBFD4C4IHcE3EoHQOPi/5U=; b=a19rDRf3nyzBeRBdaJ/iSDnETJ
	smYF+8AUHCM3qVdKdri7Kmf48RpqtrGW6VOpR4zm8PNFnZleHekY7RUxzsjo5LtgYYwiX93Y/sRoL
	O2Me1+fR25JahwhDMGjjkchAJGE0MsFgCbjKCUIbozdCPUcHSUiVDX76syeG0Kb/CU+Ztzt6+UGSB
	7ybwexT8VbzYYFHobV5GZzzsJKomIlzNzfDlRM6OFuvN613GA2edsrYSD5uRifET9AmaHpaKpOxTL
	Q6U3N6f/nvbyKNqkoL5XNIdXrKWApbFsriafwKxx2p15P+WFN0ifJr7hGDuQnmtszL5NDr/6iQqc9
	hnKtOjoA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sJrP8-00000000WrR-3T9h;
	Wed, 19 Jun 2024 09:14:58 +0000
Received: from mail-wm1-f49.google.com ([209.85.128.49])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sJrP3-00000000WpG-2dRw
	for linux-nvme@lists.infradead.org;
	Wed, 19 Jun 2024 09:14:57 +0000
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4217f072531so3690715e9.1
        for <linux-nvme@lists.infradead.org>; Wed, 19 Jun 2024 02:14:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718788491; x=1719393291;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3XkPhKL+v59TVHhZ9Rit+LBFD4C4IHcE3EoHQOPi/5U=;
        b=D35mhTUPr2k8fyNMKBZ7bI5Gx/HqHAJ8fj6RVEZCdfp96WwxlTe8vrseYMbPnQVPMn
         o+2v7llunPwO7ErbOJdhQ00r7KeozEIL8cFu4oGE2XDIo6HFMfDl6/PKegOR3w/nGKOW
         GkwNWnND1rJf4gUuFFHduLFfsAyN4+jGH8t+ZpahcNxBQPsGGqB67Iu0m/mLF49GSOqw
         g4cT0KkIiX/AouBoDyfu6Llz+Wpp1siY4N/tWLtEE6YADXUU6hb9E4i1skk3AifCLuas
         ro7ura0a3LuEY0wbu1wV+9w+1H7K5TWppcUzqip6b+kTuGMEzq5mcTgzzlm5iUAn26ps
         uSRQ==
X-Forwarded-Encrypted: i=1; AJvYcCWw+ZVXuX1XNyzV2bpYSStGnsGP3Ar1cOWRG4SgBuuCqASUH+vRZm1PhJQ+bTka6+4k5YsbkEzZ0mxXWZBsMhJHGxCUWCPDOnSHPGkaekg=
X-Gm-Message-State: AOJu0YzeWb6pWQcZi8MnL4szUsdXe2EQ/lPD0yPZcidbqtlA6hQAafOl
	Uh83vIA18SC0MDM8wgeSAIg4nRLXvXr9c2BtMZUvjEJgeVF3MQxx
X-Google-Smtp-Source: AGHT+IEp+nd5YhSsx9fCkGmkYb8QCLmcYR2ayGXZ2Xz6m9wp3Azg3981v+/AoLP0zpKTO3ckc+0DSw==
X-Received: by 2002:a05:600c:1c8b:b0:423:146b:36f8 with SMTP id 5b1f17b1804b1-42478e41349mr4312055e9.4.1718788490893;
        Wed, 19 Jun 2024 02:14:50 -0700 (PDT)
Received: from [10.50.4.180] (bzq-84-110-32-226.static-ip.bezeqint.net. [84.110.32.226])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42306049f1asm181934235e9.22.2024.06.19.02.14.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Jun 2024 02:14:50 -0700 (PDT)
Message-ID: <85c93883-8383-4ed0-b742-cf062bf2a271@grimberg.me>
Date: Wed, 19 Jun 2024 12:14:49 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] IB/core: add support for draining Shared receive
 queues
To: Bart Van Assche <bvanassche@acm.org>, Max Gurtovoy
 <mgurtovoy@nvidia.com>, leonro@nvidia.com, jgg@nvidia.com,
 linux-nvme@lists.infradead.org, linux-rdma@vger.kernel.org,
 chuck.lever@oracle.com
Cc: oren@nvidia.com, israelr@nvidia.com, maorg@nvidia.com,
 yishaih@nvidia.com, hch@lst.de, shiraz.saleem@intel.com, edumazet@google.com
References: <20240618001034.22681-1-mgurtovoy@nvidia.com>
 <20240618001034.22681-2-mgurtovoy@nvidia.com>
 <244b708e-be75-435a-8b27-c48e976d4cdd@acm.org>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <244b708e-be75-435a-8b27-c48e976d4cdd@acm.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240619_021453_742301_E336E6DA 
X-CRM114-Status: GOOD (  10.47  )
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



On 18/06/2024 19:07, Bart Van Assche wrote:
> On 6/17/24 5:10 PM, Max Gurtovoy wrote:
>> +    if (wait_for_completion_timeout(&qp->srq_completion, 10 * HZ) > 
>> 0) {

I think this warrants a comment to why you stop after consuming cq->cqe 
completions
(i.e. shared completions).

>> +        while (polled != cq->cqe) {
>> +            n = ib_process_cq_direct(cq, cq->cqe - polled);
>> +            if (!n)
>> +                return;
>> +            polled += n;
>> +        }
>> +    }
>
> Why a hardcoded timeout (10 * HZ) instead of waiting forever?

Agreed. Is there a scenario where the IB event is missed or something?

