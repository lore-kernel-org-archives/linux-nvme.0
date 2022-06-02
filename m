Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 445B9C433EF
	for <linux-nvme@archiver.kernel.org>; Thu,  2 Jun 2022 08:05:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=CqOoFv5ajKhhxuaIXwvvd9yF2mOBWHc6FT8FH9XleP4=; b=zvYy3pM46AI/C3qCPBDNevm6fY
	6s/ASHNjC7TCe8yYNS4VBBJuIijDkjqyMLSjw+ALdJZFcVtxISGAB11BDzM27tEgcy7oBcT6yvCoH
	AVDEhzLEc/VV9mtg3LFVhzvLWGuBvPFI4LqoKL/sV7JT0Q+RfwE8V+sUCAwEcpDo9+RROMB58cciG
	RZbe3vYNb8Ix2xO7ZeQUoTfCKgJtMY9rCVLOI8v5nbCiGGYG1ySeyT5Vw2CPvwR5SU9uqGZCmAKRz
	u8YXVxYdL+3PhXhEKBgwr/YeT5Crm4zoCbk+mRexH1SL4aJXIwi0Stlzu+dlqApTairCmWI5+WgHQ
	0fEKhBLg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nwfpx-0028fS-JG; Thu, 02 Jun 2022 08:05:45 +0000
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nwfpv-0028dX-G5
	for linux-nvme@lists.infradead.org; Thu, 02 Jun 2022 08:05:45 +0000
Received: by mail-wr1-x433.google.com with SMTP id q21so5409670wra.2
        for <linux-nvme@lists.infradead.org>; Thu, 02 Jun 2022 01:05:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=CqOoFv5ajKhhxuaIXwvvd9yF2mOBWHc6FT8FH9XleP4=;
        b=dUEHQ0iLv5JTPM8zRlQ2Xk5Quzir1yaICVyODgCYssqVnR7oCUfDPh7WVPI7fbnAXf
         YmTbwmormFhGjp8219I9Kt+r4MqHPUk5uroTQeciDbu2NBFDQ8sMD8PeUsepfUyDI/iE
         4CXeJ3WyCGNMRm03y07B5wuLf3+qDchEcQ4wcDWsihzlhvo55vCJTjmrJDTIuo/KV6u3
         keDpgvJNAtdowjc5BgEpx/fSJjVFwDD9FGS+mUDZu8C3vHJz4WBU5/bMVHJoF5tHvsaD
         KrGZe/2MmASd72xISXRjkgpCWylgKlYz2k+wU5VyLfm6mTE0S/lt1Ozv0Y9D93JlYWgk
         5MPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=CqOoFv5ajKhhxuaIXwvvd9yF2mOBWHc6FT8FH9XleP4=;
        b=7zJUqpPdszdMTQ/xCBFzguBtuFncz5D4cpcLUlK3Xukr5QoCshw+t+ujWOhQe6T0X8
         WjDDbSF3WWBzKTQT01BlJGQy5Kqy86ESsa1RiqcOopVIHRJaRHuTwFpHTIpCzDDysJQz
         Rl4rBMOFfoon0AQjVeVNfTTAgwmwgjdKQ2gTyWLBGr+SbfXA7/tv5R46f6kf8SZHQNCb
         7GOZXpLwg/TkCohunNnLXHQp2awJXxhn48NjcQjGp6fqf3F60PG7vcpgYWBx3oG8zCy6
         OY9eGVb65waQid7g8omD2yVFyovD92JUnCfwXZGZIZmYqLmbqhAfruNW7URuJyUeVDcn
         kDgA==
X-Gm-Message-State: AOAM532SS/dzJcvgpyrH3pdtPar0XStKhFLoJj9BNKWQ5HMdmNeZXkd2
	V0IAxyLBFUY3vbvneK2mfmnoei+E68ermK1W
X-Google-Smtp-Source: ABdhPJyVe7JZW48l90LBJZKfQaeiwP+tN9o+v5/aRcI01HsnqA/Dtwqg+SouYLPIhJ1nBazalS6rSw==
X-Received: by 2002:a05:6000:1b8d:b0:20c:d372:f07c with SMTP id r13-20020a0560001b8d00b0020cd372f07cmr2535752wru.607.1654157141231;
        Thu, 02 Jun 2022 01:05:41 -0700 (PDT)
Received: from [10.40.36.78] ([193.52.24.5])
        by smtp.gmail.com with ESMTPSA id v19-20020a1cf713000000b0039c18d3fe27sm4151716wmh.19.2022.06.02.01.05.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Jun 2022 01:05:40 -0700 (PDT)
Message-ID: <f333ef06-6aab-81cb-e998-44b91670f9ef@kernel.dk>
Date: Thu, 2 Jun 2022 02:05:39 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [GIT PULL] nvmes fixes for Linux 5.19
Content-Language: en-US
To: Christoph Hellwig <hch@infradead.org>
Cc: Keith Busch <kbusch@kernel.org>, linux-block@vger.kernel.org,
 Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
References: <YphKZBtmtKFRNIPL@infradead.org>
 <2ae24afc-6474-60f3-ece0-fb5a1d19f8c5@kernel.dk>
 <Yphtx84vMpkX+bsb@infradead.org>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <Yphtx84vMpkX+bsb@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220602_010543_594151_B6D58CDD 
X-CRM114-Status: GOOD (  12.77  )
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
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 6/2/22 1:59 AM, Christoph Hellwig wrote:
> On Thu, Jun 02, 2022 at 01:49:09AM -0600, Jens Axboe wrote:
>> On 6/1/22 11:28 PM, Christoph Hellwig wrote:
>>> The following changes since commit a1a2d8f0162b27e85e7ce0ae6a35c96a490e0559:
>>>
>>>   bcache: avoid unnecessary soft lockup in kworker update_writeback_rate() (2022-05-28 06:48:26 -0600)
>>>
>>> are available in the Git repository at:
>>>
>>>   ssh://git.infradead.org/var/lib/git/nvme.git tags/nvme-5.19-2022-06-02
>>
>> Eh, I can't pull from that... I used the usual git url with this tag.
> 
> Sorry, that was my push url.  The external facing one is:
> 
> git://git.infradead.org/nvme.git tags/nvme-5.19-2022-06-02

Yep that's what I used, and matches what it should look like. All queued
up.

-- 
Jens Axboe


