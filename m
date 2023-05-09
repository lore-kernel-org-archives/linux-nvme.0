Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 516A2C7EE22
	for <linux-nvme@archiver.kernel.org>; Tue,  9 May 2023 22:33:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=fBbM9Oq3DBaJaO9s1PylV1848qqRn75MsrkD0PJda54=; b=NAbBcFTYF7NEHimxqA9pXXqRGk
	8uUuFdbalkkr9RikhtEigeKL7HxdLAx3ScWypomQ3CYz7E8POkv4WUDAnZI7xVrSL65rQiHk4VGo7
	f7was7xwC8RScNeed+n6IDogIcXI2/rXN+V9w8yVzXpFu5FupP9lEKIx1ID8wEWBcKz6X2eeomnDt
	cP0Bjq1hfX1yb0ka6ewJhmwyQsyEnln2hwwar1wv99DJr57djgNyRVWdkCm/zjyko3xObcRvrBFWk
	3SrJopjMFtY81CITLwezRqR/b+nQpUf3lZmIOLM6ujss6GwN66APzVx7wSHIljQ0uEgB4ckigTgtt
	w0aoUX+w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pwVtt-004PYB-2C;
	Tue, 09 May 2023 22:33:41 +0000
Received: from mail-pl1-f181.google.com ([209.85.214.181])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pwVtq-004PXm-1K
	for linux-nvme@lists.infradead.org;
	Tue, 09 May 2023 22:33:39 +0000
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1aafa41116fso44956275ad.1
        for <linux-nvme@lists.infradead.org>; Tue, 09 May 2023 15:33:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683671616; x=1686263616;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fBbM9Oq3DBaJaO9s1PylV1848qqRn75MsrkD0PJda54=;
        b=HUDO2MYNKgLTLi2gAkrcVXrQv0n0lXXv8zSXfk1MOF9E6YqdE1E8+VACSq5Yceu+Oy
         DfpfhbHOtabOB3oiIDLD4le+A14OWSsz6xZY/NDPLo7r0/DZ8Bti4UTzLl+qziTa182k
         hAMVdNLVvC4/IBiOur0AuQl5OE/JdWhsfx4qzADO0wbLTG8Jw02OxEHflX5t+864PJ/o
         Ja6wSzmcVf9Gm1az2WbSl6DAhrlCX5bCaAwGoZ+uwowDvQswgCv4VPZumxwQUEklGL0s
         F8xD3wubhzEIWrA2Dorjt90E8joQrMjMEW42S2Q24DPp/H54ZS4IcOHpqPFIiVO8EPPM
         +bOQ==
X-Gm-Message-State: AC+VfDzpZRFlvLtkEwpLAqOjUoClBCsOfUrRQfwIuUuw4y+FdP8ZCyI4
	PYFkKdoeLmF5rvT0XHzziCQ=
X-Google-Smtp-Source: ACHHUZ5DGVAm5R7dRu331w+asiBUyTJsfm/YwOVJUiEaTZjLxKFwIQzss+SsogqUZ+bS93CRfhiepw==
X-Received: by 2002:a17:902:d902:b0:1a9:86ca:38cd with SMTP id c2-20020a170902d90200b001a986ca38cdmr15437448plz.2.1683671616010;
        Tue, 09 May 2023 15:33:36 -0700 (PDT)
Received: from [172.20.11.151] ([173.214.130.133])
        by smtp.gmail.com with ESMTPSA id n13-20020a170903110d00b001ac741db80csm2160939plh.88.2023.05.09.15.33.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 May 2023 15:33:35 -0700 (PDT)
Message-ID: <a7458945-5187-ad13-e75c-bfa6966c5e44@acm.org>
Date: Tue, 9 May 2023 15:33:35 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH] nvmet-rdma: Suppress a class of lockdep complaints
Content-Language: en-US
To: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Sagi Grimberg <sagi@grimberg.me>, Max Gurtovoy <maxg@mellanox.com>,
 Hannes Reinecke <hare@suse.de>
References: <20230509135615.2061227-1-bvanassche@acm.org>
 <ycdptic5i3aerzpzml7eitzb7wn7wj3vwk3bric2ogus6m3uaz@33zh62c3mmco>
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <ycdptic5i3aerzpzml7eitzb7wn7wj3vwk3bric2ogus6m3uaz@33zh62c3mmco>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230509_153338_462749_0637038C 
X-CRM114-Status: GOOD (  15.35  )
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

On 5/9/23 14:44, Shinichiro Kawasaki wrote:
> Bart, thank you very much for this immediate action after the discussion at LSF.
> This is encouraging. I applied the patch on top of v6.4-rc1 and ran the test
> case with various transports. Unfortunately, I observed kernel panics with rdma
> and siw transports [1][2]. Also I observed another lockdep WARN with tcp
> transport [3]. It looks that your fix unveiled more hidden issue/s.

Please use siw instead of rxe when running blktests - there are known 
issues with the rxe driver.

Please apply these patches on top of kernel v6.3 instead of v6.4-rc1. 
The hrtimer_interrupt() crash shown below is a v6.4-rc1 regression and 
does not occur with the v6.3 kernel.

Since my patch is for the RDMA transport, it is not clear to me why a 
report for the TCP transport is included in a reply to my patch?

Thanks,

Bart.

