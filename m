Return-Path: <SRS0=YOZe=ER=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB373C4742C
	for <linux-nvme@archiver.kernel.org>; Wed, 11 Nov 2020 09:22:31 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B47A2067D
	for <linux-nvme@archiver.kernel.org>; Wed, 11 Nov 2020 09:22:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="pB90fsFw";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=javigon-com.20150623.gappssmtp.com header.i=@javigon-com.20150623.gappssmtp.com header.b="ovy9ByqA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B47A2067D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=javigon.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=oY8po+ni9PAg8Lm7pCJSXgdNjZl2ZKn8lFPE9XuTBCk=; b=pB90fsFwjtJU1b+uMN5vmYjDa
	skhuS9FkEpMIyrKkvVqYsRWgGwJ4+pW/w7ab/UVpBF9yckQt9NMaNpwRJDjy501w+Wx9Vf6S5oY25
	ShjKKqnrN30eB9JhUia5fK3wERFQkbvbfUUwD+vYzyJrHyoj5YuZTaNdAPO+DRTp4u1pmIuUXj1R+
	0kn5rVM0gE7/85z5jX9vOGLbQIkWS5ca2q0mTDEUsDONtbu0HlpKeXNk/c+TIAieEjlbSxYt0kR5I
	+0DgZ8ewA2TRPXu4rI6wMQZhoJjz6/NIEB895gjsi0HF8QJEbL4AjuO2/0hvPtVuCU+eRrWlvN+Rx
	PNRn2wcJw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kcmKa-0002s0-Lt; Wed, 11 Nov 2020 09:22:20 +0000
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kcmJm-0002Tz-ED
 for linux-nvme@lists.infradead.org; Wed, 11 Nov 2020 09:21:32 +0000
Received: by mail-ed1-x534.google.com with SMTP id e18so1528555edy.6
 for <linux-nvme@lists.infradead.org>; Wed, 11 Nov 2020 01:21:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=javigon-com.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=0Q5zxvMuV3Azks8Ot8yG9MlzIKDLAnbtKky+Zy7lFTo=;
 b=ovy9ByqAVRH79WjGKXbFwo7C6JmauMHkytViMDqh3ab1Wy4iGWqtglsJiodVPA4AVa
 gW26kDW53ZFkJwHEk/WPSLrLbNNcH7ps8hKSVmiwKGExvECfD5mzdKLAYhoyu8giouDR
 xphGtC20qdUl+B3MLakLRdgEXbCWeKBJ2so9DsxkEZZqnuZC2pgARfXWC/EL5zj21HBe
 f8dXlLp3xiaxqnnW14TvuFAsq0NAlyCPQPCYizFtCvIxNx/IRCb4hiDg/6nNEoTCvPZl
 0o3uqd1/dpP5sVKJYX7JTC4dIsDAh4rSO3I3RnMSjbvh4vr0L57Xehis3Ld1V9MmkFbw
 5hNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=0Q5zxvMuV3Azks8Ot8yG9MlzIKDLAnbtKky+Zy7lFTo=;
 b=RWXRirDPCTjWWDNEsAAr8MUcIyP+eaAV3yGYlblh3lQYDWiXoqHJxRVdDCQLAT8O2H
 HAdBVvfwhGfYvLySdlRWMswh7LXuV0uTiPXMpViLsvun88JLcItoFbWDCDGCN/KWurjP
 ZK0k7bBgcGAH9wbGWXKHQgXLkBF2rQcD6WqhX2WEZnvsQIMBy72IMwpLdkW9cmlMyvce
 m0rpZHj4JxgvgAL4X9+LVjL7nWWUaORIPuKRKXNOMTGcEiLjE6k99buLAlSncrImR4A/
 gyK+5nOyAd1bBw4IJI6xusXq2gHPlUIkWVomx6BXBUK7xOqWIBEqLTZqUNxUqPyOhOOk
 nqQA==
X-Gm-Message-State: AOAM533yiev0PhfHR7g+009LaWlShEUtR516TYHEFNDBZdbutmjPAMv/
 0dOSKdFBD9q2w6M0qzFTaLU82A==
X-Google-Smtp-Source: ABdhPJzGmXFCrl6cG26vGGLly392mTClcMtd5NDXKHm4xd+EVZxauYh7lT+zZkeS0/qnoJe3H2Z/Ug==
X-Received: by 2002:a50:d885:: with SMTP id p5mr3783825edj.169.1605086488511; 
 Wed, 11 Nov 2020 01:21:28 -0800 (PST)
Received: from localhost (5.186.124.214.cgn.fibianet.dk. [5.186.124.214])
 by smtp.gmail.com with ESMTPSA id f18sm634293edt.32.2020.11.11.01.21.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Nov 2020 01:21:27 -0800 (PST)
Date: Wed, 11 Nov 2020 10:21:27 +0100
From: Javier =?utf-8?B?R29uesOhbGV6?= <javier@javigon.com>
To: Sagi Grimberg <sagi@grimberg.me>
Subject: Re: nvme: enable ro namespace for ZNS without append
Message-ID: <20201111092127.hue2hhdugkxy33ff@MacBook-Pro.localdomain>
References: <20201110210708.5912-1-javier@samsung.com>
 <20201110220941.GA2225168@dhcp-10-100-145-180.wdc.com>
 <87931ded-b17b-90b2-c5b2-a1a465d109cc@grimberg.me>
 <20201111081530.GB23062@lst.de>
 <e8f50827-4bc9-7300-0f8b-ed0a854fb50b@grimberg.me>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <e8f50827-4bc9-7300-0f8b-ed0a854fb50b@grimberg.me>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201111_042130_658057_CE707DFE 
X-CRM114-Status: GOOD (  12.06  )
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
Cc: axboe@kernel.dk, Niklas.Cassel@wdc.com, joshi.k@samsung.com,
 k.jensen@samsung.com, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, Keith Busch <kbusch@kernel.org>,
 Christoph Hellwig <hch@lst.de>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 11.11.2020 00:36, Sagi Grimberg wrote:
>
>>>>>-	if (id->nsattr & NVME_NS_ATTR_RO)
>>>>>+	if (id->nsattr & NVME_NS_ATTR_RO || test_bit(NVME_NS_FORCE_RO, &ns->flags))
>>>>>   		set_disk_ro(disk, true);
>>>>
>>>>If the FORCE_RO flag is set, the disk is set to read-only. If that flag
>>>>is later cleared, nothing clears the disk's read-only setting.
>>>
>>>Yea, that is true also for the non-force case, but before it broke
>>>BLKROSET so I reverted that. We can use this FORCE_RO for BLKROSET as
>>>well I think...
>>
>>Let me prioritize the hard r/o setting.  mkp actually has an older patch
>>that did just that which I'll resurrect.
>
>Sounds good.

Cool. I'll repost fixing the log page update. I can then rebase on the
patches you send for this - or you can put them on top if it is easier.

Thanks!

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
