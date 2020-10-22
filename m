Return-Path: <SRS0=3deH=D5=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15EA7C388F9
	for <linux-nvme@archiver.kernel.org>; Thu, 22 Oct 2020 22:04:31 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 771352245F
	for <linux-nvme@archiver.kernel.org>; Thu, 22 Oct 2020 22:04:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="HfU+IMyK";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=osandov-com.20150623.gappssmtp.com header.i=@osandov-com.20150623.gappssmtp.com header.b="af2WcgEU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 771352245F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=osandov.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=Jjft0blI3nzIBboCmn+ErSenFkH0nrUNjcpu4bghuAs=; b=HfU+IMyK9gJHuez4Gt4iiwNae
	pBukd5oHetiVqYHmfk7TvPMOPyy6ksyslUzhOinR6FE1Fbc93MzksOvjfFN8spZv6NVVkMAxGNa6Q
	zCmk1rf5Nd9AjXfAoSMPsx4bGvf7DCk7z/0iBGReXNF8ClQS+zVRWEa4nzmVPZDTtbhLqW4vRy/P9
	CQpxBYSWb9AeA31t0rnZJSaox5fpflST6S8k6Q6XnZEv3TPg1exh5+PrQPpYCjcS4pnvYuBnCbafD
	5EKKugd8PkHPe7eISn/pnWaYhXx+/S4GzwBi4Fsh+j/ZK8qhJh8l3XCqf13mc/O0ja/ohQWcT6p8J
	L0Vh+9ksg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kVih5-0002gV-Qy; Thu, 22 Oct 2020 22:04:23 +0000
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kVih1-0002f0-QK
 for linux-nvme@lists.infradead.org; Thu, 22 Oct 2020 22:04:20 +0000
Received: by mail-pg1-x542.google.com with SMTP id l18so1881662pgg.0
 for <linux-nvme@lists.infradead.org>; Thu, 22 Oct 2020 15:04:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=osandov-com.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=dUyWZKQk6Jd509JR1HWnGlhG34ZF3RzE+ItR8/csEOI=;
 b=af2WcgEUhMVdVEHg2sk74MHZXBT5DxoLwOBS00xAz5EohLXoViwwSmaU24AWRLzOZ6
 zYMUuBSqeYJ/qwD4xXLIAGGh58KA7lRlWvv/+eYhcdQ+erGUd2LKD0srl8w55Y7XV0F4
 j+qGHjaPGeR6vtPbmiQllPHVBLr0CpNir9LOJGXQK3w0qJsIYHFCJoDC3ws7MrB/IQ+G
 1IYlCLL0TFT2TvDhogL7kls8VQDccjVT+uV0djRG3tplfsjuK4UQYIre67O2aN5RgTJC
 YtjdV6iMnesCyRXjZ+RVKmg95xHsNCS2fZMH6eaO/S05rWYT61QMtwSjaqAQDS9YMtI9
 50TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=dUyWZKQk6Jd509JR1HWnGlhG34ZF3RzE+ItR8/csEOI=;
 b=a1cs2MXgsuQLWIRoSke7wZDlToixOqvZMIzBrcUvU3sRFd345YKo2W+opJ2gPZHoyt
 935YeZObCK6emO7gvByiGw0oilSQsHsnl2ls6HEXeueMdvwIXJN093NK0jb1lRiMtXR/
 1GfIlhS7NcWnej6oBN3YZQm+ZS1H3YD4R7nLQGP9zsIfBQsjGG+UArqF0I79HC7XLaqT
 frcFXKO1Lyxj9HLtPYO9uGgGEaAjrXp3Sh/0DRBKLaIl5omvs93zCmrxq7CmAvr/uElb
 pZhpU2VsFT1E3Irdtsvmc6gObEMR9FQBaa3Tyg8bzqXTggXRpJN+VNGD1qfTP8jVbmYU
 Jwyg==
X-Gm-Message-State: AOAM532nlewZFCTMrrzp8So75W2yUi1Pi0lCthJ5IIhRiy3gY2o7bJV5
 jJLqesHGHLlmGBjL7CK8Yu05Dg==
X-Google-Smtp-Source: ABdhPJwcEQ3YeUH8ovZald8QJXaj4Ky438QGFKsn+C8K/zktkNFvlI8EP4KTVhCTcviIo4d9WpYQ7g==
X-Received: by 2002:a63:4c6:: with SMTP id 189mr3900717pge.233.1603404256042; 
 Thu, 22 Oct 2020 15:04:16 -0700 (PDT)
Received: from relinquished.localdomain ([2620:10d:c090:400::4:f799])
 by smtp.gmail.com with ESMTPSA id y10sm3329203pff.119.2020.10.22.15.04.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Oct 2020 15:04:14 -0700 (PDT)
Date: Thu, 22 Oct 2020 15:04:12 -0700
From: Omar Sandoval <osandov@osandov.com>
To: Logan Gunthorpe <logang@deltatee.com>
Subject: Re: [PATCH blktests v3 00/11] NVMe Target Passthru Block Tests
Message-ID: <20201022220412.GB1006674@relinquished.localdomain>
References: <20201008164024.12546-1-logang@deltatee.com>
 <29f3dc94-50c3-1548-034e-09c5394ef781@deltatee.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <29f3dc94-50c3-1548-034e-09c5394ef781@deltatee.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201022_180419_996749_5FE67604 
X-CRM114-Status: GOOD (  13.00  )
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
 Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, Stephen Bates <sbates@raithlin.com>,
 linux-block@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Thu, Oct 22, 2020 at 12:45:25PM -0600, Logan Gunthorpe wrote:
> 
> On 2020-10-08 10:40 a.m., Logan Gunthorpe wrote:
> > Hi,
> > 
> > This series adds blktests for the nvmet passthru feature that was merged
> > for 5.9. It's been reconciled with Sagi's blktest series that Omar
> > recently merged.
> 
> Bump. This has been around for a while now. Omar, can you please
> consider picking this up?

There were a couple of shellcheck errors:

tests/nvme/rc:77:8: warning: Declare and assign separately to avoid masking return values. [SC2155]
tests/nvme/rc:278:7: note: Useless echo? Instead of 'echo $(cmd)', just use 'cmd'. [SC2005]

I fixed those up and applied, thanks.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
