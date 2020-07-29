Return-Path: <SRS0=jy92=BI=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4654BC433DF
	for <linux-nvme@archiver.kernel.org>; Wed, 29 Jul 2020 05:53:52 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 10537206D4
	for <linux-nvme@archiver.kernel.org>; Wed, 29 Jul 2020 05:53:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="QMPucaxx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10537206D4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=PyHFAWyfvFDO5r+5dz242bUPnQRr6Bja5cOuwObWZGE=; b=QMPucaxxLSiQ3pD4DrRbTlWeM
	RXMru8WFMikshTx6sdD8B1QAycXJrpOV0Jj19vj1tDwYFoGgeJQzv4eltJsP99nUeeBqmbJICXinh
	jBL0mnEyD5QrX54a2LHJdL4y+BgWkg0oc/4yoKyq35JnubGPEOIORvvb1zo9ZtPbGWa0kDgwOHC/+
	G9Hx7zLiVoguefbUBtSiP+vdL5ZwGRtHXPCLJNn8YhQ7hrGPWe5i9/1ZZ4qCI8Xj51HARTWPC0sjB
	/3aUyJWl4pyT26G+dVa9UVm/byFXr0sfmqGPWWn63X+JdsG5PS9s4ZTm8j7u9DoiVItwLs19gcriT
	7yfzvod9w==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k0f2C-0008FO-VF; Wed, 29 Jul 2020 05:53:48 +0000
Received: from mail-wm1-f67.google.com ([209.85.128.67])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k0f2A-0008Ex-RF
 for linux-nvme@lists.infradead.org; Wed, 29 Jul 2020 05:53:47 +0000
Received: by mail-wm1-f67.google.com with SMTP id f18so1398301wmc.0
 for <linux-nvme@lists.infradead.org>; Tue, 28 Jul 2020 22:53:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=L2BSWzQQ0Ym22Tk2sL7NGJroCccUus+uO2wMuo1dCSM=;
 b=edDKvkpL36LycgU1qlp6HwlcDkHEQWWk3wGbf6oDoif+zhMCfktA+pCvi3m8ofPGjG
 qR7CPSGSB9opPzhcCwbwp+5aTDklG7oAhfmS8f+7T19i5uCjr01t0FJC/x/iHzbOe7G1
 XOyi7H7WY/rTvvZWY5/Zj76hkeU4reLnRQsf0xGLHMBw8DfE3w6Rc2o9barxF3XK1xz4
 QrAQDj/0rsq3LBvwgWi1OVjUjjclreDOFFHkrUVN/+V1eIqkDtID5AwOdCL3vMNmfj+A
 Gfp5ruHUe6qh5hT3BS0rc5HskCvUPb4AxAP6++nZ2kUuns7aSCAGpTtjsIZGMHVgb0fa
 GD9Q==
X-Gm-Message-State: AOAM531R/1KSDyD9v7CUNbtr02Yby1f/KbM58CMWxNp3gsIgi/ksoudS
 NUzybC8dXhqZfeDWLELQgfQ=
X-Google-Smtp-Source: ABdhPJxyVXGQc9QkNMVHBQ/9QXhQVmA3FdGCj9TiYAMETiO0jsfb0O/yq4Sm00Bj4CCeBhK4nhRGzg==
X-Received: by 2002:a05:600c:410b:: with SMTP id
 j11mr7352757wmi.38.1596002025332; 
 Tue, 28 Jul 2020 22:53:45 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:8475:db3f:c2a2:c61c?
 ([2601:647:4802:9070:8475:db3f:c2a2:c61c])
 by smtp.gmail.com with ESMTPSA id g126sm2654737wme.16.2020.07.28.22.53.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 Jul 2020 22:53:44 -0700 (PDT)
Subject: Re: [PATCH] nvme-fabrics: allow to queue requests for live queues
To: Christoph Hellwig <hch@lst.de>
References: <20200728053523.21657-1-sagi@grimberg.me>
 <20200729054500.GA31113@lst.de>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <16c71600-1656-b6ff-026c-6ae92944d346@grimberg.me>
Date: Tue, 28 Jul 2020 22:53:41 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200729054500.GA31113@lst.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200729_015346_890370_128B46B6 
X-CRM114-Status: GOOD (  13.47  )
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
Cc: Keith Busch <kbusch@kernel.org>, James Smart <james.smart@broadcom.com>,
 linux-nvme@lists.infradead.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


> Dropped from nvme-5.9 to wait to the discussion to finish as I want
> to send a PR to Jens today..

OK, this is a bug fix, so we can send it later for sure.

I can also send a patch that doesn't touch the USERCMDs that
James is concerned about and we will fix that later...

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
