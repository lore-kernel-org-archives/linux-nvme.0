Return-Path: <SRS0=roYe=ID=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADA7EC433DB
	for <linux-nvme@archiver.kernel.org>; Fri,  5 Mar 2021 22:35:12 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2CFBB65073
	for <linux-nvme@archiver.kernel.org>; Fri,  5 Mar 2021 22:35:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CFBB65073
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=kNSoeh8vZm0qQdY6g+S2i/jPolyD4yOp8NsDCjepHXs=; b=g/lB5oboZHCJ0/n8BpPyqBsZD
	BiAQmfpb85b+ojjlbae3Ukttg/N5TUOWpnITDdQa5mr57Hh6iWKqRhcP5Eko7sjZYwDbEnpOo78+a
	lDx/W3ZSg3y0FVOCdJOCUg5cBzVh6ZrgT6/vyEoocVeODcWNFSeoqDMsJiygRZUGBVk9YitUl1lAg
	bQSholQan/y9CpCh9M2p6WLvFC1L6b/J9nWVKuJFHM9/iwg8za3by6v37sB7LFtgi0yyyAbjBr2Ch
	ijp066r8VEAzaD3qT2WHjuYQqXL0XLjNXaIrbOmz4JtjwoCP2Lvir4Xp4l95/6b3cdF8iuKg73uqG
	VduIlkJ3g==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lIJ23-00GrBm-9h; Fri, 05 Mar 2021 22:34:51 +0000
Received: from mail-oo1-f46.google.com ([209.85.161.46])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lIJ1x-00Gr9o-Hg
 for linux-nvme@lists.infradead.org; Fri, 05 Mar 2021 22:34:48 +0000
Received: by mail-oo1-f46.google.com with SMTP id n19so806011ooj.11
 for <linux-nvme@lists.infradead.org>; Fri, 05 Mar 2021 14:34:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=z91xx6uF+CymxsUAgbHYk97Wmf+hUIZkoC3XTJ1WcCA=;
 b=dgUYGnrUfTBA2CmhjosI7OaIrCaYQnY1e7z5SnEiQX3NvFqY4fh4NHQsaRmYVxh1/s
 Du+zMaq0DkIx9p3tMnDUnPr35qDuozmlUYA9g9UAdvzctlBx7zvDhjjAagxnx4+oJnVN
 p4HrJR9fjEQ9XncRjevDBY+wc5OCRozESPNUMIDy/NscIOYMb7WNClAE3AbWZhceevRX
 VEucgiR33tHrVX9iPO6dsE56HqTY+6f5M6isAV33dZSPh2UA6lp41jH7hBnBYeRoW3oQ
 eWo5MzerWmyAqt3joQ0gVa23gV9SkcWejq5+iVPk93fsQVbAcv+44X3I6ZSVmaPWnThB
 CfRA==
X-Gm-Message-State: AOAM532ewhhjb4rxMfYqazRlhjSpCQXJlDyoVBIdr+FrPTc/5IawBo8B
 Rax4TmMvw9s8yvwZT+hGeSQ=
X-Google-Smtp-Source: ABdhPJwWOKWF2C6T3L6kGGMZUi5QXH+3Uk+W67cHAbje2gOFxAjaof2HNYaeidDuB3XaNpAycG7jhQ==
X-Received: by 2002:a4a:aacd:: with SMTP id e13mr9515704oon.35.1614983684391; 
 Fri, 05 Mar 2021 14:34:44 -0800 (PST)
Received: from ?IPv6:2600:1700:65a0:78e0:e55e:67c6:e7ec:9?
 ([2600:1700:65a0:78e0:e55e:67c6:e7ec:9])
 by smtp.gmail.com with ESMTPSA id g21sm830972ooa.15.2021.03.05.14.34.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 05 Mar 2021 14:34:43 -0800 (PST)
Subject: Re: [PATCH V8 0/4] blk-mq: implement queue quiesce via percpu_ref for
 BLK_MQ_F_BLOCKING
To: Chao Leng <lengchao@huawei.com>, Ming Lei <ming.lei@redhat.com>,
 Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
 Keith Busch <kbusch@kernel.org>
Cc: Hannes Reinecke <hare@suse.de>, Bart Van Assche <bvanassche@acm.org>,
 Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
References: <20201020085555.1554255-1-ming.lei@redhat.com>
 <cc732195-c053-9ce4-e1a7-e7f6dcf762ac@huawei.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <3aa5407c-0800-2482-597b-4264781a7eac@grimberg.me>
Date: Fri, 5 Mar 2021 14:34:41 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <cc732195-c053-9ce4-e1a7-e7f6dcf762ac@huawei.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210305_223445_707085_454B5015 
X-CRM114-Status: GOOD (  19.14  )
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


> About nvme_stop_queues need long times for large number namespaces,
> If work with multipath and one path fails, It cause wait long times
> to fail over to retry, and the more namespaces the longer the time.
> This has a great impact on delay-sensitive services.
> there are two options to fix it:
> 1. Use percpu instead of SRCU. Ming's patchset.
> 2. Use tagset quiesce interface with SRCU. Sagi's patchset.
> The two patchsets are still pending.
> 
> It is a serious bug, I expect that we can revisit the solution.
> Maybe we don't have the best option, but we need to choose a relatively
> acceptable option.
> 
> Can we fix the bug for non-blocking queues(which used by fc&rdma) first?
> 
> Sagi & Ming, what do you think?

I don't recall any outstanding concerns that I had (I think they
were all addressed). I'm fine with moving forward with it.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
