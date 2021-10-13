Return-Path: <SRS0=KS3B=PB=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAF3DC433F5
	for <linux-nvme@archiver.kernel.org>; Wed, 13 Oct 2021 11:49:33 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A84CB610C9
	for <linux-nvme@archiver.kernel.org>; Wed, 13 Oct 2021 11:49:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org A84CB610C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=EnlpFBr4ldsEYdTWBNvHAUFVmiRjTr9fPn7cEHVgDLQ=; b=nPqIoG6iYR+VpFfb8mXMqRzfVU
	FA8LSvngAKq/IN4fgSeo3Xxf68mI+oraJ/zWlWReCxxLmym1rd7dJvGcz4wjASgI1PjPUfsGjkepH
	pFjtVKW6cbCtbepW1e6Q5w9B9XqXCPvhfIk0YRNbqUUyh42EzyucBqvgYlrJ3fbtK8rZTVZhgSdNM
	g/L+e915uYvDWuqbrn6oLg/Td3G7k+JGHxtDeUnc3BFM8kyJHwjEEoSuCNV6JN+qCtyIO/jT6tDoL
	z05a6gpJZSSKQeAQMgRuTgQQW/tGHJs2pk2MRZnXyJjFBnvWmOofSJaHe2Okx23KWBPlyEmtLlA04
	7sZDgKBw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1macky-00GOnu-Dd; Wed, 13 Oct 2021 11:49:12 +0000
Received: from mail-wr1-f43.google.com ([209.85.221.43])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mablB-00G53u-OT
 for linux-nvme@lists.infradead.org; Wed, 13 Oct 2021 10:45:22 +0000
Received: by mail-wr1-f43.google.com with SMTP id r18so6794972wrg.6
 for <linux-nvme@lists.infradead.org>; Wed, 13 Oct 2021 03:45:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
 b=PSL7Eco0L7VFbK0i+XGyHKN4blY25oU+jxbjfDzwb2WTLdCLXYV8VaQgEOU7lPTOE9
 U3sOGwCP1otIqRIxnR48S1G3QYhqr0VIvW7vKkPqF6SAeq1NdW1sqE1hjvlsYFldKOrW
 GKA/N0fy4zfbtBTw1IwmQSSLMiH3oKotVlrYjYeR7H0A/kYiTbqL4Zm27hIflWLrD4us
 LmWPsPA3p5sLd8ESBe7Fsut9V+kKjrZbDEdn5PtCzWLviZIyfUAnHPBVM9i05obZfm4z
 9GukIDjXzInfbQ0+3bAvKWXp9MHu8u1UEg92AkVKWMEz3HsiMFyY+vRdvC8RaKh1wMBo
 RgHQ==
X-Gm-Message-State: AOAM530HvW4Jt2jBvi0z0iWkH0a+1HFIg+XAbfJfsVB4shF5mRwx1tXc
 NzJpDSG1Fsy56wgzRhtLEVaB8csmEiY=
X-Google-Smtp-Source: ABdhPJzFGLQQR+jCHOC/JN9A5sELSOjwRWhKAofThGBfU5bCj3NNbGzvUwR+owUYLDkIWq3WKwyGew==
X-Received: by 2002:a7b:c841:: with SMTP id c1mr12124684wml.40.1634121919984; 
 Wed, 13 Oct 2021 03:45:19 -0700 (PDT)
Received: from [192.168.81.70] (bzq-219-42-90.isdn.bezeqint.net.
 [62.219.42.90])
 by smtp.gmail.com with ESMTPSA id 73sm5210720wmb.40.2021.10.13.03.45.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 13 Oct 2021 03:45:18 -0700 (PDT)
Subject: Re: [PATCH 10/16] io_uring: don't sleep when polling for I/O
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc: Jeffle Xu <jefflexu@linux.alibaba.com>, Ming Lei <ming.lei@redhat.com>,
 Damien Le Moal <Damien.LeMoal@wdc.com>, Keith Busch <kbusch@kernel.org>,
 "Wunderlich, Mark" <mark.wunderlich@intel.com>,
 "Vasudevan, Anil" <anil.vasudevan@intel.com>, linux-block@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-nvme@lists.infradead.org
References: <20211012111226.760968-1-hch@lst.de>
 <20211012111226.760968-11-hch@lst.de>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <f26eae8f-266b-e173-6e9b-b4f01517a603@grimberg.me>
Date: Wed, 13 Oct 2021 13:45:17 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211012111226.760968-11-hch@lst.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211013_034521_822802_1907A2A6 
X-CRM114-Status: UNSURE (   8.67  )
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
