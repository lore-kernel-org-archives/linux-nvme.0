Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E031ECAAD2
	for <linux-nvme@archiver.kernel.org>; Sun, 28 Aug 2022 14:37:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=j3ld8khRORRAqap17P1bfZL7VX
	2zVpuNryL8BrGY8iEorPYj3drAHfZ0F1Homl0YpmDxrkvtLKIjlN/P+ViOX4Ymn2d3Hf7j1Of84jm
	w3/jBxMDFuEHimyBEUefBAAAquIrxU1eFPUUu94pcnpO6HTmzUalktbhv6omDnmt6dJ0Vlsj+AsS9
	scXGLu3C2HMXnmwLQuZNibNi9T8HKZ6RbsXnzi5+PMlW1BHcbhj44t4viX/3pPK8M3a/JuiZNAEK3
	ao6Z9qPy6IV7pN76qJkAi5BZPdT9UpVd8d7JixBxjBPbsVXb4bJ0UWI8Omn0AX46tTDT5y2PeeX7J
	vefFebRw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oSJPt-00HYeo-D1; Sun, 28 Aug 2022 14:37:37 +0000
Received: from mail-wr1-f41.google.com ([209.85.221.41])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oSJPq-00HYck-GV
	for linux-nvme@lists.infradead.org; Sun, 28 Aug 2022 14:37:35 +0000
Received: by mail-wr1-f41.google.com with SMTP id e20so7214499wri.13
        for <linux-nvme@lists.infradead.org>; Sun, 28 Aug 2022 07:37:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=S/ZPvR+kvr6TgEvx8swWzJvhhpXtdykfoK7YiSR3nCLILUBSRk/gtj3d/T6Eo8QT8k
         AeMSANnxRu4VqThRXS3cpBNAgYTkKIlw9oXKI4pQupvVMm1Bdc5jAzDQwKs52/mKsxLc
         cnEb6EFrWCzwQCx3Haek97o+ao4xVouXqwRnC9wbKnwg8WSnIajAJ9tQjuT6SziHdxBV
         baBvT2vxn6qZnJPW14oDaYKPmqg3JhIM7HtH3R3w3bzDujMJAwRQMpTWeuwVet8VIiCz
         GRd4zJSWFkmwNtz2JaOj1ZMx2sybVK7aJAG2oVds/rZgsgBoa8uQ39pFSUiJbv7wk6UB
         EOaw==
X-Gm-Message-State: ACgBeo32qREuhSycr4h8uBW9KW4Fyn+5YsuKl74aDRPintyraQWH5H44
	4jNUqsPTN0sD1hj44ThhFqfJpEUSkWY=
X-Google-Smtp-Source: AA6agR7kMCAw1V7f5l3k157HPR+kd7clH0FCjPF4s7zM5FhZY1PFnWBSDCFVmey+CaZVDAxPEOnF4w==
X-Received: by 2002:adf:f592:0:b0:225:2f5e:6a99 with SMTP id f18-20020adff592000000b002252f5e6a99mr4465683wro.593.1661697451895;
        Sun, 28 Aug 2022 07:37:31 -0700 (PDT)
Received: from [192.168.64.104] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id c3-20020a05600c0a4300b003a5f3f5883dsm6795912wmq.17.2022.08.28.07.37.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 28 Aug 2022 07:37:27 -0700 (PDT)
Message-ID: <7e8c4aa6-d95a-d555-943f-064fa01234ad@grimberg.me>
Date: Sun, 28 Aug 2022 17:37:24 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 2/2] nvme-pci: don't wait freeze during resetting
Content-Language: en-US
To: Ming Lei <ming.lei@redhat.com>, Christoph Hellwig <hch@lst.de>,
 linux-nvme@lists.infradead.org
Cc: Yi Zhang <yi.zhang@redhat.com>, Keith Busch <kbusch@kernel.org>
References: <20220821084754.340585-1-ming.lei@redhat.com>
 <20220821084754.340585-3-ming.lei@redhat.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20220821084754.340585-3-ming.lei@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220828_073734_595958_33280FEC 
X-CRM114-Status: UNSURE (   6.36  )
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

