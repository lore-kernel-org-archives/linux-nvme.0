Return-Path: <SRS0=DDko=AE=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A5D2C433E0
	for <linux-nvme@archiver.kernel.org>; Tue, 23 Jun 2020 17:40:05 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3DADD20774
	for <linux-nvme@archiver.kernel.org>; Tue, 23 Jun 2020 17:40:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="mY24mJdq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3DADD20774
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=EnlpFBr4ldsEYdTWBNvHAUFVmiRjTr9fPn7cEHVgDLQ=; b=mY24mJdqa4QgDeaMVPQ9G8pzp
	wKXWHdPmlnGWlrKMd5hojltDJF2s9Fwy5nMB94sfEJFJjnNgIjx8DHl6EvPQ+Q2kEt/xkq1f2IDaW
	JtCCQ5b7+AwetoazbeRdM/iFGGTpZlrjyrM9mHARAdcnYoqNUteJ5/ADABdA9Is57ZfQ63SKIvGHL
	wtK4/olBQdtVg8Gf2AObLD/dXnwStADMeRCylaLoL1Kqq6mAQjtWZqGg8gVyjwj2+g++8fNxNhkBA
	V67yfUZt1xUJXs8ggfvyNsFPXa7Mn+fKifhKNL91qJ4c+YCS3SbSZ26vy1jgqjH90ZAohNUwrJ6Bc
	yQXrL1s7w==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jnmtu-0005Lz-Oa; Tue, 23 Jun 2020 17:40:02 +0000
Received: from mail-pj1-f49.google.com ([209.85.216.49])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jnmtp-0005K7-QS
 for linux-nvme@lists.infradead.org; Tue, 23 Jun 2020 17:39:58 +0000
Received: by mail-pj1-f49.google.com with SMTP id h22so1875637pjf.1
 for <linux-nvme@lists.infradead.org>; Tue, 23 Jun 2020 10:39:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
 b=qi8GYh2ekqa6IxJ+Iplu7sI1Q/cGfa+tlFxfkYrd8W9hLZYhDXTAKYz4XFxYh4FYMd
 XvNkOR/0ECH3I2tqPeHmQXDB9tLh/zYdwUvs+Pv8ENC4bbF4HQvMywQ6G87m9s+wwWN0
 76joKgXAFHFPXaex2dYa1gq//+L4fxYV0jctvqDrKbixrF+siXSObpseZwYG0ccQ6x86
 lxUx377AkTUBp1BE2RhaFeCdBXzMctZoOp5YJ8y2Csuq7hZ78d6r0bt7Ow9XTLO98Iyn
 RVrpRZARnk9BDd4/o8oT0jvBgDA0BJKRJQWbmPH1EwJsRbqPq9CCR23CSsFluwMOCk9E
 3YgQ==
X-Gm-Message-State: AOAM530a7M/flGPKMwrUjSdO4KFbPB7m3S4ysBpO+b0jnMkVYmswLm7g
 TMvx4GdNQq5dZcOlT/zA1hI=
X-Google-Smtp-Source: ABdhPJy5yNa9YCh5UqfALz8PSpQpHx/uLWc0fOou3IMn1j8a8eVkY6oZe4ui356rmDdzLOrCbq0HBQ==
X-Received: by 2002:a17:90b:1a86:: with SMTP id
 ng6mr9447871pjb.88.1592933996847; 
 Tue, 23 Jun 2020 10:39:56 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:acd7:a900:b9f:8b8b?
 ([2601:647:4802:9070:acd7:a900:b9f:8b8b])
 by smtp.gmail.com with ESMTPSA id b24sm17087560pfo.112.2020.06.23.10.39.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 Jun 2020 10:39:56 -0700 (PDT)
Subject: Re: [PATCH 3/3] nvme: Use USEC_PER_SEC instead of magic numbers
To: Baolin Wang <baolin.wang@linux.alibaba.com>, kbusch@kernel.org,
 axboe@fb.com, hch@lst.de
References: <cover.1592916850.git.baolin.wang@linux.alibaba.com>
 <a64d35465b8d91ab11f37d814ac10003da7804b8.1592916850.git.baolin.wang@linux.alibaba.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <c2b796ae-a00e-7368-e60d-1fea473cbee9@grimberg.me>
Date: Tue, 23 Jun 2020 10:39:55 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <a64d35465b8d91ab11f37d814ac10003da7804b8.1592916850.git.baolin.wang@linux.alibaba.com>
Content-Language: en-US
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
Cc: baolin.wang7@gmail.com, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
