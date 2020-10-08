Return-Path: <SRS0=NQX9=DP=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE2AFC433E7
	for <linux-nvme@archiver.kernel.org>; Thu,  8 Oct 2020 23:05:58 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2DB7522248
	for <linux-nvme@archiver.kernel.org>; Thu,  8 Oct 2020 23:05:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="P87TNJTU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2DB7522248
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=CN/Xoi05hLkoiXplDgOk4+/Ce10Xsl3cV++z7PQLQN4=; b=P87TNJTULWCI/f3WpFQKYNedm
	wT7P6+ThJCXQbv8vIXhcIA5eu6jBUMcAqdoURm92V0HHRzmBmVd5iepsDINc/R8A+wh07tCvJW+xS
	ckYsmAxTTM0ZPL6FuEFT3L2Hsa4zaYjV/WIbniyuY+csLKETuffb8BCUH8cNY8Jz3wnjmgGyuw1py
	wC5kgoXedDrbjDoPfXMtW1rM2BTCJllfHE48H65CYqITpNnwWWaMzXBAzz8RPyfndw+JqWY7hwx87
	STe8zs+x99YZKyew6WQabn48jJl4NfGaRSmWwnHVpOFEbKuq9JPro7Oq0VzA4EMusZP+EgWUVZZAG
	01BnVwVpg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kQeyw-0005q9-FR; Thu, 08 Oct 2020 23:05:54 +0000
Received: from mail-wm1-f68.google.com ([209.85.128.68])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kQeys-0005pZ-QB
 for linux-nvme@lists.infradead.org; Thu, 08 Oct 2020 23:05:52 +0000
Received: by mail-wm1-f68.google.com with SMTP id f21so7992237wml.3
 for <linux-nvme@lists.infradead.org>; Thu, 08 Oct 2020 16:05:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=dB20HVoUg946vxWKworaTCw4p2EkZ/5MfYI2isxQJwk=;
 b=LKAj/M7fhXD0Dw8w1ImaHObA62WvqtyoaM2XQ53jxdMVnBZYuc2wp1qqlS30ci8WRA
 y/vlmtNmdNYmOqSEYhkl623Qm9UsM/qFRJZioL2OkAIspNm4Q0bEVT5GMrvmOjPfdXth
 oSYy6NzI6UGhVjDaj6W0hFt0eG9lNA347poelPUrmoiekfm8Rw0R9uqESP8VEOSClU6f
 Nz9IaEeGSC3u82nFffNG5cznjhh1nEdaieIPtT7kGgRSGAvRCOK92bauETbt/YosId8l
 EgiH2DY2+pHcN0et/767Vhj8b/U9M8zd4x4lg4zzgaKJDripjSaRKZ3ROcihs31QkzhE
 u7yw==
X-Gm-Message-State: AOAM5302Qu5nFl0+W1mkr+tZwq2N96LzsBwbbYPI6gI8t4WcRCqMzbi4
 jMBp/SZGXgeZoQKDxmyAxX3zkXCbj9w=
X-Google-Smtp-Source: ABdhPJxjKwf6S8u3irrDfOz65cWcm+G1mYwsrii+c86Y9kKVV7M7ZASZWXK7rvskf7M2lD2fWgbXLw==
X-Received: by 2002:a1c:4c13:: with SMTP id z19mr10087258wmf.121.1602198348995; 
 Thu, 08 Oct 2020 16:05:48 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:68d6:3fd5:5a8b:9959?
 ([2601:647:4802:9070:68d6:3fd5:5a8b:9959])
 by smtp.gmail.com with ESMTPSA id j101sm10006355wrj.9.2020.10.08.16.05.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 08 Oct 2020 16:05:48 -0700 (PDT)
Subject: Re: [PATCH net-next RFC v1 01/10] iov_iter: Skip copy in
 memcpy_to_page if src==dst
To: Boris Pismenny <borisp@mellanox.com>, kuba@kernel.org,
 davem@davemloft.net, saeedm@nvidia.com, hch@lst.de, axboe@fb.com,
 kbusch@kernel.org, viro@zeniv.linux.org.uk, edumazet@google.com
References: <20200930162010.21610-1-borisp@mellanox.com>
 <20200930162010.21610-2-borisp@mellanox.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <3820c19e-0fea-9345-0e0e-692119f7aa84@grimberg.me>
Date: Thu, 8 Oct 2020 16:05:43 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200930162010.21610-2-borisp@mellanox.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201008_190550_873076_6D4F911A 
X-CRM114-Status: UNSURE (   9.63  )
X-CRM114-Notice: Please train this message.
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: Yoray Zack <yorayz@mellanox.com>, Ben Ben-Ishay <benishay@mellanox.com>,
 boris.pismenny@gmail.com, linux-nvme@lists.infradead.org,
 netdev@vger.kernel.org, Or Gerlitz <ogerlitz@mellanox.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

You probably want Al to have a look at this..

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
