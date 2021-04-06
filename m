Return-Path: <SRS0=EEJI=JD=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C880AC433ED
	for <linux-nvme@archiver.kernel.org>; Tue,  6 Apr 2021 15:20:25 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 38CCD61363
	for <linux-nvme@archiver.kernel.org>; Tue,  6 Apr 2021 15:20:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38CCD61363
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=4bGi+y/SHK+a8Dmr9cG29VEwwui3uI+/pUSIlQDvfjI=; b=jNxjV82Nih/JTxUFFg9Oi6Cw/
	Yr2+MiDEBQ01yUdXhqGwm9/WY/HI3hccEj7TrTsX+syOcSrO/f37GChRgLWT/zNZyujaL+n/Hj5vV
	cxiN1lPs2xZGmVGP5DhFqY7bmcUq388H4M2PqzjHTA5l7rhvkl1WDV7z2sSNDRternWproteSHcqj
	c3IH7UcQcphdc7Mzka1Va4bVD7MD5yb01rRuOUVrSWK4mO6u50j6bjvTts63XEm/12SYv0ICxyGDe
	FVtpC0r65Si9aVuFGueisehfkLQFo6nIVIAy6K/4Q6iO/6OuthxxRvtc3EvmcIm6YGKR2qi8WcvpP
	btBf0G3aQ==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lTnUq-002ueN-9X; Tue, 06 Apr 2021 15:20:04 +0000
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lTnUn-002udi-19
 for linux-nvme@lists.infradead.org; Tue, 06 Apr 2021 15:20:02 +0000
Received: by mail-pf1-x42b.google.com with SMTP id x26so3928409pfn.0
 for <linux-nvme@lists.infradead.org>; Tue, 06 Apr 2021 08:20:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel-dk.20150623.gappssmtp.com; s=20150623;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=JC7snZoKdDIitoATLSQcRE7CQtGzaaPD9ACA1xAq/vs=;
 b=anLnEx+ItWHFlcrYYDZQ4zCpRpt/gLJPuFDotQZ9FBAtBSdIg6y0ejC5tRxbUvPlnj
 JYVf3HDRqTRVLZCzOeT9p6I0I/nXrg5fXnMwnhAhXW9tm1L3IYQMl2UenLMr5dKNcl5R
 d2PmHhhs7UGEDumqClRkcn0K9mJ57Nky3gK97JktGNZcSHWy6V+v8kipp0o7NLBTXURf
 XZC3PRkpq0s1/dafCphQtOjyOI2nArQ0U+ZOVxYQJ5h1QqfP4rTGwAIoQTKMcV4cuSSK
 33bkTdfPfKvEHfM7rN4QgQomDCSZBalslbWg8HSQmCCM5CcTRt+tTpy/BbwvKb0tXpXC
 BkZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=JC7snZoKdDIitoATLSQcRE7CQtGzaaPD9ACA1xAq/vs=;
 b=K2wruh0AJgtPgEyOpgc9kfU1o5/KAR+7sD3poY4nV5xka/AlsUmkfXoVwhrvR9Usn8
 x4vIixRthz2nXE9zmdF/B5qA//eZMUpo/HaXJaoUcTrvMB1f9IruONQRa8kI+oUCo2JF
 dghXHaONSuqxIR7+pDpVt3uENsaEA84FzM/pCa5/s+HAwCgEFkDrAhHhYtSWXeKZGmM4
 g5j1NIlk7SZGmhRMynX5WaWX1eGDD0DisjNPjEhaYYZDeKZbFJBewJwBcqunb3zWDWlj
 G9pgh4vCmWvN/+WLDYWz/j2XeZi4wtODHnn2vRRRfnxrWl4uQTAp27K2SCvwszYiRBw/
 13PA==
X-Gm-Message-State: AOAM532doLYwTM9i4Gt/2xNhcsOmHfEaWCU588FMlCNc+0ebnh6JfidG
 Ym4aOI0IOkkKnyGPPCs1n5oHDJYpPvCFTA==
X-Google-Smtp-Source: ABdhPJyEgwrZu35kLrX06uZeT8br+KCWTsJ22XW5RAUJO4SX4qKlwJEkJUmstt7Q2kGTMhqs2f+uwg==
X-Received: by 2002:a62:1847:0:b029:209:7eef:b14e with SMTP id
 68-20020a6218470000b02902097eefb14emr1858013pfy.3.1617722398365; 
 Tue, 06 Apr 2021 08:19:58 -0700 (PDT)
Received: from [192.168.4.41] (cpe-72-132-29-68.dc.res.rr.com. [72.132.29.68])
 by smtp.gmail.com with ESMTPSA id
 i10sm3373032pjm.1.2021.04.06.08.19.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 06 Apr 2021 08:19:57 -0700 (PDT)
Subject: Re: [GIT PULL] nvme updates for Linux 5.13
To: Christoph Hellwig <hch@infradead.org>
Cc: Keith Busch <kbusch@kernel.org>, linux-block@vger.kernel.org,
 Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
References: <YGwJ0h0GCC/118r5@infradead.org>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <a9c8ad42-529c-0fb3-5f74-95ea9a0f38d0@kernel.dk>
Date: Tue, 6 Apr 2021 09:19:59 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YGwJ0h0GCC/118r5@infradead.org>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210406_162001_175964_0C45F162 
X-CRM114-Status: GOOD (  18.33  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 4/6/21 1:12 AM, Christoph Hellwig wrote:
> Note that there is a conflict with Linus' tree in
> drivers/nvme/host/core.c.  Linus should take the version from this PR.
> 
> The following changes since commit 80755855f808c27c7154937667436f30e47bc820:
> 
>   mtip32xx: use LIST_HEAD() for list_head (2021-03-29 07:38:49 -0600)
> 
> are available in the Git repository at:
> 
>   git://git.infradead.org/nvme.git tags/nvme-5.13-2021-04-06
> 
> for you to fetch changes up to 8609c63fce58e94d82f6b6bf29c7806062e2e867:
> 
>   nvme: fix handling of large MDTS values (2021-04-06 08:34:39 +0200)
> 
> ----------------------------------------------------------------
> nvme updates for Linux 5.13
> 
>  - fix handling of very large MDTS values (Bart Van Assche)
>  - retrigger ANA log update if group descriptor isn't found
>    (Hannes Reinecke)
>  - fix locking contexts in nvme-tcp and nvmet-tcp (Sagi Grimberg)
>  - return proper error code from discovery ctrl (Hou Pu)
>  - verify the SGLS field in nvmet-tcp and nvmet-fc (Max Gurtovoy)
>  - disallow passthru cmd from targeting a nsid != nsid of the block dev
>    (Niklas Cassel)
>  - do not allow model_number exceed 40 bytes in nvmet (Noam Gottlieb)
>  - enable optional queue idle period tracking in nvmet-tcp
>    (Mark Wunderlich)
>  - various cleanups and optimizations (Chaitanya Kulkarni, Kanchan Joshi)
>  - expose fast_io_fail_tmo in sysfs (Daniel Wagner)
>  - implement non-MDTS command limits (Keith Busch)
>  - reduce warnings for unhandled command effects (Keith Busch)
>  - allocate storage for the SQE as part of the nvme_request (Keith Busch)
> 
> ----------------------------------------------------------------

Pulled, thanks.

-- 
Jens Axboe


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
