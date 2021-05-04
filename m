Return-Path: <SRS0=iWk4=J7=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03D11C433ED
	for <linux-nvme@archiver.kernel.org>; Tue,  4 May 2021 20:02:05 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AAA726115C
	for <linux-nvme@archiver.kernel.org>; Tue,  4 May 2021 20:02:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AAA726115C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=sX4LkkAw1qc3DRda02j/HB+/VR8r040OSzp9eRWntaU=; b=U7yTu2UHHXQXHlwbC7B8ub+ov
	rrllnNFrltgAf7LYOaba4ZPKHCEY40KeDOi/ml/rTD2gYjpwMgNuw6N/51kjC9HoWb2B7S6mLwgjQ
	NKUZqG0MCMEubyEd5Tv452e51hhHU8IcM/P/nXZb4yHkkJ//gx6TPT2B5a9nrEI+7cp1LDOVx+/sB
	c9DLS0R0mw6hO9B2Gfv9R3Cp8ADpYYBQV/JBHSQEykUhDKlEh2TNz+bsVSLrE/hRsTLiupPjNOY0S
	VE5fAf5WzfgSDhh3bQpmBYhzmJgw0br+W2DdEysNFOEew7wKSRoX7+m5Yo7gvc93zVSvvsYYPY0my
	K1wPbx/LA==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1le1EX-00GySP-OA; Tue, 04 May 2021 20:01:29 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1le1EL-00GyPk-BH
 for linux-nvme@desiato.infradead.org; Tue, 04 May 2021 20:01:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
 Subject:Sender:Reply-To:Content-ID:Content-Description;
 bh=nn7XbIEuR1mPnrlEUhsb2sJwj/n5pr+hwTjxV+Dfv3c=; b=SoVzD5t0swok+ppddjPpTtnMDD
 fjpPKa+La+F2BeZdgbVWgqhf3MYkMlCD4wQEXUokOCxjigBr62Wtyr5zePSL2xU/8KtLnoxg8XNTW
 KnY4x/5SyjgspaFZipdEl4PWi/8dSmGmC/LsI98e2MXJM9+aftC4Fb6rEo/HJftj5wc/qUDigHaye
 p02UeDWgKSRlD/bHAfMhAsnJGvGIVjdNTrIPF9eoMmvG9jC89niMdUfjy+RZlyl0oIOCjfXwl++aE
 PFm0wsNOLqckljC4ocKlZr6GnfiLr4oePUm6//deq1SO57jmzVQ4ChmksgWG6GffIf2jRbXWZQhbw
 CxudwK2Q==;
Received: from mail-pg1-f182.google.com ([209.85.215.182])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1le1EI-004Eft-VG
 for linux-nvme@lists.infradead.org; Tue, 04 May 2021 20:01:16 +0000
Received: by mail-pg1-f182.google.com with SMTP id m124so3308387pgm.13
 for <linux-nvme@lists.infradead.org>; Tue, 04 May 2021 13:01:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=nn7XbIEuR1mPnrlEUhsb2sJwj/n5pr+hwTjxV+Dfv3c=;
 b=ZLPdGyPYryEmNR+BswPIE6I9959+ZuLLQNRgCYnPWyP1PwLcSEHW3MGrz6ax/XDzlF
 vTKrJG3rOYv/R0dLAbb7pz1wc4EQt/Wy57T7+aK0fBMjdwW5JIY5tBm1+OCYFYc3vwEx
 MikJmXqayD2v4ALs8e++ASn8AwqGqIklpy7uDme2/mDF1WGvYrvfwZ27jZZumVMMchf2
 DggcYe17gkrwNvSCev8gHH89TrlbzEgYOU5ZDxjeJFnETEVnQ9YJS2xik3cHI0Y71p5T
 5uqG63isqLvQf7WfbFL3PitIhN3zq2cCvWtRzG5KoklVlHOyGZlnwVEJKp74YLHtL4WL
 UgJQ==
X-Gm-Message-State: AOAM532wDeGP8JhVGsADmRxT5/OkgntOKzIjatK0tN2LITfSl2wxf0NS
 XOCP6jX/dLe6UijvzJwYRxI=
X-Google-Smtp-Source: ABdhPJzNeU7wZZkpRlN3tT3Pv1MAqriIUFZx0eiCMC8dXVTj5fHJOn2YQvB2ejmzPBym0r36FuLdrA==
X-Received: by 2002:a65:5808:: with SMTP id g8mr24529756pgr.137.1620158471944; 
 Tue, 04 May 2021 13:01:11 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:dee:5152:2348:42c1?
 ([2601:647:4802:9070:dee:5152:2348:42c1])
 by smtp.gmail.com with ESMTPSA id 23sm13564617pfz.91.2021.05.04.13.01.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 04 May 2021 13:01:11 -0700 (PDT)
Subject: Re: [PATCH 0/2] nvmet: consider req->sg_cnt for inline bio
To: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
 linux-nvme@lists.infradead.org
Cc: hch@lst.de
References: <20210429184357.9185-1-chaitanya.kulkarni@wdc.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <6cb7c286-1030-5343-ddab-5d2c7995828b@grimberg.me>
Date: Tue, 4 May 2021 13:01:10 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210429184357.9185-1-chaitanya.kulkarni@wdc.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210504_130115_039292_DC67261C 
X-CRM114-Status: GOOD (  13.33  )
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


> Hi,
> 
> While testing I came across the scenario where checking for the
> transfer size is not enough for inline bios, this issue is not easily
> reproducible with the test tools that I have.
> 
> This small patch-series adds an additional check so that we make sure
> transfer size and the req->sg_cnt both fit in the inline bio for
> bdev and passthru backend.

Looks good, though I'd re-title the patches as bug fixes so they
will be picked to stable kernels.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
