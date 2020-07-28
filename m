Return-Path: <SRS0=l2Ft=BH=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 730D5C433EA
	for <linux-nvme@archiver.kernel.org>; Tue, 28 Jul 2020 07:48:50 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3AD5121D95
	for <linux-nvme@archiver.kernel.org>; Tue, 28 Jul 2020 07:48:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="AEOyay83"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3AD5121D95
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=n2i2Eu2jbtg3Zs5/eDeobfXj7iJCiYSCLH951C7avIM=; b=AEOyay836ebwD6YW5yDj2hckp
	Q/JtqK6wiQIvG21SaaQRroL1ibhsnXztl2LBdfaWnau8SsAeUMhoVqtZ6YqicWhzK/69Sr664KWXp
	wMDZlQ3hOGU1oYzwqsHngo0TVS04GunzPd3GvvxE3lsqTPHcQCDLrPFAAGd++fo+bwJcb6HCg85Fv
	anPyPZ704NmgPB2xm7es90ruEYE90d+2Jo/XYblXEP+3U2C4Hz5BebVMuxrVPd2PAQUHhP8Kk/3rQ
	r5wU9KyFqF1dB/qGGTuCoCbZjxhWMmLTYMYDd/XfhzeaKgarHaktjhrq2MnLZE+cqKN5Ap7P5y9sk
	fwt40wuMQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k0KLt-0005LS-0C; Tue, 28 Jul 2020 07:48:45 +0000
Received: from mail-pj1-f67.google.com ([209.85.216.67])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k0KLq-0005JN-1V
 for linux-nvme@lists.infradead.org; Tue, 28 Jul 2020 07:48:42 +0000
Received: by mail-pj1-f67.google.com with SMTP id f9so4893728pju.4
 for <linux-nvme@lists.infradead.org>; Tue, 28 Jul 2020 00:48:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=FO3oZnFQw3BE/aK5FD2/kGmXgS1zOp4LbjFEtdo3Kss=;
 b=Sb29dlCWCchaLpuygY6/Ytko3Ryz36iV/7K9l6iVHLLSUiii+CaUQPUXraPJP2gp+t
 b6ByGtV/LYrgr/Y2hEAGsmxjR8KHAw8mSXfTyIGAnJdWdiFKTq/SRzHqUE/DS7GXjuAE
 mKvnmdi86pBGRrBY6L29ry/+/pNAD2hgcY4o4oFwWjaIQarA88LbtgdQaVWsGn1yokGt
 jKPXdMCMuFApNd+1PKE8pZLuQ05+GNKq16AOIyc94Yb3PwrvIQCWrCML4tttkFL+lIvk
 RYQv8ERthhUst2ye8CsgRxng3XzX37n2B+r7vQEXzNX84PPO/dukC17uxPz9IFxaKn6+
 QqSA==
X-Gm-Message-State: AOAM532UyUrFn8ItRN4XXEn+7jK+IgMRlWb3Ij/05S0LyQToCxD41RDM
 8JH7ZRCqTTlrDMEKSVGZ/euZMADj
X-Google-Smtp-Source: ABdhPJxiF2YrVEmDeu79GtOv5OlVjYPIrvmpdEyZkbJPAMTCqudVVziGKdUAmW3UYNHmAKI5+Eva1Q==
X-Received: by 2002:a17:90b:1249:: with SMTP id
 gx9mr3200688pjb.149.1595922521144; 
 Tue, 28 Jul 2020 00:48:41 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:541c:8b1b:5ac:35fe?
 ([2601:647:4802:9070:541c:8b1b:5ac:35fe])
 by smtp.gmail.com with ESMTPSA id s23sm2000848pjs.47.2020.07.28.00.48.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 Jul 2020 00:48:40 -0700 (PDT)
Subject: Re: [PATCH v5 1/2] blk-mq: add tagset quiesce interface
To: Christoph Hellwig <hch@lst.de>
References: <20200727231022.307602-1-sagi@grimberg.me>
 <20200727231022.307602-2-sagi@grimberg.me> <20200728071859.GA21629@lst.de>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <54c7f095-c112-eaa7-3c69-65b4b48f2688@grimberg.me>
Date: Tue, 28 Jul 2020 00:48:39 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200728071859.GA21629@lst.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200728_034842_126408_F11BEBFB 
X-CRM114-Status: GOOD (  19.25  )
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
Cc: Jens Axboe <axboe@kernel.dk>, "Paul E. McKenney" <paulmck@kernel.org>,
 linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
 Chao Leng <lengchao@huawei.com>, Keith Busch <kbusch@kernel.org>,
 Ming Lin <mlin@kernel.org>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


> I like the tagset based interface.

Even that we need to unquiesce back the connect_q?
See my comment on v5. Kinda bothers me...

   But the idea of doing a per-hctx
> allocation and wait doesn't seem very scalable.

I belong to this camp too..

> Paul, do you have any good idea for an interface that waits on
> multiple srcu heads?  As far as I can tell we could just have a single
> global completion and counter, and each call_srcu would just just
> decrement it and then the final one would do the wakeup.  It would just
> be great to figure out a way to keep the struct rcu_synchronize and
> counter on stack to avoid an allocation.
> 
> But if we can't do with an on-stack object I'd much rather just embedd
> the rcu_head in the hw_ctx.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
