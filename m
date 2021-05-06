Return-Path: <SRS0=D26X=KB=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14BA2C433ED
	for <linux-nvme@archiver.kernel.org>; Thu,  6 May 2021 09:43:10 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 93DFD6112F
	for <linux-nvme@archiver.kernel.org>; Thu,  6 May 2021 09:43:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93DFD6112F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=EnlpFBr4ldsEYdTWBNvHAUFVmiRjTr9fPn7cEHVgDLQ=; b=V2BY9azTfIUaJdYOMT892GbXC
	SF+S4fadZpvjEuIxRAOUmf1avdEe1AUuxBLd0pf+L8Xo1z4zF3gWRjpjuTqEs6Tms9Hx+LfR9w5KC
	VJhRzVZyqmRqFtzRtQHZPpIZf1KvGqFsQ4J08tV2Fqn6u3cLZ1DNiTUbpnaQNAklhKwesPlz8j3kg
	uTm5w9Es+76q5YyEW4W5wuNHqzPobDAQfi1FOBFhyCkARNf7AXQGEA3Xk0TRTdHyP1mSxWpYXkRLf
	bVKPgb8VEqdd9LPAWo7FfhlZ1c76JMVSipdUIvjxMowyT2NO0A5bjpe8EBzIgweHWABYACnzoenUW
	8/mtTA2Ag==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1leaWs-003qaw-SI; Thu, 06 May 2021 09:42:46 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1leaWK-003qRl-RB
 for linux-nvme@desiato.infradead.org; Thu, 06 May 2021 09:42:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
 Subject:Sender:Reply-To:Content-ID:Content-Description;
 bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=jc2jwEkJY1621RDnToT4FoWyGu
 SMHugoCFGJzuYsynGa5OCpg6a49xwPBfip0ipkcB+vWTc8ioXl4pRFa50JAzmu9NwcP/MikECFh7m
 9gl1m8VINa3nJCciXhvzDYD5RA7sHBapRmblxZwylEr1gJPtcK2UYitod83m1pdf09cwv8ihh+9Oh
 HS8+RQ35CFH5PBIs5I1oSUk6iV2q71gewVudJvCWDDf3U4UGTQFq9+vfNCr+xUWZrSI4qaMj33LPG
 8R7/fL8VFkQmr+/GzWX+z/yJ9BTcG0dIHv5eDCr5YyMoQa009kn2SXf/LORJ8wq+OdogKmlNzjHTy
 OTWj073w==;
Received: from mail-wr1-f44.google.com ([209.85.221.44])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1leaWI-005v2K-Fg
 for linux-nvme@lists.infradead.org; Thu, 06 May 2021 09:42:11 +0000
Received: by mail-wr1-f44.google.com with SMTP id v12so4869349wrq.6
 for <linux-nvme@lists.infradead.org>; Thu, 06 May 2021 02:42:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
 b=B2ji3gHcO7evDNBfBhxvyjb+YWmrlpanBAbV8e8JvrXUfVuauEA6aB8dmpuEGaYUM/
 kVFbuEEf2ZLoNrqei5W44wTcPbf7CR2eLjJfzINh+d7NDrNNiTmbeXchpv/XSPffZ+Jz
 selAekY4tJjv1EMjoG48OYBCmkMKqFMH/hrMAIIjUsYxqjoQhdrunOof1XGueUoZNYNn
 g/rgg2TCWtGvMVxmQpNkdJQowo6qORG9+hEMSdFlvOfB1WYz9x2snY9lTL6ZpNsjU8zP
 cmc2NU+hIyqxt8GIIzmP2msPhKkTqCAfRiqfopq0B5HWpwST0/sX21mDAx3ascf1T4mz
 Vx4w==
X-Gm-Message-State: AOAM531YKXIjg3RtKcHXMlxvY4XF7bi8ftauE0LOYtsLPFFglkCRq7cB
 a2VnLN4EJ2eE2RaCwhHDDGc=
X-Google-Smtp-Source: ABdhPJyUaqjAz3GRAiEx/ZRxrbT4E3AIC/Ncv/qVtgCa9NjThK9ECW54mRRUyP9vmj5C4k0L29EHAg==
X-Received: by 2002:a5d:55ca:: with SMTP id i10mr3858464wrw.299.1620294128513; 
 Thu, 06 May 2021 02:42:08 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:e504:8c1:c1db:d524?
 ([2601:647:4802:9070:e504:8c1:c1db:d524])
 by smtp.gmail.com with ESMTPSA id f6sm3983347wru.72.2021.05.06.02.42.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 06 May 2021 02:42:08 -0700 (PDT)
Subject: Re: [PATCH] nvmet-rdma: Fix NULL deref when SEND is completed with
 error
To: Michal Kalderon <michal.kalderon@marvell.com>, mkalderon@marvell.com,
 aelior@marvell.com, hch@lst.de, yaminf@mellanox.com
Cc: linux-nvme@lists.infradead.org, linux-rdma@vger.kernel.org,
 Shai Malin <smalin@marvell.com>
References: <20210506070819.12502-1-michal.kalderon@marvell.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <7290ab44-130e-1723-af23-8a5336b72334@grimberg.me>
Date: Thu, 6 May 2021 02:42:04 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210506070819.12502-1-michal.kalderon@marvell.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210506_024210_547588_8249F6F7 
X-CRM114-Status: UNSURE (   8.53  )
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
