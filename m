Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EFB2ECDFA1
	for <linux-nvme@archiver.kernel.org>; Mon, 24 Oct 2022 08:50:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:References:Cc:To:From:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=18lRdCEX4yLQYFCKAwJMvIINT0nyFi41bx4NPe/PekE=; b=iWmWtCGmWWRNQEJFgI//krZwIX
	bA9hDbt5T88NWfvFvFOesfh3pfadPLaIpnzR1k2QHD/VQkkZF+pJ9BtawqpYRoL4Mw0iTLeS1jlyX
	41lS7K2NbzIxggcEW2gHOxnvFdp+SCWUm/9nOWoV9sP4fjNNhn9BpXTGbkYTA4nX8UKmspVzhuHYc
	sNoAVvX69Zjx4yofy2dVU8WwoeBi0hZzruI4N+q5ixqD3hau6VmHkx3KsFYrNO2NCLntfLDnDBtBS
	95au3N6FdHM/PaRFqgDM/Bv41cui1xdThXR4gTWhajQL//ZluwWfkOz3L4zbLRlemSAscTB7Or7Xb
	dPWBZrUQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1omtAG-000Emc-3G; Mon, 24 Oct 2022 08:50:32 +0000
Received: from mail-wm1-f42.google.com ([209.85.128.42])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1omtAA-000El2-AO
	for linux-nvme@lists.infradead.org; Mon, 24 Oct 2022 08:50:30 +0000
Received: by mail-wm1-f42.google.com with SMTP id jb18so2709361wmb.4
        for <linux-nvme@lists.infradead.org>; Mon, 24 Oct 2022 01:50:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=18lRdCEX4yLQYFCKAwJMvIINT0nyFi41bx4NPe/PekE=;
        b=RvnKEufZXdMt9jBz5fmg4ssi/JUlfApl2sAJEAbPHWqYANijC6RatHTCjfh/DLPojG
         W1DfyRgmDFxZdB6NeH8nuMHKRRj/UBOHxI/RT4ry4ib9pNyWcHr1tu5KcvTxkzNxayKD
         G0oxG0GfNVwUjyt1H2dNtiWMYBSk8Dcqa/usTlBvw3TgHqrc0T0vHCBkgqMNXz0pOsxj
         nDPFGqXvGZmb6rMCfYgAPsyaNoUJKyNeJFtP9Ikn46i1U8oyjNFGBuNxsgzf3Ly0RrTf
         Icv6v4fnn8FMNVvIx3F5MGLcG5RaKmNncNZd0Ny4EOr3PmKztyvmj+iRW4e4WbjCsuuK
         O0qA==
X-Gm-Message-State: ACrzQf3cOfjJ1EpRzghEtuKGAhqlwdl6IZh+js9ghXQe6qjKK96fBK7k
	pXpmAQmRBLtUXvKlkot/p6g=
X-Google-Smtp-Source: AMsMyM55fommkUFOgu8vFZ05nbPW5Or2bLoCsnfUY0atwg+dAF5w8rexofq3CG6mqF5LCUlzBi5d/A==
X-Received: by 2002:a05:600c:1913:b0:3c7:32c8:20f1 with SMTP id j19-20020a05600c191300b003c732c820f1mr11064467wmq.81.1666601424609;
        Mon, 24 Oct 2022 01:50:24 -0700 (PDT)
Received: from [192.168.64.94] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id a10-20020a056000188a00b0022e344a63c7sm26706921wri.92.2022.10.24.01.50.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Oct 2022 01:50:24 -0700 (PDT)
Message-ID: <45eea8bb-7322-6555-8181-40f57c42d337@grimberg.me>
Date: Mon, 24 Oct 2022 11:50:22 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH 6/8] nvme: move the NS_DEAD flag to the controller
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
 Chao Leng <lengchao@huawei.com>, Ming Lei <ming.lei@redhat.com>,
 linux-nvme@lists.infradead.org, linux-block@vger.kernel.org
References: <20221020105608.1581940-1-hch@lst.de>
 <20221020105608.1581940-7-hch@lst.de>
 <ac33021a-b7a1-37cf-b156-df021ac4de43@grimberg.me>
 <20221021132815.GE22327@lst.de>
 <7d93b4fe-f88b-2d2c-e58d-396e03f3bc72@grimberg.me>
In-Reply-To: <7d93b4fe-f88b-2d2c-e58d-396e03f3bc72@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221024_015026_387837_D53D1F5B 
X-CRM114-Status: GOOD (  11.27  )
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


>>>> -
>>>> +    if (!test_and_set_bit(NVME_CTRL_NS_DEAD, &ctrl->flags)) {
>>>> +        list_for_each_entry(ns, &ctrl->namespaces, list)
>>>> +            nvme_set_queue_dying(ns);
>>>> +    }
>>>
>>> Looking at it now, I'm not sure I understand the need for this flag. It
>>> seems to make nvme_kill_queues reentrant safe, but the admin queue
>>> unquiesce can still end up unbalanced under reentrance?
>>>
>>> How is this not broken today (or ever since quiesce/unquiesce started
>>> accounting)? Maybe I lost some context on the exact subtlety of how
>>> nvme-pci uses this interface...
>>
>> Yes, this also looks weird and I had a TODO list entry for myself
>> to look into what is going on here.  The whole interaction
>> with nvme_remove_namespaces is pretty weird to start with,

git blame points to:
0ff9d4e1a284 ("NVMe: Short-cut removal on surprise hot-unplug")

But it is unclear as to why it sits in nvme_remove_namespaces instead
of somewhere before that in nvme_remove()...

Keith?

