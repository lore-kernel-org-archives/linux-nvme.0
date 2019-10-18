Return-Path: <SRS0=X7Om=YL=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6A16CA9EA0
	for <linux-nvme@archiver.kernel.org>; Fri, 18 Oct 2019 14:50:21 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D8D621D7C
	for <linux-nvme@archiver.kernel.org>; Fri, 18 Oct 2019 14:50:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="HWvMdF4e";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="FQBz4UQP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D8D621D7C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=jlgbtMe+vdMwh5iuhcBGeTP9pUm6K7U6lhBTyYfUszw=; b=HWvMdF4enpQcZW
	betTeYroGEEwAp7MrTYjsVYmuCm+HPFFoHuSPkQhlvX89lT8XhqN3fNaQll01k6xza4rA1M5EvP62
	HenGfggOr7ypgIwWZDOy96YXu2ZI+ua7mVSpkPm5NxBZD279/3sfve/i4js3zvHOtB2D4evwyNtQI
	1rG0xDB+40PnU9+sstK0Bwr2YaANgP2LAKF6dNfeM/jvEuSoxsEkrZPsVDc7hZ63p6rcldEdVJypR
	fNkRKVW/2MA4D+qpgw9cqAd1bjl+og61S3Pfk5epWwDr6i9Xd3G9qYrHvFln4tr/BI0KUsi4KXJAr
	YHV+Q0SgvHFOywbpDpwg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iLTa7-0004mi-2G; Fri, 18 Oct 2019 14:50:19 +0000
Received: from mail-pg1-x533.google.com ([2607:f8b0:4864:20::533])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iLTZz-0003hV-IM
 for linux-nvme@lists.infradead.org; Fri, 18 Oct 2019 14:50:14 +0000
Received: by mail-pg1-x533.google.com with SMTP id k20so3524773pgi.1
 for <linux-nvme@lists.infradead.org>; Fri, 18 Oct 2019 07:50:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel-dk.20150623.gappssmtp.com; s=20150623;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=cluIrb5aTtYCQMt1KqwQbqniDgf/vLI6mSN7XZnOYo4=;
 b=FQBz4UQPF13SWJM6+ai6yuCNjteXWO5qE7/oONY7sIM/f+8/NbsxCB9G/fnjBDw+gN
 u6BxSEt1GmBPyJ8D64X+Ymoxf6Xl2kIaaHYp3XeDd4F9Utcx8HldU7ZPKdtM282FAJFx
 pZrAjFzqc+NMRnWYwiCp2ckqsNYPYLJbZNI5ObZT8o3K3tv6ggbMQQdofDtk2eQnKmaR
 W7Io8XcwP/Ih2pvBiyBndpZKPRup7Dv4YVn3bvfRZrXnQOE9FRnEU6kc7QSqQFaMG5jI
 HzZYeXwVe81dNSDRV+A99HQcmCrIzFE4595PCjBdqith3+qxlY/vYLpj6PbKE6tpxK8T
 xcYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=cluIrb5aTtYCQMt1KqwQbqniDgf/vLI6mSN7XZnOYo4=;
 b=LVNHsS2OgiG76BYs5b3lcKJ1DN5a+XpYZKL19jDgKuUSzcOJvJLphwLc/AA1t3pnQb
 +yPSmqjZlN0mTAKGjC1ZYeCpdPoMbBnrWBPg78CqF9hPq62eUDjZbTZI9Wwv7yLk4JqD
 RP/FMHQBWnmRz2R4OKaD1B3eN5FNcDlqXg0yNG4DdcF9iIgny47iPrvHwKoaxaYTF9B/
 ys/DcK/3ic6f8kbnfToivAa6YfuyhfVCdUhksFadhm4gA7/zNpJTCwknPVVwrZ+e83eT
 K77SVpYiiiMA7TU5KEKVfnEChyPuWdAQOr6P8GdJN5IqRYUepEqoRBUDM1bm4aEK3Gd9
 wyxA==
X-Gm-Message-State: APjAAAUY53SCnTN8cDhDoYKVSYQn7zgwg3ZPhptznih/beGYpe6jI6e8
 17yOeo4LNMcpnTORnqccyQKIHw==
X-Google-Smtp-Source: APXvYqwL8wEORBEBLy+IG8CwpH+hh5+9ifT7nOsy8chPp3rYNTpjB7vxo6vzc2jGg+ugjK/7nXxbcg==
X-Received: by 2002:a17:90a:33a7:: with SMTP id
 n36mr11124361pjb.53.1571410207542; 
 Fri, 18 Oct 2019 07:50:07 -0700 (PDT)
Received: from [192.168.1.188] ([66.219.217.79])
 by smtp.gmail.com with ESMTPSA id z13sm7820507pfq.121.2019.10.18.07.50.05
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 18 Oct 2019 07:50:06 -0700 (PDT)
Subject: Re: [GIT PULL] nvme fixes for 5.4
To: Keith Busch <kbusch@kernel.org>
References: <20191018143700.GB7124@redsun51.ssa.fujisawa.hgst.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <fca4561f-e24b-7ae2-b6bd-b84c3eb06158@kernel.dk>
Date: Fri, 18 Oct 2019 08:50:04 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191018143700.GB7124@redsun51.ssa.fujisawa.hgst.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191018_075011_950101_C2CA05A9 
X-CRM114-Status: UNSURE (   9.96  )
X-CRM114-Notice: Please train this message.
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
Cc: sagi@grimberg.me, linux-nvme@lists.infradead.org, hch@lst.de
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 10/18/19 8:37 AM, Keith Busch wrote:
> This is a collection of bug fixes committed since the previous pull
> request that address deadlocks, double resets, memory leaks, and other
> regression.

Thanks Keith, pulled.

-- 
Jens Axboe


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
