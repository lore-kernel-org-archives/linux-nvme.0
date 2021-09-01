Return-Path: <SRS0=EXAn=NX=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A7FBC432BE
	for <linux-nvme@archiver.kernel.org>; Wed,  1 Sep 2021 14:59:07 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C7BC60BD3
	for <linux-nvme@archiver.kernel.org>; Wed,  1 Sep 2021 14:59:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 1C7BC60BD3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7kSxp/Y1NjlC7AFV1NrgZQ8AqwjfCYvy3AvkYQx0pDY=; b=VjIw2yS/dquLn/12mOXDw9EY5H
	9kCRN02MJox182ply6Rc0I2tCGmvoeHJ/cU8ue43DnYneNrabXMQPC8Iv8e8i0Yjvx6gYEN1AE8QS
	x4VFMeLkzVwu9mQKswjUn77dQ4H70NCrcOiT7iwi/xZLCmmbWfralceR1wspU1XxV3lLBsscQn6+m
	vjG8lZ11yIkToD6WmXQWTArg6g312C1K4EBHnTIxYspvVSs9c7l55Al/Bg2ie3yT0710cqyW50MJQ
	i2D1w5tZ0BklS2ybjaD1WBWCZYN6FjZiZncLvI0n2KNbpwvAcgeKR7WZ/V7tyoBvFkta+jidlnpP3
	w9L/8iWg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mLRhL-006Jbu-6n; Wed, 01 Sep 2021 14:58:43 +0000
Received: from mail-wm1-f51.google.com ([209.85.128.51])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mLRhD-006Jb2-PH
 for linux-nvme@lists.infradead.org; Wed, 01 Sep 2021 14:58:37 +0000
Received: by mail-wm1-f51.google.com with SMTP id
 d22-20020a1c1d16000000b002e7777970f0so5002055wmd.3
 for <linux-nvme@lists.infradead.org>; Wed, 01 Sep 2021 07:58:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=LIJJa6yIi3gGpTBMMvQKQExcxbiRtGrijkJ9oStOCGs=;
 b=sz5EH/RnygHMNqTssO+l0NqxrN8s4mhtI3gRBTlfC6Z+hQLtIry1cjCTIgEc4petJX
 2/jxupwpOPjWAkTdH86LadfF2XFABwZm9ToEr+IoYmC3TBgb2YCXPUEQ0UKldTh1d4qB
 0kZqNSLx2dvDvoRLVZfMjCWMjYx4XJZF8ZGzfExh/+RsJ2OIjcre47DKBlUAbZjWW5k6
 irLaOzUtfjcqQiXNdM8/g1eBsHWFbYYaiM4CUzf2HdtW7UXAbAraHqdFubtJkH3/nIB1
 HG/lyDScYa5xaYMTs+4astz0HzzfTcPRUNsRliE2eVdYgWPZgPY07tZq14N2mI/XIdAk
 hZbw==
X-Gm-Message-State: AOAM532+YLn5qlC+dh9TrCIm0eTbA91XW7euslyUFJb2hTs3qD60bQ7W
 wTmDwSpPPsTry2+IXOElarWqGD1bp9A=
X-Google-Smtp-Source: ABdhPJxvGu4Lvn2jyZiyk9tAFCD5xCCJw40j/awGaOIpifD3A3rxXFYTFXOWTF7Nrd6MRgUYO87goA==
X-Received: by 2002:a05:600c:898:: with SMTP id
 l24mr10219150wmp.90.1630508313768; 
 Wed, 01 Sep 2021 07:58:33 -0700 (PDT)
Received: from [10.100.102.14] (109-186-228-184.bb.netvision.net.il.
 [109.186.228.184])
 by smtp.gmail.com with ESMTPSA id g138sm5879123wmg.34.2021.09.01.07.58.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 01 Sep 2021 07:58:33 -0700 (PDT)
Subject: Re: SPDK initiators (Vmware 7.x) can not connect to nvmet-rdma.
To: Mark Ruijter <mruijter@primelogic.nl>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
References: <CA3F5384-4B57-47ED-9DFE-27E80F3D312C@primelogic.nl>
 <07e2bbb2-2b62-f0a3-b845-27398268c468@grimberg.me>
 <0FA43353-7C04-4CAE-9E84-CA0DE6907492@primelogic.nl>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <733fb177-a0ec-152c-f211-73f1e96dfe10@grimberg.me>
Date: Wed, 1 Sep 2021 17:58:32 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <0FA43353-7C04-4CAE-9E84-CA0DE6907492@primelogic.nl>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210901_075835_881152_FAD28324 
X-CRM114-Status: GOOD (  16.42  )
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


> Hi Sagi,
> 
> I am using VMware 7.x as initiator with RDMA.
> The target system is running Ubuntu 20.04.3 LTS with kernel 5.11.22+.
> 
> The device that is exported is an LVM volume, however I also tested with a file backed loop device.
> Connecting with SPDK seems to be the problem and as reported on the SPDK mailing-list it can be used to reproduce the issue when VMWare is not available.
> ./perf -q 64 -P 1 -s 4096 -w read -t 300 -c 0x1 -o 4096 -r 'trtype:RDMA adrfam:IPv4 traddr:169.254.85.8 trsvcid:4420'
> 
> This seems to produce a similar result:
> nvme connect --transport=rdma --queue-size=1024 --nqn=testnqn_1 --traddr=169.254.85.8 --trsvcid=4420
> 
> I hope this helps,

I meant which rdma device are you using? that device is failing the
qp creation.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
