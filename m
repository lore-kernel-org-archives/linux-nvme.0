Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63B4EE7D27E
	for <linux-nvme@archiver.kernel.org>; Tue, 26 Sep 2023 19:55:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Cx3P9XMJrUWs/rcJWQ9bHQisSJ4667Rmi6WpZzvHcL0=; b=eHQeHncvN6y2s79OHxEQQ3Juk9
	GH3Ku43W5AdNQkIZxsK/LBivHX6+OO3fiyyUOdyrKuv3qW0GEouq49eFFsy5PQ3a77hto0sAaFw2j
	bKw1dPZPXMs62To6gCLxmifo6wu3owJwdJDb3AfYazbg9YThpNkuioMDqBBiFr4IC0EGieXXMaJ0T
	M9Fo4EJtF8O26PSdRcwliaOJyyQM2dX0+i78bk8H8d8NA/SYJee/89oOvfqrSwnjcOeWRbiPKWXTY
	nHIf5ZP87ZkNjMrBVnTqwOsylcfS1yam0J/CrJ3eazuUsXDXdECahaguPv2+mYrRLgThKfhIJQytN
	Bab4yULw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qlE9U-00GxVc-2L;
	Tue, 26 Sep 2023 19:55:24 +0000
Received: from mail-wm1-f50.google.com ([209.85.128.50])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qlE9S-00GxUu-1A
	for linux-nvme@lists.infradead.org;
	Tue, 26 Sep 2023 19:55:23 +0000
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4053e6e8ca7so23816785e9.1
        for <linux-nvme@lists.infradead.org>; Tue, 26 Sep 2023 12:55:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695758117; x=1696362917;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Cx3P9XMJrUWs/rcJWQ9bHQisSJ4667Rmi6WpZzvHcL0=;
        b=S/0SRV7FgPV9PrQ6LmkcbdPFREn/cSivzeX40aVFFr+T0g4WFk4Dsn9F+2+pst+pTI
         ai7tM5DCu2ikeEe7iVk2im77ZlfaD8rZ58p4OizyOlix5hlWQdh+5lWUWOPOTFi8vx7X
         Vr1Lrlxp5Ca0J7ReSJdwj616NDskoLxb166OCOyFPTiEH3aMAWqbbxCGI+sOgzSlDy/4
         QXxDqztVA9HVCd2EoCBQjjoI5Ju9Q73rgzWBWfDZWXG2Jfva3hR34V5p5iKaYNsaPVkf
         2tGZdSmxKv+RETeyLi+NgkwALtKaaWWwxnsyNp767A6RpstSJ4ilTasmChAIrbA6lb0v
         lj9Q==
X-Gm-Message-State: AOJu0YxDoQJqG0ZBjnqqyPqk8qaEVMb19SLiB9GJWdyYrRdcrYgfND5Q
	HdHdYYN5ZUZXD0MCLVPrNEY=
X-Google-Smtp-Source: AGHT+IFXNKdjd1NGv/IuiM7qzfv/r8HWdZCSufDFGqBU8Zq1onz7/xYA0lEqCceiUKgF7NgIBoX+MA==
X-Received: by 2002:a05:600c:4e05:b0:405:3cc1:e115 with SMTP id b5-20020a05600c4e0500b004053cc1e115mr9594967wmq.3.1695758116659;
        Tue, 26 Sep 2023 12:55:16 -0700 (PDT)
Received: from [10.100.102.67] (46-116-234-112.bb.netvision.net.il. [46.116.234.112])
        by smtp.gmail.com with ESMTPSA id n14-20020a5d400e000000b00321773bb933sm15558190wrp.77.2023.09.26.12.55.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Sep 2023 12:55:15 -0700 (PDT)
Message-ID: <709e6baa-8ac5-4f2c-984b-0d7b06deb7d0@grimberg.me>
Date: Tue, 26 Sep 2023 22:55:14 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvmet-rdma: use spin_lock_bh() on rsp_wr_wait_lock
Content-Language: en-US
To: Chengfeng Ye <dg573847474@gmail.com>, hch@lst.de, kch@nvidia.com
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230926172208.55478-1-dg573847474@gmail.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20230926172208.55478-1-dg573847474@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230926_125522_405327_50092471 
X-CRM114-Status: UNSURE (   8.68  )
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



On 9/26/23 20:22, Chengfeng Ye wrote:
> It seems to me that read_cqe.done could be executed under softirq
> context,

It doesn't though.

>   as done callbacks always do, and it acquires rsp_wr_wait_lock
> along the following call chain.

The CQ polling context is IB_POLL_WORKQUEUE, which does not
run in softirq.

