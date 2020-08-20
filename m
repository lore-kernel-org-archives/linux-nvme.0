Return-Path: <SRS0=ANWg=B6=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89D2BC433E1
	for <linux-nvme@archiver.kernel.org>; Thu, 20 Aug 2020 17:15:05 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5143921734
	for <linux-nvme@archiver.kernel.org>; Thu, 20 Aug 2020 17:15:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Z+GTVn4C";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="Om8wbEWr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5143921734
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=AvF7WfXMZBQW3Qgr6Zsdlz/TLTKZzNStcKMg9csMKSE=; b=Z+GTVn4CXcsYrLCgxNVcaBqbn
	pNjEgQ4yKbFpcjaZVnjb6biYRok3fYSjRqDwPraFKnm/FsZfEkkyvgVYgYr6CUEKKIVjvLweMxsC4
	tTnRkfhrGZIT3ZLyJLekZuqPGfvFD5XVePNHkCIG8pJ/r0zM0tmK07RoDaHt0AJPDJ/JYQ0uOZaX5
	vyjYU23e6ieGKdxP/79r7gpsglG2LitNhGGVtUqbDs4+34XvIQgNuCCcfnZ3f1z+IicrohhKE7pxA
	dqRvONHKiSAFwhuS8GIM5IbdVi41krdNa6iQLHnmI9X4oSep61wbJCu+3/IzHY289WF0uTqWYvZL+
	wxnjyE8jA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k8o9W-00083p-EL; Thu, 20 Aug 2020 17:15:02 +0000
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k8o9U-00082o-9k
 for linux-nvme@lists.infradead.org; Thu, 20 Aug 2020 17:15:00 +0000
Received: by mail-pl1-x629.google.com with SMTP id z23so1184736plo.8
 for <linux-nvme@lists.infradead.org>; Thu, 20 Aug 2020 10:14:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel-dk.20150623.gappssmtp.com; s=20150623;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=Lnb73Iq69gKSLZJF0MMWf+npRy4EArM7SDSo7R1fk90=;
 b=Om8wbEWrVQQmlk+tjod+u90QU+sV70v4tA8PHYYHY/8zcf3tjvGLnqbNDJUi1CjmDA
 GhjG+BuIsIFctbe9Op5+FZA4MOZEQKjH5VRXkP1GJ9xLV15Ou5Yw7wML8iA4Adr9ApdK
 LKpbH8gknpCqTIi2T0Shz6X8PIEdlGnePzZqRW9EgsSurx0ZU7lh6sFtRPode0sHk6Os
 /SRyiRrKLubfJb9J+kERsIzetPXPmDS+tm5rVnqVNuAP98y7K1Ad6S5Iz14lxE5kIJWS
 gzKL0hqqOWWssD/Hmpno7+y3hU6Xv5OG6f2AgyWIsMcSz9MYmz4B8Axcb1b0o7l3/eDM
 7V+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Lnb73Iq69gKSLZJF0MMWf+npRy4EArM7SDSo7R1fk90=;
 b=Fxj+uZ8TRGY9U94RzKOUVfRJWfNfTh7O4AY15f8YNVyiuBFrDfr0vTH+C12v2JvcHq
 hghG1gGqAZNNFp0Pj617gSVJ+ByBx265SjXqpP3UaUS8KQUr8CMtZPqdX+Qkabbwy7BT
 gTC41LS88qW+X2bBPngMwfEcOQJP/L+ynp4tJkJpK7yL+feM2+GhzikePFW2DrR5LK8g
 mjvv9skO487+sFN73kVrRpwenTEG9A03lHN9hiygiERwYb/4iB+j39Dzc7sQP0LxwlGJ
 wEbN4mCTome10d46ylUl1NM4+k6+DUyugGPHxXNeUCCKHap/+n2wrIpasdJBKEN0LkMH
 3HMw==
X-Gm-Message-State: AOAM533JItwjQXsS6k0g0yhvm6NuX4/El5OzyqUAxe2DDkzz44dXa1iP
 8FcHSwiZPtBdPtH7YJPDU3rKfg==
X-Google-Smtp-Source: ABdhPJxNjEk8N2CwA9AQjce290avW7h5BEXFqhxYqZoNWxNsofrU0gOjcdnL3uyPt9A76exUtYmarg==
X-Received: by 2002:a17:90a:e64c:: with SMTP id
 ep12mr3425355pjb.206.1597943697872; 
 Thu, 20 Aug 2020 10:14:57 -0700 (PDT)
Received: from ?IPv6:2620:10d:c085:21c1::16b5? ([2620:10d:c090:400::5:609b])
 by smtp.gmail.com with ESMTPSA id q11sm1075155pgj.92.2020.08.20.10.14.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 20 Aug 2020 10:14:57 -0700 (PDT)
Subject: Re: v5.9-rc1 commit reliably breaks pci nvme detection
To: Christoph Hellwig <hch@infradead.org>
References: <20200817135011.GA2072@lx-t490>
 <20200817155658.GB1221871@dhcp-10-100-145-180.wdl.wdc.com>
 <d077aec4-d79b-b52e-cdd9-bcc89fbbde5f@fb.com>
 <2356f514-9408-6a6f-871d-046984963533@kernel.dk>
 <20200820170729.GA4116@lx-t490>
 <83a3d1b6-1eb5-859b-3c5c-287d8d18a99b@kernel.dk>
 <20200820171214.GA15207@infradead.org>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <e9e4804b-f036-a1f8-63b6-b51592d9a0c5@kernel.dk>
Date: Thu, 20 Aug 2020 11:14:55 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200820171214.GA15207@infradead.org>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200820_131500_367654_460F4B25 
X-CRM114-Status: GOOD (  16.92  )
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
Cc: Sagi Grimberg <sagi@grimberg.me>,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, "Ahmed S. Darwish" <a.darwish@linutronix.de>,
 Keith Busch <kbusch@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 8/20/20 11:12 AM, Christoph Hellwig wrote:
> On Thu, Aug 20, 2020 at 11:10:58AM -0600, Jens Axboe wrote:
>> To be fair, I've only heard this one complaint about it, so hopefully it's
>> not too widespread. I'm on an x86-64 laptop myself with nvme, and it works
>> just fine :-)
> 
> The cause for this is the weird NVMe of by ones, where 0 in a field
> means 1.  So for the overflow to happen you need a controller that
> supports USHORT_MAX queue entries.  Which don't seem to be all that
> common.

Yeah, don't think I've ever seen those. I come across 1023 and 128 all
the time, but I don't have one in my arsenal of NVMe drives that is
any different than those two.

-- 
Jens Axboe


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
