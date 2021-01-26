Return-Path: <SRS0=0e7J=G5=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2C2BC433E0
	for <linux-nvme@archiver.kernel.org>; Tue, 26 Jan 2021 15:50:31 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 61E2C2083E
	for <linux-nvme@archiver.kernel.org>; Tue, 26 Jan 2021 15:50:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61E2C2083E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=7HVRdUEe383VJvDE74S9RuVWSnyttQ+MvdyALTGsO98=; b=HyfvWQUbouMdl7v7YsR0T/SUs
	EwfeoEPkB/K2sbks407XFOA+8W2K3siwQBIeOSPwO0igxYsW5aegAI0sBttBbEK3oP34P862iXxQ6
	6ViOYGwp6E/vOsJgASMGJ9TKEjNZnP1g3QOyXJHjr32DLGfhyuuIIxg4UHimG0C5aFBvxGsKCLUe5
	WQYCzkFe3ZZ+EJHxOmNZlTgY+nhzzScg120cz5W29ew2s4OudlOgGYFjb3Rh64VduWEHHBMsE+OX3
	Xd57uFwHUuaNLxyNl9e49QPHyySlehcwUvrX2MV6tPwvwEizuwrR0Qu9muPmUMiqS6hbtqlfKH1RK
	EkfNiRYHA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l4Qbk-0005yT-Cr; Tue, 26 Jan 2021 15:50:20 +0000
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l4Qbh-0005xV-J5
 for linux-nvme@lists.infradead.org; Tue, 26 Jan 2021 15:50:18 +0000
Received: by mail-pf1-x42c.google.com with SMTP id 11so10655806pfu.4
 for <linux-nvme@lists.infradead.org>; Tue, 26 Jan 2021 07:50:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel-dk.20150623.gappssmtp.com; s=20150623;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=SsOHsp4CNkFxjdTZshpM5g+g+qO3mJ0CLTnLDYGv8F8=;
 b=Q/fVoQh5K93yJcNdbudRk4luINyrwHUURtqGAC6/JqYcOPosFilLAg+2J9JqCAyANZ
 EnsGBpNvfjgopsphz2sovbPJTKzmrCA4ASTUfBXE6n5cw0t3FfMmYTlyc1xvJ3u4wQkQ
 Y0g4X+JIUu0F+4XBCTzkbegxLAe6uGJ9kLMY+tHukHRybvSz+0BFvNicJpql+rcTOst4
 R+9elAJWLiLOLRWZkaX9ONwxX4kAU4kEKAJNJ7ldWH9kdI13qMOMw3Tw4lgEoMSa2iix
 gpvu7RWlVeK3KO+3PC7yJ38PHoTMygY6TEZX80x/gMEorKUHLXX4Y1vfo2A9Qe3S+DTK
 3pSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=SsOHsp4CNkFxjdTZshpM5g+g+qO3mJ0CLTnLDYGv8F8=;
 b=SnNwd/t5V9sdOpsOISzMSmKq5m+pC86jXhkjy9JCcqDwZhU2yln537qJodiaCd3Y5P
 +TqCRpyqEPir38cj0yKbbSMTQwxXykHTFBLJN+q3x9dk1C30M6Kv86OQSf740tx7QacH
 uSrkTkKmx25E9hnJnNhHHvlsGJOwyV/ElzUwZL7VGClv9XS5h74BNqBxny7SbUthV2TC
 pABf1ou8b4NlaBgvncvM48ULRJ0XPUNK1z+2ye3IQe90QTm9qk2fGK4gKxnA3Yf0VQLs
 XzphJWvUq8zfMDjZokcGzae/KB7hiBmGevUNO3vBVVEwDerwHYVGrcYfturUyx8FeYI0
 qCDw==
X-Gm-Message-State: AOAM533rprhpWQMLq8XYz8VNR0qaB5bgm5eUZFScMmlvvOsR9drYP1uJ
 keyriT57UIxYDOFX2zVNBOLcgg==
X-Google-Smtp-Source: ABdhPJxFgCpz0Tr3yR3J/h+CulR4O67CYepxBdICoMBSME41Ibjc9P2FhWI9Jz3iszjTH1K/mjzkMA==
X-Received: by 2002:a65:5241:: with SMTP id q1mr6163039pgp.143.1611676212261; 
 Tue, 26 Jan 2021 07:50:12 -0800 (PST)
Received: from [192.168.4.41] (cpe-72-132-29-68.dc.res.rr.com. [72.132.29.68])
 by smtp.gmail.com with ESMTPSA id
 y16sm19967027pfb.83.2021.01.26.07.50.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 26 Jan 2021 07:50:11 -0800 (PST)
Subject: Re: additional ->bi_bdev fixups
To: Christoph Hellwig <hch@lst.de>
References: <20210126143308.1960860-1-hch@lst.de>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <b33aeb19-094e-c32a-2da0-33cff6f9e418@kernel.dk>
Date: Tue, 26 Jan 2021 08:50:11 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210126143308.1960860-1-hch@lst.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210126_105017_735082_D073275E 
X-CRM114-Status: GOOD (  13.09  )
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
Cc: linux-block@vger.kernel.org, linux-bcache@vger.kernel.org,
 linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 1/26/21 7:33 AM, Christoph Hellwig wrote:
> Hi Jens,
> 
> more fixes for the (so far theoretical) fallout from the ->bi_bdev
> conversion.

Applied, thanks.

-- 
Jens Axboe


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
