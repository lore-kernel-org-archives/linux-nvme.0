Return-Path: <SRS0=dOZ+=AN=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 388AEC433DF
	for <linux-nvme@archiver.kernel.org>; Thu,  2 Jul 2020 18:12:08 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 063082073E
	for <linux-nvme@archiver.kernel.org>; Thu,  2 Jul 2020 18:12:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="hCV6LWHF";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="vIkkeK1f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 063082073E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=HwrB9CEKW4xa5NIglYQthOpKgSztSL9TZSlYzzIiRA0=; b=hCV6LWHFFZOlpmusAe0ewSf6c
	XlZV+2cLo6yYVw4hZyLX7P/rG3WfCvkR6HUgwI+7r2ESaNkkLuErnVyME3IMdT7fBcVhafzdcYo3K
	+xekJqRO7PUO6pRwC/epI9L76V4qVFKSkFdUR5aBzObLzcsyUjMJ9qPyZu19wa/ySN85v53m4idIR
	h7ri7kRVQCFgbzQ5BCBGdq3tytu+mH9uIjMbbKEOucrrTBauojCgqDGQQbcAoPN5GaJ1JjywuhzLV
	eDYw/02KITMenIlQI2nejW7t2P62vQidUYqpoiw4GZC1yCEpT3d5KfhUCYfQ0BmBI01neijqyqbN7
	5reQGxthg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jr3gm-0000P3-FA; Thu, 02 Jul 2020 18:12:00 +0000
Received: from mail-pj1-x102e.google.com ([2607:f8b0:4864:20::102e])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jr3gj-0000Ne-Nc
 for linux-nvme@lists.infradead.org; Thu, 02 Jul 2020 18:11:58 +0000
Received: by mail-pj1-x102e.google.com with SMTP id o22so7799879pjw.2
 for <linux-nvme@lists.infradead.org>; Thu, 02 Jul 2020 11:11:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel-dk.20150623.gappssmtp.com; s=20150623;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=+xvSQSVLi9qjNChiWcvmHMeE7PdhPj01xUVBnDWHVZo=;
 b=vIkkeK1f2M+ZUIi5TVUzVnaCz+/9ofM6TeInaeP9CX3/4+fPgzDwbKEajj9m+RV+Ze
 vLr9D5cHB0p1+T5DsrPksUaxjz5/JNK47pTpeU7FSRyzvJFuXZ0V/GwCQGoQC/PjqPO6
 STDhWeVA5RXbt+1MXg7aHXNfFb/Gee9wvkcXulQu8aCEfoybYv79YpGbV9ogiwgJtErI
 quSn9+G13Fnv8KBYH5m6kig4YkQaPQ6rerf4VMv2XyXPRgz+m9KHcgDcpyO7di12qSC+
 Q6QxMU7Ur5KHnwvbwQz18xFxXGA+An7R2wOrIsK9QzK+YReEDKgGnM1L6DD32UltYQIO
 o+vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=+xvSQSVLi9qjNChiWcvmHMeE7PdhPj01xUVBnDWHVZo=;
 b=KTgj73SYVKk8wU3GpkK/UW+PeJCobjWuM/XhMhDTDHFwbP+d97yLlCmXAOK+4lkDrl
 z+H7JWGFVFxdH/sySLxxPfMr+3KsP2XPPvYRgSHMEtK81ZSTMPj+vZGqLv7UziU6CnFK
 N0LhGTwKepkEkBFR3GCezt5BjYaUtjX4g/D7pnOIcUCCTPlQN1n3fPmCrpq1/XoOzApB
 mz/hwmVK9ahjdQ6Rc374/inOzW52qTOflew+qL4o9IGrA5AfHcnnZFJBqh1fJdSxFQCK
 gSCh84c6H+S8Et+8wFSWoWuJ3d62G0TKzzKc06XTCcAut3cwudZg2DWtagaUsOd2p11k
 oqeQ==
X-Gm-Message-State: AOAM531S0rbcKpU5KZz5I0eXWkb6SoWpu0LT0uDKBwBAns5udD8lWeHI
 jtujsYSvRLTOPqj/sC7tQahtulUcB+pk1w==
X-Google-Smtp-Source: ABdhPJxPWhlvrfExBBerGxc/tmSwb6mhWXRYPDne8ntGywD7UHhakw189oo11S3nWuDViuLXoJGQwA==
X-Received: by 2002:a17:90a:3489:: with SMTP id
 p9mr34276441pjb.56.1593713513925; 
 Thu, 02 Jul 2020 11:11:53 -0700 (PDT)
Received: from [10.174.189.217] ([204.156.180.104])
 by smtp.gmail.com with ESMTPSA id l22sm8238485pjq.20.2020.07.02.11.11.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 02 Jul 2020 11:11:53 -0700 (PDT)
Subject: Re: [GIT PULL] nvme fixes for 5.8
To: Christoph Hellwig <hch@infradead.org>
References: <20200702084207.GA3718469@infradead.org>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <8368fa84-18ff-5a7c-1549-c80b8fced17d@kernel.dk>
Date: Thu, 2 Jul 2020 12:11:50 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200702084207.GA3718469@infradead.org>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200702_141157_804732_C6CBED19 
X-CRM114-Status: GOOD (  11.56  )
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

On 7/2/20 2:42 AM, Christoph Hellwig wrote:
> The following changes since commit e7eea44eefbdd5f0345a0a8b80a3ca1c21030d06:
> 
>   virtio-blk: free vblk-vqs in error path of virtblk_probe() (2020-06-30 19:02:58 -0600)
> 
> are available in the Git repository at:
> 
>   git://git.infradead.org/nvme.git nvme-5.8

Pulled, thanks.

-- 
Jens Axboe


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
