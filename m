Return-Path: <SRS0=NQX9=DP=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1426BC4727E
	for <linux-nvme@archiver.kernel.org>; Thu,  8 Oct 2020 15:48:28 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 983FA20739
	for <linux-nvme@archiver.kernel.org>; Thu,  8 Oct 2020 15:48:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="oallRmnZ";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="M8AdW+n/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 983FA20739
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=19cbGsBkRNPgg7cMa+/IVPJrOwZ+Mzr8TgKLvr/+B5M=; b=oallRmnZcgk3w/DkcXLOLKUf/
	3g0gxg592xv5qstmPNwV+CJ6NTTOLlmQ4w3Nx21/yZrEYAR2bM6mC03nLVvJVGPiYrAN7eaBXLEhj
	MPS6/OrrrEhkjLp5nr/os12use79wFVxo7XrNw+9WRPYCdVgLbyDXSrlNXS3ZmmVGP3iA2T8nOUWR
	YvhtgdbO29cEdlmBcARh95s1+gwfJdHy9GV7SCsoHAIbCFNJ57HBgqD8sA6fItkwKdRdgwnaK0KxM
	iWYVmiBVI+jQL/DelqWxm4p607taV0bAY0eBnUKo3S1AH0scKsCH3dgwBuImjeQU/mC4P7A6elMFr
	WWx0fudDw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kQY9U-0002Xi-TH; Thu, 08 Oct 2020 15:48:20 +0000
Received: from mail-il1-x141.google.com ([2607:f8b0:4864:20::141])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kQY9M-0002U3-GX
 for linux-nvme@lists.infradead.org; Thu, 08 Oct 2020 15:48:14 +0000
Received: by mail-il1-x141.google.com with SMTP id b2so6153646ilr.1
 for <linux-nvme@lists.infradead.org>; Thu, 08 Oct 2020 08:48:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel-dk.20150623.gappssmtp.com; s=20150623;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=CZNHoHKR5jVBV9HJSR3SvdvPnSVPLY2dCoFYQlqfRoA=;
 b=M8AdW+n/tvCr2kgpjYflBK9OQKj9sld6K1kLL8LDYxaQg7ILWOVyu9HsBWfDPthqZm
 RpkJDyTQ1T67OkBfVHrBEadjfc3FCUm76oHBYJ7819ryR7/DgAZE+v8wbbkkBh6fJ1Hn
 tV3elI5PRKFSz+EqV6fGwJb4FVwHVwiHlPsI9B5S7v0ic6eqDjZFFiDdODnZut8m6KEv
 X32mAEk3+y3Fy6YyzjLHwJzDqjI8fUgy1qFhbLz17S2T5YJPIuUwTmiah1CFXQkjbmV6
 nJS7fCO/3QaXxTe7R0QO6gLGAwf7mFAManqG12onaIJMb0N9QJQT9gRiyHWH7Xqfp2pV
 cg5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=CZNHoHKR5jVBV9HJSR3SvdvPnSVPLY2dCoFYQlqfRoA=;
 b=SZdv6H1/CofBNy5Kym7KgPxgo71BSpJiRg1GNcVUgDtgWj2D3LBCuuZ8IwWo8nwSQ/
 b+FwuFcdkCwVvH5UDs/leXA3neyIcBeH9xpRSRnj94X8OIDONRmjzAd7IwlLyso4qwKu
 vk6uYCyMqdU0DnPBOiiljl48rtwnUFuxYgmkviWVeZTaxO/s64nQVxguqicezo2IvXjw
 MBBfn8lCtWkSmzrjUp7HKg5h3xUB3Vu4DWwug74uzphjDOqdeoYo6ReGTd6vgP3Er9wf
 B58rnxvdXAt7ExbNaS4EgTNOQSST5IW8qtuPeC0Dur40pMvrnrI2U2crCYl8iClW4ZeR
 6O6g==
X-Gm-Message-State: AOAM5303aJiI+4j9GZQH2/Q4e5ED4yDK67kpBsu5KgqyOrZeS81JqUvH
 x9NEgk6i5BYitmUhY8PGaGS9JnV6axmbgg==
X-Google-Smtp-Source: ABdhPJyqdUGO1UO/ML20DKjXGkngT1OTfRPxZetNXrAdhtJfDzy3vJ+LICZj3xKbh0sqG13qkDGm/w==
X-Received: by 2002:a92:5e42:: with SMTP id s63mr7413773ilb.205.1602172090379; 
 Thu, 08 Oct 2020 08:48:10 -0700 (PDT)
Received: from [192.168.1.30] ([65.144.74.34])
 by smtp.gmail.com with ESMTPSA id r15sm2814537ilj.43.2020.10.08.08.48.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 08 Oct 2020 08:48:09 -0700 (PDT)
Subject: Re: [GIT PULL] nvme updates for 5.10
To: Christoph Hellwig <hch@infradead.org>
References: <20201008150125.GA1495381@infradead.org>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <78afe105-d7c6-997c-e4e6-13a6e3f84e7f@kernel.dk>
Date: Thu, 8 Oct 2020 09:48:09 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201008150125.GA1495381@infradead.org>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201008_114812_611891_26FDFB6A 
X-CRM114-Status: GOOD (  13.84  )
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
Cc: Keith Busch <kbusch@kernel.org>, linux-block@vger.kernel.org,
 Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 10/8/20 9:01 AM, Christoph Hellwig wrote:
> The following changes since commit 103fbf8e4020845e4fcf63819288cedb092a3c91:
> 
>   scsi: megaraid_sas: Added support for shared host tagset for cpuhotplug (2020-10-06 08:33:44 -0600)
> 
> are available in the Git repository at:
> 
>   git://git.infradead.org/nvme.git tags/nvme-5.10-2020-10-08

Pulled, thanks.

-- 
Jens Axboe


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
