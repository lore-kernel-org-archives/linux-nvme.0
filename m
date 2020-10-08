Return-Path: <SRS0=NQX9=DP=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF159C4363A
	for <linux-nvme@archiver.kernel.org>; Thu,  8 Oct 2020 14:53:03 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4FDF821789
	for <linux-nvme@archiver.kernel.org>; Thu,  8 Oct 2020 14:53:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="E8rE5TJT";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="1AWWo1+g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FDF821789
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=pkL4TB/S0348ytwbz/eioiWlm+VtTiLUcHfdyFJz8Ek=; b=E8rE5TJT6aIuxioVRhrZNsbsl
	BfbysYqIbbVtntH/lMxPBdtcEvysRS+0NMw2CVHq7P+tWlQpxoegrnXrGlDwGl7AKWQoXesUnqDhx
	iyjfsIIA27FBPZklrRWdteWCVMkw6V34YVRpks/q5jipCbGTvgf09zx2csoJHruBy96ugb8W1l2IJ
	G4UaTjoibcUFlv6x2FWmEclPyoS8ut8mfPl5Z5qJeOT3AO1RnYFXn2KNqKAIZK6qj1shI+nC1Xh3J
	lDbZ3H0SItXP0bjpHXCN+qn6uo9xxc3dtC5PByCtmJRTnCm8rHwPy5OlTWiwu1xx8LBvpLZtaunkp
	V9/GwD59g==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kQXHt-0002OY-Et; Thu, 08 Oct 2020 14:52:57 +0000
Received: from mail-io1-xd43.google.com ([2607:f8b0:4864:20::d43])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kQXHp-0002Nl-K5
 for linux-nvme@lists.infradead.org; Thu, 08 Oct 2020 14:52:54 +0000
Received: by mail-io1-xd43.google.com with SMTP id u19so6480779ion.3
 for <linux-nvme@lists.infradead.org>; Thu, 08 Oct 2020 07:52:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel-dk.20150623.gappssmtp.com; s=20150623;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=DniGGjTKE4v2KQx2b92S7YMddx7cu5sQYwDlNrFyG4o=;
 b=1AWWo1+go7rxZ4n8NsVCzA6SEFlGnEZTWyXEBQhU4RK0xNMikPk5r8kcnVVbDvJtks
 IWmA02/m8U2UXTAroCmj+0KVn/QO1+Jhg1wZrbBzXg4IA/6UkLM/SLJFri37Vy+C9ZDh
 Gt/WpeKnWM0xPFOweoYuu+rMzIR1MgQkJeSVS++bb7gk8NeD05DXtyiZ06V0kqVtRNIF
 A6hnGFw7Ml7dJVasnz2/orVScm55d5dvHQWhtkokYMtinIHS1JQ6zQRqzEf8kcq8C9FD
 +asSqXCVyGz1sdc05LHA675wXHbPe7wrb6pz+g4flYjTW/HSSa8dp9WwpotZ8KK7RsVD
 BdSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=DniGGjTKE4v2KQx2b92S7YMddx7cu5sQYwDlNrFyG4o=;
 b=FHD4M9i7svXufa0jsWhkvRehQC95z0ZdUYvwxTZq2ggekZKsqe5ZrRLx52Ydoi1J8y
 WesE8NlmUUMfdz2HM4YstwgniQfEnr+CG5vkqR4uI2PsFX07inukjQhisX7Q4CfpAHTT
 tfuFa6UMBNJpX/Dlto60sC5507pCfsweNNCBJ99mx2wGKCMI2FW2oM9huSWfUcRxMVJh
 Y7visge+mYBIV/zeRVNSWN5y6+EQHc1vDuE7oGWwqNYCN4qqH9g4M++ENdhEiiUdt40t
 8PcF19ZVPax6aJ3fHAPXXP0JlXpkH6LRs6P4Y+sN1k4kXG3G3p1vwnmweH5h9XgvHMo5
 sM5A==
X-Gm-Message-State: AOAM533RT0VAYn7589NoHOA5FkxJhUaLpuY62PfbZWNg39f8SKwhzNyz
 mz5kd/wCnSzOb0vl01OtEdboM3UX5MSY1Q==
X-Google-Smtp-Source: ABdhPJyAbg+e/or0gRB1zBJCj8noz5IOQmp6vRENMPQcGCtwR1vOzQpBDto/cvzgAPl96caPaCUtGg==
X-Received: by 2002:a05:6602:2d0c:: with SMTP id
 c12mr6178658iow.117.1602168771512; 
 Thu, 08 Oct 2020 07:52:51 -0700 (PDT)
Received: from [192.168.1.30] ([65.144.74.34])
 by smtp.gmail.com with ESMTPSA id u8sm2824968ilc.59.2020.10.08.07.52.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 08 Oct 2020 07:52:50 -0700 (PDT)
Subject: Re: [GIT PULL] nvme updates for 5.10
To: Christoph Hellwig <hch@infradead.org>
References: <20201008141041.GA1493538@infradead.org>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <2b4ad1d6-3d77-d14e-2275-0f9326b19514@kernel.dk>
Date: Thu, 8 Oct 2020 08:52:50 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201008141041.GA1493538@infradead.org>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201008_105253_660456_F5D985B4 
X-CRM114-Status: GOOD (  16.98  )
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

On 10/8/20 8:10 AM, Christoph Hellwig wrote:
> The following changes since commit 103fbf8e4020845e4fcf63819288cedb092a3c91:
> 
>   scsi: megaraid_sas: Added support for shared host tagset for cpuhotplug (2020-10-06 08:33:44 -0600)
> 
> are available in the Git repository at:
> 
>   git://git.infradead.org/nvme.git tags/nvme-5.10-2020-10-08
> 
> for you to fetch changes up to c4485252cf36ae62c8bf12c4aede72345cad0d2b:
> 
>   nvme-core: remove extra condition for vwc (2020-10-07 07:56:20 +0200)
> 
> ----------------------------------------------------------------
> nvme update for 5.8:
> 
>  - fix a controller refcount leak on init failure (Chaitanya Kulkarni)
>  - misc cleanups (Chaitanya Kulkarni)
>  - major refactoring of the scanning code (me)

Seems to be a typo here, 5.8?

-- 
Jens Axboe


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
