Return-Path: <SRS0=roYe=ID=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7ADFC433E0
	for <linux-nvme@archiver.kernel.org>; Fri,  5 Mar 2021 22:35:55 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6AF7365073
	for <linux-nvme@archiver.kernel.org>; Fri,  5 Mar 2021 22:35:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6AF7365073
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=EnlpFBr4ldsEYdTWBNvHAUFVmiRjTr9fPn7cEHVgDLQ=; b=MSnVPvoOWyXQYTqoocaq/du3i
	ZJickc0fWCnOJnVehFvqr2jjQ+7s+OF7T9crajbjx9IFdE3GIk09xJuaY8lXx2dj6u3D8QKigyBHd
	ocbFbYDJCCp66pOF/YfshUwgGWBGuXma+0856u2wsV2R4sOc5LKJZ2M/6josvjooGO2L+7lxRz9Ls
	W86yKSGGSlOXyj5zC6L9upfPQ5+QDW81f/3dfyuA42ULoeH4mQNbSAqBMikdt+Sk+YyMVES/wx5j4
	ZLaQqjTienYKqqhg0hdfUNfjHTpKnCQZ46P6Wv9cps9fd0QtQrTTdl8s/OeNNrZpyHvTDBehqzXoP
	I0dKjcuVA==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lIJ2s-00GrTu-GX; Fri, 05 Mar 2021 22:35:42 +0000
Received: from mail-ot1-f48.google.com ([209.85.210.48])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lIJ2m-00GrQw-8H
 for linux-nvme@lists.infradead.org; Fri, 05 Mar 2021 22:35:40 +0000
Received: by mail-ot1-f48.google.com with SMTP id h10so3383127otm.1
 for <linux-nvme@lists.infradead.org>; Fri, 05 Mar 2021 14:35:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
 b=MbAAg1LBynPy5XNBkvq2LArumUU357fIbDCDJUzLZBoPKb/kA6dVteSdxHPm1hnGMS
 hHsGJxKVI2vv+L71LZDkr6NyRTVXPEbLRukCcvUXoiniqZeEfPvRA2QisNKCYCwDqAWs
 ZHtdB0RweEB2RSq9CZft/JQN94RIOUU4f2ec4nCz9UIhJe//A2PTZTcBGC0LutupVw76
 qnnGCgMnKDa61a1n4rPgyT5CIAR02+2e58+vQBaAc1DbrDjagDbCh2vwb2rCO69zhIKO
 c7hrrciw6mDje3eyYIlA00aa01AyyGshEkZxGF6LnP0esakdPOj3uYzWf2fqkfIfQmAJ
 0dwA==
X-Gm-Message-State: AOAM530mINxuVb3ekvKfnVgvx2317qjni2fwRKZ8/FET0e+qkKvhQXYa
 CpbC2j6rwnhJud8vn+0CLzo=
X-Google-Smtp-Source: ABdhPJy2mTrtkY/vsFIkYU/OI0xjKkKridYKUZMeq+LZaLCwrvAWRWN/TbwBRZ5u0yiYlGk7nd6OTw==
X-Received: by 2002:a05:6830:314d:: with SMTP id
 c13mr10156774ots.124.1614983733043; 
 Fri, 05 Mar 2021 14:35:33 -0800 (PST)
Received: from ?IPv6:2600:1700:65a0:78e0:e55e:67c6:e7ec:9?
 ([2600:1700:65a0:78e0:e55e:67c6:e7ec:9])
 by smtp.gmail.com with ESMTPSA id z32sm859196ota.81.2021.03.05.14.35.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 05 Mar 2021 14:35:32 -0800 (PST)
Subject: Re: [PATCH] nvme-multipath: use nvme_ctrl_use_ana helper to check ANA
To: Minwoo Im <minwoo.im.dev@gmail.com>, linux-nvme@lists.infradead.org
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
 Christoph Hellwig <hch@lst.de>
References: <20210225105744.69579-1-minwoo.im.dev@gmail.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <3679f128-61a5-e219-3a7d-148baf14b4cc@grimberg.me>
Date: Fri, 5 Mar 2021 14:35:31 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210225105744.69579-1-minwoo.im.dev@gmail.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210305_223536_378175_F270B509 
X-CRM114-Status: UNSURE (   9.58  )
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
