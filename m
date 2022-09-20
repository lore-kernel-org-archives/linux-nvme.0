Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C413BECAAD8
	for <linux-nvme@archiver.kernel.org>; Tue, 20 Sep 2022 11:38:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=URWCXNQ5YHvkyCvX5bdKcCLQ4Piclp57iUCltD9+ciE=; b=A/Zi62UXJ0led6fW+oMffsrBEL
	yydN5AJFNSxD2X8x/yAlsVeT3hLF+InwNC+h9Bi/U1AecjsssdXR4JCkG8jdO9RwRzcEzV4YyR8fV
	srbtfDhawYTPMezAJknb8khMJI3SWdcK7rT9MVDV4LcpETgIj2mkOgC+9WkLxZceK1zdDLBIYxMHp
	/R+p1LaCCXKw+ZLdeZ+WX4qthNog5v3YtBvUM9hT3RpuVFMDJxbLE8/QkkPyE97M+/iWNT1YIJr8V
	/S5RWtc3mrja845sTnZ7syaF3tBaPCmxveGKxotZVPbBLMPT2/IDVvYEbTC5H8LdF+PYLQsoQdtVH
	ifmq6pHQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oabaI-003Obz-ET; Tue, 20 Sep 2022 11:38:38 +0000
Received: from mail-wm1-f49.google.com ([209.85.128.49])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oabRg-003J5f-Jn
	for linux-nvme@lists.infradead.org; Tue, 20 Sep 2022 11:29:46 +0000
Received: by mail-wm1-f49.google.com with SMTP id e18so1687238wmq.3
        for <linux-nvme@lists.infradead.org>; Tue, 20 Sep 2022 04:29:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=URWCXNQ5YHvkyCvX5bdKcCLQ4Piclp57iUCltD9+ciE=;
        b=teWzDsbETkztQKCU/3fZtHX06A/8GYIlpEJuhTsywB/qVSLDnBnd2+znWRtaO14Dim
         IC4KT1q9O9qjGu55ozYhEXcVaC74+tbV0gqTLzIbxb9uk1PqR1GiOuGAqbyjX/AfJPWj
         tOtLl4n46CdVSWjJeS4XuJKYKLHnJ8oFuwVRa/m7NpaBp+bG8I+Jxyaubag29SG37/vP
         5QutX7nf5O9ipNypms7XvIUMly9/ivG7JsgyRbXK3A4kButKdpHAjJqUFspdqWf8v+A7
         t0Wux6TmG28pTweo8WIgmz9t4eV268XP9OXeFVESeWDc2JqbFcTRknECg9AczGXJVxKd
         5JUQ==
X-Gm-Message-State: ACrzQf2rrbJeTNlvPmunk/k0/igpkOc1zmjpiie96vF237IR6NkF95pB
	UE5JBD1Ii/CcWIMCf8zyJ/Cm03du5/s=
X-Google-Smtp-Source: AMsMyM67dmckDdLq7F5wSsz+U8zB0mfdBBfKguo9pV4uQ9FyZiAr6SpKsl3ZxyomPp1YxslmdEEkOg==
X-Received: by 2002:a05:600c:4e94:b0:3b4:baf8:cf18 with SMTP id f20-20020a05600c4e9400b003b4baf8cf18mr2078891wmq.170.1663673380152;
        Tue, 20 Sep 2022 04:29:40 -0700 (PDT)
Received: from [10.100.102.14] (46-116-236-159.bb.netvision.net.il. [46.116.236.159])
        by smtp.gmail.com with ESMTPSA id n34-20020a05600c502200b003b47a99d928sm2174187wmr.18.2022.09.20.04.29.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Sep 2022 04:29:39 -0700 (PDT)
Message-ID: <c4f7f644-9dc9-48ed-a411-5074fc51f9cd@grimberg.me>
Date: Tue, 20 Sep 2022 14:29:37 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v4 1/1] nvmet-tcp: Fix NULL pointer dereference during
 release
Content-Language: en-US
To: zhenwei pi <pizhenwei@bytedance.com>, hch@lst.de
Cc: kch@nvidia.com, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org, fmdefrancesco@gmail.com
References: <20220913014253.931724-1-pizhenwei@bytedance.com>
 <20220913014253.931724-2-pizhenwei@bytedance.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20220913014253.931724-2-pizhenwei@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220920_042945_207425_280B187C 
X-CRM114-Status: UNSURE (   9.61  )
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


> nvmet-tcp frees CMD buffers in nvmet_tcp_uninit_data_in_cmds(),
> and waits the inflight IO requests in nvmet_sq_destroy(). During wait
> the inflight IO requests, the callback nvmet_tcp_queue_response()
> is called from backend after IO complete, this leads a typical
> Use-After-Free issue like this:

Would it be possible to resend this patch rebased on top of nvme-6.1?

