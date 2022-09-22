Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DE64C54EE9
	for <linux-nvme@archiver.kernel.org>; Thu, 22 Sep 2022 22:48:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=oRYxZWuMJqZP+RSfxY545W8pMThXDlFMSil0ZVU3QEw=; b=j3H2g7Dw1+VUV1GJU0vdhfoOTQ
	b3w70S4NgGQwBLWKpit0cfxwxSj5z8teYS2vx+8ZvHGWZFWMuHW/J8cc4HRzvp2m6sqcFusAI4uYT
	bSC3qLDw2ZJkXsyH5o2E61IIL9vxT9K6gYWxa3yygMjwJFPTy4Y0iFCzdbJQP7Y76Ul9XO9qDZzeF
	WsujVTyL4jMcPvA3i0z2wiRQMKY0rwOmVPoyHsGt8PkuHSIwS0Lw1QseQ8XXS1+3p8TNgX3UfWxDv
	rfdJ09M6dro7tBLHW+lAGaTcbdJnd4nsP2/bN8b+Oqi9FG+RitkHDhKdSynkmBU6ZUQULO5KU1hrk
	48uy2cMQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1obUzs-000VmY-2U; Thu, 22 Sep 2022 22:48:44 +0000
Received: from mail-qk1-x72d.google.com ([2607:f8b0:4864:20::72d])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1obUzo-000Vlq-Qu
	for linux-nvme@lists.infradead.org; Thu, 22 Sep 2022 22:48:42 +0000
Received: by mail-qk1-x72d.google.com with SMTP id g2so7281730qkk.1
        for <linux-nvme@lists.infradead.org>; Thu, 22 Sep 2022 15:48:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=oRYxZWuMJqZP+RSfxY545W8pMThXDlFMSil0ZVU3QEw=;
        b=gL9jLciTGmSP5jtdiLvt5D6r++FT4JdyYsoClCY9nzzIlufXDeVsKu5xs7R3hBsKQc
         Xlv95Kr1F4EsfWmG/i6uiJcywxCjKPjxKU8OZLmr1Ek2QZl2G+TZ5tyWIRPfvOGwMCVD
         kyYkEoXbiE7U9picefLtTPANRH7cfbrxQF9BdIf7H0UxXdeChOIMfOSk2q5ZRKCqruiP
         9I5i91mLKvg5F6WlmUQZaxktmsKnxyTW5jajqv6EJ90sgydcW3E+aYbqmBwuqhstQ/qJ
         FysDh3gKufEQhTKus9C06NdSb2/UVsTLfXVNiuByp8cYdiZkP2SRt5wlbH0N3rXgiN2Y
         Mvdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=oRYxZWuMJqZP+RSfxY545W8pMThXDlFMSil0ZVU3QEw=;
        b=wo7lfSmv2Q/5tPfcpFC8jwqAwn3ueK5J0nLjeQzOm28XUqlsUxCUMlMvzCGHBQlv4u
         0wcolzFhHi3MoNapRRL9x8m8R4Mjrek32L0QzGaIywUIzrltFzdvnURJGP3uwVM+wvZA
         /ZtWLv97VaswOozz53yFuwH5AMoME7GvXefOsPmeqDRW3oMnXGspBMlbmRHfzKfkxd5Q
         iZowvCXdc7BN8wXP+V+Wmm886noHVuiB+NtI3YTcrPQoH0S+7p/ea3qIdi6u1gVFvy9r
         crjbRjJjwf7bOeYbyAG7lqb08YHd1kxFaLfVjcY0fumZ063tpCnhS9Im4m0l7ix7VThl
         7owg==
X-Gm-Message-State: ACrzQf3TkqHbf3YGXiX1vFMuukEO2Y6FYQlO9GOS1bAPFJlV95LdzsiJ
	ERMxxm0Kc+fdfgy4W3MqGY0=
X-Google-Smtp-Source: AMsMyM46oxEO/nKNtIjsWbm04nrVYgAg3KqlE38JmLyV8AgZJj4alLKm3hOL0/MHGZBUnaIsWZKvOQ==
X-Received: by 2002:a05:620a:2844:b0:6b8:8cc3:9387 with SMTP id h4-20020a05620a284400b006b88cc39387mr3918430qkp.615.1663886919364;
        Thu, 22 Sep 2022 15:48:39 -0700 (PDT)
Received: from [10.69.46.142] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id h12-20020a05620a400c00b006bbe6e89bdcsm4892145qko.31.2022.09.22.15.48.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Sep 2022 15:48:38 -0700 (PDT)
Message-ID: <eeed4ba0-de96-5be0-8ef4-9982a32e6c35@gmail.com>
Date: Thu, 22 Sep 2022 15:48:35 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH 07/13] nvme-fc: keep ctrl->sqsize in sync with
 opts->queue_size
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
 Sagi Grimberg <sagi@grimberg.me>, James Smart <james.smart@broadcom.com>
Cc: linux-nvme@lists.infradead.org
References: <20220920171611.1289361-1-hch@lst.de>
 <20220920171611.1289361-8-hch@lst.de>
From: James Smart <jsmart2021@gmail.com>
In-Reply-To: <20220920171611.1289361-8-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220922_154840_919913_44ADADE5 
X-CRM114-Status: GOOD (  12.72  )
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

On 9/20/2022 10:16 AM, Christoph Hellwig wrote:
> Also update the sqsize field when capping the queue size, and remove the
> check a queue size that is larger than sqsize given that sqsize is only
> initialized from opts->queue_size.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   drivers/nvme/host/fc.c | 10 +---------
>   1 file changed, 1 insertion(+), 9 deletions(-)
> 
> diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
> index 42767fb754552..ee376111f5610 100644

Reviewed-by: James Smart <jsmart2021@gmail.com>

-- james



