Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3AFFC433F5
	for <linux-nvme@archiver.kernel.org>; Wed, 29 Dec 2021 17:52:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
	Subject:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=A/2gYt7+YP9UcYI5ZhLAWGb4uFFavysWqDWMBAaUFlU=; b=tekb1+FuevZrclScHjSiytYhtf
	QMugp7wF72a+Hs+p7+vZXOmHW8kZG+2Gkx093JlR/vrfv3m1BzKEYkqQ993hz5tdxhxFiDuDdvloY
	Z1x08MX3OpZ1dtzAeAx8GL1yfgQJAJK75RjNJwgZAJDO+FQvrVu0m5qbvhPmnW6TnfOKJmHNGergI
	ZKDlp9/UmMKqm4jvXSSRiy6ymcnJior7wc4T9alMk3bjxTS6iG7ktU2wUoDaK6CneYMobFposC7Ue
	+LwT0LvPQGnOzU2TZYkBmBMH46rtMoSN5WCV8pE95yeAMCp+FC97BZbMBaHWNIMRQADW/8BzoSajH
	AjuhhvFg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1n2d7t-003G20-PL; Wed, 29 Dec 2021 17:52:37 +0000
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1n2d7r-003G16-Ci
 for linux-nvme@lists.infradead.org; Wed, 29 Dec 2021 17:52:36 +0000
Received: by mail-pf1-x431.google.com with SMTP id q3so14977030pfs.7
 for <linux-nvme@lists.infradead.org>; Wed, 29 Dec 2021 09:52:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel-dk.20210112.gappssmtp.com; s=20210112;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=A/2gYt7+YP9UcYI5ZhLAWGb4uFFavysWqDWMBAaUFlU=;
 b=huwwDH+xrplC7VzvJ5V4Dru7OTPWF9La2yM2+kJQr71amL0mUt7WB59PDn5iuF0ouJ
 ZSVfleOOlN2y620iRt3ckxYtqDMM9m/O+QhuUKm0OalyAau9s0XnGxh3+nheKYEKUL1f
 MFpuQr+P1T2XeqSV/w9s3V1uzFhriU5vAoQzdpEF7vreKiavuQ33t2PrEdSMulKYTUBI
 9R0apJ79ezIcIE7uZgIJiJOJVqk3FkV/Vx8ZYFbdWjHhB4x/SQaFp4WcuTQ1MytnsY0i
 RZYP1BQPvq4FTvvOh/7ckbjl1r+ZE4Rj9NIK+lhWfGrcjySFYPthQv289Ju1soAuIIGG
 mROA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=A/2gYt7+YP9UcYI5ZhLAWGb4uFFavysWqDWMBAaUFlU=;
 b=2IOVsLJ9o2abWz4f/CCg3pSd3klgCzQIEDrlpo8R6Q74VuK97iL+SrIFyGhg1GZcY5
 7G8Lmd9MT1ncK0bozuDhTfunvwAgd6ZaECTyuWjZCicYrm1pR38P/DSSvXyq7lXx/sFb
 Vg4Mw8OEKKav0+noN4cNpawHopVfrJ6Yuh1VxlHlMvUE+WCouhI5HHdZ8LcM50zaZDmY
 X/6+jI0GPaTOEvASNNzSEXGIlod3A5f18JjBW3m5/5ldZLGtTy59muT43/IfYLdqXq7J
 3ZSHdmKV+TYgCjTZO7mWxPNvxnw5Q8bEL9yhu1SHj9gUMcqtOP9UHUf/Hp5P7xFA2gFf
 2bKA==
X-Gm-Message-State: AOAM533rwjQMTRXPF8OgNBaU5HlY2DgLqd+di2srmgVr+plHiNcU8agD
 MuQjfdI/B7BUK6pfRV7PytnISbeeT/zqpw==
X-Google-Smtp-Source: ABdhPJzZBGkkaqsZSRforFyh/+anNj7NrfXL8PCrrdRRH5KvVWJRUHPXcFnwXtT/IFg1oTZkML2xNg==
X-Received: by 2002:a63:82c8:: with SMTP id w191mr24149180pgd.92.1640800353669; 
 Wed, 29 Dec 2021 09:52:33 -0800 (PST)
Received: from [192.168.4.41] (cpe-72-132-29-68.dc.res.rr.com. [72.132.29.68])
 by smtp.gmail.com with ESMTPSA id
 qe14sm21183393pjb.44.2021.12.29.09.52.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 Dec 2021 09:52:33 -0800 (PST)
Subject: Re: [GIT PULL] nvme updates for Linux 5.17
To: Christoph Hellwig <hch@infradead.org>
Cc: Keith Busch <kbusch@kernel.org>, linux-block@vger.kernel.org,
 Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
References: <YcyVq0hj1dPtRiGp@infradead.org>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <38daa193-e3e1-dc3b-3069-bccb3755f63a@kernel.dk>
Date: Wed, 29 Dec 2021 09:52:31 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YcyVq0hj1dPtRiGp@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211229_095235_459138_BFF1E149 
X-CRM114-Status: GOOD (  11.42  )
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

On 12/29/21 9:06 AM, Christoph Hellwig wrote:
> 
> The following changes since commit 3427f2b2c533d97bcc57b4237c2af21a8bd2cdbc:
> 
>   block: remove the rsxx driver (2021-12-16 10:57:04 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.infradead.org/nvme.git tags/nvme-5.17-2021-12-29

Pulled, thanks.

-- 
Jens Axboe


