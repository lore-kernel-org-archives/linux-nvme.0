Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15A41C6FD1D
	for <linux-nvme@archiver.kernel.org>; Wed, 15 Mar 2023 15:19:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=ESQod+dRcm0hve09oCCpMK/MYq
	nJN0rR5xUio8TkP+47DpDqNyWXhDxSTPfCQbyi3q5STHMJXJvjKZOobUU4uu9FDRuIAeZw2/O8v5v
	+MGJ59kYYSFA0/CnbDYdkmx43JQvZjssZZYR1k0sCJ8S7v3TralFuThRXulhSAI7f/nDIU/2xtrJE
	uJenwZ2aKftbm09W+mAIbbNTk1jOtaIG8x6TEMQ9sSNw9Wzv6a9Uu0Rv0QZekcRduylV4k6ytRwIc
	9z7iHA3Yqb+B/JWjio64z91ILJyC2DkE+W6q1IHSXtmMrWS4ZL2kt27jDUHDFocJ1nQM6KXk7BmOk
	RRKVMimw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pcSu8-00DsE0-0i;
	Wed, 15 Mar 2023 15:19:04 +0000
Received: from mail-wr1-f53.google.com ([209.85.221.53])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pcSu4-00DsBO-17
	for linux-nvme@lists.infradead.org;
	Wed, 15 Mar 2023 15:19:01 +0000
Received: by mail-wr1-f53.google.com with SMTP id l1so17626373wry.12
        for <linux-nvme@lists.infradead.org>; Wed, 15 Mar 2023 08:18:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678893536;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=70Z45LGkeYDXwUJ8tomAZbjuu8dnKcFgTQbRYAHEWGDnHnt8V0PwkaI7GmdvEgErUC
         00SqIcVbW9RDL7n2POpQ98/t9bAHIFtiMrStmAS5hoDA1R+JSgfeL8Y65pbT27XPG80N
         DyW6liY04hmyel7L/ybK3jhTACVHL2zGAGj9JjKspl+OlE5ZmS0dfx3oT2g+ypdDWW0e
         Z5oRCgOYcL7FEVMyreh0tbx5fVwABY8/xQwJuhdtX07qnqPTP3T4pIBQadeamR7TuZxF
         K3Zmfqgj1ILtifV6lRvXS1PCu8K5e+ypiGn/ycSjD26P/CCDT76BgC0y4NqX7Hhw7MFx
         iHVg==
X-Gm-Message-State: AO0yUKVXSPbRqmHYIjkikvLQ7NEw/Jl/tWsOMoTBjPQE5tW+tuWosvd7
	Cw6xoqI3r+LKapPI9DYWyH4=
X-Google-Smtp-Source: AK7set+Rv7+1NC0PdZWWzntPLCMY/S0Vb6F+JwuQ4Q+KkJ4ZZTGLKH1OM4HsZgLdC/vFqJuM6siXkQ==
X-Received: by 2002:a5d:6041:0:b0:2ce:3679:5169 with SMTP id j1-20020a5d6041000000b002ce36795169mr11940186wrt.6.1678893536314;
        Wed, 15 Mar 2023 08:18:56 -0700 (PDT)
Received: from [192.168.64.192] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id o11-20020adfcf0b000000b002c573778432sm4847608wrj.102.2023.03.15.08.18.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Mar 2023 08:18:56 -0700 (PDT)
Message-ID: <1ce8b9ff-24d8-4576-7432-0ab2bfdc5375@grimberg.me>
Date: Wed, 15 Mar 2023 17:18:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 1/2] nvmet: fix Identify Identification Descriptor List
 handling
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, Chaitanya Kulkarni <kch@nvidia.com>
Cc: Damien Le Moal <damien.lemoal@opensource.wdc.com>,
 linux-nvme@lists.infradead.org
References: <20230315142032.507083-1-hch@lst.de>
 <20230315142032.507083-2-hch@lst.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20230315142032.507083-2-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230315_081900_405422_A8C9CBBD 
X-CRM114-Status: UNSURE (   6.85  )
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

